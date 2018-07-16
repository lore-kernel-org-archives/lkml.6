Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7589ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D5F20870
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:49:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74D5F20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbeGPSRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 14:17:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52082 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727797AbeGPSRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 14:17:39 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6GHjfaH037493
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 13:49:07 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k8vpb1ctc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 13:49:07 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 16 Jul 2018 13:49:06 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 16 Jul 2018 13:49:03 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6GHn39t2687300
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Jul 2018 17:49:03 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75500B206B;
        Mon, 16 Jul 2018 13:48:55 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38872B2065;
        Mon, 16 Jul 2018 13:48:55 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 16 Jul 2018 13:48:55 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 8292A16C370B; Mon, 16 Jul 2018 10:51:25 -0700 (PDT)
Date:   Mon, 16 Jul 2018 10:51:25 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, boqun.feng@gmail.com,
        byungchul.park@lge.com, andrea.parri@amarulasolutions.com,
        arnd@arndb.de, joe@perches.com, joel@joelfernandes.org,
        mchehab@kernel.org, neilb@suse.com, sfr@canb.auug.org.au
Subject: [GIT PULL rcu/next] RCU commits for 4.19
Reply-To: paulmck@linux.vnet.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18071617-0064-0000-0000-0000032B29B7
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009375; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01061725; UDB=6.00545092; IPR=6.00839629;
 MB=3.00022159; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-16 17:49:06
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071617-0065-0000-0000-000039F62A6F
Message-Id: <20180716175125.GA4287@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-16_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807160202
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Ingo!

This pull request contains the following changes:

1.	An optimization and a fix for RCU expedited grace periods, with
	the fix being from Boqun Feng.

	http://lkml.kernel.org/r/20180625224308.GA10064@linux.vnet.ibm.com

2.	Miscellaneous fixes, including a lockdep-annotation fix from
	Boqun Feng.

	http://lkml.kernel.org/r/20180625230410.GA13250@linux.vnet.ibm.com

3.	SRCU updates.

	http://lkml.kernel.org/r/20180625224734.GA10860@linux.vnet.ibm.com

4.	Updates to rcutorture and associated scripting.

	http://lkml.kernel.org/r/20180625225735.GA11793@linux.vnet.ibm.com

5.	Introduce grace-period sequence numbers to the RCU-bh, RCU-preempt,
	and RCU-sched flavors, replacing the old ->gpnum and ->completed
	pair of fields.  This change allows lockless code to obtain the
	complete grace-period state with a single READ_ONCE(), which is
	needed to maintain tolerable lock contention during the upcoming
	consolidation of the three RCU flavors.  Note that grace-period
	sequence numbers are already used by rcu_barrier(), expedited
	RCU grace periods, and SRCU, and are thus already heavily used
	and well-tested.  Joel Fernandes contributed a number of excellent
	fixes and improvements.

	http://lkml.kernel.org/r/20180626000841.GA15696@linux.vnet.ibm.com

6.	Clean up some grace-period-reporting loose ends, including
	improving the handling of quiescent states from offline CPUs
	and fixing some false-positive WARN_ON_ONCE() invocations.
	(Strictly speaking, the WARN_ON_ONCE() invocations were quite
	correct, but their invariants were (harmlessly) violated by the
	earlier sloppy handling of quiescent states from offline CPUs.)
	In addition, improve grace-period forward-progress guarantees so
	as to allow removal of fail-safe checks that required otherwise
	needless lock acquisitions.  Finally, add more diagnostics to
	help debug the upcoming consolidation of the RCU-bh, RCU-preempt,
	and RCU-sched flavors.

	http://lkml.kernel.org/r/20180626002052.GA24146@linux.vnet.ibm.com

7.	Additional miscellaneous fixes, including those contributed by
	Byungchul Park, Mauro Carvalho Chehab, Joe Perches, Joel Fernandes,
	Steven Rostedt, Andrea Parri, and Neil Brown.

	http://lkml.kernel.org/r/20180626003448.GA26209@linux.vnet.ibm.com

8.	Additional torture-test changes, including several contributed by
	Arnd Bergmann and Joel Fernandes.

	http://lkml.kernel.org/r/20180626005205.GA28179@linux.vnet.ibm.com

The layout of this pull request is unusual due to the large footprint
of the commits in #5 and #6.  Therefore #1-#4 are branches on top of
v4.18-rc1, #5 and #6 are stacked on top of each other based off of the
merge point for #1-#4, and #7 and #8 are branches on top of #6.

Although I merged this series with v4.18-rc4 without conflicts and tested
the results, Stephen Rothwell has reported a couple of conflicts with
this series in the course of his -next integration-testing efforts and
has provided the following resolutions:

http://lkml.kernel.org/r/20180514134636.61831bcc@canb.auug.org.au
http://lkml.kernel.org/r/20180622122717.5f475829@canb.auug.org.au

Both of these resolutions look good to me.

This pull request increases the size of RCU by not quite 500 lines.
Of this, about 200 is due to adding test code to rcutorture in
order to adequately test the consolidated RCU-bh, RCU-preempt, and
RCU-sched flavors.  The purpose of adding this test code early is to
test it against RCU-sched, which happens to already support compound RCU
read-side critical sections via rcu_read_lock_sched(), preempt_disable(),
local_bh_disable(), and local_irq_save().  The remainder are primarily
due to the addition of diagnostics and the fixing of quiescent-state and
grace-period reporting.  This size increase is temporary: The overall
effect of this set of cleanups, the consolidation of the three RCU
flavors, and additional cleanups will be to -decrease- RCU's line count
by a couple of hundred lines.

All of these changes have been subjected to 0day Test Robot and -next
testing, and are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git for-mingo

for you to fetch changes up to 18952651dae8efcc6d565c97f8fe5629b399cb3e:

  Merge branches 'fixes1.2018.07.12b' and 'torture1.2018.07.12b' into HEAD (2018-07-12 15:42:41 -0700)

----------------------------------------------------------------
Andrea Parri (1):
      doc: Update synchronize_rcu() definition in whatisRCU.txt

Arnd Bergmann (1):
      rcutorture: Use monotonic timestamp for stall detection

Boqun Feng (2):
      rcu: Use the proper lockdep annotation in dump_blkd_tasks()
      rcu: Make expedited GPs handle CPU 0 being offline

Byungchul Park (2):
      rcu: Improve rcu_note_voluntary_context_switch() reporting
      rcu: Check the range of jiffies_till_{first,next}_fqs when setting them

Joe Perches (1):
      rcu: Use pr_fmt to prefix "rcu: " to logging output

Joel Fernandes (1):
      rcu: Rename the grace-period-request variables and parameters

Joel Fernandes (Google) (10):
      rcu: Produce last "CleanupMore" trace only if late-breaking request
      rcu: Fix cpustart tracepoint gp_seq number
      rcu: Use better variable names in funnel locking loop
      rcu: Identify grace period is in progress as we advance up the tree
      rcu: Add comment documenting how rcu_seq_snap works
      rcu: Assign higher prio to RCU threads if rcutorture is built-in
      rcutorture: Disable RT throttling for boost tests
      rcutorture: Make boost test more robust
      rcutorture: Add support to detect if boost kthread prio is too low
      rcutorture: Fix rcu_barrier successes counter

Mauro Carvalho Chehab (1):
      rcu: rcupdate.h: Get rid of Sphinx warnings at rcu_pointer_handoff()

NeilBrown (1):
      rculist: Improve documentation for list_for_each_entry_from_rcu()

Paul E. McKenney (98):
      rcu: Make expedited grace period use direct call on last leaf
      srcu: Fix typos in __call_srcu() header comment
      srcu: Document that srcu_funnel_gp_start() implies srcu_funnel_exp_start()
      srcu: Add address of first callback to rcutorture output
      srcu: Introduce srcu_read_{un,}lock_notrace()
      torture: Use a single build directory for torture scenarios
      rcutorture: Remove obsolete TREE08-T.boot file
      rcutorture: Make kvm-find-errors.sh find close calls
      torture: Make online/offline messages appear only for verbose=2
      torture: Keep old-school dmesg format
      rcu: Add debugging info to assertion
      rcu: Exclude near-simultaneous RCU CPU stall warnings
      rcu: Diagnostics for grace-period startup hangs
      rcu: Make rcu_gp_cleanup() write only once to ->gp_flags
      Merge branches 'expedited.2018.07.12a', 'fixes.2018.07.12a', 'srcu.2018.06.25b' and 'torture.2018.06.25b' into HEAD
      rcu: Introduce grace-period sequence numbers
      rcu: Move rcu_gp_slow() to ->gp_seq
      rcu: Make rcutorture's batches-completed API use ->gp_seq
      rcu: Convert rcu_check_gp_kthread_starvation() to GP sequence number
      rcu: Make quiescent-state reporting use ->gp_seq
      rcu: Convert conditional grace-period primitives to ->gp_seq
      rcu: Move RCU's grace-period-change code to ->gp_seq
      rcu: Convert rcu_gpnum_ovf() to ->gp_seq
      rcu: Move rcu_implicit_dynticks_qs() to ->gp_seq
      rcu: Move rcu_try_advance_all_cbs() to ->gp_seq
      rcu: Move rcu_nocb_gp_get() to ->gp_seq
      rcu: Move rcu_gp_in_progress() to ->gp_seq
      rcu: Convert ->rcu_iw_gpnum to ->gp_seq
      rcu: Convert ->completedqs to ->gp_seq
      rcu: Convert grace-period requests to ->gp_seq
      rcu: Make RCU CPU stall warnings use ->gp_seq
      rcutorture: Convert rcutorture_get_gp_data() to ->gp_seq
      rcu: Move from ->need_future_gp[] to ->gp_seq_needed
      rcu: Make rcu_nocb_wait_gp() check if GP already requested
      rcu: Convert rcu_grace_period tracepoint to gp_seq
      rcu: Convert rcu_future_grace_period tracepoint to gp_seq
      rcu: Convert rcu_grace_period_init tracepoint to gp_seq
      rcu: Convert rcu_preempt_task tracepoint to ->gp_seq
      rcu: Convert rcu_unlock_preempted_task tracepoint to ->gp_seq
      rcu: Convert rcu_quiescent_state_report tracepoint to ->gp_seq
      rcu: Convert rcu_fqs tracepoint to ->gp_seq
      rcu: Remove ->gpnum and ->completed
      rcu: Make simple callback acceleration refer to rdp->gp_seq_needed
      doc: Update data-structure documentation for ->gp_seq
      doc: Update memory-ordering documentation for ->gp-seq
      doc: Update RCU CPU stall-warning documentation
      rcu: Don't funnel-lock above leaf node if GP in progress
      rcu: Make rcu_start_this_gp() check for grace period already started
      rcutorture: Correctly handle grace-period sequence wrap
      rcu: Regularize resetting of rcu_data wrap indicator
      rcu: Clean up handling of tasks blocked across full-rcu_node offline
      rcu: Fix an obsolete ->qsmaskinit comment
      rcu: Make rcu_init_new_rnp() stop upon already-set bit
      rcu: Make rcu_report_unblock_qs_rnp() warn on violated preconditions
      rcu: Fix typo and add additional debug
      rcu: Replace smp_wmb() with smp_store_release() for stall check
      rcu: Prevent useless FQS scan after all CPUs have checked in
      rcu: Suppress false-positive offline-CPU lockdep-RCU splat
      rcu: Suppress false-positive preempted-task splats
      rcu: Suppress more involved false-positive preempted-task splats
      rcu: Suppress false-positive splats from mid-init task resume
      rcu: Fix grace-period hangs from mid-init task resume
      rcu: Fix grace-period hangs due to race with CPU offline
      rcu: Add RCU-preempt check for waiting on newly onlined CPU
      rcu: Move grace-period pre-init delay after pre-init
      rcu: Remove failsafe check for lost quiescent state
      rcu: Remove CPU-hotplug failsafe from force-quiescent-state code path
      rcu: Add up-tree information to dump_blkd_tasks() diagnostics
      rcu: Add CPU online/offline state to dump_blkd_tasks()
      rcu: Record ->gp_state for both phases of grace-period initialization
      rcu: Add diagnostics for offline CPUs failing to report QS
      rcu: Make rcu_read_unlock_special() static
      rcu: Improve RCU-tasks naming and comments
      rcu: Mark task as .need_qs less aggressively
      rcu: Inline rcu_dynticks_momentary_idle() into its sole caller
      rcu: Clarify and correct the rcu_preempt_qs() header comment
      rcu: Remove unused rcu_kick_nohz_cpu() function
      rcu: Remove unused local variable "cpu"
      rcu: Remove "inline" from panic_on_rcu_stall() and rcu_blocking_is_gp()
      rcu: Remove "inline" from rcu_torture_print_module_parms()
      rcu: Remove "inline" from rcu_perf_print_module_parms()
      rcu: Remove __maybe_unused from rcu_cpu_has_callbacks()
      rcu: Use RCU CPU stall timeout for rcu_check_gp_start_stall()
      rcu: Add diagnostics for rcutorture writer stall warning
      rcu: Make rcu_seq_diff() more exact
      MAINTAINERS: Update RCU, SRCU, and TORTURE-TEST entries
      rcu: Print stall-warning NMI dyntick state in hexadecimal
      srcu: Add grace-period number to rcutorture statistics printout
      rcutorture: Change units of onoff_interval to jiffies
      rcu: Remove rcutorture test version and sequence number
      rcuperf: Remove unused torturing_tasks() function
      rcutorture: Extract common code from rcu_torture_reader()
      rcutorture: Use atomic increment for n_rcu_torture_timers
      rcutorture: Use per-CPU random state for rcu_torture_timer()
      rcutorture: Make rcu_torture_timer() use rcu_torture_one_read()
      rcutorture: Handle extended read-side critical sections
      rcutorture: Emphasize testing of single reader protection type
      Merge branches 'fixes1.2018.07.12b' and 'torture1.2018.07.12b' into HEAD

Steven Rostedt (VMware) (2):
      rcu: Speed up calling of RCU tasks callbacks
      rcu: Add comment to the last sleep in the rcu tasks loop

 .../Design/Data-Structures/Data-Structures.html    |  118 +--
 .../Memory-Ordering/Tree-RCU-Memory-Ordering.html  |   22 +-
 .../Design/Memory-Ordering/TreeRCU-gp-cleanup.svg  |  123 +--
 .../Design/Memory-Ordering/TreeRCU-gp-init-1.svg   |   16 +-
 .../Design/Memory-Ordering/TreeRCU-gp-init-3.svg   |   56 +-
 .../RCU/Design/Memory-Ordering/TreeRCU-gp.svg      |  237 ++---
 .../RCU/Design/Memory-Ordering/TreeRCU-qs.svg      |   12 +-
 Documentation/RCU/stallwarn.txt                    |   24 +-
 Documentation/RCU/whatisRCU.txt                    |   18 +-
 Documentation/admin-guide/kernel-parameters.txt    |    4 +-
 MAINTAINERS                                        |    9 +-
 include/linux/rculist.h                            |   19 +-
 include/linux/rcupdate.h                           |   20 +-
 include/linux/rcutiny.h                            |    2 +-
 include/linux/srcu.h                               |   17 +
 include/linux/torture.h                            |    4 +-
 include/trace/events/rcu.h                         |  112 ++-
 kernel/locking/locktorture.c                       |    5 +-
 kernel/rcu/rcu.h                                   |  104 +-
 kernel/rcu/rcuperf.c                               |   57 +-
 kernel/rcu/rcutorture.c                            |  462 ++++++---
 kernel/rcu/srcutree.c                              |   39 +-
 kernel/rcu/tiny.c                                  |    4 +-
 kernel/rcu/tree.c                                  | 1019 +++++++++++---------
 kernel/rcu/tree.h                                  |   71 +-
 kernel/rcu/tree_exp.h                              |   14 +-
 kernel/rcu/tree_plugin.h                           |  176 ++--
 kernel/rcu/update.c                                |   45 +-
 kernel/torture.c                                   |   15 +-
 .../testing/selftests/rcutorture/bin/configinit.sh |   26 +-
 .../testing/selftests/rcutorture/bin/kvm-build.sh  |   11 +-
 .../selftests/rcutorture/bin/kvm-recheck-rcu.sh    |    1 +
 .../selftests/rcutorture/bin/kvm-recheck.sh        |    1 +
 .../selftests/rcutorture/bin/kvm-test-1-run.sh     |    5 +-
 tools/testing/selftests/rcutorture/bin/kvm.sh      |    2 +-
 .../selftests/rcutorture/bin/parse-console.sh      |    7 +
 .../selftests/rcutorture/configs/rcu/TREE03.boot   |    4 +-
 .../selftests/rcutorture/configs/rcu/TREE08-T.boot |    1 -
 .../rcutorture/configs/rcu/ver_functions.sh        |    2 +-
 39 files changed, 1675 insertions(+), 1209 deletions(-)
 delete mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TREE08-T.boot

