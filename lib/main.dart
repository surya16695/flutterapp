import 'package:flutter/material.dart';
import 'dart:async';
import 'package:weather/weather.dart';
import 'package:http/http.dart';

import 'package:flutterweather/modles/WeatherData.dart';
import 'package:flutterweather/modles/ForecastData.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _res = 'Unknown';
  List<Weather> f;
  Weather w;
  String key = '751d7305f6f1ef6338c0998a6fbd2ccb';
  WeatherStation ws;

  @override
  void initState() {
    super.initState();
    ws = new WeatherStation(key);
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    queryWeather();

  }

  void queryForecast() async {
    f = await ws.fiveDayForecast();
    setState(() {
    });
  }

  void queryWeather() async {
    w = await ws.currentWeather();
    print(w.areaName);
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Weather App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
          backgroundColor: Colors.blueGrey,
          appBar: AppBar(
            title: Text('Flutter Weather App'),
          ),

          body: Center(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                Text('Ammma', style: new TextStyle(color: Colors.white)),
                                Text('Rain', style: new TextStyle(color: Colors.white, fontSize: 32.0)),
                                Text('72°F',  style: new TextStyle(color: Colors.white)),
                                Image.network('https://openweathermap.org/img/w/01d.png'),
                                Text('Jun 28, 2018', style: new TextStyle(color: Colors.white)),
                                Text('18:30', style: new TextStyle(color: Colors.white)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                              icon: new Icon(Icons.refresh),
                              tooltip: 'Refresh',
                              onPressed: queryWeather,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 200.0,
                          child: ListView.builder(
                              itemCount: f.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text('New York', style: new TextStyle(color: Colors.black)),
                                      Text('Rain', style: new TextStyle(color: Colors.black, fontSize: 24.0)),
                                      Text('72°F',  style: new TextStyle(color: Colors.black)),
                                      Image.network('https://openweathermap.org/img/w/01d.png'),
                                      Text('Jun 28, 2018', style: new TextStyle(color: Colors.black)),
                                      Text('18:30', style: new TextStyle(color: Colors.black)),
                                    ],
                                  ),
                                ),
                              )
                          ),
                        ),
                      ),
                    )
                  ]
              )
          ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: FloatingActionButton(
            onPressed: queryWeather,
            child: Icon(Icons.cloud_download)),
      ),
    );
  }
}
