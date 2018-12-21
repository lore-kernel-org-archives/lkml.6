Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1C3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FD3121917
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731581AbeLUPsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 10:48:20 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:43202 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731341AbeLUPsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 10:48:19 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-15-UUHnCn1jPsShdUuc4ksamw-1; Fri, 21 Dec 2018 15:48:15 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 21 Dec 2018 15:48:28 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 21 Dec 2018 15:48:27 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Borislav Petkov' <bp@suse.de>, WANG Chao <chao.wang@ucloud.cn>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        Andy Lutomirski <luto@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        "srinivas.eeda@oracle.com" <srinivas.eeda@oracle.com>
Subject: RE: [PATCH] treewide: replace RETPOLINE with CONFIG_RETPOLINE
Thread-Topic: [PATCH] treewide: replace RETPOLINE with CONFIG_RETPOLINE
Thread-Index: AQHUmRqUsfCR4f4V90yvOEtrV22nHKWJVOxw
Date:   Fri, 21 Dec 2018 15:48:27 +0000
Message-ID: <5e2597b5ce4e4e19bf3ccca65c25a8d5@AcuMS.aculab.com>
References: <20181210163725.95977-1-chao.wang@ucloud.cn>
 <20181221093347.GA88654@WANG-Chaos-MacBook-Pro.local>
 <20181221104705.GA4750@zn.tnic>
In-Reply-To: <20181221104705.GA4750@zn.tnic>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: UUHnCn1jPsShdUuc4ksamw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQm9yaXNsYXYgUGV0a292DQo+IFNlbnQ6IDIxIERlY2VtYmVyIDIwMTggMTA6NDcNCj4g
T24gRnJpLCBEZWMgMjEsIDIwMTggYXQgMDU6MzM6NDdQTSArMDgwMCwgV0FORyBDaGFvIHdyb3Rl
Og0KPiA+IE9uIDEyLzExLzE4IGF0IDEyOjM3UCwgV0FORyBDaGFvIHdyb3RlOg0KPiA+ID4gU2lu
Y2UgY29tbWl0IDRjZDI0ZGUzYTA5OCAoIng4Ni9yZXRwb2xpbmU6IE1ha2UgQ09ORklHX1JFVFBP
TElORSBkZXBlbmQNCj4gPiA+IG9uIGNvbXBpbGVyIHN1cHBvcnQiKSwgUkVUUE9MSU5FIGhhcyBi
ZWVuIHJlcGxhY2VkIGJ5IENPTkZJR19SRVRQT0xJTkUuDQo+ID4gPg0KPiA+ID4gRml4ZXM6IDRj
ZDI0ZGUzYTA5OCAoIng4Ni9yZXRwb2xpbmU6IE1ha2UgQ09ORklHX1JFVFBPTElORSBkZXBlbmQg
b24gY29tcGlsZXIgc3VwcG9ydCIpDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBXQU5HIENoYW8gPGNo
YW8ud2FuZ0B1Y2xvdWQuY24+DQo+ID4NCj4gPiBwaW5nIC4uLg0KPiANCj4gVGhpcyBvbmUgc29t
ZWhvdyBzbGlwcGVkIHRocm91Z2ggdGhlIGNyYWNrcy4uLiA6LVwNCj4gDQo+IE9rLCBsZXQncyBz
ZWU6IHRoaXMgY291bGQgYmUgcmVsZXZhbnQgZm9yIHRoZSBjYXNlIHdoZW4gYSBtb2R1bGUgYnVp
bHQNCj4gd2l0aCBhIGNvbXBpbGVyIHdoaWNoIGRvZXNuJ3Qgc3VwcG9ydCByZXRwb2xpbmVzLCBn
ZXRzIGxvYWRlZCBvbiBhDQo+IHN5c3RlbSB3aGljaCBpcyBidWlsdCB3aXRoIHJldHBvbGluZXMu
DQoNCklzbid0IHRoZSByZWFsIHByb2JsZW0gc29tZW9uZSB0YWtpbmcgYSBrZXJuZWwgZnJvbSAo
c2F5KSBrZXJuZWwub3JnDQp0aGF0IGlzIGNvbXBpbGVkIGZvciByZXRwb2xpbmVzIGFuZCB0aGVu
IHRyeWluZyB0byBjb21waWxlIGFuIGFkZGl0aW9uYWwNCm1vZHVsZSBvbiBhIHN5c3RlbSB0aGF0
IGhhcyBhbiBvbGQgY29tcGlsZXI/DQoNCj4gV2hpY2ggaXMgcHJldHR5IHNlbGRvbSBhcyB0aGUg
bWFqb3JpdHkgb2Ygc2V0dXBzIG91dCB0aGVyZSBzaG91bGQgaGF2ZQ0KPiBhIHJldHBvbGluZS1l
bmFibGVkIGNvbXBpbGVyLiBBbmQgc2hvdWxkIG5vdCBhbGxvdyBsb2FkaW5nIGV4dGVybmFsDQo+
IG1vZHVsZXMgYW55d2F5LCBidXQgdGhhdCdzIGEgZGlmZmVyZW50IHN0b3J5Lg0KDQpNb3N0IG9m
IGFuIGV4dGVybmFsIG1vZHVsZSBpcyBsaWtlbHkgdG8gYmUgYSBiaWcgJy5vJyBmaWxlIHRoYXQg
KEkgZXhwZWN0KQ0KaGFzIHRvIGJlIGNvbXBpbGVkIHdpdGhvdXQgcmV0cG9saW5lcyBpbiBvcmRl
ciB0byBiZSBsaW5rYWJsZSBpbnRvIG9sZA0Ka2VybmVscy4NCihFaXRoZXIgdGhhdCBvciBpdCBk
b2Vzbid0IG1hdHRlciBhdCBhbGwgYmVjYXVzZSBpdCBpcyBqdXN0IGEgY2hhbmdlDQp0byB0aGUg
Z2VuZXJhdGVkIGNvZGUuKQ0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2Vz
aWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVL
DQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

