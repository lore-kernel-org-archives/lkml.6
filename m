Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F35C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDD792075B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="YH22oDpY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDD792075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbeJLQcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 12:32:17 -0400
Received: from mail-eopbgr50092.outbound.protection.outlook.com ([40.107.5.92]:2544
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727955AbeJLQcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 12:32:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/as3KM6mstbGYitz3eTvsQuOcHAzkA6ijTmCdYl4JtQ=;
 b=YH22oDpY6mrtZNlPymVQojZmyxVtC5gPYk+xhOXeC5+WsbGUlN6/sk8iPkG2fEdyzwVb2twXGropfkhLr3VnYucuBCO/5gny02jfourWgU65oc0uJd0/22JPz3yCz5GSeosctf3i9EgDCqN02+4ewrQBbIG1Sdviqb0hm/zEsaI=
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com (10.168.137.14) by
 VI1PR0501MB1967.eurprd05.prod.outlook.com (10.166.45.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.23; Fri, 12 Oct 2018 09:00:41 +0000
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::99b0:2276:18cf:18aa]) by VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::99b0:2276:18cf:18aa%3]) with mapi id 15.20.1207.029; Fri, 12 Oct 2018
 09:00:41 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "timur@kernel.org" <timur@kernel.org>,
        "swboyd@chromium.org" <swboyd@chromium.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "jhugo@codeaurora.org" <jhugo@codeaurora.org>,
        "ricardo.ribalda@gmail.com" <ricardo.ribalda@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: REGRESSION: [PATCH v5 3/3] gpiolib: Show correct direction from the
 beginning
Thread-Topic: REGRESSION: [PATCH v5 3/3] gpiolib: Show correct direction from
 the beginning
Thread-Index: AQHUYgoNoMD92TQrMUShrDSw1Tr4Yw==
Date:   Fri, 12 Oct 2018 09:00:41 +0000
Message-ID: <1539334839.30485.9.camel@toradex.com>
References: <20181005065300.22882-1-ricardo.ribalda@gmail.com>
         <20181005065300.22882-3-ricardo.ribalda@gmail.com>
In-Reply-To: <20181005065300.22882-3-ricardo.ribalda@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [188.155.129.42]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0501MB1967;6:5KAK5dALy0y3B88g01sieDxnKjIso+x3i/xEXqGpAv+Hq/aqxqp427R8T6WLe0Kp2rHhYUo6QsfjCpc9ZAsKEW+n5O9JiHxVy83Usc1c1H93L3l8hydhIhA8tnKbtYGcjGrplttEqwC9THDb8zyGKok9Rnj33rQidH6A+6wTjonH/MkuvGoH9sSR/i6nwmqqCO6eUWHpT5s4c/XveIchHIN3wMe+bHuo8Vf2WQPvzlwPtUHI4/OQpdcj/4hHlDLXzaRtthlKAKkeKwgTZf2in1KzAZBEGhMCkLbTZFHoMMqJaAzghyB+35S+vWUyLgYBHy0o11u0T96zvXlPvmvuE0phlx3Ee3iN2E06tcgmSWQCiwbr6aNOD4pXfBEVNjN0XxDXqa2Jn+1nqGrQYx23xK/bxPZRiPg9uXqn3NA9uBBH6lRYs5vaKvd3EhM2+RjBggSApCH0YMGwGMSo8alTnA==;5:iXXRrQninhc2W0lC0Wa8fx6nq1n40DBZHMZSDXS+0YGa0LScfw+77pa5IRCLk5iKGe3XsayJMIma7juBRwMueLp+bbApOjSBK/Sbv9k+MwQU7sMbuCLovhOLCL78AlW2BJZUNqh43ZKe3HEQRBfajNWH5+KereBYhQFx6bahuXI=;7:3lxaoXDAxmHkUGdrZzQjpFclq9EStOtUYAwj8AEqGlVnEuxhpsTwOV+a0La4D578w1xGDY7uJbqWgeGO+KcnBG9T2/sS6SZORbkWIxqkpXFOMi9XpbmtcpD2aTpK2xHqVdOlpabeTCNvDkwaKMdpDcmdTjFel21M6aVdHpq5ZJSgCv9qNSvol0kY5nsekkm0YNgTIyz/vKNhOeHanq4hznF0CNDhQqnQofmJTK79huiRm7f9WvH4K7+XqJC0XHwT
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f1013cf7-6a10-4fa4-a734-08d630212fdf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB1967;
x-ms-traffictypediagnostic: VI1PR0501MB1967:
x-microsoft-antispam-prvs: <VI1PR0501MB1967473072400463F48F2F22FBE20@VI1PR0501MB1967.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991067);SRVR:VI1PR0501MB1967;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB1967;
x-forefront-prvs: 0823A5777B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(396003)(346002)(136003)(376002)(366004)(199004)(189003)(7736002)(186003)(68736007)(14444005)(11346002)(316002)(575784001)(305945005)(2201001)(86362001)(5024004)(446003)(6486002)(53936002)(256004)(6436002)(102836004)(26005)(103116003)(25786009)(5660300001)(6512007)(5250100002)(97736004)(14454004)(76176011)(2501003)(71200400001)(71190400001)(99286004)(105586002)(8676002)(45080400002)(81156014)(8936002)(81166006)(44832011)(476003)(2616005)(486006)(66066001)(478600001)(106356001)(2900100001)(6506007)(36756003)(39060400002)(2906002)(110136005)(3846002)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0501MB1967;H:VI1PR0501MB2590.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: azJ8xyUyZgdQsLz5GJbkuLmBEBb+rCRJPui2py2Yy9QIPen3TAOxDYfXtizISnLOztd4k05bFNrkHrN0yM5AUkrn7owdc0jqQ+4Cv1cduy3wcSr7o8sM0mIQ+xs0F7Tf53cNlUzru6XB+V0jqi0OwbQWbpk+jRiSgnqFcXGfGyAn9TwuNxrKDyk4CiVIXDfNl7M2b3QBX7BfJ4CIJQtDAM3si1yOae0A3QHd+Eq47Aahcb4zxW5VkGbOuaSaSIAuhquL/IKZjGrDC57pMVqqjduSvLusY0CJOoWsTRRvzCoe3XCs5jIbbjQb4RJfBT2+eNAZEQanQJrzIZlSpleJc30m93qeZjqz55G8StKP5n4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4595EBAEC5900A46BAAF25BDB69658C2@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1013cf7-6a10-4fa4-a734-08d630212fdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2018 09:00:41.3453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB1967
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE4LTEwLTA1IGF0IDA4OjUzICswMjAwLCBSaWNhcmRvIFJpYmFsZGEgRGVsZ2Fk
byB3cm90ZToNCj4gQ3VycmVudCBjb2RlIGFzc3VtZXMgdGhhdCB0aGUgZGlyZWN0aW9uIGlzIGlu
cHV0IGlmIGRpcmVjdGlvbl9pbnB1dA0KPiBmdW5jdGlvbiBpcyBzZXQuDQo+IFRoaXMgbWlnaHQg
bm90IGJlIHRoZSBjYXNlIG9uIEdQSU9zIHdpdGggcHJvZ3JhbW1hYmxlIGRpcmVjdGlvbi4NCg0K
VW5mb3J0dW5hdGVseSwgdGhpcyBicmVha3MgYXQgbGVhc3QgQXBhbGlzIFQzMCBhbmQgQXBhbGlz
IFRLMS4gRW5hYmxpbmcNCmVhcmx5Y29uIHJldmVhbHMgdGhlIGZvbGxvd2luZzoNCg0KWyAgICAw
LjcyMTE2NV0gVW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNl
IGF0DQp2aXJ0dWFsIGFkZHJlDQpzcyAwMDAwMDFmOA0KWyAgICAwLjcyOTU3MF0gcGdkID0gKHB0
cnZhbCkNClsgICAgMC43MzI0MTddIFswMDAwMDFmOF0gKnBnZD0wMDAwMDAwMA0KWyAgICAwLjcz
NjEzN10gSW50ZXJuYWwgZXJyb3I6IE9vcHM6IDUgWyMxXSBQUkVFTVBUIFNNUCBBUk0NClsgICAg
MC43NDE2NDNdIE1vZHVsZXMgbGlua2VkIGluOg0KWyAgICAwLjc0NDgxOV0gQ1BVOiAwIFBJRDog
MSBDb21tOiBzd2FwcGVyLzAgTm90IHRhaW50ZWQgNC4xOS4wLXJjNy0NCm5leHQtMjAxODEwMQ0K
MiAjNg0KWyAgICAwLjc1MjU3OV0gSGFyZHdhcmUgbmFtZTogTlZJRElBIFRlZ3JhIFNvQyAoRmxh
dHRlbmVkIERldmljZSBUcmVlKQ0KWyAgICAwLjc1OTA5Ml0gUEMgaXMgYXQgZ3Bpb2RfaG9nKzB4
MmMvMHgxNTANClsgICAgMC43NjMyNTVdIExSIGlzIGF0IG9mX2dwaW9jaGlwX2FkZCsweDM0Yy8w
eDUxMA0KWyAgICAwLjc2ODA0MF0gcGMgOiBbPGMwNDRjOWE0Pl0gICAgbHIgOiBbPGMwNDRlODQw
Pl0gICAgcHNyOiA2MDAwMDAxMw0KWyAgICAwLjc3NDUzNF0gc3AgOiBmNjhjOWNkMCAgaXAgOiAw
MDAwMDAwMCAgZnAgOiBmNjhjOWQxOA0KWyAgICAwLjc3OTk0Nl0gcjEwOiBjMGNjYjNjOCAgcjkg
OiAwMDAwMDAwMCAgcjggOiAwMDAwMDAwMA0KWyAgICAwLjc4NTM1OV0gcjcgOiAwMDAwMDAwNyAg
cjYgOiBjMjAwMTljNCAgcjUgOiBmNmE3Yjk3MCAgcjQgOg0KZjZhNzhhMjQNClsgICAgMC43OTIx
MjFdIHIzIDogMDAwMDAwMDAgIHIyIDogMDAwMDAwMDAgIHIxIDogYzIwMDE5YzQgIHIwIDoNCmY2
YTdiOTcwDQpbICAgIDAuNzk4ODg0XSBGbGFnczogblpDdiAgSVJRcyBvbiAgRklRcyBvbiAgTW9k
ZSBTVkNfMzIgIElTQQ0KQVJNICBTZWdtZW50IG5vbmUNClsgICAgMC44MDYyNzNdIENvbnRyb2w6
IDEwYzUzODdkICBUYWJsZTogODAwMDQwNGEgIERBQzogMDAwMDAwNTENClsgICAgMC44MTIyMjdd
IFByb2Nlc3Mgc3dhcHBlci8wIChwaWQ6IDEsIHN0YWNrIGxpbWl0ID0gMHgocHRydmFsKSkNClsg
ICAgMC44MTg0NTFdIFN0YWNrOiAoMHhmNjhjOWNkMCB0byAweGY2OGNhMDAwKQ0KLi4uDQpbICAg
IDEuMDQzNDkwXSBbPGMwNDRjOWE0Pl0gKGdwaW9kX2hvZykgZnJvbSBbPGMwNDRlODQwPl0NCihv
Zl9ncGlvY2hpcF9hZGQrMHgzNGMvMHg1MTApDQpbICAgIDEuMDUxNTMxXSBbPGMwNDRlODQwPl0g
KG9mX2dwaW9jaGlwX2FkZCkgZnJvbSBbPGMwNDRkMWNjPl0NCihncGlvY2hpcF9hZGRfZGF0YV93
aXRoX2tleSsweDY2OC8weDk1OCkNClsgICAgMS4wNjEwOTFdIFs8YzA0NGQxY2M+XSAoZ3Bpb2No
aXBfYWRkX2RhdGFfd2l0aF9rZXkpIGZyb20NCls8YzA0NGQ1MDQ+XSAoZGV2bV9ncGlvY2hpcF9h
ZGRfZGF0YSsweDQ4LzB4ODQpDQpbICAgIDEuMDcxMTA5XSBbPGMwNDRkNTA0Pl0gKGRldm1fZ3Bp
b2NoaXBfYWRkX2RhdGEpIGZyb20gWzxjMDQ1MTY2Yz5dDQoodGVncmFfZ3Bpb19wcm9iZSsweDJk
NC8weDQyMCkNClsgICAgMS4wODA0MTNdIFs8YzA0NTE2NmM+XSAodGVncmFfZ3Bpb19wcm9iZSkg
ZnJvbSBbPGMwNTc0MDQwPl0NCihwbGF0Zm9ybV9kcnZfcHJvYmUrMHg0OC8weDk4KQ0KWyAgICAx
LjA4OTE3MV0gWzxjMDU3NDA0MD5dIChwbGF0Zm9ybV9kcnZfcHJvYmUpIGZyb20gWzxjMDU3MjE2
ND5dDQoocmVhbGx5X3Byb2JlKzB4MWUwLzB4MmNjKQ0KWyAgICAxLjA5Nzc0Nl0gWzxjMDU3MjE2
ND5dIChyZWFsbHlfcHJvYmUpIGZyb20gWzxjMDU3MjNiND5dDQooZHJpdmVyX3Byb2JlX2Rldmlj
ZSsweDYwLzB4MTZjKQ0KWyAgICAxLjEwNjMxN10gWzxjMDU3MjNiND5dIChkcml2ZXJfcHJvYmVf
ZGV2aWNlKSBmcm9tIFs8YzA1NzI1OWM+XQ0KKF9fZHJpdmVyX2F0dGFjaCsweGRjLzB4ZTApDQpb
ICAgIDEuMTE1MDcxXSBbPGMwNTcyNTljPl0gKF9fZHJpdmVyX2F0dGFjaCkgZnJvbSBbPGMwNTcw
NGE4Pl0NCihidXNfZm9yX2VhY2hfZGV2KzB4NzQvMHhiNCkNClsgICAgMS4xMjM1NTRdIFs8YzA1
NzA0YTg+XSAoYnVzX2Zvcl9lYWNoX2RldikgZnJvbSBbPGMwNTcxNjQ0Pl0NCihidXNfYWRkX2Ry
aXZlcisweDFjMC8weDIwNCkNClsgICAgMS4xMzIxMjJdIFs8YzA1NzE2NDQ+XSAoYnVzX2FkZF9k
cml2ZXIpIGZyb20gWzxjMDU3MzFiOD5dDQooZHJpdmVyX3JlZ2lzdGVyKzB4NzQvMHgxMDgpDQpb
ICAgIDEuMTQwNTIxXSBbPGMwNTczMWI4Pl0gKGRyaXZlcl9yZWdpc3RlcikgZnJvbSBbPGMwMTAy
ZWJjPl0NCihkb19vbmVfaW5pdGNhbGwrMHg1NC8weDI4NCkNClsgICAgMS4xNDkwMTVdIFs8YzAx
MDJlYmM+XSAoZG9fb25lX2luaXRjYWxsKSBmcm9tIFs8YzBlMDExMzQ+XQ0KKGtlcm5lbF9pbml0
X2ZyZWVhYmxlKzB4MmQwLzB4MzY0KQ0KWyAgICAxLjE1ODA0M10gWzxjMGUwMTEzND5dIChrZXJu
ZWxfaW5pdF9mcmVlYWJsZSkgZnJvbSBbPGMwYTI0Yzc4Pl0NCihrZXJuZWxfaW5pdCsweDgvMHgx
MTApDQpbICAgIDEuMTY2NTI3XSBbPGMwYTI0Yzc4Pl0gKGtlcm5lbF9pbml0KSBmcm9tIFs8YzAx
MDEwZTg+XQ0KKHJldF9mcm9tX2ZvcmsrMHgxNC8weDJjKQ0KWyAgICAxLjE3NDM3NV0gRXhjZXB0
aW9uIHN0YWNrKDB4ZjY4YzlmYjAgdG8gMHhmNjhjOWZmOCkNCi4uLg0KDQpKdXN0IHJldmVydGlu
ZyB0aGlzIG9uZSBwYXRjaCBtYWRlIGl0IGJvb3QgYWdhaW4uIEkgd2lsbCBpbnZlc3RpZ2F0ZQ0K
ZnVydGhlci4uLg0KDQo+IFNpZ25lZC1vZmYtYnk6IFJpY2FyZG8gUmliYWxkYSBEZWxnYWRvIDxy
aWNhcmRvLnJpYmFsZGFAZ21haWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3Bpby9ncGlvbGli
LmMgfCAyNyArKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAx
MyBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwaW8vZ3Bpb2xpYi5jIGIvZHJpdmVycy9ncGlvL2dwaW9saWIuYw0KPiBpbmRleCA5MDcw
MTliNjdhNTguLmUwMTZiMjI2NThmZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncGlvL2dwaW9s
aWIuYw0KPiArKysgYi9kcml2ZXJzL2dwaW8vZ3Bpb2xpYi5jDQo+IEBAIC0xMzQ5LDIwICsxMzQ5
LDYgQEAgaW50IGdwaW9jaGlwX2FkZF9kYXRhX3dpdGhfa2V5KHN0cnVjdA0KPiBncGlvX2NoaXAg
KmNoaXAsIHZvaWQgKmRhdGEsDQo+ICANCj4gIAlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZncGlv
X2xvY2ssIGZsYWdzKTsNCj4gIA0KPiAtCWZvciAoaSA9IDA7IGkgPCBjaGlwLT5uZ3BpbzsgaSsr
KSB7DQo+IC0JCXN0cnVjdCBncGlvX2Rlc2MgKmRlc2MgPSAmZ2Rldi0+ZGVzY3NbaV07DQo+IC0N
Cj4gLQkJZGVzYy0+Z2RldiA9IGdkZXY7DQo+IC0NCj4gLQkJLyogUkVWSVNJVDogbW9zdCBoYXJk
d2FyZSBpbml0aWFsaXplcyBHUElPcyBhcw0KPiBpbnB1dHMgKG9mdGVuDQo+IC0JCSAqIHdpdGgg
cHVsbHVwcyBlbmFibGVkKSBzbyBwb3dlciB1c2FnZSBpcw0KPiBtaW5pbWl6ZWQuIExpbnV4DQo+
IC0JCSAqIGNvZGUgc2hvdWxkIHNldCB0aGUgZ3BpbyBkaXJlY3Rpb24gZmlyc3QgdGhpbmc7DQo+
IGJ1dCB1bnRpbA0KPiAtCQkgKiBpdCBkb2VzLCBhbmQgaW4gY2FzZSBjaGlwLT5nZXRfZGlyZWN0
aW9uIGlzIG5vdA0KPiBzZXQsIHdlIG1heQ0KPiAtCQkgKiBleHBvc2UgdGhlIHdyb25nIGRpcmVj
dGlvbiBpbiBzeXNmcy4NCj4gLQkJICovDQo+IC0JCWRlc2MtPmZsYWdzID0gIWNoaXAtPmRpcmVj
dGlvbl9pbnB1dCA/ICgxIDw8DQo+IEZMQUdfSVNfT1VUKSA6IDA7DQo+IC0JfQ0KPiAtDQo+ICAj
aWZkZWYgQ09ORklHX1BJTkNUUkwNCj4gIAlJTklUX0xJU1RfSEVBRCgmZ2Rldi0+cGluX3Jhbmdl
cyk7DQo+ICAjZW5kaWYNCj4gQEAgLTEzOTEsNiArMTM3NywxOSBAQCBpbnQgZ3Bpb2NoaXBfYWRk
X2RhdGFfd2l0aF9rZXkoc3RydWN0DQo+IGdwaW9fY2hpcCAqY2hpcCwgdm9pZCAqZGF0YSwNCj4g
IAlpZiAoc3RhdHVzKQ0KPiAgCQlnb3RvIGVycl9yZW1vdmVfY2hpcDsNCj4gIA0KPiArCWZvciAo
aSA9IDA7IGkgPCBjaGlwLT5uZ3BpbzsgaSsrKSB7DQo+ICsJCXN0cnVjdCBncGlvX2Rlc2MgKmRl
c2MgPSAmZ2Rldi0+ZGVzY3NbaV07DQo+ICsNCj4gKwkJZGVzYy0+Z2RldiA9IGdkZXY7DQo+ICsN
Cj4gKwkJaWYgKGNoaXAtPmdldF9kaXJlY3Rpb24gJiYNCj4gZ3Bpb2NoaXBfbGluZV9pc192YWxp
ZChjaGlwLCBpKSkNCj4gKwkJCWRlc2MtPmZsYWdzID0gIWNoaXAtPmdldF9kaXJlY3Rpb24oY2hp
cCwgaSkNCj4gPw0KPiArCQkJCQkoMSA8PCBGTEFHX0lTX09VVCkgOiAwOw0KPiArCQllbHNlDQo+
ICsJCQlkZXNjLT5mbGFncyA9ICFjaGlwLT5kaXJlY3Rpb25faW5wdXQgPw0KPiArCQkJCQkoMSA8
PCBGTEFHX0lTX09VVCkgOiAwOw0KPiArCX0NCj4gKw0KPiAgCWFjcGlfZ3Bpb2NoaXBfYWRkKGNo
aXApOw0KPiAgDQo+ICAJbWFjaGluZV9ncGlvY2hpcF9hZGQoY2hpcCk7
