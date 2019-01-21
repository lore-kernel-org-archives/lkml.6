Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C106C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 638B9214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R6dmdIVT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbfAUJwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 04:52:51 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:38496 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfAUJwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 04:52:50 -0500
Received: by mail-it1-f195.google.com with SMTP id h65so14329113ith.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 01:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zDiKq1hOhznwRBdFg+iTPKFfdzetvRsqw7ML34AIuAM=;
        b=R6dmdIVTI+MJ4OGmfuZAkPm+ixJKiNoeTjF+HOA+1ZqgBHWkdjsiffYfnA/rPCLORx
         FsOrWowyte37QHDONStBHpmdUuEuoglw8/fzGa44VtrEq8mn9QHmRxzLX7zWaV3mLtP8
         6lMyDkDsaHFjAj38j3nSJmYvf+IbTe81VCmHW+xP0Pg3p+GkW7u38WXWHUKRYMiibCMH
         tSWVZdrjZsB8l22UTZfTI+jMdDvD/bXZ9eV9FM66vGZmRiOeN1bqcUC0Giux3Dme+lRZ
         qJw8cpU15ySa+9UfnL7Mso2YNr6BaMsoG7lN/Htpo090q+3vNaSg/ctxkIoKMOeide1Z
         fv0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zDiKq1hOhznwRBdFg+iTPKFfdzetvRsqw7ML34AIuAM=;
        b=XWnqHDvcnsRIxDIEaeMH57BmxQ/p0Wd1/YfIpC+Xr06B1up6DDTOfmRQgrwIDm8slk
         RU7irJVeS4OzehTFhj4cSFZp02ynJGUDqLawyWe+gY9xDARXnMOBivsxBRLDPjrieran
         n0fsS5j8PdSnnGZmod6ocxlf/zKf5qV1XSN0UjnSs6r1yMktw8bJkoVLSrDVQGe290s4
         xEtpRdEbGvl3T0IDLgGhVeP2iqT2s2YaI4VtNjPWgEZX6MHy0MYsNXWfKxt5Qws/FqWL
         Fc3ntrTwGlqc50idAw3kyPw0TuBR55e4uB/0Njj8d5cH7kbhpgZi0O+ylGy+kbGMkZ7H
         o31A==
X-Gm-Message-State: AJcUukda3fNX5KRCM0t0b3RvaAeH2oyHy1k8JtXd99P5DdSuBaofzqwD
        ZPalo5JXTJxuzRZ0jpRXCYS3twQpsVXl2BOFZtyXWQ==
X-Google-Smtp-Source: ALg8bN6cH1IOLA+EWRWxObA3v+3RPm2hm0sFWgX4wtIJdOFwHR7lCfpz+ubQMhXYEbtQ1GYKHg9z2CzXwJJVOIz0FqY=
X-Received: by 2002:a02:ac8c:: with SMTP id x12mr15558711jan.72.1548064368495;
 Mon, 21 Jan 2019 01:52:48 -0800 (PST)
MIME-Version: 1.0
References: <1547634429-772-1-git-send-email-elena.reshetova@intel.com> <CACT4Y+bWgcS=c=KrthWyyjjBpc72DEK-=czLYK8=SkmOsZ_-jg@mail.gmail.com>
In-Reply-To: <CACT4Y+bWgcS=c=KrthWyyjjBpc72DEK-=czLYK8=SkmOsZ_-jg@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 21 Jan 2019 10:52:37 +0100
Message-ID: <CACT4Y+a6-YyrwZ9qX+yhhMuoPoZ5=B-NKxkn-EyFqijNBf4N+g@mail.gmail.com>
Subject: Re: [PATCH] kcov: convert kcov.refcount to refcount_t
To:     Elena Reshetova <elena.reshetova@intel.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 1:51 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Wed, Jan 16, 2019 at 11:27 AM Elena Reshetova
> <elena.reshetova@intel.com> wrote:
> >
> > atomic_t variables are currently used to implement reference
> > counters with the following properties:
> >  - counter is initialized to 1 using atomic_set()
> >  - a resource is freed upon counter reaching zero
> >  - once counter reaches zero, its further
> >    increments aren't allowed
> >  - counter schema uses basic atomic operations
> >    (set, inc, inc_not_zero, dec_and_test, etc.)
> >
> > Such atomic variables should be converted to a newly provided
> > refcount_t type and API that prevents accidental counter overflows
> > and underflows. This is important since overflows and underflows
> > can lead to use-after-free situation and be exploitable.
> >
> > The variable kcov.refcount is used as pure reference counter.
> > Convert it to refcount_t and fix up the operations.
> >
> > **Important note for maintainers:
> >
> > Some functions from refcount_t API defined in lib/refcount.c
> > have different memory ordering guarantees than their atomic
> > counterparts.
> > The full comparison can be seen in
> > https://lkml.org/lkml/2017/11/15/57 and it is hopefully soon
> > in state to be merged to the documentation tree.
> > Normally the differences should not matter since refcount_t provides
> > enough guarantees to satisfy the refcounting use cases, but in
> > some rare cases it might matter.
> > Please double check that you don't have some undocumented
> > memory guarantees for this variable usage.
> >
> > For the kcov.refcount it might make a difference
> > in following places:
> >  - kcov_put(): decrement in refcount_dec_and_test() only
> >    provides RELEASE ordering and control dependency on success
> >    vs. fully ordered atomic counterpart
>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
>
> Thanks for improving this.
>
> KCOV uses refcounts in a very simple canonical way, so no hidden
> ordering implied.
>
> Am I missing something or refcount_dec_and_test does not in fact
> provide ACQUIRE ordering?
>
> +case 5) - decrement-based RMW ops that return a value
> +-----------------------------------------------------
> +
> +Function changes:
> +                atomic_dec_and_test() --> refcount_dec_and_test()
> +                atomic_sub_and_test() --> refcount_sub_and_test()
> +                no atomic counterpart --> refcount_dec_if_one()
> +                atomic_add_unless(&var, -1, 1) --> refcount_dec_not_one(&var)
> +
> +Memory ordering guarantees changes:
> +                fully ordered --> RELEASE ordering + control dependency
>
> I think that's against the expected refcount guarantees. When I
> privatize an  atomic_dec_and_test I would expect that not only stores,
> but also loads act on a quiescent object. But loads can hoist outside
> of the control dependency.
>
> Consider the following example, is it the case that the BUG_ON can still fire?
>
> struct X {
>   refcount_t rc; // == 2
>   int done1, done2; // == 0
> };
>
> // thread 1:
> x->done1 = 1;
> if (refcount_dec_and_test(&x->rc))
>   BUG_ON(!x->done2);
>
> // thread 2:
> x->done2 = 1;
> if (refcount_dec_and_test(&x->rc))
>   BUG_ON(!x->done1);

+more people knowledgeable in memory ordering

Unfortunately I can't find a way to reply to the
Documentation/core-api/refcount-vs-atomic.rst patch review thread.

The refcount_dec_and_test guarantees look too weak to me, see the
example above. Shouldn't refcount_dec_and_test returning true give the
object in fully quiescent state? Why only control dependency? Loads
can hoist across control dependency, no?



> > Suggested-by: Kees Cook <keescook@chromium.org>
> > Reviewed-by: David Windsor <dwindsor@gmail.com>
> > Reviewed-by: Hans Liljestrand <ishkamiel@gmail.com>
> > Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
> > ---
> >  kernel/kcov.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/kcov.c b/kernel/kcov.c
> > index c2277db..051e86e 100644
> > --- a/kernel/kcov.c
> > +++ b/kernel/kcov.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/debugfs.h>
> >  #include <linux/uaccess.h>
> >  #include <linux/kcov.h>
> > +#include <linux/refcount.h>
> >  #include <asm/setup.h>
> >
> >  /* Number of 64-bit words written per one comparison: */
> > @@ -44,7 +45,7 @@ struct kcov {
> >          *  - opened file descriptor
> >          *  - task with enabled coverage (we can't unwire it from another task)
> >          */
> > -       atomic_t                refcount;
> > +       refcount_t              refcount;
> >         /* The lock protects mode, size, area and t. */
> >         spinlock_t              lock;
> >         enum kcov_mode          mode;
> > @@ -228,12 +229,12 @@ EXPORT_SYMBOL(__sanitizer_cov_trace_switch);
> >
> >  static void kcov_get(struct kcov *kcov)
> >  {
> > -       atomic_inc(&kcov->refcount);
> > +       refcount_inc(&kcov->refcount);
> >  }
> >
> >  static void kcov_put(struct kcov *kcov)
> >  {
> > -       if (atomic_dec_and_test(&kcov->refcount)) {
> > +       if (refcount_dec_and_test(&kcov->refcount)) {
> >                 vfree(kcov->area);
> >                 kfree(kcov);
> >         }
> > @@ -312,7 +313,7 @@ static int kcov_open(struct inode *inode, struct file *filep)
> >         if (!kcov)
> >                 return -ENOMEM;
> >         kcov->mode = KCOV_MODE_DISABLED;
> > -       atomic_set(&kcov->refcount, 1);
> > +       refcount_set(&kcov->refcount, 1);
> >         spin_lock_init(&kcov->lock);
> >         filep->private_data = kcov;
> >         return nonseekable_open(inode, filep);
> > --
> > 2.7.4
> >
