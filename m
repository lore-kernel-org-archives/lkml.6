Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55459ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 07:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2F16214C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 07:42:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2F16214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sma.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbeIQNI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 09:08:56 -0400
Received: from msgsrv3.atosorigin.de ([194.8.120.225]:41895 "EHLO
        msgsrv3.atosorigin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727547AbeIQNI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 09:08:56 -0400
Received: from unknown (HELO julia-mo2.ccsn.de.ao-srv.com) ([194.8.124.179])
  by msgsrv-out1.atosorigin.de with ESMTP; 17 Sep 2018 09:42:38 +0200
Received: from julia-mo2.ccsn.de.ao-srv.com (unknown [194.8.124.179]) by MCS02-MA1.atosorigin.de with smtp
         id 292e_c83b_f32ca5ce_e814_4830_8587_69bc189fb703;
        Mon, 17 Sep 2018 09:42:37 +0200
Received: from julia-mo2 (localhost [127.0.0.1])
        by julia-mo2.ccsn.de.ao-srv.com (Postfix) with ESMTP id 680FDA9BFB4;
        Mon, 17 Sep 2018 09:42:38 +0200 (CEST)
Received: from MCS01-MA1.atosorigin.de (mcs01-ma1.deuser.de.intra [194.8.120.185])
        by julia-mo2.ccsn.de.ao-srv.com (Postfix) with ESMTP id 52C7EA9BFB3;
        Mon, 17 Sep 2018 09:42:38 +0200 (CEST)
Received: from SVR-DE-EXMBX-01.sma.de (unknown [10.99.42.82]) by MCS01-MA1.atosorigin.de with smtp
         id 150d_3616_1c3c636b_0efc_45a0_a318_1cd774cb083f;
        Mon, 17 Sep 2018 09:42:25 +0200
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (10.0.42.37) by
 webmail.sma.de (10.0.42.161) with Microsoft SMTP Server (TLS) id 14.3.389.1;
 Mon, 17 Sep 2018 09:42:12 +0200
Received: from DB7PR04MB5243.eurprd04.prod.outlook.com (20.176.236.87) by
 DB7PR04MB4668.eurprd04.prod.outlook.com (52.135.139.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.17; Mon, 17 Sep 2018 07:42:10 +0000
Received: from DB7PR04MB5243.eurprd04.prod.outlook.com
 ([fe80::f198:36b7:1793:542b]) by DB7PR04MB5243.eurprd04.prod.outlook.com
 ([fe80::f198:36b7:1793:542b%3]) with mapi id 15.20.1143.017; Mon, 17 Sep 2018
 07:42:10 +0000
From:   Andre Kalb <Andre.Kalb@sma.de>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Frank Rowand <frowand.list@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] of: __of_update_property_sysfs only call
 __of_sysfs_remove_bin_file if of_node_is_attached
Thread-Topic: [PATCH v2] of: __of_update_property_sysfs only call
 __of_sysfs_remove_bin_file if of_node_is_attached
Thread-Index: AdROWYyofBc07fvnTZafE/8ZhRTb4g==
Date:   Mon, 17 Sep 2018 07:42:10 +0000
Message-ID: <DB7PR04MB5243DC26F130FDFADF113CB2FC1E0@DB7PR04MB5243.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andre.Kalb@sma.de; 
x-originating-ip: [62.157.91.9]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4668;6:fxdk2pFsGZxaCIth9D7/VLpnFhdMysWjzcI5tbDiHz7xMRgB88aOecUojpKIu+qIU2tWM9mw4x8QY7DgKyZz0ur3ec3ughovJSuUGMRsPA57kg7V8jg3JRGGvtYu+gJ/v9ofrz2YV5IJcu+NoQ0k5ui+UKekCdl4vEwjDqpzZp9yqVSPzsp0nmCqx5+dVGE7QVxSjZdjkPtuBHJ2t42QKieEVGMNflINolltPDLppGE3Z2eHcx6N0zRvsVYSdgVZSCu/6v+X+30gtNaPqcHHEsU7r3OpoaFsaalCjGEik+4cJRjt1UydWcjDUeyqrNXk/n5GiikjMi+hIM+H0vyMeLB7uEWUOqwwHGxTmVwhX6zPtewqnkYV+SYDHRWTN+qVg9cQ0RFPBIyp+L4LaDd4eiTlYjYLYx4Kv9XLIpBZxafmo1vQg1qs8X7tonUBOOtUZeudnnYjCE/oVQneIV0j9w==;5:xpfZNrAf8uUa18cb1IpzHV5f5YkTr/CdUcNW6ax6EqG57gH7FAxcG3hc8aD9gBBZOr2zdzdDpd/zDXBf762NY4mUBDHttI1SL0CawXRoOLosz/BqEp6HxQ+nyZ6bAcxT7bVZkyL1t4TzjQ3AC9qUmI5u43FzsS4H0GHNPXyOEcw=;7:AjoXg7wh9Xgw4+91x4llIEkVAkQfcu8sRfuBIDhDviy7aC4Q4Mn7i2XoGFZZAp7qmj8hti0gc05yaLjsIdAwhL1EzCLcmrksO2cCBpuMRneNHhBVfj5viL26BvALokya3h6eo/Hwt05fMm4rOL/9ZxfG9bnhqqmAh/sGfm90PTXh4O8GNYiSbjXP4Bbi97N9AF1nT8NwMbQ89cDfP+UP4bBhA9zoJLsUx12RddnkSal9wOjXvqgBxprm47uKArbt
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c9eb3122-d6d9-4a5b-62a6-08d61c711374
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4668;
x-ms-traffictypediagnostic: DB7PR04MB4668:
x-microsoft-antispam-prvs: <DB7PR04MB466892CD943382162D7F5328FC1E0@DB7PR04MB4668.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699050);SRVR:DB7PR04MB4668;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4668;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(136003)(346002)(39850400004)(376002)(199004)(189003)(575784001)(53936002)(476003)(8936002)(2900100001)(53546011)(55016002)(6506007)(9686003)(3846002)(26005)(97736004)(2906002)(39060400002)(86362001)(6116002)(5250100002)(486006)(316002)(8676002)(25786009)(81156014)(81166006)(4326008)(54906003)(68736007)(74316002)(186003)(33656002)(66066001)(5024004)(102836004)(7696005)(7736002)(305945005)(5660300001)(45080400002)(14454004)(478600001)(72206003)(75402003)(74482002)(256004)(14444005)(106356001)(6436002)(99286004)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR04MB4668;H:DB7PR04MB5243.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: sma.de does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: VNfUjM5LAuXeOfxJ9ZAPcSrOcLaWxt4iNJqGhI/5uz8rV8885Lw3FPvSx0sfmNSlcg03BQHrQS4ZeMc7YyFTZ7nm3kGgBAhP2sEd4X37YmHFXsubPi9fHd5JlsUJODTv5w1ft6S9g6M3H39uqsighO0yxsDDJGswswz9KjdUUZBre2D7HR73ODCN87XqVrQHbh+/Pc5a3bgVlCi59O8xMSaFhEmvS4vdtfxIlcbSkAXA099cj6LiONZBENxL9QLY54HSAZVE/7kkhh3A7ICY+GdZQcsCmZKbvPsRWbamjr4001ErGSeISx197NcrwlBdzMY9BaxgANWhAuHKcUZKPDBC4UvnXiqjWySKlru2ogE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c9eb3122-d6d9-4a5b-62a6-08d61c711374
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 07:42:10.1569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a059b96c-2829-4d11-8837-4cc1ff84735d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4668
X-OriginatorOrg: sma.de
X-NAI-Spam-Flag: NO
X-NAI-Spam-Level: *
X-NAI-Spam-Threshold: 8
X-NAI-Spam-Score: 1.4
X-NAI-Spam-Version: 2.3.0.9418 : core <6374> : inlines <6879> : streams
 <1798691> : uri <2712136>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iLA0KDQpJIGhhdmUgdXNlZCBhbiBvdGhlciBoYXJkd2FyZSB0byBjaGVjayB0aGUgcGF0
Y2guIEkgaG9wZSBpdCBkb2VzbuKAmXQgbWF0dGVyLiBJIGFkZGVkIGZldyBsaW5lcyBhdCB0aGUg
dW50aXRlc3QuYy4gQWxsIGV4aXN0aW5nIHVuaXR0ZXN0IHVzZSBhbiBhdHRhY2hlZCBzeXNmcywg
dGhlcmVmb3JlIHRoZSBidWcgaXNuJ3QgZGV0ZWN0YWJsZS4NCg0KQmVzdCByZWdhcmRzDQpBbmRy
ZSBLYWxiDQoNCg0KPiBPbiBUaHUsIFNlcCAxMywgMjAxOCBhdCA0OjQyIFBNIEFuZHJlIEthbGIg
PEFuZHJlLkthbGJAc21hLmRlPiB3cm90ZToNCj4gRnJvbSAxZTg2ZTM1MWVmYTFhN2NlYTMxZDE1
N2JhZmIwYWU0MGI4NTZjZGNjIE1vbiBTZXAgMTcgMDA6MDA6MDANCj4gMjAwMQ0KPiBGcm9tOiBB
bmRyZSBLYWxiIDxBbmRyZS5LYWxiQHNtYS5kZT4NCj4gRGF0ZTogVGh1LCAxMyBTZXAgMjAxOCAx
Njo0Mjo0OCArMDIwMA0KPiBTdWJqZWN0OiBbUEFUQ0hdIEFkZGVkIG5ldyB1bml0dGVzdA0KPg0K
PiAtLS0NCj4gIGRyaXZlcnMvb2YvdW5pdHRlc3QuYyB8IDE4ICsrKysrKysrKysrKysrKysrKw0K
PiAgMSBmaWxlIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKykNCj4NCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvb2YvdW5pdHRlc3QuYyBiL2RyaXZlcnMvb2YvdW5pdHRlc3QuYyBpbmRleA0KPiAyYTU0
N2NhM2Q0NDMuLjE3ZjZjYWNiNGZhZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9vZi91bml0dGVz
dC5jDQo+ICsrKyBiL2RyaXZlcnMvb2YvdW5pdHRlc3QuYw0KPiBAQCAtOTIzLDYgKzkyMywyNCBA
QCBzdGF0aWMgaW50IF9faW5pdCB1bml0dGVzdF9kYXRhX2FkZCh2b2lkKQ0KPiAgICAgICAgICAg
ICAgIHJldHVybiAtRUlOVkFMOw0KPiAgICAgICB9DQo+DQo+ICsgICAgIHsNCj4gKyAgICAgICAg
ICAgICBzdHJ1Y3QgcHJvcGVydHkgKnByb3A7DQo+ICsNCj4gKyAgICAgICAgICAgICBwcm9wID0g
a3phbGxvYyhzaXplb2YoKnByb3ApLCBHRlBfS0VSTkVMKTsNCj4gKyAgICAgICAgICAgICBpZiAo
IXByb3ApIHsNCj4gKyAgICAgICAgICAgICAgICAgICAgIHVuaXR0ZXN0KDAsICJremFsbG9jKCkg
ZmFpbGVkXG4iKTsNCj4gKyAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRU5PTUVNOw0KPiAr
ICAgICAgICAgICAgIH0NCj4gKw0KPiArICAgICAgICAgICAgIG5wID0gb2ZfZmluZF9ub2RlX3dp
dGhfcHJvcGVydHkodW5pdHRlc3RfZGF0YV9ub2RlLCAicHJvcC0NCj4gdXBkYXRlIik7DQo+ICsg
ICAgICAgICAgICAgdW5pdHRlc3QobnAsICJmaW5kIHByb3AtdXBkYXRlIik7DQo+ICsNCj4gKyAg
ICAgICAgICAgICBwcm9wLT5uYW1lID0gInByb3AtdXBkYXRlIjsNCj4gKyAgICAgICAgICAgICBw
cm9wLT52YWx1ZSA9ICJuZXctcHJvcGVydHktZGF0YSI7DQo+ICsgICAgICAgICAgICAgcHJvcC0+
bGVuZ3RoID0gc3RybGVuKHByb3AtPnZhbHVlKSArIDE7DQo+ICsgICAgICAgICAgICAgdW5pdHRl
c3Qob2ZfdXBkYXRlX3Byb3BlcnR5KG5wLCBwcm9wKSA9PSAwLCAiVXBkYXRlIGEgZXhpc3RpbmcN
Cj4gcHJvcGVydHkgZmFpbGVkXG4iKTsNCj4gKyAgICAgfQ0KPiArDQo+ICAgICAgIGlmICghb2Zf
cm9vdCkgew0KPiAgICAgICAgICAgICAgIG9mX3Jvb3QgPSB1bml0dGVzdF9kYXRhX25vZGU7DQo+
ICAgICAgICAgICAgICAgZm9yX2VhY2hfb2ZfYWxsbm9kZXMobnApDQo+IC0tDQo+IDIuMTYuNA0K
DQotLS0tLS0tLS0tLS1bIGN1dCBoZXJlIF0tLS0tLS0tLS0tLS0NCldBUk5JTkc6IENQVTogMCBQ
SUQ6IDEgYXQgZnMva2VybmZzL2Rpci5jOjE0ODEga2VybmZzX3JlbW92ZV9ieV9uYW1lX25zKzB4
OWMvMHhhNA0Ka2VybmZzOiBjYW4gbm90IHJlbW92ZSAnKG51bGwpJywgbm8gZGlyZWN0b3J5DQpN
b2R1bGVzIGxpbmtlZCBpbjoNCkNQVTogMCBQSUQ6IDEgQ29tbTogc3dhcHBlciBOb3QgdGFpbnRl
ZCA0LjE4LjcgIzMNCkhhcmR3YXJlIG5hbWU6IEZyZWVzY2FsZSBpLk1YNiBVbHRyYWxpdGUgKERl
dmljZSBUcmVlKQ0KWzxjMDEwZjMzOD5dICh1bndpbmRfYmFja3RyYWNlKSBmcm9tIFs8YzAxMGNl
ZmM+XSAoc2hvd19zdGFjaysweDEwLzB4MTQpDQpbPGMwMTBjZWZjPl0gKHNob3dfc3RhY2spIGZy
b20gWzxjMDEyMjAwND5dIChfX3dhcm4rMHhlMC8weGY4KQ0KWzxjMDEyMjAwND5dIChfX3dhcm4p
IGZyb20gWzxjMDEyMjA2MD5dICh3YXJuX3Nsb3dwYXRoX2ZtdCsweDQ0LzB4NjgpDQpbPGMwMTIy
MDYwPl0gKHdhcm5fc2xvd3BhdGhfZm10KSBmcm9tIFs8YzAyYzY1NDA+XSAoa2VybmZzX3JlbW92
ZV9ieV9uYW1lX25zKzB4OWMvMHhhNCkNCls8YzAyYzY1NDA+XSAoa2VybmZzX3JlbW92ZV9ieV9u
YW1lX25zKSBmcm9tIFs8YzA1NWE3MDQ+XSAoX19vZl91cGRhdGVfcHJvcGVydHlfc3lzZnMrMHgz
OC8weDUwKQ0KWzxjMDU1YTcwND5dIChfX29mX3VwZGF0ZV9wcm9wZXJ0eV9zeXNmcykgZnJvbSBb
PGMwNTU3Yjk0Pl0gKG9mX3VwZGF0ZV9wcm9wZXJ0eSsweGMwLzB4MTA0KQ0KWzxjMDU1N2I5ND5d
IChvZl91cGRhdGVfcHJvcGVydHkpIGZyb20gWzxjMDk1MjFiYz5dIChvZl91bml0dGVzdCsweDFi
OC8weDI4ZDQpDQpbPGMwOTUyMWJjPl0gKG9mX3VuaXR0ZXN0KSBmcm9tIFs8YzAxMDJkODg+XSAo
ZG9fb25lX2luaXRjYWxsKzB4NDAvMHgyMTgpDQpbPGMwMTAyZDg4Pl0gKGRvX29uZV9pbml0Y2Fs
bCkgZnJvbSBbPGMwOTAxMDFjPl0gKGtlcm5lbF9pbml0X2ZyZWVhYmxlKzB4MjRjLzB4MmU0KQ0K
WzxjMDkwMTAxYz5dIChrZXJuZWxfaW5pdF9mcmVlYWJsZSkgZnJvbSBbPGMwNmExZjZjPl0gKGtl
cm5lbF9pbml0KzB4OC8weDExMCkNCls8YzA2YTFmNmM+XSAoa2VybmVsX2luaXQpIGZyb20gWzxj
MDEwMTBlOD5dIChyZXRfZnJvbV9mb3JrKzB4MTQvMHgyYykNCkV4Y2VwdGlvbiBzdGFjaygweGNj
MDk5ZmIwIHRvIDB4Y2MwOTlmZjgpDQo5ZmEwOiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMA0KOWZjMDogMDAwMDAw
MDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAg
MDAwMDAwMDANCjlmZTA6IDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAw
MDEzIDAwMDAwMDAwDQotLS1bIGVuZCB0cmFjZSA0NTIyZjY5ZTA3NjBlNGQ1IF0tLS0NCg0KDQoN
Cj4gLS0tLS1VcnNwcsO8bmdsaWNoZSBOYWNocmljaHQtLS0tLQ0KPiBWb246IFJvYiBIZXJyaW5n
IFttYWlsdG86cm9iaCtkdEBrZXJuZWwub3JnXQ0KPiBHZXNlbmRldDogTW9udGFnLCAxMC4gU2Vw
dGVtYmVyIDIwMTggMTU6NDcNCj4gQW46IEFuZHJlIEthbGINCj4gQ2M6IEZyYW5rIFJvd2FuZDsg
ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcN
Cj4gQmV0cmVmZjogUmU6IFtQQVRDSCB2Ml0gb2Y6IF9fb2ZfdXBkYXRlX3Byb3BlcnR5X3N5c2Zz
IG9ubHkgY2FsbA0KPiBfX29mX3N5c2ZzX3JlbW92ZV9iaW5fZmlsZSBpZiBvZl9ub2RlX2lzX2F0
dGFjaGVkDQo+DQo+IE9uIE1vbiwgU2VwIDEwLCAyMDE4IGF0IDQ6NTEgQU0gQW5kcmUgS2FsYiA8
QW5kcmUuS2FsYkBzbWEuZGU+IHdyb3RlOg0KPiA+DQo+ID4gSGkgRnJhbmssDQo+ID4NCj4gPiA+
IC0tLS0tVXJzcHLDvG5nbGljaGUgTmFjaHJpY2h0LS0tLS0NCj4gPiA+IFZvbjogRnJhbmsgUm93
YW5kIFttYWlsdG86ZnJvd2FuZC5saXN0QGdtYWlsLmNvbV0NCj4gPiA+IEdlc2VuZGV0OiBGcmVp
dGFnLCA3LiBTZXB0ZW1iZXIgMjAxOCAyMjowMQ0KPiA+ID4gQW46IEFuZHJlIEthbGI7IHJvYmgr
ZHRAa2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gPiBsaW51eC0g
a2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiA+ID4gQmV0cmVmZjogUmU6IFtQQVRDSCB2Ml0gb2Y6
IF9fb2ZfdXBkYXRlX3Byb3BlcnR5X3N5c2ZzIG9ubHkgY2FsbA0KPiA+ID4gX19vZl9zeXNmc19y
ZW1vdmVfYmluX2ZpbGUgaWYgb2Zfbm9kZV9pc19hdHRhY2hlZA0KPiA+ID4NCj4gPiA+IEhpIEFu
ZHJlZCwNCj4gPiA+DQo+ID4gPiBPbiAwOS8wNC8xOCAwODo1MSwgQW5kcmUgS2FsYiB3cm90ZToN
Cj4gPiA+ID4gVG8gcHJldmVudCB3YXJuaW5nICJrZXJuZnM6IGNhbiBub3QgcmVtb3ZlICcobnVs
bCknLCBubyBkaXJlY3RvcnkiDQo+ID4gPiA+IGlmIGFuIG92ZXJsYXkNCj4gPiA+IGlzbid0IGFw
cGxpZWQgdG8gdGhlIGFjdGl2ZSBkZXZpY2V0cmVlLg0KPiA+ID4gPg0KPiA+ID4gPiBVc2luZyBv
Zl9yZW1vdmVfcHJvcGVydHkgYW5kIHRoZW4gb2ZfYWRkX3Byb3BlcnR5IGRvZXNuJ3Qgc2hvdyB0
aGUNCj4gPiA+IHdhcm5pbmcuDQo+DQo+IFsuLi5dDQo+DQo+ID4gPiBXaGF0IGlzIHRoZSBjYWxs
aW5nIHBhdGggdGhhdCByZXN1bHRzIGluIHRoZSB3YXJuaW5nPw0KPiA+ID4NCj4gPiA+IC1GcmFu
aw0KPiA+DQo+ID4gVGhlcmUgaXMgdGhlIGNhbGxzdGFjayBvZiB0aGUgd2FybmluZy4NCj4gPg0K
PiA+IFsgICAxMC43ODI4MzBdIC0tLS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLQ0K
PiA+IFsgICAxMC44MzAzNTddIFdBUk5JTkc6IENQVTogMCBQSUQ6IDE3MCBhdCAvbGludXgtNC54
L2ZzL2tlcm5mcy9kaXIuYzoxMjc2DQo+IGtlcm5mc19yZW1vdmVfYnlfbmFtZV9ucysweDMwLzB4
ODAoKQ0KPiA+IFsgICAxMC45Mjg5OTddIGtlcm5mczogY2FuIG5vdCByZW1vdmUgJyhudWxsKScs
IG5vIGRpcmVjdG9yeQ0KPiA+IFsgICAxMC45OTMxMDddIE1vZHVsZXMgbGlua2VkIGluOiBtb2R1
bGVfY2FwZW1ncigrKQ0KPiA+IFsgICAxMS4wNDU3NTBdIENQVTogMCBQSUQ6IDE3MCBDb21tOiBz
eXN0ZW1kLXVkZXZkIE5vdCB0YWludGVkIDQuNC4xNDMtDQo+IDAwMTU4LWc4ZTVjYTY1ZWM3ZWUt
ZGlydHkgIzExNA0KPg0KPiAxNTggcGF0Y2hlcyBvbiB0b3Agb2YgYW4gYWxtb3N0IDMgeWVhciBv
bGQga2VybmVsLi4uDQo+DQo+ID4gWyAgIDEyLjAxMTM3M10gWzxiZjAwMDBlND5dIChtb2R1bGVf
Y2FwZW1ncl9zbG90X3NjYW4gW21vZHVsZV9jYXBlbWdyXSkNCj4gZnJvbSBbPGJmMDAwN2JjPl0g
KG1vZHVsZV9jYXBlbWdyX3Byb2JlKzB4M2MvMHg1OCBbbW9kdWxlX2NhcGVtZ3JdKQ0KPg0KPiBB
bmQgYSBkcml2ZXIgdGhhdCdzIG5vdCB1cHN0cmVhbS4NCj4NCj4gTm90IHNheWluZyB0aGUgZml4
IGlzbid0IHZhbGlkLCBidXQgcGxlYXNlIHJlcHJvZHVjZSBvbiByZWNlbnQgbWFpbmxpbmUuIEFk
ZCBhDQo+IHVuaXR0ZXN0IGlmIHlvdSBoYXZlIHRvLg0KPg0KPiBSb2INCg0KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQoNClNNQSBTb2xhciBUZWNo
bm9sb2d5IEFHDQpBdWZzaWNodHNyYXQ6IERyLiBFcmlrIEVocmVudHJhdXQgKFZvcnNpdHplbmRl
cikNClZvcnN0YW5kOiBVbHJpY2ggSGFkZGluZywgRHIuLUluZy4gSnVlcmdlbiBSZWluZXJ0LCBQ
aWVycmUtUGFzY2FsIFVyYm9uDQpIYW5kZWxzcmVnaXN0ZXI6IEFtdHNnZXJpY2h0IEthc3NlbCBI
UkIgMzk3Mg0KU2l0eiBkZXIgR2VzZWxsc2NoYWZ0OiAzNDI2NiBOaWVzdGV0YWwNClVTdC1JRC1O
ci4gREUgMTEzIDA4IDU5IDU0DQpXRUVFLVJlZy4tTnIuIERFIDk1ODgxMTUwDQpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCg==
