Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BF2C6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 09:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE4D223AC
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 09:47:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DE4D223AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hotmail.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752944AbeGGJlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 05:41:08 -0400
Received: from mail-oln040092064098.outbound.protection.outlook.com ([40.92.64.98]:44064
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751693AbeGGJlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 05:41:06 -0400
Received: from HE1EUR01FT021.eop-EUR01.prod.protection.outlook.com
 (10.152.0.56) by HE1EUR01HT208.eop-EUR01.prod.protection.outlook.com
 (10.152.1.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.20.906.15; Sat, 7
 Jul 2018 09:41:03 +0000
Received: from AM5PR0701MB2657.eurprd07.prod.outlook.com (10.152.0.54) by
 HE1EUR01FT021.mail.protection.outlook.com (10.152.0.167) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.20.906.15 via Frontend Transport; Sat, 7 Jul 2018 09:41:03 +0000
Received: from AM5PR0701MB2657.eurprd07.prod.outlook.com
 ([fe80::b1fe:1b4f:88c3:5243]) by AM5PR0701MB2657.eurprd07.prod.outlook.com
 ([fe80::b1fe:1b4f:88c3:5243%7]) with mapi id 15.20.0952.008; Sat, 7 Jul 2018
 09:41:03 +0000
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCHv2] Fix range checks in kernfs_get_target_path
Thread-Topic: [PATCHv2] Fix range checks in kernfs_get_target_path
Thread-Index: AQHUFdaeLDbdtFgySEW5kU1JCySiEg==
Date:   Sat, 7 Jul 2018 09:41:03 +0000
Message-ID: <AM5PR0701MB265728DBCC26198F64EEC027E4460@AM5PR0701MB2657.eurprd07.prod.outlook.com>
Accept-Language: en-US, en-GB, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0065.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::29) To AM5PR0701MB2657.eurprd07.prod.outlook.com
 (2603:10a6:203:75::7)
x-incomingtopheadermarker: OriginalChecksum:C5B416B28EDEDA3B94F1C3F2E41BA3675CDFC6A93D6B60D02AB50967A4D97EEE;UpperCasedChecksum:A63BDCBDD950C3F5258A06BEDF7363502B288E82709B13329B3C4316709B30F6;SizeAsReceived:7429;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [fBp3VAWJNg0c2m921xuju7rgmRMrXYlk]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1EUR01HT208;7:pZT0IvlVfVi5ZhAVYKqcsuHmsuWQheX6eOcuYJAnVvHVHgDgcowaHZJF+lw0F5bdlCmgQcCU3t5gQvcWXcdNQWOPWFS78cGVpbK2TuwZv9d92ziv9cP85gjy0OWvB3y1giYTEJ6CcmSFUEZdUZL/4F/wtKBTU2glzuWIxVba6/IiCwnz4VZEMpoKOoJvMYpBakqZqTEkxMNpUPr3LPcAgV8CstGDkTV3w2DCaYoWhGgRunA3pnJ8BdVKK+h43h/z
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031324274)(2017031323274)(2017031322404)(1601125500)(1603101448)(1701031045);SRVR:HE1EUR01HT208;
x-ms-traffictypediagnostic: HE1EUR01HT208:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(82015058);SRVR:HE1EUR01HT208;BCL:0;PCL:0;RULEID:;SRVR:HE1EUR01HT208;
x-forefront-prvs: 0726B2D7A6
x-forefront-antispam-report: SFV:NSPM;SFS:(7070007)(199004)(189003)(104016004)(55016002)(74316002)(305945005)(74482002)(14454004)(9686003)(2900100001)(25786009)(8676002)(81156014)(8936002)(97736004)(75402003)(68736007)(110136005)(82202002)(6436002)(73972006)(99286004)(102836004)(2501003)(5250100002)(1857600001)(6346003)(26005)(5660300001)(44832011)(33656002)(7696005)(476003)(486006)(14444005)(256004)(86362001)(105586002)(6506007)(106356001)(386003);DIR:OUT;SFP:1901;SCL:1;SRVR:HE1EUR01HT208;H:AM5PR0701MB2657.eurprd07.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:;
received-spf: None (protection.outlook.com: hotmail.de does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bernd.edlinger@hotmail.de; 
x-microsoft-antispam-message-info: tdOLYIJeDMeps10ns0Qwyzdgx8R+9Rw2AMVOYmQBLUKbpdtY8iJLWyCg09SPfMDwZeIhKsix6H9cqipWIZE+wfrR9KPFKaSIN37Lb5WOhmnelx6kFYUtV8eFl+B3nVXiFQ9hJWDV80JcKEjhxFGhAwUq80zSSS0y+sZHb4YwL8usvelIw6qRL1OIPpckmi6QanIfirSZb7c5l2a+hEfRpaDttxwwytCARR79rSg5ZRg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8BC95E185D4B164B8D590ECB00FEE5AF@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: d4d70346-2c10-4f39-8c00-e767963926d9
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a937796-75c4-4c5e-11ef-08d5e3edc119
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: d4d70346-2c10-4f39-8c00-e767963926d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2018 09:41:03.7161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1EUR01HT208
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIHN0cm5jcHkgY2F1c2VzIGEgd2FybmluZyBbLVdzdHJpbmdvcC10cnVuY2F0aW9uXSBoZXJl
LA0Kd2hpY2ggaW5kaWNhdGVzIHRoYXQgaXQgbmV2ZXIgYXBwZW5kcyBhIE5VTCBieXRlIHRvIHRo
ZSBwYXRoLg0KVGhlIE5VTCBieXRlIGlzIG9ubHkgdGhlcmUgYmVjYXVzZSB0aGUgYnVmZmVyIGlz
IGFsbG9jYXRlZA0Kd2l0aCBremFsbG9jKFBBR0VfU0laRSwgR0ZQX0tFUk5FTCksIGJ1dCBzaW5j
ZSB0aGUgcmFuZ2UtY2hlY2sNCmlzIGFsc28gb2ZmLWJ5LW9uZSwgYW5kIFBBR0VfU0laRT09UEFU
SF9NQVggdGhlIHJldHVybmVkIHN0cmluZw0Kd2lsbCBub3QgYmUgemVyby10ZXJtaW5hdGVkIGlm
IGl0IGlzIGV4YWN0bHkgUEFUSF9NQVggY2hhcmFjdGVycy4NCkZ1cnRoZXJtb3JlIGFsc28gdGhl
IGluaXRpYWwgbG9vcCBtYXkgdGhlb3JldGljYWxseSBleGNlZWQgUEFUSF9NQVgNCmFuZCBjYXVz
ZSBhIGZhdWx0Lg0KDQpTaWduZWQtb2ZmLWJ5OiBCZXJuZCBFZGxpbmdlciA8YmVybmQuZWRsaW5n
ZXJAaG90bWFpbC5kZT4NCi0tLQ0KICBmcy9rZXJuZnMvc3ltbGluay5jIHwgMTAgKysrKysrKy0t
LQ0KICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KDQpk
aWZmIC0tZ2l0IGEvZnMva2VybmZzL3N5bWxpbmsuYyBiL2ZzL2tlcm5mcy9zeW1saW5rLmMNCmlu
ZGV4IDA4Y2NhYmQuLmM4YjdkNDRhIDEwMDY0NA0KLS0tIGEvZnMva2VybmZzL3N5bWxpbmsuYw0K
KysrIGIvZnMva2VybmZzL3N5bWxpbmsuYw0KQEAgLTYzLDcgKzYzLDEwIEBAIHN0YXRpYyBpbnQg
a2VybmZzX2dldF90YXJnZXRfcGF0aChzdHJ1Y3Qga2VybmZzX25vZGUNCiAgCQlpZiAoYmFzZSA9
PSBrbikNCiAgCQkJYnJlYWs7DQoNCi0JCXN0cmNweShzLCAiLi4vIik7DQorCQlpZiAoKHMgLSBw
YXRoKSArIDMgPj0gUEFUSF9NQVgpDQorCQkJcmV0dXJuIC1FTkFNRVRPT0xPTkc7DQorDQorCQlt
ZW1jcHkocywgIi4uLyIsIDMpOw0KICAJCXMgKz0gMzsNCiAgCQliYXNlID0gYmFzZS0+cGFyZW50
Ow0KICAJfQ0KQEAgLTc5LDE2ICs4MiwxNyBAQCBzdGF0aWMgaW50IGtlcm5mc19nZXRfdGFyZ2V0
X3BhdGgoc3RydWN0IGtlcm5mc19ub2RlDQogIAlpZiAobGVuIDwgMikNCiAgCQlyZXR1cm4gLUVJ
TlZBTDsNCiAgCWxlbi0tOw0KLQlpZiAoKHMgLSBwYXRoKSArIGxlbiA+IFBBVEhfTUFYKQ0KKwlp
ZiAoKHMgLSBwYXRoKSArIGxlbiA+PSBQQVRIX01BWCkNCiAgCQlyZXR1cm4gLUVOQU1FVE9PTE9O
RzsNCg0KICAJLyogcmV2ZXJzZSBmaWxsdXAgb2YgdGFyZ2V0IHN0cmluZyBmcm9tIHRhcmdldCB0
byBiYXNlICovDQogIAlrbiA9IHRhcmdldDsNCisJc1tsZW5dID0gJ1wwJzsNCiAgCXdoaWxlIChr
bi0+cGFyZW50ICYmIGtuICE9IGJhc2UpIHsNCiAgCQlpbnQgc2xlbiA9IHN0cmxlbihrbi0+bmFt
ZSk7DQoNCiAgCQlsZW4gLT0gc2xlbjsNCi0JCXN0cm5jcHkocyArIGxlbiwga24tPm5hbWUsIHNs
ZW4pOw0KKwkJbWVtY3B5KHMgKyBsZW4sIGtuLT5uYW1lLCBzbGVuKTsNCiAgCQlpZiAobGVuKQ0K
ICAJCQlzWy0tbGVuXSA9ICcvJzsNCg0KLS0gDQoxLjkuMQ0K
