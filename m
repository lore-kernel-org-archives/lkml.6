Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9E4C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9D7F2085B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:41:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9D7F2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbeKGULE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 15:11:04 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:46493 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726218AbeKGULE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 15:11:04 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by dkim.mimecast.com with ESMTP id uk-mta-34-gJg79r0kPGKnhHOV_H5bug-1;
 Wed, 07 Nov 2018 10:41:10 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed,
 7 Nov 2018 10:41:15 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 7 Nov 2018 10:41:15 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Vlastimil Babka' <vbabka@suse.cz>,
        'Bart Van Assche' <bvanassche@acm.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Christoph Lameter <cl@linux.com>,
        "Roman Gushchin" <guro@fb.com>
Subject: RE: [PATCH] slab.h: Avoid using & for logical and of booleans
Thread-Topic: [PATCH] slab.h: Avoid using & for logical and of booleans
Thread-Index: AQHUdUfJjxPqMWIPVkCDxWbeIJk+/6VCg0ZQgAAHZYCAAAoxEIAAH18AgAFtI9A=
Date:   Wed, 7 Nov 2018 10:41:15 +0000
Message-ID: <9af3ac1d43bb422cb3c41e7e8e422e6e@AcuMS.aculab.com>
References: <20181105204000.129023-1-bvanassche@acm.org>
 <62188a351f2249188ce654ee03c894b1@AcuMS.aculab.com>
 <e44e6c8b-e4e4-e7cb-a5ca-88e9559eb0d7@suse.cz>
 <3c9adab0f1f74c46a60b3d4401030337@AcuMS.aculab.com>
 <60deb90d-e521-39e5-5072-fc9efb98e365@suse.cz>
In-Reply-To: <60deb90d-e521-39e5-5072-fc9efb98e365@suse.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: gJg79r0kPGKnhHOV_H5bug-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogVmxhc3RpbWlsIEJhYmthDQo+IFNlbnQ6IDA2IE5vdmVtYmVyIDIwMTggMTI6NTENCj4g
DQo+IE9uIDExLzYvMTggMTI6MDcgUE0sIERhdmlkIExhaWdodCB3cm90ZToNCj4gPiBGcm9tOiBW
bGFzdGltaWwgQmFia2EgW21haWx0bzp2YmFia2FAc3VzZS5jel0NCj4gPj4gU2VudDogMDYgTm92
ZW1iZXIgMjAxOCAxMDoyMg0KPiA+IC4uLg0KPiA+Pj4+IC0JcmV0dXJuIHR5cGVfZG1hICsgKGlz
X3JlY2xhaW1hYmxlICYgIWlzX2RtYSkgKiBLTUFMTE9DX1JFQ0xBSU07DQo+ID4+Pj4gKwlyZXR1
cm4gdHlwZV9kbWEgKyBpc19yZWNsYWltYWJsZSAqICFpc19kbWEgKiBLTUFMTE9DX1JFQ0xBSU07
DQouLi4NCj4gPiBJJ3ZlIGRvbmUgc29tZSBleHBlcmltZW50cywgY29tcGlsZWQgd2l0aCBnY2Mg
NC43LjMgYW5kIC1PMg0KPiA+IFRoZSBjb25zdGFudHMgbWF0Y2ggdGhvc2UgZnJvbSB0aGUga2Vy
bmVsIGhlYWRlcnMuDQo+ID4NCj4gPiBJdCBpcyBub3RpY2FibGUgdGhhdCB0aGVyZSBpc24ndCBh
IGNtb3YgaW4gc2lnaHQuDQo+IA0KPiBUaGVyZSBpcyB3aXRoIG5ld2VyIGdjYzogaHR0cHM6Ly9n
b2Rib2x0Lm9yZy96L3FGZEJ5UQ0KPiANCj4gQnV0IGV2ZW4gdGhhdCBkaWRuJ3QgcmVtb3ZlIHRo
ZSBpbXVsIGluIGYzKCkgc28gdGhhdCdzIGluZGVlZCBhIGJ1c3QuDQo+IA0KPiA+IFRoZSBjb2Rl
IHdvdWxkIGFsc28gYmUgYmV0dGVyIGlmIHRoZSBLTUFMTE9DIGNvbnN0YW50cyBtYXRjaGVkIHRo
ZSBHRlAgb25lcy4NCj4gDQo+IFRoYXQgd291bGQgYmUgaGFyZCwgYXMgX19HRlAgZmxhZ3MgaGF2
ZSBhbHNvIG90aGVyIGNvbnN0cmFpbnRzDQo+IChlc3BlY2lhbGx5IF9fR0ZQX0RNQSByZWxhdGl2
ZSB0byBvdGhlciB6b25lIHJlc3RyaWN0aW5nIF9fR0ZQIGZsYWdzKQ0KPiBhbmQgS01BTExPQ18q
IGFyZSB1c2VkIGFzIGFycmF5IGluZGV4Lg0KDQpIbW1tLi4uDQpXaXRoIG9ubHkgMiBvciB0aHJl
ZSB2YWx1ZXMgY29uZGl0aW9uYWxzIGFyZSBwcm9iYWJseSBiZXR0ZXIgdGhhbg0KdGFibGUgbG9v
a3VwcyAtIGVzcGVjaWFsbHkgaWYgdGhleSBhcmUgZnVuY3Rpb24gcG9pbnRlcnMuDQoNCj4gDQo+
ID4gdW5zaWduZWQgaW50IGYxKHVuc2lnbmVkIGludCBmbGFncykNCj4gPiB7DQo+ID4gICAgICAg
ICByZXR1cm4gIV9fYnVpbHRpbl9leHBlY3QoZmxhZ3MgJiAoX19HRlBfRE1BIHwgX19HRlBfUkVD
TEFJTSksIDApID8gMCA6IGZsYWdzICYgX19HRlBfRE1BID8NCj4gS01BTExPQ19ETUEgOiBLTUFM
TE9DX1JFQ0xBSU07DQo+ID4gfQ0KPiA+DQo+IA0KPiAuLi4NCj4gDQo+ID4gMDAwMDAwMDAwMDAw
MDAyMCA8ZjE+Og0KPiA+ICAgMjA6ICAgNDAgZjYgYzcgMTEgICAgICAgICAgICAgdGVzdCAgICQw
eDExLCVkaWwNCj4gPiAgIDI0OiAgIDc1IDAzICAgICAgICAgICAgICAgICAgIGpuZSAgICAyOSA8
ZjErMHg5Pg0KPiA+ICAgMjY6ICAgMzEgYzAgICAgICAgICAgICAgICAgICAgeG9yICAgICVlYXgs
JWVheA0KPiA+ICAgMjg6ICAgYzMgICAgICAgICAgICAgICAgICAgICAgcmV0cQ0KPiA+ICAgMjk6
ICAgODMgZTcgMDEgICAgICAgICAgICAgICAgYW5kICAgICQweDEsJWVkaQ0KPiA+ICAgMmM6ICAg
ODMgZmYgMDEgICAgICAgICAgICAgICAgY21wICAgICQweDEsJWVkaQ0KPiA+ICAgMmY6ICAgMTkg
YzAgICAgICAgICAgICAgICAgICAgc2JiICAgICVlYXgsJWVheA0KPiA+ICAgMzE6ICAgODMgYzAg
MDIgICAgICAgICAgICAgICAgYWRkICAgICQweDIsJWVheA0KPiA+ICAgMzQ6ICAgYzMgICAgICAg
ICAgICAgICAgICAgICAgcmV0cQ0KPiA+DQo+ID4gVGhlIGpuZSB3aWxsIGJlIHByZWRpY3RlZCBu
b3QgdGFrZW4gYW5kIHRoZSByZXRxIHByZWRpY3RlZC4NCj4gPiBTbyB0aGlzIG1pZ2h0IG9ubHkg
YmUgMSBjbG9jayBpbiB0aGUgbm9ybWFsIGNhc2UuDQo+IA0KPiBJIHRoaW5rIHRoaXMgaXMgdGhl
IHdpbm5lci4gSXQncyBhbHNvIGEgc2luZ2xlIGJyYW5jaCBhbmQgbm90IHR3bywNCj4gYmVjYXVz
ZSB0aGUgY29tcGlsZXIgY291bGQgZmlndXJlIG91dCBzb21lIG9mIHRoZSAiY2xldmVyIGFyaXRo
bWV0aWNzIg0KPiBpdHNlbGYuIENhcmUgdG8gc2VuZCBhIGZ1bGwgcGF0Y2g/DQoNCkkndmUgbm90
IGdvdCBhIHN1aXRhYmxlIHNvdXJjZSB0cmVlIGx1cmtpbmcuDQpTbyBzb21lb25lIGVsc2Ugd291
bGQgbmVlZCB0byBkbyBpdC4NCkknbGwgd2FpdmUgYW55IGNvcHlyaWdodCB0aGF0IGNvdWxkIHBs
YXVzaWJseSBiZSBhc3NpZ25lZCB0byB0aGUgYWJvdmUhDQoNCglEYXZpZA0KDQotDQpSZWdpc3Rl
cmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtl
eW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

