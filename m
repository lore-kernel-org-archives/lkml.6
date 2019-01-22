Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C25C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC1ED2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qWaoapor"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfAVKMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:12:17 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:55593 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfAVKMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 05:12:17 -0500
Received: by mail-it1-f193.google.com with SMTP id m62so20521599ith.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 02:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qlJATULT4hazjvfGK4NYpVOgm0Sh9BbR6oZEuDYHwYQ=;
        b=qWaoaporDypT3ZRAg5ywetlOktU3YqDGCjG7AnNFuC3V7kkkULcU/CQxLkHYXUF+x/
         b5lmJDd1zpzYSXUO0znN3yB9DBefiy77gdeSyclUJiDvrrSYnc0aBBQ2K3cjAPPJLHTY
         XEWAKL0QNSPi4XRjyObbEEUI6ohVseZAgIlGFzdvw9r2GN4PpR3QC2fx7UkH3Jrrbn52
         6wuKpqhDO7s0fDxGZeAGBysWavc7EFB+GjlYh6zQGY2idrK7TSWfixGtaWGllwf3I9Vk
         DXBmql2yIEg1F+zZ202w+FWCLXvnjdN0vAGMFVqSwnkApa8EeEgeEU62z/U2k60aRjrb
         gFcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qlJATULT4hazjvfGK4NYpVOgm0Sh9BbR6oZEuDYHwYQ=;
        b=rTNiohxm7d+mYig6wH1a8Qy3F/Oe2ziIUtHHOGysxX4rhvkzDin1poGXKyaspFRh0f
         sqrLuI9BWm0y2NC591xYSm+KMmBLtnaVGlWoLuDnyhGcO+cUwGh4o3pQCOtaJSm8l6jf
         jFhEiXjxAD1YgaN5LKZ6C5JTDQkfTd9r6AVCSi8Lbm7LwQ0WpvujkFJnj5lGi1Q2gICU
         i0+XWf3WN28IyDgD1RJUoXtWdFVcflps9x4NUPi+EF/Ex2h9FgxuQ4w+mBA5GK0FBNkP
         t/+w0xQrhlVzDXhsYKdULcKSzwCq3XXf6on/A8QKXjDujvY/V8JibwTTBnWmr/tJPa1r
         Cn3g==
X-Gm-Message-State: AJcUukehDrJ7a5SHVjPsP81Glh/fCof0BKQJoCNzHABii6vGpJq9PdOQ
        dEe4n4BrxH1jU4NCobxBzRCbtqSn+rT3lpMdv1kZYQ==
X-Google-Smtp-Source: ALg8bN7aTbQMNuir1JTRpUsVdwRidIcv47/71jblvz33tQDaeKB/vnWq0sdDXSKXuTTIjoEMHVSdN27XEfJBcSpGkz8=
X-Received: by 2002:a02:97a2:: with SMTP id s31mr19115716jaj.82.1548151936025;
 Tue, 22 Jan 2019 02:12:16 -0800 (PST)
MIME-Version: 1.0
References: <000000000000f7a28e057653dc6e@google.com> <20180920141058.4ed467594761e073606eafe2@linux-foundation.org>
 <CAHRSSEzX5HOUEQ6DgEF76OLGrwS1isWMdtvneBLOEEnwoMxVrA@mail.gmail.com>
 <CAEXW_YSot+3AMQ=jmDRowmqoOmQmujp9r8Dh18KJJN1EDmyHOw@mail.gmail.com>
 <20180921162110.e22d09a9e281d194db3c8359@linux-foundation.org> <4b0a5f8c-2be2-db38-a70d-8d497cb67665@I-love.SAKURA.ne.jp>
In-Reply-To: <4b0a5f8c-2be2-db38-a70d-8d497cb67665@I-love.SAKURA.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 22 Jan 2019 11:12:04 +0100
Message-ID: <CACT4Y+ZTjCGd9XYUCUoqv+AqXrPwX4OqWMC0jFgjNxZRFkNYXw@mail.gmail.com>
Subject: Re: possible deadlock in __do_page_fault
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        syzbot+a76129f18c89f3e2ddd4@syzkaller.appspotmail.com,
        Andi Kleen <ak@linux.intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 11:02 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2018/09/22 8:21, Andrew Morton wrote:
> > On Thu, 20 Sep 2018 19:33:15 -0400 Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> >> On Thu, Sep 20, 2018 at 5:12 PM Todd Kjos <tkjos@google.com> wrote:
> >>>
> >>> +Joel Fernandes
> >>>
> >>> On Thu, Sep 20, 2018 at 2:11 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >>>>
> >>>>
> >>>> Thanks.  Let's cc the ashmem folks.
> >>>>
> >>
> >> This should be fixed by https://patchwork.kernel.org/patch/10572477/
> >>
> >> It has Neil Brown's Reviewed-by but looks like didn't yet appear in
> >> anyone's tree, could Greg take this patch?
> >
> > All is well.  That went into mainline yesterday, with a cc:stable.
> >
>
> This problem was not fixed at all.

There are at least 2 other open deadlocks involving ashmem:

https://syzkaller.appspot.com/bug?extid=148c2885d71194f18d28
https://syzkaller.appspot.com/bug?extid=4b8b031b89e6b96c4b2e

Does this fix any of these too?


> Why do we need to call fallocate() synchronously with ashmem_mutex held?
> Why can't we call fallocate() asynchronously from WQ_MEM_RECLAIM workqueue
> context so that we can call fallocate() with ashmem_mutex not held?
>
> I don't know how ashmem works, but as far as I can guess, offloading is
> possible as long as other operations which depend on the completion of
> fallocate() operation (e.g. read()/mmap(), querying/changing pinned status)
> wait for completion of asynchronous fallocate() operation (like a draft
> patch shown below is doing).
>
> ---
>  drivers/staging/android/ashmem.c | 50 ++++++++++++++++++++++++++++----
>  1 file changed, 45 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
> index 90a8a9f1ac7d..1a890c43a10a 100644
> --- a/drivers/staging/android/ashmem.c
> +++ b/drivers/staging/android/ashmem.c
> @@ -75,6 +75,17 @@ struct ashmem_range {
>  /* LRU list of unpinned pages, protected by ashmem_mutex */
>  static LIST_HEAD(ashmem_lru_list);
>
> +static struct workqueue_struct *ashmem_wq;
> +static atomic_t ashmem_shrink_inflight = ATOMIC_INIT(0);
> +static DECLARE_WAIT_QUEUE_HEAD(ashmem_shrink_wait);
> +
> +struct ashmem_shrink_work {
> +       struct work_struct work;
> +       struct file *file;
> +       loff_t start;
> +       loff_t end;
> +};
> +
>  /*
>   * long lru_count - The count of pages on our LRU list.
>   *
> @@ -292,6 +303,7 @@ static ssize_t ashmem_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>         int ret = 0;
>
>         mutex_lock(&ashmem_mutex);
> +       wait_event(ashmem_shrink_wait, !atomic_read(&ashmem_shrink_inflight));
>
>         /* If size is not set, or set to 0, always return EOF. */
>         if (asma->size == 0)
> @@ -359,6 +371,7 @@ static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
>         int ret = 0;
>
>         mutex_lock(&ashmem_mutex);
> +       wait_event(ashmem_shrink_wait, !atomic_read(&ashmem_shrink_inflight));
>
>         /* user needs to SET_SIZE before mapping */
>         if (!asma->size) {
> @@ -421,6 +434,19 @@ static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
>         return ret;
>  }
>
> +static void ashmem_shrink_worker(struct work_struct *work)
> +{
> +       struct ashmem_shrink_work *w = container_of(work, typeof(*w), work);
> +
> +       w->file->f_op->fallocate(w->file,
> +                                FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
> +                                w->start, w->end - w->start);
> +       fput(w->file);
> +       kfree(w);
> +       if (atomic_dec_and_test(&ashmem_shrink_inflight))
> +               wake_up_all(&ashmem_shrink_wait);
> +}
> +
>  /*
>   * ashmem_shrink - our cache shrinker, called from mm/vmscan.c
>   *
> @@ -449,12 +475,18 @@ ashmem_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
>                 return -1;
>
>         list_for_each_entry_safe(range, next, &ashmem_lru_list, lru) {
> -               loff_t start = range->pgstart * PAGE_SIZE;
> -               loff_t end = (range->pgend + 1) * PAGE_SIZE;
> +               struct ashmem_shrink_work *w = kzalloc(sizeof(*w), GFP_ATOMIC);
> +
> +               if (!w)
> +                       break;
> +               INIT_WORK(&w->work, ashmem_shrink_worker);
> +               w->file = range->asma->file;
> +               get_file(w->file);
> +               w->start = range->pgstart * PAGE_SIZE;
> +               w->end = (range->pgend + 1) * PAGE_SIZE;
> +               atomic_inc(&ashmem_shrink_inflight);
> +               queue_work(ashmem_wq, &w->work);
>
> -               range->asma->file->f_op->fallocate(range->asma->file,
> -                               FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
> -                               start, end - start);
>                 range->purged = ASHMEM_WAS_PURGED;
>                 lru_del(range);
>
> @@ -713,6 +745,7 @@ static int ashmem_pin_unpin(struct ashmem_area *asma, unsigned long cmd,
>                 return -EFAULT;
>
>         mutex_lock(&ashmem_mutex);
> +       wait_event(ashmem_shrink_wait, !atomic_read(&ashmem_shrink_inflight));
>
>         if (!asma->file)
>                 goto out_unlock;
> @@ -883,8 +916,15 @@ static int __init ashmem_init(void)
>                 goto out_free2;
>         }
>
> +       ashmem_wq = alloc_workqueue("ashmem_wq", WQ_MEM_RECLAIM, 0);
> +       if (!ashmem_wq) {
> +               pr_err("failed to create workqueue\n");
> +               goto out_demisc;
> +       }
> +
>         ret = register_shrinker(&ashmem_shrinker);
>         if (ret) {
> +               destroy_workqueue(ashmem_wq);
>                 pr_err("failed to register shrinker!\n");
>                 goto out_demisc;
>         }
> --
> 2.17.1
