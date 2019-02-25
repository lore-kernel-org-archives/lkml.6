Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7373C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 672BA20663
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kmSM8G0j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfBYNXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 08:23:48 -0500
Received: from mail-eopbgr10049.outbound.protection.outlook.com ([40.107.1.49]:11787
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726921AbfBYNXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 08:23:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7xv7X1v+iBMPE2PuYgIImz6PdGMc4CineF7pCcqrSI=;
 b=kmSM8G0jLlnnUnE/eTzoe7M2ZoXM96c6+NuDsq8Mhw/FikzrqqYAxi3EA9qS7gDwWJ0q67cD9Vxukzb7dyRPg2l0o/7+zTKj371m1uF9eAlJrHa1Oaf8XgZiW1x5rr01a/VRnaLxSgettyTbDX2AcAwdaMI9BYEOai5feuL1YUg=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3485.eurprd04.prod.outlook.com (52.134.3.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Mon, 25 Feb 2019 13:23:41 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced%2]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 13:23:41 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "baruch@tkos.co.il" <baruch@tkos.co.il>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: Re: [PATCH 1/5] arm64: dts: imx8mq: Add SDMA nodes
Thread-Topic: [PATCH 1/5] arm64: dts: imx8mq: Add SDMA nodes
Thread-Index: AQHUzQx/QeEbizeFI0O2BFE6xP8gsqXwgIsA
Date:   Mon, 25 Feb 2019 13:23:41 +0000
Message-ID: <f02865a5b9cd3cde711d818ccbb25f6b7b95a4cf.camel@nxp.com>
References: <20190225131722.10253-1-daniel.baluta@nxp.com>
In-Reply-To: <20190225131722.10253-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 71287ff5-2c38-4645-6aa7-08d69b24759b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3485;
x-ms-traffictypediagnostic: VI1PR0402MB3485:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjA0MDJNQjM0ODU7MjM6TWN2R0FjWnQ4UzZCWnhxcjQ2cHNSbHBM?=
 =?utf-8?B?VnJUdjkzYmhweVc3eVRrNEVYRXhyT0oyS1FlOXN0RHd3RWVXcmN2ZlpKS2p1?=
 =?utf-8?B?VE42RmFKN2ZxVFRNVXlMSWR0RzRjZEVGaUlwWmM4SEd3OEtCVDJIcTRPdzU2?=
 =?utf-8?B?SnBhWnIyYTFkd2RMTW5CNDVBNE9pYXNXdGJpUysxM2NSUkRxYnNGYk5JK0dl?=
 =?utf-8?B?R2xjKy82U0gwbVBmZGU2ZUpnOHZScjNLaXlZRHBXMmxNV1ZYRlhPNytrMEtT?=
 =?utf-8?B?U2tDU1ZwMTUyZjdZWGZrTGhHeDVkZFFCWXF2TmVYdmEzQ1ZGaUhNYjRzVmRs?=
 =?utf-8?B?Q2lxSCs3NVp2TFZETnZsR1g0TjJIUHFTSFRPS0xOYXNqQVRGMGNmNWpRL2dP?=
 =?utf-8?B?elJlaHZGYW4veVU3dzFQNStqdFc4TzF4djB2Umk3SVh5RTV1dTc0aGpVK3hr?=
 =?utf-8?B?VWMwRnlzNFZIekUwcEFPdnppRW4zK2FnbnlPd2JUQWt3QWt6K05EWkw0aVYw?=
 =?utf-8?B?TWQyU1FqSFpXWkhLK2pDWXlVM1ozUklsNWluWEp5WUdSRmZPUjhibjhhTEd0?=
 =?utf-8?B?SnppcUJOVmZLVGVzNmVjREM2UUUyR2E5ZjgwVlpDRE1Dak00VkhQRWQ4em9Q?=
 =?utf-8?B?QnVIZG1PV0lrZ2k5bEdSRXBmRVl3Qm5HaHpDQTB3TEgySVprOVZndGtYNjhP?=
 =?utf-8?B?amIvTHFpNVlaZjYyS3FHLzBKVnh5Wmc5UktYazlmT2t5YWwrbTNZZmFURkNI?=
 =?utf-8?B?LzdES1diZ1VxbWFmd2hOMnRmSDF5ZWdoWU9SazFCVzgzVGlBRW43UWp5VlA0?=
 =?utf-8?B?M2R1V0VYb3hWZ1lBV2pNVTA3Tkd1TXpHeDdBR1JPbktjM0VtMHBxbXNUWEVD?=
 =?utf-8?B?ZzJYUFNoNDBKRVpwQ3BJa0VkM1pTcDY3RGVwU1BWMmVoN1FYbEFrRjZ1NitM?=
 =?utf-8?B?MDNrb0lueWtIdzA0T3psb0k1U1IwczQvblZIdERtd2d5WGRjRVlNVlZ2N2xV?=
 =?utf-8?B?SVRDeisreHlRT0ZPcy9yemgzOGFlanRvQ0l1Z3lUeWFDYnVGc1pmWUVXVElr?=
 =?utf-8?B?NmNDWGRWaGdDWVYydVg5S0F0b3pSTmxocFg1RlZMV2FFLzFzSVdHcG01ZEEx?=
 =?utf-8?B?OHZRcFhvenR4a2d5ZCtaY3NlUE9lQmlvRVZDTXEybUVVZWxvQmFNaUQxbVpN?=
 =?utf-8?B?Q3dwcittQ3Y3NDNweE53UlNwQUFhUmlES0VHZHRERUZualMzakN4Sy81N2ZX?=
 =?utf-8?B?TTJvaEY5OFc5NVZUVnBLSjlRdStVV2pKcUt1RXZJWE1rcWVxT3o4L09Xa3M3?=
 =?utf-8?B?aGpaWEh1SUZFd0ExcGxrRXlUR1VZSTdpaEJWT1M2aGJ3SXIyeExEWlpUVktP?=
 =?utf-8?B?WTNtRzZYeDRzcS9oM2NqWktVa2grYmNvTXZlYThsOHNHYmpJZDVpSDhjajdD?=
 =?utf-8?B?REhMS3hmTlR0TGRCcWJXMUpPK0U1ZjFjU01uMXpvaTZ5Mld2M0hlcGZkaWd2?=
 =?utf-8?B?SHpYMDF0WU9lUWpGYlg4cHlSRGxxRFRwUElTMVc0WERqeGxKVFVHcitCOFds?=
 =?utf-8?B?eGRWdldHVjZnMWJVUmZLQ2k5OTVyV3k1S2NJcGlyRmZ4NUdrd0xhTlo0WFVo?=
 =?utf-8?B?aG1TS0hXTStoTGlJUjFCY2R1c25FMHh2OXpIU1dSdnRiVDYvTHNUWWpxR3Q1?=
 =?utf-8?B?NjF3MXdFNVc5Q1NFZVo0MzE5K1N5d0dlZVFnVVlwOTliTXpEZDVoWkxqVHF4?=
 =?utf-8?B?V3hVS0JGZE9jRFczOGRGWTJ5ZFZsNXErK2tJRERDYTAwNFFsTlhSU25kZW1R?=
 =?utf-8?B?YWI5OHZ2SlNWQ2crMWluSXM1VGkyRU5oUDZlWUltS2xWRi9iQT09?=
x-microsoft-antispam-prvs: <VI1PR0402MB348583A573668B834D0688DEF97A0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(136003)(366004)(39860400002)(199004)(189003)(6116002)(105586002)(106356001)(5660300002)(81166006)(71190400001)(81156014)(2351001)(97736004)(1730700003)(71200400001)(66066001)(478600001)(8676002)(14444005)(2906002)(3846002)(305945005)(86362001)(14454004)(7416002)(7736002)(6486002)(6436002)(316002)(5640700003)(6916009)(6246003)(6512007)(36756003)(256004)(26005)(476003)(54906003)(229853002)(4326008)(486006)(2501003)(446003)(68736007)(11346002)(44832011)(99286004)(76176011)(2616005)(8936002)(53936002)(102836004)(6506007)(186003)(118296001)(25786009)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3485;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4REqXvo+YqqM1u/Sxm/LrBmZX3BO2ynsY81FSsYltSUOILTGpkAl8MK/y3jHbDnTRBVk1cV5J7GfyG7zcgEBJnleNOuuySH/TwyDVWCYjx07x+G/wMknsBNU2HY85QJrJi5rpak91EL9Gt61iRdbx1nkb8rEMkV70TSyqTT0KO2WeX1ekXDkQdsg83pGWg+ijiO+TUy9FSZNXuJPOkhylO9n93/V8XCE5qm4lnVk5fwdMtmg14KX339YgoK2F4ZM0o8zWOJEF2W5r4EJbtnY0b7AoOK7tenaIllFGpaEYya1u9wOKkqCAG+VAE6QqIQ0VCZFtU4MCVW8R6avBELOySU6BJ06orcbJxEm5W2u2yvoBXnKlswYgVG4agBd7mSq8VERwjeUfNUDvTwG1MEZpc7LhHQ+ZLAulqCSdDBKIKY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <75BE431F1FB38E41A58EBC99CA645D39@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71287ff5-2c38-4645-6aa7-08d69b24759b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 13:23:41.2270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3485
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UGxlYXNlIGlnbm9yZSB0aGlzLCBJIHNlbnQgaXQgZnJvbSB0aGUgd3JvbmcgcmVwby4gSSBzd2Vh
ciB0aGF0IEkNCmRvdWJsZSBjaGVja2VkLg0KDQpXaWxsIHNlbnQgdjIgd2l0aCBjb3JyZWN0IGJh
c2UuDQoNCg0KT24gTW9uLCAyMDE5LTAyLTI1IGF0IDEzOjE3ICswMDAwLCBEYW5pZWwgQmFsdXRh
IHdyb3RlOg0KPiBTRE1BMSBpcyBwYXJ0IG9mIEFJUFMtMyByZWdpb24gYW5kIFNETUEyIGlzIHBh
cnQNCj4gb2YgQUlQUy0xIHJlZ2lvbi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5n
IDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiBbaW5pdGlhbCBzdWJtaXQgaW4gaS5NWCBpbnRlcm5h
bCB0cmVlXQ0KPiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgQmFsdXRhIDxkYW5pZWwuYmFsdXRhQG54
cC5jb20+DQo+IFthZGFwdGF0aW9uIGZvciBsaW51eC1uZXh0XQ0KPiAtLS0NCj4gIGFyY2gvYXJt
NjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcS5kdHNpIHwgMjINCj4gKysrKysrKysrKysrKysr
KysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYg
LS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXEuZHRzaQ0KPiBiL2Fy
Y2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcS5kdHNpDQo+IGluZGV4IDkxNTViZDQ3
ODRlYi4uODc4MzljNWM4YTdmIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2Zy
ZWVzY2FsZS9pbXg4bXEuZHRzaQ0KPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2Fs
ZS9pbXg4bXEuZHRzaQ0KPiBAQCAtMjM0LDYgKzIzNCwxNyBAQA0KPiAgCQkJCXN0YXR1cyA9ICJk
aXNhYmxlZCI7DQo+ICAJCQl9Ow0KPiAgDQo+ICsJCQlzZG1hMjogc2RtYUAzMDJjMDAwMCB7DQo+
ICsJCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14OG1xLXNkbWEiLA0KPiAiZnNsLGlteDdkLXNkbWEi
Ow0KPiArCQkJCXJlZyA9IDwweDMwMmMwMDAwIDB4MTAwMDA+Ow0KPiArCQkJCWludGVycnVwdHMg
PSA8R0lDX1NQSSAxMDMNCj4gSVJRX1RZUEVfTEVWRUxfSElHSD47DQo+ICsJCQkJY2xvY2tzID0g
PCZjbGsgSU1YOE1RX0NMS19TRE1BMl9ST09UPiwNCj4gKwkJCQkJIDwmY2xrIElNWDhNUV9DTEtf
U0RNQTJfUk9PVD47DQo+ICsJCQkJY2xvY2stbmFtZXMgPSAiaXBnIiwgImFoYiI7DQo+ICsJCQkJ
I2RtYS1jZWxscyA9IDwzPjsNCj4gKwkJCQlmc2wsc2RtYS1yYW0tc2NyaXB0LW5hbWUgPQ0KPiAi
aW14L3NkbWEvc2RtYS1pbXg3ZC5iaW4iOw0KPiArCQkJfTsNCj4gKw0KPiAgCQkJaW9tdXhjOiBp
b211eGNAMzAzMzAwMDAgew0KPiAgCQkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDhtcS1pb211eGMi
Ow0KPiAgCQkJCXJlZyA9IDwweDMwMzMwMDAwIDB4MTAwMDA+Ow0KPiBAQCAtNTc1LDYgKzU4Niwx
NyBAQA0KPiAgCQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ICAJCQl9Ow0KPiAgDQo+ICsJCQlz
ZG1hMTogc2RtYUAzMGJkMDAwMCB7DQo+ICsJCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14OG1xLXNk
bWEiLA0KPiAiZnNsLGlteDdkLXNkbWEiOw0KPiArCQkJCXJlZyA9IDwweDMwYmQwMDAwIDB4MTAw
MDA+Ow0KPiArCQkJCWludGVycnVwdHMgPSA8R0lDX1NQSSAyDQo+IElSUV9UWVBFX0xFVkVMX0hJ
R0g+Ow0KPiArCQkJCWNsb2NrcyA9IDwmY2xrIElNWDhNUV9DTEtfU0RNQTFfUk9PVD4sDQo+ICsJ
CQkJCSA8JmNsayBJTVg4TVFfQ0xLX1NETUExX1JPT1Q+Ow0KPiArCQkJCWNsb2NrLW5hbWVzID0g
ImlwZyIsICJhaGIiOw0KPiArCQkJCSNkbWEtY2VsbHMgPSA8Mz47DQo+ICsJCQkJZnNsLHNkbWEt
cmFtLXNjcmlwdC1uYW1lID0NCj4gImlteC9zZG1hL3NkbWEtaW14N2QuYmluIjsNCj4gKwkJCX07
DQo+ICsNCj4gIAkJCWZlYzE6IGV0aGVybmV0QDMwYmUwMDAwIHsNCj4gIAkJCQljb21wYXRpYmxl
ID0gImZzbCxpbXg4bXEtZmVjIiwNCj4gImZzbCxpbXg2c3gtZmVjIjsNCj4gIAkJCQlyZWcgPSA8
MHgzMGJlMDAwMCAweDEwMDAwPjsNCg==
