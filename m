Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0E8C3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 01:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FF9D24F76
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 01:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="E4Nj5kBJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FF9D24F76
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753565AbeGCBOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 21:14:18 -0400
Received: from mail-eopbgr40040.outbound.protection.outlook.com ([40.107.4.40]:22350
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752771AbeGCBOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 21:14:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SePdXCrpxTj19yN0MvAyTNPWfJz7VXKfgEBASCofEJo=;
 b=E4Nj5kBJ1EoZMdEGzCCb9cqA84aAEI769eNWVkxDgaycegwsr5mCdiwRW1eEIlFWTtrYfT1mRqXu14sr9ioLMTfBi2zFMrvku/Y+4u0aY+qJ9BXkd8vj9+iGq9M45AZoraXq2dtGzH/DG3NJmobWH2OekHUFouPlokOvnoND3Ak=
Received: from AM3PR04MB1315.eurprd04.prod.outlook.com (10.163.7.13) by
 AM3PR04MB1250.eurprd04.prod.outlook.com (10.163.6.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.24; Tue, 3 Jul 2018 01:14:11 +0000
Received: from AM3PR04MB1315.eurprd04.prod.outlook.com
 ([fe80::a024:25ab:f457:64c7]) by AM3PR04MB1315.eurprd04.prod.outlook.com
 ([fe80::a024:25ab:f457:64c7%7]) with mapi id 15.20.0906.026; Tue, 3 Jul 2018
 01:14:11 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Fabio Estevam <fabio.estevam@nxp.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] bindings: add clocks optional binding for imx gpio
Thread-Topic: [PATCH] bindings: add clocks optional binding for imx gpio
Thread-Index: AQHUD1oTpUYELc/cLUKlpW3sCHQ1vaR79ziAgAC+stA=
Date:   Tue, 3 Jul 2018 01:14:11 +0000
Message-ID: <AM3PR04MB13158C70263CB7CD5CB24173F5420@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1530243004-10529-1-git-send-email-Anson.Huang@nxp.com>
 <CACRpkdbbbbO-94i-ZTSunzuUQcJ8dQpuPHBYODrvdWQyuri7yw@mail.gmail.com>
In-Reply-To: <CACRpkdbbbbO-94i-ZTSunzuUQcJ8dQpuPHBYODrvdWQyuri7yw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB1250;7:GwPR9eDc73RqECxv6mLegdcZt83eL/d8t4TAFoIXlESttLG6NO2Gnq3e3HwMDs2jiIiYEBmQ6FGZ1J6o6Ls3sezRnkGUSzoyED0tKurJWuyH17JwhaTR/4DUwKtjqkaujFB4ZC86U3i7ExWj0iHfB3HAUp95GpsEMDTZ//hgNG5aJsRJ9GysDNbxsIlSGIDhFrmyXFbcFF/DIvG4c1pBp0DiHxnS74RF8k3KhXeNkJjpP/13TqWwoo5OV+mh4NsR
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d60fb102-78e5-4243-84b4-08d5e08248e0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1250;
x-ms-traffictypediagnostic: AM3PR04MB1250:
x-microsoft-antispam-prvs: <AM3PR04MB12504314BDB15BAFB9954E91F5420@AM3PR04MB1250.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB1250;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1250;
x-forefront-prvs: 0722981D2A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(366004)(136003)(396003)(13464003)(189003)(199004)(44832011)(2900100001)(9686003)(74316002)(86362001)(305945005)(4326008)(6636002)(76176011)(7696005)(25786009)(54906003)(256004)(110136005)(2906002)(8936002)(81166006)(8676002)(446003)(55016002)(11346002)(81156014)(316002)(486006)(476003)(7736002)(105586002)(66066001)(14454004)(53936002)(6436002)(106356001)(6246003)(99286004)(53546011)(6506007)(229853002)(26005)(102836004)(186003)(33656002)(68736007)(97736004)(478600001)(5660300001)(6116002)(3846002)(5250100002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1250;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Yg+34lRul+U0BrkZ6QmUIgA5rDEyXLmcV4/m9G4dGbefb9Gj0dEJ7ZBpRBWMCW2gernBQ4dS1u7eggOXsiVMNfvxRBrVi82+VYCLTYIxdHOExNWo4Q3RK5osoB2PaRHqwr3N8RAn4mnsD28stFxvNH5ReDUa7JpiNDFjMpHFqALpKlY0GsVucoClXsfHu8R78Bjq5k7OWDO26YQdVJS/4RvsxUZES2Sz9KJIqA1do7XWvA5A3lomzBAWFW6hGSFgyZnkHxZBcmGEBd9ArY9z7lDy5vfZdSuZVfbLlEzqhXRp4suj9+bqL59AU3aajnk7AL1eFfv+WpVleF2Vj9HL525jhxp30hCO2HmUijFEREo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d60fb102-78e5-4243-84b4-08d5e08248e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2018 01:14:11.4716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1250
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIExpbnVzDQoNCkFuc29uIEh1YW5nDQpCZXN0IFJlZ2FyZHMhDQoNCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaW51cyBXYWxsZWlqIFttYWlsdG86bGludXMud2Fs
bGVpakBsaW5hcm8ub3JnXQ0KPiBTZW50OiBNb25kYXksIEp1bHkgMiwgMjAxOCA5OjQ2IFBNDQo+
IFRvOiBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT47IEZhYmlvIEVzdGV2YW0NCj4g
PGZhYmlvLmVzdGV2YW1AbnhwLmNvbT4NCj4gQ2M6IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5l
bC5vcmc+OyBNYXJrIFJ1dGxhbmQNCj4gPG1hcmsucnV0bGFuZEBhcm0uY29tPjsgb3BlbiBsaXN0
OkdQSU8gU1VCU1lTVEVNDQo+IDxsaW51eC1ncGlvQHZnZXIua2VybmVsLm9yZz47IG9wZW4gbGlz
dDpPUEVOIEZJUk1XQVJFIEFORCBGTEFUVEVORUQNCj4gREVWSUNFIFRSRUUgQklORElOR1MgPGRl
dmljZXRyZWVAdmdlci5rZXJuZWwub3JnPjsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRD
SF0gYmluZGluZ3M6IGFkZCBjbG9ja3Mgb3B0aW9uYWwgYmluZGluZyBmb3IgaW14IGdwaW8NCj4g
DQo+IE9uIEZyaSwgSnVuIDI5LCAyMDE4IGF0IDU6MzQgQU0gQW5zb24gSHVhbmcgPEFuc29uLkh1
YW5nQG54cC5jb20+DQo+IHdyb3RlOg0KPiANCj4gPiBTb21lIGkuTVggU29DcyBoYXZlIEdQSU8g
Y2xvY2sgZ2F0ZSBpbiBDQ00sIGFjY2Vzc2luZyBHUElPIHJlZ2lzdGVycw0KPiA+IG5lZWRzIHRv
IGVuYWJsZSBHUElPIGNsb2NrIGdhdGUgZmlyc3QsIGkuTVggR1BJTyBkcml2ZXIgd2lsbCBlbmFi
bGUNCj4gPiBjbG9jayBnYXRlIGlmIHRoZXJlIGlzIGNsb2NrIHByb3BlcnR5IGluIEdQSU8gbm9k
ZSBvZiBkdGIsIGFkZA0KPiA+IG9wdGlvbmFsIHByb3BlcnR5IHRvIGkuTVggR1BJTyBiaW5kaW5n
IGRvYy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0Bu
eHAuY29tPg0KPiANCj4gTWFrZSBzZW5zZSBzaW5jZSB0aGUgZ3Bpby1teGMgZHJpdmVyIGFscmVh
ZHkgc3VwcG9ydHMgdGhpcyA6KQ0KPiANCj4gPiArT3B0aW9uYWwgcHJvcGVydGllczoNCj4gPiAr
LSBjbG9ja3M6IHRoZSBjbG9ja3MgdXNlZCBieSBncGlvIGJhbmsNCj4gDQo+IFNob3VsZCB0aGUg
dGV4dCBiZSAidGhlIGNsb2NrIGZvciBjbG9ja2luZyB0aGUgR1BJTyBzaWxpY29uIg0KPiBJIGd1
ZXNzIHRoYXQgaXMgd2hhdCBpdCBpcy4gQW5kIHNpbmd1bGFyaXM/DQoNClllcywgaXQgaXMgc2lu
Z3VsYXJpcywgSSB3aWxsIGltcHJvdmUgdGhlIHRleHQuDQoNCj4gDQo+IERvZXMgaXQgaHVydCB0
byBnaXZlIHRoZSBjbG9jayBhIG5hbWU/IExpa2UgdGhlIGNvbW1vbiAicGNsayIgZm9yIHBlcmlw
aGVyYWwNCj4gY2xvY2sgb3Igc29tZXRoaW5nIHNpbWlsYXIgdGhhdCBvdGhlciBpLk1YIHNpbGlj
b24gdXNlcz8NCg0KSXQgaXMganVzdCBiZWNhdXNlIEdQSU8gb25seSBuZWVkcyBvbmUgY2xvY2ss
IGFuZCB0aGUgZHJpdmVyIGRvZXMgTk9UIGdldCB0aGUNCmNsb2NrIHVzaW5nIGNsb2NrIG5hbWUs
IHNvIHRoZSBHUElPIG5vZGUgaW4gZHRiIGFsc28gaGFzIG5vIGNsb2NrIG5hbWUgc3BlY2lmaWVk
LA0KaWYgd2UgYWRkIGEgY2xvY2sgbmFtZSBoZXJlLCBkdGIgYWxzbyBuZWVkIHRvIGJlIHVwZGF0
ZWQ/IEFuZCBJIHNhdyBvdGhlciBpLk1YDQptb2R1bGVzIHdoaWNoIGhhdmUgb25seSBvbmUgY2xv
Y2ssIHRoZXkgYWxzbyBoYXZlIG5vIGNsb2NrIG5hbWUgc3BlY2lmaWVkLCBsaWtlIEkyQw0Kb24g
aS5NWDZRREwsIEkgd2lsbCBzZW5kIGEgVjIgcGF0Y2ggd2l0aCB0ZXh0IGltcHJvdmVkLCB0aGFu
a3MuDQoNCkFuc29uLg0KDQo+IA0KPiBGYWJpbzogY2FuIHdlIGhhdmUgeW91ciBBQ0sgb24gdGhp
cyB0b28uDQo+IA0KPiBZb3VycywNCj4gTGludXMgV2FsbGVpag0K
