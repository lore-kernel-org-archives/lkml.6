Return-Path: <SRS0=V1ol=GE=linux.vnet.ibm.com=paulmck@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2529736-1521058353-2-13442306389964624729
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='198.145.29.99', Host='mail.kernel.org', Country='US', FromHeader='com',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: SRS0=V1ol=GE=linux.vnet.ibm.com=paulmck@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521058352; b=GCin68rlJdAfyFWJv3QSUT8sIhguv0YMePj+YLSZzg8jXv/
    MEwz/6mE+dkET39qXbTK5y81EuFFoNU9ZnDxIpcUe52My4rUTw8uGY4xY8FS/ytV
    Ly101TBvLbZ279Gd0FzXX2PSvPQmBrQ3qqExbNZuuAnu7BR2jL5+Kz1IyB4Fvnw1
    q3LqYACs+Qnyw/lCY0LG6G9oW0mOUKhBfvxiGtNcfh3DOBL7ddA5oqcF/HcpsEQD
    KLpCb8HycCUFO6uZxghTM445tOMpICrbH2qeycKiBS2Rcj3/GmN91Ov+h/PbnDzW
    VsnqBQSpj7GSBpkbxSPv4AQCS7y9VwPMJJ9hZYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:reply-to
    :references:mime-version:content-type:in-reply-to:message-id; s=
    arctest; t=1521058352; bh=ps7nGv0r//9LZsPPEQc/BOvzrsc4/xkVZPoRGd
    anUeU=; b=AuPEFZr8pblB0msRLXslLlprzbCYIC6UVZUYdeYykfku6p8JpDYBuY
    hnZBXC6khwZdMTTAjEiec8/jOUFZYtLdfcA45h/jecSlXq6KkHE1lLy3BTaZKK10
    UKi+pzsyJJjDnsHbaB3sgYVcTiWeSuWiMGlOwjZLGIpb3IZqHmTGFHzt8eT26I4W
    znRrmvmEsa6+MxOVRb0+EavkV4E9tdbY2VkpBdNX5XtUp+skf1YbqfAs71Sp0N68
    nu0KbAaG0vK8NahvC/qOA+enGyAK+VV0GR94aiFjs9RRNm09J7060hecfBo7wZaG
    qhxx2ClqyA/jVTggs09z9fy4VknQDdKQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,d=none) header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=V1ol=GE=linux.vnet.ibm.com=paulmck@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=linux.vnet.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,d=none) header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=V1ol=GE=linux.vnet.ibm.com=paulmck@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=linux.vnet.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C90120779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=paulmck@linux.vnet.ibm.com
Date: Wed, 14 Mar 2018 13:13:04 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, jannh@google.com, bcrl@kvack.org,
        viro@zeniv.linux.org.uk, kent.overstreet@gmail.com,
        security@kernel.org, linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 6/8] RCU, workqueue: Implement rcu_work
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180314194205.1651587-1-tj@kernel.org>
 <20180314194515.1661824-1-tj@kernel.org>
 <20180314194515.1661824-6-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314194515.1661824-6-tj@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18031420-0048-0000-0000-0000024A8F71
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008674; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01003060; UDB=6.00510445; IPR=6.00782391;
 MB=3.00020035; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-14 20:12:25
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031420-0049-0000-0000-00004470041A
Message-Id: <20180314201304.GF3918@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-14_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803140215
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 12:45:13PM -0700, Tejun Heo wrote:
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

Looks good to me!

Reviewed-by: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

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
>  	int cpu;
>  };
> 
> +struct rcu_work {
> +	struct work_struct work;
> +	struct rcu_head rcu;
> +
> +	/* target workqueue ->rcu uses to queue ->work */
> +	struct workqueue_struct *wq;
> +};
> +
>  /**
>   * struct workqueue_attrs - A struct for workqueue attributes.
>   *
> @@ -151,6 +160,11 @@ static inline struct delayed_work *to_delayed_work(struct work_struct *work)
>  	return container_of(work, struct delayed_work, work);
>  }
> 
> +static inline struct rcu_work *to_rcu_work(struct work_struct *work)
> +{
> +	return container_of(work, struct rcu_work, work);
> +}
> +
>  struct execute_work {
>  	struct work_struct work;
>  };
> @@ -266,6 +280,12 @@ static inline unsigned int work_static(struct work_struct *work) { return 0; }
>  #define INIT_DEFERRABLE_WORK_ONSTACK(_work, _func)			\
>  	__INIT_DELAYED_WORK_ONSTACK(_work, _func, TIMER_DEFERRABLE)
> 
> +#define INIT_RCU_WORK(_work, _func)					\
> +	INIT_WORK(&(_work)->work, (_func))
> +
> +#define INIT_RCU_WORK_ONSTACK(_work, _func)				\
> +	INIT_WORK_ONSTACK(&(_work)->work, (_func))
> +
>  /**
>   * work_pending - Find out whether a work item is currently pending
>   * @work: The work item in question
> @@ -447,6 +467,7 @@ extern bool queue_delayed_work_on(int cpu, struct workqueue_struct *wq,
>  			struct delayed_work *work, unsigned long delay);
>  extern bool mod_delayed_work_on(int cpu, struct workqueue_struct *wq,
>  			struct delayed_work *dwork, unsigned long delay);
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
>  				     int max_active);
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
> +	struct rcu_work *rwork = container_of(rcu, struct rcu_work, rcu);
> +
> +	/* read the comment in __queue_work() */
> +	local_irq_disable();
> +	__queue_work(WORK_CPU_UNBOUND, rwork->wq, &rwork->work);
> +	local_irq_enable();
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
> +bool queue_rcu_work(struct workqueue_struct *wq, struct rcu_work *rwork)
> +{
> +	struct work_struct *work = &rwork->work;
> +
> +	if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work))) {
> +		rwork->wq = wq;
> +		call_rcu(&rwork->rcu, rcu_work_rcufn);
> +		return true;
> +	}
> +
> +	return false;
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
> +	if (test_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(&rwork->work))) {
> +		rcu_barrier();
> +		flush_work(&rwork->work);
> +		return true;
> +	} else {
> +		return flush_work(&rwork->work);
> +	}
> +}
> +EXPORT_SYMBOL(flush_rcu_work);
> +
>  static bool __cancel_work(struct work_struct *work, bool is_dwork)
>  {
>  	unsigned long flags;
> -- 
> 2.9.5
> 
