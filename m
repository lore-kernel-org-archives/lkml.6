Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADF7C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1344820989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730251AbfA3KQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 05:16:36 -0500
Received: from mx21.baidu.com ([220.181.3.85]:43377 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726476AbfA3KQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 05:16:36 -0500
X-Greylist: delayed 2820 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Jan 2019 05:16:32 EST
Received: from M1-MAIL-EX03.internal.baidu.com (unknown [10.44.83.52])
        by Forcepoint Email with ESMTPS id 7BDEF9897140B;
        Wed, 30 Jan 2019 17:29:28 +0800 (CST)
Received: from BC-Mail-Ex14.internal.baidu.com (172.31.40.50) by
 M1-MAIL-EX03.internal.baidu.com (10.44.83.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1531.3; Wed, 30 Jan 2019 17:29:29 +0800
Received: from BC-Mail-Ex13.internal.baidu.com (172.31.40.49) by
 BC-Mail-Ex14.internal.baidu.com (172.31.40.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1531.3; Wed, 30 Jan 2019 17:29:29 +0800
Received: from BC-Mail-Ex13.internal.baidu.com ([172.31.40.49]) by
 Bc-Mail-Ex13.internal.baidu.com ([172.31.40.49]) with mapi id 15.01.1531.010;
 Wed, 30 Jan 2019 17:29:29 +0800
From:   "Li,Rongqing" <lirongqing@baidu.com>
To:     "Kohli, Gaurav" <gkohli@codeaurora.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0hdW3Y0XSB0dHk6IGZpeCByYWNlIGJldHdlZW4gZmx1?=
 =?utf-8?B?c2hfdG9fbGRpc2MgYW5kIHR0eV9vcGVu?=
Thread-Topic: [PATCH][v4] tty: fix race between flush_to_ldisc and tty_open
Thread-Index: AQHUrx28V3uRZzwha06OB03mJmgPUKW0dHSAgBMoktA=
Date:   Wed, 30 Jan 2019 09:29:29 +0000
Message-ID: <4aac24e895cb4a1881bcbada05de1884@baidu.com>
References: <1547803637-29135-1-git-send-email-lirongqing@baidu.com>
 <ae44b1c5-4d33-110b-a4da-f526d156be2a@codeaurora.org>
In-Reply-To: <ae44b1c5-4d33-110b-a4da-f526d156be2a@codeaurora.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.24.150.113]
x-baidu-bdmsfe-datecheck: 1_BC-Mail-Ex14_2019-01-30 17:29:29:900
x-baidu-bdmsfe-viruscheck: BC-Mail-Ex14_GRAY_Inside_WithoutAtta_2019-01-30
 17:29:29:885
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Baidu-BdMsfe-DateCheck: 1_M1-MAIL-EX03_2019-01-30 17:29:30:115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IEtvaGxpLCBHYXVyYXYg
W21haWx0bzpna29obGlAY29kZWF1cm9yYS5vcmddDQo+IOWPkemAgeaXtumXtDogMjAxOeW5tDHm
nIgxOOaXpSAyMDo1MQ0KPiDmlLbku7bkuro6IExpLFJvbmdxaW5nIDxsaXJvbmdxaW5nQGJhaWR1
LmNvbT47IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOw0KPiBqc2xhYnlAc3VzZS5jb207IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4g5Li76aKYOiBSZTogW1BBVENIXVt2NF0gdHR5
OiBmaXggcmFjZSBiZXR3ZWVuIGZsdXNoX3RvX2xkaXNjIGFuZCB0dHlfb3Blbg0KPiANCj4gDQo+
IA0KPiBPbiAxLzE4LzIwMTkgMjo1NyBQTSwgTGkgUm9uZ1Fpbmcgd3JvdGU6DQo+ID4gVGhlcmUg
c3RpbGwgaXMgYSByYWNlIHdpbmRvdyBhZnRlciB0aGUgY29tbWl0IGIwMjdlMjI5OGJkNTg4DQo+
ID4gKCJ0dHk6IGZpeCBkYXRhIHJhY2UgYmV0d2VlbiB0dHlfaW5pdF9kZXYgYW5kIGZsdXNoIG9m
IGJ1ZiIpLCBhbmQgd2UNCj4gPiBlbmNvdW50ZXJlZCB0aGlzIGNyYXNoIGlzc3VlIGlmIHJlY2Vp
dmVfYnVmIGNhbGwgY29tZXMgYmVmb3JlIHR0eQ0KPiA+IGluaXRpYWxpemF0aW9uIGNvbXBsZXRl
cyBpbiBuX3R0eV9vcGVuIGFuZA0KPiA+IHR0eS0+ZHJpdmVyX2RhdGEgbWF5IGJlIE5VTEwuDQo+
ID4NCj4gPiBDUFUwICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQ1BVMQ0KPiA+
IC0tLS0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtLS0tDQo+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIG5fdHR5X29wZW4NCj4gPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB0dHlfaW5pdF9kZXYNCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHR0eV9sZGlzY191bmxvY2sNCj4gPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgc2NoZWR1bGUgZmx1c2hfdG9fbGRpc2MNCj4gPiAg
IHJlY2VpdmVfYnVmDQo+ID4gICAgdHR5X3BvcnRfZGVmYXVsdF9yZWNlaXZlX2J1Zg0KPiA+ICAg
ICB0dHlfbGRpc2NfcmVjZWl2ZV9idWYNCj4gPiAgICAgIG5fdHR5X3JlY2VpdmVfYnVmX2NvbW1v
bg0KPiA+ICAgICAgICBfX3JlY2VpdmVfYnVmDQo+ID4gICAgICAgICB1YXJ0X2ZsdXNoX2NoYXJz
DQo+ID4gICAgICAgICAgdWFydF9zdGFydA0KPiA+ICAgICAgICAgIC8qdHR5LT5kcml2ZXJfZGF0
YSBpcyBOVUxMKi8NCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0dHkt
Pm9wcy0+b3Blbg0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC8qaW5p
dCB0dHktPmRyaXZlcl9kYXRhKi8NCj4gPg0KPiA+IGl0IGNhbiBiZSBmaXhlZCBieSBleHRlbmRp
bmcgbGRpc2Mgc2VtYXBob3JlIGxvY2sgaW4gdHR5X2luaXRfZGV2IHRvDQo+ID4gZHJpdmVyX2Rh
dGEgaW5pdGlhbGl6ZWQgY29tcGxldGVseSBhZnRlciB0dHktPm9wcy0+b3BlbigpLCBidXQgdGhp
cw0KPiA+IHdpbGwgbGVhZCB0byBwdXQgbG9jayBvbiBvbmUgZnVuY3Rpb24gYW5kIHVubG9jayBp
biBzb21lIG90aGVyDQo+ID4gZnVuY3Rpb24sIGFuZCBoYXJkIHRvIG1haW50YWluLCBzbyBmaXgg
dGhpcyByYWNlIG9ubHkgYnkgY2hlY2tpbmcNCj4gPiB0dHktPmRyaXZlcl9kYXRhIHdoZW4gcmVj
ZWl2aW5nLCBhbmQgcmV0dXJuIGlmIHR0eS0+ZHJpdmVyX2RhdGENCj4gPiBpcyBOVUxMDQo+ID4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBXYW5nIExpIDx3YW5nbGkzOUBiYWlkdS5jb20+DQo+ID4gU2ln
bmVkLW9mZi1ieTogWmhhbmcgWXUgPHpoYW5neXUzMUBiYWlkdS5jb20+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogTGkgUm9uZ1FpbmcgPGxpcm9uZ3FpbmdAYmFpZHUuY29tPg0KPiA+IC0tLQ0KPiA+IFY0
OiBhZGQgdmVyc2lvbiBpbmZvcm1hdGlvbg0KPiA+IFYzOiBub3QgdXNlZCBsZGlzYyBzZW1hcGhv
cmUgbG9jaywgb25seSBjaGVja2luZyB0dHktPmRyaXZlcl9kYXRhIHdpdGgNCj4gPiBOVUxMDQo+
ID4gVjI6IGZpeCBidWlsZGluZyBlcnJvciBieSBFWFBPUlRfU1lNQk9MIHR0eV9sZGlzY191bmxv
Y2sNCj4gPiBWMTogZXh0ZW5kIGxkaXNjIGxvY2sgdG8gcHJvdGVjdCB0aGF0IHR0eS0+ZHJpdmVy
X2RhdGEgaXMgaW5pdGVkDQo+ID4NCj4gPiBkcml2ZXJzL3R0eS90dHlfcG9ydC5jIHwgMyArKysN
Cj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3R0eS90dHlfcG9ydC5jIGIvZHJpdmVycy90dHkvdHR5X3BvcnQuYyBpbmRl
eA0KPiA+IDA0NGMzY2JkY2ZhNC4uODZkMGJlYzM4MzIyIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZl
cnMvdHR5L3R0eV9wb3J0LmMNCj4gPiArKysgYi9kcml2ZXJzL3R0eS90dHlfcG9ydC5jDQo+ID4g
QEAgLTMxLDYgKzMxLDkgQEAgc3RhdGljIGludCB0dHlfcG9ydF9kZWZhdWx0X3JlY2VpdmVfYnVm
KHN0cnVjdCB0dHlfcG9ydA0KPiAqcG9ydCwNCj4gPiAgIAlpZiAoIXR0eSkNCj4gPiAgIAkJcmV0
dXJuIDA7DQo+ID4NCj4gPiArCWlmICghdHR5LT5kcml2ZXJfZGF0YSkNCj4gPiArCQlyZXR1cm4g
MDsNCj4gPiArDQo+ID4gICAJZGlzYyA9IHR0eV9sZGlzY19yZWYodHR5KTsNCj4gPiAgIAlpZiAo
IWRpc2MpDQo+ID4gICAJCXJldHVybiAwOw0KPiA+DQo+IEFja2VkLWJ5OiBHYXVyYXYgS29obGkg
PGdrb2hsaUBjb2RlYXVyb3JhLm9yZz4NCj4gDQo+IEl0IGxvb2tzIGdvb2QgdG8gbWUgdy5yLnQg
cHJldmlvdXMgYXBwcm9hY2gsIGJ1dCBMZXQncyBNYWludGFpbmVyIGRlY2lkZSBvbmNlLg0KPiAN
Cg0KVGhhbmtzIGZvciB5b3VyIHJldmlldywgdGhpcyBvbmUgaXMgc2ltcGxlIGFuZCBzYWZlLCBp
dCBpcyB1c2VkIGFzIGxpdmUtcGF0Y2ggb25saW5lDQoNCi1Sb25nUWluZw0KDQoNCj4gUmVnYXJk
cw0KPiBHYXVyYXYNCj4gLS0NCj4gUXVhbGNvbW0gSW5kaWEgUHJpdmF0ZSBMaW1pdGVkLCBvbiBi
ZWhhbGYgb2YgUXVhbGNvbW0gSW5ub3ZhdGlvbiBDZW50ZXIsIEluYy4NCj4gaXMgYSBtZW1iZXIg
b2YgdGhlIENvZGUgQXVyb3JhIEZvcnVtLCBhIExpbnV4IEZvdW5kYXRpb24gQ29sbGFib3JhdGl2
ZQ0KPiBQcm9qZWN0Lg0K
