Return-Path: <kernel-hardening-return-12348-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsSW2ooiMoy2oz7eM2amYu1aEBxt6o5DUDAgyzeYPZn9EFOhd9HezmfU9IPRbIWJ0T5I3HW
ARC-Seal: i=1; a=rsa-sha256; t=1520640461; cv=none;
        d=google.com; s=arc-20160816;
        b=DGMkkBMGLKUuxGugx+a289B+dqCqMhAsMuIjjmZwxZvz/C6Q/CxFaaw+unmEGCfVo0
         USMg88jJ94bCtWgNFeJxWsRHojWPReibUhX6oGJgXGUVKcuVkqbYeBPkDnapAeVyKV5l
         UW1eqP1nX+188MX5X2qiTQ5DY8TJSCMiiSCvponYyjpqGfyVq/S9x1WQNR7FgeCDEwGO
         PW5w+0jPNVNKRWnM0B664lg+ZCkKDQX/ieHIGz+t1oBYgWUFfiitDFR7e1b8iQdAS56h
         mNP9MCBndjx0StWQQWgc+sL172/M9jlZbBV3Tg74J5qzwmnRJcmRMaAcqYPR+QURWmmN
         qKCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=FkdnaathNud/UdkAGLDp4+gj2rCQlnnAwIAiJTPIa4s=;
        b=Hd8Bc4eeM7iDmDPdZ/emrLphlb3NDcse1LAU7uCmQpzXa9dPbwam/+FFt4c0PDuwuD
         tWYWJ5N3N6eRZtz1e4NJv/7Uvs/XP6b0gNic7qCQGo3nCByS5tT2/C3Xbvvm73c8dsDe
         tqH5+StVg0ounijqPB0bmDKp05uCzi71IPnGYGaUjFbjq1v8+tjU8b9nz9cf9AD6Y1qh
         Fao6y1z9U4mLKrAn1zv6IB+XqmNv3UeUUvY6BE7G1Rz73C6kR3dC2G0CLOvDMcDsQRfy
         Xic8eAr6e4iE/NQHeKXg49iRDutHbwR1cMvFc9F9Ay3dc30+bxax6e7IqbIXTr+taow+
         KaHg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12348-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12348-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12348-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12348-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Fri, 9 Mar 2018 16:07:19 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, "Gustavo A. R. Silva"
 <gustavo@embeddedor.com>, "Tobin C. Harding" <me@tobin.cc>, Steven Rostedt
 <rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>, Chris Mason
 <clm@fb.com>, Josef Bacik <jbacik@fb.com>, David Sterba <dsterba@suse.com>,
 "David S. Miller" <davem@davemloft.net>, Alexey Kuznetsov
 <kuznet@ms2.inr.ac.ru>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Ingo
 Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Masahiro Yamada
 <yamada.masahiro@socionext.com>, Borislav Petkov <bp@suse.de>, Randy Dunlap
 <rdunlap@infradead.org>, Ian Abbott <abbotti@mev.co.uk>, Sergey Senozhatsky
 <sergey.senozhatsky.work@gmail.com>, Petr Mladek <pmladek@suse.com>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Pantelis Antoniou
 <pantelis.antoniou@konsulko.com>, Linux Btrfs
 <linux-btrfs@vger.kernel.org>, Network Development
 <netdev@vger.kernel.org>, Kernel Hardening
 <kernel-hardening@lists.openwall.com>, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: Re: [PATCH v3] kernel.h: Skip single-eval logic on literals in
 min()/max()
Message-Id: <20180309160719.154a3158e2d8ee56e43a918f@linux-foundation.org>
In-Reply-To: <20180309200536.GA5670@beast>
References: <20180309200536.GA5670@beast>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594491887701841138?=
X-GMAIL-MSGID: =?utf-8?q?1594507092116755886?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 9 Mar 2018 12:05:36 -0800 Kees Cook <keescook@chromium.org> wrote:

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

v1, v2 and v3 of this patch all fail with gcc-4.4.4:

./include/linux/jiffies.h: In function 'jiffies_delta_to_clock_t':
./include/linux/jiffies.h:444: error: first argument to '__builtin_choose_expr' not a constant

That's with

#define __max(t1, t2, x, y)						\
	__builtin_choose_expr(__builtin_constant_p(x) &&		\
			      __builtin_constant_p(y) &&		\
			      __builtin_types_compatible_p(t1, t2),	\
			      (t1)(x) > (t2)(y) ? (t1)(x) : (t2)(y),	\
			      __single_eval_max(t1, t2,			\
						__UNIQUE_ID(max1_),	\
						__UNIQUE_ID(max2_),	\
						x, y))
/**
 * max - return maximum of two values of the same or compatible types
 * @x: first value
 * @y: second value
 */
#define max(x, y)	__max(typeof(x), typeof(y), x, y)


A brief poke failed to reveal a workaround - gcc-4.4.4 doesn't appear
to know that __builtin_constant_p(x) is a constant.  Or something.

Sigh.  Wasn't there some talk about modernizing our toolchain
requirements?
