Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E29C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 03:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 163FE20855
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 03:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iZcp29B+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbfBXDEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 22:04:50 -0500
Received: from mail-eopbgr00078.outbound.protection.outlook.com ([40.107.0.78]:10883
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727475AbfBXDEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 22:04:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDP6ao+0W1A3W1zBSTitS116lTxu3R94+skcRsSw6tw=;
 b=iZcp29B+nIW0tMGSK87l+gMib+/b4gV9kBxn7AvHk8SA8RXV5WcvppAIfUtfvCzuzF8hhuo9dhoGy6hIz3ZnSMdikBcktZSUJQrnhjJ208fiHuFtK6H8sJEE1BLd68LUvwrWhpCOtNLJeMXDIqX1EcaU/q05/Q/1F/9MHmhZ4ek=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3946.eurprd04.prod.outlook.com (52.134.72.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.18; Sun, 24 Feb 2019 03:04:43 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1643.019; Sun, 24 Feb 2019
 03:04:43 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Andy Gross <andy.gross@linaro.org>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH RESEND V2 1/4] dt-bindings: fsl: scu: add watchdog binding
Thread-Topic: [PATCH RESEND V2 1/4] dt-bindings: fsl: scu: add watchdog
 binding
Thread-Index: AQHUx1azBL+yCPCH8ke6RA/LaBE/tKXsQYyAgAFkewCAAKW9YA==
Date:   Sun, 24 Feb 2019 03:04:43 +0000
Message-ID: <DB3PR0402MB3916912A64AF0837A9649913F5790@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1550472539-16590-1-git-send-email-Anson.Huang@nxp.com>
 <1550472539-16590-2-git-send-email-Anson.Huang@nxp.com>
 <20190222195217.GA22194@bogus>
 <bb19470c-1590-f8dd-72e6-b382444d7902@roeck-us.net>
In-Reply-To: <bb19470c-1590-f8dd-72e6-b382444d7902@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 48202ad1-a3eb-40db-d5dc-08d69a04d38a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3946;
x-ms-traffictypediagnostic: DB3PR0402MB3946:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtEQjNQUjA0MDJNQjM5NDY7MjM6NGJjUGMrdDVKWUZwZG52WmRRUjFNVWlq?=
 =?utf-8?B?SGEzZThrS01id205bldLaXB5b1FGT0VFSjBqQVp2UTdxNVFQOTJVYzVLLzI0?=
 =?utf-8?B?T1BuTjF0LzM4S2NabzlZbHlLTHdSVHpab2NFTVlSVXUxRXE5eGRvNmt5TElN?=
 =?utf-8?B?ZkRleGxVUEI0NFZmYnMyaUx2WVdUZDR1OUdqaVNsUGgvcmc1VVFqR0FNeG44?=
 =?utf-8?B?VFF0RHVwMFllVjVETGpZWjExV2tNRzFJNlNhdmpiK0o1cTRHZW9RaVVvYzJi?=
 =?utf-8?B?cEpiWXN1bWduRjhqWTlZWHliZFc5QkhVVS8rcjdLT3Qya2Nyd0ZqMHBkazBt?=
 =?utf-8?B?b2c4NDU5UXY4ZWR4ZEw2ZHc3M3hYdTNZRDRrOWlWZFp4aFlYWDJkc0lMRjdM?=
 =?utf-8?B?bEdYRi9Wa3g1MU9BRjRscHd1d210eTUwZmlyc1ZMYjU1dTRuckhiL0xoSHpJ?=
 =?utf-8?B?aVVQVTJhZUZLUERDSHJQYUkyL2pxVVhnczJwYTRneDIxS3dJNi84MmxuOHE1?=
 =?utf-8?B?Tk1BK1ZmVFVBSEg0UXdlbWNMSkJhNU10SGl5VU1VckVDV0U2QWtBa1E1WG0v?=
 =?utf-8?B?UldIWnlLcUY2QVVkbVNncEZIS1BaQTc4NHRzZWpIODZEM2lMT3RTNTNmOHQr?=
 =?utf-8?B?Z3pUR1dZcU1WTitoMktmbk5jVGpqSkJRWjBKQXNOUUhBd0tYc2lsY2kvRk9Y?=
 =?utf-8?B?R0UwQ2lqQXRtNS9JSFBJamZSL2k2RVdwb3ZQY0phRzc4RXhYS0pzNG9ET3Zs?=
 =?utf-8?B?UGNSQVpJZUViZGtYSjVNaUszNEVHREQ3MmhXMzFTa005dndwSVpQenkvUzEv?=
 =?utf-8?B?eGtyZHJwYjBBYTNMNzlBZkFnUFUvZDlINThtSmtGcDRkU2RVK3UwTWdmVm1t?=
 =?utf-8?B?M3lpNzNiTjF5bmtGTHNmQkdOTlpERFdMUlFtSUNiUWJVd0ttdzQ3ZjVuTGRi?=
 =?utf-8?B?bUtXRnpiaEJNbmxKYi8yY2dFdjZHSWtCWHk4U1NseGhuZlk1QkRzOFNZS0l0?=
 =?utf-8?B?MmtaRjJqUzM2RkVvSUQydnlPTmdaSjBla3Y4Q1hyNW9VemE4Tkt5NGwvT0h6?=
 =?utf-8?B?RUZiOUF4STBYVnMxdGhtNFl2ZkMvc0Z6R1JZRThPZm1JNE50OHpBckYxRStC?=
 =?utf-8?B?bnhnQ09Ub1BEUDNSSHZWeWxYQWRwVUk3Unc1dU15TDlPZStwcldLbkgxbnNS?=
 =?utf-8?B?Nm9rd1lweUpWNjJIbjdYOHFqYzFSS1Rsekpib2VCSkRMTWlMdEFPL2ZJQ1B2?=
 =?utf-8?B?YUpwVHlic0xUY29oM00yWTFwK0J2SjdJTW83cGpEbTBlS1BIUjNWQkJpMExJ?=
 =?utf-8?B?VXp0cnkxa0hEdW13TTBqM245NzRBWndyMWovc040c012MWtJSnhPUUFLbnVE?=
 =?utf-8?B?bjNrNzFBTExjSGdmc2FQSUx0RjR1dW95N3JHZzFiVzNJQUJKbXpFaDkwWUJB?=
 =?utf-8?B?QklJdmxNak04c24xMU9yRlBwbDNRZGdyL2JJeTNsT1gvMlNiZlJFdjMwU1Fm?=
 =?utf-8?B?TnFEQmcwUFByWHgrbXNhVVhFQUh3TlZKblU4Ry9VYXBWTzNqUVFPS2dXbHAz?=
 =?utf-8?B?bCtLeHV5TFpnc1d5WFhnSGtyU0pPdEloUWFSbC9DRHYzSTdnaysxcmM4L2th?=
 =?utf-8?B?MHoyaDBLY3VTQkExeE1mNWQxQ1psdVczK2NCV05JK0dBTjAvZUU4N0ZxZ2hq?=
 =?utf-8?B?R3VhOWFlczRCTVNueTVUL3VjUzJ4SVBwVC9rcXFjcTVaSTlkOGs4TlZpSTIz?=
 =?utf-8?B?WXgyN29sMnV6Mnk3eGdCdjQrRTZRSXJDSDFMakJJb21NbWtXZ3JwR1pKUzFW?=
 =?utf-8?B?SmxhM0xnQ1pkb1k3dUd0VXlLUWFlQlUxT1lVV1dJTjlRR0FYQT09?=
x-microsoft-antispam-prvs: <DB3PR0402MB394651F7FA7116C18748803CF5790@DB3PR0402MB3946.eurprd04.prod.outlook.com>
x-forefront-prvs: 09583628E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(396003)(346002)(366004)(13464003)(199004)(189003)(6246003)(186003)(14444005)(5660300002)(14454004)(74316002)(6436002)(68736007)(316002)(256004)(6506007)(8676002)(86362001)(53546011)(26005)(478600001)(66066001)(3846002)(71190400001)(52536013)(2906002)(71200400001)(6116002)(33656002)(99286004)(102836004)(9686003)(76176011)(229853002)(55016002)(7736002)(54906003)(110136005)(4326008)(476003)(97736004)(44832011)(105586002)(53936002)(25786009)(106356001)(8936002)(486006)(446003)(305945005)(81166006)(11346002)(93886005)(81156014)(7416002)(7696005)(15866825006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3946;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BLXuTT9am6HDs+A2lKb7e5cKLFNGFm5ZKp+fmfQHEpC2GkQm9qlPrtZ5/5arsqkkxdVF+OHb+ofTL3AQDtWeovU8Ou25yx0XJOnYDLg1zC6maJs1d8WYm/z8TCUdVnHuGUqQBKymb+EESWBf//+KfvFJKOyrvKgnpAmsKONCrtQ5faHhV++eTCo1U/XTdqZ8ENy8PdD621v9y9Yk2+4jukvBpsaFMZXG6lcc2GEncC9vSnqtzaE2LnoddL+Gsx9hy7FJUHwd+FN3HLOBkXGU8NgMJo81rAZN9KTbirzUV2iu28r1qa7Uo4K6ieHkQ+Cg6+zEN/YFza1/E0Y97UTs5+puA9iKJRkZSXFUN4IubUr6+xrZBnRC6HEfGmcZUNWlGIUxJenasAnpFOUxaQgiIxh3CraMicCUFmyAZAFzZxY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48202ad1-a3eb-40db-d5dc-08d69a04d38a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2019 03:04:43.7460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3946
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEd1ZW50ZXIvUm9iDQoNCkJlc3QgUmVnYXJkcyENCkFuc29uIEh1YW5nDQoNCj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VlbnRlciBSb2VjayBbbWFpbHRvOmdyb2Vj
azdAZ21haWwuY29tXSBPbiBCZWhhbGYgT2YgR3VlbnRlcg0KPiBSb2Vjaw0KPiBTZW50OiAyMDE5
5bm0MuaciDI05pelIDE6MDgNCj4gVG86IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+OyBB
bnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4gQ2M6IG1hcmsucnV0bGFuZEBhcm0u
Y29tOyBzaGF3bmd1b0BrZXJuZWwub3JnOw0KPiBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJu
ZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsNCj4gY2F0YWxpbi5tYXJpbmFz
QGFybS5jb207IHdpbGwuZGVhY29uQGFybS5jb207IHdpbUBsaW51eC13YXRjaGRvZy5vcmc7DQo+
IEFpc2hlbmcgRG9uZyA8YWlzaGVuZy5kb25nQG54cC5jb20+OyB1bGYuaGFuc3NvbkBsaW5hcm8u
b3JnOyBEYW5pZWwNCj4gQmFsdXRhIDxkYW5pZWwuYmFsdXRhQG54cC5jb20+OyBBbmR5IEdyb3Nz
IDxhbmR5Lmdyb3NzQGxpbmFyby5vcmc+Ow0KPiBob3JtcytyZW5lc2FzQHZlcmdlLm5ldC5hdTsg
aGVpa29Ac250ZWNoLmRlOyBhcm5kQGFybmRiLmRlOw0KPiBiam9ybi5hbmRlcnNzb25AbGluYXJv
Lm9yZzsgamFnYW5AYW1hcnVsYXNvbHV0aW9ucy5jb207DQo+IGVucmljLmJhbGxldGJvQGNvbGxh
Ym9yYS5jb207IG1hcmMudy5nb256YWxlekBmcmVlLmZyOyBvbG9mQGxpeG9tLm5ldDsNCj4gZGV2
aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LWFybS0NCj4ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LXdhdGNoZG9nQHZn
ZXIua2VybmVsLm9yZzsgZGwtbGludXgtaW14DQo+IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCBSRVNFTkQgVjIgMS80XSBkdC1iaW5kaW5nczogZnNsOiBzY3U6IGFk
ZCB3YXRjaGRvZw0KPiBiaW5kaW5nDQo+IA0KPiBPbiAyLzIyLzE5IDExOjUyIEFNLCBSb2IgSGVy
cmluZyB3cm90ZToNCj4gPiBPbiBNb24sIEZlYiAxOCwgMjAxOSBhdCAwNjo1Mzo0OEFNICswMDAw
LCBBbnNvbiBIdWFuZyB3cm90ZToNCj4gPj4gQWRkIGkuTVg4UVhQIHN5c3RlbSBjb250cm9sbGVy
IHdhdGNoZG9nIGJpbmRpbmcuDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5n
IDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+PiAtLS0NCj4gPj4gQ2hhbmdlcyBzaW5jZSBWMToN
Cj4gPj4gCS0gdXBkYXRlIGR0cyBub2RlIG5hbWUgdG8gIndhdGNoZG9nIjsNCj4gPj4gLS0tDQo+
ID4+ICAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mcmVlc2NhbGUvZnNs
LHNjdS50eHQgfCAxMA0KPiArKysrKysrKysrDQo+ID4+ICAgMSBmaWxlIGNoYW5nZWQsIDEwIGlu
c2VydGlvbnMoKykNCj4gPj4NCj4gPj4gZGlmZiAtLWdpdA0KPiA+PiBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnJlZXNjYWxlL2ZzbCxzY3UudHh0DQo+ID4+IGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mcmVlc2NhbGUvZnNsLHNjdS50eHQN
Cj4gPj4gaW5kZXggNGI3OTc1MS4uZjM4OGVjNiAxMDA2NDQNCj4gPj4gLS0tIGEvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mcmVlc2NhbGUvZnNsLHNjdS50eHQNCj4gPj4g
KysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mcmVlc2NhbGUvZnNs
LHNjdS50eHQNCj4gPj4gQEAgLTEzNiw2ICsxMzYsMTIgQEAgUmVxdWlyZWQgcHJvcGVydGllczoN
Cj4gPj4gICAJCQkgICByZXNvdXJjZSBpZCBmb3IgdGhlcm1hbCBkcml2ZXIgdG8gZ2V0IHRlbXBl
cmF0dXJlDQo+IHZpYQ0KPiA+PiAgIAkJCSAgIFNDVSBJUEMuDQo+ID4+DQo+ID4+ICtXYXRjaGRv
ZyBiaW5kaW5ncyBiYXNlZCBvbiBTQ1UgTWVzc2FnZSBQcm90b2NvbA0KPiA+PiArLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4+
ICsNCj4gPj4gK1JlcXVpcmVkIHByb3BlcnRpZXM6DQo+ID4+ICstIGNvbXBhdGlibGU6IHNob3Vs
ZCBiZSAiZnNsLGlteDhxeHAtc2Mtd2R0IjsNCj4gPj4gKw0KPiA+PiAgIEV4YW1wbGUgKGlteDhx
eHApOg0KPiA+PiAgIC0tLS0tLS0tLS0tLS0NCj4gPj4gICBsc2lvX211MTogbWFpbGJveEA1ZDFj
MDAwMCB7DQo+ID4+IEBAIC0xODgsNiArMTk0LDEwIEBAIGZpcm13YXJlIHsNCj4gPj4gICAJCQl0
c2Vucy1udW0gPSA8MT47DQo+ID4+ICAgCQkJI3RoZXJtYWwtc2Vuc29yLWNlbGxzID0gPDE+Ow0K
PiA+PiAgIAkJfTsNCj4gPj4gKw0KPiA+PiArCQl3YXRjaGRvZzogd2F0Y2hkb2cgew0KPiA+PiAr
CQkJY29tcGF0aWJsZSA9ICJmc2wsaW14OHF4cC1zYy13ZHQiOw0KPiA+DQo+ID4gQXMtaXMsIHRo
ZXJlJ3Mgbm8gcmVhc29uIGZvciB0aGlzIHRvIGJlIGluIERULiBUaGUgcGFyZW50IG5vZGUncw0K
PiA+IGRyaXZlciBjYW4gaW5zdGFudGlhdGUgdGhlIHdkb2cuDQo+ID4NCj4gDQo+IEFzIHRoZSBk
cml2ZXIgaXMgY3VycmVudGx5IHdyaXR0ZW4sIHlvdSBhcmUgY29ycmVjdCwgc2luY2UgaXQgZG9l
c24ndCBhY2NlcHQNCj4gd2F0Y2hkb2cgdGltZW91dCBjb25maWd1cmF0aW9uIHRocm91Z2ggZGV2
aWNldHJlZS4NCj4gDQo+IFF1ZXN0aW9uIGlzIGlmIHRoYXQgaXMgaW50ZW5kZWQuIElzIGl0ID8N
Cg0KSSBhbSBhIGxpdHRsZSBjb25mdXNlZCwgZG8geW91IG1lYW4gd2Ugbm8gbmVlZCB0byBoYXZl
ICJ3YXRjaGRvZyIgbm9kZSBpbiBzaWRlICJzY3UiDQpub2RlPyBPciB3ZSBuZWVkIHRvIG1vZGlm
eSB0aGUgd2F0Y2hkb2cgbm9kZSdzIGNvbXBhdGlibGUgc3RyaW5nIHRvICIgZnNsLGlteC1zYy13
ZHQiIHRvIG1ha2UNCml0IG1vcmUgZ2VuZXJpYyBmb3Igb3RoZXIgcGxhdGZvcm1zPyBJZiB5ZXMs
IEkgY2FuIHJlc2VuZCB0aGUgcGF0Y2ggc2VyaWVzIHRvIG1vZGlmeSBpdC4NCiANCkFuc29uLg0K
DQo+IA0KPiBUaGFua3MsDQo+IEd1ZW50ZXINCg==
