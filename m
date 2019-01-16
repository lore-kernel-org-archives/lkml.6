Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206F8C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2DBE20675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uqmoPKZc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392860AbfAPMvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 07:51:46 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:36714 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390115AbfAPMvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 07:51:45 -0500
Received: by mail-it1-f193.google.com with SMTP id c9so2529418itj.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 04:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rETGl7o2fGs5+cpdOh+3cwNMQcwXj7xEC2JHUJhKfDA=;
        b=uqmoPKZcnF+a04u8AJ/n3tbnb1CqQVnkmub47jiv85mbmV59JDjmK0ggaAHn7sHQdt
         B8yFAwgS2WwN6ec2MehsI3QR0P8nNDB2NtVlqplKoki4rvR3zHBXjuiSXmBkfc8qBsAY
         eezUIcmImTHx7fid+SMag3mI28Qg+bb/MeMjB/X6vZAhtfuwriO6hGtvKP5KU6PDVp3S
         hAwHuxYVLfiPsyFRyqU40uivnDAWvUW+mwdKYhI+RJzFaRiTTQHD+THMCihfyo2X9yGu
         DRKzMVaNTU3X4aQyO2BPrLDQav6zz/6wvuHZYVHkVYGGLa1GIvKzESxCj2YeajEpqA+Z
         Lzvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rETGl7o2fGs5+cpdOh+3cwNMQcwXj7xEC2JHUJhKfDA=;
        b=HJMUVAxi3Iw4jsL7E7Y7uo18Dwssj2viUneBOcy9p4vgz5clM32gQuHycsxmnhwwUc
         ojZWpAbnvVcXzxMFwh34OytqKGp+7gD5olSWgsHRgSrG4bqmdsqom/OEN/9n9Qss0mhn
         sN1Zt068vWo53GfI4HJNxvavYz2cdBZ1QPOsUTA7pTZMgzL5E7Y6+749DCXWzEM89KUR
         08ZhHtg34Rtmt6JCv5GE1dyjgHzk5Zt6DHj+PADqvdOCcfvjfZhTPt21Rbu8Xdu1A+YS
         k6XjDzvBcU9ccCp9Q/iiByA6wHz4d9l2vchGApSm7hTGJ8nO9n1Xvw3A1lHiqHr8wAki
         6HhA==
X-Gm-Message-State: AJcUukfReXHtaDJPMWTP/VzqfZAQWRRVvB6HzkpzVVpl1jTaaIT7b5be
        jYtQxbjhquoxsthciE9QPxqCnSAPexeAN5P7l4GftUXI0mk=
X-Google-Smtp-Source: ALg8bN54XAUuvg9MBEM56pARJa8YteEpCgvNxtNCUp3jzZJhSMzRqRkucdXZsdupy35xV+iAqObNoL4v6z7U2HV8DIc=
X-Received: by 2002:a24:f14d:: with SMTP id q13mr1271642iti.166.1547643104451;
 Wed, 16 Jan 2019 04:51:44 -0800 (PST)
MIME-Version: 1.0
References: <1547634429-772-1-git-send-email-elena.reshetova@intel.com>
In-Reply-To: <1547634429-772-1-git-send-email-elena.reshetova@intel.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 16 Jan 2019 13:51:33 +0100
Message-ID: <CACT4Y+bWgcS=c=KrthWyyjjBpc72DEK-=czLYK8=SkmOsZ_-jg@mail.gmail.com>
Subject: Re: [PATCH] kcov: convert kcov.refcount to refcount_t
To:     Elena Reshetova <elena.reshetova@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 11:27 AM Elena Reshetova
<elena.reshetova@intel.com> wrote:
>
> atomic_t variables are currently used to implement reference
> counters with the following properties:
>  - counter is initialized to 1 using atomic_set()
>  - a resource is freed upon counter reaching zero
>  - once counter reaches zero, its further
>    increments aren't allowed
>  - counter schema uses basic atomic operations
>    (set, inc, inc_not_zero, dec_and_test, etc.)
>
> Such atomic variables should be converted to a newly provided
> refcount_t type and API that prevents accidental counter overflows
> and underflows. This is important since overflows and underflows
> can lead to use-after-free situation and be exploitable.
>
> The variable kcov.refcount is used as pure reference counter.
> Convert it to refcount_t and fix up the operations.
>
> **Important note for maintainers:
>
> Some functions from refcount_t API defined in lib/refcount.c
> have different memory ordering guarantees than their atomic
> counterparts.
> The full comparison can be seen in
> https://lkml.org/lkml/2017/11/15/57 and it is hopefully soon
> in state to be merged to the documentation tree.
> Normally the differences should not matter since refcount_t provides
> enough guarantees to satisfy the refcounting use cases, but in
> some rare cases it might matter.
> Please double check that you don't have some undocumented
> memory guarantees for this variable usage.
>
> For the kcov.refcount it might make a difference
> in following places:
>  - kcov_put(): decrement in refcount_dec_and_test() only
>    provides RELEASE ordering and control dependency on success
>    vs. fully ordered atomic counterpart

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

Thanks for improving this.

KCOV uses refcounts in a very simple canonical way, so no hidden
ordering implied.

Am I missing something or refcount_dec_and_test does not in fact
provide ACQUIRE ordering?

+case 5) - decrement-based RMW ops that return a value
+-----------------------------------------------------
+
+Function changes:
+                atomic_dec_and_test() --> refcount_dec_and_test()
+                atomic_sub_and_test() --> refcount_sub_and_test()
+                no atomic counterpart --> refcount_dec_if_one()
+                atomic_add_unless(&var, -1, 1) --> refcount_dec_not_one(&var)
+
+Memory ordering guarantees changes:
+                fully ordered --> RELEASE ordering + control dependency

I think that's against the expected refcount guarantees. When I
privatize an  atomic_dec_and_test I would expect that not only stores,
but also loads act on a quiescent object. But loads can hoist outside
of the control dependency.

Consider the following example, is it the case that the BUG_ON can still fire?

struct X {
  refcount_t rc; // == 2
  int done1, done2; // == 0
};

// thread 1:
x->done1 = 1;
if (refcount_dec_and_test(&x->rc))
  BUG_ON(!x->done2);

// thread 2:
x->done2 = 1;
if (refcount_dec_and_test(&x->rc))
  BUG_ON(!x->done1);



> Suggested-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: David Windsor <dwindsor@gmail.com>
> Reviewed-by: Hans Liljestrand <ishkamiel@gmail.com>
> Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
> ---
>  kernel/kcov.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/kcov.c b/kernel/kcov.c
> index c2277db..051e86e 100644
> --- a/kernel/kcov.c
> +++ b/kernel/kcov.c
> @@ -20,6 +20,7 @@
>  #include <linux/debugfs.h>
>  #include <linux/uaccess.h>
>  #include <linux/kcov.h>
> +#include <linux/refcount.h>
>  #include <asm/setup.h>
>
>  /* Number of 64-bit words written per one comparison: */
> @@ -44,7 +45,7 @@ struct kcov {
>          *  - opened file descriptor
>          *  - task with enabled coverage (we can't unwire it from another task)
>          */
> -       atomic_t                refcount;
> +       refcount_t              refcount;
>         /* The lock protects mode, size, area and t. */
>         spinlock_t              lock;
>         enum kcov_mode          mode;
> @@ -228,12 +229,12 @@ EXPORT_SYMBOL(__sanitizer_cov_trace_switch);
>
>  static void kcov_get(struct kcov *kcov)
>  {
> -       atomic_inc(&kcov->refcount);
> +       refcount_inc(&kcov->refcount);
>  }
>
>  static void kcov_put(struct kcov *kcov)
>  {
> -       if (atomic_dec_and_test(&kcov->refcount)) {
> +       if (refcount_dec_and_test(&kcov->refcount)) {
>                 vfree(kcov->area);
>                 kfree(kcov);
>         }
> @@ -312,7 +313,7 @@ static int kcov_open(struct inode *inode, struct file *filep)
>         if (!kcov)
>                 return -ENOMEM;
>         kcov->mode = KCOV_MODE_DISABLED;
> -       atomic_set(&kcov->refcount, 1);
> +       refcount_set(&kcov->refcount, 1);
>         spin_lock_init(&kcov->lock);
>         filep->private_data = kcov;
>         return nonseekable_open(inode, filep);
> --
> 2.7.4
>
