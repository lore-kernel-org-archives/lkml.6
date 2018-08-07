Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D3FC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 13:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3151821770
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 13:43:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3151821770
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mut-group.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389323AbeHGP52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 11:57:28 -0400
Received: from mut-gw.mut-group.com ([213.209.114.184]:41709 "EHLO
        mut-gw.mut-group.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731069AbeHGP51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 11:57:27 -0400
Received: from [192.168.20.11] (port=46917 helo=zcom03.mut-group.com)
        by mut-gw.mut-group.com with esmtps (TLSv1.2:AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <mhellwig@mut-group.com>)
        id 1fn2GE-0004IV-1B; Tue, 07 Aug 2018 15:42:54 +0200
Received: from ZCOM03.mut-group.com (192.168.20.11) by ZCOM03.mut-group.com
 (192.168.20.11) with Microsoft SMTP Server (TLS) id 15.0.1263.5; Tue, 7 Aug
 2018 15:42:53 +0200
Received: from ZCOM03.mut-group.com ([fe80::6097:6956:3dd6:4960]) by
 ZCOM03.mut-group.com ([fe80::6097:6956:3dd6:4960%12]) with mapi id
 15.00.1263.000; Tue, 7 Aug 2018 15:42:53 +0200
From:   Marcel Hellwig <mhellwig@mut-group.com>
To:     'Eric Dumazet' <eric.dumazet@gmail.com>,
        'David Laight' <David.Laight@ACULAB.COM>,
        "'davem@davemloft.net'" <davem@davemloft.net>,
        "'kuznet@ms2.inr.ac.ru'" <kuznet@ms2.inr.ac.ru>,
        "'yoshfuji@linux-ipv6.org'" <yoshfuji@linux-ipv6.org>,
        "'andrew@lunn.ch'" <andrew@lunn.ch>
CC:     "'netdev@vger.kernel.org'" <netdev@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "Matthias Wystrik" <mwystrik@mut-group.com>
Subject: AW: AW: AW: PROBLEM: Kernel Oops in UDP stack
Thread-Topic: AW: AW: PROBLEM: Kernel Oops in UDP stack
Thread-Index: AQHUKnKCJJXaQYccoUSfJCnigX5tbaStr3WAgAaizRA=
Date:   Tue, 7 Aug 2018 13:42:53 +0000
Message-ID: <b8b9b9f905164e36a8fea24aa84e124a@ZCOM03.mut-group.com>
References: <18092446dfa7435aaa8deaab65afbf23@ZCOM03.mut-group.com>
 <f1940127-7307-e1ba-7a05-075680a6d3c1@gmail.com>
 <b8ceab2531f345d295686903b003787b@ZCOM03.mut-group.com>
 <96753ca4-88fe-aa26-b439-6e22eaf8b524@gmail.com>
 <9f9d731107594b368504cbbaf698bc3d@ZCOM03.mut-group.com>
 <d16f03bf47b24313ad9f2ff4e37d6274@AcuMS.aculab.com>
 <405319c1-2fa0-e1b5-7173-b19d9769d98a@gmail.com>
 <18341daf5b2c458db8e30299d6cddafc@ZCOM03.mut-group.com>
 <b297c600-1600-3560-7f2e-6d504529e0db@gmail.com>
 <936fbc1f39424adea318bcd95f50d63d@ZCOM03.mut-group.com>
In-Reply-To: <936fbc1f39424adea318bcd95f50d63d@ZCOM03.mut-group.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.168.21.69]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4NCj4+IFdlbGwsIHRoaXMgZHJpdmVyIGRvZXMgbm90IHVzZSBORVRfSVBfQUxJR04gcmVzZXJ2
YXRpb24sIG1lYW5pbmcgSVAgaGVhZGVyIGlzIG5vdCA0LWJ5dGUgYWxpZ25lZC4NCj4+DQo+PiBO
byBpZGVhIHdoeSBtaXMtYWxpZ25tZW50cyBhcmUgb2theSBpbiBJUCBsYXllciwgYnV0IG5vdCBp
biBVRFANCj4+DQo+PiBZb3UgY291bGQgdHJ5IHRvIHBhdGNoIGl0IHRvIHVzZSBuZXRkZXZfYWxs
b2Nfc2tiX2lwX2FsaWduKCkgaW5zdGVhZCBvZiBkZXZfYWxsb2Nfc2tiKCkNCj4gDQo+IExvb2tz
IHZlcnkgcHJvbWlzaW5nISBDUFUgcnVucyBmb3IgMyBob3VycyBhbmQgbm8gcGFuaWMgc28gZmFy
LiBMZXQncyBob3BlIGl0IHN1cnZpdmVzIHRoZSB3ZWVrZW5kISAqZmluZ2VycyBjcm9zc2VkKiBU
aGUgc3RyYW5nZSB0aGluZyBJIGRvbid0IHVuZGVyc3RhbmQgaXMsIHdoeSBkb2VzIHRoZSAzLjUu
NyBrZXJuZWwgZG9lcyBub3QgY3Jhc2ggKG9yIDQuMTcuMTIsIHllcyBJIG1hbmFnZWQgdG8gcnVu
IGEgcmVjZW50IGtlcm5lbCBvbiBvdXIgbWFjaGluZSEgXG8vICk/IEl0IGRvZXMgbm90IHVzZSBu
ZXRkZXZfYWxsb2Nfc2tiX2lwX2FsaWduIGVpdGhlclswXVsxXSwgYnV0IG9uZSB0aGluZywgdGhh
dCBJIG5vdGljZWQgaXQsIHRoYXQgdGhlcmUgaXMgYSBkaWZmZXJlbmNlIGluIC9wcm9jL2lvbWVt
DQo+IA0KPiAzLjQuMTEzDQo+ICMgY2F0IC9wcm9jL2lvbWVtDQo+IDA4MDAwMDAwLTA4MDFmZmZm
IDogbHBjLWV0aC4wDQo+IDMxMDYwMDAwLTMxMDYwZmZmIDogbHBjLWV0aC4wDQo+IDQwMDg4MDAw
LTQwMDg4MDFmIDogc2VyaWFsDQo+IFsuLi5dDQo+IA0KPiAzLjUuNw0KPiAjIGNhdCAvcHJvYy9p
b21lbQ0KPiAyMDA4NDAwMC0yMDA4NGZmZiA6IC9haGIvYXBiL3NzcEAyMDA4NDAwMA0KPiAyMDA4
YzAwMC0yMDA4Y2ZmZiA6IC9haGIvYXBiL3NzcEAyMDA4YzAwMA0KPiAzMTAwMDAwMC0zMTAwMGZm
ZiA6IC9haGIvZG1hQDMxMDAwMDAwDQo+IDQwMDg4MDAwLTQwMDg4MDFmIDogc2VyaWFsDQo+IFsu
Li5dDQo+IA0KPiBBcyB5b3Ugbm90aWNlIGxwYy1ldGguMCAob3IgMzEwNjAwMDAuZXRoZXJuZXQg
YXMgaXQncyBjYWxsZWQgbm93YWRheXMpIGlzIG5vdCBsaXN0ZWQsIHNvIG15IGd1ZXNzIGl0IGlz
IHNlcnZlZCBieSBETUE/DQo+IA0KPiBNYXkgdGhhdCB0aGUgcmVhc29uIHdoeSBpdCBkb2VzIG5v
dCBjcmFzaCAoTm90aWNlOiAzLjUuNyBydW5zIHZpYSBkZXZpY2UgdHJlZSBmaWxlKT8NCj4gDQo+
IFNvIGp1c3QgbXkgdGhvdWdodDogSWYgSSB3b3VsZCBkaXNhYmxlIGRtYSAoc29tZWhvdykgd291
bGQgdGhlIGVycm9yIHN0aWxsIG9jY3VyIGluIHRvZGF5J3Mga2VybmVsPw0KDQpJIHRoaW5rLCB0
aGF0IGl0IGlzIGltcGxpY2l0bHkgYWxpZ25lZCB0b2RheSAoSSB0aGluayEpLCBzbyB0aGF0J3Mg
dGhlIHJlYXNvbiB3aHkgdGhlIG9vcHMgZG9lcyBub3Qgb2NjdXIgYW55bW9yZS4NCg0KT3VyIG1h
Y2hpbmVzIHN1cnZpdmVkIHRoZSA0IGRheXMgbm93LCBzbyB3ZSBhcmUgdmVyeSBjb25maWRlbnQs
IHRoYXQgdGhpcyBzb2x2ZWQgdGhlIHByb2JsZW0gZm9yIHVzIQ0KDQpUaGFuayB5b3UgdmVyeSBt
dWNoLCB5b3UgYWxsIGhlbHBlZCB1cyBhIGxvdCEgDQoNCk1pdCBmcmV1bmRsaWNoZW4gR3LDvMOf
ZW4gLyBXaXRoIGtpbmQgcmVnYXJkcyANCg0KTWFyY2VsIEhlbGx3aWcNCkIuIFNjLiBJbmZvcm1h
dGlrDQpFbnR3aWNrbGVyDQoNCm0tdS10wqBHbWJIDQpBbSBNYXJpZW5ob2YgMg0KMjI4ODAgV2Vk
ZWwNCkdlcm1hbnkNCg0KUGhvbmU6CSs0OSA0MTAzIDkzMDggLSA0NzQNCkZheDrCoMKgCSs0OSA0
MTAzIDkzMDggLSA5OQ0KbWhlbGx3aWdAbXV0LWdyb3VwLmNvbQ0KDQp3d3cubXV0LWdyb3VwLmNv
bQ0KDQpHZXNjaMOkZnRzZsO8aHJlcsKgKE1hbmFnaW5nIERpcmVjdG9yKTogRmFiaWFuIFBldGVy
cyBBbXRzZ2VyaWNodCBQaW5uZWJlcmcgKENvbW1lcmNpYWwgUmVnaXN0ZXIgTm8uKTogSFJCwqAx
MDMwNCBQSSBVU3QtSWROci4gKFZBVC1Oby4pOiBERTIyODI3NTM5MA0KV0VFRS1SZWctTnIuOiBE
RSA3MjI3MTgwOA0K
