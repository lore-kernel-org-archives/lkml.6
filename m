Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978A2C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 00:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57B03222A1
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 00:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PBQX1CH4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404465AbfBPAlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 19:41:35 -0500
Received: from mail-eopbgr80071.outbound.protection.outlook.com ([40.107.8.71]:37696
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726145AbfBPAle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 19:41:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGW2QSoxAkkmmfAPnkgRuuG+Z4Ikwr9HJxsBIlLRb/I=;
 b=PBQX1CH4ZTaTzTJY05u80cy1gNXp05kGScBMbGb31gRyZJwK32Xna9f3bu5xw/J5/KSrovPf+dSNggHPPTUXy/KfcaqgsMVCC/JbdO6f4DRUHnnRj9+0vKveI8sIpWqrfd7l2P59zM7fV8y8UKv/13x5ctYyei0NoVrh1MynHQI=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3641.eurprd04.prod.outlook.com (52.134.69.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Sat, 16 Feb 2019 00:41:24 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Sat, 16 Feb 2019
 00:41:24 +0000
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
Thread-Index: AQHUxAgs8uuWj5mH40eZScOWTh4AP6XhjI6AgAALrrA=
Date:   Sat, 16 Feb 2019 00:41:24 +0000
Message-ID: <DB3PR0402MB3916D80AEC3CEEC6F6A8C394F5610@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1550108915-574-1-git-send-email-Anson.Huang@nxp.com>
 <1550108915-574-2-git-send-email-Anson.Huang@nxp.com>
 <155027509324.115909.9001648696808985832@swboyd.mtv.corp.google.com>
In-Reply-To: <155027509324.115909.9001648696808985832@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [183.192.23.231]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da178b89-5e7d-456a-a5c3-08d693a77a88
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3641;
x-ms-traffictypediagnostic: DB3PR0402MB3641:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtEQjNQUjA0MDJNQjM2NDE7MjM6MEQ0OTlqWU10cmhWbEt5RWZTWndQN3pL?=
 =?utf-8?B?NzVCODdQem90bEsxSW5uNTZUNmR6Z1ZrT2diSlBhY3JZTERsMytDOThaYVJv?=
 =?utf-8?B?TGJ3cFdBQUNIWlpINFNwUFlUTmJNNmFYRlRUZEVzajltK25BQkg4dDFpU0Zn?=
 =?utf-8?B?bElyK3JlRFdvL0lMSnFJYjhZa3lZek1oOC9zaCtRVkQ1Sis2N3lXUkxVVXVr?=
 =?utf-8?B?TmczY1pQZnNXZDBmdlRRVjhOdUxhVGErdDNYcnZabnloT2VKclRmeGFYSTho?=
 =?utf-8?B?WlZXNWhNZkk4VWRVT3ZjNk42UXdLOU1WRmErZGJhem1QYXBxdXBjZSswLzVQ?=
 =?utf-8?B?NUFNd2NLSm0xUjFqWURoOEV6elpzaDZ6ZU43VFZMTzRkczJRaG1hT0pDcmZl?=
 =?utf-8?B?aXdnZC9PWFp2bHhLRm5USGV4QVBrNy9kSlJCZFRRRWdtQzVjcGlpS1AxY2Zk?=
 =?utf-8?B?MEp1eXF6eG1uVzV0REl4amNWWFoxbHpXV1BjdFFudnZ5YVcwRHBKeTlNOE8z?=
 =?utf-8?B?bFNuMnJ6L2xucDF2aFQ5eXRWMC80ODVpTG1xSTBJdkJ2N2dwMmo1eW5ic3pi?=
 =?utf-8?B?azFiMzJYMFhYMzlhUDBGN3Z5R2NqdlFvQlU1V0NkZ2VxNHlEdXlVc3VjT0RZ?=
 =?utf-8?B?cGZYbTdMbmFqWStVTHMxZS90S29wTjJ1MkhqRWp3OEZFZzJYSlI5WXhvTEZz?=
 =?utf-8?B?dzlDZm1LZDNhVXhLWHNHR2svWC9aanZOSDBmcjZHbUhOYTBQODhqaE5nVldS?=
 =?utf-8?B?clhIVHovWitVL3hrakdwdlk3aHRHQ0xpa2FzU0pxc3gwRlUzN0ltWmxBZ05M?=
 =?utf-8?B?QkRYZm1WZVdNUmkvcG9QQVV6d21kZ0xaRCtMV0wrUy9rcVVzSkxtZTZvVGJQ?=
 =?utf-8?B?bEpHWGVURGwwUnZ0cy8zM0RKWVRDeXQ3YzhlUFRac1BKYklrQ3JKMXZDK2sx?=
 =?utf-8?B?Ry9YOEJYNEliK0JURUJaUFYyS1M1SXVzcXpGUDc5bkJTZVg0L1lZTUpQOVlh?=
 =?utf-8?B?QXl5cVV1S0RJdWM5cE5FVlpyODV6dGM3b1RlU2hnazdjK1NUVi9vVkQ1NVhy?=
 =?utf-8?B?cC9UK29ZLzlWcDBRQzVpZEJVUDVsMjNHYnNqeFA0WWpiM2xkSXNZRVprK0Yv?=
 =?utf-8?B?aHNwYVNFRVRhOVFuS1NveUV0S21GMWhoOEFwZ1AzWEZmTFRZNHh2d1Nrb3Bx?=
 =?utf-8?B?Mmo0VzV5c1ByVkd3TVB1RC9hTXJyd085MVFlYkh1cVdaMG14aERDS3E0MUw4?=
 =?utf-8?B?V3lHeWh6RHhoQVFBMUxDQTJmTDN0bm81aXY4dkw4RkJzaU5XdHNCeTdQTjlT?=
 =?utf-8?B?YVlBTlZrQWNEbTQzb0F3SFFxc3gzN3VVbSthbS93R21kbEorRTQ3UnRMeHNt?=
 =?utf-8?B?cmVDVVAzcVMxZXBKbHJtamRuUVovTXVta0pQUDlQQkVVRzRQTjkyTU5wcGpJ?=
 =?utf-8?B?NHZTZzY3bVFtd29GaER4aHZMY3ovdWZaOEt0NmtRN3FCdlo2SUlwdXpnbzVl?=
 =?utf-8?B?a0IxT21KVmVyNTdKaFZEY3RBUzVFU0VVaE9GZkRYNHNRS3lDbUdiZWhGbzly?=
 =?utf-8?B?UFl5QzE4NkI5QXJFdTB1OUk1bEZRVU12cUdkUlR2OWZnYW1rL3V4azhjMkFt?=
 =?utf-8?B?YmpBaGtUSTFPNEl3bythOUJwcnpsOW8rWDA1VmlhTU9TOGU2REljZUR5QTkw?=
 =?utf-8?B?QlhqN3JGakhabVE0R2hJazRncEg3TGhaOThnWjUxMUpJU1ZXd3M1YzE3Tm53?=
 =?utf-8?B?S2E1K1RjMjBvaGdhbzVOaTRzdVdhZEJnZEpFRFMrMUJRY0lDRFFZd0NOUU9x?=
 =?utf-8?B?Q0c3YmxFVW9PMi9WUjVaLzBrTnBwdi9IajVBdmViNkFLUVFTdz09?=
x-microsoft-antispam-prvs: <DB3PR0402MB36417BA65DF6A84A769DE5EAF5610@DB3PR0402MB3641.eurprd04.prod.outlook.com>
x-forefront-prvs: 0950706AC1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(396003)(376002)(346002)(199004)(13464003)(189003)(478600001)(25786009)(476003)(44832011)(256004)(7416002)(446003)(68736007)(3846002)(14454004)(66066001)(74316002)(86362001)(2906002)(229853002)(55016002)(7736002)(2501003)(8676002)(11346002)(486006)(2201001)(33656002)(9686003)(305945005)(6116002)(53546011)(76176011)(6436002)(99286004)(14444005)(71200400001)(6246003)(8936002)(81166006)(81156014)(6636002)(53936002)(97736004)(7696005)(102836004)(186003)(316002)(4326008)(110136005)(106356001)(26005)(105586002)(71190400001)(6506007)(5660300002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3641;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: noxpsu9WIhuR4g8z9pOaJONy1hI6lg5b/FXhAiz1IQdGxOO6HJquqIXKoxJzH2Hx01xMK3HAZBhyjMpuDxK13vsRSk33+EvFcgLFOKTPevA4+AKaDnhFAC6EYgn83WgXhEm1Y61TvYdj5qIpWjqg1q9Z9OkgiDhPS4JynQxIA6c8RaZVOaqw2PMi7jt23ks+JL4jPLtvkag4V7UN3jy0R1TZYdjfxMUbJ67AMC7eFShn7o2ENvq+uCiaMvJQpgBNH1AKLKnhEkQ6HGZZxZpNCpXBuzxUAYf9leXWughVuirW1pCHwhpWNiPDP/JdRiPRW0QgOhfR5FIX7KdVGQ2lU7lf+LSIiXl2HrImlZTFPlwUPsG9eNLvJyMfMZdmvJFIWeqG6hAu0c+4cHowaqytLwZYvD/fNTZwol/HaV1/cVM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da178b89-5e7d-456a-a5c3-08d693a77a88
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2019 00:41:24.2840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3641
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFN0ZXBoZW4NCg0KQmVzdCBSZWdhcmRzIQ0KQW5zb24gSHVhbmcNCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdGVwaGVuIEJveWQgW21haWx0bzpzYm95ZEBrZXJu
ZWwub3JnXQ0KPiBTZW50OiAyMDE55bm0MuaciDE25pelIDc6NTgNCj4gVG86IGRldmljZXRyZWVA
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
c29uLkh1YW5nQG54cC5jb20+DQo+ID4gLS0tDQo+IA0KPiBBY2tlZC1ieTogU3RlcGhlbiBCb3lk
IDxzYm95ZEBrZXJuZWwub3JnPg0KPiANCj4gVW5sZXNzIHlvdSB3YW50ZWQgbWUgdG8gcGljayB0
aGlzIHBhdGNoIHVwIGludG8gY2xrLW5leHQ/DQoNClllcywgcGxlYXNlLCB3ZSB3YW50IHRvIHN1
cHBvcnQgY3B1LWZyZXEgc2NhbGluZyBpbiBMaW51eCBuZXh0IHRyZWUgQVNBUC4NCg0KVGhhbmtz
LA0KQW5zb24uDQo=
