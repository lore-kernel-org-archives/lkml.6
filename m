Return-Path: <kernel-hardening-return-12480-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELucdnxaRmGy19ITnj3XMdIqB8zvEdmpmQGrtaAypa/SAIoHd4aeEL8l72sX/wkFi75C8XUM
ARC-Seal: i=1; a=rsa-sha256; t=1520895347; cv=none;
        d=google.com; s=arc-20160816;
        b=meJOYvdAS9B8EGEhtSNecqnUBb8+Htq74DS3DpmnHEZwnEl8zNm9HSi5hKtmf21dnL
         scuKkGxlKNR6ZRf8qvAmUMrnWBEa5fQp0LkagZ6CAZsDtoLWCrZidHXTdm9vtF1XNBbk
         Ax0nkictB4bvofMwxjuQdJCYahv6kYXcLHQRw/JaGWPuoOFCxknIEPlSeT6EVGwHomQC
         yJX8HZyaVpxel1X9gaLqdLdn8Rj6uC8Q+n6HzVSEes5EN+8Sc5W47SCsD8lBZ5AGPTG/
         9sWQ1roe2toBPlxkOvClPcnihiFBQo0wSuvcXBYvM+9IKLE93t4aQY6E4jz4FcA6FQhH
         HbIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=Gdtjz3FmZbbxTIOvmDMy5w64/GcukgZkaFQjr2pvd80=;
        b=pIniBEgRBvtmvv0gkJFvHR1AbZTzWJ6rhRxvnNH4AISDXnF2Eld3jNundG/6BrHtgX
         ZfnoPtxYFfKHl1etJB/b2WiB+BbTS/aSn5jM+6qdJoaGRRGDD/XOY3pX+JHgz/tvnOkc
         W0qhF0KxtePEDM/gRpLlrXLolTO09QTeNhP3Ge9TRpVhjGurdpNPlMgJRfcmQqGhDibi
         BbcpdP2b3p39GfU2iNrRiwUzd43wjJz0LnA50bKkqg47+1qHxt5f5jaSIBgEjCzcjoZU
         5usXXIB87DWE+bjwh5EVCkQn9dOLMsqCfJARWFXKPOjcaKl2C/JPzjK+9r+RlUDTWUDR
         Uygw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12480-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12480-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12480-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12480-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Mon, 12 Mar 2018 15:55:24 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
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
 <kernel-hardening@lists.openwall.com>
Subject: Re: [PATCH v3] kernel.h: Skip single-eval logic on literals in
 min()/max()
Message-Id: <20180312155524.b421f07d7f08f24c57bd1887@linux-foundation.org>
In-Reply-To: <CAGXu5j+D=zs8AMb969dhH05GmKPuBxKPcAs89KfKzVf47faL1g@mail.gmail.com>
References: <20180309200536.GA5670@beast>
	<20180309160719.154a3158e2d8ee56e43a918f@linux-foundation.org>
	<CA+55aFw9hWz1-YFVoHEiXDjqb9q7dz=rQVXr7YLkMuVLvbwaOg@mail.gmail.com>
	<20180309163241.a421e216999bd0b1f43a64c2@linux-foundation.org>
	<CA+55aFwbO2vUsjWzAwB6SZ65RM4r3P0+2JvyMHn=ry0CgWCBgA@mail.gmail.com>
	<CAGXu5j+D=zs8AMb969dhH05GmKPuBxKPcAs89KfKzVf47faL1g@mail.gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594491887701841138?=
X-GMAIL-MSGID: =?utf-8?q?1594774359782560374?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 9 Mar 2018 17:30:15 -0800 Kees Cook <keescook@chromium.org> wrote:

> > It's one reason why I wondered if simplifying the expression to have
> > just that single __builtin_constant_p() might not end up working..
> 
> Yeah, it seems like it doesn't bail out as "false" for complex
> expressions given to __builtin_constant_p().
> 
> If no magic solution, then which of these?
> 
> - go back to my original "multi-eval max only for constants" macro (meh)
> - add gcc version checks around this and similarly for -Wvla in the future (eww)
> - raise gcc version (yikes)

Replacing the __builtin_choose_expr() with ?: works of course.  What
will be the runtime effects?

I tried replacing

	__builtin_choose_expr(__builtin_constant_p(x) &&
                              __builtin_constant_p(y),

with

	__builtin_choose_expr(__builtin_constant_p(x + y),

but no success.

I'm not sure what else to try to trick gcc into working.

--- a/include/linux/kernel.h~kernelh-skip-single-eval-logic-on-literals-in-min-max-v3-fix
+++ a/include/linux/kernel.h
@@ -804,13 +804,10 @@ static inline void ftrace_dump(enum ftra
  * accidental VLA.
  */
 #define __min(t1, t2, x, y)						\
-	__builtin_choose_expr(__builtin_constant_p(x) &&		\
-			      __builtin_constant_p(y),			\
-			      (t1)(x) < (t2)(y) ? (t1)(x) : (t2)(y),	\
-			      __single_eval_min(t1, t2,			\
-						__UNIQUE_ID(min1_),	\
-						__UNIQUE_ID(min2_),	\
-						x, y))
+	((__builtin_constant_p(x) && __builtin_constant_p(y)) ?		\
+		((t1)(x) < (t2)(y) ? (t1)(x) : (t2)(y)) :		\
+		(__single_eval_min(t1, t2, __UNIQUE_ID(min1_),		\
+				  __UNIQUE_ID(min2_), x, y)))
 
 /**
  * min - return minimum of two values of the same or compatible types
@@ -826,13 +823,11 @@ static inline void ftrace_dump(enum ftra
 	max1 > max2 ? max1 : max2; })
 
 #define __max(t1, t2, x, y)						\
-	__builtin_choose_expr(__builtin_constant_p(x) &&		\
-			      __builtin_constant_p(y),			\
-			      (t1)(x) > (t2)(y) ? (t1)(x) : (t2)(y),	\
-			      __single_eval_max(t1, t2,			\
-						__UNIQUE_ID(max1_),	\
-						__UNIQUE_ID(max2_),	\
-						x, y))
+	((__builtin_constant_p(x) && __builtin_constant_p(y)) ?		\
+		((t1)(x) > (t2)(y) ? (t1)(x) : (t2)(y)) :		\
+		(__single_eval_max(t1, t2, __UNIQUE_ID(max1_),		\
+				  __UNIQUE_ID(max2_), x, y)))
+
 /**
  * max - return maximum of two values of the same or compatible types
  * @x: first value
_
