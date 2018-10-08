Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E719C64EB8
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9ABE2087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="L0XvAzHM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9ABE2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbeJHPph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 11:45:37 -0400
Received: from mail-eopbgr00044.outbound.protection.outlook.com ([40.107.0.44]:2751
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726096AbeJHPph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 11:45:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIYl46BFKdznWXL+CUuWN29zosPYM4dA7OYWuMICMME=;
 b=L0XvAzHMZAJ48piwxYwIURPj1iRtgZaJM2nbXD8h4UNn6OLOahh3UonhTwUpFXdt5EnwfkqA+jmPt1lnRbse8shKx9Gv+XTGvqLDGG7FLhAL6fiDIwfAvY9d9kYuP53/gD0pIFugf1PhIFus/adfkj1V8mgeIaarLnDRSOADHGo=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3769.eurprd04.prod.outlook.com (52.134.71.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.22; Mon, 8 Oct 2018 08:34:59 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5c30:b387:c71a:7071]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5c30:b387:c71a:7071%2]) with mapi id 15.20.1207.024; Mon, 8 Oct 2018
 08:34:59 +0000
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
Thread-Index: AQHULtJmBbQCL7E8lECcVaukjbrAoqS1i6SAgAAAVtCAB1yugIAcTbiAgABtsgCAAKaTAIAEBEiQgDcH54CAAA4SYA==
Date:   Mon, 8 Oct 2018 08:34:59 +0000
Message-ID: <DB3PR0402MB391664354775DF42E90E67C9F5E60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1533703167-26583-1-git-send-email-Anson.Huang@nxp.com>
 <1533703167-26583-2-git-send-email-Anson.Huang@nxp.com>
 <AM0PR04MB4481FC2BAD71B75D7BE84C0788260@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916F8BC381BBA01DB21D1C0F5260@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <AM0PR04MB44813C7A3E0AF4F3BCFFCF0088390@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <153567894721.93865.4092113232222931488@swboyd.mtv.corp.google.com>
 <a6489bda-703f-207c-0b24-60f4044fe89f@linaro.org>
 <153573827629.93865.6200966443862432044@swboyd.mtv.corp.google.com>
 <AM6PR0402MB391120110A289BA5FB6B9F0DF50C0@AM6PR0402MB3911.eurprd04.prod.outlook.com>
 <153898445180.119890.15025812558797341532@swboyd.mtv.corp.google.com>
In-Reply-To: <153898445180.119890.15025812558797341532@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3769;6:bl0UHnUz1vTkJbrm4h69xU2O2epE31hjUpIYOepQiojah15WqV0gzBtPkPkC2ggql08VmVDdycOwAC7HW5tGCR5BrW3bELDorv5IFg12f0af41oU3Jz6mFA3lI3yeR3cUz3o1lz6pxtSlD9myIL6PIJlOGO6NyEOx2FfOF7kE35tzSLSnbCbJ5I9ctjSdlJ87Us3IfSPujyW9T9pNEfK5KW/pwiLDowKmS9f+u2fomIuYKUWACctzW5fP9bgti9udJ2XF3qpQB5QMW2tsT8SgsNRpJdJBRPHKar0fOBYcX8rCooTdfKwih7FgY+YMgqgS+lzG1EeBukEc6ilzdlq1HXbnST9n9k/IGv/xLnf3QWvCILNsTV6RaDpCjX2QKuui3ChMUbuKc5bxK/eTn5NadnhwxmomWXoDaK+atCIWMRl3OgLWIT/bY32EplyTVMnGb7eiRIAm4R4FeZgALfJTg==;5:S18vVMw9Yt+2o2Zzlmi2i7QpEFWTfGRZL22j70I8IXPi0iWI4F3m6QERtmc7qNIe/sdtXs4gLnl67kefBuAfZVHIr6D1Wk6AZzZNf3dS8lQez+iPFKIhBMsXpNHuuh2Eu5cwi0vlVZTHzEVRylfgmTJpOkEfn3Iw18VXl/tTC08=;7:ZW5akvQWWRMl0suOw1gWUPDCcWRhx++SDuiAhYOpW2wafoocpVU8TsgEbDmt2boz9BFEyYlrjpc6obD4Ioi/yeYygplmUpNOtxZypRslMtDPITQG2Cb8qwbT+J4kkoUs+P3HRBnAXu++EToh6EmHwLEs3ZuxcBa0EBLIzcQ1AwZBAbNqO51LNEcVdDLX4esP9FlmhdJ7kpKbo92cLq/e7xOoi9wwdQj5XzAXZa7GvX48JV4VGggCNUpF7wk91wLY
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b7f914c4-7a69-492a-ac85-08d62cf8ef2e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3769;
x-ms-traffictypediagnostic: DB3PR0402MB3769:
x-microsoft-antispam-prvs: <DB3PR0402MB3769E658F3A5D842BF56BE02F5E60@DB3PR0402MB3769.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(258649278758335)(9452136761055)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699051);SRVR:DB3PR0402MB3769;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3769;
x-forefront-prvs: 081904387B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(39860400002)(396003)(136003)(13464003)(189003)(199004)(9686003)(5660300001)(53546011)(99286004)(7696005)(55016002)(105586002)(76176011)(106356001)(4326008)(6506007)(14454004)(316002)(93886005)(71200400001)(53936002)(71190400001)(8936002)(7416002)(74316002)(305945005)(68736007)(102836004)(66066001)(81166006)(2501003)(81156014)(5250100002)(97736004)(256004)(6436002)(8676002)(33656002)(11346002)(110136005)(229853002)(6246003)(7736002)(44832011)(86362001)(25786009)(3846002)(6116002)(2900100001)(486006)(446003)(2201001)(478600001)(186003)(2906002)(476003)(14444005)(26005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3769;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: O1/71XRD44wghdJm/zClOar2+qtUkOACTIVaylcmfna4hdSdymmcEgm4eonhTPDBu8Xh0iQvMdkokMVIBcAZG8wVWdjksUa3Y5x8aaTX18J0pEQjvSlbJD9M2wTt2caWpzS9gEfMfBKOkt3WKjN/2qYr/0PJ60/iqmcA2gaj5Qrp7+nhVJ1kIOfg9bbiFbYewmgtdNZi7D1zNVONgAKEmRtUzQSMFL/2q23rRhIfDQrV4cXA1LIDzIj4B+kE1KizWRIv0U8AhfC+W6XeR/FNVlSGjp21+2SKXB0B/sPUAOSmHASeC02zqRmLpfOYgFwNi2nXvRTb2Ww0IKEsYTx77YoybyzsnQ6r62CayULTM68=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f914c4-7a69-492a-ac85-08d62cf8ef2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2018 08:34:59.4938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3769
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkFuc29uIEh1YW5nDQpCZXN0IFJlZ2FyZHMhDQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiBGcm9tOiBTdGVwaGVuIEJveWQgPHNib3lkQGtlcm5lbC5vcmc+DQo+IFNlbnQ6
IE1vbmRheSwgT2N0b2JlciA4LCAyMDE4IDM6NDEgUE0NCj4gVG86IGtlcm5lbEBwZW5ndXRyb25p
eC5kZTsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBsaW51eC1jbGtA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBtdHVycXVl
dHRlQGJheWxpYnJlLmNvbTsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsgc2hhd25ndW9Aa2VybmVs
Lm9yZzsNCj4gQW5zb24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5jb20+OyBGYWJpbyBFc3RldmFt
DQo+IDxmYWJpby5lc3RldmFtQG54cC5jb20+OyBKZXJvbWUgRm9yaXNzaWVyIDxqZXJvbWUuZm9y
aXNzaWVyQGxpbmFyby5vcmc+Ow0KPiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT47IFJvYiBI
ZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQo+IENjOiBkbC1saW51eC1pbXggPGxpbnV4LWlteEBu
eHAuY29tPg0KPiBTdWJqZWN0OiBSRTogW1BBVENIIDIvMl0gY2xrOiBpbXg6IGlteDdkOiByZW1v
dmUgY2xrc19pbml0X29uIGFycmF5DQo+IA0KPiBRdW90aW5nIEFuc29uIEh1YW5nICgyMDE4LTA5
LTAzIDAwOjIwOjUzKQ0KPiA+ID4gPiBPbiAwOC8zMS8yMDE4IDAzOjI5IEFNLCBTdGVwaGVuIEJv
eWQgd3JvdGU6DQo+ID4gPiA+ID4gUXVvdGluZyBQZW5nIEZhbiAoMjAxOC0wOC0xMiAxODoxNTo0
MSkNCj4gPiA+ID4gPj4gSGkgQW5zb24sDQo+ID4gPiA+ID4+DQo+ID4gPiA+ID4+Pj4+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiA+ID4+Pj4+IEZyb206IEFuc29uIEh1YW5nDQo+
ID4gPiA+ID4+Pj4+IFNlbnQ6IDIwMTjlubQ45pyIOOaXpSAxMjozOQ0KPiA+ID4gPiA+Pj4+PiBU
bzogc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsNCj4gPiA+ID4g
Pj4+Pj4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBGYWJpbyBFc3RldmFtDQo+ID4gPiA+ID4+Pj4+
IDxmYWJpby5lc3RldmFtQG54cC5jb20+OyBtdHVycXVldHRlQGJheWxpYnJlLmNvbTsNCj4gPiA+
ID4gPj4+Pj4gc2JveWRAa2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnOw0KPiA+ID4gPiA+Pj4+PiBsaW51eC1jbGtAdmdlci5rZXJuZWwub3JnOyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+ID4gPiA+ID4+Pj4+IENjOiBkbC1saW51eC1pbXggPGxp
bnV4LWlteEBueHAuY29tPg0KPiA+ID4gPiA+Pj4+PiBTdWJqZWN0OiBbUEFUQ0ggMi8yXSBjbGs6
IGlteDogaW14N2Q6IHJlbW92ZSBjbGtzX2luaXRfb24NCj4gPiA+ID4gPj4+Pj4gYXJyYXkNCj4g
PiA+ID4gPj4+Pj4NCj4gPiA+ID4gPj4+Pj4gQ2xvY2sgZnJhbWV3b3JrIHdpbGwgZW5hYmxlIHRo
b3NlIGNsb2NrcyByZWdpc3RlcmVkIHdpdGgNCj4gPiA+ID4gPj4+Pj4gQ0xLX0lTX0NSSVRJQ0FM
IGZsYWcsIHNvIG5vIG5lZWQgdG8gaGF2ZSBjbGtzX2luaXRfb24gYXJyYXkNCj4gPiA+ID4gPj4+
Pj4gZHVyaW5nIGNsb2NrDQo+ID4gPiA+ID4+Pj4gaW5pdGlhbGl6YXRpb24gbm93Lg0KPiA+ID4g
PiA+Pj4+DQo+ID4gPiA+ID4+Pj4gV2lsbCBpdCBiZSBtb3JlIGZsZXhpYmxlIHRvIHBhcnNlIGR0
cyBzYXlpbmcgImNyaXRpY2FsLWNsb2NrcyA9IDx4eHg+Ig0KPiA+ID4gPiA+Pj4+IG9yICJpbml0
LW9uLWFycmFyeT08eHh4PiINCj4gPiA+ID4gPj4+PiBhbmQgZW5hYmxlIHRob3NlIGNsb2Nrcz8N
Cj4gPiA+ID4gPj4+DQo+ID4gPiA+ID4+PiBQYXJzaW5nIHRoZSBjbG9ja3MgYXJyYXlzIGZyb20g
ZHRiIGlzIGFub3RoZXIgd2F5IG9mIGVuYWJsaW5nDQo+ID4gPiA+ID4+PiBjcml0aWNhbCBjbG9j
a3MsIGJ1dCBmb3IgY3VycmVudCBpLk1YNi83IHBsYXRmb3Jtcywgd2UNCj4gPiA+ID4gPj4+IGlt
cGxlbWVudCBpdCBpbiBzYW1lIHdheSBhcyBtb3N0IG9mIG90aGVyIFNvQ3MsIGN1cnJlbnRseSBJ
DQo+ID4gPiA+ID4+PiBkaWQgTk9UIHNlZSBhbnkgbmVjZXNzaXR5IG9mIHB1dHRpbmcgdGhlbSBp
biBkdGIsIGp1c3QgYWRkaW5nDQo+ID4gPiA+ID4+PiBmbGFnIGR1cmluZyBjbG9jayByZWdpc3Rl
cmluZyBpcyBtb3JlIHNpbXBsZSwgaWYgdGhlcmUgaXMgYW55DQo+ID4gPiA+ID4+PiBzcGVjaWFs
IHJlcXVpcmVtZW50IGZvciBkaWZmZXJlbnQgY2xvY2tzIHNldCB0byBiZSBlbmFibGVkLA0KPiA+
ID4gPiA+Pj4gdGhlbiB3ZSBjYW4gYWRkIHN1cHBvcnQgdG8gZW5hYmxlDQo+ID4gPiB0aGUgbWV0
aG9kIG9mIHBhcnNpbmcgY3JpdGljYWwtY2xvY2tzIGZyb20gZHRiLiBKdXN0IG15IHR3byBjZW50
cy4NCj4gPiA+ID4gPj4NCj4gPiA+ID4gPj4gVGhpbmtpbmcgYWJvdXQgT1AtVEVFIHdhbnQgdG8g
dXNlIG9uZSBkZXZpY2UsIGJ1dCBpdCdzIGNsb2Nrcw0KPiA+ID4gPiA+PiBhcmUgcmVnaXN0ZXJl
ZCBieSBMaW51eCwgYmVjYXVzZSB0aGVyZSBpcyBubyBtb2R1bGUgaW4gTGludXgNCj4gPiA+ID4g
Pj4gc2lkZSB1c2UgaXQsIGl0IHdpbGwgc2h1dGRvd24gdGhlIGNsb2NrLCB3aGljaCBjYXVzZSBP
UC1URUUNCj4gPiA+ID4gPj4gY291bGQgbm90IGFjY2VzcyB0aGUNCj4gPiA+IGRldmljZS4NCj4g
PiA+ID4gPj4NCj4gPiA+ID4gPj4gVGhlbiBwZW9wbGUgaGF2ZSB0byBtb2RpZnkgY2xrIGNvZGUg
dG8gYWRkIENMS19JU19DUklUSUNBTCBmbGFnDQo+ID4gPiA+ID4+IHRvIG1ha2Ugc3VyZSB0aGUg
Y2xvY2tzIGFyZSBub3Qgc2h1dGRvd24gYnkgTGludXguDQo+ID4gPiA+ID4+DQo+ID4gPiA+ID4+
IEhvd2V2ZXIgYWRkaW5nIGEgbmV3IHByb3BlcnR5IGluIGNsayBub2RlIGFuZCBsZXQgZHJpdmVy
IGNvZGUNCj4gPiA+ID4gPj4gcGFyc2UgdGhlIGR0cywgdGhlcmUgaXMgbm8gbmVlZCB0byBtb2Rp
ZnkgY2xrIGRyaXZlciBjb2RlIHdoZW4NCj4gPiA+ID4gPj4gT1AtVEVFIG5lZWRzDQo+ID4gPiBh
bm90aGVyIGRldmljZSBjbG9jay4NCj4gPiA+ID4gPj4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IElm
IE9QLVRFRSBuZWVkcyBsaW51eCB0byBrZWVwIHRoaW5ncyBvbiB0aGVuIHdoeSBjYW4ndCB0aGUN
Cj4gPiA+ID4gPiBPUC1URUUgZHJpdmVyIGluIExpbnV4IHByb2JlLCBhY3F1aXJlIGNsb2Nrcywg
YW5kIGtlZXAgdGhlIGNsa3MgZW5hYmxlZA0KPiBmb3JldmVyPw0KPiA+ID4gPg0KPiA+ID4gPiBT
b3VuZHMgcmVhc29uYWJsZSwgYnV0IGhvdyBjb3VsZCB0aGlzIGJlIGRvbmUgd2l0aG91dCBpbnRy
b2R1Y2luZw0KPiA+ID4gPiBwbGF0Zm9ybS1zcGVjaWZpYyBzdHVmZiBpbiB0aGUgT1AtVEVFIGRy
aXZlcj8NCj4gPiA+ID4NCj4gPiA+DQo+ID4gPiBXaHkgaXMgdGhhdCBhIGdvYWw/DQo+ID4NCj4g
PiBJIGRvIE5PVCB0aGluayB3ZSBzaG91bGQgY29uc2lkZXIgc3VjaCBjYXNlIGluIHRoaXMgcGF0
Y2ggc2VyaWVzLA0KPiA+IHdoYXRldmVyIE9QLVRFRSBuZWVkcyBmb3IgaXRzIG93biBmZWF0dXJl
LCBpdCBzaG91bGQgZG8gbmVjZXNzYXJ5IG9wZXJhdGlvbnMNCj4gZWl0aGVyIGluIGl0cyBkcml2
ZXIgb3Igc29tZXdoZXJlIGVsc2UgYnkgYWRkaW5nIG5ldyBwYXRjaC4NCj4gPg0KPiANCj4gV2h5
IGNhbid0IHdlIGFkZCBjbGtzIHRvIHRoZSBvcC10ZWUgbm9kZSBpbiBEVCdzIC9maXJtd2FyZSBj
b250YWluZXI/DQo+IFRoZW4gYW55IGNsa3MgaW4gdGhlcmUgY2FuIGJlIHR1cm5lZCBvbiBmb3Jl
dmVyIGFuZCBsZWZ0IGVuYWJsZWQgYnkgdGhlIGxpbnV4DQo+IGRyaXZlcj8NCiANCkkgZGlkIE5P
VCBydW4gb3AtdGVlIHdpdGggTGludXgtbmV4dCBrZXJuZWwgYmVmb3JlLCBjYW4geW91IGFkdmlz
ZSBtb3JlPyBBbmQgSSB0aGluayBpZiBvcC10ZWUgaGFzIHN1Y2ggcmVxdWlyZW1lbnQsDQpjYW4g
d2UgaGF2ZSBhbm90aGVyIHBhdGNoIHRvIGNvdmVyIGl0PyBJIGJlbGlldmUgYWxsIG90aGVyIGku
TVggcGxhdGZvcm1zIGFsc28gaGF2ZSBzYW1lDQpyZXF1aXJlbWVudHMgaWYgY29uc2lkZXJpbmcg
b3AtdGVlIHN1cHBvcnQsIHNvIEkgdGhpbmsgaXQgc2hvdWxkIGJlIGFub3RoZXIgdG9waWMsIHdo
YXQgZG8geW91IHRoaW5rPw0KDQpBbnNvbi4gDQoNCg0K
