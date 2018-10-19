Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57CBECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 00:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D98D21476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 00:19:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D98D21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbeJSIXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 04:23:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54412 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725934AbeJSIXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 04:23:14 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9J0EIeF120505
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 20:19:40 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n6yu5aq7q-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 20:19:40 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 18 Oct 2018 20:19:38 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 18 Oct 2018 20:19:34 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9J0JXHo17367056
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Oct 2018 00:19:33 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5FCFEB2064;
        Fri, 19 Oct 2018 00:19:33 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 278BAB2065;
        Fri, 19 Oct 2018 00:19:33 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.132.214])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 19 Oct 2018 00:19:33 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id D9F8516C3AA2; Thu, 18 Oct 2018 17:19:32 -0700 (PDT)
Date:   Thu, 18 Oct 2018 17:19:32 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Nikolay Borisov <nborisov@suse.com>, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC] doc: rcu: remove obsolete (non-)requirement about
 disabling preemption
Reply-To: paulmck@linux.ibm.com
References: <20181015201556.GA43575@joelaf.mtv.corp.google.com>
 <20181015210856.GE2674@linux.ibm.com>
 <20181016112611.GA27405@linux.ibm.com>
 <20181016204122.GA8176@joelaf.mtv.corp.google.com>
 <20181017161100.GP2674@linux.ibm.com>
 <20181017181505.GC107185@joelaf.mtv.corp.google.com>
 <20181017203324.GS2674@linux.ibm.com>
 <20181018020751.GB99677@joelaf.mtv.corp.google.com>
 <20181018144637.GD2674@linux.ibm.com>
 <20181019000350.GB89903@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181019000350.GB89903@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18101900-0052-0000-0000-000003462BB5
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009898; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01104680; UDB=6.00571900; IPR=6.00884730;
 MB=3.00023815; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-19 00:19:37
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101900-0053-0000-0000-00005E769596
Message-Id: <20181019001932.GR2674@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-18_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810190001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 05:03:50PM -0700, Joel Fernandes wrote:
> On Thu, Oct 18, 2018 at 07:46:37AM -0700, Paul E. McKenney wrote:
> [..]
> > > > > > > > ------------------------------------------------------------------------
> > > > > > > > 
> > > > > > > > commit 07921e8720907f58f82b142f2027fc56d5abdbfd
> > > > > > > > Author: Paul E. McKenney <paulmck@linux.ibm.com>
> > > > > > > > Date:   Tue Oct 16 04:12:58 2018 -0700
> > > > > > > > 
> > > > > > > >     rcu: Speed up expedited GPs when interrupting RCU reader
> > > > > > > >     
> > > > > > > >     In PREEMPT kernels, an expedited grace period might send an IPI to a
> > > > > > > >     CPU that is executing an RCU read-side critical section.  In that case,
> > > > > > > >     it would be nice if the rcu_read_unlock() directly interacted with the
> > > > > > > >     RCU core code to immediately report the quiescent state.  And this does
> > > > > > > >     happen in the case where the reader has been preempted.  But it would
> > > > > > > >     also be a nice performance optimization if immediate reporting also
> > > > > > > >     happened in the preemption-free case.
> > > > > > > >     
> > > > > > > >     This commit therefore adds an ->exp_hint field to the task_struct structure's
> > > > > > > >     ->rcu_read_unlock_special field.  The IPI handler sets this hint when
> > > > > > > >     it has interrupted an RCU read-side critical section, and this causes
> > > > > > > >     the outermost rcu_read_unlock() call to invoke rcu_read_unlock_special(),
> > > > > > > >     which, if preemption is enabled, reports the quiescent state immediately.
> > > > > > > >     If preemption is disabled, then the report is required to be deferred
> > > > > > > >     until preemption (or bottom halves or interrupts or whatever) is re-enabled.
> > > > > > > >     
> > > > > > > >     Because this is a hint, it does nothing for more complicated cases.  For
> > > > > > > >     example, if the IPI interrupts an RCU reader, but interrupts are disabled
> > > > > > > >     across the rcu_read_unlock(), but another rcu_read_lock() is executed
> > > > > > > >     before interrupts are re-enabled, the hint will already have been cleared.
> > > > > > > >     If you do crazy things like this, reporting will be deferred until some
> > > > > > > >     later RCU_SOFTIRQ handler, context switch, cond_resched(), or similar.
> > > > > > > >     
> > > > > > > >     Reported-by: Joel Fernandes <joel@joelfernandes.org>
> > > > > > > >     Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> > > > > > > > 
> > > > > > > > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > > > > > > > index 004ca21f7e80..64ce751b5fe9 100644
> > > > > > > > --- a/include/linux/sched.h
> > > > > > > > +++ b/include/linux/sched.h
> > > > > > > > @@ -571,8 +571,10 @@ union rcu_special {
> > > > > > > >  	struct {
> > > > > > > >  		u8			blocked;
> > > > > > > >  		u8			need_qs;
> > > > > > > > +		u8			exp_hint; /* Hint for performance. */
> > > > > > > > +		u8			pad; /* No garbage from compiler! */
> > > > > > > >  	} b; /* Bits. */
> > > > > > > > -	u16 s; /* Set of bits. */
> > > > > > > > +	u32 s; /* Set of bits. */
> > > > > > > >  };
> > > > > > > >  
> > > > > > > >  enum perf_event_task_context {
> > > > > > > > diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> > > > > > > > index e669ccf3751b..928fe5893a57 100644
> > > > > > > > --- a/kernel/rcu/tree_exp.h
> > > > > > > > +++ b/kernel/rcu/tree_exp.h
> > > > > > > > @@ -692,8 +692,10 @@ static void sync_rcu_exp_handler(void *unused)
> > > > > > > >  	 */
> > > > > > > >  	if (t->rcu_read_lock_nesting > 0) {
> > > > > > > >  		raw_spin_lock_irqsave_rcu_node(rnp, flags);
> > > > > > > > -		if (rnp->expmask & rdp->grpmask)
> > > > > > > > +		if (rnp->expmask & rdp->grpmask) {
> > > > > > > >  			rdp->deferred_qs = true;
> > > > > > > > +			WRITE_ONCE(t->rcu_read_unlock_special.b.exp_hint, true);
> > > > > > > > +		}
> > > > > > > >  		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> > > > > > > >  	}
> > > > > > > >  
> > > > > > > > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > > > > > > > index 8b48bb7c224c..d6286eb6e77e 100644
> > > > > > > > --- a/kernel/rcu/tree_plugin.h
> > > > > > > > +++ b/kernel/rcu/tree_plugin.h
> > > > > > > > @@ -643,8 +643,9 @@ static void rcu_read_unlock_special(struct task_struct *t)
> > > > > > > >  	local_irq_save(flags);
> > > > > > > >  	irqs_were_disabled = irqs_disabled_flags(flags);
> > > > > > > >  	if ((preempt_bh_were_disabled || irqs_were_disabled) &&
> > > > > > > > -	    t->rcu_read_unlock_special.b.blocked) {
> > > > > > > > +	    t->rcu_read_unlock_special.s) {
> > > > > > > >  		/* Need to defer quiescent state until everything is enabled. */
> > > > > > > > +		WRITE_ONCE(t->rcu_read_unlock_special.b.exp_hint, false);
> > > > > > > >  		raise_softirq_irqoff(RCU_SOFTIRQ);
> > > > > > > 
> > > > > > > Still going through this patch, but it seems to me like the fact that
> > > > > > > rcu_read_unlock_special is called means someone has requested for a grace
> > > > > > > period. Then in that case, does it not make sense to raise the softirq
> > > > > > > for processing anyway?
> > > > > > 
> > > > > > Not necessarily.  Another reason that rcu_read_unlock_special() might
> > > > > > be called is if the RCU read-side critical section had been preempted,
> > > > > > in which case there might not even be a grace period in progress.
> > > > > 
> > > > > Yes true, it was at the back of my head ;) It needs to remove itself from the
> > > > > blocked lists on the unlock. And ofcourse the preemption case is alsoo
> > > > > clearly mentioned in this function's comments. (slaps self).
> > > > 
> > > > Sometimes rcutorture reminds me of interesting RCU corner cases...  ;-)
> > > > 
> > > > > > In addition, if interrupts, bottom halves, and preemption are all enabled,
> > > > > > the code in rcu_preempt_deferred_qs_irqrestore() doesn't need to bother
> > > > > > raising softirq, as it can instead just immediately report the quiescent
> > > > > > state.
> > > > > 
> > > > > Makes sense. I will go through these code paths more today. Thank you for the
> > > > > explanations!
> > > > > 
> > > > > I think something like need_exp_qs instead of 'exp_hint' may be more
> > > > > descriptive?
> > > > 
> > > > Well, it is only a hint due to the fact that it is not preserved across
> > > > complex sequences of overlapping RCU read-side critical sections of
> > > > different types.  So if you have the following sequence:
> > > > 
> > > > 	rcu_read_lock();
> > > > 	/* Someone does synchronize_rcu_expedited(), which sets ->exp_hint. */
> > > > 	preempt_disable();
> > > > 	rcu_read_unlock(); /* Clears ->exp_hint. */
> > > > 	preempt_enable(); /* But ->exp_hint is already cleared. */
> > > > 
> > > > This is OK because there will be some later event that passes the quiescent
> > > > state to the RCU core.  This will slow down the expedited grace period,
> > > > but this case should be uncommon.  If it does turn out to be common, then
> > > > some more complex scheme can be put in place.
> > > > 
> > > > Hmmm...  This patch does need some help, doesn't it?  How about the following
> > > > to be folded into the original?
> > > > 
> > > > commit d8d996385055d4708121fa253e04b4272119f5e2
> > > > Author: Paul E. McKenney <paulmck@linux.ibm.com>
> > > > Date:   Wed Oct 17 13:32:25 2018 -0700
> > > > 
> > > >     fixup! rcu: Speed up expedited GPs when interrupting RCU reader
> > > >     
> > > >     Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> > > > 
> > > > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > > > index d6286eb6e77e..117aeb582fdc 100644
> > > > --- a/kernel/rcu/tree_plugin.h
> > > > +++ b/kernel/rcu/tree_plugin.h
> > > > @@ -650,6 +650,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
> > > >  		local_irq_restore(flags);
> > > >  		return;
> > > >  	}
> > > > +	WRITE_ONCE(t->rcu_read_unlock_special.b.exp_hint, false);
> > > >  	rcu_preempt_deferred_qs_irqrestore(t, flags);
> > > >  }
> > > >  
> > > 
> > > Sure, I believe so. I was also thinking out load about if we can avoid
> > > raising of the softirq for some cases in rcu_read_unlock_special:
> > > 
> > > For example, in rcu_read_unlock_special()
> > > 
> > > static void rcu_read_unlock_special(struct task_struct *t)
> > > {
> > > [...]
> > > 	if ((preempt_bh_were_disabled || irqs_were_disabled) &&
> > > 	    t->rcu_read_unlock_special.s) {
> > > 		/* Need to defer quiescent state until everything is enabled. */
> > > 		raise_softirq_irqoff(RCU_SOFTIRQ);
> > > 		local_irq_restore(flags);
> > > 		return;
> > > 	}
> > > 	rcu_preempt_deferred_qs_irqrestore(t, flags);
> > > }
> > > 
> > > Instead of raising the softirq, for the case where irqs are enabled, but
> > > preemption is disabled, can we not just do:
> > > 
> > > 		set_tsk_need_resched(current);
> > > 		set_preempt_need_resched();
> > > 
> > > and return? Not sure the benefits of doing that are, but it seems nice to
> > > avoid raising the softirq if possible, for benefit of real-time workloads.
> > 
> > This approach would work very well in the case when preemption or bottom
> > halves were disabled, but would not handle the case where interrupts were
> > enabled during the RCU read-side critical section, an expedited grace
> > period started (thus setting ->exp_hint), interrupts where then disabled,
> > and finally rcu_read_unlock() was invoked.  Re-enabling interrupts would
> > not cause either softirq or the scheduler to do anything, so the end of
> > the expedited grace period might be delayed for some time, for example,
> > until the next scheduling-clock interrupt.
> > 
> > But please see below.
> > 
> > > Also it seems like there is a chance the softirq might run before the
> > > preemption is reenabled anyway right?
> > 
> > Not unless the rcu_read_unlock() is invoked from within a softirq
> > handler on the one hand or within an interrupt handler that interrupted
> > a preempt-disable region of code.  Otherwise, because interrupts are
> > disabled, the raise_softirq() will wake up ksoftirqd, which cannot run
> > until both preemption and bottom halves are enabled.
> > 
> > > Also one last thing, in your patch - do we really need to test for
> > > "t->rcu_read_unlock_special.s" in rcu_read_unlock_special()? AFAICT,
> > > rcu_read_unlock_special would only be called if t->rcu_read_unlock_special.s
> > > is set in the first place so we can drop the test for that.
> > 
> > Good point!
> > 
> > How about the following?
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > static void rcu_read_unlock_special(struct task_struct *t)
> > {
> > 	unsigned long flags;
> > 	bool preempt_bh_were_disabled =
> > 			!!(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK));
> > 	bool irqs_were_disabled;
> > 
> > 	/* NMI handlers cannot block and cannot safely manipulate state. */
> > 	if (in_nmi())
> > 		return;
> > 
> > 	local_irq_save(flags);
> > 	irqs_were_disabled = irqs_disabled_flags(flags);
> > 	if (preempt_bh_were_disabled || irqs_were_disabled) {
> > 		WRITE_ONCE(t->rcu_read_unlock_special.b.exp_hint, false);
> > 		/* Need to defer quiescent state until everything is enabled. */
> > 		if (irqs_were_disabled) {
> > 			raise_softirq_irqoff(RCU_SOFTIRQ);
> > 		} else {
> > 			set_tsk_need_resched(current);
> > 			set_preempt_need_resched();
> > 		}
> 
> Looks good to me, thanks! Maybe some code comments would be nice as well.
> 
> Shouldn't we also set_tsk_need_resched for the irqs_were_disabled case, so
> that say if we are in an IRQ disabled region (local_irq_disable), then
> ksoftirqd would run as possible once IRQs are renabled?

Last I checked, local_irq_restore() didn't check for reschedules, instead
relying on IPIs and scheduling-clock interrupts to do its dirty work.
Has that changed?

> By the way, the user calling preempt_enable_no_resched would be another case
> where the expedited grace period might extend longer than needed with the
> above patch, but that seems unlikely enough to worry about :-)

I figured that whoever calls preempt_enable_no_resched() is taking the
responsibility for permitting preemption in the near future, and if they
fail to do so, they will get called on it.  Hard to hide from the latency
tracer, after all.  ;-)

							Thanx, Paul

