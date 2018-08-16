Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F87C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 09:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 755B9214C2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 09:15:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 755B9214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390376AbeHPMNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 08:13:07 -0400
Received: from eu-smtp-delivery-211.mimecast.com ([146.101.78.211]:46584 "EHLO
        eu-smtp-delivery-211.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728165AbeHPMNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 08:13:07 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by eu-smtp-1.mimecast.com with ESMTP id
 uk-mta-123-Ank6DcxCOM2-xgQfLXSRQA-1; Thu, 16 Aug 2018 10:15:53 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 16 Aug 2018 10:17:32 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 16 Aug 2018 10:17:32 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>
CC:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        "Mike Galbraith" <efault@gmx.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: RE: Build failures with gcc 4.5 and older
Thread-Topic: Build failures with gcc 4.5 and older
Thread-Index: AQHUM/HAiGfsyFkD4UmbPfzcSwB5naTAwY9QgAAjZICAABVscP//+GIAgAEofxA=
Date:   Thu, 16 Aug 2018 09:17:32 +0000
Message-ID: <5740f0ea692244a5a9bc7c4ac9263687@AcuMS.aculab.com>
References: <20180814170904.GA12768@roeck-us.net>
 <aa4bedb7b1af45c59ff4e61f3f199287@AcuMS.aculab.com>
 <CA+55aFyeW7rqgGqOusZSz-jFP-CMH=hcyVGKhxyLxNeyBgLbqw@mail.gmail.com>
 <d87ba353f6fc44668969a8535790cdc9@AcuMS.aculab.com>
 <CA+55aFwwon2MLEhw-ERLskWed8b58NseLYF-7OOQhhjMcD-A6A@mail.gmail.com>
In-Reply-To: <CA+55aFwwon2MLEhw-ERLskWed8b58NseLYF-7OOQhhjMcD-A6A@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
MIME-Version: 1.0
X-MC-Unique: Ank6DcxCOM2-xgQfLXSRQA-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMTUgQXVndXN0IDIwMTggMTc6MzQNCj4gVG86
IERhdmlkIExhaWdodA0KPiBDYzogR3VlbnRlciBSb2VjazsgTGludXggS2VybmVsIE1haWxpbmcg
TGlzdDsgUmlrIHZhbiBSaWVsOyBNaWtlIEdhbGJyYWl0aDsgRGF2ZSBIYW5zZW47IEFuZHJldyBN
b3J0b24NCj4gU3ViamVjdDogUmU6IEJ1aWxkIGZhaWx1cmVzIHdpdGggZ2NjIDQuNSBhbmQgb2xk
ZXINCj4gDQo+IE9uIFdlZCwgQXVnIDE1LCAyMDE4IGF0IDk6MTYgQU0gRGF2aWQgTGFpZ2h0IDxE
YXZpZC5MYWlnaHRAYWN1bGFiLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiA+DQo+ID4gPiBCdXQgc29t
ZSBsaWJlbGYgYnVnIHRoYXQgaXMgbGVzcyB0aGFuIGEgeWVhciBvbGQgaXMgbGlrZWx5IHRvIGJp
dGUgcGVvcGxlLg0KPiA+DQo+ID4gU2VlIGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE3LzkvMTAv
MTg2IGZvciB0aGUgbGliZWxmIGZpeC4NCj4gPiBJdCBpc24ndCBhbnl0aGluZyBsaWtlIGFzIHJh
cmUgYXMgdGhvc2UgZW1haWxzIHN1Z2dlc3QuDQo+ID4gQW4gJ2FsbG1vZGNvbmZpZycgYnVpbGQg
ZmFpbHMgb24gYSBsb3Qgb2Ygb2JqZWN0IGZpbGVzIGFmdGVyIDQuMTUtcmM5Lg0KPiANCj4gT2ss
IGJ1dCB0aGF0IHBhdGNoIHRoYXQgZml4ZXMgaXQgd2FzIG1lcmdlZCBhIGxvbmcgdGltZSBhZ28g
YWxyZWFkeS4NCj4gU2VlIGNvbW1pdCA5N2RhYjJhZTdlODQgKCJvYmp0b29sOiBGaXggb2JqZWN0
IGZpbGUgY29ycnVwdGlvbiIpDQo+IA0KPiBTbyBJJ20gYSBiaXQgY29uZnVzZWQgYnkgeW91ciBp
c3N1ZS4gVGhlIHRoaW5nIHlvdSBwb2ludCB0byBmcm9tIGxhc3QNCj4geWVhciB3YXMgbGl0ZXJh
bGwgZml4ZWQgYW5kIGNvbW1pdHRlZCB0byB0aGUgdHJlZSBpbiBhIGNvdXBsZSBvZiBkYXlzDQo+
IGRheXMuDQoNCkhtbW0uLi4gSSBzdGlsbCBoYWQgdG8gdXBkYXRlIGZyb20gbGliZWxmLTAuMTUz
LnNvIHRvIGxpYmVsZi0wLjE2NS5zbw0KaW4gb3JkZXIgdG8gZ2V0IHRoZSBvdXRwdXQgZnJvbSBv
Ymp0b29sIHRvIGJlIHZhbGlkLg0KSSdtIHN1cmUgSSdkIHNlZW4gYSBwYXRjaCB0byBsaWJlbGYg
YXMgd2VsbC4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJh
bWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0
cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

