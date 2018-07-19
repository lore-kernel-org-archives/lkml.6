Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E03ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 16:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4412120661
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 16:19:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4412120661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732052AbeGSRDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 13:03:49 -0400
Received: from eu-smtp-delivery-211.mimecast.com ([207.82.80.211]:43889 "EHLO
        eu-smtp-delivery-211.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731625AbeGSRDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 13:03:49 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by eu-smtp-1.mimecast.com with ESMTP id
 uk-mta-12-2UeKkl4QMDOpZE6OtNdLjw-1; Thu, 19 Jul 2018 17:19:53 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu,
 19 Jul 2018 17:21:32 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 19 Jul 2018 17:21:32 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Kirill Tkhai' <ktkhai@virtuozzo.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "vdavydov.dev@gmail.com" <vdavydov.dev@gmail.com>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "penguin-kernel@I-love.SAKURA.ne.jp" 
        <penguin-kernel@I-love.SAKURA.ne.jp>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mm: Cleanup in do_shrink_slab()
Thread-Topic: [PATCH] mm: Cleanup in do_shrink_slab()
Thread-Index: AQHUH3p9jXsb1mwn8kyuT9a/BX6Xv6SWuXKQ
Date:   Thu, 19 Jul 2018 16:21:32 +0000
Message-ID: <0f98d9b38be1466b8608d5c071aa52ed@AcuMS.aculab.com>
References: <153201627722.12295.11034132843390627757.stgit@localhost.localdomain>
In-Reply-To: <153201627722.12295.11034132843390627757.stgit@localhost.localdomain>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
MIME-Version: 1.0
X-MC-Unique: 2UeKkl4QMDOpZE6OtNdLjw-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogS2lyaWxsIFRraGFpDQo+IFNlbnQ6IDE5IEp1bHkgMjAxOCAxNzowNQ0KPiANCj4gR3Jv
dXAgbG9uZyB2YXJpYWJsZXMgdG9nZXRoZXIgdG8gbWluaW1pemUgbnVtYmVyIG9mIG9jY3VwaWVk
IGxpbmVzDQo+IGFuZCBwbGFjZSBhbGwgZGVmaW5pdGlvbnMgaW4gYmFjayBDaHJpc3RtYXMgdHJl
ZSBvcmRlci4NCg0KR3JvdXBpbmcgdG9nZXRoZXIgdW5yZWxhdGVkIHZhcmlhYmxlcyBkb2Vzbid0
IHJlYWxseSBtYWtlIHRoZSBjb2RlDQphbnkgbW9yZSByZWFkYWJsZS4NCklNSE8gT25lIHZhcmlh
YmxlIHBlciBsaW5lIGlzIHVzdWFsbHkgYmVzdC4NCg0KPiBBbHNvLCBzaW1wbGlmeSBleHByZXNz
aW9uIGFyb3VuZCBiYXRjaF9zaXplOiB1c2UgYWxsIHBvd2VyIG9mIEMgbGFuZ3VhZ2UhDQoNCiAg
IGZvbyA9IGJhciA/IDogYmF6Ow0KSXMgbm90IHBhcnQgb2YgQywgaXQgaXMgYSBnY2MgZXh0ZW5z
aW9uLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5
IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRp
b24gTm86IDEzOTczODYgKFdhbGVzKQ0K

