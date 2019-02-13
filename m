Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897C4C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44AFA222B6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WRwTl8WD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390875AbfBMIxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 03:53:18 -0500
Received: from mail-eopbgr130052.outbound.protection.outlook.com ([40.107.13.52]:38240
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389921AbfBMIxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 03:53:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ncKFoI2dhTlY7Y35UyWxmggBxN0Vkmg2RqLGKTVdVMY=;
 b=WRwTl8WD/gCeDbjGGTczLyrECie8qyFB2WFNeHx6d3qT4APzMNy+5wxo/g/uZI8B3X9WwKEz3AMPdpIYX6xr+iQKK6uIFeodT4Jd72uM/W8ghEGFdk3dGS73kX5Q0d4HY/QvNGXWigdf8Bbon5NUCo0nZ0kKWznH/MFh4PwUkAw=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3676.eurprd04.prod.outlook.com (52.134.70.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Wed, 13 Feb 2019 08:53:10 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 08:53:09 +0000
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
Thread-Index: AQHUw0mAk7D4InMTwEi38x/B8uOIA6XdT24AgAAaBPCAAAIDUA==
Date:   Wed, 13 Feb 2019 08:53:09 +0000
Message-ID: <DB3PR0402MB391662EC01B6160C1AA9A540F5660@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1550027011-7884-1-git-send-email-Anson.Huang@nxp.com>
 <1550027011-7884-3-git-send-email-Anson.Huang@nxp.com>
 <20190213070904.3oswrjafy6cqedsr@vireshk-i7>
 <DB3PR0402MB3916203C35D82A7667DA3A16F5660@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916203C35D82A7667DA3A16F5660@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93e6852e-93ec-4e80-9b10-08d69190adfc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3676;
x-ms-traffictypediagnostic: DB3PR0402MB3676:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?gb2312?B?MTtEQjNQUjA0MDJNQjM2NzY7MjM6R1JpZVJaVHp1R1JZWW41eE5CNnNsVldh?=
 =?gb2312?B?bTJCRGdDWUVtRDd5dXVoeHVsdXZCV05iOVdGS205dUpQZUtWeVNWdEVSUjU2?=
 =?gb2312?B?bXJLQlpKYU5JOXViazZ1OGUyNE9sclN2VThpbGpZa1RJZnYrZ2pKVGQzWG5n?=
 =?gb2312?B?ZFVsenlZbnNuaDZlS0NnYnVpa2dUOTdURTJOVCs0SUdTV3FvUnNJV3dsakgr?=
 =?gb2312?B?eHNiSzVIRGdtSW1NemhUemVLUXpuNHdYSHh1Q0grVjNPQjNRVHBsRXI0NWZo?=
 =?gb2312?B?MzF3ZWh3VlF6cEJnZmJ2REE0RERHeFZoenlpeHpCTTBNcXdueFBtaEgwSUdN?=
 =?gb2312?B?aUdIMzB5S2F2bHVnTlowcWtEdC9mUVFhRlpHQ0hsSDVaamNOaE5FR1ZpeUNq?=
 =?gb2312?B?Qm5sNitXckFXZzFYNTNkcjZSeFRBWXRHZi8rWnhnOWNqSHg1Q1RIQVJVZFJ1?=
 =?gb2312?B?ejhieDNNZHI3RE5abFNBdzlQUnFoSktaRVh0Ynp6cTUyOExJWjlXSVdUQlhj?=
 =?gb2312?B?WTNFeGpaOTFCemFNczN3ME5jcW1Ud29HM3AvS2tvV2QzenFwbGtOSFRMdkV3?=
 =?gb2312?B?cmtua1Fnd0dvMzNtdnI2d2xqb0hPbUlEVGhLN3EyUnNoa3k3TGR4RHM1dldS?=
 =?gb2312?B?dVExY2RSejZkdEdwaXdOT2pnN3pDRkZ1V2dvVTFoOHE1Y29qcnZpb1hvVTgx?=
 =?gb2312?B?NWZjYzJzOTgzVmcvS2ZmTFNZcGJ3S3dCNlViY2FBbldKak5Pc21lZ3Q5am1p?=
 =?gb2312?B?bHNRVHh1cUI5VjQ2S1lPeko3VnJWZ2o3STRSVExjaXliVVpoSGxwY2FvRm9M?=
 =?gb2312?B?UGZDdWRiOFBGSC9HRlZEUkNoRE1JckNvZ09adlVHcGZYVEF2Z00zTGVRdTdE?=
 =?gb2312?B?M0lObS9JbjFwUkVUcjNEaEVHZWpLcXI1WlcyWWdrRzhBNUxmN1ExTXNRTDJx?=
 =?gb2312?B?WHZ2MUxsNjdRQkJHZmpxY29LbCtGMDlBVUFpQ0h0UklZeURoQnJFbkYrQlNY?=
 =?gb2312?B?allnWGpSU1NobmZhNGFYT0MzaVdGWDVOL0N2dmgzRFI0UXh4TldpZzlvYmdG?=
 =?gb2312?B?MzF1bk1xSGhkVVJrYTEzT3g2bWcrT2dYNnR1Zkd0RmFieE9zWHV6TXNGM3JS?=
 =?gb2312?B?czgrbGVRcis0ZnJ5K3g2RURBcm5WVldMYU90USs5UTVVTjEyVGo0cUdiNW5B?=
 =?gb2312?B?d3AzV1FnNE5iSzQzQm9BOTU2UjJSWXQrTWU0YzFyRTcvUEhMNHlXSERBeTFG?=
 =?gb2312?B?K0ZEdDNwczR4aFRhS0hvQzlQcmlIS3ZIdFFIYWlIajI2OUJRSkhPQ3Bjc3F3?=
 =?gb2312?B?VXM3bmY1QkNja1ZINDNHS1R0U3phLytZWE1EY1ZDYXhLSHhGWERTWk9nRFgx?=
 =?gb2312?B?OCtaYWZoTzVEQm1RM2JHQkEzdXpGSmlVUHlFb0lDa2NaNXc0dkZ6TXZjdHVB?=
 =?gb2312?B?a3g3TGpGVHNpR0ZBOWcyU2VLdWJyVjhQanp2eWNyTER0enNQSVg1VFB4SGNF?=
 =?gb2312?B?RC9RQ3MwMkdNMmovYy9EOVJDSEJEbG1tamd6RGZ4QitURkpJRlVkdFQ1ejdF?=
 =?gb2312?B?U3RlNFBhS1RRL1JHOU9IWnFDcFhDNlJlUjN1TGwzNEVEc1gxVnIwMkh6ZHhi?=
 =?gb2312?B?TXdEOFhNRHVBWXUrL2U4WWlMeG9RUDdBenNUamRYcXM0RC9TemVJcmVjbXpL?=
 =?gb2312?B?VlVRMnRYMldnRlhHUld4WUNBU3hxMGVTaEd5Z1NqNG5MQnYwekNaNHRSOWxB?=
 =?gb2312?B?L2kwdG5HTTVWOTc3eHpsbkx6UmtGL2dTNWNNTTZ4L0dNR0VZZDVmQnZOa09C?=
 =?gb2312?B?VG9VM0ZVaHVhVEJvT25iNWx5SmEwazEvakthM0szbTNmNzNMQT09?=
x-microsoft-antispam-prvs: <DB3PR0402MB3676BEDAF1DA922362753924F5660@DB3PR0402MB3676.eurprd04.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(376002)(396003)(136003)(13464003)(199004)(189003)(14444005)(97736004)(6246003)(93886005)(33656002)(71200400001)(305945005)(256004)(8936002)(229853002)(2906002)(14454004)(93156006)(8676002)(81166006)(7736002)(81156014)(2940100002)(74316002)(7696005)(71190400001)(76176011)(53936002)(9686003)(54906003)(316002)(478600001)(68736007)(53546011)(6436002)(44832011)(486006)(66066001)(186003)(476003)(6506007)(86362001)(6916009)(102836004)(26005)(99286004)(6116002)(4326008)(3846002)(25786009)(105586002)(7416002)(446003)(106356001)(55016002)(11346002)(15866825006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3676;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: b2ACx+hS8VfMmfSYDuHug9z/pNx2o1UWAuXcku/Iq2845OtbCxDDG/T7Ow/bGb4MaXkdpkUW7d0moYAboXeWVdjdMtlrUl5MNPogVjhTdcJ6SH3Gu/Ed5P5QYpwBZY3nvyYa/o5jySs6SW8HhOyeKt1YBUUWkxu7RjIiBZ+I2BttNvFMVQL5ve7EB4aD6+6SxY1mW4bA1/XlgfcvHrqbLq42Muu0tzCAHIxtJVKu2Y5bITlf+R1C/M2MnbQMJNLYYbkeEyQOGS6f2L0N+eSB5+2wv89c3NMUipMfMsxglkq8hroRB5gk9lhjeGkFOsrPNYME/kPVGwUo9T/JNabBi7xr4L5leioujtymGvvP8LtABputtLUkClNDR0MBmvvpwwm5Bn3Sm9j93TGFm8hjy9yY8CX8PRcn15rtEpW78gw=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e6852e-93ec-4e80-9b10-08d69190adfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 08:53:09.9254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3676
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkJlc3QgUmVnYXJkcyENCkFuc29uIEh1YW5nDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gRnJvbTogQW5zb24gSHVhbmcNCj4gU2VudDogMjAxOcTqMtTCMTPI1SAxNjo0Nw0K
PiBUbzogVmlyZXNoIEt1bWFyIDx2aXJlc2gua3VtYXJAbGluYXJvLm9yZz4NCj4gQ2M6IHJvYmgr
ZHRAa2VybmVsLm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207IHNoYXduZ3VvQGtlcm5lbC5vcmc7
DQo+IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2
YW1AZ21haWwuY29tOw0KPiBjYXRhbGluLm1hcmluYXNAYXJtLmNvbTsgd2lsbC5kZWFjb25AYXJt
LmNvbTsgcmp3QHJqd3lzb2NraS5uZXQ7DQo+IEFpc2hlbmcgRG9uZyA8YWlzaGVuZy5kb25nQG54
cC5jb20+OyBEYW5pZWwgQmFsdXRhDQo+IDxkYW5pZWwuYmFsdXRhQG54cC5jb20+OyBBbmR5IEdy
b3NzIDxhbmR5Lmdyb3NzQGxpbmFyby5vcmc+Ow0KPiBob3JtcytyZW5lc2FzQHZlcmdlLm5ldC5h
dTsgaGVpa29Ac250ZWNoLmRlOyBhcm5kQGFybmRiLmRlOw0KPiBiam9ybi5hbmRlcnNzb25AbGlu
YXJvLm9yZzsgamFnYW5AYW1hcnVsYXNvbHV0aW9ucy5jb207DQo+IGVucmljLmJhbGxldGJvQGNv
bGxhYm9yYS5jb207IG1hcmMudy5nb256YWxlekBmcmVlLmZyOyBvbG9mQGxpeG9tLm5ldDsNCj4g
ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXBtQHZnZXIu
a2VybmVsLm9yZzsgZGwtbGludXgtaW14IDxsaW51eC0NCj4gaW14QG54cC5jb20+DQo+IFN1Ympl
Y3Q6IFJFOiBbUEFUQ0ggMy8zXSBjcHVmcmVxOiBpbXgtc2M6IGFkZCBpLm14IHN5c3RlbSBjb250
cm9sbGVyIGNwdWZyZXENCj4gc3VwcG9ydA0KPiANCj4gSGksIFZpcmVzaA0KPiANCj4gQmVzdCBS
ZWdhcmRzIQ0KPiBBbnNvbiBIdWFuZw0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiA+IEZyb206IFZpcmVzaCBLdW1hciBbbWFpbHRvOnZpcmVzaC5rdW1hckBsaW5hcm8ub3Jn
XQ0KPiA+IFNlbnQ6IDIwMTnE6jLUwjEzyNUgMTU6MDkNCj4gPiBUbzogQW5zb24gSHVhbmcgPGFu
c29uLmh1YW5nQG54cC5jb20+DQo+ID4gQ2M6IHJvYmgrZHRAa2VybmVsLm9yZzsgbWFyay5ydXRs
YW5kQGFybS5jb207IHNoYXduZ3VvQGtlcm5lbC5vcmc7DQo+ID4gcy5oYXVlckBwZW5ndXRyb25p
eC5kZTsga2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207DQo+ID4gY2F0
YWxpbi5tYXJpbmFzQGFybS5jb207IHdpbGwuZGVhY29uQGFybS5jb207IHJqd0Byand5c29ja2ku
bmV0Ow0KPiA+IEFpc2hlbmcgRG9uZyA8YWlzaGVuZy5kb25nQG54cC5jb20+OyBEYW5pZWwgQmFs
dXRhDQo+ID4gPGRhbmllbC5iYWx1dGFAbnhwLmNvbT47IEFuZHkgR3Jvc3MgPGFuZHkuZ3Jvc3NA
bGluYXJvLm9yZz47DQo+ID4gaG9ybXMrcmVuZXNhc0B2ZXJnZS5uZXQuYXU7IGhlaWtvQHNudGVj
aC5kZTsgYXJuZEBhcm5kYi5kZTsNCj4gPiBiam9ybi5hbmRlcnNzb25AbGluYXJvLm9yZzsgamFn
YW5AYW1hcnVsYXNvbHV0aW9ucy5jb207DQo+ID4gZW5yaWMuYmFsbGV0Ym9AY29sbGFib3JhLmNv
bTsgbWFyYy53LmdvbnphbGV6QGZyZWUuZnI7IG9sb2ZAbGl4b20ubmV0Ow0KPiA+IGRldmljZXRy
ZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7
DQo+ID4gbGludXgtIGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXBtQHZnZXIua2VybmVs
Lm9yZzsgZGwtbGludXgtaW14DQo+ID4gPGxpbnV4LSBpbXhAbnhwLmNvbT4NCj4gPiBTdWJqZWN0
OiBSZTogW1BBVENIIDMvM10gY3B1ZnJlcTogaW14LXNjOiBhZGQgaS5teCBzeXN0ZW0gY29udHJv
bGxlcg0KPiA+IGNwdWZyZXEgc3VwcG9ydA0KPiA+DQo+ID4gT24gMTMtMDItMTksIDAzOjA5LCBB
bnNvbiBIdWFuZyB3cm90ZToNCj4gPiA+IE9uIE5YUCdzIGkuTVggU29DcyB3aXRoIHN5c3RlbSBj
b250cm9sbGVyIGluc2lkZSwgQ1BVIGZyZXF1ZW5jeQ0KPiA+ID4gc2NhbGluZyBjYW4gT05MWSBi
ZSBkb25lIGJ5IHN5c3RlbSBjb250cm9sbGVyIGZpcm13YXJlLCBhbmQgaXQgY2FuDQo+ID4gPiBP
TkxZIGJlIHJlcXVlc3RlZCBmcm9tIHNlY3VyZSBtb2RlLCBzbyBMaW51eCBjcHVmcmVxIGRyaXZl
ciBoYXMgdG8NCj4gPiA+IGNhbGwgQVJNIFNNQyB0byB0cmFwIHRvIEFSTS1UcnVzdGVkLUZpcm13
YXJlIHRvIHJlcXVlc3Qgc3lzdGVtDQo+ID4gPiBjb250cm9sbGVyIGZpcm13YXJlIHRvIGRvIENQ
VSBmcmVxdWVuY3kgc2NhbGluZy4NCj4gPiA+DQo+ID4gPiBUaGlzIHBhdGNoIGFkZHMgaS5NWCBz
eXN0ZW0gY29udHJvbGxlciBjcHVmcmVxIGRyaXZlciBzdXBwb3J0LCB3aGVuDQo+ID4gPiBkb2lu
ZyBDUFUgZnJlcXVlbmN5IHNjYWxpbmcsIGNwdWZyZXEgZHJpdmVyIHdpbGwgZG8gQVJNIFNNQyBj
YWxsIGFuZA0KPiA+ID4gdHJhcCB0byBBUk0tVHJ1c3RlZC1GaXJtd2FyZSwgdGhlbiBTSVAoc2ls
aWNvbiBwcm92aWRlcikgc2VydmljZQ0KPiA+ID4gd2lsbCBjb21tdW5pY2F0ZSB3aXRoIHN5c3Rl
bSBjb250cm9sbGVyIGZvciBDUFUgZnJlcXVlbmN0IHNjYWxpbmcuDQo+ID4gPg0KPiA+ID4gU2ln
bmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+ID4gPiAtLS0N
Cj4gPiA+ICBkcml2ZXJzL2NwdWZyZXEvS2NvbmZpZy5hcm0gICAgICB8ICAgOSArKw0KPiA+ID4g
IGRyaXZlcnMvY3B1ZnJlcS9NYWtlZmlsZSAgICAgICAgIHwgICAxICsNCj4gPiA+ICBkcml2ZXJz
L2NwdWZyZXEvaW14LXNjLWNwdWZyZXEuYyB8IDE4Mw0KPiA+ID4gKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrDQo+ID4gPiAgMyBmaWxlcyBjaGFuZ2VkLCAxOTMgaW5zZXJ0
aW9ucygrKQ0KPiA+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2NwdWZyZXEvaW14LXNj
LWNwdWZyZXEuYw0KPiA+DQo+ID4gV2h5IGNhbid0IHlvdSB1c2UgY3B1ZnJlcS1kdCBkcml2ZXIg
bGlrZSBldmVyeW9uZSBlbHNlID8NCj4gDQo+IEp1c3Qgbm90aWNlIHRoYXQgd2UgY2FuIG92ZXJ3
cml0ZSB0aGUgc2V0X3RhcmdldCBpZiB1c2luZyBjcHVmcmVxLWR0LCB0aGVuIHdlDQo+IHN0aWxs
IG5lZWQgYSBwbGF0Zm9ybSBjcHVmcmVxIGZpbGUgdG8gaW1wbGVtZW50IGFyY2hfc2V0X2ZyZXFf
c2NhbGUoKSwgSSBjYW4NCj4gdXNlIGl0IHRvIHNhdmUgdGhlIGNvZGUgb2YgaW14IHN5c3RlbSBj
b250cm9sbGVyIGNwdWZyZXEgZHJpdmVyLCBhbmQgQlRXLCBjYW4NCj4gY3B1ZnJlcS1kdCBzdXBw
b3J0IG11bHRpIGNsdXN0ZXJzIGNwdWZyZXE/IEFzIGkuTVg4UU0gaGFzIDIgY2x1c3RlcnMNCj4g
cnVubmluZyB3aXRoIGRpZmZlcmVudCBPUFBzLg0KPiANCj4gVGhhbmtzLA0KPiBBbnNvbi4NCg0K
Rm9yZ290IHRvIG1lbnRpb24sIGkuTVggc3lzdGVtIGNvbnRyb2xsZXIgY3B1ZnJlcSBhY3R1YWxs
eSBjYW4gTk9UIGRvIGFueSBDUFUNCmNsb2NrL3ZvbHRhZ2Ugc2NhbGluZyBmcm9tIExpbnV4IGtl
cm5lbCwgdGhleSBhcmUgY29udHJvbGxlZCBieSBzeXN0ZW0gY29udHJvbGxlcg0KZmlybXdhcmUg
YW5kIE9OTFkgY2FuIGJlIHJlcXVlc3RlZCB2aWEgUlBDIHdpdGggc2VjdXJlIG1vZGUsIHNvIExp
bnV4IGtlcm5lbA0KaGFzIHRvIGNhbGwgU01DIGFuZCB0cmFwIHRvIEFSTS1UcnVzdGVkLUZpcm13
YXJlIHRvIGRvIGl0LCBpbiB0aGlzIGNhc2UsIGlzIGNwdWZyZXEtZHQNCnN0aWxsIHN1aXRhYmxl
IHRvIHN1cHBvcnQgaXQ/IEkgc2F3IGNwdWZyZXEtZHQgZHJpdmVyIHdpbGwgZG8gQ1BVIGNsb2Nr
L3ZvbHRhZ2Ugc2NhbGluZw0KZGlyZWN0bHkuDQoNCkFuc29uLg0KDQo+IA0KPiA+DQo+ID4gLS0N
Cj4gPiB2aXJlc2gNCg==
