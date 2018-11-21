Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E3EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF6F82145D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:53:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF6F82145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731570AbeKVC2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 21:28:00 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:56626 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731291AbeKVC2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 21:28:00 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-96-HRHuzG45NRyCpNio0l2opA-1; Wed, 21 Nov 2018 15:52:58 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 21 Nov 2018 15:53:05 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 21 Nov 2018 15:53:05 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jan Beulich' <JBeulich@suse.com>
CC:     "mingo@elte.hu" <mingo@elte.hu>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Juergen Gross" <jgross@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>
Subject: RE: [PATCH v2] x86: modernize sync_bitops.h
Thread-Topic: [PATCH v2] x86: modernize sync_bitops.h
Thread-Index: AQHUgYKYAz8XcFA8pkaOqgSV6G3YUKVaHKgQgAAVTACAAAwV0IAAD5OAgAAPKkA=
Date:   Wed, 21 Nov 2018 15:53:05 +0000
Message-ID: <9dc88b57164e481184dfbb4b2079086e@AcuMS.aculab.com>
References: <5B30C2C302000078001CD6D1@prv1-mh.provo.novell.com>
 <5B30C2C302000000000FA99B@prv1-mh.provo.novell.com>
 <5B30C2C302000078001FE5A0@prv1-mh.provo.novell.com>
 <5BF52F4D02000078001FE5C1@prv1-mh.provo.novell.com>
 <92f590595593498eaa1f91a17875126f@AcuMS.aculab.com>
 <5BF5577202000078001FE7AC@prv1-mh.provo.novell.com>
 <47f7dfd9b32f4425ac8466c8b0065c6e@AcuMS.aculab.com>
 <5BF56EA502000078001FE90E@prv1-mh.provo.novell.com>
In-Reply-To: <5BF56EA502000078001FE90E@prv1-mh.provo.novell.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: HRHuzG45NRyCpNio0l2opA-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFuIEJldWxpY2ggW21h
aWx0bzpKQmV1bGljaEBzdXNlLmNvbV0NCj4gU2VudDogMjEgTm92ZW1iZXIgMjAxOCAxNDo0Mg0K
PiBUbzogRGF2aWQgTGFpZ2h0DQo+IENjOiBtaW5nb0BlbHRlLmh1OyB0Z2x4QGxpbnV0cm9uaXgu
ZGU7IEJvcmlzIE9zdHJvdnNreTsgSnVlcmdlbiBHcm9zczsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsNCj4gaHBhQHp5dG9yLmNvbQ0KPiBTdWJqZWN0OiBSRTogW1BBVENIIHYyXSB4ODY6
IG1vZGVybml6ZSBzeW5jX2JpdG9wcy5oDQo+IA0KPiA+Pj4gT24gMjEuMTEuMTggYXQgMTQ6NDks
IDxEYXZpZC5MYWlnaHRAQUNVTEFCLkNPTT4gd3JvdGU6DQo+ID4gRnJvbTogSmFuIEJldWxpY2gN
Cj4gPj4gU2VudDogMjEgTm92ZW1iZXIgMjAxOCAxMzowMw0KPiA+Pg0KPiA+PiA+Pj4gT24gMjEu
MTEuMTggYXQgMTI6NTUsIDxEYXZpZC5MYWlnaHRAQUNVTEFCLkNPTT4gd3JvdGU6DQo+ID4+ID4g
RnJvbTogSmFuIEJldWxpY2gNCj4gPj4gPj4gU2VudDogMjEgTm92ZW1iZXIgMjAxOCAxMDoxMQ0K
PiA+PiA+Pg0KPiA+PiA+PiBBZGQgbWlzc2luZyBpbnNuIHN1ZmZpeGVzIGFuZCB1c2Ugcm13Y2Mu
aCBqdXN0IGxpa2Ugd2FzIChtb3JlIG9yIGxlc3MpDQo+ID4+ID4+IHJlY2VudGx5IGRvbmUgZm9y
IGJpdG9wcy5oIGFzIHdlbGwuDQo+ID4+ID4NCj4gPj4gPiBXaHk/IGJ0cyAoZXRjKSBvbiBtZW1v
cnkgZG9uJ3QgcmVhbGx5IGhhdmUgYW4gJ29wZXJhbmQgc2l6ZScuDQo+ID4+DQo+ID4+IE9mIGNv
dXJzZSB0aGV5IGRvIC0gZGVwZW5kaW5nIG9uIG9wZXJhbmQgc2l6ZSB0aGV5IG9wZXJhdGUgb24N
Cj4gPj4gMi0sIDQtLCBvciA4LWJ5dGUgcXVhbnRpdGllcy4gV2hlbiB0aGUgc2Vjb25kIG9wZXJh
bmQgaXMgYQ0KPiA+PiByZWdpc3RlciwgdGhlIHN1ZmZpeCBpcyByZWR1bmRhbnQgKGJ1dCBkb2Vz
bid0IGh1cnQpLCBidXQgd2hlbg0KPiA+PiB0aGUgc2Vjb25kIG9wZXJhbmQgaXMgYW4gaW1tZWRp
YXRlLCB0aGUgYXNzZW1ibGVyIChpbiBBVCZUDQo+ID4+IHN5bnRheCkgaGFzIG5vIHdheSBvZiBr
bm93aW5nIHdoYXQgb3BlcmFuZCBzaXplIHlvdSBtZWFuLg0KPiA+DQo+ID4gWW91IG5lZWQgdG8g
UlRGTS4NCj4gDQo+IEV4Y3VzZSBtZT8gSG93IGFib3V0IHlvdSBsb29rIGF0IHRoaXMgdGFibGUg
ZnJvbSB0aGUgU0RNDQo+IChmb3JtYXQgb2YgY291cnNlIGNvbWVzIG91dCBiZXR0ZXIgaW4gdGhl
IC5wZGYpOg0KPiANCj4gMEYgQUIgL3IgQlRTIHIvbTE2LCByMTYgTVIgVmFsaWQgVmFsaWQgU3Rv
cmUgc2VsZWN0ZWQgYml0IGluIENGIGZsYWcgYW5kIHNldC4NCj4gMEYgQUIgL3IgQlRTIHIvbTMy
LCByMzIgTVIgVmFsaWQgVmFsaWQgU3RvcmUgc2VsZWN0ZWQgYml0IGluIENGIGZsYWcgYW5kIHNl
dC4NCj4gUkVYLlcgKyAwRiBBQiAvciBCVFMgci9tNjQsIHI2NCBNUiBWYWxpZCBOLkUuIFN0b3Jl
IHNlbGVjdGVkIGJpdCBpbiBDRiBmbGFnIGFuZCBzZXQuDQo+IDBGIEJBIC81IGliIEJUUyByL20x
NiwgaW1tOCBNSSBWYWxpZCBWYWxpZCBTdG9yZSBzZWxlY3RlZCBiaXQgaW4gQ0YgZmxhZyBhbmQg
c2V0Lg0KPiAwRiBCQSAvNSBpYiBCVFMgci9tMzIsIGltbTggTUkgVmFsaWQgVmFsaWQgU3RvcmUg
c2VsZWN0ZWQgYml0IGluIENGIGZsYWcgYW5kIHNldC4NCj4gUkVYLlcgKyAwRiBCQSAvNSBpYiBC
VFMgci9tNjQsIGltbTggTUkgVmFsaWQgTi5FLiBTdG9yZSBzZWxlY3RlZCBiaXQgaW4gQ0YgZmxh
ZyBhbmQgc2V0Lg0KPiANCj4gUGxlYXNlIHJlYWQgbWFudWFscyB5b3Vyc2VsZiBiZWZvcmUgbWFr
aW5nIHN1Y2ggc3RhdGVtZW50cy4NCj4gDQo+ID4gUmVnYXJkbGVzcyBvZiB0aGUgJ29wZXJhbmQg
c2l6ZScgdGhlICdiaXQnIGluc3RydWN0aW9ucyBkbyBhIDMyIGJpdCBhbGlnbmVkDQo+ID4gMzIg
Yml0IHdpZGUgcmVhZC9tb2RpZnkvd3JpdGUgY3ljbGUuDQo+ID4NCj4gPiBUaGUgJ29wZXJhbmQg
c2l6ZScgZG9lcyBhZmZlY3Qgd2hldGhlciB0aGUgYml0IG51bWJlciAod2hpY2ggaXMgc2lnbmVk
KQ0KPiA+IGNvbWVzIGZyb20gJWNsICg4IGJpdHMpLCAlY3ggKDE2IGJpdHMpLCAlcmN4ICgzMiBi
aXRzKSBvciAoJWVjeCkgNjQgYml0cy4NCj4gPiBCdXQgdGhhdCBpcyBpbXBsaWNpdCBpbiB0aGUg
cmVnaXN0ZXIgbmFtZSB1c2VkLg0KPiANCj4gVGhlcmUgaXMgbm8gZm9ybSB3aXRoICVjbCBhcyBv
cGVyYW5kLiBJbnN0ZWFkIHRoZXJlIGFyZSBmb3JtcyB3aXRoDQo+IGFuIGltbWVkaWF0ZSBvcGVy
YW5kLg0KDQpTZWUgYWxzbyBzZWN0aW9uIDMuMS4xLjkgKGluIHRoZSBjb3B5IG9mIDMyNTQ2Mi5w
ZGYgSSBoYXZlKToNCihlZGl0ZWQgb3V0IHJlZmVyZW5jZXMgdG8gdGhlIGZpZ3VyZXMpDQoNCkJp
dChCaXRCYXNlLCBCaXRPZmZzZXQpIOKAlCBSZXR1cm5zIHRoZSB2YWx1ZSBvZiBhIGJpdCB3aXRo
aW4gYSBiaXQgc3RyaW5nLg0KICAgVGhlIGJpdCBzdHJpbmcgaXMgYSBzZXF1ZW5jZSBvZiBiaXRz
IGluIG1lbW9yeSBvciBhIHJlZ2lzdGVyLiBCaXRzIGFyZQ0KICAgbnVtYmVyZWQgZnJvbSBsb3ct
b3JkZXIgdG8gaGlnaC1vcmRlciB3aXRoaW4gcmVnaXN0ZXJzIGFuZCB3aXRoaW4gbWVtb3J5DQog
ICBieXRlcy4gSWYgdGhlIEJpdEJhc2UgaXMgYSByZWdpc3RlciwgdGhlIEJpdE9mZnNldCBjYW4g
YmUgaW4gdGhlIHJhbmdlIDANCiAgIHRvIFsxNSwgMzEsIDYzXSBkZXBlbmRpbmcgb24gdGhlIG1v
ZGUgYW5kIHJlZ2lzdGVyIHNpemUuDQoNCiAgIElmIEJpdEJhc2UgaXMgYSBtZW1vcnkgYWRkcmVz
cywgdGhlIEJpdE9mZnNldCBjYW4gcmFuZ2UgaGFzIGRpZmZlcmVudCByYW5nZXMNCiAgIGRlcGVu
ZGluZyBvbiB0aGUgb3BlcmFuZCBzaXplIChzZWUgVGFibGUgMy0yKS4NCg0KICAgVGhlIGFkZHJl
c3NlZCBiaXQgaXMgbnVtYmVyZWQgKE9mZnNldCBNT0QgOCkgd2l0aGluIHRoZSBieXRlIGF0IGFk
ZHJlc3MNCiAgIChCaXRCYXNlICsgKEJpdE9mZnNldCBESVYgOCkpIHdoZXJlIERJViBpcyBzaWdu
ZWQgZGl2aXNpb24gd2l0aCByb3VuZGluZw0KICAgdG93YXJkcyBuZWdhdGl2ZSBpbmZpbml0eSBh
bmQgTU9EIHJldHVybnMgYSBwb3NpdGl2ZSBudW1iZXIuDQoNClRhYmxlIDMtMi4gUmFuZ2Ugb2Yg
Qml0IFBvc2l0aW9ucyBTcGVjaWZpZWQgYnkgQml0IE9mZnNldCBPcGVyYW5kcw0KT3BlcmFuZCBT
aXplIEltbWVkaWF0ZSBCaXRPZmZzZXQgICBSZWdpc3RlciBCaXRPZmZzZXQNCiAgICAxNiAgICAg
ICAgICAgICAwIHRvIDE1ICAgICAgICAgMioqMTUgdG8gMioqMTUg4oiSIDENCiAgICAzMiAgICAg
ICAgICAgICAwIHRvIDMxICAgICAgICAgMioqMzEgdG8gMioqMzEg4oiSIDENCiAgICA2NCAgICAg
ICAgICAgICAwIHRvIDYzICAgICAgICAgMioqNjMgdG8gMioqNjMg4oiSIDENCg0KRm9yIEJpdCB0
ZXN0IGl0IHNheXM6DQoNCldoZW4gYWNjZXNzaW5nIGEgYml0IGluIG1lbW9yeSwgdGhlIHByb2Nl
c3NvciBtYXkgYWNjZXNzIDQgYnl0ZXMgc3RhcnRpbmcgZnJvbQ0KdGhlIG1lbW9yeSBhZGRyZXNz
IGZvciBhIDMyLWJpdCBvcGVyYW5kIHNpemUsIHVzaW5nIGJ5IHRoZSBmb2xsb3dpbmcgcmVsYXRp
b25zaGlwOg0KICAgIEVmZmVjdGl2ZSBBZGRyZXNzICsgKDQg4oiXIChCaXRPZmZzZXQgRElWIDMy
KSkNCk9yLCBpdCBtYXkgYWNjZXNzIDIgYnl0ZXMgc3RhcnRpbmcgZnJvbSB0aGUgbWVtb3J5IGFk
ZHJlc3MgZm9yIGEgMTYtYml0IG9wZXJhbmQsIHVzaW5nIHRoaXMgcmVsYXRpb25zaGlwOg0KICAg
IEVmZmVjdGl2ZSBBZGRyZXNzICsgKDIg4oiXIChCaXRPZmZzZXQgRElWIDE2KSkNCkl0IG1heSBk
byBzbyBldmVuIHdoZW4gb25seSBhIHNpbmdsZSBieXRlIG5lZWRzIHRvIGJlIGFjY2Vzc2VkIHRv
IHJlYWNoIHRoZSBnaXZlbiBiaXQuDQoNCihUaGF0IGlzIHRoZSB0ZXh0IEkgcmVtZW1iZXIgYmVp
bmcgaW4gdGhlIG9sZCBkb2NzLCBidXQgSSBkb24ndCB0aGluayBpdA0KdXNlZCB0byByZWZlciB0
byB0aGUgYWRkcmVzcyBiZWluZyBhbGlnbmVkLg0KTXkgODA4NiwgMjg2IGFuZCAzODYgYm9va3Mg
YXJlIGFsbCBhdCBob21lLikNCg0KVGhlIG90aGVyIGluc3RydWN0aW9ucyAoZWcgYnRjKSBzYXk6
DQoNCklmIHRoZSBiaXQgYmFzZSBvcGVyYW5kIHNwZWNpZmllcyBhIG1lbW9yeSBsb2NhdGlvbiwg
dGhlIG9wZXJhbmQgcmVwcmVzZW50cyB0aGUNCmFkZHJlc3Mgb2YgdGhlIGJ5dGUgaW4gbWVtb3J5
IHRoYXQgY29udGFpbnMgdGhlIGJpdCBiYXNlIChiaXQgMCBvZiB0aGUgc3BlY2lmaWVkIGJ5dGUp
DQpvZiB0aGUgYml0IHN0cmluZy4gVGhlIHJhbmdlIG9mIHRoZSBiaXQgcG9zaXRpb24gdGhhdCBj
YW4gYmUNCnJlZmVyZW5jZWQgYnkgdGhlIG9mZnNldCBvcGVyYW5kIGRlcGVuZHMgb24gdGhlIG9w
ZXJhbmQgc2l6ZS4NCg0KU28gdGhlICdvcGVyYW5kIHNpemUnIGdpdmVzIHRoZSBzaXplIG9mIHRo
ZSBiaXQgb2Zmc2V0LCBub3QgdGhlIHNpemUgb2YNCnRoZSBtZW1vcnkgY3ljbGUuDQoNCk1heWJl
IEknbGwgcnVuIHNvbWUgaW5zdHJ1Y3Rpb25zIGFnYWluc3QgYSBQQ0llIHNsYXZlIGFuZCBtb25p
dG9yIHRoZSBUTFBzLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRl
LCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpS
ZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

