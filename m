Return-Path: <kernel-hardening-return-12260-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvIxK0QVw+KXGQ41fjOlequfSLhEEhlEgIw7qtw/EWSmBnEGO3X+Yedc4C44bRJp2uSHbJu
ARC-Seal: i=1; a=rsa-sha256; t=1520542176; cv=none;
        d=google.com; s=arc-20160816;
        b=qtnbemBkBq7aIxe5OJDhGT/2uzy6xTY+rcIR1Vn9HRto1n5vlQl6MowQ4QDAiWM/YI
         3x78ZE5e52t1mk6hvpD1JQTPe1aPtupGPEWKC00vt1MtJukDMqNaFegy7Vm9hFDGC4r3
         /CXAYMjNvRS4zUBmaqvT/wjXUVShxBCZTznqMbwAAiuHup0utdwtCwp0dXdgnNvWo2/4
         Ntyu8dvhzdcSrAJQ7STrXAKXOPD+GhxRLlX93j4Tpiz0RQUY2QAEVq0dH13T1AVHN9K/
         xo2QWtgoHU9zp78UQ8VyBY3/MBQtbH7H4rtbQUUEhyW8UtPPrCwzfy8IfdiT3bOA94xT
         eB+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=6eDkBKYy1PpeVGmHUy0oNr7zPOXJ1IZtesDnPRylxQo=;
        b=r51nMAZWL/Vj3r6HU7I+NN3iT9BwnprXo+U86PPIS20CTlD2/3yRYr+czjMcsIxIlP
         xxdpnZ2qx+Iu5aycKztArFs2YqrNMcHJW+mFGoU3yQte02grMhol2pZigTd00hrhk/EI
         L6BSErqhnHmEuQa88eD+gD2q1WFmpvr+ZaagMMWx+PO2UcE/NVpjXZRZzSNeoQWB6I/k
         aHu5Giqg7lWZlUiBqdOgwAZDCS0iW5lTZfy121zwLsh3WhmvwmvvaANAN/ecNUorqxMT
         lDhJn9xFtcRLubJm3dkuaseBFaNZ+9FD979Du7/7yzX3feL4F8/Dek9NipIJK82HWET2
         MqTw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12260-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12260-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12260-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12260-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Thu, 8 Mar 2018 12:49:13 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
 corbet@lwn.net, gustavo@embeddedor.com, rostedt@goodmis.org, Chris Mason
 <clm@fb.com>, Josef Bacik <jbacik@fb.com>, David Sterba <dsterba@suse.com>,
 "David S. Miller" <davem@davemloft.net>, Alexey Kuznetsov
 <kuznet@ms2.inr.ac.ru>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Ingo
 Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Masahiro Yamada
 <yamada.masahiro@socionext.com>, Borislav Petkov <bp@suse.de>, Randy Dunlap
 <rdunlap@infradead.org>, Ian Abbott <abbotti@mev.co.uk>, "Tobin C. Harding"
 <me@tobin.cc>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Petr
 Mladek <pmladek@suse.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Pantelis Antoniou
 <pantelis.antoniou@konsulko.com>, linux-btrfs@vger.kernel.org,
 netdev@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [PATCH 0/3] Remove accidental VLA usage
Message-Id: <20180308124913.858b2693a14c25d6dcc66b4a@linux-foundation.org>
In-Reply-To: <20180308150236.5tysfbm3xdouii5n@treble>
References: <1520479847-39174-1-git-send-email-keescook@chromium.org>
	<20180308150236.5tysfbm3xdouii5n@treble>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594338745857869070?=
X-GMAIL-MSGID: =?utf-8?q?1594404033087134998?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 8 Mar 2018 09:02:36 -0600 Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> On Wed, Mar 07, 2018 at 07:30:44PM -0800, Kees Cook wrote:
> > This series adds SIMPLE_MAX() to be used in places where a stack array
> > is actually fixed, but the compiler still warns about VLA usage due to
> > confusion caused by the safety checks in the max() macro.
> > 
> > I'm sending these via -mm since that's where I've introduced SIMPLE_MAX(),
> > and they should all have no operational differences.
> 
> What if we instead simplify the max() macro's type checking so that GCC
> can more easily fold the array size constants?  The below patch seems to
> work:
> 
> -/*
> - * min()/max()/clamp() macros that also do
> - * strict type-checking.. See the
> - * "unnecessary" pointer comparison.
> - */
> -#define __min(t1, t2, min1, min2, x, y) ({		\
> -	t1 min1 = (x);					\
> -	t2 min2 = (y);					\
> -	(void) (&min1 == &min2);			\
> -	min1 < min2 ? min1 : min2; })
> +extern long __error_incompatible_types_in_min_macro;
> +extern long __error_incompatible_types_in_max_macro;
> +
> +#define __min(t1, t2, x, y)						\
> +	__builtin_choose_expr(__builtin_types_compatible_p(t1, t2),	\
> +			      (t1)(x) < (t2)(y) ? (t1)(x) : (t2)(y),	\
> +			      (t1)__error_incompatible_types_in_min_macro)

This will move the error detection from compile-time to link-time. 
That's tolerable I guess, but a bit sad and should be flagged in the
changelog at least.
