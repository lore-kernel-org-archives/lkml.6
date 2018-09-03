Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1E6C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 21:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31CA520862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 21:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="IgJrNebR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31CA520862
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbeIDB2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 21:28:07 -0400
Received: from mail-eopbgr20137.outbound.protection.outlook.com ([40.107.2.137]:47872
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725947AbeIDB2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 21:28:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MO6EqHC//udl15SREWztDhRHHNAqgzY5QF7ktaAOexA=;
 b=IgJrNebRAxroop17AKAs8MyNNMDbiHpp/e3/JpfnLL32ota9HmHxXuY7IkTEV2EhGru9NXulzk+i4MRjbMgThULKj38T85y/Bz6nzlOwxDy9fCRyJKoisb694sAGRg8WUchEpoI8b1aMEDie80T7AO4PwEBOgBV1o7tblSYmobk=
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com (10.168.137.14) by
 VI1PR0501MB2542.eurprd05.prod.outlook.com (10.168.136.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.17; Mon, 3 Sep 2018 21:06:02 +0000
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::79d0:3e0b:20af:4bb]) by VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::79d0:3e0b:20af:4bb%8]) with mapi id 15.20.1101.016; Mon, 3 Sep 2018
 21:06:02 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "digetx@gmail.com" <digetx@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 09/19] memory: tegra: Adapt to Tegra20 device-tree
 binding changes
Thread-Topic: [PATCH v3 09/19] memory: tegra: Adapt to Tegra20 device-tree
 binding changes
Thread-Index: AQHUQ8nrnpWhkV+mCkO6HfUxwPAryA==
Date:   Mon, 3 Sep 2018 21:06:01 +0000
Message-ID: <1536008759.25080.2.camel@toradex.com>
References: <20180818155430.5586-1-digetx@gmail.com>
         <20180818155430.5586-10-digetx@gmail.com>
In-Reply-To: <20180818155430.5586-10-digetx@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [89.217.215.226]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0501MB2542;6:q9ded0FE1PDhitWcu8bLzokgNm8M94HgnPMWBWMc0PrHyVrgTpMb+DJY1cF0xgrgIV/Yb4bo3l8rqAs0D8HdCz8rSSmCGj3sCyo4sj8r9q0Zko1YTla4c4wiLDnUhvHviR+EtJ0G7OggT2QHV5zxQ9L2ImvnhwbQJojn9vLkN0HNcRgH9Kve9j6fH2y7Khee6H74cl9jA43xwfYOQhFC0MihhYE/x0KOzgRAxQGKGmOdcitdIS/bK/56GVP4IECCY9nVfsy19rvrjH1uWBDxflWnPqOYnvTWGfVuKmYPSuC41e/zokZL+C1IClndQO0DHZ0RVxz0YPUabr9dhh1DZ2vQPGfnWEKwLFyAWTtazwXdTksOLtiACUXx0S6WSBe42ZDMb9XdzfpYtoAapf18k1sCHdagvZj8/sxa43j67Bc+3zdJfdRzmZhRKNmyhTeERYUn5kQV13mJ1RFH7l6Q+A==;5:A6VR5flwFhF1Zm78nftwmX474LU9j72NG/0I8GrVFeGk3cI55ZJ2sPWkuj9A1AInaFcSoly4bdyLyjTya0zmkU/6NSntxGE9JOgHe0ZRp5H+V13CDByLZozrESHRtCV8cMkMJzDYLSeV/sZ1LuFP1DswDEh2fxhjBtZ0hswrvG4=;7:WVh2HPQqVnM3ToipmJw3Q0An1fjDSbI8qo0jCQnCt5NxlB+qrzNr56ihmJKXndPWlfWx9tzW6ZDNRgcT7GmVAe3Z70W7PglFjDNrLrzAz6/FN9Do8NY9ckCQIcA9YOPh5dPXJNfaKoL09nqhFaLN47shLgCJMDOMtyPRYzL/wZtaQ4NWlS9Rl96l+VdVgGXRf+icIL3YgK98Z7KTZcqWT6FrGRk4T77RLGvYy7g7EvnKRqkTT4B5aeaPKexlAN9F
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: cc5d440e-8d5f-4b56-e551-08d611e10e11
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2542;
x-ms-traffictypediagnostic: VI1PR0501MB2542:
x-microsoft-antispam-prvs: <VI1PR0501MB2542AEB0A443357407891B43FB0C0@VI1PR0501MB2542.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(201708071742011)(7699016);SRVR:VI1PR0501MB2542;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB2542;
x-forefront-prvs: 0784C803FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(136003)(376002)(396003)(346002)(39840400004)(366004)(189003)(199004)(53936002)(6512007)(316002)(110136005)(2501003)(2201001)(14454004)(76176011)(478600001)(7416002)(5250100002)(102836004)(6506007)(103116003)(8676002)(305945005)(105586002)(86362001)(7736002)(26005)(68736007)(446003)(6116002)(3846002)(36756003)(476003)(2616005)(11346002)(486006)(229853002)(256004)(66066001)(97736004)(6246003)(6486002)(6436002)(99286004)(8936002)(106356001)(5660300001)(39060400002)(2900100001)(81166006)(81156014)(25786009)(4326008)(2906002)(186003)(54906003)(44832011)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0501MB2542;H:VI1PR0501MB2590.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: cKkEMxqTf1rMD44KIEV2nTGoRPTjF6y9VwMq6HYPJRN5bwzqutxrGayK9Ojpes1vaXLMDu+Gvx8vviA0h2OuXOn7wxZYoxq0ocz0MEPqOkX21/+/QBA36p7kVXKulPEJewDAxERhoKoLCjyPNpScJR9wb8R/xrqk83eFu+O+qmJYyHCAHWgsI+pSwg3hVrI2gf47lnOvBv+4zdtj01TEvW46NnmPfPhbiESPvYTXtdxOcuy86930mALpWJZelsIRP/xzg7bLSXIqi0swhwT/CO5G8mrEmsBbdmzr/nq3XjP3s+IFsdKA7lPIk88v9t/xVwvMh4AOSBw7AVZhzXA6OwggDPt0Udcg38+FjoDCiFY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E996DE64F62884590CB2AD3355722AE@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc5d440e-8d5f-4b56-e551-08d611e10e11
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2018 21:06:01.8996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2542
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDE4LTA4LTE4IGF0IDE4OjU0ICswMzAwLCBEbWl0cnkgT3NpcGVua28gd3JvdGU6
DQo+IFRoZSB0ZWdyYTIwLW1jIERUIGJpbmRpbmcgaGFzIGJlZW4gY2hhbmdlZCwgR0FSVCBoYXMg
YmVlbiBzcXVhc2hlZA0KPiBpbnRvIE1lbW9yeSBDb250cm9sbGVyIGFuZCBub3cgdGhlIGNsb2Nr
IHByb3BlcnR5IGlzIG1hbmRhdG9yeSBmb3INCj4gVGVncmEyMC4gQWRhcHQgZHJpdmVyIHRoZSB0
byBEVCBjaGFuZ2VzLg0KDQpNaW5vciBuaXRwaWNrIGNvbmNlcm5pbmcgdGhlIGNvbW1pdCBtZXNz
YWdlOg0KDQpBZGFwdCBkcml2ZXIgdG8gdGhlIERUIGNoYW5nZXMuDQoNCj4gU2lnbmVkLW9mZi1i
eTogRG1pdHJ5IE9zaXBlbmtvIDxkaWdldHhAZ21haWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMv
bWVtb3J5L3RlZ3JhL21jLmMgfCAxOSArKysrKysrLS0tLS0tLS0tLS0tDQo+ICBkcml2ZXJzL21l
bW9yeS90ZWdyYS9tYy5oIHwgIDYgLS0tLS0tDQo+ICBpbmNsdWRlL3NvYy90ZWdyYS9tYy5oICAg
IHwgIDIgKy0NCj4gIDMgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAxOSBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21lbW9yeS90ZWdyYS9tYy5jIGIvZHJp
dmVycy9tZW1vcnkvdGVncmEvbWMuYw0KPiBpbmRleCBlNTY4NjI0OTVmMzYuLjNiZjMxMzg3Njlm
NCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tZW1vcnkvdGVncmEvbWMuYw0KPiArKysgYi9kcml2
ZXJzL21lbW9yeS90ZWdyYS9tYy5jDQo+IEBAIC02MzgsMjQgKzYzOCwxOSBAQCBzdGF0aWMgaW50
IHRlZ3JhX21jX3Byb2JlKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJaWYg
KElTX0VSUihtYy0+cmVncykpDQo+ICAJCXJldHVybiBQVFJfRVJSKG1jLT5yZWdzKTsNCj4gIA0K
PiArCW1jLT5jbGsgPSBkZXZtX2Nsa19nZXQoJnBkZXYtPmRldiwgIm1jIik7DQo+ICsJaWYgKElT
X0VSUihtYy0+Y2xrKSkgew0KPiArCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJmYWlsZWQgdG8gZ2V0
IE1DIGNsb2NrOiAlbGRcbiIsDQo+ICsJCQlQVFJfRVJSKG1jLT5jbGspKTsNCj4gKwkJcmV0dXJu
IFBUUl9FUlIobWMtPmNsayk7DQo+ICsJfQ0KPiArDQo+ICAjaWZkZWYgQ09ORklHX0FSQ0hfVEVH
UkFfMnhfU09DDQo+ICAJaWYgKG1jLT5zb2MgPT0gJnRlZ3JhMjBfbWNfc29jKSB7DQo+IC0JCXJl
cyA9IHBsYXRmb3JtX2dldF9yZXNvdXJjZShwZGV2LCBJT1JFU09VUkNFX01FTSwNCj4gMSk7DQo+
IC0JCW1jLT5yZWdzMiA9IGRldm1faW9yZW1hcF9yZXNvdXJjZSgmcGRldi0+ZGV2LCByZXMpOw0K
PiAtCQlpZiAoSVNfRVJSKG1jLT5yZWdzMikpDQo+IC0JCQlyZXR1cm4gUFRSX0VSUihtYy0+cmVn
czIpOw0KPiAtDQo+ICAJCWlzciA9IHRlZ3JhMjBfbWNfaXJxOw0KPiAgCX0gZWxzZQ0KPiAgI2Vu
ZGlmDQo+ICAJew0KPiAtCQltYy0+Y2xrID0gZGV2bV9jbGtfZ2V0KCZwZGV2LT5kZXYsICJtYyIp
Ow0KPiAtCQlpZiAoSVNfRVJSKG1jLT5jbGspKSB7DQo+IC0JCQlkZXZfZXJyKCZwZGV2LT5kZXYs
ICJmYWlsZWQgdG8gZ2V0IE1DIGNsb2NrOg0KPiAlbGRcbiIsDQo+IC0JCQkJUFRSX0VSUihtYy0+
Y2xrKSk7DQo+IC0JCQlyZXR1cm4gUFRSX0VSUihtYy0+Y2xrKTsNCj4gLQkJfQ0KPiAtDQo+ICAJ
CWVyciA9IHRlZ3JhX21jX3NldHVwX2xhdGVuY3lfYWxsb3dhbmNlKG1jKTsNCj4gIAkJaWYgKGVy
ciA8IDApIHsNCj4gIAkJCWRldl9lcnIoJnBkZXYtPmRldiwgImZhaWxlZCB0byBzZXR1cCBsYXRl
bmN5DQo+IGFsbG93YW5jZTogJWRcbiIsDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21lbW9yeS90
ZWdyYS9tYy5oIGIvZHJpdmVycy9tZW1vcnkvdGVncmEvbWMuaA0KPiBpbmRleCAwMTA2NWYxMmVi
ZWIuLjk4NTZmMDg1ZTQ4NyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tZW1vcnkvdGVncmEvbWMu
aA0KPiArKysgYi9kcml2ZXJzL21lbW9yeS90ZWdyYS9tYy5oDQo+IEBAIC0yNiwxOCArMjYsMTIg
QEANCj4gIA0KPiAgc3RhdGljIGlubGluZSB1MzIgbWNfcmVhZGwoc3RydWN0IHRlZ3JhX21jICpt
YywgdW5zaWduZWQgbG9uZw0KPiBvZmZzZXQpDQo+ICB7DQo+IC0JaWYgKG1jLT5yZWdzMiAmJiBv
ZmZzZXQgPj0gMHgyNCkNCj4gLQkJcmV0dXJuIHJlYWRsKG1jLT5yZWdzMiArIG9mZnNldCAtIDB4
M2MpOw0KPiAtDQo+ICAJcmV0dXJuIHJlYWRsKG1jLT5yZWdzICsgb2Zmc2V0KTsNCj4gIH0NCj4g
IA0KPiAgc3RhdGljIGlubGluZSB2b2lkIG1jX3dyaXRlbChzdHJ1Y3QgdGVncmFfbWMgKm1jLCB1
MzIgdmFsdWUsDQo+ICAJCQkgICAgIHVuc2lnbmVkIGxvbmcgb2Zmc2V0KQ0KPiAgew0KPiAtCWlm
IChtYy0+cmVnczIgJiYgb2Zmc2V0ID49IDB4MjQpDQo+IC0JCXJldHVybiB3cml0ZWwodmFsdWUs
IG1jLT5yZWdzMiArIG9mZnNldCAtIDB4M2MpOw0KPiAtDQo+ICAJd3JpdGVsKHZhbHVlLCBtYy0+
cmVncyArIG9mZnNldCk7DQo+ICB9DQo+ICANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvc29jL3Rl
Z3JhL21jLmggYi9pbmNsdWRlL3NvYy90ZWdyYS9tYy5oDQo+IGluZGV4IGI0M2YzN2ZlYTA5Ni4u
ZGI1YmZkZjU4OWI0IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL3NvYy90ZWdyYS9tYy5oDQo+ICsr
KyBiL2luY2x1ZGUvc29jL3RlZ3JhL21jLmgNCj4gQEAgLTE0NCw3ICsxNDQsNyBAQCBzdHJ1Y3Qg
dGVncmFfbWNfc29jIHsNCj4gIHN0cnVjdCB0ZWdyYV9tYyB7DQo+ICAJc3RydWN0IGRldmljZSAq
ZGV2Ow0KPiAgCXN0cnVjdCB0ZWdyYV9zbW11ICpzbW11Ow0KPiAtCXZvaWQgX19pb21lbSAqcmVn
cywgKnJlZ3MyOw0KPiArCXZvaWQgX19pb21lbSAqcmVnczsNCj4gIAlzdHJ1Y3QgY2xrICpjbGs7
DQo+ICAJaW50IGlycTs=
