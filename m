Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00340C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 22:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A9AB208B5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 22:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IzIk1pQW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A9AB208B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756707AbeFOWms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 18:42:48 -0400
Received: from mail-eopbgr30072.outbound.protection.outlook.com ([40.107.3.72]:27717
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756429AbeFOWmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 18:42:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3NOFpTTP1yCcL3v6Bes3V31rrL/+ZbkS9iWMjHsFL8=;
 b=IzIk1pQW1G2sJeimPNe/36w7Omxs42ditrDEvBYfMgimG9dbkcDWjFprxeRn3mQ3nVzmSxBKS6cM3h/gEU9uN5E9M7imeIw7QRNPXIjESdFc64mEe0kxh/snb/q7gzigzNBQA//QppYc6n4opA3SY5nlUlQ+qzV+M8JazmAtWx8=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4002.eurprd04.prod.outlook.com (52.134.90.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.16; Fri, 15 Jun 2018 22:42:43 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::1cd1:a089:87a0:25ec]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::1cd1:a089:87a0:25ec%2]) with mapi id 15.20.0863.016; Fri, 15 Jun 2018
 22:42:43 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "festevam@gmail.com" <festevam@gmail.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "marex@denx.de" <marex@denx.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "marcofrk@gmail.com" <marcofrk@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH 1/3] drm: mxsfb: Change driver.name to mxsfb-drm
Thread-Topic: [PATCH 1/3] drm: mxsfb: Change driver.name to mxsfb-drm
Thread-Index: AQHUBOE6dIO4bv5XOkuQXfh+MS7cPKRhubYAgAATpQCAAArcAIAAEl0A
Date:   Fri, 15 Jun 2018 22:42:43 +0000
Message-ID: <b3fa74c5110b45e5992920485749869ab1f7ebce.camel@nxp.com>
References: <cover.1529091248.git.leonard.crestez@nxp.com>
         <47ea7572011735b68a8a70f0e11bdf00cb2fd86a.1529091248.git.leonard.crestez@nxp.com>
         <CAOMZO5B8i0gN+rCq-yPrd112NkwJWTxYCtsLVeLhD1JLRuX6EQ@mail.gmail.com>
         <07be6d9a85b6be655fc2b084be81d8bf9715b57a.camel@nxp.com>
         <638457fd-85da-8fec-d146-517c43f71813@denx.de>
In-Reply-To: <638457fd-85da-8fec-d146-517c43f71813@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.2-1 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [85.204.4.237]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4002;7:hk1rviUZrSN2rJ7ScOUzmJOynnhBhFj3ySRfTvW/r/n0WDHD3HPSShmkfWrZF7NHCGhD9lWEPWfraIFKWB9u7gh6JS0d+GdjYU2C93piFQjiqkrNMTEB51tanOvx4ELR9LZl3mDyYKftQ6G0N/Sn/o7NCes4LIimo9z03HMKmlEHkNTgokWe8pxNVa2WOdB+LQAEpJD5DprcZvsfZlgpQJGH0N4wDq1ZkaFfP88Bk2SlV5DMzCGpDJsOHlV9xOy3
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 9d321c42-335c-4d7d-47a9-08d5d3114f00
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4002;
x-ms-traffictypediagnostic: AM0PR04MB4002:
x-microsoft-antispam-prvs: <AM0PR04MB4002BE17A0772D1F6C3E8251EE7C0@AM0PR04MB4002.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4002;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4002;
x-forefront-prvs: 0704670F76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(376002)(39380400002)(346002)(39860400002)(199004)(189003)(8936002)(5250100002)(97736004)(6436002)(59450400001)(4326008)(53546011)(26005)(6116002)(25786009)(6486002)(110136005)(36756003)(186003)(81156014)(316002)(3280700002)(53936002)(50226002)(99286004)(68736007)(93886005)(6506007)(81166006)(3660700001)(2501003)(76176011)(561944003)(54906003)(118296001)(6512007)(2201001)(305945005)(106356001)(3846002)(66066001)(476003)(446003)(486006)(5660300001)(39060400002)(14454004)(2900100001)(7736002)(2906002)(102836004)(11346002)(7416002)(105586002)(478600001)(8676002)(86362001)(229853002)(44832011)(6246003)(2616005)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4002;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 94JQabg8koe8Q+Ey8KB8MUcyUEVni9p3BI+4BKnoGNwu6ENrawm4K4/41EjYCo5rUi4xs61uwompbGnsv1OyvPX03P/UmuMQJfWyntDkfvtPU/aWhyvblqkkeHQqHA/bXfNBSldiw5SIRvvgDiE/wK33262VzNkby2hEmzIkGSxA4MC8B5+BNrakANDgL3CO
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B53FC94007FC849B602E73E1E65C123@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d321c42-335c-4d7d-47a9-08d5d3114f00
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2018 22:42:43.5178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4002
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE4LTA2LTE1IGF0IDIzOjM2ICswMjAwLCBNYXJlayBWYXN1dCB3cm90ZToNCj4g
T24gMDYvMTUvMjAxOCAxMDo1OCBQTSwgTGVvbmFyZCBDcmVzdGV6IHdyb3RlOg0KPiA+IE9uIEZy
aSwgMjAxOC0wNi0xNSBhdCAxNjo0NyAtMDMwMCwgRmFiaW8gRXN0ZXZhbSB3cm90ZToNCj4gPiA+
IE9uIEZyaSwgSnVuIDE1LCAyMDE4IGF0IDQ6NDMgUE0sIExlb25hcmQgQ3Jlc3Rleg0KPiA+ID4g
PGxlb25hcmQuY3Jlc3RlekBueHAuY29tPiB3cm90ZToNCg0KPiA+ID4gPiBUaGUgRkJERVYgZHJp
dmVyIHVzZXMgdGhlIHNhbWUgbmFtZSBhbmQgYm90aCBjYW4ndCBiZSByZWdpc3RlcmVkIGF0IHRo
ZQ0KPiA+ID4gPiBzYW1lIHRpbWUuIEZpeCB0aGlzIGJ5IHJlbmFtaW5nIHRoZSBkcm0gZHJpdmVy
IHRvIG14c2ZiLWRybQ0KPiA+ID4gDQo+ID4gPiBTdGVmYW4gc2VudCB0aGUgc2FtZSBwYXRjaCBh
IGZldyBkYXlzIGFnbzoNCj4gPiANCj4gPiBJbiB0aGF0IHRocmVhZCB0aGVyZSBpcyBhIHByb3Bv
c2FsIGZvciByZW1vdmluZyB0aGUgb2xkIGZiZGV2L214c2ZiDQo+ID4gZHJpdmVyIGVudGlyZWx5
Lg0KPiA+IA0KPiA+IFRoYXQgd291bGQgYnJlYWsgb2xkIERUQnMsIGlzbid0IHRoaXMgZ2VuZXJh
bGx5IGNvbnNpZGVyZWQgYmFkPyBBbHNvLA0KPiA+IGFyZSB3ZSBzdXJlIHRoZSByZW1vdmFsIG9m
IGZiZGV2L214c2ZiIHdvdWxkbid0IGxvc2UgYW55IGZlYXR1cmVzPw0KPiA+IA0KPiA+IFdoYXQg
bXkgc2VyaWVzIGRvZXMgaXMgbWFrZSBib3RoIGRyaXZlcnMgd29yayB3aXRoIHRoZSBzYW1lIGtl
cm5lbA0KPiA+IGltYWdlIGFuZCB0dXJucyB0aGUgY2hvaWNlIGludG8gYSBib2FyZC1sZXZlbCBk
dGIgZGVjaXNpb24uIFN1cHBvcnRpbmcNCj4gPiBldmVyeXRoaW5nIGF0IG9uY2Ugc2VlbXMgZGVz
aXJhYmxlIHRvIG1lIGFuZCBpdCBhbGxvd3MgZm9yIGEgdmVyeQ0KPiA+IHNtb290aCB1cGdyYWRl
IHBhdGguDQo+IA0KPiBIYXZpbmcgdHdvIGRyaXZlcnMgaW4gdGhlIGtlcm5lbCB3aXRoIGRpZmZl
cmVudCBzZXQgb2YgYnVncyBpcyBhbHdheXMgYmFkLg0KPiANCj4gPiBUaGUgb2xkIGRyaXZlciBj
b3VsZCBiZSByZW1vdmVkIGxhdGVyLCBhZnRlciBhbGwgdXNlcnMgYXJlIGNvbnZlcnRlZC4NCj4g
DQo+IEJvdGggZHJpdmVycyB3ZXJlIGluIGZvciBsb25nIGVub3VnaCBhbHJlYWR5LiBBbmQgbGV0
J3MgYmUgcmVhbGlzdGljLA0KPiBob3cgbWFueSBNWDIzL01YMjggdXNlcnMgb2Ygb2xkIERUcyB3
aXRoIG5ldyBrZXJuZWxzIGFyZSB0aGVyZSB3aG8NCj4gY2Fubm90IHVwZGF0ZSB0aGUgRFQgYXMg
d2VsbCA/DQoNCkdyZXBwaW5nIGZvciAiZGlzcGxheSA9IiBpbiBhcmNoL2FybS9ib290L2R0cy9p
bXgqIEkgc2VlIHRoYXQgb2xkDQpiaW5kaW5ncyBhcmUgYWxzbyB1c2VkIGJ5IDNyZC1wYXJ0eSBi
b2FyZHMgZm9yIGlteDYvNzoNCiAqIGlteDZzeC1uaXRyb2dlbjZzeA0KICogaW14NnVsLWdlYW0N
CiAqIGlteDZ1bC1pc2lvdA0KICogaW14NnVsLW9wb3M2dWxkZXYNCiAqIGlteDZ1bC1waWNvLWhv
YmJpdA0KICogaW14NnVsLXR4NnVsDQogKiBpbXg3ZC1uaXRyb2dlbjcNCg0KQ29udmVydGluZyBl
dmVyeXRoaW5nIG1pZ2h0IGJlIHF1aXRlIGEgYml0IG9mIHdvcmssIGFuZCBleHBsaWNpdGx5DQpz
dXBwb3J0aW5nIG9sZCBiaW5kaW5ncyBpcyBhbHNvIHdvcmsuDQoNCkl0IGlzIHZlcnkgY29uZnVz
aW5nIHRoYXQgdGhlcmUgaXMgYSB3aG9sZSBzZXQgb2YgZGlzcGxheXMgZm9yIGlteDYvNw0Kd2hp
Y2ggYXJlIHN1cHBvcnRlZCBieSB1cHN0cmVhbSBidXQgb25seSB3aXRoIGEgbm9uLWRlZmF1bHQg
Y29uZmlnLg0KV2hpbGUgaXQgaXMgZXh0cmVtZWx5IGNvbW1vbiBpbiB0aGUgZW1iZWRkZWQgZmll
bGQgdG8gaGF2ZSBjdXN0b20NCmNvbmZpZ3MgdGhlIGRlZmF1bHQgb25lIGluIHRoZSBrZXJuZWwg
c2hvdWxkIHRyeSB0byAianVzdCB3b3JrIi4NCg0KQ291bGRuJ3QgdGhpcyBwYXRjaCBzZXJpZXMg
YmUgY29uc2lkZXJlZCBhIGJ1Z2ZpeD8gSXQgd2FzIGFsc28NCnN1cnByaXNpbmdseSBzbWFsbC4N
Cg0KLS0NClJlZ2FyZHMsDQpMZW9uYXJk
