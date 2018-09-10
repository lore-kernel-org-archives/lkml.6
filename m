Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC81C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24903204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pwiPOWvs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24903204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbeIJOMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 10:12:15 -0400
Received: from mail-eopbgr70057.outbound.protection.outlook.com ([40.107.7.57]:6784
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726081AbeIJOMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 10:12:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IgcKfnStt4+Uh4aoN9Q5jYj9gYramootF71a6GoS8Gc=;
 b=pwiPOWvsxEXXtR1fNdcqoo9SrhWoFAaCp98yxYu7pHZBw0mP2GsfUmaVuS18q3xf+fAeSDbwLph420i19G2MVZmyyiwfhw8Hzb4qL59d6JPCFQD89NbUzBu/H2CTGYto8i5Z5Kks1wiurqeV6VsTm609JPDbFdb9aIaLfeuTaso=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.71.159) by
 DB3PR0402MB3690.eurprd04.prod.outlook.com (52.134.70.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.18; Mon, 10 Sep 2018 09:18:35 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1c65:743b:56d0:5aa2]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1c65:743b:56d0:5aa2%5]) with mapi id 15.20.1122.019; Mon, 10 Sep 2018
 09:18:35 +0000
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
Thread-Index: AQHULtJmBbQCL7E8lECcVaukjbrAoqS1i6SAgAAAVtCAB1yugIAcTbiAgABtsgCAAKaTAIAEBEiQgAshjiA=
Date:   Mon, 10 Sep 2018 09:18:35 +0000
Message-ID: <DB3PR0402MB391656D3F0C5E7AC1975064CF5050@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1533703167-26583-1-git-send-email-Anson.Huang@nxp.com>
 <1533703167-26583-2-git-send-email-Anson.Huang@nxp.com>
 <AM0PR04MB4481FC2BAD71B75D7BE84C0788260@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916F8BC381BBA01DB21D1C0F5260@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <AM0PR04MB44813C7A3E0AF4F3BCFFCF0088390@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <153567894721.93865.4092113232222931488@swboyd.mtv.corp.google.com>
 <a6489bda-703f-207c-0b24-60f4044fe89f@linaro.org>
 <153573827629.93865.6200966443862432044@swboyd.mtv.corp.google.com>
 <AM6PR0402MB391120110A289BA5FB6B9F0DF50C0@AM6PR0402MB3911.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR0402MB391120110A289BA5FB6B9F0DF50C0@AM6PR0402MB3911.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3690;6:aWMfoQEmGV7Je63UWgm+dkvIFxW5xBEfuQam+d1DE6xkM2mUQrcucyryMaBuJbilIeEHOI/3ZFcer7wFn2vI8ay0ePpmpX3NCDQxkZZZOFWMbvUb5DsUqFnftFJDHzgP7oGByDltpOUcPtGOOvdkWAdBDjHwr3Q231puieJFfwIWPIfmrS73dQtdCA3XrmubPynaozQ4fARUDRy0yi4JroUWzvkUJRsxahKVjEMdUvHF6EmkEeTcUoyHnanjWwHwaQRSWV/41nOwTxYqoDjNLYzmYc/MnB2i49fRDroNcj7eL3wly/ZclPqLKvexBN8q7kTeJbkwkaN4MzX2l2EzW5lInpPiEijRZGSS+/CyDBcIUMmNiMU86JvihGp82DiN9L403WSPs5SjLLaMnv8+QGj3MQQtJwej8dgNrl653aSwngNhi78oR68l0gP0jpouRYwaSg/Ujdgp1roAf4OAcA==;5:s5P40teNzrCl3NlkXs/5n+miZws+4z33pEGmdyHCueanCgT38EXCOPRQCF7eCC/SHjME3yKw+rGojCRQTrJvNtgsT5kTojO+qOwjVXXpqTJlYfJEMy5u978e0q/aHJ5yP5OlAZ58N47EFf+c8Iu1WWKGzqMazw91RqPyM/lPbEg=;7:oGaJFlt1aQ7CX8lMos756OkrgnUCr0oQp3RUMu2ztWiVsM1D1ysa3D0H7rFPfa4i+sTlGfzm0Dw24XYgsPM66CIUdbHOvyUBIRxcbBwGJe3z1TLrpVGYzs2vBOmLF74ofZtnAbZrKMKgKmHe1RmxhdsVdbyCUZEEyoU50uqLRU9xkKYnFOVOApYe88Lprj+PdMk7h2VwzHkAfI3oqnNVuH6PGjdEqoT9uzZMin+rKjNPICqz8C4cb14mYjlp//Jw
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 93a7a65d-d114-4729-590b-08d616fe630c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3690;
x-ms-traffictypediagnostic: DB3PR0402MB3690:
x-microsoft-antispam-prvs: <DB3PR0402MB369089328B81CBA184E05B88F5050@DB3PR0402MB3690.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699050);SRVR:DB3PR0402MB3690;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3690;
x-forefront-prvs: 07915F544A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(366004)(396003)(136003)(13464003)(199004)(189003)(26005)(33656002)(256004)(229853002)(14444005)(6246003)(66066001)(8676002)(74316002)(25786009)(7696005)(5660300001)(81156014)(4326008)(186003)(93886005)(110136005)(102836004)(6506007)(53546011)(2900100001)(105586002)(7736002)(305945005)(99286004)(316002)(106356001)(446003)(2201001)(68736007)(6436002)(86362001)(97736004)(486006)(44832011)(5250100002)(55016002)(11346002)(53936002)(476003)(2501003)(478600001)(9686003)(3846002)(7416002)(76176011)(8936002)(2906002)(81166006)(14454004)(6116002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3690;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: IrJJrIblxibrBqtpbOnxcEsl2fEhYb9N1upcgZJGz1A+30MxRJ337xJITL4CnERn9m1k3DfT6UEKEgNyM6anig4okQ1oT0NyrRWdeTZNQCSTzI3MkCmTH2kTaKAtB2u+RJ+6uTZijWhRojRwVvJJ0Q919hXpQ471c9IVb6UqbO0n/Fr5qPglO1L5+aEZNGJ9l+mEMfghBXEducoZpkxaesgNLnGke4AgEQR/KV+cF3Ks8vZty51X2Kqs08gJ6LT7s4X3qfFH2uqcyiD2lwb9J8IEkocSMq3GulzIqxgUOwKiaG+y1r+0qeZBzOa5J+2wCXzLC/C/r/T/2S/oUS3aZ5R+zXZBlPqmuVWtFaNanto=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93a7a65d-d114-4729-590b-08d616fe630c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2018 09:18:35.6480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3690
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R2VudGxlIFBpbmcuLi4NCg0KQW5zb24gSHVhbmcNCkJlc3QgUmVnYXJkcyENCg0KDQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFuc29uIEh1YW5nDQo+IFNlbnQ6IE1vbmRh
eSwgU2VwdGVtYmVyIDMsIDIwMTggMzoyMSBQTQ0KPiBUbzogU3RlcGhlbiBCb3lkIDxzYm95ZEBr
ZXJuZWwub3JnPjsga2VybmVsQHBlbmd1dHJvbml4LmRlOw0KPiBsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWNsa0B2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7IG10dXJxdWV0dGVAYmF5bGlicmUuY29tOw0KPiBzLmhhdWVy
QHBlbmd1dHJvbml4LmRlOyBzaGF3bmd1b0BrZXJuZWwub3JnOyBGYWJpbyBFc3RldmFtDQo+IDxm
YWJpby5lc3RldmFtQG54cC5jb20+OyBKZXJvbWUgRm9yaXNzaWVyIDxqZXJvbWUuZm9yaXNzaWVy
QGxpbmFyby5vcmc+Ow0KPiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT47IFJvYiBIZXJyaW5n
IDxyb2JoQGtlcm5lbC5vcmc+DQo+IENjOiBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29t
Pg0KPiBTdWJqZWN0OiBSRTogW1BBVENIIDIvMl0gY2xrOiBpbXg6IGlteDdkOiByZW1vdmUgY2xr
c19pbml0X29uIGFycmF5DQo+IA0KPiANCj4gDQo+IEFuc29uIEh1YW5nDQo+IEJlc3QgUmVnYXJk
cyENCj4gDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogU3Rl
cGhlbiBCb3lkIDxzYm95ZEBrZXJuZWwub3JnPg0KPiA+IFNlbnQ6IFNhdHVyZGF5LCBTZXB0ZW1i
ZXIgMSwgMjAxOCAxOjU4IEFNDQo+ID4gVG86IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiA+IGxpbnV4LWNsa0B2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gbXR1cnF1ZXR0ZUBiYXls
aWJyZS5jb207IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7DQo+IHNoYXduZ3VvQGtlcm5lbC5vcmc7
DQo+ID4gQW5zb24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5jb20+OyBGYWJpbyBFc3RldmFtDQo+
ID4gPGZhYmlvLmVzdGV2YW1AbnhwLmNvbT47IEplcm9tZSBGb3Jpc3NpZXINCj4gPiA8amVyb21l
LmZvcmlzc2llckBsaW5hcm8ub3JnPjsgUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+OyBSb2IN
Cj4gPiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQo+ID4gQ2M6IGRsLWxpbnV4LWlteCA8bGlu
dXgtaW14QG54cC5jb20+DQo+ID4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzJdIGNsazogaW14OiBp
bXg3ZDogcmVtb3ZlIGNsa3NfaW5pdF9vbiBhcnJheQ0KPiA+DQo+ID4gUXVvdGluZyBKZXJvbWUg
Rm9yaXNzaWVyICgyMDE4LTA4LTMxIDAxOjAxOjQ0KQ0KPiA+ID4NCj4gPiA+DQo+ID4gPiBPbiAw
OC8zMS8yMDE4IDAzOjI5IEFNLCBTdGVwaGVuIEJveWQgd3JvdGU6DQo+ID4gPiA+IFF1b3Rpbmcg
UGVuZyBGYW4gKDIwMTgtMDgtMTIgMTg6MTU6NDEpDQo+ID4gPiA+PiBIaSBBbnNvbiwNCj4gPiA+
ID4+DQo+ID4gPiA+Pj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gPj4+Pj4g
RnJvbTogQW5zb24gSHVhbmcNCj4gPiA+ID4+Pj4+IFNlbnQ6IDIwMTjlubQ45pyIOOaXpSAxMjoz
OQ0KPiA+ID4gPj4+Pj4gVG86IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9u
aXguZGU7DQo+ID4gPiA+Pj4+PiBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IEZhYmlvIEVzdGV2YW0g
PGZhYmlvLmVzdGV2YW1AbnhwLmNvbT47DQo+ID4gPiA+Pj4+PiBtdHVycXVldHRlQGJheWxpYnJl
LmNvbTsgc2JveWRAa2VybmVsLm9yZzsNCj4gPiA+ID4+Pj4+IGxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZzsNCj4gPiA+ID4+Pj4+IGxpbnV4LWNsa0B2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPiA+ID4+Pj4+IENjOiBkbC1saW51eC1p
bXggPGxpbnV4LWlteEBueHAuY29tPg0KPiA+ID4gPj4+Pj4gU3ViamVjdDogW1BBVENIIDIvMl0g
Y2xrOiBpbXg6IGlteDdkOiByZW1vdmUgY2xrc19pbml0X29uDQo+ID4gPiA+Pj4+PiBhcnJheQ0K
PiA+ID4gPj4+Pj4NCj4gPiA+ID4+Pj4+IENsb2NrIGZyYW1ld29yayB3aWxsIGVuYWJsZSB0aG9z
ZSBjbG9ja3MgcmVnaXN0ZXJlZCB3aXRoDQo+ID4gPiA+Pj4+PiBDTEtfSVNfQ1JJVElDQUwgZmxh
Zywgc28gbm8gbmVlZCB0byBoYXZlIGNsa3NfaW5pdF9vbiBhcnJheQ0KPiA+ID4gPj4+Pj4gZHVy
aW5nIGNsb2NrDQo+ID4gPiA+Pj4+IGluaXRpYWxpemF0aW9uIG5vdy4NCj4gPiA+ID4+Pj4NCj4g
PiA+ID4+Pj4gV2lsbCBpdCBiZSBtb3JlIGZsZXhpYmxlIHRvIHBhcnNlIGR0cyBzYXlpbmcgImNy
aXRpY2FsLWNsb2NrcyA9IDx4eHg+Ig0KPiA+ID4gPj4+PiBvciAiaW5pdC1vbi1hcnJhcnk9PHh4
eD4iDQo+ID4gPiA+Pj4+IGFuZCBlbmFibGUgdGhvc2UgY2xvY2tzPw0KPiA+ID4gPj4+DQo+ID4g
PiA+Pj4gUGFyc2luZyB0aGUgY2xvY2tzIGFycmF5cyBmcm9tIGR0YiBpcyBhbm90aGVyIHdheSBv
ZiBlbmFibGluZw0KPiA+ID4gPj4+IGNyaXRpY2FsIGNsb2NrcywgYnV0IGZvciBjdXJyZW50IGku
TVg2LzcgcGxhdGZvcm1zLCB3ZSBpbXBsZW1lbnQNCj4gPiA+ID4+PiBpdCBpbiBzYW1lIHdheSBh
cyBtb3N0IG9mIG90aGVyIFNvQ3MsIGN1cnJlbnRseSBJIGRpZCBOT1Qgc2VlDQo+ID4gPiA+Pj4g
YW55IG5lY2Vzc2l0eSBvZiBwdXR0aW5nIHRoZW0gaW4gZHRiLCBqdXN0IGFkZGluZyBmbGFnIGR1
cmluZw0KPiA+ID4gPj4+IGNsb2NrIHJlZ2lzdGVyaW5nIGlzIG1vcmUgc2ltcGxlLCBpZiB0aGVy
ZSBpcyBhbnkgc3BlY2lhbA0KPiA+ID4gPj4+IHJlcXVpcmVtZW50IGZvciBkaWZmZXJlbnQgY2xv
Y2tzIHNldCB0byBiZSBlbmFibGVkLCB0aGVuIHdlIGNhbg0KPiA+ID4gPj4+IGFkZCBzdXBwb3J0
IHRvIGVuYWJsZQ0KPiA+IHRoZSBtZXRob2Qgb2YgcGFyc2luZyBjcml0aWNhbC1jbG9ja3MgZnJv
bSBkdGIuIEp1c3QgbXkgdHdvIGNlbnRzLg0KPiA+ID4gPj4NCj4gPiA+ID4+IFRoaW5raW5nIGFi
b3V0IE9QLVRFRSB3YW50IHRvIHVzZSBvbmUgZGV2aWNlLCBidXQgaXQncyBjbG9ja3MgYXJlDQo+
ID4gPiA+PiByZWdpc3RlcmVkIGJ5IExpbnV4LCBiZWNhdXNlIHRoZXJlIGlzIG5vIG1vZHVsZSBp
biBMaW51eCBzaWRlIHVzZQ0KPiA+ID4gPj4gaXQsIGl0IHdpbGwgc2h1dGRvd24gdGhlIGNsb2Nr
LCB3aGljaCBjYXVzZSBPUC1URUUgY291bGQgbm90DQo+ID4gPiA+PiBhY2Nlc3MgdGhlDQo+ID4g
ZGV2aWNlLg0KPiA+ID4gPj4NCj4gPiA+ID4+IFRoZW4gcGVvcGxlIGhhdmUgdG8gbW9kaWZ5IGNs
ayBjb2RlIHRvIGFkZCBDTEtfSVNfQ1JJVElDQUwgZmxhZw0KPiA+ID4gPj4gdG8gbWFrZSBzdXJl
IHRoZSBjbG9ja3MgYXJlIG5vdCBzaHV0ZG93biBieSBMaW51eC4NCj4gPiA+ID4+DQo+ID4gPiA+
PiBIb3dldmVyIGFkZGluZyBhIG5ldyBwcm9wZXJ0eSBpbiBjbGsgbm9kZSBhbmQgbGV0IGRyaXZl
ciBjb2RlDQo+ID4gPiA+PiBwYXJzZSB0aGUgZHRzLCB0aGVyZSBpcyBubyBuZWVkIHRvIG1vZGlm
eSBjbGsgZHJpdmVyIGNvZGUgd2hlbg0KPiA+ID4gPj4gT1AtVEVFIG5lZWRzDQo+ID4gYW5vdGhl
ciBkZXZpY2UgY2xvY2suDQo+ID4gPiA+Pg0KPiA+ID4gPg0KPiA+ID4gPiBJZiBPUC1URUUgbmVl
ZHMgbGludXggdG8ga2VlcCB0aGluZ3Mgb24gdGhlbiB3aHkgY2FuJ3QgdGhlIE9QLVRFRQ0KPiA+
ID4gPiBkcml2ZXIgaW4gTGludXggcHJvYmUsIGFjcXVpcmUgY2xvY2tzLCBhbmQga2VlcCB0aGUg
Y2xrcyBlbmFibGVkIGZvcmV2ZXI/DQo+ID4gPg0KPiA+ID4gU291bmRzIHJlYXNvbmFibGUsIGJ1
dCBob3cgY291bGQgdGhpcyBiZSBkb25lIHdpdGhvdXQgaW50cm9kdWNpbmcNCj4gPiA+IHBsYXRm
b3JtLXNwZWNpZmljIHN0dWZmIGluIHRoZSBPUC1URUUgZHJpdmVyPw0KPiA+ID4NCj4gPg0KPiA+
IFdoeSBpcyB0aGF0IGEgZ29hbD8NCj4gDQo+IEkgZG8gTk9UIHRoaW5rIHdlIHNob3VsZCBjb25z
aWRlciBzdWNoIGNhc2UgaW4gdGhpcyBwYXRjaCBzZXJpZXMsIHdoYXRldmVyDQo+IE9QLVRFRSBu
ZWVkcyBmb3IgaXRzIG93biBmZWF0dXJlLCBpdCBzaG91bGQgZG8gbmVjZXNzYXJ5IG9wZXJhdGlv
bnMgZWl0aGVyIGluIGl0cw0KPiBkcml2ZXIgb3Igc29tZXdoZXJlIGVsc2UgYnkgYWRkaW5nIG5l
dyBwYXRjaC4NCj4gDQo+IEFuc29uLg0KDQo=
