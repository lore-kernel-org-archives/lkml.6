Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE10C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 818E820832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Vi5FImuh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 818E820832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbeK1UH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:07:27 -0500
Received: from mail-eopbgr00066.outbound.protection.outlook.com ([40.107.0.66]:60222
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727413AbeK1UHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:07:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZeTlPK+M5UR1XQeKqyWx/V6yKpFTGDA4hTmCHQOVXuo=;
 b=Vi5FImuhMYyC+ePPDIm5E3D5Q3tvv0wLzFLGlSxDaS3eTahDJH26VFWwTUOlSYFdJsy66OI1vm+nB/YADM5jZuLo/YddMALmsmc6OueONXSoe5ExCbJuUBog6gVKuiYANdGvViId20Yaei/MMYi9j0tkz7/zHzHc3S5RyGwy9Uc=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3756.eurprd04.prod.outlook.com (52.134.73.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Wed, 28 Nov 2018 09:06:27 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%2]) with mapi id 15.20.1361.019; Wed, 28 Nov 2018
 09:06:27 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     =?utf-8?B?TG90aGFyIFdhw59tYW5u?= <LW@KARO-electronics.de>
CC:     "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Aisheng DONG <aisheng.dong@nxp.com>,
        Andy Gross <andy.gross@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 4/4] ARM64: dts: imx: add i.MX8QXP system controller RTC
 support
Thread-Topic: [PATCH 4/4] ARM64: dts: imx: add i.MX8QXP system controller RTC
 support
Thread-Index: AQHUhjVp2fzkoSnTjEGBUoXMaMsjH6Vk5kcAgAAALcA=
Date:   Wed, 28 Nov 2018 09:06:27 +0000
Message-ID: <DB3PR0402MB3916FFD700313BF684CF32AAF5D10@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1543311334-8807-1-git-send-email-Anson.Huang@nxp.com>
        <1543311334-8807-5-git-send-email-Anson.Huang@nxp.com>
 <20181128100420.0c9a721a@karo-electronics.de>
In-Reply-To: <20181128100420.0c9a721a@karo-electronics.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3756;6:o8a5g897w45qn4nZi93HzE0EZXZuXiPzE9ryJeT0b9JVhwvo6uGFk/FcVEqUD4pEcwCu2e7o8xVi/eSZVHkZJ5hmjcnj1fI4XfHt3ph4X3gACXUtP/+u67nLDOovHeQcRPxY3C5avsIrwxufSWh5bs+YueZIJPJ/aygNTRfwDPs2Vubj37VIpdQQ2Uw6FX+bOOlMIhmZeFsW1tJvrdzF21vLP/SZmhWM21snHRF18ifn+7jnOzwS/jqH9ayJqHCAaGSJktJRnWhsdfQ/PDjCsPbb2Bz7oo5E3jJ5SiM//at27Boqn6TxOhiKZTzyUUIc9Rcsgk9UeofS4YJOsneMCIiBuNL7/WaRI6b1OmdB+KksUOyrECWbOvGS2rpYlJ86hnB95VhzEp7LzNl2hDPGYeQW8NvbYCwX28uTjg2xTEEISmiC2anKcbQzo5vlLr3KclzVATNrOf4Ey4wLy5vX6w==;5:ztqbF0r2wzdIWCioRkdT2twXAwWoH2fwO5jHsrN0tFXDCWfLSN7sYWL5DIX3H+bQK8w7Zfw2OGdOFL3T7ogleMnqKup7Y2aXJTeKltTITYj/jFbzjrTBTWaq8bBouyFGeBMat4hP6xAJ+MXZagNE4WgzRc54aHbs/EemNu4yNX8=;7:po0UbacmQF8sNZwXagURW1hnBXFIHJmcNpDCOCFEkk9Cuu2/pOUixVzqTjnuomu8QZKV+AV5T/ayx0Hg2SachRqWHCf4PZ8p59z+kvDosmnooiUSIuwxrs31m04WJn0PQazD/ryHKWUPYzQuOD0Maw==
x-ms-office365-filtering-correlation-id: d16077c0-b9a4-4f8b-c3fb-08d65510c79f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3756;
x-ms-traffictypediagnostic: DB3PR0402MB3756:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB3PR0402MB3756822EAB79640B8D3C5B95F5D10@DB3PR0402MB3756.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231443)(999002)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3756;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3756;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(346002)(376002)(39860400002)(13464003)(199004)(189003)(8676002)(14454004)(86362001)(7416002)(6246003)(44832011)(53936002)(66066001)(68736007)(256004)(14444005)(71190400001)(71200400001)(446003)(11346002)(102836004)(486006)(74316002)(97736004)(5660300001)(305945005)(7736002)(476003)(4326008)(66574009)(9686003)(55016002)(99286004)(106356001)(105586002)(8936002)(2906002)(6116002)(3846002)(76176011)(478600001)(26005)(81156014)(53546011)(6506007)(33656002)(6916009)(54906003)(81166006)(6436002)(316002)(25786009)(7696005)(186003)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3756;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: eBOD92j6PDDR2PuixIbP9iv+tjQSSwJbTzSXrU1EtJhnvlk6tUp/l3/8MlERX2UTdGFyUQiZHe8zcIvXKAMEMHiqQjHG6oljPeAZDOdM4txrR8wGOKwqDgSprxITlQ1zU4ttme2S1Z8yjZr751W59D3RwgXaajs24hPcgblhVG5H0f9SacNxlY2eLaxCk1Lv8qWXyfVA8OL7x5qfaZ0VIi/vYamRn6Sz703jXAkB3Abw/Ss8+c92cUhV5IRto3wOPSC1Okl2l4CgTKu2xzb3lr5MVoNtno8kK9wIUDZa8cdANYBXjXjCE4PgB5kcaHMAMRiAVz6cf4LIUD+Z/JX3YziXV7tSXYXnFjwPTTAympM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d16077c0-b9a4-4f8b-c3fb-08d65510c79f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 09:06:27.5852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3756
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIExvdGhhcg0KDQpCZXN0IFJlZ2FyZHMhDQpBbnNvbiBIdWFuZw0KDQo+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExvdGhhciBXYcOfbWFubiBbbWFpbHRvOkxXQEtBUk8t
ZWxlY3Ryb25pY3MuZGVdDQo+IFNlbnQ6IDIwMTjlubQxMeaciDI45pelIDE3OjA0DQo+IFRvOiBB
bnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4gQ2M6IGEuenVtbW9AdG93ZXJ0ZWNo
Lml0OyBhbGV4YW5kcmUuYmVsbG9uaUBib290bGluLmNvbTsNCj4gcm9iaCtkdEBrZXJuZWwub3Jn
OyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgY2F0YWxpbi5tYXJpbmFzQGFybS5jb207DQo+IHdpbGwu
ZGVhY29uQGFybS5jb207IEFpc2hlbmcgRE9ORyA8YWlzaGVuZy5kb25nQG54cC5jb20+OyBBbmR5
IEdyb3NzDQo+IDxhbmR5Lmdyb3NzQGxpbmFyby5vcmc+OyBhcm5kQGFybmRiLmRlOyBob3Jtcyty
ZW5lc2FzQHZlcmdlLm5ldC5hdTsNCj4gaGVpa29Ac250ZWNoLmRlOyBiam9ybi5hbmRlcnNzb25A
bGluYXJvLm9yZzsgZW5yaWMuYmFsbGV0Ym9AY29sbGFib3JhLmNvbTsNCj4gYW1pdC5rdWNoZXJp
YUBsaW5hcm8ub3JnOyBlemVxdWllbEBjb2xsYWJvcmEuY29tOyBvbG9mQGxpeG9tLm5ldDsNCj4g
c2hhd25ndW9Aa2VybmVsLm9yZzsgbGludXgtcnRjQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJl
ZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gZGwtbGludXgtaW14IDxsaW51eC1p
bXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCA0LzRdIEFSTTY0OiBkdHM6IGlteDog
YWRkIGkuTVg4UVhQIHN5c3RlbSBjb250cm9sbGVyDQo+IFJUQyBzdXBwb3J0DQo+IA0KPiBIaSwN
Cj4gDQo+IE9uIFR1ZSwgMjcgTm92IDIwMTggMDk6NDE6NDYgKzAwMDAgQW5zb24gSHVhbmcgd3Jv
dGU6DQo+ID4gQWRkIGkuTVg4UVhQIHN5c3RlbSBjb250cm9sbGVyIFJUQyBzdXBwb3J0Lg0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+
ID4gLS0tDQo+ID4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhxeHAuZHRzaSB8
IDQgKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OHF4cC5kdHNpDQo+
IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OHF4cC5kdHNpDQo+ID4gaW5kZXgg
OTE1NWQ0NS4uZWY1N2RiNiAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2Zy
ZWVzY2FsZS9pbXg4cXhwLmR0c2kNCj4gPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVz
Y2FsZS9pbXg4cXhwLmR0c2kNCj4gPiBAQCAtNDMzLDQgKzQzMyw4IEBADQo+ID4gIAkJI3NpemUt
Y2VsbHMgPSA8MT47DQo+ID4gIAkJcmFuZ2VzID0gPDB4NWYwMDAwMDAgMHgwIDB4NWYwMDAwMDAg
MHgxMDAwMDAwPjsNCj4gPiAgCX07DQo+ID4gKw0KPiA+ICsJcnRjOiBydGMgew0KPiA+ICsJCWNv
bXBhdGlibGUgPSAibnhwLGlteDhxeHAtc2MtcnRjIjsNCj4gPiArCX07DQo+ID4gIH07DQo+IElN
TyB0aGlzIHNob3VsZCBiZSBkaXNhYmxlZCBieSBkZWZhdWx0Lg0KDQpUaGlzIG1vZHVsZSBpcyBO
T1QgZGVwZW5kaW5nIG9uIGFueSBib2FyZCBkZXNpZ24sIHNob3VsZCBpdCBiZSBlbmFibGVkIGJ5
IGRlZmF1bHQgaW4gc29jIGR0c2k/DQpMaWtlIHdkb2cgZXRjLi4NCg0KQW5zb24uDQoNCj4gDQo+
IA0KPiBMb3RoYXIgV2HDn21hbm4NCg==
