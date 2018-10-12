Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B52C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 08:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C9F920835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 08:56:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C9F920835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbeJLQ2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 12:28:14 -0400
Received: from mga07.intel.com ([134.134.136.100]:62934 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727705AbeJLQ2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 12:28:14 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Oct 2018 01:56:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,371,1534834800"; 
   d="gz'50?scan'50,208,50";a="98584917"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.6])
  by fmsmga001.fm.intel.com with ESMTP; 12 Oct 2018 01:56:45 -0700
Date:   Fri, 12 Oct 2018 16:57:06 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, LKP <lkp@01.org>
Subject: [LKP] ca90800a91 [ 9.462982] WARNING: CPU: 0 PID: 1 at
 mm/page_alloc.c:4061 __alloc_pages_nodemask
Message-ID: <20181012085706.GL13396@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="poJSiGMzRSvrLGLs"
Content-Disposition: inline
User-Agent: Heirloom mailx 12.5 6/20/10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--poJSiGMzRSvrLGLs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

commit ca90800a91ba723d78ded634d037c1d2df8b54d6
Author:     Kees Cook <keescook@chromium.org>
AuthorDate: Thu May 10 16:40:03 2018 -0700
Commit:     Kees Cook <keescook@chromium.org>
CommitDate: Tue Jun 5 12:16:51 2018 -0700

    test_overflow: Add memory allocation overflow tests
    
    Make sure that the memory allocators are behaving as expected in the face
    of overflows of multiplied arguments or when using the array_size()-family
    helpers.
    
    Example output of new tests (with the expected __alloc_pages_slowpath
    and vmalloc warnings about refusing giant allocations removed):
    
    [   93.062076] test_overflow: kmalloc detected saturation
    [   93.062988] test_overflow: kmalloc_node detected saturation
    [   93.063818] test_overflow: kzalloc detected saturation
    [   93.064539] test_overflow: kzalloc_node detected saturation
    [   93.120386] test_overflow: kvmalloc detected saturation
    [   93.143458] test_overflow: kvmalloc_node detected saturation
    [   93.166861] test_overflow: kvzalloc detected saturation
    [   93.189924] test_overflow: kvzalloc_node detected saturation
    [   93.221671] test_overflow: vmalloc detected saturation
    [   93.246326] test_overflow: vmalloc_node detected saturation
    [   93.270260] test_overflow: vzalloc detected saturation
    [   93.293824] test_overflow: vzalloc_node detected saturation
    [   93.294597] test_overflow: devm_kmalloc detected saturation
    [   93.295383] test_overflow: devm_kzalloc detected saturation
    [   93.296217] test_overflow: all tests passed
    
    Signed-off-by: Kees Cook <keescook@chromium.org>

610b15c50e  overflow.h: Add allocation size calculation helpers
ca90800a91  test_overflow: Add memory allocation overflow tests
0778a9f2dd  Merge branch 'for-4.19-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup
771b65e89c  Add linux-next specific files for 20181011
+----------------------------------------------------+------------+------------+------------+---------------+
|                                                    | 610b15c50e | ca90800a91 | 0778a9f2dd | next-20181011 |
+----------------------------------------------------+------------+------------+------------+---------------+
| boot_successes                                     | 33         | 0          | 0          | 0             |
| boot_failures                                      | 0          | 11         | 19         | 11            |
| WARNING:at_mm/page_alloc.c:#__alloc_pages_nodemask | 0          | 11         | 19         | 11            |
| EIP:__alloc_pages_nodemask                         | 0          | 11         | 19         | 11            |
| Mem-Info                                           | 0          | 11         | 19         | 11            |
+----------------------------------------------------+------------+------------+------------+---------------+

[    9.460416] test_overflow: s8 : 19 tests
[    9.460879] test_overflow: u16: 17 tests
[    9.461344] test_overflow: s16: 17 tests
[    9.461794] test_overflow: u32: 17 tests
[    9.462274] test_overflow: s32: 17 tests
[    9.462982] WARNING: CPU: 0 PID: 1 at mm/page_alloc.c:4061 __alloc_pages_nodemask+0x8df/0x13b0
[    9.463703] CPU: 0 PID: 1 Comm: swapper Not tainted 4.17.0-rc4-00006-gca90800 #2
[    9.463703] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[    9.463703] EIP: __alloc_pages_nodemask+0x8df/0x13b0
[    9.463703] EFLAGS: 00210246 CPU: 0
[    9.463703] EAX: 00000000 EBX: 78013e44 ECX: 00000000 EDX: 00000000
[    9.463703] ESI: 00000000 EDI: 00000000 EBP: 78013e8c ESP: 78013df8
[    9.463703]  DS: 007b ES: 007b FS: 0000 GS: 00e0 SS: 0068
[    9.463703] CR0: 80050033 CR2: 00000000 CR3: 0353a000 CR4: 00140690
[    9.463703] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[    9.463703] DR6: fffe0ff0 DR7: 00000400
[    9.463703] Call Trace:
[    9.463703]  ? __lock_acquire+0x362/0x12f0
[    9.463703]  ? fs_reclaim_release+0x30/0x70
[    9.463703]  ? slob_new_pages+0x22/0x70
[    9.463703]  ? __kmalloc+0xab/0x110
[    9.463703]  ? test_kmalloc+0x152/0x1d7
[    9.463703]  ? test_module_init+0x1a63/0x22ef
[    9.463703]  ? test_vzalloc_node+0x1b5/0x1b5
[    9.463703]  ? do_one_initcall+0xd8/0x28d
[    9.463703]  ? do_early_param+0x128/0x128
[    9.463703]  ? kernel_init_freeable+0x25b/0x3aa
[    9.463703]  ? rest_init+0x1f0/0x1f0
[    9.463703]  ? kernel_init+0x19/0x260
[    9.463703]  ? schedule_tail_wrapper+0x9/0xc
[    9.463703]  ? ret_from_fork+0x2e/0x38
[    9.463703] Code: 7b 00 0f 0b 81 e6 ff ff f7 ff 83 05 e8 90 bc 7b 01 83 15 ec 90 bc 7b 00 e9 6f f9 ff ff 83 05 d8 90 bc 7b 01 83 15 dc 90 bc 7b 00 <0f> 0b e9 e8 f8 ff ff 8d 76 00 8d bc 27 00 00 00 00 c7 45 a8 04 
[    9.463703] random: get_random_bytes called from init_oops_id+0x58/0x70 with crng_init=0
[    9.463703] ---[ end trace 418e45661914bb67 ]---
[    9.483371] test_overflow: kmalloc detected saturation

                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start v4.18 v4.17 --
git bisect  bad c81b995f00c7a1c2ca9ad67f5bb4a50d02f98f84  # 08:37  B      0     1   15   0  Merge branch 'perf-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect  bad 2a70ea5cda00214a1d573acf19fa0cd06d947e38  # 08:54  B      0     2   16   0  Merge tag 'hsi-for-4.18' of git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi
git bisect good 07c4dd3435aa387d3b58f4e941dc516513f14507  # 09:13  G     11     0    0   0  Merge tag 'usb-4.18-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
git bisect  bad 3036bc45364f98515a2c446d7fac2c34dcfbeff4  # 09:29  B      0     3   18   1  Merge tag 'media/v4.18-2' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
git bisect good 8450493076cd1dc8465db688f919708b5be17d46  # 09:54  G     11     0    0   0  Merge tag 'edac_for_4.18' of git://git.kernel.org/pub/scm/linux/kernel/git/bp/bp
git bisect  bad 285767604576148fc1be7fcd112e4a90eb0d6ad2  # 10:05  B      0     1   15   0  Merge tag 'overflow-v4.18-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux
git bisect good 10b1eb7d8ce5635a7deb273f8291d8a0a7681de1  # 10:27  G     11     0    0   0  Merge branch 'next-general' of git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security
git bisect good 8b5c6a3a49d9ebc7dc288870b9c56c4f946035d8  # 10:39  G     11     0    0   0  Merge tag 'audit-pr-20180605' of git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit
git bisect good 5eb6eed7e0fe880dc8de8da203cc888716bbf196  # 10:52  G     11     0    0   0  Merge tag 'trace-v4.18' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace
git bisect  bad ca90800a91ba723d78ded634d037c1d2df8b54d6  # 11:03  B      0     2   16   0  test_overflow: Add memory allocation overflow tests
git bisect good 6d3344324b5ae49fc8cb599a2c687e5607ba6e9f  # 11:25  G     11     0    0   0  test_overflow: macrofy some more, do more tests for free
git bisect good 610b15c50e86eb1e4b77274fabcaea29ac72d6a8  # 11:39  G     10     0    0   0  overflow.h: Add allocation size calculation helpers
# first bad commit: [ca90800a91ba723d78ded634d037c1d2df8b54d6] test_overflow: Add memory allocation overflow tests
git bisect good 610b15c50e86eb1e4b77274fabcaea29ac72d6a8  # 11:44  G     30     0    0   0  overflow.h: Add allocation size calculation helpers
# extra tests with debug options
git bisect  bad ca90800a91ba723d78ded634d037c1d2df8b54d6  # 12:00  B      0     4   18   0  test_overflow: Add memory allocation overflow tests
# extra tests on HEAD of linux-devel/devel-catchup-201810120513
git bisect  bad a6734b991353bf6f3d53a7be69653874a402fc58  # 12:05  B      0    19   36   0  0day head guard for 'devel-catchup-201810120513'
# extra tests on tree/branch linus/master
git bisect  bad 0778a9f2dd924c3af41971ba40eec44793aea531  # 12:17  B      0     5   19   0  Merge branch 'for-4.19-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup
# extra tests on tree/branch linux-next/master
git bisect  bad 771b65e89c8a51d611b8049718693a4202e4f732  # 12:39  B      0    11   25   0  Add linux-next specific files for 20181011

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/lkp                          Intel Corporation

--poJSiGMzRSvrLGLs
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-openwrt-lkp-hsw01-23:20181012110355:i386-randconfig-h1-10111909:4.17.0-rc4-00006-gca90800:2.gz"
Content-Transfer-Encoding: base64

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
8f8AK7DvvJc4AQA=

--poJSiGMzRSvrLGLs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reproduce-openwrt-lkp-hsw01-23:20181012110355:i386-randconfig-h1-10111909:4.17.0-rc4-00006-gca90800:2"

#!/bin/bash

kernel=$1
initrd=openwrt-trinity-i386.cgz

wget --no-clobber https://github.com/fengguang/reproduce-kernel-bug/raw/master/openwrt/$initrd

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-cpu Haswell,+smep,+smap
	-kernel $kernel
	-initrd $initrd
	-m 256
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

--poJSiGMzRSvrLGLs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-4.17.0-rc4-00006-gca90800"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 4.17.0-rc4 Kernel Configuration
#
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
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=2
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_BROKEN_ON_SMP=y
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
CONFIG_KERNEL_BZIP2=y
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
# CONFIG_SYSVIPC is not set
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_CROSS_MEMORY_ATTACH is not set
# CONFIG_USELIB is not set
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
CONFIG_GENERIC_IRQ_DEBUGFS=y
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
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
# CONFIG_NO_HZ is not set
# CONFIG_HIGH_RES_TIMERS is not set

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set

#
# RCU Subsystem
#
CONFIG_PREEMPT_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CGROUPS=y
# CONFIG_MEMCG is not set
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
# CONFIG_CFS_BANDWIDTH is not set
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_CGROUP_PIDS=y
# CONFIG_CGROUP_RDMA is not set
# CONFIG_CGROUP_FREEZER is not set
CONFIG_CGROUP_DEVICE=y
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
# CONFIG_UTS_NS is not set
# CONFIG_USER_NS is not set
# CONFIG_PID_NS is not set
CONFIG_NET_NS=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
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
CONFIG_UID16=y
CONFIG_MULTIUSER=y
# CONFIG_SGETMASK_SYSCALL is not set
# CONFIG_SYSFS_SYSCALL is not set
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_FHANDLE=y
# CONFIG_POSIX_TIMERS is not set
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
# CONFIG_PCSPKR_PLATFORM is not set
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
# CONFIG_EVENTFD is not set
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_COMPAT_BRK=y
# CONFIG_SLAB is not set
# CONFIG_SLUB is not set
CONFIG_SLOB=y
# CONFIG_SLAB_MERGE_DEFAULT is not set
# CONFIG_PROFILING is not set
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
# CONFIG_JUMP_LABEL is not set
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
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_GCC_PLUGINS=y
# CONFIG_GCC_PLUGINS is not set
CONFIG_HAVE_CC_STACKPROTECTOR=y
# CONFIG_CC_STACKPROTECTOR_NONE is not set
# CONFIG_CC_STACKPROTECTOR_REGULAR is not set
# CONFIG_CC_STACKPROTECTOR_STRONG is not set
CONFIG_CC_STACKPROTECTOR_AUTO=y
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
CONFIG_ISA_BUS_API=y
CONFIG_CLONE_BACKWARDS=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_OLD_SIGACTION=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_REFCOUNT=y
CONFIG_REFCOUNT_FULL=y

#
# GCOV-based kernel profiling
#
CONFIG_GCOV_KERNEL=y
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
CONFIG_GCOV_PROFILE_ALL=y
CONFIG_GCOV_FORMAT_AUTODETECT=y
# CONFIG_GCOV_FORMAT_3_4 is not set
# CONFIG_GCOV_FORMAT_4_7 is not set
CONFIG_HAVE_GENERIC_DMA_COHERENT=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
# CONFIG_MODULES is not set
CONFIG_MODULES_TREE_LOOKUP=y
# CONFIG_BLOCK is not set
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_FREEZER=y

#
# Processor type and features
#
# CONFIG_ZONE_DMA is not set
# CONFIG_SMP is not set
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
CONFIG_INTEL_RDT=y
# CONFIG_X86_EXTENDED_PLATFORM is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
CONFIG_IOSF_MBI_DEBUG=y
CONFIG_X86_32_IRIS=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_KVM_GUEST=y
# CONFIG_KVM_DEBUG_FS is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
CONFIG_NO_BOOTMEM=y
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
CONFIG_MEFFICEON=y
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
# CONFIG_X86_GENERIC is not set
CONFIG_X86_INTERNODE_CACHE_SHIFT=5
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
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
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_NR_CPUS_RANGE_BEGIN=1
CONFIG_NR_CPUS_RANGE_END=1
CONFIG_NR_CPUS_DEFAULT=1
CONFIG_NR_CPUS=1
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y
CONFIG_UP_LATE_INIT=y
CONFIG_X86_UP_APIC=y
# CONFIG_X86_UP_IOAPIC is not set
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
# CONFIG_X86_MCE is not set

#
# Performance monitoring
#
# CONFIG_PERF_EVENTS_INTEL_UNCORE is not set
CONFIG_PERF_EVENTS_INTEL_RAPL=y
# CONFIG_PERF_EVENTS_INTEL_CSTATE is not set
CONFIG_PERF_EVENTS_AMD_POWER=y
# CONFIG_X86_LEGACY_VM86 is not set
# CONFIG_TOSHIBA is not set
CONFIG_I8K=y
# CONFIG_X86_REBOOTFIXUPS is not set
CONFIG_MICROCODE=y
# CONFIG_MICROCODE_INTEL is not set
# CONFIG_MICROCODE_AMD is not set
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
# CONFIG_VMSPLIT_3G is not set
# CONFIG_VMSPLIT_3G_OPT is not set
# CONFIG_VMSPLIT_2G is not set
CONFIG_VMSPLIT_2G_OPT=y
# CONFIG_VMSPLIT_1G is not set
CONFIG_PAGE_OFFSET=0x78000000
CONFIG_HIGHMEM=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_HAVE_MEMBLOCK=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_HAVE_GENERIC_GUP=y
CONFIG_ARCH_DISCARD_MEMBLOCK=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_TRANSPARENT_HUGEPAGE=y
# CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
CONFIG_NEED_PER_CPU_KM=y
# CONFIG_CLEANCACHE is not set
# CONFIG_CMA is not set
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
CONFIG_Z3FOLD=y
# CONFIG_ZSMALLOC is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_FRAME_VECTOR=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_BENCHMARK is not set
# CONFIG_HIGHPTE is not set
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
# CONFIG_MTRR_SANITIZER is not set
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
# CONFIG_X86_SMAP is not set
# CONFIG_X86_INTEL_UMIP is not set
# CONFIG_EFI is not set
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_300=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=300
CONFIG_KEXEC=y
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
# CONFIG_COMPAT_VDSO is not set
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y

#
# Power management and ACPI options
#
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_PM_SLEEP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_PM_CLK=y
CONFIG_PM_GENERIC_DOMAINS=y
CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
CONFIG_PM_GENERIC_DOMAINS_SLEEP=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_TAD is not set
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_IPMI is not set
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
# CONFIG_ACPI_CONTAINER is not set
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
# CONFIG_ACPI_HED is not set
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
# CONFIG_DPTF_POWER is not set
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y
CONFIG_X86_APM_BOOT=y
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
CONFIG_APM_DO_ENABLE=y
# CONFIG_APM_CPU_IDLE is not set
# CONFIG_APM_DISPLAY_BLANK is not set
# CONFIG_APM_ALLOW_INTS is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_INTEL_IDLE is not set

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCI_CNB20LE_QUIRK=y
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCI_MSI is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_REALLOC_ENABLE_AUTO=y
CONFIG_PCI_STUB=y
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
# CONFIG_PCI_PRI is not set
CONFIG_PCI_PASID=y
CONFIG_PCI_LABEL=y
# CONFIG_HOTPLUG_PCI is not set

#
# Cadence PCIe controllers support
#

#
# DesignWare PCI Core Support
#

#
# PCI host controller drivers
#

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set

#
# PCI switch controller drivers
#
CONFIG_PCI_SW_SWITCHTEC=y
CONFIG_ISA_BUS=y
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
CONFIG_SCx200=y
CONFIG_SCx200HR_TIMER=y
# CONFIG_OLPC is not set
CONFIG_ALIX=y
# CONFIG_NET5501 is not set
# CONFIG_GEOS is not set
CONFIG_AMD_NB=y
# CONFIG_PCCARD is not set
CONFIG_RAPIDIO=y
CONFIG_RAPIDIO_DISC_TIMEOUT=30
# CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS is not set
# CONFIG_RAPIDIO_DMA_ENGINE is not set
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
CONFIG_RAPIDIO_CPS_GEN2=y
CONFIG_RAPIDIO_RXS_GEN3=y
CONFIG_X86_SYSFB=y

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_HAVE_AOUT=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_MISC=y
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
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
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
CONFIG_INET6_XFRM_MODE_TRANSPORT=y
CONFIG_INET6_XFRM_MODE_TUNNEL=y
CONFIG_INET6_XFRM_MODE_BEET=y
# CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
# CONFIG_IPV6_VTI is not set
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_NETWORK_SECMARK is not set
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
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
# CONFIG_BPF_STREAM_PARSER is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
# CONFIG_RFKILL is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_DEBUG is not set
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
CONFIG_DEVTMPFS_MOUNT=y
# CONFIG_STANDALONE is not set
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
CONFIG_WANT_DEV_COREDUMP=y
# CONFIG_ALLOW_DEV_COREDUMP is not set
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_DEVRES=y
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
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
# CONFIG_CONNECTOR is not set
CONFIG_MTD=y
# CONFIG_MTD_REDBOOT_PARTS is not set
# CONFIG_MTD_CMDLINE_PARTS is not set
CONFIG_MTD_AR7_PARTS=y

#
# Partition parsers
#

#
# User Modules And Translation Layers
#
CONFIG_MTD_OOPS=y
CONFIG_MTD_PARTITIONED_MASTER=y

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
CONFIG_MTD_JEDECPROBE=y
CONFIG_MTD_GEN_PROBE=y
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_CFI_INTELEXT=y
# CONFIG_MTD_CFI_AMDSTD is not set
CONFIG_MTD_CFI_STAA=y
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=y
# CONFIG_MTD_ROM is not set
CONFIG_MTD_ABSENT=y

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
CONFIG_MTD_PHYSMAP=y
# CONFIG_MTD_PHYSMAP_COMPAT is not set
CONFIG_MTD_SBC_GXX=y
CONFIG_MTD_SCx200_DOCFLASH=y
# CONFIG_MTD_AMD76XROM is not set
# CONFIG_MTD_ICHXROM is not set
CONFIG_MTD_ESB2ROM=y
CONFIG_MTD_CK804XROM=y
# CONFIG_MTD_SCB2_FLASH is not set
# CONFIG_MTD_NETtel is not set
CONFIG_MTD_L440GX=y
CONFIG_MTD_PCI=y
CONFIG_MTD_GPIO_ADDR=y
# CONFIG_MTD_INTEL_VR_NOR is not set
CONFIG_MTD_PLATRAM=y
# CONFIG_MTD_LATCH_ADDR is not set

#
# Self-contained MTD device drivers
#
CONFIG_MTD_PMC551=y
CONFIG_MTD_PMC551_BUGFIX=y
# CONFIG_MTD_PMC551_DEBUG is not set
# CONFIG_MTD_SLRAM is not set
CONFIG_MTD_PHRAM=y
CONFIG_MTD_MTDRAM=y
CONFIG_MTDRAM_TOTAL_SIZE=4096
CONFIG_MTDRAM_ERASE_SIZE=128

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
CONFIG_MTD_ONENAND=y
CONFIG_MTD_ONENAND_VERIFY_WRITE=y
CONFIG_MTD_ONENAND_GENERIC=y
CONFIG_MTD_ONENAND_OTP=y
CONFIG_MTD_ONENAND_2X_PROGRAM=y
CONFIG_MTD_NAND_ECC=y
CONFIG_MTD_NAND_ECC_SMC=y
CONFIG_MTD_NAND=y
# CONFIG_MTD_NAND_ECC_BCH is not set
# CONFIG_MTD_NAND_DENALI_PCI is not set
CONFIG_MTD_NAND_GPIO=y
# CONFIG_MTD_NAND_RICOH is not set
CONFIG_MTD_NAND_DISKONCHIP=y
# CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED is not set
CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=0
CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE=y
CONFIG_MTD_NAND_DOCG4=y
# CONFIG_MTD_NAND_CAFE is not set
CONFIG_MTD_NAND_CS553X=y
CONFIG_MTD_NAND_NANDSIM=y
CONFIG_MTD_NAND_PLATFORM=y

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=y
CONFIG_MTD_QINFO_PROBE=y
CONFIG_MTD_SPI_NOR=y
# CONFIG_MTD_MT81xx_NOR is not set
CONFIG_MTD_SPI_NOR_USE_4K_SECTORS=y
CONFIG_SPI_INTEL_SPI=y
CONFIG_SPI_INTEL_SPI_PCI=y
CONFIG_SPI_INTEL_SPI_PLATFORM=y
CONFIG_MTD_UBI=y
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
CONFIG_MTD_UBI_FASTMAP=y
# CONFIG_MTD_UBI_GLUEBI is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
# CONFIG_PARPORT_PC is not set
# CONFIG_PARPORT_AX88796 is not set
# CONFIG_PARPORT_1284 is not set
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y

#
# NVME Support
#

#
# Misc devices
#
CONFIG_AD525X_DPOT=y
CONFIG_AD525X_DPOT_I2C=y
CONFIG_DUMMY_IRQ=y
# CONFIG_IBM_ASM is not set
CONFIG_PHANTOM=y
# CONFIG_SGI_IOC4 is not set
CONFIG_TIFM_CORE=y
CONFIG_TIFM_7XX1=y
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=y
# CONFIG_CS5535_MFGPT is not set
CONFIG_HP_ILO=y
CONFIG_APDS9802ALS=y
# CONFIG_ISL29003 is not set
CONFIG_ISL29020=y
# CONFIG_SENSORS_TSL2550 is not set
# CONFIG_SENSORS_BH1770 is not set
CONFIG_SENSORS_APDS990X=y
CONFIG_HMC6352=y
CONFIG_DS1682=y
CONFIG_PCH_PHUB=y
CONFIG_USB_SWITCH_FSA9480=y
# CONFIG_SRAM is not set
CONFIG_PCI_ENDPOINT_TEST=y
CONFIG_MISC_RTSX=y
CONFIG_C2PORT=y
# CONFIG_C2PORT_DURAMAR_2150 is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
CONFIG_EEPROM_LEGACY=y
# CONFIG_EEPROM_MAX6875 is not set
# CONFIG_EEPROM_93CX6 is not set
CONFIG_EEPROM_IDT_89HPESX=y
CONFIG_CB710_CORE=y
CONFIG_CB710_DEBUG=y
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# CONFIG_SENSORS_LIS3_I2C is not set
CONFIG_ALTERA_STAPL=y
CONFIG_INTEL_MEI=y
CONFIG_INTEL_MEI_ME=y
CONFIG_INTEL_MEI_TXE=y
# CONFIG_VMWARE_VMCI is not set

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
CONFIG_MISC_RTSX_PCI=y
# CONFIG_MISC_RTSX_USB is not set
CONFIG_HAVE_IDE=y

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_FUSION=y
CONFIG_FUSION_MAX_SGE=128
# CONFIG_FUSION_LOGGING is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=y
CONFIG_FIREWIRE_OHCI=y
# CONFIG_FIREWIRE_NET is not set
# CONFIG_FIREWIRE_NOSY is not set
# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NTB_NETDEV is not set
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
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_PCNET32 is not set
# CONFIG_AMD_XGBE is not set
CONFIG_NET_VENDOR_AQUANTIA=y
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
CONFIG_NET_VENDOR_AURORA=y
# CONFIG_AURORA_NB8800 is not set
CONFIG_NET_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
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
CONFIG_NET_VENDOR_EXAR=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_HP=y
# CONFIG_HP100 is not set
CONFIG_NET_VENDOR_HUAWEI=y
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
# CONFIG_I40E is not set
CONFIG_NET_VENDOR_I825XX=y
# CONFIG_JME is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NET_VENDOR_NI=y
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
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
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_MDIO_DEVICE is not set
# CONFIG_PHYLIB is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_RTL8152 is not set
# CONFIG_USB_LAN78XX is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_IPHETH is not set
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

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
# CONFIG_WAN is not set
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_THUNDERBOLT_NET is not set
# CONFIG_NETDEVSIM is not set
# CONFIG_ISDN is not set

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
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=y
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ADP5520=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1070 is not set
CONFIG_KEYBOARD_QT2160=y
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
CONFIG_KEYBOARD_GPIO=y
CONFIG_KEYBOARD_GPIO_POLLED=y
CONFIG_KEYBOARD_TCA6416=y
CONFIG_KEYBOARD_TCA8418=y
CONFIG_KEYBOARD_MATRIX=y
CONFIG_KEYBOARD_LM8323=y
CONFIG_KEYBOARD_LM8333=y
CONFIG_KEYBOARD_MAX7359=y
CONFIG_KEYBOARD_MCS=y
CONFIG_KEYBOARD_MPR121=y
CONFIG_KEYBOARD_NEWTON=y
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
CONFIG_KEYBOARD_SUNKBD=y
CONFIG_KEYBOARD_TM2_TOUCHKEY=y
CONFIG_KEYBOARD_TWL4030=y
CONFIG_KEYBOARD_XTKBD=y
# CONFIG_INPUT_MOUSE is not set
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=y
CONFIG_JOYSTICK_A3D=y
CONFIG_JOYSTICK_ADI=y
CONFIG_JOYSTICK_COBRA=y
CONFIG_JOYSTICK_GF2K=y
CONFIG_JOYSTICK_GRIP=y
CONFIG_JOYSTICK_GRIP_MP=y
CONFIG_JOYSTICK_GUILLEMOT=y
# CONFIG_JOYSTICK_INTERACT is not set
# CONFIG_JOYSTICK_SIDEWINDER is not set
CONFIG_JOYSTICK_TMDC=y
CONFIG_JOYSTICK_IFORCE=y
# CONFIG_JOYSTICK_IFORCE_USB is not set
# CONFIG_JOYSTICK_IFORCE_232 is not set
CONFIG_JOYSTICK_WARRIOR=y
# CONFIG_JOYSTICK_MAGELLAN is not set
CONFIG_JOYSTICK_SPACEORB=y
CONFIG_JOYSTICK_SPACEBALL=y
# CONFIG_JOYSTICK_STINGER is not set
# CONFIG_JOYSTICK_TWIDJOY is not set
CONFIG_JOYSTICK_ZHENHUA=y
CONFIG_JOYSTICK_DB9=y
CONFIG_JOYSTICK_GAMECON=y
CONFIG_JOYSTICK_TURBOGRAFX=y
CONFIG_JOYSTICK_AS5011=y
CONFIG_JOYSTICK_JOYDUMP=y
CONFIG_JOYSTICK_XPAD=y
# CONFIG_JOYSTICK_XPAD_FF is not set
CONFIG_JOYSTICK_XPAD_LEDS=y
# CONFIG_JOYSTICK_PXRC is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=y
# CONFIG_RMI4_I2C is not set
CONFIG_RMI4_SMB=y
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
# CONFIG_RMI4_F12 is not set
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
CONFIG_RMI4_F54=y
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
CONFIG_SERIO_ALTERA_PS2=y
CONFIG_SERIO_PS2MULT=y
CONFIG_SERIO_ARC_PS2=y
# CONFIG_SERIO_GPIO_PS2 is not set
CONFIG_USERIO=y
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
CONFIG_SERIAL_NONSTANDARD=y
CONFIG_ROCKETPORT=y
# CONFIG_CYCLADES is not set
CONFIG_MOXA_INTELLIO=y
CONFIG_MOXA_SMARTIO=y
# CONFIG_SYNCLINK is not set
CONFIG_SYNCLINKMP=y
CONFIG_SYNCLINK_GT=y
CONFIG_NOZOMI=y
# CONFIG_ISI is not set
# CONFIG_N_HDLC is not set
# CONFIG_N_GSM is not set
CONFIG_TRACE_ROUTER=y
CONFIG_TRACE_SINK=y
CONFIG_DEVMEM=y
CONFIG_DEVKMEM=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
CONFIG_SERIAL_8250_FINTEK=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_PCI=y
# CONFIG_SERIAL_8250_EXAR is not set
# CONFIG_SERIAL_8250_MEN_MCB is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
# CONFIG_SERIAL_8250_SHARE_IRQ is not set
CONFIG_SERIAL_8250_DETECT_IRQ=y
# CONFIG_SERIAL_8250_RSA is not set
CONFIG_SERIAL_8250_DW=y
CONFIG_SERIAL_8250_RT288X=y
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_MOXA=y

#
# Non-8250 serial port support
#
CONFIG_SERIAL_UARTLITE=y
# CONFIG_SERIAL_UARTLITE_CONSOLE is not set
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=y
CONFIG_SERIAL_SCCNXP=y
# CONFIG_SERIAL_SCCNXP_CONSOLE is not set
CONFIG_SERIAL_SC16IS7XX=y
# CONFIG_SERIAL_SC16IS7XX_I2C is not set
CONFIG_SERIAL_TIMBERDALE=y
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_PCH_UART is not set
# CONFIG_SERIAL_ARC is not set
CONFIG_SERIAL_RP2=y
CONFIG_SERIAL_RP2_NR_UARTS=32
CONFIG_SERIAL_FSL_LPUART=y
# CONFIG_SERIAL_FSL_LPUART_CONSOLE is not set
CONFIG_SERIAL_MEN_Z135=y
CONFIG_SERIAL_DEV_BUS=y
# CONFIG_SERIAL_DEV_CTRL_TTYPORT is not set
CONFIG_TTY_PRINTK=y
CONFIG_PRINTER=y
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set
# CONFIG_VIRTIO_CONSOLE is not set
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PROC_INTERFACE=y
CONFIG_IPMI_PANIC_EVENT=y
# CONFIG_IPMI_PANIC_STRING is not set
CONFIG_IPMI_DEVICE_INTERFACE=y
CONFIG_IPMI_SI=y
CONFIG_IPMI_SSIF=y
CONFIG_IPMI_WATCHDOG=y
CONFIG_IPMI_POWEROFF=y
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=y
CONFIG_HW_RANDOM_INTEL=y
CONFIG_HW_RANDOM_AMD=y
CONFIG_HW_RANDOM_GEODE=y
CONFIG_HW_RANDOM_VIA=y
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_NVRAM is not set
CONFIG_R3964=y
CONFIG_APPLICOM=y
CONFIG_SONYPI=y
CONFIG_MWAVE=y
CONFIG_SCx200_GPIO=y
CONFIG_PC8736x_GPIO=y
CONFIG_NSC_GPIO=y
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
CONFIG_TCG_TIS_I2C_ATMEL=y
CONFIG_TCG_TIS_I2C_INFINEON=y
CONFIG_TCG_TIS_I2C_NUVOTON=y
# CONFIG_TCG_NSC is not set
# CONFIG_TCG_ATMEL is not set
# CONFIG_TCG_INFINEON is not set
# CONFIG_TCG_CRB is not set
CONFIG_TCG_VTPM_PROXY=y
CONFIG_TCG_TIS_ST33ZP24=y
CONFIG_TCG_TIS_ST33ZP24_I2C=y
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
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
CONFIG_I2C_MUX_LTC4306=y
CONFIG_I2C_MUX_PCA9541=y
# CONFIG_I2C_MUX_PCA954x is not set
CONFIG_I2C_MUX_REG=y
# CONFIG_I2C_MUX_MLXCPLD is not set
CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_ALI1535=y
CONFIG_I2C_ALI1563=y
CONFIG_I2C_ALI15X3=y
# CONFIG_I2C_AMD756 is not set
CONFIG_I2C_AMD8111=y
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=y
# CONFIG_I2C_ISMT is not set
CONFIG_I2C_PIIX4=y
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_SIS5595 is not set
CONFIG_I2C_SIS630=y
CONFIG_I2C_SIS96X=y
CONFIG_I2C_VIA=y
CONFIG_I2C_VIAPRO=y

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=y
CONFIG_I2C_DESIGNWARE_CORE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=y
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PCI=y
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
CONFIG_I2C_EG20T=y
# CONFIG_I2C_EMEV2 is not set
CONFIG_I2C_GPIO=y
# CONFIG_I2C_GPIO_FAULT_INJECTOR is not set
CONFIG_I2C_OCORES=y
# CONFIG_I2C_PCA_PLATFORM is not set
CONFIG_I2C_SIMTEC=y
CONFIG_I2C_XILINX=y

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
CONFIG_I2C_DLN2=y
# CONFIG_I2C_PARPORT is not set
CONFIG_I2C_PARPORT_LIGHT=y
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
CONFIG_I2C_TAOS_EVM=y
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_SCx200_ACB=y
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=y
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_SPI is not set
CONFIG_SPMI=y
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
# CONFIG_HSI_CHAR is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set
CONFIG_NTP_PPS=y

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=y
CONFIG_PPS_CLIENT_LDISC=y
# CONFIG_PPS_CLIENT_PARPORT is not set
CONFIG_PPS_CLIENT_GPIO=y

#
# PPS generators support
#

#
# PTP clock support
#

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# CONFIG_PTP_1588_CLOCK_PCH is not set
# CONFIG_PINCTRL is not set
CONFIG_GPIOLIB=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
CONFIG_DEBUG_GPIO=y
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
# CONFIG_GPIO_ICH is not set
# CONFIG_GPIO_LYNXPOINT is not set
CONFIG_GPIO_MB86S7X=y
CONFIG_GPIO_MENZ127=y
CONFIG_GPIO_MOCKUP=y
# CONFIG_GPIO_VX855 is not set

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
CONFIG_GPIO_IT87=y
CONFIG_GPIO_SCH=y
# CONFIG_GPIO_SCH311X is not set
CONFIG_GPIO_WINBOND=y
CONFIG_GPIO_WS16C48=y

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=y
CONFIG_GPIO_ADP5588_IRQ=y
# CONFIG_GPIO_MAX7300 is not set
CONFIG_GPIO_MAX732X=y
CONFIG_GPIO_MAX732X_IRQ=y
# CONFIG_GPIO_PCA953X is not set
CONFIG_GPIO_PCF857X=y
# CONFIG_GPIO_TPIC2810 is not set

#
# MFD GPIO expanders
#
# CONFIG_GPIO_ADP5520 is not set
# CONFIG_GPIO_ARIZONA is not set
CONFIG_GPIO_BD9571MWV=y
CONFIG_GPIO_CS5535=y
CONFIG_GPIO_DA9055=y
# CONFIG_GPIO_DLN2 is not set
CONFIG_GPIO_JANZ_TTL=y
CONFIG_GPIO_LP3943=y
# CONFIG_GPIO_LP873X is not set
# CONFIG_GPIO_PALMAS is not set
CONFIG_GPIO_RC5T583=y
# CONFIG_GPIO_TIMBERDALE is not set
CONFIG_GPIO_TPS65912=y
CONFIG_GPIO_TWL4030=y
CONFIG_GPIO_WM831X=y
# CONFIG_GPIO_WM8994 is not set

#
# PCI GPIO expanders
#
CONFIG_GPIO_AMD8111=y
CONFIG_GPIO_ML_IOH=y
CONFIG_GPIO_PCH=y
CONFIG_GPIO_PCI_IDIO_16=y
CONFIG_GPIO_PCIE_IDIO_24=y
# CONFIG_GPIO_RDC321X is not set

#
# USB GPIO expanders
#
CONFIG_W1=y

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_MATROX=y
# CONFIG_W1_MASTER_DS2490 is not set
CONFIG_W1_MASTER_DS2482=y
CONFIG_W1_MASTER_DS1WM=y
CONFIG_W1_MASTER_GPIO=y

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
# CONFIG_W1_SLAVE_SMEM is not set
CONFIG_W1_SLAVE_DS2405=y
# CONFIG_W1_SLAVE_DS2408 is not set
# CONFIG_W1_SLAVE_DS2413 is not set
CONFIG_W1_SLAVE_DS2406=y
# CONFIG_W1_SLAVE_DS2423 is not set
CONFIG_W1_SLAVE_DS2805=y
CONFIG_W1_SLAVE_DS2431=y
CONFIG_W1_SLAVE_DS2433=y
CONFIG_W1_SLAVE_DS2433_CRC=y
CONFIG_W1_SLAVE_DS2438=y
# CONFIG_W1_SLAVE_DS2760 is not set
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
# CONFIG_W1_SLAVE_DS28E04 is not set
CONFIG_W1_SLAVE_DS28E17=y
# CONFIG_POWER_AVS is not set
# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_PDA_POWER=y
CONFIG_WM831X_BACKUP=y
CONFIG_WM831X_POWER=y
# CONFIG_TEST_POWER is not set
CONFIG_BATTERY_88PM860X=y
CONFIG_BATTERY_DS2780=y
CONFIG_BATTERY_DS2781=y
CONFIG_BATTERY_DS2782=y
CONFIG_BATTERY_SBS=y
# CONFIG_CHARGER_SBS is not set
CONFIG_MANAGER_SBS=y
# CONFIG_BATTERY_BQ27XXX is not set
CONFIG_BATTERY_DA9030=y
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
CONFIG_BATTERY_MAX1721X=y
CONFIG_CHARGER_88PM860X=y
# CONFIG_CHARGER_ISP1704 is not set
# CONFIG_CHARGER_MAX8903 is not set
CONFIG_CHARGER_LP8727=y
CONFIG_CHARGER_GPIO=y
# CONFIG_CHARGER_MANAGER is not set
# CONFIG_CHARGER_LTC3651 is not set
# CONFIG_CHARGER_MAX14577 is not set
CONFIG_CHARGER_MAX77693=y
# CONFIG_CHARGER_MAX8998 is not set
CONFIG_CHARGER_BQ2415X=y
# CONFIG_CHARGER_BQ24190 is not set
CONFIG_CHARGER_BQ24257=y
CONFIG_CHARGER_BQ24735=y
# CONFIG_CHARGER_BQ25890 is not set
CONFIG_CHARGER_SMB347=y
CONFIG_CHARGER_TPS65090=y
CONFIG_BATTERY_GAUGE_LTC2941=y
# CONFIG_BATTERY_RT5033 is not set
CONFIG_CHARGER_RT9455=y
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=y
# CONFIG_SENSORS_ABITUGURU3 is not set
CONFIG_SENSORS_AD7414=y
CONFIG_SENSORS_AD7418=y
CONFIG_SENSORS_ADM1021=y
# CONFIG_SENSORS_ADM1025 is not set
CONFIG_SENSORS_ADM1026=y
CONFIG_SENSORS_ADM1029=y
CONFIG_SENSORS_ADM1031=y
# CONFIG_SENSORS_ADM9240 is not set
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7410=y
CONFIG_SENSORS_ADT7411=y
CONFIG_SENSORS_ADT7462=y
CONFIG_SENSORS_ADT7470=y
# CONFIG_SENSORS_ADT7475 is not set
CONFIG_SENSORS_ASC7621=y
CONFIG_SENSORS_K8TEMP=y
CONFIG_SENSORS_K10TEMP=y
CONFIG_SENSORS_FAM15H_POWER=y
# CONFIG_SENSORS_APPLESMC is not set
CONFIG_SENSORS_ASB100=y
CONFIG_SENSORS_ASPEED=y
# CONFIG_SENSORS_ATXP1 is not set
CONFIG_SENSORS_DS620=y
CONFIG_SENSORS_DS1621=y
CONFIG_SENSORS_DELL_SMM=y
CONFIG_SENSORS_DA9055=y
CONFIG_SENSORS_I5K_AMB=y
CONFIG_SENSORS_F71805F=y
CONFIG_SENSORS_F71882FG=y
CONFIG_SENSORS_F75375S=y
CONFIG_SENSORS_MC13783_ADC=y
# CONFIG_SENSORS_FSCHMD is not set
CONFIG_SENSORS_FTSTEUTATES=y
CONFIG_SENSORS_GL518SM=y
CONFIG_SENSORS_GL520SM=y
# CONFIG_SENSORS_G760A is not set
CONFIG_SENSORS_G762=y
CONFIG_SENSORS_HIH6130=y
CONFIG_SENSORS_IBMAEM=y
CONFIG_SENSORS_IBMPEX=y
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=y
CONFIG_SENSORS_IT87=y
CONFIG_SENSORS_JC42=y
CONFIG_SENSORS_POWR1220=y
# CONFIG_SENSORS_LINEAGE is not set
# CONFIG_SENSORS_LTC2945 is not set
CONFIG_SENSORS_LTC2990=y
CONFIG_SENSORS_LTC4151=y
CONFIG_SENSORS_LTC4215=y
# CONFIG_SENSORS_LTC4222 is not set
# CONFIG_SENSORS_LTC4245 is not set
CONFIG_SENSORS_LTC4260=y
# CONFIG_SENSORS_LTC4261 is not set
CONFIG_SENSORS_MAX16065=y
CONFIG_SENSORS_MAX1619=y
# CONFIG_SENSORS_MAX1668 is not set
# CONFIG_SENSORS_MAX197 is not set
CONFIG_SENSORS_MAX6621=y
CONFIG_SENSORS_MAX6639=y
CONFIG_SENSORS_MAX6642=y
# CONFIG_SENSORS_MAX6650 is not set
# CONFIG_SENSORS_MAX6697 is not set
# CONFIG_SENSORS_MAX31790 is not set
# CONFIG_SENSORS_MCP3021 is not set
CONFIG_SENSORS_TC654=y
# CONFIG_SENSORS_MENF21BMC_HWMON is not set
# CONFIG_SENSORS_LM63 is not set
CONFIG_SENSORS_LM73=y
CONFIG_SENSORS_LM75=y
CONFIG_SENSORS_LM77=y
CONFIG_SENSORS_LM78=y
# CONFIG_SENSORS_LM80 is not set
CONFIG_SENSORS_LM83=y
# CONFIG_SENSORS_LM85 is not set
CONFIG_SENSORS_LM87=y
CONFIG_SENSORS_LM90=y
CONFIG_SENSORS_LM92=y
CONFIG_SENSORS_LM93=y
CONFIG_SENSORS_LM95234=y
CONFIG_SENSORS_LM95241=y
# CONFIG_SENSORS_LM95245 is not set
CONFIG_SENSORS_PC87360=y
CONFIG_SENSORS_PC87427=y
CONFIG_SENSORS_NTC_THERMISTOR=y
CONFIG_SENSORS_NCT6683=y
# CONFIG_SENSORS_NCT6775 is not set
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
CONFIG_SENSORS_PCF8591=y
CONFIG_PMBUS=y
# CONFIG_SENSORS_PMBUS is not set
# CONFIG_SENSORS_ADM1275 is not set
CONFIG_SENSORS_IBM_CFFPS=y
CONFIG_SENSORS_IR35221=y
# CONFIG_SENSORS_LM25066 is not set
CONFIG_SENSORS_LTC2978=y
# CONFIG_SENSORS_LTC2978_REGULATOR is not set
# CONFIG_SENSORS_LTC3815 is not set
CONFIG_SENSORS_MAX16064=y
# CONFIG_SENSORS_MAX20751 is not set
CONFIG_SENSORS_MAX31785=y
CONFIG_SENSORS_MAX34440=y
CONFIG_SENSORS_MAX8688=y
CONFIG_SENSORS_TPS40422=y
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=y
CONFIG_SENSORS_UCD9200=y
CONFIG_SENSORS_ZL6100=y
# CONFIG_SENSORS_SHT15 is not set
# CONFIG_SENSORS_SHT21 is not set
CONFIG_SENSORS_SHT3x=y
CONFIG_SENSORS_SHTC1=y
CONFIG_SENSORS_SIS5595=y
CONFIG_SENSORS_DME1737=y
CONFIG_SENSORS_EMC1403=y
CONFIG_SENSORS_EMC2103=y
CONFIG_SENSORS_EMC6W201=y
# CONFIG_SENSORS_SMSC47M1 is not set
CONFIG_SENSORS_SMSC47M192=y
CONFIG_SENSORS_SMSC47B397=y
CONFIG_SENSORS_SCH56XX_COMMON=y
CONFIG_SENSORS_SCH5627=y
CONFIG_SENSORS_SCH5636=y
CONFIG_SENSORS_STTS751=y
CONFIG_SENSORS_SMM665=y
CONFIG_SENSORS_ADC128D818=y
# CONFIG_SENSORS_ADS1015 is not set
# CONFIG_SENSORS_ADS7828 is not set
CONFIG_SENSORS_AMC6821=y
CONFIG_SENSORS_INA209=y
CONFIG_SENSORS_INA2XX=y
CONFIG_SENSORS_INA3221=y
CONFIG_SENSORS_TC74=y
CONFIG_SENSORS_THMC50=y
CONFIG_SENSORS_TMP102=y
# CONFIG_SENSORS_TMP103 is not set
CONFIG_SENSORS_TMP108=y
CONFIG_SENSORS_TMP401=y
CONFIG_SENSORS_TMP421=y
# CONFIG_SENSORS_VIA_CPUTEMP is not set
CONFIG_SENSORS_VIA686A=y
CONFIG_SENSORS_VT1211=y
# CONFIG_SENSORS_VT8231 is not set
CONFIG_SENSORS_W83773G=y
CONFIG_SENSORS_W83781D=y
# CONFIG_SENSORS_W83791D is not set
# CONFIG_SENSORS_W83792D is not set
CONFIG_SENSORS_W83793=y
CONFIG_SENSORS_W83795=y
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=y
CONFIG_SENSORS_W83L786NG=y
CONFIG_SENSORS_W83627HF=y
# CONFIG_SENSORS_W83627EHF is not set
CONFIG_SENSORS_WM831X=y

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
# CONFIG_THERMAL_HWMON is not set
# CONFIG_THERMAL_WRITABLE_TRIPS is not set
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE=y
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_GOV_STEP_WISE is not set
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
# CONFIG_THERMAL_EMULATION is not set
CONFIG_INTEL_POWERCLAMP=y
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# CONFIG_INTEL_PCH_THERMAL is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
# CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is not set
# CONFIG_WATCHDOG_SYSFS is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=y
# CONFIG_DA9055_WATCHDOG is not set
# CONFIG_DA9062_WATCHDOG is not set
# CONFIG_MENF21BMC_WATCHDOG is not set
# CONFIG_WDAT_WDT is not set
# CONFIG_WM831X_WATCHDOG is not set
CONFIG_XILINX_WATCHDOG=y
CONFIG_ZIIRAVE_WATCHDOG=y
# CONFIG_CADENCE_WATCHDOG is not set
CONFIG_DW_WATCHDOG=y
# CONFIG_TWL4030_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
CONFIG_RETU_WATCHDOG=y
CONFIG_ACQUIRE_WDT=y
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=y
CONFIG_ALIM7101_WDT=y
CONFIG_EBC_C384_WDT=y
# CONFIG_F71808E_WDT is not set
CONFIG_SP5100_TCO=y
CONFIG_SBC_FITPC2_WATCHDOG=y
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=y
# CONFIG_IBMASR is not set
CONFIG_WAFER_WDT=y
CONFIG_I6300ESB_WDT=y
# CONFIG_IE6XX_WDT is not set
# CONFIG_ITCO_WDT is not set
# CONFIG_IT8712F_WDT is not set
CONFIG_IT87_WDT=y
# CONFIG_HP_WATCHDOG is not set
CONFIG_SC1200_WDT=y
# CONFIG_SCx200_WDT is not set
CONFIG_PC87413_WDT=y
# CONFIG_NV_TCO is not set
CONFIG_60XX_WDT=y
# CONFIG_SBC8360_WDT is not set
# CONFIG_SBC7240_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=y
CONFIG_SMSC37B787_WDT=y
CONFIG_VIA_WDT=y
CONFIG_W83627HF_WDT=y
# CONFIG_W83877F_WDT is not set
CONFIG_W83977F_WDT=y
CONFIG_MACHZ_WDT=y
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=y
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=y
CONFIG_WDTPCI=y

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=y

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
# CONFIG_SSB_PCIHOST is not set
# CONFIG_SSB_SILENT is not set
# CONFIG_SSB_DEBUG is not set
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
# CONFIG_BCMA_HOST_PCI is not set
CONFIG_BCMA_HOST_SOC=y
CONFIG_BCMA_DRIVER_PCI=y
# CONFIG_BCMA_SFLASH is not set
CONFIG_BCMA_DRIVER_GMAC_CMN=y
# CONFIG_BCMA_DRIVER_GPIO is not set
CONFIG_BCMA_DEBUG=y

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_CS5535=y
CONFIG_MFD_AS3711=y
CONFIG_PMIC_ADP5520=y
CONFIG_MFD_AAT2870_CORE=y
# CONFIG_MFD_BCM590XX is not set
CONFIG_MFD_BD9571MWV=y
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_CROS_EC is not set
CONFIG_PMIC_DA903X=y
# CONFIG_MFD_DA9052_I2C is not set
CONFIG_MFD_DA9055=y
CONFIG_MFD_DA9062=y
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
CONFIG_MFD_DLN2=y
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_I2C=y
# CONFIG_HTC_PASIC3 is not set
CONFIG_HTC_I2CPLD=y
CONFIG_MFD_INTEL_QUARK_I2C_GPIO=y
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=y
# CONFIG_INTEL_SOC_PMIC is not set
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
CONFIG_MFD_JANZ_CMODIO=y
# CONFIG_MFD_KEMPLD is not set
CONFIG_MFD_88PM800=y
CONFIG_MFD_88PM805=y
CONFIG_MFD_88PM860X=y
CONFIG_MFD_MAX14577=y
CONFIG_MFD_MAX77693=y
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
CONFIG_MFD_MAX8997=y
CONFIG_MFD_MAX8998=y
# CONFIG_MFD_MT6397 is not set
CONFIG_MFD_MENF21BMC=y
# CONFIG_MFD_VIPERBOARD is not set
CONFIG_MFD_RETU=y
# CONFIG_MFD_PCF50633 is not set
CONFIG_MFD_RDC321X=y
CONFIG_MFD_RT5033=y
CONFIG_MFD_RC5T583=y
# CONFIG_MFD_SEC_CORE is not set
CONFIG_MFD_SI476X_CORE=y
# CONFIG_MFD_SM501 is not set
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SMSC is not set
# CONFIG_ABX500_CORE is not set
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
CONFIG_MFD_LP3943=y
CONFIG_MFD_LP8788=y
CONFIG_MFD_TI_LMU=y
CONFIG_MFD_PALMAS=y
CONFIG_TPS6105X=y
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=y
# CONFIG_MFD_TPS65086 is not set
CONFIG_MFD_TPS65090=y
# CONFIG_MFD_TPS68470 is not set
CONFIG_MFD_TI_LP873X=y
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
CONFIG_MFD_TPS80031=y
CONFIG_TWL4030_CORE=y
# CONFIG_MFD_TWL4030_AUDIO is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
CONFIG_MFD_LM3533=y
CONFIG_MFD_TIMBERDALE=y
CONFIG_MFD_VX855=y
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
# CONFIG_MFD_CS47L24 is not set
CONFIG_MFD_WM5102=y
CONFIG_MFD_WM5110=y
# CONFIG_MFD_WM8997 is not set
CONFIG_MFD_WM8998=y
CONFIG_MFD_WM8400=y
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
# CONFIG_MFD_WM8350_I2C is not set
CONFIG_MFD_WM8994=y
# CONFIG_RAVE_SP_CORE is not set
CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
CONFIG_REGULATOR_88PG86X=y
CONFIG_REGULATOR_88PM800=y
CONFIG_REGULATOR_88PM8607=y
# CONFIG_REGULATOR_ACT8865 is not set
# CONFIG_REGULATOR_AD5398 is not set
CONFIG_REGULATOR_ANATOP=y
CONFIG_REGULATOR_AAT2870=y
CONFIG_REGULATOR_AS3711=y
CONFIG_REGULATOR_BD9571MWV=y
CONFIG_REGULATOR_DA903X=y
# CONFIG_REGULATOR_DA9055 is not set
# CONFIG_REGULATOR_DA9062 is not set
# CONFIG_REGULATOR_DA9210 is not set
CONFIG_REGULATOR_DA9211=y
# CONFIG_REGULATOR_FAN53555 is not set
CONFIG_REGULATOR_GPIO=y
CONFIG_REGULATOR_ISL9305=y
# CONFIG_REGULATOR_ISL6271A is not set
CONFIG_REGULATOR_LM363X=y
CONFIG_REGULATOR_LP3971=y
CONFIG_REGULATOR_LP3972=y
CONFIG_REGULATOR_LP872X=y
CONFIG_REGULATOR_LP8755=y
CONFIG_REGULATOR_LP8788=y
CONFIG_REGULATOR_LTC3589=y
CONFIG_REGULATOR_LTC3676=y
CONFIG_REGULATOR_MAX14577=y
# CONFIG_REGULATOR_MAX1586 is not set
CONFIG_REGULATOR_MAX8649=y
CONFIG_REGULATOR_MAX8660=y
CONFIG_REGULATOR_MAX8952=y
# CONFIG_REGULATOR_MAX8997 is not set
CONFIG_REGULATOR_MAX8998=y
CONFIG_REGULATOR_MAX77693=y
CONFIG_REGULATOR_MC13XXX_CORE=y
CONFIG_REGULATOR_MC13783=y
CONFIG_REGULATOR_MC13892=y
CONFIG_REGULATOR_MT6311=y
# CONFIG_REGULATOR_PALMAS is not set
CONFIG_REGULATOR_PFUZE100=y
CONFIG_REGULATOR_PV88060=y
CONFIG_REGULATOR_PV88080=y
CONFIG_REGULATOR_PV88090=y
# CONFIG_REGULATOR_PWM is not set
# CONFIG_REGULATOR_QCOM_SPMI is not set
CONFIG_REGULATOR_RC5T583=y
# CONFIG_REGULATOR_RT5033 is not set
CONFIG_REGULATOR_TPS51632=y
CONFIG_REGULATOR_TPS6105X=y
CONFIG_REGULATOR_TPS62360=y
# CONFIG_REGULATOR_TPS65023 is not set
# CONFIG_REGULATOR_TPS6507X is not set
CONFIG_REGULATOR_TPS65090=y
# CONFIG_REGULATOR_TPS65132 is not set
CONFIG_REGULATOR_TPS65912=y
# CONFIG_REGULATOR_TPS80031 is not set
# CONFIG_REGULATOR_TWL4030 is not set
CONFIG_REGULATOR_WM831X=y
CONFIG_REGULATOR_WM8400=y
# CONFIG_REGULATOR_WM8994 is not set
CONFIG_CEC_CORE=y
CONFIG_CEC_PIN=y
CONFIG_RC_CORE=y
# CONFIG_RC_MAP is not set
# CONFIG_LIRC is not set
CONFIG_RC_DECODERS=y
# CONFIG_IR_NEC_DECODER is not set
CONFIG_IR_RC5_DECODER=y
CONFIG_IR_RC6_DECODER=y
# CONFIG_IR_JVC_DECODER is not set
CONFIG_IR_SONY_DECODER=y
CONFIG_IR_SANYO_DECODER=y
CONFIG_IR_SHARP_DECODER=y
CONFIG_IR_MCE_KBD_DECODER=y
CONFIG_IR_XMP_DECODER=y
CONFIG_IR_IMON_DECODER=y
# CONFIG_RC_DEVICES is not set
CONFIG_MEDIA_SUPPORT=y

#
# Multimedia core support
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_CEC_SUPPORT=y
CONFIG_MEDIA_CEC_RC=y
# CONFIG_CEC_PIN_ERROR_INJ is not set
CONFIG_MEDIA_CONTROLLER=y
# CONFIG_MEDIA_CONTROLLER_DVB is not set
CONFIG_VIDEO_DEV=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
CONFIG_VIDEO_V4L2=y
CONFIG_VIDEO_ADV_DEBUG=y
CONFIG_VIDEO_FIXED_MINOR_RANGES=y
# CONFIG_VIDEO_PCI_SKELETON is not set
CONFIG_VIDEO_TUNER=y
CONFIG_V4L2_FLASH_LED_CLASS=y
CONFIG_V4L2_FWNODE=y
CONFIG_VIDEOBUF_GEN=y
CONFIG_VIDEOBUF_DMA_SG=y
CONFIG_VIDEOBUF_VMALLOC=y
CONFIG_VIDEOBUF_DVB=y
CONFIG_DVB_CORE=y
CONFIG_DVB_MMAP=y
CONFIG_DVB_NET=y
CONFIG_TTPCI_EEPROM=y
CONFIG_DVB_MAX_ADAPTERS=16
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
CONFIG_DVB_ULE_DEBUG=y

#
# Media drivers
#
CONFIG_MEDIA_USB_SUPPORT=y

#
# Analog TV USB devices
#
# CONFIG_VIDEO_PVRUSB2 is not set
CONFIG_VIDEO_HDPVR=y
CONFIG_VIDEO_USBVISION=y
CONFIG_VIDEO_STK1160_COMMON=y
CONFIG_VIDEO_STK1160=y

#
# Analog/digital TV USB devices
#
CONFIG_VIDEO_AU0828=y
# CONFIG_VIDEO_AU0828_V4L2 is not set
# CONFIG_VIDEO_AU0828_RC is not set
CONFIG_VIDEO_CX231XX=y
CONFIG_VIDEO_CX231XX_RC=y
CONFIG_VIDEO_CX231XX_DVB=y
CONFIG_VIDEO_TM6000=y
CONFIG_VIDEO_TM6000_DVB=y

#
# Digital TV USB devices
#
# CONFIG_DVB_USB is not set
# CONFIG_DVB_USB_V2 is not set
CONFIG_DVB_TTUSB_BUDGET=y
CONFIG_DVB_TTUSB_DEC=y
# CONFIG_SMS_USB_DRV is not set
CONFIG_DVB_B2C2_FLEXCOP_USB=y
# CONFIG_DVB_B2C2_FLEXCOP_USB_DEBUG is not set
CONFIG_DVB_AS102=y

#
# Webcam, TV (analog/digital) USB devices
#
CONFIG_VIDEO_EM28XX=y
CONFIG_VIDEO_EM28XX_V4L2=y
# CONFIG_VIDEO_EM28XX_DVB is not set
CONFIG_VIDEO_EM28XX_RC=y

#
# Software defined radio USB devices
#
CONFIG_USB_AIRSPY=y
CONFIG_USB_HACKRF=y

#
# USB HDMI CEC adapters
#
# CONFIG_USB_PULSE8_CEC is not set
CONFIG_USB_RAINSHADOW_CEC=y
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture/analog TV support
#
# CONFIG_VIDEO_IVTV is not set
CONFIG_VIDEO_HEXIUM_GEMINI=y
CONFIG_VIDEO_HEXIUM_ORION=y
CONFIG_VIDEO_MXB=y
CONFIG_VIDEO_DT3155=y

#
# Media capture/analog/hybrid TV support
#
CONFIG_VIDEO_CX18=y
# CONFIG_VIDEO_CX25821 is not set
CONFIG_VIDEO_CX88=y
CONFIG_VIDEO_CX88_BLACKBIRD=y
CONFIG_VIDEO_CX88_DVB=y
# CONFIG_VIDEO_CX88_ENABLE_VP3054 is not set
CONFIG_VIDEO_CX88_MPEG=y
CONFIG_VIDEO_BT848=y
CONFIG_DVB_BT8XX=y
CONFIG_VIDEO_SAA7134=y
# CONFIG_VIDEO_SAA7134_RC is not set
CONFIG_VIDEO_SAA7134_DVB=y
CONFIG_VIDEO_SAA7164=y

#
# Media digital TV PCI Adapters
#
CONFIG_DVB_AV7110=y
# CONFIG_DVB_AV7110_OSD is not set
CONFIG_DVB_BUDGET_CORE=y
CONFIG_DVB_BUDGET=y
CONFIG_DVB_BUDGET_CI=y
# CONFIG_DVB_BUDGET_AV is not set
CONFIG_DVB_BUDGET_PATCH=y
# CONFIG_DVB_B2C2_FLEXCOP_PCI is not set
CONFIG_DVB_PLUTO2=y
CONFIG_DVB_DM1105=y
# CONFIG_DVB_PT1 is not set
CONFIG_DVB_PT3=y
# CONFIG_MANTIS_CORE is not set
# CONFIG_DVB_NGENE is not set
CONFIG_DVB_DDBRIDGE=y
CONFIG_DVB_SMIPCIE=y
# CONFIG_VIDEO_IPU3_CIO2 is not set
CONFIG_DVB_PLATFORM_DRIVERS=y
CONFIG_CEC_PLATFORM_DRIVERS=y
CONFIG_CEC_GPIO=y
CONFIG_SDR_PLATFORM_DRIVERS=y

#
# Supported MMC/SDIO adapters
#
CONFIG_RADIO_ADAPTERS=y
CONFIG_RADIO_TEA575X=y
# CONFIG_RADIO_SI470X is not set
CONFIG_RADIO_SI4713=y
CONFIG_USB_SI4713=y
# CONFIG_PLATFORM_SI4713 is not set
CONFIG_I2C_SI4713=y
CONFIG_USB_MR800=y
CONFIG_USB_DSBR=y
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_SHARK is not set
# CONFIG_RADIO_SHARK2 is not set
CONFIG_USB_KEENE=y
CONFIG_USB_RAREMONO=y
CONFIG_USB_MA901=y
CONFIG_RADIO_TEA5764=y
CONFIG_RADIO_TEA5764_XTAL=y
CONFIG_RADIO_SAA7706H=y
CONFIG_RADIO_TEF6862=y
CONFIG_RADIO_TIMBERDALE=y
# CONFIG_RADIO_WL1273 is not set

#
# Texas Instruments WL128x FM driver (ST based)
#

#
# Supported FireWire (IEEE 1394) Adapters
#
# CONFIG_DVB_FIREDTV is not set
CONFIG_VIDEO_CX2341X=y
CONFIG_VIDEO_TVEEPROM=y
CONFIG_CYPRESS_FIRMWARE=y
CONFIG_VIDEOBUF2_CORE=y
CONFIG_VIDEOBUF2_V4L2=y
CONFIG_VIDEOBUF2_MEMOPS=y
CONFIG_VIDEOBUF2_DMA_CONTIG=y
CONFIG_VIDEOBUF2_VMALLOC=y
CONFIG_VIDEOBUF2_DMA_SG=y
CONFIG_VIDEOBUF2_DVB=y
CONFIG_DVB_B2C2_FLEXCOP=y
CONFIG_VIDEO_SAA7146=y
CONFIG_VIDEO_SAA7146_VV=y

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y
CONFIG_VIDEO_IR_I2C=y

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_TVAUDIO=y
CONFIG_VIDEO_TDA7432=y
CONFIG_VIDEO_TDA9840=y
CONFIG_VIDEO_TEA6415C=y
CONFIG_VIDEO_TEA6420=y
CONFIG_VIDEO_MSP3400=y
CONFIG_VIDEO_CS5345=y
CONFIG_VIDEO_WM8775=y

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=y

#
# Video decoders
#
CONFIG_VIDEO_SAA711X=y
CONFIG_VIDEO_TVP5150=y

#
# Video and audio decoders
#
CONFIG_VIDEO_CX25840=y

#
# Video encoders
#

#
# Camera sensor devices
#

#
# Flash devices
#

#
# Video improvement chips
#

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=y

#
# SDR tuner chips
#

#
# Miscellaneous helper chips
#

#
# Sensors used on soc_camera driver
#
CONFIG_MEDIA_TUNER=y
CONFIG_MEDIA_TUNER_SIMPLE=y
CONFIG_MEDIA_TUNER_TDA8290=y
CONFIG_MEDIA_TUNER_TDA827X=y
CONFIG_MEDIA_TUNER_TDA18271=y
CONFIG_MEDIA_TUNER_TDA9887=y
CONFIG_MEDIA_TUNER_TEA5761=y
CONFIG_MEDIA_TUNER_TEA5767=y
CONFIG_MEDIA_TUNER_MT20XX=y
CONFIG_MEDIA_TUNER_XC2028=y
CONFIG_MEDIA_TUNER_XC5000=y
CONFIG_MEDIA_TUNER_XC4000=y
CONFIG_MEDIA_TUNER_MXL5005S=y
CONFIG_MEDIA_TUNER_MXL5007T=y
CONFIG_MEDIA_TUNER_MC44S803=y
CONFIG_MEDIA_TUNER_TDA18212=y
CONFIG_MEDIA_TUNER_M88RS6000T=y
CONFIG_MEDIA_TUNER_SI2157=y
CONFIG_MEDIA_TUNER_R820T=y
CONFIG_MEDIA_TUNER_MXL301RF=y
CONFIG_MEDIA_TUNER_QM1D1C0042=y

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=y
CONFIG_DVB_STB6100=y
CONFIG_DVB_STV090x=y
CONFIG_DVB_STV0910=y
CONFIG_DVB_STV6110x=y
CONFIG_DVB_STV6111=y
CONFIG_DVB_MXL5XX=y
CONFIG_DVB_M88DS3103=y

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=y
CONFIG_DVB_TDA18271C2DD=y
CONFIG_DVB_SI2165=y
CONFIG_DVB_MN88473=y

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=y
CONFIG_DVB_CX24123=y
CONFIG_DVB_MT312=y
CONFIG_DVB_ZL10036=y
CONFIG_DVB_ZL10039=y
CONFIG_DVB_S5H1420=y
CONFIG_DVB_STV0288=y
CONFIG_DVB_STB6000=y
CONFIG_DVB_STV0299=y
CONFIG_DVB_STV0900=y
CONFIG_DVB_TDA8083=y
CONFIG_DVB_TDA10086=y
CONFIG_DVB_VES1X93=y
CONFIG_DVB_TUNER_ITD1000=y
CONFIG_DVB_TUNER_CX24113=y
CONFIG_DVB_TDA826X=y
CONFIG_DVB_CX24116=y
CONFIG_DVB_CX24120=y
CONFIG_DVB_SI21XX=y
CONFIG_DVB_TS2020=y
CONFIG_DVB_DS3000=y

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP8870=y
CONFIG_DVB_SP887X=y
CONFIG_DVB_CX22700=y
CONFIG_DVB_CX22702=y
CONFIG_DVB_L64781=y
CONFIG_DVB_TDA1004X=y
CONFIG_DVB_NXT6000=y
CONFIG_DVB_MT352=y
CONFIG_DVB_ZL10353=y
CONFIG_DVB_TDA10048=y
CONFIG_DVB_STV0367=y
CONFIG_DVB_CXD2841ER=y
CONFIG_DVB_SI2168=y
CONFIG_DVB_AS102_FE=y

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=y
CONFIG_DVB_TDA10023=y
CONFIG_DVB_STV0297=y

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=y
CONFIG_DVB_OR51211=y
CONFIG_DVB_OR51132=y
CONFIG_DVB_BCM3510=y
CONFIG_DVB_LGDT330X=y
CONFIG_DVB_LGDT3305=y
CONFIG_DVB_LGDT3306A=y
CONFIG_DVB_S5H1409=y
CONFIG_DVB_AU8522=y
CONFIG_DVB_AU8522_DTV=y
CONFIG_DVB_S5H1411=y

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_MB86A20S=y

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=y

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=y

#
# SEC control devices for DVB-S
#
CONFIG_DVB_LNBH25=y
CONFIG_DVB_LNBP21=y
CONFIG_DVB_ISL6405=y
CONFIG_DVB_ISL6421=y
CONFIG_DVB_ISL6423=y

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=y

#
# Tools to develop new frontends
#

#
# Graphics support
#
CONFIG_AGP=y
CONFIG_AGP_ALI=y
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
CONFIG_AGP_AMD64=y
CONFIG_AGP_INTEL=y
# CONFIG_AGP_NVIDIA is not set
CONFIG_AGP_SIS=y
CONFIG_AGP_SWORKS=y
# CONFIG_AGP_VIA is not set
CONFIG_AGP_EFFICEON=y
CONFIG_INTEL_GTT=y
# CONFIG_VGA_ARB is not set
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=y
CONFIG_DRM_DP_AUX_CHARDEV=y
CONFIG_DRM_DEBUG_MM=y
# CONFIG_DRM_DEBUG_MM_SELFTEST is not set
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_TTM=y
CONFIG_DRM_SCHED=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=y
CONFIG_DRM_I2C_SIL164=y
CONFIG_DRM_I2C_NXP_TDA998X=y
CONFIG_DRM_RADEON=y
CONFIG_DRM_RADEON_USERPTR=y
CONFIG_DRM_AMDGPU=y
# CONFIG_DRM_AMDGPU_SI is not set
# CONFIG_DRM_AMDGPU_CIK is not set
# CONFIG_DRM_AMDGPU_USERPTR is not set
# CONFIG_DRM_AMDGPU_GART_DEBUGFS is not set

#
# ACP (Audio CoProcessor) Configuration
#
CONFIG_DRM_AMD_ACP=y

#
# Display Engine Configuration
#
# CONFIG_DRM_AMD_DC is not set
CONFIG_DRM_AMD_DC_PRE_VEGA=y

#
# AMD Library routines
#
CONFIG_CHASH=y
# CONFIG_CHASH_STATS is not set
# CONFIG_CHASH_SELFTEST is not set
# CONFIG_DRM_NOUVEAU is not set
# CONFIG_DRM_I915 is not set
# CONFIG_DRM_VGEM is not set
# CONFIG_DRM_VMWGFX is not set
CONFIG_DRM_GMA500=y
# CONFIG_DRM_GMA600 is not set
# CONFIG_DRM_GMA3600 is not set
CONFIG_DRM_UDL=y
# CONFIG_DRM_AST is not set
# CONFIG_DRM_MGAG200 is not set
CONFIG_DRM_CIRRUS_QEMU=y
CONFIG_DRM_QXL=y
CONFIG_DRM_BOCHS=y
# CONFIG_DRM_VIRTIO_GPU is not set
CONFIG_DRM_PANEL=y

#
# Display Panels
#
CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
CONFIG_DRM_ANALOGIX_ANX78XX=y
CONFIG_DRM_HISI_HIBMC=y
# CONFIG_DRM_TINYDRM is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y

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
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_SVGALIB=y
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
CONFIG_FB_CIRRUS=y
CONFIG_FB_PM2=y
CONFIG_FB_PM2_FIFO_DISCONNECT=y
CONFIG_FB_CYBER2000=y
CONFIG_FB_CYBER2000_DDC=y
# CONFIG_FB_ARC is not set
CONFIG_FB_ASILIANT=y
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
CONFIG_FB_OPENCORES=y
# CONFIG_FB_S1D13XXX is not set
CONFIG_FB_NVIDIA=y
# CONFIG_FB_NVIDIA_I2C is not set
CONFIG_FB_NVIDIA_DEBUG=y
# CONFIG_FB_NVIDIA_BACKLIGHT is not set
CONFIG_FB_RIVA=y
CONFIG_FB_RIVA_I2C=y
# CONFIG_FB_RIVA_DEBUG is not set
CONFIG_FB_RIVA_BACKLIGHT=y
# CONFIG_FB_I740 is not set
# CONFIG_FB_I810 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_INTEL is not set
# CONFIG_FB_MATROX is not set
CONFIG_FB_RADEON=y
CONFIG_FB_RADEON_I2C=y
CONFIG_FB_RADEON_BACKLIGHT=y
CONFIG_FB_RADEON_DEBUG=y
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
CONFIG_FB_S3=y
# CONFIG_FB_S3_DDC is not set
CONFIG_FB_SAVAGE=y
# CONFIG_FB_SAVAGE_I2C is not set
CONFIG_FB_SAVAGE_ACCEL=y
CONFIG_FB_SIS=y
# CONFIG_FB_SIS_300 is not set
CONFIG_FB_SIS_315=y
CONFIG_FB_VIA=y
# CONFIG_FB_VIA_DIRECT_PROCFS is not set
CONFIG_FB_VIA_X_COMPATIBILITY=y
# CONFIG_FB_NEOMAGIC is not set
CONFIG_FB_KYRO=y
CONFIG_FB_3DFX=y
# CONFIG_FB_3DFX_ACCEL is not set
# CONFIG_FB_3DFX_I2C is not set
# CONFIG_FB_VOODOO1 is not set
CONFIG_FB_VT8623=y
CONFIG_FB_TRIDENT=y
CONFIG_FB_ARK=y
CONFIG_FB_PM3=y
CONFIG_FB_CARMINE=y
# CONFIG_FB_CARMINE_DRAM_EVAL is not set
CONFIG_CARMINE_DRAM_CUSTOM=y
CONFIG_FB_GEODE=y
CONFIG_FB_GEODE_LX=y
# CONFIG_FB_GEODE_GX is not set
CONFIG_FB_GEODE_GX1=y
# CONFIG_FB_SMSCUFX is not set
CONFIG_FB_UDL=y
CONFIG_FB_IBM_GXT4500=y
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
CONFIG_FB_MB862XX=y
CONFIG_FB_MB862XX_PCI_GDC=y
# CONFIG_FB_MB862XX_I2C is not set
CONFIG_FB_BROADSHEET=y
# CONFIG_FB_AUO_K190X is not set
# CONFIG_FB_SIMPLE is not set
CONFIG_FB_SM712=y
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_LCD_CLASS_DEVICE=y
CONFIG_LCD_PLATFORM=y
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_GENERIC=y
CONFIG_BACKLIGHT_LM3533=y
CONFIG_BACKLIGHT_PWM=y
# CONFIG_BACKLIGHT_DA903X is not set
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_PM8941_WLED=y
CONFIG_BACKLIGHT_SAHARA=y
# CONFIG_BACKLIGHT_WM831X is not set
CONFIG_BACKLIGHT_ADP5520=y
CONFIG_BACKLIGHT_ADP8860=y
CONFIG_BACKLIGHT_ADP8870=y
CONFIG_BACKLIGHT_88PM860X=y
# CONFIG_BACKLIGHT_AAT2870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
CONFIG_BACKLIGHT_LM3639=y
CONFIG_BACKLIGHT_LP855X=y
# CONFIG_BACKLIGHT_LP8788 is not set
# CONFIG_BACKLIGHT_PANDORA is not set
CONFIG_BACKLIGHT_AS3711=y
# CONFIG_BACKLIGHT_GPIO is not set
CONFIG_BACKLIGHT_LV5207LP=y
CONFIG_BACKLIGHT_BD6107=y
# CONFIG_BACKLIGHT_ARCXCNN is not set
CONFIG_VGASTATE=y
CONFIG_HDMI=y
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
# CONFIG_LOGO_LINUX_VGA16 is not set
# CONFIG_LOGO_LINUX_CLUT224 is not set
CONFIG_SOUND=y
# CONFIG_SND is not set

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
CONFIG_HIDRAW=y
CONFIG_UHID=y
# CONFIG_HID_GENERIC is not set

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
# CONFIG_HID_ACRUX is not set
# CONFIG_HID_APPLE is not set
CONFIG_HID_ASUS=y
# CONFIG_HID_AUREAL is not set
# CONFIG_HID_BELKIN is not set
CONFIG_HID_CHERRY=y
CONFIG_HID_CHICONY=y
# CONFIG_HID_CORSAIR is not set
CONFIG_HID_CMEDIA=y
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=y
CONFIG_DRAGONRISE_FF=y
CONFIG_HID_EMS_FF=y
# CONFIG_HID_ELECOM is not set
CONFIG_HID_EZKEY=y
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
CONFIG_HID_KEYTOUCH=y
CONFIG_HID_KYE=y
CONFIG_HID_WALTOP=y
CONFIG_HID_GYRATION=y
CONFIG_HID_ICADE=y
# CONFIG_HID_ITE is not set
# CONFIG_HID_JABRA is not set
# CONFIG_HID_TWINHAN is not set
CONFIG_HID_KENSINGTON=y
CONFIG_HID_LCPOWER=y
CONFIG_HID_LED=y
CONFIG_HID_LENOVO=y
CONFIG_HID_LOGITECH=y
# CONFIG_HID_LOGITECH_DJ is not set
# CONFIG_HID_LOGITECH_HIDPP is not set
# CONFIG_LOGITECH_FF is not set
CONFIG_LOGIRUMBLEPAD2_FF=y
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
CONFIG_HID_MAYFLASH=y
# CONFIG_HID_MICROSOFT is not set
CONFIG_HID_MONTEREY=y
# CONFIG_HID_MULTITOUCH is not set
CONFIG_HID_NTI=y
# CONFIG_HID_ORTEK is not set
CONFIG_HID_PANTHERLORD=y
CONFIG_PANTHERLORD_FF=y
CONFIG_HID_PETALYNX=y
CONFIG_HID_PICOLCD=y
CONFIG_HID_PICOLCD_FB=y
# CONFIG_HID_PICOLCD_BACKLIGHT is not set
CONFIG_HID_PICOLCD_LCD=y
# CONFIG_HID_PICOLCD_LEDS is not set
CONFIG_HID_PICOLCD_CIR=y
# CONFIG_HID_PLANTRONICS is not set
CONFIG_HID_PRIMAX=y
CONFIG_HID_SAITEK=y
# CONFIG_HID_SAMSUNG is not set
CONFIG_HID_SPEEDLINK=y
CONFIG_HID_STEELSERIES=y
CONFIG_HID_SUNPLUS=y
# CONFIG_HID_RMI is not set
CONFIG_HID_GREENASIA=y
CONFIG_GREENASIA_FF=y
# CONFIG_HID_SMARTJOYPLUS is not set
CONFIG_HID_TIVO=y
# CONFIG_HID_TOPSEED is not set
CONFIG_HID_THINGM=y
CONFIG_HID_THRUSTMASTER=y
# CONFIG_THRUSTMASTER_FF is not set
CONFIG_HID_UDRAW_PS3=y
CONFIG_HID_WIIMOTE=y
# CONFIG_HID_XINMO is not set
# CONFIG_HID_ZEROPLUS is not set
CONFIG_HID_ZYDACRON=y
# CONFIG_HID_SENSOR_HUB is not set
# CONFIG_HID_ALPS is not set

#
# USB HID support
#
# CONFIG_USB_HID is not set
# CONFIG_HID_PID is not set

#
# USB HID Boot Protocol drivers
#
CONFIG_USB_KBD=y
CONFIG_USB_MOUSE=y

#
# I2C HID support
#
CONFIG_I2C_HID=y
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
# CONFIG_USB_PCI is not set
# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set

#
# Miscellaneous USB options
#
# CONFIG_USB_DEFAULT_PERSIST is not set
CONFIG_USB_DYNAMIC_MINORS=y
CONFIG_USB_OTG=y
CONFIG_USB_OTG_WHITELIST=y
# CONFIG_USB_OTG_BLACKLIST_HUB is not set
CONFIG_USB_OTG_FSM=y
CONFIG_USB_MON=y
CONFIG_USB_WUSB_CBAF=y
# CONFIG_USB_WUSB_CBAF_DEBUG is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_C67X00_HCD=y
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PLATFORM=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_HCD_PLATFORM=y
CONFIG_USB_OXU210HP_HCD=y
CONFIG_USB_ISP116X_HCD=y
CONFIG_USB_FOTG210_HCD=y
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_SSB=y
CONFIG_USB_OHCI_HCD_PLATFORM=y
CONFIG_USB_SL811_HCD=y
# CONFIG_USB_SL811_HCD_ISO is not set
CONFIG_USB_R8A66597_HCD=y
CONFIG_USB_HCD_BCMA=y
CONFIG_USB_HCD_SSB=y
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=y
CONFIG_USB_PRINTER=y
# CONFIG_USB_WDM is not set
CONFIG_USB_TMC=y

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#

#
# USB Imaging devices
#
CONFIG_USB_MDC800=y
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_MUSB_HDRC is not set
CONFIG_USB_DWC3=y
CONFIG_USB_DWC3_ULPI=y
CONFIG_USB_DWC3_HOST=y

#
# Platform Glue Driver Support
#
# CONFIG_USB_DWC2 is not set
CONFIG_USB_CHIPIDEA=y
# CONFIG_USB_CHIPIDEA_HOST is not set
# CONFIG_USB_CHIPIDEA_ULPI is not set
CONFIG_USB_ISP1760=y
CONFIG_USB_ISP1760_HCD=y
CONFIG_USB_ISP1760_HOST_ROLE=y

#
# USB port drivers
#
CONFIG_USB_USS720=y
CONFIG_USB_SERIAL=y
CONFIG_USB_SERIAL_CONSOLE=y
# CONFIG_USB_SERIAL_GENERIC is not set
# CONFIG_USB_SERIAL_SIMPLE is not set
CONFIG_USB_SERIAL_AIRCABLE=y
CONFIG_USB_SERIAL_ARK3116=y
# CONFIG_USB_SERIAL_BELKIN is not set
CONFIG_USB_SERIAL_CH341=y
CONFIG_USB_SERIAL_WHITEHEAT=y
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=y
CONFIG_USB_SERIAL_CP210X=y
CONFIG_USB_SERIAL_CYPRESS_M8=y
CONFIG_USB_SERIAL_EMPEG=y
CONFIG_USB_SERIAL_FTDI_SIO=y
# CONFIG_USB_SERIAL_VISOR is not set
CONFIG_USB_SERIAL_IPAQ=y
# CONFIG_USB_SERIAL_IR is not set
CONFIG_USB_SERIAL_EDGEPORT=y
CONFIG_USB_SERIAL_EDGEPORT_TI=y
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
CONFIG_USB_SERIAL_GARMIN=y
CONFIG_USB_SERIAL_IPW=y
CONFIG_USB_SERIAL_IUU=y
CONFIG_USB_SERIAL_KEYSPAN_PDA=y
CONFIG_USB_SERIAL_KEYSPAN=y
CONFIG_USB_SERIAL_KLSI=y
CONFIG_USB_SERIAL_KOBIL_SCT=y
CONFIG_USB_SERIAL_MCT_U232=y
CONFIG_USB_SERIAL_METRO=y
CONFIG_USB_SERIAL_MOS7720=y
CONFIG_USB_SERIAL_MOS7715_PARPORT=y
# CONFIG_USB_SERIAL_MOS7840 is not set
# CONFIG_USB_SERIAL_MXUPORT is not set
CONFIG_USB_SERIAL_NAVMAN=y
# CONFIG_USB_SERIAL_PL2303 is not set
CONFIG_USB_SERIAL_OTI6858=y
CONFIG_USB_SERIAL_QCAUX=y
CONFIG_USB_SERIAL_QUALCOMM=y
# CONFIG_USB_SERIAL_SPCP8X5 is not set
CONFIG_USB_SERIAL_SAFE=y
CONFIG_USB_SERIAL_SAFE_PADDED=y
CONFIG_USB_SERIAL_SIERRAWIRELESS=y
CONFIG_USB_SERIAL_SYMBOL=y
# CONFIG_USB_SERIAL_TI is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_XIRCOM is not set
CONFIG_USB_SERIAL_WWAN=y
CONFIG_USB_SERIAL_OPTION=y
CONFIG_USB_SERIAL_OMNINET=y
# CONFIG_USB_SERIAL_OPTICON is not set
CONFIG_USB_SERIAL_XSENS_MT=y
CONFIG_USB_SERIAL_WISHBONE=y
CONFIG_USB_SERIAL_SSU100=y
# CONFIG_USB_SERIAL_QT2 is not set
CONFIG_USB_SERIAL_UPD78F0730=y
CONFIG_USB_SERIAL_DEBUG=y

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=y
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
CONFIG_USB_SEVSEG=y
# CONFIG_USB_RIO500 is not set
CONFIG_USB_LEGOTOWER=y
CONFIG_USB_LCD=y
CONFIG_USB_CYPRESS_CY7C63=y
# CONFIG_USB_CYTHERM is not set
CONFIG_USB_IDMOUSE=y
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
CONFIG_USB_SISUSBVGA=y
CONFIG_USB_LD=y
# CONFIG_USB_TRANCEVIBRATOR is not set
CONFIG_USB_IOWARRIOR=y
CONFIG_USB_TEST=y
CONFIG_USB_EHSET_TEST_FIXTURE=y
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
CONFIG_USB_EZUSB_FX2=y
CONFIG_USB_HUB_USB251XB=y
CONFIG_USB_HSIC_USB3503=y
CONFIG_USB_HSIC_USB4604=y
CONFIG_USB_LINK_LAYER_TEST=y
CONFIG_USB_CHAOSKEY=y

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
# CONFIG_NOP_USB_XCEIV is not set
CONFIG_USB_GPIO_VBUS=y
CONFIG_TAHVO_USB=y
# CONFIG_TAHVO_USB_HOST_BY_DEFAULT is not set
CONFIG_USB_ISP1301=y
# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
CONFIG_TYPEC_TCPM=y
CONFIG_TYPEC_FUSB302=y
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_ACPI is not set
# CONFIG_TYPEC_TPS6598X is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
CONFIG_TYPEC_MUX_PI3USB30532=y
# CONFIG_USB_ROLES_INTEL_XHCI is not set
CONFIG_USB_ULPI_BUS=y
CONFIG_USB_ROLE_SWITCH=y
# CONFIG_UWB is not set
# CONFIG_MMC is not set
CONFIG_MEMSTICK=y
CONFIG_MEMSTICK_DEBUG=y

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=y
# CONFIG_MEMSTICK_JMICRON_38X is not set
CONFIG_MEMSTICK_R592=y
# CONFIG_MEMSTICK_REALTEK_PCI is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
# CONFIG_LEDS_88PM860X is not set
CONFIG_LEDS_APU=y
# CONFIG_LEDS_AS3645A is not set
CONFIG_LEDS_LM3530=y
# CONFIG_LEDS_LM3533 is not set
CONFIG_LEDS_LM3642=y
CONFIG_LEDS_NET48XX=y
# CONFIG_LEDS_WRAP is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=y
CONFIG_LEDS_LP3952=y
CONFIG_LEDS_LP55XX_COMMON=y
CONFIG_LEDS_LP5521=y
# CONFIG_LEDS_LP5523 is not set
CONFIG_LEDS_LP5562=y
CONFIG_LEDS_LP8501=y
CONFIG_LEDS_LP8788=y
CONFIG_LEDS_CLEVO_MAIL=y
CONFIG_LEDS_PCA955X=y
# CONFIG_LEDS_PCA955X_GPIO is not set
CONFIG_LEDS_PCA963X=y
CONFIG_LEDS_WM831X_STATUS=y
# CONFIG_LEDS_DA903X is not set
CONFIG_LEDS_PWM=y
# CONFIG_LEDS_REGULATOR is not set
CONFIG_LEDS_BD2802=y
# CONFIG_LEDS_INTEL_SS4200 is not set
CONFIG_LEDS_LT3593=y
# CONFIG_LEDS_ADP5520 is not set
CONFIG_LEDS_MC13783=y
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_MAX8997 is not set
CONFIG_LEDS_LM355x=y
# CONFIG_LEDS_OT200 is not set
# CONFIG_LEDS_MENF21BMC is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
# CONFIG_LEDS_MLXCPLD is not set
CONFIG_LEDS_MLXREG=y
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set

#
# LED Triggers
#
# CONFIG_LEDS_TRIGGERS is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
CONFIG_EDAC_DEBUG=y
CONFIG_EDAC_AMD76X=y
CONFIG_EDAC_E7XXX=y
CONFIG_EDAC_E752X=y
CONFIG_EDAC_I82875P=y
# CONFIG_EDAC_I82975X is not set
CONFIG_EDAC_I3000=y
CONFIG_EDAC_I3200=y
# CONFIG_EDAC_IE31200 is not set
CONFIG_EDAC_X38=y
# CONFIG_EDAC_I5400 is not set
# CONFIG_EDAC_I82860 is not set
# CONFIG_EDAC_R82600 is not set
CONFIG_EDAC_I5000=y
# CONFIG_EDAC_I5100 is not set
# CONFIG_EDAC_I7300 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
CONFIG_RTC_SYSTOHC=y
CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
CONFIG_RTC_DRV_TEST=y

#
# I2C RTC drivers
#
CONFIG_RTC_DRV_88PM860X=y
# CONFIG_RTC_DRV_88PM80X is not set
CONFIG_RTC_DRV_ABB5ZES3=y
CONFIG_RTC_DRV_ABX80X=y
# CONFIG_RTC_DRV_DS1307 is not set
# CONFIG_RTC_DRV_DS1374 is not set
CONFIG_RTC_DRV_DS1672=y
CONFIG_RTC_DRV_LP8788=y
CONFIG_RTC_DRV_MAX6900=y
# CONFIG_RTC_DRV_MAX8998 is not set
CONFIG_RTC_DRV_MAX8997=y
# CONFIG_RTC_DRV_RS5C372 is not set
# CONFIG_RTC_DRV_ISL1208 is not set
# CONFIG_RTC_DRV_ISL12022 is not set
CONFIG_RTC_DRV_X1205=y
# CONFIG_RTC_DRV_PCF8523 is not set
CONFIG_RTC_DRV_PCF85063=y
CONFIG_RTC_DRV_PCF85363=y
CONFIG_RTC_DRV_PCF8563=y
CONFIG_RTC_DRV_PCF8583=y
CONFIG_RTC_DRV_M41T80=y
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=y
CONFIG_RTC_DRV_PALMAS=y
# CONFIG_RTC_DRV_TPS80031 is not set
# CONFIG_RTC_DRV_RC5T583 is not set
CONFIG_RTC_DRV_S35390A=y
CONFIG_RTC_DRV_FM3130=y
CONFIG_RTC_DRV_RX8010=y
CONFIG_RTC_DRV_RX8581=y
CONFIG_RTC_DRV_RX8025=y
CONFIG_RTC_DRV_EM3027=y
CONFIG_RTC_DRV_RV8803=y

#
# SPI RTC drivers
#
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=y
# CONFIG_RTC_DRV_DS3232_HWMON is not set
CONFIG_RTC_DRV_PCF2127=y
# CONFIG_RTC_DRV_RV3029C2 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
# CONFIG_RTC_DRV_DS1286 is not set
CONFIG_RTC_DRV_DS1511=y
CONFIG_RTC_DRV_DS1553=y
CONFIG_RTC_DRV_DS1685_FAMILY=y
CONFIG_RTC_DRV_DS1685=y
# CONFIG_RTC_DRV_DS1689 is not set
# CONFIG_RTC_DRV_DS17285 is not set
# CONFIG_RTC_DRV_DS17485 is not set
# CONFIG_RTC_DRV_DS17885 is not set
# CONFIG_RTC_DS1685_PROC_REGS is not set
# CONFIG_RTC_DS1685_SYSFS_REGS is not set
CONFIG_RTC_DRV_DS1742=y
CONFIG_RTC_DRV_DS2404=y
# CONFIG_RTC_DRV_DA9055 is not set
# CONFIG_RTC_DRV_DA9063 is not set
CONFIG_RTC_DRV_STK17TA8=y
CONFIG_RTC_DRV_M48T86=y
# CONFIG_RTC_DRV_M48T35 is not set
# CONFIG_RTC_DRV_M48T59 is not set
CONFIG_RTC_DRV_MSM6242=y
CONFIG_RTC_DRV_BQ4802=y
# CONFIG_RTC_DRV_RP5C01 is not set
# CONFIG_RTC_DRV_V3020 is not set
# CONFIG_RTC_DRV_WM831X is not set

#
# on-CPU RTC drivers
#
CONFIG_RTC_DRV_FTRTC010=y
# CONFIG_RTC_DRV_MC13XXX is not set

#
# HID Sensor RTC drivers
#
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
# CONFIG_AUXDISPLAY is not set
CONFIG_CHARLCD=y
CONFIG_PANEL=y
CONFIG_PANEL_PARPORT=0
CONFIG_PANEL_PROFILE=5
# CONFIG_PANEL_CHANGE_MESSAGE is not set
# CONFIG_UIO is not set
CONFIG_VIRT_DRIVERS=y
# CONFIG_VBOXGUEST is not set
CONFIG_VIRTIO=y
# CONFIG_VIRTIO_MENU is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# CONFIG_STAGING is not set
CONFIG_X86_PLATFORM_DEVICES=y
# CONFIG_ACER_WIRELESS is not set
# CONFIG_ACERHDF is not set
# CONFIG_ASUS_LAPTOP is not set
# CONFIG_DELL_SMBIOS is not set
# CONFIG_DELL_SMO8800 is not set
# CONFIG_FUJITSU_LAPTOP is not set
# CONFIG_FUJITSU_TABLET is not set
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_HP_ACCEL is not set
# CONFIG_HP_WIRELESS is not set
# CONFIG_PANASONIC_LAPTOP is not set
# CONFIG_THINKPAD_ACPI is not set
CONFIG_SENSORS_HDAPS=y
# CONFIG_INTEL_MENLOW is not set
# CONFIG_ASUS_WIRELESS is not set
# CONFIG_ACPI_WMI is not set
# CONFIG_TOPSTAR_LAPTOP is not set
# CONFIG_TOSHIBA_BT_RFKILL is not set
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_ACPI_CMPC is not set
# CONFIG_INTEL_CHT_INT33FE is not set
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_HID_EVENT is not set
# CONFIG_INTEL_VBTN is not set
# CONFIG_INTEL_IPS is not set
# CONFIG_INTEL_PMC_CORE is not set
CONFIG_IBM_RTL=y
CONFIG_SAMSUNG_LAPTOP=y
# CONFIG_SAMSUNG_Q10 is not set
# CONFIG_APPLE_GMUX is not set
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_PVPANIC is not set
# CONFIG_INTEL_PMC_IPC is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
# CONFIG_SURFACE_3_BUTTON is not set
CONFIG_INTEL_PUNIT_IPC=y
# CONFIG_MLX_PLATFORM is not set
CONFIG_PMC_ATOM=y
CONFIG_CHROME_PLATFORMS=y
CONFIG_CHROMEOS_LAPTOP=y
CONFIG_CHROMEOS_PSTORE=y
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
CONFIG_COMMON_CLK_WM831X=y
CONFIG_COMMON_CLK_SI5351=y
CONFIG_COMMON_CLK_SI544=y
# CONFIG_COMMON_CLK_CDCE706 is not set
CONFIG_COMMON_CLK_CS2000_CP=y
CONFIG_COMMON_CLK_PALMAS=y
CONFIG_COMMON_CLK_PWM=y
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_CLKBLD_I8253=y
CONFIG_MAILBOX=y
# CONFIG_PCC is not set
# CONFIG_ALTERA_MBOX is not set
# CONFIG_IOMMU_SUPPORT is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
# CONFIG_RPMSG_CHAR is not set
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
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
CONFIG_SOC_TI=y

#
# Xilinx SoC drivers
#
# CONFIG_XILINX_VCU is not set
# CONFIG_PM_DEVFREQ is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_GPIO=y
# CONFIG_EXTCON_INTEL_INT3496 is not set
CONFIG_EXTCON_MAX14577=y
CONFIG_EXTCON_MAX3355=y
CONFIG_EXTCON_MAX77693=y
# CONFIG_EXTCON_MAX8997 is not set
# CONFIG_EXTCON_PALMAS is not set
# CONFIG_EXTCON_RT8973A is not set
CONFIG_EXTCON_SM5502=y
# CONFIG_EXTCON_USB_GPIO is not set
CONFIG_MEMORY=y
# CONFIG_IIO is not set
CONFIG_NTB=y
CONFIG_NTB_IDT=y
CONFIG_NTB_SWITCHTEC=y
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
CONFIG_NTB_PERF=y
CONFIG_NTB_TRANSPORT=y
CONFIG_VME_BUS=y

#
# VME Bridge Drivers
#
CONFIG_VME_CA91CX42=y
# CONFIG_VME_TSI148 is not set
CONFIG_VME_FAKE=y

#
# VME Board Drivers
#
CONFIG_VMIVME_7805=y

#
# VME Device Drivers
#
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_LP3943=y
CONFIG_PWM_LPSS=y
CONFIG_PWM_LPSS_PCI=y
# CONFIG_PWM_LPSS_PLATFORM is not set
CONFIG_PWM_PCA9685=y
CONFIG_PWM_TWL=y
CONFIG_PWM_TWL_LED=y

#
# IRQ chip support
#
CONFIG_ARM_GIC_MAX_NR=1
CONFIG_IPACK_BUS=y
# CONFIG_BOARD_TPCI200 is not set
CONFIG_SERIAL_IPOCTAL=y
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_TI_SYSCON=y
CONFIG_FMC=y
CONFIG_FMC_FAKEDEV=y
# CONFIG_FMC_TRIVIAL is not set
# CONFIG_FMC_WRITE_EEPROM is not set
# CONFIG_FMC_CHARDEV is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_BCM_KONA_USB2_PHY is not set
CONFIG_PHY_PXA_28NM_HSIC=y
CONFIG_PHY_PXA_28NM_USB2=y
CONFIG_PHY_QCOM_USB_HS=y
CONFIG_PHY_QCOM_USB_HSIC=y
# CONFIG_PHY_TUSB1210 is not set
CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL=y
CONFIG_MCB=y
CONFIG_MCB_PCI=y
CONFIG_MCB_LPC=y

#
# Performance monitor support
#
CONFIG_RAS=y
CONFIG_THUNDERBOLT=y

#
# Android
#
# CONFIG_ANDROID is not set
# CONFIG_DAX is not set
CONFIG_NVMEM=y

#
# HW tracing support
#
CONFIG_STM=y
CONFIG_STM_DUMMY=y
CONFIG_STM_SOURCE_CONSOLE=y
CONFIG_STM_SOURCE_HEARTBEAT=y
CONFIG_INTEL_TH=y
CONFIG_INTEL_TH_PCI=y
# CONFIG_INTEL_TH_ACPI is not set
CONFIG_INTEL_TH_GTH=y
# CONFIG_INTEL_TH_STH is not set
# CONFIG_INTEL_TH_MSU is not set
# CONFIG_INTEL_TH_PTI is not set
# CONFIG_INTEL_TH_DEBUG is not set
CONFIG_FPGA=y
CONFIG_ALTERA_PR_IP_CORE=y
CONFIG_FPGA_MGR_ALTERA_CVP=y
CONFIG_FPGA_BRIDGE=y
CONFIG_XILINX_PR_DECOUPLER=y
CONFIG_FPGA_REGION=y
CONFIG_SIOX=y
CONFIG_SIOX_BUS_GPIO=y
CONFIG_SLIMBUS=y
# CONFIG_SLIM_QCOM_CTRL is not set

#
# Firmware Drivers
#
# CONFIG_EDD is not set
CONFIG_FIRMWARE_MEMMAP=y
# CONFIG_DELL_RBU is not set
CONFIG_DCDBAS=y
# CONFIG_DMIID is not set
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT_FIND is not set
# CONFIG_FW_CFG_SYSFS is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# Tegra firmware driver
#

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
# CONFIG_FS_ENCRYPTION is not set
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_QUOTA=y
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
# CONFIG_PRINT_QUOTA_WARNING is not set
CONFIG_QUOTA_DEBUG=y
CONFIG_QFMT_V1=y
# CONFIG_QFMT_V2 is not set
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_FUSE_FS=y
CONFIG_CUSE=y
CONFIG_OVERLAY_FS=y
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set

#
# Caches
#
CONFIG_FSCACHE=y
# CONFIG_FSCACHE_STATS is not set
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_HUGETLBFS is not set
CONFIG_CONFIGFS_FS=y
# CONFIG_MISC_FILESYSTEMS is not set
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
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=y
CONFIG_NLS_CODEPAGE_775=y
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_CODEPAGE_855=y
# CONFIG_NLS_CODEPAGE_857 is not set
CONFIG_NLS_CODEPAGE_860=y
CONFIG_NLS_CODEPAGE_861=y
CONFIG_NLS_CODEPAGE_862=y
CONFIG_NLS_CODEPAGE_863=y
CONFIG_NLS_CODEPAGE_864=y
CONFIG_NLS_CODEPAGE_865=y
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
CONFIG_NLS_CODEPAGE_950=y
CONFIG_NLS_CODEPAGE_932=y
CONFIG_NLS_CODEPAGE_949=y
CONFIG_NLS_CODEPAGE_874=y
CONFIG_NLS_ISO8859_8=y
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=y
CONFIG_NLS_ISO8859_3=y
CONFIG_NLS_ISO8859_4=y
CONFIG_NLS_ISO8859_5=y
CONFIG_NLS_ISO8859_6=y
# CONFIG_NLS_ISO8859_7 is not set
CONFIG_NLS_ISO8859_9=y
# CONFIG_NLS_ISO8859_13 is not set
CONFIG_NLS_ISO8859_14=y
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=y
CONFIG_NLS_KOI8_U=y
# CONFIG_NLS_MAC_ROMAN is not set
CONFIG_NLS_MAC_CELTIC=y
CONFIG_NLS_MAC_CENTEURO=y
CONFIG_NLS_MAC_CROATIAN=y
CONFIG_NLS_MAC_CYRILLIC=y
# CONFIG_NLS_MAC_GAELIC is not set
CONFIG_NLS_MAC_GREEK=y
# CONFIG_NLS_MAC_ICELAND is not set
CONFIG_NLS_MAC_INUIT=y
CONFIG_NLS_MAC_ROMANIAN=y
CONFIG_NLS_MAC_TURKISH=y
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
CONFIG_DYNAMIC_DEBUG=y

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
CONFIG_FRAME_WARN=1024
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_READABLE_ASM is not set
CONFIG_UNUSED_SYMBOLS=y
CONFIG_PAGE_OWNER=y
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
# CONFIG_DEBUG_SECTION_MISMATCH is not set
# CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
CONFIG_FRAME_POINTER=y
CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
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
# CONFIG_PAGE_POISONING_NO_SANITY is not set
CONFIG_PAGE_POISONING_ZERO=y
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_DEBUG_OBJECTS=y
CONFIG_DEBUG_OBJECTS_SELFTEST=y
CONFIG_DEBUG_OBJECTS_FREE=y
CONFIG_DEBUG_OBJECTS_TIMERS=y
# CONFIG_DEBUG_OBJECTS_WORK is not set
CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
# CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER is not set
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_HIGHMEM is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
# CONFIG_HARDLOCKUP_DETECTOR is not set
# CONFIG_DETECT_HUNG_TASK is not set
CONFIG_WQ_WATCHDOG=y
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
# CONFIG_SCHEDSTATS is not set
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_DEBUG_TIMEKEEPING=y
# CONFIG_DEBUG_PREEMPT is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
CONFIG_DEBUG_LOCKDEP=y
CONFIG_DEBUG_ATOMIC_SLEEP=y
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
CONFIG_LOCK_TORTURE_TEST=y
CONFIG_WW_MUTEX_SELFTEST=y
CONFIG_STACKTRACE=y
CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_KOBJECT_RELEASE is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PI_LIST is not set
# CONFIG_DEBUG_SG is not set
CONFIG_DEBUG_NOTIFIERS=y
CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=y
# CONFIG_RCU_PERF_TEST is not set
CONFIG_RCU_TORTURE_TEST=y
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_TRACE=y
CONFIG_RCU_EQS_DEBUG=y
CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
CONFIG_NOTIFIER_ERROR_INJECTION=y
CONFIG_PM_NOTIFIER_ERROR_INJECT=y
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
# CONFIG_FAULT_INJECTION is not set
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
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_DMA_API_DEBUG is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_TEST_LIST_SORT is not set
CONFIG_TEST_SORT=y
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
CONFIG_INTERVAL_TREE_TEST=y
CONFIG_ATOMIC64_SELFTEST=y
# CONFIG_TEST_HEXDUMP is not set
CONFIG_TEST_STRING_HELPERS=y
# CONFIG_TEST_KSTRTOX is not set
CONFIG_TEST_PRINTF=y
CONFIG_TEST_BITMAP=y
CONFIG_TEST_UUID=y
CONFIG_TEST_OVERFLOW=y
# CONFIG_TEST_RHASHTABLE is not set
CONFIG_TEST_HASH=y
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=y
# CONFIG_TEST_SYSCTL is not set
CONFIG_TEST_UDELAY=y
# CONFIG_MEMTEST is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
# CONFIG_STRICT_DEVMEM is not set
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
# CONFIG_EARLY_PRINTK_USB_XDBC is not set
CONFIG_X86_PTDUMP_CORE=y
CONFIG_X86_PTDUMP=y
# CONFIG_DEBUG_WX is not set
CONFIG_DOUBLEFAULT=y
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
# CONFIG_IO_DELAY_0X80 is not set
CONFIG_IO_DELAY_0XED=y
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=1
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_OPTIMIZE_INLINING is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_FRAME_POINTER=y

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_BIG_KEYS is not set
# CONFIG_TRUSTED_KEYS is not set
# CONFIG_ENCRYPTED_KEYS is not set
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
# CONFIG_SECURITY is not set
CONFIG_SECURITYFS=y
# CONFIG_FORTIFY_SOURCE is not set
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_DEFAULT_SECURITY=""
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
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_MCRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_GLUE_HELPER_X86=y

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
# CONFIG_CRYPTO_CTS is not set
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=y
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=y
CONFIG_CRYPTO_VMAC=y

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
# CONFIG_CRYPTO_CRC32C_INTEL is not set
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRC32_PCLMUL=y
# CONFIG_CRYPTO_CRCT10DIF is not set
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
CONFIG_CRYPTO_RMD128=y
CONFIG_CRYPTO_RMD160=y
CONFIG_CRYPTO_RMD256=y
# CONFIG_CRYPTO_RMD320 is not set
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
# CONFIG_CRYPTO_SHA3 is not set
CONFIG_CRYPTO_SM3=y
CONFIG_CRYPTO_TGR192=y
CONFIG_CRYPTO_WP512=y

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=y
CONFIG_CRYPTO_AES_586=y
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_ANUBIS=y
CONFIG_CRYPTO_ARC4=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
# CONFIG_CRYPTO_CAMELLIA is not set
CONFIG_CRYPTO_CAST_COMMON=y
# CONFIG_CRYPTO_CAST5 is not set
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_DES=y
# CONFIG_CRYPTO_FCRYPT is not set
CONFIG_CRYPTO_KHAZAD=y
CONFIG_CRYPTO_SALSA20=y
# CONFIG_CRYPTO_SALSA20_586 is not set
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_SEED=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_586=y
CONFIG_CRYPTO_SM4=y
CONFIG_CRYPTO_SPECK=y
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_TWOFISH is not set
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_586=y

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=y
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set

#
# Random Number Generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
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
CONFIG_CRYPTO_DEV_HIFN_795X=y
# CONFIG_CRYPTO_DEV_HIFN_795X_RNG is not set
# CONFIG_CRYPTO_DEV_CCP is not set
CONFIG_CRYPTO_DEV_QAT=y
# CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
CONFIG_CRYPTO_DEV_QAT_C3XXX=y
CONFIG_CRYPTO_DEV_QAT_C62X=y
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=y
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=y
# CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
# CONFIG_CRYPTO_DEV_VIRTIO is not set
# CONFIG_ASYMMETRIC_KEY_TYPE is not set

#
# Certificates for signature checking
#
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
CONFIG_HAVE_KVM=y
# CONFIG_VIRTUALIZATION is not set

#
# Library routines
#
CONFIG_BITREVERSE=y
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
# CONFIG_CRC_T10DIF is not set
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=y
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
CONFIG_CRC32_BIT=y
CONFIG_CRC4=y
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
# CONFIG_XZ_DEC_POWERPC is not set
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
# CONFIG_XZ_DEC_ARMTHUMB is not set
# CONFIG_XZ_DEC_SPARC is not set
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_REED_SOLOMON=y
CONFIG_REED_SOLOMON_DEC16=y
CONFIG_BCH=y
CONFIG_INTERVAL_TREE=y
CONFIG_RADIX_TREE_MULTIORDER=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_SGL_ALLOC=y
CONFIG_DMA_DIRECT_OPS=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_DQL=y
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
# CONFIG_CORDIC is not set
CONFIG_DDR=y
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_OID_REGISTRY=y
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_STACKDEPOT=y
CONFIG_STRING_SELFTEST=y

--poJSiGMzRSvrLGLs--
