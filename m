Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7305ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FBDC20827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="huferaK2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FBDC20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbeKIBLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 20:11:45 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47008 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbeKIBLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 20:11:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BU7SkzwEa7GzidQBjgU36owQODZrfnKAxhguWfpDQnE=; b=huferaK23NC4seMiP2N309eTA
        VFsDHuZ9LcsS3xvGGetPyHG1HFL8WhYAHbQcJiQnj08VClQkiFQ8Z//+oz5jh5myHOUpS3nsrh2Hs
        gQj3S6ehjpvZSi6EKdWm2EA9OaW9NaQ/zobH6y14zaFRoMgcZv35v9XCI8aqEUUVOdIqHjwDcoH9p
        0Q1EWFf6yNZOhrg4/O/5ugcT9BwbFF/iD5XX73K6lIxJ9MiFB76dEH3a+sopVHseThhj5PXqylbpZ
        wzTL2iDgcyEVBZvBJsS7o2C0kUFbpGU4d0DIK4nKwSXzEw6unwbtef7BblTzwoUKtv5ZIpVKXYyZP
        rgVUzwfcg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gKmLN-0007yW-TP; Thu, 08 Nov 2018 15:35:42 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5E8A920284F94; Thu,  8 Nov 2018 16:35:40 +0100 (CET)
Date:   Thu, 8 Nov 2018 16:35:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Question on comment header for for_each_domain()
Message-ID: <20181108153540.GW9761@hirez.programming.kicks-ass.net>
References: <20181107230002.GA15577@linux.ibm.com>
 <20181108092151.GM9761@hirez.programming.kicks-ass.net>
 <20181108153109.GF4170@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108153109.GF4170@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 07:31:09AM -0800, Paul E. McKenney wrote:
> On Thu, Nov 08, 2018 at 10:21:51AM +0100, Peter Zijlstra wrote:
> > On Wed, Nov 07, 2018 at 03:00:02PM -0800, Paul E. McKenney wrote:
> > > Hello!
> > > 
> > > The header comment for for_each_domain() talks about a call to
> > > synchronize_sched() within detach_destroy_domains(), but I am not
> > > seeing any such call.  Because synchronize_sched() is now folded into
> > > synchronize_rcu(), I have a patch that edits the comment, but it looks
> > > like a larger change is needed.
> > > 
> > > Or am I blind today?
> > 
> > I think you're quite right and that comment is a wee bit stale.
> > 
> > The sched domain tree is indeed protected by regular RCU (not RCU-sched
> > as the comment seems to imply) and this is per destroy_sched_domains()
> > using call_rcu().
> > 
> > And most (I didn't look at all) uses for the sched-domain tree do indeed
> > employ rcu_read_lock().
> 
> Ah, thank you for the info!  Would this patch do the trick?

> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 618577fc9aa8..00b91d16af9f 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1237,7 +1237,7 @@ extern void sched_ttwu_pending(void);
>  
>  /*
>   * The domain tree (rq->sd) is protected by RCU's quiescent state transition.
> - * See detach_destroy_domains: synchronize_sched for details.
> + * See destroy_sched_domains: call_rcu for details.
>   *
>   * The domain tree of any CPU may only be accessed from within
>   * preempt-disabled sections.
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 8d7f15ba5916..04d458faf2c1 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -248,7 +248,7 @@ void rq_attach_root(struct rq *rq, struct root_domain *rd)
>  	raw_spin_unlock_irqrestore(&rq->lock, flags);
>  
>  	if (old_rd)
> -		call_rcu_sched(&old_rd->rcu, free_rootdomain);
> +		call_rcu(&old_rd->rcu, free_rootdomain);
>  }
>  
>  void sched_get_rd(struct root_domain *rd)
> @@ -261,7 +261,7 @@ void sched_put_rd(struct root_domain *rd)
>  	if (!atomic_dec_and_test(&rd->refcount))
>  		return;
>  
> -	call_rcu_sched(&rd->rcu, free_rootdomain);
> +	call_rcu(&rd->rcu, free_rootdomain);
>  }
>  
>  static int init_rootdomain(struct root_domain *rd)
> 

Argh, that is the rootdomain, not the regular sched-domain tree. Now
I'll have to go audit that stuff again.

ISTR there being slightly different rules for rootdomain, and with a
reason.

Can we hold onto this until after LPC?
