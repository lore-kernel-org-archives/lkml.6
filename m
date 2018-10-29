Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BBAC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 02:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5B9F2082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 02:29:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5B9F2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tencent.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbeJ2LQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 07:16:06 -0400
Received: from mail4.tencent.com ([183.57.53.109]:60997 "EHLO
        mail4.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729128AbeJ2LQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 07:16:06 -0400
Received: from EXHUB-SZMAIL04.tencent.com (unknown [10.14.6.35])
        by mail4.tencent.com (Postfix) with ESMTP id 312DC5015D;
        Mon, 29 Oct 2018 10:29:27 +0800 (CST)
Received: from EXMBX-SZMAIL022.tencent.com ([fe80::dcc:e364:cd45:89d9]) by
 EXHUB-SZMAIL04.tencent.com ([::1]) with mapi id 14.03.0415.000; Mon, 29 Oct
 2018 10:29:17 +0800
From:   =?utf-8?B?Y2hvdXJ5emhvdSjlkajlqIEp?= <chouryzhou@tencent.com>
To:     Todd Kjos <tkjos@google.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?utf-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?utf-8?B?Y2hvdXJ5emhvdSjlkajlqIEp?= <chouryzhou@tencent.com>
Subject: RE: [PATCH] binder: ipc namespace support for android binder
Thread-Topic: [PATCH] binder: ipc namespace support for android binder
Thread-Index: AdRvLq/0N5Jg5ds8SyKSO/9pZfjvhg==
Date:   Mon, 29 Oct 2018 02:29:08 +0000
Message-ID: <5FBCBE569E134E4CA167B91C0A77FD610198F6B4F6@EXMBX-SZMAIL022.tencent.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.96.209.37]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gSGkNCj4+ICAgV2UgYXJlIHdvcmtpbmcgZm9yIHJ1bm5pbmcgYW5kcm9pZCBpbiBjb250YWlu
ZXIsIGJ1dCB3ZSBmb3VuZCB0aGF0IGJpbmRlciBpcw0KPj4gbm90IGlzb2xhdGVkIGJ5IGlwYyBu
YW1lc3BhY2UuIFNpbmNlIGJpbmRlciBpcyBhIGZvcm0gb2YgSVBDIGFuZCB0aGVyZWZvcmUgc2hv
dWxkDQo+PiBiZSB0aWVkIHRvIGlwYyBuYW1lc3BhY2UuIFdpdGggdGhpcyBwYXRjaCwgd2UgY2Fu
IHJ1biBtb3JlIHRoYW4gb25lIGFuZHJvaWQNCj4+IGNvbnRhaW5lciBvbiBvbmUgaG9zdC4NCj4+
ICAgVGhpcyBwYXRjaCBtb3ZlICJiaW5kZXJfcHJvY3MiIGFuZCAiYmluZGVyX2NvbnRleHQiIGlu
dG8gaXBjX25hbWVzcGFjZSwNCj4+IGRyaXZlciB3aWxsIGZpbmQgdGhlIGNvbnRleHQgZnJvbSBp
dCB3aGVuIG9wZW5pbmcuIEFsdGhvdWdodCBzdGF0aXN0aWNzIGluIGRlYnVnZnMNCj4+IHJlbWFp
biBnbG9iYWwuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogY2hvdXJ5IHpob3UgPGNob3VyeXpob3VA
dGVuY2VudC5jb20+DQo+PiAtLS0NCj4+ICBkcml2ZXJzL2FuZHJvaWQvS2NvbmZpZyAgICAgICB8
ICAgMiArLQ0KPj4gIGRyaXZlcnMvYW5kcm9pZC9iaW5kZXIuYyAgICAgIHwgMTI2ICsrKysrKysr
KysrKysrKysrKysrKysrKystLS0tLS0tLS0NCj4+ICBpbmNsdWRlL2xpbnV4L2lwY19uYW1lc3Bh
Y2UuaCB8ICAxNCArKysrDQo+PiAgaXBjL25hbWVzcGFjZS5jICAgICAgICAgICAgICAgfCAgIDQg
KysNCj4+ICA0IGZpbGVzIGNoYW5nZWQsIDExMSBpbnNlcnRpb25zKCspLCAzNSBkZWxldGlvbnMo
LSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9hbmRyb2lkL0tjb25maWcgYi9kcml2ZXJz
L2FuZHJvaWQvS2NvbmZpZw0KPj4gaW5kZXggNDMyZTlhZDc3MDcwLi4wOTg4MzQ0M2IyZGEgMTAw
NjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2FuZHJvaWQvS2NvbmZpZw0KPj4gKysrIGIvZHJpdmVycy9h
bmRyb2lkL0tjb25maWcNCj4+IEBAIC0xMCw3ICsxMCw3IEBAIGlmIEFORFJPSUQNCj4+DQo+PiAg
Y29uZmlnIEFORFJPSURfQklOREVSX0lQQw0KPj4gICAgICAgICBib29sICJBbmRyb2lkIEJpbmRl
ciBJUEMgRHJpdmVyIg0KPj4gLSAgICAgICBkZXBlbmRzIG9uIE1NVQ0KPj4gKyAgICAgICBkZXBl
bmRzIG9uIE1NVSAmJiBTWVNWSVBDDQo+IA0KPiBOQUsuIFdlIGNhbid0IGZvcmNlIFNZU1ZJUEMg
b24gZm9yIEFuZHJvaWQuIFRoZSBub3Rpb24gb2YgcnVubmluZw0KPiBiaW5kZXIgaW4gYSBjb250
YWluZXIgaXMgcmVhc29uYWJsZSwgYnV0IG5lZWRzIHRvIGJlIGRvbmUgd2l0aG91dA0KPiBleHBs
aWNpdCByZXF1aXJlbWVudCBmb3IgU1lTVklQQy4gYmluZGVyLWluLWNvbnRhaW5lciBpcyBhIHRv
cGljIGluDQo+IHRoZSBhbmRyb2lkIG1pY3JvY29uZiBhdCBMaW51eCBwbHVtYmVycyAtLSBhcmUg
eW91IGdvaW5nIHRvIGJlIGF0IExQQz8NCj4gDQpXZSBoYXZlIG5vIHBsYW4gdG8gZ29pbmcgdG8g
YXR0ZW5kIExQQyB0ZW1wb3JhcmlseS4NCg0KPiBJdCdzIG5vdCBvYnZpb3VzIGZyb20gdGhpcyBw
YXRjaCB3aGVyZSB0aGlzIGRlcGVuZGVuY3kgY29tZXMNCj4gZnJvbS4uLndoeSBpcyBTWVNWSVBD
IHJlcXVpcmVkPyBJJ2QgbGlrZSB0byBub3QgaGF2ZSB0byByZXF1aXJlIElQQ19OUw0KPiBlaXRo
ZXIgZm9yIGRldmljZXMuDQoNClllcywgdGhlIHBhdGNoIGlzIG5vdCBoaWdobHkgZGVwZW5kZW50
IG9uIFNZU1ZJUEMsIGJ1dCBpdCB3aWxsIGJlIGNvbnZlbmllbnQNCmlmIHJlcXVpcmUgaXQuIEkg
d2lsbCB1cGRhdGUgaXQgdG8gZHJvcCBkZXBlbmRlbmN5IG9mIGl0IGluIFYyIHBhdGNoLiBUaGlz
IHBhdGNoDQpkb2Vzbid0IG5lZWQgSVBDX05TIHNldCBhdCBwcmVzZW50Lg0K
