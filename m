Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB921C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93707224E0
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:56:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93707224E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387897AbeKNAyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 19:54:55 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:43731 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728718AbeKNAyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 19:54:55 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by dkim.mimecast.com with ESMTP id uk-mta-56-9XoIgnlFNqi7TxvZ2EK5IA-1;
 Tue, 13 Nov 2018 14:56:21 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 13 Nov 2018 14:56:27 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 13 Nov 2018 14:56:27 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Li, Aubrey'" <aubrey.li@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Aubrey Li <aubrey.li@intel.com>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH v2 1/2] x86/fpu: detect AVX task
Thread-Topic: [RFC PATCH v2 1/2] x86/fpu: detect AVX task
Thread-Index: AQHUeii707Eilrmaj0KnTIFQLJW0yKVNgTLwgAAt84CAAB0EEA==
Date:   Tue, 13 Nov 2018 14:56:27 +0000
Message-ID: <8adbc254854244b383147b4a25353cb7@AcuMS.aculab.com>
References: <1541610982-33478-1-git-send-email-aubrey.li@intel.com>
 <alpine.DEB.2.21.1811091121340.1519@nanos.tec.linutronix.de>
 <657a9ee9-bb27-968a-34ae-e25df6c2fff9@linux.intel.com>
 <25dd33ee964f4de5ae33a1575e1bf47f@AcuMS.aculab.com>
 <2229f120-cb11-8f8e-f27d-eabc94457cd5@linux.intel.com>
In-Reply-To: <2229f120-cb11-8f8e-f27d-eabc94457cd5@linux.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: 9XoIgnlFNqi7TxvZ2EK5IA-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGksIEF1YnJleQ0KPiBTZW50OiAxMyBOb3ZlbWJlciAyMDE4IDEzOjA3DQouLi4NCj4g
PiBJc24ndCB0aGVyZSBhbiBvYnZpb3VzIG9wdGltaXNhdGlvbiB0byBleGVjdXRlIFZaRVJPQUxM
IGR1cmluZyBzeXN0ZW0gY2FsbA0KPiA+IGVudHJ5Pw0KPiANCj4gSSdtIG5vdCBhd2FyZSBvZiB0
aGlzIGluIHRoZSBrZXJuZWwsIG1heWJlIHlvdSBhcmUgdGFsa2luZyBhYm91dCBzb21lDQo+IG9w
dGltaXphdGlvbiBpbiBnbGliYz8NCg0KSSd2ZSBub3Qgc2VlbiBpdCBhbnl3aGVyZSBlaXRoZXIu
DQoNCklJUkMgYWxsIHRoZSB4bW0gYW5kIHltbSByZWdpc3RlcnMgYXJlICdjYWxsZXIgc2F2ZWQn
Lg0KU2luY2Ugc3lzdGVtIGNhbGxzIGFsbCBsb29rIGxpa2UgZnVuY3Rpb24gY2FsbHMgdGhlIGNv
bXBpbGVyDQpoYXMgdG8gYXNzdW1lIHRoYXQgdGhlIHJlZ2lzdGVycyBjYW4gYmUgbW9kaWZpZWQu
DQpUaGlzIG1lYW5zIHRoYXQgaXQgaXMgc2FmZSBmb3IgdGhlIHN5c3RlbSBjYWxsIGNvZGUgdG8g
Y2hhbmdlIHRoZW0uDQpJdCBtdXN0bid0IGxlYWsga2VybmVsIHZhbHVlcyBvdXQgdG8gdXNlcnNw
YWNlLCBidXQgaXQgY2FuIHplcm8gdGhlbS4NCg0KU28gYWRkaW5nIFZaRVJPQUxMIG9uIHN5c3Rl
bSBjYWxsIGVudHJ5IHdvdWxkIHNhdmUgdGhlIEZQIHNhdmUgY29kZSBoYXZpbmcNCnRvIHNhdmUg
YW5kIHJlc3RvcmUgYW55IG9mIHRoZSB4bW0veW1tIHJlZ2lzdGVycy4NCklJUkMgdGhlIGhhcmR3
YXJlIGp1c3Qgc2F2ZXMgYSBmbGFnIGluZGljYXRpbmcgdGhhdCB0aGV5IGFyZSBhbGwgemVyby4N
Cg0KQWxsIHRoZSByZWdpc3RlcnMgZG8gbmVlZCBzYXZpbmcgaWYgdGhlIGtlcm5lbCBpcyBlbnRl
cmVkIGJ5IGFuDQppbnRlcnJ1cHQgb3IgZmF1bHQuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVk
IEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5l
cywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

