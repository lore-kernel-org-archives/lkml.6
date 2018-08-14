Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3F6C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 06:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33046218DE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 06:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="mQu6vvVE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33046218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731889AbeHNJpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 05:45:13 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:37031 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbeHNJpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 05:45:13 -0400
Received: by mail-io0-f194.google.com with SMTP id z19-v6so17277827ioh.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 23:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DcYor0uwvULpS6otDLLyf3RWZJ26qIwzyd0BFu2v/qI=;
        b=mQu6vvVEGSJSv7BCgh6mW/Viv7otO0i5m1cFtPoAMLdx2OEfyd0c5m44vcykVQuEzB
         YwRIFdWNkhGBuF6oNdm4O3P3hyCYvmuTQpMbTP9wDl/ibCQhFxi/1zT5hH7U8ScwlUfj
         gDs6EDx4zF6sKyp5q/Q249fuyGP6dTcBqB1+hpTJnCm5EjFdec7UALWLTMbyzWWvs3u3
         hO2b8r5VrW9GNnDgU5L88CU8Hrl4245ILGITqlcWGjTB7Eeyej19xYLqrRufnmVoJnpe
         deDRH01JiGyBTwu/9kjDfmPgePghvgEFcDf8mk80eSmcBH0k76JQvEnXRluEcqNw0X6n
         fJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DcYor0uwvULpS6otDLLyf3RWZJ26qIwzyd0BFu2v/qI=;
        b=oGQYHacxmQL8fgiCxc0H5u/CktTgNNLZZaSlLmm7scwNdpU87448GWHepWfL+32vYJ
         ubznJfAKn7hS8TkyeIffk9baZqTuQx0Dfk9b+JZxYDhtSBl1VfYJ8sWHtneeohNgR/UW
         Xw7IM2L2oFpyDSI7W1hWNxJdSoYCb4OeAZ6AzqWTXhSiqr0bCcj0rKr+mOEt0IL+q2yN
         92RAOJYy2scpuVr1Zs4q1MelfSCZ06YDZs1EtM0CykMd5icCaCH+2WXYwxjO5WK368O/
         PLvO9W+9mLXQwrJK9z7fUkoSjb0C2kDU4ZM/SbkQPTZvJwGNUSfZKfEKLyyfLYsO+9Wh
         0YMg==
X-Gm-Message-State: AOUpUlEemCpQrZHPJvpzAQaQNWXl1i3rlY++ljiwg9uRRczXboH//h2p
        gMOvvy1f/JRjWBaFzqRxX6EXzQ8T4JltJUrPEukCHg==
X-Google-Smtp-Source: AA+uWPxvMskmmmIQfucb1TyUDY+D0f+gVTE3rTeRlw6j+yNqI3j8N3hgV45WaP9B1rhAFxsDWMJXFw/nIVQi/4zhCls=
X-Received: by 2002:a6b:b284:: with SMTP id b126-v6mr15189549iof.201.1534229962668;
 Mon, 13 Aug 2018 23:59:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:bb58:0:0:0:0:0 with HTTP; Mon, 13 Aug 2018 23:59:22
 -0700 (PDT)
In-Reply-To: <20180814002853.53690-1-sherryy@android.com>
References: <20180814002853.53690-1-sherryy@android.com>
From:   Martijn Coenen <maco@android.com>
Date:   Tue, 14 Aug 2018 08:59:22 +0200
Message-ID: <CAB0TPYGZMggNuVsgsKPpc0RvvpYNgHTbakP-GTookFbXB-vOKw@mail.gmail.com>
Subject: Re: [PATCH] android: binder: no outgoing transaction when thread todo
 has transaction
To:     Sherry Yang <sherryy@android.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Todd Kjos <tkjos@google.com>,
        Martijn Coenen <maco@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sherry, this was found by syzkaller, right? In that case, can you add
the <reported-by> tag so the issue gets closed automatically when this
gets merged?


On Tue, Aug 14, 2018 at 2:28 AM, Sherry Yang <sherryy@android.com> wrote:
> When a process dies, failed reply is sent to the sender of any transactio=
n
> queued on a dead thread's todo list. The sender asserts that the
> received failed reply corresponds to the head of the transaction stack.
> This assert can fail if the dead thread is allowed to send outgoing
> transactions when there is already a transaction on its todo list,
> because this new transaction can end up on the transaction stack of the
> original sender. The following steps illustrate how this assertion can
> fail.
>
> 1. Thread1 sends txn19 to Thread2
>    (T1->transaction_stack=3Dtxn19, T2->todo+=3Dtxn19)
> 2. Without processing todo list, Thread2 sends txn20 to Thread1
>    (T1->todo+=3Dtxn20, T2->transaction_stack=3Dtxn20)
> 3. T1 processes txn20 on its todo list
>    (T1->transaction_stack=3Dtxn20->txn19, T1->todo=3D<empty>)
> 4. T2 dies, T2->todo cleanup attempts to send failed reply for txn19, but
>    T1->transaction_stack points to txn20 -- assertion failes
>
> Step 2. is the incorrect behavior. When there is a transaction on a
> thread's todo list, this thread should not be able to send any outgoing
> synchronous transactions. Only the head of the todo list needs to be
> checked because only threads that are waiting for proc work can directly
> receive work from another thread, and no work is allowed to be queued
> on such a thread without waking up the thread. This patch also enforces
> that a thread is not waiting for proc work when a work is directly
> enqueued to its todo list.
>
> Acked-by: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
> Signed-off-by: Sherry Yang <sherryy@android.com>

Reviewed-by: Martijn Coenen <maco@android.com>

Thanks,
Martijn

> ---
>  drivers/android/binder.c | 44 +++++++++++++++++++++++++++++-----------
>  1 file changed, 32 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index d58763b6b009..f2081934eb8b 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -822,6 +822,7 @@ static void
>  binder_enqueue_deferred_thread_work_ilocked(struct binder_thread *thread=
,
>                                             struct binder_work *work)
>  {
> +       WARN_ON(!list_empty(&thread->waiting_thread_node));
>         binder_enqueue_work_ilocked(work, &thread->todo);
>  }
>
> @@ -839,6 +840,7 @@ static void
>  binder_enqueue_thread_work_ilocked(struct binder_thread *thread,
>                                    struct binder_work *work)
>  {
> +       WARN_ON(!list_empty(&thread->waiting_thread_node));
>         binder_enqueue_work_ilocked(work, &thread->todo);
>         thread->process_todo =3D true;
>  }
> @@ -1270,19 +1272,12 @@ static int binder_inc_node_nilocked(struct binder=
_node *node, int strong,
>                 } else
>                         node->local_strong_refs++;
>                 if (!node->has_strong_ref && target_list) {
> +                       struct binder_thread *thread =3D container_of(tar=
get_list,
> +                                                   struct binder_thread,=
 todo);
>                         binder_dequeue_work_ilocked(&node->work);
> -                       /*
> -                        * Note: this function is the only place where we=
 queue
> -                        * directly to a thread->todo without using the
> -                        * corresponding binder_enqueue_thread_work() hel=
per
> -                        * functions; in this case it's ok to not set the
> -                        * process_todo flag, since we know this node wor=
k will
> -                        * always be followed by other work that starts q=
ueue
> -                        * processing: in case of synchronous transaction=
s, a
> -                        * BR_REPLY or BR_ERROR; in case of oneway
> -                        * transactions, a BR_TRANSACTION_COMPLETE.
> -                        */
> -                       binder_enqueue_work_ilocked(&node->work, target_l=
ist);
> +                       BUG_ON(&thread->todo !=3D target_list);
> +                       binder_enqueue_deferred_thread_work_ilocked(threa=
d,
> +                                                                  &node-=
>work);
>                 }
>         } else {
>                 if (!internal)
> @@ -2723,6 +2718,7 @@ static void binder_transaction(struct binder_proc *=
proc,
>  {
>         int ret;
>         struct binder_transaction *t;
> +       struct binder_work *w;
>         struct binder_work *tcomplete;
>         binder_size_t *offp, *off_end, *off_start;
>         binder_size_t off_min;
> @@ -2864,6 +2860,29 @@ static void binder_transaction(struct binder_proc =
*proc,
>                         goto err_invalid_target_handle;
>                 }
>                 binder_inner_proc_lock(proc);
> +
> +               w =3D list_first_entry_or_null(&thread->todo,
> +                                            struct binder_work, entry);
> +               if (!(tr->flags & TF_ONE_WAY) && w &&
> +                   w->type =3D=3D BINDER_WORK_TRANSACTION) {
> +                       /*
> +                        * Do not allow new outgoing transaction from a
> +                        * thread that has a transaction at the head of
> +                        * its todo list. Only need to check the head
> +                        * because binder_select_thread_ilocked picks a
> +                        * thread from proc->waiting_threads to enqueue
> +                        * the transaction, and nothing is queued to the
> +                        * todo list while the thread is on waiting_threa=
ds.
> +                        */
> +                       binder_user_error("%d:%d new transaction not allo=
wed when there is a transaction on thread todo\n",
> +                                         proc->pid, thread->pid);
> +                       binder_inner_proc_unlock(proc);
> +                       return_error =3D BR_FAILED_REPLY;
> +                       return_error_param =3D -EPROTO;
> +                       return_error_line =3D __LINE__;
> +                       goto err_bad_todo_list;
> +               }
> +
>                 if (!(tr->flags & TF_ONE_WAY) && thread->transaction_stac=
k) {
>                         struct binder_transaction *tmp;
>
> @@ -3247,6 +3266,7 @@ static void binder_transaction(struct binder_proc *=
proc,
>         kfree(t);
>         binder_stats_deleted(BINDER_STAT_TRANSACTION);
>  err_alloc_t_failed:
> +err_bad_todo_list:
>  err_bad_call_stack:
>  err_empty_call_stack:
>  err_dead_binder:
> --
> 2.18.0.597.ga71716f1ad-goog
>
