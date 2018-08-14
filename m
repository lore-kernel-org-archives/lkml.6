Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1034C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 21:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B41E21709
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 21:02:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B41E21709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729984AbeHNXvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 19:51:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48282 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728156AbeHNXvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 19:51:08 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7EKriK7076631
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 17:02:07 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kv68jgxeq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 17:02:07 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 14 Aug 2018 17:02:06 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 14 Aug 2018 17:02:04 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7EL23AG3342642
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Aug 2018 21:02:03 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4877BB2064;
        Tue, 14 Aug 2018 17:01:19 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16620B2067;
        Tue, 14 Aug 2018 17:01:19 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 14 Aug 2018 17:01:19 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 9B64116C3AB1; Tue, 14 Aug 2018 14:02:04 -0700 (PDT)
Date:   Tue, 14 Aug 2018 14:02:04 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        peterz@infradead.org, tj@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] Make call_srcu() available during very early boot
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180814162448.GA20414@linux.vnet.ibm.com>
 <20180814124945.5cf1753f@gandalf.local.home>
 <20180814170618.GA24813@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180814170618.GA24813@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18081421-0060-0000-0000-0000029DF171
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009545; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01073549; UDB=6.00553161; IPR=6.00853506;
 MB=3.00022719; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-14 21:02:06
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18081421-0061-0000-0000-0000462AF07F
Message-Id: <20180814210204.GA12851@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-14_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808140211
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 10:06:18AM -0700, Paul E. McKenney wrote:
> On Tue, Aug 14, 2018 at 12:49:45PM -0400, Steven Rostedt wrote:
> > On Tue, 14 Aug 2018 09:24:48 -0700
> > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> > 
> > > Event tracing is moving to SRCU in order to take advantage of the fact
> > > that SRCU may be safely used from idle and even offline CPUs.  However,
> > > event tracing can invoke call_srcu() very early in the boot process,
> > > even before workqueue_init_early() is invoked (let alone rcu_init()).
> > > Therefore, call_srcu()'s attempts to queue work fail miserably.
> > > 
> > > This commit therefore detects this situation, and refrains from attempting
> > > to queue work before rcu_init() time, but does everything else that it
> > > would have done, and in addition, adds the srcu_struct to a global list.
> > > The rcu_init() function now invokes a new srcu_init() function, which
> > > is empty if CONFIG_SRCU=n.  Otherwise, srcu_init() queues work for
> > > each srcu_struct on the list.  This all happens early enough in boot
> > > that there is but a single CPU with interrupts disabled, which allows
> > > synchronization to be dispensed with.
> > > 
> > > Of course, the queued work won't actually be invoked until after
> > > workqueue_init() is invoked, which happens shortly after the scheduler
> > > is up and running.  This means that although call_srcu() may be invoked
> > > any time after per-CPU variables have been set up, there is still a very
> > > narrow window when synchronize_srcu() won't work, and this window
> > > extends from the time that the scheduler starts until the time that
> > > workqueue_init() returns.  This can be fixed in a manner similar to
> > > the fix for synchronize_rcu_expedited() and friends, but until someone
> > > actually needs to use synchronize_srcu() during this window, this fix
> > > is added churn for no benefit.
> > > 
> > > Finally, note that Tree SRCU's new srcu_init() function invokes
> > > queue_work() rather than the queue_delayed_work() function that is invoked
> > > post-boot.  The reason is that queue_delayed_work() will (as you would
> > > expect) post a timer, and timers have not yet been initialized.  So use
> > > of queue_delayed_work() avoids the complaints about use of uninitialized
> > 
> > You mean "So use of queue_work() avoids .." ?
> 
> Indeed I do!  Fixed.
> 
> > > spinlocks that would otherwise result.  Besides, delay is in any case
> > > provide by the aforementioned fact that the queued work won't actually
> > > be invoked until after the scheduler is up and running.
> > > 
> > > Requested-by: Steven Rostedt <rostedt@goodmis.org>
> > > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > > 
> > > diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
> > > index f41d2fb09f87..2b5c0822e683 100644
> > > --- a/include/linux/srcutiny.h
> > > +++ b/include/linux/srcutiny.h
> > > @@ -36,6 +36,7 @@ struct srcu_struct {
> > >  	struct rcu_head *srcu_cb_head;	/* Pending callbacks: Head. */
> > >  	struct rcu_head **srcu_cb_tail;	/* Pending callbacks: Tail. */
> > >  	struct work_struct srcu_work;	/* For driving grace periods. */
> > > +	struct list_head srcu_boot_entry; /* Early-boot callbacks. */
> > 
> > I really don't like increasing the size of a structure for a field that
> > is hardly ever used.
> > 
> > Is there a way we could make a union, or reuse one of the other fields,
> > as we know that synchronize_srcu() can't be used yet (and if it is,
> > either warn, or just make it a nop). And when we call srcu_init() and
> > remove the srcu_struct from the list, we can then initialize whatever
> > we used as the temporary boot up list field.
> 
> I will take a look.  If nothing else, I could union it with the
> struct work_struct, since it cannot be used that early anyway.  ;-)

Not so much!!!  The problem is that the srcu_struct needs to be
initialized differently depending on whether it is used before or after
start_kernel()'s call to rcu_init().  Before, it needs to be initialized
as a list_head, after as a work_struct.  But the type of initialization
is determined not by the time of initialization but rather by the time
of first use.  So it looks like reusing work_struct's list_head makes
more sense.

> Or I could just use the work_struct that is already inside the struct
> work_struct.  Tejun, would you be OK with that?

I am creating a separate patch that eliminates the boot-time-only
->srcu_boot_entry field to allow the decisions to be made separately.

							Thanx, Paul

> For whatever it is worth, synchronize_srcu() is perfectly legal way
> early in boot, at least as early as call_srcu().  The reason is that
> until the scheduler starts, synchronize_srcu() is a no-op.
> 
> > srcu_init is called when we are still running only one CPU correct?
> 
> Yes, single CPU interrupts disabled.
> 
> > >  #ifdef CONFIG_DEBUG_LOCK_ALLOC
> > >  	struct lockdep_map dep_map;
> > >  #endif /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
> > > @@ -48,6 +49,7 @@ void srcu_drive_gp(struct work_struct *wp);
> > >  	.srcu_wq = __SWAIT_QUEUE_HEAD_INITIALIZER(name.srcu_wq),	\
> > >  	.srcu_cb_tail = &name.srcu_cb_head,				\
> > >  	.srcu_work = __WORK_INITIALIZER(name.srcu_work, srcu_drive_gp),	\
> > > +	.srcu_boot_entry = LIST_HEAD_INIT(name.srcu_boot_entry),	\
> > >  	__SRCU_DEP_MAP_INIT(name)					\
> > >  }
> > >  
> > > diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> > > index 745d4ca4dd50..86ad97111315 100644
> > > --- a/include/linux/srcutree.h
> > > +++ b/include/linux/srcutree.h
> > > @@ -94,6 +94,7 @@ struct srcu_struct {
> > >  						/*  callback for the barrier */
> > >  						/*  operation. */
> > >  	struct delayed_work work;
> > > +	struct list_head srcu_boot_entry;	/* Early-boot callbacks. */
> > >  #ifdef CONFIG_DEBUG_LOCK_ALLOC
> > >  	struct lockdep_map dep_map;
> > >  #endif /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
> > > @@ -105,12 +106,13 @@ struct srcu_struct {
> > >  #define SRCU_STATE_SCAN2	2
> > >  
> > >  #define __SRCU_STRUCT_INIT(name, pcpu_name)				\
> > > -	{								\
> > > -		.sda = &pcpu_name,					\
> > > -		.lock = __SPIN_LOCK_UNLOCKED(name.lock),		\
> > > -		.srcu_gp_seq_needed = 0 - 1,				\
> > > -		__SRCU_DEP_MAP_INIT(name)				\
> > > -	}
> > > +{									\
> > > +	.sda = &pcpu_name,						\
> > > +	.lock = __SPIN_LOCK_UNLOCKED(name.lock),			\
> > > +	.srcu_gp_seq_needed = 0 - 1,					\
> > 
> > Interesting initialization of -1. This was there before, but still
> > interesting none the less.
> 
> If I recall correctly, this subterfuge suppresses compiler complaints
> about initializing an unsigned long with a negative number.  :-/
> 
> 							Thanx, Paul
> 
> > > +	.srcu_boot_entry = LIST_HEAD_INIT(name.srcu_boot_entry),	\
> > > +	__SRCU_DEP_MAP_INIT(name)					\
> > > +}
> > >  
> > >
> > 
> > -- Steve
> > 

