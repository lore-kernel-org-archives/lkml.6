Return-Path: <kernel-hardening-return-12223-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELv+LcyDsTSabmn1qUnzQJSegVBL1qBQHd27XLxYIz6NIZb2suL8Sh21bA2lBj0i1TlWiLj7
ARC-Seal: i=1; a=rsa-sha256; t=1520469397; cv=none;
        d=google.com; s=arc-20160816;
        b=g6S+oVYvLhYgEhHg0RYWj7woKMNpYTgOUz/oPGP8etUDSF6JmXGNZA4tPVKgBmrKSw
         Br9JMcV3gXPQbICwO2AatjjyVwIXYeH9tMO+rCINPxOV9XCEwCTHDlyIfmivZTjyUbkm
         CkJuMfpW3phxeIg/qsr6esR4LbEOGlRqcASpvTNqsy/eAtKMRC7MpAyzWMpuHuGRA+lB
         4g9gWlo/y+yyUZ5ceiRKLeZ+w3A9ySp7sHzgJbr3/oBD/YJuvtvQqFVXKXvpGYsN0khH
         tMc/HFlcsqAOFM8Ovaqqx2PMfklF38LmZt0MOADQtlvpKqnrLoC4de/pVdNFOX6LPJ9X
         cZuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=jwmhsX+akWCqplCL0FcldghI2mQcQjijMWxRP3FPdq0=;
        b=1G1HIifPfbzGBK0Tj6v/fweyhVv/BufttqJvNc2uZl1lPbMnGEj4V7bXNrCHRWPX7h
         w541eojEBuQLNYEOXG8wLXDEEXhkCWC215RSPfOa5MKnsflW1qCtcyDIUxpoom/c1Q/5
         P1HkpLA9Lu5V7/qQ2HRaYpAGY7eS4xSLVrPQBMJzg88LEtDoL8Ph1Y3I6xrwtEtp3kHG
         P2LDAQEt8vzI1grILfGjNGIUqlUu1YIg+srhJLjjCso2rL6WP2mBm6S+/nEQ1/o0z6Pg
         XgTz7G4wZJB6+UMX8UP+48r0wpihbcVVQ8FaJoNwCD/361Sklf8HoGinn0QfQS5ThvAV
         k+kA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=bGfYIcH6;
       dkim=pass header.i=@chromium.org header.s=google header.b=fU1IORPw;
       spf=pass (google.com: domain of kernel-hardening-return-12223-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12223-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=bGfYIcH6;
       dkim=pass header.i=@chromium.org header.s=google header.b=fU1IORPw;
       spf=pass (google.com: domain of kernel-hardening-return-12223-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12223-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180307160322.e9f8a3fb462751d1efa3b09a@linux-foundation.org>
References: <20180307230714.GA20797@beast> <20180307234238.yxbbaka35ck2xymw@smitten>
 <CAGXu5j+d91dqTEPm13CXDvNzzaj01M-CYLYCqyMN5VjrD5Q4ww@mail.gmail.com> <20180307160322.e9f8a3fb462751d1efa3b09a@linux-foundation.org>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 7 Mar 2018 16:36:17 -0800
X-Google-Sender-Auth: LpIDhIq4EFdtdDx81NkhN1KCXQo
Message-ID: <CAGXu5jKvAiyF=Dxd0nGx6bH84Vjqksjf4jZRXOTVXqSrnG6S5A@mail.gmail.com>
Subject: Re: [PATCH] vsprintf: Remove accidental VLA usage
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Tycho Andersen <tycho@tycho.ws>, "Tobin C. Harding" <me@tobin.cc>, Jonathan Corbet <corbet@lwn.net>,
	Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
	"Steven Rostedt (VMware)" <rostedt@goodmis.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, LKML <linux-kernel@vger.kernel.org>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594322119542311159?=
X-GMAIL-MSGID: =?utf-8?q?1594327718739235750?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 7, 2018 at 4:03 PM, Andrew Morton <akpm@linux-foundation.org> wrote:
> On Wed, 7 Mar 2018 15:59:27 -0800 Kees Cook <keescook@chromium.org> wrote:
>
>> I didn't want to encourage a global macro that _lacked_ the safety
>> built into the max*() family, though... thoughts for a reasonable
>> approach?
>
> I think SIMPLE_MAX() is OK.    Along with one of /* these */ things ;)

Sounds good. I will resend with net/ipv[46]/proc.c and one other fixed
as well...

-Kees

-- 
Kees Cook
Pixel Security
