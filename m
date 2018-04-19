Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752809AbeDSDO5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 23:14:57 -0400
Received: from mga17.intel.com ([192.55.52.151]:46121 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752245AbeDSDO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 23:14:56 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,467,1517904000";
   d="gz'50?scan'50,208,50";a="43005142"
Date: Thu, 19 Apr 2018 11:14:49 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
To: Paul Blakey <paulb@mellanox.com>
Cc: linux-kernel@vger.kernel.org, lkp@01.org, Thomas Graf <tgraf@suug.ch>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florian Westphal <fw@strlen.de>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: 499ac3b60f ("test_rhashtable: add test case for rhltable with
 duplicate objects"): WARNING: CPU: 0 PID: 1 at lib/debugobjects.c:328
 __debug_object_init
Message-ID: <20180419031449.gp3tw74rtvccyjki@wfg-t540p.sh.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="fng6jrty3tbvv7s7"
Content-Disposition: inline
In-Reply-To: <20180419030602.e6prycb2gw3agagn@wfg-t540p.sh.intel.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fng6jrty3tbvv7s7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master

commit 499ac3b60f657dae82055fc81c7b01e6242ac9bc
Author:     Paul Blakey <paulb@mellanox.com>
AuthorDate: Sun Mar 4 17:29:49 2018 +0200
Commit:     David S. Miller <davem@davemloft.net>
CommitDate: Wed Mar 7 10:44:03 2018 -0500

     test_rhashtable: add test case for rhltable with duplicate objects
     
     Tries to insert duplicates in the middle of bucket's chain:
     bucket 1:  [[val 21 (tid=1)]] -> [[ val 1 (tid=2),  val 1 (tid=0) ]]
     
     Reuses tid to distinguish the elements insertion order.
     
     Signed-off-by: Paul Blakey <paulb@mellanox.com>
     Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
     Signed-off-by: David S. Miller <davem@davemloft.net>

d3dcf8eb61  rhashtable: Fix rhlist duplicates insertion
499ac3b60f  test_rhashtable: add test case for rhltable with duplicate objects
+----------------------------------------------------+------------+------------+
|                                                    | d3dcf8eb61 | 499ac3b60f |
+----------------------------------------------------+------------+------------+
| boot_successes                                     | 28         | 0          |
| boot_failures                                      | 0          | 15         |
| WARNING:at_lib/debugobjects.c:#__debug_object_init | 0          | 15         |
| EIP:__debug_object_init                            | 0          | 15         |
| Mem-Info                                           | 0          | 2          |
+----------------------------------------------------+------------+------------+

[    9.724580]   Duration of test: 115289366 ns
[    9.736431] test if its possible to exceed max_size 8192: no, ok
[    9.737933] Average test time: 118138571
[    9.738694] test inserting duplicates
[    9.739384] ODEBUG: object is on stack, but not annotated
[    9.740024] WARNING: CPU: 0 PID: 1 at lib/debugobjects.c:328 __debug_object_init+0x17b/0x380
[    9.740024] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.16.0-rc4-00130-g499ac3b #1
[    9.740024] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[    9.740024] EIP: __debug_object_init+0x17b/0x380
[    9.740024] EFLAGS: 00210096 CPU: 0
[    9.740024] EAX: 0000002d EBX: c0023e3c ECX: c0080ae0 EDX: 00000000
[    9.740024] ESI: c2403d14 EDI: c2e99fa0 EBP: c2e99f9c ESP: c0023d90
[    9.740024]  DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
[    9.740024] CR0: 80050033 CR2: 00000000 CR3: 02828000 CR4: 00000690
[    9.740024] Call Trace:
[    9.740024]  ? kstrtos8_from_user+0x50/0x50
[    9.740024]  ? rhashtable_init+0x1ff/0x2d0
[    9.740024]  ? rhltable_init+0xf/0x20
[    9.740024]  ? test_insert_dup+0x38/0x430
[    9.740024]  ? __lock_acquire+0x47c/0x8a0
[    9.740024]  ? kstrtos8_from_user+0x50/0x50
[    9.740024]  ? jhash+0x120/0x120
[    9.740024]  ? my_hashfn+0x30/0x30
[    9.740024]  ? test_rht_init+0x2bd/0x55f
[    9.740024]  ? test_rhashtable+0x40f/0x40f
[    9.740024]  ? do_one_initcall+0x7c/0x120
[    9.740024]  ? kernel_init_freeable+0xcc/0x164
[    9.740024]  ? kernel_init_freeable+0xec/0x164
[    9.740024]  ? rest_init+0x110/0x110
[    9.740024]  ? kernel_init+0x5/0xe0
[    9.740024]  ? ret_from_fork+0x19/0x24
[    9.740024] Code: 00 39 d3 0f 83 32 01 00 00 83 7c 24 08 01 74 20 89 4c 24 08 68 14 3d 40 c2 83 c0 01 a3 cc a7 e3 c2 e8 7f 90 ab ff 5e 8b 4c 24 08 <0f> 0b 8d 76 00 8b 41 08 83 f8 03 74 48 72 36 83 f8 04 75 0c ba
[    9.740024] ---[ end trace 0df84646a6fe1676 ]---
[    9.763142] 

                                                           # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start f495aa00f6e9a7241096abc57c000cf2f98a2a40 661e50bc853209e41a5c14a290ca4decc43cbfd1 --
git bisect good 48d0d60ce4ae55c6e81020c638e4031faf8e8b92  # 04:31  G     11     0    0   0  Merge 'krzk/for-next' into devel-hourly-2018030913
git bisect good 1f5ca3de3b75425387c5fe59906a03e4fa6573ad  # 04:49  G     11     0    1   1  Merge 'anholt/for-next' into devel-hourly-2018030913
git bisect  bad 7e454c4a43319dd82b50bc7374dff990b51ee05b  # 05:04  B      0     1   14   0  Merge 'block/for-next' into devel-hourly-2018030913
git bisect  bad 223f4a9a8596ee7d6b4ca78605320f4eba725eb8  # 05:24  B      0     8   21   0  Merge 'jkirsher-net-queue/dev-queue' into devel-hourly-2018030913
git bisect good 3078ca90f959c821b41933bac8bacbf49cdaf624  # 05:50  G     10     0    5   5  Merge 'lpieralisi-pci/pci/rcar' into devel-hourly-2018030913
git bisect  bad 89036a2a9852f70dcec97d5962974fe806828382  # 06:04  B      0     7   20   0  Merge branch 'for-upstream' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
git bisect good 25b5cdfcce1b57971840505dfc78556bd12dea6d  # 06:19  G     11     0    5   5  dt-bindings: net: renesas-ravb: Make stream buffer optional
git bisect  bad 803fafbe0cd522fa6b9e41ca3b96cfb2e2a2222d  # 06:35  B      0     5   18   0  fsl/fman: avoid sleeping in atomic context while adding an address
git bisect  bad 499ac3b60f657dae82055fc81c7b01e6242ac9bc  # 06:53  B      0     2   15   0  test_rhashtable: add test case for rhltable with duplicate objects
git bisect good d3dcf8eb615537526bd42ff27a081d46d337816e  # 07:09  G     11     0    2   2  rhashtable: Fix rhlist duplicates insertion
# first bad commit: [499ac3b60f657dae82055fc81c7b01e6242ac9bc] test_rhashtable: add test case for rhltable with duplicate objects
git bisect good d3dcf8eb615537526bd42ff27a081d46d337816e  # 07:19  G     30     0    8  10  rhashtable: Fix rhlist duplicates insertion
# extra tests with debug options
git bisect  bad 499ac3b60f657dae82055fc81c7b01e6242ac9bc  # 07:35  B      0     5   18   0  test_rhashtable: add test case for rhltable with duplicate objects
# extra tests on HEAD of linux-devel/devel-hourly-2018030913
git bisect  bad f495aa00f6e9a7241096abc57c000cf2f98a2a40  # 07:40  B      0    57   73   0  0day head guard for 'devel-hourly-2018030913'
# extra tests on tree/branch linux-next/master
# extra tests with first bad commit reverted

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/lkp                          Intel Corporation

--fng6jrty3tbvv7s7
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-yocto-lkp-nhm-dp1-10:20180310065402:i386-randconfig-h1-03092329:4.16.0-rc4-00130-g499ac3b:1.gz"
Content-Transfer-Encoding: base64

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

--fng6jrty3tbvv7s7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reproduce-yocto-lkp-nhm-dp1-10:20180310065402:i386-randconfig-h1-03092329:4.16.0-rc4-00130-g499ac3b:1"

#!/bin/bash

kernel=$1
initrd=yocto-trinity-i386.cgz

wget --no-clobber https://github.com/fengguang/reproduce-kernel-bug/raw/master/yocto/$initrd

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-kernel $kernel
	-initrd $initrd
	-m 296
	-smp 1
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

--fng6jrty3tbvv7s7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-4.16.0-rc4-00130-g499ac3b"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 4.16.0-rc4 Kernel Configuration
#
# CONFIG_64BIT is not set
CONFIG_X86_32=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf32-i386"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/i386_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_BITS_MAX=16
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
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
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_X86_32_SMP=y
CONFIG_X86_32_LAZY_GS=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=2
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
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
CONFIG_KERNEL_LZ4=y
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
# CONFIG_SYSVIPC is not set
# CONFIG_POSIX_MQUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
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
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
# CONFIG_NO_HZ is not set
CONFIG_HIGH_RES_TIMERS=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
# CONFIG_TASKSTATS is not set
CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=32
CONFIG_RCU_FANOUT_LEAF=16
CONFIG_RCU_NOCB_CPU=y
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
# CONFIG_MEMCG_SWAP is not set
CONFIG_BLK_CGROUP=y
CONFIG_DEBUG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
# CONFIG_CFS_BANDWIDTH is not set
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
# CONFIG_CGROUP_RDMA is not set
# CONFIG_CGROUP_FREEZER is not set
# CONFIG_CGROUP_HUGETLB is not set
# CONFIG_CPUSETS is not set
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
CONFIG_CGROUP_PERF=y
# CONFIG_CGROUP_DEBUG is not set
# CONFIG_SOCK_CGROUP_DATA is not set
# CONFIG_NAMESPACES is not set
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
# CONFIG_RD_XZ is not set
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
# CONFIG_UID16 is not set
CONFIG_MULTIUSER=y
# CONFIG_SGETMASK_SYSCALL is not set
CONFIG_SYSFS_SYSCALL=y
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
# CONFIG_ELF_CORE is not set
CONFIG_PCSPKR_PLATFORM=y
# CONFIG_BASE_FULL is not set
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
# CONFIG_AIO is not set
CONFIG_ADVISE_SYSCALLS=y
# CONFIG_MEMBARRIER is not set
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
# CONFIG_KALLSYMS_ABSOLUTE_PERCPU is not set
CONFIG_KALLSYMS_BASE_RELATIVE=y
# CONFIG_BPF_SYSCALL is not set
# CONFIG_USERFAULTFD is not set
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y
CONFIG_PC104=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
CONFIG_DEBUG_PERF_USE_VMALLOC=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_COMPAT_BRK=y
# CONFIG_SLAB is not set
# CONFIG_SLUB is not set
CONFIG_SLOB=y
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SYSTEM_DATA_VERIFICATION is not set
CONFIG_PROFILING=y
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_OPROFILE=y
# CONFIG_OPROFILE_EVENT_MULTIPLEX is not set
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
# CONFIG_JUMP_LABEL is not set
# CONFIG_UPROBES is not set
# CONFIG_HAVE_64BIT_ALIGNED_ACCESS is not set
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_DMA_API_DEBUG=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_HAVE_GCC_PLUGINS=y
# CONFIG_GCC_PLUGINS is not set
CONFIG_HAVE_CC_STACKPROTECTOR=y
CONFIG_CC_STACKPROTECTOR_NONE=y
# CONFIG_CC_STACKPROTECTOR_REGULAR is not set
# CONFIG_CC_STACKPROTECTOR_STRONG is not set
# CONFIG_CC_STACKPROTECTOR_AUTO is not set
CONFIG_THIN_ARCHIVES=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_REL=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=8
CONFIG_HAVE_COPY_THREAD_TLS=y
# CONFIG_HAVE_ARCH_HASH is not set
# CONFIG_ISA_BUS_API is not set
CONFIG_CLONE_BACKWARDS=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_OLD_SIGACTION=y
# CONFIG_CPU_NO_EFFICIENT_FFS is not set
# CONFIG_HAVE_ARCH_VMAP_STACK is not set
# CONFIG_ARCH_OPTIONAL_KERNEL_RWX is not set
# CONFIG_ARCH_OPTIONAL_KERNEL_RWX_DEFAULT is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_PHYS_TO_DMA=y
CONFIG_ARCH_HAS_REFCOUNT=y
CONFIG_REFCOUNT_FULL=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
CONFIG_HAVE_GENERIC_DMA_COHERENT=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=1
# CONFIG_MODULES is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_LBDAF=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
CONFIG_BLK_CMDLINE_PARSER=y
CONFIG_BLK_WBT=y
# CONFIG_BLK_WBT_SQ is not set
CONFIG_BLK_WBT_MQ=y
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
CONFIG_ACORN_PARTITION=y
CONFIG_ACORN_PARTITION_CUMANA=y
CONFIG_ACORN_PARTITION_EESOX=y
# CONFIG_ACORN_PARTITION_ICS is not set
# CONFIG_ACORN_PARTITION_ADFS is not set
CONFIG_ACORN_PARTITION_POWERTEC=y
CONFIG_ACORN_PARTITION_RISCIX=y
CONFIG_AIX_PARTITION=y
CONFIG_OSF_PARTITION=y
# CONFIG_AMIGA_PARTITION is not set
CONFIG_ATARI_PARTITION=y
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_BSD_DISKLABEL is not set
# CONFIG_MINIX_SUBPARTITION is not set
CONFIG_SOLARIS_X86_PARTITION=y
# CONFIG_UNIXWARE_DISKLABEL is not set
CONFIG_LDM_PARTITION=y
CONFIG_LDM_DEBUG=y
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
# CONFIG_EFI_PARTITION is not set
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
# CONFIG_IOSCHED_DEADLINE is not set
# CONFIG_IOSCHED_CFQ is not set
CONFIG_DEFAULT_NOOP=y
CONFIG_DEFAULT_IOSCHED="noop"
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_FREEZER=y

#
# Processor type and features
#
# CONFIG_ZONE_DMA is not set
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_FAST_FEATURE_TESTS=y
CONFIG_X86_MPPARSE=y
CONFIG_GOLDFISH=y
# CONFIG_RETPOLINE is not set
CONFIG_INTEL_RDT=y
# CONFIG_X86_BIGSMP is not set
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_GOLDFISH is not set
CONFIG_X86_INTEL_MID=y
# CONFIG_X86_INTEL_QUARK is not set
CONFIG_X86_INTEL_LPSS=y
CONFIG_X86_AMD_PLATFORM_DEVICE=y
CONFIG_IOSF_MBI=y
CONFIG_IOSF_MBI_DEBUG=y
# CONFIG_X86_RDC321X is not set
# CONFIG_X86_32_NON_STANDARD is not set
CONFIG_X86_32_IRIS=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
# CONFIG_PARAVIRT_SPINLOCKS is not set
CONFIG_KVM_GUEST=y
# CONFIG_KVM_DEBUG_FS is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
CONFIG_NO_BOOTMEM=y
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
CONFIG_M686=y
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MELAN is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_MVIAC7 is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_X86_GENERIC=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_PPRO_FENCE=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=6
CONFIG_X86_DEBUGCTLMSR=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_CYRIX_32=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_TRANSMETA_32=y
CONFIG_CPU_SUP_UMC_32=y
CONFIG_HPET_TIMER=y
CONFIG_APB_TIMER=y
CONFIG_DMI=y
CONFIG_NR_CPUS_RANGE_BEGIN=2
CONFIG_NR_CPUS_RANGE_END=8
CONFIG_NR_CPUS_DEFAULT=8
CONFIG_NR_CPUS=8
# CONFIG_SCHED_SMT is not set
# CONFIG_SCHED_MC is not set
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
# CONFIG_X86_MCE is not set

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
CONFIG_PERF_EVENTS_AMD_POWER=y
# CONFIG_X86_LEGACY_VM86 is not set
# CONFIG_VM86 is not set
CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX32=y
CONFIG_TOSHIBA=y
# CONFIG_I8K is not set
# CONFIG_X86_REBOOTFIXUPS is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_VMSPLIT_3G=y
# CONFIG_VMSPLIT_3G_OPT is not set
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_2G_OPT is not set
# CONFIG_VMSPLIT_1G is not set
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_HIGHMEM=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_NEED_NODE_MEMMAP_SIZE=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
CONFIG_SELECT_MEMORY_MODEL=y
# CONFIG_FLATMEM_MANUAL is not set
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_HAVE_MEMBLOCK=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_HAVE_GENERIC_GUP=y
CONFIG_ARCH_DISCARD_MEMBLOCK=y
CONFIG_MEMORY_ISOLATION=y
# CONFIG_HAVE_BOOTMEM_INFO_NODE is not set
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
# CONFIG_PHYS_ADDR_T_64BIT is not set
# CONFIG_BOUNCE is not set
CONFIG_VIRT_TO_BUS=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
# CONFIG_ARCH_WANTS_THP_SWAP is not set
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
CONFIG_CLEANCACHE=y
CONFIG_FRONTSWAP=y
# CONFIG_CMA is not set
# CONFIG_ZSWAP is not set
# CONFIG_ZPOOL is not set
CONFIG_ZBUD=y
# CONFIG_ZSMALLOC is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
# CONFIG_IDLE_PAGE_TRACKING is not set
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_BENCHMARK is not set
# CONFIG_HIGHPTE is not set
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MATH_EMULATION=y
# CONFIG_MTRR is not set
CONFIG_ARCH_RANDOM=y
# CONFIG_X86_SMAP is not set
CONFIG_X86_INTEL_UMIP=y
CONFIG_EFI=y
CONFIG_EFI_STUB=y
# CONFIG_SECCOMP is not set
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_CRASH_DUMP=y
# CONFIG_KEXEC_JUMP is not set
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y

#
# Power management and ACPI options
#
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_SUSPEND_SKIP_SYNC=y
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
CONFIG_PM_AUTOSLEEP=y
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_PROCFS_POWER is not set
# CONFIG_ACPI_REV_OVERRIDE_POSSIBLE is not set
CONFIG_ACPI_EC_DEBUGFS=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=y
# CONFIG_ACPI_THERMAL is not set
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_DEBUG=y
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=y
# CONFIG_ACPI_HED is not set
CONFIG_ACPI_CUSTOM_METHOD=y
# CONFIG_ACPI_BGRT is not set
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
# CONFIG_ACPI_APEI_GHES is not set
# CONFIG_ACPI_APEI_PCIEAER is not set
# CONFIG_ACPI_APEI_EINJ is not set
CONFIG_ACPI_APEI_ERST_DEBUG=y
CONFIG_DPTF_POWER=y
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y
CONFIG_X86_APM_BOOT=y
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
# CONFIG_APM_CPU_IDLE is not set
CONFIG_APM_DISPLAY_BLANK=y
CONFIG_APM_ALLOW_INTS=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
# CONFIG_CPU_FREQ_STAT is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
# CONFIG_CPU_FREQ_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
# CONFIG_CPU_FREQ_GOV_SCHEDUTIL is not set

#
# CPU frequency scaling drivers
#
CONFIG_CPUFREQ_DT=y
CONFIG_CPUFREQ_DT_PLATDEV=y
CONFIG_X86_INTEL_PSTATE=y
CONFIG_X86_PCC_CPUFREQ=y
CONFIG_X86_ACPI_CPUFREQ=y
CONFIG_X86_ACPI_CPUFREQ_CPB=y
# CONFIG_X86_SFI_CPUFREQ is not set
CONFIG_X86_POWERNOW_K6=y
# CONFIG_X86_POWERNOW_K7 is not set
CONFIG_X86_POWERNOW_K8=y
# CONFIG_X86_AMD_FREQ_SENSITIVITY is not set
CONFIG_X86_GX_SUSPMOD=y
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_SPEEDSTEP_ICH=y
# CONFIG_X86_SPEEDSTEP_SMI is not set
CONFIG_X86_P4_CLOCKMOD=y
CONFIG_X86_CPUFREQ_NFORCE2=y
CONFIG_X86_LONGRUN=y
CONFIG_X86_LONGHAUL=y
# CONFIG_X86_E_POWERSAVER is not set

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=y
CONFIG_X86_SPEEDSTEP_RELAXED_CAP_CHECK=y

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
# CONFIG_CPU_IDLE_GOV_MENU is not set
# CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is not set
# CONFIG_INTEL_IDLE is not set

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
# CONFIG_PCI_GOOLPC is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_OLPC=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCI_CNB20LE_QUIRK=y
CONFIG_PCIEPORTBUS=y
# CONFIG_HOTPLUG_PCI_PCIE is not set
CONFIG_PCIEAER=y
# CONFIG_PCIE_ECRC is not set
CONFIG_PCIEAER_INJECT=y
# CONFIG_PCIEASPM is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
# CONFIG_PCIE_PTM is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
# CONFIG_PCI_STUB is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_COMPAQ=y
CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM=y
CONFIG_HOTPLUG_PCI_IBM=y
CONFIG_HOTPLUG_PCI_ACPI=y
# CONFIG_HOTPLUG_PCI_ACPI_IBM is not set
# CONFIG_HOTPLUG_PCI_CPCI is not set
# CONFIG_HOTPLUG_PCI_SHPC is not set

#
# Cadence PCIe controllers support
#
# CONFIG_PCIE_CADENCE_HOST is not set
# CONFIG_PCIE_CADENCE_EP is not set

#
# DesignWare PCI Core Support
#
CONFIG_PCIE_DW=y
CONFIG_PCIE_DW_HOST=y
CONFIG_PCIE_DW_PLAT=y

#
# PCI host controller drivers
#

#
# PCI Endpoint
#
CONFIG_PCI_ENDPOINT=y
CONFIG_PCI_ENDPOINT_CONFIGFS=y
CONFIG_PCI_EPF_TEST=y

#
# PCI switch controller drivers
#
CONFIG_PCI_SW_SWITCHTEC=y
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
CONFIG_SCx200=y
# CONFIG_SCx200HR_TIMER is not set
CONFIG_OLPC=y
# CONFIG_OLPC_XO15_SCI is not set
CONFIG_ALIX=y
# CONFIG_NET5501 is not set
# CONFIG_GEOS is not set
CONFIG_AMD_NB=y
CONFIG_PCCARD=y
CONFIG_PCMCIA=y
# CONFIG_PCMCIA_LOAD_CIS is not set
# CONFIG_CARDBUS is not set

#
# PC-card bridges
#
CONFIG_YENTA=y
# CONFIG_YENTA_O2 is not set
# CONFIG_YENTA_RICOH is not set
# CONFIG_YENTA_TI is not set
# CONFIG_YENTA_TOSHIBA is not set
# CONFIG_PD6729 is not set
CONFIG_I82092=y
CONFIG_PCCARD_NONSTATIC=y
CONFIG_RAPIDIO=y
# CONFIG_RAPIDIO_TSI721 is not set
CONFIG_RAPIDIO_DISC_TIMEOUT=30
CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS=y
CONFIG_RAPIDIO_DMA_ENGINE=y
# CONFIG_RAPIDIO_DEBUG is not set
CONFIG_RAPIDIO_ENUM_BASIC=y
# CONFIG_RAPIDIO_CHMAN is not set
CONFIG_RAPIDIO_MPORT_CDEV=y

#
# RapidIO Switch drivers
#
# CONFIG_RAPIDIO_TSI57X is not set
CONFIG_RAPIDIO_CPS_XX=y
# CONFIG_RAPIDIO_TSI568 is not set
# CONFIG_RAPIDIO_CPS_GEN2 is not set
# CONFIG_RAPIDIO_RXS_GEN3 is not set
CONFIG_X86_SYSFB=y

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_HAVE_AOUT=y
# CONFIG_BINFMT_AOUT is not set
# CONFIG_BINFMT_MISC is not set
CONFIG_COREDUMP=y
CONFIG_COMPAT_32=y
CONFIG_HAVE_ATOMIC_IOMAP=y
CONFIG_NET=y

#
# Networking options
#
# CONFIG_PACKET is not set
CONFIG_UNIX=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_TLS is not set
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_XFRM_MIGRATE is not set
# CONFIG_XFRM_STATISTICS is not set
# CONFIG_NET_KEY is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
# CONFIG_SYN_COOKIES is not set
# CONFIG_NET_IPVTI is not set
# CONFIG_NET_UDP_TUNNEL is not set
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_XFRM_TUNNEL is not set
CONFIG_INET_TUNNEL=y
CONFIG_INET_XFRM_MODE_TRANSPORT=y
CONFIG_INET_XFRM_MODE_TUNNEL=y
CONFIG_INET_XFRM_MODE_BEET=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_INET_UDP_DIAG is not set
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=y
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
# CONFIG_INET6_XFRM_TUNNEL is not set
# CONFIG_INET6_TUNNEL is not set
CONFIG_INET6_XFRM_MODE_TRANSPORT=y
CONFIG_INET6_XFRM_MODE_TUNNEL=y
CONFIG_INET6_XFRM_MODE_BEET=y
# CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
# CONFIG_IPV6_VTI is not set
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_IPV6_FOU is not set
# CONFIG_IPV6_FOU_TUNNEL is not set
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_NETLABEL is not set
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
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=y
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
# CONFIG_STREAM_PARSER is not set
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set
# CONFIG_LIB80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
# CONFIG_RFKILL is not set
# CONFIG_NET_9P is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
# CONFIG_LWTUNNEL is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
# CONFIG_NET_DEVLINK is not set
CONFIG_MAY_USE_DEVLINK=y

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_STANDALONE is not set
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_DEVRES=y
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_SYS_HYPERVISOR is not set
# CONFIG_GENERIC_CPU_DEVICES is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_W1=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set

#
# Bus devices
#
# CONFIG_SIMPLE_PM_BUS is not set
# CONFIG_CONNECTOR is not set
# CONFIG_MTD is not set
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
CONFIG_OF_PROMTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_NET=y
# CONFIG_OF_OVERLAY is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
# CONFIG_PARPORT_SERIAL is not set
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
CONFIG_PARPORT_PC_PCMCIA=y
# CONFIG_PARPORT_GSC is not set
CONFIG_PARPORT_AX88796=y
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_BLK_DEV_FD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_VIRTIO_BLK is not set
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=y
CONFIG_BLK_DEV_NVME=y
CONFIG_NVME_MULTIPATH=y
CONFIG_NVME_FABRICS=y
CONFIG_NVME_FC=y
# CONFIG_NVME_TARGET is not set

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
# CONFIG_AD525X_DPOT is not set
CONFIG_DUMMY_IRQ=y
CONFIG_IBM_ASM=y
CONFIG_PHANTOM=y
# CONFIG_INTEL_MID_PTI is not set
# CONFIG_SGI_IOC4 is not set
CONFIG_TIFM_CORE=y
# CONFIG_TIFM_7XX1 is not set
# CONFIG_ICS932S401 is not set
# CONFIG_ENCLOSURE_SERVICES is not set
CONFIG_HP_ILO=y
CONFIG_APDS9802ALS=y
# CONFIG_ISL29003 is not set
# CONFIG_ISL29020 is not set
CONFIG_SENSORS_TSL2550=y
CONFIG_SENSORS_BH1770=y
CONFIG_SENSORS_APDS990X=y
CONFIG_HMC6352=y
CONFIG_DS1682=y
# CONFIG_VMWARE_BALLOON is not set
CONFIG_PCH_PHUB=y
CONFIG_USB_SWITCH_FSA9480=y
CONFIG_SRAM=y
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_MISC_RTSX is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
CONFIG_EEPROM_LEGACY=y
# CONFIG_EEPROM_MAX6875 is not set
CONFIG_EEPROM_93CX6=y
# CONFIG_EEPROM_IDT_89HPESX is not set
CONFIG_CB710_CORE=y
CONFIG_CB710_DEBUG=y
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
CONFIG_SENSORS_LIS3_I2C=y
CONFIG_ALTERA_STAPL=y
CONFIG_INTEL_MEI=y
CONFIG_INTEL_MEI_ME=y
CONFIG_INTEL_MEI_TXE=y
CONFIG_VMWARE_VMCI=y

#
# Intel MIC & related support
#

#
# Intel MIC Bus Driver
#

#
# SCIF Bus Driver
#

#
# VOP Bus Driver
#

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
CONFIG_ECHO=y
# CONFIG_CXL_BASE is not set
# CONFIG_CXL_AFU_DRIVER_OPS is not set
# CONFIG_CXL_LIB is not set
# CONFIG_OCXL_BASE is not set
# CONFIG_MISC_RTSX_PCI is not set
CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
# CONFIG_SCSI_NETLINK is not set
CONFIG_SCSI_MQ_DEFAULT=y
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
CONFIG_CHR_DEV_OSST=y
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=y
CONFIG_CHR_DEV_SCH=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=y
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
CONFIG_SCSI_SAS_ATTRS=y
# CONFIG_SCSI_SAS_LIBSAS is not set
CONFIG_SCSI_SRP_ATTRS=y
# CONFIG_SCSI_LOWLEVEL is not set
# CONFIG_SCSI_LOWLEVEL_PCMCIA is not set
# CONFIG_SCSI_DH is not set
CONFIG_SCSI_OSD_INITIATOR=y
CONFIG_SCSI_OSD_ULD=y
CONFIG_SCSI_OSD_DPRINT_SENSE=1
CONFIG_SCSI_OSD_DEBUG=y
CONFIG_ATA=y
# CONFIG_ATA_NONSTANDARD is not set
# CONFIG_ATA_VERBOSE_ERROR is not set
# CONFIG_ATA_ACPI is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=y
CONFIG_SATA_MOBILE_LPM_POLICY=0
# CONFIG_SATA_AHCI_PLATFORM is not set
CONFIG_AHCI_CEVA=y
CONFIG_AHCI_QORIQ=y
# CONFIG_SATA_INIC162X is not set
CONFIG_SATA_ACARD_AHCI=y
CONFIG_SATA_SIL24=y
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
CONFIG_SATA_QSTOR=y
CONFIG_SATA_SX4=y
# CONFIG_ATA_BMDMA is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
CONFIG_PATA_MPIIX=y
CONFIG_PATA_NS87410=y
# CONFIG_PATA_OPTI is not set
CONFIG_PATA_PCMCIA=y
CONFIG_PATA_PLATFORM=y
# CONFIG_PATA_OF_PLATFORM is not set
CONFIG_PATA_RZ1000=y

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_LEGACY is not set
# CONFIG_MD is not set
# CONFIG_TARGET_CORE is not set
CONFIG_FUSION=y
CONFIG_FUSION_SPI=y
CONFIG_FUSION_SAS=y
CONFIG_FUSION_MAX_SGE=128
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LOGGING is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
CONFIG_FIREWIRE_NOSY=y
# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_RIONET is not set
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
# CONFIG_VIRTIO_NET is not set
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
# CONFIG_PCMCIA_3C574 is not set
# CONFIG_PCMCIA_3C589 is not set
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_PCNET32 is not set
# CONFIG_PCMCIA_NMCLAN is not set
# CONFIG_AMD_XGBE is not set
# CONFIG_AMD_XGBE_HAVE_ECC is not set
CONFIG_NET_VENDOR_AQUANTIA=y
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_NET_VENDOR_AURORA is not set
CONFIG_NET_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_CAVIUM=y
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_GEMINI_ETHERNET is not set
# CONFIG_CX_ECAT is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_EZCHIP=y
# CONFIG_EZCHIP_NPS_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_EXAR=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_FUJITSU=y
# CONFIG_PCMCIA_FMVJ18X is not set
CONFIG_NET_VENDOR_HP=y
# CONFIG_HP100 is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
# CONFIG_IXGBEVF is not set
# CONFIG_I40E is not set
# CONFIG_I40EVF is not set
# CONFIG_FM10K is not set
CONFIG_NET_VENDOR_I825XX=y
# CONFIG_JME is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_MVNETA_BM is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX4_CORE is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_PCMCIA_AXNET is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_PCMCIA_PCNET is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_PCH_GBE is not set
# CONFIG_ETHOC is not set
CONFIG_NET_PACKET_ENGINE=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_QLGE is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCA7000_UART is not set
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_R8169 is not set
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_PCMCIA_SMC91C92 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_ALE is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XIRCOM=y
# CONFIG_PCMCIA_XIRC2PS is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_MDIO_DEVICE is not set
# CONFIG_MDIO_BUS is not set
# CONFIG_PHYLIB is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Host-side USB support is needed for USB Network Adapter support
#
CONFIG_WLAN=y
# CONFIG_WIRELESS_WDS is not set
CONFIG_WLAN_VENDOR_ADMTEK=y
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_WLAN_VENDOR_ATMEL=y
CONFIG_WLAN_VENDOR_BROADCOM=y
CONFIG_WLAN_VENDOR_CISCO=y
CONFIG_WLAN_VENDOR_INTEL=y
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
CONFIG_WLAN_VENDOR_MEDIATEK=y
CONFIG_WLAN_VENDOR_RALINK=y
CONFIG_WLAN_VENDOR_REALTEK=y
CONFIG_WLAN_VENDOR_RSI=y
CONFIG_WLAN_VENDOR_ST=y
CONFIG_WLAN_VENDOR_TI=y
CONFIG_WLAN_VENDOR_ZYDAS=y
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_PCMCIA_RAYCS is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
# CONFIG_WAN is not set
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_THUNDERBOLT_NET is not set
# CONFIG_NETDEVSIM is not set
# CONFIG_ISDN is not set
# CONFIG_NVM is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_LEDS is not set
CONFIG_INPUT_FF_MEMLESS=y
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
CONFIG_INPUT_JOYDEV=y
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ADP5520=y
# CONFIG_KEYBOARD_ADP5588 is not set
CONFIG_KEYBOARD_ADP5589=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_QT1070=y
CONFIG_KEYBOARD_QT2160=y
CONFIG_KEYBOARD_DLINK_DIR685=y
CONFIG_KEYBOARD_LKKBD=y
CONFIG_KEYBOARD_GPIO=y
CONFIG_KEYBOARD_GPIO_POLLED=y
CONFIG_KEYBOARD_TCA6416=y
CONFIG_KEYBOARD_TCA8418=y
CONFIG_KEYBOARD_MATRIX=y
# CONFIG_KEYBOARD_LM8323 is not set
CONFIG_KEYBOARD_LM8333=y
CONFIG_KEYBOARD_MAX7359=y
# CONFIG_KEYBOARD_MCS is not set
CONFIG_KEYBOARD_MPR121=y
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_KEYBOARD_OPENCORES=y
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_GOLDFISH_EVENTS is not set
CONFIG_KEYBOARD_STOWAWAY=y
CONFIG_KEYBOARD_SUNKBD=y
CONFIG_KEYBOARD_STMPE=y
CONFIG_KEYBOARD_OMAP4=y
CONFIG_KEYBOARD_TM2_TOUCHKEY=y
CONFIG_KEYBOARD_XTKBD=y
CONFIG_KEYBOARD_CAP11XX=y
CONFIG_KEYBOARD_BCM=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
# CONFIG_MOUSE_PS2_LOGIPS2PP is not set
# CONFIG_MOUSE_PS2_SYNAPTICS is not set
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
# CONFIG_MOUSE_PS2_LIFEBOOK is not set
# CONFIG_MOUSE_PS2_TRACKPOINT is not set
# CONFIG_MOUSE_PS2_ELANTECH is not set
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_OLPC=y
CONFIG_MOUSE_PS2_FOCALTECH=y
# CONFIG_MOUSE_PS2_VMMOUSE is not set
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=y
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
# CONFIG_MOUSE_CYAPA is not set
CONFIG_MOUSE_ELAN_I2C=y
# CONFIG_MOUSE_ELAN_I2C_I2C is not set
# CONFIG_MOUSE_ELAN_I2C_SMBUS is not set
CONFIG_MOUSE_VSXXXAA=y
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=y
# CONFIG_MOUSE_SYNAPTICS_USB is not set
CONFIG_INPUT_JOYSTICK=y
# CONFIG_JOYSTICK_ANALOG is not set
# CONFIG_JOYSTICK_A3D is not set
CONFIG_JOYSTICK_ADI=y
CONFIG_JOYSTICK_COBRA=y
CONFIG_JOYSTICK_GF2K=y
# CONFIG_JOYSTICK_GRIP is not set
CONFIG_JOYSTICK_GRIP_MP=y
CONFIG_JOYSTICK_GUILLEMOT=y
CONFIG_JOYSTICK_INTERACT=y
CONFIG_JOYSTICK_SIDEWINDER=y
# CONFIG_JOYSTICK_TMDC is not set
# CONFIG_JOYSTICK_IFORCE is not set
CONFIG_JOYSTICK_WARRIOR=y
CONFIG_JOYSTICK_MAGELLAN=y
CONFIG_JOYSTICK_SPACEORB=y
CONFIG_JOYSTICK_SPACEBALL=y
CONFIG_JOYSTICK_STINGER=y
CONFIG_JOYSTICK_TWIDJOY=y
CONFIG_JOYSTICK_ZHENHUA=y
# CONFIG_JOYSTICK_DB9 is not set
# CONFIG_JOYSTICK_GAMECON is not set
# CONFIG_JOYSTICK_TURBOGRAFX is not set
CONFIG_JOYSTICK_AS5011=y
# CONFIG_JOYSTICK_JOYDUMP is not set
# CONFIG_JOYSTICK_XPAD is not set
# CONFIG_JOYSTICK_WALKERA0701 is not set
CONFIG_INPUT_TABLET=y
# CONFIG_TABLET_USB_ACECAD is not set
# CONFIG_TABLET_USB_AIPTEK is not set
# CONFIG_TABLET_USB_HANWANG is not set
# CONFIG_TABLET_USB_KBTAB is not set
# CONFIG_TABLET_USB_PEGASUS is not set
CONFIG_TABLET_SERIAL_WACOM4=y
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_AD714X=y
# CONFIG_INPUT_AD714X_I2C is not set
# CONFIG_INPUT_ATMEL_CAPTOUCH is not set
# CONFIG_INPUT_BMA150 is not set
CONFIG_INPUT_E3X0_BUTTON=y
CONFIG_INPUT_PCSPKR=y
CONFIG_INPUT_MAX8925_ONKEY=y
CONFIG_INPUT_MC13783_PWRBUTTON=y
CONFIG_INPUT_MMA8450=y
CONFIG_INPUT_APANEL=y
CONFIG_INPUT_GP2A=y
CONFIG_INPUT_GPIO_BEEPER=y
# CONFIG_INPUT_GPIO_DECODER is not set
# CONFIG_INPUT_WISTRON_BTNS is not set
# CONFIG_INPUT_ATLAS_BTNS is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
# CONFIG_INPUT_KXTJ9 is not set
# CONFIG_INPUT_POWERMATE is not set
# CONFIG_INPUT_YEALINK is not set
# CONFIG_INPUT_CM109 is not set
CONFIG_INPUT_REGULATOR_HAPTIC=y
CONFIG_INPUT_RETU_PWRBUTTON=y
CONFIG_INPUT_TPS65218_PWRBUTTON=y
CONFIG_INPUT_TWL6040_VIBRA=y
# CONFIG_INPUT_UINPUT is not set
CONFIG_INPUT_PALMAS_PWRBUTTON=y
CONFIG_INPUT_PCF50633_PMU=y
# CONFIG_INPUT_PCF8574 is not set
CONFIG_INPUT_RK805_PWRKEY=y
CONFIG_INPUT_GPIO_ROTARY_ENCODER=y
# CONFIG_INPUT_DA9052_ONKEY is not set
# CONFIG_INPUT_DA9055_ONKEY is not set
CONFIG_INPUT_DA9063_ONKEY=y
CONFIG_INPUT_ADXL34X=y
CONFIG_INPUT_ADXL34X_I2C=y
# CONFIG_INPUT_CMA3000 is not set
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
CONFIG_INPUT_SOC_BUTTON_ARRAY=y
CONFIG_INPUT_DRV260X_HAPTICS=y
# CONFIG_INPUT_DRV2665_HAPTICS is not set
CONFIG_INPUT_DRV2667_HAPTICS=y
CONFIG_RMI4_CORE=y
CONFIG_RMI4_I2C=y
CONFIG_RMI4_SMB=y
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
# CONFIG_RMI4_F55 is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=y
CONFIG_SERIO_PARKBD=y
CONFIG_SERIO_PCIPS2=y
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
CONFIG_SERIO_ALTERA_PS2=y
CONFIG_SERIO_PS2MULT=y
# CONFIG_SERIO_ARC_PS2 is not set
CONFIG_SERIO_APBPS2=y
CONFIG_SERIO_OLPC_APSP=y
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
CONFIG_GAMEPORT=y
# CONFIG_GAMEPORT_NS558 is not set
CONFIG_GAMEPORT_L4=y
CONFIG_GAMEPORT_EMU10K1=y
# CONFIG_GAMEPORT_FM801 is not set

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_NOZOMI is not set
# CONFIG_N_GSM is not set
# CONFIG_TRACE_SINK is not set
# CONFIG_GOLDFISH_TTY is not set
# CONFIG_DEVMEM is not set
# CONFIG_DEVKMEM is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
# CONFIG_SERIAL_8250_CS is not set
# CONFIG_SERIAL_8250_MEN_MCB is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_ASPEED_VUART is not set
# CONFIG_SERIAL_8250_FSL is not set
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_8250_MOXA is not set
# CONFIG_SERIAL_OF_PLATFORM is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_TIMBERDALE is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_PCH_UART is not set
# CONFIG_SERIAL_XILINX_PS_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
# CONFIG_SERIAL_MEN_Z135 is not set
CONFIG_SERIAL_DEV_BUS=y
CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=y
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=y
# CONFIG_VIRTIO_CONSOLE is not set
# CONFIG_IPMI_HANDLER is not set
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=y
# CONFIG_HW_RANDOM_INTEL is not set
# CONFIG_HW_RANDOM_AMD is not set
CONFIG_HW_RANDOM_GEODE=y
CONFIG_HW_RANDOM_VIA=y
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_NVRAM=y
# CONFIG_R3964 is not set
CONFIG_APPLICOM=y
# CONFIG_SONYPI is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
CONFIG_CARDMAN_4000=y
# CONFIG_CARDMAN_4040 is not set
CONFIG_SCR24X=y
# CONFIG_IPWIRELESS is not set
# CONFIG_MWAVE is not set
# CONFIG_SCx200_GPIO is not set
# CONFIG_PC8736x_GPIO is not set
CONFIG_NSC_GPIO=y
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=256
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_I2C_ATMEL is not set
CONFIG_TCG_TIS_I2C_INFINEON=y
CONFIG_TCG_TIS_I2C_NUVOTON=y
# CONFIG_TCG_NSC is not set
# CONFIG_TCG_ATMEL is not set
# CONFIG_TCG_INFINEON is not set
# CONFIG_TCG_CRB is not set
CONFIG_TCG_VTPM_PROXY=y
CONFIG_TCG_TIS_ST33ZP24=y
CONFIG_TCG_TIS_ST33ZP24_I2C=y
CONFIG_TELCLOCK=y
# CONFIG_DEVPORT is not set
CONFIG_XILLYBUS=y
CONFIG_XILLYBUS_PCIE=y
CONFIG_XILLYBUS_OF=y

#
# I2C support
#
CONFIG_I2C=y
# CONFIG_ACPI_I2C_OPREGION is not set
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_ARB_GPIO_CHALLENGE is not set
CONFIG_I2C_MUX_GPIO=y
CONFIG_I2C_MUX_GPMUX=y
CONFIG_I2C_MUX_LTC4306=y
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
CONFIG_I2C_MUX_PINCTRL=y
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_DEMUX_PINCTRL=y
CONFIG_I2C_MUX_MLXCPLD=y
# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=y
CONFIG_I2C_ALGOPCA=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
CONFIG_I2C_ALI15X3=y
CONFIG_I2C_AMD756=y
# CONFIG_I2C_AMD756_S4882 is not set
CONFIG_I2C_AMD8111=y
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=y
CONFIG_I2C_ISMT=y
CONFIG_I2C_PIIX4=y
CONFIG_I2C_NFORCE2=y
# CONFIG_I2C_NFORCE2_S4985 is not set
CONFIG_I2C_SIS5595=y
CONFIG_I2C_SIS630=y
CONFIG_I2C_SIS96X=y
CONFIG_I2C_VIA=y
CONFIG_I2C_VIAPRO=y

#
# ACPI drivers
#
CONFIG_I2C_SCMI=y

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=y
CONFIG_I2C_DESIGNWARE_CORE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=y
CONFIG_I2C_DESIGNWARE_SLAVE=y
CONFIG_I2C_DESIGNWARE_PCI=y
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
CONFIG_I2C_EG20T=y
# CONFIG_I2C_EMEV2 is not set
CONFIG_I2C_GPIO=y
CONFIG_I2C_GPIO_FAULT_INJECTOR=y
CONFIG_I2C_KEMPLD=y
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_PCA_PLATFORM is not set
CONFIG_I2C_PXA=y
CONFIG_I2C_PXA_PCI=y
CONFIG_I2C_RK3X=y
CONFIG_I2C_SIMTEC=y
CONFIG_I2C_XILINX=y

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_PARPORT is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_TAOS_EVM is not set

#
# Other I2C/SMBus bus drivers
#
# CONFIG_SCx200_ACB is not set
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=y
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_SPI is not set
CONFIG_SPMI=y
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set
# CONFIG_NTP_PPS is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
# CONFIG_PPS_CLIENT_LDISC is not set
# CONFIG_PPS_CLIENT_PARPORT is not set
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
# CONFIG_PTP_1588_CLOCK_PCH is not set
CONFIG_PTP_1588_CLOCK_KVM=y
CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
CONFIG_DEBUG_PINCTRL=y
# CONFIG_PINCTRL_AS3722 is not set
CONFIG_PINCTRL_AMD=y
CONFIG_PINCTRL_MCP23S08=y
# CONFIG_PINCTRL_SINGLE is not set
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_MAX77620=y
CONFIG_PINCTRL_PALMAS=y
# CONFIG_PINCTRL_RK805 is not set
CONFIG_PINCTRL_BAYTRAIL=y
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_MERRIFIELD is not set
CONFIG_PINCTRL_INTEL=y
CONFIG_PINCTRL_BROXTON=y
CONFIG_PINCTRL_CANNONLAKE=y
CONFIG_PINCTRL_CEDARFORK=y
CONFIG_PINCTRL_DENVERTON=y
CONFIG_PINCTRL_GEMINILAKE=y
# CONFIG_PINCTRL_LEWISBURG is not set
CONFIG_PINCTRL_SUNRISEPOINT=y
CONFIG_GPIOLIB=y
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
CONFIG_DEBUG_GPIO=y
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_74XX_MMIO is not set
CONFIG_GPIO_ALTERA=y
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_FTGPIO010 is not set
CONFIG_GPIO_GENERIC_PLATFORM=y
# CONFIG_GPIO_GRGPIO is not set
# CONFIG_GPIO_ICH is not set
CONFIG_GPIO_LYNXPOINT=y
CONFIG_GPIO_MB86S7X=y
CONFIG_GPIO_MENZ127=y
CONFIG_GPIO_MOCKUP=y
# CONFIG_GPIO_SYSCON is not set
# CONFIG_GPIO_VX855 is not set
CONFIG_GPIO_XILINX=y

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_F7188X=y
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
CONFIG_GPIO_SCH311X=y

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_ADNP is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
CONFIG_GPIO_PCA953X=y
CONFIG_GPIO_PCA953X_IRQ=y
# CONFIG_GPIO_PCF857X is not set
CONFIG_GPIO_TPIC2810=y

#
# MFD GPIO expanders
#
# CONFIG_GPIO_ADP5520 is not set
CONFIG_GPIO_BD9571MWV=y
# CONFIG_GPIO_CRYSTAL_COVE is not set
CONFIG_GPIO_DA9052=y
CONFIG_GPIO_DA9055=y
CONFIG_GPIO_JANZ_TTL=y
CONFIG_GPIO_KEMPLD=y
CONFIG_GPIO_LP3943=y
# CONFIG_GPIO_LP873X is not set
CONFIG_GPIO_MAX77620=y
CONFIG_GPIO_MSIC=y
CONFIG_GPIO_PALMAS=y
# CONFIG_GPIO_STMPE is not set
# CONFIG_GPIO_TIMBERDALE is not set
CONFIG_GPIO_TPS65086=y
# CONFIG_GPIO_TPS65218 is not set
# CONFIG_GPIO_TPS6586X is not set
CONFIG_GPIO_TPS65912=y
CONFIG_GPIO_TWL6040=y
CONFIG_GPIO_WHISKEY_COVE=y
# CONFIG_GPIO_WM8350 is not set
CONFIG_GPIO_WM8994=y

#
# PCI GPIO expanders
#
CONFIG_GPIO_AMD8111=y
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_INTEL_MID is not set
CONFIG_GPIO_MERRIFIELD=y
CONFIG_GPIO_ML_IOH=y
CONFIG_GPIO_PCH=y
CONFIG_GPIO_PCI_IDIO_16=y
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# CONFIG_GPIO_SODAVILLE is not set
CONFIG_W1=y

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_MATROX=y
# CONFIG_W1_MASTER_DS2482 is not set
CONFIG_W1_MASTER_DS1WM=y
CONFIG_W1_MASTER_GPIO=y

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
CONFIG_W1_SLAVE_SMEM=y
CONFIG_W1_SLAVE_DS2405=y
CONFIG_W1_SLAVE_DS2408=y
# CONFIG_W1_SLAVE_DS2408_READBACK is not set
CONFIG_W1_SLAVE_DS2413=y
CONFIG_W1_SLAVE_DS2406=y
CONFIG_W1_SLAVE_DS2423=y
CONFIG_W1_SLAVE_DS2805=y
# CONFIG_W1_SLAVE_DS2431 is not set
# CONFIG_W1_SLAVE_DS2433 is not set
# CONFIG_W1_SLAVE_DS2438 is not set
CONFIG_W1_SLAVE_DS2760=y
# CONFIG_W1_SLAVE_DS2780 is not set
CONFIG_W1_SLAVE_DS2781=y
# CONFIG_W1_SLAVE_DS28E04 is not set
CONFIG_W1_SLAVE_DS28E17=y
CONFIG_POWER_AVS=y
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_AS3722 is not set
# CONFIG_POWER_RESET_GPIO is not set
# CONFIG_POWER_RESET_GPIO_RESTART is not set
CONFIG_POWER_RESET_LTC2952=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_RESET_SYSCON=y
CONFIG_POWER_RESET_SYSCON_POWEROFF=y
# CONFIG_SYSCON_REBOOT_MODE is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_PDA_POWER is not set
# CONFIG_MAX8925_POWER is not set
CONFIG_WM8350_POWER=y
# CONFIG_TEST_POWER is not set
CONFIG_BATTERY_ACT8945A=y
CONFIG_BATTERY_DS2760=y
# CONFIG_BATTERY_DS2780 is not set
CONFIG_BATTERY_DS2781=y
CONFIG_BATTERY_DS2782=y
CONFIG_BATTERY_OLPC=y
CONFIG_BATTERY_SBS=y
CONFIG_CHARGER_SBS=y
CONFIG_MANAGER_SBS=y
# CONFIG_BATTERY_BQ27XXX is not set
CONFIG_BATTERY_DA9052=y
CONFIG_BATTERY_DA9150=y
# CONFIG_BATTERY_MAX17040 is not set
CONFIG_BATTERY_MAX17042=y
CONFIG_BATTERY_MAX1721X=y
CONFIG_CHARGER_PCF50633=y
# CONFIG_CHARGER_MAX8903 is not set
CONFIG_CHARGER_LP8727=y
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_MANAGER is not set
CONFIG_CHARGER_LTC3651=y
CONFIG_CHARGER_MAX14577=y
CONFIG_CHARGER_DETECTOR_MAX14656=y
CONFIG_CHARGER_MAX77693=y
# CONFIG_CHARGER_MAX8998 is not set
CONFIG_CHARGER_BQ2415X=y
CONFIG_CHARGER_BQ24190=y
CONFIG_CHARGER_BQ24257=y
CONFIG_CHARGER_BQ24735=y
CONFIG_CHARGER_BQ25890=y
# CONFIG_CHARGER_SMB347 is not set
# CONFIG_CHARGER_TPS65090 is not set
# CONFIG_CHARGER_TPS65217 is not set
CONFIG_BATTERY_GAUGE_LTC2941=y
CONFIG_BATTERY_GOLDFISH=y
# CONFIG_BATTERY_RT5033 is not set
# CONFIG_CHARGER_RT9455 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=y
# CONFIG_SENSORS_ABITUGURU3 is not set
CONFIG_SENSORS_AD7414=y
# CONFIG_SENSORS_AD7418 is not set
CONFIG_SENSORS_ADM1021=y
# CONFIG_SENSORS_ADM1025 is not set
CONFIG_SENSORS_ADM1026=y
CONFIG_SENSORS_ADM1029=y
CONFIG_SENSORS_ADM1031=y
# CONFIG_SENSORS_ADM9240 is not set
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7410=y
CONFIG_SENSORS_ADT7411=y
# CONFIG_SENSORS_ADT7462 is not set
CONFIG_SENSORS_ADT7470=y
# CONFIG_SENSORS_ADT7475 is not set
# CONFIG_SENSORS_ASC7621 is not set
CONFIG_SENSORS_K8TEMP=y
CONFIG_SENSORS_K10TEMP=y
CONFIG_SENSORS_FAM15H_POWER=y
CONFIG_SENSORS_APPLESMC=y
CONFIG_SENSORS_ASB100=y
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=y
# CONFIG_SENSORS_DS620 is not set
CONFIG_SENSORS_DS1621=y
CONFIG_SENSORS_DELL_SMM=y
# CONFIG_SENSORS_DA9052_ADC is not set
CONFIG_SENSORS_DA9055=y
# CONFIG_SENSORS_I5K_AMB is not set
CONFIG_SENSORS_F71805F=y
# CONFIG_SENSORS_F71882FG is not set
# CONFIG_SENSORS_F75375S is not set
CONFIG_SENSORS_MC13783_ADC=y
CONFIG_SENSORS_FSCHMD=y
CONFIG_SENSORS_FTSTEUTATES=y
CONFIG_SENSORS_GL518SM=y
# CONFIG_SENSORS_GL520SM is not set
CONFIG_SENSORS_G760A=y
CONFIG_SENSORS_G762=y
# CONFIG_SENSORS_GPIO_FAN is not set
CONFIG_SENSORS_HIH6130=y
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=y
# CONFIG_SENSORS_IT87 is not set
CONFIG_SENSORS_JC42=y
# CONFIG_SENSORS_POWR1220 is not set
# CONFIG_SENSORS_LINEAGE is not set
# CONFIG_SENSORS_LTC2945 is not set
CONFIG_SENSORS_LTC2990=y
CONFIG_SENSORS_LTC4151=y
CONFIG_SENSORS_LTC4215=y
CONFIG_SENSORS_LTC4222=y
CONFIG_SENSORS_LTC4245=y
# CONFIG_SENSORS_LTC4260 is not set
# CONFIG_SENSORS_LTC4261 is not set
CONFIG_SENSORS_MAX16065=y
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_MAX1668 is not set
CONFIG_SENSORS_MAX197=y
CONFIG_SENSORS_MAX6621=y
# CONFIG_SENSORS_MAX6639 is not set
CONFIG_SENSORS_MAX6642=y
CONFIG_SENSORS_MAX6650=y
# CONFIG_SENSORS_MAX6697 is not set
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=y
CONFIG_SENSORS_TC654=y
CONFIG_SENSORS_MENF21BMC_HWMON=y
CONFIG_SENSORS_LM63=y
# CONFIG_SENSORS_LM73 is not set
CONFIG_SENSORS_LM75=y
CONFIG_SENSORS_LM77=y
# CONFIG_SENSORS_LM78 is not set
CONFIG_SENSORS_LM80=y
# CONFIG_SENSORS_LM83 is not set
CONFIG_SENSORS_LM85=y
CONFIG_SENSORS_LM87=y
CONFIG_SENSORS_LM90=y
# CONFIG_SENSORS_LM92 is not set
# CONFIG_SENSORS_LM93 is not set
# CONFIG_SENSORS_LM95234 is not set
CONFIG_SENSORS_LM95241=y
CONFIG_SENSORS_LM95245=y
CONFIG_SENSORS_PC87360=y
# CONFIG_SENSORS_PC87427 is not set
CONFIG_SENSORS_NTC_THERMISTOR=y
CONFIG_SENSORS_NCT6683=y
CONFIG_SENSORS_NCT6775=y
CONFIG_SENSORS_NCT7802=y
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_PCF8591 is not set
CONFIG_PMBUS=y
CONFIG_SENSORS_PMBUS=y
CONFIG_SENSORS_ADM1275=y
CONFIG_SENSORS_IBM_CFFPS=y
CONFIG_SENSORS_IR35221=y
# CONFIG_SENSORS_LM25066 is not set
CONFIG_SENSORS_LTC2978=y
# CONFIG_SENSORS_LTC2978_REGULATOR is not set
CONFIG_SENSORS_LTC3815=y
CONFIG_SENSORS_MAX16064=y
CONFIG_SENSORS_MAX20751=y
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=y
# CONFIG_SENSORS_MAX8688 is not set
CONFIG_SENSORS_TPS40422=y
CONFIG_SENSORS_TPS53679=y
# CONFIG_SENSORS_UCD9000 is not set
CONFIG_SENSORS_UCD9200=y
CONFIG_SENSORS_ZL6100=y
CONFIG_SENSORS_SHT15=y
CONFIG_SENSORS_SHT21=y
CONFIG_SENSORS_SHT3x=y
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=y
# CONFIG_SENSORS_DME1737 is not set
CONFIG_SENSORS_EMC1403=y
CONFIG_SENSORS_EMC2103=y
# CONFIG_SENSORS_EMC6W201 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
CONFIG_SENSORS_SMSC47M192=y
CONFIG_SENSORS_SMSC47B397=y
CONFIG_SENSORS_SCH56XX_COMMON=y
CONFIG_SENSORS_SCH5627=y
# CONFIG_SENSORS_SCH5636 is not set
CONFIG_SENSORS_STTS751=y
# CONFIG_SENSORS_SMM665 is not set
CONFIG_SENSORS_ADC128D818=y
CONFIG_SENSORS_ADS1015=y
# CONFIG_SENSORS_ADS7828 is not set
# CONFIG_SENSORS_AMC6821 is not set
CONFIG_SENSORS_INA209=y
CONFIG_SENSORS_INA2XX=y
CONFIG_SENSORS_INA3221=y
CONFIG_SENSORS_TC74=y
# CONFIG_SENSORS_THMC50 is not set
# CONFIG_SENSORS_TMP102 is not set
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=y
CONFIG_SENSORS_TMP421=y
CONFIG_SENSORS_VIA_CPUTEMP=y
CONFIG_SENSORS_VIA686A=y
CONFIG_SENSORS_VT1211=y
CONFIG_SENSORS_VT8231=y
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=y
CONFIG_SENSORS_W83791D=y
# CONFIG_SENSORS_W83792D is not set
# CONFIG_SENSORS_W83793 is not set
CONFIG_SENSORS_W83795=y
CONFIG_SENSORS_W83795_FANCTRL=y
CONFIG_SENSORS_W83L785TS=y
CONFIG_SENSORS_W83L786NG=y
# CONFIG_SENSORS_W83627HF is not set
CONFIG_SENSORS_W83627EHF=y
CONFIG_SENSORS_WM8350=y

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
CONFIG_SENSORS_ATK0110=y
CONFIG_THERMAL=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_OF=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
CONFIG_CPU_THERMAL=y
# CONFIG_CLOCK_THERMAL is not set
CONFIG_DEVFREQ_THERMAL=y
# CONFIG_THERMAL_EMULATION is not set
CONFIG_MAX77620_THERMAL=y
CONFIG_QORIQ_THERMAL=y
CONFIG_DA9062_THERMAL=y
# CONFIG_INTEL_POWERCLAMP is not set
CONFIG_INTEL_SOC_DTS_IOSF_CORE=y
CONFIG_INTEL_SOC_DTS_THERMAL=y

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=y
CONFIG_ACPI_THERMAL_REL=y
CONFIG_INT3406_THERMAL=y
CONFIG_INTEL_BXT_PMIC_THERMAL=y
CONFIG_INTEL_PCH_THERMAL=y
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_SYSFS=y

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=y
CONFIG_DA9052_WATCHDOG=y
CONFIG_DA9055_WATCHDOG=y
# CONFIG_DA9063_WATCHDOG is not set
# CONFIG_DA9062_WATCHDOG is not set
CONFIG_GPIO_WATCHDOG=y
# CONFIG_GPIO_WATCHDOG_ARCH_INITCALL is not set
CONFIG_MENF21BMC_WATCHDOG=y
# CONFIG_WDAT_WDT is not set
# CONFIG_WM8350_WATCHDOG is not set
CONFIG_XILINX_WATCHDOG=y
CONFIG_ZIIRAVE_WATCHDOG=y
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_RN5T618_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_MAX77620_WATCHDOG is not set
CONFIG_RETU_WATCHDOG=y
CONFIG_ACQUIRE_WDT=y
CONFIG_ADVANTECH_WDT=y
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
CONFIG_F71808E_WDT=y
CONFIG_SP5100_TCO=y
CONFIG_SBC_FITPC2_WATCHDOG=y
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=y
# CONFIG_IBMASR is not set
CONFIG_WAFER_WDT=y
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=y
# CONFIG_INTEL_SCU_WATCHDOG is not set
# CONFIG_INTEL_MID_WATCHDOG is not set
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=y
CONFIG_IT87_WDT=y
CONFIG_HP_WATCHDOG=y
CONFIG_KEMPLD_WDT=y
# CONFIG_HPWDT_NMI_DECODING is not set
# CONFIG_SC1200_WDT is not set
# CONFIG_SCx200_WDT is not set
# CONFIG_PC87413_WDT is not set
# CONFIG_NV_TCO is not set
# CONFIG_60XX_WDT is not set
# CONFIG_SBC8360_WDT is not set
CONFIG_SBC7240_WDT=y
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=y
# CONFIG_SMSC37B787_WDT is not set
CONFIG_VIA_WDT=y
# CONFIG_W83627HF_WDT is not set
# CONFIG_W83877F_WDT is not set
# CONFIG_W83977F_WDT is not set
CONFIG_MACHZ_WDT=y
CONFIG_SBC_EPX_C3_WATCHDOG=y
# CONFIG_INTEL_MEI_WDT is not set
CONFIG_NI903X_WDT=y
# CONFIG_NIC7018_WDT is not set
CONFIG_MEN_A21_WDT=y

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
# CONFIG_SSB_B43_PCI_BRIDGE is not set
CONFIG_SSB_PCMCIAHOST_POSSIBLE=y
CONFIG_SSB_PCMCIAHOST=y
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
CONFIG_SSB_SILENT=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
# CONFIG_SSB_DRIVER_PCICORE is not set
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
# CONFIG_BCMA_HOST_PCI is not set
CONFIG_BCMA_HOST_SOC=y
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_SFLASH=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
# CONFIG_BCMA_DRIVER_GPIO is not set
CONFIG_BCMA_DEBUG=y

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_CS5535 is not set
CONFIG_MFD_ACT8945A=y
CONFIG_MFD_AS3711=y
CONFIG_MFD_AS3722=y
CONFIG_PMIC_ADP5520=y
# CONFIG_MFD_AAT2870_CORE is not set
CONFIG_MFD_ATMEL_FLEXCOM=y
CONFIG_MFD_ATMEL_HLCDC=y
CONFIG_MFD_BCM590XX=y
CONFIG_MFD_BD9571MWV=y
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_CROS_EC is not set
# CONFIG_PMIC_DA903X is not set
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_I2C=y
CONFIG_MFD_DA9055=y
CONFIG_MFD_DA9062=y
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=y
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_I2C=y
CONFIG_MFD_HI6421_PMIC=y
# CONFIG_HTC_PASIC3 is not set
CONFIG_HTC_I2CPLD=y
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=y
CONFIG_INTEL_SOC_PMIC=y
CONFIG_INTEL_SOC_PMIC_BXTWC=y
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
CONFIG_MFD_INTEL_MSIC=y
CONFIG_MFD_JANZ_CMODIO=y
CONFIG_MFD_KEMPLD=y
# CONFIG_MFD_88PM800 is not set
CONFIG_MFD_88PM805=y
# CONFIG_MFD_88PM860X is not set
CONFIG_MFD_MAX14577=y
CONFIG_MFD_MAX77620=y
CONFIG_MFD_MAX77686=y
CONFIG_MFD_MAX77693=y
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
CONFIG_MFD_MAX8925=y
# CONFIG_MFD_MAX8997 is not set
CONFIG_MFD_MAX8998=y
# CONFIG_MFD_MT6397 is not set
CONFIG_MFD_MENF21BMC=y
CONFIG_MFD_RETU=y
CONFIG_MFD_PCF50633=y
CONFIG_PCF50633_ADC=y
CONFIG_PCF50633_GPIO=y
# CONFIG_UCB1400_CORE is not set
CONFIG_MFD_RDC321X=y
CONFIG_MFD_RT5033=y
# CONFIG_MFD_RC5T583 is not set
CONFIG_MFD_RK808=y
CONFIG_MFD_RN5T618=y
CONFIG_MFD_SEC_CORE=y
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=y
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SMSC is not set
CONFIG_ABX500_CORE=y
# CONFIG_AB3100_CORE is not set
CONFIG_MFD_STMPE=y

#
# STMicroelectronics STMPE Interface Drivers
#
CONFIG_STMPE_I2C=y
CONFIG_MFD_SYSCON=y
# CONFIG_MFD_TI_AM335X_TSCADC is not set
CONFIG_MFD_LP3943=y
CONFIG_MFD_LP8788=y
CONFIG_MFD_TI_LMU=y
CONFIG_MFD_PALMAS=y
CONFIG_TPS6105X=y
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
CONFIG_MFD_TPS65086=y
CONFIG_MFD_TPS65090=y
CONFIG_MFD_TPS65217=y
# CONFIG_MFD_TPS68470 is not set
CONFIG_MFD_TI_LP873X=y
# CONFIG_MFD_TI_LP87565 is not set
CONFIG_MFD_TPS65218=y
CONFIG_MFD_TPS6586X=y
# CONFIG_MFD_TPS65910 is not set
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
CONFIG_MFD_TPS80031=y
# CONFIG_TWL4030_CORE is not set
CONFIG_TWL6040_CORE=y
# CONFIG_MFD_WL1273_CORE is not set
CONFIG_MFD_LM3533=y
CONFIG_MFD_TIMBERDALE=y
# CONFIG_MFD_TC3589X is not set
# CONFIG_MFD_TMIO is not set
CONFIG_MFD_VX855=y
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
CONFIG_MFD_WM8994=y
# CONFIG_RAVE_SP_CORE is not set
CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
# CONFIG_REGULATOR_ACT8865 is not set
# CONFIG_REGULATOR_ACT8945A is not set
CONFIG_REGULATOR_AD5398=y
CONFIG_REGULATOR_ANATOP=y
# CONFIG_REGULATOR_AS3711 is not set
# CONFIG_REGULATOR_AS3722 is not set
CONFIG_REGULATOR_BCM590XX=y
# CONFIG_REGULATOR_BD9571MWV is not set
# CONFIG_REGULATOR_DA9052 is not set
# CONFIG_REGULATOR_DA9055 is not set
# CONFIG_REGULATOR_DA9062 is not set
# CONFIG_REGULATOR_DA9063 is not set
# CONFIG_REGULATOR_DA9210 is not set
CONFIG_REGULATOR_DA9211=y
# CONFIG_REGULATOR_FAN53555 is not set
# CONFIG_REGULATOR_GPIO is not set
# CONFIG_REGULATOR_HI6421 is not set
CONFIG_REGULATOR_HI6421V530=y
CONFIG_REGULATOR_ISL9305=y
CONFIG_REGULATOR_ISL6271A=y
CONFIG_REGULATOR_LM363X=y
CONFIG_REGULATOR_LP3971=y
CONFIG_REGULATOR_LP3972=y
# CONFIG_REGULATOR_LP872X is not set
# CONFIG_REGULATOR_LP873X is not set
CONFIG_REGULATOR_LP8755=y
# CONFIG_REGULATOR_LP8788 is not set
CONFIG_REGULATOR_LTC3589=y
CONFIG_REGULATOR_LTC3676=y
CONFIG_REGULATOR_MAX14577=y
CONFIG_REGULATOR_MAX1586=y
CONFIG_REGULATOR_MAX77620=y
CONFIG_REGULATOR_MAX8649=y
CONFIG_REGULATOR_MAX8660=y
CONFIG_REGULATOR_MAX8925=y
CONFIG_REGULATOR_MAX8952=y
# CONFIG_REGULATOR_MAX8973 is not set
CONFIG_REGULATOR_MAX8998=y
CONFIG_REGULATOR_MAX77686=y
CONFIG_REGULATOR_MAX77693=y
CONFIG_REGULATOR_MAX77802=y
CONFIG_REGULATOR_MC13XXX_CORE=y
# CONFIG_REGULATOR_MC13783 is not set
CONFIG_REGULATOR_MC13892=y
CONFIG_REGULATOR_MT6311=y
CONFIG_REGULATOR_PALMAS=y
# CONFIG_REGULATOR_PCF50633 is not set
# CONFIG_REGULATOR_PFUZE100 is not set
CONFIG_REGULATOR_PV88060=y
CONFIG_REGULATOR_PV88080=y
CONFIG_REGULATOR_PV88090=y
# CONFIG_REGULATOR_QCOM_SPMI is not set
CONFIG_REGULATOR_RK808=y
CONFIG_REGULATOR_RN5T618=y
# CONFIG_REGULATOR_RT5033 is not set
CONFIG_REGULATOR_S2MPA01=y
# CONFIG_REGULATOR_S2MPS11 is not set
CONFIG_REGULATOR_S5M8767=y
CONFIG_REGULATOR_TPS51632=y
# CONFIG_REGULATOR_TPS6105X is not set
# CONFIG_REGULATOR_TPS62360 is not set
CONFIG_REGULATOR_TPS65023=y
# CONFIG_REGULATOR_TPS6507X is not set
# CONFIG_REGULATOR_TPS65086 is not set
# CONFIG_REGULATOR_TPS65090 is not set
CONFIG_REGULATOR_TPS65132=y
# CONFIG_REGULATOR_TPS65217 is not set
CONFIG_REGULATOR_TPS65218=y
CONFIG_REGULATOR_TPS6586X=y
CONFIG_REGULATOR_TPS65912=y
CONFIG_REGULATOR_TPS80031=y
CONFIG_REGULATOR_VCTRL=y
# CONFIG_REGULATOR_WM8350 is not set
CONFIG_REGULATOR_WM8994=y
CONFIG_CEC_CORE=y
CONFIG_CEC_NOTIFIER=y
CONFIG_RC_CORE=y
CONFIG_RC_MAP=y
CONFIG_LIRC=y
CONFIG_RC_DECODERS=y
CONFIG_IR_NEC_DECODER=y
# CONFIG_IR_RC5_DECODER is not set
CONFIG_IR_RC6_DECODER=y
CONFIG_IR_JVC_DECODER=y
CONFIG_IR_SONY_DECODER=y
CONFIG_IR_SANYO_DECODER=y
CONFIG_IR_SHARP_DECODER=y
CONFIG_IR_MCE_KBD_DECODER=y
CONFIG_IR_XMP_DECODER=y
# CONFIG_RC_DEVICES is not set
# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
CONFIG_AGP=y
# CONFIG_AGP_ALI is not set
CONFIG_AGP_ATI=y
# CONFIG_AGP_AMD is not set
CONFIG_AGP_AMD64=y
CONFIG_AGP_INTEL=y
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
CONFIG_AGP_SWORKS=y
CONFIG_AGP_VIA=y
CONFIG_AGP_EFFICEON=y
CONFIG_INTEL_GTT=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=y
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DEBUG_MM is not set
CONFIG_DRM_DEBUG_MM_SELFTEST=y
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
CONFIG_DRM_TTM=y
CONFIG_DRM_GEM_CMA_HELPER=y
CONFIG_DRM_KMS_CMA_HELPER=y
CONFIG_DRM_VM=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=y
# CONFIG_DRM_I2C_SIL164 is not set
CONFIG_DRM_I2C_NXP_TDA998X=y
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set

#
# ACP (Audio CoProcessor) Configuration
#

#
# AMD Library routines
#
# CONFIG_CHASH is not set
CONFIG_DRM_NOUVEAU=y
CONFIG_NOUVEAU_DEBUG=5
CONFIG_NOUVEAU_DEBUG_DEFAULT=3
# CONFIG_NOUVEAU_DEBUG_MMU is not set
# CONFIG_DRM_NOUVEAU_BACKLIGHT is not set
# CONFIG_DRM_I915 is not set
CONFIG_DRM_VGEM=y
CONFIG_DRM_VMWGFX=y
CONFIG_DRM_VMWGFX_FBCON=y
CONFIG_DRM_GMA500=y
CONFIG_DRM_GMA600=y
CONFIG_DRM_GMA3600=y
CONFIG_DRM_MEDFIELD=y
# CONFIG_DRM_UDL is not set
# CONFIG_DRM_AST is not set
# CONFIG_DRM_MGAG200 is not set
# CONFIG_DRM_CIRRUS_QEMU is not set
CONFIG_DRM_RCAR_DW_HDMI=y
CONFIG_DRM_QXL=y
CONFIG_DRM_BOCHS=y
CONFIG_DRM_VIRTIO_GPU=y
CONFIG_DRM_PANEL=y

#
# Display Panels
#
CONFIG_DRM_PANEL_LVDS=y
CONFIG_DRM_PANEL_SIMPLE=y
# CONFIG_DRM_PANEL_INNOLUX_P079ZCA is not set
CONFIG_DRM_PANEL_JDI_LT070ME05000=y
# CONFIG_DRM_PANEL_ORISETECH_OTM8009A is not set
CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00=y
CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=y
CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2=y
CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=y
# CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0 is not set
# CONFIG_DRM_PANEL_SEIKO_43WVF1G is not set
# CONFIG_DRM_PANEL_SHARP_LQ101R1SX01 is not set
# CONFIG_DRM_PANEL_SHARP_LS043T1LE01 is not set
CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
CONFIG_DRM_DUMB_VGA_DAC=y
CONFIG_DRM_LVDS_ENCODER=y
CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW=y
# CONFIG_DRM_NXP_PTN3460 is not set
# CONFIG_DRM_PARADE_PS8622 is not set
# CONFIG_DRM_SIL_SII8620 is not set
CONFIG_DRM_SII902X=y
# CONFIG_DRM_SII9234 is not set
CONFIG_DRM_TOSHIBA_TC358767=y
CONFIG_DRM_TI_TFP410=y
CONFIG_DRM_I2C_ADV7511=y
# CONFIG_DRM_I2C_ADV7511_AUDIO is not set
CONFIG_DRM_I2C_ADV7533=y
CONFIG_DRM_I2C_ADV7511_CEC=y
CONFIG_DRM_DW_HDMI=y
CONFIG_DRM_DW_HDMI_AHB_AUDIO=y
CONFIG_DRM_DW_HDMI_I2S_AUDIO=y
CONFIG_DRM_DW_HDMI_CEC=y
CONFIG_DRM_ARCPGU=y
# CONFIG_DRM_HISI_HIBMC is not set
CONFIG_DRM_MXS=y
CONFIG_DRM_MXSFB=y
CONFIG_DRM_TINYDRM=y
CONFIG_DRM_LEGACY=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_I810 is not set
CONFIG_DRM_MGA=y
CONFIG_DRM_SIS=y
# CONFIG_DRM_VIA is not set
# CONFIG_DRM_SAVAGE is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_LIB_RANDOM=y

#
# Frame buffer Devices
#
CONFIG_FB=y
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB_DDC=y
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_PROVIDE_GET_FB_UNMAPPED_AREA is not set
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_SVGALIB=y
# CONFIG_FB_MACMODES is not set
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
CONFIG_FB_CIRRUS=y
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
CONFIG_FB_IMSTT=y
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
# CONFIG_FB_EFI is not set
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
CONFIG_FB_OPENCORES=y
CONFIG_FB_S1D13XXX=y
CONFIG_FB_NVIDIA=y
CONFIG_FB_NVIDIA_I2C=y
# CONFIG_FB_NVIDIA_DEBUG is not set
CONFIG_FB_NVIDIA_BACKLIGHT=y
# CONFIG_FB_RIVA is not set
CONFIG_FB_I740=y
CONFIG_FB_I810=y
CONFIG_FB_I810_GTF=y
CONFIG_FB_I810_I2C=y
CONFIG_FB_LE80578=y
CONFIG_FB_CARILLO_RANCH=y
CONFIG_FB_INTEL=y
CONFIG_FB_INTEL_DEBUG=y
CONFIG_FB_INTEL_I2C=y
CONFIG_FB_MATROX=y
CONFIG_FB_MATROX_MILLENIUM=y
# CONFIG_FB_MATROX_MYSTIQUE is not set
CONFIG_FB_MATROX_G=y
CONFIG_FB_MATROX_I2C=y
CONFIG_FB_MATROX_MAVEN=y
CONFIG_FB_RADEON=y
CONFIG_FB_RADEON_I2C=y
# CONFIG_FB_RADEON_BACKLIGHT is not set
CONFIG_FB_RADEON_DEBUG=y
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
CONFIG_FB_SAVAGE=y
# CONFIG_FB_SAVAGE_I2C is not set
# CONFIG_FB_SAVAGE_ACCEL is not set
CONFIG_FB_SIS=y
# CONFIG_FB_SIS_300 is not set
CONFIG_FB_SIS_315=y
CONFIG_FB_VIA=y
# CONFIG_FB_VIA_DIRECT_PROCFS is not set
# CONFIG_FB_VIA_X_COMPATIBILITY is not set
CONFIG_FB_NEOMAGIC=y
# CONFIG_FB_KYRO is not set
CONFIG_FB_3DFX=y
CONFIG_FB_3DFX_ACCEL=y
# CONFIG_FB_3DFX_I2C is not set
CONFIG_FB_VOODOO1=y
CONFIG_FB_VT8623=y
# CONFIG_FB_TRIDENT is not set
CONFIG_FB_ARK=y
CONFIG_FB_PM3=y
# CONFIG_FB_CARMINE is not set
CONFIG_FB_GEODE=y
CONFIG_FB_GEODE_LX=y
CONFIG_FB_GEODE_GX=y
CONFIG_FB_GEODE_GX1=y
CONFIG_FB_SM501=y
CONFIG_FB_IBM_GXT4500=y
# CONFIG_FB_GOLDFISH is not set
CONFIG_FB_VIRTUAL=y
CONFIG_FB_METRONOME=y
# CONFIG_FB_MB862XX is not set
CONFIG_FB_BROADSHEET=y
CONFIG_FB_AUO_K190X=y
CONFIG_FB_AUO_K1900=y
# CONFIG_FB_AUO_K1901 is not set
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SSD1307 is not set
CONFIG_FB_SM712=y
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_LCD_CLASS_DEVICE=y
# CONFIG_LCD_PLATFORM is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_GENERIC=y
CONFIG_BACKLIGHT_LM3533=y
# CONFIG_BACKLIGHT_CARILLO_RANCH is not set
# CONFIG_BACKLIGHT_DA9052 is not set
# CONFIG_BACKLIGHT_MAX8925 is not set
CONFIG_BACKLIGHT_APPLE=y
# CONFIG_BACKLIGHT_PM8941_WLED is not set
CONFIG_BACKLIGHT_SAHARA=y
# CONFIG_BACKLIGHT_ADP5520 is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
CONFIG_BACKLIGHT_ADP8870=y
CONFIG_BACKLIGHT_PCF50633=y
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_TPS65217=y
CONFIG_BACKLIGHT_AS3711=y
CONFIG_BACKLIGHT_GPIO=y
CONFIG_BACKLIGHT_LV5207LP=y
CONFIG_BACKLIGHT_BD6107=y
CONFIG_BACKLIGHT_ARCXCNN=y
CONFIG_VGASTATE=y
CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
CONFIG_SOUND=y
# CONFIG_SOUND_OSS_CORE is not set
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_PCM_ELD=y
CONFIG_SND_PCM_IEC958=y
CONFIG_SND_DMAENGINE_PCM=y
CONFIG_SND_HWDEP=y
CONFIG_SND_SEQ_DEVICE=y
CONFIG_SND_RAWMIDI=y
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
# CONFIG_SND_OSSEMUL is not set
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_HRTIMER=y
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_DEBUG=y
# CONFIG_SND_DEBUG_VERBOSE is not set
CONFIG_SND_PCM_XRUN_DEBUG=y
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_SEQUENCER=y
CONFIG_SND_SEQ_DUMMY=y
# CONFIG_SND_SEQ_HRTIMER_DEFAULT is not set
CONFIG_SND_SEQ_MIDI_EVENT=y
CONFIG_SND_SEQ_MIDI=y
CONFIG_SND_SEQ_VIRMIDI=y
# CONFIG_SND_OPL3_LIB_SEQ is not set
# CONFIG_SND_OPL4_LIB_SEQ is not set
CONFIG_SND_VX_LIB=y
CONFIG_SND_AC97_CODEC=y
CONFIG_SND_DRIVERS=y
CONFIG_SND_PCSP=y
CONFIG_SND_DUMMY=y
CONFIG_SND_ALOOP=y
CONFIG_SND_VIRMIDI=y
CONFIG_SND_MTPAV=y
# CONFIG_SND_MTS64 is not set
CONFIG_SND_SERIAL_U16550=y
# CONFIG_SND_MPU401 is not set
# CONFIG_SND_PORTMAN2X4 is not set
# CONFIG_SND_AC97_POWER_SAVE is not set
# CONFIG_SND_PCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA_PREALLOC_SIZE=64
CONFIG_SND_PCMCIA=y
CONFIG_SND_VXPOCKET=y
CONFIG_SND_PDAUDIOCF=y
CONFIG_SND_SOC=y
CONFIG_SND_SOC_AC97_BUS=y
CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
CONFIG_SND_SOC_AMD_ACP=y
CONFIG_SND_SOC_AMD_CZ_RT5645_MACH=y
CONFIG_SND_ATMEL_SOC=y
CONFIG_SND_DESIGNWARE_I2S=y
# CONFIG_SND_DESIGNWARE_PCM is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
CONFIG_SND_SOC_FSL_ASRC=y
# CONFIG_SND_SOC_FSL_SAI is not set
# CONFIG_SND_SOC_FSL_SSI is not set
CONFIG_SND_SOC_FSL_SPDIF=y
# CONFIG_SND_SOC_FSL_ESAI is not set
# CONFIG_SND_SOC_IMX_AUDMUX is not set
# CONFIG_SND_I2S_HI6210_I2S is not set
# CONFIG_SND_SOC_IMG is not set
# CONFIG_SND_SOC_INTEL_SST_TOPLEVEL is not set

#
# STMicroelectronics STM32 SOC audio support
#
# CONFIG_SND_SOC_XTFPGA_I2S is not set
CONFIG_ZX_TDM=y
CONFIG_SND_SOC_I2C_AND_SPI=y

#
# CODEC drivers
#
CONFIG_SND_SOC_AC97_CODEC=y
CONFIG_SND_SOC_ADAU_UTILS=y
CONFIG_SND_SOC_ADAU1701=y
CONFIG_SND_SOC_ADAU17X1=y
CONFIG_SND_SOC_ADAU1761=y
CONFIG_SND_SOC_ADAU1761_I2C=y
CONFIG_SND_SOC_ADAU7002=y
CONFIG_SND_SOC_AK4554=y
CONFIG_SND_SOC_AK4613=y
CONFIG_SND_SOC_AK4642=y
CONFIG_SND_SOC_AK5386=y
CONFIG_SND_SOC_ALC5623=y
CONFIG_SND_SOC_BT_SCO=y
CONFIG_SND_SOC_CS35L32=y
CONFIG_SND_SOC_CS35L33=y
CONFIG_SND_SOC_CS35L34=y
CONFIG_SND_SOC_CS35L35=y
CONFIG_SND_SOC_CS42L42=y
CONFIG_SND_SOC_CS42L51=y
CONFIG_SND_SOC_CS42L51_I2C=y
CONFIG_SND_SOC_CS42L52=y
CONFIG_SND_SOC_CS42L56=y
CONFIG_SND_SOC_CS42L73=y
CONFIG_SND_SOC_CS4265=y
CONFIG_SND_SOC_CS4270=y
CONFIG_SND_SOC_CS4271=y
CONFIG_SND_SOC_CS4271_I2C=y
CONFIG_SND_SOC_CS42XX8=y
CONFIG_SND_SOC_CS42XX8_I2C=y
CONFIG_SND_SOC_CS43130=y
CONFIG_SND_SOC_CS4349=y
CONFIG_SND_SOC_CS53L30=y
CONFIG_SND_SOC_DIO2125=y
CONFIG_SND_SOC_HDMI_CODEC=y
CONFIG_SND_SOC_ES7134=y
CONFIG_SND_SOC_ES8316=y
CONFIG_SND_SOC_ES8328=y
CONFIG_SND_SOC_ES8328_I2C=y
CONFIG_SND_SOC_GTM601=y
CONFIG_SND_SOC_INNO_RK3036=y
CONFIG_SND_SOC_MAX98504=y
CONFIG_SND_SOC_MAX98927=y
CONFIG_SND_SOC_MAX98373=y
CONFIG_SND_SOC_MAX9860=y
CONFIG_SND_SOC_MSM8916_WCD_ANALOG=y
# CONFIG_SND_SOC_MSM8916_WCD_DIGITAL is not set
CONFIG_SND_SOC_PCM1681=y
CONFIG_SND_SOC_PCM179X=y
CONFIG_SND_SOC_PCM179X_I2C=y
CONFIG_SND_SOC_PCM186X=y
CONFIG_SND_SOC_PCM186X_I2C=y
CONFIG_SND_SOC_PCM3168A=y
CONFIG_SND_SOC_PCM3168A_I2C=y
CONFIG_SND_SOC_PCM512x=y
CONFIG_SND_SOC_PCM512x_I2C=y
CONFIG_SND_SOC_RL6231=y
# CONFIG_SND_SOC_RT5514_SPI_BUILTIN is not set
CONFIG_SND_SOC_RT5616=y
CONFIG_SND_SOC_RT5631=y
CONFIG_SND_SOC_RT5645=y
# CONFIG_SND_SOC_RT5677_SPI is not set
CONFIG_SND_SOC_SGTL5000=y
CONFIG_SND_SOC_SIGMADSP=y
CONFIG_SND_SOC_SIGMADSP_I2C=y
CONFIG_SND_SOC_SIGMADSP_REGMAP=y
CONFIG_SND_SOC_SIRF_AUDIO_CODEC=y
CONFIG_SND_SOC_SPDIF=y
CONFIG_SND_SOC_SSM2602=y
CONFIG_SND_SOC_SSM2602_I2C=y
CONFIG_SND_SOC_SSM4567=y
CONFIG_SND_SOC_STA32X=y
CONFIG_SND_SOC_STA350=y
CONFIG_SND_SOC_STI_SAS=y
CONFIG_SND_SOC_TAS2552=y
CONFIG_SND_SOC_TAS5086=y
CONFIG_SND_SOC_TAS571X=y
CONFIG_SND_SOC_TAS5720=y
CONFIG_SND_SOC_TAS6424=y
CONFIG_SND_SOC_TFA9879=y
CONFIG_SND_SOC_TLV320AIC23=y
CONFIG_SND_SOC_TLV320AIC23_I2C=y
CONFIG_SND_SOC_TLV320AIC31XX=y
CONFIG_SND_SOC_TLV320AIC32X4=y
CONFIG_SND_SOC_TLV320AIC32X4_I2C=y
CONFIG_SND_SOC_TLV320AIC3X=y
CONFIG_SND_SOC_TS3A227E=y
CONFIG_SND_SOC_TSCS42XX=y
CONFIG_SND_SOC_WM8510=y
CONFIG_SND_SOC_WM8523=y
CONFIG_SND_SOC_WM8524=y
CONFIG_SND_SOC_WM8580=y
CONFIG_SND_SOC_WM8711=y
CONFIG_SND_SOC_WM8728=y
CONFIG_SND_SOC_WM8731=y
CONFIG_SND_SOC_WM8737=y
CONFIG_SND_SOC_WM8741=y
CONFIG_SND_SOC_WM8750=y
CONFIG_SND_SOC_WM8753=y
CONFIG_SND_SOC_WM8776=y
CONFIG_SND_SOC_WM8804=y
CONFIG_SND_SOC_WM8804_I2C=y
CONFIG_SND_SOC_WM8903=y
CONFIG_SND_SOC_WM8960=y
CONFIG_SND_SOC_WM8962=y
CONFIG_SND_SOC_WM8974=y
CONFIG_SND_SOC_WM8978=y
CONFIG_SND_SOC_WM8985=y
# CONFIG_SND_SOC_ZX_AUD96P22 is not set
CONFIG_SND_SOC_NAU8540=y
CONFIG_SND_SOC_NAU8810=y
CONFIG_SND_SOC_NAU8824=y
CONFIG_SND_SOC_TPA6130A2=y
CONFIG_SND_SIMPLE_CARD_UTILS=y
CONFIG_SND_SIMPLE_CARD=y
CONFIG_SND_SIMPLE_SCU_CARD=y
CONFIG_SND_AUDIO_GRAPH_CARD=y
# CONFIG_SND_AUDIO_GRAPH_SCU_CARD is not set
CONFIG_SND_X86=y
CONFIG_AC97_BUS=y

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
# CONFIG_HIDRAW is not set
CONFIG_UHID=y
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
# CONFIG_HID_ACRUX is not set
# CONFIG_HID_APPLE is not set
CONFIG_HID_ASUS=y
CONFIG_HID_AUREAL=y
CONFIG_HID_BELKIN=y
# CONFIG_HID_CHERRY is not set
# CONFIG_HID_CHICONY is not set
CONFIG_HID_PRODIKEYS=y
CONFIG_HID_CMEDIA=y
# CONFIG_HID_CYPRESS is not set
CONFIG_HID_DRAGONRISE=y
# CONFIG_DRAGONRISE_FF is not set
CONFIG_HID_EMS_FF=y
CONFIG_HID_ELECOM=y
# CONFIG_HID_EZKEY is not set
CONFIG_HID_GEMBIRD=y
CONFIG_HID_GFRM=y
CONFIG_HID_KEYTOUCH=y
# CONFIG_HID_KYE is not set
CONFIG_HID_WALTOP=y
CONFIG_HID_GYRATION=y
CONFIG_HID_ICADE=y
# CONFIG_HID_ITE is not set
CONFIG_HID_JABRA=y
# CONFIG_HID_TWINHAN is not set
# CONFIG_HID_KENSINGTON is not set
CONFIG_HID_LCPOWER=y
CONFIG_HID_LED=y
CONFIG_HID_LENOVO=y
CONFIG_HID_LOGITECH=y
# CONFIG_HID_LOGITECH_HIDPP is not set
# CONFIG_LOGITECH_FF is not set
CONFIG_LOGIRUMBLEPAD2_FF=y
CONFIG_LOGIG940_FF=y
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MAYFLASH is not set
CONFIG_HID_MICROSOFT=y
# CONFIG_HID_MONTEREY is not set
CONFIG_HID_MULTITOUCH=y
# CONFIG_HID_NTI is not set
# CONFIG_HID_ORTEK is not set
CONFIG_HID_PANTHERLORD=y
# CONFIG_PANTHERLORD_FF is not set
CONFIG_HID_PETALYNX=y
CONFIG_HID_PICOLCD=y
# CONFIG_HID_PICOLCD_FB is not set
CONFIG_HID_PICOLCD_BACKLIGHT=y
# CONFIG_HID_PICOLCD_LCD is not set
# CONFIG_HID_PICOLCD_LEDS is not set
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=y
# CONFIG_HID_PRIMAX is not set
CONFIG_HID_SAITEK=y
CONFIG_HID_SAMSUNG=y
# CONFIG_HID_SPEEDLINK is not set
CONFIG_HID_STEELSERIES=y
CONFIG_HID_SUNPLUS=y
CONFIG_HID_RMI=y
CONFIG_HID_GREENASIA=y
CONFIG_GREENASIA_FF=y
CONFIG_HID_SMARTJOYPLUS=y
CONFIG_SMARTJOYPLUS_FF=y
CONFIG_HID_TIVO=y
CONFIG_HID_TOPSEED=y
CONFIG_HID_THINGM=y
CONFIG_HID_THRUSTMASTER=y
# CONFIG_THRUSTMASTER_FF is not set
CONFIG_HID_UDRAW_PS3=y
CONFIG_HID_WIIMOTE=y
CONFIG_HID_XINMO=y
CONFIG_HID_ZEROPLUS=y
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=y
# CONFIG_HID_SENSOR_HUB is not set
CONFIG_HID_ALPS=y

#
# I2C HID support
#
# CONFIG_I2C_HID is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_ARCH_HAS_HCD=y
# CONFIG_USB is not set
CONFIG_USB_PCI=y

#
# USB port drivers
#

#
# USB Physical Layer drivers
#
# CONFIG_USB_PHY is not set
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_TAHVO_USB is not set
# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_ULPI_BUS is not set
CONFIG_UWB=y
CONFIG_UWB_WHCI=y
CONFIG_MMC=y
CONFIG_PWRSEQ_EMMC=y
# CONFIG_PWRSEQ_SIMPLE is not set
# CONFIG_MMC_BLOCK is not set
# CONFIG_SDIO_UART is not set
CONFIG_MMC_TEST=y

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
# CONFIG_MMC_SDHCI is not set
# CONFIG_MMC_WBSD is not set
CONFIG_MMC_TIFM_SD=y
CONFIG_MMC_GOLDFISH=y
# CONFIG_MMC_SDRICOH_CS is not set
CONFIG_MMC_CB710=y
CONFIG_MMC_VIA_SDMMC=y
CONFIG_MMC_USDHI6ROL0=y
# CONFIG_MMC_CQHCI is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
CONFIG_MMC_MTK=y
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_AAT1290 is not set
CONFIG_LEDS_APU=y
# CONFIG_LEDS_AS3645A is not set
# CONFIG_LEDS_BCM6328 is not set
# CONFIG_LEDS_BCM6358 is not set
CONFIG_LEDS_LM3530=y
CONFIG_LEDS_LM3533=y
CONFIG_LEDS_LM3642=y
CONFIG_LEDS_LM3692X=y
# CONFIG_LEDS_PCA9532 is not set
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_LP3944=y
CONFIG_LEDS_LP3952=y
CONFIG_LEDS_LP55XX_COMMON=y
# CONFIG_LEDS_LP5521 is not set
CONFIG_LEDS_LP5523=y
# CONFIG_LEDS_LP5562 is not set
CONFIG_LEDS_LP8501=y
CONFIG_LEDS_LP8788=y
CONFIG_LEDS_LP8860=y
# CONFIG_LEDS_CLEVO_MAIL is not set
# CONFIG_LEDS_PCA955X is not set
CONFIG_LEDS_PCA963X=y
# CONFIG_LEDS_WM8350 is not set
# CONFIG_LEDS_DA9052 is not set
CONFIG_LEDS_REGULATOR=y
CONFIG_LEDS_BD2802=y
CONFIG_LEDS_INTEL_SS4200=y
CONFIG_LEDS_LT3593=y
# CONFIG_LEDS_ADP5520 is not set
# CONFIG_LEDS_MC13783 is not set
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
CONFIG_LEDS_MAX77693=y
CONFIG_LEDS_LM355x=y
CONFIG_LEDS_OT200=y
CONFIG_LEDS_MENF21BMC=y
# CONFIG_LEDS_KTD2692 is not set
# CONFIG_LEDS_IS31FL319X is not set
CONFIG_LEDS_IS31FL32XX=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
# CONFIG_LEDS_SYSCON is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set

#
# LED Triggers
#
# CONFIG_LEDS_TRIGGERS is not set
CONFIG_ACCESSIBILITY=y
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
# CONFIG_EDAC_LEGACY_SYSFS is not set
CONFIG_EDAC_DEBUG=y
# CONFIG_EDAC_AMD76X is not set
CONFIG_EDAC_E7XXX=y
CONFIG_EDAC_E752X=y
CONFIG_EDAC_I82875P=y
# CONFIG_EDAC_I82975X is not set
CONFIG_EDAC_I3000=y
# CONFIG_EDAC_I3200 is not set
# CONFIG_EDAC_IE31200 is not set
CONFIG_EDAC_X38=y
CONFIG_EDAC_I5400=y
CONFIG_EDAC_I82860=y
CONFIG_EDAC_R82600=y
CONFIG_EDAC_I5000=y
CONFIG_EDAC_I5100=y
CONFIG_EDAC_I7300=y
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
# CONFIG_RTC_CLASS is not set
CONFIG_DMADEVICES=y
CONFIG_DMADEVICES_DEBUG=y
# CONFIG_DMADEVICES_VDEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
CONFIG_DMA_OF=y
CONFIG_ALTERA_MSGDMA=y
CONFIG_FSL_EDMA=y
CONFIG_INTEL_IDMA64=y
CONFIG_PCH_DMA=y
CONFIG_TIMB_DMA=y
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
# CONFIG_DW_DMAC is not set
CONFIG_DW_DMAC_PCI=y
CONFIG_HSU_DMA=y
CONFIG_HSU_DMA_PCI=y

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=y
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
# CONFIG_UIO is not set
CONFIG_VIRT_DRIVERS=y
CONFIG_VBOXGUEST=y
CONFIG_VIRTIO=y
# CONFIG_VIRTIO_MENU is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# CONFIG_HYPERV_TSCPAGE is not set
# CONFIG_STAGING is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACER_WMI=y
CONFIG_ACER_WIRELESS=y
CONFIG_ACERHDF=y
# CONFIG_ALIENWARE_WMI is not set
CONFIG_ASUS_LAPTOP=y
# CONFIG_DELL_SMBIOS_WMI is not set
# CONFIG_DELL_SMBIOS_SMM is not set
# CONFIG_DELL_LAPTOP is not set
# CONFIG_DELL_WMI is not set
# CONFIG_DELL_WMI_AIO is not set
CONFIG_DELL_WMI_LED=y
CONFIG_DELL_SMO8800=y
CONFIG_FUJITSU_LAPTOP=y
# CONFIG_FUJITSU_TABLET is not set
CONFIG_GPD_POCKET_FAN=y
CONFIG_TC1100_WMI=y
CONFIG_HP_ACCEL=y
CONFIG_HP_WIRELESS=y
# CONFIG_HP_WMI is not set
# CONFIG_PANASONIC_LAPTOP is not set
CONFIG_THINKPAD_ACPI=y
# CONFIG_THINKPAD_ACPI_ALSA_SUPPORT is not set
CONFIG_THINKPAD_ACPI_DEBUGFACILITIES=y
CONFIG_THINKPAD_ACPI_DEBUG=y
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
# CONFIG_THINKPAD_ACPI_HOTKEY_POLL is not set
CONFIG_SENSORS_HDAPS=y
CONFIG_EEEPC_LAPTOP=y
CONFIG_ASUS_WMI=y
CONFIG_ASUS_NB_WMI=y
CONFIG_EEEPC_WMI=y
CONFIG_ASUS_WIRELESS=y
CONFIG_ACPI_WMI=y
CONFIG_WMI_BMOF=y
CONFIG_INTEL_WMI_THUNDERBOLT=y
# CONFIG_MSI_WMI is not set
CONFIG_PEAQ_WMI=y
# CONFIG_TOPSTAR_LAPTOP is not set
# CONFIG_TOSHIBA_BT_RFKILL is not set
CONFIG_TOSHIBA_HAPS=y
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=y
# CONFIG_INTEL_CHT_INT33FE is not set
CONFIG_INTEL_INT0002_VGPIO=y
# CONFIG_INTEL_HID_EVENT is not set
# CONFIG_INTEL_VBTN is not set
CONFIG_INTEL_SCU_IPC=y
CONFIG_INTEL_SCU_IPC_UTIL=y
CONFIG_INTEL_MID_POWER_BUTTON=y
CONFIG_INTEL_MFLD_THERMAL=y
# CONFIG_INTEL_IPS is not set
# CONFIG_INTEL_PMC_CORE is not set
CONFIG_IBM_RTL=y
CONFIG_XO15_EBOOK=y
# CONFIG_SAMSUNG_LAPTOP is not set
CONFIG_MXM_WMI=y
CONFIG_SAMSUNG_Q10=y
CONFIG_APPLE_GMUX=y
CONFIG_INTEL_RST=y
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_PVPANIC is not set
CONFIG_INTEL_PMC_IPC=y
# CONFIG_INTEL_BXTWC_PMIC_TMU is not set
CONFIG_SURFACE_PRO3_BUTTON=y
# CONFIG_SURFACE_3_BUTTON is not set
# CONFIG_INTEL_PUNIT_IPC is not set
CONFIG_MLX_PLATFORM=y
CONFIG_PMC_ATOM=y
CONFIG_GOLDFISH_BUS=y
CONFIG_GOLDFISH_PIPE=y
CONFIG_CHROME_PLATFORMS=y
# CONFIG_CHROMEOS_LAPTOP is not set
CONFIG_CHROMEOS_PSTORE=y
CONFIG_CROS_KBD_LED_BACKLIGHT=y
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=y
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
CONFIG_CLK_HSDK=y
# CONFIG_COMMON_CLK_MAX77686 is not set
# CONFIG_COMMON_CLK_RK808 is not set
CONFIG_COMMON_CLK_SI5351=y
CONFIG_COMMON_CLK_SI514=y
CONFIG_COMMON_CLK_SI570=y
# CONFIG_COMMON_CLK_CDCE706 is not set
CONFIG_COMMON_CLK_CDCE925=y
# CONFIG_COMMON_CLK_CS2000_CP is not set
CONFIG_COMMON_CLK_S2MPS11=y
CONFIG_CLK_TWL6040=y
# CONFIG_COMMON_CLK_NXP is not set
CONFIG_COMMON_CLK_PALMAS=y
# CONFIG_COMMON_CLK_PXA is not set
# CONFIG_COMMON_CLK_PIC32 is not set
CONFIG_COMMON_CLK_VC5=y
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
CONFIG_DW_APB_TIMER=y
# CONFIG_ATMEL_PIT is not set
# CONFIG_SH_TIMER_CMT is not set
# CONFIG_SH_TIMER_MTU2 is not set
# CONFIG_SH_TIMER_TMU is not set
# CONFIG_EM_TIMER_STI is not set
# CONFIG_MAILBOX is not set
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# CONFIG_INTEL_IOMMU is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
# CONFIG_RPMSG_CHAR is not set
CONFIG_RPMSG_VIRTIO=y
# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#

#
# Broadcom SoC drivers
#

#
# i.MX SoC drivers
#

#
# Qualcomm SoC drivers
#
# CONFIG_SUNXI_SRAM is not set
CONFIG_SOC_TI=y

#
# Xilinx SoC drivers
#
CONFIG_XILINX_VCU=y
CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
CONFIG_DEVFREQ_GOV_POWERSAVE=y
CONFIG_DEVFREQ_GOV_USERSPACE=y
CONFIG_DEVFREQ_GOV_PASSIVE=y

#
# DEVFREQ Drivers
#
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_GPIO=y
CONFIG_EXTCON_INTEL_INT3496=y
CONFIG_EXTCON_MAX14577=y
# CONFIG_EXTCON_MAX3355 is not set
CONFIG_EXTCON_MAX77693=y
# CONFIG_EXTCON_PALMAS is not set
CONFIG_EXTCON_RT8973A=y
CONFIG_EXTCON_SM5502=y
CONFIG_EXTCON_USB_GPIO=y
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
# CONFIG_NTB is not set
CONFIG_VME_BUS=y

#
# VME Bridge Drivers
#
# CONFIG_VME_CA91CX42 is not set
# CONFIG_VME_TSI148 is not set
# CONFIG_VME_FAKE is not set

#
# VME Board Drivers
#
CONFIG_VMIVME_7805=y

#
# VME Device Drivers
#
# CONFIG_PWM is not set

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
CONFIG_ARM_GIC_MAX_NR=1
# CONFIG_ARM_GIC_V3_ITS is not set
# CONFIG_IPACK_BUS is not set
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_ATH79 is not set
# CONFIG_RESET_AXS10X is not set
# CONFIG_RESET_BERLIN is not set
# CONFIG_RESET_IMX7 is not set
# CONFIG_RESET_LANTIQ is not set
# CONFIG_RESET_LPC18XX is not set
# CONFIG_RESET_MESON is not set
# CONFIG_RESET_PISTACHIO is not set
# CONFIG_RESET_SIMPLE is not set
# CONFIG_RESET_SUNXI is not set
# CONFIG_RESET_TI_SYSCON is not set
# CONFIG_RESET_ZYNQ is not set
# CONFIG_RESET_TEGRA_BPMP is not set
CONFIG_FMC=y
CONFIG_FMC_FAKEDEV=y
# CONFIG_FMC_TRIVIAL is not set
# CONFIG_FMC_WRITE_EEPROM is not set
CONFIG_FMC_CHARDEV=y

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_BCM_KONA_USB2_PHY=y
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL=y
CONFIG_MCB=y
CONFIG_MCB_PCI=y
# CONFIG_MCB_LPC is not set

#
# Performance monitor support
#
CONFIG_RAS=y
CONFIG_THUNDERBOLT=y

#
# Android
#
CONFIG_ANDROID=y
CONFIG_ANDROID_BINDER_IPC=y
CONFIG_ANDROID_BINDER_DEVICES="binder,hwbinder,vndbinder"
CONFIG_ANDROID_BINDER_IPC_32BIT=y
CONFIG_ANDROID_BINDER_IPC_SELFTEST=y
# CONFIG_DAX is not set
CONFIG_NVMEM=y
CONFIG_STM=y
CONFIG_STM_DUMMY=y
# CONFIG_STM_SOURCE_CONSOLE is not set
# CONFIG_STM_SOURCE_HEARTBEAT is not set
CONFIG_INTEL_TH=y
CONFIG_INTEL_TH_PCI=y
CONFIG_INTEL_TH_GTH=y
# CONFIG_INTEL_TH_STH is not set
CONFIG_INTEL_TH_MSU=y
CONFIG_INTEL_TH_PTI=y
CONFIG_INTEL_TH_DEBUG=y
CONFIG_FPGA=y
CONFIG_ALTERA_PR_IP_CORE=y
CONFIG_ALTERA_PR_IP_CORE_PLAT=y
# CONFIG_FPGA_MGR_ALTERA_CVP is not set
CONFIG_FPGA_BRIDGE=y
CONFIG_XILINX_PR_DECOUPLER=y
CONFIG_FPGA_REGION=y
CONFIG_OF_FPGA_REGION=y
# CONFIG_FSI is not set
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=y
# CONFIG_MUX_GPIO is not set
CONFIG_MUX_MMIO=y
CONFIG_PM_OPP=y
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set

#
# Firmware Drivers
#
CONFIG_EDD=y
CONFIG_EDD_OFF=y
# CONFIG_FIRMWARE_MEMMAP is not set
CONFIG_DELL_RBU=y
CONFIG_DCDBAS=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT_FIND is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
CONFIG_GOOGLE_FIRMWARE=y
CONFIG_GOOGLE_SMI=y
CONFIG_GOOGLE_COREBOOT_TABLE=y
# CONFIG_GOOGLE_COREBOOT_TABLE_ACPI is not set
CONFIG_GOOGLE_COREBOOT_TABLE_OF=y
# CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY is not set
# CONFIG_GOOGLE_MEMCONSOLE_COREBOOT is not set
CONFIG_GOOGLE_VPD=y

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
# CONFIG_EFI_VARS_PSTORE is not set
CONFIG_EFI_RUNTIME_MAP=y
CONFIG_EFI_FAKE_MEMMAP=y
CONFIG_EFI_MAX_FAKE_MEM=8
CONFIG_EFI_RUNTIME_WRAPPERS=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
CONFIG_EFI_CAPSULE_LOADER=y
# CONFIG_EFI_CAPSULE_QUIRK_QUARK_CSH is not set
CONFIG_EFI_TEST=y
CONFIG_APPLE_PROPERTIES=y
# CONFIG_RESET_ATTACK_MITIGATION is not set
CONFIG_UEFI_CPER=y
CONFIG_EFI_DEV_PATH_PARSER=y

#
# Tegra firmware driver
#

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_POSIX_ACL=y
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
# CONFIG_EXT4_FS_SECURITY is not set
# CONFIG_EXT4_ENCRYPTION is not set
CONFIG_EXT4_DEBUG=y
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
CONFIG_REISERFS_CHECK=y
CONFIG_REISERFS_PROC_INFO=y
# CONFIG_REISERFS_FS_XATTR is not set
CONFIG_JFS_FS=y
CONFIG_JFS_POSIX_ACL=y
CONFIG_JFS_SECURITY=y
CONFIG_JFS_DEBUG=y
# CONFIG_JFS_STATISTICS is not set
CONFIG_XFS_FS=y
# CONFIG_XFS_QUOTA is not set
# CONFIG_XFS_POSIX_ACL is not set
# CONFIG_XFS_RT is not set
CONFIG_XFS_ONLINE_SCRUB=y
CONFIG_XFS_DEBUG=y
# CONFIG_XFS_ASSERT_FATAL is not set
CONFIG_GFS2_FS=y
# CONFIG_OCFS2_FS is not set
CONFIG_BTRFS_FS=y
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
CONFIG_BTRFS_ASSERT=y
# CONFIG_BTRFS_FS_REF_VERIFY is not set
CONFIG_NILFS2_FS=y
# CONFIG_F2FS_FS is not set
# CONFIG_FS_DAX is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
# CONFIG_FS_ENCRYPTION is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
# CONFIG_PRINT_QUOTA_WARNING is not set
CONFIG_QUOTA_DEBUG=y
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS4_FS is not set
# CONFIG_FUSE_FS is not set
CONFIG_OVERLAY_FS=y
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
# CONFIG_OVERLAY_FS_INDEX is not set

#
# Caches
#
CONFIG_FSCACHE=y
CONFIG_FSCACHE_STATS=y
CONFIG_FSCACHE_HISTOGRAM=y
CONFIG_FSCACHE_DEBUG=y
# CONFIG_FSCACHE_OBJECT_LIST is not set
# CONFIG_CACHEFILES is not set

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
CONFIG_UDF_FS=y
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
# CONFIG_MSDOS_FS is not set
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_FAT_DEFAULT_UTF8 is not set
CONFIG_NTFS_FS=y
CONFIG_NTFS_DEBUG=y
CONFIG_NTFS_RW=y

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_VMCORE=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
CONFIG_AFFS_FS=y
# CONFIG_ECRYPT_FS is not set
CONFIG_HFS_FS=y
CONFIG_HFSPLUS_FS=y
CONFIG_HFSPLUS_FS_POSIX_ACL=y
CONFIG_BEFS_FS=y
CONFIG_BEFS_DEBUG=y
# CONFIG_BFS_FS is not set
CONFIG_EFS_FS=y
# CONFIG_CRAMFS is not set
CONFIG_SQUASHFS=y
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
# CONFIG_SQUASHFS_DECOMP_SINGLE is not set
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
CONFIG_SQUASHFS_XATTR=y
# CONFIG_SQUASHFS_ZLIB is not set
CONFIG_SQUASHFS_LZ4=y
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
CONFIG_SQUASHFS_ZSTD=y
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
CONFIG_SQUASHFS_EMBEDDED=y
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
CONFIG_VXFS_FS=y
CONFIG_MINIX_FS=y
CONFIG_OMFS_FS=y
CONFIG_HPFS_FS=y
# CONFIG_QNX4FS_FS is not set
CONFIG_QNX6FS_FS=y
# CONFIG_QNX6FS_DEBUG is not set
CONFIG_ROMFS_FS=y
CONFIG_ROMFS_BACKED_BY_BLOCK=y
CONFIG_ROMFS_ON_BLOCK=y
CONFIG_PSTORE=y
CONFIG_PSTORE_ZLIB_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
CONFIG_PSTORE_RAM=y
CONFIG_SYSV_FS=y
CONFIG_UFS_FS=y
CONFIG_UFS_FS_WRITE=y
CONFIG_UFS_DEBUG=y
# CONFIG_EXOFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=y
# CONFIG_NFS_SWAP is not set
# CONFIG_NFS_V4_1 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFS_FSCACHE is not set
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
# CONFIG_NFSD is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=y
CONFIG_RPCSEC_GSS_KRB5=y
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=y
# CONFIG_CIFS_STATS is not set
# CONFIG_CIFS_WEAK_PW_HASH is not set
# CONFIG_CIFS_UPCALL is not set
# CONFIG_CIFS_XATTR is not set
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
# CONFIG_CIFS_DFS_UPCALL is not set
# CONFIG_CIFS_SMB311 is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
CONFIG_NLS_CODEPAGE_775=y
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=y
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
CONFIG_NLS_CODEPAGE_860=y
CONFIG_NLS_CODEPAGE_861=y
CONFIG_NLS_CODEPAGE_862=y
# CONFIG_NLS_CODEPAGE_863 is not set
CONFIG_NLS_CODEPAGE_864=y
CONFIG_NLS_CODEPAGE_865=y
CONFIG_NLS_CODEPAGE_866=y
CONFIG_NLS_CODEPAGE_869=y
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
CONFIG_NLS_CODEPAGE_932=y
CONFIG_NLS_CODEPAGE_949=y
CONFIG_NLS_CODEPAGE_874=y
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=y
CONFIG_NLS_ASCII=y
# CONFIG_NLS_ISO8859_1 is not set
CONFIG_NLS_ISO8859_2=y
CONFIG_NLS_ISO8859_3=y
CONFIG_NLS_ISO8859_4=y
# CONFIG_NLS_ISO8859_5 is not set
CONFIG_NLS_ISO8859_6=y
# CONFIG_NLS_ISO8859_7 is not set
CONFIG_NLS_ISO8859_9=y
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=y
CONFIG_NLS_KOI8_U=y
# CONFIG_NLS_MAC_ROMAN is not set
# CONFIG_NLS_MAC_CELTIC is not set
# CONFIG_NLS_MAC_CENTEURO is not set
# CONFIG_NLS_MAC_CROATIAN is not set
CONFIG_NLS_MAC_CYRILLIC=y
CONFIG_NLS_MAC_GAELIC=y
# CONFIG_NLS_MAC_GREEK is not set
# CONFIG_NLS_MAC_ICELAND is not set
CONFIG_NLS_MAC_INUIT=y
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
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_GDB_SCRIPTS is not set
# CONFIG_ENABLE_WARN_DEPRECATED is not set
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_FRAME_WARN=1024
CONFIG_STRIP_ASM_SYMS=y
CONFIG_READABLE_ASM=y
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_PAGE_OWNER is not set
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
CONFIG_DEBUG_PAGEALLOC=y
CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT=y
CONFIG_PAGE_POISONING=y
CONFIG_PAGE_POISONING_NO_SANITY=y
CONFIG_PAGE_POISONING_ZERO=y
CONFIG_DEBUG_RODATA_TEST=y
CONFIG_DEBUG_OBJECTS=y
CONFIG_DEBUG_OBJECTS_SELFTEST=y
CONFIG_DEBUG_OBJECTS_FREE=y
# CONFIG_DEBUG_OBJECTS_TIMERS is not set
CONFIG_DEBUG_OBJECTS_WORK=y
# CONFIG_DEBUG_OBJECTS_RCU_HEAD is not set
CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=y
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_STACK_USAGE=y
CONFIG_DEBUG_VM=y
CONFIG_DEBUG_VM_VMACACHE=y
CONFIG_DEBUG_VM_RB=y
# CONFIG_DEBUG_VM_PGFLAGS is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=y
CONFIG_DEBUG_PER_CPU_MAPS=y
CONFIG_DEBUG_HIGHMEM=y
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=1
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
# CONFIG_SCHED_DEBUG is not set
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# CONFIG_SCHED_STACK_END_CHECK is not set
# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_LOCK_ALLOC=y
# CONFIG_PROVE_LOCKING is not set
CONFIG_LOCKDEP=y
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_LOCKDEP=y
CONFIG_DEBUG_ATOMIC_SLEEP=y
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
CONFIG_LOCK_TORTURE_TEST=y
CONFIG_WW_MUTEX_SELFTEST=y
CONFIG_STACKTRACE=y
CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PI_LIST=y
# CONFIG_DEBUG_SG is not set
CONFIG_DEBUG_NOTIFIERS=y
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
# CONFIG_PROVE_RCU is not set
CONFIG_TORTURE_TEST=y
# CONFIG_RCU_PERF_TEST is not set
CONFIG_RCU_TORTURE_TEST=y
CONFIG_RCU_CPU_STALL_TIMEOUT=21
# CONFIG_RCU_TRACE is not set
CONFIG_RCU_EQS_DEBUG=y
# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
CONFIG_CPU_HOTPLUG_STATE_CONTROL=y
CONFIG_NOTIFIER_ERROR_INJECTION=y
CONFIG_PM_NOTIFIER_ERROR_INJECT=y
CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT=y
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FAULT_INJECTION=y
CONFIG_FAIL_PAGE_ALLOC=y
# CONFIG_FAIL_MAKE_REQUEST is not set
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_MMC_REQUEST is not set
CONFIG_FAIL_FUTEX=y
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAULT_INJECTION_STACKTRACE_FILTER is not set
# CONFIG_LATENCYTOP is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_DMA_API_DEBUG is not set
CONFIG_RUNTIME_TESTING_MENU=y
CONFIG_LKDTM=y
CONFIG_TEST_LIST_SORT=y
CONFIG_TEST_SORT=y
# CONFIG_BACKTRACE_SELF_TEST is not set
CONFIG_RBTREE_TEST=y
# CONFIG_INTERVAL_TREE_TEST is not set
CONFIG_ATOMIC64_SELFTEST=y
# CONFIG_TEST_HEXDUMP is not set
CONFIG_TEST_STRING_HELPERS=y
# CONFIG_TEST_KSTRTOX is not set
CONFIG_TEST_PRINTF=y
# CONFIG_TEST_BITMAP is not set
CONFIG_TEST_UUID=y
CONFIG_TEST_RHASHTABLE=y
CONFIG_TEST_HASH=y
CONFIG_FIND_BIT_BENCHMARK=y
# CONFIG_TEST_FIRMWARE is not set
CONFIG_TEST_SYSCTL=y
CONFIG_TEST_UDELAY=y
# CONFIG_MEMTEST is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_ARCH_WANTS_UBSAN_NO_NULL is not set
# CONFIG_UBSAN is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_EFI=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
CONFIG_X86_PTDUMP_CORE=y
CONFIG_X86_PTDUMP=y
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_WX is not set
CONFIG_DOUBLEFAULT=y
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
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
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
# CONFIG_UNWINDER_FRAME_POINTER is not set
CONFIG_UNWINDER_GUESS=y

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_BIG_KEYS is not set
# CONFIG_TRUSTED_KEYS is not set
CONFIG_ENCRYPTED_KEYS=y
CONFIG_KEY_DH_OPERATIONS=y
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
# CONFIG_SECURITY_WRITABLE_HOOKS is not set
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
# CONFIG_SECURITY_NETWORK_XFRM is not set
# CONFIG_SECURITY_PATH is not set
# CONFIG_FORTIFY_SOURCE is not set
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
CONFIG_IMA=y
CONFIG_IMA_MEASURE_PCR_IDX=10
# CONFIG_IMA_TEMPLATE is not set
CONFIG_IMA_NG_TEMPLATE=y
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
# CONFIG_IMA_DEFAULT_HASH_SHA1 is not set
CONFIG_IMA_DEFAULT_HASH_SHA256=y
# CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
CONFIG_IMA_DEFAULT_HASH="sha256"
# CONFIG_IMA_WRITE_POLICY is not set
CONFIG_IMA_READ_POLICY=y
# CONFIG_IMA_APPRAISE is not set
CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY=y
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
CONFIG_EVM_LOAD_X509=y
CONFIG_EVM_X509_PATH="/etc/keys/x509_evm.der"
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_DEFAULT_SECURITY=""
CONFIG_XOR_BLOCKS=y
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
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=y
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_MCRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_ABLK_HELPER=y
CONFIG_CRYPTO_GLUE_HELPER_X86=y

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
# CONFIG_CRYPTO_GCM is not set
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=y
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XTS=y
CONFIG_CRYPTO_KEYWRAP=y

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_XCBC is not set
CONFIG_CRYPTO_VMAC=y

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=y
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRC32_PCLMUL=y
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
CONFIG_CRYPTO_RMD128=y
CONFIG_CRYPTO_RMD160=y
CONFIG_CRYPTO_RMD256=y
CONFIG_CRYPTO_RMD320=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=y
CONFIG_CRYPTO_TGR192=y
# CONFIG_CRYPTO_WP512 is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=y
CONFIG_CRYPTO_AES_586=y
# CONFIG_CRYPTO_AES_NI_INTEL is not set
CONFIG_CRYPTO_ANUBIS=y
CONFIG_CRYPTO_ARC4=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_DES=y
# CONFIG_CRYPTO_FCRYPT is not set
# CONFIG_CRYPTO_KHAZAD is not set
CONFIG_CRYPTO_SALSA20=y
# CONFIG_CRYPTO_SALSA20_586 is not set
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_SEED=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_586=y
# CONFIG_CRYPTO_TEA is not set
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
# CONFIG_CRYPTO_TWOFISH_586 is not set

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=y

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=y
CONFIG_CRYPTO_DEV_PADLOCK_AES=y
CONFIG_CRYPTO_DEV_PADLOCK_SHA=y
CONFIG_CRYPTO_DEV_GEODE=y
# CONFIG_CRYPTO_DEV_HIFN_795X is not set
# CONFIG_CRYPTO_DEV_FSL_CAAM_CRYPTO_API_DESC is not set
# CONFIG_CRYPTO_DEV_CCP is not set
CONFIG_CRYPTO_DEV_QAT=y
CONFIG_CRYPTO_DEV_QAT_DH895xCC=y
CONFIG_CRYPTO_DEV_QAT_C3XXX=y
# CONFIG_CRYPTO_DEV_QAT_C62X is not set
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=y
# CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
# CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
# CONFIG_CRYPTO_DEV_VIRTIO is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS7_MESSAGE_PARSER=y

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=4096
CONFIG_SECONDARY_TRUSTED_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
CONFIG_HAVE_KVM=y
# CONFIG_VIRTUALIZATION is not set
# CONFIG_BINARY_PRINTF is not set

#
# Library routines
#
CONFIG_RAID6_PQ=y
CONFIG_BITREVERSE=y
# CONFIG_HAVE_ARCH_BITREVERSE is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
CONFIG_CRC32_SARWATE=y
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC4 is not set
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
# CONFIG_AUDIT_ARCH_COMPAT_GENERIC is not set
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
# CONFIG_XZ_DEC_X86 is not set
# CONFIG_XZ_DEC_POWERPC is not set
# CONFIG_XZ_DEC_IA64 is not set
CONFIG_XZ_DEC_ARM=y
# CONFIG_XZ_DEC_ARMTHUMB is not set
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=y
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=y
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_RADIX_TREE_MULTIORDER=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_SGL_ALLOC=y
# CONFIG_DMA_DIRECT_OPS is not set
# CONFIG_DMA_VIRT_OPS is not set
CONFIG_CHECK_SIGNATURE=y
# CONFIG_CPUMASK_OFFSTACK is not set
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
CONFIG_GLOB_SELFTEST=y
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_CORDIC=y
# CONFIG_DDR is not set
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_FONT_SUPPORT=y
CONFIG_FONT_8x16=y
CONFIG_FONT_AUTOSELECT=y
# CONFIG_SG_SPLIT is not set
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_SBITMAP=y
CONFIG_PRIME_NUMBERS=y
# CONFIG_STRING_SELFTEST is not set

--fng6jrty3tbvv7s7--
