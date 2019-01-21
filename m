Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777EAC2F3A6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38C6B2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aMEO1IhS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbfAUMm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 07:42:56 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:55453 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728163AbfAUMm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 07:42:56 -0500
Received: by mail-it1-f195.google.com with SMTP id m62so16175914ith.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 04:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qLCAMNY8ip350mbuKSMyKuBtoSJ499QiUIVKiUAfvRU=;
        b=aMEO1IhSZvD26ww6BhGKkmBr2Sc4RiOmJuZuX6s5Y5x0sh3SHFJiETs0j4frdA9BGK
         mwAG1DmARyDcloVIcKDsjg5tAnRhAvgDo5VnzQjU2wLHPuI75DvXfaePl+//8n2NlDRQ
         ZJBPQyhboiAzNxHp/1p33QFUVWp6p9BtO+CyRbSRm+nCjhbyrLRZvrus3jUhDOFoiAW3
         oq6GduNu44WFW3cqirLnjpE/95ub9tukzmcXQi1KE6Sw58F8HVVek1eSjdzhLwndQGTN
         /dUmyO+KezO2sQ6YKZW8GtP5zD7DsXJBBuU0fiWP9YcWSzFdyw6wC93xMiPHlql0BawZ
         hGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qLCAMNY8ip350mbuKSMyKuBtoSJ499QiUIVKiUAfvRU=;
        b=ZEiERe+atDuPo38GDRev2aI21OFNwUkBTx4Gu2N36z5muaMAvqNnxK9/O1TPIfYq7k
         gq7u3Xyk5W0Y5xap+gwGMYhiNtYU4vnrJRiedZH1BrTs6TpUsDXo5f6Fo4O62rrtptrn
         24JHvk4xzZ2yjwuH+SxSD9SW5nBObK8YOoVNGjTWfJJWwvuiyG4CWOMRkty+wltD/7Np
         AnNWVSarbgMqKkNmuFy9HIjnt+rL81UJj7LhMBPTxj9uz1QR7VJBUy7n6dPnXPTY2SlR
         k1+UfNq1dbApDhdKv6L7KlPUXx8bn0olrD//ZnAf3zebzsQBZ3StMi5wviMgidBqpYXb
         ffvA==
X-Gm-Message-State: AJcUukdvYKH2FhKxjipwopGdc6iPhxO5tFTyXtGlBun53y54ZxV4luud
        LQPi7mPuVvkZq7d5D2wcrd30N/7591kw/+2005HRVw==
X-Google-Smtp-Source: ALg8bN46GfMjvMjZCL2CrR2YGfdPkkOHPYevOWRq9+Oiy95ImdDTyxRqvZGd+bqbnuMeZCebgHHmOx28v3DP2djxjWE=
X-Received: by 2002:a02:ac8c:: with SMTP id x12mr15856810jan.72.1548074574520;
 Mon, 21 Jan 2019 04:42:54 -0800 (PST)
MIME-Version: 1.0
References: <1547634429-772-1-git-send-email-elena.reshetova@intel.com> <20190121123836.GC47506@lakrids.cambridge.arm.com>
In-Reply-To: <20190121123836.GC47506@lakrids.cambridge.arm.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 21 Jan 2019 13:42:43 +0100
Message-ID: <CACT4Y+Y6JNyQ+SSZXDSYVcBXZ_e1Hf3OMpoz=1eqGNhNKqYikg@mail.gmail.com>
Subject: Re: [PATCH] kcov: convert kcov.refcount to refcount_t
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Elena Reshetova <elena.reshetova@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 1:38 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Wed, Jan 16, 2019 at 12:27:09PM +0200, Elena Reshetova wrote:
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
> >
> > Suggested-by: Kees Cook <keescook@chromium.org>
> > Reviewed-by: David Windsor <dwindsor@gmail.com>
> > Reviewed-by: Hans Liljestrand <ishkamiel@gmail.com>
> > Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
>
> Just to check, has this been tested with CONFIG_REFCOUNT_FULL and
> something poking kcov?
>
> Given lib/refcount.c is instrumented, the refcount_*() calls will
> recurse back into the kcov code. It looks like that's fine, given these
> are only manipulated in setup/teardown paths, but it would be nice to be
> sure.

A simple program using KCOV is available here:
https://elixir.bootlin.com/linux/v5.0-rc3/source/Documentation/dev-tools/kcov.rst#L42
or here (it's like strace but collects and prints KCOV coverage):
https://github.com/google/syzkaller/blob/master/tools/kcovtrace/kcovtrace.c

> Thanks,
> Mark.
>
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
> >        *  - opened file descriptor
> >        *  - task with enabled coverage (we can't unwire it from another task)
> >        */
> > -     atomic_t                refcount;
> > +     refcount_t              refcount;
> >       /* The lock protects mode, size, area and t. */
> >       spinlock_t              lock;
> >       enum kcov_mode          mode;
> > @@ -228,12 +229,12 @@ EXPORT_SYMBOL(__sanitizer_cov_trace_switch);
> >
> >  static void kcov_get(struct kcov *kcov)
> >  {
> > -     atomic_inc(&kcov->refcount);
> > +     refcount_inc(&kcov->refcount);
> >  }
> >
> >  static void kcov_put(struct kcov *kcov)
> >  {
> > -     if (atomic_dec_and_test(&kcov->refcount)) {
> > +     if (refcount_dec_and_test(&kcov->refcount)) {
> >               vfree(kcov->area);
> >               kfree(kcov);
> >       }
> > @@ -312,7 +313,7 @@ static int kcov_open(struct inode *inode, struct file *filep)
> >       if (!kcov)
> >               return -ENOMEM;
> >       kcov->mode = KCOV_MODE_DISABLED;
> > -     atomic_set(&kcov->refcount, 1);
> > +     refcount_set(&kcov->refcount, 1);
> >       spin_lock_init(&kcov->lock);
> >       filep->private_data = kcov;
> >       return nonseekable_open(inode, filep);
> > --
> > 2.7.4
> >
