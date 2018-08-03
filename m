Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5631DC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 11:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0096E2175D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 11:22:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0096E2175D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbeHCNSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 09:18:46 -0400
Received: from eu-smtp-delivery-211.mimecast.com ([207.82.80.211]:56012 "EHLO
        eu-smtp-delivery-211.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726933AbeHCNSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 09:18:46 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by eu-smtp-1.mimecast.com with ESMTP id
 uk-mta-128-R1zRlZODOEaaPqFm00H03g-1; Fri, 03 Aug 2018 12:22:49 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 3 Aug 2018 12:24:28 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 3 Aug 2018 12:24:28 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Ard Biesheuvel' <ard.biesheuvel@linaro.org>,
        Ramana Radhakrishnan <ramana.gcc@googlemail.com>
CC:     Florian Weimer <fweimer@redhat.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        Andrew Pinski <pinskia@gmail.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "Russell King" <linux@armlinux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        "Mikulas Patocka" <mpatocka@redhat.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: RE: framebuffer corruption due to overlapping stp instructions on
 arm64
Thread-Topic: framebuffer corruption due to overlapping stp instructions on
 arm64
Thread-Index: AQHUKwzKyzS7gP0u+Em6lFS72D3AkaSt4YCg
Date:   Fri, 3 Aug 2018 11:24:28 +0000
Message-ID: <f696ebe8605840e3bb04bb78b60a6cfa@AcuMS.aculab.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CA+=Sn1mWkjuwVnjw6OWWUM=UcP76bdFa680FebCseewHfx3NpA@mail.gmail.com>
 <9acdacdb-3bd5-b71a-3003-e48132ee1371@redhat.com>
 <CAJA7tRZbmnZq7RfvQeYEy_a1ZObWqpFpVdvgsXgsioQ3RyPMuA@mail.gmail.com>
 <CAKv+Gu97QvwoLLK_zueiA_gjg_4Q5cqU4YVUyHUVFFfffdyJaw@mail.gmail.com>
In-Reply-To: <CAKv+Gu97QvwoLLK_zueiA_gjg_4Q5cqU4YVUyHUVFFfffdyJaw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
MIME-Version: 1.0
X-MC-Unique: R1zRlZODOEaaPqFm00H03g-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQXJkIEJpZXNoZXV2ZWwNCj4gU2VudDogMDMgQXVndXN0IDIwMTggMTA6MzANCi4uLg0K
PiBUaGUgZGlzY3Vzc2lvbiBhYm91dCB3aGV0aGVyIG1lbWNweSgpIHNob3VsZCByZWx5IG9uIHVu
YWxpZ25lZA0KPiBhY2Nlc3NlcywgYW5kIHdoZXRoZXIgeW91IHNob3VsZCB1c2UgaXQgb24gZGV2
aWNlIG1lbW9yeSBpcyBvcnRob2dvbmFsDQo+IHRvIHRoYXQsIGFuZCBub3QgdGhlIGhlYXJ0IG9m
IHRoZSBtYXR0ZXIgSU1PDQoNCkV2ZW4gb24geDg2IHVzaW5nIG1lbWNweSgpIG9uIFBDSWUgbWVt
b3J5IChtYXliZSBtbWFwKCllZCBpbnRvIHVzZXJzcGFjZSkNCmlzbid0IGEgZ29vZCBpZGVhLg0K
SW4gdGhlIGtlcm5lbCBtZW1jcHlfdG8vZnJvbWlvKCkgb3VnaHQgdG8gYmUgYSBiZXR0ZXIgY2hv
aWNlIGJ1dCB0aGF0DQppcyBqdXN0IGFuIGFsdGVybmF0ZSBuYW1lIGZvciBtZW1jcHkoKS4NCg0K
VGhlIHByb2JsZW0gb24geDg2IGlzIHRoYXQgbWVtY3B5KCkgaXMgbGlrZWx5IHRvIGJlIGltcGxl
bWVudGVkIGFzDQoncmVwIG1vdnNiJyBvbiBtb2Rlcm4gY3B1IC0gcmVseWluZyBvbiB0aGUgY3B1
IGhhcmR3YXJlIHRvIHBlcmZvcm0NCmNhY2hlLWxpbmUgc2l6ZWQgdHJhbnNmZXJzIChldGMpLg0K
VW5mb3J0dW5hdGVseSBvbiB1bmNhY2hlZCBsb2NhdGlvbnMgaXQgaGFzIHRvIHJldmVydCB0byBi
eXRlIGNvcGllcy4NClNvIFBDSWUgdHJhbnNmZXJzIChlc3BlY2lhbGx5IHJlYWRzKSBhcmUgdmVy
eSBzbG93Lg0KDQpUaGUgdHJhbnNmZXJzIG5lZWQgdG8gdXNlIHRoZSBsYXJnZXN0IHNpemUgcmVn
aXN0ZXIgYXZhaWxhYmxlLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2Vz
aWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVL
DQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

