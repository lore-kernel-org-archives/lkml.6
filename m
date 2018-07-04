Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821F0C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AD1821917
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="cOaJsw2/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AD1821917
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933909AbeGDMDg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 08:03:36 -0400
Received: from mail-eopbgr00138.outbound.protection.outlook.com ([40.107.0.138]:49055
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933160AbeGDMDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 08:03:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+kANgbvSGUs1H7fCbYrrBF+6CyTshs0OonHQWydgaRk=;
 b=cOaJsw2/ciboGV2KMjYS+ac/HPVZbX+Pj9FekyaKZ5gz1ElQBp7vHHzyNW312Mv8IYYqLkpnpe7W4fodtRGamgis2354iXFz9qOTI4aP5hGk8OsxEkfMu4Rone+z8RxQH1qSV3y+uaTZFmSqfK4osOylNMlfWKS+bZTRR4Qsq6w=
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com (10.168.137.14) by
 VI1PR0501MB2381.eurprd05.prod.outlook.com (10.168.135.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.23; Wed, 4 Jul 2018 12:03:29 +0000
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::5570:f225:bd5b:1aa3]) by VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::5570:f225:bd5b:1aa3%10]) with mapi id 15.20.0906.026; Wed, 4 Jul 2018
 12:03:29 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "lee.jones@linaro.org" <lee.jones@linaro.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "ldewangan@nvidia.com" <ldewangan@nvidia.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2] mfd: as3722: disable auto power on when AC OK
Thread-Topic: [PATCH v2] mfd: as3722: disable auto power on when AC OK
Thread-Index: AQHUEt8lf8EHBdK0IkayWBFmCV5bvaR+sgsAgABGPoA=
Date:   Wed, 4 Jul 2018 12:03:29 +0000
Message-ID: <1530705807.13209.44.camel@toradex.com>
References: <20180703150411.29709-1-marcel@ziswiler.com>
         <20180704075202.GQ20176@dell>
In-Reply-To: <20180704075202.GQ20176@dell>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0501MB2381;7:T7CsjCY7VxU73PdfUz2IkXTvNfokjwIP7VWXcfNu+aBxWvnwdM1O8XiYCRPP95yBbsmfNTczttDJJKgZAoS4+JrTndV3D9eRKgM839+E+4+zjD/jnzKeKKLOpz9kjWYjttmCWgsiVokhQPkv/FRaa0alErqHb7lnqx3fUhwjMdclsq1pZLLUxKnUc2dPrUYuNTtVQlWByx6KepjKgoARMK9+O3cR8qUVP8aOqTKiqMBZqSL4jmzsj5t8Rn3ACn4P
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 63202ff3-687c-4cb2-55d5-08d5e1a62811
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2381;
x-ms-traffictypediagnostic: VI1PR0501MB2381:
x-microsoft-antispam-prvs: <VI1PR0501MB23819A43029A01AF10FD3FBEFB410@VI1PR0501MB2381.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(18589796830644)(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:VI1PR0501MB2381;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB2381;
x-forefront-prvs: 0723A02764
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(39840400004)(366004)(346002)(376002)(189003)(199004)(2351001)(14454004)(66066001)(478600001)(36756003)(6916009)(5660300001)(3846002)(7736002)(103116003)(68736007)(6436002)(5640700003)(6116002)(44832011)(2501003)(97736004)(2616005)(6486002)(305945005)(446003)(476003)(6512007)(229853002)(486006)(11346002)(53936002)(26005)(6506007)(99286004)(102836004)(186003)(4326008)(6246003)(256004)(14444005)(25786009)(2900100001)(5250100002)(575784001)(86362001)(105586002)(316002)(106356001)(54906003)(2906002)(8936002)(76176011)(81156014)(81166006)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0501MB2381;H:VI1PR0501MB2590.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: UPq4jfNnYeO5OT6hxGBpO/2uBl+MyxTl8x5YZ/8ANyEaeozYQfwBkKsfdFesJTSLSmC1nRFS5H1TP22BzmgTwQmM9GJA6LZJMYUttMqzFgQ+NfYnO28ZPq42rGclvqGocfyFoeFcVlxMb0bCONCkyHmx8jECBNr9lbowFHS9xLR6srfMliDQR3jweiZj1q5ryl0pETVW120jhmW83ZjKriG3BWG6dEzeIUigaUY5ekS7G3Y7gPADSP6oqkO1OJ7kCsDwytnwjN12GGeI1fFDYfNrcMC2zCFvdtgtYTrtMrb2cal4wIOLMq6U0rNkriMr+/d64tPciqPwAq8JZMC8tBI86wLi3j1uA7LAbjxX77c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <75817DF6228CC840B9622624905C6388@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63202ff3-687c-4cb2-55d5-08d5e1a62811
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2018 12:03:29.4507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2381
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE4LTA3LTA0IGF0IDA4OjUyICswMTAwLCBMZWUgSm9uZXMgd3JvdGU6DQo+IE9u
IFR1ZSwgMDMgSnVsIDIwMTgsIE1hcmNlbCBaaXN3aWxlciB3cm90ZToNCj4gDQo+ID4gRnJvbTog
TWFyY2VsIFppc3dpbGVyIDxtYXJjZWwuemlzd2lsZXJAdG9yYWRleC5jb20+DQo+ID4gDQo+ID4g
T24gYW1zIEFTMzcyMiwgcG93ZXIgb24gd2hlbiBBQyBPSyBpcyBlbmFibGVkIGJ5IGRlZmF1bHQu
DQo+ID4gTWFraW5nIHRoaXMgb3B0aW9uIGFzIGRpc2FibGUgYnkgZGVmYXVsdCBhbmQgZW5hYmxl
IG9ubHkNCj4gPiB3aGVuIHBsYXRmb3JtIG5lZWQgdGhpcyBleHBsaWNpdGx5Lg0KPiA+IA0KPiA+
IFNpZ25lZC1vZmYtYnk6IExheG1hbiBEZXdhbmdhbiA8bGRld2FuZ2FuQG52aWRpYS5jb20+DQo+
ID4gUmV2aWV3ZWQtYnk6IEJpYmVrIEJhc3UgPGJiYXN1QG52aWRpYS5jb20+DQo+ID4gVGVzdGVk
LWJ5OiBCaWJlayBCYXN1IDxiYmFzdUBudmlkaWEuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE1h
cmNlbCBaaXN3aWxlciA8bWFyY2VsLnppc3dpbGVyQHRvcmFkZXguY29tPg0KPiA+IA0KPiA+IC0t
LQ0KPiA+IA0KPiA+IENoYW5nZXMgaW4gdjI6DQo+ID4gLSBEb2N1bWVudCBkZXZpY2UgdHJlZSBw
cm9wZXJ0eSBhcyBzdWdnZXN0ZWQgYnkgU3RlZmFuLg0KPiA+IC0gUmVuYW1lIFNFUTEgdG8gU0VR
VTEgYXMgcGVyIGRhdGFzaGVldCBhcyBzdWdnZXN0ZWQgYnkgU3RlZmFuLg0KPiA+IC0gRHJvcCBy
ZWZlcmVuY2UgdG8gZG93bnN0cmVhbSBjb21taXQgYXMgc3VnZ2VzdGVkIGJ5IExlZS4NCj4gPiAN
Cj4gPiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9hczM3MjIudHh0IHwg
IDIgKysNCj4gPiAgZHJpdmVycy9tZmQvYXMzNzIyLmMgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHwgMTIgKysrKysrKysrKysrDQo+ID4gIGluY2x1ZGUvbGludXgvbWZkL2FzMzcyMi5oICAg
ICAgICAgICAgICAgICAgICAgICB8ICAzICsrKw0KPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDE3IGlu
c2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL21mZC9hczM3MjIudHh0DQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvbWZkL2FzMzcyMi50eHQNCj4gPiBpbmRleCA1Mjk3YjIyMTA3MDQuLjJhNjY1
NzQxZDdmZSAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvbWZkL2FzMzcyMi50eHQNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvbWZkL2FzMzcyMi50eHQNCj4gPiBAQCAtMjAsNiArMjAsOCBAQCBPcHRpb25hbCBwcm9w
ZXJ0aWVzOg0KPiA+ICAtIGFtcyxlbmFibGUtaW50ZXJuYWwtaTJjLXB1bGx1cDogQm9vbGVhbiBw
cm9wZXJ0eSwgdG8gZW5hYmxlDQo+ID4gaW50ZXJuYWwgcHVsbHVwIG9uDQo+ID4gIAlpMmMgc2Ns
L3NkYSBwaW5zLiBNaXNzaW5nIHRoaXMgd2lsbCBkaXNhYmxlIGludGVybmFsDQo+ID4gcHVsbHVw
IG9uIGkyYw0KPiA+ICAJc2NsL3NkYSBsaW5lcy4NCj4gPiArLSBhbXMsZW5hYmxlLWFjLW9rLXBv
d2VyLW9uOiBCb29sZWFuIHByb3BlcnR5LCB0byBlbmFibGUgZXhpdCBvdXQNCj4gPiBvZiBwb3dl
ciBvZmYNCj4gPiArCW1vZGUgd2l0aCBBQ19PSyBwaW4gKHBpbiBlbmFibGVkIGluIHBvd2VyIG9m
ZiBtb2RlKS4NCj4gDQo+IFRoaXMgbmVlZHMgYSBEVCBBY2suDQoNClllcywgY2VydGFpbmx5LiBU
aGF0J3Mgd2h5IEkgQ0MnZCB0aGUgZGV2aWNlIHRyZWUgbWFpbGluZyBsaXN0IGFzIHdlbGwNCmFz
IE1yLiBIZXJyaW5nIGhpbXNlbGYuDQoNCj4gPiAgT3B0aW9uYWwgc3VibW9kdWxlIGFuZCB0aGVp
ciBwcm9wZXJ0aWVzOg0KPiA+ICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT0NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZmQvYXMzNzIyLmMgYi9kcml2ZXJzL21mZC9h
czM3MjIuYw0KPiA+IGluZGV4IGY4NzM0MmMyMTFiYy4uNGQwNjllZDIxZmY2IDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvbWZkL2FzMzcyMi5jDQo+ID4gKysrIGIvZHJpdmVycy9tZmQvYXMzNzIy
LmMNCj4gPiBAQCAtMzQ5LDYgKzM0OSw4IEBAIHN0YXRpYyBpbnQgYXMzNzIyX2kyY19vZl9wcm9i
ZShzdHJ1Y3QNCj4gPiBpMmNfY2xpZW50ICppMmMsDQo+ID4gIAkJCQkJImFtcyxlbmFibGUtaW50
ZXJuYWwtaW50LQ0KPiA+IHB1bGx1cCIpOw0KPiA+ICAJYXMzNzIyLT5lbl9pbnRlcm5faTJjX3B1
bGx1cCA9IG9mX3Byb3BlcnR5X3JlYWRfYm9vbChucCwNCj4gPiAgCQkJCQkiYW1zLGVuYWJsZS1p
bnRlcm5hbC1pMmMtDQo+ID4gcHVsbHVwIik7DQo+ID4gKwlhczM3MjItPmVuX2FjX29rX3B3cl9v
biA9IG9mX3Byb3BlcnR5X3JlYWRfYm9vbChucCwNCj4gPiArCQkJCQkiYW1zLGVuYWJsZS1hYy1v
ay1wb3dlci0NCj4gPiBvbiIpOw0KPiA+ICAJYXMzNzIyLT5pcnFfZmxhZ3MgPSBpcnFkX2dldF90
cmlnZ2VyX3R5cGUoaXJxX2RhdGEpOw0KPiA+ICAJZGV2X2RiZygmaTJjLT5kZXYsICJJUlEgZmxh
Z3MgYXJlIDB4JTA4bHhcbiIsIGFzMzcyMi0NCj4gPiA+aXJxX2ZsYWdzKTsNCj4gPiAgCXJldHVy
biAwOw0KPiA+IEBAIC0zNjAsNiArMzYyLDcgQEAgc3RhdGljIGludCBhczM3MjJfaTJjX3Byb2Jl
KHN0cnVjdCBpMmNfY2xpZW50DQo+ID4gKmkyYywNCj4gPiAgCXN0cnVjdCBhczM3MjIgKmFzMzcy
MjsNCj4gPiAgCXVuc2lnbmVkIGxvbmcgaXJxX2ZsYWdzOw0KPiA+ICAJaW50IHJldDsNCj4gPiAr
CXU4IHZhbCA9IDA7DQo+ID4gIA0KPiA+ICAJYXMzNzIyID0gZGV2bV9remFsbG9jKCZpMmMtPmRl
diwgc2l6ZW9mKHN0cnVjdCBhczM3MjIpLA0KPiA+IEdGUF9LRVJORUwpOw0KPiA+ICAJaWYgKCFh
czM3MjIpDQo+ID4gQEAgLTM5OCw2ICs0MDEsMTUgQEAgc3RhdGljIGludCBhczM3MjJfaTJjX3By
b2JlKHN0cnVjdCBpMmNfY2xpZW50DQo+ID4gKmkyYywNCj4gPiAgCWlmIChyZXQgPCAwKQ0KPiA+
ICAJCXJldHVybiByZXQ7DQo+ID4gIA0KPiA+ICsJaWYgKGFzMzcyMi0+ZW5fYWNfb2tfcHdyX29u
KQ0KPiA+ICsJCXZhbCA9IEFTMzcyMl9DVFJMX1NFUVUxX0FDX09LX1BXUl9PTjsNCj4gPiArCXJl
dCA9IGFzMzcyMl91cGRhdGVfYml0cyhhczM3MjIsIEFTMzcyMl9DVFJMX1NFUVUxX1JFRywNCj4g
PiArCQkJQVMzNzIyX0NUUkxfU0VRVTFfQUNfT0tfUFdSX09OLCB2YWwpOw0KPiANCj4gV2hhdCBp
cyB0aGUgZGVmYXVsdCB2YWx1ZT8NCg0KWWVzLCBzb3JyeS4gSSBxdWVzcyBpdCBtYXkgbm90IGJl
IGNvbXBsZXRlbHkgY2xlYXIgZnJvbSBMYXhtYW4ncw0Kb3JpZ2luYWwgY29tbWl0IG1lc3NhZ2Uu
DQoNCj4gSWYgMCwgeW91IGNvdWxkIHBsYWNlIGFsbCBvZiB0aGlzIGNvZGUgaW5zaWRlIHRoZSAi
aWYNCj4gKGFzMzcyMi0+ZW5fYWNfb2tfcHdyX29uKSIgYW5kIHNhdmUgb24gYSBmZXcgdW5uZWNl
c3NhcnkgY3ljbGVzLg0KDQpVbmZvcnR1bmF0ZWx5LCBpdCBpcyBub3QgcXVpdGUgdGhhdCBzaW1w
bGUuIFdoaWxlIHRoZSBoYXJkd2FyZSBkZWZhdWx0DQp3b3VsZCBhY3R1YWxseSBiZSBvbiBhdCBs
ZWFzdCBKZXRzb24gVEsxIGFzIHdlbGwgYXMgVG9yYWRleCBBcGFsaXMgVEsxDQpkbyBub3Qgd29y
ayB0aGF0IHdheS4gVGhlcmVmb3JlLCBteSAocmVzcC4gTGF4bWFuJ3MpIHByb3Bvc2VkIHdheSBv
Zg0KaGFuZGxpbmcgdGhpcyB3YXMvaXMgZm9yIHRoZSBkZWZhdWx0IHRvIGJlIG9mZiBhbmQgYW55
Ym9keSByZWFsbHkNCnJlcXVpcmluZyBpdCB0byBiZSBvbiBoYXZpbmcgdG8gZG8gc28gdmlhIGFk
ZGluZyB0aGlzIGRldmljZSB0cmVlDQpwcm9wZXJ0eS4gSSBhZG1pdCB0aGF0IHRoaXMgbWF5IGJl
IHBlcmNlaXZlZCBhcyBhIGJlaGF2aW91cmFsIGNoYW5nZQ0KaG93ZXZlciBhcyBtZW50aW9uZWQg
YWJvdmUgYXQgbGVhc3Qgb24gSmV0c29uIFRLMSBhcyB3ZWxsIGFzIFRvcmFkZXgNCkFwYWxpcyBU
SzEgdGhpcyByZWFsbHkgZml4ZXMgcG93ZXJvZmYgd2hpY2ggb3RoZXJ3aXNlIGltbWVkaWF0ZWx5
DQpwb3dlcmVkIG9uIGFnYWluLiBTbyB0aGlzIGlzIHJlYWxseSBhIGJ1ZyBmaXguIEkgbWF5IGlu
Y2x1ZGUgc29tZSBtb3JlDQppbmZvcm1hdGlvbiBpbiB0aGUgY29tbWl0IG1lc3NhZ2UgaWYgcmVx
dWVzdGVkLg0KDQpNYXliZSBzb21lYm9keSBmcm9tIE5WSURJQSBjb3VsZCBhbHNvIGNvbW1lbnQg
b24gd2hldGhlciBvciBub3QgdGhpcyBpcw0KcmVhbGx5IGEgZ29vZCBpZGVhIG9yIGhvdyB0aGV5
IHdvdWxkIGV4cGVjdCB0aGluZ3MgdG8gd29yay4gQW55Ym9keT8NCg0KPiA+ICsJaWYgKHJldCA8
IDApIHsNCj4gPiArCQlkZXZfZXJyKGFzMzcyMi0+ZGV2LCAiQ1RSTHNlcXUxIHVwZGF0ZSBmYWls
ZWQ6DQo+ID4gJWRcbiIsIHJldCk7DQo+ID4gKwkJcmV0dXJuIHJldDsNCj4gPiArCX0NCj4gPiAr
DQo+ID4gIAlyZXQgPSBkZXZtX21mZF9hZGRfZGV2aWNlcygmaTJjLT5kZXYsIC0xLCBhczM3MjJf
ZGV2cywNCj4gPiAgCQkJCSAgIEFSUkFZX1NJWkUoYXMzNzIyX2RldnMpLCBOVUxMLA0KPiA+IDAs
DQo+ID4gIAkJCQkgICByZWdtYXBfaXJxX2dldF9kb21haW4oYXMzNzIyLQ0KPiA+ID5pcnFfZGF0
YSkpOw0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21mZC9hczM3MjIuaA0KPiA+IGIv
aW5jbHVkZS9saW51eC9tZmQvYXMzNzIyLmgNCj4gPiBpbmRleCA1MWU2Zjk0MTQ1NzUuLmI0MDRh
NWFmOWJiYSAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L21mZC9hczM3MjIuaA0KPiA+
ICsrKyBiL2luY2x1ZGUvbGludXgvbWZkL2FzMzcyMi5oDQo+ID4gQEAgLTI5Niw2ICsyOTYsOCBA
QA0KPiA+ICAjZGVmaW5lIEFTMzcyMl9BREMxX0NPTlZfTk9UUkVBRFkJCQlCSVQoNykNCj4gPiAg
I2RlZmluZSBBUzM3MjJfQURDMV9TT1VSQ0VfU0VMRUNUX01BU0sJCQkweDFGDQo+ID4gIA0KPiA+
ICsjZGVmaW5lIEFTMzcyMl9DVFJMX1NFUVUxX0FDX09LX1BXUl9PTgkJCUJJVCgNCj4gPiAwKQ0K
PiA+ICsNCj4gPiAgLyogR1BJTyBtb2RlcyAqLw0KPiA+ICAjZGVmaW5lIEFTMzcyMl9HUElPX01P
REVfTUFTSwkJCQkweDA3DQo+ID4gICNkZWZpbmUgQVMzNzIyX0dQSU9fTU9ERV9JTlBVVAkJCQkw
eDAwDQo+ID4gQEAgLTM5MSw2ICszOTMsNyBAQCBzdHJ1Y3QgYXMzNzIyIHsNCj4gPiAgCXVuc2ln
bmVkIGxvbmcgaXJxX2ZsYWdzOw0KPiA+ICAJYm9vbCBlbl9pbnRlcm5faW50X3B1bGx1cDsNCj4g
PiAgCWJvb2wgZW5faW50ZXJuX2kyY19wdWxsdXA7DQo+ID4gKwlib29sIGVuX2FjX29rX3B3cl9v
bjsNCj4gPiAgCXN0cnVjdCByZWdtYXBfaXJxX2NoaXBfZGF0YSAqaXJxX2RhdGE7DQo+ID4gIH07
