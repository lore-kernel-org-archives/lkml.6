Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA50FC64E79
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 539F721848
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545689853;
	bh=t6C/zXcUHvSPDr98BmnRSgeWfZ4eRei0eqxy/je/Xt8=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=0bSFiw7xaWFdySLiyr5zwNbwm4r4fj6A4RpD3lxoMXENkoABxmEv5ynqPKJqT9+K4
	 hkoOabk/sWeMuF5thSfjxMlLDSUTXAouuTqaTfkjnOSbAyimoYsZr2WCeJ6mc0HMmB
	 puNFJpcyz3WQmXdcoRds+nwE1LNKGrsodH+wnTdc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbeLXWRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 17:17:32 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37924 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbeLXWRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 17:17:32 -0500
Received: by mail-wr1-f66.google.com with SMTP id v13so12563363wrw.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 14:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=DsBH1D9/xz2bXUtyQeJvb1+NZf+B8Jcd8DGGpNGC7fA=;
        b=lda9CaujZOlUzJ0j2kLvCWFNCL2tO5zs5QQqouqGld6fSmfVpg39UPGtXVLhwldV8d
         bR5vb5FKiM7HFBQoXhN+PbumhGjtoFUgCNfhAzazTnx9S3vH1N4OkGD3BOcKxRgywuIU
         CZblMkmuRJl24r/dbLmgX2RH942Lq4ZyAA02tvwUSclq2vRtGxepVQxyi+N92liMrLK9
         T+Gv6USdYviYhiJ/tSkdqH2KfGFL7LvAg6vFsV0I6COi5mXOAZKP35lLJzcT01RdUxgU
         fc74V1wn6nrobP8oD27i4b6DxgXwosOmpeW9BtPAx3EfH1X1hRxgygg09C5U1r7UIbeS
         CYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=DsBH1D9/xz2bXUtyQeJvb1+NZf+B8Jcd8DGGpNGC7fA=;
        b=pZypvx7pAqzH8JkvBi3PcZkNS6zRYVGFCaHGOuFaPlnaq/aYSCWsVBPuylu+beWJKw
         GyVk4ZR9diMlU2xvRrAPdffESsIYfT2azIzIGBDolFEbsJbpLnZO4/caoBNjIgJdq014
         X0C/D8gpQ8K7tL2voDeWP6rMrmUBsb9h//gbms0PUv+Ii4AnuFlsWIIEua55ZMX4ifVc
         7dqB3sdbmFWUc6qePJbZc8cwT8oigNAAKyJMwbfn3YMheXHn6JCuH8dT/SIwC02Vwxwz
         9vNfqlVK5oa8iwq+qslyolTEabcsmPstTOxCG7kbalQSDECBmOLT3ofL9/muMHR8gfVU
         wUMA==
X-Gm-Message-State: AJcUukflt5GLaBeEjRig9vXQ/hvdBTt71iydasP1NafdMSiHgulhLNth
        reEg/PqN6QCSpqNH2GMLCq4=
X-Google-Smtp-Source: ALg8bN6S3tjaO5D9zN+WNBSOvyg75UQVlopp5PwHxsk2N6tbM1GlXMxicSM0tpDOvIGmoWanA+vcrg==
X-Received: by 2002:adf:e509:: with SMTP id j9mr13980003wrm.76.1545689849066;
        Mon, 24 Dec 2018 14:17:29 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 129sm21305902wmd.18.2018.12.24.14.17.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Dec 2018 14:17:28 -0800 (PST)
Date:   Mon, 24 Dec 2018 23:17:26 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@us.ibm.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] RCU updates for v4.21
Message-ID: <20181224221726.GA78524@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest core-rcu-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-rcu-for-linus

   # HEAD: 4bbfd7467cfc7d42e18d3008fa6a28ffd56e901a Merge branch 'for-mingo' of git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu into core/rcu

The biggest RCU changes in this cycle were:

    - Convert RCU's BUG_ON() and similar calls to WARN_ON() and similar.
    
    - Replace calls of RCU-bh and RCU-sched update-side functions
      to their vanilla RCU counterparts.  This series is a step
      towards complete removal of the RCU-bh and RCU-sched update-side
      functions.
    
      ( Note that some of these conversions are going upstream via their
        respective maintainers. )
    
    - Documentation updates, including a number of flavor-consolidation
      updates from Joel Fernandes.
    
    - Miscellaneous fixes.
    
    - Automate generation of the initrd filesystem used for
      rcutorture testing.
    
    - Convert spin_is_locked() assertions to instead use lockdep.
    
      ( Note that some of these conversions are going upstream via their
        respective maintainers. )
    
    - SRCU updates, especially including a fix from Dennis Krein
      for a bag-on-head-class bug.
    
    - RCU torture-test updates.

 Thanks,

	Ingo

------------------>
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

Paul E. McKenney (76):
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

