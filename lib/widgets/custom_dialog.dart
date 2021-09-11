import 'package:coffee_project2/const/cafe_type.dart';
import 'package:coffee_project2/model/coffee_model.dart';
import 'package:flutter/material.dart';

class CustomDialog {
  Widget setMyCoffeeImage(String url) {
    if (url != '') {
      return Image.network(
        url,
        width: 200.0,
        height: 200.0,
      );
    } else {
      return Container();
    }
  }

  Widget dialogContent(CoffeeModel? myCoffeeModel, String url) {
    if (myCoffeeModel == null) {
      return Container(
        child: Text('マイドリンクの説明'),
      );
    } else {
      return Container(
        child: Column(
          mainAxisSize: MainAxisSize.min, // columnの高さを自動調整
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    myCoffeeModel.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            ),
            myCoffeeModel.cafeType == CafeType.TYPE_SHOP_CAFE
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          myCoffeeModel.shopName,
                          style: const TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
            myCoffeeModel.cafeType == CafeType.TYPE_HOME_CAFE
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: Row(
                      children: [
                        Text(
                          myCoffeeModel.brandName,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
            setMyCoffeeImage(url),
          ],
        ),
      );
    }
  }

  void opneMyCoffee(
    BuildContext context,
    CoffeeModel? myCoffeeModel,
    String imageUrl,
  ) {
    showDialog(
      context: context,
      // barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: Container(child: Text('マイドリンク')),
          content: dialogContent(myCoffeeModel, imageUrl),
          // content: Text("This is the content"),
          actions: [
            TextButton(
              child: const Text('閉じる'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  void openIconDescription(BuildContext context) {
    showDialog(
      context: context,
      // barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: const Text('アイコンの説明'),
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min, // columnの高さを自動調整
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                        width: 3,
                        height: 25,
                        color: Colors.red,
                      ),
                      const Text(
                        'おうち',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                        width: 3,
                        height: 25,
                        color: Colors.blue,
                      ),
                      const Text(
                        'おみせ',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                        child: const Icon(Icons.favorite_outline_outlined),
                      ),
                      const Text(
                        'お気に入り',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // content: Text("This is the content"),
          actions: [
            TextButton(
              child: const Text('閉じる'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  Future<String?> myCoffeeDialog(
    BuildContext context,
    bool isUpdate,
    String name,
    String brandName,
    String shopName,
  ) async {
    var result = showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: const Text('マイドリンクに登録しますか？'),
          content: !isUpdate
              ? const Text('マイドリンクにすることで次回から簡単に登録できます')
              : Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // columnの高さを自動調整
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('登録中のマイドリンク'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              name,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      brandName != ''
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    brandName,
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      shopName != ''
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    shopName,
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
          // content: Text("This is the content"),
          actions: [
            TextButton(
              child: const Text('キャンセル'),
              onPressed: () => Navigator.pop(context, 'NO'),
            ),
            TextButton(
              child: const Text('登録する'),
              onPressed: () => Navigator.pop(context, 'YES'),
            ),
          ],
        );
      },
    );
    return result;
  }

  /**
   * コーヒー削除前確認ダイアログ
   */
  Future<String?> deleteCoffeeDialog(
    BuildContext context,
  ) async {
    var result = showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: const Text('削除しますか？'),
          // content: const Text('マイドリンクにすることで次回から簡単に登録できます'),
          actions: [
            TextButton(
              child: const Text('キャンセル'),
              onPressed: () => Navigator.pop(context, 'NO'),
            ),
            TextButton(
              child: const Text(
                '削除する',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  // fontSize: 20,
                ),
              ),
              onPressed: () => Navigator.pop(context, 'YES'),
            ),
          ],
        );
      },
    );
    return result;
  }

// deleteMyDrinkDialog
  Future<String?> simpleDefaultDialog(
    BuildContext context,
    String _title,
    String _content,
  ) async {
    var result = showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: _title != '' ? Text(_title) : null,
          content: _content != '' ? Text(_content) : null,
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context, 'YES'),
            ),
          ],
        );
      },
    );
    return result;
  }

  // サインアウト確認ダイアログ
  Future<String?> signOutDialog(
    BuildContext context,
  ) async {
    var result = showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: const Text('ログアウトしますか？'),
          content: const Text('連携をしていない場合はデータが失われます。'),
          actions: [
            TextButton(
              child: const Text('キャンセル'),
              onPressed: () => Navigator.pop(context, 'NO'),
            ),
            TextButton(
              child: const Text(
                'ログアウトする',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () => Navigator.pop(context, 'YES'),
            ),
          ],
        );
      },
    );
    return result;
  }
}
