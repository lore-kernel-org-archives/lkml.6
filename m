Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URI_HEX autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C55ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 14:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24A7F20870
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 14:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="cfMeeRS4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24A7F20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730093AbeGPObe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 10:31:34 -0400
Received: from mail-eopbgr40104.outbound.protection.outlook.com ([40.107.4.104]:25024
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728063AbeGPObe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 10:31:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYi+U5p2Sx9WGc0pjVY0wteKS0SBVdDwLMFXa9XKB6g=;
 b=cfMeeRS4Hian40e5n1+ZDF6seS53MIc/ddOBQ89Xt4VUlKVsd5vZfg/xdRwOQHj0xjPkJgMPHKLF1cBQnttRFDfUwB7+PfSao/DPOX0nv/Pb9AKUKyQdAxFZFCiJPM5dpvFV8mDdkcd/AnbgtURBQ1j0PKIMNG6aWZhbj1v+WTc=
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com (10.168.137.14) by
 VI1PR0501MB1997.eurprd05.prod.outlook.com (10.167.195.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.19; Mon, 16 Jul 2018 14:03:52 +0000
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::dc61:4a61:b84:357e]) by VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::dc61:4a61:b84:357e%6]) with mapi id 15.20.0952.021; Mon, 16 Jul 2018
 14:03:52 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>
CC:     "rpurdie@rpsys.net" <rpurdie@rpsys.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dianders@google.com" <dianders@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "jacek.anaszewski@gmail.com" <jacek.anaszewski@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "briannorris@google.com" <briannorris@google.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "amstan@google.com" <amstan@google.com>,
        "groeck@google.com" <groeck@google.com>
Subject: Re: REGRESSION: [RESEND PATCH v3 1/4] backlight: pwm_bl: linear
 interpolation between brightness-levels
Thread-Topic: REGRESSION: [RESEND PATCH v3 1/4] backlight: pwm_bl: linear
 interpolation between brightness-levels
Thread-Index: AQHUG4R+HyVgZWRryUKWT5nDq5XGE6SP6+4AgABstQCAAULsgIAAJbyAgAAf2oCAAAN2AA==
Date:   Mon, 16 Jul 2018 14:03:52 +0000
Message-ID: <1531749830.6547.25.camel@toradex.com>
References: <20180409083333.1249-1-enric.balletbo@collabora.com>
         <20180409083333.1249-2-enric.balletbo@collabora.com>
         <1531580895.7579.7.camel@toradex.com> <20180715075732.GA2989@wychelm.lan>
         <1531664796.7579.13.camel@toradex.com>
         <20180716094223.syzwviia4wdx74yh@holly.lan>
         <1531742247.6547.4.camel@toradex.com>
         <20180716135127.2hvlqxi6mibp7yrh@holly.lan>
In-Reply-To: <20180716135127.2hvlqxi6mibp7yrh@holly.lan>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0501MB1997;7:/4FI0j94SZYr+CZBeBotRJH3oMN/4SgJgP5w359VF3zfZi6O2LU6QbwQeg9Xmkqdu2Xrnm28x2cUBmuQEoig0NKbxNv5OaR/O59M5H8bQxlhOobAixeRnvJKngRPRjedHDxpT4zdtX2/bp8jygSokVlMhfEwt48FL8a+I70J0AC+OsFJts82zNlIhOh5FY0Wbbwz7ntoIiNdhLoOSY2Il8ovrolB7pwbf1fBVzCvwzLyxF31QkKUd4dUehE9DR1C
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 93a544ce-91e4-4cea-4346-08d5eb24f669
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB1997;
x-ms-traffictypediagnostic: VI1PR0501MB1997:
x-microsoft-antispam-prvs: <VI1PR0501MB1997B0EAFFFC8B40E336F68FFB5D0@VI1PR0501MB1997.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:VI1PR0501MB1997;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB1997;
x-forefront-prvs: 073515755F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39840400004)(366004)(136003)(376002)(346002)(199004)(189003)(8676002)(14454004)(2351001)(36756003)(6512007)(106356001)(8936002)(26005)(478600001)(81156014)(81166006)(6246003)(54906003)(7416002)(5660300001)(6116002)(316002)(105586002)(93886005)(6916009)(2906002)(6436002)(68736007)(86362001)(25786009)(103116003)(2900100001)(5640700003)(186003)(2501003)(66066001)(5250100002)(486006)(53936002)(256004)(305945005)(39060400002)(4326008)(44832011)(97736004)(229853002)(6506007)(446003)(6486002)(3846002)(217873002)(99286004)(102836004)(76176011)(11346002)(2616005)(7736002)(14444005)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0501MB1997;H:VI1PR0501MB2590.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: EleTuBcWSK4rOLNk3LaEOFyjgUjAvoEz84ivOKcV2Y96kXJjoUWZzlXrAiN8aEaidlJAyGATxjByi8RNwor8AIpLV+eN8NugT1XW+C0MKkNbC+ldonssSdBBniXE2IjTc0SZsU6Ev8q8tbcDblXHPlMdbjiTtDexY6kb9yhNGag/edptdFVDPZ7/DtrXHdthQhQIlBx6vuytywqUSnid3qLkEQoyTvx4i3bNAI5t1RqCHeot0gUQ1qUOvkzSWCMnJko4bB+0TxM/g5Qa9TJpmt38lLuBhW0lO9OpYdfZbQSb1rQiEyvBlS1CH/RD3uRwHKLrdZQDOZQ7gIeqN/cq3XIoGmYKbSqKO9k9pq/xMmo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <6937285CC943F041849C258A6DD02789@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93a544ce-91e4-4cea-4346-08d5eb24f669
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2018 14:03:52.7143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB1997
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE4LTA3LTE2IGF0IDE0OjUxICswMTAwLCBEYW5pZWwgVGhvbXBzb24gd3JvdGU6
DQo+IE9uIE1vbiwgSnVsIDE2LCAyMDE4IGF0IDExOjU3OjI5QU0gKzAwMDAsIE1hcmNlbCBaaXN3
aWxlciB3cm90ZToNCj4gPiBPbiBNb24sIDIwMTgtMDctMTYgYXQgMTA6NDIgKzAxMDAsIERhbmll
bCBUaG9tcHNvbiB3cm90ZToNCj4gPiA+ID4gDQo+ID4gPiA+IEZyb20gZGJiMzFkMDBjOWYyODcz
YWZmZWRiY2VhZTkxN2M5ZDdmY2U1ZjgzMiBNb24gU2VwIDE3DQo+ID4gPiA+IDAwOjAwOjAwDQo+
ID4gPiA+IDIwMDENCj4gPiA+ID4gTWVzc2FnZS1JZDoNCj4gPiA+ID4gPGRiYjMxZDAwYzlmMjg3
M2FmZmVkYmNlYWU5MTdjOWQ3ZmNlNWY4MzIuMTUzMTY2NDY2My5naXQubWENCj4gPiA+ID4gcmNl
bC56aXN3aWxlckB0b3JhZGV4LmNvbT4NCj4gPiA+ID4gRnJvbTogRGFuaWVsIFRob21wc29uIDxk
YW5pZWwudGhvbXBzb25AbGluYXJvLm9yZz4NCj4gPiA+ID4gRGF0ZTogU3VuLCAxNSBKdWwgMjAx
OCAwODo0OTowNSArMDEwMA0KPiA+ID4gPiBTdWJqZWN0OiBbUEFUQ0hdIGJhY2tsaWdodDogcHdt
X2JsOiBGaXggdW5pbml0aWFsaXplZCB2YXJpYWJsZQ0KPiA+ID4gPiANCj4gPiA+ID4gQ3VycmVu
dGx5LCBpZiB0aGUgRFQgZG9lcyBub3QgZGVmaW5lIG51bS1pbnRlcnBvbGF0ZWQtc3RlcHMNCj4g
PiA+ID4gdGhlbg0KPiA+ID4gPiBudW1fc3RlcHMgaXMgdW5kZWZpbmVkIG1lYW5pbmcgdGhlIGlu
dGVycG9sYXRpb24gY29kZSB3aWxsDQo+ID4gPiA+IGRlcGxveQ0KPiA+ID4gPiByYW5kb21seS4g
Rml4IHRoaXMuDQo+ID4gPiA+IA0KPiA+ID4gPiBGaXhlczogNTczZmU2ZDFjMjVjICgiYmFja2xp
Z2h0OiBwd21fYmw6IExpbmVhciBpbnRlcnBvbGF0aW9uDQo+ID4gPiA+IGJldHdlZW4NCj4gPiA+
ID4gYnJpZ2h0bmVzcy1sZXZlbHMiKQ0KPiA+ID4gPiBSZXBvcnRlZC1ieTogTWFyY2VsIFppc3dp
bGVyIDxtYXJjZWwuemlzd2lsZXJAdG9yYWRleC5jb20+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6
IERhbmllbCBUaG9tcHNvbiA8ZGFuaWVsLnRob21wc29uQGxpbmFyby5vcmc+DQo+ID4gPiA+IFNp
Z25lZC1vZmYtYnk6IE1hcmNlbCBaaXN3aWxlciA8bWFyY2VsLnppc3dpbGVyQHRvcmFkZXguY29t
Pg0KPiA+ID4gDQo+ID4gPiBJcyBpdCBUZXN0ZWQtYnk6IHRvbz8gSXQgd291bGQgYmUgZ29vZCB0
byBjb25maXJtIEkgd2FzIHJpZ2h0DQo+ID4gPiBhYm91dA0KPiA+ID4gdGhlDQo+ID4gPiBjYXVz
ZSBvZiB0aGUgcHJvYmxlbS4NCj4gPiANCj4gPiBZZXMgYW5kIEkgY29uZmlybSB5b3Ugd2VyZSBy
aWdodC4NCj4gDQo+IFRoYW5rcy4NCj4gDQo+IA0KPiA+ID4gPiAgZHJpdmVycy92aWRlby9iYWNr
bGlnaHQvcHdtX2JsLmMgfCAxOCArKysrKysrKy0tLS0tLS0tLS0NCj4gPiA+ID4gIDEgZmlsZSBj
aGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0KPiA+ID4gPiANCj4gPiA+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlkZW8vYmFja2xpZ2h0L3B3bV9ibC5jDQo+ID4gPiA+
IGIvZHJpdmVycy92aWRlby9iYWNrbGlnaHQvcHdtX2JsLmMNCj4gPiA+ID4gaW5kZXggOWVlNGMx
YjczNWIyLi5lODg0ZDU4OTM3OGQgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvdmlkZW8v
YmFja2xpZ2h0L3B3bV9ibC5jDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvdmlkZW8vYmFja2xpZ2h0
L3B3bV9ibC5jDQo+ID4gPiA+IEBAIC0yNTAsNyArMjUwLDcgQEAgc3RhdGljIGludCBwd21fYmFj
a2xpZ2h0X3BhcnNlX2R0KHN0cnVjdA0KPiA+ID4gPiBkZXZpY2UNCj4gPiA+ID4gKmRldiwNCj4g
PiA+ID4gIAlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5vZGUgPSBkZXYtPm9mX25vZGU7DQo+ID4gPiA+
ICAJdW5zaWduZWQgaW50IG51bV9sZXZlbHMgPSAwOw0KPiA+ID4gPiAgCXVuc2lnbmVkIGludCBs
ZXZlbHNfY291bnQ7DQo+ID4gPiA+IC0JdW5zaWduZWQgaW50IG51bV9zdGVwczsNCj4gPiA+ID4g
Kwl1bnNpZ25lZCBpbnQgbnVtX3N0ZXBzID0gMDsNCj4gPiA+IA0KPiA+ID4gVGhpcyBjYW4gZ28u
IElmIHdlIGNoZWNrIHRoZSByZXR1cm4gY29kZSB0aGVtIHRoaXMgdmFyaWFibGUgaXMgbm8NCj4g
PiA+IGxvbmdlcg0KPiA+ID4gdXNlZCB1bmluaXRpYWxpemVkIFtJJ20gT0sgdG8gbWFrZSB0aGUg
Y2hhbmdlIHRob3VnaC4uLiBzaW5jZQ0KPiA+ID4geW91J3ZlDQo+ID4gPiBrZXB0IG15IG5hbWUg
YXQgdGhlIHRvcCA7LSkgXS4NCj4gPiANCj4gPiBZZXMsIEkgY29uZmlybSB0aGF0IHRoaXMgd29y
a3MgZm9yIG1lLiBBcmUgeW91IGdvbmEgc2VuZCBhIHByb3Blcg0KPiA+IHBhdGNoDQo+ID4gb3V0
IG9yIHNob3VsZCBJIGRvIGl0Pw0KPiANCj4gSSBjYW4gc2VuZCBpdCBvdXQuDQo+IA0KPiANCj4g
RGFuaWVsLg0KDQpUaGFuayB5b3UuDQoNCkNoZWVycw0KDQpNYXJjZWw=
