Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86C7C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93DC020862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:07:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93DC020862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730397AbeKFUc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 15:32:27 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:49890 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726976AbeKFUc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 15:32:26 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by dkim.mimecast.com with ESMTP id uk-mta-73-zbbIy2x3PTyacKT6AuZrKQ-1;
 Tue, 06 Nov 2018 11:07:40 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 6 Nov 2018 11:07:46 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 6 Nov 2018 11:07:46 +0000
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
Thread-Index: AQHUdUfJjxPqMWIPVkCDxWbeIJk+/6VCg0ZQgAAHZYCAAAoxEA==
Date:   Tue, 6 Nov 2018 11:07:46 +0000
Message-ID: <3c9adab0f1f74c46a60b3d4401030337@AcuMS.aculab.com>
References: <20181105204000.129023-1-bvanassche@acm.org>
 <62188a351f2249188ce654ee03c894b1@AcuMS.aculab.com>
 <e44e6c8b-e4e4-e7cb-a5ca-88e9559eb0d7@suse.cz>
In-Reply-To: <e44e6c8b-e4e4-e7cb-a5ca-88e9559eb0d7@suse.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: zbbIy2x3PTyacKT6AuZrKQ-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogVmxhc3RpbWlsIEJhYmthIFttYWlsdG86dmJhYmthQHN1c2UuY3pdDQo+IFNlbnQ6IDA2
IE5vdmVtYmVyIDIwMTggMTA6MjINCi4uLg0KPiA+PiAtCXJldHVybiB0eXBlX2RtYSArIChpc19y
ZWNsYWltYWJsZSAmICFpc19kbWEpICogS01BTExPQ19SRUNMQUlNOw0KPiA+PiArCXJldHVybiB0
eXBlX2RtYSArIGlzX3JlY2xhaW1hYmxlICogIWlzX2RtYSAqIEtNQUxMT0NfUkVDTEFJTTsNCj4g
Pg0KPiA+IElTVE0gdGhhdCBjaGFuZ2luZyBpc19kbWEgYW5kIGlzX3JlY2xhaW1hYmxlIGZyb20g
aW50IHRvIGJvb2wgd2lsbCBzdG9wIHRoZSBibGVhdGluZy4NCj4gPg0KPiA+IEl0IGlzIGFsc28g
c3RyYW5nZSB0aGF0IHRoaXMgY29kZSBpcyB0cnlpbmcgc28gaGFyZCBoZXJlIHRvIGF2b2lkIGNv
bmRpdGlvbmFsIGluc3RydWN0aW9ucw0KDQpJJ3ZlIGRvbmUgc29tZSBleHBlcmltZW50cywgY29t
cGlsZWQgd2l0aCBnY2MgNC43LjMgYW5kIC1PMg0KVGhlIGNvbnN0YW50cyBtYXRjaCB0aG9zZSBm
cm9tIHRoZSBrZXJuZWwgaGVhZGVycy4NCg0KSXQgaXMgbm90aWNhYmxlIHRoYXQgdGhlcmUgaXNu
J3QgYSBjbW92IGluIHNpZ2h0Lg0KVGhlIGNvZGUgd291bGQgYWxzbyBiZSBiZXR0ZXIgaWYgdGhl
IEtNQUxMT0MgY29uc3RhbnRzIG1hdGNoZWQgdGhlIEdGUCBvbmVzLg0KDQoNCiNkZWZpbmUgX19H
RlBfRE1BIDF1DQojZGVmaW5lIF9fR0ZQX1JFQ0xBSU0gMHgxMHUNCg0KI2RlZmluZSBLTUFMTE9D
X0RNQSAyDQojZGVmaW5lIEtNQUxMT0NfUkVDTEFJTSAxDQoNCnVuc2lnbmVkIGludCBmKHVuc2ln
bmVkIGludCBmbGFncykNCnsNCiAgICAgICAgcmV0dXJuIGZsYWdzICYgX19HRlBfRE1BID8gS01B
TExPQ19ETUEgOiBmbGFncyAmIF9fR0ZQX1JFQ0xBSU0gPyBLTUFMTE9DX1JFQ0xBSU0gOiAwOw0K
fQ0KDQp1bnNpZ25lZCBpbnQgZjEodW5zaWduZWQgaW50IGZsYWdzKQ0Kew0KICAgICAgICByZXR1
cm4gIV9fYnVpbHRpbl9leHBlY3QoZmxhZ3MgJiAoX19HRlBfRE1BIHwgX19HRlBfUkVDTEFJTSks
IDApID8gMCA6IGZsYWdzICYgX19HRlBfRE1BID8gS01BTExPQ19ETUEgOiBLTUFMTE9DX1JFQ0xB
SU07DQp9DQoNCnVuc2lnbmVkIGludCBmMih1bnNpZ25lZCBpbnQgZmxhZ3MpDQp7DQogICAgICAg
IGludCBpc19kbWEsIHR5cGVfZG1hLCBpc19yZWM7DQoNCiAgICAgICAgaXNfZG1hID0gISEoZmxh
Z3MgJiBfX0dGUF9ETUEpOw0KICAgICAgICB0eXBlX2RtYSA9IGlzX2RtYSAqIEtNQUxMT0NfRE1B
Ow0KICAgICAgICBpc19yZWMgPSAhIShmbGFncyAmIF9fR0ZQX1JFQ0xBSU0pOw0KDQogICAgICAg
IHJldHVybiB0eXBlX2RtYSArIChpc19yZWMgJiAhaXNfZG1hKSAqIEtNQUxMT0NfUkVDTEFJTTsN
Cn0NCg0KdW5zaWduZWQgaW50IGYzKHVuc2lnbmVkIGludCBmbGFncykNCnsNCiAgICAgICAgaW50
IGlzX2RtYSwgdHlwZV9kbWEsIGlzX3JlYzsNCg0KICAgICAgICBpc19kbWEgPSAhIShmbGFncyAm
IF9fR0ZQX0RNQSk7DQogICAgICAgIHR5cGVfZG1hID0gaXNfZG1hICogS01BTExPQ19ETUE7DQog
ICAgICAgIGlzX3JlYyA9ICEhKGZsYWdzICYgX19HRlBfUkVDTEFJTSk7DQoNCiAgICAgICAgcmV0
dXJuIHR5cGVfZG1hICsgKGlzX3JlYyAqICFpc19kbWEpICogS01BTExPQ19SRUNMQUlNOw0KfQ0K
DQpEaXNhc3NlbWJseSBvZiBzZWN0aW9uIC50ZXh0Og0KDQowMDAwMDAwMDAwMDAwMDAwIDxmPjoN
CiAgIDA6ICAgNDAgZjYgYzcgMDEgICAgICAgICAgICAgdGVzdCAgICQweDEsJWRpbA0KICAgNDog
ICBiOCAwMiAwMCAwMCAwMCAgICAgICAgICBtb3YgICAgJDB4MiwlZWF4DQogICA5OiAgIDc0IDA1
ICAgICAgICAgICAgICAgICAgIGplICAgICAxMCA8ZisweDEwPg0KICAgYjogICBmMyBjMyAgICAg
ICAgICAgICAgICAgICByZXB6IHJldHENCiAgIGQ6ICAgMGYgMWYgMDAgICAgICAgICAgICAgICAg
bm9wbCAgICglcmF4KQ0KICAxMDogICA4OSBmOCAgICAgICAgICAgICAgICAgICBtb3YgICAgJWVk
aSwlZWF4DQogIDEyOiAgIGMxIGU4IDA0ICAgICAgICAgICAgICAgIHNociAgICAkMHg0LCVlYXgN
CiAgMTU6ICAgODMgZTAgMDEgICAgICAgICAgICAgICAgYW5kICAgICQweDEsJWVheA0KICAxODog
ICBjMyAgICAgICAgICAgICAgICAgICAgICByZXRxDQoNClRoaXMgb25lIGhhcyBhIG1pc3ByZWRp
Y2VkIGJyYW5jaCBpbiB0aGUgY29tbW9uIHBhdGguDQoNCjAwMDAwMDAwMDAwMDAwMjAgPGYxPjoN
CiAgMjA6ICAgNDAgZjYgYzcgMTEgICAgICAgICAgICAgdGVzdCAgICQweDExLCVkaWwNCiAgMjQ6
ICAgNzUgMDMgICAgICAgICAgICAgICAgICAgam5lICAgIDI5IDxmMSsweDk+DQogIDI2OiAgIDMx
IGMwICAgICAgICAgICAgICAgICAgIHhvciAgICAlZWF4LCVlYXgNCiAgMjg6ICAgYzMgICAgICAg
ICAgICAgICAgICAgICAgcmV0cQ0KICAyOTogICA4MyBlNyAwMSAgICAgICAgICAgICAgICBhbmQg
ICAgJDB4MSwlZWRpDQogIDJjOiAgIDgzIGZmIDAxICAgICAgICAgICAgICAgIGNtcCAgICAkMHgx
LCVlZGkNCiAgMmY6ICAgMTkgYzAgICAgICAgICAgICAgICAgICAgc2JiICAgICVlYXgsJWVheA0K
ICAzMTogICA4MyBjMCAwMiAgICAgICAgICAgICAgICBhZGQgICAgJDB4MiwlZWF4DQogIDM0OiAg
IGMzICAgICAgICAgICAgICAgICAgICAgIHJldHENCg0KVGhlIGpuZSB3aWxsIGJlIHByZWRpY3Rl
ZCBub3QgdGFrZW4gYW5kIHRoZSByZXRxIHByZWRpY3RlZC4NClNvIHRoaXMgbWlnaHQgb25seSBi
ZSAxIGNsb2NrIGluIHRoZSBub3JtYWwgY2FzZS4NCg0KMDAwMDAwMDAwMDAwMDA0MCA8ZjI+Og0K
ICA0MDogICA4OSBmOCAgICAgICAgICAgICAgICAgICBtb3YgICAgJWVkaSwlZWF4DQogIDQyOiAg
IGMxIGVmIDA0ICAgICAgICAgICAgICAgIHNociAgICAkMHg0LCVlZGkNCiAgNDU6ICAgODMgZTAg
MDEgICAgICAgICAgICAgICAgYW5kICAgICQweDEsJWVheA0KICA0ODogICA4OSBjMiAgICAgICAg
ICAgICAgICAgICBtb3YgICAgJWVheCwlZWR4DQogIDRhOiAgIDgzIGYyIDAxICAgICAgICAgICAg
ICAgIHhvciAgICAkMHgxLCVlZHgNCiAgNGQ6ICAgMjEgZDcgICAgICAgICAgICAgICAgICAgYW5k
ICAgICVlZHgsJWVkaQ0KICA0ZjogICA4ZCAwNCA0NyAgICAgICAgICAgICAgICBsZWEgICAgKCVy
ZGksJXJheCwyKSwlZWF4DQogIDUyOiAgIGMzICAgICAgICAgICAgICAgICAgICAgIHJldHENCg0K
Tm8gY29uZGl0aW9uYWxzLCBidXQgYSA0IGRlZXAgZGVwZW5kZW5jeSBjaGFpbi4NCg0KMDAwMDAw
MDAwMDAwMDA2MCA8ZjM+Og0KICA2MDogICA4OSBmYSAgICAgICAgICAgICAgICAgICBtb3YgICAg
JWVkaSwlZWR4DQogIDYyOiAgIGMxIGVmIDA0ICAgICAgICAgICAgICAgIHNociAgICAkMHg0LCVl
ZGkNCiAgNjU6ICAgODMgZTIgMDEgICAgICAgICAgICAgICAgYW5kICAgICQweDEsJWVkeA0KICA2
ODogICA4MyBlNyAwMSAgICAgICAgICAgICAgICBhbmQgICAgJDB4MSwlZWRpDQogIDZiOiAgIDg5
IGQwICAgICAgICAgICAgICAgICAgIG1vdiAgICAlZWR4LCVlYXgNCiAgNmQ6ICAgODMgZjAgMDEg
ICAgICAgICAgICAgICAgeG9yICAgICQweDEsJWVheA0KICA3MDogICAwZiBhZiBjNyAgICAgICAg
ICAgICAgICBpbXVsICAgJWVkaSwlZWF4DQogIDczOiAgIDhkIDA0IDUwICAgICAgICAgICAgICAg
IGxlYSAgICAoJXJheCwlcmR4LDIpLCVlYXgNCiAgNzY6ICAgYzMgICAgICAgICAgICAgICAgICAg
ICAgcmV0cQ0KDQpZb3UgcmVhbGx5IGRvbid0IHdhbnQgdGhlIG11bHRpcGx5Lg0KDQoJRGF2aWQN
Cg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZh
cm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYg
KFdhbGVzKQ0K

