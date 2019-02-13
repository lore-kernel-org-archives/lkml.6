Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9F9C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93F99222B6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="tRbUAa8p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390792AbfBMIqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 03:46:55 -0500
Received: from mail-eopbgr50049.outbound.protection.outlook.com ([40.107.5.49]:21205
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730377AbfBMIqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 03:46:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dsm+Kur/qvJ+W8QN6O+dArGhod0R4HG0rTH4y+u21U4=;
 b=tRbUAa8pDs1OvQ/95LYlsNcljXUxRLPu9hW7FNVDwBU+65ShpTTtFdd6EuS8sDfTGn81SeMKdEWWFb3YhzbM6TCcB22WgAy4apVG1DOPSiZu5vsOAbchV5C8KWKTABAl/hWE0NpCNKc2kAZtAmkM5GUaJVCvGpR9pUgtQcUCslg=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3754.eurprd04.prod.outlook.com (52.134.67.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Wed, 13 Feb 2019 08:46:45 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 08:46:45 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        Aisheng Dong <aisheng.dong@nxp.com>,
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
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 3/3] cpufreq: imx-sc: add i.mx system controller cpufreq
 support
Thread-Topic: [PATCH 3/3] cpufreq: imx-sc: add i.mx system controller cpufreq
 support
Thread-Index: AQHUw0mAk7D4InMTwEi38x/B8uOIA6XdT24AgAAaBPA=
Date:   Wed, 13 Feb 2019 08:46:45 +0000
Message-ID: <DB3PR0402MB3916203C35D82A7667DA3A16F5660@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1550027011-7884-1-git-send-email-Anson.Huang@nxp.com>
 <1550027011-7884-3-git-send-email-Anson.Huang@nxp.com>
 <20190213070904.3oswrjafy6cqedsr@vireshk-i7>
In-Reply-To: <20190213070904.3oswrjafy6cqedsr@vireshk-i7>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12f15dc0-2f65-42be-f16c-08d6918fc8ec
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3754;
x-ms-traffictypediagnostic: DB3PR0402MB3754:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?gb2312?B?MTtEQjNQUjA0MDJNQjM3NTQ7MjM6MS9RMUU1c05nSWhQV29Qc0V6eW5ydzA3?=
 =?gb2312?B?cmQ1THNwZWFUMjR1OHl0b1RUQUVQV1BQb2t0YjJiamRCQlFwNHlYb1o5WkRq?=
 =?gb2312?B?MWd3d0ZyaXM1QnJzSGszZDRJRkdjS1ZEeE1oT1A1bmswMmFETXRpUElyY244?=
 =?gb2312?B?VVg1dERBUk9vb3U1YmxNTWYxL0tQZ08ya3Z4UUo1Q21xODY0QjRNSHNhYXlI?=
 =?gb2312?B?T2ZMVWw5RzFWbEZjWGd1cEZZQnNIbFJmV3pkWnpXUllDam00UFprSkpraDJu?=
 =?gb2312?B?b3l6SS9WYUtPQVlYbWlUMEV5TDRLVk8wajRsRUJMV2hMOHBOQWZrNWVzdGwy?=
 =?gb2312?B?UUlsaHVNakNmQ1BSMnZXMVEvU2thNzZUYWlkT1B2MHFjSUFtdWZXd1JLQnd6?=
 =?gb2312?B?dmtGMlBNdEE0Vjk0L1RGSVNmZWUvaFpKK0EwcTNJeVBoVEo5QkdseXZ4d2Rv?=
 =?gb2312?B?QlJYSjExeXBEUGYzd1N4VEdEUFYzWFJDTzRnZ251NTlwUWsySy9Mc3pCUmMv?=
 =?gb2312?B?ZmpSQXkxYWJFaXNCelZ6NFUvV0E3UG1wTmZmSlRxQTNwNENCWHZScFE4RndY?=
 =?gb2312?B?QTRmbGJ1S0o1NjdKYmEwenpZSnlNa0ozN2NWZWtTMU1PNG1oZUJ1UmgydHh2?=
 =?gb2312?B?THRFUTVXV1Urazd4L0g1Nm93dldzYzY5M0tkdXpEc1lUK0kvUHpQRHd6WWFT?=
 =?gb2312?B?L3lyT09PUlFsTU5vVjU5WnA0OHBGdTd0ZFdTaDJTaCtBT1Z3WUl5VGw1aXRo?=
 =?gb2312?B?V3lSSnFMYkpndEpYZzBoLzBrL0xrWWJUdHFNS3JhelBkZlBRU0JoVk9XUzVX?=
 =?gb2312?B?NnlYWFd5dWg2c2tId0N6Nnc2cjhVUlM2UGVHYzNzbHE1OTBwU1ZoYitTWWp2?=
 =?gb2312?B?RnlhTlJaYnZQUDY0UlRTNHdROWZyUVhFZG10RHpnSWRMbFcwM0Y2T0s1K0pB?=
 =?gb2312?B?TFpiUnczQVpCQXQyTVRBVDFzWEpKa20vREV0TzR0VFhBSmt1T3hZRlJDQis1?=
 =?gb2312?B?cmJIakwxOGowbnh1Wlh0Kzc3aFNRTS82dWh6NUZZdlNUQU5VVS92N3BXR3Ar?=
 =?gb2312?B?L1J0M3UzSWJPcHg1Tml3VCtQVGFoQllXalBqeS9HM1lHdTliN1FXUGd1VHdS?=
 =?gb2312?B?WElCY2lWbkV0d0JaNEJTUmVic3ZGL2UxWm1xa0NIMS9mYnB2bnp0NEhOTndG?=
 =?gb2312?B?aU0yb1c4dDcxR3RwSGl2TmZ2UGMrU3Rrb1NoK0JVdGhWemZEVUwzeExIRHY3?=
 =?gb2312?B?OFh0TDNKR3RwamtWRldXUDJWSDI2ZG81b0xRa3VpSXpKMit5Ym9SMmdqOWh5?=
 =?gb2312?B?QUsyTExheGZsVkpZWXowblgwQlJvOHFXWnVvWm94TVBERGpoMlJVUG9STXJn?=
 =?gb2312?B?OHF5U29xVDNjU05XQlkwRnlvTGt6VVNHVFZtZXJYK1QxNjRhTlB4N0ViRHRH?=
 =?gb2312?B?ekROZFlLS0dLWGhMR1JCdU1haTNtSVFnUXJLck5OZWtSeUpjZ3pPcGtlbExX?=
 =?gb2312?B?cmZ2eTR6OFJtbGEzZGhrckozeWtjUlBlMis1em9ScTZhVHNRb3JpUW5QdFZP?=
 =?gb2312?B?R0RvbnBTVUZGWFBmUEN1QTI0aVprZURwUStzelp3MWFOL0V3YUNVdVBsb0c2?=
 =?gb2312?B?K091c1UrTUFUMEZkTW1MU0d2N2J0dHhvMkFMbk9DY05tUkdTcWt0OEU2RUtv?=
 =?gb2312?B?YzFPZndWTmRUSVF1RzRscHBmeHZHUGpMQmpHeHltRm8wSlhzbS9kckEybkl2?=
 =?gb2312?Q?18TUVUnzgEqjQlpK0WxSiJS2YmPhL/yEMClLKLI=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB3754A3E4EF4FADE2541CD510F5660@DB3PR0402MB3754.eurprd04.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(346002)(396003)(366004)(13464003)(199004)(189003)(9686003)(316002)(478600001)(55016002)(14454004)(71200400001)(71190400001)(68736007)(33656002)(6436002)(86362001)(229853002)(74316002)(6916009)(81166006)(7736002)(305945005)(8676002)(81156014)(8936002)(66066001)(105586002)(53936002)(3846002)(76176011)(6116002)(4326008)(486006)(44832011)(2906002)(7696005)(25786009)(97736004)(102836004)(11346002)(53546011)(186003)(476003)(6346003)(6246003)(446003)(6506007)(106356001)(26005)(54906003)(99286004)(14444005)(256004)(7416002)(15866825006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3754;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6aGvHZq1H0n+WXVRxPinUrko40wvF2JAu4/4le4ykrFJEmFXE2BNpMtoUxHAx9SExew3H58FmPWt9P88sp4HrMNNRBJtbCoc1g+JgNVtsFxjU+Jw4TH/uDxy/Qju2igc+oKmslsnS/7QEdxhsdJMai9yrdxBA0yZPSWTlFswF5BCrJ//ZmyBcuaoxQsttupus3zCueSTiKY9S7l278/4Y/JIzZx+8HH8ONcHcrNT55vso+smSrqLLSjC/cK5p40J4VL+PKWv/8VGwfKSRoEA4fq2NiO6gt2Hkj9am86OvbT+a7SiYsjL9LOU1jwaJyl1MG/SkD9oZpUt49/nr/gDGhewcDWlt5L/kMgC+3oEB/pisc7Ecj+rnSsY+58yoBGqCDqkqzRQiKNgBG2yklxnVSk8i4fQ9qxLkrpNezG89ZU=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f15dc0-2f65-42be-f16c-08d6918fc8ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 08:46:45.4684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3754
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFZpcmVzaA0KDQpCZXN0IFJlZ2FyZHMhDQpBbnNvbiBIdWFuZw0KDQo+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFZpcmVzaCBLdW1hciBbbWFpbHRvOnZpcmVzaC5rdW1h
ckBsaW5hcm8ub3JnXQ0KPiBTZW50OiAyMDE5xOoy1MIxM8jVIDE1OjA5DQo+IFRvOiBBbnNvbiBI
dWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4gQ2M6IHJvYmgrZHRAa2VybmVsLm9yZzsgbWFy
ay5ydXRsYW5kQGFybS5jb207IHNoYXduZ3VvQGtlcm5lbC5vcmc7DQo+IHMuaGF1ZXJAcGVuZ3V0
cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOw0KPiBj
YXRhbGluLm1hcmluYXNAYXJtLmNvbTsgd2lsbC5kZWFjb25AYXJtLmNvbTsgcmp3QHJqd3lzb2Nr
aS5uZXQ7DQo+IEFpc2hlbmcgRG9uZyA8YWlzaGVuZy5kb25nQG54cC5jb20+OyBEYW5pZWwgQmFs
dXRhDQo+IDxkYW5pZWwuYmFsdXRhQG54cC5jb20+OyBBbmR5IEdyb3NzIDxhbmR5Lmdyb3NzQGxp
bmFyby5vcmc+Ow0KPiBob3JtcytyZW5lc2FzQHZlcmdlLm5ldC5hdTsgaGVpa29Ac250ZWNoLmRl
OyBhcm5kQGFybmRiLmRlOw0KPiBiam9ybi5hbmRlcnNzb25AbGluYXJvLm9yZzsgamFnYW5AYW1h
cnVsYXNvbHV0aW9ucy5jb207DQo+IGVucmljLmJhbGxldGJvQGNvbGxhYm9yYS5jb207IG1hcmMu
dy5nb256YWxlekBmcmVlLmZyOyBvbG9mQGxpeG9tLm5ldDsNCj4gZGV2aWNldHJlZUB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtDQo+
IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZzsgZGwtbGlu
dXgtaW14IDxsaW51eC0NCj4gaW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMy8z
XSBjcHVmcmVxOiBpbXgtc2M6IGFkZCBpLm14IHN5c3RlbSBjb250cm9sbGVyIGNwdWZyZXENCj4g
c3VwcG9ydA0KPiANCj4gT24gMTMtMDItMTksIDAzOjA5LCBBbnNvbiBIdWFuZyB3cm90ZToNCj4g
PiBPbiBOWFAncyBpLk1YIFNvQ3Mgd2l0aCBzeXN0ZW0gY29udHJvbGxlciBpbnNpZGUsIENQVSBm
cmVxdWVuY3kNCj4gPiBzY2FsaW5nIGNhbiBPTkxZIGJlIGRvbmUgYnkgc3lzdGVtIGNvbnRyb2xs
ZXIgZmlybXdhcmUsIGFuZCBpdCBjYW4NCj4gPiBPTkxZIGJlIHJlcXVlc3RlZCBmcm9tIHNlY3Vy
ZSBtb2RlLCBzbyBMaW51eCBjcHVmcmVxIGRyaXZlciBoYXMgdG8NCj4gPiBjYWxsIEFSTSBTTUMg
dG8gdHJhcCB0byBBUk0tVHJ1c3RlZC1GaXJtd2FyZSB0byByZXF1ZXN0IHN5c3RlbQ0KPiA+IGNv
bnRyb2xsZXIgZmlybXdhcmUgdG8gZG8gQ1BVIGZyZXF1ZW5jeSBzY2FsaW5nLg0KPiA+DQo+ID4g
VGhpcyBwYXRjaCBhZGRzIGkuTVggc3lzdGVtIGNvbnRyb2xsZXIgY3B1ZnJlcSBkcml2ZXIgc3Vw
cG9ydCwgd2hlbg0KPiA+IGRvaW5nIENQVSBmcmVxdWVuY3kgc2NhbGluZywgY3B1ZnJlcSBkcml2
ZXIgd2lsbCBkbyBBUk0gU01DIGNhbGwgYW5kDQo+ID4gdHJhcCB0byBBUk0tVHJ1c3RlZC1GaXJt
d2FyZSwgdGhlbiBTSVAoc2lsaWNvbiBwcm92aWRlcikgc2VydmljZSB3aWxsDQo+ID4gY29tbXVu
aWNhdGUgd2l0aCBzeXN0ZW0gY29udHJvbGxlciBmb3IgQ1BVIGZyZXF1ZW5jdCBzY2FsaW5nLg0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+
DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvY3B1ZnJlcS9LY29uZmlnLmFybSAgICAgIHwgICA5ICsr
DQo+ID4gIGRyaXZlcnMvY3B1ZnJlcS9NYWtlZmlsZSAgICAgICAgIHwgICAxICsNCj4gPiAgZHJp
dmVycy9jcHVmcmVxL2lteC1zYy1jcHVmcmVxLmMgfCAxODMNCj4gPiArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCAxOTMgaW5zZXJ0
aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9jcHVmcmVxL2lteC1zYy1j
cHVmcmVxLmMNCj4gDQo+IFdoeSBjYW4ndCB5b3UgdXNlIGNwdWZyZXEtZHQgZHJpdmVyIGxpa2Ug
ZXZlcnlvbmUgZWxzZSA/DQoNCkp1c3Qgbm90aWNlIHRoYXQgd2UgY2FuIG92ZXJ3cml0ZSB0aGUg
c2V0X3RhcmdldCBpZiB1c2luZyBjcHVmcmVxLWR0LCB0aGVuIHdlIHN0aWxsDQpuZWVkIGEgcGxh
dGZvcm0gY3B1ZnJlcSBmaWxlIHRvIGltcGxlbWVudCBhcmNoX3NldF9mcmVxX3NjYWxlKCksIEkg
Y2FuIHVzZSBpdCB0byBzYXZlDQp0aGUgY29kZSBvZiBpbXggc3lzdGVtIGNvbnRyb2xsZXIgY3B1
ZnJlcSBkcml2ZXIsIGFuZCBCVFcsIGNhbiBjcHVmcmVxLWR0IHN1cHBvcnQNCm11bHRpIGNsdXN0
ZXJzIGNwdWZyZXE/IEFzIGkuTVg4UU0gaGFzIDIgY2x1c3RlcnMgcnVubmluZyB3aXRoIGRpZmZl
cmVudCBPUFBzLg0KDQpUaGFua3MsDQpBbnNvbi4NCg0KPiANCj4gLS0NCj4gdmlyZXNoDQo=
