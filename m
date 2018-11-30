Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B61C04EB9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 01:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B4272082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 01:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="d4HzOJt+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B4272082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbeK3MVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 07:21:54 -0500
Received: from mail-eopbgr20054.outbound.protection.outlook.com ([40.107.2.54]:55899
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726393AbeK3MVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 07:21:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWtM9940ePISV+xZidPZSFJFsqUsOAZ0c7In9K5uETM=;
 b=d4HzOJt+Du2eQZ+9CBK3WDHUOYgiSrAo6qZn3MJwiogN0opN7QnxSWxojYl87frkTcGoH5SgwMI/nbwpt/duUadh32DAOnHj5IHdz4y0L4pexCc6U4TuGaD6T7DaPLyMEBr7b81MMscdmgqSdh8w32EKn0lnBosko1elfw+jLyY=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3833.eurprd04.prod.outlook.com (52.134.67.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.21; Fri, 30 Nov 2018 01:11:23 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%2]) with mapi id 15.20.1361.019; Fri, 30 Nov 2018
 01:11:22 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Eduardo Valentin <edubezval@gmail.com>
CC:     "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Aisheng DONG <aisheng.dong@nxp.com>,
        Andy Gross <andy.gross@linaro.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "LW@KARO-electronics.de" <LW@KARO-electronics.de>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V4 4/4] ARM64: dts: imx: add i.MX8QXP thermal support
Thread-Topic: [PATCH V4 4/4] ARM64: dts: imx: add i.MX8QXP thermal support
Thread-Index: AQHUh4yD0j4a4gnKUE+WHik1QQ7rHKVm+DmAgACLdvA=
Date:   Fri, 30 Nov 2018 01:11:22 +0000
Message-ID: <DB3PR0402MB39165F272CF5417E2D4C2F24F5D30@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1543458696-4741-1-git-send-email-Anson.Huang@nxp.com>
 <1543458696-4741-5-git-send-email-Anson.Huang@nxp.com>
 <20181129165040.GD2688@localhost.localdomain>
In-Reply-To: <20181129165040.GD2688@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3833;6:fXRquUUCA2HMN4wPHUqR/MBJVEFK7o1wQ4iakAgatve9UfaGx5eK29apfOwA7K7Uq7w0BkcJKw4zwgGu0BpzeJ/tJRE9u1S48G4i4F0FLlrzZadnrXQKdzOx6F68lqE93iH5q1qy1bONVXZwFV7ACdx4rWtgdfTRB1gB4PINdQuTo/E4hOS9cgECkKQcoVCkC2u3BoXdx3l5WMV1zysrkxM2+G9bVL5lwo9CuDTin/54WtL5Z9rZR/p1fpyCD3YoD1cML7D/WFzrm1zoe35/8HF2tkn4fOQh3b0dQ55t4qcv5VrYI/WxzjyUHz0GTQDupaMynVpP974eOr1VI8batx+hnYkzaVfhPmczZBKZ3/m7/CF5d8ll9uGVtcOqwu9Pc8yKX2O7M6P5q0nYwZ+iugU2M16WPgx4UQf4AEUi9fNA4eVyHjTOBjPvwxt38RMylKPWSVGlmpdNrUmZkabitQ==;5:/ygxot+1dWf4+qzfJoC9jLtM8RozF46E8ziCuNsv0+ALXKM0A6Rmo0yLRfeAW6fPLFya2DbP33phpjnsr/9/TsPTOr3+I2v91+oVWvwJbtaY1w21COD7JCZrrYJKhy/kw/A35gF4ZuphwBpL39t1ny0S/TtXe7oxF4YQVJzyq5g=;7:gshyp9GnMMbuitg7iipCOoIF8Snqa4izzuumwf4GJk7NeTQTrsqBQsqCj49qAt35vwo3Da7q+yArexF7ddwLemXkTCRYllp0f3VyzpwF2OAl3gUjWGDJiRvVeu17bTYK8AKwHgs411GrLGF8YeBDsA==
x-ms-office365-filtering-correlation-id: 7cd43ee1-2cce-49bc-78b8-08d65660be5a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3833;
x-ms-traffictypediagnostic: DB3PR0402MB3833:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB3PR0402MB3833B379F3057BA33554B9B1F5D30@DB3PR0402MB3833.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231453)(999002)(944501410)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3833;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3833;
x-forefront-prvs: 087223B4DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(396003)(366004)(39860400002)(54534003)(13464003)(199004)(189003)(44832011)(3846002)(53546011)(1411001)(53936002)(25786009)(4326008)(66066001)(6246003)(478600001)(7696005)(39060400002)(102836004)(11346002)(7416002)(74316002)(86362001)(5660300001)(305945005)(7736002)(2906002)(68736007)(256004)(9686003)(55016002)(105586002)(33656002)(6436002)(8676002)(446003)(54906003)(99286004)(106356001)(476003)(316002)(6506007)(76176011)(71200400001)(6916009)(486006)(14454004)(71190400001)(8936002)(81166006)(229853002)(186003)(26005)(97736004)(6116002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3833;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: GrcW65YLAUcQbJ7wrZpvWtfL1lz48ADSJdl1TaAYJGvqJBs2JtztsmTPJaInWZABxHyiY0khqbmIX4o/zg/X1FUMTWF2Gpz1edebVNq5EdWgjJ0PmK9iwC1aw3ofBt+3kU6D5fnLyZATmTW/P/tR9QeMljJ9kk4f3iKL+sPdtBxaDlQ1Cn1uBwb+oGRNOab7bLm1PQSaAUnCnNce23zFGQsYXBHxpEnHAM2cZ/rXwM9v8B9HXJtwvHl4DeetRd5iJvop8NSp+isH9cN/TD+SVJZWM+pn2JgRcGtIt25nXrXD291Zg0OF299Yr6rnEssMB/ULGCyXQrc8jrnwUJv+YYA6H6plzf1DG7iEwIKnCFo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd43ee1-2cce-49bc-78b8-08d65660be5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2018 01:11:22.8859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3833
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEVkdWFyZG8NCg0KQmVzdCBSZWdhcmRzIQ0KQW5zb24gSHVhbmcNCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFZHVhcmRvIFZhbGVudGluIFttYWlsdG86ZWR1YmV6
dmFsQGdtYWlsLmNvbV0NCj4gU2VudDogMjAxOMTqMTHUwjMwyNUgMDo1MQ0KPiBUbzogQW5zb24g
SHVhbmcgPGFuc29uLmh1YW5nQG54cC5jb20+DQo+IENjOiBydWkuemhhbmdAaW50ZWwuY29tOyBk
YW5pZWwubGV6Y2Fub0BsaW5hcm8ub3JnOyByb2JoK2R0QGtlcm5lbC5vcmc7DQo+IG1hcmsucnV0
bGFuZEBhcm0uY29tOyBjYXRhbGluLm1hcmluYXNAYXJtLmNvbTsgd2lsbC5kZWFjb25AYXJtLmNv
bTsNCj4gQWlzaGVuZyBET05HIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT47IEFuZHkgR3Jvc3MNCj4g
PGFuZHkuZ3Jvc3NAbGluYXJvLm9yZz47IGhlaWtvQHNudGVjaC5kZTsgaG9ybXMrcmVuZXNhc0B2
ZXJnZS5uZXQuYXU7DQo+IGFybmRAYXJuZGIuZGU7IGFtaXQua3VjaGVyaWFAbGluYXJvLm9yZzsg
ZW5yaWMuYmFsbGV0Ym9AY29sbGFib3JhLmNvbTsNCj4gZXplcXVpZWxAY29sbGFib3JhLmNvbTsg
b2xvZkBsaXhvbS5uZXQ7IGJqb3JuLmFuZGVyc3NvbkBsaW5hcm8ub3JnOw0KPiBzaGF3bmd1b0Br
ZXJuZWwub3JnOyBMV0BLQVJPLWVsZWN0cm9uaWNzLmRlOyBsaW51eC1wbUB2Z2VyLmtlcm5lbC5v
cmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGRsLWxpbnV4
LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjQgNC80XSBB
Uk02NDogZHRzOiBpbXg6IGFkZCBpLk1YOFFYUCB0aGVybWFsIHN1cHBvcnQNCj4gDQo+IE9uIFRo
dSwgTm92IDI5LCAyMDE4IGF0IDAyOjM3OjQ3QU0gKzAwMDAsIEFuc29uIEh1YW5nIHdyb3RlOg0K
PiA+IEFkZCBpLk1YOFFYUCBDUFUgdGhlcm1hbCB6b25lIHN1cHBvcnQuDQo+ID4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gPiAtLS0NCj4g
PiBDaGFuZ2VMb2c6DQo+ID4gVjMtPlY0Og0KPiA+ICAgKm1vdmUgdGhlIHRzZW5zIG5vZGUgdG8g
aW5zaWRlIG9mIFNDVSBub2RlIGFzIGl0IGlzIGJlbG9uZ2luZyB0byBTQ1UuDQo+ID4gLS0tDQo+
ID4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhxeHAuZHRzaSB8IDI3DQo+ID4g
KysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyNyBpbnNl
cnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVl
c2NhbGUvaW14OHF4cC5kdHNpDQo+ID4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9p
bXg4cXhwLmR0c2kNCj4gPiBpbmRleCA5YjA4Njg4Li40OGY2MjJjIDEwMDY0NA0KPiA+IC0tLSBh
L2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhxeHAuZHRzaQ0KPiA+ICsrKyBiL2Fy
Y2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhxeHAuZHRzaQ0KPiA+IEBAIC05LDYgKzks
NyBAQA0KPiA+ICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvZmlybXdhcmUvaW14L3JzcmMuaD4gICNp
bmNsdWRlDQo+ID4gPGR0LWJpbmRpbmdzL2dwaW8vZ3Bpby5oPiAgI2luY2x1ZGUNCj4gPiA8ZHQt
YmluZGluZ3MvcGluY3RybC9wYWRzLWlteDhxeHAuaD4NCj4gPiArI2luY2x1ZGUgPGR0LWJpbmRp
bmdzL3RoZXJtYWwvdGhlcm1hbC5oPg0KPiA+DQo+ID4gICNpbmNsdWRlICJpbXg4LWNhMzUuZHRz
aSINCj4gPg0KPiA+IEBAIC04Nyw2ICs4OCwxMiBAQA0KPiA+ICAJCXJ0YzogcnRjIHsNCj4gPiAg
CQkJY29tcGF0aWJsZSA9ICJmc2wsaW14OHF4cC1zYy1ydGMiOw0KPiA+ICAJCX07DQo+ID4gKw0K
PiA+ICsJCXRzZW5zOiB0aGVybWFsLXNlbnNvciB7DQo+ID4gKwkJCWNvbXBhdGlibGUgPSAiZnNs
LGlteDhxeHAtc2MtdGhlcm1hbCI7DQo+ID4gKwkJCXRzZW5zLW51bSA9IDwxPjsNCj4gPiArCQkJ
I3RoZXJtYWwtc2Vuc29yLWNlbGxzID0gPDE+Ow0KPiA+ICsJCX07DQo+ID4gIAl9Ow0KPiA+DQo+
ID4gIAlhZG1hX3N1YnN5czogYnVzQDU5MDAwMDAwIHsNCj4gPiBAQCAtNDEwLDQgKzQxNywyNCBA
QA0KPiA+ICAJCSNzaXplLWNlbGxzID0gPDE+Ow0KPiA+ICAJCXJhbmdlcyA9IDwweDVmMDAwMDAw
IDB4MCAweDVmMDAwMDAwIDB4MTAwMDAwMD47DQo+ID4gIAl9Ow0KPiA+ICsNCj4gPiArCXRoZXJt
YWxfem9uZXM6IHRoZXJtYWwtem9uZXMgew0KPiA+ICsJCWNwdS10aGVybWFsMCB7DQo+ID4gKwkJ
CXBvbGxpbmctZGVsYXktcGFzc2l2ZSA9IDwyNTA+Ow0KPiA+ICsJCQlwb2xsaW5nLWRlbGF5ID0g
PDIwMDA+Ow0KPiA+ICsJCQl0aGVybWFsLXNlbnNvcnMgPSA8JnRzZW5zIDM1NT47DQo+ID4gKwkJ
CXRyaXBzIHsNCj4gPiArCQkJCWNwdV9hbGVydDA6IHRyaXAwIHsNCj4gPiArCQkJCQl0ZW1wZXJh
dHVyZSA9IDwxMDcwMDA+Ow0KPiA+ICsJCQkJCWh5c3RlcmVzaXMgPSA8MjAwMD47DQo+ID4gKwkJ
CQkJdHlwZSA9ICJwYXNzaXZlIjsNCj4gDQo+IFBhc3NpdmUsIGJ1dCB5ZXQgbm8gY29vbGluZyBt
YXBzPw0KDQpUaGUgY3B1LWZyZXEgZHJpdmVyIGZvciBpLk1YOFFYUCBpcyBOT1QgcmVhZHkgeWV0
LCBhbmQgTk9UDQpzdXJlIHdoZW4gaXQgd2lsbCBiZSByZWFkeSwgc28gSSBjYW4gTk9UIHRlc3Qg
dGhlIGNvb2xpbmcgZnVuY3Rpb24gbm93LA0KdGhhdCBpcyB3aHkgSSBkaWQgTk9UIGFkZCB0aGUg
Y29vbGluZyBtYXBzLCBwbGFuIHRvIGFkZCB0aGUgQ1BVIGNvb2xpbmcNCm1hcCBhZnRlciBjcHUt
ZnJlcSBpcyByZWFkeS4NCg0KQW5zb24uDQoNCj4gDQo+ID4gKwkJCQl9Ow0KPiA+ICsJCQkJY3B1
X2NyaXQwOiB0cmlwMSB7DQo+ID4gKwkJCQkJdGVtcGVyYXR1cmUgPSA8MTI3MDAwPjsNCj4gPiAr
CQkJCQloeXN0ZXJlc2lzID0gPDIwMDA+Ow0KPiA+ICsJCQkJCXR5cGUgPSAiY3JpdGljYWwiOw0K
PiA+ICsJCQkJfTsNCj4gPiArCQkJfTsNCj4gPiArCQl9Ow0KPiA+ICsJfTsNCj4gPiAgfTsNCj4g
PiAtLQ0KPiA+IDIuNy40DQo+ID4NCg==
