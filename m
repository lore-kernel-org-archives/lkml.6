Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582C2C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 087392146F
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HHSF+Wjp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 087392146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbeK1UVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:21:21 -0500
Received: from mail-eopbgr140044.outbound.protection.outlook.com ([40.107.14.44]:44612
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727413AbeK1UVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:21:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZFcGO2X7DKEF/l9UDEhWT8nD7JA2WowvGMlUhw+yUU=;
 b=HHSF+Wjp5t4YV0JlyS4sP5OwkiDkA6TeO7IRCAdEEjxY+6tOYlVonmrZQhY2HAkqrh2MRNW9Q9V+HuxqapGZDwZfpyaMs/QemGjzBAWlGlf7OpLVo9klduvwB1WGYqVMiwvRHY7Gz8ywWt19vQupUPs6KwaY/Lr2KeifCbbb+Uc=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Wed, 28 Nov 2018 09:20:02 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%2]) with mapi id 15.20.1361.019; Wed, 28 Nov 2018
 09:20:02 +0000
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
Thread-Index: AQHUhjVp2fzkoSnTjEGBUoXMaMsjH6Vk5kcAgAAALcCAAAIbAIAAAVaA
Date:   Wed, 28 Nov 2018 09:20:02 +0000
Message-ID: <DB3PR0402MB391643B7E4591A3EF5FCA8AAF5D10@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1543311334-8807-1-git-send-email-Anson.Huang@nxp.com>
        <1543311334-8807-5-git-send-email-Anson.Huang@nxp.com>
        <20181128100420.0c9a721a@karo-electronics.de>
        <DB3PR0402MB3916FFD700313BF684CF32AAF5D10@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20181128101230.435bfbeb@ipc1.ka-ro>
In-Reply-To: <20181128101230.435bfbeb@ipc1.ka-ro>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3916;6:ouJI6Vk/xOUyo09HLvd33vVI6/u3EwkpQD/IlQiLXR6yJrHKOc5RHSZSHjTz26MAxTIwJvQlhVjPJfES6XSHhU8QoxuMnt4BiNFreXDhbdSuHYSR4KyGncLugbe2oiG5sGWgw/MdU+0ZAv8tt1/zH7OQ0rQGob+aMlK+8k1v/bsWZ83DjNjJCYvYlhbZJzIOEhH35weAHnR+it+kbfCBzwu2sWGhNlY4onB8ooJkG9q05R3rcDaIFRwOsTTpZr2zIe8xxYzw7OUM29EL+pBbCTEhVveULeRsKTPsn3rUgEMeKSqAsu4Qsggr2TWeBqCrg/WunbJB2v8UQDagC9Cd3bJl8vr3/y4Mg798tB+fFzj2GIA9uzZmCNRoySqpIxZElBUUxOzibDdVW9W6vTkq2BIDd1rcMmGN5Uyzyo/VSWv7V75kllaGiD8/VcTgkfmbA6LTWNUNCEil1mjw14L/tg==;5:K8B+OtW7a0yvqG4vMgo/cYtJFEL3dVgyvf6/OI8ioyYCFqajrBfindceKaMyxOzewZA+DEGUsHmt7GLkxNRunO3iEV8fBhgBn/w44HOsZ8/JK9BDrMR/JUWpE3EF4EKJfSrlumGgfomLbr6Wh5gPzZ03nYh9+WVI+lxq929Bmiw=;7:JeB5OygNylIRjXuUE6vBpm3HZ07UpWS74nvfIBlC7jCKItVRFQ7zdL+9VWe1ezvSyiiP1bcwvIEQ1CwD2hqMG85Zwi5N2+wrzfZjWRvkQUTVF6qe+hZ+tb/J+MKL9K7vZiG8YwRvn27krnHgnbhEBQ==
x-ms-office365-filtering-correlation-id: eb6c411a-89da-4e11-b158-08d65512ad93
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3916;
x-ms-traffictypediagnostic: DB3PR0402MB3916:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB3PR0402MB39160CD81295F86DBF13D275F5D10@DB3PR0402MB3916.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231443)(999002)(944501436)(52105112)(93006095)(93001095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3916;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3916;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(39860400002)(366004)(396003)(346002)(189003)(199004)(13464003)(6246003)(71200400001)(8676002)(316002)(229853002)(8936002)(81166006)(81156014)(99286004)(14454004)(93886005)(7696005)(71190400001)(66574009)(6436002)(45080400002)(478600001)(2906002)(106356001)(105586002)(6506007)(68736007)(6916009)(966005)(53546011)(3846002)(6116002)(86362001)(575784001)(44832011)(305945005)(53936002)(102836004)(5660300001)(26005)(7416002)(4326008)(6346003)(7736002)(74316002)(476003)(6306002)(66066001)(25786009)(76176011)(54906003)(11346002)(446003)(33656002)(55016002)(186003)(9686003)(14444005)(256004)(486006)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3916;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-microsoft-antispam-message-info: Xv0hW0U/NzPbVl/eF+5Fgt2utlo4BrD/Wy2ECd4ELI4RV8pt7phbPQlfECvR5Y4e4jF1Ms2U2ztqtm4tL1z89/dKCaGx/F+uphEtimSUHgnxY/enzsMMtCK8pZpeMww8DKi4vOWeknBEnhuvw+48K4MQ1JoKQVooFxBnbdCggb5IZ3/GIglzxHfGH/83jh/cG+2/LCvzXmqZYyeTYzj3DIeH8h6M2OPE4W5xrQxQGWTIB1bZfuMj2IXYsUP7iXF5Q4ml759i9XK8lEdqTBFkyDT8MtKW67ltQavkHh6W2opV1NBJQeJTt1HWv5V3tMRF7cqpt5RFtcHABq0DioBzQeQTychehXz+58FdM46AHxA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb6c411a-89da-4e11-b158-08d65512ad93
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 09:20:02.8632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3916
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIExvdGhhcg0KDQpCZXN0IFJlZ2FyZHMhDQpBbnNvbiBIdWFuZw0KDQo+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExvdGhhciBXYcOfbWFubiBbbWFpbHRvOkxXQEtBUk8t
ZWxlY3Ryb25pY3MuZGVdDQo+IFNlbnQ6IDIwMTjlubQxMeaciDI45pelIDE3OjEzDQo+IFRvOiBB
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
YWRkIGkuTVg4UVhQIHN5c3RlbSBjb250cm9sbGVyDQo+IFJUQyBzdXBwb3J0DQo+IA0KPiBBbnNv
biBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4gd3JvdGU6DQo+IA0KPiA+IEhpLCBMb3RoYXIN
Cj4gPg0KPiA+IEJlc3QgUmVnYXJkcyENCj4gPiBBbnNvbiBIdWFuZw0KPiA+DQo+ID4gPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogTG90aGFyIFdhw59tYW5uIFttYWls
dG86TFdAS0FSTy1lbGVjdHJvbmljcy5kZV0NCj4gPiA+IFNlbnQ6IDIwMTjlubQxMeaciDI45pel
IDE3OjA0DQo+ID4gPiBUbzogQW5zb24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5jb20+DQo+ID4g
PiBDYzogYS56dW1tb0B0b3dlcnRlY2guaXQ7IGFsZXhhbmRyZS5iZWxsb25pQGJvb3RsaW4uY29t
Ow0KPiA+ID4gcm9iaCtkdEBrZXJuZWwub3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgY2F0YWxp
bi5tYXJpbmFzQGFybS5jb207DQo+ID4gPiB3aWxsLmRlYWNvbkBhcm0uY29tOyBBaXNoZW5nIERP
TkcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPjsgQW5keQ0KPiBHcm9zcw0KPiA+ID4gPGFuZHkuZ3Jv
c3NAbGluYXJvLm9yZz47IGFybmRAYXJuZGIuZGU7IGhvcm1zK3JlbmVzYXNAdmVyZ2UubmV0LmF1
Ow0KPiA+ID4gaGVpa29Ac250ZWNoLmRlOyBiam9ybi5hbmRlcnNzb25AbGluYXJvLm9yZzsNCj4g
PiA+IGVucmljLmJhbGxldGJvQGNvbGxhYm9yYS5jb207IGFtaXQua3VjaGVyaWFAbGluYXJvLm9y
ZzsNCj4gPiA+IGV6ZXF1aWVsQGNvbGxhYm9yYS5jb207IG9sb2ZAbGl4b20ubmV0OyBzaGF3bmd1
b0BrZXJuZWwub3JnOw0KPiA+ID4gbGludXgtcnRjQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJl
ZUB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+ID4gPiBkbC1saW51eC1pbXgg
PGxpbnV4LWlteEBueHAuY29tPg0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCA0LzRdIEFSTTY0
OiBkdHM6IGlteDogYWRkIGkuTVg4UVhQIHN5c3RlbQ0KPiA+ID4gY29udHJvbGxlciBSVEMgc3Vw
cG9ydA0KPiA+ID4NCj4gPiA+IEhpLA0KPiA+ID4NCj4gPiA+IE9uIFR1ZSwgMjcgTm92IDIwMTgg
MDk6NDE6NDYgKzAwMDAgQW5zb24gSHVhbmcgd3JvdGU6DQo+ID4gPiA+IEFkZCBpLk1YOFFYUCBz
eXN0ZW0gY29udHJvbGxlciBSVEMgc3VwcG9ydC4NCj4gPiA+ID4NCj4gPiA+ID4gU2lnbmVkLW9m
Zi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+
ID4gPiAgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OHF4cC5kdHNpIHwgNCArKysr
DQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQo+ID4gPiA+DQo+ID4g
PiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4cXhwLmR0
c2kNCj4gPiA+IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OHF4cC5kdHNpDQo+
ID4gPiA+IGluZGV4IDkxNTVkNDUuLmVmNTdkYjYgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2FyY2gv
YXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhxeHAuZHRzaQ0KPiA+ID4gPiArKysgYi9hcmNo
L2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4cXhwLmR0c2kNCj4gPiA+ID4gQEAgLTQzMyw0
ICs0MzMsOCBAQA0KPiA+ID4gPiAgCQkjc2l6ZS1jZWxscyA9IDwxPjsNCj4gPiA+ID4gIAkJcmFu
Z2VzID0gPDB4NWYwMDAwMDAgMHgwIDB4NWYwMDAwMDAgMHgxMDAwMDAwPjsNCj4gPiA+ID4gIAl9
Ow0KPiA+ID4gPiArDQo+ID4gPiA+ICsJcnRjOiBydGMgew0KPiA+ID4gPiArCQljb21wYXRpYmxl
ID0gIm54cCxpbXg4cXhwLXNjLXJ0YyI7DQo+ID4gPiA+ICsJfTsNCj4gPiA+ID4gIH07DQo+ID4g
PiBJTU8gdGhpcyBzaG91bGQgYmUgZGlzYWJsZWQgYnkgZGVmYXVsdC4NCj4gPg0KPiA+IFRoaXMg
bW9kdWxlIGlzIE5PVCBkZXBlbmRpbmcgb24gYW55IGJvYXJkIGRlc2lnbiwgc2hvdWxkIGl0IGJl
IGVuYWJsZWQgYnkNCj4gZGVmYXVsdCBpbiBzb2MgZHRzaT8NCj4gPiBMaWtlIHdkb2cgZXRjLi4N
Cj4gPg0KPiBXaGF0IGFib3V0IGV4aXN0aW5nIHVzZXJzIChpZiB0aGVyZSBhcmUgYW55KSwgd2hp
Y2ggd291bGQgaGF2ZSBhIG5ldyBkZXZpY2UNCj4gYXBwZWFyaW5nIHdoZW4gdXBkYXRpbmcgdGhl
IERUQj8NCg0KVGhpcyBpLk1YOFFYUCBpcyBhIG5ldyBTb0Mgb24gdGhlIHdheSB0byB1cHN0cmVh
bSwgbm8gb2xkIGR0YiB1c2VkLCBzbyBpcyBpdCBPSyB0byBrZWVwIGl0IGVuYWJsZWQNCmJ5IGRl
ZmF1bHQgYW5kIGFsaWduZWQgd2l0aCBhbGwgcHJldmlvdXMgaS5NWCBTb0NzJyBSVEMgaW1wbGVt
ZW50YXRpb24/IElmIHdlIGRpc2FibGUgaXQNCmhlcmUsIHdlIGhhdmUgdG8gZW5hYmxlIGl0IGlu
IGFsbCBib2FyZHMgZHRiLiBTbyBpZiBpdCBpcyBOT1QgdmVyeSBjcml0aWNhbCwgaXMgaXQgT0sg
dG8ga2VlcA0KaXQgZW5hYmxlZCBieSBkZWZhdWx0IGhlcmU/IFRoYW5rcy4NCg0KQW5zb24NCg0K
PiANCj4gDQo+IExvdGhhciBXYcOfbWFubg0KPiAtLQ0KPiBfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiANCj4gS2EtUm8gZWxlY3Ry
b25pY3MgR21iSCB8IFBhc2NhbHN0cmHDn2UgMjIgfCBEIC0gNTIwNzYgQWFjaGVuDQo+IFBob25l
OiArNDkgMjQwOCAxNDAyLTAgfCBGYXg6ICs0OSAyNDA4IDE0MDItMTANCj4gR2VzY2jDpGZ0c2bD
vGhyZXI6IE1hdHRoaWFzIEthdXNzZW4NCj4gSGFuZGVsc3JlZ2lzdGVyZWludHJhZzogQW10c2dl
cmljaHQgQWFjaGVuLCBIUkIgNDk5Ng0KPiANCj4gaHR0cHM6Ly9lbWVhMDEuc2FmZWxpbmtzLnBy
b3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD13d3cua2Fyby1lbGVjdHJvbmljcy5kDQo+IGUmYW1w
O2RhdGE9MDIlN0MwMSU3Q2Fuc29uLmh1YW5nJTQwbnhwLmNvbSU3QzEyZmI4ZTU0NmEwZTQ2ZDAz
DQo+IDcyNDA4ZDY1NTExYTQzZiU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdD
MCU3QzAlN0MNCj4gNjM2Nzg5OTMxNjAwNDgzODA3JmFtcDtzZGF0YT1TVlpqcHZZc2k5WEFNN0NH
dDhzSFo1bXQ4clBSYSUyRlBsDQo+IDc1RVF2SFRvZCUyQmclM0QmYW1wO3Jlc2VydmVkPTAgfCBp
bmZvQGthcm8tZWxlY3Ryb25pY3MuZGUNCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCg==
