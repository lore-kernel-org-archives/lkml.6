Return-Path: <kernel-hardening-return-12667-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELs+YFPewr6ktXQEzfE/fO6t0W+WNVxFFDZiXmUAk1cy7bC7kohLqBv1jktp3vCuGC8yNiiY
ARC-Seal: i=1; a=rsa-sha256; t=1521222263; cv=none;
        d=google.com; s=arc-20160816;
        b=APMupvOPyQeYu/XmV2vCIucCulq5RhTWxWBBS/ggNI1CUCGreLfU14eHzr++9RnbEq
         aPXGch/sK65WUg6tI4E01FWNwLQ7d3KOxHChce+uPN+ivoJbPb1qA0FiKl3vzyGbBIOQ
         wfilep2wctxri0yQGSTR+xqCKukPnW6xjj5+gkS00qlO8mhlVwRqpu5x72oycYXdTi6t
         WqTpwBfIwph8bHw3eIn6Pk4c+guPogNp3vikwwnatXxd8wSjrEfb4SqzVNTEHNYfEAdj
         zSg9SOwtA0kC9J9O8eNx6Xc+8DEOF+Zqnnum1dSJNZHVcl05ZcL14J6SPyUpFFyRCQz4
         f33Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=rtsDxb1lV5DluwCfvrMI3e3eXFVHt+HaR5cO0091W30=;
        b=oRZGH0qfRSPyjOXDxwnJYpRD9EJgntZzh32rombP9wPn4Zja5V/mEgpzijSkWMqo76
         niZbubIQ+HabGx53dTN5l2ZTc2c8V0Av8Eipvaffc9h4NztcR7RFnIP3Pb9STr0Rw4d8
         XzcFtHc8tdeLSlayv+gs3aqiBLLigFYjUjDX/YrY17nWzQLq+hDxN/cdxSymsIHMaR/w
         bVsgfeElkIcxTpsAj4RMMscU+hTh5T0LdNHYhnO/HYnqpac+EEYnhzjhhAeNt86BOqEo
         m/GWyqar0uWh8p+2uO+TMBsK2HYuIJY9BpOT0EmH5FKvvWy029WGVDFi9bdKOPqN0q0M
         aPNg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12667-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12667-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12667-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12667-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: David Laight <David.Laight@ACULAB.COM>
To: 'Linus Torvalds' <torvalds@linux-foundation.org>, Florian Weimer
	<fweimer@redhat.com>
CC: Kees Cook <keescook@chromium.org>, Andrew Morton
	<akpm@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, "Rasmus
 Villemoes" <linux@rasmusvillemoes.dk>, Randy Dunlap <rdunlap@infradead.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Ingo Molnar
	<mingo@kernel.org>, Ian Abbott <abbotti@mev.co.uk>, linux-input
	<linux-input@vger.kernel.org>, linux-btrfs <linux-btrfs@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>, Kernel Hardening
	<kernel-hardening@lists.openwall.com>
Subject: RE: [PATCH v5 0/2] Remove false-positive VLAs when using max()
Thread-Topic: [PATCH v5 0/2] Remove false-positive VLAs when using max()
Thread-Index: AQHTvUx2cPC61AQThUukKjo0dmw4m6PTIZQw
Date: Fri, 16 Mar 2018 17:44:52 +0000
Message-ID: <a37f7b0da04f4ede9fac2c88f7079a8a@AcuMS.aculab.com>
References: <1521174359-46392-1-git-send-email-keescook@chromium.org>
 <ab2933a2-ca7b-eb3b-744d-bc037b1be688@redhat.com>
 <CA+55aFx92dXg-qnrjGS2Rsna6TE5HSPBgGpSA3cv4n_n3RqBzA@mail.gmail.com>
In-Reply-To: <CA+55aFx92dXg-qnrjGS2Rsna6TE5HSPBgGpSA3cv4n_n3RqBzA@mail.gmail.com>
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
X-GMAIL-THRID: =?utf-8?q?1595034368078500739?=
X-GMAIL-MSGID: =?utf-8?q?1595117156841713023?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMTYgTWFyY2ggMjAxOCAxNzoyOQ0KPiBPbiBG
cmksIE1hciAxNiwgMjAxOCBhdCA0OjQ3IEFNLCBGbG9yaWFuIFdlaW1lciA8ZndlaW1lckByZWRo
YXQuY29tPiB3cm90ZToNCj4gPg0KPiA+IElmIHlvdSB3YW50IHRvIGNhdGNoIHN0YWNrIGZyYW1l
cyB3aGljaCBoYXZlIHVuYm91bmRlZCBzaXplLA0KPiA+IC1XZXJyb3I9c3RhY2stdXNhZ2U9MTAw
MCBvciAtV2Vycm9yPXZsYS1sYXJnZXItdGhhbj0xMDAwICh3aXRoIHRoZSBjb25zdGFudA0KPiA+
IGFkanVzdGVkIGFzIG5lZWRlZCkgbWlnaHQgYmUgdGhlIGJldHRlciBhcHByb2FjaC4NCj4gDQo+
IE5vLCB3ZSB3YW50IHRvIGNhdGNoICp2YXJpYWJsZSogc3RhY2sgc2l6ZXMuDQo+IA0KPiBEb2Vz
ICItV2Vycm9yPXZsYS1sYXJnZXItdGhhbj0wIiBwZXJoYXBzIHdvcmsgZm9yIHRoYXQ/IE5vLCBi
ZWNhdXNlDQo+IHRoZSBzdHVwaWQgY29tcGlsZXIgc2F5cyB0aGF0IGlzICJtZWFuaW5nbGVzcyIu
DQo+IA0KPiBBbmQgbm8sIHVzaW5nICItV2Vycm9yPXZsYS1sYXJnZXItdGhhbj0xIiBkb2Vzbid0
IHdvcmsgZWl0aGVyLCBiZWNhdXNlDQo+IHRoZSBtb3JvbmljIGNvbXBpbGVyIGNvbnRpbnVlcyB0
byB0aGluayB0aGF0ICJ2bGEiIGlzIGFib3V0IHRoZQ0KPiBfdHlwZV8sIG5vdCB0aGUgY29kZToN
Cj4gDQo+ICAgIHQuYzogSW4gZnVuY3Rpb24g4oCYdGVzdOKAmToNCj4gICAgdC5jOjY6NjogZXJy
b3I6IGFyZ3VtZW50IHRvIHZhcmlhYmxlLWxlbmd0aCBhcnJheSBpcyB0b28gbGFyZ2UNCj4gWy1X
ZXJyb3I9dmxhLWxhcmdlci10aGFuPV0NCj4gICAgICBpbnQgYXJyYXlbKDEsMTAwKV07DQo+IA0K
PiBHY2MgcGVvcGxlIGFyZSBjcmF6eS4NCj4gDQo+IElzIHRoZXJlIHJlYWxseSBubyB3YXkgdG8g
anVzdCBzYXkgInNodXQgdXAgYWJvdXQgdGhlIHN0dXBpZCBfc3ludGF4Xw0KPiBpc3N1ZSB0aGF0
IGlzIGVudGlyZWx5IGlycmVsZXZhbnQsIGFuZCBnaXZlIHVzIHRoZSBfY29kZV8gaXNzdWUiLg0K
DQpJIGxvb2tlZCBhdCB0aGUgZ2VuZXJhdGVkIGNvZGUgZm9yIG9uZSBvZiB0aGUgY29uc3RhbnQg
c2l6ZWQgVkxBIHRoYXQNCnRoZSBjb21waWxlciBiYXJmZWQgYXQuDQpJdCBzZWVtZWQgdG8gc3Vi
dHJhY3QgY29uc3RhbnRzIGZyb20gJXNwIHNlcGFyYXRlbHkgZm9yIHRoZSBWTEEuDQpTbyBpdCBs
b29rcyBsaWtlIHRoZSBjb21waWxlciB0cmVhdHMgdGhlbSBhcyBWTEEgZXZlbiB0aG91Z2ggaXQN
Cmtub3dzIHRoZSBzaXplLg0KVGhhdCBpcyBwcm9iYWJseSBtaXNzaW5nIG9wdGltaXNhdGlvbi4N
Cg0KCURhdmlkDQoNCg==
