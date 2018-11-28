Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCFFC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A6CA2081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="F6TfDGEv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A6CA2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbeK1UXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:23:00 -0500
Received: from mail-eopbgr00061.outbound.protection.outlook.com ([40.107.0.61]:6476
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727413AbeK1UW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:22:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4iLhvVZFExrh7POvsge/WsF79cgioYn2ParTaec3wE=;
 b=F6TfDGEvfP/BX3ILQ37OV/qtw96gwlIBoDFYSeW86n698TwryKN/ZoyR23v810V4GeJpKt7PQ7Faw2aGmAY2BpwEcP9OcZwnU1OZgvcPovl+ENBD4A5vNr9y28/sbhY1BV65X7q0iPYMY1x/nt+Kw9HobUKztlOdqV0BJ6XpM/o=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3865.eurprd04.prod.outlook.com (52.134.73.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.16; Wed, 28 Nov 2018 09:21:56 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%2]) with mapi id 15.20.1361.019; Wed, 28 Nov 2018
 09:21:56 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     =?ks_c_5601-1987?B?TG90aGFyIFdhqaxtYW5u?= <LW@KARO-electronics.de>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
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
Thread-Index: AQHUhjVp2fzkoSnTjEGBUoXMaMsjH6Vk5kcAgAAALcCAAAQfgIAAAEBQ
Date:   Wed, 28 Nov 2018 09:21:56 +0000
Message-ID: <DB3PR0402MB39168AC8DB69B81C51CE63C2F5D10@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1543311334-8807-1-git-send-email-Anson.Huang@nxp.com>
 <1543311334-8807-5-git-send-email-Anson.Huang@nxp.com>
 <20181128100420.0c9a721a@karo-electronics.de>
 <DB3PR0402MB3916FFD700313BF684CF32AAF5D10@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20181128091943.GB8952@piout.net>
In-Reply-To: <20181128091943.GB8952@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3865;6:9HxV7vx3vr5hvIMzH0kHUmm05hbcFcuuGFKavvBmMPfPtxOVz/acKKrI+WpMhZJ0HLcSRlc+unQ0PVnsubDY84bpm6MNDGO4fR3/EgDcKua5Ttfe5Fubv80lWLBynXRtUInZ5+J9yDNU4iswqCZueqFxEQZF4uWUbYZ21JKE2pKICzBAw7so08FTJqWcQLoHCg8silt1yz2lJ4Ulw7iJfIb/suJV/tFzdUgDkDhSpSFFf7UtIhhwW3gkE4GiBo1LWDwkcAeHhiJ//8W2e6Zjn5RorlMoMVUBPIPSbPVdlRR8la2vReNQ6Jsv95JUsCs3fYk1HmoZlSFsMwza9gdcTzeKBSqyz1wXNLj+lad8pSvtuCAN7wKjASAnspfkpKPS2FjUDpIzNxjjXKoGOPEhMh6GnmFDykSqWkvDyMQg+0lRZYaZpt6gumSnaJx+5c0CX8wjHu4zGcnStRKrRL97Pg==;5:Buj0NzuGUTRRlMKHCp9djrk00Qw2xl5uN2hRywclbL7YF35KS65GoCQrGfo8ID1ocoCCK4Mw5de2em04r448/JsjaHDHRshTnsgOYxlnXeYIJnny4fui6Jpf1js679C5yDrgkvYWW/WTSt7zWHgSTDBgLtWo7BxCsPaevdnSmOI=;7:kRWh9clX1QMw5PUPI/jsMnUTHxI/nI1bTRcZ96SQV3ozof4SXq6gLGjjHiAnpdRg4EbExoN/kTvD5xXWT1D58spDAHPeXR/eB6FG3Z48KdFr1y0ZLjjqTkk6xgFBrzeV/DIS3KsobuYrIqW8QuIGwQ==
x-ms-office365-filtering-correlation-id: 0a4b20b8-b72e-42bd-8704-08d65512f133
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3865;
x-ms-traffictypediagnostic: DB3PR0402MB3865:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB3PR0402MB38650AE59D16EBEEF21D8E6DF5D10@DB3PR0402MB3865.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231443)(999002)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3865;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3865;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(346002)(136003)(376002)(13464003)(189003)(199004)(446003)(11346002)(26005)(6116002)(305945005)(3846002)(4326008)(86362001)(53936002)(8936002)(45080400002)(5660300001)(9686003)(478600001)(97736004)(6246003)(7416002)(2906002)(55016002)(6306002)(74316002)(105586002)(106356001)(6436002)(14454004)(7736002)(54906003)(256004)(476003)(316002)(14444005)(6916009)(93886005)(6506007)(99286004)(33656002)(102836004)(7696005)(76176011)(44832011)(486006)(25786009)(81156014)(81166006)(966005)(186003)(66066001)(229853002)(71190400001)(71200400001)(66574009)(68736007)(53546011)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3865;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: cDqmtnOG4c5rOBkZEftMT4uYp/hl7dYRwqyQMba9CQtPWq/5NJdXmyeZ7P5/62nngU886/+eO29lau9Upc6gsZg4hbR8GKXsgLUs+uVnpsa4JzuTMH6Na0X03Nw7byV8iIh0FdKoq0Wmusp2jCWvr88JOXgtZuWd5Ws6o+nYf8UrEtryqquqRUkhdFatHFmydC9RxqqrLWw5slcjl2Tk22OkEziUu43vwml4w6/EJDWRTyfxSwmoCB3eSua/NuPNJK1+wpETCXSqQTkpMDsr7Y/Yepi5mq+AU0a41/8bGIFxW6CP3cxsbi3bt8wktl4+9B2FgSwAaTC83e0edt9N/sct0qvOOWVKnnWgI2l5qCM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="ks_c_5601-1987"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a4b20b8-b72e-42bd-8704-08d65512f133
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 09:21:56.3493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3865
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkJlc3QgUmVnYXJkcyENCkFuc29uIEh1YW5nDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gRnJvbTogQWxleGFuZHJlIEJlbGxvbmkgW21haWx0bzphbGV4YW5kcmUuYmVsbG9u
aUBib290bGluLmNvbV0NCj4gU2VudDogMjAxONK0MTHqxTI47O0gMTc6MjANCj4gVG86IEFuc29u
IEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPg0KPiBDYzogTG90aGFyIFdhqaxtYW5uIDxMV0BL
QVJPLWVsZWN0cm9uaWNzLmRlPjsgYS56dW1tb0B0b3dlcnRlY2guaXQ7DQo+IHJvYmgrZHRAa2Vy
bmVsLm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tOw0K
PiB3aWxsLmRlYWNvbkBhcm0uY29tOyBBaXNoZW5nIERPTkcgPGFpc2hlbmcuZG9uZ0BueHAuY29t
PjsgQW5keSBHcm9zcw0KPiA8YW5keS5ncm9zc0BsaW5hcm8ub3JnPjsgYXJuZEBhcm5kYi5kZTsg
aG9ybXMrcmVuZXNhc0B2ZXJnZS5uZXQuYXU7DQo+IGhlaWtvQHNudGVjaC5kZTsgYmpvcm4uYW5k
ZXJzc29uQGxpbmFyby5vcmc7IGVucmljLmJhbGxldGJvQGNvbGxhYm9yYS5jb207DQo+IGFtaXQu
a3VjaGVyaWFAbGluYXJvLm9yZzsgZXplcXVpZWxAY29sbGFib3JhLmNvbTsgb2xvZkBsaXhvbS5u
ZXQ7DQo+IHNoYXduZ3VvQGtlcm5lbC5vcmc7IGxpbnV4LXJ0Y0B2Z2VyLmtlcm5lbC5vcmc7IGRl
dmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGRsLWxpbnV4LWlteCA8
bGludXgtaW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggNC80XSBBUk02NDogZHRz
OiBpbXg6IGFkZCBpLk1YOFFYUCBzeXN0ZW0gY29udHJvbGxlcg0KPiBSVEMgc3VwcG9ydA0KPiAN
Cj4gT24gMjgvMTEvMjAxOCAwOTowNjoyNyswMDAwLCBBbnNvbiBIdWFuZyB3cm90ZToNCj4gPiA+
ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhxeHAuZHRz
aQ0KPiA+ID4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4cXhwLmR0c2kNCj4g
PiA+ID4gaW5kZXggOTE1NWQ0NS4uZWY1N2RiNiAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvYXJjaC9h
cm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OHF4cC5kdHNpDQo+ID4gPiA+ICsrKyBiL2FyY2gv
YXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhxeHAuZHRzaQ0KPiA+ID4gPiBAQCAtNDMzLDQg
KzQzMyw4IEBADQo+ID4gPiA+ICAJCSNzaXplLWNlbGxzID0gPDE+Ow0KPiA+ID4gPiAgCQlyYW5n
ZXMgPSA8MHg1ZjAwMDAwMCAweDAgMHg1ZjAwMDAwMCAweDEwMDAwMDA+Ow0KPiA+ID4gPiAgCX07
DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwlydGM6IHJ0YyB7DQo+ID4gPiA+ICsJCWNvbXBhdGlibGUg
PSAibnhwLGlteDhxeHAtc2MtcnRjIjsNCj4gPiA+ID4gKwl9Ow0KPiA+ID4gPiAgfTsNCj4gPiA+
IElNTyB0aGlzIHNob3VsZCBiZSBkaXNhYmxlZCBieSBkZWZhdWx0Lg0KPiA+DQo+ID4gVGhpcyBt
b2R1bGUgaXMgTk9UIGRlcGVuZGluZyBvbiBhbnkgYm9hcmQgZGVzaWduLCBzaG91bGQgaXQgYmUg
ZW5hYmxlZCBieQ0KPiBkZWZhdWx0IGluIHNvYyBkdHNpPw0KPiA+IExpa2Ugd2RvZyBldGMuLg0K
PiA+DQo+IA0KPiBJIGd1ZXNzIHRoZSBwb2ludCBpcyB0aGF0IHlvdSBtYXkgbm90IHdhbnQgaXQg
ZW5hYmxlZCwgZXZlbiBpZiBpdCBzaG91bGQgYWx3YXlzDQo+IGJlIHdvcmtpbmcuIGVuYWJsaW5n
IGl0IGJ5IGRlZmF1bHQgd291bGQgYWZmZWN0IHRoZSBSVEMgb3JkZXJpbmcgZm9yIGV4YW1wbGUu
DQoNCmkuTVggU29DcyBPTkxZIGhhdmUgMSBSVEMuIEFuZCBSVEMgYXJlIGFsd2F5cyBlbmFibGVk
IGJ5IGRlZmF1bHQgZm9yIGFsbCBpLk1YDQpTb0NzLCBzbyBkbyB3ZSBoYXZlIHRvIGRpc2FibGUg
aXQgaGVyZSBhbmQgZW5hYmxlIGl0IGluIGJvYXJkIGR0cz8NCg0KQW5zb24uDQoNCj4gDQo+IA0K
PiAtLQ0KPiBBbGV4YW5kcmUgQmVsbG9uaSwgQm9vdGxpbg0KPiBFbWJlZGRlZCBMaW51eCBhbmQg
S2VybmVsIGVuZ2luZWVyaW5nDQo+IGh0dHBzOi8vZW1lYTAxLnNhZmVsaW5rcy5wcm90ZWN0aW9u
Lm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZib290bA0KPiBpbi5jb20mYW1wO2RhdGE9
MDIlN0MwMSU3Q2Fuc29uLmh1YW5nJTQwbnhwLmNvbSU3QzA1ODZmZDEwZDZmZjQNCj4gNWQwM2Y0
MzA4ZDY1NTEyYTg2NCU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzAN
Cj4gJTdDNjM2Nzg5OTM1OTUxMjE1NzAzJmFtcDtzZGF0YT1IczFBWFhvWk1NS2w4aW5PWEZzOHhY
TlhROUVKRw0KPiBndHBoeVROaEZ2TWlURSUzRCZhbXA7cmVzZXJ2ZWQ9MA0K
