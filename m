Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAEBC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 02:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F42E2077B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 02:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sqKrREy8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfBVCeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 21:34:23 -0500
Received: from mail-eopbgr80070.outbound.protection.outlook.com ([40.107.8.70]:37373
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725961AbfBVCeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 21:34:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSREwVdxZKPLXVE4xpFFup85wBgIPJGZBPomx+6OMEg=;
 b=sqKrREy8wgGH34SjwEIopR+hgIjWW2UUH69s0CRsq3vaC6OA1nGGpZmYy/JZ4GARGkbo97UFDmR8FZA+yNmwVmJJMhWWVIYms5tTjYMwSnFlvXMDvTUSyKYMnPmgbAIZIMPqRJKdJljLsRufadrCp419qdump/9fnK8ZTDAjvpk=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3771.eurprd04.prod.outlook.com (52.134.67.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Fri, 22 Feb 2019 02:34:16 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1643.016; Fri, 22 Feb 2019
 02:34:16 +0000
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
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V4 2/2] clk: imx: scu: add cpu frequency scaling support
Thread-Topic: [PATCH V4 2/2] clk: imx: scu: add cpu frequency scaling support
Thread-Index: AQHUxAgs8uuWj5mH40eZScOWTh4AP6XqxYcAgABgFjA=
Date:   Fri, 22 Feb 2019 02:34:16 +0000
Message-ID: <DB3PR0402MB3916D31F618C847E3504A564F57F0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1550108915-574-1-git-send-email-Anson.Huang@nxp.com>
 <1550108915-574-2-git-send-email-Anson.Huang@nxp.com>
 <155078210899.77512.5319038009555276321@swboyd.mtv.corp.google.com>
In-Reply-To: <155078210899.77512.5319038009555276321@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2ac5572-459a-4c8b-51c5-08d6986e3d9b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3771;
x-ms-traffictypediagnostic: DB3PR0402MB3771:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtEQjNQUjA0MDJNQjM3NzE7MjM6TzJvNVpBdFRvSUdoMFJlNFJadjJCT2ZT?=
 =?utf-8?B?bHlwVU9hdGNQS2JLQng0L3ZDZUc1M3JDcnlvQjMwQnVHOHhmWWRzVjhBUHV1?=
 =?utf-8?B?MTNkTTd6aFVXa2xocVYxRzN0UTZPQ09wZjJHWUQ3YzNjOU1xMGZUOW5VbCtZ?=
 =?utf-8?B?R2YxblNUV0FvcXoyTVFiVkxjMzhPUXBsNStlR25kbUdKYUI0cERpRFA4M3cr?=
 =?utf-8?B?SkN2TnpicnlVeVMydmJPTEs2OGNmdWdnUlNKYXIrMTJSTTFoczdXRC9CUUl1?=
 =?utf-8?B?RDlCczMreExuN2l5VlA4S0g0R3RTVXZ3T0JPTnArUW5SVHZOMUNZK0RiL2pE?=
 =?utf-8?B?QkpwblNtckEwN0dYY2dyVlF1N1pmOFlQL1IwZExWMy9qUlczZkZMUzF3a1BI?=
 =?utf-8?B?NEQwSWRJVFdTWmVwYklNZTc1bmxBK013Wjg2bld1SGkvWDFyUUZQS0lKN250?=
 =?utf-8?B?VHY1ZFhXTWw0RjBrK0hIL3kzNXFTd3UyZGZ1RE5CbXY2MUc5YVVad05pMGQ4?=
 =?utf-8?B?NW9pRlNlNVIzdktWeVBJZXE0TnNMQW83UUZiMHNnck5BYlZoMUFhQ1hHVXRo?=
 =?utf-8?B?YU1JR0ViYXRENXhXdDlOeGNqOWdHUldqU3hKWXZnWTNjSlhoYXMrQTBwNkY5?=
 =?utf-8?B?YnpJdFA4eUJEOE9vUmdYc3VWbzZoKzFoSkZJTkVzcWJwR2FEelNCSXh1RkxE?=
 =?utf-8?B?WHNJNnVPTWlkVVNRNTFad1drNVVUR3FFVU1uZm1GWHY3QmtLL1lWd3R4Ukxx?=
 =?utf-8?B?WU1XbXhxN3V1MmRUYXlud3ptZXlXVDc3dmt6b3ROTHJZbCsyVGVuRG9yeVl1?=
 =?utf-8?B?ckVBMEVLeVNSMkZJTGR0ZnZBbTZKVVU0ZjdJRFNrQ2xrakZBb3Nqb2hnSzlw?=
 =?utf-8?B?ZnJKTHNxZ3c5WDZWMHN1cDNUNDFmRytKZUJHM0d1blBwZjNwRWcxcU41NkJR?=
 =?utf-8?B?Z2N5NmVhcVFMQ1RKTmFrK1VOZXM3N3N4ZkZjMjhSZFgyZTNWdjJWaDJoMm1w?=
 =?utf-8?B?dU10akJxMnJrK1FRTVV4dUQ3WnNDRkF1TGY0OTZPU0hjOGJFelJVSFF4RUJX?=
 =?utf-8?B?ZHRVQkRjdkxnUDJLa0NKeTE1Ymx4bXBEWFpha2d5bXNTT2x3aWMyaHVVVFI1?=
 =?utf-8?B?eVpPa1BwMjZGRSs5ZlJOR0N5bEdrNmJQWEZ3NU12RUdZbFNLYVltM3o3UWxN?=
 =?utf-8?B?RmViNWo4dTRzQWFHZGVDS3Yvc0FBSllKRjl3ZUhxblhraHZ3RG84V2x4OWlE?=
 =?utf-8?B?OEhHdlNtMFZzYU9VMXlJUkRZT3V2U1NwRFhkSnR0Rit0bTlyNU1ZUVBoYmZq?=
 =?utf-8?B?Nndqb0x5RkFBZXdvUmJxVWZYOUZJenhzTzNBM1ZvRGpaL2JrMUQwS2QzdmxG?=
 =?utf-8?B?WURBSWxZYWVOVmw5ZzJxNzBxeWhXcWM2cjZ3VEppRllPWWhsN1c1MkE2dS93?=
 =?utf-8?B?Tkl5SHdYNTFNSDJydEhPMG4xa2xQT21Vbm9Dd2kramR4dnUyYTErMmZrLzNL?=
 =?utf-8?B?RXFaWUZDWDhYV2ZTTXhSNXFHdDRUSDNQQW5ObElBamZUdGlVUS8ydEFhczJ2?=
 =?utf-8?B?MG96VnNaeEgyYWwzamtNQ1BiTDEvTTY2dXNQdVJDbzlmRytqckIva1VzcGpZ?=
 =?utf-8?B?QWtlUnZZTEZwY211YmVVM29YbE5qeWJ2MStWTVZ6bmZHcFA4eUQ1djlvZ0h3?=
 =?utf-8?B?VzIyNXRZQlpxNkxuWVdsdXR5YldPK2M5elRBc2liV2VhWmE1RUNTSGQ1QitE?=
 =?utf-8?B?VGlGZVlDMHY5RTdMNGlTbTlSQmwzSk92SzBSQXlBWGZtditkbEVJU2MyVjA2?=
 =?utf-8?B?aWpNWTVnTTc2aU9GeDA2TU5lQktmam5yYVZtRGwzcUFwMnpDWU0zQWlVZW5E?=
 =?utf-8?Q?f3tjmSVnmezkB9NqCEVmOcfAndonhtKVVB?=
x-microsoft-antispam-prvs: <DB3PR0402MB377139A0D8449F3A9F9B8624F57F0@DB3PR0402MB3771.eurprd04.prod.outlook.com>
x-forefront-prvs: 09565527D6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(366004)(376002)(39860400002)(396003)(13464003)(189003)(199004)(105586002)(7736002)(53936002)(446003)(486006)(7416002)(6636002)(97736004)(66066001)(26005)(476003)(11346002)(33656002)(74316002)(305945005)(71190400001)(106356001)(71200400001)(8936002)(81156014)(8676002)(2501003)(81166006)(44832011)(53546011)(6506007)(186003)(102836004)(7696005)(2906002)(6116002)(14454004)(9686003)(5660300002)(6246003)(6306002)(68736007)(2201001)(14444005)(966005)(110136005)(229853002)(316002)(86362001)(6436002)(99286004)(76176011)(55016002)(256004)(3846002)(4326008)(25786009)(478600001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3771;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HOk7cZ2vI+9vs1xb6UwMe6fLpbDqiLioBv3P9ZAlWstZiUWGopDtSx+rT1aKAJM3sWVRzq0p8YHPHfQQ37NQhm/+ectVypp5z1Q9XSgbW4R2AO7TT1jZhhUIWRBEfvjNKg0ZXR9xpPU7dTAaVpgq/bWoVVlbaQxMhLoxknjGODUhxdqGrdp5U0jKuuX3OBfIFku62K/1nW/Ps0L3fQ7j5ynLIOXHg6iyWQC1OMg395+c+RwbzvK463bqI6+2+6JAGuD7C7Ow3P+lKWD32Y+FJ2O1XKNtDmL12WvP4rbeYuAhC202OP8F9NHPtWvF4d+Ccg9w4nco2SVdEGtpk9/jj6+ze1npcJ5OPvQGWv00t0Xcdb9mQ95jKcTgcN5dW+qKyNvoxH36ZBWheLVHCB+MGQu/2pN+64jo7tdFsiJrADE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2ac5572-459a-4c8b-51c5-08d6986e3d9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2019 02:34:16.5766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3771
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFN0ZXBoZW4NCg0KQmVzdCBSZWdhcmRzIQ0KQW5zb24gSHVhbmcNCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdGVwaGVuIEJveWQgW21haWx0bzpzYm95ZEBrZXJu
ZWwub3JnXQ0KPiBTZW50OiAyMDE55bm0MuaciDIy5pelIDQ6NDgNCj4gVG86IGRldmljZXRyZWVA
dmdlci5rZXJuZWwub3JnOyBmZXN0ZXZhbUBnbWFpbC5jb207DQo+IGtlcm5lbEBwZW5ndXRyb25p
eC5kZTsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC0NCj4gY2xr
QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbWFyay5ydXRs
YW5kQGFybS5jb207DQo+IG10dXJxdWV0dGVAYmF5bGlicmUuY29tOyByb2JoK2R0QGtlcm5lbC5v
cmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7DQo+IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHZpcmVz
aC5rdW1hckBsaW5hcm8ub3JnOyBBaXNoZW5nIERvbmcNCj4gPGFpc2hlbmcuZG9uZ0BueHAuY29t
PjsgQW5zb24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5jb20+OyBEYW5pZWwNCj4gQmFsdXRhIDxk
YW5pZWwuYmFsdXRhQG54cC5jb20+DQo+IENjOiBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAu
Y29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFY0IDIvMl0gY2xrOiBpbXg6IHNjdTogYWRkIGNw
dSBmcmVxdWVuY3kgc2NhbGluZyBzdXBwb3J0DQo+IA0KPiBRdW90aW5nIEFuc29uIEh1YW5nICgy
MDE5LTAyLTEzIDE3OjU0OjA4KQ0KPiA+IE9uIE5YUCdzIGkuTVggU29DcyB3aXRoIHN5c3RlbSBj
b250cm9sbGVyIGluc2lkZSwgQ1BVIGZyZXF1ZW5jeQ0KPiA+IHNjYWxpbmcgY2FuIE9OTFkgYmUg
ZG9uZSBieSBzeXN0ZW0gY29udHJvbGxlciBmaXJtd2FyZSwgYW5kIGl0IGNhbg0KPiA+IE9OTFkg
YmUgcmVxdWVzdGVkIGZyb20gc2VjdXJlIG1vZGUsIHNvIExpbnV4IGtlcm5lbCBoYXMgdG8gY2Fs
bCBBUk0NCj4gPiBTTUMgdG8gdHJhcCB0byBBUk0tVHJ1c3RlZC1GaXJtd2FyZSB0byByZXF1ZXN0
IHN5c3RlbSBjb250cm9sbGVyDQo+ID4gZmlybXdhcmUgdG8gZG8gQ1BVIGZyZXF1ZW5jeSBzY2Fs
aW5nLg0KPiA+DQo+ID4gVGhpcyBwYXRjaCBhZGRzIGkuTVggc3lzdGVtIGNvbnRyb2xsZXIgQ1BV
IGZyZXF1ZW5jeSBzY2FsaW5nIHN1cHBvcnQsDQo+ID4gaXQgcmV1c2VzIGNwdWZyZXEtZHQgZHJp
dmVyIGFuZCBpbXBsZW1lbnQgdGhlIENQVSBmcmVxdWVuY3kgc2NhbGluZw0KPiA+IGluc2lkZSBT
Q1UgY2xvY2sgZHJpdmVyLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFu
c29uLkh1YW5nQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gQ2hhbmdlcyBzaW5jZSBWMzoNCj4gPiAg
ICAgICAgIC0gdXNlIGRpZmZlcmVudCBjbGsgb3BzIGZvciBDUFUgY2xvY2sgdG8gYXZvaWQgcnVu
dGltZSBjaGVjayBpbg0KPiBjbGtfc2V0X3JhdGU7DQo+ID4gICAgICAgICAtIHVzZSByc3JjX2lk
IHRvIGRldGVybWluZSB3aGV0aGVyIGl0IGlzIENQVSBmcmVxdWVuY3kgY2hhbmdlIGFuZCBhbHNv
DQo+IHRvIGdldA0KPiA+ICAgICAgICAgICBjbHVzdGVyIElEIGZvciBTTUMgY2FsbC4NCj4gDQo+
IFRoaXMgZGlyZWN0bHkgY29uZmxpY3RzIHdpdGggYSBwYXRjaCB0byBhZGQgZ2V0L3NldCBwYXJl
bnQgc3VwcG9ydCBmcm9tDQo+IEFpc2hlbmcgRG9uZy4gQ2FuIHlvdSBwbGVhc2Ugd29yayB0b2dl
dGhlciBhbmQgcmViYXNlIHRoZSBwYXRjaCBvbiB0b3Agb2YNCj4gdGhhdCBwYXRjaCAod2hpY2gg
aXMgaW4gY2xrLW5leHQpIGFuZCByZXNlbmQgdGhpcz8NCg0KSSBoYXZlIHJlc2VudCB0aGUgcGF0
Y2ggc2V0IGJhc2VkIG9uIHRvcCBvZiBjbGstbmV4dCBhbmQgdGVzdGVkIHRoZSBmdW5jdGlvbi4N
ClBsZWFzZSBhcHBseSB0aGlzIHJlc2VudCBwYXRjaCwgaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVs
Lm9yZy9wYXRjaC8xMDgyNTA4NS8NCg0KVGhhbmtzLA0KQW5zb24uDQo=
