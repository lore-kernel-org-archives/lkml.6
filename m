Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA9AC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01C7820859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="W61Glb75"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733115AbfAPGGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 01:06:52 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:53391 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732932AbfAPGGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 01:06:51 -0500
X-IronPort-AV: E=Sophos;i="5.56,485,1539673200"; 
   d="scan'208";a="25544313"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 15 Jan 2019 23:06:50 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 15 Jan 2019 23:06:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJxMPfEE19kOVW/Ar6s9o1BMkK3qlVGQFN6Z2ayIDeA=;
 b=W61Glb754+pEy8g2tBu8RELKB6TP1J1P2KzOWhYpghnYK5Kn6iRotvucC7WztaGkrniPeZVVqV+G+0kTA5wdrP8LnK2baOi1oClncFf1nyZlozEHfrwDZmpeDPkTeEO2CEmn5yNDED+8vn1XEI3f4HD80RhYXnmzQvzs4VWVKUw=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB2036.namprd11.prod.outlook.com (10.173.26.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.19; Wed, 16 Jan 2019 06:06:47 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::79d8:b977:b90a:76fa]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::79d8:b977:b90a:76fa%4]) with mapi id 15.20.1516.019; Wed, 16 Jan 2019
 06:06:47 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <ryder.lee@mediatek.com>, <marek.vasut@gmail.com>,
        <computersforpeace@gmail.com>, <boris.brezillon@bootlin.com>
CC:     <robh+dt@kernel.org>, <weijie.gao@mediatek.com>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v2 3/3] mtd: spi-nor: mtk-quadspi: rename config to a
 common one
Thread-Topic: [PATCH v2 3/3] mtd: spi-nor: mtk-quadspi: rename config to a
 common one
Thread-Index: AQHUrUDt92IZyy9gw0SVGsdcSg853qWxaMkA
Date:   Wed, 16 Jan 2019 06:06:47 +0000
Message-ID: <28cd6980-6697-e9f2-2e7a-226a507b5467@microchip.com>
References: <74d710ed89fd505a49bce53b51f6cb489e313dbb.1547538621.git.ryder.lee@mediatek.com>
 <761c9a0a482795dbc48949e982ab46987b737e08.1547538621.git.ryder.lee@mediatek.com>
In-Reply-To: <761c9a0a482795dbc48949e982ab46987b737e08.1547538621.git.ryder.lee@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P194CA0016.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:800:be::26) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:103::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB2036;6:uXjxmQ/P6qgH57Uobi/OFPQ1ozxj9y7+RwHWIvc0uvsRIyroesNRF8kbiA6MzZaOFWPYF3PBFTeAJGBiXCJH1mqwLhAT4G586NbeCb2/iqV2mJ/4iQ8Prs6is8vLNskORqp6kJ41gUr0CD6eO0/6ctUoHxBKx5lK5yN9Cch+NgTgU17eLJMjpvQYxAdMk1Src6+QdsD70CEPHmL7FHXuKwe+b5yL/sycMrexwxleGylXMdlklpXm+a1Zxem7aILJSAf1ajZlimdF/VAuT9GDVvntppuQuxS8HoyzwdjIluB0BHy8LhmfwmqPbY3oWCcgE8DKUzyKvbJ5PMdXAVAH422+4rPWiiaTyDXMsJomEG4gkXwh4goK/hiGo1w6xDKh3Vb3/6q869zoSnCW2c0Xtx5ex3OyrDpoRI7HhLGGs/QnpJbGXVoj5pBqjgNVXruOggt9A3EfR6WMbCpfZlxBcA==;5:337Zpo8p9U4QipPrfsx1TZCLqeyiiVNHUIEoG/43PfccK/DJk/13AbtvQKk6XeGausBzkL4fmOWWD0woFZ0kmScm1nYRIQioarj3Dt3dnEZLJUrcvRY7zxRBjd7GhVcuWILtr/e1ZAoepmD9OoZ1mIuAucBglG1ywlsYVApG4DqDaFbnD4R1UFPcOYOyHMKidFpliXZAtPGYs0FXfgM0fw==;7:fHheuVTvy1iuce+dItqB4bINjNRlVJzRy+qlE4J+1NwDa1jbzS+Hy5026MqsBWMt4Qfi+3AXr5/OWkCC744ZM6CMbYhxNtFrM9lBfdggk8zGlguBFVgO3V0TJ88WZZXuTYHevZM3VMMOSUTNJHvViw==
x-ms-office365-filtering-correlation-id: 2ba887cf-c4e4-4039-eff7-08d67b78cc31
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB2036;
x-ms-traffictypediagnostic: BN6PR11MB2036:
x-microsoft-antispam-prvs: <BN6PR11MB2036B46B0BD132E49F59F481F0820@BN6PR11MB2036.namprd11.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(136003)(366004)(346002)(39860400002)(189003)(199004)(6436002)(31686004)(52116002)(6246003)(66066001)(478600001)(26005)(6486002)(305945005)(106356001)(7736002)(316002)(105586002)(486006)(72206003)(99286004)(446003)(11346002)(54906003)(110136005)(2616005)(186003)(102836004)(76176011)(7416002)(6346003)(6506007)(476003)(386003)(53546011)(68736007)(8676002)(4326008)(3846002)(2906002)(6116002)(53936002)(71200400001)(71190400001)(256004)(8936002)(229853002)(36756003)(81156014)(81166006)(5660300001)(97736004)(6512007)(14444005)(39060400002)(14454004)(86362001)(25786009)(31696002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB2036;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NctawnhfXs2OedmftVBptxak16tKHf9ViHKCfFLiIQrNNxz1e4OhH3UMlBcXdZQlWVrlT+64v+28xwONZmGa3cn8Qq9agwCP1Uwr+O+3/GtX0USPszl2paG3P9AT+AU6f1EW/IgmXYACzX8wFAGkdrAEehbKgdAHmBX2oa+bkuRyFyb8yOyS+x4RSUuUoO0aeRZCtPQbTk4z/hW3k74Z2VO+Fd9fbLWzS7pf+BWPh/RZUq3899atmzCiN2MzaUts7mBNVqDam/f67tgL6QXY9JLpzL7LzY4eWffKJmlGMZ+Chbd6d/GGT6WVyiXTHajoCex5wpBtW3Wksybz+kxKZYPY47mlgSXV/Oj3e6YbiC34R68sN3YpGEGEg8o0U0v3GWtbgh2xYVmIbUT11KVe+WgQHALrbVRJerk1rGUE9hI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <3ADEA60ACD9CF04F906056C3E46099F5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba887cf-c4e4-4039-eff7-08d67b78cc31
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 06:06:45.3855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB2036
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDAxLzE2LzIwMTkgMDQ6MTIgQU0sIFJ5ZGVyIExlZSB3cm90ZToNCj4gVGhlIHF1YWRz
cGkgaXMgYSBnZW5lcmljIGNvbW11bmljYXRpb24gaW50ZXJmYWNlIHdoaWNoIGNvdWxkIGJlIHNo
YXJlZA0KPiB3aXRoIG90aGVyIE1lZGlhVGVrIFNvQ3MuIEhlbmNlIHJlbmFtZSBpdCB0byBhIGNv
bW1vbiBvbmUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSeWRlciBMZWUgPHJ5ZGVyLmxlZUBtZWRp
YXRlay5jb20+DQoNClJldmlld2VkLWJ5OiBUdWRvciBBbWJhcnVzIDx0dWRvci5hbWJhcnVzQG1p
Y3JvY2hpcC5jb20+DQoNCj4gLS0tDQo+IENoYW5nZXMgc2luY2UgdjI6DQo+IC1yZWJhc2UgdG8g
djUuMC1yYzEuDQo+IC1zb3J0IHRoZSBjb25maWcgaW4gYW4gYWxwaGFiZXRpY2FsIG9yZGVyLg0K
PiANCj4gQ2hhbmdlcyBzaW5jZSB2MTogbm9uZS4gDQo+IC0tLQ0KPiAgZHJpdmVycy9tdGQvc3Bp
LW5vci9LY29uZmlnICB8IDE2ICsrKysrKysrLS0tLS0tLS0NCj4gIGRyaXZlcnMvbXRkL3NwaS1u
b3IvTWFrZWZpbGUgfCAgMiArLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyks
IDkgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvc3BpLW5vci9L
Y29uZmlnIGIvZHJpdmVycy9tdGQvc3BpLW5vci9LY29uZmlnDQo+IGluZGV4IDQ0ZmU4MDEuLjQx
NGU4ODcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvS2NvbmZpZw0KPiArKysg
Yi9kcml2ZXJzL210ZC9zcGktbm9yL0tjb25maWcNCj4gQEAgLTcsMTQgKzcsNiBAQCBtZW51Y29u
ZmlnIE1URF9TUElfTk9SDQo+ICANCj4gIGlmIE1URF9TUElfTk9SDQo+ICANCj4gLWNvbmZpZyBN
VERfTVQ4MXh4X05PUg0KPiAtCXRyaXN0YXRlICJNZWRpYXRlayBNVDgxeHggU1BJIE5PUiBmbGFz
aCBjb250cm9sbGVyIg0KPiAtCWRlcGVuZHMgb24gSEFTX0lPTUVNDQo+IC0JaGVscA0KPiAtCSAg
VGhpcyBlbmFibGVzIGFjY2VzcyB0byBTUEkgTk9SIGZsYXNoLCB1c2luZyBNVDgxeHggU1BJIE5P
UiBmbGFzaA0KPiAtCSAgY29udHJvbGxlci4gVGhpcyBjb250cm9sbGVyIGRvZXMgbm90IHN1cHBv
cnQgZ2VuZXJpYyBTUEkgQlVTLCBpdCBvbmx5DQo+IC0JICBzdXBwb3J0cyBTUEkgTk9SIEZsYXNo
Lg0KPiAtDQo+ICBjb25maWcgTVREX1NQSV9OT1JfVVNFXzRLX1NFQ1RPUlMNCj4gIAlib29sICJV
c2Ugc21hbGwgNDA5NiBCIGVyYXNlIHNlY3RvcnMiDQo+ICAJZGVmYXVsdCB5DQo+IEBAIC02Niw2
ICs1OCwxNCBAQCBjb25maWcgU1BJX0hJU0lfU0ZDDQo+ICAJaGVscA0KPiAgCSAgVGhpcyBlbmFi
bGVzIHN1cHBvcnQgZm9yIGhpc2lsaWNvbiBTUEktTk9SIGZsYXNoIGNvbnRyb2xsZXIuDQo+ICAN
Cj4gK2NvbmZpZyBTUElfTVRLX1FVQURTUEkNCj4gKwl0cmlzdGF0ZSAiTWVkaWFUZWsgUXVhZCBT
UEkgY29udHJvbGxlciINCj4gKwlkZXBlbmRzIG9uIEhBU19JT01FTQ0KPiArCWhlbHANCj4gKwkg
IFRoaXMgZW5hYmxlcyBzdXBwb3J0IGZvciB0aGUgUXVhZCBTUEkgY29udHJvbGxlciBpbiBtYXN0
ZXIgbW9kZS4NCj4gKwkgIFRoaXMgY29udHJvbGxlciBkb2VzIG5vdCBzdXBwb3J0IGdlbmVyaWMg
U1BJLiBJdCBvbmx5IHN1cHBvcnRzDQo+ICsJICBTUEkgTk9SLg0KPiArDQo+ICBjb25maWcgU1BJ
X05YUF9TUElGSQ0KPiAgCXRyaXN0YXRlICJOWFAgU1BJIEZsYXNoIEludGVyZmFjZSAoU1BJRkkp
Ig0KPiAgCWRlcGVuZHMgb24gT0YgJiYgKEFSQ0hfTFBDMThYWCB8fCBDT01QSUxFX1RFU1QpDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL01ha2VmaWxlIGIvZHJpdmVycy9tdGQv
c3BpLW5vci9NYWtlZmlsZQ0KPiBpbmRleCBhNTUyZWZkLi40ZTRkNDAwIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL210ZC9zcGktbm9yL01ha2VmaWxlDQo+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1u
b3IvTWFrZWZpbGUNCj4gQEAgLTQsNyArNCw3IEBAIG9iai0kKENPTkZJR19TUElfQVNQRUVEX1NN
QykJKz0gYXNwZWVkLXNtYy5vDQo+ICBvYmotJChDT05GSUdfU1BJX0NBREVOQ0VfUVVBRFNQSSkJ
Kz0gY2FkZW5jZS1xdWFkc3BpLm8NCj4gIG9iai0kKENPTkZJR19TUElfRlNMX1FVQURTUEkpCSs9
IGZzbC1xdWFkc3BpLm8NCj4gIG9iai0kKENPTkZJR19TUElfSElTSV9TRkMpCSs9IGhpc2ktc2Zj
Lm8NCj4gLW9iai0kKENPTkZJR19NVERfTVQ4MXh4X05PUikgICAgKz0gbXRrLXF1YWRzcGkubw0K
PiArb2JqLSQoQ09ORklHX1NQSV9NVEtfUVVBRFNQSSkgICAgKz0gbXRrLXF1YWRzcGkubw0KPiAg
b2JqLSQoQ09ORklHX1NQSV9OWFBfU1BJRkkpCSs9IG54cC1zcGlmaS5vDQo+ICBvYmotJChDT05G
SUdfU1BJX0lOVEVMX1NQSSkJKz0gaW50ZWwtc3BpLm8NCj4gIG9iai0kKENPTkZJR19TUElfSU5U
RUxfU1BJX1BDSSkJKz0gaW50ZWwtc3BpLXBjaS5vDQo+IA0K
