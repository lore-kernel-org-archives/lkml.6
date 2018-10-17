Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B05ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 20:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 031C020866
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 20:33:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 031C020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbeJREax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 00:30:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54064 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725798AbeJREax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 00:30:53 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9HKSg3A144695
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 16:33:28 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n6a3sd7rb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 16:33:28 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 17 Oct 2018 16:33:27 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 17 Oct 2018 16:33:24 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9HKXNe647317118
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 17 Oct 2018 20:33:23 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D4DBB2065;
        Wed, 17 Oct 2018 20:33:23 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C88C7B205F;
        Wed, 17 Oct 2018 20:33:22 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.109])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 17 Oct 2018 20:33:22 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 839D816C3AA2; Wed, 17 Oct 2018 13:33:24 -0700 (PDT)
Date:   Wed, 17 Oct 2018 13:33:24 -0700
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
References: <5151da01-343b-bb37-353e-b6652ae530f5@suse.com>
 <20181015112112.GT2674@linux.ibm.com>
 <20181015193951.GA33528@joelaf.mtv.corp.google.com>
 <20181015195426.GD2674@linux.ibm.com>
 <20181015201556.GA43575@joelaf.mtv.corp.google.com>
 <20181015210856.GE2674@linux.ibm.com>
 <20181016112611.GA27405@linux.ibm.com>
 <20181016204122.GA8176@joelaf.mtv.corp.google.com>
 <20181017161100.GP2674@linux.ibm.com>
 <20181017181505.GC107185@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017181505.GC107185@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18101720-0052-0000-0000-000003454EFC
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009893; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01104126; UDB=6.00571567; IPR=6.00884178;
 MB=3.00023799; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-17 20:33:26
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101720-0053-0000-0000-00005E72F091
Message-Id: <20181017203324.GS2674@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-16_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810170169
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 11:15:05AM -0700, Joel Fernandes wrote:
> On Wed, Oct 17, 2018 at 09:11:00AM -0700, Paul E. McKenney wrote:
> > On Tue, Oct 16, 2018 at 01:41:22PM -0700, Joel Fernandes wrote:
> > > On Tue, Oct 16, 2018 at 04:26:11AM -0700, Paul E. McKenney wrote:
> > > > On Mon, Oct 15, 2018 at 02:08:56PM -0700, Paul E. McKenney wrote:
> > > > > On Mon, Oct 15, 2018 at 01:15:56PM -0700, Joel Fernandes wrote:
> > > > > > On Mon, Oct 15, 2018 at 12:54:26PM -0700, Paul E. McKenney wrote:
> > > > > > [...]
> > > > > > > > > In any case, please don't spin for milliseconds with preemption disabled.
> > > > > > > > > The real-time guys are unlikely to be happy with you if you do this!
> > > > > > > > 
> > > > > > > > Well just to clarify, I was just running Oleg's test which did this. This
> > > > > > > > test was mentioned in the original documentation that I deleted. Ofcourse I
> > > > > > > > would not dare do such a thing in production code :-D. I guess to Oleg's
> > > > > > > > defense, he did it to very that synchronize_rcu() was not blocked on
> > > > > > > > preempt-disable sections which was a different test.
> > > > > > > 
> > > > > > > Understood!  Just pointing out that RCU's tolerating a given action does
> > > > > > > not necessarily mean that it is a good idea to take that action.  ;-)
> > > > > > 
> > > > > > Makes sense :-) thanks.
> > > > > 
> > > > > Don't worry, that won't happen again.  ;-)
> > > > > 
> > > > > > > > > > > +		pr_crit("SPIN done!\n");
> > > > > > > > > > > +		preempt_enable();
> > > > > > > > > > > +		break;
> > > > > > > > > > > +	case 777:
> > > > > > > > > > > +		pr_crit("SYNC start\n");
> > > > > > > > > > > +		synchronize_rcu();
> > > > > > > > > > > +		pr_crit("SYNC done!\n");
> > > > > > > > > > 
> > > > > > > > > > But you are using the console printing infrastructure which is rather
> > > > > > > > > > heavyweight. Try replacing pr_* calls with trace_printk so that you
> > > > > > > > > > write to the lock-free ring buffer, this will reduce the noise from the
> > > > > > > > > > heavy console printing infrastructure.
> > > > > > > > > 
> > > > > > > > > And this might be a problem as well.
> > > > > > > > 
> > > > > > > > This was not the issue (or atleast not fully the issue) since I saw the same
> > > > > > > > thing with trace_printk. It was exactly what you said - which is the
> > > > > > > > excessively long preempt disabled times.
> > > > > > > 
> > > > > > > One approach would be to apply this patch against (say) v4.18, which
> > > > > > > does not have consolidated grace periods.  You might then be able to
> > > > > > > tell if the pr_crit() calls make any difference.
> > > > > > 
> > > > > > I could do that, yeah. But since the original problem went away due to
> > > > > > disabling preempts for a short while, I will move on and continue to focus on
> > > > > > updating other parts of the documenation. Just to mention I
> > > > > > brought this up because I thought its better to do that than not to, just
> > > > > > incase there is any lurking issue with the consolidation. Sorry if that ended
> > > > > > up with me being noisy.
> > > > > 
> > > > > Not a problem, no need to apologize!
> > > > 
> > > > Besides, digging through the code did point out a reasonable optimization.
> > > > In the common case, this would buy 100s of microseconds rather than
> > > > milliseconds, but it seems simple enough to be worthwhile.  Thoughts?
> > > 
> > > Cool, thanks. One comment below:
> > > 
> > > > ------------------------------------------------------------------------
> > > > 
> > > > commit 07921e8720907f58f82b142f2027fc56d5abdbfd
> > > > Author: Paul E. McKenney <paulmck@linux.ibm.com>
> > > > Date:   Tue Oct 16 04:12:58 2018 -0700
> > > > 
> > > >     rcu: Speed up expedited GPs when interrupting RCU reader
> > > >     
> > > >     In PREEMPT kernels, an expedited grace period might send an IPI to a
> > > >     CPU that is executing an RCU read-side critical section.  In that case,
> > > >     it would be nice if the rcu_read_unlock() directly interacted with the
> > > >     RCU core code to immediately report the quiescent state.  And this does
> > > >     happen in the case where the reader has been preempted.  But it would
> > > >     also be a nice performance optimization if immediate reporting also
> > > >     happened in the preemption-free case.
> > > >     
> > > >     This commit therefore adds an ->exp_hint field to the task_struct structure's
> > > >     ->rcu_read_unlock_special field.  The IPI handler sets this hint when
> > > >     it has interrupted an RCU read-side critical section, and this causes
> > > >     the outermost rcu_read_unlock() call to invoke rcu_read_unlock_special(),
> > > >     which, if preemption is enabled, reports the quiescent state immediately.
> > > >     If preemption is disabled, then the report is required to be deferred
> > > >     until preemption (or bottom halves or interrupts or whatever) is re-enabled.
> > > >     
> > > >     Because this is a hint, it does nothing for more complicated cases.  For
> > > >     example, if the IPI interrupts an RCU reader, but interrupts are disabled
> > > >     across the rcu_read_unlock(), but another rcu_read_lock() is executed
> > > >     before interrupts are re-enabled, the hint will already have been cleared.
> > > >     If you do crazy things like this, reporting will be deferred until some
> > > >     later RCU_SOFTIRQ handler, context switch, cond_resched(), or similar.
> > > >     
> > > >     Reported-by: Joel Fernandes <joel@joelfernandes.org>
> > > >     Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> > > > 
> > > > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > > > index 004ca21f7e80..64ce751b5fe9 100644
> > > > --- a/include/linux/sched.h
> > > > +++ b/include/linux/sched.h
> > > > @@ -571,8 +571,10 @@ union rcu_special {
> > > >  	struct {
> > > >  		u8			blocked;
> > > >  		u8			need_qs;
> > > > +		u8			exp_hint; /* Hint for performance. */
> > > > +		u8			pad; /* No garbage from compiler! */
> > > >  	} b; /* Bits. */
> > > > -	u16 s; /* Set of bits. */
> > > > +	u32 s; /* Set of bits. */
> > > >  };
> > > >  
> > > >  enum perf_event_task_context {
> > > > diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> > > > index e669ccf3751b..928fe5893a57 100644
> > > > --- a/kernel/rcu/tree_exp.h
> > > > +++ b/kernel/rcu/tree_exp.h
> > > > @@ -692,8 +692,10 @@ static void sync_rcu_exp_handler(void *unused)
> > > >  	 */
> > > >  	if (t->rcu_read_lock_nesting > 0) {
> > > >  		raw_spin_lock_irqsave_rcu_node(rnp, flags);
> > > > -		if (rnp->expmask & rdp->grpmask)
> > > > +		if (rnp->expmask & rdp->grpmask) {
> > > >  			rdp->deferred_qs = true;
> > > > +			WRITE_ONCE(t->rcu_read_unlock_special.b.exp_hint, true);
> > > > +		}
> > > >  		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> > > >  	}
> > > >  
> > > > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > > > index 8b48bb7c224c..d6286eb6e77e 100644
> > > > --- a/kernel/rcu/tree_plugin.h
> > > > +++ b/kernel/rcu/tree_plugin.h
> > > > @@ -643,8 +643,9 @@ static void rcu_read_unlock_special(struct task_struct *t)
> > > >  	local_irq_save(flags);
> > > >  	irqs_were_disabled = irqs_disabled_flags(flags);
> > > >  	if ((preempt_bh_were_disabled || irqs_were_disabled) &&
> > > > -	    t->rcu_read_unlock_special.b.blocked) {
> > > > +	    t->rcu_read_unlock_special.s) {
> > > >  		/* Need to defer quiescent state until everything is enabled. */
> > > > +		WRITE_ONCE(t->rcu_read_unlock_special.b.exp_hint, false);
> > > >  		raise_softirq_irqoff(RCU_SOFTIRQ);
> > > 
> > > Still going through this patch, but it seems to me like the fact that
> > > rcu_read_unlock_special is called means someone has requested for a grace
> > > period. Then in that case, does it not make sense to raise the softirq
> > > for processing anyway?
> > 
> > Not necessarily.  Another reason that rcu_read_unlock_special() might
> > be called is if the RCU read-side critical section had been preempted,
> > in which case there might not even be a grace period in progress.
> 
> Yes true, it was at the back of my head ;) It needs to remove itself from the
> blocked lists on the unlock. And ofcourse the preemption case is alsoo
> clearly mentioned in this function's comments. (slaps self).

Sometimes rcutorture reminds me of interesting RCU corner cases...  ;-)

> > In addition, if interrupts, bottom halves, and preemption are all enabled,
> > the code in rcu_preempt_deferred_qs_irqrestore() doesn't need to bother
> > raising softirq, as it can instead just immediately report the quiescent
> > state.
> 
> Makes sense. I will go through these code paths more today. Thank you for the
> explanations!
> 
> I think something like need_exp_qs instead of 'exp_hint' may be more
> descriptive?

Well, it is only a hint due to the fact that it is not preserved across
complex sequences of overlapping RCU read-side critical sections of
different types.  So if you have the following sequence:

	rcu_read_lock();
	/* Someone does synchronize_rcu_expedited(), which sets ->exp_hint. */
	preempt_disable();
	rcu_read_unlock(); /* Clears ->exp_hint. */
	preempt_enable(); /* But ->exp_hint is already cleared. */

This is OK because there will be some later event that passes the quiescent
state to the RCU core.  This will slow down the expedited grace period,
but this case should be uncommon.  If it does turn out to be common, then
some more complex scheme can be put in place.

Hmmm...  This patch does need some help, doesn't it?  How about the following
to be folded into the original?

							Thanx, Paul

> Otherwise,
> Reviewed-by: Joel Fernandes <joel@joelfernandes.org>
> 
> thanks,
> 
>  - Joel

------------------------------------------------------------------------

commit d8d996385055d4708121fa253e04b4272119f5e2
Author: Paul E. McKenney <paulmck@linux.ibm.com>
Date:   Wed Oct 17 13:32:25 2018 -0700

    fixup! rcu: Speed up expedited GPs when interrupting RCU reader
    
    Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index d6286eb6e77e..117aeb582fdc 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -650,6 +650,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
 		local_irq_restore(flags);
 		return;
 	}
+	WRITE_ONCE(t->rcu_read_unlock_special.b.exp_hint, false);
 	rcu_preempt_deferred_qs_irqrestore(t, flags);
 }
 

