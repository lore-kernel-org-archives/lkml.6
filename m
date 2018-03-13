Return-Path: <kernel-hardening-return-12504-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtDqpN+b3fHzxdWgFNVEXmSphoVxIOMEsPUkMMufmqnoSVU9diCWq+RVIxeTrkWamvLCsGU
ARC-Seal: i=1; a=rsa-sha256; t=1520947867; cv=none;
        d=google.com; s=arc-20160816;
        b=bW0oEyF0TAlgDOAA/PFKVQfP7g+rgOusSY/P1A1PfRzoxaswuROZ+485ziJLvLBilC
         hwxIC1V3omZUSemeC9D7gXTo2/m0WjCIzgIxAZEyEXxG5AbPYthKG+pudpXfxSxTKlkn
         wrjB40C7dHhLSdDcuxLWeX5fxdpzc/OO8bi/krfqvDDKnV73654qP4feczBLdwMi1WsU
         mrKPIOo1jEL2yO6HaA6cOeogdhNeGlF3Q/LziSiz+amwL5hkD6Nbqoqjm1a4Q67NEeFh
         lpWqd3a+yb6cdFSxRvPQW0UVsLAmzJXPNDpq2NMDKu8h5VU/XxZwhyu5lyVxM8Zj8S9B
         Ic/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=TjlU7B8qvbp41px/lsz1zfGjLILDv0pQJbb1z9ts2uY=;
        b=Ie/C/5kzNqA/nNR+dBDRN71NSNuz0745YszE1SIm4be3KjCazG4CYaEt9LB90C0Yu5
         JbPvcFxVbP2NkBAqfetlMAfUwIoD6NH5HGxInpep3nXgtd+qbV2dQL3VGvfCgA/Gs9iW
         a4tyOXQmC0WYjGgKRxJkOXUwKV1iITBUl5D7fDeLyD4Ad2Qpu2hAcr/TgU7pYoqbKcvP
         tqJcrhka8GUyE8nzDPDMIKNPZ9hMxUhK/O+LxAoVGGi1lJjjdSmeQQSQXic+/ZOl0XbC
         CzF7+YFlo0QceGUV1nTwWDgPxVtyXckn6fEoww0wl8KpiqRxhXBOlAVbUngryzM0umb5
         wNyg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12504-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12504-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12504-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12504-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: David Laight <David.Laight@ACULAB.COM>
To: 'Linus Torvalds' <torvalds@linux-foundation.org>, Kees Cook
	<keescook@chromium.org>
CC: Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List
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
Thread-Index: AQHTt+tFbfmX6z4ZI0WYzhXAPa6ocqPOLhIA
Date: Tue, 13 Mar 2018 13:31:24 +0000
Message-ID: <569ab24c68bb46ae99600b9b309ebcbd@AcuMS.aculab.com>
References: <20180309200536.GA5670@beast>
 <CA+55aFy82Drgu2xm1GWaDz2Jyj5QBx3dW4AatXzmCx-b1YET5Q@mail.gmail.com>
In-Reply-To: <CA+55aFy82Drgu2xm1GWaDz2Jyj5QBx3dW4AatXzmCx-b1YET5Q@mail.gmail.com>
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
X-GMAIL-MSGID: =?utf-8?q?1594829430932374557?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

VGhlIGFtb3VudCBvZiByZXBsaWNhdGVkIGRlZmluZWQgY291bGQgYWxzbyBiZSByZWR1Y2VkIGJ5
IHBhc3NpbmcgPiBvciA8DQp0byBhIG1pbl9tYXgoKSBtYWNyby4NClNvIHlvdSBzdGFydCBvZmYg
d2l0aCBzb21ldGhpbmcgbGlrZToNCiNkZWZpbmUgbWluKHgsIHkpIF9fbWluX21heCh4LCA8LCB5
KQ0KI2RlZmluZSBtYXgoeCwgeSkgX19taW5fbWF4KHgsID4sIHkpDQp0aGVuIGhhdmU6DQojZGVm
aW5lIF9fbWluX21heCh4LCBjb25kLCB5KSAoKHgpIGNvbmQgKHkpID8gKHgpIDogKHkpKQ0KaW4g
YWxsIGl0cyBhc3NvY2lhdGVkIGZsYXZvdXJzLg0KDQoJRGF2aWQNCg0KDQo=
