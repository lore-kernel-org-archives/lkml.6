Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C5BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B873B20684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:36:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B873B20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406432AbeKWEQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 23:16:56 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:38549 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727522AbeKWEQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 23:16:56 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-131-lvsNkvxyO-yruosD5DLwNw-1; Thu, 22 Nov 2018 17:36:31 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu,
 22 Nov 2018 17:36:38 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 22 Nov 2018 17:36:38 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Denys Vlasenko' <dvlasenk@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, "Ingo Molnar" <mingo@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Brian Gerst <brgerst@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
Subject: RE: [PATCH] x86: only use ERMS for user copies for larger sizes
Thread-Topic: [PATCH] x86: only use ERMS for user copies for larger sizes
Thread-Index: AQHUgaBY0KBBfG3q00apJLDxEV5GB6VcD8pw
Date:   Thu, 22 Nov 2018 17:36:37 +0000
Message-ID: <7ea44458b90b4d41a08ba9012818d273@AcuMS.aculab.com>
References: <02bfc577-32a5-66be-64bf-d476b7d447d2@kernel.dk>
 <20181121063609.GA109082@gmail.com>
 <48e27a3a-2bb2-ff41-3512-8aeb3fd59e57@kernel.dk>
 <26eff539-7de7-784c-0c88-f1d30753299d@redhat.com>
In-Reply-To: <26eff539-7de7-784c-0c88-f1d30753299d@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: lvsNkvxyO-yruosD5DLwNw-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogRGVueXMgVmxhc2Vua28NCj4gU2VudDogMjEgTm92ZW1iZXIgMjAxOCAxMzo0NA0KLi4u
DQo+IEkgYWxzbyB0ZXN0ZWQgdGhpcyB3aGlsZSB3b3JraW5nIGZvciBzdHJpbmcgb3BzIGNvZGUg
aW4gbXVzbC4NCj4gDQo+IEkgdGhpbmsgYXQgbGVhc3QgMTI4IGJ5dGVzIHdvdWxkIGJlIHRoZSBt
aW5pbXVtIHdoZXJlICJSRVAgaW5zbiINCj4gYXJlIG1vcmUgZWZmaWNpZW50LiBJbiBteSB0ZXN0
aW5nLCBpdCdzIG1vcmUgbGlrZSAyNTYgYnl0ZXMuLi4NCg0KV2hhdCBoYXBwZW5zIGZvciBtaXNh
bGlnbmVkIGNvcGllcz8NCkkgaGFkIGEgZmVlbGluZyB0aGF0IHRoZSBFUk1TICdyZWIgbW92c2In
IGNvZGUgdXNlZCBzb21lIGtpbmQNCm9mIGJhcnJlbCBzaGlmdGVyIGluIHRoYXQgY2FzZS4NCg0K
VGhlIG90aGVyIHByb2JsZW0gd2l0aCB0aGUgRVJNUyBjb3B5IGlzIHRoYXQgaXQgZ2V0cyB1c2Vk
DQpmb3IgY29weV90by9mcm9tX2lvKCkgLSBhbmQgdGhlICdyZXAgbW92c2InIG9uIHVuY2FjaGVk
DQpsb2NhdGlvbnMgaGFzIHRvIGRvIGJ5dGUgY29waWVzLg0KQnl0ZSByZWFkcyBvbiBQQ0llIGFy
ZSByZWFsbHkgaG9ycmlkLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2Vz
aWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVL
DQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

