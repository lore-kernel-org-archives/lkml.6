Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBD8C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 04:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B5420862
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 04:22:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93B5420862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbeKKOJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 09:09:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57106 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727037AbeKKOJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 09:09:39 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAB4IR5D058485
        for <linux-kernel@vger.kernel.org>; Sat, 10 Nov 2018 23:22:15 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nnvrj5r6v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 10 Nov 2018 23:22:15 -0500
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 11 Nov 2018 04:22:14 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 11 Nov 2018 04:22:11 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wAB4MAxP64421908
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 11 Nov 2018 04:22:10 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 28D9CB205F;
        Sun, 11 Nov 2018 04:22:10 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E6914B2065;
        Sun, 11 Nov 2018 04:22:09 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.207.24])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 11 Nov 2018 04:22:09 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 79EC116C5D1B; Sat, 10 Nov 2018 20:22:10 -0800 (PST)
Date:   Sat, 10 Nov 2018 20:22:10 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com
Subject: Re: dyntick-idle CPU and node's qsmask
Reply-To: paulmck@linux.ibm.com
References: <20181110214659.GA96924@google.com>
 <20181110230436.GL4170@linux.ibm.com>
 <20181111030925.GA182908@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181111030925.GA182908@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18111104-0040-0000-0000-00000490567F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010024; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01115712; UDB=6.00577119; IPR=6.00895812;
 MB=3.00024106; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-11 04:22:13
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111104-0041-0000-0000-000008995EA7
Message-Id: <20181111042210.GN4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-11_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811110040
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 10, 2018 at 07:09:25PM -0800, Joel Fernandes wrote:
> On Sat, Nov 10, 2018 at 03:04:36PM -0800, Paul E. McKenney wrote:
> > On Sat, Nov 10, 2018 at 01:46:59PM -0800, Joel Fernandes wrote:
> > > Hi Paul and everyone,
> > > 
> > > I was tracing/studying the RCU code today in paul/dev branch and noticed that
> > > for dyntick-idle CPUs, the RCU GP thread is clearing the rnp->qsmask
> > > corresponding to the leaf node for the idle CPU, and reporting a QS on their
> > > behalf.
> > > 
> > > rcu_sched-10    [003]    40.008039: rcu_fqs:              rcu_sched 792 0 dti
> > > rcu_sched-10    [003]    40.008039: rcu_fqs:              rcu_sched 801 2 dti
> > > rcu_sched-10    [003]    40.008041: rcu_quiescent_state_report: rcu_sched 805 5>0 0 0 3 0
> > > 
> > > That's all good but I was wondering if we can do better for the idle CPUs if
> > > we can some how not set the qsmask of the node in the first place. Then no
> > > reporting would be needed of quiescent state is needed for idle CPUs right?
> > > And we would also not need to acquire the rnp lock I think.
> > > 
> > > At least for a single node tree RCU system, it seems that would avoid needing
> > > to acquire the lock without complications. Anyway let me know your thoughts
> > > and happy to discuss this at the hallways of the LPC as well for folks
> > > attending :)
> > 
> > We could, but that would require consulting the rcu_data structure for
> > each CPU while initializing the grace period, thus increasing the number
> > of cache misses during grace-period initialization and also shortly after
> > for any non-idle CPUs.  This seems backwards on busy systems where each
> 
> When I traced, it appears to me that rcu_data structure of a remote CPU was
> being consulted anyway by the rcu_sched thread. So it seems like such cache
> miss would happen anyway whether it is during grace-period initialization or
> during the fqs stage? I guess I'm trying to say, the consultation of remote
> CPU's rcu_data happens anyway.

Hmmm...

The rcu_gp_init() function does access an rcu_data structure, but it is
that of the current CPU, so shouldn't involve a communications cache miss,
at least not in the common case.

Or are you seeing these cross-CPU rcu_data accesses in rcu_gp_fqs() or
functions that it calls?  In that case, please see below.

> > CPU will with high probability report its own quiescent state before three
> > jiffies pass, in which case the cache misses on the rcu_data structures
> > would be wasted motion.
> 
> If all the CPUs are busy and reporting their QS themselves, then I think the
> qsmask is likely 0 so then rcu_implicit_dynticks_qs (called from
> force_qs_rnp) wouldn't be called and so there would no cache misses on
> rcu_data right?

Yes, but assuming that all CPUs report their quiescent states before
the first call to rcu_gp_fqs().  One exception is when some CPU is
looping in the kernel for many milliseconds without passing through a
quiescent state.  This is because for recent kernels, cond_resched()
is not a quiescent state until the grace period is something like 100
milliseconds old.  (For older kernels, cond_resched() was never an RCU
quiescent state unless it actually scheduled.)

Why wait 100 milliseconds?  Because otherwise the increase in
cond_resched() overhead shows up all too well, causing 0day test robot
to complain bitterly.  Besides, I would expect that in the common case,
CPUs would be executing usermode code.

Ah, did you build with NO_HZ_FULL, boot with nohz_full CPUs, and then run
CPU-bound usermode workloads on those CPUs?  Such CPUs would appear to
be idle from an RCU perspective.  But these CPUs would never touch their
rcu_data structures, so they would likely remain in the RCU grace-period
kthread's cache.  So this should work well also.  Give or take that other
work would likely eject them from the cache, but in that case they would
be capacity cache misses rather than the aforementioned communications
cache misses.  Not that this distinction matters to whoever is measuring
performance.  ;-)

> > Now, this does increase overhead on mostly idle systems, but the theory
> > is that mostly idle systems are most able to absorb this extra overhead.
> 
> Yes. Could we use rcuperf to check the impact of such change?

I would be very surprised if the overhead was large enough for rcuperf
to be able to see it.

> Anyway it was just an idea that popped up when I was going through traces :)
> Thanks for the discussion and happy to discuss further or try out anything.

Either way, I do appreciate your going through this.  People have found
RCU bugs this way, one of which involved RCU uselessly calling a particular
function twice in quick succession.  ;-)

							Thanx, Paul

