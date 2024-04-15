import 'dart:math';

import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class NamedNode {
  final int id;
  String name;

  NamedNode(this.id, this.name);
}

// Global map of node names mapping nodes to their names
Map<Node, NamedNode> nodeMap = {};

class _MyHomePageState extends State<MyHomePage> {

  var nodeName = "";

  @override
  Widget build(BuildContext context) {

    final node1 = Node.Id(1);
    final node2 = Node.Id(2);
    final node3 = Node.Id(3);


    graph.addEdge(node1, node2);
    graph.addEdge(node2, node1);
    graph.addEdge(node3, node1);

    nodeMap.addAll({node1: NamedNode(node1.key?.value as int, "Angie"), node2: NamedNode(node2.key?.value as int, "Vish"), node3: NamedNode(node3.key?.value as int, "Yao")});


    builder
      ..siblingSeparation = (100)
      ..levelSeparation = (150)
      ..subtreeSeparation = (150)
      ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              margin: const EdgeInsets.all(10.0),
              // padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
              child: const Text(
                "Hi Vishnu,"
              ),
            ),
          //   Create a container for the graph
            SizedBox(
              width: 390,
              height: 720,
              //   This container will hold the graph and interactive viewer
              child: Column(
                children: [
                  Wrap(
                    children: [
                      Container(
                        // Container of max width
                        width: 100,
                        // Create a text form to be filled
                        child: TextFormField(
                          initialValue: builder.siblingSeparation.toString(),
                          decoration: const InputDecoration(labelText: "Sibling Separation"),
                          onChanged: (text) {
                            builder.siblingSeparation = int.tryParse(text) ?? 100;
                            this.setState(() {});
                          },
                        ),
                      ),
                      Container(
                        width: 100,
                        child: TextFormField(
                          initialValue: builder.levelSeparation.toString(),
                          decoration: const InputDecoration(labelText: "Level Separation"),
                          onChanged: (text) {
                            builder.levelSeparation = int.tryParse(text) ?? 100;
                            this.setState(() {});
                          },
                        ),
                      ),
                      Container(
                        width: 100,
                        child: TextFormField(
                          initialValue: builder.subtreeSeparation.toString(),
                          decoration: const InputDecoration(labelText: "SubTree Separation"),
                          onChanged: (text) {
                            builder.subtreeSeparation = int.tryParse(text) ?? 100;
                            this.setState(() {});
                          },
                        ),
                      ),
                      Container(
                        width: 100,
                        child: TextFormField(
                          initialValue: builder.orientation.toString(),
                          decoration: const InputDecoration(labelText: "Orientation"),
                          onChanged: (text) {
                            builder.orientation = int.tryParse(text) ?? 100;
                            this.setState(() {});
                          },
                        ),
                      ),
                      Container(
                        width: 100,
                        child: TextFormField(
                          initialValue: "Word",
                          decoration: const InputDecoration(labelText: "Node Display Name"),
                          onChanged: (text) {
                            nodeName = text ?? "";
                            this.setState(() {});
                          },
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          final nodeId = r.nextInt(100); // Generate a unique ID for the node
                          final node = Node.Id(nodeId);
                          final namedNode = NamedNode(nodeId, nodeName);
                          nodeMap[node] = namedNode; // Store the node with its name
                          var edge = nodeMap.keys.elementAt(r.nextInt(nodeMap.length)); // Get a random node to connect to
                          graph.addEdge(edge, node);
                          setState(() {});
                        },
                        child: const Text("Add"),
                      ),
                    ],
                  ),
                  Expanded(
                    child: InteractiveViewer(
                      constrained: false,
                      boundaryMargin: EdgeInsets.all(100),
                      minScale: 0.01,
                      maxScale: 5.6,
                      child: GraphView(
                        graph: graph,
                        algorithm: FruchtermanReingoldAlgorithm(),
                        paint: Paint()
                          ..color = Colors.green
                          ..strokeWidth = 1
                          ..style = PaintingStyle.stroke,
                        builder: (Node node) {
                          // Retrieve the named node information safely
                          final namedNode = nodeMap[node];
                          if (namedNode != null) {
                            return rectangleWidget(namedNode);  // Only call the widget function if namedNode is not null
                          } else {
                            // Handle the case where no namedNode is found, possibly by returning a default widget
                            return Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.redAccent,  // Indicate an error or missing node visually
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text("Missing Node"),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              )
            ),
          ],
        ),
      ),
    );
  }

  Random r = Random();

  Widget rectangleWidget(NamedNode namedNode) {
    return InkWell(
      onTap: () {
        print("Clicked on Node ${namedNode.id}");
      },
      child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            boxShadow: const [
              BoxShadow(color: Colors.blue, spreadRadius: 1),
            ],
          ),
          child: Text("${namedNode.name}")), // Display the name and ID
    );
  }

  final Graph graph = Graph()..isTree = true;
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();

}