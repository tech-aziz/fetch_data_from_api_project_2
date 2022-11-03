import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/data_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ModelData> allData = [];

  String link =
      "https://raw.githubusercontent.com/codeifitech/fitness-app/master/exercises.json";
  fetchData() async {
    var response = await http.get(Uri.parse(link));
    print("Status code is ${response.statusCode}");
    // print("${response.body}");
    if (response.statusCode == 200) {
      final item = jsonDecode(response.body);
      for (var data in item["exercises"]) {
        ModelData dataModel = ModelData(
            id: data['id'],
            title: data['title'],
            thumbnail: data['thumbnail'],
            gif: data['gif'],
            seconds: data['seconds']);
        setState(() {
          allData.add(dataModel);
        });
      }
      print("Total length is ${allData.length}");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data from api 2'),
          centerTitle: true,
        ),
        body: Container(
          width: double.infinity,
          child: ListView.builder(
            itemCount: allData.length,
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Card(
                  elevation: 12,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(allData[index].thumbnail.toString()),
                    ),
                    title: Text(allData[index].title.toString()),
                    subtitle: Text(allData[index].id.toString()),
                    trailing: CircleAvatar(
                      backgroundImage:
                          NetworkImage(allData[index].gif.toString()),
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }
}
