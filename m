Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336CAC282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 107EF20821
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730887AbfBLR36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:29:58 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:50629 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728066AbfBLR36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:29:58 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-146-17SHnOWmMGu9jXGImVZ0OQ-1; Tue, 12 Feb 2019 17:29:55 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 12 Feb 2019 17:30:38 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 12 Feb 2019 17:30:38 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Vineet Gupta' <vineet.gupta1@synopsys.com>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] ARC: Explicitly set ARCH_SLAB_MINALIGN = 8
Thread-Topic: [PATCH] ARC: Explicitly set ARCH_SLAB_MINALIGN = 8
Thread-Index: AQHUwvc8KjF6Xlwy10OvbYFx5kwo16XcaZhg
Date:   Tue, 12 Feb 2019 17:30:38 +0000
Message-ID: <f83412d1e7fd4d67b4632c1f81fae963@AcuMS.aculab.com>
References: <20190208105519.26750-1-abrodkin@synopsys.com>
 <81017fe4-b31f-4942-e822-a7b70008b74d@synopsys.com>
In-Reply-To: <81017fe4-b31f-4942-e822-a7b70008b74d@synopsys.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: 17SHnOWmMGu9jXGImVZ0OQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogIFZpbmVldCBHdXB0YQ0KPiBTZW50OiAxMiBGZWJydWFyeSAyMDE5IDE3OjE3DQo+IA0K
PiBPbiAyLzgvMTkgMjo1NSBBTSwgQWxleGV5IEJyb2RraW4gd3JvdGU6DQo+ID4gQnkgZGVmYXVs
dCBBUkNIX1NMQUJfTUlOQUxJR04gaXMgZGVmaW5lZCBpbiAiaW5jbHVkZS9saW51eC9zbGFiLmgi
IGFzDQo+ID4gIl9fYWxpZ25vZl9fKHVuc2lnbmVkIGxvbmcgbG9uZykiIHdoaWNoIGxvb2tzIGZp
bmUgYnV0IG5vdCBmb3IgQVJDLg0KPiANCj4gSnVzdCBmb3IgdGhlIHJlY29yZCwgdGhlIGlzc3Vl
IGhhcHBlbnMgYmVjYXVzZSBhIExMT0NLRCAoZXhjbHVzaXZlIDY0LWJpdCBsb2FkKQ0KPiB3YXMg
dHJ5aW5nIHRvIHVzZSBhIDMyLWJpdCBhbGlnbmVkIGVmZmVjdGl2ZSBhZGRyZXNzIChmb3IgYXRv
bWljNjRfdCksIG5vdCBhbGxvd2VkDQo+IGJ5IElTQSAoTExPQ0tEIGNhbiBvbmx5IHRha2UgNjQt
Yml0IGFsaWduZWQgYWRkcmVzcywgZXZlbiB3aGVuIHRoZSBDUFUgaGFzDQo+IHVuYWxpZ25lZCBh
Y2Nlc3MgZW5hYmxlZCkuDQo+IA0KPiBUaGlzIGluIHR1cm4gd2FzIGhhcHBlbmluZyBiZWNhdXNl
IHRoaXMgd29yZCBpcyBlbWJlZGRlZCBpbiBzb21lIG90aGVyIHN0cnVjdCBhbmQNCj4gaGFwcGVu
cyB0byBiZSA0IGJ5dGUgYWxpZ25lZA0KPiANCj4gDQo+ID4gQVJDIHRvb2xzIEFCSSBzZXRzIGFs
aWduIG9mICJsb25nIGxvbmciIHRoZSBzYW1lIGFzIGZvciAibG9uZyIgPSA0DQo+ID4gaW5zdGVh
ZCBvZiA4IG9uZSBtYXkgdGhpbmsgb2YuDQoNClJpZ2h0LCBidXQgX19hbGlnbm9mX18oKSBkb2Vz
bid0IGhhdmUgdG8gcmV0dXJuIHRoZSBhbGlnbm1lbnQgdGhhdCB3b3VsZA0KYmUgdXNlZCBmb3Ig
YSBkYXRhIGl0ZW0gb2YgdGhlIHNwZWNpZmllZCB0eXBlLg0KKFJlYWQgdGhlIGdjYyAnYnVnJyBp
bmZvIGZvciBnb3J5IGRldGFpbHMuKQ0KDQpPbiBpMzg2IF9fYWxpZ25vZl9fKGxvbmcgbG9uZykg
aXMgOCwgYnV0IHN0cnVjdHVyZSBtZW1iZXJzIG9mIHR5cGUgJ2xvbmcgbG9uZycNCmFyZSA0IGJ5
dGUgYWxpZ25lZCBhbmQgdGhlIGFsaWdubWVudCBvZiBhIHN0cnVjdHVyZSB3aXRoIGEgJ2xvbmcg
bG9uZycgbWVtYmVyDQppcyBvbmx5IDQuDQooQWx0aG91Z2ggdGhlIG1pY3Jvc29mdCBjb21waWxl
ciByZXR1cm5zIDQuKQ0KDQo+IFJpZ2h0LCB0aGlzIHdhcyBpbmRlZWQgdW5leHBlY3RlZCBhbmQg
bm90IGxpa2UgbW9zdCBvdGhlciBhcmNoZXMuIEFSQ3YyIElTQSBhbGxvd3MNCj4gcmVndWxhciA2
NC1iaXQgbG9hZHMvc3RvcmVzIChMREQvU1REKSB0byB0YWtlIDMyLWJpdCBhbGlnbmVkIGFkZHJl
c3Nlcy4gVGh1cyBBQkkNCj4gcmVsYXhpbmcgdGhlIGFsaWdubWVudCBmb3IgNjQtYml0IGRhdGEg
cG90ZW50aWFsbHkgY2F1c2VzIG1vcmUgcGFja2luZyBhbmQgbGVzcw0KPiBzcGFjZSB3YXN0ZS4g
QnV0IG9uIHRoZSBmbGlwIHNpZGUgd2UgbmVlZCB0byB3YXN0ZSBzcGFjZSBhdCBhcmJpdHJhcnkg
cGxhY2VzIGxpZWsNCj4gdGhpcy4NCj4gDQo+IFNvIHRoaXMgaXMgYWxsIGdvb2QgYW5kIHRoZW9y
eSwgYnV0IEknbSBub3QgMTAwJSBzdXJlIGhvdyBzbGFiIGFsaWdubWVudCBoZWxwcw0KPiBoZXJl
IChhbmQgaXMgZnV0dXJlIHByb29mKS4gU28gdGhlIG91dGVyIHN0cnVjdCB3aXRoIGVtYmVkZGVk
IGF0b21pYzY0X3Qgd2FzDQo+IGFsbG9jYXRlZCB2aWEgc2xhYiBhbmQgeW91ciBwYXRjaCBlbnN1
cmVzIHRoYXQgb3V0ZXIgc3RydWN0IGlzIDY0LWJpdCBhbGlnbmVkID8NCg0KUHJlc3VtYWJsZSAn
YXRvbWljNjRfdCcgaGFzIGFuIGFsaWdubWVudCBhdHRyaWJ1dGUgdG8gZm9yY2UgOCBieXRlIGFs
aWdubWVudC4NCg0KPiBCdXQgaG93IGRvZXMgdGhhdCBndWFyYW50ZWUgdGhhdCBhbGwgZW1iZWRk
ZWQgYXRvbWljNjRfdCBpbiB0aGVyZSB3aWxsIGJlIDY0LWJpdA0KPiBhbGlnbmVkIChpbiBmdXR1
cmUgc2F5KSBpbiB0aGUgbGlnaHQgb2YgQVJDIEFCSSBhbmQgdGhlIGdjYyBidWcvZmVhdHVyZSB3
aGljaA0KPiBQZXRlciBhbGx1ZGVkIHRvDQo+IA0KPiAgICBodHRwczovL2djYy5nbnUub3JnL2J1
Z3ppbGxhL3Nob3dfYnVnLmNnaT9pZD01NDE4OA0KPiAgICBodHRwczovL2djYy5nbnUub3JnL2J1
Z3ppbGxhL3Nob3dfYnVnLmNnaT9pZD0xMDM2MA0KPiANCj4gPiBUaHVzIHNsYWIgYWxsb2NhdG9y
IG1heSBlYXNpbHkgYWxsb2NhdGUgYSBidWZmZXIgd2hpY2ggaXMgMzItYml0IGFsaWduZWQuDQo+
ID4gQW5kIG1vc3Qgb2YgdGhlIHRpbWUgaXQncyBPSyB1bnRpbCB3ZSBzdGFydCBkZWFsaW5nIHdp
dGggNjQtYml0IGF0b21pY3MNCj4gPiB3aXRoIHNwZWNpYWwgTExPQ0tEL1NDT05ERCBpbnN0cnVj
dGlvbnMgd2hpY2ggKGFzIG9wcG9zZWQgdG8gdGhlaXIgMzItYml0DQo+ID4gY291bnRlcnBhcnRz
IExMT0NLL1NDT05EKSBvcGVyYXRlIHdpdGggZnVsbCA2NC1iaXQgd29yZHMgYnV0IHRob3NlIHdv
cmRzDQo+ID4gbXVzdCBiZSA2NC1iaXQgYWxpZ25lZC4NCj4gDQo+IFNvbWUgb2YgdGhpcyB0ZXh0
IG5lZWRlZCB0byBnbyBhYm92ZSB0byBnaXZlIG1vcmUgY29udGV4dC4NCg0KSSBzdXNwZWN0IHRo
ZSBzbGFiIGFsbG9jYXRvciBzaG91bGQgYmUgcmV0dXJuaW5nIDggYnl0ZSBhbGlnbmVkIGFkZHJl
c3Nlcw0Kb24gYWxsIHN5c3RlbXMuLi4uDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJl
c3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsx
IDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

