Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02AB7C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 16:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 974AE2083C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 16:16:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 974AE2083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729513AbeHOTJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 15:09:37 -0400
Received: from eu-smtp-delivery-211.mimecast.com ([146.101.78.211]:28059 "EHLO
        eu-smtp-delivery-211.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729348AbeHOTJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 15:09:36 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by eu-smtp-1.mimecast.com with ESMTP id
 uk-mta-89-O8FTty0LPMSOH5t_YmUaFw-1; Wed, 15 Aug 2018 17:16:47 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 15 Aug 2018 17:18:26 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 15 Aug 2018 17:18:26 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>
CC:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        "Mike Galbraith" <efault@gmx.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "Andrew Morton" <akpm@linux-foundation.org>
Subject: RE: Build failures with gcc 4.5 and older
Thread-Topic: Build failures with gcc 4.5 and older
Thread-Index: AQHUM/HAiGfsyFkD4UmbPfzcSwB5naTAwY9QgAAjZICAABVscA==
Date:   Wed, 15 Aug 2018 16:18:26 +0000
Message-ID: <d87ba353f6fc44668969a8535790cdc9@AcuMS.aculab.com>
References: <20180814170904.GA12768@roeck-us.net>
 <aa4bedb7b1af45c59ff4e61f3f199287@AcuMS.aculab.com>
 <CA+55aFyeW7rqgGqOusZSz-jFP-CMH=hcyVGKhxyLxNeyBgLbqw@mail.gmail.com>
In-Reply-To: <CA+55aFyeW7rqgGqOusZSz-jFP-CMH=hcyVGKhxyLxNeyBgLbqw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
MIME-Version: 1.0
X-MC-Unique: O8FTty0LPMSOH5t_YmUaFw-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpGcm9tOiBMaW51cyBUb3J2YWxkcw0KPiBTZW50OiAxNSBBdWd1c3QgMjAxOCAxNjo0NA0KPiBP
biBXZWQsIEF1ZyAxNSwgMjAxOCBhdCA1OjM4IEFNIERhdmlkIExhaWdodCA8RGF2aWQuTGFpZ2h0
QGFjdWxhYi5jb20+IHdyb3RlOg0KPiA+DQo+ID4gTmV2ZXIgbWluZCB0aGUgdmVyc2lvbiBvZiBn
Y2MsIHRoZSB4ODYga2VybmVsIGRvZXNuJ3QgYnVpbGQgd2l0aCB0aGUNCj4gPiBkZWZhdWx0IGtl
cm5lbCBvcHRpb25zIGJlY2F1c2UgdGhlIE9SQyB1bndpbmRlciBoaXRzIGEgYnVnIGluIGxpYmVs
Zg0KPiA+IChpbiBvYmp0b29sKSB0aGF0IHdhcyBvbmx5IGZpeGVkIGxhdGUgbGFzdCB5ZWFyLg0K
PiA+DQo+ID4gSXQgaXNuJ3QgZXZlbiBvYnZpb3VzIGZyb20gdGhlIGJ1aWxkIGxvZyB3aGF0IGhh
cyBnb25lIHdyb25nLg0KPiANCj4gQ2FuIHlvdSBnaXZlIG1vcmUgZGV0YWlscz8gV2Ugc2hvdWxk
IHRyeSB0byB3b3JrIGFyb3VuZCBpdC4NCj4gDQo+IEl0J3Mgb25lIHRoaW5nIHRvIGNhcmUgYWJv
dXQgYSBjb21waWxlciB0aGF0IGlzIGFsbW9zdCBhIGRlY2FkZSBvbGQuDQo+IEF0IHNvbWUgcG9p
bnQgd2UganVzdCBoYXZlIHRvIGxldCBpdCBnby4NCj4gDQo+IEJ1dCBzb21lIGxpYmVsZiBidWcg
dGhhdCBpcyBsZXNzIHRoYW4gYSB5ZWFyIG9sZCBpcyBsaWtlbHkgdG8gYml0ZSBwZW9wbGUuDQoN
ClNlZSBodHRwczovL2xrbWwub3JnL2xrbWwvMjAxNy85LzEwLzE4NiBmb3IgdGhlIGxpYmVsZiBm
aXguDQpJdCBpc24ndCBhbnl0aGluZyBsaWtlIGFzIHJhcmUgYXMgdGhvc2UgZW1haWxzIHN1Z2dl
c3QuDQpBbiAnYWxsbW9kY29uZmlnJyBidWlsZCBmYWlscyBvbiBhIGxvdCBvZiBvYmplY3QgZmls
ZXMgYWZ0ZXIgNC4xNS1yYzkuDQoNCldoZW4gSSBmZWxsIG92ZXIgdGhlIHByb2JsZW0gSSBmb3Vu
ZCBhIGZldyByZXBvcnRzIG9uIHRoZSB1YnVudHUgbGlzdHMNCmJ1dCB0aGV5IGFsbCBqdXN0IHNh
aWQgdGhlIHVidW50dSB2ZXJzaW9uIHdhcyB1bnN1cHBvcnRlZC4NCg0KVGhlcmUgaXMgdGhpcyBw
YXRjaCBJIGRpZCBodHRwczovL2xrbWwub3JnL2xrbWwvMjAxOC83LzI2LzI2NiB0aGF0IGdvdA0K
bm8gY29tbWVudHMuDQoNCkJ1dCByZWFsbHkgc29tZXRoaW5nIG5lZWRzIHRvIGJlIGRvbmUgdG8g
b2JqdG9vbC4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJh
bWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0
cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

