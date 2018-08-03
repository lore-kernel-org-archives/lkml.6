Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E36C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 08:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 067792172A
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 08:24:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 067792172A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mut-group.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729876AbeHCKTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 06:19:34 -0400
Received: from mut-gw.mut-group.com ([213.209.114.184]:48108 "EHLO
        mut-gw.mut-group.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727848AbeHCKTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 06:19:34 -0400
Received: from [192.168.20.11] (port=44642 helo=zcom03.mut-group.com)
        by mut-gw.mut-group.com with esmtps (TLSv1.2:AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <mhellwig@mut-group.com>)
        id 1flVNh-0003b1-0v; Fri, 03 Aug 2018 10:24:17 +0200
Received: from ZCOM03.mut-group.com (192.168.20.11) by ZCOM03.mut-group.com
 (192.168.20.11) with Microsoft SMTP Server (TLS) id 15.0.1263.5; Fri, 3 Aug
 2018 10:24:16 +0200
Received: from ZCOM03.mut-group.com ([fe80::6097:6956:3dd6:4960]) by
 ZCOM03.mut-group.com ([fe80::6097:6956:3dd6:4960%12]) with mapi id
 15.00.1263.000; Fri, 3 Aug 2018 10:24:16 +0200
From:   Marcel Hellwig <mhellwig@mut-group.com>
To:     'Eric Dumazet' <eric.dumazet@gmail.com>,
        David Laight <David.Laight@ACULAB.COM>,
        "'davem@davemloft.net'" <davem@davemloft.net>,
        "'kuznet@ms2.inr.ac.ru'" <kuznet@ms2.inr.ac.ru>,
        "'yoshfuji@linux-ipv6.org'" <yoshfuji@linux-ipv6.org>,
        "'andrew@lunn.ch'" <andrew@lunn.ch>
CC:     "'netdev@vger.kernel.org'" <netdev@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "Matthias Wystrik" <mwystrik@mut-group.com>
Subject: AW: AW: AW: PROBLEM: Kernel Oops in UDP stack
Thread-Topic: AW: AW: PROBLEM: Kernel Oops in UDP stack
Thread-Index: AQHUKnKCJJXaQYccoUSfJCnigX5tbaStr3WA
Date:   Fri, 3 Aug 2018 08:24:16 +0000
Message-ID: <936fbc1f39424adea318bcd95f50d63d@ZCOM03.mut-group.com>
References: <18092446dfa7435aaa8deaab65afbf23@ZCOM03.mut-group.com>
 <f1940127-7307-e1ba-7a05-075680a6d3c1@gmail.com>
 <b8ceab2531f345d295686903b003787b@ZCOM03.mut-group.com>
 <96753ca4-88fe-aa26-b439-6e22eaf8b524@gmail.com>
 <9f9d731107594b368504cbbaf698bc3d@ZCOM03.mut-group.com>
 <d16f03bf47b24313ad9f2ff4e37d6274@AcuMS.aculab.com>
 <405319c1-2fa0-e1b5-7173-b19d9769d98a@gmail.com>
 <18341daf5b2c458db8e30299d6cddafc@ZCOM03.mut-group.com>
 <b297c600-1600-3560-7f2e-6d504529e0db@gmail.com>
In-Reply-To: <b297c600-1600-3560-7f2e-6d504529e0db@gmail.com>
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

Pg0KPldlbGwsIHRoaXMgZHJpdmVyIGRvZXMgbm90IHVzZSBORVRfSVBfQUxJR04gcmVzZXJ2YXRp
b24sIG1lYW5pbmcgSVAgaGVhZGVyIGlzIG5vdCA0LWJ5dGUgYWxpZ25lZC4NCj4NCj5ObyBpZGVh
IHdoeSBtaXMtYWxpZ25tZW50cyBhcmUgb2theSBpbiBJUCBsYXllciwgYnV0IG5vdCBpbiBVRFAN
Cj4NCj5Zb3UgY291bGQgdHJ5IHRvIHBhdGNoIGl0IHRvIHVzZSBuZXRkZXZfYWxsb2Nfc2tiX2lw
X2FsaWduKCkgaW5zdGVhZCBvZiBkZXZfYWxsb2Nfc2tiKCkNCg0KTG9va3MgdmVyeSBwcm9taXNp
bmchIENQVSBydW5zIGZvciAzIGhvdXJzIGFuZCBubyBwYW5pYyBzbyBmYXIuIExldCdzIGhvcGUg
aXQgc3Vydml2ZXMgdGhlIHdlZWtlbmQhICpmaW5nZXJzIGNyb3NzZWQqDQpUaGUgc3RyYW5nZSB0
aGluZyBJIGRvbid0IHVuZGVyc3RhbmQgaXMsIHdoeSBkb2VzIHRoZSAzLjUuNyBrZXJuZWwgZG9l
cyBub3QgY3Jhc2ggKG9yIDQuMTcuMTIsIHllcyBJIG1hbmFnZWQgdG8gcnVuIGEgcmVjZW50IGtl
cm5lbCBvbiBvdXIgbWFjaGluZSEgXG8vICk/IEl0IGRvZXMgbm90IHVzZSBuZXRkZXZfYWxsb2Nf
c2tiX2lwX2FsaWduIGVpdGhlclswXVsxXSwgYnV0IG9uZSB0aGluZywgdGhhdCBJIG5vdGljZWQg
aXQsIHRoYXQgdGhlcmUgaXMgYSBkaWZmZXJlbmNlIGluIC9wcm9jL2lvbWVtDQoNCjMuNC4xMTMN
CiMgY2F0IC9wcm9jL2lvbWVtDQowODAwMDAwMC0wODAxZmZmZiA6IGxwYy1ldGguMA0KMzEwNjAw
MDAtMzEwNjBmZmYgOiBscGMtZXRoLjANCjQwMDg4MDAwLTQwMDg4MDFmIDogc2VyaWFsDQpbLi4u
XQ0KDQozLjUuNw0KIyBjYXQgL3Byb2MvaW9tZW0NCjIwMDg0MDAwLTIwMDg0ZmZmIDogL2FoYi9h
cGIvc3NwQDIwMDg0MDAwDQoyMDA4YzAwMC0yMDA4Y2ZmZiA6IC9haGIvYXBiL3NzcEAyMDA4YzAw
MA0KMzEwMDAwMDAtMzEwMDBmZmYgOiAvYWhiL2RtYUAzMTAwMDAwMA0KNDAwODgwMDAtNDAwODgw
MWYgOiBzZXJpYWwNClsuLi5dDQoNCkFzIHlvdSBub3RpY2UgbHBjLWV0aC4wIChvciAzMTA2MDAw
MC5ldGhlcm5ldCBhcyBpdCdzIGNhbGxlZCBub3dhZGF5cykgaXMgbm90IGxpc3RlZCwgc28gbXkg
Z3Vlc3MgaXQgaXMgc2VydmVkIGJ5IERNQT8NCg0KTWF5IHRoYXQgdGhlIHJlYXNvbiB3aHkgaXQg
ZG9lcyBub3QgY3Jhc2ggKE5vdGljZTogMy41LjcgcnVucyB2aWEgZGV2aWNlIHRyZWUgZmlsZSk/
DQoNClNvIGp1c3QgbXkgdGhvdWdodDogSWYgSSB3b3VsZCBkaXNhYmxlIGRtYSAoc29tZWhvdykg
d291bGQgdGhlIGVycm9yIHN0aWxsIG9jY3VyIGluIHRvZGF5J3Mga2VybmVsPw0KDQoNClswXTog
aHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjMuNS43L3NvdXJjZS9kcml2ZXJzL25l
dC9ldGhlcm5ldC9ueHAvbHBjX2V0aC5jI0wxMDAzDQpbMV06IGh0dHBzOi8vZWxpeGlyLmJvb3Rs
aW4uY29tL2xpbnV4L3Y0LjE3LjEyL3NvdXJjZS9kcml2ZXJzL25ldC9ldGhlcm5ldC9ueHAvbHBj
X2V0aC5jI0w5NTcNCg0KDQpNaXQgZnJldW5kbGljaGVuIEdyw7zDn2VuIC8gV2l0aCBraW5kIHJl
Z2FyZHMgDQoNCk1hcmNlbCBIZWxsd2lnDQpCLiBTYy4gSW5mb3JtYXRpaw0KRW50d2lja2xlcg0K
DQptLXUtdMKgR21iSA0KQW0gTWFyaWVuaG9mIDINCjIyODgwIFdlZGVsDQpHZXJtYW55DQoNClBo
b25lOgkrNDkgNDEwMyA5MzA4IC0gNDc0DQpGYXg6wqDCoAkrNDkgNDEwMyA5MzA4IC0gOTkNCm1o
ZWxsd2lnQG11dC1ncm91cC5jb20NCg0Kd3d3Lm11dC1ncm91cC5jb20NCg0KR2VzY2jDpGZ0c2bD
vGhyZXLCoChNYW5hZ2luZyBEaXJlY3Rvcik6IEZhYmlhbiBQZXRlcnMNCkFtdHNnZXJpY2h0IFBp
bm5lYmVyZyAoQ29tbWVyY2lhbCBSZWdpc3RlciBOby4pOiBIUkLCoDEwMzA0IFBJDQpVU3QtSWRO
ci4gKFZBVC1Oby4pOiBERTIyODI3NTM5MA0KV0VFRS1SZWctTnIuOiBERSA3MjI3MTgwOA0K
