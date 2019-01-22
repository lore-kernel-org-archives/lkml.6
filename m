Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1E8C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0148F20854
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="vEB/I1M+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfAVHu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 02:50:27 -0500
Received: from mail-eopbgr10089.outbound.protection.outlook.com ([40.107.1.89]:44032
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727219AbfAVHu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 02:50:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NsSZIIYMTnlJ7pz2PzPUOJVoKsudGTx4pWKzVTK6Mxo=;
 b=vEB/I1M+mndDibmi2FihZgStClf0UEmwufqTSK5UTrAO2F/3R4pGbW0bBFV1cVPyPWVahYMOS8R6qnI2y+pcFQ8JL8n3eFz4w7UCcv6q/TkOzvUElC8bfFv4eJGncKlacTIunWaohcd375WWd3WQqf4oqhIVGo6/uQ7hXbKOv7Y=
Received: from AM0PR04MB5314.eurprd04.prod.outlook.com (20.177.42.87) by
 AM0PR04MB5396.eurprd04.prod.outlook.com (20.178.113.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.29; Tue, 22 Jan 2019 07:50:09 +0000
Received: from AM0PR04MB5314.eurprd04.prod.outlook.com
 ([fe80::a01b:d7d4:87d7:d4f5]) by AM0PR04MB5314.eurprd04.prod.outlook.com
 ([fe80::a01b:d7d4:87d7:d4f5%5]) with mapi id 15.20.1537.031; Tue, 22 Jan 2019
 07:50:09 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Philipp Puschmann <pp@emlix.com>,
        Philipp Puschmann <philipp.puschmann@emlix.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/2] dt-bindings: usb: ci-hdrc-usb2: add property
 power-active-high
Thread-Topic: [PATCH v3 1/2] dt-bindings: usb: ci-hdrc-usb2: add property
 power-active-high
Thread-Index: AQHUrYw/5wxJwf4f10q/6GCCK3hl76WzB9QwgAcDgoCAAOc4kA==
Date:   Tue, 22 Jan 2019 07:50:09 +0000
Message-ID: <AM0PR04MB5314CEFFC0FEB91184FD872D8B980@AM0PR04MB5314.eurprd04.prod.outlook.com>
References: <20190116105103.28842-2-philipp.puschmann@emlix.com>
 <20190116111133.31326-1-philipp.puschmann@emlix.com>
 <VI1PR04MB5327656AD22454B054CE0AD08B830@VI1PR04MB5327.eurprd04.prod.outlook.com>
 <7d0da12b-0173-aca1-b0eb-78a00681d35d@emlix.com>
In-Reply-To: <7d0da12b-0173-aca1-b0eb-78a00681d35d@emlix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5396;6:QdI3ZDg0fUBOyFn1lgiJcsjxkqnTDTtQCeomvMfsGWe1ONu/cIg2twbltuWICUdaiOmjRCyA2/oHVJ/GIwbKVFwzU9UI54p5l49RJhQKiSqm30Pt8yG3KwwXAyGxZ8f6WZkzyQEvQoWYQeRj5bmiHg3szCQyqblGO/sx6XVIosPUqp0k1b2wA/znD0XWdBqPqvyxijAfxpsQCQ7/QdKUqxMa5LyJNuJMKCVLEIxP3fAQucF+GnDSaa/g7X2+wnZi5Rvoa+fRAcNNA4ACUB8pnE9TB6VRN4rMr9qBJdtG2ryJW8ydB5qrMmTcaDJyM5JMfpXs8wzWKcmYyR6uaWOwRC2+MjACrQLhm29NW8XRWxPWwtsYqrmeXMNz0PazV7AcfG5D9oiBdYJBUk5ov3lSiKKY7DD0ah1223gDFrV1V59AnHfjLkRoW1tari6ybZF8RsoQmE1HFf7623xbYZyQIw==;5:H5lgSzUVQN0TkyYdx0fGLsv5lIQyLBOBkUwoDdbllxxZOiZew+qF0cyDkkQF//aUEOpG47efmNGCFNCQNnMcEploBq0qTPFkVMQUOxD8aQmBQdI/VNyq+HWxSH7yGr0aNjWJEZTrDWavpDiwf+Swgfg8FW1fmfdGPnvHqxK1+wdn96m/o348wtVOGlOQUmbZRyuc7oYvXPE0GkTve5Mq4w==;7:2GHnEAb9tvyE8j/qTe+/y+lbvZesbXzBtO++p4gVSApfUWmwIGmVQxi9Pm2RSN1h0yoUHokR0LZjiAayfp3Yl/W7brw7lG71sg1GaV/XzQJy4FjSYoAhrfv0by2Jto4lZ8kGf5uJD8pKLDJW33sZjg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b8ebed83-2888-45c2-6313-08d6803e3bc6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5396;
x-ms-traffictypediagnostic: AM0PR04MB5396:
x-microsoft-antispam-prvs: <AM0PR04MB53963B7A66C24A4CDAC7072F8B980@AM0PR04MB5396.eurprd04.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(396003)(376002)(136003)(189003)(199004)(229853002)(256004)(25786009)(106356001)(44832011)(68736007)(105586002)(8676002)(102836004)(66066001)(2906002)(3846002)(33656002)(6436002)(71190400001)(71200400001)(6116002)(14454004)(4326008)(6246003)(478600001)(55016002)(316002)(93886005)(110136005)(53936002)(486006)(305945005)(9686003)(99286004)(8936002)(26005)(11346002)(86362001)(2501003)(81156014)(81166006)(476003)(6506007)(186003)(97736004)(54906003)(74316002)(7736002)(76176011)(7696005)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5396;H:AM0PR04MB5314.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RGAi1cVNZRPov/OqBNtruUXap1eOZ/xWSAe2Pd0U8FgZBOvu01++LsnvZLpquCBfc6QebCUwkFMNdm2n1JpRQjTbSX+hnEBDANbKdKui+0bhgL5jTh4dZqseyieM9sBeD2nhqdJZaItxgbrUdOEqDhL1OOoMlJk+f01cIED05ihDDFelonq0L9jxvy8E3akHC56BAW055IoIKuIhzwS4fF+x/xngGDbKW68cSIqvBc9UBfdilA0ljvK5w4QViV+d/sqbf1G9dSjEv936qbJqdFVf57sXgIQtBDw8xd1CS4EbFEvm5bIAUkV8Ww/2PxCKciVpCK5Vqp8oZqXEX/DXpXmZ9jvVpQweo0hWHmJ7KaPnO/dl2FWIM3QYXPXAalW41XscKiiNXLdkJGcn+7eopiQa1gBY5NMJwRZzklBBbM0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8ebed83-2888-45c2-6313-08d6803e3bc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 07:50:09.7547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5396
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IA0KPiBBbSAxNy4wMS4xOSB1bSAwODowMSBzY2hyaWViIFBldGVyIENoZW46DQo+ID4NCj4gPj4N
Cj4gPj4gVGhlIGkuTVg2cS9kbCBVU0IgY29udHJvbGxlciBtYXkgZHJpdmUgdGhlIHVzYiBwb3dl
ciBsaW5lIGRpcmVjdGx5LA0KPiA+PiBidXQgdGhlIHBvbGFyaXR5IGRlcGVuZHMgb24gdGhlIGJv
YXJkLiBSZXNldCBzdGF0ZSBvZiB0aGUgcG9sYXJpdHkgaXMNCj4gPj4gbG93LWFjdGl2ZSBzbyBh
ZGQgdGhpcyBwcm9wZXJ0eSB0byBhbGxvdyBpdCB0byBiZSBoaWdoLWFjdGl2ZS4NCj4gPj4NCj4g
Pg0KPiA+IEFzIGZhciBhcyBJIGtub3csIG1vc3Qgb2YgaS5teCBVU0IgY29udHJvbGxlcnMgKGV4
Y2VwdCBpbXgyOC8yMywgYnV0DQo+ID4gdGhleSBkb24ndCBoYXZlIG5vbi1jb3JlIHJlZ2lzdGVy
cykgd29yayBsaWtlIHRoaXMsIGFuZCBtb3N0IG9mIHRoZW0NCj4gPiBhcmUgbG93IGFjdGl2ZSBm
b3IgUFAgZGVmYXVsdC4gV291bGQgeW91IGp1c3QgdXNlICJpLm14IiBhdCBib3RoIHlvdXIgY29k
ZSBhbmQNCj4geW91ciBjb21tZW50Pw0KPiANCj4gQW0gaSByaWdodCB0aGF0IGkgaGF2ZSB0byBh
ZGQgbXkgY29kZSBibG9jayB0byAobmVhcmx5KSBhbGwgb3RoZXIgdmVyc2lvbiBzcGVjaWZpYyBp
bml0DQo+IGZ1bmN0aW9ucyB0aGVuPw0KDQpCZXNpZGVzIHlvdXIgY3VycmVudCBwYXRjaCwgb25s
eSB1c2JtaXNjX2lteDdkX2luaXQgaXMgbmVlZGVkIHRvIGFkZCB0aGUgc2FtZSBjb250ZW50Lg0K
DQpQZXRlcg0KDQo+IFdpbGwgZG8gc28gaW4gbmV4dCBkYXlzIGFuZCB0aGVuIHNlbmQgYSB2NCBv
ZiB0aGlzIHBhdGNoLg0KPiA+DQo+ID4gUGV0ZXINCj4gPg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBQ
aGlsaXBwIFB1c2NobWFubiA8cGhpbGlwcC5wdXNjaG1hbm5AZW1saXguY29tPg0KPiA+PiAtLS0N
Cj4gPj4gQ2hhbmdlcyBpbiB2MzogYWRkIGRlc2NyaXB0aW9uDQo+ID4+IC0tLQ0KPiA+PiAgRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9jaS1oZHJjLXVzYjIudHh0IHwgMSAr
DQo+ID4+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gPj4NCj4gPj4gZGlmZiAt
LWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvY2ktaGRyYy11c2Iy
LnR4dA0KPiA+PiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvY2ktaGRy
Yy11c2IyLnR4dA0KPiA+PiBpbmRleCBhZGFlODIzODVkZDYuLjg2OTZlM2VmZjZlNyAxMDA2NDQN
Cj4gPj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9jaS1oZHJj
LXVzYjIudHh0DQo+ID4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91
c2IvY2ktaGRyYy11c2IyLnR4dA0KPiA+PiBAQCAtOTMsNiArOTMsNyBAQCBpLm14IHNwZWNpZmlj
IHByb3BlcnRpZXMNCj4gPj4gIC0gb3Zlci1jdXJyZW50LWFjdGl2ZS1sb3c6IG92ZXIgY3VycmVu
dCBzaWduYWwgcG9sYXJpdHkgaXMgYWN0aXZlIGxvdy4NCj4gPj4gIC0gb3Zlci1jdXJyZW50LWFj
dGl2ZS1oaWdoOiBvdmVyIGN1cnJlbnQgc2lnbmFsIHBvbGFyaXR5IGlzIGFjdGl2ZSBoaWdoLg0K
PiA+PiAgICBJdCdzIHJlY29tbWVuZGVkIHRvIHNwZWNpZnkgdGhlIG92ZXIgY3VycmVudCBwb2xh
cml0eS4NCj4gPj4gKy0gcG93ZXItYWN0aXZlLWhpZ2g6IHBvd2VyIHNpZ25hbCBwb2xhcml0eSBp
cyBoaWdoIGFjdGl2ZSAob25seSBmb3INCj4gPj4gK2lteDZxL2RsKQ0KPiA+PiAgLSBleHRlcm5h
bC12YnVzLWRpdmlkZXI6IGVuYWJsZXMgb2ZmLWNoaXAgcmVzaXN0b3IgZGl2aWRlciBmb3IgVmJ1
cw0KPiA+Pg0KPiA+PiAgRXhhbXBsZToNCj4gPj4gLS0NCj4gPj4gMi4yMC4xDQo+ID4NCg==
