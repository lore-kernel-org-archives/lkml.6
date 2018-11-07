Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33679C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 11:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F11112081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 11:01:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F11112081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbeKGUaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 15:30:55 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:49249 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726225AbeKGUaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 15:30:55 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by dkim.mimecast.com with ESMTP id
 uk-mta-131-IpHlzqaHPDyDiGJ-u5fDwg-1; Wed, 07 Nov 2018 11:01:01 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed,
 7 Nov 2018 11:01:05 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 7 Nov 2018 11:01:05 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Tetsuo Handa' <penguin-kernel@i-love.sakura.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
CC:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Subject: RE: [PATCH v6 1/3] printk: Add line-buffered printk() API.
Thread-Topic: [PATCH v6 1/3] printk: Add line-buffered printk() API.
Thread-Index: AQHUdogRgDaMOD8K702OSi1cCtNLCaVEI+qQ
Date:   Wed, 7 Nov 2018 11:01:05 +0000
Message-ID: <8354d714f6b6489d9003d6e04ee10618@AcuMS.aculab.com>
References: <1541165517-3557-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20181106143502.GA32748@tigerII.localdomain>
 <42f33aae-a1d1-197f-a1d5-8c5ec88e88d1@i-love.sakura.ne.jp>
In-Reply-To: <42f33aae-a1d1-197f-a1d5-8c5ec88e88d1@i-love.sakura.ne.jp>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: IpHlzqaHPDyDiGJ-u5fDwg-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogVGV0c3VvIEhhbmRhDQo+IFNlbnQ6IDA3IE5vdmVtYmVyIDIwMTggMTA6NTMNCj4gDQo+
IE9uIDIwMTgvMTEvMDYgMjM6MzUsIFNlcmdleSBTZW5vemhhdHNreSB3cm90ZToNCj4gPj4gU2lu
Y2Ugd2Ugd2FudCB0byByZW1vdmUgInN0cnVjdCBjb250IiBldmVudHVhbGx5LCB3ZSB3aWxsIHRy
eSB0byByZW1vdmUNCj4gPj4gYm90aCAiaW1wbGljaXQgcHJpbnRrKCkgdXNlcnMgd2hvIGFyZSBl
eHBlY3RpbmcgS0VSTl9DT05UIGJlaGF2aW9yIiBhbmQNCj4gPj4gImV4cGxpY2l0IHByX2NvbnQo
KS9wcmludGsoS0VSTl9DT05UKSB1c2VycyIuIFRoZXJlZm9yZSwgY29udmVydGluZyB0bw0KPiA+
PiB0aGlzIEFQSSBpcyByZWNvbW1lbmRlZC4NCj4gPg0KPiA+IC0gVGhlIHByaW50ay1mYWxsYmFj
ayBzb3VuZHMgbGlrZSBhIGhpbnQgdGhhdCB0aGUgZXhpc3RpbmcgJ2NvbnQnIGhhbmRsaW5nDQo+
ID4gICBiZXR0ZXIgc3RheSBpbiB0aGUga2VybmVsLiBJIGRvbid0IHNlZSBob3cgdGhlIGV4aXN0
aW5nICdjb250JyBpcw0KPiA+ICAgc2lnbmlmaWNhbnRseSB3b3JzZSB0aGFuDQo+ID4gCQlicHJf
d2FybihOVUxMLCAuLi4pLT5wcmludGsoKSAvLyBubyAnY29udCcgc3VwcG9ydA0KPiA+ICAgSSBk
b24ndCBzZWUgd2h5IHdvdWxkIHdlIHdhbnQgdG8gZG8gaXQsIHNvcnJ5LiBJIGRvbid0IHNlZSAi
aXQgdGFrZXMgMTYNCj4gPiAgIHByaW50ay1idWZmZXJzIHRvIG1ha2UgYSB0aGluZyBnbyByaWdo
dCIgYXMgYSBzdXJlIHRoaW5nLg0KPiANCj4gRXhpc3RpbmcgJ2NvbnQnIGhhbmRsaW5nIHdpbGwg
c3RheSBmb3IgYSB3aGlsZS4gQWZ0ZXIgbWFqb3JpdHkgb2YNCj4gcHJfY29udCgpL0tFUk5fQ09O
VCB1c2VycyBhcmUgY29udmVydGVkLCAnY29udCcgc3VwcG9ydCB3aWxsIGJlIHJlbW92ZWQNCj4g
KGUuZy4gS0VSTl9DT05UIGJlY29tZXMgIiIpLg0KDQpBIHRob3VnaDoNCg0KV2h5IG5vdCBtYWtl
IHRoZSBwcmludGYgbG9jayBzbGlnaHRseSAnc3RpY2t5Jz8NCi0gSWYgdGhlIG91dHB1dCBsaW5l
IGlzIGluY29tcGxldGUgc2F2ZSB0aGUgY3B1aWQuDQotIElmIHRoZXJlIGlzIGEgc2F2ZWQgY3B1
aWQgdGhhdCBkb2Vzbid0IG1hdGNoIHRoZSBjdXJyZW50IGNwdSB0aGVuIHNwaW4gZm9yIGEgYml0
Lg0KDQpBbnkgY2FsbGVycyBvZiBwcmludGsoKSBoYXZlIHRvIGFzc3VtZSB0aGV5IHdpbGwgc3Bp
biBvbiB0aGUgYnVmZmVyIGZvciB0aGUNCmxvbmdlc3QgcHJpbnRrIGZvcm1hdHRpbmcgKGFuZCBz
eW1ib2wgbG9va3VwIG1pZ2h0IHRha2UgYSB3aGlsZSkgc28gYSBzaG9ydA0KYWRkaXRpb25hbCBk
ZWxheSB3b24ndCBtYXR0ZXIuDQoNClRoZW4gdHdvIGNhbGxzIHRvIHByaW50aygpIGZvciB0aGUg
c2FtZSBsaW5lIHdvbid0ICh1c3VhbGx5KSBnZXQgc3BsaXQgYW5kDQpub25lIG9mIHRoZSBjYWxs
ZXJzIG5lZWQgYW55IGNoYW5nZXMuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3Mg
TGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQ
VCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

