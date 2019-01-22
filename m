Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86794C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4211720879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LMqXiGZ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbfAVLEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 06:04:53 -0500
Received: from mail-eopbgr130051.outbound.protection.outlook.com ([40.107.13.51]:51073
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727048AbfAVLEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 06:04:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SzePpS4eVYoxpHQQZs61xQxHykqVKZyXHqSG3794VO8=;
 b=LMqXiGZ7EKf4aopL7wZ8NXciVXP9Znuw9MWi+zGBqWpFVmelMQImhnlYhDhdv7665RiSCLx/T01FllMR6lD6lha0sZoFUOfQTW1iBfXRdfHvO5i2qrTi5yNTGe2GyvGmqHqtxlSan7SWeHppZwZbb8MN/r+iZx9ZqdLzbxvH2IY=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5875.eurprd04.prod.outlook.com (20.178.202.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.31; Tue, 22 Jan 2019 11:04:48 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%5]) with mapi id 15.20.1558.016; Tue, 22 Jan 2019
 11:04:48 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: RE: [PATCH 1/1] irqchip: gpcv2: make config option visible
Thread-Topic: [PATCH 1/1] irqchip: gpcv2: make config option visible
Thread-Index: AQHUrwExKd8SdkCETUqu4TDod0IgjqW0vfmAgAAJiQCAAAZKgIAGVosg
Date:   Tue, 22 Jan 2019 11:04:48 +0000
Message-ID: <AM0PR04MB4211ACC01F82236A7A34944780980@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1547796918-29790-1-git-send-email-aisheng.dong@nxp.com>
 <25cd3e29-e365-f0d4-65a3-b3af69acd9cd@arm.com>
 <AM0PR04MB421158B2E042D623792A296E809C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <77ecfcfa-16fe-a3e2-3d6b-90cdf999b316@arm.com>
In-Reply-To: <77ecfcfa-16fe-a3e2-3d6b-90cdf999b316@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5875;6:vMVxbCNE0IueUwEMCempuSEXNuhQUPV+vn1iiv96D9lgfwCNBkT4SK5TS4rOTg8NAVIi9z9DPu20R9BljExFc3oNhphLB57K4rKxjKU16yOYJ7AU+r7NVUQGGbFXpO7srlAO/CCizmbD4eQHDCSnlOZLe0HbErIRnOXp/2SEUe8ldfaDyqIAAMZohAT3mk/hU2rDxwy6baIKlZSin+5A0kCwgjXuHaYAwoWK9Igi1eVQnTVdLOxGLU44NNhxJFFuGfytJ9lJ6jMf8pU6dZ2zY1IK+QFEQB3d7WLuweKDn8i86SbzjRVDRYhN5g55+BmMGV1ANiYaSD6SVfrtud333htNol2W0RclbEJVkOToxY7673S9Z0Rj7Xi36XM8fs1IfakmESkKxPgrVTydqOpnoJdiWaLGSalpE62bmVsWcxKhc3+g19rpw+iDFic5xSTPYlqgU9jQrpNV6VYcO7lNow==;5:y3hUBDGWRLbZ/Rk6Bk2ePcZ9557e/1aAtNcDsHm5FlYsRw6Gje0HZsxWPB/agfWTY4vMiks+CrXayiledFGOH5ISV0+ciBO+o6RXDxvvNf5+Dnr/6vDkO5TVsJrFDtB9IO1BDLfMbKcqu5a4jhPpxutLjBouyjrmgea5KpMbLMGHB4Q96kYZLbZEW2X5of+UOXpu6YaL8FqE2nvV65UjZg==;7:5jkO7FpetjVJPsJiR2KQrDrG1lllzrY+CSNzfYhVyOxSgrLPrp4HRFf/0LQHhG4H3hKV08EyNCdG16hRc2AcFCdx6MPCJMUQdCmZsx/uVeVPk9T1BRjMTQXgQ1MUFybeENzRcud+QihoWqS9sCrsyQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 69ad3122-c40a-4e0a-7882-08d680596cd0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5875;
x-ms-traffictypediagnostic: AM0PR04MB5875:
x-microsoft-antispam-prvs: <AM0PR04MB587518A99BDCD7870AD108DE80980@AM0PR04MB5875.eurprd04.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(136003)(346002)(396003)(189003)(199004)(7696005)(6506007)(76176011)(74316002)(93886005)(478600001)(71190400001)(71200400001)(68736007)(3846002)(106356001)(8936002)(2906002)(66066001)(86362001)(6116002)(81166006)(105586002)(81156014)(8676002)(55016002)(6436002)(4326008)(25786009)(2501003)(256004)(14454004)(9686003)(97736004)(305945005)(53936002)(44832011)(229853002)(6246003)(33656002)(26005)(11346002)(476003)(486006)(99286004)(7736002)(54906003)(186003)(39060400002)(316002)(102836004)(110136005)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5875;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: H5WJ/0rIcbLVWxJwlro7usyTxJF1qU2AuGsTz3jH621vfLgzdUwzrsBspPwQ+RiC5t+k1dXQdixDRZ70Xhk+NLaXGiEILfPjdJnFuXdIa9qiELt7yv/vsxlEfrTwNYwIwI8yAlz/xodTUWtgUtjoX4aLqgX0+Snb0Gwf85MbmBhBp6aAkMqZB2UkemNEG/jzrenheyoBUGJ5oF0DNKS9WnbcxRozgWtr3iegL1YYbxNbbjCH51wbIzng+UlizF8TOTP5F4ZKYAZIt3YxVXx/TZ6oq4KgBYpEeyTquDT0YCTi03gezMIBWa9fs3mBXImTxi59SF7opYGlifn3YOGqZzRtuDJwJI0hAJigaAU9VO6tco1cW/vR4Z/MrSN1p08cF7xmhYVgDsFvDud55TESuaZEAJpqm2gb4KRzIVCfYw0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69ad3122-c40a-4e0a-7882-08d680596cd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 11:04:48.5260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5875
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gRnJvbTogTWFyYyBaeW5naWVyIFttYWlsdG86bWFyYy56eW5naWVyQGFybS5jb21dDQo+
IFNlbnQ6IEZyaWRheSwgSmFudWFyeSAxOCwgMjAxOSA2OjEwIFBNDQpbLi4uXQ0KPiA+Pj4NCj4g
Pj4+ICBjb25maWcgSU1YX0dQQ1YyDQo+ID4+PiAtCWJvb2wNCj4gPj4+ICsJYm9vbCAiaS5NWCBH
UEN2MiBJUlEgY2hpcCINCj4gPj4+ICsJZGVwZW5kcyBvbiBBUkNIX01YQyB8fCAoQ09NUElMRV9U
RVNUICYmIE9GKQ0KPiA+Pj4gIAlzZWxlY3QgSVJRX0RPTUFJTg0KPiA+Pj4gIAloZWxwDQo+ID4+
PiAgCSAgRW5hYmxlcyB0aGUgd2FrZXVwIElSUXMgZm9yIElNWCBwbGF0Zm9ybXMgd2l0aCBHUEN2
MiBibG9jaw0KPiA+Pj4NCj4gPj4NCj4gPj4gSG93IGRvZXMgaXQgaGVscCBleGFjdGx5PyBJdCBp
cyBwcmV0dHkgZGlmZmljdWx0IGZvciBhIHVzZXIgdG8ga25vdw0KPiA+PiBleGFjdGx5IHdoYXQg
dGhleSBuZWVkLiBJJ2QgcmF0aGVyIHNlZSBpdCBzZWxlY3RlZCBieSBBUkNIX01YQywgd2hpY2gN
Cj4gPj4gbWFrZXMgaXQNCj4gPg0KPiA+IEFSTTY0IFNvQyBtYWludGFpbmVycyBzdWdnZXN0IG5v
dCBhZGQgbW9yZSBkcml2ZXIgc3BlY2lmaWMgb3B0aW9ucw0KPiA+IGV4Y2VwdCBhbiBHZW5lcmlj
IEFSQ0ggb3B0aW9uLg0KPiA+DQo+ID4gQXMgR1BDdjIgaXMgYWxzbyB1c2VkIGluIE1YOE1RLiBT
byB3ZSBtYXkgc2VsZWN0IGl0IGluIGFybXY4IGRlZmNvbmZpZy4NCj4gPiBJZiB0aGlzIG9wdGlv
biBpcyBpbnZpc2libGUsIHdlIGNhbid0IHNlbGVjdCBpdC4NCj4gDQo+IEFuZCBjb252ZXJzZWx5
LCB1c2VycyBoYXZlIG5vIGlkZWEgb2Ygd2hhdCBsZXR0ZXIgc291cCB0aGV5IGhhdmUgdG8gc2Vs
ZWN0IHRvDQo+IG1ha2UgdGhlaXIgSFcgd29yayBwcm9wZXJseS4gU2VsZWN0aW5nIHRoZSBkcml2
ZXIgd2hlbiB0aGUgcGxhdGZvcm0gaXMNCj4gc3VwcG9zZWQgdG8gYmUgc3VwcG9ydGVkIGlzIHRo
ZSByaWdodCB3YXkgdG8gc29sdmUgdGhpcyBwcm9ibGVtLg0KPiANCg0KSSB0aGluayB0aGUgcHJv
YmxlbSBpcyB0aGF0IHdlIGhhdmUgbm8gcGxhdGZvcm0gc3BlY2lmaWMgQ09ORklHcyBmb3IgYXJt
IHY4IHBsYXRmb3Jtcy4NCldlIGhhdmUgb25seSBvbmUgQ09ORklHX0FSQ0hfTVhDIGZvciBhbGwg
TVg4IFNvQ3MsIGUuZy4gbXg4cXhwLCBteDhtcS4uLg0KT25seSBNWDhNUSBuZWVkcyB0byB1c2Ug
R1BDdjIuIFNlbGVjdGluZyBHUEN2MiB1bmRlciBBUkNIX01YQyBtZWFucyB1c2Vycw0KaGF2ZSBu
byBjaGFuY2UgdG8gZGlzYWJsZSBpdCBmb3IgbXg4cXhwIHdoaWNoIGRvZXMgbm90IG5lZWQgaXQu
DQoNCldlIHByb2JhYmx5IGNvdWxkIGludHJvZHVjZSBTT0Mgb3B0aW9uIHVuZGVyIGRyaXZlcnMv
c29jLyB0byBkbyB0aGUgZGVmYXVsdCBjb25maWdzDQpzZWxlY3Rpb24uIEJ1dCB3ZSd2ZSBhbHJl
YWR5IGhhbmRsZWQgYWxsIG90aGVyIGRyaXZlciBzZWxlY3Rpb25zIGluIGRlZmNvbmZpZw0KZS5n
LiBmaXJtd2FyZSwgY2xrLCBwaW5jdHJsLCBwb3dlciBkb21haW4gYW5kIGV0Yy4NCk5vdCBzdXJl
IHdoZXRoZXIgR1BDdjIgc2hvdWxkIGJlIGFuIGV4Y2VwdGlvbi4NCg0KUmVnYXJkcw0KRG9uZyBB
aXNoZW5nDQoNCj4gVGhhbmtzLA0KPiANCj4gCU0uDQo+IC0tDQo+IEphenogaXMgbm90IGRlYWQu
IEl0IGp1c3Qgc21lbGxzIGZ1bm55Li4uDQo=
