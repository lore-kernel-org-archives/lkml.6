Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70969C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 23:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 336AF20870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 23:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OesFrvNz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfAVXXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 18:23:03 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:36812 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfAVXXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 18:23:03 -0500
Received: by mail-ua1-f67.google.com with SMTP id j3so108768uap.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 15:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EpXWdqvCkEPWa6yAUiNF/XWYwIM8qsTQoY3KGOXsen0=;
        b=OesFrvNz3hNtpWMRMyd2qHuPWNXfed0smM4b4u9SdyeH4XYud4eGfRs5UJK9JZ4mZg
         y4f0NWsbM29zXGUQvIhxWFN3i0iOKFwbAYKgYEyecbb0VJvsgoC6n3ARxFJKSWBAPDI4
         q2CGJPiNtlg/YRMU4dYa4p7ujIEnhi5DdyCso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EpXWdqvCkEPWa6yAUiNF/XWYwIM8qsTQoY3KGOXsen0=;
        b=Vv6JBBaEorvEtyso0EFYGyC5lxr/Ztf8tZlVDMq0m+cMvHNDQwBnklMSdQkPQS4mYh
         bJnDjsawbqpezSTjdO28fWi5x9gHJzQAae8EhWgWWLSxll/WiJp5adFpCm6pYbxIjh7B
         DySt7kd7Kb7y41u0XfNCDN/whsTI0N2YTD4cJdz47NN7+a1ltRgOSEDIm6TE+Q5EJxmH
         WSsxIwvK7HfHf5hkCm1aare+rOiHgktvXYp+bFsVS6VsV6qY7BPnnCtvXcJjjDXHvwgM
         0TYHW6OWcoAI2ylnDz6+ZeA/HUmdnRhIOJ7guj5H3276tpCJ9Juq+qgMZfo1gcRSQfd/
         jHTA==
X-Gm-Message-State: AJcUukcQpGizJ0BtG8Pz1anlCgYNt2Oe0DzhXeMXWivqjk/CvyqycDD2
        JwhuRdG5mqZ8Vte/Vv2c2ImiAv4SLHo=
X-Google-Smtp-Source: ALg8bN74y6oF5i8rdSaPEc3UqdvDHsvfyqs1m7q0k8mBDB5OhluIRMrXOrBQ8rE27X3gwpBN+1hKzg==
X-Received: by 2002:ab0:30b5:: with SMTP id b21mr5921905uam.69.1548199381432;
        Tue, 22 Jan 2019 15:23:01 -0800 (PST)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id e67sm25267903vsd.32.2019.01.22.15.22.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 15:22:58 -0800 (PST)
Received: by mail-vs1-f46.google.com with SMTP id n13so198600vsk.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 15:22:57 -0800 (PST)
X-Received: by 2002:a67:848a:: with SMTP id g132mr14558030vsd.222.1548199377420;
 Tue, 22 Jan 2019 15:22:57 -0800 (PST)
MIME-Version: 1.0
References: <20190121131816.GC17749@hirez.programming.kicks-ass.net>
 <Pine.LNX.4.44L0.1901211103000.24162-100000@netrider.rowland.org> <20190122090456.GE13777@hirez.programming.kicks-ass.net>
In-Reply-To: <20190122090456.GE13777@hirez.programming.kicks-ass.net>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 23 Jan 2019 12:22:44 +1300
X-Gmail-Original-Message-ID: <CAGXu5jKHo4CZWAnn4Wvg=MV=xaf3j4mBvxggBHuZETTkMOxkOA@mail.gmail.com>
Message-ID: <CAGXu5jKHo4CZWAnn4Wvg=MV=xaf3j4mBvxggBHuZETTkMOxkOA@mail.gmail.com>
Subject: Re: [PATCH] kcov: convert kcov.refcount to refcount_t
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Dmitry Vyukov <dvyukov@google.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
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

On Tue, Jan 22, 2019 at 10:05 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Jan 21, 2019 at 11:05:03AM -0500, Alan Stern wrote:
> > On Mon, 21 Jan 2019, Peter Zijlstra wrote:
>
> > > Any additional ordering; like the one you have above; are not strictly
> > > required for the proper functioning of the refcount. Rather, you rely on
> > > additional ordering and will need to provide this explicitly:
> > >
> > >
> > >     if (refcount_dec_and_text(&x->rc)) {
> > >             /*
> > >              * Comment that explains what we order against....
> > >              */
> > >             smp_mb__after_atomic();
> > >             BUG_ON(!x->done*);
> > >             free(x);
> > >     }
> > >
> > >
> > > Also; these patches explicitly mention that refcount_t is weaker,
> > > specifically to make people aware of this difference.
> > >
> > > A full smp_mb() (or two) would also be much more expensive on a number
> > > of platforms and in the vast majority of the cases it is not required.
> >
> > How about adding smp_rmb() into refcount_dec_and_test()?  That would
> > give acq+rel semantics, which seems to be what people will expect.  And
> > it wouldn't be nearly as expensive as a full smp_mb().
>
> Yes, that's a very good suggestion.
>
> I suppose we can add smp_acquire__after_ctrl_dep() on the true branch.
> Then it reall does become rel_acq.
>
> A wee something like so (I couldn't find an arm64 refcount, even though
> I have distinct memories of talk about it).

In the end, arm and arm64 chose to use REFCOUNT_FULL unconditionally,
so there's no arch-specific implementation.

> This isn't compiled, and obviously needs comment/documentation updates
> to go along with it.

Elena, can you do the doc updates?

>
> ---
>  arch/x86/include/asm/refcount.h | 9 ++++++++-
>  lib/refcount.c                  | 7 ++++++-
>  2 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/include/asm/refcount.h b/arch/x86/include/asm/refcount.h
> index dbaed55c1c24..6f7a1eb345b4 100644
> --- a/arch/x86/include/asm/refcount.h
> +++ b/arch/x86/include/asm/refcount.h
> @@ -74,9 +74,16 @@ bool refcount_sub_and_test(unsigned int i, refcount_t *r)
>
>  static __always_inline __must_check bool refcount_dec_and_test(refcount_t *r)
>  {
> -       return GEN_UNARY_SUFFIXED_RMWcc(LOCK_PREFIX "decl",
> +       bool ret = GEN_UNARY_SUFFIXED_RMWcc(LOCK_PREFIX "decl",
>                                         REFCOUNT_CHECK_LT_ZERO,
>                                         r->refs.counter, e, "cx");
> +
> +       if (ret) {
> +               smp_acquire__after_ctrl_dep();
> +               return true;
> +       }
> +
> +       return false;
>  }
>
>  static __always_inline __must_check
> diff --git a/lib/refcount.c b/lib/refcount.c
> index ebcf8cd49e05..8276ad349d48 100644
> --- a/lib/refcount.c
> +++ b/lib/refcount.c
> @@ -190,7 +190,12 @@ bool refcount_sub_and_test_checked(unsigned int i, refcount_t *r)
>
>         } while (!atomic_try_cmpxchg_release(&r->refs, &val, new));
>
> -       return !new;
> +       if (!new) {
> +               smp_acquire__after_ctrl_dep();
> +               return true;
> +       }
> +
> +       return false;
>  }
>  EXPORT_SYMBOL(refcount_sub_and_test_checked);
>

Thanks for this!

-- 
Kees Cook
