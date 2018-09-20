Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A84C2C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 06:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 001102083A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 06:54:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 001102083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbeITMgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 08:36:02 -0400
Received: from mga03.intel.com ([134.134.136.65]:64469 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbeITMgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 08:36:01 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Sep 2018 23:54:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,397,1531810800"; 
   d="gz'50?scan'50,208,50";a="264182556"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.4])
  by fmsmga005.fm.intel.com with ESMTP; 19 Sep 2018 23:53:59 -0700
Date:   Thu, 20 Sep 2018 14:54:21 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        LKP <lkp@01.org>
Subject: [LKP] cde50a6739 [16.916169] WARNING: bad unlock balance detected!
Message-ID: <20180920065421.GA27173@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
User-Agent: Heirloom mailx 12.5 6/20/10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

commit cde50a67397c0da7d11795d4b4418384022ab8e6
Author:     Levin, Alexander (Sasha Levin) <alexander.levin@verizon.com>
AuthorDate: Sun Jun 18 14:06:01 2017 +0000
Commit:     Ingo Molnar <mingo@kernel.org>
CommitDate: Tue Jun 20 11:53:09 2017 +0200

    locking/rtmutex: Don't initialize lockdep when not required
    
    pi_mutex isn't supposed to be tracked by lockdep, but just
    passing NULLs for name and key will cause lockdep to spew a
    warning and die, which is not what we want it to do.
    
    Skip lockdep initialization if the caller passed NULLs for
    name and key, suggesting such initialization isn't desired.
    
    Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
    Cc: Linus Torvalds <torvalds@linux-foundation.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Fixes: f5694788ad8d ("rt_mutex: Add lockdep annotations")
    Link: http://lkml.kernel.org/r/20170618140548.4763-1-alexander.levin@verizon.com
    Signed-off-by: Ingo Molnar <mingo@kernel.org>

018956d641  locking/selftest: Add RT-mutex support
cde50a6739  locking/rtmutex: Don't initialize lockdep when not required
5b945fd2c3  Merge tag 'trace-v4.19-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace
f8dcd02792  Add linux-next specific files for 20180913
+------------------------------------------------------------------+------------+------------+------------+---------------+
|                                                                  | 018956d641 | cde50a6739 | 5b945fd2c3 | next-20180913 |
+------------------------------------------------------------------+------------+------------+------------+---------------+
| boot_successes                                                   | 900        | 488        | 309        | 320           |
| boot_failures                                                    | 10         | 84         | 0          | 2             |
| WARNING:at_kernel/locking/lockdep.c:#lockdep_init_map            | 8          |            |            |               |
| EIP:lockdep_init_map                                             | 8          |            |            |               |
| INFO:rcu_preempt_detected_stalls_on_CPUs/tasks                   | 1          |            |            |               |
| BUG:kernel_hang_in_test_stage                                    | 1          |            |            |               |
| BUG:kernel_hang_in_boot_stage                                    | 1          |            |            |               |
| WARNING:bad_unlock_balance_detected                              | 0          | 79         |            |               |
| is_trying_to_release_lock(rcu_preempt_state)at                   | 0          | 79         |            |               |
| WARNING:at_arch/x86/include/asm/fpu/internal.h:#fpu__restore     | 0          | 2          |            |               |
| EIP:fpu__restore                                                 | 0          | 2          |            |               |
| invoked_oom-killer:gfp_mask=0x                                   | 0          | 2          | 0          | 2             |
| Mem-Info                                                         | 0          | 7          | 0          | 2             |
| EIP:__copy_user_ll                                               | 0          | 1          | 0          | 2             |
| EIP:__put_user_4                                                 | 0          | 1          |            |               |
| Out_of_memory:Kill_process                                       | 0          | 1          | 0          | 2             |
| Kernel_panic-not_syncing:Out_of_memory_and_no_killable_processes | 0          | 1          |            |               |
| calltrace:SyS_setpriority                                        | 0          | 8          |            |               |
| WARNING:at_drivers/pci/pci-sysfs.c:#pci_mmap_resource            | 0          | 2          |            |               |
| EIP:pci_mmap_resource                                            | 0          | 2          |            |               |
| calltrace:SyS_kill                                               | 0          | 1          |            |               |
| EIP:strncpy_from_user                                            | 0          | 1          |            |               |
| Out_of_memory_and_no_killable_processes                          | 0          | 0          | 0          | 2             |
| Kernel_panic-not_syncing:System_is_deadlocked_on_memory          | 0          | 0          | 0          | 2             |
+------------------------------------------------------------------+------------+------------+------------+---------------+

/etc/rcS.d/S00fbsetup: line 3: /sbin/modprobe: No such file or directory
Starting udev
/etc/rcS.d/S03udev: line 72: /proc/sys/kernel/hotplug: No such file or directory
[   16.911383] 
[   16.915139] =====================================
[   16.916169] WARNING: bad unlock balance detected!
[   16.917205] 4.12.0-rc4-00028-gcde50a6 #28 Not tainted
[   16.918273] -------------------------------------
[   16.919311] udevd/356 is trying to release lock (rcu_preempt_state) at:
[   16.920697] [<c10d79d8>] rcu_read_unlock_special+0x348/0x360
[   16.921890] but there are no more locks to release!
[   16.923010] 
[   16.923010] other info that might help us debug this:
[   16.924549] 1 lock held by udevd/356:
[   16.938455]  #0:  (rcu_read_lock){......}, at: [<c1072bef>] SyS_setpriority+0x2f/0x470
[   16.940232] 
[   16.940232] stack backtrace:
[   16.941469] CPU: 0 PID: 356 Comm: udevd Not tainted 4.12.0-rc4-00028-gcde50a6 #28
[   16.943148] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[   16.944986] Call Trace:
[   16.945685]  dump_stack+0x7d/0xb2
[   16.946490]  ? rcu_read_unlock_special+0x348/0x360
[   16.947525]  print_unlock_imbalance_bug+0xe5/0xf0
[   16.948555]  ? rcu_read_unlock_special+0x348/0x360
[   16.949595]  ? rcu_read_unlock_special+0x348/0x360
[   16.950656]  ? rcu_read_unlock_special+0x348/0x360
[   16.951690]  lock_release+0x17c/0x3e0
[   16.965655]  ? swake_up+0x39/0x50
[   16.966566]  rt_mutex_unlock+0x2f/0xa0
[   16.967477]  rcu_read_unlock_special+0x348/0x360
[   16.968533]  ? preempt_schedule_common+0x1c/0x30
[   16.969620]  __rcu_read_unlock+0x67/0x70
[   16.970588]  SyS_setpriority+0x27c/0x470
[   16.971552]  ? SyS_setpriority+0x2f/0x470
[   16.972533]  ? SyS_rt_sigprocmask+0xc6/0xf0
[   16.973550]  do_int80_syscall_32+0x61/0x140
[   16.974558]  entry_INT80_32+0x36/0x36
[   16.975454] EIP: 0x47f3e3e4
[   16.976223] EFLAGS: 00000202 CPU: 0
[   16.977085] EAX: ffffffda EBX: 00000000 ECX: 00000000 EDX: 00000000
[   16.991464] ESI: 08069008 EDI: 00000004 EBP: 08081fa0 ESP: bff6c548
[   16.992831]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b
[   17.325200] blk_update_request: I/O error, dev fd0, sector 0
[   17.326376] floppy: error -5 while reading block 0

                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start v4.13 v4.12 --
git bisect  bad 63a86362130f4c17eaa57f3ef5171ec43111a54e  # 07:47  B     11     1    0   0  Merge tag 'pm-4.13-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
git bisect  bad 090a81d8766e21d33ab3e4d24e6c8e5eedf086dd  # 08:05  B    100     2    0   0  Merge branch 'for-spi' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs
git bisect  bad 3bad2f1c676581d01e7645eb03e9b27e28b0a92e  # 08:23  B    106     1    2   2  Merge branch 'work.misc-set_fs' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs
git bisect  bad 362f6729cbb1d6bbab59e069f19441b0622ff7ec  # 08:47  B     77     1    0   0  Merge tag 'usb-4.13-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
git bisect  bad 6553698be05983056f5561cef6aaee0cc6afe7a0  # 09:13  B     86     1    1   1  Merge branch 'x86-cleanups-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect  bad 892ad5acca0b2ddb514fae63fa4686bf726d2471  # 09:41  B     75     1    0   0  Merge branch 'locking-core-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 26d3a77d2cb3cb31bbaa2de37b7a4e6375f204ee  # 10:10  G    310     0    1   1  Merge tag 'edac_for_4.13' of git://git.kernel.org/pub/scm/linux/kernel/git/bp/bp
git bisect good 330e9e46253cbfab178450c976aa90ef0f3ae940  # 10:40  G    301     0    1   1  Merge branch 'core-rcu-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 162b246eb420d2ca2002a50917c897b10c9aba09  # 11:06  G    300     0    0   0  Merge branch 'efi-core-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 12d83f7361724e5aa4299bb28e4caadc62ae482b  # 11:49  G    305     0    0  81  tools/include: Add (mostly) empty include/linux/sched/mm.h
git bisect good 3942b77121986519ee52ab4dd4ae8f4383dfe765  # 12:14  G    309     0    0  74  MAINTAINERS: Claim atomic*_t maintainership
git bisect  bad cde50a67397c0da7d11795d4b4418384022ab8e6  # 12:20  B     11     1    0  21  locking/rtmutex: Don't initialize lockdep when not required
git bisect good cfb6133399a490419cda55fcdcf9dbbca65eacba  # 12:54  G    303     0    4 167  locking/selftest: Remove the bad unlock ordering test
git bisect good 018956d6419be3e5ff5aacc60b2a3cff585adee1  # 13:15  G    310     0    0   0  locking/selftest: Add RT-mutex support
# first bad commit: [cde50a67397c0da7d11795d4b4418384022ab8e6] locking/rtmutex: Don't initialize lockdep when not required
git bisect good 018956d6419be3e5ff5aacc60b2a3cff585adee1  # 13:45  G    909     0    9   9  locking/selftest: Add RT-mutex support
# extra tests with debug options
git bisect  bad cde50a67397c0da7d11795d4b4418384022ab8e6  # 13:54  B     40     2    0   0  locking/rtmutex: Don't initialize lockdep when not required
# extra tests on HEAD of internal-chrome-os/chromeos-4.14
git bisect  bad 398e4407ff49740beb32f7e4b062a1eea57d9487  # 13:54  B     73     2    0   4  CHROMIUM: arm64: dts: qcom: Switch edp regulator to load switch
# extra tests on tree/branch linus/master
git bisect good 5b945fd2c34c6324752fc793266b4598a307d765  # 14:22  G    306     0    5   5  Merge tag 'trace-v4.19-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace
# extra tests with first bad commit reverted
git bisect good c4ed1913cb01110119247ed7b1a098626a954418  # 14:48  G    304     0  305 305  Revert "locking/rtmutex: Don't initialize lockdep when not required"
# extra tests on tree/branch linux-next/master
git bisect good f8dcd02792146c5047419ff4c856651acd04f7c6  # 15:13  G    310     0    0   2  Add linux-next specific files for 20180913

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/lkp                          Intel Corporation

--CE+1k2dSO48ffgeK
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-yocto-lkp-hsw01-53:20180915122104:i386-randconfig-v1-201836:4.12.0-rc4-00028-gcde50a6:28.gz"
Content-Transfer-Encoding: base64

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

--CE+1k2dSO48ffgeK
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-quantal-ivb41-110:20180915133407:i386-randconfig-v1-201836:4.12.0-rc4-00027-g018956d:1.gz"
Content-Transfer-Encoding: base64

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
IAEA

--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reproduce-yocto-lkp-hsw01-53:20180915122104:i386-randconfig-v1-201836:4.12.0-rc4-00028-gcde50a6:28"

#!/bin/bash

kernel=$1
initrd=yocto-trinity-i386.cgz

wget --no-clobber https://github.com/fengguang/reproduce-kernel-bug/raw/master/yocto/$initrd

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

--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-4.12.0-rc4-00028-gcde50a6"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 4.12.0-rc4 Kernel Configuration
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
CONFIG_KERNEL_LZMA=y
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
# CONFIG_SWAP is not set
# CONFIG_SYSVIPC is not set
# CONFIG_POSIX_MQUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_FHANDLE=y
CONFIG_USELIB=y
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
CONFIG_IRQ_DOMAIN_DEBUG=y
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
CONFIG_HIGH_RES_TIMERS=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
# CONFIG_TASKSTATS is not set

#
# RCU Subsystem
#
CONFIG_PREEMPT_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
# CONFIG_CLASSIC_SRCU is not set
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=32
CONFIG_RCU_FANOUT_LEAF=16
CONFIG_RCU_FAST_NO_HZ=y
# CONFIG_TREE_RCU_TRACE is not set
CONFIG_RCU_BOOST=y
CONFIG_RCU_KTHREAD_PRIO=1
CONFIG_RCU_BOOST_DELAY=500
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
# CONFIG_MEMCG is not set
CONFIG_BLK_CGROUP=y
# CONFIG_DEBUG_BLK_CGROUP is not set
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_CGROUP_PIDS=y
# CONFIG_CGROUP_RDMA is not set
# CONFIG_CGROUP_FREEZER is not set
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
# CONFIG_CGROUP_BPF is not set
# CONFIG_CGROUP_DEBUG is not set
# CONFIG_SOCK_CGROUP_DATA is not set
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
# CONFIG_USER_NS is not set
CONFIG_PID_NS=y
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
# CONFIG_EXPERT is not set
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_POSIX_TIMERS=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
# CONFIG_KALLSYMS_ABSOLUTE_PERCPU is not set
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
CONFIG_MEMBARRIER=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PC104=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_COMPAT_BRK=y
CONFIG_SLAB=y
# CONFIG_SLUB is not set
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SYSTEM_DATA_VERIFICATION is not set
# CONFIG_PROFILING is not set
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
# CONFIG_KPROBES is not set
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
# CONFIG_GCC_PLUGINS is not set
CONFIG_HAVE_CC_STACKPROTECTOR=y
CONFIG_CC_STACKPROTECTOR=y
# CONFIG_CC_STACKPROTECTOR_NONE is not set
# CONFIG_CC_STACKPROTECTOR_REGULAR is not set
CONFIG_CC_STACKPROTECTOR_STRONG=y
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
CONFIG_SLABINFO=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
CONFIG_MODULE_COMPRESS=y
CONFIG_MODULE_COMPRESS_GZIP=y
# CONFIG_MODULE_COMPRESS_XZ is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_LBDAF=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
# CONFIG_BLK_DEV_INTEGRITY is not set
CONFIG_BLK_DEV_ZONED=y
# CONFIG_BLK_DEV_THROTTLING is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
CONFIG_BLK_WBT=y
# CONFIG_BLK_WBT_SQ is not set
# CONFIG_BLK_WBT_MQ is not set
# CONFIG_BLK_DEBUG_FS is not set
CONFIG_BLK_SED_OPAL=y

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_DEADLINE=m
CONFIG_IOSCHED_CFQ=y
# CONFIG_CFQ_GROUP_IOSCHED is not set
CONFIG_DEFAULT_CFQ=y
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="cfq"
# CONFIG_MQ_IOSCHED_DEADLINE is not set
CONFIG_MQ_IOSCHED_KYBER=m
CONFIG_IOSCHED_BFQ=m
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
# CONFIG_FREEZER is not set

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_FAST_FEATURE_TESTS=y
# CONFIG_X86_MPPARSE is not set
CONFIG_X86_BIGSMP=y
# CONFIG_GOLDFISH is not set
# CONFIG_INTEL_RDT_A is not set
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
# CONFIG_X86_INTEL_QUARK is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
# CONFIG_IOSF_MBI is not set
CONFIG_X86_RDC321X=y
CONFIG_X86_32_NON_STANDARD=y
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_STA2X11 is not set
CONFIG_X86_32_IRIS=m
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
# CONFIG_PARAVIRT_SPINLOCKS is not set
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
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_TRANSMETA_32=y
CONFIG_HPET_TIMER=y
CONFIG_DMI=y
CONFIG_SWIOTLB=y
CONFIG_IOMMU_HELPER=y
CONFIG_NR_CPUS=32
# CONFIG_SCHED_SMT is not set
CONFIG_SCHED_MC=y
# CONFIG_SCHED_MC_PRIO is not set
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
# CONFIG_X86_ANCIENT_MCE is not set
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m
CONFIG_X86_THERMAL_VECTOR=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
CONFIG_PERF_EVENTS_AMD_POWER=y
CONFIG_X86_LEGACY_VM86=y
CONFIG_VM86=y
CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX32=y
CONFIG_TOSHIBA=m
# CONFIG_I8K is not set
CONFIG_X86_REBOOTFIXUPS=y
CONFIG_MICROCODE=y
# CONFIG_MICROCODE_INTEL is not set
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_X86_PAE=y
CONFIG_ARCH_PHYS_ADDR_T_64BIT=y
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
# CONFIG_COMPACTION is not set
CONFIG_MIGRATION=y
CONFIG_PHYS_ADDR_T_64BIT=y
# CONFIG_BOUNCE is not set
CONFIG_VIRT_TO_BUS=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_MEMORY_FAILURE is not set
# CONFIG_TRANSPARENT_HUGEPAGE is not set
CONFIG_CLEANCACHE=y
CONFIG_CMA=y
CONFIG_CMA_DEBUG=y
CONFIG_CMA_DEBUGFS=y
CONFIG_CMA_AREAS=7
# CONFIG_ZPOOL is not set
# CONFIG_ZBUD is not set
# CONFIG_ZSMALLOC is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_X86_RESERVE_LOW=64
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_MTRR_SANITIZER is not set
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
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
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_HOTPLUG_CPU=y
# CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
CONFIG_DEBUG_HOTPLUG_CPU0=y
CONFIG_COMPAT_VDSO=y
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
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
CONFIG_ACPI_HOTPLUG_CPU=y
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
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
# CONFIG_ACPI_NFIT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
# CONFIG_DPTF_POWER is not set
# CONFIG_ACPI_EXTLOG is not set
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_SFI=y

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is not set
CONFIG_INTEL_IDLE=y

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
# CONFIG_PCIEPORTBUS is not set
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

#
# PCI Endpoint
#
CONFIG_PCI_ENDPOINT=y
CONFIG_PCI_ENDPOINT_CONFIGFS=y
# CONFIG_PCI_EPF_TEST is not set

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
CONFIG_ISA_DMA_API=y
CONFIG_ISA=y
CONFIG_EISA=y
# CONFIG_EISA_VLB_PRIMING is not set
CONFIG_EISA_PCI_EISA=y
# CONFIG_EISA_VIRTUAL_ROOT is not set
CONFIG_EISA_NAMES=y
# CONFIG_SCx200 is not set
# CONFIG_ALIX is not set
CONFIG_NET5501=y
CONFIG_GEOS=y
CONFIG_AMD_NB=y
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set
# CONFIG_X86_SYSFB is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
CONFIG_BINFMT_SCRIPT=y
CONFIG_HAVE_AOUT=y
# CONFIG_BINFMT_AOUT is not set
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
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_STANDALONE is not set
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=y
# CONFIG_FIRMWARE_IN_KERNEL is not set
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
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
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y
# CONFIG_DMA_CMA is not set

#
# Bus devices
#
# CONFIG_CONNECTOR is not set
CONFIG_MTD=y
# CONFIG_MTD_TESTS is not set
CONFIG_MTD_REDBOOT_PARTS=y
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED=y
# CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
# CONFIG_MTD_CMDLINE_PARTS is not set
# CONFIG_MTD_OF_PARTS is not set
# CONFIG_MTD_AR7_PARTS is not set

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=y
CONFIG_MTD_BLOCK=m
CONFIG_MTD_BLOCK_RO=m
CONFIG_FTL=y
CONFIG_NFTL=m
CONFIG_NFTL_RW=y
CONFIG_INFTL=y
# CONFIG_RFD_FTL is not set
CONFIG_SSFDC=m
CONFIG_SM_FTL=y
CONFIG_MTD_OOPS=m
CONFIG_MTD_PARTITIONED_MASTER=y

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=m
CONFIG_MTD_JEDECPROBE=y
CONFIG_MTD_GEN_PROBE=y
CONFIG_MTD_CFI_ADV_OPTIONS=y
# CONFIG_MTD_CFI_NOSWAP is not set
# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
CONFIG_MTD_CFI_LE_BYTE_SWAP=y
CONFIG_MTD_CFI_GEOMETRY=y
# CONFIG_MTD_MAP_BANK_WIDTH_1 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_2 is not set
CONFIG_MTD_MAP_BANK_WIDTH_4=y
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
CONFIG_MTD_MAP_BANK_WIDTH_16=y
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
# CONFIG_MTD_CFI_I1 is not set
# CONFIG_MTD_CFI_I2 is not set
CONFIG_MTD_CFI_I4=y
# CONFIG_MTD_CFI_I8 is not set
# CONFIG_MTD_OTP is not set
CONFIG_MTD_CFI_INTELEXT=y
CONFIG_MTD_CFI_AMDSTD=y
CONFIG_MTD_CFI_STAA=y
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=y
CONFIG_MTD_ROM=m
CONFIG_MTD_ABSENT=m

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
CONFIG_MTD_PHYSMAP=m
# CONFIG_MTD_PHYSMAP_COMPAT is not set
CONFIG_MTD_PHYSMAP_OF=y
# CONFIG_MTD_PHYSMAP_OF_VERSATILE is not set
CONFIG_MTD_PHYSMAP_OF_GEMINI=y
CONFIG_MTD_SBC_GXX=y
# CONFIG_MTD_AMD76XROM is not set
CONFIG_MTD_ICHXROM=y
# CONFIG_MTD_ESB2ROM is not set
# CONFIG_MTD_CK804XROM is not set
# CONFIG_MTD_SCB2_FLASH is not set
CONFIG_MTD_NETtel=m
CONFIG_MTD_L440GX=y
# CONFIG_MTD_PCI is not set
CONFIG_MTD_GPIO_ADDR=y
# CONFIG_MTD_INTEL_VR_NOR is not set
CONFIG_MTD_PLATRAM=y
# CONFIG_MTD_LATCH_ADDR is not set

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
CONFIG_MTD_DATAFLASH=y
CONFIG_MTD_DATAFLASH_WRITE_VERIFY=y
CONFIG_MTD_DATAFLASH_OTP=y
CONFIG_MTD_SST25L=m
# CONFIG_MTD_SLRAM is not set
CONFIG_MTD_PHRAM=y
CONFIG_MTD_MTDRAM=m
CONFIG_MTDRAM_TOTAL_SIZE=4096
CONFIG_MTDRAM_ERASE_SIZE=128
CONFIG_MTD_BLOCK2MTD=m

#
# Disk-On-Chip Device Drivers
#
CONFIG_MTD_DOCG3=m
CONFIG_BCH_CONST_M=14
CONFIG_BCH_CONST_T=4
CONFIG_MTD_NAND_ECC=y
CONFIG_MTD_NAND_ECC_SMC=y
CONFIG_MTD_NAND=m
# CONFIG_MTD_NAND_ECC_BCH is not set
# CONFIG_MTD_SM_COMMON is not set
# CONFIG_MTD_NAND_DENALI_PCI is not set
# CONFIG_MTD_NAND_DENALI_DT is not set
# CONFIG_MTD_NAND_GPIO is not set
# CONFIG_MTD_NAND_OMAP_BCH_BUILD is not set
# CONFIG_MTD_NAND_RICOH is not set
CONFIG_MTD_NAND_DISKONCHIP=m
CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED=y
CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=0
# CONFIG_MTD_NAND_DISKONCHIP_PROBE_HIGH is not set
# CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE is not set
CONFIG_MTD_NAND_DOCG4=m
# CONFIG_MTD_NAND_CAFE is not set
# CONFIG_MTD_NAND_CS553X is not set
# CONFIG_MTD_NAND_NANDSIM is not set
CONFIG_MTD_NAND_PLATFORM=m
# CONFIG_MTD_NAND_HISI504 is not set
# CONFIG_MTD_NAND_MTK is not set
CONFIG_MTD_ONENAND=m
# CONFIG_MTD_ONENAND_VERIFY_WRITE is not set
# CONFIG_MTD_ONENAND_GENERIC is not set
CONFIG_MTD_ONENAND_OTP=y
# CONFIG_MTD_ONENAND_2X_PROGRAM is not set

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=m
CONFIG_MTD_QINFO_PROBE=m
# CONFIG_MTD_SPI_NOR is not set
CONFIG_MTD_UBI=y
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
# CONFIG_MTD_UBI_GLUEBI is not set
# CONFIG_MTD_UBI_BLOCK is not set
CONFIG_DTC=y
CONFIG_OF=y
CONFIG_OF_UNITTEST=y
CONFIG_OF_FLATTREE=y
CONFIG_OF_EARLY_FLATTREE=y
# CONFIG_OF_DYNAMIC is not set
CONFIG_OF_ADDRESS=y
CONFIG_OF_ADDRESS_PCI=y
CONFIG_OF_IRQ=y
CONFIG_OF_NET=y
CONFIG_OF_PCI=y
CONFIG_OF_PCI_IRQ=y
CONFIG_OF_RESOLVE=y
# CONFIG_OF_OVERLAY is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
# CONFIG_PARPORT_GSC is not set
CONFIG_PARPORT_AX88796=m
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_ISAPNP=y
# CONFIG_PNPBIOS is not set
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
CONFIG_BLK_DEV_FD=y
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
CONFIG_BLK_DEV_CRYPTOLOOP=y
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
# CONFIG_BLK_DEV_RAM_DAX is not set
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
CONFIG_CDROM_PKTCDVD_WCACHE=y
# CONFIG_ATA_OVER_ETH is not set
CONFIG_VIRTIO_BLK=m
# CONFIG_VIRTIO_BLK_SCSI is not set
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_RSXX is not set
CONFIG_NVME_CORE=y
# CONFIG_BLK_DEV_NVME is not set
# CONFIG_BLK_DEV_NVME_SCSI is not set
CONFIG_NVME_FABRICS=y
CONFIG_NVME_FC=y
# CONFIG_NVME_TARGET is not set

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
CONFIG_AD525X_DPOT=y
CONFIG_AD525X_DPOT_I2C=y
# CONFIG_AD525X_DPOT_SPI is not set
CONFIG_DUMMY_IRQ=y
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_SGI_IOC4 is not set
# CONFIG_TIFM_CORE is not set
CONFIG_ICS932S401=y
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_HP_ILO is not set
# CONFIG_APDS9802ALS is not set
# CONFIG_ISL29003 is not set
# CONFIG_ISL29020 is not set
# CONFIG_SENSORS_TSL2550 is not set
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=y
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_TI_DAC7512=y
# CONFIG_PCH_PHUB is not set
CONFIG_USB_SWITCH_FSA9480=y
# CONFIG_LATTICE_ECP3_CONFIG is not set
CONFIG_SRAM=y
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
CONFIG_EEPROM_AT25=m
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
CONFIG_EEPROM_93XX46=m
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
CONFIG_SENSORS_LIS3_I2C=y

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
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
# CONFIG_SCSI_NETLINK is not set
# CONFIG_SCSI_MQ_DEFAULT is not set
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=m
CONFIG_CHR_DEV_OSST=y
CONFIG_BLK_DEV_SR=y
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
CONFIG_SCSI_SAS_ATTRS=y
CONFIG_SCSI_SAS_LIBSAS=y
# CONFIG_SCSI_SAS_ATA is not set
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# CONFIG_SCSI_LOWLEVEL is not set
CONFIG_SCSI_DH=y
# CONFIG_SCSI_DH_RDAC is not set
# CONFIG_SCSI_DH_HP_SW is not set
CONFIG_SCSI_DH_EMC=m
CONFIG_SCSI_DH_ALUA=m
CONFIG_SCSI_OSD_INITIATOR=m
CONFIG_SCSI_OSD_ULD=m
CONFIG_SCSI_OSD_DPRINT_SENSE=1
# CONFIG_SCSI_OSD_DEBUG is not set
CONFIG_ATA=y
# CONFIG_ATA_NONSTANDARD is not set
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
# CONFIG_SATA_PMP is not set

#
# Controllers with non-SFF native interface
#
# CONFIG_SATA_AHCI is not set
# CONFIG_SATA_AHCI_PLATFORM is not set
CONFIG_AHCI_CEVA=m
# CONFIG_AHCI_QORIQ is not set
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
# CONFIG_ATA_SFF is not set
# CONFIG_MD is not set
# CONFIG_TARGET_CORE is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=y
# CONFIG_FIREWIRE_OHCI is not set
# CONFIG_FIREWIRE_SBP2 is not set
# CONFIG_FIREWIRE_NET is not set
# CONFIG_FIREWIRE_NOSY is not set
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
CONFIG_MDIO=m
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL3 is not set
# CONFIG_3C515 is not set
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
# CONFIG_LANCE is not set
# CONFIG_PCNET32 is not set
# CONFIG_NI65 is not set
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
CONFIG_NET_VENDOR_CIRRUS=y
# CONFIG_CS89x0 is not set
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
# CONFIG_EZCHIP_NPS_MANAGEMENT_ENET is not set
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
# CONFIG_NE2000 is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_ULTRA is not set
# CONFIG_WD80x3 is not set
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
# CONFIG_QCA7000 is not set
# CONFIG_QCOM_EMAC is not set
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
# CONFIG_SMC9194 is not set
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
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_MDIO_DEVICE is not set
# CONFIG_PHYLIB is not set
# CONFIG_MICREL_KS8995MA is not set
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
CONFIG_NVM=y
# CONFIG_NVM_DEBUG is not set
CONFIG_NVM_RRPC=m
# CONFIG_NVM_PBLK is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=m
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=y
CONFIG_INPUT_SPARSEKMAP=m
CONFIG_INPUT_MATRIXKMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_EVBUG=y

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ADC=m
CONFIG_KEYBOARD_ADP5520=y
CONFIG_KEYBOARD_ADP5588=y
CONFIG_KEYBOARD_ADP5589=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_QT1070=y
CONFIG_KEYBOARD_QT2160=y
CONFIG_KEYBOARD_LKKBD=m
CONFIG_KEYBOARD_GPIO=y
CONFIG_KEYBOARD_GPIO_POLLED=m
CONFIG_KEYBOARD_TCA6416=m
CONFIG_KEYBOARD_TCA8418=y
CONFIG_KEYBOARD_MATRIX=m
# CONFIG_KEYBOARD_LM8323 is not set
CONFIG_KEYBOARD_LM8333=m
# CONFIG_KEYBOARD_MAX7359 is not set
CONFIG_KEYBOARD_MCS=y
CONFIG_KEYBOARD_MPR121=y
CONFIG_KEYBOARD_NEWTON=y
CONFIG_KEYBOARD_OPENCORES=m
# CONFIG_KEYBOARD_SAMSUNG is not set
CONFIG_KEYBOARD_STOWAWAY=m
CONFIG_KEYBOARD_SUNKBD=m
# CONFIG_KEYBOARD_STMPE is not set
CONFIG_KEYBOARD_OMAP4=m
# CONFIG_KEYBOARD_TC3589X is not set
CONFIG_KEYBOARD_TM2_TOUCHKEY=y
CONFIG_KEYBOARD_TWL4030=m
CONFIG_KEYBOARD_XTKBD=y
# CONFIG_KEYBOARD_CROS_EC is not set
CONFIG_KEYBOARD_CAP11XX=y
# CONFIG_KEYBOARD_BCM is not set
CONFIG_INPUT_MOUSE=y
# CONFIG_MOUSE_PS2 is not set
CONFIG_MOUSE_SERIAL=y
CONFIG_MOUSE_APPLETOUCH=m
CONFIG_MOUSE_BCM5974=y
CONFIG_MOUSE_CYAPA=m
# CONFIG_MOUSE_ELAN_I2C is not set
CONFIG_MOUSE_INPORT=m
# CONFIG_MOUSE_ATIXL is not set
CONFIG_MOUSE_LOGIBM=y
# CONFIG_MOUSE_PC110PAD is not set
CONFIG_MOUSE_VSXXXAA=y
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
CONFIG_MOUSE_SYNAPTICS_USB=m
CONFIG_INPUT_JOYSTICK=y
# CONFIG_JOYSTICK_ANALOG is not set
CONFIG_JOYSTICK_A3D=m
# CONFIG_JOYSTICK_ADI is not set
CONFIG_JOYSTICK_COBRA=m
CONFIG_JOYSTICK_GF2K=y
CONFIG_JOYSTICK_GRIP=m
CONFIG_JOYSTICK_GRIP_MP=m
CONFIG_JOYSTICK_GUILLEMOT=m
CONFIG_JOYSTICK_INTERACT=m
CONFIG_JOYSTICK_SIDEWINDER=m
# CONFIG_JOYSTICK_TMDC is not set
CONFIG_JOYSTICK_IFORCE=y
CONFIG_JOYSTICK_IFORCE_USB=y
# CONFIG_JOYSTICK_IFORCE_232 is not set
CONFIG_JOYSTICK_WARRIOR=y
CONFIG_JOYSTICK_MAGELLAN=m
CONFIG_JOYSTICK_SPACEORB=m
CONFIG_JOYSTICK_SPACEBALL=m
CONFIG_JOYSTICK_STINGER=m
CONFIG_JOYSTICK_TWIDJOY=y
CONFIG_JOYSTICK_ZHENHUA=m
# CONFIG_JOYSTICK_DB9 is not set
CONFIG_JOYSTICK_GAMECON=m
CONFIG_JOYSTICK_TURBOGRAFX=m
# CONFIG_JOYSTICK_AS5011 is not set
# CONFIG_JOYSTICK_JOYDUMP is not set
CONFIG_JOYSTICK_XPAD=m
CONFIG_JOYSTICK_XPAD_FF=y
CONFIG_JOYSTICK_XPAD_LEDS=y
# CONFIG_JOYSTICK_WALKERA0701 is not set
# CONFIG_JOYSTICK_PSXPAD_SPI is not set
# CONFIG_INPUT_TABLET is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
CONFIG_TOUCHSCREEN_ADS7846=m
CONFIG_TOUCHSCREEN_AD7877=m
CONFIG_TOUCHSCREEN_AD7879=m
CONFIG_TOUCHSCREEN_AD7879_I2C=m
CONFIG_TOUCHSCREEN_AD7879_SPI=m
# CONFIG_TOUCHSCREEN_AR1021_I2C is not set
# CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
CONFIG_TOUCHSCREEN_AUO_PIXCIR=y
# CONFIG_TOUCHSCREEN_BU21013 is not set
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8318 is not set
CONFIG_TOUCHSCREEN_CY8CTMG110=m
CONFIG_TOUCHSCREEN_CYTTSP_CORE=y
# CONFIG_TOUCHSCREEN_CYTTSP_I2C is not set
CONFIG_TOUCHSCREEN_CYTTSP_SPI=m
CONFIG_TOUCHSCREEN_CYTTSP4_CORE=y
CONFIG_TOUCHSCREEN_CYTTSP4_I2C=y
CONFIG_TOUCHSCREEN_CYTTSP4_SPI=m
# CONFIG_TOUCHSCREEN_DYNAPRO is not set
CONFIG_TOUCHSCREEN_HAMPSHIRE=y
CONFIG_TOUCHSCREEN_EETI=y
CONFIG_TOUCHSCREEN_EGALAX=m
CONFIG_TOUCHSCREEN_EGALAX_SERIAL=m
CONFIG_TOUCHSCREEN_FUJITSU=y
# CONFIG_TOUCHSCREEN_GOODIX is not set
CONFIG_TOUCHSCREEN_ILI210X=y
# CONFIG_TOUCHSCREEN_GUNZE is not set
CONFIG_TOUCHSCREEN_EKTF2127=y
CONFIG_TOUCHSCREEN_ELAN=m
CONFIG_TOUCHSCREEN_ELO=y
CONFIG_TOUCHSCREEN_WACOM_W8001=y
CONFIG_TOUCHSCREEN_WACOM_I2C=y
# CONFIG_TOUCHSCREEN_MAX11801 is not set
# CONFIG_TOUCHSCREEN_MCS5000 is not set
CONFIG_TOUCHSCREEN_MMS114=y
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
# CONFIG_TOUCHSCREEN_MTOUCH is not set
CONFIG_TOUCHSCREEN_IMX6UL_TSC=y
# CONFIG_TOUCHSCREEN_INEXIO is not set
# CONFIG_TOUCHSCREEN_MK712 is not set
CONFIG_TOUCHSCREEN_HTCPEN=m
CONFIG_TOUCHSCREEN_PENMOUNT=m
# CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
CONFIG_TOUCHSCREEN_TOUCHRIGHT=y
CONFIG_TOUCHSCREEN_TOUCHWIN=m
CONFIG_TOUCHSCREEN_TI_AM335X_TSC=m
# CONFIG_TOUCHSCREEN_PIXCIR is not set
CONFIG_TOUCHSCREEN_WDT87XX_I2C=y
CONFIG_TOUCHSCREEN_WM97XX=m
# CONFIG_TOUCHSCREEN_WM9705 is not set
CONFIG_TOUCHSCREEN_WM9712=y
CONFIG_TOUCHSCREEN_WM9713=y
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
CONFIG_TOUCHSCREEN_MC13783=m
CONFIG_TOUCHSCREEN_TOUCHIT213=m
# CONFIG_TOUCHSCREEN_TSC_SERIO is not set
CONFIG_TOUCHSCREEN_TSC200X_CORE=m
CONFIG_TOUCHSCREEN_TSC2004=m
# CONFIG_TOUCHSCREEN_TSC2005 is not set
# CONFIG_TOUCHSCREEN_TSC2007 is not set
CONFIG_TOUCHSCREEN_RM_TS=y
# CONFIG_TOUCHSCREEN_SILEAD is not set
CONFIG_TOUCHSCREEN_SIS_I2C=m
CONFIG_TOUCHSCREEN_ST1232=m
CONFIG_TOUCHSCREEN_STMPE=y
CONFIG_TOUCHSCREEN_SURFACE3_SPI=m
CONFIG_TOUCHSCREEN_SX8654=y
# CONFIG_TOUCHSCREEN_TPS6507X is not set
# CONFIG_TOUCHSCREEN_ZET6223 is not set
# CONFIG_TOUCHSCREEN_ZFORCE is not set
# CONFIG_TOUCHSCREEN_COLIBRI_VF50 is not set
CONFIG_TOUCHSCREEN_ROHM_BU21023=m
CONFIG_INPUT_MISC=y
CONFIG_INPUT_88PM80X_ONKEY=y
# CONFIG_INPUT_AD714X is not set
CONFIG_INPUT_ATMEL_CAPTOUCH=m
# CONFIG_INPUT_BMA150 is not set
CONFIG_INPUT_E3X0_BUTTON=m
# CONFIG_INPUT_PCSPKR is not set
# CONFIG_INPUT_MAX77693_HAPTIC is not set
# CONFIG_INPUT_MC13783_PWRBUTTON is not set
CONFIG_INPUT_MMA8450=y
CONFIG_INPUT_APANEL=m
CONFIG_INPUT_GP2A=y
CONFIG_INPUT_GPIO_BEEPER=m
# CONFIG_INPUT_GPIO_TILT_POLLED is not set
CONFIG_INPUT_GPIO_DECODER=m
# CONFIG_INPUT_CPCAP_PWRBUTTON is not set
CONFIG_INPUT_WISTRON_BTNS=m
# CONFIG_INPUT_ATLAS_BTNS is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
CONFIG_INPUT_KEYSPAN_REMOTE=y
CONFIG_INPUT_KXTJ9=y
# CONFIG_INPUT_KXTJ9_POLLED_MODE is not set
CONFIG_INPUT_POWERMATE=y
CONFIG_INPUT_YEALINK=y
CONFIG_INPUT_CM109=y
CONFIG_INPUT_REGULATOR_HAPTIC=y
# CONFIG_INPUT_AXP20X_PEK is not set
# CONFIG_INPUT_TWL4030_PWRBUTTON is not set
CONFIG_INPUT_TWL4030_VIBRA=m
CONFIG_INPUT_TWL6040_VIBRA=y
CONFIG_INPUT_UINPUT=m
CONFIG_INPUT_PCF50633_PMU=y
# CONFIG_INPUT_PCF8574 is not set
CONFIG_INPUT_PWM_BEEPER=y
# CONFIG_INPUT_GPIO_ROTARY_ENCODER is not set
# CONFIG_INPUT_DA9055_ONKEY is not set
CONFIG_INPUT_DA9063_ONKEY=m
CONFIG_INPUT_ADXL34X=m
CONFIG_INPUT_ADXL34X_I2C=m
CONFIG_INPUT_ADXL34X_SPI=m
CONFIG_INPUT_IMS_PCU=m
# CONFIG_INPUT_CMA3000 is not set
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
CONFIG_INPUT_SOC_BUTTON_ARRAY=m
# CONFIG_INPUT_DRV260X_HAPTICS is not set
CONFIG_INPUT_DRV2665_HAPTICS=y
CONFIG_INPUT_DRV2667_HAPTICS=y
# CONFIG_RMI4_CORE is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=m
CONFIG_SERIO_CT82C710=m
CONFIG_SERIO_PARKBD=m
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
# CONFIG_SERIO_ALTERA_PS2 is not set
# CONFIG_SERIO_PS2MULT is not set
# CONFIG_SERIO_ARC_PS2 is not set
CONFIG_SERIO_APBPS2=m
CONFIG_USERIO=y
CONFIG_GAMEPORT=y
# CONFIG_GAMEPORT_NS558 is not set
CONFIG_GAMEPORT_L4=m
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_FM801 is not set

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_SERIAL_NONSTANDARD=y
CONFIG_ROCKETPORT=y
CONFIG_CYCLADES=m
# CONFIG_CYZ_INTR is not set
CONFIG_MOXA_INTELLIO=y
CONFIG_MOXA_SMARTIO=m
# CONFIG_SYNCLINK is not set
# CONFIG_SYNCLINKMP is not set
# CONFIG_SYNCLINK_GT is not set
# CONFIG_NOZOMI is not set
# CONFIG_ISI is not set
CONFIG_N_HDLC=y
# CONFIG_N_GSM is not set
CONFIG_TRACE_ROUTER=m
CONFIG_TRACE_SINK=m
CONFIG_DEVMEM=y
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
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
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
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
CONFIG_SERIAL_UARTLITE=y
# CONFIG_SERIAL_UARTLITE_CONSOLE is not set
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_SERIAL_SCCNXP=y
# CONFIG_SERIAL_SCCNXP_CONSOLE is not set
CONFIG_SERIAL_SC16IS7XX_CORE=y
CONFIG_SERIAL_SC16IS7XX=y
CONFIG_SERIAL_SC16IS7XX_I2C=y
# CONFIG_SERIAL_SC16IS7XX_SPI is not set
CONFIG_SERIAL_TIMBERDALE=y
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
CONFIG_SERIAL_ALTERA_UART=m
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
# CONFIG_SERIAL_IFX6X60 is not set
# CONFIG_SERIAL_PCH_UART is not set
CONFIG_SERIAL_XILINX_PS_UART=y
# CONFIG_SERIAL_XILINX_PS_UART_CONSOLE is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
CONFIG_SERIAL_CONEXANT_DIGICOLOR=m
CONFIG_SERIAL_MEN_Z135=m
CONFIG_SERIAL_DEV_BUS=y
CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
CONFIG_PRINTER=m
CONFIG_LP_CONSOLE=y
# CONFIG_PPDEV is not set
CONFIG_HVC_DRIVER=y
CONFIG_VIRTIO_CONSOLE=y
# CONFIG_IPMI_HANDLER is not set
CONFIG_HW_RANDOM=m
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
CONFIG_HW_RANDOM_GEODE=m
# CONFIG_HW_RANDOM_VIA is not set
CONFIG_HW_RANDOM_VIRTIO=m
CONFIG_HW_RANDOM_TPM=m
CONFIG_NVRAM=m
# CONFIG_DTLK is not set
CONFIG_R3964=y
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set
# CONFIG_MWAVE is not set
CONFIG_PC8736x_GPIO=y
CONFIG_NSC_GPIO=y
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=256
# CONFIG_HPET is not set
# CONFIG_HANGCHECK_TIMER is not set
CONFIG_TCG_TPM=m
CONFIG_TCG_TIS_CORE=m
CONFIG_TCG_TIS=m
CONFIG_TCG_TIS_SPI=m
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
# CONFIG_TCG_TIS_I2C_NUVOTON is not set
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
# CONFIG_TCG_CRB is not set
CONFIG_TCG_VTPM_PROXY=m
CONFIG_TCG_TIS_ST33ZP24=m
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
CONFIG_TCG_TIS_ST33ZP24_SPI=m
CONFIG_TELCLOCK=y
# CONFIG_DEVPORT is not set
CONFIG_XILLYBUS=m
# CONFIG_XILLYBUS_OF is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
# CONFIG_I2C_CHARDEV is not set
# CONFIG_I2C_MUX is not set
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
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EG20T is not set
# CONFIG_I2C_EMEV2 is not set
CONFIG_I2C_GPIO=m
CONFIG_I2C_KEMPLD=m
CONFIG_I2C_OCORES=m
CONFIG_I2C_PCA_PLATFORM=y
# CONFIG_I2C_PXA is not set
# CONFIG_I2C_PXA_PCI is not set
# CONFIG_I2C_RK3X is not set
# CONFIG_I2C_SIMTEC is not set
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=y
CONFIG_I2C_DLN2=m
# CONFIG_I2C_PARPORT is not set
CONFIG_I2C_PARPORT_LIGHT=m
CONFIG_I2C_ROBOTFUZZ_OSIF=m
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=m

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_PCA_ISA=m
# CONFIG_I2C_CROS_EC_TUNNEL is not set
# CONFIG_SCx200_ACB is not set
CONFIG_I2C_STUB=m
CONFIG_I2C_SLAVE=y
# CONFIG_I2C_SLAVE_EEPROM is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
CONFIG_SPI=y
CONFIG_SPI_DEBUG=y
CONFIG_SPI_MASTER=y

#
# SPI Master Controller Drivers
#
CONFIG_SPI_ALTERA=y
CONFIG_SPI_AXI_SPI_ENGINE=y
CONFIG_SPI_BITBANG=y
CONFIG_SPI_BUTTERFLY=m
# CONFIG_SPI_CADENCE is not set
CONFIG_SPI_DESIGNWARE=y
# CONFIG_SPI_DW_PCI is not set
CONFIG_SPI_DW_MMIO=y
CONFIG_SPI_DLN2=y
CONFIG_SPI_GPIO=m
# CONFIG_SPI_LM70_LLP is not set
CONFIG_SPI_FSL_LIB=m
CONFIG_SPI_FSL_SPI=m
CONFIG_SPI_OC_TINY=y
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_PXA2XX_PCI is not set
CONFIG_SPI_ROCKCHIP=m
CONFIG_SPI_SC18IS602=y
# CONFIG_SPI_TOPCLIFF_PCH is not set
CONFIG_SPI_XCOMM=y
CONFIG_SPI_XILINX=y
# CONFIG_SPI_ZYNQMP_GQSPI is not set

#
# SPI Protocol Masters
#
CONFIG_SPI_SPIDEV=y
CONFIG_SPI_LOOPBACK_TEST=m
CONFIG_SPI_TLE62X0=y
# CONFIG_SPMI is not set
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
# CONFIG_HSI_CHAR is not set

#
# PPS support
#
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
# CONFIG_PPS_CLIENT_PARPORT is not set
CONFIG_PPS_CLIENT_GPIO=y

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
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=y

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=y
# CONFIG_GPIO_ALTERA is not set
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_AXP209=m
CONFIG_GPIO_DWAPB=y
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_FTGPIO010 is not set
CONFIG_GPIO_GENERIC_PLATFORM=m
CONFIG_GPIO_GRGPIO=m
# CONFIG_GPIO_ICH is not set
# CONFIG_GPIO_LYNXPOINT is not set
CONFIG_GPIO_MENZ127=m
CONFIG_GPIO_MOCKUP=y
CONFIG_GPIO_SYSCON=m
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_XILINX is not set

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_104_DIO_48E=m
CONFIG_GPIO_104_IDIO_16=m
# CONFIG_GPIO_104_IDI_48 is not set
# CONFIG_GPIO_F7188X is not set
CONFIG_GPIO_GPIO_MM=y
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
CONFIG_GPIO_SCH311X=y
CONFIG_GPIO_WS16C48=y

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=y
CONFIG_GPIO_ADP5588_IRQ=y
CONFIG_GPIO_ADNP=y
# CONFIG_GPIO_MAX7300 is not set
CONFIG_GPIO_MAX732X=m
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCF857X is not set
CONFIG_GPIO_TPIC2810=m

#
# MFD GPIO expanders
#
CONFIG_GPIO_ADP5520=y
CONFIG_GPIO_DA9055=m
# CONFIG_GPIO_DLN2 is not set
# CONFIG_GPIO_KEMPLD is not set
CONFIG_GPIO_MAX77620=y
CONFIG_GPIO_STMPE=y
CONFIG_GPIO_TC3589X=y
CONFIG_GPIO_TPS65086=m
# CONFIG_GPIO_TPS65912 is not set
CONFIG_GPIO_TWL4030=m
CONFIG_GPIO_TWL6040=m

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_RDC321X is not set
# CONFIG_GPIO_SODAVILLE is not set

#
# SPI GPIO expanders
#
CONFIG_GPIO_74X164=y
# CONFIG_GPIO_MAX7301 is not set
CONFIG_GPIO_MC33880=m
CONFIG_GPIO_PISOSR=y

#
# SPI or I2C GPIO expanders
#
# CONFIG_GPIO_MCP23S08 is not set

#
# USB GPIO expanders
#
CONFIG_W1=m

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
# CONFIG_W1_MASTER_DS2490 is not set
# CONFIG_W1_MASTER_DS2482 is not set
CONFIG_W1_MASTER_DS1WM=m
CONFIG_W1_MASTER_GPIO=m

#
# 1-wire Slaves
#
# CONFIG_W1_SLAVE_THERM is not set
# CONFIG_W1_SLAVE_SMEM is not set
# CONFIG_W1_SLAVE_DS2405 is not set
# CONFIG_W1_SLAVE_DS2408 is not set
# CONFIG_W1_SLAVE_DS2413 is not set
CONFIG_W1_SLAVE_DS2406=m
CONFIG_W1_SLAVE_DS2423=m
# CONFIG_W1_SLAVE_DS2431 is not set
# CONFIG_W1_SLAVE_DS2433 is not set
CONFIG_W1_SLAVE_DS2438=m
CONFIG_W1_SLAVE_DS2760=m
CONFIG_W1_SLAVE_DS2780=m
CONFIG_W1_SLAVE_DS2781=m
# CONFIG_W1_SLAVE_DS28E04 is not set
# CONFIG_W1_SLAVE_BQ27000 is not set
CONFIG_POWER_AVS=y
CONFIG_POWER_RESET=y
CONFIG_POWER_RESET_AS3722=y
CONFIG_POWER_RESET_GPIO=y
CONFIG_POWER_RESET_GPIO_RESTART=y
CONFIG_POWER_RESET_LTC2952=y
CONFIG_POWER_RESET_RESTART=y
CONFIG_POWER_RESET_SYSCON=y
# CONFIG_POWER_RESET_SYSCON_POWEROFF is not set
# CONFIG_SYSCON_REBOOT_MODE is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_PDA_POWER=m
CONFIG_GENERIC_ADC_BATTERY=y
# CONFIG_TEST_POWER is not set
CONFIG_BATTERY_DS2760=m
# CONFIG_BATTERY_DS2780 is not set
CONFIG_BATTERY_DS2781=m
CONFIG_BATTERY_DS2782=m
# CONFIG_BATTERY_LEGO_EV3 is not set
# CONFIG_BATTERY_SBS is not set
CONFIG_CHARGER_SBS=m
CONFIG_BATTERY_BQ27XXX=y
# CONFIG_BATTERY_BQ27XXX_I2C is not set
CONFIG_AXP20X_POWER=m
# CONFIG_AXP288_CHARGER is not set
CONFIG_AXP288_FUEL_GAUGE=m
CONFIG_BATTERY_MAX17040=m
CONFIG_BATTERY_MAX17042=y
# CONFIG_CHARGER_PCF50633 is not set
CONFIG_CHARGER_CPCAP=m
CONFIG_CHARGER_ISP1704=m
CONFIG_CHARGER_MAX8903=y
# CONFIG_CHARGER_TWL4030 is not set
CONFIG_CHARGER_LP8727=m
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_MANAGER is not set
CONFIG_CHARGER_DETECTOR_MAX14656=y
CONFIG_CHARGER_MAX77693=m
# CONFIG_CHARGER_MAX8998 is not set
CONFIG_CHARGER_BQ2415X=m
CONFIG_CHARGER_BQ24190=y
# CONFIG_CHARGER_BQ24257 is not set
CONFIG_CHARGER_BQ24735=y
CONFIG_CHARGER_BQ25890=y
CONFIG_CHARGER_SMB347=y
CONFIG_BATTERY_GAUGE_LTC2941=m
CONFIG_BATTERY_RT5033=m
CONFIG_CHARGER_RT9455=y
CONFIG_HWMON=m
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
# CONFIG_SENSORS_ABITUGURU is not set
CONFIG_SENSORS_ABITUGURU3=m
CONFIG_SENSORS_AD7314=m
# CONFIG_SENSORS_AD7414 is not set
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1026 is not set
# CONFIG_SENSORS_ADM1029 is not set
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ADM9240 is not set
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
# CONFIG_SENSORS_ADT7470 is not set
# CONFIG_SENSORS_ADT7475 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
# CONFIG_SENSORS_FAM15H_POWER is not set
# CONFIG_SENSORS_APPLESMC is not set
CONFIG_SENSORS_ASB100=m
CONFIG_SENSORS_ASPEED=m
# CONFIG_SENSORS_ATXP1 is not set
# CONFIG_SENSORS_DS620 is not set
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=m
CONFIG_SENSORS_DA9055=m
# CONFIG_SENSORS_I5K_AMB is not set
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_MC13783_ADC=m
CONFIG_SENSORS_FSCHMD=m
CONFIG_SENSORS_FTSTEUTATES=m
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
# CONFIG_SENSORS_G760A is not set
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_GPIO_FAN is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IIO_HWMON=m
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=m
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_JC42 is not set
CONFIG_SENSORS_POWR1220=m
CONFIG_SENSORS_LINEAGE=m
CONFIG_SENSORS_LTC2945=m
CONFIG_SENSORS_LTC2990=m
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
CONFIG_SENSORS_LTC4222=m
CONFIG_SENSORS_LTC4245=m
CONFIG_SENSORS_LTC4260=m
# CONFIG_SENSORS_LTC4261 is not set
CONFIG_SENSORS_MAX1111=m
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
CONFIG_SENSORS_MAX31722=m
CONFIG_SENSORS_MAX6639=m
# CONFIG_SENSORS_MAX6642 is not set
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
CONFIG_SENSORS_TC654=m
CONFIG_SENSORS_MENF21BMC_HWMON=m
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
CONFIG_SENSORS_LM70=m
# CONFIG_SENSORS_LM73 is not set
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
# CONFIG_SENSORS_LM78 is not set
CONFIG_SENSORS_LM80=m
# CONFIG_SENSORS_LM83 is not set
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
# CONFIG_SENSORS_LM95234 is not set
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
# CONFIG_SENSORS_PC87360 is not set
CONFIG_SENSORS_PC87427=m
# CONFIG_SENSORS_NTC_THERMISTOR is not set
CONFIG_SENSORS_NCT6683=m
CONFIG_SENSORS_NCT6775=m
CONFIG_SENSORS_NCT7802=m
# CONFIG_SENSORS_NCT7904 is not set
CONFIG_SENSORS_PCF8591=m
# CONFIG_PMBUS is not set
CONFIG_SENSORS_PWM_FAN=m
CONFIG_SENSORS_SHT15=m
# CONFIG_SENSORS_SHT21 is not set
CONFIG_SENSORS_SHT3x=m
CONFIG_SENSORS_SHTC1=m
# CONFIG_SENSORS_SIS5595 is not set
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
CONFIG_SENSORS_EMC2103=m
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
CONFIG_SENSORS_SMM665=m
CONFIG_SENSORS_ADC128D818=m
CONFIG_SENSORS_ADS1015=m
# CONFIG_SENSORS_ADS7828 is not set
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
# CONFIG_SENSORS_INA2XX is not set
CONFIG_SENSORS_INA3221=m
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
CONFIG_SENSORS_TMP103=m
CONFIG_SENSORS_TMP108=m
CONFIG_SENSORS_TMP401=m
# CONFIG_SENSORS_TMP421 is not set
CONFIG_SENSORS_VIA_CPUTEMP=m
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_VT1211=m
# CONFIG_SENSORS_VT8231 is not set
CONFIG_SENSORS_W83781D=m
# CONFIG_SENSORS_W83791D is not set
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
# CONFIG_SENSORS_W83795 is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
# CONFIG_SENSORS_W83627HF is not set
# CONFIG_SENSORS_W83627EHF is not set

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_OF=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE=y
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_GOV_STEP_WISE is not set
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
# CONFIG_THERMAL_EMULATION is not set
CONFIG_MAX77620_THERMAL=m
CONFIG_QORIQ_THERMAL=m
CONFIG_DA9062_THERMAL=m
# CONFIG_INTEL_POWERCLAMP is not set
CONFIG_X86_PKG_TEMP_THERMAL=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# CONFIG_INTEL_PCH_THERMAL is not set
CONFIG_GENERIC_ADC_THERMAL=m
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_SYSFS=y

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=y
# CONFIG_SOFT_WATCHDOG_PRETIMEOUT is not set
CONFIG_DA9055_WATCHDOG=m
CONFIG_DA9063_WATCHDOG=m
CONFIG_DA9062_WATCHDOG=m
CONFIG_GPIO_WATCHDOG=m
CONFIG_MENF21BMC_WATCHDOG=m
# CONFIG_WDAT_WDT is not set
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
CONFIG_CADENCE_WATCHDOG=y
# CONFIG_DW_WATCHDOG is not set
CONFIG_TWL4030_WATCHDOG=m
CONFIG_MAX63XX_WATCHDOG=m
CONFIG_MAX77620_WATCHDOG=y
CONFIG_ACQUIRE_WDT=m
CONFIG_ADVANTECH_WDT=m
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
CONFIG_EBC_C384_WDT=m
CONFIG_F71808E_WDT=m
# CONFIG_SP5100_TCO is not set
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=y
# CONFIG_IBMASR is not set
CONFIG_WAFER_WDT=y
# CONFIG_I6300ESB_WDT is not set
# CONFIG_IE6XX_WDT is not set
# CONFIG_ITCO_WDT is not set
# CONFIG_IT8712F_WDT is not set
CONFIG_IT87_WDT=m
# CONFIG_HP_WATCHDOG is not set
CONFIG_KEMPLD_WDT=m
# CONFIG_SC1200_WDT is not set
CONFIG_PC87413_WDT=y
# CONFIG_NV_TCO is not set
# CONFIG_RDC321X_WDT is not set
# CONFIG_60XX_WDT is not set
# CONFIG_SBC8360_WDT is not set
# CONFIG_SBC7240_WDT is not set
CONFIG_CPU5_WDT=m
CONFIG_SMSC_SCH311X_WDT=y
CONFIG_SMSC37B787_WDT=m
# CONFIG_VIA_WDT is not set
CONFIG_W83627HF_WDT=y
CONFIG_W83877F_WDT=m
# CONFIG_W83977F_WDT is not set
# CONFIG_MACHZ_WDT is not set
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
CONFIG_MEN_A21_WDT=m

#
# ISA-based Watchdog Cards
#
CONFIG_PCWATCHDOG=y
# CONFIG_MIXCOMWD is not set
# CONFIG_WDT is not set

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=m

#
# Watchdog Pretimeout Governors
#
CONFIG_WATCHDOG_PRETIMEOUT_GOV=y
CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP=y
# CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC is not set
CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC=y
CONFIG_SSB_POSSIBLE=y

#
# Sonics Silicon Backplane
#
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
# CONFIG_SSB_B43_PCI_BRIDGE is not set
CONFIG_SSB_DEBUG=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
# CONFIG_SSB_DRIVER_PCICORE is not set
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y

#
# Broadcom specific AMBA
#
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
# CONFIG_BCMA_DRIVER_GPIO is not set
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_CS5535 is not set
# CONFIG_MFD_ACT8945A is not set
# CONFIG_MFD_AS3711 is not set
CONFIG_MFD_AS3722=y
CONFIG_PMIC_ADP5520=y
CONFIG_MFD_AAT2870_CORE=y
# CONFIG_MFD_ATMEL_FLEXCOM is not set
# CONFIG_MFD_ATMEL_HLCDC is not set
CONFIG_MFD_BCM590XX=y
CONFIG_MFD_AXP20X=m
CONFIG_MFD_AXP20X_I2C=m
CONFIG_MFD_CROS_EC=m
CONFIG_MFD_CROS_EC_I2C=m
CONFIG_MFD_CROS_EC_SPI=m
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
CONFIG_MFD_DA9055=y
CONFIG_MFD_DA9062=y
CONFIG_MFD_DA9063=m
# CONFIG_MFD_DA9150 is not set
CONFIG_MFD_DLN2=y
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_SPI=y
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_HI6421_PMIC is not set
# CONFIG_HTC_PASIC3 is not set
CONFIG_HTC_I2CPLD=y
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_INTEL_SOC_PMIC is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=y
CONFIG_MFD_88PM800=y
CONFIG_MFD_88PM805=m
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
CONFIG_MFD_MAX77620=y
CONFIG_MFD_MAX77686=m
CONFIG_MFD_MAX77693=m
CONFIG_MFD_MAX77843=y
CONFIG_MFD_MAX8907=y
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
CONFIG_MFD_MAX8998=y
# CONFIG_MFD_MT6397 is not set
CONFIG_MFD_MENF21BMC=y
# CONFIG_EZX_PCAP is not set
CONFIG_MFD_CPCAP=m
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
CONFIG_MFD_PCF50633=y
# CONFIG_PCF50633_ADC is not set
CONFIG_PCF50633_GPIO=y
# CONFIG_UCB1400_CORE is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RTSX_PCI is not set
CONFIG_MFD_RT5033=y
CONFIG_MFD_RTSX_USB=y
# CONFIG_MFD_RC5T583 is not set
CONFIG_MFD_RK808=y
# CONFIG_MFD_RN5T618 is not set
CONFIG_MFD_SEC_CORE=y
CONFIG_MFD_SI476X_CORE=y
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
CONFIG_MFD_SKY81452=y
# CONFIG_MFD_SMSC is not set
# CONFIG_ABX500_CORE is not set
CONFIG_MFD_STMPE=y

#
# STMicroelectronics STMPE Interface Drivers
#
CONFIG_STMPE_I2C=y
# CONFIG_STMPE_SPI is not set
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
CONFIG_MFD_TI_LMU=y
# CONFIG_MFD_PALMAS is not set
CONFIG_TPS6105X=y
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
CONFIG_MFD_TPS65086=m
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TPS65217 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS65218 is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
CONFIG_MFD_TPS65912=m
CONFIG_MFD_TPS65912_I2C=m
CONFIG_MFD_TPS65912_SPI=m
# CONFIG_MFD_TPS80031 is not set
CONFIG_TWL4030_CORE=y
CONFIG_MFD_TWL4030_AUDIO=y
CONFIG_TWL6040_CORE=y
CONFIG_MFD_WL1273_CORE=y
CONFIG_MFD_LM3533=m
# CONFIG_MFD_TIMBERDALE is not set
CONFIG_MFD_TC3589X=y
# CONFIG_MFD_TMIO is not set
# CONFIG_MFD_VX855 is not set
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_VIRTUAL_CONSUMER=m
CONFIG_REGULATOR_USERSPACE_CONSUMER=m
# CONFIG_REGULATOR_88PM800 is not set
CONFIG_REGULATOR_ACT8865=y
CONFIG_REGULATOR_AD5398=y
# CONFIG_REGULATOR_ANATOP is not set
# CONFIG_REGULATOR_AAT2870 is not set
CONFIG_REGULATOR_AS3722=y
# CONFIG_REGULATOR_AXP20X is not set
CONFIG_REGULATOR_BCM590XX=m
CONFIG_REGULATOR_CPCAP=m
# CONFIG_REGULATOR_DA9055 is not set
CONFIG_REGULATOR_DA9062=y
# CONFIG_REGULATOR_DA9063 is not set
CONFIG_REGULATOR_DA9210=y
# CONFIG_REGULATOR_DA9211 is not set
CONFIG_REGULATOR_FAN53555=y
CONFIG_REGULATOR_GPIO=m
CONFIG_REGULATOR_ISL9305=y
# CONFIG_REGULATOR_ISL6271A is not set
CONFIG_REGULATOR_LM363X=m
CONFIG_REGULATOR_LP3971=y
# CONFIG_REGULATOR_LP3972 is not set
# CONFIG_REGULATOR_LP872X is not set
CONFIG_REGULATOR_LP8755=m
CONFIG_REGULATOR_LTC3589=m
CONFIG_REGULATOR_LTC3676=m
CONFIG_REGULATOR_MAX1586=m
CONFIG_REGULATOR_MAX77620=m
# CONFIG_REGULATOR_MAX8649 is not set
CONFIG_REGULATOR_MAX8660=y
CONFIG_REGULATOR_MAX8907=y
CONFIG_REGULATOR_MAX8952=y
CONFIG_REGULATOR_MAX8973=m
CONFIG_REGULATOR_MAX8998=m
CONFIG_REGULATOR_MAX77686=m
CONFIG_REGULATOR_MAX77693=m
CONFIG_REGULATOR_MAX77802=m
# CONFIG_REGULATOR_MC13783 is not set
# CONFIG_REGULATOR_MC13892 is not set
# CONFIG_REGULATOR_MT6311 is not set
CONFIG_REGULATOR_PCF50633=y
CONFIG_REGULATOR_PFUZE100=m
CONFIG_REGULATOR_PV88060=y
CONFIG_REGULATOR_PV88080=y
CONFIG_REGULATOR_PV88090=m
CONFIG_REGULATOR_PWM=y
CONFIG_REGULATOR_RK808=m
# CONFIG_REGULATOR_RT5033 is not set
CONFIG_REGULATOR_S2MPA01=y
# CONFIG_REGULATOR_S2MPS11 is not set
# CONFIG_REGULATOR_S5M8767 is not set
# CONFIG_REGULATOR_SKY81452 is not set
CONFIG_REGULATOR_TPS51632=y
# CONFIG_REGULATOR_TPS6105X is not set
# CONFIG_REGULATOR_TPS62360 is not set
# CONFIG_REGULATOR_TPS65023 is not set
# CONFIG_REGULATOR_TPS6507X is not set
CONFIG_REGULATOR_TPS65086=m
# CONFIG_REGULATOR_TPS65132 is not set
CONFIG_REGULATOR_TPS6524X=y
# CONFIG_REGULATOR_TPS65912 is not set
CONFIG_REGULATOR_TWL4030=m
# CONFIG_REGULATOR_VCTRL is not set
# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=y
CONFIG_DRM_MIPI_DSI=y
# CONFIG_DRM_DP_AUX_CHARDEV is not set
CONFIG_DRM_DEBUG_MM=y
CONFIG_DRM_DEBUG_MM_SELFTEST=m
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_GEM_CMA_HELPER=y
CONFIG_DRM_KMS_CMA_HELPER=y
CONFIG_DRM_VM=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=y
# CONFIG_DRM_I2C_SIL164 is not set
CONFIG_DRM_I2C_NXP_TDA998X=m
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
CONFIG_DRM_RCAR_DW_HDMI=y
# CONFIG_DRM_QXL is not set
# CONFIG_DRM_BOCHS is not set
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
CONFIG_DRM_PANEL_LVDS=m
CONFIG_DRM_PANEL_SIMPLE=y
# CONFIG_DRM_PANEL_JDI_LT070ME05000 is not set
CONFIG_DRM_PANEL_SAMSUNG_LD9040=y
# CONFIG_DRM_PANEL_LG_LG4573 is not set
CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00=m
CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2=y
CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=m
CONFIG_DRM_PANEL_SHARP_LQ101R1SX01=y
# CONFIG_DRM_PANEL_SHARP_LS043T1LE01 is not set
CONFIG_DRM_PANEL_SITRONIX_ST7789V=y
CONFIG_DRM_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# CONFIG_DRM_DUMB_VGA_DAC is not set
# CONFIG_DRM_LVDS_ENCODER is not set
CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW=y
CONFIG_DRM_NXP_PTN3460=m
# CONFIG_DRM_PARADE_PS8622 is not set
# CONFIG_DRM_SIL_SII8620 is not set
# CONFIG_DRM_SII902X is not set
# CONFIG_DRM_TOSHIBA_TC358767 is not set
CONFIG_DRM_TI_TFP410=y
# CONFIG_DRM_I2C_ADV7511 is not set
CONFIG_DRM_DW_HDMI=y
CONFIG_DRM_DW_HDMI_AHB_AUDIO=m
CONFIG_DRM_DW_HDMI_I2S_AUDIO=m
CONFIG_DRM_ARCPGU=m
# CONFIG_DRM_HISI_HIBMC is not set
# CONFIG_DRM_MXSFB is not set
# CONFIG_DRM_TINYDRM is not set
CONFIG_DRM_LEGACY=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_VIA is not set
# CONFIG_DRM_SAVAGE is not set
CONFIG_DRM_LIB_RANDOM=y

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
CONFIG_FB_FOREIGN_ENDIAN=y
# CONFIG_FB_BOTH_ENDIAN is not set
CONFIG_FB_BIG_ENDIAN=y
# CONFIG_FB_LITTLE_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_HECUBA=m
# CONFIG_FB_SVGALIB is not set
# CONFIG_FB_MACMODES is not set
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

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
# CONFIG_FB_VESA is not set
CONFIG_FB_N411=m
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
CONFIG_FB_SM501=m
# CONFIG_FB_SMSCUFX is not set
CONFIG_FB_UDL=y
CONFIG_FB_IBM_GXT4500=m
CONFIG_FB_VIRTUAL=m
CONFIG_FB_METRONOME=m
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_BROADSHEET is not set
CONFIG_FB_AUO_K190X=y
CONFIG_FB_AUO_K1900=y
# CONFIG_FB_AUO_K1901 is not set
# CONFIG_FB_SIMPLE is not set
CONFIG_FB_SSD1307=m
# CONFIG_FB_SM712 is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_LCD_CLASS_DEVICE=m
CONFIG_LCD_L4F00242T03=m
CONFIG_LCD_LMS283GF05=m
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
CONFIG_LCD_TDO24M=m
# CONFIG_LCD_VGG2432A4 is not set
# CONFIG_LCD_PLATFORM is not set
CONFIG_LCD_S6E63M0=m
# CONFIG_LCD_LD9040 is not set
CONFIG_LCD_AMS369FG06=m
CONFIG_LCD_LMS501KF03=m
CONFIG_LCD_HX8357=m
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_GENERIC=m
# CONFIG_BACKLIGHT_LM3533 is not set
# CONFIG_BACKLIGHT_PWM is not set
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_PM8941_WLED=m
CONFIG_BACKLIGHT_SAHARA=y
CONFIG_BACKLIGHT_ADP5520=y
CONFIG_BACKLIGHT_ADP8860=y
CONFIG_BACKLIGHT_ADP8870=y
CONFIG_BACKLIGHT_PCF50633=y
CONFIG_BACKLIGHT_AAT2870=y
CONFIG_BACKLIGHT_LM3630A=y
# CONFIG_BACKLIGHT_LM3639 is not set
# CONFIG_BACKLIGHT_LP855X is not set
CONFIG_BACKLIGHT_PANDORA=m
CONFIG_BACKLIGHT_SKY81452=m
CONFIG_BACKLIGHT_GPIO=y
CONFIG_BACKLIGHT_LV5207LP=y
CONFIG_BACKLIGHT_BD6107=y
# CONFIG_BACKLIGHT_ARCXCNN is not set
# CONFIG_VGASTATE is not set
CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_VGACON_SOFT_SCROLLBACK is not set
CONFIG_MDA_CONSOLE=m
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_LOGO is not set
CONFIG_SOUND=y
# CONFIG_SOUND_OSS_CORE is not set
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_PCM_ELD=y
CONFIG_SND_PCM_IEC958=y
CONFIG_SND_DMAENGINE_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
# CONFIG_SND_MIXER_OSS is not set
# CONFIG_SND_PCM_OSS is not set
CONFIG_SND_PCM_TIMER=y
# CONFIG_SND_SEQUENCER_OSS is not set
# CONFIG_SND_HRTIMER is not set
# CONFIG_SND_DYNAMIC_MINORS is not set
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
CONFIG_SND_VERBOSE_PRINTK=y
# CONFIG_SND_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_RAWMIDI_SEQ=m
CONFIG_SND_OPL3_LIB_SEQ=m
CONFIG_SND_OPL4_LIB_SEQ=m
CONFIG_SND_SBAWE_SEQ=m
# CONFIG_SND_EMU10K1_SEQ is not set
CONFIG_SND_MPU401_UART=m
CONFIG_SND_OPL3_LIB=m
CONFIG_SND_OPL4_LIB=m
CONFIG_SND_AC97_CODEC=m
# CONFIG_SND_DRIVERS is not set
CONFIG_SND_WSS_LIB=m
CONFIG_SND_SB_COMMON=m
CONFIG_SND_SB8_DSP=m
CONFIG_SND_SB16_DSP=m
CONFIG_SND_ISA=y
# CONFIG_SND_ADLIB is not set
CONFIG_SND_AD1816A=m
# CONFIG_SND_AD1848 is not set
CONFIG_SND_ALS100=m
CONFIG_SND_AZT1605=m
CONFIG_SND_AZT2316=m
CONFIG_SND_AZT2320=m
CONFIG_SND_CMI8328=m
CONFIG_SND_CMI8330=m
# CONFIG_SND_CS4231 is not set
CONFIG_SND_CS4236=m
# CONFIG_SND_ES1688 is not set
# CONFIG_SND_ES18XX is not set
# CONFIG_SND_SC6000 is not set
CONFIG_SND_GUSCLASSIC=m
CONFIG_SND_GUSEXTREME=m
CONFIG_SND_GUSMAX=m
# CONFIG_SND_INTERWAVE is not set
CONFIG_SND_INTERWAVE_STB=m
CONFIG_SND_JAZZ16=m
CONFIG_SND_OPL3SA2=m
# CONFIG_SND_OPTI92X_AD1848 is not set
# CONFIG_SND_OPTI92X_CS4231 is not set
# CONFIG_SND_OPTI93X is not set
CONFIG_SND_MIRO=m
CONFIG_SND_SB8=m
CONFIG_SND_SB16=m
CONFIG_SND_SBAWE=m
# CONFIG_SND_SB16_CSP is not set
# CONFIG_SND_SSCAPE is not set
CONFIG_SND_WAVEFRONT=m
# CONFIG_SND_MSND_PINNACLE is not set
CONFIG_SND_MSND_CLASSIC=m
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
# CONFIG_SND_CS5530 is not set
# CONFIG_SND_CS5535AUDIO is not set
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
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
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
# CONFIG_SND_SIS7019 is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VIRTUOSO is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
# CONFIG_SND_HDA_INTEL is not set
CONFIG_SND_HDA_PREALLOC_SIZE=64
CONFIG_SND_SPI=y
# CONFIG_SND_USB is not set
# CONFIG_SND_FIREWIRE is not set
CONFIG_SND_SOC=m
CONFIG_SND_SOC_AC97_BUS=y
CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
CONFIG_SND_SOC_AMD_ACP=m
CONFIG_SND_ATMEL_SOC=m
# CONFIG_SND_DESIGNWARE_I2S is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
CONFIG_SND_SOC_FSL_ASRC=m
CONFIG_SND_SOC_FSL_SAI=m
# CONFIG_SND_SOC_FSL_SSI is not set
# CONFIG_SND_SOC_FSL_SPDIF is not set
CONFIG_SND_SOC_FSL_ESAI=m
CONFIG_SND_SOC_IMX_AUDMUX=m
CONFIG_SND_I2S_HI6210_I2S=m
CONFIG_SND_SOC_IMG=y
# CONFIG_SND_SOC_IMG_I2S_IN is not set
# CONFIG_SND_SOC_IMG_I2S_OUT is not set
CONFIG_SND_SOC_IMG_PARALLEL_OUT=m
# CONFIG_SND_SOC_IMG_SPDIF_IN is not set
# CONFIG_SND_SOC_IMG_SPDIF_OUT is not set
CONFIG_SND_SOC_IMG_PISTACHIO_INTERNAL_DAC=m
# CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH is not set
# CONFIG_SND_SOC_INTEL_BXT_RT298_MACH is not set
# CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH is not set
# CONFIG_SND_SOC_INTEL_BYTCR_RT5651_MACH is not set
# CONFIG_SND_SOC_INTEL_SKL_RT286_MACH is not set
CONFIG_SND_SOC_XTFPGA_I2S=m
# CONFIG_ZX_TDM is not set
CONFIG_SND_SOC_I2C_AND_SPI=m

#
# CODEC drivers
#
CONFIG_SND_SOC_AC97_CODEC=m
CONFIG_SND_SOC_ADAU_UTILS=m
CONFIG_SND_SOC_ADAU1701=m
CONFIG_SND_SOC_ADAU17X1=m
CONFIG_SND_SOC_ADAU1761=m
CONFIG_SND_SOC_ADAU1761_I2C=m
CONFIG_SND_SOC_ADAU1761_SPI=m
CONFIG_SND_SOC_ADAU7002=m
CONFIG_SND_SOC_AK4104=m
CONFIG_SND_SOC_AK4554=m
CONFIG_SND_SOC_AK4613=m
CONFIG_SND_SOC_AK4642=m
CONFIG_SND_SOC_AK5386=m
CONFIG_SND_SOC_ALC5623=m
CONFIG_SND_SOC_BT_SCO=m
CONFIG_SND_SOC_CS35L32=m
CONFIG_SND_SOC_CS35L33=m
CONFIG_SND_SOC_CS35L34=m
CONFIG_SND_SOC_CS35L35=m
CONFIG_SND_SOC_CS42L42=m
CONFIG_SND_SOC_CS42L51=m
CONFIG_SND_SOC_CS42L51_I2C=m
CONFIG_SND_SOC_CS42L52=m
CONFIG_SND_SOC_CS42L56=m
CONFIG_SND_SOC_CS42L73=m
CONFIG_SND_SOC_CS4265=m
CONFIG_SND_SOC_CS4270=m
CONFIG_SND_SOC_CS4271=m
CONFIG_SND_SOC_CS4271_I2C=m
CONFIG_SND_SOC_CS4271_SPI=m
CONFIG_SND_SOC_CS42XX8=m
CONFIG_SND_SOC_CS42XX8_I2C=m
CONFIG_SND_SOC_CS4349=m
CONFIG_SND_SOC_CS53L30=m
CONFIG_SND_SOC_DIO2125=m
CONFIG_SND_SOC_HDMI_CODEC=m
CONFIG_SND_SOC_ES7134=m
CONFIG_SND_SOC_ES8328=m
CONFIG_SND_SOC_ES8328_I2C=m
CONFIG_SND_SOC_ES8328_SPI=m
CONFIG_SND_SOC_GTM601=m
CONFIG_SND_SOC_INNO_RK3036=m
CONFIG_SND_SOC_MAX98504=m
CONFIG_SND_SOC_MAX98927=m
CONFIG_SND_SOC_MAX9860=m
# CONFIG_SND_SOC_MSM8916_WCD_DIGITAL is not set
CONFIG_SND_SOC_PCM1681=m
CONFIG_SND_SOC_PCM179X=m
CONFIG_SND_SOC_PCM179X_I2C=m
CONFIG_SND_SOC_PCM179X_SPI=m
CONFIG_SND_SOC_PCM3168A=m
CONFIG_SND_SOC_PCM3168A_I2C=m
CONFIG_SND_SOC_PCM3168A_SPI=m
CONFIG_SND_SOC_PCM512x=m
CONFIG_SND_SOC_PCM512x_I2C=m
CONFIG_SND_SOC_PCM512x_SPI=m
CONFIG_SND_SOC_RL6231=m
CONFIG_SND_SOC_RT5616=m
CONFIG_SND_SOC_RT5631=m
# CONFIG_SND_SOC_RT5677_SPI is not set
CONFIG_SND_SOC_SGTL5000=m
CONFIG_SND_SOC_SIGMADSP=m
CONFIG_SND_SOC_SIGMADSP_I2C=m
CONFIG_SND_SOC_SIGMADSP_REGMAP=m
CONFIG_SND_SOC_SIRF_AUDIO_CODEC=m
CONFIG_SND_SOC_SPDIF=m
CONFIG_SND_SOC_SSM2602=m
CONFIG_SND_SOC_SSM2602_SPI=m
CONFIG_SND_SOC_SSM2602_I2C=m
CONFIG_SND_SOC_SSM4567=m
CONFIG_SND_SOC_STA32X=m
CONFIG_SND_SOC_STA350=m
CONFIG_SND_SOC_STI_SAS=m
CONFIG_SND_SOC_TAS2552=m
CONFIG_SND_SOC_TAS5086=m
CONFIG_SND_SOC_TAS571X=m
CONFIG_SND_SOC_TAS5720=m
CONFIG_SND_SOC_TFA9879=m
CONFIG_SND_SOC_TLV320AIC23=m
CONFIG_SND_SOC_TLV320AIC23_I2C=m
CONFIG_SND_SOC_TLV320AIC23_SPI=m
CONFIG_SND_SOC_TLV320AIC31XX=m
CONFIG_SND_SOC_TLV320AIC3X=m
CONFIG_SND_SOC_TS3A227E=m
CONFIG_SND_SOC_WM8510=m
CONFIG_SND_SOC_WM8523=m
CONFIG_SND_SOC_WM8580=m
CONFIG_SND_SOC_WM8711=m
CONFIG_SND_SOC_WM8728=m
CONFIG_SND_SOC_WM8731=m
CONFIG_SND_SOC_WM8737=m
CONFIG_SND_SOC_WM8741=m
CONFIG_SND_SOC_WM8750=m
CONFIG_SND_SOC_WM8753=m
CONFIG_SND_SOC_WM8770=m
CONFIG_SND_SOC_WM8776=m
CONFIG_SND_SOC_WM8804=m
CONFIG_SND_SOC_WM8804_I2C=m
CONFIG_SND_SOC_WM8804_SPI=m
CONFIG_SND_SOC_WM8903=m
CONFIG_SND_SOC_WM8960=m
CONFIG_SND_SOC_WM8962=m
CONFIG_SND_SOC_WM8974=m
CONFIG_SND_SOC_WM8978=m
CONFIG_SND_SOC_WM8985=m
CONFIG_SND_SOC_NAU8540=m
CONFIG_SND_SOC_NAU8810=m
CONFIG_SND_SOC_NAU8824=m
CONFIG_SND_SOC_TPA6130A2=m
CONFIG_SND_SIMPLE_CARD_UTILS=m
CONFIG_SND_SIMPLE_CARD=m
# CONFIG_SND_SIMPLE_SCU_CARD is not set
CONFIG_SND_X86=y
CONFIG_AC97_BUS=m

#
# HID support
#
CONFIG_HID=m
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=m

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
CONFIG_HID_ACCUTOUCH=m
CONFIG_HID_ACRUX=m
CONFIG_HID_ACRUX_FF=y
# CONFIG_HID_APPLE is not set
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=m
# CONFIG_HID_BELKIN is not set
CONFIG_HID_BETOP_FF=m
CONFIG_HID_CHERRY=m
# CONFIG_HID_CHICONY is not set
CONFIG_HID_CORSAIR=m
CONFIG_HID_PRODIKEYS=m
CONFIG_HID_CMEDIA=m
CONFIG_HID_CP2112=m
CONFIG_HID_CYPRESS=m
# CONFIG_HID_DRAGONRISE is not set
CONFIG_HID_EMS_FF=m
CONFIG_HID_ELECOM=m
CONFIG_HID_ELO=m
CONFIG_HID_EZKEY=m
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
CONFIG_HID_HOLTEK=m
CONFIG_HOLTEK_FF=y
# CONFIG_HID_GT683R is not set
# CONFIG_HID_KEYTOUCH is not set
CONFIG_HID_KYE=m
CONFIG_HID_UCLOGIC=m
# CONFIG_HID_WALTOP is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
# CONFIG_HID_LENOVO is not set
CONFIG_HID_LOGITECH=m
# CONFIG_HID_LOGITECH_DJ is not set
CONFIG_HID_LOGITECH_HIDPP=m
CONFIG_LOGITECH_FF=y
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
# CONFIG_HID_MAGICMOUSE is not set
CONFIG_HID_MAYFLASH=m
# CONFIG_HID_MICROSOFT is not set
CONFIG_HID_MONTEREY=m
# CONFIG_HID_MULTITOUCH is not set
CONFIG_HID_NTI=m
# CONFIG_HID_NTRIG is not set
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
CONFIG_HID_PENMOUNT=m
# CONFIG_HID_PETALYNX is not set
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
# CONFIG_HID_PLANTRONICS is not set
CONFIG_HID_PRIMAX=m
CONFIG_HID_ROCCAT=m
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
# CONFIG_HID_SONY is not set
# CONFIG_HID_SPEEDLINK is not set
# CONFIG_HID_STEELSERIES is not set
CONFIG_HID_SUNPLUS=m
# CONFIG_HID_RMI is not set
# CONFIG_HID_GREENASIA is not set
CONFIG_HID_SMARTJOYPLUS=m
CONFIG_SMARTJOYPLUS_FF=y
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
# CONFIG_HID_THRUSTMASTER is not set
CONFIG_HID_UDRAW_PS3=m
CONFIG_HID_WACOM=m
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
CONFIG_ZEROPLUS_FF=y
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=m
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m

#
# USB HID support
#
CONFIG_USB_HID=m
# CONFIG_HID_PID is not set
CONFIG_USB_HIDDEV=y

#
# I2C HID support
#
CONFIG_I2C_HID=m
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
CONFIG_USB_DYNAMIC_MINORS=y
CONFIG_USB_OTG=y
# CONFIG_USB_OTG_WHITELIST is not set
# CONFIG_USB_OTG_BLACKLIST_HUB is not set
CONFIG_USB_OTG_FSM=m
CONFIG_USB_LEDS_TRIGGER_USBPORT=m
# CONFIG_USB_MON is not set
CONFIG_USB_WUSB=y
CONFIG_USB_WUSB_CBAF=y
CONFIG_USB_WUSB_CBAF_DEBUG=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
CONFIG_USB_XHCI_PCI=y
CONFIG_USB_XHCI_PLATFORM=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
CONFIG_USB_EHCI_HCD_PLATFORM=y
# CONFIG_USB_OXU210HP_HCD is not set
CONFIG_USB_ISP116X_HCD=y
# CONFIG_USB_ISP1362_HCD is not set
CONFIG_USB_FOTG210_HCD=m
CONFIG_USB_MAX3421_HCD=m
CONFIG_USB_OHCI_HCD=m
CONFIG_USB_OHCI_HCD_PCI=m
CONFIG_USB_OHCI_HCD_SSB=y
CONFIG_USB_OHCI_HCD_PLATFORM=m
# CONFIG_USB_UHCI_HCD is not set
# CONFIG_USB_U132_HCD is not set
CONFIG_USB_SL811_HCD=m
CONFIG_USB_SL811_HCD_ISO=y
CONFIG_USB_R8A66597_HCD=m
# CONFIG_USB_WHCI_HCD is not set
CONFIG_USB_HWA_HCD=y
# CONFIG_USB_HCD_BCMA is not set
CONFIG_USB_HCD_SSB=y
CONFIG_USB_HCD_TEST_MODE=y

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
CONFIG_USB_WDM=m
CONFIG_USB_TMC=y

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=y
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_REALTEK=m
CONFIG_REALTEK_AUTOPM=y
# CONFIG_USB_STORAGE_DATAFAB is not set
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_USBAT=y
CONFIG_USB_STORAGE_SDDR09=m
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y
# CONFIG_USB_STORAGE_ALAUDA is not set
CONFIG_USB_STORAGE_ONETOUCH=y
# CONFIG_USB_STORAGE_KARMA is not set
CONFIG_USB_STORAGE_CYPRESS_ATACB=m
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
CONFIG_USB_UAS=m

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
CONFIG_USB_MICROTEK=y
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_MUSB_HDRC is not set
CONFIG_USB_DWC3=m
# CONFIG_USB_DWC3_HOST is not set
CONFIG_USB_DWC3_GADGET=y
# CONFIG_USB_DWC3_DUAL_ROLE is not set

#
# Platform Glue Driver Support
#
CONFIG_USB_DWC3_PCI=m
CONFIG_USB_DWC3_OF_SIMPLE=m
CONFIG_USB_DWC2=y
CONFIG_USB_DWC2_HOST=y

#
# Gadget/Dual-role mode requires USB Gadget support to be enabled
#
# CONFIG_USB_DWC2_PCI is not set
# CONFIG_USB_DWC2_DEBUG is not set
# CONFIG_USB_DWC2_TRACK_MISSED_SOFS is not set
# CONFIG_USB_CHIPIDEA is not set
CONFIG_USB_ISP1760=y
CONFIG_USB_ISP1760_HCD=y
CONFIG_USB_ISP1760_HOST_ROLE=y

#
# USB port drivers
#
CONFIG_USB_USS720=m
CONFIG_USB_SERIAL=y
# CONFIG_USB_SERIAL_CONSOLE is not set
# CONFIG_USB_SERIAL_GENERIC is not set
CONFIG_USB_SERIAL_SIMPLE=y
CONFIG_USB_SERIAL_AIRCABLE=y
CONFIG_USB_SERIAL_ARK3116=m
CONFIG_USB_SERIAL_BELKIN=m
# CONFIG_USB_SERIAL_CH341 is not set
CONFIG_USB_SERIAL_WHITEHEAT=y
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
CONFIG_USB_SERIAL_CP210X=y
# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
CONFIG_USB_SERIAL_EMPEG=y
CONFIG_USB_SERIAL_FTDI_SIO=m
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
CONFIG_USB_SERIAL_GARMIN=m
CONFIG_USB_SERIAL_IPW=m
CONFIG_USB_SERIAL_IUU=y
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
CONFIG_USB_SERIAL_KEYSPAN=m
CONFIG_USB_SERIAL_KLSI=y
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_MCT_U232=y
CONFIG_USB_SERIAL_METRO=y
# CONFIG_USB_SERIAL_MOS7720 is not set
# CONFIG_USB_SERIAL_MOS7840 is not set
# CONFIG_USB_SERIAL_MXUPORT is not set
CONFIG_USB_SERIAL_NAVMAN=y
# CONFIG_USB_SERIAL_PL2303 is not set
CONFIG_USB_SERIAL_OTI6858=m
CONFIG_USB_SERIAL_QCAUX=y
CONFIG_USB_SERIAL_QUALCOMM=m
CONFIG_USB_SERIAL_SPCP8X5=y
CONFIG_USB_SERIAL_SAFE=y
CONFIG_USB_SERIAL_SAFE_PADDED=y
CONFIG_USB_SERIAL_SIERRAWIRELESS=y
# CONFIG_USB_SERIAL_SYMBOL is not set
# CONFIG_USB_SERIAL_TI is not set
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_XIRCOM=y
CONFIG_USB_SERIAL_WWAN=y
CONFIG_USB_SERIAL_OPTION=y
CONFIG_USB_SERIAL_OMNINET=y
CONFIG_USB_SERIAL_OPTICON=m
# CONFIG_USB_SERIAL_XSENS_MT is not set
CONFIG_USB_SERIAL_WISHBONE=m
CONFIG_USB_SERIAL_SSU100=m
# CONFIG_USB_SERIAL_QT2 is not set
CONFIG_USB_SERIAL_UPD78F0730=m
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=y
CONFIG_USB_EMI26=m
CONFIG_USB_ADUTUX=y
CONFIG_USB_SEVSEG=y
CONFIG_USB_RIO500=m
# CONFIG_USB_LEGOTOWER is not set
CONFIG_USB_LCD=m
CONFIG_USB_CYPRESS_CY7C63=m
CONFIG_USB_CYTHERM=y
CONFIG_USB_IDMOUSE=y
CONFIG_USB_FTDI_ELAN=y
CONFIG_USB_APPLEDISPLAY=y
CONFIG_USB_SISUSBVGA=m
# CONFIG_USB_SISUSBVGA_CON is not set
CONFIG_USB_LD=m
CONFIG_USB_TRANCEVIBRATOR=y
# CONFIG_USB_IOWARRIOR is not set
CONFIG_USB_TEST=m
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
CONFIG_USB_ISIGHTFW=y
# CONFIG_USB_YUREX is not set
CONFIG_USB_EZUSB_FX2=y
CONFIG_USB_HUB_USB251XB=m
CONFIG_USB_HSIC_USB3503=y
CONFIG_USB_HSIC_USB4604=y
# CONFIG_USB_LINK_LAYER_TEST is not set
CONFIG_USB_CHAOSKEY=m
# CONFIG_UCSI is not set

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
CONFIG_NOP_USB_XCEIV=m
# CONFIG_USB_GPIO_VBUS is not set
CONFIG_USB_ISP1301=m
CONFIG_USB_GADGET=m
# CONFIG_USB_GADGET_DEBUG is not set
# CONFIG_USB_GADGET_DEBUG_FILES is not set
CONFIG_USB_GADGET_DEBUG_FS=y
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2

#
# USB Peripheral Controller
#
# CONFIG_USB_FOTG210_UDC is not set
CONFIG_USB_GR_UDC=m
# CONFIG_USB_R8A66597 is not set
# CONFIG_USB_PXA27X is not set
CONFIG_USB_MV_UDC=m
# CONFIG_USB_MV_U3D is not set
CONFIG_USB_M66592=m
CONFIG_USB_BDC_UDC=m

#
# Platform Support
#
CONFIG_USB_BDC_PCI=m
# CONFIG_USB_AMD5536UDC is not set
# CONFIG_USB_NET2272 is not set
# CONFIG_USB_NET2280 is not set
# CONFIG_USB_GOKU is not set
# CONFIG_USB_EG20T is not set
CONFIG_USB_GADGET_XILINX=m
# CONFIG_USB_DUMMY_HCD is not set
CONFIG_USB_LIBCOMPOSITE=m
CONFIG_USB_F_ACM=m
CONFIG_USB_F_SS_LB=m
CONFIG_USB_U_SERIAL=m
CONFIG_USB_F_OBEX=m
CONFIG_USB_F_MASS_STORAGE=m
CONFIG_USB_F_PRINTER=m
CONFIG_USB_CONFIGFS=m
# CONFIG_USB_CONFIGFS_SERIAL is not set
CONFIG_USB_CONFIGFS_ACM=y
CONFIG_USB_CONFIGFS_OBEX=y
# CONFIG_USB_CONFIGFS_NCM is not set
# CONFIG_USB_CONFIGFS_ECM is not set
# CONFIG_USB_CONFIGFS_ECM_SUBSET is not set
# CONFIG_USB_CONFIGFS_RNDIS is not set
# CONFIG_USB_CONFIGFS_EEM is not set
CONFIG_USB_CONFIGFS_MASS_STORAGE=y
CONFIG_USB_CONFIGFS_F_LB_SS=y
# CONFIG_USB_CONFIGFS_F_FS is not set
# CONFIG_USB_CONFIGFS_F_UAC1 is not set
# CONFIG_USB_CONFIGFS_F_UAC2 is not set
# CONFIG_USB_CONFIGFS_F_MIDI is not set
# CONFIG_USB_CONFIGFS_F_HID is not set
CONFIG_USB_CONFIGFS_F_PRINTER=y

#
# USB Power Delivery and Type-C drivers
#
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
CONFIG_UWB=y
CONFIG_UWB_HWA=y
# CONFIG_UWB_WHCI is not set
CONFIG_UWB_I1480U=m
CONFIG_MMC=m
CONFIG_MMC_DEBUG=y
CONFIG_PWRSEQ_EMMC=m
CONFIG_PWRSEQ_SIMPLE=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_MMC_BLOCK_BOUNCE=y
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
CONFIG_MMC_SDHCI=m
# CONFIG_MMC_SDHCI_PCI is not set
# CONFIG_MMC_SDHCI_ACPI is not set
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_OF_ARASAN is not set
CONFIG_MMC_SDHCI_OF_AT91=m
CONFIG_MMC_SDHCI_CADENCE=m
CONFIG_MMC_SDHCI_F_SDH30=m
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_SPI is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_VUB300 is not set
CONFIG_MMC_USHC=m
CONFIG_MMC_USDHI6ROL0=m
# CONFIG_MMC_REALTEK_USB is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
CONFIG_MEMSTICK=y
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=y
CONFIG_MS_BLOCK=y

#
# MemoryStick Host Controller Drivers
#
# CONFIG_MEMSTICK_TIFM_MS is not set
# CONFIG_MEMSTICK_JMICRON_38X is not set
# CONFIG_MEMSTICK_R592 is not set
CONFIG_MEMSTICK_REALTEK_USB=y
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
CONFIG_LEDS_BCM6328=y
CONFIG_LEDS_BCM6358=y
# CONFIG_LEDS_CPCAP is not set
# CONFIG_LEDS_LM3530 is not set
CONFIG_LEDS_LM3533=m
# CONFIG_LEDS_LM3642 is not set
CONFIG_LEDS_PCA9532=m
# CONFIG_LEDS_PCA9532_GPIO is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
CONFIG_LEDS_LP3952=y
CONFIG_LEDS_LP55XX_COMMON=y
CONFIG_LEDS_LP5521=y
CONFIG_LEDS_LP5523=y
CONFIG_LEDS_LP5562=y
CONFIG_LEDS_LP8501=y
CONFIG_LEDS_LP8860=y
# CONFIG_LEDS_CLEVO_MAIL is not set
# CONFIG_LEDS_PCA955X is not set
CONFIG_LEDS_PCA963X=m
CONFIG_LEDS_DAC124S085=y
CONFIG_LEDS_PWM=m
CONFIG_LEDS_REGULATOR=y
# CONFIG_LEDS_BD2802 is not set
# CONFIG_LEDS_INTEL_SS4200 is not set
# CONFIG_LEDS_LT3593 is not set
# CONFIG_LEDS_ADP5520 is not set
CONFIG_LEDS_MC13783=y
# CONFIG_LEDS_TCA6507 is not set
CONFIG_LEDS_TLC591XX=m
# CONFIG_LEDS_LM355x is not set
# CONFIG_LEDS_OT200 is not set
CONFIG_LEDS_MENF21BMC=y
CONFIG_LEDS_IS31FL319X=m
CONFIG_LEDS_IS31FL32XX=m

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
# CONFIG_LEDS_SYSCON is not set
CONFIG_LEDS_USER=y
# CONFIG_LEDS_NIC78BX is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=y
# CONFIG_LEDS_TRIGGER_ONESHOT is not set
# CONFIG_LEDS_TRIGGER_DISK is not set
CONFIG_LEDS_TRIGGER_MTD=y
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
CONFIG_LEDS_TRIGGER_CPU=y
CONFIG_LEDS_TRIGGER_GPIO=y
CONFIG_LEDS_TRIGGER_DEFAULT_ON=y

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
# CONFIG_LEDS_TRIGGER_CAMERA is not set
CONFIG_LEDS_TRIGGER_PANIC=y
CONFIG_ACCESSIBILITY=y
CONFIG_A11Y_BRAILLE_CONSOLE=y
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
CONFIG_EDAC_DEBUG=y
CONFIG_EDAC_DECODE_MCE=y
# CONFIG_EDAC_AMD64 is not set
# CONFIG_EDAC_AMD76X is not set
# CONFIG_EDAC_E7XXX is not set
# CONFIG_EDAC_E752X is not set
# CONFIG_EDAC_I82875P is not set
# CONFIG_EDAC_I82975X is not set
# CONFIG_EDAC_I3000 is not set
# CONFIG_EDAC_I3200 is not set
# CONFIG_EDAC_IE31200 is not set
# CONFIG_EDAC_X38 is not set
# CONFIG_EDAC_I5400 is not set
# CONFIG_EDAC_I7CORE is not set
# CONFIG_EDAC_I82860 is not set
# CONFIG_EDAC_R82600 is not set
# CONFIG_EDAC_I5000 is not set
# CONFIG_EDAC_I5100 is not set
# CONFIG_EDAC_I7300 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
# CONFIG_RTC_CLASS is not set
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
CONFIG_UIO=y
# CONFIG_UIO_CIF is not set
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
# CONFIG_UIO_AEC is not set
# CONFIG_UIO_SERCOS3 is not set
# CONFIG_UIO_PCI_GENERIC is not set
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_VIRT_DRIVERS=y
CONFIG_VIRTIO=y

#
# Virtio drivers
#
# CONFIG_VIRTIO_PCI is not set
# CONFIG_VIRTIO_BALLOON is not set
CONFIG_VIRTIO_INPUT=y
CONFIG_VIRTIO_MMIO=y
CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# CONFIG_HYPERV_TSCPAGE is not set
# CONFIG_STAGING is not set
CONFIG_X86_PLATFORM_DEVICES=y
# CONFIG_ACERHDF is not set
# CONFIG_ASUS_LAPTOP is not set
# CONFIG_DELL_LAPTOP is not set
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
# CONFIG_INTEL_CHT_INT33FE is not set
# CONFIG_INTEL_HID_EVENT is not set
# CONFIG_INTEL_VBTN is not set
# CONFIG_INTEL_IPS is not set
# CONFIG_INTEL_PMC_CORE is not set
# CONFIG_IBM_RTL is not set
CONFIG_SAMSUNG_LAPTOP=y
# CONFIG_SAMSUNG_Q10 is not set
# CONFIG_APPLE_GMUX is not set
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_PVPANIC is not set
# CONFIG_INTEL_PMC_IPC is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
# CONFIG_SURFACE_3_BUTTON is not set
# CONFIG_INTEL_PUNIT_IPC is not set
CONFIG_MLX_CPLD_PLATFORM=m
CONFIG_PMC_ATOM=y
CONFIG_CHROME_PLATFORMS=y
CONFIG_CHROMEOS_LAPTOP=y
CONFIG_CHROMEOS_PSTORE=y
# CONFIG_CROS_EC_CHARDEV is not set
# CONFIG_CROS_EC_LPC is not set
CONFIG_CROS_EC_PROTO=y
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_MAX77686 is not set
# CONFIG_COMMON_CLK_RK808 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI514 is not set
# CONFIG_COMMON_CLK_SI570 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CDCE925 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_S2MPS11 is not set
# CONFIG_CLK_TWL6040 is not set
# CONFIG_COMMON_CLK_NXP is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_COMMON_CLK_PXA is not set
# CONFIG_COMMON_CLK_PIC32 is not set
# CONFIG_COMMON_CLK_VC5 is not set

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
CONFIG_MAILBOX=y
CONFIG_PLATFORM_MHU=y
# CONFIG_PCC is not set
CONFIG_ALTERA_MBOX=y
# CONFIG_MAILBOX_TEST is not set
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=m

#
# Rpmsg drivers
#

#
# SOC (System On Chip) specific Drivers
#

#
# Broadcom SoC drivers
#

#
# i.MX SoC drivers
#
# CONFIG_SUNXI_SRAM is not set
CONFIG_SOC_TI=y
# CONFIG_SOC_ZTE is not set
# CONFIG_PM_DEVFREQ is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=y
CONFIG_EXTCON_AXP288=m
# CONFIG_EXTCON_GPIO is not set
# CONFIG_EXTCON_INTEL_INT3496 is not set
CONFIG_EXTCON_MAX3355=y
CONFIG_EXTCON_MAX77693=m
CONFIG_EXTCON_MAX77843=y
# CONFIG_EXTCON_QCOM_SPMI_MISC is not set
CONFIG_EXTCON_RT8973A=m
# CONFIG_EXTCON_SM5502 is not set
# CONFIG_EXTCON_USB_GPIO is not set
# CONFIG_MEMORY is not set
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=y
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=m
CONFIG_IIO_SW_TRIGGER=y

#
# Accelerometers
#
# CONFIG_BMA180 is not set
CONFIG_BMA220=y
CONFIG_BMC150_ACCEL=y
CONFIG_BMC150_ACCEL_I2C=y
CONFIG_BMC150_ACCEL_SPI=y
CONFIG_DA280=m
CONFIG_DA311=y
# CONFIG_DMARD06 is not set
CONFIG_DMARD09=y
# CONFIG_DMARD10 is not set
CONFIG_HID_SENSOR_ACCEL_3D=m
CONFIG_KXSD9=m
# CONFIG_KXSD9_SPI is not set
CONFIG_KXSD9_I2C=m
CONFIG_KXCJK1013=y
CONFIG_MC3230=m
CONFIG_MMA7455=m
# CONFIG_MMA7455_I2C is not set
CONFIG_MMA7455_SPI=m
# CONFIG_MMA7660 is not set
CONFIG_MMA8452=y
# CONFIG_MMA9551 is not set
# CONFIG_MMA9553 is not set
CONFIG_MXC4005=y
CONFIG_MXC6255=m
CONFIG_SCA3000=m
CONFIG_STK8312=m
CONFIG_STK8BA50=m

#
# Analog to digital converters
#
CONFIG_AD_SIGMA_DELTA=m
# CONFIG_AD7266 is not set
CONFIG_AD7291=m
# CONFIG_AD7298 is not set
CONFIG_AD7476=m
CONFIG_AD7766=m
CONFIG_AD7791=m
# CONFIG_AD7793 is not set
CONFIG_AD7887=m
CONFIG_AD7923=m
# CONFIG_AD799X is not set
# CONFIG_AXP20X_ADC is not set
CONFIG_AXP288_ADC=m
# CONFIG_CC10001_ADC is not set
# CONFIG_CPCAP_ADC is not set
CONFIG_ENVELOPE_DETECTOR=y
# CONFIG_HI8435 is not set
# CONFIG_HX711 is not set
# CONFIG_INA2XX_ADC is not set
CONFIG_LTC2485=m
CONFIG_LTC2497=y
CONFIG_MAX1027=y
CONFIG_MAX11100=m
CONFIG_MAX1118=y
# CONFIG_MAX1363 is not set
CONFIG_MAX9611=m
CONFIG_MCP320X=m
CONFIG_MCP3422=m
# CONFIG_MEN_Z188_ADC is not set
# CONFIG_NAU7802 is not set
# CONFIG_STX104 is not set
# CONFIG_TI_ADC081C is not set
# CONFIG_TI_ADC0832 is not set
CONFIG_TI_ADC12138=m
CONFIG_TI_ADC128S052=m
# CONFIG_TI_ADC161S626 is not set
# CONFIG_TI_ADS1015 is not set
CONFIG_TI_ADS7950=m
CONFIG_TI_ADS8688=m
CONFIG_TI_AM335X_ADC=m
CONFIG_TI_TLC4541=m
# CONFIG_TWL4030_MADC is not set
CONFIG_TWL6030_GPADC=m
CONFIG_VF610_ADC=y

#
# Amplifiers
#
# CONFIG_AD8366 is not set

#
# Chemical Sensors
#
# CONFIG_ATLAS_PH_SENSOR is not set
CONFIG_IAQCORE=m
# CONFIG_VZ89X is not set
CONFIG_IIO_CROS_EC_SENSORS_CORE=m
CONFIG_IIO_CROS_EC_SENSORS=m

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=m
CONFIG_HID_SENSOR_IIO_TRIGGER=m
CONFIG_IIO_MS_SENSORS_I2C=m

#
# SSP Sensor Common
#
# CONFIG_IIO_SSP_SENSORHUB is not set
CONFIG_IIO_ST_SENSORS_I2C=m
CONFIG_IIO_ST_SENSORS_SPI=m
CONFIG_IIO_ST_SENSORS_CORE=m

#
# Counters
#
CONFIG_104_QUAD_8=y

#
# Digital to analog converters
#
# CONFIG_AD5064 is not set
CONFIG_AD5360=y
# CONFIG_AD5380 is not set
CONFIG_AD5421=m
# CONFIG_AD5446 is not set
CONFIG_AD5449=y
CONFIG_AD5592R_BASE=m
CONFIG_AD5592R=m
# CONFIG_AD5593R is not set
# CONFIG_AD5504 is not set
# CONFIG_AD5624R_SPI is not set
# CONFIG_LTC2632 is not set
CONFIG_AD5686=m
CONFIG_AD5755=m
CONFIG_AD5761=m
# CONFIG_AD5764 is not set
# CONFIG_AD5791 is not set
CONFIG_AD7303=m
CONFIG_CIO_DAC=y
CONFIG_AD8801=y
CONFIG_DPOT_DAC=y
CONFIG_M62332=y
# CONFIG_MAX517 is not set
CONFIG_MAX5821=m
# CONFIG_MCP4725 is not set
CONFIG_MCP4922=m
CONFIG_VF610_DAC=m

#
# IIO dummy driver
#
# CONFIG_IIO_SIMPLE_DUMMY is not set

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
CONFIG_AD9523=m

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
# CONFIG_ADF4350 is not set

#
# Digital gyroscope sensors
#
CONFIG_ADIS16080=m
CONFIG_ADIS16130=m
# CONFIG_ADIS16136 is not set
CONFIG_ADIS16260=y
# CONFIG_ADXRS450 is not set
# CONFIG_BMG160 is not set
CONFIG_HID_SENSOR_GYRO_3D=m
# CONFIG_MPU3050_I2C is not set
# CONFIG_IIO_ST_GYRO_3AXIS is not set
# CONFIG_ITG3200 is not set

#
# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4403=m
CONFIG_AFE4404=m
CONFIG_MAX30100=m
CONFIG_MAX30102=y

#
# Humidity sensors
#
# CONFIG_AM2315 is not set
CONFIG_DHT11=m
CONFIG_HDC100X=y
CONFIG_HID_SENSOR_HUMIDITY=m
CONFIG_HTS221=m
CONFIG_HTS221_I2C=m
CONFIG_HTS221_SPI=m
CONFIG_HTU21=m
# CONFIG_SI7005 is not set
# CONFIG_SI7020 is not set

#
# Inertial measurement units
#
CONFIG_ADIS16400=m
CONFIG_ADIS16480=m
CONFIG_BMI160=y
CONFIG_BMI160_I2C=y
CONFIG_BMI160_SPI=y
CONFIG_KMX61=y
# CONFIG_INV_MPU6050_SPI is not set
CONFIG_IIO_ST_LSM6DSX=m
CONFIG_IIO_ST_LSM6DSX_I2C=m
CONFIG_IIO_ST_LSM6DSX_SPI=m
CONFIG_IIO_ADIS_LIB=y
CONFIG_IIO_ADIS_LIB_BUFFER=y

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
# CONFIG_ADJD_S311 is not set
CONFIG_AL3320A=m
CONFIG_APDS9300=y
CONFIG_APDS9960=m
CONFIG_BH1750=m
CONFIG_BH1780=m
# CONFIG_CM32181 is not set
# CONFIG_CM3232 is not set
# CONFIG_CM3323 is not set
CONFIG_CM3605=y
# CONFIG_CM36651 is not set
CONFIG_IIO_CROS_EC_LIGHT_PROX=m
# CONFIG_GP2AP020A00F is not set
CONFIG_SENSORS_ISL29018=y
CONFIG_ISL29125=m
CONFIG_HID_SENSOR_ALS=m
# CONFIG_HID_SENSOR_PROX is not set
CONFIG_JSA1212=y
CONFIG_RPR0521=m
# CONFIG_SENSORS_LM3533 is not set
CONFIG_LTR501=m
CONFIG_MAX44000=m
CONFIG_OPT3001=y
CONFIG_PA12203001=m
# CONFIG_SI1145 is not set
CONFIG_STK3310=m
# CONFIG_TCS3414 is not set
CONFIG_TCS3472=y
CONFIG_SENSORS_TSL2563=y
CONFIG_TSL2583=y
# CONFIG_TSL4531 is not set
CONFIG_US5182D=y
# CONFIG_VCNL4000 is not set
CONFIG_VEML6070=m
CONFIG_VL6180=m

#
# Magnetometer sensors
#
CONFIG_AK8974=m
CONFIG_AK8975=m
CONFIG_AK09911=m
CONFIG_BMC150_MAGN=m
CONFIG_BMC150_MAGN_I2C=m
# CONFIG_BMC150_MAGN_SPI is not set
# CONFIG_MAG3110 is not set
CONFIG_HID_SENSOR_MAGNETOMETER_3D=m
# CONFIG_MMC35240 is not set
CONFIG_IIO_ST_MAGN_3AXIS=m
CONFIG_IIO_ST_MAGN_I2C_3AXIS=m
CONFIG_IIO_ST_MAGN_SPI_3AXIS=m
# CONFIG_SENSORS_HMC5843_I2C is not set
# CONFIG_SENSORS_HMC5843_SPI is not set

#
# Inclinometer sensors
#
# CONFIG_HID_SENSOR_INCLINOMETER_3D is not set
CONFIG_HID_SENSOR_DEVICE_ROTATION=m

#
# Triggers - standalone
#
# CONFIG_IIO_HRTIMER_TRIGGER is not set
CONFIG_IIO_INTERRUPT_TRIGGER=y
CONFIG_IIO_TIGHTLOOP_TRIGGER=y
CONFIG_IIO_SYSFS_TRIGGER=y

#
# Digital potentiometers
#
# CONFIG_DS1803 is not set
# CONFIG_MAX5481 is not set
CONFIG_MAX5487=m
CONFIG_MCP4131=y
CONFIG_MCP4531=y
CONFIG_TPL0102=m

#
# Digital potentiostats
#
CONFIG_LMP91000=y

#
# Pressure sensors
#
CONFIG_ABP060MG=m
# CONFIG_BMP280 is not set
# CONFIG_IIO_CROS_EC_BARO is not set
CONFIG_HID_SENSOR_PRESS=m
CONFIG_HP03=m
CONFIG_MPL115=y
CONFIG_MPL115_I2C=y
# CONFIG_MPL115_SPI is not set
CONFIG_MPL3115=y
# CONFIG_MS5611 is not set
CONFIG_MS5637=m
# CONFIG_IIO_ST_PRESS is not set
# CONFIG_T5403 is not set
CONFIG_HP206C=m
CONFIG_ZPA2326=m
CONFIG_ZPA2326_I2C=m
CONFIG_ZPA2326_SPI=m

#
# Lightning sensors
#
# CONFIG_AS3935 is not set

#
# Proximity and distance sensors
#
CONFIG_LIDAR_LITE_V2=m
CONFIG_SRF04=m
CONFIG_SX9500=m
CONFIG_SRF08=y

#
# Temperature sensors
#
# CONFIG_MAXIM_THERMOCOUPLE is not set
CONFIG_HID_SENSOR_TEMP=m
CONFIG_MLX90614=y
# CONFIG_TMP006 is not set
CONFIG_TMP007=y
CONFIG_TSYS01=m
CONFIG_TSYS02D=m
# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_CROS_EC=m
CONFIG_PWM_FSL_FTM=y
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
# CONFIG_PWM_PCA9685 is not set
CONFIG_PWM_STMPE=y
# CONFIG_PWM_TWL is not set
CONFIG_PWM_TWL_LED=m
CONFIG_IRQCHIP=y
CONFIG_ARM_GIC_MAX_NR=1
CONFIG_IPACK_BUS=m
# CONFIG_BOARD_TPCI200 is not set
CONFIG_SERIAL_IPOCTAL=m
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_ATH79 is not set
# CONFIG_RESET_BERLIN is not set
# CONFIG_RESET_IMX7 is not set
# CONFIG_RESET_LPC18XX is not set
# CONFIG_RESET_MESON is not set
# CONFIG_RESET_PISTACHIO is not set
# CONFIG_RESET_SOCFPGA is not set
# CONFIG_RESET_STM32 is not set
# CONFIG_RESET_SUNXI is not set
# CONFIG_TI_SYSCON_RESET is not set
# CONFIG_RESET_ZYNQ is not set
# CONFIG_RESET_TEGRA_BPMP is not set
CONFIG_FMC=y
# CONFIG_FMC_FAKEDEV is not set
# CONFIG_FMC_TRIVIAL is not set
CONFIG_FMC_WRITE_EEPROM=y
CONFIG_FMC_CHARDEV=m

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_PHY_PXA_28NM_HSIC is not set
CONFIG_PHY_PXA_28NM_USB2=m
CONFIG_BCM_KONA_USB2_PHY=y
CONFIG_PHY_SAMSUNG_USB2=m
# CONFIG_PHY_EXYNOS4210_USB2 is not set
# CONFIG_PHY_EXYNOS4X12_USB2 is not set
# CONFIG_PHY_EXYNOS5250_USB2 is not set
CONFIG_POWERCAP=y
CONFIG_MCB=m
# CONFIG_MCB_PCI is not set
CONFIG_MCB_LPC=m

#
# Performance monitor support
#
CONFIG_RAS=y
# CONFIG_MCE_AMD_INJ is not set
# CONFIG_THUNDERBOLT is not set

#
# Android
#
# CONFIG_ANDROID is not set
CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_BLK=m
# CONFIG_BTT is not set
CONFIG_DAX=y
CONFIG_NVMEM=m
CONFIG_STM=y
CONFIG_STM_DUMMY=m
# CONFIG_STM_SOURCE_CONSOLE is not set
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_INTEL_TH=y
# CONFIG_INTEL_TH_PCI is not set
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=y
# CONFIG_INTEL_TH_MSU is not set
# CONFIG_INTEL_TH_PTI is not set
# CONFIG_INTEL_TH_DEBUG is not set

#
# FPGA Configuration Support
#
CONFIG_FPGA=m
CONFIG_FPGA_REGION=m
CONFIG_FPGA_MGR_ICE40_SPI=m
CONFIG_FPGA_MGR_XILINX_SPI=m
CONFIG_FPGA_BRIDGE=m
CONFIG_ALTERA_PR_IP_CORE=m
CONFIG_ALTERA_PR_IP_CORE_PLAT=m
# CONFIG_XILINX_PR_DECOUPLER is not set

#
# FSI support
#
# CONFIG_FSI is not set

#
# Firmware Drivers
#
CONFIG_EDD=y
CONFIG_EDD_OFF=y
CONFIG_FIRMWARE_MEMMAP=y
# CONFIG_DELL_RBU is not set
CONFIG_DCDBAS=m
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT_FIND is not set
CONFIG_FW_CFG_SYSFS=m
CONFIG_FW_CFG_SYSFS_CMDLINE=y
CONFIG_GOOGLE_FIRMWARE=y
CONFIG_GOOGLE_COREBOOT_TABLE=m
# CONFIG_GOOGLE_COREBOOT_TABLE_ACPI is not set
CONFIG_GOOGLE_COREBOOT_TABLE_OF=m
CONFIG_GOOGLE_MEMCONSOLE=m
# CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY is not set
CONFIG_GOOGLE_MEMCONSOLE_COREBOOT=m
CONFIG_GOOGLE_VPD=m
# CONFIG_EFI_DEV_PATH_PARSER is not set

#
# Tegra firmware driver
#

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=m
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT3_FS is not set
# CONFIG_EXT4_FS is not set
CONFIG_REISERFS_FS=m
CONFIG_REISERFS_CHECK=y
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_REISERFS_FS_XATTR is not set
CONFIG_JFS_FS=m
# CONFIG_JFS_POSIX_ACL is not set
CONFIG_JFS_SECURITY=y
CONFIG_JFS_DEBUG=y
CONFIG_JFS_STATISTICS=y
# CONFIG_XFS_FS is not set
CONFIG_GFS2_FS=y
# CONFIG_OCFS2_FS is not set
# CONFIG_BTRFS_FS is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=y
# CONFIG_F2FS_STAT_FS is not set
# CONFIG_F2FS_FS_XATTR is not set
CONFIG_F2FS_CHECK_FS=y
CONFIG_F2FS_FAULT_INJECTION=y
CONFIG_FS_DAX=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
# CONFIG_FS_ENCRYPTION is not set
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
# CONFIG_QUOTA is not set
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=m
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
CONFIG_OVERLAY_FS=y
CONFIG_OVERLAY_FS_REDIRECT_DIR=y

#
# Caches
#
# CONFIG_FSCACHE is not set

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
CONFIG_UDF_FS=y
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
# CONFIG_MSDOS_FS is not set
# CONFIG_VFAT_FS is not set
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
# CONFIG_PROC_CHILDREN is not set
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_CONFIGFS_FS=y
# CONFIG_MISC_FILESYSTEMS is not set
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
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=y
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=y
# CONFIG_NLS_CODEPAGE_860 is not set
CONFIG_NLS_CODEPAGE_861=m
# CONFIG_NLS_CODEPAGE_862 is not set
CONFIG_NLS_CODEPAGE_863=m
# CONFIG_NLS_CODEPAGE_864 is not set
CONFIG_NLS_CODEPAGE_865=m
# CONFIG_NLS_CODEPAGE_866 is not set
CONFIG_NLS_CODEPAGE_869=y
CONFIG_NLS_CODEPAGE_936=y
CONFIG_NLS_CODEPAGE_950=m
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
CONFIG_NLS_ISO8859_8=y
CONFIG_NLS_CODEPAGE_1250=m
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=y
CONFIG_NLS_ISO8859_3=y
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=y
# CONFIG_NLS_ISO8859_7 is not set
CONFIG_NLS_ISO8859_9=y
CONFIG_NLS_ISO8859_13=y
CONFIG_NLS_ISO8859_14=y
# CONFIG_NLS_ISO8859_15 is not set
CONFIG_NLS_KOI8_R=m
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_MAC_ROMAN is not set
CONFIG_NLS_MAC_CELTIC=y
# CONFIG_NLS_MAC_CENTEURO is not set
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=y
CONFIG_NLS_MAC_GREEK=y
# CONFIG_NLS_MAC_ICELAND is not set
# CONFIG_NLS_MAC_INUIT is not set
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=y
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
CONFIG_BOOT_PRINTK_DELAY=y
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
CONFIG_FRAME_WARN=1024
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
CONFIG_UNUSED_SYMBOLS=y
# CONFIG_PAGE_OWNER is not set
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
CONFIG_DEBUG_SECTION_MISMATCH=y
# CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
CONFIG_ARCH_WANT_FRAME_POINTERS=y
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
# CONFIG_PAGE_POISONING is not set
CONFIG_DEBUG_RODATA_TEST=y
# CONFIG_DEBUG_OBJECTS is not set
CONFIG_DEBUG_SLAB=y
# CONFIG_DEBUG_SLAB_LEAK is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_DEBUG_PER_CPU_MAPS=y
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
CONFIG_HAVE_ARCH_KMEMCHECK=y
# CONFIG_KMEMCHECK is not set
# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_HARDLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=0
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=1
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_DEBUG_TIMEKEEPING=y
# CONFIG_DEBUG_PREEMPT is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_PROVE_LOCKING=y
CONFIG_LOCKDEP=y
CONFIG_LOCK_STAT=y
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
CONFIG_WW_MUTEX_SELFTEST=y
CONFIG_TRACE_IRQFLAGS=y
CONFIG_STACKTRACE=y
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PI_LIST is not set
# CONFIG_DEBUG_SG is not set
CONFIG_DEBUG_NOTIFIERS=y
CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
# CONFIG_PROVE_RCU_REPEATEDLY is not set
# CONFIG_SPARSE_RCU_POINTER is not set
CONFIG_TORTURE_TEST=y
# CONFIG_RCU_PERF_TEST is not set
CONFIG_RCU_TORTURE_TEST=y
# CONFIG_RCU_TORTURE_TEST_SLOW_PREINIT is not set
# CONFIG_RCU_TORTURE_TEST_SLOW_INIT is not set
# CONFIG_RCU_TORTURE_TEST_SLOW_CLEANUP is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
# CONFIG_RCU_TRACE is not set
CONFIG_RCU_EQS_DEBUG=y
# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_NOTIFIER_ERROR_INJECTION=y
CONFIG_PM_NOTIFIER_ERROR_INJECT=y
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FAULT_INJECTION=y
CONFIG_FAILSLAB=y
# CONFIG_FAIL_PAGE_ALLOC is not set
CONFIG_FAIL_MAKE_REQUEST=y
CONFIG_FAIL_IO_TIMEOUT=y
CONFIG_FAIL_MMC_REQUEST=y
CONFIG_FAIL_FUTEX=y
CONFIG_FAULT_INJECTION_DEBUG_FS=y
CONFIG_FAULT_INJECTION_STACKTRACE_FILTER=y
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set

#
# Runtime Testing
#
CONFIG_LKDTM=m
CONFIG_TEST_LIST_SORT=m
CONFIG_TEST_SORT=m
# CONFIG_BACKTRACE_SELF_TEST is not set
CONFIG_RBTREE_TEST=y
CONFIG_INTERVAL_TREE_TEST=m
CONFIG_PERCPU_TEST=m
# CONFIG_ATOMIC64_SELFTEST is not set
CONFIG_TEST_HEXDUMP=m
CONFIG_TEST_STRING_HELPERS=y
CONFIG_TEST_KSTRTOX=y
CONFIG_TEST_PRINTF=y
CONFIG_TEST_BITMAP=m
CONFIG_TEST_UUID=y
# CONFIG_TEST_RHASHTABLE is not set
CONFIG_TEST_HASH=m
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_DMA_API_DEBUG is not set
CONFIG_TEST_LKM=m
# CONFIG_TEST_USER_COPY is not set
# CONFIG_TEST_BPF is not set
# CONFIG_TEST_FIRMWARE is not set
CONFIG_TEST_UDELAY=m
CONFIG_MEMTEST=y
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
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
# CONFIG_EARLY_PRINTK_USB_XDBC is not set
# CONFIG_X86_PTDUMP_CORE is not set
# CONFIG_X86_PTDUMP is not set
# CONFIG_DEBUG_WX is not set
CONFIG_DOUBLEFAULT=y
# CONFIG_DEBUG_TLBFLUSH is not set
# CONFIG_IOMMU_STRESS is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
# CONFIG_IO_DELAY_0X80 is not set
# CONFIG_IO_DELAY_0XED is not set
CONFIG_IO_DELAY_UDELAY=y
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=2
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
# CONFIG_OPTIMIZE_INLINING is not set
CONFIG_DEBUG_ENTRY=y
CONFIG_DEBUG_NMI_SELFTEST=y
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set

#
# Security options
#
CONFIG_KEYS=y
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_BIG_KEYS=y
CONFIG_TRUSTED_KEYS=m
CONFIG_ENCRYPTED_KEYS=m
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
# CONFIG_SECURITY is not set
CONFIG_SECURITYFS=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
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
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
# CONFIG_CRYPTO_ECDH is not set
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_MCRYPTD=m
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_ABLK_HELPER=y
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
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=y
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=y
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=y
CONFIG_CRYPTO_CRC32=y
# CONFIG_CRYPTO_CRC32_PCLMUL is not set
CONFIG_CRYPTO_CRCT10DIF=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_MICHAEL_MIC=y
CONFIG_CRYPTO_RMD128=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_RMD256=y
CONFIG_CRYPTO_RMD320=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_TGR192=y
CONFIG_CRYPTO_WP512=y

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=m
CONFIG_CRYPTO_AES_586=y
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_ANUBIS=y
CONFIG_CRYPTO_ARC4=m
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_CAMELLIA is not set
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_DES=y
# CONFIG_CRYPTO_FCRYPT is not set
CONFIG_CRYPTO_KHAZAD=y
CONFIG_CRYPTO_SALSA20=m
# CONFIG_CRYPTO_SALSA20_586 is not set
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_586=y
# CONFIG_CRYPTO_TEA is not set
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_586=y

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=m
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=m

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
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
CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=4096
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
# CONFIG_KVM is not set
# CONFIG_VHOST_NET is not set
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set
# CONFIG_LGUEST is not set
# CONFIG_BINARY_PRINTF is not set

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
# CONFIG_CRC_CCITT is not set
CONFIG_CRC16=m
CONFIG_CRC_T10DIF=m
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
CONFIG_CRC32_SARWATE=y
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=m
CONFIG_CRC8=y
# CONFIG_AUDIT_ARCH_COMPAT_GENERIC is not set
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=m
CONFIG_842_DECOMPRESS=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=m
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=m
CONFIG_LZ4_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_DEC16=y
CONFIG_BCH=m
CONFIG_BCH_CONST_PARAMS=y
CONFIG_INTERVAL_TREE=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
# CONFIG_DMA_NOOP_OPS is not set
# CONFIG_DMA_VIRT_OPS is not set
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_CORDIC=y
# CONFIG_DDR is not set
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_FONT_SUPPORT=y
CONFIG_FONTS=y
CONFIG_FONT_8x8=y
# CONFIG_FONT_8x16 is not set
CONFIG_FONT_6x11=y
# CONFIG_FONT_7x14 is not set
CONFIG_FONT_PEARL_8x8=y
CONFIG_FONT_ACORN_8x8=y
CONFIG_FONT_MINI_4x6=y
# CONFIG_FONT_6x10 is not set
CONFIG_FONT_10x18=y
CONFIG_FONT_SUN8x16=y
CONFIG_FONT_SUN12x22=y
# CONFIG_SG_SPLIT is not set
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_ARCH_HAS_MMIO_FLUSH=y
CONFIG_STACKDEPOT=y
CONFIG_SBITMAP=y
CONFIG_PRIME_NUMBERS=m

--CE+1k2dSO48ffgeK--
