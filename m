Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD858C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 01:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0D10222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 01:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="qEaR6Ok6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729701AbfBMBKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 20:10:09 -0500
Received: from mail-eopbgr770134.outbound.protection.outlook.com ([40.107.77.134]:46400
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726530AbfBMBKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 20:10:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i32Yy8wwpjGbFb49EpXLjNaiJN1jwLdA1/CHRtDedrU=;
 b=qEaR6Ok66f8tIleRL5AZ5C40Q1f/unqhPto3hCuN6+kd7LVdQ47goS7kRM/cUM9GSrh22lZE+0OiUwyTvD3VQH9UZIggcvjzEdPJH9sKCE+qvnkgcEcHRnEmFyim+sKaoqfR3eNlQPAKWBeEU4A0sBEoLKjrg9suAp0BvgZEF/w=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3642.namprd06.prod.outlook.com (10.167.236.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Wed, 13 Feb 2019 01:10:03 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85%5]) with mapi id 15.20.1622.016; Wed, 13 Feb 2019
 01:10:03 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "festevam@gmail.com" <festevam@gmail.com>
CC:     "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: Re: [PATCH 2/2] ARM: dts: imx7: add DMA properties for ECSPI
Thread-Topic: [PATCH 2/2] ARM: dts: imx7: add DMA properties for ECSPI
Thread-Index: AQHUvyD/DkP33gVxsUSHwHJ5QzA1bqXU0h6AgAUATgCAATwLAIAAFl6AgAANW4CAAWRIAIAAS20AgAAOAYCAAAOJAA==
Date:   Wed, 13 Feb 2019 01:10:03 +0000
Message-ID: <1550020202.3075.135.camel@impinj.com>
References: <20190107132226.16216-1-stefan@agner.ch>
         <20190107132226.16216-2-stefan@agner.ch>
         <1549573243.3075.72.camel@impinj.com> <20190211012305.GA21496@dragon>
         <1549916056.3075.102.camel@impinj.com>
         <CAOMZO5BrTLyg7Q51tPcHbN8S2VmA4HAENOVzNhw+Yx7Nniz3Gg@mail.gmail.com>
         <1549923727.3075.103.camel@impinj.com>
         <CAOMZO5Ccovx2hMU0SmPm9ToZDNXOdLWkoQ8QT7EOhLocL7GAEQ@mail.gmail.com>
         <1550016436.3075.127.camel@impinj.com>
         <CAOMZO5Ctp_p=j1G1DCaPxsyjWTK8dtKR9Ov59XGxYdiqE+1c2g@mail.gmail.com>
In-Reply-To: <CAOMZO5Ctp_p=j1G1DCaPxsyjWTK8dtKR9Ov59XGxYdiqE+1c2g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c9c90075-90fd-42b0-fcfd-08d6914ffbce
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3642;
x-ms-traffictypediagnostic: MWHPR0601MB3642:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3642;20:EIAsZwRgNrR2imKiSdc48optt7LjQXiuCFpjUHbBaS6npMQ4EPciWuKYp54fYhPvHmpPxgU1LCjkM/t6BVmzj0Yajr0nx3Q0XXVJf+Ut0Yg6DbdYhfhBcUB91bnzhRI556Y1zhPG1WwhcPC3Cpf6cQ2Ukn1VvVRbNZFZyR1VlzA=
x-microsoft-antispam-prvs: <MWHPR0601MB3642B1DA53B751B7323671FAD3660@MWHPR0601MB3642.namprd06.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39850400004)(366004)(136003)(376002)(346002)(199004)(189003)(54094003)(105586002)(1411001)(81166006)(478600001)(6436002)(966005)(5640700003)(106356001)(1730700003)(2351001)(476003)(14454004)(8676002)(53936002)(81156014)(7416002)(229853002)(6486002)(1361003)(2616005)(68736007)(256004)(14444005)(93886005)(2501003)(8936002)(71200400001)(71190400001)(6512007)(6306002)(103116003)(99286004)(2906002)(26005)(36756003)(102836004)(486006)(97736004)(25786009)(446003)(4326008)(316002)(66066001)(186003)(305945005)(7736002)(11346002)(86362001)(3846002)(53546011)(6506007)(6916009)(6116002)(76176011)(6246003)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3642;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vpR2qVWUUQiZ6QPDczMXtxLV6kJnc9jNvhK9QHgkmMNoT0pU2TOdoCMiyFEAf8Z80JA/ozR9F9TtAANyXsCvWtqyTPyUDRTgzevPmaPmg/K7JItSQxGgXIgWwQ3QnSx0yRjKdKlqgDWwrGGup04TMqPkl+lg1Yc49ru1K0YqsA8rS0qTUVdNqhcsRi7SG2/ai/Dk9/kLTOk3I/2/aRKsrBsT0rEVWzYlaXiYc6VUBkRPl1hP4tKM/gzbu3+3LworcdmQQ6/9n2rL+YR5+93ajs4ngBIDP4AonTZuh6cFrpEYOX1Nw/b2Pq1EsQ2p/KdY92lvmIj2SA0cHbohWwnETJ/4uB8U/leGd/jXlnmCqFJf/dKK98btJGVeQk7F9GjinGM7m5GR9ZAY/IWk3NtYeNDVNNELS4conKf3RXAh2y4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <621C6364E9CB144487460B453BFA5A37@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c90075-90fd-42b0-fcfd-08d6914ffbce
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 01:10:03.1803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3642
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTAyLTEyIGF0IDIyOjU3IC0wMjAwLCBGYWJpbyBFc3RldmFtIHdyb3RlOg0K
PiBPbiBUdWUsIEZlYiAxMiwgMjAxOSBhdCAxMDowNyBQTSBUcmVudCBQaWVwaG8gPHRwaWVwaG9A
aW1waW5qLmNvbT4NCj4gd3JvdGU6DQo+IA0KPiA+IFRyaWVkIFNETUEgZmlybXdhcmUgNC4yLiAg
U3RpbGwgYnJva2VuLiAgTm8gYXBwYXJlbnQgY2hhbmdlLg0KPiA+IA0KPiA+IEdldCA0IGN5Y2xl
IHBhdXNlIGFmdGVyIGVhY2ggYnl0ZS4NCj4gPiANCj4gPiBBbmQgY3Jhc2ggd2hpbGUvYWZ0ZXIg
dXNpbmcgRE1BLiAgQ2xlYXJseSBzb21lIHNvcnQgb2YgbWVtb3J5DQo+ID4gY29ycnVwdGlvbiBn
b2luZyBvbi4gIEZvcnR1bmF0ZWx5LCBpdCdzIHZlcnkgcmVsaWFibGUgdGhhdCB1c2luZw0KPiA+
IERNQQ0KPiA+IGFsbW9zdCBpbW1lZGlhdGVseSBjYXVzZXMgYSBwcm9ibGVtIGFuZCB0aGlzIGlz
IGVhc3kgdG8NCj4gPiByZXByb2R1Y2UuICBJDQo+ID4gdGhpbmsgdGhhdCBpbmRpY2F0ZXMgaXQn
cyBlaXRoZXIgY2xvYmJlcnMgYSBsb3Qgb2YgUkFNLCBvcg0KPiA+IGNvbnNpc3RlbnRseQ0KPiA+
IG1hbmFnZXMgdG8gaGl0IGEgdmVyeSBpbXBvcnRhbnQgbG9jYXRpb24gZm9yIGtlcm5lbCBtZW1v
cnkNCj4gPiBhbGxvY2F0b3JzLg0KPiA+IA0KPiA+IEkndmUgZ290IGFuIGlkZWEgb2Ygd2hlcmUg
dGhhdCBtaWdodCBiZSBoYXBwZW5pbmcgdGhhdCBJJ20gbG9va2luZw0KPiA+IGludG8uDQo+IA0K
PiBPaywgdGhhbmtzIGZvciBpbnZlc3RpZ2F0aW5nIHRoaXMgaXNzdWUuDQo+IA0KPiA+IA0KPiA+
IEkgdGhpbmsgaXQncyByZWFzb25hYmxlIHRvIGFkZCB0aGUgZG1hIGF0dHJpYnV0ZXMsIGJ1dCBw
dXQgYSBjaGVjaw0KPiA+IGluDQo+ID4gdGhlIHNwaS1pbXggZHJpdmVyIHRvIGRpc2FibGUgRE1B
IG9uIGlteDdkIGF0IGxlYXN0Lg0KPiANCj4gU29tZXRoaW5nIGxpa2UgdGhpcz8NCmh0dHA6Ly9k
YXJrLWNvZGUuYnVsaXgub3JnL3VyZm9oOC01ODAxNzQNCg0KU29tZXRoaW5nIGxpa2UgdGhhdC4g
IEkgdGhvdWdodCBhIHByaW50ayBvbiBwcm9iZSwgdGhhdCBETUEgd2FzDQpkaXNhYmxlZCwgd291
bGQgYmUgbmljZSBzbyBubyBvbmUgYmVhdHMgdGhlaXIgaGVhZCBhZ2FpbnN0IHRoZSB3YWxsDQp0
cnlpbmcgdG8gZmlndXJlIG91dCB3aHkgRE1BIGlzbid0IGJlaW5nIHVzZWQuDQoNCkJ1dCBJIHRo
aW5rIEkndmUgZm91bmQgdGhlIGlzc3VlIGFuZCB0cmFja2VkIGl0IHRvIGJ1ZyBpbiB0aGUgc3Bp
IGNvcmUuDQogIEknbGwgc2VuZCBhIHBhdGNoIHNob3J0bHkuICBJdCBzaG91bGQgYWZmZWN0IGFu
eXRoaW5nIHRoYXQgdXNlcyBETUEsDQp3aXRoIGEgc3BpIG1hc3RlciB0aGF0IHJlcXVpcmVzIFJY
IGFuZC9vciBUWCBidWZmZXJzLCBhbmQgYSBzcGkNCnRyYW5zZmVyIHRoYXQgZG9lcyBub3QgcHJv
dmlkZSB0aGUgcmVxdWlyZSBidWZmZXIocykuICBJbiBteSBjYXNlLCBzcGktDQppbXggcmVxdWly
ZXMgYW4gUlggYnVmZmVyIGJ1dCBJIGFtIGRvaW5nIFRYIG9ubHkgRE1BLiAgVGhlIHNwaSBjb3Jl
DQp0YWtlcyBjYXJlIG9mIHRoaXMsIGJ1dCBJIHRoaW5rIHRoZXJlIGlzIGEgcmFjZSBpbiB0aGUg
Y2xlYW51cCBvZiB0aGUNCmR1bW15IFJYIERNQSBidWZmZXIuDQoNClRoaXMgYXBwZWFycyB0byBj
bG9iYmVyIHNvbWV0aGluZyByZWxhdGluZyB0byBETUEgYnVmZmVyIGFsbG9jYXRpb24gYW5kDQp0
aGUga2VybmVsIHN0YXJ0cyB0byBhbGxvY2F0ZSBib2d1cyBETUEgYnVmZmVyIGFkZHJlc3Nlcywg
YW5kIHRoZSBTUEkNCmNvbnRyb2xsZXIgaGFwcGlseSBETUFzIGFsbCBvdmVyIG1lbW9yeS4gIEkg
d29uZGVyIGlmIHRoYXQgY291bGQgYmUNCnNvbWVob3cgZXhwbG9pdGVkIHRvIHJlYWQvd3JpdGUg
YXJiaXRyYXJ5IG1lbW9yeSB2aWEgU1BJIERNQT8=
