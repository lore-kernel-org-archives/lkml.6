Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C33C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 08:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0386927BEC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 08:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cQxcPktQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0386927BEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964979AbeF2I1s (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 04:27:48 -0400
Received: from mail-eopbgr30070.outbound.protection.outlook.com ([40.107.3.70]:56640
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964929AbeF2I1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 04:27:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3xZj3mUdfB6zzO6YRCi9okpqnHGkXa5N84/MFv09H0=;
 b=cQxcPktQbp7AMR/PLI5PX7+YYNQ5NnsBWyjvAGOfeQ2N5EutS8C6hdndTbQBrA8yhCwiffU5v16UQvB+zHyEZh73TiEpxUCdGIWSdFqnNDgZyb+D/AcXwEgT+8mYhnLkDtk8zwOXn5feabPqJu+zgKhShjNehge5voWkTgFlKgw=
Received: from AM3PR04MB1315.eurprd04.prod.outlook.com (10.163.7.13) by
 AM3PR04MB1140.eurprd04.prod.outlook.com (10.163.5.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.23; Fri, 29 Jun 2018 08:27:41 +0000
Received: from AM3PR04MB1315.eurprd04.prod.outlook.com
 ([fe80::a024:25ab:f457:64c7]) by AM3PR04MB1315.eurprd04.prod.outlook.com
 ([fe80::a024:25ab:f457:64c7%7]) with mapi id 15.20.0906.025; Fri, 29 Jun 2018
 08:27:41 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] ARM: dts: imx6: correct anatop regulators range
Thread-Topic: [PATCH] ARM: dts: imx6: correct anatop regulators range
Thread-Index: AQHUD38AdyuDZR4W10i/tnVGAfQSq6R245iAgAAATiA=
Date:   Fri, 29 Jun 2018 08:27:41 +0000
Message-ID: <AM3PR04MB13157A4948E36BAE60A8DC49F54E0@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1530258861-11666-1-git-send-email-Anson.Huang@nxp.com>
 <1530260109.22468.60.camel@pengutronix.de>
In-Reply-To: <1530260109.22468.60.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB1140;7:w1NA0Jg/qbGZoe8YYirkm2DL3yAPso35BKTg7Ng1ezt8Nat35QVPTLRW1cdkGsdask07Y3qLEnrJMW3CwhY+6TfvaQEz1BLLCI89cE4SiLO9lyekVJBNsLTUDvz73qo/7IL4RJZeC+w2QHkaSSwR8ISZidhBmFRoPscX+RrYtwSgAp8lq8rbLKd3yINWLmjJ9mmbi3r+wmCY+tahlA+/ECIIuXObJUUfdjaA8MknOHuuvcvuLdVoy+qtgiRiX1N4
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f4840584-9941-4dc6-4d51-08d5dd9a2e3d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1140;
x-ms-traffictypediagnostic: AM3PR04MB1140:
x-microsoft-antispam-prvs: <AM3PR04MB1140A513DBD49DDDC9008936F54E0@AM3PR04MB1140.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB1140;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1140;
x-forefront-prvs: 0718908305
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(346002)(39860400002)(376002)(13464003)(199004)(189003)(7736002)(11346002)(81156014)(446003)(305945005)(2900100001)(6436002)(476003)(7696005)(55016002)(33656002)(9686003)(229853002)(8936002)(486006)(74316002)(8676002)(68736007)(106356001)(5660300001)(99286004)(110136005)(316002)(6116002)(3846002)(2201001)(76176011)(81166006)(53936002)(2906002)(478600001)(6246003)(102836004)(6506007)(2501003)(25786009)(97736004)(4326008)(256004)(5250100002)(105586002)(86362001)(26005)(53546011)(14454004)(44832011)(186003)(66066001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1140;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: g/hX4DKG3LP1XbVjmsfXuXHPLOyL7BYpzFPXTFcCb589g6YnaYpLDA/UoV0KrseDt3n5WnwwktpsO9TN/Ye2Hk9gpZTcPU9TyXAPm3VyfBNDOWFBnA/d3DUD5CJthVX+aGu8jGCQSaikbtqEvAcogI8OX7uzpbD7Mu0A48pTiv7xbuZz9Q4CiNP5AKYtrBVAbToT0I7Z0zVzSANzi7/6jVnaRNy+DBs3XvIxfMJ3QUfamiADfGkqzHKt7sdtZ+ePnFswPQBIqtbQw3R+yuAHkA2sT6uQoX0xl1kVt41/n4ygE2hf+aoyy7DO9q+nQDBBnri0jrYdiA9I8odOAT38XPCCg4wbh0KKvPF+db4+0i4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4840584-9941-4dc6-4d51-08d5dd9a2e3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2018 08:27:41.2053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEx1Y2FzDQoNCkFuc29uIEh1YW5nDQpCZXN0IFJlZ2FyZHMhDQoNCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWNhcyBTdGFjaCBbbWFpbHRvOmwuc3RhY2hAcGVu
Z3V0cm9uaXguZGVdDQo+IFNlbnQ6IEZyaWRheSwgSnVuZSAyOSwgMjAxOCA0OjE1IFBNDQo+IFRv
OiBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT47IHNoYXduZ3VvQGtlcm5lbC5vcmc7
DQo+IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgRmFiaW8g
RXN0ZXZhbQ0KPiA8ZmFiaW8uZXN0ZXZhbUBueHAuY29tPjsgcm9iaCtkdEBrZXJuZWwub3JnOyBt
YXJrLnJ1dGxhbmRAYXJtLmNvbTsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZw0KPiBDYzogZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSF0gQVJNOiBkdHM6IGlteDY6IGNvcnJlY3QgYW5hdG9wIHJlZ3VsYXRvcnMg
cmFuZ2UNCj4gDQo+IEFtIEZyZWl0YWcsIGRlbiAyOS4wNi4yMDE4LCAxNTo1NCArMDgwMCBzY2hy
aWViIEFuc29uIEh1YW5nOg0KPiA+IENvcnJlY3Qgc29tZSBpLk1YNiBTb0NzIGFuYXRvcCByZWd1
bGF0b3JzIHJhbmdlIGFjY29yZGluZyB0byByZWZlcmVuY2UNCj4gPiBtYW51YWwuDQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gDQo+
IE5BQ0suDQo+IA0KPiBUaGlzIGlzIHdyb25nLiBXaGlsZSB0aGUgcmVndWxhdG9yIHN1cHBvcnRz
IHRoaXMgcmFuZ2UsIHRoZSBTb0MgZG9lc24ndC7CoFRoZQ0KPiBjdXJyZW50IHNldHRpbmdzIGFy
ZSBkZXJpdmVkIGZyb20gdGhlIGFsbG93ZWQgb3BlcmF0aW5nIHJhbmdlcyBvZiB0aGUgU29DIChh
dA0KPiBsZWFzdCBmb3IgdGhlIE1YNlFETCksIHdoaWNoIGlzIGluIGFjY29yZGFuY2Ugd2l0aCBo
b3cgcmVndWxhdG9yIGNvbnN0cmFpbnRzDQo+IGluIERUIGFyZSBtZWFudCB0byBiZSB1c2VkLg0K
IA0KVW5kZXJzdGFuZCB0aGF0IG5vcm1hbGx5IHRoZXNlIHJlZ3VsYXRvcnMnIHZvbHRhZ2UgYXJl
IE5PVCBhZGp1c3RlZCwgd2UganVzdCB1c2UNCnRoZSBkZWZhdWx0IHZhbHVlLCBsZXQncyBqdXN0
IGNhbGwgdGhlIG9wZXJhdGluZyByYW5nZSBvZiB0aGUgU29DICJTb0MgcmFuZ2UiLA0KbXkgaW50
ZW50aW9uIGlzIHRvIG1ha2UgYWxsIGkuTVg2J3MgYW5hdG9wIHJlZ3VsYXRvciBzZXR0aW5ncyBh
bGlnbmVkIHNpbmNlIHRoZXkgYXJlIGluIHNhbWUgc2VyaWVzLCANCkkgc2F3IHNvbWUgaS5NWDYg
U29DcyB1c2Ugc2FtZSBTb0MgcmFuZ2UgYXMgYW5hdG9wIGxkbyByYW5nZSwgYnV0IHNvbWUgYXJl
DQpOT1QsIGxpa2UgaW14NnFkbC9pbXg2c3gvaW14NnNsIHVzZSBkaWZmZXJlbnQgU29DIHJhbmdl
IHRoYW4gYW5hdG9wIGxkbyByYW5nZSwNCmJ1dCBpbXg2dWwvdWxsL3NsbCB1c2Ugc2FtZSByZWd1
bGF0b3IgcmFuZ2UgYXMgYW5hdG9wIGxkbywgYW5kIHJlZ3VsYXRvciAxcDEvMnA1LzNwMA0KYWxz
byBoYXZlIGRpZmZlcmVudCBzZXR0aW5ncywgc29tZSBhcmUgdXNlIFNvQyByYW5nZSBhbmQgc29t
ZSBhcmUganVzdCBzYW1lIGFzIGFuYXRvcA0KbGRvIHJhbmdlLi4uLnRoaXMgbG9va3MgcmVhbGx5
IGNvbmZ1c2VkLg0KDQpTbywgZG8geW91IHRoaW5rIHdlIGNhbiBhZGp1c3QgdGhlIGlteDZ1bC91
bGwvc2xsJ3MgcmVndWxhdG9yIHJhbmdlIHRvIGJlIFNvQyByYW5nZSByYXRoZXIgdGhhbg0KYW5h
dG9wIGxkbyByYW5nZT8gQW5kIGhvdyB0byBkZWZpbmUgdGhlIFNvQyByYW5nZT8gTGlrZSB0aGUg
MXAxIGxkbyByYW5nZSwgaG93IGRvDQp3ZSBrbm93IHdoaWNoIHJhbmdlIGlzIGZpbmU/IEFzIEkg
c2F3IGl0IGlzIDF2IH4gMS4ydiBvbiBpbXg2cWRsLCBidXQgMC44diB+IDEuMzc1diBvbiBpbXg2
c2w/DQoNClRoYW5rcy4NCg0KQW5zb24uDQoNCj4gDQo+IFJlZ2FyZHMsDQo+IEx1Y2FzDQo+IA0K
PiA+IC0tLQ0KPiA+IMKgYXJjaC9hcm0vYm9vdC9kdHMvaW14NnFkbC5kdHNpIHwgMTIgKysrKysr
LS0tLS0tDQo+ID4gwqBhcmNoL2FybS9ib290L2R0cy9pbXg2c2wuZHRzacKgwqB8wqDCoDQgKyst
LQ0KPiA+IMKgYXJjaC9hcm0vYm9vdC9kdHMvaW14NnN4LmR0c2nCoMKgfMKgwqA0ICsrLS0NCj4g
PiDCoDMgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQo+
ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnFkbC5kdHNpDQo+ID4g
Yi9hcmNoL2FybS9ib290L2R0cy9pbXg2cWRsLmR0c2kgaW5kZXggOTExMTQxZS4uZDlmOThkZCAx
MDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9pbXg2cWRsLmR0c2kNCj4gPiArKysg
Yi9hcmNoL2FybS9ib290L2R0cy9pbXg2cWRsLmR0c2kNCj4gPiBAQCAtNjg5LDggKzY4OSw4IEBA
DQo+ID4gPiDCoAkJCQlyZWd1bGF0b3ItMXAxIHsNCj4gPiA+IMKgCQkJCQljb21wYXRpYmxlID0g
ImZzbCxhbmF0b3AtcmVndWxhdG9yIjsNCj4gPiA+IMKgCQkJCQlyZWd1bGF0b3ItbmFtZSA9ICJ2
ZGQxcDEiOw0KPiA+ID4gLQkJCQkJcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8MTAwMDAwMD47
DQo+ID4gPiAtCQkJCQlyZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwxMjAwMDAwPjsNCj4gPiA+
ICsJCQkJCXJlZ3VsYXRvci1taW4tbWljcm92b2x0ID0gPDgwMDAwMD47DQo+ID4gPiArCQkJCQly
ZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwxMzc1MDAwPjsNCj4gPiA+IMKgCQkJCQlyZWd1bGF0
b3ItYWx3YXlzLW9uOw0KPiA+ID4gwqAJCQkJCWFuYXRvcC1yZWctb2Zmc2V0ID0gPDB4MTEwPjsN
Cj4gPiA+IMKgCQkJCQlhbmF0b3Atdm9sLWJpdC1zaGlmdCA9IDw4PjsNCj4gPiBAQCAtNzA0LDgg
KzcwNCw4IEBADQo+ID4gPiDCoAkJCQlyZWd1bGF0b3ItM3AwIHsNCj4gPiA+IMKgCQkJCQljb21w
YXRpYmxlID0gImZzbCxhbmF0b3AtcmVndWxhdG9yIjsNCj4gPiA+IMKgCQkJCQlyZWd1bGF0b3It
bmFtZSA9ICJ2ZGQzcDAiOw0KPiA+ID4gLQkJCQkJcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8
MjgwMDAwMD47DQo+ID4gPiAtCQkJCQlyZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwzMTUwMDAw
PjsNCj4gPiA+ICsJCQkJCXJlZ3VsYXRvci1taW4tbWljcm92b2x0ID0gPDI2MjUwMDA+Ow0KPiA+
ID4gKwkJCQkJcmVndWxhdG9yLW1heC1taWNyb3ZvbHQgPSA8MzQwMDAwMD47DQo+ID4gPiDCoAkJ
CQkJcmVndWxhdG9yLWFsd2F5cy1vbjsNCj4gPiA+IMKgCQkJCQlhbmF0b3AtcmVnLW9mZnNldCA9
IDwweDEyMD47DQo+ID4gPiDCoAkJCQkJYW5hdG9wLXZvbC1iaXQtc2hpZnQgPSA8OD47DQo+ID4g
QEAgLTcxOSw4ICs3MTksOCBAQA0KPiA+ID4gwqAJCQkJcmVndWxhdG9yLTJwNSB7DQo+ID4gPiDC
oAkJCQkJY29tcGF0aWJsZSA9ICJmc2wsYW5hdG9wLXJlZ3VsYXRvciI7DQo+ID4gPiDCoAkJCQkJ
cmVndWxhdG9yLW5hbWUgPSAidmRkMnA1IjsNCj4gPiA+IC0JCQkJCXJlZ3VsYXRvci1taW4tbWlj
cm92b2x0ID0gPDIyNTAwMDA+Ow0KPiA+ID4gLQkJCQkJcmVndWxhdG9yLW1heC1taWNyb3ZvbHQg
PSA8Mjc1MDAwMD47DQo+ID4gPiArCQkJCQlyZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDwyMTAw
MDAwPjsNCj4gPiA+ICsJCQkJCXJlZ3VsYXRvci1tYXgtbWljcm92b2x0ID0gPDI4NzUwMDA+Ow0K
PiA+ID4gwqAJCQkJCXJlZ3VsYXRvci1hbHdheXMtb247DQo+ID4gPiDCoAkJCQkJYW5hdG9wLXJl
Zy1vZmZzZXQgPSA8MHgxMzA+Ow0KPiA+ID4gwqAJCQkJCWFuYXRvcC12b2wtYml0LXNoaWZ0ID0g
PDg+Ow0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9pbXg2c2wuZHRzaQ0KPiA+
IGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnNsLmR0c2kgaW5kZXggODFmNDgxMTYuLjNkNzkzMWIg
MTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnNsLmR0c2kNCj4gPiArKysg
Yi9hcmNoL2FybS9ib290L2R0cy9pbXg2c2wuZHRzaQ0KPiA+IEBAIC01MzksOCArNTM5LDggQEAN
Cj4gPiA+IMKgCQkJCXJlZ3VsYXRvci0zcDAgew0KPiA+ID4gwqAJCQkJCWNvbXBhdGlibGUgPSAi
ZnNsLGFuYXRvcC1yZWd1bGF0b3IiOw0KPiA+ID4gwqAJCQkJCXJlZ3VsYXRvci1uYW1lID0gInZk
ZDNwMCI7DQo+ID4gPiAtCQkJCQlyZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDwyODAwMDAwPjsN
Cj4gPiA+IC0JCQkJCXJlZ3VsYXRvci1tYXgtbWljcm92b2x0ID0gPDMxNTAwMDA+Ow0KPiA+ID4g
KwkJCQkJcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8MjYyNTAwMD47DQo+ID4gPiArCQkJCQly
ZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwzNDAwMDAwPjsNCj4gPiA+IMKgCQkJCQlyZWd1bGF0
b3ItYWx3YXlzLW9uOw0KPiA+ID4gwqAJCQkJCWFuYXRvcC1yZWctb2Zmc2V0ID0gPDB4MTIwPjsN
Cj4gPiA+IMKgCQkJCQlhbmF0b3Atdm9sLWJpdC1zaGlmdCA9IDw4PjsNCj4gPiBkaWZmIC0tZ2l0
IGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnN4LmR0c2kNCj4gPiBiL2FyY2gvYXJtL2Jvb3QvZHRz
L2lteDZzeC5kdHNpIGluZGV4IDcxMzBhYjguLmYyNmY2MTEgMTAwNjQ0DQo+ID4gLS0tIGEvYXJj
aC9hcm0vYm9vdC9kdHMvaW14NnN4LmR0c2kNCj4gPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9p
bXg2c3guZHRzaQ0KPiA+IEBAIC02MDcsOCArNjA3LDggQEANCj4gPiA+IMKgCQkJCXJlZ3VsYXRv
ci0zcDAgew0KPiA+ID4gwqAJCQkJCWNvbXBhdGlibGUgPSAiZnNsLGFuYXRvcC1yZWd1bGF0b3Ii
Ow0KPiA+ID4gwqAJCQkJCXJlZ3VsYXRvci1uYW1lID0gInZkZDNwMCI7DQo+ID4gPiAtCQkJCQly
ZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDwyODAwMDAwPjsNCj4gPiA+IC0JCQkJCXJlZ3VsYXRv
ci1tYXgtbWljcm92b2x0ID0gPDMxNTAwMDA+Ow0KPiA+ID4gKwkJCQkJcmVndWxhdG9yLW1pbi1t
aWNyb3ZvbHQgPSA8MjYyNTAwMD47DQo+ID4gPiArCQkJCQlyZWd1bGF0b3ItbWF4LW1pY3Jvdm9s
dCA9IDwzNDAwMDAwPjsNCj4gPiA+IMKgCQkJCQlyZWd1bGF0b3ItYWx3YXlzLW9uOw0KPiA+ID4g
wqAJCQkJCWFuYXRvcC1yZWctb2Zmc2V0ID0gPDB4MTIwPjsNCj4gPiA+IMKgCQkJCQlhbmF0b3At
dm9sLWJpdC1zaGlmdCA9IDw4PjsNCg==
