Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E21C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 01:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D78EB208E3
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 01:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfABBGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 20:06:22 -0500
Received: from mga06.intel.com ([134.134.136.31]:31909 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbfABBGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 20:06:21 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Jan 2019 17:06:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,429,1539673200"; 
   d="gz'50?scan'50,208,50";a="103221918"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.6])
  by orsmga007.jf.intel.com with ESMTP; 01 Jan 2019 17:06:13 -0800
Date:   Wed, 2 Jan 2019 09:06:23 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        LKP <lkp@01.org>
Subject: [LKP] 8b5b7958fd [ 90.848440] BUG: unable to handle kernel paging
 request at 6b6b6b6b
Message-ID: <20190102010623.GE17624@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="gDGSpKKIBgtShtf+"
Content-Disposition: inline
User-Agent: Heirloom mailx 12.5 6/20/10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gDGSpKKIBgtShtf+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

commit 8b5b7958fd1cac54bdca62ec5552c6be0b38def4
Author:     Alexandre Belloni <alexandre.belloni@bootlin.com>
AuthorDate: Mon Feb 12 23:47:46 2018 +0100
Commit:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CommitDate: Thu Mar 1 10:49:29 2018 +0100

    rtc: cmos: use generic nvmem
    
    Instead of adding a binary sysfs attribute from the driver, use the
    core to register an nvmem device. This allows to use the in-kernel
    interface to access the nvram.
    
    Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

53d29e0a3a  rtc: cmos: fix possible race condition
8b5b7958fd  rtc: cmos: use generic nvmem
195303136f  Merge tag 'kconfig-v4.21-2' of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild
6a1d293238  Add linux-next specific files for 20181224
+------------------------------------------+------------+------------+------------+---------------+
|                                          | 53d29e0a3a | 8b5b7958fd | 195303136f | next-20181224 |
+------------------------------------------+------------+------------+------------+---------------+
| boot_successes                           | 0          | 0          | 0          | 0             |
| boot_failures                            | 55         | 11         | 14         | 9             |
| es#_lib.c:#ess_reset_at#:failed          | 55         | 0          | 2          |               |
| BUG:unable_to_handle_kernel              | 0          | 11         | 12         | 9             |
| Oops:#[##]                               | 0          | 11         | 12         | 9             |
| EIP:strlen                               | 0          | 11         | 12         | 9             |
| Kernel_panic-not_syncing:Fatal_exception | 0          | 11         | 12         | 9             |
+------------------------------------------+------------+------------+------------+---------------+

[   90.813587] usbcore: registered new interface driver yealink
[   90.819856] ideapad_slidebar: DMI does not match
[   90.827650] rtc_cmos 00:00: RTC can wake from S4
[   90.838651] rtc_cmos 00:00: registered as rtc0
[   90.841964] rtc_cmos 00:00: alarms up to one day, y3k, 114 bytes nvram, hpet irqs
[   90.848440] BUG: unable to handle kernel paging request at 6b6b6b6b
[   90.850772] IP: strlen+0xd/0x20
[   90.850772] *pde = 00000000 
[   90.850772] Oops: 0000 [#1] PREEMPT DEBUG_PAGEALLOC
[   90.850772] CPU: 0 PID: 1 Comm: swapper Not tainted 4.16.0-rc1-00037-g8b5b795 #1
[   90.850772] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[   90.850772] EIP: strlen+0xd/0x20
[   90.850772] EFLAGS: 00210246 CPU: 0
[   90.850772] EAX: 00000000 EBX: 4030e7a8 ECX: ffffffff EDX: 00000000
[   90.850772] ESI: 6b6b6b6b EDI: 6b6b6b6b EBP: 40059d74 ESP: 40059d70
[   90.850772]  DS: 007b ES: 007b FS: 0000 GS: 00e0 SS: 0068
[   90.850772] CR0: 80050033 CR2: 6b6b6b6b CR3: 1a6d7000 CR4: 00140690
[   90.850772] Call Trace:
[   90.850772]  ? kernfs_name_hash+0xf/0x70
[   90.850772]  ? kernfs_find_ns+0x3d/0x110
[   90.850772]  ? release_nodes+0x10f/0x1f0
[   90.850772]  ? usb_disconnect+0xbc/0x270
[   90.850772]  ? kernfs_remove_by_name_ns+0x2b/0x80
[   90.850772]  ? sysfs_remove_bin_file+0xf/0x20
[   90.850772]  ? rtc_nvmem_unregister+0x2c/0x60
[   90.850772]  ? devm_rtc_release_device+0xd/0x30
[   90.850772]  ? release_nodes+0x106/0x1f0
[   90.850772]  ? usb_disconnect+0xbc/0x270
[   90.850772]  ? devres_release_all+0x34/0x50
[   90.850772]  ? driver_probe_device+0xdf/0x560
[   90.850772]  ? compare_pnp_id+0x24/0xf0
[   90.850772]  ? usb_disconnect+0xbc/0x270
[   90.850772]  ? __driver_attach+0xd9/0x100
[   90.850772]  ? klist_next+0x70/0xf0
[   90.850772]  ? bus_release+0x20/0x20
[   90.850772]  ? driver_probe_device+0x560/0x560
[   90.850772]  ? bus_for_each_dev+0x57/0xa0
[   90.850772]  ? usb_disconnect+0xbc/0x270
[   90.850772]  ? driver_attach+0x19/0x20
[   90.850772]  ? driver_probe_device+0x560/0x560
[   90.850772]  ? bus_add_driver+0x1b7/0x270
[   90.850772]  ? driver_register+0x54/0xe0
[   90.850772]  ? driver_register+0x83/0xe0
[   90.850772]  ? i2c_register_driver+0x49/0x90
[   90.850772]  ? bq4802_driver_init+0x11/0x11
[   90.850772]  ? pnp_register_driver+0x17/0x20
[   90.850772]  ? cmos_init+0xe/0x60
[   90.850772]  ? bq4802_driver_init+0x11/0x11
[   90.850772]  ? do_one_initcall+0x86/0x13b
[   90.850772]  ? set_debug_rodata+0xf/0xf
[   90.850772]  ? usb_disconnect+0xbc/0x270
[   90.850772]  ? kernel_init_freeable+0xdc/0x150
[   90.850772]  ? rest_init+0x110/0x110
[   90.850772]  ? kernel_init+0xb/0x100
[   90.850772]  ? schedule_tail_wrapper+0x9/0xc
[   90.850772]  ? ret_from_fork+0x19/0x24
[   90.850772] Code: c0 75 fa 89 d8 8b 75 f8 8b 5d f4 8b 7d fc 89 ec 5d c3 8d b6 00 00 00 00 8d bf 00 00 00 00 55 b9 ff ff ff ff 89 e5 57 89 c7 31 c0 <f2> ae 5f b8 fe ff ff ff 29 c8 5d c3 8d b4 26 00 00 00 00 55 89
[   90.850772] EIP: strlen+0xd/0x20 SS:ESP: 0068:40059d70
[   90.850772] CR2: 000000006b6b6b6b
[   90.850772] ---[ end trace 784ab93ce82a3a47 ]---
[   90.850772] Kernel panic - not syncing: Fatal exception

                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start v4.17 v4.16 --
git bisect  bad 83beed7b2b26f232d782127792dd0cd4362fdc41  # 12:35  B      0    11   25   0  Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal
git bisect good 8844a509863d7da41024194e40190ec00c2cd890  # 12:46  G     11     0   11  22  Merge branch 'misc.sparc' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs
git bisect  bad 80aa76bcd3642480e17bc27811665d928c0b87d6  # 12:47  B      0    11   25   0  Merge tag 'xfs-4.17-merge-4' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux
git bisect  bad f77cfbe6455a67d4e9b69f08f07fc62cd11b0674  # 13:04  B      0     7   44  23  Merge tag 'for-linus' of git://linux-c6x.org/git/projects/linux-c6x-upstreaming
git bisect good fd40ffc72e2f74c7db61e400903e7d50a88bc0b0  # 13:24  G     10     0   10  21  selinux: fix missing dput() before selinuxfs unmount
git bisect good d36260050e1881dce09625a9352d8729c911a6e3  # 13:33  G     11     0   11  15  Merge tag 'media/v4.17-2' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
git bisect  bad fbe173e3ffbd897b5a859020d714c0eaf4af2a1a  # 13:45  B      0     1   15   0  Merge tag 'rtc-4.17' of git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux
git bisect good 7aa1cf254ca66bc9602bc5adef5bf1d611869a69  # 14:21  G     11     0   11  11  Merge tag 'sound-fix-4.17-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
git bisect good 5e630afdcb82779f5bf03fd4a5e86adc56fe7c8a  # 14:42  G     10     0   10  23  Merge tag 'fbdev-v4.17' of git://github.com/bzolnier/linux
git bisect  bad ce2e5a7613c64ac919d403fd957a472a0f12360e  # 15:03  B      0     4   41  22  rtc: ab-b5ze-s3: stop validating rtc_time in .read_time
git bisect good 11ad0b613d35f74dd8453d09b71dc2f0af7cf3e0  # 15:19  G     11     0   11  33  rtc: sirfsoc: remove useless sirfsoc_rtc_ioctl
git bisect  bad 68981fd1515de16f8effdd39e81f9a6084a895f7  # 15:39  B      0     6   20   0  rtc: tx4939: switch to rtc_register_device
git bisect  bad bcdd559268039d8340d38fa58668393596e29fdc  # 15:58  B      0     8   22   0  rtc: rp5c01: fix possible race condition
git bisect good 53d29e0a3afe0567db9e4360e8523b092eb2d4e4  # 16:17  G     11     0   11  11  rtc: cmos: fix possible race condition
git bisect  bad 1358e7b2b3312372ba231f6c94902a8dbfc7d2db  # 16:30  B      0     4   31  13  rtc: ds1742: switch to rtc_register_device
git bisect  bad 8b5b7958fd1cac54bdca62ec5552c6be0b38def4  # 16:50  B      0     6   20   0  rtc: cmos: use generic nvmem
# first bad commit: [8b5b7958fd1cac54bdca62ec5552c6be0b38def4] rtc: cmos: use generic nvmem
git bisect good 53d29e0a3afe0567db9e4360e8523b092eb2d4e4  # 16:59  G     32     0   32  54  rtc: cmos: fix possible race condition
# extra tests with debug options
git bisect  bad 8b5b7958fd1cac54bdca62ec5552c6be0b38def4  # 17:17  B      0     1   15   0  rtc: cmos: use generic nvmem
# extra tests on HEAD of linux-review/Petr-Sedl-k/Staging-vt6655-Fix-camel-case-of-variable/20181230-101524
git bisect  bad 1eb972809c37b7c05fa6bf4d054886f0e7730971  # 17:23  B      0    13   30   0  Staging: vt6655: Fix camel case of variable
# extra tests on tree/branch linus/master
git bisect  bad 195303136f192d37b89e20a8d1d2670d0d825266  # 17:23  B      0    12   41   2  Merge tag 'kconfig-v4.21-2' of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild
# extra tests on tree/branch linux-next/master
git bisect  bad 6a1d293238c1774cef23c25b5188b0c134c29a34  # 17:44  B      0     1   23   8  Add linux-next specific files for 20181224

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/lkp                          Intel Corporation

--gDGSpKKIBgtShtf+
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-yocto-vm-yocto-304:20181230164934:i386-randconfig-i2-201852:4.16.0-rc1-00037-g8b5b795:1.gz"
Content-Transfer-Encoding: base64

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

--gDGSpKKIBgtShtf+
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-openwrt-vm-openwrt-401:20181230163902:i386-randconfig-i2-201852:4.16.0-rc1-00036-g53d29e0:1.gz"
Content-Transfer-Encoding: base64

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

--gDGSpKKIBgtShtf+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-4.16.0-rc1-00037-g8b5b795"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 4.16.0-rc1 Kernel Configuration
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
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=2
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
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
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
CONFIG_KERNEL_XZ=y
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
# CONFIG_SYSVIPC is not set
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_CROSS_MEMORY_ATTACH is not set
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
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
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
CONFIG_IRQ_TIME_ACCOUNTING=y
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set

#
# RCU Subsystem
#
CONFIG_PREEMPT_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=32
CONFIG_RCU_FANOUT_LEAF=16
# CONFIG_RCU_BOOST is not set
# CONFIG_RCU_NOCB_CPU is not set
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CGROUPS=y
# CONFIG_MEMCG is not set
# CONFIG_CGROUP_SCHED is not set
# CONFIG_CGROUP_PIDS is not set
# CONFIG_CGROUP_RDMA is not set
# CONFIG_CGROUP_FREEZER is not set
# CONFIG_CGROUP_HUGETLB is not set
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
# CONFIG_CGROUP_BPF is not set
# CONFIG_CGROUP_DEBUG is not set
# CONFIG_SOCK_CGROUP_DATA is not set
# CONFIG_NAMESPACES is not set
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
# CONFIG_RD_BZIP2 is not set
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
CONFIG_SYSFS_SYSCALL=y
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
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
CONFIG_MEMBARRIER=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
# CONFIG_KALLSYMS_ABSOLUTE_PERCPU is not set
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
# CONFIG_USERFAULTFD is not set
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_EMBEDDED=y
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
CONFIG_SLAB=y
# CONFIG_SLUB is not set
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SYSTEM_DATA_VERIFICATION is not set
# CONFIG_PROFILING is not set
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
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
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_GCC_PLUGINS=y
# CONFIG_GCC_PLUGINS is not set
CONFIG_HAVE_CC_STACKPROTECTOR=y
# CONFIG_CC_STACKPROTECTOR_NONE is not set
# CONFIG_CC_STACKPROTECTOR_REGULAR is not set
# CONFIG_CC_STACKPROTECTOR_STRONG is not set
CONFIG_CC_STACKPROTECTOR_AUTO=y
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
# CONFIG_BLOCK is not set
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
CONFIG_X86_FAST_FEATURE_TESTS=y
# CONFIG_GOLDFISH is not set
# CONFIG_RETPOLINE is not set
# CONFIG_X86_EXTENDED_PLATFORM is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_32_IRIS=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
CONFIG_PARAVIRT_DEBUG=y
CONFIG_KVM_GUEST=y
# CONFIG_KVM_DEBUG_FS is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
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
# CONFIG_CPU_SUP_INTEL is not set
CONFIG_CPU_SUP_CYRIX_32=y
CONFIG_CPU_SUP_AMD=y
# CONFIG_CPU_SUP_CENTAUR is not set
# CONFIG_CPU_SUP_TRANSMETA_32 is not set
CONFIG_CPU_SUP_UMC_32=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_NR_CPUS=1
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y
# CONFIG_X86_UP_APIC is not set
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_ANCIENT_MCE=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_AMD_POWER=y
CONFIG_X86_LEGACY_VM86=y
CONFIG_VM86=y
CONFIG_TOSHIBA=y
# CONFIG_I8K is not set
CONFIG_X86_REBOOTFIXUPS=y
CONFIG_MICROCODE=y
# CONFIG_MICROCODE_INTEL is not set
# CONFIG_MICROCODE_AMD is not set
CONFIG_MICROCODE_OLD_INTERFACE=y
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
# CONFIG_VMSPLIT_3G is not set
# CONFIG_VMSPLIT_3G_OPT is not set
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_2G_OPT is not set
CONFIG_VMSPLIT_1G=y
CONFIG_PAGE_OFFSET=0x40000000
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
# CONFIG_MEMORY_HOTPLUG is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
# CONFIG_COMPACTION is not set
CONFIG_MIGRATION=y
# CONFIG_PHYS_ADDR_T_64BIT is not set
CONFIG_VIRT_TO_BUS=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
# CONFIG_TRANSPARENT_HUGEPAGE is not set
# CONFIG_ARCH_WANTS_THP_SWAP is not set
CONFIG_NEED_PER_CPU_KM=y
# CONFIG_CLEANCACHE is not set
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
CONFIG_CMA_DEBUGFS=y
CONFIG_CMA_AREAS=7
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
CONFIG_Z3FOLD=y
CONFIG_ZSMALLOC=y
# CONFIG_PGTABLE_MAPPING is not set
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_FRAME_VECTOR=y
# CONFIG_PERCPU_STATS is not set
CONFIG_GUP_BENCHMARK=y
# CONFIG_HIGHPTE is not set
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
# CONFIG_MTRR_SANITIZER is not set
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
# CONFIG_EFI is not set
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_COMPAT_VDSO=y
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y

#
# Power management and ACPI options
#
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_SUSPEND_SKIP_SYNC=y
CONFIG_PM_SLEEP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
CONFIG_PM_TEST_SUSPEND=y
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
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
# CONFIG_ACPI_VIDEO is not set
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_IPMI is not set
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
# CONFIG_ACPI_CONTAINER is not set
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
# CONFIG_APM_DO_ENABLE is not set
# CONFIG_APM_CPU_IDLE is not set
CONFIG_APM_DISPLAY_BLANK=y
CONFIG_APM_ALLOW_INTS=y

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
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCI_MSI is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_STUB is not set
CONFIG_PCI_LOCKLESS_CONFIG=y
# CONFIG_PCI_IOV is not set
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
# CONFIG_HOTPLUG_PCI is not set

#
# Cadence PCIe controllers support
#
# CONFIG_PCIE_CADENCE_HOST is not set
# CONFIG_PCIE_CADENCE_EP is not set

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
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_SCx200 is not set
CONFIG_OLPC=y
# CONFIG_OLPC_XO15_SCI is not set
CONFIG_ALIX=y
CONFIG_NET5501=y
CONFIG_GEOS=y
CONFIG_AMD_NB=y
CONFIG_PCCARD=y
# CONFIG_PCMCIA is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
# CONFIG_YENTA is not set
CONFIG_PCMCIA_PROBE=y
# CONFIG_RAPIDIO is not set
CONFIG_X86_SYSFB=y

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_HAVE_AOUT=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_MISC=y
# CONFIG_COREDUMP is not set
CONFIG_COMPAT_32=y
CONFIG_HAVE_ATOMIC_IOMAP=y
CONFIG_NET=y

#
# Networking options
#
# CONFIG_PACKET is not set
CONFIG_UNIX=y
CONFIG_UNIX_DIAG=y
# CONFIG_TLS is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_IPCOMP=y
# CONFIG_NET_KEY is not set
CONFIG_SMC=y
# CONFIG_SMC_DIAG is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=y
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=y
CONFIG_NET_UDP_TUNNEL=y
CONFIG_NET_FOU=y
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=y
CONFIG_INET_ESP=y
CONFIG_INET_ESP_OFFLOAD=y
CONFIG_INET_IPCOMP=y
CONFIG_INET_XFRM_TUNNEL=y
CONFIG_INET_TUNNEL=y
# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
CONFIG_INET_XFRM_MODE_TUNNEL=y
CONFIG_INET_XFRM_MODE_BEET=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
CONFIG_INET_UDP_DIAG=y
CONFIG_INET_RAW_DIAG=y
# CONFIG_INET_DIAG_DESTROY is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
# CONFIG_IPV6 is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
# CONFIG_NETFILTER is not set
CONFIG_IP_DCCP=y
CONFIG_INET_DCCP_DIAG=y

#
# DCCP CCIDs Configuration
#
CONFIG_IP_DCCP_CCID2_DEBUG=y
# CONFIG_IP_DCCP_CCID3 is not set

#
# DCCP Kernel Hacking
#
CONFIG_IP_DCCP_DEBUG=y
CONFIG_IP_SCTP=y
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=y
# CONFIG_RDS is not set
CONFIG_TIPC=y
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_ATM=y
CONFIG_ATM_CLIP=y
# CONFIG_ATM_CLIP_NO_ICMP is not set
# CONFIG_ATM_LANE is not set
CONFIG_ATM_BR2684=y
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=y
CONFIG_L2TP_DEBUGFS=y
# CONFIG_L2TP_V3 is not set
CONFIG_MRP=y
# CONFIG_BRIDGE is not set
CONFIG_HAVE_NET_DSA=y
CONFIG_NET_DSA=y
CONFIG_NET_DSA_LEGACY=y
CONFIG_NET_DSA_TAG_BRCM=y
CONFIG_NET_DSA_TAG_BRCM_PREPEND=y
CONFIG_NET_DSA_TAG_LAN9303=y
CONFIG_NET_DSA_TAG_TRAILER=y
CONFIG_VLAN_8021Q=y
# CONFIG_VLAN_8021Q_GVRP is not set
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=y
CONFIG_LLC2=y
# CONFIG_ATALK is not set
CONFIG_X25=y
CONFIG_LAPB=y
CONFIG_PHONET=y
CONFIG_IEEE802154=y
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=y
# CONFIG_MAC802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=y
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
CONFIG_VSOCKETS=y
# CONFIG_VSOCKETS_DIAG is not set
CONFIG_VIRTIO_VSOCKETS=y
CONFIG_VIRTIO_VSOCKETS_COMMON=y
# CONFIG_NETLINK_DIAG is not set
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
# CONFIG_MPLS_ROUTING is not set
CONFIG_NET_NSH=y
CONFIG_HSR=y
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_NET_NCSI is not set
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
# CONFIG_BPF_STREAM_PARSER is not set

#
# Network testing
#
CONFIG_NET_PKTGEN=y
CONFIG_HAMRADIO=y

#
# Packet Radio protocols
#
CONFIG_AX25=y
# CONFIG_AX25_DAMA_SLAVE is not set
CONFIG_NETROM=y
CONFIG_ROSE=y

#
# AX.25 network device drivers
#
CONFIG_MKISS=y
# CONFIG_6PACK is not set
CONFIG_BPQETHER=y
CONFIG_DMASCC=y
CONFIG_SCC=y
# CONFIG_SCC_DELAY is not set
CONFIG_SCC_TRXECHO=y
CONFIG_BAYCOM_SER_FDX=y
CONFIG_BAYCOM_SER_HDX=y
# CONFIG_YAM is not set
# CONFIG_CAN is not set
CONFIG_BT=y
CONFIG_BT_BREDR=y
CONFIG_BT_RFCOMM=y
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=y
# CONFIG_BT_BNEP_MC_FILTER is not set
CONFIG_BT_BNEP_PROTO_FILTER=y
# CONFIG_BT_HIDP is not set
# CONFIG_BT_HS is not set
CONFIG_BT_LE=y
# CONFIG_BT_LEDS is not set
# CONFIG_BT_SELFTEST is not set
CONFIG_BT_DEBUGFS=y

#
# Bluetooth device drivers
#
CONFIG_BT_INTEL=y
CONFIG_BT_BCM=y
CONFIG_BT_HCIBTUSB=y
CONFIG_BT_HCIBTUSB_AUTOSUSPEND=y
CONFIG_BT_HCIBTUSB_BCM=y
# CONFIG_BT_HCIBTUSB_RTL is not set
# CONFIG_BT_HCIBTSDIO is not set
CONFIG_BT_HCIUART=y
CONFIG_BT_HCIUART_SERDEV=y
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_NOKIA=y
CONFIG_BT_HCIUART_BCSP=y
# CONFIG_BT_HCIUART_ATH3K is not set
# CONFIG_BT_HCIUART_LL is not set
# CONFIG_BT_HCIUART_3WIRE is not set
# CONFIG_BT_HCIUART_INTEL is not set
# CONFIG_BT_HCIUART_QCA is not set
CONFIG_BT_HCIUART_AG6XX=y
# CONFIG_BT_HCIUART_MRVL is not set
# CONFIG_BT_HCIBCM203X is not set
# CONFIG_BT_HCIBPA10X is not set
CONFIG_BT_HCIBFUSB=y
CONFIG_BT_HCIVHCI=y
CONFIG_BT_MRVL=y
# CONFIG_BT_MRVL_SDIO is not set
# CONFIG_BT_ATH3K is not set
# CONFIG_BT_WILINK is not set
# CONFIG_AF_RXRPC is not set
CONFIG_AF_KCM=y
CONFIG_STREAM_PARSER=y
# CONFIG_WIRELESS is not set
CONFIG_WIMAX=y
CONFIG_WIMAX_DEBUG_LEVEL=8
CONFIG_RFKILL=y
CONFIG_RFKILL_LEDS=y
# CONFIG_RFKILL_INPUT is not set
CONFIG_RFKILL_GPIO=y
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_RDMA is not set
# CONFIG_NET_9P_DEBUG is not set
CONFIG_CAIF=y
# CONFIG_CAIF_DEBUG is not set
# CONFIG_CAIF_NETDEV is not set
CONFIG_CAIF_USB=y
CONFIG_CEPH_LIB=y
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
CONFIG_NFC=y
CONFIG_NFC_DIGITAL=y
# CONFIG_NFC_NCI is not set
CONFIG_NFC_HCI=y
CONFIG_NFC_SHDLC=y

#
# Near Field Communication (NFC) devices
#
CONFIG_NFC_SIM=y
CONFIG_NFC_PORT100=y
# CONFIG_NFC_PN544_I2C is not set
CONFIG_NFC_PN533=y
CONFIG_NFC_PN533_USB=y
# CONFIG_NFC_PN533_I2C is not set
# CONFIG_NFC_MICROREAD_I2C is not set
CONFIG_NFC_ST21NFCA=y
CONFIG_NFC_ST21NFCA_I2C=y
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_DEVLINK=y
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
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_ALLOW_DEV_COREDUMP is not set
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_DEVRES=y
CONFIG_DEBUG_TEST_DRIVER_REMOVE=y
# CONFIG_SYS_HYPERVISOR is not set
# CONFIG_GENERIC_CPU_DEVICES is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y
# CONFIG_DMA_CMA is not set

#
# Bus devices
#
CONFIG_SIMPLE_PM_BUS=y
# CONFIG_CONNECTOR is not set
# CONFIG_MTD is not set
CONFIG_DTC=y
CONFIG_OF=y
CONFIG_OF_UNITTEST=y
CONFIG_OF_FLATTREE=y
CONFIG_OF_EARLY_FLATTREE=y
CONFIG_OF_PROMTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_NET=y
CONFIG_OF_MDIO=y
CONFIG_OF_RESOLVE=y
# CONFIG_OF_OVERLAY is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
# CONFIG_PARPORT is not set
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
# CONFIG_ISAPNP is not set
# CONFIG_PNPBIOS is not set
CONFIG_PNPACPI=y

#
# NVME Support
#

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
CONFIG_AD525X_DPOT=y
CONFIG_AD525X_DPOT_I2C=y
CONFIG_DUMMY_IRQ=y
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_SGI_IOC4 is not set
# CONFIG_TIFM_CORE is not set
CONFIG_ICS932S401=y
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_HP_ILO is not set
CONFIG_APDS9802ALS=y
# CONFIG_ISL29003 is not set
# CONFIG_ISL29020 is not set
# CONFIG_SENSORS_TSL2550 is not set
CONFIG_SENSORS_BH1770=y
CONFIG_SENSORS_APDS990X=y
CONFIG_HMC6352=y
# CONFIG_DS1682 is not set
# CONFIG_PCH_PHUB is not set
CONFIG_USB_SWITCH_FSA9480=y
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_MISC_RTSX=y
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
CONFIG_EEPROM_LEGACY=y
# CONFIG_EEPROM_MAX6875 is not set
CONFIG_EEPROM_93CX6=y
CONFIG_EEPROM_IDT_89HPESX=y
# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
CONFIG_TI_ST=y
CONFIG_SENSORS_LIS3_I2C=y
CONFIG_ALTERA_STAPL=y
# CONFIG_INTEL_MEI is not set
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
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
# CONFIG_CXL_BASE is not set
# CONFIG_CXL_AFU_DRIVER_OPS is not set
# CONFIG_CXL_LIB is not set
# CONFIG_OCXL_BASE is not set
# CONFIG_MISC_RTSX_PCI is not set
CONFIG_MISC_RTSX_USB=y
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
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
CONFIG_BONDING=y
CONFIG_DUMMY=y
CONFIG_EQUALIZER=y
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
CONFIG_VXLAN=y
CONFIG_GENEVE=y
CONFIG_GTP=y
CONFIG_MACSEC=y
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
CONFIG_TUN=y
CONFIG_TUN_VNET_CROSS_LE=y
CONFIG_VETH=y
CONFIG_VIRTIO_NET=y
# CONFIG_NLMON is not set
# CONFIG_VSOCKMON is not set
CONFIG_ARCNET=y
CONFIG_ARCNET_1201=y
CONFIG_ARCNET_1051=y
CONFIG_ARCNET_RAW=y
# CONFIG_ARCNET_CAP is not set
# CONFIG_ARCNET_COM90xx is not set
CONFIG_ARCNET_COM90xxIO=y
# CONFIG_ARCNET_RIM_I is not set
# CONFIG_ARCNET_COM20020 is not set
# CONFIG_ATM_DRIVERS is not set

#
# CAIF transport drivers
#
CONFIG_CAIF_TTY=y
CONFIG_CAIF_SPI_SLAVE=y
# CONFIG_CAIF_SPI_SYNC is not set
CONFIG_CAIF_HSI=y
# CONFIG_CAIF_VIRTIO is not set

#
# Distributed Switch Architecture drivers
#
CONFIG_B53=y
CONFIG_B53_MDIO_DRIVER=y
CONFIG_B53_MMAP_DRIVER=y
CONFIG_B53_SRAB_DRIVER=y
CONFIG_NET_DSA_BCM_SF2=y
CONFIG_NET_DSA_LOOP=y
# CONFIG_NET_DSA_MT7530 is not set
CONFIG_NET_DSA_MV88E6060=y
# CONFIG_MICROCHIP_KSZ is not set
# CONFIG_NET_DSA_MV88E6XXX is not set
# CONFIG_NET_DSA_QCA8K is not set
CONFIG_NET_DSA_SMSC_LAN9303=y
CONFIG_NET_DSA_SMSC_LAN9303_I2C=y
CONFIG_NET_DSA_SMSC_LAN9303_MDIO=y
CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
# CONFIG_NET_VENDOR_ALACRITECH is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
CONFIG_ALTERA_TSE=y
# CONFIG_NET_VENDOR_AMAZON is not set
# CONFIG_NET_VENDOR_AMD is not set
# CONFIG_NET_VENDOR_AQUANTIA is not set
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
CONFIG_MACB=y
CONFIG_MACB_USE_HWSTAMP=y
# CONFIG_MACB_PCI is not set
# CONFIG_NET_VENDOR_BROADCOM is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
# CONFIG_NET_VENDOR_CAVIUM is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CIRRUS=y
# CONFIG_CS89x0 is not set
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
# CONFIG_NET_VENDOR_EZCHIP is not set
CONFIG_NET_VENDOR_EXAR=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
# CONFIG_NET_VENDOR_HP is not set
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
CONFIG_MVMDIO=y
# CONFIG_MVNETA_BM is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_NET_VENDOR_MELLANOX is not set
# CONFIG_NET_VENDOR_MICREL is not set
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NET_VENDOR_8390=y
CONFIG_NE2000=y
# CONFIG_NE2K_PCI is not set
CONFIG_ULTRA=y
CONFIG_WD80x3=y
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_PCH_GBE is not set
CONFIG_ETHOC=y
CONFIG_NET_PACKET_ENGINE=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_QLGE is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
# CONFIG_NET_VENDOR_QUALCOMM is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_R8169 is not set
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
# CONFIG_NET_VENDOR_ROCKER is not set
CONFIG_NET_VENDOR_SAMSUNG=y
CONFIG_SXGBE_ETH=y
# CONFIG_NET_VENDOR_SEEQ is not set
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
# CONFIG_NET_VENDOR_SOLARFLARE is not set
# CONFIG_NET_VENDOR_SMSC is not set
# CONFIG_NET_VENDOR_SOCIONEXT is not set
CONFIG_NET_VENDOR_STMICRO=y
CONFIG_STMMAC_ETH=y
CONFIG_STMMAC_PLATFORM=y
# CONFIG_DWMAC_DWC_QOS_ETH is not set
# CONFIG_DWMAC_GENERIC is not set
# CONFIG_STMMAC_PCI is not set
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
# CONFIG_NET_VENDOR_VIA is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
# CONFIG_NET_VENDOR_SYNOPSYS is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_MDIO_BCM_UNIMAC=y
# CONFIG_MDIO_BITBANG is not set
CONFIG_MDIO_BUS_MUX=y
CONFIG_MDIO_BUS_MUX_GPIO=y
# CONFIG_MDIO_BUS_MUX_MMIOREG is not set
CONFIG_MDIO_HISI_FEMAC=y
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
CONFIG_LED_TRIGGER_PHY=y

#
# MII PHY device drivers
#
CONFIG_AMD_PHY=y
CONFIG_AQUANTIA_PHY=y
CONFIG_AT803X_PHY=y
CONFIG_BCM7XXX_PHY=y
# CONFIG_BCM87XX_PHY is not set
CONFIG_BCM_NET_PHYLIB=y
# CONFIG_BROADCOM_PHY is not set
# CONFIG_CICADA_PHY is not set
CONFIG_CORTINA_PHY=y
CONFIG_DAVICOM_PHY=y
CONFIG_DP83822_PHY=y
CONFIG_DP83848_PHY=y
CONFIG_DP83867_PHY=y
CONFIG_FIXED_PHY=y
CONFIG_ICPLUS_PHY=y
CONFIG_INTEL_XWAY_PHY=y
# CONFIG_LSI_ET1011C_PHY is not set
CONFIG_LXT_PHY=y
CONFIG_MARVELL_PHY=y
CONFIG_MARVELL_10G_PHY=y
CONFIG_MICREL_PHY=y
CONFIG_MICROCHIP_PHY=y
# CONFIG_MICROSEMI_PHY is not set
CONFIG_NATIONAL_PHY=y
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=y
CONFIG_RENESAS_PHY=y
CONFIG_ROCKCHIP_PHY=y
CONFIG_SMSC_PHY=y
CONFIG_STE10XP=y
# CONFIG_TERANETICS_PHY is not set
CONFIG_VITESSE_PHY=y
CONFIG_XILINX_GMII2RGMII=y
CONFIG_PPP=y
# CONFIG_PPP_BSDCOMP is not set
# CONFIG_PPP_DEFLATE is not set
CONFIG_PPP_FILTER=y
CONFIG_PPP_MPPE=y
CONFIG_PPP_MULTILINK=y
# CONFIG_PPPOATM is not set
CONFIG_PPPOE=y
CONFIG_PPPOL2TP=y
CONFIG_PPP_ASYNC=y
CONFIG_PPP_SYNC_TTY=y
CONFIG_SLIP=y
CONFIG_SLHC=y
# CONFIG_SLIP_COMPRESSED is not set
# CONFIG_SLIP_SMART is not set
# CONFIG_SLIP_MODE_SLIP6 is not set
# CONFIG_USB_NET_DRIVERS is not set
# CONFIG_WLAN is not set

#
# WiMAX Wireless Broadband devices
#
CONFIG_WIMAX_I2400M=y
CONFIG_WIMAX_I2400M_USB=y
CONFIG_WIMAX_I2400M_DEBUG_LEVEL=8
CONFIG_WAN=y
# CONFIG_LANMEDIA is not set
CONFIG_HDLC=y
CONFIG_HDLC_RAW=y
CONFIG_HDLC_RAW_ETH=y
# CONFIG_HDLC_CISCO is not set
CONFIG_HDLC_FR=y
CONFIG_HDLC_PPP=y
CONFIG_HDLC_X25=y
# CONFIG_PCI200SYN is not set
# CONFIG_WANXL is not set
# CONFIG_PC300TOO is not set
CONFIG_N2=y
CONFIG_C101=y
# CONFIG_FARSYNC is not set
# CONFIG_DLCI is not set
# CONFIG_LAPBETHER is not set
CONFIG_X25_ASY=y
# CONFIG_SBNI is not set
CONFIG_IEEE802154_DRIVERS=y
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
CONFIG_NETDEVSIM=y
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_LEDS is not set
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=y
# CONFIG_INPUT_SPARSEKMAP is not set
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set
CONFIG_INPUT_EVBUG=y

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
# CONFIG_KEYBOARD_ADP5520 is not set
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_STMPE is not set
# CONFIG_KEYBOARD_OMAP4 is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CAP11XX is not set
# CONFIG_KEYBOARD_BCM is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
CONFIG_INPUT_TABLET=y
CONFIG_TABLET_USB_ACECAD=y
CONFIG_TABLET_USB_AIPTEK=y
# CONFIG_TABLET_USB_GTCO is not set
# CONFIG_TABLET_USB_HANWANG is not set
CONFIG_TABLET_USB_KBTAB=y
# CONFIG_TABLET_USB_PEGASUS is not set
CONFIG_TABLET_SERIAL_WACOM4=y
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
CONFIG_TOUCHSCREEN_AD7879=y
CONFIG_TOUCHSCREEN_AD7879_I2C=y
# CONFIG_TOUCHSCREEN_AR1021_I2C is not set
CONFIG_TOUCHSCREEN_ATMEL_MXT=y
CONFIG_TOUCHSCREEN_ATMEL_MXT_T37=y
CONFIG_TOUCHSCREEN_AUO_PIXCIR=y
CONFIG_TOUCHSCREEN_BU21013=y
CONFIG_TOUCHSCREEN_CHIPONE_ICN8318=y
CONFIG_TOUCHSCREEN_CY8CTMG110=y
CONFIG_TOUCHSCREEN_CYTTSP_CORE=y
CONFIG_TOUCHSCREEN_CYTTSP_I2C=y
# CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
# CONFIG_TOUCHSCREEN_DYNAPRO is not set
CONFIG_TOUCHSCREEN_HAMPSHIRE=y
CONFIG_TOUCHSCREEN_EETI=y
# CONFIG_TOUCHSCREEN_EGALAX is not set
# CONFIG_TOUCHSCREEN_EGALAX_SERIAL is not set
CONFIG_TOUCHSCREEN_EXC3000=y
CONFIG_TOUCHSCREEN_FUJITSU=y
CONFIG_TOUCHSCREEN_GOODIX=y
# CONFIG_TOUCHSCREEN_HIDEEP is not set
CONFIG_TOUCHSCREEN_ILI210X=y
CONFIG_TOUCHSCREEN_S6SY761=y
CONFIG_TOUCHSCREEN_GUNZE=y
CONFIG_TOUCHSCREEN_EKTF2127=y
CONFIG_TOUCHSCREEN_ELAN=y
CONFIG_TOUCHSCREEN_ELO=y
CONFIG_TOUCHSCREEN_WACOM_W8001=y
# CONFIG_TOUCHSCREEN_WACOM_I2C is not set
CONFIG_TOUCHSCREEN_MAX11801=y
CONFIG_TOUCHSCREEN_MCS5000=y
CONFIG_TOUCHSCREEN_MMS114=y
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
# CONFIG_TOUCHSCREEN_MTOUCH is not set
CONFIG_TOUCHSCREEN_IMX6UL_TSC=y
# CONFIG_TOUCHSCREEN_INEXIO is not set
CONFIG_TOUCHSCREEN_MK712=y
CONFIG_TOUCHSCREEN_HTCPEN=y
CONFIG_TOUCHSCREEN_PENMOUNT=y
CONFIG_TOUCHSCREEN_EDT_FT5X06=y
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
# CONFIG_TOUCHSCREEN_TI_AM335X_TSC is not set
CONFIG_TOUCHSCREEN_PIXCIR=y
CONFIG_TOUCHSCREEN_WDT87XX_I2C=y
CONFIG_TOUCHSCREEN_WM831X=y
CONFIG_TOUCHSCREEN_USB_COMPOSITE=y
# CONFIG_TOUCHSCREEN_MC13783 is not set
CONFIG_TOUCHSCREEN_USB_EGALAX=y
# CONFIG_TOUCHSCREEN_USB_PANJIT is not set
# CONFIG_TOUCHSCREEN_USB_3M is not set
CONFIG_TOUCHSCREEN_USB_ITM=y
CONFIG_TOUCHSCREEN_USB_ETURBO=y
# CONFIG_TOUCHSCREEN_USB_GUNZE is not set
CONFIG_TOUCHSCREEN_USB_DMC_TSC10=y
# CONFIG_TOUCHSCREEN_USB_IRTOUCH is not set
# CONFIG_TOUCHSCREEN_USB_IDEALTEK is not set
CONFIG_TOUCHSCREEN_USB_GENERAL_TOUCH=y
# CONFIG_TOUCHSCREEN_USB_GOTOP is not set
# CONFIG_TOUCHSCREEN_USB_JASTEC is not set
CONFIG_TOUCHSCREEN_USB_ELO=y
# CONFIG_TOUCHSCREEN_USB_E2I is not set
CONFIG_TOUCHSCREEN_USB_ZYTRONIC=y
CONFIG_TOUCHSCREEN_USB_ETT_TC45USB=y
# CONFIG_TOUCHSCREEN_USB_NEXIO is not set
# CONFIG_TOUCHSCREEN_USB_EASYTOUCH is not set
CONFIG_TOUCHSCREEN_TOUCHIT213=y
# CONFIG_TOUCHSCREEN_TSC_SERIO is not set
CONFIG_TOUCHSCREEN_TSC200X_CORE=y
CONFIG_TOUCHSCREEN_TSC2004=y
CONFIG_TOUCHSCREEN_TSC2007=y
CONFIG_TOUCHSCREEN_TSC2007_IIO=y
CONFIG_TOUCHSCREEN_RM_TS=y
# CONFIG_TOUCHSCREEN_SILEAD is not set
CONFIG_TOUCHSCREEN_SIS_I2C=y
CONFIG_TOUCHSCREEN_ST1232=y
CONFIG_TOUCHSCREEN_STMFTS=y
# CONFIG_TOUCHSCREEN_STMPE is not set
CONFIG_TOUCHSCREEN_SUR40=y
CONFIG_TOUCHSCREEN_SX8654=y
# CONFIG_TOUCHSCREEN_TPS6507X is not set
CONFIG_TOUCHSCREEN_ZET6223=y
CONFIG_TOUCHSCREEN_ZFORCE=y
CONFIG_TOUCHSCREEN_COLIBRI_VF50=y
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_88PM80X_ONKEY=y
CONFIG_INPUT_AD714X=y
CONFIG_INPUT_AD714X_I2C=y
CONFIG_INPUT_ARIZONA_HAPTICS=y
# CONFIG_INPUT_ATMEL_CAPTOUCH is not set
CONFIG_INPUT_BMA150=y
# CONFIG_INPUT_E3X0_BUTTON is not set
# CONFIG_INPUT_PCSPKR is not set
CONFIG_INPUT_MAX8925_ONKEY=y
CONFIG_INPUT_MC13783_PWRBUTTON=y
# CONFIG_INPUT_MMA8450 is not set
CONFIG_INPUT_APANEL=y
# CONFIG_INPUT_GP2A is not set
CONFIG_INPUT_GPIO_BEEPER=y
CONFIG_INPUT_GPIO_DECODER=y
# CONFIG_INPUT_WISTRON_BTNS is not set
# CONFIG_INPUT_ATLAS_BTNS is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
CONFIG_INPUT_KEYSPAN_REMOTE=y
CONFIG_INPUT_KXTJ9=y
# CONFIG_INPUT_KXTJ9_POLLED_MODE is not set
# CONFIG_INPUT_POWERMATE is not set
CONFIG_INPUT_YEALINK=y
CONFIG_INPUT_CM109=y
CONFIG_INPUT_REGULATOR_HAPTIC=y
# CONFIG_INPUT_TPS65218_PWRBUTTON is not set
CONFIG_INPUT_AXP20X_PEK=y
CONFIG_INPUT_UINPUT=y
CONFIG_INPUT_PCF50633_PMU=y
CONFIG_INPUT_PCF8574=y
CONFIG_INPUT_RK805_PWRKEY=y
CONFIG_INPUT_GPIO_ROTARY_ENCODER=y
CONFIG_INPUT_DA9055_ONKEY=y
CONFIG_INPUT_DA9063_ONKEY=y
# CONFIG_INPUT_WM831X_ON is not set
# CONFIG_INPUT_ADXL34X is not set
CONFIG_INPUT_IMS_PCU=y
CONFIG_INPUT_CMA3000=y
CONFIG_INPUT_CMA3000_I2C=y
CONFIG_INPUT_IDEAPAD_SLIDEBAR=y
# CONFIG_INPUT_DRV260X_HAPTICS is not set
CONFIG_INPUT_DRV2665_HAPTICS=y
CONFIG_INPUT_DRV2667_HAPTICS=y
CONFIG_RMI4_CORE=y
CONFIG_RMI4_I2C=y
# CONFIG_RMI4_SMB is not set
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
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
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_SERIO_ALTERA_PS2 is not set
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=y
CONFIG_SERIO_APBPS2=y
CONFIG_SERIO_OLPC_APSP=y
CONFIG_SERIO_GPIO_PS2=y
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
CONFIG_CYCLADES=y
# CONFIG_CYZ_INTR is not set
# CONFIG_MOXA_INTELLIO is not set
CONFIG_MOXA_SMARTIO=y
# CONFIG_SYNCLINK is not set
# CONFIG_SYNCLINKMP is not set
# CONFIG_SYNCLINK_GT is not set
# CONFIG_NOZOMI is not set
# CONFIG_ISI is not set
CONFIG_N_HDLC=y
CONFIG_N_GSM=y
# CONFIG_TRACE_SINK is not set
# CONFIG_DEVMEM is not set
CONFIG_DEVKMEM=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
CONFIG_SERIAL_8250_FINTEK=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
# CONFIG_SERIAL_8250_MEN_MCB is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
# CONFIG_SERIAL_8250_FOURPORT is not set
CONFIG_SERIAL_8250_ACCENT=y
CONFIG_SERIAL_8250_ASPEED_VUART=y
# CONFIG_SERIAL_8250_BOCA is not set
# CONFIG_SERIAL_8250_EXAR_ST16C554 is not set
# CONFIG_SERIAL_8250_HUB6 is not set
# CONFIG_SERIAL_8250_SHARE_IRQ is not set
CONFIG_SERIAL_8250_DETECT_IRQ=y
CONFIG_SERIAL_8250_RSA=y
# CONFIG_SERIAL_8250_FSL is not set
# CONFIG_SERIAL_8250_DW is not set
CONFIG_SERIAL_8250_RT288X=y
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
CONFIG_SERIAL_TIMBERDALE=y
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_PCH_UART is not set
CONFIG_SERIAL_XILINX_PS_UART=y
CONFIG_SERIAL_XILINX_PS_UART_CONSOLE=y
CONFIG_SERIAL_ARC=y
CONFIG_SERIAL_ARC_CONSOLE=y
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
CONFIG_SERIAL_FSL_LPUART=y
# CONFIG_SERIAL_FSL_LPUART_CONSOLE is not set
CONFIG_SERIAL_CONEXANT_DIGICOLOR=y
# CONFIG_SERIAL_CONEXANT_DIGICOLOR_CONSOLE is not set
CONFIG_SERIAL_MEN_Z135=y
CONFIG_SERIAL_DEV_BUS=y
# CONFIG_SERIAL_DEV_CTRL_TTYPORT is not set
CONFIG_TTY_PRINTK=y
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
# CONFIG_HW_RANDOM is not set
CONFIG_NVRAM=y
CONFIG_DTLK=y
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set
CONFIG_MWAVE=y
CONFIG_PC8736x_GPIO=y
CONFIG_NSC_GPIO=y
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
CONFIG_TCG_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_I2C_ATMEL is not set
CONFIG_TCG_TIS_I2C_INFINEON=y
CONFIG_TCG_TIS_I2C_NUVOTON=y
CONFIG_TCG_NSC=y
CONFIG_TCG_ATMEL=y
# CONFIG_TCG_INFINEON is not set
# CONFIG_TCG_CRB is not set
CONFIG_TCG_VTPM_PROXY=y
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
CONFIG_TELCLOCK=y
# CONFIG_DEVPORT is not set
CONFIG_XILLYBUS=y
CONFIG_XILLYBUS_OF=y

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
CONFIG_I2C_ARB_GPIO_CHALLENGE=y
# CONFIG_I2C_MUX_GPIO is not set
CONFIG_I2C_MUX_GPMUX=y
CONFIG_I2C_MUX_LTC4306=y
CONFIG_I2C_MUX_PCA9541=y
CONFIG_I2C_MUX_PCA954x=y
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
# CONFIG_I2C_DESIGNWARE_PLATFORM is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EG20T is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_KEMPLD is not set
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_PCA_PLATFORM is not set
# CONFIG_I2C_PXA is not set
# CONFIG_I2C_PXA_PCI is not set
# CONFIG_I2C_RK3X is not set
CONFIG_I2C_SIMTEC=y
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
# CONFIG_I2C_DLN2 is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
CONFIG_I2C_TAOS_EVM=y
CONFIG_I2C_TINY_USB=y
# CONFIG_I2C_VIPERBOARD is not set

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_ELEKTOR is not set
CONFIG_I2C_PCA_ISA=y
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_SPI is not set
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
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
CONFIG_PTP_1588_CLOCK=y
CONFIG_DP83640_PHY=y
CONFIG_PTP_1588_CLOCK_PCH=y
# CONFIG_PTP_1588_CLOCK_KVM is not set
CONFIG_PINCTRL=y
CONFIG_GENERIC_PINCTRL_GROUPS=y
CONFIG_PINMUX=y
CONFIG_GENERIC_PINMUX_FUNCTIONS=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AS3722 is not set
CONFIG_PINCTRL_AXP209=y
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_MCP23S08 is not set
CONFIG_PINCTRL_SINGLE=y
CONFIG_PINCTRL_SX150X=y
CONFIG_PINCTRL_RK805=y
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
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
CONFIG_GPIO_74XX_MMIO=y
CONFIG_GPIO_ALTERA=y
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_DWAPB=y
# CONFIG_GPIO_EXAR is not set
CONFIG_GPIO_FTGPIO010=y
CONFIG_GPIO_GENERIC_PLATFORM=y
CONFIG_GPIO_GRGPIO=y
# CONFIG_GPIO_ICH is not set
# CONFIG_GPIO_LYNXPOINT is not set
CONFIG_GPIO_MB86S7X=y
# CONFIG_GPIO_MENZ127 is not set
CONFIG_GPIO_MOCKUP=y
CONFIG_GPIO_SYSCON=y
# CONFIG_GPIO_VX855 is not set
CONFIG_GPIO_XILINX=y

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_104_DIO_48E=y
CONFIG_GPIO_104_IDIO_16=y
CONFIG_GPIO_104_IDI_48=y
CONFIG_GPIO_F7188X=y
CONFIG_GPIO_GPIO_MM=y
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
CONFIG_GPIO_SCH311X=y
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=y
# CONFIG_GPIO_ADP5588_IRQ is not set
CONFIG_GPIO_ADNP=y
# CONFIG_GPIO_MAX7300 is not set
CONFIG_GPIO_MAX732X=y
# CONFIG_GPIO_MAX732X_IRQ is not set
# CONFIG_GPIO_PCA953X is not set
CONFIG_GPIO_PCF857X=y
CONFIG_GPIO_TPIC2810=y

#
# MFD GPIO expanders
#
CONFIG_GPIO_ADP5520=y
# CONFIG_GPIO_ARIZONA is not set
CONFIG_GPIO_BD9571MWV=y
# CONFIG_GPIO_DA9055 is not set
# CONFIG_GPIO_DLN2 is not set
CONFIG_GPIO_KEMPLD=y
# CONFIG_GPIO_LP3943 is not set
# CONFIG_GPIO_LP873X is not set
# CONFIG_GPIO_LP87565 is not set
# CONFIG_GPIO_RC5T583 is not set
# CONFIG_GPIO_STMPE is not set
# CONFIG_GPIO_TPS65086 is not set
# CONFIG_GPIO_TPS65218 is not set
CONFIG_GPIO_TPS65912=y
CONFIG_GPIO_WM831X=y

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# CONFIG_GPIO_SODAVILLE is not set

#
# USB GPIO expanders
#
CONFIG_GPIO_VIPERBOARD=y
# CONFIG_W1 is not set
CONFIG_POWER_AVS=y
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_AS3722 is not set
# CONFIG_POWER_RESET_GPIO is not set
CONFIG_POWER_RESET_GPIO_RESTART=y
# CONFIG_POWER_RESET_LTC2952 is not set
CONFIG_POWER_RESET_RESTART=y
CONFIG_POWER_RESET_SYSCON=y
# CONFIG_POWER_RESET_SYSCON_POWEROFF is not set
CONFIG_REBOOT_MODE=y
CONFIG_SYSCON_REBOOT_MODE=y
CONFIG_POWER_SUPPLY=y
CONFIG_POWER_SUPPLY_DEBUG=y
# CONFIG_PDA_POWER is not set
CONFIG_GENERIC_ADC_BATTERY=y
CONFIG_MAX8925_POWER=y
# CONFIG_WM831X_BACKUP is not set
CONFIG_WM831X_POWER=y
# CONFIG_TEST_POWER is not set
CONFIG_BATTERY_ACT8945A=y
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
CONFIG_BATTERY_DS2782=y
# CONFIG_BATTERY_LEGO_EV3 is not set
# CONFIG_BATTERY_OLPC is not set
CONFIG_BATTERY_SBS=y
CONFIG_CHARGER_SBS=y
CONFIG_MANAGER_SBS=y
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_CHARGER_DA9150 is not set
# CONFIG_BATTERY_DA9150 is not set
CONFIG_CHARGER_AXP20X=y
# CONFIG_BATTERY_AXP20X is not set
CONFIG_AXP20X_POWER=y
# CONFIG_AXP288_CHARGER is not set
CONFIG_AXP288_FUEL_GAUGE=y
CONFIG_BATTERY_MAX17040=y
CONFIG_BATTERY_MAX17042=y
CONFIG_CHARGER_PCF50633=y
# CONFIG_CHARGER_ISP1704 is not set
# CONFIG_CHARGER_MAX8903 is not set
CONFIG_CHARGER_LP8727=y
CONFIG_CHARGER_LP8788=y
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_MANAGER is not set
# CONFIG_CHARGER_LTC3651 is not set
CONFIG_CHARGER_DETECTOR_MAX14656=y
CONFIG_CHARGER_BQ2415X=y
CONFIG_CHARGER_BQ24190=y
CONFIG_CHARGER_BQ24257=y
CONFIG_CHARGER_BQ24735=y
CONFIG_CHARGER_BQ25890=y
CONFIG_CHARGER_SMB347=y
# CONFIG_CHARGER_TPS65090 is not set
CONFIG_CHARGER_TPS65217=y
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
CONFIG_BATTERY_RT5033=y
# CONFIG_CHARGER_RT9455 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
# CONFIG_SENSORS_ABITUGURU is not set
CONFIG_SENSORS_ABITUGURU3=y
CONFIG_SENSORS_AD7414=y
# CONFIG_SENSORS_AD7418 is not set
CONFIG_SENSORS_ADM1021=y
CONFIG_SENSORS_ADM1025=y
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
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
# CONFIG_SENSORS_FAM15H_POWER is not set
CONFIG_SENSORS_APPLESMC=y
CONFIG_SENSORS_ASB100=y
# CONFIG_SENSORS_ASPEED is not set
# CONFIG_SENSORS_ATXP1 is not set
# CONFIG_SENSORS_DS620 is not set
CONFIG_SENSORS_DS1621=y
CONFIG_SENSORS_DELL_SMM=y
CONFIG_SENSORS_DA9055=y
# CONFIG_SENSORS_I5K_AMB is not set
CONFIG_SENSORS_F71805F=y
CONFIG_SENSORS_F71882FG=y
CONFIG_SENSORS_F75375S=y
CONFIG_SENSORS_MC13783_ADC=y
# CONFIG_SENSORS_FSCHMD is not set
CONFIG_SENSORS_FTSTEUTATES=y
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_GL520SM is not set
CONFIG_SENSORS_G760A=y
CONFIG_SENSORS_G762=y
# CONFIG_SENSORS_GPIO_FAN is not set
# CONFIG_SENSORS_HIH6130 is not set
# CONFIG_SENSORS_IBMAEM is not set
CONFIG_SENSORS_IBMPEX=y
CONFIG_SENSORS_IIO_HWMON=y
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=y
# CONFIG_SENSORS_IT87 is not set
CONFIG_SENSORS_JC42=y
# CONFIG_SENSORS_POWR1220 is not set
# CONFIG_SENSORS_LINEAGE is not set
CONFIG_SENSORS_LTC2945=y
CONFIG_SENSORS_LTC2990=y
# CONFIG_SENSORS_LTC4151 is not set
CONFIG_SENSORS_LTC4215=y
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=y
CONFIG_SENSORS_LTC4260=y
CONFIG_SENSORS_LTC4261=y
# CONFIG_SENSORS_MAX16065 is not set
CONFIG_SENSORS_MAX1619=y
# CONFIG_SENSORS_MAX1668 is not set
CONFIG_SENSORS_MAX197=y
CONFIG_SENSORS_MAX6621=y
# CONFIG_SENSORS_MAX6639 is not set
# CONFIG_SENSORS_MAX6642 is not set
# CONFIG_SENSORS_MAX6650 is not set
# CONFIG_SENSORS_MAX6697 is not set
CONFIG_SENSORS_MAX31790=y
CONFIG_SENSORS_MCP3021=y
CONFIG_SENSORS_TC654=y
CONFIG_SENSORS_MENF21BMC_HWMON=y
# CONFIG_SENSORS_LM63 is not set
CONFIG_SENSORS_LM73=y
CONFIG_SENSORS_LM75=y
# CONFIG_SENSORS_LM77 is not set
CONFIG_SENSORS_LM78=y
# CONFIG_SENSORS_LM80 is not set
CONFIG_SENSORS_LM83=y
CONFIG_SENSORS_LM85=y
CONFIG_SENSORS_LM87=y
# CONFIG_SENSORS_LM90 is not set
CONFIG_SENSORS_LM92=y
CONFIG_SENSORS_LM93=y
CONFIG_SENSORS_LM95234=y
CONFIG_SENSORS_LM95241=y
CONFIG_SENSORS_LM95245=y
# CONFIG_SENSORS_PC87360 is not set
CONFIG_SENSORS_PC87427=y
# CONFIG_SENSORS_NTC_THERMISTOR is not set
CONFIG_SENSORS_NCT6683=y
CONFIG_SENSORS_NCT6775=y
CONFIG_SENSORS_NCT7802=y
CONFIG_SENSORS_NCT7904=y
# CONFIG_SENSORS_PCF8591 is not set
CONFIG_PMBUS=y
CONFIG_SENSORS_PMBUS=y
# CONFIG_SENSORS_ADM1275 is not set
CONFIG_SENSORS_IBM_CFFPS=y
CONFIG_SENSORS_IR35221=y
CONFIG_SENSORS_LM25066=y
CONFIG_SENSORS_LTC2978=y
# CONFIG_SENSORS_LTC2978_REGULATOR is not set
# CONFIG_SENSORS_LTC3815 is not set
# CONFIG_SENSORS_MAX16064 is not set
CONFIG_SENSORS_MAX20751=y
CONFIG_SENSORS_MAX31785=y
CONFIG_SENSORS_MAX34440=y
CONFIG_SENSORS_MAX8688=y
# CONFIG_SENSORS_TPS40422 is not set
CONFIG_SENSORS_TPS53679=y
# CONFIG_SENSORS_UCD9000 is not set
CONFIG_SENSORS_UCD9200=y
CONFIG_SENSORS_ZL6100=y
CONFIG_SENSORS_SHT15=y
# CONFIG_SENSORS_SHT21 is not set
# CONFIG_SENSORS_SHT3x is not set
CONFIG_SENSORS_SHTC1=y
# CONFIG_SENSORS_SIS5595 is not set
CONFIG_SENSORS_DME1737=y
# CONFIG_SENSORS_EMC1403 is not set
# CONFIG_SENSORS_EMC2103 is not set
# CONFIG_SENSORS_EMC6W201 is not set
CONFIG_SENSORS_SMSC47M1=y
CONFIG_SENSORS_SMSC47M192=y
CONFIG_SENSORS_SMSC47B397=y
CONFIG_SENSORS_SCH56XX_COMMON=y
CONFIG_SENSORS_SCH5627=y
CONFIG_SENSORS_SCH5636=y
CONFIG_SENSORS_STTS751=y
CONFIG_SENSORS_SMM665=y
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS1015=y
CONFIG_SENSORS_ADS7828=y
CONFIG_SENSORS_AMC6821=y
CONFIG_SENSORS_INA209=y
CONFIG_SENSORS_INA2XX=y
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=y
CONFIG_SENSORS_TMP102=y
# CONFIG_SENSORS_TMP103 is not set
CONFIG_SENSORS_TMP108=y
CONFIG_SENSORS_TMP401=y
CONFIG_SENSORS_TMP421=y
CONFIG_SENSORS_VIA_CPUTEMP=y
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_VT1211=y
# CONFIG_SENSORS_VT8231 is not set
CONFIG_SENSORS_W83773G=y
CONFIG_SENSORS_W83781D=y
# CONFIG_SENSORS_W83791D is not set
CONFIG_SENSORS_W83792D=y
CONFIG_SENSORS_W83793=y
CONFIG_SENSORS_W83795=y
CONFIG_SENSORS_W83795_FANCTRL=y
CONFIG_SENSORS_W83L785TS=y
CONFIG_SENSORS_W83L786NG=y
# CONFIG_SENSORS_W83627HF is not set
CONFIG_SENSORS_W83627EHF=y
CONFIG_SENSORS_WM831X=y

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
# CONFIG_THERMAL_HWMON is not set
# CONFIG_THERMAL_OF is not set
# CONFIG_THERMAL_WRITABLE_TRIPS is not set
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
CONFIG_THERMAL_EMULATION=y
CONFIG_DA9062_THERMAL=y
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# CONFIG_INTEL_PCH_THERMAL is not set
CONFIG_GENERIC_ADC_THERMAL=y
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
CONFIG_WATCHDOG_NOWAYOUT=y
# CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is not set
# CONFIG_WATCHDOG_SYSFS is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=y
CONFIG_DA9055_WATCHDOG=y
CONFIG_DA9062_WATCHDOG=y
CONFIG_GPIO_WATCHDOG=y
CONFIG_GPIO_WATCHDOG_ARCH_INITCALL=y
CONFIG_MENF21BMC_WATCHDOG=y
# CONFIG_WDAT_WDT is not set
# CONFIG_WM831X_WATCHDOG is not set
# CONFIG_XILINX_WATCHDOG is not set
CONFIG_ZIIRAVE_WATCHDOG=y
# CONFIG_CADENCE_WATCHDOG is not set
CONFIG_DW_WATCHDOG=y
# CONFIG_MAX63XX_WATCHDOG is not set
CONFIG_ACQUIRE_WDT=y
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
CONFIG_EBC_C384_WDT=y
CONFIG_F71808E_WDT=y
# CONFIG_SP5100_TCO is not set
# CONFIG_SBC_FITPC2_WATCHDOG is not set
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=y
CONFIG_IBMASR=y
CONFIG_WAFER_WDT=y
# CONFIG_I6300ESB_WDT is not set
# CONFIG_IE6XX_WDT is not set
# CONFIG_ITCO_WDT is not set
CONFIG_IT8712F_WDT=y
# CONFIG_IT87_WDT is not set
# CONFIG_HP_WATCHDOG is not set
# CONFIG_KEMPLD_WDT is not set
CONFIG_SC1200_WDT=y
# CONFIG_PC87413_WDT is not set
# CONFIG_NV_TCO is not set
CONFIG_60XX_WDT=y
CONFIG_SBC8360_WDT=y
# CONFIG_SBC7240_WDT is not set
CONFIG_CPU5_WDT=y
CONFIG_SMSC_SCH311X_WDT=y
CONFIG_SMSC37B787_WDT=y
# CONFIG_VIA_WDT is not set
CONFIG_W83627HF_WDT=y
# CONFIG_W83877F_WDT is not set
CONFIG_W83977F_WDT=y
CONFIG_MACHZ_WDT=y
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set

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
CONFIG_USBPCWATCHDOG=y

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
CONFIG_SSB_SDIOHOST_POSSIBLE=y
# CONFIG_SSB_SDIOHOST is not set
# CONFIG_SSB_SILENT is not set
# CONFIG_SSB_DEBUG is not set
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
# CONFIG_SSB_DRIVER_PCICORE is not set
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

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
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
# CONFIG_MFD_CROS_EC is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_I2C is not set
CONFIG_MFD_DA9055=y
CONFIG_MFD_DA9062=y
# CONFIG_MFD_DA9063 is not set
CONFIG_MFD_DA9150=y
CONFIG_MFD_DLN2=y
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_I2C=y
# CONFIG_MFD_HI6421_PMIC is not set
CONFIG_HTC_PASIC3=y
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_INTEL_SOC_PMIC is not set
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=y
CONFIG_MFD_88PM800=y
CONFIG_MFD_88PM805=y
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77620 is not set
CONFIG_MFD_MAX77686=y
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
CONFIG_MFD_MAX8907=y
CONFIG_MFD_MAX8925=y
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
CONFIG_MFD_MT6397=y
CONFIG_MFD_MENF21BMC=y
CONFIG_MFD_VIPERBOARD=y
# CONFIG_MFD_RETU is not set
CONFIG_MFD_PCF50633=y
CONFIG_PCF50633_ADC=y
CONFIG_PCF50633_GPIO=y
# CONFIG_MFD_RDC321X is not set
CONFIG_MFD_RT5033=y
CONFIG_MFD_RC5T583=y
CONFIG_MFD_RK808=y
# CONFIG_MFD_RN5T618 is not set
CONFIG_MFD_SEC_CORE=y
CONFIG_MFD_SI476X_CORE=y
CONFIG_MFD_SM501=y
# CONFIG_MFD_SM501_GPIO is not set
CONFIG_MFD_SKY81452=y
CONFIG_MFD_SMSC=y
# CONFIG_ABX500_CORE is not set
CONFIG_MFD_STMPE=y

#
# STMicroelectronics STMPE Interface Drivers
#
CONFIG_STMPE_I2C=y
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
CONFIG_MFD_LP3943=y
CONFIG_MFD_LP8788=y
CONFIG_MFD_TI_LMU=y
# CONFIG_MFD_PALMAS is not set
CONFIG_TPS6105X=y
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
CONFIG_MFD_TPS65086=y
CONFIG_MFD_TPS65090=y
CONFIG_MFD_TPS65217=y
# CONFIG_MFD_TPS68470 is not set
CONFIG_MFD_TI_LP873X=y
CONFIG_MFD_TI_LP87565=y
CONFIG_MFD_TPS65218=y
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
CONFIG_MFD_WL1273_CORE=y
CONFIG_MFD_LM3533=y
# CONFIG_MFD_TIMBERDALE is not set
# CONFIG_MFD_TC3589X is not set
# CONFIG_MFD_TMIO is not set
# CONFIG_MFD_VX855 is not set
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
# CONFIG_MFD_CS47L24 is not set
CONFIG_MFD_WM5102=y
CONFIG_MFD_WM5110=y
# CONFIG_MFD_WM8997 is not set
# CONFIG_MFD_WM8998 is not set
# CONFIG_MFD_WM8400 is not set
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_RAVE_SP_CORE is not set
CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
CONFIG_REGULATOR_88PM800=y
CONFIG_REGULATOR_ACT8865=y
CONFIG_REGULATOR_ACT8945A=y
CONFIG_REGULATOR_AD5398=y
# CONFIG_REGULATOR_ANATOP is not set
CONFIG_REGULATOR_ARIZONA_LDO1=y
CONFIG_REGULATOR_ARIZONA_MICSUPP=y
CONFIG_REGULATOR_AS3711=y
CONFIG_REGULATOR_AS3722=y
CONFIG_REGULATOR_AXP20X=y
CONFIG_REGULATOR_BCM590XX=y
CONFIG_REGULATOR_BD9571MWV=y
# CONFIG_REGULATOR_DA9055 is not set
# CONFIG_REGULATOR_DA9062 is not set
CONFIG_REGULATOR_DA9210=y
# CONFIG_REGULATOR_DA9211 is not set
CONFIG_REGULATOR_FAN53555=y
# CONFIG_REGULATOR_GPIO is not set
CONFIG_REGULATOR_ISL9305=y
CONFIG_REGULATOR_ISL6271A=y
CONFIG_REGULATOR_LM363X=y
CONFIG_REGULATOR_LP3971=y
# CONFIG_REGULATOR_LP3972 is not set
# CONFIG_REGULATOR_LP872X is not set
CONFIG_REGULATOR_LP873X=y
CONFIG_REGULATOR_LP8755=y
CONFIG_REGULATOR_LP87565=y
CONFIG_REGULATOR_LP8788=y
# CONFIG_REGULATOR_LTC3589 is not set
CONFIG_REGULATOR_LTC3676=y
CONFIG_REGULATOR_MAX1586=y
CONFIG_REGULATOR_MAX8649=y
# CONFIG_REGULATOR_MAX8660 is not set
CONFIG_REGULATOR_MAX8907=y
CONFIG_REGULATOR_MAX8925=y
# CONFIG_REGULATOR_MAX8952 is not set
CONFIG_REGULATOR_MAX77686=y
CONFIG_REGULATOR_MAX77802=y
CONFIG_REGULATOR_MC13XXX_CORE=y
CONFIG_REGULATOR_MC13783=y
CONFIG_REGULATOR_MC13892=y
# CONFIG_REGULATOR_MT6311 is not set
# CONFIG_REGULATOR_MT6323 is not set
CONFIG_REGULATOR_MT6397=y
CONFIG_REGULATOR_PCF50633=y
# CONFIG_REGULATOR_PFUZE100 is not set
CONFIG_REGULATOR_PV88060=y
CONFIG_REGULATOR_PV88080=y
# CONFIG_REGULATOR_PV88090 is not set
CONFIG_REGULATOR_RC5T583=y
# CONFIG_REGULATOR_RK808 is not set
CONFIG_REGULATOR_RT5033=y
# CONFIG_REGULATOR_S2MPA01 is not set
# CONFIG_REGULATOR_S2MPS11 is not set
CONFIG_REGULATOR_S5M8767=y
# CONFIG_REGULATOR_SKY81452 is not set
# CONFIG_REGULATOR_TPS51632 is not set
CONFIG_REGULATOR_TPS6105X=y
CONFIG_REGULATOR_TPS62360=y
CONFIG_REGULATOR_TPS65023=y
CONFIG_REGULATOR_TPS6507X=y
CONFIG_REGULATOR_TPS65086=y
# CONFIG_REGULATOR_TPS65090 is not set
CONFIG_REGULATOR_TPS65132=y
CONFIG_REGULATOR_TPS65217=y
# CONFIG_REGULATOR_TPS65218 is not set
CONFIG_REGULATOR_TPS65912=y
# CONFIG_REGULATOR_VCTRL is not set
# CONFIG_REGULATOR_WM831X is not set
CONFIG_CEC_CORE=y
# CONFIG_RC_CORE is not set
CONFIG_MEDIA_SUPPORT=y

#
# Multimedia core support
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
# CONFIG_MEDIA_RADIO_SUPPORT is not set
# CONFIG_MEDIA_SDR_SUPPORT is not set
# CONFIG_MEDIA_CEC_SUPPORT is not set
CONFIG_MEDIA_CONTROLLER=y
CONFIG_MEDIA_CONTROLLER_DVB=y
CONFIG_VIDEO_DEV=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
CONFIG_VIDEO_V4L2=y
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
# CONFIG_VIDEO_PCI_SKELETON is not set
CONFIG_VIDEO_TUNER=y
CONFIG_V4L2_MEM2MEM_DEV=y
CONFIG_V4L2_FLASH_LED_CLASS=y
CONFIG_V4L2_FWNODE=y
CONFIG_VIDEOBUF_GEN=y
CONFIG_VIDEOBUF_VMALLOC=y
CONFIG_DVB_CORE=y
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
# CONFIG_TTPCI_EEPROM is not set
CONFIG_DVB_MAX_ADAPTERS=16
# CONFIG_DVB_DYNAMIC_MINORS is not set
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
CONFIG_DVB_ULE_DEBUG=y

#
# Media drivers
#
CONFIG_MEDIA_USB_SUPPORT=y

#
# Webcam devices
#
CONFIG_USB_VIDEO_CLASS=y
# CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV is not set
CONFIG_USB_GSPCA=y
CONFIG_USB_M5602=y
# CONFIG_USB_STV06XX is not set
# CONFIG_USB_GL860 is not set
CONFIG_USB_GSPCA_BENQ=y
CONFIG_USB_GSPCA_CONEX=y
# CONFIG_USB_GSPCA_CPIA1 is not set
CONFIG_USB_GSPCA_DTCS033=y
# CONFIG_USB_GSPCA_ETOMS is not set
# CONFIG_USB_GSPCA_FINEPIX is not set
CONFIG_USB_GSPCA_JEILINJ=y
CONFIG_USB_GSPCA_JL2005BCD=y
# CONFIG_USB_GSPCA_KINECT is not set
# CONFIG_USB_GSPCA_KONICA is not set
# CONFIG_USB_GSPCA_MARS is not set
CONFIG_USB_GSPCA_MR97310A=y
CONFIG_USB_GSPCA_NW80X=y
CONFIG_USB_GSPCA_OV519=y
CONFIG_USB_GSPCA_OV534=y
CONFIG_USB_GSPCA_OV534_9=y
# CONFIG_USB_GSPCA_PAC207 is not set
CONFIG_USB_GSPCA_PAC7302=y
CONFIG_USB_GSPCA_PAC7311=y
# CONFIG_USB_GSPCA_SE401 is not set
CONFIG_USB_GSPCA_SN9C2028=y
# CONFIG_USB_GSPCA_SN9C20X is not set
CONFIG_USB_GSPCA_SONIXB=y
CONFIG_USB_GSPCA_SONIXJ=y
CONFIG_USB_GSPCA_SPCA500=y
CONFIG_USB_GSPCA_SPCA501=y
CONFIG_USB_GSPCA_SPCA505=y
# CONFIG_USB_GSPCA_SPCA506 is not set
CONFIG_USB_GSPCA_SPCA508=y
CONFIG_USB_GSPCA_SPCA561=y
CONFIG_USB_GSPCA_SPCA1528=y
CONFIG_USB_GSPCA_SQ905=y
CONFIG_USB_GSPCA_SQ905C=y
CONFIG_USB_GSPCA_SQ930X=y
CONFIG_USB_GSPCA_STK014=y
CONFIG_USB_GSPCA_STK1135=y
CONFIG_USB_GSPCA_STV0680=y
# CONFIG_USB_GSPCA_SUNPLUS is not set
CONFIG_USB_GSPCA_T613=y
CONFIG_USB_GSPCA_TOPRO=y
# CONFIG_USB_GSPCA_TOUPTEK is not set
CONFIG_USB_GSPCA_TV8532=y
# CONFIG_USB_GSPCA_VC032X is not set
CONFIG_USB_GSPCA_VICAM=y
# CONFIG_USB_GSPCA_XIRLINK_CIT is not set
# CONFIG_USB_GSPCA_ZC3XX is not set
CONFIG_USB_PWC=y
CONFIG_USB_PWC_DEBUG=y
CONFIG_USB_PWC_INPUT_EVDEV=y
CONFIG_VIDEO_CPIA2=y
CONFIG_USB_ZR364XX=y
CONFIG_USB_STKWEBCAM=y
CONFIG_USB_S2255=y
CONFIG_VIDEO_USBTV=y

#
# Analog/digital TV USB devices
#
# CONFIG_VIDEO_AU0828 is not set

#
# Digital TV USB devices
#
CONFIG_DVB_USB_V2=y
CONFIG_DVB_USB_AF9015=y
# CONFIG_DVB_USB_AF9035 is not set
CONFIG_DVB_USB_ANYSEE=y
CONFIG_DVB_USB_AU6610=y
CONFIG_DVB_USB_AZ6007=y
CONFIG_DVB_USB_CE6230=y
# CONFIG_DVB_USB_EC168 is not set
# CONFIG_DVB_USB_GL861 is not set
CONFIG_DVB_USB_MXL111SF=y
# CONFIG_DVB_USB_RTL28XXU is not set
CONFIG_DVB_USB_DVBSKY=y
# CONFIG_DVB_USB_ZD1301 is not set
# CONFIG_DVB_TTUSB_BUDGET is not set
# CONFIG_DVB_TTUSB_DEC is not set
# CONFIG_SMS_USB_DRV is not set
# CONFIG_DVB_B2C2_FLEXCOP_USB is not set
CONFIG_DVB_AS102=y

#
# Webcam, TV (analog/digital) USB devices
#
CONFIG_VIDEO_EM28XX=y
CONFIG_VIDEO_EM28XX_V4L2=y
# CONFIG_VIDEO_EM28XX_ALSA is not set
CONFIG_VIDEO_EM28XX_DVB=y
# CONFIG_MEDIA_PCI_SUPPORT is not set
# CONFIG_V4L_PLATFORM_DRIVERS is not set
CONFIG_V4L_MEM2MEM_DRIVERS=y
CONFIG_VIDEO_SH_VEU=y
CONFIG_V4L_TEST_DRIVERS=y
# CONFIG_VIDEO_VIMC is not set
CONFIG_VIDEO_VIM2M=y
# CONFIG_DVB_PLATFORM_DRIVERS is not set

#
# Supported MMC/SDIO adapters
#
CONFIG_SMS_SDIO_DRV=y
CONFIG_MEDIA_COMMON_OPTIONS=y

#
# common driver options
#
CONFIG_VIDEO_TVEEPROM=y
CONFIG_CYPRESS_FIRMWARE=y
CONFIG_VIDEOBUF2_CORE=y
CONFIG_VIDEOBUF2_MEMOPS=y
CONFIG_VIDEOBUF2_DMA_CONTIG=y
CONFIG_VIDEOBUF2_VMALLOC=y
CONFIG_VIDEOBUF2_DMA_SG=y
CONFIG_SMS_SIANO_MDTV=y

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set

#
# I2C Encoders, decoders, sensors and other helper chips
#

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_TVAUDIO=y
CONFIG_VIDEO_TDA7432=y
# CONFIG_VIDEO_TDA9840 is not set
CONFIG_VIDEO_TEA6415C=y
# CONFIG_VIDEO_TEA6420 is not set
CONFIG_VIDEO_MSP3400=y
CONFIG_VIDEO_CS3308=y
CONFIG_VIDEO_CS5345=y
# CONFIG_VIDEO_CS53L32A is not set
# CONFIG_VIDEO_TLV320AIC23B is not set
CONFIG_VIDEO_UDA1342=y
# CONFIG_VIDEO_WM8775 is not set
CONFIG_VIDEO_WM8739=y
CONFIG_VIDEO_VP27SMPX=y
# CONFIG_VIDEO_SONY_BTF_MPX is not set

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=y

#
# Video decoders
#
CONFIG_VIDEO_ADV7180=y
CONFIG_VIDEO_ADV7183=y
# CONFIG_VIDEO_ADV748X is not set
CONFIG_VIDEO_ADV7604=y
CONFIG_VIDEO_ADV7604_CEC=y
# CONFIG_VIDEO_ADV7842 is not set
# CONFIG_VIDEO_BT819 is not set
CONFIG_VIDEO_BT856=y
# CONFIG_VIDEO_BT866 is not set
CONFIG_VIDEO_KS0127=y
CONFIG_VIDEO_ML86V7667=y
# CONFIG_VIDEO_AD5820 is not set
CONFIG_VIDEO_DW9714=y
# CONFIG_VIDEO_SAA7110 is not set
CONFIG_VIDEO_SAA711X=y
CONFIG_VIDEO_TC358743=y
CONFIG_VIDEO_TC358743_CEC=y
CONFIG_VIDEO_TVP514X=y
# CONFIG_VIDEO_TVP5150 is not set
# CONFIG_VIDEO_TVP7002 is not set
CONFIG_VIDEO_TW2804=y
# CONFIG_VIDEO_TW9903 is not set
CONFIG_VIDEO_TW9906=y
CONFIG_VIDEO_VPX3220=y

#
# Video and audio decoders
#
# CONFIG_VIDEO_SAA717X is not set
CONFIG_VIDEO_CX25840=y

#
# Video encoders
#
CONFIG_VIDEO_SAA7127=y
CONFIG_VIDEO_SAA7185=y
# CONFIG_VIDEO_ADV7170 is not set
# CONFIG_VIDEO_ADV7175 is not set
CONFIG_VIDEO_ADV7343=y
CONFIG_VIDEO_ADV7393=y
CONFIG_VIDEO_ADV7511=y
# CONFIG_VIDEO_ADV7511_CEC is not set
CONFIG_VIDEO_AD9389B=y
CONFIG_VIDEO_AK881X=y
CONFIG_VIDEO_THS8200=y

#
# Camera sensor devices
#
CONFIG_VIDEO_APTINA_PLL=y
CONFIG_VIDEO_IMX274=y
CONFIG_VIDEO_OV2640=y
# CONFIG_VIDEO_OV2659 is not set
CONFIG_VIDEO_OV5640=y
CONFIG_VIDEO_OV5645=y
# CONFIG_VIDEO_OV5647 is not set
CONFIG_VIDEO_OV6650=y
CONFIG_VIDEO_OV5670=y
CONFIG_VIDEO_OV7640=y
CONFIG_VIDEO_OV7670=y
CONFIG_VIDEO_OV7740=y
CONFIG_VIDEO_OV9650=y
CONFIG_VIDEO_OV13858=y
CONFIG_VIDEO_VS6624=y
CONFIG_VIDEO_MT9M032=y
CONFIG_VIDEO_MT9M111=y
# CONFIG_VIDEO_MT9P031 is not set
CONFIG_VIDEO_MT9T001=y
CONFIG_VIDEO_MT9V011=y
CONFIG_VIDEO_MT9V032=y
# CONFIG_VIDEO_SR030PC30 is not set
# CONFIG_VIDEO_NOON010PC30 is not set
CONFIG_VIDEO_M5MOLS=y
CONFIG_VIDEO_S5K6AA=y
# CONFIG_VIDEO_S5K6A3 is not set
CONFIG_VIDEO_S5K4ECGX=y
CONFIG_VIDEO_S5K5BAF=y
# CONFIG_VIDEO_SMIAPP is not set
# CONFIG_VIDEO_ET8EK8 is not set

#
# Flash devices
#
# CONFIG_VIDEO_ADP1653 is not set
CONFIG_VIDEO_LM3560=y
# CONFIG_VIDEO_LM3646 is not set

#
# Video improvement chips
#
CONFIG_VIDEO_UPD64031A=y
# CONFIG_VIDEO_UPD64083 is not set

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
CONFIG_VIDEO_THS7303=y
CONFIG_VIDEO_M52790=y

#
# Sensors used on soc_camera driver
#

#
# SPI helper chips
#
CONFIG_MEDIA_TUNER=y

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_SIMPLE=y
# CONFIG_MEDIA_TUNER_TDA18250 is not set
CONFIG_MEDIA_TUNER_TDA8290=y
CONFIG_MEDIA_TUNER_TDA827X=y
CONFIG_MEDIA_TUNER_TDA18271=y
CONFIG_MEDIA_TUNER_TDA9887=y
CONFIG_MEDIA_TUNER_TEA5761=y
CONFIG_MEDIA_TUNER_TEA5767=y
CONFIG_MEDIA_TUNER_MT20XX=y
# CONFIG_MEDIA_TUNER_MT2060 is not set
CONFIG_MEDIA_TUNER_MT2063=y
# CONFIG_MEDIA_TUNER_MT2266 is not set
# CONFIG_MEDIA_TUNER_MT2131 is not set
CONFIG_MEDIA_TUNER_QT1010=y
CONFIG_MEDIA_TUNER_XC2028=y
CONFIG_MEDIA_TUNER_XC5000=y
CONFIG_MEDIA_TUNER_XC4000=y
CONFIG_MEDIA_TUNER_MXL5005S=y
CONFIG_MEDIA_TUNER_MXL5007T=y
# CONFIG_MEDIA_TUNER_MC44S803 is not set
CONFIG_MEDIA_TUNER_MAX2165=y
CONFIG_MEDIA_TUNER_TDA18218=y
CONFIG_MEDIA_TUNER_FC0011=y
CONFIG_MEDIA_TUNER_FC0012=y
CONFIG_MEDIA_TUNER_FC0013=y
# CONFIG_MEDIA_TUNER_TDA18212 is not set
CONFIG_MEDIA_TUNER_E4000=y
CONFIG_MEDIA_TUNER_FC2580=y
CONFIG_MEDIA_TUNER_M88RS6000T=y
CONFIG_MEDIA_TUNER_TUA9001=y
CONFIG_MEDIA_TUNER_SI2157=y
CONFIG_MEDIA_TUNER_IT913X=y
CONFIG_MEDIA_TUNER_R820T=y
# CONFIG_MEDIA_TUNER_MXL301RF is not set
CONFIG_MEDIA_TUNER_QM1D1C0042=y

#
# Customise DVB Frontends
#

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
# CONFIG_DVB_M88DS3103 is not set

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=y
CONFIG_DVB_TDA18271C2DD=y
CONFIG_DVB_SI2165=y
CONFIG_DVB_MN88472=y
CONFIG_DVB_MN88473=y

#
# DVB-S (satellite) frontends
#
# CONFIG_DVB_CX24110 is not set
CONFIG_DVB_CX24123=y
# CONFIG_DVB_MT312 is not set
CONFIG_DVB_ZL10036=y
CONFIG_DVB_ZL10039=y
CONFIG_DVB_S5H1420=y
CONFIG_DVB_STV0288=y
# CONFIG_DVB_STB6000 is not set
CONFIG_DVB_STV0299=y
# CONFIG_DVB_STV6110 is not set
CONFIG_DVB_STV0900=y
# CONFIG_DVB_TDA8083 is not set
# CONFIG_DVB_TDA10086 is not set
# CONFIG_DVB_TDA8261 is not set
CONFIG_DVB_VES1X93=y
CONFIG_DVB_TUNER_ITD1000=y
CONFIG_DVB_TUNER_CX24113=y
# CONFIG_DVB_TDA826X is not set
CONFIG_DVB_TUA6100=y
CONFIG_DVB_CX24116=y
# CONFIG_DVB_CX24117 is not set
CONFIG_DVB_CX24120=y
CONFIG_DVB_SI21XX=y
CONFIG_DVB_TS2020=y
CONFIG_DVB_DS3000=y
# CONFIG_DVB_MB86A16 is not set
CONFIG_DVB_TDA10071=y

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP8870=y
CONFIG_DVB_SP887X=y
# CONFIG_DVB_CX22700 is not set
CONFIG_DVB_CX22702=y
CONFIG_DVB_S5H1432=y
# CONFIG_DVB_DRXD is not set
# CONFIG_DVB_L64781 is not set
CONFIG_DVB_TDA1004X=y
# CONFIG_DVB_NXT6000 is not set
CONFIG_DVB_MT352=y
CONFIG_DVB_ZL10353=y
# CONFIG_DVB_DIB3000MB is not set
# CONFIG_DVB_DIB3000MC is not set
CONFIG_DVB_DIB7000M=y
CONFIG_DVB_DIB7000P=y
CONFIG_DVB_DIB9000=y
CONFIG_DVB_TDA10048=y
CONFIG_DVB_AF9013=y
# CONFIG_DVB_EC100 is not set
CONFIG_DVB_STV0367=y
CONFIG_DVB_CXD2820R=y
# CONFIG_DVB_CXD2841ER is not set
# CONFIG_DVB_RTL2830 is not set
CONFIG_DVB_RTL2832=y
# CONFIG_DVB_SI2168 is not set
CONFIG_DVB_AS102_FE=y
# CONFIG_DVB_ZD1301_DEMOD is not set
# CONFIG_DVB_GP8PSK_FE is not set

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=y
# CONFIG_DVB_TDA10021 is not set
CONFIG_DVB_TDA10023=y
CONFIG_DVB_STV0297=y

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=y
# CONFIG_DVB_OR51211 is not set
CONFIG_DVB_OR51132=y
# CONFIG_DVB_BCM3510 is not set
CONFIG_DVB_LGDT330X=y
CONFIG_DVB_LGDT3305=y
CONFIG_DVB_LGDT3306A=y
# CONFIG_DVB_LG2160 is not set
# CONFIG_DVB_S5H1409 is not set
CONFIG_DVB_AU8522=y
CONFIG_DVB_AU8522_DTV=y
CONFIG_DVB_AU8522_V4L=y
# CONFIG_DVB_S5H1411 is not set

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=y
CONFIG_DVB_DIB8000=y
CONFIG_DVB_MB86A20S=y

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=y

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=y
CONFIG_DVB_TUNER_DIB0070=y
CONFIG_DVB_TUNER_DIB0090=y

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=y
CONFIG_DVB_LNBH25=y
# CONFIG_DVB_LNBP21 is not set
CONFIG_DVB_LNBP22=y
CONFIG_DVB_ISL6405=y
CONFIG_DVB_ISL6421=y
# CONFIG_DVB_ISL6423 is not set
# CONFIG_DVB_A8293 is not set
# CONFIG_DVB_SP2 is not set
CONFIG_DVB_LGS8GL5=y
CONFIG_DVB_LGS8GXX=y
# CONFIG_DVB_ATBM8830 is not set
CONFIG_DVB_TDA665x=y
# CONFIG_DVB_IX2505V is not set
# CONFIG_DVB_M88RS2000 is not set
CONFIG_DVB_AF9033=y
CONFIG_DVB_HORUS3A=y
# CONFIG_DVB_ASCOT2E is not set
CONFIG_DVB_HELENE=y

#
# Tools to develop new frontends
#
CONFIG_DVB_DUMMY_FE=y

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
# AMD Library routines
#
# CONFIG_CHASH is not set
# CONFIG_DRM_LIB_RANDOM is not set

#
# Frame buffer Devices
#
# CONFIG_FB is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_LCD_CLASS_DEVICE=y
CONFIG_LCD_PLATFORM=y
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_GENERIC is not set
# CONFIG_BACKLIGHT_LM3533 is not set
CONFIG_BACKLIGHT_MAX8925=y
# CONFIG_BACKLIGHT_APPLE is not set
# CONFIG_BACKLIGHT_PM8941_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
CONFIG_BACKLIGHT_WM831X=y
CONFIG_BACKLIGHT_ADP5520=y
CONFIG_BACKLIGHT_ADP8860=y
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_PCF50633 is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_SKY81452=y
CONFIG_BACKLIGHT_TPS65217=y
CONFIG_BACKLIGHT_AS3711=y
CONFIG_BACKLIGHT_GPIO=y
CONFIG_BACKLIGHT_LV5207LP=y
# CONFIG_BACKLIGHT_BD6107 is not set
CONFIG_BACKLIGHT_ARCXCNN=y
# CONFIG_VGASTATE is not set
CONFIG_HDMI=y
CONFIG_SOUND=y
# CONFIG_SOUND_OSS_CORE is not set
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_DMAENGINE_PCM=y
CONFIG_SND_HWDEP=y
CONFIG_SND_RAWMIDI=y
CONFIG_SND_COMPRESS_OFFLOAD=y
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
# CONFIG_SND_OSSEMUL is not set
# CONFIG_SND_PCM_TIMER is not set
# CONFIG_SND_HRTIMER is not set
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
# CONFIG_SND_SUPPORT_OLD_API is not set
# CONFIG_SND_PROC_FS is not set
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_DEBUG=y
# CONFIG_SND_DEBUG_VERBOSE is not set
CONFIG_SND_DMA_SGBUF=y
# CONFIG_SND_SEQUENCER is not set
CONFIG_SND_MPU401_UART=y
CONFIG_SND_OPL3_LIB=y
CONFIG_SND_OPL4_LIB=y
# CONFIG_SND_OPL3_LIB_SEQ is not set
# CONFIG_SND_OPL4_LIB_SEQ is not set
CONFIG_SND_DRIVERS=y
CONFIG_SND_PCSP=y
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_ALOOP is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set
CONFIG_SND_WSS_LIB=y
CONFIG_SND_SB_COMMON=y
CONFIG_SND_SB8_DSP=y
CONFIG_SND_SB16_DSP=y
CONFIG_SND_ISA=y
CONFIG_SND_ADLIB=y
# CONFIG_SND_AD1816A is not set
CONFIG_SND_AD1848=y
# CONFIG_SND_ALS100 is not set
CONFIG_SND_AZT1605=y
# CONFIG_SND_AZT2316 is not set
# CONFIG_SND_AZT2320 is not set
# CONFIG_SND_CMI8328 is not set
CONFIG_SND_CMI8330=y
# CONFIG_SND_CS4231 is not set
CONFIG_SND_CS4236=y
CONFIG_SND_ES1688=y
CONFIG_SND_ES18XX=y
# CONFIG_SND_SC6000 is not set
CONFIG_SND_GUSCLASSIC=y
CONFIG_SND_GUSEXTREME=y
CONFIG_SND_GUSMAX=y
# CONFIG_SND_INTERWAVE is not set
# CONFIG_SND_INTERWAVE_STB is not set
# CONFIG_SND_JAZZ16 is not set
# CONFIG_SND_OPL3SA2 is not set
CONFIG_SND_OPTI92X_AD1848=y
# CONFIG_SND_OPTI92X_CS4231 is not set
CONFIG_SND_OPTI93X=y
# CONFIG_SND_MIRO is not set
CONFIG_SND_SB8=y
CONFIG_SND_SB16=y
# CONFIG_SND_SBAWE is not set
# CONFIG_SND_SBAWE_SEQ is not set
CONFIG_SND_SB16_CSP=y
# CONFIG_SND_SSCAPE is not set
# CONFIG_SND_WAVEFRONT is not set
CONFIG_SND_MSND_PINNACLE=y
# CONFIG_SND_MSND_CLASSIC is not set
CONFIG_SND_PCI=y
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_ASIHPI is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AW2 is not set
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
# CONFIG_SND_EMU10K1_SEQ is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_LOLA is not set
# CONFIG_SND_LX6464ES is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_PCXHR is not set
# CONFIG_SND_RIPTIDE is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_SE6X is not set
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
# CONFIG_SND_USB is not set
CONFIG_SND_SOC=y
CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
CONFIG_SND_SOC_COMPRESS=y
CONFIG_SND_SOC_ACPI=y
CONFIG_SND_SOC_AMD_ACP=y
# CONFIG_SND_SOC_AMD_CZ_RT5645_MACH is not set
CONFIG_SND_ATMEL_SOC=y
# CONFIG_SND_DESIGNWARE_I2S is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
CONFIG_SND_SOC_FSL_ASRC=y
CONFIG_SND_SOC_FSL_SAI=y
# CONFIG_SND_SOC_FSL_SSI is not set
# CONFIG_SND_SOC_FSL_SPDIF is not set
# CONFIG_SND_SOC_FSL_ESAI is not set
# CONFIG_SND_SOC_IMX_AUDMUX is not set
CONFIG_SND_I2S_HI6210_I2S=y
# CONFIG_SND_SOC_IMG is not set
CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
CONFIG_SND_SST_IPC=y
CONFIG_SND_SST_IPC_ACPI=y
# CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_PCI is not set
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM=y
# CONFIG_SND_SOC_INTEL_SKYLAKE is not set
CONFIG_SND_SOC_ACPI_INTEL_MATCH=y
CONFIG_SND_SOC_INTEL_MACH=y

#
# STMicroelectronics STM32 SOC audio support
#
CONFIG_SND_SOC_XTFPGA_I2S=y
# CONFIG_ZX_TDM is not set
CONFIG_SND_SOC_I2C_AND_SPI=y

#
# CODEC drivers
#
# CONFIG_SND_SOC_AC97_CODEC is not set
CONFIG_SND_SOC_ADAU1701=y
# CONFIG_SND_SOC_ADAU1761_I2C is not set
CONFIG_SND_SOC_ADAU7002=y
CONFIG_SND_SOC_AK4554=y
CONFIG_SND_SOC_AK4613=y
CONFIG_SND_SOC_AK4642=y
CONFIG_SND_SOC_AK5386=y
# CONFIG_SND_SOC_ALC5623 is not set
CONFIG_SND_SOC_BT_SCO=y
CONFIG_SND_SOC_CS35L32=y
CONFIG_SND_SOC_CS35L33=y
CONFIG_SND_SOC_CS35L34=y
# CONFIG_SND_SOC_CS35L35 is not set
# CONFIG_SND_SOC_CS42L42 is not set
CONFIG_SND_SOC_CS42L51=y
CONFIG_SND_SOC_CS42L51_I2C=y
CONFIG_SND_SOC_CS42L52=y
CONFIG_SND_SOC_CS42L56=y
# CONFIG_SND_SOC_CS42L73 is not set
CONFIG_SND_SOC_CS4265=y
CONFIG_SND_SOC_CS4270=y
# CONFIG_SND_SOC_CS4271_I2C is not set
CONFIG_SND_SOC_CS42XX8=y
CONFIG_SND_SOC_CS42XX8_I2C=y
CONFIG_SND_SOC_CS43130=y
# CONFIG_SND_SOC_CS4349 is not set
CONFIG_SND_SOC_CS53L30=y
# CONFIG_SND_SOC_DIO2125 is not set
CONFIG_SND_SOC_ES7134=y
# CONFIG_SND_SOC_ES8316 is not set
CONFIG_SND_SOC_ES8328=y
CONFIG_SND_SOC_ES8328_I2C=y
# CONFIG_SND_SOC_GTM601 is not set
CONFIG_SND_SOC_INNO_RK3036=y
CONFIG_SND_SOC_MAX98504=y
CONFIG_SND_SOC_MAX98927=y
CONFIG_SND_SOC_MAX98373=y
CONFIG_SND_SOC_MAX9860=y
# CONFIG_SND_SOC_MSM8916_WCD_DIGITAL is not set
# CONFIG_SND_SOC_PCM1681 is not set
CONFIG_SND_SOC_PCM179X=y
CONFIG_SND_SOC_PCM179X_I2C=y
# CONFIG_SND_SOC_PCM186X_I2C is not set
# CONFIG_SND_SOC_PCM3168A_I2C is not set
CONFIG_SND_SOC_PCM512x=y
CONFIG_SND_SOC_PCM512x_I2C=y
# CONFIG_SND_SOC_RT5514_SPI_BUILTIN is not set
# CONFIG_SND_SOC_RT5616 is not set
CONFIG_SND_SOC_RT5631=y
# CONFIG_SND_SOC_RT5677_SPI is not set
CONFIG_SND_SOC_SGTL5000=y
CONFIG_SND_SOC_SIGMADSP=y
CONFIG_SND_SOC_SIGMADSP_I2C=y
CONFIG_SND_SOC_SIRF_AUDIO_CODEC=y
# CONFIG_SND_SOC_SPDIF is not set
# CONFIG_SND_SOC_SSM2602_I2C is not set
CONFIG_SND_SOC_SSM4567=y
CONFIG_SND_SOC_STA32X=y
CONFIG_SND_SOC_STA350=y
# CONFIG_SND_SOC_STI_SAS is not set
CONFIG_SND_SOC_TAS2552=y
# CONFIG_SND_SOC_TAS5086 is not set
# CONFIG_SND_SOC_TAS571X is not set
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
# CONFIG_SND_SOC_WM8524 is not set
# CONFIG_SND_SOC_WM8580 is not set
CONFIG_SND_SOC_WM8711=y
# CONFIG_SND_SOC_WM8728 is not set
CONFIG_SND_SOC_WM8731=y
CONFIG_SND_SOC_WM8737=y
CONFIG_SND_SOC_WM8741=y
CONFIG_SND_SOC_WM8750=y
# CONFIG_SND_SOC_WM8753 is not set
CONFIG_SND_SOC_WM8776=y
# CONFIG_SND_SOC_WM8804_I2C is not set
# CONFIG_SND_SOC_WM8903 is not set
CONFIG_SND_SOC_WM8960=y
CONFIG_SND_SOC_WM8962=y
# CONFIG_SND_SOC_WM8974 is not set
# CONFIG_SND_SOC_WM8978 is not set
CONFIG_SND_SOC_WM8985=y
CONFIG_SND_SOC_ZX_AUD96P22=y
# CONFIG_SND_SOC_NAU8540 is not set
CONFIG_SND_SOC_NAU8810=y
# CONFIG_SND_SOC_NAU8824 is not set
# CONFIG_SND_SOC_TPA6130A2 is not set
CONFIG_SND_SIMPLE_CARD_UTILS=y
# CONFIG_SND_SIMPLE_CARD is not set
CONFIG_SND_SIMPLE_SCU_CARD=y
# CONFIG_SND_AUDIO_GRAPH_CARD is not set
# CONFIG_SND_AUDIO_GRAPH_SCU_CARD is not set
# CONFIG_SND_X86 is not set

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
# CONFIG_HID_A4TECH is not set
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=y
CONFIG_HID_ACRUX_FF=y
CONFIG_HID_APPLE=y
CONFIG_HID_APPLEIR=y
# CONFIG_HID_ASUS is not set
# CONFIG_HID_AUREAL is not set
# CONFIG_HID_BELKIN is not set
# CONFIG_HID_BETOP_FF is not set
CONFIG_HID_CHERRY=y
CONFIG_HID_CHICONY=y
CONFIG_HID_CORSAIR=y
CONFIG_HID_PRODIKEYS=y
CONFIG_HID_CMEDIA=y
CONFIG_HID_CYPRESS=y
# CONFIG_HID_DRAGONRISE is not set
# CONFIG_HID_EMS_FF is not set
CONFIG_HID_ELECOM=y
# CONFIG_HID_ELO is not set
# CONFIG_HID_EZKEY is not set
CONFIG_HID_GEMBIRD=y
CONFIG_HID_GFRM=y
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=y
CONFIG_HID_KYE=y
# CONFIG_HID_UCLOGIC is not set
# CONFIG_HID_WALTOP is not set
CONFIG_HID_GYRATION=y
CONFIG_HID_ICADE=y
CONFIG_HID_ITE=y
CONFIG_HID_JABRA=y
# CONFIG_HID_TWINHAN is not set
CONFIG_HID_KENSINGTON=y
CONFIG_HID_LCPOWER=y
CONFIG_HID_LED=y
CONFIG_HID_LENOVO=y
CONFIG_HID_LOGITECH=y
CONFIG_HID_LOGITECH_HIDPP=y
CONFIG_LOGITECH_FF=y
CONFIG_LOGIRUMBLEPAD2_FF=y
# CONFIG_LOGIG940_FF is not set
CONFIG_LOGIWHEELS_FF=y
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MAYFLASH is not set
CONFIG_HID_MICROSOFT=y
# CONFIG_HID_MONTEREY is not set
# CONFIG_HID_MULTITOUCH is not set
# CONFIG_HID_NTI is not set
CONFIG_HID_NTRIG=y
CONFIG_HID_ORTEK=y
CONFIG_HID_PANTHERLORD=y
CONFIG_PANTHERLORD_FF=y
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=y
CONFIG_HID_PICOLCD=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
# CONFIG_HID_PICOLCD_LCD is not set
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PLANTRONICS=y
# CONFIG_HID_PRIMAX is not set
CONFIG_HID_RETRODE=y
CONFIG_HID_ROCCAT=y
CONFIG_HID_SAITEK=y
CONFIG_HID_SAMSUNG=y
CONFIG_HID_SONY=y
# CONFIG_SONY_FF is not set
CONFIG_HID_SPEEDLINK=y
CONFIG_HID_STEELSERIES=y
CONFIG_HID_SUNPLUS=y
CONFIG_HID_RMI=y
# CONFIG_HID_GREENASIA is not set
# CONFIG_HID_SMARTJOYPLUS is not set
CONFIG_HID_TIVO=y
CONFIG_HID_TOPSEED=y
CONFIG_HID_THINGM=y
CONFIG_HID_THRUSTMASTER=y
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
CONFIG_HID_WACOM=y
# CONFIG_HID_WIIMOTE is not set
CONFIG_HID_XINMO=y
CONFIG_HID_ZEROPLUS=y
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=y
# CONFIG_HID_SENSOR_HUB is not set
# CONFIG_HID_ALPS is not set

#
# USB HID support
#
CONFIG_USB_HID=y
CONFIG_HID_PID=y
# CONFIG_USB_HIDDEV is not set

#
# I2C HID support
#
CONFIG_I2C_HID=y
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
# CONFIG_USB_DYNAMIC_MINORS is not set
CONFIG_USB_OTG=y
# CONFIG_USB_OTG_WHITELIST is not set
# CONFIG_USB_OTG_BLACKLIST_HUB is not set
# CONFIG_USB_OTG_FSM is not set
# CONFIG_USB_LEDS_TRIGGER_USBPORT is not set
CONFIG_USB_MON=y
CONFIG_USB_WUSB=y
CONFIG_USB_WUSB_CBAF=y
# CONFIG_USB_WUSB_CBAF_DEBUG is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_C67X00_HCD=y
CONFIG_USB_XHCI_HCD=y
CONFIG_USB_XHCI_DBGCAP=y
CONFIG_USB_XHCI_PCI=y
CONFIG_USB_XHCI_PLATFORM=y
# CONFIG_USB_EHCI_HCD is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_ISP1362_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
# CONFIG_USB_UHCI_HCD is not set
CONFIG_USB_SL811_HCD=y
CONFIG_USB_SL811_HCD_ISO=y
CONFIG_USB_R8A66597_HCD=y
# CONFIG_USB_WHCI_HCD is not set
# CONFIG_USB_HWA_HCD is not set
CONFIG_USB_HCD_SSB=y
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=y
CONFIG_USB_PRINTER=y
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
CONFIG_USBIP_CORE=y
# CONFIG_USBIP_VHCI_HCD is not set
CONFIG_USBIP_HOST=y
CONFIG_USBIP_DEBUG=y
CONFIG_USB_MUSB_HDRC=y
CONFIG_USB_MUSB_HOST=y

#
# Platform Glue Layer
#

#
# MUSB DMA mode
#
CONFIG_MUSB_PIO_ONLY=y
# CONFIG_USB_DWC3 is not set
CONFIG_USB_DWC2=y
CONFIG_USB_DWC2_HOST=y

#
# Gadget/Dual-role mode requires USB Gadget support to be enabled
#
# CONFIG_USB_DWC2_PCI is not set
# CONFIG_USB_DWC2_DEBUG is not set
CONFIG_USB_DWC2_TRACK_MISSED_SOFS=y
CONFIG_USB_ISP1760=y
CONFIG_USB_ISP1760_HCD=y
CONFIG_USB_ISP1760_HOST_ROLE=y

#
# USB port drivers
#
CONFIG_USB_SERIAL=y
# CONFIG_USB_SERIAL_CONSOLE is not set
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_SERIAL_SIMPLE=y
# CONFIG_USB_SERIAL_AIRCABLE is not set
CONFIG_USB_SERIAL_ARK3116=y
# CONFIG_USB_SERIAL_BELKIN is not set
CONFIG_USB_SERIAL_CH341=y
CONFIG_USB_SERIAL_WHITEHEAT=y
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
CONFIG_USB_SERIAL_CP210X=y
# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
CONFIG_USB_SERIAL_EMPEG=y
CONFIG_USB_SERIAL_FTDI_SIO=y
# CONFIG_USB_SERIAL_VISOR is not set
CONFIG_USB_SERIAL_IPAQ=y
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
CONFIG_USB_SERIAL_EDGEPORT_TI=y
CONFIG_USB_SERIAL_F81232=y
CONFIG_USB_SERIAL_F8153X=y
# CONFIG_USB_SERIAL_GARMIN is not set
CONFIG_USB_SERIAL_IPW=y
CONFIG_USB_SERIAL_IUU=y
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
CONFIG_USB_SERIAL_KEYSPAN=y
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
CONFIG_USB_SERIAL_METRO=y
# CONFIG_USB_SERIAL_MOS7720 is not set
# CONFIG_USB_SERIAL_MOS7840 is not set
CONFIG_USB_SERIAL_MXUPORT=y
CONFIG_USB_SERIAL_NAVMAN=y
CONFIG_USB_SERIAL_PL2303=y
CONFIG_USB_SERIAL_OTI6858=y
CONFIG_USB_SERIAL_QCAUX=y
CONFIG_USB_SERIAL_QUALCOMM=y
CONFIG_USB_SERIAL_SPCP8X5=y
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
CONFIG_USB_SERIAL_SYMBOL=y
# CONFIG_USB_SERIAL_TI is not set
CONFIG_USB_SERIAL_CYBERJACK=y
# CONFIG_USB_SERIAL_XIRCOM is not set
CONFIG_USB_SERIAL_WWAN=y
CONFIG_USB_SERIAL_OPTION=y
CONFIG_USB_SERIAL_OMNINET=y
# CONFIG_USB_SERIAL_OPTICON is not set
CONFIG_USB_SERIAL_XSENS_MT=y
CONFIG_USB_SERIAL_WISHBONE=y
CONFIG_USB_SERIAL_SSU100=y
CONFIG_USB_SERIAL_QT2=y
CONFIG_USB_SERIAL_UPD78F0730=y
CONFIG_USB_SERIAL_DEBUG=y

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
CONFIG_USB_EMI26=y
CONFIG_USB_ADUTUX=y
CONFIG_USB_SEVSEG=y
# CONFIG_USB_RIO500 is not set
CONFIG_USB_LEGOTOWER=y
CONFIG_USB_LCD=y
CONFIG_USB_CYPRESS_CY7C63=y
CONFIG_USB_CYTHERM=y
CONFIG_USB_IDMOUSE=y
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
CONFIG_USB_SISUSBVGA=y
CONFIG_USB_LD=y
CONFIG_USB_TRANCEVIBRATOR=y
CONFIG_USB_IOWARRIOR=y
# CONFIG_USB_TEST is not set
CONFIG_USB_EHSET_TEST_FIXTURE=y
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
CONFIG_USB_EZUSB_FX2=y
CONFIG_USB_HUB_USB251XB=y
# CONFIG_USB_HSIC_USB3503 is not set
CONFIG_USB_HSIC_USB4604=y
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_ATM is not set

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
CONFIG_TYPEC_TCPM=y
CONFIG_TYPEC_FUSB302=y
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_ACPI is not set
CONFIG_TYPEC_TPS6598X=y
CONFIG_USB_LED_TRIG=y
CONFIG_USB_ULPI_BUS=y
CONFIG_UWB=y
CONFIG_UWB_HWA=y
# CONFIG_UWB_WHCI is not set
CONFIG_UWB_I1480U=y
CONFIG_MMC=y
CONFIG_PWRSEQ_EMMC=y
CONFIG_PWRSEQ_SIMPLE=y
# CONFIG_SDIO_UART is not set
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
# CONFIG_MMC_SDHCI is not set
CONFIG_MMC_WBSD=y
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
CONFIG_MMC_VUB300=y
# CONFIG_MMC_USHC is not set
CONFIG_MMC_USDHI6ROL0=y
CONFIG_MMC_REALTEK_USB=y
# CONFIG_MMC_CQHCI is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
CONFIG_MEMSTICK=y
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
# CONFIG_MEMSTICK_REALTEK_USB is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
# CONFIG_LEDS_AAT1290 is not set
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_AS3645A=y
CONFIG_LEDS_BCM6328=y
# CONFIG_LEDS_BCM6358 is not set
CONFIG_LEDS_LM3530=y
# CONFIG_LEDS_LM3533 is not set
CONFIG_LEDS_LM3642=y
CONFIG_LEDS_LM3692X=y
CONFIG_LEDS_MT6323=y
# CONFIG_LEDS_PCA9532 is not set
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_LP3944=y
CONFIG_LEDS_LP3952=y
CONFIG_LEDS_LP55XX_COMMON=y
# CONFIG_LEDS_LP5521 is not set
CONFIG_LEDS_LP5523=y
CONFIG_LEDS_LP5562=y
CONFIG_LEDS_LP8501=y
CONFIG_LEDS_LP8788=y
CONFIG_LEDS_LP8860=y
# CONFIG_LEDS_CLEVO_MAIL is not set
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
CONFIG_LEDS_WM831X_STATUS=y
# CONFIG_LEDS_REGULATOR is not set
# CONFIG_LEDS_BD2802 is not set
# CONFIG_LEDS_INTEL_SS4200 is not set
CONFIG_LEDS_LT3593=y
# CONFIG_LEDS_ADP5520 is not set
# CONFIG_LEDS_MC13783 is not set
CONFIG_LEDS_TCA6507=y
# CONFIG_LEDS_TLC591XX is not set
CONFIG_LEDS_LM355x=y
CONFIG_LEDS_OT200=y
# CONFIG_LEDS_MENF21BMC is not set
# CONFIG_LEDS_KTD2692 is not set
# CONFIG_LEDS_IS31FL319X is not set
CONFIG_LEDS_IS31FL32XX=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
# CONFIG_LEDS_SYSCON is not set
CONFIG_LEDS_USER=y
# CONFIG_LEDS_NIC78BX is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
# CONFIG_LEDS_TRIGGER_TIMER is not set
CONFIG_LEDS_TRIGGER_ONESHOT=y
# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
CONFIG_LEDS_TRIGGER_BACKLIGHT=y
CONFIG_LEDS_TRIGGER_CPU=y
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=y
CONFIG_LEDS_TRIGGER_DEFAULT_ON=y

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=y
CONFIG_LEDS_TRIGGER_CAMERA=y
CONFIG_LEDS_TRIGGER_PANIC=y
CONFIG_LEDS_TRIGGER_NETDEV=y
CONFIG_ACCESSIBILITY=y
CONFIG_INFINIBAND=y
CONFIG_INFINIBAND_USER_MAD=y
CONFIG_INFINIBAND_USER_ACCESS=y
# CONFIG_INFINIBAND_EXP_USER_ACCESS is not set
CONFIG_INFINIBAND_USER_MEM=y
# CONFIG_INFINIBAND_ON_DEMAND_PAGING is not set
CONFIG_INFINIBAND_ADDR_TRANS=y
CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS=y
# CONFIG_INFINIBAND_MTHCA is not set
# CONFIG_MLX4_INFINIBAND is not set
# CONFIG_INFINIBAND_NES is not set
# CONFIG_INFINIBAND_OCRDMA is not set
# CONFIG_INFINIBAND_IPOIB is not set
# CONFIG_RDMA_RXE is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
# CONFIG_EDAC is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
# CONFIG_RTC_INTF_DEV is not set
CONFIG_RTC_DRV_TEST=y

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_88PM80X is not set
# CONFIG_RTC_DRV_ABB5ZES3 is not set
CONFIG_RTC_DRV_ABX80X=y
CONFIG_RTC_DRV_AS3722=y
# CONFIG_RTC_DRV_DS1307 is not set
CONFIG_RTC_DRV_DS1374=y
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=y
CONFIG_RTC_DRV_HYM8563=y
CONFIG_RTC_DRV_LP8788=y
# CONFIG_RTC_DRV_MAX6900 is not set
CONFIG_RTC_DRV_MAX8907=y
CONFIG_RTC_DRV_MAX8925=y
CONFIG_RTC_DRV_MAX77686=y
# CONFIG_RTC_DRV_RK808 is not set
# CONFIG_RTC_DRV_RS5C372 is not set
CONFIG_RTC_DRV_ISL1208=y
CONFIG_RTC_DRV_ISL12022=y
CONFIG_RTC_DRV_X1205=y
CONFIG_RTC_DRV_PCF8523=y
CONFIG_RTC_DRV_PCF85063=y
CONFIG_RTC_DRV_PCF85363=y
CONFIG_RTC_DRV_PCF8563=y
CONFIG_RTC_DRV_PCF8583=y
CONFIG_RTC_DRV_M41T80=y
# CONFIG_RTC_DRV_M41T80_WDT is not set
CONFIG_RTC_DRV_BQ32K=y
# CONFIG_RTC_DRV_RC5T583 is not set
CONFIG_RTC_DRV_S35390A=y
CONFIG_RTC_DRV_FM3130=y
CONFIG_RTC_DRV_RX8010=y
CONFIG_RTC_DRV_RX8581=y
CONFIG_RTC_DRV_RX8025=y
CONFIG_RTC_DRV_EM3027=y
CONFIG_RTC_DRV_RV8803=y
CONFIG_RTC_DRV_S5M=y

#
# SPI RTC drivers
#
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
# CONFIG_RTC_DRV_DS3232 is not set
CONFIG_RTC_DRV_PCF2127=y
CONFIG_RTC_DRV_RV3029C2=y
# CONFIG_RTC_DRV_RV3029_HWMON is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=y
# CONFIG_RTC_DRV_DS1511 is not set
CONFIG_RTC_DRV_DS1553=y
CONFIG_RTC_DRV_DS1685_FAMILY=y
# CONFIG_RTC_DRV_DS1685 is not set
# CONFIG_RTC_DRV_DS1689 is not set
# CONFIG_RTC_DRV_DS17285 is not set
CONFIG_RTC_DRV_DS17485=y
# CONFIG_RTC_DRV_DS17885 is not set
# CONFIG_RTC_DS1685_PROC_REGS is not set
# CONFIG_RTC_DS1685_SYSFS_REGS is not set
CONFIG_RTC_DRV_DS1742=y
CONFIG_RTC_DRV_DS2404=y
CONFIG_RTC_DRV_DA9055=y
CONFIG_RTC_DRV_DA9063=y
CONFIG_RTC_DRV_STK17TA8=y
CONFIG_RTC_DRV_M48T86=y
CONFIG_RTC_DRV_M48T35=y
CONFIG_RTC_DRV_M48T59=y
# CONFIG_RTC_DRV_MSM6242 is not set
CONFIG_RTC_DRV_BQ4802=y
CONFIG_RTC_DRV_RP5C01=y
CONFIG_RTC_DRV_V3020=y
CONFIG_RTC_DRV_WM831X=y
CONFIG_RTC_DRV_PCF50633=y
CONFIG_RTC_DRV_ZYNQMP=y

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set
CONFIG_RTC_DRV_MC13XXX=y
CONFIG_RTC_DRV_SNVS=y
# CONFIG_RTC_DRV_MT6397 is not set
CONFIG_RTC_DRV_R7301=y

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_HID_SENSOR_TIME is not set
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
# CONFIG_SYNC_FILE is not set
CONFIG_AUXDISPLAY=y
# CONFIG_HD44780 is not set
CONFIG_IMG_ASCII_LCD=y
CONFIG_UIO=y
# CONFIG_UIO_CIF is not set
CONFIG_UIO_PDRV_GENIRQ=y
CONFIG_UIO_DMEM_GENIRQ=y
# CONFIG_UIO_AEC is not set
# CONFIG_UIO_SERCOS3 is not set
# CONFIG_UIO_PCI_GENERIC is not set
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_VIRT_DRIVERS=y
# CONFIG_VBOXGUEST is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
# CONFIG_VIRTIO_PCI is not set
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_INPUT=y
CONFIG_VIRTIO_MMIO=y
CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV_TSCPAGE is not set
# CONFIG_STAGING is not set
# CONFIG_X86_PLATFORM_DEVICES is not set
CONFIG_PMC_ATOM=y
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_WM831X is not set
# CONFIG_CLK_HSDK is not set
# CONFIG_COMMON_CLK_MAX77686 is not set
# CONFIG_COMMON_CLK_RK808 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI514 is not set
# CONFIG_COMMON_CLK_SI570 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CDCE925 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_S2MPS11 is not set
# CONFIG_COMMON_CLK_NXP is not set
# CONFIG_COMMON_CLK_PXA is not set
# CONFIG_COMMON_CLK_PIC32 is not set
# CONFIG_COMMON_CLK_VC5 is not set
CONFIG_HWSPINLOCK=y

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
CONFIG_RPMSG=y
CONFIG_RPMSG_CHAR=y
CONFIG_RPMSG_VIRTIO=y
CONFIG_SOUNDWIRE=y

#
# SoundWire Devices
#
# CONFIG_SOUNDWIRE_INTEL is not set

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
# CONFIG_PM_DEVFREQ is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=y
# CONFIG_EXTCON_ARIZONA is not set
CONFIG_EXTCON_AXP288=y
CONFIG_EXTCON_GPIO=y
# CONFIG_EXTCON_INTEL_INT3496 is not set
CONFIG_EXTCON_MAX3355=y
CONFIG_EXTCON_RT8973A=y
CONFIG_EXTCON_SM5502=y
CONFIG_EXTCON_USB_GPIO=y
CONFIG_MEMORY=y
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
CONFIG_IIO_BUFFER_HW_CONSUMER=y
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=y
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
# CONFIG_IIO_SW_DEVICE is not set
CONFIG_IIO_SW_TRIGGER=y

#
# Accelerometers
#
# CONFIG_ADXL345_I2C is not set
CONFIG_BMA180=y
# CONFIG_BMC150_ACCEL is not set
# CONFIG_DA280 is not set
# CONFIG_DA311 is not set
CONFIG_DMARD06=y
CONFIG_DMARD09=y
CONFIG_DMARD10=y
CONFIG_IIO_CROS_EC_ACCEL_LEGACY=y
# CONFIG_KXSD9 is not set
CONFIG_KXCJK1013=y
CONFIG_MC3230=y
CONFIG_MMA7455=y
CONFIG_MMA7455_I2C=y
CONFIG_MMA7660=y
# CONFIG_MMA8452 is not set
# CONFIG_MMA9551 is not set
# CONFIG_MMA9553 is not set
# CONFIG_MXC4005 is not set
CONFIG_MXC6255=y
CONFIG_STK8312=y
CONFIG_STK8BA50=y

#
# Analog to digital converters
#
# CONFIG_AD7291 is not set
CONFIG_AD799X=y
CONFIG_AXP20X_ADC=y
CONFIG_AXP288_ADC=y
# CONFIG_CC10001_ADC is not set
CONFIG_DA9150_GPADC=y
CONFIG_DLN2_ADC=y
CONFIG_ENVELOPE_DETECTOR=y
# CONFIG_HX711 is not set
CONFIG_LP8788_ADC=y
CONFIG_LTC2471=y
# CONFIG_LTC2485 is not set
# CONFIG_LTC2497 is not set
CONFIG_MAX1363=y
CONFIG_MAX9611=y
CONFIG_MCP3422=y
CONFIG_MEN_Z188_ADC=y
CONFIG_NAU7802=y
CONFIG_SD_ADC_MODULATOR=y
# CONFIG_STX104 is not set
CONFIG_TI_ADC081C=y
# CONFIG_TI_AM335X_ADC is not set
CONFIG_VF610_ADC=y
# CONFIG_VIPERBOARD_ADC is not set

#
# Amplifiers
#

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=y
CONFIG_CCS811=y
# CONFIG_IAQCORE is not set
# CONFIG_VZ89X is not set

#
# Hid Sensor IIO Common
#
CONFIG_IIO_MS_SENSORS_I2C=y

#
# SSP Sensor Common
#
CONFIG_IIO_ST_SENSORS_I2C=y
CONFIG_IIO_ST_SENSORS_CORE=y

#
# Counters
#
# CONFIG_104_QUAD_8 is not set

#
# Digital to analog converters
#
CONFIG_AD5064=y
CONFIG_AD5380=y
CONFIG_AD5446=y
CONFIG_AD5592R_BASE=y
CONFIG_AD5593R=y
# CONFIG_CIO_DAC is not set
CONFIG_DPOT_DAC=y
CONFIG_DS4424=y
CONFIG_M62332=y
CONFIG_MAX517=y
CONFIG_MAX5821=y
CONFIG_MCP4725=y
CONFIG_VF610_DAC=y

#
# IIO dummy driver
#

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#

#
# Phase-Locked Loop (PLL) frequency synthesizers
#

#
# Digital gyroscope sensors
#
CONFIG_BMG160=y
CONFIG_BMG160_I2C=y
CONFIG_MPU3050=y
CONFIG_MPU3050_I2C=y
# CONFIG_IIO_ST_GYRO_3AXIS is not set
CONFIG_ITG3200=y

#
# Health Sensors
#

#
# Heart Rate Monitors
#
# CONFIG_AFE4404 is not set
CONFIG_MAX30100=y
CONFIG_MAX30102=y

#
# Humidity sensors
#
CONFIG_AM2315=y
# CONFIG_DHT11 is not set
# CONFIG_HDC100X is not set
CONFIG_HTS221=y
CONFIG_HTS221_I2C=y
# CONFIG_HTU21 is not set
CONFIG_SI7005=y
# CONFIG_SI7020 is not set

#
# Inertial measurement units
#
CONFIG_BMI160=y
CONFIG_BMI160_I2C=y
CONFIG_KMX61=y
CONFIG_INV_MPU6050_IIO=y
CONFIG_INV_MPU6050_I2C=y
CONFIG_IIO_ST_LSM6DSX=y
CONFIG_IIO_ST_LSM6DSX_I2C=y

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
# CONFIG_ADJD_S311 is not set
# CONFIG_AL3320A is not set
CONFIG_APDS9300=y
CONFIG_APDS9960=y
# CONFIG_BH1750 is not set
CONFIG_BH1780=y
CONFIG_CM32181=y
# CONFIG_CM3232 is not set
CONFIG_CM3323=y
CONFIG_CM3605=y
# CONFIG_CM36651 is not set
CONFIG_GP2AP020A00F=y
# CONFIG_SENSORS_ISL29018 is not set
CONFIG_SENSORS_ISL29028=y
CONFIG_ISL29125=y
CONFIG_JSA1212=y
CONFIG_RPR0521=y
CONFIG_SENSORS_LM3533=y
CONFIG_LTR501=y
CONFIG_MAX44000=y
# CONFIG_OPT3001 is not set
# CONFIG_PA12203001 is not set
CONFIG_SI1145=y
CONFIG_STK3310=y
# CONFIG_ST_UVIS25 is not set
# CONFIG_TCS3414 is not set
CONFIG_TCS3472=y
CONFIG_SENSORS_TSL2563=y
# CONFIG_TSL2583 is not set
CONFIG_TSL4531=y
# CONFIG_US5182D is not set
# CONFIG_VCNL4000 is not set
CONFIG_VEML6070=y
CONFIG_VL6180=y
# CONFIG_ZOPT2201 is not set

#
# Magnetometer sensors
#
CONFIG_AK8974=y
CONFIG_AK8975=y
CONFIG_AK09911=y
CONFIG_BMC150_MAGN=y
CONFIG_BMC150_MAGN_I2C=y
# CONFIG_MAG3110 is not set
CONFIG_MMC35240=y
CONFIG_IIO_ST_MAGN_3AXIS=y
CONFIG_IIO_ST_MAGN_I2C_3AXIS=y
CONFIG_SENSORS_HMC5843=y
CONFIG_SENSORS_HMC5843_I2C=y

#
# Multiplexers
#
CONFIG_IIO_MUX=y

#
# Inclinometer sensors
#

#
# Triggers - standalone
#
CONFIG_IIO_HRTIMER_TRIGGER=y
# CONFIG_IIO_INTERRUPT_TRIGGER is not set
# CONFIG_IIO_TIGHTLOOP_TRIGGER is not set
CONFIG_IIO_SYSFS_TRIGGER=y

#
# Digital potentiometers
#
CONFIG_DS1803=y
# CONFIG_MCP4531 is not set
CONFIG_TPL0102=y

#
# Digital potentiostats
#
# CONFIG_LMP91000 is not set

#
# Pressure sensors
#
# CONFIG_ABP060MG is not set
CONFIG_BMP280=y
CONFIG_BMP280_I2C=y
# CONFIG_HP03 is not set
CONFIG_MPL115=y
CONFIG_MPL115_I2C=y
# CONFIG_MPL3115 is not set
CONFIG_MS5611=y
CONFIG_MS5611_I2C=y
CONFIG_MS5637=y
CONFIG_IIO_ST_PRESS=y
CONFIG_IIO_ST_PRESS_I2C=y
CONFIG_T5403=y
# CONFIG_HP206C is not set
CONFIG_ZPA2326=y
CONFIG_ZPA2326_I2C=y

#
# Lightning sensors
#

#
# Proximity and distance sensors
#
CONFIG_LIDAR_LITE_V2=y
CONFIG_RFD77402=y
# CONFIG_SRF04 is not set
CONFIG_SX9500=y
CONFIG_SRF08=y

#
# Temperature sensors
#
CONFIG_MLX90614=y
# CONFIG_TMP006 is not set
CONFIG_TMP007=y
CONFIG_TSYS01=y
CONFIG_TSYS02D=y
# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
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
CONFIG_RESET_TI_SYSCON=y
# CONFIG_RESET_ZYNQ is not set
# CONFIG_RESET_TEGRA_BPMP is not set
CONFIG_FMC=y
# CONFIG_FMC_FAKEDEV is not set
CONFIG_FMC_TRIVIAL=y
CONFIG_FMC_WRITE_EEPROM=y
# CONFIG_FMC_CHARDEV is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
CONFIG_PHY_CPCAP_USB=y
# CONFIG_PHY_QCOM_USB_HS is not set
CONFIG_PHY_QCOM_USB_HSIC=y
CONFIG_PHY_SAMSUNG_USB2=y
# CONFIG_PHY_EXYNOS4210_USB2 is not set
# CONFIG_PHY_EXYNOS4X12_USB2 is not set
# CONFIG_PHY_EXYNOS5250_USB2 is not set
CONFIG_PHY_TUSB1210=y
CONFIG_POWERCAP=y
# CONFIG_INTEL_RAPL is not set
CONFIG_MCB=y
# CONFIG_MCB_PCI is not set
# CONFIG_MCB_LPC is not set

#
# Performance monitor support
#
CONFIG_RAS=y
# CONFIG_THUNDERBOLT is not set

#
# Android
#
# CONFIG_ANDROID is not set
CONFIG_DAX=y
CONFIG_NVMEM=y
CONFIG_STM=y
CONFIG_STM_DUMMY=y
# CONFIG_STM_SOURCE_CONSOLE is not set
CONFIG_STM_SOURCE_HEARTBEAT=y
# CONFIG_INTEL_TH is not set
CONFIG_FPGA=y
CONFIG_ALTERA_PR_IP_CORE=y
CONFIG_ALTERA_PR_IP_CORE_PLAT=y
# CONFIG_FPGA_MGR_ALTERA_CVP is not set
# CONFIG_FPGA_BRIDGE is not set
CONFIG_FSI=y
# CONFIG_FSI_MASTER_GPIO is not set
CONFIG_FSI_MASTER_HUB=y
CONFIG_FSI_SCOM=y
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=y
CONFIG_MUX_GPIO=y
# CONFIG_MUX_MMIO is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set

#
# Firmware Drivers
#
# CONFIG_EDD is not set
CONFIG_FIRMWARE_MEMMAP=y
# CONFIG_DELL_RBU is not set
# CONFIG_DCDBAS is not set
# CONFIG_DMIID is not set
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT_FIND is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
# CONFIG_GOOGLE_FIRMWARE is not set
# CONFIG_EFI_DEV_PATH_PARSER is not set

#
# Tegra firmware driver
#

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_FS_POSIX_ACL is not set
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
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
CONFIG_QFMT_V1=y
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS4_FS is not set
# CONFIG_FUSE_FS is not set
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
CONFIG_FSCACHE=y
# CONFIG_FSCACHE_STATS is not set
CONFIG_FSCACHE_HISTOGRAM=y
CONFIG_FSCACHE_DEBUG=y
# CONFIG_FSCACHE_OBJECT_LIST is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_SYSCTL=y
# CONFIG_PROC_PAGE_MONITOR is not set
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
CONFIG_ECRYPT_FS=y
CONFIG_ECRYPT_FS_MESSAGING=y
CONFIG_CRAMFS=y
CONFIG_PSTORE=y
# CONFIG_PSTORE_ZLIB_COMPRESS is not set
# CONFIG_PSTORE_LZO_COMPRESS is not set
CONFIG_PSTORE_LZ4_COMPRESS=y
CONFIG_PSTORE_CONSOLE=y
# CONFIG_PSTORE_PMSG is not set
CONFIG_PSTORE_RAM=y
# CONFIG_NETWORK_FILESYSTEMS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=y
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=y
# CONFIG_NLS_CODEPAGE_860 is not set
CONFIG_NLS_CODEPAGE_861=y
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
CONFIG_NLS_CODEPAGE_864=y
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
CONFIG_NLS_CODEPAGE_936=y
CONFIG_NLS_CODEPAGE_950=y
# CONFIG_NLS_CODEPAGE_932 is not set
CONFIG_NLS_CODEPAGE_949=y
CONFIG_NLS_CODEPAGE_874=y
CONFIG_NLS_ISO8859_8=y
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=y
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
CONFIG_NLS_ISO8859_3=y
CONFIG_NLS_ISO8859_4=y
CONFIG_NLS_ISO8859_5=y
CONFIG_NLS_ISO8859_6=y
# CONFIG_NLS_ISO8859_7 is not set
CONFIG_NLS_ISO8859_9=y
CONFIG_NLS_ISO8859_13=y
CONFIG_NLS_ISO8859_14=y
# CONFIG_NLS_ISO8859_15 is not set
CONFIG_NLS_KOI8_R=y
CONFIG_NLS_KOI8_U=y
CONFIG_NLS_MAC_ROMAN=y
# CONFIG_NLS_MAC_CELTIC is not set
CONFIG_NLS_MAC_CENTEURO=y
CONFIG_NLS_MAC_CROATIAN=y
CONFIG_NLS_MAC_CYRILLIC=y
# CONFIG_NLS_MAC_GAELIC is not set
CONFIG_NLS_MAC_GREEK=y
CONFIG_NLS_MAC_ICELAND=y
CONFIG_NLS_MAC_INUIT=y
CONFIG_NLS_MAC_ROMANIAN=y
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
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_FRAME_WARN=1024
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_READABLE_ASM is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_PAGE_OWNER is not set
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
# CONFIG_DEBUG_SECTION_MISMATCH is not set
# CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
CONFIG_FRAME_POINTER=y
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
# CONFIG_PAGE_POISONING is not set
CONFIG_DEBUG_RODATA_TEST=y
# CONFIG_DEBUG_OBJECTS is not set
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_SLAB_LEAK=y
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_STACK_USAGE=y
CONFIG_DEBUG_VM=y
# CONFIG_DEBUG_VM_VMACACHE is not set
CONFIG_DEBUG_VM_RB=y
CONFIG_DEBUG_VM_PGFLAGS=y
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_DEBUG_HIGHMEM=y
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
CONFIG_DEBUG_SHIRQ=y

#
# Debug Lockups and Hangs
#
# CONFIG_SOFTLOCKUP_DETECTOR is not set
# CONFIG_HARDLOCKUP_DETECTOR is not set
# CONFIG_DETECT_HUNG_TASK is not set
CONFIG_WQ_WATCHDOG=y
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_DEBUG_TIMEKEEPING=y
CONFIG_DEBUG_PREEMPT=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
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
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_PI_LIST is not set
CONFIG_DEBUG_SG=y
CONFIG_DEBUG_NOTIFIERS=y
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
# CONFIG_PROVE_RCU is not set
CONFIG_TORTURE_TEST=y
CONFIG_RCU_PERF_TEST=y
CONFIG_RCU_TORTURE_TEST=y
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_TRACE=y
CONFIG_RCU_EQS_DEBUG=y
CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
CONFIG_NOTIFIER_ERROR_INJECTION=y
CONFIG_PM_NOTIFIER_ERROR_INJECT=y
CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT=y
CONFIG_NETDEV_NOTIFIER_ERROR_INJECT=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_LATENCYTOP=y
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
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_DMA_API_DEBUG is not set
CONFIG_RUNTIME_TESTING_MENU=y
CONFIG_TEST_LIST_SORT=y
# CONFIG_TEST_SORT is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
CONFIG_TEST_KSTRTOX=y
# CONFIG_TEST_PRINTF is not set
CONFIG_TEST_BITMAP=y
CONFIG_TEST_UUID=y
CONFIG_TEST_RHASHTABLE=y
# CONFIG_TEST_HASH is not set
CONFIG_FIND_BIT_BENCHMARK=y
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
CONFIG_TEST_UDELAY=y
CONFIG_MEMTEST=y
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_ARCH_WANTS_UBSAN_NO_NULL is not set
CONFIG_UBSAN=y
# CONFIG_UBSAN_SANITIZE_ALL is not set
# CONFIG_UBSAN_ALIGNMENT is not set
CONFIG_UBSAN_NULL=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
# CONFIG_EARLY_PRINTK_DBGP is not set
# CONFIG_EARLY_PRINTK_USB_XDBC is not set
CONFIG_X86_PTDUMP_CORE=y
CONFIG_X86_PTDUMP=y
# CONFIG_DEBUG_WX is not set
# CONFIG_DOUBLEFAULT is not set
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
CONFIG_DEBUG_ENTRY=y
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_FRAME_POINTER=y
# CONFIG_UNWINDER_GUESS is not set

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_BIG_KEYS is not set
CONFIG_TRUSTED_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
# CONFIG_SECURITY is not set
CONFIG_SECURITYFS=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
CONFIG_FORTIFY_SOURCE=y
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
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
# CONFIG_CRYPTO_RSA is not set
# CONFIG_CRYPTO_DH is not set
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=y
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=y
# CONFIG_CRYPTO_MCRYPTD is not set
CONFIG_CRYPTO_AUTHENC=y

#
# Authenticated Encryption with Associated Data
#
# CONFIG_CRYPTO_CCM is not set
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_LRW is not set
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
CONFIG_CRYPTO_CRC32C_INTEL=y
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRC32_PCLMUL=y
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_RMD128 is not set
CONFIG_CRYPTO_RMD160=y
CONFIG_CRYPTO_RMD256=y
CONFIG_CRYPTO_RMD320=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=y
CONFIG_CRYPTO_TGR192=y
CONFIG_CRYPTO_WP512=y

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
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_KHAZAD=y
# CONFIG_CRYPTO_SALSA20 is not set
# CONFIG_CRYPTO_SALSA20_586 is not set
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_SEED=y
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_SERPENT_SSE2_586 is not set
CONFIG_CRYPTO_TEA=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_586=y

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=y
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
CONFIG_CRYPTO_USER_API=y
# CONFIG_CRYPTO_USER_API_HASH is not set
CONFIG_CRYPTO_USER_API_SKCIPHER=y
# CONFIG_CRYPTO_USER_API_RNG is not set
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=y
CONFIG_CRYPTO_DEV_PADLOCK_AES=y
CONFIG_CRYPTO_DEV_PADLOCK_SHA=y
# CONFIG_CRYPTO_DEV_GEODE is not set
# CONFIG_CRYPTO_DEV_HIFN_795X is not set
# CONFIG_CRYPTO_DEV_FSL_CAAM_CRYPTO_API_DESC is not set
# CONFIG_CRYPTO_DEV_CCP is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
# CONFIG_CRYPTO_DEV_QAT_C62X is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
# CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
# CONFIG_CRYPTO_DEV_VIRTIO is not set
# CONFIG_ASYMMETRIC_KEY_TYPE is not set

#
# Certificates for signature checking
#
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
CONFIG_VHOST_NET=y
CONFIG_VHOST_VSOCK=y
CONFIG_VHOST=y
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set
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
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=y
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC4=y
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_AUDIT_GENERIC=y
# CONFIG_AUDIT_ARCH_COMPAT_GENERIC is not set
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
# CONFIG_XZ_DEC_IA64 is not set
# CONFIG_XZ_DEC_ARM is not set
# CONFIG_XZ_DEC_ARMTHUMB is not set
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=y
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=y
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_SGL_ALLOC=y
# CONFIG_DMA_DIRECT_OPS is not set
# CONFIG_DMA_VIRT_OPS is not set
CONFIG_CHECK_SIGNATURE=y
CONFIG_DQL=y
CONFIG_NLATTR=y
CONFIG_CORDIC=y
# CONFIG_DDR is not set
CONFIG_IRQ_POLL=y
CONFIG_LIBFDT=y
# CONFIG_SG_SPLIT is not set
# CONFIG_SG_POOL is not set
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_STRING_SELFTEST=y

--gDGSpKKIBgtShtf+--
