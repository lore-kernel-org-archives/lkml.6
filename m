Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932448AbeCJP4r (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 10:56:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56536 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932150AbeCJP4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 10:56:45 -0500
Date: Sat, 10 Mar 2018 07:57:17 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: mingo@kernel.org
Cc: linux-kernel@vger.kernel.org, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, lianglihao@huawei.com, tj@kernel.org,
        changcheng.liu@intel.com, mawilcox@microsoft.com, evix84@gmail.com,
        byungchul.park@lge.com
Subject: [GIT PULL rcu/next] RCU commits for 4.17
Reply-To: paulmck@linux.vnet.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18031015-0056-0000-0000-0000042B789C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008647; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01001060; UDB=6.00509247; IPR=6.00780390;
 MB=3.00019958; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-10 15:56:43
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031015-0057-0000-0000-0000086D80C9
Message-Id: <20180310155717.GA10068@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-10_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803100191
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Ingo!

This pull request contains the following changes:

1.	Miscellaneous fixes, perhaps most notably removing obsolete
	code whose only purpose in life was to gather information for
	the now-removed RCU debugfs facility.  Other notable changes
	include removing NO_HZ_FULL_ALL in favor of the nohz_full kernel
	boot parameter, minor optimizations for expedited grace periods,
	some added tracing, creating an RCU-specific workqueue using Tejun's
	new WQ_MEM_RECLAIM flag, and several cleanups to code and comments.

	http://lkml.kernel.org/r/20180226215219.GA27379@linux.vnet.ibm.com

2.	SRCU cleanups and optimizations.

	http://lkml.kernel.org/r/20180226215614.GA31616@linux.vnet.ibm.com

3.	Torture-test updates, perhaps most notably the adding of ARMv8
	support, but also including numerous cleanups and usability fixes.

	http://lkml.kernel.org/r/20180307172627.GA15805@linux.vnet.ibm.com

All of these changes have been subjected to 0day Test Robot and -next
testing, and are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git for-mingo

for you to fetch changes up to 338c46403f169dd76bff8ed58fd0be0d600e7aba:

  Merge branches 'fixes.2018.02.23a', 'srcu.2018.02.20a' and 'torture.2018.02.20a' into HEAD (2018-02-23 15:15:41 -0800)

----------------------------------------------------------------
Byungchul Park (1):
      srcu: Remove dead code in srcu_gp_end()

Ildar Ismagilov (3):
      rcu: Fix misprint in srcu_funnel_exp_start
      srcu: Prevent sdp->srcu_gp_seq_needed_exp counter wrap
      srcu: Reduce scans of srcu_data in counter wrap check

Lihao Liang (4):
      rcu: Remove unnecessary spinlock in rcu_boot_init_percpu_data()
      doc: Fix typo in rcutorture documentation
      doc: Fix typo in rcu_head comments
      rcutorture: Add basic ARM64 support to run scripts

Liu, Changcheng (1):
      rcu: Remove redundant nxttail index macro define

Matthew Wilcox (1):
      rcu: Use wrapper for lockdep asserts

Paul E. McKenney (27):
      sched/isolation: Eliminate NO_HZ_FULL_ALL
      rcu: Fix CPU offload boot message when no CPUs are offloaded
      rcu: Remove obsolete boost statistics for debugfs
      rcu: Remove obsolete callback-invocation statistics for debugfs
      rcu: Remove obsolete __rcu_pending() statistics for debugfs
      rcu: Remove obsolete force-quiescent-state statistics for debugfs
      rcu: More clearly identify grace-period kthread stack dump
      rcu: Consolidate rcu.h #ifdefs
      rcu: Fix init_rcu_head() comment.
      rcu: Add more tracing of expedited grace periods
      rcu: Trace expedited GP delays due to transitioning CPUs
      rcu: Make expedited RCU CPU selection avoid unnecessary stores
      srcu: Abstract function name
      rcu: Remove SRCU throttling
      rcutorture: Replace multi-instance kzalloc() with kcalloc()
      rcutorture: Abstract function and module names
      rcutorture: Avoid fake-writer use of undefined primitives
      rcutorture: Re-enable testing of dynamic expediting
      rcutorture: Record which grace-period primitives are tested
      rcutorture: Update kvm.sh header comment
      torture: Specify qemu memory size with --memory argument
      torture: Default jitter off when running rcuperf
      torture: Adjust rcuperf trace processing to allow for workqueues
      torture: Grace periods do not piggyback off of themselves
      torture: Provide more sensible nreader/nwriter defaults for rcuperf
      rcu: Create RCU-specific workqueues with rescuers
      Merge branches 'fixes.2018.02.23a', 'srcu.2018.02.20a' and 'torture.2018.02.20a' into HEAD

Tejun Heo (1):
      rcu: Call touch_nmi_watchdog() while printing stall warnings

 Documentation/timers/NO_HZ.txt                     |  7 ---
 include/linux/rcupdate.h                           | 10 +--
 include/linux/types.h                              |  2 +-
 include/trace/events/rcu.h                         |  4 ++
 kernel/rcu/rcu.h                                   | 38 ++++++++----
 kernel/rcu/rcuperf.c                               | 21 ++++++-
 kernel/rcu/rcutorture.c                            | 72 ++++++++++++----------
 kernel/rcu/srcutree.c                              | 29 +++++----
 kernel/rcu/tree.c                                  | 72 ++++++++--------------
 kernel/rcu/tree.h                                  | 36 +----------
 kernel/rcu/tree_exp.h                              | 36 ++++++++---
 kernel/rcu/tree_plugin.h                           | 34 ++++++----
 kernel/time/Kconfig                                | 10 ---
 kernel/time/tick-sched.c                           | 22 +------
 .../testing/selftests/rcutorture/bin/functions.sh  | 17 ++++-
 .../rcutorture/bin/kvm-recheck-rcuperf-ftrace.sh   | 11 ++--
 .../selftests/rcutorture/bin/kvm-test-1-run.sh     |  4 +-
 tools/testing/selftests/rcutorture/bin/kvm.sh      | 22 +++++--
 .../selftests/rcutorture/configs/rcu/TASKS03       |  1 -
 .../selftests/rcutorture/configs/rcu/TASKS03.boot  |  2 +-
 .../selftests/rcutorture/configs/rcu/TREE04        |  1 -
 .../selftests/rcutorture/configs/rcu/TREE04.boot   |  2 +-
 .../selftests/rcutorture/configs/rcu/TREE07        |  1 -
 .../rcutorture/configs/rcuperf/ver_functions.sh    | 24 +-------
 .../selftests/rcutorture/doc/rcu-test-image.txt    |  2 +-
 25 files changed, 238 insertions(+), 242 deletions(-)
