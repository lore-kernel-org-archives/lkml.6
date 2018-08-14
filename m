Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8A6C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 10:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 547AB21765
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 10:04:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 547AB21765
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732001AbeHNMvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 08:51:22 -0400
Received: from eu-smtp-delivery-211.mimecast.com ([207.82.80.211]:48951 "EHLO
        eu-smtp-delivery-211.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728101AbeHNMvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 08:51:22 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by eu-smtp-1.mimecast.com with ESMTP id
 uk-mta-128-pjp3_NTwNF2CZ8DnN7IoSA-1; Tue, 14 Aug 2018 11:04:51 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue,
 14 Aug 2018 11:06:31 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 14 Aug 2018 11:06:31 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Johannes Berg' <johannes@sipsolutions.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] bitfield: avoid gcc-8 -Wint-in-bool-context warning
Thread-Topic: [PATCH] bitfield: avoid gcc-8 -Wint-in-bool-context warning
Thread-Index: AQHUM6S9MtwhT4oWPE+vI6EhBy4DeaS/BLdg
Date:   Tue, 14 Aug 2018 10:06:31 +0000
Message-ID: <74bd14d45d2b47978218517093ae9de1@AcuMS.aculab.com>
References: <20180813220950.194841-1-arnd@arndb.de>
         <CAK7LNASVE-vZhGyAsWg8YmPb8P-sucwPVOUt5qsfVwZQuHg9gw@mail.gmail.com>
 <1534233405.3547.4.camel@sipsolutions.net>
In-Reply-To: <1534233405.3547.4.camel@sipsolutions.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
MIME-Version: 1.0
X-MC-Unique: pjp3_NTwNF2CZ8DnN7IoSA-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSm9oYW5uZXMgQmVyZw0KPiBTZW50OiAxNCBBdWd1c3QgMjAxOCAwODo1Nw0KLi4uDQo+
ID4gSG93IGFib3V0IGZpeGluZyB0aGUgcm9vdCBjYXVzZQ0KPiA+IGluIGRyaXZlcnMvbmV0L3dp
cmVsZXNzL2ludGVsL2l3bHdpZmkvZncvYXBpL3J4LmggPw0KPiA+DQo+ID4NCj4gPiAjZGVmaW5l
IElXTF9SWF9IRV9QSFlfU0lCR19TWU1fT1JfVVNFUl9OVU1fTUFTSyAgIDB4MWUwMDAwMDAwMFVM
TA0KPiA+DQo+ID4NCj4gPiBlbnVtIGl3bF9yeF9oZV9waHkgbG9va3MgcmVhbGx5IHN0cmFuZ2Uu
DQo+IA0KPiBXaHk/IEkgZG9uJ3QgdGhpbmsgdGhpcyBpcyBhIHByb2JsZW0sIHRoZSBlbnVtIGlz
IHVzZWQgaGVyZSB0byBnZXQNCj4gY29uc3RhbnRzIHNvIHRoYXQgd2UgY2FuIGFsc28gaGF2ZSBk
b2N1bWVudGF0aW9uIGZvciB0aGVtLiBUaGF0J3MgYQ0KPiBjb21tb24gYW5kIGFjY2VwdGVkIHRl
Y2huaXF1ZS4NCg0KSXQgd291bGQgYmUgbXVjaCBtb3JlIHVzZWZ1bCB0byBpbmRpY2F0ZSB3aGVy
ZSB0aGUgdmFsdWVzIGFyZSB1c2VkLg0KU3VjaCBhIGZpZWxkL3BhcmFtZXRlciBjb3VsZCAocHJv
YmFibHkpIGhhdmUgdGhlIHR5cGUgb2YgdGhlIGVudW0uDQpCdXQsIGF0IHNvbWUgcG9pbnQsIHRo
ZSBjb21waWxlciBtaWdodCBzdGFydCBiYXJmaW5nIGF0IHRoYXQgYXQgd2VsbC4NCg0KVGhlcmUg
YXJlIGFsc28gYSB3aG9sZSBsb2FkIG9mIGNyYXBweSBfX3BhY2tlZCBpbiB0aGF0IGhlYWRlciBm
aWxlLg0KVGhlcmUgbWlnaHQgYmUgb25lIG9yIHR3byA2NGJpdCBpdGVtcyBvbiAzMmJpdCBib3Vu
ZGFyaWVzIGJ1dA0KdGhhdCBjYW4gYmUgc29sdmVkIHdpdGhvdXQgdXNpbmcgX19wYWNrZWQuDQoN
CglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwg
TW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzog
MTM5NzM4NiAoV2FsZXMpDQo=

