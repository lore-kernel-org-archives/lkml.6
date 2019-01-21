Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99892C7113B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CBF22084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sizwidYd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbfAUM3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 07:29:24 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:44764 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728299AbfAUM3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 07:29:24 -0500
Received: by mail-io1-f67.google.com with SMTP id r200so16192188iod.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 04:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cVqSnm1+Gomh9R6fjm5+J2p/n3A44tXQxbOzw7X1r5Q=;
        b=sizwidYd8GWX+Pfn/P39TN3P3JXvkhe/GzVgoEL1Tfk1ER3CMsaWG+mzvX7Ul1wu6s
         3Nh6uN1wsQhXOjsac2gom26cNzLuB1HPaPEEW3Z8U5QTarEJxVSRKPDe6NmzokOieruf
         Ct8zFq7FU585So/E5moZH3juOrNMeYlrDCxbFiaiW/yqxO2yMRsT3FUinflw41sTcsnm
         MLFH7OFI12B9Rcp1s8iimVHGc5Wjxrd7wI+yG619NRXoqcpMmAWxq20H2mXV3TjgRukL
         3CrpUhlnf/byPU3olWNeFAHKPZSEBiXQAq6VabRwEiAi2tjYoE6Kq/Sik6tobHyWkpSb
         r/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cVqSnm1+Gomh9R6fjm5+J2p/n3A44tXQxbOzw7X1r5Q=;
        b=C7r72v+pwaPcdOMNqUbuCGvvUVq/Vkc7os8qEK2IAhJ5XLfWhidRZqvY6jUyL+C9G/
         QEIQujoHkeXqxvonNsu+Jc09kDE1LD4TvU/pkvCzuVs27LZL0lmtKeeggGrMHkZ26Aoy
         H5KzrKNzZOBF/am/wTGwmjM/KhT/RZqPY35YRKHdgNlgbhZjwylBObt2YWKubJz+rOIR
         MTYYVpHYR77F4WmMBSw3nbCG0zavY8dTdhDQw+Hr0mhO+WBP7YuCDJAz4mkJdab76KJs
         oSg3RW49RZZoqjSpaXpqFr73amdHo97Dz4hhVNIeU7iNVzGDx+J2ty20mffofaJUHjJa
         LHXQ==
X-Gm-Message-State: AJcUuke5ITy7VhpTJdeCK9vbJ361z2defmOnL+mttr0JI6gGMtYEwJrB
        uIX2zrVECflvi5vC5gIyU3O7lbf8q+4vn5GRvFL5/w==
X-Google-Smtp-Source: ALg8bN6e11giq5uaAOZYzC+Y4IS7ZtWVbFvufqx5QEKQDg+bdSlZBLteSH0CI4bAI3NhAJJ2baBm0h6IohEttmTJOgM=
X-Received: by 2002:a6b:fa01:: with SMTP id p1mr15180792ioh.271.1548073762606;
 Mon, 21 Jan 2019 04:29:22 -0800 (PST)
MIME-Version: 1.0
References: <1547634429-772-1-git-send-email-elena.reshetova@intel.com>
 <CACT4Y+bWgcS=c=KrthWyyjjBpc72DEK-=czLYK8=SkmOsZ_-jg@mail.gmail.com>
 <CACT4Y+a6-YyrwZ9qX+yhhMuoPoZ5=B-NKxkn-EyFqijNBf4N+g@mail.gmail.com> <20190121114505.GA7307@andrea>
In-Reply-To: <20190121114505.GA7307@andrea>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 21 Jan 2019 13:29:11 +0100
Message-ID: <CACT4Y+aF8+RqEk8RJn3G4nN8bCAxuci5W9YXa=cFq4c-QC3kgg@mail.gmail.com>
Subject: Re: [PATCH] kcov: convert kcov.refcount to refcount_t
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     Elena Reshetova <elena.reshetova@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
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

 On Mon, Jan 21, 2019 at 12:45 PM Andrea Parri
<andrea.parri@amarulasolutions.com> wrote:
>
> On Mon, Jan 21, 2019 at 10:52:37AM +0100, Dmitry Vyukov wrote:
>
> [...]
>
> > > Am I missing something or refcount_dec_and_test does not in fact
> > > provide ACQUIRE ordering?
> > >
> > > +case 5) - decrement-based RMW ops that return a value
> > > +-----------------------------------------------------
> > > +
> > > +Function changes:
> > > +                atomic_dec_and_test() --> refcount_dec_and_test()
> > > +                atomic_sub_and_test() --> refcount_sub_and_test()
> > > +                no atomic counterpart --> refcount_dec_if_one()
> > > +                atomic_add_unless(&var, -1, 1) --> refcount_dec_not_one(&var)
> > > +
> > > +Memory ordering guarantees changes:
> > > +                fully ordered --> RELEASE ordering + control dependency
> > >
> > > I think that's against the expected refcount guarantees. When I
> > > privatize an  atomic_dec_and_test I would expect that not only stores,
> > > but also loads act on a quiescent object. But loads can hoist outside
> > > of the control dependency.
> > >
> > > Consider the following example, is it the case that the BUG_ON can still fire?
>
> Can't it fire in an SC world? (wrong example, or a Monday morning? ;D)

I don't see how. Maybe there is a stupid off-by-one, but overall
that's the example I wanted to show. refcount is 2, each thread sets
own done flag, drops refcount, last thread checks done flag of the
other thread.



> > > struct X {
> > >   refcount_t rc; // == 2
> > >   int done1, done2; // == 0
> > > };
> > >
> > > // thread 1:
> > > x->done1 = 1;
> > > if (refcount_dec_and_test(&x->rc))
> > >   BUG_ON(!x->done2);
> > >
> > > // thread 2:
> > > x->done2 = 1;
> > > if (refcount_dec_and_test(&x->rc))
> > >   BUG_ON(!x->done1);
> >
> > +more people knowledgeable in memory ordering
> >
> > Unfortunately I can't find a way to reply to the
> > Documentation/core-api/refcount-vs-atomic.rst patch review thread.
> >
> > The refcount_dec_and_test guarantees look too weak to me, see the
> > example above. Shouldn't refcount_dec_and_test returning true give the
> > object in fully quiescent state? Why only control dependency? Loads
> > can hoist across control dependency, no?
>
> As you remarked, the doc. says CTRL+RELEASE (so yes, loads can hoist);
> AFAICR, implementations do comply to this requirement.
>
> (FWIW, I sometimes think at this "weird" ordering as a weak "acq_rel",
>  the latter, acq_rel, being missing from the current APIs.)

But doesn't it break like half of use cases?

Iv'e skimmed through few uses. This read of db_info->views after
refcount_dec_and_test looks like potential unordered read:
https://elixir.bootlin.com/linux/v5.0-rc3/source/arch/s390/kernel/debug.c#L412

This read of vdata->maddr after refcount_dec_and_test looks like
potential unordered read:
https://elixir.bootlin.com/linux/v5.0-rc3/source/drivers/char/mspec.c#L171

This read of buf->sgt_base looks like potential unordered read:
https://elixir.bootlin.com/linux/v5.0-rc3/source/drivers/media/common/videobuf2/videobuf2-dma-contig.c#L129

Also this:
https://elixir.bootlin.com/linux/v5.0-rc3/source/fs/btrfs/scrub.c#L544
and this:
https://elixir.bootlin.com/linux/v5.0-rc3/source/fs/nfs/inode.c#L992

For each case it's quite hard to prove if there is anything else that
provides read ordering, or if the field was initialized before the
object was first published and then never changed. But overall, why
are we making it so error-prone and subtle?


> > > > Suggested-by: Kees Cook <keescook@chromium.org>
> > > > Reviewed-by: David Windsor <dwindsor@gmail.com>
> > > > Reviewed-by: Hans Liljestrand <ishkamiel@gmail.com>
> > > > Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
> > > > ---
> > > >  kernel/kcov.c | 9 +++++----
> > > >  1 file changed, 5 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/kernel/kcov.c b/kernel/kcov.c
> > > > index c2277db..051e86e 100644
> > > > --- a/kernel/kcov.c
> > > > +++ b/kernel/kcov.c
> > > > @@ -20,6 +20,7 @@
> > > >  #include <linux/debugfs.h>
> > > >  #include <linux/uaccess.h>
> > > >  #include <linux/kcov.h>
> > > > +#include <linux/refcount.h>
> > > >  #include <asm/setup.h>
> > > >
> > > >  /* Number of 64-bit words written per one comparison: */
> > > > @@ -44,7 +45,7 @@ struct kcov {
> > > >          *  - opened file descriptor
> > > >          *  - task with enabled coverage (we can't unwire it from another task)
> > > >          */
> > > > -       atomic_t                refcount;
> > > > +       refcount_t              refcount;
> > > >         /* The lock protects mode, size, area and t. */
> > > >         spinlock_t              lock;
> > > >         enum kcov_mode          mode;
> > > > @@ -228,12 +229,12 @@ EXPORT_SYMBOL(__sanitizer_cov_trace_switch);
> > > >
> > > >  static void kcov_get(struct kcov *kcov)
> > > >  {
> > > > -       atomic_inc(&kcov->refcount);
> > > > +       refcount_inc(&kcov->refcount);
> > > >  }
> > > >
> > > >  static void kcov_put(struct kcov *kcov)
> > > >  {
> > > > -       if (atomic_dec_and_test(&kcov->refcount)) {
> > > > +       if (refcount_dec_and_test(&kcov->refcount)) {
> > > >                 vfree(kcov->area);
> > > >                 kfree(kcov);
> > > >         }
> > > > @@ -312,7 +313,7 @@ static int kcov_open(struct inode *inode, struct file *filep)
> > > >         if (!kcov)
> > > >                 return -ENOMEM;
> > > >         kcov->mode = KCOV_MODE_DISABLED;
> > > > -       atomic_set(&kcov->refcount, 1);
> > > > +       refcount_set(&kcov->refcount, 1);
> > > >         spin_lock_init(&kcov->lock);
> > > >         filep->private_data = kcov;
> > > >         return nonseekable_open(inode, filep);
> > > > --
> > > > 2.7.4
> > > >
