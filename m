Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69362C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 365B0206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:27:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 365B0206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbeK2C3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 21:29:25 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:42674 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727726AbeK2C3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 21:29:25 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-139-yoTxg8ubPXm0pWNBZu6k_g-1; Wed, 28 Nov 2018 15:27:20 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed,
 28 Nov 2018 15:27:28 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 28 Nov 2018 15:27:28 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'H. Peter Anvin'" <hpa@zytor.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Jann Horn <jannh@google.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH] x86/fpu: XRSTOR is expected to raise #GP
Thread-Topic: [PATCH] x86/fpu: XRSTOR is expected to raise #GP
Thread-Index: AQHUhcFLw8vcflGVjkKDrYg9xvXgSaVlUhOQ
Date:   Wed, 28 Nov 2018 15:27:28 +0000
Message-ID: <52276fe27116406eb601a99704459f80@AcuMS.aculab.com>
References: <20181126172706.184008-1-jannh@google.com>
 <20181126174945.r2ubrlg2gzwog2ez@linutronix.de>
 <4d4c4f1f-72e3-0182-151e-8bd455ccd143@zytor.com>
In-Reply-To: <4d4c4f1f-72e3-0182-151e-8bd455ccd143@zytor.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: yoTxg8ubPXm0pWNBZu6k_g-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSC4gUGV0ZXIgQW52aW4NCj4gU2VudDogMjYgTm92ZW1iZXIgMjAxOCAxOTo1MA0KPiBP
biAxMS8yNi8xOCA5OjQ5IEFNLCBTZWJhc3RpYW4gQW5kcnplaiBTaWV3aW9yIHdyb3RlOg0KPiA+
IE9uIDIwMTgtMTEtMjYgMTg6Mjc6MDYgWyswMTAwXSwgSmFubiBIb3JuIHdyb3RlOg0KPiA+PiBj
b21taXQgNzUwNDVmNzdmN2E3ICgieDg2L2V4dGFibGU6IEludHJvZHVjZSBfQVNNX0VYVEFCTEVf
VUEgZm9yIHVhY2Nlc3MNCj4gPj4gZml4dXBzIikgaW5jb3JyZWN0bHkgcmVwbGFjZWQgdGhlIGZp
eHVwIGVudHJ5IGZvciBYU1RBVEVfT1Agd2l0aCBhDQo+ID4+IHVzZXItI1BGLW9ubHkgZml4dXAu
IEhvd2V2ZXIsIFhSU1RPUiBjYW4gYWxzbyByYWlzZSAjR1Agd2hlbiB0aGUgc3VwcGxpZWQNCj4g
Pj4gYWRkcmVzcyBwb2ludHMgdG8gdXNlcnNwYWNlIG1lbW9yeS4gQ2hhbmdlIGl0IGJhY2suDQo+
ID4NCj4gPiBUaGUgI0dQIGlzIHJhaXNlZCBpZiB0aGUgeHN0YXRlIGNvbnRlbnQgaXMgaW52YWxp
ZC4gQnV0IEkgZ3Vlc3MgdGhlDQo+ID4gZGV0YWlscyBkb24ndCBtYXR0ZXIuDQo+ID4NCj4gPj4g
UmVwb3J0ZWQtYnk6IFNlYmFzdGlhbiBBbmRyemVqIFNpZXdpb3IgPGJpZ2Vhc3lAbGludXRyb25p
eC5kZT4NCj4gPj4gRml4ZXM6IDc1MDQ1Zjc3ZjdhNyAoIng4Ni9leHRhYmxlOiBJbnRyb2R1Y2Ug
X0FTTV9FWFRBQkxFX1VBIGZvciB1YWNjZXNzIGZpeHVwcyIpDQo+ID4+IFNpZ25lZC1vZmYtYnk6
IEphbm4gSG9ybiA8amFubmhAZ29vZ2xlLmNvbT4NCj4gPiBBY2tlZC1ieTogU2ViYXN0aWFuIEFu
ZHJ6ZWogU2lld2lvciA8YmlnZWFzeUBsaW51dHJvbml4LmRlPg0KPiA+DQo+IA0KPiBJdCBkb2Vz
IG1hdHRlciAtLSBwbGVhc2UgY29ycmVjdCB0aGUgcGF0Y2ggZGVzY3JpcHRpb24sIG9yIHdlIG1p
Z2h0IGhhdmUgc29tZQ0KPiBzZXJpb3VzIGNvbmZ1c2lvbiBhdCBzb21lIGFyYml0cmFyeSBwb2lu
dCBpbiB0aGUgZnV0dXJlIHdpdGggdGhlIHJlc3VsdCB0aGF0DQo+IHRoZSBidWcgZ2V0cyByZS1p
bnRyb2R1Y2VkOyBpdCB3b3VsZCBub3QgYmUgdGhlIGZpcnN0IHRpbWUuDQoNCkJldHRlciBzdGls
bCBub3RlIGl0IGluIHRoZSBjb2RlLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNz
IExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAx
UFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

