Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8C2C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 13:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E105A21741
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 13:08:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E105A21741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732699AbeHNPzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 11:55:05 -0400
Received: from eu-smtp-delivery-211.mimecast.com ([146.101.78.211]:53590 "EHLO
        eu-smtp-delivery-211.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729955AbeHNPzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 11:55:04 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by eu-smtp-1.mimecast.com with ESMTP id
 uk-mta-149-6v4cGIP8OT-J1kApq5rYEg-1; Tue, 14 Aug 2018 14:07:55 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue,
 14 Aug 2018 14:09:34 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 14 Aug 2018 14:09:34 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arnd Bergmann' <arnd@arndb.de>
CC:     Johannes Berg <johannes@sipsolutions.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] bitfield: avoid gcc-8 -Wint-in-bool-context warning
Thread-Topic: [PATCH] bitfield: avoid gcc-8 -Wint-in-bool-context warning
Thread-Index: AQHUM6S9MtwhT4oWPE+vI6EhBy4DeaS/BLdggAABXYCAADBgMA==
Date:   Tue, 14 Aug 2018 13:09:34 +0000
Message-ID: <74849e23af4d480f8a990a7924fc48e1@AcuMS.aculab.com>
References: <20180813220950.194841-1-arnd@arndb.de>
 <CAK7LNASVE-vZhGyAsWg8YmPb8P-sucwPVOUt5qsfVwZQuHg9gw@mail.gmail.com>
 <1534233405.3547.4.camel@sipsolutions.net>
 <74bd14d45d2b47978218517093ae9de1@AcuMS.aculab.com>
 <CAK8P3a2-rQ2wp77dHJv9sKg+0oZrnNqMxGGJmyMWxBSfL03LKA@mail.gmail.com>
In-Reply-To: <CAK8P3a2-rQ2wp77dHJv9sKg+0oZrnNqMxGGJmyMWxBSfL03LKA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
MIME-Version: 1.0
X-MC-Unique: 6v4cGIP8OT-J1kApq5rYEg-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQXJuZCBCZXJnbWFubg0KPiBTZW50OiAxNCBBdWd1c3QgMjAxOCAxMjowOA0KLi4uDQo+
ID4gVGhlcmUgYXJlIGFsc28gYSB3aG9sZSBsb2FkIG9mIGNyYXBweSBfX3BhY2tlZCBpbiB0aGF0
IGhlYWRlciBmaWxlLg0KPiA+IFRoZXJlIG1pZ2h0IGJlIG9uZSBvciB0d28gNjRiaXQgaXRlbXMg
b24gMzJiaXQgYm91bmRhcmllcyBidXQNCj4gPiB0aGF0IGNhbiBiZSBzb2x2ZWQgd2l0aG91dCB1
c2luZyBfX3BhY2tlZC4NCj4gDQo+IEFncmVlZCwgdGhpcyBsaWtlbHkgY2F1c2VzIHByb2JsZW1z
IG9uIGFyY2hpdGVjdHVyZXMgd2l0aG91dCB1bmFsaWduZWQNCj4gbG9hZC9zdG9yZSBpbnN0cnVj
dGlvbnMgdGhhdCBlbmQgdXAgZG9pbmcgYnl0ZSBhY2Nlc3NlcyB0byB0aGUgZGVzY3JpcHRvcg0K
PiBmaWVsZHMsIHdoaWNoIGluIHR1cm4gY2FuIGNvbmZ1c2UgdGhlIGhhcmR3YXJlLCBhbmQgY2Fu
IGJlY29tZSB2ZXJ5DQo+IHNsb3cgd2hlbiB0aGV5IGxpdmUgaW4gZG1hX2FsbG9jX2NvaGVyZW50
KCkgbWVtb3J5LiBUaGF0IGxvb2tzDQo+IGxpa2UgYSBjb21wbGV0ZWx5IHVucmVsYXRlZCBpc3N1
ZSB0aG91Z2guDQoNCklmIHlvdSBldmVyIGRlZmluZSBhIHZhcmlhYmxlIG9mIG9uZSBvZiB0aG9z
ZSB0eXBlcyAob3IgZW1iZWQgb25lDQppbiBhbm90aGVyIHN0cnVjdHVyZSB0aGF0IGNvbnRhaW5z
IG5vbi13b3JkIHNpemVkIGl0ZW1zKSB5b3UnbGwNCmdldCB0aGUgZW50aXJlIHN0cnVjdHVyZSBt
aXNhbGlnbmVkLg0KSSBkb3VidCB0aGF0IGlzIHdoYXQgeW91IGhhZCBpbiBtaW5kLg0KDQpNYXli
ZSB5b3UgY291bGQgdXNlIF9fcGFja2VkIF9fYXR0cmlidXRlX18oKGFsaWduZWQoNCkpKS4NCkJ1
dCBpdCBpcyBtdWNoIGJldHRlciBqdXN0IHRvIHVzZSBhIDY0Yml0IHR5cGUgd2l0aCBvbmx5IDQg
Ynl0ZSBhbGlnbm1lbnQNCihJIHRoaW5rIHRoZXJlIGlzIGEgc3RhbmRhcmQgb25lIGluIG9uZSBv
ZiB0aGUgaGVhZGVyIGZpbGVzKS4NCg0KSSdkIGFsc28gYWRkIGEgY29tcGlsZS10aW1lIGFzc2Vy
dCBvbiB0aGUgbGVuZ3RoIG9mIHRoZSBub24tdHJpdmlhbA0Kc3RydWN0dXJlcy4gVGhhdCB3aWxs
IGRldGVjdCBhbGwgc29ydHMgb2YgZXJyb3JzLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBB
ZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMs
IE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

