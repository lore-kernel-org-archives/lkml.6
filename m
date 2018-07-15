Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URI_HEX autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383A5ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 14:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C58982124D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 14:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="Vnozie0y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C58982124D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbeGOOuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 10:50:02 -0400
Received: from mail-eopbgr80107.outbound.protection.outlook.com ([40.107.8.107]:44134
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726246AbeGOOuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 10:50:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9ELdvhromprfjnvAQZXc28DBrj02Hdnr2tcy6L8jh8=;
 b=Vnozie0ySKO580j3xpStFJqMAO0dCwXkZh/6umPiq0e8RDS111TBAwEOS2ZjYQGChgyVcFbBHHiGlDCsWaY4yjfqaGfkhE0RaVSTFe5e6RRXdO/WiwF4HDXW+n8xYrlaCKwdn1MVxJ5S+XMCnMbyex3KodnhQMBCN9iovspmnTw=
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com (10.168.137.14) by
 VI1PR0501MB2592.eurprd05.prod.outlook.com (10.168.137.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.18; Sun, 15 Jul 2018 14:26:44 +0000
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::dc61:4a61:b84:357e]) by VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::dc61:4a61:b84:357e%6]) with mapi id 15.20.0952.021; Sun, 15 Jul 2018
 14:26:44 +0000
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
Thread-Index: AQHUG4R+HyVgZWRryUKWT5nDq5XGE6SP6+4AgABstQA=
Date:   Sun, 15 Jul 2018 14:26:44 +0000
Message-ID: <1531664796.7579.13.camel@toradex.com>
References: <20180409083333.1249-1-enric.balletbo@collabora.com>
         <20180409083333.1249-2-enric.balletbo@collabora.com>
         <1531580895.7579.7.camel@toradex.com> <20180715075732.GA2989@wychelm.lan>
In-Reply-To: <20180715075732.GA2989@wychelm.lan>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [89.217.215.226]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0501MB2592;7:FSgVfIV5h3CM+P0zLIdZfZ1IWAWYXwVCjN5NX6a7Dbcd0jpGyWk4JslR5e83uK420XkXRO+pEcAx/Sd3wudn4H4Ln/ACDeeebH1s42aUAesgBZSW7vST1SSUu4HjodFN683gmlEyL5KVJ7GP1ICCh5SFwe8+ibnv/HzWCJYostm7tZsrMTTaO/h66T05NpCZESkys4y1onp8iJxaWQHv6E/NJGKjryElVqUGOUhb48P24IxxSJqTUJ2PKE5iaXb2
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: affd55b6-7289-4b1a-d6d7-08d5ea5efdcb
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2592;
x-ms-traffictypediagnostic: VI1PR0501MB2592:
x-microsoft-antispam-prvs: <VI1PR0501MB2592B1A8933D2C31DC4D1056FB5E0@VI1PR0501MB2592.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:VI1PR0501MB2592;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB2592;
x-forefront-prvs: 07349BFAD2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(39830400003)(396003)(136003)(199004)(189003)(7736002)(217873002)(7416002)(5660300001)(14444005)(26005)(305945005)(256004)(186003)(36756003)(6436002)(2351001)(575784001)(6512007)(5640700003)(93886005)(99286004)(2906002)(97736004)(86362001)(66066001)(68736007)(6486002)(76176011)(229853002)(106356001)(6246003)(81166006)(81156014)(105586002)(103116003)(6916009)(11346002)(6116002)(44832011)(53546011)(2616005)(5250100002)(8936002)(2501003)(54906003)(6506007)(14454004)(39060400002)(25786009)(316002)(486006)(102836004)(446003)(8676002)(476003)(3846002)(4326008)(53936002)(478600001)(2900100001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0501MB2592;H:VI1PR0501MB2590.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: YPiLWvz0sKrIRIDlv+Rgt3sBBBHN6DSr8m1hIBjSdLXBkOt38dGqFIC5q91fFUW8v/VAR/0pawRco367ftiMxIheljM4A+WaSkAIE8qaeFE0awT+EIAJKO30CSksNbrHC0I85M54sMj7MFzgyBXSEEfqVy7d5WfrgH/vZ/we6cdokfl3Atc5EGhwmECuwreNTSkio5MlmABn2tTMB9is8a9AyfLO9v5tJZyvCM9i1yGgLjY0IsTYYHZy/NH89NKtj9aQS4j+K/u3xwL5jN0DVDfmfIH6Y+F6qRT8dacjFT9NsL4CCYp7zBYBLT+j3TZN0hcT/Yns/CjNqD8Z9VhAS+BSWfY2air9s4/c7NXxZ9s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <B383E2BA32D77F4F98AF5F52DECD6B68@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: affd55b6-7289-4b1a-d6d7-08d5ea5efdcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2018 14:26:44.6737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2592
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDE4LTA3LTE1IGF0IDA4OjU3ICswMTAwLCBEYW5pZWwgVGhvbXBzb24gd3JvdGU6
DQo+IE9uIFNhdCwgSnVsIDE0LCAyMDE4IGF0IDAzOjA4OjE3UE0gKzAwMDAsIE1hcmNlbCBaaXN3
aWxlciB3cm90ZToNCj4gPiBPbiBNb24sIDIwMTgtMDQtMDkgYXQgMTA6MzMgKzAyMDAsIEVucmlj
IEJhbGxldGJvIGkgU2VycmEgd3JvdGU6DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aWRl
by9iYWNrbGlnaHQvcHdtX2JsLmMNCj4gPiA+IGIvZHJpdmVycy92aWRlby9iYWNrbGlnaHQvcHdt
X2JsLmMNCj4gPiA+IGluZGV4IDhlM2YxMjQ1ZjVjNS4uZjBhMTA4YWI1NzBhIDEwMDY0NA0KPiA+
ID4gLS0tIGEvZHJpdmVycy92aWRlby9iYWNrbGlnaHQvcHdtX2JsLmMNCj4gPiA+ICsrKyBiL2Ry
aXZlcnMvdmlkZW8vYmFja2xpZ2h0L3B3bV9ibC5jDQo+ID4gPiBAQCAtMTQ3LDcgKzE0NywxMSBA
QCBzdGF0aWMgaW50IHB3bV9iYWNrbGlnaHRfcGFyc2VfZHQoc3RydWN0DQo+ID4gPiBkZXZpY2UN
Cj4gPiA+ICpkZXYsDQo+ID4gPiAgCQkJCSAgc3RydWN0DQo+ID4gPiBwbGF0Zm9ybV9wd21fYmFj
a2xpZ2h0X2RhdGENCj4gPiA+ICpkYXRhKQ0KPiA+ID4gIHsNCj4gPiA+ICAJc3RydWN0IGRldmlj
ZV9ub2RlICpub2RlID0gZGV2LT5vZl9ub2RlOw0KPiA+ID4gKwl1bnNpZ25lZCBpbnQgbnVtX2xl
dmVscyA9IDA7DQo+ID4gPiArCXVuc2lnbmVkIGludCBsZXZlbHNfY291bnQ7DQo+ID4gPiArCXVu
c2lnbmVkIGludCBudW1fc3RlcHM7DQo+IA0KPiBudW1fc3RlcHMgaXMgbm90IGluaXRpYWxpemVk
Li4uDQo+IA0KPiANCj4gPiA+ICAJc3RydWN0IHByb3BlcnR5ICpwcm9wOw0KPiA+ID4gKwl1bnNp
Z25lZCBpbnQgKnRhYmxlOw0KPiA+ID4gIAlpbnQgbGVuZ3RoOw0KPiA+ID4gIAl1MzIgdmFsdWU7
DQo+ID4gPiAgCWludCByZXQ7DQo+ID4gPiBAQCAtMTY3LDYgKzE3MSw3IEBAIHN0YXRpYyBpbnQg
cHdtX2JhY2tsaWdodF9wYXJzZV9kdChzdHJ1Y3QNCj4gPiA+IGRldmljZQ0KPiA+ID4gKmRldiwN
Cj4gPiA+ICAJLyogcmVhZCBicmlnaHRuZXNzIGxldmVscyBmcm9tIERUIHByb3BlcnR5ICovDQo+
ID4gPiAgCWlmIChkYXRhLT5tYXhfYnJpZ2h0bmVzcyA+IDApIHsNCj4gPiA+ICAJCXNpemVfdCBz
aXplID0gc2l6ZW9mKCpkYXRhLT5sZXZlbHMpICogZGF0YS0NCj4gPiA+ID4gbWF4X2JyaWdodG5l
c3M7DQo+ID4gPiANCj4gPiA+ICsJCXVuc2lnbmVkIGludCBpLCBqLCBuID0gMDsNCj4gPiA+ICAN
Cj4gPiA+ICAJCWRhdGEtPmxldmVscyA9IGRldm1fa3phbGxvYyhkZXYsIHNpemUsDQo+ID4gPiBH
RlBfS0VSTkVMKTsNCj4gPiA+ICAJCWlmICghZGF0YS0+bGV2ZWxzKQ0KPiA+ID4gQEAgLTE4NCw2
ICsxODksODQgQEAgc3RhdGljIGludCBwd21fYmFja2xpZ2h0X3BhcnNlX2R0KHN0cnVjdA0KPiA+
ID4gZGV2aWNlDQo+ID4gPiAqZGV2LA0KPiA+ID4gIAkJCXJldHVybiByZXQ7DQo+ID4gPiAgDQo+
ID4gPiAgCQlkYXRhLT5kZnRfYnJpZ2h0bmVzcyA9IHZhbHVlOw0KPiA+ID4gKw0KPiA+ID4gKwkJ
LyoNCj4gPiA+ICsJCSAqIFRoaXMgcHJvcGVydHkgaXMgb3B0aW9uYWwsIGlmIGlzIHNldCBlbmFi
bGVzDQo+ID4gPiBsaW5lYXINCj4gPiA+ICsJCSAqIGludGVycG9sYXRpb24gYmV0d2VlbiBlYWNo
IG9mIHRoZSB2YWx1ZXMgb2YNCj4gPiA+IGJyaWdodG5lc3MgbGV2ZWxzDQo+ID4gPiArCQkgKiBh
bmQgY3JlYXRlcyBhIG5ldyBwcmUtY29tcHV0ZWQgdGFibGUuDQo+ID4gPiArCQkgKi8NCj4gPiA+
ICsJCW9mX3Byb3BlcnR5X3JlYWRfdTMyKG5vZGUsICJudW0taW50ZXJwb2xhdGVkLQ0KPiA+ID4g
c3RlcHMiLA0KPiA+ID4gKwkJCQkgICAgICZudW1fc3RlcHMpOw0KPiANCj4gLi4uIHRoaXMgaXMg
bm90IGd1YXJhbnRlZWQgdG8gaW5pdGlhbGl6ZWQgbnVtX3N0ZXBzIC4uLg0KDQpZZXMsIGFzIGl0
IG9ubHkgZG9lcyBzbyBpZiByZXR1cm5pbmcgemVyby4gSSBkbyBmdXJ0aGVyIHByb3Bvc2UgdG8N
CmNoZWNrIGl0cyByZXR1cm4gdmFsdWUgYXMgd2VsbC4gSXNuJ3QgdGhhdCB3aGF0IHJldHVybiB2
YWx1ZXMgYXJlIHVzZWQNCmZvcj8NCg0KUXVvdGluZyBmcm9tIGluY2x1ZGUvbGludXgvb2YuaDoN
Cg0KU2VhcmNoIGZvciBhIHByb3BlcnR5IGluIGEgZGV2aWNlIG5vZGUgYW5kIHJlYWQgMzItYml0
IHZhbHVlKHMpIGZyb20NCml0LiBSZXR1cm5zIDAgb24gc3VjY2VzcywgLUVJTlZBTCBpZiB0aGUg
cHJvcGVydHkgZG9lcyBub3QgZXhpc3QsDQotRU5PREFUQSBpZiBwcm9wZXJ0eSBkb2VzIG5vdCBo
YXZlIGEgdmFsdWUsIGFuZCAtRU9WRVJGTE9XIGlmIHRoZQ0KcHJvcGVydHkgZGF0YSBpc24ndCBs
YXJnZSBlbm91Z2guDQoNCj4gPiA+ICsNCj4gPiA+ICsJCS8qDQo+ID4gPiArCQkgKiBNYWtlIHN1
cmUgdGhhdCB0aGVyZSBpcyBhdCBsZWFzdCB0d28gZW50cmllcw0KPiA+ID4gaW4NCj4gPiA+IHRo
ZQ0KPiA+ID4gKwkJICogYnJpZ2h0bmVzcy1sZXZlbHMgdGFibGUsIG90aGVyd2lzZSB3ZSBjYW4n
dA0KPiA+ID4gaW50ZXJwb2xhdGUNCj4gPiA+ICsJCSAqIGJldHdlZW4gdHdvIHBvaW50cy4NCj4g
PiA+ICsJCSAqLw0KPiA+ID4gKwkJaWYgKG51bV9zdGVwcykgew0KPiANCj4gLi4uIGFuZCB3ZSBt
YWtlIGEgZGVjaXNpb24gb24gaXQgaGVyZS4NCj4gDQo+IE1hcmNlbDogQ2FuIHlvdSB0cnkgdGhl
IGZvbGxvd2luZyBxdWljayBmaXg/IEl0J3MgdW50ZXN0ZWQgb24gbXkgc2lkZQ0KPiAgICAgICAg
IGJ1dCB2ZXJ5IHNpbXBsZS4uLg0KPiANCj4gRnJvbSA2ZmEyZmJlYjAxNzA4NjE0N2FjNjE5ODEx
MDdhOTVjYjhhZTdiNGU3IE1vbiBTZXAgMTcgMDA6MDA6MDANCj4gMjAwMQ0KPiBGcm9tOiBEYW5p
ZWwgVGhvbXBzb24gPGRhbmllbC50aG9tcHNvbkBsaW5hcm8ub3JnPg0KPiBEYXRlOiBTdW4sIDE1
IEp1bCAyMDE4IDA4OjQ5OjA1ICswMTAwDQo+IFN1YmplY3Q6IFtQQVRDSF0gYmFja2xpZ2h0OiBw
d21fYmw6IEZpeCB1bmluaXRpYWxpemVkIHZhcmlhYmxlDQo+IA0KPiBDdXJyZW50bHksIGlmIHRo
ZSBEVCBkb2VzIG5vdCBkZWZpbmUgbnVtLWludGVycG9sYXRlZC1zdGVwcyB0aGVuDQo+IG51bV9z
dGVwcyBpcyB1bmRlZmluZWQgbWVhbmluZyB0aGUgaW50ZXJwb2xhdGlvbiBjb2RlIHdpbGwgZGVw
bG95DQo+IHJhbmRvbWx5LiBGaXggdGhpcy4NCj4gDQo+IEZpeGVzOiA1NzNmZTZkMWMyNWMgKCJi
YWNrbGlnaHQ6IHB3bV9ibDogTGluZWFyIGludGVycG9sYXRpb24gYmV0d2Vlbg0KPiBicmlnaHRu
ZXNzLWxldmVscyIpDQo+IFJlcG9ydGVkLWJ5OiBNYXJjZWwgWmlzd2lsZXIgPG1hcmNlbC56aXN3
aWxlckB0b3JhZGV4LmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogRGFuaWVsIFRob21wc29uIDxkYW5p
ZWwudGhvbXBzb25AbGluYXJvLm9yZz4NCj4gLS0tDQo+ICBkcml2ZXJzL3ZpZGVvL2JhY2tsaWdo
dC9wd21fYmwuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBk
ZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlkZW8vYmFja2xpZ2h0L3B3
bV9ibC5jDQo+IGIvZHJpdmVycy92aWRlby9iYWNrbGlnaHQvcHdtX2JsLmMNCj4gaW5kZXggOWVl
NGMxYjczNWIyLi5iZGZjYzBhNzFkYjEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdmlkZW8vYmFj
a2xpZ2h0L3B3bV9ibC5jDQo+ICsrKyBiL2RyaXZlcnMvdmlkZW8vYmFja2xpZ2h0L3B3bV9ibC5j
DQo+IEBAIC0yNTAsNyArMjUwLDcgQEAgc3RhdGljIGludCBwd21fYmFja2xpZ2h0X3BhcnNlX2R0
KHN0cnVjdCBkZXZpY2UNCj4gKmRldiwNCj4gIAlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5vZGUgPSBk
ZXYtPm9mX25vZGU7DQo+ICAJdW5zaWduZWQgaW50IG51bV9sZXZlbHMgPSAwOw0KPiAgCXVuc2ln
bmVkIGludCBsZXZlbHNfY291bnQ7DQo+IC0JdW5zaWduZWQgaW50IG51bV9zdGVwczsNCj4gKwl1
bnNpZ25lZCBpbnQgbnVtX3N0ZXBzID0gMDsNCj4gIAlzdHJ1Y3QgcHJvcGVydHkgKnByb3A7DQo+
ICAJdW5zaWduZWQgaW50ICp0YWJsZTsNCj4gIAlpbnQgbGVuZ3RoOw0KPiAtLQ0KPiAyLjE3LjEN
Cg0KRnJvbSBkYmIzMWQwMGM5ZjI4NzNhZmZlZGJjZWFlOTE3YzlkN2ZjZTVmODMyIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQ0KTWVzc2FnZS1JZDogPGRiYjMxZDAwYzlmMjg3M2FmZmVkYmNlYWU5
MTdjOWQ3ZmNlNWY4MzIuMTUzMTY2NDY2My5naXQubWENCnJjZWwuemlzd2lsZXJAdG9yYWRleC5j
b20+DQpGcm9tOiBEYW5pZWwgVGhvbXBzb24gPGRhbmllbC50aG9tcHNvbkBsaW5hcm8ub3JnPg0K
RGF0ZTogU3VuLCAxNSBKdWwgMjAxOCAwODo0OTowNSArMDEwMA0KU3ViamVjdDogW1BBVENIXSBi
YWNrbGlnaHQ6IHB3bV9ibDogRml4IHVuaW5pdGlhbGl6ZWQgdmFyaWFibGUNCg0KQ3VycmVudGx5
LCBpZiB0aGUgRFQgZG9lcyBub3QgZGVmaW5lIG51bS1pbnRlcnBvbGF0ZWQtc3RlcHMgdGhlbg0K
bnVtX3N0ZXBzIGlzIHVuZGVmaW5lZCBtZWFuaW5nIHRoZSBpbnRlcnBvbGF0aW9uIGNvZGUgd2ls
bCBkZXBsb3kNCnJhbmRvbWx5LiBGaXggdGhpcy4NCg0KRml4ZXM6IDU3M2ZlNmQxYzI1YyAoImJh
Y2tsaWdodDogcHdtX2JsOiBMaW5lYXIgaW50ZXJwb2xhdGlvbiBiZXR3ZWVuDQpicmlnaHRuZXNz
LWxldmVscyIpDQpSZXBvcnRlZC1ieTogTWFyY2VsIFppc3dpbGVyIDxtYXJjZWwuemlzd2lsZXJA
dG9yYWRleC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgVGhvbXBzb24gPGRhbmllbC50aG9t
cHNvbkBsaW5hcm8ub3JnPg0KU2lnbmVkLW9mZi1ieTogTWFyY2VsIFppc3dpbGVyIDxtYXJjZWwu
emlzd2lsZXJAdG9yYWRleC5jb20+DQotLS0NCiBkcml2ZXJzL3ZpZGVvL2JhY2tsaWdodC9wd21f
YmwuYyB8IDE4ICsrKysrKysrLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlv
bnMoKyksIDEwIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy92aWRlby9iYWNr
bGlnaHQvcHdtX2JsLmMNCmIvZHJpdmVycy92aWRlby9iYWNrbGlnaHQvcHdtX2JsLmMNCmluZGV4
IDllZTRjMWI3MzViMi4uZTg4NGQ1ODkzNzhkIDEwMDY0NA0KLS0tIGEvZHJpdmVycy92aWRlby9i
YWNrbGlnaHQvcHdtX2JsLmMNCisrKyBiL2RyaXZlcnMvdmlkZW8vYmFja2xpZ2h0L3B3bV9ibC5j
DQpAQCAtMjUwLDcgKzI1MCw3IEBAIHN0YXRpYyBpbnQgcHdtX2JhY2tsaWdodF9wYXJzZV9kdChz
dHJ1Y3QgZGV2aWNlDQoqZGV2LA0KIAlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5vZGUgPSBkZXYtPm9m
X25vZGU7DQogCXVuc2lnbmVkIGludCBudW1fbGV2ZWxzID0gMDsNCiAJdW5zaWduZWQgaW50IGxl
dmVsc19jb3VudDsNCi0JdW5zaWduZWQgaW50IG51bV9zdGVwczsNCisJdW5zaWduZWQgaW50IG51
bV9zdGVwcyA9IDA7DQogCXN0cnVjdCBwcm9wZXJ0eSAqcHJvcDsNCiAJdW5zaWduZWQgaW50ICp0
YWJsZTsNCiAJaW50IGxlbmd0aDsNCkBAIC0yOTksMTUgKzI5OSwxMyBAQCBzdGF0aWMgaW50IHB3
bV9iYWNrbGlnaHRfcGFyc2VfZHQoc3RydWN0IGRldmljZQ0KKmRldiwNCiAJCSAqIGludGVycG9s
YXRpb24gYmV0d2VlbiBlYWNoIG9mIHRoZSB2YWx1ZXMgb2YNCmJyaWdodG5lc3MgbGV2ZWxzDQog
CQkgKiBhbmQgY3JlYXRlcyBhIG5ldyBwcmUtY29tcHV0ZWQgdGFibGUuDQogCQkgKi8NCi0JCW9m
X3Byb3BlcnR5X3JlYWRfdTMyKG5vZGUsICJudW0taW50ZXJwb2xhdGVkLXN0ZXBzIiwNCi0JCQkJ
ICAgICAmbnVtX3N0ZXBzKTsNCi0NCi0JCS8qDQotCQkgKiBNYWtlIHN1cmUgdGhhdCB0aGVyZSBp
cyBhdCBsZWFzdCB0d28gZW50cmllcyBpbiB0aGUNCi0JCSAqIGJyaWdodG5lc3MtbGV2ZWxzIHRh
YmxlLCBvdGhlcndpc2Ugd2UgY2FuJ3QNCmludGVycG9sYXRlDQotCQkgKiBiZXR3ZWVuIHR3byBw
b2ludHMuDQotCQkgKi8NCi0JCWlmIChudW1fc3RlcHMpIHsNCisJCWlmICgob2ZfcHJvcGVydHlf
cmVhZF91MzIobm9kZSwgIm51bS1pbnRlcnBvbGF0ZWQtDQpzdGVwcyIsDQorCQkJCQkgICZudW1f
c3RlcHMpID09IDApICYmDQoobnVtX3N0ZXBzKSkgew0KKwkJCS8qDQorCQkJICogTWFrZSBzdXJl
IHRoYXQgdGhlcmUgaXMgYXQgbGVhc3QgdHdvDQplbnRyaWVzIGluIHRoZQ0KKwkJCSAqIGJyaWdo
dG5lc3MtbGV2ZWxzIHRhYmxlLCBvdGhlcndpc2Ugd2UgY2FuJ3QNCmludGVycG9sYXRlDQorCQkJ
ICogYmV0d2VlbiB0d28gcG9pbnRzLg0KKwkJCSAqLw0KIAkJCWlmIChkYXRhLT5tYXhfYnJpZ2h0
bmVzcyA8IDIpIHsNCiAJCQkJZGV2X2VycihkZXYsICJjYW4ndCBpbnRlcnBvbGF0ZVxuIik7DQog
CQkJCXJldHVybiAtRUlOVkFMOw0KLS0gDQoyLjE0LjQ=
