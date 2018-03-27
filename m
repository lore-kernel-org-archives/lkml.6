Return-Path: <kernel-hardening-return-12759-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELs1bCkwV82TNSLzCiBjw9HcRE3LR0LApmx5Dw72FuhdrYPKUZsbyO2WzK5OvPrHrXTs25ZL
ARC-Seal: i=1; a=rsa-sha256; t=1522140920; cv=none;
        d=google.com; s=arc-20160816;
        b=UqgQ21qs2Vt94Ui8A6lxhlYlOs5dZH5XCuu6GoPCu5u5LQIDWIKDKsZ6bZRVBk73pq
         iwj68PBbNgmCHJcTwvLZodYgbrFOUtczN0OZROpya9Aot29MHrv7Q+8GLOj6vMiuGIj6
         kqCFLXkyJ3yftlJ44gp2tfyezXP1cMbPesiU68y8yheFFVTsOXamVFLa34jWpcKO1F66
         wBLMal1d+b7WFSGvwIHIJ9yhdfnlM0hYeufmSc/KH5Uy1v1WfsKKB9vbDz4Sxnl3+sZZ
         ha4jno6x7BWhdeL4YOKqB794d9YPLhaClJuVKC1nabqZvh0co7AWxDcUYBNAsLQ9l6pX
         xTPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=66yfnjcOCm73/NPHBPoC4koPwzYBDad3TOkC4UYuN4o=;
        b=JrBNYVt6N0T5569P561EZL5wLzzE2Vm9ICvOWgIGInXA6HKvcDY+dKUN+n2J73ZDvm
         T0dX6EV9YU4+CLBAr7PNZQdhqFbQprd5lszsvB27+E4ZtCb7fc4mVJU3HCOtUVED7coc
         KYsTlFDGzmgKR9tzTmVLm6pi15j7UvbEV/yHypOU0tFjmXSjWKsbyLOr13ZVZOyl6hWN
         yLS6lM426vOPYzidAvjBVyjQGXMmIctRG41vjL8EwtUUfZdiOk2k0fC39kxIzHIrVjgd
         i6D4fiER1nJHIYpUa/ksobp5waLxoR2cv8K9hfpQjOwHo9BwO/fX+3+mKjpqdhOg4DhD
         7RmA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12759-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12759-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12759-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12759-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: David Laight <David.Laight@ACULAB.COM>
To: 'Kees Cook' <keescook@chromium.org>, Andrew Morton
	<akpm@linux-foundation.org>
CC: Linus Torvalds <torvalds@linux-foundation.org>, Martin Uecker
	<Martin.Uecker@med.uni-goettingen.de>, Josh Poimboeuf <jpoimboe@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Randy Dunlap
	<rdunlap@infradead.org>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	"Ingo Molnar" <mingo@kernel.org>, Ian Abbott <abbotti@mev.co.uk>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>
Subject: RE: [PATCH v6] kernel.h: Retain constant expression output for
 max()/min()
Thread-Topic: [PATCH v6] kernel.h: Retain constant expression output for
 max()/min()
Thread-Index: AQHTxVAsz5P5OiAR50OWAXwjMUtHVqPjxocA
Date: Tue, 27 Mar 2018 08:55:55 +0000
Message-ID: <0c29e85f7fa64ff488d60b0f5647257b@AcuMS.aculab.com>
References: <20180326221554.GA45166@beast>
In-Reply-To: <20180326221554.GA45166@beast>
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
X-GMAIL-THRID: =?utf-8?q?1596040250176531135?=
X-GMAIL-MSGID: =?utf-8?q?1596080437533363511?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogS2VlcyBDb29rDQo+IFNlbnQ6IDI2IE1hcmNoIDIwMTggMjM6MTYNCi4uLg0KPiArI2Rl
ZmluZSBfX3R5cGVjaGVjayh4LCB5KSBcDQo+ICsJCSghIShzaXplb2YoKHR5cGVvZih4KSopMSA9
PSAodHlwZW9mKHkpKikxKSkpDQoNClRoZSB0d28gMSBzaG91bGQgcHJvYmFibHkgYmUgYXQgbGVh
c3QgOCBiZWZvcmUgdGhlIGNvbXBpbGVyIHN0YXJ0cw0KYmxlYXRpbmcgYWJvdXQgYWNjZXNzZXMg
dG8gbWlzYWxpZ25lZCBhZGRyZXNzZXMgYmVpbmcgdW5kZWZpbmVkLg0KDQoJRGF2aWQNCg0K
