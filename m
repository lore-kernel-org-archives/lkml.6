Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CF2ECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 14:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21B8920896
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 14:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="dcl48MzP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21B8920896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbeGNOvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 10:51:18 -0400
Received: from mail.efficios.com ([167.114.142.138]:35458 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbeGNOvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 10:51:17 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id CA9211B74CB;
        Sat, 14 Jul 2018 10:31:59 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id w_4vqp72Tjnx; Sat, 14 Jul 2018 10:31:58 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 4C6D71B74C4;
        Sat, 14 Jul 2018 10:31:58 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 4C6D71B74C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1531578718;
        bh=NIIGnCSzNoiKQRSVNNsaa2AuVcz7lrGDO8e6bUGG/M8=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=dcl48MzPcAwnkFHJ724B3eHKrJsyOf/8SrkBS7bnfbN6zKC9X5414QmDHrJ2SpIxM
         me+aRzhdXx4/9Klek5a5GaRbAWTR+69D+IJinzaxijOcQ0RHzEGnmPEcVgl6lwCLkU
         lQUQIB+tMEg8HTdrZ/GNNGh5vvJgP0HisJRLAxvmHafZvUhXNDtvxJQN/f88g4bK44
         j1TsZasFXpPTrKe/B5vw3d+OZ2CRTmoc/cQXMB0EHE+f1WOsg81uJocTpHE6pWBORU
         QUUJQFH7w+Z+NzjSAjRXbd9neFBekmwUngHgNFB6Yz+6CV+kJv7LaRQMkzsc+2rJIm
         yVHVgDJ0r+ZoQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id Vo3EzGxCtvEs; Sat, 14 Jul 2018 10:31:58 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 31BE01B74BD;
        Sat, 14 Jul 2018 10:31:58 -0400 (EDT)
Date:   Sat, 14 Jul 2018 10:31:57 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     "Joel Fernandes, Google" <joel@joelfernandes.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Erick Reyes <erickreyes@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Todd Kjos <tkjos@google.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>
Message-ID: <1420383125.4964.1531578717837.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180713215547.255620-3-joel@joelfernandes.org>
References: <20180713215547.255620-1-joel@joelfernandes.org> <20180713215547.255620-3-joel@joelfernandes.org>
Subject: Re: [PATCH v10 2/3] tracepoint: Make rcuidle tracepoint callers use
 SRCU
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: tracepoint: Make rcuidle tracepoint callers use SRCU
Thread-Index: GAYR78LA0J4BTegV3PVmbdxukz+zXg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jul 13, 2018, at 5:55 PM, Joel Fernandes, Google joel@joelfernandes.org wrote:

> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> 
> In recent tests with IRQ on/off tracepoints, a large performance
> overhead ~10% is noticed when running hackbench. This is root caused to
> calls to rcu_irq_enter_irqson and rcu_irq_exit_irqson from the
> tracepoint code. Following a long discussion on the list [1] about this,
> we concluded that srcu is a better alternative for use during rcu idle.
> Although it does involve extra barriers, its lighter than the sched-rcu
> version which has to do additional RCU calls to notify RCU idle about
> entry into RCU sections.
> 
> In this patch, we change the underlying implementation of the
> trace_*_rcuidle API to use SRCU. This has shown to improve performance
> alot for the high frequency irq enable/disable tracepoints.
> 
> Test: Tested idle and preempt/irq tracepoints.
> 
> Here are some performance numbers:
> 
> With a run of the following 30 times on a single core x86 Qemu instance
> with 1GB memory:
> hackbench -g 4 -f 2 -l 3000
> 
> Completion times in seconds. CONFIG_PROVE_LOCKING=y.
> 
> No patches (without this series)
> Mean: 3.048
> Median: 3.025
> Std Dev: 0.064
> 
> With Lockdep using irq tracepoints with RCU implementation:
> Mean: 3.451   (-11.66 %)
> Median: 3.447 (-12.22%)
> Std Dev: 0.049
> 
> With Lockdep using irq tracepoints with SRCU implementation (this series):
> Mean: 3.020   (I would consider the improvement against the "without
>	       this series" case as just noise).
> Median: 3.013
> Std Dev: 0.033
> 
> [1] https://patchwork.kernel.org/patch/10344297/
> 
> Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

I'm fine with the changes done since last iteration.

Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks!

Mathieu

> Cleaned-up-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
> include/linux/tracepoint.h | 45 +++++++++++++++++++++++++++++++-------
> kernel/tracepoint.c        | 16 +++++++++++++-
> 2 files changed, 52 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index 19a690b559ca..97e1d365a817 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -15,6 +15,7 @@
>  */
> 
> #include <linux/smp.h>
> +#include <linux/srcu.h>
> #include <linux/errno.h>
> #include <linux/types.h>
> #include <linux/cpumask.h>
> @@ -33,6 +34,8 @@ struct trace_eval_map {
> 
> #define TRACEPOINT_DEFAULT_PRIO	10
> 
> +extern struct srcu_struct tracepoint_srcu;
> +
> extern int
> tracepoint_probe_register(struct tracepoint *tp, void *probe, void *data);
> extern int
> @@ -75,10 +78,16 @@ int unregister_tracepoint_module_notifier(struct
> notifier_block *nb)
>  * probe unregistration and the end of module exit to make sure there is no
>  * caller executing a probe when it is freed.
>  */
> +#ifdef CONFIG_TRACEPOINTS
> static inline void tracepoint_synchronize_unregister(void)
> {
> +	synchronize_srcu(&tracepoint_srcu);
> 	synchronize_sched();
> }
> +#else
> +static inline void tracepoint_synchronize_unregister(void)
> +{ }
> +#endif
> 
> #ifdef CONFIG_HAVE_SYSCALL_TRACEPOINTS
> extern int syscall_regfunc(void);
> @@ -129,18 +138,34 @@ extern void syscall_unregfunc(void);
>  * as "(void *, void)". The DECLARE_TRACE_NOARGS() will pass in just
>  * "void *data", where as the DECLARE_TRACE() will pass in "void *data, proto".
>  */
> -#define __DO_TRACE(tp, proto, args, cond, rcucheck)			\
> +#define __DO_TRACE(tp, proto, args, cond, rcuidle)			\
> 	do {								\
> 		struct tracepoint_func *it_func_ptr;			\
> 		void *it_func;						\
> 		void *__data;						\
> +		int __maybe_unused idx = 0;				\
> 									\
> 		if (!(cond))						\
> 			return;						\
> -		if (rcucheck)						\
> -			rcu_irq_enter_irqson();				\
> -		rcu_read_lock_sched_notrace();				\
> -		it_func_ptr = rcu_dereference_sched((tp)->funcs);	\
> +									\
> +		/* srcu can't be used from NMI */			\
> +		if (rcuidle && in_nmi())				\
> +			WARN_ON_ONCE(1);				\
> +									\
> +		/* keep srcu and sched-rcu usage consistent */		\
> +		preempt_disable_notrace();				\
> +									\
> +		/*							\
> +		 * For rcuidle callers, use srcu since sched-rcu	\
> +		 * doesn't work from the idle path.			\
> +		 */							\
> +		if (rcuidle)						\
> +			idx = srcu_read_lock_notrace(&tracepoint_srcu);	\
> +		else							\
> +			rcu_read_lock_sched_notrace();			\
> +									\
> +		it_func_ptr = rcu_dereference_raw((tp)->funcs);		\
> +									\
> 		if (it_func_ptr) {					\
> 			do {						\
> 				it_func = (it_func_ptr)->func;		\
> @@ -148,9 +173,13 @@ extern void syscall_unregfunc(void);
> 				((void(*)(proto))(it_func))(args);	\
> 			} while ((++it_func_ptr)->func);		\
> 		}							\
> -		rcu_read_unlock_sched_notrace();			\
> -		if (rcucheck)						\
> -			rcu_irq_exit_irqson();				\
> +									\
> +		if (rcuidle)						\
> +			srcu_read_unlock_notrace(&tracepoint_srcu, idx);\
> +		else							\
> +			rcu_read_unlock_sched_notrace();		\
> +									\
> +		preempt_enable_notrace();				\
> 	} while (0)
> 
> #ifndef MODULE
> diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
> index 6dc6356c3327..955148d91b74 100644
> --- a/kernel/tracepoint.c
> +++ b/kernel/tracepoint.c
> @@ -31,6 +31,9 @@
> extern struct tracepoint * const __start___tracepoints_ptrs[];
> extern struct tracepoint * const __stop___tracepoints_ptrs[];
> 
> +DEFINE_SRCU(tracepoint_srcu);
> +EXPORT_SYMBOL_GPL(tracepoint_srcu);
> +
> /* Set to 1 to enable tracepoint debug output */
> static const int tracepoint_debug;
> 
> @@ -67,16 +70,27 @@ static inline void *allocate_probes(int count)
> 	return p == NULL ? NULL : p->probes;
> }
> 
> -static void rcu_free_old_probes(struct rcu_head *head)
> +static void srcu_free_old_probes(struct rcu_head *head)
> {
> 	kfree(container_of(head, struct tp_probes, rcu));
> }
> 
> +static void rcu_free_old_probes(struct rcu_head *head)
> +{
> +	call_srcu(&tracepoint_srcu, head, srcu_free_old_probes);
> +}
> +
> static inline void release_probes(struct tracepoint_func *old)
> {
> 	if (old) {
> 		struct tp_probes *tp_probes = container_of(old,
> 			struct tp_probes, probes[0]);
> +		/*
> +		 * Tracepoint probes are protected by both sched RCU and SRCU,
> +		 * by calling the SRCU callback in the sched RCU callback we
> +		 * cover both cases. So let us chain the SRCU and sched RCU
> +		 * callbacks to wait for both grace periods.
> +		 */
> 		call_rcu_sched(&tp_probes->rcu, rcu_free_old_probes);
> 	}
> }
> --
> 2.18.0.203.gfac676dfb9-goog

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
