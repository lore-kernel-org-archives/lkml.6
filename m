Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68E7C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 19:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90D6D2184C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 19:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbeLRTRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 14:17:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60486 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726446AbeLRTRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 14:17:09 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5858C5D61D;
        Tue, 18 Dec 2018 19:17:07 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-223.bos.redhat.com [10.18.17.223])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 92DF81001F3C;
        Tue, 18 Dec 2018 19:17:04 +0000 (UTC)
Subject: Re: [PATCH v2] sched/wake_q: Reduce reference counting for special
 users
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Yongji Xie <elohimes@gmail.com>, mingo@redhat.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        Xie Yongji <xieyongji@baidu.com>, zhangyu31@baidu.com,
        liuqi16@baidu.com, yuanlinsi01@baidu.com, nixun@baidu.com,
        lilin24@baidu.com, andrea.parri@amarulasolutions.com
References: <20181129180828.GA11650@hirez.programming.kicks-ass.net>
 <729ceddb-dd9a-ec2a-f74e-03fa4d7e65e8@redhat.com>
 <20181129213017.v3eljor54lfpoug2@linux-r8p5>
 <20181129213421.wwvhsjql3m3lvtv4@linux-r8p5>
 <20181129221714.GF11632@hirez.programming.kicks-ass.net>
 <CAONzpcZ_kQ0cwit+d5uL=v2SqwP=Fo0WSihdCr23uKCAFAhTbQ@mail.gmail.com>
 <20181217113718.GB4900@worktop.programming.kicks-ass.net>
 <20181217205310.pvwcryyaqlrzmaex@linux-r8p5>
 <20181218131031.GJ15430@hirez.programming.kicks-ass.net>
 <20181218131419.GD16284@hirez.programming.kicks-ass.net>
 <20181218185443.g5jzinm3vnrkznmm@linux-r8p5>
From:   Waiman Long <longman@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=longman@redhat.com; prefer-encrypt=mutual; keydata=
 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
 weim8xU=
Organization: Red Hat
Message-ID: <a8767197-21b9-f470-b864-be88e020c647@redhat.com>
Date:   Tue, 18 Dec 2018 14:17:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181218185443.g5jzinm3vnrkznmm@linux-r8p5>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 18 Dec 2018 19:17:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/18/2018 01:54 PM, Davidlohr Bueso wrote:
> Some users, specifically futexes and rwsems, required fixes
> that allowed the callers to be safe when wakeups occur before
> they are expected by wake_up_q(). Such scenarios also play
> games and rely on reference counting, and until now were
> pivoting on wake_q doing it. With the wake_q_add() call being
> moved down, this can no longer be the case. As such we end up
> with a a double task refcounting overhead; and these callers
> care enough about this (being rather core-ish).
>
> This patch introduces a wake_q_add_safe() call that serves
> for callers that have already done refcounting and therefore the
> task is 'safe' from wake_q point of view (int that it requires
> reference throughout the entire queue/>wakeup cycle). In the one
> case it has internal reference counting, in the other case it
> consumes the reference counting.
>
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> ---
>
> Changes from v1:
> - Simplify some of the interface allowing callers to not worry
>   about the return value of the add operation. This makes caller
>   refcouting two levels/asymm by putting the refcouting in the
>   wake_q's hands, but the benefits are worth it.
>
> Applies on peterz' queue tree.
>
> include/linux/sched/wake_q.h |  4 +--
> kernel/futex.c               |  3 +--
> kernel/locking/rwsem-xadd.c  |  4 +--
> kernel/sched/core.c          | 62
> ++++++++++++++++++++++++++++++++------------
> 4 files changed, 50 insertions(+), 23 deletions(-)
>
> diff --git a/include/linux/sched/wake_q.h b/include/linux/sched/wake_q.h
> index 545f37138057..ad826d2a4557 100644
> --- a/include/linux/sched/wake_q.h
> +++ b/include/linux/sched/wake_q.h
> @@ -51,8 +51,8 @@ static inline void wake_q_init(struct wake_q_head
> *head)
>     head->lastp = &head->first;
> }
>
> -extern void wake_q_add(struct wake_q_head *head,
> -               struct task_struct *task);
> +extern void wake_q_add(struct wake_q_head *head, struct task_struct
> *task);
> +extern void wake_q_add_safe(struct wake_q_head *head, struct
> task_struct *task);
> extern void wake_up_q(struct wake_q_head *head);
>
> #endif /* _LINUX_SCHED_WAKE_Q_H */
> diff --git a/kernel/futex.c b/kernel/futex.c
> index d14971f6ed3d..6218d98f649b 100644
> --- a/kernel/futex.c
> +++ b/kernel/futex.c
> @@ -1402,8 +1402,7 @@ static void mark_wake_futex(struct wake_q_head
> *wake_q, struct futex_q *q)
>      * Queue the task for later wakeup for after we've released
>      * the hb->lock. wake_q_add() grabs reference to p.
>      */
> -    wake_q_add(wake_q, p);
> -    put_task_struct(p);
> +    wake_q_add_safe(wake_q, p);
> }
>
> /*
> diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
> index 50d9af615dc4..fbe96341beee 100644
> --- a/kernel/locking/rwsem-xadd.c
> +++ b/kernel/locking/rwsem-xadd.c
> @@ -211,9 +211,7 @@ static void __rwsem_mark_wake(struct rw_semaphore
> *sem,
>          * Ensure issuing the wakeup (either by us or someone else)
>          * after setting the reader waiter to nil.
>          */
> -        wake_q_add(wake_q, tsk);
> -        /* wake_q_add() already take the task ref */
> -        put_task_struct(tsk);
> +        wake_q_add_safe(wake_q, tsk);
>     }
>
>     adjustment = woken * RWSEM_ACTIVE_READ_BIAS - adjustment;
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index d740d7a3608d..ef85c6ad4caa 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -396,19 +396,7 @@ static bool set_nr_if_polling(struct task_struct *p)
> #endif
> #endif
>
> -/**
> - * wake_q_add() - queue a wakeup for 'later' waking.
> - * @head: the wake_q_head to add @task to
> - * @task: the task to queue for 'later' wakeup
> - *
> - * Queue a task for later wakeup, most likely by the wake_up_q() call
> in the
> - * same context, _HOWEVER_ this is not guaranteed, the wakeup can come
> - * instantly.
> - *
> - * This function must be used as-if it were wake_up_process(); IOW
> the task
> - * must be ready to be woken at this location.
> - */
> -void wake_q_add(struct wake_q_head *head, struct task_struct *task)
> +static bool __wake_q_add(struct wake_q_head *head, struct task_struct
> *task)
> {
>     struct wake_q_node *node = &task->wake_q;
>
> @@ -422,15 +410,57 @@ void wake_q_add(struct wake_q_head *head, struct
> task_struct *task)
>      */
>     smp_mb__before_atomic();
>     if (unlikely(cmpxchg_relaxed(&node->next, NULL, WAKE_Q_TAIL)))
> -        return;
> -
> -    get_task_struct(task);
> +        return false;
>
>     /*
>      * The head is context local, there can be no concurrency.
>      */
>     *head->lastp = node;
>     head->lastp = &node->next;
> +    return true;
> +}
> +
> +/**
> + * wake_q_add() - queue a wakeup for 'later' waking.
> + * @head: the wake_q_head to add @task to
> + * @task: the task to queue for 'later' wakeup
> + *
> + * Queue a task for later wakeup, most likely by the wake_up_q() call
> in the
> + * same context, _HOWEVER_ this is not guaranteed, the wakeup can come
> + * instantly.
> + *
> + * This function must be used as-if it were wake_up_process(); IOW
> the task
> + * must be ready to be woken at this location.
> + *
> + * The @task will be refcounted upon a

Are you missing some text here?

-Longman
