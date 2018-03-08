Return-Path: <kernel-hardening-return-12246-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELs1eMzBEToB7mVsF6SLE44++IWNDiQ1AeowYebLbHsyBGq2bhgDx9qW6ZwuRPFED/RtWaGT
ARC-Seal: i=1; a=rsa-sha256; t=1520532735; cv=none;
        d=google.com; s=arc-20160816;
        b=NKGXC6Eas0xU3pEatoa5dztXYIeuQRvjEOnUmeEeoJwt1u+GarkBN3B0hMo5jyN6s8
         IgSNy/gxZN7cNt8DrhAVwyB22nFJn655H7gV1XRZuqpN48EN5Qc0tiHaZFJ8wN3ktrUA
         ljBxxRkpj2pXZcAkP/AQ+A/CIAIM4XrB/8P+KtBIKwR7hF47zWGm5X54fQ8/X74bdy6R
         6JNHG6/LXoP3OEmHcvHoc9pg/TVaUJcPGjPM7nL46Q0JZIxFLixEmNZKF3nBb0+BT2cB
         ooqBQQlggm8j8Y6EhXdzuGN6RFTGu7kl+GTmXUnb4BGwiZ9/avdU6dkEvbzH1th5bSvi
         mxtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=35bzQ8nB9g+srnhSEGDkvtn0S/KCubQzPlD/bWQYqCk=;
        b=PpF1W1Gu8PibBWU4rLfoUMUU4Ql/6CSptaotaHuExS7iVLd58iZtP8YGsD6NU8I6bO
         gcpoziwtl/rD53BCqFReHEE0Q4VD6y7oIKRLclj2MdEE6ySnRTx5hJPcMQ+RJCquHt+m
         laYSsTvmGq8Xwd+AVthNDpFgZByymC7OMLEyAhRoa0lQWomc3QJkYpGNP7cqUrEKq1z8
         SHvweSfWTXVticRbEgknUkmElORIKo3lNMmgROlJxrtCW2knAIdxyl0IHPqYI9h5b6cN
         BLv8v/EUuyNXlDS6Qb2LlRPBsB0HAqprzLlcozzxGa7puBNgmI2K1eWNg66jMcElXyAF
         gTcg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12246-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12246-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12246-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12246-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Thu, 8 Mar 2018 12:11:54 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Steven Rostedt <rostedt@goodmis.org>, Chris Mason <clm@fb.com>,
	Josef Bacik <jbacik@fb.com>, David Sterba <dsterba@suse.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	Borislav Petkov <bp@suse.de>, Randy Dunlap <rdunlap@infradead.org>,
	Ian Abbott <abbotti@mev.co.uk>, "Tobin C. Harding" <me@tobin.cc>,
	Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
	Petr Mladek <pmladek@suse.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
	Linux Btrfs <linux-btrfs@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: Re: [PATCH 0/3] Remove accidental VLA usage
Message-ID: <20180308181154.z2pipjykwos2mpzs@treble>
References: <1520479847-39174-1-git-send-email-keescook@chromium.org>
 <20180308150236.5tysfbm3xdouii5n@treble>
 <CAGXu5jL=93keuGEjNaLYHM-hc1EeaaW2SmnnW5ja=SH1jPJwGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGXu5jL=93keuGEjNaLYHM-hc1EeaaW2SmnnW5ja=SH1jPJwGw@mail.gmail.com>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594338745857869070?=
X-GMAIL-MSGID: =?utf-8?q?1594394133961598386?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 08, 2018 at 10:02:01AM -0800, Kees Cook wrote:
> On Thu, Mar 8, 2018 at 7:02 AM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > On Wed, Mar 07, 2018 at 07:30:44PM -0800, Kees Cook wrote:
> >> This series adds SIMPLE_MAX() to be used in places where a stack array
> >> is actually fixed, but the compiler still warns about VLA usage due to
> >> confusion caused by the safety checks in the max() macro.
> >>
> >> I'm sending these via -mm since that's where I've introduced SIMPLE_MAX(),
> >> and they should all have no operational differences.
> >
> > What if we instead simplify the max() macro's type checking so that GCC
> > can more easily fold the array size constants?  The below patch seems to
> > work:
> 
> Oooooh magic! Very nice. I couldn't figure out how to do this when I
> stared at it. Yes, let me respin. (I assume I can add your S-o-b?)

I'm going to be traveling for a few days, so I bequeath the patch to
you.  You can add my SOB.  I agree with Steve's suggestion to run it
through 0-day.

> 
> -Kees
> 
> >
> > diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> > index 3fd291503576..ec863726da29 100644
> > --- a/include/linux/kernel.h
> > +++ b/include/linux/kernel.h
> > @@ -782,42 +782,32 @@ ftrace_vprintk(const char *fmt, va_list ap)
> >  static inline void ftrace_dump(enum ftrace_dump_mode oops_dump_mode) { }
> >  #endif /* CONFIG_TRACING */
> >
> > -/*
> > - * min()/max()/clamp() macros that also do
> > - * strict type-checking.. See the
> > - * "unnecessary" pointer comparison.
> > - */
> > -#define __min(t1, t2, min1, min2, x, y) ({             \
> > -       t1 min1 = (x);                                  \
> > -       t2 min2 = (y);                                  \
> > -       (void) (&min1 == &min2);                        \
> > -       min1 < min2 ? min1 : min2; })
> > +extern long __error_incompatible_types_in_min_macro;
> > +extern long __error_incompatible_types_in_max_macro;
> > +
> > +#define __min(t1, t2, x, y)                                            \
> > +       __builtin_choose_expr(__builtin_types_compatible_p(t1, t2),     \
> > +                             (t1)(x) < (t2)(y) ? (t1)(x) : (t2)(y),    \
> > +                             (t1)__error_incompatible_types_in_min_macro)
> >
> >  /**
> >   * min - return minimum of two values of the same or compatible types
> >   * @x: first value
> >   * @y: second value
> >   */
> > -#define min(x, y)                                      \
> > -       __min(typeof(x), typeof(y),                     \
> > -             __UNIQUE_ID(min1_), __UNIQUE_ID(min2_),   \
> > -             x, y)
> > +#define min(x, y) __min(typeof(x), typeof(y), x, y)                    \
> >
> > -#define __max(t1, t2, max1, max2, x, y) ({             \
> > -       t1 max1 = (x);                                  \
> > -       t2 max2 = (y);                                  \
> > -       (void) (&max1 == &max2);                        \
> > -       max1 > max2 ? max1 : max2; })
> > +#define __max(t1, t2, x, y)                                            \
> > +       __builtin_choose_expr(__builtin_types_compatible_p(t1, t2),     \
> > +                             (t1)(x) > (t2)(y) ? (t1)(x) : (t2)(y),    \
> > +                             (t1)__error_incompatible_types_in_max_macro)
> >
> >  /**
> >   * max - return maximum of two values of the same or compatible types
> >   * @x: first value
> >   * @y: second value
> >   */
> > -#define max(x, y)                                      \
> > -       __max(typeof(x), typeof(y),                     \
> > -             __UNIQUE_ID(max1_), __UNIQUE_ID(max2_),   \
> > -             x, y)
> > +#define max(x, y) __max(typeof(x), typeof(y), x, y)
> >
> >  /**
> >   * min3 - return minimum of three values
> > @@ -869,10 +859,7 @@ static inline void ftrace_dump(enum ftrace_dump_mode oops_dump_mode) { }
> >   * @x: first value
> >   * @y: second value
> >   */
> > -#define min_t(type, x, y)                              \
> > -       __min(type, type,                               \
> > -             __UNIQUE_ID(min1_), __UNIQUE_ID(min2_),   \
> > -             x, y)
> > +#define min_t(type, x, y) __min(type, type, x, y)
> >
> >  /**
> >   * max_t - return maximum of two values, using the specified type
> > @@ -880,10 +867,7 @@ static inline void ftrace_dump(enum ftrace_dump_mode oops_dump_mode) { }
> >   * @x: first value
> >   * @y: second value
> >   */
> > -#define max_t(type, x, y)                              \
> > -       __max(type, type,                               \
> > -             __UNIQUE_ID(min1_), __UNIQUE_ID(min2_),   \
> > -             x, y)
> > +#define max_t(type, x, y) __max(type, type, x, y)                              \
> >
> >  /**
> >   * clamp_t - return a value clamped to a given range using a given type
> 
> 
> 
> -- 
> Kees Cook
> Pixel Security

-- 
Josh
