Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF225ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 08:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E7E620693
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 08:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="QqmYBorx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E7E620693
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730161AbeGRI6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 04:58:52 -0400
Received: from mail-ve1eur01on0108.outbound.protection.outlook.com ([104.47.1.108]:38144
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726282AbeGRI6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 04:58:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVu7JP0fLPns8w9AhjvM48VOtqxbMtm1bwW+nCCzpuE=;
 b=QqmYBorxqZIqTPlJ6CLEFkeZEcVXa2C12i2U7klnN1eoaHwjOacoCI/tg9/oyX4XAlLr3lYTOMmypO4glidzwh922qz1lHN7N2PLD9uLD0XkeU1pgufgEpl+9rrgG1ABdUEoYifmgAnd0QxQnULI/u33klJJVDxxAJbcZYn/sZw=
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com (10.168.137.14) by
 VI1PR0501MB2623.eurprd05.prod.outlook.com (10.172.13.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Wed, 18 Jul 2018 08:22:01 +0000
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::dc61:4a61:b84:357e]) by VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::dc61:4a61:b84:357e%8]) with mapi id 15.20.0973.016; Wed, 18 Jul 2018
 08:22:01 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "patches@linaro.org" <patches@linaro.org>
Subject: Re: [PATCH] backlight: pwm_bl: Fix uninitialized variable
Thread-Topic: [PATCH] backlight: pwm_bl: Fix uninitialized variable
Thread-Index: AQHUHUhtmsif0KNc40KlPUM2WKHIC6SUoqmAgAADkYA=
Date:   Wed, 18 Jul 2018 08:22:01 +0000
Message-ID: <1531902119.16896.13.camel@toradex.com>
References: <20180716210241.9457-1-daniel.thompson@linaro.org>
         <20180718080913.GB4641@dell>
In-Reply-To: <20180718080913.GB4641@dell>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0501MB2623;6:zdWESwb40ehhpjGDncm+C8hN4z4TTzk/1v/Z4TOCwKkSCBxXc4vWfp/lED76MG/mY8MPBsXRgmw6o2a/JIPdi+UJPtw32hi5J2RQH3wPyQNTVleQNYlhZtNiDeUHcwKEYa+cZjdN3IR1nbRV1eat7nYMemKMw59AweY5QsAwGaZrKi1tzuL8wdLfhZfCMlGWwYE8k2tteDpQ6W6j0ckc70af55n/+SWEnMvr6QI5Ko6VQTcoXLx/Z9a+cObX0OLDd4cFPZwxH88A5sKBglrKAYqBoTviz89V+qgShEiPULR+wpuW0kMX1X1zQeSTT860g27Op/lh09WtfkY8Wpg0EQgoggRFmpxpCtbf7ZyaMVoyObRlJ4cs04C1udOvxObuOeAmTh0X4mqzCkyLwWSfHPrjzbSJuy7e0F6TWsQ3tOguhTtKmilOhuwcRQbzHMbhMgmTvgT9YHPbwPFAcaBN+w==;5:4AjORB42Y4DEmK2OjS4M51BG4CZBpXo9LmuOqQ0yml4yrvJ9dpEUcRwlAYfiVSYW/XS8xK4ldGA6ZVg900xpjqZXcVQFIyByrb9jP1iaYKN+dKNR9m/sSdMQt4xwtnuiWU950NUC0Nhi9aOATnAqBTXV+UzNyr2JqGXAUEf+voo=;7:pj15pLsptWARScSciyAXvObbRUFVVwVgqOu32CVTDx0yTP8WC6JyajcMGne2CCtYf8GrkMgoUBmudA+/EjSywE2Upp8t/HzuI3XLXNfS8ieimQiyg0xLicGc4MkwVU0s5QF7rbTNOrUaUisT3+S6T+I0xkHal7Z+UZfBLCkNT2q5LaDOkkRIGPGx6q1lyHc1bGxXpG+boDnYUZfEaYb7A5YLbsI31cuagXbVR0o6yghVLfp+hflhu/Y9esa8i8jS
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 8ac95564-a4d9-4ce2-7934-08d5ec878955
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2623;
x-ms-traffictypediagnostic: VI1PR0501MB2623:
x-microsoft-antispam-prvs: <VI1PR0501MB262359F9B749B8B4C2C22E83FB530@VI1PR0501MB2623.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:VI1PR0501MB2623;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB2623;
x-forefront-prvs: 0737B96801
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(396003)(39840400004)(136003)(366004)(346002)(376002)(189003)(199004)(8936002)(2501003)(6436002)(76176011)(5250100002)(5660300001)(4326008)(3846002)(8676002)(81156014)(316002)(36756003)(105586002)(25786009)(106356001)(6486002)(86362001)(97736004)(81166006)(7416002)(6116002)(446003)(6512007)(6246003)(305945005)(26005)(99286004)(68736007)(7736002)(102836004)(11346002)(53936002)(2616005)(186003)(2900100001)(476003)(54906003)(103116003)(14454004)(256004)(478600001)(2906002)(110136005)(44832011)(229853002)(6506007)(486006)(66066001)(39060400002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0501MB2623;H:VI1PR0501MB2590.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: W3qQhei9GbVPC18gyAIajsJCmdm2h0Ewb6AnWCjjKY/CMyZIga/f9Nqn/WHLuHLQaDSbD5G2vBlGxvqmeN1c3gTG/9gV5dXYz4TTgWjWeMa2tnFz3MKrNiQAaODr8fn9Z7zF20vj7bSkL9tx2WOXvy4T2qgLGzowZgStoAANXdDx+ylOPOkMCJup6BXAhqGSiW22rn8wW5zLoKd1t4Dh3LZn4rReJom5WGWzJty4cJj5MjjbqiyIc54ln+JIcPmc+vP8uvHFzfFnJ8hWDEW9YP0Yl3uAzIYbr1OFR/aRpLrj6Zv5c73klqp/gu6cMjWnavBG7UvD4gRy2kQzj9tp9ngCm0W+7/pn00KOz2KkuHo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <04A66DB3B544DD4A9C4AE4761D15A658@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac95564-a4d9-4ce2-7934-08d5ec878955
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2018 08:22:01.0442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2623
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE4LTA3LTE4IGF0IDA5OjA5ICswMTAwLCBMZWUgSm9uZXMgd3JvdGU6DQo+IE9u
IE1vbiwgMTYgSnVsIDIwMTgsIERhbmllbCBUaG9tcHNvbiB3cm90ZToNCj4gDQo+ID4gQ3VycmVu
dGx5LCBpZiB0aGUgRFQgZG9lcyBub3QgZGVmaW5lIG51bS1pbnRlcnBvbGF0ZWQtc3RlcHMgdGhl
bg0KPiA+IG51bV9zdGVwcyBpcyB1bmRlZmluZWQgYW5kIHRoZSBpbnRlcnBvbGF0aW9uIGNvZGUg
d2lsbCBkZXBsb3kNCj4gPiByYW5kb21seS4NCj4gPiBGaXggdGhpcy4NCj4gPiANCj4gPiBGaXhl
czogNTczZmU2ZDFjMjVjICgiYmFja2xpZ2h0OiBwd21fYmw6IExpbmVhciBpbnRlcnBvbGF0aW9u
DQo+ID4gYmV0d2Vlbg0KPiA+IGJyaWdodG5lc3MtbGV2ZWxzIikNCj4gPiBSZXBvcnRlZC1ieTog
TWFyY2VsIFppc3dpbGVyIDxtYXJjZWwuemlzd2lsZXJAdG9yYWRleC5jb20+DQo+ID4gU2lnbmVk
LW9mZi1ieTogRGFuaWVsIFRob21wc29uIDxkYW5pZWwudGhvbXBzb25AbGluYXJvLm9yZz4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBNYXJjZWwgWmlzd2lsZXIgPG1hcmNlbC56aXN3aWxlckB0b3JhZGV4
LmNvbT4NCj4gDQo+IFRoaXMgbGluZSBpcyBjb25mdXNpbmcuICBEaWQgeW91IGd1eXMgYXV0aG9y
IHRoaXMgcGF0Y2ggdG9nZXRoZXI/DQoNClllcywgSSByZXBvcnRlZCBpdCBhbmQgd2UgY2FtZSB0
byBhIGNvbmNsdXNpb24gdG9nZXRoZXIuDQoNCj4gTXkgZ3Vlc3MgaXMgdGhhdCB0aGlzIGxpbmUg
c2hvdWxkIGJlIGRyb3BwZWQgYW5kIHRoZSBSQiBhbmQgVEIgdGFncw0KPiBzaG91bGQgcmVtYWlu
PyAgSWYgaXQgd2FzIHJldmlld2VkIHRvbywgcGVyaGFwcyBhbiBBQiB0b28/DQoNCkknbSBPSyBl
aXRoZXIgd2F5IGFuZCBkbyBub3QgbmVlZCBhbnkgZXhwbGljaXQgYXV0aG9yc2hpcCB0byBiZQ0K
ZXhwcmVzc2VkIGZvciBtZS4NCg0KPiA+IFRlc3RlZC1ieTogTWFyY2VsIFppc3dpbGVyIDxtYXJj
ZWwuemlzd2lsZXJAdG9yYWRleC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvdmlkZW8vYmFj
a2xpZ2h0L3B3bV9ibC5jIHwgMTcgKysrKysrKystLS0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDggaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy92aWRlby9iYWNrbGlnaHQvcHdtX2JsLmMNCj4gPiBiL2RyaXZlcnMvdmlkZW8v
YmFja2xpZ2h0L3B3bV9ibC5jDQo+ID4gaW5kZXggOWVlNGMxYjczNWIyLi5lM2MyMmI3OWZiY2Qg
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy92aWRlby9iYWNrbGlnaHQvcHdtX2JsLmMNCj4gPiAr
KysgYi9kcml2ZXJzL3ZpZGVvL2JhY2tsaWdodC9wd21fYmwuYw0KPiA+IEBAIC0yOTksMTUgKzI5
OSwxNCBAQCBzdGF0aWMgaW50IHB3bV9iYWNrbGlnaHRfcGFyc2VfZHQoc3RydWN0DQo+ID4gZGV2
aWNlICpkZXYsDQo+ID4gIAkJICogaW50ZXJwb2xhdGlvbiBiZXR3ZWVuIGVhY2ggb2YgdGhlIHZh
bHVlcyBvZg0KPiA+IGJyaWdodG5lc3MgbGV2ZWxzDQo+ID4gIAkJICogYW5kIGNyZWF0ZXMgYSBu
ZXcgcHJlLWNvbXB1dGVkIHRhYmxlLg0KPiA+ICAJCSAqLw0KPiA+IC0JCW9mX3Byb3BlcnR5X3Jl
YWRfdTMyKG5vZGUsICJudW0taW50ZXJwb2xhdGVkLQ0KPiA+IHN0ZXBzIiwNCj4gPiAtCQkJCSAg
ICAgJm51bV9zdGVwcyk7DQo+ID4gLQ0KPiA+IC0JCS8qDQo+ID4gLQkJICogTWFrZSBzdXJlIHRo
YXQgdGhlcmUgaXMgYXQgbGVhc3QgdHdvIGVudHJpZXMgaW4NCj4gPiB0aGUNCj4gPiAtCQkgKiBi
cmlnaHRuZXNzLWxldmVscyB0YWJsZSwgb3RoZXJ3aXNlIHdlIGNhbid0DQo+ID4gaW50ZXJwb2xh
dGUNCj4gPiAtCQkgKiBiZXR3ZWVuIHR3byBwb2ludHMuDQo+ID4gLQkJICovDQo+ID4gLQkJaWYg
KG51bV9zdGVwcykgew0KPiA+ICsJCWlmICgob2ZfcHJvcGVydHlfcmVhZF91MzIobm9kZSwgIm51
bS1pbnRlcnBvbGF0ZWQtDQo+ID4gc3RlcHMiLA0KPiA+ICsJCQkJCSAgJm51bV9zdGVwcykgPT0g
MCkgJiYNCj4gPiBudW1fc3RlcHMpIHsNCj4gDQo+IFRoaXMgaXMgcHJldHR5IHVnbHksIGFuZCBp
c24ndCBpdCBzdWZmZXJpbmcgZnJvbSBvdmVyLWJyYWNrZXRpbmc/ICBNeQ0KPiBzdWdnZXN0aW9u
IHdvdWxkIGJlIHRvIGJyZWFrIG91dCB0aGUgaW52b2NhdGlvbiBvZg0KPiBvZl9wcm9wZXJ0eV9y
ZWFkX3UzMigpIGZyb20gdGhlIGlmIGFuZCB0ZXN0IG9ubHkgdGhlIHJlc3VsdC4NCj4gDQo+IAkJ
b2ZfcHJvcGVydHlfcmVhZF91MzIobm9kZSwgIm51bS1pbnRlcnBvbGF0ZWQtc3RlcHMiLCANCj4g
Jm51bV9zdGVwcyk7DQoNCnlvdSBtZWFuOg0KDQoJCXJldCA9IG9mX3Byb3BlcnR5X3JlYWRfdTMy
KG5vZGUsICJudW0taW50ZXJwb2xhdGVkLQ0Kc3RlcHMiLCAmbnVtX3N0ZXBzKTsNCg0KPiAJCWlm
ICghcmV0ICYmIG51bV9zdGVwcykgew0KPiANCj4gSSBoYXZlbid0IGNoZWNrZWQgdGhlIHVuZGVy
bGluZyBjb2RlLCBidXQgaXMgaXQgZXZlbiBmZWFzaWJsZSBmb3INCj4gb2ZfcHJvcGVydHlfcmVh
ZF91MzIoKSB0byBub3Qgc3VjY2VlZCBBTkQgZm9yIG51bV9zdGVwcyB0byBiZSBzZXQ/DQo+IA0K
PiBJZiBub3QsIHRoZSBjaGVjayBmb3IgIXJldCBpZiBzdXBlcmZsdW91cyBhbmQgeW91IGNhbiBk
cm9wIGl0Lg0KDQpObywgdGhlbiB3ZSBhcmUgYmFjayB0byB0aGUgaW5pdGlhbCBpc3N1ZSBvZiBu
dW1fc3RlcHMgcG90ZW50aWFsbHkgbm90DQpiZWluZyBpbml0aWFsaXNlZC4gV2UgcmVhbGx5IHdh
bnQgYm90aCBvZl9wcm9wZXJ0eV9yZWFkX3UzMigpIHRvDQpzdWNjZWVkIEFORCBudW1fc3RlcHMg
dG8gYWN0dWFsbHkgYmUgc2V0Lg0KDQo+ID4gKwkJCS8qDQo+ID4gKwkJCSAqIE1ha2Ugc3VyZSB0
aGF0IHRoZXJlIGlzIGF0IGxlYXN0IHR3bw0KPiA+IGVudHJpZXMgaW4gdGhlDQo+IA0KPiBzL2lz
L2FyZS8NCj4gDQo+ID4gKwkJCSAqIGJyaWdodG5lc3MtbGV2ZWxzIHRhYmxlLCBvdGhlcndpc2Ug
d2UNCj4gPiBjYW4ndA0KPiA+ICsJCQkgKiBpbnRlcnBvbGF0ZQ0KPiANCj4gV2h5IGJyZWFrIHRo
ZSBsaW5lIGhlcmU/DQoNClRoYXQncyBwcm9iYWJseSBhIHJlbW5hbnQgb2YgZ29pbmcgYmFjayBh
bmQgZm9ydGggcGx1cyBxdW90aW5nIG9uIHRoZQ0KbWFpbGluZyBsaXN0Lg0KDQo+ID4gKwkJCSAq
IGJldHdlZW4gdHdvIHBvaW50cy4NCj4gPiArCQkJICovDQo+ID4gIAkJCWlmIChkYXRhLT5tYXhf
YnJpZ2h0bmVzcyA8IDIpIHsNCj4gPiAgCQkJCWRldl9lcnIoZGV2LCAiY2FuJ3QNCj4gPiBpbnRl
cnBvbGF0ZVxuIik7DQo+ID4gIAkJCQlyZXR1cm4gLUVJTlZBTDs=
