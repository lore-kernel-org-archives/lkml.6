Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F932C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 01:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F07692087F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 01:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lHJu06y4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F07692087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbeLDBaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 20:30:25 -0500
Received: from mail-eopbgr70052.outbound.protection.outlook.com ([40.107.7.52]:31184
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725943AbeLDBaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 20:30:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GIuF8spFsMvJiPqd5S2k0AfyI1XX7tQaWL7yynqph6w=;
 b=lHJu06y4mChyMaTUJEiLNjgnSFh1iYvhGNGJHYwm7kYDEp+46QTxJzvuAA4iD/98v4SPif1gW6Pmi9rwejbdE/m5ADbHkwlPILvl2IKVlJHEMllS+b/DzUPy+pG+Q9FPQYHfEjFLfXeh4EZN1wuRbGXzpkvAjOcCWBi3Thbpix4=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5281.eurprd04.prod.outlook.com (20.177.42.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.18; Tue, 4 Dec 2018 01:29:29 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927%2]) with mapi id 15.20.1382.020; Tue, 4 Dec 2018
 01:29:29 +0000
From:   Aisheng DONG <aisheng.dong@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V6 0/9] clk: add imx7ulp clk support
Thread-Topic: [PATCH V6 0/9] clk: add imx7ulp clk support
Thread-Index: AQHUfBop1Xq5Us4kAEeJejcBpfY7TqVthW+AgABjuOA=
Date:   Tue, 4 Dec 2018 01:29:29 +0000
Message-ID: <AM0PR04MB42111FFF525D6EC5D785692380AF0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1542200198-3017-1-git-send-email-aisheng.dong@nxp.com>
 <154386550302.88331.785218354920872757@swboyd.mtv.corp.google.com>
In-Reply-To: <154386550302.88331.785218354920872757@swboyd.mtv.corp.google.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [101.93.238.110]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5281;6:pVyt9fnd7lBGoIIrTaXetOHt6h4cXxaxhD5tHe1cSc2wu7VUKSopUxhRcy+nfpSFOJtGMBW6eRRG55/P2jNZtZqpr0psMD3jBskxPbfC6Mrw5w5i40yYqurTvtQCkuwIsY+yaCLtFvGfToiBxDC1loiXsxHNdrY5MMOC3U5s7+QFQd1zpWJg18jwZlZMCKm/KnO4RofFsXmMcxCnIn2ThTI4jVn6ovK5IL4xl8wdusxgLWYnZtSb2fNGF3DsAqS6ayKevNMIbq2RI1jmtdf6eISuIkTSMZzUmUrfH3D9Ti+/x8LVRR+xM5tLx2K4dTj+qz0xm1tZDt+wKEjQRvOOiqwMJWakXCRaOcmZSQoeB3Q40LV+vCrbrCZzS1PJbabF72aTUtGutCrufeNDI9MGIQNnLjN0eU+jblMRDZ+GWp2hmr/fEcAzc9NQf+HcNyr9ym80jy/JWOeW1yh5L6jR5w==;5:SXmhNaQgXMxcf7mS6g7jxbyg+KUfzoAWHMSIyQaw/HiOT2fRJDeBeBBIor0se04jnmK3zc7aLkmOqUydgAGt2znngp8NWRJ1zdsCjrmT25A5ILi3tRYZKzvJG+yrtzUe0vzFRc/R/9dEswvU6aGivRwWI9Y8XQQtzz3NllpfRCI=;7:uN3cDRitl2I8MR5q8n34Q7VKMH9mGDn+TR65xTlaqYljkLxI6e3/TqJiaPQ0fb4vYqZwzvvgDcEODIKWF+CtQklBMsb1kyX5klZlopjnSSl4bUJFjU6bQloKRkJ39oaVZHy0YTs8Ncz+SRY+ne4/3A==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 405910cf-df7e-4754-2dd7-08d65987efcb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5281;
x-ms-traffictypediagnostic: AM0PR04MB5281:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-microsoft-antispam-prvs: <AM0PR04MB52813980F3C8F8D93C54CE0680AF0@AM0PR04MB5281.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231455)(999002)(944501493)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB5281;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5281;
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39860400002)(136003)(366004)(199004)(189003)(13464003)(14454004)(2906002)(5660300001)(81166006)(8676002)(3846002)(6116002)(7696005)(68736007)(81156014)(54906003)(486006)(110136005)(99286004)(26005)(33656002)(8936002)(229853002)(4326008)(71200400001)(305945005)(7736002)(97736004)(71190400001)(53936002)(476003)(11346002)(14444005)(6436002)(256004)(66066001)(106356001)(6506007)(9686003)(74316002)(6246003)(25786009)(4001150100001)(478600001)(55016002)(105586002)(53546011)(2501003)(86362001)(76176011)(316002)(446003)(186003)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5281;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 98uTPsk7lCpVbGecP7D88OvTOZPJbVuConUIs0qPDu6/2W/WEfR5HKdg7HYihIFgxVA1xxhx1J7Z1VETR0y/0BOCDZINia26JRAfatULpwdBCDMRqczlhVVhYiGwtH8djHLv50AL4+YmpcBxT7yRHseRbev9Y4qc7C+GxIOZ1i8ixOCRjCWToKKhBNCzTs+XX10RP6Z4F1nCOyDOh2hgV13bq9sTtXUcMvp6Zs1G7/42EoTjlvl7+21qH4+w7vQIfn2VyArVuTWlKEnFsBaPJTd+X8oIdYOvEgqlrciBHfHKJybWc8H9WMfmm6QfJkWTWSsOisLBnzuB42WWGN5PWh8kYGeA20hk0AAjQ7lTsWM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 405910cf-df7e-4754-2dd7-08d65987efcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 01:29:29.7330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5281
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdGVwaGVuIEJveWQgW21haWx0
bzpzYm95ZEBrZXJuZWwub3JnXQ0KPiBTZW50OiBUdWVzZGF5LCBEZWNlbWJlciA0LCAyMDE4IDM6
MzIgQU0NCj4gVG86IEFpc2hlbmcgRE9ORyA8YWlzaGVuZy5kb25nQG54cC5jb20+OyBsaW51eC1j
bGtAdmdlci5rZXJuZWwub3JnDQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IG10dXJxdWV0dGVAYmF5bGli
cmUuY29tOyBzaGF3bmd1b0BrZXJuZWwub3JnOyBBbnNvbiBIdWFuZw0KPiA8YW5zb24uaHVhbmdA
bnhwLmNvbT47IEphY2t5IEJhaSA8cGluZy5iYWlAbnhwLmNvbT47IGRsLWxpbnV4LWlteA0KPiA8
bGludXgtaW14QG54cC5jb20+OyBBaXNoZW5nIERPTkcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPg0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIFY2IDAvOV0gY2xrOiBhZGQgaW14N3VscCBjbGsgc3VwcG9y
dA0KPiANCj4gUXVvdGluZyBBLnMuIERvbmcgKDIwMTgtMTEtMTQgMDU6MDE6MzEpDQo+ID4gVGhp
cyBwYXRjaCBzZXJpZXMgaW50ZW5kcyB0byBhZGQgaW14N3VscCBjbGsgc3VwcG9ydC4NCj4gPg0K
PiA+IGkuTVg3VUxQIENsb2NrIGZ1bmN0aW9ucyBhcmUgdW5kZXIgam9pbnQgY29udHJvbCBvZiB0
aGUgU3lzdGVtIENsb2NrDQo+ID4gR2VuZXJhdGlvbiAoU0NHKSBtb2R1bGVzLCBQZXJpcGhlcmFs
IENsb2NrIENvbnRyb2wgKFBDQykgbW9kdWxlcywgYW5kDQo+ID4gQ29yZSBNb2RlIENvbnRyb2xs
ZXIgKENNQykxIGJsb2Nrcw0KPiA+DQo+ID4gVGhlIGNsb2NraW5nIHNjaGVtZSBwcm92aWRlcyBj
bGVhciBzZXBhcmF0aW9uIGJldHdlZW4gTTQgZG9tYWluIGFuZCBBNw0KPiA+IGRvbWFpbi4gRXhj
ZXB0IGZvciBhIGZldyBjbG9jayBzb3VyY2VzIHNoYXJlZCBiZXR3ZWVuIHR3byBkb21haW5zLA0K
PiA+IHN1Y2ggYXMgdGhlIFN5c3RlbSBPc2NpbGxhdG9yIGNsb2NrLCB0aGUgU2xvdyBJUkMgKFNJ
UkMpLCBhbmQgYW5kIHRoZQ0KPiA+IEZhc3QgSVJDIGNsb2NrIChGSVJDTEspLCBjbG9jayBzb3Vy
Y2VzIGFuZCBjbG9jayBtYW5hZ2VtZW50IGFyZQ0KPiA+IHNlcGFyYXRlZCBhbmQgY29udGFpbmVk
IHdpdGhpbiBlYWNoIGRvbWFpbi4NCj4gPg0KPiA+IE00IGNsb2NrIG1hbmFnZW1lbnQgY29uc2lz
dHMgb2YgU0NHMCwgUENDMCwgUENDMSwgYW5kIENNQzAgbW9kdWxlcy4NCj4gPiBBNyBjbG9jayBt
YW5hZ2VtZW50IGNvbnNpc3RzIG9mIFNDRzEsIFBDQzIsIFBDQzMsIGFuZCBDTUMxIG1vZHVsZXMu
DQo+ID4NCj4gPiBOb3RlOiB0aGlzIHNlcmllcyBvbmx5IGFkZHMgQTcgY2xvY2sgZG9tYWluIHN1
cHBvcnQgYXMgTTQgY2xvY2sgZG9tYWluDQo+ID4gd2lsbCBiZSBoYW5kbGVkIGJ5IE00IHNlcGVy
YXRlbHkuDQo+ID4NCj4gDQo+IEkgZ290Og0KPiANCj4gZHJpdmVycy9jbGsvaW14L2Nsay1wbGx2
NC5jOjE1MjoxNTogd2FybmluZzogc3ltYm9sICdpbXhfY2xrX3BsbHY0JyB3YXMgbm90DQo+IGRl
Y2xhcmVkLiBTaG91bGQgaXQgYmUgc3RhdGljPw0KPiBkcml2ZXJzL2Nsay9pbXgvY2xrLXBmZHYy
LmM6MTY2OjE1OiB3YXJuaW5nOiBzeW1ib2wgJ2lteF9jbGtfcGZkdjInIHdhcyBub3QNCj4gZGVj
bGFyZWQuIFNob3VsZCBpdCBiZSBzdGF0aWM/DQo+IGRyaXZlcnMvY2xrL2lteC9jbGstZGl2aWRl
ci1nYXRlLmM6MTc0OjE1OiB3YXJuaW5nOiBzeW1ib2wNCj4gJ2lteF9jbGtfZGl2aWRlcl9nYXRl
JyB3YXMgbm90IGRlY2xhcmVkLiBTaG91bGQgaXQgYmUgc3RhdGljPw0KPiBkcml2ZXJzL2Nsay9p
bXgvY2xrLWNvbXBvc2l0ZS03dWxwLmM6MjI6MTU6IHdhcm5pbmc6IHN5bWJvbA0KPiAnaW14N3Vs
cF9jbGtfY29tcG9zaXRlJyB3YXMgbm90IGRlY2xhcmVkLiBTaG91bGQgaXQgYmUgc3RhdGljPw0K
PiANCj4gd2hpY2ggSSBjYW4gZml4IGVhc2lseSBieSB0aHJvd2luZyBpbiBjbGsuaCBpbnRvIGVh
Y2ggZmlsZS4NCg0KVGhhbmtzLCBJIHdpbGwgZG91YmxlIGNoZWNrIGl0IHdoZW4gSSBiYWNrIHRv
IG9mZmljZS4NCg0KUmVnYXJkcw0KRG9uZyBBaXNoZW5nDQoNCg==
