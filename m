Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D94C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 02:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C6325700
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 02:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NPSXofzc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50C6325700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933150AbeGBCM6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 22:12:58 -0400
Received: from mail-eopbgr70045.outbound.protection.outlook.com ([40.107.7.45]:56112
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932734AbeGBCM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 22:12:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=em56XSnHbW1VP+WVU+Q60wZGLmWAjRvG2XVgESI3gfM=;
 b=NPSXofzcskheyw5RypwQsz7M+5k2k9AxJwyQfsHod7LEVjh45ICws8FBKWTm2RT4iGnV+yE3IpnA+cO9YDzIAFF/KzwBL6ZgivqmWQ3JKYD7QNZhJenwdclICOvg9Kpucg2BQKnYYk1i5kZH7wRsNQRBuISYN0MdrZZ5Bk3x6X0=
Received: from DB6PR04MB3223.eurprd04.prod.outlook.com (10.170.211.19) by
 DB6PR04MB3239.eurprd04.prod.outlook.com (10.170.215.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.25; Mon, 2 Jul 2018 02:12:52 +0000
Received: from DB6PR04MB3223.eurprd04.prod.outlook.com
 ([fe80::982d:7c4d:d525:42f9]) by DB6PR04MB3223.eurprd04.prod.outlook.com
 ([fe80::982d:7c4d:d525:42f9%5]) with mapi id 15.20.0906.026; Mon, 2 Jul 2018
 02:12:52 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "festevam@gmail.com" <festevam@gmail.com>,
        Anson Huang <anson.huang@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v1] ARM: dts: imx6sl-evk: keep sw4 always on
Thread-Topic: [PATCH v1] ARM: dts: imx6sl-evk: keep sw4 always on
Thread-Index: AQHUDD3lErATOOOC6U2dIIt1Q++idKR6JNEAgADqWICAABaiAIAAAEeAgAAAwgCAAADKgIAAAMqAgAAAjgCAAAEVAIAAAkuAgACVe4A=
Date:   Mon, 2 Jul 2018 02:12:52 +0000
Message-ID: <1530526335.15665.13.camel@nxp.com>
References: <1529930051-14122-1-git-send-email-yibin.gong@nxp.com>
         <20180701093402.GN4348@dragon>
         <CAOMZO5BjOEGWv2dC-bp0BYHq+PhLssEKic+o7ock8_1Dobd=sQ@mail.gmail.com>
         <AM3PR04MB131507901BFEE1A5E426EECBF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
         <CAOMZO5D8tjnjbwMdLGd7KF7_4PwqRWX8XH8kdcF3-5e-r2YQEA@mail.gmail.com>
         <AM3PR04MB1315E7AED2BCE2265E6C443DF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
         <CAOMZO5D8v4KM9S4ooHTDbA+vc8BZN_eO_wDuOPA+8Hcq-SmLDw@mail.gmail.com>
         <AM3PR04MB1315C7C7CFF990615732FFBCF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
         <CAOMZO5AM5VRS7UiWuvAQ8vvTB8OM+iwofuYrbsL_yB9e0Z9Kyg@mail.gmail.com>
         <AM3PR04MB13155B8D567ABEF7EF03249AF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
         <CAOMZO5BdtxKjQge5ONpnjr1yNVeTJf4u8Gh-fPqpHz7G9ipOTg@mail.gmail.com>
In-Reply-To: <CAOMZO5BdtxKjQge5ONpnjr1yNVeTJf4u8Gh-fPqpHz7G9ipOTg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR04MB3239;7:2CTVi+o/zJlBATIslvmd+O/htcfAlTjkMgELh+bQEpL0OswcT/brDGfAseD5aG7r4awwT7RLONoE8sFOxzqoBQqh4IEguSxO+M2xCYIRs/CR1cls56Fj6o1WrCfea5ythSwsGnE7xPWSUI2CDtIJlaWQS4OU6LoRDyWuwqlDt0AJZa52hiNXFAt/MJWZf+1fC9akdbNUod9AccvB+s8aBW6hOnMOTx31o2IhGKO1r2bkLGubta9feEalFprLsEib
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 2cb739ac-a34b-434a-b617-08d5dfc150e1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB6PR04MB3239;
x-ms-traffictypediagnostic: DB6PR04MB3239:
x-microsoft-antispam-prvs: <DB6PR04MB3239CED1A6659D9E8812E96289430@DB6PR04MB3239.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DB6PR04MB3239;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB3239;
x-forefront-prvs: 07215D0470
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(136003)(39860400002)(376002)(189003)(199004)(105586002)(106356001)(25786009)(316002)(81156014)(6636002)(81166006)(6436002)(8676002)(6486002)(6116002)(66066001)(4326008)(93886005)(6512007)(36756003)(3846002)(8936002)(68736007)(2906002)(6246003)(39060400002)(103116003)(5660300001)(97736004)(305945005)(53936002)(6506007)(102836004)(53546011)(86362001)(186003)(26005)(486006)(478600001)(2900100001)(446003)(2616005)(476003)(14454004)(11346002)(99286004)(76176011)(7736002)(110136005)(229853002)(54906003)(5250100002)(2501003)(256004)(50226002)(99106002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB3239;H:DB6PR04MB3223.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: cLdFaD8cBivh5CN3b0WDDwadwTABWcEkw0hwjanHqeCB/5AgC6ZyneWJ60jRMADYpv9nyKtX6vitms7Jkh4FayGecixSPh1eETQATZdI4Cnfkp2JFvpmnOOS7sAW7u8eVyUXrdRvH7kuoq0B79jzl4Cdq0gEk+4wTUeR4TUiwWCwcywGyQxDX4VPnuppAGg8IcM7m/r12OWuELmGq0nGF5HqvPPcDef1mQYrgczr0rCp3+zvRKMoqOXB76Oh8iLncpN5ZaQGJ8DzfhlxyMu61ToUDBTVFpzRDiSyyWS5Qi+pFNdE6PyTF7OF/VyoDsce/WK9lhT11nE/Pu6cERDcKG6UhNGhcy8y9Sb5/pUCb98=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <91DBFE0A689CED489D51377F02880C9A@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cb739ac-a34b-434a-b617-08d5dfc150e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2018 02:12:52.0574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3239
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24g5pelLCAyMDE4LTA3LTAxIGF0IDIyOjE3IC0wMzAwLCBGYWJpbyBFc3RldmFtIHdyb3RlOg0K
PiBPbiBTdW4sIEp1bCAxLCAyMDE4IGF0IDEwOjA5IFBNLCBBbnNvbiBIdWFuZyA8YW5zb24uaHVh
bmdAbnhwLmNvbT4NCj4gd3JvdGU6DQo+IA0KPiA+IA0KPiA+IE9uIHNvbWUgbmV3IGkuTVggcGxh
dGZvcm1zLCBQRnV6ZSBzd2l0Y2hlcyBhcmUgdXNlZCBmb3Igc3VwcGx5aW5nDQo+ID4gR1BVL1ZQ
VQ0KPiA+IG9yIG90aGVyIG5vbi1jcml0aWNhbCBtb2R1bGVzIG9ubHksIHRoZXNlIHN3aXRjaGVz
IG5lZWQgdG8gYmUNCj4gPiB0dXJuZWQgb2ZmIGJ5DQo+ID4gcnVudGltZSBQTSB0byBhdm9pZCB2
ZXJ5IGhpZ2ggcG93ZXIgbGVha2FnZSwgbGlrZSBvbiBtU2NhbGU4NTBELg0KPiBPaywgaW4gdGhp
cyBjYXNlIEkgc3VnZ2VzdCBhZGRpbmcgYSBuZXcgcHJvcGVydHkgc28gdGhhdCB0aGUgc3dpdGNo
ZXMNCj4gY2FuIGJlIHR1cm5lZCBvZmYgb25seSB3aGVuIHRoZSBuZXcgcHJvcGVydHkgaXMgcHJl
c2VudC4NCj4gDQo+IFdoZW4gdGhpcyBuZXcgcHJvcGVydHkgaXMgYWJzZW50LCB0aGVuIHdlIGtl
ZXAgdGhlIGN1cnJlbnQgYmVoYXZpb3INCj4gYW5kIGF2b2lkIGR0YiBicmVha2FnZS4NCj4gDQo+
IFNpbmNlIE1YOE0gc3VwcG9ydCBpcyBub3QgaW4gcGxhY2UgeWV0LCB0aGlzIGlzIG5vdCB1cmdl
bnQsIHNvIEkgd2lsbA0KPiBzZW5kIGEgcmV2ZXJ0IGFuZCB0aGVuIHlvdSBjYW4gcmUtd29yayB0
aGUgcGF0Y2ggc28gdGhhdCBpdCBkb2VzIG5vdA0KPiBhZmZlY3QgdGhlIG9sZCBkdGJzLg0KPiAN
Cj4gRG8geW91IGFncmVlIHdpdGggc3VjaCBhcHByb2FjaD8NCkJ1dCBpbiBmYWN0LCB0aGUgb3Jp
Z2luYWwgZHRzIGlzIG5vdCBjb3JyZWN0IHdpdGhvdXQgJ3JlZ3VsYXRvci1hbHdheXMtDQpvbidz
aW5jZSBTVzQgaXMgdGhlIGNyaXRpY2FsIEREUiBwb3dlciByYWlsLCBhbHRob3VnaCwgaXQncyBr
ZXB0IG9uIGluDQp0aGUgcHJldmlvdXMga2VybmVsIGJ5IG5vIHN3aXRjaGVzIGVuYWJsZS9kaXNh
YmxlIGludGVyZmFjZXMgcHJvdmlkZWQNCmluIHBmdXplIGRyaXZlci4gQWRkaW5nIG5ldyBwcm9w
ZXJ0eSB3aGljaCBjYW4gYmUgZG9uZSB0b3RhbGx5IGJ5IHRoZQ0KY29tbW9uICdyZWd1bGF0b3It
YWx3YXlzLW9uJyBpcyBub3QgYSBnb29kIGNob2ljZS4gS2VlcCB0aGUgZHRzIHBhdGNoDQphZGRp
bmcgJ3JlZ3VsYXRvci1hbHdheXMtb24nIGFoZWFkIG9mIHBmdXplIGRyaXZlciBwYWNoIGFkZGlu
Zw0KZW5hYmxlL2Rpc2FibGUgaW50ZXJmYWNlIGlzIGVub3VnaCBmb3Igc3VjaCBjYXNlIEkgdGhp
bmsuwqA=
