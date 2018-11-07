Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB99C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 13:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C12B220882
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 13:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="NZfS58F3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C12B220882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbeKGWjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 17:39:44 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:42994 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbeKGWjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 17:39:43 -0500
Received: by mail-io1-f68.google.com with SMTP id h19-v6so11814315iog.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 05:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LO8LVs4QnK5pY1XerlzRfE3ckOfZjyQ5f4s67TviexY=;
        b=NZfS58F3QTwytkXCvAhKkgYWvQNA0cK2SZVKZ05CmNyBOvxA0v6apYv1Q/5uuLQXSP
         rAbjS9ZQB5W6I9KNdIACUNW/AnMhxp8waIi0wuJkI6WpBiIMfOsOkJ3/MEt8+ljrXhkc
         nRDk1tDWrzsyU980kdAFBxxfZGcuo2DVym5hY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LO8LVs4QnK5pY1XerlzRfE3ckOfZjyQ5f4s67TviexY=;
        b=DwLrvHRSVXASFimphKsXQhKm9ktjpVdLoXAcwcsSHqe3kfVC+pD77LkoamK1rTbJ4j
         zZ0sSXWVkY3/oB1iL86i1mpO1G8GX9MfL/ULYX6wJSXWzjuoAyuRRcgEAEFA/5zBIsdy
         jI/xWi1Q8dOKfMcKNM5iRNo3buxTrlJcEylL6+L2nK0hA1OKrQ8RMbiJNTakQfs9jlx0
         lXu245HGpgeqvH5ee8uSS9lv1+NDP68mdLtWFpOzzI8WLcqjldEI4TTv5zqnYJEJjtg/
         fm2C2GS+pwZEVBz6fRbH/yMVvwXDdBSzv2PuKEPz57zx4N39g/HcmJsaqzYPKgFSo9Pc
         QtLg==
X-Gm-Message-State: AGRZ1gJ7EzuQ8OcpQGsUKueCtgrcLdlZX6IPvkI+3OQH09rS7V/QWgRi
        uvbJHThmQV6lqk+FaUSfFbsstmc898nLhNi5VfdXtVcb
X-Google-Smtp-Source: AJdET5eaaP5vKM6ueHC78X+wBXrArsSpXTm6l7k79K7vyIwHT158o8AtcAmOjO/tPNFFZBpkQgTDUeeuuFRsmuJcMZU=
X-Received: by 2002:a6b:15c5:: with SMTP id 188-v6mr121993iov.246.1541596163708;
 Wed, 07 Nov 2018 05:09:23 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a6b:ac42:0:0:0:0:0 with HTTP; Wed, 7 Nov 2018 05:09:23 -0800 (PST)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <154149663862.17764.9649077325029198892.stgit@localhost.localdomain>
References: <154149586524.17764.5252013294539109287.stgit@localhost.localdomain>
 <154149663862.17764.9649077325029198892.stgit@localhost.localdomain>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 7 Nov 2018 14:09:23 +0100
Message-ID: <CAJfpegtTP5E1XcDZf=BKJjMrwpYYaHyu1SFC_8nR-Vn-L6aJTA@mail.gmail.com>
Subject: Re: [PATCH 2/6] fuse: Optimize request_end() by not taking fiq->waitq.lock
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 10:30 AM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> We take global fiq->waitq.lock every time, when we are
> in this function, but interrupted requests are just small
> subset of all requests. This patch optimizes request_end()
> and makes it to take the lock when it's really needed.
>
> queue_interrupt() needs small change for that. After req
> is linked to interrupt list, we do smp_mb() and check
> for FR_FINISHED again. In case of FR_FINISHED bit has
> appeared, we remove req and leave the function:
>
> CPU 0                                                CPU 1
> queue_interrupt()                                    request_end()
>
>   spin_lock(&fiq->waitq.lock)
>
>
>   list_add_tail(&req->intr_entry, &fiq->interrupts)    test_and_set_bit(FR_FINISHED, &req->flags)
>   smp_mb()                                             <memory barrier implied test_and_set_bit()>
>   if (test_bit(FR_FINISHED, &req->flags))              if (!list_empty(&req->intr_entry))
>
>     list_del_init(&req->intr_entry)                      spin_lock(&fiq->waitq.lock)
>                                                          list_del_init(&req->intr_entry)
>
> Check the change is visible in perf report:
>
> 1)Firstly mount fusexmp_fh:
>   $fuse/example/.libs/fusexmp_fh mnt
>
> 2)Run test doing
>     futimes(fd, tv1);
>     futimes(fd, tv2);
>   in many threads endlessly.
>
> 3)perf record -g (all the system load)
>
> Without the patch in request_end() we spend 62.58% of do_write() time:
> (= 12.58 / 20.10 * 100%)
>
>    55,22% entry_SYSCALL_64
>      20,10% do_writev
>       ...
>           18,08% fuse_dev_do_write
>            12,58% request_end
>             10,08% __wake_up_common_lock
>             1,97% queued_spin_lock_slowpath
>            1,31% fuse_copy_args
>            1,04% fuse_copy_one
>            0,85% queued_spin_lock_slowpath
>
> With the patch, the perf report becomes better, and only 58.16%
> of do_write() time we spend in request_end():
>
>    54,15% entry_SYSCALL_64
>      18,24% do_writev
>       ...
>           16,25% fuse_dev_do_write
>            10,61% request_end
>             10,25% __wake_up_common_lock
>            1,34% fuse_copy_args
>            1,06% fuse_copy_one
>            0,88% queued_spin_lock_slowpath
>
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> ---
>  fs/fuse/dev.c |   30 ++++++++++++++++++++++--------
>  1 file changed, 22 insertions(+), 8 deletions(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 7705f75c77a3..391498e680ec 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -427,10 +427,16 @@ static void request_end(struct fuse_conn *fc, struct fuse_req *req)
>
>         if (test_and_set_bit(FR_FINISHED, &req->flags))
>                 goto put_request;
> -
> -       spin_lock(&fiq->waitq.lock);
> -       list_del_init(&req->intr_entry);
> -       spin_unlock(&fiq->waitq.lock);
> +       /*
> +        * test_and_set_bit() implies smp_mb() between bit
> +        * changing and below intr_entry check. Pairs with
> +        * smp_mb() from queue_interrupt().
> +        */
> +       if (!list_empty(&req->intr_entry)) {
> +               spin_lock(&fiq->waitq.lock);
> +               list_del_init(&req->intr_entry);
> +               spin_unlock(&fiq->waitq.lock);
> +       }
>         WARN_ON(test_bit(FR_PENDING, &req->flags));
>         WARN_ON(test_bit(FR_SENT, &req->flags));
>         if (test_bit(FR_BACKGROUND, &req->flags)) {
> @@ -470,13 +476,21 @@ static void queue_interrupt(struct fuse_iqueue *fiq, struct fuse_req *req)
>  {
>         bool kill = false;
>
> -       spin_lock(&fiq->waitq.lock);
> -       if (test_bit(FR_FINISHED, &req->flags)) {
> -               spin_unlock(&fiq->waitq.lock);
> +       if (test_bit(FR_FINISHED, &req->flags))

The only case this test would make sense if this was a performance
sensitive path, which it's not.

>                 return;
> -       }
> +       spin_lock(&fiq->waitq.lock);
>         if (list_empty(&req->intr_entry)) {
>                 list_add_tail(&req->intr_entry, &fiq->interrupts);
> +               /*
> +                * Pairs with smp_mb() implied by test_and_set_bit()
> +                * from request_end().
> +                */
> +               smp_mb();
> +               if (test_bit(FR_FINISHED, &req->flags)) {
> +                       list_del_init(&req->intr_entry);
> +                       spin_unlock(&fiq->waitq.lock);
> +                       return;
> +               }
>                 wake_up_locked(&fiq->waitq);
>                 kill = true;
>         }
>
