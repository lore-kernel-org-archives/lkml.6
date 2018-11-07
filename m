Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60914C32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 01:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93A342086B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 01:48:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93A342086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tencent.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389083AbeKGLQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 06:16:44 -0500
Received: from mail4.tencent.com ([183.57.53.109]:52223 "EHLO
        mail4.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388314AbeKGLQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 06:16:44 -0500
Received: from EXHUB-SZMail05.tencent.com (unknown [10.14.6.11])
        by mail4.tencent.com (Postfix) with ESMTP id 4451450943;
        Wed,  7 Nov 2018 09:48:19 +0800 (CST)
Received: from EXMBX-SZMAIL022.tencent.com ([fe80::dcc:e364:cd45:89d9]) by
 EXHUB-SZMail05.tencent.com ([::1]) with mapi id 14.03.0415.000; Wed, 7 Nov
 2018 09:48:16 +0800
From:   =?utf-8?B?Y2hvdXJ5emhvdSjlkajlqIEp?= <chouryzhou@tencent.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "arve@android.com" <arve@android.com>,
        "tkjos@android.com" <tkjos@android.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2] binder: ipc namespace support for android binder
Thread-Topic: [PATCH V2] binder: ipc namespace support for android binder
Thread-Index: AdR2O9PdakWPLy3uTgS8yHvEPC98iw==
Date:   Wed, 7 Nov 2018 01:48:12 +0000
Message-ID: <5FBCBE569E134E4CA167B91C0A77FD610198F816F8@EXMBX-SZMAIL022.tencent.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.96.209.72]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmRyZXcgTW9ydG9uIDxha3Bt
QGxpbnV4LWZvdW5kYXRpb24ub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIE5vdmVtYmVyIDcsIDIw
MTggODowNyBBTQ0KPiBUbzogY2hvdXJ5emhvdSjlkajlqIEpIDxjaG91cnl6aG91QHRlbmNlbnQu
Y29tPg0KPiBDYzogZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7IGFydmVAYW5kcm9pZC5jb207
IHRram9zQGFuZHJvaWQuY29tOw0KPiBkYXZlQHN0Z29sYWJzLm5ldDsgZGV2ZWxAZHJpdmVyZGV2
Lm9zdW9zbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6
IFtQQVRDSCBWMl0gYmluZGVyOiBpcGMgbmFtZXNwYWNlIHN1cHBvcnQgZm9yIGFuZHJvaWQNCj4g
YmluZGVyDQo+IA0KPiBPbiBNb24sIDI5IE9jdCAyMDE4IDA2OjE4OjExICswMDAwIGNob3VyeXpo
b3Uo5ZGo5aiBKQ0KPiA8Y2hvdXJ5emhvdUB0ZW5jZW50LmNvbT4gd3JvdGU6DQo+IA0KPiA+ICAg
V2UgYXJlIHdvcmtpbmcgZm9yIHJ1bm5pbmcgYW5kcm9pZCBpbiBjb250YWluZXIsIGJ1dCB3ZSBm
b3VuZCB0aGF0IGJpbmRlcg0KPiBpcw0KPiA+IG5vdCBpc29sYXRlZCBieSBpcGMgbmFtZXNwYWNl
LiBTaW5jZSBiaW5kZXIgaXMgYSBmb3JtIG9mIElQQyBhbmQgdGhlcmVmb3JlDQo+IHNob3VsZA0K
PiA+IGJlIHRpZWQgdG8gaXBjIG5hbWVzcGFjZS4gV2l0aCB0aGlzIHBhdGNoLCB3ZSBjYW4gcnVu
IG1vcmUgdGhhbiBvbmUgYW5kcm9pZA0KPiA+IGNvbnRhaW5lciBvbiBvbmUgaG9zdC4NCj4gPiAg
IFRoaXMgcGF0Y2ggbW92ZSAiYmluZGVyX3Byb2NzIiBhbmQgImJpbmRlcl9jb250ZXh0IiBpbnRv
DQo+IGlwY19uYW1lc3BhY2UsDQo+ID4gZHJpdmVyIHdpbGwgZmluZCB0aGUgY29udGV4dCBmcm9t
IGl0IHdoZW4gb3BlbmluZy4gQWx0aG91Z2ggc3RhdGlzdGljcyBpbg0KPiBkZWJ1Z2ZzDQo+ID4g
cmVtYWluIGdsb2JhbC4NCj4gPg0KPiA+IC4uLg0KPiA+DQo+ID4gLS0tIGEvaXBjL25hbWVzcGFj
ZS5jDQo+ID4gKysrIGIvaXBjL25hbWVzcGFjZS5jDQo+ID4gQEAgLTU2LDYgKzU2LDkgQEAgc3Rh
dGljIHN0cnVjdCBpcGNfbmFtZXNwYWNlICpjcmVhdGVfaXBjX25zKHN0cnVjdA0KPiB1c2VyX25h
bWVzcGFjZSAqdXNlcl9ucywNCj4gPiAgICAgICAgIG5zLT51Y291bnRzID0gdWNvdW50czsNCj4g
Pg0KPiA+ICAgICAgICAgZXJyID0gbXFfaW5pdF9ucyhucyk7DQo+ID4gKyAgICAgICBpZiAoZXJy
KQ0KPiA+ICsgICAgICAgICAgICAgICBnb3RvIGZhaWxfcHV0Ow0KPiA+ICsgICAgICAgZXJyID0g
YmluZGVyX2luaXRfbnMobnMpOw0KPiA+ICAgICAgICAgaWYgKGVycikNCj4gPiAgICAgICAgICAg
ICAgICAgZ290byBmYWlsX3B1dDsNCj4gPg0KPiANCj4gRG9uJ3Qgd2UgbmVlZCBhbiBtcV9wdXRf
bW50KCkgaWYgYmluZGVyX2luaXRfbnMoKSBmYWlscz8NCj4gDQo+IGZyZWVfaXBjX25zKCkgc2Vl
bXMgdG8gaGF2ZSBmb3Jnb3R0ZW4gYWJvdXQgdGhhdCB0b28uICBJbiB3aGljaCBjYXNlIGl0DQo+
IG11c3QgYmUgbWFkbHkgbGVha2luZyBtb3VudHMgc28gcHJvYmFibHkgSSdtIHdyb25nLiAgQ29u
ZnVzZWQuDQo+IA0KDQptcV9pbml0X25zIHdpbGwgZG8gY2xlYW4gam9iIGlmIGl0IGZhaWxlZCwg
YW5kIGFzIGRvIGJpbmRlcl9pbml0X25zLiANCg==
