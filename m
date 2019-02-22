Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3A2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A41492075A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfBVOug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 09:50:36 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2090 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726090AbfBVOue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 09:50:34 -0500
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 3BEBA93C6A484C2FDC45;
        Fri, 22 Feb 2019 22:50:27 +0800 (CST)
Received: from DGGEMM528-MBX.china.huawei.com ([169.254.8.114]) by
 DGGEMM402-HUB.china.huawei.com ([10.3.20.210]) with mapi id 14.03.0415.000;
 Fri, 22 Feb 2019 22:50:24 +0800
From:   "liujian (CE)" <liujian56@huawei.com>
To:     Vignesh R <vigneshr@ti.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "joakim.tjernlund@infinera.com" <joakim.tjernlund@infinera.com>,
        "ikegami@allied-telesis.co.jp" <ikegami@allied-telesis.co.jp>,
        "keescook@chromium.org" <keescook@chromium.org>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] cfi: fix deadloop in cfi_cmdset_0002.c
 do_write_buffer
Thread-Topic: [PATCH v2] cfi: fix deadloop in cfi_cmdset_0002.c
 do_write_buffer
Thread-Index: AQHUyECUkUyeapQrDkmF59WHE7XjT6Xq0LsAgAEYiIA=
Date:   Fri, 22 Feb 2019 14:50:23 +0000
Message-ID: <4F88C5DDA1E80143B232E89585ACE27D0263D40B@DGGEMM528-MBX.china.huawei.com>
References: <1550609234-40861-1-git-send-email-liujian56@huawei.com>
 <e9923a1f-aefc-fdd9-97d8-5c0012f09726@ti.com>
In-Reply-To: <e9923a1f-aefc-fdd9-97d8-5c0012f09726@ti.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.177.97.126]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFZpZ25lc2ggUiBbbWFpbHRv
OnZpZ25lc2hyQHRpLmNvbV0NCj4gU2VudDogRnJpZGF5LCBGZWJydWFyeSAyMiwgMjAxOSAxOjU5
IFBNDQo+IFRvOiBsaXVqaWFuIChDRSkgPGxpdWppYW41NkBodWF3ZWkuY29tPjsgZHdtdzJAaW5m
cmFkZWFkLm9yZzsNCj4gY29tcHV0ZXJzZm9ycGVhY2VAZ21haWwuY29tOyBiYnJlemlsbG9uQGtl
cm5lbC5vcmc7DQo+IG1hcmVrLnZhc3V0QGdtYWlsLmNvbTsgcmljaGFyZEBub2QuYXQ7IGpvYWtp
bS50amVybmx1bmRAaW5maW5lcmEuY29tOw0KPiBpa2VnYW1pQGFsbGllZC10ZWxlc2lzLmNvLmpw
OyBrZWVzY29va0BjaHJvbWl1bS5vcmcNCj4gQ2M6IGxpbnV4LW10ZEBsaXN0cy5pbmZyYWRlYWQu
b3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
djJdIGNmaTogZml4IGRlYWRsb29wIGluIGNmaV9jbWRzZXRfMDAwMi5jIGRvX3dyaXRlX2J1ZmZl
cg0KPiANCj4gDQo+IA0KPiBPbiAyMC8wMi8xOSAyOjE3IEFNLCBMaXUgSmlhbiB3cm90ZToNCj4g
PiBJbiBmdW5jdGlvbiBkb193cml0ZV9idWZmZXIoKSwgaW4gdGhlIGZvciBsb29wLCB0aGVyZSBp
cyBhIGNhc2UNCj4gPiBjaGlwX3JlYWR5KCkgcmV0dXJucyAxIHdoaWxlIGNoaXBfZ29vZCgpIHJl
dHVybnMgMCwgc28gaXQgbmV2ZXIgYnJlYWsNCj4gPiB0aGUgbG9vcC4NCj4gPiBUbyBmaXggdGhp
cywgY2hpcF9nb29kKCkgaXMgZW5vdWdoIGFuZCBpdCBzaG91bGQgdGltZW91dCBpZiBpdCBzdGF5
DQo+ID4gYmFkIGZvciBhIHdoaWxlLg0KPiA+DQo+ID4gRml4ZXM6IGRmZWFlMTA3MzU4MyAoIm10
ZDogY2ZpX2NtZHNldF8wMDAyOiBDaGFuZ2Ugd3JpdGUgYnVmZmVyIHRvDQo+ID4gY2hlY2sgY29y
cmVjdCB2YWx1ZSIpDQo+ID4gU2lnbmVkLW9mZi1ieTogWWkgSHVhaWppZSA8eWlodWFpamllQGh1
YXdlaS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogTGl1IEppYW4gPGxpdWppYW41NkBodWF3ZWku
Y29tPg0KPiA+IFJldmlld2VkLWJ5OiBUb2t1bm9yaSBJa2VnYW1pIDxpa2VnYW1pX3RvQHlhaG9v
LmNvLmpwPg0KPiA+IC0tLQ0KPiA+IHYxLT52MjoNCj4gPiBjaGFuZ2UgZ2l0IGxvZywgcHV0IHRo
ZSBGaXhlcyB0YWcgb24gYSBzaW5nbGUgbGluZQ0KPiA+DQo+ID4gIGRyaXZlcnMvbXRkL2NoaXBz
L2NmaV9jbWRzZXRfMDAwMi5jIHwgNiArKystLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5z
ZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L210ZC9jaGlwcy9jZmlfY21kc2V0XzAwMDIuYw0KPiA+IGIvZHJpdmVycy9tdGQvY2hpcHMvY2Zp
X2NtZHNldF8wMDAyLmMNCj4gPiBpbmRleCA3MjQyOGI2Li44MThlOTRiIDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvbXRkL2NoaXBzL2NmaV9jbWRzZXRfMDAwMi5jDQo+ID4gKysrIGIvZHJpdmVy
cy9tdGQvY2hpcHMvY2ZpX2NtZHNldF8wMDAyLmMNCj4gPiBAQCAtMTg3NiwxNCArMTg3NiwxNCBA
QCBzdGF0aWMgaW50IF9feGlwcmFtIGRvX3dyaXRlX2J1ZmZlcihzdHJ1Y3QNCj4gbWFwX2luZm8g
Km1hcCwgc3RydWN0IGZsY2hpcCAqY2hpcCwNCj4gPiAgCQkJY29udGludWU7DQo+ID4gIAkJfQ0K
PiA+DQo+ID4gLQkJaWYgKHRpbWVfYWZ0ZXIoamlmZmllcywgdGltZW8pICYmICFjaGlwX3JlYWR5
KG1hcCwgYWRyKSkNCj4gPiAtCQkJYnJlYWs7DQo+ID4gLQ0KPiA+ICAJCWlmIChjaGlwX2dvb2Qo
bWFwLCBhZHIsIGRhdHVtKSkgew0KPiA+ICAJCQl4aXBfZW5hYmxlKG1hcCwgY2hpcCwgYWRyKTsN
Cj4gPiAgCQkJZ290byBvcF9kb25lOw0KPiA+ICAJCX0NCj4gPg0KPiA+ICsJCWlmICh0aW1lX2Fm
dGVyKGppZmZpZXMsIHRpbWVvKSkNCj4gPiArCQkJYnJlYWs7DQo+ID4gKw0KPiANCj4gSXQgaXMg
cXVpdGUgcG9zc2libGUgdGhhdCB0aGlzIHRocmVhZCBtaWdodCBiZSBwcmUtZW1wdGVkIGp1c3Qg
YWZ0ZXINCj4gY2hpcF9nb29kKCkgY2hlY2sgYnV0IGJlZm9yZSBiZWZvcmUgdGltZV9hZnRlcigp
LiBJZiB0aGUgdGhyZWFkLCB0aGVuIHJlc3VtZXMNCj4gZXhlY3V0aW9uIGFmdGVyIHRpbWVvIGhh
cyBlbGFzcGVkIHRoZW4sIHRoaXMgY29kZSB3aWxsIHdyb25nbHkgaW5kaWNhdGUgd3JpdGUNCj4g
ZmFpbHVyZS4NCj4gDQo+IFRvIGF2b2lkIHRoaXMgY2FzZSwgeW91IHNob3VsZCBhZGQgb25lIG1v
cmUgY2hlY2sgZm9yIGNoZWNrX2dvb2QoKSBldmVuIHdoZW4NCj4gdGltZV9hZnRlcigpIHJldHVy
bnMgdHJ1ZS4gU29tZXRoaW5nIGxpa2U6DQo+IA0KPiAJaWYgKHRpbWVfYWZ0ZXIoamlmZmllcywg
dGltZW8pKSB7DQo+IAkJaWYgKGNoaXBfZ29vZChtYXAsIGFkciwgZGF0dW0pKSB7DQo+IAkJCXhp
cF9lbmFibGUobWFwLCBjaGlwLCBhZHIpOw0KPiAJCQlnb3RvIG9wX2RvbmU7DQo+IAkJfQ0KPiAJ
CWJyZWFrOw0KPiAJfQ0KPiANClNvLCAgdGhlIHBhdGNoIHNob3VsZCBsaWtlIHRoaXMgPw0KDQpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvY2hpcHMvY2ZpX2NtZHNldF8wMDAyLmMgYi9kcml2ZXJz
L210ZC9jaGlwcy9jZmlfY21kc2V0XzAwMDIuYw0KaW5kZXggNzI0MjhiNi4uM2RhMjM3NiAxMDA2
NDQNCi0tLSBhL2RyaXZlcnMvbXRkL2NoaXBzL2NmaV9jbWRzZXRfMDAwMi5jDQorKysgYi9kcml2
ZXJzL210ZC9jaGlwcy9jZmlfY21kc2V0XzAwMDIuYw0KQEAgLTE4NzYsNyArMTg3Niw3IEBAIHN0
YXRpYyBpbnQgX194aXByYW0gZG9fd3JpdGVfYnVmZmVyKHN0cnVjdCBtYXBfaW5mbyAqbWFwLCBz
dHJ1Y3QgZmxjaGlwICpjaGlwLA0KICAgICAgICAgICAgICAgICAgICAgICAgY29udGludWU7DQog
ICAgICAgICAgICAgICAgfQ0KDQotICAgICAgICAgICAgICAgaWYgKHRpbWVfYWZ0ZXIoamlmZmll
cywgdGltZW8pICYmICFjaGlwX3JlYWR5KG1hcCwgYWRyKSkNCisgICAgICAgICAgICAgICBpZiAo
dGltZV9hZnRlcihqaWZmaWVzLCB0aW1lbykgJiYgIWNoaXBfZ29vZChtYXAsIGFkciwgZGF0dW0p
KQ0KICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQoNCiAgICAgICAgICAgICAgICBpZiAo
Y2hpcF9nb29kKG1hcCwgYWRyLCBkYXR1bSkpIHsNCg0KDQoNCkFueSBvdGhlciBvcGluaW9ucz8N
CklmIHRoZXJlIGFyZSBubyBvdGhlciBjb21tZW50cywgSSB3aWxsIHNlbmQgYSBwYXRjaCBhZ2Fp
bg0KDQo+IA0KPiA+ICAJCS8qIExhdGVuY3kgaXNzdWVzLiBEcm9wIHRoZSBsb2NrLCB3YWl0IGEg
d2hpbGUgYW5kIHJldHJ5ICovDQo+ID4gIAkJVURFTEFZKG1hcCwgY2hpcCwgYWRyLCAxKTsNCj4g
PiAgCX0NCj4gPg0KPiANCj4gLS0NCj4gUmVnYXJkcw0KPiBWaWduZXNoDQo=
