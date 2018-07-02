Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DDFC6778C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 01:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 363562500F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 01:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z+U8yg3Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 363562500F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932276AbeGBBDQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 21:03:16 -0400
Received: from mail-eopbgr40081.outbound.protection.outlook.com ([40.107.4.81]:25495
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752739AbeGBBDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 21:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W46LxO7gXqsMsBHlRNb9Ox7nDbtBXO+hl8kcuyX6qFY=;
 b=Z+U8yg3ZZkb41XEg8ov91oNl65q9JtT6zAZYwUUzEgJNbi2DT2/EMbRKTLOJp2MFAK6MnD7Sxk9ton8cl15YYXysJ9rU5PibLhT2lVW4HA9f4tNZgQloOs+HNk7j4pZHMhLj9a77CyoGUcFB5cer2wpjtF3CWU7zOlPLnvG4ylQ=
Received: from AM3PR04MB1315.eurprd04.prod.outlook.com (10.163.7.13) by
 AM3PR04MB1395.eurprd04.prod.outlook.com (10.163.185.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.20; Mon, 2 Jul 2018 01:03:11 +0000
Received: from AM3PR04MB1315.eurprd04.prod.outlook.com
 ([fe80::a024:25ab:f457:64c7]) by AM3PR04MB1315.eurprd04.prod.outlook.com
 ([fe80::a024:25ab:f457:64c7%7]) with mapi id 15.20.0906.026; Mon, 2 Jul 2018
 01:03:11 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     Shawn Guo <shawnguo@kernel.org>, Robin Gong <yibin.gong@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v1] ARM: dts: imx6sl-evk: keep sw4 always on
Thread-Topic: [PATCH v1] ARM: dts: imx6sl-evk: keep sw4 always on
Thread-Index: AQHUDD3lRelNZaT6s0KCSbdeyjhmZKR6JNEAgADqWICAABYs4IAAAL2AgAAAQsCAAAFKgIAAAEyQ
Date:   Mon, 2 Jul 2018 01:03:11 +0000
Message-ID: <AM3PR04MB1315C7C7CFF990615732FFBCF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1529930051-14122-1-git-send-email-yibin.gong@nxp.com>
 <20180701093402.GN4348@dragon>
 <CAOMZO5BjOEGWv2dC-bp0BYHq+PhLssEKic+o7ock8_1Dobd=sQ@mail.gmail.com>
 <AM3PR04MB131507901BFEE1A5E426EECBF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5D8tjnjbwMdLGd7KF7_4PwqRWX8XH8kdcF3-5e-r2YQEA@mail.gmail.com>
 <AM3PR04MB1315E7AED2BCE2265E6C443DF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5D8v4KM9S4ooHTDbA+vc8BZN_eO_wDuOPA+8Hcq-SmLDw@mail.gmail.com>
In-Reply-To: <CAOMZO5D8v4KM9S4ooHTDbA+vc8BZN_eO_wDuOPA+8Hcq-SmLDw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB1395;7:EsdshU1Brf16PnKE2eduBwMUu+l/yKLSJyTPA7hG7FKJS/5WfHxlNiBO3kkxipTWmFahFPu5NxEWVD3rhWfP4BJgJLecMtLvD1WeCY/MpKggTsuKRmgnuLFSprKLXBx4W+oaudbdKIqceES5jK9WldAAmmhzqByOcKG+xegI09xtV/Hd+0nzGnzDwIaOU1Ujw+3X6RC1b6wCvcU4fIjdAi73n4fHTdzuJ57dgpKyyYTRt53YHhYr62kyYbo/rpJ9
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 26c5ef45-46f7-436c-dddb-08d5dfb794dd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1395;
x-ms-traffictypediagnostic: AM3PR04MB1395:
x-microsoft-antispam-prvs: <AM3PR04MB13955F5D12F435338BBE9112F5430@AM3PR04MB1395.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(85827821059158)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB1395;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1395;
x-forefront-prvs: 07215D0470
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(346002)(376002)(366004)(199004)(189003)(13464003)(2900100001)(44832011)(4326008)(39060400002)(486006)(6436002)(476003)(53546011)(6246003)(7696005)(97736004)(55016002)(9686003)(446003)(76176011)(6506007)(11346002)(229853002)(256004)(1411001)(2906002)(14454004)(25786009)(6116002)(33656002)(305945005)(53936002)(54906003)(105586002)(8676002)(316002)(8936002)(74316002)(3846002)(7736002)(106356001)(68736007)(66066001)(26005)(86362001)(478600001)(5250100002)(81166006)(99286004)(186003)(102836004)(5660300001)(6916009)(81156014)(93886005)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1395;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Qdumj0yGSobN1ziB/4aoD6MKG1nFvF2BzRbUuzgHopcDojfw7/3rW87PDc6XmeucJmNH2BIIXR6BHEOGYZ34rlPu973DhhIl+4WrGiFka+Z59TKDbyniUQh+o3+YcE/1zW8npXRYdKQKJ1otfETA4qmM0E/UaN9uWK2lnJu/WzbiPGB7yNWxoPQ5Vf9UxKTCPE8soN6cnkpDN46k67T/KvqZ0iL3mgPC2qIH65AKtb5X3nqhlfNyJqhHVfiqmHT18axN0S1ETvU7HaA8vPkOi2XVa+n91Rs7Y14lcr72tNDQv7j63hF8n62B85sLvWtYQGzpdMHxRbqX+dOXFc9eNlnTKXhjhiqUMRo100wGrP8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26c5ef45-46f7-436c-dddb-08d5dfb794dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2018 01:03:11.0939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1395
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkFuc29uIEh1YW5nDQpCZXN0IFJlZ2FyZHMhDQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiBGcm9tOiBGYWJpbyBFc3RldmFtIFttYWlsdG86ZmVzdGV2YW1AZ21haWwuY29t
XQ0KPiBTZW50OiBNb25kYXksIEp1bHkgMiwgMjAxOCA5OjAwIEFNDQo+IFRvOiBBbnNvbiBIdWFu
ZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4gQ2M6IFNoYXduIEd1byA8c2hhd25ndW9Aa2VybmVs
Lm9yZz47IFJvYmluIEdvbmcgPHlpYmluLmdvbmdAbnhwLmNvbT47DQo+IE1hcmsgUnV0bGFuZCA8
bWFyay5ydXRsYW5kQGFybS5jb20+OyBvcGVuIGxpc3Q6T1BFTiBGSVJNV0FSRSBBTkQNCj4gRkxB
VFRFTkVEIERFVklDRSBUUkVFIEJJTkRJTkdTIDxkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZz47
DQo+IGxpbnV4LWtlcm5lbCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IFJvYiBIZXJy
aW5nDQo+IDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAu
Y29tPjsgU2FzY2hhIEhhdWVyDQo+IDxrZXJuZWxAcGVuZ3V0cm9uaXguZGU+OyBGYWJpbyBFc3Rl
dmFtIDxmYWJpby5lc3RldmFtQG54cC5jb20+Ow0KPiBtb2RlcmF0ZWQgbGlzdDpBUk0vRlJFRVND
QUxFIElNWCAvIE1YQyBBUk0gQVJDSElURUNUVVJFDQo+IDxsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjFdIEFSTTogZHRzOiBpbXg2
c2wtZXZrOiBrZWVwIHN3NCBhbHdheXMgb24NCj4gDQo+IEhpIEFuc29uLA0KPiANCj4gT24gU3Vu
LCBKdWwgMSwgMjAxOCBhdCA5OjU3IFBNLCBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNv
bT4gd3JvdGU6DQo+IA0KPiA+IEp1c3Qgd2FudCB0byBrbm93IGhvdyB0byBoYW5kbGUgc3VjaCBj
YXNlPyBUaGUga2VybmVsIHBhdGNoIHdpbGwgbmV2ZXINCj4gPiBiZSBhcHBsaWVkIG9yIGlzIHRo
ZXJlIGFueSB3YXkgdG8gbWFrZSBrZXJuZWwgcGF0Y2ggYW5kIGR0YiBwYXRjaA0KPiA+IGFwcGxp
ZWQgdG9nZXRoZXIgdG8gYXZvaWQgYW55IGJyZWFrYWdlPw0KPiANCj4gV2UgYWx3YXlzIHdhbnQg
dG8gYXZvaWQgYnJlYWtpbmcgYSB3b3JraW5nIGR0YiB3aGVuIGl0IGlzIHVzZWQgd2l0aCBhIG5l
d2VyDQo+IGtlcm5lbC4NCj4gDQo+IEluIHRoaXMgY2FzZSB3ZSBuZWVkIHRvIHJldmVydCB0aGUg
a2VybmVsIHBhdGNoIGFzIGl0IGNhdXNlcyByZWdyZXNzaW9uIHdpdGggb2xkDQo+IGR0YnMuDQog
DQpTbyB0aGF0IG1lYW4gc3VjaCBraW5kIG9mIGtlcm5lbCBwYXRjaCB3aWxsIG5ldmVyIGJlIGlu
dG8ga2VybmVsPyBFdmVuIGlmIGl0IGlzIGENCm5lY2Vzc2FyeSBwYXRjaCBmb3IgZml4aW5nIHNv
bWUgb3RoZXIgaXNzdWVzPyBJIGp1c3Qgd29uZGVyIGhvdyB0aGlzIGNhc2UgYmVpbmcNCmhhbmRs
ZWQuDQoNCkFuc29uLg0K
