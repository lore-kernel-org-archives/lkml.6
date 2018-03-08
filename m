Return-Path: <kernel-hardening-return-12273-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvpyzypl34d38x4xrCKUG72Q4FZztZa5jggJDm4G7ze5XSy3f8OhMWaWwwCPdnWgwHgz/jJ
ARC-Seal: i=1; a=rsa-sha256; t=1520547535; cv=none;
        d=google.com; s=arc-20160816;
        b=ZrWx6SpXiUKXb4i63/wFzL3MyPtEHZcC9ZOiZTFmujDNgb8cB59Y9XxoIA6R4g4WBl
         fLcUloW2C8P1I6oOXtTLe5XMizooSfsc7Cq0dMpunnaUimQ5KOInWjNAyzYWTFYnE3RD
         ZSxUKN9FRD57lSrvZgypnDQwRKIeUP48HQlY652Zatz/u8EnHxtoPyJC8tx79TPPkuDa
         mCLLxItm12MiD7IU8wxIOAvvFBWj7+3pjlm/LIKJ2yfYzhkod+rX72ZSTq526r6QX6RH
         a0PtgmdsbeuK2bGYeKOEm3P4wPE33Qgk+o6WQH4AcBfHbpVkrbPR1W8PXUlidKRzcQSY
         Qrow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=1nitwgJDn30fyBj8c1OO4GWbGNrssL4l1RkM3IULTVk=;
        b=z+AC+8pr+PjjZNSm5/jubzfLxNjoVjeVS6U09sdMjFfbSIXLSXd4a5PuAAoAVnKStw
         5NHjFiIEmcR1RfATtukSimf3sCeMWKbnwV/0oXJFNeA+Pk51fLb3rDgrL4OOov7QMB5W
         jFo+UrsHLIxdqNwADv851DDT58VUxSkUy+1eXUvQlJ+mHVaeplIwrBZwKUtcrM3s+1K0
         TZXNzwlhlIjr2oLxLkltpUyIWRQR0yQD2mRaoMcDpRQvDz4BiaEv0pYPaU11L6nYmlFQ
         WahQSQ2JB0LB1bW0uYOCOPPbI3ruvV3ddYkTSRnSVJlqddtTD06LSf2GmBNpZDJYD7BE
         3vbQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12273-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12273-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12273-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12273-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Thu, 8 Mar 2018 14:18:33 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Kees Cook <keescook@chromium.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 "Tobin C. Harding" <me@tobin.cc>, rostedt@goodmis.org, corbet@lwn.net,
 Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>, David Sterba
 <dsterba@suse.com>, "David S. Miller" <davem@davemloft.net>, Alexey
 Kuznetsov <kuznet@ms2.inr.ac.ru>, Hideaki YOSHIFUJI
 <yoshfuji@linux-ipv6.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Masahiro
 Yamada <yamada.masahiro@socionext.com>, Borislav Petkov <bp@suse.de>, Randy
 Dunlap <rdunlap@infradead.org>, Ian Abbott <abbotti@mev.co.uk>, Sergey
 Senozhatsky <sergey.senozhatsky.work@gmail.com>, Petr Mladek
 <pmladek@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 linux-btrfs@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [PATCH] kernel.h: Skip single-eval logic on literals in
 min()/max()
Message-Id: <20180308141833.3fb57913bceae38f18db2bf1@linux-foundation.org>
In-Reply-To: <20180308214045.GA6787@beast>
References: <20180308214045.GA6787@beast>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594407273404510633?=
X-GMAIL-MSGID: =?utf-8?q?1594409652849926033?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 8 Mar 2018 13:40:45 -0800 Kees Cook <keescook@chromium.org> wrote:

> When max() is used in stack array size calculations from literal values
> (e.g. "char foo[max(sizeof(struct1), sizeof(struct2))]", the compiler
> thinks this is a dynamic calculation due to the single-eval logic, which
> is not needed in the literal case. This change removes several accidental
> stack VLAs from an x86 allmodconfig build:
> 
> $ diff -u before.txt after.txt | grep ^-
> -drivers/input/touchscreen/cyttsp4_core.c:871:2: warning: ISO C90 forbids variable length array ‘ids’ [-Wvla]
> -fs/btrfs/tree-checker.c:344:4: warning: ISO C90 forbids variable length array ‘namebuf’ [-Wvla]
> -lib/vsprintf.c:747:2: warning: ISO C90 forbids variable length array ‘sym’ [-Wvla]
> -net/ipv4/proc.c:403:2: warning: ISO C90 forbids variable length array ‘buff’ [-Wvla]
> -net/ipv6/proc.c:198:2: warning: ISO C90 forbids variable length array ‘buff’ [-Wvla]
> -net/ipv6/proc.c:218:2: warning: ISO C90 forbids variable length array ‘buff64’ [-Wvla]
> 
> Based on an earlier patch from Josh Poimboeuf.
> 
> ...
>
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -787,37 +787,57 @@ static inline void ftrace_dump(enum ftrace_dump_mode oops_dump_mode) { }
>   * strict type-checking.. See the
>   * "unnecessary" pointer comparison.
>   */
> -#define __min(t1, t2, min1, min2, x, y) ({		\
> +#define __single_eval_min(t1, t2, min1, min2, x, y) ({	\
>  	t1 min1 = (x);					\
>  	t2 min2 = (y);					\
>  	(void) (&min1 == &min2);			\
>  	min1 < min2 ? min1 : min2; })
>  
> +/*
> + * In the case of builtin constant values, there is no need to do the
> + * double-evaluation protection, so the raw comparison can be made.
> + * This allows min()/max() to be used in stack array allocations and
> + * avoid the compiler thinking it is a dynamic value leading to an
> + * accidental VLA.
> + */
> +#define __min(t1, t2, x, y)						\
> +	__builtin_choose_expr(__builtin_constant_p(x) &&		\
> +			      __builtin_constant_p(y) &&		\
> +			      __builtin_types_compatible_p(t1, t2),	\
> +			      (t1)(x) < (t2)(y) ? (t1)(x) : (t2)(y),	\
> +			      __single_eval_min(t1, t2,			\
> +						__UNIQUE_ID(max1_),	\
> +						__UNIQUE_ID(max2_),	\
> +						x, y))
> +

Holy crap.

I suppose gcc will one day be fixed and we won't need this.

Is there a good reason to convert min()?  Surely nobody will be using
min to dimension an array - always max?  Just for symmetry, I guess.
