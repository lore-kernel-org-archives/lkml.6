Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC7AC282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1A8420844
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731292AbfA3Msw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 07:48:52 -0500
Received: from mx23.baidu.com ([61.135.165.120]:51059 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731029AbfA3Msv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 07:48:51 -0500
Received: from M1-MAIL-EX14.internal.baidu.com (unknown [10.44.89.54])
        by Forcepoint Email with ESMTPS id A9FF0DF58595D;
        Wed, 30 Jan 2019 20:48:41 +0800 (CST)
Received: from BC-Mail-Ex13.internal.baidu.com (172.31.40.49) by
 M1-MAIL-EX14.internal.baidu.com (10.44.89.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1531.3; Wed, 30 Jan 2019 20:48:42 +0800
Received: from BC-Mail-Ex13.internal.baidu.com ([172.31.40.49]) by
 Bc-Mail-Ex13.internal.baidu.com ([172.31.40.49]) with mapi id 15.01.1531.010;
 Wed, 30 Jan 2019 20:48:42 +0800
From:   "Li,Rongqing" <lirongqing@baidu.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "jslaby@suse.com" <jslaby@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gkohli@codeaurora.org" <gkohli@codeaurora.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXVt2NF0gdHR5OiBmaXggcmFjZSBiZXR3ZWVuIGZsdXNo?=
 =?gb2312?B?X3RvX2xkaXNjIGFuZCB0dHlfb3Blbg==?=
Thread-Topic: [PATCH][v4] tty: fix race between flush_to_ldisc and tty_open
Thread-Index: AQHUrx28V3uRZzwha06OB03mJmgPUKXHJicAgACqo5A=
Date:   Wed, 30 Jan 2019 12:48:42 +0000
Message-ID: <f13cb07ed77d428b8b43459ff71adcae@baidu.com>
References: <1547803637-29135-1-git-send-email-lirongqing@baidu.com>
 <20190130101914.GA30587@kroah.com>
In-Reply-To: <20190130101914.GA30587@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.24.150.113]
x-baidu-bdmsfe-datecheck: 1_M1-MAIL-EX14_2019-01-30 20:48:42:406
x-baidu-bdmsfe-viruscheck: M1-MAIL-EX14_GRAY_Inside_WithoutAtta_2019-01-30
 20:48:42:375
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS3Tyrz+1K28/i0tLS0tDQo+ILeivP7IyzogbGludXgta2VybmVsLW93bmVyQHZn
ZXIua2VybmVsLm9yZw0KPiBbbWFpbHRvOmxpbnV4LWtlcm5lbC1vd25lckB2Z2VyLmtlcm5lbC5v
cmddILT6se0gR3JlZyBLSA0KPiC3osvNyrG85DogMjAxOcTqMdTCMzDI1SAxODoxOQ0KPiDK1bz+
yMs6IExpLFJvbmdxaW5nIDxsaXJvbmdxaW5nQGJhaWR1LmNvbT4NCj4gs63LzToganNsYWJ5QHN1
c2UuY29tOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBna29obGlAY29kZWF1cm9yYS5v
cmcNCj4g1vfM4jogUmU6IFtQQVRDSF1bdjRdIHR0eTogZml4IHJhY2UgYmV0d2VlbiBmbHVzaF90
b19sZGlzYyBhbmQgdHR5X29wZW4NCj4gDQo+IE9uIEZyaSwgSmFuIDE4LCAyMDE5IGF0IDA1OjI3
OjE3UE0gKzA4MDAsIExpIFJvbmdRaW5nIHdyb3RlOg0KPiA+IFRoZXJlIHN0aWxsIGlzIGEgcmFj
ZSB3aW5kb3cgYWZ0ZXIgdGhlIGNvbW1pdCBiMDI3ZTIyOThiZDU4OA0KPiA+ICgidHR5OiBmaXgg
ZGF0YSByYWNlIGJldHdlZW4gdHR5X2luaXRfZGV2IGFuZCBmbHVzaCBvZiBidWYiKSwgYW5kIHdl
DQo+ID4gZW5jb3VudGVyZWQgdGhpcyBjcmFzaCBpc3N1ZSBpZiByZWNlaXZlX2J1ZiBjYWxsIGNv
bWVzIGJlZm9yZSB0dHkNCj4gPiBpbml0aWFsaXphdGlvbiBjb21wbGV0ZXMgaW4gbl90dHlfb3Bl
biBhbmQNCj4gPiB0dHktPmRyaXZlcl9kYXRhIG1heSBiZSBOVUxMLg0KPiA+DQo+ID4gQ1BVMCAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIENQVTENCj4gPiAtLS0tICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgLS0tLQ0KPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIG5fdHR5X29wZW4NCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHR0eV9pbml0X2Rldg0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB0dHlfbGRpc2NfdW5sb2NrDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgc2NoZWR1bGUgZmx1c2hfdG9fbGRpc2MNCj4gPiByZWNlaXZlX2J1Zg0KPiA+ICAg
dHR5X3BvcnRfZGVmYXVsdF9yZWNlaXZlX2J1Zg0KPiA+ICAgIHR0eV9sZGlzY19yZWNlaXZlX2J1
Zg0KPiA+ICAgICBuX3R0eV9yZWNlaXZlX2J1Zl9jb21tb24NCj4gPiAgICAgICBfX3JlY2VpdmVf
YnVmDQo+ID4gICAgICAgIHVhcnRfZmx1c2hfY2hhcnMNCj4gPiAgICAgICAgIHVhcnRfc3RhcnQN
Cj4gPiAgICAgICAgIC8qdHR5LT5kcml2ZXJfZGF0YSBpcyBOVUxMKi8NCj4gPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHR0eS0+b3BzLT5vcGVuDQo+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAvKmluaXQgdHR5LT5kcml2ZXJfZGF0YSovDQo+ID4NCj4g
PiBpdCBjYW4gYmUgZml4ZWQgYnkgZXh0ZW5kaW5nIGxkaXNjIHNlbWFwaG9yZSBsb2NrIGluIHR0
eV9pbml0X2RldiB0bw0KPiA+IGRyaXZlcl9kYXRhIGluaXRpYWxpemVkIGNvbXBsZXRlbHkgYWZ0
ZXIgdHR5LT5vcHMtPm9wZW4oKSwgYnV0IHRoaXMNCj4gPiB3aWxsIGxlYWQgdG8gcHV0IGxvY2sg
b24gb25lIGZ1bmN0aW9uIGFuZCB1bmxvY2sgaW4gc29tZSBvdGhlcg0KPiA+IGZ1bmN0aW9uLCBh
bmQgaGFyZCB0byBtYWludGFpbiwgc28gZml4IHRoaXMgcmFjZSBvbmx5IGJ5IGNoZWNraW5nDQo+
ID4gdHR5LT5kcml2ZXJfZGF0YSB3aGVuIHJlY2VpdmluZywgYW5kIHJldHVybiBpZiB0dHktPmRy
aXZlcl9kYXRhDQo+ID4gaXMgTlVMTA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogV2FuZyBMaSA8
d2FuZ2xpMzlAYmFpZHUuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFpoYW5nIFl1IDx6aGFuZ3l1
MzFAYmFpZHUuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IExpIFJvbmdRaW5nIDxsaXJvbmdxaW5n
QGJhaWR1LmNvbT4NCj4gPiAtLS0NCj4gPiBWNDogYWRkIHZlcnNpb24gaW5mb3JtYXRpb24NCj4g
PiBWMzogbm90IHVzZWQgbGRpc2Mgc2VtYXBob3JlIGxvY2ssIG9ubHkgY2hlY2tpbmcgdHR5LT5k
cml2ZXJfZGF0YSB3aXRoDQo+ID4gTlVMTA0KPiA+IFYyOiBmaXggYnVpbGRpbmcgZXJyb3IgYnkg
RVhQT1JUX1NZTUJPTCB0dHlfbGRpc2NfdW5sb2NrDQo+ID4gVjE6IGV4dGVuZCBsZGlzYyBsb2Nr
IHRvIHByb3RlY3QgdGhhdCB0dHktPmRyaXZlcl9kYXRhIGlzIGluaXRlZA0KPiA+DQo+ID4gZHJp
dmVycy90dHkvdHR5X3BvcnQuYyB8IDMgKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2Vy
dGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS90dHlfcG9ydC5jIGIv
ZHJpdmVycy90dHkvdHR5X3BvcnQuYyBpbmRleA0KPiA+IDA0NGMzY2JkY2ZhNC4uODZkMGJlYzM4
MzIyIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvdHR5L3R0eV9wb3J0LmMNCj4gPiArKysgYi9k
cml2ZXJzL3R0eS90dHlfcG9ydC5jDQo+ID4gQEAgLTMxLDYgKzMxLDkgQEAgc3RhdGljIGludCB0
dHlfcG9ydF9kZWZhdWx0X3JlY2VpdmVfYnVmKHN0cnVjdCB0dHlfcG9ydA0KPiAqcG9ydCwNCj4g
PiAgCWlmICghdHR5KQ0KPiA+ICAJCXJldHVybiAwOw0KPiA+DQo+ID4gKwlpZiAoIXR0eS0+ZHJp
dmVyX2RhdGEpDQo+ID4gKwkJcmV0dXJuIDA7DQo+ID4gKw0KPiANCj4gSG93IGlzIHRoaXMgd29y
a2luZz8gIFdoYXQgaXMgc2V0dGluZyBkcml2ZXJfZGF0YSB0byBOVUxMIHRvICJzdG9wIiB0aGlz
IHJhY2U/DQo+IA0KDQoNCmlmIHR0eS0+ZHJpdmVyX2RhdGEgaXMgTlVMTCBhbmQgcmV0dXJuLCAg
dHR5X3BvcnRfZGVmYXVsdF9yZWNlaXZlX2J1ZiB3aWxsIG5vdCBzdGVwIHRvDQp1YXJ0X3N0YXJ0
IHdoaWNoIGFjY2VzcyB0dHktPmRyaXZlcl9kYXRhIGFuZCB0cmlnZ2VyIHBhbmljIGJlZm9yZSB0
dHlfb3Blbiwgc28gaXQgY2FuDQpmaXggdGhlIHN5c3RlbSBwYW5pYw0KDQo+IFRoZXJlJ3Mgbm8g
cmVxdWlyZW1lbnQgdGhhdCBhIHR0eSBkcml2ZXIgc2V0IHRoaXMgZmllbGQgdG8gTlVMTCB3aGVu
IGl0IGlzICJkb25lIg0KPiB3aXRoIHRoZSB0dHkgZGV2aWNlLCBzbyBJIHRoaW5rIHlvdSBhcmUg
anVzdCBnZXR0aW5nIGx1Y2t5IGluIHRoYXQgeW91ciBzcGVjaWZpYw0KPiBkcml2ZXIgaGFwcGVu
cyB0byBiZSBkb2luZyB0aGlzLg0KPiANCg0Kd2hlbiB0dHlfb3BlbiBpcyBydW5uaW5nLCB0dHkg
aXMgYWxsb2NhdGVkIGJ5IGt6YWxsb2MgaW4gdHR5X2luaXRfZGV2IHdoaWNoIGNhbGxlZA0KYnkg
dHR5X29wZW5fYnlfZHJpdmVyLCB0dHkgaXMgaW5pdGVkIHRvIDANCg0KPiBXaGF0IGRyaXZlciBh
cmUgeW91IHRlc3RpbmcgdGhpcyBhZ2FpbnN0Pw0KPiANCg0KODI1MA0KDQpUaGFua3MNCg0KLVJv
bmdRaW5nDQoNCj4gdGhhbmtzLA0KPiANCj4gZ3JlZyBrLWgNCg==
