Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6807C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40BEC208A3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrL8l347"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40BEC208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbeLDIIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 03:08:45 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52906 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbeLDIIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 03:08:45 -0500
Received: by mail-wm1-f67.google.com with SMTP id r11-v6so8479901wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 00:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mxDxa9O9GyeUMsd43Dvv3LPJAy+k0Omy2tFm2Ue51mA=;
        b=RrL8l347Bd8g46HG5jBRr9jfdWT8XKksPK+FE9YwNyPQj/ulU6qr2R/ipX3xLPfxVd
         3XLXO9STQAuK5SAqpjBShbps3bjE1CimPKmAf9BFRUWR6+gern+AiTeco5WqfVDjhmaN
         tRwBBFSyhckwqEXdeT6SIWujoBtwJxPf6PloRhvsoLskWAmEFu/mqrVzsvvFwQcSU/eN
         VZDYvCwVDSpgER59NS7i0kZE9cW27mEWeGuZxduKt++BSLUErsl2eX84lSPP/14Qu5c+
         DxK4tlWOIX3WAB80Z+MOotZyoRRb+3RXot7i3rzr3O3VQgKos92zUl1r9FtoTbAymKgX
         wBtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mxDxa9O9GyeUMsd43Dvv3LPJAy+k0Omy2tFm2Ue51mA=;
        b=fC0UcjAAgs8KvYfUHTwqPniUC6CAHMCo/GMN4og0W3RMmz/huzhMfZD4jwKewFmBG3
         O+PSLlXz0q/C63DhevzwsJ/+A3LFUcPAtrrCABBDR9bMB0NH/NYmHIagAFvirpZWSyfX
         GONboYKnonZ5ntDk5RD82s17tVUh/MUNIbTz5t2o25okh2iTuZ+E4AnhGs1t54ADuhde
         r+n1AQJ+iiNhq7waZDe208IdLSbA7D72/bPmsL5/rg8zZDC+bBzdm4ZWCyrWbXi6YH6f
         67g/iLo40NEuGeKHvE0C5aeoCrKFlQGjtT5uOK+bWYtWbOGzSxr3d84JMMJkBqllY6A6
         P5Rw==
X-Gm-Message-State: AA+aEWYJLMoVMx6+nTvxS+mLp1St0M/PfqkGtZqEPJu2eD9iGkZ4QjHU
        rs0ccKChR25adbjmLum4cfg=
X-Google-Smtp-Source: AFSGD/VDqtLWbD4HO2eOB+3KZwkRae8JW/vrhKe2IthDsIi6iDKRIhzj4WdA9QbB4disl52tYzwwOw==
X-Received: by 2002:a1c:b189:: with SMTP id a131mr11726792wmf.38.1543910920669;
        Tue, 04 Dec 2018 00:08:40 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id f2sm14942862wru.14.2018.12.04.00.08.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 00:08:39 -0800 (PST)
Date:   Tue, 4 Dec 2018 09:08:37 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Willy Tarreau <w@1wt.eu>, "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org, danymadden@us.ibm.com,
        Dennis.Krein@netapp.com, joe@perches.com, joel@joelfernandes.org,
        ldr709@gmail.com, pierceagriffiths@gmail.com,
        rdunlap@infradead.org, w@1wt.eu, zhouzhouyi@gmail.com,
        connor.shu@gmail.com
Subject: Re: [GIT PULL rcu/next] RCU commits for 4.21/5.0
Message-ID: <20181204080837.GA67285@gmail.com>
References: <20181203225405.GA21856@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203225405.GA21856@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



[ Added Linus and Arnaldo to the Cc:, for high level kernel side and 
  tooling side buy-in for the <nolibc.h> inclusion in the kernel tree 
  below: ]

* Paul E. McKenney <paulmck@linux.ibm.com> wrote:

> Hello, Ingo,
> 
> This pull request contains the following changes:
> 
> 1.	Convert RCU's BUG_ON() and similar calls to WARN_ON() and similar.
> 
> 	http://lkml.kernel.org/r/20181111193156.GA3666@linux.ibm.com
> 
> 2.	Replace of calls to RCU-bh and RCU-sched update-side functions
> 	to their vanilla RCU counterparts.  This series is a step
> 	towards complete removal of the RCU-bh and RCU-sched update-side
> 	functions.
> 
> 	http://lkml.kernel.org/r/20181111194104.GA4787@linux.ibm.com
> 
> 	Note that several of the patches sent out have been dropped from
> 	this series due to having been pulled in by their respective
> 	maintainers.
> 
> 3.	Documentation updates, including a number of flavor-consolidation
> 	updates from Joel Fernandes.
> 
> 	http://lkml.kernel.org/r/20181111195619.GA6958@linux.ibm.com
> 
> 4.	Miscellaneous fixes.
> 
> 	http://lkml.kernel.org/r/20181111192839.GA32144@linux.ibm.com
> 
> 5.	Automate generation of the initrd filesystem used for
> 	rcutorture testing.
> 
> 	http://lkml.kernel.org/r/20181111200127.GA9511@linux.ibm.com
> 
> 6.	Convert spin_is_locked() assertions to instead use lockdep.
> 
> 	http://lkml.kernel.org/r/20181111200421.GA10551@linux.ibm.com
> 
> 	Note that several of the patches sent out have been dropped from
> 	this series due to having been pulled in by their respective
> 	maintainers.
> 
> 7.	SRCU updates, especially including a fix from Dennis Krein
> 	for a bag-on-head-class bug.
> 
> 	http://lkml.kernel.org/r/20181111200834.GA10983@linux.ibm.com
> 
> 8.	RCU torture-test updates.
> 
> 	http://lkml.kernel.org/r/20181111201956.GA11935@linux.ibm.com
> 
> All of these changes have been subjected to 0day Test Robot and -next
> testing, and are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git for-mingo
> 
> for you to fetch changes up to 5ac7cdc29897e5fc3f5e214f3f8c8b03ef8d7029:
> 
>   rcutorture: Don't do busted forward-progress testing (2018-12-01 12:45:42 -0800)
> 
> ----------------------------------------------------------------
> Connor Shu (1):
>       rcutorture: Automatically create initrd directory
> 
> Dennis Krein (1):
>       srcu: Lock srcu_data structure in srcu_gp_start()
> 
> Joe Perches (1):
>       checkpatch: Create table of obsolete APIs and apply to RCU
> 
> Joel Fernandes (Google) (19):
>       rcu: Remove unused rcu_state externs
>       rcu: Fix rcu_{node,data} comments about gp_seq_needed
>       doc: Clarify RCU data-structure comment about rcu_tree fanout
>       doc: Remove rcu_preempt_state reference in stallwarn
>       doc: Update information about resched_cpu
>       doc: Remove rcu_dynticks from Data-Structures
>       doc: rcu: Update Data-Structures for RCU flavor consolidation
>       doc: rcu: Better clarify the rcu_segcblist ->len field
>       doc: rcu: Update description of gp_seq fields in rcu_data
>       doc: rcu: Update core and full API in whatisRCU
>       doc: rcu: Add more rationale for using rcu_read_lock_sched in checklist
>       doc: rcu: Remove obsolete suggestion from checklist
>       doc: rcu: Remove obsolete checklist item about synchronize_rcu usage
>       doc: rcu: Encourage use of rcu_barrier in checklist
>       doc: Make reader aware of rcu_dereference_protected
>       doc: Remove obsolete (non-)requirement about disabling preemption
>       doc: Make listing in RCU perf/scale requirements use rcu_assign_pointer()
>       doc: Correct parameter in stallwarn
>       doc: Fix "struction" typo in RCU memory-ordering documentation
> 
> Lance Roy (7):
>       x86/PCI: Replace spin_is_locked() with lockdep
>       sfc: Replace spin_is_locked() with lockdep
>       smsc: Replace spin_is_locked() with lockdep
>       userfaultfd: Replace spin_is_locked() with lockdep
>       locking/mutex: Replace spin_is_locked() with lockdep
>       mm: Replace spin_is_locked() with lockdep
>       KVM: arm/arm64: vgic: Replace spin_is_locked() with lockdep
> 
> Paul E. McKenney (77):
>       rcu: Eliminate BUG_ON() for sync.c
>       rcu: Eliminate BUG_ON() for kernel/rcu/tree.c
>       rcu: Eliminate synchronize_rcu_mult()
>       rcu: Consolidate the RCU update functions invoked by sync.c
>       sched/membarrier: Replace synchronize_sched() with synchronize_rcu()
>       sparc/oprofile: Convert timer_stop() to use synchronize_rcu()
>       s390/mm: Convert tlb_table_flush() to use call_rcu()
>       powerpc: Convert hugepd_free() to use call_rcu()
>       doc: Set down forward-progress requirements
>       rcutorture: Add initrd support for systems lacking dracut
>       rcutorture: Make initrd/init execute in userspace
>       rcutorture: Add cross-compile capability to initrd.sh
>       srcu: Prevent __call_srcu() counter wrap with read-side critical section
>       rcu: Stop expedited grace periods from relying on stop-machine
>       rcu: Eliminate BUG_ON() for kernel/rcu/tree_plugin.h
>       rcu: Eliminate BUG_ON() for kernel/rcu/update.c
>       doc: Document rcutorture forward-progress test kernel parameters
>       doc: RCU scheduler spinlock rcu_read_unlock() restriction remains
>       MAINTAINERS: Update from @linux.vnet.ibm.com to @linux.ibm.com
>       rcu: Avoid double multiply by HZ
>       rcu: Parameterize rcu_check_gp_start_stall()
>       rcu: Add state name to show_rcu_gp_kthreads() output
>       rcu: Add jiffies-since-GP-activity to show_rcu_gp_kthreads()
>       rcu: Trace end of grace period before end of grace period
>       rcu: Speed up expedited GPs when interrupting RCU reader
>       rcu: Replace this_cpu_ptr() with __this_cpu_read()
>       rcu: Avoid signed integer overflow in rcu_preempt_deferred_qs()
>       MAINTAINERS:  Add Joel Fernandes as RCU reviewer
>       checkpatch.pl: Suggest lockdep instead of asserting !spin_is_locked()
>       crypto/pcrypt: Replace synchronize_rcu_bh() with synchronize_rcu()
>       drivers/ipmi: Replace synchronize_sched() with synchronize_rcu()
>       ethernet/sis: Replace synchronize_sched() with synchronize_rcu()
>       ethernet/realtek: Replace synchronize_sched() with synchronize_rcu()
>       drivers/vhost: Replace synchronize_rcu_bh() with synchronize_rcu()
>       cpufreq/intel_pstate: Replace synchronize_sched() with synchronize_rcu()
>       cpufreq/cpufreq_governor: Replace synchronize_sched() with synchronize_rcu()
>       fs/file: Replace synchronize_sched() with synchronize_rcu()
>       tracing: Replace synchronize_sched() and call_rcu_sched()
>       main: Replace rcu_barrier_sched() with rcu_barrier()
>       kprobes: Replace synchronize_sched() with synchronize_rcu()
>       lockdep: Replace synchronize_sched() with synchronize_rcu()
>       sched/membarrier: synchronize_sched() with synchronize_rcu()
>       modules: Replace synchronize_sched() and call_rcu_sched()
>       workqueue: Replace call_rcu_sched() with call_rcu()
>       events: Replace synchronize_sched() with synchronize_rcu()
>       percpu-refcount: Replace call_rcu_sched() with call_rcu()
>       slab: Replace synchronize_sched() with synchronize_rcu()
>       mm: Replace call_rcu_sched() with call_rcu()
>       srcu: Use "ssp" instead of "sp" for srcu_struct pointer
>       net/sched: Replace call_rcu_bh() and rcu_barrier_bh()
>       net/core: Replace call_rcu_bh() and synchronize_rcu_bh()
>       net/bridge: Replace call_rcu_bh() and rcu_barrier_bh()
>       percpu-rwsem: Replace synchronize_sched() with synchronize_rcu()
>       types: Remove call_rcu_bh() and call_rcu_sched()
>       cgroups: Replace synchronize_sched() with synchronize_rcu()
>       livepatch: Replace synchronize_sched() with synchronize_rcu()
>       net/core/skmsg: Replace call_rcu_sched() with call_rcu()
>       net/decnet: Replace rcu_barrier_bh() with rcu_barrier()
>       tools/kernel.h: Replace synchronize_sched() with synchronize_rcu()
>       rcutorture/formal: Replace synchronize_sched() with synchronize_rcu()
>       Merge branches 'bug.2018.11.12a', 'consolidate.2018.12.01a', 'doc.2018.11.12a', 'fixes.2018.11.12a', 'initrd.2018.11.08b', 'sil.2018.11.12a' and 'srcu.2018.11.27a' into HEAD
>       rcutorture: Add call_rcu() flooding forward-progress tests
>       torture: Bring any extra CPUs online during kernel startup
>       rcutorture: Remove cbflood facility
>       rcutorture: Break up too-long rcu_torture_fwd_prog() function
>       rcutorture: Affinity forward-progress test to avoid housekeeping CPUs
>       rcutorture: Prepare for asynchronous access to rcu_fwd_startat
>       rcutorture: Dump grace-period diagnostics upon forward-progress OOM
>       rcu: Account for nocb-CPU callback counts in RCU CPU stall warnings
>       rcu: Print per-CPU callback counts for forward-progress failures
>       rcutorture: Print GP age upon forward-progress failure
>       rcutorture: Print histogram of CB invocation at OOM time
>       rcutorture: Print time since GP end upon forward-progress failure
>       rcutorture: Print forward-progress test age upon failure
>       rcutorture: Recover from OOM during forward-progress tests
>       rcutorture: Use 100ms buckets for forward-progress callback histograms
>       rcutorture: Don't do busted forward-progress testing
> 
> Pierce Griffiths (1):
>       torture: Remove unnecessary "ret" variables
> 
> Randy Dunlap (1):
>       srcu: Fix kernel-doc missing notation
> 
> Willy Tarreau (4):
>       rcutorture: Always strip using the cross-compiler
>       rcutorture: Check initrd/init instead of initrd only
>       rcutorture: Import a copy of nolibc
>       rcutorture: Make use of nolibc when available
> 
> Zhouyi Zhou (1):
>       rcu: Adjust the comment of function rcu_is_watching
> 
>  .../Design/Data-Structures/BigTreeClassicRCUBH.svg |  499 -----
>  .../Data-Structures/BigTreeClassicRCUBHdyntick.svg |  695 -------
>  .../Data-Structures/BigTreePreemptRCUBHdyntick.svg |  741 -------
>  .../BigTreePreemptRCUBHdyntickCB.svg               |  834 +++-----
>  .../Design/Data-Structures/Data-Structures.html    |  173 +-
>  .../RCU/Design/Data-Structures/blkd_task.svg       |  676 +++---
>  .../Expedited-Grace-Periods.html                   |    6 +-
>  .../Memory-Ordering/Tree-RCU-Memory-Ordering.html  |    2 +-
>  .../RCU/Design/Requirements/Requirements.html      |  206 +-
>  Documentation/RCU/checklist.txt                    |   49 +-
>  Documentation/RCU/stallwarn.txt                    |    7 +-
>  Documentation/RCU/whatisRCU.txt                    |   70 +-
>  Documentation/admin-guide/kernel-parameters.txt    |   35 +-
>  MAINTAINERS                                        |   73 +-
>  arch/powerpc/mm/hugetlbpage.c                      |    2 +-
>  arch/s390/mm/pgalloc.c                             |    2 +-
>  arch/sparc/oprofile/init.c                         |    2 +-
>  arch/x86/pci/i386.c                                |    2 +-
>  crypto/pcrypt.c                                    |    2 +-
>  drivers/char/ipmi/ipmi_si_intf.c                   |    2 +-
>  drivers/cpufreq/cpufreq_governor.c                 |    2 +-
>  drivers/cpufreq/intel_pstate.c                     |    2 +-
>  drivers/net/ethernet/realtek/8139too.c             |    2 +-
>  drivers/net/ethernet/realtek/r8169.c               |    4 +-
>  drivers/net/ethernet/sfc/efx.c                     |    2 +-
>  drivers/net/ethernet/sis/sis190.c                  |    2 +-
>  drivers/net/ethernet/smsc/smsc911x.h               |    2 +-
>  drivers/vhost/net.c                                |    2 +-
>  fs/file.c                                          |    2 +-
>  fs/userfaultfd.c                                   |    2 +-
>  include/linux/percpu-rwsem.h                       |    2 +-
>  include/linux/rcupdate_wait.h                      |   17 -
>  include/linux/sched.h                              |    4 +-
>  include/linux/srcu.h                               |   79 +-
>  include/linux/srcutiny.h                           |   24 +-
>  include/linux/srcutree.h                           |    8 +-
>  include/linux/tracepoint.h                         |    2 +-
>  include/linux/types.h                              |    4 +-
>  init/main.c                                        |    6 +-
>  kernel/cgroup/cgroup.c                             |    2 +-
>  kernel/events/core.c                               |    2 +-
>  kernel/kprobes.c                                   |   10 +-
>  kernel/livepatch/patch.c                           |    4 +-
>  kernel/livepatch/transition.c                      |    4 +-
>  kernel/locking/lockdep.c                           |    2 +-
>  kernel/locking/mutex-debug.c                       |    4 +-
>  kernel/module.c                                    |   14 +-
>  kernel/rcu/rcu.h                                   |    4 +
>  kernel/rcu/rcutorture.c                            |  389 ++--
>  kernel/rcu/srcutiny.c                              |  120 +-
>  kernel/rcu/srcutree.c                              |  489 ++---
>  kernel/rcu/sync.c                                  |   25 +-
>  kernel/rcu/tree.c                                  |  114 +-
>  kernel/rcu/tree.h                                  |   18 +-
>  kernel/rcu/tree_exp.h                              |   10 +-
>  kernel/rcu/tree_plugin.h                           |   81 +-
>  kernel/rcu/update.c                                |    9 +-
>  kernel/sched/core.c                                |    2 +-
>  kernel/sched/membarrier.c                          |    6 +-
>  kernel/torture.c                                   |   34 +-
>  kernel/trace/ftrace.c                              |   24 +-
>  kernel/trace/ring_buffer.c                         |   12 +-
>  kernel/trace/trace.c                               |   10 +-
>  kernel/trace/trace_events_filter.c                 |    4 +-
>  kernel/trace/trace_kprobe.c                        |    2 +-
>  kernel/tracepoint.c                                |    4 +-
>  kernel/workqueue.c                                 |    8 +-
>  lib/percpu-refcount.c                              |    2 +-
>  mm/khugepaged.c                                    |    4 +-
>  mm/mmu_gather.c                                    |    2 +-
>  mm/slab.c                                          |    4 +-
>  mm/slab_common.c                                   |    6 +-
>  mm/swap.c                                          |    3 +-
>  net/bridge/br_mdb.c                                |    2 +-
>  net/bridge/br_multicast.c                          |   14 +-
>  net/core/netpoll.c                                 |    4 +-
>  net/core/skmsg.c                                   |    2 +-
>  net/decnet/af_decnet.c                             |    2 +-
>  net/sched/sch_api.c                                |    2 +-
>  net/sched/sch_generic.c                            |    8 +-
>  scripts/checkpatch.pl                              |   35 +
>  tools/include/linux/kernel.h                       |    2 +-
>  tools/testing/selftests/rcutorture/bin/kvm.sh      |    8 +
>  tools/testing/selftests/rcutorture/bin/mkinitrd.sh |  136 ++
>  tools/testing/selftests/rcutorture/bin/nolibc.h    | 2197 ++++++++++++++++++++
>  tools/testing/selftests/rcutorture/doc/initrd.txt  |   99 +-
>  .../formal/srcu-cbmc/include/linux/types.h         |    4 +-
>  virt/kvm/arm/vgic/vgic.c                           |   12 +-
>  88 files changed, 4187 insertions(+), 4014 deletions(-)
>  delete mode 100644 Documentation/RCU/Design/Data-Structures/BigTreeClassicRCUBH.svg
>  delete mode 100644 Documentation/RCU/Design/Data-Structures/BigTreeClassicRCUBHdyntick.svg
>  delete mode 100644 Documentation/RCU/Design/Data-Structures/BigTreePreemptRCUBHdyntick.svg
>  create mode 100755 tools/testing/selftests/rcutorture/bin/mkinitrd.sh
>  create mode 100644 tools/testing/selftests/rcutorture/bin/nolibc.h

Pulled into tip:core/rcu, with the <nolibc.h> caveats below, thanks a lot 
Paul!

I noticed this bit from Willy:

>  tools/testing/selftests/rcutorture/bin/nolibc.h    | 2197 ++++++++++++++++++++

So <nolibc.h> is a rather large header and it comes with very little 
documentation - but once you read through the header it's obvious what it 
does, the code is clean and it's pretty cool all around, and in hindsight 
the name is a strong hint about what the header does as well. ;)

Still it would be nice to at least add a top level description to the 
header to make people (like me) who are reading the code before the 
changelogs wonder less. For tooling headers we require a similar 
self-explanatory, feel-fuzzy structure as for kernel headers.

Beyond adding a bit more documentation it would also be useful to factor 
nolibc.h out into tools/include/nolibc/ or so, no reason to hide it in 
rcutorture, I bet there's a number of other testcases and smaller 
utilities in tools/ that could make good use of it.

My long term hope would be that eventually we could even create a minimal 
klibc from it (a minimal libc provided by the kernel itself), giving 
minimalist binaries a mechanism to link against klibc.so:

- klibc would be an explicit opt-in mechanism, i.e. binaries that are 
  coupled with the kernel anyway (and initrd executables certainly are) 
  could use this.

- We could also add a way for the kernel to provide (non-swappable) 
  binaries via an automatic /klib/ mount point or so. This would allow 
  features like a minimal, console based rescue/debug shell that doesn't 
  rely on any filesystem state or external library dependencies, other 
  than the initial kernel+initrd image.

- In such a scheme klibc would be in /klib/klibc.so, with a mixed
  static/dynamic linking model where klibc.so is linked to a particular 
  static address in all klibc binaries. This would allow executable 
  startup without dynamic linking overhead, there's basically just an 
  mmap() required to map klibc.so. I.e. we would get the best of the two
  worlds: the simplicity and performance of static linking, with the
  low memory overhead and centrally maintained mechanism of dynamic 
  linked libraries.

- klibc would also eventually allow deeper integration with the vDSO 
  proper: for example on klibc based embedded systems we could link klibc
  and the vDSO into a single vDSO library, further simplifying and 
  optimizing it.

- klibc would also allow faster feature propagation from kernel to libc 
  as well, as we could prototype, test and benchmark new system calls and 
  new features on klibc - i.e. klibc integration and testcases could be a
  requirement for new system calls.

- There's no upper limit to how such a minimal kernel-shell (root only) 
  environment would look like, beyond a minimal shell in principle it 
  could include bits like:

    - a minimal editor,

    - a minimal sshd server/client,

    - a minimal 3D graphics and window system:

       - we can use precompiled shaders for the minimal 3D library to 
         run the window system with high speed on modern GPU hardware on 
         GPUs with open-source drivers, such as amdgpu, intel or 
         nouveau,

       - (a minimal font library using a single font, with the supported 
          font sizes rendered at build time, to avoid having to have a 
          minimal vector font library.)

    - a minimal X terminal based on the 3D rendering environment, 
      running the shell and editor,

    - a minimal version of 3D Tetris (just kidding)

    - 3D graphics based perf binary (not kidding: it would have *far* 
      lower display overhead than the current console graphics we are 
      using)

- ... all of which would allow a fully integrated, self-contained (!) 
  solution with no external dependencies other than the build environment 
  to build the binaries, that allows the debugging of a system and the 
  eventual extraction of debug information, without having to interact 
  with the local filesystem or even the local X-window state for these 
  apps to run.

- I.e. a minimal Linux distribution done right, optimized for kernel 
  development, system bootstrap, rescue enviroment, etc. - far more 
  usable than a kdb session.

/me runs

Anyway, back to <nolibc.h>: wanted to ask Linus's and Arnaldo's opinion 
about the merge of it, we can still re-base and re-try if there's any 
objections.

Thanks,

	Ingo
