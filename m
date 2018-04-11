Return-Path: <kernel-hardening-return-12978-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx482dWia6R/Aglf856fi+0OHmO7vsQxTIPad4EfHsZppAOlYTfHqvgNYdBqOHRgehZ+iUy0Q
ARC-Seal: i=1; a=rsa-sha256; t=1523463604; cv=none;
        d=google.com; s=arc-20160816;
        b=ct9BxnnxKcfUlg3we/GsH9j13QKsRZfEFvNSsz+F/6jqkWN42wu0rtst+X51gLQ/mR
         TU8mUanLznlQybRoJ24uNTLlIJqS2Sk6r+HYAhUbz70yQ4CHlRxZVxdCnp8KKatRM4Kq
         n/Fgj9SQkRwWzFe/eeiT1/QEgYcabUElD3H6t2TZmjWvuIFlPjYySmpwgGXSMYqXQl88
         LVLG33YbSrtnwM4zdB/BBSwBrMbAeWsdt3sgh+RN48eKj1ECF5cweg91EnsmrsvqBPcn
         LhgN1JWMTMWy7+rzBUpvOlzPVjeZGu3HWRu9wRY0scMKRGWgVWlr9B+dUTMli7oohlMB
         el8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=iyNwC+nQqEgdt7yZC9XzFDzUC68kGobUruJhRw68COw=;
        b=hZ23FwF2OoUnClVtivYCdxY5IDNYPQlHhI6vdj8gMJo5aHuUHIXkJcI+Xvpc/BV8oi
         5Exy8o+WtI1OuUyYdPx792+tyIuoVbEql2GxGSeWF2qSf3++vCyZ1PXZ1CGH/rCoY7m3
         f8rBsfqs4HS85I3swNAfiPH+C3mJF7bPVrb8kU1b04m9KOD1yjaxteB+rhZ1/DxUpODY
         PzhSYJTjjo/mtSOUOtz2CcUg/8qTt/KElB9wCjENUBAyyjaMHqU0/i8WSnwoD94f7jp4
         NpoYXM8ENMJZykHwBModTjcaa0d6iTiDq8OnkdZfdwXJshvvCptlKGcYrlrndi22cprA
         y4TQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12978-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12978-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12978-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12978-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: David Laight <David.Laight@ACULAB.COM>
To: 'Salvatore Mesoraca' <s.mesoraca16@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Herbert Xu <herbert@gondor.apana.org.au>,
	"Kees Cook" <keescook@chromium.org>, Eric Biggers <ebiggers3@gmail.com>,
	"Laura Abbott" <labbott@redhat.com>
Subject: RE: [PATCH v2 0/2] crypto: removing various VLAs
Thread-Topic: [PATCH v2 0/2] crypto: removing various VLAs
Thread-Index: AQHT0AqPFLFjzadDvEuYJrE7teT3QaP4fQXggAAUdgCAAyxe0A==
Date: Wed, 11 Apr 2018 16:20:42 +0000
Message-ID: <43fc1586cc5247df860e592f37b170a3@AcuMS.aculab.com>
References: <1523282087-22128-1-git-send-email-s.mesoraca16@gmail.com>
 <ca31b95a8b8e4dab90c5ea2eb6e6477f@AcuMS.aculab.com>
 <CAJHCu1+YynzroRkfZC9ki0b=RwiDOoOJB0S97uUVWSxLgac74A@mail.gmail.com>
In-Reply-To: <CAJHCu1+YynzroRkfZC9ki0b=RwiDOoOJB0S97uUVWSxLgac74A@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Outbound-IP: 156.67.243.126
X-Env-From: David.Laight@ACULAB.COM
X-Proto: esmtps
X-Revdns: 
X-HELO: AcuMS.aculab.com
X-TLS: TLSv1.2:ECDHE-RSA-AES256-SHA384:256
X-Authenticated_ID: 
X-PolicySMART: 3396946, 3397078
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597277119052489301?=
X-GMAIL-MSGID: =?utf-8?q?1597467372988585147?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogU2FsdmF0b3JlIE1lc29yYWNhDQo+IFNlbnQ6IDA5IEFwcmlsIDIwMTggMTc6MzgNCi4u
Lg0KPiA+IFlvdSBjYW4gYWxzbyBkbyBtdWNoIGJldHRlciB0aGFuIGFsbG9jYXRpbmcgTUFYX0JM
T0NLU0laRSArIE1BWF9BTElHTk1BU0sNCj4gPiBieXRlcyBieSByZXF1ZXN0aW5nICdsb25nJyBh
bGlnbmVkIG9uLXN0YWNrIG1lbW9yeS4NCj4gPiBUaGUgZWFzaWVzdCB3YXkgaXMgdG8gZGVmaW5l
IGEgdW5pb24gbGlrZToNCj4gPg0KPiA+IHVuaW9uIGNyeXB0b190bXAgew0KPiA+ICAgICAgICAg
dTggYnVmW0NSWVBUT19NQVhfVE1QX0JVRl07DQo+ID4gICAgICAgICBsb25nIGJ1Zl9hbGlnbjsN
Cj4gPiB9Ow0KPiA+DQo+ID4gVGhlbiBpbiBlYWNoIGZ1bmN0aW9uOg0KPiA+DQo+ID4gICAgICAg
ICB1bmlvbiB0bXAgY3J5cHRvX3RtcDsNCj4gPiAgICAgICAgIHU4ICprZXlzdHJlYW0gPSBQVFJf
QUxJR04odG1wLmJ1ZiwgYWxpZ25tYXNrICsgMSk7DQo+ID4NCj4gPiBJIHRoaW5rIENSWVBUT19N
QVhfVE1QX0JVRiBuZWVkcyB0byBiZSBNQVhfQkxPQ0tTSVpFICsgTUFYX0FMSUdOTUFTSyAtIHNp
emVvZiAobG9uZykuDQo+IA0KPiBZZWFoLCB0aGF0IHdvdWxkIGJlIG5pY2UsIGl0IG1pZ2h0IHNh
dmUgdXMgNC04IGJ5dGVzIG9uIHRoZSBzdGFjay4NCj4gQnV0IEkgd2FzIHRoaW5raW5nLCB3b3Vs
ZG4ndCBpdCBiZSBldmVuIGJldHRlciB0byBkbyBzb21ldGhpbmcgbGlrZToNCj4gDQo+IHU4IGJ1
ZltDUllQVE9fTUFYX1RNUF9CVUZdIF9fYWxpZ25lZChfX2FsaWdub2ZfXyhsb25nKSk7DQo+IHU4
ICprZXlzdHJlYW0gPSBQVFJfQUxJR04oYnVmLCBhbGlnbm1hc2sgKyAxKTsNCj4gDQo+IEluIHRo
aXMgY2FzZSBfX2FsaWduZWQgc2hvdWxkIHdvcmssIGlmIEknbSBub3QgbWlzc2luZyBzb21lIG90
aGVyDQo+IHN1YnRsZSBHQ0MgY2F2ZWF0Lg0KDQpUaGlua2luZyBmdXJ0aGVyLCB0aGVyZSBpcyBu
byBwb2ludCBhbGlnbmluZyB0aGUgYnVmZmVyIHRvIGxlc3MgdGhhbg0KdGhlIG1heGltdW0gYWxp
Z25tZW50IGFsbG93ZWQgLSBpdCBqdXN0IGFkZHMgY29kZS4NCg0KU28geW91IGVuZCB1cCB3aXRo
Og0KI2RlZmluZSBNQVhfU1RBQ0tfQUxJR04gX19hbGlnbm9mX18obG9uZykgIC8qIExhcmdlc3Qg
dHlwZSB0aGUgY29tcGlsZXIgY2FuIGFsaWduIG9uIHN0YWNrICovDQojZGVmaW5lIENSWVBUT19N
QVhfVE1QX0JVRiAoTUFYX0JMT0NLU0laRSArIE1BWF9BTElHTk1BU0sgKyAxIC0gTUFYX1NUQUNL
X0FMSUdOKQ0KdTggYnVmW0NSWVBUT19NQVhfVE1QX0JVRl0gX19hbGlnbmVkKE1BWF9TVEFDS19B
TElHTik7DQp1OCAqa2V5c3RyZWFtID0gUFRSX0FMSUdOKGJ1ZiwgTUFYX0FMSUdOTUFTSyArIDEp
Ow0KDQpUaGUgbGFzdCB0d28gbGluZXMgY291bGQgYmUgcHV0IGludG8gYSAjZGVmaW5lIG9mIHRo
ZWlyIG93biBzbyB0aGF0IHRoZSAnY2FsbCBzaXRlcycNCmRvbid0IG5lZWQgdG8ga25vdyB0aGUg
Z29yeSBkZXRhaWxzIG9mIGhvdyB0aGUgYnVmZmVyIGlzIGRlZmluZWQuDQoNCkluIHByaW5jaXBs
ZSB5b3UgY291bGQganVzdCBoYXZlOg0KdTgga2V5c3RyZWFtW01BWF9CTE9DS1NJWkVdIF9fYWxp
Z25lZChNQVhfQUxJR05NQVNLICsgMSk7DQoNCkJ1dCB0aGF0IHdpbGwgZ28gd3JvbmcgaWYgdGhl
IHN0YWNrIGFsaWdubWVudCBoYXMgZ29uZSB3cm9uZyBzb21ld2hlcmUNCmFuZCBnZW5lcmF0ZXMg
YSBkb3VibGUgc3RhY2sgZnJhbWUgaWYgdGhlIHJlcXVlc3RlZCBhbGlnbm1lbnQgaXMgbGFyZ2Vy
DQp0aGFuIHRoZSBleHBlY3RlZCBzdGFjayBhbGlnbm1lbnQuDQoNCklJUkMgdGhlcmUgaXMgYSBn
Y2MgY29tbWFuZCBsaW5lIG9wdGlvbiB0byBlbmZvcmNlIHN0YWNrIGFsaWdubWVudCBvbg0Kc29t
ZS9hbGwgZnVuY3Rpb24gZW50cnkgcHJvbG9ndWVzLiBUaGUgZ29yeSBkZXRhaWxzIGFyZSBoZWxk
IGluIHNvbWUNCm9sZCBicmFpbiBjZWxscyBzb21ld2hlcmUuDQoNCglEYXZpZA0KDQo=
