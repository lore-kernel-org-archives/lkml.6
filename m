Return-Path: <kernel-hardening-return-12630-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtNZpoUcJDNxZNKF/f1e+ck385L7uep7fexfoSgKvc996zJqVBPMswNLGUll9OqYCZucQAy
ARC-Seal: i=1; a=rsa-sha256; t=1521114890; cv=none;
        d=google.com; s=arc-20160816;
        b=KyWQcLdqAjFuJQHmCeEnH1X0j4m0j6aNRZzSFD0557CGx5+JIxYZ5Do3Cy6MSdrasu
         B/x1oe1gMbGoO2BcZDz/uE5Inx9uNN3qbSaXZUUhKcWqXaA2KUCk3BooEXg+41u2emhK
         EVKg4BTpzVGLmPh2k2Sr9PVRPxxPiCdksAModr8c+MweqqJNqv6NA3kXhydi7pX6og8w
         1sLe+l9OIZHIUjYlnNeRW+wgJMoZQ1WN6ILAJW3lCse67Xf+Rwt+vjfyiFIpdOz3KjU7
         YRmrpa3Tt0KpDZPsrYiLC/xrPA+y9hHcSQgrlFrdKEL8mqBRUbpbzUm/ao0H0d3QGQqK
         1OPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=RFCMNkc6Pg07isxIGxi29hAshGa7zid8cqEo/XoW5uE=;
        b=yXQb8gzA2D7ohhWepZpKfYgaiAPjE0EwNCs6WPPnNIUP9iFku6qph/buu2ewd44sJ/
         xVAao0gJdhqLFsUTbARCofNooML67hCSaDqEviR520lRU30llsG3/mMy6c3/UdWUD1iS
         svsTAPuhk/Vp+xEJ1Mn+Yhk17ZK6r2YRHmyjxPBpZq0J717jkPj1EQQHQp0R++w6ucrB
         5mIxBXQezjSUPwNTuMeEUQHLxLKyfZIRznx9/8t2BYUkGa8xXWAxNbYRP2gcpzDJJ8Cu
         tnQj5ZzOwzLYItPsQIENdkjcfx9ClHXAQ9UE4zLeAT29gw/8Vf12gvdNoubmFND9i40t
         4oUA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12630-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12630-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12630-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12630-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: David Laight <David.Laight@ACULAB.COM>
To: 'Eric Biggers' <ebiggers3@gmail.com>, Salvatore Mesoraca
	<s.mesoraca16@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Herbert Xu <herbert@gondor.apana.org.au>,
	"Kees Cook" <keescook@chromium.org>
Subject: RE: [PATCH] crypto: ctr: avoid VLA use
Thread-Topic: [PATCH] crypto: ctr: avoid VLA use
Thread-Index: AQHTu8LqlyKrxoL3rE6fdv2yQFmOY6PRLvDw
Date: Thu, 15 Mar 2018 11:55:21 +0000
Message-ID: <913c28c268ca49f19f2407afc110deef@AcuMS.aculab.com>
References: <1521033450-14447-1-git-send-email-s.mesoraca16@gmail.com>
 <20180314183157.GA183724@gmail.com>
In-Reply-To: <20180314183157.GA183724@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
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
X-GMAIL-THRID: =?utf-8?q?1594919197404593745?=
X-GMAIL-MSGID: =?utf-8?q?1595004567428139176?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Eric Biggers
> Sent: 14 March 2018 18:32
...
> Also, I recall there being a long discussion a while back about how
> __aligned(16) doesn't work on local variables because the kernel's stack =
pointer
> isn't guaranteed to maintain the alignment assumed by the compiler (see c=
ommit
> b8fbe71f7535)...

ISTR that gcc arbitrarily decided that the x86 stack (for 32 bit) would be
kept aligned to more than 4 bytes (16??) - probably so that xmm registers
could be written to stack locations.
This was a massive ABI change that they didn't tell anyone about!
While gcc compiled code maintained the alignment a lot of asm code didn't.
I don't know about Linux, but NetBSD didn't even align user stacks.

There is a gcc option to not assume that the stack is 'appropriately aligne=
d',
but ISTR that it generates rather more code that one might have wished.

If the compiler does align the stack, it does so by generating a double
stack frame - not pretty at all.

	David
