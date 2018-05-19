Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-974401-1526712285-3-9814816489891726402
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.248, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526712284; b=MN71v0+6x13yInykz/96JlTDpF8vocX50Zhi6dE6bC9sOHK7oA
    ztCeAVnpeGNb7n3HJz566x0YeiCbo1ruCP36CXpR3LZtv8yzCZzAEG/KuKU0qUW8
    dcWDHy432m0HkORCAU99mKvXgzdvk+Lb/MwQSl4VJCLpII5G0jIkUgS8ej9xdUf9
    Srgm5NVG2vIzx6Ch020bdpZl9P8L6W3t58n6pvchfE8g/LkGD9Syxl1xMWeXyngr
    qPaNG3lrIxSFm9cM2v5RfWJAcMxJ01MxW1NmhWr4NclkAjuDoMBB7BAZ4KMki+Pr
    uIvjCqt26a3T1A6ga5mQO4q52083GWqnLTLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1526712284; bh=O6hkSnbq7LInFlWecmoWucTWhCjjS/2TuH6QL2F9H5
    Y=; b=K3S/OLJ0ugqZ+yIOruNOszdzOPWeTZhOWlMfhJvSgN6wYPZ53PjGxGA9+b
    Pts/5Ci3jP0NkpLFM4Fof9XdXkUHXb05n+QkqZTJ3z1A+qB+YsAkmDObO6+XjvPs
    pqB8ha0zB4jwIvc7riipb8/4wO6N5t3kh5S45ohL1nu7IMKaPnR3wg1CSIcahtVN
    N0MDmj+PaqLjf46GSgJkg9nfsdzNygj3kqFMPARVFO1I5ew/bMU1BaPwpiCDRyWy
    3worE3KInznskBaP+vg8NI1rMDNAmK7ZsOKwUNZDzcg3xq7EcUqvP4qJZucKvg9l
    8TSQvW3qWQIq5Y1hFvOoBhTZoZGw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=DnT/vbhh x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=bpH/5oz4;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=DnT/vbhh x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=bpH/5oz4;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNwYSXTJBtpHrJpKTRrZR0sm/BIArOS2LGT2Ms5xCA2lESIzyflzmGCnyKA6VeT1LTfBaW9YKBBwCVzx600HfJMMl8ccP0bJoGVi/RbMG1p2N9DXyRZV
    lMmlxAINoV1Ows8tbsWsI2r8/35Cw+P2+dGfYJf8bgLLSCPAZ9Q2o+AbkklIL8EpLkCksT8QBZq46mnqcwhs9HQASVEMKOwdZ079b2oKT1mVb9Hth/b8+qa7
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=x__7FTJV84wA:10 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=KgpIaK4Oq2S2k0HljmAA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750766AbeESGom (ORCPT <rfc822;greg@kroah.com>);
        Sat, 19 May 2018 02:44:42 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:34631 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750743AbeESGol (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 19 May 2018 02:44:41 -0400
X-Google-Smtp-Source: AB8JxZpNUCNODnR9mjMLvVxON2ohJ6Hzbg1dw9pTqdJhWHFQIyycy5ivrM/OHyDkCtLVD9MvXjZzr3Uv4tdiiowX/FY=
MIME-Version: 1.0
In-Reply-To: <20180517043448.3152269-4-tj@kernel.org>
References: <20180517043448.3152269-1-tj@kernel.org> <20180517043448.3152269-4-tj@kernel.org>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Sat, 19 May 2018 14:44:39 +0800
Message-ID: <CAJhGHyC8pZvy3cmT-n6aFy0KQVJ0je6LwUKZf2Z1Rdvq--vFVw@mail.gmail.com>
Subject: Re: [PATCH 3/6] workqueue: Make worker_attach/detach_pool() update worker->pool
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>, Craig Small <csmall@enc.com.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 17, 2018 at 12:34 PM, Tejun Heo <tj@kernel.org> wrote:
> For historical reasons, the worker attach/detach functions don't
> currently manage worker->pool and the callers are manually and
> inconsistently updating it.
>
> This patch moves worker->pool updates into the worker attach/detach
> functions.  This makes worker->pool consistent and clearly defines how
> worker->pool updates are synchronized.
>
> This will help later workqueue visibility improvements by allowing
> safe access to workqueue information from worker->task.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/workqueue.c          | 16 ++++++++--------
>  kernel/workqueue_internal.h |  2 +-
>  2 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 91fe0a6..2fde50f 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -1741,6 +1741,7 @@ static void worker_attach_to_pool(struct worker *worker,
>                 worker->flags |= WORKER_UNBOUND;
>
>         list_add_tail(&worker->node, &pool->workers);
> +       worker->pool = pool;
>
>         mutex_unlock(&wq_pool_attach_mutex);
>  }
> @@ -1748,19 +1749,21 @@ static void worker_attach_to_pool(struct worker *worker,
>  /**
>   * worker_detach_from_pool() - detach a worker from its pool
>   * @worker: worker which is attached to its pool
> - * @pool: the pool @worker is attached to
>   *
>   * Undo the attaching which had been done in worker_attach_to_pool().  The
>   * caller worker shouldn't access to the pool after detached except it has
>   * other reference to the pool.
>   */
> -static void worker_detach_from_pool(struct worker *worker,
> -                                   struct worker_pool *pool)
> +static void worker_detach_from_pool(struct worker *worker)
>  {
> +       struct worker_pool *pool = worker->pool;
>         struct completion *detach_completion = NULL;
>
>         mutex_lock(&wq_pool_attach_mutex);
> +
>         list_del(&worker->node);
> +       worker->pool = NULL;
> +
>         if (list_empty(&pool->workers))
>                 detach_completion = pool->detach_completion;
>         mutex_unlock(&wq_pool_attach_mutex);
> @@ -1799,7 +1802,6 @@ static struct worker *create_worker(struct worker_pool *pool)
>         if (!worker)
>                 goto fail;
>
> -       worker->pool = pool;
>         worker->id = id;
>
>         if (pool->cpu >= 0)
> @@ -2236,7 +2238,7 @@ static int worker_thread(void *__worker)
>
>                 set_task_comm(worker->task, "kworker/dying");
>                 ida_simple_remove(&pool->worker_ida, worker->id);
> -               worker_detach_from_pool(worker, pool);
> +               worker_detach_from_pool(worker);
>                 kfree(worker);
>                 return 0;
>         }
> @@ -2367,7 +2369,6 @@ static int rescuer_thread(void *__rescuer)
>                 worker_attach_to_pool(rescuer, pool);
>
>                 spin_lock_irq(&pool->lock);
> -               rescuer->pool = pool;
>
>                 /*
>                  * Slurp in all works issued via this workqueue and
> @@ -2417,10 +2418,9 @@ static int rescuer_thread(void *__rescuer)
>                 if (need_more_worker(pool))
>                         wake_up_worker(pool);
>
> -               rescuer->pool = NULL;
>                 spin_unlock_irq(&pool->lock);
>
> -               worker_detach_from_pool(rescuer, pool);
> +               worker_detach_from_pool(rescuer);
>
>                 spin_lock_irq(&wq_mayday_lock);
>         }
> diff --git a/kernel/workqueue_internal.h b/kernel/workqueue_internal.h
> index d390d1b..4a182e0 100644
> --- a/kernel/workqueue_internal.h
> +++ b/kernel/workqueue_internal.h
> @@ -37,7 +37,7 @@ struct worker {
>         /* 64 bytes boundary on 64bit, 32 on 32bit */
>
>         struct task_struct      *task;          /* I: worker task */
> -       struct worker_pool      *pool;          /* I: the associated pool */
> +       struct worker_pool      *pool;          /* A: the associated pool */
>                                                 /* L: for rescuers */

I guess ` /* L: for rescuers */ ` needed to be removed.

And there are many usages of worker->pool without attached_mutex
heled. The only locking annotation "A:" is not enough. Additional
comment is needed too.

1) called from the worker(including rescuer) task: it is safe because only
    the worker task itself can call the attach()/detach().

2) called from the destroy_worker() (only normal worker): it is safe
    because it is immutable before the worker detaches itself.

>         struct list_head        node;           /* A: anchored at pool->workers */
>                                                 /* A: runs through worker->node */
> --
> 2.9.5
>
