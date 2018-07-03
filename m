Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4ACC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 515C92083E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:28:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 515C92083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754762AbeGCK2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 06:28:12 -0400
Received: from smtp-out4.electric.net ([192.162.216.187]:58657 "EHLO
        smtp-out4.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754665AbeGCK2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 06:28:10 -0400
Received: from 1faIXM-00029Z-Vs by out4c.electric.net with emc1-ok (Exim 4.90_1)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1faIXW-00034N-VS; Tue, 03 Jul 2018 03:28:06 -0700
Received: by emcmailer; Tue, 03 Jul 2018 03:28:06 -0700
Received: from [156.67.243.126] (helo=AcuMS.aculab.com)
        by out4c.electric.net with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1faIXM-00029Z-Vs; Tue, 03 Jul 2018 03:27:56 -0700
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue,
 3 Jul 2018 11:29:36 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 3 Jul 2018 11:29:36 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jan Beulich' <JBeulich@suse.com>
CC:     Borislav Petkov <bp@alien8.de>,
        "brgerst@gmail.com" <brgerst@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>
Subject: RE: [tip:x86/asm] x86/entry/64: Add two more instruction suffixes
Thread-Topic: [tip:x86/asm] x86/entry/64: Add two more instruction suffixes
Thread-Index: AQHUEqkqUgcuA0q28EukrINgYR6YAqR9LYhQgAAHfQCAABRHwA==
Date:   Tue, 3 Jul 2018 10:29:36 +0000
Message-ID: <b244577958e34a6f9063a37826f660ec@AcuMS.aculab.com>
References: <5B3A02DD02000078001CFB78@prv1-mh.provo.novell.com>
 <tip-6709812f094d96543b443645c68daaa32d3d3e77@git.kernel.org>
 <dd366701851f48e4897ebe0f62f0fd94@AcuMS.aculab.com>
 <5B3B4AB802000078001D0216@prv1-mh.provo.novell.com>
In-Reply-To: <5B3B4AB802000078001D0216@prv1-mh.provo.novell.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Outbound-IP: 156.67.243.126
X-Env-From: David.Laight@ACULAB.COM
X-Proto: esmtps
X-Revdns: 
X-HELO: AcuMS.aculab.com
X-TLS:  TLSv1.2:ECDHE-RSA-AES256-SHA384:256
X-Authenticated_ID: 
X-PolicySMART: 3396946, 3397078
X-Virus-Status: Scanned by VirusSMART (c)
X-Virus-Status: Scanned by VirusSMART (s)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSmFuIEJldWxpY2gNCj4gU2VudDogMDMgSnVseSAyMDE4IDExOjA3DQo+ID4+PiBPbiAw
My4wNy4xOCBhdCAxMDo0NiwgPERhdmlkLkxhaWdodEBBQ1VMQUIuQ09NPiB3cm90ZToNCj4gPiBG
cm9tOiBKYW4gQmV1bGljaA0KPiA+PiBTZW50OiAwMyBKdWx5IDIwMTggMDk6MzYNCj4gPiAuLi4N
Cj4gPj4gQXMgc2FpZCB0aGVyZSwgb21pdHRpbmcgc3VmZml4ZXMgZnJvbSBpbnN0cnVjdGlvbnMg
aW4gQVQmVCBtb2RlIGlzIGJhZA0KPiA+PiBwcmFjdGljZSB3aGVuIG9wZXJhbmQgc2l6ZSBjYW5u
b3QgYmUgZGV0ZXJtaW5lZCBieSB0aGUgYXNzZW1ibGVyIGZyb20NCj4gPj4gcmVnaXN0ZXIgb3Bl
cmFuZHMsIGFuZCBpcyBsaWtlbHkgZ29pbmcgdG8gYmUgd2FybmVkIGFib3V0IGJ5IHVwc3RyZWFt
DQo+ID4+IGdhcyBpbiB0aGUgZnV0dXJlIChtaW5lIGRvZXMgYWxyZWFkeSkuDQo+ID4gLi4uDQo+
ID4+IC0JYnQJJDksIEVGTEFHUyglcnNwKQkJLyogaW50ZXJydXB0cyBvZmY/ICovDQo+ID4+ICsJ
YnRsCSQ5LCBFRkxBR1MoJXJzcCkJCS8qIGludGVycnVwdHMgb2ZmPyAqLw0KPiA+DQo+ID4gSG1t
bS4uLi4NCj4gPiBEb2VzIHRoZSBvcGVyYW5kIHNpemUgbWFrZSBhbnkgZGlmZmVyZW5jZSBhdCBh
bGwgZm9yIHRoZSBiaXQgaW5zdHJ1Y3Rpb25zPw0KPiA+IEknbSBwcmV0dHkgc3VyZSB0aGF0IHRo
ZSBjcHVzICgzODYgb253YXJkcykgaGF2ZSBhbHdheXMgZG9uZSBhbGlnbmVkIDMyYml0DQo+ID4g
dHJhbnNmZXJzICh0aGUgZG9jcyBuZXZlciBhY3R1YWxseSBzYWlkIGFsaWduZWQpLg0KPiA+IEkg
Y2FuJ3QgcmVtZW1iZXIgd2hldGhlciA2NGJpdCBtb2RlIGFsbG93cyBpbW1lZGlhdGVzIGFib3Zl
IDMxLg0KPiA+DQo+ID4gU28gZ2FzIGFjY2VwdGluZyAnYnRiICRuLG1lbW9yeScgaXMgZ2l2aW5n
IGEgZmFsc2UgaW1wcmVzc2lvbiBvZg0KPiA+IHdoYXQgYWN0dWFsbHkgaGFwcGVucy4NCj4gDQo+
IEJUQiBkb2VzIG5vdCBleGlzdCBhdCBhbGwuIEJUVyBhbmQgKG9uIDY0LWJpdCkgQlRRIGRvIGV4
aXN0IHRob3VnaCwNCj4gYW5kIHRoZXkgaGF2ZSBiZWhhdmlvciBkaWZmZXJpbmcgZnJvbSBCVEwu
IFRoZSBvbmx5IEFUJlQgc3ludGF4IGRvYw0KPiBJIGhhdmUgc2F5cyB0aGF0IEwgaXMgdGhlIGRl
ZmF1bHQgc3VmZml4IHRvIGJlIHVzZWQsIGJ1dCB0aGVyZSBhcmUgY2FzZXMNCj4gd2hlcmUgdGhp
cyB3YXNuJ3QgKGFuZCBtYXliZSBzdGlsbCBpc24ndCkgdGhlIGNhc2UsIHNvIG9taXR0aW5nIGEg
c3VmZml4DQo+IHdoZW4gcmVnaXN0ZXIgb3BlcmFuZHMgYXJlbid0IGF2YWlsYWJsZSB0byBzaXpl
IGluc3RydWN0aW9ucyBoYXMgYWx3YXlzDQo+IGJlZW4gYSByaXNreSBnYW1lLg0KDQpJJ3ZlIGp1
c3QgbG9va2VkIGl0IHVwIDotKQ0KVGhlcmUgYXJlIG9ubHkgMTZiaXQsIDMyYml0IGFuZCA2NGJp
dCB2YXJpYW50cy4NClRoZXkgbW9zdGx5IGFmZmVjdCBob3cgbXVjaCBvZiAlY3ggaXMgdXNlZCBm
b3IgdGhlIGJpdCBvZmZzZXQuDQpXaXRoIHRoZSBhZGRpdGlvbiAnbWF5JyBjbGF1c2VzIGJlbG93
IC0gd2hpY2ggYXJlIG1vcmUgZXhwbGljaXQNCnRoYW4gdGhleSB1c2VkIHRvIGJlLg0KDQoiV2hl
biBhY2Nlc3NpbmcgYSBiaXQgaW4gbWVtb3J5LCB0aGUgcHJvY2Vzc29yIG1heSBhY2Nlc3MgNCBi
eXRlcyBzdGFydGluZw0KZnJvbSB0aGUgbWVtb3J5IGFkZHJlc3MgZm9yIGEgMzItYml0IG9wZXJh
bmQgc2l6ZSwgdXNpbmcgYnkgdGhlIGZvbGxvd2luZw0KcmVsYXRpb25zaGlwOg0KICAgIEVmZmVj
dGl2ZSBBZGRyZXNzICsgKDQgKiAoQml0T2Zmc2V0IERJViAzMikpDQoNCk9yLCBpdCBtYXkgYWNj
ZXNzIDIgYnl0ZXMgc3RhcnRpbmcgZnJvbSB0aGUgbWVtb3J5IGFkZHJlc3MgZm9yIGEgMTYtYml0
DQpvcGVyYW5kLCB1c2luZyB0aGlzIHJlbGF0aW9uc2hpcDoNCiAgICBFZmZlY3RpdmUgQWRkcmVz
cyArICgyICogKEJpdE9mZnNldCBESVYgMTYpKQ0KDQpJdCBtYXkgZG8gc28gZXZlbiB3aGVuIG9u
bHkgYSBzaW5nbGUgYnl0ZSBuZWVkcyB0byBiZSBhY2Nlc3NlZCB0byByZWFjaA0KdGhlIGdpdmVu
IGJpdC4gV2hlbiB1c2luZyB0aGlzIGJpdCBhZGRyZXNzaW5nIG1lY2hhbmlzbSwgc29mdHdhcmUg
c2hvdWxkDQphdm9pZCByZWZlcmVuY2luZyBhcmVhcyBvZiBtZW1vcnkgY2xvc2UgdG8gYWRkcmVz
cyBzcGFjZSBob2xlcy4iDQooQSBzdHJhbmdlIHF1YWxpZnlpbmcgY2xhdXNlLikNCg0KCURhdmlk
DQoNCg==
