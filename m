Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAC9C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9633220856
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TCwOTyue"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfA1IeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 03:34:12 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:43895 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbfA1IeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 03:34:11 -0500
Received: by mail-io1-f66.google.com with SMTP id b23so12728602ios.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 00:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vr/HMut0ktj2VJdSoSaKoFxNf82QpzugkR31+X8r3b0=;
        b=TCwOTyue9xncwPQFRgJFoohPMjIj4I3l+DEbqJbO3Sn4ypiAu8x8BtTUx4tr49Ae53
         wy2+KylCncKRfOrptootOdCfqUneP3Rxagb0XZjcDsWlOL3ku+vy9etk42oPdP/A6r9U
         CdRbiNlP5L4JrPZmHd3MSvnKftmEcrllYpufnpx7SQ5LBgRGcsJ8QZC8vyQTFuyD1C0A
         3aV4ZyGykREJWAtuE8+FBodCTiCLuEq7205Q3CM/My2HVL+aahVZj0dQmcl3eNy1aGFc
         dU4obVn6HEAO90JDJ6d2XaGREphS+lHKhSgBfSutuUua954ebtsz0EcXtMWipMbm+N+3
         o0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vr/HMut0ktj2VJdSoSaKoFxNf82QpzugkR31+X8r3b0=;
        b=qruLHvExMPI/7awjx9v4mBpCWGXqrpkNQ+IQIAcimlUYWZbI8egBBfsjSyTNyWmb9m
         P1lEecAF9rK3+pewDTwXM3aDLmcm769I4pN2BdvJPYKLKIWkGCo8abRkevt6QOH+MURb
         9R9QP6FvLT2H0wNJH3X3sWy3/N1T0Nb+g/3kmjCOiUcgZd5R1y5XC1C/farFi1CTonCs
         g2IED8ScBDHJ8MXsD0sQhrbtjOdN0AExqpF7Fqx/wrFjimgYNwsD0z/OoJkYFDURDfc+
         GkTJdeTuPUgKf7nN08TEx3ty28zxOB3HCt592BFkYnV6KxqPZ27oQDu2OPdbZZnQKD2P
         aeOg==
X-Gm-Message-State: AHQUAuZfw7ppAUMMb8qhtu4fgrZEkxYPZkH35pIbcna9rD8w8yoYtpGL
        bxftnFDTySaK4znqKoOxQoVpdpQ/EIPCi/knpvTS8w==
X-Google-Smtp-Source: AHgI3Ib00yTpukMMZmjPV5qmCieyffcq37ZTqf9OYvVHGCSXVrYRPt5uEaXlSP8pPk+P28smtV7QSji5md0OPUgwGzk=
X-Received: by 2002:a5d:9456:: with SMTP id x22mr10205689ior.282.1548664450355;
 Mon, 28 Jan 2019 00:34:10 -0800 (PST)
MIME-Version: 1.0
References: <20190121131816.GC17749@hirez.programming.kicks-ass.net>
 <Pine.LNX.4.44L0.1901211103000.24162-100000@netrider.rowland.org>
 <20190122090456.GE13777@hirez.programming.kicks-ass.net> <2236FBA76BA1254E88B949DDB74E612BA4B944B3@IRSMSX102.ger.corp.intel.com>
In-Reply-To: <2236FBA76BA1254E88B949DDB74E612BA4B944B3@IRSMSX102.ger.corp.intel.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 28 Jan 2019 09:33:58 +0100
Message-ID: <CACT4Y+Zi7+6aAHf5mzjuSr4NcT+bowC8cU_DqFKwCKLh=m-tAQ@mail.gmail.com>
Subject: Re: [PATCH] kcov: convert kcov.refcount to refcount_t
To:     "Reshetova, Elena" <elena.reshetova@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Kees Cook <keescook@chromium.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 27, 2019 at 7:41 PM Reshetova, Elena
<elena.reshetova@intel.com> wrote:
>
> > On Mon, Jan 21, 2019 at 11:05:03AM -0500, Alan Stern wrote:
> > > On Mon, 21 Jan 2019, Peter Zijlstra wrote:
> >
> > > > Any additional ordering; like the one you have above; are not strictly
> > > > required for the proper functioning of the refcount. Rather, you rely on
> > > > additional ordering and will need to provide this explicitly:
> > > >
> > > >
> > > >   if (refcount_dec_and_text(&x->rc)) {
> > > >           /*
> > > >            * Comment that explains what we order against....
> > > >            */
> > > >           smp_mb__after_atomic();
> > > >           BUG_ON(!x->done*);
> > > >           free(x);
> > > >   }
> > > >
> > > >
> > > > Also; these patches explicitly mention that refcount_t is weaker,
> > > > specifically to make people aware of this difference.
> > > >
> > > > A full smp_mb() (or two) would also be much more expensive on a number
> > > > of platforms and in the vast majority of the cases it is not required.
> > >
> > > How about adding smp_rmb() into refcount_dec_and_test()?  That would
> > > give acq+rel semantics, which seems to be what people will expect.  And
> > >it wouldn't be nearly as expensive as a full smp_mb().
> >
> > Yes, that's a very good suggestion.
> >
> > I suppose we can add smp_acquire__after_ctrl_dep() on the true branch.
> > Then it reall does become rel_acq.
> >
> > A wee something like so (I couldn't find an arm64 refcount, even though
> > I have distinct memories of talk about it).
> >
> > This isn't compiled, and obviously needs comment/documentation updates
> > to go along with it.
> >
> > ---
> >  arch/x86/include/asm/refcount.h | 9 ++++++++-
> >  lib/refcount.c                  | 7 ++++++-
> >  2 files changed, 14 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/refcount.h b/arch/x86/include/asm/refcount.h
> > index dbaed55c1c24..6f7a1eb345b4 100644
> > --- a/arch/x86/include/asm/refcount.h
> > +++ b/arch/x86/include/asm/refcount.h
> > @@ -74,9 +74,16 @@ bool refcount_sub_and_test(unsigned int i, refcount_t *r)
> >
> >  static __always_inline __must_check bool refcount_dec_and_test(refcount_t *r)
> >  {
> > -     return GEN_UNARY_SUFFIXED_RMWcc(LOCK_PREFIX "decl",
> > +     bool ret = GEN_UNARY_SUFFIXED_RMWcc(LOCK_PREFIX "decl",
> >
> >       REFCOUNT_CHECK_LT_ZERO,
> >                                       r-
> > >refs.counter, e, "cx");
> > +
> > +     if (ret) {
> > +             smp_acquire__after_ctrl_dep();
> > +             return true;
> > +     }
> > +
> > +     return false;
> >  }
>
> Actually as I started to do this, any reason why the change here only for dec_and_test and not
> for sub_and _test also? Should not the arch. specific logic follow the generic?

I would say these should be exactly the same wrt semantics.
dec_and_test is just syntactic sugar for 1 decrement. If we change
dec_and_test, we should change sub_and_test the same way.
