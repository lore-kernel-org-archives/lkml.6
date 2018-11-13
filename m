Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E969AC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6CCF2245E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:25:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6CCF2245E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732207AbeKMUXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 15:23:19 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:43901 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726765AbeKMUXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 15:23:19 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by dkim.mimecast.com with ESMTP id
 uk-mta-147-gymFyqMKOi6lV4dL7gY-qQ-1; Tue, 13 Nov 2018 10:25:49 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue,
 13 Nov 2018 10:25:54 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 13 Nov 2018 10:25:54 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Li, Aubrey'" <aubrey.li@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Aubrey Li <aubrey.li@intel.com>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH v2 1/2] x86/fpu: detect AVX task
Thread-Topic: [RFC PATCH v2 1/2] x86/fpu: detect AVX task
Thread-Index: AQHUeii707Eilrmaj0KnTIFQLJW0yKVNgTLw
Date:   Tue, 13 Nov 2018 10:25:54 +0000
Message-ID: <25dd33ee964f4de5ae33a1575e1bf47f@AcuMS.aculab.com>
References: <1541610982-33478-1-git-send-email-aubrey.li@intel.com>
 <alpine.DEB.2.21.1811091121340.1519@nanos.tec.linutronix.de>
 <657a9ee9-bb27-968a-34ae-e25df6c2fff9@linux.intel.com>
In-Reply-To: <657a9ee9-bb27-968a-34ae-e25df6c2fff9@linux.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: gymFyqMKOi6lV4dL7gY-qQ-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGksIEF1YnJleQ0KPiBTZW50OiAxMiBOb3ZlbWJlciAyMDE4IDAxOjQxDQouLi4NCj4g
VlpFUk9VUFBFUiBpbnN0cnVjdGlvbiByZXNldHMgdGhlIGluaXQgc3RhdGUuIElmIGNvbnRleHQg
c3dpdGNoIGhhcHBlbnMNCj4gdG8gb2NjdXIgZXhhY3RseSBhZnRlciBWWkVST1VQUEVSIGluc3Ry
dWN0aW9uLCBYSU5VU0UgYml0bWFwIGlzIGVtcHR5KGFsbA0KPiB6ZXJvcyksIHdoaWNoIGluZGlj
YXRlcyB0aGUgdGFzayBpcyBub3QgdXNpbmcgQVZYLiBUaGF0J3Mgd2h5IHRoZSBzdGF0ZQ0KPiBk
ZWNheSBjb3VudCBpcyB1c2VkIGhlcmUuDQoNCklzbid0IHRoZXJlIGFuIG9idmlvdXMgb3B0aW1p
c2F0aW9uIHRvIGV4ZWN1dGUgVlpFUk9BTEwgZHVyaW5nIHN5c3RlbSBjYWxsDQplbnRyeT8NCklm
IHRoYXQgaXMgZG9uZSBkb2VzIGFueSBvZiB0aGlzIGFjdHVhbGx5IHdvcms/DQoNCglEYXZpZA0K
IA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQg
RmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4
NiAoV2FsZXMpDQo=

