Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDDEC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 01:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03FCF26913
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 01:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ERCr6Mjb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03FCF26913
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755059AbeF0BXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 21:23:08 -0400
Received: from mail-eopbgr00076.outbound.protection.outlook.com ([40.107.0.76]:3776
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751491AbeF0BXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 21:23:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=miL0++cNyFW5vfXTquuzxyLaJtPdTFTFHQJSTK+3pGA=;
 b=ERCr6MjbQZw1QHwwhkVHewjNS2qtCPmbchCE+4t3VMXtJh41FLHUzMTgCoxJwqDdv0DQ+tAFDqSVSPu0YtaaTsZT8EQywjuHEpK5/Onyozr9GXp8EDWQT4v2Izuf04r6O+34t50m4LDOx6xnXnEUAYXt0yxrLlQBU0hh/byknvk=
Received: from DB5PR04MB1320.eurprd04.prod.outlook.com (10.162.157.139) by
 DB5PR04MB0869.eurprd04.prod.outlook.com (10.161.195.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.24; Wed, 27 Jun 2018 01:23:02 +0000
Received: from DB5PR04MB1320.eurprd04.prod.outlook.com
 ([fe80::bdee:ee45:1fa8:7f8]) by DB5PR04MB1320.eurprd04.prod.outlook.com
 ([fe80::bdee:ee45:1fa8:7f8%3]) with mapi id 15.20.0906.023; Wed, 27 Jun 2018
 01:23:01 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ARM: dts: make pfuze switch always-on for imx platforms
Thread-Topic: [PATCH] ARM: dts: make pfuze switch always-on for imx platforms
Thread-Index: AQHUDRSjJ0VVxmrHn0SPihAXLvQaBqRzT/8AgAAAYRA=
Date:   Wed, 27 Jun 2018 01:23:01 +0000
Message-ID: <DB5PR04MB1320492352AFFEB852E74D1AF5480@DB5PR04MB1320.eurprd04.prod.outlook.com>
References: <1529993283-32396-1-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5C--fpkRLfwmySFJeO2hwPdz3paxW1WMiqcqraqmbL9Mg@mail.gmail.com>
In-Reply-To: <CAOMZO5C--fpkRLfwmySFJeO2hwPdz3paxW1WMiqcqraqmbL9Mg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB5PR04MB0869;7:5lFealYwEv8KfQ95rcDXY5lIOTxWpSNJGcOjjkXk+ZY5tQtUJVrwfA/B2/AXA9vMIsXbFpot4fnk2m7NvgsnkZqFqRJD7zyQfSdPJmap1SSlwLX1mYfLt226GRza7ifHlgN4NsypHR/CslCz+KvEFKYn5V9r6eIMehzdkxGVwBUVL03tJkgKaI2ZsKtMdPf/z/OCK5p6l3nCWpXw6WxcKBV3YJxfYQeb3d71xWE77LPmzxDH+1TIjdkCntWV73JT
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b1136dcb-3ec4-43f1-788d-08d5dbcc867d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB0869;
x-ms-traffictypediagnostic: DB5PR04MB0869:
x-microsoft-antispam-prvs: <DB5PR04MB0869599F66DB516953AA9C44F5480@DB5PR04MB0869.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(85827821059158)(258649278758335)(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DB5PR04MB0869;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB0869;
x-forefront-prvs: 0716E70AB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(396003)(39860400002)(366004)(376002)(346002)(136003)(13464003)(199004)(189003)(74316002)(102836004)(7736002)(53546011)(97736004)(5660300001)(9686003)(66066001)(76176011)(8676002)(2906002)(81156014)(7696005)(6916009)(68736007)(81166006)(6506007)(305945005)(8936002)(14454004)(33656002)(316002)(478600001)(54906003)(105586002)(53936002)(186003)(55016002)(99286004)(2900100001)(5250100002)(106356001)(3846002)(4326008)(1411001)(39060400002)(44832011)(11346002)(476003)(446003)(6246003)(6436002)(86362001)(486006)(25786009)(229853002)(256004)(26005)(6116002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB0869;H:DB5PR04MB1320.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Ad9Is7YIBav12YEW4r0XcWzx0cbQviMcJZBn5xgoQumR4LAhvPShWO0pucDHwXrgcVuXc62U+N/ibSRvycte7IORJxc2Huzj27yUxrFtFZcR7OCIj7GxnILYIpqJ2aDim83TRDXFcGDiFMXXVrmdXNrvcYCHsYe+iHaK916JW07NgovQGda1/9juLAHQR8zHrpR+KSTqqUAOF4sfT4wf7IuckS0kMk1PCwPcPPloz1wiZlSuZxW2XpSO32S701LXeZ4gMKWLfBtgOkqGya+pw7byzWu0gfBfugYHgT1VfgCnUj2d/OQfIZq0rAgotqmskvoWdssQHGVMgoWTXLpeYuXa4fR1oEpZB4u8gX63nIg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1136dcb-3ec4-43f1-788d-08d5dbcc867d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2018 01:23:01.8123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB0869
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkFuc29uIEh1YW5nDQpCZXN0IFJlZ2FyZHMhDQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiBGcm9tOiBGYWJpbyBFc3RldmFtIFttYWlsdG86ZmVzdGV2YW1AZ21haWwuY29t
XQ0KPiBTZW50OiBXZWRuZXNkYXksIEp1bmUgMjcsIDIwMTggOToyMSBBTQ0KPiBUbzogQW5zb24g
SHVhbmcgPGFuc29uLmh1YW5nQG54cC5jb20+DQo+IENjOiBTaGF3biBHdW8gPHNoYXduZ3VvQGtl
cm5lbC5vcmc+OyBTYXNjaGEgSGF1ZXINCj4gPHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+OyBTYXNj
aGEgSGF1ZXIgPGtlcm5lbEBwZW5ndXRyb25peC5kZT47IEZhYmlvDQo+IEVzdGV2YW0gPGZhYmlv
LmVzdGV2YW1AbnhwLmNvbT47IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+Ow0KPiBN
YXJrIFJ1dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0uY29tPjsgZGwtbGludXgtaW14IDxsaW51eC1p
bXhAbnhwLmNvbT47DQo+IG1vZGVyYXRlZCBsaXN0OkFSTS9GUkVFU0NBTEUgSU1YIC8gTVhDIEFS
TSBBUkNISVRFQ1RVUkUNCj4gPGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZz47
IG9wZW4gbGlzdDpPUEVOIEZJUk1XQVJFIEFORA0KPiBGTEFUVEVORUQgREVWSUNFIFRSRUUgQklO
RElOR1MgPGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnPjsNCj4gbGludXgta2VybmVsIDxsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBBUk06IGR0
czogbWFrZSBwZnV6ZSBzd2l0Y2ggYWx3YXlzLW9uIGZvciBpbXggcGxhdGZvcm1zDQo+IA0KPiBP
biBUdWUsIEp1biAyNiwgMjAxOCBhdCAzOjA4IEFNLCBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdA
bnhwLmNvbT4NCj4gd3JvdGU6DQo+ID4gY29tbWl0ICg1ZmUxNTZmIHJlZ3VsYXRvcjogcGZ1emUx
MDA6IGFkZCBlbmFibGUvZGlzYWJsZSBmb3Igc3dpdGNoKQ0KPiA+IHdpbGwgY2F1c2UgdGhvc2Ug
dW5yZWZlcmVuY2VkIHN3aXRjaGVzIGJlaW5nDQo+IA0KPiBOaXQ6IFRoZSBwcm9wZXIgd2F5IHRv
IHJlZmVyZW5jZSBhIGNvbW1pdCBpczoNCj4gDQo+IGNvbW1pdCA1ZmUxNTZmMWNhYjQgKCJyZWd1
bGF0b3I6IHBmdXplMTAwOiBhZGQgZW5hYmxlL2Rpc2FibGUgZm9yIHN3aXRjaCIpDQo+IA0KPiAx
MiBjaGFyIGZvciB0aGUgY29tbWl0IElEIGFuZCB0aGUgY29tbWl0IG5hbWUgaW5zaWRlICgiICIp
Lg0KPiANCj4gPiB0dXJuZWQgb2ZmIGlmICJyZWd1bGF0b3ItYWx3YXlzLW9uIiBpcyBOT1QgcHJl
c2VudCwgYXMgcGZ1emUgc3dpdGNoZXMNCj4gPiBhcmUgbm9ybWFsbHkgdXNlZCBieSBjcml0aWNh
bCBtb2R1bGVzIHdoaWNoIG11c3QgYmUgYWx3YXlzIE9OIG9yDQo+ID4gc2hhcmVkIGJ5IG1hbnkg
cGVyaXBoZXJhbHMgd2hpY2ggZG8gTk9UIGltcGxlbWVudCBwb3dlciBkb21haW4NCj4gPiBjb250
cm9sLCBzbyBqdXN0IG1ha2Ugc3VyZSBhbGwgc3dpdGNoZXMgYWx3YXlzIE9OIHRvIGF2b2lkIGFu
eSBzeXN0ZW0NCj4gPiBpc3N1ZSBjYXVzZWQgYnkgdW5leHBlY3RlZGx5IHR1cm5pbmcgb2ZmIHN3
aXRjaGVzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5n
QG54cC5jb20+DQo+IA0KPiBSZXZpZXdlZC1ieTogRmFiaW8gRXN0ZXZhbSA8ZmFiaW8uZXN0ZXZh
bUBueHAuY29tPg0KDQpUaGFua3MsIHdpbGwgaW1wcm92ZSBpdCBhbmQgYWxzbyB0aGUgb3RoZXIg
cGF0Y2ggZm9yIGlteDZzbGwuDQoNCkFuc29uLg0KDQoNCg==
