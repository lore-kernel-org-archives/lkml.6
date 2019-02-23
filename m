Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87075C10F00
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 02:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FB49206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 02:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CtsI9zRb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbfBWCch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 21:32:37 -0500
Received: from mail-eopbgr70043.outbound.protection.outlook.com ([40.107.7.43]:59775
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725821AbfBWCcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 21:32:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZNVYWFtDGtppJIxyfmUV2cZcHeK0El/KJVjXF2yFI0=;
 b=CtsI9zRbR6l/lQ67CrzqLmBSIyk37gFhq22B5m5mlZuJjncYh3dgIptAlkacyd7YCr1ROetqFcDv258raZ300XpGvAPRHpUWBY+PIk1W0xxgEMacoPd7Jkg+ufRrkwi74FGZZjwtbFg5hM3r82Zw4zYGjpSUNgKjzohbNPfMRXc=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3948.eurprd04.prod.outlook.com (52.134.70.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Sat, 23 Feb 2019 02:32:28 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1643.016; Sat, 23 Feb 2019
 02:32:28 +0000
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
Thread-Index: AQHUylbQgTJCBi+vS065hKMQGm7POKXsLzkAgAB55sA=
Date:   Sat, 23 Feb 2019 02:32:28 +0000
Message-ID: <DB3PR0402MB3916BA142113B84C0199C93EF5780@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1550802436-13007-1-git-send-email-Anson.Huang@nxp.com>
 <1550802436-13007-2-git-send-email-Anson.Huang@nxp.com>
 <155086249004.77512.8709011386763447047@swboyd.mtv.corp.google.com>
In-Reply-To: <155086249004.77512.8709011386763447047@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2b2e07cb-122d-42fd-303c-08d6993727b7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3948;
x-ms-traffictypediagnostic: DB3PR0402MB3948:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtEQjNQUjA0MDJNQjM5NDg7MjM6NlpMK243UkE2bUFnYmFMTmh6RTFmSlda?=
 =?utf-8?B?QklBNXdIZjJSK0FNREFoK2FuWGcvV2ozL1Urbmd2bm54Rmd6M2Q2cVl4ZlZ4?=
 =?utf-8?B?TjlnRG5Hekdpb1o5M1dZRFdvYTNxeXNMUWxHMitzYUN1dStsT25QS0pVTTBN?=
 =?utf-8?B?N2FKVjZ5bjFZU1Q0Ui9Cb09XbTVBYitLL3RqaG1CUjZ0L2M1WEw1MU1qaXd5?=
 =?utf-8?B?Y3FHTktQUERzekJpb1EydFNqa2ZZVW1keHR1RHpGWVR1Yk1GbllTOWhhZ1dZ?=
 =?utf-8?B?Nm9aMHkwM3UxUmd1SWsrQW1aNzQwbmx5RzFrbEdMSEJOTUlBdEVKd3hXZkIy?=
 =?utf-8?B?ZStxR1N0NklQcWQ4bG5ZdDJLSVVhNllDRmtac2lFd3lQd1Z6YTFuTG1ySjhp?=
 =?utf-8?B?R0VBZFpRVnBTb2lJdmVoK1ZMTXlOejhlcEl0ZHpIQUVHaWtqckpTWGZXZFdm?=
 =?utf-8?B?cHlxYmU1VnhPNGErb0QweVRUcmJaYVoyc3hzeVdnOGVOSDV2UXd2bUJXUjVk?=
 =?utf-8?B?dHF1dWFsZjgwakw5ZTI3SmY5c1kvOVlCTXU3NFI4UW5ER3FiS3VQM0crNm1E?=
 =?utf-8?B?MysyMURQQ2tHYkxueGZCS0tKQno0SzZyc3JmSXhBWC9CZ3BoVHNvbElreEEz?=
 =?utf-8?B?TU04QUFqb3pNd3BXZllJTnRhOUVIdkVMYjRjNWxacnp6QUFDVmFBY1UydWRV?=
 =?utf-8?B?K3YrR0JLUjk2UlYrR0hteENPa0tzNzhCMUNIaE8zWDBvWW9iRmphL3dyR3hM?=
 =?utf-8?B?Q3hreFRKSWVadnlmSVg0bGpVNWl6R2ZWcGpxMW1UdFZyNnF0bi92blIzbGt6?=
 =?utf-8?B?NW14MnhDaHJCUzh3TkJaRlFKQ0Jray9PY0YyTXQ1c1RtVThFb3ZoZG4rZ2NK?=
 =?utf-8?B?SDQ2ZElabVloVXg4MHIrOWdFNHVZeEw3alBuQXlwN0JLcVpDYnF0N1g5dUxO?=
 =?utf-8?B?WDIzeE05WHVzWU5qcndhQ08yM1MyeEhGTEpyYjBaU3F5eDA2c3ltTEx3VURs?=
 =?utf-8?B?blRKSGNacGM0bWdRL0p3MzFYWUkrY2I2c0VzbklTUDczNHFSN1BoUkhCYXBp?=
 =?utf-8?B?UGY5SFdYMXYwUW1zQjJ3TXRZcmNUeWJBa2F6YVZxRzcvMHBYT2pLS2hGSGt1?=
 =?utf-8?B?amp6dWtLUHlWUUh5MWRYZVJ3T0lQaEs1dXh4NVl1b3FTcUtsajVRcHVLbWU5?=
 =?utf-8?B?cExUOG5qdzhJVUdTNHBuVUxZdnA0TnNWWm1lUmlSclp4NHJhaGl4ZFRtZXF4?=
 =?utf-8?B?dzFOU0w5bklmL3c1eWVGY1lMcVhCL1pURnZjQlZydEZvdGpDa2dOcFJxM3ov?=
 =?utf-8?B?a1JzNXhETFZWenZPdHV1dktvYnVrcy9zL2M2eVhmSDFkSjRwNm5KSUEwTHlO?=
 =?utf-8?B?Wm95L0FTd3VyWE1yeGhHcXBqRVBVUUQ2WjhPdTJtTGR3NmtTYnhBNWJpVVA3?=
 =?utf-8?B?bEU0M3RFUFFGdzFPWGhFSHFVczJPV2FkQm9ZVGNzUUJrUHYzNmxtYk5GS1Ar?=
 =?utf-8?B?bElCNXJVRXNlektkS0sySklMU01TSUluSnBWcG1saXRwNVZZVnlYcm44OVVV?=
 =?utf-8?B?L0J0S0ltUWRtYmFDVjZkTzhDVnlaUzZxSitSeHN4Z2cyWTRsL1NObWVRQm5B?=
 =?utf-8?B?eDZiOExJcm8xSndDY1U3dlpZclMvTlViUHZyZTBjNjNmQ2VDQTJqbnBKamhh?=
 =?utf-8?B?VzR1WXhUV0l2cDV5bFl5TUVXVThocVFUY0VJdFczUytINzNXY1lEUk12Vk94?=
 =?utf-8?B?dVY0VVdWYXhERkcrMGZlZ09WaDFndmZEVXd2Z2hFSDkyZW4xMjIvVW9lWWpB?=
 =?utf-8?B?dFFkVytNTnZySUE4ZVdYRVJKaklwQzRQY2Yxb0h5bWRkUFkvNTVvVitDNC9M?=
 =?utf-8?Q?kdbifHzOzZz/U=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB3948C6D9C23D64ED76C9C6E5F5780@DB3PR0402MB3948.eurprd04.prod.outlook.com>
x-forefront-prvs: 0957AD37A0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(346002)(396003)(39860400002)(189003)(199004)(13464003)(6246003)(8676002)(11346002)(476003)(256004)(14444005)(71190400001)(86362001)(53936002)(66066001)(97736004)(44832011)(55016002)(3846002)(71200400001)(6116002)(2201001)(229853002)(2501003)(81166006)(486006)(81156014)(186003)(446003)(26005)(4326008)(68736007)(14454004)(105586002)(53546011)(76176011)(2906002)(106356001)(33656002)(9686003)(99286004)(6436002)(110136005)(6636002)(8936002)(102836004)(478600001)(25786009)(7416002)(305945005)(316002)(6506007)(74316002)(7696005)(7736002)(5660300002)(52536013)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3948;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WhePo0T4Svwie1Jztqzs2h/hbe0VopVTue7pCZX9UdG6/KP0AUYYJrRSkrnCV8Abj0z2RkJfg+EXjUbxb4TNh8s4Z1eF/IaxajkryFj2c2tgCMGXdXnnWKOEfc5+DTOxkbqm55OXnubTBi4Yp867SluDWAZduXjs7IuU9OJJdjl3+pbUhcTPAnAfANGf4RqRRq8zkNLjeFQqyARAMzITzjzR8AtX0pBVlyC2s5YQJhVxlBG/qLkUGwlrm2nAKLtR7gWrsShCVqZnQi/3I6VUyzZlkB8ZK4M5LRL/kQyXWse4nWFiOGFwmH4Nfp48x+zlDRZVwCINZEBCGtDP58OiC3s/KJLXtVi2YO0T7UB2/xJ7kOoseMHMlISS1XhER148D2zI+nJgnW3+9BNEqEMvUWKRryIydT/uzfKKP81dQ/E=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b2e07cb-122d-42fd-303c-08d6993727b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2019 02:32:28.7201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3948
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFN0ZWhwZW4NCg0KQmVzdCBSZWdhcmRzIQ0KQW5zb24gSHVhbmcNCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdGVwaGVuIEJveWQgW21haWx0bzpzYm95ZEBrZXJu
ZWwub3JnXQ0KPiBTZW50OiAyMDE55bm0MuaciDIz5pelIDM6MDgNCj4gVG86IGRldmljZXRyZWVA
dmdlci5rZXJuZWwub3JnOyBmZXN0ZXZhbUBnbWFpbC5jb207DQo+IGtlcm5lbEBwZW5ndXRyb25p
eC5kZTsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC0NCj4gY2xr
QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbWFyay5ydXRs
YW5kQGFybS5jb207DQo+IG10dXJxdWV0dGVAYmF5bGlicmUuY29tOyByb2JoK2R0QGtlcm5lbC5v
cmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7DQo+IHNoYXduZ3VvQGtlcm5lbC5vcmc7IEFpc2hl
bmcgRG9uZyA8YWlzaGVuZy5kb25nQG54cC5jb20+OyBBbnNvbg0KPiBIdWFuZyA8YW5zb24uaHVh
bmdAbnhwLmNvbT47IERhbmllbCBCYWx1dGEgPGRhbmllbC5iYWx1dGFAbnhwLmNvbT4NCj4gQ2M6
IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
UkVTRU5EIFY2IDIvMl0gY2xrOiBpbXg6IHNjdTogYWRkIGNwdSBmcmVxdWVuY3kgc2NhbGluZw0K
PiBzdXBwb3J0DQo+IA0KPiBRdW90aW5nIEFuc29uIEh1YW5nICgyMDE5LTAyLTIxIDE4OjMyOjEw
KQ0KPiA+IE9uIE5YUCdzIGkuTVggU29DcyB3aXRoIHN5c3RlbSBjb250cm9sbGVyIGluc2lkZSwg
Q1BVIGZyZXF1ZW5jeQ0KPiA+IHNjYWxpbmcgY2FuIE9OTFkgYmUgZG9uZSBieSBzeXN0ZW0gY29u
dHJvbGxlciBmaXJtd2FyZSwgYW5kIGl0IGNhbg0KPiA+IE9OTFkgYmUgcmVxdWVzdGVkIGZyb20g
c2VjdXJlIG1vZGUsIHNvIExpbnV4IGtlcm5lbCBoYXMgdG8gY2FsbCBBUk0NCj4gPiBTTUMgdG8g
dHJhcCB0byBBUk0tVHJ1c3RlZC1GaXJtd2FyZSB0byByZXF1ZXN0IHN5c3RlbSBjb250cm9sbGVy
DQo+ID4gZmlybXdhcmUgdG8gZG8gQ1BVIGZyZXF1ZW5jeSBzY2FsaW5nLg0KPiA+DQo+ID4gVGhp
cyBwYXRjaCBhZGRzIGkuTVggc3lzdGVtIGNvbnRyb2xsZXIgQ1BVIGZyZXF1ZW5jeSBzY2FsaW5n
IHN1cHBvcnQsDQo+ID4gaXQgcmV1c2VzIGNwdWZyZXEtZHQgZHJpdmVyIGFuZCBpbXBsZW1lbnQg
dGhlIENQVSBmcmVxdWVuY3kgc2NhbGluZw0KPiA+IGluc2lkZSBTQ1UgY2xvY2sgZHJpdmVyLg0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+
DQo+IA0KPiBBaCBJIG1pc3NlZCBvbmUgdGhpbmcsIHNlZSBiZWxvdy4NCj4gDQo+ID4gQEAgLTE4
MCw2ICsxODUsMjMgQEAgc3RhdGljIGxvbmcgY2xrX3NjdV9yb3VuZF9yYXRlKHN0cnVjdCBjbGtf
aHcgKmh3LA0KPiB1bnNpZ25lZCBsb25nIHJhdGUsDQo+ID4gICAgICAgICByZXR1cm4gcmF0ZTsN
Cj4gPiAgfQ0KPiA+DQo+ID4gK3N0YXRpYyBpbnQgY2xrX3NjdV9hdGZfc2V0X2NwdV9yYXRlKHN0
cnVjdCBjbGtfaHcgKmh3LCB1bnNpZ25lZCBsb25nIHJhdGUsDQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgbG9uZyBwYXJlbnRfcmF0ZSkgew0KPiA+ICsg
ICAgICAgc3RydWN0IGNsa19zY3UgKmNsayA9IHRvX2Nsa19zY3UoaHcpOw0KPiA+ICsgICAgICAg
c3RydWN0IGFybV9zbWNjY19yZXMgcmVzOw0KPiA+ICsgICAgICAgdW5zaWduZWQgbG9uZyBjbHVz
dGVyX2lkOw0KPiA+ICsNCj4gPiArICAgICAgIGlmIChjbGstPnJzcmNfaWQgPT0gSU1YX1NDX1Jf
QTM1KQ0KPiA+ICsgICAgICAgICAgICAgICBjbHVzdGVyX2lkID0gMDsNCj4gDQo+IERvIHdlIHN0
aWxsIG5lZWQgdG8gY2hlY2sgdGhpcyBhbnltb3JlPyBXaHkgbm90IGp1c3QgYWx3YXlzIHVzZSBj
bHVzdGVyX2lkIDA/DQoNClRoZSBpLk1YOFFYUCBPTkxZIGhhcyAxIGNsdXN0ZXIgbmFtZWQgQTM1
LCB3aGlsZSBvbiBpLk1YOFFNIHRoZXJlIHdpbGwgYmUNCjIgY2x1c3RlcnMsIEE1MyBhbmQgQTcy
LCBzbyB3ZSBuZWVkIHRvIHVzZSB0aGUgcmVzb3VyY2UgSUQgdG8gaW5pdGlhbGl6ZSB0aGUgY2x1
c3Rlcl9pZC4NCg0KPiANCj4gPiArDQo+ID4gKyAgICAgICAvKiBDUFUgZnJlcXVlbmN5IHNjYWxp
bmcgY2FuIE9OTFkgYmUgZG9uZSBieSBBUk0tVHJ1c3RlZC1GaXJtd2FyZQ0KPiAqLw0KPiA+ICsg
ICAgICAgYXJtX3NtY2NjX3NtYyhJTVhfU0lQX0NQVUZSRVEsIElNWF9TSVBfU0VUX0NQVUZSRVEs
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIGNsdXN0ZXJfaWQsIHJhdGUsIDAsIDAsIDAsIDAs
ICZyZXMpOw0KPiANCj4gQmVjYXVzZSBub3QgY2hlY2tpbmcgd291bGQgbWFrZSB0aGlzIHdvcmss
IHZzLiBjaGVja2luZyBjYXVzZXMgdGhpcyBjb2RlIHRvDQo+IHNvbWV0aW1lcyB1c2UgYW4gdW5p
bml0aWFsaXplZCB2YWx1ZSBmcm9tIHRoZSBzdGFjay4NCg0KIDg5ICsgICAgICAgaWYgKHJzcmNf
aWQgPT0gSU1YX1NDX1JfQTM1KQ0KIDkwICsgICAgICAgICAgICAgICBpbml0Lm9wcyA9ICZjbGtf
c2N1X2NwdV9vcHM7DQogOTEgKyAgICAgICBlbHNlDQogOTIgKyAgICAgICAgICAgICAgIGluaXQu
b3BzID0gJmNsa19zY3Vfb3BzOw0KDQpJIHRoaW5rIGl0IHNob3VsZCBiZSBnb29kLiBPbmx5IHdo
ZW4gcGxhbiB0byBzdXBwb3J0IGNwdS1mcmVxIHNjYWxpbmcsIHRoZW4gdGhlDQpDUFUgY2xvY2sg
d2lsbCBiZSBzd2l0Y2hlZCB0byB1c2UgY2xrX3NjdV9jcHVfb3BzIGFuZCB0aGUgY2x1dHNlcl9p
ZCBpbml0aWFsaXphdGlvbg0Kd2lsbCBiZSBkb25lIGFjY29yZGluZyB0byBDUFUgcmVzb3VyY2Uu
IEZvciBleGFtcGxlLCB3aGVuIHdlIHBsYW4gdG8gc3VwcG9ydCBpLk1YOFFNDQpjcHUtZnJlcSBz
Y2FsaW5nLCB3ZSB3aWxsIGFkZCBBNTMgYW5kIEE3MiBjaGVjayBoZXJlIGFuZCBzd2l0Y2ggdGhl
IGNsb2NrIG9wcyB0byBjbGtfc2N1X2NwdV9vcHMsDQphbHNvIHdlIHdpbGwgYWRkIHRoZSBjbHVz
dGVyX2lkIGluaXRpYWxpemF0aW9uIGluIHRoZSBTTUMgY2xvY2sgc2V0IHJhdGUuDQoNClRoYW5r
cywNCkFuc29uLg0KDQo+IA0KPiA+ICsNCj4gPiArICAgICAgIHJldHVybiAwOw0KPiA+ICt9DQo+
ID4gKw0K
