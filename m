Return-Path: <kernel-hardening-return-12863-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx48gnSc8031yBVCCmp4mQ+1P2Sk/sLbU/v4CJcQqzLR1TSQmA0wuEWihdWVaxpkOJ6ulUaNc
ARC-Seal: i=1; a=rsa-sha256; t=1522960299; cv=none;
        d=google.com; s=arc-20160816;
        b=s2TvlCAs037Mx0IB/0LzEE0R9DqWvJKChLvkEn2NN/txJWhbGkZTgk3MLqi1wy+hSA
         P657obPdiHeTZTkY6p+FxRde7yDhLpTvFeRGMw6ykCtvgveQOl499FEALeEflEeDw23M
         AU+wbUhC2oQaScdPHAk0QjoFvHM89ebM1Eo+iKv7S5xzhHpjjbJbwOW6GFGqy0zEYVxf
         NkCtgpeMeCNOfplrMoOW1hVEjCVONfWdEwuq8dBQqMu85eOFhqcERI2cwNZn7QGGghBY
         DhIBbKu59rPvM8osn0ennZYo4S5x0tps/wu3HHLmfAz9fGcXNW+JOiw3C8PGLOGVuqTQ
         nx4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=U37JdoZ6vkmSMsdUX/dumW5VA0c+KffRa8+FAIhL8Mw=;
        b=T0DKqKgiNfjQHtHNHmbxGstQVciMM45FqbXaGWxSJBM34wHqmDiSIXNaeHoIydwYCY
         fzKkElJfyxueyRQuzmRaNweQGxpr0T8FAKrwhtniQ64bIG5+Ugx1b/Zh6OJdHSDQcm7j
         HEqnMAqzxRCpJ0ToAWjGwjwBGE97H7A3PusSp35bu0kYlR02z/kQ9o8b0MCtaYznD/wn
         g3IRUnnBzdBqaS9xrOQHXfax/V6IJnlmw1Qt81CkauDNQNwCQxUdEba8hzN8WgLlJxrX
         BUorUnxl+PCLDM7KKweHElqvP8kcDGjlvGK49gut1hsBmwfhl5cPeYhFq8xTTNRMo6ev
         +zSA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=GtkGlL1U;
       dkim=pass header.i=@chromium.org header.s=google header.b=QwdLpcSD;
       spf=pass (google.com: domain of kernel-hardening-return-12863-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12863-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=GtkGlL1U;
       dkim=pass header.i=@chromium.org header.s=google header.b=QwdLpcSD;
       spf=pass (google.com: domain of kernel-hardening-return-12863-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12863-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <CA+55aFxVvg=4cX6wTTVNCJMj-VzJp0KhLBY3yLP5Nd3eMXGt=w@mail.gmail.com>
References: <20180331015236.GA3852@beast> <CAGXu5jJsaB+FJJszkOwvW2VYbSHGVyTD+EE=n+k1p1Mg_wtkMw@mail.gmail.com>
 <CA+55aFxVvg=4cX6wTTVNCJMj-VzJp0KhLBY3yLP5Nd3eMXGt=w@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 5 Apr 2018 13:31:18 -0700
X-Google-Sender-Auth: Uoz12_a4_GHjyTGqLYY5LA_8QG8
Message-ID: <CAGXu5j+yDnNkH2vaipGvExqqiAQLP2_SvvEtnzpobBgGvJrUAQ@mail.gmail.com>
Subject: Re: [PATCH v7] kernel.h: Retain constant expression output for max()/min()
To: Linus Torvalds <torvalds@linux-foundation.org>
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
X-GMAIL-MSGID: =?utf-8?q?1596939618969433002?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 5, 2018 at 1:20 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Apr 5, 2018 at 12:52 PM, Kees Cook <keescook@chromium.org> wrote:
>>
>> This patch seems finished (*knock on wood*). Do you want to take this
>> directly for v4.17, should I send a single-patch pull-request, or
>> should this go through -mm (for either 4.17 or 4.18)?
>
> I was actually expecting it to go with the other VLA removal patches,
> but if the plan is to try to just get them in individual maintainer
> trees, I guess I can just take this directly.

Yeah, the VLA patches have been going through maintainer trees --
mostly due to needing specialized review, etc. While many are trivial,
a fair number aren't (or at least the trade-offs aren't always
obvious).

> So if it would be a single-commit pull request, I'll just take it as a
> patch. I guess it could go through -mm, but since I was involved in
> the discussion anyway, I also don't mind just taking it directly. If
> it causes problems, I can curse at myself.

Yeah, I'm in no rush to collect the "unresponded" VLA patches into a
tree, and we've still got more to go, so right now it'd just be a
single-patch pull. If you can snag it now, that'd be great! :)

Thanks!

-Kees

-- 
Kees Cook
Pixel Security
