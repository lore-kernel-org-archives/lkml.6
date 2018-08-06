Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF25C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A63214F1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:23:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7A63214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729729AbeHFMb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 08:31:59 -0400
Received: from eu-smtp-delivery-211.mimecast.com ([146.101.78.211]:56761 "EHLO
        eu-smtp-delivery-211.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728720AbeHFMb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 08:31:58 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by eu-smtp-1.mimecast.com with ESMTP id
 uk-mta-119-ZbMRWgkkOrmdz0lbGbUP8g-1; Mon, 06 Aug 2018 11:23:31 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 6 Aug 2018 11:25:10 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 6 Aug 2018 11:25:10 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Nick Desaulniers' <ndesaulniers@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "jgross@suse.com" <jgross@suse.com>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jdelvare@suse.de" <jdelvare@suse.de>,
        "astrachan@google.com" <astrachan@google.com>,
        "mka@chromium.org" <mka@chromium.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tstellar@redhat.com" <tstellar@redhat.com>,
        "sedat.dilek@gmail.com" <sedat.dilek@gmail.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] x86/irqflags: provide a declaration for native_save_fl
Thread-Topic: [PATCH] x86/irqflags: provide a declaration for native_save_fl
Thread-Index: AQHUK0x6WDTiNpFGE06NxxDqKj99SqSyiIzg
Date:   Mon, 6 Aug 2018 10:25:10 +0000
Message-ID: <c69c7292139b4e22a7d9ea3e968828d8@AcuMS.aculab.com>
References: <CAKwvOdmBtzkca-C1YpB_OYVyqFFi3P_Q8DJPaKr96DFZF0e6Hg@mail.gmail.com>
 <20180803170550.164688-1-ndesaulniers@google.com>
In-Reply-To: <20180803170550.164688-1-ndesaulniers@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
MIME-Version: 1.0
X-MC-Unique: ZbMRWgkkOrmdz0lbGbUP8g-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTmljayBEZXNhdWxuaWVycw0KPiBTZW50OiAwMyBBdWd1c3QgMjAxOCAxODowNg0KPiBG
aXhlcyBjb21taXQgZDBhOGQ5Mzc4ZDE2ICgieDg2L3BhcmF2aXJ0OiBNYWtlIG5hdGl2ZV9zYXZl
X2ZsKCkgZXh0ZXJuDQo+IGlubGluZSIpLg0KPiANCj4gSXQgd2FzIHJlcG9ydGVkIHRoYXQgdGhl
IGFib3ZlIGNvbW1pdCB3YXMgY2F1c2luZyB1c2VycyBvZiBnY2MgPCA0LjkgdG8NCj4gb2JzZXJ2
ZSAtV2Vycm9yPW1pc3NpbmctcHJvdG90eXBlcyBlcnJvcnMuDQo+IA0KPiBJbmRlZWQsIGl0IHNl
ZW1zIHRoYXQ6DQo+IGV4dGVybiBpbmxpbmUgdW5zaWduZWQgbG9uZyBuYXRpdmVfc2F2ZV9mbCh2
b2lkKSB7IHJldHVybiAwOyB9DQo+IA0KPiBjb21waWxlZCB3aXRoIC1XZXJyb3I9bWlzc2luZy1w
cm90b3R5cGVzIHByb2R1Y2VzIHRoaXMgd2FybmluZyBpbiBnY2MgPA0KPiA0LjksIGJ1dCBub3Qg
Z2NjID49IDQuOS4NCj4gDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnICMgNC4xNywgNC4x
NCwgNC45LCA0LjQNCj4gUmVwb3J0ZWQtYnk6IERhdmlkIExhaWdodCA8ZGF2aWQubGFpZ2h0QGFj
dWxhYi5jb20+DQo+IFJlcG9ydGVkLWJ5OiBKZWFuIERlbHZhcmUgPGpkZWx2YXJlQHN1c2UuZGU+
DQo+IFNpZ25lZC1vZmYtYnk6IE5pY2sgRGVzYXVsbmllcnMgPG5kZXNhdWxuaWVyc0Bnb29nbGUu
Y29tPg0KDQpZb3UgY2FuIGFkZCBteToNCg0KVGVzdGVkLWJ5OiBEYXZpZCBMYWlnaHQgPGRhdmlk
LmxhaWdodEBhY3VhYi5jb20+DQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFr
ZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwg
VUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

