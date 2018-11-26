Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E46C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 13:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F8AD20862
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 13:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="Ev6n9OC7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F8AD20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nokia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbeKZX7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 18:59:11 -0500
Received: from mail-eopbgr60120.outbound.protection.outlook.com ([40.107.6.120]:60544
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726411AbeKZX7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 18:59:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHlQvXHYUwapRfC8CVUdt43byVynh4VI7uEVpmXpYQE=;
 b=Ev6n9OC7wXDLOUc5Uxlblk7OfFrdXOfiuwKsbdNV5koMbsLw31KUSxuNeFs5gvoUlTsy4t93GnN6N6/jnfLUNzE5yZ8HD5V0ImQ67pROQA75MIzDe21Gga8eh2mN9n9bkQpHHBXdVkWDw1ASmWvoDk6WNbTuimaM0MBo5kDjYOY=
Received: from HE1PR0701MB2729.eurprd07.prod.outlook.com (10.168.188.135) by
 HE1PR0701MB2745.eurprd07.prod.outlook.com (10.168.188.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.14; Mon, 26 Nov 2018 13:04:45 +0000
Received: from HE1PR0701MB2729.eurprd07.prod.outlook.com
 ([fe80::35b1:90ba:fa:3c77]) by HE1PR0701MB2729.eurprd07.prod.outlook.com
 ([fe80::35b1:90ba:fa:3c77%9]) with mapi id 15.20.1361.019; Mon, 26 Nov 2018
 13:04:45 +0000
From:   "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
To:     "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "richard@nod.at" <richard@nod.at>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mtd: spi-nor: fix erase_type array to indicate current
 map conf
Thread-Topic: [PATCH v2] mtd: spi-nor: fix erase_type array to indicate
 current map conf
Thread-Index: AQHUhYXyqNwBRhXCWUmPjriIVe6LZ6ViBiQA
Date:   Mon, 26 Nov 2018 13:04:45 +0000
Message-ID: <2ae2459e-f5e7-f621-fd63-0982a1e59e86@nokia.com>
References: <20181126124531.17548-1-tudor.ambarus@microchip.com>
In-Reply-To: <20181126124531.17548-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [131.228.32.165]
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
x-clientproxiedby: HE1PR05CA0309.eurprd05.prod.outlook.com
 (2603:10a6:7:93::40) To HE1PR0701MB2729.eurprd07.prod.outlook.com
 (2603:10a6:3:99::7)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=alexander.sverdlin@nokia.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0701MB2745;6:G53Aoe69gx/qt/nNbR60/UBl1AvImaSiLd5W86TCJwY+XKj4ERsF3LVe+zNF+k6Uq48qZF3EAl3ooammPLsQVkE9ct4SrakGDOt+DvAIWy6TpCJ7KNAnWjHRkbmtmIZdeFig1We396oaVPTRlnCvTRnj2jvOMgSD0et5NdT1lLTjbLkF5wGsKINusVHKhItfr+OVEJH0i9CUUVc7r1xPVcideWiahqmjB86zg8u0zY9ilLlEMMVbozYoMkUeHPeYdl7ECutYkhU8kFPBvi+pzGwqt5Da4P9xHDzhaYSnHtjZWB6Mbf4xIWhyIuOntcBx3HjUd53TZXpEMq/Jy5Y1Zwv+TCobOazFKco2QqZ4KYp+ZxqCVuNgPGdO3J0ES1iWaQIyVNNYSheuDUv2wXjMVa1Rk3w2IsBbqieozUiDgubGIYjgGghfrXyin+Gu3Rnvdroidpq4kwVC+mVS3Sqn9Q==;5:9CttrPYOvyDTp1ghef3qwWIOxi9CbRBvgSDCt0aIvRfjNSY7l9nE8MwbAxvR3Gwql2VxemmqcD8Weo7CArbm73IBUcgj3SKOP4UA8Inr8NEZhKwIo763TXYsydt29+Qt+ktvwAjpxoiQu2pxEwITaEjy3RR7aQxDQcxGwjKjWz4=;7:jJsfE6lljMO3oY0ksVzXSNiTV6cuZ+LyVZoNWPK07t7e+CaoL768UXq1PDHq7PIdLVXahEe6nwCJafE/ZzOgX3pG17IKc+qaswP49tWFP/tkUqa0gZGQDj8EPj/17IVj7gT9Fl+Nj7JrY4b7EZ7BHw==
x-ms-office365-filtering-correlation-id: df0bc8ec-a37d-4124-8be1-08d6539fbcec
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:HE1PR0701MB2745;
x-ms-traffictypediagnostic: HE1PR0701MB2745:
x-microsoft-antispam-prvs: <HE1PR0701MB2745ACF9809EC1928ACCC8AB88D70@HE1PR0701MB2745.eurprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231443)(11241501185)(806100)(944501410)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:HE1PR0701MB2745;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0701MB2745;
x-forefront-prvs: 086831DFB4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(136003)(366004)(396003)(189003)(199004)(54906003)(6116002)(3846002)(486006)(8676002)(8936002)(2906002)(81166006)(6436002)(81156014)(2616005)(14444005)(58126008)(110136005)(256004)(4326008)(476003)(26005)(6486002)(39060400002)(68736007)(305945005)(7736002)(316002)(11346002)(31696002)(71200400001)(71190400001)(86362001)(2201001)(186003)(446003)(64126003)(65826007)(229853002)(53546011)(106356001)(105586002)(6512007)(99286004)(14454004)(5660300001)(6506007)(386003)(66066001)(25786009)(97736004)(76176011)(65806001)(65956001)(2501003)(52116002)(478600001)(6246003)(36756003)(31686004)(102836004)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0701MB2745;H:HE1PR0701MB2729.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: mWQyM4bm6mgj/ib0iURrbx+aPhb3Sf3KPAi/RGBTLevZ/ae2WdtSymmFKaxRkdCxOQcEHcoB03XeNAbNF/gpNn9X4l4u/s9Xuw0sjqUOSscKRLoKYj8DhD6RPNF9WCT/2K1J5eGr08QWXQ6qd9gtllaPRlR60QD+U7QrCYC/B8pKYLCZNOkrQ/xNOOMwGfJl6BvFYzrlIUdK61DcM6IoYtiv9sRI929GPrTtj+wyUP/s3SgcYBwgnQghBzEejwNWlv/QffYs32gX0IWMh7qvmKP4hHdQUgY4i+3+oq9NfhUtedHsAqQ0pPLVnCFw7TWItdM1SRoPf2trw7TjZBfPbwpIMeURJgXQcVhuZz+mABU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <14E00832EAE7C5418B18E5F1080ED6D7@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df0bc8ec-a37d-4124-8be1-08d6539fbcec
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2018 13:04:45.8952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0701MB2745
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gVHVkb3IgYW5kIGFsbCwNCg0KT24gMjYvMTEvMjAxOCAxMzo0NSwgVHVkb3IuQW1iYXJ1
c0BtaWNyb2NoaXAuY29tIHdyb3RlOg0KPiBGcm9tOiBUdWRvciBBbWJhcnVzIDx0dWRvci5hbWJh
cnVzQG1pY3JvY2hpcC5jb20+DQo+IA0KPiBCRlBUIGFkdmVydGlzZXMgYWxsIHRoZSBlcmFzZSB0
eXBlcyBzdXBwb3J0ZWQgYnkgYWxsIHRoZSBwb3NzaWJsZQ0KPiBtYXAgY29uZmlndXJhdGlvbnMu
IE1hc2sgb3V0IHRoZSBlcmFzZSB0eXBlcyB0aGF0IGFyZSBub3Qgc3VwcG9ydGVkDQo+IGJ5IHRo
ZSBjdXJyZW50IG1hcCBjb25maWd1cmF0aW9uLg0KPiANCj4gQmFja3dhcmQgY29tcGF0aWJpbGl0
eSB0ZXN0IGRvbmUgb24gc3N0MjZ2ZjA2NGIuDQo+IA0KPiBGaXhlczogYjAzOGU4ZTNiZTcyICgi
bXRkOiBzcGktbm9yOiBwYXJzZSBTRkRQIFNlY3RvciBNYXAgUGFyYW1ldGVyIFRhYmxlIikNCj4g
UmVwb3J0ZWQtYnk6IEFsZXhhbmRlciBTdmVyZGxpbiA8YWxleGFuZGVyLnN2ZXJkbGluQG5va2lh
LmNvbT4NCg0KSSd2ZSB2ZXJpZmllZCB0aGUgZXJhc2VzaXplLCBwYXJ0aXRpb25pbmcgYW5kIGVy
YXNlIGZ1bmN0aW9uIG9mIHRoZSBTMjVGUzEyOFMNCmFuZCBhbGwgdGhlIGFib3ZlIGlzIGF0IGxl
YXN0IGJhY2sgdG8gcHJlLVNGRFAgc3RhdGUuDQoNClNvIHRoZSBwYXRjaCB3b3JrcyBhcyBpbnRl
bmRlZCBhbmQgaXQncw0KVGVzdGVkLWJ5OiBBbGV4YW5kZXIgU3ZlcmRsaW4gPGFsZXhhbmRlci5z
dmVyZGxpbkBub2tpYS5jb20+DQoNClRoZXJlIGlzIHN0aWxsIGEgcmVncmVzc2lvbiB3aXRoIHdy
aXRlIHdoZW4gUzI1RlMxMjhTIGlzIHVzZWQgd2l0aCBTRkRQDQpiZWNhdXNlIFNGRFAgb2YgdGhl
IFMyNUZTMTI4UyBpcyBqdXN0IGJyb2tlbi4gSXQgYWR2ZXJ0aXNlcyA1MTIgYnl0ZXMNCm9mIHdy
aXRlIHBhZ2Ugc2l6ZSBidXQgZmFjdG9yeSBkZWxpdmVyeSBjb25maWd1cmF0aW9uIHdyYXBzIHRo
ZSBhZGRyZXNzDQpvbiAyNTYgYnl0ZXMgYm91bmRhcnkuIEkgZm91bmQgbm8gd2F5IHRvIGZldGNo
IHRoaXMgY29uZmlndXJhdGlvbiBpbiBhDQp2ZW5kb3ItbmV1dHJhbCB3YXkgKG9yIEpFREVDLWNv
bmZvcm0gd2F5KS4gV2hpY2ggbWVhbnMsIFMyNUZTMTI4Uw0KY291bGQgYmUgdGhlIGZpcnN0IHVz
ZXIgb2YgU1BJX05PUl9TS0lQX1NGRFAgZmxhZyA6XA0KDQo+IFNpZ25lZC1vZmYtYnk6IFR1ZG9y
IEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbT4NCj4gLS0tDQo+IHYyOg0KPiAt
IGRyb3AgY29uc3QgcXVhbGlmaWVyDQo+IC0gdXBkYXRlIGNvbW1pdCBtZXNzYWdlIGFuZCBjb21t
ZW50DQo+IA0KPiAgZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMgfCAzMSArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9y
L3NwaS1ub3IuYyBiL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jDQo+IGluZGV4IDkzYzli
Yzg5MzFmYy4uMWZkZDI4MzRmYmNiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL210ZC9zcGktbm9y
L3NwaS1ub3IuYw0KPiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYw0KPiBAQCAt
Mjk5NSwxMiArMjk5NSwxMyBAQCBzdGF0aWMgaW50IHNwaV9ub3JfaW5pdF9ub25fdW5pZm9ybV9l
cmFzZV9tYXAoc3RydWN0IHNwaV9ub3IgKm5vciwNCj4gIAkJCQkJICAgICAgY29uc3QgdTMyICpz
bXB0KQ0KPiAgew0KPiAgCXN0cnVjdCBzcGlfbm9yX2VyYXNlX21hcCAqbWFwID0gJm5vci0+ZXJh
c2VfbWFwOw0KPiAtCWNvbnN0IHN0cnVjdCBzcGlfbm9yX2VyYXNlX3R5cGUgKmVyYXNlID0gbWFw
LT5lcmFzZV90eXBlOw0KPiArCXN0cnVjdCBzcGlfbm9yX2VyYXNlX3R5cGUgKmVyYXNlID0gbWFw
LT5lcmFzZV90eXBlOw0KPiAgCXN0cnVjdCBzcGlfbm9yX2VyYXNlX3JlZ2lvbiAqcmVnaW9uOw0K
PiAgCXU2NCBvZmZzZXQ7DQo+ICAJdTMyIHJlZ2lvbl9jb3VudDsNCj4gIAlpbnQgaSwgajsNCj4g
LQl1OCBlcmFzZV90eXBlLCB1bmlmb3JtX2VyYXNlX3R5cGU7DQo+ICsJdTggdW5pZm9ybV9lcmFz
ZV90eXBlLCBzYXZlX3VuaWZvcm1fZXJhc2VfdHlwZTsNCj4gKwl1OCBlcmFzZV90eXBlLCByZWdp
b25zX2VyYXNlX3R5cGU7DQo+ICANCj4gIAlyZWdpb25fY291bnQgPSBTTVBUX01BUF9SRUdJT05f
Q09VTlQoKnNtcHQpOw0KPiAgCS8qDQo+IEBAIC0zMDE0LDYgKzMwMTUsNyBAQCBzdGF0aWMgaW50
IHNwaV9ub3JfaW5pdF9ub25fdW5pZm9ybV9lcmFzZV9tYXAoc3RydWN0IHNwaV9ub3IgKm5vciwN
Cj4gIAltYXAtPnJlZ2lvbnMgPSByZWdpb247DQo+ICANCj4gIAl1bmlmb3JtX2VyYXNlX3R5cGUg
PSAweGZmOw0KPiArCXJlZ2lvbnNfZXJhc2VfdHlwZSA9IDA7DQo+ICAJb2Zmc2V0ID0gMDsNCj4g
IAkvKiBQb3B1bGF0ZSByZWdpb25zLiAqLw0KPiAgCWZvciAoaSA9IDA7IGkgPCByZWdpb25fY291
bnQ7IGkrKykgew0KPiBAQCAtMzAzMCwxMyArMzAzMiwzOCBAQCBzdGF0aWMgaW50IHNwaV9ub3Jf
aW5pdF9ub25fdW5pZm9ybV9lcmFzZV9tYXAoc3RydWN0IHNwaV9ub3IgKm5vciwNCj4gIAkJICov
DQo+ICAJCXVuaWZvcm1fZXJhc2VfdHlwZSAmPSBlcmFzZV90eXBlOw0KPiAgDQo+ICsJCS8qDQo+
ICsJCSAqIHJlZ2lvbnNfZXJhc2VfdHlwZSBtYXNrIHdpbGwgaW5kaWNhdGUgYWxsIHRoZSBlcmFz
ZSB0eXBlcw0KPiArCQkgKiBzdXBwb3J0ZWQgaW4gdGhpcyBjb25maWd1cmF0aW9uIG1hcC4NCj4g
KwkJICovDQo+ICsJCXJlZ2lvbnNfZXJhc2VfdHlwZSB8PSBlcmFzZV90eXBlOw0KPiArDQo+ICAJ
CW9mZnNldCA9IChyZWdpb25baV0ub2Zmc2V0ICYgflNOT1JfRVJBU0VfRkxBR1NfTUFTSykgKw0K
PiAgCQkJIHJlZ2lvbltpXS5zaXplOw0KPiAgCX0NCj4gIA0KPiArCXNhdmVfdW5pZm9ybV9lcmFz
ZV90eXBlID0gbWFwLT51bmlmb3JtX2VyYXNlX3R5cGU7DQo+ICAJbWFwLT51bmlmb3JtX2VyYXNl
X3R5cGUgPSBzcGlfbm9yX3NvcnRfZXJhc2VfbWFzayhtYXAsDQo+ICAJCQkJCQkJICB1bmlmb3Jt
X2VyYXNlX3R5cGUpOw0KPiAgDQo+ICsJaWYgKCFyZWdpb25zX2VyYXNlX3R5cGUpIHsNCj4gKwkJ
LyoNCj4gKwkJICogUm9sbCBiYWNrIHRvIHRoZSBwcmV2aW91cyB1bmlmb3JtX2VyYXNlX3R5cGUg
bWFzaywgU01QVCBpcw0KPiArCQkgKiBicm9rZW4uDQo+ICsJCSAqLw0KPiArCQltYXAtPnVuaWZv
cm1fZXJhc2VfdHlwZSA9IHNhdmVfdW5pZm9ybV9lcmFzZV90eXBlOw0KPiArCQlyZXR1cm4gLUVJ
TlZBTDsNCj4gKwl9DQo+ICsNCj4gKwkvKg0KPiArCSAqIEJGUFQgYWR2ZXJ0aXNlcyBhbGwgdGhl
IGVyYXNlIHR5cGVzIHN1cHBvcnRlZCBieSBhbGwgdGhlIHBvc3NpYmxlDQo+ICsJICogbWFwIGNv
bmZpZ3VyYXRpb25zLiBNYXNrIG91dCB0aGUgZXJhc2UgdHlwZXMgdGhhdCBhcmUgbm90IHN1cHBv
cnRlZA0KPiArCSAqIGJ5IHRoZSBjdXJyZW50IG1hcCBjb25maWd1cmF0aW9uLg0KPiArCSAqLw0K
PiArCWZvciAoaSA9IDA7IGkgPCBTTk9SX0VSQVNFX1RZUEVfTUFYOyBpKyspDQo+ICsJCWlmICgh
KHJlZ2lvbnNfZXJhc2VfdHlwZSAmIEJJVChlcmFzZVtpXS5pZHgpKSkNCj4gKwkJCXNwaV9ub3Jf
c2V0X2VyYXNlX3R5cGUoJmVyYXNlW2ldLCAwLCAweEZGKTsNCj4gKw0KPiAgCXNwaV9ub3JfcmVn
aW9uX21hcmtfZW5kKCZyZWdpb25baSAtIDFdKTsNCj4gIA0KPiAgCXJldHVybiAwOw0KDQotLSAN
CkJlc3QgcmVnYXJkcywNCkFsZXhhbmRlciBTdmVyZGxpbi4NCg==
