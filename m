Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB408C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 01:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6119F25A80
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 01:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ouqNBADL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6119F25A80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752113AbeF1BOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 21:14:52 -0400
Received: from mail-eopbgr70055.outbound.protection.outlook.com ([40.107.7.55]:35077
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751043AbeF1BOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 21:14:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26Nf9U/jrKIZavdhukAh5sr9aOBlpS5YQu5pVwYxjPs=;
 b=ouqNBADLo3uuhE16MxQX7Asi2atwva/fB8YGjj6/EO/FYPY+Na2d+TkL2jm4D8+3MMLxSoh0LsSkmBTlEQINZo7rdgtycc1NYw96I7a06xE5b5T8KSBAZonyJpLH2yqpV8s7jNkAJq1AHTNtTW18wjPhduG+5AiRzNVuieCGrK8=
Received: from AM3PR04MB1315.eurprd04.prod.outlook.com (10.163.7.13) by
 AM3PR04MB531.eurprd04.prod.outlook.com (10.242.112.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.23; Thu, 28 Jun 2018 01:14:44 +0000
Received: from AM3PR04MB1315.eurprd04.prod.outlook.com
 ([fe80::a024:25ab:f457:64c7]) by AM3PR04MB1315.eurprd04.prod.outlook.com
 ([fe80::a024:25ab:f457:64c7%7]) with mapi id 15.20.0906.023; Thu, 28 Jun 2018
 01:14:44 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ARM: dts: imx6sll-evk: enable usdhc3 slot
Thread-Topic: [PATCH] ARM: dts: imx6sll-evk: enable usdhc3 slot
Thread-Index: AQHUDfKUXi2sug5/y0O+R0vVRcqq46R0KyUAgACzVyA=
Date:   Thu, 28 Jun 2018 01:14:44 +0000
Message-ID: <AM3PR04MB1315128EA1000FD6D0903CEAF54F0@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1530088605-9264-1-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5DoRUSOfV_oh242w6s_1Zs8yAy9Kf4D+WdYym5c+6nucg@mail.gmail.com>
In-Reply-To: <CAOMZO5DoRUSOfV_oh242w6s_1Zs8yAy9Kf4D+WdYym5c+6nucg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB531;7:VTlENkWI5jEdmztmZHYT8P2bh8tKml1W5s451NWTE5Hl8cU1fvO1WAUpvfKfMkhruMjwqBfaGteVL5qwptxGpel5oNKC9c9vIQwZbjbfUQ/Do+B4BKUQ2mS3wdTUn7ruwPbvlP2ZYIkV0f/mc4IXFZc35RZWc0F2pk+c4ZhMhxM1IGECmoJWwE8jMNi+ykik6uSQt5TXf12xGq35x60VO23FzPA7NU4FK//NtRnU8iJLyZ2wkW7jN9O1/3sPbVlM
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1f76c2b1-73c6-4ca1-8447-08d5dc9488aa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652034)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB531;
x-ms-traffictypediagnostic: AM3PR04MB531:
x-microsoft-antispam-prvs: <AM3PR04MB5314451E63BAA450F5C0507F54F0@AM3PR04MB531.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(85827821059158)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB531;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB531;
x-forefront-prvs: 0717E25089
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(346002)(39860400002)(136003)(13464003)(189003)(199004)(52314003)(39060400002)(25786009)(4326008)(5250100002)(99286004)(33656002)(86362001)(54906003)(5660300001)(2900100001)(66066001)(53936002)(55016002)(316002)(9686003)(6436002)(7736002)(305945005)(81156014)(105586002)(256004)(6916009)(74316002)(106356001)(186003)(97736004)(478600001)(81166006)(8936002)(2906002)(14454004)(476003)(44832011)(68736007)(11346002)(6506007)(486006)(446003)(26005)(3846002)(6116002)(8676002)(7696005)(6246003)(76176011)(102836004)(229853002)(53546011)(14444005)(1411001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB531;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: G0KzQeKiU7iYOa3RXj97gK/fUrV+Hx6OLhpbiUyNHKuygN5FuirrKy1c7VYZ8qRDBJgA9v/7QrbcCFtdJ6NLAnCHJBls3cuvx8ZGpXHYGZi+ocjLCnkH/f1WxKNC26hdCyAsWuNwKMEVZrrk34kBqHrrcbOXSMflq8ilqkW0YWmoH2SMNQfgdSbI/EcZ/CkcsIlU0lidwrI4wUtrvJ2lOSUtdTM2Ez97BHNSJZUGsiEQGQbJ4D8a4f7V2UwY3AqV+/eFj3SMKCZ9kwBwEE50DGKgzHywd3LayFzlQa7eTidlUslo6sp9p53D6FBxRReGBH1xg4zrcfY7mamiYhH6Dj6eiSbU9nWJb8PBg+yzlLE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f76c2b1-73c6-4ca1-8447-08d5dc9488aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2018 01:14:44.7488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB531
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEZhYmlvDQoNCkFuc29uIEh1YW5nDQpCZXN0IFJlZ2FyZHMhDQoNCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGYWJpbyBFc3RldmFtIFttYWlsdG86ZmVzdGV2YW1A
Z21haWwuY29tXQ0KPiBTZW50OiBXZWRuZXNkYXksIEp1bmUgMjcsIDIwMTggMTA6MzEgUE0NCj4g
VG86IEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPg0KPiBDYzogU2hhd24gR3VvIDxz
aGF3bmd1b0BrZXJuZWwub3JnPjsgU2FzY2hhIEhhdWVyDQo+IDxzLmhhdWVyQHBlbmd1dHJvbml4
LmRlPjsgU2FzY2hhIEhhdWVyIDxrZXJuZWxAcGVuZ3V0cm9uaXguZGU+OyBGYWJpbw0KPiBFc3Rl
dmFtIDxmYWJpby5lc3RldmFtQG54cC5jb20+OyBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwu
b3JnPjsNCj4gTWFyayBSdXRsYW5kIDxtYXJrLnJ1dGxhbmRAYXJtLmNvbT47IG9wZW4gbGlzdDpP
UEVOIEZJUk1XQVJFIEFORA0KPiBGTEFUVEVORUQgREVWSUNFIFRSRUUgQklORElOR1MgPGRldmlj
ZXRyZWVAdmdlci5rZXJuZWwub3JnPjsNCj4gZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNv
bT47IG1vZGVyYXRlZCBsaXN0OkFSTS9GUkVFU0NBTEUgSU1YIC8gTVhDDQo+IEFSTSBBUkNISVRF
Q1RVUkUgPGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZz47IGxpbnV4LWtlcm5l
bA0KPiA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz4NCj4gU3ViamVjdDogUmU6IFtQQVRD
SF0gQVJNOiBkdHM6IGlteDZzbGwtZXZrOiBlbmFibGUgdXNkaGMzIHNsb3QNCj4gDQo+IEhpIEFu
c29uLA0KPiANCj4gT24gV2VkLCBKdW4gMjcsIDIwMTggYXQgNTozNiBBTSwgQW5zb24gSHVhbmcg
PEFuc29uLkh1YW5nQG54cC5jb20+DQo+IHdyb3RlOg0KPiANCj4gPiArJnVzZGhjMyB7DQo+ID4g
KyAgICAgICBwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiLCAic3RhdGVfMTAwbWh6IiwgInN0YXRl
XzIwMG1oeiI7DQo+ID4gKyAgICAgICBwaW5jdHJsLTAgPSA8JnBpbmN0cmxfdXNkaGMzPjsNCj4g
PiArICAgICAgIHBpbmN0cmwtMSA9IDwmcGluY3RybF91c2RoYzNfMTAwbWh6PjsNCj4gPiArICAg
ICAgIHBpbmN0cmwtMiA9IDwmcGluY3RybF91c2RoYzNfMjAwbWh6PjsNCj4gPiArICAgICAgIGNk
LWdwaW9zID0gPCZncGlvMyAyMiBHUElPX0FDVElWRV9MT1c+Ow0KPiA+ICsgICAgICAga2VlcC1w
b3dlci1pbi1zdXNwZW5kOw0KPiA+ICsgICAgICAgZW5hYmxlLXNkaW8td2FrZXVwOw0KPiA+ICsg
ICAgICAgdm1tYy1zdXBwbHkgPSA8JnJlZ19zZDNfdm1tYz47DQo+ID4gKyAgICAgICBzdGF0dXMg
PSAib2theSI7DQo+ID4gK307DQo+ID4gKw0KPiA+ICAmdXNib3RnMSB7DQo+IA0KPiBQbGVhc2Ug
a2VlcCB0aGUgbm9kZXMgc29ydGVkIGluIGFscGhhYmV0aWNhbCBvcmRlci4NCg0KVGhhbmtzLCBp
dCBpcyBiZWNhdXNlIG9yaWdpbmFsIGNvZGUgZG9lcyBOT1QgZG8gaXQgaW4gYWxwaGFiZXRpY2Fs
IG9yZGVyLCBzbyBJIGp1c3QgYWRkZWQNCnVzZGhjMyBhdCB0aGUgZW5kIG9mIHVzZGhjMSwgYnV0
IEkgc2VudCBWMiBwYXRjaCB0byByZS1zb3J0IGl0IGFueXdheSwgcGxlYXNlIHJldmlldyBpdC4g
IA0KDQpBbnNvbi4NCg0KDQo=
