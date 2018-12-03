Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFBFC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E613620851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:54:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E613620851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbeLCWyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 17:54:12 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11834 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725909AbeLCWyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 17:54:11 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wB3Mrioh131634
        for <linux-kernel@vger.kernel.org>; Mon, 3 Dec 2018 17:54:08 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2p5dnmr1rt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 17:54:08 -0500
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 3 Dec 2018 22:54:07 -0000
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 3 Dec 2018 22:54:03 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wB3Ms2UQ20512818
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 3 Dec 2018 22:54:02 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D30FAB2065;
        Mon,  3 Dec 2018 22:54:02 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 974B5B2064;
        Mon,  3 Dec 2018 22:54:02 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.38])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  3 Dec 2018 22:54:02 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 9BD2916C1BF4; Mon,  3 Dec 2018 14:54:05 -0800 (PST)
Date:   Mon, 3 Dec 2018 14:54:05 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, danymadden@us.ibm.com,
        Dennis.Krein@netapp.com, joe@perches.com, joel@joelfernandes.org,
        ldr709@gmail.com, pierceagriffiths@gmail.com,
        rdunlap@infradead.org, w@1wt.eu, zhouzhouyi@gmail.com,
        connor.shu@gmail.com
Subject: [GIT PULL rcu/next] RCU commits for 4.21/5.0
Reply-To: paulmck@linux.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18120322-0060-0000-0000-000002DDEE0B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010166; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01126567; UDB=6.00585085; IPR=6.00906702;
 MB=3.00024430; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-03 22:54:07
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120322-0061-0000-0000-00004769D2D2
Message-Id: <20181203225405.GA21856@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-03_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812030205
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Ingo,

This pull request contains the following changes:

1.	Convert RCU's BUG_ON() and similar calls to WARN_ON() and similar.

	http://lkml.kernel.org/r/20181111193156.GA3666@linux.ibm.com

2.	Replace of calls to RCU-bh and RCU-sched update-side functions
	to their vanilla RCU counterparts.  This series is a step
	towards complete removal of the RCU-bh and RCU-sched update-side
	functions.

	http://lkml.kernel.org/r/20181111194104.GA4787@linux.ibm.com

	Note that several of the patches sent out have been dropped from
	this series due to having been pulled in by their respective
	maintainers.

3.	Documentation updates, including a number of flavor-consolidation
	updates from Joel Fernandes.

	http://lkml.kernel.org/r/20181111195619.GA6958@linux.ibm.com

4.	Miscellaneous fixes.

	http://lkml.kernel.org/r/20181111192839.GA32144@linux.ibm.com

5.	Automate generation of the initrd filesystem used for
	rcutorture testing.

	http://lkml.kernel.org/r/20181111200127.GA9511@linux.ibm.com

6.	Convert spin_is_locked() assertions to instead use lockdep.

	http://lkml.kernel.org/r/20181111200421.GA10551@linux.ibm.com

	Note that several of the patches sent out have been dropped from
	this series due to having been pulled in by their respective
	maintainers.

7.	SRCU updates, especially including a fix from Dennis Krein
	for a bag-on-head-class bug.

	http://lkml.kernel.org/r/20181111200834.GA10983@linux.ibm.com

8.	RCU torture-test updates.

	http://lkml.kernel.org/r/20181111201956.GA11935@linux.ibm.com

All of these changes have been subjected to 0day Test Robot and -next
testing, and are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git for-mingo

for you to fetch changes up to 5ac7cdc29897e5fc3f5e214f3f8c8b03ef8d7029:

  rcutorture: Don't do busted forward-progress testing (2018-12-01 12:45:42 -0800)

----------------------------------------------------------------
Connor Shu (1):
      rcutorture: Automatically create initrd directory

Dennis Krein (1):
      srcu: Lock srcu_data structure in srcu_gp_start()

Joe Perches (1):
      checkpatch: Create table of obsolete APIs and apply to RCU

Joel Fernandes (Google) (19):
      rcu: Remove unused rcu_state externs
      rcu: Fix rcu_{node,data} comments about gp_seq_needed
      doc: Clarify RCU data-structure comment about rcu_tree fanout
      doc: Remove rcu_preempt_state reference in stallwarn
      doc: Update information about resched_cpu
      doc: Remove rcu_dynticks from Data-Structures
      doc: rcu: Update Data-Structures for RCU flavor consolidation
      doc: rcu: Better clarify the rcu_segcblist ->len field
      doc: rcu: Update description of gp_seq fields in rcu_data
      doc: rcu: Update core and full API in whatisRCU
      doc: rcu: Add more rationale for using rcu_read_lock_sched in checklist
      doc: rcu: Remove obsolete suggestion from checklist
      doc: rcu: Remove obsolete checklist item about synchronize_rcu usage
      doc: rcu: Encourage use of rcu_barrier in checklist
      doc: Make reader aware of rcu_dereference_protected
      doc: Remove obsolete (non-)requirement about disabling preemption
      doc: Make listing in RCU perf/scale requirements use rcu_assign_pointer()
      doc: Correct parameter in stallwarn
      doc: Fix "struction" typo in RCU memory-ordering documentation

Lance Roy (7):
      x86/PCI: Replace spin_is_locked() with lockdep
      sfc: Replace spin_is_locked() with lockdep
      smsc: Replace spin_is_locked() with lockdep
      userfaultfd: Replace spin_is_locked() with lockdep
      locking/mutex: Replace spin_is_locked() with lockdep
      mm: Replace spin_is_locked() with lockdep
      KVM: arm/arm64: vgic: Replace spin_is_locked() with lockdep

Paul E. McKenney (77):
      rcu: Eliminate BUG_ON() for sync.c
      rcu: Eliminate BUG_ON() for kernel/rcu/tree.c
      rcu: Eliminate synchronize_rcu_mult()
      rcu: Consolidate the RCU update functions invoked by sync.c
      sched/membarrier: Replace synchronize_sched() with synchronize_rcu()
      sparc/oprofile: Convert timer_stop() to use synchronize_rcu()
      s390/mm: Convert tlb_table_flush() to use call_rcu()
      powerpc: Convert hugepd_free() to use call_rcu()
      doc: Set down forward-progress requirements
      rcutorture: Add initrd support for systems lacking dracut
      rcutorture: Make initrd/init execute in userspace
      rcutorture: Add cross-compile capability to initrd.sh
      srcu: Prevent __call_srcu() counter wrap with read-side critical section
      rcu: Stop expedited grace periods from relying on stop-machine
      rcu: Eliminate BUG_ON() for kernel/rcu/tree_plugin.h
      rcu: Eliminate BUG_ON() for kernel/rcu/update.c
      doc: Document rcutorture forward-progress test kernel parameters
      doc: RCU scheduler spinlock rcu_read_unlock() restriction remains
      MAINTAINERS: Update from @linux.vnet.ibm.com to @linux.ibm.com
      rcu: Avoid double multiply by HZ
      rcu: Parameterize rcu_check_gp_start_stall()
      rcu: Add state name to show_rcu_gp_kthreads() output
      rcu: Add jiffies-since-GP-activity to show_rcu_gp_kthreads()
      rcu: Trace end of grace period before end of grace period
      rcu: Speed up expedited GPs when interrupting RCU reader
      rcu: Replace this_cpu_ptr() with __this_cpu_read()
      rcu: Avoid signed integer overflow in rcu_preempt_deferred_qs()
      MAINTAINERS:  Add Joel Fernandes as RCU reviewer
      checkpatch.pl: Suggest lockdep instead of asserting !spin_is_locked()
      crypto/pcrypt: Replace synchronize_rcu_bh() with synchronize_rcu()
      drivers/ipmi: Replace synchronize_sched() with synchronize_rcu()
      ethernet/sis: Replace synchronize_sched() with synchronize_rcu()
      ethernet/realtek: Replace synchronize_sched() with synchronize_rcu()
      drivers/vhost: Replace synchronize_rcu_bh() with synchronize_rcu()
      cpufreq/intel_pstate: Replace synchronize_sched() with synchronize_rcu()
      cpufreq/cpufreq_governor: Replace synchronize_sched() with synchronize_rcu()
      fs/file: Replace synchronize_sched() with synchronize_rcu()
      tracing: Replace synchronize_sched() and call_rcu_sched()
      main: Replace rcu_barrier_sched() with rcu_barrier()
      kprobes: Replace synchronize_sched() with synchronize_rcu()
      lockdep: Replace synchronize_sched() with synchronize_rcu()
      sched/membarrier: synchronize_sched() with synchronize_rcu()
      modules: Replace synchronize_sched() and call_rcu_sched()
      workqueue: Replace call_rcu_sched() with call_rcu()
      events: Replace synchronize_sched() with synchronize_rcu()
      percpu-refcount: Replace call_rcu_sched() with call_rcu()
      slab: Replace synchronize_sched() with synchronize_rcu()
      mm: Replace call_rcu_sched() with call_rcu()
      srcu: Use "ssp" instead of "sp" for srcu_struct pointer
      net/sched: Replace call_rcu_bh() and rcu_barrier_bh()
      net/core: Replace call_rcu_bh() and synchronize_rcu_bh()
      net/bridge: Replace call_rcu_bh() and rcu_barrier_bh()
      percpu-rwsem: Replace synchronize_sched() with synchronize_rcu()
      types: Remove call_rcu_bh() and call_rcu_sched()
      cgroups: Replace synchronize_sched() with synchronize_rcu()
      livepatch: Replace synchronize_sched() with synchronize_rcu()
      net/core/skmsg: Replace call_rcu_sched() with call_rcu()
      net/decnet: Replace rcu_barrier_bh() with rcu_barrier()
      tools/kernel.h: Replace synchronize_sched() with synchronize_rcu()
      rcutorture/formal: Replace synchronize_sched() with synchronize_rcu()
      Merge branches 'bug.2018.11.12a', 'consolidate.2018.12.01a', 'doc.2018.11.12a', 'fixes.2018.11.12a', 'initrd.2018.11.08b', 'sil.2018.11.12a' and 'srcu.2018.11.27a' into HEAD
      rcutorture: Add call_rcu() flooding forward-progress tests
      torture: Bring any extra CPUs online during kernel startup
      rcutorture: Remove cbflood facility
      rcutorture: Break up too-long rcu_torture_fwd_prog() function
      rcutorture: Affinity forward-progress test to avoid housekeeping CPUs
      rcutorture: Prepare for asynchronous access to rcu_fwd_startat
      rcutorture: Dump grace-period diagnostics upon forward-progress OOM
      rcu: Account for nocb-CPU callback counts in RCU CPU stall warnings
      rcu: Print per-CPU callback counts for forward-progress failures
      rcutorture: Print GP age upon forward-progress failure
      rcutorture: Print histogram of CB invocation at OOM time
      rcutorture: Print time since GP end upon forward-progress failure
      rcutorture: Print forward-progress test age upon failure
      rcutorture: Recover from OOM during forward-progress tests
      rcutorture: Use 100ms buckets for forward-progress callback histograms
      rcutorture: Don't do busted forward-progress testing

Pierce Griffiths (1):
      torture: Remove unnecessary "ret" variables

Randy Dunlap (1):
      srcu: Fix kernel-doc missing notation

Willy Tarreau (4):
      rcutorture: Always strip using the cross-compiler
      rcutorture: Check initrd/init instead of initrd only
      rcutorture: Import a copy of nolibc
      rcutorture: Make use of nolibc when available

Zhouyi Zhou (1):
      rcu: Adjust the comment of function rcu_is_watching

 .../Design/Data-Structures/BigTreeClassicRCUBH.svg |  499 -----
 .../Data-Structures/BigTreeClassicRCUBHdyntick.svg |  695 -------
 .../Data-Structures/BigTreePreemptRCUBHdyntick.svg |  741 -------
 .../BigTreePreemptRCUBHdyntickCB.svg               |  834 +++-----
 .../Design/Data-Structures/Data-Structures.html    |  173 +-
 .../RCU/Design/Data-Structures/blkd_task.svg       |  676 +++---
 .../Expedited-Grace-Periods.html                   |    6 +-
 .../Memory-Ordering/Tree-RCU-Memory-Ordering.html  |    2 +-
 .../RCU/Design/Requirements/Requirements.html      |  206 +-
 Documentation/RCU/checklist.txt                    |   49 +-
 Documentation/RCU/stallwarn.txt                    |    7 +-
 Documentation/RCU/whatisRCU.txt                    |   70 +-
 Documentation/admin-guide/kernel-parameters.txt    |   35 +-
 MAINTAINERS                                        |   73 +-
 arch/powerpc/mm/hugetlbpage.c                      |    2 +-
 arch/s390/mm/pgalloc.c                             |    2 +-
 arch/sparc/oprofile/init.c                         |    2 +-
 arch/x86/pci/i386.c                                |    2 +-
 crypto/pcrypt.c                                    |    2 +-
 drivers/char/ipmi/ipmi_si_intf.c                   |    2 +-
 drivers/cpufreq/cpufreq_governor.c                 |    2 +-
 drivers/cpufreq/intel_pstate.c                     |    2 +-
 drivers/net/ethernet/realtek/8139too.c             |    2 +-
 drivers/net/ethernet/realtek/r8169.c               |    4 +-
 drivers/net/ethernet/sfc/efx.c                     |    2 +-
 drivers/net/ethernet/sis/sis190.c                  |    2 +-
 drivers/net/ethernet/smsc/smsc911x.h               |    2 +-
 drivers/vhost/net.c                                |    2 +-
 fs/file.c                                          |    2 +-
 fs/userfaultfd.c                                   |    2 +-
 include/linux/percpu-rwsem.h                       |    2 +-
 include/linux/rcupdate_wait.h                      |   17 -
 include/linux/sched.h                              |    4 +-
 include/linux/srcu.h                               |   79 +-
 include/linux/srcutiny.h                           |   24 +-
 include/linux/srcutree.h                           |    8 +-
 include/linux/tracepoint.h                         |    2 +-
 include/linux/types.h                              |    4 +-
 init/main.c                                        |    6 +-
 kernel/cgroup/cgroup.c                             |    2 +-
 kernel/events/core.c                               |    2 +-
 kernel/kprobes.c                                   |   10 +-
 kernel/livepatch/patch.c                           |    4 +-
 kernel/livepatch/transition.c                      |    4 +-
 kernel/locking/lockdep.c                           |    2 +-
 kernel/locking/mutex-debug.c                       |    4 +-
 kernel/module.c                                    |   14 +-
 kernel/rcu/rcu.h                                   |    4 +
 kernel/rcu/rcutorture.c                            |  389 ++--
 kernel/rcu/srcutiny.c                              |  120 +-
 kernel/rcu/srcutree.c                              |  489 ++---
 kernel/rcu/sync.c                                  |   25 +-
 kernel/rcu/tree.c                                  |  114 +-
 kernel/rcu/tree.h                                  |   18 +-
 kernel/rcu/tree_exp.h                              |   10 +-
 kernel/rcu/tree_plugin.h                           |   81 +-
 kernel/rcu/update.c                                |    9 +-
 kernel/sched/core.c                                |    2 +-
 kernel/sched/membarrier.c                          |    6 +-
 kernel/torture.c                                   |   34 +-
 kernel/trace/ftrace.c                              |   24 +-
 kernel/trace/ring_buffer.c                         |   12 +-
 kernel/trace/trace.c                               |   10 +-
 kernel/trace/trace_events_filter.c                 |    4 +-
 kernel/trace/trace_kprobe.c                        |    2 +-
 kernel/tracepoint.c                                |    4 +-
 kernel/workqueue.c                                 |    8 +-
 lib/percpu-refcount.c                              |    2 +-
 mm/khugepaged.c                                    |    4 +-
 mm/mmu_gather.c                                    |    2 +-
 mm/slab.c                                          |    4 +-
 mm/slab_common.c                                   |    6 +-
 mm/swap.c                                          |    3 +-
 net/bridge/br_mdb.c                                |    2 +-
 net/bridge/br_multicast.c                          |   14 +-
 net/core/netpoll.c                                 |    4 +-
 net/core/skmsg.c                                   |    2 +-
 net/decnet/af_decnet.c                             |    2 +-
 net/sched/sch_api.c                                |    2 +-
 net/sched/sch_generic.c                            |    8 +-
 scripts/checkpatch.pl                              |   35 +
 tools/include/linux/kernel.h                       |    2 +-
 tools/testing/selftests/rcutorture/bin/kvm.sh      |    8 +
 tools/testing/selftests/rcutorture/bin/mkinitrd.sh |  136 ++
 tools/testing/selftests/rcutorture/bin/nolibc.h    | 2197 ++++++++++++++++++++
 tools/testing/selftests/rcutorture/doc/initrd.txt  |   99 +-
 .../formal/srcu-cbmc/include/linux/types.h         |    4 +-
 virt/kvm/arm/vgic/vgic.c                           |   12 +-
 88 files changed, 4187 insertions(+), 4014 deletions(-)
 delete mode 100644 Documentation/RCU/Design/Data-Structures/BigTreeClassicRCUBH.svg
 delete mode 100644 Documentation/RCU/Design/Data-Structures/BigTreeClassicRCUBHdyntick.svg
 delete mode 100644 Documentation/RCU/Design/Data-Structures/BigTreePreemptRCUBHdyntick.svg
 create mode 100755 tools/testing/selftests/rcutorture/bin/mkinitrd.sh
 create mode 100644 tools/testing/selftests/rcutorture/bin/nolibc.h

