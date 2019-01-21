Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DFEC2F441
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7906820663
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XIIRtObZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfAURAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 12:00:49 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:55783 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfAURAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 12:00:49 -0500
Received: by mail-it1-f196.google.com with SMTP id m62so17291788ith.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 09:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iP0IE2NFj3pjp1sfMNE2ByYU55I+rsROGryB1fs1+9k=;
        b=XIIRtObZsN+3d3SivExBkJU2XVdTe8yVY7n0GqDd0Js68JtlM/tiXoGHResVC8OOeZ
         dxUJ/sefdRXHPMVJ/IZGorrzTRq7NE/qOtgPhM6D/3i4u2Ksjsyz2szaYmCIag9fAFQi
         DcYwBmA8Rp1BpGmJXQBVixOSmAdqcA0zJrephCbwwKkRkjKdb0AKWKESJ03Qv6DhxwJl
         CmvJPRAAwp/JOJAQXo2elSjOxX26IargGDQUJdWnlQNZRazoLPcm/Tb+0z2bi6iqwpsw
         XUM4ETb80K9YsKQXYiYHFttURxobdHyRBE1X3Eadf560XWG2Oj+MbRK3RZHoyFn8ptJx
         ykaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iP0IE2NFj3pjp1sfMNE2ByYU55I+rsROGryB1fs1+9k=;
        b=dRiSwF3GCmIAhTtBjOFUGqZgF4W44CK8HbPiztN5pmoLE+kQfly05avl8iUbTzvgxJ
         oqA3IcCH0rKNcxPUG4rdJ3PxUUmBtZ1XWDGfhP1gMj3fU6IcZQD4rqeqry6BO8Nnx6Lq
         TfVZx88dpCj5e0W5gEu0Xsygj/BXQwpOMfgsGbtt8sT7KVrcABODC6+gFuJWgbxuYrS1
         6hweBL974o8iOR0YY6Zcp5KN/R/ghjyBYRjP6tM1S1pxTQtFt6f27mLQ4dff5icLrSlX
         QfcIn1Go4OZuLEnUCJK2dzWo8DSnI6+y3i3iUQKCM6+g5MfRU7fem097T5LuNcZagKzw
         fyKg==
X-Gm-Message-State: AJcUukcopWEQK6bjToX5IFtvvLv8qkCiY+ipxfUkPrkymKOUGOUcA4+H
        rDdgGUhZgwPHOg/Xuzt+9Gv1PTV8AjhPeUXVTfarWg==
X-Google-Smtp-Source: ALg8bN5MCzVm58LdXMGwjNu8lb0k7F+/G2s2aoljJfLxTFSNMejIw795vj3KXskCaoASWWfEkRVEWEdcslEXXSvz7fA=
X-Received: by 2002:a05:660c:f94:: with SMTP id x20mr125526itl.144.1548090048433;
 Mon, 21 Jan 2019 09:00:48 -0800 (PST)
MIME-Version: 1.0
References: <20190121131816.GC17749@hirez.programming.kicks-ass.net> <Pine.LNX.4.44L0.1901211103000.24162-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1901211103000.24162-100000@netrider.rowland.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 21 Jan 2019 18:00:35 +0100
Message-ID: <CACT4Y+a-V036akpmmOeB0qhL7W8F=vVEue9+-p_qiDgzqJ4UiQ@mail.gmail.com>
Subject: Re: [PATCH] kcov: convert kcov.refcount to refcount_t
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
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

On Mon, Jan 21, 2019 at 5:05 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Mon, 21 Jan 2019, Peter Zijlstra wrote:
>
> > On Mon, Jan 21, 2019 at 10:52:37AM +0100, Dmitry Vyukov wrote:
> > > On Wed, Jan 16, 2019 at 1:51 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > > > KCOV uses refcounts in a very simple canonical way, so no hidden
> > > > ordering implied.
> > > >
> > > > Am I missing something or refcount_dec_and_test does not in fact
> > > > provide ACQUIRE ordering?
> > > >
> > > > +case 5) - decrement-based RMW ops that return a value
> > > > +-----------------------------------------------------
> > > > +
> > > > +Function changes:
> > > > +                atomic_dec_and_test() --> refcount_dec_and_test()
> > > > +                atomic_sub_and_test() --> refcount_sub_and_test()
> > > > +                no atomic counterpart --> refcount_dec_if_one()
> > > > +                atomic_add_unless(&var, -1, 1) --> refcount_dec_not_one(&var)
> > > > +
> > > > +Memory ordering guarantees changes:
> > > > +                fully ordered --> RELEASE ordering + control dependency
> > > >
> > > > I think that's against the expected refcount guarantees. When I
> > > > privatize an  atomic_dec_and_test I would expect that not only stores,
> > > > but also loads act on a quiescent object. But loads can hoist outside
> > > > of the control dependency.
> > > >
> > > > Consider the following example, is it the case that the BUG_ON can still fire?
> > > >
> > > > struct X {
> > > >   refcount_t rc; // == 2
> > > >   int done1, done2; // == 0
> > > > };
> > > >
> > > > // thread 1:
> > > > x->done1 = 1;
> > > > if (refcount_dec_and_test(&x->rc))
> > > >   BUG_ON(!x->done2);
> > > >
> > > > // thread 2:
> > > > x->done2 = 1;
> > > > if (refcount_dec_and_test(&x->rc))
> > > >   BUG_ON(!x->done1);
> >
> > I'm the one responsible for that refcount_t ordering.
> >
> > The rationale for REL+CTRL is that for the final put we want to ensure
> > all prior load/store are complete, because any later access could be a
> > UAF; consider:
> >
> >
> > P0()
> > {
> >       x->foo=0;
> >       if (refcount_dec_and_test(&x->rc))
> >               free(x);
> > }
> >
> > P1()
> > {
> >       x->bar=1;
> >       if (refcount_dec_and_test(&->rc))
> >               free(x);
> > }
> >
> >
> > without release, if would be possible for either (foo,bar) store to
> > happen after the free().
> >
> > Additionally we also need the CTRL to ensure that the actual free()
> > happens _after_ the dec_and_test, freeing early would be bad.
> >
> > But after these two requirements, the basic refcounting works.
> >
> > > The refcount_dec_and_test guarantees look too weak to me, see the
> > > example above. Shouldn't refcount_dec_and_test returning true give the
> > > object in fully quiescent state? Why only control dependency? Loads
> > > can hoist across control dependency, no?
> >
> > Yes, loads can escape like you say.
> >
> > Any additional ordering; like the one you have above; are not strictly
> > required for the proper functioning of the refcount. Rather, you rely on
> > additional ordering and will need to provide this explicitly:
> >
> >
> >       if (refcount_dec_and_text(&x->rc)) {
> >               /*
> >                * Comment that explains what we order against....
> >                */
> >               smp_mb__after_atomic();
> >               BUG_ON(!x->done*);
> >               free(x);
> >       }
> >
> >
> > Also; these patches explicitly mention that refcount_t is weaker,
> > specifically to make people aware of this difference.
> >
> > A full smp_mb() (or two) would also be much more expensive on a number
> > of platforms and in the vast majority of the cases it is not required.
>
> How about adding smp_rmb() into refcount_dec_and_test()?  That would
> give acq+rel semantics, which seems to be what people will expect.  And
> it wouldn't be nearly as expensive as a full smp_mb().

I would expect a ref count api to provide acquire on the last reference release.
Also, even if the code is correct when first submitted and the
developer has done the proper analysis, no acquire will be quite
fragile during subsequent changes: adding a load to a function that is
meant to "own" the object (e.g. a destructor) can subtly break things.
This does not affect x86, so mostly likely won't be noticed right
away, and even when noticed it can cost man-months to debug episodic
misbehaviors.
From the performance perspective the last release happens less often
than non-last releases, which already contain a barrier, and release
of the last reference usually contains more work (multiple kfree's,
scheduler calls, etc), so it should not be a deal breaker. From safe
API design perspective we can do it the other way around: provide a
safe default and an opt-in version without barrier and longer name for
cases where people do know what they are doing and each bit of
performance really matters.
