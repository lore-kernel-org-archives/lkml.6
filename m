Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC807C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA187218D0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mFNelOE/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbfAHJdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:33:22 -0500
Received: from mail-eopbgr30056.outbound.protection.outlook.com ([40.107.3.56]:47990
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727689AbfAHJdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:33:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqV5IvbjO/Hs4495vMPopacyxz8Ae5hS0f6FRq2PuHI=;
 b=mFNelOE/qadjceqUhBxCgnyCzGhvu5PDvlw96jzmeHSZJAU2JxbPM8Ew9S7aLl3qMq6O9Zr8ivfIMuZbVzdMrCY8xBxSGKXJlcsSR566vnBrARpIzmpVtYxdPdrHCA3VvNgJiehvJIgdMcCSKaTtOQL4eYquC+BM20BjK1l9H6U=
Received: from VI1PR0402MB3519.eurprd04.prod.outlook.com (52.134.4.24) by
 VI1SPR01MB326.eurprd04.prod.outlook.com (10.165.198.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.13; Tue, 8 Jan 2019 09:33:18 +0000
Received: from VI1PR0402MB3519.eurprd04.prod.outlook.com
 ([fe80::5d51:a6f6:df78:87e]) by VI1PR0402MB3519.eurprd04.prod.outlook.com
 ([fe80::5d51:a6f6:df78:87e%5]) with mapi id 15.20.1495.011; Tue, 8 Jan 2019
 09:33:18 +0000
From:   Jacky Bai <ping.bai@nxp.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v2 2/2] driver: clocksource: Add nxp system counter timer
 driver support
Thread-Topic: [PATCH v2 2/2] driver: clocksource: Add nxp system counter timer
 driver support
Thread-Index: AQHUkduDSPUR4D8ONkaAhIX2AZ1ft6V7cswAgCnNt1A=
Date:   Tue, 8 Jan 2019 09:33:18 +0000
Message-ID: <VI1PR0402MB3519AF0CEF41F24867B10986878A0@VI1PR0402MB3519.eurprd04.prod.outlook.com>
References: <1544592770-19996-1-git-send-email-ping.bai@nxp.com>
 <1544592770-19996-2-git-send-email-ping.bai@nxp.com>
 <dbe836ff-cd29-a693-4d83-a2fee419b424@infradead.org>
In-Reply-To: <dbe836ff-cd29-a693-4d83-a2fee419b424@infradead.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ping.bai@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1SPR01MB326;6:f/LJa7bvb8fol0+gKgDEQEJtGU6m4V6yXGBBchzRoOw7weK1cb5XWpi03rwphVqDMuWMDbI+1YW4zSNkorbPibWWMN+3NO9obd0L6nJn1ScS6EYuE+LNzO48HFvVFHMkUfnG+uBg2JNgxsh+dP7AP/EviPIrwVzC+cuY/f0kOK/dRCP9PpjjmCNA/whfMoUmTXHY4xK7B+Rz/on/VcQNivRYt840JvL1Bzs9XIUoLJa84S233dJAUtWtDSHMwfqgVsP3/QHN43sPiXTAJXYQzAs4ABIv/KKFE1BXuAfB0pL0H0jY8fHMtMA3sDyRUHSnvyCLzRYEaQr0bHC7UBA+TfDqCbsPgmLVzup8TLZxt4PA7gRQJaIkXul1J1emplSM2AAiHz8iRE4dVvQsOo0yDjYP+GsHBShb7QSaptvS5DRKG0wbsV/nNwhsTwRzEVz7y7exXTbYicVIraQRN2HlWg==;5:KrJukW4MgnqVB+lzXd1lRL9EgkejRSvw5NJ/L6WZ/yvistExVFiRmjKFrcvcZLEKMgg6UZagE9nYSP68q5xHpc3Ogxh+a+z2s+DRn8gumpyHoE7YyS+figaY3AmRNCkIjx0Mj0VWTDBCybNdtgcRMU9OsfWIDbHoCJEDoSgthYuK3i+bj8A1ACbpwzwhPPT8+aV97VHvZpeYgYEWqQr+ZA==;7:E/RW03XteL1ptUKXLZb5LWVfBTj+LtdBdUYasGphnOC0S91FgbKIzKS0isKwyfPv1NVgSk0Gf1lh+BscJm+UdAjfCUXEaR4/w2fHeRXYU7t4AhcY45XrHLw5KZaVCNxp57DUZMEEfB6iBSsxEH7O1A==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: fa9fa579-9364-4206-9cab-08d6754c52ab
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1SPR01MB326;
x-ms-traffictypediagnostic: VI1SPR01MB326:
x-microsoft-antispam-prvs: <VI1SPR01MB3261FC92A23A112F3E0C3FD878A0@VI1SPR01MB326.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1SPR01MB326;BCL:0;PCL:0;RULEID:;SRVR:VI1SPR01MB326;
x-forefront-prvs: 0911D5CE78
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39860400002)(396003)(136003)(346002)(189003)(199004)(6636002)(68736007)(476003)(5660300001)(9686003)(14454004)(66066001)(106356001)(105586002)(305945005)(446003)(99286004)(229853002)(7736002)(33656002)(74316002)(6436002)(486006)(55016002)(316002)(54906003)(110136005)(478600001)(53936002)(4326008)(11346002)(6246003)(2201001)(86362001)(256004)(71190400001)(71200400001)(102836004)(81166006)(2906002)(8936002)(97736004)(186003)(8676002)(26005)(81156014)(76176011)(7696005)(6116002)(3846002)(6506007)(53546011)(2501003)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1SPR01MB326;H:VI1PR0402MB3519.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EKmXZqdeRRYqYSSbInEyEAlzamLn7KnuLOXz+HYF5NIFpPQKAJEk2Xw65RHgh8HoRdZUJblGCzAlbqbGSJs3zTNjB+1gcqgNrEla3xsToYR3gxoeP6gX1zAwNEJRMYXPBZUcjC3uq5ROFBBntoiL/OvYhZR8Pym6Sd/C1Tt16c4g4xYZ6NfaXQ3tTCxhItoli2H4A782SPBYbdn+eoFCo6k9uEEUR6oQ8DgVChScddprozfs+yrj15PfdlNsCUHO3fmT5MWWhxe+cF9CogXGYAmTDx/Zoc278MSv6KBKGr05ZYy/q5ckw4z1utFurHKN
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa9fa579-9364-4206-9cab-08d6754c52ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2019 09:33:18.2995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1SPR01MB326
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDIvMl0gZHJpdmVyOiBjbG9ja3NvdXJjZTogQWRkIG54
cCBzeXN0ZW0gY291bnRlciB0aW1lcg0KPiBkcml2ZXIgc3VwcG9ydA0KPiANCj4gSGksDQo+IA0K
PiBPbiAxMi8xMS8xOCA5OjI4IFBNLCBKYWNreSBCYWkgd3JvdGU6DQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvY2xvY2tzb3VyY2UvS2NvbmZpZyBiL2RyaXZlcnMvY2xvY2tzb3VyY2UvS2NvbmZp
Zw0KPiA+IGluZGV4IGM1N2IxNTYuLjdlNWYyZGUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9j
bG9ja3NvdXJjZS9LY29uZmlnDQo+ID4gKysrIGIvZHJpdmVycy9jbG9ja3NvdXJjZS9LY29uZmln
DQo+ID4gQEAgLTU3OSw2ICs1NzksMTQgQEAgY29uZmlnIENMS1NSQ19JTVhfVFBNDQo+ID4gIAkg
IEVuYWJsZSB0aGlzIG9wdGlvbiB0byB1c2UgSU1YIFRpbWVyL1BXTSBNb2R1bGUgKFRQTSkgdGlt
ZXIgYXMNCj4gPiAgCSAgY2xvY2tzb3VyY2UuDQo+ID4NCj4gPiArY29uZmlnIENMS1NSQ19JTVhf
U1lTX0NUUg0KPiA+ICsJYm9vbCAiQ2xvY2tzb3VyY2UgdXNpbmcgaS5NWCBzeXN0ZW0gY291bnRl
ciIgaWYgQ09NUElMRV9URVNUDQo+IA0KPiBMb29rcyBsaWtlIGEgIm1ha2UgKmNvbmZpZyIgdXNl
ciBvbmx5IGdldHMgdGhpcyBwcm9tcHQgaWYgQ09NUElMRV9URVNUIGlzIHNldC4NCj4gDQo+IElm
IENPTVBJTEVfVEVTVCBpcyBub3Qgc2V0LCBob3cgZG9lcyB0aGlzIGRyaXZlciBiZWNvbWUgZW5h
YmxlZC9zZXQ/DQo+IA0KPiANCg0KU29ycnkgZm9yIHJlcGx5IHRvIHlvdSBzbyBsYXRlci4gdGhp
cyBkcml2ZXIgbmVlZCB0byBiZSBlbmFibGUgZXhwbGljaXRseSB3aGVuIElNWCBzb2MgaXMgYnVp
bHQuDQoNCkJSDQo+ID4gKwlkZXBlbmRzIG9uIChBUk0gfHwgQVJNNjQpICYmIENMS0RFVl9MT09L
VVANCj4gPiArCXNlbGVjdCBDTEtTUkNfTU1JTw0KPiA+ICsJaGVscA0KPiA+ICsJICBFbmFibGUg
dGhpcyBvcHRpb24gdG8gdXNlIElNWCBzeXN0ZW0gY291bnRlciB0aW1lciBhcw0KPiA+ICsJICBj
bG9ja3NvdXJjZS4NCj4gPiArDQo+ID4gIGNvbmZpZyBDTEtTUkNfU1RfTFBDDQo+ID4gIAlib29s
ICJMb3cgcG93ZXIgY2xvY2tzb3VyY2UgZm91bmQgaW4gdGhlIExQQyIgaWYgQ09NUElMRV9URVNU
DQo+ID4gIAlzZWxlY3QgVElNRVJfT0YgaWYgT0YNCj4gDQo+IHRoYW5rcywNCj4gLS0NCj4gflJh
bmR5DQo=
