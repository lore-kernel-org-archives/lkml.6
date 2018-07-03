Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23D1C3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 03:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 242B421767
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 03:03:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 242B421767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753874AbeGCDDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 23:03:35 -0400
Received: from mga12.intel.com ([192.55.52.136]:23971 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753790AbeGCDDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 23:03:33 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jul 2018 20:03:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,301,1526367600"; 
   d="gz'50?scan'50,208,50";a="68193349"
Received: from keunhyun-mobl1.amr.corp.intel.com (HELO localhost) ([10.255.29.56])
  by fmsmga004.fm.intel.com with ESMTP; 02 Jul 2018 20:03:24 -0700
Date:   Tue, 3 Jul 2018 11:03:04 +0800
From:   kernel test robot <rongx.a.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        LKP <lkp@01.org>
Subject: [lkp-robot] 9a93848fe7 [    1.383411] WARNING: CPU: 0 PID: 1 at
 arch/x86/mm/dump_pagetables.c:235 note_page
Message-ID: <20180703030304.GE32173@nfs>
Reply-To: kernel test robot <lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="a+b56+3nqLzpiR9O"
Content-Disposition: inline
User-Agent: Heirloom mailx 12.5 6/20/10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a+b56+3nqLzpiR9O
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline


Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

commit 9a93848fe787a53aec404e4e00d8f7f9bbdaebb4
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Thu Feb 2 14:43:51 2017 +0100
Commit:     Ingo Molnar <mingo@kernel.org>
CommitDate: Mon Mar 27 10:20:28 2017 +0200

    x86/debug: Implement __WARN() using UD0
    
    By using "UD0" for WARN()s we remove the function call and its possible
    __FILE__ and __LINE__ immediate arguments from the instruction stream.
    
    Total image size will not change much, what we win in the instruction
    stream we'll lose because of the __bug_table entries. Still, saves on
    I$ footprint and the total image size does go down a bit.
    
          text    data       filename
      10702123    4530992    defconfig-build/vmlinux.orig
      10682460    4530992    defconfig-build/vmlinux.patched
    
    (UML didn't seem to use GENERIC_BUG at all, so remove it)
    
    Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
    Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
    Cc: Arjan van de Ven <arjan@linux.intel.com>
    Cc: Borislav Petkov <bp@alien8.de>
    Cc: Linus Torvalds <torvalds@linux-foundation.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Richard Weinberger <richard.weinberger@gmail.com>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Cc: linux-kernel@vger.kernel.org
    Signed-off-by: Ingo Molnar <mingo@kernel.org>

1fa9d67a2f  x86/ftrace: Use Makefile logic instead of #ifdef for compiling ftrace_*.o
9a93848fe7  x86/debug: Implement __WARN() using UD0
883c9ab9eb  Merge branch 'parisc-4.18-1' of git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux
e3c7283c19  Add linux-next specific files for 20180629
+-----------------------------------------------------+------------+------------+------------+---------------+
|                                                     | 1fa9d67a2f | 9a93848fe7 | 883c9ab9eb | next-20180629 |
+-----------------------------------------------------+------------+------------+------------+---------------+
| boot_successes                                      | 0          | 0          | 2          | 0             |
| boot_failures                                       | 55         | 22         | 22         | 6             |
| WARNING:at_arch/x86/mm/dump_pagetables.c:#note_page | 55         | 22         | 22         | 6             |
| EIP:note_page                                       | 0          | 22         | 22         | 6             |
| Mem-Info                                            | 0          | 0          | 1          |               |
+-----------------------------------------------------+------------+------------+------------+---------------+

[    1.379767] Write protecting the kernel text: 7716k
[    1.380913] Write protecting the kernel read-only data: 3232k
[    1.381556] NX-protecting the kernel data: 6620k
[    1.382399] x86/mm: Found insecure W+X mapping at address 400a0000/0x400a0000
[    1.382947] ------------[ cut here ]------------
[    1.383411] WARNING: CPU: 0 PID: 1 at arch/x86/mm/dump_pagetables.c:235 note_page+0x73d/0x970
[    1.384159] Modules linked in:
[    1.384461] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.11.0-rc3-00046-g9a93848 #58
[    1.385012] task: 4f43c000 task.stack: 4f43e000
[    1.385611] EIP: note_page+0x73d/0x970
[    1.386058] EFLAGS: 00210216 CPU: 0
[    1.386490] EAX: 00000041 EBX: 4f43ff40 ECX: 00000228 EDX: 00000000
[    1.387184] ESI: 80000000 EDI: 00000000 EBP: 4f43ff10 ESP: 4f43fed8
[    1.387897]  DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
[    1.388523] CR0: 80050033 CR2: 00000000 CR3: 09070000 CR4: 001406b0
[    1.389239] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[    1.389938] DR6: fffe0ff0 DR7: 00000400
[    1.390390] Call Trace:
[    1.390679]  ? preempt_schedule_common+0x48/0x60
[    1.391217]  ptdump_walk_pgd_level_core+0x36e/0x4a0
[    1.391773]  ptdump_walk_pgd_level_checkwx+0x16/0x20
[    1.392354]  mark_rodata_ro+0xed/0x110
[    1.392780]  ? rest_init+0xb0/0xb0
[    1.393219]  kernel_init+0x2c/0x100
[    1.393628]  ? rest_init+0xb0/0xb0
[    1.394018]  ret_from_fork+0x21/0x2c
[    1.394451] Code: 00 00 00 b8 a0 54 f6 48 c6 05 44 df ec 48 01 e8 3a ab 0e 00 8b 43 0c c7 04 24 60 0f dd 48 89 44 24 08 89 44 24 04 e8 81 93 12 00 <0f> ff 31 c9 ba 01 00 00 00 c7 04 24 01 00 00 00 b8 88 54 f6 48
[    1.396683] ---[ end trace b027e07a36e0a3c3 ]---
[    1.397351] x86/mm: Checked W+X mappings: FAILED, 96 W+X pages found.

                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start v4.12 v4.11 --
git bisect  bad f3926e4c2a4b53c25a998de168d4eef6d0360369  # 17:32  B      0     1   19   4  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs
git bisect  bad 677375cef8cb7763ef620e007873117b9bad72a0  # 17:44  B      0     3   26   9  Merge tag 'fscrypt_for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tytso/fscrypt
git bisect  bad 76f1948a79b26d5f57a5ee9941876b745c6baaea  # 17:53  B      0     5   22   3  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/jikos/livepatching
git bisect good 3dee9fb2a4ced89a13a4d4b72b0b7360b701e566  # 18:10  G     11     0   11  11  Merge branch 'ras-core-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect  bad ceb198bb007b84ead867e87a71ffe715c4412b15  # 18:17  B      0     3   18   1  Merge tag 'm68k-for-v4.12-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k
git bisect  bad 2cc12e2e8cb65aec9a95a3d3de4d70e7b6b8c881  # 18:31  B      0     1   26  11  Merge branch 'x86-cleanups-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 12ca7c8db30d36e0ba1d00d17fc8c85f9ebfdf47  # 18:43  G     10     0   10  21  Merge branch 'x86-apic-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect  bad 3fb9268e43e7ab62adb5c6ddec58d3cb4767bd9a  # 18:49  B      0     1   17   2  Merge branch 'x86-asm-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect  bad 19d436268dde95389c616bb3819da73f0a8b28a8  # 19:00  B      0     4   29  11  debug: Add _ONCE() logic to report_bug()
git bisect good 3d82c59c6e3cb168284d9b0a1143415d9c98ae40  # 19:12  G     11     0   11  22  x86/ftrace: Move the ftrace specific code out of entry_32.S
git bisect good 644e0e8dc76b919976c44d3929164d42cbe656bc  # 19:21  G     10     0   10  20  x86/ftrace: Add -mfentry support to x86_32 with DYNAMIC_FTRACE set
git bisect  bad 9a93848fe787a53aec404e4e00d8f7f9bbdaebb4  # 19:30  B      0     2   19   3  x86/debug: Implement __WARN() using UD0
git bisect good 1fa9d67a2f07893fc7e4a880867a6cbb81dda547  # 19:44  G     11     0   11  22  x86/ftrace: Use Makefile logic instead of #ifdef for compiling ftrace_*.o
# first bad commit: [9a93848fe787a53aec404e4e00d8f7f9bbdaebb4] x86/debug: Implement __WARN() using UD0
git bisect good 1fa9d67a2f07893fc7e4a880867a6cbb81dda547  # 19:56  G     32     0   32  54  x86/ftrace: Use Makefile logic instead of #ifdef for compiling ftrace_*.o
# extra tests on HEAD of linux-review/Gilad-Ben-Yossef/crypto-fixes-and-cleanups/20180701-151201
git bisect  bad 23cd9451ea539e87729209bcd994945f9a797f7a  # 19:57  B      0    13   33   2  crypto: ccree: rate limit debug print
# extra tests on tree/branch linus/master
git bisect  bad 883c9ab9eb595f8542d01e55d29a346c8d96862e  # 20:02  B      0     1   24   9  Merge branch 'parisc-4.18-1' of git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux
# extra tests on tree/branch linux-next/master
git bisect  bad e3c7283c19cd9ba999794f38007389ac83408a78  # 20:20  B      0     2   16   0  Add linux-next specific files for 20180629

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/lkp                          Intel Corporation

--a+b56+3nqLzpiR9O
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-openwrt-lkp-hsw01-82:20180701193109:i386-randconfig-a0-201826:4.11.0-rc3-00046-g9a93848:58.gz"
Content-Transfer-Encoding: base64

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

--a+b56+3nqLzpiR9O
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-openwrt-lkp-nhm-dp2-14:20180701193921:i386-randconfig-a0-201826:4.11.0-rc3-00045-g1fa9d67:60.gz"
Content-Transfer-Encoding: base64

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

--a+b56+3nqLzpiR9O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reproduce-openwrt-lkp-hsw01-82:20180701193109:i386-randconfig-a0-201826:4.11.0-rc3-00046-g9a93848:58"

#!/bin/bash

kernel=$1
initrd=openwrt-trinity-i386.cgz

wget --no-clobber https://github.com/fengguang/reproduce-kernel-bug/raw/master/openwrt/$initrd

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-cpu Haswell,+smep
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

--a+b56+3nqLzpiR9O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-4.11.0-rc3-00046-g9a93848"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 4.11.0-rc3 Kernel Configuration
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
CONFIG_NEED_DMA_MAP_STATE=y
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
CONFIG_PGTABLE_LEVELS=3
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
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
CONFIG_KERNEL_LZ4=y
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_CROSS_MEMORY_ATTACH is not set
CONFIG_FHANDLE=y
# CONFIG_USELIB is not set
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
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
CONFIG_NO_HZ=y
# CONFIG_HIGH_RES_TIMERS is not set

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
# CONFIG_TASKSTATS is not set

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_FANOUT=32
CONFIG_RCU_FANOUT_LEAF=16
CONFIG_RCU_FAST_NO_HZ=y
# CONFIG_TREE_RCU_TRACE is not set
CONFIG_RCU_KTHREAD_PRIO=0
CONFIG_RCU_NOCB_CPU=y
CONFIG_RCU_NOCB_CPU_NONE=y
# CONFIG_RCU_NOCB_CPU_ZERO is not set
# CONFIG_RCU_NOCB_CPU_ALL is not set
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
# CONFIG_CGROUP_SCHED is not set
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
# CONFIG_CGROUP_FREEZER is not set
# CONFIG_CPUSETS is not set
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
# CONFIG_CGROUP_BPF is not set
CONFIG_CGROUP_DEBUG=y
# CONFIG_SOCK_CGROUP_DATA is not set
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_NAMESPACES=y
# CONFIG_UTS_NS is not set
# CONFIG_IPC_NS is not set
# CONFIG_USER_NS is not set
CONFIG_PID_NS=y
CONFIG_NET_NS=y
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
# CONFIG_RD_BZIP2 is not set
# CONFIG_RD_LZMA is not set
# CONFIG_RD_XZ is not set
# CONFIG_RD_LZO is not set
CONFIG_RD_LZ4=y
CONFIG_INITRAMFS_COMPRESSION=".gz"
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
CONFIG_SGETMASK_SYSCALL=y
# CONFIG_SYSFS_SYSCALL is not set
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_POSIX_TIMERS=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
# CONFIG_KALLSYMS_ABSOLUTE_PERCPU is not set
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
# CONFIG_ELF_CORE is not set
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_BPF_SYSCALL=y
CONFIG_SHMEM=y
# CONFIG_AIO is not set
# CONFIG_ADVISE_SYSCALLS is not set
CONFIG_USERFAULTFD=y
CONFIG_PCI_QUIRKS=y
# CONFIG_MEMBARRIER is not set
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y
CONFIG_PC104=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
CONFIG_DEBUG_PERF_USE_VMALLOC=y
# CONFIG_VM_EVENT_COUNTERS is not set
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
# CONFIG_SLUB is not set
CONFIG_SLOB=y
# CONFIG_SYSTEM_DATA_VERIFICATION is not set
# CONFIG_PROFILING is not set
CONFIG_TRACEPOINTS=y
CONFIG_KEXEC_CORE=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
CONFIG_OPTPROBES=y
# CONFIG_UPROBES is not set
# CONFIG_HAVE_64BIT_ALIGNED_ACCESS is not set
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_DMA_API_DEBUG=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_CYC_COMPLEXITY is not set
CONFIG_GCC_PLUGIN_LATENT_ENTROPY=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK is not set
CONFIG_HAVE_CC_STACKPROTECTOR=y
# CONFIG_CC_STACKPROTECTOR is not set
CONFIG_CC_STACKPROTECTOR_NONE=y
# CONFIG_CC_STACKPROTECTOR_REGULAR is not set
# CONFIG_CC_STACKPROTECTOR_STRONG is not set
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_MODULES_USE_ELF_REL=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=8
CONFIG_HAVE_COPY_THREAD_TLS=y
# CONFIG_HAVE_ARCH_HASH is not set
CONFIG_ISA_BUS_API=y
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
CONFIG_STRICT_MODULE_RWX=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
CONFIG_HAVE_GENERIC_DMA_COHERENT=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
# CONFIG_MODULE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
CONFIG_MODULES_TREE_LOOKUP=y
# CONFIG_BLOCK is not set
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
# CONFIG_FREEZER is not set

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_FAST_FEATURE_TESTS=y
# CONFIG_X86_MPPARSE is not set
# CONFIG_X86_BIGSMP is not set
CONFIG_GOLDFISH=y
# CONFIG_INTEL_RDT_A is not set
# CONFIG_X86_EXTENDED_PLATFORM is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
# CONFIG_IOSF_MBI is not set
# CONFIG_X86_32_IRIS is not set
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
CONFIG_PARAVIRT_DEBUG=y
CONFIG_PARAVIRT_SPINLOCKS=y
# CONFIG_QUEUED_LOCK_STAT is not set
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
# CONFIG_KVM_DEBUG_FS is not set
# CONFIG_LGUEST_GUEST is not set
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
# CONFIG_X86_GENERIC is not set
CONFIG_X86_INTERNODE_CACHE_SHIFT=5
CONFIG_X86_L1_CACHE_SHIFT=5
# CONFIG_X86_PPRO_FENCE is not set
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=5
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_PROCESSOR_SELECT=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_CYRIX_32=y
CONFIG_CPU_SUP_AMD=y
# CONFIG_CPU_SUP_CENTAUR is not set
CONFIG_CPU_SUP_TRANSMETA_32=y
# CONFIG_CPU_SUP_UMC_32 is not set
CONFIG_HPET_TIMER=y
# CONFIG_DMI is not set
CONFIG_SWIOTLB=y
CONFIG_IOMMU_HELPER=y
CONFIG_NR_CPUS=8
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
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
CONFIG_TOSHIBA=m
CONFIG_I8K=y
CONFIG_X86_REBOOTFIXUPS=y
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
CONFIG_X86_CPUID=m
# CONFIG_NOHIGHMEM is not set
# CONFIG_HIGHMEM4G is not set
CONFIG_HIGHMEM64G=y
# CONFIG_VMSPLIT_3G is not set
# CONFIG_VMSPLIT_2G is not set
CONFIG_VMSPLIT_1G=y
CONFIG_PAGE_OFFSET=0x40000000
CONFIG_HIGHMEM=y
CONFIG_X86_PAE=y
CONFIG_ARCH_PHYS_ADDR_T_64BIT=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
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
CONFIG_ARCH_DISCARD_MEMBLOCK=y
CONFIG_MEMORY_ISOLATION=y
# CONFIG_HAVE_BOOTMEM_INFO_NODE is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_VIRT_TO_BUS=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
CONFIG_CLEANCACHE=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
CONFIG_CMA_DEBUGFS=y
CONFIG_CMA_AREAS=7
CONFIG_ZPOOL=y
CONFIG_ZBUD=m
CONFIG_Z3FOLD=m
# CONFIG_ZSMALLOC is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT=y
# CONFIG_IDLE_PAGE_TRACKING is not set
# CONFIG_HIGHPTE is not set
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
# CONFIG_MTRR_SANITIZER is not set
# CONFIG_X86_PAT is not set
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
# CONFIG_X86_INTEL_MPX is not set
# CONFIG_EFI is not set
# CONFIG_SECCOMP is not set
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
# CONFIG_SCHED_HRTICK is not set
CONFIG_KEXEC=y
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
CONFIG_COMPAT_VDSO=y
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
# CONFIG_PM is not set
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
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
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_IPMI is not set
CONFIG_ACPI_HOTPLUG_CPU=y
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_X86_PM_TIMER=y
CONFIG_ACPI_CONTAINER=y
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
CONFIG_SFI=y

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
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=m
CONFIG_CPU_FREQ_GOV_USERSPACE=m
CONFIG_CPU_FREQ_GOV_ONDEMAND=m
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_ACPI_CPUFREQ is not set
# CONFIG_X86_POWERNOW_K6 is not set
# CONFIG_X86_POWERNOW_K7 is not set
# CONFIG_X86_GX_SUSPMOD is not set
CONFIG_X86_SPEEDSTEP_CENTRINO=m
CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE=y
# CONFIG_X86_SPEEDSTEP_ICH is not set
CONFIG_X86_SPEEDSTEP_SMI=y
CONFIG_X86_P4_CLOCKMOD=m
CONFIG_X86_CPUFREQ_NFORCE2=y
# CONFIG_X86_LONGRUN is not set
# CONFIG_X86_LONGHAUL is not set
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
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is not set
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
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCI_BUS_ADDR_T_64BIT=y
# CONFIG_PCI_MSI is not set
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
# CONFIG_PCI_STUB is not set
CONFIG_HT_IRQ=y
# CONFIG_PCI_IOV is not set
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
# CONFIG_HOTPLUG_PCI is not set

#
# DesignWare PCI Core Support
#

#
# PCI host controller drivers
#
CONFIG_ISA_BUS=y
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
CONFIG_SCx200=m
# CONFIG_SCx200HR_TIMER is not set
# CONFIG_ALIX is not set
CONFIG_NET5501=y
CONFIG_AMD_NB=y
CONFIG_PCCARD=m
# CONFIG_PCMCIA is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
# CONFIG_YENTA is not set
# CONFIG_RAPIDIO is not set
# CONFIG_X86_SYSFB is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_HAVE_AOUT=y
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_MISC=m
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
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
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
# CONFIG_NET_TCPPROBE is not set
# CONFIG_NET_DROP_MONITOR is not set
# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_IRDA is not set
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
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=y
CONFIG_FIRMWARE_IN_KERNEL=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
# CONFIG_ALLOW_DEV_COREDUMP is not set
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_TEST_ASYNC_DRIVER_PROBE=m
# CONFIG_SYS_HYPERVISOR is not set
# CONFIG_GENERIC_CPU_DEVICES is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y
CONFIG_DMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=0
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8

#
# Bus devices
#
# CONFIG_CONNECTOR is not set
CONFIG_MTD=m
CONFIG_MTD_TESTS=m
CONFIG_MTD_REDBOOT_PARTS=m
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
# CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
CONFIG_MTD_REDBOOT_PARTS_READONLY=y
CONFIG_MTD_CMDLINE_PARTS=m
# CONFIG_MTD_AR7_PARTS is not set

#
# User Modules And Translation Layers
#
# CONFIG_MTD_OOPS is not set
CONFIG_MTD_PARTITIONED_MASTER=y

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=m
CONFIG_MTD_JEDECPROBE=m
CONFIG_MTD_GEN_PROBE=m
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_CFI_I4 is not set
# CONFIG_MTD_CFI_I8 is not set
CONFIG_MTD_CFI_INTELEXT=m
CONFIG_MTD_CFI_AMDSTD=m
CONFIG_MTD_CFI_STAA=m
CONFIG_MTD_CFI_UTIL=m
CONFIG_MTD_RAM=m
CONFIG_MTD_ROM=m
CONFIG_MTD_ABSENT=m

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
CONFIG_MTD_PHYSMAP=m
CONFIG_MTD_PHYSMAP_COMPAT=y
CONFIG_MTD_PHYSMAP_START=0x8000000
CONFIG_MTD_PHYSMAP_LEN=0
CONFIG_MTD_PHYSMAP_BANKWIDTH=2
# CONFIG_MTD_SBC_GXX is not set
# CONFIG_MTD_SCx200_DOCFLASH is not set
CONFIG_MTD_AMD76XROM=m
# CONFIG_MTD_ICHXROM is not set
# CONFIG_MTD_ESB2ROM is not set
# CONFIG_MTD_CK804XROM is not set
# CONFIG_MTD_SCB2_FLASH is not set
CONFIG_MTD_NETtel=m
# CONFIG_MTD_L440GX is not set
# CONFIG_MTD_PCI is not set
# CONFIG_MTD_GPIO_ADDR is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
CONFIG_MTD_PLATRAM=m
CONFIG_MTD_LATCH_ADDR=m

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
CONFIG_MTD_DATAFLASH=m
CONFIG_MTD_DATAFLASH_WRITE_VERIFY=y
CONFIG_MTD_DATAFLASH_OTP=y
CONFIG_MTD_M25P80=m
# CONFIG_MTD_SST25L is not set
CONFIG_MTD_SLRAM=m
CONFIG_MTD_PHRAM=m
CONFIG_MTD_MTDRAM=m
CONFIG_MTDRAM_TOTAL_SIZE=4096
CONFIG_MTDRAM_ERASE_SIZE=128

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
CONFIG_MTD_NAND_ECC=m
# CONFIG_MTD_NAND_ECC_SMC is not set
CONFIG_MTD_NAND=m
CONFIG_MTD_NAND_BCH=m
CONFIG_MTD_NAND_ECC_BCH=y
# CONFIG_MTD_SM_COMMON is not set
# CONFIG_MTD_NAND_DENALI_PCI is not set
# CONFIG_MTD_NAND_GPIO is not set
# CONFIG_MTD_NAND_OMAP_BCH_BUILD is not set
CONFIG_MTD_NAND_IDS=m
# CONFIG_MTD_NAND_RICOH is not set
CONFIG_MTD_NAND_DISKONCHIP=m
# CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED is not set
CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=0
CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE=y
CONFIG_MTD_NAND_DOCG4=m
# CONFIG_MTD_NAND_CAFE is not set
CONFIG_MTD_NAND_CS553X=m
CONFIG_MTD_NAND_NANDSIM=m
CONFIG_MTD_NAND_PLATFORM=m
# CONFIG_MTD_NAND_HISI504 is not set
# CONFIG_MTD_NAND_MTK is not set
CONFIG_MTD_ONENAND=m
# CONFIG_MTD_ONENAND_VERIFY_WRITE is not set
CONFIG_MTD_ONENAND_GENERIC=m
# CONFIG_MTD_ONENAND_OTP is not set
CONFIG_MTD_ONENAND_2X_PROGRAM=y

#
# LPDDR & LPDDR2 PCM memory drivers
#
# CONFIG_MTD_LPDDR is not set
CONFIG_MTD_SPI_NOR=m
# CONFIG_MTD_MT81xx_NOR is not set
CONFIG_MTD_SPI_NOR_USE_4K_SECTORS=y
CONFIG_SPI_INTEL_SPI=m
CONFIG_SPI_INTEL_SPI_PLATFORM=m
# CONFIG_MTD_UBI is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
# CONFIG_PARPORT is not set
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
CONFIG_AD525X_DPOT=m
CONFIG_AD525X_DPOT_I2C=m
# CONFIG_AD525X_DPOT_SPI is not set
CONFIG_DUMMY_IRQ=y
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_SGI_IOC4 is not set
# CONFIG_TIFM_CORE is not set
CONFIG_ICS932S401=y
CONFIG_ENCLOSURE_SERVICES=m
# CONFIG_HP_ILO is not set
# CONFIG_APDS9802ALS is not set
CONFIG_ISL29003=y
# CONFIG_ISL29020 is not set
CONFIG_SENSORS_TSL2550=y
CONFIG_SENSORS_BH1770=y
CONFIG_SENSORS_APDS990X=y
CONFIG_HMC6352=m
CONFIG_DS1682=m
# CONFIG_TI_DAC7512 is not set
# CONFIG_PCH_PHUB is not set
CONFIG_USB_SWITCH_FSA9480=y
CONFIG_LATTICE_ECP3_CONFIG=m
# CONFIG_SRAM is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
# CONFIG_EEPROM_MAX6875 is not set
CONFIG_EEPROM_93CX6=y
CONFIG_EEPROM_93XX46=m
CONFIG_EEPROM_IDT_89HPESX=y
# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
CONFIG_SENSORS_LIS3_I2C=y

#
# Altera FPGA firmware download module
#
CONFIG_ALTERA_STAPL=y
# CONFIG_INTEL_MEI is not set
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_VMWARE_VMCI is not set

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
CONFIG_HAVE_IDE=y

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# CONFIG_SCSI_DMA is not set
# CONFIG_SCSI_NETLINK is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=y
# CONFIG_FIREWIRE_OHCI is not set
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
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
# CONFIG_NLMON is not set
# CONFIG_ARCNET is not set

#
# CAIF transport drivers
#

#
# Distributed Switch Architecture drivers
#
CONFIG_ETHERNET=y
CONFIG_MDIO=m
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
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=m
CONFIG_E1000E_HWTS=y
CONFIG_IGB=m
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=m
CONFIG_IXGBE_HWMON=y
# CONFIG_I40E is not set
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
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETRONOME=y
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
CONFIG_NET_VENDOR_REALTEK=y
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
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_PHYLIB is not set
# CONFIG_MICREL_KS8995MA is not set
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

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
# CONFIG_WAN is not set
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=m
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=y
# CONFIG_INPUT_SPARSEKMAP is not set
CONFIG_INPUT_MATRIXKMAP=y

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
CONFIG_INPUT_JOYDEV=y
CONFIG_INPUT_EVDEV=m
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
# CONFIG_KEYBOARD_ADP5588 is not set
CONFIG_KEYBOARD_ADP5589=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1070 is not set
CONFIG_KEYBOARD_QT2160=m
CONFIG_KEYBOARD_LKKBD=y
CONFIG_KEYBOARD_GPIO=y
# CONFIG_KEYBOARD_GPIO_POLLED is not set
CONFIG_KEYBOARD_TCA6416=y
CONFIG_KEYBOARD_TCA8418=m
CONFIG_KEYBOARD_MATRIX=y
CONFIG_KEYBOARD_LM8323=y
# CONFIG_KEYBOARD_LM8333 is not set
CONFIG_KEYBOARD_MAX7359=m
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
CONFIG_KEYBOARD_NEWTON=m
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
CONFIG_KEYBOARD_GOLDFISH_EVENTS=m
# CONFIG_KEYBOARD_STOWAWAY is not set
CONFIG_KEYBOARD_SUNKBD=m
CONFIG_KEYBOARD_TM2_TOUCHKEY=y
CONFIG_KEYBOARD_XTKBD=m
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
CONFIG_INPUT_TABLET=y
# CONFIG_TABLET_USB_ACECAD is not set
# CONFIG_TABLET_USB_AIPTEK is not set
# CONFIG_TABLET_USB_HANWANG is not set
# CONFIG_TABLET_USB_KBTAB is not set
# CONFIG_TABLET_USB_PEGASUS is not set
# CONFIG_TABLET_SERIAL_WACOM4 is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
# CONFIG_RMI4_CORE is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=m
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_SERIO_ALTERA_PS2 is not set
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
# CONFIG_CYCLADES is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
# CONFIG_SYNCLINK is not set
# CONFIG_SYNCLINKMP is not set
# CONFIG_SYNCLINK_GT is not set
# CONFIG_NOZOMI is not set
# CONFIG_ISI is not set
# CONFIG_N_HDLC is not set
# CONFIG_N_GSM is not set
CONFIG_TRACE_ROUTER=y
CONFIG_TRACE_SINK=y
# CONFIG_GOLDFISH_TTY is not set
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
# CONFIG_SERIAL_8250_DMA is not set
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
# CONFIG_SERIAL_8250_SHARE_IRQ is not set
CONFIG_SERIAL_8250_DETECT_IRQ=y
# CONFIG_SERIAL_8250_RSA is not set
# CONFIG_SERIAL_8250_FSL is not set
CONFIG_SERIAL_8250_DW=y
CONFIG_SERIAL_8250_RT288X=y
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_8250_MOXA is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
CONFIG_SERIAL_UARTLITE=m
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SCCNXP is not set
CONFIG_SERIAL_SC16IS7XX=y
# CONFIG_SERIAL_SC16IS7XX_I2C is not set
# CONFIG_SERIAL_SC16IS7XX_SPI is not set
# CONFIG_SERIAL_TIMBERDALE is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
CONFIG_SERIAL_ALTERA_UART=y
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
# CONFIG_SERIAL_ALTERA_UART_CONSOLE is not set
# CONFIG_SERIAL_IFX6X60 is not set
# CONFIG_SERIAL_PCH_UART is not set
CONFIG_SERIAL_ARC=y
CONFIG_SERIAL_ARC_CONSOLE=y
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
CONFIG_SERIAL_FSL_LPUART=y
# CONFIG_SERIAL_FSL_LPUART_CONSOLE is not set
CONFIG_SERIAL_DEV_BUS=y
CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
CONFIG_TTY_PRINTK=m
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_PANIC_EVENT=y
# CONFIG_IPMI_PANIC_STRING is not set
CONFIG_IPMI_DEVICE_INTERFACE=y
CONFIG_IPMI_SI=y
CONFIG_IPMI_SSIF=m
# CONFIG_IPMI_WATCHDOG is not set
CONFIG_IPMI_POWEROFF=y
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=y
CONFIG_HW_RANDOM_AMD=y
CONFIG_HW_RANDOM_GEODE=y
CONFIG_HW_RANDOM_VIA=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_NVRAM=m
CONFIG_R3964=m
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set
CONFIG_MWAVE=y
CONFIG_SCx200_GPIO=m
CONFIG_PC8736x_GPIO=m
CONFIG_NSC_GPIO=m
# CONFIG_HPET is not set
# CONFIG_HANGCHECK_TIMER is not set
CONFIG_TCG_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
CONFIG_TCG_TIS_SPI=y
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=y
# CONFIG_TCG_TIS_I2C_NUVOTON is not set
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=y
# CONFIG_TCG_INFINEON is not set
# CONFIG_TCG_CRB is not set
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=y
CONFIG_TCG_TIS_ST33ZP24_I2C=y
CONFIG_TCG_TIS_ST33ZP24_SPI=m
# CONFIG_TELCLOCK is not set
CONFIG_DEVPORT=y
# CONFIG_XILLYBUS is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_MUX_GPIO=y
CONFIG_I2C_MUX_PCA9541=y
CONFIG_I2C_MUX_PCA954x=y
# CONFIG_I2C_MUX_REG is not set
# CONFIG_I2C_MUX_MLXCPLD is not set
CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=m
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=y

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
CONFIG_I2C_CBUS_GPIO=y
CONFIG_I2C_DESIGNWARE_CORE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EG20T is not set
# CONFIG_I2C_EMEV2 is not set
CONFIG_I2C_GPIO=y
CONFIG_I2C_KEMPLD=m
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=y
# CONFIG_I2C_PXA_PCI is not set
# CONFIG_I2C_SIMTEC is not set
CONFIG_I2C_XILINX=m

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_PARPORT_LIGHT=m
# CONFIG_I2C_TAOS_EVM is not set

#
# Other I2C/SMBus bus drivers
#
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_STUB is not set
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=m
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y

#
# SPI Master Controller Drivers
#
CONFIG_SPI_ALTERA=y
# CONFIG_SPI_AXI_SPI_ENGINE is not set
CONFIG_SPI_BITBANG=y
CONFIG_SPI_CADENCE=m
CONFIG_SPI_DESIGNWARE=m
# CONFIG_SPI_DW_PCI is not set
CONFIG_SPI_DW_MMIO=m
CONFIG_SPI_GPIO=m
CONFIG_SPI_OC_TINY=y
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_PXA2XX_PCI is not set
# CONFIG_SPI_ROCKCHIP is not set
CONFIG_SPI_SC18IS602=y
# CONFIG_SPI_TOPCLIFF_PCH is not set
CONFIG_SPI_XCOMM=m
# CONFIG_SPI_XILINX is not set
CONFIG_SPI_ZYNQMP_GQSPI=m

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
CONFIG_SPI_LOOPBACK_TEST=m
CONFIG_SPI_TLE62X0=m
# CONFIG_SPMI is not set
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
CONFIG_HSI_CHAR=y

#
# PPS support
#
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=y
CONFIG_PPS_CLIENT_LDISC=y
# CONFIG_PPS_CLIENT_GPIO is not set

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=m

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# CONFIG_PTP_1588_CLOCK_PCH is not set
CONFIG_PTP_1588_CLOCK_KVM=m
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
# CONFIG_GPIO_AXP209 is not set
CONFIG_GPIO_DWAPB=y
# CONFIG_GPIO_EXAR is not set
CONFIG_GPIO_GENERIC_PLATFORM=y
# CONFIG_GPIO_ICH is not set
# CONFIG_GPIO_LYNXPOINT is not set
# CONFIG_GPIO_MOCKUP is not set
# CONFIG_GPIO_VX855 is not set

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_104_DIO_48E=m
CONFIG_GPIO_104_IDIO_16=m
CONFIG_GPIO_104_IDI_48=m
CONFIG_GPIO_F7188X=y
# CONFIG_GPIO_GPIO_MM is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
CONFIG_GPIO_SCH311X=y
CONFIG_GPIO_WS16C48=m

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=m
# CONFIG_GPIO_MAX7300 is not set
CONFIG_GPIO_MAX732X=y
# CONFIG_GPIO_MAX732X_IRQ is not set
CONFIG_GPIO_PCA953X=y
CONFIG_GPIO_PCA953X_IRQ=y
CONFIG_GPIO_PCF857X=y
# CONFIG_GPIO_TPIC2810 is not set

#
# MFD GPIO expanders
#
# CONFIG_GPIO_ARIZONA is not set
# CONFIG_GPIO_DA9052 is not set
CONFIG_GPIO_KEMPLD=m
# CONFIG_GPIO_LP3943 is not set
# CONFIG_GPIO_LP873X is not set
# CONFIG_GPIO_RC5T583 is not set
CONFIG_GPIO_TPS65086=y
CONFIG_GPIO_TPS65912=m
CONFIG_GPIO_TWL6040=y
CONFIG_GPIO_WM831X=m
CONFIG_GPIO_WM8350=m
CONFIG_GPIO_WM8994=y

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_RDC321X is not set

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX7301 is not set
CONFIG_GPIO_MC33880=m
CONFIG_GPIO_PISOSR=m

#
# SPI or I2C GPIO expanders
#
# CONFIG_W1 is not set
CONFIG_POWER_AVS=y
CONFIG_POWER_RESET=y
CONFIG_POWER_RESET_RESTART=y
CONFIG_POWER_SUPPLY=y
CONFIG_POWER_SUPPLY_DEBUG=y
# CONFIG_PDA_POWER is not set
CONFIG_GENERIC_ADC_BATTERY=m
# CONFIG_WM831X_BACKUP is not set
CONFIG_WM831X_POWER=y
CONFIG_WM8350_POWER=m
# CONFIG_TEST_POWER is not set
CONFIG_BATTERY_88PM860X=m
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
CONFIG_CHARGER_SBS=m
CONFIG_BATTERY_BQ27XXX=y
CONFIG_BATTERY_BQ27XXX_I2C=y
CONFIG_BATTERY_DA9030=m
CONFIG_BATTERY_DA9052=m
CONFIG_CHARGER_DA9150=m
CONFIG_BATTERY_DA9150=m
# CONFIG_AXP288_FUEL_GAUGE is not set
CONFIG_BATTERY_MAX17040=y
CONFIG_BATTERY_MAX17042=m
CONFIG_CHARGER_88PM860X=m
CONFIG_CHARGER_MAX8903=y
# CONFIG_CHARGER_LP8727 is not set
CONFIG_CHARGER_LP8788=m
CONFIG_CHARGER_GPIO=m
CONFIG_CHARGER_MANAGER=y
# CONFIG_CHARGER_MAX14577 is not set
CONFIG_CHARGER_MAX8997=y
CONFIG_CHARGER_BQ2415X=y
# CONFIG_CHARGER_BQ24190 is not set
CONFIG_CHARGER_BQ24257=m
# CONFIG_CHARGER_BQ24735 is not set
CONFIG_CHARGER_BQ25890=y
CONFIG_CHARGER_SMB347=y
CONFIG_BATTERY_GAUGE_LTC2941=y
CONFIG_BATTERY_GOLDFISH=m
CONFIG_BATTERY_RT5033=m
CONFIG_CHARGER_RT9455=y
# CONFIG_AXP20X_POWER is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_AD7314=y
CONFIG_SENSORS_AD7414=m
# CONFIG_SENSORS_AD7418 is not set
CONFIG_SENSORS_ADM1021=y
CONFIG_SENSORS_ADM1025=m
# CONFIG_SENSORS_ADM1026 is not set
CONFIG_SENSORS_ADM1029=y
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM9240 is not set
CONFIG_SENSORS_ADT7X10=m
CONFIG_SENSORS_ADT7310=m
# CONFIG_SENSORS_ADT7410 is not set
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=y
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=y
# CONFIG_SENSORS_ASC7621 is not set
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
# CONFIG_SENSORS_FAM15H_POWER is not set
# CONFIG_SENSORS_APPLESMC is not set
CONFIG_SENSORS_ASB100=m
CONFIG_SENSORS_ATXP1=y
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=y
CONFIG_SENSORS_DA9052_ADC=y
# CONFIG_SENSORS_I5K_AMB is not set
CONFIG_SENSORS_F71805F=y
CONFIG_SENSORS_F71882FG=y
# CONFIG_SENSORS_F75375S is not set
CONFIG_SENSORS_MC13783_ADC=m
CONFIG_SENSORS_FSCHMD=m
CONFIG_SENSORS_FTSTEUTATES=m
# CONFIG_SENSORS_GL518SM is not set
CONFIG_SENSORS_GL520SM=y
# CONFIG_SENSORS_G760A is not set
CONFIG_SENSORS_G762=y
# CONFIG_SENSORS_GPIO_FAN is not set
CONFIG_SENSORS_HIH6130=m
# CONFIG_SENSORS_IBMAEM is not set
CONFIG_SENSORS_IBMPEX=y
CONFIG_SENSORS_IIO_HWMON=m
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=y
CONFIG_SENSORS_JC42=m
CONFIG_SENSORS_POWR1220=y
CONFIG_SENSORS_LINEAGE=m
CONFIG_SENSORS_LTC2945=y
CONFIG_SENSORS_LTC2990=m
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
CONFIG_SENSORS_LTC4222=y
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
CONFIG_SENSORS_MAX1111=y
CONFIG_SENSORS_MAX16065=y
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
# CONFIG_SENSORS_MAX197 is not set
# CONFIG_SENSORS_MAX31722 is not set
CONFIG_SENSORS_MAX6639=y
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=y
CONFIG_SENSORS_MAX6697=m
CONFIG_SENSORS_MAX31790=y
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_TC654 is not set
CONFIG_SENSORS_ADCXX=m
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=y
# CONFIG_SENSORS_LM75 is not set
CONFIG_SENSORS_LM77=y
CONFIG_SENSORS_LM78=y
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=y
# CONFIG_SENSORS_LM85 is not set
CONFIG_SENSORS_LM87=y
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=y
CONFIG_SENSORS_LM93=y
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
# CONFIG_SENSORS_PC87427 is not set
# CONFIG_SENSORS_NTC_THERMISTOR is not set
CONFIG_SENSORS_NCT6683=m
CONFIG_SENSORS_NCT6775=y
CONFIG_SENSORS_NCT7802=m
CONFIG_SENSORS_NCT7904=y
CONFIG_SENSORS_PCF8591=y
# CONFIG_PMBUS is not set
CONFIG_SENSORS_SHT15=y
# CONFIG_SENSORS_SHT21 is not set
CONFIG_SENSORS_SHT3x=y
CONFIG_SENSORS_SHTC1=m
# CONFIG_SENSORS_SIS5595 is not set
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
# CONFIG_SENSORS_EMC6W201 is not set
CONFIG_SENSORS_SMSC47M1=y
# CONFIG_SENSORS_SMSC47M192 is not set
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
CONFIG_SENSORS_STTS751=y
CONFIG_SENSORS_SMM665=y
CONFIG_SENSORS_ADC128D818=m
CONFIG_SENSORS_ADS1015=y
# CONFIG_SENSORS_ADS7828 is not set
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
# CONFIG_SENSORS_INA209 is not set
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
# CONFIG_SENSORS_THMC50 is not set
# CONFIG_SENSORS_TMP102 is not set
CONFIG_SENSORS_TMP103=m
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
# CONFIG_SENSORS_TMP421 is not set
CONFIG_SENSORS_VIA_CPUTEMP=y
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_VT1211=m
# CONFIG_SENSORS_VT8231 is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
# CONFIG_SENSORS_W83792D is not set
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
CONFIG_SENSORS_W83795_FANCTRL=y
CONFIG_SENSORS_W83L785TS=y
# CONFIG_SENSORS_W83L786NG is not set
# CONFIG_SENSORS_W83627HF is not set
# CONFIG_SENSORS_W83627EHF is not set
CONFIG_SENSORS_WM831X=m
CONFIG_SENSORS_WM8350=y

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
CONFIG_THERMAL_HWMON=y
# CONFIG_THERMAL_WRITABLE_TRIPS is not set
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
# CONFIG_THERMAL_GOV_USER_SPACE is not set
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
# CONFIG_THERMAL_EMULATION is not set
# CONFIG_INTEL_POWERCLAMP is not set
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# CONFIG_INTEL_PCH_THERMAL is not set
# CONFIG_GENERIC_ADC_THERMAL is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_SYSFS=y

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_SOFT_WATCHDOG_PRETIMEOUT=y
# CONFIG_DA9052_WATCHDOG is not set
CONFIG_DA9063_WATCHDOG=m
CONFIG_DA9062_WATCHDOG=y
# CONFIG_WDAT_WDT is not set
# CONFIG_WM831X_WATCHDOG is not set
# CONFIG_WM8350_WATCHDOG is not set
# CONFIG_XILINX_WATCHDOG is not set
CONFIG_ZIIRAVE_WATCHDOG=y
CONFIG_CADENCE_WATCHDOG=m
CONFIG_DW_WATCHDOG=y
CONFIG_MAX63XX_WATCHDOG=y
# CONFIG_RETU_WATCHDOG is not set
CONFIG_ACQUIRE_WDT=m
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
CONFIG_EBC_C384_WDT=m
CONFIG_F71808E_WDT=y
# CONFIG_SP5100_TCO is not set
CONFIG_SBC_FITPC2_WATCHDOG=y
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=y
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
# CONFIG_I6300ESB_WDT is not set
# CONFIG_IE6XX_WDT is not set
# CONFIG_ITCO_WDT is not set
CONFIG_IT8712F_WDT=y
CONFIG_IT87_WDT=y
# CONFIG_HP_WATCHDOG is not set
# CONFIG_KEMPLD_WDT is not set
# CONFIG_SC1200_WDT is not set
# CONFIG_SCx200_WDT is not set
CONFIG_PC87413_WDT=m
# CONFIG_NV_TCO is not set
CONFIG_60XX_WDT=y
CONFIG_SBC8360_WDT=y
# CONFIG_SBC7240_WDT is not set
CONFIG_CPU5_WDT=y
CONFIG_SMSC_SCH311X_WDT=m
CONFIG_SMSC37B787_WDT=y
# CONFIG_VIA_WDT is not set
CONFIG_W83627HF_WDT=y
CONFIG_W83877F_WDT=y
CONFIG_W83977F_WDT=y
CONFIG_MACHZ_WDT=m
CONFIG_SBC_EPX_C3_WATCHDOG=m
# CONFIG_NI903X_WDT is not set
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
CONFIG_WATCHDOG_PRETIMEOUT_GOV=y
# CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP is not set
CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC=y
# CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP is not set
CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC=y
CONFIG_SSB_POSSIBLE=y

#
# Sonics Silicon Backplane
#
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y

#
# Broadcom specific AMBA
#
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_CS5535 is not set
CONFIG_MFD_AS3711=y
# CONFIG_PMIC_ADP5520 is not set
CONFIG_MFD_AAT2870_CORE=y
CONFIG_MFD_BCM590XX=m
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
# CONFIG_MFD_CROS_EC is not set
CONFIG_PMIC_DA903X=y
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_SPI=y
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
CONFIG_MFD_DA9062=y
CONFIG_MFD_DA9063=m
CONFIG_MFD_DA9150=m
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_SPI=y
# CONFIG_MFD_MC13XXX_I2C is not set
CONFIG_HTC_PASIC3=y
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_INTEL_SOC_PMIC is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=y
CONFIG_MFD_88PM800=y
# CONFIG_MFD_88PM805 is not set
CONFIG_MFD_88PM860X=y
CONFIG_MFD_MAX14577=y
# CONFIG_MFD_MAX77693 is not set
CONFIG_MFD_MAX77843=y
CONFIG_MFD_MAX8907=y
# CONFIG_MFD_MAX8925 is not set
CONFIG_MFD_MAX8997=y
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
CONFIG_MFD_RETU=m
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RTSX_PCI is not set
CONFIG_MFD_RT5033=m
CONFIG_MFD_RC5T583=y
CONFIG_MFD_SEC_CORE=y
CONFIG_MFD_SI476X_CORE=y
# CONFIG_MFD_SM501 is not set
CONFIG_MFD_SKY81452=m
# CONFIG_MFD_SMSC is not set
CONFIG_ABX500_CORE=y
CONFIG_AB3100_CORE=y
CONFIG_AB3100_OTP=y
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=m
CONFIG_MFD_LP3943=m
CONFIG_MFD_LP8788=y
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
CONFIG_MFD_TPS65086=y
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TPS65217 is not set
CONFIG_MFD_TI_LP873X=m
# CONFIG_MFD_TPS65218 is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
CONFIG_MFD_TPS65912=m
CONFIG_MFD_TPS65912_I2C=m
# CONFIG_MFD_TPS65912_SPI is not set
CONFIG_MFD_TPS80031=y
# CONFIG_TWL4030_CORE is not set
CONFIG_TWL6040_CORE=y
CONFIG_MFD_WL1273_CORE=m
CONFIG_MFD_LM3533=m
# CONFIG_MFD_TIMBERDALE is not set
# CONFIG_MFD_TMIO is not set
# CONFIG_MFD_VX855 is not set
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=m
CONFIG_MFD_ARIZONA_SPI=m
# CONFIG_MFD_CS47L24 is not set
# CONFIG_MFD_WM5102 is not set
CONFIG_MFD_WM5110=y
CONFIG_MFD_WM8997=y
# CONFIG_MFD_WM8998 is not set
# CONFIG_MFD_WM8400 is not set
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
CONFIG_MFD_WM831X_SPI=y
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
CONFIG_MFD_WM8994=y
CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=m
CONFIG_REGULATOR_VIRTUAL_CONSUMER=m
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
CONFIG_REGULATOR_88PM800=y
CONFIG_REGULATOR_88PM8607=y
CONFIG_REGULATOR_ACT8865=m
# CONFIG_REGULATOR_AD5398 is not set
CONFIG_REGULATOR_ANATOP=y
CONFIG_REGULATOR_AAT2870=m
CONFIG_REGULATOR_AB3100=y
CONFIG_REGULATOR_AS3711=m
# CONFIG_REGULATOR_AXP20X is not set
CONFIG_REGULATOR_BCM590XX=m
# CONFIG_REGULATOR_DA903X is not set
# CONFIG_REGULATOR_DA9052 is not set
# CONFIG_REGULATOR_DA9062 is not set
CONFIG_REGULATOR_DA9063=m
CONFIG_REGULATOR_DA9210=y
# CONFIG_REGULATOR_DA9211 is not set
# CONFIG_REGULATOR_FAN53555 is not set
CONFIG_REGULATOR_GPIO=m
# CONFIG_REGULATOR_ISL9305 is not set
# CONFIG_REGULATOR_ISL6271A is not set
CONFIG_REGULATOR_LP3971=y
CONFIG_REGULATOR_LP3972=y
# CONFIG_REGULATOR_LP872X is not set
CONFIG_REGULATOR_LP8755=y
# CONFIG_REGULATOR_LP8788 is not set
CONFIG_REGULATOR_LTC3589=y
CONFIG_REGULATOR_LTC3676=y
CONFIG_REGULATOR_MAX14577=m
CONFIG_REGULATOR_MAX1586=m
CONFIG_REGULATOR_MAX8649=m
# CONFIG_REGULATOR_MAX8660 is not set
CONFIG_REGULATOR_MAX8907=m
CONFIG_REGULATOR_MAX8952=y
CONFIG_REGULATOR_MAX8997=y
# CONFIG_REGULATOR_MAX77693 is not set
CONFIG_REGULATOR_MC13XXX_CORE=y
CONFIG_REGULATOR_MC13783=m
CONFIG_REGULATOR_MC13892=y
CONFIG_REGULATOR_MT6311=y
# CONFIG_REGULATOR_PFUZE100 is not set
CONFIG_REGULATOR_PV88060=m
CONFIG_REGULATOR_PV88080=y
# CONFIG_REGULATOR_PV88090 is not set
CONFIG_REGULATOR_RC5T583=m
CONFIG_REGULATOR_RT5033=m
CONFIG_REGULATOR_S2MPA01=y
CONFIG_REGULATOR_S2MPS11=y
CONFIG_REGULATOR_S5M8767=y
CONFIG_REGULATOR_SKY81452=m
CONFIG_REGULATOR_TPS51632=y
CONFIG_REGULATOR_TPS62360=y
CONFIG_REGULATOR_TPS65023=y
CONFIG_REGULATOR_TPS6507X=y
CONFIG_REGULATOR_TPS65086=m
CONFIG_REGULATOR_TPS6524X=m
CONFIG_REGULATOR_TPS65912=m
CONFIG_REGULATOR_TPS80031=m
CONFIG_REGULATOR_WM831X=m
CONFIG_REGULATOR_WM8350=m
CONFIG_REGULATOR_WM8994=m
CONFIG_MEDIA_SUPPORT=y

#
# Multimedia core support
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
# CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
# CONFIG_MEDIA_RADIO_SUPPORT is not set
# CONFIG_MEDIA_SDR_SUPPORT is not set
# CONFIG_MEDIA_RC_SUPPORT is not set
CONFIG_MEDIA_CEC_SUPPORT=y
# CONFIG_MEDIA_CEC_DEBUG is not set
CONFIG_MEDIA_CEC_EDID=y
# CONFIG_MEDIA_CONTROLLER is not set
CONFIG_VIDEO_DEV=y
CONFIG_VIDEO_V4L2=y
CONFIG_VIDEO_ADV_DEBUG=y
CONFIG_VIDEO_FIXED_MINOR_RANGES=y
# CONFIG_TTPCI_EEPROM is not set

#
# Media drivers
#
# CONFIG_MEDIA_PCI_SUPPORT is not set
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
CONFIG_V4L_TEST_DRIVERS=y
# CONFIG_VIDEO_VIVID is not set
# CONFIG_VIDEO_VIM2M is not set

#
# Supported MMC/SDIO adapters
#

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y
CONFIG_MEDIA_ATTACH=y

#
# Audio decoders, processors and mixers
#

#
# RDS decoders
#

#
# Video decoders
#

#
# Video and audio decoders
#

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
CONFIG_MEDIA_TUNER_MT20XX=y
CONFIG_MEDIA_TUNER_XC2028=y
CONFIG_MEDIA_TUNER_XC5000=y
CONFIG_MEDIA_TUNER_XC4000=y
CONFIG_MEDIA_TUNER_MC44S803=y

#
# Tools to develop new frontends
#

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=y
# CONFIG_DRM_DP_AUX_CHARDEV is not set
# CONFIG_DRM_DEBUG_MM is not set
# CONFIG_DRM_DEBUG_MM_SELFTEST is not set
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_KMS_FB_HELPER=y
# CONFIG_DRM_FBDEV_EMULATION is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_GEM_CMA_HELPER=y
CONFIG_DRM_KMS_CMA_HELPER=y
CONFIG_DRM_VM=y

#
# I2C encoder or helper chips
#
# CONFIG_DRM_I2C_CH7006 is not set
CONFIG_DRM_I2C_SIL164=m
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set

#
# ACP (Audio CoProcessor) Configuration
#
# CONFIG_DRM_NOUVEAU is not set
# CONFIG_DRM_I915 is not set
CONFIG_DRM_VGEM=y
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
# CONFIG_DRM_UDL is not set
# CONFIG_DRM_AST is not set
# CONFIG_DRM_MGAG200 is not set
# CONFIG_DRM_CIRRUS_QEMU is not set
# CONFIG_DRM_QXL is not set
# CONFIG_DRM_BOCHS is not set
CONFIG_DRM_BRIDGE=y

#
# Display Interface Bridges
#
CONFIG_DRM_ANALOGIX_ANX78XX=y
# CONFIG_DRM_HISI_HIBMC is not set
CONFIG_DRM_TINYDRM=y
# CONFIG_TINYDRM_MI0283QT is not set
CONFIG_DRM_LEGACY=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_VIA is not set
# CONFIG_DRM_SAVAGE is not set
# CONFIG_DRM_LIB_RANDOM is not set

#
# Frame buffer Devices
#
CONFIG_FB=y
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
# CONFIG_FB_DDC is not set
# CONFIG_FB_BOOT_VESA_SUPPORT is not set
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
# CONFIG_FB_SVGALIB is not set
# CONFIG_FB_MACMODES is not set
# CONFIG_FB_BACKLIGHT is not set
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_ARC=m
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
CONFIG_FB_S1D13XXX=y
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
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_GEODE is not set
# CONFIG_FB_IBM_GXT4500 is not set
CONFIG_FB_GOLDFISH=m
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_BROADSHEET=m
# CONFIG_FB_AUO_K190X is not set
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SM712 is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_LCD_CLASS_DEVICE=m
CONFIG_LCD_L4F00242T03=m
CONFIG_LCD_LMS283GF05=m
CONFIG_LCD_LTV350QV=m
CONFIG_LCD_ILI922X=m
CONFIG_LCD_ILI9320=m
CONFIG_LCD_TDO24M=m
CONFIG_LCD_VGG2432A4=m
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_S6E63M0 is not set
# CONFIG_LCD_LD9040 is not set
# CONFIG_LCD_AMS369FG06 is not set
CONFIG_LCD_LMS501KF03=m
CONFIG_LCD_HX8357=m
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_GENERIC=y
# CONFIG_BACKLIGHT_LM3533 is not set
# CONFIG_BACKLIGHT_DA903X is not set
# CONFIG_BACKLIGHT_DA9052 is not set
# CONFIG_BACKLIGHT_APPLE is not set
# CONFIG_BACKLIGHT_PM8941_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_WM831X is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_88PM860X is not set
# CONFIG_BACKLIGHT_AAT2870 is not set
# CONFIG_BACKLIGHT_LM3639 is not set
# CONFIG_BACKLIGHT_SKY81452 is not set
# CONFIG_BACKLIGHT_AS3711 is not set
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_VGASTATE is not set
CONFIG_HDMI=y
# CONFIG_LOGO is not set
# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
# CONFIG_HID_GENERIC is not set

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
CONFIG_HID_ACRUX=y
# CONFIG_HID_ACRUX_FF is not set
# CONFIG_HID_APPLE is not set
# CONFIG_HID_ASUS is not set
# CONFIG_HID_AUREAL is not set
CONFIG_HID_BELKIN=m
CONFIG_HID_CHERRY=m
# CONFIG_HID_CHICONY is not set
CONFIG_HID_CMEDIA=y
CONFIG_HID_CYPRESS=y
# CONFIG_HID_DRAGONRISE is not set
CONFIG_HID_EMS_FF=y
CONFIG_HID_ELECOM=y
CONFIG_HID_EZKEY=y
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=y
CONFIG_HID_KEYTOUCH=y
# CONFIG_HID_KYE is not set
CONFIG_HID_WALTOP=y
# CONFIG_HID_GYRATION is not set
CONFIG_HID_ICADE=m
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=y
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
# CONFIG_HID_LOGITECH is not set
# CONFIG_HID_MAGICMOUSE is not set
CONFIG_HID_MAYFLASH=y
# CONFIG_HID_MICROSOFT is not set
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
CONFIG_PANTHERLORD_FF=y
CONFIG_HID_PETALYNX=y
CONFIG_HID_PICOLCD=m
# CONFIG_HID_PICOLCD_FB is not set
# CONFIG_HID_PICOLCD_BACKLIGHT is not set
CONFIG_HID_PICOLCD_LCD=y
# CONFIG_HID_PICOLCD_LEDS is not set
CONFIG_HID_PLANTRONICS=m
CONFIG_HID_PRIMAX=y
CONFIG_HID_SAITEK=y
# CONFIG_HID_SAMSUNG is not set
CONFIG_HID_SPEEDLINK=m
CONFIG_HID_STEELSERIES=y
CONFIG_HID_SUNPLUS=m
# CONFIG_HID_RMI is not set
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_SMARTJOYPLUS=m
CONFIG_SMARTJOYPLUS_FF=y
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
# CONFIG_HID_THRUSTMASTER is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=y
CONFIG_HID_XINMO=m
# CONFIG_HID_ZEROPLUS is not set
CONFIG_HID_ZYDACRON=m
# CONFIG_HID_SENSOR_HUB is not set
CONFIG_HID_ALPS=y

#
# I2C HID support
#
CONFIG_I2C_HID=y
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_ARCH_HAS_HCD=y
# CONFIG_USB is not set

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
# CONFIG_USB_ULPI_BUS is not set
CONFIG_UWB=m
# CONFIG_UWB_WHCI is not set
CONFIG_MMC=y
CONFIG_MMC_DEBUG=y
CONFIG_SDIO_UART=m
CONFIG_MMC_TEST=m

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_SDHCI is not set
CONFIG_MMC_WBSD=y
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_GOLDFISH is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
CONFIG_MMC_USDHI6ROL0=y
# CONFIG_MMC_TOSHIBA_PCI is not set
CONFIG_MMC_MTK=m
CONFIG_MEMSTICK=m
CONFIG_MEMSTICK_DEBUG=y

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set

#
# MemoryStick Host Controller Drivers
#
# CONFIG_MEMSTICK_TIFM_MS is not set
# CONFIG_MEMSTICK_JMICRON_38X is not set
# CONFIG_MEMSTICK_R592 is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=m
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
CONFIG_LEDS_88PM860X=y
# CONFIG_LEDS_LM3530 is not set
CONFIG_LEDS_LM3533=m
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_NET48XX is not set
CONFIG_LEDS_WRAP=m
CONFIG_LEDS_PCA9532=m
# CONFIG_LEDS_PCA9532_GPIO is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
CONFIG_LEDS_LP3952=y
CONFIG_LEDS_LP55XX_COMMON=y
# CONFIG_LEDS_LP5521 is not set
CONFIG_LEDS_LP5523=y
CONFIG_LEDS_LP5562=y
# CONFIG_LEDS_LP8501 is not set
# CONFIG_LEDS_LP8788 is not set
# CONFIG_LEDS_LP8860 is not set
CONFIG_LEDS_PCA955X=y
# CONFIG_LEDS_PCA963X is not set
CONFIG_LEDS_WM831X_STATUS=y
CONFIG_LEDS_WM8350=y
CONFIG_LEDS_DA903X=y
# CONFIG_LEDS_DA9052 is not set
CONFIG_LEDS_DAC124S085=y
CONFIG_LEDS_REGULATOR=m
CONFIG_LEDS_BD2802=y
CONFIG_LEDS_LT3593=m
# CONFIG_LEDS_MC13783 is not set
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
CONFIG_LEDS_MAX8997=m
# CONFIG_LEDS_LM355x is not set
CONFIG_LEDS_OT200=m

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_USER=m
# CONFIG_LEDS_NIC78BX is not set

#
# LED Triggers
#
# CONFIG_LEDS_TRIGGERS is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
# CONFIG_EDAC is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
# CONFIG_RTC_CLASS is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
CONFIG_INTEL_IDMA64=y
# CONFIG_PCH_DMA is not set
CONFIG_QCOM_HIDMA_MGMT=y
# CONFIG_QCOM_HIDMA is not set
# CONFIG_DW_DMAC is not set
# CONFIG_DW_DMAC_PCI is not set

#
# DMA Clients
#
# CONFIG_ASYNC_TX_DMA is not set
CONFIG_DMATEST=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
CONFIG_AUXDISPLAY=y
# CONFIG_IMG_ASCII_LCD is not set
# CONFIG_UIO is not set
CONFIG_VIRT_DRIVERS=y

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
CONFIG_X86_PLATFORM_DEVICES=y
# CONFIG_ACERHDF is not set
# CONFIG_ASUS_LAPTOP is not set
# CONFIG_DELL_SMO8800 is not set
# CONFIG_FUJITSU_LAPTOP is not set
# CONFIG_FUJITSU_TABLET is not set
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
# CONFIG_INTEL_HID_EVENT is not set
# CONFIG_INTEL_VBTN is not set
# CONFIG_INTEL_IPS is not set
# CONFIG_INTEL_PMC_CORE is not set
# CONFIG_IBM_RTL is not set
# CONFIG_SAMSUNG_LAPTOP is not set
# CONFIG_SAMSUNG_Q10 is not set
# CONFIG_APPLE_GMUX is not set
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_PVPANIC is not set
# CONFIG_INTEL_PMC_IPC is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
# CONFIG_SURFACE_3_BUTTON is not set
CONFIG_INTEL_PUNIT_IPC=y
# CONFIG_MLX_CPLD_PLATFORM is not set
CONFIG_PMC_ATOM=y
CONFIG_GOLDFISH_BUS=y
# CONFIG_GOLDFISH_PIPE is not set
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_WM831X is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_S2MPS11 is not set
# CONFIG_CLK_TWL6040 is not set
# CONFIG_COMMON_CLK_NXP is not set
# CONFIG_COMMON_CLK_PXA is not set
# CONFIG_COMMON_CLK_PIC32 is not set

#
# Hardware Spinlock drivers
#

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
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
# CONFIG_SOC_ZTE is not set
# CONFIG_PM_DEVFREQ is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=y
# CONFIG_EXTCON_GPIO is not set
# CONFIG_EXTCON_INTEL_INT3496 is not set
# CONFIG_EXTCON_MAX14577 is not set
CONFIG_EXTCON_MAX3355=y
# CONFIG_EXTCON_MAX77843 is not set
# CONFIG_EXTCON_MAX8997 is not set
# CONFIG_EXTCON_QCOM_SPMI_MISC is not set
CONFIG_EXTCON_RT8973A=m
CONFIG_EXTCON_SM5502=y
CONFIG_EXTCON_USB_GPIO=y
CONFIG_MEMORY=y
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
# CONFIG_IIO_BUFFER_CB is not set
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=y
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=y
CONFIG_IIO_SW_TRIGGER=m
CONFIG_IIO_TRIGGERED_EVENT=y

#
# Accelerometers
#
# CONFIG_BMA180 is not set
CONFIG_BMA220=m
# CONFIG_BMC150_ACCEL is not set
CONFIG_DA280=y
# CONFIG_DA311 is not set
CONFIG_DMARD09=m
# CONFIG_DMARD10 is not set
CONFIG_KXSD9=y
CONFIG_KXSD9_SPI=m
# CONFIG_KXSD9_I2C is not set
CONFIG_KXCJK1013=m
CONFIG_MC3230=m
CONFIG_MMA7455=m
CONFIG_MMA7455_I2C=m
# CONFIG_MMA7455_SPI is not set
# CONFIG_MMA7660 is not set
# CONFIG_MMA8452 is not set
CONFIG_MMA9551_CORE=y
CONFIG_MMA9551=m
CONFIG_MMA9553=y
CONFIG_MXC4005=y
CONFIG_MXC6255=y
# CONFIG_SCA3000 is not set
CONFIG_STK8312=y
# CONFIG_STK8BA50 is not set

#
# Analog to digital converters
#
CONFIG_AD_SIGMA_DELTA=y
CONFIG_AD7266=m
# CONFIG_AD7291 is not set
CONFIG_AD7298=m
CONFIG_AD7476=y
CONFIG_AD7766=y
CONFIG_AD7791=m
CONFIG_AD7793=y
# CONFIG_AD7887 is not set
CONFIG_AD7923=m
CONFIG_AD799X=m
CONFIG_AXP288_ADC=m
# CONFIG_CC10001_ADC is not set
CONFIG_DA9150_GPADC=m
CONFIG_HI8435=y
CONFIG_HX711=y
CONFIG_INA2XX_ADC=m
CONFIG_LP8788_ADC=m
CONFIG_LTC2485=m
CONFIG_MAX1027=y
CONFIG_MAX11100=m
CONFIG_MAX1363=y
CONFIG_MCP320X=y
CONFIG_MCP3422=m
CONFIG_NAU7802=y
# CONFIG_STX104 is not set
# CONFIG_TI_ADC081C is not set
CONFIG_TI_ADC0832=y
CONFIG_TI_ADC12138=y
CONFIG_TI_ADC128S052=m
CONFIG_TI_ADC161S626=y
CONFIG_TI_ADS7950=y
CONFIG_TI_AM335X_ADC=m
# CONFIG_TI_TLC4541 is not set

#
# Amplifiers
#
# CONFIG_AD8366 is not set

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=m
CONFIG_IAQCORE=m
CONFIG_VZ89X=y

#
# Hid Sensor IIO Common
#
CONFIG_IIO_MS_SENSORS_I2C=y

#
# SSP Sensor Common
#
CONFIG_IIO_SSP_SENSORS_COMMONS=m
CONFIG_IIO_SSP_SENSORHUB=y
CONFIG_IIO_ST_SENSORS_I2C=y
CONFIG_IIO_ST_SENSORS_SPI=y
CONFIG_IIO_ST_SENSORS_CORE=y

#
# Counters
#
CONFIG_104_QUAD_8=y

#
# Digital to analog converters
#
CONFIG_AD5064=m
CONFIG_AD5360=m
CONFIG_AD5380=m
# CONFIG_AD5421 is not set
CONFIG_AD5446=y
CONFIG_AD5449=m
CONFIG_AD5592R_BASE=m
CONFIG_AD5592R=m
# CONFIG_AD5593R is not set
CONFIG_AD5504=m
# CONFIG_AD5624R_SPI is not set
# CONFIG_AD5686 is not set
# CONFIG_AD5755 is not set
CONFIG_AD5761=m
CONFIG_AD5764=m
CONFIG_AD5791=y
# CONFIG_AD7303 is not set
CONFIG_CIO_DAC=y
# CONFIG_AD8801 is not set
CONFIG_M62332=y
# CONFIG_MAX517 is not set
CONFIG_MCP4725=y
CONFIG_MCP4922=y

#
# IIO dummy driver
#
CONFIG_IIO_DUMMY_EVGEN=y
CONFIG_IIO_SIMPLE_DUMMY=y
CONFIG_IIO_SIMPLE_DUMMY_EVENTS=y
CONFIG_IIO_SIMPLE_DUMMY_BUFFER=y

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
# CONFIG_AD9523 is not set

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
CONFIG_ADF4350=m

#
# Digital gyroscope sensors
#
CONFIG_ADIS16080=y
CONFIG_ADIS16130=m
# CONFIG_ADIS16136 is not set
CONFIG_ADIS16260=y
CONFIG_ADXRS450=y
# CONFIG_BMG160 is not set
# CONFIG_MPU3050_I2C is not set
CONFIG_IIO_ST_GYRO_3AXIS=m
CONFIG_IIO_ST_GYRO_I2C_3AXIS=m
CONFIG_IIO_ST_GYRO_SPI_3AXIS=m
CONFIG_ITG3200=y

#
# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4403=y
# CONFIG_AFE4404 is not set
CONFIG_MAX30100=m

#
# Humidity sensors
#
CONFIG_AM2315=y
CONFIG_DHT11=y
CONFIG_HDC100X=m
CONFIG_HTS221=y
CONFIG_HTS221_I2C=y
CONFIG_HTS221_SPI=y
# CONFIG_HTU21 is not set
# CONFIG_SI7005 is not set
# CONFIG_SI7020 is not set

#
# Inertial measurement units
#
CONFIG_ADIS16400=y
# CONFIG_ADIS16480 is not set
CONFIG_BMI160=y
CONFIG_BMI160_I2C=y
# CONFIG_BMI160_SPI is not set
CONFIG_KMX61=m
CONFIG_INV_MPU6050_IIO=m
# CONFIG_INV_MPU6050_I2C is not set
CONFIG_INV_MPU6050_SPI=m
CONFIG_IIO_ST_LSM6DSX=y
CONFIG_IIO_ST_LSM6DSX_I2C=y
CONFIG_IIO_ST_LSM6DSX_SPI=y
CONFIG_IIO_ADIS_LIB=y
CONFIG_IIO_ADIS_LIB_BUFFER=y

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
CONFIG_ADJD_S311=m
# CONFIG_AL3320A is not set
CONFIG_APDS9300=m
CONFIG_APDS9960=m
CONFIG_BH1750=y
CONFIG_BH1780=m
CONFIG_CM32181=y
CONFIG_CM3232=m
CONFIG_CM3323=m
CONFIG_CM36651=y
CONFIG_GP2AP020A00F=m
CONFIG_SENSORS_ISL29018=y
# CONFIG_ISL29125 is not set
CONFIG_JSA1212=m
CONFIG_RPR0521=y
# CONFIG_SENSORS_LM3533 is not set
CONFIG_LTR501=y
CONFIG_MAX44000=m
CONFIG_OPT3001=m
CONFIG_PA12203001=m
CONFIG_SI1145=y
CONFIG_STK3310=y
# CONFIG_TCS3414 is not set
CONFIG_TCS3472=y
# CONFIG_SENSORS_TSL2563 is not set
# CONFIG_TSL2583 is not set
CONFIG_TSL4531=y
CONFIG_US5182D=y
CONFIG_VCNL4000=y
CONFIG_VEML6070=y

#
# Magnetometer sensors
#
CONFIG_AK8975=y
CONFIG_AK09911=y
CONFIG_BMC150_MAGN=y
CONFIG_BMC150_MAGN_I2C=y
CONFIG_BMC150_MAGN_SPI=m
# CONFIG_MAG3110 is not set
CONFIG_MMC35240=m
CONFIG_IIO_ST_MAGN_3AXIS=y
CONFIG_IIO_ST_MAGN_I2C_3AXIS=y
CONFIG_IIO_ST_MAGN_SPI_3AXIS=y
CONFIG_SENSORS_HMC5843=y
CONFIG_SENSORS_HMC5843_I2C=y
CONFIG_SENSORS_HMC5843_SPI=m

#
# Inclinometer sensors
#

#
# Triggers - standalone
#
CONFIG_IIO_HRTIMER_TRIGGER=m
# CONFIG_IIO_INTERRUPT_TRIGGER is not set
CONFIG_IIO_TIGHTLOOP_TRIGGER=m
CONFIG_IIO_SYSFS_TRIGGER=y

#
# Digital potentiometers
#
CONFIG_DS1803=y
# CONFIG_MAX5481 is not set
# CONFIG_MAX5487 is not set
# CONFIG_MCP4131 is not set
# CONFIG_MCP4531 is not set
CONFIG_TPL0102=m

#
# Digital potentiostats
#
# CONFIG_LMP91000 is not set

#
# Pressure sensors
#
CONFIG_ABP060MG=m
CONFIG_BMP280=m
CONFIG_BMP280_I2C=m
CONFIG_BMP280_SPI=m
CONFIG_HP03=y
CONFIG_MPL115=y
CONFIG_MPL115_I2C=m
CONFIG_MPL115_SPI=y
CONFIG_MPL3115=m
# CONFIG_MS5611 is not set
CONFIG_MS5637=m
# CONFIG_IIO_ST_PRESS is not set
CONFIG_T5403=m
# CONFIG_HP206C is not set
CONFIG_ZPA2326=y
CONFIG_ZPA2326_I2C=y
CONFIG_ZPA2326_SPI=y

#
# Lightning sensors
#
CONFIG_AS3935=y

#
# Proximity and distance sensors
#
CONFIG_LIDAR_LITE_V2=y
# CONFIG_SX9500 is not set
CONFIG_SRF08=y

#
# Temperature sensors
#
# CONFIG_MAXIM_THERMOCOUPLE is not set
# CONFIG_MLX90614 is not set
CONFIG_TMP006=y
# CONFIG_TMP007 is not set
CONFIG_TSYS01=y
CONFIG_TSYS02D=m
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
CONFIG_FMC=m
CONFIG_FMC_FAKEDEV=m
# CONFIG_FMC_TRIVIAL is not set
CONFIG_FMC_WRITE_EEPROM=m
CONFIG_FMC_CHARDEV=m

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_PHY_PXA_28NM_HSIC is not set
CONFIG_PHY_PXA_28NM_USB2=m
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
CONFIG_ANDROID=y
CONFIG_ANDROID_BINDER_IPC=y
CONFIG_ANDROID_BINDER_DEVICES="binder,hwbinder,vndbinder"
CONFIG_ANDROID_BINDER_IPC_32BIT=y
CONFIG_DEV_DAX=y
CONFIG_NR_DEV_DAX=32768
CONFIG_NVMEM=y
# CONFIG_STM is not set
CONFIG_INTEL_TH=y
# CONFIG_INTEL_TH_PCI is not set
# CONFIG_INTEL_TH_GTH is not set
CONFIG_INTEL_TH_MSU=y
# CONFIG_INTEL_TH_PTI is not set
CONFIG_INTEL_TH_DEBUG=y

#
# FPGA Configuration Support
#
# CONFIG_FPGA is not set

#
# FSI support
#
# CONFIG_FSI is not set

#
# Firmware Drivers
#
# CONFIG_EDD is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DELL_RBU=y
# CONFIG_DCDBAS is not set
# CONFIG_ISCSI_IBFT_FIND is not set
CONFIG_FW_CFG_SYSFS=m
CONFIG_FW_CFG_SYSFS_CMDLINE=y
CONFIG_GOOGLE_FIRMWARE=y

#
# Google Firmware Drivers
#
# CONFIG_EFI_DEV_PATH_PARSER is not set

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
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
CONFIG_QUOTA=y
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_PRINT_QUOTA_WARNING=y
CONFIG_QUOTA_DEBUG=y
CONFIG_QFMT_V1=y
# CONFIG_QFMT_V2 is not set
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS4_FS is not set
CONFIG_FUSE_FS=y
CONFIG_CUSE=m
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
CONFIG_FSCACHE_HISTOGRAM=y
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_SYSCTL=y
# CONFIG_PROC_PAGE_MONITOR is not set
# CONFIG_PROC_CHILDREN is not set
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_CONFIGFS_FS=y
CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
CONFIG_ECRYPT_FS=m
CONFIG_ECRYPT_FS_MESSAGING=y
CONFIG_JFFS2_FS=m
CONFIG_JFFS2_FS_DEBUG=0
CONFIG_JFFS2_FS_WRITEBUFFER=y
CONFIG_JFFS2_FS_WBUF_VERIFY=y
CONFIG_JFFS2_SUMMARY=y
CONFIG_JFFS2_FS_XATTR=y
CONFIG_JFFS2_FS_POSIX_ACL=y
CONFIG_JFFS2_FS_SECURITY=y
# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
CONFIG_JFFS2_ZLIB=y
# CONFIG_JFFS2_LZO is not set
CONFIG_JFFS2_RTIME=y
# CONFIG_JFFS2_RUBIN is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_PSTORE is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
# CONFIG_NFS_V4_1 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
# CONFIG_NFSD is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS is not set
# CONFIG_CIFS_WEAK_PW_HASH is not set
# CONFIG_CIFS_UPCALL is not set
# CONFIG_CIFS_XATTR is not set
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DFS_UPCALL is not set
# CONFIG_CIFS_SMB2 is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
# CONFIG_NLS_CODEPAGE_857 is not set
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
# CONFIG_NLS_CODEPAGE_863 is not set
CONFIG_NLS_CODEPAGE_864=m
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
CONFIG_NLS_CODEPAGE_869=m
# CONFIG_NLS_CODEPAGE_936 is not set
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
# CONFIG_NLS_ASCII is not set
# CONFIG_NLS_ISO8859_1 is not set
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
# CONFIG_NLS_ISO8859_5 is not set
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
# CONFIG_NLS_MAC_CELTIC is not set
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
# CONFIG_NLS_MAC_CYRILLIC is not set
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
# CONFIG_NLS_MAC_INUIT is not set
# CONFIG_NLS_MAC_ROMANIAN is not set
CONFIG_NLS_MAC_TURKISH=m
# CONFIG_NLS_UTF8 is not set
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
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
CONFIG_READABLE_ASM=y
CONFIG_UNUSED_SYMBOLS=y
CONFIG_PAGE_OWNER=y
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_ARCH_WANT_FRAME_POINTERS=y
CONFIG_FRAME_POINTER=y
CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
# CONFIG_MAGIC_SYSRQ_SERIAL is not set
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_POISONING is not set
CONFIG_DEBUG_PAGE_REF=y
CONFIG_DEBUG_RODATA_TEST=y
CONFIG_DEBUG_OBJECTS=y
# CONFIG_DEBUG_OBJECTS_SELFTEST is not set
# CONFIG_DEBUG_OBJECTS_FREE is not set
# CONFIG_DEBUG_OBJECTS_TIMERS is not set
CONFIG_DEBUG_OBJECTS_WORK=y
# CONFIG_DEBUG_OBJECTS_RCU_HEAD is not set
CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=y
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_STACK_USAGE=y
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_MEMORY_INIT is not set
CONFIG_DEBUG_PER_CPU_MAPS=y
# CONFIG_DEBUG_HIGHMEM is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_HAVE_ARCH_KMEMCHECK=y
CONFIG_DEBUG_SHIRQ=y

#
# Debug Lockups and Hangs
#
# CONFIG_LOCKUP_DETECTOR is not set
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
CONFIG_BOOTPARAM_HUNG_TASK_PANIC=y
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=1
CONFIG_WQ_WATCHDOG=y
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_DEBUG_TIMEKEEPING=y

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
CONFIG_LOCK_TORTURE_TEST=m
# CONFIG_WW_MUTEX_SELFTEST is not set
CONFIG_TRACE_IRQFLAGS=y
CONFIG_STACKTRACE=y
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PI_LIST is not set
CONFIG_DEBUG_SG=y
CONFIG_DEBUG_NOTIFIERS=y
CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
# CONFIG_PROVE_RCU is not set
# CONFIG_SPARSE_RCU_POINTER is not set
CONFIG_TORTURE_TEST=m
CONFIG_RCU_PERF_TEST=m
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
# CONFIG_RCU_TRACE is not set
CONFIG_RCU_EQS_DEBUG=y
CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
CONFIG_CPU_HOTPLUG_STATE_CONTROL=y
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FAULT_INJECTION=y
CONFIG_FAIL_PAGE_ALLOC=y
# CONFIG_FAIL_FUTEX is not set
# CONFIG_FAULT_INJECTION_DEBUG_FS is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_FUNCTION_TRACER=y
# CONFIG_FUNCTION_GRAPH_TRACER is not set
CONFIG_IRQSOFF_TRACER=y
CONFIG_SCHED_TRACER=y
# CONFIG_HWLAT_TRACER is not set
# CONFIG_FTRACE_SYSCALLS is not set
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_TRACE_BRANCH_PROFILING=y
# CONFIG_BRANCH_PROFILE_NONE is not set
CONFIG_PROFILE_ANNOTATED_BRANCHES=y
# CONFIG_PROFILE_ALL_BRANCHES is not set
CONFIG_TRACING_BRANCHES=y
CONFIG_BRANCH_TRACER=y
CONFIG_STACK_TRACER=y
CONFIG_KPROBE_EVENTS=y
# CONFIG_UPROBE_EVENTS is not set
CONFIG_BPF_EVENTS=y
CONFIG_PROBE_EVENTS=y
# CONFIG_DYNAMIC_FTRACE is not set
CONFIG_FUNCTION_PROFILER=y
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_MMIOTRACE is not set
CONFIG_TRACING_MAP=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACEPOINT_BENCHMARK is not set
# CONFIG_RING_BUFFER_BENCHMARK is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_TRACE_ENUM_MAP_FILE is not set
# CONFIG_TRACING_EVENTS_GPIO is not set

#
# Runtime Testing
#
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_SORT is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_USER_COPY is not set
# CONFIG_TEST_BPF is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_MEMTEST is not set
# CONFIG_TEST_STATIC_KEYS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_ARCH_WANTS_UBSAN_NO_NULL is not set
# CONFIG_UBSAN is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
CONFIG_IO_STRICT_DEVMEM=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
# CONFIG_EARLY_PRINTK_DBGP is not set
CONFIG_X86_PTDUMP_CORE=y
CONFIG_X86_PTDUMP=m
CONFIG_DEBUG_WX=y
# CONFIG_DOUBLEFAULT is not set
CONFIG_DEBUG_TLBFLUSH=y
# CONFIG_IOMMU_STRESS is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
# CONFIG_IO_DELAY_0X80 is not set
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
CONFIG_IO_DELAY_NONE=y
CONFIG_DEFAULT_IO_DELAY_TYPE=3
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
CONFIG_OPTIMIZE_INLINING=y
CONFIG_DEBUG_ENTRY=y
CONFIG_DEBUG_NMI_SELFTEST=y
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set

#
# Security options
#
CONFIG_KEYS=y
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_BIG_KEYS=y
# CONFIG_TRUSTED_KEYS is not set
CONFIG_ENCRYPTED_KEYS=m
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
# CONFIG_SECURITY is not set
CONFIG_SECURITYFS=y
CONFIG_HAVE_ARCH_HARDENED_USERCOPY=y
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
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_RSA=y
# CONFIG_CRYPTO_DH is not set
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=m
CONFIG_CRYPTO_MCRYPTD=y
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_ABLK_HELPER=m
CONFIG_CRYPTO_GLUE_HELPER_X86=m

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XTS=y
CONFIG_CRYPTO_KEYWRAP=m

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
# CONFIG_CRYPTO_CRC32C_INTEL is not set
# CONFIG_CRYPTO_CRC32 is not set
# CONFIG_CRYPTO_CRC32_PCLMUL is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD128=y
CONFIG_CRYPTO_RMD160=y
# CONFIG_CRYPTO_RMD256 is not set
CONFIG_CRYPTO_RMD320=y
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=y
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_SHA3 is not set
CONFIG_CRYPTO_TGR192=m
CONFIG_CRYPTO_WP512=y

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=y
CONFIG_CRYPTO_AES_586=m
# CONFIG_CRYPTO_AES_NI_INTEL is not set
CONFIG_CRYPTO_ANUBIS=y
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
# CONFIG_CRYPTO_CAMELLIA is not set
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=y
CONFIG_CRYPTO_SALSA20=y
# CONFIG_CRYPTO_SALSA20_586 is not set
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_586=m
CONFIG_CRYPTO_TEA=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
# CONFIG_CRYPTO_TWOFISH_586 is not set

#
# Compression
#
# CONFIG_CRYPTO_DEFLATE is not set
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=m
CONFIG_CRYPTO_LZ4=y
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
CONFIG_VIRTUALIZATION=y
# CONFIG_VHOST_NET is not set
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set
# CONFIG_LGUEST is not set
CONFIG_BINARY_PRINTF=y

#
# Library routines
#
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
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
# CONFIG_CRC16 is not set
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
CONFIG_CRC32_BIT=y
CONFIG_CRC7=y
# CONFIG_LIBCRC32C is not set
CONFIG_CRC8=y
# CONFIG_AUDIT_ARCH_COMPAT_GENERIC is not set
CONFIG_RANDOM32_SELFTEST=y
CONFIG_842_COMPRESS=m
CONFIG_842_DECOMPRESS=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=m
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
# CONFIG_XZ_DEC_POWERPC is not set
# CONFIG_XZ_DEC_IA64 is not set
CONFIG_XZ_DEC_ARM=y
# CONFIG_XZ_DEC_ARMTHUMB is not set
# CONFIG_XZ_DEC_SPARC is not set
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=y
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_DEC16=y
CONFIG_BCH=m
CONFIG_RADIX_TREE_MULTIORDER=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
# CONFIG_DMA_NOOP_OPS is not set
# CONFIG_DMA_VIRT_OPS is not set
# CONFIG_CPUMASK_OFFSTACK is not set
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
CONFIG_GLOB_SELFTEST=y
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
# CONFIG_CORDIC is not set
CONFIG_DDR=y
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_OID_REGISTRY=y
# CONFIG_SG_SPLIT is not set
# CONFIG_SG_POOL is not set
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_ARCH_HAS_MMIO_FLUSH=y
CONFIG_STACKDEPOT=y

--a+b56+3nqLzpiR9O--
