Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A331C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 00:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E9C253FF
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 00:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Dj3M5N0Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5E9C253FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932145AbeGBAx6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 20:53:58 -0400
Received: from mail-eopbgr60074.outbound.protection.outlook.com ([40.107.6.74]:36904
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753027AbeGBAxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 20:53:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qdy/OFyNsaspDTPHko33Vz+x/x3xrLVNHOvov1GG9us=;
 b=Dj3M5N0ZxyD71fQb4v9RcHCX6TWxGcTK3cFDJ24ZTclgGAbZhXgdA8jQSF+AcaG1asN00QiQHkLXKnScmv6Q+l+i6cdWZyVMEj6a49qXMtbWuLlGY0AvKeMWyBeyotnSt+3pE0DOUhIePA2A1b7pe9mhCkKP3ChmHjxClFvehPQ=
Received: from AM3PR04MB1315.eurprd04.prod.outlook.com (10.163.7.13) by
 AM3PR04MB1347.eurprd04.prod.outlook.com (10.163.185.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.20; Mon, 2 Jul 2018 00:53:50 +0000
Received: from AM3PR04MB1315.eurprd04.prod.outlook.com
 ([fe80::a024:25ab:f457:64c7]) by AM3PR04MB1315.eurprd04.prod.outlook.com
 ([fe80::a024:25ab:f457:64c7%7]) with mapi id 15.20.0906.026; Mon, 2 Jul 2018
 00:53:50 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>
CC:     Robin Gong <yibin.gong@nxp.com>,
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
Thread-Index: AQHUDD3lRelNZaT6s0KCSbdeyjhmZKR6JNEAgADqWICAABYs4A==
Date:   Mon, 2 Jul 2018 00:53:50 +0000
Message-ID: <AM3PR04MB131507901BFEE1A5E426EECBF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1529930051-14122-1-git-send-email-yibin.gong@nxp.com>
 <20180701093402.GN4348@dragon>
 <CAOMZO5BjOEGWv2dC-bp0BYHq+PhLssEKic+o7ock8_1Dobd=sQ@mail.gmail.com>
In-Reply-To: <CAOMZO5BjOEGWv2dC-bp0BYHq+PhLssEKic+o7ock8_1Dobd=sQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB1347;7:q2RFwFMmV89v4hGLzjDcssoorc+/f2jRtRmBufMEX1OdIgJu6TrHSrbmi+9OB26ym1EA268Yu1oq43UTJtyQhQoUR2Kz8r54340NqqPvNIhs+cmd1bOsoXxWVfOPxQbNAInYyJaPedCy5MoSiRk0nN2EIiVlCI9VDBGv9eZSALcQ8A8cFtZBiliJ0cNlaNhEScFCwPoj3qD//mB4O8H5Uh5UdUcXx1Dh6yVDMqZgpwhJTpF4mj+TqvXo7F0Ejv4J
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1db7620e-bcf1-4a68-c047-08d5dfb64672
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1347;
x-ms-traffictypediagnostic: AM3PR04MB1347:
x-microsoft-antispam-prvs: <AM3PR04MB13470F8F2F3E249E691C3AE3F5430@AM3PR04MB1347.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(85827821059158)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB1347;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1347;
x-forefront-prvs: 07215D0470
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(136003)(366004)(376002)(13464003)(199004)(189003)(7736002)(106356001)(39060400002)(2906002)(74316002)(256004)(25786009)(66066001)(14444005)(6246003)(446003)(53546011)(478600001)(54906003)(110136005)(105586002)(11346002)(86362001)(53936002)(6506007)(186003)(33656002)(7696005)(44832011)(76176011)(2900100001)(6436002)(99286004)(4326008)(476003)(6116002)(81156014)(3846002)(68736007)(81166006)(26005)(486006)(55016002)(14454004)(102836004)(97736004)(8676002)(8936002)(5660300001)(305945005)(229853002)(9686003)(5250100002)(316002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1347;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: WaqsunBEGBwjxWP2vO4mCOkzvW6eXt5kpoldr1+Rwwu+EkjW53znWfMrStFSnGNkMOroucUMdeUW4QVLRLxfTm3vnwmKZl5SDx3XgBFFNKHU0yTt4ROZFkYsZnBNjwoqt9lGmxfJIOMR0BLU3lEpiVMJiwgoG6sL8GGY7+yhQSTOvxSN+0Jr00zNg4HVuWOm0iKAbDCGhc8bzpdh/hJqzJz/3HK+nYdWSI4ew3ZyeYlgnEMlctrtsq1MfXDXT2tsLJAfrhS3sAyHqe+J/2RkuxF8fyLEz1z5cjugi7QaTR/a2yzH1cU+DDftUiwaI0W68tINjiQqSKMFIXDGvcaRpaSGWJ/OruyBK9B26gfCkmo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db7620e-bcf1-4a68-c047-08d5dfb64672
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2018 00:53:50.0609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1347
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkFuc29uIEh1YW5nDQpCZXN0IFJlZ2FyZHMhDQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiBGcm9tOiBGYWJpbyBFc3RldmFtIFttYWlsdG86ZmVzdGV2YW1AZ21haWwuY29t
XQ0KPiBTZW50OiBNb25kYXksIEp1bHkgMiwgMjAxOCA3OjMzIEFNDQo+IFRvOiBTaGF3biBHdW8g
PHNoYXduZ3VvQGtlcm5lbC5vcmc+OyBBbnNvbiBIdWFuZw0KPiA8YW5zb24uaHVhbmdAbnhwLmNv
bT4NCj4gQ2M6IFJvYmluIEdvbmcgPHlpYmluLmdvbmdAbnhwLmNvbT47IE1hcmsgUnV0bGFuZA0K
PiA8bWFyay5ydXRsYW5kQGFybS5jb20+OyBvcGVuIGxpc3Q6T1BFTiBGSVJNV0FSRSBBTkQgRkxB
VFRFTkVEDQo+IERFVklDRSBUUkVFIEJJTkRJTkdTIDxkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9y
Zz47IGxpbnV4LWtlcm5lbA0KPiA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IFJvYiBI
ZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+Ow0KPiBkbC1saW51eC1pbXggPGxpbnV4LWlteEBu
eHAuY29tPjsgU2FzY2hhIEhhdWVyIDxrZXJuZWxAcGVuZ3V0cm9uaXguZGU+Ow0KPiBGYWJpbyBF
c3RldmFtIDxmYWJpby5lc3RldmFtQG54cC5jb20+OyBtb2RlcmF0ZWQgbGlzdDpBUk0vRlJFRVND
QUxFDQo+IElNWCAvIE1YQyBBUk0gQVJDSElURUNUVVJFIDxsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjFdIEFSTTogZHRzOiBpbXg2
c2wtZXZrOiBrZWVwIHN3NCBhbHdheXMgb24NCj4gDQo+IE9uIFN1biwgSnVsIDEsIDIwMTggYXQg
NjozNCBBTSwgU2hhd24gR3VvIDxzaGF3bmd1b0BrZXJuZWwub3JnPiB3cm90ZToNCj4gPiBPbiBN
b24sIEp1biAyNSwgMjAxOCBhdCAwODozNDoxMVBNICswODAwLCBSb2JpbiBHb25nIHdyb3RlOg0K
PiA+PiBTVzQgaXMgb25lIHBvd2VyIHJhaWwgZm9yIExQRERSMiBvbiBpLm14NnNsLWV2aywgc28g
aXQgc2hvdWxkIGJlIGtlcHQNCj4gPj4gYWx3YXlzIG9uLiBCdXQgaXQncyBkaXNhYmxlZCBhZnRl
ciBzd2l0Y2ggZGlzYWJsZWQgaW50ZXJmYWNlDQo+ID4+IGltcGxlbWVudGVkIGluIHBmdXplIGRy
aXZlciAnY29tbWl0IDVmZTE1NmYxY2FiNA0KPiA+PiAoInJlZ3VsYXRvcjogcGZ1emUxMDA6IGFk
ZCBlbmFibGUvZGlzYWJsZSBmb3Igc3dpdGNoIiknLlRodXMsIGl0DQo+ID4+IGJyZWFrcyBrZXJu
ZWwgYm9vdHVwLiBBZGQgJ3JlZ3VsYXRvci1hbHdheXMtb24nIGZvciBTVzQuDQo+ID4+DQo+ID4+
IFNpZ25lZC1vZmYtYnk6IFJvYmluIEdvbmcgPHlpYmluLmdvbmdAbnhwLmNvbT4NCj4gPg0KPiA+
IERvZXMgdGhhdCBtZWFuIGJvYXJkcyB3aXRoIGV4aXN0aW5nIERUQiBpbnN0YWxsZWQgd2lsbCBz
dG9wIHdvcmtpbmcNCj4gPiB3aXRoIG5ldyBrZXJuZWw/ICBUaGF0J3MgYmFkLCBhbmQgdGhlIGtl
cm5lbCBjb21taXQgc2hvdWxkIHByb2JhYmx5IGJlDQo+ID4gcmV2ZXJ0ZWQuDQo+IA0KPiBZZXMs
IHRoaXMgaXMgYSBnb29kIHBvaW50Lg0KPiANCj4gQW5zb24sDQo+IA0KPiBTaG91bGQgNWZlMTU2
ZjFjYWI0ICgicmVndWxhdG9yOiBwZnV6ZTEwMDogYWRkIGVuYWJsZS9kaXNhYmxlIGZvcg0KPiBz
d2l0Y2giKSBiZSByZXZlcnRlZCB0byBhdm9pZCBzdWNoIGJyZWFrYWdlPw0KIA0KWWVzLCBJIHRo
aW5rIHdlIGNhbiByZXZlcnQgaXQgdG8gYXZvaWQgYnJlYWthZ2UuIERpZG4ndCBub3RpY2UgdGhh
dCBzb21lDQppLk1YIHBsYXRmb3JtIGRvIE5PVCBoYXZlIHRob3NlIGNyaXRpY2FsIHN3aXRjaGVz
IGFsd2F5cy1vbi4NCg0KQW5zb24uDQoNCg==
