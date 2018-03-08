Return-Path: <kernel-hardening-return-12284-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELu1Ik/zGWt4UIiHwpuZ+UV6PQsZTwYK6Sz7S31rn8Vomb+JOKkoWL7pd46v97K+tobF0WAj
ARC-Seal: i=1; a=rsa-sha256; t=1520552912; cv=none;
        d=google.com; s=arc-20160816;
        b=ePd47bnSOQcXha65pmloIfIZIJymN9B0G1fpplIVEIDTJQivAnjj6iQZoVfdp+ANC9
         0P7LQlve7jiYKeakSUncIR9Uq3r3A7KXy5AsMSRkUNQEysPF/bk0M7PmUINapXkqYSdQ
         Dmt1i+4M5wFFr8ewm4xOgVSZJSd4FZN1C7loCr42iL1QfqJaZFDshqOnQZoOC6+46FuG
         IeDedRAiNVdBoORhh0c5G2l1OCjdV5itj0Ko8zFJL4V+TdqrNkErRq0jBNbLf4e2TrlT
         YRg3XiReUoUqaxqdFSwKAZazyuy6b3eTzD/AG2O50ejZ0X/bdlbQb7CvjySrPE+e2m3c
         da2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=BbltuIcaj1hGqG0Firwh5rBHeTYwRBNQiEpgEPLvMJA=;
        b=yfK5VVnVChjTXg1hanIFHzvUKddrPdPfeCSqso8i0OKgUbwPDI4upS45CK6taGKwi1
         LECg4qBU1eHadNyA5HvkAUmlvg8skVzyewJGRBTSL1/A0Qw0Ad/CbD+kgxDS3l04D7Wc
         mgG/DfhU0up02BSHm/wChB+0FgH+FVfcZzVtNN2CyKuN1IK0tjGIyN3enRsMuitJcr7A
         XqqTGqhvCY56YF9pQbUvnA9kfoTGkHgZSvxGOSz3M1TmhM5TB4+9ibUPzqCsdb3WphRO
         WBxzMVm8D4FSnNNIVJQOZutIqdgzP+IWFVFbg1QBlX77svf3hRitTOU4rNCvA0rg9FlT
         g0jA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=hS081aT/;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=DDtNIi5A;
       spf=pass (google.com: domain of kernel-hardening-return-12284-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12284-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=hS081aT/;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=DDtNIi5A;
       spf=pass (google.com: domain of kernel-hardening-return-12284-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12284-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20180308214045.GA6787@beast>
References: <20180308214045.GA6787@beast>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 8 Mar 2018 15:48:10 -0800
X-Google-Sender-Auth: aPc3PLg4uh22hZxwIRTTlkr_5W0
Message-ID: <CA+55aFyf-ajRzW2sUwFrrMOAu5UyuOk5L8g9xfkr4VuJeWjV9w@mail.gmail.com>
Subject: Re: [PATCH] kernel.h: Skip single-eval logic on literals in min()/max()
To: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	"Tobin C. Harding" <me@tobin.cc>, Steven Rostedt <rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>,
	Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>, David Sterba <dsterba@suse.com>,
	"David S. Miller" <davem@davemloft.net>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
	Masahiro Yamada <yamada.masahiro@socionext.com>, Borislav Petkov <bp@suse.de>,
	Randy Dunlap <rdunlap@infradead.org>, Ian Abbott <abbotti@mev.co.uk>,
	Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Petr Mladek <pmladek@suse.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Pantelis Antoniou <pantelis.antoniou@konsulko.com>, linux-btrfs <linux-btrfs@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594407273404510633?=
X-GMAIL-MSGID: =?utf-8?q?1594415290459653257?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 8, 2018 at 1:40 PM, Kees Cook <keescook@chromium.org> wrote:
> +#define __min(t1, t2, x, y)                                            \
> +       __builtin_choose_expr(__builtin_constant_p(x) &&                \
> +                             __builtin_constant_p(y) &&                \
> +                             __builtin_types_compatible_p(t1, t2),     \
> +                             (t1)(x) < (t2)(y) ? (t1)(x) : (t2)(y),    \

I understand why you use __builtin_types_compatible_p(), but please don't.

It will mean that trivial constants like "5" and "sizeof(x)" won't
simplify, because they have different types.

The ?: will give the right combined type anyway, and if you want the
type comparison warning, just add a comma-expression with something
like like

   (t1 *)1 == (t2 *)1

to get the type compatibility warning.

Yeah, yeah, maybe none of the VLA cases triggered that, but it seems
silly to not just get that obvious constant case right.

Hmm?

              Linus
