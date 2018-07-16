Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URI_HEX autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A56CECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A292208E9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="sdEdtD11"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A292208E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730027AbeGPMYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 08:24:42 -0400
Received: from mail-eopbgr10130.outbound.protection.outlook.com ([40.107.1.130]:15360
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728574AbeGPMYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 08:24:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSisbO6zNmYv6SgCAIzAnWeUxcozAsA74wjocPt4rGk=;
 b=sdEdtD11PYH+kFTEiNKxSpJQhE9OMIuI5Tv7dCJBHR5tfIDiRoD/+yziGsEbT3Up7VNqQGOhtCrU0bCVx1Ujf3rzX/Km/VyCvXwlFgC4aUd3fh1ZI8cgV88tcNpnx06pNEX7GRt91slwivMdCFjj8QPVh2lgch1qrOl3l4X2mu0=
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com (10.168.137.14) by
 VI1PR0501MB2110.eurprd05.prod.outlook.com (10.167.196.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.18; Mon, 16 Jul 2018 11:57:29 +0000
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::dc61:4a61:b84:357e]) by VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::dc61:4a61:b84:357e%6]) with mapi id 15.20.0952.021; Mon, 16 Jul 2018
 11:57:29 +0000
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
Thread-Index: AQHUG4R+HyVgZWRryUKWT5nDq5XGE6SP6+4AgABstQCAAULsgIAAJbyA
Date:   Mon, 16 Jul 2018 11:57:29 +0000
Message-ID: <1531742247.6547.4.camel@toradex.com>
References: <20180409083333.1249-1-enric.balletbo@collabora.com>
         <20180409083333.1249-2-enric.balletbo@collabora.com>
         <1531580895.7579.7.camel@toradex.com> <20180715075732.GA2989@wychelm.lan>
         <1531664796.7579.13.camel@toradex.com>
         <20180716094223.syzwviia4wdx74yh@holly.lan>
In-Reply-To: <20180716094223.syzwviia4wdx74yh@holly.lan>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0501MB2110;7:GQ+NR5I8NP6zN4SMPlJGyjfLH3EP/sBHni9m/l7yWwegssVoI1vcuew0ztNJ03BlbCZCvhALdtiiBWw9RkDi3D2IH48LyouG4TfaFctyrTsHJam4ge3+zsUoUaZ8aDcXY0RBkv3uyghsoBoFAGm4zQtTxX2KptOyPK8yxr8dwNTMB8ERCfghABZRctDNCIEhR/1ZJGyS+sWYGjwI0DppkPDLHRJOVZlKKLTnJDx3GJ663btnxjHu4OtjZNupoib/
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 6c3b530e-9589-4979-b8be-08d5eb134e83
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2110;
x-ms-traffictypediagnostic: VI1PR0501MB2110:
x-microsoft-antispam-prvs: <VI1PR0501MB2110B16B881FCF14EAC422A8FB5D0@VI1PR0501MB2110.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR0501MB2110;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB2110;
x-forefront-prvs: 073515755F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(396003)(136003)(366004)(346002)(376002)(199004)(189003)(229853002)(26005)(93886005)(53546011)(6486002)(6436002)(54906003)(14444005)(5640700003)(486006)(106356001)(5250100002)(256004)(2501003)(476003)(217873002)(44832011)(99286004)(102836004)(8936002)(575784001)(86362001)(25786009)(6506007)(4326008)(97736004)(68736007)(76176011)(3846002)(6116002)(2900100001)(105586002)(6512007)(36756003)(7736002)(5660300001)(81156014)(7416002)(305945005)(6916009)(81166006)(2351001)(53936002)(446003)(6246003)(186003)(39060400002)(11346002)(2616005)(66066001)(316002)(103116003)(8676002)(478600001)(14454004)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0501MB2110;H:VI1PR0501MB2590.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: gW/qJS0HBThfZrq4LQbf/rzPjfCD/Hbh7VR03ucgNgOZZVXwLEYt1O2q+8a1bI4oZiJHMiJoliWJKEMzMfEKWrO7Nh4Uj6ylG+jxO4VHEpvISNBrUjsAOqCZfrRrakgP8trNGSoyagVBLKElEr26Tc7e1k/i+2XXPqYpCTLYjpCCbm3ClDIFPE3ZNmYiI7r1uMjpWHxpw4p9ZSDk5rprU8cee6b9/cez5gh2a5RB5hCQ0SGnCdRrgLocVQowsUS1bgeRfI/Kbq4NtcoI1Fl1V8dBnP5Ij1YUlsXFc/VmmU9kORsaNwF9oHY1Lsegy3HOAyC5UaOfPGOUqcPsQlX8fB/6+CPUnbd4DrO28htRXmU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <D8909C86F8A00848B5A909019F3BB688@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c3b530e-9589-4979-b8be-08d5eb134e83
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2018 11:57:29.5704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE4LTA3LTE2IGF0IDEwOjQyICswMTAwLCBEYW5pZWwgVGhvbXBzb24gd3JvdGU6
DQo+IE9uIFN1biwgSnVsIDE1LCAyMDE4IGF0IDAyOjI2OjQ0UE0gKzAwMDAsIE1hcmNlbCBaaXN3
aWxlciB3cm90ZToNCj4gPiBPbiBTdW4sIDIwMTgtMDctMTUgYXQgMDg6NTcgKzAxMDAsIERhbmll
bCBUaG9tcHNvbiB3cm90ZToNCj4gPiA+IE9uIFNhdCwgSnVsIDE0LCAyMDE4IGF0IDAzOjA4OjE3
UE0gKzAwMDAsIE1hcmNlbCBaaXN3aWxlciB3cm90ZToNCj4gPiA+ID4gT24gTW9uLCAyMDE4LTA0
LTA5IGF0IDEwOjMzICswMjAwLCBFbnJpYyBCYWxsZXRibyBpIFNlcnJhDQo+ID4gPiA+IHdyb3Rl
Og0KPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpZGVvL2JhY2tsaWdodC9wd21fYmwu
Yw0KPiA+ID4gPiA+IGIvZHJpdmVycy92aWRlby9iYWNrbGlnaHQvcHdtX2JsLmMNCj4gPiA+ID4g
PiBpbmRleCA4ZTNmMTI0NWY1YzUuLmYwYTEwOGFiNTcwYSAxMDA2NDQNCj4gPiA+ID4gPiAtLS0g
YS9kcml2ZXJzL3ZpZGVvL2JhY2tsaWdodC9wd21fYmwuYw0KPiA+ID4gPiA+ICsrKyBiL2RyaXZl
cnMvdmlkZW8vYmFja2xpZ2h0L3B3bV9ibC5jDQo+ID4gPiA+ID4gQEAgLTE0Nyw3ICsxNDcsMTEg
QEAgc3RhdGljIGludCBwd21fYmFja2xpZ2h0X3BhcnNlX2R0KHN0cnVjdA0KPiA+ID4gPiA+IGRl
dmljZQ0KPiA+ID4gPiA+ICpkZXYsDQo+ID4gPiA+ID4gIAkJCQkgIHN0cnVjdA0KPiA+ID4gPiA+
IHBsYXRmb3JtX3B3bV9iYWNrbGlnaHRfZGF0YQ0KPiA+ID4gPiA+ICpkYXRhKQ0KPiA+ID4gPiA+
ICB7DQo+ID4gPiA+ID4gIAlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5vZGUgPSBkZXYtPm9mX25vZGU7
DQo+ID4gPiA+ID4gKwl1bnNpZ25lZCBpbnQgbnVtX2xldmVscyA9IDA7DQo+ID4gPiA+ID4gKwl1
bnNpZ25lZCBpbnQgbGV2ZWxzX2NvdW50Ow0KPiA+ID4gPiA+ICsJdW5zaWduZWQgaW50IG51bV9z
dGVwczsNCj4gPiA+IA0KPiA+ID4gbnVtX3N0ZXBzIGlzIG5vdCBpbml0aWFsaXplZC4uLg0KPiA+
ID4gDQo+ID4gPiANCj4gPiA+ID4gPiAgCXN0cnVjdCBwcm9wZXJ0eSAqcHJvcDsNCj4gPiA+ID4g
PiArCXVuc2lnbmVkIGludCAqdGFibGU7DQo+ID4gPiA+ID4gIAlpbnQgbGVuZ3RoOw0KPiA+ID4g
PiA+ICAJdTMyIHZhbHVlOw0KPiA+ID4gPiA+ICAJaW50IHJldDsNCj4gPiA+ID4gPiBAQCAtMTY3
LDYgKzE3MSw3IEBAIHN0YXRpYyBpbnQgcHdtX2JhY2tsaWdodF9wYXJzZV9kdChzdHJ1Y3QNCj4g
PiA+ID4gPiBkZXZpY2UNCj4gPiA+ID4gPiAqZGV2LA0KPiA+ID4gPiA+ICAJLyogcmVhZCBicmln
aHRuZXNzIGxldmVscyBmcm9tIERUIHByb3BlcnR5ICovDQo+ID4gPiA+ID4gIAlpZiAoZGF0YS0+
bWF4X2JyaWdodG5lc3MgPiAwKSB7DQo+ID4gPiA+ID4gIAkJc2l6ZV90IHNpemUgPSBzaXplb2Yo
KmRhdGEtPmxldmVscykgKiBkYXRhLQ0KPiA+ID4gPiA+ID4gbWF4X2JyaWdodG5lc3M7DQo+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gKwkJdW5zaWduZWQgaW50IGksIGosIG4gPSAwOw0KPiA+ID4gPiA+
ICANCj4gPiA+ID4gPiAgCQlkYXRhLT5sZXZlbHMgPSBkZXZtX2t6YWxsb2MoZGV2LCBzaXplLA0K
PiA+ID4gPiA+IEdGUF9LRVJORUwpOw0KPiA+ID4gPiA+ICAJCWlmICghZGF0YS0+bGV2ZWxzKQ0K
PiA+ID4gPiA+IEBAIC0xODQsNiArMTg5LDg0IEBAIHN0YXRpYyBpbnQgcHdtX2JhY2tsaWdodF9w
YXJzZV9kdChzdHJ1Y3QNCj4gPiA+ID4gPiBkZXZpY2UNCj4gPiA+ID4gPiAqZGV2LA0KPiA+ID4g
PiA+ICAJCQlyZXR1cm4gcmV0Ow0KPiA+ID4gPiA+ICANCj4gPiA+ID4gPiAgCQlkYXRhLT5kZnRf
YnJpZ2h0bmVzcyA9IHZhbHVlOw0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArCQkvKg0KPiA+ID4g
PiA+ICsJCSAqIFRoaXMgcHJvcGVydHkgaXMgb3B0aW9uYWwsIGlmIGlzIHNldA0KPiA+ID4gPiA+
IGVuYWJsZXMNCj4gPiA+ID4gPiBsaW5lYXINCj4gPiA+ID4gPiArCQkgKiBpbnRlcnBvbGF0aW9u
IGJldHdlZW4gZWFjaCBvZiB0aGUgdmFsdWVzDQo+ID4gPiA+ID4gb2YNCj4gPiA+ID4gPiBicmln
aHRuZXNzIGxldmVscw0KPiA+ID4gPiA+ICsJCSAqIGFuZCBjcmVhdGVzIGEgbmV3IHByZS1jb21w
dXRlZCB0YWJsZS4NCj4gPiA+ID4gPiArCQkgKi8NCj4gPiA+ID4gPiArCQlvZl9wcm9wZXJ0eV9y
ZWFkX3UzMihub2RlLCAibnVtLQ0KPiA+ID4gPiA+IGludGVycG9sYXRlZC0NCj4gPiA+ID4gPiBz
dGVwcyIsDQo+ID4gPiA+ID4gKwkJCQkgICAgICZudW1fc3RlcHMpOw0KPiA+ID4gDQo+ID4gPiAu
Li4gdGhpcyBpcyBub3QgZ3VhcmFudGVlZCB0byBpbml0aWFsaXplZCBudW1fc3RlcHMgLi4uDQo+
ID4gDQo+ID4gWWVzLCBhcyBpdCBvbmx5IGRvZXMgc28gaWYgcmV0dXJuaW5nIHplcm8uIEkgZG8g
ZnVydGhlciBwcm9wb3NlIHRvDQo+ID4gY2hlY2sgaXRzIHJldHVybiB2YWx1ZSBhcyB3ZWxsLiBJ
c24ndCB0aGF0IHdoYXQgcmV0dXJuIHZhbHVlcyBhcmUNCj4gPiB1c2VkDQo+ID4gZm9yPw0KPiAN
Cj4gSSBkb24ndCBtdWNoIG1pbmQgZWl0aGVyIHdheS4NCj4gDQo+IEkgb3JpZ2luYWxseSB3cm90
ZSB0aGUgcGF0Y2ggeW91IHNoYXJlZCBiZWxvdyBidXQgdGhlbiBkZWNpZGVkIHRvIGFzaw0KPiB5
b3UNCj4gdG8gdGVzdCBhbmQsIHNpbmNlIEkgZGlkbid0IGNvbXBpbGUgdGVzdCBiZWZvcmUgZG9p
bmcgc28sIEkgb3B0ZWQgZm9yDQo+IHNvbWV0aGluZyBtb3JlIGltbXVuZSB0byBzaWxseSBtaXN0
YWtlcy4NCj4gDQo+IA0KPiA+IFF1b3RpbmcgZnJvbSBpbmNsdWRlL2xpbnV4L29mLmg6DQo+ID4g
DQo+ID4gU2VhcmNoIGZvciBhIHByb3BlcnR5IGluIGEgZGV2aWNlIG5vZGUgYW5kIHJlYWQgMzIt
Yml0IHZhbHVlKHMpDQo+ID4gZnJvbQ0KPiA+IGl0LiBSZXR1cm5zIDAgb24gc3VjY2VzcywgLUVJ
TlZBTCBpZiB0aGUgcHJvcGVydHkgZG9lcyBub3QgZXhpc3QsDQo+ID4gLUVOT0RBVEEgaWYgcHJv
cGVydHkgZG9lcyBub3QgaGF2ZSBhIHZhbHVlLCBhbmQgLUVPVkVSRkxPVyBpZiB0aGUNCj4gPiBw
cm9wZXJ0eSBkYXRhIGlzbid0IGxhcmdlIGVub3VnaC4NCj4gPiANCj4gPiA+ID4gPiArDQo+ID4g
PiA+ID4gKwkJLyoNCj4gPiA+ID4gPiArCQkgKiBNYWtlIHN1cmUgdGhhdCB0aGVyZSBpcyBhdCBs
ZWFzdCB0d28NCj4gPiA+ID4gPiBlbnRyaWVzDQo+ID4gPiA+ID4gaW4NCj4gPiA+ID4gPiB0aGUN
Cj4gPiA+ID4gPiArCQkgKiBicmlnaHRuZXNzLWxldmVscyB0YWJsZSwgb3RoZXJ3aXNlIHdlDQo+
ID4gPiA+ID4gY2FuJ3QNCj4gPiA+ID4gPiBpbnRlcnBvbGF0ZQ0KPiA+ID4gPiA+ICsJCSAqIGJl
dHdlZW4gdHdvIHBvaW50cy4NCj4gPiA+ID4gPiArCQkgKi8NCj4gPiA+ID4gPiArCQlpZiAobnVt
X3N0ZXBzKSB7DQo+ID4gPiANCj4gPiA+IC4uLiBhbmQgd2UgbWFrZSBhIGRlY2lzaW9uIG9uIGl0
IGhlcmUuDQo+ID4gPiANCj4gPiA+IE1hcmNlbDogQ2FuIHlvdSB0cnkgdGhlIGZvbGxvd2luZyBx
dWljayBmaXg/IEl0J3MgdW50ZXN0ZWQgb24gbXkNCj4gPiA+IHNpZGUNCj4gPiA+ICAgICAgICAg
YnV0IHZlcnkgc2ltcGxlLi4uDQo+ID4gPiANCj4gPiA+IEZyb20gNmZhMmZiZWIwMTcwODYxNDdh
YzYxOTgxMTA3YTk1Y2I4YWU3YjRlNyBNb24gU2VwIDE3IDAwOjAwOjAwDQo+ID4gPiAyMDAxDQo+
ID4gPiBGcm9tOiBEYW5pZWwgVGhvbXBzb24gPGRhbmllbC50aG9tcHNvbkBsaW5hcm8ub3JnPg0K
PiA+ID4gRGF0ZTogU3VuLCAxNSBKdWwgMjAxOCAwODo0OTowNSArMDEwMA0KPiA+ID4gU3ViamVj
dDogW1BBVENIXSBiYWNrbGlnaHQ6IHB3bV9ibDogRml4IHVuaW5pdGlhbGl6ZWQgdmFyaWFibGUN
Cj4gPiA+IA0KPiA+ID4gQ3VycmVudGx5LCBpZiB0aGUgRFQgZG9lcyBub3QgZGVmaW5lIG51bS1p
bnRlcnBvbGF0ZWQtc3RlcHMgdGhlbg0KPiA+ID4gbnVtX3N0ZXBzIGlzIHVuZGVmaW5lZCBtZWFu
aW5nIHRoZSBpbnRlcnBvbGF0aW9uIGNvZGUgd2lsbCBkZXBsb3kNCj4gPiA+IHJhbmRvbWx5LiBG
aXggdGhpcy4NCj4gPiA+IA0KPiA+ID4gRml4ZXM6IDU3M2ZlNmQxYzI1YyAoImJhY2tsaWdodDog
cHdtX2JsOiBMaW5lYXIgaW50ZXJwb2xhdGlvbg0KPiA+ID4gYmV0d2Vlbg0KPiA+ID4gYnJpZ2h0
bmVzcy1sZXZlbHMiKQ0KPiA+ID4gUmVwb3J0ZWQtYnk6IE1hcmNlbCBaaXN3aWxlciA8bWFyY2Vs
Lnppc3dpbGVyQHRvcmFkZXguY29tPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogRGFuaWVsIFRob21w
c29uIDxkYW5pZWwudGhvbXBzb25AbGluYXJvLm9yZz4NCj4gPiA+IC0tLQ0KPiA+ID4gIGRyaXZl
cnMvdmlkZW8vYmFja2xpZ2h0L3B3bV9ibC5jIHwgMiArLQ0KPiA+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy92aWRlby9iYWNrbGlnaHQvcHdtX2JsLmMNCj4gPiA+IGIvZHJpdmVycy92aWRl
by9iYWNrbGlnaHQvcHdtX2JsLmMNCj4gPiA+IGluZGV4IDllZTRjMWI3MzViMi4uYmRmY2MwYTcx
ZGIxIDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy92aWRlby9iYWNrbGlnaHQvcHdtX2JsLmMN
Cj4gPiA+ICsrKyBiL2RyaXZlcnMvdmlkZW8vYmFja2xpZ2h0L3B3bV9ibC5jDQo+ID4gPiBAQCAt
MjUwLDcgKzI1MCw3IEBAIHN0YXRpYyBpbnQgcHdtX2JhY2tsaWdodF9wYXJzZV9kdChzdHJ1Y3QN
Cj4gPiA+IGRldmljZQ0KPiA+ID4gKmRldiwNCj4gPiA+ICAJc3RydWN0IGRldmljZV9ub2RlICpu
b2RlID0gZGV2LT5vZl9ub2RlOw0KPiA+ID4gIAl1bnNpZ25lZCBpbnQgbnVtX2xldmVscyA9IDA7
DQo+ID4gPiAgCXVuc2lnbmVkIGludCBsZXZlbHNfY291bnQ7DQo+ID4gPiAtCXVuc2lnbmVkIGlu
dCBudW1fc3RlcHM7DQo+ID4gPiArCXVuc2lnbmVkIGludCBudW1fc3RlcHMgPSAwOw0KPiA+ID4g
IAlzdHJ1Y3QgcHJvcGVydHkgKnByb3A7DQo+ID4gPiAgCXVuc2lnbmVkIGludCAqdGFibGU7DQo+
ID4gPiAgCWludCBsZW5ndGg7DQo+ID4gPiAtLQ0KPiA+ID4gMi4xNy4xDQo+ID4gDQo+ID4gRnJv
bSBkYmIzMWQwMGM5ZjI4NzNhZmZlZGJjZWFlOTE3YzlkN2ZjZTVmODMyIE1vbiBTZXAgMTcgMDA6
MDA6MDANCj4gPiAyMDAxDQo+ID4gTWVzc2FnZS1JZDoNCj4gPiA8ZGJiMzFkMDBjOWYyODczYWZm
ZWRiY2VhZTkxN2M5ZDdmY2U1ZjgzMi4xNTMxNjY0NjYzLmdpdC5tYQ0KPiA+IHJjZWwuemlzd2ls
ZXJAdG9yYWRleC5jb20+DQo+ID4gRnJvbTogRGFuaWVsIFRob21wc29uIDxkYW5pZWwudGhvbXBz
b25AbGluYXJvLm9yZz4NCj4gPiBEYXRlOiBTdW4sIDE1IEp1bCAyMDE4IDA4OjQ5OjA1ICswMTAw
DQo+ID4gU3ViamVjdDogW1BBVENIXSBiYWNrbGlnaHQ6IHB3bV9ibDogRml4IHVuaW5pdGlhbGl6
ZWQgdmFyaWFibGUNCj4gPiANCj4gPiBDdXJyZW50bHksIGlmIHRoZSBEVCBkb2VzIG5vdCBkZWZp
bmUgbnVtLWludGVycG9sYXRlZC1zdGVwcyB0aGVuDQo+ID4gbnVtX3N0ZXBzIGlzIHVuZGVmaW5l
ZCBtZWFuaW5nIHRoZSBpbnRlcnBvbGF0aW9uIGNvZGUgd2lsbCBkZXBsb3kNCj4gPiByYW5kb21s
eS4gRml4IHRoaXMuDQo+ID4gDQo+ID4gRml4ZXM6IDU3M2ZlNmQxYzI1YyAoImJhY2tsaWdodDog
cHdtX2JsOiBMaW5lYXIgaW50ZXJwb2xhdGlvbg0KPiA+IGJldHdlZW4NCj4gPiBicmlnaHRuZXNz
LWxldmVscyIpDQo+ID4gUmVwb3J0ZWQtYnk6IE1hcmNlbCBaaXN3aWxlciA8bWFyY2VsLnppc3dp
bGVyQHRvcmFkZXguY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IERhbmllbCBUaG9tcHNvbiA8ZGFu
aWVsLnRob21wc29uQGxpbmFyby5vcmc+DQo+ID4gU2lnbmVkLW9mZi1ieTogTWFyY2VsIFppc3dp
bGVyIDxtYXJjZWwuemlzd2lsZXJAdG9yYWRleC5jb20+DQo+IA0KPiBJcyBpdCBUZXN0ZWQtYnk6
IHRvbz8gSXQgd291bGQgYmUgZ29vZCB0byBjb25maXJtIEkgd2FzIHJpZ2h0IGFib3V0DQo+IHRo
ZQ0KPiBjYXVzZSBvZiB0aGUgcHJvYmxlbS4NCg0KWWVzIGFuZCBJIGNvbmZpcm0geW91IHdlcmUg
cmlnaHQuDQoNCj4gPiAtLS0NCj4gPiAgZHJpdmVycy92aWRlby9iYWNrbGlnaHQvcHdtX2JsLmMg
fCAxOCArKysrKysrKy0tLS0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9u
cygrKSwgMTAgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlk
ZW8vYmFja2xpZ2h0L3B3bV9ibC5jDQo+ID4gYi9kcml2ZXJzL3ZpZGVvL2JhY2tsaWdodC9wd21f
YmwuYw0KPiA+IGluZGV4IDllZTRjMWI3MzViMi4uZTg4NGQ1ODkzNzhkIDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvdmlkZW8vYmFja2xpZ2h0L3B3bV9ibC5jDQo+ID4gKysrIGIvZHJpdmVycy92
aWRlby9iYWNrbGlnaHQvcHdtX2JsLmMNCj4gPiBAQCAtMjUwLDcgKzI1MCw3IEBAIHN0YXRpYyBp
bnQgcHdtX2JhY2tsaWdodF9wYXJzZV9kdChzdHJ1Y3QgZGV2aWNlDQo+ID4gKmRldiwNCj4gPiAg
CXN0cnVjdCBkZXZpY2Vfbm9kZSAqbm9kZSA9IGRldi0+b2Zfbm9kZTsNCj4gPiAgCXVuc2lnbmVk
IGludCBudW1fbGV2ZWxzID0gMDsNCj4gPiAgCXVuc2lnbmVkIGludCBsZXZlbHNfY291bnQ7DQo+
ID4gLQl1bnNpZ25lZCBpbnQgbnVtX3N0ZXBzOw0KPiA+ICsJdW5zaWduZWQgaW50IG51bV9zdGVw
cyA9IDA7DQo+IA0KPiBUaGlzIGNhbiBnby4gSWYgd2UgY2hlY2sgdGhlIHJldHVybiBjb2RlIHRo
ZW0gdGhpcyB2YXJpYWJsZSBpcyBubw0KPiBsb25nZXINCj4gdXNlZCB1bmluaXRpYWxpemVkIFtJ
J20gT0sgdG8gbWFrZSB0aGUgY2hhbmdlIHRob3VnaC4uLiBzaW5jZSB5b3UndmUNCj4ga2VwdCBt
eSBuYW1lIGF0IHRoZSB0b3AgOy0pIF0uDQoNClllcywgSSBjb25maXJtIHRoYXQgdGhpcyB3b3Jr
cyBmb3IgbWUuIEFyZSB5b3UgZ29uYSBzZW5kIGEgcHJvcGVyIHBhdGNoDQpvdXQgb3Igc2hvdWxk
IEkgZG8gaXQ/DQoNCj4gRGFuaWVsLg0KPiANCj4gPiAgCXN0cnVjdCBwcm9wZXJ0eSAqcHJvcDsN
Cj4gPiAgCXVuc2lnbmVkIGludCAqdGFibGU7DQo+ID4gIAlpbnQgbGVuZ3RoOw0KPiA+IEBAIC0y
OTksMTUgKzI5OSwxMyBAQCBzdGF0aWMgaW50IHB3bV9iYWNrbGlnaHRfcGFyc2VfZHQoc3RydWN0
DQo+ID4gZGV2aWNlDQo+ID4gKmRldiwNCj4gPiAgCQkgKiBpbnRlcnBvbGF0aW9uIGJldHdlZW4g
ZWFjaCBvZiB0aGUgdmFsdWVzIG9mDQo+ID4gYnJpZ2h0bmVzcyBsZXZlbHMNCj4gPiAgCQkgKiBh
bmQgY3JlYXRlcyBhIG5ldyBwcmUtY29tcHV0ZWQgdGFibGUuDQo+ID4gIAkJICovDQo+ID4gLQkJ
b2ZfcHJvcGVydHlfcmVhZF91MzIobm9kZSwgIm51bS1pbnRlcnBvbGF0ZWQtDQo+ID4gc3RlcHMi
LA0KPiA+IC0JCQkJICAgICAmbnVtX3N0ZXBzKTsNCj4gPiAtDQo+ID4gLQkJLyoNCj4gPiAtCQkg
KiBNYWtlIHN1cmUgdGhhdCB0aGVyZSBpcyBhdCBsZWFzdCB0d28gZW50cmllcyBpbg0KPiA+IHRo
ZQ0KPiA+IC0JCSAqIGJyaWdodG5lc3MtbGV2ZWxzIHRhYmxlLCBvdGhlcndpc2Ugd2UgY2FuJ3QN
Cj4gPiBpbnRlcnBvbGF0ZQ0KPiA+IC0JCSAqIGJldHdlZW4gdHdvIHBvaW50cy4NCj4gPiAtCQkg
Ki8NCj4gPiAtCQlpZiAobnVtX3N0ZXBzKSB7DQo+ID4gKwkJaWYgKChvZl9wcm9wZXJ0eV9yZWFk
X3UzMihub2RlLCAibnVtLWludGVycG9sYXRlZC0NCj4gPiBzdGVwcyIsDQo+ID4gKwkJCQkJICAm
bnVtX3N0ZXBzKSA9PSAwKSAmJg0KPiA+IChudW1fc3RlcHMpKSB7DQo+ID4gKwkJCS8qDQo+ID4g
KwkJCSAqIE1ha2Ugc3VyZSB0aGF0IHRoZXJlIGlzIGF0IGxlYXN0IHR3bw0KPiA+IGVudHJpZXMg
aW4gdGhlDQo+ID4gKwkJCSAqIGJyaWdodG5lc3MtbGV2ZWxzIHRhYmxlLCBvdGhlcndpc2Ugd2UN
Cj4gPiBjYW4ndA0KPiA+IGludGVycG9sYXRlDQo+ID4gKwkJCSAqIGJldHdlZW4gdHdvIHBvaW50
cy4NCj4gPiArCQkJICovDQo+ID4gIAkJCWlmIChkYXRhLT5tYXhfYnJpZ2h0bmVzcyA8IDIpIHsN
Cj4gPiAgCQkJCWRldl9lcnIoZGV2LCAiY2FuJ3QNCj4gPiBpbnRlcnBvbGF0ZVxuIik7DQo+ID4g
IAkJCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiAtLSANCj4gPiAyLjE0LjQ=
