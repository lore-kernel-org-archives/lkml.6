Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B882C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 03:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8431720831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 03:56:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8431720831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tencent.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730820AbeKTOXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 09:23:53 -0500
Received: from mail2.tencent.com ([163.177.67.195]:33324 "EHLO
        mail2.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730148AbeKTOXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 09:23:53 -0500
Received: from EXHUB-SZMail05.tencent.com (unknown [10.14.6.11])
        by mail2.tencent.com (Postfix) with ESMTP id 7F43C8EDEB;
        Tue, 20 Nov 2018 11:56:49 +0800 (CST)
Received: from EXMBX-SZMAIL022.tencent.com ([fe80::dcc:e364:cd45:89d9]) by
 EXHUB-SZMail05.tencent.com ([::1]) with mapi id 14.03.0415.000; Tue, 20 Nov
 2018 11:56:47 +0800
From:   =?utf-8?B?Y2hvdXJ5emhvdSjlkajlqIEp?= <chouryzhou@tencent.com>
To:     Christian Brauner <christian@brauner.io>,
        Todd Kjos <tkjos@google.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        =?utf-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V4] binder: ipc namespace support for android binder
Thread-Topic: [PATCH V4] binder: ipc namespace support for android binder
Thread-Index: AdSAhQCNOWQOOCZBTaKM+8Nt+bdtxQ==
Date:   Tue, 20 Nov 2018 03:56:45 +0000
Message-ID: <5FBCBE569E134E4CA167B91C0A77FD610198FA2BCD@EXMBX-SZMAIL022.tencent.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.96.209.54]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBGcmksIE5vdiAxNiwgMjAxOCBhdCAxMToxOTo0MUFNIC0wODAwLCBUb2RkIEtqb3Mgd3Jv
dGU6DQo+ID4gT24gVGh1LCBOb3YgMTUsIDIwMTggYXQgMjo1NCBQTSBncmVna2hAbGludXhmb3Vu
ZGF0aW9uLm9yZw0KPiA+IDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4gd3JvdGU6DQo+ID4g
Li4uDQo+ID4gPg0KPiA+ID4gQSBudW1iZXIgb2YgdXMgaGF2ZSB0YWxrZWQgYWJvdXQgdGhpcyBp
biB0aGUgcGx1bWJlcnMgQW5kcm9pZCB0cmFjaywgYW5kDQo+ID4gPiBhIGRpZmZlcmVudCBwcm9w
b3NhbCBmb3IgaG93IHRvIHNvbHZlIHRoaXMgaGFzIGJlZW4gbWFkZSB0aGF0IHNob3VsZCBiZQ0K
PiA+ID4gbXVjaCBtb3JlIHJlc2lsaWFudC4gIFNvIEkgd2lsbCBkcm9wIHRoaXMgcGF0Y2ggZnJv
bSBteSBxdWV1ZSBhbmQgd2FpdA0KPiA+ID4gZm9yIHRoZSBwYXRjaGVzIGJhc2VkIG9uIHRoZSBk
aXNjdXNzaW9ucyB3ZSBoYWQgdGhlcmUuDQo+ID4gPg0KPiA+ID4gSSB0aGluayB0aGVyZSdzIHNv
bWUgbm90ZXMvc2xpZGVzIG9uIHRoZSBkaXNjdXNzaW9uIG9ubGluZSBzb21ld2hlcmUsDQo+ID4g
PiBidXQgaXQgaGFzbid0IGJlZW4gcHVibGlzaGVkIGFzIHRoZSBjb25mZXJlbmNlIGlzIHN0aWxs
IGhhcHBlbmluZywNCj4gPiA+IG90aGVyd2lzZSBJIHdvdWxkIGxpbmsgdG8gaXQgaGVyZS4uLg0K
PiA+DQo+ID4gSGVyZSBpcyBhIGxpbmsgdG8gdGhlIHNlc3Npb24gd2hlcmUgeW91IGNhbiBsb29r
IGF0IHRoZSBzbGlkZXMgWzFdLg0KPiA+IFRoZXJlIHdhcyBjb25zZW5zdXMgdGhhdCAiYmluZGVy
ZnMiIChzbGlkZSA1KSB3YXMgdGhlIG1vc3QgcHJvbWlzaW5nDQo+ID4gLS0gYnV0IHdvdWxkIGJl
IGJlaGluZCBhIGNvbmZpZyBvcHRpb24gdG8gcHJvdmlkZSBiYWNrd2FyZHMNCj4gPiBjb21wYXRp
YmlsaXR5IGZvciBub24tY29udGFpbmVyIHVzZS1jYXNlcy4NCj4gPg0KPiA+IFRoZSBldGhlcnBh
ZCBub3RlcyBhcmUgYXQgWzJdIChsb29rIGF0ICJEeW5hbWljYWxseSBBbGxvY2F0ZWQgQmluZGVy
DQo+ID4gRGV2aWNlcyIgc2VjdGlvbikNCj4gPg0KPiA+IENocmlzdGlhbiBCcmF1bmVyIHdpbGwg
YmUgc2VuZGluZyBvdXQgbW9yZSBkZXRhaWxzLg0KPiANCj4gT2ssIHNvcnJ5IGZvciB0aGUgZGVs
YXkgSSBnb3QgY2F1Z2h0IHVwIGluIG90aGVyIHdvcmsuDQo+IA0KPiBUaGUgaWRlYSBpcyB0byBp
bXBsZW1lbnQgYmluZGVyZnMgd2hpY2ggSSdtIHN0YXJ0aW5nIHRvIHdvcmsgb24uDQo+IGJpbmRl
cmZzIHdpbGwgYmUgYSBzZXBhcmF0ZSBwc2V1ZG8tZmlsZXN5c3RlbSB0aGF0IHdpbGwgYmUgbW91
bnRhYmxlDQo+IHBlci1pcGMgbmFtZXNwYWNlLg0KPiBUaGlzIGhhcyB0aGUgYWR2YW50YWdlIHRo
YXQgdGhlIGlwYyBuYW1lc3BhY2UgaXMgYXR0YWNoZWQgdG8gdGhlDQo+IHN1cGVyYmxvY2sgb2Yg
dGhlIG1vdW50IGFuZCBjYW4gYmUgZWFzaWx5IHJldHJpZXZlZCBieSB0aGUgYmluZGVyDQo+IGRy
aXZlci4gSXQgYWxzbyBpbXBsaWVzIHRoYXQgLSBpbiBjb250cmFzdCB0byB0aGUgcHJvcG9zZWQg
cGF0Y2ggaGVyZSAtDQo+IGFuIG9wZW4oKSBvbiBhIGdpdmVuIGJpbmRlciBkZXZpY2Ugd2lsbCBu
b3QgYmUgYWJsZSB0byBjaGFuZ2UgdGhlIGlwYw0KPiBuYW1lc3BhY2Ugb2Ygc2FpZCBkZXZpY2Vz
LiBUaGUgb2J2aW91cyBjb3JvbGxhcnkgaXMgdGhhdCB5b3UgY2FuDQo+IGJpbmQtbW91bnQgYmlu
ZGVyIGRldmljZXMgb3IgdGhlIHdob2xlIGJpbmRlcmZzIG1vdW50IGJldHdlZW4gZGlmZmVyZW50
DQo+IGlwYyBuYW1lc3BhY2VzIGFuZCBnaXZlbiB0aGUgcmlnaHQgcGVybWlzc2lvbnMgKENBUF9J
UENfT1dORVIgaW4gdGhlDQo+IG93bmluZyB1c2VybnMgb2YgdGhlIGlwY25zKSBjYW4gc2VlIHNl
cnZpY2VzIG9uIHRoZSBob3N0IHdoaWNoIGlzDQo+IHNvbWV0aGluZyB0aGF0IHBlb3BsZSB3YW50
ZWQgdG8gYmUgYWJsZSB0byBkby4NCj4gQWRkaXRpb25hbGx5LCBlYWNoIGJpbmRlcmZzIG1vdW50
IHdpbGwgY29tZSB3aXRoIGEgYmluZGVyLWNvbnRyb2wNCj4gZGV2aWNlLiBUaGlzIGRldmljZSBp
cyBmdW5jdGlvbmFsbHkgc2ltaWxhciB0byBsb29wLWNvbnRyb2wgYW5kIHdpbGwNCj4gYWxsb3cg
Zm9yIGR5bmFtaWMgYWxsb2NhdGlvbiAoYW5kIHBvc3NpYmx5IGRlYWxsb2NhdGlvbikgb2YgYmlu
ZGVyDQo+IGRldmljZXMuIFdpdGggdGhpcyB3ZSBjYW4gcmVtb3ZlIHRoZSByZXN0cmljdGlvbiB0
byBoYXJkLWNvZGUgdGhlIG51bWJlcg0KPiBvZiBiaW5kZXIgZGV2aWNlcyBhdCBjb21waWxlIHRp
bWUuDQo+IEJhY2t3YXJkcyBjb21wYXRpYmlsaXR5IGNhbiBlaXRoZXIgYmUgZ3VhcmFudGVlZCBi
eSBoaWRpbmcgYmluZGVyZnMNCj4gYmVoaW5kIGEgY29tcGlsZSBmbGFnIG9yIGJ5IHNwZWNpYWwt
Y2FzaW5nIHRoZSBpbml0YWwgYmluZGVyZnMgbW91bnQgdG8NCj4gcHJlLWNyZWF0ZSB0aGUgc3Rh
bmRhcmQgYmluZGVyIGRldmljZXMuIFRoZSBqdXJ5IGlzIHN0aWxsIG91dCBvbiB0aGlzLg0KPiAN
Cj4gQ2hyaXN0aWFuDQo+IA0KDQpTaW5jZSB5b3UgYXJlIHdvcmtpbmcgb24gdGhpcywgSSB3aWxs
IHdpdGhkcmF3IHRoaXMgcGF0Y2guIFdlIHdpbGwgZXZhbHVhdGUgDQp3aGV0aGVyIHRvIHlvdXIg
c29sdXRpb24gaW4gb3VyIGVudmlyb25tZW50IGFmdGVyIHlvdSBpbXBsZW1lbnQgaXQuIA0K
