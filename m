Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DC5C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 00:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23DF1208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 00:49:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23DF1208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbeHTECS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 00:02:18 -0400
Received: from mga04.intel.com ([192.55.52.120]:10543 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725743AbeHTECS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 00:02:18 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Aug 2018 17:48:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,263,1531810800"; 
   d="gz'50?scan'50,208,50";a="64403620"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.4])
  by fmsmga008.fm.intel.com with ESMTP; 19 Aug 2018 17:48:49 -0700
Date:   Mon, 20 Aug 2018 08:49:22 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        linux-kernel@vger.kernel.org, LKP <lkp@01.org>
Subject: [LKP] 02a5c550b2 BUG: kernel reboot-without-warning in test stage
Message-ID: <20180820004922.GA31827@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
User-Agent: Heirloom mailx 12.5 6/20/10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

commit 02a5c550b2738f2bfea8e1e00aa75944d71c9e18
Author:     Paul E. McKenney <paulmck@linux.vnet.ibm.com>
AuthorDate: Wed Nov 2 17:25:06 2016 -0700
Commit:     Paul E. McKenney <paulmck@linux.vnet.ibm.com>
CommitDate: Mon Jan 23 11:44:18 2017 -0800

    rcu: Abstract extended quiescent state determination
    
    This commit is the fourth step towards full abstraction of all accesses
    to the ->dynticks counter, implementing previously open-coded checks and
    comparisons in new rcu_dynticks_in_eqs() and rcu_dynticks_in_eqs_since()
    functions.  This abstraction will ease changes to the ->dynticks counter
    operation.
    
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
    Reviewed-by: Josh Triplett <josh@joshtriplett.org>

2625d469ba  rcu: Abstract dynticks extended quiescent state enter/exit operations
02a5c550b2  rcu: Abstract extended quiescent state determination
307797159a  pcmcia: remove long deprecated pcmcia_request_exclusive_irq() function
d7857ae43d  Add linux-next specific files for 20180817
+------------------------------------------------------------------+------------+------------+------------+---------------+
|                                                                  | 2625d469ba | 02a5c550b2 | 307797159a | next-20180817 |
+------------------------------------------------------------------+------------+------------+------------+---------------+
| boot_successes                                                   | 1097       | 496        | 85         | 574           |
| boot_failures                                                    | 1          | 15         | 18         | 21            |
| WARNING:at_mm/page_alloc.c:#__alloc_pages_nodemask               | 1          |            |            |               |
| BUG:kernel_reboot-without-warning_in_test_stage                  | 0          | 14         | 2          | 4             |
| Mem-Info                                                         | 0          | 1          | 16         | 16            |
| invoked_oom-killer:gfp_mask=0x                                   | 0          | 0          | 16         | 16            |
| Kernel_panic-not_syncing:Out_of_memory_and_no_killable_processes | 0          | 0          | 16         | 16            |
| BUG:kernel_hang_in_test_stage                                    | 0          | 0          | 0          | 1             |
+------------------------------------------------------------------+------------+------------+------------+---------------+

[main] Setsockopt(107 d 68b000 10) on fd 377 [17:3:768]
[main] Setsockopt(1 29 68b000 e3) on fd 378 [1:2:1]
[main] Setsockopt(1 28 68b000 40) on fd 379 [2:1:6]
[main] Setsockopt(1 d 68b000 8) on fd 381 [1:5:1]
[main] 375 sockets created based on info from socket cachefile.
BUG: kernel reboot-without-warning in test stage


                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start v4.11 v4.10 --
git bisect  bad ce70df089143c49385b4f32f39d41fb50fbf6a7c  # 06:01  B    300    14    0  17  mm, gup: fix typo in gup_p4d_range()
git bisect  bad 94eae8034002401d71ae950106659e16add36e77  # 06:02  B    307     8    0  10  Merge tag 'platform-drivers-x86-v4.11-1' of git://git.infradead.org/linux-platform-drivers-x86
git bisect  bad 7bb033829ef3ecfc491c0ed0197966e8f197fbdc  # 06:02  B    309    13    0  14  Merge tag 'rodata-v4.11-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux
git bisect  bad f790bd9c8e826434ab6c326b225276ed0f73affe  # 06:02  B    312    16    0   3  Merge tag 'regulator-v4.11' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator
git bisect  bad 4cee9fe53e4d181b608c7758090ed492b45d6801  # 06:02  B    302     8    0   0  Merge branch 'x86-apic-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 575260e3f8f8ac72dc0c41a4a20190d1a5f2b887  # 06:02  G    317     0    0  15  Merge branch 'core-debugobjects-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect  bad 7f4eb0a6d5a76ee054acd7255c05b8d5ca31c5d9  # 06:02  B    303    10    0  14  Merge branch 'perf-core-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect  bad f7458a5d631df2ecdbfe4a606053aba19913cc41  # 06:02  B    303    11    0   3  Merge branch 'core-rcu-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 8dc79888a792f6c365c2a26903e49ff919e72488  # 06:03  G    310     0    0   0  rcu: Add lockdep checks to synchronous expedited primitives
git bisect good 7d025948e4982ee3fa741c0fa56385c8b4a7072d  # 06:03  G    317     0    0   4  torture: Enable DEBUG_OBJECTS_RCU_HEAD for Tiny RCU
git bisect  bad 38d30b336ccf8ee98e0e494a13738a0fade5a5e6  # 06:03  B    309     9    0   3  rcu: Adjust FQS offline checks for exact online-CPU detection
git bisect good 2625d469baeef3aabdfe122572e00c517e2d9451  # 06:03  G    933     0    0  13  rcu: Abstract dynticks extended quiescent state enter/exit operations
git bisect  bad 3a19b46a5c17b12ef0691df19c676ba3da330a57  # 06:03  B    331    13    0  12  rcu: Check cond_resched_rcu_qs() state less often to reduce GP overhead
git bisect  bad 02a5c550b2738f2bfea8e1e00aa75944d71c9e18  # 06:03  B    331    14    0   9  rcu: Abstract extended quiescent state determination
# first bad commit: [02a5c550b2738f2bfea8e1e00aa75944d71c9e18] rcu: Abstract extended quiescent state determination
git bisect good 2625d469baeef3aabdfe122572e00c517e2d9451  # 06:03  G    933     0    0  13  rcu: Abstract dynticks extended quiescent state enter/exit operations
# extra tests on HEAD of linux-review/Bhaskar-Singh/staging-rtl8188eu-Removed-a-function-and-coded-inline/20180819-034357
git bisect  bad aecb9988cbfc07b01181e7e07feeb361db9c4ab9  # 06:04  B     56     2    0   0  staging: rtl8188eu: Removed a function and coded inline
# extra tests on tree/branch linus/master
git bisect  bad 307797159ac25fe5a2048bf5c6a5718298edca57  # 06:19  B     27     1    0  14  pcmcia: remove long deprecated pcmcia_request_exclusive_irq() function
# extra tests on tree/branch linux-next/master
git bisect  bad d7857ae43dcc4b23e61672d365c8094239d7bae4  # 06:20  B    325     4    0  24  Add linux-next specific files for 20180817

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/lkp                          Intel Corporation

--sm4nu43k4a2Rpi4c
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-quantal-ivb41-127:20180818124147:x86_64-kexec:4.10.0-rc3-00006-g02a5c550:1.gz"
Content-Transfer-Encoding: base64

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
Cg==

--sm4nu43k4a2Rpi4c
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-quantal-lkp-hsw01-48:20180818130212:x86_64-kexec:4.10.0-rc3-00005-g2625d46:1.gz"
Content-Transfer-Encoding: base64

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

--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reproduce-quantal-ivb41-127:20180818124147:x86_64-kexec:4.10.0-rc3-00006-g02a5c550:1"

#!/bin/bash

kernel=$1
initrd=quantal-core-x86_64.cgz

wget --no-clobber https://github.com/fengguang/reproduce-kernel-bug/raw/master/quantal/$initrd

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-cpu kvm64
	-kernel $kernel
	-initrd $initrd
	-m 512
	-smp 2
	-device e1000,netdev=net0
	-netdev user,id=net0
	-boot order=nc
	-no-reboot
	-watchdog i6300esb
	-watchdog-action debug
	-rtc base=localtime
	-serial stdio
	-display none
	-monitor null
)

append=(
	root=/dev/ram0
	hung_task_panic=1
	debug
	apic=debug
	sysrq_always_enabled
	rcupdate.rcu_cpu_stall_timeout=100
	net.ifnames=0
	printk.devkmsg=on
	panic=-1
	softlockup_panic=1
	nmi_watchdog=panic
	oops=panic
	load_ramdisk=2
	prompt_ramdisk=0
	drbd.minor_count=8
	systemd.log_level=err
	ignore_loglevel
	console=tty0
	earlyprintk=ttyS0,115200
	console=ttyS0,115200
	vga=normal
	rw
	drbd.minor_count=8
	rcuperf.shutdown=0
)

"${kvm[@]}" -append "${append[*]}"

--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-4.10.0-rc3-00006-g02a5c550"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 4.10.0-rc3 Kernel Configuration
#
CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/x86_64_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DEBUG_RODATA=y
CONFIG_PGTABLE_LEVELS=4
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_CROSS_COMPILE=""
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_FHANDLE=y
CONFIG_USELIB=y
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y
CONFIG_AUDIT_WATCH=y
CONFIG_AUDIT_TREE=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
# CONFIG_IRQ_DOMAIN_DEBUG is not set
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
# CONFIG_NO_HZ_FULL is not set
# CONFIG_NO_HZ is not set
CONFIG_HIGH_RES_TIMERS=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
# CONFIG_TREE_RCU_TRACE is not set
# CONFIG_RCU_EXPEDITE_BOOT is not set
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_NMI_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_ARCH_SUPPORTS_INT128=y
# CONFIG_NUMA_BALANCING is not set
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_SWAP_ENABLED=y
CONFIG_BLK_CGROUP=y
CONFIG_DEBUG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
# CONFIG_CFS_BANDWIDTH is not set
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
CONFIG_CGROUP_BPF=y
CONFIG_CGROUP_DEBUG=y
CONFIG_CHECKPOINT_RESTORE=y
# CONFIG_NAMESPACES is not set
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
# CONFIG_RD_BZIP2 is not set
# CONFIG_RD_LZMA is not set
# CONFIG_RD_XZ is not set
# CONFIG_RD_LZO is not set
# CONFIG_RD_LZ4 is not set
CONFIG_INITRAMFS_COMPRESSION=".gz"
# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_SYSCTL_SYSCALL=y
CONFIG_POSIX_TIMERS=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_BPF_SYSCALL=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_USERFAULTFD=y
CONFIG_PCI_QUIRKS=y
# CONFIG_MEMBARRIER is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
CONFIG_COMPAT_BRK=y
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
# CONFIG_SLAB_FREELIST_RANDOM is not set
CONFIG_SLUB_CPU_PARTIAL=y
# CONFIG_SYSTEM_DATA_VERIFICATION is not set
# CONFIG_PROFILING is not set
CONFIG_TRACEPOINTS=y
CONFIG_KEXEC_CORE=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_KPROBES=y
# CONFIG_JUMP_LABEL is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
# CONFIG_UPROBES is not set
# CONFIG_HAVE_64BIT_ALIGNED_ACCESS is not set
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_DMA_API_DEBUG=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_GCC_PLUGINS=y
# CONFIG_GCC_PLUGINS is not set
CONFIG_HAVE_CC_STACKPROTECTOR=y
# CONFIG_CC_STACKPROTECTOR is not set
CONFIG_CC_STACKPROTECTOR_NONE=y
# CONFIG_CC_STACKPROTECTOR_REGULAR is not set
# CONFIG_CC_STACKPROTECTOR_STRONG is not set
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_HAVE_STACK_VALIDATION=y
# CONFIG_HAVE_ARCH_HASH is not set
# CONFIG_ISA_BUS_API is not set
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
# CONFIG_CPU_NO_EFFICIENT_FFS is not set
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
CONFIG_SLABINFO=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
# CONFIG_BLK_DEV_INTEGRITY is not set
# CONFIG_BLK_DEV_ZONED is not set
# CONFIG_BLK_DEV_THROTTLING is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
# CONFIG_BLK_WBT is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
# CONFIG_BSD_DISKLABEL is not set
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_LDM_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_KARMA_PARTITION is not set
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_DEADLINE=y
# CONFIG_IOSCHED_CFQ is not set
CONFIG_DEFAULT_DEADLINE=y
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="deadline"
CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_ASN1=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_FREEZER=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_FAST_FEATURE_TESTS=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
# CONFIG_INTEL_RDT_A is not set
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
# CONFIG_X86_UV is not set
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
# CONFIG_PARAVIRT_SPINLOCKS is not set
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
# CONFIG_KVM_DEBUG_FS is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
CONFIG_NO_BOOTMEM=y
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_PROCESSOR_SELECT=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_GART_IOMMU=y
# CONFIG_CALGARY_IOMMU is not set
CONFIG_SWIOTLB=y
CONFIG_IOMMU_HELPER=y
# CONFIG_MAXSMP is not set
CONFIG_NR_CPUS=512
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
CONFIG_X86_MCE=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m
CONFIG_X86_THERMAL_VECTOR=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
# CONFIG_PERF_EVENTS_INTEL_RAPL is not set
# CONFIG_PERF_EVENTS_INTEL_CSTATE is not set
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# CONFIG_VM86 is not set
CONFIG_X86_VSYSCALL_EMULATION=y
# CONFIG_I8K is not set
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_ARCH_PHYS_ADDR_T_64BIT=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_X86_DIRECT_GBPAGES=y
CONFIG_NUMA=y
CONFIG_AMD_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NODES_SPAN_OTHER_NODES=y
# CONFIG_NUMA_EMU is not set
CONFIG_NODES_SHIFT=6
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_MEMBLOCK=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_ARCH_DISCARD_MEMBLOCK=y
CONFIG_MEMORY_ISOLATION=y
# CONFIG_MOVABLE_NODE is not set
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
# CONFIG_CLEANCACHE is not set
# CONFIG_FRONTSWAP is not set
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=7
# CONFIG_MEM_SOFT_DIRTY is not set
# CONFIG_ZPOOL is not set
# CONFIG_ZBUD is not set
# CONFIG_ZSMALLOC is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT=y
# CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ZONE_DEVICE=y
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=y
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_INTEL_MPX=y
# CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
# CONFIG_KEXEC_FILE is not set
# CONFIG_CRASH_DUMP is not set
# CONFIG_KEXEC_JUMP is not set
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_PHYSICAL_ALIGN=0x1000000
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
CONFIG_COMPAT_VDSO=y
# CONFIG_LEGACY_VSYSCALL_NATIVE is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set
CONFIG_HAVE_LIVEPATCH=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_SUSPEND_SKIP_SYNC=y
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
# CONFIG_PM_TRACE_RTC is not set
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_PROCFS_POWER is not set
# CONFIG_ACPI_REV_OVERRIDE_POSSIBLE is not set
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
# CONFIG_ACPI_VIDEO is not set
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_IPMI is not set
CONFIG_ACPI_HOTPLUG_CPU=y
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_NUMA=y
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_TABLE_UPGRADE is not set
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_X86_PM_TIMER=y
CONFIG_ACPI_CONTAINER=y
# CONFIG_ACPI_HOTPLUG_MEMORY is not set
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_BGRT is not set
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NFIT=m
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
CONFIG_ACPI_APEI_ERST_DEBUG=y
# CONFIG_DPTF_POWER is not set
CONFIG_ACPI_EXTLOG=m
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_SFI is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
# CONFIG_CPU_FREQ_STAT_DETAILS is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
# CONFIG_CPU_FREQ_GOV_SCHEDUTIL is not set

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_ACPI_CPUFREQ is not set
CONFIG_X86_SPEEDSTEP_CENTRINO=y
# CONFIG_X86_P4_CLOCKMOD is not set

#
# shared options
#
# CONFIG_X86_SPEEDSTEP_LIB is not set

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is not set
# CONFIG_INTEL_IDLE is not set

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
CONFIG_PCIEPORTBUS=y
CONFIG_PCIEAER=y
# CONFIG_PCIE_ECRC is not set
# CONFIG_PCIEAER_INJECT is not set
CONFIG_PCIEASPM=y
# CONFIG_PCIEASPM_DEBUG is not set
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
# CONFIG_PCIE_DPC is not set
# CONFIG_PCIE_PTM is not set
CONFIG_PCI_BUS_ADDR_T_64BIT=y
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
# CONFIG_PCI_STUB is not set
CONFIG_HT_IRQ=y
CONFIG_PCI_ATS=y
CONFIG_PCI_IOV=y
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
# CONFIG_HOTPLUG_PCI is not set

#
# PCI host controller drivers
#
# CONFIG_PCIE_DW_PLAT is not set
# CONFIG_VMD is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set
# CONFIG_X86_SYSFB is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
CONFIG_BINFMT_SCRIPT=y
# CONFIG_HAVE_AOUT is not set
# CONFIG_BINFMT_MISC is not set
CONFIG_COREDUMP=y
CONFIG_IA32_EMULATION=y
# CONFIG_IA32_AOUT is not set
# CONFIG_X86_X32 is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_KEYS_COMPAT=y
CONFIG_X86_DEV_DMA_OPS=y
CONFIG_PMC_ATOM=y
CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_DIAG is not set
CONFIG_UNIX=y
# CONFIG_UNIX_DIAG is not set
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_XFRM_MIGRATE is not set
# CONFIG_XFRM_STATISTICS is not set
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=m
# CONFIG_IP_MROUTE is not set
# CONFIG_SYN_COOKIES is not set
CONFIG_NET_UDP_TUNNEL=m
CONFIG_NET_FOU=m
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_XFRM_TUNNEL is not set
# CONFIG_INET_TUNNEL is not set
# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
# CONFIG_INET_XFRM_MODE_TUNNEL is not set
# CONFIG_INET_XFRM_MODE_BEET is not set
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_INET_UDP_DIAG is not set
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
# CONFIG_IPV6 is not set
# CONFIG_NETWORK_SECMARK is not set
CONFIG_NET_PTP_CLASSIFY=y
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
# CONFIG_BRIDGE is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=y
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
CONFIG_SOCK_CGROUP_DATA=y
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
# CONFIG_BPF_JIT is not set
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_TCPPROBE is not set
# CONFIG_NET_DROP_MONITOR is not set
# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
# CONFIG_CAN_SLCAN is not set
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_LEDS is not set
# CONFIG_CAN_C_CAN is not set
# CONFIG_CAN_CC770 is not set
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_SJA1000 is not set
# CONFIG_CAN_SOFTING is not set

#
# CAN USB interfaces
#
# CONFIG_CAN_EMS_USB is not set
# CONFIG_CAN_ESD_USB2 is not set
# CONFIG_CAN_GS_USB is not set
# CONFIG_CAN_KVASER_USB is not set
# CONFIG_CAN_PEAK_USB is not set
# CONFIG_CAN_8DEV_USB is not set
# CONFIG_CAN_DEBUG_DEVICES is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
# CONFIG_STREAM_PARSER is not set
CONFIG_WIRELESS=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
# CONFIG_CFG80211_INTERNAL_REGDB is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
# CONFIG_LIB80211 is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_MINSTREL_HT=y
# CONFIG_MAC80211_RC_MINSTREL_VHT is not set
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
CONFIG_MAC80211_MESH=y
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
# CONFIG_RFKILL is not set
# CONFIG_NET_9P is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
# CONFIG_NET_DEVLINK is not set
CONFIG_MAY_USE_DEVLINK=y
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_STANDALONE is not set
# CONFIG_PREVENT_FIRMWARE_BUILD is not set
CONFIG_FW_LOADER=y
CONFIG_FIRMWARE_IN_KERNEL=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
# CONFIG_SYS_HYPERVISOR is not set
# CONFIG_GENERIC_CPU_DEVICES is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_MMIO=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
CONFIG_DMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=200
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8

#
# Bus devices
#
CONFIG_CONNECTOR=m
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
# CONFIG_PARPORT is not set
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
CONFIG_BLK_DEV_CRYPTOLOOP=y
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SKD is not set
# CONFIG_BLK_DEV_OSD is not set
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=65536
# CONFIG_BLK_DEV_RAM_DAX is not set
# CONFIG_CDROM_PKTCDVD is not set
CONFIG_ATA_OVER_ETH=y
# CONFIG_BLK_DEV_HD is not set
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_RSXX is not set
CONFIG_NVME_CORE=m
# CONFIG_BLK_DEV_NVME is not set
# CONFIG_BLK_DEV_NVME_SCSI is not set
CONFIG_NVME_FABRICS=m
# CONFIG_NVME_FC is not set
CONFIG_NVME_TARGET=m
CONFIG_NVME_TARGET_LOOP=m
# CONFIG_NVME_TARGET_FC is not set

#
# Misc devices
#
# CONFIG_SENSORS_LIS3LV02D is not set
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_SGI_IOC4 is not set
# CONFIG_TIFM_CORE is not set
# CONFIG_ICS932S401 is not set
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_HP_ILO is not set
# CONFIG_APDS9802ALS is not set
# CONFIG_ISL29003 is not set
# CONFIG_ISL29020 is not set
# CONFIG_SENSORS_TSL2550 is not set
# CONFIG_SENSORS_BH1770 is not set
# CONFIG_SENSORS_APDS990X is not set
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
# CONFIG_USB_SWITCH_FSA9480 is not set
# CONFIG_SRAM is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_LEGACY is not set
# CONFIG_EEPROM_MAX6875 is not set
# CONFIG_EEPROM_93CX6 is not set
# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_SENSORS_LIS3_I2C is not set

#
# Altera FPGA firmware download module
#
# CONFIG_ALTERA_STAPL is not set
# CONFIG_INTEL_MEI is not set
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_VMWARE_VMCI is not set

#
# Intel MIC Bus Driver
#
# CONFIG_INTEL_MIC_BUS is not set

#
# SCIF Bus Driver
#
# CONFIG_SCIF_BUS is not set

#
# VOP Bus Driver
#
# CONFIG_VOP_BUS is not set

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#

#
# VOP Driver
#
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_CXL_BASE is not set
# CONFIG_CXL_AFU_DRIVER_OPS is not set
CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
# CONFIG_SCSI_MQ_DEFAULT is not set
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=m
CONFIG_CHR_DEV_OSST=m
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
CONFIG_SCSI_LOWLEVEL=y
CONFIG_ISCSI_TCP=m
CONFIG_ISCSI_BOOT_SYSFS=m
CONFIG_SCSI_CXGB3_ISCSI=m
CONFIG_SCSI_CXGB4_ISCSI=m
CONFIG_SCSI_BNX2_ISCSI=m
CONFIG_SCSI_BNX2X_FCOE=m
CONFIG_BE2ISCSI=m
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
CONFIG_SCSI_HPSA=m
CONFIG_SCSI_3W_9XXX=m
CONFIG_SCSI_3W_SAS=m
# CONFIG_SCSI_ACARD is not set
CONFIG_SCSI_AACRAID=m
# CONFIG_SCSI_AIC7XXX is not set
CONFIG_SCSI_AIC79XX=m
CONFIG_AIC79XX_CMDS_PER_DEVICE=4
CONFIG_AIC79XX_RESET_DELAY_MS=15000
# CONFIG_AIC79XX_BUILD_FIRMWARE is not set
# CONFIG_AIC79XX_DEBUG_ENABLE is not set
CONFIG_AIC79XX_DEBUG_MASK=0
# CONFIG_AIC79XX_REG_PRETTY_PRINT is not set
# CONFIG_SCSI_AIC94XX is not set
CONFIG_SCSI_MVSAS=m
# CONFIG_SCSI_MVSAS_DEBUG is not set
CONFIG_SCSI_MVSAS_TASKLET=y
CONFIG_SCSI_MVUMI=m
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
CONFIG_SCSI_ARCMSR=m
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
CONFIG_MEGARAID_SAS=m
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
CONFIG_SCSI_MPT2SAS=m
# CONFIG_SCSI_SMARTPQI is not set
CONFIG_SCSI_UFSHCD=m
CONFIG_SCSI_UFSHCD_PCI=m
# CONFIG_SCSI_UFS_DWC_TC_PCI is not set
# CONFIG_SCSI_UFSHCD_PLATFORM is not set
CONFIG_SCSI_HPTIOP=m
# CONFIG_SCSI_BUSLOGIC is not set
CONFIG_VMWARE_PVSCSI=m
CONFIG_LIBFC=m
CONFIG_LIBFCOE=m
CONFIG_FCOE=m
CONFIG_FCOE_FNIC=m
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
CONFIG_SCSI_INITIO=m
# CONFIG_SCSI_INIA100 is not set
CONFIG_SCSI_STEX=m
# CONFIG_SCSI_SYM53C8XX_2 is not set
CONFIG_SCSI_IPR=m
CONFIG_SCSI_IPR_TRACE=y
CONFIG_SCSI_IPR_DUMP=y
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA_FC=m
CONFIG_SCSI_QLA_ISCSI=m
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
CONFIG_SCSI_PMCRAID=m
CONFIG_SCSI_PM8001=m
# CONFIG_SCSI_BFA_FC is not set
CONFIG_SCSI_CHELSIO_FCOE=m
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
CONFIG_SCSI_OSD_INITIATOR=m
CONFIG_SCSI_OSD_ULD=m
CONFIG_SCSI_OSD_DPRINT_SENSE=1
# CONFIG_SCSI_OSD_DEBUG is not set
CONFIG_ATA=y
# CONFIG_ATA_NONSTANDARD is not set
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=y
CONFIG_SATA_AHCI_PLATFORM=y
# CONFIG_SATA_INIC162X is not set
CONFIG_SATA_ACARD_AHCI=m
CONFIG_SATA_SIL24=m
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
CONFIG_PDC_ADMA=m
CONFIG_SATA_QSTOR=m
CONFIG_SATA_SX4=m
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=y
CONFIG_SATA_MV=m
CONFIG_SATA_NV=m
CONFIG_SATA_PROMISE=m
CONFIG_SATA_SIL=m
CONFIG_SATA_SIS=m
CONFIG_SATA_SVW=m
CONFIG_SATA_ULI=m
CONFIG_SATA_VIA=m
CONFIG_SATA_VITESSE=m

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
CONFIG_PATA_SIS=m
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_PLATFORM is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
# CONFIG_DM_MQ_DEFAULT is not set
# CONFIG_DM_DEBUG is not set
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
CONFIG_DM_CACHE_CLEANER=m
# CONFIG_DM_ERA is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
CONFIG_DM_DELAY=m
# CONFIG_DM_UEVENT is not set
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
# CONFIG_TARGET_CORE is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
CONFIG_DUMMY=y
# CONFIG_EQUALIZER is not set
CONFIG_NET_FC=y
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_GTP is not set
CONFIG_MACSEC=y
CONFIG_NETCONSOLE=y
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=y
# CONFIG_NLMON is not set
# CONFIG_ARCNET is not set

#
# CAIF transport drivers
#

#
# Distributed Switch Architecture drivers
#
CONFIG_ETHERNET=y
CONFIG_MDIO=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=y
CONFIG_TYPHOON=y
CONFIG_NET_VENDOR_ADAPTEC=y
CONFIG_ADAPTEC_STARFIRE=y
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
CONFIG_ACENIC=y
# CONFIG_ACENIC_OMIT_TIGON_I is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
CONFIG_NET_VENDOR_AMD=y
CONFIG_AMD8111_ETH=y
CONFIG_PCNET32=y
# CONFIG_AMD_XGBE is not set
# CONFIG_AMD_XGBE_HAVE_ECC is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
CONFIG_ATL2=y
CONFIG_ATL1=y
CONFIG_ATL1E=y
CONFIG_ATL1C=y
# CONFIG_ALX is not set
# CONFIG_NET_VENDOR_AURORA is not set
CONFIG_NET_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_BROADCOM=y
CONFIG_B44=y
CONFIG_B44_PCI_AUTOSELECT=y
CONFIG_B44_PCICORE_AUTOSELECT=y
CONFIG_B44_PCI=y
# CONFIG_BCMGENET is not set
CONFIG_BNX2=y
CONFIG_CNIC=y
CONFIG_TIGON3=y
CONFIG_BNX2X=y
CONFIG_BNX2X_SRIOV=y
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
# CONFIG_NET_VENDOR_CAVIUM is not set
CONFIG_NET_VENDOR_CHELSIO=y
CONFIG_CHELSIO_T1=y
# CONFIG_CHELSIO_T1_1G is not set
CONFIG_CHELSIO_T3=y
CONFIG_CHELSIO_T4=y
# CONFIG_CHELSIO_T4VF is not set
CONFIG_CHELSIO_LIB=m
CONFIG_NET_VENDOR_CISCO=y
CONFIG_ENIC=y
# CONFIG_CX_ECAT is not set
CONFIG_DNET=y
CONFIG_NET_VENDOR_DEC=y
CONFIG_NET_TULIP=y
CONFIG_DE2104X=y
CONFIG_DE2104X_DSL=0
CONFIG_TULIP=y
# CONFIG_TULIP_MWI is not set
# CONFIG_TULIP_MMIO is not set
# CONFIG_TULIP_NAPI is not set
CONFIG_DE4X5=y
CONFIG_WINBOND_840=y
CONFIG_DM9102=y
CONFIG_ULI526X=y
CONFIG_NET_VENDOR_DLINK=y
CONFIG_DL2K=y
CONFIG_SUNDANCE=y
CONFIG_SUNDANCE_MMIO=y
CONFIG_NET_VENDOR_EMULEX=y
CONFIG_BE2NET=y
# CONFIG_BE2NET_HWMON is not set
# CONFIG_NET_VENDOR_EZCHIP is not set
CONFIG_NET_VENDOR_EXAR=y
CONFIG_S2IO=y
CONFIG_VXGE=y
# CONFIG_VXGE_DEBUG_TRACE_ALL is not set
CONFIG_NET_VENDOR_HP=y
CONFIG_HP100=y
CONFIG_NET_VENDOR_INTEL=y
CONFIG_E100=y
CONFIG_E1000=y
CONFIG_E1000E=y
# CONFIG_E1000E_HWTS is not set
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
CONFIG_IGBVF=y
CONFIG_IXGB=y
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
# CONFIG_IXGBEVF is not set
# CONFIG_I40E is not set
# CONFIG_I40EVF is not set
# CONFIG_FM10K is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_JME=y
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
CONFIG_SKGE=y
# CONFIG_SKGE_DEBUG is not set
# CONFIG_SKGE_GENESIS is not set
CONFIG_SKY2=y
# CONFIG_SKY2_DEBUG is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX4_CORE is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
CONFIG_NET_VENDOR_MICREL=y
CONFIG_KS8851_MLL=y
CONFIG_KSZ884X_PCI=y
CONFIG_NET_VENDOR_MYRI=y
CONFIG_MYRI10GE=y
CONFIG_FEALNX=y
CONFIG_NET_VENDOR_NATSEMI=y
CONFIG_NATSEMI=y
CONFIG_NS83820=y
# CONFIG_NET_VENDOR_NETRONOME is not set
CONFIG_NET_VENDOR_8390=y
CONFIG_NE2K_PCI=y
CONFIG_NET_VENDOR_NVIDIA=y
CONFIG_FORCEDETH=y
CONFIG_NET_VENDOR_OKI=y
CONFIG_ETHOC=y
# CONFIG_NET_PACKET_ENGINE is not set
CONFIG_NET_VENDOR_QLOGIC=y
CONFIG_QLA3XXX=y
CONFIG_QLCNIC=y
CONFIG_QLCNIC_SRIOV=y
CONFIG_QLCNIC_HWMON=y
CONFIG_QLGE=y
CONFIG_NETXEN_NIC=y
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
CONFIG_NET_VENDOR_REALTEK=y
CONFIG_8139CP=y
CONFIG_8139TOO=y
CONFIG_8139TOO_PIO=y
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
CONFIG_R8169=y
# CONFIG_NET_VENDOR_RENESAS is not set
CONFIG_NET_VENDOR_RDC=y
CONFIG_R6040=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SILAN=y
CONFIG_SC92031=y
CONFIG_NET_VENDOR_SIS=y
CONFIG_SIS900=y
CONFIG_SIS190=y
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SMSC=y
CONFIG_EPIC100=y
# CONFIG_SMSC911X is not set
CONFIG_SMSC9420=y
CONFIG_NET_VENDOR_STMICRO=y
CONFIG_STMMAC_ETH=y
CONFIG_STMMAC_PLATFORM=y
# CONFIG_DWMAC_GENERIC is not set
# CONFIG_STMMAC_PCI is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
CONFIG_NIU=y
# CONFIG_NET_VENDOR_SYNOPSYS is not set
CONFIG_NET_VENDOR_TEHUTI=y
CONFIG_TEHUTI=y
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_ALE is not set
CONFIG_TLAN=y
CONFIG_NET_VENDOR_VIA=y
CONFIG_VIA_RHINE=y
CONFIG_VIA_RHINE_MMIO=y
CONFIG_VIA_VELOCITY=y
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_PHYLIB=y
# CONFIG_LED_TRIGGER_PHY is not set

#
# MDIO bus device drivers
#
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_OCTEON is not set
# CONFIG_MDIO_THUNDER is not set

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_AT803X_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM87XX_PHY is not set
CONFIG_BCM_NET_PHYLIB=y
CONFIG_BROADCOM_PHY=y
CONFIG_CICADA_PHY=y
CONFIG_DAVICOM_PHY=y
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_FIXED_PHY is not set
CONFIG_ICPLUS_PHY=y
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
CONFIG_LXT_PHY=y
CONFIG_MARVELL_PHY=y
# CONFIG_MESON_GXL_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_NATIONAL_PHY is not set
CONFIG_QSEMI_PHY=y
# CONFIG_REALTEK_PHY is not set
CONFIG_SMSC_PHY=y
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
CONFIG_VITESSE_PHY=y
# CONFIG_XILINX_GMII2RGMII is not set
CONFIG_PPP=y
CONFIG_PPP_BSDCOMP=y
CONFIG_PPP_DEFLATE=y
# CONFIG_PPP_FILTER is not set
CONFIG_PPP_MPPE=y
CONFIG_PPP_MULTILINK=y
CONFIG_PPPOE=y
CONFIG_PPP_ASYNC=y
CONFIG_PPP_SYNC_TTY=y
CONFIG_SLIP=y
CONFIG_SLHC=y
# CONFIG_SLIP_COMPRESSED is not set
CONFIG_SLIP_SMART=y
CONFIG_SLIP_MODE_SLIP6=y
CONFIG_USB_NET_DRIVERS=y
CONFIG_USB_CATC=y
CONFIG_USB_KAWETH=y
CONFIG_USB_PEGASUS=y
CONFIG_USB_RTL8150=y
# CONFIG_USB_RTL8152 is not set
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=y
CONFIG_USB_NET_CDCETHER=y
CONFIG_USB_NET_CDC_EEM=y
CONFIG_USB_NET_CDC_NCM=y
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
# CONFIG_USB_NET_CDC_MBIM is not set
CONFIG_USB_NET_DM9601=y
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
CONFIG_USB_NET_SMSC75XX=y
CONFIG_USB_NET_SMSC95XX=y
CONFIG_USB_NET_GL620A=y
CONFIG_USB_NET_NET1080=y
CONFIG_USB_NET_PLUSB=y
CONFIG_USB_NET_MCS7830=y
CONFIG_USB_NET_RNDIS_HOST=y
CONFIG_USB_NET_CDC_SUBSET_ENABLE=y
CONFIG_USB_NET_CDC_SUBSET=y
CONFIG_USB_ALI_M5632=y
CONFIG_USB_AN2720=y
CONFIG_USB_BELKIN=y
CONFIG_USB_ARMLINUX=y
CONFIG_USB_EPSON2888=y
CONFIG_USB_KC2190=y
CONFIG_USB_NET_ZAURUS=y
CONFIG_USB_NET_CX82310_ETH=y
CONFIG_USB_NET_KALMIA=y
# CONFIG_USB_NET_QMI_WWAN is not set
CONFIG_USB_NET_INT51X1=y
CONFIG_USB_IPHETH=y
CONFIG_USB_SIERRA_NET=y
CONFIG_USB_VL600=y
# CONFIG_USB_NET_CH9200 is not set
CONFIG_WLAN=y
# CONFIG_WIRELESS_WDS is not set
# CONFIG_WLAN_VENDOR_ADMTEK is not set
# CONFIG_WLAN_VENDOR_ATH is not set
# CONFIG_WLAN_VENDOR_ATMEL is not set
# CONFIG_WLAN_VENDOR_BROADCOM is not set
# CONFIG_WLAN_VENDOR_CISCO is not set
# CONFIG_WLAN_VENDOR_INTEL is not set
# CONFIG_WLAN_VENDOR_INTERSIL is not set
# CONFIG_WLAN_VENDOR_MARVELL is not set
# CONFIG_WLAN_VENDOR_MEDIATEK is not set
# CONFIG_WLAN_VENDOR_RALINK is not set
# CONFIG_WLAN_VENDOR_REALTEK is not set
# CONFIG_WLAN_VENDOR_RSI is not set
# CONFIG_WLAN_VENDOR_ST is not set
# CONFIG_WLAN_VENDOR_TI is not set
# CONFIG_WLAN_VENDOR_ZYDAS is not set
CONFIG_MAC80211_HWSIM=m
CONFIG_USB_NET_RNDIS_WLAN=m

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
# CONFIG_WAN is not set
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_ISDN is not set
# CONFIG_NVM is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_LEDS is not set
# CONFIG_INPUT_FF_MEMLESS is not set
CONFIG_INPUT_POLLDEV=y
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ADP5588=y
CONFIG_KEYBOARD_ADP5589=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_QT1070=y
CONFIG_KEYBOARD_QT2160=y
CONFIG_KEYBOARD_LKKBD=y
CONFIG_KEYBOARD_TCA6416=y
# CONFIG_KEYBOARD_TCA8418 is not set
CONFIG_KEYBOARD_LM8323=y
# CONFIG_KEYBOARD_LM8333 is not set
CONFIG_KEYBOARD_MAX7359=y
CONFIG_KEYBOARD_MCS=y
CONFIG_KEYBOARD_MPR121=y
CONFIG_KEYBOARD_NEWTON=y
CONFIG_KEYBOARD_OPENCORES=y
CONFIG_KEYBOARD_STOWAWAY=y
CONFIG_KEYBOARD_SUNKBD=y
CONFIG_KEYBOARD_XTKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
# CONFIG_MOUSE_PS2_BYD is not set
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
# CONFIG_MOUSE_PS2_ELANTECH is not set
# CONFIG_MOUSE_PS2_SENTELIC is not set
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
# CONFIG_MOUSE_PS2_VMMOUSE is not set
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
# CONFIG_MOUSE_CYAPA is not set
# CONFIG_MOUSE_ELAN_I2C is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_MOUSE_SYNAPTICS_I2C is not set
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_BMA150 is not set
# CONFIG_INPUT_E3X0_BUTTON is not set
# CONFIG_INPUT_PCSPKR is not set
# CONFIG_INPUT_MMA8450 is not set
# CONFIG_INPUT_MPU3050 is not set
# CONFIG_INPUT_APANEL is not set
# CONFIG_INPUT_ATLAS_BTNS is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
# CONFIG_INPUT_KXTJ9 is not set
# CONFIG_INPUT_POWERMATE is not set
# CONFIG_INPUT_YEALINK is not set
# CONFIG_INPUT_CM109 is not set
CONFIG_INPUT_UINPUT=y
# CONFIG_INPUT_PCF8574 is not set
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_IMS_PCU is not set
# CONFIG_INPUT_CMA3000 is not set
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
# CONFIG_INPUT_DRV2667_HAPTICS is not set
# CONFIG_RMI4_CORE is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_SERIO_ALTERA_PS2 is not set
# CONFIG_SERIO_PS2MULT is not set
# CONFIG_SERIO_ARC_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_NOZOMI=y
# CONFIG_N_GSM is not set
# CONFIG_TRACE_SINK is not set
CONFIG_DEVMEM=y
CONFIG_DEVKMEM=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_NR_UARTS=16
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
# CONFIG_SERIAL_8250_FSL is not set
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
# CONFIG_SERIAL_8250_MID is not set
# CONFIG_SERIAL_8250_MOXA is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_IPMI_HANDLER=m
# CONFIG_IPMI_PANIC_EVENT is not set
# CONFIG_IPMI_DEVICE_INTERFACE is not set
CONFIG_IPMI_SI=m
# CONFIG_IPMI_SSIF is not set
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
CONFIG_HW_RANDOM_INTEL=y
# CONFIG_HW_RANDOM_AMD is not set
CONFIG_HW_RANDOM_VIA=y
CONFIG_NVRAM=y
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set
CONFIG_DEVPORT=y
# CONFIG_XILLYBUS is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
# CONFIG_I2C_CHARDEV is not set
# CONFIG_I2C_MUX is not set
CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_ALGOBIT=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_ISMT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_PCA_PLATFORM is not set
# CONFIG_I2C_PXA_PCI is not set
# CONFIG_I2C_SIMTEC is not set
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
# CONFIG_I2C_STUB is not set
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_SPI is not set
# CONFIG_SPMI is not set
# CONFIG_HSI is not set

#
# PPS support
#
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
# CONFIG_PPS_CLIENT_LDISC is not set
# CONFIG_PPS_CLIENT_GPIO is not set

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# CONFIG_GPIOLIB is not set
# CONFIG_W1 is not set
# CONFIG_POWER_AVS is not set
# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_PDA_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_SMB347 is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
CONFIG_HWMON=y
# CONFIG_HWMON_VID is not set
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
# CONFIG_SENSORS_ABITUGURU is not set
# CONFIG_SENSORS_ABITUGURU3 is not set
# CONFIG_SENSORS_AD7414 is not set
# CONFIG_SENSORS_AD7418 is not set
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1026 is not set
# CONFIG_SENSORS_ADM1029 is not set
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ADM9240 is not set
# CONFIG_SENSORS_ADT7410 is not set
# CONFIG_SENSORS_ADT7411 is not set
# CONFIG_SENSORS_ADT7462 is not set
# CONFIG_SENSORS_ADT7470 is not set
# CONFIG_SENSORS_ADT7475 is not set
# CONFIG_SENSORS_ASC7621 is not set
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
# CONFIG_SENSORS_FAM15H_POWER is not set
# CONFIG_SENSORS_APPLESMC is not set
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_ATXP1 is not set
# CONFIG_SENSORS_DS620 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_DELL_SMM is not set
# CONFIG_SENSORS_I5K_AMB is not set
# CONFIG_SENSORS_F71805F is not set
# CONFIG_SENSORS_F71882FG is not set
# CONFIG_SENSORS_F75375S is not set
# CONFIG_SENSORS_FSCHMD is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_GL520SM is not set
# CONFIG_SENSORS_G760A is not set
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
# CONFIG_SENSORS_IBMAEM is not set
# CONFIG_SENSORS_IBMPEX is not set
# CONFIG_SENSORS_I5500 is not set
# CONFIG_SENSORS_CORETEMP is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_JC42 is not set
# CONFIG_SENSORS_POWR1220 is not set
# CONFIG_SENSORS_LINEAGE is not set
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC4151 is not set
# CONFIG_SENSORS_LTC4215 is not set
# CONFIG_SENSORS_LTC4222 is not set
# CONFIG_SENSORS_LTC4245 is not set
# CONFIG_SENSORS_LTC4260 is not set
# CONFIG_SENSORS_LTC4261 is not set
# CONFIG_SENSORS_MAX16065 is not set
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_MAX1668 is not set
# CONFIG_SENSORS_MAX197 is not set
# CONFIG_SENSORS_MAX6639 is not set
# CONFIG_SENSORS_MAX6642 is not set
# CONFIG_SENSORS_MAX6650 is not set
# CONFIG_SENSORS_MAX6697 is not set
# CONFIG_SENSORS_MAX31790 is not set
# CONFIG_SENSORS_MCP3021 is not set
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_LM63 is not set
# CONFIG_SENSORS_LM73 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_LM92 is not set
# CONFIG_SENSORS_LM93 is not set
# CONFIG_SENSORS_LM95234 is not set
# CONFIG_SENSORS_LM95241 is not set
# CONFIG_SENSORS_LM95245 is not set
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_PC87427 is not set
# CONFIG_SENSORS_NTC_THERMISTOR is not set
# CONFIG_SENSORS_NCT6683 is not set
# CONFIG_SENSORS_NCT6775 is not set
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_PMBUS is not set
# CONFIG_SENSORS_SHT21 is not set
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHTC1 is not set
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_DME1737 is not set
# CONFIG_SENSORS_EMC1403 is not set
# CONFIG_SENSORS_EMC2103 is not set
# CONFIG_SENSORS_EMC6W201 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47M192 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
# CONFIG_SENSORS_SCH56XX_COMMON is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
# CONFIG_SENSORS_ADS1015 is not set
# CONFIG_SENSORS_ADS7828 is not set
# CONFIG_SENSORS_AMC6821 is not set
# CONFIG_SENSORS_INA209 is not set
# CONFIG_SENSORS_INA2XX is not set
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
# CONFIG_SENSORS_THMC50 is not set
# CONFIG_SENSORS_TMP102 is not set
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
# CONFIG_SENSORS_TMP401 is not set
# CONFIG_SENSORS_TMP421 is not set
# CONFIG_SENSORS_VIA_CPUTEMP is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_VT1211 is not set
# CONFIG_SENSORS_VT8231 is not set
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83791D is not set
# CONFIG_SENSORS_W83792D is not set
# CONFIG_SENSORS_W83793 is not set
# CONFIG_SENSORS_W83795 is not set
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83L786NG is not set
# CONFIG_SENSORS_W83627HF is not set
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
# CONFIG_THERMAL_EMULATION is not set
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_PKG_TEMP_THERMAL=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
CONFIG_INTEL_PCH_THERMAL=m
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y

#
# Sonics Silicon Backplane
#
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
# CONFIG_SSB_B43_PCI_BRIDGE is not set
# CONFIG_SSB_SILENT is not set
# CONFIG_SSB_DEBUG is not set
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
CONFIG_SSB_DRIVER_PCICORE=y
CONFIG_BCMA_POSSIBLE=y

#
# Broadcom specific AMBA
#
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
# CONFIG_MFD_CORE is not set
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_CROS_EC is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RTSX_PCI is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RTSX_USB is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
# CONFIG_MFD_SM501 is not set
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SMSC is not set
# CONFIG_ABX500_CORE is not set
CONFIG_MFD_SYSCON=y
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TPS65217 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS65218 is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TMIO is not set
# CONFIG_MFD_VX855 is not set
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_REGULATOR is not set
# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
# CONFIG_DRM is not set

#
# ACP (Audio CoProcessor) Configuration
#

#
# Frame buffer Devices
#
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
# CONFIG_FB_DDC is not set
# CONFIG_FB_BOOT_VESA_SUPPORT is not set
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
# CONFIG_FB_SYS_FILLRECT is not set
# CONFIG_FB_SYS_COPYAREA is not set
# CONFIG_FB_SYS_IMAGEBLIT is not set
# CONFIG_FB_FOREIGN_ENDIAN is not set
# CONFIG_FB_SYS_FOPS is not set
# CONFIG_FB_SVGALIB is not set
# CONFIG_FB_MACMODES is not set
# CONFIG_FB_BACKLIGHT is not set
# CONFIG_FB_MODE_HELPERS is not set
# CONFIG_FB_TILEBLITTING is not set

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
# CONFIG_FB_VESA is not set
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_BROADSHEET is not set
# CONFIG_FB_AUO_K190X is not set
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SM712 is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_LCD_CLASS_DEVICE=y
# CONFIG_LCD_PLATFORM is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_GENERIC=y
# CONFIG_BACKLIGHT_APPLE is not set
# CONFIG_BACKLIGHT_PM8941_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3639 is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_VGASTATE is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_VGACON_SOFT_SCROLLBACK=y
CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=1024
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY is not set
# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
# CONFIG_LOGO is not set
CONFIG_SOUND=y
# CONFIG_SOUND_OSS_CORE is not set
CONFIG_SND=y
CONFIG_SND_PCM=y
CONFIG_SND_HWDEP=y
CONFIG_SND_RAWMIDI=y
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
# CONFIG_SND_SEQUENCER is not set
# CONFIG_SND_MIXER_OSS is not set
# CONFIG_SND_PCM_OSS is not set
# CONFIG_SND_PCM_TIMER is not set
# CONFIG_SND_HRTIMER is not set
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
CONFIG_SND_SUPPORT_OLD_API=y
# CONFIG_SND_PROC_FS is not set
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_DEBUG=y
CONFIG_SND_DEBUG_VERBOSE=y
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
# CONFIG_SND_RAWMIDI_SEQ is not set
# CONFIG_SND_OPL3_LIB_SEQ is not set
# CONFIG_SND_OPL4_LIB_SEQ is not set
# CONFIG_SND_SBAWE_SEQ is not set
# CONFIG_SND_EMU10K1_SEQ is not set
CONFIG_SND_MPU401_UART=y
CONFIG_SND_AC97_CODEC=y
CONFIG_SND_DRIVERS=y
# CONFIG_SND_PCSP is not set
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_ALOOP is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set
# CONFIG_SND_AC97_POWER_SAVE is not set
CONFIG_SND_PCI=y
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ASIHPI is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_OXYGEN is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CTXFI is not set
# CONFIG_SND_DARLA20 is not set
# CONFIG_SND_GINA20 is not set
# CONFIG_SND_LAYLA20 is not set
# CONFIG_SND_DARLA24 is not set
# CONFIG_SND_GINA24 is not set
# CONFIG_SND_LAYLA24 is not set
# CONFIG_SND_MONA is not set
# CONFIG_SND_MIA is not set
# CONFIG_SND_ECHO3G is not set
# CONFIG_SND_INDIGO is not set
# CONFIG_SND_INDIGOIO is not set
# CONFIG_SND_INDIGODJ is not set
# CONFIG_SND_INDIGOIOX is not set
# CONFIG_SND_INDIGODJX is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
CONFIG_SND_INTEL8X0=y
CONFIG_SND_INTEL8X0M=y
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_LOLA is not set
# CONFIG_SND_LX6464ES is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_PCXHR is not set
# CONFIG_SND_RIPTIDE is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_SE6X is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_TRIDENT is not set
CONFIG_SND_VIA82XX=y
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VIRTUOSO is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA=y
CONFIG_SND_HDA_INTEL=y
CONFIG_SND_HDA_HWDEP=y
CONFIG_SND_HDA_RECONFIG=y
CONFIG_SND_HDA_INPUT_BEEP=y
CONFIG_SND_HDA_INPUT_BEEP_MODE=1
CONFIG_SND_HDA_PATCH_LOADER=y
CONFIG_SND_HDA_CODEC_REALTEK=y
CONFIG_SND_HDA_CODEC_ANALOG=y
CONFIG_SND_HDA_CODEC_SIGMATEL=y
CONFIG_SND_HDA_CODEC_VIA=y
CONFIG_SND_HDA_CODEC_HDMI=y
CONFIG_SND_HDA_CODEC_CIRRUS=y
CONFIG_SND_HDA_CODEC_CONEXANT=y
CONFIG_SND_HDA_CODEC_CA0110=y
CONFIG_SND_HDA_CODEC_CA0132=y
# CONFIG_SND_HDA_CODEC_CA0132_DSP is not set
CONFIG_SND_HDA_CODEC_CMEDIA=y
CONFIG_SND_HDA_CODEC_SI3054=y
CONFIG_SND_HDA_GENERIC=y
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
CONFIG_SND_HDA_CORE=y
CONFIG_SND_HDA_PREALLOC_SIZE=64
CONFIG_SND_USB=y
# CONFIG_SND_USB_AUDIO is not set
# CONFIG_SND_USB_UA101 is not set
# CONFIG_SND_USB_USX2Y is not set
# CONFIG_SND_USB_CAIAQ is not set
# CONFIG_SND_USB_US122L is not set
# CONFIG_SND_USB_6FIRE is not set
# CONFIG_SND_USB_HIFACE is not set
# CONFIG_SND_BCD2000 is not set
# CONFIG_SND_USB_POD is not set
# CONFIG_SND_USB_PODHD is not set
# CONFIG_SND_USB_TONEPORT is not set
# CONFIG_SND_USB_VARIAX is not set
# CONFIG_SND_SOC is not set
# CONFIG_SOUND_PRIME is not set
CONFIG_AC97_BUS=y

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
CONFIG_HIDRAW=y
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
# CONFIG_HID_ACRUX is not set
# CONFIG_HID_APPLE is not set
# CONFIG_HID_APPLEIR is not set
# CONFIG_HID_AUREAL is not set
# CONFIG_HID_BELKIN is not set
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_CHERRY is not set
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_PRODIKEYS is not set
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CYPRESS is not set
# CONFIG_HID_DRAGONRISE is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELECOM is not set
# CONFIG_HID_ELO is not set
# CONFIG_HID_EZKEY is not set
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_GT683R is not set
# CONFIG_HID_KEYTOUCH is not set
# CONFIG_HID_KYE is not set
# CONFIG_HID_UCLOGIC is not set
# CONFIG_HID_WALTOP is not set
# CONFIG_HID_GYRATION is not set
# CONFIG_HID_ICADE is not set
# CONFIG_HID_TWINHAN is not set
# CONFIG_HID_KENSINGTON is not set
# CONFIG_HID_LCPOWER is not set
# CONFIG_HID_LED is not set
# CONFIG_HID_LENOVO is not set
# CONFIG_HID_LOGITECH is not set
# CONFIG_HID_MAGICMOUSE is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_MICROSOFT is not set
# CONFIG_HID_MONTEREY is not set
# CONFIG_HID_MULTITOUCH is not set
# CONFIG_HID_NTRIG is not set
# CONFIG_HID_ORTEK is not set
# CONFIG_HID_PANTHERLORD is not set
# CONFIG_HID_PENMOUNT is not set
# CONFIG_HID_PETALYNX is not set
# CONFIG_HID_PICOLCD is not set
# CONFIG_HID_PLANTRONICS is not set
# CONFIG_HID_PRIMAX is not set
# CONFIG_HID_ROCCAT is not set
# CONFIG_HID_SAITEK is not set
# CONFIG_HID_SAMSUNG is not set
# CONFIG_HID_SONY is not set
# CONFIG_HID_SPEEDLINK is not set
# CONFIG_HID_STEELSERIES is not set
# CONFIG_HID_SUNPLUS is not set
# CONFIG_HID_RMI is not set
# CONFIG_HID_GREENASIA is not set
# CONFIG_HID_SMARTJOYPLUS is not set
# CONFIG_HID_TIVO is not set
# CONFIG_HID_TOPSEED is not set
# CONFIG_HID_THINGM is not set
# CONFIG_HID_THRUSTMASTER is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_WACOM is not set
# CONFIG_HID_WIIMOTE is not set
# CONFIG_HID_XINMO is not set
# CONFIG_HID_ZEROPLUS is not set
# CONFIG_HID_ZYDACRON is not set
# CONFIG_HID_SENSOR_HUB is not set
# CONFIG_HID_ALPS is not set

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
CONFIG_USB_HIDDEV=y

#
# I2C HID support
#
# CONFIG_I2C_HID is not set

#
# Intel ISH HID support
#
# CONFIG_INTEL_ISH_HID is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
CONFIG_USB_DYNAMIC_MINORS=y
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_WHITELIST is not set
# CONFIG_USB_OTG_BLACKLIST_HUB is not set
# CONFIG_USB_LEDS_TRIGGER_USBPORT is not set
# CONFIG_USB_MON is not set
CONFIG_USB_WUSB=y
# CONFIG_USB_WUSB_CBAF is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
# CONFIG_USB_EHCI_TT_NEWSCHED is not set
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_ISP1362_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
CONFIG_USB_WHCI_HCD=y
CONFIG_USB_HWA_HCD=y
# CONFIG_USB_HCD_SSB is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=y
# CONFIG_USB_PRINTER is not set
CONFIG_USB_WDM=y
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=y
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_REALTEK=y
CONFIG_REALTEK_AUTOPM=y
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_USBAT=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y
CONFIG_USB_STORAGE_ALAUDA=y
CONFIG_USB_STORAGE_ONETOUCH=y
CONFIG_USB_STORAGE_KARMA=y
CONFIG_USB_STORAGE_CYPRESS_ATACB=y
CONFIG_USB_STORAGE_ENE_UB6250=y
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
# CONFIG_UCSI is not set

#
# USB Physical Layer drivers
#
# CONFIG_USB_PHY is not set
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_ISP1301 is not set
# CONFIG_USB_GADGET is not set
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
CONFIG_UWB=y
CONFIG_UWB_HWA=y
CONFIG_UWB_WHCI=y
CONFIG_UWB_I1480U=y
# CONFIG_MMC is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set

#
# LED drivers
#
# CONFIG_LEDS_LM3530 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_LP3944 is not set
# CONFIG_LEDS_LP5521 is not set
# CONFIG_LEDS_LP5523 is not set
# CONFIG_LEDS_LP5562 is not set
# CONFIG_LEDS_LP8501 is not set
# CONFIG_LEDS_LP8860 is not set
# CONFIG_LEDS_CLEVO_MAIL is not set
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_BD2802 is not set
# CONFIG_LEDS_INTEL_SS4200 is not set
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
# CONFIG_LEDS_MLXCPLD is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
# CONFIG_LEDS_TRIGGER_TIMER is not set
# CONFIG_LEDS_TRIGGER_ONESHOT is not set
# CONFIG_LEDS_TRIGGER_DISK is not set
# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
# CONFIG_LEDS_TRIGGER_CAMERA is not set
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
# CONFIG_EDAC is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
CONFIG_RTC_SYSTOHC=y
CONFIG_RTC_SYSTOHC_DEVICE="n"
# CONFIG_RTC_DEBUG is not set

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABX80X is not set
# CONFIG_RTC_DRV_DS1307 is not set
# CONFIG_RTC_DRV_DS1374 is not set
# CONFIG_RTC_DRV_DS1672 is not set
# CONFIG_RTC_DRV_MAX6900 is not set
# CONFIG_RTC_DRV_RS5C372 is not set
# CONFIG_RTC_DRV_ISL1208 is not set
# CONFIG_RTC_DRV_ISL12022 is not set
# CONFIG_RTC_DRV_X1205 is not set
# CONFIG_RTC_DRV_PCF8523 is not set
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF8563 is not set
# CONFIG_RTC_DRV_PCF8583 is not set
# CONFIG_RTC_DRV_M41T80 is not set
# CONFIG_RTC_DRV_BQ32K is not set
# CONFIG_RTC_DRV_S35390A is not set
# CONFIG_RTC_DRV_FM3130 is not set
# CONFIG_RTC_DRV_RX8010 is not set
# CONFIG_RTC_DRV_RX8581 is not set
# CONFIG_RTC_DRV_RX8025 is not set
# CONFIG_RTC_DRV_EM3027 is not set
# CONFIG_RTC_DRV_RV8803 is not set

#
# SPI RTC drivers
#
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
# CONFIG_RTC_DRV_DS3232 is not set
# CONFIG_RTC_DRV_PCF2127 is not set
# CONFIG_RTC_DRV_RV3029C2 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
# CONFIG_RTC_DRV_DS1286 is not set
# CONFIG_RTC_DRV_DS1511 is not set
# CONFIG_RTC_DRV_DS1553 is not set
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
# CONFIG_RTC_DRV_DS1742 is not set
# CONFIG_RTC_DRV_DS2404 is not set
# CONFIG_RTC_DRV_STK17TA8 is not set
# CONFIG_RTC_DRV_M48T86 is not set
# CONFIG_RTC_DRV_M48T35 is not set
# CONFIG_RTC_DRV_M48T59 is not set
# CONFIG_RTC_DRV_MSM6242 is not set
# CONFIG_RTC_DRV_BQ4802 is not set
# CONFIG_RTC_DRV_RP5C01 is not set
# CONFIG_RTC_DRV_V3020 is not set

#
# on-CPU RTC drivers
#

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_HID_SENSOR_TIME is not set
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
# CONFIG_AUXDISPLAY is not set
CONFIG_UIO=y
# CONFIG_UIO_CIF is not set
# CONFIG_UIO_PDRV_GENIRQ is not set
# CONFIG_UIO_DMEM_GENIRQ is not set
# CONFIG_UIO_AEC is not set
# CONFIG_UIO_SERCOS3 is not set
# CONFIG_UIO_PCI_GENERIC is not set
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
# CONFIG_VFIO is not set
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set

#
# Virtio drivers
#
# CONFIG_VIRTIO_PCI is not set
# CONFIG_VIRTIO_MMIO is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# CONFIG_STAGING is not set
# CONFIG_X86_PLATFORM_DEVICES is not set
# CONFIG_CHROME_PLATFORMS is not set

#
# Hardware Spinlock drivers
#

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# CONFIG_ATMEL_PIT is not set
# CONFIG_SH_TIMER_CMT is not set
# CONFIG_SH_TIMER_MTU2 is not set
# CONFIG_SH_TIMER_TMU is not set
# CONFIG_EM_TIMER_STI is not set
CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
CONFIG_IOMMU_IOVA=y
# CONFIG_AMD_IOMMU is not set
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
CONFIG_INTEL_IOMMU_DEFAULT_ON=y
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_IRQ_REMAP=y

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set

#
# Rpmsg drivers
#

#
# SOC (System On Chip) specific Drivers
#

#
# Broadcom SoC drivers
#
# CONFIG_SUNXI_SRAM is not set
# CONFIG_SOC_TI is not set
CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=m
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
# CONFIG_DEVFREQ_GOV_USERSPACE is not set
# CONFIG_DEVFREQ_GOV_PASSIVE is not set

#
# DEVFREQ Drivers
#
# CONFIG_PM_DEVFREQ_EVENT is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
# CONFIG_PWM is not set
CONFIG_ARM_GIC_MAX_NR=1
# CONFIG_IPACK_BUS is not set
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_ATH79 is not set
# CONFIG_RESET_BERLIN is not set
# CONFIG_RESET_LPC18XX is not set
# CONFIG_RESET_MESON is not set
# CONFIG_RESET_PISTACHIO is not set
# CONFIG_RESET_SOCFPGA is not set
# CONFIG_RESET_STM32 is not set
# CONFIG_RESET_SUNXI is not set
# CONFIG_TI_SYSCON_RESET is not set
# CONFIG_RESET_ZYNQ is not set
# CONFIG_RESET_TEGRA_BPMP is not set
# CONFIG_FMC is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_POWERCAP is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
CONFIG_RAS=y
# CONFIG_THUNDERBOLT is not set

#
# Android
#
# CONFIG_ANDROID is not set
CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_BLK=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_NR_DEV_DAX=32768
CONFIG_NVMEM=y
# CONFIG_STM is not set
# CONFIG_INTEL_TH is not set

#
# FPGA Configuration Support
#
# CONFIG_FPGA is not set

#
# Firmware Drivers
#
# CONFIG_ARM_SCPI_PROTOCOL is not set
# CONFIG_EDD is not set
CONFIG_FIRMWARE_MEMMAP=y
# CONFIG_DELL_RBU is not set
# CONFIG_DCDBAS is not set
CONFIG_DMIID=y
# CONFIG_DMI_SYSFS is not set
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT_FIND is not set
# CONFIG_FW_CFG_SYSFS is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
# CONFIG_EFI_VARS is not set
CONFIG_EFI_ESRT=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
# CONFIG_APPLE_PROPERTIES is not set
CONFIG_UEFI_CPER=y
# CONFIG_EFI_DEV_PATH_PARSER is not set

#
# Tegra firmware driver
#

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
# CONFIG_EXT4_USE_FOR_EXT2 is not set
# CONFIG_EXT4_FS_POSIX_ACL is not set
# CONFIG_EXT4_FS_SECURITY is not set
CONFIG_EXT4_ENCRYPTION=y
CONFIG_EXT4_FS_ENCRYPTION=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
# CONFIG_XFS_QUOTA is not set
# CONFIG_XFS_POSIX_ACL is not set
CONFIG_XFS_RT=y
CONFIG_XFS_DEBUG=y
# CONFIG_GFS2_FS is not set
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
CONFIG_BTRFS_FS_CHECK_INTEGRITY=y
CONFIG_BTRFS_FS_RUN_SANITY_TESTS=y
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_NILFS2_FS is not set
# CONFIG_F2FS_FS is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
# CONFIG_MANDATORY_FILE_LOCKING is not set
CONFIG_FS_ENCRYPTION=y
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
CONFIG_QUOTA=y
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=m
# CONFIG_QFMT_V1 is not set
# CONFIG_QFMT_V2 is not set
CONFIG_QUOTACTL=y
CONFIG_QUOTACTL_COMPAT=y
# CONFIG_AUTOFS4_FS is not set
CONFIG_FUSE_FS=m
# CONFIG_CUSE is not set
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
# CONFIG_FSCACHE is not set

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
# CONFIG_MSDOS_FS is not set
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=y
# CONFIG_SQUASHFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_ZLIB_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EXOFS_FS is not set
CONFIG_ORE=m
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=y
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=y
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_OBJLAYOUT=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
# CONFIG_NFSD_SCSILAYOUT is not set
# CONFIG_NFSD_FLEXFILELAYOUT is not set
# CONFIG_NFSD_FAULT_INJECTION is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=y
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=y
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=y
CONFIG_CIFS_STATS=y
CONFIG_CIFS_STATS2=y
# CONFIG_CIFS_WEAK_PW_HASH is not set
# CONFIG_CIFS_UPCALL is not set
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
# CONFIG_CIFS_ACL is not set
CONFIG_CIFS_DEBUG=y
CONFIG_CIFS_DEBUG2=y
# CONFIG_CIFS_DFS_UPCALL is not set
# CONFIG_CIFS_SMB2 is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
CONFIG_NLS_CODEPAGE_936=y
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_MAC_ROMAN is not set
# CONFIG_NLS_MAC_CELTIC is not set
# CONFIG_NLS_MAC_CENTEURO is not set
# CONFIG_NLS_MAC_CROATIAN is not set
# CONFIG_NLS_MAC_CYRILLIC is not set
# CONFIG_NLS_MAC_GAELIC is not set
# CONFIG_NLS_MAC_GREEK is not set
# CONFIG_NLS_MAC_ICELAND is not set
# CONFIG_NLS_MAC_INUIT is not set
# CONFIG_NLS_MAC_ROMANIAN is not set
# CONFIG_NLS_MAC_TURKISH is not set
CONFIG_NLS_UTF8=y
# CONFIG_DLM is not set

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_DYNAMIC_DEBUG is not set

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_ENABLE_WARN_DEPRECATED=y
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=2048
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_READABLE_ASM is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_PAGE_OWNER is not set
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
# CONFIG_DEBUG_SECTION_MISMATCH is not set
# CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
CONFIG_ARCH_WANT_FRAME_POINTERS=y
CONFIG_FRAME_POINTER=y
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
CONFIG_DEBUG_VM=y
# CONFIG_DEBUG_VM_VMACACHE is not set
# CONFIG_DEBUG_VM_RB is not set
# CONFIG_DEBUG_VM_PGFLAGS is not set
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
CONFIG_HAVE_ARCH_KMEMCHECK=y
CONFIG_HAVE_ARCH_KASAN=y
# CONFIG_KASAN is not set
CONFIG_ARCH_HAS_KCOV=y
# CONFIG_KCOV is not set
# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Lockups and Hangs
#
# CONFIG_LOCKUP_DETECTOR is not set
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
# CONFIG_SCHEDSTATS is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
# CONFIG_DEBUG_TIMEKEEPING is not set
# CONFIG_TIMER_STATS is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
CONFIG_STACKTRACE=y
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_PI_LIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
# CONFIG_PROVE_RCU is not set
# CONFIG_SPARSE_RCU_POINTER is not set
CONFIG_TORTURE_TEST=m
# CONFIG_RCU_PERF_TEST is not set
CONFIG_RCU_TORTURE_TEST=m
# CONFIG_RCU_TORTURE_TEST_SLOW_PREINIT is not set
# CONFIG_RCU_TORTURE_TEST_SLOW_INIT is not set
# CONFIG_RCU_TORTURE_TEST_SLOW_CLEANUP is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_NOTIFIER_ERROR_INJECTION=m
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
CONFIG_FAIL_MAKE_REQUEST=y
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_LATENCYTOP is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_SCHED_TRACER is not set
# CONFIG_HWLAT_TRACER is not set
# CONFIG_FTRACE_SYSCALLS is not set
# CONFIG_TRACER_SNAPSHOT is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_PROFILE_ALL_BRANCHES is not set
# CONFIG_STACK_TRACER is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
CONFIG_KPROBE_EVENT=y
# CONFIG_UPROBE_EVENT is not set
CONFIG_BPF_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
# CONFIG_FUNCTION_PROFILER is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_MMIOTRACE is not set
CONFIG_TRACING_MAP=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACEPOINT_BENCHMARK is not set
# CONFIG_RING_BUFFER_BENCHMARK is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_TRACE_ENUM_MAP_FILE is not set

#
# Runtime Testing
#
# CONFIG_LKDTM is not set
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_KSTRTOX is not set
CONFIG_TEST_PRINTF=m
CONFIG_TEST_BITMAP=m
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_DMA_API_DEBUG is not set
CONFIG_TEST_LKM=m
CONFIG_TEST_USER_COPY=m
CONFIG_TEST_BPF=m
CONFIG_TEST_FIRMWARE=m
# CONFIG_TEST_UDELAY is not set
CONFIG_MEMTEST=y
CONFIG_TEST_STATIC_KEYS=m
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_ARCH_WANTS_UBSAN_NO_NULL is not set
# CONFIG_UBSAN is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
# CONFIG_STRICT_DEVMEM is not set
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_EFI=y
# CONFIG_X86_PTDUMP_CORE is not set
# CONFIG_X86_PTDUMP is not set
# CONFIG_EFI_PGT_DUMP is not set
CONFIG_DEBUG_RODATA_TEST=y
# CONFIG_DEBUG_WX is not set
# CONFIG_DEBUG_SET_MODULE_RONX is not set
# CONFIG_DEBUG_NX_TEST is not set
CONFIG_DOUBLEFAULT=y
# CONFIG_DEBUG_TLBFLUSH is not set
# CONFIG_IOMMU_DEBUG is not set
# CONFIG_IOMMU_STRESS is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=0
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
# CONFIG_OPTIMIZE_INLINING is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_BIG_KEYS is not set
# CONFIG_ENCRYPTED_KEYS is not set
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
# CONFIG_SECURITY is not set
# CONFIG_SECURITYFS is not set
# CONFIG_INTEL_TXT is not set
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HAVE_ARCH_HARDENED_USERCOPY=y
# CONFIG_HARDENED_USERCOPY is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_DEFAULT_SECURITY=""
CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_RSA=y
# CONFIG_CRYPTO_DH is not set
# CONFIG_CRYPTO_ECDH is not set
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
# CONFIG_CRYPTO_PCRYPT is not set
CONFIG_CRYPTO_WORKQUEUE=y
# CONFIG_CRYPTO_CRYPTD is not set
# CONFIG_CRYPTO_MCRYPTD is not set
CONFIG_CRYPTO_AUTHENC=y
# CONFIG_CRYPTO_TEST is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_SEQIV=y
# CONFIG_CRYPTO_ECHAINIV is not set

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_LRW is not set
# CONFIG_CRYPTO_PCBC is not set
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_XCBC is not set
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
# CONFIG_CRYPTO_CRC32C_INTEL is not set
# CONFIG_CRYPTO_CRC32 is not set
# CONFIG_CRYPTO_CRC32_PCLMUL is not set
CONFIG_CRYPTO_CRCT10DIF=m
# CONFIG_CRYPTO_CRCT10DIF_PCLMUL is not set
CONFIG_CRYPTO_GHASH=y
# CONFIG_CRYPTO_POLY1305 is not set
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
# CONFIG_CRYPTO_RMD128 is not set
# CONFIG_CRYPTO_RMD160 is not set
# CONFIG_CRYPTO_RMD256 is not set
# CONFIG_CRYPTO_RMD320 is not set
CONFIG_CRYPTO_SHA1=y
# CONFIG_CRYPTO_SHA1_SSSE3 is not set
# CONFIG_CRYPTO_SHA256_SSSE3 is not set
# CONFIG_CRYPTO_SHA512_SSSE3 is not set
# CONFIG_CRYPTO_SHA1_MB is not set
# CONFIG_CRYPTO_SHA256_MB is not set
# CONFIG_CRYPTO_SHA512_MB is not set
CONFIG_CRYPTO_SHA256=y
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_SHA3 is not set
# CONFIG_CRYPTO_TGR192 is not set
# CONFIG_CRYPTO_WP512 is not set
# CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_X86_64 is not set
# CONFIG_CRYPTO_AES_NI_INTEL is not set
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_ARC4=y
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_BLOWFISH_X86_64 is not set
# CONFIG_CRYPTO_CAMELLIA is not set
# CONFIG_CRYPTO_CAMELLIA_X86_64 is not set
# CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64 is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST5_AVX_X86_64 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_CAST6_AVX_X86_64 is not set
CONFIG_CRYPTO_DES=y
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
# CONFIG_CRYPTO_FCRYPT is not set
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_SALSA20 is not set
# CONFIG_CRYPTO_SALSA20_X86_64 is not set
# CONFIG_CRYPTO_CHACHA20 is not set
# CONFIG_CRYPTO_CHACHA20_X86_64 is not set
# CONFIG_CRYPTO_SEED is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_SERPENT_SSE2_X86_64 is not set
# CONFIG_CRYPTO_SERPENT_AVX_X86_64 is not set
# CONFIG_CRYPTO_SERPENT_AVX2_X86_64 is not set
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_TWOFISH_X86_64 is not set
# CONFIG_CRYPTO_TWOFISH_X86_64_3WAY is not set
# CONFIG_CRYPTO_TWOFISH_AVX_X86_64 is not set

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
# CONFIG_CRYPTO_LZO is not set
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set

#
# Random Number Generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_HASH_INFO=y
# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS7_MESSAGE_PARSER=y

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
CONFIG_KVM_INTEL=m
# CONFIG_KVM_AMD is not set
# CONFIG_KVM_MMU_AUDIT is not set
# CONFIG_KVM_DEVICE_ASSIGNMENT is not set
CONFIG_VHOST_NET=m
CONFIG_VHOST=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set
CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_BITREVERSE=y
# CONFIG_HAVE_ARCH_BITREVERSE is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_GENERIC_IO=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=m
# CONFIG_CRC_ITU_T is not set
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=y
# CONFIG_CRC8 is not set
# CONFIG_AUDIT_ARCH_COMPAT_GENERIC is not set
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
# CONFIG_XZ_DEC is not set
# CONFIG_XZ_DEC_BCJ is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_RADIX_TREE_MULTIORDER=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
# CONFIG_CORDIC is not set
# CONFIG_DDR is not set
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
# CONFIG_SG_SPLIT is not set
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_MMIO_FLUSH=y
CONFIG_SBITMAP=y

--sm4nu43k4a2Rpi4c--
