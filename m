Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E900C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1EDB20882
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:21:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1EDB20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388470AbeGXM1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 08:27:16 -0400
Received: from eu-smtp-delivery-211.mimecast.com ([207.82.80.211]:58093 "EHLO
        eu-smtp-delivery-211.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388271AbeGXM1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 08:27:16 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by eu-smtp-1.mimecast.com with ESMTP id
 uk-mta-116-karjEUGXPTKr1bUPyhsGqw-1; Tue, 24 Jul 2018 12:21:14 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 24 Jul 2018 12:22:53 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 24 Jul 2018 12:22:53 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Krzysztof Kozlowski' <krzk@kernel.org>
CC:     Pantelis Antoniou <pantelis.antoniou@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Eric Biggers <ebiggers3@gmail.com>
Subject: RE: [PATCH] net: ethernet: fs-enet: Use generic CRC32 implementation
Thread-Topic: [PATCH] net: ethernet: fs-enet: Use generic CRC32 implementation
Thread-Index: AQHUIqFaRp0U1GGAv0+osEvb8ATmgqSeNinQ///yCwCAABIP0A==
Date:   Tue, 24 Jul 2018 11:22:53 +0000
Message-ID: <8a9c44b51e2f4fb08f5273d3aca71e1c@AcuMS.aculab.com>
References: <20180723162020.6221-1-krzk@kernel.org>
 <5ef968e1cb2a473cad97f6bfead369ca@AcuMS.aculab.com>
 <CAJKOXPdveQeg_M42v69m9vBEz2SaJE0_BZNRUqGLt4Ve+ZLYSg@mail.gmail.com>
In-Reply-To: <CAJKOXPdveQeg_M42v69m9vBEz2SaJE0_BZNRUqGLt4Ve+ZLYSg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
MIME-Version: 1.0
X-MC-Unique: karjEUGXPTKr1bUPyhsGqw-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogS3J6eXN6dG9mIEtvemxvd3NraQ0KPiBTZW50OiAyNCBKdWx5IDIwMTggMTI6MTINCi4u
Lg0KPiA+PiBOb3QgdGVzdGVkIG9uIGhhcmR3YXJlLg0KPiA+DQo+ID4gSGF2ZSB5b3UgdmVyaWZp
ZWQgdGhhdCB0aGUgb2xkIGFuZCBuZXcgZnVuY3Rpb25zIGdpdmUgdGhlDQo+ID4gc2FtZSByZXN1
bHQgZm9yIGEgZmV3IG1hYyBhZGRyZXNzZXM/DQo+ID4gSXQgaXMgdmVyeSBlYXN5IHRvIHVzZSB0
aGUgd3JvbmcgYml0cyBpbiBjcmMgY2FsY3VsYXRpb25zDQo+ID4gb3IgZ2VuZXJhdGUgdGhlIG91
dHB1dCBpbiB0aGUgd3JvbmcgYml0IG9yZGVyLg0KPiANCj4gSSBjb3BpZWQgdGhlIG9yaWdpbmFs
IGNvZGUgYW5kIG5ldyBvbmUgb250byBhIGRpZmZlcmVudCBkcml2ZXIgYW5kIHJ1bg0KPiB0aGlz
IGluIGEgbG9vcCBmb3IgdGhvdXNhbmRzIG9mIGRhdGEgaW5wdXQgKGFsdGhvdWdoIG5vdCBhbGwg
cG9zc2libGUNCj4gTUFDIGNvbWJpbmF0aW9ucykuIFRoZSBvdXRwdXQgd2FzIHRoZSBzYW1lLiBJ
IGFncmVlIGhvd2V2ZXIgdGhhdCByZWFsDQo+IHRlc3Rpbmcgd291bGQgYmUgaW1wb3J0YW50Lg0K
DQpTaW5jZSBDUkMgYXJlIGxpbmVhciB5b3Ugb25seSBuZWVkIHRvIGNoZWNrIHRoYXQgZWFjaCBp
bnB1dA0KYml0IGdlbmVyYXRlcyB0aGUgY29ycmVjdCBvdXRwdXQuDQoNCglEYXZpZA0KDQotDQpS
ZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWls
dG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMp
DQo=

