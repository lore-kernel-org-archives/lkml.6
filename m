Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75455C00319
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 02:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FC7C2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 02:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="R4AhVEGa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbfBYC0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 21:26:34 -0500
Received: from mail-eopbgr60050.outbound.protection.outlook.com ([40.107.6.50]:35528
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726539AbfBYC0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 21:26:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1QjwQfulx0EW8AdvbmpygjCjb7dF/8R8fZeWoqFk4tQ=;
 b=R4AhVEGaph0hvCF++dn4vqMXTmmoFPQhNZNwiJPwEEFyTtu6NKf6S3QJoncy0DzYF2auAY9nbLQFMblEHDfi3TDXoHN0mDFBTKmM1/Y+co1uXC1ma/vid086ACUlVsAgGaaviSPViAn7f7taJdzJAsf7P879oul+28JKNAhFCSQ=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3932.eurprd04.prod.outlook.com (52.134.72.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Mon, 25 Feb 2019 02:26:16 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 02:26:16 +0000
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
Thread-Index: AQHUx1azBL+yCPCH8ke6RA/LaBE/tKXsQYyAgAFkewCAAKW9YIAABU2AgAGCOQA=
Date:   Mon, 25 Feb 2019 02:26:16 +0000
Message-ID: <DB3PR0402MB391659B6A466B1D85114E9C9F57A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1550472539-16590-1-git-send-email-Anson.Huang@nxp.com>
 <1550472539-16590-2-git-send-email-Anson.Huang@nxp.com>
 <20190222195217.GA22194@bogus>
 <bb19470c-1590-f8dd-72e6-b382444d7902@roeck-us.net>
 <DB3PR0402MB3916912A64AF0837A9649913F5790@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <96932b3e-87f1-d8f2-95bc-0e9a8d5d45ed@roeck-us.net>
In-Reply-To: <96932b3e-87f1-d8f2-95bc-0e9a8d5d45ed@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 01b0629d-d1c3-418f-6cd3-08d69ac89e7b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3932;
x-ms-traffictypediagnostic: DB3PR0402MB3932:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtEQjNQUjA0MDJNQjM5MzI7MjM6dGl6VGNEcjVMSFQ2Vnd4d3hXVnN1U1B3?=
 =?utf-8?B?ZGpNYW1BTkwxOHVaV0lXREJ6ZGVUNSt3NDRJaGJvbGUvZjg3NUR6aklFNWlF?=
 =?utf-8?B?OWVMWlFkbzh1VjJmVU9hRlVFcWlIK2FmTldsLzdkZVp3NnJJNHE4MFhGN3o1?=
 =?utf-8?B?U0NjWTB5SmF2TFplakZmZC9GSGh5NEpJdmpLOGhhYWIvSEpxMGtIV0ZaWkky?=
 =?utf-8?B?R0Y0amVTeEFqaTBGTW81TUFZbnAxMHY2RkJodFNzLzJBOGllL2dKNVAzNGJz?=
 =?utf-8?B?UGgxSHNJMTkrWXVyNVZyckRBMnpsYWNsVmt6Tm5oM1dZeDk4UmJKM2VtS1Fw?=
 =?utf-8?B?eU9PNUpkSEhZVDZQSi9KRmtCb0xvNnpyS2d6aEpBbWNMR0djekhGWlNqM2pv?=
 =?utf-8?B?Zm5sRnkvVE8rOUxvOXRCWHpidlNSMHV5WTltcXhPWDl5ZTRkV3A5bXRJY2s5?=
 =?utf-8?B?UGNLSkR3ZERFU0FLN1FHZENFN2pXQlpoV01rd094VzVrOGx2NTJzQm5SZUdB?=
 =?utf-8?B?TTI0NUpHY0xGY0FzRnhBdTlBV0xCWk94OXJiKzcwbVF2Q0k0cGRXZDZoaU9S?=
 =?utf-8?B?Qm9xaHNnY1VvTEZEV0N4WndWamdYQTRDVXl3Zk03WkZnTEJmaW85dVFOT1F3?=
 =?utf-8?B?VjY4aGgyZzNiWGdWWUlhN2xIdnBQRXBxbkdUUWhQa1FuOXlmei8yc0lIOE9G?=
 =?utf-8?B?U2hnTHBnemxDUTVFWEEycHVkd29YZXJWQ0VsdUtNQWREd0hoaVppUUFiS0tM?=
 =?utf-8?B?K0FDaStwZGR5ZlNHS01NMTk2T2ZhK2R3dHZ5UWNuVXZFMmQ5N29ZZ3NLZHox?=
 =?utf-8?B?dHFEckxHNFAyWVMyWk9Ndnc0TkExM1ZiRGJWcE1EcllJbVF2alF4MzdTWEVi?=
 =?utf-8?B?RUJNSnBXNzFkVy9GcVlYcm84dFRqSng2UWNzT2Rmdk1sV3NJbGR1ek5qbVhY?=
 =?utf-8?B?NE15cnBOZzJkSGtMRWYyQTdmWW9aWHMwTkVqenNpSGlYNm9mL2pRK0tGVDJl?=
 =?utf-8?B?MkU5clFhTmg0MXJaaUpGeUxqNzJ2eEdBQmJpSHpKRDNUSUpRZmJwcmlqbzVJ?=
 =?utf-8?B?MW1qUDY2a0d0OHlCTlhzVFBlSjhRaG9POTl3TFR5T0lpVVViY05MSm84V1RM?=
 =?utf-8?B?aU9QTEhzcVdLVDkyQXY3M252a0xDMUlyUUNDVm1YYjZwMStzUEZEamVUTGNU?=
 =?utf-8?B?SlJBZ0NZRmdkTDhPNjJ0a3NCRzdNTlBETndDOWptUDdFWWl2WWRpdndFMmtj?=
 =?utf-8?B?Q2ltOU1rM3dkWDdoWVBTRGxuTGtva2FqODN6M0p0VXRCNUcydjRUN2VCQndL?=
 =?utf-8?B?NmJNS254bnBzMUwxeXJUUndmZlhtdHhYNGJXelJjQzZTOXljQnl5YmxJek5L?=
 =?utf-8?B?Z0t6d2NaeGx6cjNJRHEzV2dlTllkWUtGa1FPZmpMNjlEa2dYZzRiQ05LWnU0?=
 =?utf-8?B?b1lOL011YitZL3p2a2QwZmgzdHN5VGJXZzNWYnRNRWx1Z0FVTDFDdGZSa2RZ?=
 =?utf-8?B?SUhlUXpWeVZsM1Qwbjhvd2FnaVNLVGZYbEtCdmZwWGNVNGtENG00dkRDMnRj?=
 =?utf-8?B?UjR2SHBzRldZandUa21CUWd2ZUdKZER1aCtBTk5CVkpwajlsc1dnNmlSeVgw?=
 =?utf-8?B?SnYydzNDYVVzR01qZjZvSGtUNFkzdzlWVGFuTnlUcXNUY3k5dDZCTVhWUk5p?=
 =?utf-8?B?RFZRTXQ1VmRMNmJBRnM0c0hiWDVhQjgwcHBnOHA4VVJ4L1VoeUNaempTai9Z?=
 =?utf-8?B?MXVKQmVCWFo0SVliRllCRjVzQ0g4R1dpVVRYekFoRDZuT0JSSHlPTVJyRUZo?=
 =?utf-8?B?cDkrN3dDRGg5anROaUVLd0hIb05WMittVXBPY0xKbEVsV0FPQT09?=
x-microsoft-antispam-prvs: <DB3PR0402MB3932A8D7BB13673BAD6D284DF57A0@DB3PR0402MB3932.eurprd04.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(136003)(366004)(376002)(396003)(13464003)(189003)(199004)(7416002)(8936002)(81156014)(8676002)(81166006)(6116002)(3846002)(6436002)(74316002)(305945005)(478600001)(7736002)(14454004)(55016002)(9686003)(229853002)(71190400001)(71200400001)(33656002)(4326008)(97736004)(2906002)(6246003)(66066001)(25786009)(106356001)(105586002)(53936002)(186003)(7696005)(68736007)(256004)(93886005)(86362001)(316002)(76176011)(14444005)(54906003)(5660300002)(486006)(476003)(52536013)(6506007)(44832011)(110136005)(102836004)(53546011)(99286004)(26005)(446003)(11346002)(15866825006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3932;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6ij63x9DtKt9vHQQH0N/Ao5l6QDL//NLeybgJyzZCCGJGK5zUksjzrTsUHB62xhNUZoHgxwjkO/mPVz79dW8O9JYdwcIS/zLPz5WT0x5sO/8/LLolzx1p4GHIJIU3aG2qj8sEJ4eNdl8/nlRBZ8io47ACja6KXfM60y368f/qDLnNon+T5hXDRT3gkWjXzgqwsviJw4NWaKySCu+ljaqxhBdRwQM1EZR26hFtwoK9k/MiOeUB7ipPVeHYbpEuvb8oTl2c4Jo7h2aVaDRCh7dzpvV3M6ZVzN0M7nrGi7CJSgW7J0ditfQ67MG3bxLuGYALoU78SMlu+rRBRFCgRjQsdjdVZ76E3gR0GYzlPras9/edJxnEFgwLc99zpz02qyh/XZ0lqKJdEKKqtiEOX31NSZA8v2evMm+g3ZvlMU3clE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01b0629d-d1c3-418f-6cd3-08d69ac89e7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 02:26:16.1839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3932
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEd1ZW50ZXINCg0KQmVzdCBSZWdhcmRzIQ0KQW5zb24gSHVhbmcNCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBHdWVudGVyIFJvZWNrIFttYWlsdG86Z3JvZWNrN0Bn
bWFpbC5jb21dIE9uIEJlaGFsZiBPZiBHdWVudGVyDQo+IFJvZWNrDQo+IFNlbnQ6IDIwMTnlubQy
5pyIMjTml6UgMTE6MjANCj4gVG86IEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPjsg
Um9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NCj4gQ2M6IG1hcmsucnV0bGFuZEBhcm0uY29t
OyBzaGF3bmd1b0BrZXJuZWwub3JnOw0KPiBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxA
cGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsNCj4gY2F0YWxpbi5tYXJpbmFzQGFy
bS5jb207IHdpbGwuZGVhY29uQGFybS5jb207IHdpbUBsaW51eC13YXRjaGRvZy5vcmc7DQo+IEFp
c2hlbmcgRG9uZyA8YWlzaGVuZy5kb25nQG54cC5jb20+OyB1bGYuaGFuc3NvbkBsaW5hcm8ub3Jn
OyBEYW5pZWwNCj4gQmFsdXRhIDxkYW5pZWwuYmFsdXRhQG54cC5jb20+OyBBbmR5IEdyb3NzIDxh
bmR5Lmdyb3NzQGxpbmFyby5vcmc+Ow0KPiBob3JtcytyZW5lc2FzQHZlcmdlLm5ldC5hdTsgaGVp
a29Ac250ZWNoLmRlOyBhcm5kQGFybmRiLmRlOw0KPiBiam9ybi5hbmRlcnNzb25AbGluYXJvLm9y
ZzsgamFnYW5AYW1hcnVsYXNvbHV0aW9ucy5jb207DQo+IGVucmljLmJhbGxldGJvQGNvbGxhYm9y
YS5jb207IG1hcmMudy5nb256YWxlekBmcmVlLmZyOyBvbG9mQGxpeG9tLm5ldDsNCj4gZGV2aWNl
dHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LWFybS0NCj4ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LXdhdGNoZG9nQHZnZXIu
a2VybmVsLm9yZzsgZGwtbGludXgtaW14DQo+IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSCBSRVNFTkQgVjIgMS80XSBkdC1iaW5kaW5nczogZnNsOiBzY3U6IGFkZCB3
YXRjaGRvZw0KPiBiaW5kaW5nDQo+IA0KPiBPbiAyLzIzLzE5IDc6MDQgUE0sIEFuc29uIEh1YW5n
IHdyb3RlOg0KPiA+IEhpLCBHdWVudGVyL1JvYg0KPiA+DQo+ID4gQmVzdCBSZWdhcmRzIQ0KPiA+
IEFuc29uIEh1YW5nDQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4g
RnJvbTogR3VlbnRlciBSb2VjayBbbWFpbHRvOmdyb2VjazdAZ21haWwuY29tXSBPbiBCZWhhbGYg
T2YgR3VlbnRlcg0KPiA+PiBSb2Vjaw0KPiA+PiBTZW50OiAyMDE55bm0MuaciDI05pelIDE6MDgN
Cj4gPj4gVG86IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+OyBBbnNvbiBIdWFuZw0KPiA8
YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4gPj4gQ2M6IG1hcmsucnV0bGFuZEBhcm0uY29tOyBzaGF3
bmd1b0BrZXJuZWwub3JnOw0KPiA+PiBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVu
Z3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsNCj4gPj4gY2F0YWxpbi5tYXJpbmFzQGFy
bS5jb207IHdpbGwuZGVhY29uQGFybS5jb207IHdpbUBsaW51eC0NCj4gd2F0Y2hkb2cub3JnOw0K
PiA+PiBBaXNoZW5nIERvbmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPjsgdWxmLmhhbnNzb25AbGlu
YXJvLm9yZzsgRGFuaWVsDQo+ID4+IEJhbHV0YSA8ZGFuaWVsLmJhbHV0YUBueHAuY29tPjsgQW5k
eSBHcm9zcyA8YW5keS5ncm9zc0BsaW5hcm8ub3JnPjsNCj4gPj4gaG9ybXMrcmVuZXNhc0B2ZXJn
ZS5uZXQuYXU7IGhlaWtvQHNudGVjaC5kZTsgYXJuZEBhcm5kYi5kZTsNCj4gPj4gYmpvcm4uYW5k
ZXJzc29uQGxpbmFyby5vcmc7IGphZ2FuQGFtYXJ1bGFzb2x1dGlvbnMuY29tOw0KPiA+PiBlbnJp
Yy5iYWxsZXRib0Bjb2xsYWJvcmEuY29tOyBtYXJjLncuZ29uemFsZXpAZnJlZS5mcjsNCj4gPj4g
b2xvZkBsaXhvbS5uZXQ7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiA+PiBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0tIGtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnOw0KPiA+PiBsaW51eC13YXRjaGRvZ0B2Z2VyLmtlcm5lbC5vcmc7IGRsLWxpbnV4LWlteCA8
bGludXgtaW14QG54cC5jb20+DQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggUkVTRU5EIFYyIDEv
NF0gZHQtYmluZGluZ3M6IGZzbDogc2N1OiBhZGQNCj4gPj4gd2F0Y2hkb2cgYmluZGluZw0KPiA+
Pg0KPiA+PiBPbiAyLzIyLzE5IDExOjUyIEFNLCBSb2IgSGVycmluZyB3cm90ZToNCj4gPj4+IE9u
IE1vbiwgRmViIDE4LCAyMDE5IGF0IDA2OjUzOjQ4QU0gKzAwMDAsIEFuc29uIEh1YW5nIHdyb3Rl
Og0KPiA+Pj4+IEFkZCBpLk1YOFFYUCBzeXN0ZW0gY29udHJvbGxlciB3YXRjaGRvZyBiaW5kaW5n
Lg0KPiA+Pj4+DQo+ID4+Pj4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5n
QG54cC5jb20+DQo+ID4+Pj4gLS0tDQo+ID4+Pj4gQ2hhbmdlcyBzaW5jZSBWMToNCj4gPj4+PiAJ
LSB1cGRhdGUgZHRzIG5vZGUgbmFtZSB0byAid2F0Y2hkb2ciOw0KPiA+Pj4+IC0tLQ0KPiA+Pj4+
ICAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnJlZXNjYWxlL2ZzbCxz
Y3UudHh0IHwgMTANCj4gPj4gKysrKysrKysrKw0KPiA+Pj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAx
MCBpbnNlcnRpb25zKCspDQo+ID4+Pj4NCj4gPj4+PiBkaWZmIC0tZ2l0DQo+ID4+Pj4gYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZyZWVzY2FsZS9mc2wsc2N1LnR4dA0K
PiA+Pj4+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mcmVlc2NhbGUv
ZnNsLHNjdS50eHQNCj4gPj4+PiBpbmRleCA0Yjc5NzUxLi5mMzg4ZWM2IDEwMDY0NA0KPiA+Pj4+
IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnJlZXNjYWxlL2Zz
bCxzY3UudHh0DQo+ID4+Pj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2FybS9mcmVlc2NhbGUvZnNsLHNjdS50eHQNCj4gPj4+PiBAQCAtMTM2LDYgKzEzNiwxMiBAQCBS
ZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiA+Pj4+ICAgIAkJCSAgIHJlc291cmNlIGlkIGZvciB0aGVy
bWFsIGRyaXZlciB0byBnZXQgdGVtcGVyYXR1cmUNCj4gPj4gdmlhDQo+ID4+Pj4gICAgCQkJICAg
U0NVIElQQy4NCj4gPj4+Pg0KPiA+Pj4+ICtXYXRjaGRvZyBiaW5kaW5ncyBiYXNlZCBvbiBTQ1Ug
TWVzc2FnZSBQcm90b2NvbA0KPiA+Pj4+ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPj4+PiArDQo+ID4+Pj4gK1JlcXVpcmVk
IHByb3BlcnRpZXM6DQo+ID4+Pj4gKy0gY29tcGF0aWJsZTogc2hvdWxkIGJlICJmc2wsaW14OHF4
cC1zYy13ZHQiOw0KPiA+Pj4+ICsNCj4gPj4+PiAgICBFeGFtcGxlIChpbXg4cXhwKToNCj4gPj4+
PiAgICAtLS0tLS0tLS0tLS0tDQo+ID4+Pj4gICAgbHNpb19tdTE6IG1haWxib3hANWQxYzAwMDAg
ew0KPiA+Pj4+IEBAIC0xODgsNiArMTk0LDEwIEBAIGZpcm13YXJlIHsNCj4gPj4+PiAgICAJCQl0
c2Vucy1udW0gPSA8MT47DQo+ID4+Pj4gICAgCQkJI3RoZXJtYWwtc2Vuc29yLWNlbGxzID0gPDE+
Ow0KPiA+Pj4+ICAgIAkJfTsNCj4gPj4+PiArDQo+ID4+Pj4gKwkJd2F0Y2hkb2c6IHdhdGNoZG9n
IHsNCj4gPj4+PiArCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14OHF4cC1zYy13ZHQiOw0KPiA+Pj4N
Cj4gPj4+IEFzLWlzLCB0aGVyZSdzIG5vIHJlYXNvbiBmb3IgdGhpcyB0byBiZSBpbiBEVC4gVGhl
IHBhcmVudCBub2RlJ3MNCj4gPj4+IGRyaXZlciBjYW4gaW5zdGFudGlhdGUgdGhlIHdkb2cuDQo+
ID4+Pg0KPiA+Pg0KPiA+PiBBcyB0aGUgZHJpdmVyIGlzIGN1cnJlbnRseSB3cml0dGVuLCB5b3Ug
YXJlIGNvcnJlY3QsIHNpbmNlIGl0IGRvZXNuJ3QNCj4gPj4gYWNjZXB0IHdhdGNoZG9nIHRpbWVv
dXQgY29uZmlndXJhdGlvbiB0aHJvdWdoIGRldmljZXRyZWUuDQo+ID4+DQo+ID4+IFF1ZXN0aW9u
IGlzIGlmIHRoYXQgaXMgaW50ZW5kZWQuIElzIGl0ID8NCj4gPg0KPiA+IEkgYW0gYSBsaXR0bGUg
Y29uZnVzZWQsIGRvIHlvdSBtZWFuIHdlIG5vIG5lZWQgdG8gaGF2ZSAid2F0Y2hkb2ciIG5vZGUN
Cj4gaW4gc2lkZSAic2N1Ig0KPiA+IG5vZGU/IE9yIHdlIG5lZWQgdG8gbW9kaWZ5IHRoZSB3YXRj
aGRvZyBub2RlJ3MgY29tcGF0aWJsZSBzdHJpbmcgdG8gIg0KPiA+IGZzbCxpbXgtc2Mtd2R0IiB0
byBtYWtlIGl0IG1vcmUgZ2VuZXJpYyBmb3Igb3RoZXIgcGxhdGZvcm1zPyBJZiB5ZXMsIEkgY2Fu
DQo+IHJlc2VuZCB0aGUgcGF0Y2ggc2VyaWVzIHRvIG1vZGlmeSBpdC4NCj4gPg0KPiANCj4gSSB0
aGluayBSb2Igc3VnZ2VzdGVkIHRoYXQgdGhlIFNDVSBwYXJlbnQgZHJpdmVyIHNob3VsZCBpbnN0
YW50aWF0ZSB0aGUNCj4gd2F0Y2hkb2cgd2l0aG91dCBleHBsaWNpdCB3YXRjaGRvZyBub2RlLiBU
aGF0IHdvdWxkIGJlIHBvc3NpYmxlLCBidXQgaXQNCj4gY3VycmVudGx5IHVzZXMNCj4gZGV2bV9v
Zl9wbGF0Zm9ybV9wb3B1bGF0ZSgpIHRvIGRvIHRoZSBpbnN0YW50aWF0aW9uLCBhbmQgY2hhbmdp
bmcgdGhhdA0KPiB3b3VsZCBiZSBhIG1lc3MuIEJlc2lkZXMsIGl0IGRvZXMgc2VtIHRvIG1lIHRo
YXQgeW91ciBzdWdnZXN0ZWQgbm9kZSB3b3VsZA0KPiBkZXNjcmliZSB0aGUgaGFyZHdhcmUsIHNv
IEkgYW0gbm90IHN1cmUgSSB1bmRlcnN0YW5kIHRoZSByZWFzb25pbmcuDQo+IA0KPiBGb3IgbXkg
cGFydCBJIHJlZmVycmVkIHRvDQo+IAl3YXRjaGRvZ19pbml0X3RpbWVvdXQoaW14X3NjX3dkZCwg
REVGQVVMVF9USU1FT1VULCAmcGRldi0NCj4gPmRldik7IGluIHRoZSBkcml2ZXIsIHdoaWNoIGd1
YXJhbnRlZXMgdGhhdCB0aGUgdGltZW91dCBwcm9wZXJ0eSB3aWxsIG5vdCBiZQ0KPiB1c2VkIHRv
IHNldCB0aGUgdGltZW91dC4gQSBtb3JlIGNvbW1vbiBpbXBsZW1lbnRhdGlvbiB3b3VsZCBoYXZl
IGJlZW4NCj4gDQo+IAlpbXhfc2Nfd2RkLT50aW1lb3V0ID0gREVGQVVMVF9USU1FT1VUOw0KPiAJ
cmV0ID0gd2F0Y2hkb2dfaW5pdF90aW1lb3V0KGlteF9zY193ZGQsIHRpbWVvdXQsICZwZGV2LT5k
ZXYpOw0KPiANCj4gd2hlcmUgJ3RpbWVvdXQnIGlzIHRoZSBtb2R1bGUgcGFyYW1ldGVyLiBXaGlj
aCBpcyBhY3R1YWxseSBub3QgdXNlZCBpbiB5b3VyDQo+IGRyaXZlci4NCj4gSG1tIC4uLiBJIHdh
c24ndCBjYXJlZnVsIGVub3VnaCB3aXRoIG15IHJldmlldy4gVGhlIHRpbWVvdXQgaW5pdGlhbGl6
YXRpb24gYXMtDQo+IGlzIGRvZXNuJ3QgbWFrZSBzZW5zZS4gSSdsbCBjb21tZW50IG9uIHRoYXQg
aW4gdGhlIHBhdGNoLg0KDQpJIHVuZGVyc3RhbmQgbm93LCBpbiBvdXIgY2FzZXMsIEkgd291bGQg
c3RpbGwgcHJlZmVyIHRvIGhhdmUgd2F0Y2hkb2cgbm9kZSB1bmRlcg0KdGhlIFNDVSBwYXJlbnQg
bm9kZSwgc2luY2UgdGhlcmUgY291bGQgYmUgb3RoZXIgcHJvcGVydHkgc2V0dGluZyBkaWZmZXJl
bmNlIGJldHdlZW4NCmRpZmZlcmVudCBpLk1YIHBsYXRmb3JtcyB3aXRoIHN5c3RlbSBjb250cm9s
bGVyIHdhdGNoZG9nIGluc2lkZSwgdXNpbmcgdGhlIFNDVSBub2RlDQp0byBpbnN0YW50aWF0ZSBt
YWtlcyB1cyBhIGxpdHRsZSBjb25mdXNlZCBhYm91dCB0aGUgd2F0Y2hkb2csIHNvIGlmIGl0IGlz
IE5PVCB0aGF0IGNyaXRpY2FsLA0KSSB0aGluayB3ZSBzaG91bGQga2VlcCB3YXRjaGRvZyBub2Rl
LiBCdXQgdG8gbWFrZSB0aGUgd2F0Y2hkb2cgZHJpdmVyIG1vcmUgZ2VuZXJpYw0KZm9yIG90aGVy
IGkuTVggcGxhdGZvcm1zLCBJIGNoYW5nZWQgdGhlIGNvbXBhdGlibGUgc3RyaW5nIHRvICJmc2ws
aW14LXNjLXdkdCIgaW4gZHJpdmVyLCBhbmQNCmVhY2ggU29DIHNob3VsZCBoYXMgaXQgYXMgZmFs
bGJhY2sgaWYgaXQgY2FuIHJldXNlIHRoaXMgd2F0Y2hkb2cgZHJpdmVyLg0KDQpUaGFua3MsDQpB
bnNvbg0KDQo+IA0KPiBHdWVudGVyDQo+IA0KPiA+IEFuc29uLg0KPiA+DQo+ID4+DQo+ID4+IFRo
YW5rcywNCj4gPj4gR3VlbnRlcg0KDQo=
