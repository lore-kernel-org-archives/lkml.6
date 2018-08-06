Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5263C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0650C219CF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:50:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0650C219CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbeHFL64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:58:56 -0400
Received: from mga06.intel.com ([134.134.136.31]:56370 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726640AbeHFL64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:58:56 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2018 02:50:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,452,1526367600"; 
   d="gz'50?scan'50,208,50";a="222259363"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.4])
  by orsmga004.jf.intel.com with ESMTP; 06 Aug 2018 02:50:06 -0700
Date:   Mon, 6 Aug 2018 17:50:41 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-gpio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-mips@linux-mips.org, LKP <lkp@01.org>
Subject: [LKP] 28a54ccb4d [ 2.593639] BUG: unable to handle kernel paging
 request at c1aa2000
Message-ID: <20180806095041.GA5840@shao2-debian>
Reply-To: kernel test robot <lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
User-Agent: Heirloom mailx 12.5 6/20/10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/pti

commit 28a54ccb4d286b31b1759cf325731f44ef14222d
Merge: 706d51681d636 2140e26f3d98e
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun Aug 5 22:26:02 2018 +0200
Commit:     Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun Aug 5 22:26:02 2018 +0200

    Merge branch 'x86/pti-urgent' into x86/pti
    
    Integrate the PTI Global bit fixes which conflict with the 32bit PTI support.
    
    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

706d51681d  x86/speculation: Support Enhanced IBRS on future CPUs
2140e26f3d  x86/mm/init: Remove freed kernel image areas from alias mapping
28a54ccb4d  Merge branch 'x86/pti-urgent' into x86/pti
9c2c950edb  Merge branch 'x86/vdso'
+------------------------------------------+------------+------------+------------+------------+
|                                          | 706d51681d | 2140e26f3d | 28a54ccb4d | 9c2c950edb |
+------------------------------------------+------------+------------+------------+------------+
| boot_successes                           | 58         | 58         | 0          | 0          |
| boot_failures                            | 0          | 0          | 22         | 18         |
| BUG:unable_to_handle_kernel              | 0          | 0          | 22         | 18         |
| Oops:#[##]                               | 0          | 0          | 22         | 18         |
| EIP:get_page_from_freelist               | 0          | 0          | 13         | 16         |
| EIP:copy_page_to_iter                    | 0          | 0          | 7          | 11         |
| Kernel_panic-not_syncing:Fatal_exception | 0          | 0          | 22         | 18         |
| EIP:handle_mm_fault                      | 0          | 0          | 5          |            |
| EIP:wp_page_copy                         | 0          | 0          | 4          | 2          |
+------------------------------------------+------------+------------+------------+------------+

[    2.562080] random: get_random_bytes called from prandom_seed_full_state+0x2c/0xa0 with crng_init=0
[    2.565719] Freeing unused kernel image memory: 644K
[    2.573117] Write protecting the kernel text: 7668k
[    2.575673] Write protecting the kernel read-only data: 2392k
[    2.577149] rodata_test: all tests were successful
[    2.593639] BUG: unable to handle kernel paging request at c1aa2000
[    2.595231] *pde = 1661e163 *pte = 01aa2062 
[    2.596351] Oops: 0002 [#1] SMP PTI
[    2.597312] CPU: 0 PID: 1 Comm: init Not tainted 4.18.0-rc8-00056-g28a54cc #2
[    2.599027] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[    2.601109] EIP: get_page_from_freelist+0x20a/0xb20
[    2.602360] Code: e4 eb 54 90 8d 74 26 00 f7 c7 02 00 00 00 0f 85 14 08 00 00 f7 c7 04 00 00 00 0f 85 f7 07 00 00 89 d1 31 c0 c1 e9 02 f6 c2 02 <f3> ab 74 08 66 c7 07 00 00 83 c7 02 f6 c2 01 74 03 c6 07 00 89 f0 
[    2.606778] EAX: 00000000 EBX: d582c950 ECX: 00000400 EDX: 00001000
[    2.608317] ESI: c1aa2000 EDI: c1aa2000 EBP: d50b1c70 ESP: d50b1bf8
[    2.609843] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010246
[    2.611489] CR0: 80050033 CR2: c1aa2000 CR3: 1662e000 CR4: 000006d0
[    2.613033] Call Trace:
[    2.613777]  __alloc_pages_nodemask+0xa8/0xb70
[    2.614935]  ? is_module_text_address+0xf/0x20
[    2.616099]  ? kernel_text_address+0x38/0x80
[    2.617214]  ? __kernel_text_address+0xb/0x30
[    2.618357]  ? unwind_get_return_address+0x1e/0x40
[    2.619592]  ? __save_stack_trace+0x6e/0xb0
[    2.620692]  ? deactivate_slab+0x2ae/0x4f0
[    2.621934]  handle_mm_fault+0xa9f/0xd50
[    2.623007]  __do_page_fault+0x189/0x470
[    2.624057]  ? kvm_disable_steal_time+0x20/0x20
[    2.625368]  do_page_fault+0x21/0x30
[    2.626342]  do_async_page_fault+0x14/0x80
[    2.627430]  common_exception+0x110/0x116
[    2.628498] EIP: copy_page_to_iter+0xe3/0x3d0
[    2.629629] Code: 85 db 8d 4c 1f ff 0f 84 ce 00 00 00 39 cf 77 24 89 fa 31 ff eb 0f 90 81 c2 00 10 00 00 39 d1 0f 82 9a 00 00 00 8d 76 00 89 f8 <c6> 02 00 8d 76 00 85 c0 74 e3 8b 7d e8 8b 45 e4 e8 18 82 d0 ff 8b 
[    2.634080] EAX: 00000000 EBX: 0000014d ECX: b7f1e14c EDX: b7f1e000
[    2.635614] ESI: d50b1ef4 EDI: 00000000 EBP: d50b1e48 ESP: d50b1e20
[    2.637156] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010246
[    2.638796]  ? kvm_disable_steal_time+0x20/0x20
[    2.640122]  generic_file_buffered_read+0x35e/0x700
[    2.641369]  generic_file_read_iter+0x157/0x1b0
[    2.642478]  __vfs_read+0xf2/0x160
[    2.643283]  vfs_read+0x8f/0x140
[    2.643977]  ksys_read+0x40/0xa0
[    2.644582]  sys_read+0x11/0x20
[    2.645455]  do_int80_syscall_32+0x67/0x110
[    2.646165]  entry_INT80_32+0xc3/0xc3
[    2.646824] EIP: 0xb7f221b2
[    2.647357] Code: 89 c2 31 c0 89 d7 f3 aa 8b 44 24 1c 89 30 c6 40 04 00 83 c4 2c 89 f0 5b 5e 5f 5d c3 90 90 90 90 90 90 90 90 90 90 90 90 cd 80 <c3> 8d b6 00 00 00 00 8d bc 27 00 00 00 00 8b 1c 24 c3 8d b6 00 00 
[    2.650296] EAX: ffffffda EBX: 00000007 ECX: b7f1e000 EDX: 00001000
[    2.651296] ESI: 005415d8 EDI: 0000014d EBP: 00542168 ESP: bff80924
[    2.652305] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000246
[    2.653365] Modules linked in:
[    2.653994] CR2: 00000000c1aa2000
[    2.654570] ---[ end trace af6f08788fbeeb09 ]---
[    2.655409] EIP: get_page_from_freelist+0x20a/0xb20

                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start 1495f1e4b4ee21fe5c3cdfeb68f195f426369f88 1ffaddd029c867d134a1dde39f540dcc8c52e274 --
git bisect  bad 6fb7bfa28535f092d9e239192ad5760ccae51bbd  # 12:56  B      1    12    1   1  Merge 'lpieralisi-pci/pci/mobiveil' into devel-hourly-2018080608
git bisect  bad c3c97687aae9f301dff01d6d731d28d5a4089dc2  # 13:04  B      3     4    3   3  Merge 'linux-review/Michal-Zylowski/checkpatch-Check-for-space-after-else-keyword/20180803-071308' into devel-hourly-2018080608
git bisect  bad 606460fc5ac24a48abc4e943ba611b591a8ae52f  # 13:14  B      3     2    3   3  Merge 'linux-review/Christoph-Hellwig/RISC-V-remove-timer-leftovers/20180805-005325' into devel-hourly-2018080608
git bisect  bad f826c2fec01d5b9ce223a9a3475025b1bae58d81  # 13:29  B      2     4    2   2  Merge 'linux-review/Alexandru-Gagniuc/ALSA-hda-realtek-Add-mute-LED-quirk-for-HP-Spectre-x360/20180805-172627' into devel-hourly-2018080608
git bisect  bad 7562fcc8adf6c858096077734c12dc75a9e620ac  # 13:37  B      4    11    4   4  Merge 'f2fs/dev-test' into devel-hourly-2018080608
git bisect  bad 822beb31f8617c76f773b67250d2218a85c0f6cb  # 13:55  B      9     6    9  11  Merge 'tip/master' into devel-hourly-2018080608
git bisect good 66967cf768a40c827801a067c7e7ad36b16f6bcd  # 14:11  G     18     0    0   0  Merge 'gpio/devel' into devel-hourly-2018080608
git bisect good 4ec44e4da5d00bd5199ae65e8b91511f95678bc1  # 14:23  G     17     0    0   0  Merge 'linux-review/Alexandru-Gheorghe/Add-helper-for-plane-reset/20180806-021828' into devel-hourly-2018080608
git bisect good 486ea23287dddacfc220b343a9893480f94e8c98  # 14:37  G     18     0    0   0  Merge 'linux-review/zhong-jiang/drivers-staging-Remove-some-unneeded-semicolon/20180806-064846' into devel-hourly-2018080608
git bisect good 5fc74ce12611abb08bd6245418a9d078a56731bd  # 14:54  G     18     0    0   0  Merge branch 'perf/core'
git bisect good 94570b83310087059d5cacf6a83fbc56c82d88f1  # 15:07  G     18     0    0   0  Merge branch 'x86/cache'
git bisect  bad 28a54ccb4d286b31b1759cf325731f44ef14222d  # 15:16  B      3     3    3   5  Merge branch 'x86/pti-urgent' into x86/pti
git bisect good f94560cd6b5117f8913f4c42f4d9a405c26ddc1c  # 15:28  G     18     0    0   0  x86/mm/pti: Clone CPU_ENTRY_AREA on PMD level on x86_32
git bisect good b2b7d986a89b6c94b1331a909de1217214fb08c1  # 15:45  G     18     0    0   0  x86/pti: Check the return value of pti_user_pagetable_walk_p4d()
git bisect good fdf82a7856b32d905c39afc85e34364491e46346  # 15:59  G     17     0    0   0  x86/speculation: Protect against userspace-userspace spectreRSB
git bisect good 9f515cdb411ef34f1aaf4c40bb0c932cf6db5de1  # 16:08  G     18     0    0   0  x86/mm/init: Pass unconverted symbol addresses to free_init_pages()
git bisect good 2140e26f3d98e615c60c5f6a97d8421a077d61eb  # 16:21  G     18     0    0   0  x86/mm/init: Remove freed kernel image areas from alias mapping
git bisect good 706d51681d636a0c4a5ef53395ec3b803e45ed4d  # 16:33  G     18     0    0   0  x86/speculation: Support Enhanced IBRS on future CPUs
# first bad commit: [28a54ccb4d286b31b1759cf325731f44ef14222d] Merge branch 'x86/pti-urgent' into x86/pti
git bisect good 706d51681d636a0c4a5ef53395ec3b803e45ed4d  # 16:37  G     54     0    0   0  x86/speculation: Support Enhanced IBRS on future CPUs
git bisect good 2140e26f3d98e615c60c5f6a97d8421a077d61eb  # 16:41  G     54     0    0   0  x86/mm/init: Remove freed kernel image areas from alias mapping
# extra tests with debug options
git bisect  bad 28a54ccb4d286b31b1759cf325731f44ef14222d  # 16:51  B      0     7   23   1  Merge branch 'x86/pti-urgent' into x86/pti
# extra tests on HEAD of linux-devel/devel-hourly-2018080608
git bisect  bad 1495f1e4b4ee21fe5c3cdfeb68f195f426369f88  # 16:51  B      0     7   31   6  0day head guard for 'devel-hourly-2018080608'
# extra tests on tree/branch tip/x86/pti
git bisect  bad 28a54ccb4d286b31b1759cf325731f44ef14222d  # 16:52  B      0    13   37   9  Merge branch 'x86/pti-urgent' into x86/pti
# extra tests on tree/branch tip/master
git bisect  bad 9c2c950edbfc4616a4fdfef1d43562753a7271cd  # 17:03  B      2    16    2   2  Merge branch 'x86/vdso'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/lkp                          Intel Corporation

--BXVAT5kNtrzKuDFl
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-quantal-ivb41-105:20180806151648:i386-randconfig-h1-08061152:4.18.0-rc8-00056-g28a54cc:2.gz"
Content-Transfer-Encoding: base64

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
ombxD2yLtLainQAA

--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reproduce-quantal-ivb41-105:20180806151648:i386-randconfig-h1-08061152:4.18.0-rc8-00056-g28a54cc:2"

#!/bin/bash

kernel=$1
initrd=quantal-core-i386.cgz

wget --no-clobber https://github.com/fengguang/reproduce-kernel-bug/raw/master/quantal/$initrd

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-cpu kvm64
	-kernel $kernel
	-initrd $initrd
	-m 369
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

--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-4.18.0-rc8-00056-g28a54cc"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 4.18.0-rc8 Kernel Configuration
#

#
# Compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
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
CONFIG_X86_32_SMP=y
CONFIG_X86_32_LAZY_GS=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=2
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=40904
CONFIG_CLANG_VERSION=0
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
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
CONFIG_KERNEL_LZO=y
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
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
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
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
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
# CONFIG_NO_HZ is not set
# CONFIG_HIGH_RES_TIMERS is not set

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
# CONFIG_TASKSTATS is not set
# CONFIG_CPU_ISOLATION is not set

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=32
CONFIG_RCU_FANOUT_LEAF=16
# CONFIG_RCU_FAST_NO_HZ is not set
# CONFIG_RCU_NOCB_CPU is not set
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
# CONFIG_DEBUG_BLK_CGROUP is not set
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
# CONFIG_CGROUP_RDMA is not set
# CONFIG_CGROUP_FREEZER is not set
# CONFIG_CPUSETS is not set
CONFIG_CGROUP_DEVICE=y
# CONFIG_CGROUP_CPUACCT is not set
CONFIG_CGROUP_PERF=y
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
CONFIG_RELAY=y
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
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
# CONFIG_USERFAULTFD is not set
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
# CONFIG_EMBEDDED is not set
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
# CONFIG_SLAB_MERGE_DEFAULT is not set
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
CONFIG_SLUB_CPU_PARTIAL=y
CONFIG_PROFILING=y
CONFIG_OPROFILE=y
CONFIG_OPROFILE_EVENT_MULTIPLEX=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
# CONFIG_KPROBES is not set
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
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_CLK=y
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
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_PLUGIN_HOSTCC="g++"
CONFIG_HAVE_GCC_PLUGINS=y
# CONFIG_GCC_PLUGINS is not set
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
# CONFIG_STACKPROTECTOR is not set
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
CONFIG_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_PHYS_TO_DMA=y
CONFIG_ARCH_HAS_REFCOUNT=y
# CONFIG_REFCOUNT_FULL is not set

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
CONFIG_MODULE_COMPRESS=y
CONFIG_MODULE_COMPRESS_GZIP=y
# CONFIG_MODULE_COMPRESS_XZ is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
# CONFIG_LBDAF is not set
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_DEV_THROTTLING=y
CONFIG_BLK_DEV_THROTTLING_LOW=y
CONFIG_BLK_CMDLINE_PARSER=y
CONFIG_BLK_WBT=y
CONFIG_BLK_WBT_SQ=y
CONFIG_BLK_WBT_MQ=y
# CONFIG_BLK_DEBUG_FS is not set
# CONFIG_BLK_SED_OPAL is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
CONFIG_AIX_PARTITION=y
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
# CONFIG_MINIX_SUBPARTITION is not set
CONFIG_SOLARIS_X86_PARTITION=y
# CONFIG_UNIXWARE_DISKLABEL is not set
CONFIG_LDM_PARTITION=y
# CONFIG_LDM_DEBUG is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_KARMA_PARTITION is not set
# CONFIG_EFI_PARTITION is not set
# CONFIG_SYSV68_PARTITION is not set
CONFIG_CMDLINE_PARTITION=y
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
# CONFIG_MQ_IOSCHED_DEADLINE is not set
CONFIG_MQ_IOSCHED_KYBER=m
CONFIG_IOSCHED_BFQ=y
# CONFIG_BFQ_GROUP_IOSCHED is not set
CONFIG_PADATA=y
CONFIG_ASN1=m
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
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y
CONFIG_FREEZER=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
# CONFIG_X86_MPPARSE is not set
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
# CONFIG_INTEL_RDT is not set
CONFIG_X86_BIGSMP=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_GOLDFISH is not set
CONFIG_X86_INTEL_MID=y
CONFIG_X86_INTEL_QUARK=y
CONFIG_X86_INTEL_LPSS=y
CONFIG_X86_AMD_PLATFORM_DEVICE=y
CONFIG_IOSF_MBI=y
CONFIG_IOSF_MBI_DEBUG=y
CONFIG_X86_RDC321X=y
CONFIG_X86_32_NON_STANDARD=y
CONFIG_STA2X11=y
# CONFIG_X86_32_IRIS is not set
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
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_TRANSMETA_32=y
CONFIG_HPET_TIMER=y
CONFIG_APB_TIMER=y
CONFIG_DMI=y
CONFIG_NR_CPUS_RANGE_BEGIN=2
CONFIG_NR_CPUS_RANGE_END=64
CONFIG_NR_CPUS_DEFAULT=32
CONFIG_NR_CPUS=32
# CONFIG_SCHED_SMT is not set
# CONFIG_SCHED_MC is not set
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
# CONFIG_X86_MCELOG_LEGACY is not set
# CONFIG_X86_MCE_INTEL is not set
# CONFIG_X86_MCE_AMD is not set
# CONFIG_X86_ANCIENT_MCE is not set
CONFIG_X86_MCE_INJECT=m

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
# CONFIG_PERF_EVENTS_INTEL_RAPL is not set
# CONFIG_PERF_EVENTS_INTEL_CSTATE is not set
CONFIG_PERF_EVENTS_AMD_POWER=y
# CONFIG_X86_LEGACY_VM86 is not set
CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX32=y
# CONFIG_TOSHIBA is not set
CONFIG_I8K=m
CONFIG_X86_REBOOTFIXUPS=y
CONFIG_MICROCODE=y
# CONFIG_MICROCODE_INTEL is not set
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_HIGHMEM=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
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
# CONFIG_MEMORY_HOTPLUG is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
# CONFIG_BOUNCE is not set
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
# CONFIG_CLEANCACHE is not set
CONFIG_FRONTSWAP=y
# CONFIG_CMA is not set
CONFIG_ZSWAP=y
CONFIG_ZPOOL=y
CONFIG_ZBUD=m
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=m
CONFIG_PGTABLE_MAPPING=y
CONFIG_ZSMALLOC_STAT=y
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
CONFIG_IDLE_PAGE_TRACKING=y
# CONFIG_PERCPU_STATS is not set
CONFIG_GUP_BENCHMARK=y
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# CONFIG_HIGHPTE is not set
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=y
CONFIG_X86_RESERVE_LOW=64
CONFIG_MATH_EMULATION=y
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_INTEL_UMIP=y
# CONFIG_EFI is not set
# CONFIG_SECCOMP is not set
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
# CONFIG_KEXEC is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_HOTPLUG_CPU=y
# CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
CONFIG_DEBUG_HOTPLUG_CPU0=y
CONFIG_COMPAT_VDSO=y
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
CONFIG_PM_AUTOSLEEP=y
CONFIG_PM_WAKELOCKS=y
CONFIG_PM_WAKELOCKS_LIMIT=100
CONFIG_PM_WAKELOCKS_GC=y
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_PROCFS_POWER=y
# CONFIG_ACPI_REV_OVERRIDE_POSSIBLE is not set
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_IPMI is not set
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
# CONFIG_ACPI_THERMAL is not set
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=y
CONFIG_ACPI_HED=m
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
# CONFIG_DPTF_POWER is not set
CONFIG_PMIC_OPREGION=y
# CONFIG_XPOWER_PMIC_OPREGION is not set
# CONFIG_CHT_DC_TI_PMIC_OPREGION is not set
CONFIG_ACPI_CONFIGFS=m
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y
CONFIG_X86_APM_BOOT=y
CONFIG_APM=y
CONFIG_APM_IGNORE_USER_SUSPEND=y
CONFIG_APM_DO_ENABLE=y
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
CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=m
CONFIG_CPU_FREQ_GOV_ONDEMAND=m
# CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
CONFIG_X86_PCC_CPUFREQ=y
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_SFI_CPUFREQ=m
# CONFIG_X86_POWERNOW_K6 is not set
# CONFIG_X86_POWERNOW_K7 is not set
# CONFIG_X86_POWERNOW_K8 is not set
# CONFIG_X86_AMD_FREQ_SENSITIVITY is not set
CONFIG_X86_GX_SUSPMOD=y
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_SPEEDSTEP_ICH=y
CONFIG_X86_SPEEDSTEP_SMI=m
CONFIG_X86_P4_CLOCKMOD=m
CONFIG_X86_CPUFREQ_NFORCE2=y
CONFIG_X86_LONGRUN=m
CONFIG_X86_LONGHAUL=m
CONFIG_X86_E_POWERSAVER=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=y
# CONFIG_X86_SPEEDSTEP_RELAXED_CAP_CHECK is not set

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
CONFIG_CPU_IDLE_GOV_MENU=y
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
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_STUB=y
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
# CONFIG_PCI_IOV is not set
CONFIG_PCI_PRI=y
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
# CONFIG_HOTPLUG_PCI is not set

#
# PCI controller drivers
#

#
# Cadence PCIe controllers support
#

#
# DesignWare PCI Core Support
#

#
# PCI Endpoint
#
CONFIG_PCI_ENDPOINT=y
# CONFIG_PCI_ENDPOINT_CONFIGFS is not set
CONFIG_PCI_EPF_TEST=m

#
# PCI switch controller drivers
#
CONFIG_PCI_SW_SWITCHTEC=m
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
CONFIG_SCx200=y
CONFIG_SCx200HR_TIMER=m
# CONFIG_OLPC is not set
# CONFIG_ALIX is not set
# CONFIG_NET5501 is not set
CONFIG_GEOS=y
CONFIG_AMD_NB=y
CONFIG_PCCARD=y
# CONFIG_PCMCIA is not set
# CONFIG_CARDBUS is not set

#
# PC-card bridges
#
# CONFIG_YENTA is not set
CONFIG_RAPIDIO=y
CONFIG_RAPIDIO_DISC_TIMEOUT=30
CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS=y
# CONFIG_RAPIDIO_DMA_ENGINE is not set
# CONFIG_RAPIDIO_DEBUG is not set
# CONFIG_RAPIDIO_ENUM_BASIC is not set
CONFIG_RAPIDIO_CHMAN=y
CONFIG_RAPIDIO_MPORT_CDEV=y

#
# RapidIO Switch drivers
#
CONFIG_RAPIDIO_TSI57X=m
# CONFIG_RAPIDIO_CPS_XX is not set
CONFIG_RAPIDIO_TSI568=y
CONFIG_RAPIDIO_CPS_GEN2=m
# CONFIG_RAPIDIO_RXS_GEN3 is not set
# CONFIG_X86_SYSFB is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_HAVE_AOUT=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
CONFIG_COMPAT_32=y
CONFIG_HAVE_ATOMIC_IOMAP=y
CONFIG_X86_DEV_DMA_OPS=y
CONFIG_X86_DMA_REMAP=y
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
# CONFIG_XDP_SOCKETS is not set
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
# CONFIG_NETLABEL is not set
# CONFIG_NETWORK_SECMARK is not set
CONFIG_NET_PTP_CLASSIFY=y
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_BPFILTER is not set
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
CONFIG_DNS_RESOLVER=m
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
# CONFIG_BPF_JIT is not set
# CONFIG_BPF_STREAM_PARSER is not set
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
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set

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
# CONFIG_FAILOVER is not set
CONFIG_HAVE_EBPF_JIT=y

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

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_SPMI=m
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set

#
# Bus devices
#
# CONFIG_CONNECTOR is not set
CONFIG_MTD=y
CONFIG_MTD_TESTS=m
# CONFIG_MTD_REDBOOT_PARTS is not set
# CONFIG_MTD_CMDLINE_PARTS is not set
CONFIG_MTD_AR7_PARTS=y

#
# Partition parsers
#

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=y
# CONFIG_MTD_BLOCK is not set
CONFIG_MTD_BLOCK_RO=y
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
CONFIG_INFTL=m
CONFIG_RFD_FTL=m
# CONFIG_SSFDC is not set
CONFIG_SM_FTL=y
CONFIG_MTD_OOPS=y
# CONFIG_MTD_SWAP is not set
CONFIG_MTD_PARTITIONED_MASTER=y

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_GEN_PROBE=y
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_CFI_INTELEXT=m
CONFIG_MTD_CFI_AMDSTD=y
CONFIG_MTD_CFI_STAA=m
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=m
CONFIG_MTD_ROM=y
CONFIG_MTD_ABSENT=y

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
# CONFIG_MTD_PHYSMAP is not set
# CONFIG_MTD_SCx200_DOCFLASH is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
CONFIG_MTD_PLATRAM=m

#
# Self-contained MTD device drivers
#
CONFIG_MTD_PMC551=y
# CONFIG_MTD_PMC551_BUGFIX is not set
# CONFIG_MTD_PMC551_DEBUG is not set
# CONFIG_MTD_DATAFLASH is not set
CONFIG_MTD_M25P80=m
# CONFIG_MTD_MCHP23K256 is not set
CONFIG_MTD_SST25L=y
CONFIG_MTD_SLRAM=m
# CONFIG_MTD_PHRAM is not set
CONFIG_MTD_MTDRAM=y
CONFIG_MTDRAM_TOTAL_SIZE=4096
CONFIG_MTDRAM_ERASE_SIZE=128
CONFIG_MTD_BLOCK2MTD=m

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
CONFIG_MTD_ONENAND=m
CONFIG_MTD_ONENAND_VERIFY_WRITE=y
CONFIG_MTD_ONENAND_GENERIC=m
# CONFIG_MTD_ONENAND_OTP is not set
CONFIG_MTD_ONENAND_2X_PROGRAM=y
CONFIG_MTD_NAND_ECC=y
CONFIG_MTD_NAND_ECC_SMC=y
# CONFIG_MTD_NAND is not set

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=y
CONFIG_MTD_QINFO_PROBE=y
CONFIG_MTD_SPI_NOR=m
CONFIG_MTD_MT81xx_NOR=m
# CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
CONFIG_SPI_INTEL_SPI=m
# CONFIG_SPI_INTEL_SPI_PCI is not set
CONFIG_SPI_INTEL_SPI_PLATFORM=m
# CONFIG_MTD_UBI is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
# CONFIG_PARPORT_PC is not set
CONFIG_PARPORT_AX88796=m
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
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
# CONFIG_ZRAM is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
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
# CONFIG_NVME_MULTIPATH is not set
CONFIG_NVME_FABRICS=y
CONFIG_NVME_FC=y
CONFIG_NVME_TARGET=y
# CONFIG_NVME_TARGET_LOOP is not set
CONFIG_NVME_TARGET_FC=y
CONFIG_NVME_TARGET_FCLOOP=m

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
# CONFIG_AD525X_DPOT is not set
CONFIG_DUMMY_IRQ=m
CONFIG_IBM_ASM=m
CONFIG_PHANTOM=y
CONFIG_INTEL_MID_PTI=y
CONFIG_SGI_IOC4=y
CONFIG_TIFM_CORE=y
# CONFIG_TIFM_7XX1 is not set
CONFIG_ICS932S401=y
CONFIG_ENCLOSURE_SERVICES=m
# CONFIG_CS5535_MFGPT is not set
CONFIG_HP_ILO=m
CONFIG_APDS9802ALS=y
CONFIG_ISL29003=m
CONFIG_ISL29020=y
# CONFIG_SENSORS_TSL2550 is not set
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=y
CONFIG_HMC6352=y
CONFIG_DS1682=y
# CONFIG_VMWARE_BALLOON is not set
CONFIG_PCH_PHUB=m
# CONFIG_USB_SWITCH_FSA9480 is not set
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_C2PORT=m
CONFIG_C2PORT_DURAMAR_2150=m

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
CONFIG_EEPROM_AT25=y
CONFIG_EEPROM_LEGACY=y
CONFIG_EEPROM_MAX6875=m
# CONFIG_EEPROM_93CX6 is not set
CONFIG_EEPROM_93XX46=y
# CONFIG_EEPROM_IDT_89HPESX is not set
CONFIG_CB710_CORE=y
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
CONFIG_SENSORS_LIS3_I2C=y
CONFIG_ALTERA_STAPL=y
CONFIG_INTEL_MEI=y
CONFIG_INTEL_MEI_ME=y
# CONFIG_INTEL_MEI_TXE is not set
CONFIG_VMWARE_VMCI=m

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
# CONFIG_ECHO is not set
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
# CONFIG_SCSI_MQ_DEFAULT is not set
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
# CONFIG_BLK_DEV_SD is not set
CONFIG_CHR_DEV_ST=m
CONFIG_CHR_DEV_OSST=y
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m
# CONFIG_SCSI_ENCLOSURE is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set
# CONFIG_SCSI_SCAN_ASYNC is not set

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
CONFIG_SCSI_SAS_ATTRS=y
CONFIG_SCSI_SAS_LIBSAS=y
# CONFIG_SCSI_SAS_ATA is not set
# CONFIG_SCSI_SAS_HOST_SMP is not set
# CONFIG_SCSI_SRP_ATTRS is not set
# CONFIG_SCSI_LOWLEVEL is not set
# CONFIG_SCSI_DH is not set
CONFIG_SCSI_OSD_INITIATOR=m
CONFIG_SCSI_OSD_ULD=m
CONFIG_SCSI_OSD_DPRINT_SENSE=1
# CONFIG_SCSI_OSD_DEBUG is not set
CONFIG_ATA=y
# CONFIG_ATA_VERBOSE_ERROR is not set
CONFIG_ATA_ACPI=y
CONFIG_SATA_ZPODD=y
# CONFIG_SATA_PMP is not set

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
CONFIG_SATA_SIL24=m
# CONFIG_ATA_SFF is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
# CONFIG_MD_RAID10 is not set
CONFIG_MD_RAID456=m
# CONFIG_MD_MULTIPATH is not set
CONFIG_MD_FAULTY=m
CONFIG_BCACHE=m
CONFIG_BCACHE_DEBUG=y
# CONFIG_BCACHE_CLOSURES_DEBUG is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
# CONFIG_DM_MQ_DEFAULT is not set
# CONFIG_DM_DEBUG is not set
CONFIG_DM_BUFIO=m
CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING=y
CONFIG_DM_DEBUG_BLOCK_STACK_TRACING=y
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
# CONFIG_DM_CRYPT is not set
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
CONFIG_DM_WRITECACHE=m
CONFIG_DM_ERA=m
CONFIG_DM_MIRROR=m
# CONFIG_DM_LOG_USERSPACE is not set
# CONFIG_DM_RAID is not set
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
# CONFIG_DM_MULTIPATH_ST is not set
# CONFIG_DM_DELAY is not set
# CONFIG_DM_UEVENT is not set
CONFIG_DM_FLAKEY=m
# CONFIG_DM_VERITY is not set
CONFIG_DM_SWITCH=m
# CONFIG_DM_LOG_WRITES is not set
CONFIG_DM_INTEGRITY=m
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
CONFIG_NET_VENDOR_AQUANTIA=y
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_NET_VENDOR_AURORA is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_CADENCE=y
# CONFIG_MACB is not set
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
CONFIG_NET_VENDOR_HP=y
# CONFIG_HP100 is not set
CONFIG_NET_VENDOR_HUAWEI=y
CONFIG_NET_VENDOR_I825XX=y
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
CONFIG_NET_VENDOR_EXAR=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
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
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
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
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_R8169 is not set
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
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
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
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
# CONFIG_MDIO_DEVICE is not set
# CONFIG_PHYLIB is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Host-side USB support is needed for USB Network Adapter support
#
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
CONFIG_WLAN_VENDOR_QUANTENNA=y

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
# CONFIG_WAN is not set
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_THUNDERBOLT_NET is not set
# CONFIG_NETDEVSIM is not set
# CONFIG_NET_FAILOVER is not set
# CONFIG_ISDN is not set
CONFIG_NVM=y
CONFIG_NVM_DEBUG=y
CONFIG_NVM_PBLK=y

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=m
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=y
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=y

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
CONFIG_INPUT_JOYDEV=y
# CONFIG_INPUT_EVDEV is not set
CONFIG_INPUT_EVBUG=y

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ADC=y
# CONFIG_KEYBOARD_ADP5520 is not set
CONFIG_KEYBOARD_ADP5588=m
CONFIG_KEYBOARD_ADP5589=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_QT1070=y
CONFIG_KEYBOARD_QT2160=y
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
CONFIG_KEYBOARD_GPIO=m
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
CONFIG_KEYBOARD_TCA8418=y
CONFIG_KEYBOARD_MATRIX=y
CONFIG_KEYBOARD_LM8323=y
CONFIG_KEYBOARD_LM8333=m
CONFIG_KEYBOARD_MAX7359=y
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
CONFIG_KEYBOARD_NEWTON=m
CONFIG_KEYBOARD_OPENCORES=m
CONFIG_KEYBOARD_SAMSUNG=y
# CONFIG_KEYBOARD_STOWAWAY is not set
CONFIG_KEYBOARD_SUNKBD=m
CONFIG_KEYBOARD_TM2_TOUCHKEY=y
# CONFIG_KEYBOARD_TWL4030 is not set
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_KEYBOARD_MTK_PMIC=m
# CONFIG_INPUT_MOUSE is not set
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=m
CONFIG_JOYSTICK_A3D=m
CONFIG_JOYSTICK_ADI=y
CONFIG_JOYSTICK_COBRA=m
# CONFIG_JOYSTICK_GF2K is not set
CONFIG_JOYSTICK_GRIP=y
# CONFIG_JOYSTICK_GRIP_MP is not set
CONFIG_JOYSTICK_GUILLEMOT=m
# CONFIG_JOYSTICK_INTERACT is not set
CONFIG_JOYSTICK_SIDEWINDER=y
CONFIG_JOYSTICK_TMDC=m
CONFIG_JOYSTICK_IFORCE=m
CONFIG_JOYSTICK_IFORCE_232=y
# CONFIG_JOYSTICK_WARRIOR is not set
CONFIG_JOYSTICK_MAGELLAN=y
# CONFIG_JOYSTICK_SPACEORB is not set
CONFIG_JOYSTICK_SPACEBALL=m
CONFIG_JOYSTICK_STINGER=m
CONFIG_JOYSTICK_TWIDJOY=m
# CONFIG_JOYSTICK_ZHENHUA is not set
CONFIG_JOYSTICK_DB9=m
CONFIG_JOYSTICK_GAMECON=m
# CONFIG_JOYSTICK_TURBOGRAFX is not set
CONFIG_JOYSTICK_AS5011=y
CONFIG_JOYSTICK_JOYDUMP=m
# CONFIG_JOYSTICK_XPAD is not set
CONFIG_JOYSTICK_PSXPAD_SPI=m
CONFIG_JOYSTICK_PSXPAD_SPI_FF=y
# CONFIG_JOYSTICK_PXRC is not set
CONFIG_INPUT_TABLET=y
# CONFIG_TABLET_USB_ACECAD is not set
# CONFIG_TABLET_USB_AIPTEK is not set
# CONFIG_TABLET_USB_HANWANG is not set
# CONFIG_TABLET_USB_KBTAB is not set
# CONFIG_TABLET_USB_PEGASUS is not set
# CONFIG_TABLET_SERIAL_WACOM4 is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
# CONFIG_TOUCHSCREEN_ADS7846 is not set
CONFIG_TOUCHSCREEN_AD7877=m
CONFIG_TOUCHSCREEN_AD7879=y
CONFIG_TOUCHSCREEN_AD7879_I2C=m
CONFIG_TOUCHSCREEN_AD7879_SPI=y
CONFIG_TOUCHSCREEN_ATMEL_MXT=y
CONFIG_TOUCHSCREEN_AUO_PIXCIR=y
# CONFIG_TOUCHSCREEN_BU21013 is not set
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
CONFIG_TOUCHSCREEN_CY8CTMG110=m
CONFIG_TOUCHSCREEN_CYTTSP_CORE=y
CONFIG_TOUCHSCREEN_CYTTSP_I2C=y
CONFIG_TOUCHSCREEN_CYTTSP_SPI=y
CONFIG_TOUCHSCREEN_CYTTSP4_CORE=m
# CONFIG_TOUCHSCREEN_CYTTSP4_I2C is not set
# CONFIG_TOUCHSCREEN_CYTTSP4_SPI is not set
CONFIG_TOUCHSCREEN_DA9034=y
CONFIG_TOUCHSCREEN_DA9052=m
CONFIG_TOUCHSCREEN_DYNAPRO=y
CONFIG_TOUCHSCREEN_HAMPSHIRE=m
CONFIG_TOUCHSCREEN_EETI=m
CONFIG_TOUCHSCREEN_EGALAX_SERIAL=y
CONFIG_TOUCHSCREEN_EXC3000=m
CONFIG_TOUCHSCREEN_FUJITSU=m
# CONFIG_TOUCHSCREEN_GOODIX is not set
CONFIG_TOUCHSCREEN_HIDEEP=y
CONFIG_TOUCHSCREEN_ILI210X=y
CONFIG_TOUCHSCREEN_S6SY761=y
CONFIG_TOUCHSCREEN_GUNZE=m
CONFIG_TOUCHSCREEN_EKTF2127=m
CONFIG_TOUCHSCREEN_ELAN=y
CONFIG_TOUCHSCREEN_ELO=y
CONFIG_TOUCHSCREEN_WACOM_W8001=y
CONFIG_TOUCHSCREEN_WACOM_I2C=y
CONFIG_TOUCHSCREEN_MAX11801=m
# CONFIG_TOUCHSCREEN_MCS5000 is not set
# CONFIG_TOUCHSCREEN_MMS114 is not set
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
# CONFIG_TOUCHSCREEN_MTOUCH is not set
# CONFIG_TOUCHSCREEN_INEXIO is not set
# CONFIG_TOUCHSCREEN_MK712 is not set
CONFIG_TOUCHSCREEN_PENMOUNT=m
# CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
CONFIG_TOUCHSCREEN_TOUCHWIN=m
CONFIG_TOUCHSCREEN_PIXCIR=m
# CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
CONFIG_TOUCHSCREEN_WM831X=y
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
# CONFIG_TOUCHSCREEN_MC13783 is not set
# CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
CONFIG_TOUCHSCREEN_TSC_SERIO=m
CONFIG_TOUCHSCREEN_TSC200X_CORE=y
# CONFIG_TOUCHSCREEN_TSC2004 is not set
CONFIG_TOUCHSCREEN_TSC2005=y
CONFIG_TOUCHSCREEN_TSC2007=y
CONFIG_TOUCHSCREEN_TSC2007_IIO=y
CONFIG_TOUCHSCREEN_PCAP=m
CONFIG_TOUCHSCREEN_RM_TS=m
CONFIG_TOUCHSCREEN_SILEAD=m
CONFIG_TOUCHSCREEN_SIS_I2C=m
# CONFIG_TOUCHSCREEN_ST1232 is not set
CONFIG_TOUCHSCREEN_STMFTS=y
CONFIG_TOUCHSCREEN_SURFACE3_SPI=m
# CONFIG_TOUCHSCREEN_SX8654 is not set
CONFIG_TOUCHSCREEN_TPS6507X=m
# CONFIG_TOUCHSCREEN_ZET6223 is not set
CONFIG_TOUCHSCREEN_ZFORCE=y
CONFIG_TOUCHSCREEN_ROHM_BU21023=y
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=y
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SPI=m
# CONFIG_RMI4_SMB is not set
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F55 is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=m
CONFIG_SERIO_PARKBD=m
CONFIG_SERIO_PCIPS2=y
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
# CONFIG_SERIO_ALTERA_PS2 is not set
CONFIG_SERIO_PS2MULT=y
CONFIG_SERIO_ARC_PS2=y
CONFIG_SERIO_GPIO_PS2=m
# CONFIG_USERIO is not set
CONFIG_GAMEPORT=y
CONFIG_GAMEPORT_NS558=y
CONFIG_GAMEPORT_L4=y
CONFIG_GAMEPORT_EMU10K1=y
CONFIG_GAMEPORT_FM801=m

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
CONFIG_NOZOMI=m
# CONFIG_N_GSM is not set
CONFIG_TRACE_ROUTER=m
CONFIG_TRACE_SINK=m
# CONFIG_DEVMEM is not set
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
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
# CONFIG_SERIAL_8250_MANY_PORTS is not set
# CONFIG_SERIAL_8250_SHARE_IRQ is not set
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
# CONFIG_SERIAL_8250_RSA is not set
CONFIG_SERIAL_8250_DW=y
CONFIG_SERIAL_8250_RT288X=y
CONFIG_SERIAL_8250_LPSS=m
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_MOXA=y

#
# Non-8250 serial port support
#
CONFIG_SERIAL_MAX3100=m
CONFIG_SERIAL_MAX310X=m
CONFIG_SERIAL_UARTLITE=m
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=y
CONFIG_SERIAL_SCCNXP=m
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_TIMBERDALE is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
CONFIG_SERIAL_ALTERA_UART=y
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
# CONFIG_SERIAL_ALTERA_UART_CONSOLE is not set
# CONFIG_SERIAL_IFX6X60 is not set
# CONFIG_SERIAL_PCH_UART is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_DEV_BUS is not set
CONFIG_PRINTER=m
CONFIG_LP_CONSOLE=y
CONFIG_PPDEV=m
CONFIG_HVC_DRIVER=y
CONFIG_VIRTIO_CONSOLE=m
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PANIC_EVENT=y
# CONFIG_IPMI_PANIC_STRING is not set
# CONFIG_IPMI_DEVICE_INTERFACE is not set
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
# CONFIG_HW_RANDOM is not set
CONFIG_NVRAM=m
# CONFIG_R3964 is not set
CONFIG_APPLICOM=y
# CONFIG_SONYPI is not set
CONFIG_MWAVE=y
CONFIG_SCx200_GPIO=y
# CONFIG_PC8736x_GPIO is not set
CONFIG_NSC_GPIO=y
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=256
CONFIG_HPET=y
# CONFIG_HPET_MMAP is not set
CONFIG_HANGCHECK_TIMER=y
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set
# CONFIG_DEVPORT is not set
CONFIG_XILLYBUS=m

#
# I2C support
#
CONFIG_I2C=y
# CONFIG_ACPI_I2C_OPREGION is not set
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
# CONFIG_I2C_MUX is not set
# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ALGOPCA=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_ALI1535=y
CONFIG_I2C_ALI1563=y
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=y
# CONFIG_I2C_AMD756_S4882 is not set
CONFIG_I2C_AMD8111=y
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
# CONFIG_I2C_PIIX4 is not set
CONFIG_I2C_NFORCE2=y
# CONFIG_I2C_NFORCE2_S4985 is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=y
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=y
# CONFIG_I2C_DESIGNWARE_PLATFORM is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
CONFIG_I2C_EG20T=m
CONFIG_I2C_EMEV2=y
# CONFIG_I2C_GPIO is not set
CONFIG_I2C_KEMPLD=m
CONFIG_I2C_OCORES=y
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=y
CONFIG_I2C_XILINX=m

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_PARPORT is not set
CONFIG_I2C_PARPORT_LIGHT=y
CONFIG_I2C_TAOS_EVM=m

#
# Other I2C/SMBus bus drivers
#
CONFIG_SCx200_ACB=m
CONFIG_I2C_STUB=m
CONFIG_I2C_SLAVE=y
# CONFIG_I2C_SLAVE_EEPROM is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
CONFIG_SPI_MEM=y

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
CONFIG_SPI_AXI_SPI_ENGINE=y
CONFIG_SPI_BITBANG=y
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
CONFIG_SPI_DESIGNWARE=m
# CONFIG_SPI_DW_PCI is not set
# CONFIG_SPI_DW_MMIO is not set
CONFIG_SPI_GPIO=m
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
CONFIG_SPI_SC18IS602=m
CONFIG_SPI_TOPCLIFF_PCH=y
CONFIG_SPI_XCOMM=m
CONFIG_SPI_XILINX=y
CONFIG_SPI_ZYNQMP_GQSPI=m

#
# SPI Protocol Masters
#
CONFIG_SPI_SPIDEV=y
CONFIG_SPI_LOOPBACK_TEST=m
CONFIG_SPI_TLE62X0=y
# CONFIG_SPI_SLAVE is not set
CONFIG_SPMI=y
CONFIG_HSI=m
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

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=y
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

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
CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=y
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_BAYTRAIL=y
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_MERRIFIELD is not set
CONFIG_PINCTRL_INTEL=y
CONFIG_PINCTRL_BROXTON=m
CONFIG_PINCTRL_CANNONLAKE=y
CONFIG_PINCTRL_CEDARFORK=m
# CONFIG_PINCTRL_DENVERTON is not set
CONFIG_PINCTRL_GEMINILAKE=m
CONFIG_PINCTRL_LEWISBURG=m
CONFIG_PINCTRL_SUNRISEPOINT=y
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
# CONFIG_GPIO_SYSFS is not set
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_AMDPT=y
# CONFIG_GPIO_DWAPB is not set
CONFIG_GPIO_EXAR=m
CONFIG_GPIO_GENERIC_PLATFORM=m
CONFIG_GPIO_ICH=y
CONFIG_GPIO_LYNXPOINT=y
CONFIG_GPIO_MB86S7X=y
# CONFIG_GPIO_MOCKUP is not set
CONFIG_GPIO_STA2X11=y
CONFIG_GPIO_VX855=y

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_F7188X=m
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
CONFIG_GPIO_WINBOND=m
CONFIG_GPIO_WS16C48=m

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
CONFIG_GPIO_MAX7300=y
CONFIG_GPIO_MAX732X=m
# CONFIG_GPIO_PCA953X is not set
CONFIG_GPIO_PCF857X=m
# CONFIG_GPIO_TPIC2810 is not set

#
# MFD GPIO expanders
#
CONFIG_GPIO_ADP5520=m
CONFIG_GPIO_ARIZONA=m
# CONFIG_GPIO_CS5535 is not set
CONFIG_GPIO_DA9052=y
CONFIG_GPIO_DA9055=y
CONFIG_GPIO_JANZ_TTL=m
CONFIG_GPIO_KEMPLD=m
# CONFIG_GPIO_LP3943 is not set
CONFIG_GPIO_LP873X=m
# CONFIG_GPIO_MSIC is not set
CONFIG_GPIO_TPS6586X=y
CONFIG_GPIO_TPS65912=m
CONFIG_GPIO_TWL4030=y
# CONFIG_GPIO_TWL6040 is not set
# CONFIG_GPIO_WM831X is not set
CONFIG_GPIO_WM8994=m

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
CONFIG_GPIO_INTEL_MID=y
# CONFIG_GPIO_MERRIFIELD is not set
CONFIG_GPIO_ML_IOH=y
# CONFIG_GPIO_PCH is not set
CONFIG_GPIO_PCI_IDIO_16=y
CONFIG_GPIO_PCIE_IDIO_24=y
# CONFIG_GPIO_RDC321X is not set

#
# SPI GPIO expanders
#
CONFIG_GPIO_MAX3191X=m
CONFIG_GPIO_MAX7301=y
CONFIG_GPIO_MC33880=y
CONFIG_GPIO_PISOSR=m
CONFIG_GPIO_XRA1403=m
CONFIG_W1=m

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_MATROX=m
CONFIG_W1_MASTER_DS2482=m
# CONFIG_W1_MASTER_DS1WM is not set
CONFIG_W1_MASTER_GPIO=m

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=m
CONFIG_W1_SLAVE_SMEM=m
# CONFIG_W1_SLAVE_DS2405 is not set
CONFIG_W1_SLAVE_DS2408=m
# CONFIG_W1_SLAVE_DS2408_READBACK is not set
CONFIG_W1_SLAVE_DS2413=m
# CONFIG_W1_SLAVE_DS2406 is not set
# CONFIG_W1_SLAVE_DS2423 is not set
# CONFIG_W1_SLAVE_DS2805 is not set
# CONFIG_W1_SLAVE_DS2431 is not set
# CONFIG_W1_SLAVE_DS2433 is not set
CONFIG_W1_SLAVE_DS2438=m
CONFIG_W1_SLAVE_DS2760=m
CONFIG_W1_SLAVE_DS2780=m
CONFIG_W1_SLAVE_DS2781=m
CONFIG_W1_SLAVE_DS28E04=m
CONFIG_W1_SLAVE_DS28E17=m
# CONFIG_POWER_AVS is not set
# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_PDA_POWER=m
CONFIG_GENERIC_ADC_BATTERY=y
CONFIG_WM831X_BACKUP=y
CONFIG_WM831X_POWER=m
# CONFIG_TEST_POWER is not set
# CONFIG_BATTERY_DS2760 is not set
CONFIG_BATTERY_DS2780=m
CONFIG_BATTERY_DS2781=m
CONFIG_BATTERY_DS2782=m
CONFIG_BATTERY_SBS=y
CONFIG_CHARGER_SBS=y
CONFIG_BATTERY_BQ27XXX=y
# CONFIG_BATTERY_BQ27XXX_I2C is not set
CONFIG_BATTERY_BQ27XXX_HDQ=m
CONFIG_BATTERY_DA9030=y
CONFIG_BATTERY_DA9052=m
# CONFIG_AXP20X_POWER is not set
# CONFIG_AXP288_FUEL_GAUGE is not set
CONFIG_BATTERY_MAX17040=y
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_BATTERY_MAX1721X is not set
CONFIG_BATTERY_TWL4030_MADC=y
# CONFIG_CHARGER_PCF50633 is not set
# CONFIG_BATTERY_RX51 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_TWL4030 is not set
CONFIG_CHARGER_LP8727=y
# CONFIG_CHARGER_LP8788 is not set
CONFIG_CHARGER_GPIO=m
CONFIG_CHARGER_MANAGER=y
CONFIG_CHARGER_LTC3651=m
CONFIG_CHARGER_MAX14577=y
CONFIG_CHARGER_MAX77693=m
# CONFIG_CHARGER_MAX8997 is not set
# CONFIG_CHARGER_MAX8998 is not set
CONFIG_CHARGER_BQ2415X=m
# CONFIG_CHARGER_BQ24190 is not set
CONFIG_CHARGER_BQ24257=y
CONFIG_CHARGER_BQ24735=y
CONFIG_CHARGER_BQ25890=y
# CONFIG_CHARGER_SMB347 is not set
# CONFIG_CHARGER_TPS65090 is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_CHARGER_RT9455 is not set
CONFIG_HWMON=m
CONFIG_HWMON_VID=m
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
# CONFIG_SENSORS_ABITUGURU is not set
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
# CONFIG_SENSORS_AD7414 is not set
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
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
CONFIG_SENSORS_K8TEMP=m
# CONFIG_SENSORS_K10TEMP is not set
# CONFIG_SENSORS_FAM15H_POWER is not set
# CONFIG_SENSORS_APPLESMC is not set
CONFIG_SENSORS_ASB100=m
CONFIG_SENSORS_ASPEED=m
CONFIG_SENSORS_ATXP1=m
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=m
# CONFIG_SENSORS_DA9052_ADC is not set
CONFIG_SENSORS_DA9055=m
CONFIG_SENSORS_I5K_AMB=m
# CONFIG_SENSORS_F71805F is not set
CONFIG_SENSORS_F71882FG=m
# CONFIG_SENSORS_F75375S is not set
CONFIG_SENSORS_MC13783_ADC=m
CONFIG_SENSORS_FSCHMD=m
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
# CONFIG_SENSORS_G760A is not set
# CONFIG_SENSORS_G762 is not set
CONFIG_SENSORS_HIH6130=m
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_IIO_HWMON=m
CONFIG_SENSORS_I5500=m
# CONFIG_SENSORS_CORETEMP is not set
# CONFIG_SENSORS_IT87 is not set
CONFIG_SENSORS_JC42=m
CONFIG_SENSORS_POWR1220=m
# CONFIG_SENSORS_LINEAGE is not set
CONFIG_SENSORS_LTC2945=m
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC4151 is not set
# CONFIG_SENSORS_LTC4215 is not set
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
CONFIG_SENSORS_LTC4260=m
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
CONFIG_SENSORS_MAX31722=m
CONFIG_SENSORS_MAX6621=m
# CONFIG_SENSORS_MAX6639 is not set
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
CONFIG_SENSORS_MAX31790=m
# CONFIG_SENSORS_MCP3021 is not set
CONFIG_SENSORS_TC654=m
# CONFIG_SENSORS_MENF21BMC_HWMON is not set
CONFIG_SENSORS_ADCXX=m
# CONFIG_SENSORS_LM63 is not set
# CONFIG_SENSORS_LM70 is not set
# CONFIG_SENSORS_LM73 is not set
CONFIG_SENSORS_LM75=m
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
# CONFIG_SENSORS_LM95234 is not set
# CONFIG_SENSORS_LM95241 is not set
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NTC_THERMISTOR=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=m
CONFIG_SENSORS_NCT7802=m
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_PCF8591 is not set
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_IBM_CFFPS is not set
CONFIG_SENSORS_IR35221=m
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC2978_REGULATOR is not set
CONFIG_SENSORS_LTC3815=m
CONFIG_SENSORS_MAX16064=m
CONFIG_SENSORS_MAX20751=m
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
# CONFIG_SENSORS_MAX8688 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
# CONFIG_SENSORS_UCD9000 is not set
CONFIG_SENSORS_UCD9200=m
# CONFIG_SENSORS_ZL6100 is not set
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
CONFIG_SENSORS_SHT3x=m
CONFIG_SENSORS_SHTC1=m
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
# CONFIG_SENSORS_EMC1403 is not set
# CONFIG_SENSORS_EMC2103 is not set
# CONFIG_SENSORS_EMC6W201 is not set
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_STTS751=m
# CONFIG_SENSORS_SMM665 is not set
CONFIG_SENSORS_ADC128D818=m
CONFIG_SENSORS_ADS1015=m
CONFIG_SENSORS_ADS7828=m
CONFIG_SENSORS_ADS7871=m
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
CONFIG_SENSORS_INA3221=m
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
CONFIG_SENSORS_VIA_CPUTEMP=m
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
CONFIG_SENSORS_W83773G=m
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
# CONFIG_SENSORS_W83792D is not set
CONFIG_SENSORS_W83793=m
# CONFIG_SENSORS_W83795 is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_WM831X is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
CONFIG_THERMAL=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
# CONFIG_THERMAL_WRITABLE_TRIPS is not set
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
# CONFIG_THERMAL_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
CONFIG_THERMAL_EMULATION=y
CONFIG_INTEL_POWERCLAMP=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set
CONFIG_INTEL_QUARK_DTS_THERMAL=m

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# CONFIG_INTEL_PCH_THERMAL is not set
CONFIG_GENERIC_ADC_THERMAL=y
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
# CONFIG_BCMA_HOST_PCI is not set
CONFIG_BCMA_HOST_SOC=y
# CONFIG_BCMA_DRIVER_PCI is not set
# CONFIG_BCMA_SFLASH is not set
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
CONFIG_BCMA_DEBUG=y

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_CS5535=m
CONFIG_MFD_AS3711=y
CONFIG_PMIC_ADP5520=y
# CONFIG_MFD_AAT2870_CORE is not set
CONFIG_MFD_BCM590XX=y
# CONFIG_MFD_BD9571MWV is not set
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
# CONFIG_MFD_CROS_EC is not set
CONFIG_PMIC_DA903X=y
CONFIG_PMIC_DA9052=y
# CONFIG_MFD_DA9052_SPI is not set
CONFIG_MFD_DA9052_I2C=y
CONFIG_MFD_DA9055=y
CONFIG_MFD_DA9062=m
CONFIG_MFD_DA9063=m
# CONFIG_MFD_DA9150 is not set
CONFIG_MFD_MC13XXX=m
CONFIG_MFD_MC13XXX_SPI=m
CONFIG_MFD_MC13XXX_I2C=m
# CONFIG_HTC_PASIC3 is not set
CONFIG_HTC_I2CPLD=y
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=y
# CONFIG_INTEL_SOC_PMIC is not set
# CONFIG_INTEL_SOC_PMIC_BXTWC is not set
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
CONFIG_INTEL_SOC_PMIC_CHTDC_TI=y
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=m
CONFIG_MFD_INTEL_LPSS_PCI=y
CONFIG_MFD_INTEL_MSIC=y
CONFIG_MFD_JANZ_CMODIO=m
CONFIG_MFD_KEMPLD=m
CONFIG_MFD_88PM800=m
CONFIG_MFD_88PM805=y
# CONFIG_MFD_88PM860X is not set
CONFIG_MFD_MAX14577=y
CONFIG_MFD_MAX77693=m
CONFIG_MFD_MAX77843=y
CONFIG_MFD_MAX8907=m
# CONFIG_MFD_MAX8925 is not set
CONFIG_MFD_MAX8997=y
CONFIG_MFD_MAX8998=y
CONFIG_MFD_MT6397=m
CONFIG_MFD_MENF21BMC=y
CONFIG_EZX_PCAP=y
# CONFIG_MFD_RETU is not set
CONFIG_MFD_PCF50633=m
CONFIG_PCF50633_ADC=m
CONFIG_PCF50633_GPIO=m
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SEC_CORE is not set
CONFIG_MFD_SI476X_CORE=y
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
CONFIG_MFD_SKY81452=m
CONFIG_MFD_SMSC=y
CONFIG_ABX500_CORE=y
CONFIG_AB3100_CORE=y
CONFIG_AB3100_OTP=m
CONFIG_MFD_STA2X11=y
CONFIG_MFD_SYSCON=y
# CONFIG_MFD_TI_AM335X_TSCADC is not set
CONFIG_MFD_LP3943=m
CONFIG_MFD_LP8788=y
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
CONFIG_TPS6105X=y
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
CONFIG_MFD_TPS65090=y
# CONFIG_MFD_TPS68470 is not set
CONFIG_MFD_TI_LP873X=y
CONFIG_MFD_TPS6586X=y
# CONFIG_MFD_TPS65910 is not set
CONFIG_MFD_TPS65912=m
CONFIG_MFD_TPS65912_I2C=m
CONFIG_MFD_TPS65912_SPI=m
# CONFIG_MFD_TPS80031 is not set
CONFIG_TWL4030_CORE=y
CONFIG_MFD_TWL4030_AUDIO=y
CONFIG_TWL6040_CORE=y
CONFIG_MFD_WL1273_CORE=m
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TIMBERDALE is not set
CONFIG_MFD_VX855=y
CONFIG_MFD_ARIZONA=y
# CONFIG_MFD_ARIZONA_I2C is not set
CONFIG_MFD_ARIZONA_SPI=y
CONFIG_MFD_CS47L24=y
CONFIG_MFD_WM5102=y
CONFIG_MFD_WM5110=y
CONFIG_MFD_WM8997=y
# CONFIG_MFD_WM8998 is not set
# CONFIG_MFD_WM8400 is not set
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
CONFIG_MFD_WM8994=m
CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
# CONFIG_REGULATOR_88PG86X is not set
CONFIG_REGULATOR_88PM800=m
CONFIG_REGULATOR_ACT8865=m
CONFIG_REGULATOR_AD5398=y
CONFIG_REGULATOR_ANATOP=m
# CONFIG_REGULATOR_AB3100 is not set
# CONFIG_REGULATOR_AS3711 is not set
CONFIG_REGULATOR_AXP20X=y
CONFIG_REGULATOR_BCM590XX=m
CONFIG_REGULATOR_DA903X=m
CONFIG_REGULATOR_DA9052=y
# CONFIG_REGULATOR_DA9055 is not set
CONFIG_REGULATOR_DA9062=m
CONFIG_REGULATOR_DA9063=m
# CONFIG_REGULATOR_DA9210 is not set
CONFIG_REGULATOR_DA9211=y
CONFIG_REGULATOR_FAN53555=m
# CONFIG_REGULATOR_GPIO is not set
CONFIG_REGULATOR_ISL9305=m
# CONFIG_REGULATOR_ISL6271A is not set
# CONFIG_REGULATOR_LP3971 is not set
CONFIG_REGULATOR_LP3972=m
# CONFIG_REGULATOR_LP872X is not set
# CONFIG_REGULATOR_LP8755 is not set
# CONFIG_REGULATOR_LP8788 is not set
# CONFIG_REGULATOR_LTC3589 is not set
CONFIG_REGULATOR_LTC3676=m
CONFIG_REGULATOR_MAX14577=y
CONFIG_REGULATOR_MAX1586=y
# CONFIG_REGULATOR_MAX8649 is not set
CONFIG_REGULATOR_MAX8660=m
CONFIG_REGULATOR_MAX8907=m
CONFIG_REGULATOR_MAX8952=y
CONFIG_REGULATOR_MAX8997=m
CONFIG_REGULATOR_MAX8998=y
CONFIG_REGULATOR_MAX77693=m
CONFIG_REGULATOR_MC13XXX_CORE=m
CONFIG_REGULATOR_MC13783=m
# CONFIG_REGULATOR_MC13892 is not set
CONFIG_REGULATOR_MT6311=y
CONFIG_REGULATOR_MT6323=m
CONFIG_REGULATOR_MT6397=m
CONFIG_REGULATOR_PCAP=m
CONFIG_REGULATOR_PCF50633=m
CONFIG_REGULATOR_PFUZE100=m
CONFIG_REGULATOR_PV88060=y
CONFIG_REGULATOR_PV88080=y
# CONFIG_REGULATOR_PV88090 is not set
# CONFIG_REGULATOR_QCOM_SPMI is not set
CONFIG_REGULATOR_SKY81452=m
# CONFIG_REGULATOR_TPS51632 is not set
CONFIG_REGULATOR_TPS6105X=y
CONFIG_REGULATOR_TPS62360=y
CONFIG_REGULATOR_TPS65023=y
# CONFIG_REGULATOR_TPS6507X is not set
CONFIG_REGULATOR_TPS65090=y
CONFIG_REGULATOR_TPS65132=y
CONFIG_REGULATOR_TPS6524X=y
# CONFIG_REGULATOR_TPS6586X is not set
CONFIG_REGULATOR_TPS65912=m
CONFIG_REGULATOR_TWL4030=y
CONFIG_REGULATOR_WM831X=y
CONFIG_REGULATOR_WM8994=m
CONFIG_RC_CORE=y
# CONFIG_RC_MAP is not set
# CONFIG_LIRC is not set
# CONFIG_RC_DECODERS is not set
# CONFIG_RC_DEVICES is not set
# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
CONFIG_AGP=m
# CONFIG_AGP_ALI is not set
CONFIG_AGP_ATI=m
CONFIG_AGP_AMD=m
CONFIG_AGP_AMD64=m
CONFIG_AGP_INTEL=m
# CONFIG_AGP_NVIDIA is not set
CONFIG_AGP_SIS=m
# CONFIG_AGP_SWORKS is not set
CONFIG_AGP_VIA=m
CONFIG_AGP_EFFICEON=m
CONFIG_INTEL_GTT=m
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DEBUG_SELFTEST is not set
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_TTM=m
CONFIG_DRM_VM=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
CONFIG_DRM_I2C_NXP_TDA998X=m
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
CONFIG_DRM_RADEON=m
CONFIG_DRM_RADEON_USERPTR=y
# CONFIG_DRM_AMDGPU is not set

#
# ACP (Audio CoProcessor) Configuration
#

#
# AMD Library routines
#
CONFIG_DRM_NOUVEAU=m
CONFIG_NOUVEAU_DEBUG=5
CONFIG_NOUVEAU_DEBUG_DEFAULT=3
CONFIG_NOUVEAU_DEBUG_MMU=y
CONFIG_DRM_NOUVEAU_BACKLIGHT=y
CONFIG_DRM_I915=m
# CONFIG_DRM_I915_ALPHA_SUPPORT is not set
CONFIG_DRM_I915_CAPTURE_ERROR=y
# CONFIG_DRM_I915_COMPRESS_ERROR is not set
CONFIG_DRM_I915_USERPTR=y
CONFIG_DRM_VGEM=m
CONFIG_DRM_VMWGFX=m
# CONFIG_DRM_VMWGFX_FBCON is not set
# CONFIG_DRM_GMA500 is not set
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
# CONFIG_DRM_CIRRUS_QEMU is not set
CONFIG_DRM_QXL=m
# CONFIG_DRM_BOCHS is not set
# CONFIG_DRM_VIRTIO_GPU is not set
CONFIG_DRM_PANEL=y

#
# Display Panels
#
CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=m
CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
CONFIG_DRM_ANALOGIX_ANX78XX=m
CONFIG_DRM_HISI_HIBMC=m
# CONFIG_DRM_TINYDRM is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=m

#
# Frame buffer Devices
#
CONFIG_FB=y
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB_DDC=m
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
CONFIG_FB_FOREIGN_ENDIAN=y
# CONFIG_FB_BOTH_ENDIAN is not set
# CONFIG_FB_BIG_ENDIAN is not set
CONFIG_FB_LITTLE_ENDIAN=y
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_HECUBA=y
CONFIG_FB_SVGALIB=m
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
CONFIG_FB_PM2=m
# CONFIG_FB_PM2_FIFO_DISCONNECT is not set
CONFIG_FB_CYBER2000=m
CONFIG_FB_CYBER2000_DDC=y
CONFIG_FB_ARC=y
CONFIG_FB_ASILIANT=y
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
CONFIG_FB_N411=y
CONFIG_FB_HGA=m
CONFIG_FB_OPENCORES=m
CONFIG_FB_S1D13XXX=y
CONFIG_FB_NVIDIA=m
# CONFIG_FB_NVIDIA_I2C is not set
# CONFIG_FB_NVIDIA_DEBUG is not set
# CONFIG_FB_NVIDIA_BACKLIGHT is not set
# CONFIG_FB_RIVA is not set
CONFIG_FB_I740=m
CONFIG_FB_I810=m
CONFIG_FB_I810_GTF=y
CONFIG_FB_I810_I2C=y
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
CONFIG_FB_RADEON=m
# CONFIG_FB_RADEON_I2C is not set
CONFIG_FB_RADEON_BACKLIGHT=y
CONFIG_FB_RADEON_DEBUG=y
CONFIG_FB_ATY128=y
# CONFIG_FB_ATY128_BACKLIGHT is not set
# CONFIG_FB_ATY is not set
CONFIG_FB_S3=m
# CONFIG_FB_S3_DDC is not set
CONFIG_FB_SAVAGE=y
# CONFIG_FB_SAVAGE_I2C is not set
CONFIG_FB_SAVAGE_ACCEL=y
# CONFIG_FB_SIS is not set
CONFIG_FB_VIA=m
CONFIG_FB_VIA_DIRECT_PROCFS=y
CONFIG_FB_VIA_X_COMPATIBILITY=y
CONFIG_FB_NEOMAGIC=y
# CONFIG_FB_KYRO is not set
CONFIG_FB_3DFX=m
CONFIG_FB_3DFX_ACCEL=y
# CONFIG_FB_3DFX_I2C is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
CONFIG_FB_CARMINE=y
CONFIG_FB_CARMINE_DRAM_EVAL=y
# CONFIG_CARMINE_DRAM_CUSTOM is not set
# CONFIG_FB_GEODE is not set
# CONFIG_FB_SM501 is not set
CONFIG_FB_IBM_GXT4500=y
# CONFIG_FB_VIRTUAL is not set
CONFIG_FB_METRONOME=y
CONFIG_FB_MB862XX=y
CONFIG_FB_MB862XX_PCI_GDC=y
# CONFIG_FB_MB862XX_I2C is not set
# CONFIG_FB_BROADSHEET is not set
CONFIG_FB_SIMPLE=y
# CONFIG_FB_SM712 is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_LCD_CLASS_DEVICE=y
CONFIG_LCD_L4F00242T03=m
CONFIG_LCD_LMS283GF05=y
CONFIG_LCD_LTV350QV=m
CONFIG_LCD_ILI922X=m
CONFIG_LCD_ILI9320=y
# CONFIG_LCD_TDO24M is not set
CONFIG_LCD_VGG2432A4=y
# CONFIG_LCD_PLATFORM is not set
# CONFIG_LCD_S6E63M0 is not set
CONFIG_LCD_LD9040=m
# CONFIG_LCD_AMS369FG06 is not set
CONFIG_LCD_LMS501KF03=y
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_GENERIC=y
CONFIG_BACKLIGHT_DA903X=m
CONFIG_BACKLIGHT_DA9052=m
CONFIG_BACKLIGHT_APPLE=y
CONFIG_BACKLIGHT_PM8941_WLED=m
# CONFIG_BACKLIGHT_SAHARA is not set
CONFIG_BACKLIGHT_WM831X=y
CONFIG_BACKLIGHT_ADP5520=y
CONFIG_BACKLIGHT_ADP8860=y
CONFIG_BACKLIGHT_ADP8870=m
CONFIG_BACKLIGHT_PCF50633=m
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_PANDORA=m
# CONFIG_BACKLIGHT_SKY81452 is not set
CONFIG_BACKLIGHT_AS3711=m
CONFIG_BACKLIGHT_GPIO=y
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
CONFIG_BACKLIGHT_ARCXCNN=y
CONFIG_VGASTATE=y
CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_VGACON_SOFT_SCROLLBACK is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y
CONFIG_SOUND=y
# CONFIG_SND is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
# CONFIG_HIDRAW is not set
CONFIG_UHID=m
CONFIG_HID_GENERIC=m

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
CONFIG_HID_ACRUX=y
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=m
# CONFIG_HID_ASUS is not set
CONFIG_HID_AUREAL=y
# CONFIG_HID_BELKIN is not set
# CONFIG_HID_CHERRY is not set
CONFIG_HID_CHICONY=m
CONFIG_HID_CMEDIA=y
CONFIG_HID_CYPRESS=m
# CONFIG_HID_DRAGONRISE is not set
CONFIG_HID_EMS_FF=y
CONFIG_HID_ELECOM=y
CONFIG_HID_EZKEY=y
# CONFIG_HID_GEMBIRD is not set
CONFIG_HID_GFRM=y
CONFIG_HID_KEYTOUCH=m
# CONFIG_HID_KYE is not set
# CONFIG_HID_WALTOP is not set
# CONFIG_HID_GYRATION is not set
# CONFIG_HID_ICADE is not set
# CONFIG_HID_ITE is not set
CONFIG_HID_JABRA=y
# CONFIG_HID_TWINHAN is not set
CONFIG_HID_KENSINGTON=y
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=y
# CONFIG_HID_LENOVO is not set
# CONFIG_HID_LOGITECH is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MAYFLASH is not set
CONFIG_HID_REDRAGON=m
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=y
CONFIG_HID_NTI=m
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
CONFIG_PANTHERLORD_FF=y
CONFIG_HID_PETALYNX=y
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PRIMAX=y
# CONFIG_HID_SAITEK is not set
CONFIG_HID_SAMSUNG=y
CONFIG_HID_SPEEDLINK=y
CONFIG_HID_STEAM=m
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=y
# CONFIG_HID_GREENASIA is not set
# CONFIG_HID_SMARTJOYPLUS is not set
# CONFIG_HID_TIVO is not set
CONFIG_HID_TOPSEED=m
# CONFIG_HID_THINGM is not set
CONFIG_HID_THRUSTMASTER=m
CONFIG_THRUSTMASTER_FF=y
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_WIIMOTE is not set
CONFIG_HID_XINMO=y
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
# CONFIG_HID_ZYDACRON is not set
CONFIG_HID_SENSOR_HUB=m
# CONFIG_HID_SENSOR_CUSTOM_SENSOR is not set
# CONFIG_HID_ALPS is not set

#
# I2C HID support
#
CONFIG_I2C_HID=y
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
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_UWB is not set
# CONFIG_MMC is not set
CONFIG_MEMSTICK=y
CONFIG_MEMSTICK_DEBUG=y

#
# MemoryStick drivers
#
CONFIG_MEMSTICK_UNSAFE_RESUME=y
CONFIG_MSPRO_BLOCK=y
CONFIG_MS_BLOCK=y

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=m
CONFIG_MEMSTICK_JMICRON_38X=m
CONFIG_MEMSTICK_R592=m
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
CONFIG_LEDS_APU=y
CONFIG_LEDS_LM3530=m
CONFIG_LEDS_LM3642=m
CONFIG_LEDS_MT6323=m
# CONFIG_LEDS_NET48XX is not set
# CONFIG_LEDS_WRAP is not set
CONFIG_LEDS_PCA9532=m
CONFIG_LEDS_PCA9532_GPIO=y
CONFIG_LEDS_GPIO=m
CONFIG_LEDS_LP3944=y
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP55XX_COMMON=y
# CONFIG_LEDS_LP5521 is not set
CONFIG_LEDS_LP5523=m
CONFIG_LEDS_LP5562=y
# CONFIG_LEDS_LP8501 is not set
CONFIG_LEDS_LP8788=y
CONFIG_LEDS_CLEVO_MAIL=y
CONFIG_LEDS_PCA955X=m
CONFIG_LEDS_PCA955X_GPIO=y
CONFIG_LEDS_PCA963X=m
CONFIG_LEDS_WM831X_STATUS=y
# CONFIG_LEDS_DA903X is not set
CONFIG_LEDS_DA9052=m
# CONFIG_LEDS_DAC124S085 is not set
CONFIG_LEDS_REGULATOR=m
CONFIG_LEDS_BD2802=y
CONFIG_LEDS_INTEL_SS4200=m
CONFIG_LEDS_LT3593=m
# CONFIG_LEDS_ADP5520 is not set
CONFIG_LEDS_MC13783=m
# CONFIG_LEDS_TCA6507 is not set
CONFIG_LEDS_TLC591XX=m
CONFIG_LEDS_MAX8997=y
CONFIG_LEDS_LM355x=m
# CONFIG_LEDS_OT200 is not set
CONFIG_LEDS_MENF21BMC=m

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
CONFIG_LEDS_MLXCPLD=y
CONFIG_LEDS_MLXREG=m
CONFIG_LEDS_USER=y
CONFIG_LEDS_NIC78BX=m

#
# LED Triggers
#
# CONFIG_LEDS_TRIGGERS is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
# CONFIG_RTC_HCTOSYS is not set
CONFIG_RTC_SYSTOHC=y
CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
CONFIG_RTC_DEBUG=y
# CONFIG_RTC_NVMEM is not set

#
# RTC interfaces
#
# CONFIG_RTC_INTF_SYSFS is not set
CONFIG_RTC_INTF_PROC=y
# CONFIG_RTC_INTF_DEV is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_88PM80X is not set
CONFIG_RTC_DRV_ABB5ZES3=y
CONFIG_RTC_DRV_ABX80X=y
CONFIG_RTC_DRV_DS1307=m
CONFIG_RTC_DRV_DS1307_HWMON=y
CONFIG_RTC_DRV_DS1307_CENTURY=y
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
# CONFIG_RTC_DRV_DS1672 is not set
CONFIG_RTC_DRV_LP8788=y
CONFIG_RTC_DRV_MAX6900=m
# CONFIG_RTC_DRV_MAX8907 is not set
# CONFIG_RTC_DRV_MAX8998 is not set
CONFIG_RTC_DRV_MAX8997=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
# CONFIG_RTC_DRV_X1205 is not set
CONFIG_RTC_DRV_PCF8523=m
CONFIG_RTC_DRV_PCF85063=m
CONFIG_RTC_DRV_PCF85363=m
CONFIG_RTC_DRV_PCF8563=y
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=y
CONFIG_RTC_DRV_M41T80_WDT=y
# CONFIG_RTC_DRV_BQ32K is not set
CONFIG_RTC_DRV_TPS6586X=m
CONFIG_RTC_DRV_S35390A=y
# CONFIG_RTC_DRV_FM3130 is not set
# CONFIG_RTC_DRV_RX8010 is not set
# CONFIG_RTC_DRV_RX8581 is not set
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
CONFIG_RTC_DRV_RV8803=m

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
CONFIG_RTC_DRV_DS1302=m
CONFIG_RTC_DRV_DS1305=m
CONFIG_RTC_DRV_DS1343=y
CONFIG_RTC_DRV_DS1347=y
# CONFIG_RTC_DRV_DS1390 is not set
CONFIG_RTC_DRV_MAX6916=y
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=y
CONFIG_RTC_DRV_RX6110=y
# CONFIG_RTC_DRV_RS5C348 is not set
CONFIG_RTC_DRV_MAX6902=y
# CONFIG_RTC_DRV_PCF2123 is not set
CONFIG_RTC_DRV_MCP795=m
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
CONFIG_RTC_DRV_PCF2127=m
# CONFIG_RTC_DRV_RV3029C2 is not set

#
# Platform RTC drivers
#
# CONFIG_RTC_DRV_CMOS is not set
CONFIG_RTC_DRV_VRTC=y
# CONFIG_RTC_DRV_DS1286 is not set
CONFIG_RTC_DRV_DS1511=y
CONFIG_RTC_DRV_DS1553=m
CONFIG_RTC_DRV_DS1685_FAMILY=m
CONFIG_RTC_DRV_DS1685=y
# CONFIG_RTC_DRV_DS1689 is not set
# CONFIG_RTC_DRV_DS17285 is not set
# CONFIG_RTC_DRV_DS17485 is not set
# CONFIG_RTC_DRV_DS17885 is not set
# CONFIG_RTC_DS1685_PROC_REGS is not set
# CONFIG_RTC_DS1685_SYSFS_REGS is not set
CONFIG_RTC_DRV_DS1742=m
# CONFIG_RTC_DRV_DS2404 is not set
# CONFIG_RTC_DRV_DA9052 is not set
CONFIG_RTC_DRV_DA9055=m
CONFIG_RTC_DRV_DA9063=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=y
# CONFIG_RTC_DRV_M48T59 is not set
# CONFIG_RTC_DRV_MSM6242 is not set
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=y
CONFIG_RTC_DRV_V3020=m
# CONFIG_RTC_DRV_WM831X is not set
CONFIG_RTC_DRV_PCF50633=m
# CONFIG_RTC_DRV_AB3100 is not set

#
# on-CPU RTC drivers
#
CONFIG_RTC_DRV_FTRTC010=y
# CONFIG_RTC_DRV_PCAP is not set
CONFIG_RTC_DRV_MC13XXX=m
CONFIG_RTC_DRV_MT6397=m

#
# HID Sensor RTC drivers
#
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_INTEL_IDMA64=y
# CONFIG_PCH_DMA is not set
CONFIG_QCOM_HIDMA_MGMT=y
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
# CONFIG_DW_DMAC is not set
CONFIG_DW_DMAC_PCI=y
CONFIG_HSU_DMA=y
CONFIG_HSU_DMA_PCI=y

#
# DMA Clients
#
# CONFIG_ASYNC_TX_DMA is not set
# CONFIG_DMATEST is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
# CONFIG_UIO is not set
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=m
# CONFIG_VIRTIO_MENU is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# CONFIG_STAGING is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACER_WMI=y
CONFIG_ACER_WIRELESS=m
CONFIG_ACERHDF=y
CONFIG_ALIENWARE_WMI=m
# CONFIG_ASUS_LAPTOP is not set
CONFIG_DELL_SMBIOS=m
# CONFIG_DELL_SMBIOS_WMI is not set
CONFIG_DELL_SMBIOS_SMM=y
# CONFIG_DELL_LAPTOP is not set
CONFIG_DELL_WMI=m
CONFIG_DELL_WMI_DESCRIPTOR=m
CONFIG_DELL_WMI_AIO=y
# CONFIG_DELL_WMI_LED is not set
# CONFIG_DELL_SMO8800 is not set
# CONFIG_FUJITSU_LAPTOP is not set
CONFIG_FUJITSU_TABLET=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_TC1100_WMI=y
# CONFIG_HP_ACCEL is not set
CONFIG_HP_WIRELESS=y
CONFIG_HP_WMI=y
CONFIG_PANASONIC_LAPTOP=m
CONFIG_SURFACE3_WMI=m
CONFIG_THINKPAD_ACPI=m
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
# CONFIG_THINKPAD_ACPI_HOTKEY_POLL is not set
CONFIG_SENSORS_HDAPS=m
CONFIG_ASUS_WIRELESS=m
CONFIG_ACPI_WMI=y
# CONFIG_WMI_BMOF is not set
CONFIG_INTEL_WMI_THUNDERBOLT=y
# CONFIG_MSI_WMI is not set
# CONFIG_PEAQ_WMI is not set
CONFIG_TOPSTAR_LAPTOP=m
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_TOSHIBA_BT_RFKILL is not set
CONFIG_TOSHIBA_HAPS=y
CONFIG_TOSHIBA_WMI=y
# CONFIG_ACPI_CMPC is not set
CONFIG_INTEL_INT0002_VGPIO=m
CONFIG_INTEL_HID_EVENT=m
CONFIG_INTEL_VBTN=y
CONFIG_INTEL_SCU_IPC=y
# CONFIG_INTEL_SCU_IPC_UTIL is not set
# CONFIG_INTEL_MID_POWER_BUTTON is not set
CONFIG_INTEL_MFLD_THERMAL=y
# CONFIG_INTEL_IPS is not set
CONFIG_INTEL_IMR=y
CONFIG_INTEL_PMC_CORE=y
# CONFIG_IBM_RTL is not set
CONFIG_SAMSUNG_LAPTOP=y
CONFIG_MXM_WMI=y
CONFIG_SAMSUNG_Q10=y
CONFIG_APPLE_GMUX=m
CONFIG_INTEL_RST=y
# CONFIG_INTEL_SMARTCONNECT is not set
CONFIG_PVPANIC=m
CONFIG_INTEL_PMC_IPC=y
CONFIG_SURFACE_PRO3_BUTTON=m
CONFIG_SURFACE_3_BUTTON=m
CONFIG_INTEL_PUNIT_IPC=y
# CONFIG_MLX_PLATFORM is not set
CONFIG_SILEAD_DMI=y
CONFIG_INTEL_CHTDC_TI_PWRBTN=y
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
# CONFIG_COMMON_CLK_SI5351 is not set
CONFIG_COMMON_CLK_SI544=y
CONFIG_COMMON_CLK_CDCE706=y
CONFIG_COMMON_CLK_CS2000_CP=y
CONFIG_CLK_TWL6040=y
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
CONFIG_DW_APB_TIMER=y
CONFIG_MAILBOX=y
# CONFIG_PCC is not set
CONFIG_ALTERA_MBOX=m
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
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
CONFIG_SOUNDWIRE=y

#
# SoundWire Devices
#

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
# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
CONFIG_XILINX_VCU=y
# CONFIG_PM_DEVFREQ is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_ADC_JACK is not set
# CONFIG_EXTCON_AXP288 is not set
CONFIG_EXTCON_GPIO=y
CONFIG_EXTCON_INTEL_INT3496=y
# CONFIG_EXTCON_MAX14577 is not set
CONFIG_EXTCON_MAX3355=y
# CONFIG_EXTCON_MAX77693 is not set
CONFIG_EXTCON_MAX77843=m
CONFIG_EXTCON_MAX8997=y
# CONFIG_EXTCON_RT8973A is not set
# CONFIG_EXTCON_SM5502 is not set
# CONFIG_EXTCON_USB_GPIO is not set
# CONFIG_MEMORY is not set
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
CONFIG_IIO_BUFFER_HW_CONSUMER=m
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=m
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
# CONFIG_IIO_SW_DEVICE is not set
CONFIG_IIO_SW_TRIGGER=m

#
# Accelerometers
#
CONFIG_ADIS16201=y
CONFIG_ADIS16209=m
CONFIG_ADXL345=y
CONFIG_ADXL345_I2C=y
CONFIG_ADXL345_SPI=y
# CONFIG_BMA180 is not set
CONFIG_BMA220=m
CONFIG_BMC150_ACCEL=y
CONFIG_BMC150_ACCEL_I2C=y
CONFIG_BMC150_ACCEL_SPI=y
CONFIG_DA280=m
# CONFIG_DA311 is not set
CONFIG_DMARD09=m
# CONFIG_DMARD10 is not set
CONFIG_HID_SENSOR_ACCEL_3D=m
# CONFIG_IIO_CROS_EC_ACCEL_LEGACY is not set
# CONFIG_KXSD9 is not set
# CONFIG_KXCJK1013 is not set
CONFIG_MC3230=m
CONFIG_MMA7455=m
CONFIG_MMA7455_I2C=m
CONFIG_MMA7455_SPI=m
# CONFIG_MMA7660 is not set
CONFIG_MMA8452=m
CONFIG_MMA9551_CORE=m
CONFIG_MMA9551=m
# CONFIG_MMA9553 is not set
CONFIG_MXC4005=m
CONFIG_MXC6255=y
CONFIG_SCA3000=y
CONFIG_STK8312=m
CONFIG_STK8BA50=y

#
# Analog to digital converters
#
# CONFIG_AD7266 is not set
CONFIG_AD7291=y
CONFIG_AD7298=y
# CONFIG_AD7476 is not set
# CONFIG_AD7766 is not set
# CONFIG_AD7791 is not set
# CONFIG_AD7793 is not set
# CONFIG_AD7887 is not set
CONFIG_AD7923=y
CONFIG_AD799X=y
# CONFIG_AXP20X_ADC is not set
CONFIG_AXP288_ADC=y
# CONFIG_CC10001_ADC is not set
# CONFIG_HI8435 is not set
CONFIG_HX711=y
CONFIG_INA2XX_ADC=m
CONFIG_LP8788_ADC=m
CONFIG_LTC2471=m
CONFIG_LTC2485=m
CONFIG_LTC2497=m
# CONFIG_MAX1027 is not set
CONFIG_MAX11100=y
# CONFIG_MAX1118 is not set
CONFIG_MAX1363=m
# CONFIG_MAX9611 is not set
# CONFIG_MCP320X is not set
CONFIG_MCP3422=m
CONFIG_NAU7802=y
CONFIG_QCOM_VADC_COMMON=m
# CONFIG_QCOM_SPMI_IADC is not set
CONFIG_QCOM_SPMI_VADC=m
# CONFIG_TI_ADC081C is not set
CONFIG_TI_ADC0832=y
CONFIG_TI_ADC084S021=y
CONFIG_TI_ADC12138=m
CONFIG_TI_ADC108S102=m
CONFIG_TI_ADC128S052=y
CONFIG_TI_ADC161S626=y
CONFIG_TI_ADS1015=m
# CONFIG_TI_ADS7950 is not set
CONFIG_TI_TLC4541=y
CONFIG_TWL4030_MADC=y
# CONFIG_TWL6030_GPADC is not set

#
# Analog Front Ends
#

#
# Amplifiers
#
CONFIG_AD8366=m

#
# Chemical Sensors
#
# CONFIG_ATLAS_PH_SENSOR is not set
CONFIG_CCS811=m
CONFIG_IAQCORE=m
CONFIG_VZ89X=m

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=m
CONFIG_HID_SENSOR_IIO_TRIGGER=m
CONFIG_IIO_MS_SENSORS_I2C=y

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

#
# Digital to analog converters
#
CONFIG_AD5064=m
# CONFIG_AD5360 is not set
# CONFIG_AD5380 is not set
CONFIG_AD5421=m
CONFIG_AD5446=m
# CONFIG_AD5449 is not set
CONFIG_AD5592R_BASE=m
# CONFIG_AD5592R is not set
CONFIG_AD5593R=m
CONFIG_AD5504=y
CONFIG_AD5624R_SPI=y
CONFIG_LTC2632=y
# CONFIG_AD5686_SPI is not set
# CONFIG_AD5696_I2C is not set
# CONFIG_AD5755 is not set
CONFIG_AD5761=m
CONFIG_AD5764=y
CONFIG_AD5791=m
CONFIG_AD7303=m
CONFIG_AD8801=m
CONFIG_DS4424=m
# CONFIG_M62332 is not set
CONFIG_MAX517=m
CONFIG_MCP4725=m
CONFIG_MCP4922=y
# CONFIG_TI_DAC082S085 is not set
CONFIG_TI_DAC5571=y

#
# IIO dummy driver
#

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
CONFIG_ADF4350=m

#
# Digital gyroscope sensors
#
CONFIG_ADIS16080=y
CONFIG_ADIS16130=m
# CONFIG_ADIS16136 is not set
CONFIG_ADIS16260=y
# CONFIG_ADXRS450 is not set
CONFIG_BMG160=m
CONFIG_BMG160_I2C=m
CONFIG_BMG160_SPI=m
CONFIG_HID_SENSOR_GYRO_3D=m
# CONFIG_MPU3050_I2C is not set
CONFIG_IIO_ST_GYRO_3AXIS=m
CONFIG_IIO_ST_GYRO_I2C_3AXIS=m
CONFIG_IIO_ST_GYRO_SPI_3AXIS=m
# CONFIG_ITG3200 is not set

#
# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4403=m
# CONFIG_AFE4404 is not set
# CONFIG_MAX30100 is not set
CONFIG_MAX30102=m

#
# Humidity sensors
#
CONFIG_AM2315=y
CONFIG_DHT11=m
# CONFIG_HDC100X is not set
CONFIG_HID_SENSOR_HUMIDITY=m
CONFIG_HTS221=m
CONFIG_HTS221_I2C=m
CONFIG_HTS221_SPI=m
CONFIG_HTU21=m
CONFIG_SI7005=y
CONFIG_SI7020=y

#
# Inertial measurement units
#
CONFIG_ADIS16400=m
CONFIG_ADIS16480=m
CONFIG_BMI160=m
CONFIG_BMI160_I2C=m
CONFIG_BMI160_SPI=m
CONFIG_KMX61=m
# CONFIG_INV_MPU6050_SPI is not set
# CONFIG_IIO_ST_LSM6DSX is not set
CONFIG_IIO_ADIS_LIB=y
CONFIG_IIO_ADIS_LIB_BUFFER=y

#
# Light sensors
#
CONFIG_ACPI_ALS=y
CONFIG_ADJD_S311=y
CONFIG_AL3320A=y
# CONFIG_APDS9300 is not set
CONFIG_APDS9960=m
CONFIG_BH1750=y
CONFIG_BH1780=y
CONFIG_CM32181=y
# CONFIG_CM3232 is not set
# CONFIG_CM3323 is not set
# CONFIG_CM36651 is not set
CONFIG_GP2AP020A00F=y
# CONFIG_SENSORS_ISL29018 is not set
CONFIG_SENSORS_ISL29028=y
# CONFIG_ISL29125 is not set
CONFIG_HID_SENSOR_ALS=m
CONFIG_HID_SENSOR_PROX=m
CONFIG_JSA1212=y
CONFIG_RPR0521=m
CONFIG_LTR501=y
CONFIG_LV0104CS=m
CONFIG_MAX44000=y
# CONFIG_OPT3001 is not set
CONFIG_PA12203001=y
# CONFIG_SI1145 is not set
# CONFIG_STK3310 is not set
# CONFIG_ST_UVIS25 is not set
CONFIG_TCS3414=y
# CONFIG_TCS3472 is not set
CONFIG_SENSORS_TSL2563=m
# CONFIG_TSL2583 is not set
CONFIG_TSL2772=m
CONFIG_TSL4531=m
# CONFIG_US5182D is not set
CONFIG_VCNL4000=m
CONFIG_VEML6070=y
CONFIG_VL6180=m
# CONFIG_ZOPT2201 is not set

#
# Magnetometer sensors
#
CONFIG_AK8975=m
# CONFIG_AK09911 is not set
CONFIG_BMC150_MAGN=m
# CONFIG_BMC150_MAGN_I2C is not set
CONFIG_BMC150_MAGN_SPI=m
CONFIG_MAG3110=y
# CONFIG_HID_SENSOR_MAGNETOMETER_3D is not set
CONFIG_MMC35240=m
CONFIG_IIO_ST_MAGN_3AXIS=m
CONFIG_IIO_ST_MAGN_I2C_3AXIS=m
CONFIG_IIO_ST_MAGN_SPI_3AXIS=m
CONFIG_SENSORS_HMC5843=y
# CONFIG_SENSORS_HMC5843_I2C is not set
CONFIG_SENSORS_HMC5843_SPI=y

#
# Multiplexers
#

#
# Inclinometer sensors
#
CONFIG_HID_SENSOR_INCLINOMETER_3D=m
CONFIG_HID_SENSOR_DEVICE_ROTATION=m

#
# Triggers - standalone
#
CONFIG_IIO_HRTIMER_TRIGGER=m
# CONFIG_IIO_INTERRUPT_TRIGGER is not set
CONFIG_IIO_TIGHTLOOP_TRIGGER=m
CONFIG_IIO_SYSFS_TRIGGER=m

#
# Digital potentiometers
#
CONFIG_AD5272=m
# CONFIG_DS1803 is not set
CONFIG_MAX5481=m
# CONFIG_MAX5487 is not set
# CONFIG_MCP4018 is not set
# CONFIG_MCP4131 is not set
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
CONFIG_BMP280=y
CONFIG_BMP280_I2C=y
CONFIG_BMP280_SPI=y
CONFIG_HID_SENSOR_PRESS=m
# CONFIG_HP03 is not set
CONFIG_MPL115=y
CONFIG_MPL115_I2C=m
CONFIG_MPL115_SPI=y
CONFIG_MPL3115=y
CONFIG_MS5611=m
CONFIG_MS5611_I2C=m
CONFIG_MS5611_SPI=m
# CONFIG_MS5637 is not set
CONFIG_IIO_ST_PRESS=m
CONFIG_IIO_ST_PRESS_I2C=m
CONFIG_IIO_ST_PRESS_SPI=m
# CONFIG_T5403 is not set
CONFIG_HP206C=y
# CONFIG_ZPA2326 is not set

#
# Lightning sensors
#
CONFIG_AS3935=m

#
# Proximity and distance sensors
#
# CONFIG_LIDAR_LITE_V2 is not set
CONFIG_RFD77402=m
# CONFIG_SRF04 is not set
CONFIG_SX9500=m
# CONFIG_SRF08 is not set

#
# Resolver to digital converters
#
CONFIG_AD2S1200=y

#
# Temperature sensors
#
# CONFIG_MAXIM_THERMOCOUPLE is not set
# CONFIG_HID_SENSOR_TEMP is not set
CONFIG_MLX90614=m
CONFIG_MLX90632=m
CONFIG_TMP006=y
CONFIG_TMP007=m
CONFIG_TSYS01=m
CONFIG_TSYS02D=y
# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
# CONFIG_PWM is not set

#
# IRQ chip support
#
CONFIG_ARM_GIC_MAX_NR=1
# CONFIG_IPACK_BUS is not set
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_TI_SYSCON is not set
CONFIG_FMC=m
CONFIG_FMC_FAKEDEV=m
CONFIG_FMC_TRIVIAL=m
# CONFIG_FMC_WRITE_EEPROM is not set
CONFIG_FMC_CHARDEV=m

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_BCM_KONA_USB2_PHY is not set
CONFIG_PHY_PXA_28NM_HSIC=y
CONFIG_PHY_PXA_28NM_USB2=m
# CONFIG_PHY_CPCAP_USB is not set
CONFIG_POWERCAP=y
# CONFIG_INTEL_RAPL is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# CONFIG_RAS is not set
CONFIG_THUNDERBOLT=m

#
# Android
#
# CONFIG_ANDROID is not set
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_NVMEM=y

#
# HW tracing support
#
CONFIG_STM=y
CONFIG_STM_DUMMY=m
# CONFIG_STM_SOURCE_CONSOLE is not set
# CONFIG_STM_SOURCE_HEARTBEAT is not set
CONFIG_INTEL_TH=m
# CONFIG_INTEL_TH_PCI is not set
CONFIG_INTEL_TH_ACPI=m
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
# CONFIG_INTEL_TH_MSU is not set
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
CONFIG_FPGA=y
# CONFIG_ALTERA_PR_IP_CORE is not set
# CONFIG_FPGA_MGR_ALTERA_PS_SPI is not set
CONFIG_FPGA_MGR_ALTERA_CVP=m
CONFIG_FPGA_MGR_XILINX_SPI=y
CONFIG_FPGA_MGR_MACHXO2_SPI=y
CONFIG_FPGA_BRIDGE=m
# CONFIG_XILINX_PR_DECOUPLER is not set
CONFIG_FPGA_REGION=m
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set

#
# Firmware Drivers
#
# CONFIG_EDD is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DELL_RBU=y
CONFIG_DCDBAS=m
CONFIG_DMIID=y
# CONFIG_DMI_SYSFS is not set
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT_FIND is not set
# CONFIG_FW_CFG_SYSFS is not set
CONFIG_GOOGLE_FIRMWARE=y
# CONFIG_GOOGLE_COREBOOT_TABLE_ACPI is not set
# CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY is not set

#
# Tegra firmware driver
#

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
CONFIG_EXT3_FS=m
# CONFIG_EXT3_FS_POSIX_ACL is not set
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_EXT4_FS=m
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
# CONFIG_EXT4_FS_SECURITY is not set
CONFIG_EXT4_ENCRYPTION=y
CONFIG_EXT4_FS_ENCRYPTION=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=m
CONFIG_JBD2_DEBUG=y
CONFIG_FS_MBCACHE=m
CONFIG_REISERFS_FS=m
CONFIG_REISERFS_CHECK=y
CONFIG_REISERFS_PROC_INFO=y
# CONFIG_REISERFS_FS_XATTR is not set
CONFIG_JFS_FS=y
CONFIG_JFS_POSIX_ACL=y
# CONFIG_JFS_SECURITY is not set
CONFIG_JFS_DEBUG=y
# CONFIG_JFS_STATISTICS is not set
# CONFIG_OCFS2_FS is not set
CONFIG_BTRFS_FS=m
# CONFIG_BTRFS_FS_POSIX_ACL is not set
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
CONFIG_BTRFS_DEBUG=y
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
CONFIG_NILFS2_FS=y
CONFIG_F2FS_FS=m
# CONFIG_F2FS_STAT_FS is not set
CONFIG_F2FS_FS_XATTR=y
# CONFIG_F2FS_FS_POSIX_ACL is not set
CONFIG_F2FS_FS_SECURITY=y
# CONFIG_F2FS_CHECK_FS is not set
CONFIG_F2FS_FS_ENCRYPTION=y
CONFIG_F2FS_FAULT_INJECTION=y
# CONFIG_FS_DAX is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
# CONFIG_MANDATORY_FILE_LOCKING is not set
CONFIG_FS_ENCRYPTION=m
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
CONFIG_QUOTA=y
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_PRINT_QUOTA_WARNING=y
CONFIG_QUOTA_DEBUG=y
CONFIG_QFMT_V1=m
# CONFIG_QFMT_V2 is not set
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=m
CONFIG_AUTOFS_FS=m
CONFIG_FUSE_FS=y
CONFIG_CUSE=y
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
CONFIG_OVERLAY_FS_INDEX=y
# CONFIG_OVERLAY_FS_NFS_EXPORT is not set
CONFIG_OVERLAY_FS_XINO_AUTO=y

#
# Caches
#
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
CONFIG_FSCACHE_HISTOGRAM=y
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=m
CONFIG_CACHEFILES_DEBUG=y
CONFIG_CACHEFILES_HISTOGRAM=y

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
# CONFIG_JOLIET is not set
CONFIG_ZISOFS=y
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
# CONFIG_VFAT_FS is not set
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_NTFS_FS=y
CONFIG_NTFS_DEBUG=y
CONFIG_NTFS_RW=y

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
# CONFIG_PROC_CHILDREN is not set
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_HUGETLBFS is not set
CONFIG_MEMFD_CREATE=y
CONFIG_CONFIGFS_FS=y
CONFIG_MISC_FILESYSTEMS=y
CONFIG_ORANGEFS_FS=y
CONFIG_ADFS_FS=y
# CONFIG_ADFS_FS_RW is not set
CONFIG_AFFS_FS=y
CONFIG_ECRYPT_FS=m
CONFIG_ECRYPT_FS_MESSAGING=y
CONFIG_HFS_FS=m
CONFIG_HFSPLUS_FS=y
CONFIG_HFSPLUS_FS_POSIX_ACL=y
# CONFIG_BEFS_FS is not set
CONFIG_BFS_FS=y
CONFIG_EFS_FS=m
# CONFIG_JFFS2_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_SQUASHFS is not set
# CONFIG_VXFS_FS is not set
CONFIG_MINIX_FS=m
CONFIG_OMFS_FS=y
# CONFIG_HPFS_FS is not set
CONFIG_QNX4FS_FS=m
CONFIG_QNX6FS_FS=y
CONFIG_QNX6FS_DEBUG=y
# CONFIG_ROMFS_FS is not set
# CONFIG_PSTORE is not set
# CONFIG_SYSV_FS is not set
CONFIG_UFS_FS=y
CONFIG_UFS_FS_WRITE=y
CONFIG_UFS_DEBUG=y
# CONFIG_EXOFS_FS is not set
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
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
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
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=y
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=m
# CONFIG_NLS_CODEPAGE_852 is not set
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=y
# CONFIG_NLS_CODEPAGE_861 is not set
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
CONFIG_NLS_CODEPAGE_869=y
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=y
CONFIG_NLS_ISO8859_8=y
CONFIG_NLS_CODEPAGE_1250=m
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=y
# CONFIG_NLS_ISO8859_1 is not set
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=y
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=y
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=y
CONFIG_NLS_ISO8859_9=y
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
CONFIG_NLS_KOI8_R=y
CONFIG_NLS_KOI8_U=y
CONFIG_NLS_MAC_ROMAN=y
CONFIG_NLS_MAC_CELTIC=m
# CONFIG_NLS_MAC_CENTEURO is not set
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=y
# CONFIG_NLS_MAC_ICELAND is not set
CONFIG_NLS_MAC_INUIT=m
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
CONFIG_FRAME_WARN=1024
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_READABLE_ASM is not set
CONFIG_UNUSED_SYMBOLS=y
# CONFIG_PAGE_OWNER is not set
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
CONFIG_DEBUG_SECTION_MISMATCH=y
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
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_PAGE_POISONING=y
CONFIG_PAGE_POISONING_NO_SANITY=y
CONFIG_PAGE_POISONING_ZERO=y
CONFIG_DEBUG_RODATA_TEST=y
# CONFIG_DEBUG_OBJECTS is not set
CONFIG_SLUB_DEBUG_ON=y
CONFIG_SLUB_STATS=y
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
# CONFIG_DEBUG_HIGHMEM is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Lockups and Hangs
#
# CONFIG_SOFTLOCKUP_DETECTOR is not set
# CONFIG_HARDLOCKUP_DETECTOR is not set
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
# CONFIG_SCHEDSTATS is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_DEBUG_TIMEKEEPING=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_WW_MUTEX_SELFTEST=m
CONFIG_STACKTRACE=y
CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
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
# CONFIG_RCU_PERF_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_TRACE=y
# CONFIG_RCU_EQS_DEBUG is not set
# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
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
CONFIG_RING_BUFFER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_RUNTIME_TESTING_MENU is not set
CONFIG_MEMTEST=y
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_X86_PTDUMP is not set
# CONFIG_DEBUG_WX is not set
CONFIG_DOUBLEFAULT=y
# CONFIG_DEBUG_TLBFLUSH is not set
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
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_DEBUG_IMR_SELFTEST=y
CONFIG_X86_DEBUG_FPU=y
CONFIG_PUNIT_ATOM_DEBUG=y
CONFIG_UNWINDER_FRAME_POINTER=y

#
# Security options
#
CONFIG_KEYS=y
CONFIG_PERSISTENT_KEYRINGS=y
# CONFIG_BIG_KEYS is not set
CONFIG_ENCRYPTED_KEYS=m
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
# CONFIG_SECURITY_NETWORK is not set
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_SECURITY_PATH=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
# CONFIG_FORTIFY_SOURCE is not set
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
CONFIG_SECURITY_LOADPIN=y
CONFIG_SECURITY_LOADPIN_ENABLED=y
CONFIG_SECURITY_YAMA=y
# CONFIG_INTEGRITY is not set
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
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_RSA=m
# CONFIG_CRYPTO_DH is not set
CONFIG_CRYPTO_ECDH=m
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=y
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=m
CONFIG_CRYPTO_MCRYPTD=m
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=m
CONFIG_CRYPTO_GLUE_HELPER_X86=m

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
# CONFIG_CRYPTO_GCM is not set
CONFIG_CRYPTO_CHACHA20POLY1305=y
CONFIG_CRYPTO_AEGIS128=m
# CONFIG_CRYPTO_AEGIS128L is not set
CONFIG_CRYPTO_AEGIS256=m
CONFIG_CRYPTO_MORUS640=m
# CONFIG_CRYPTO_MORUS1280 is not set
CONFIG_CRYPTO_SEQIV=m
CONFIG_CRYPTO_ECHAINIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=m
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=m
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=m
# CONFIG_CRYPTO_LRW is not set
# CONFIG_CRYPTO_PCBC is not set
CONFIG_CRYPTO_XTS=m
# CONFIG_CRYPTO_KEYWRAP is not set

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=y
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
# CONFIG_CRYPTO_CRC32C_INTEL is not set
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD128=m
CONFIG_CRYPTO_RMD160=y
CONFIG_CRYPTO_RMD256=m
CONFIG_CRYPTO_RMD320=m
# CONFIG_CRYPTO_SHA1 is not set
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=m
CONFIG_CRYPTO_TGR192=y
CONFIG_CRYPTO_WP512=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
# CONFIG_CRYPTO_AES_586 is not set
# CONFIG_CRYPTO_AES_NI_INTEL is not set
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_ARC4=y
# CONFIG_CRYPTO_BLOWFISH is not set
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_DES=y
# CONFIG_CRYPTO_FCRYPT is not set
CONFIG_CRYPTO_KHAZAD=y
CONFIG_CRYPTO_SALSA20=y
CONFIG_CRYPTO_CHACHA20=y
# CONFIG_CRYPTO_SEED is not set
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_586=m
# CONFIG_CRYPTO_SM4 is not set
CONFIG_CRYPTO_SPECK=y
CONFIG_CRYPTO_TEA=m
# CONFIG_CRYPTO_TWOFISH is not set
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_586=m

#
# Compression
#
# CONFIG_CRYPTO_DEFLATE is not set
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=m
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=m
CONFIG_CRYPTO_ZSTD=m

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
# CONFIG_X509_CERTIFICATE_PARSER is not set

#
# Certificates for signature checking
#
# CONFIG_SYSTEM_TRUSTED_KEYRING is not set
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
# CONFIG_VHOST_NET is not set
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_BITREVERSE=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=m
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=m
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC4=m
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=y
CONFIG_CRC8=m
CONFIG_XXHASH=m
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
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=m
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=m
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_INTERVAL_TREE=y
CONFIG_RADIX_TREE_MULTIORDER=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_HAVE_GENERIC_DMA_COHERENT=y
CONFIG_DMA_DIRECT_OPS=y
CONFIG_SWIOTLB=y
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
CONFIG_GLOB_SELFTEST=m
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_CORDIC=y
CONFIG_DDR=y
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_OID_REGISTRY=m
CONFIG_FONT_SUPPORT=y
CONFIG_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
# CONFIG_FONT_6x11 is not set
CONFIG_FONT_7x14=y
# CONFIG_FONT_PEARL_8x8 is not set
# CONFIG_FONT_ACORN_8x8 is not set
CONFIG_FONT_MINI_4x6=y
# CONFIG_FONT_6x10 is not set
CONFIG_FONT_10x18=y
CONFIG_FONT_SUN8x16=y
# CONFIG_FONT_SUN12x22 is not set
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_SBITMAP=y
CONFIG_STRING_SELFTEST=m

--BXVAT5kNtrzKuDFl--
