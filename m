Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22489C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 11:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C19CD269F3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 11:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FR/XSvgp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C19CD269F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934882AbeFZLlu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 07:41:50 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:42150 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933780AbeFZLlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 07:41:49 -0400
Received: by mail-qt0-f195.google.com with SMTP id y31-v6so14772353qty.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 04:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZjKK9Xh33M0fSXVgRZGKtoLhikXaQWIZgNTHh3wyyls=;
        b=FR/XSvgpB8c9ohizqnHI95vSeeTBR5RZECilqE6Ldo/Q94aQIa2jMSuI6aogoSA4R2
         U+TlvzfSoO3rG548c9Z8aIR78fnYPuI3xGGx5hVmYWWSfJ3j5vZT8hot6nznlhKi0iQH
         sAONbViU0qtkWTaxGwZdXsW2vAZEmbj6M8najXXiiNJbzGzGSJCCb3XL2CL5i7XYGN2F
         eyty56Q8e6vToJxdAmA0TLtbMNXeh9L4sPHTrCVFZY6Bjr/yBJVGZ8jn6MUhHmXob0Zx
         P91YUlHDDLFJFQVQA7THN+pY29iErunRImtnjTR5RWBpkKJWnwqM8AM5GaztOCAzQezX
         UKQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZjKK9Xh33M0fSXVgRZGKtoLhikXaQWIZgNTHh3wyyls=;
        b=MBhkLY8tRrVt5507XFtZct+eFEDsHzG0QoeJyVgpwYIBQLbJU2nN3IW7rVX4jQHr7Q
         0MCx59lBNuaE2zGfAuT9MHRBywD3Ikkdsmu7Gzqx4Qqbzv1NC5bpB/LVhz06Ii1RbuRv
         4GPShu8EVDFmiG+vvxkdFNN+4Vwg3yeLugRa/+QmmYx/zSb5wri+8tpd9i6/HqwFhwMb
         NyatBtZyuInztlcoZCZhsvTh2N7Lw3YiwfSW40D/LE0/PylxhJ6WnAd+adquk0UCHg9U
         PE4ACAqRB8NVEfkzXTc6pD3Edib5oKqp0lv3eQN7b8u+trrEB8ijOb/0+ENgPWzO5lFt
         ic4w==
X-Gm-Message-State: APt69E3+50gPpkan2qXpH6P2m2lv9gm2hCA3JPDEpVWB1eEoex0h7jQ/
        ffRxGZ76wqi7MoIOH5G+5lU=
X-Google-Smtp-Source: AAOMgpdHN7VyVVJl/dLjVWEabtkGNu1k3rVVyLW7mod04lreT83W1xEatQyjsfbCtapKtKAWn2N9Sg==
X-Received: by 2002:aed:36e7:: with SMTP id f94-v6mr980685qtb.276.1530013308325;
        Tue, 26 Jun 2018 04:41:48 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id d14-v6sm884506qtn.90.2018.06.26.04.41.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 04:41:47 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 2567321398;
        Tue, 26 Jun 2018 07:41:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 26 Jun 2018 07:41:46 -0400
X-ME-Sender: <xms:eSYyWyS2ensFwlAUoPZa1-6CtCLZEUsP8tY--baSzIcNezxGWhWOiw>
Received: from localhost (unknown [45.32.128.109])
        by mail.messagingengine.com (Postfix) with ESMTPA id ED24C1025D;
        Tue, 26 Jun 2018 07:41:44 -0400 (EDT)
Date:   Tue, 26 Jun 2018 19:46:52 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 2/2] rcu: Make expedited GPs handle CPU 0
 being offline
Message-ID: <20180626114652.GH9125@tardis>
References: <20180625224308.GA10064@linux.vnet.ibm.com>
 <20180625224332.10596-2-paulmck@linux.vnet.ibm.com>
 <20180626093820.GG2494@hirez.programming.kicks-ass.net>
 <20180626104447.GG9125@tardis>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626104447.GG9125@tardis>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 06:44:47PM +0800, Boqun Feng wrote:
> On Tue, Jun 26, 2018 at 11:38:20AM +0200, Peter Zijlstra wrote:
> > On Mon, Jun 25, 2018 at 03:43:32PM -0700, Paul E. McKenney wrote:
> > > +		preempt_disable();
> > > +		for_each_leaf_node_possible_cpu(rnp, cpu) {
> > > +			if (cpu_is_offline(cpu)) /* Preemption disabled. */
> > > +				continue;
> > 
> > Create for_each_node_online_cpu() instead? Seems a bit pointless to
> > iterate possible mask only to then check it against the online mask.
> > Just iterate the online mask directly.
> > 
> > Or better yet, write this as:
> > 
> > 	preempt_disable();
> > 	cpu = cpumask_next(rnp->grplo - 1, cpu_online_mask);
> > 	if (cpu > rnp->grphi)
> > 		cpu = WORK_CPU_UNBOUND;
> > 	queue_work_on(cpu, rcu_par_gp_wq, &rnp->rew.rew_work);
> > 	preempt_enable();
> > 
> > Which is what it appears to be doing.
> > 
> 
> Make sense! Thanks ;-)
> 
> Applied this and running a TREE03 rcutorture. If all go well, I will
> send the updated patch.
> 

So the patch has passed one 30 min run for TREE03 rcutorture. Paul,
if it looks good, could you take it for your next spin or pull request
in the future? Thanks.

Regards,
Boqun

-------------->8
Subject: [PATCH tip/core/rcu v2] rcu: exp: Make expedited GPs handle CPU 0 being offline

Currently, the parallelized initialization of expedited grace periods
uses the workqueue associated with each rcu_node structure's ->grplo
field.  This works fine unless that CPU is offline.  This commit
therefore uses the CPU corresponding to the lowest-numbered online CPU,
or fallback to queue the work on WORK_CPU_UNBOUND if there are no online
CPUs on this rcu_node structure.

Note that this patch uses cpu_online_mask instead of the usual approach
of checking bits in the rcu_node structure's ->qsmaskinitnext field.
This is safe because preemption is disabled across both the
cpu_online_mask check and the call to queue_work_on().

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
[ paulmck: Disable preemption to close offline race window. ]
Not-Yet-Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
v1 --> v2:
	
*	Replace the for_each_leaf_node_possible_cpu() + cpu_is_offline()
	check loop with a single cpumask_next() as suggested by Peter
	Zijlstra

 kernel/rcu/tree_exp.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index d40708e8c5d6..3bf87fd4bd91 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -473,6 +473,7 @@ static void sync_rcu_exp_select_cpus(struct rcu_state *rsp,
 				     smp_call_func_t func)
 {
 	struct rcu_node *rnp;
+	int cpu;
 
 	trace_rcu_exp_grace_period(rsp->name, rcu_exp_gp_seq_endval(rsp), TPS("reset"));
 	sync_exp_reset_tree(rsp);
@@ -492,7 +493,13 @@ static void sync_rcu_exp_select_cpus(struct rcu_state *rsp,
 			continue;
 		}
 		INIT_WORK(&rnp->rew.rew_work, sync_rcu_exp_select_node_cpus);
-		queue_work_on(rnp->grplo, rcu_par_gp_wq, &rnp->rew.rew_work);
+		preempt_disable();
+		cpu = cpumask_next(rnp->grplo - 1, cpu_online_mask);
+		/* All offlines, queue the work on an unbound CPU */
+		if (unlikely(cpu > rnp->grphi))
+			cpu = WORK_CPU_UNBOUND;
+		queue_work_on(cpu, rcu_par_gp_wq, &rnp->rew.rew_work);
+		preempt_enable();
 		rnp->exp_need_flush = true;
 	}
 
-- 
2.17.1

