Return-Path: <kernel-hardening-return-12234-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuHOU75jtjcx7cFtHW17wra87SNz95K4smCoxG9I1DSO1PZe6keX8QkVqFjdbxmyEYpyii3
ARC-Seal: i=1; a=rsa-sha256; t=1520508154; cv=none;
        d=google.com; s=arc-20160816;
        b=SDhDS9uwAf/XO8z/A9U63+1ftmV/1xUOEA2EXbuacvFBz8CBALjdvYCmFGOnoLLP6n
         kCGXE4riLyvdEwG5ywecHUr9MkJ2OZco6+NPT9XcOpAJ0P/pnOEDrx5Du/AyxN/TsSnv
         Cs3d8JAZQY+idK8NIRPa+kTXr8vXR5O0D2b6IkncEXx4Lir1JGE2zEowebN5YllO8I3u
         yhjWy+QWn+9bXAYdjgyoN3duF6isdwe5834r7MzAIqNKYpwzAc9fjEnCw9Dn3SqXPBWO
         18wrv2pPJf02WBR0VB04bMdZqEWA94Wb6j1rizyt6gRbkPesXq+A7Os5y8UwtNKfoQlc
         LNDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=J08t0BmTkhmQuh6zR1BFMB2wKcUf0Zt6vGSxPyx90XQ=;
        b=UxsBFAopwAu72BRo5hoEcOnkrDWtyeDNN+8BoYmMkk81ND5tvBBiT+xv6pwpwF4G2x
         dAKM3ONrd7XF0vj7mN2AMSWK41mBLgvHNhfSKNhmRpr/KqtdtgMAHH3ykD3kbnFHJ13S
         6JfohzOyUkmm6Z4o5Tc0alMmiZ0+LfcdDlhCLPpbrWuP1LSOPFzeApC9XkBCopIQyinz
         zFoGtrZQMQSv/XeUhzEfIaAFo4HAggNO0xTMbQawaEEE/SXbAj+2YFEKODixW0xG8hu1
         +ge5mBRi4z8kV5omoiHg2hjQnUc/byOM/gZX6WZ2WQosn8MbFieU4rfk2TVlzAufPAf2
         AtCQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12234-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12234-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12234-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12234-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Thu, 8 Mar 2018 12:21:23 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
cc: Kees Cook <keescook@chromium.org>,
    Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
    corbet@lwn.net, gustavo@embeddedor.com, rostedt@goodmis.org,
    Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
    David Sterba <dsterba@suse.com>, "David S. Miller" <davem@davemloft.net>,
    Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
    Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
    Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
    Masahiro Yamada <yamada.masahiro@socionext.com>,
    Borislav Petkov <bp@suse.de>, Josh Poimboeuf <jpoimboe@redhat.com>,
    Randy Dunlap <rdunlap@infradead.org>, Ian Abbott <abbotti@mev.co.uk>,
    "Tobin C. Harding" <me@tobin.cc>,
    Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
    Petr Mladek <pmladek@suse.com>,
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
    Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
    linux-btrfs@vger.kernel.org, netdev@vger.kernel.org,
    kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v2 1/3] vsprintf: Remove accidental VLA usage
In-Reply-To: <49e6b509-d1e7-5916-ecb8-6bde026fde1e@rasmusvillemoes.dk>
Message-ID: <alpine.DEB.2.21.1803081211230.8662@nanos.tec.linutronix.de>
References: <1520479847-39174-1-git-send-email-keescook@chromium.org> <1520479847-39174-2-git-send-email-keescook@chromium.org> <49e6b509-d1e7-5916-ecb8-6bde026fde1e@rasmusvillemoes.dk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594322119542311159?=
X-GMAIL-MSGID: =?utf-8?q?1594368358062324683?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 8 Mar 2018, Rasmus Villemoes wrote:
> On 2018-03-08 04:30, Kees Cook wrote:
> >  /**
> > + * SIMPLE_MAX - return maximum of two values without any type checking
> > + * @x: first value
> > + * @y: second value
> > + *
> > + * This should only be used in stack array sizes, since the type-checking
> > + * from max() confuses the compiler into thinking a VLA is being used.
> > + */
> > +#define SIMPLE_MAX(x, y)	((size_t)(x) > (size_t)(y) ? (size_t)(x) \
> > +							   : (size_t)(y))
> 
> This will be abused at some point, leading to the usual double
> evaluation etc. etc. problems. The name is also too long (and in general
> we should avoid adjectives like "simple", "safe", people reading the
> code won't know what is simple or safe about it). I think this should work
> 
> #define MAX(x, y) (__builtin_choose_expr((x) > (y), x, y))
> 
> That forces (x)>(y) to be a compile-time constant, so x and y must also
> be; hence there can be no side effects. The MIN version of this could
> replace the custom __const_min in fs/file.c, and probably other places
> as well.
> 
> I tested that this at least works in the vsprintf case, -Wvla no longer
> complains. fs/file.c also compiles with the MIN version of this.
> 
> I suppose MIN and MAX will collide with other uses in the tree. Hmm.

Make it CONST_MAX() or something like that which makes it entirely clear.

Thanks,

	tglx
