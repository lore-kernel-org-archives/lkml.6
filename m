Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82ECEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 05:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F3B6213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 05:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nxGgtw2G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfBZFSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 00:18:22 -0500
Received: from mail-eopbgr60047.outbound.protection.outlook.com ([40.107.6.47]:28112
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725983AbfBZFSU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 00:18:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMyTJnHKrtgby4bv9F5U/rVXNCp16TB70mK4Rk1AoKI=;
 b=nxGgtw2GBVewpsvmxNazDfdyJuY/7hrtm0eQbYoNIR5cnBMprZa0qCJrEeTDRsILQdCvu6APDo2Ackg8kNWA2YE9la6ScfS0BYJ6213uGsrpDd6nU8tTUqJMZgAKpQGwgfgGLIO1ZDZnUKiUiPMftBXiOL0tP1Zw/OWX/nGEC/I=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3849.eurprd04.prod.outlook.com (52.134.71.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.18; Tue, 26 Feb 2019 05:18:08 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 05:18:08 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH RESEND V6 2/2] clk: imx: scu: add cpu frequency scaling
 support
Thread-Topic: [PATCH RESEND V6 2/2] clk: imx: scu: add cpu frequency scaling
 support
Thread-Index: AQHUylbQgTJCBi+vS065hKMQGm7POKXsLzkAgAB55sCABB9gAIAAx+7w
Date:   Tue, 26 Feb 2019 05:18:08 +0000
Message-ID: <DB3PR0402MB3916536B5BDD5CD17E9E04BFF57B0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1550802436-13007-1-git-send-email-Anson.Huang@nxp.com>
 <1550802436-13007-2-git-send-email-Anson.Huang@nxp.com>
 <155086249004.77512.8709011386763447047@swboyd.mtv.corp.google.com>
 <DB3PR0402MB3916BA142113B84C0199C93EF5780@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <155111530880.77512.16435986555733393398@swboyd.mtv.corp.google.com>
In-Reply-To: <155111530880.77512.16435986555733393398@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 749751fe-edb4-4ebf-c382-08d69ba9cb94
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3849;
x-ms-traffictypediagnostic: DB3PR0402MB3849:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtEQjNQUjA0MDJNQjM4NDk7MjM6YUNEcXJyM252NCs1anlocUFONnhqUm9h?=
 =?utf-8?B?ZGprdUxoMVU0alNGVTVNd0k1QkZuUm1tY2dwbjVEaWdGU3VBbG1TaEY2dGww?=
 =?utf-8?B?dDU0K1E2ZjlXakdOaTFZa3lSZHV3VnRqQURXU2dvdkpuajQvdmZsK3lRTkU0?=
 =?utf-8?B?UHU5dGxrdHM2NGdMMU5MbVRRVDRFUE9YRGd0Q3NUQmtPL1BqSThNb1lWV1Zh?=
 =?utf-8?B?QUU1OVMwUEFlS3FxR1dESzdJN282MjU5d3BBSllaa3BNaUl2Nm9FcE51ZU14?=
 =?utf-8?B?VGZYUHdJRHpnNTYvT2NYZCtvZjZRTmcrbGN3UnovNnY4dTM3cTlrU3BHMDZD?=
 =?utf-8?B?Q0lnSGM3dmo1T3hGMGtFakhBRmxyUnhkSlE3amhHQ0J5WURlTjlHZVNqR0Nw?=
 =?utf-8?B?UEU0OUVvV01Ba2tReThqSWhYOGVGR3JqSS9UQlFYci9sNG9YczNoUEM4OVIv?=
 =?utf-8?B?QlBsV3l4WWRuQ2dMOWdweUgrTVo4WldCNlpxK203TmxrK2I0OUpXTjRXMEp3?=
 =?utf-8?B?Z0Z3djBsdU80a1hMNVBWZTc1T1NPRkxNeUdFeXd2QlZxV0dEYUd3UFE4MjJQ?=
 =?utf-8?B?RXZVaTArRnFpQzFKR3RLV2U1S3Nyb3Q3ZzkrVFlEbVVyS3hyaDNpRXNZU2xy?=
 =?utf-8?B?bWg2c3hVdXNjbisxYTJHQm9JV3l2RTVzS2ViM2JPTS9FQlc5d0JjOU9NRjVH?=
 =?utf-8?B?ZWh0NWxTWGNqRCt4OG1tQUFpTmlFdUx6NVBPYmNRYVFtVmhsNE8rYy9EaUN6?=
 =?utf-8?B?WS9IYU9ZZm0xQ2Z1eXp1Y0grVkRXaUlFL0lSUGl3bkw3Uy9qTkVoNWY1Tysr?=
 =?utf-8?B?S3lrSXl5VlZOSlJseHE1TE9rWHdRQ0NVcDErK3BMZGNaejgxZXZYczBzWHl4?=
 =?utf-8?B?bDd3ek1QZDJyam5PRGdYakhEbm9ydFNrS29XMTg5OFdPSCtwcFJTem1SUjRP?=
 =?utf-8?B?bjlqQXdOQytMNUh4OWtBZi9QTmMyZEYrOW5BS1NSSkoxN3o5ZmxMSHRWeXhK?=
 =?utf-8?B?UzBGTVF5blIxZzRkdVA3d1VOUVRyV0tVbmpWdjJsU3hsRFhPT1Z3YWsweG45?=
 =?utf-8?B?QzFESnB6VnlWR0VZVWZUaEZYcG9QZXpqeWl6T0FGYWYvOTVNazNyVkFHdXBw?=
 =?utf-8?B?NTgza3VTTkZpUk1FaXRnd3BucTRrYUg2elVyWElXRXdGbTBxckI3OHhIVW1E?=
 =?utf-8?B?VENzM3lVM21nMWtIb0U0bVpDRjIxYlI1bkdhNU1seXM2bEZzdnZnZFlxNFV2?=
 =?utf-8?B?MDRzbFF1SmJyMG9pWE5WdFNuSkRLeXZuTG9EZ25zRHE3NFprMXJ4ejlQVy9n?=
 =?utf-8?B?SnA3aGhwZHdiU3pKVGdxazcyQzJTaFFFaUhjVUQzTDJBSHRGeW13YnNUN2Iv?=
 =?utf-8?B?L0VuV0ljc3dGdDJ3RzlzblJ4dzF2bFIwL0o2bFVTN0ltUUdSa2tlMWhVbjNZ?=
 =?utf-8?B?YUdRRFJkOHg3UCtXQU9VZnlvemdoby9jU1lTOW1LK2Vyb25EcTZIeGJUYjBw?=
 =?utf-8?B?SFlLbTFicHdtRlhGRjNuaFJ4WWdtOThRNEdqa3kydENLRVdMcC8xRm9aMGxH?=
 =?utf-8?B?OU53S0Fka09uVVVCRDdGTmtlNDNKRFZ1ZmpucWJadUdWTzEyUXFZQlFObjFv?=
 =?utf-8?B?TDB0UGFCTWVGblhwZmp0bUdYRVBqbkJwRGwrMXF6Qjh0dXJpY0Nic3FNMmVR?=
 =?utf-8?B?WEZrSGViSWtqZHpPWEhnY3ZNQkpKazlKSkZrSEpPSHhFbFVJdnl4aS9oUVY5?=
 =?utf-8?B?cVI5T0NJNkdzeC8xUjROK3ZLcnFQWFdPanFOMHhLcGJtZExwKzZ4aGtnbnNM?=
 =?utf-8?B?NElaWmtFbmlnV2paTk9RLzdMMXVVVTVyeUxwbWdoRFI2d1NHb3NPRXlwRnc4?=
 =?utf-8?Q?vJqh8uF/lco98=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB3849B3EA1C01C899A81CF5EFF57B0@DB3PR0402MB3849.eurprd04.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(396003)(39860400002)(366004)(13464003)(199004)(189003)(9686003)(476003)(186003)(102836004)(26005)(76176011)(7696005)(4326008)(446003)(2501003)(86362001)(14454004)(11346002)(81166006)(6436002)(6636002)(8676002)(81156014)(305945005)(2201001)(52536013)(5660300002)(106356001)(97736004)(71200400001)(71190400001)(6246003)(7736002)(74316002)(105586002)(8936002)(486006)(7416002)(44832011)(93886005)(110136005)(229853002)(99286004)(66066001)(55016002)(33656002)(68736007)(6506007)(478600001)(53546011)(3846002)(6116002)(53936002)(256004)(316002)(25786009)(2906002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3849;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qt7dpk1Dl2vZBwNPx2JMrw8UQfd5gPuwk4EL3r5HJEDxB7fqjxKEKi5DB2kJQyZNWM5H86jrEmVXlxx5eq7y2r3+2LYCi7Scqx5x4YA89FPmQNXjDwJAxMO3AJxBvvK+BplrRiRzkyC63CVCMrtjlig4K8O06XCG1JwxkMoJrww0eUP5h+yiVgmoZbJkWy3uHUYFecDmAGiF9kZ+UBPlKUprLFsoPTvH9MTMUN+0Eqj++HdszxLdlLPAgF1OSEGMm6BFlFZ7AVu+Ee6i4ZWrcfF4Ujy9Uwm7zPdNwyxACGfgXC+OOEoTTd/CqDBmn5eTnE9Zt3yVwsNczd2sHp+Fni1CeNUO5WW3PyphTj0tt34udinVeBTlEUwcm/JzoXqZY7tLeJuBD9PTTQQfKf1BICBEQHU7wR5PERgFlOdGEIA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 749751fe-edb4-4ebf-c382-08d69ba9cb94
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 05:18:08.5535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3849
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFN0ZXBoZW4NCg0KQmVzdCBSZWdhcmRzIQ0KQW5zb24gSHVhbmcNCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdGVwaGVuIEJveWQgW21haWx0bzpzYm95ZEBrZXJu
ZWwub3JnXQ0KPiBTZW50OiAyMDE55bm0MuaciDI25pelIDE6MjINCj4gVG86IGRldmljZXRyZWVA
dmdlci5rZXJuZWwub3JnOyBmZXN0ZXZhbUBnbWFpbC5jb207DQo+IGtlcm5lbEBwZW5ndXRyb25p
eC5kZTsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC0NCj4gY2xr
QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbWFyay5ydXRs
YW5kQGFybS5jb207DQo+IG10dXJxdWV0dGVAYmF5bGlicmUuY29tOyByb2JoK2R0QGtlcm5lbC5v
cmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7DQo+IHNoYXduZ3VvQGtlcm5lbC5vcmc7IEFpc2hl
bmcgRG9uZyA8YWlzaGVuZy5kb25nQG54cC5jb20+OyBBbnNvbg0KPiBIdWFuZyA8YW5zb24uaHVh
bmdAbnhwLmNvbT47IERhbmllbCBCYWx1dGEgPGRhbmllbC5iYWx1dGFAbnhwLmNvbT4NCj4gQ2M6
IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0gg
UkVTRU5EIFY2IDIvMl0gY2xrOiBpbXg6IHNjdTogYWRkIGNwdSBmcmVxdWVuY3kgc2NhbGluZw0K
PiBzdXBwb3J0DQo+IA0KPiBRdW90aW5nIEFuc29uIEh1YW5nICgyMDE5LTAyLTIyIDE4OjMyOjI4
KQ0KPiA+ID4gPiArICAgICAgICAgICAgICAgY2x1c3Rlcl9pZCA9IDA7DQo+ID4gPg0KPiA+ID4g
RG8gd2Ugc3RpbGwgbmVlZCB0byBjaGVjayB0aGlzIGFueW1vcmU/IFdoeSBub3QganVzdCBhbHdh
eXMgdXNlDQo+IGNsdXN0ZXJfaWQgMD8NCj4gPg0KPiA+IFRoZSBpLk1YOFFYUCBPTkxZIGhhcyAx
IGNsdXN0ZXIgbmFtZWQgQTM1LCB3aGlsZSBvbiBpLk1YOFFNIHRoZXJlIHdpbGwNCj4gPiBiZQ0K
PiA+IDIgY2x1c3RlcnMsIEE1MyBhbmQgQTcyLCBzbyB3ZSBuZWVkIHRvIHVzZSB0aGUgcmVzb3Vy
Y2UgSUQgdG8gaW5pdGlhbGl6ZSB0aGUNCj4gY2x1c3Rlcl9pZC4NCj4gPg0KPiA+ID4NCj4gPiA+
ID4gKw0KPiA+ID4gPiArICAgICAgIC8qIENQVSBmcmVxdWVuY3kgc2NhbGluZyBjYW4gT05MWSBi
ZSBkb25lIGJ5DQo+ID4gPiA+ICsgQVJNLVRydXN0ZWQtRmlybXdhcmUNCj4gPiA+ICovDQo+ID4g
PiA+ICsgICAgICAgYXJtX3NtY2NjX3NtYyhJTVhfU0lQX0NQVUZSRVEsIElNWF9TSVBfU0VUX0NQ
VUZSRVEsDQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICBjbHVzdGVyX2lkLCByYXRlLCAw
LCAwLCAwLCAwLCAmcmVzKTsNCj4gPiA+DQo+ID4gPiBCZWNhdXNlIG5vdCBjaGVja2luZyB3b3Vs
ZCBtYWtlIHRoaXMgd29yaywgdnMuIGNoZWNraW5nIGNhdXNlcyB0aGlzDQo+ID4gPiBjb2RlIHRv
IHNvbWV0aW1lcyB1c2UgYW4gdW5pbml0aWFsaXplZCB2YWx1ZSBmcm9tIHRoZSBzdGFjay4NCj4g
Pg0KPiA+ICA4OSArICAgICAgIGlmIChyc3JjX2lkID09IElNWF9TQ19SX0EzNSkNCj4gPiAgOTAg
KyAgICAgICAgICAgICAgIGluaXQub3BzID0gJmNsa19zY3VfY3B1X29wczsNCj4gPiAgOTEgKyAg
ICAgICBlbHNlDQo+ID4gIDkyICsgICAgICAgICAgICAgICBpbml0Lm9wcyA9ICZjbGtfc2N1X29w
czsNCj4gPg0KPiA+IEkgdGhpbmsgaXQgc2hvdWxkIGJlIGdvb2QuIE9ubHkgd2hlbiBwbGFuIHRv
IHN1cHBvcnQgY3B1LWZyZXEgc2NhbGluZywNCj4gPiB0aGVuIHRoZSBDUFUgY2xvY2sgd2lsbCBi
ZSBzd2l0Y2hlZCB0byB1c2UgY2xrX3NjdV9jcHVfb3BzIGFuZCB0aGUNCj4gPiBjbHV0c2VyX2lk
IGluaXRpYWxpemF0aW9uIHdpbGwgYmUgZG9uZSBhY2NvcmRpbmcgdG8gQ1BVIHJlc291cmNlLiBG
b3INCj4gPiBleGFtcGxlLCB3aGVuIHdlIHBsYW4gdG8gc3VwcG9ydCBpLk1YOFFNIGNwdS1mcmVx
IHNjYWxpbmcsIHdlIHdpbGwgYWRkDQo+ID4gQTUzIGFuZCBBNzIgY2hlY2sgaGVyZSBhbmQgc3dp
dGNoIHRoZSBjbG9jayBvcHMgdG8gY2xrX3NjdV9jcHVfb3BzLCBhbHNvDQo+IHdlIHdpbGwgYWRk
IHRoZSBjbHVzdGVyX2lkIGluaXRpYWxpemF0aW9uIGluIHRoZSBTTUMgY2xvY2sgc2V0IHJhdGUu
DQo+ID4NCj4gDQo+IE9rLiBTbyB0aGVuIHBsZWFzZSBtYWtlIHRoZSBzZXRfcmF0ZSBmdW5jdGlv
biBmYWlsIGlmIHRoZSByc3JjX2lkIGRvZXNuJ3QNCj4gbWF0Y2ggc29tZXRoaW5nIGV4cGVjdGVk
LiBBcyB0aGUgY29kZSBpcyB3cml0dGVuIHJpZ2h0IG5vdywgdGhlIGNvbXBpbGVyDQo+IGNhbid0
IGZpZ3VyZSBvdXQgdGhhdCBjbHVzdGVyX2lkIHdpbGwgYWx3YXlzIGJlIGFzc2lnbmVkLCBzbyBp
dCBjb21wbGFpbnMgdGhhdCBpdA0KPiBtYXkgYmUgdXNpbmcgdW5pbml0aWFsaXplZCBkYXRhLg0K
DQpBZ3JlZWQsIEkgaGF2ZSBzZW50IFY3IHBhdGNoIHNlcmllcyB0byBhZGQgcmV0dXJuIGZhaWwg
aWYgdGhlIHJlc291cmNlIElEIGlzIE5PVCBleHBlY3RlZC4NCg0KVGhhbmtzLA0KQW5zb24uDQoN
Cg==
