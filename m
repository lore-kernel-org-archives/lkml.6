Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A34ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 11:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D726A2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 11:28:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D726A2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbeJSTd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 15:33:59 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:52631 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726784AbeJSTd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 15:33:59 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by eu-smtp-1.mimecast.com with ESMTP id
 uk-mta-148-6hZ5yJn7P9ei7r-xcDAz8Q-1; Fri, 19 Oct 2018 12:28:17 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 19 Oct 2018 12:28:19 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 19 Oct 2018 12:28:19 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Masahiro Yamada' <yamada.masahiro@socionext.com>,
        Borislav Petkov <bp@alien8.de>
CC:     =?utf-8?B?TGVvbmFyZG8gQnLDoXM=?= <leobras.c@gmail.com>,
        "lkcamp@lists.libreplanetbr.org" <lkcamp@lists.libreplanetbr.org>,
        "Matthew Wilcox" <willy6545@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Subject: RE: [PATCH 1/4] Adds -Wshadow=local on KBUILD_HOSTCFLAGS
Thread-Topic: [PATCH 1/4] Adds -Wshadow=local on KBUILD_HOSTCFLAGS
Thread-Index: AQHUZwE94ZhritarS0iSYOE/UiGZ1aUmbYcQ
Date:   Fri, 19 Oct 2018 11:28:19 +0000
Message-ID: <7b87404e2a0347968013e024e52e4cb2@AcuMS.aculab.com>
References: <20181017000809.GA21292@WindFlash>
 <20181017081115.GA22535@zn.tnic>
 <CAK7LNASVn7CB5uL9tCtNC2u4Ary5eb-vyiB_sS2ey5AZNweKAA@mail.gmail.com>
 <20181017083126.GB22535@zn.tnic>
 <CADvQ+rFa=XEuxLb=yPmtJE2QepBNjCVzjEY5urVzCaSF1tJBYw@mail.gmail.com>
 <20181018091606.GA20831@zn.tnic>
 <CAK7LNAQq7aE_2QYwqei7M9fg8Yen7-ucjz-t2E_hq2xkznKsQw@mail.gmail.com>
In-Reply-To: <CAK7LNAQq7aE_2QYwqei7M9fg8Yen7-ucjz-t2E_hq2xkznKsQw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: 6hZ5yJn7P9ei7r-xcDAz8Q-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTWFzYWhpcm8gWWFtYWRhDQo+IFNlbnQ6IDE4IE9jdG9iZXIgMjAxOCAxNzozOQ0KPiAN
Cj4gT24gVGh1LCBPY3QgMTgsIDIwMTggYXQgNjoxOCBQTSBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFs
aWVuOC5kZT4gd3JvdGU6DQo+ID4NCj4gPiBPbiBXZWQsIE9jdCAxNywgMjAxOCBhdCAwOTo0MDo1
M1BNIC0wMzAwLCBMZW9uYXJkbyBCcmFzIHdyb3RlOg0KPiA+ID4gVGhlIGlkZWEgd2FzIHRvIHB1
dCBpdCBhcyBkZWZhdWx0IGFuZCBmaXggYWxsIHRoZSBzaGFkb3dpbmcgd2FybmluZ3MuDQo+ID4g
PiBXaGF0IGRvIHlvdSB0aGluaz8gIEkgYW0gb3BlbiB0byBzdWdnZXN0aW9ucy4NCj4gPg0KPiA+
IFRoYXQncyBNYXNhaGlybydzIGNhbGwuIEluIHRoZSByZXN0IG9mIHRoZSBrZXJuZWwsIHRob3Nl
IHdhcm5pbmdzIGFyZSBiZWhpbmQNCj4gPiB0aGUgVz0yIHN3aXRjaCAtIGkuZS4sIG5vdCBlbmFi
bGVkIGJ5IGRlZmF1bHQuDQo+IA0KPiANCj4gSXQgaXMgbm90IHJlYWxpc3RpYyB0byBlbmFibGUg
dGhpcyB3YXJuaW5nIG9wdGlvbiBieSBkZWZhdWx0Lg0KPiBFdmVuIC1Xc2hhZG93PWxvY2FsIGVt
aXRzIHRvbnMgb2Ygd2FybmluZ3MuDQo+IChNb3JlIHdpdGggLVdzaGFkb3cpDQoNClRoZSBxdWVz
dGlvbiBpcywgaG93IG1hbnkgb2YgdGhlbSBhcmUgYWN0dWFsIGJ1Z3MuDQpJTUhPIC1Xc2hhZG93
IGlzIGEgZ29vZCBpZGVhLg0KDQo+IFRoZSBwcm9ibGVtIG9mIHRoaXMgZmxhZyBpcywNCj4gaXQg
aXMgZmFsc2UgcG9zaXRpdmUgaW4gbWFjcm8gZXhwYW5zaW9ucy4NCg0KUmlnaHQsIGJ1dCBtYWNy
byBleHBhbnNpb25zIGluc2lkZSBtYWNybyBkZWZpbml0aW9ucyBjb3VsZCBhY2NpZGVudGFsbHkN
CnVzZSB0aGUgc2FtZSBsb2NhbCB2YXJpYWJsZSAtIGxlYWRpbmcgdG8gY2hvYXMuDQoNCj4gRm9y
IGV4YW1wbGUsIEkgdGhpbmsgdGhlIGZvbGxvd2luZyBpcyBhIGxlZ2l0aW1hdGUgY2FzZS4NCi4u
Lg0KPiBhcmNoL2FybTY0L2tlcm5lbC9mcHNpbWQuYzo3MTM6Mjogbm90ZTogaW4gZXhwYW5zaW9u
IG9mIG1hY3JvIOKAmHdyaXRlX3N5c3JlZ+KAmQ0KPiAgIHdyaXRlX3N5c3JlZyhyZWFkX3N5c3Jl
ZyhDUEFDUl9FTDEpIHwgQ1BBQ1JfRUwxX1pFTl9FTDFFTiwgQ1BBQ1JfRUwxKTsNCj4gICBefn5+
fn5+fn5+fn4NCg0KRWFzaWx5IGZpeGVkIGJ5IHVzaW5nIGRpZmZlcmVudCBuYW1lZCB0ZW1wb3Jh
cmllcyBpbiB0aGUgdHdvIG1hY3Jvcy4NClRoZXJlIHByb2JhYmx5IGFyZW4ndCB0aGF0IG1hbnkg
bWFjcm8gcGFpcnMgd2hlcmUgdGhhdCBoYXBwZW5zLg0KRXNwZWNpYWxseSBzaW5jZSBtYW55IGFy
ZSBub3cgaW5saW5lZCBmdW5jdGlvbnMuDQoNCkl0IG1pZ2h0IGJlIHRoYXQgYSBzbWFsbCBudW1i
ZXIgb2YgY2hhbmdlcyBnZXQgcmlkIG9mIG1vc3Qgb2YgdGhlIHdhcm5pbmdzLg0KDQoJRGF2aWQN
Cg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZh
cm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYg
KFdhbGVzKQ0K

