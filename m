Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B2DC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 00:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9E1C20856
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 00:30:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9E1C20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388600AbeGYBjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 21:39:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50154 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388441AbeGYBjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 21:39:48 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6P0SbZP111375
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 20:30:31 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kee01hj9b-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 20:30:30 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 24 Jul 2018 20:30:29 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 24 Jul 2018 20:30:27 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6P0UQZF7012658
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 25 Jul 2018 00:30:26 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E380B206C;
        Tue, 24 Jul 2018 20:30:09 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B4FBBB205F;
        Tue, 24 Jul 2018 20:30:08 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 24 Jul 2018 20:30:08 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id C7DF516CA330; Tue, 24 Jul 2018 17:30:27 -0700 (PDT)
Date:   Tue, 24 Jul 2018 17:30:27 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, lkp@01.org
Subject: Re: [lkp-robot] [rcutorture]  3398b55446:
 WARNING:possible_recursive_locking_detected
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180724074310.GF19722@shao2-debian>
 <20180724172855.GL12945@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724172855.GL12945@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18072500-0072-0000-0000-0000038563B8
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009424; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01065674; UDB=6.00547441; IPR=6.00843532;
 MB=3.00022308; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-25 00:30:29
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072500-0073-0000-0000-000048D58400
Message-Id: <20180725003027.GA13300@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-24_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807250003
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 10:28:55AM -0700, Paul E. McKenney wrote:
> On Tue, Jul 24, 2018 at 03:43:10PM +0800, kernel test robot wrote:
> > 
> > FYI, we noticed the following commit (built with gcc-7):
> > 
> > commit: 3398b55446fb602245007d5955b6778fb6ff326a ("rcutorture: Handle extended "rcu" read-side critical sections")
> > https://git.kernel.org/cgit/linux/kernel/git/paulmck/linux-rcu.git dev
> > 
> > in testcase: boot
> > 
> > on test machine: qemu-system-x86_64 -enable-kvm -smp 2 -m 512M
> > 
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > 
> > 
> > +---------------------------------------------+------------+------------+
> > |                                             | 6fb6dfca01 | 3398b55446 |
> > +---------------------------------------------+------------+------------+
> > | boot_successes                              | 28         | 4          |
> > | boot_failures                               | 0          | 26         |
> > | WARNING:possible_recursive_locking_detected | 0          | 26         |
> > +---------------------------------------------+------------+------------+
> 
> But this one is all too real!
> 
> Excellent catch, and thank you for your testing efforts!!!
> 
> My rcutorture runs somehow missed this one, but it does require a long
> chain of events to trigger.  Sounds like also a bug in rcutorture.  ;-)

Not yet sure how to fix the rcutorture bug, but I do believe that I have
a fix for the Linux-kernel RCU bug queued.

							Thanx, Paul

> > [   15.516826] WARNING: possible recursive locking detected
> > [   15.518058] 4.18.0-rc5-00173-g3398b55 #1 Not tainted
> > [   15.519215] --------------------------------------------
> > [   15.520008] rcu_torture_rea/78 is trying to acquire lock:
> > [   15.520008] (____ptrval____) (&p->pi_lock){-.-.}, at: try_to_wake_up+0x30/0x317
> > [   15.520008] 
> > [   15.520008] but task is already holding lock:
> > [   15.520008] (____ptrval____) (&p->pi_lock){-.-.}, at: try_to_wake_up+0x30/0x317
> > [   15.520008] 
> > [   15.520008] other info that might help us debug this:
> > [   15.520008]  Possible unsafe locking scenario:
> > [   15.520008] 
> > [   15.520008]        CPU0
> > [   15.520008]        ----
> > [   15.520008]   lock(&p->pi_lock);
> > [   15.520008]   lock(&p->pi_lock);
> > [   15.520008] 
> > [   15.520008]  *** DEADLOCK ***
> > [   15.520008] 
> > [   15.520008]  May be due to missing lock nesting notation
> > [   15.520008] 
> > [   15.520008] 2 locks held by rcu_torture_rea/78:
> > [   15.520008]  #0: (____ptrval____) (&p->pi_lock){-.-.}, at: try_to_wake_up+0x30/0x317
> > [   15.520008]  #1: (____ptrval____) (rcu_read_lock){....}, at: select_task_rq_rt+0x1a/0x152
> > [   15.520008] 
> > [   15.520008] stack backtrace:
> > [   15.520008] CPU: 1 PID: 78 Comm: rcu_torture_rea Not tainted 4.18.0-rc5-00173-g3398b55 #1
> > [   15.520008] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> > [   15.520008] Call Trace:
> > [   15.520008]  dump_stack+0xc4/0x117
> > [   15.520008]  __lock_acquire+0x806/0xf26
> > [   15.520008]  ? kvm_clock_read+0x23/0x33
> > [   15.520008]  lock_acquire+0x70/0x9f
> > [   15.520008]  ? try_to_wake_up+0x30/0x317
> > [   15.520008]  _raw_spin_lock_irqsave+0x62/0x9d
> > [   15.520008]  ? try_to_wake_up+0x30/0x317
> > [   15.520008]  try_to_wake_up+0x30/0x317
> > [   15.520008]  ? __lock_acquire+0x2d7/0xf26
> > [   15.520008]  wake_up_process+0x10/0x12
> > [   15.520008]  wakeup_softirqd+0x2b/0x2d
> > [   15.520008]  raise_softirq_irqoff+0x1c/0x1e
> > [   15.520008]  rcu_read_unlock_special+0x7b/0xca
> > [   15.520008]  __rcu_read_unlock+0x3f/0x5b
> > [   15.520008]  select_task_rq_rt+0x127/0x152
> > [   15.520008]  try_to_wake_up+0x16c/0x317
> > [   15.520008]  wake_up_process+0x10/0x12
> > [   15.520008]  rcu_initiate_boost+0xa3/0xb5
> > [   15.520008]  __rcu_report_exp_rnp+0x3f/0xc3
> > [   15.520008]  rcu_report_exp_cpu_mult+0x59/0x62
> > [   15.520008]  rcu_report_exp_rdp+0x1a/0x1c
> > [   15.520008]  rcu_preempt_deferred_qs_irqrestore+0xec/0x382
> > [   15.520008]  rcu_preempt_deferred_qs+0x4c/0x51
> > [   15.520008]  rcu_note_context_switch+0x360/0x3d0
> > [   15.520008]  __schedule+0x186/0x7ad
> > [   15.520008]  ? preempt_schedule+0x30/0x32
> > [   15.520008]  ? rcutorture_one_extend+0xce/0x178
> > [   15.520008]  preempt_schedule_common+0x65/0x7f
> > [   15.520008]  preempt_schedule+0x30/0x32
> > [   15.520008]  ___preempt_schedule+0x16/0x18
> > [   15.520008]  __local_bh_enable_ip+0xf5/0xfa
> > [   15.520008]  rcutorture_one_extend+0xdf/0x178
> > [   15.520008]  rcu_torture_one_read+0x26e/0x287
> > [   15.520008]  ? rcu_torture_one_read+0x287/0x287
> > [   15.520008]  rcu_torture_reader+0xd2/0x131
> > [   15.520008]  ? rcu_busted_torture_deferred_free+0xb/0xb
> > [   15.520008]  ? __kthread_parkme+0x47/0x7c
> > [   15.520008]  kthread+0x125/0x12d
> > [   15.520008]  ? rcu_torture_one_read+0x287/0x287
> > [   15.520008]  ? kthread+0x125/0x12d
> > [   15.520008]  ? kthread_flush_work_fn+0xf/0xf
> > [   15.520008]  ret_from_fork+0x3a/0x50
> > [   51.562859] [drm] Initialized vgem 1.0.0 20120112 for virtual device on minor 0
> > [   51.566668] Silicon Labs C2 port support v. 0.51.0 - (C) 2007 Rodolfo Giometti
> > [   51.569287] usbcore: registered new interface driver viperboard
> > [   51.571011] usbcore: registered new interface driver dln2
> > [   51.572479] Uniform Multi-Platform E-IDE driver
> > [   51.574488] ide-gd driver 1.18
> > [   51.600600] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-NAPI
> > [   51.601993] e1000: Copyright (c) 1999-2006 Intel Corporation.
> > [   51.785059] PCI Interrupt Link [LNKC] enabled at IRQ 11
> > [   52.234347] e1000 0000:00:03.0 eth0: (PCI:33MHz:32-bit) 52:54:00:12:34:56
> > [   52.255507] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connection
> > [   52.256896] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
> > [   52.258046] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
> > [   52.259434] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.4.0-k
> > [   52.260805] igb: Copyright (c) 2007-2014 Intel Corporation.
> > [   52.261961] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver - version 5.1.0-k
> > [   52.263751] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
> > [   52.287160] usbcore: registered new interface driver hwa-rc
> > [   52.288320] usbcore: registered new interface driver i1480-dfu-usb
> > [   52.289967] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> > [   52.291304] ehci-pci: EHCI PCI platform driver
> > [   52.292268] ehci-platform: EHCI generic platform driver
> > [   52.293463] usbcore: registered new interface driver hwa-hc
> > [   52.294591] fotg210_hcd: FOTG210 Host Controller (EHCI) Driver
> > [   52.308853] usbcore: registered new interface driver wusb-cbaf
> > [   52.310075] usbcore: registered new interface driver cdc_acm
> > [   52.311213] cdc_acm: USB Abstract Control Model driver for USB modems and ISDN adapters
> > [   52.312838] usbcore: registered new interface driver usblp
> > [   52.314096] usbcore: registered new interface driver usbtmc
> > [   52.315287] usbcore: registered new interface driver mdc800
> > 
> > 
> > To reproduce:
> > 
> >         git clone https://github.com/intel/lkp-tests.git
> >         cd lkp-tests
> >         bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email
> > 
> > 
> > 
> > Thanks,
> > Rong, Chen
> 
> > #
> > # Automatically generated file; DO NOT EDIT.
> > # Linux/x86_64 4.18.0-rc5 Kernel Configuration
> > #
> > 
> > #
> > # Compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
> > #
> > CONFIG_64BIT=y
> > CONFIG_X86_64=y
> > CONFIG_X86=y
> > CONFIG_INSTRUCTION_DECODER=y
> > CONFIG_OUTPUT_FORMAT="elf64-x86-64"
> > CONFIG_ARCH_DEFCONFIG="arch/x86/configs/x86_64_defconfig"
> > CONFIG_LOCKDEP_SUPPORT=y
> > CONFIG_STACKTRACE_SUPPORT=y
> > CONFIG_MMU=y
> > CONFIG_ARCH_MMAP_RND_BITS_MIN=28
> > CONFIG_ARCH_MMAP_RND_BITS_MAX=32
> > CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
> > CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
> > CONFIG_GENERIC_ISA_DMA=y
> > CONFIG_GENERIC_BUG=y
> > CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
> > CONFIG_GENERIC_HWEIGHT=y
> > CONFIG_ARCH_MAY_HAVE_PC_FDC=y
> > CONFIG_RWSEM_XCHGADD_ALGORITHM=y
> > CONFIG_GENERIC_CALIBRATE_DELAY=y
> > CONFIG_ARCH_HAS_CPU_RELAX=y
> > CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
> > CONFIG_ARCH_HAS_FILTER_PGPROT=y
> > CONFIG_HAVE_SETUP_PER_CPU_AREA=y
> > CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
> > CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
> > CONFIG_ARCH_HIBERNATION_POSSIBLE=y
> > CONFIG_ARCH_SUSPEND_POSSIBLE=y
> > CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
> > CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
> > CONFIG_ZONE_DMA32=y
> > CONFIG_AUDIT_ARCH=y
> > CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
> > CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
> > CONFIG_X86_64_SMP=y
> > CONFIG_ARCH_SUPPORTS_UPROBES=y
> > CONFIG_FIX_EARLYCON_MEM=y
> > CONFIG_DYNAMIC_PHYSICAL_MASK=y
> > CONFIG_PGTABLE_LEVELS=4
> > CONFIG_CC_IS_GCC=y
> > CONFIG_GCC_VERSION=70300
> > CONFIG_CLANG_VERSION=0
> > CONFIG_CONSTRUCTORS=y
> > CONFIG_IRQ_WORK=y
> > CONFIG_BUILDTIME_EXTABLE_SORT=y
> > CONFIG_THREAD_INFO_IN_TASK=y
> > 
> > #
> > # General setup
> > #
> > CONFIG_INIT_ENV_ARG_LIMIT=32
> > # CONFIG_COMPILE_TEST is not set
> > CONFIG_LOCALVERSION=""
> > CONFIG_LOCALVERSION_AUTO=y
> > CONFIG_HAVE_KERNEL_GZIP=y
> > CONFIG_HAVE_KERNEL_BZIP2=y
> > CONFIG_HAVE_KERNEL_LZMA=y
> > CONFIG_HAVE_KERNEL_XZ=y
> > CONFIG_HAVE_KERNEL_LZO=y
> > CONFIG_HAVE_KERNEL_LZ4=y
> > # CONFIG_KERNEL_GZIP is not set
> > # CONFIG_KERNEL_BZIP2 is not set
> > CONFIG_KERNEL_LZMA=y
> > # CONFIG_KERNEL_XZ is not set
> > # CONFIG_KERNEL_LZO is not set
> > # CONFIG_KERNEL_LZ4 is not set
> > CONFIG_DEFAULT_HOSTNAME="(none)"
> > CONFIG_SWAP=y
> > CONFIG_SYSVIPC=y
> > CONFIG_SYSVIPC_SYSCTL=y
> > # CONFIG_POSIX_MQUEUE is not set
> > CONFIG_CROSS_MEMORY_ATTACH=y
> > CONFIG_USELIB=y
> > # CONFIG_AUDIT is not set
> > CONFIG_HAVE_ARCH_AUDITSYSCALL=y
> > 
> > #
> > # IRQ subsystem
> > #
> > CONFIG_GENERIC_IRQ_PROBE=y
> > CONFIG_GENERIC_IRQ_SHOW=y
> > CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
> > CONFIG_GENERIC_PENDING_IRQ=y
> > CONFIG_GENERIC_IRQ_MIGRATION=y
> > CONFIG_GENERIC_IRQ_CHIP=y
> > CONFIG_IRQ_DOMAIN=y
> > CONFIG_IRQ_SIM=y
> > CONFIG_IRQ_DOMAIN_HIERARCHY=y
> > CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
> > CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
> > CONFIG_IRQ_FORCED_THREADING=y
> > CONFIG_SPARSE_IRQ=y
> > # CONFIG_GENERIC_IRQ_DEBUGFS is not set
> > CONFIG_CLOCKSOURCE_WATCHDOG=y
> > CONFIG_ARCH_CLOCKSOURCE_DATA=y
> > CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
> > CONFIG_GENERIC_TIME_VSYSCALL=y
> > CONFIG_GENERIC_CLOCKEVENTS=y
> > CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
> > CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
> > CONFIG_GENERIC_CMOS_UPDATE=y
> > 
> > #
> > # Timers subsystem
> > #
> > CONFIG_TICK_ONESHOT=y
> > CONFIG_HZ_PERIODIC=y
> > # CONFIG_NO_HZ_IDLE is not set
> > # CONFIG_NO_HZ_FULL is not set
> > CONFIG_NO_HZ=y
> > CONFIG_HIGH_RES_TIMERS=y
> > 
> > #
> > # CPU/Task time and stats accounting
> > #
> > CONFIG_VIRT_CPU_ACCOUNTING=y
> > # CONFIG_TICK_CPU_ACCOUNTING is not set
> > CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
> > CONFIG_IRQ_TIME_ACCOUNTING=y
> > CONFIG_BSD_PROCESS_ACCT=y
> > CONFIG_BSD_PROCESS_ACCT_V3=y
> > # CONFIG_TASKSTATS is not set
> > CONFIG_CPU_ISOLATION=y
> > 
> > #
> > # RCU Subsystem
> > #
> > CONFIG_PREEMPT_RCU=y
> > CONFIG_RCU_EXPERT=y
> > CONFIG_SRCU=y
> > CONFIG_TREE_SRCU=y
> > CONFIG_TASKS_RCU=y
> > CONFIG_RCU_STALL_COMMON=y
> > CONFIG_RCU_NEED_SEGCBLIST=y
> > CONFIG_CONTEXT_TRACKING=y
> > CONFIG_CONTEXT_TRACKING_FORCE=y
> > CONFIG_RCU_FANOUT=64
> > CONFIG_RCU_FANOUT_LEAF=16
> > CONFIG_RCU_BOOST=y
> > CONFIG_RCU_BOOST_DELAY=500
> > # CONFIG_RCU_NOCB_CPU is not set
> > CONFIG_BUILD_BIN2C=y
> > CONFIG_IKCONFIG=y
> > CONFIG_IKCONFIG_PROC=y
> > CONFIG_LOG_BUF_SHIFT=20
> > CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
> > CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
> > CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
> > CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
> > CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
> > CONFIG_ARCH_SUPPORTS_INT128=y
> > CONFIG_CGROUPS=y
> > # CONFIG_MEMCG is not set
> > # CONFIG_BLK_CGROUP is not set
> > CONFIG_CGROUP_SCHED=y
> > CONFIG_FAIR_GROUP_SCHED=y
> > CONFIG_CFS_BANDWIDTH=y
> > CONFIG_RT_GROUP_SCHED=y
> > # CONFIG_CGROUP_PIDS is not set
> > CONFIG_CGROUP_RDMA=y
> > # CONFIG_CGROUP_FREEZER is not set
> > CONFIG_CPUSETS=y
> > # CONFIG_PROC_PID_CPUSET is not set
> > # CONFIG_CGROUP_DEVICE is not set
> > # CONFIG_CGROUP_CPUACCT is not set
> > CONFIG_CGROUP_PERF=y
> > CONFIG_CGROUP_DEBUG=y
> > CONFIG_NAMESPACES=y
> > # CONFIG_UTS_NS is not set
> > CONFIG_IPC_NS=y
> > # CONFIG_USER_NS is not set
> > # CONFIG_PID_NS is not set
> > CONFIG_NET_NS=y
> > # CONFIG_SCHED_AUTOGROUP is not set
> > # CONFIG_SYSFS_DEPRECATED is not set
> > CONFIG_RELAY=y
> > CONFIG_BLK_DEV_INITRD=y
> > CONFIG_INITRAMFS_SOURCE=""
> > CONFIG_RD_GZIP=y
> > # CONFIG_RD_BZIP2 is not set
> > CONFIG_RD_LZMA=y
> > # CONFIG_RD_XZ is not set
> > CONFIG_RD_LZO=y
> > # CONFIG_RD_LZ4 is not set
> > # CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
> > CONFIG_CC_OPTIMIZE_FOR_SIZE=y
> > CONFIG_SYSCTL=y
> > CONFIG_ANON_INODES=y
> > CONFIG_SYSCTL_EXCEPTION_TRACE=y
> > CONFIG_HAVE_PCSPKR_PLATFORM=y
> > CONFIG_BPF=y
> > # CONFIG_EXPERT is not set
> > CONFIG_MULTIUSER=y
> > CONFIG_SGETMASK_SYSCALL=y
> > CONFIG_SYSFS_SYSCALL=y
> > CONFIG_FHANDLE=y
> > CONFIG_POSIX_TIMERS=y
> > CONFIG_PRINTK=y
> > CONFIG_PRINTK_NMI=y
> > CONFIG_BUG=y
> > CONFIG_ELF_CORE=y
> > CONFIG_PCSPKR_PLATFORM=y
> > CONFIG_BASE_FULL=y
> > CONFIG_FUTEX=y
> > CONFIG_FUTEX_PI=y
> > CONFIG_EPOLL=y
> > CONFIG_SIGNALFD=y
> > CONFIG_TIMERFD=y
> > CONFIG_EVENTFD=y
> > CONFIG_SHMEM=y
> > CONFIG_AIO=y
> > CONFIG_ADVISE_SYSCALLS=y
> > CONFIG_MEMBARRIER=y
> > CONFIG_KALLSYMS=y
> > CONFIG_KALLSYMS_ALL=y
> > CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
> > CONFIG_KALLSYMS_BASE_RELATIVE=y
> > # CONFIG_BPF_SYSCALL is not set
> > # CONFIG_USERFAULTFD is not set
> > CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
> > CONFIG_RSEQ=y
> > # CONFIG_EMBEDDED is not set
> > CONFIG_HAVE_PERF_EVENTS=y
> > 
> > #
> > # Kernel Performance Events And Counters
> > #
> > CONFIG_PERF_EVENTS=y
> > # CONFIG_DEBUG_PERF_USE_VMALLOC is not set
> > CONFIG_VM_EVENT_COUNTERS=y
> > # CONFIG_COMPAT_BRK is not set
> > CONFIG_SLAB=y
> > # CONFIG_SLUB is not set
> > # CONFIG_SLAB_MERGE_DEFAULT is not set
> > # CONFIG_SLAB_FREELIST_RANDOM is not set
> > # CONFIG_PROFILING is not set
> > CONFIG_HAVE_OPROFILE=y
> > CONFIG_OPROFILE_NMI_TIMER=y
> > # CONFIG_JUMP_LABEL is not set
> > CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
> > CONFIG_ARCH_USE_BUILTIN_BSWAP=y
> > CONFIG_HAVE_IOREMAP_PROT=y
> > CONFIG_HAVE_KPROBES=y
> > CONFIG_HAVE_KRETPROBES=y
> > CONFIG_HAVE_OPTPROBES=y
> > CONFIG_HAVE_KPROBES_ON_FTRACE=y
> > CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
> > CONFIG_HAVE_NMI=y
> > CONFIG_HAVE_ARCH_TRACEHOOK=y
> > CONFIG_HAVE_DMA_CONTIGUOUS=y
> > CONFIG_GENERIC_SMP_IDLE_THREAD=y
> > CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
> > CONFIG_ARCH_HAS_SET_MEMORY=y
> > CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
> > CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
> > CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
> > CONFIG_HAVE_RSEQ=y
> > CONFIG_HAVE_CLK=y
> > CONFIG_HAVE_HW_BREAKPOINT=y
> > CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
> > CONFIG_HAVE_USER_RETURN_NOTIFIER=y
> > CONFIG_HAVE_PERF_EVENTS_NMI=y
> > CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
> > CONFIG_HAVE_PERF_REGS=y
> > CONFIG_HAVE_PERF_USER_STACK_DUMP=y
> > CONFIG_HAVE_ARCH_JUMP_LABEL=y
> > CONFIG_HAVE_RCU_TABLE_FREE=y
> > CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
> > CONFIG_HAVE_CMPXCHG_LOCAL=y
> > CONFIG_HAVE_CMPXCHG_DOUBLE=y
> > CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
> > CONFIG_SECCOMP_FILTER=y
> > CONFIG_PLUGIN_HOSTCC="g++"
> > CONFIG_HAVE_GCC_PLUGINS=y
> > CONFIG_GCC_PLUGINS=y
> > # CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
> > CONFIG_GCC_PLUGIN_STRUCTLEAK=y
> > # CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL is not set
> > # CONFIG_GCC_PLUGIN_STRUCTLEAK_VERBOSE is not set
> > # CONFIG_GCC_PLUGIN_RANDSTRUCT is not set
> > CONFIG_HAVE_STACKPROTECTOR=y
> > CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
> > # CONFIG_STACKPROTECTOR is not set
> > CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
> > CONFIG_HAVE_CONTEXT_TRACKING=y
> > CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
> > CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
> > CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
> > CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
> > CONFIG_HAVE_ARCH_HUGE_VMAP=y
> > CONFIG_HAVE_ARCH_SOFT_DIRTY=y
> > CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
> > CONFIG_MODULES_USE_ELF_RELA=y
> > CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
> > CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
> > CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
> > CONFIG_HAVE_EXIT_THREAD=y
> > CONFIG_ARCH_MMAP_RND_BITS=28
> > CONFIG_HAVE_COPY_THREAD_TLS=y
> > CONFIG_HAVE_STACK_VALIDATION=y
> > CONFIG_HAVE_RELIABLE_STACKTRACE=y
> > CONFIG_ISA_BUS_API=y
> > CONFIG_HAVE_ARCH_VMAP_STACK=y
> > CONFIG_VMAP_STACK=y
> > CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
> > CONFIG_STRICT_KERNEL_RWX=y
> > CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
> > CONFIG_ARCH_HAS_REFCOUNT=y
> > # CONFIG_REFCOUNT_FULL is not set
> > 
> > #
> > # GCOV-based kernel profiling
> > #
> > CONFIG_GCOV_KERNEL=y
> > CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
> > # CONFIG_GCOV_PROFILE_ALL is not set
> > CONFIG_GCOV_FORMAT_4_7=y
> > CONFIG_RT_MUTEXES=y
> > CONFIG_BASE_SMALL=0
> > # CONFIG_MODULES is not set
> > CONFIG_MODULES_TREE_LOOKUP=y
> > CONFIG_BLOCK=y
> > CONFIG_BLK_SCSI_REQUEST=y
> > CONFIG_BLK_DEV_BSG=y
> > # CONFIG_BLK_DEV_BSGLIB is not set
> > CONFIG_BLK_DEV_INTEGRITY=y
> > CONFIG_BLK_DEV_ZONED=y
> > CONFIG_BLK_CMDLINE_PARSER=y
> > CONFIG_BLK_WBT=y
> > # CONFIG_BLK_WBT_SQ is not set
> > CONFIG_BLK_WBT_MQ=y
> > # CONFIG_BLK_DEBUG_FS is not set
> > # CONFIG_BLK_SED_OPAL is not set
> > 
> > #
> > # Partition Types
> > #
> > # CONFIG_PARTITION_ADVANCED is not set
> > CONFIG_MSDOS_PARTITION=y
> > CONFIG_EFI_PARTITION=y
> > CONFIG_BLK_MQ_PCI=y
> > CONFIG_BLK_MQ_VIRTIO=y
> > 
> > #
> > # IO Schedulers
> > #
> > CONFIG_IOSCHED_NOOP=y
> > # CONFIG_IOSCHED_DEADLINE is not set
> > CONFIG_IOSCHED_CFQ=y
> > CONFIG_DEFAULT_CFQ=y
> > # CONFIG_DEFAULT_NOOP is not set
> > CONFIG_DEFAULT_IOSCHED="cfq"
> > CONFIG_MQ_IOSCHED_DEADLINE=y
> > CONFIG_MQ_IOSCHED_KYBER=y
> > # CONFIG_IOSCHED_BFQ is not set
> > CONFIG_PADATA=y
> > CONFIG_ASN1=y
> > CONFIG_UNINLINE_SPIN_UNLOCK=y
> > CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
> > CONFIG_MUTEX_SPIN_ON_OWNER=y
> > CONFIG_RWSEM_SPIN_ON_OWNER=y
> > CONFIG_LOCK_SPIN_ON_OWNER=y
> > CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
> > CONFIG_QUEUED_SPINLOCKS=y
> > CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
> > CONFIG_QUEUED_RWLOCKS=y
> > CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
> > CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
> > CONFIG_CC_HAS_SANE_STACKPROTECTOR=y
> > CONFIG_FREEZER=y
> > 
> > #
> > # Processor type and features
> > #
> > CONFIG_ZONE_DMA=y
> > CONFIG_SMP=y
> > CONFIG_X86_FEATURE_NAMES=y
> > # CONFIG_X86_X2APIC is not set
> > CONFIG_X86_MPPARSE=y
> > CONFIG_GOLDFISH=y
> > CONFIG_RETPOLINE=y
> > CONFIG_INTEL_RDT=y
> > # CONFIG_X86_EXTENDED_PLATFORM is not set
> > # CONFIG_X86_INTEL_LPSS is not set
> > # CONFIG_X86_AMD_PLATFORM_DEVICE is not set
> > # CONFIG_IOSF_MBI is not set
> > # CONFIG_SCHED_OMIT_FRAME_POINTER is not set
> > CONFIG_HYPERVISOR_GUEST=y
> > CONFIG_PARAVIRT=y
> > CONFIG_PARAVIRT_DEBUG=y
> > # CONFIG_PARAVIRT_SPINLOCKS is not set
> > # CONFIG_XEN is not set
> > CONFIG_KVM_GUEST=y
> > CONFIG_KVM_DEBUG_FS=y
> > CONFIG_PARAVIRT_TIME_ACCOUNTING=y
> > CONFIG_PARAVIRT_CLOCK=y
> > # CONFIG_JAILHOUSE_GUEST is not set
> > CONFIG_NO_BOOTMEM=y
> > # CONFIG_MK8 is not set
> > # CONFIG_MPSC is not set
> > # CONFIG_MCORE2 is not set
> > # CONFIG_MATOM is not set
> > CONFIG_GENERIC_CPU=y
> > CONFIG_X86_INTERNODE_CACHE_SHIFT=6
> > CONFIG_X86_L1_CACHE_SHIFT=6
> > CONFIG_X86_TSC=y
> > CONFIG_X86_CMPXCHG64=y
> > CONFIG_X86_CMOV=y
> > CONFIG_X86_MINIMUM_CPU_FAMILY=64
> > CONFIG_X86_DEBUGCTLMSR=y
> > CONFIG_CPU_SUP_INTEL=y
> > CONFIG_CPU_SUP_AMD=y
> > CONFIG_CPU_SUP_CENTAUR=y
> > CONFIG_HPET_TIMER=y
> > CONFIG_DMI=y
> > # CONFIG_GART_IOMMU is not set
> > # CONFIG_CALGARY_IOMMU is not set
> > # CONFIG_MAXSMP is not set
> > CONFIG_NR_CPUS_RANGE_BEGIN=2
> > CONFIG_NR_CPUS_RANGE_END=512
> > CONFIG_NR_CPUS_DEFAULT=64
> > CONFIG_NR_CPUS=64
> > CONFIG_SCHED_SMT=y
> > # CONFIG_SCHED_MC is not set
> > # CONFIG_PREEMPT_NONE is not set
> > # CONFIG_PREEMPT_VOLUNTARY is not set
> > CONFIG_PREEMPT=y
> > CONFIG_PREEMPT_COUNT=y
> > CONFIG_X86_LOCAL_APIC=y
> > CONFIG_X86_IO_APIC=y
> > CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
> > # CONFIG_X86_MCE is not set
> > 
> > #
> > # Performance monitoring
> > #
> > CONFIG_PERF_EVENTS_INTEL_UNCORE=y
> > CONFIG_PERF_EVENTS_INTEL_RAPL=y
> > CONFIG_PERF_EVENTS_INTEL_CSTATE=y
> > # CONFIG_PERF_EVENTS_AMD_POWER is not set
> > CONFIG_X86_16BIT=y
> > CONFIG_X86_ESPFIX64=y
> > CONFIG_X86_VSYSCALL_EMULATION=y
> > # CONFIG_I8K is not set
> > CONFIG_MICROCODE=y
> > CONFIG_MICROCODE_INTEL=y
> > CONFIG_MICROCODE_AMD=y
> > CONFIG_MICROCODE_OLD_INTERFACE=y
> > # CONFIG_X86_MSR is not set
> > CONFIG_X86_CPUID=y
> > # CONFIG_X86_5LEVEL is not set
> > CONFIG_ARCH_HAS_MEM_ENCRYPT=y
> > CONFIG_AMD_MEM_ENCRYPT=y
> > CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT=y
> > CONFIG_ARCH_USE_MEMREMAP_PROT=y
> > # CONFIG_NUMA is not set
> > CONFIG_ARCH_SPARSEMEM_ENABLE=y
> > CONFIG_ARCH_SPARSEMEM_DEFAULT=y
> > CONFIG_ARCH_SELECT_MEMORY_MODEL=y
> > # CONFIG_ARCH_MEMORY_PROBE is not set
> > CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
> > CONFIG_SELECT_MEMORY_MODEL=y
> > CONFIG_SPARSEMEM_MANUAL=y
> > CONFIG_SPARSEMEM=y
> > CONFIG_HAVE_MEMORY_PRESENT=y
> > CONFIG_SPARSEMEM_EXTREME=y
> > CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
> > CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER=y
> > CONFIG_SPARSEMEM_VMEMMAP=y
> > CONFIG_HAVE_MEMBLOCK=y
> > CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
> > CONFIG_HAVE_GENERIC_GUP=y
> > CONFIG_ARCH_DISCARD_MEMBLOCK=y
> > CONFIG_MEMORY_ISOLATION=y
> > CONFIG_HAVE_BOOTMEM_INFO_NODE=y
> > CONFIG_MEMORY_HOTPLUG=y
> > CONFIG_MEMORY_HOTPLUG_SPARSE=y
> > CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=y
> > CONFIG_MEMORY_HOTREMOVE=y
> > CONFIG_SPLIT_PTLOCK_CPUS=4
> > CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
> > CONFIG_COMPACTION=y
> > CONFIG_MIGRATION=y
> > CONFIG_ARCH_ENABLE_THP_MIGRATION=y
> > CONFIG_PHYS_ADDR_T_64BIT=y
> > CONFIG_BOUNCE=y
> > CONFIG_VIRT_TO_BUS=y
> > # CONFIG_KSM is not set
> > CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
> > CONFIG_TRANSPARENT_HUGEPAGE=y
> > # CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
> > CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
> > CONFIG_ARCH_WANTS_THP_SWAP=y
> > CONFIG_THP_SWAP=y
> > CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
> > # CONFIG_CLEANCACHE is not set
> > # CONFIG_FRONTSWAP is not set
> > CONFIG_CMA=y
> > # CONFIG_CMA_DEBUG is not set
> > # CONFIG_CMA_DEBUGFS is not set
> > CONFIG_CMA_AREAS=7
> > CONFIG_ZPOOL=y
> > CONFIG_ZBUD=y
> > CONFIG_Z3FOLD=y
> > # CONFIG_ZSMALLOC is not set
> > CONFIG_GENERIC_EARLY_IOREMAP=y
> > # CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
> > CONFIG_IDLE_PAGE_TRACKING=y
> > CONFIG_ARCH_HAS_ZONE_DEVICE=y
> > # CONFIG_ZONE_DEVICE is not set
> > CONFIG_FRAME_VECTOR=y
> > CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
> > CONFIG_ARCH_HAS_PKEYS=y
> > # CONFIG_PERCPU_STATS is not set
> > CONFIG_GUP_BENCHMARK=y
> > CONFIG_ARCH_HAS_PTE_SPECIAL=y
> > # CONFIG_X86_PMEM_LEGACY is not set
> > CONFIG_X86_CHECK_BIOS_CORRUPTION=y
> > CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=y
> > CONFIG_X86_RESERVE_LOW=64
> > CONFIG_MTRR=y
> > CONFIG_MTRR_SANITIZER=y
> > CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
> > CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
> > CONFIG_X86_PAT=y
> > CONFIG_ARCH_USES_PG_UNCACHED=y
> > CONFIG_ARCH_RANDOM=y
> > CONFIG_X86_SMAP=y
> > CONFIG_X86_INTEL_UMIP=y
> > # CONFIG_X86_INTEL_MPX is not set
> > CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
> > # CONFIG_EFI is not set
> > CONFIG_SECCOMP=y
> > CONFIG_HZ_100=y
> > # CONFIG_HZ_250 is not set
> > # CONFIG_HZ_300 is not set
> > # CONFIG_HZ_1000 is not set
> > CONFIG_HZ=100
> > CONFIG_SCHED_HRTICK=y
> > # CONFIG_KEXEC is not set
> > # CONFIG_KEXEC_FILE is not set
> > # CONFIG_CRASH_DUMP is not set
> > CONFIG_PHYSICAL_START=0x1000000
> > # CONFIG_RELOCATABLE is not set
> > CONFIG_PHYSICAL_ALIGN=0x200000
> > CONFIG_HOTPLUG_CPU=y
> > CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
> > CONFIG_DEBUG_HOTPLUG_CPU0=y
> > CONFIG_LEGACY_VSYSCALL_EMULATE=y
> > # CONFIG_LEGACY_VSYSCALL_NONE is not set
> > # CONFIG_CMDLINE_BOOL is not set
> > CONFIG_MODIFY_LDT_SYSCALL=y
> > CONFIG_HAVE_LIVEPATCH=y
> > CONFIG_ARCH_HAS_ADD_PAGES=y
> > CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
> > CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
> > 
> > #
> > # Power management and ACPI options
> > #
> > CONFIG_ARCH_HIBERNATION_HEADER=y
> > # CONFIG_SUSPEND is not set
> > CONFIG_HIBERNATE_CALLBACKS=y
> > CONFIG_HIBERNATION=y
> > CONFIG_PM_STD_PARTITION=""
> > CONFIG_PM_SLEEP=y
> > CONFIG_PM_SLEEP_SMP=y
> > CONFIG_PM_AUTOSLEEP=y
> > # CONFIG_PM_WAKELOCKS is not set
> > CONFIG_PM=y
> > # CONFIG_PM_DEBUG is not set
> > CONFIG_PM_CLK=y
> > CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
> > CONFIG_ACPI=y
> > CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
> > CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
> > CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
> > # CONFIG_ACPI_DEBUGGER is not set
> > CONFIG_ACPI_SPCR_TABLE=y
> > CONFIG_ACPI_LPIT=y
> > CONFIG_ACPI_SLEEP=y
> > # CONFIG_ACPI_PROCFS_POWER is not set
> > CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
> > # CONFIG_ACPI_EC_DEBUGFS is not set
> > CONFIG_ACPI_AC=y
> > CONFIG_ACPI_BATTERY=y
> > CONFIG_ACPI_BUTTON=y
> > # CONFIG_ACPI_VIDEO is not set
> > CONFIG_ACPI_FAN=y
> > # CONFIG_ACPI_TAD is not set
> > # CONFIG_ACPI_DOCK is not set
> > CONFIG_ACPI_CPU_FREQ_PSS=y
> > CONFIG_ACPI_PROCESSOR_CSTATE=y
> > CONFIG_ACPI_PROCESSOR_IDLE=y
> > CONFIG_ACPI_PROCESSOR=y
> > CONFIG_ACPI_HOTPLUG_CPU=y
> > # CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
> > CONFIG_ACPI_THERMAL=y
> > CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
> > CONFIG_ACPI_TABLE_UPGRADE=y
> > # CONFIG_ACPI_DEBUG is not set
> > # CONFIG_ACPI_PCI_SLOT is not set
> > CONFIG_ACPI_CONTAINER=y
> > # CONFIG_ACPI_HOTPLUG_MEMORY is not set
> > CONFIG_ACPI_HOTPLUG_IOAPIC=y
> > # CONFIG_ACPI_SBS is not set
> > # CONFIG_ACPI_HED is not set
> > # CONFIG_ACPI_CUSTOM_METHOD is not set
> > # CONFIG_ACPI_NFIT is not set
> > CONFIG_HAVE_ACPI_APEI=y
> > CONFIG_HAVE_ACPI_APEI_NMI=y
> > # CONFIG_ACPI_APEI is not set
> > # CONFIG_DPTF_POWER is not set
> > # CONFIG_PMIC_OPREGION is not set
> > # CONFIG_ACPI_CONFIGFS is not set
> > CONFIG_X86_PM_TIMER=y
> > CONFIG_SFI=y
> > 
> > #
> > # CPU Frequency scaling
> > #
> > # CONFIG_CPU_FREQ is not set
> > 
> > #
> > # CPU Idle
> > #
> > CONFIG_CPU_IDLE=y
> > CONFIG_CPU_IDLE_GOV_LADDER=y
> > CONFIG_CPU_IDLE_GOV_MENU=y
> > CONFIG_INTEL_IDLE=y
> > 
> > #
> > # Bus options (PCI etc.)
> > #
> > CONFIG_PCI=y
> > CONFIG_PCI_DIRECT=y
> > CONFIG_PCI_MMCONFIG=y
> > CONFIG_PCI_DOMAINS=y
> > CONFIG_MMCONF_FAM10H=y
> > # CONFIG_PCIEPORTBUS is not set
> > # CONFIG_PCI_MSI is not set
> > CONFIG_PCI_QUIRKS=y
> > # CONFIG_PCI_DEBUG is not set
> > # CONFIG_PCI_STUB is not set
> > CONFIG_PCI_LOCKLESS_CONFIG=y
> > # CONFIG_PCI_IOV is not set
> > # CONFIG_PCI_PRI is not set
> > # CONFIG_PCI_PASID is not set
> > CONFIG_PCI_LABEL=y
> > # CONFIG_HOTPLUG_PCI is not set
> > 
> > #
> > # PCI controller drivers
> > #
> > 
> > #
> > # Cadence PCIe controllers support
> > #
> > # CONFIG_PCIE_CADENCE_HOST is not set
> > # CONFIG_PCI_FTPCI100 is not set
> > # CONFIG_PCI_HOST_GENERIC is not set
> > 
> > #
> > # DesignWare PCI Core Support
> > #
> > 
> > #
> > # PCI Endpoint
> > #
> > # CONFIG_PCI_ENDPOINT is not set
> > 
> > #
> > # PCI switch controller drivers
> > #
> > # CONFIG_PCI_SW_SWITCHTEC is not set
> > CONFIG_ISA_DMA_API=y
> > CONFIG_AMD_NB=y
> > CONFIG_PCCARD=y
> > CONFIG_PCMCIA=y
> > # CONFIG_PCMCIA_LOAD_CIS is not set
> > CONFIG_CARDBUS=y
> > 
> > #
> > # PC-card bridges
> > #
> > # CONFIG_YENTA is not set
> > # CONFIG_PD6729 is not set
> > # CONFIG_I82092 is not set
> > # CONFIG_RAPIDIO is not set
> > # CONFIG_X86_SYSFB is not set
> > 
> > #
> > # Executable file formats / Emulations
> > #
> > CONFIG_BINFMT_ELF=y
> > CONFIG_ELFCORE=y
> > # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
> > CONFIG_BINFMT_SCRIPT=y
> > CONFIG_BINFMT_MISC=y
> > CONFIG_COREDUMP=y
> > # CONFIG_IA32_EMULATION is not set
> > # CONFIG_X86_X32 is not set
> > CONFIG_X86_DEV_DMA_OPS=y
> > CONFIG_NET=y
> > 
> > #
> > # Networking options
> > #
> > # CONFIG_PACKET is not set
> > CONFIG_UNIX=y
> > # CONFIG_UNIX_DIAG is not set
> > # CONFIG_TLS is not set
> > CONFIG_XFRM=y
> > # CONFIG_XFRM_USER is not set
> > # CONFIG_XFRM_SUB_POLICY is not set
> > # CONFIG_XFRM_MIGRATE is not set
> > # CONFIG_XFRM_STATISTICS is not set
> > # CONFIG_NET_KEY is not set
> > CONFIG_INET=y
> > # CONFIG_IP_MULTICAST is not set
> > # CONFIG_IP_ADVANCED_ROUTER is not set
> > CONFIG_IP_PNP=y
> > CONFIG_IP_PNP_DHCP=y
> > # CONFIG_IP_PNP_BOOTP is not set
> > # CONFIG_IP_PNP_RARP is not set
> > # CONFIG_NET_IPIP is not set
> > # CONFIG_NET_IPGRE_DEMUX is not set
> > CONFIG_NET_IP_TUNNEL=y
> > # CONFIG_SYN_COOKIES is not set
> > # CONFIG_NET_IPVTI is not set
> > # CONFIG_NET_FOU is not set
> > # CONFIG_NET_FOU_IP_TUNNELS is not set
> > # CONFIG_INET_AH is not set
> > # CONFIG_INET_ESP is not set
> > # CONFIG_INET_IPCOMP is not set
> > CONFIG_INET_TUNNEL=y
> > CONFIG_INET_XFRM_MODE_TRANSPORT=y
> > CONFIG_INET_XFRM_MODE_TUNNEL=y
> > CONFIG_INET_XFRM_MODE_BEET=y
> > CONFIG_INET_DIAG=y
> > CONFIG_INET_TCP_DIAG=y
> > # CONFIG_INET_UDP_DIAG is not set
> > # CONFIG_INET_RAW_DIAG is not set
> > # CONFIG_INET_DIAG_DESTROY is not set
> > # CONFIG_TCP_CONG_ADVANCED is not set
> > CONFIG_TCP_CONG_CUBIC=y
> > CONFIG_DEFAULT_TCP_CONG="cubic"
> > # CONFIG_TCP_MD5SIG is not set
> > CONFIG_IPV6=y
> > # CONFIG_IPV6_ROUTER_PREF is not set
> > # CONFIG_IPV6_OPTIMISTIC_DAD is not set
> > # CONFIG_INET6_AH is not set
> > # CONFIG_INET6_ESP is not set
> > # CONFIG_INET6_IPCOMP is not set
> > # CONFIG_IPV6_MIP6 is not set
> > CONFIG_INET6_XFRM_MODE_TRANSPORT=y
> > CONFIG_INET6_XFRM_MODE_TUNNEL=y
> > CONFIG_INET6_XFRM_MODE_BEET=y
> > # CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
> > # CONFIG_IPV6_VTI is not set
> > CONFIG_IPV6_SIT=y
> > # CONFIG_IPV6_SIT_6RD is not set
> > CONFIG_IPV6_NDISC_NODETYPE=y
> > # CONFIG_IPV6_TUNNEL is not set
> > # CONFIG_IPV6_MULTIPLE_TABLES is not set
> > # CONFIG_IPV6_MROUTE is not set
> > # CONFIG_IPV6_SEG6_LWTUNNEL is not set
> > # CONFIG_IPV6_SEG6_HMAC is not set
> > # CONFIG_NETWORK_SECMARK is not set
> > CONFIG_NET_PTP_CLASSIFY=y
> > # CONFIG_NETWORK_PHY_TIMESTAMPING is not set
> > # CONFIG_NETFILTER is not set
> > # CONFIG_BPFILTER is not set
> > # CONFIG_IP_DCCP is not set
> > # CONFIG_IP_SCTP is not set
> > # CONFIG_RDS is not set
> > # CONFIG_TIPC is not set
> > # CONFIG_ATM is not set
> > # CONFIG_L2TP is not set
> > # CONFIG_BRIDGE is not set
> > CONFIG_HAVE_NET_DSA=y
> > # CONFIG_NET_DSA is not set
> > # CONFIG_VLAN_8021Q is not set
> > # CONFIG_DECNET is not set
> > # CONFIG_LLC2 is not set
> > # CONFIG_ATALK is not set
> > # CONFIG_X25 is not set
> > # CONFIG_LAPB is not set
> > # CONFIG_PHONET is not set
> > # CONFIG_6LOWPAN is not set
> > # CONFIG_IEEE802154 is not set
> > # CONFIG_NET_SCHED is not set
> > # CONFIG_DCB is not set
> > CONFIG_DNS_RESOLVER=y
> > # CONFIG_BATMAN_ADV is not set
> > # CONFIG_OPENVSWITCH is not set
> > # CONFIG_VSOCKETS is not set
> > # CONFIG_NETLINK_DIAG is not set
> > # CONFIG_MPLS is not set
> > # CONFIG_NET_NSH is not set
> > # CONFIG_HSR is not set
> > # CONFIG_NET_SWITCHDEV is not set
> > # CONFIG_NET_L3_MASTER_DEV is not set
> > # CONFIG_NET_NCSI is not set
> > CONFIG_RPS=y
> > CONFIG_RFS_ACCEL=y
> > CONFIG_XPS=y
> > # CONFIG_CGROUP_NET_PRIO is not set
> > # CONFIG_CGROUP_NET_CLASSID is not set
> > CONFIG_NET_RX_BUSY_POLL=y
> > CONFIG_BQL=y
> > CONFIG_NET_FLOW_LIMIT=y
> > 
> > #
> > # Network testing
> > #
> > # CONFIG_NET_PKTGEN is not set
> > # CONFIG_HAMRADIO is not set
> > # CONFIG_CAN is not set
> > # CONFIG_BT is not set
> > # CONFIG_AF_RXRPC is not set
> > # CONFIG_AF_KCM is not set
> > CONFIG_WIRELESS=y
> > # CONFIG_CFG80211 is not set
> > 
> > #
> > # CFG80211 needs to be enabled for MAC80211
> > #
> > CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
> > # CONFIG_WIMAX is not set
> > # CONFIG_RFKILL is not set
> > # CONFIG_NET_9P is not set
> > # CONFIG_CAIF is not set
> > # CONFIG_CEPH_LIB is not set
> > # CONFIG_NFC is not set
> > # CONFIG_PSAMPLE is not set
> > # CONFIG_NET_IFE is not set
> > # CONFIG_LWTUNNEL is not set
> > CONFIG_DST_CACHE=y
> > CONFIG_GRO_CELLS=y
> > # CONFIG_NET_DEVLINK is not set
> > CONFIG_MAY_USE_DEVLINK=y
> > # CONFIG_FAILOVER is not set
> > CONFIG_HAVE_EBPF_JIT=y
> > 
> > #
> > # Device Drivers
> > #
> > 
> > #
> > # Generic Driver Options
> > #
> > CONFIG_UEVENT_HELPER=y
> > CONFIG_UEVENT_HELPER_PATH=""
> > CONFIG_DEVTMPFS=y
> > # CONFIG_DEVTMPFS_MOUNT is not set
> > CONFIG_STANDALONE=y
> > # CONFIG_PREVENT_FIRMWARE_BUILD is not set
> > 
> > #
> > # Firmware loader
> > #
> > CONFIG_FW_LOADER=y
> > CONFIG_EXTRA_FIRMWARE=""
> > CONFIG_FW_LOADER_USER_HELPER=y
> > # CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
> > CONFIG_WANT_DEV_COREDUMP=y
> > CONFIG_ALLOW_DEV_COREDUMP=y
> > CONFIG_DEV_COREDUMP=y
> > # CONFIG_DEBUG_DRIVER is not set
> > CONFIG_DEBUG_DEVRES=y
> > # CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
> > CONFIG_GENERIC_CPU_AUTOPROBE=y
> > CONFIG_GENERIC_CPU_VULNERABILITIES=y
> > CONFIG_REGMAP=y
> > CONFIG_REGMAP_I2C=y
> > CONFIG_REGMAP_SPMI=y
> > CONFIG_REGMAP_W1=y
> > CONFIG_REGMAP_MMIO=y
> > CONFIG_REGMAP_IRQ=y
> > CONFIG_DMA_SHARED_BUFFER=y
> > CONFIG_DMA_FENCE_TRACE=y
> > CONFIG_DMA_CMA=y
> > 
> > #
> > # Default contiguous memory area size:
> > #
> > CONFIG_CMA_SIZE_PERCENTAGE=0
> > # CONFIG_CMA_SIZE_SEL_MBYTES is not set
> > CONFIG_CMA_SIZE_SEL_PERCENTAGE=y
> > # CONFIG_CMA_SIZE_SEL_MIN is not set
> > # CONFIG_CMA_SIZE_SEL_MAX is not set
> > CONFIG_CMA_ALIGNMENT=8
> > 
> > #
> > # Bus devices
> > #
> > CONFIG_SIMPLE_PM_BUS=y
> > # CONFIG_CONNECTOR is not set
> > # CONFIG_MTD is not set
> > CONFIG_DTC=y
> > CONFIG_OF=y
> > CONFIG_OF_UNITTEST=y
> > CONFIG_OF_FLATTREE=y
> > CONFIG_OF_EARLY_FLATTREE=y
> > CONFIG_OF_KOBJ=y
> > CONFIG_OF_DYNAMIC=y
> > CONFIG_OF_ADDRESS=y
> > CONFIG_OF_IRQ=y
> > CONFIG_OF_NET=y
> > CONFIG_OF_RESOLVE=y
> > # CONFIG_OF_OVERLAY is not set
> > CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
> > # CONFIG_PARPORT is not set
> > CONFIG_PNP=y
> > CONFIG_PNP_DEBUG_MESSAGES=y
> > 
> > #
> > # Protocols
> > #
> > CONFIG_PNPACPI=y
> > CONFIG_BLK_DEV=y
> > # CONFIG_BLK_DEV_NULL_BLK is not set
> > # CONFIG_BLK_DEV_FD is not set
> > # CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
> > # CONFIG_BLK_DEV_DAC960 is not set
> > # CONFIG_BLK_DEV_UMEM is not set
> > # CONFIG_BLK_DEV_LOOP is not set
> > # CONFIG_BLK_DEV_DRBD is not set
> > # CONFIG_BLK_DEV_NBD is not set
> > # CONFIG_BLK_DEV_SKD is not set
> > # CONFIG_BLK_DEV_SX8 is not set
> > # CONFIG_BLK_DEV_RAM is not set
> > # CONFIG_CDROM_PKTCDVD is not set
> > # CONFIG_ATA_OVER_ETH is not set
> > # CONFIG_VIRTIO_BLK is not set
> > # CONFIG_BLK_DEV_RBD is not set
> > # CONFIG_BLK_DEV_RSXX is not set
> > 
> > #
> > # NVME Support
> > #
> > CONFIG_NVME_CORE=y
> > # CONFIG_BLK_DEV_NVME is not set
> > CONFIG_NVME_MULTIPATH=y
> > CONFIG_NVME_FABRICS=y
> > CONFIG_NVME_FC=y
> > # CONFIG_NVME_TARGET is not set
> > 
> > #
> > # Misc devices
> > #
> > CONFIG_SENSORS_LIS3LV02D=y
> > CONFIG_AD525X_DPOT=y
> > CONFIG_AD525X_DPOT_I2C=y
> > # CONFIG_DUMMY_IRQ is not set
> > # CONFIG_IBM_ASM is not set
> > # CONFIG_PHANTOM is not set
> > # CONFIG_SGI_IOC4 is not set
> > # CONFIG_TIFM_CORE is not set
> > # CONFIG_ICS932S401 is not set
> > # CONFIG_ENCLOSURE_SERVICES is not set
> > # CONFIG_HP_ILO is not set
> > CONFIG_APDS9802ALS=y
> > # CONFIG_ISL29003 is not set
> > CONFIG_ISL29020=y
> > # CONFIG_SENSORS_TSL2550 is not set
> > CONFIG_SENSORS_BH1770=y
> > CONFIG_SENSORS_APDS990X=y
> > CONFIG_HMC6352=y
> > CONFIG_DS1682=y
> > CONFIG_USB_SWITCH_FSA9480=y
> > CONFIG_SRAM=y
> > # CONFIG_PCI_ENDPOINT_TEST is not set
> > CONFIG_C2PORT=y
> > # CONFIG_C2PORT_DURAMAR_2150 is not set
> > 
> > #
> > # EEPROM support
> > #
> > CONFIG_EEPROM_AT24=y
> > CONFIG_EEPROM_LEGACY=y
> > CONFIG_EEPROM_MAX6875=y
> > # CONFIG_EEPROM_93CX6 is not set
> > CONFIG_EEPROM_IDT_89HPESX=y
> > # CONFIG_CB710_CORE is not set
> > 
> > #
> > # Texas Instruments shared transport line discipline
> > #
> > # CONFIG_TI_ST is not set
> > CONFIG_SENSORS_LIS3_I2C=y
> > # CONFIG_ALTERA_STAPL is not set
> > # CONFIG_INTEL_MEI is not set
> > # CONFIG_INTEL_MEI_ME is not set
> > # CONFIG_INTEL_MEI_TXE is not set
> > # CONFIG_VMWARE_VMCI is not set
> > 
> > #
> > # Intel MIC & related support
> > #
> > 
> > #
> > # Intel MIC Bus Driver
> > #
> > # CONFIG_INTEL_MIC_BUS is not set
> > 
> > #
> > # SCIF Bus Driver
> > #
> > # CONFIG_SCIF_BUS is not set
> > 
> > #
> > # VOP Bus Driver
> > #
> > # CONFIG_VOP_BUS is not set
> > 
> > #
> > # Intel MIC Host Driver
> > #
> > 
> > #
> > # Intel MIC Card Driver
> > #
> > 
> > #
> > # SCIF Driver
> > #
> > 
> > #
> > # Intel MIC Coprocessor State Management (COSM) Drivers
> > #
> > 
> > #
> > # VOP Driver
> > #
> > # CONFIG_GENWQE is not set
> > # CONFIG_ECHO is not set
> > # CONFIG_MISC_RTSX_PCI is not set
> > # CONFIG_MISC_RTSX_USB is not set
> > CONFIG_HAVE_IDE=y
> > CONFIG_IDE=y
> > 
> > #
> > # Please see Documentation/ide/ide.txt for help/info on IDE drives
> > #
> > CONFIG_IDE_XFER_MODE=y
> > CONFIG_IDE_TIMINGS=y
> > CONFIG_IDE_ATAPI=y
> > CONFIG_BLK_DEV_IDE_SATA=y
> > CONFIG_IDE_GD=y
> > # CONFIG_IDE_GD_ATA is not set
> > # CONFIG_IDE_GD_ATAPI is not set
> > # CONFIG_BLK_DEV_IDECS is not set
> > # CONFIG_BLK_DEV_DELKIN is not set
> > # CONFIG_BLK_DEV_IDECD is not set
> > CONFIG_BLK_DEV_IDETAPE=y
> > # CONFIG_BLK_DEV_IDEACPI is not set
> > # CONFIG_IDE_TASK_IOCTL is not set
> > CONFIG_IDE_PROC_FS=y
> > 
> > #
> > # IDE chipset support/bugfixes
> > #
> > # CONFIG_IDE_GENERIC is not set
> > CONFIG_BLK_DEV_PLATFORM=y
> > CONFIG_BLK_DEV_CMD640=y
> > # CONFIG_BLK_DEV_CMD640_ENHANCED is not set
> > # CONFIG_BLK_DEV_IDEPNP is not set
> > 
> > #
> > # PCI IDE chipsets support
> > #
> > # CONFIG_BLK_DEV_GENERIC is not set
> > # CONFIG_BLK_DEV_OPTI621 is not set
> > # CONFIG_BLK_DEV_RZ1000 is not set
> > # CONFIG_BLK_DEV_AEC62XX is not set
> > # CONFIG_BLK_DEV_ALI15X3 is not set
> > # CONFIG_BLK_DEV_AMD74XX is not set
> > # CONFIG_BLK_DEV_ATIIXP is not set
> > # CONFIG_BLK_DEV_CMD64X is not set
> > # CONFIG_BLK_DEV_TRIFLEX is not set
> > # CONFIG_BLK_DEV_HPT366 is not set
> > # CONFIG_BLK_DEV_JMICRON is not set
> > # CONFIG_BLK_DEV_PIIX is not set
> > # CONFIG_BLK_DEV_IT8172 is not set
> > # CONFIG_BLK_DEV_IT8213 is not set
> > # CONFIG_BLK_DEV_IT821X is not set
> > # CONFIG_BLK_DEV_NS87415 is not set
> > # CONFIG_BLK_DEV_PDC202XX_OLD is not set
> > # CONFIG_BLK_DEV_PDC202XX_NEW is not set
> > # CONFIG_BLK_DEV_SVWKS is not set
> > # CONFIG_BLK_DEV_SIIMAGE is not set
> > # CONFIG_BLK_DEV_SIS5513 is not set
> > # CONFIG_BLK_DEV_SLC90E66 is not set
> > # CONFIG_BLK_DEV_TRM290 is not set
> > # CONFIG_BLK_DEV_VIA82CXXX is not set
> > # CONFIG_BLK_DEV_TC86C001 is not set
> > 
> > #
> > # SCSI device support
> > #
> > CONFIG_SCSI_MOD=y
> > CONFIG_RAID_ATTRS=y
> > # CONFIG_SCSI is not set
> > # CONFIG_ATA is not set
> > CONFIG_MD=y
> > # CONFIG_BLK_DEV_MD is not set
> > # CONFIG_BCACHE is not set
> > CONFIG_BLK_DEV_DM_BUILTIN=y
> > CONFIG_BLK_DEV_DM=y
> > # CONFIG_DM_MQ_DEFAULT is not set
> > # CONFIG_DM_DEBUG is not set
> > CONFIG_DM_BUFIO=y
> > # CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
> > CONFIG_DM_BIO_PRISON=y
> > CONFIG_DM_PERSISTENT_DATA=y
> > CONFIG_DM_UNSTRIPED=y
> > CONFIG_DM_CRYPT=y
> > CONFIG_DM_SNAPSHOT=y
> > CONFIG_DM_THIN_PROVISIONING=y
> > CONFIG_DM_CACHE=y
> > # CONFIG_DM_CACHE_SMQ is not set
> > CONFIG_DM_WRITECACHE=y
> > # CONFIG_DM_ERA is not set
> > # CONFIG_DM_MIRROR is not set
> > # CONFIG_DM_RAID is not set
> > CONFIG_DM_ZERO=y
> > CONFIG_DM_MULTIPATH=y
> > CONFIG_DM_MULTIPATH_QL=y
> > CONFIG_DM_MULTIPATH_ST=y
> > CONFIG_DM_DELAY=y
> > CONFIG_DM_UEVENT=y
> > CONFIG_DM_FLAKEY=y
> > # CONFIG_DM_VERITY is not set
> > CONFIG_DM_SWITCH=y
> > CONFIG_DM_LOG_WRITES=y
> > CONFIG_DM_INTEGRITY=y
> > # CONFIG_DM_ZONED is not set
> > # CONFIG_FUSION is not set
> > 
> > #
> > # IEEE 1394 (FireWire) support
> > #
> > CONFIG_FIREWIRE=y
> > # CONFIG_FIREWIRE_OHCI is not set
> > # CONFIG_FIREWIRE_NET is not set
> > # CONFIG_FIREWIRE_NOSY is not set
> > # CONFIG_MACINTOSH_DRIVERS is not set
> > CONFIG_NETDEVICES=y
> > CONFIG_NET_CORE=y
> > # CONFIG_BONDING is not set
> > # CONFIG_DUMMY is not set
> > # CONFIG_EQUALIZER is not set
> > # CONFIG_NET_TEAM is not set
> > # CONFIG_MACVLAN is not set
> > # CONFIG_VXLAN is not set
> > # CONFIG_MACSEC is not set
> > # CONFIG_NETCONSOLE is not set
> > # CONFIG_TUN is not set
> > # CONFIG_TUN_VNET_CROSS_LE is not set
> > # CONFIG_VETH is not set
> > # CONFIG_VIRTIO_NET is not set
> > # CONFIG_NLMON is not set
> > # CONFIG_ARCNET is not set
> > 
> > #
> > # CAIF transport drivers
> > #
> > 
> > #
> > # Distributed Switch Architecture drivers
> > #
> > CONFIG_ETHERNET=y
> > CONFIG_MDIO=y
> > CONFIG_NET_VENDOR_3COM=y
> > # CONFIG_PCMCIA_3C574 is not set
> > # CONFIG_PCMCIA_3C589 is not set
> > # CONFIG_VORTEX is not set
> > # CONFIG_TYPHOON is not set
> > CONFIG_NET_VENDOR_ADAPTEC=y
> > # CONFIG_ADAPTEC_STARFIRE is not set
> > CONFIG_NET_VENDOR_AGERE=y
> > # CONFIG_ET131X is not set
> > CONFIG_NET_VENDOR_ALACRITECH=y
> > # CONFIG_SLICOSS is not set
> > CONFIG_NET_VENDOR_ALTEON=y
> > # CONFIG_ACENIC is not set
> > # CONFIG_ALTERA_TSE is not set
> > CONFIG_NET_VENDOR_AMAZON=y
> > CONFIG_NET_VENDOR_AMD=y
> > # CONFIG_AMD8111_ETH is not set
> > # CONFIG_PCNET32 is not set
> > # CONFIG_PCMCIA_NMCLAN is not set
> > # CONFIG_AMD_XGBE is not set
> > CONFIG_NET_VENDOR_AQUANTIA=y
> > # CONFIG_AQTION is not set
> > CONFIG_NET_VENDOR_ARC=y
> > CONFIG_NET_VENDOR_ATHEROS=y
> > # CONFIG_ATL2 is not set
> > # CONFIG_ATL1 is not set
> > # CONFIG_ATL1E is not set
> > # CONFIG_ATL1C is not set
> > # CONFIG_ALX is not set
> > # CONFIG_NET_VENDOR_AURORA is not set
> > CONFIG_NET_VENDOR_BROADCOM=y
> > # CONFIG_B44 is not set
> > # CONFIG_BCMGENET is not set
> > # CONFIG_BNX2 is not set
> > # CONFIG_CNIC is not set
> > # CONFIG_TIGON3 is not set
> > # CONFIG_BNX2X is not set
> > # CONFIG_SYSTEMPORT is not set
> > # CONFIG_BNXT is not set
> > CONFIG_NET_VENDOR_BROCADE=y
> > # CONFIG_BNA is not set
> > CONFIG_NET_CADENCE=y
> > # CONFIG_MACB is not set
> > CONFIG_NET_VENDOR_CAVIUM=y
> > # CONFIG_THUNDER_NIC_PF is not set
> > # CONFIG_THUNDER_NIC_VF is not set
> > # CONFIG_THUNDER_NIC_BGX is not set
> > # CONFIG_THUNDER_NIC_RGX is not set
> > CONFIG_CAVIUM_PTP=y
> > # CONFIG_LIQUIDIO is not set
> > CONFIG_NET_VENDOR_CHELSIO=y
> > # CONFIG_CHELSIO_T1 is not set
> > # CONFIG_CHELSIO_T3 is not set
> > # CONFIG_CHELSIO_T4 is not set
> > # CONFIG_CHELSIO_T4VF is not set
> > CONFIG_NET_VENDOR_CISCO=y
> > # CONFIG_ENIC is not set
> > CONFIG_NET_VENDOR_CORTINA=y
> > # CONFIG_GEMINI_ETHERNET is not set
> > # CONFIG_CX_ECAT is not set
> > # CONFIG_DNET is not set
> > CONFIG_NET_VENDOR_DEC=y
> > # CONFIG_NET_TULIP is not set
> > CONFIG_NET_VENDOR_DLINK=y
> > # CONFIG_DL2K is not set
> > # CONFIG_SUNDANCE is not set
> > CONFIG_NET_VENDOR_EMULEX=y
> > # CONFIG_BE2NET is not set
> > CONFIG_NET_VENDOR_EZCHIP=y
> > # CONFIG_EZCHIP_NPS_MANAGEMENT_ENET is not set
> > CONFIG_NET_VENDOR_FUJITSU=y
> > # CONFIG_PCMCIA_FMVJ18X is not set
> > CONFIG_NET_VENDOR_HP=y
> > # CONFIG_HP100 is not set
> > CONFIG_NET_VENDOR_HUAWEI=y
> > CONFIG_NET_VENDOR_I825XX=y
> > CONFIG_NET_VENDOR_INTEL=y
> > # CONFIG_E100 is not set
> > CONFIG_E1000=y
> > CONFIG_E1000E=y
> > CONFIG_E1000E_HWTS=y
> > CONFIG_IGB=y
> > CONFIG_IGB_HWMON=y
> > # CONFIG_IGBVF is not set
> > # CONFIG_IXGB is not set
> > CONFIG_IXGBE=y
> > CONFIG_IXGBE_HWMON=y
> > # CONFIG_I40E is not set
> > CONFIG_NET_VENDOR_EXAR=y
> > # CONFIG_S2IO is not set
> > # CONFIG_VXGE is not set
> > # CONFIG_JME is not set
> > CONFIG_NET_VENDOR_MARVELL=y
> > # CONFIG_MVMDIO is not set
> > # CONFIG_SKGE is not set
> > # CONFIG_SKY2 is not set
> > CONFIG_NET_VENDOR_MELLANOX=y
> > # CONFIG_MLX4_EN is not set
> > # CONFIG_MLX5_CORE is not set
> > # CONFIG_MLXSW_CORE is not set
> > # CONFIG_MLXFW is not set
> > CONFIG_NET_VENDOR_MICREL=y
> > # CONFIG_KS8851_MLL is not set
> > # CONFIG_KSZ884X_PCI is not set
> > CONFIG_NET_VENDOR_MICROSEMI=y
> > CONFIG_NET_VENDOR_MYRI=y
> > # CONFIG_MYRI10GE is not set
> > # CONFIG_FEALNX is not set
> > CONFIG_NET_VENDOR_NATSEMI=y
> > # CONFIG_NATSEMI is not set
> > # CONFIG_NS83820 is not set
> > CONFIG_NET_VENDOR_NETRONOME=y
> > CONFIG_NET_VENDOR_NI=y
> > CONFIG_NET_VENDOR_8390=y
> > # CONFIG_PCMCIA_AXNET is not set
> > # CONFIG_NE2K_PCI is not set
> > # CONFIG_PCMCIA_PCNET is not set
> > CONFIG_NET_VENDOR_NVIDIA=y
> > # CONFIG_FORCEDETH is not set
> > CONFIG_NET_VENDOR_OKI=y
> > # CONFIG_ETHOC is not set
> > CONFIG_NET_PACKET_ENGINE=y
> > # CONFIG_HAMACHI is not set
> > # CONFIG_YELLOWFIN is not set
> > CONFIG_NET_VENDOR_QLOGIC=y
> > # CONFIG_QLA3XXX is not set
> > # CONFIG_QLCNIC is not set
> > # CONFIG_QLGE is not set
> > # CONFIG_NETXEN_NIC is not set
> > # CONFIG_QED is not set
> > CONFIG_NET_VENDOR_QUALCOMM=y
> > # CONFIG_QCA7000_UART is not set
> > # CONFIG_QCOM_EMAC is not set
> > # CONFIG_RMNET is not set
> > CONFIG_NET_VENDOR_RDC=y
> > # CONFIG_R6040 is not set
> > CONFIG_NET_VENDOR_REALTEK=y
> > # CONFIG_8139CP is not set
> > # CONFIG_8139TOO is not set
> > # CONFIG_R8169 is not set
> > CONFIG_NET_VENDOR_RENESAS=y
> > CONFIG_NET_VENDOR_ROCKER=y
> > CONFIG_NET_VENDOR_SAMSUNG=y
> > # CONFIG_SXGBE_ETH is not set
> > CONFIG_NET_VENDOR_SEEQ=y
> > CONFIG_NET_VENDOR_SOLARFLARE=y
> > # CONFIG_SFC is not set
> > # CONFIG_SFC_FALCON is not set
> > CONFIG_NET_VENDOR_SILAN=y
> > # CONFIG_SC92031 is not set
> > CONFIG_NET_VENDOR_SIS=y
> > # CONFIG_SIS900 is not set
> > # CONFIG_SIS190 is not set
> > CONFIG_NET_VENDOR_SMSC=y
> > # CONFIG_PCMCIA_SMC91C92 is not set
> > # CONFIG_EPIC100 is not set
> > # CONFIG_SMSC911X is not set
> > # CONFIG_SMSC9420 is not set
> > CONFIG_NET_VENDOR_SOCIONEXT=y
> > CONFIG_NET_VENDOR_STMICRO=y
> > # CONFIG_STMMAC_ETH is not set
> > CONFIG_NET_VENDOR_SUN=y
> > # CONFIG_HAPPYMEAL is not set
> > # CONFIG_SUNGEM is not set
> > # CONFIG_CASSINI is not set
> > # CONFIG_NIU is not set
> > CONFIG_NET_VENDOR_SYNOPSYS=y
> > # CONFIG_DWC_XLGMAC is not set
> > CONFIG_NET_VENDOR_TEHUTI=y
> > # CONFIG_TEHUTI is not set
> > CONFIG_NET_VENDOR_TI=y
> > # CONFIG_TI_CPSW_ALE is not set
> > # CONFIG_TLAN is not set
> > CONFIG_NET_VENDOR_VIA=y
> > # CONFIG_VIA_RHINE is not set
> > # CONFIG_VIA_VELOCITY is not set
> > CONFIG_NET_VENDOR_WIZNET=y
> > # CONFIG_WIZNET_W5100 is not set
> > # CONFIG_WIZNET_W5300 is not set
> > CONFIG_NET_VENDOR_XIRCOM=y
> > # CONFIG_PCMCIA_XIRC2PS is not set
> > # CONFIG_FDDI is not set
> > # CONFIG_HIPPI is not set
> > # CONFIG_NET_SB1000 is not set
> > # CONFIG_MDIO_DEVICE is not set
> > # CONFIG_PHYLIB is not set
> > # CONFIG_PPP is not set
> > # CONFIG_SLIP is not set
> > CONFIG_USB_NET_DRIVERS=y
> > # CONFIG_USB_CATC is not set
> > # CONFIG_USB_KAWETH is not set
> > # CONFIG_USB_PEGASUS is not set
> > # CONFIG_USB_RTL8150 is not set
> > # CONFIG_USB_RTL8152 is not set
> > # CONFIG_USB_LAN78XX is not set
> > # CONFIG_USB_USBNET is not set
> > # CONFIG_USB_IPHETH is not set
> > CONFIG_WLAN=y
> > CONFIG_WLAN_VENDOR_ADMTEK=y
> > CONFIG_WLAN_VENDOR_ATH=y
> > # CONFIG_ATH_DEBUG is not set
> > # CONFIG_ATH5K_PCI is not set
> > CONFIG_WLAN_VENDOR_ATMEL=y
> > CONFIG_WLAN_VENDOR_BROADCOM=y
> > CONFIG_WLAN_VENDOR_CISCO=y
> > CONFIG_WLAN_VENDOR_INTEL=y
> > CONFIG_WLAN_VENDOR_INTERSIL=y
> > # CONFIG_HOSTAP is not set
> > # CONFIG_PRISM54 is not set
> > CONFIG_WLAN_VENDOR_MARVELL=y
> > CONFIG_WLAN_VENDOR_MEDIATEK=y
> > CONFIG_WLAN_VENDOR_RALINK=y
> > CONFIG_WLAN_VENDOR_REALTEK=y
> > CONFIG_WLAN_VENDOR_RSI=y
> > CONFIG_WLAN_VENDOR_ST=y
> > CONFIG_WLAN_VENDOR_TI=y
> > CONFIG_WLAN_VENDOR_ZYDAS=y
> > CONFIG_WLAN_VENDOR_QUANTENNA=y
> > # CONFIG_PCMCIA_RAYCS is not set
> > 
> > #
> > # Enable WiMAX (Networking options) to see the WiMAX drivers
> > #
> > # CONFIG_WAN is not set
> > # CONFIG_VMXNET3 is not set
> > # CONFIG_FUJITSU_ES is not set
> > # CONFIG_NETDEVSIM is not set
> > # CONFIG_NET_FAILOVER is not set
> > # CONFIG_ISDN is not set
> > # CONFIG_NVM is not set
> > 
> > #
> > # Input device support
> > #
> > CONFIG_INPUT=y
> > CONFIG_INPUT_LEDS=y
> > CONFIG_INPUT_FF_MEMLESS=y
> > CONFIG_INPUT_POLLDEV=y
> > CONFIG_INPUT_SPARSEKMAP=y
> > CONFIG_INPUT_MATRIXKMAP=y
> > 
> > #
> > # Userland interfaces
> > #
> > # CONFIG_INPUT_MOUSEDEV is not set
> > # CONFIG_INPUT_JOYDEV is not set
> > CONFIG_INPUT_EVDEV=y
> > CONFIG_INPUT_EVBUG=y
> > 
> > #
> > # Input Device Drivers
> > #
> > CONFIG_INPUT_KEYBOARD=y
> > # CONFIG_KEYBOARD_ADC is not set
> > # CONFIG_KEYBOARD_ADP5588 is not set
> > # CONFIG_KEYBOARD_ADP5589 is not set
> > CONFIG_KEYBOARD_ATKBD=y
> > # CONFIG_KEYBOARD_QT1070 is not set
> > # CONFIG_KEYBOARD_QT2160 is not set
> > # CONFIG_KEYBOARD_DLINK_DIR685 is not set
> > # CONFIG_KEYBOARD_LKKBD is not set
> > # CONFIG_KEYBOARD_GPIO is not set
> > # CONFIG_KEYBOARD_GPIO_POLLED is not set
> > # CONFIG_KEYBOARD_TCA6416 is not set
> > # CONFIG_KEYBOARD_TCA8418 is not set
> > # CONFIG_KEYBOARD_MATRIX is not set
> > # CONFIG_KEYBOARD_LM8323 is not set
> > # CONFIG_KEYBOARD_LM8333 is not set
> > # CONFIG_KEYBOARD_MAX7359 is not set
> > # CONFIG_KEYBOARD_MCS is not set
> > # CONFIG_KEYBOARD_MPR121 is not set
> > # CONFIG_KEYBOARD_NEWTON is not set
> > # CONFIG_KEYBOARD_OPENCORES is not set
> > # CONFIG_KEYBOARD_SAMSUNG is not set
> > # CONFIG_KEYBOARD_GOLDFISH_EVENTS is not set
> > # CONFIG_KEYBOARD_STOWAWAY is not set
> > # CONFIG_KEYBOARD_SUNKBD is not set
> > # CONFIG_KEYBOARD_STMPE is not set
> > # CONFIG_KEYBOARD_OMAP4 is not set
> > # CONFIG_KEYBOARD_TC3589X is not set
> > # CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
> > # CONFIG_KEYBOARD_XTKBD is not set
> > # CONFIG_KEYBOARD_CROS_EC is not set
> > # CONFIG_KEYBOARD_CAP11XX is not set
> > # CONFIG_KEYBOARD_BCM is not set
> > # CONFIG_KEYBOARD_MTK_PMIC is not set
> > CONFIG_INPUT_MOUSE=y
> > # CONFIG_MOUSE_PS2 is not set
> > # CONFIG_MOUSE_SERIAL is not set
> > CONFIG_MOUSE_APPLETOUCH=y
> > # CONFIG_MOUSE_BCM5974 is not set
> > # CONFIG_MOUSE_CYAPA is not set
> > # CONFIG_MOUSE_ELAN_I2C is not set
> > CONFIG_MOUSE_VSXXXAA=y
> > # CONFIG_MOUSE_GPIO is not set
> > CONFIG_MOUSE_SYNAPTICS_I2C=y
> > CONFIG_MOUSE_SYNAPTICS_USB=y
> > CONFIG_INPUT_JOYSTICK=y
> > CONFIG_JOYSTICK_ANALOG=y
> > CONFIG_JOYSTICK_A3D=y
> > CONFIG_JOYSTICK_ADI=y
> > CONFIG_JOYSTICK_COBRA=y
> > # CONFIG_JOYSTICK_GF2K is not set
> > # CONFIG_JOYSTICK_GRIP is not set
> > CONFIG_JOYSTICK_GRIP_MP=y
> > # CONFIG_JOYSTICK_GUILLEMOT is not set
> > CONFIG_JOYSTICK_INTERACT=y
> > # CONFIG_JOYSTICK_SIDEWINDER is not set
> > CONFIG_JOYSTICK_TMDC=y
> > # CONFIG_JOYSTICK_IFORCE is not set
> > CONFIG_JOYSTICK_WARRIOR=y
> > CONFIG_JOYSTICK_MAGELLAN=y
> > CONFIG_JOYSTICK_SPACEORB=y
> > # CONFIG_JOYSTICK_SPACEBALL is not set
> > CONFIG_JOYSTICK_STINGER=y
> > CONFIG_JOYSTICK_TWIDJOY=y
> > CONFIG_JOYSTICK_ZHENHUA=y
> > CONFIG_JOYSTICK_AS5011=y
> > CONFIG_JOYSTICK_JOYDUMP=y
> > # CONFIG_JOYSTICK_XPAD is not set
> > CONFIG_JOYSTICK_PXRC=y
> > # CONFIG_INPUT_TABLET is not set
> > CONFIG_INPUT_TOUCHSCREEN=y
> > CONFIG_TOUCHSCREEN_PROPERTIES=y
> > # CONFIG_TOUCHSCREEN_AD7879 is not set
> > CONFIG_TOUCHSCREEN_AR1021_I2C=y
> > CONFIG_TOUCHSCREEN_ATMEL_MXT=y
> > CONFIG_TOUCHSCREEN_ATMEL_MXT_T37=y
> > CONFIG_TOUCHSCREEN_AUO_PIXCIR=y
> > CONFIG_TOUCHSCREEN_BU21013=y
> > # CONFIG_TOUCHSCREEN_CHIPONE_ICN8318 is not set
> > # CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
> > # CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
> > # CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
> > # CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
> > CONFIG_TOUCHSCREEN_DA9034=y
> > CONFIG_TOUCHSCREEN_DA9052=y
> > CONFIG_TOUCHSCREEN_DYNAPRO=y
> > CONFIG_TOUCHSCREEN_HAMPSHIRE=y
> > # CONFIG_TOUCHSCREEN_EETI is not set
> > # CONFIG_TOUCHSCREEN_EGALAX is not set
> > CONFIG_TOUCHSCREEN_EGALAX_SERIAL=y
> > # CONFIG_TOUCHSCREEN_EXC3000 is not set
> > CONFIG_TOUCHSCREEN_FUJITSU=y
> > CONFIG_TOUCHSCREEN_GOODIX=y
> > CONFIG_TOUCHSCREEN_HIDEEP=y
> > # CONFIG_TOUCHSCREEN_ILI210X is not set
> > CONFIG_TOUCHSCREEN_S6SY761=y
> > # CONFIG_TOUCHSCREEN_GUNZE is not set
> > # CONFIG_TOUCHSCREEN_EKTF2127 is not set
> > CONFIG_TOUCHSCREEN_ELAN=y
> > CONFIG_TOUCHSCREEN_ELO=y
> > CONFIG_TOUCHSCREEN_WACOM_W8001=y
> > CONFIG_TOUCHSCREEN_WACOM_I2C=y
> > CONFIG_TOUCHSCREEN_MAX11801=y
> > CONFIG_TOUCHSCREEN_MCS5000=y
> > CONFIG_TOUCHSCREEN_MMS114=y
> > CONFIG_TOUCHSCREEN_MELFAS_MIP4=y
> > # CONFIG_TOUCHSCREEN_MTOUCH is not set
> > CONFIG_TOUCHSCREEN_IMX6UL_TSC=y
> > CONFIG_TOUCHSCREEN_INEXIO=y
> > # CONFIG_TOUCHSCREEN_MK712 is not set
> > CONFIG_TOUCHSCREEN_PENMOUNT=y
> > CONFIG_TOUCHSCREEN_EDT_FT5X06=y
> > CONFIG_TOUCHSCREEN_TOUCHRIGHT=y
> > CONFIG_TOUCHSCREEN_TOUCHWIN=y
> > CONFIG_TOUCHSCREEN_TI_AM335X_TSC=y
> > CONFIG_TOUCHSCREEN_UCB1400=y
> > # CONFIG_TOUCHSCREEN_PIXCIR is not set
> > CONFIG_TOUCHSCREEN_WDT87XX_I2C=y
> > CONFIG_TOUCHSCREEN_WM831X=y
> > CONFIG_TOUCHSCREEN_WM97XX=y
> > # CONFIG_TOUCHSCREEN_WM9705 is not set
> > # CONFIG_TOUCHSCREEN_WM9712 is not set
> > # CONFIG_TOUCHSCREEN_WM9713 is not set
> > CONFIG_TOUCHSCREEN_USB_COMPOSITE=y
> > # CONFIG_TOUCHSCREEN_MC13783 is not set
> > CONFIG_TOUCHSCREEN_USB_EGALAX=y
> > CONFIG_TOUCHSCREEN_USB_PANJIT=y
> > CONFIG_TOUCHSCREEN_USB_3M=y
> > CONFIG_TOUCHSCREEN_USB_ITM=y
> > CONFIG_TOUCHSCREEN_USB_ETURBO=y
> > CONFIG_TOUCHSCREEN_USB_GUNZE=y
> > CONFIG_TOUCHSCREEN_USB_DMC_TSC10=y
> > CONFIG_TOUCHSCREEN_USB_IRTOUCH=y
> > CONFIG_TOUCHSCREEN_USB_IDEALTEK=y
> > CONFIG_TOUCHSCREEN_USB_GENERAL_TOUCH=y
> > CONFIG_TOUCHSCREEN_USB_GOTOP=y
> > CONFIG_TOUCHSCREEN_USB_JASTEC=y
> > CONFIG_TOUCHSCREEN_USB_ELO=y
> > CONFIG_TOUCHSCREEN_USB_E2I=y
> > CONFIG_TOUCHSCREEN_USB_ZYTRONIC=y
> > CONFIG_TOUCHSCREEN_USB_ETT_TC45USB=y
> > CONFIG_TOUCHSCREEN_USB_NEXIO=y
> > CONFIG_TOUCHSCREEN_USB_EASYTOUCH=y
> > CONFIG_TOUCHSCREEN_TOUCHIT213=y
> > CONFIG_TOUCHSCREEN_TSC_SERIO=y
> > CONFIG_TOUCHSCREEN_TSC200X_CORE=y
> > CONFIG_TOUCHSCREEN_TSC2004=y
> > CONFIG_TOUCHSCREEN_TSC2007=y
> > CONFIG_TOUCHSCREEN_TSC2007_IIO=y
> > CONFIG_TOUCHSCREEN_RM_TS=y
> > CONFIG_TOUCHSCREEN_SILEAD=y
> > CONFIG_TOUCHSCREEN_SIS_I2C=y
> > # CONFIG_TOUCHSCREEN_ST1232 is not set
> > # CONFIG_TOUCHSCREEN_STMFTS is not set
> > CONFIG_TOUCHSCREEN_STMPE=y
> > # CONFIG_TOUCHSCREEN_SX8654 is not set
> > CONFIG_TOUCHSCREEN_TPS6507X=y
> > CONFIG_TOUCHSCREEN_ZET6223=y
> > CONFIG_TOUCHSCREEN_ZFORCE=y
> > # CONFIG_TOUCHSCREEN_COLIBRI_VF50 is not set
> > # CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
> > # CONFIG_INPUT_MISC is not set
> > CONFIG_RMI4_CORE=y
> > # CONFIG_RMI4_I2C is not set
> > CONFIG_RMI4_SMB=y
> > CONFIG_RMI4_F03=y
> > CONFIG_RMI4_F03_SERIO=y
> > # CONFIG_RMI4_F11 is not set
> > # CONFIG_RMI4_F12 is not set
> > CONFIG_RMI4_F30=y
> > # CONFIG_RMI4_F34 is not set
> > # CONFIG_RMI4_F54 is not set
> > # CONFIG_RMI4_F55 is not set
> > 
> > #
> > # Hardware I/O ports
> > #
> > CONFIG_SERIO=y
> > CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
> > CONFIG_SERIO_I8042=y
> > CONFIG_SERIO_SERPORT=y
> > CONFIG_SERIO_CT82C710=y
> > # CONFIG_SERIO_PCIPS2 is not set
> > CONFIG_SERIO_LIBPS2=y
> > # CONFIG_SERIO_RAW is not set
> > CONFIG_SERIO_ALTERA_PS2=y
> > CONFIG_SERIO_PS2MULT=y
> > CONFIG_SERIO_ARC_PS2=y
> > # CONFIG_SERIO_APBPS2 is not set
> > CONFIG_SERIO_GPIO_PS2=y
> > CONFIG_USERIO=y
> > CONFIG_GAMEPORT=y
> > CONFIG_GAMEPORT_NS558=y
> > CONFIG_GAMEPORT_L4=y
> > # CONFIG_GAMEPORT_EMU10K1 is not set
> > # CONFIG_GAMEPORT_FM801 is not set
> > 
> > #
> > # Character devices
> > #
> > CONFIG_TTY=y
> > CONFIG_VT=y
> > CONFIG_CONSOLE_TRANSLATIONS=y
> > CONFIG_VT_CONSOLE=y
> > CONFIG_VT_CONSOLE_SLEEP=y
> > CONFIG_HW_CONSOLE=y
> > CONFIG_VT_HW_CONSOLE_BINDING=y
> > CONFIG_UNIX98_PTYS=y
> > CONFIG_LEGACY_PTYS=y
> > CONFIG_LEGACY_PTY_COUNT=256
> > # CONFIG_SERIAL_NONSTANDARD is not set
> > # CONFIG_NOZOMI is not set
> > # CONFIG_N_GSM is not set
> > CONFIG_TRACE_ROUTER=y
> > CONFIG_TRACE_SINK=y
> > # CONFIG_GOLDFISH_TTY is not set
> > CONFIG_DEVMEM=y
> > # CONFIG_DEVKMEM is not set
> > 
> > #
> > # Serial drivers
> > #
> > CONFIG_SERIAL_EARLYCON=y
> > CONFIG_SERIAL_8250=y
> > CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
> > CONFIG_SERIAL_8250_PNP=y
> > # CONFIG_SERIAL_8250_FINTEK is not set
> > CONFIG_SERIAL_8250_CONSOLE=y
> > CONFIG_SERIAL_8250_PCI=y
> > CONFIG_SERIAL_8250_EXAR=y
> > CONFIG_SERIAL_8250_CS=y
> > # CONFIG_SERIAL_8250_MEN_MCB is not set
> > CONFIG_SERIAL_8250_NR_UARTS=4
> > CONFIG_SERIAL_8250_RUNTIME_UARTS=4
> > CONFIG_SERIAL_8250_EXTENDED=y
> > CONFIG_SERIAL_8250_MANY_PORTS=y
> > CONFIG_SERIAL_8250_ASPEED_VUART=y
> > CONFIG_SERIAL_8250_SHARE_IRQ=y
> > CONFIG_SERIAL_8250_DETECT_IRQ=y
> > CONFIG_SERIAL_8250_RSA=y
> > CONFIG_SERIAL_8250_DW=y
> > CONFIG_SERIAL_8250_RT288X=y
> > CONFIG_SERIAL_8250_LPSS=y
> > CONFIG_SERIAL_8250_MID=y
> > # CONFIG_SERIAL_8250_MOXA is not set
> > CONFIG_SERIAL_OF_PLATFORM=y
> > 
> > #
> > # Non-8250 serial port support
> > #
> > CONFIG_SERIAL_UARTLITE=y
> > CONFIG_SERIAL_UARTLITE_CONSOLE=y
> > CONFIG_SERIAL_UARTLITE_NR_UARTS=1
> > CONFIG_SERIAL_CORE=y
> > CONFIG_SERIAL_CORE_CONSOLE=y
> > # CONFIG_SERIAL_JSM is not set
> > CONFIG_SERIAL_SCCNXP=y
> > CONFIG_SERIAL_SCCNXP_CONSOLE=y
> > CONFIG_SERIAL_SC16IS7XX_CORE=y
> > CONFIG_SERIAL_SC16IS7XX=y
> > CONFIG_SERIAL_SC16IS7XX_I2C=y
> > # CONFIG_SERIAL_ALTERA_JTAGUART is not set
> > CONFIG_SERIAL_ALTERA_UART=y
> > CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
> > CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
> > CONFIG_SERIAL_ALTERA_UART_CONSOLE=y
> > # CONFIG_SERIAL_XILINX_PS_UART is not set
> > # CONFIG_SERIAL_ARC is not set
> > # CONFIG_SERIAL_RP2 is not set
> > CONFIG_SERIAL_FSL_LPUART=y
> > CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
> > CONFIG_SERIAL_CONEXANT_DIGICOLOR=y
> > # CONFIG_SERIAL_CONEXANT_DIGICOLOR_CONSOLE is not set
> > # CONFIG_SERIAL_MEN_Z135 is not set
> > CONFIG_SERIAL_DEV_BUS=y
> > CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
> > CONFIG_HVC_DRIVER=y
> > CONFIG_VIRTIO_CONSOLE=y
> > # CONFIG_IPMI_HANDLER is not set
> > CONFIG_HW_RANDOM=y
> > CONFIG_HW_RANDOM_TIMERIOMEM=y
> > CONFIG_HW_RANDOM_INTEL=y
> > CONFIG_HW_RANDOM_AMD=y
> > # CONFIG_HW_RANDOM_VIA is not set
> > CONFIG_HW_RANDOM_VIRTIO=y
> > # CONFIG_NVRAM is not set
> > CONFIG_R3964=y
> > # CONFIG_APPLICOM is not set
> > 
> > #
> > # PCMCIA character devices
> > #
> > CONFIG_SYNCLINK_CS=y
> > # CONFIG_CARDMAN_4000 is not set
> > CONFIG_CARDMAN_4040=y
> > CONFIG_SCR24X=y
> > # CONFIG_IPWIRELESS is not set
> > CONFIG_MWAVE=y
> > CONFIG_RAW_DRIVER=y
> > CONFIG_MAX_RAW_DEVS=256
> > # CONFIG_HPET is not set
> > # CONFIG_HANGCHECK_TIMER is not set
> > CONFIG_TCG_TPM=y
> > CONFIG_HW_RANDOM_TPM=y
> > # CONFIG_TCG_TIS is not set
> > CONFIG_TCG_TIS_I2C_ATMEL=y
> > CONFIG_TCG_TIS_I2C_INFINEON=y
> > # CONFIG_TCG_TIS_I2C_NUVOTON is not set
> > CONFIG_TCG_NSC=y
> > # CONFIG_TCG_ATMEL is not set
> > # CONFIG_TCG_INFINEON is not set
> > # CONFIG_TCG_CRB is not set
> > CONFIG_TCG_VTPM_PROXY=y
> > CONFIG_TCG_TIS_ST33ZP24=y
> > CONFIG_TCG_TIS_ST33ZP24_I2C=y
> > CONFIG_TELCLOCK=y
> > CONFIG_DEVPORT=y
> > CONFIG_XILLYBUS=y
> > # CONFIG_XILLYBUS_OF is not set
> > 
> > #
> > # I2C support
> > #
> > CONFIG_I2C=y
> > CONFIG_ACPI_I2C_OPREGION=y
> > CONFIG_I2C_BOARDINFO=y
> > CONFIG_I2C_COMPAT=y
> > CONFIG_I2C_CHARDEV=y
> > CONFIG_I2C_MUX=y
> > 
> > #
> > # Multiplexer I2C Chip support
> > #
> > CONFIG_I2C_ARB_GPIO_CHALLENGE=y
> > CONFIG_I2C_MUX_GPIO=y
> > # CONFIG_I2C_MUX_GPMUX is not set
> > CONFIG_I2C_MUX_LTC4306=y
> > CONFIG_I2C_MUX_PCA9541=y
> > CONFIG_I2C_MUX_PCA954x=y
> > CONFIG_I2C_MUX_PINCTRL=y
> > CONFIG_I2C_MUX_REG=y
> > CONFIG_I2C_DEMUX_PINCTRL=y
> > CONFIG_I2C_MUX_MLXCPLD=y
> > CONFIG_I2C_HELPER_AUTO=y
> > CONFIG_I2C_SMBUS=y
> > CONFIG_I2C_ALGOBIT=y
> > 
> > #
> > # I2C Hardware Bus support
> > #
> > 
> > #
> > # PC SMBus host controller drivers
> > #
> > # CONFIG_I2C_ALI1535 is not set
> > # CONFIG_I2C_ALI1563 is not set
> > # CONFIG_I2C_ALI15X3 is not set
> > # CONFIG_I2C_AMD756 is not set
> > # CONFIG_I2C_AMD8111 is not set
> > # CONFIG_I2C_I801 is not set
> > # CONFIG_I2C_ISCH is not set
> > # CONFIG_I2C_ISMT is not set
> > # CONFIG_I2C_PIIX4 is not set
> > # CONFIG_I2C_NFORCE2 is not set
> > # CONFIG_I2C_SIS5595 is not set
> > # CONFIG_I2C_SIS630 is not set
> > # CONFIG_I2C_SIS96X is not set
> > # CONFIG_I2C_VIA is not set
> > # CONFIG_I2C_VIAPRO is not set
> > 
> > #
> > # ACPI drivers
> > #
> > # CONFIG_I2C_SCMI is not set
> > 
> > #
> > # I2C system bus drivers (mostly embedded / system-on-chip)
> > #
> > CONFIG_I2C_CBUS_GPIO=y
> > CONFIG_I2C_DESIGNWARE_CORE=y
> > CONFIG_I2C_DESIGNWARE_PLATFORM=y
> > CONFIG_I2C_DESIGNWARE_SLAVE=y
> > # CONFIG_I2C_DESIGNWARE_PCI is not set
> > # CONFIG_I2C_EMEV2 is not set
> > CONFIG_I2C_GPIO=y
> > CONFIG_I2C_GPIO_FAULT_INJECTOR=y
> > CONFIG_I2C_OCORES=y
> > # CONFIG_I2C_PCA_PLATFORM is not set
> > # CONFIG_I2C_RK3X is not set
> > CONFIG_I2C_SIMTEC=y
> > CONFIG_I2C_XILINX=y
> > 
> > #
> > # External I2C/SMBus adapter drivers
> > #
> > CONFIG_I2C_DIOLAN_U2C=y
> > CONFIG_I2C_DLN2=y
> > CONFIG_I2C_PARPORT_LIGHT=y
> > CONFIG_I2C_ROBOTFUZZ_OSIF=y
> > # CONFIG_I2C_TAOS_EVM is not set
> > # CONFIG_I2C_TINY_USB is not set
> > # CONFIG_I2C_VIPERBOARD is not set
> > 
> > #
> > # Other I2C/SMBus bus drivers
> > #
> > CONFIG_I2C_MLXCPLD=y
> > CONFIG_I2C_CROS_EC_TUNNEL=y
> > CONFIG_I2C_SLAVE=y
> > CONFIG_I2C_SLAVE_EEPROM=y
> > # CONFIG_I2C_DEBUG_CORE is not set
> > # CONFIG_I2C_DEBUG_ALGO is not set
> > # CONFIG_I2C_DEBUG_BUS is not set
> > # CONFIG_SPI is not set
> > CONFIG_SPMI=y
> > CONFIG_HSI=y
> > CONFIG_HSI_BOARDINFO=y
> > 
> > #
> > # HSI controllers
> > #
> > 
> > #
> > # HSI clients
> > #
> > # CONFIG_HSI_CHAR is not set
> > CONFIG_PPS=y
> > # CONFIG_PPS_DEBUG is not set
> > # CONFIG_NTP_PPS is not set
> > 
> > #
> > # PPS clients support
> > #
> > # CONFIG_PPS_CLIENT_KTIMER is not set
> > # CONFIG_PPS_CLIENT_LDISC is not set
> > # CONFIG_PPS_CLIENT_GPIO is not set
> > 
> > #
> > # PPS generators support
> > #
> > 
> > #
> > # PTP clock support
> > #
> > CONFIG_PTP_1588_CLOCK=y
> > 
> > #
> > # Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
> > #
> > CONFIG_PTP_1588_CLOCK_KVM=y
> > CONFIG_PINCTRL=y
> > CONFIG_GENERIC_PINCTRL_GROUPS=y
> > CONFIG_PINMUX=y
> > CONFIG_GENERIC_PINMUX_FUNCTIONS=y
> > CONFIG_PINCONF=y
> > CONFIG_GENERIC_PINCONF=y
> > # CONFIG_DEBUG_PINCTRL is not set
> > # CONFIG_PINCTRL_AXP209 is not set
> > # CONFIG_PINCTRL_AMD is not set
> > # CONFIG_PINCTRL_MCP23S08 is not set
> > CONFIG_PINCTRL_SINGLE=y
> > # CONFIG_PINCTRL_SX150X is not set
> > # CONFIG_PINCTRL_MAX77620 is not set
> > CONFIG_PINCTRL_PALMAS=y
> > CONFIG_PINCTRL_RK805=y
> > # CONFIG_PINCTRL_BAYTRAIL is not set
> > # CONFIG_PINCTRL_CHERRYVIEW is not set
> > # CONFIG_PINCTRL_BROXTON is not set
> > # CONFIG_PINCTRL_CANNONLAKE is not set
> > # CONFIG_PINCTRL_CEDARFORK is not set
> > # CONFIG_PINCTRL_DENVERTON is not set
> > # CONFIG_PINCTRL_GEMINILAKE is not set
> > # CONFIG_PINCTRL_LEWISBURG is not set
> > # CONFIG_PINCTRL_SUNRISEPOINT is not set
> > CONFIG_GPIOLIB=y
> > CONFIG_GPIOLIB_FASTPATH_LIMIT=512
> > CONFIG_OF_GPIO=y
> > CONFIG_GPIO_ACPI=y
> > CONFIG_GPIOLIB_IRQCHIP=y
> > # CONFIG_DEBUG_GPIO is not set
> > CONFIG_GPIO_SYSFS=y
> > CONFIG_GPIO_GENERIC=y
> > 
> > #
> > # Memory mapped GPIO drivers
> > #
> > CONFIG_GPIO_74XX_MMIO=y
> > CONFIG_GPIO_ALTERA=y
> > # CONFIG_GPIO_AMDPT is not set
> > CONFIG_GPIO_DWAPB=y
> > # CONFIG_GPIO_EXAR is not set
> > CONFIG_GPIO_FTGPIO010=y
> > CONFIG_GPIO_GENERIC_PLATFORM=y
> > CONFIG_GPIO_GRGPIO=y
> > # CONFIG_GPIO_HLWD is not set
> > # CONFIG_GPIO_ICH is not set
> > # CONFIG_GPIO_LYNXPOINT is not set
> > CONFIG_GPIO_MB86S7X=y
> > # CONFIG_GPIO_MENZ127 is not set
> > CONFIG_GPIO_MOCKUP=y
> > CONFIG_GPIO_SYSCON=y
> > # CONFIG_GPIO_VX855 is not set
> > # CONFIG_GPIO_XILINX is not set
> > 
> > #
> > # Port-mapped I/O GPIO drivers
> > #
> > # CONFIG_GPIO_F7188X is not set
> > CONFIG_GPIO_IT87=y
> > # CONFIG_GPIO_SCH is not set
> > CONFIG_GPIO_SCH311X=y
> > # CONFIG_GPIO_WINBOND is not set
> > CONFIG_GPIO_WS16C48=y
> > 
> > #
> > # I2C GPIO expanders
> > #
> > CONFIG_GPIO_ADP5588=y
> > CONFIG_GPIO_ADP5588_IRQ=y
> > CONFIG_GPIO_ADNP=y
> > # CONFIG_GPIO_MAX7300 is not set
> > CONFIG_GPIO_MAX732X=y
> > # CONFIG_GPIO_MAX732X_IRQ is not set
> > CONFIG_GPIO_PCA953X=y
> > # CONFIG_GPIO_PCA953X_IRQ is not set
> > CONFIG_GPIO_PCF857X=y
> > CONFIG_GPIO_TPIC2810=y
> > 
> > #
> > # MFD GPIO expanders
> > #
> > CONFIG_GPIO_BD9571MWV=y
> > # CONFIG_GPIO_DA9052 is not set
> > CONFIG_GPIO_DA9055=y
> > # CONFIG_GPIO_DLN2 is not set
> > # CONFIG_GPIO_LP3943 is not set
> > CONFIG_GPIO_LP873X=y
> > CONFIG_GPIO_LP87565=y
> > # CONFIG_GPIO_MAX77620 is not set
> > CONFIG_GPIO_PALMAS=y
> > CONFIG_GPIO_STMPE=y
> > CONFIG_GPIO_TC3589X=y
> > # CONFIG_GPIO_TPS65086 is not set
> > CONFIG_GPIO_TPS65218=y
> > # CONFIG_GPIO_TPS6586X is not set
> > # CONFIG_GPIO_TPS65910 is not set
> > # CONFIG_GPIO_TPS65912 is not set
> > CONFIG_GPIO_UCB1400=y
> > CONFIG_GPIO_WM831X=y
> > # CONFIG_GPIO_WM8994 is not set
> > 
> > #
> > # PCI GPIO expanders
> > #
> > # CONFIG_GPIO_AMD8111 is not set
> > # CONFIG_GPIO_BT8XX is not set
> > # CONFIG_GPIO_ML_IOH is not set
> > # CONFIG_GPIO_PCI_IDIO_16 is not set
> > # CONFIG_GPIO_PCIE_IDIO_24 is not set
> > # CONFIG_GPIO_RDC321X is not set
> > # CONFIG_GPIO_SODAVILLE is not set
> > 
> > #
> > # USB GPIO expanders
> > #
> > # CONFIG_GPIO_VIPERBOARD is not set
> > CONFIG_W1=y
> > 
> > #
> > # 1-wire Bus Masters
> > #
> > # CONFIG_W1_MASTER_MATROX is not set
> > CONFIG_W1_MASTER_DS2490=y
> > CONFIG_W1_MASTER_DS2482=y
> > # CONFIG_W1_MASTER_DS1WM is not set
> > CONFIG_W1_MASTER_GPIO=y
> > 
> > #
> > # 1-wire Slaves
> > #
> > CONFIG_W1_SLAVE_THERM=y
> > # CONFIG_W1_SLAVE_SMEM is not set
> > # CONFIG_W1_SLAVE_DS2405 is not set
> > CONFIG_W1_SLAVE_DS2408=y
> > CONFIG_W1_SLAVE_DS2408_READBACK=y
> > # CONFIG_W1_SLAVE_DS2413 is not set
> > CONFIG_W1_SLAVE_DS2406=y
> > CONFIG_W1_SLAVE_DS2423=y
> > # CONFIG_W1_SLAVE_DS2805 is not set
> > # CONFIG_W1_SLAVE_DS2431 is not set
> > # CONFIG_W1_SLAVE_DS2433 is not set
> > CONFIG_W1_SLAVE_DS2438=y
> > CONFIG_W1_SLAVE_DS2760=y
> > CONFIG_W1_SLAVE_DS2780=y
> > CONFIG_W1_SLAVE_DS2781=y
> > # CONFIG_W1_SLAVE_DS28E04 is not set
> > CONFIG_W1_SLAVE_DS28E17=y
> > # CONFIG_POWER_AVS is not set
> > # CONFIG_POWER_RESET is not set
> > CONFIG_POWER_SUPPLY=y
> > CONFIG_POWER_SUPPLY_DEBUG=y
> > # CONFIG_PDA_POWER is not set
> > # CONFIG_GENERIC_ADC_BATTERY is not set
> > CONFIG_MAX8925_POWER=y
> > CONFIG_WM831X_BACKUP=y
> > CONFIG_WM831X_POWER=y
> > # CONFIG_TEST_POWER is not set
> > # CONFIG_BATTERY_ACT8945A is not set
> > CONFIG_BATTERY_DS2760=y
> > CONFIG_BATTERY_DS2780=y
> > # CONFIG_BATTERY_DS2781 is not set
> > # CONFIG_BATTERY_DS2782 is not set
> > CONFIG_BATTERY_LEGO_EV3=y
> > # CONFIG_BATTERY_WM97XX is not set
> > CONFIG_BATTERY_SBS=y
> > # CONFIG_CHARGER_SBS is not set
> > CONFIG_MANAGER_SBS=y
> > # CONFIG_BATTERY_BQ27XXX is not set
> > CONFIG_BATTERY_DA9030=y
> > CONFIG_BATTERY_DA9052=y
> > CONFIG_CHARGER_DA9150=y
> > CONFIG_BATTERY_DA9150=y
> > CONFIG_CHARGER_AXP20X=y
> > CONFIG_BATTERY_AXP20X=y
> > # CONFIG_AXP20X_POWER is not set
> > CONFIG_AXP288_CHARGER=y
> > # CONFIG_AXP288_FUEL_GAUGE is not set
> > CONFIG_BATTERY_MAX17040=y
> > CONFIG_BATTERY_MAX17042=y
> > CONFIG_BATTERY_MAX1721X=y
> > CONFIG_CHARGER_PCF50633=y
> > CONFIG_CHARGER_ISP1704=y
> > CONFIG_CHARGER_MAX8903=y
> > CONFIG_CHARGER_LP8727=y
> > # CONFIG_CHARGER_GPIO is not set
> > # CONFIG_CHARGER_MANAGER is not set
> > CONFIG_CHARGER_LTC3651=y
> > CONFIG_CHARGER_MAX14577=y
> > # CONFIG_CHARGER_DETECTOR_MAX14656 is not set
> > CONFIG_CHARGER_MAX77693=y
> > CONFIG_CHARGER_BQ2415X=y
> > CONFIG_CHARGER_BQ24190=y
> > CONFIG_CHARGER_BQ24257=y
> > CONFIG_CHARGER_BQ24735=y
> > # CONFIG_CHARGER_BQ25890 is not set
> > CONFIG_CHARGER_SMB347=y
> > # CONFIG_CHARGER_TPS65090 is not set
> > CONFIG_CHARGER_TPS65217=y
> > # CONFIG_BATTERY_GAUGE_LTC2941 is not set
> > # CONFIG_BATTERY_GOLDFISH is not set
> > CONFIG_BATTERY_RT5033=y
> > # CONFIG_CHARGER_RT9455 is not set
> > CONFIG_HWMON=y
> > CONFIG_HWMON_VID=y
> > CONFIG_HWMON_DEBUG_CHIP=y
> > 
> > #
> > # Native drivers
> > #
> > CONFIG_SENSORS_ABITUGURU=y
> > # CONFIG_SENSORS_ABITUGURU3 is not set
> > # CONFIG_SENSORS_AD7414 is not set
> > # CONFIG_SENSORS_AD7418 is not set
> > # CONFIG_SENSORS_ADM1021 is not set
> > CONFIG_SENSORS_ADM1025=y
> > CONFIG_SENSORS_ADM1026=y
> > CONFIG_SENSORS_ADM1029=y
> > CONFIG_SENSORS_ADM1031=y
> > CONFIG_SENSORS_ADM9240=y
> > CONFIG_SENSORS_ADT7X10=y
> > CONFIG_SENSORS_ADT7410=y
> > # CONFIG_SENSORS_ADT7411 is not set
> > CONFIG_SENSORS_ADT7462=y
> > CONFIG_SENSORS_ADT7470=y
> > # CONFIG_SENSORS_ADT7475 is not set
> > CONFIG_SENSORS_ASC7621=y
> > # CONFIG_SENSORS_K8TEMP is not set
> > # CONFIG_SENSORS_K10TEMP is not set
> > # CONFIG_SENSORS_FAM15H_POWER is not set
> > CONFIG_SENSORS_APPLESMC=y
> > CONFIG_SENSORS_ASB100=y
> > # CONFIG_SENSORS_ASPEED is not set
> > # CONFIG_SENSORS_ATXP1 is not set
> > CONFIG_SENSORS_DS620=y
> > # CONFIG_SENSORS_DS1621 is not set
> > # CONFIG_SENSORS_DELL_SMM is not set
> > CONFIG_SENSORS_DA9052_ADC=y
> > # CONFIG_SENSORS_DA9055 is not set
> > # CONFIG_SENSORS_I5K_AMB is not set
> > CONFIG_SENSORS_F71805F=y
> > CONFIG_SENSORS_F71882FG=y
> > CONFIG_SENSORS_F75375S=y
> > CONFIG_SENSORS_MC13783_ADC=y
> > CONFIG_SENSORS_FSCHMD=y
> > CONFIG_SENSORS_GL518SM=y
> > CONFIG_SENSORS_GL520SM=y
> > # CONFIG_SENSORS_G760A is not set
> > # CONFIG_SENSORS_G762 is not set
> > CONFIG_SENSORS_GPIO_FAN=y
> > CONFIG_SENSORS_HIH6130=y
> > CONFIG_SENSORS_IIO_HWMON=y
> > # CONFIG_SENSORS_I5500 is not set
> > CONFIG_SENSORS_CORETEMP=y
> > CONFIG_SENSORS_IT87=y
> > CONFIG_SENSORS_JC42=y
> > # CONFIG_SENSORS_POWR1220 is not set
> > CONFIG_SENSORS_LINEAGE=y
> > CONFIG_SENSORS_LTC2945=y
> > CONFIG_SENSORS_LTC2990=y
> > # CONFIG_SENSORS_LTC4151 is not set
> > CONFIG_SENSORS_LTC4215=y
> > CONFIG_SENSORS_LTC4222=y
> > CONFIG_SENSORS_LTC4245=y
> > CONFIG_SENSORS_LTC4260=y
> > CONFIG_SENSORS_LTC4261=y
> > CONFIG_SENSORS_MAX16065=y
> > # CONFIG_SENSORS_MAX1619 is not set
> > CONFIG_SENSORS_MAX1668=y
> > CONFIG_SENSORS_MAX197=y
> > CONFIG_SENSORS_MAX6621=y
> > # CONFIG_SENSORS_MAX6639 is not set
> > CONFIG_SENSORS_MAX6642=y
> > CONFIG_SENSORS_MAX6650=y
> > CONFIG_SENSORS_MAX6697=y
> > CONFIG_SENSORS_MAX31790=y
> > CONFIG_SENSORS_MCP3021=y
> > CONFIG_SENSORS_TC654=y
> > CONFIG_SENSORS_MENF21BMC_HWMON=y
> > CONFIG_SENSORS_LM63=y
> > # CONFIG_SENSORS_LM73 is not set
> > CONFIG_SENSORS_LM75=y
> > CONFIG_SENSORS_LM77=y
> > CONFIG_SENSORS_LM78=y
> > CONFIG_SENSORS_LM80=y
> > CONFIG_SENSORS_LM83=y
> > CONFIG_SENSORS_LM85=y
> > # CONFIG_SENSORS_LM87 is not set
> > CONFIG_SENSORS_LM90=y
> > # CONFIG_SENSORS_LM92 is not set
> > # CONFIG_SENSORS_LM93 is not set
> > # CONFIG_SENSORS_LM95234 is not set
> > CONFIG_SENSORS_LM95241=y
> > CONFIG_SENSORS_LM95245=y
> > CONFIG_SENSORS_PC87360=y
> > # CONFIG_SENSORS_PC87427 is not set
> > # CONFIG_SENSORS_NTC_THERMISTOR is not set
> > # CONFIG_SENSORS_NCT6683 is not set
> > CONFIG_SENSORS_NCT6775=y
> > CONFIG_SENSORS_NCT7802=y
> > CONFIG_SENSORS_NCT7904=y
> > CONFIG_SENSORS_PCF8591=y
> > CONFIG_PMBUS=y
> > CONFIG_SENSORS_PMBUS=y
> > CONFIG_SENSORS_ADM1275=y
> > CONFIG_SENSORS_IBM_CFFPS=y
> > CONFIG_SENSORS_IR35221=y
> > # CONFIG_SENSORS_LM25066 is not set
> > CONFIG_SENSORS_LTC2978=y
> > # CONFIG_SENSORS_LTC2978_REGULATOR is not set
> > # CONFIG_SENSORS_LTC3815 is not set
> > CONFIG_SENSORS_MAX16064=y
> > CONFIG_SENSORS_MAX20751=y
> > # CONFIG_SENSORS_MAX31785 is not set
> > CONFIG_SENSORS_MAX34440=y
> > # CONFIG_SENSORS_MAX8688 is not set
> > # CONFIG_SENSORS_TPS40422 is not set
> > CONFIG_SENSORS_TPS53679=y
> > CONFIG_SENSORS_UCD9000=y
> > CONFIG_SENSORS_UCD9200=y
> > # CONFIG_SENSORS_ZL6100 is not set
> > CONFIG_SENSORS_SHT15=y
> > CONFIG_SENSORS_SHT21=y
> > CONFIG_SENSORS_SHT3x=y
> > CONFIG_SENSORS_SHTC1=y
> > # CONFIG_SENSORS_SIS5595 is not set
> > # CONFIG_SENSORS_DME1737 is not set
> > CONFIG_SENSORS_EMC1403=y
> > CONFIG_SENSORS_EMC2103=y
> > # CONFIG_SENSORS_EMC6W201 is not set
> > # CONFIG_SENSORS_SMSC47M1 is not set
> > # CONFIG_SENSORS_SMSC47M192 is not set
> > CONFIG_SENSORS_SMSC47B397=y
> > CONFIG_SENSORS_STTS751=y
> > CONFIG_SENSORS_SMM665=y
> > CONFIG_SENSORS_ADC128D818=y
> > # CONFIG_SENSORS_ADS1015 is not set
> > CONFIG_SENSORS_ADS7828=y
> > CONFIG_SENSORS_AMC6821=y
> > # CONFIG_SENSORS_INA209 is not set
> > CONFIG_SENSORS_INA2XX=y
> > CONFIG_SENSORS_INA3221=y
> > CONFIG_SENSORS_TC74=y
> > # CONFIG_SENSORS_THMC50 is not set
> > # CONFIG_SENSORS_TMP102 is not set
> > CONFIG_SENSORS_TMP103=y
> > CONFIG_SENSORS_TMP108=y
> > CONFIG_SENSORS_TMP401=y
> > CONFIG_SENSORS_TMP421=y
> > CONFIG_SENSORS_VIA_CPUTEMP=y
> > # CONFIG_SENSORS_VIA686A is not set
> > CONFIG_SENSORS_VT1211=y
> > # CONFIG_SENSORS_VT8231 is not set
> > CONFIG_SENSORS_W83773G=y
> > CONFIG_SENSORS_W83781D=y
> > # CONFIG_SENSORS_W83791D is not set
> > CONFIG_SENSORS_W83792D=y
> > CONFIG_SENSORS_W83793=y
> > CONFIG_SENSORS_W83795=y
> > # CONFIG_SENSORS_W83795_FANCTRL is not set
> > CONFIG_SENSORS_W83L785TS=y
> > CONFIG_SENSORS_W83L786NG=y
> > # CONFIG_SENSORS_W83627HF is not set
> > CONFIG_SENSORS_W83627EHF=y
> > # CONFIG_SENSORS_WM831X is not set
> > 
> > #
> > # ACPI drivers
> > #
> > # CONFIG_SENSORS_ACPI_POWER is not set
> > # CONFIG_SENSORS_ATK0110 is not set
> > CONFIG_THERMAL=y
> > # CONFIG_THERMAL_STATISTICS is not set
> > CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
> > # CONFIG_THERMAL_HWMON is not set
> > CONFIG_THERMAL_OF=y
> > # CONFIG_THERMAL_WRITABLE_TRIPS is not set
> > # CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
> > CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE=y
> > # CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
> > # CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
> > CONFIG_THERMAL_GOV_FAIR_SHARE=y
> > CONFIG_THERMAL_GOV_STEP_WISE=y
> > CONFIG_THERMAL_GOV_BANG_BANG=y
> > # CONFIG_THERMAL_GOV_USER_SPACE is not set
> > CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
> > CONFIG_THERMAL_EMULATION=y
> > # CONFIG_MAX77620_THERMAL is not set
> > CONFIG_QORIQ_THERMAL=y
> > CONFIG_INTEL_POWERCLAMP=y
> > # CONFIG_INTEL_SOC_DTS_THERMAL is not set
> > 
> > #
> > # ACPI INT340X thermal drivers
> > #
> > # CONFIG_INT340X_THERMAL is not set
> > # CONFIG_INTEL_PCH_THERMAL is not set
> > CONFIG_QCOM_SPMI_TEMP_ALARM=y
> > CONFIG_GENERIC_ADC_THERMAL=y
> > # CONFIG_WATCHDOG is not set
> > CONFIG_SSB_POSSIBLE=y
> > CONFIG_SSB=y
> > CONFIG_SSB_SPROM=y
> > CONFIG_SSB_PCIHOST_POSSIBLE=y
> > CONFIG_SSB_PCIHOST=y
> > CONFIG_SSB_PCMCIAHOST_POSSIBLE=y
> > # CONFIG_SSB_PCMCIAHOST is not set
> > CONFIG_SSB_SDIOHOST_POSSIBLE=y
> > CONFIG_SSB_SDIOHOST=y
> > # CONFIG_SSB_DEBUG is not set
> > CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
> > # CONFIG_SSB_DRIVER_PCICORE is not set
> > # CONFIG_SSB_DRIVER_GPIO is not set
> > CONFIG_BCMA_POSSIBLE=y
> > CONFIG_BCMA=y
> > CONFIG_BCMA_HOST_PCI_POSSIBLE=y
> > CONFIG_BCMA_HOST_PCI=y
> > CONFIG_BCMA_HOST_SOC=y
> > CONFIG_BCMA_DRIVER_PCI=y
> > # CONFIG_BCMA_SFLASH is not set
> > # CONFIG_BCMA_DRIVER_GMAC_CMN is not set
> > # CONFIG_BCMA_DRIVER_GPIO is not set
> > CONFIG_BCMA_DEBUG=y
> > 
> > #
> > # Multifunction device drivers
> > #
> > CONFIG_MFD_CORE=y
> > CONFIG_MFD_ACT8945A=y
> > # CONFIG_MFD_AS3711 is not set
> > # CONFIG_MFD_AS3722 is not set
> > # CONFIG_PMIC_ADP5520 is not set
> > CONFIG_MFD_AAT2870_CORE=y
> > CONFIG_MFD_ATMEL_FLEXCOM=y
> > # CONFIG_MFD_ATMEL_HLCDC is not set
> > CONFIG_MFD_BCM590XX=y
> > CONFIG_MFD_BD9571MWV=y
> > CONFIG_MFD_AXP20X=y
> > CONFIG_MFD_AXP20X_I2C=y
> > CONFIG_MFD_CROS_EC=y
> > CONFIG_MFD_CROS_EC_I2C=y
> > # CONFIG_MFD_CROS_EC_CHARDEV is not set
> > CONFIG_PMIC_DA903X=y
> > CONFIG_PMIC_DA9052=y
> > CONFIG_MFD_DA9052_I2C=y
> > CONFIG_MFD_DA9055=y
> > # CONFIG_MFD_DA9062 is not set
> > CONFIG_MFD_DA9063=y
> > CONFIG_MFD_DA9150=y
> > CONFIG_MFD_DLN2=y
> > CONFIG_MFD_MC13XXX=y
> > CONFIG_MFD_MC13XXX_I2C=y
> > CONFIG_MFD_HI6421_PMIC=y
> > # CONFIG_HTC_PASIC3 is not set
> > CONFIG_HTC_I2CPLD=y
> > # CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
> > # CONFIG_LPC_ICH is not set
> > # CONFIG_LPC_SCH is not set
> > # CONFIG_INTEL_SOC_PMIC is not set
> > # CONFIG_INTEL_SOC_PMIC_CHTWC is not set
> > # CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
> > # CONFIG_MFD_INTEL_LPSS_ACPI is not set
> > # CONFIG_MFD_INTEL_LPSS_PCI is not set
> > # CONFIG_MFD_JANZ_CMODIO is not set
> > # CONFIG_MFD_KEMPLD is not set
> > CONFIG_MFD_88PM800=y
> > CONFIG_MFD_88PM805=y
> > # CONFIG_MFD_88PM860X is not set
> > CONFIG_MFD_MAX14577=y
> > CONFIG_MFD_MAX77620=y
> > CONFIG_MFD_MAX77686=y
> > CONFIG_MFD_MAX77693=y
> > # CONFIG_MFD_MAX77843 is not set
> > # CONFIG_MFD_MAX8907 is not set
> > CONFIG_MFD_MAX8925=y
> > # CONFIG_MFD_MAX8997 is not set
> > # CONFIG_MFD_MAX8998 is not set
> > CONFIG_MFD_MT6397=y
> > CONFIG_MFD_MENF21BMC=y
> > CONFIG_MFD_VIPERBOARD=y
> > CONFIG_MFD_RETU=y
> > CONFIG_MFD_PCF50633=y
> > # CONFIG_PCF50633_ADC is not set
> > CONFIG_PCF50633_GPIO=y
> > CONFIG_UCB1400_CORE=y
> > # CONFIG_MFD_RDC321X is not set
> > CONFIG_MFD_RT5033=y
> > # CONFIG_MFD_RC5T583 is not set
> > CONFIG_MFD_RK808=y
> > CONFIG_MFD_RN5T618=y
> > # CONFIG_MFD_SEC_CORE is not set
> > # CONFIG_MFD_SI476X_CORE is not set
> > CONFIG_MFD_SM501=y
> > # CONFIG_MFD_SM501_GPIO is not set
> > # CONFIG_MFD_SKY81452 is not set
> > CONFIG_MFD_SMSC=y
> > # CONFIG_ABX500_CORE is not set
> > CONFIG_MFD_STMPE=y
> > 
> > #
> > # STMicroelectronics STMPE Interface Drivers
> > #
> > CONFIG_STMPE_I2C=y
> > CONFIG_MFD_SYSCON=y
> > CONFIG_MFD_TI_AM335X_TSCADC=y
> > CONFIG_MFD_LP3943=y
> > # CONFIG_MFD_LP8788 is not set
> > CONFIG_MFD_TI_LMU=y
> > CONFIG_MFD_PALMAS=y
> > CONFIG_TPS6105X=y
> > # CONFIG_TPS65010 is not set
> > CONFIG_TPS6507X=y
> > CONFIG_MFD_TPS65086=y
> > CONFIG_MFD_TPS65090=y
> > CONFIG_MFD_TPS65217=y
> > # CONFIG_MFD_TPS68470 is not set
> > CONFIG_MFD_TI_LP873X=y
> > CONFIG_MFD_TI_LP87565=y
> > CONFIG_MFD_TPS65218=y
> > CONFIG_MFD_TPS6586X=y
> > CONFIG_MFD_TPS65910=y
> > CONFIG_MFD_TPS65912=y
> > CONFIG_MFD_TPS65912_I2C=y
> > # CONFIG_MFD_TPS80031 is not set
> > # CONFIG_TWL4030_CORE is not set
> > # CONFIG_TWL6040_CORE is not set
> > # CONFIG_MFD_WL1273_CORE is not set
> > # CONFIG_MFD_LM3533 is not set
> > CONFIG_MFD_TC3589X=y
> > # CONFIG_MFD_VX855 is not set
> > # CONFIG_MFD_ARIZONA_I2C is not set
> > CONFIG_MFD_WM8400=y
> > CONFIG_MFD_WM831X=y
> > CONFIG_MFD_WM831X_I2C=y
> > # CONFIG_MFD_WM8350_I2C is not set
> > CONFIG_MFD_WM8994=y
> > CONFIG_RAVE_SP_CORE=y
> > CONFIG_REGULATOR=y
> > # CONFIG_REGULATOR_DEBUG is not set
> > CONFIG_REGULATOR_FIXED_VOLTAGE=y
> > # CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
> > # CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
> > CONFIG_REGULATOR_88PG86X=y
> > CONFIG_REGULATOR_88PM800=y
> > # CONFIG_REGULATOR_ACT8865 is not set
> > # CONFIG_REGULATOR_ACT8945A is not set
> > CONFIG_REGULATOR_AD5398=y
> > CONFIG_REGULATOR_ANATOP=y
> > CONFIG_REGULATOR_AAT2870=y
> > # CONFIG_REGULATOR_AXP20X is not set
> > CONFIG_REGULATOR_BCM590XX=y
> > CONFIG_REGULATOR_BD9571MWV=y
> > # CONFIG_REGULATOR_DA903X is not set
> > CONFIG_REGULATOR_DA9052=y
> > CONFIG_REGULATOR_DA9055=y
> > CONFIG_REGULATOR_DA9063=y
> > CONFIG_REGULATOR_DA9210=y
> > CONFIG_REGULATOR_DA9211=y
> > CONFIG_REGULATOR_FAN53555=y
> > # CONFIG_REGULATOR_GPIO is not set
> > CONFIG_REGULATOR_HI6421=y
> > # CONFIG_REGULATOR_HI6421V530 is not set
> > CONFIG_REGULATOR_ISL9305=y
> > CONFIG_REGULATOR_ISL6271A=y
> > CONFIG_REGULATOR_LM363X=y
> > # CONFIG_REGULATOR_LP3971 is not set
> > CONFIG_REGULATOR_LP3972=y
> > CONFIG_REGULATOR_LP872X=y
> > CONFIG_REGULATOR_LP873X=y
> > # CONFIG_REGULATOR_LP8755 is not set
> > CONFIG_REGULATOR_LP87565=y
> > CONFIG_REGULATOR_LTC3589=y
> > CONFIG_REGULATOR_LTC3676=y
> > CONFIG_REGULATOR_MAX14577=y
> > CONFIG_REGULATOR_MAX1586=y
> > CONFIG_REGULATOR_MAX77620=y
> > CONFIG_REGULATOR_MAX8649=y
> > CONFIG_REGULATOR_MAX8660=y
> > # CONFIG_REGULATOR_MAX8925 is not set
> > # CONFIG_REGULATOR_MAX8952 is not set
> > CONFIG_REGULATOR_MAX8973=y
> > CONFIG_REGULATOR_MAX77686=y
> > CONFIG_REGULATOR_MAX77693=y
> > CONFIG_REGULATOR_MAX77802=y
> > CONFIG_REGULATOR_MC13XXX_CORE=y
> > CONFIG_REGULATOR_MC13783=y
> > CONFIG_REGULATOR_MC13892=y
> > # CONFIG_REGULATOR_MT6311 is not set
> > # CONFIG_REGULATOR_MT6323 is not set
> > CONFIG_REGULATOR_MT6397=y
> > # CONFIG_REGULATOR_PALMAS is not set
> > # CONFIG_REGULATOR_PCF50633 is not set
> > CONFIG_REGULATOR_PFUZE100=y
> > # CONFIG_REGULATOR_PV88060 is not set
> > # CONFIG_REGULATOR_PV88080 is not set
> > CONFIG_REGULATOR_PV88090=y
> > CONFIG_REGULATOR_QCOM_SPMI=y
> > # CONFIG_REGULATOR_RK808 is not set
> > CONFIG_REGULATOR_RN5T618=y
> > CONFIG_REGULATOR_RT5033=y
> > CONFIG_REGULATOR_SY8106A=y
> > CONFIG_REGULATOR_TPS51632=y
> > # CONFIG_REGULATOR_TPS6105X is not set
> > # CONFIG_REGULATOR_TPS62360 is not set
> > CONFIG_REGULATOR_TPS65023=y
> > # CONFIG_REGULATOR_TPS6507X is not set
> > CONFIG_REGULATOR_TPS65086=y
> > CONFIG_REGULATOR_TPS65090=y
> > # CONFIG_REGULATOR_TPS65132 is not set
> > CONFIG_REGULATOR_TPS65217=y
> > # CONFIG_REGULATOR_TPS65218 is not set
> > # CONFIG_REGULATOR_TPS6586X is not set
> > # CONFIG_REGULATOR_TPS65910 is not set
> > CONFIG_REGULATOR_TPS65912=y
> > CONFIG_REGULATOR_VCTRL=y
> > # CONFIG_REGULATOR_WM831X is not set
> > CONFIG_REGULATOR_WM8400=y
> > # CONFIG_REGULATOR_WM8994 is not set
> > CONFIG_RC_CORE=y
> > CONFIG_RC_MAP=y
> > # CONFIG_LIRC is not set
> > # CONFIG_RC_DECODERS is not set
> > # CONFIG_RC_DEVICES is not set
> > CONFIG_MEDIA_SUPPORT=y
> > 
> > #
> > # Multimedia core support
> > #
> > # CONFIG_MEDIA_CAMERA_SUPPORT is not set
> > # CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
> > CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
> > CONFIG_MEDIA_RADIO_SUPPORT=y
> > CONFIG_MEDIA_SDR_SUPPORT=y
> > # CONFIG_MEDIA_CEC_SUPPORT is not set
> > CONFIG_MEDIA_CONTROLLER=y
> > CONFIG_MEDIA_CONTROLLER_DVB=y
> > CONFIG_VIDEO_DEV=y
> > # CONFIG_VIDEO_V4L2_SUBDEV_API is not set
> > CONFIG_VIDEO_V4L2=y
> > # CONFIG_VIDEO_ADV_DEBUG is not set
> > # CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
> > CONFIG_V4L2_FWNODE=y
> > CONFIG_DVB_CORE=y
> > CONFIG_DVB_MMAP=y
> > CONFIG_DVB_NET=y
> > CONFIG_DVB_MAX_ADAPTERS=16
> > CONFIG_DVB_DYNAMIC_MINORS=y
> > CONFIG_DVB_DEMUX_SECTION_LOSS_LOG=y
> > CONFIG_DVB_ULE_DEBUG=y
> > 
> > #
> > # Media drivers
> > #
> > # CONFIG_MEDIA_USB_SUPPORT is not set
> > # CONFIG_MEDIA_PCI_SUPPORT is not set
> > # CONFIG_DVB_PLATFORM_DRIVERS is not set
> > # CONFIG_SDR_PLATFORM_DRIVERS is not set
> > 
> > #
> > # Supported MMC/SDIO adapters
> > #
> > CONFIG_SMS_SDIO_DRV=y
> > # CONFIG_RADIO_ADAPTERS is not set
> > 
> > #
> > # Supported FireWire (IEEE 1394) Adapters
> > #
> > # CONFIG_DVB_FIREDTV is not set
> > CONFIG_MEDIA_COMMON_OPTIONS=y
> > 
> > #
> > # common driver options
> > #
> > CONFIG_CYPRESS_FIRMWARE=y
> > CONFIG_VIDEOBUF2_CORE=y
> > CONFIG_VIDEOBUF2_V4L2=y
> > CONFIG_VIDEOBUF2_MEMOPS=y
> > CONFIG_VIDEOBUF2_VMALLOC=y
> > CONFIG_SMS_SIANO_MDTV=y
> > # CONFIG_SMS_SIANO_RC is not set
> > 
> > #
> > # Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
> > #
> > # CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
> > CONFIG_VIDEO_IR_I2C=y
> > 
> > #
> > # I2C Encoders, decoders, sensors and other helper chips
> > #
> > 
> > #
> > # Audio decoders, processors and mixers
> > #
> > CONFIG_VIDEO_TVAUDIO=y
> > CONFIG_VIDEO_TDA7432=y
> > # CONFIG_VIDEO_TDA9840 is not set
> > CONFIG_VIDEO_TEA6415C=y
> > # CONFIG_VIDEO_TEA6420 is not set
> > CONFIG_VIDEO_MSP3400=y
> > CONFIG_VIDEO_CS3308=y
> > CONFIG_VIDEO_CS5345=y
> > CONFIG_VIDEO_CS53L32A=y
> > CONFIG_VIDEO_TLV320AIC23B=y
> > CONFIG_VIDEO_UDA1342=y
> > # CONFIG_VIDEO_WM8775 is not set
> > # CONFIG_VIDEO_WM8739 is not set
> > CONFIG_VIDEO_VP27SMPX=y
> > # CONFIG_VIDEO_SONY_BTF_MPX is not set
> > 
> > #
> > # RDS decoders
> > #
> > CONFIG_VIDEO_SAA6588=y
> > 
> > #
> > # Video decoders
> > #
> > # CONFIG_VIDEO_ADV7183 is not set
> > CONFIG_VIDEO_BT819=y
> > # CONFIG_VIDEO_BT856 is not set
> > CONFIG_VIDEO_BT866=y
> > # CONFIG_VIDEO_KS0127 is not set
> > # CONFIG_VIDEO_ML86V7667 is not set
> > CONFIG_VIDEO_AD5820=y
> > # CONFIG_VIDEO_SAA7110 is not set
> > # CONFIG_VIDEO_SAA711X is not set
> > CONFIG_VIDEO_TVP514X=y
> > CONFIG_VIDEO_TVP5150=y
> > CONFIG_VIDEO_TVP7002=y
> > # CONFIG_VIDEO_TW2804 is not set
> > CONFIG_VIDEO_TW9903=y
> > CONFIG_VIDEO_TW9906=y
> > CONFIG_VIDEO_TW9910=y
> > # CONFIG_VIDEO_VPX3220 is not set
> > 
> > #
> > # Video and audio decoders
> > #
> > # CONFIG_VIDEO_SAA717X is not set
> > # CONFIG_VIDEO_CX25840 is not set
> > 
> > #
> > # Video encoders
> > #
> > # CONFIG_VIDEO_SAA7127 is not set
> > CONFIG_VIDEO_SAA7185=y
> > CONFIG_VIDEO_ADV7170=y
> > CONFIG_VIDEO_ADV7175=y
> > # CONFIG_VIDEO_ADV7343 is not set
> > # CONFIG_VIDEO_ADV7393 is not set
> > CONFIG_VIDEO_AK881X=y
> > CONFIG_VIDEO_THS8200=y
> > 
> > #
> > # Camera sensor devices
> > #
> > CONFIG_VIDEO_MT9M111=y
> > 
> > #
> > # Flash devices
> > #
> > 
> > #
> > # Video improvement chips
> > #
> > # CONFIG_VIDEO_UPD64031A is not set
> > # CONFIG_VIDEO_UPD64083 is not set
> > 
> > #
> > # Audio/Video compression chips
> > #
> > CONFIG_VIDEO_SAA6752HS=y
> > 
> > #
> > # SDR tuner chips
> > #
> > CONFIG_SDR_MAX2175=y
> > 
> > #
> > # Miscellaneous helper chips
> > #
> > CONFIG_VIDEO_THS7303=y
> > # CONFIG_VIDEO_M52790 is not set
> > CONFIG_VIDEO_I2C=y
> > 
> > #
> > # Sensors used on soc_camera driver
> > #
> > 
> > #
> > # SPI helper chips
> > #
> > CONFIG_MEDIA_TUNER=y
> > 
> > #
> > # Customize TV tuners
> > #
> > # CONFIG_MEDIA_TUNER_SIMPLE is not set
> > CONFIG_MEDIA_TUNER_TDA18250=y
> > # CONFIG_MEDIA_TUNER_TDA8290 is not set
> > CONFIG_MEDIA_TUNER_TDA827X=y
> > CONFIG_MEDIA_TUNER_TDA18271=y
> > CONFIG_MEDIA_TUNER_TDA9887=y
> > CONFIG_MEDIA_TUNER_TEA5761=y
> > CONFIG_MEDIA_TUNER_TEA5767=y
> > CONFIG_MEDIA_TUNER_MT20XX=y
> > CONFIG_MEDIA_TUNER_MT2060=y
> > # CONFIG_MEDIA_TUNER_MT2063 is not set
> > # CONFIG_MEDIA_TUNER_MT2266 is not set
> > # CONFIG_MEDIA_TUNER_MT2131 is not set
> > CONFIG_MEDIA_TUNER_QT1010=y
> > CONFIG_MEDIA_TUNER_XC2028=y
> > CONFIG_MEDIA_TUNER_XC5000=y
> > # CONFIG_MEDIA_TUNER_XC4000 is not set
> > CONFIG_MEDIA_TUNER_MXL5005S=y
> > # CONFIG_MEDIA_TUNER_MXL5007T is not set
> > CONFIG_MEDIA_TUNER_MC44S803=y
> > CONFIG_MEDIA_TUNER_MAX2165=y
> > CONFIG_MEDIA_TUNER_TDA18218=y
> > CONFIG_MEDIA_TUNER_FC0011=y
> > CONFIG_MEDIA_TUNER_FC0012=y
> > CONFIG_MEDIA_TUNER_FC0013=y
> > CONFIG_MEDIA_TUNER_TDA18212=y
> > CONFIG_MEDIA_TUNER_E4000=y
> > CONFIG_MEDIA_TUNER_FC2580=y
> > CONFIG_MEDIA_TUNER_M88RS6000T=y
> > CONFIG_MEDIA_TUNER_TUA9001=y
> > CONFIG_MEDIA_TUNER_SI2157=y
> > # CONFIG_MEDIA_TUNER_IT913X is not set
> > CONFIG_MEDIA_TUNER_R820T=y
> > # CONFIG_MEDIA_TUNER_MXL301RF is not set
> > # CONFIG_MEDIA_TUNER_QM1D1C0042 is not set
> > CONFIG_MEDIA_TUNER_QM1D1B0004=y
> > 
> > #
> > # Customise DVB Frontends
> > #
> > 
> > #
> > # Multistandard (satellite) frontends
> > #
> > CONFIG_DVB_STB0899=y
> > # CONFIG_DVB_STB6100 is not set
> > CONFIG_DVB_STV090x=y
> > # CONFIG_DVB_STV0910 is not set
> > CONFIG_DVB_STV6110x=y
> > # CONFIG_DVB_STV6111 is not set
> > CONFIG_DVB_MXL5XX=y
> > CONFIG_DVB_M88DS3103=y
> > 
> > #
> > # Multistandard (cable + terrestrial) frontends
> > #
> > # CONFIG_DVB_DRXK is not set
> > CONFIG_DVB_TDA18271C2DD=y
> > # CONFIG_DVB_SI2165 is not set
> > CONFIG_DVB_MN88472=y
> > # CONFIG_DVB_MN88473 is not set
> > 
> > #
> > # DVB-S (satellite) frontends
> > #
> > # CONFIG_DVB_CX24110 is not set
> > CONFIG_DVB_CX24123=y
> > # CONFIG_DVB_MT312 is not set
> > CONFIG_DVB_ZL10036=y
> > # CONFIG_DVB_ZL10039 is not set
> > CONFIG_DVB_S5H1420=y
> > # CONFIG_DVB_STV0288 is not set
> > CONFIG_DVB_STB6000=y
> > # CONFIG_DVB_STV0299 is not set
> > CONFIG_DVB_STV6110=y
> > CONFIG_DVB_STV0900=y
> > CONFIG_DVB_TDA8083=y
> > CONFIG_DVB_TDA10086=y
> > CONFIG_DVB_TDA8261=y
> > # CONFIG_DVB_VES1X93 is not set
> > CONFIG_DVB_TUNER_ITD1000=y
> > # CONFIG_DVB_TUNER_CX24113 is not set
> > CONFIG_DVB_TDA826X=y
> > CONFIG_DVB_TUA6100=y
> > CONFIG_DVB_CX24116=y
> > # CONFIG_DVB_CX24117 is not set
> > CONFIG_DVB_CX24120=y
> > # CONFIG_DVB_SI21XX is not set
> > # CONFIG_DVB_TS2020 is not set
> > CONFIG_DVB_DS3000=y
> > # CONFIG_DVB_MB86A16 is not set
> > # CONFIG_DVB_TDA10071 is not set
> > 
> > #
> > # DVB-T (terrestrial) frontends
> > #
> > CONFIG_DVB_SP8870=y
> > # CONFIG_DVB_SP887X is not set
> > CONFIG_DVB_CX22700=y
> > # CONFIG_DVB_CX22702 is not set
> > CONFIG_DVB_S5H1432=y
> > CONFIG_DVB_DRXD=y
> > CONFIG_DVB_L64781=y
> > # CONFIG_DVB_TDA1004X is not set
> > CONFIG_DVB_NXT6000=y
> > # CONFIG_DVB_MT352 is not set
> > # CONFIG_DVB_ZL10353 is not set
> > # CONFIG_DVB_DIB3000MB is not set
> > CONFIG_DVB_DIB3000MC=y
> > CONFIG_DVB_DIB7000M=y
> > # CONFIG_DVB_DIB7000P is not set
> > CONFIG_DVB_DIB9000=y
> > # CONFIG_DVB_TDA10048 is not set
> > CONFIG_DVB_AF9013=y
> > # CONFIG_DVB_EC100 is not set
> > CONFIG_DVB_STV0367=y
> > CONFIG_DVB_CXD2820R=y
> > CONFIG_DVB_CXD2841ER=y
> > CONFIG_DVB_RTL2830=y
> > CONFIG_DVB_RTL2832=y
> > # CONFIG_DVB_RTL2832_SDR is not set
> > # CONFIG_DVB_SI2168 is not set
> > CONFIG_DVB_ZD1301_DEMOD=y
> > 
> > #
> > # DVB-C (cable) frontends
> > #
> > CONFIG_DVB_VES1820=y
> > CONFIG_DVB_TDA10021=y
> > CONFIG_DVB_TDA10023=y
> > CONFIG_DVB_STV0297=y
> > 
> > #
> > # ATSC (North American/Korean Terrestrial/Cable DTV) frontends
> > #
> > CONFIG_DVB_NXT200X=y
> > # CONFIG_DVB_OR51211 is not set
> > # CONFIG_DVB_OR51132 is not set
> > CONFIG_DVB_BCM3510=y
> > CONFIG_DVB_LGDT330X=y
> > # CONFIG_DVB_LGDT3305 is not set
> > CONFIG_DVB_LGDT3306A=y
> > CONFIG_DVB_LG2160=y
> > CONFIG_DVB_S5H1409=y
> > # CONFIG_DVB_AU8522_DTV is not set
> > # CONFIG_DVB_AU8522_V4L is not set
> > CONFIG_DVB_S5H1411=y
> > 
> > #
> > # ISDB-T (terrestrial) frontends
> > #
> > CONFIG_DVB_S921=y
> > # CONFIG_DVB_DIB8000 is not set
> > # CONFIG_DVB_MB86A20S is not set
> > 
> > #
> > # ISDB-S (satellite) & ISDB-T (terrestrial) frontends
> > #
> > CONFIG_DVB_TC90522=y
> > 
> > #
> > # Digital terrestrial only tuners/PLL
> > #
> > # CONFIG_DVB_PLL is not set
> > CONFIG_DVB_TUNER_DIB0070=y
> > CONFIG_DVB_TUNER_DIB0090=y
> > 
> > #
> > # SEC control devices for DVB-S
> > #
> > CONFIG_DVB_DRX39XYJ=y
> > # CONFIG_DVB_LNBH25 is not set
> > CONFIG_DVB_LNBP21=y
> > # CONFIG_DVB_LNBP22 is not set
> > CONFIG_DVB_ISL6405=y
> > CONFIG_DVB_ISL6421=y
> > # CONFIG_DVB_ISL6423 is not set
> > CONFIG_DVB_A8293=y
> > CONFIG_DVB_LGS8GL5=y
> > CONFIG_DVB_LGS8GXX=y
> > # CONFIG_DVB_ATBM8830 is not set
> > CONFIG_DVB_TDA665x=y
> > # CONFIG_DVB_IX2505V is not set
> > CONFIG_DVB_M88RS2000=y
> > CONFIG_DVB_AF9033=y
> > CONFIG_DVB_HORUS3A=y
> > CONFIG_DVB_ASCOT2E=y
> > # CONFIG_DVB_HELENE is not set
> > 
> > #
> > # Common Interface (EN50221) controller drivers
> > #
> > CONFIG_DVB_CXD2099=y
> > CONFIG_DVB_SP2=y
> > 
> > #
> > # Tools to develop new frontends
> > #
> > CONFIG_DVB_DUMMY_FE=y
> > 
> > #
> > # Graphics support
> > #
> > # CONFIG_AGP is not set
> > CONFIG_VGA_ARB=y
> > CONFIG_VGA_ARB_MAX_GPUS=16
> > # CONFIG_VGA_SWITCHEROO is not set
> > CONFIG_DRM=y
> > CONFIG_DRM_MIPI_DSI=y
> > CONFIG_DRM_DP_AUX_CHARDEV=y
> > # CONFIG_DRM_DEBUG_MM is not set
> > CONFIG_DRM_DEBUG_SELFTEST=y
> > CONFIG_DRM_KMS_HELPER=y
> > CONFIG_DRM_KMS_FB_HELPER=y
> > CONFIG_DRM_FBDEV_EMULATION=y
> > CONFIG_DRM_FBDEV_OVERALLOC=100
> > CONFIG_DRM_LOAD_EDID_FIRMWARE=y
> > CONFIG_DRM_TTM=y
> > CONFIG_DRM_GEM_CMA_HELPER=y
> > CONFIG_DRM_KMS_CMA_HELPER=y
> > 
> > #
> > # I2C encoder or helper chips
> > #
> > CONFIG_DRM_I2C_CH7006=y
> > CONFIG_DRM_I2C_SIL164=y
> > # CONFIG_DRM_I2C_NXP_TDA998X is not set
> > # CONFIG_DRM_I2C_NXP_TDA9950 is not set
> > # CONFIG_DRM_RADEON is not set
> > # CONFIG_DRM_AMDGPU is not set
> > 
> > #
> > # ACP (Audio CoProcessor) Configuration
> > #
> > 
> > #
> > # AMD Library routines
> > #
> > # CONFIG_DRM_NOUVEAU is not set
> > # CONFIG_DRM_I915 is not set
> > CONFIG_DRM_VGEM=y
> > # CONFIG_DRM_VMWGFX is not set
> > # CONFIG_DRM_GMA500 is not set
> > # CONFIG_DRM_UDL is not set
> > # CONFIG_DRM_AST is not set
> > # CONFIG_DRM_MGAG200 is not set
> > # CONFIG_DRM_CIRRUS_QEMU is not set
> > # CONFIG_DRM_RCAR_DW_HDMI is not set
> > # CONFIG_DRM_RCAR_LVDS is not set
> > # CONFIG_DRM_QXL is not set
> > # CONFIG_DRM_BOCHS is not set
> > CONFIG_DRM_VIRTIO_GPU=y
> > CONFIG_DRM_PANEL=y
> > 
> > #
> > # Display Panels
> > #
> > # CONFIG_DRM_PANEL_ARM_VERSATILE is not set
> > # CONFIG_DRM_PANEL_LVDS is not set
> > CONFIG_DRM_PANEL_SIMPLE=y
> > CONFIG_DRM_PANEL_INNOLUX_P079ZCA=y
> > CONFIG_DRM_PANEL_JDI_LT070ME05000=y
> > CONFIG_DRM_PANEL_ORISETECH_OTM8009A=y
> > CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00=y
> > # CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
> > CONFIG_DRM_PANEL_RAYDIUM_RM68200=y
> > CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2=y
> > # CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03 is not set
> > CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=y
> > # CONFIG_DRM_PANEL_SEIKO_43WVF1G is not set
> > CONFIG_DRM_PANEL_SHARP_LQ101R1SX01=y
> > CONFIG_DRM_PANEL_SHARP_LS043T1LE01=y
> > CONFIG_DRM_BRIDGE=y
> > CONFIG_DRM_PANEL_BRIDGE=y
> > 
> > #
> > # Display Interface Bridges
> > #
> > CONFIG_DRM_ANALOGIX_ANX78XX=y
> > CONFIG_DRM_CDNS_DSI=y
> > CONFIG_DRM_DUMB_VGA_DAC=y
> > # CONFIG_DRM_LVDS_ENCODER is not set
> > # CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW is not set
> > CONFIG_DRM_NXP_PTN3460=y
> > CONFIG_DRM_PARADE_PS8622=y
> > CONFIG_DRM_SIL_SII8620=y
> > CONFIG_DRM_SII902X=y
> > CONFIG_DRM_SII9234=y
> > # CONFIG_DRM_THINE_THC63LVD1024 is not set
> > CONFIG_DRM_TOSHIBA_TC358767=y
> > CONFIG_DRM_TI_TFP410=y
> > CONFIG_DRM_I2C_ADV7511=y
> > CONFIG_DRM_I2C_ADV7511_AUDIO=y
> > # CONFIG_DRM_I2C_ADV7533 is not set
> > # CONFIG_DRM_I2C_ADV7511_CEC is not set
> > CONFIG_DRM_ARCPGU=y
> > # CONFIG_DRM_HISI_HIBMC is not set
> > # CONFIG_DRM_MXSFB is not set
> > CONFIG_DRM_TINYDRM=y
> > # CONFIG_DRM_LEGACY is not set
> > CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
> > CONFIG_DRM_LIB_RANDOM=y
> > 
> > #
> > # Frame buffer Devices
> > #
> > CONFIG_FB=y
> > # CONFIG_FIRMWARE_EDID is not set
> > CONFIG_FB_CMDLINE=y
> > CONFIG_FB_NOTIFY=y
> > CONFIG_FB_CFB_FILLRECT=y
> > CONFIG_FB_CFB_COPYAREA=y
> > CONFIG_FB_CFB_IMAGEBLIT=y
> > CONFIG_FB_SYS_FILLRECT=y
> > CONFIG_FB_SYS_COPYAREA=y
> > CONFIG_FB_SYS_IMAGEBLIT=y
> > # CONFIG_FB_FOREIGN_ENDIAN is not set
> > CONFIG_FB_SYS_FOPS=y
> > CONFIG_FB_DEFERRED_IO=y
> > CONFIG_FB_HECUBA=y
> > CONFIG_FB_MODE_HELPERS=y
> > CONFIG_FB_TILEBLITTING=y
> > 
> > #
> > # Frame buffer hardware drivers
> > #
> > # CONFIG_FB_CIRRUS is not set
> > # CONFIG_FB_PM2 is not set
> > # CONFIG_FB_CYBER2000 is not set
> > CONFIG_FB_ARC=y
> > # CONFIG_FB_ASILIANT is not set
> > # CONFIG_FB_IMSTT is not set
> > # CONFIG_FB_VGA16 is not set
> > # CONFIG_FB_VESA is not set
> > CONFIG_FB_N411=y
> > # CONFIG_FB_HGA is not set
> > # CONFIG_FB_OPENCORES is not set
> > CONFIG_FB_S1D13XXX=y
> > # CONFIG_FB_NVIDIA is not set
> > # CONFIG_FB_RIVA is not set
> > # CONFIG_FB_I740 is not set
> > # CONFIG_FB_LE80578 is not set
> > # CONFIG_FB_MATROX is not set
> > # CONFIG_FB_RADEON is not set
> > # CONFIG_FB_ATY128 is not set
> > # CONFIG_FB_ATY is not set
> > # CONFIG_FB_S3 is not set
> > # CONFIG_FB_SAVAGE is not set
> > # CONFIG_FB_SIS is not set
> > # CONFIG_FB_VIA is not set
> > # CONFIG_FB_NEOMAGIC is not set
> > # CONFIG_FB_KYRO is not set
> > # CONFIG_FB_3DFX is not set
> > # CONFIG_FB_VOODOO1 is not set
> > # CONFIG_FB_VT8623 is not set
> > # CONFIG_FB_TRIDENT is not set
> > # CONFIG_FB_ARK is not set
> > # CONFIG_FB_PM3 is not set
> > # CONFIG_FB_CARMINE is not set
> > CONFIG_FB_SM501=y
> > # CONFIG_FB_SMSCUFX is not set
> > CONFIG_FB_UDL=y
> > CONFIG_FB_IBM_GXT4500=y
> > # CONFIG_FB_GOLDFISH is not set
> > CONFIG_FB_VIRTUAL=y
> > CONFIG_FB_METRONOME=y
> > # CONFIG_FB_MB862XX is not set
> > CONFIG_FB_BROADSHEET=y
> > # CONFIG_FB_SIMPLE is not set
> > # CONFIG_FB_SSD1307 is not set
> > # CONFIG_FB_SM712 is not set
> > CONFIG_BACKLIGHT_LCD_SUPPORT=y
> > CONFIG_LCD_CLASS_DEVICE=y
> > CONFIG_LCD_PLATFORM=y
> > CONFIG_BACKLIGHT_CLASS_DEVICE=y
> > CONFIG_BACKLIGHT_GENERIC=y
> > CONFIG_BACKLIGHT_DA903X=y
> > # CONFIG_BACKLIGHT_DA9052 is not set
> > # CONFIG_BACKLIGHT_MAX8925 is not set
> > # CONFIG_BACKLIGHT_APPLE is not set
> > CONFIG_BACKLIGHT_PM8941_WLED=y
> > CONFIG_BACKLIGHT_SAHARA=y
> > CONFIG_BACKLIGHT_WM831X=y
> > CONFIG_BACKLIGHT_ADP8860=y
> > CONFIG_BACKLIGHT_ADP8870=y
> > CONFIG_BACKLIGHT_PCF50633=y
> > # CONFIG_BACKLIGHT_AAT2870 is not set
> > CONFIG_BACKLIGHT_LM3639=y
> > CONFIG_BACKLIGHT_TPS65217=y
> > # CONFIG_BACKLIGHT_GPIO is not set
> > CONFIG_BACKLIGHT_LV5207LP=y
> > CONFIG_BACKLIGHT_BD6107=y
> > CONFIG_BACKLIGHT_ARCXCNN=y
> > CONFIG_BACKLIGHT_RAVE_SP=y
> > CONFIG_VIDEOMODE_HELPERS=y
> > CONFIG_HDMI=y
> > 
> > #
> > # Console display driver support
> > #
> > CONFIG_VGA_CONSOLE=y
> > # CONFIG_VGACON_SOFT_SCROLLBACK is not set
> > CONFIG_DUMMY_CONSOLE=y
> > CONFIG_DUMMY_CONSOLE_COLUMNS=80
> > CONFIG_DUMMY_CONSOLE_ROWS=25
> > CONFIG_FRAMEBUFFER_CONSOLE=y
> > CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
> > CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
> > # CONFIG_LOGO is not set
> > CONFIG_SOUND=y
> > CONFIG_SOUND_OSS_CORE=y
> > # CONFIG_SOUND_OSS_CORE_PRECLAIM is not set
> > CONFIG_SND=y
> > CONFIG_SND_TIMER=y
> > CONFIG_SND_PCM=y
> > CONFIG_SND_PCM_ELD=y
> > CONFIG_SND_PCM_IEC958=y
> > CONFIG_SND_DMAENGINE_PCM=y
> > CONFIG_SND_JACK=y
> > CONFIG_SND_JACK_INPUT_DEV=y
> > CONFIG_SND_OSSEMUL=y
> > CONFIG_SND_MIXER_OSS=y
> > # CONFIG_SND_PCM_OSS is not set
> > CONFIG_SND_PCM_TIMER=y
> > CONFIG_SND_HRTIMER=y
> > # CONFIG_SND_DYNAMIC_MINORS is not set
> > CONFIG_SND_SUPPORT_OLD_API=y
> > CONFIG_SND_PROC_FS=y
> > # CONFIG_SND_VERBOSE_PROCFS is not set
> > CONFIG_SND_VERBOSE_PRINTK=y
> > CONFIG_SND_DEBUG=y
> > # CONFIG_SND_DEBUG_VERBOSE is not set
> > CONFIG_SND_VMASTER=y
> > CONFIG_SND_DMA_SGBUF=y
> > # CONFIG_SND_SEQUENCER is not set
> > CONFIG_SND_AC97_CODEC=y
> > # CONFIG_SND_DRIVERS is not set
> > CONFIG_SND_PCI=y
> > # CONFIG_SND_AD1889 is not set
> > # CONFIG_SND_ALS300 is not set
> > # CONFIG_SND_ALS4000 is not set
> > # CONFIG_SND_ALI5451 is not set
> > # CONFIG_SND_ASIHPI is not set
> > # CONFIG_SND_ATIIXP is not set
> > # CONFIG_SND_ATIIXP_MODEM is not set
> > # CONFIG_SND_AU8810 is not set
> > # CONFIG_SND_AU8820 is not set
> > # CONFIG_SND_AU8830 is not set
> > # CONFIG_SND_AW2 is not set
> > # CONFIG_SND_AZT3328 is not set
> > # CONFIG_SND_BT87X is not set
> > # CONFIG_SND_CA0106 is not set
> > # CONFIG_SND_CMIPCI is not set
> > # CONFIG_SND_OXYGEN is not set
> > # CONFIG_SND_CS4281 is not set
> > # CONFIG_SND_CS46XX is not set
> > # CONFIG_SND_CTXFI is not set
> > # CONFIG_SND_DARLA20 is not set
> > # CONFIG_SND_GINA20 is not set
> > # CONFIG_SND_LAYLA20 is not set
> > # CONFIG_SND_DARLA24 is not set
> > # CONFIG_SND_GINA24 is not set
> > # CONFIG_SND_LAYLA24 is not set
> > # CONFIG_SND_MONA is not set
> > # CONFIG_SND_MIA is not set
> > # CONFIG_SND_ECHO3G is not set
> > # CONFIG_SND_INDIGO is not set
> > # CONFIG_SND_INDIGOIO is not set
> > # CONFIG_SND_INDIGODJ is not set
> > # CONFIG_SND_INDIGOIOX is not set
> > # CONFIG_SND_INDIGODJX is not set
> > # CONFIG_SND_EMU10K1 is not set
> > # CONFIG_SND_EMU10K1X is not set
> > # CONFIG_SND_ENS1370 is not set
> > # CONFIG_SND_ENS1371 is not set
> > # CONFIG_SND_ES1938 is not set
> > # CONFIG_SND_ES1968 is not set
> > # CONFIG_SND_FM801 is not set
> > # CONFIG_SND_HDSP is not set
> > # CONFIG_SND_HDSPM is not set
> > # CONFIG_SND_ICE1712 is not set
> > # CONFIG_SND_ICE1724 is not set
> > # CONFIG_SND_INTEL8X0 is not set
> > # CONFIG_SND_INTEL8X0M is not set
> > # CONFIG_SND_KORG1212 is not set
> > # CONFIG_SND_LOLA is not set
> > # CONFIG_SND_LX6464ES is not set
> > # CONFIG_SND_MAESTRO3 is not set
> > # CONFIG_SND_MIXART is not set
> > # CONFIG_SND_NM256 is not set
> > # CONFIG_SND_PCXHR is not set
> > # CONFIG_SND_RIPTIDE is not set
> > # CONFIG_SND_RME32 is not set
> > # CONFIG_SND_RME96 is not set
> > # CONFIG_SND_RME9652 is not set
> > # CONFIG_SND_SE6X is not set
> > # CONFIG_SND_SONICVIBES is not set
> > # CONFIG_SND_TRIDENT is not set
> > # CONFIG_SND_VIA82XX is not set
> > # CONFIG_SND_VIA82XX_MODEM is not set
> > # CONFIG_SND_VIRTUOSO is not set
> > # CONFIG_SND_VX222 is not set
> > # CONFIG_SND_YMFPCI is not set
> > 
> > #
> > # HD-Audio
> > #
> > # CONFIG_SND_HDA_INTEL is not set
> > CONFIG_SND_HDA_PREALLOC_SIZE=64
> > # CONFIG_SND_USB is not set
> > # CONFIG_SND_FIREWIRE is not set
> > CONFIG_SND_PCMCIA=y
> > # CONFIG_SND_VXPOCKET is not set
> > CONFIG_SND_PDAUDIOCF=y
> > CONFIG_SND_SOC=y
> > CONFIG_SND_SOC_AC97_BUS=y
> > CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
> > CONFIG_SND_SOC_AMD_ACP=y
> > CONFIG_SND_SOC_AMD_CZ_DA7219MX98357_MACH=y
> > # CONFIG_SND_SOC_AMD_CZ_RT5645_MACH is not set
> > CONFIG_SND_ATMEL_SOC=y
> > # CONFIG_SND_DESIGNWARE_I2S is not set
> > 
> > #
> > # SoC Audio for Freescale CPUs
> > #
> > 
> > #
> > # Common SoC Audio options for Freescale CPUs:
> > #
> > # CONFIG_SND_SOC_FSL_ASRC is not set
> > CONFIG_SND_SOC_FSL_SAI=y
> > CONFIG_SND_SOC_FSL_SSI=y
> > CONFIG_SND_SOC_FSL_SPDIF=y
> > CONFIG_SND_SOC_FSL_ESAI=y
> > CONFIG_SND_SOC_IMX_AUDMUX=y
> > # CONFIG_SND_I2S_HI6210_I2S is not set
> > # CONFIG_SND_SOC_IMG is not set
> > # CONFIG_SND_SOC_INTEL_SST_TOPLEVEL is not set
> > 
> > #
> > # STMicroelectronics STM32 SOC audio support
> > #
> > CONFIG_SND_SOC_XTFPGA_I2S=y
> > # CONFIG_ZX_TDM is not set
> > CONFIG_SND_SOC_I2C_AND_SPI=y
> > 
> > #
> > # CODEC drivers
> > #
> > CONFIG_SND_SOC_AC97_CODEC=y
> > CONFIG_SND_SOC_ADAU_UTILS=y
> > CONFIG_SND_SOC_ADAU1701=y
> > CONFIG_SND_SOC_ADAU17X1=y
> > CONFIG_SND_SOC_ADAU1761=y
> > CONFIG_SND_SOC_ADAU1761_I2C=y
> > CONFIG_SND_SOC_ADAU7002=y
> > CONFIG_SND_SOC_AK4458=y
> > CONFIG_SND_SOC_AK4554=y
> > CONFIG_SND_SOC_AK4613=y
> > CONFIG_SND_SOC_AK4642=y
> > CONFIG_SND_SOC_AK5386=y
> > CONFIG_SND_SOC_AK5558=y
> > CONFIG_SND_SOC_ALC5623=y
> > CONFIG_SND_SOC_BD28623=y
> > CONFIG_SND_SOC_BT_SCO=y
> > CONFIG_SND_SOC_CS35L32=y
> > CONFIG_SND_SOC_CS35L33=y
> > CONFIG_SND_SOC_CS35L34=y
> > CONFIG_SND_SOC_CS35L35=y
> > CONFIG_SND_SOC_CS42L42=y
> > CONFIG_SND_SOC_CS42L51=y
> > CONFIG_SND_SOC_CS42L51_I2C=y
> > CONFIG_SND_SOC_CS42L52=y
> > CONFIG_SND_SOC_CS42L56=y
> > CONFIG_SND_SOC_CS42L73=y
> > CONFIG_SND_SOC_CS4265=y
> > CONFIG_SND_SOC_CS4270=y
> > CONFIG_SND_SOC_CS4271=y
> > CONFIG_SND_SOC_CS4271_I2C=y
> > CONFIG_SND_SOC_CS42XX8=y
> > CONFIG_SND_SOC_CS42XX8_I2C=y
> > CONFIG_SND_SOC_CS43130=y
> > CONFIG_SND_SOC_CS4349=y
> > CONFIG_SND_SOC_CS53L30=y
> > CONFIG_SND_SOC_DA7219=y
> > CONFIG_SND_SOC_DIO2125=y
> > CONFIG_SND_SOC_HDMI_CODEC=y
> > CONFIG_SND_SOC_ES7134=y
> > CONFIG_SND_SOC_ES8316=y
> > CONFIG_SND_SOC_ES8328=y
> > CONFIG_SND_SOC_ES8328_I2C=y
> > CONFIG_SND_SOC_GTM601=y
> > CONFIG_SND_SOC_INNO_RK3036=y
> > CONFIG_SND_SOC_MAX98357A=y
> > CONFIG_SND_SOC_MAX98504=y
> > CONFIG_SND_SOC_MAX9867=y
> > CONFIG_SND_SOC_MAX98927=y
> > CONFIG_SND_SOC_MAX98373=y
> > CONFIG_SND_SOC_MAX9860=y
> > CONFIG_SND_SOC_MSM8916_WCD_ANALOG=y
> > CONFIG_SND_SOC_MSM8916_WCD_DIGITAL=y
> > CONFIG_SND_SOC_PCM1681=y
> > CONFIG_SND_SOC_PCM1789=y
> > CONFIG_SND_SOC_PCM1789_I2C=y
> > CONFIG_SND_SOC_PCM179X=y
> > CONFIG_SND_SOC_PCM179X_I2C=y
> > CONFIG_SND_SOC_PCM186X=y
> > CONFIG_SND_SOC_PCM186X_I2C=y
> > CONFIG_SND_SOC_PCM3168A=y
> > CONFIG_SND_SOC_PCM3168A_I2C=y
> > CONFIG_SND_SOC_PCM512x=y
> > CONFIG_SND_SOC_PCM512x_I2C=y
> > CONFIG_SND_SOC_RL6231=y
> > CONFIG_SND_SOC_RT5616=y
> > CONFIG_SND_SOC_RT5631=y
> > CONFIG_SND_SOC_SGTL5000=y
> > CONFIG_SND_SOC_SIGMADSP=y
> > CONFIG_SND_SOC_SIGMADSP_I2C=y
> > CONFIG_SND_SOC_SIGMADSP_REGMAP=y
> > CONFIG_SND_SOC_SIRF_AUDIO_CODEC=y
> > CONFIG_SND_SOC_SPDIF=y
> > CONFIG_SND_SOC_SSM2305=y
> > CONFIG_SND_SOC_SSM2602=y
> > CONFIG_SND_SOC_SSM2602_I2C=y
> > CONFIG_SND_SOC_SSM4567=y
> > CONFIG_SND_SOC_STA32X=y
> > CONFIG_SND_SOC_STA350=y
> > CONFIG_SND_SOC_STI_SAS=y
> > CONFIG_SND_SOC_TAS2552=y
> > CONFIG_SND_SOC_TAS5086=y
> > CONFIG_SND_SOC_TAS571X=y
> > CONFIG_SND_SOC_TAS5720=y
> > CONFIG_SND_SOC_TAS6424=y
> > CONFIG_SND_SOC_TDA7419=y
> > CONFIG_SND_SOC_TFA9879=y
> > CONFIG_SND_SOC_TLV320AIC23=y
> > CONFIG_SND_SOC_TLV320AIC23_I2C=y
> > CONFIG_SND_SOC_TLV320AIC31XX=y
> > CONFIG_SND_SOC_TLV320AIC32X4=y
> > CONFIG_SND_SOC_TLV320AIC32X4_I2C=y
> > CONFIG_SND_SOC_TLV320AIC3X=y
> > CONFIG_SND_SOC_TS3A227E=y
> > CONFIG_SND_SOC_TSCS42XX=y
> > CONFIG_SND_SOC_TSCS454=y
> > CONFIG_SND_SOC_WM8510=y
> > CONFIG_SND_SOC_WM8523=y
> > CONFIG_SND_SOC_WM8524=y
> > CONFIG_SND_SOC_WM8580=y
> > CONFIG_SND_SOC_WM8711=y
> > CONFIG_SND_SOC_WM8728=y
> > CONFIG_SND_SOC_WM8731=y
> > CONFIG_SND_SOC_WM8737=y
> > CONFIG_SND_SOC_WM8741=y
> > CONFIG_SND_SOC_WM8750=y
> > CONFIG_SND_SOC_WM8753=y
> > CONFIG_SND_SOC_WM8776=y
> > CONFIG_SND_SOC_WM8782=y
> > CONFIG_SND_SOC_WM8804=y
> > CONFIG_SND_SOC_WM8804_I2C=y
> > CONFIG_SND_SOC_WM8903=y
> > CONFIG_SND_SOC_WM8960=y
> > CONFIG_SND_SOC_WM8962=y
> > CONFIG_SND_SOC_WM8974=y
> > CONFIG_SND_SOC_WM8978=y
> > CONFIG_SND_SOC_WM8985=y
> > CONFIG_SND_SOC_ZX_AUD96P22=y
> > CONFIG_SND_SOC_MAX9759=y
> > CONFIG_SND_SOC_MT6351=y
> > CONFIG_SND_SOC_NAU8540=y
> > CONFIG_SND_SOC_NAU8810=y
> > CONFIG_SND_SOC_NAU8824=y
> > CONFIG_SND_SOC_TPA6130A2=y
> > CONFIG_SND_SIMPLE_CARD_UTILS=y
> > CONFIG_SND_SIMPLE_CARD=y
> > CONFIG_SND_SIMPLE_SCU_CARD=y
> > CONFIG_SND_AUDIO_GRAPH_CARD=y
> > CONFIG_SND_AUDIO_GRAPH_SCU_CARD=y
> > CONFIG_SND_X86=y
> > CONFIG_AC97_BUS=y
> > 
> > #
> > # HID support
> > #
> > # CONFIG_HID is not set
> > 
> > #
> > # USB HID support
> > #
> > # CONFIG_USB_HID is not set
> > CONFIG_HID_PID=y
> > 
> > #
> > # I2C HID support
> > #
> > # CONFIG_I2C_HID is not set
> > 
> > #
> > # Intel ISH HID support
> > #
> > # CONFIG_INTEL_ISH_HID is not set
> > CONFIG_USB_OHCI_LITTLE_ENDIAN=y
> > CONFIG_USB_SUPPORT=y
> > CONFIG_USB_COMMON=y
> > CONFIG_USB_ARCH_HAS_HCD=y
> > CONFIG_USB=y
> > CONFIG_USB_PCI=y
> > # CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set
> > 
> > #
> > # Miscellaneous USB options
> > #
> > # CONFIG_USB_DEFAULT_PERSIST is not set
> > CONFIG_USB_DYNAMIC_MINORS=y
> > CONFIG_USB_OTG=y
> > # CONFIG_USB_OTG_WHITELIST is not set
> > CONFIG_USB_OTG_BLACKLIST_HUB=y
> > CONFIG_USB_OTG_FSM=y
> > CONFIG_USB_MON=y
> > CONFIG_USB_WUSB=y
> > CONFIG_USB_WUSB_CBAF=y
> > CONFIG_USB_WUSB_CBAF_DEBUG=y
> > 
> > #
> > # USB Host Controller Drivers
> > #
> > CONFIG_USB_C67X00_HCD=y
> > CONFIG_USB_XHCI_HCD=y
> > CONFIG_USB_XHCI_DBGCAP=y
> > CONFIG_USB_XHCI_PCI=y
> > CONFIG_USB_XHCI_PLATFORM=y
> > CONFIG_USB_EHCI_HCD=y
> > # CONFIG_USB_EHCI_ROOT_HUB_TT is not set
> > # CONFIG_USB_EHCI_TT_NEWSCHED is not set
> > CONFIG_USB_EHCI_PCI=y
> > CONFIG_USB_EHCI_HCD_PLATFORM=y
> > # CONFIG_USB_OXU210HP_HCD is not set
> > # CONFIG_USB_ISP116X_HCD is not set
> > CONFIG_USB_FOTG210_HCD=y
> > # CONFIG_USB_OHCI_HCD is not set
> > # CONFIG_USB_UHCI_HCD is not set
> > # CONFIG_USB_U132_HCD is not set
> > CONFIG_USB_SL811_HCD=y
> > CONFIG_USB_SL811_HCD_ISO=y
> > # CONFIG_USB_SL811_CS is not set
> > CONFIG_USB_R8A66597_HCD=y
> > # CONFIG_USB_WHCI_HCD is not set
> > CONFIG_USB_HWA_HCD=y
> > # CONFIG_USB_HCD_BCMA is not set
> > CONFIG_USB_HCD_SSB=y
> > CONFIG_USB_HCD_TEST_MODE=y
> > 
> > #
> > # USB Device Class drivers
> > #
> > CONFIG_USB_ACM=y
> > CONFIG_USB_PRINTER=y
> > # CONFIG_USB_WDM is not set
> > CONFIG_USB_TMC=y
> > 
> > #
> > # NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
> > #
> > 
> > #
> > # also be needed; see USB_STORAGE Help for more info
> > #
> > 
> > #
> > # USB Imaging devices
> > #
> > CONFIG_USB_MDC800=y
> > # CONFIG_USBIP_CORE is not set
> > # CONFIG_USB_MUSB_HDRC is not set
> > CONFIG_USB_DWC3=y
> > # CONFIG_USB_DWC3_ULPI is not set
> > CONFIG_USB_DWC3_HOST=y
> > 
> > #
> > # Platform Glue Driver Support
> > #
> > CONFIG_USB_DWC3_PCI=y
> > CONFIG_USB_DWC3_OF_SIMPLE=y
> > # CONFIG_USB_DWC2 is not set
> > # CONFIG_USB_CHIPIDEA is not set
> > # CONFIG_USB_ISP1760 is not set
> > 
> > #
> > # USB port drivers
> > #
> > CONFIG_USB_SERIAL=y
> > # CONFIG_USB_SERIAL_CONSOLE is not set
> > CONFIG_USB_SERIAL_GENERIC=y
> > CONFIG_USB_SERIAL_SIMPLE=y
> > # CONFIG_USB_SERIAL_AIRCABLE is not set
> > CONFIG_USB_SERIAL_ARK3116=y
> > CONFIG_USB_SERIAL_BELKIN=y
> > CONFIG_USB_SERIAL_CH341=y
> > CONFIG_USB_SERIAL_WHITEHEAT=y
> > # CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
> > CONFIG_USB_SERIAL_CP210X=y
> > CONFIG_USB_SERIAL_CYPRESS_M8=y
> > CONFIG_USB_SERIAL_EMPEG=y
> > # CONFIG_USB_SERIAL_FTDI_SIO is not set
> > # CONFIG_USB_SERIAL_VISOR is not set
> > # CONFIG_USB_SERIAL_IPAQ is not set
> > CONFIG_USB_SERIAL_IR=y
> > # CONFIG_USB_SERIAL_EDGEPORT is not set
> > CONFIG_USB_SERIAL_EDGEPORT_TI=y
> > CONFIG_USB_SERIAL_F81232=y
> > CONFIG_USB_SERIAL_F8153X=y
> > # CONFIG_USB_SERIAL_GARMIN is not set
> > CONFIG_USB_SERIAL_IPW=y
> > CONFIG_USB_SERIAL_IUU=y
> > CONFIG_USB_SERIAL_KEYSPAN_PDA=y
> > # CONFIG_USB_SERIAL_KEYSPAN is not set
> > # CONFIG_USB_SERIAL_KLSI is not set
> > CONFIG_USB_SERIAL_KOBIL_SCT=y
> > CONFIG_USB_SERIAL_MCT_U232=y
> > # CONFIG_USB_SERIAL_METRO is not set
> > CONFIG_USB_SERIAL_MOS7720=y
> > # CONFIG_USB_SERIAL_MOS7840 is not set
> > CONFIG_USB_SERIAL_MXUPORT=y
> > CONFIG_USB_SERIAL_NAVMAN=y
> > CONFIG_USB_SERIAL_PL2303=y
> > CONFIG_USB_SERIAL_OTI6858=y
> > CONFIG_USB_SERIAL_QCAUX=y
> > CONFIG_USB_SERIAL_QUALCOMM=y
> > CONFIG_USB_SERIAL_SPCP8X5=y
> > CONFIG_USB_SERIAL_SAFE=y
> > # CONFIG_USB_SERIAL_SAFE_PADDED is not set
> > # CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
> > CONFIG_USB_SERIAL_SYMBOL=y
> > # CONFIG_USB_SERIAL_TI is not set
> > CONFIG_USB_SERIAL_CYBERJACK=y
> > CONFIG_USB_SERIAL_XIRCOM=y
> > CONFIG_USB_SERIAL_WWAN=y
> > # CONFIG_USB_SERIAL_OPTION is not set
> > CONFIG_USB_SERIAL_OMNINET=y
> > # CONFIG_USB_SERIAL_OPTICON is not set
> > # CONFIG_USB_SERIAL_XSENS_MT is not set
> > CONFIG_USB_SERIAL_WISHBONE=y
> > CONFIG_USB_SERIAL_SSU100=y
> > CONFIG_USB_SERIAL_QT2=y
> > # CONFIG_USB_SERIAL_UPD78F0730 is not set
> > CONFIG_USB_SERIAL_DEBUG=y
> > 
> > #
> > # USB Miscellaneous drivers
> > #
> > # CONFIG_USB_EMI62 is not set
> > CONFIG_USB_EMI26=y
> > CONFIG_USB_ADUTUX=y
> > CONFIG_USB_SEVSEG=y
> > CONFIG_USB_RIO500=y
> > CONFIG_USB_LEGOTOWER=y
> > CONFIG_USB_LCD=y
> > CONFIG_USB_CYPRESS_CY7C63=y
> > CONFIG_USB_CYTHERM=y
> > CONFIG_USB_IDMOUSE=y
> > CONFIG_USB_FTDI_ELAN=y
> > # CONFIG_USB_APPLEDISPLAY is not set
> > # CONFIG_USB_SISUSBVGA is not set
> > # CONFIG_USB_LD is not set
> > CONFIG_USB_TRANCEVIBRATOR=y
> > CONFIG_USB_IOWARRIOR=y
> > CONFIG_USB_TEST=y
> > # CONFIG_USB_EHSET_TEST_FIXTURE is not set
> > CONFIG_USB_ISIGHTFW=y
> > CONFIG_USB_YUREX=y
> > CONFIG_USB_EZUSB_FX2=y
> > # CONFIG_USB_HUB_USB251XB is not set
> > CONFIG_USB_HSIC_USB3503=y
> > CONFIG_USB_HSIC_USB4604=y
> > CONFIG_USB_LINK_LAYER_TEST=y
> > CONFIG_USB_CHAOSKEY=y
> > 
> > #
> > # USB Physical Layer drivers
> > #
> > CONFIG_USB_PHY=y
> > # CONFIG_NOP_USB_XCEIV is not set
> > # CONFIG_USB_GPIO_VBUS is not set
> > # CONFIG_TAHVO_USB is not set
> > CONFIG_USB_ISP1301=y
> > # CONFIG_USB_GADGET is not set
> > # CONFIG_TYPEC is not set
> > # CONFIG_USB_ROLES_INTEL_XHCI is not set
> > CONFIG_USB_ULPI_BUS=y
> > CONFIG_USB_ROLE_SWITCH=y
> > CONFIG_UWB=y
> > CONFIG_UWB_HWA=y
> > # CONFIG_UWB_WHCI is not set
> > CONFIG_UWB_I1480U=y
> > CONFIG_MMC=y
> > # CONFIG_PWRSEQ_EMMC is not set
> > # CONFIG_PWRSEQ_SIMPLE is not set
> > CONFIG_MMC_BLOCK=y
> > CONFIG_MMC_BLOCK_MINORS=8
> > # CONFIG_SDIO_UART is not set
> > # CONFIG_MMC_TEST is not set
> > 
> > #
> > # MMC/SD/SDIO Host Controller Drivers
> > #
> > CONFIG_MMC_DEBUG=y
> > CONFIG_MMC_SDHCI=y
> > # CONFIG_MMC_SDHCI_PCI is not set
> > # CONFIG_MMC_SDHCI_ACPI is not set
> > CONFIG_MMC_SDHCI_PLTFM=y
> > # CONFIG_MMC_SDHCI_OF_ARASAN is not set
> > CONFIG_MMC_SDHCI_OF_AT91=y
> > # CONFIG_MMC_SDHCI_CADENCE is not set
> > CONFIG_MMC_SDHCI_F_SDH30=y
> > CONFIG_MMC_WBSD=y
> > # CONFIG_MMC_TIFM_SD is not set
> > CONFIG_MMC_GOLDFISH=y
> > # CONFIG_MMC_SDRICOH_CS is not set
> > # CONFIG_MMC_CB710 is not set
> > # CONFIG_MMC_VIA_SDMMC is not set
> > # CONFIG_MMC_VUB300 is not set
> > CONFIG_MMC_USHC=y
> > CONFIG_MMC_USDHI6ROL0=y
> > # CONFIG_MMC_CQHCI is not set
> > # CONFIG_MMC_TOSHIBA_PCI is not set
> > # CONFIG_MMC_MTK is not set
> > CONFIG_MMC_SDHCI_XENON=y
> > # CONFIG_MMC_SDHCI_OMAP is not set
> > CONFIG_MEMSTICK=y
> > CONFIG_MEMSTICK_DEBUG=y
> > 
> > #
> > # MemoryStick drivers
> > #
> > CONFIG_MEMSTICK_UNSAFE_RESUME=y
> > CONFIG_MSPRO_BLOCK=y
> > CONFIG_MS_BLOCK=y
> > 
> > #
> > # MemoryStick Host Controller Drivers
> > #
> > # CONFIG_MEMSTICK_TIFM_MS is not set
> > # CONFIG_MEMSTICK_JMICRON_38X is not set
> > # CONFIG_MEMSTICK_R592 is not set
> > CONFIG_NEW_LEDS=y
> > CONFIG_LEDS_CLASS=y
> > CONFIG_LEDS_CLASS_FLASH=y
> > # CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set
> > 
> > #
> > # LED drivers
> > #
> > # CONFIG_LEDS_AAT1290 is not set
> > CONFIG_LEDS_APU=y
> > CONFIG_LEDS_AS3645A=y
> > CONFIG_LEDS_BCM6328=y
> > # CONFIG_LEDS_BCM6358 is not set
> > CONFIG_LEDS_LM3530=y
> > # CONFIG_LEDS_LM3642 is not set
> > CONFIG_LEDS_LM3692X=y
> > CONFIG_LEDS_LM3601X=y
> > # CONFIG_LEDS_MT6323 is not set
> > # CONFIG_LEDS_PCA9532 is not set
> > CONFIG_LEDS_GPIO=y
> > # CONFIG_LEDS_LP3944 is not set
> > CONFIG_LEDS_LP3952=y
> > CONFIG_LEDS_LP55XX_COMMON=y
> > # CONFIG_LEDS_LP5521 is not set
> > # CONFIG_LEDS_LP5523 is not set
> > # CONFIG_LEDS_LP5562 is not set
> > CONFIG_LEDS_LP8501=y
> > # CONFIG_LEDS_LP8860 is not set
> > # CONFIG_LEDS_CLEVO_MAIL is not set
> > CONFIG_LEDS_PCA955X=y
> > CONFIG_LEDS_PCA955X_GPIO=y
> > # CONFIG_LEDS_PCA963X is not set
> > CONFIG_LEDS_WM831X_STATUS=y
> > CONFIG_LEDS_DA903X=y
> > CONFIG_LEDS_DA9052=y
> > # CONFIG_LEDS_REGULATOR is not set
> > CONFIG_LEDS_BD2802=y
> > # CONFIG_LEDS_INTEL_SS4200 is not set
> > CONFIG_LEDS_LT3593=y
> > # CONFIG_LEDS_MC13783 is not set
> > # CONFIG_LEDS_TCA6507 is not set
> > # CONFIG_LEDS_TLC591XX is not set
> > CONFIG_LEDS_MAX77693=y
> > # CONFIG_LEDS_LM355x is not set
> > CONFIG_LEDS_MENF21BMC=y
> > # CONFIG_LEDS_KTD2692 is not set
> > # CONFIG_LEDS_IS31FL319X is not set
> > CONFIG_LEDS_IS31FL32XX=y
> > 
> > #
> > # LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
> > #
> > CONFIG_LEDS_BLINKM=y
> > # CONFIG_LEDS_SYSCON is not set
> > CONFIG_LEDS_MLXCPLD=y
> > # CONFIG_LEDS_MLXREG is not set
> > CONFIG_LEDS_USER=y
> > # CONFIG_LEDS_NIC78BX is not set
> > 
> > #
> > # LED Triggers
> > #
> > # CONFIG_LEDS_TRIGGERS is not set
> > CONFIG_ACCESSIBILITY=y
> > # CONFIG_A11Y_BRAILLE_CONSOLE is not set
> > # CONFIG_INFINIBAND is not set
> > CONFIG_EDAC_ATOMIC_SCRUB=y
> > CONFIG_EDAC_SUPPORT=y
> > # CONFIG_EDAC is not set
> > CONFIG_RTC_LIB=y
> > CONFIG_RTC_MC146818_LIB=y
> > # CONFIG_RTC_CLASS is not set
> > # CONFIG_DMADEVICES is not set
> > 
> > #
> > # DMABUF options
> > #
> > CONFIG_SYNC_FILE=y
> > # CONFIG_SW_SYNC is not set
> > # CONFIG_AUXDISPLAY is not set
> > CONFIG_UIO=y
> > # CONFIG_UIO_CIF is not set
> > CONFIG_UIO_PDRV_GENIRQ=y
> > CONFIG_UIO_DMEM_GENIRQ=y
> > # CONFIG_UIO_AEC is not set
> > # CONFIG_UIO_SERCOS3 is not set
> > # CONFIG_UIO_PCI_GENERIC is not set
> > # CONFIG_UIO_NETX is not set
> > # CONFIG_UIO_PRUSS is not set
> > # CONFIG_UIO_MF624 is not set
> > CONFIG_VIRT_DRIVERS=y
> > # CONFIG_VBOXGUEST is not set
> > CONFIG_VIRTIO=y
> > # CONFIG_VIRTIO_MENU is not set
> > 
> > #
> > # Microsoft Hyper-V guest support
> > #
> > # CONFIG_HYPERV is not set
> > # CONFIG_STAGING is not set
> > CONFIG_X86_PLATFORM_DEVICES=y
> > # CONFIG_ACER_WIRELESS is not set
> > # CONFIG_ACERHDF is not set
> > # CONFIG_ASUS_LAPTOP is not set
> > CONFIG_DELL_SMBIOS=y
> > # CONFIG_DELL_SMBIOS_SMM is not set
> > CONFIG_DELL_LAPTOP=y
> > # CONFIG_DELL_SMO8800 is not set
> > # CONFIG_FUJITSU_LAPTOP is not set
> > # CONFIG_FUJITSU_TABLET is not set
> > # CONFIG_GPD_POCKET_FAN is not set
> > # CONFIG_HP_ACCEL is not set
> > # CONFIG_HP_WIRELESS is not set
> > # CONFIG_PANASONIC_LAPTOP is not set
> > # CONFIG_THINKPAD_ACPI is not set
> > # CONFIG_SENSORS_HDAPS is not set
> > # CONFIG_INTEL_MENLOW is not set
> > # CONFIG_ASUS_WIRELESS is not set
> > # CONFIG_ACPI_WMI is not set
> > # CONFIG_TOPSTAR_LAPTOP is not set
> > # CONFIG_TOSHIBA_BT_RFKILL is not set
> > # CONFIG_TOSHIBA_HAPS is not set
> > # CONFIG_ACPI_CMPC is not set
> > # CONFIG_INTEL_CHT_INT33FE is not set
> > # CONFIG_INTEL_INT0002_VGPIO is not set
> > # CONFIG_INTEL_HID_EVENT is not set
> > # CONFIG_INTEL_VBTN is not set
> > # CONFIG_INTEL_IPS is not set
> > # CONFIG_INTEL_PMC_CORE is not set
> > # CONFIG_IBM_RTL is not set
> > # CONFIG_SAMSUNG_LAPTOP is not set
> > # CONFIG_SAMSUNG_Q10 is not set
> > # CONFIG_APPLE_GMUX is not set
> > # CONFIG_INTEL_RST is not set
> > # CONFIG_INTEL_SMARTCONNECT is not set
> > # CONFIG_PVPANIC is not set
> > # CONFIG_INTEL_PMC_IPC is not set
> > # CONFIG_SURFACE_PRO3_BUTTON is not set
> > CONFIG_INTEL_PUNIT_IPC=y
> > CONFIG_MLX_PLATFORM=y
> > # CONFIG_SILEAD_DMI is not set
> > CONFIG_PMC_ATOM=y
> > # CONFIG_GOLDFISH_BUS is not set
> > # CONFIG_GOLDFISH_PIPE is not set
> > CONFIG_CHROME_PLATFORMS=y
> > CONFIG_CHROMEOS_LAPTOP=y
> > CONFIG_CHROMEOS_PSTORE=y
> > # CONFIG_CHROMEOS_TBMC is not set
> > # CONFIG_CROS_EC_LPC is not set
> > CONFIG_CROS_EC_PROTO=y
> > # CONFIG_CROS_KBD_LED_BACKLIGHT is not set
> > CONFIG_MELLANOX_PLATFORM=y
> > CONFIG_MLXREG_HOTPLUG=y
> > CONFIG_CLKDEV_LOOKUP=y
> > CONFIG_HAVE_CLK_PREPARE=y
> > CONFIG_COMMON_CLK=y
> > 
> > #
> > # Common Clock Framework
> > #
> > # CONFIG_COMMON_CLK_WM831X is not set
> > # CONFIG_CLK_HSDK is not set
> > # CONFIG_COMMON_CLK_MAX77686 is not set
> > # CONFIG_COMMON_CLK_RK808 is not set
> > # CONFIG_COMMON_CLK_SI5351 is not set
> > # CONFIG_COMMON_CLK_SI514 is not set
> > # CONFIG_COMMON_CLK_SI544 is not set
> > # CONFIG_COMMON_CLK_SI570 is not set
> > # CONFIG_COMMON_CLK_CDCE706 is not set
> > # CONFIG_COMMON_CLK_CDCE925 is not set
> > # CONFIG_COMMON_CLK_CS2000_CP is not set
> > # CONFIG_COMMON_CLK_PALMAS is not set
> > # CONFIG_COMMON_CLK_VC5 is not set
> > CONFIG_HWSPINLOCK=y
> > 
> > #
> > # Clock Source drivers
> > #
> > CONFIG_CLKEVT_I8253=y
> > CONFIG_I8253_LOCK=y
> > CONFIG_CLKBLD_I8253=y
> > # CONFIG_MAILBOX is not set
> > CONFIG_IOMMU_SUPPORT=y
> > 
> > #
> > # Generic IOMMU Pagetable Support
> > #
> > # CONFIG_AMD_IOMMU is not set
> > 
> > #
> > # Remoteproc drivers
> > #
> > CONFIG_REMOTEPROC=y
> > 
> > #
> > # Rpmsg drivers
> > #
> > CONFIG_RPMSG=y
> > # CONFIG_RPMSG_CHAR is not set
> > CONFIG_RPMSG_VIRTIO=y
> > CONFIG_SOUNDWIRE=y
> > 
> > #
> > # SoundWire Devices
> > #
> > # CONFIG_SOUNDWIRE_INTEL is not set
> > 
> > #
> > # SOC (System On Chip) specific Drivers
> > #
> > 
> > #
> > # Amlogic SoC drivers
> > #
> > 
> > #
> > # Broadcom SoC drivers
> > #
> > 
> > #
> > # i.MX SoC drivers
> > #
> > 
> > #
> > # Qualcomm SoC drivers
> > #
> > # CONFIG_SOC_TI is not set
> > 
> > #
> > # Xilinx SoC drivers
> > #
> > CONFIG_XILINX_VCU=y
> > # CONFIG_PM_DEVFREQ is not set
> > CONFIG_EXTCON=y
> > 
> > #
> > # Extcon Device Drivers
> > #
> > # CONFIG_EXTCON_ADC_JACK is not set
> > CONFIG_EXTCON_AXP288=y
> > CONFIG_EXTCON_GPIO=y
> > # CONFIG_EXTCON_INTEL_INT3496 is not set
> > CONFIG_EXTCON_MAX14577=y
> > # CONFIG_EXTCON_MAX3355 is not set
> > CONFIG_EXTCON_MAX77693=y
> > CONFIG_EXTCON_PALMAS=y
> > CONFIG_EXTCON_RT8973A=y
> > CONFIG_EXTCON_SM5502=y
> > CONFIG_EXTCON_USB_GPIO=y
> > # CONFIG_EXTCON_USBC_CROS_EC is not set
> > # CONFIG_MEMORY is not set
> > CONFIG_IIO=y
> > CONFIG_IIO_BUFFER=y
> > CONFIG_IIO_BUFFER_CB=y
> > CONFIG_IIO_BUFFER_HW_CONSUMER=y
> > CONFIG_IIO_KFIFO_BUF=y
> > CONFIG_IIO_TRIGGERED_BUFFER=y
> > CONFIG_IIO_CONFIGFS=y
> > CONFIG_IIO_TRIGGER=y
> > CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
> > CONFIG_IIO_SW_DEVICE=y
> > # CONFIG_IIO_SW_TRIGGER is not set
> > 
> > #
> > # Accelerometers
> > #
> > CONFIG_ADXL345=y
> > CONFIG_ADXL345_I2C=y
> > # CONFIG_BMA180 is not set
> > CONFIG_BMC150_ACCEL=y
> > CONFIG_BMC150_ACCEL_I2C=y
> > CONFIG_DA280=y
> > CONFIG_DA311=y
> > CONFIG_DMARD06=y
> > CONFIG_DMARD09=y
> > CONFIG_DMARD10=y
> > CONFIG_IIO_CROS_EC_ACCEL_LEGACY=y
> > CONFIG_KXSD9=y
> > CONFIG_KXSD9_I2C=y
> > # CONFIG_KXCJK1013 is not set
> > CONFIG_MC3230=y
> > # CONFIG_MMA7455_I2C is not set
> > CONFIG_MMA7660=y
> > # CONFIG_MMA8452 is not set
> > CONFIG_MMA9551_CORE=y
> > # CONFIG_MMA9551 is not set
> > CONFIG_MMA9553=y
> > CONFIG_MXC4005=y
> > CONFIG_MXC6255=y
> > CONFIG_STK8312=y
> > CONFIG_STK8BA50=y
> > 
> > #
> > # Analog to digital converters
> > #
> > CONFIG_AD7291=y
> > # CONFIG_AD799X is not set
> > CONFIG_AXP20X_ADC=y
> > CONFIG_AXP288_ADC=y
> > # CONFIG_CC10001_ADC is not set
> > CONFIG_DA9150_GPADC=y
> > # CONFIG_DLN2_ADC is not set
> > CONFIG_ENVELOPE_DETECTOR=y
> > CONFIG_HX711=y
> > CONFIG_LTC2471=y
> > # CONFIG_LTC2485 is not set
> > CONFIG_LTC2497=y
> > # CONFIG_MAX1363 is not set
> > # CONFIG_MAX9611 is not set
> > CONFIG_MCP3422=y
> > CONFIG_MEN_Z188_ADC=y
> > CONFIG_NAU7802=y
> > CONFIG_PALMAS_GPADC=y
> > CONFIG_QCOM_VADC_COMMON=y
> > CONFIG_QCOM_SPMI_IADC=y
> > CONFIG_QCOM_SPMI_VADC=y
> > CONFIG_SD_ADC_MODULATOR=y
> > # CONFIG_TI_ADC081C is not set
> > CONFIG_TI_ADS1015=y
> > # CONFIG_TI_AM335X_ADC is not set
> > CONFIG_VF610_ADC=y
> > CONFIG_VIPERBOARD_ADC=y
> > 
> > #
> > # Analog Front Ends
> > #
> > # CONFIG_IIO_RESCALE is not set
> > 
> > #
> > # Amplifiers
> > #
> > 
> > #
> > # Chemical Sensors
> > #
> > # CONFIG_ATLAS_PH_SENSOR is not set
> > CONFIG_CCS811=y
> > # CONFIG_IAQCORE is not set
> > CONFIG_VZ89X=y
> > CONFIG_IIO_CROS_EC_SENSORS_CORE=y
> > CONFIG_IIO_CROS_EC_SENSORS=y
> > 
> > #
> > # Hid Sensor IIO Common
> > #
> > CONFIG_IIO_MS_SENSORS_I2C=y
> > 
> > #
> > # SSP Sensor Common
> > #
> > CONFIG_IIO_ST_SENSORS_I2C=y
> > CONFIG_IIO_ST_SENSORS_CORE=y
> > 
> > #
> > # Counters
> > #
> > 
> > #
> > # Digital to analog converters
> > #
> > # CONFIG_AD5064 is not set
> > CONFIG_AD5380=y
> > CONFIG_AD5446=y
> > # CONFIG_AD5593R is not set
> > # CONFIG_AD5696_I2C is not set
> > # CONFIG_DPOT_DAC is not set
> > CONFIG_DS4424=y
> > CONFIG_M62332=y
> > # CONFIG_MAX517 is not set
> > CONFIG_MAX5821=y
> > CONFIG_MCP4725=y
> > CONFIG_TI_DAC5571=y
> > CONFIG_VF610_DAC=y
> > 
> > #
> > # IIO dummy driver
> > #
> > CONFIG_IIO_SIMPLE_DUMMY=y
> > # CONFIG_IIO_SIMPLE_DUMMY_EVENTS is not set
> > CONFIG_IIO_SIMPLE_DUMMY_BUFFER=y
> > 
> > #
> > # Frequency Synthesizers DDS/PLL
> > #
> > 
> > #
> > # Clock Generator/Distribution
> > #
> > 
> > #
> > # Phase-Locked Loop (PLL) frequency synthesizers
> > #
> > 
> > #
> > # Digital gyroscope sensors
> > #
> > # CONFIG_BMG160 is not set
> > CONFIG_MPU3050=y
> > CONFIG_MPU3050_I2C=y
> > CONFIG_IIO_ST_GYRO_3AXIS=y
> > CONFIG_IIO_ST_GYRO_I2C_3AXIS=y
> > CONFIG_ITG3200=y
> > 
> > #
> > # Health Sensors
> > #
> > 
> > #
> > # Heart Rate Monitors
> > #
> > CONFIG_AFE4404=y
> > # CONFIG_MAX30100 is not set
> > CONFIG_MAX30102=y
> > 
> > #
> > # Humidity sensors
> > #
> > CONFIG_AM2315=y
> > # CONFIG_DHT11 is not set
> > CONFIG_HDC100X=y
> > CONFIG_HTS221=y
> > CONFIG_HTS221_I2C=y
> > # CONFIG_HTU21 is not set
> > CONFIG_SI7005=y
> > CONFIG_SI7020=y
> > 
> > #
> > # Inertial measurement units
> > #
> > # CONFIG_BMI160_I2C is not set
> > CONFIG_KMX61=y
> > # CONFIG_INV_MPU6050_I2C is not set
> > CONFIG_IIO_ST_LSM6DSX=y
> > CONFIG_IIO_ST_LSM6DSX_I2C=y
> > 
> > #
> > # Light sensors
> > #
> > # CONFIG_ACPI_ALS is not set
> > # CONFIG_ADJD_S311 is not set
> > # CONFIG_AL3320A is not set
> > CONFIG_APDS9300=y
> > CONFIG_APDS9960=y
> > CONFIG_BH1750=y
> > # CONFIG_BH1780 is not set
> > CONFIG_CM32181=y
> > # CONFIG_CM3232 is not set
> > CONFIG_CM3323=y
> > # CONFIG_CM3605 is not set
> > CONFIG_CM36651=y
> > # CONFIG_IIO_CROS_EC_LIGHT_PROX is not set
> > # CONFIG_GP2AP020A00F is not set
> > # CONFIG_SENSORS_ISL29018 is not set
> > CONFIG_SENSORS_ISL29028=y
> > CONFIG_ISL29125=y
> > CONFIG_JSA1212=y
> > CONFIG_RPR0521=y
> > CONFIG_LTR501=y
> > CONFIG_LV0104CS=y
> > # CONFIG_MAX44000 is not set
> > # CONFIG_OPT3001 is not set
> > CONFIG_PA12203001=y
> > # CONFIG_SI1145 is not set
> > CONFIG_STK3310=y
> > CONFIG_ST_UVIS25=y
> > CONFIG_ST_UVIS25_I2C=y
> > # CONFIG_TCS3414 is not set
> > # CONFIG_TCS3472 is not set
> > CONFIG_SENSORS_TSL2563=y
> > CONFIG_TSL2583=y
> > CONFIG_TSL2772=y
> > CONFIG_TSL4531=y
> > # CONFIG_US5182D is not set
> > CONFIG_VCNL4000=y
> > # CONFIG_VEML6070 is not set
> > CONFIG_VL6180=y
> > CONFIG_ZOPT2201=y
> > 
> > #
> > # Magnetometer sensors
> > #
> > CONFIG_AK8974=y
> > CONFIG_AK8975=y
> > CONFIG_AK09911=y
> > CONFIG_BMC150_MAGN=y
> > CONFIG_BMC150_MAGN_I2C=y
> > CONFIG_MAG3110=y
> > CONFIG_MMC35240=y
> > CONFIG_IIO_ST_MAGN_3AXIS=y
> > CONFIG_IIO_ST_MAGN_I2C_3AXIS=y
> > CONFIG_SENSORS_HMC5843=y
> > CONFIG_SENSORS_HMC5843_I2C=y
> > 
> > #
> > # Multiplexers
> > #
> > CONFIG_IIO_MUX=y
> > 
> > #
> > # Inclinometer sensors
> > #
> > 
> > #
> > # Triggers - standalone
> > #
> > CONFIG_IIO_INTERRUPT_TRIGGER=y
> > # CONFIG_IIO_SYSFS_TRIGGER is not set
> > 
> > #
> > # Digital potentiometers
> > #
> > # CONFIG_AD5272 is not set
> > # CONFIG_DS1803 is not set
> > # CONFIG_MCP4018 is not set
> > # CONFIG_MCP4531 is not set
> > CONFIG_TPL0102=y
> > 
> > #
> > # Digital potentiostats
> > #
> > CONFIG_LMP91000=y
> > 
> > #
> > # Pressure sensors
> > #
> > CONFIG_ABP060MG=y
> > # CONFIG_BMP280 is not set
> > # CONFIG_IIO_CROS_EC_BARO is not set
> > # CONFIG_HP03 is not set
> > # CONFIG_MPL115_I2C is not set
> > # CONFIG_MPL3115 is not set
> > CONFIG_MS5611=y
> > # CONFIG_MS5611_I2C is not set
> > CONFIG_MS5637=y
> > CONFIG_IIO_ST_PRESS=y
> > CONFIG_IIO_ST_PRESS_I2C=y
> > # CONFIG_T5403 is not set
> > # CONFIG_HP206C is not set
> > # CONFIG_ZPA2326 is not set
> > 
> > #
> > # Lightning sensors
> > #
> > 
> > #
> > # Proximity and distance sensors
> > #
> > # CONFIG_LIDAR_LITE_V2 is not set
> > CONFIG_RFD77402=y
> > CONFIG_SRF04=y
> > CONFIG_SX9500=y
> > # CONFIG_SRF08 is not set
> > 
> > #
> > # Resolver to digital converters
> > #
> > 
> > #
> > # Temperature sensors
> > #
> > # CONFIG_MLX90614 is not set
> > CONFIG_MLX90632=y
> > # CONFIG_TMP006 is not set
> > CONFIG_TMP007=y
> > CONFIG_TSYS01=y
> > CONFIG_TSYS02D=y
> > # CONFIG_NTB is not set
> > # CONFIG_VME_BUS is not set
> > # CONFIG_PWM is not set
> > 
> > #
> > # IRQ chip support
> > #
> > CONFIG_IRQCHIP=y
> > CONFIG_ARM_GIC_MAX_NR=1
> > CONFIG_IPACK_BUS=y
> > # CONFIG_BOARD_TPCI200 is not set
> > # CONFIG_SERIAL_IPOCTAL is not set
> > CONFIG_RESET_CONTROLLER=y
> > CONFIG_RESET_TI_SYSCON=y
> > CONFIG_FMC=y
> > CONFIG_FMC_FAKEDEV=y
> > CONFIG_FMC_TRIVIAL=y
> > CONFIG_FMC_WRITE_EEPROM=y
> > # CONFIG_FMC_CHARDEV is not set
> > 
> > #
> > # PHY Subsystem
> > #
> > CONFIG_GENERIC_PHY=y
> > # CONFIG_BCM_KONA_USB2_PHY is not set
> > # CONFIG_PHY_PXA_28NM_HSIC is not set
> > CONFIG_PHY_PXA_28NM_USB2=y
> > # CONFIG_PHY_CPCAP_USB is not set
> > CONFIG_PHY_MAPPHONE_MDM6600=y
> > CONFIG_PHY_QCOM_USB_HS=y
> > CONFIG_PHY_QCOM_USB_HSIC=y
> > CONFIG_PHY_TUSB1210=y
> > CONFIG_POWERCAP=y
> > CONFIG_MCB=y
> > # CONFIG_MCB_PCI is not set
> > CONFIG_MCB_LPC=y
> > 
> > #
> > # Performance monitor support
> > #
> > CONFIG_RAS=y
> > # CONFIG_THUNDERBOLT is not set
> > 
> > #
> > # Android
> > #
> > CONFIG_ANDROID=y
> > # CONFIG_ANDROID_BINDER_IPC is not set
> > # CONFIG_LIBNVDIMM is not set
> > CONFIG_DAX=y
> > # CONFIG_DEV_DAX is not set
> > CONFIG_NVMEM=y
> > # CONFIG_RAVE_SP_EEPROM is not set
> > 
> > #
> > # HW tracing support
> > #
> > CONFIG_STM=y
> > # CONFIG_STM_DUMMY is not set
> > CONFIG_STM_SOURCE_CONSOLE=y
> > CONFIG_STM_SOURCE_HEARTBEAT=y
> > # CONFIG_INTEL_TH is not set
> > # CONFIG_FPGA is not set
> > CONFIG_FSI=y
> > CONFIG_FSI_MASTER_GPIO=y
> > CONFIG_FSI_MASTER_HUB=y
> > # CONFIG_FSI_SCOM is not set
> > CONFIG_MULTIPLEXER=y
> > 
> > #
> > # Multiplexer drivers
> > #
> > CONFIG_MUX_ADG792A=y
> > # CONFIG_MUX_GPIO is not set
> > CONFIG_MUX_MMIO=y
> > # CONFIG_UNISYS_VISORBUS is not set
> > CONFIG_SIOX=y
> > CONFIG_SIOX_BUS_GPIO=y
> > # CONFIG_SLIMBUS is not set
> > 
> > #
> > # Firmware Drivers
> > #
> > # CONFIG_EDD is not set
> > CONFIG_FIRMWARE_MEMMAP=y
> > CONFIG_DELL_RBU=y
> > CONFIG_DCDBAS=y
> > CONFIG_DMIID=y
> > # CONFIG_DMI_SYSFS is not set
> > CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
> > # CONFIG_ISCSI_IBFT_FIND is not set
> > CONFIG_FW_CFG_SYSFS=y
> > CONFIG_FW_CFG_SYSFS_CMDLINE=y
> > # CONFIG_GOOGLE_FIRMWARE is not set
> > 
> > #
> > # Tegra firmware driver
> > #
> > 
> > #
> > # File systems
> > #
> > CONFIG_DCACHE_WORD_ACCESS=y
> > CONFIG_FS_IOMAP=y
> > CONFIG_EXT2_FS=y
> > CONFIG_EXT2_FS_XATTR=y
> > CONFIG_EXT2_FS_POSIX_ACL=y
> > # CONFIG_EXT2_FS_SECURITY is not set
> > CONFIG_EXT3_FS=y
> > # CONFIG_EXT3_FS_POSIX_ACL is not set
> > CONFIG_EXT3_FS_SECURITY=y
> > CONFIG_EXT4_FS=y
> > CONFIG_EXT4_FS_POSIX_ACL=y
> > CONFIG_EXT4_FS_SECURITY=y
> > CONFIG_EXT4_ENCRYPTION=y
> > CONFIG_EXT4_FS_ENCRYPTION=y
> > # CONFIG_EXT4_DEBUG is not set
> > CONFIG_JBD2=y
> > # CONFIG_JBD2_DEBUG is not set
> > CONFIG_FS_MBCACHE=y
> > # CONFIG_REISERFS_FS is not set
> > CONFIG_JFS_FS=y
> > CONFIG_JFS_POSIX_ACL=y
> > # CONFIG_JFS_SECURITY is not set
> > CONFIG_JFS_DEBUG=y
> > CONFIG_JFS_STATISTICS=y
> > # CONFIG_XFS_FS is not set
> > CONFIG_GFS2_FS=y
> > # CONFIG_OCFS2_FS is not set
> > CONFIG_BTRFS_FS=y
> > CONFIG_BTRFS_FS_POSIX_ACL=y
> > CONFIG_BTRFS_FS_CHECK_INTEGRITY=y
> > # CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
> > # CONFIG_BTRFS_DEBUG is not set
> > # CONFIG_BTRFS_ASSERT is not set
> > CONFIG_BTRFS_FS_REF_VERIFY=y
> > # CONFIG_NILFS2_FS is not set
> > # CONFIG_F2FS_FS is not set
> > # CONFIG_FS_DAX is not set
> > CONFIG_FS_POSIX_ACL=y
> > CONFIG_EXPORTFS=y
> > CONFIG_EXPORTFS_BLOCK_OPS=y
> > CONFIG_FILE_LOCKING=y
> > # CONFIG_MANDATORY_FILE_LOCKING is not set
> > CONFIG_FS_ENCRYPTION=y
> > CONFIG_FSNOTIFY=y
> > CONFIG_DNOTIFY=y
> > CONFIG_INOTIFY_USER=y
> > # CONFIG_FANOTIFY is not set
> > # CONFIG_QUOTA is not set
> > # CONFIG_QUOTA_NETLINK_INTERFACE is not set
> > CONFIG_QUOTACTL=y
> > CONFIG_AUTOFS4_FS=y
> > CONFIG_AUTOFS_FS=y
> > CONFIG_FUSE_FS=y
> > CONFIG_CUSE=y
> > CONFIG_OVERLAY_FS=y
> > CONFIG_OVERLAY_FS_REDIRECT_DIR=y
> > CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
> > # CONFIG_OVERLAY_FS_INDEX is not set
> > CONFIG_OVERLAY_FS_XINO_AUTO=y
> > 
> > #
> > # Caches
> > #
> > CONFIG_FSCACHE=y
> > CONFIG_FSCACHE_STATS=y
> > # CONFIG_FSCACHE_HISTOGRAM is not set
> > CONFIG_FSCACHE_DEBUG=y
> > # CONFIG_FSCACHE_OBJECT_LIST is not set
> > # CONFIG_CACHEFILES is not set
> > 
> > #
> > # CD-ROM/DVD Filesystems
> > #
> > CONFIG_ISO9660_FS=y
> > CONFIG_JOLIET=y
> > CONFIG_ZISOFS=y
> > # CONFIG_UDF_FS is not set
> > 
> > #
> > # DOS/FAT/NT Filesystems
> > #
> > CONFIG_FAT_FS=y
> > CONFIG_MSDOS_FS=y
> > CONFIG_VFAT_FS=y
> > CONFIG_FAT_DEFAULT_CODEPAGE=437
> > CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
> > # CONFIG_FAT_DEFAULT_UTF8 is not set
> > # CONFIG_NTFS_FS is not set
> > 
> > #
> > # Pseudo filesystems
> > #
> > CONFIG_PROC_FS=y
> > # CONFIG_PROC_KCORE is not set
> > CONFIG_PROC_SYSCTL=y
> > CONFIG_PROC_PAGE_MONITOR=y
> > # CONFIG_PROC_CHILDREN is not set
> > CONFIG_KERNFS=y
> > CONFIG_SYSFS=y
> > CONFIG_TMPFS=y
> > # CONFIG_TMPFS_POSIX_ACL is not set
> > # CONFIG_TMPFS_XATTR is not set
> > # CONFIG_HUGETLBFS is not set
> > CONFIG_MEMFD_CREATE=y
> > CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
> > CONFIG_CONFIGFS_FS=y
> > # CONFIG_MISC_FILESYSTEMS is not set
> > CONFIG_NETWORK_FILESYSTEMS=y
> > CONFIG_NFS_FS=y
> > CONFIG_NFS_V2=y
> > CONFIG_NFS_V3=y
> > # CONFIG_NFS_V3_ACL is not set
> > CONFIG_NFS_V4=y
> > # CONFIG_NFS_SWAP is not set
> > # CONFIG_NFS_V4_1 is not set
> > # CONFIG_ROOT_NFS is not set
> > # CONFIG_NFS_FSCACHE is not set
> > # CONFIG_NFS_USE_LEGACY_DNS is not set
> > CONFIG_NFS_USE_KERNEL_DNS=y
> > # CONFIG_NFSD is not set
> > CONFIG_GRACE_PERIOD=y
> > CONFIG_LOCKD=y
> > CONFIG_LOCKD_V4=y
> > CONFIG_NFS_COMMON=y
> > CONFIG_SUNRPC=y
> > CONFIG_SUNRPC_GSS=y
> > CONFIG_RPCSEC_GSS_KRB5=y
> > # CONFIG_SUNRPC_DEBUG is not set
> > # CONFIG_CEPH_FS is not set
> > CONFIG_CIFS=y
> > # CONFIG_CIFS_STATS is not set
> > # CONFIG_CIFS_WEAK_PW_HASH is not set
> > # CONFIG_CIFS_UPCALL is not set
> > # CONFIG_CIFS_XATTR is not set
> > CONFIG_CIFS_DEBUG=y
> > # CONFIG_CIFS_DEBUG2 is not set
> > # CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
> > # CONFIG_CIFS_DFS_UPCALL is not set
> > # CONFIG_CIFS_SMB311 is not set
> > # CONFIG_CIFS_FSCACHE is not set
> > # CONFIG_CODA_FS is not set
> > # CONFIG_AFS_FS is not set
> > CONFIG_NLS=y
> > CONFIG_NLS_DEFAULT="iso8859-1"
> > CONFIG_NLS_CODEPAGE_437=y
> > CONFIG_NLS_CODEPAGE_737=y
> > CONFIG_NLS_CODEPAGE_775=y
> > CONFIG_NLS_CODEPAGE_850=y
> > CONFIG_NLS_CODEPAGE_852=y
> > CONFIG_NLS_CODEPAGE_855=y
> > # CONFIG_NLS_CODEPAGE_857 is not set
> > CONFIG_NLS_CODEPAGE_860=y
> > # CONFIG_NLS_CODEPAGE_861 is not set
> > # CONFIG_NLS_CODEPAGE_862 is not set
> > CONFIG_NLS_CODEPAGE_863=y
> > CONFIG_NLS_CODEPAGE_864=y
> > # CONFIG_NLS_CODEPAGE_865 is not set
> > CONFIG_NLS_CODEPAGE_866=y
> > # CONFIG_NLS_CODEPAGE_869 is not set
> > # CONFIG_NLS_CODEPAGE_936 is not set
> > # CONFIG_NLS_CODEPAGE_950 is not set
> > CONFIG_NLS_CODEPAGE_932=y
> > CONFIG_NLS_CODEPAGE_949=y
> > CONFIG_NLS_CODEPAGE_874=y
> > CONFIG_NLS_ISO8859_8=y
> > CONFIG_NLS_CODEPAGE_1250=y
> > CONFIG_NLS_CODEPAGE_1251=y
> > CONFIG_NLS_ASCII=y
> > CONFIG_NLS_ISO8859_1=y
> > # CONFIG_NLS_ISO8859_2 is not set
> > CONFIG_NLS_ISO8859_3=y
> > CONFIG_NLS_ISO8859_4=y
> > CONFIG_NLS_ISO8859_5=y
> > # CONFIG_NLS_ISO8859_6 is not set
> > CONFIG_NLS_ISO8859_7=y
> > CONFIG_NLS_ISO8859_9=y
> > CONFIG_NLS_ISO8859_13=y
> > CONFIG_NLS_ISO8859_14=y
> > CONFIG_NLS_ISO8859_15=y
> > # CONFIG_NLS_KOI8_R is not set
> > CONFIG_NLS_KOI8_U=y
> > # CONFIG_NLS_MAC_ROMAN is not set
> > # CONFIG_NLS_MAC_CELTIC is not set
> > CONFIG_NLS_MAC_CENTEURO=y
> > CONFIG_NLS_MAC_CROATIAN=y
> > CONFIG_NLS_MAC_CYRILLIC=y
> > CONFIG_NLS_MAC_GAELIC=y
> > CONFIG_NLS_MAC_GREEK=y
> > CONFIG_NLS_MAC_ICELAND=y
> > CONFIG_NLS_MAC_INUIT=y
> > # CONFIG_NLS_MAC_ROMANIAN is not set
> > CONFIG_NLS_MAC_TURKISH=y
> > # CONFIG_NLS_UTF8 is not set
> > # CONFIG_DLM is not set
> > 
> > #
> > # Kernel hacking
> > #
> > CONFIG_TRACE_IRQFLAGS_SUPPORT=y
> > 
> > #
> > # printk and dmesg options
> > #
> > CONFIG_PRINTK_TIME=y
> > CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
> > CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
> > # CONFIG_BOOT_PRINTK_DELAY is not set
> > # CONFIG_DYNAMIC_DEBUG is not set
> > 
> > #
> > # Compile-time checks and compiler options
> > #
> > CONFIG_DEBUG_INFO=y
> > CONFIG_DEBUG_INFO_REDUCED=y
> > # CONFIG_DEBUG_INFO_SPLIT is not set
> > # CONFIG_DEBUG_INFO_DWARF4 is not set
> > # CONFIG_GDB_SCRIPTS is not set
> > CONFIG_ENABLE_WARN_DEPRECATED=y
> > # CONFIG_ENABLE_MUST_CHECK is not set
> > CONFIG_FRAME_WARN=2048
> > CONFIG_STRIP_ASM_SYMS=y
> > # CONFIG_READABLE_ASM is not set
> > # CONFIG_UNUSED_SYMBOLS is not set
> > # CONFIG_PAGE_OWNER is not set
> > CONFIG_DEBUG_FS=y
> > CONFIG_HEADERS_CHECK=y
> > CONFIG_DEBUG_SECTION_MISMATCH=y
> > # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
> > CONFIG_FRAME_POINTER=y
> > CONFIG_STACK_VALIDATION=y
> > # CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
> > CONFIG_MAGIC_SYSRQ=y
> > CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
> > # CONFIG_MAGIC_SYSRQ_SERIAL is not set
> > CONFIG_DEBUG_KERNEL=y
> > 
> > #
> > # Memory Debugging
> > #
> > CONFIG_PAGE_EXTENSION=y
> > CONFIG_DEBUG_PAGEALLOC=y
> > CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT=y
> > CONFIG_PAGE_POISONING=y
> > CONFIG_PAGE_POISONING_NO_SANITY=y
> > CONFIG_PAGE_POISONING_ZERO=y
> > # CONFIG_DEBUG_RODATA_TEST is not set
> > # CONFIG_DEBUG_OBJECTS is not set
> > CONFIG_DEBUG_SLAB=y
> > # CONFIG_DEBUG_SLAB_LEAK is not set
> > CONFIG_HAVE_DEBUG_KMEMLEAK=y
> > # CONFIG_DEBUG_KMEMLEAK is not set
> > CONFIG_DEBUG_STACK_USAGE=y
> > # CONFIG_DEBUG_VM is not set
> > CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
> > CONFIG_DEBUG_VIRTUAL=y
> > CONFIG_DEBUG_MEMORY_INIT=y
> > # CONFIG_DEBUG_PER_CPU_MAPS is not set
> > CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
> > # CONFIG_DEBUG_STACKOVERFLOW is not set
> > CONFIG_HAVE_ARCH_KASAN=y
> > CONFIG_ARCH_HAS_KCOV=y
> > CONFIG_CC_HAS_SANCOV_TRACE_PC=y
> > # CONFIG_KCOV is not set
> > # CONFIG_DEBUG_SHIRQ is not set
> > 
> > #
> > # Debug Lockups and Hangs
> > #
> > CONFIG_LOCKUP_DETECTOR=y
> > CONFIG_SOFTLOCKUP_DETECTOR=y
> > CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
> > CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=1
> > CONFIG_HARDLOCKUP_DETECTOR_PERF=y
> > CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
> > CONFIG_HARDLOCKUP_DETECTOR=y
> > # CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is not set
> > CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=0
> > # CONFIG_DETECT_HUNG_TASK is not set
> > # CONFIG_WQ_WATCHDOG is not set
> > CONFIG_PANIC_ON_OOPS=y
> > CONFIG_PANIC_ON_OOPS_VALUE=1
> > CONFIG_PANIC_TIMEOUT=0
> > CONFIG_SCHED_DEBUG=y
> > CONFIG_SCHED_INFO=y
> > CONFIG_SCHEDSTATS=y
> > CONFIG_SCHED_STACK_END_CHECK=y
> > # CONFIG_DEBUG_TIMEKEEPING is not set
> > CONFIG_DEBUG_PREEMPT=y
> > 
> > #
> > # Lock Debugging (spinlocks, mutexes, etc...)
> > #
> > CONFIG_LOCK_DEBUGGING_SUPPORT=y
> > CONFIG_PROVE_LOCKING=y
> > CONFIG_LOCK_STAT=y
> > CONFIG_DEBUG_RT_MUTEXES=y
> > CONFIG_DEBUG_SPINLOCK=y
> > CONFIG_DEBUG_MUTEXES=y
> > CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
> > CONFIG_DEBUG_RWSEMS=y
> > CONFIG_DEBUG_LOCK_ALLOC=y
> > CONFIG_LOCKDEP=y
> > # CONFIG_DEBUG_LOCKDEP is not set
> > CONFIG_DEBUG_ATOMIC_SLEEP=y
> > # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
> > # CONFIG_LOCK_TORTURE_TEST is not set
> > CONFIG_WW_MUTEX_SELFTEST=y
> > CONFIG_TRACE_IRQFLAGS=y
> > CONFIG_STACKTRACE=y
> > CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
> > # CONFIG_DEBUG_KOBJECT is not set
> > CONFIG_DEBUG_BUGVERBOSE=y
> > CONFIG_DEBUG_LIST=y
> > # CONFIG_DEBUG_PI_LIST is not set
> > CONFIG_DEBUG_SG=y
> > # CONFIG_DEBUG_NOTIFIERS is not set
> > # CONFIG_DEBUG_CREDENTIALS is not set
> > 
> > #
> > # RCU Debugging
> > #
> > CONFIG_PROVE_RCU=y
> > CONFIG_TORTURE_TEST=y
> > # CONFIG_RCU_PERF_TEST is not set
> > CONFIG_RCU_TORTURE_TEST=y
> > CONFIG_RCU_CPU_STALL_TIMEOUT=21
> > CONFIG_RCU_TRACE=y
> > CONFIG_RCU_EQS_DEBUG=y
> > CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
> > # CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
> > # CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
> > # CONFIG_NOTIFIER_ERROR_INJECTION is not set
> > CONFIG_FAULT_INJECTION=y
> > # CONFIG_FAILSLAB is not set
> > CONFIG_FAIL_PAGE_ALLOC=y
> > # CONFIG_FAIL_MAKE_REQUEST is not set
> > CONFIG_FAIL_IO_TIMEOUT=y
> > # CONFIG_FAIL_FUTEX is not set
> > # CONFIG_FAULT_INJECTION_DEBUG_FS is not set
> > CONFIG_LATENCYTOP=y
> > CONFIG_USER_STACKTRACE_SUPPORT=y
> > CONFIG_HAVE_FUNCTION_TRACER=y
> > CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
> > CONFIG_HAVE_DYNAMIC_FTRACE=y
> > CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
> > CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
> > CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
> > CONFIG_HAVE_FENTRY=y
> > CONFIG_HAVE_C_RECORDMCOUNT=y
> > CONFIG_TRACE_CLOCK=y
> > CONFIG_TRACING_SUPPORT=y
> > # CONFIG_FTRACE is not set
> > # CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
> > # CONFIG_DMA_API_DEBUG is not set
> > # CONFIG_RUNTIME_TESTING_MENU is not set
> > # CONFIG_MEMTEST is not set
> > CONFIG_BUG_ON_DATA_CORRUPTION=y
> > # CONFIG_SAMPLES is not set
> > CONFIG_HAVE_ARCH_KGDB=y
> > # CONFIG_KGDB is not set
> > CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
> > CONFIG_UBSAN=y
> > # CONFIG_UBSAN_SANITIZE_ALL is not set
> > # CONFIG_UBSAN_ALIGNMENT is not set
> > CONFIG_UBSAN_NULL=y
> > CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
> > CONFIG_STRICT_DEVMEM=y
> > # CONFIG_IO_STRICT_DEVMEM is not set
> > CONFIG_X86_VERBOSE_BOOTUP=y
> > CONFIG_EARLY_PRINTK=y
> > # CONFIG_EARLY_PRINTK_DBGP is not set
> > # CONFIG_EARLY_PRINTK_USB_XDBC is not set
> > CONFIG_X86_PTDUMP_CORE=y
> > CONFIG_X86_PTDUMP=y
> > CONFIG_DEBUG_WX=y
> > CONFIG_DOUBLEFAULT=y
> > # CONFIG_DEBUG_TLBFLUSH is not set
> > CONFIG_HAVE_MMIOTRACE_SUPPORT=y
> > CONFIG_IO_DELAY_TYPE_0X80=0
> > CONFIG_IO_DELAY_TYPE_0XED=1
> > CONFIG_IO_DELAY_TYPE_UDELAY=2
> > CONFIG_IO_DELAY_TYPE_NONE=3
> > CONFIG_IO_DELAY_0X80=y
> > # CONFIG_IO_DELAY_0XED is not set
> > # CONFIG_IO_DELAY_UDELAY is not set
> > # CONFIG_IO_DELAY_NONE is not set
> > CONFIG_DEFAULT_IO_DELAY_TYPE=0
> > CONFIG_DEBUG_BOOT_PARAMS=y
> > # CONFIG_CPA_DEBUG is not set
> > # CONFIG_OPTIMIZE_INLINING is not set
> > # CONFIG_DEBUG_ENTRY is not set
> > # CONFIG_DEBUG_NMI_SELFTEST is not set
> > CONFIG_X86_DEBUG_FPU=y
> > # CONFIG_PUNIT_ATOM_DEBUG is not set
> > # CONFIG_UNWINDER_ORC is not set
> > CONFIG_UNWINDER_FRAME_POINTER=y
> > 
> > #
> > # Security options
> > #
> > CONFIG_KEYS=y
> > # CONFIG_PERSISTENT_KEYRINGS is not set
> > # CONFIG_BIG_KEYS is not set
> > CONFIG_TRUSTED_KEYS=y
> > CONFIG_ENCRYPTED_KEYS=y
> > # CONFIG_KEY_DH_OPERATIONS is not set
> > CONFIG_SECURITY_DMESG_RESTRICT=y
> > # CONFIG_SECURITY is not set
> > CONFIG_SECURITYFS=y
> > CONFIG_PAGE_TABLE_ISOLATION=y
> > CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
> > # CONFIG_HARDENED_USERCOPY is not set
> > CONFIG_FORTIFY_SOURCE=y
> > CONFIG_STATIC_USERMODEHELPER=y
> > CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
> > CONFIG_DEFAULT_SECURITY_DAC=y
> > CONFIG_DEFAULT_SECURITY=""
> > CONFIG_XOR_BLOCKS=y
> > CONFIG_ASYNC_CORE=y
> > CONFIG_ASYNC_XOR=y
> > CONFIG_CRYPTO=y
> > 
> > #
> > # Crypto core or helper
> > #
> > CONFIG_CRYPTO_ALGAPI=y
> > CONFIG_CRYPTO_ALGAPI2=y
> > CONFIG_CRYPTO_AEAD=y
> > CONFIG_CRYPTO_AEAD2=y
> > CONFIG_CRYPTO_BLKCIPHER=y
> > CONFIG_CRYPTO_BLKCIPHER2=y
> > CONFIG_CRYPTO_HASH=y
> > CONFIG_CRYPTO_HASH2=y
> > CONFIG_CRYPTO_RNG=y
> > CONFIG_CRYPTO_RNG2=y
> > CONFIG_CRYPTO_RNG_DEFAULT=y
> > CONFIG_CRYPTO_AKCIPHER2=y
> > CONFIG_CRYPTO_AKCIPHER=y
> > CONFIG_CRYPTO_KPP2=y
> > CONFIG_CRYPTO_KPP=y
> > CONFIG_CRYPTO_ACOMP2=y
> > CONFIG_CRYPTO_RSA=y
> > CONFIG_CRYPTO_DH=y
> > CONFIG_CRYPTO_ECDH=y
> > CONFIG_CRYPTO_MANAGER=y
> > CONFIG_CRYPTO_MANAGER2=y
> > # CONFIG_CRYPTO_USER is not set
> > CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
> > CONFIG_CRYPTO_GF128MUL=y
> > CONFIG_CRYPTO_NULL=y
> > CONFIG_CRYPTO_NULL2=y
> > CONFIG_CRYPTO_PCRYPT=y
> > CONFIG_CRYPTO_WORKQUEUE=y
> > CONFIG_CRYPTO_CRYPTD=y
> > CONFIG_CRYPTO_MCRYPTD=y
> > CONFIG_CRYPTO_AUTHENC=y
> > CONFIG_CRYPTO_SIMD=y
> > CONFIG_CRYPTO_GLUE_HELPER_X86=y
> > CONFIG_CRYPTO_ENGINE=y
> > 
> > #
> > # Authenticated Encryption with Associated Data
> > #
> > CONFIG_CRYPTO_CCM=y
> > CONFIG_CRYPTO_GCM=y
> > CONFIG_CRYPTO_CHACHA20POLY1305=y
> > # CONFIG_CRYPTO_AEGIS128 is not set
> > CONFIG_CRYPTO_AEGIS128L=y
> > CONFIG_CRYPTO_AEGIS256=y
> > CONFIG_CRYPTO_AEGIS128_AESNI_SSE2=y
> > CONFIG_CRYPTO_AEGIS128L_AESNI_SSE2=y
> > CONFIG_CRYPTO_AEGIS256_AESNI_SSE2=y
> > # CONFIG_CRYPTO_MORUS640 is not set
> > CONFIG_CRYPTO_MORUS640_GLUE=y
> > CONFIG_CRYPTO_MORUS640_SSE2=y
> > # CONFIG_CRYPTO_MORUS1280 is not set
> > CONFIG_CRYPTO_MORUS1280_GLUE=y
> > # CONFIG_CRYPTO_MORUS1280_SSE2 is not set
> > CONFIG_CRYPTO_MORUS1280_AVX2=y
> > CONFIG_CRYPTO_SEQIV=y
> > CONFIG_CRYPTO_ECHAINIV=y
> > 
> > #
> > # Block modes
> > #
> > CONFIG_CRYPTO_CBC=y
> > # CONFIG_CRYPTO_CFB is not set
> > CONFIG_CRYPTO_CTR=y
> > CONFIG_CRYPTO_CTS=y
> > CONFIG_CRYPTO_ECB=y
> > CONFIG_CRYPTO_LRW=y
> > CONFIG_CRYPTO_PCBC=y
> > CONFIG_CRYPTO_XTS=y
> > CONFIG_CRYPTO_KEYWRAP=y
> > 
> > #
> > # Hash modes
> > #
> > CONFIG_CRYPTO_CMAC=y
> > CONFIG_CRYPTO_HMAC=y
> > CONFIG_CRYPTO_XCBC=y
> > CONFIG_CRYPTO_VMAC=y
> > 
> > #
> > # Digest
> > #
> > CONFIG_CRYPTO_CRC32C=y
> > CONFIG_CRYPTO_CRC32C_INTEL=y
> > CONFIG_CRYPTO_CRC32=y
> > CONFIG_CRYPTO_CRC32_PCLMUL=y
> > CONFIG_CRYPTO_CRCT10DIF=y
> > CONFIG_CRYPTO_CRCT10DIF_PCLMUL=y
> > CONFIG_CRYPTO_GHASH=y
> > CONFIG_CRYPTO_POLY1305=y
> > CONFIG_CRYPTO_POLY1305_X86_64=y
> > CONFIG_CRYPTO_MD4=y
> > CONFIG_CRYPTO_MD5=y
> > # CONFIG_CRYPTO_MICHAEL_MIC is not set
> > CONFIG_CRYPTO_RMD128=y
> > CONFIG_CRYPTO_RMD160=y
> > CONFIG_CRYPTO_RMD256=y
> > CONFIG_CRYPTO_RMD320=y
> > CONFIG_CRYPTO_SHA1=y
> > # CONFIG_CRYPTO_SHA1_SSSE3 is not set
> > CONFIG_CRYPTO_SHA256_SSSE3=y
> > # CONFIG_CRYPTO_SHA512_SSSE3 is not set
> > CONFIG_CRYPTO_SHA1_MB=y
> > CONFIG_CRYPTO_SHA256_MB=y
> > CONFIG_CRYPTO_SHA512_MB=y
> > CONFIG_CRYPTO_SHA256=y
> > CONFIG_CRYPTO_SHA512=y
> > # CONFIG_CRYPTO_SHA3 is not set
> > # CONFIG_CRYPTO_SM3 is not set
> > # CONFIG_CRYPTO_TGR192 is not set
> > CONFIG_CRYPTO_WP512=y
> > CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=y
> > 
> > #
> > # Ciphers
> > #
> > CONFIG_CRYPTO_AES=y
> > CONFIG_CRYPTO_AES_TI=y
> > CONFIG_CRYPTO_AES_X86_64=y
> > CONFIG_CRYPTO_AES_NI_INTEL=y
> > CONFIG_CRYPTO_ANUBIS=y
> > CONFIG_CRYPTO_ARC4=y
> > CONFIG_CRYPTO_BLOWFISH=y
> > CONFIG_CRYPTO_BLOWFISH_COMMON=y
> > # CONFIG_CRYPTO_BLOWFISH_X86_64 is not set
> > # CONFIG_CRYPTO_CAMELLIA is not set
> > CONFIG_CRYPTO_CAMELLIA_X86_64=y
> > CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=y
> > CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=y
> > CONFIG_CRYPTO_CAST_COMMON=y
> > CONFIG_CRYPTO_CAST5=y
> > CONFIG_CRYPTO_CAST5_AVX_X86_64=y
> > CONFIG_CRYPTO_CAST6=y
> > # CONFIG_CRYPTO_CAST6_AVX_X86_64 is not set
> > CONFIG_CRYPTO_DES=y
> > CONFIG_CRYPTO_DES3_EDE_X86_64=y
> > CONFIG_CRYPTO_FCRYPT=y
> > CONFIG_CRYPTO_KHAZAD=y
> > CONFIG_CRYPTO_SALSA20=y
> > CONFIG_CRYPTO_CHACHA20=y
> > # CONFIG_CRYPTO_CHACHA20_X86_64 is not set
> > # CONFIG_CRYPTO_SEED is not set
> > CONFIG_CRYPTO_SERPENT=y
> > CONFIG_CRYPTO_SERPENT_SSE2_X86_64=y
> > CONFIG_CRYPTO_SERPENT_AVX_X86_64=y
> > CONFIG_CRYPTO_SERPENT_AVX2_X86_64=y
> > CONFIG_CRYPTO_SM4=y
> > CONFIG_CRYPTO_SPECK=y
> > CONFIG_CRYPTO_TEA=y
> > CONFIG_CRYPTO_TWOFISH=y
> > CONFIG_CRYPTO_TWOFISH_COMMON=y
> > CONFIG_CRYPTO_TWOFISH_X86_64=y
> > CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=y
> > CONFIG_CRYPTO_TWOFISH_AVX_X86_64=y
> > 
> > #
> > # Compression
> > #
> > CONFIG_CRYPTO_DEFLATE=y
> > # CONFIG_CRYPTO_LZO is not set
> > CONFIG_CRYPTO_842=y
> > # CONFIG_CRYPTO_LZ4 is not set
> > # CONFIG_CRYPTO_LZ4HC is not set
> > CONFIG_CRYPTO_ZSTD=y
> > 
> > #
> > # Random Number Generation
> > #
> > CONFIG_CRYPTO_ANSI_CPRNG=y
> > CONFIG_CRYPTO_DRBG_MENU=y
> > CONFIG_CRYPTO_DRBG_HMAC=y
> > CONFIG_CRYPTO_DRBG_HASH=y
> > CONFIG_CRYPTO_DRBG_CTR=y
> > CONFIG_CRYPTO_DRBG=y
> > CONFIG_CRYPTO_JITTERENTROPY=y
> > # CONFIG_CRYPTO_USER_API_HASH is not set
> > # CONFIG_CRYPTO_USER_API_SKCIPHER is not set
> > # CONFIG_CRYPTO_USER_API_RNG is not set
> > # CONFIG_CRYPTO_USER_API_AEAD is not set
> > CONFIG_CRYPTO_HASH_INFO=y
> > CONFIG_CRYPTO_HW=y
> > CONFIG_CRYPTO_DEV_PADLOCK=y
> > CONFIG_CRYPTO_DEV_PADLOCK_AES=y
> > # CONFIG_CRYPTO_DEV_PADLOCK_SHA is not set
> > # CONFIG_CRYPTO_DEV_CCP is not set
> > # CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
> > # CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
> > # CONFIG_CRYPTO_DEV_QAT_C62X is not set
> > # CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
> > # CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
> > # CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
> > CONFIG_CRYPTO_DEV_VIRTIO=y
> > # CONFIG_CRYPTO_DEV_CCREE is not set
> > # CONFIG_ASYMMETRIC_KEY_TYPE is not set
> > 
> > #
> > # Certificates for signature checking
> > #
> > # CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
> > CONFIG_HAVE_KVM=y
> > CONFIG_VIRTUALIZATION=y
> > # CONFIG_KVM is not set
> > # CONFIG_VHOST_NET is not set
> > # CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set
> > 
> > #
> > # Library routines
> > #
> > CONFIG_RAID6_PQ=y
> > CONFIG_BITREVERSE=y
> > CONFIG_RATIONAL=y
> > CONFIG_GENERIC_STRNCPY_FROM_USER=y
> > CONFIG_GENERIC_STRNLEN_USER=y
> > CONFIG_GENERIC_NET_UTILS=y
> > CONFIG_GENERIC_FIND_FIRST_BIT=y
> > CONFIG_GENERIC_PCI_IOMAP=y
> > CONFIG_GENERIC_IOMAP=y
> > CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
> > CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
> > CONFIG_CRC_CCITT=y
> > CONFIG_CRC16=y
> > CONFIG_CRC_T10DIF=y
> > CONFIG_CRC_ITU_T=y
> > CONFIG_CRC32=y
> > CONFIG_CRC32_SELFTEST=y
> > # CONFIG_CRC32_SLICEBY8 is not set
> > CONFIG_CRC32_SLICEBY4=y
> > # CONFIG_CRC32_SARWATE is not set
> > # CONFIG_CRC32_BIT is not set
> > CONFIG_CRC4=y
> > CONFIG_CRC7=y
> > CONFIG_LIBCRC32C=y
> > CONFIG_CRC8=y
> > CONFIG_XXHASH=y
> > # CONFIG_RANDOM32_SELFTEST is not set
> > CONFIG_842_COMPRESS=y
> > CONFIG_842_DECOMPRESS=y
> > CONFIG_ZLIB_INFLATE=y
> > CONFIG_ZLIB_DEFLATE=y
> > CONFIG_LZO_COMPRESS=y
> > CONFIG_LZO_DECOMPRESS=y
> > CONFIG_ZSTD_COMPRESS=y
> > CONFIG_ZSTD_DECOMPRESS=y
> > # CONFIG_XZ_DEC is not set
> > CONFIG_DECOMPRESS_GZIP=y
> > CONFIG_DECOMPRESS_LZMA=y
> > CONFIG_DECOMPRESS_LZO=y
> > CONFIG_GENERIC_ALLOCATOR=y
> > CONFIG_RADIX_TREE_MULTIORDER=y
> > CONFIG_ASSOCIATIVE_ARRAY=y
> > CONFIG_HAS_IOMEM=y
> > CONFIG_HAS_IOPORT_MAP=y
> > CONFIG_HAS_DMA=y
> > CONFIG_NEED_SG_DMA_LENGTH=y
> > CONFIG_NEED_DMA_MAP_STATE=y
> > CONFIG_ARCH_DMA_ADDR_T_64BIT=y
> > CONFIG_DMA_DIRECT_OPS=y
> > CONFIG_SWIOTLB=y
> > CONFIG_SGL_ALLOC=y
> > CONFIG_CPU_RMAP=y
> > CONFIG_DQL=y
> > CONFIG_NLATTR=y
> > CONFIG_CLZ_TAB=y
> > # CONFIG_CORDIC is not set
> > # CONFIG_DDR is not set
> > CONFIG_IRQ_POLL=y
> > CONFIG_MPILIB=y
> > CONFIG_LIBFDT=y
> > CONFIG_OID_REGISTRY=y
> > CONFIG_FONT_SUPPORT=y
> > # CONFIG_FONTS is not set
> > CONFIG_FONT_8x8=y
> > CONFIG_FONT_8x16=y
> > CONFIG_SG_POOL=y
> > CONFIG_ARCH_HAS_SG_CHAIN=y
> > CONFIG_ARCH_HAS_PMEM_API=y
> > CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
> > CONFIG_ARCH_HAS_UACCESS_MCSAFE=y
> > CONFIG_SBITMAP=y
> > CONFIG_PRIME_NUMBERS=y
> > CONFIG_STRING_SELFTEST=y
> 
> > #!/bin/sh
> > 
> > export_top_env()
> > {
> > 	export suite='boot'
> > 	export testcase='boot'
> > 	export timeout='10m'
> > 	export job_origin='/lkp/lkp/src/jobs/boot.yaml'
> > 	export queue='bisect'
> > 	export testbox='vm-ivb41-quantal-x86_64-23'
> > 	export tbox_group='vm-ivb41-quantal-x86_64'
> > 	export branch='linux-devel/devel-spot-201807211235'
> > 	export commit='3398b55446fb602245007d5955b6778fb6ff326a'
> > 	export kconfig='x86_64-randconfig-a0-07211320'
> > 	export submit_id='5b5597210b9a930c13b32658'
> > 	export job_file='/lkp/scheduled/vm-ivb41-quantal-x86_64-23/boot-1-quantal-core-x86_64.cgz-3398b55446fb602245007d5955b6778fb6ff326a-20180723-3091-qqfgj0-0.yaml'
> > 	export id='698f7bcdb51f450627f00f39d141162ca35eadc2'
> > 	export model='qemu-system-x86_64 -enable-kvm'
> > 	export nr_vm=32
> > 	export nr_cpu=2
> > 	export memory='512M'
> > 	export rootfs='quantal-core-x86_64.cgz'
> > 	export need_kconfig='CONFIG_KVM_GUEST=y'
> > 	export compiler='gcc-7'
> > 	export enqueue_time='2018-07-23 16:51:45 +0800'
> > 	export _id='5b5597210b9a930c13b32658'
> > 	export _rt='/result/boot/1/vm-ivb41-quantal-x86_64/quantal-core-x86_64.cgz/x86_64-randconfig-a0-07211320/gcc-7/3398b55446fb602245007d5955b6778fb6ff326a'
> > 	export user='lkp'
> > 	export result_root='/result/boot/1/vm-ivb41-quantal-x86_64/quantal-core-x86_64.cgz/x86_64-randconfig-a0-07211320/gcc-7/3398b55446fb602245007d5955b6778fb6ff326a/0'
> > 	export LKP_SERVER='inn'
> > 	export max_uptime=600
> > 	export initrd='/osimage/quantal/quantal-core-x86_64.cgz'
> > 	export bootloader_append='root=/dev/ram0
> > user=lkp
> > job=/lkp/scheduled/vm-ivb41-quantal-x86_64-23/boot-1-quantal-core-x86_64.cgz-3398b55446fb602245007d5955b6778fb6ff326a-20180723-3091-qqfgj0-0.yaml
> > ARCH=x86_64
> > kconfig=x86_64-randconfig-a0-07211320
> > branch=linux-devel/devel-spot-201807211235
> > commit=3398b55446fb602245007d5955b6778fb6ff326a
> > BOOT_IMAGE=/pkg/linux/x86_64-randconfig-a0-07211320/gcc-7/3398b55446fb602245007d5955b6778fb6ff326a/vmlinuz-4.18.0-rc5-00173-g3398b55
> > max_uptime=600
> > RESULT_ROOT=/result/boot/1/vm-ivb41-quantal-x86_64/quantal-core-x86_64.cgz/x86_64-randconfig-a0-07211320/gcc-7/3398b55446fb602245007d5955b6778fb6ff326a/0
> > LKP_SERVER=inn
> > debug
> > apic=debug
> > sysrq_always_enabled
> > rcupdate.rcu_cpu_stall_timeout=100
> > net.ifnames=0
> > printk.devkmsg=on
> > panic=-1
> > softlockup_panic=1
> > nmi_watchdog=panic
> > oops=panic
> > load_ramdisk=2
> > prompt_ramdisk=0
> > drbd.minor_count=8
> > systemd.log_level=err
> > ignore_loglevel
> > console=tty0
> > earlyprintk=ttyS0,115200
> > console=ttyS0,115200
> > vga=normal
> > rw'
> > 	export lkp_initrd='/lkp/lkp/lkp-x86_64.cgz'
> > 	export site='inn'
> > 	export LKP_CGI_PORT=80
> > 	export LKP_CIFS_PORT=139
> > 	export kernel='/pkg/linux/x86_64-randconfig-a0-07211320/gcc-7/3398b55446fb602245007d5955b6778fb6ff326a/vmlinuz-4.18.0-rc5-00173-g3398b55'
> > 	export dequeue_time='2018-07-23 17:19:15 +0800'
> > 	export job_initrd='/lkp/scheduled/vm-ivb41-quantal-x86_64-23/boot-1-quantal-core-x86_64.cgz-3398b55446fb602245007d5955b6778fb6ff326a-20180723-3091-qqfgj0-0.cgz'
> > 
> > 	[ -n "$LKP_SRC" ] ||
> > 	export LKP_SRC=/lkp/${user:-lkp}/src
> > }
> > 
> > run_job()
> > {
> > 	echo $$ > $TMP/run-job.pid
> > 
> > 	. $LKP_SRC/lib/http.sh
> > 	. $LKP_SRC/lib/job.sh
> > 	. $LKP_SRC/lib/env.sh
> > 
> > 	export_top_env
> > 
> > 	run_monitor $LKP_SRC/monitors/one-shot/wrapper boot-slabinfo
> > 	run_monitor $LKP_SRC/monitors/one-shot/wrapper boot-meminfo
> > 	run_monitor $LKP_SRC/monitors/one-shot/wrapper memmap
> > 	run_monitor $LKP_SRC/monitors/no-stdout/wrapper boot-time
> > 	run_monitor $LKP_SRC/monitors/wrapper kmsg
> > 	run_monitor $LKP_SRC/monitors/wrapper oom-killer
> > 	run_monitor $LKP_SRC/monitors/plain/watchdog
> > 
> > 	run_test $LKP_SRC/tests/wrapper sleep 1
> > }
> > 
> > extract_stats()
> > {
> > 	$LKP_SRC/stats/wrapper boot-slabinfo
> > 	$LKP_SRC/stats/wrapper boot-meminfo
> > 	$LKP_SRC/stats/wrapper memmap
> > 	$LKP_SRC/stats/wrapper boot-memory
> > 	$LKP_SRC/stats/wrapper boot-time
> > 	$LKP_SRC/stats/wrapper kernel-size
> > 	$LKP_SRC/stats/wrapper kmsg
> > 
> > 	$LKP_SRC/stats/wrapper time sleep.time
> > 	$LKP_SRC/stats/wrapper time
> > 	$LKP_SRC/stats/wrapper dmesg
> > 	$LKP_SRC/stats/wrapper kmsg
> > 	$LKP_SRC/stats/wrapper stderr
> > 	$LKP_SRC/stats/wrapper last_state
> > }
> > 
> > "$@"
> 
> 

