import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _randomWord = <WordPair>[];
  final _saveWordPairs = Set<WordPair>();

  Widget _buildList() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, item) {
          if (item.isOdd) return Divider();

          final index = item ~/ 2;

          if (index >= _randomWord.length) {
            _randomWord.addAll(generateWordPairs().take(10));
          }

          return _buildRow(_randomWord[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saveWordPairs.contains(pair);

    return ListTile(
        title: Text(pair.asPascalCase, style: TextStyle(fontSize: 18.0)),
        trailing: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border,
            color: alreadySaved ? Colors.red : null),
        onTap: () {
          setState(() {
            if (alreadySaved) {
              _saveWordPairs.remove(pair);
            } else {
              _saveWordPairs.add(pair);
            }
          });
        });
  }

  void _pushSaved() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      final Iterable<ListTile> tiles = _saveWordPairs.map((WordPair pair) {
        return ListTile(
          title: Text(pair.asPascalCase, style: TextStyle(fontSize: 16.0)),
        );
      });
      final List<Widget> divided =
          ListTile.divideTiles(context: context, tiles: tiles).toList();

      return Scaffold(
        appBar: AppBar(
          title: Text('Saved Wordpair AppTest')
          ),
          body: ListView(children: divided),
          );
    }));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wordpair AppTest'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved)
        ],
      ),
      body: _buildList(),
    );
  }
}
