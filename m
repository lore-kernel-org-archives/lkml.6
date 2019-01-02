Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7096EC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 09:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 122522171F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 09:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="vIiOmE4s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbfABJ0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 04:26:00 -0500
Received: from mail-eopbgr790054.outbound.protection.outlook.com ([40.107.79.54]:27552
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728994AbfABJZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 04:25:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6YAmSHAJz4W6hpaJD0uCoYoaAf3mg7jpll1aj2AFmM=;
 b=vIiOmE4sCbxc25ZpZe4266WkbDmzekyTbYIBOdVTN7QQm/YEnpU/axQiVEaqKpdiLbWVRV/BvRcCIENbbflnOLfZq62f9H7Zmuf4uqyAL30NI05EYuPDk7li5QjQ/cMesvLMoF+l9pQY4idXrLycS8BFxlGaIPMP91HWDd8Ta+Q=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (10.168.206.9) by
 MWHPR02MB3200.namprd02.prod.outlook.com (10.164.133.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Wed, 2 Jan 2019 09:23:04 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::a8e5:2cda:352a:6e61]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::a8e5:2cda:352a:6e61%12]) with mapi id 15.20.1471.019; Wed, 2 Jan 2019
 09:23:04 +0000
From:   Naga Sureshkumar Relli <nagasure@xilinx.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Romain Perier <romain.perier@gmail.com>
CC:     Boris Brezillon <bbrezillon@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "peterpandong@micron.com" <peterpandong@micron.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [LINUX PATCH v12] mtd: rawnand: pl353: Add basic driver for arm
 pl353 smc nand interface
Thread-Topic: [LINUX PATCH v12] mtd: rawnand: pl353: Add basic driver for arm
 pl353 smc nand interface
Thread-Index: AQHUmQ4LiiFMPM7qzEydyT81wJBeTaWbuZsAgAAFQPA=
Date:   Wed, 2 Jan 2019 09:23:04 +0000
Message-ID: <MWHPR02MB26237BE35B07E8930B5E2AB2AF8C0@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1533620414-3332-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <20181221091750.GA19470@hp-probook-450> <20190102093338.3b4a8c69@xps13>
In-Reply-To: <20190102093338.3b4a8c69@xps13>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB3200;6:TeRYUACx1/vYegQVgMwigGN3VUdfaW3ty6c4olZCB5fkXKBgeWpdK8ENDu1gChEeqNyssgAtgSwF2jP9cwPpmpjbhUgMWPOdjFj5qLeSTDkZGLdRGoZmxAQhWytbeM9usGrk/dNMddUPFweBWX+Jlgxjy/kGvEZOZ7JT08dIjY6IgGuIEq8j2wOIihKKquRDynw/0c2zD5TsjQ8cNDvxNf2lXKDV5NSTnfgjezQdzRbgIr03MapBsjGSkxypU/38qfoMMZ2VGIUQfwSdESOA4sIOGbgwxv21atKza+7CU16+f7GA5NxaiMyJ0PvZubcecEaOxslJ1QiQWvxY7V1MIaGHqqBJC1xHCUb4H/MF+9wMgFSpzcC+MK73HOT3fatiMSjJsWO6e8WMX+4/5a8suAZ315bdmdVIVYkGiWoidneReyRhcLYdawV+wKQOCdgwX1XKtH100nATsvnEp7Vc7A==;5:bd9rYxqb2TsXHq/QGpPyniRD3nasxToI7LYS9HlIP86TKBX1qvOcfCczvPsVGatnL9jts/JbW5vG1zuJldxx50juEcNF+K3r0lHQn25DpRXZrWSkWCf1+L03mtbo71eNRejZGcluZaSd1Vgkl814/DwUiBkrLp43nAVrSGPXqrMVbSOAKrSVoN7pS39PyrNct35Y5ErTZpnumpAiQHA24A==;7:Jk3Cq23cD4tKLv2fwvQntHuu+krS4G9XQeNNcmXpfpN+R8v5y9xoca+V0S9MoDefOloqTyRpl309HeBRD1F1fXOPw7DcCjrFU3nqPE/RyoULViPq8wCnehkIuFVALIqqzEq78VUUJBKth1g7dHTWvw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 2920f96f-85e8-458a-6cb5-08d67093e653
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB3200;
x-ms-traffictypediagnostic: MWHPR02MB3200:
x-microsoft-antispam-prvs: <MWHPR02MB320028E4BA950F9077137D27AF8C0@MWHPR02MB3200.namprd02.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(93006095)(93001095)(3002001)(3231475)(944501520)(52105112)(10201501046)(6055026)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:MWHPR02MB3200;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB3200;
x-forefront-prvs: 0905A6B2C7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(376002)(39860400002)(346002)(136003)(199004)(189003)(13464003)(66574012)(6506007)(76176011)(486006)(26005)(476003)(106356001)(105586002)(217873002)(256004)(68736007)(71190400001)(97736004)(102836004)(14444005)(33656002)(71200400001)(4326008)(53546011)(186003)(11346002)(446003)(7696005)(6436002)(81166006)(8676002)(229853002)(8936002)(81156014)(5660300001)(9686003)(6246003)(25786009)(39060400002)(53936002)(55016002)(3846002)(6116002)(86362001)(74316002)(2906002)(478600001)(14454004)(99286004)(305945005)(66066001)(54906003)(316002)(7736002)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB3200;H:MWHPR02MB2623.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ygkyg/mw4kOjBfOzY9CYJgqJa/xAN0vN4dQjaKjLUG17Rhei/9CxZjXWbGRVDYRkEbw3OteMcU5cKnUzwY9cLIafLMdAPJtX16AyGjWTtrEpvHJURw5MVk9ji65+eF3Fuaq75uSbViHg46oHMRZy2+rkvxTn3veT7nNelIG2E1pJY/Q9BojfzpMD0OLjDRy3vUmsnnS/e0o+UxZEEgaOeFlY7eQ91o3i5tgXwxi4m4ALviXHNmAbTq2JIsp/hN2bx07Q8KXrL+zDkJdKPc73VIJ5vc1orzPzcBPC+pKVxygwn4yrAZOnym/FVM6fJRF+
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2920f96f-85e8-458a-6cb5-08d67093e653
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2019 09:23:04.3522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWlxdWVsIFJheW5h
bCBbbWFpbHRvOm1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb21dDQo+IFNlbnQ6IFdlZG5lc2RheSwg
SmFudWFyeSAyLCAyMDE5IDI6MDQgUE0NCj4gVG86IFJvbWFpbiBQZXJpZXIgPHJvbWFpbi5wZXJp
ZXJAZ21haWwuY29tPg0KPiBDYzogTmFnYSBTdXJlc2hrdW1hciBSZWxsaSA8bmFnYXN1cmVAeGls
aW54LmNvbT47IEJvcmlzIEJyZXppbGxvbg0KPiA8YmJyZXppbGxvbkBrZXJuZWwub3JnPjsgbGlu
dXgtbXRkQGxpc3RzLmluZnJhZGVhZC5vcmc7IHBldGVycGFuZG9uZ0BtaWNyb24uY29tOw0KPiBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbTElOVVggUEFUQ0gg
djEyXSBtdGQ6IHJhd25hbmQ6IHBsMzUzOiBBZGQgYmFzaWMgZHJpdmVyIGZvciBhcm0gcGwzNTMN
Cj4gc21jIG5hbmQgaW50ZXJmYWNlDQo+IA0KPiBIaSBSb21haW4sDQo+IA0KPiBTd2l0Y2hpbmcg
Qm9yaXMgYWRkcmVzcy4NCj4gDQo+IFJvbWFpbiBQZXJpZXIgPHJvbWFpbi5wZXJpZXJAZ21haWwu
Y29tPiB3cm90ZSBvbiBGcmksIDIxIERlYyAyMDE4DQo+IDEwOjE3OjUwICswMTAwOg0KPiANCj4g
PiBIZWxsbywNCj4gPg0KPiA+IEkgaGF2ZSByZWJhc2VkIHRoaXMgcGF0Y2ggb250byA0LjE5LjEx
LiBJIHVzZSBpdCBvbiBhIFp5bnE3MDAwLWJhc2VkDQo+ID4gYm9hcmQgd2l0aCBhIE5BTkQgY2hp
cCBNaWNyb24gTVQyOUY0RzA4QUJBREFINCwgc2luY2UgfjIgd2Vla3Mgbm93Lg0KPiA+IFRoZSBv
bmx5IHByb2JsZW0gSSBoYXZlIHRvIHJlcG9ydCBpcyB0aGF0IHdoZW4gSSBib290IHdpdGggYW4N
Cj4gPiB1bmNoYW5nZWQgZHJpdmVyIG9uIG15IGJvYXJkLCBJIGdldCB0aGUgZm9sbG93aW5nIGxv
Z3M6DQo+ID4NCj4gPiBbICAgIDEuOTg4Nzk3XSBuYW5kOiBkZXZpY2UgZm91bmQsIE1hbnVmYWN0
dXJlciBJRDogMHgyYywgQ2hpcCBJRDogMHhkYw0KPiA+IFsgICAgMS45OTUxODRdIG5hbmQ6IE1p
Y3JvbiBNVDI5RjRHMDhBQkFEQUg0DQo+ID4gWyAgICAxLjk5OTE4N10gbmFuZDogNTEyIE1pQiwg
U0xDLCBlcmFzZSBzaXplOiAxMjggS2lCLCBwYWdlIHNpemU6IDIwNDgsIE9PQiBzaXplOiA2NA0K
PiA+IFsgICAgMi40MDI2NjFdIG5hbmQ6IHRpbWVvdXQgd2hpbGUgd2FpdGluZyBmb3IgY2hpcCB0
byBiZWNvbWUgcmVhZHkNCj4gPiBbICAgIDIuNDA4NjY1XSBuYW5kOiB0aW1pbmcgbW9kZSA1IG5v
dCBhY2tub3dsZWRnZWQgYnkgdGhlIE5BTkQgY2hpcA0KPiA+IFsgICAgMi40MTYyNTFdIEJhZCBi
bG9jayB0YWJsZSBub3QgZm91bmQgZm9yIGNoaXAgMA0KPiA+IFsgICAgMi40MjIyNzhdIEJhZCBi
bG9jayB0YWJsZSBub3QgZm91bmQgZm9yIGNoaXAgMA0KPiA+IFsgICAgMi40MjY5MDNdIFNjYW5u
aW5nIGRldmljZSBmb3IgYmFkIGJsb2Nrcw0KPiA+IFsgICAgMi40MzEwMjRdIEJhZCBlcmFzZWJs
b2NrIDAgYXQgMHgwMDAwMDAwMDAwMDANCj4gPiBbICAgIDIuNDM1NTA5XSBCYWQgZXJhc2VibG9j
ayAxIGF0IDB4MDAwMDAwMDIwMDAwDQo+ID4gWyAgICAyLjQzOTk3OF0gQmFkIGVyYXNlYmxvY2sg
MiBhdCAweDAwMDAwMDA0MDAwMA0KPiA+IFsgICAgMi40NDQ0NjVdIEJhZCBlcmFzZWJsb2NrIDMg
YXQgMHgwMDAwMDAwNjAwMDANCj4gPiBbICAgIDIuNDQ4OTM2XSBCYWQgZXJhc2VibG9jayA0IGF0
IDB4MDAwMDAwMDgwMDAwDQo+ID4gWyAgICAyLjQ1MzQyM10gQmFkIGVyYXNlYmxvY2sgNSBhdCAw
eDAwMDAwMDBhMDAwMA0KPiA+IFsgICAgMi40NTc4OTNdIEJhZCBlcmFzZWJsb2NrIDYgYXQgMHgw
MDAwMDAwYzAwMDANCj4gPiBbICAgIDIuNDYyMzU0XSBCYWQgZXJhc2VibG9jayA3IGF0IDB4MDAw
MDAwMGUwMDAwDQo+ID4gWyAgICAyLjQ2Njg0MV0gQmFkIGVyYXNlYmxvY2sgOCBhdCAweDAwMDAw
MDEwMDAwMA0KPiA+IFsgICAgMi40NzEzMDRdIEJhZCBlcmFzZWJsb2NrIDkgYXQgMHgwMDAwMDAx
MjAwMDANCj4gPiBbICAgIDIuNDc1NzkzXSBCYWQgZXJhc2VibG9jayAxMCBhdCAweDAwMDAwMDE0
MDAwMA0KPiA+IFsgICAgMi40ODAzNDldIEJhZCBlcmFzZWJsb2NrIDExIGF0IDB4MDAwMDAwMTYw
MDAwDQo+ID4NCj4gPiBbLi4uXQ0KPiA+DQo+ID4NCj4gPiBBZnRlciBpbnZlc3RpZ2F0aW9uLCBp
dCBzZWVtcyB0aGF0IGR1cmluZyB0aGUgbmFuZF9zY2FuIHBoYXNlLCB0aGUNCj4gPiBOQU5EIHN1
YnN5c3RlbSB0ZXN0cyBkaWZmZXJlbnQgdGltaW5nIG1vZGVzIG9uIHRoZSBOQU5EIGNoaXAgKG1v
ZGUgMA0KPiA+IHNlZW1zIHRvIGJlIGFwcGx5IGR1cmluZyByZXNldCwgYW5kIHRoZW4gaXQgdHJp
ZXMgdG8gZGV0ZWN0IHRoZSBiZXN0DQo+ID4gbW9kZSBzdXBwb3J0ZWQgYnkgdGhlIE5BTkQgY2hp
cCkuIE9ubHkgdGhlIG1vZGUgMCB3b3JrcyBoZXJlLCB0cnlpbmcNCj4gPiB0aGUgdXNlIHRoZSBt
b2RlIDUgcmVzdWxzIGluIGFuIGVycm9yIChhcyB5b3UgY2FuIHNlZSBpbiB0aGUgbG9nKSBhbmQN
Cj4gPiBhIGJhZCBCQlQgZGV0ZWN0aW9uLiBCb3RoIG1vZGVzIGFyZSBzdXBwb3J0ZWQgYnkgdGhl
IE5BTkQgY2hpcC4gSW4NCj4gPiBvcmRlciB0byBmaXggdGhpcywgSSBoYWQgdG8gcHV0IHRoZSBu
ZmMgdGltaW5nIGludG8gdGhlIGRldmljZSBub2RlIG9mIHRoZSBuZmMsIGluc2lkZSB0aGUgRFQN
Cj4gKHRoYXQncyBub3QgYSByZWFsIGZpeCwgaWhtbykuDQo+IA0KPiBUaGFua3MgZm9yIHRlc3Rp
bmchIEluZGVlZCwgdGhlIC0+c2V0dXBfZGF0YV9pbnRlcmZhY2UoKSBjYWxsYmFjayBzaG91bGQg
YmUgZml4ZWQuDQpPaywgbGV0IG1lIGNoZWNrLg0KTWVhbndoaWxlLCBjYW4geW91IHNoYXJlIHRo
ZSB0aW1pbmdzIHRoYXQgeW91IHB1dCBpbnNpZGUgdGhlIERUPw0KPiANCj4gPiBFeGNlcHQgdGhp
cywgZXZlcnl0aGluZyBpcyB3b3JraW5nIGFzIGV4cGVjdGVkLiBFdmVyeXRoaW5nIGlzIHN0YWJs
ZQ0KPiA+IHdpdGggY29ycmVjdCBwZXJmb3JtYW5jZXMuDQo+ID4NCj4gPiBJZiBJIGNhbiBwcm92
aWRlIG1vcmUgaW5mb3JtYXRpb25zLCBmZWVsIGZyZWUgdG8gYXNrLg0KPiANCj4gWy4uLl0NCj4g
DQo+ID4gPiArc3RhdGljIGludCBwbDM1M19zZXR1cF9kYXRhX2ludGVyZmFjZShzdHJ1Y3QgbXRk
X2luZm8gKm10ZCwgaW50IGNzbGluZSwNCj4gPiA+ICsJCQkJICAgICAgIGNvbnN0IHN0cnVjdCBu
YW5kX2RhdGFfaW50ZXJmYWNlICpjb25mKSB7DQo+ID4gPiArCXN0cnVjdCBuYW5kX2NoaXAgKmNo
aXAgPSBtdGRfdG9fbmFuZChtdGQpOw0KPiA+ID4gKwlzdHJ1Y3QgcGwzNTNfbmFuZF9jb250cm9s
bGVyICp4bmZjID0NCj4gPiA+ICsJCWNvbnRhaW5lcl9vZihjaGlwLCBzdHJ1Y3QgcGwzNTNfbmFu
ZF9jb250cm9sbGVyLCBjaGlwKTsNCj4gPiA+ICsJY29uc3Qgc3RydWN0IG5hbmRfc2RyX3RpbWlu
Z3MgKnNkcjsNCj4gPiA+ICsJdTMyIHRpbWluZ3NbN10sIG1ja3BlcmlvZHBzOw0KPiA+ID4gKw0K
PiA+ID4gKwlpZiAoY3NsaW5lID09IE5BTkRfREFUQV9JRkFDRV9DSEVDS19PTkxZKQ0KPiA+ID4g
KwkJcmV0dXJuIDA7DQo+ID4gPiArDQo+ID4gPiArCXNkciA9IG5hbmRfZ2V0X3Nkcl90aW1pbmdz
KGNvbmYpOw0KPiA+ID4gKwlpZiAoSVNfRVJSKHNkcikpDQo+ID4gPiArCQlyZXR1cm4gUFRSX0VS
UihzZHIpOw0KPiA+ID4gKw0KPiA+ID4gKwkvKg0KPiA+ID4gKwkgKiBTRFIgdGltaW5ncyBhcmUg
Z2l2ZW4gaW4gcGljby1zZWNvbmRzIHdoaWxlIE5GQyB0aW1pbmdzIG11c3QgYmUNCj4gPiA+ICsJ
ICogZXhwcmVzc2VkIGluIE5BTkQgY29udHJvbGxlciBjbG9jayBjeWNsZXMuDQo+ID4gPiArCSAq
Lw0KPiA+ID4gKwltY2twZXJpb2RwcyA9IE5TRUNfUEVSX1NFQyAvIGNsa19nZXRfcmF0ZSh4bmZj
LT5tY2xrKTsNCj4gPiA+ICsJbWNrcGVyaW9kcHMgKj0gMTAwMDsNCj4gPiA+ICsJaWYgKHNkci0+
dFJDX21pbiA8PSAyMDAwMCkNCj4gPiA+ICsJCS8qDQo+ID4gPiArCQkgKiBQTDM1MyBTTUMgbmVl
ZHMgb25lIGV4dHJhIHJlYWQgY3ljbGUgaW4gU0RSIE1vZGUgNQ0KPiA+ID4gKwkJICogVGhpcyBp
cyBub3Qgd3JpdHRlbiBhbnl3aGVyZSBpbiB0aGUgZGF0YXNoZWV0IGJ1dA0KPiA+ID4gKwkJICog
dGhlIHJlc3VsdHMgb2JzZXJ2ZWQgZHVyaW5nIHRlc3RpbmcuDQo+ID4gPiArCQkgKi8NCj4gPiA+
ICsJCXRpbWluZ3NbMF0gPSBESVZfUk9VTkRfVVAoc2RyLT50UkNfbWluLCBtY2twZXJpb2Rwcykg
KyAxOw0KPiA+ID4gKwllbHNlDQo+ID4gPiArCQl0aW1pbmdzWzBdID0gRElWX1JPVU5EX1VQKHNk
ci0+dFJDX21pbiwgbWNrcGVyaW9kcHMpOw0KPiA+ID4gKw0KPiA+ID4gKwl0aW1pbmdzWzFdID0g
RElWX1JPVU5EX1VQKHNkci0+dFdDX21pbiwgbWNrcGVyaW9kcHMpOw0KPiA+ID4gKwkvKg0KPiA+
ID4gKwkgKiBGb3IgYWxsIFNEUiBtb2RlcywgUEwzNTMgU01DIG5lZWRzIHRSRUEgbWF4IHZhbHVl
IGFzIDEsDQo+ID4gPiArCSAqIFJlc3VsdHMgb2JzZXJ2ZWQgZHVyaW5nIHRlc3RpbmcuDQo+ID4g
PiArCSAqLw0KPiA+ID4gKwl0aW1pbmdzWzJdID0gUEwzNTNfVFJFQV9NQVhfVkFMVUU7DQo+ID4g
PiArCXRpbWluZ3NbM10gPSBESVZfUk9VTkRfVVAoc2RyLT50V1BfbWluLCBtY2twZXJpb2Rwcyk7
DQo+ID4gPiArCXRpbWluZ3NbNF0gPSBESVZfUk9VTkRfVVAoc2RyLT50Q0xSX21pbiwgbWNrcGVy
aW9kcHMpOw0KPiA+ID4gKwl0aW1pbmdzWzVdID0gRElWX1JPVU5EX1VQKHNkci0+dEFSX21pbiwg
bWNrcGVyaW9kcHMpOw0KPiA+ID4gKwl0aW1pbmdzWzZdID0gRElWX1JPVU5EX1VQKHNkci0+dFJS
X21pbiwgbWNrcGVyaW9kcHMpOw0KPiA+ID4gKwlwbDM1M19zbWNfc2V0X2N5Y2xlcyh0aW1pbmdz
KTsNCj4gPiA+ICsNCj4gPiA+ICsJcmV0dXJuIDA7DQo+ID4gPiArfQ0KPiA+DQo+ID4gSWYgSSBo
YWNrIHRoaXMgZnVuY3Rpb24gaW4gb3JkZXIgdG8gbGltaXQgdGhlIHRpbWluZ3Mgb25seSB0byBt
b2RlIDAsDQo+ID4gZXZlcnl0aGluZyB3b3Jrcy4gT3RoZXJ3aXNlIGl0IGhhbmdzIHdoZW4gaXQg
dHJpZXMgdG8gYXBwbHkgbW9kZSA1Lg0KPiA+DQo+IA0KPiBNYXliZSBOYWdhIGlzIG5vdCB1c2lu
ZyBhIGNoaXAgY29tcGF0aWJsZSB3aXRoIG1vZGUgNSBhbmQgZGlkIG5vdCByYW4gaW50byB0aGlz
IGlzc3VlPw0KTm8sIHRoZXNlIGFyZSB0aGUgY2hpcHMgSSBhbSB1c2luZywgUzM0TUwwMUcxIGFu
ZCBNVDI5RjJHMTZBQkFFQVdQLg0KVGhlc2UgYXJlIHVwIHRvIG1vZGUgNSBjb21wYXRpYmxlLg0K
DQpUaGFua3MsDQpOYWdhIFN1cmVzaGt1bWFyIFJlbGxpDQo+IA0KPiANCj4gVGhhbmtzLA0KPiBN
aXF1w6hsDQo=
