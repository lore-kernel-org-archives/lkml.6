Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AD9C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 06:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C46C4206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 06:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bT96RHMd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C46C4206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbeJLONu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 10:13:50 -0400
Received: from mail-eopbgr70083.outbound.protection.outlook.com ([40.107.7.83]:53492
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727056AbeJLONu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 10:13:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4xNee47/Y13EsSrHGyGLAw8OMx9/NmVOqGbvl9Z2LA=;
 b=bT96RHMdnLupNPsyL5FWjz/nnAE3vikNndtLvcQ4W2N/vevOYyLvqhoTbQaBjZePpi44PC3v2t/T+KRWtX3XWnvLE2gOn00GVsN7vREO1e0bl9gA9deUPypgR25txaXeJloaSCe331Cs88xNyKhzmuuOr5ikT+nzaVkOd00y7N0=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3659.eurprd04.prod.outlook.com (52.134.66.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.23; Fri, 12 Oct 2018 06:42:05 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5c30:b387:c71a:7071]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5c30:b387:c71a:7071%2]) with mapi id 15.20.1228.020; Fri, 12 Oct 2018
 06:42:05 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] thermal: imx: improve error message
Thread-Topic: [PATCH 1/2] thermal: imx: improve error message
Thread-Index: AQHUS2fDDgOCVSUxtEuXx9Y8c/3aYqUbVnTQ
Date:   Fri, 12 Oct 2018 06:42:05 +0000
Message-ID: <DB3PR0402MB3916867EF2740736050170CAF5E20@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1536829986-23702-1-git-send-email-Anson.Huang@nxp.com>
 <3ef674ab-6152-dc77-6c5e-5d5d23642a9f@linaro.org>
In-Reply-To: <3ef674ab-6152-dc77-6c5e-5d5d23642a9f@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3659;6:dguYBdxTgJagS1209KdnK/64hLN+v4SS0mhthNCK/fQGydBTu5SxdholjehpH8b63nThueAB60MpdO4WUENhoQZyEZyOqMJDb2iXhd3QgN8orqvyDxDcB+GkOtSR6qhSLIepK4VSTdaS+NkTibrrPoowa1xQ4Kv/N+HWL4u4GGph8etkp2B9JGXyfkTa0jq/Tkr4cQxfa9aSZpIzKU//WsMro4w9AXFRy0DwFz1YPkn98GLb/D0JoGK8zvdc3Yfjg1ktQ6uBJvy8aV+brlmG9YxKHUxunEK8JA8EuXVrncPLdx8rVZPysGX+qt6+Jcd5oaYfMB7T3j7hwWYMo/peNb2QoPv051VMuT/VBlAC54BxCNkzQz+OR0KPkVy6CFeC8KZPDQ4Y/vhpEAMiSD7fT47wOIRCzpSwTjRo4BUsHdvz8Bdt9DUPtvuSt1z1uxP8jVg/CzQL20sykRcPsuXEZA==;5:8Aoqvt0wNBU71PFWcVaM8xhlaPD4okW9abrfEYOWbQy1HRAexQ/pklZ8huaRPPfADFEnkwWCPFrszPftbU4565j1KjAXTA1hVnK1DKn2ctHqQYLdUHt5LDFZ0g5SoPazrgTzRV1YUN2S+jkWtNFSsKNNRK0ITwMDiOkPGmTuSno=;7:yYYnc4zGz9XP2SYk3nC6P3o/PR0ieN1EGI1AfhbmnRcINiSktbbkFkBPbrbITxuSQ4SEgpuDbKmCzgaWBqbNgCbW68tW3EdypNUw3YFOGXrwChd1CJR5BMavYFhgaNgyZxl5OBFdd3hQauMHiQCJwB+JIS/7lduhaP+a8j724o/eAINt2+OgIQSvT3dSp2Ds/4aIznmDqUBGxoneGOmih+FP0VdiYq1/CmV3NRBLxo/v3ed2qPGtoaiMOfetd+n8
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 622dcf8e-7e14-4169-1300-08d6300dd341
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3659;
x-ms-traffictypediagnostic: DB3PR0402MB3659:
x-microsoft-antispam-prvs: <DB3PR0402MB36594D6940A5E1E25ABA8537F5E20@DB3PR0402MB3659.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(85827821059158)(9452136761055)(64217206974132)(185117386973197)(81227570615382)(148322886591682)(45079756050767)(189930954265078);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991067);SRVR:DB3PR0402MB3659;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3659;
x-forefront-prvs: 0823A5777B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(376002)(346002)(136003)(13464003)(199004)(189003)(8936002)(2900100001)(11346002)(575784001)(86362001)(229853002)(106356001)(71190400001)(71200400001)(2201001)(256004)(44832011)(25786009)(39060400002)(476003)(81156014)(8676002)(7736002)(81166006)(478600001)(66066001)(6306002)(6436002)(2501003)(486006)(5250100002)(446003)(53936002)(6246003)(9686003)(55016002)(110136005)(6506007)(76176011)(5660300001)(3846002)(2906002)(33656002)(68736007)(26005)(305945005)(102836004)(14454004)(186003)(7696005)(15650500001)(53546011)(6116002)(97736004)(99286004)(105586002)(74316002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3659;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: l+O0fPqSB0LmXMYNfWkQTk3YQiAMBpeIAbsp8szwElidcmWcHN/dK1YgSVVuuqG4UXs9I6XTOtl7kNhTHkZ9cSTvY+kZzAwgcU5qNmxR8cxbo9WhIa7wPPrZTS2j+YTjuijwVKolpUS3IhxuYksNUbEbrEs1iDKLskc23lgYp6fB47AKG6AkHTzHZeYo9LVP6S+lrzsXbQIdFAjY4afMo73GIiO7lu8YT63FjHWjN86OnqmDffdJdVN6Bc3qsAm9WWt40MP8JzR0zm/tJ0JJjHVTCvDGEIDXL1a642xPk183u2t6B+QMoKUtTJ9x49KkWKD8EqQqTwBsHyCBqTaURYG4Wg4urZCbnUxccqXcYes=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 622dcf8e-7e14-4169-1300-08d6300dd341
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2018 06:42:05.5428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3659
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R2VudGxlIHBpbmcgdGhpcyBwYXRjaCBzZXQuLi4uDQoNCkFuc29uIEh1YW5nDQpCZXN0IFJlZ2Fy
ZHMhDQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYW5pZWwgTGV6
Y2FubyA8ZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZz4NCj4gU2VudDogVGh1cnNkYXksIFNlcHRl
bWJlciAxMywgMjAxOCA5OjQzIFBNDQo+IFRvOiBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhw
LmNvbT47IHJ1aS56aGFuZ0BpbnRlbC5jb207DQo+IGVkdWJlenZhbEBnbWFpbC5jb207IGxpbnV4
LXBtQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIDEvMl0gdGhlcm1hbDogaW14OiBpbXByb3ZlIGVycm9yIG1lc3Nh
Z2UNCj4gDQo+IE9uIDEzLzA5LzIwMTggMTE6MTMsIEFuc29uIEh1YW5nIHdyb3RlOg0KPiA+IFJl
bW92ZSB0aGUgZHVwbGljYXRlZCAiZnJvbSIgdG8gaW1wcm92ZSB0aGUgZXJyb3IgbWVzc2FnZS4N
Cj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29t
Pg0KPiA+IC0tLQ0KPiANCj4gUmV2aWV3ZWQtYnk6IERhbmllbCBMZXpjYW5vIDxkYW5pZWwubGV6
Y2Fub0BsaW5hcm8ub3JnPg0KPiANCj4gLS0NCj4gDQo+IDxodHRwczovL2VtZWEwMS5zYWZlbGlu
a3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHAlM0ElMkYlMkZ3d3cNCj4gLmxpbmFy
by5vcmclMkYmYW1wO2RhdGE9MDIlN0MwMSU3Q0Fuc29uLkh1YW5nJTQwbnhwLmNvbSU3Qzc0YjBl
Mw0KPiA2OWRlYTQ0MmNkMjNjYTA4ZDYxOTdlZTUxOCU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5
YzVjMzAxNjM1JTdDDQo+IDAlN0MwJTdDNjM2NzI0NDMwMTI5Nzg5MDEzJmFtcDtzZGF0YT1DOWw4
UUZ0NThZSlZvNXBydndITnFTaU9QNQ0KPiA0b3BVTVBHT2Z6eVY0UFpGQSUzRCZhbXA7cmVzZXJ2
ZWQ9MD4gTGluYXJvLm9yZyDilIIgT3BlbiBzb3VyY2UNCj4gc29mdHdhcmUgZm9yIEFSTSBTb0Nz
DQo+IA0KPiBGb2xsb3cgTGluYXJvOg0KPiA8aHR0cHM6Ly9lbWVhMDEuc2FmZWxpbmtzLnByb3Rl
Y3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwJTNBJTJGJTJGd3d3DQo+IC5mYWNlYm9vay5jb20l
MkZwYWdlcyUyRkxpbmFybyZhbXA7ZGF0YT0wMiU3QzAxJTdDQW5zb24uSHVhbmclNDANCj4gbnhw
LmNvbSU3Qzc0YjBlMzY5ZGVhNDQyY2QyM2NhMDhkNjE5N2VlNTE4JTdDNjg2ZWExZDNiYzJiNGM2
ZmE5Mg0KPiBjZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2MzY3MjQ0MzAxMjk3ODkwMTMmYW1wO3Nk
YXRhPVNxZkdmNmE0bg0KPiBNUXZPNWR2QWpoWFBreEpSS3habTklMkZPMzdMTHg4bkJtSjQlM0Qm
YW1wO3Jlc2VydmVkPTA+DQo+IEZhY2Vib29rIHwNCj4gPGh0dHBzOi8vZW1lYTAxLnNhZmVsaW5r
cy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cCUzQSUyRiUyRnR3aXR0DQo+IGVyLmNv
bSUyRiUyMyElMkZsaW5hcm9vcmcmYW1wO2RhdGE9MDIlN0MwMSU3Q0Fuc29uLkh1YW5nJTQwbnhw
LmMNCj4gb20lN0M3NGIwZTM2OWRlYTQ0MmNkMjNjYTA4ZDYxOTdlZTUxOCU3QzY4NmVhMWQzYmMy
YjRjNmZhOTJjZDk5DQo+IGM1YzMwMTYzNSU3QzAlN0MwJTdDNjM2NzI0NDMwMTI5Nzg5MDEzJmFt
cDtzZGF0YT1lT2YybnZDZEpFcm1WDQo+IHJhMTJ1eGxaNDJMRmpqcnlIQTN1NEJxbUVGaEFwRSUz
RCZhbXA7cmVzZXJ2ZWQ9MD4gVHdpdHRlciB8DQo+IDxodHRwczovL2VtZWEwMS5zYWZlbGlua3Mu
cHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHAlM0ElMkYlMkZ3d3cNCj4gLmxpbmFyby5v
cmclMkZsaW5hcm8tYmxvZyUyRiZhbXA7ZGF0YT0wMiU3QzAxJTdDQW5zb24uSHVhbmclNDBueHAu
Yw0KPiBvbSU3Qzc0YjBlMzY5ZGVhNDQyY2QyM2NhMDhkNjE5N2VlNTE4JTdDNjg2ZWExZDNiYzJi
NGM2ZmE5MmNkOTkNCj4gYzVjMzAxNjM1JTdDMCU3QzAlN0M2MzY3MjQ0MzAxMjk3ODkwMTMmYW1w
O3NkYXRhPVZjcTJDWjNXdXR6NloNCj4geFE3N3Rwb3czMFgydyUyRlZzbWo0M3lsMU01M0djV1Ul
M0QmYW1wO3Jlc2VydmVkPTA+IEJsb2cNCg0K
