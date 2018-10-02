Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04325C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADD202089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:04:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADD202089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbeJBQqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 12:46:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36584 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726393AbeJBQqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 12:46:35 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w92A3quD002472
        for <linux-kernel@vger.kernel.org>; Tue, 2 Oct 2018 06:04:04 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mv10huwqg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 06:04:03 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 2 Oct 2018 06:04:01 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 2 Oct 2018 06:03:57 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w92A3uXe60555360
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 2 Oct 2018 10:03:56 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 00C5EB206E;
        Tue,  2 Oct 2018 06:02:08 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B242FB2065;
        Tue,  2 Oct 2018 06:02:08 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.185.184])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  2 Oct 2018 06:02:08 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 4D83116C13CC; Tue,  2 Oct 2018 03:03:56 -0700 (PDT)
Date:   Tue, 2 Oct 2018 03:03:56 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, efault@gmx.de, byungchul.park@lge.com,
        joel@joelfernandes.org, mhillenb@amazon.de, dwmw2@infradead.org,
        peterz@infradead.org
Subject: Re: [GIT PULL rcu/next] RCU commits for 4.20/5.0
Reply-To: paulmck@linux.ibm.com
References: <20180926182159.GA26116@linux.ibm.com>
 <20181002082429.GA69893@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002082429.GA69893@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18100210-0072-0000-0000-000003ADCE75
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009808; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01096730; UDB=6.00567124; IPR=6.00876773;
 MB=3.00023585; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-02 10:04:00
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100210-0073-0000-0000-0000499DA1FF
Message-Id: <20181002100356.GX4222@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-02_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810020101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 10:24:29AM +0200, Ingo Molnar wrote:
> 
> * Paul E. McKenney <paulmck@linux.ibm.com> wrote:
> 
> > Hello, Ingo,
> > 
> > This pull request contains the following changes:
> > 
> > 1.	Documentation updates, including some good-eye catches from
> > 	Joel Fernandes.
> > 
> > 	http://lkml.kernel.org/r/20180829211637.GA20980@linux.vnet.ibm.com
> > 
> > 2.	SRCU updates, most notably changes enabling call_srcu() to be
> > 	invoked very early in the boot sequence.
> > 
> > 	http://lkml.kernel.org/r/20180829212036.GA22033@linux.vnet.ibm.com
> > 
> > 3.	Torture-test updates, including some preliminary work towards
> > 	making rcutorture better able to find problems that result in
> > 	insufficient grace-period forward progress.
> > 
> > 	http://lkml.kernel.org/r/20180829214722.GA23411@linux.vnet.ibm.com
> > 
> > 4.	Consolidate the RCU-bh, RCU-preempt, and RCU-sched flavors into
> > 	a single flavor similar to RCU-sched in !PREEMPT kernels and 
> > 	into a single flavor similar to RCU-preempt (but also waiting
> > 	on preempt-disabled sequences of code) in PREEMPT kernels.  This
> > 	branch also includes a refactoring of rcu_{nmi,irq}_{enter,exit}()
> > 	from Byungchul Park.
> > 
> > 	http://lkml.kernel.org/r/20180829222021.GA29944@linux.vnet.ibm.com
> > 
> > 5.	Now that there is only one RCU flavor in any given running kernel,
> > 	the many "rsp" pointers are no longer required, and this cleanup
> > 	series removes them.
> > 
> > 	http://lkml.kernel.org/r/20180829223830.GA1800@linux.vnet.ibm.com
> > 
> > 6.	This branch carries out additional cleanups made possible by
> > 	the RCU flavor consolidation, including inlining how-trivial
> > 	functions, updating comments and definitions, and removing
> > 	now-unneeded rcutorture scenarios.
> > 
> > 	http://lkml.kernel.org/r/20180829225340.GA7019@linux.vnet.ibm.com
> > 
> > 7.	Initial changes to RCU to better promote forward progress of
> > 	grace periods, including fixing a bug found by Marius Hillenbrand
> > 	and David Woodhouse, with the fix suggested by Peter Zijlstra.
> > 
> > 	http://lkml.kernel.org/r/20180829230035.GA7751@linux.vnet.ibm.com
> > 
> > 8.	Now that there is only one flavor of RCU in any running kernel,
> > 	there is also only on rcu_data structure per CPU.  This means
> > 	that the rcu_dynticks structure can be merged into the rcu_data
> > 	structure, a task taken on by this branch.  This branch also
> > 	contains a -rt-related fix from Mike Galbraith.
> > 
> > 	http://lkml.kernel.org/r/20180829230715.GA9431@linux.vnet.ibm.com
> > 
> > Once again, the layout of this pull request is unusual due to the large
> > footprint of the commits in #4-#8 above.  These five branches are therefore
> > stacked on top of each other instead of my usual practice of laying them
> > out in parallel.
> > 
> > This pull request decreases the size of RCU by more than 450 lines,
> > offsetting the increase of the v4.19 merge window.  I expect a further
> > decrease due to additional outside-of-RCU cleanups, though this will be
> > offset by additional forward-progress testing and fixes in response to
> > Marius's and David's location of a forward-progress bug that escaped to
> > the field -- rcutorture should have located that bug, after all.
> > 
> > All of these changes have been subjected to 0day Test Robot and -next
> > testing, and are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git for-mingo
> > 
> > for you to fetch changes up to b56ada120921fbb0a4fb2a5bee163717182e7e9e:
> > 
> >   Merge branches 'doc.2018.08.30a', 'dynticks.2018.08.30b', 'srcu.2018.08.30b' and 'torture.2018.08.29a' into HEAD (2018-08-30 16:12:53 -0700)
> > 
> > ----------------------------------------------------------------
> > Byungchul Park (1):
> >       rcu: Refactor rcu_{nmi,irq}_{enter,exit}()
> > 
> > Joel Fernandes (Google) (2):
> >       doc: Fix broken RCU-requirements link to LKML archive
> >       doc: Improve rcu_dynticks::dynticks documentation
> > 
> > Mike Galbraith (1):
> >       rcu: Convert rcu_state.ofl_lock to raw_spinlock_t
> > 
> > Paul E. McKenney (137):
> >       doc: Add design documentation on interruption of NMI handlers
> >       torture: Stop overwriting Make.out file with obsolete version
> >       rcutorture: Force occasional reader waits
> >       rcutorture: Warn on bad torture type for built-in tests
> >       rcuperf: Warn on bad perf type for built-in tests
> >       rcutorture: Remove TREE06 and TREE08 from the default test list
> >       rcutorture: Add forward-progress tests for RCU grace periods
> >       rcutorture: Also use GP sequence to judge forward progress
> >       rcutorture: Avoid no-test complaint if too few forward-progress tries
> >       rcutorture: Vary forward-progress test interval
> >       rcutorture: Add self-propagating callback to forward-progress testing
> >       rcutorture: Increase rcu_read_delay() longdelay_ms
> >       rcutorture: Limit reader duration if irq or bh disabled
> >       rcutorture: Reduce priority of forward-progress testing
> >       rcutorture: Adjust number of reader kthreads per CPU-hotplug operations
> >       rcutorture: Print forward-progress test interval on error
> >       rcutorture: Check GP completion at stutter end
> >       rcutorture: Maintain self-propagating CB only during forward-progress test
> >       doc: Update removal of RCU-bh/sched update machinery
> >       doc: Fix broken HTML directive
> >       rcu: Defer reporting RCU-preempt quiescent states when disabled
> >       rcutorture: Test extended "rcu" read-side critical sections
> >       rcu: Allow processing deferred QSes for exiting RCU-preempt readers
> >       rcu: Remove now-unused ->b.exp_need_qs field from the rcu_special union
> >       rcu: Add warning to detect half-interrupts
> >       rcu: Apply RCU-bh QSes to RCU-sched and RCU-preempt when safe
> >       rcu: Report expedited grace periods at context-switch time
> >       rcu: Define RCU-bh update API in terms of RCU
> >       rcu: Update comments and help text for no more RCU-bh updaters
> >       rcu: Drop "wake" parameter from rcu_report_exp_rdp()
> >       rcu: Fix typo in rcu_get_gp_kthreads_prio() header comment
> >       rcu: Define RCU-sched API in terms of RCU for Tree RCU PREEMPT builds
> >       rcu: Express Tiny RCU updates in terms of RCU rather than RCU-sched
> >       rcu: Remove RCU_STATE_INITIALIZER()
> >       rcu: Eliminate rcu_state structure's ->call field
> >       rcu: Remove rcu_state structure's ->rda field
> >       rcu: Remove rcu_state_p pointer to default rcu_state structure
> >       rcu: Remove rcu_data_p pointer to default rcu_data structure
> >       rcu: Remove rsp parameter from rcu_report_qs_rnp()
> >       rcu: Remove rsp parameter from rcu_report_qs_rsp()
> >       rcu: Remove rsp parameter from rcu_report_unblock_qs_rnp()
> >       rcu: Remove rsp parameter from rcu_report_qs_rdp()
> >       rcu: Remove rsp parameter from rcu_gp_in_progress()
> >       rcu: Remove rsp parameter from rcu_get_root()
> >       rcu: Remove rsp parameter from record_gp_stall_check_time()
> >       rcu: Remove rsp parameter from rcu_check_gp_kthread_starvation()
> >       rcu: Remove rsp parameter from rcu_dump_cpu_stacks()
> >       rcu: Remove rsp parameter from rcu_stall_kick_kthreads()
> >       rcu: Remove rsp parameter from print_other_cpu_stall()
> >       rcu: Remove rsp parameter from print_cpu_stall()
> >       rcu: Remove rsp parameter from check_cpu_stall()
> >       rcu: Remove rsp parameter from rcu_future_gp_cleanup()
> >       rcu: Remove rsp parameter from rcu_gp_kthread_wake()
> >       rcu: Remove rsp parameter from rcu_accelerate_cbs()
> >       rcu: Remove rsp parameter from rcu_accelerate_cbs_unlocked()
> >       rcu: Remove rsp parameter from rcu_advance_cbs()
> >       rcu: Remove rsp parameter from __note_gp_changes()
> >       rcu: Remove rsp parameter from note_gp_changes()
> >       rcu: Remove rsp parameter from rcu_gp_slow()
> >       rcu: Remove rsp parameter from rcu_gp_kthread() and friends
> >       rcu: Remove rsp parameter from rcu_check_quiescent_state()
> >       rcu: Remove rsp parameter from CPU hotplug functions
> >       rcu: Remove rsp parameter from rcu_do_batch()
> >       rcu: Remove rsp parameter from force-quiescent-state functions
> >       rcu: Remove rsp parameter from rcu_check_gp_start_stall()
> >       rcu: Remove rsp parameter from __rcu_process_callbacks()
> >       rcu: Remove rsp parameter from __call_rcu() and friend
> >       rcu: Remove rsp parameter from __rcu_pending()
> >       rcu: Remove rsp parameter from _rcu_barrier() and friends
> >       rcu: Remove rsp parameter from rcu_boot_init_percpu_data() and friends
> >       rcu: Remove rsp parameter from rcu_init_one() and friends
> >       rcu: Remove rsp parameter from rcu_print_detail_task_stall()
> >       rcu: Remove rsp parameter from dump_blkd_tasks() and friend
> >       rcu: Remove rsp parameter from rcu_spawn_one_boost_kthread()
> >       rcu: Remove rsp parameter from print_cpu_stall_info()
> >       rcu: Remove rsp parameter from no-CBs CPU functions
> >       rcu: Remove rsp parameter from expedited grace-period functions
> >       rcu: Remove rsp parameter from rcu_node tree accessor macros
> >       rcu: Remove rcu_data structure's ->rsp field
> >       rcu: Remove last non-flavor-traversal rsp local variable from tree_plugin.h
> >       rcu: Remove for_each_rcu_flavor() flavor-traversal macro
> >       rcu: Simplify rcutorture_get_gp_data()
> >       rcu: Restructure rcu_check_gp_kthread_starvation()
> >       rcu: Eliminate stall-warning use of rsp
> >       rcu: Eliminate grace-period management code use of rsp
> >       rcu: Eliminate callback-invocation/invocation use of rsp
> >       rcu: Eliminate quiescent-state and grace-period-nonstart use of rsp
> >       rcu: Eliminate RCU-barrier use of rsp
> >       rcu: Eliminate initialization-time use of rsp
> >       rcu: Fix typo in force_qs_rnp()'s parameter's parameter
> >       rcu: Inline increment_cpu_stall_ticks() into its sole caller
> >       rcu: Pull rcu_gp_kthread() FQS loop into separate function
> >       rcu: Consolidate RCU-bh update-side function definitions
> >       rcu: Consolidate RCU-sched update-side function definitions
> >       rcutorture: Add RCU-bh and RCU-sched support for extended readers
> >       rcu: Stop testing RCU-bh and RCU-sched
> >       rcutorture: Remove the "rcu_bh" and "sched" torture types
> >       rcuperf: Remove the "rcu_bh" and "sched" torture types
> >       rcu: Remove now-unused rcutorture APIs
> >       rcu: Clean up flavor-related definitions and comments in rcupdate.h
> >       rcu: Clean up flavor-related definitions and comments in rculist.h
> >       rcu: Clean up flavor-related definitions and comments in rcupdate_wait.h
> >       rcu: Clean up flavor-related definitions and comments in Kconfig
> >       rcu: Clean up flavor-related definitions and comments in rcu.h
> >       rcu: Clean up flavor-related definitions and comments in rcutorture.c
> >       rcu: Clean up flavor-related definitions and comments in srcutree.h
> >       rcu: Clean up flavor-related definitions and comments in tiny.c
> >       rcu: Clean up flavor-related definitions and comments in tree.c
> >       rcu: Clean up flavor-related definitions and comments in tree_exp.h
> >       rcu: Clean up flavor-related definitions and comments in tree_plugin.h
> >       rcu: Clean up flavor-related definitions and comments in update.c
> >       rcu: Remove !PREEMPT code from rcu_note_voluntary_context_switch()
> >       rcu: Define rcu_all_qs() only in !PREEMPT builds
> >       rcu: Inline _rcu_barrier() into its sole remaining caller
> >       rcu: Make need_resched() respond to urgent RCU-QS needs
> >       rcu: Provide improved interrupt-from-idle check in rcu_check_callbacks()
> >       rcutorture: Dump reader protection sequence if failures or close calls
> >       rcu: Motivate Tiny RCU forward progress
> >       rcu: Eliminate ->rcu_qs_ctr from the rcu_dynticks structure
> >       rcu: Provide functions for determining if call_rcu() has been invoked
> >       rcu: Compute jiffies_till_sched_qs from other kernel parameters
> >       rcu: More aggressively enlist scheduler aid for nohz_full CPUs
> >       rcu: Avoid resched_cpu() when rescheduling the current CPU
> >       rcu: Convert "1UL << x" to "BIT(x)"
> >       rcu: Remove unused rcu_dynticks_snap() from Tiny RCU
> >       rcu: Merge rcu_dynticks structure into rcu_data structure
> >       rcu: Switch ->tick_nohz_enabled_snap to rcu_data structure
> >       rcu: Switch last accelerate/advance to rcu_data structure
> >       rcu: Switch lazy counts to rcu_data structure
> >       rcu: Switch urgent quiescent-state requests to rcu_data structure
> >       rcu: Switch dyntick nesting counters to rcu_data structure
> >       rcu: Switch ->dynticks to rcu_data structure, remove rcu_dynticks
> >       rcu: Remove obsolete ->dynticks_fqs and ->cond_resched_completed
> >       srcu: Make call_srcu() available during very early boot
> >       rcutorture: Test early boot call_srcu()
> >       srcu: Make early-boot call_srcu() reuse workqueue lists
> >       Merge branches 'doc.2018.08.30a', 'dynticks.2018.08.30b', 'srcu.2018.08.30b' and 'torture.2018.08.29a' into HEAD
> > 
> >  .../Design/Data-Structures/Data-Structures.html    |   31 +-
> >  .../Expedited-Grace-Periods.html                   |    9 +-
> >  .../RCU/Design/Requirements/Requirements.html      |  214 +-
> >  Documentation/RCU/stallwarn.txt                    |   13 +-
> >  Documentation/RCU/whatisRCU.txt                    |    3 +-
> >  Documentation/admin-guide/kernel-parameters.txt    |   31 +-
> >  Documentation/kernel-per-CPU-kthreads.txt          |    2 +-
> >  include/linux/rculist.h                            |   32 +-
> >  include/linux/rcupdate.h                           |  154 +-
> >  include/linux/rcupdate_wait.h                      |   14 +-
> >  include/linux/rcutiny.h                            |   53 +-
> >  include/linux/rcutree.h                            |   31 +-
> >  include/linux/sched.h                              |    6 +-
> >  include/linux/srcutree.h                           |   13 +-
> >  include/linux/torture.h                            |    2 +-
> >  include/trace/events/rcu.h                         |   25 +-
> >  kernel/rcu/Kconfig                                 |   14 +-
> >  kernel/rcu/rcu.h                                   |   67 +-
> >  kernel/rcu/rcuperf.c                               |   66 +-
> >  kernel/rcu/rcutorture.c                            |  397 ++--
> >  kernel/rcu/srcutiny.c                              |   29 +-
> >  kernel/rcu/srcutree.c                              |   31 +-
> >  kernel/rcu/tiny.c                                  |  154 +-
> >  kernel/rcu/tree.c                                  | 2213 ++++++++------------
> >  kernel/rcu/tree.h                                  |  132 +-
> >  kernel/rcu/tree_exp.h                              |  426 ++--
> >  kernel/rcu/tree_plugin.h                           |  790 +++----
> >  kernel/rcu/update.c                                |   70 +-
> >  kernel/softirq.c                                   |    3 +-
> >  kernel/torture.c                                   |    3 +-
> >  .../selftests/rcutorture/bin/kvm-test-1-run.sh     |    1 -
> >  .../selftests/rcutorture/configs/rcu/CFLIST        |    2 -
> >  .../selftests/rcutorture/configs/rcu/SRCU-P.boot   |    1 +
> >  .../selftests/rcutorture/configs/rcu/SRCU-u.boot   |    1 +
> >  .../selftests/rcutorture/configs/rcu/TINY02.boot   |    2 -
> >  .../selftests/rcutorture/configs/rcu/TREE01.boot   |    2 +-
> >  .../selftests/rcutorture/configs/rcu/TREE04.boot   |    2 +-
> >  .../selftests/rcutorture/configs/rcu/TREE05.boot   |    3 +-
> >  .../selftests/rcutorture/configs/rcu/TREE06.boot   |    2 -
> >  .../selftests/rcutorture/configs/rcu/TREE08.boot   |    2 -
> >  40 files changed, 2294 insertions(+), 2752 deletions(-)
> 
> Pulled into tip:core/rcu, thanks a lot Paul!
> 
> The code and complexity reduction from the consolidation of the RCU models is pretty 
> impressive IMO! :-)

Glad you like it!  ;-)

Which reminds me...

If you are running rcutorture in -tip on NO_HZ_FULL kernel with RCU
callback offloading enabled, you are not extremely excited about
getting splats from rcutorture's new forward-progress testing,
I reccommend that you add "rcutorture.fwd_progress=0" to your kernel
boot parameters.  I added forward-progress testing because of people
finding a forward-progress issue in real-life testing.  (The fix to that
specific issue is included and called out in #7 above.)

							Thanx, Paul

