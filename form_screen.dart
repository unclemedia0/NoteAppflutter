import 'package:flutter/material.dart';
import 'package:flutter_database/models/Transactions.dart';
import 'package:flutter_database/providers/transaction_provider.dart';
import 'package:flutter_database/screens/home_screen.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class FormScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  // controller 
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("ກະລຸນາກອກລາຍລະອຽດ"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: new InputDecoration(labelText: "ຊື້ລາຍການ"),
                  autofocus: false,
                  controller: titleController,
                  validator: (String str){
                      //ชื่อรายการเป็นค่าว่าง
                      if(str.isEmpty){
                          return "ກະລຸນາປ້ອນຊື່ລາຍການ";
                      }
                      return null;
                  },
                ),
                TextFormField(
                  decoration: new InputDecoration(labelText: "ຈຳນວນເງິນ"),
                  keyboardType:TextInputType.number,
                  controller: amountController,
                  validator: (String str){
                    if(str.isEmpty){
                          return "ກະລຸນາປ້ອນຈຳນວນເງິນ";
                    }
                    if(double.parse(str)<=0){
                          return "ກະລຸນາປ້ອນຕົວເລກໃຫຍ່ກວ່າ 0";
                    }
                    return null;
                  },
                ),
                FlatButton(
                  child: Text("ເພີມຂໍ້ມູນ"),
                  color: Colors.purple,
                  textColor: Colors.white,
                  onPressed: (){
                      if(formKey.currentState.validate()){
                          var title = titleController.text;
                          var amount = amountController.text;
                          //เตรียมข้อมูล
                          Transactions statement = Transactions(
                            title: title,
                            amount: double.parse(amount),
                            date:DateTime.now()
                          );//object

                          //เรียก Provider 
                          var provider = Provider.of<TransactionProvider>(context,listen:false);
                          provider.addTransaction(statement);
                          Navigator.push(context, MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (context){
                              return MyHomePage();
                          }));
                      } 
                  }, 
                  )
              ],
            ),
          ),
        ));
  }
}
