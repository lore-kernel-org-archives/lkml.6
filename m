Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B936CFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B89C20853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B89C20853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbeINONN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 10:13:13 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:34403 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727675AbeINONM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 10:13:12 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by eu-smtp-1.mimecast.com with ESMTP id
 uk-mta-6-ylpiy9jaPaSOkiM1-_vIiw-1; Fri, 14 Sep 2018 09:59:38 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 14 Sep 2018 10:01:48 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 14 Sep 2018 10:01:48 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Eugene Korenevsky' <ekorenevsky@gmail.com>
CC:     "kzak@redhat.com" <kzak@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: RE: [PATCH v2] efi: take size of partition entry from GPT header
Thread-Topic: [PATCH v2] efi: take size of partition entry from GPT header
Thread-Index: AQHUSnRba9AUJIT+vUG+D13HDhLQCKTuLuRwgABgzYCAAO19EA==
Date:   Fri, 14 Sep 2018 09:01:48 +0000
Message-ID: <2db38b2d1af34ab9b653c665d08872f1@AcuMS.aculab.com>
References: <20180911161527.GA30689@vnote>
 <20180912083844.iegei2kobcz4b7ag@ws.net.home>
 <6d349d22d37041c1a2942d8ed4c76b69@AcuMS.aculab.com>
 <CAJC2YLaug4=7otnRC7x+UdDp=5ErgJFHFL_7mjRO7sdM2CrUfQ@mail.gmail.com>
In-Reply-To: <CAJC2YLaug4=7otnRC7x+UdDp=5ErgJFHFL_7mjRO7sdM2CrUfQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: ylpiy9jaPaSOkiM1-_vIiw-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogRXVnZW5lIEtvcmVuZXZza3kNCj4gU2VudDogMTMgU2VwdGVtYmVyIDIwMTggMjA6NDgN
Cj4gDQo+ID4gSSBzdXNwZWN0IHlvdSBhbHNvIG5lZWQgYSBzYW5pdHkgY2hlY2sgdGhhdCB0aGUg
dmFsdWUgaXNuJ3QgdG9vIHNtYWxsDQo+ID4gb3Igc3R1cGlkbHkgbGFyZ2UuDQo+IA0KPiBXaGF0
IHdvdWxkIGJlIHRoZSBjcml0ZXJpb24gZm9yIHRvbyBsYXJnZSBlbnRyaWVzPw0KDQpBbnl0aGlu
ZyBsYXJnZXIgdGhhbiB0aGUgbWF4aW11bSBzaXplIG9mIHRoZSBmdWxsIEdQVCB0YWJsZQ0Kd291
bGQgYmUgYSBzdGFydC4NCkV2ZW4gc29tZXRoaW5nIGxpa2UgNjRrIHdvdWxkIHN0b3AgbGF0ZXIg
Y2FsY3VsYXRpb25zIGdvaW5nIHdyb25nLg0KSSBwcmVzdW1lIHRoZXJlIGlzIGEgY2hlY2sgZWxz
ZXdoZXJlIHRoYXQgdGhlIEdQVCB0YWJsZSBlbnRyaWVzDQphcmUgYWxsIGluc2lkZSB0aGUgZGlz
ayBhcmVhIHRoYXQgd2FzIHJlYWQ/DQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3Mg
TGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQ
VCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

