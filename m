Return-Path: <kernel-hardening-return-12583-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELswRibRpCpc/y1wxHW10h8P9uaWiYlWbxjUNn476V63ORFrThYzO324FLPea0tBlu048TUa
ARC-Seal: i=1; a=rsa-sha256; t=1521027301; cv=none;
        d=google.com; s=arc-20160816;
        b=UUWhnaFebHSxvr04U4Af9BxghDeMFPp5kKX6QbNsR9XJI6U6QGPFa00ZNJU3EKhZ8O
         FhPzrPNgKkttqcHptsEtCCJ7ng4R5pV23uU7wMfSnp/XWsuKChSfkVqyaeXABJwTGOXQ
         OPNP6Z0wnttJ1tpz4Uj/nS8vx13NFTaz39dCMZ4rKIx60E1dVqmu6AcFbeH4NYrllR7o
         EyARjSjbGjCy/JDDmELMEATjNEC6Ja6e69xmPmt92NhkeBpNcfnKRz1JCPBgQWCVS7PU
         CCnb/a18tBuEHEv5fdOxbSRJIgUqE+jnceUqxN87KjwI5uBzKiKK7OreM6mCmBos5Vq7
         7DtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=cwOgywh/bSGJu0XYXBshh01zWJ1SDueJTJ3W5bEnWws=;
        b=PUWq0ShanhYIZyuBwvPGf/TiA2Ih0SysMGQJeaf5M29A4kfw+tsf30LPEVpfV5ClCW
         4Ndei9KoKyUOhjxIrm5rixD1g2RDZZBF+2N4ZEd0gdHR3UwBCbnq7Hb66vVtNZDAE611
         xHFYuJZJX3WFkPgj8w/fEi5ZBmwd+EvIisSJJsKlbYkmngvGIdNSS8FjWCzHTEap/9ga
         E1JNsMXgCBjxGvT1I1q8JSflnkgittlqJX/qvhnDSyFPfXxn3ORWCUIgaeqGsYkFWIZF
         Us1+XxcVrLjcr2E9gr2hqf/qSotwh1DYeybkeJi37y1pdwM3sfdrQ3pSLgrFa1URU233
         cUEw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12583-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12583-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12583-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12583-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: David Laight <David.Laight@ACULAB.COM>
To: 'Kees Cook' <keescook@chromium.org>, Andrew Morton
	<akpm@linux-foundation.org>
CC: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, "Rasmus
 Villemoes" <linux@rasmusvillemoes.dk>, "Gustavo A. R. Silva"
	<gustavo@embeddedor.com>, "Tobin C. Harding" <me@tobin.cc>, Steven Rostedt
	<rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>, Chris Mason
	<clm@fb.com>, Josef Bacik <jbacik@fb.com>, David Sterba <dsterba@suse.com>,
	"David S. Miller" <davem@davemloft.net>, Alexey Kuznetsov
	<kuznet@ms2.inr.ac.ru>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, "Ingo
 Molnar" <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Thomas
 Gleixner" <tglx@linutronix.de>, Masahiro Yamada
	<yamada.masahiro@socionext.com>, Borislav Petkov <bp@suse.de>, Randy Dunlap
	<rdunlap@infradead.org>, Ian Abbott <abbotti@mev.co.uk>, Sergey Senozhatsky
	<sergey.senozhatsky.work@gmail.com>, Petr Mladek <pmladek@suse.com>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, Pantelis Antoniou
	<pantelis.antoniou@konsulko.com>, Linux Btrfs <linux-btrfs@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>, Kernel Hardening
	<kernel-hardening@lists.openwall.com>
Subject: RE: [PATCH v3] kernel.h: Skip single-eval logic on literals in
 min()/max()
Thread-Topic: [PATCH v3] kernel.h: Skip single-eval logic on literals in
 min()/max()
Thread-Index: AQHTuxiqbfmX6z4ZI0WYzhXAPa6ocqPPmfUg
Date: Wed, 14 Mar 2018 11:35:26 +0000
Message-ID: <4922d8fb3c334e76a622258bb3c610e6@AcuMS.aculab.com>
References: <20180309200536.GA5670@beast>
 <20180309160719.154a3158e2d8ee56e43a918f@linux-foundation.org>
 <CA+55aFw9hWz1-YFVoHEiXDjqb9q7dz=rQVXr7YLkMuVLvbwaOg@mail.gmail.com>
 <20180309163241.a421e216999bd0b1f43a64c2@linux-foundation.org>
 <CA+55aFwbO2vUsjWzAwB6SZ65RM4r3P0+2JvyMHn=ry0CgWCBgA@mail.gmail.com>
 <CAGXu5j+D=zs8AMb969dhH05GmKPuBxKPcAs89KfKzVf47faL1g@mail.gmail.com>
 <20180312155524.b421f07d7f08f24c57bd1887@linux-foundation.org>
 <CA+55aFwK7W0SsaP5eR+2TxOj-j_Mu_E11fRw2Gk8ptV71ebvww@mail.gmail.com>
 <CAGXu5j+M0qbBS0og8buXHdubA=oi=jMcK=ehLGDeevFd2H7JmA@mail.gmail.com>
 <20180313140248.7fdb0d0cee044cd7c7fc7b93@linux-foundation.org>
 <CAGXu5j+JUfvYCej17Gx__3Vhu4JmimddrSgV89c2tkfwshH_Mw@mail.gmail.com>
In-Reply-To: <CAGXu5j+JUfvYCej17Gx__3Vhu4JmimddrSgV89c2tkfwshH_Mw@mail.gmail.com>
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
X-GMAIL-THRID: =?utf-8?q?1594491887701841138?=
X-GMAIL-MSGID: =?utf-8?q?1594912724305963402?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogS2VlcyBDb29rDQo+IFNlbnQ6IDEzIE1hcmNoIDIwMTggMjI6MTUNCi4uLg0KPiBJJ2xs
IHNlbmQgYSAiY29uc3RfbWF4KCkiIHdoaWNoIHdpbGwgcmVmdXNlIHRvIHdvcmsgb24NCj4gbm9u
LWNvbnN0YW50LXZhbHVlcyAoc28gaXQgZG9lc24ndCBnZXQgYWNjaWRlbnRhbGx5IHVzZWQgb24g
dmFyaWFibGVzDQo+IHRoYXQgY291bGQgYmUgZXhwb3NlZCB0byBkb3VibGUtZXZhbHVhdGlvbiks
IGFuZCB3aWxsIHdvcmsgZm9yIHN0YWNrDQo+IGFycmF5IGRlY2xhcmF0aW9ucyAodG8gYXZvaWQg
dGhlIG92ZXJseS1zZW5zaXRpdmUgLVd2bGEgY2hlY2tzKS4NCg0KSVNUUiB0aGUgZGVmaW5pdGlv
bnMgd2VyZSBvZiB0aGUgZm9ybToNCgljaGFyIGZvb1ttYXgoc2l6ZW9mIChzdHJ1Y3QgYmFoKSwg
c2l6ZW9mIChzdHJ1Y3QgYmF6KSldOw0KVGhpcyBkb2Vzbid0IGdlbmVyYXRlIGEgJ2Zvbycgd2l0
aCB0aGUgcmVxdWlyZWQgYWxpZ25tZW50Lg0KSXQgd291bGQgYmUgbXVjaCBiZXR0ZXIgdG8gdXNl
IGEgdW5pb24uDQoNCglEYXZpZA0KDQo=
