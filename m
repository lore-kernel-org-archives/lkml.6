Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C8BC6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9CE720820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:03:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9CE720820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbeKBCHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 22:07:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55424 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725982AbeKBCHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 22:07:43 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA1GrxGp030851
        for <linux-kernel@vger.kernel.org>; Thu, 1 Nov 2018 13:03:53 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ng47suu09-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 13:03:52 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 1 Nov 2018 17:03:52 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 1 Nov 2018 17:03:48 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA1H3m7K1835492
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Nov 2018 17:03:48 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EDA57B2065;
        Thu,  1 Nov 2018 17:03:47 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BBA0EB205F;
        Thu,  1 Nov 2018 17:03:47 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.141])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  1 Nov 2018 17:03:47 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 16B7E16C36E4; Thu,  1 Nov 2018 10:03:48 -0700 (PDT)
Date:   Thu, 1 Nov 2018 10:03:48 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Subject: Re: [PATCH RFC kenrel/rcu] Eliminate BUG_ON() for sync.c
Reply-To: paulmck@linux.ibm.com
References: <20181022145241.GA7488@linux.ibm.com>
 <20181022152406.GA7257@redhat.com>
 <20181022155644.GG4170@linux.ibm.com>
 <20181022161439.GA8640@redhat.com>
 <20181030175539.GL4170@linux.ibm.com>
 <20181031172604.GC21207@redhat.com>
 <20181031173349.GF4170@linux.ibm.com>
 <20181101141217.GC23232@redhat.com>
 <20181101144250.GN4170@linux.ibm.com>
 <20181101154518.GE23232@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181101154518.GE23232@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18110117-0052-0000-0000-0000034E4783
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009966; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01111179; UDB=6.00575823; IPR=6.00891270;
 MB=3.00023993; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-01 17:03:51
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110117-0053-0000-0000-00005E9E8A4C
Message-Id: <20181101170348.GR4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-01_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811010144
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2018 at 04:45:19PM +0100, Oleg Nesterov wrote:
> On 11/01, Paul E. McKenney wrote:
> >
> > Any news on exactly which patch constituted the reworking of this
> > code some time back?
> 
> Again, I never sent a patch, I simply showed the new code (more than 2 years
> ago ;), see below. I need to re-read our discussiong, but iirc your and Peter's
> reviews were mostly positive.

I am glad that I didn't try to apply the various related patches I
found, then.  ;-)

> The new implementation (and the state machine) is simpler, plus the new
> __rcu_sync_enter(). It can be used instead of rcu_sync_enter_start() hack,
> and by freeze_super() which currently need 3 GP's to take 3 percpu rwsems.
> 
> Oleg.
> -------------------------------------------------------------------------------
> 
> #include <linux/rcu_sync.h>
> #include <linux/sched.h>
> 
> #ifdef CONFIG_PROVE_RCU
> #define __INIT_HELD(func)	.held = func,
> #else
> #define __INIT_HELD(func)
> #endif
> 
> static const struct {
> 	void (*call)(struct rcu_head *, void (*)(struct rcu_head *));
> 	void (*wait)(void);	// TODO: remove this, see the comment in dtor
> #ifdef CONFIG_PROVE_RCU
> 	int  (*held)(void);
> #endif
> } gp_ops[] = {
> 	[RCU_SYNC] = {
> 		.call = call_rcu,
> 		.wait = rcu_barrier,
> 		__INIT_HELD(rcu_read_lock_held)
> 	},
> 	[RCU_SCHED_SYNC] = {
> 		.call = call_rcu_sched,
> 		.wait = rcu_barrier_sched,

In my -rcu tree, these are now call_rcu and rcu_barrier, courtesy of
RCU flavor consolidation.

> 		__INIT_HELD(rcu_read_lock_sched_held)

This remains the same.

> 	},
> 	[RCU_BH_SYNC] = {
> 		.call = call_rcu_bh,
> 		.wait = rcu_barrier_bh,
> 		__INIT_HELD(rcu_read_lock_bh_held)

And same for these three.

							Thanx, Paul

> 	},
> };
> 
> #define	rss_lock	gp_wait.lock
> 
> enum { GP_IDLE = 0, GP_ENTER, GP_PASSED, GP_EXIT, GP_REPLAY };
> 
> #ifdef CONFIG_PROVE_RCU
> void rcu_sync_lockdep_assert(struct rcu_sync *rsp)
> {
> 	RCU_LOCKDEP_WARN(!gp_ops[rsp->gp_type].held(),
> 			 "suspicious rcu_sync_is_idle() usage");
> }
> #endif
> 
> void rcu_sync_init(struct rcu_sync *rsp, enum rcu_sync_type type)
> {
> 	memset(rsp, 0, sizeof(*rsp));
> 	init_waitqueue_head(&rsp->gp_wait);
> 	rsp->gp_type = type;
> }
> 
> static void rcu_sync_func(struct rcu_head *rcu);
> 
> static void rcu_sync_call(struct rcu_sync *rsp)
> {
> 	// TODO: THIS IS SUBOPTIMAL. We want to call it directly
> 	// if rcu_blocking_is_gp() == T, but it has might_sleep().
> 	gp_ops[rsp->gp_type].call(&rsp->cb_head, rcu_sync_func);
> }
> 
> static void rcu_sync_func(struct rcu_head *rcu)
> {
> 	struct rcu_sync *rsp = container_of(rcu, struct rcu_sync, cb_head);
> 	unsigned long flags;
> 
> 	BUG_ON(rsp->gp_state == GP_IDLE);
> 	BUG_ON(rsp->gp_state == GP_PASSED);
> 
> 	spin_lock_irqsave(&rsp->rss_lock, flags);
> 	if (rsp->gp_count) {
> 		/*
> 		 * We're at least a GP after the first __rcu_sync_enter().
> 		 */
> 		rsp->gp_state = GP_PASSED;
> 		wake_up_locked(&rsp->gp_wait);
> 	} else if (rsp->gp_state == GP_REPLAY) {
> 		/*
> 		 * A new rcu_sync_exit() has happened; requeue the callback
> 		 * to catch a later GP.
> 		 */
> 		rsp->gp_state = GP_EXIT;
> 		rcu_sync_call(rsp);
> 	} else {
> 		/*
> 		 * We're at least a GP after the last rcu_sync_exit();
> 		 * eveybody will now have observed the write side critical
> 		 * section. Let 'em rip!.
> 		 *
> 		 * OR. ->gp_state can be still GP_ENTER if __rcu_sync_wait()
> 		 * wasn't called after __rcu_sync_enter(), abort.
> 		 */
> 		rsp->gp_state = GP_IDLE;
> 	}
> 	spin_unlock_irqrestore(&rsp->rss_lock, flags);
> }
> 
> bool __rcu_sync_enter(struct rcu_sync *rsp)
> {
> 	int gp_count, gp_state;
> 
> 	spin_lock_irq(&rsp->rss_lock);
> 	gp_count = rsp->gp_count++;
> 	gp_state = rsp->gp_state;
> 	if (gp_state == GP_IDLE) {
> 		rsp->gp_state = GP_ENTER;
> 		rcu_sync_call(rsp);
> 	}
> 	spin_unlock_irq(&rsp->rss_lock);
> 
> 	BUG_ON(gp_count != 0 && gp_state == GP_IDLE);
> 	BUG_ON(gp_count == 0 && gp_state == GP_PASSED);
> 
> 	return gp_state < GP_PASSED;
> }
> 
> void __rcu_sync_wait(struct rcu_sync *rsp)
> {
> 	BUG_ON(rsp->gp_state == GP_IDLE);
> 	BUG_ON(rsp->gp_count == 0);
> 
> 	wait_event(rsp->gp_wait, rsp->gp_state >= GP_PASSED);
> }
> 
> void rcu_sync_enter(struct rcu_sync *rsp)
> {
> 	if (__rcu_sync_enter(rsp))
> 		__rcu_sync_wait(rsp);
> }
> 
> void rcu_sync_exit(struct rcu_sync *rsp)
> {
> 	BUG_ON(rsp->gp_state == GP_IDLE);
> 	BUG_ON(rsp->gp_count == 0);
> 
> 	spin_lock_irq(&rsp->rss_lock);
> 	if (!--rsp->gp_count) {
> 		if (rsp->gp_state == GP_PASSED) {
> 			rsp->gp_state = GP_EXIT;
> 			rcu_sync_call(rsp);
> 		} else if (rsp->gp_state == GP_EXIT) {
> 			rsp->gp_state = GP_REPLAY;
> 		}
> 	}
> 	spin_unlock_irq(&rsp->rss_lock);
> }
> 
> void rcu_sync_dtor(struct rcu_sync *rsp)
> {
> 	int gp_state;
> 
> 	BUG_ON(rsp->gp_count);
> 	BUG_ON(rsp->gp_state == GP_PASSED);
> 
> 	spin_lock_irq(&rsp->rss_lock);
> 	if (rsp->gp_state == GP_REPLAY)
> 		rsp->gp_state = GP_EXIT;
> 	gp_state = rsp->gp_state;
> 	spin_unlock_irq(&rsp->rss_lock);
> 
> 	// TODO: add another wake_up_locked() into rcu_sync_func(),
> 	// use wait_event + spin_lock_wait, remove gp_ops->wait().
> 	if (gp_state != GP_IDLE) {
> 		gp_ops[rsp->gp_type].wait();
> 		BUG_ON(rsp->gp_state != GP_IDLE);
> 	}
> }
> 
> 

