Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752D3C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37D812184A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733227AbfBKUMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 15:12:16 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39692 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732615AbfBKUMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 15:12:16 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1BK9HMV028141
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 15:12:14 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qkfehh3cm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 15:12:14 -0500
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 11 Feb 2019 20:12:13 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 11 Feb 2019 20:12:09 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1BKC8d624707240
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Feb 2019 20:12:08 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B2069B2065;
        Mon, 11 Feb 2019 20:12:08 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 838A8B205F;
        Mon, 11 Feb 2019 20:12:08 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.41])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 11 Feb 2019 20:12:08 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 89DBF16C4066; Mon, 11 Feb 2019 12:12:08 -0800 (PST)
Date:   Mon, 11 Feb 2019 12:12:08 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        jun.zhang@intel.com, junchangwang@gmail.com,
        joel@joelfernandes.org, bigeasy@linutronix.de, w@1wt.eu
Subject: [GIT PULL rcu/next] RCU commits for 5.1
Reply-To: paulmck@linux.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19021120-0052-0000-0000-00000388B05E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010578; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000279; SDB=6.01159648; UDB=6.00605180; IPR=6.00940193;
 MB=3.00025530; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-11 20:12:11
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021120-0053-0000-0000-00005FD026BD
Message-Id: <20190211201208.GA30732@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-11_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902110147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Ingo,

This pull request contains the following changes:

1.	Additional cleanups after RCU flavor consolidation.

	http://lkml.kernel.org/r/20190109211830.GA30595@linux.ibm.com

2.	Grace-period forward-progress cleanups and improvements.

	http://lkml.kernel.org/r/20190109212816.GA32282@linux.ibm.com

3.	Documentation updates.

	http://lkml.kernel.org/r/20190109213302.GA1723@linux.ibm.com

4.	Miscellaneous fixes.

	http://lkml.kernel.org/r/20190109214115.GA2835@linux.ibm.com

5.	spin_is_locked() conversions to lockdep.

	http://lkml.kernel.org/r/20190109222120.GA13904@linux.ibm.com

6.	SPDX changes to RCU source and header files.

	http://lkml.kernel.org/r/20190207141700.GA11106@linux.ibm.com

7.	SRCU updates.

	http://lkml.kernel.org/r/20190109214506.GA4747@linux.ibm.com

8.	Torture-test updates, including nolibc updates and moving
	nolibc to tools/include.

	http://lkml.kernel.org/r/20190109214944.GA5610@linux.ibm.com

All of these changes have been subjected to 0day Test Robot and -next
testing, and are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git e7ffb4eb9a6d89678e7f62461737899f88dab64e

for you to fetch changes up to e7ffb4eb9a6d89678e7f62461737899f88dab64e:

  Merge branches 'doc.2019.01.26a', 'fixes.2019.01.26a', 'sil.2019.01.26a', 'spdx.2019.02.09a', 'srcu.2019.01.26a' and 'torture.2019.01.26a' into HEAD (2019-02-09 08:47:52 -0800)

Note that the diffstat output omits the addition of tree_stall.h, so is
overly optimistic.  :-/

----------------------------------------------------------------
Joel Fernandes (Google) (1):
      rcu: Add sparse check to rcu_assign_pointer()

Junchang Wang (2):
      doc: Fix outdated links
      RCU/torture.txt: Remove section MODULE PARAMETERS

Paul E. McKenney (59):
      sched: Replace call_rcu_sched() with call_rcu()
      sched: Replace synchronize_sched() with synchronize_rcu()
      rcu: Rename and comment changes due to only one rcuo kthread per CPU
      rcu: Make expedited IPI handler return after handling critical section
      rcu: Inline force_quiescent_state() into rcu_force_quiescent_state()
      rcu: Eliminate RCU_BH_FLAVOR and RCU_SCHED_FLAVOR
      rcu: Inline rcu_kthread_do_work() into its sole remaining caller
      rcu: Determine expedited-GP IPI handler at build time
      rcu: Consolidate PREEMPT and !PREEMPT synchronize_rcu_expedited()
      rcu: Consolidate PREEMPT and !PREEMPT synchronize_rcu()
      rcu: Inline _synchronize_rcu_expedited() into synchronize_rcu_expedited()
      rcu: Discard separate per-CPU callback counts
      rcu: Remove wrapper definitions for obsolete RCU update functions
      rcu: Accommodate zero jiffies_till_first_fqs and kthread kicking
      rcu: Move rcu_cpu_kthread_task to rcu_data structure
      rcu: Move rcu_cpu_kthread_status to rcu_data structure
      rcu: Remove unused rcu_cpu_kthread_loops per-CPU variable
      rcu: Move rcu_cpu_has_work to rcu_data structure
      rcu: Remove unused rcu_cpu_kthread_cpu per-CPU variable
      rcu: Update NOCB comments
      rcu: Improve diagnostics for failed RCU grace-period start
      rcu: Protect rcu_check_gp_kthread_starvation() access to ->gp_flags
      rcu: Add sysrq rcu_node-dump capability
      Merge branches 'consolidate.2019.01.26a' and 'fwd.2019.01.26a' into HEAD
      doc: Now jiffies_till_sched_qs solicits help from cond_resched()
      doc: CPU-hotplug notifiers cannot invoke synchronize_srcu() or srcu_barrier()
      rcu: Docbook for rcu_head_init() and rcu_head_after_call_rcu()
      rcu: Rename rcu_check_callbacks() to rcu_sched_clock_irq()
      rcu: Rename rcu_process_callbacks() to rcu_core() for Tree RCU
      rcu: Remove preemption disabling from expedited CPU selection
      rcu: Repair rcu_nmi_exit() docbook header
      rcu: Fix obsolete DYNTICK_IRQ_NONIDLE comment
      include/asm-generic: Remove spin_is_locked() comment
      virt/kvm: Replace spin_is_locked() with lockdep
      srcu: Check for invalid idx argument in srcu_read_unlock()
      rcutorture: Record grace periods in forward-progress histogram
      torture: Explain and simplify odd "for" loop in mkinitrd.sh
      rcutorture: Add grace period after CPU offline
      rcuperf: Stop abusing IS_ENABLED()
      rcu/rcu.h: Convert to SPDX license identifier
      rcu/rcuperf: Convert to SPDX license identifier
      rcu/rcu_segcblist: Convert to SPDX license identifier
      rcu/rcutorture: Convert to SPDX license identifier
      rcu/srcu: Convert to SPDX license identifier
      rcu/sync: Convert to SPDX license identifier
      rcu/tiny: Convert to SPDX license identifier
      rcu/tree: Convert to SPDX license identifier
      rcu/update: Convert to SPDX license identifier
      linux/rcu_node_tree: Convert to SPDX license identifier
      linux/rcupdate: Convert to SPDX license identifier
      linux/rcu_segcblist: Convert to SPDX license identifier
      linux/rcu_sync: Convert to SPDX license identifier
      linux/rcutiny: Convert to SPDX license identifier
      linux/rcutree: Convert to SPDX license identifier
      linux/srcu: Convert to SPDX license identifier
      torture: Convert to SPDX license identifier
      linux/torture: Convert to SPDX license identifier
      locking/locktorture: Convert to SPDX license identifier
      Merge branches 'doc.2019.01.26a', 'fixes.2019.01.26a', 'sil.2019.01.26a', 'spdx.2019.02.09a', 'srcu.2019.01.26a' and 'torture.2019.01.26a' into HEAD

Sebastian Andrzej Siewior (1):
      srcu: Remove srcu_queue_delayed_work_on()

Willy Tarreau (5):
      rcutorture/nolibc: Fix the clobbered registers in the MIPS syscall definition
      rcutorture/nolibc: Fix some poor indentation and alignment
      rcutorture/nolibc: Add a bit of documentation to explain how to use nolibc
      tools headers: Move the nolibc header from rcutorture to tools/include/nolibc/
      MAINTAINERS: Add myself as the maintainer for the nolibc header file(s)

Zhang, Jun (2):
      rcu: Do RCU GP kthread self-wakeup from softirq and interrupt
      rcu: Prevent needless ->gp_seq_needed update in __note_gp_changes()

 .../Expedited-Grace-Periods/ExpSchedFlow.svg       |  18 +-
 .../Expedited-Grace-Periods.html                   |  26 +-
 .../Memory-Ordering/Tree-RCU-Memory-Ordering.html  |   6 +-
 .../TreeRCU-callback-invocation.svg                |   2 +-
 .../RCU/Design/Memory-Ordering/TreeRCU-gp.svg      |   8 +-
 .../RCU/Design/Memory-Ordering/TreeRCU-qs.svg      |   6 +-
 .../RCU/Design/Requirements/Requirements.html      |  20 +-
 Documentation/RCU/stallwarn.txt                    |  15 +-
 Documentation/RCU/torture.txt                      | 169 +------------
 Documentation/RCU/whatisRCU.txt                    |   4 +-
 Documentation/admin-guide/kernel-parameters.txt    |  32 ++-
 MAINTAINERS                                        |   6 +
 include/asm-generic/bug.h                          |   3 -
 include/linux/rcu_node_tree.h                      |  17 +-
 include/linux/rcu_segcblist.h                      |  17 +-
 include/linux/rcu_sync.h                           |  15 +-
 include/linux/rcupdate.h                           |  91 +------
 include/linux/rcutiny.h                            |  17 +-
 include/linux/rcutree.h                            |  19 +-
 include/linux/srcu.h                               |  18 +-
 include/linux/srcutiny.h                           |  17 +-
 include/linux/srcutree.h                           |  20 +-
 include/linux/torture.h                            |  20 +-
 kernel/locking/locktorture.c                       |  21 +-
 kernel/rcu/rcu.h                                   |  21 +-
 kernel/rcu/rcu_segcblist.c                         |  17 +-
 kernel/rcu/rcu_segcblist.h                         |  17 +-
 kernel/rcu/rcuperf.c                               |  27 +--
 kernel/rcu/rcutorture.c                            |  59 +++--
 kernel/rcu/srcutiny.c                              |  17 +-
 kernel/rcu/srcutree.c                              |  72 ++----
 kernel/rcu/sync.c                                  |  15 +-
 kernel/rcu/tiny.c                                  |  19 +-
 kernel/rcu/tree.c                                  | 267 +++++++++++++--------
 kernel/rcu/tree.h                                  |  53 ++--
 kernel/rcu/tree_exp.h                              | 201 ++++++----------
 kernel/rcu/tree_plugin.h                           | 238 +++++-------------
 kernel/rcu/update.c                                |  17 +-
 kernel/sched/cpufreq.c                             |   4 +-
 kernel/sched/cpufreq_schedutil.c                   |   2 +-
 kernel/sched/sched.h                               |   2 +-
 kernel/sched/topology.c                            |   4 +-
 kernel/time/timer.c                                |   2 +-
 kernel/torture.c                                   |  25 +-
 .../rcutorture/bin => include/nolibc}/nolibc.h     | 118 +++++++--
 tools/testing/selftests/rcutorture/bin/mkinitrd.sh |  27 ++-
 virt/kvm/kvm_main.c                                |   2 +-
 47 files changed, 640 insertions(+), 1173 deletions(-)
 rename tools/{testing/selftests/rcutorture/bin => include/nolibc}/nolibc.h (94%)

