Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4899BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04020222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="xCiAy0Xv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393394AbfBNB6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 20:58:37 -0500
Received: from mail-eopbgr80047.outbound.protection.outlook.com ([40.107.8.47]:35370
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729663AbfBNB6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 20:58:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfEPbafiW1hSJjNQ3vriLGRd0uFScb3UaNkjdkVYeeo=;
 b=xCiAy0XvhjwTNncHpBggIQY0+pVTYMRPEN3KOMhopbqduWesxoaOLD03Gxt1x4M96mMzvsO4uyuemXVNCu+E/l2Qp5moMsoCl3K8nVUt5aDSlaA37bGphmtMwJ5juBs32LRw64ubpC7nindBdbpxW4ebqu8Cn4si6G9xle4qvyM=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3850.eurprd04.prod.outlook.com (52.134.65.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Thu, 14 Feb 2019 01:58:30 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Thu, 14 Feb 2019
 01:58:30 +0000
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
Subject: RE: [PATCH V3 2/2] clk: imx: scu: add cpu frequency scaling support
Thread-Topic: [PATCH V3 2/2] clk: imx: scu: add cpu frequency scaling support
Thread-Index: AQHUw7Ub4OqO1UkLH067EH1cbtXa4KXd/7AAgACJOUA=
Date:   Thu, 14 Feb 2019 01:58:30 +0000
Message-ID: <DB3PR0402MB39161EBE454F4095C275CFF0F5670@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1550073243-11242-1-git-send-email-Anson.Huang@nxp.com>
 <1550073243-11242-2-git-send-email-Anson.Huang@nxp.com>
 <155007977634.115909.4465011219844819801@swboyd.mtv.corp.google.com>
In-Reply-To: <155007977634.115909.4465011219844819801@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3bc3d09-779e-4f2a-cf5c-08d6921feb16
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3850;
x-ms-traffictypediagnostic: DB3PR0402MB3850:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtEQjNQUjA0MDJNQjM4NTA7MjM6UUc2djcyWUh1SFcwOXZlU2hmVlZ2WUhj?=
 =?utf-8?B?Tnc4L1JKNENIWjRPdUc4aFZCVUhIM1B0U3IrZ3l4K3UvRVNlME1GMk5sVFky?=
 =?utf-8?B?WU84bjhnQ0JoQloxY0tIQTJIK2lPZ2NzcUQwdlhnUllUNTJtZjNQMHdaS1BW?=
 =?utf-8?B?S0xPRWNsdloxU2pUSWNRbldGOFN5MHROenQ2Nmh0cnZhN2QvaGtWQmdEUUJ4?=
 =?utf-8?B?aHR3T3hhUGU1aURlMnNPUFd4a3lMTnVCT0ZxRWdGNzMzK1BlYndHTStzSi9I?=
 =?utf-8?B?Q2gvUm9XZ1JrQk01WGtBQUwwT0U5Z2FMREdJK0k2WGV3MENtbTI4YjU5Y3ZY?=
 =?utf-8?B?U0ZyNXJwRzEwdjdjZkJCM3VkSzZDRWNkblh6ZmJWdVpOUGJDMkxEZFRET3d4?=
 =?utf-8?B?MzB4SWZOM0JkdW5xSHZkSWJPUW5zZXl4Si9UbjdXYkRycStSQ2ZwL04zWXNS?=
 =?utf-8?B?K0hZMnJuUjZ3ekVUWVhXTEJhVXFoSC9LQjNnS29QeGgxL0VUUktJOTlHOWhR?=
 =?utf-8?B?UHNkd2txeGNDakRVOTZXb013c2R2K1FoZGxZaGdhSi9iU3FwNU5BZG8reXFS?=
 =?utf-8?B?elBkRVFrKzh5QnlhUTk0YkZWYkxpczVBRWVGc2pNbEh6UlBmZ01kVldSSGJM?=
 =?utf-8?B?OXFTKzBZbXhDSVd3NDhUcHBETmh1anprWGdiTndBUHlTa0xrVjh2VlRJd0Iw?=
 =?utf-8?B?VHNsS1hlaHBQZVMvSXBNQmwybVZrYXRIcWk3TUVHMWI1YlhxcGV6T09VZWZx?=
 =?utf-8?B?aVAySzRzNStIUi9VcHVjcTY2N2FkUHc4alR1UnEvYk9tOEhVYWwyTXdSQTBu?=
 =?utf-8?B?OHFQb0xUd3JGSFp1eVBxa1JjN0F3NmU1dVVzdkhNQkZwV3Y5YXdjYUlzM2Rp?=
 =?utf-8?B?Zk1BUTl0YVdweGNlbzdLazV6RDEwelErQkpGbVBhK0g5bDVSY0lqTXF3Umx3?=
 =?utf-8?B?cWFpb1hjV01idU5iQjlJUmZaUkNJTFpDeXRlazlrK3lEeXlOTm9ydWdZNXpV?=
 =?utf-8?B?UUZJTzczdnQwT1BBRld1Y0pmdHNWYWRZOVE0ZXQrYU8yRENDTDRaTjg0QU51?=
 =?utf-8?B?Z1FPY3pQUkRJZTRHdjU0S2svSUphdFVDU2FOVzNQbituYWlXV3R1aWtWd2F4?=
 =?utf-8?B?SWIzeENWb2JPNTBoY0J1WithK0NsYVg4V3Rpc3p5d3dHUks3V2tGTlVobENm?=
 =?utf-8?B?clVQSU4zakRBQytQTzVRekhBWVJsT0ZCZEVpRTdkbmhUUkt3V3VEYmMvTHNX?=
 =?utf-8?B?VXZjMDU4amllb3ErOHJVb1UrTkNEQTNVTFJpaGxwUFo0akVNOW5EdUs5RDcz?=
 =?utf-8?B?b2J3V3B1dkxMeE1mVjFBLzNWZVdUK0orWDY4QlVjM3Y5ZFNBMGJmWmZTeEFi?=
 =?utf-8?B?bCtndzZuUFAyZGRaT2FuWVJ1R1FGNzh2ZmxjYmNqbHB4VVFobHllMThrb0pI?=
 =?utf-8?B?WGR3cjRhNkhEdThsQnowY1I2Wi8zbmNXZjN4YXZvOHArNW93SGl4bGdreXRt?=
 =?utf-8?B?Qzd6SEo4YURDM1R1clM1eTVtV2p4aVlIU3IyMEVtYUxSTjduY2h6QXQzK2Z3?=
 =?utf-8?B?Y240WkV0am9qdEg3QS9tTUc5djErdXVsWGxzU2pZTEZFTE5xdmtrcWE0QVdv?=
 =?utf-8?B?VVV0NUV1Z3hEVHh3SFl6MW16NG9meEZUN0J4aFlwM05VZXZLbzZLWXdxUStk?=
 =?utf-8?B?V1YxUGRjWk1Jc1Vob3lMZ3g0N1VjbnQ5NDBxV1pRR2F1UkpxcFBBTnA3Zkox?=
 =?utf-8?Q?uqyT5PF7ptmo7uXHbYcZxt0ZYAtv5IGDTfztVy8=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB3850C3CB8A694DB9BA782BEDF5670@DB3PR0402MB3850.eurprd04.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(366004)(376002)(39860400002)(396003)(13464003)(199004)(189003)(256004)(71190400001)(76176011)(229853002)(7696005)(6506007)(7416002)(6636002)(99286004)(55016002)(53546011)(9686003)(6436002)(2501003)(4326008)(26005)(71200400001)(14454004)(102836004)(478600001)(305945005)(2906002)(2201001)(105586002)(3846002)(486006)(81166006)(11346002)(476003)(97736004)(66066001)(106356001)(7736002)(86362001)(186003)(8676002)(33656002)(53936002)(74316002)(6246003)(110136005)(44832011)(8936002)(316002)(81156014)(68736007)(446003)(25786009)(6116002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3850;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +y5b8YYYsdYSbTFQm+kpWabulHvogJpxsJN+GvutDiccnuMX7K8A2KXE7NLTsTRB8YnXHw0Bwtr51toCHk7UjRpzgyrh95RoJv4l6TdCyQ93MBZUGEJc7Kl15x+8cxZXaPsW5yOGW4vYexFDW7/XLiOOH1DProfO8njrsps/eCyZWWOKgG75EGnuuL6OQqgAqws5o6+TJWaeYZxSv6XZS21SNfdkn/zSY0jc4uP9eTG05eJbp3LfxcmXVmul5xDJGnBgU57Y74hWJdIX5RrCD3OgCEfJArxAvmkKTjX+zylN5fiL3d4MFowBBEU5xKoWzmoYbeznW3JosJVPJiSSyr820ZGFg6l8v0ylwHeUEreZUgI6JV3/KT18CDGFNTO3jKMMz+azbpY34qDll+dvGhOKFfI2otLa9329niqqrBw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3bc3d09-779e-4f2a-cf5c-08d6921feb16
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 01:58:30.4165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3850
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkJlc3QgUmVnYXJkcyENCkFuc29uIEh1YW5nDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gRnJvbTogU3RlcGhlbiBCb3lkIFttYWlsdG86c2JveWRAa2VybmVsLm9yZ10NCj4g
U2VudDogMjAxOeW5tDLmnIgxNOaXpSAxOjQzDQo+IFRvOiBkZXZpY2V0cmVlQHZnZXIua2VybmVs
Lm9yZzsgZmVzdGV2YW1AZ21haWwuY29tOw0KPiBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGxpbnV4
LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtDQo+IGNsa0B2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IG1hcmsucnV0bGFuZEBhcm0uY29t
Ow0KPiBtdHVycXVldHRlQGJheWxpYnJlLmNvbTsgcm9iaCtkdEBrZXJuZWwub3JnOyBzLmhhdWVy
QHBlbmd1dHJvbml4LmRlOw0KPiBzaGF3bmd1b0BrZXJuZWwub3JnOyB2aXJlc2gua3VtYXJAbGlu
YXJvLm9yZzsgQWlzaGVuZyBEb25nDQo+IDxhaXNoZW5nLmRvbmdAbnhwLmNvbT47IEFuc29uIEh1
YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPjsgRGFuaWVsDQo+IEJhbHV0YSA8ZGFuaWVsLmJhbHV0
YUBueHAuY29tPg0KPiBDYzogZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCBWMyAyLzJdIGNsazogaW14OiBzY3U6IGFkZCBjcHUgZnJlcXVlbmN5
IHNjYWxpbmcgc3VwcG9ydA0KPiANCj4gUXVvdGluZyBBbnNvbiBIdWFuZyAoMjAxOS0wMi0xMyAw
Nzo1OTozMikNCj4gPiBAQCAtMTQ1LDYgKzE2MSwzOSBAQCBzdGF0aWMgbG9uZyBjbGtfc2N1X3Jv
dW5kX3JhdGUoc3RydWN0IGNsa19odyAqaHcsDQo+IHVuc2lnbmVkIGxvbmcgcmF0ZSwNCj4gPiAg
ICAgICAgIHJldHVybiByYXRlOw0KPiA+ICB9DQo+ID4NCj4gPiArc3RhdGljIGJvb2wgY2xrX3Nj
dV9hdGZfc2V0X2NwdV9yYXRlKHN0cnVjdCBjbGtfaHcgKmh3LCB1bnNpZ25lZCBsb25nDQo+ID4g
K3JhdGUpIHsNCj4gPiArICAgICAgIHN0cnVjdCBjbGtfc2N1ICpjbGsgPSB0b19jbGtfc2N1KGh3
KTsNCj4gPiArICAgICAgIHN0cnVjdCBhcm1fc21jY2NfcmVzIHJlczsNCj4gPiArICAgICAgIHVu
c2lnbmVkIGludCBjbHVzdGVyX2lkOw0KPiA+ICsgICAgICAgaW50IGk7DQo+ID4gKw0KPiA+ICsg
ICAgICAgLyogQ1BVIGZyZXF1ZW5jeSBzY2FsaW5nIGNhbiBPTkxZIGJlIGRvbmUgYnkgQVJNLVRy
dXN0ZWQtRmlybXdhcmUNCj4gKi8NCj4gPiArICAgICAgIGlmIChjbGstPmNsa190eXBlID09IElN
WF9TQ19QTV9DTEtfQ1BVKSB7DQo+ID4gKyAgICAgICAgICAgICAgIGZvciAoaSA9IDA7IGkgPCBB
UlJBWV9TSVpFKGlteF9zY19jcHVmcmVxX2RhdGEpOyBpKyspIHsNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICBpZiAoIXN0cmNtcChjbGtfaHdfZ2V0X25hbWUoaHcpLA0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgaW14X3NjX2NwdWZyZXFfZGF0YVtpXS5jbGtfbmFtZSkp
IHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNsdXN0ZXJfaWQgPSBpbXhf
c2NfY3B1ZnJlcV9kYXRhW2ldLmNsdXN0ZXJfaWQ7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBicmVhazsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICB9DQo+ID4gKyAg
ICAgICAgICAgICAgIH0NCj4gDQo+IElzIHRoZXJlIHNvbWUgcmVhc29uIHdoeSB0aGVzZSBjbGtz
IGNhbid0IGJlIGRldGVybWluZWQgb25jZSBhdCBib290IHRpbWU/DQo+IEl0IHdvdWxkIGJlIGEg
Z29vZCBpZGVhIHRvIGF2b2lkIGRvaW5nIGFueSBzb3J0IG9mIHN0cmluZyBjb21wYXJpc29uIGhl
cmUsDQo+IGluc3RlYWQganVzdCBjYWxsaW5nIHRoZSByaWdodCBhcm1fc21jY2Nfc21jIHdpdGgg
dGhlIHJpZ2h0IGFyZ3VtZW50cyBiYXNlZA0KPiBvbiBjb2RlIHRoYXQgcmVnaXN0ZXJzIHRob3Nl
IHR5cGVzIG9mIGNsa3MuDQoNCkFncmVlLCBJIGNhbiBhdm9pZCBzdHJpbmcgY29tcGFyaXNvbiBp
biBydW50aW1lLCBpbiBWNCBwYXRjaCBJIGp1c3Qgc2VudCwgSSBhZGQgYW5vdGhlcg0KY2xrIG9w
cyBmb3IgQ1BVIGNsb2NrLCBhbmQgdXNlIHJlc291cmNlIElEIHRvIGRldGVybWluZSB0aGUgQ1BV
IGNsayBvcHMgYW5kIGNsdXN0ZXIgaWQsDQp0aHVzIHdlIGNhbiBzYXZlIHRoZSBydW50aW1lIGNo
ZWNrIGFuZCBzdHJpbmcgY29tcGFyaXNvbi4NCg0KVGhhbmtzLA0KQW5zb24uDQoNCg==
