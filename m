Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24227C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD02B20837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BRQmCwl2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD02B20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbeHaFp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 01:45:28 -0400
Received: from mail-he1eur01on0084.outbound.protection.outlook.com ([104.47.0.84]:36313
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725807AbeHaFp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 01:45:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bML717jiZ/Vlg30KooxiIKu6JxuZgwhq0+BEPavrJ8=;
 b=BRQmCwl2VWt9QLqvidl9IVkbelGsmGvVmjw1Nl6VMr9EwPH85fpdP/9d0kKDPI75HRs3fuCKi4ai+CptS8IfVX3IMDrxStOVs/psaP2aML7LIdnrNKBrpGDEgiikDE48SuZNHSuOPI0ySHbgOBLojs9HjNPemhxMRKw9BI9S53M=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.71.159) by
 DB3PR0402MB3769.eurprd04.prod.outlook.com (52.134.71.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.16; Fri, 31 Aug 2018 01:40:21 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::c0c1:51f1:411f:f13c]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::c0c1:51f1:411f:f13c%3]) with mapi id 15.20.1080.015; Fri, 31 Aug 2018
 01:40:21 +0000
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
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 2/2] clk: imx: imx7d: remove clks_init_on array
Thread-Topic: [PATCH 2/2] clk: imx: imx7d: remove clks_init_on array
Thread-Index: AQHULtJmBbQCL7E8lECcVaukjbrAoqS1i6SAgAAAVtCAB1yugIAcTbiAgAABaNA=
Date:   Fri, 31 Aug 2018 01:40:21 +0000
Message-ID: <DB3PR0402MB3916D437C4BB42A612CE5A19F50F0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1533703167-26583-1-git-send-email-Anson.Huang@nxp.com>
 <1533703167-26583-2-git-send-email-Anson.Huang@nxp.com>
 <AM0PR04MB4481FC2BAD71B75D7BE84C0788260@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916F8BC381BBA01DB21D1C0F5260@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <AM0PR04MB44813C7A3E0AF4F3BCFFCF0088390@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <153567894721.93865.4092113232222931488@swboyd.mtv.corp.google.com>
In-Reply-To: <153567894721.93865.4092113232222931488@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3769;6:dq4YQ7x7jQ7WeSKJpTBseMoRalKPmHVM+9UcU+HpSoh8gkTeD317L2aa7gv7qJjLvXTkjXuUvdwhCtWytZbuazgJ2UhiSXvy32HEtc/3lhBhZSn91QbqVHgeYHkMnspYT6v3OdOSjT77eC9rzo9N6MCxyaElv4/lGJkqCiM5rk70pAXBI9iARF/vwHB/demmAB0OdGWOEA1UqrB1j3zJ6KPiz9tu/dsGu/5VxEldTfDPKuc/ftlYUcO98KFaKMwdItCwLhoymSI8OUhphS87i6g9jW9O5kJ/pDhEAGc+V86lZDcQcufToPFVUlK1ismUd8GJURHdM2U3dl8MM63kYO/zOeD1AGwL8hjQobCGdqM+PDN4cwehCJpyDF7uC9GKhtNwSMYU15gLyFv3s4P688E5s3a1zZbsFzO3oWWRx41LZLwxQZbw2OPwdfUZljLOMT9EOekPZICqQoKqHiwSxg==;5:miHCQBeXBh3ctdngqxWKBU0V3P90m7di1+QK3fq+borCBZr43F6qOlpjipoGl7mYm5WVhOEwDu5/2zFifpHMs+o55fcQnwD1aFU8HOzNSTsDqhgcJtLx4rwV7XqZtB5AMGjrdcpum5gSeQYg7/kU5GimfrjGvtATWr/2I1Ljlto=;7:l3urpEgT6hZyXmdXOevtt2XNcSQCIKK/4shBhMXvZ1r7szwOVvTQgb+FqizBofKPMQ65pbdgfYI+I+VElcvMdXWjM6nVl0Xx+eFmV5T6dxT156A+J6USIoB2NKr29nR4VxFIQlAscMShJv0W6z17wnag7MpfcOBLOzjyDiP7MakklUcwaT9j1xcrBNdWK0o/WVwUieEhgxW3ufWky5MQy/rKeNX/e1wooSFpExs/NYP1nleFD2x4A1qo4/eQIFQq
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 6fdeb569-f64b-4a71-3f6a-08d60ee2b6da
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3769;
x-ms-traffictypediagnostic: DB3PR0402MB3769:
x-microsoft-antispam-prvs: <DB3PR0402MB3769D6BF1A30E5EDB6C1D4F5F50F0@DB3PR0402MB3769.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699016);SRVR:DB3PR0402MB3769;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3769;
x-forefront-prvs: 07817FCC2D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(376002)(346002)(396003)(39860400002)(199004)(189003)(13464003)(305945005)(14444005)(256004)(102836004)(2501003)(5250100002)(6506007)(106356001)(33656002)(53546011)(97736004)(4326008)(6246003)(105586002)(81166006)(81156014)(478600001)(6116002)(25786009)(3846002)(14454004)(7736002)(74316002)(6436002)(8676002)(99286004)(66066001)(9686003)(486006)(316002)(55016002)(93886005)(44832011)(8936002)(11346002)(446003)(476003)(186003)(110136005)(5660300001)(7696005)(76176011)(26005)(86362001)(2201001)(229853002)(2906002)(68736007)(2900100001)(53936002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3769;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: pkwOvJ8guX5pvP1JP7BntG7JGl/aUCkBdd24i1rqxcNtJjwsavFHzaHcNJArhgm8rOmiPslaev1teIhp6wUUS0/Qh7mEi5sNZ+nJ5hfLFVOwYTa4zHneVyFEbdGp1hlNDRSwRQSQa68JNZuFGHdzvVxKRFoxis19qL6j2iDe7QKNvJdoYbLAYunbBk/qQ5wLLDM2t5ScV1k6gRPjIjFL8vqCbj7zBDyN3N0iWjPtOP8Ydgr9o2C0rUL85c20nS/SbacxvIfQ+7bSzp7H8xu8+3UatdS635BLQsnkgsI7tXJ34MvwI8VWHYlXOQeIJI9G2Sqt10w08MrtyqhVLRTJfTTDpZ83rA3OxPA272eeb8k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fdeb569-f64b-4a71-3f6a-08d60ee2b6da
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2018 01:40:21.2167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3769
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFN0ZXBoZW4NCg0KQW5zb24gSHVhbmcNCkJlc3QgUmVnYXJkcyENCg0KDQo+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFN0ZXBoZW4gQm95ZCA8c2JveWRAa2VybmVsLm9y
Zz4NCj4gU2VudDogRnJpZGF5LCBBdWd1c3QgMzEsIDIwMTggOToyOSBBTQ0KPiBUbzoga2VybmVs
QHBlbmd1dHJvbml4LmRlOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+
IGxpbnV4LWNsa0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
DQo+IG10dXJxdWV0dGVAYmF5bGlicmUuY29tOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBzaGF3
bmd1b0BrZXJuZWwub3JnOw0KPiBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT47IEZh
YmlvIEVzdGV2YW0NCj4gPGZhYmlvLmVzdGV2YW1AbnhwLmNvbT47IFBlbmcgRmFuIDxwZW5nLmZh
bkBueHAuY29tPjsgUm9iIEhlcnJpbmcNCj4gPHJvYmhAa2VybmVsLm9yZz4NCj4gQ2M6IGRsLWxp
bnV4LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggMi8yXSBj
bGs6IGlteDogaW14N2Q6IHJlbW92ZSBjbGtzX2luaXRfb24gYXJyYXkNCj4gDQo+IFF1b3Rpbmcg
UGVuZyBGYW4gKDIwMTgtMDgtMTIgMTg6MTU6NDEpDQo+ID4gSGkgQW5zb24sDQo+ID4NCj4gPiA+
ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gPiA+IEZyb206IEFuc29uIEh1
YW5nDQo+ID4gPiA+ID4gU2VudDogMjAxOOW5tDjmnIg45pelIDEyOjM5DQo+ID4gPiA+ID4gVG86
IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7DQo+ID4gPiA+ID4g
a2VybmVsQHBlbmd1dHJvbml4LmRlOyBGYWJpbyBFc3RldmFtIDxmYWJpby5lc3RldmFtQG54cC5j
b20+Ow0KPiA+ID4gPiA+IG10dXJxdWV0dGVAYmF5bGlicmUuY29tOyBzYm95ZEBrZXJuZWwub3Jn
Ow0KPiA+ID4gPiA+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gPiA+
ID4gPiBsaW51eC1jbGtAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnDQo+ID4gPiA+ID4gQ2M6IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+ID4g
PiA+ID4gU3ViamVjdDogW1BBVENIIDIvMl0gY2xrOiBpbXg6IGlteDdkOiByZW1vdmUgY2xrc19p
bml0X29uIGFycmF5DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBDbG9jayBmcmFtZXdvcmsgd2lsbCBl
bmFibGUgdGhvc2UgY2xvY2tzIHJlZ2lzdGVyZWQgd2l0aA0KPiA+ID4gPiA+IENMS19JU19DUklU
SUNBTCBmbGFnLCBzbyBubyBuZWVkIHRvIGhhdmUgY2xrc19pbml0X29uIGFycmF5DQo+ID4gPiA+
ID4gZHVyaW5nIGNsb2NrDQo+ID4gPiA+IGluaXRpYWxpemF0aW9uIG5vdy4NCj4gPiA+ID4NCj4g
PiA+ID4gV2lsbCBpdCBiZSBtb3JlIGZsZXhpYmxlIHRvIHBhcnNlIGR0cyBzYXlpbmcgImNyaXRp
Y2FsLWNsb2NrcyA9IDx4eHg+Ig0KPiA+ID4gPiBvciAiaW5pdC1vbi1hcnJhcnk9PHh4eD4iDQo+
ID4gPiA+IGFuZCBlbmFibGUgdGhvc2UgY2xvY2tzPw0KPiA+ID4NCj4gPiA+IFBhcnNpbmcgdGhl
IGNsb2NrcyBhcnJheXMgZnJvbSBkdGIgaXMgYW5vdGhlciB3YXkgb2YgZW5hYmxpbmcNCj4gPiA+
IGNyaXRpY2FsIGNsb2NrcywgYnV0IGZvciBjdXJyZW50IGkuTVg2LzcgcGxhdGZvcm1zLCB3ZSBp
bXBsZW1lbnQgaXQNCj4gPiA+IGluIHNhbWUgd2F5IGFzIG1vc3Qgb2Ygb3RoZXIgU29DcywgY3Vy
cmVudGx5IEkgZGlkIE5PVCBzZWUgYW55DQo+ID4gPiBuZWNlc3NpdHkgb2YgcHV0dGluZyB0aGVt
IGluIGR0YiwganVzdCBhZGRpbmcgZmxhZyBkdXJpbmcgY2xvY2sNCj4gPiA+IHJlZ2lzdGVyaW5n
IGlzIG1vcmUgc2ltcGxlLCBpZiB0aGVyZSBpcyBhbnkgc3BlY2lhbCByZXF1aXJlbWVudCBmb3IN
Cj4gPiA+IGRpZmZlcmVudCBjbG9ja3Mgc2V0IHRvIGJlIGVuYWJsZWQsIHRoZW4gd2UgY2FuIGFk
ZCBzdXBwb3J0IHRvIGVuYWJsZSB0aGUNCj4gbWV0aG9kIG9mIHBhcnNpbmcgY3JpdGljYWwtY2xv
Y2tzIGZyb20gZHRiLiBKdXN0IG15IHR3byBjZW50cy4NCj4gPg0KPiA+IFRoaW5raW5nIGFib3V0
IE9QLVRFRSB3YW50IHRvIHVzZSBvbmUgZGV2aWNlLCBidXQgaXQncyBjbG9ja3MgYXJlDQo+ID4g
cmVnaXN0ZXJlZCBieSBMaW51eCwgYmVjYXVzZSB0aGVyZSBpcyBubyBtb2R1bGUgaW4gTGludXgg
c2lkZSB1c2UgaXQsDQo+ID4gaXQgd2lsbCBzaHV0ZG93biB0aGUgY2xvY2ssIHdoaWNoIGNhdXNl
IE9QLVRFRSBjb3VsZCBub3QgYWNjZXNzIHRoZSBkZXZpY2UuDQo+ID4NCj4gPiBUaGVuIHBlb3Bs
ZSBoYXZlIHRvIG1vZGlmeSBjbGsgY29kZSB0byBhZGQgQ0xLX0lTX0NSSVRJQ0FMIGZsYWcgdG8N
Cj4gPiBtYWtlIHN1cmUgdGhlIGNsb2NrcyBhcmUgbm90IHNodXRkb3duIGJ5IExpbnV4Lg0KPiA+
DQo+ID4gSG93ZXZlciBhZGRpbmcgYSBuZXcgcHJvcGVydHkgaW4gY2xrIG5vZGUgYW5kIGxldCBk
cml2ZXIgY29kZSBwYXJzZQ0KPiA+IHRoZSBkdHMsIHRoZXJlIGlzIG5vIG5lZWQgdG8gbW9kaWZ5
IGNsayBkcml2ZXIgY29kZSB3aGVuIE9QLVRFRSBuZWVkcw0KPiBhbm90aGVyIGRldmljZSBjbG9j
ay4NCj4gPg0KPiANCj4gSWYgT1AtVEVFIG5lZWRzIGxpbnV4IHRvIGtlZXAgdGhpbmdzIG9uIHRo
ZW4gd2h5IGNhbid0IHRoZSBPUC1URUUgZHJpdmVyIGluDQo+IExpbnV4IHByb2JlLCBhY3F1aXJl
IGNsb2NrcywgYW5kIGtlZXAgdGhlIGNsa3MgZW5hYmxlZCBmb3JldmVyPw0KIA0KWWVzLCBJIGFn
cmVlIHdpdGggeW91LCBPUC1URUUgc2hvdWxkIG1haW50YWluIGl0cyBjbG9ja3Mgd2hlbiBPUC1U
RUUgaXMgZW5hYmxlZC4NCg0KVGhpcyBpcyBPTkxZIGEgY29uY2VybiByYWlzZWQgYnkgUGVuZywg
YWxsIHBsYXRmb3JtcycgY3VycmVudCBjbG9jayBkcml2ZXIgZG9lcyBOT1QgY29uc2lkZXINCnRo
aXMgY2FzZSwgc28gSSB0aGluayB0aGlzIHBhdGNoIHNob3VsZCBiZSBmaW5lIGZvciBub3c/IFRo
YW5rcy4NCg0KQW5zb24uDQoNCg0K
