Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6B0C7112B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 09:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C102205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 09:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nUCWzePt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C102205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbeJORSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 13:18:07 -0400
Received: from mail-eopbgr30043.outbound.protection.outlook.com ([40.107.3.43]:41514
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726614AbeJORSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 13:18:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9cTEyFP8MiEFF85wjj99XfXr0I6VBX/eEpyMwQi/nro=;
 b=nUCWzePtyY89xSTnqSWBYAFIfp7BVndnWLyapxaOG3a2Yra3OARXvYpdp73M12sJAdYoLsmL1x2ZiMnCw4XG5vmuyuA/yW76YiszcYP/Xxc6NQFWzJj1/x2dK0QasDPRIe4C9qishVq2w6cL/AYRDdm8z/oAAlJqLaCEiKYbwZ4=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3850.eurprd04.prod.outlook.com (52.134.65.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.26; Mon, 15 Oct 2018 09:33:35 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5c30:b387:c71a:7071]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5c30:b387:c71a:7071%2]) with mapi id 15.20.1228.027; Mon, 15 Oct 2018
 09:33:35 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Jerome Forissier <jerome.forissier@linaro.org>,
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 2/2] clk: imx: imx7d: remove clks_init_on array
Thread-Topic: [PATCH 2/2] clk: imx: imx7d: remove clks_init_on array
Thread-Index: AQHULtJmBbQCL7E8lECcVaukjbrAoqS1i6SAgAAAVtCAB1yugIAcTbiAgABtsgCAAKaTAIAEBEiQgDcH54CAAA4SYIAHBm0AgAQKbLA=
Date:   Mon, 15 Oct 2018 09:33:35 +0000
Message-ID: <DB3PR0402MB39169A3BA844F7833B62FF55F5FD0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1533703167-26583-1-git-send-email-Anson.Huang@nxp.com>
 <AM0PR04MB4481FC2BAD71B75D7BE84C0788260@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916F8BC381BBA01DB21D1C0F5260@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <AM0PR04MB44813C7A3E0AF4F3BCFFCF0088390@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <153567894721.93865.4092113232222931488@swboyd.mtv.corp.google.com>
 <a6489bda-703f-207c-0b24-60f4044fe89f@linaro.org>
 <153573827629.93865.6200966443862432044@swboyd.mtv.corp.google.com>
 <AM6PR0402MB391120110A289BA5FB6B9F0DF50C0@AM6PR0402MB3911.eurprd04.prod.outlook.com>
 <153898445180.119890.15025812558797341532@swboyd.mtv.corp.google.com>
 <DB3PR0402MB391664354775DF42E90E67C9F5E60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <153937368201.5275.2313781259297807972@swboyd.mtv.corp.google.com>
In-Reply-To: <153937368201.5275.2313781259297807972@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3850;6:GUIXhRZg+Ydm8vXelzIdMYxt7y92Vpt8NLnLEHbaOuPk7nkC+uhoQrlfhYCBpRiXmTqHBgchwAie3qlMXTzpsUSNKKAjunD9Ys41YPM0hpWNZ9nshs9nZgWucoQUCp4pPi0ifrhTAcIlhkPNzmpIjCwnJ1vLjU3SPrhe5ZrrJQMFinJEtoJRMP32RjzsbHfZl913GRM6I56NZ4kCGvykYoxbZLv/Y6bhwCVOMY5aiqI8yMyANEgVVI/eDnBNPvozY7uiECDaoFnYXvinKjpV/g/cgKYuJxdkJDX9jluP/MICh/eiO1gRRX6S2zrfSPViW2RNUU7J7m6xHEMjPvpG+KgemgCByjwinwV2RaKBVXYXGkokFc+cvNpZrEOAPdTgQCRZqUSCQ4+sBqrupc4hwuiXEg+84uhPMtyVE4nmrNl/SIVRBuWSbHfpzCuCRTlq30dQ5cR1Hdz6h7CoqtLdwg==;5:FUEDztVz2B16NbDtt5cDwSf7H5+hEWarOGxNeqimcImrxk+Py5AdE21TlzudoasVN951jic5K4mSj5UplBJG4NpwbFjVFYW5rfSmufX6GpYNJhmtxC3Zg0i0evjvEYh4TPV3S8atcJh4rQvAWgihZlceKrRK8aofdq4tHUes94Y=;7:0w7/fSQ3xBoeMvMpGPCAST+NbM17UvEq/jZIxdT7Vn2Au6JZTLx8S13Oua5/xvWgl6as5SH+iPnxBTiMBl1BdH2f9m0wQn8HhoFFOCNK+6jdtcrUNqHLtr1hOc9pgJFWXhpGMtE9GBWZZRoaVphoGrSTFdU4YMVi/Bu1rUxX7DIh8UbDAeFKQuYUMFUVLtTb3hLhAO3n/zi9p8xjyJJr8XyGjYvJiefHcgX+850KmE9+ED7A2Rg+yODSAMPWIk0k
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 0255ecdd-f3b9-46ed-f921-08d6328147d6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3850;
x-ms-traffictypediagnostic: DB3PR0402MB3850:
x-microsoft-antispam-prvs: <DB3PR0402MB3850FA4EDD103E866199C2B0F5FD0@DB3PR0402MB3850.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(258649278758335)(9452136761055)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(10201501046)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051);SRVR:DB3PR0402MB3850;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3850;
x-forefront-prvs: 0826B2F01B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(39860400002)(136003)(366004)(189003)(13464003)(199004)(55016002)(9686003)(68736007)(2906002)(53936002)(76176011)(6246003)(6506007)(229853002)(7416002)(316002)(53546011)(7736002)(74316002)(7696005)(93886005)(305945005)(102836004)(6116002)(3846002)(11346002)(106356001)(110136005)(99286004)(6436002)(8676002)(81166006)(476003)(8936002)(486006)(33656002)(105586002)(44832011)(81156014)(5660300001)(446003)(71200400001)(71190400001)(66066001)(478600001)(97736004)(14454004)(4326008)(256004)(14444005)(26005)(186003)(25786009)(5250100002)(2501003)(2900100001)(2201001)(86362001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3850;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: J2Ym9OThZMoq6mGNeiAfV4yXT8FbkpzXT6MFuax/zbG8j4HbL0aWwcqWLvp2RtEZPo40oV1CkJOwUMxvNJ7Ehv1+SYMH4WHQeV2nidCqA/vcrnG7ZgrbRg9L4INuyhnDeBJsIQRxEd1bJ/DKX63rkRtiSW9H4nj1tVeSOuT2dL6TqZzkYwVzlp3ATbCQQoch2XMmGrltbq+Z+Q4VmGiRgcZXzDYVI8hetykA6HC1t7sQyAs7x3oZ2idzNOxpNP6ah6ei7o2fO025qvVG+LI6L8Qj+Uecq1nK+oV76Tr0Sq5FsUAjeUKHug4pn/cLyfZSvxFn4wTouCkfkJM6Ll+I7gngERT7G9o/saHrFsP9644=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0255ecdd-f3b9-46ed-f921-08d6328147d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2018 09:33:35.6544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3850
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFN0ZXBoZW4NCg0KQW5zb24gSHVhbmcNCkJlc3QgUmVnYXJkcyENCg0KDQo+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFN0ZXBoZW4gQm95ZCA8c2JveWRAa2VybmVsLm9y
Zz4NCj4gU2VudDogU2F0dXJkYXksIE9jdG9iZXIgMTMsIDIwMTggMzo0OCBBTQ0KPiBUbzoga2Vy
bmVsQHBlbmd1dHJvbml4LmRlOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7
DQo+IGxpbnV4LWNsa0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7DQo+IG10dXJxdWV0dGVAYmF5bGlicmUuY29tOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBz
aGF3bmd1b0BrZXJuZWwub3JnOw0KPiBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT47
IEZhYmlvIEVzdGV2YW0NCj4gPGZhYmlvLmVzdGV2YW1AbnhwLmNvbT47IEplcm9tZSBGb3Jpc3Np
ZXIgPGplcm9tZS5mb3Jpc3NpZXJAbGluYXJvLm9yZz47DQo+IFBlbmcgRmFuIDxwZW5nLmZhbkBu
eHAuY29tPjsgUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NCj4gQ2M6IGRsLWxpbnV4LWlt
eCA8bGludXgtaW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggMi8yXSBjbGs6IGlt
eDogaW14N2Q6IHJlbW92ZSBjbGtzX2luaXRfb24gYXJyYXkNCj4gDQo+IFF1b3RpbmcgQW5zb24g
SHVhbmcgKDIwMTgtMTAtMDggMDE6MzQ6NTkpDQo+ID4gPiBRdW90aW5nIEFuc29uIEh1YW5nICgy
MDE4LTA5LTAzIDAwOjIwOjUzKQ0KPiA+ID4gPiA+ID4gT24gMDgvMzEvMjAxOCAwMzoyOSBBTSwg
U3RlcGhlbiBCb3lkIHdyb3RlOg0KPiA+ID4gPiA+ID4gPiBRdW90aW5nIFBlbmcgRmFuICgyMDE4
LTA4LTEyIDE4OjE1OjQxKQ0KPiA+ID4gPiA+ID4gPj4gSGkgQW5zb24sDQo+ID4gPiA+ID4gPiA+
Pg0KPiA+ID4gPiA+ID4gPj4+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+ID4g
PiA+ID4+Pj4+IEZyb206IEFuc29uIEh1YW5nDQo+ID4gPiA+ID4gPiA+Pj4+PiBTZW50OiAyMDE4
5bm0OOaciDjml6UgMTI6MzkNCj4gPiA+ID4gPiA+ID4+Pj4+IFRvOiBzaGF3bmd1b0BrZXJuZWwu
b3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOw0KPiA+ID4gPiA+ID4gPj4+Pj4ga2VybmVsQHBl
bmd1dHJvbml4LmRlOyBGYWJpbyBFc3RldmFtDQo+ID4gPiA+ID4gPiA+Pj4+PiA8ZmFiaW8uZXN0
ZXZhbUBueHAuY29tPjsgbXR1cnF1ZXR0ZUBiYXlsaWJyZS5jb207DQo+ID4gPiA+ID4gPiA+Pj4+
PiBzYm95ZEBrZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7
DQo+ID4gPiA+ID4gPiA+Pj4+PiBsaW51eC1jbGtAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnDQo+ID4gPiA+ID4gPiA+Pj4+PiBDYzogZGwtbGludXgtaW14IDxs
aW51eC1pbXhAbnhwLmNvbT4NCj4gPiA+ID4gPiA+ID4+Pj4+IFN1YmplY3Q6IFtQQVRDSCAyLzJd
IGNsazogaW14OiBpbXg3ZDogcmVtb3ZlDQo+ID4gPiA+ID4gPiA+Pj4+PiBjbGtzX2luaXRfb24g
YXJyYXkNCj4gPiA+ID4gPiA+ID4+Pj4+DQo+ID4gPiA+ID4gPiA+Pj4+PiBDbG9jayBmcmFtZXdv
cmsgd2lsbCBlbmFibGUgdGhvc2UgY2xvY2tzIHJlZ2lzdGVyZWQgd2l0aA0KPiA+ID4gPiA+ID4g
Pj4+Pj4gQ0xLX0lTX0NSSVRJQ0FMIGZsYWcsIHNvIG5vIG5lZWQgdG8gaGF2ZSBjbGtzX2luaXRf
b24NCj4gPiA+ID4gPiA+ID4+Pj4+IGFycmF5IGR1cmluZyBjbG9jaw0KPiA+ID4gPiA+ID4gPj4+
PiBpbml0aWFsaXphdGlvbiBub3cuDQo+ID4gPiA+ID4gPiA+Pj4+DQo+ID4gPiA+ID4gPiA+Pj4+
IFdpbGwgaXQgYmUgbW9yZSBmbGV4aWJsZSB0byBwYXJzZSBkdHMgc2F5aW5nICJjcml0aWNhbC1j
bG9ja3MgPQ0KPiA8eHh4PiINCj4gPiA+ID4gPiA+ID4+Pj4gb3IgImluaXQtb24tYXJyYXJ5PTx4
eHg+Ig0KPiA+ID4gPiA+ID4gPj4+PiBhbmQgZW5hYmxlIHRob3NlIGNsb2Nrcz8NCj4gPiA+ID4g
PiA+ID4+Pg0KPiA+ID4gPiA+ID4gPj4+IFBhcnNpbmcgdGhlIGNsb2NrcyBhcnJheXMgZnJvbSBk
dGIgaXMgYW5vdGhlciB3YXkgb2YNCj4gPiA+ID4gPiA+ID4+PiBlbmFibGluZyBjcml0aWNhbCBj
bG9ja3MsIGJ1dCBmb3IgY3VycmVudCBpLk1YNi83DQo+ID4gPiA+ID4gPiA+Pj4gcGxhdGZvcm1z
LCB3ZSBpbXBsZW1lbnQgaXQgaW4gc2FtZSB3YXkgYXMgbW9zdCBvZiBvdGhlcg0KPiA+ID4gPiA+
ID4gPj4+IFNvQ3MsIGN1cnJlbnRseSBJIGRpZCBOT1Qgc2VlIGFueSBuZWNlc3NpdHkgb2YgcHV0
dGluZw0KPiA+ID4gPiA+ID4gPj4+IHRoZW0gaW4gZHRiLCBqdXN0IGFkZGluZyBmbGFnIGR1cmlu
ZyBjbG9jayByZWdpc3RlcmluZyBpcw0KPiA+ID4gPiA+ID4gPj4+IG1vcmUgc2ltcGxlLCBpZiB0
aGVyZSBpcyBhbnkgc3BlY2lhbCByZXF1aXJlbWVudCBmb3INCj4gPiA+ID4gPiA+ID4+PiBkaWZm
ZXJlbnQgY2xvY2tzIHNldCB0byBiZSBlbmFibGVkLCB0aGVuIHdlIGNhbiBhZGQNCj4gPiA+ID4g
PiA+ID4+PiBzdXBwb3J0IHRvIGVuYWJsZQ0KPiA+ID4gPiA+IHRoZSBtZXRob2Qgb2YgcGFyc2lu
ZyBjcml0aWNhbC1jbG9ja3MgZnJvbSBkdGIuIEp1c3QgbXkgdHdvIGNlbnRzLg0KPiA+ID4gPiA+
ID4gPj4NCj4gPiA+ID4gPiA+ID4+IFRoaW5raW5nIGFib3V0IE9QLVRFRSB3YW50IHRvIHVzZSBv
bmUgZGV2aWNlLCBidXQgaXQncw0KPiA+ID4gPiA+ID4gPj4gY2xvY2tzIGFyZSByZWdpc3RlcmVk
IGJ5IExpbnV4LCBiZWNhdXNlIHRoZXJlIGlzIG5vIG1vZHVsZQ0KPiA+ID4gPiA+ID4gPj4gaW4g
TGludXggc2lkZSB1c2UgaXQsIGl0IHdpbGwgc2h1dGRvd24gdGhlIGNsb2NrLCB3aGljaA0KPiA+
ID4gPiA+ID4gPj4gY2F1c2UgT1AtVEVFIGNvdWxkIG5vdCBhY2Nlc3MgdGhlDQo+ID4gPiA+ID4g
ZGV2aWNlLg0KPiA+ID4gPiA+ID4gPj4NCj4gPiA+ID4gPiA+ID4+IFRoZW4gcGVvcGxlIGhhdmUg
dG8gbW9kaWZ5IGNsayBjb2RlIHRvIGFkZCBDTEtfSVNfQ1JJVElDQUwNCj4gPiA+ID4gPiA+ID4+
IGZsYWcgdG8gbWFrZSBzdXJlIHRoZSBjbG9ja3MgYXJlIG5vdCBzaHV0ZG93biBieSBMaW51eC4N
Cj4gPiA+ID4gPiA+ID4+DQo+ID4gPiA+ID4gPiA+PiBIb3dldmVyIGFkZGluZyBhIG5ldyBwcm9w
ZXJ0eSBpbiBjbGsgbm9kZSBhbmQgbGV0IGRyaXZlcg0KPiA+ID4gPiA+ID4gPj4gY29kZSBwYXJz
ZSB0aGUgZHRzLCB0aGVyZSBpcyBubyBuZWVkIHRvIG1vZGlmeSBjbGsgZHJpdmVyDQo+ID4gPiA+
ID4gPiA+PiBjb2RlIHdoZW4gT1AtVEVFIG5lZWRzDQo+ID4gPiA+ID4gYW5vdGhlciBkZXZpY2Ug
Y2xvY2suDQo+ID4gPiA+ID4gPiA+Pg0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiBJZiBP
UC1URUUgbmVlZHMgbGludXggdG8ga2VlcCB0aGluZ3Mgb24gdGhlbiB3aHkgY2FuJ3QgdGhlDQo+
ID4gPiA+ID4gPiA+IE9QLVRFRSBkcml2ZXIgaW4gTGludXggcHJvYmUsIGFjcXVpcmUgY2xvY2tz
LCBhbmQga2VlcCB0aGUNCj4gPiA+ID4gPiA+ID4gY2xrcyBlbmFibGVkDQo+ID4gPiBmb3JldmVy
Pw0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFNvdW5kcyByZWFzb25hYmxlLCBidXQgaG93IGNv
dWxkIHRoaXMgYmUgZG9uZSB3aXRob3V0DQo+ID4gPiA+ID4gPiBpbnRyb2R1Y2luZyBwbGF0Zm9y
bS1zcGVjaWZpYyBzdHVmZiBpbiB0aGUgT1AtVEVFIGRyaXZlcj8NCj4gPiA+ID4gPiA+DQo+ID4g
PiA+ID4NCj4gPiA+ID4gPiBXaHkgaXMgdGhhdCBhIGdvYWw/DQo+ID4gPiA+DQo+ID4gPiA+IEkg
ZG8gTk9UIHRoaW5rIHdlIHNob3VsZCBjb25zaWRlciBzdWNoIGNhc2UgaW4gdGhpcyBwYXRjaCBz
ZXJpZXMsDQo+ID4gPiA+IHdoYXRldmVyIE9QLVRFRSBuZWVkcyBmb3IgaXRzIG93biBmZWF0dXJl
LCBpdCBzaG91bGQgZG8gbmVjZXNzYXJ5DQo+ID4gPiA+IG9wZXJhdGlvbnMNCj4gPiA+IGVpdGhl
ciBpbiBpdHMgZHJpdmVyIG9yIHNvbWV3aGVyZSBlbHNlIGJ5IGFkZGluZyBuZXcgcGF0Y2guDQo+
ID4gPiA+DQo+ID4gPg0KPiA+ID4gV2h5IGNhbid0IHdlIGFkZCBjbGtzIHRvIHRoZSBvcC10ZWUg
bm9kZSBpbiBEVCdzIC9maXJtd2FyZSBjb250YWluZXI/DQo+ID4gPiBUaGVuIGFueSBjbGtzIGlu
IHRoZXJlIGNhbiBiZSB0dXJuZWQgb24gZm9yZXZlciBhbmQgbGVmdCBlbmFibGVkIGJ5DQo+ID4g
PiB0aGUgbGludXggZHJpdmVyPw0KPiA+DQo+ID4gSSBkaWQgTk9UIHJ1biBvcC10ZWUgd2l0aCBM
aW51eC1uZXh0IGtlcm5lbCBiZWZvcmUsIGNhbiB5b3UgYWR2aXNlIG1vcmU/DQo+IA0KPiBOZWl0
aGVyIGhhdmUgSSwgc28gSSBjYW4ndCBhZHZpc2UgbW9yZS4NCj4gDQo+ID4gQW5kIEkgdGhpbmsg
aWYgb3AtdGVlIGhhcyBzdWNoIHJlcXVpcmVtZW50LCBjYW4gd2UgaGF2ZSBhbm90aGVyIHBhdGNo
DQo+ID4gdG8gY292ZXIgaXQ/DQo+IA0KPiBZZXMuDQo+IA0KPiANCj4gPiBJIGJlbGlldmUgYWxs
IG90aGVyIGkuTVggcGxhdGZvcm1zIGFsc28gaGF2ZSBzYW1lIHJlcXVpcmVtZW50cyBpZg0KPiA+
IGNvbnNpZGVyaW5nIG9wLXRlZSBzdXBwb3J0LCBzbyBJIHRoaW5rIGl0IHNob3VsZCBiZSBhbm90
aGVyIHRvcGljLCB3aGF0IGRvIHlvdQ0KPiB0aGluaz8NCj4gPg0KPiANCj4gSSdtIGdvaW5nIHRv
IGRyb3AgdGhlc2UgcGF0Y2hlcyBmcm9tIG15IHJldmlldyBxdWV1ZS4gUGxlYXNlIHJlc2VuZCB0
aGVtDQo+IGFuZCBwbGVhc2UgaW5jbHVkZSB0aGUgb3AtdGVlIHBhdGNoZXMgdG9vLg0KDQoNCkkg
ZG8gTk9UIGtub3cgaG93IHRvIGluY2x1ZGUgdGhlIG9wLXRlZSBwYXRjaCB0byBtZWV0IHNwZWNp
YWwgcmVxdWlyZW1lbnQsIHNob3VsZA0KdGhlIG9wLXRlZSByZWxhdGVkIHBhdGNoIGJlIGFkZGVk
IGxhdGVyIHdoZW4gc29tZW9uZSBhY3R1YWxseSBhZGQgdGhlIG9wLXRlZSBzdXBwb3J0IGZvciBp
Lk1YNz8NCkl0IHNob3VsZCBOT1QgYmxvY2sgdGhpcyBwYXRjaCBzZXQsIGRvIHlvdSB0aGluayB3
ZSBjYW4gYWRkIHRoaXMgcGF0Y2ggc2V0IGZpcnN0Pw0KDQpBbnNvbi4NCg0KDQoNCg==
