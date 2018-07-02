Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4C7C6778D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 00:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 285B6255F8
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 00:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Xuf4gwW4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 285B6255F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932318AbeGBA5o (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 20:57:44 -0400
Received: from mail-eopbgr20082.outbound.protection.outlook.com ([40.107.2.82]:36452
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752739AbeGBA5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 20:57:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfXwJpTdSr/JoiFPE7i//1dFpUgva4VaXinON0Ho9QA=;
 b=Xuf4gwW4XJ221Pz6ugndVTyysuBs5FUYicJVveIMVbVtjza/5hsMhBxGFaC8p2vvJQjZRqLxmC6esuCCcezR+EUaVy8HijUdWRP82r+7eztW7xXols3CYVNNy38XBb5eclkcRAHyyNWHAuMQavMRTDQ/MDS+qHYVKvFJ2I0qZ88=
Received: from AM3PR04MB1315.eurprd04.prod.outlook.com (10.163.7.13) by
 AM3PR04MB1395.eurprd04.prod.outlook.com (10.163.185.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.20; Mon, 2 Jul 2018 00:57:33 +0000
Received: from AM3PR04MB1315.eurprd04.prod.outlook.com
 ([fe80::a024:25ab:f457:64c7]) by AM3PR04MB1315.eurprd04.prod.outlook.com
 ([fe80::a024:25ab:f457:64c7%7]) with mapi id 15.20.0906.026; Mon, 2 Jul 2018
 00:57:33 +0000
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
Thread-Index: AQHUDD3lRelNZaT6s0KCSbdeyjhmZKR6JNEAgADqWICAABYs4IAAAL2AgAAAQsA=
Date:   Mon, 2 Jul 2018 00:57:32 +0000
Message-ID: <AM3PR04MB1315E7AED2BCE2265E6C443DF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1529930051-14122-1-git-send-email-yibin.gong@nxp.com>
 <20180701093402.GN4348@dragon>
 <CAOMZO5BjOEGWv2dC-bp0BYHq+PhLssEKic+o7ock8_1Dobd=sQ@mail.gmail.com>
 <AM3PR04MB131507901BFEE1A5E426EECBF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5D8tjnjbwMdLGd7KF7_4PwqRWX8XH8kdcF3-5e-r2YQEA@mail.gmail.com>
In-Reply-To: <CAOMZO5D8tjnjbwMdLGd7KF7_4PwqRWX8XH8kdcF3-5e-r2YQEA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB1395;7:oD9pSxOMopEDPEilaE3gPfiuyfMF4I+fiedCLhcrRAR1oW4cFhfdU3LGmBjocCOXiHqVROcfbjfIJF7TEooPdhBBw2Ue7pOVkJCv/X+XASgJqZ5gOyZ+Y3c8S8B2Dj+E0ntNWjsVCyJ+K8QWLqDgGFHUshx9IHBIcvwCxzfBBEqXDXhnoyIy2q01RqsQlCURoI6SjmHPgMt5Qtnjr/lzKqxNYFiYw2gIC7fwiexqL/ermdhhmv+b7Y3YwOoCXH6+
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 4604febd-158a-4be2-c9e2-08d5dfb6cb56
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1395;
x-ms-traffictypediagnostic: AM3PR04MB1395:
x-microsoft-antispam-prvs: <AM3PR04MB1395BD21FB2CBA541B948B4BF5430@AM3PR04MB1395.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(85827821059158)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB1395;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1395;
x-forefront-prvs: 07215D0470
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(346002)(376002)(366004)(199004)(189003)(13464003)(2900100001)(44832011)(4326008)(39060400002)(14444005)(486006)(6436002)(476003)(53546011)(6246003)(7696005)(97736004)(55016002)(9686003)(446003)(76176011)(6506007)(11346002)(229853002)(256004)(1411001)(2906002)(14454004)(25786009)(6116002)(33656002)(305945005)(53936002)(54906003)(105586002)(8676002)(316002)(8936002)(74316002)(3846002)(7736002)(106356001)(68736007)(66066001)(26005)(86362001)(478600001)(5250100002)(81166006)(99286004)(186003)(102836004)(5660300001)(6916009)(81156014)(93886005)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1395;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: pxl3Bkca4+zxUWCGKb5CZwGiT9eDd5Qii18Ig37F/h5X7CluqcUxG9UyFuSWCCTHpkef30OJ9HINsugeqFegwktYShfCqUlhAB5gd33gMOaCgeqPFi8TwydCggvmpCPtgWRZVNxlZNM9OktpJGKUHvkEerjq9lY6xk/R4RBaNpgOjX+eo0dwxqsbP0wRY/XkaxihsC12FJbjoE2I4ucwhWF7ukCfkk/brFGqWvo4XzpDS1wIqTS/9h/6UFiHCt0L9ympBQPpgiTEjwXOA0KSKoczxNbFV4ImG+Z3EXFps6OLS+Xsapj1fKp6RB+QwSkqpkAhm0AcbqDzMsh6A/cO7tRY8AU5l9iYimBbfWYtaZU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4604febd-158a-4be2-c9e2-08d5dfb6cb56
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2018 00:57:33.0076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1395
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEZhYmlvDQoNCkFuc29uIEh1YW5nDQpCZXN0IFJlZ2FyZHMhDQoNCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGYWJpbyBFc3RldmFtIFttYWlsdG86ZmVzdGV2YW1A
Z21haWwuY29tXQ0KPiBTZW50OiBNb25kYXksIEp1bHkgMiwgMjAxOCA4OjU1IEFNDQo+IFRvOiBB
bnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4gQ2M6IFNoYXduIEd1byA8c2hhd25n
dW9Aa2VybmVsLm9yZz47IFJvYmluIEdvbmcgPHlpYmluLmdvbmdAbnhwLmNvbT47DQo+IE1hcmsg
UnV0bGFuZCA8bWFyay5ydXRsYW5kQGFybS5jb20+OyBvcGVuIGxpc3Q6T1BFTiBGSVJNV0FSRSBB
TkQNCj4gRkxBVFRFTkVEIERFVklDRSBUUkVFIEJJTkRJTkdTIDxkZXZpY2V0cmVlQHZnZXIua2Vy
bmVsLm9yZz47DQo+IGxpbnV4LWtlcm5lbCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47
IFJvYiBIZXJyaW5nDQo+IDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBkbC1saW51eC1pbXggPGxpbnV4
LWlteEBueHAuY29tPjsgU2FzY2hhIEhhdWVyDQo+IDxrZXJuZWxAcGVuZ3V0cm9uaXguZGU+OyBG
YWJpbyBFc3RldmFtIDxmYWJpby5lc3RldmFtQG54cC5jb20+Ow0KPiBtb2RlcmF0ZWQgbGlzdDpB
Uk0vRlJFRVNDQUxFIElNWCAvIE1YQyBBUk0gQVJDSElURUNUVVJFDQo+IDxsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjFdIEFSTTog
ZHRzOiBpbXg2c2wtZXZrOiBrZWVwIHN3NCBhbHdheXMgb24NCj4gDQo+IEhpIEFuc29uLA0KPiAN
Cj4gT24gU3VuLCBKdWwgMSwgMjAxOCBhdCA5OjUzIFBNLCBBbnNvbiBIdWFuZyA8YW5zb24uaHVh
bmdAbnhwLmNvbT4gd3JvdGU6DQo+IA0KPiA+IFllcywgSSB0aGluayB3ZSBjYW4gcmV2ZXJ0IGl0
IHRvIGF2b2lkIGJyZWFrYWdlLiBEaWRuJ3Qgbm90aWNlIHRoYXQNCj4gPiBzb21lIGkuTVggcGxh
dGZvcm0gZG8gTk9UIGhhdmUgdGhvc2UgY3JpdGljYWwgc3dpdGNoZXMgYWx3YXlzLW9uLg0KPiAN
Cj4gT2ssIHRoYW5rcyBmb3IgY29uZmlybWluZy4NCj4gDQo+IEkgd2lsbCBzZW5kIGEgcmV2ZXJ0
IHBhdGNoIHRoZW4uDQo+IA0KPiBUaGFua3MNCiANCkp1c3Qgd2FudCB0byBrbm93IGhvdyB0byBo
YW5kbGUgc3VjaCBjYXNlPyBUaGUga2VybmVsIHBhdGNoIHdpbGwgbmV2ZXINCmJlIGFwcGxpZWQg
b3IgaXMgdGhlcmUgYW55IHdheSB0byBtYWtlIGtlcm5lbCBwYXRjaCBhbmQgZHRiIHBhdGNoIGFw
cGxpZWQNCnRvZ2V0aGVyIHRvIGF2b2lkIGFueSBicmVha2FnZT8NCg0KQW5zb24uDQoNCg==
