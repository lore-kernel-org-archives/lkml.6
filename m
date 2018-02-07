Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2942899-1517976953-2-7235270946715853479
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517976952; b=NjJGzV3mGiJWmWBNeekzpU+ASRcFlz0RXtbBoYFStMKWh+s
    VddakmDxnx0xqAZp0QHZFD8zHUjYz/Flgsfz/I/ovFW7V/uAmtFpIV+4QyTn9CNQ
    0HN8I3TcJBAEJ4PHolf4Q8Zm58D9+qEeUbG5bG/Fxmbie6WEwsnQcv7dn6vsbWBp
    Y0NzaPLSIvUpZmZO8ubuGHYIrbs0pkphCk9yo1nwlsRQ+fd5/Q9+WKIBYW8AOF3g
    OuyRCj+g+BbbQ+u9cmu08XQRHNpIC3+XdYXCJeYRm765/TcvpOY3PwQ/JUXWYD49
    gO8HuO8fjmNmItMt3s373YgbvijrdiqCSNU3lqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1517976952; bh=LUk/wZSVKM/ev055PYuZumLAKLz7ZAEq8VHchY1RqnY=; b=F
    hC6cgJR/0Vl8wMEsCMcN98DKkhcy+qJu+wQYcLausdZjReB8dsFt/PGvUBh+44aS
    5lfi/TxRDzfFuA4O9NYCqHhKHcxrQVhr5gcH/wYahyr3plll0UFtUE+5FQK3/mBm
    b/XI9GMRP9J40ZRzOdaXCqt5BggQNOx04CkjeF7KWMcmLFwnLQjGkdE9VKahXzrt
    ceitq4MOb+P8y90vGLA8gvsvIqjRs9BN0CDQxCIFWcJydgsOUSb+51maFAQskab3
    eSK6k1Gq6YFH0fuizlq3Ro7waDk1P9nLT5HteeMXUppk87tUD0/HWs/vqNXVaAyh
    DgJpRDvJ+Stpu1fp5w8LA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=goodmis.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=goodmis.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753420AbeBGEPl (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 23:15:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:45792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753359AbeBGEPj (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 6 Feb 2018 23:15:39 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E25F82075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Tue, 6 Feb 2018 23:15:35 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "tip-bot for Steven Rostedt (VMware)" <tipbot@zytor.com>
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        hpa@zytor.com, rostedt@goodmis.org, peterz@infradead.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        efault@gmx.de, pkondeti@codeaurora.org,
        linux-tip-commits@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [tip:sched/urgent] sched/rt: Up the root domain ref count when
 passing it around via IPIs
Message-ID: <20180206231535.626c402a@vmware.local.home>
In-Reply-To: <tip-364f56653708ba8bcdefd4f0da2a42904baa8eeb@git.kernel.org>
References: <CAEU1=PkiHO35Dzna8EQqNSKW1fr1y1zRQ5y66X117MG06sQtNA@mail.gmail.com>
        <tip-364f56653708ba8bcdefd4f0da2a42904baa8eeb@git.kernel.org>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


I see this was just applied to Linus's tree. This too probably should be
tagged for stable as well.

-- Steve


On Tue, 6 Feb 2018 03:54:42 -0800
"tip-bot for Steven Rostedt (VMware)" <tipbot@zytor.com> wrote:

> Commit-ID:  364f56653708ba8bcdefd4f0da2a42904baa8eeb
> Gitweb:     https://git.kernel.org/tip/364f56653708ba8bcdefd4f0da2a42904baa8eeb
> Author:     Steven Rostedt (VMware) <rostedt@goodmis.org>
> AuthorDate: Tue, 23 Jan 2018 20:45:38 -0500
> Committer:  Ingo Molnar <mingo@kernel.org>
> CommitDate: Tue, 6 Feb 2018 10:20:33 +0100
> 
> sched/rt: Up the root domain ref count when passing it around via IPIs
> 
> When issuing an IPI RT push, where an IPI is sent to each CPU that has more
> than one RT task scheduled on it, it references the root domain's rto_mask,
> that contains all the CPUs within the root domain that has more than one RT
> task in the runable state. The problem is, after the IPIs are initiated, the
> rq->lock is released. This means that the root domain that is associated to
> the run queue could be freed while the IPIs are going around.
> 
> Add a sched_get_rd() and a sched_put_rd() that will increment and decrement
> the root domain's ref count respectively. This way when initiating the IPIs,
> the scheduler will up the root domain's ref count before releasing the
> rq->lock, ensuring that the root domain does not go away until the IPI round
> is complete.
> 
> Reported-by: Pavan Kondeti <pkondeti@codeaurora.org>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Mike Galbraith <efault@gmx.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Fixes: 4bdced5c9a292 ("sched/rt: Simplify the IPI based RT balancing logic")
> Link: http://lkml.kernel.org/r/CAEU1=PkiHO35Dzna8EQqNSKW1fr1y1zRQ5y66X117MG06sQtNA@mail.gmail.com
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
>  kernel/sched/rt.c       |  9 +++++++--
>  kernel/sched/sched.h    |  2 ++
>  kernel/sched/topology.c | 13 +++++++++++++
>  3 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 2fb627d..89a086e 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1990,8 +1990,11 @@ static void tell_cpu_to_push(struct rq *rq)
>  
>  	rto_start_unlock(&rq->rd->rto_loop_start);
>  
> -	if (cpu >= 0)
> +	if (cpu >= 0) {
> +		/* Make sure the rd does not get freed while pushing */
> +		sched_get_rd(rq->rd);
>  		irq_work_queue_on(&rq->rd->rto_push_work, cpu);
> +	}
>  }
>  
>  /* Called from hardirq context */
> @@ -2021,8 +2024,10 @@ void rto_push_irq_work_func(struct irq_work *work)
>  
>  	raw_spin_unlock(&rd->rto_lock);
>  
> -	if (cpu < 0)
> +	if (cpu < 0) {
> +		sched_put_rd(rd);
>  		return;
> +	}
>  
>  	/* Try the next RT overloaded CPU */
>  	irq_work_queue_on(&rd->rto_push_work, cpu);
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 2e95505..fb5fc45 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -691,6 +691,8 @@ extern struct mutex sched_domains_mutex;
>  extern void init_defrootdomain(void);
>  extern int sched_init_domains(const struct cpumask *cpu_map);
>  extern void rq_attach_root(struct rq *rq, struct root_domain *rd);
> +extern void sched_get_rd(struct root_domain *rd);
> +extern void sched_put_rd(struct root_domain *rd);
>  
>  #ifdef HAVE_RT_PUSH_IPI
>  extern void rto_push_irq_work_func(struct irq_work *work);
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 034cbed..519b024 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -259,6 +259,19 @@ void rq_attach_root(struct rq *rq, struct root_domain *rd)
>  		call_rcu_sched(&old_rd->rcu, free_rootdomain);
>  }
>  
> +void sched_get_rd(struct root_domain *rd)
> +{
> +	atomic_inc(&rd->refcount);
> +}
> +
> +void sched_put_rd(struct root_domain *rd)
> +{
> +	if (!atomic_dec_and_test(&rd->refcount))
> +		return;
> +
> +	call_rcu_sched(&rd->rcu, free_rootdomain);
> +}
> +
>  static int init_rootdomain(struct root_domain *rd)
>  {
>  	if (!zalloc_cpumask_var(&rd->span, GFP_KERNEL))
