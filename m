Return-Path: <kernel-hardening-return-12288-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsazgFb36BOdV1ecNygRHOFDd5LB/qKbc2is6G8cJprG/zJ0jo6vtfI6QRXmz8YQxdmGVLI
ARC-Seal: i=1; a=rsa-sha256; t=1520559335; cv=none;
        d=google.com; s=arc-20160816;
        b=dtJqZ4NhJuqeiseg3mPHJAOQnNNfH0Ywh1aw+EMwiNcb0teJHYThqlRcSs3nt3NMe4
         FNjWd+Bh/wgkiCK9oOSb9T1tQXH2PdE8kSSwLuWmVS8lAmU8D7toouoWl9tVM2MLe9vR
         rRrVE09juTWJJ532lO+gU4puBWcZL2rehs5PCbylixCV1pCHIS/nhRK6OiKv4b3QlPsK
         EISCExy3scgjGWJYuKTPh2HF0tgQVJ4nqTYxYPi9wxH4VFJG2nKpOp2cXAt404hd9nrV
         9rynakfJLOcQgoRyNgEHkfDRvB3bXsdTuzQGXYj0mlnOE3QmshMBqZZD6Q7O3OHFtfL0
         QsSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:sender:mime-version:dkim-signature
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=jnxroqe8YbZd6eymMv+1TOe9XYYSnCx7JyBb8wypGe8=;
        b=eeduTFNQTlpUfbCndlcCihvYkPI16+zEhHDOp3Fn1Vu64/+yCtEASQKff1lbblp2vW
         edX37NL2vTni3XaXK8hJdDr1mw0kLfhzdr8vN9Y7joik2lmDroZRQ6AFb86I5QN9jGqd
         BJv3FKsCQLu+u6Cj0Xes+ksrSNb19GVxg3m7Lw2i36wPq3T0opH4eEHy1Qfn+viusEtE
         ifouWMXrJ9gberZEVlvsSYrblCLxqBjVjL80pg90dBBDOP4gRtdryUYh9joVDyfB5sfH
         2chsoZfu5uyuL6CdCtie1J7vW5+86MAiPd/KsemN/nbSp7HUKMXJyoouQGahINSyR1Ib
         Ncxg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=a4PphsgH;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=Gy86ndj1;
       spf=pass (google.com: domain of kernel-hardening-return-12288-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12288-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=a4PphsgH;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=Gy86ndj1;
       spf=pass (google.com: domain of kernel-hardening-return-12288-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12288-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CAGXu5j+JiYcsdaC4V9+SmUM2SKW1yRHr18d74G5SM_sSrQm=Nw@mail.gmail.com>
References: <20180308214045.GA6787@beast> <CA+55aFyf-ajRzW2sUwFrrMOAu5UyuOk5L8g9xfkr4VuJeWjV9w@mail.gmail.com>
 <CAGXu5j+JiYcsdaC4V9+SmUM2SKW1yRHr18d74G5SM_sSrQm=Nw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 8 Mar 2018 17:35:15 -0800
X-Google-Sender-Auth: orVkONR2vOT_bSvwvEvybZPQyMw
Message-ID: <CA+55aFxXb8JhpELWcFJnQMYy6sTyndwdNpCLFUznA9ML7-oL_Q@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594407273404510633?=
X-GMAIL-MSGID: =?utf-8?q?1594422025289992504?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 8, 2018 at 4:45 PM, Kees Cook <keescook@chromium.org> wrote:
>
> Rasmus mentioned this too. What I said there was that I was shy to
> make that change, since we already can't mix that kind of thing with
> the existing min()/max() implementation. The existing min()/max() is
> already extremely strict, so there are no instances of this in the
> tree.

Yes, but I also didn't want to add any new cases in case people add
new min/max() users.

But:

> If I explicitly add one, I see this with or without the patch:
>
> In file included from drivers/misc/lkdtm.h:7:0,
>                  from drivers/misc/lkdtm_core.c:33:
> drivers/misc/lkdtm_core.c: In function =E2=80=98lkdtm_module_exit=E2=80=
=99:
> ./include/linux/kernel.h:809:16: warning: comparison of distinct
> pointer types lacks a cast

Oh, ok, in that case, just drop the __builtin_types_compatible_p()
entirely. It's not adding anything.

I was expecting the non-chosen expression in __builtin_choose_expr()
to not cause type warnings. I'm actually surprised it does. Type games
is why __builtin_choose_expr() tends to exist in the first place.

> So are you saying you _want_ the type enforcement weakened here, or
> that I should just not use __builtin_types_compatible_p()?

I don't want to weaken the type enforcement, and I _thought_ you had
done that __builtin_types_compatible_p() to keep it in place.

But if that's not why you did it, then why was it there at all? If the
type warning shows through even if it's in the other expression, then
just a


#define __min(t1, t2, x, y)                             \
        __builtin_choose_expr(                          \
                __builtin_constant_p(x) &               \
                __builtin_constant_p(y),                \
                (t1)(x) < (t2)(y) ? (t1)(x) : (t2)(y),  \
                __single_eval_min(t1, t2,               \
   ...

would seem to be sufficient?

Because logically, the only thing that matters is that x and y don't
have any side effects and can be evaluated twice, and
"__builtin_constant_p()" is already a much stronger version of that.

Hmm? The __builtin_types_compatible_p() just doesn't seem to matter
for the only thing I thought it was there for.

                  Linus
