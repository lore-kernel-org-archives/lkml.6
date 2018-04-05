Return-Path: <kernel-hardening-return-12864-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx48VCtyGzXLk/PUB+8W3/jCm4YKb5E0MO282YuoamzXBI+Y2LjA3VZOXkeb56/lmdbDd5nY0
ARC-Seal: i=1; a=rsa-sha256; t=1522961029; cv=none;
        d=google.com; s=arc-20160816;
        b=lWAFlFHz8TNfbVrvXI87mSv4/GP1HFEBOOm2tbINyaR2GIGwE4lui47vbdOzELSUMl
         6ZCmIz7mlwZyLdTmvoD4+8tJn43CSNdZWcatd6HORqyNRmkCJwKdIzSvg52sgCDSR9ny
         VkLHi1KgkWRVOZ8q000xBAoVwnfgbVpt320NgzDMVluk5sPf+E0sfVAzGPF710l9wkdy
         3ZEBjoVvzi41+3K+aaQL9Qf026U5XPC0gV+AOj18OyJfyZiHvX3KHpFXGGHiZViGGMH4
         wETzlq0ZYCd6R+X6mVhFzRFDu/w0HJZcje/s14xuN4jv1kBwDLNDJPfrFQtttY6rVUDD
         DQrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=fF35DYV9FfLgYnQR5W7bsmPHPmh8TM5S1IvJzAl3I3Q=;
        b=WSYiF3KKp5qiCa8KRFSzYFuK/SGQJQqzdVrKECVTiaJs5mhThI+sm9nL5EOmI2yinK
         Al/n812IvPzT6K7+58U1Ay0nCuJBOysh0dIvkbUaR2+/BbO5quHckGWgUHpWU0FoGfu/
         VZUHKdoB/QA6O8Aop1Ho9Hky7pmE6iP4WXjuN8xm4DGhVgXA0BtOfa0TSAw7xCqoGLEa
         pdU/YYAieZwTxk+ZVgUhvuaO/CtRwWvzfi15Wcs5upeq+uIEVjsUBFKUpdfx/TP+cwoP
         iFpf2QNU4AU3+EkL2f/O3fMP1qg3eU12Chbx4rcdsZVNfJ0AZomZQQs+7M5q9GXIjabt
         AvpA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=nRIb92cT;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=MIF4fbRZ;
       spf=pass (google.com: domain of kernel-hardening-return-12864-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12864-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=nRIb92cT;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=MIF4fbRZ;
       spf=pass (google.com: domain of kernel-hardening-return-12864-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12864-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CAGXu5j+yDnNkH2vaipGvExqqiAQLP2_SvvEtnzpobBgGvJrUAQ@mail.gmail.com>
References: <20180331015236.GA3852@beast> <CAGXu5jJsaB+FJJszkOwvW2VYbSHGVyTD+EE=n+k1p1Mg_wtkMw@mail.gmail.com>
 <CA+55aFxVvg=4cX6wTTVNCJMj-VzJp0KhLBY3yLP5Nd3eMXGt=w@mail.gmail.com> <CAGXu5j+yDnNkH2vaipGvExqqiAQLP2_SvvEtnzpobBgGvJrUAQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 5 Apr 2018 13:42:55 -0700
X-Google-Sender-Auth: glEkhbbEfyA2oant3-TkHyS4TQQ
Message-ID: <CA+55aFxU66DqMtwWYh_WqXkdM-fapMyyQZSEZXVmVY=KV-7SLw@mail.gmail.com>
Subject: Re: [PATCH v7] kernel.h: Retain constant expression output for max()/min()
To: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Martin Uecker <Martin.Uecker@med.uni-goettingen.de>, Josh Poimboeuf <jpoimboe@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Randy Dunlap <rdunlap@infradead.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Ingo Molnar <mingo@kernel.org>,
	David Laight <David.Laight@aculab.com>, Ian Abbott <abbotti@mev.co.uk>,
	LKML <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596416253887758070?=
X-GMAIL-MSGID: =?utf-8?q?1596940384288679786?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 5, 2018 at 1:31 PM, Kees Cook <keescook@chromium.org> wrote:
>
> Yeah, I'm in no rush to collect the "unresponded" VLA patches into a
> tree, and we've still got more to go, so right now it'd just be a
> single-patch pull. If you can snag it now, that'd be great! :)

Ok, applied.

               Linus
