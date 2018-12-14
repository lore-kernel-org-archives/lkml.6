Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0897AC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B687820675
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729967AbeLNNjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 08:39:24 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:32232 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728881AbeLNNjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 08:39:22 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id uk-mta-4-5MAOICzyOhqJ1pr0r7imnw-1;
 Fri, 14 Dec 2018 13:39:18 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri,
 14 Dec 2018 13:39:30 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 14 Dec 2018 13:39:30 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Borislav Petkov' <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>
CC:     Tom Lendacky <Thomas.Lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>
Subject: RE: [RFC PATCH 4/4] x86/TSC: Use RDTSCP
Thread-Topic: [RFC PATCH 4/4] x86/TSC: Use RDTSCP
Thread-Index: AQHUkkrWNSwtnyiO9kCe7sX2n/ihoKV+PuKQ
Date:   Fri, 14 Dec 2018 13:39:30 +0000
Message-ID: <d7d04973d6d54a969c9324ab3240b401@AcuMS.aculab.com>
References: <20181211222326.14581-1-bp@alien8.de>
 <20181211222326.14581-5-bp@alien8.de>
 <CALCETrVArfAAbQKJ-g_5pOy6dMVgx-FC_mjdC9xzL1jU9T07jw@mail.gmail.com>
 <59aad362-4a5b-dd8b-642f-0dc3f83cf7ee@amd.com>
 <20181211233901.GV27375@zn.tnic>
 <CALCETrXvZ4avdUh2bTLVTTz3Jxogo3zK5akWTsJ=rkJpf1XiDg@mail.gmail.com>
 <20181212100814.GB6653@zn.tnic>
 <CALCETrWSG5825HrxwEJGqbSoRz=A_2O-GSBD+K_q9YPHu2TB6A@mail.gmail.com>
 <20181212184459.GE6653@zn.tnic>
In-Reply-To: <20181212184459.GE6653@zn.tnic>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: 5MAOICzyOhqJ1pr0r7imnw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogIEJvcmlzbGF2IFBldGtvdg0KPiBTZW50OiAxMiBEZWNlbWJlciAyMDE4IDE4OjQ1DQou
Li4NCj4gPiBUaGUgcHJvcGVydHkgSSB3YW50IGZvciBSRFRTQyBvcmRlcmluZyBpcyBtdWNoIHdl
YWtlcjogSSB3YW50IGl0IHRvIGJlDQo+ID4gb3JkZXJlZCBsaWtlIGEgbG9hZC4gIEltYWdpbmUg
dGhhdCwgaW5zdGVhZCBvZiBhbiBvbi1jaGlwIFRTQywgdGhlIFRTQw0KPiA+IGlzIGxpdGVyYWxs
eSBhIGxvY2F0aW9uIGluIG1haW4gbWVtb3J5IHRoYXQgZ2V0cyBpbmNyZW1lbnRlZCBieSBhbg0K
PiA+IGV4dHJhIGRlZGljYXRlZCBDUFUgZXZlcnkgbmFub3NlY29uZCBvciBzby4gIEkgd2FudCB1
c2VycyBvZiBSRFRTQyB0bw0KPiA+IHdvcmsgYXMgaWYgdGhleSB3ZXJlIHJlYWRpbmcgc3VjaCBh
IGxvY2F0aW9uIGluIG1lbW9yeSB1c2luZyBhbg0KPiA+IG9yZGluYXJ5IGxvYWQuICBJIGJlbGll
dmUgdGhpcyBnaXZlcyB0aGUgcmVhbCBkZXNpcmVkIHByb3BlcnR5IHRoYXQgaXQNCj4gPiBzaG91
bGQgYmUgaW1wb3NzaWJsZSB0byBvYnNlcnZlIHRoZSBUU0MgZ29pbmcgYmFja3dhcmRzLiAgVGhp
cyBpcyBhDQo+ID4gbXVjaCB3ZWFrZXIgZm9ybSBvZiBzZXJpYWxpemF0aW9uLg0KPiANCj4gV2Vs
bCwgaW4gdGhhdCBjYXNlIHlvdSBuZWVkIHNvbWV0aGluZyBuZXcuDQo+IA0KPiBCZWNhdXNlLCB0
aGUgbW9tZW50IHlvdSBoYXZlIGEgUkRUU0MgaW4gZmxpZ2h0IGFuZCBhIHNlY29uZCBSRFRTQyBj
b21lcw0KPiBpbiBhbmQgdGhhdCBzZWNvbmQgUkRUU0MgbXVzdCAqbm90KiBieXBhc3MgdGhlIGZp
cnN0IG9uZSBhbmQgZXhlY3V0ZQ0KPiBlYXJsaWVyIGR1ZSB0byBPb08sIHlvdSBuZWVkIHRvIGlt
cG9zZSBzb21lIG9yZGVyaW5nLiBBbmQgdGhhdCdzIHByZXR0eQ0KPiBtdWNoIHVhcmNoLWRlcGVu
ZGVudCwgSSdkIHNheS4NCj4gDQo+IEFuZCBJIGd1ZXNzIG9uIEFNRCB0aGUgd2F5IHRvIGRvIHRo
YXQgaXMgdG8gc3RvcCBkaXNwYXRjaCB1bnRpbCB0aGUNCj4gZmlyc3QgUkRUU0MgcmV0aXJlcy4N
Cj4gDQo+IENhbiBpdCBiZSBkb25lIGZhc3Rlcj8gU3VyZS4gQW5kIEknbSBwcmV0dHkgc3VyZSB0
aGVyZSdzIGEgbG90IG9mIHBlc2t5DQo+IGxpdHRsZSBodyBkZXRhaWxzIHdlJ3JlIG5vdCBldmVu
IGhlYXJpbmcgb2YsIHdoaWNoIGdldCBpbiB0aGUgd2F5Lg0KDQpJU1RSIG9uZSBvZiB0aGUgcHJv
YmxlbXMgd2l0aCBSRFRTQyBzZXJpYWxpc2luZyBpcyB0aGF0IGl0IGlzIHVzZWQNCmZvciBtaWNy
by1iZW5jaG1hcmtzLg0KU28geW91IHdhbnQgdG8gdGltZSBhbGwgdGhlIGluc3RydWN0aW9ucyBi
ZXR3ZWVuIGEgcGFpciBvZiBSRFRTQy4NClRoaXMgZG9lc24ndCB3b3JrIHdlbGwgaWYgUkRUU0Mg
ZG9lc24ndCB3YWl0IGZvciBhbGwgaW5zdHJ1Y3Rpb25zDQp0byBoYXZlIGV4ZWN1dGVkLg0KVGhl
IHNlcmlhbGlzYXRpb24gcmVxdWlyZW1lbnRzIGZvciBzcGVjdHJlIG1pdGlnYXRpb24gYXJlIGRp
ZmZlcmVudC4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJh
bWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0
cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

