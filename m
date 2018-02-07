Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2949743-1517976899-2-5223934733193571741
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
    t=1517976899; b=KLWJl/GIa2RmNCyb2yzhJBRsp3ssXP6dOauGw7CnAJGS5vN
    1SDUz60x2jCdmjY4rJpi7Qn9wQyoDA5W/Jycs5X+5wXoAWXdF5KF3i3JD3i7ovrw
    p3EJ5tqhi/rsUPB8ESofbD9mPrwwN/XQubvp4HCQlrgE6FzQvYnCzVivgS8PZLs8
    tBWkXK+OnucJSGYAS+p+1ktiBPFdsM8T461lGarUpx3GqzW6AaVBnTiq9S/UJJBJ
    gleksPa48jmIZ3/7JXXTajZbhK1YVf7To2O8Jt+M2wujfj/V9Q415DnHke+I9mgK
    ypyG5DaImoJirckT956VvhUsEXFMYIl7dKNEDhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1517976899; bh=cIOQFlhJ4Dmm0lA3yRuGIRuFFqTENNdxpd4KwZStdrc=; b=q
    T3lMz+8Uvjz2amSamCB1GABhX7WOlLqAGcoSe9+y30DV9cY9/0Rqj8PPt4ksqdN9
    kSct0cgrKhToAxdiWrQYfRiBzHc6b6SYcm78SfHDM2NDERR5UvTmy1/YgfC4V0Ew
    0w6yQ3h9pZ3Qk+2xJhFus3ASxLSs2907dv/T1wwThctMEx262ryVvHRRJRVVsI9K
    VTc0OuIaYDH3rnXBp/im6EydRj9wzG9oWeuaTPCN5yuR6jSd6IKtfFLcZeqYvJ+g
    0tHRmaIy2ElH04xyZGvcExhcQcWtRYuuSl1ZjMK2a/Vgnti+L36c4XeENaNGW+4J
    Sg4GDmt93HWALwHCvdu6w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=goodmis.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=goodmis.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753246AbeBGEOp (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 23:14:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:45354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752564AbeBGEOo (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 6 Feb 2018 23:14:44 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E7352075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Tue, 6 Feb 2018 23:14:40 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "tip-bot for Steven Rostedt (VMware)" <tipbot@zytor.com>
Cc: pkondeti@codeaurora.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org, efault@gmx.de,
        peterz@infradead.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, mingo@kernel.org,
        tglx@linutronix.de, linux-tip-commits@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [tip:sched/urgent] sched/rt: Use container_of() to get root
 domain in rto_push_irq_work_func()
Message-ID: <20180206231440.4bc7f636@vmware.local.home>
In-Reply-To: <tip-ad0f1d9d65938aec72a698116cd73a980916895e@git.kernel.org>
References: <CAEU1=PkiHO35Dzna8EQqNSKW1fr1y1zRQ5y66X117MG06sQtNA@mail.gmail.com>
        <tip-ad0f1d9d65938aec72a698116cd73a980916895e@git.kernel.org>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


I see this was just applied to Linus's tree. It probably should be
tagged for stable as well.

-- Steve


On Tue, 6 Feb 2018 03:54:16 -0800
"tip-bot for Steven Rostedt (VMware)" <tipbot@zytor.com> wrote:

> Commit-ID:  ad0f1d9d65938aec72a698116cd73a980916895e
> Gitweb:     https://git.kernel.org/tip/ad0f1d9d65938aec72a698116cd73a980916895e
> Author:     Steven Rostedt (VMware) <rostedt@goodmis.org>
> AuthorDate: Tue, 23 Jan 2018 20:45:37 -0500
> Committer:  Ingo Molnar <mingo@kernel.org>
> CommitDate: Tue, 6 Feb 2018 10:20:33 +0100
> 
> sched/rt: Use container_of() to get root domain in rto_push_irq_work_func()
> 
> When the rto_push_irq_work_func() is called, it looks at the RT overloaded
> bitmask in the root domain via the runqueue (rq->rd). The problem is that
> during CPU up and down, nothing here stops rq->rd from changing between
> taking the rq->rd->rto_lock and releasing it. That means the lock that is
> released is not the same lock that was taken.
> 
> Instead of using this_rq()->rd to get the root domain, as the irq work is
> part of the root domain, we can simply get the root domain from the irq work
> that is passed to the routine:
> 
>  container_of(work, struct root_domain, rto_push_work)
> 
> This keeps the root domain consistent.
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
>  kernel/sched/rt.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 862a513..2fb627d 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1907,9 +1907,8 @@ static void push_rt_tasks(struct rq *rq)
>   * the rt_loop_next will cause the iterator to perform another scan.
>   *
>   */
> -static int rto_next_cpu(struct rq *rq)
> +static int rto_next_cpu(struct root_domain *rd)
>  {
> -	struct root_domain *rd = rq->rd;
>  	int next;
>  	int cpu;
>  
> @@ -1985,7 +1984,7 @@ static void tell_cpu_to_push(struct rq *rq)
>  	 * Otherwise it is finishing up and an ipi needs to be sent.
>  	 */
>  	if (rq->rd->rto_cpu < 0)
> -		cpu = rto_next_cpu(rq);
> +		cpu = rto_next_cpu(rq->rd);
>  
>  	raw_spin_unlock(&rq->rd->rto_lock);
>  
> @@ -1998,6 +1997,8 @@ static void tell_cpu_to_push(struct rq *rq)
>  /* Called from hardirq context */
>  void rto_push_irq_work_func(struct irq_work *work)
>  {
> +	struct root_domain *rd =
> +		container_of(work, struct root_domain, rto_push_work);
>  	struct rq *rq;
>  	int cpu;
>  
> @@ -2013,18 +2014,18 @@ void rto_push_irq_work_func(struct irq_work *work)
>  		raw_spin_unlock(&rq->lock);
>  	}
>  
> -	raw_spin_lock(&rq->rd->rto_lock);
> +	raw_spin_lock(&rd->rto_lock);
>  
>  	/* Pass the IPI to the next rt overloaded queue */
> -	cpu = rto_next_cpu(rq);
> +	cpu = rto_next_cpu(rd);
>  
> -	raw_spin_unlock(&rq->rd->rto_lock);
> +	raw_spin_unlock(&rd->rto_lock);
>  
>  	if (cpu < 0)
>  		return;
>  
>  	/* Try the next RT overloaded CPU */
> -	irq_work_queue_on(&rq->rd->rto_push_work, cpu);
> +	irq_work_queue_on(&rd->rto_push_work, cpu);
>  }
>  #endif /* HAVE_RT_PUSH_IPI */
>  
