Return-Path: <kernel-hardening-return-12764-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx49Cq2zYl+4iWiVGx7gmy3Do7lRtGX2fLzUq3SI5VPFWir30gYTqUXb7zWA9fB67MXiO4gDA
ARC-Seal: i=1; a=rsa-sha256; t=1522155802; cv=none;
        d=google.com; s=arc-20160816;
        b=Ea90KLtyjfCfk8weqpaDwUIilTIuncPxhokRy2439bI2e/sHK6iVV2srCtDQjwKokv
         FWdoGPF75fPKsRCRzg0r77cqVY86pxMGN8197j+8dwdi38e1B3bXwpOFhdyi5eq06/ca
         9Uyy6MF39lEludE5ElshvaLQxCRs6hyr7d4OntlwF/2zEm9n/qpFlf87KwyzQqnbHnYY
         9GgkNpkyzFBVnoS6EJo5rYQyhtaZCLXVrI17EVoXGKjBHkK7TihEveHWqiqSFiXf/cov
         T8IFwuoSU+RS1qeGVD6vgE73VTBU7vpMFB/l23JEsT2nZ8GeiDtsg2gGzT8WVxIdCLpT
         0wMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:delivered-to:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=MpLfaKk2vPFGEICrrcV2spSXAIfjb7ZiGISPS7al+To=;
        b=U2xXybfqgWOPUYxBZNT5qZ2tN1e68qJcMY/5zCr/waej+xjejmfgu7wBpd9Nwvfm3s
         srDXwvPOVHxbBDrW+zF2CiBYtdsZEBPkytXq6o1/z6AdVbsQdpk6aX3wS2Sq3tqdMsTv
         qQzcLCX5Pl8u5VZEqRQ4dzTmDBGkim47kRFDgxU61Lt9bzM/B+tJ5Od3VPanPLG2+aBy
         pWSM2PZnaHxH/6SJErlSb0sG2ShGGj0v66tvqMzgjOjTBq6KQvjBUAqNmIMnG6peAiaP
         9T8jy0t0XPOfNFy2zDFzs3o+UbPI5LZKDbvdgPnWfDDE8SilMLYAwkTcRvSq31fKZ3Bc
         nTbA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12764-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12764-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12764-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12764-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: "Uecker, Martin" <Martin.Uecker@med.uni-goettingen.de>
To: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
	"keescook@chromium.org" <keescook@chromium.org>
CC: "mingo@kernel.org" <mingo@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "rdunlap@infradead.org"
	<rdunlap@infradead.org>, "abbotti@mev.co.uk" <abbotti@mev.co.uk>,
	"linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
	"miguel.ojeda.sandonis@gmail.com" <miguel.ojeda.sandonis@gmail.com>,
	"jpoimboe@redhat.com" <jpoimboe@redhat.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "kernel-hardening@lists.openwall.com"
	<kernel-hardening@lists.openwall.com>, "David.Laight@aculab.com"
	<David.Laight@aculab.com>
Subject: Re: [PATCH v6] kernel.h: Retain constant expression output for
 max()/min()
Thread-Topic: [PATCH v6] kernel.h: Retain constant expression output for
 max()/min()
Thread-Index: AQHTxVAGCQPCWmK6BEGtdds0lH0BrqPjH4AAgAC63oA=
Date: Tue, 27 Mar 2018 12:00:55 +0000
Message-ID: <1522152055.3889.4.camel@med.uni-goettingen.de>
References: <20180326221554.GA45166@beast>
	 <CA+55aFw2Jn=ispuj1Xzj_RwPPMR3-1eYTi+BFo+2-d07AJBQJw@mail.gmail.com>
In-Reply-To: <CA+55aFw2Jn=ispuj1Xzj_RwPPMR3-1eYTi+BFo+2-d07AJBQJw@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.76.125.21]
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC226295E504114E82616A96029D541D@ads.local.med.uni-goettingen.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596040250176531135?=
X-GMAIL-MSGID: =?utf-8?q?1596096042480241202?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

DQpUbyBnaXZlIGNyZWRpdCB3aGVyZSBjcmVkaXQgaXMgZHVlLCB0aGlzIGhhY2sgd2FzIGluc3Bp
cmVkIGJ5wqANCmFuIGVxdWFsbHkgaW5zYW5lIChidXQgZGlmZmVyZW50KSB1c2Ugb2YgdGhlID86
IG9wZXJhdG9yIHRvIGNob29zZcKgDQp0aGUgcmlnaHQgcmV0dXJuIHR5cGUgZm9yIHR5cGUtZ2Vu
ZXJpYyBtYWNyb3MgaW4gdGdtYXRoLmguDQoNCmh0dHBzOi8vc291cmNld2FyZS5vcmcvZ2l0Lz9w
PWdsaWJjLmdpdDthPWJsb2I7Zj1tYXRoL3RnbWF0aC5oO2g9YTcwOWE1DQo5ZDBmYTExNjhlZjAz
MzQ5NTYxMTY5ZmM1YmQyN2Q2NWFhO2hiPWQ4NzQyZGQ4MmY2YTAwNjAxMTU1YzY5YmFkMzAxMmU5
MA0KNTU5MWUxZg0KDQoocmVjb21tZW5kYXRpb246IGRvbid0IGxvb2spDQoNCk1hcnRpbg0KDQoN
CkFtIE1vbnRhZywgZGVuIDI2LjAzLjIwMTgsIDE0OjUyIC0xMDAwIHNjaHJpZWIgTGludXMgVG9y
dmFsZHM6DQo+IE9uIE1vbiwgTWFyIDI2LCAyMDE4IGF0IDEyOjE1IFBNLCBLZWVzIENvb2sgPGtl
ZXNjb29rQGNocm9taXVtLm9yZz4NCj4gd3JvdGU6DQo+ID4gDQo+ID4gVGhpcyBwYXRjaCB1cGRh
dGVzIHRoZSBtaW4oKS9tYXgoKSBtYWNyb3MgdG8gZXZhbHVhdGUgdG8gYSBjb25zdGFudA0KPiA+
IGV4cHJlc3Npb24gd2hlbiBjYWxsZWQgb24gY29uc3RhbnQgZXhwcmVzc2lvbiBhcmd1bWVudHMu
DQo+IA0KPiBBY2suDQo+IA0KPiBJJ20gb2YgdHdvIG1pbmRzIHdoZXRoZXIgdGhhdCAiX19pc19j
b25zdGFudCgpIiBtYWNybyBzaG91bGQgYmUNCj4gZXhwbGFpbmVkIG9yIG5vdC4NCj4gDQo+IEEg
c21hbGwgdm9pY2UgaW4gbXkgaGVhZCBzYXlzICJ0aGF0IHdhbnRzIGEgY29tbWVudCIuDQo+IA0K
PiBCdXQgYSBiaWdnZXIgdm9pY2UgZGlzYWdyZWVzLg0KPiANCj4gSXQgaXMgYSB3b3JrIG9mIGFy
dCwgYW5kIG1heWJlIHRoZSBiZXN0IGRvY3VtZW50YXRpb24gaXMganVzdCB0aGUNCj4gbmFtZS4g
SXQgZG9lcyB3aGF0IGl0IHNheXMgaXQgZG9lcy4NCj4gDQo+IEFydCBzaG91bGRuJ3QgYmUgZXhw
bGFpbmVkLiBJdCBzaG91bGQgYmUgYXBwcmVjaWF0ZWQuDQo+IA0KPiBOb2JvZHkgc2FuZSByZWFs
bHkgc2hvdWxkIGNhcmUgYWJvdXQgaG93IGl0IHdvcmtzLCBhbmQgaWYgc29tZWJvZHkNCj4gY2Fy
ZXMgaXQgaXMgImxlZnQgYXMgYW4gZXhlcmNpc2UgdG8gdGhlIHJlYWRlciIuDQo+IA0KPiDCoMKg
wqDCoMKgwqBMaW51cw==
