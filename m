Return-Path: <SRS0=DZvH=GG=gmail.com=jiangshanlai@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2161282-1521180100-3-6861349229481791872
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='198.145.29.99', Host='mail.kernel.org', Country='US', FromHeader='com',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: SRS0=DZvH=GG=gmail.com=jiangshanlai@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521180099; b=lFEetSn3/JsxRd/CElB6KRGJOI2IsrtKVEBFMQH+zryj8+d
    zLNkPIguo9b4rnPByAbVa4ZEPLf8Lk47Rfenb4S9pFukNjCkemqLu5J//LmmNNV6
    QEJLmGFGGtozxgjO8XqMsSPP6N45QnMuOC6Vv2vfDd8MF9FZSFGR1u0jYSLl69aB
    0rWRv/XuIAk8BlzBxErFP3Nf7qLT9qnTiSn7cjOZrjk5G+nW65ulH3rx45iwYwVb
    /1LvQmlJrxBF0D0Z6aHQphmImyTgvFMuaiqXsJBLvqZJQS0zUsITVyn2O8tK/qm1
    PqSPyiL6dDDZPmsdyr7iv74eHpkcxid+fpYpTTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:sender:in-reply-to
    :references:from:date:message-id:subject:to:cc:content-type; s=
    arctest; t=1521180099; bh=dGH6Pko+HmJv0EIw2SsFgMyy51Ts/4gEZdsCqp
    Shbi4=; b=qrxsNrxyE9vrb8vk7lF/SpPbNQorJM3NEKCutToyrXWsZKu0G+YIFr
    n62LoT3lX9Kyjo8NfXhnq98x4pOYeVjgVA/nYev5lXIF8HFrmDg8umreDDxLN3hd
    DJ0ZBXEkfwRuZQcOOebLxHgJfsQ/B9AGoDM3Yb4ZdE4Zo0ixWG+Vkz1RhGy3g8xa
    +nlagTbwBXlCU3+Ep0ufEJItQqjVyp6lvGvtue1Ut2P5HvLGte4YG1qZY3RPhHC0
    r5p1ubozwqbv2bpm9U+mOcEzTsK70aSYKECv0sSRKZfQCHgEs75nohajRlJk1q/x
    07PZxB7WLos/pBaipaKGTr7fG/PFLHtA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=q8LDNNVy x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=DZvH=GG=gmail.com=jiangshanlai@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=MiEDOzbp;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=q8LDNNVy x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=DZvH=GG=gmail.com=jiangshanlai@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=MiEDOzbp;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13ED321741
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=jiangshanlai@gmail.com
X-Google-Smtp-Source: AG47ELuq72x7sPJfjvjA1btiiodAtPzDbDWARqeBEhc3ZEAXhBdSX8L0h9nR1ixOLZbIKlCEvvh2Qxh6ULpJJHjIIIo=
MIME-Version: 1.0
Sender: jiangshanlai@gmail.com
In-Reply-To: <20180314194515.1661824-6-tj@kernel.org>
References: <20180314194205.1651587-1-tj@kernel.org> <20180314194515.1661824-1-tj@kernel.org>
 <20180314194515.1661824-6-tj@kernel.org>
From: Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Date: Fri, 16 Mar 2018 14:01:35 +0800
X-Google-Sender-Auth: NI8yprPfsMuPdCKxNrvS_33J634
Message-ID: <CAJhGHyA3zte-0MWGC+DrOptprHBRroCn8fHM678iVnb-1VStLA@mail.gmail.com>
Subject: Re: [PATCH 6/8] RCU, workqueue: Implement rcu_work
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jann Horn <jannh@google.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Benjamin LaHaise <bcrl@kvack.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Kent Overstreet <kent.overstreet@gmail.com>, security@kernel.org,
	LKML <linux-kernel@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 15, 2018 at 3:45 AM, Tejun Heo <tj@kernel.org> wrote:
> There are cases where RCU callback needs to be bounced to a sleepable
> context.  This is currently done by the RCU callback queueing a work
> item, which can be cumbersome to write and confusing to read.
>
> This patch introduces rcu_work, a workqueue work variant which gets
> executed after a RCU grace period, and converts the open coded
> bouncing in fs/aio and kernel/cgroup.
>
> v3: Dropped queue_rcu_work_on().  Documented rcu grace period behavior
>     after queue_rcu_work().
>
> v2: Use rcu_barrier() instead of synchronize_rcu() to wait for
>     completion of previously queued rcu callback as per Paul.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> ---
>  include/linux/workqueue.h | 23 ++++++++++++++++++++
>  kernel/workqueue.c        | 54 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 77 insertions(+)
>
> diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
> index bc0cda1..d026f8f 100644
> --- a/include/linux/workqueue.h
> +++ b/include/linux/workqueue.h
> @@ -13,6 +13,7 @@
>  #include <linux/threads.h>
>  #include <linux/atomic.h>
>  #include <linux/cpumask.h>
> +#include <linux/rcupdate.h>
>
>  struct workqueue_struct;
>
> @@ -120,6 +121,14 @@ struct delayed_work {
>         int cpu;
>  };
>
> +struct rcu_work {
> +       struct work_struct work;
> +       struct rcu_head rcu;
> +
> +       /* target workqueue ->rcu uses to queue ->work */
> +       struct workqueue_struct *wq;
> +};
> +
>  /**
>   * struct workqueue_attrs - A struct for workqueue attributes.
>   *
> @@ -151,6 +160,11 @@ static inline struct delayed_work *to_delayed_work(struct work_struct *work)
>         return container_of(work, struct delayed_work, work);
>  }
>
> +static inline struct rcu_work *to_rcu_work(struct work_struct *work)
> +{
> +       return container_of(work, struct rcu_work, work);
> +}
> +
>  struct execute_work {
>         struct work_struct work;
>  };
> @@ -266,6 +280,12 @@ static inline unsigned int work_static(struct work_struct *work) { return 0; }
>  #define INIT_DEFERRABLE_WORK_ONSTACK(_work, _func)                     \
>         __INIT_DELAYED_WORK_ONSTACK(_work, _func, TIMER_DEFERRABLE)
>
> +#define INIT_RCU_WORK(_work, _func)                                    \
> +       INIT_WORK(&(_work)->work, (_func))
> +
> +#define INIT_RCU_WORK_ONSTACK(_work, _func)                            \
> +       INIT_WORK_ONSTACK(&(_work)->work, (_func))
> +
>  /**
>   * work_pending - Find out whether a work item is currently pending
>   * @work: The work item in question
> @@ -447,6 +467,7 @@ extern bool queue_delayed_work_on(int cpu, struct workqueue_struct *wq,
>                         struct delayed_work *work, unsigned long delay);
>  extern bool mod_delayed_work_on(int cpu, struct workqueue_struct *wq,
>                         struct delayed_work *dwork, unsigned long delay);
> +extern bool queue_rcu_work(struct workqueue_struct *wq, struct rcu_work *rwork);
>
>  extern void flush_workqueue(struct workqueue_struct *wq);
>  extern void drain_workqueue(struct workqueue_struct *wq);
> @@ -463,6 +484,8 @@ extern bool flush_delayed_work(struct delayed_work *dwork);
>  extern bool cancel_delayed_work(struct delayed_work *dwork);
>  extern bool cancel_delayed_work_sync(struct delayed_work *dwork);
>
> +extern bool flush_rcu_work(struct rcu_work *rwork);
> +
>  extern void workqueue_set_max_active(struct workqueue_struct *wq,
>                                      int max_active);
>  extern struct work_struct *current_work(void);
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index bb9a519..7df85fa 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -1604,6 +1604,40 @@ bool mod_delayed_work_on(int cpu, struct workqueue_struct *wq,
>  }
>  EXPORT_SYMBOL_GPL(mod_delayed_work_on);
>
> +static void rcu_work_rcufn(struct rcu_head *rcu)
> +{
> +       struct rcu_work *rwork = container_of(rcu, struct rcu_work, rcu);
> +
> +       /* read the comment in __queue_work() */
> +       local_irq_disable();
> +       __queue_work(WORK_CPU_UNBOUND, rwork->wq, &rwork->work);
> +       local_irq_enable();
> +}
> +
> +/**
> + * queue_rcu_work - queue work after a RCU grace period
> + * @wq: workqueue to use
> + * @rwork: work to queue
> + *
> + * Return: %false if @rwork was already pending, %true otherwise.  Note
> + * that a full RCU grace period is guaranteed only after a %true return.
> + * While @rwork is guarnateed to be executed after a %false return, the
> + * execution may happen before a full RCU grace period has passed.
> + */

LGTM

Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>

> +bool queue_rcu_work(struct workqueue_struct *wq, struct rcu_work *rwork)
> +{
> +       struct work_struct *work = &rwork->work;
> +
> +       if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work))) {
> +               rwork->wq = wq;
> +               call_rcu(&rwork->rcu, rcu_work_rcufn);
> +               return true;
> +       }
> +
> +       return false;
> +}
> +EXPORT_SYMBOL(queue_rcu_work);
> +
>  /**
>   * worker_enter_idle - enter idle state
>   * @worker: worker which is entering idle state
> @@ -3001,6 +3035,26 @@ bool flush_delayed_work(struct delayed_work *dwork)
>  }
>  EXPORT_SYMBOL(flush_delayed_work);
>
> +/**
> + * flush_rcu_work - wait for a rwork to finish executing the last queueing
> + * @rwork: the rcu work to flush
> + *
> + * Return:
> + * %true if flush_rcu_work() waited for the work to finish execution,
> + * %false if it was already idle.
> + */
> +bool flush_rcu_work(struct rcu_work *rwork)
> +{
> +       if (test_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(&rwork->work))) {
> +               rcu_barrier();
> +               flush_work(&rwork->work);
> +               return true;

A possible tiny improvement: check if it was already queued on wq.
For example:

       if (test_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(&rwork->work))) {
               if (!flush_work(&rwork->work)) {
                      rcu_barrier();
                      flush_work(&rwork->work);
               }
               return true;
> +       } else {
> +               return flush_work(&rwork->work);
> +       }
> +}
> +EXPORT_SYMBOL(flush_rcu_work);
> +
>  static bool __cancel_work(struct work_struct *work, bool is_dwork)
>  {
>         unsigned long flags;
> --
> 2.9.5
>
