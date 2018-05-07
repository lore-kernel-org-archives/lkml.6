Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752024AbeEGBPd (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 21:15:33 -0400
Received: from mga07.intel.com ([134.134.136.100]:7069 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751899AbeEGBPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 21:15:24 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,372,1520924400";
   d="gz'50?scan'50,208,50";a="43656403"
Date: Mon, 7 May 2018 09:15:59 +0800
From: kernel test robot <shun.hao@intel.com>
To: David Howells <dhowells@redhat.com>
Cc: linux-afs@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, LKP <lkp@01.org>
Subject: [lkp-robot] ace45bec6d [   44.030009] watchdog: BUG: soft lockup -
 CPU#0 stuck for 23s! [kworker/0:1:19]
Message-ID: <20180507011559.dvxfa2jbanwyzk6n@shao2-debian>
Reply-To: kernel test robot <lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="7ej6mdx5ofjufdrf"
Content-Disposition: inline
User-Agent: Heirloom mailx 12.5 6/20/10
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7ej6mdx5ofjufdrf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

commit ace45bec6d77bc061c3c3d8ad99e298ea9800c2b
Author:     David Howells <dhowells@redhat.com>
AuthorDate: Fri Mar 30 21:04:43 2018 +0100
Commit:     David Howells <dhowells@redhat.com>
CommitDate: Fri Mar 30 21:04:43 2018 +0100

    rxrpc: Fix firewall route keepalive
    
    Fix the firewall route keepalive part of AF_RXRPC which is currently
    function incorrectly by replying to VERSION REPLY packets from the server
    with VERSION REQUEST packets.
    
    Instead, send VERSION REPLY packets to the peers of service connections to
    act as keep-alives 20s after the latest packet was transmitted to that
    peer.
    
    Also, just discard VERSION REPLY packets rather than replying to them.
    
    Signed-off-by: David Howells <dhowells@redhat.com>

c0b6edef0b  tc-testing: Add newline when writing test case files
ace45bec6d  rxrpc: Fix firewall route keepalive
c1c07416cd  Merge tag 'kbuild-fixes-v4.17' of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild
+------------------------------------------------+------------+------------+------------+
|                                                | c0b6edef0b | ace45bec6d | c1c07416cd |
+------------------------------------------------+------------+------------+------------+
| boot_successes                                 | 159        | 24         | 22         |
| boot_failures                                  | 2          | 11         | 18         |
| Mem-Info                                       | 2          |            |            |
| BUG:soft_lockup-CPU##stuck_for#s               | 0          | 8          | 14         |
| EIP:arch_local_irq_enable                      | 0          | 3          | 7          |
| Kernel_panic-not_syncing:softlockup:hung_tasks | 0          | 11         | 18         |
| EIP:arch_local_irq_restore                     | 0          | 6          | 9          |
| EIP:do_raw_spin_unlock                         | 0          | 1          |            |
| EIP:rxrpc_peer_keepalive_worker                | 0          | 1          | 1          |
| calltrace:rxrpc_peer_keepalive_worker          | 0          | 1          | 1          |
| EIP:__local_bh_disable_ip                      | 0          | 0          | 1          |
+------------------------------------------------+------------+------------+------------+

Starting udev
Kernel tests: Boot OK!
[    5.636456] VFS: Warning: trinity-c2 using old stat() call. Recompile your binary.
[    5.676092] VFS: Warning: trinity-c3 using old stat() call. Recompile your binary.

[   44.030009] watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [kworker/0:1:19]
[   44.044662] Modules linked in:
[   44.045074] irq event stamp: 181031373
[   44.045594] hardirqs last  enabled at (181031371): [<fc1697fb>] __local_bh_enable_ip+0xae/0xba
[   44.046757] hardirqs last disabled at (181031373): [<40d2972d>] apic_timer_interrupt+0x3a/0x50
[   44.047914] softirqs last  enabled at (181031370): [<50cc2190>] rxrpc_peer_keepalive_worker+0x11a/0x326
[   44.049135] softirqs last disabled at (181031372): [<cd96f8e7>] rxrpc_peer_keepalive_worker+0xb8/0x326
[   44.050291] CPU: 0 PID: 19 Comm: kworker/0:1 Not tainted 4.16.0-rc6-02064-gace45be #213
[   44.051322] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[   44.052442] Workqueue: krxrpcd rxrpc_peer_keepalive_worker
[   44.053238] EIP: arch_local_irq_restore+0x5/0xb
[   44.053907] EFLAGS: 00000246 CPU: 0
[   44.054394] EAX: 00000246 EBX: 8f4c7080 ECX: 81edc1a8 EDX: 539ce25c
[   44.055220] ESI: 8dc171b0 EDI: 00000246 EBP: 8f4d7e74 ESP: 8f4d7e74
[   44.056083]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
[   44.056859] CR0: 80050033 CR2: 09bcf850 CR3: 0d3ab000 CR4: 00000690
[   44.057776] DR0: 76d86000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[   44.058678] DR6: ffff0ff0 DR7: 00000600
[   44.059234] Call Trace:
[   44.059592]  lock_acquire+0x6a/0x75
[   44.060085]  ? rxrpc_peer_keepalive_worker+0xb8/0x326
[   44.060811]  _raw_spin_lock_bh+0x28/0x37
[   44.061383]  ? rxrpc_peer_keepalive_worker+0xb8/0x326
[   44.062085]  rxrpc_peer_keepalive_worker+0xb8/0x326
[   44.062791]  ? lock_acquire+0x6a/0x75
[   44.063292]  ? process_one_work+0x164/0x29a
[   44.063880]  process_one_work+0x183/0x29a
[   44.064405]  ? process_one_work+0x164/0x29a
[   44.076043]  worker_thread+0x178/0x21b
[   44.076552]  kthread+0xd3/0xd5
[   44.076945]  ? rescuer_thread+0x23a/0x23a
[   44.077459]  ? kthread_create_worker_on_cpu+0x17/0x17
[   44.078243]  ret_from_fork+0x2e/0x40
[   44.078837] Code: 00 8d 43 34 6a 00 8b 4d f4 89 f2 e8 2f 0f 00 00 89 5b 30 5e 8d 65 f8 5b 5e 5d c3 55 89 e5 9c 58 8d 74 26 00 5d c3 55 89 e5 50 9d <8d> 74 26 00 5d c3 55 89 e5 e8 e2 ff ff ff 89 c1 fa 90 8d 74 26
[   44.081585] Kernel panic - not syncing: softlockup: hung tasks
[   44.082307] CPU: 0 PID: 19 Comm: kworker/0:1 Tainted: G             L   4.16.0-rc6-02064-gace45be #213
[   44.083693] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[   44.085102] Workqueue: krxrpcd rxrpc_peer_keepalive_worker
[   44.095951] Call Trace:
[   44.096279]  dump_stack+0x73/0xa5
[   44.096739]  panic+0x99/0x1d8
[   44.097144]  watchdog_timer_fn+0x1ad/0x1d2
[   44.097709]  __hrtimer_run_queues+0xa5/0x117
[   44.098283]  ? watchdog+0x16/0x16
[   44.098737]  hrtimer_run_queues+0x9c/0xd3
[   44.099252]  run_local_timers+0x15/0x2c
[   44.099777]  update_process_times+0x18/0x39
[   44.100344]  tick_periodic+0x99/0xa5
[   44.100827]  tick_handle_periodic+0x1d/0x5c
[   44.101371]  smp_apic_timer_interrupt+0x54/0x67
[   44.101944]  apic_timer_interrupt+0x41/0x50
[   44.102463] EIP: arch_local_irq_restore+0x5/0xb
[   44.103164] EFLAGS: 00000246 CPU: 0
[   44.103781] EAX: 00000246 EBX: 8f4c7080 ECX: 81edc1a8 EDX: 539ce25c
[   44.104803] ESI: 8dc171b0 EDI: 00000246 EBP: 8f4d7e74 ESP: 8f4d7e74
[   44.116848]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
[   44.117580]  ? rcu_read_unlock+0x24/0x56
[   44.118098]  ? startup_32_smp+0x18/0x170
[   44.118614]  ? prepare_to_wait_exclusive+0x17/0x5f
[   44.119265]  lock_acquire+0x6a/0x75
[   44.119750]  ? rxrpc_peer_keepalive_worker+0xb8/0x326
[   44.120401]  _raw_spin_lock_bh+0x28/0x37
[   44.120908]  ? rxrpc_peer_keepalive_worker+0xb8/0x326
[   44.121532]  rxrpc_peer_keepalive_worker+0xb8/0x326
[   44.122168]  ? lock_acquire+0x6a/0x75
[   44.122671]  ? process_one_work+0x164/0x29a
[   44.123285]  process_one_work+0x183/0x29a
[   44.123905]  ? process_one_work+0x164/0x29a
[   44.124511]  worker_thread+0x178/0x21b
[   44.125052]  kthread+0xd3/0xd5
[   44.125481]  ? rescuer_thread+0x23a/0x23a
[   44.126032]  ? kthread_create_worker_on_cpu+0x17/0x17
[   44.137746]  ret_from_fork+0x2e/0x40
[   44.138569] Kernel Offset: disabled


                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start 60cc43fc888428bb2f18f08997432d426a243338 v4.16 --
git bisect  bad 3c0d551e02b2590fa71a1354f2f1994551a33315  # 07:54  B      4     2    3   3  Merge tag 'pci-v4.17-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci
git bisect  bad 17dec0a949153d9ac00760ba2f5b78cb583e995f  # 08:09  B      0     1   15   0  Merge branch 'userns-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace
git bisect good f5a8eb632b562bd9c16c389f5db3a5260fba4157  # 08:15  G     21     0    0   1  Merge tag 'arch-removal' of git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic
git bisect good 77624cd2a7783fccf2c518768a6fd7a7aeccd002  # 08:36  G     23     0    1   1  Merge tag 'pinctrl-v4.17-1' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl
git bisect  bad 0734e00ef9e48e78c5c3ce1648572f160d07e323  # 08:47  B      0     1   20   4  Merge branch 'parisc-4.17-1' of git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux
git bisect good bb2407a7219760926760f0448fddf00d625e5aec  # 08:52  G     21     0    0   1  Merge tag 'docs-4.17' of git://git.lwn.net/linux
git bisect  bad 5bb053bef82523a8fd78d650bca81c9f114fa276  # 08:52  B      4     4    0   8  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next
git bisect good 489b30b53f0540b9f8e391cbb2839cea48b5d1c1  # 09:01  G     25     0    1   1  net: Convert l2tp_net_ops
git bisect good 038d49baab571800e3077b9d322a004f95c8aa8f  # 09:09  G     25     0    0   1  Merge branch 'Introduce-net_rwsem-to-protect-net_namespace_list'
git bisect good d162190bded8b3f635d1ba1e27e63d1b4a720ba8  # 09:14  G     25     0    0   0  Merge git://git.kernel.org/pub/scm/linux/kernel/git/pablo/nf-next
git bisect  bad 70ae7222c61d4f19c844c8fe75f053f8976b9552  # 09:14  B      8     4    0   9  Merge branch 'inet-frags-bring-rhashtables-to-IP-defrag'
git bisect  bad e2e80c027f5adab3cc44c3d07c4484291384d278  # 09:19  B      4    10    0   7  Merge tag 'rxrpc-next-20180330' of git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs
git bisect  bad 17226f1240381812c3a4927dc9da2814fb71c8ac  # 09:19  B      9     7    0   5  rxrpc: Fix leak of rxrpc_peer objects
git bisect good 6f14f49ce5eb00f533133df06c663fbaea13cd50  # 09:27  G     46     0    1   1  Merge branch 'ieee802154-for-davem-2018-03-29' of git://git.kernel.org/pub/scm/linux/kernel/git/sschmidt/wpan-next
git bisect  bad 59299aa1028fce051adbd25aaff7c387b865cd6d  # 09:27  B      8     5    0   6  rxrpc: Fix resend event time calculation
git bisect  bad ace45bec6d77bc061c3c3d8ad99e298ea9800c2b  # 09:27  B      9     6    0   6  rxrpc: Fix firewall route keepalive
git bisect good c0b6edef0bf0e33c12eaf80c676ff09def011518  # 09:27  G     49     0    0   0  tc-testing: Add newline when writing test case files
# first bad commit: [ace45bec6d77bc061c3c3d8ad99e298ea9800c2b] rxrpc: Fix firewall route keepalive
git bisect good c0b6edef0bf0e33c12eaf80c676ff09def011518  # 09:54  G    136     0    4   4  tc-testing: Add newline when writing test case files
# extra tests on HEAD of linux-devel/devel-catchup-201805060551
git bisect  bad 51ecf81e1818f38e84576c21d6098cfef3b27d29  # 09:54  B      5     5    0   4  0day head guard for 'devel-catchup-201805060551'
# extra tests on tree/branch linus/master
git bisect  bad c1c07416cdd47161a359286021d483f449ad8c4f  # 09:54  B      4     9    0   9  Merge tag 'kbuild-fixes-v4.17' of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild
# extra tests with first bad commit reverted
git bisect good e1f21b9be760e1e983900105c90b1349447f9aec  # 10:00  G     48     0    0   0  Revert "rxrpc: Fix firewall route keepalive"
# extra tests on tree/branch linux-next/master

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/lkp                          Intel Corporation

--7ej6mdx5ofjufdrf
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-yocto-intel12-10:20180506085351:i386-randconfig-s0-201818:4.16.0-rc6-02064-gace45be:213.gz"
Content-Transfer-Encoding: base64

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
9Lj3P9StsenWtwAA

--7ej6mdx5ofjufdrf
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-yocto-intel12-16:20180506094629:i386-randconfig-s0-201818:4.16.0-rc6-02063-gc0b6ede:216.gz"
Content-Transfer-Encoding: base64

H4sICBti7loAA2RtZXNnLXlvY3RvLWludGVsMTItMTY6MjAxODA1MDYwOTQ2Mjk6aTM4Ni1y
YW5kY29uZmlnLXMwLTIwMTgxODo0LjE2LjAtcmM2LTAyMDYzLWdjMGI2ZWRlOjIxNgCsW+lz
2zqS/7z5K3pmvsi7lkzwprY0NT7kRGXL1rOc97KTSqkoEpQ5pkg+Hj5S88dvN0BJFCn5yNhV
iUSw+4cG0OgLEHez6Bm8JM6TiEMYQ86LMsUGn3+aZMk8jBcwPDuDDvf9QRIEUCTgh7k7j/hB
r9eD5P4Tb0LwpyJzvWJ2z7OYR5/COC2Lme8Wbh+UJ0VlzGaKXjVHPBatim2Ypu58SsoCm0UT
U8Rf1bShDOZM9fVPEn1WJIUbzfLwJ5dMjm0R06cz7iXLNON5TkO4DOPyieSduJloGF6e0+NV
AhmPEs8twiSGmHOf+9TuJzHvfTpJkoKIizsOsrvep++Af0pPyvZDAsMDR1QE0HvM7CndzDO7
iqqYWnfhKXMTQaFzPy/DyP9HdJ927/InRTuAzsLz1pxmT+8poCrMYopqQueMz0O3au46Bwfw
N5WZMB1PYFrGMHafwQTF7ht2X3PgdHpLrHZTuCfbPArSso9fLDiffIXHMIqgzDmcf5se/z5s
0nNbVfpwMrqedtMseQhxMiC9e85Dz43g5ngMSzftN5kEueT8vuRLsUTbf92tJieYB8EPlIJ0
6F1gTuC1wQICw2Xm2QP33wUXtGULfh2OtYYaBD4LfmmoyKm2wH5ZtoAHNHF1OGr6ZTiJtgX3
qnQ+n5eLPoSLOMloR0XJIuIPPCJzQ1usta/muPVWJuW7sDAITCoa01y28K9wo3poAa6+QWf4
xL2y4HBWmSlAXS64J3a458ZxUsCcr4D6ECdxd3I8rDb4X5rImRv7ybIPgZsXaNzCQtiGJtV0
TBMGas8Gsjk8LlojOhuP+vDbcPwVpgViupkPk1PohLqunH+D/4HJaPTtEJjjmAeHYvqB9ZjS
U7sMFP1IYUe4w/Um6JfnFOc7zJMMp5gGSSO6+H28e2eXKVph3lzQ1ULWdBUGg7/vXUuJlfFl
8lDHcjdYlTLs1nvJHuF0ztIghgFyk76jbXmauZl3t26VO2qXTZsc3/bhNImDcFFm0nR/V7rW
jz78cQLwxy3A19Mu/oPWc2vdUCEgwNkjy4qua8/UaDict7PW7JS0T29nrdmkYCdrkJSxL/jG
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
jw28zTEBAA==

--7ej6mdx5ofjufdrf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reproduce-yocto-intel12-10:20180506085351:i386-randconfig-s0-201818:4.16.0-rc6-02064-gace45be:213"

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

--7ej6mdx5ofjufdrf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-4.16.0-rc6-02064-gace45be"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 4.16.0-rc6 Kernel Configuration
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
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_32_SMP=y
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
CONFIG_KERNEL_LZO=y
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
# CONFIG_SYSVIPC is not set
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_CROSS_MEMORY_ATTACH is not set
CONFIG_USELIB=y
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
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ=y
# CONFIG_HIGH_RES_TIMERS is not set

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_CPU_ISOLATION is not set

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
# CONFIG_TASKS_RCU is not set
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
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
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
# CONFIG_CFS_BANDWIDTH is not set
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
# CONFIG_CGROUP_FREEZER is not set
# CONFIG_CPUSETS is not set
CONFIG_CGROUP_DEVICE=y
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
# CONFIG_CGROUP_BPF is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
# CONFIG_NAMESPACES is not set
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
# CONFIG_RD_BZIP2 is not set
CONFIG_RD_LZMA=y
# CONFIG_RD_XZ is not set
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
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
# CONFIG_POSIX_TIMERS is not set
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
# CONFIG_PCSPKR_PLATFORM is not set
CONFIG_BASE_FULL=y
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
# CONFIG_CHECKPOINT_RESTORE is not set
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
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
CONFIG_DEBUG_PERF_USE_VMALLOC=y
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_COMPAT_BRK is not set
CONFIG_SLAB=y
# CONFIG_SLUB is not set
# CONFIG_SLOB is not set
# CONFIG_SLAB_MERGE_DEFAULT is not set
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SYSTEM_DATA_VERIFICATION is not set
CONFIG_PROFILING=y
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_OPROFILE=m
# CONFIG_OPROFILE_EVENT_MULTIPLEX is not set
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
# CONFIG_KPROBES is not set
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
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
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_CYC_COMPLEXITY is not set
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK is not set
CONFIG_GCC_PLUGIN_RANDSTRUCT=y
# CONFIG_GCC_PLUGIN_RANDSTRUCT_PERFORMANCE is not set
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
CONFIG_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_PHYS_TO_DMA=y
CONFIG_ARCH_HAS_REFCOUNT=y
# CONFIG_REFCOUNT_FULL is not set

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
CONFIG_MODVERSIONS=y
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
CONFIG_MODULE_COMPRESS=y
CONFIG_MODULE_COMPRESS_GZIP=y
# CONFIG_MODULE_COMPRESS_XZ is not set
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
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_FREEZER=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_FAST_FEATURE_TESTS=y
CONFIG_X86_MPPARSE=y
CONFIG_GOLDFISH=y
CONFIG_RETPOLINE=y
# CONFIG_INTEL_RDT is not set
CONFIG_X86_BIGSMP=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_GOLDFISH is not set
CONFIG_X86_INTEL_LPSS=y
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_RDC321X=y
CONFIG_X86_32_NON_STANDARD=y
CONFIG_STA2X11=y
CONFIG_X86_32_IRIS=m
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
CONFIG_M486=y
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
CONFIG_X86_INTERNODE_CACHE_SHIFT=4
CONFIG_X86_L1_CACHE_SHIFT=4
# CONFIG_X86_PPRO_FENCE is not set
CONFIG_X86_F00F_BUG=y
CONFIG_X86_INVD_BUG=y
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_MINIMUM_CPU_FAMILY=4
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_CYRIX_32=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_TRANSMETA_32=y
CONFIG_CPU_SUP_UMC_32=y
CONFIG_HPET_TIMER=y
CONFIG_DMI=y
CONFIG_SWIOTLB=y
CONFIG_IOMMU_HELPER=y
CONFIG_NR_CPUS_RANGE_BEGIN=2
CONFIG_NR_CPUS_RANGE_END=64
CONFIG_NR_CPUS_DEFAULT=32
CONFIG_NR_CPUS=32
# CONFIG_SCHED_SMT is not set
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
# CONFIG_X86_MCE is not set

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
# CONFIG_PERF_EVENTS_INTEL_RAPL is not set
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
CONFIG_PERF_EVENTS_AMD_POWER=m
# CONFIG_X86_LEGACY_VM86 is not set
# CONFIG_VM86 is not set
CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX32=y
# CONFIG_TOSHIBA is not set
CONFIG_I8K=y
CONFIG_X86_REBOOTFIXUPS=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=y
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_VMSPLIT_3G is not set
# CONFIG_VMSPLIT_3G_OPT is not set
CONFIG_VMSPLIT_2G=y
# CONFIG_VMSPLIT_2G_OPT is not set
# CONFIG_VMSPLIT_1G is not set
CONFIG_PAGE_OFFSET=0x80000000
# CONFIG_X86_PAE is not set
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
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
# CONFIG_PHYS_ADDR_T_64BIT is not set
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_TRANSPARENT_HUGEPAGE=y
# CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
# CONFIG_ARCH_WANTS_THP_SWAP is not set
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
CONFIG_CLEANCACHE=y
CONFIG_CMA=y
CONFIG_CMA_DEBUG=y
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=7
CONFIG_ZPOOL=y
CONFIG_ZBUD=m
CONFIG_Z3FOLD=m
# CONFIG_ZSMALLOC is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_FRAME_VECTOR=y
CONFIG_PERCPU_STATS=y
# CONFIG_GUP_BENCHMARK is not set
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=y
CONFIG_X86_RESERVE_LOW=64
# CONFIG_MATH_EMULATION is not set
# CONFIG_MTRR is not set
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
# CONFIG_X86_INTEL_UMIP is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
# CONFIG_SECCOMP is not set
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_300=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=300
# CONFIG_SCHED_HRTICK is not set
CONFIG_KEXEC=y
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

#
# Power management and ACPI options
#
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
CONFIG_PM_WAKELOCKS=y
CONFIG_PM_WAKELOCKS_LIMIT=100
# CONFIG_PM_WAKELOCKS_GC is not set
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_PM_CLK=y
CONFIG_PM_GENERIC_DOMAINS=y
CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
CONFIG_PM_GENERIC_DOMAINS_SLEEP=y
CONFIG_PM_GENERIC_DOMAINS_OF=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
CONFIG_ACPI_DEBUGGER=y
# CONFIG_ACPI_DEBUGGER_USER is not set
# CONFIG_ACPI_SPCR_TABLE is not set
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_PROCFS_POWER is not set
# CONFIG_ACPI_REV_OVERRIDE_POSSIBLE is not set
CONFIG_ACPI_EC_DEBUGFS=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_IPMI is not set
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=y
# CONFIG_ACPI_THERMAL is not set
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=y
CONFIG_ACPI_HED=y
CONFIG_ACPI_CUSTOM_METHOD=y
CONFIG_ACPI_BGRT=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_EINJ=y
CONFIG_ACPI_APEI_ERST_DEBUG=m
CONFIG_DPTF_POWER=y
CONFIG_ACPI_WATCHDOG=y
CONFIG_PMIC_OPREGION=y
# CONFIG_CHT_DC_TI_PMIC_OPREGION is not set
CONFIG_ACPI_CONFIGFS=y
CONFIG_TPS68470_PMIC_OPREGION=y
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y
CONFIG_X86_APM_BOOT=y
CONFIG_APM=y
CONFIG_APM_IGNORE_USER_SUSPEND=y
CONFIG_APM_DO_ENABLE=y
# CONFIG_APM_CPU_IDLE is not set
# CONFIG_APM_DISPLAY_BLANK is not set
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
CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=m
CONFIG_CPU_FREQ_GOV_POWERSAVE=m
CONFIG_CPU_FREQ_GOV_USERSPACE=y
# CONFIG_CPU_FREQ_GOV_ONDEMAND is not set
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_CPUFREQ_DT=m
CONFIG_CPUFREQ_DT_PLATDEV=y
CONFIG_X86_INTEL_PSTATE=y
CONFIG_X86_PCC_CPUFREQ=m
# CONFIG_X86_ACPI_CPUFREQ is not set
CONFIG_X86_POWERNOW_K6=y
CONFIG_X86_POWERNOW_K7=m
CONFIG_X86_POWERNOW_K7_ACPI=y
CONFIG_X86_GX_SUSPMOD=y
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_SPEEDSTEP_ICH=m
CONFIG_X86_SPEEDSTEP_SMI=y
CONFIG_X86_P4_CLOCKMOD=y
CONFIG_X86_CPUFREQ_NFORCE2=m
CONFIG_X86_LONGRUN=m
CONFIG_X86_LONGHAUL=y
CONFIG_X86_E_POWERSAVER=y

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
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is not set
# CONFIG_INTEL_IDLE is not set

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
CONFIG_PCI_GOBIOS=y
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
# CONFIG_PCI_GOOLPC is not set
# CONFIG_PCI_GOANY is not set
CONFIG_PCI_BIOS=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
CONFIG_PCIEPORTBUS=y
# CONFIG_PCIEAER is not set
# CONFIG_PCIEASPM is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_PTM=y
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_REALLOC_ENABLE_AUTO=y
# CONFIG_PCI_STUB is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
# CONFIG_HOTPLUG_PCI is not set

#
# Cadence PCIe controllers support
#
CONFIG_PCIE_CADENCE=y
CONFIG_PCIE_CADENCE_HOST=y

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
# CONFIG_PCI_ENDPOINT is not set

#
# PCI switch controller drivers
#
CONFIG_PCI_SW_SWITCHTEC=m
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_SCx200 is not set
CONFIG_OLPC=y
# CONFIG_OLPC_XO1_PM is not set
# CONFIG_OLPC_XO15_SCI is not set
CONFIG_ALIX=y
CONFIG_NET5501=y
# CONFIG_GEOS is not set
CONFIG_AMD_NB=y
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set
# CONFIG_X86_SYSFB is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_HAVE_AOUT=y
CONFIG_BINFMT_AOUT=y
# CONFIG_BINFMT_MISC is not set
# CONFIG_COREDUMP is not set
CONFIG_COMPAT_32=y
CONFIG_HAVE_ATOMIC_IOMAP=y
CONFIG_X86_DEV_DMA_OPS=y
CONFIG_X86_DMA_REMAP=y
CONFIG_NET=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y

#
# Networking options
#
CONFIG_PACKET=m
# CONFIG_PACKET_DIAG is not set
CONFIG_UNIX=y
# CONFIG_UNIX_DIAG is not set
CONFIG_TLS=m
CONFIG_XFRM=y
CONFIG_XFRM_ALGO=y
# CONFIG_XFRM_USER is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
# CONFIG_XFRM_STATISTICS is not set
CONFIG_XFRM_IPCOMP=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
# CONFIG_IP_MULTIPLE_TABLES is not set
# CONFIG_IP_ROUTE_MULTIPATH is not set
# CONFIG_IP_ROUTE_VERBOSE is not set
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
CONFIG_IP_PNP_RARP=y
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=y
# CONFIG_NET_IPGRE is not set
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=y
CONFIG_NET_UDP_TUNNEL=y
CONFIG_NET_FOU=m
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=y
# CONFIG_INET_ESP is not set
CONFIG_INET_IPCOMP=y
CONFIG_INET_XFRM_TUNNEL=y
CONFIG_INET_TUNNEL=y
# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
CONFIG_INET_XFRM_MODE_TUNNEL=y
# CONFIG_INET_XFRM_MODE_BEET is not set
# CONFIG_INET_DIAG is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=m
CONFIG_IPV6_ROUTER_PREF=y
# CONFIG_IPV6_ROUTE_INFO is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
CONFIG_INET6_IPCOMP=m
# CONFIG_IPV6_MIP6 is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
# CONFIG_INET6_XFRM_MODE_TRANSPORT is not set
CONFIG_INET6_XFRM_MODE_TUNNEL=m
CONFIG_INET6_XFRM_MODE_BEET=m
CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION=m
# CONFIG_IPV6_VTI is not set
CONFIG_IPV6_SIT=m
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_GRE=m
CONFIG_IPV6_FOU=m
CONFIG_IPV6_FOU_TUNNEL=m
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_NETLABEL=y
# CONFIG_NETWORK_SECMARK is not set
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
# CONFIG_NETFILTER is not set
CONFIG_IP_DCCP=y

#
# DCCP CCIDs Configuration
#
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
CONFIG_IP_DCCP_CCID3=y
# CONFIG_IP_DCCP_CCID3_DEBUG is not set
CONFIG_IP_DCCP_TFRC_LIB=y

#
# DCCP Kernel Hacking
#
CONFIG_IP_DCCP_DEBUG=y
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1 is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
# CONFIG_SCTP_COOKIE_HMAC_SHA1 is not set
# CONFIG_RDS is not set
CONFIG_TIPC=y
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_TIPC_DIAG=y
CONFIG_ATM=y
CONFIG_ATM_CLIP=m
CONFIG_ATM_CLIP_NO_ICMP=y
CONFIG_ATM_LANE=y
CONFIG_ATM_MPOA=y
CONFIG_ATM_BR2684=y
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
# CONFIG_L2TP_ETH is not set
CONFIG_STP=y
CONFIG_GARP=y
CONFIG_MRP=y
# CONFIG_BRIDGE is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=y
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
CONFIG_DECNET=m
# CONFIG_DECNET_ROUTER is not set
CONFIG_LLC=y
CONFIG_LLC2=m
# CONFIG_ATALK is not set
CONFIG_X25=y
# CONFIG_LAPB is not set
CONFIG_PHONET=m
CONFIG_6LOWPAN=m
CONFIG_6LOWPAN_DEBUGFS=y
CONFIG_6LOWPAN_NHC=m
CONFIG_6LOWPAN_NHC_DEST=m
# CONFIG_6LOWPAN_NHC_FRAGMENT is not set
CONFIG_6LOWPAN_NHC_HOP=m
CONFIG_6LOWPAN_NHC_IPV6=m
CONFIG_6LOWPAN_NHC_MOBILITY=m
CONFIG_6LOWPAN_NHC_ROUTING=m
CONFIG_6LOWPAN_NHC_UDP=m
CONFIG_6LOWPAN_GHC_EXT_HDR_HOP=m
CONFIG_6LOWPAN_GHC_UDP=m
CONFIG_6LOWPAN_GHC_ICMPV6=m
CONFIG_6LOWPAN_GHC_EXT_HDR_DEST=m
# CONFIG_6LOWPAN_GHC_EXT_HDR_FRAG is not set
CONFIG_6LOWPAN_GHC_EXT_HDR_ROUTE=m
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
CONFIG_IEEE802154_6LOWPAN=m
CONFIG_MAC802154=m
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=y
CONFIG_NET_SCH_HTB=y
# CONFIG_NET_SCH_HFSC is not set
# CONFIG_NET_SCH_ATM is not set
CONFIG_NET_SCH_PRIO=y
# CONFIG_NET_SCH_MULTIQ is not set
# CONFIG_NET_SCH_RED is not set
# CONFIG_NET_SCH_SFB is not set
# CONFIG_NET_SCH_SFQ is not set
# CONFIG_NET_SCH_TEQL is not set
# CONFIG_NET_SCH_TBF is not set
# CONFIG_NET_SCH_CBS is not set
CONFIG_NET_SCH_GRED=y
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=y
CONFIG_NET_SCH_DRR=y
CONFIG_NET_SCH_MQPRIO=y
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=y
# CONFIG_NET_SCH_CODEL is not set
CONFIG_NET_SCH_FQ_CODEL=m
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=y
CONFIG_NET_SCH_INGRESS=y
# CONFIG_NET_SCH_PLUG is not set
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
# CONFIG_DEFAULT_FQ_CODEL is not set
CONFIG_DEFAULT_PFIFO_FAST=y
CONFIG_DEFAULT_NET_SCH="pfifo_fast"

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=y
# CONFIG_NET_CLS_U32 is not set
CONFIG_NET_CLS_RSVP=y
CONFIG_NET_CLS_RSVP6=y
CONFIG_NET_CLS_FLOW=y
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=y
CONFIG_NET_CLS_MATCHALL=y
# CONFIG_NET_EMATCH is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=y
CONFIG_NET_ACT_GACT=y
# CONFIG_GACT_PROB is not set
# CONFIG_NET_ACT_MIRRED is not set
CONFIG_NET_ACT_SAMPLE=m
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=y
# CONFIG_NET_ACT_SIMP is not set
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=y
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=y
CONFIG_NET_ACT_SKBMOD=m
# CONFIG_NET_ACT_IFE is not set
CONFIG_NET_ACT_TUNNEL_KEY=m
CONFIG_NET_CLS_IND=y
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=y
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=m
# CONFIG_MPLS_ROUTING is not set
CONFIG_NET_NSH=m
CONFIG_HSR=y
CONFIG_NET_SWITCHDEV=y
# CONFIG_NET_L3_MASTER_DEV is not set
CONFIG_NET_NCSI=y
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
# CONFIG_BPF_STREAM_PARSER is not set
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
CONFIG_HAMRADIO=y

#
# Packet Radio protocols
#
# CONFIG_AX25 is not set
# CONFIG_CAN is not set
CONFIG_BT=y
CONFIG_BT_BREDR=y
# CONFIG_BT_RFCOMM is not set
CONFIG_BT_BNEP=y
# CONFIG_BT_BNEP_MC_FILTER is not set
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_HIDP=y
# CONFIG_BT_HS is not set
CONFIG_BT_LE=y
CONFIG_BT_6LOWPAN=m
CONFIG_BT_LEDS=y
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
CONFIG_BT_HCIBTSDIO=m
CONFIG_BT_HCIUART=y
CONFIG_BT_HCIUART_SERDEV=y
CONFIG_BT_HCIUART_H4=y
# CONFIG_BT_HCIUART_NOKIA is not set
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_ATH3K=y
CONFIG_BT_HCIUART_LL=y
# CONFIG_BT_HCIUART_3WIRE is not set
CONFIG_BT_HCIUART_INTEL=y
# CONFIG_BT_HCIUART_QCA is not set
CONFIG_BT_HCIUART_AG6XX=y
# CONFIG_BT_HCIUART_MRVL is not set
CONFIG_BT_HCIBCM203X=m
CONFIG_BT_HCIBPA10X=m
CONFIG_BT_HCIBFUSB=m
CONFIG_BT_HCIVHCI=y
# CONFIG_BT_MRVL is not set
# CONFIG_BT_ATH3K is not set
CONFIG_BT_WILINK=m
CONFIG_AF_RXRPC=y
CONFIG_AF_RXRPC_INJECT_LOSS=y
CONFIG_AF_RXRPC_DEBUG=y
CONFIG_RXKAD=y
CONFIG_AF_KCM=y
CONFIG_STREAM_PARSER=y
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set
# CONFIG_LIB80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_WIMAX=m
CONFIG_WIMAX_DEBUG_LEVEL=8
# CONFIG_RFKILL is not set
# CONFIG_NET_9P is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
CONFIG_NFC=m
# CONFIG_NFC_DIGITAL is not set
# CONFIG_NFC_NCI is not set
CONFIG_NFC_HCI=m
CONFIG_NFC_SHDLC=y

#
# Near Field Communication (NFC) devices
#
# CONFIG_NFC_MEI_PHY is not set
# CONFIG_NFC_PN544_I2C is not set
CONFIG_NFC_PN533=m
CONFIG_NFC_PN533_USB=m
CONFIG_NFC_PN533_I2C=m
# CONFIG_NFC_MICROREAD_I2C is not set
CONFIG_NFC_ST21NFCA=m
CONFIG_NFC_ST21NFCA_I2C=m
CONFIG_PSAMPLE=m
CONFIG_NET_IFE=y
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_DEVLINK=m
CONFIG_MAY_USE_DEVLINK=m

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
# CONFIG_PREVENT_FIRMWARE_BUILD is not set
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_TEST_ASYNC_DRIVER_PROBE=m
# CONFIG_SYS_HYPERVISOR is not set
# CONFIG_GENERIC_CPU_DEVICES is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_W1=m
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_SOUNDWIRE=m
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y
# CONFIG_DMA_CMA is not set

#
# Bus devices
#
CONFIG_SIMPLE_PM_BUS=y
CONFIG_CONNECTOR=m
CONFIG_MTD=y
# CONFIG_MTD_TESTS is not set
CONFIG_MTD_REDBOOT_PARTS=m
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
# CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
# CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
CONFIG_MTD_CMDLINE_PARTS=m
CONFIG_MTD_OF_PARTS=m
CONFIG_MTD_AR7_PARTS=y

#
# Partition parsers
#

#
# User Modules And Translation Layers
#
CONFIG_MTD_OOPS=y
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
# CONFIG_MTD_CFI is not set
# CONFIG_MTD_JEDECPROBE is not set
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
CONFIG_MTD_RAM=y
# CONFIG_MTD_ROM is not set
CONFIG_MTD_ABSENT=y

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
# CONFIG_MTD_PHYSMAP_OF is not set
# CONFIG_MTD_PCI is not set
# CONFIG_MTD_GPIO_ADDR is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
CONFIG_MTD_PLATRAM=y
# CONFIG_MTD_LATCH_ADDR is not set

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
CONFIG_MTD_DATAFLASH=y
CONFIG_MTD_DATAFLASH_WRITE_VERIFY=y
# CONFIG_MTD_DATAFLASH_OTP is not set
CONFIG_MTD_M25P80=m
CONFIG_MTD_MCHP23K256=m
# CONFIG_MTD_SST25L is not set
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_PHRAM is not set
CONFIG_MTD_MTDRAM=y
CONFIG_MTDRAM_TOTAL_SIZE=4096
CONFIG_MTDRAM_ERASE_SIZE=128

#
# Disk-On-Chip Device Drivers
#
CONFIG_MTD_DOCG3=y
CONFIG_BCH_CONST_M=14
CONFIG_BCH_CONST_T=4
CONFIG_MTD_NAND_ECC=m
# CONFIG_MTD_NAND_ECC_SMC is not set
CONFIG_MTD_NAND=m
# CONFIG_MTD_NAND_ECC_BCH is not set
CONFIG_MTD_SM_COMMON=m
# CONFIG_MTD_NAND_DENALI_PCI is not set
# CONFIG_MTD_NAND_DENALI_DT is not set
CONFIG_MTD_NAND_GPIO=m
# CONFIG_MTD_NAND_OMAP_BCH_BUILD is not set
CONFIG_MTD_NAND_RICOH=m
# CONFIG_MTD_NAND_DISKONCHIP is not set
CONFIG_MTD_NAND_DOCG4=m
CONFIG_MTD_NAND_CAFE=m
CONFIG_MTD_NAND_CS553X=m
CONFIG_MTD_NAND_NANDSIM=m
CONFIG_MTD_NAND_PLATFORM=m
CONFIG_MTD_ONENAND=y
# CONFIG_MTD_ONENAND_VERIFY_WRITE is not set
CONFIG_MTD_ONENAND_GENERIC=m
CONFIG_MTD_ONENAND_OTP=y
CONFIG_MTD_ONENAND_2X_PROGRAM=y

#
# LPDDR & LPDDR2 PCM memory drivers
#
# CONFIG_MTD_LPDDR is not set
CONFIG_MTD_SPI_NOR=y
# CONFIG_MTD_MT81xx_NOR is not set
# CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
CONFIG_SPI_INTEL_SPI=y
CONFIG_SPI_INTEL_SPI_PCI=y
CONFIG_SPI_INTEL_SPI_PLATFORM=m
CONFIG_MTD_UBI=y
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
CONFIG_MTD_UBI_FASTMAP=y
CONFIG_MTD_UBI_GLUEBI=y
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
CONFIG_OF_RESOLVE=y
CONFIG_OF_OVERLAY=y
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
CONFIG_PARPORT_PC_SUPERIO=y
# CONFIG_PARPORT_GSC is not set
CONFIG_PARPORT_AX88796=m
# CONFIG_PARPORT_1284 is not set
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

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
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
CONFIG_DUMMY_IRQ=y
# CONFIG_IBM_ASM is not set
CONFIG_PHANTOM=m
CONFIG_SGI_IOC4=m
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
CONFIG_ICS932S401=m
CONFIG_ENCLOSURE_SERVICES=y
CONFIG_CS5535_MFGPT=y
CONFIG_CS5535_MFGPT_DEFAULT_IRQ=7
CONFIG_CS5535_CLOCK_EVENT_SRC=y
# CONFIG_HP_ILO is not set
CONFIG_APDS9802ALS=y
# CONFIG_ISL29003 is not set
CONFIG_ISL29020=y
# CONFIG_SENSORS_TSL2550 is not set
# CONFIG_SENSORS_BH1770 is not set
CONFIG_SENSORS_APDS990X=y
CONFIG_HMC6352=y
# CONFIG_DS1682 is not set
CONFIG_PCH_PHUB=y
CONFIG_USB_SWITCH_FSA9480=m
CONFIG_LATTICE_ECP3_CONFIG=m
# CONFIG_SRAM is not set
CONFIG_PCI_ENDPOINT_TEST=y
CONFIG_MISC_RTSX=y
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
CONFIG_EEPROM_AT25=m
# CONFIG_EEPROM_LEGACY is not set
# CONFIG_EEPROM_MAX6875 is not set
# CONFIG_EEPROM_93CX6 is not set
CONFIG_EEPROM_93XX46=y
# CONFIG_EEPROM_IDT_89HPESX is not set
CONFIG_CB710_CORE=y
CONFIG_CB710_DEBUG=y
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
CONFIG_TI_ST=y
# CONFIG_SENSORS_LIS3_I2C is not set
CONFIG_ALTERA_STAPL=y
CONFIG_INTEL_MEI=y
CONFIG_INTEL_MEI_ME=y
CONFIG_INTEL_MEI_TXE=m
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
# CONFIG_ECHO is not set
# CONFIG_CXL_BASE is not set
# CONFIG_CXL_AFU_DRIVER_OPS is not set
# CONFIG_CXL_LIB is not set
# CONFIG_OCXL_BASE is not set
CONFIG_MISC_RTSX_PCI=y
CONFIG_MISC_RTSX_USB=y
CONFIG_HAVE_IDE=y

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# CONFIG_SCSI_DMA is not set
# CONFIG_SCSI_NETLINK is not set
CONFIG_FUSION=y
CONFIG_FUSION_MAX_SGE=128
CONFIG_FUSION_LOGGING=y

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=y
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_NET=y
# CONFIG_FIREWIRE_NOSY is not set
CONFIG_MACINTOSH_DRIVERS=y
# CONFIG_MAC_EMUMOUSEBTN is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_EQUALIZER is not set
# CONFIG_IFB is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_GTP is not set
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_NTB_NETDEV is not set
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
# CONFIG_VIRTIO_NET is not set
# CONFIG_NLMON is not set
# CONFIG_VSOCKMON is not set
# CONFIG_ARCNET is not set
CONFIG_ATM_DRIVERS=y
# CONFIG_ATM_DUMMY is not set
# CONFIG_ATM_TCP is not set
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_FIRESTREAM is not set
# CONFIG_ATM_ZATM is not set
# CONFIG_ATM_NICSTAR is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_AMBASSADOR is not set
# CONFIG_ATM_HORIZON is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E is not set
# CONFIG_ATM_HE is not set
# CONFIG_ATM_SOLOS is not set

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
# CONFIG_ENA_ETHERNET is not set
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
CONFIG_NET_VENDOR_HP=y
# CONFIG_HP100 is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
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
# CONFIG_IXGBE_DCB is not set
# CONFIG_IXGBEVF is not set
# CONFIG_I40E is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
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
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_NI=y
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
# CONFIG_QCA7000_SPI is not set
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
# CONFIG_SMC9194 is not set
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
# CONFIG_MDIO_BUS is not set
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
# WiMAX Wireless Broadband devices
#
# CONFIG_WIMAX_I2400M_USB is not set
# CONFIG_WAN is not set
CONFIG_IEEE802154_DRIVERS=m
# CONFIG_IEEE802154_FAKELB is not set
# CONFIG_IEEE802154_AT86RF230 is not set
# CONFIG_IEEE802154_MRF24J40 is not set
# CONFIG_IEEE802154_CC2520 is not set
# CONFIG_IEEE802154_ATUSB is not set
# CONFIG_IEEE802154_ADF7242 is not set
# CONFIG_IEEE802154_CA8210 is not set
# CONFIG_IEEE802154_MCR20A is not set
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
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_EVBUG=y

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
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
# CONFIG_KEYBOARD_GOLDFISH_EVENTS is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_STMPE is not set
# CONFIG_KEYBOARD_OMAP4 is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CROS_EC is not set
# CONFIG_KEYBOARD_CAP11XX is not set
# CONFIG_KEYBOARD_BCM is not set
# CONFIG_INPUT_MOUSE is not set
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=y
# CONFIG_JOYSTICK_A3D is not set
# CONFIG_JOYSTICK_ADI is not set
CONFIG_JOYSTICK_COBRA=m
CONFIG_JOYSTICK_GF2K=y
CONFIG_JOYSTICK_GRIP=m
CONFIG_JOYSTICK_GRIP_MP=y
CONFIG_JOYSTICK_GUILLEMOT=m
CONFIG_JOYSTICK_INTERACT=y
# CONFIG_JOYSTICK_SIDEWINDER is not set
CONFIG_JOYSTICK_TMDC=m
CONFIG_JOYSTICK_IFORCE=m
# CONFIG_JOYSTICK_IFORCE_USB is not set
CONFIG_JOYSTICK_IFORCE_232=y
CONFIG_JOYSTICK_WARRIOR=m
# CONFIG_JOYSTICK_MAGELLAN is not set
CONFIG_JOYSTICK_SPACEORB=m
CONFIG_JOYSTICK_SPACEBALL=m
CONFIG_JOYSTICK_STINGER=y
CONFIG_JOYSTICK_TWIDJOY=m
# CONFIG_JOYSTICK_ZHENHUA is not set
CONFIG_JOYSTICK_DB9=y
CONFIG_JOYSTICK_GAMECON=y
CONFIG_JOYSTICK_TURBOGRAFX=m
CONFIG_JOYSTICK_AS5011=m
CONFIG_JOYSTICK_JOYDUMP=m
CONFIG_JOYSTICK_XPAD=m
CONFIG_JOYSTICK_XPAD_FF=y
CONFIG_JOYSTICK_XPAD_LEDS=y
# CONFIG_JOYSTICK_PSXPAD_SPI is not set
# CONFIG_INPUT_TABLET is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
CONFIG_TOUCHSCREEN_88PM860X=m
CONFIG_TOUCHSCREEN_ADS7846=m
# CONFIG_TOUCHSCREEN_AD7877 is not set
CONFIG_TOUCHSCREEN_AD7879=y
CONFIG_TOUCHSCREEN_AD7879_I2C=y
CONFIG_TOUCHSCREEN_AD7879_SPI=m
CONFIG_TOUCHSCREEN_AR1021_I2C=m
CONFIG_TOUCHSCREEN_ATMEL_MXT=m
# CONFIG_TOUCHSCREEN_ATMEL_MXT_T37 is not set
# CONFIG_TOUCHSCREEN_AUO_PIXCIR is not set
# CONFIG_TOUCHSCREEN_BU21013 is not set
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8318 is not set
CONFIG_TOUCHSCREEN_CY8CTMG110=y
CONFIG_TOUCHSCREEN_CYTTSP_CORE=m
CONFIG_TOUCHSCREEN_CYTTSP_I2C=m
# CONFIG_TOUCHSCREEN_CYTTSP_SPI is not set
CONFIG_TOUCHSCREEN_CYTTSP4_CORE=m
CONFIG_TOUCHSCREEN_CYTTSP4_I2C=m
CONFIG_TOUCHSCREEN_CYTTSP4_SPI=m
# CONFIG_TOUCHSCREEN_DA9034 is not set
CONFIG_TOUCHSCREEN_DA9052=y
# CONFIG_TOUCHSCREEN_DYNAPRO is not set
CONFIG_TOUCHSCREEN_HAMPSHIRE=m
CONFIG_TOUCHSCREEN_EETI=m
CONFIG_TOUCHSCREEN_EGALAX=y
# CONFIG_TOUCHSCREEN_EGALAX_SERIAL is not set
# CONFIG_TOUCHSCREEN_EXC3000 is not set
CONFIG_TOUCHSCREEN_FUJITSU=y
CONFIG_TOUCHSCREEN_GOODIX=m
CONFIG_TOUCHSCREEN_HIDEEP=m
CONFIG_TOUCHSCREEN_ILI210X=y
# CONFIG_TOUCHSCREEN_S6SY761 is not set
CONFIG_TOUCHSCREEN_GUNZE=m
CONFIG_TOUCHSCREEN_EKTF2127=y
CONFIG_TOUCHSCREEN_ELAN=m
CONFIG_TOUCHSCREEN_ELO=y
# CONFIG_TOUCHSCREEN_WACOM_W8001 is not set
CONFIG_TOUCHSCREEN_WACOM_I2C=m
CONFIG_TOUCHSCREEN_MAX11801=y
# CONFIG_TOUCHSCREEN_MCS5000 is not set
CONFIG_TOUCHSCREEN_MMS114=m
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
CONFIG_TOUCHSCREEN_MTOUCH=m
# CONFIG_TOUCHSCREEN_IMX6UL_TSC is not set
CONFIG_TOUCHSCREEN_INEXIO=m
CONFIG_TOUCHSCREEN_MK712=y
CONFIG_TOUCHSCREEN_HTCPEN=m
CONFIG_TOUCHSCREEN_PENMOUNT=m
# CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
CONFIG_TOUCHSCREEN_TOUCHRIGHT=y
# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
CONFIG_TOUCHSCREEN_PIXCIR=y
CONFIG_TOUCHSCREEN_WDT87XX_I2C=m
CONFIG_TOUCHSCREEN_WM831X=m
CONFIG_TOUCHSCREEN_WM97XX=m
CONFIG_TOUCHSCREEN_WM9705=y
# CONFIG_TOUCHSCREEN_WM9712 is not set
# CONFIG_TOUCHSCREEN_WM9713 is not set
CONFIG_TOUCHSCREEN_USB_COMPOSITE=y
CONFIG_TOUCHSCREEN_MC13783=y
# CONFIG_TOUCHSCREEN_USB_EGALAX is not set
CONFIG_TOUCHSCREEN_USB_PANJIT=y
CONFIG_TOUCHSCREEN_USB_3M=y
# CONFIG_TOUCHSCREEN_USB_ITM is not set
CONFIG_TOUCHSCREEN_USB_ETURBO=y
CONFIG_TOUCHSCREEN_USB_GUNZE=y
CONFIG_TOUCHSCREEN_USB_DMC_TSC10=y
CONFIG_TOUCHSCREEN_USB_IRTOUCH=y
CONFIG_TOUCHSCREEN_USB_IDEALTEK=y
CONFIG_TOUCHSCREEN_USB_GENERAL_TOUCH=y
CONFIG_TOUCHSCREEN_USB_GOTOP=y
# CONFIG_TOUCHSCREEN_USB_JASTEC is not set
# CONFIG_TOUCHSCREEN_USB_ELO is not set
# CONFIG_TOUCHSCREEN_USB_E2I is not set
# CONFIG_TOUCHSCREEN_USB_ZYTRONIC is not set
CONFIG_TOUCHSCREEN_USB_ETT_TC45USB=y
# CONFIG_TOUCHSCREEN_USB_NEXIO is not set
# CONFIG_TOUCHSCREEN_USB_EASYTOUCH is not set
CONFIG_TOUCHSCREEN_TOUCHIT213=y
CONFIG_TOUCHSCREEN_TSC_SERIO=y
CONFIG_TOUCHSCREEN_TSC200X_CORE=y
CONFIG_TOUCHSCREEN_TSC2004=y
CONFIG_TOUCHSCREEN_TSC2005=y
CONFIG_TOUCHSCREEN_TSC2007=y
# CONFIG_TOUCHSCREEN_RM_TS is not set
CONFIG_TOUCHSCREEN_SILEAD=m
# CONFIG_TOUCHSCREEN_SIS_I2C is not set
CONFIG_TOUCHSCREEN_ST1232=m
# CONFIG_TOUCHSCREEN_STMFTS is not set
CONFIG_TOUCHSCREEN_STMPE=y
CONFIG_TOUCHSCREEN_SURFACE3_SPI=y
CONFIG_TOUCHSCREEN_SX8654=y
# CONFIG_TOUCHSCREEN_TPS6507X is not set
CONFIG_TOUCHSCREEN_ZET6223=y
# CONFIG_TOUCHSCREEN_ZFORCE is not set
CONFIG_TOUCHSCREEN_COLIBRI_VF50=m
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_88PM860X_ONKEY=y
# CONFIG_INPUT_88PM80X_ONKEY is not set
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_ATMEL_CAPTOUCH is not set
# CONFIG_INPUT_BMA150 is not set
CONFIG_INPUT_E3X0_BUTTON=m
# CONFIG_INPUT_MC13783_PWRBUTTON is not set
CONFIG_INPUT_MMA8450=m
# CONFIG_INPUT_APANEL is not set
CONFIG_INPUT_GP2A=m
# CONFIG_INPUT_GPIO_BEEPER is not set
CONFIG_INPUT_GPIO_DECODER=y
# CONFIG_INPUT_WISTRON_BTNS is not set
# CONFIG_INPUT_ATLAS_BTNS is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
CONFIG_INPUT_KEYSPAN_REMOTE=m
CONFIG_INPUT_KXTJ9=y
CONFIG_INPUT_KXTJ9_POLLED_MODE=y
CONFIG_INPUT_POWERMATE=y
CONFIG_INPUT_YEALINK=m
# CONFIG_INPUT_CM109 is not set
CONFIG_INPUT_RETU_PWRBUTTON=m
CONFIG_INPUT_TPS65218_PWRBUTTON=m
# CONFIG_INPUT_UINPUT is not set
CONFIG_INPUT_PALMAS_PWRBUTTON=m
CONFIG_INPUT_PCF50633_PMU=m
# CONFIG_INPUT_PCF8574 is not set
# CONFIG_INPUT_RK805_PWRKEY is not set
# CONFIG_INPUT_GPIO_ROTARY_ENCODER is not set
# CONFIG_INPUT_DA9052_ONKEY is not set
CONFIG_INPUT_DA9055_ONKEY=m
# CONFIG_INPUT_DA9063_ONKEY is not set
CONFIG_INPUT_WM831X_ON=m
# CONFIG_INPUT_ADXL34X is not set
CONFIG_INPUT_IMS_PCU=y
# CONFIG_INPUT_CMA3000 is not set
CONFIG_INPUT_IDEAPAD_SLIDEBAR=m
CONFIG_INPUT_DRV260X_HAPTICS=m
# CONFIG_INPUT_DRV2665_HAPTICS is not set
CONFIG_INPUT_DRV2667_HAPTICS=m
CONFIG_RMI4_CORE=y
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SPI=y
CONFIG_RMI4_SMB=m
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
# CONFIG_SERIO_PARKBD is not set
CONFIG_SERIO_PCIPS2=y
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
CONFIG_SERIO_ALTERA_PS2=m
CONFIG_SERIO_PS2MULT=y
CONFIG_SERIO_ARC_PS2=m
# CONFIG_SERIO_APBPS2 is not set
# CONFIG_SERIO_OLPC_APSP is not set
CONFIG_SERIO_GPIO_PS2=y
CONFIG_USERIO=y
CONFIG_GAMEPORT=y
# CONFIG_GAMEPORT_NS558 is not set
CONFIG_GAMEPORT_L4=m
CONFIG_GAMEPORT_EMU10K1=y
CONFIG_GAMEPORT_FM801=m

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_NOZOMI=m
CONFIG_N_GSM=m
# CONFIG_TRACE_ROUTER is not set
CONFIG_TRACE_SINK=m
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
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=m
CONFIG_SERIAL_8250_MEN_MCB=m
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
CONFIG_SERIAL_8250_ASPEED_VUART=m
# CONFIG_SERIAL_8250_FSL is not set
CONFIG_SERIAL_8250_DW=m
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=m
CONFIG_SERIAL_8250_MID=m
CONFIG_SERIAL_8250_MOXA=m
# CONFIG_SERIAL_OF_PLATFORM is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_MAX3100=m
CONFIG_SERIAL_MAX310X=m
CONFIG_SERIAL_UARTLITE=y
CONFIG_SERIAL_UARTLITE_CONSOLE=y
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=y
# CONFIG_SERIAL_SCCNXP is not set
CONFIG_SERIAL_SC16IS7XX_CORE=m
CONFIG_SERIAL_SC16IS7XX=m
CONFIG_SERIAL_SC16IS7XX_I2C=y
CONFIG_SERIAL_SC16IS7XX_SPI=y
CONFIG_SERIAL_TIMBERDALE=y
CONFIG_SERIAL_ALTERA_JTAGUART=y
CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE=y
# CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE_BYPASS is not set
CONFIG_SERIAL_ALTERA_UART=m
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
CONFIG_SERIAL_IFX6X60=m
# CONFIG_SERIAL_PCH_UART is not set
CONFIG_SERIAL_XILINX_PS_UART=m
# CONFIG_SERIAL_ARC is not set
CONFIG_SERIAL_RP2=y
CONFIG_SERIAL_RP2_NR_UARTS=32
CONFIG_SERIAL_FSL_LPUART=y
# CONFIG_SERIAL_FSL_LPUART_CONSOLE is not set
CONFIG_SERIAL_CONEXANT_DIGICOLOR=y
CONFIG_SERIAL_CONEXANT_DIGICOLOR_CONSOLE=y
CONFIG_SERIAL_MEN_Z135=m
CONFIG_SERIAL_DEV_BUS=y
# CONFIG_SERIAL_DEV_CTRL_TTYPORT is not set
CONFIG_TTY_PRINTK=y
# CONFIG_PRINTER is not set
CONFIG_PPDEV=m
# CONFIG_VIRTIO_CONSOLE is not set
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PROC_INTERFACE=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
# CONFIG_IPMI_DEVICE_INTERFACE is not set
CONFIG_IPMI_SI=m
# CONFIG_IPMI_SSIF is not set
# CONFIG_IPMI_WATCHDOG is not set
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=m
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
CONFIG_HW_RANDOM_GEODE=m
CONFIG_HW_RANDOM_VIA=m
# CONFIG_HW_RANDOM_VIRTIO is not set
CONFIG_NVRAM=y
CONFIG_DTLK=y
CONFIG_R3964=y
CONFIG_APPLICOM=y
CONFIG_SONYPI=y
CONFIG_MWAVE=y
# CONFIG_PC8736x_GPIO is not set
CONFIG_NSC_GPIO=y
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
CONFIG_TCG_TPM=y
CONFIG_TCG_TIS_CORE=m
# CONFIG_TCG_TIS is not set
CONFIG_TCG_TIS_SPI=m
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=y
# CONFIG_TCG_TIS_I2C_NUVOTON is not set
CONFIG_TCG_NSC=y
# CONFIG_TCG_ATMEL is not set
CONFIG_TCG_INFINEON=y
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
CONFIG_DEVPORT=y
CONFIG_XILLYBUS=m
# CONFIG_XILLYBUS_PCIE is not set
CONFIG_XILLYBUS_OF=m

#
# I2C support
#
CONFIG_I2C=y
# CONFIG_ACPI_I2C_OPREGION is not set
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_ARB_GPIO_CHALLENGE=m
CONFIG_I2C_MUX_GPIO=m
CONFIG_I2C_MUX_GPMUX=m
CONFIG_I2C_MUX_LTC4306=m
# CONFIG_I2C_MUX_PCA9541 is not set
CONFIG_I2C_MUX_PCA954x=m
CONFIG_I2C_MUX_PINCTRL=m
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_DEMUX_PINCTRL=m
CONFIG_I2C_MUX_MLXCPLD=m
# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
# CONFIG_I2C_ALGOPCF is not set
CONFIG_I2C_ALGOPCA=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_ALI1535=m
CONFIG_I2C_ALI1563=m
CONFIG_I2C_ALI15X3=m
# CONFIG_I2C_AMD756 is not set
CONFIG_I2C_AMD8111=y
CONFIG_I2C_I801=m
# CONFIG_I2C_ISCH is not set
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=y
CONFIG_I2C_VIA=y
# CONFIG_I2C_VIAPRO is not set

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
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PCI=m
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
CONFIG_I2C_EG20T=m
CONFIG_I2C_EMEV2=y
CONFIG_I2C_GPIO=m
# CONFIG_I2C_GPIO_FAULT_INJECTOR is not set
CONFIG_I2C_KEMPLD=m
CONFIG_I2C_OCORES=y
# CONFIG_I2C_PCA_PLATFORM is not set
CONFIG_I2C_PXA=y
CONFIG_I2C_PXA_PCI=y
CONFIG_I2C_RK3X=m
# CONFIG_I2C_SIMTEC is not set
CONFIG_I2C_XILINX=y

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
# CONFIG_I2C_DLN2 is not set
# CONFIG_I2C_PARPORT is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
CONFIG_I2C_ROBOTFUZZ_OSIF=y
CONFIG_I2C_TAOS_EVM=m
CONFIG_I2C_TINY_USB=y

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_PCA_ISA=y
CONFIG_I2C_CROS_EC_TUNNEL=m
CONFIG_SCx200_ACB=m
CONFIG_I2C_STUB=m
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=y
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
CONFIG_SPI=y
CONFIG_SPI_DEBUG=y
CONFIG_SPI_MASTER=y

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
CONFIG_SPI_BITBANG=y
CONFIG_SPI_BUTTERFLY=y
# CONFIG_SPI_CADENCE is not set
CONFIG_SPI_DESIGNWARE=y
CONFIG_SPI_DW_PCI=m
CONFIG_SPI_DW_MMIO=m
CONFIG_SPI_DLN2=y
CONFIG_SPI_GPIO=m
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_FSL_SPI is not set
CONFIG_SPI_OC_TINY=m
CONFIG_SPI_PXA2XX=m
CONFIG_SPI_PXA2XX_PCI=m
CONFIG_SPI_ROCKCHIP=y
CONFIG_SPI_SC18IS602=y
CONFIG_SPI_TOPCLIFF_PCH=y
# CONFIG_SPI_XCOMM is not set
CONFIG_SPI_XILINX=y
CONFIG_SPI_ZYNQMP_GQSPI=y

#
# SPI Protocol Masters
#
CONFIG_SPI_SPIDEV=m
CONFIG_SPI_LOOPBACK_TEST=m
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
# CONFIG_SPMI is not set
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
CONFIG_HSI_CHAR=m
# CONFIG_PPS is not set

#
# PTP clock support
#

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
CONFIG_PTP_1588_CLOCK_PCH=m
CONFIG_PINCTRL=y
CONFIG_GENERIC_PINCTRL_GROUPS=y
CONFIG_PINMUX=y
CONFIG_GENERIC_PINMUX_FUNCTIONS=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
CONFIG_DEBUG_PINCTRL=y
CONFIG_PINCTRL_AS3722=m
CONFIG_PINCTRL_AMD=y
CONFIG_PINCTRL_MCP23S08=y
CONFIG_PINCTRL_SINGLE=y
# CONFIG_PINCTRL_SX150X is not set
# CONFIG_PINCTRL_PALMAS is not set
CONFIG_PINCTRL_RK805=m
CONFIG_PINCTRL_BAYTRAIL=y
CONFIG_PINCTRL_CHERRYVIEW=y
CONFIG_PINCTRL_INTEL=y
CONFIG_PINCTRL_BROXTON=m
CONFIG_PINCTRL_CANNONLAKE=m
# CONFIG_PINCTRL_CEDARFORK is not set
CONFIG_PINCTRL_DENVERTON=m
# CONFIG_PINCTRL_GEMINILAKE is not set
CONFIG_PINCTRL_LEWISBURG=m
CONFIG_PINCTRL_SUNRISEPOINT=y
CONFIG_GPIOLIB=y
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
CONFIG_DEBUG_GPIO=y
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=m
CONFIG_GPIO_ALTERA=y
CONFIG_GPIO_AMDPT=m
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_FTGPIO010 is not set
CONFIG_GPIO_GENERIC_PLATFORM=y
# CONFIG_GPIO_GRGPIO is not set
CONFIG_GPIO_ICH=m
CONFIG_GPIO_LYNXPOINT=y
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_MENZ127 is not set
CONFIG_GPIO_MOCKUP=m
CONFIG_GPIO_STA2X11=y
CONFIG_GPIO_SYSCON=y
CONFIG_GPIO_VX855=y
CONFIG_GPIO_XILINX=m

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_F7188X=y
CONFIG_GPIO_IT87=y
CONFIG_GPIO_SCH=y
CONFIG_GPIO_SCH311X=y
CONFIG_GPIO_WINBOND=m
CONFIG_GPIO_WS16C48=y

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
CONFIG_GPIO_ADNP=m
CONFIG_GPIO_MAX7300=m
CONFIG_GPIO_MAX732X=m
CONFIG_GPIO_PCA953X=m
# CONFIG_GPIO_PCF857X is not set
CONFIG_GPIO_TPIC2810=m

#
# MFD GPIO expanders
#
# CONFIG_GPIO_ARIZONA is not set
# CONFIG_GPIO_BD9571MWV is not set
CONFIG_GPIO_CS5535=m
CONFIG_GPIO_DA9052=y
CONFIG_GPIO_DA9055=y
CONFIG_GPIO_DLN2=m
CONFIG_GPIO_JANZ_TTL=m
CONFIG_GPIO_KEMPLD=m
CONFIG_GPIO_LP873X=m
CONFIG_GPIO_LP87565=m
CONFIG_GPIO_PALMAS=y
CONFIG_GPIO_STMPE=y
# CONFIG_GPIO_TIMBERDALE is not set
# CONFIG_GPIO_TPS65086 is not set
# CONFIG_GPIO_TPS65218 is not set
CONFIG_GPIO_TPS65912=m
CONFIG_GPIO_TPS68470=y
CONFIG_GPIO_WM831X=m
# CONFIG_GPIO_WM8350 is not set

#
# PCI GPIO expanders
#
CONFIG_GPIO_AMD8111=y
CONFIG_GPIO_BT8XX=m
CONFIG_GPIO_ML_IOH=m
CONFIG_GPIO_PCH=y
CONFIG_GPIO_PCI_IDIO_16=y
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# CONFIG_GPIO_SODAVILLE is not set

#
# SPI GPIO expanders
#
CONFIG_GPIO_74X164=y
# CONFIG_GPIO_MAX3191X is not set
CONFIG_GPIO_MAX7301=y
CONFIG_GPIO_MC33880=y
CONFIG_GPIO_PISOSR=y
CONFIG_GPIO_XRA1403=y

#
# USB GPIO expanders
#
CONFIG_W1=y
CONFIG_W1_CON=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
CONFIG_W1_MASTER_DS2490=m
CONFIG_W1_MASTER_DS2482=y
# CONFIG_W1_MASTER_DS1WM is not set
# CONFIG_W1_MASTER_GPIO is not set

#
# 1-wire Slaves
#
# CONFIG_W1_SLAVE_THERM is not set
# CONFIG_W1_SLAVE_SMEM is not set
CONFIG_W1_SLAVE_DS2405=m
# CONFIG_W1_SLAVE_DS2408 is not set
# CONFIG_W1_SLAVE_DS2413 is not set
CONFIG_W1_SLAVE_DS2406=m
CONFIG_W1_SLAVE_DS2423=y
# CONFIG_W1_SLAVE_DS2805 is not set
# CONFIG_W1_SLAVE_DS2431 is not set
CONFIG_W1_SLAVE_DS2433=m
# CONFIG_W1_SLAVE_DS2433_CRC is not set
# CONFIG_W1_SLAVE_DS2438 is not set
# CONFIG_W1_SLAVE_DS2760 is not set
# CONFIG_W1_SLAVE_DS2780 is not set
# CONFIG_W1_SLAVE_DS2781 is not set
CONFIG_W1_SLAVE_DS28E04=m
CONFIG_W1_SLAVE_DS28E17=m
# CONFIG_POWER_AVS is not set
# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
CONFIG_POWER_SUPPLY_DEBUG=y
CONFIG_PDA_POWER=m
CONFIG_GENERIC_ADC_BATTERY=m
# CONFIG_WM831X_BACKUP is not set
# CONFIG_WM831X_POWER is not set
CONFIG_WM8350_POWER=m
# CONFIG_TEST_POWER is not set
CONFIG_BATTERY_88PM860X=m
CONFIG_BATTERY_ACT8945A=m
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
CONFIG_BATTERY_LEGO_EV3=m
# CONFIG_BATTERY_OLPC is not set
# CONFIG_BATTERY_SBS is not set
CONFIG_CHARGER_SBS=y
CONFIG_MANAGER_SBS=m
CONFIG_BATTERY_BQ27XXX=m
CONFIG_BATTERY_BQ27XXX_I2C=m
CONFIG_BATTERY_BQ27XXX_HDQ=m
# CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM is not set
CONFIG_BATTERY_DA9030=m
# CONFIG_BATTERY_DA9052 is not set
CONFIG_BATTERY_MAX17040=m
CONFIG_BATTERY_MAX17042=y
CONFIG_BATTERY_MAX1721X=m
CONFIG_CHARGER_88PM860X=m
CONFIG_CHARGER_PCF50633=m
# CONFIG_CHARGER_ISP1704 is not set
CONFIG_CHARGER_MAX8903=y
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
CONFIG_CHARGER_LTC3651=y
CONFIG_CHARGER_DETECTOR_MAX14656=y
# CONFIG_CHARGER_BQ2415X is not set
CONFIG_CHARGER_BQ24190=m
# CONFIG_CHARGER_BQ24257 is not set
CONFIG_CHARGER_BQ24735=y
CONFIG_CHARGER_BQ25890=m
# CONFIG_CHARGER_SMB347 is not set
CONFIG_CHARGER_TPS65090=m
CONFIG_CHARGER_TPS65217=m
CONFIG_BATTERY_GAUGE_LTC2941=y
CONFIG_BATTERY_GOLDFISH=y
CONFIG_BATTERY_RT5033=m
CONFIG_CHARGER_RT9455=m
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=y
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
# CONFIG_SENSORS_AD7414 is not set
CONFIG_SENSORS_AD7418=m
# CONFIG_SENSORS_ADM1021 is not set
CONFIG_SENSORS_ADM1025=y
CONFIG_SENSORS_ADM1026=y
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM9240 is not set
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7310=y
CONFIG_SENSORS_ADT7410=m
# CONFIG_SENSORS_ADT7411 is not set
# CONFIG_SENSORS_ADT7462 is not set
# CONFIG_SENSORS_ADT7470 is not set
# CONFIG_SENSORS_ADT7475 is not set
CONFIG_SENSORS_ASC7621=m
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
CONFIG_SENSORS_APPLESMC=m
# CONFIG_SENSORS_ASB100 is not set
CONFIG_SENSORS_ASPEED=y
CONFIG_SENSORS_ATXP1=y
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=y
CONFIG_SENSORS_DELL_SMM=y
# CONFIG_SENSORS_DA9052_ADC is not set
# CONFIG_SENSORS_DA9055 is not set
CONFIG_SENSORS_I5K_AMB=y
CONFIG_SENSORS_F71805F=y
CONFIG_SENSORS_F71882FG=y
CONFIG_SENSORS_F75375S=m
# CONFIG_SENSORS_MC13783_ADC is not set
CONFIG_SENSORS_FSCHMD=m
CONFIG_SENSORS_FTSTEUTATES=m
CONFIG_SENSORS_GL518SM=y
# CONFIG_SENSORS_GL520SM is not set
CONFIG_SENSORS_G760A=m
CONFIG_SENSORS_G762=m
CONFIG_SENSORS_GPIO_FAN=y
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
# CONFIG_SENSORS_IBMPEX is not set
CONFIG_SENSORS_IIO_HWMON=m
CONFIG_SENSORS_I5500=y
CONFIG_SENSORS_CORETEMP=y
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_JC42 is not set
CONFIG_SENSORS_POWR1220=m
CONFIG_SENSORS_LINEAGE=m
CONFIG_SENSORS_LTC2945=y
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC4151 is not set
CONFIG_SENSORS_LTC4215=y
CONFIG_SENSORS_LTC4222=y
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
# CONFIG_SENSORS_MAX16065 is not set
CONFIG_SENSORS_MAX1619=m
# CONFIG_SENSORS_MAX1668 is not set
CONFIG_SENSORS_MAX197=y
CONFIG_SENSORS_MAX31722=y
CONFIG_SENSORS_MAX6621=y
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=y
CONFIG_SENSORS_MAX6697=m
CONFIG_SENSORS_MAX31790=y
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_MENF21BMC_HWMON is not set
# CONFIG_SENSORS_ADCXX is not set
# CONFIG_SENSORS_LM63 is not set
CONFIG_SENSORS_LM70=m
# CONFIG_SENSORS_LM73 is not set
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=y
CONFIG_SENSORS_LM80=m
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM87 is not set
CONFIG_SENSORS_LM90=y
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=y
# CONFIG_SENSORS_LM95241 is not set
CONFIG_SENSORS_LM95245=y
CONFIG_SENSORS_PC87360=m
# CONFIG_SENSORS_PC87427 is not set
CONFIG_SENSORS_NTC_THERMISTOR=m
CONFIG_SENSORS_NCT6683=y
# CONFIG_SENSORS_NCT6775 is not set
CONFIG_SENSORS_NCT7802=y
# CONFIG_SENSORS_NCT7904 is not set
CONFIG_SENSORS_PCF8591=m
# CONFIG_PMBUS is not set
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
CONFIG_SENSORS_SHT3x=m
CONFIG_SENSORS_SHTC1=m
CONFIG_SENSORS_SIS5595=y
CONFIG_SENSORS_DME1737=y
CONFIG_SENSORS_EMC1403=m
CONFIG_SENSORS_EMC2103=m
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=y
# CONFIG_SENSORS_SMSC47B397 is not set
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
# CONFIG_SENSORS_SCH5636 is not set
CONFIG_SENSORS_STTS751=m
# CONFIG_SENSORS_SMM665 is not set
CONFIG_SENSORS_ADC128D818=m
CONFIG_SENSORS_ADS1015=m
# CONFIG_SENSORS_ADS7828 is not set
CONFIG_SENSORS_ADS7871=y
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=y
CONFIG_SENSORS_INA2XX=m
CONFIG_SENSORS_INA3221=m
CONFIG_SENSORS_TC74=y
# CONFIG_SENSORS_THMC50 is not set
CONFIG_SENSORS_TMP102=y
CONFIG_SENSORS_TMP103=y
# CONFIG_SENSORS_TMP108 is not set
# CONFIG_SENSORS_TMP401 is not set
CONFIG_SENSORS_TMP421=y
CONFIG_SENSORS_VIA_CPUTEMP=y
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_VT1211=m
# CONFIG_SENSORS_VT8231 is not set
CONFIG_SENSORS_W83773G=y
# CONFIG_SENSORS_W83781D is not set
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=y
# CONFIG_SENSORS_W83793 is not set
# CONFIG_SENSORS_W83795 is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=y
CONFIG_SENSORS_W83627EHF=m
CONFIG_SENSORS_WM831X=m
CONFIG_SENSORS_WM8350=y
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
CONFIG_SENSORS_ATK0110=y
CONFIG_THERMAL=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
# CONFIG_THERMAL_OF is not set
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
# CONFIG_THERMAL_GOV_USER_SPACE is not set
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
# CONFIG_CLOCK_THERMAL is not set
# CONFIG_DEVFREQ_THERMAL is not set
CONFIG_THERMAL_EMULATION=y
# CONFIG_DA9062_THERMAL is not set
# CONFIG_INTEL_POWERCLAMP is not set
CONFIG_INTEL_SOC_DTS_IOSF_CORE=y
CONFIG_INTEL_SOC_DTS_THERMAL=y

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
CONFIG_INTEL_PCH_THERMAL=m
CONFIG_GENERIC_ADC_THERMAL=m
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
# CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is not set
# CONFIG_WATCHDOG_SYSFS is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=y
# CONFIG_SOFT_WATCHDOG_PRETIMEOUT is not set
CONFIG_DA9052_WATCHDOG=y
# CONFIG_DA9055_WATCHDOG is not set
CONFIG_DA9063_WATCHDOG=y
CONFIG_DA9062_WATCHDOG=m
# CONFIG_GPIO_WATCHDOG is not set
# CONFIG_MENF21BMC_WATCHDOG is not set
CONFIG_WDAT_WDT=m
# CONFIG_WM831X_WATCHDOG is not set
CONFIG_WM8350_WATCHDOG=y
CONFIG_XILINX_WATCHDOG=y
# CONFIG_ZIIRAVE_WATCHDOG is not set
CONFIG_RAVE_SP_WATCHDOG=m
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
CONFIG_MAX63XX_WATCHDOG=m
CONFIG_RETU_WATCHDOG=m
CONFIG_ACQUIRE_WDT=m
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=y
# CONFIG_ALIM7101_WDT is not set
CONFIG_EBC_C384_WDT=y
CONFIG_F71808E_WDT=y
# CONFIG_SP5100_TCO is not set
CONFIG_GEODE_WDT=m
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=y
CONFIG_IBMASR=m
CONFIG_WAFER_WDT=m
# CONFIG_I6300ESB_WDT is not set
# CONFIG_IE6XX_WDT is not set
CONFIG_ITCO_WDT=y
# CONFIG_ITCO_VENDOR_SUPPORT is not set
# CONFIG_IT8712F_WDT is not set
CONFIG_IT87_WDT=y
# CONFIG_HP_WATCHDOG is not set
# CONFIG_KEMPLD_WDT is not set
CONFIG_SC1200_WDT=y
CONFIG_PC87413_WDT=m
# CONFIG_NV_TCO is not set
CONFIG_RDC321X_WDT=y
CONFIG_60XX_WDT=y
CONFIG_SBC8360_WDT=y
# CONFIG_SBC7240_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=y
CONFIG_SMSC37B787_WDT=m
# CONFIG_VIA_WDT is not set
# CONFIG_W83627HF_WDT is not set
CONFIG_W83877F_WDT=m
# CONFIG_W83977F_WDT is not set
CONFIG_MACHZ_WDT=m
CONFIG_SBC_EPX_C3_WATCHDOG=m
CONFIG_INTEL_MEI_WDT=y
CONFIG_NI903X_WDT=y
CONFIG_NIC7018_WDT=m
CONFIG_MEN_A21_WDT=m

#
# ISA-based Watchdog Cards
#
# CONFIG_PCWATCHDOG is not set
CONFIG_MIXCOMWD=y
# CONFIG_WDT is not set

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
CONFIG_WDTPCI=y

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
# CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
CONFIG_BCMA_HOST_SOC=y
CONFIG_BCMA_DRIVER_PCI=y
# CONFIG_BCMA_SFLASH is not set
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_CS5535=y
CONFIG_MFD_ACT8945A=m
CONFIG_MFD_AS3711=y
CONFIG_MFD_AS3722=m
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_ATMEL_FLEXCOM is not set
CONFIG_MFD_ATMEL_HLCDC=m
CONFIG_MFD_BCM590XX=m
CONFIG_MFD_BD9571MWV=y
# CONFIG_MFD_AXP20X_I2C is not set
CONFIG_MFD_CROS_EC=m
CONFIG_MFD_CROS_EC_I2C=m
CONFIG_MFD_CROS_EC_SPI=m
CONFIG_MFD_CROS_EC_CHARDEV=m
CONFIG_PMIC_DA903X=y
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_SPI=y
CONFIG_MFD_DA9052_I2C=y
CONFIG_MFD_DA9055=y
CONFIG_MFD_DA9062=m
CONFIG_MFD_DA9063=y
# CONFIG_MFD_DA9150 is not set
CONFIG_MFD_DLN2=y
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_SPI=y
# CONFIG_MFD_MC13XXX_I2C is not set
CONFIG_MFD_HI6421_PMIC=y
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
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
CONFIG_MFD_JANZ_CMODIO=m
CONFIG_MFD_KEMPLD=y
CONFIG_MFD_88PM800=y
# CONFIG_MFD_88PM805 is not set
CONFIG_MFD_88PM860X=y
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77620 is not set
# CONFIG_MFD_MAX77686 is not set
# CONFIG_MFD_MAX77693 is not set
CONFIG_MFD_MAX77843=y
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
CONFIG_MFD_MAX8997=y
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6397 is not set
CONFIG_MFD_MENF21BMC=m
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_CPCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
CONFIG_MFD_RETU=m
CONFIG_MFD_PCF50633=m
# CONFIG_PCF50633_ADC is not set
CONFIG_PCF50633_GPIO=m
# CONFIG_UCB1400_CORE is not set
CONFIG_MFD_RDC321X=m
CONFIG_MFD_RT5033=m
# CONFIG_MFD_RC5T583 is not set
CONFIG_MFD_RK808=m
# CONFIG_MFD_RN5T618 is not set
# CONFIG_MFD_SEC_CORE is not set
CONFIG_MFD_SI476X_CORE=y
CONFIG_MFD_SM501=m
# CONFIG_MFD_SM501_GPIO is not set
# CONFIG_MFD_SKY81452 is not set
CONFIG_MFD_SMSC=y
CONFIG_ABX500_CORE=y
CONFIG_AB3100_CORE=y
# CONFIG_AB3100_OTP is not set
CONFIG_MFD_STMPE=y

#
# STMicroelectronics STMPE Interface Drivers
#
# CONFIG_STMPE_I2C is not set
# CONFIG_STMPE_SPI is not set
CONFIG_MFD_STA2X11=y
CONFIG_MFD_SYSCON=y
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
CONFIG_MFD_PALMAS=y
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=y
CONFIG_MFD_TPS65086=m
CONFIG_MFD_TPS65090=y
CONFIG_MFD_TPS65217=y
CONFIG_MFD_TPS68470=y
CONFIG_MFD_TI_LP873X=m
CONFIG_MFD_TI_LP87565=m
CONFIG_MFD_TPS65218=m
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
CONFIG_MFD_TPS65912=m
# CONFIG_MFD_TPS65912_I2C is not set
CONFIG_MFD_TPS65912_SPI=m
CONFIG_MFD_TPS80031=y
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
CONFIG_MFD_WL1273_CORE=m
CONFIG_MFD_LM3533=y
CONFIG_MFD_TIMBERDALE=y
# CONFIG_MFD_TC3589X is not set
# CONFIG_MFD_TMIO is not set
CONFIG_MFD_VX855=y
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_CS47L24 is not set
CONFIG_MFD_WM5102=y
# CONFIG_MFD_WM5110 is not set
CONFIG_MFD_WM8997=y
CONFIG_MFD_WM8998=y
# CONFIG_MFD_WM8400 is not set
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
CONFIG_MFD_WM831X_SPI=y
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
# CONFIG_MFD_WM8994 is not set
CONFIG_RAVE_SP_CORE=y
# CONFIG_REGULATOR is not set
# CONFIG_RC_CORE is not set
CONFIG_MEDIA_SUPPORT=m

#
# Multimedia core support
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_CEC_SUPPORT=y
CONFIG_MEDIA_CONTROLLER=y
# CONFIG_MEDIA_CONTROLLER_DVB is not set
CONFIG_VIDEO_DEV=m
# CONFIG_VIDEO_V4L2_SUBDEV_API is not set
CONFIG_VIDEO_V4L2=m
CONFIG_VIDEO_ADV_DEBUG=y
CONFIG_VIDEO_FIXED_MINOR_RANGES=y
CONFIG_V4L2_FWNODE=m
CONFIG_DVB_CORE=m
CONFIG_DVB_MMAP=y
CONFIG_DVB_NET=y
# CONFIG_TTPCI_EEPROM is not set
CONFIG_DVB_MAX_ADAPTERS=16
# CONFIG_DVB_DYNAMIC_MINORS is not set
CONFIG_DVB_DEMUX_SECTION_LOSS_LOG=y
# CONFIG_DVB_ULE_DEBUG is not set

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
CONFIG_DVB_PLATFORM_DRIVERS=y
CONFIG_CEC_PLATFORM_DRIVERS=y
CONFIG_SDR_PLATFORM_DRIVERS=y

#
# Supported MMC/SDIO adapters
#
CONFIG_SMS_SDIO_DRV=m
CONFIG_RADIO_ADAPTERS=y
CONFIG_RADIO_TEA575X=m
# CONFIG_RADIO_SI470X is not set
# CONFIG_RADIO_SI4713 is not set
# CONFIG_USB_MR800 is not set
CONFIG_USB_DSBR=m
CONFIG_RADIO_MAXIRADIO=m
CONFIG_RADIO_SHARK=m
# CONFIG_RADIO_SHARK2 is not set
CONFIG_USB_KEENE=m
CONFIG_USB_RAREMONO=m
# CONFIG_USB_MA901 is not set
# CONFIG_RADIO_TEA5764 is not set
CONFIG_RADIO_SAA7706H=m
CONFIG_RADIO_TEF6862=m
CONFIG_RADIO_TIMBERDALE=m
CONFIG_RADIO_WL1273=m

#
# Texas Instruments WL128x FM driver (ST based)
#
CONFIG_V4L_RADIO_ISA_DRIVERS=y
CONFIG_RADIO_ISA=m
CONFIG_RADIO_CADET=m
CONFIG_RADIO_RTRACK=m
# CONFIG_RADIO_RTRACK2 is not set
# CONFIG_RADIO_AZTECH is not set
CONFIG_RADIO_GEMTEK=m
# CONFIG_RADIO_MIROPCM20 is not set
CONFIG_RADIO_SF16FMI=m
# CONFIG_RADIO_SF16FMR2 is not set
# CONFIG_RADIO_TERRATEC is not set
CONFIG_RADIO_TRUST=m
CONFIG_RADIO_TYPHOON=m
# CONFIG_RADIO_ZOLTRIX is not set

#
# Supported FireWire (IEEE 1394) Adapters
#
CONFIG_DVB_FIREDTV=m
CONFIG_DVB_FIREDTV_INPUT=y
CONFIG_MEDIA_COMMON_OPTIONS=y

#
# common driver options
#
# CONFIG_CYPRESS_FIRMWARE is not set
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_VMALLOC=m
CONFIG_SMS_SIANO_MDTV=m

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
CONFIG_MEDIA_ATTACH=y

#
# I2C Encoders, decoders, sensors and other helper chips
#

#
# Audio decoders, processors and mixers
#
# CONFIG_VIDEO_TVAUDIO is not set
CONFIG_VIDEO_TDA7432=m
# CONFIG_VIDEO_TDA9840 is not set
# CONFIG_VIDEO_TEA6415C is not set
CONFIG_VIDEO_TEA6420=m
CONFIG_VIDEO_MSP3400=m
CONFIG_VIDEO_CS3308=m
# CONFIG_VIDEO_CS5345 is not set
# CONFIG_VIDEO_CS53L32A is not set
CONFIG_VIDEO_TLV320AIC23B=m
# CONFIG_VIDEO_UDA1342 is not set
# CONFIG_VIDEO_WM8775 is not set
CONFIG_VIDEO_WM8739=m
# CONFIG_VIDEO_VP27SMPX is not set
CONFIG_VIDEO_SONY_BTF_MPX=m

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=m

#
# Video decoders
#
CONFIG_VIDEO_ADV7183=m
CONFIG_VIDEO_BT819=m
CONFIG_VIDEO_BT856=m
# CONFIG_VIDEO_BT866 is not set
CONFIG_VIDEO_KS0127=m
CONFIG_VIDEO_ML86V7667=m
CONFIG_VIDEO_AD5820=m
CONFIG_VIDEO_SAA7110=m
CONFIG_VIDEO_SAA711X=m
CONFIG_VIDEO_TVP514X=m
# CONFIG_VIDEO_TVP5150 is not set
CONFIG_VIDEO_TVP7002=m
CONFIG_VIDEO_TW2804=m
CONFIG_VIDEO_TW9903=m
# CONFIG_VIDEO_TW9906 is not set
CONFIG_VIDEO_VPX3220=m

#
# Video and audio decoders
#
# CONFIG_VIDEO_SAA717X is not set
# CONFIG_VIDEO_CX25840 is not set

#
# Video encoders
#
# CONFIG_VIDEO_SAA7127 is not set
# CONFIG_VIDEO_SAA7185 is not set
CONFIG_VIDEO_ADV7170=m
CONFIG_VIDEO_ADV7175=m
CONFIG_VIDEO_ADV7343=m
CONFIG_VIDEO_ADV7393=m
# CONFIG_VIDEO_AK881X is not set
CONFIG_VIDEO_THS8200=m

#
# Camera sensor devices
#
# CONFIG_VIDEO_MT9M111 is not set

#
# Flash devices
#

#
# Video improvement chips
#
# CONFIG_VIDEO_UPD64031A is not set
# CONFIG_VIDEO_UPD64083 is not set

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=m

#
# SDR tuner chips
#
# CONFIG_SDR_MAX2175 is not set

#
# Miscellaneous helper chips
#
CONFIG_VIDEO_THS7303=m
# CONFIG_VIDEO_M52790 is not set

#
# Sensors used on soc_camera driver
#

#
# SPI helper chips
#
CONFIG_MEDIA_TUNER=m

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_SIMPLE=m
# CONFIG_MEDIA_TUNER_TDA18250 is not set
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
# CONFIG_MEDIA_TUNER_MSI001 is not set
# CONFIG_MEDIA_TUNER_MT20XX is not set
CONFIG_MEDIA_TUNER_MT2060=m
CONFIG_MEDIA_TUNER_MT2063=m
# CONFIG_MEDIA_TUNER_MT2266 is not set
CONFIG_MEDIA_TUNER_MT2131=m
CONFIG_MEDIA_TUNER_QT1010=m
# CONFIG_MEDIA_TUNER_XC2028 is not set
# CONFIG_MEDIA_TUNER_XC5000 is not set
# CONFIG_MEDIA_TUNER_XC4000 is not set
CONFIG_MEDIA_TUNER_MXL5005S=m
CONFIG_MEDIA_TUNER_MXL5007T=m
CONFIG_MEDIA_TUNER_MC44S803=m
CONFIG_MEDIA_TUNER_MAX2165=m
# CONFIG_MEDIA_TUNER_TDA18218 is not set
CONFIG_MEDIA_TUNER_FC0011=m
CONFIG_MEDIA_TUNER_FC0012=m
# CONFIG_MEDIA_TUNER_FC0013 is not set
CONFIG_MEDIA_TUNER_TDA18212=m
CONFIG_MEDIA_TUNER_E4000=m
CONFIG_MEDIA_TUNER_FC2580=m
CONFIG_MEDIA_TUNER_M88RS6000T=m
CONFIG_MEDIA_TUNER_TUA9001=m
CONFIG_MEDIA_TUNER_SI2157=m
CONFIG_MEDIA_TUNER_IT913X=m
# CONFIG_MEDIA_TUNER_R820T is not set
# CONFIG_MEDIA_TUNER_MXL301RF is not set
CONFIG_MEDIA_TUNER_QM1D1C0042=m

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=m
# CONFIG_DVB_STB6100 is not set
# CONFIG_DVB_STV090x is not set
# CONFIG_DVB_STV0910 is not set
CONFIG_DVB_STV6110x=m
CONFIG_DVB_STV6111=m
# CONFIG_DVB_MXL5XX is not set
CONFIG_DVB_M88DS3103=m

#
# Multistandard (cable + terrestrial) frontends
#
# CONFIG_DVB_DRXK is not set
# CONFIG_DVB_TDA18271C2DD is not set
CONFIG_DVB_SI2165=m
CONFIG_DVB_MN88472=m
CONFIG_DVB_MN88473=m

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=m
CONFIG_DVB_CX24123=m
# CONFIG_DVB_MT312 is not set
# CONFIG_DVB_ZL10036 is not set
# CONFIG_DVB_ZL10039 is not set
CONFIG_DVB_S5H1420=m
CONFIG_DVB_STV0288=m
CONFIG_DVB_STB6000=m
CONFIG_DVB_STV0299=m
# CONFIG_DVB_STV6110 is not set
CONFIG_DVB_STV0900=m
# CONFIG_DVB_TDA8083 is not set
# CONFIG_DVB_TDA10086 is not set
CONFIG_DVB_TDA8261=m
# CONFIG_DVB_VES1X93 is not set
CONFIG_DVB_TUNER_ITD1000=m
# CONFIG_DVB_TUNER_CX24113 is not set
CONFIG_DVB_TDA826X=m
# CONFIG_DVB_TUA6100 is not set
CONFIG_DVB_CX24116=m
CONFIG_DVB_CX24117=m
CONFIG_DVB_CX24120=m
# CONFIG_DVB_SI21XX is not set
CONFIG_DVB_TS2020=m
CONFIG_DVB_DS3000=m
CONFIG_DVB_MB86A16=m
CONFIG_DVB_TDA10071=m

#
# DVB-T (terrestrial) frontends
#
# CONFIG_DVB_SP8870 is not set
# CONFIG_DVB_SP887X is not set
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=m
CONFIG_DVB_S5H1432=m
CONFIG_DVB_DRXD=m
CONFIG_DVB_L64781=m
# CONFIG_DVB_TDA1004X is not set
CONFIG_DVB_NXT6000=m
CONFIG_DVB_MT352=m
CONFIG_DVB_ZL10353=m
CONFIG_DVB_DIB3000MB=m
CONFIG_DVB_DIB3000MC=m
CONFIG_DVB_DIB7000M=m
CONFIG_DVB_DIB7000P=m
# CONFIG_DVB_DIB9000 is not set
# CONFIG_DVB_TDA10048 is not set
# CONFIG_DVB_AF9013 is not set
# CONFIG_DVB_EC100 is not set
# CONFIG_DVB_STV0367 is not set
CONFIG_DVB_CXD2820R=m
CONFIG_DVB_CXD2841ER=m
# CONFIG_DVB_RTL2830 is not set
CONFIG_DVB_RTL2832=m
# CONFIG_DVB_RTL2832_SDR is not set
CONFIG_DVB_SI2168=m
# CONFIG_DVB_AS102_FE is not set
CONFIG_DVB_ZD1301_DEMOD=m
# CONFIG_DVB_GP8PSK_FE is not set

#
# DVB-C (cable) frontends
#
# CONFIG_DVB_VES1820 is not set
CONFIG_DVB_TDA10021=m
CONFIG_DVB_TDA10023=m
# CONFIG_DVB_STV0297 is not set

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
# CONFIG_DVB_NXT200X is not set
# CONFIG_DVB_OR51211 is not set
# CONFIG_DVB_OR51132 is not set
# CONFIG_DVB_BCM3510 is not set
# CONFIG_DVB_LGDT330X is not set
CONFIG_DVB_LGDT3305=m
# CONFIG_DVB_LGDT3306A is not set
CONFIG_DVB_LG2160=m
CONFIG_DVB_S5H1409=m
CONFIG_DVB_AU8522=m
CONFIG_DVB_AU8522_DTV=m
CONFIG_DVB_AU8522_V4L=m
# CONFIG_DVB_S5H1411 is not set

#
# ISDB-T (terrestrial) frontends
#
# CONFIG_DVB_S921 is not set
# CONFIG_DVB_DIB8000 is not set
CONFIG_DVB_MB86A20S=m

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
# CONFIG_DVB_TC90522 is not set

#
# Digital terrestrial only tuners/PLL
#
# CONFIG_DVB_PLL is not set
CONFIG_DVB_TUNER_DIB0070=m
# CONFIG_DVB_TUNER_DIB0090 is not set

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=m
# CONFIG_DVB_LNBH25 is not set
# CONFIG_DVB_LNBP21 is not set
CONFIG_DVB_LNBP22=m
# CONFIG_DVB_ISL6405 is not set
# CONFIG_DVB_ISL6421 is not set
# CONFIG_DVB_ISL6423 is not set
CONFIG_DVB_A8293=m
CONFIG_DVB_SP2=m
CONFIG_DVB_LGS8GL5=m
CONFIG_DVB_LGS8GXX=m
# CONFIG_DVB_ATBM8830 is not set
# CONFIG_DVB_TDA665x is not set
CONFIG_DVB_IX2505V=m
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_AF9033=m
# CONFIG_DVB_HORUS3A is not set
# CONFIG_DVB_ASCOT2E is not set
CONFIG_DVB_HELENE=m

#
# Tools to develop new frontends
#
CONFIG_DVB_DUMMY_FE=m

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=y
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DEBUG_MM is not set
CONFIG_DRM_DEBUG_MM_SELFTEST=m
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
CONFIG_DRM_TTM=y
CONFIG_DRM_GEM_CMA_HELPER=y
CONFIG_DRM_KMS_CMA_HELPER=y
CONFIG_DRM_VM=y
CONFIG_DRM_SCHED=y

#
# I2C encoder or helper chips
#
# CONFIG_DRM_I2C_CH7006 is not set
# CONFIG_DRM_I2C_SIL164 is not set
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_RADEON is not set
CONFIG_DRM_AMDGPU=y
CONFIG_DRM_AMDGPU_SI=y
# CONFIG_DRM_AMDGPU_CIK is not set
CONFIG_DRM_AMDGPU_USERPTR=y
CONFIG_DRM_AMDGPU_GART_DEBUGFS=y

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
CONFIG_CHASH_SELFTEST=y
CONFIG_DRM_NOUVEAU=y
CONFIG_NOUVEAU_DEBUG=5
CONFIG_NOUVEAU_DEBUG_DEFAULT=3
# CONFIG_NOUVEAU_DEBUG_MMU is not set
# CONFIG_DRM_NOUVEAU_BACKLIGHT is not set
CONFIG_DRM_I915=y
# CONFIG_DRM_I915_ALPHA_SUPPORT is not set
# CONFIG_DRM_I915_CAPTURE_ERROR is not set
# CONFIG_DRM_I915_USERPTR is not set

#
# drm/i915 Debugging
#
CONFIG_DRM_I915_WERROR=y
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_DEBUG_GEM is not set
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
# CONFIG_DRM_I915_SELFTEST is not set
CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS=y
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
CONFIG_DRM_VGEM=y
# CONFIG_DRM_VMWGFX is not set
CONFIG_DRM_GMA500=y
# CONFIG_DRM_GMA600 is not set
CONFIG_DRM_GMA3600=y
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=y
# CONFIG_DRM_MGAG200 is not set
# CONFIG_DRM_CIRRUS_QEMU is not set
# CONFIG_DRM_RCAR_DW_HDMI is not set
# CONFIG_DRM_QXL is not set
# CONFIG_DRM_BOCHS is not set
CONFIG_DRM_VIRTIO_GPU=y
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_LVDS is not set
CONFIG_DRM_PANEL_SIMPLE=m
# CONFIG_DRM_PANEL_ILITEK_IL9322 is not set
# CONFIG_DRM_PANEL_INNOLUX_P079ZCA is not set
# CONFIG_DRM_PANEL_JDI_LT070ME05000 is not set
CONFIG_DRM_PANEL_SAMSUNG_LD9040=y
# CONFIG_DRM_PANEL_LG_LG4573 is not set
CONFIG_DRM_PANEL_ORISETECH_OTM8009A=m
CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00=m
CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=y
# CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2 is not set
CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=y
CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=m
CONFIG_DRM_PANEL_SEIKO_43WVF1G=m
CONFIG_DRM_PANEL_SHARP_LQ101R1SX01=m
# CONFIG_DRM_PANEL_SHARP_LS043T1LE01 is not set
CONFIG_DRM_PANEL_SITRONIX_ST7789V=m
CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
CONFIG_DRM_DUMB_VGA_DAC=m
CONFIG_DRM_LVDS_ENCODER=y
CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW=y
CONFIG_DRM_NXP_PTN3460=y
CONFIG_DRM_PARADE_PS8622=y
# CONFIG_DRM_SII902X is not set
CONFIG_DRM_SII9234=m
CONFIG_DRM_TOSHIBA_TC358767=y
CONFIG_DRM_TI_TFP410=m
# CONFIG_DRM_I2C_ADV7511 is not set
# CONFIG_DRM_ARCPGU is not set
CONFIG_DRM_HISI_HIBMC=y
# CONFIG_DRM_MXSFB is not set
CONFIG_DRM_TINYDRM=m
CONFIG_TINYDRM_MIPI_DBI=m
CONFIG_TINYDRM_ILI9225=m
CONFIG_TINYDRM_MI0283QT=m
CONFIG_TINYDRM_REPAPER=m
CONFIG_TINYDRM_ST7586=m
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_LIB_RANDOM=y

#
# Frame buffer Devices
#
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
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
CONFIG_FB_FOREIGN_ENDIAN=y
# CONFIG_FB_BOTH_ENDIAN is not set
# CONFIG_FB_BIG_ENDIAN is not set
CONFIG_FB_LITTLE_ENDIAN=y
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
# CONFIG_FB_CIRRUS is not set
CONFIG_FB_PM2=m
# CONFIG_FB_PM2_FIFO_DISCONNECT is not set
CONFIG_FB_CYBER2000=m
# CONFIG_FB_CYBER2000_DDC is not set
CONFIG_FB_ARC=y
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_UVESA=m
CONFIG_FB_VESA=y
# CONFIG_FB_EFI is not set
# CONFIG_FB_N411 is not set
CONFIG_FB_HGA=y
CONFIG_FB_OPENCORES=m
CONFIG_FB_S1D13XXX=y
CONFIG_FB_NVIDIA=m
# CONFIG_FB_NVIDIA_I2C is not set
CONFIG_FB_NVIDIA_DEBUG=y
CONFIG_FB_NVIDIA_BACKLIGHT=y
CONFIG_FB_RIVA=m
# CONFIG_FB_RIVA_I2C is not set
# CONFIG_FB_RIVA_DEBUG is not set
# CONFIG_FB_RIVA_BACKLIGHT is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
CONFIG_FB_ATY128=y
CONFIG_FB_ATY128_BACKLIGHT=y
CONFIG_FB_ATY=m
# CONFIG_FB_ATY_CT is not set
# CONFIG_FB_ATY_GX is not set
CONFIG_FB_ATY_BACKLIGHT=y
# CONFIG_FB_S3 is not set
CONFIG_FB_SAVAGE=y
CONFIG_FB_SAVAGE_I2C=y
# CONFIG_FB_SAVAGE_ACCEL is not set
CONFIG_FB_SIS=y
CONFIG_FB_SIS_300=y
# CONFIG_FB_SIS_315 is not set
CONFIG_FB_VIA=m
# CONFIG_FB_VIA_DIRECT_PROCFS is not set
# CONFIG_FB_VIA_X_COMPATIBILITY is not set
CONFIG_FB_NEOMAGIC=y
CONFIG_FB_KYRO=m
# CONFIG_FB_3DFX is not set
CONFIG_FB_VOODOO1=m
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
CONFIG_FB_ARK=y
# CONFIG_FB_PM3 is not set
CONFIG_FB_CARMINE=y
# CONFIG_FB_CARMINE_DRAM_EVAL is not set
CONFIG_CARMINE_DRAM_CUSTOM=y
# CONFIG_FB_GEODE is not set
CONFIG_FB_SM501=m
CONFIG_FB_SMSCUFX=m
CONFIG_FB_UDL=y
CONFIG_FB_IBM_GXT4500=y
CONFIG_FB_GOLDFISH=m
CONFIG_FB_VIRTUAL=y
CONFIG_FB_METRONOME=m
CONFIG_FB_MB862XX=m
CONFIG_FB_MB862XX_PCI_GDC=y
# CONFIG_FB_MB862XX_I2C is not set
# CONFIG_FB_BROADSHEET is not set
CONFIG_FB_AUO_K190X=y
CONFIG_FB_AUO_K1900=m
CONFIG_FB_AUO_K1901=y
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SSD1307 is not set
# CONFIG_FB_SM712 is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_LCD_CLASS_DEVICE=m
CONFIG_LCD_L4F00242T03=m
CONFIG_LCD_LMS283GF05=m
CONFIG_LCD_LTV350QV=m
# CONFIG_LCD_ILI922X is not set
CONFIG_LCD_ILI9320=m
CONFIG_LCD_TDO24M=m
CONFIG_LCD_VGG2432A4=m
# CONFIG_LCD_PLATFORM is not set
# CONFIG_LCD_S6E63M0 is not set
CONFIG_LCD_LD9040=m
# CONFIG_LCD_AMS369FG06 is not set
CONFIG_LCD_LMS501KF03=m
CONFIG_LCD_HX8357=m
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_GENERIC=m
# CONFIG_BACKLIGHT_LM3533 is not set
# CONFIG_BACKLIGHT_DA903X is not set
# CONFIG_BACKLIGHT_DA9052 is not set
CONFIG_BACKLIGHT_APPLE=y
CONFIG_BACKLIGHT_PM8941_WLED=m
CONFIG_BACKLIGHT_SAHARA=y
CONFIG_BACKLIGHT_WM831X=m
CONFIG_BACKLIGHT_ADP8860=y
CONFIG_BACKLIGHT_ADP8870=m
CONFIG_BACKLIGHT_88PM860X=m
CONFIG_BACKLIGHT_PCF50633=m
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_OT200=m
CONFIG_BACKLIGHT_TPS65217=y
# CONFIG_BACKLIGHT_AS3711 is not set
CONFIG_BACKLIGHT_GPIO=y
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
CONFIG_VGASTATE=y
CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y
# CONFIG_LOGO is not set
CONFIG_SOUND=m
CONFIG_SOUND_OSS_CORE=y
# CONFIG_SOUND_OSS_CORE_PRECLAIM is not set
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_SEQ_DEVICE=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
# CONFIG_SND_PCM_OSS is not set
# CONFIG_SND_PCM_TIMER is not set
# CONFIG_SND_DYNAMIC_MINORS is not set
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_DEBUG=y
# CONFIG_SND_DEBUG_VERBOSE is not set
# CONFIG_SND_PCM_XRUN_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_SEQUENCER=m
# CONFIG_SND_SEQ_DUMMY is not set
# CONFIG_SND_SEQUENCER_OSS is not set
CONFIG_SND_SEQ_MIDI_EVENT=m
CONFIG_SND_SEQ_MIDI=m
CONFIG_SND_SEQ_MIDI_EMUL=m
CONFIG_SND_SEQ_VIRMIDI=m
CONFIG_SND_MPU401_UART=m
CONFIG_SND_OPL3_LIB=m
CONFIG_SND_OPL3_LIB_SEQ=m
# CONFIG_SND_OPL4_LIB_SEQ is not set
CONFIG_SND_VX_LIB=m
CONFIG_SND_AC97_CODEC=m
# CONFIG_SND_DRIVERS is not set
CONFIG_SND_SB_COMMON=m
CONFIG_SND_SB16_DSP=m
# CONFIG_SND_ISA is not set
CONFIG_SND_PCI=y
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS300 is not set
CONFIG_SND_ALS4000=m
CONFIG_SND_ALI5451=m
# CONFIG_SND_ASIHPI is not set
# CONFIG_SND_ATIIXP is not set
CONFIG_SND_ATIIXP_MODEM=m
CONFIG_SND_AU8810=m
CONFIG_SND_AU8820=m
CONFIG_SND_AU8830=m
# CONFIG_SND_AW2 is not set
CONFIG_SND_AZT3328=m
CONFIG_SND_BT87X=m
CONFIG_SND_BT87X_OVERCLOCK=y
CONFIG_SND_CA0106=m
# CONFIG_SND_CMIPCI is not set
CONFIG_SND_OXYGEN_LIB=m
CONFIG_SND_OXYGEN=m
CONFIG_SND_CS4281=m
# CONFIG_SND_CS46XX is not set
CONFIG_SND_CS5530=m
# CONFIG_SND_CS5535AUDIO is not set
# CONFIG_SND_CTXFI is not set
# CONFIG_SND_DARLA20 is not set
CONFIG_SND_GINA20=m
CONFIG_SND_LAYLA20=m
# CONFIG_SND_DARLA24 is not set
# CONFIG_SND_GINA24 is not set
# CONFIG_SND_LAYLA24 is not set
CONFIG_SND_MONA=m
CONFIG_SND_MIA=m
CONFIG_SND_ECHO3G=m
# CONFIG_SND_INDIGO is not set
CONFIG_SND_INDIGOIO=m
CONFIG_SND_INDIGODJ=m
# CONFIG_SND_INDIGOIOX is not set
# CONFIG_SND_INDIGODJX is not set
CONFIG_SND_EMU10K1=m
CONFIG_SND_EMU10K1_SEQ=m
CONFIG_SND_EMU10K1X=m
CONFIG_SND_ENS1370=m
# CONFIG_SND_ENS1371 is not set
CONFIG_SND_ES1938=m
CONFIG_SND_ES1968=m
CONFIG_SND_ES1968_INPUT=y
# CONFIG_SND_ES1968_RADIO is not set
CONFIG_SND_FM801=m
# CONFIG_SND_FM801_TEA575X_BOOL is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
CONFIG_SND_ICE1712=m
CONFIG_SND_ICE1724=m
CONFIG_SND_INTEL8X0=m
# CONFIG_SND_INTEL8X0M is not set
CONFIG_SND_KORG1212=m
CONFIG_SND_LOLA=m
# CONFIG_SND_LX6464ES is not set
CONFIG_SND_MAESTRO3=m
CONFIG_SND_MAESTRO3_INPUT=y
CONFIG_SND_MIXART=m
CONFIG_SND_NM256=m
CONFIG_SND_PCXHR=m
CONFIG_SND_RIPTIDE=m
CONFIG_SND_RME32=m
CONFIG_SND_RME96=m
CONFIG_SND_RME9652=m
CONFIG_SND_SIS7019=m
CONFIG_SND_SONICVIBES=m
CONFIG_SND_TRIDENT=m
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VIRTUOSO is not set
CONFIG_SND_VX222=m
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
# CONFIG_SND_HDA_INTEL is not set
CONFIG_SND_HDA_PREALLOC_SIZE=64
CONFIG_SND_SPI=y
CONFIG_SND_USB=y
CONFIG_SND_USB_AUDIO=m
# CONFIG_SND_USB_UA101 is not set
CONFIG_SND_USB_USX2Y=m
CONFIG_SND_USB_CAIAQ=m
# CONFIG_SND_USB_CAIAQ_INPUT is not set
# CONFIG_SND_USB_US122L is not set
CONFIG_SND_USB_6FIRE=m
# CONFIG_SND_USB_HIFACE is not set
CONFIG_SND_BCD2000=m
CONFIG_SND_USB_LINE6=m
CONFIG_SND_USB_POD=m
CONFIG_SND_USB_PODHD=m
CONFIG_SND_USB_TONEPORT=m
CONFIG_SND_USB_VARIAX=m
CONFIG_SND_FIREWIRE=y
CONFIG_SND_FIREWIRE_LIB=m
# CONFIG_SND_DICE is not set
CONFIG_SND_OXFW=m
CONFIG_SND_ISIGHT=m
CONFIG_SND_FIREWORKS=m
CONFIG_SND_BEBOB=m
# CONFIG_SND_FIREWIRE_DIGI00X is not set
CONFIG_SND_FIREWIRE_TASCAM=m
CONFIG_SND_FIREWIRE_MOTU=m
CONFIG_SND_FIREFACE=m
# CONFIG_SND_SOC is not set
CONFIG_SND_X86=y
CONFIG_HDMI_LPE_AUDIO=m
CONFIG_SND_SYNTH_EMUX=m
CONFIG_AC97_BUS=m

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
CONFIG_HID_A4TECH=m
CONFIG_HID_ACCUTOUCH=m
CONFIG_HID_ACRUX=m
CONFIG_HID_ACRUX_FF=y
# CONFIG_HID_APPLE is not set
CONFIG_HID_APPLEIR=m
# CONFIG_HID_ASUS is not set
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=y
# CONFIG_HID_BETOP_FF is not set
CONFIG_HID_CHERRY=y
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_CORSAIR is not set
CONFIG_HID_PRODIKEYS=m
CONFIG_HID_CMEDIA=m
# CONFIG_HID_CP2112 is not set
CONFIG_HID_CYPRESS=y
# CONFIG_HID_DRAGONRISE is not set
# CONFIG_HID_EMS_FF is not set
CONFIG_HID_ELECOM=m
CONFIG_HID_ELO=m
# CONFIG_HID_EZKEY is not set
CONFIG_HID_GEMBIRD=y
CONFIG_HID_GFRM=m
CONFIG_HID_HOLTEK=m
# CONFIG_HOLTEK_FF is not set
CONFIG_HID_GT683R=m
# CONFIG_HID_KEYTOUCH is not set
CONFIG_HID_KYE=y
# CONFIG_HID_UCLOGIC is not set
CONFIG_HID_WALTOP=y
CONFIG_HID_GYRATION=y
CONFIG_HID_ICADE=m
# CONFIG_HID_ITE is not set
CONFIG_HID_JABRA=m
# CONFIG_HID_TWINHAN is not set
# CONFIG_HID_KENSINGTON is not set
# CONFIG_HID_LCPOWER is not set
CONFIG_HID_LED=y
CONFIG_HID_LENOVO=m
CONFIG_HID_LOGITECH=y
CONFIG_HID_LOGITECH_DJ=y
CONFIG_HID_LOGITECH_HIDPP=y
CONFIG_LOGITECH_FF=y
CONFIG_LOGIRUMBLEPAD2_FF=y
# CONFIG_LOGIG940_FF is not set
CONFIG_LOGIWHEELS_FF=y
CONFIG_HID_MAGICMOUSE=m
CONFIG_HID_MAYFLASH=y
# CONFIG_HID_MICROSOFT is not set
# CONFIG_HID_MONTEREY is not set
CONFIG_HID_MULTITOUCH=m
CONFIG_HID_NTI=y
# CONFIG_HID_NTRIG is not set
CONFIG_HID_ORTEK=y
# CONFIG_HID_PANTHERLORD is not set
# CONFIG_HID_PENMOUNT is not set
# CONFIG_HID_PETALYNX is not set
# CONFIG_HID_PICOLCD is not set
# CONFIG_HID_PLANTRONICS is not set
CONFIG_HID_PRIMAX=m
CONFIG_HID_RETRODE=m
# CONFIG_HID_ROCCAT is not set
# CONFIG_HID_SAITEK is not set
CONFIG_HID_SAMSUNG=y
CONFIG_HID_SONY=m
CONFIG_SONY_FF=y
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEELSERIES is not set
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=y
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_SMARTJOYPLUS=y
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=y
# CONFIG_HID_TOPSEED is not set
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=y
# CONFIG_THRUSTMASTER_FF is not set
CONFIG_HID_UDRAW_PS3=y
# CONFIG_HID_WACOM is not set
# CONFIG_HID_WIIMOTE is not set
CONFIG_HID_XINMO=y
CONFIG_HID_ZEROPLUS=m
CONFIG_ZEROPLUS_FF=y
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=m
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
# CONFIG_HID_ALPS is not set

#
# USB HID support
#
CONFIG_USB_HID=m
CONFIG_HID_PID=y
CONFIG_USB_HIDDEV=y

#
# USB HID Boot Protocol drivers
#
CONFIG_USB_KBD=y
# CONFIG_USB_MOUSE is not set

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
# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set

#
# Miscellaneous USB options
#
# CONFIG_USB_DEFAULT_PERSIST is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_WHITELIST is not set
# CONFIG_USB_OTG_BLACKLIST_HUB is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_MON=y
CONFIG_USB_WUSB_CBAF=y
# CONFIG_USB_WUSB_CBAF_DEBUG is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_C67X00_HCD=m
# CONFIG_USB_XHCI_HCD is not set
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=m
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
CONFIG_USB_OXU210HP_HCD=y
CONFIG_USB_ISP116X_HCD=m
# CONFIG_USB_ISP1362_HCD is not set
CONFIG_USB_FOTG210_HCD=m
CONFIG_USB_MAX3421_HCD=y
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_BCMA is not set
CONFIG_USB_HCD_TEST_MODE=y

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=m
CONFIG_USB_WDM=m
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
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_MUSB_HDRC is not set
CONFIG_USB_DWC3=m
# CONFIG_USB_DWC3_ULPI is not set
# CONFIG_USB_DWC3_HOST is not set
CONFIG_USB_DWC3_GADGET=y
# CONFIG_USB_DWC3_DUAL_ROLE is not set

#
# Platform Glue Driver Support
#
CONFIG_USB_DWC3_PCI=m
CONFIG_USB_DWC3_OF_SIMPLE=m
CONFIG_USB_DWC2=y
# CONFIG_USB_DWC2_HOST is not set

#
# Gadget/Dual-role mode requires USB Gadget support to be enabled
#
# CONFIG_USB_DWC2_PERIPHERAL is not set
CONFIG_USB_DWC2_DUAL_ROLE=y
# CONFIG_USB_DWC2_PCI is not set
CONFIG_USB_DWC2_DEBUG=y
CONFIG_USB_DWC2_VERBOSE=y
CONFIG_USB_DWC2_TRACK_MISSED_SOFS=y
CONFIG_USB_DWC2_DEBUG_PERIODIC=y
CONFIG_USB_CHIPIDEA=m
CONFIG_USB_CHIPIDEA_OF=m
CONFIG_USB_CHIPIDEA_UDC=y
CONFIG_USB_CHIPIDEA_HOST=y
CONFIG_USB_CHIPIDEA_ULPI=y
CONFIG_USB_ISP1760=y
CONFIG_USB_ISP1760_HCD=y
CONFIG_USB_ISP1761_UDC=y
# CONFIG_USB_ISP1760_HOST_ROLE is not set
# CONFIG_USB_ISP1760_GADGET_ROLE is not set
CONFIG_USB_ISP1760_DUAL_ROLE=y

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=m
# CONFIG_USB_EMI26 is not set
CONFIG_USB_ADUTUX=m
CONFIG_USB_SEVSEG=m
# CONFIG_USB_RIO500 is not set
CONFIG_USB_LEGOTOWER=m
# CONFIG_USB_LCD is not set
CONFIG_USB_CYPRESS_CY7C63=y
CONFIG_USB_CYTHERM=m
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
CONFIG_USB_APPLEDISPLAY=y
CONFIG_USB_SISUSBVGA=m
CONFIG_USB_LD=y
CONFIG_USB_TRANCEVIBRATOR=m
CONFIG_USB_IOWARRIOR=m
CONFIG_USB_TEST=m
CONFIG_USB_EHSET_TEST_FIXTURE=y
CONFIG_USB_ISIGHTFW=m
CONFIG_USB_YUREX=y
# CONFIG_USB_EZUSB_FX2 is not set
CONFIG_USB_HUB_USB251XB=m
# CONFIG_USB_HSIC_USB3503 is not set
CONFIG_USB_HSIC_USB4604=m
CONFIG_USB_LINK_LAYER_TEST=y
CONFIG_USB_CHAOSKEY=m
CONFIG_USB_ATM=y
# CONFIG_USB_SPEEDTOUCH is not set
# CONFIG_USB_CXACRU is not set
CONFIG_USB_UEAGLEATM=y
# CONFIG_USB_XUSBATM is not set

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
# CONFIG_NOP_USB_XCEIV is not set
CONFIG_USB_GPIO_VBUS=y
CONFIG_TAHVO_USB=m
CONFIG_TAHVO_USB_HOST_BY_DEFAULT=y
CONFIG_USB_ISP1301=m
CONFIG_USB_GADGET=y
# CONFIG_USB_GADGET_DEBUG is not set
# CONFIG_USB_GADGET_DEBUG_FILES is not set
# CONFIG_USB_GADGET_DEBUG_FS is not set
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2

#
# USB Peripheral Controller
#
CONFIG_USB_FUSB300=m
# CONFIG_USB_FOTG210_UDC is not set
CONFIG_USB_GR_UDC=m
# CONFIG_USB_R8A66597 is not set
CONFIG_USB_PXA27X=m
# CONFIG_USB_MV_UDC is not set
# CONFIG_USB_MV_U3D is not set
CONFIG_USB_SNP_CORE=y
CONFIG_USB_SNP_UDC_PLAT=y
CONFIG_USB_M66592=m
CONFIG_USB_BDC_UDC=m

#
# Platform Support
#
# CONFIG_USB_BDC_PCI is not set
CONFIG_USB_AMD5536UDC=y
# CONFIG_USB_NET2272 is not set
CONFIG_USB_NET2280=y
CONFIG_USB_GOKU=m
CONFIG_USB_EG20T=m
CONFIG_USB_GADGET_XILINX=y
CONFIG_USB_DUMMY_HCD=m
CONFIG_USB_LIBCOMPOSITE=m
CONFIG_USB_F_SS_LB=m
CONFIG_USB_U_ETHER=m
CONFIG_USB_U_AUDIO=m
CONFIG_USB_F_ECM=m
CONFIG_USB_F_PHONET=m
CONFIG_USB_F_SUBSET=m
CONFIG_USB_F_RNDIS=m
CONFIG_USB_F_UAC1=m
CONFIG_USB_F_UAC1_LEGACY=m
CONFIG_USB_F_UVC=m
CONFIG_USB_F_MIDI=m
CONFIG_USB_F_HID=m
CONFIG_USB_F_PRINTER=m
CONFIG_USB_CONFIGFS=m
# CONFIG_USB_CONFIGFS_SERIAL is not set
# CONFIG_USB_CONFIGFS_ACM is not set
# CONFIG_USB_CONFIGFS_OBEX is not set
# CONFIG_USB_CONFIGFS_NCM is not set
CONFIG_USB_CONFIGFS_ECM=y
CONFIG_USB_CONFIGFS_ECM_SUBSET=y
CONFIG_USB_CONFIGFS_RNDIS=y
# CONFIG_USB_CONFIGFS_EEM is not set
CONFIG_USB_CONFIGFS_PHONET=y
CONFIG_USB_CONFIGFS_F_LB_SS=y
# CONFIG_USB_CONFIGFS_F_FS is not set
CONFIG_USB_CONFIGFS_F_UAC1=y
CONFIG_USB_CONFIGFS_F_UAC1_LEGACY=y
# CONFIG_USB_CONFIGFS_F_UAC2 is not set
CONFIG_USB_CONFIGFS_F_MIDI=y
CONFIG_USB_CONFIGFS_F_HID=y
CONFIG_USB_CONFIGFS_F_UVC=y
CONFIG_USB_CONFIGFS_F_PRINTER=y
CONFIG_TYPEC=m
# CONFIG_TYPEC_TCPM is not set
# CONFIG_TYPEC_UCSI is not set
CONFIG_TYPEC_TPS6598X=m
# CONFIG_USB_LED_TRIG is not set
CONFIG_USB_ULPI_BUS=m
# CONFIG_UWB is not set
CONFIG_MMC=y
CONFIG_PWRSEQ_EMMC=m
CONFIG_PWRSEQ_SIMPLE=m
CONFIG_SDIO_UART=y
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
# CONFIG_MMC_SDHCI_PCI is not set
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_OF_ARASAN is not set
# CONFIG_MMC_SDHCI_OF_AT91 is not set
CONFIG_MMC_SDHCI_CADENCE=m
CONFIG_MMC_SDHCI_F_SDH30=m
# CONFIG_MMC_WBSD is not set
CONFIG_MMC_TIFM_SD=m
CONFIG_MMC_GOLDFISH=m
# CONFIG_MMC_SPI is not set
CONFIG_MMC_CB710=m
CONFIG_MMC_VIA_SDMMC=y
CONFIG_MMC_VUB300=m
CONFIG_MMC_USHC=m
CONFIG_MMC_USDHI6ROL0=m
# CONFIG_MMC_REALTEK_PCI is not set
CONFIG_MMC_REALTEK_USB=m
# CONFIG_MMC_CQHCI is not set
CONFIG_MMC_TOSHIBA_PCI=y
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
CONFIG_MMC_SDHCI_OMAP=m
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=m
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_88PM860X is not set
CONFIG_LEDS_AAT1290=m
CONFIG_LEDS_APU=y
CONFIG_LEDS_AS3645A=m
# CONFIG_LEDS_BCM6328 is not set
CONFIG_LEDS_BCM6358=m
# CONFIG_LEDS_LM3530 is not set
CONFIG_LEDS_LM3533=m
CONFIG_LEDS_LM3642=m
CONFIG_LEDS_LM3692X=m
# CONFIG_LEDS_PCA9532 is not set
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_LP3944=y
CONFIG_LEDS_LP3952=m
CONFIG_LEDS_LP55XX_COMMON=y
CONFIG_LEDS_LP5521=m
CONFIG_LEDS_LP5523=y
CONFIG_LEDS_LP5562=y
CONFIG_LEDS_LP8501=y
CONFIG_LEDS_LP8860=y
CONFIG_LEDS_CLEVO_MAIL=m
CONFIG_LEDS_PCA955X=y
CONFIG_LEDS_PCA955X_GPIO=y
CONFIG_LEDS_PCA963X=m
CONFIG_LEDS_WM831X_STATUS=y
CONFIG_LEDS_WM8350=y
# CONFIG_LEDS_DA903X is not set
CONFIG_LEDS_DA9052=m
CONFIG_LEDS_DAC124S085=m
# CONFIG_LEDS_BD2802 is not set
# CONFIG_LEDS_INTEL_SS4200 is not set
CONFIG_LEDS_LT3593=y
CONFIG_LEDS_MC13783=y
CONFIG_LEDS_TCA6507=m
# CONFIG_LEDS_TLC591XX is not set
CONFIG_LEDS_MAX8997=m
# CONFIG_LEDS_LM355x is not set
CONFIG_LEDS_OT200=y
# CONFIG_LEDS_MENF21BMC is not set
CONFIG_LEDS_KTD2692=m
# CONFIG_LEDS_IS31FL319X is not set
# CONFIG_LEDS_IS31FL32XX is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
CONFIG_LEDS_SYSCON=y
CONFIG_LEDS_USER=m
CONFIG_LEDS_NIC78BX=y

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=y
CONFIG_LEDS_TRIGGER_ONESHOT=y
CONFIG_LEDS_TRIGGER_MTD=y
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
CONFIG_LEDS_TRIGGER_BACKLIGHT=y
CONFIG_LEDS_TRIGGER_CPU=y
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=y
CONFIG_LEDS_TRIGGER_DEFAULT_ON=y

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
CONFIG_LEDS_TRIGGER_PANIC=y
CONFIG_LEDS_TRIGGER_NETDEV=y
CONFIG_ACCESSIBILITY=y
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
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
# CONFIG_RTC_INTF_SYSFS is not set
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
CONFIG_RTC_INTF_DEV_UIE_EMUL=y
CONFIG_RTC_DRV_TEST=m

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_88PM860X is not set
# CONFIG_RTC_DRV_88PM80X is not set
# CONFIG_RTC_DRV_ABB5ZES3 is not set
CONFIG_RTC_DRV_ABX80X=m
CONFIG_RTC_DRV_AS3722=m
# CONFIG_RTC_DRV_DS1307 is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
# CONFIG_RTC_DRV_DS1672 is not set
CONFIG_RTC_DRV_HYM8563=m
CONFIG_RTC_DRV_MAX6900=m
# CONFIG_RTC_DRV_MAX8997 is not set
CONFIG_RTC_DRV_RK808=m
CONFIG_RTC_DRV_RS5C372=y
CONFIG_RTC_DRV_ISL1208=m
# CONFIG_RTC_DRV_ISL12022 is not set
# CONFIG_RTC_DRV_X1205 is not set
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
CONFIG_RTC_DRV_PCF85363=m
# CONFIG_RTC_DRV_PCF8563 is not set
# CONFIG_RTC_DRV_PCF8583 is not set
CONFIG_RTC_DRV_M41T80=y
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
CONFIG_RTC_DRV_PALMAS=y
CONFIG_RTC_DRV_TPS80031=y
CONFIG_RTC_DRV_S35390A=y
# CONFIG_RTC_DRV_FM3130 is not set
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=y
# CONFIG_RTC_DRV_RX8025 is not set
CONFIG_RTC_DRV_EM3027=y
# CONFIG_RTC_DRV_RV8803 is not set

#
# SPI RTC drivers
#
CONFIG_RTC_DRV_M41T93=m
# CONFIG_RTC_DRV_M41T94 is not set
CONFIG_RTC_DRV_DS1302=m
# CONFIG_RTC_DRV_DS1305 is not set
CONFIG_RTC_DRV_DS1343=m
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
CONFIG_RTC_DRV_MAX6916=m
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=m
CONFIG_RTC_DRV_RX6110=y
CONFIG_RTC_DRV_RS5C348=y
CONFIG_RTC_DRV_MAX6902=m
CONFIG_RTC_DRV_PCF2123=m
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
# CONFIG_RTC_DRV_DS3232 is not set
CONFIG_RTC_DRV_PCF2127=y
# CONFIG_RTC_DRV_RV3029C2 is not set

#
# Platform RTC drivers
#
# CONFIG_RTC_DRV_CMOS is not set
CONFIG_RTC_DRV_DS1286=y
CONFIG_RTC_DRV_DS1511=y
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=y
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_DA9052=y
CONFIG_RTC_DRV_DA9055=y
# CONFIG_RTC_DRV_DA9063 is not set
# CONFIG_RTC_DRV_STK17TA8 is not set
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=y
# CONFIG_RTC_DRV_M48T59 is not set
# CONFIG_RTC_DRV_MSM6242 is not set
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=y
CONFIG_RTC_DRV_V3020=y
CONFIG_RTC_DRV_WM831X=y
# CONFIG_RTC_DRV_WM8350 is not set
CONFIG_RTC_DRV_PCF50633=m
CONFIG_RTC_DRV_AB3100=y
# CONFIG_RTC_DRV_ZYNQMP is not set
CONFIG_RTC_DRV_CROS_EC=m

#
# on-CPU RTC drivers
#
CONFIG_RTC_DRV_FTRTC010=y
# CONFIG_RTC_DRV_MC13XXX is not set
# CONFIG_RTC_DRV_SNVS is not set
CONFIG_RTC_DRV_R7301=m

#
# HID Sensor RTC drivers
#
CONFIG_RTC_DRV_HID_SENSOR_TIME=m
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
CONFIG_AUXDISPLAY=y
CONFIG_CHARLCD=m
# CONFIG_HD44780 is not set
CONFIG_KS0108=m
CONFIG_KS0108_PORT=0x378
CONFIG_KS0108_DELAY=2
CONFIG_CFAG12864B=m
CONFIG_CFAG12864B_RATE=20
CONFIG_IMG_ASCII_LCD=y
CONFIG_HT16K33=m
CONFIG_PANEL=m
CONFIG_PANEL_PARPORT=0
CONFIG_PANEL_PROFILE=5
CONFIG_PANEL_CHANGE_MESSAGE=y
CONFIG_PANEL_BOOT_MESSAGE=""
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
CONFIG_UIO_DMEM_GENIRQ=m
CONFIG_UIO_AEC=m
# CONFIG_UIO_SERCOS3 is not set
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
CONFIG_UIO_PRUSS=m
CONFIG_UIO_MF624=m
CONFIG_VFIO_IOMMU_TYPE1=y
# CONFIG_VFIO_VIRQFD is not set
CONFIG_VFIO=y
# CONFIG_VFIO_NOIOMMU is not set
# CONFIG_VFIO_PCI is not set
# CONFIG_VFIO_MDEV is not set
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
# CONFIG_VIRTIO_MENU is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# CONFIG_HYPERV_TSCPAGE is not set
# CONFIG_STAGING is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACER_WMI=m
CONFIG_ACER_WIRELESS=m
CONFIG_ACERHDF=y
CONFIG_ALIENWARE_WMI=m
# CONFIG_ASUS_LAPTOP is not set
CONFIG_DELL_SMBIOS=y
# CONFIG_DELL_SMBIOS_WMI is not set
# CONFIG_DELL_SMBIOS_SMM is not set
CONFIG_DELL_LAPTOP=m
CONFIG_DELL_WMI=m
CONFIG_DELL_WMI_DESCRIPTOR=m
# CONFIG_DELL_WMI_AIO is not set
CONFIG_DELL_WMI_LED=m
# CONFIG_DELL_SMO8800 is not set
CONFIG_FUJITSU_LAPTOP=y
CONFIG_FUJITSU_TABLET=y
CONFIG_GPD_POCKET_FAN=y
CONFIG_TC1100_WMI=m
CONFIG_HP_ACCEL=m
# CONFIG_HP_WIRELESS is not set
CONFIG_HP_WMI=y
CONFIG_PANASONIC_LAPTOP=m
CONFIG_SURFACE3_WMI=y
CONFIG_THINKPAD_ACPI=m
# CONFIG_THINKPAD_ACPI_ALSA_SUPPORT is not set
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
CONFIG_SENSORS_HDAPS=m
CONFIG_ASUS_WIRELESS=m
CONFIG_ACPI_WMI=y
CONFIG_WMI_BMOF=m
CONFIG_INTEL_WMI_THUNDERBOLT=m
CONFIG_MSI_WMI=m
# CONFIG_PEAQ_WMI is not set
CONFIG_TOPSTAR_LAPTOP=y
CONFIG_ACPI_TOSHIBA=m
CONFIG_TOSHIBA_BT_RFKILL=y
CONFIG_TOSHIBA_HAPS=m
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_HID_EVENT is not set
CONFIG_INTEL_VBTN=y
CONFIG_INTEL_IPS=m
# CONFIG_INTEL_PMC_CORE is not set
CONFIG_IBM_RTL=y
CONFIG_XO15_EBOOK=m
# CONFIG_SAMSUNG_LAPTOP is not set
CONFIG_MXM_WMI=y
CONFIG_SAMSUNG_Q10=y
CONFIG_APPLE_GMUX=m
CONFIG_INTEL_RST=y
# CONFIG_INTEL_SMARTCONNECT is not set
CONFIG_PVPANIC=m
CONFIG_INTEL_PMC_IPC=m
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_INTEL_PUNIT_IPC=y
CONFIG_MLX_PLATFORM=y
# CONFIG_SILEAD_DMI is not set
# CONFIG_INTEL_CHTDC_TI_PWRBTN is not set
CONFIG_PMC_ATOM=y
CONFIG_GOLDFISH_BUS=y
# CONFIG_GOLDFISH_PIPE is not set
CONFIG_CHROME_PLATFORMS=y
CONFIG_CHROMEOS_LAPTOP=y
CONFIG_CHROMEOS_PSTORE=y
CONFIG_CROS_EC_CTL=m
# CONFIG_CROS_EC_LPC is not set
CONFIG_CROS_EC_PROTO=y
CONFIG_CROS_KBD_LED_BACKLIGHT=m
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
CONFIG_COMMON_CLK_WM831X=y
# CONFIG_CLK_HSDK is not set
# CONFIG_COMMON_CLK_RK808 is not set
CONFIG_COMMON_CLK_SI5351=m
CONFIG_COMMON_CLK_SI514=y
# CONFIG_COMMON_CLK_SI570 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CDCE925 is not set
CONFIG_COMMON_CLK_CS2000_CP=y
# CONFIG_COMMON_CLK_NXP is not set
# CONFIG_COMMON_CLK_PALMAS is not set
# CONFIG_COMMON_CLK_PXA is not set
# CONFIG_COMMON_CLK_PIC32 is not set
# CONFIG_COMMON_CLK_VC5 is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_CLKBLD_I8253=y
# CONFIG_ATMEL_PIT is not set
# CONFIG_SH_TIMER_CMT is not set
# CONFIG_SH_TIMER_MTU2 is not set
# CONFIG_SH_TIMER_TMU is not set
# CONFIG_EM_TIMER_STI is not set
CONFIG_MAILBOX=y
CONFIG_PLATFORM_MHU=m
CONFIG_PCC=y
CONFIG_ALTERA_MBOX=y
# CONFIG_MAILBOX_TEST is not set
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
CONFIG_IOMMU_IOVA=y
CONFIG_OF_IOMMU=y
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
CONFIG_INTEL_IOMMU_DEFAULT_ON=y
CONFIG_INTEL_IOMMU_FLOPPY_WA=y

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
# CONFIG_RPMSG_CHAR is not set
CONFIG_RPMSG_QCOM_GLINK_NATIVE=m
CONFIG_RPMSG_QCOM_GLINK_RPM=m
CONFIG_RPMSG_VIRTIO=y
CONFIG_SOUNDWIRE=y

#
# SoundWire Devices
#
CONFIG_SOUNDWIRE_BUS=m
CONFIG_SOUNDWIRE_CADENCE=m
CONFIG_SOUNDWIRE_INTEL=m

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
# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
CONFIG_XILINX_VCU=y
CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=m
CONFIG_DEVFREQ_GOV_PERFORMANCE=m
CONFIG_DEVFREQ_GOV_POWERSAVE=y
# CONFIG_DEVFREQ_GOV_USERSPACE is not set
CONFIG_DEVFREQ_GOV_PASSIVE=y

#
# DEVFREQ Drivers
#
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=m
CONFIG_EXTCON_GPIO=m
CONFIG_EXTCON_INTEL_INT3496=y
# CONFIG_EXTCON_MAX3355 is not set
# CONFIG_EXTCON_MAX77843 is not set
# CONFIG_EXTCON_MAX8997 is not set
CONFIG_EXTCON_PALMAS=y
CONFIG_EXTCON_RT8973A=y
CONFIG_EXTCON_SM5502=m
# CONFIG_EXTCON_USB_GPIO is not set
CONFIG_EXTCON_USBC_CROS_EC=m
CONFIG_MEMORY=y
CONFIG_IIO=m
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=m
CONFIG_IIO_BUFFER_HW_CONSUMER=m
CONFIG_IIO_KFIFO_BUF=m
CONFIG_IIO_TRIGGERED_BUFFER=m
CONFIG_IIO_CONFIGFS=m
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
# CONFIG_IIO_SW_DEVICE is not set
CONFIG_IIO_SW_TRIGGER=m

#
# Accelerometers
#
CONFIG_ADXL345=m
CONFIG_ADXL345_I2C=m
# CONFIG_ADXL345_SPI is not set
CONFIG_BMA180=m
CONFIG_BMA220=m
CONFIG_BMC150_ACCEL=m
CONFIG_BMC150_ACCEL_I2C=m
CONFIG_BMC150_ACCEL_SPI=m
CONFIG_DA280=m
CONFIG_DA311=m
# CONFIG_DMARD06 is not set
# CONFIG_DMARD09 is not set
CONFIG_DMARD10=m
CONFIG_HID_SENSOR_ACCEL_3D=m
# CONFIG_IIO_CROS_EC_ACCEL_LEGACY is not set
CONFIG_IIO_ST_ACCEL_3AXIS=m
CONFIG_IIO_ST_ACCEL_I2C_3AXIS=m
CONFIG_IIO_ST_ACCEL_SPI_3AXIS=m
# CONFIG_KXSD9 is not set
CONFIG_KXCJK1013=m
CONFIG_MC3230=m
CONFIG_MMA7455=m
# CONFIG_MMA7455_I2C is not set
CONFIG_MMA7455_SPI=m
CONFIG_MMA7660=m
CONFIG_MMA8452=m
CONFIG_MMA9551_CORE=m
CONFIG_MMA9551=m
# CONFIG_MMA9553 is not set
CONFIG_MXC4005=m
CONFIG_MXC6255=m
# CONFIG_SCA3000 is not set
CONFIG_STK8312=m
CONFIG_STK8BA50=m

#
# Analog to digital converters
#
CONFIG_AD_SIGMA_DELTA=m
# CONFIG_AD7266 is not set
CONFIG_AD7291=m
CONFIG_AD7298=m
CONFIG_AD7476=m
CONFIG_AD7766=m
# CONFIG_AD7791 is not set
CONFIG_AD7793=m
CONFIG_AD7887=m
# CONFIG_AD7923 is not set
CONFIG_AD799X=m
# CONFIG_DLN2_ADC is not set
# CONFIG_ENVELOPE_DETECTOR is not set
# CONFIG_HI8435 is not set
CONFIG_HX711=m
CONFIG_INA2XX_ADC=m
CONFIG_LTC2471=m
CONFIG_LTC2485=m
# CONFIG_LTC2497 is not set
CONFIG_MAX1027=m
CONFIG_MAX11100=m
CONFIG_MAX1118=m
CONFIG_MAX1363=m
CONFIG_MAX9611=m
# CONFIG_MCP320X is not set
# CONFIG_MCP3422 is not set
CONFIG_MEN_Z188_ADC=m
CONFIG_NAU7802=m
# CONFIG_PALMAS_GPADC is not set
CONFIG_SD_ADC_MODULATOR=m
CONFIG_TI_ADC081C=m
# CONFIG_TI_ADC0832 is not set
# CONFIG_TI_ADC084S021 is not set
# CONFIG_TI_ADC12138 is not set
CONFIG_TI_ADC108S102=m
# CONFIG_TI_ADC128S052 is not set
CONFIG_TI_ADC161S626=m
CONFIG_TI_ADS1015=m
# CONFIG_TI_ADS7950 is not set
CONFIG_TI_ADS8688=m
CONFIG_TI_TLC4541=m
CONFIG_VF610_ADC=m

#
# Amplifiers
#
# CONFIG_AD8366 is not set

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=m
# CONFIG_CCS811 is not set
CONFIG_IAQCORE=m
CONFIG_VZ89X=m
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
CONFIG_IIO_SSP_SENSORS_COMMONS=m
CONFIG_IIO_SSP_SENSORHUB=m
CONFIG_IIO_ST_SENSORS_I2C=m
CONFIG_IIO_ST_SENSORS_SPI=m
CONFIG_IIO_ST_SENSORS_CORE=m

#
# Counters
#

#
# Digital to analog converters
#
# CONFIG_AD5064 is not set
# CONFIG_AD5360 is not set
# CONFIG_AD5380 is not set
CONFIG_AD5421=m
CONFIG_AD5446=m
CONFIG_AD5449=m
CONFIG_AD5592R_BASE=m
CONFIG_AD5592R=m
CONFIG_AD5593R=m
CONFIG_AD5504=m
# CONFIG_AD5624R_SPI is not set
CONFIG_LTC2632=m
CONFIG_AD5686=m
# CONFIG_AD5755 is not set
# CONFIG_AD5761 is not set
# CONFIG_AD5764 is not set
CONFIG_AD5791=m
CONFIG_AD7303=m
# CONFIG_CIO_DAC is not set
# CONFIG_AD8801 is not set
# CONFIG_DPOT_DAC is not set
CONFIG_DS4424=m
CONFIG_M62332=m
CONFIG_MAX517=m
CONFIG_MAX5821=m
CONFIG_MCP4725=m
# CONFIG_MCP4922 is not set
# CONFIG_TI_DAC082S085 is not set
# CONFIG_VF610_DAC is not set

#
# IIO dummy driver
#

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
# CONFIG_ADF4350 is not set

#
# Digital gyroscope sensors
#
# CONFIG_ADIS16080 is not set
CONFIG_ADIS16130=m
CONFIG_ADIS16136=m
CONFIG_ADIS16260=m
CONFIG_ADXRS450=m
CONFIG_BMG160=m
CONFIG_BMG160_I2C=m
CONFIG_BMG160_SPI=m
CONFIG_HID_SENSOR_GYRO_3D=m
CONFIG_MPU3050=m
CONFIG_MPU3050_I2C=m
CONFIG_IIO_ST_GYRO_3AXIS=m
CONFIG_IIO_ST_GYRO_I2C_3AXIS=m
CONFIG_IIO_ST_GYRO_SPI_3AXIS=m
CONFIG_ITG3200=m

#
# Health Sensors
#

#
# Heart Rate Monitors
#
# CONFIG_AFE4403 is not set
CONFIG_AFE4404=m
# CONFIG_MAX30100 is not set
# CONFIG_MAX30102 is not set

#
# Humidity sensors
#
CONFIG_AM2315=m
# CONFIG_DHT11 is not set
# CONFIG_HDC100X is not set
CONFIG_HID_SENSOR_HUMIDITY=m
CONFIG_HTS221=m
CONFIG_HTS221_I2C=m
CONFIG_HTS221_SPI=m
CONFIG_HTU21=m
CONFIG_SI7005=m
CONFIG_SI7020=m

#
# Inertial measurement units
#
# CONFIG_ADIS16400 is not set
# CONFIG_ADIS16480 is not set
CONFIG_BMI160=m
# CONFIG_BMI160_I2C is not set
CONFIG_BMI160_SPI=m
CONFIG_KMX61=m
CONFIG_INV_MPU6050_IIO=m
# CONFIG_INV_MPU6050_I2C is not set
CONFIG_INV_MPU6050_SPI=m
CONFIG_IIO_ST_LSM6DSX=m
CONFIG_IIO_ST_LSM6DSX_I2C=m
CONFIG_IIO_ST_LSM6DSX_SPI=m
CONFIG_IIO_ADIS_LIB=m
CONFIG_IIO_ADIS_LIB_BUFFER=y

#
# Light sensors
#
CONFIG_ACPI_ALS=m
CONFIG_ADJD_S311=m
# CONFIG_AL3320A is not set
# CONFIG_APDS9300 is not set
# CONFIG_APDS9960 is not set
CONFIG_BH1750=m
CONFIG_BH1780=m
CONFIG_CM32181=m
CONFIG_CM3232=m
CONFIG_CM3323=m
# CONFIG_CM3605 is not set
# CONFIG_CM36651 is not set
CONFIG_IIO_CROS_EC_LIGHT_PROX=m
CONFIG_GP2AP020A00F=m
CONFIG_SENSORS_ISL29018=m
CONFIG_SENSORS_ISL29028=m
# CONFIG_ISL29125 is not set
# CONFIG_HID_SENSOR_ALS is not set
# CONFIG_HID_SENSOR_PROX is not set
CONFIG_JSA1212=m
# CONFIG_RPR0521 is not set
CONFIG_SENSORS_LM3533=m
CONFIG_LTR501=m
CONFIG_MAX44000=m
CONFIG_OPT3001=m
# CONFIG_PA12203001 is not set
# CONFIG_SI1145 is not set
CONFIG_STK3310=m
CONFIG_ST_UVIS25=m
CONFIG_ST_UVIS25_I2C=m
CONFIG_ST_UVIS25_SPI=m
CONFIG_TCS3414=m
# CONFIG_TCS3472 is not set
CONFIG_SENSORS_TSL2563=m
CONFIG_TSL2583=m
# CONFIG_TSL4531 is not set
CONFIG_US5182D=m
CONFIG_VCNL4000=m
CONFIG_VEML6070=m
CONFIG_VL6180=m
CONFIG_ZOPT2201=m

#
# Magnetometer sensors
#
CONFIG_AK8974=m
CONFIG_AK8975=m
CONFIG_AK09911=m
CONFIG_BMC150_MAGN=m
CONFIG_BMC150_MAGN_I2C=m
CONFIG_BMC150_MAGN_SPI=m
# CONFIG_MAG3110 is not set
# CONFIG_HID_SENSOR_MAGNETOMETER_3D is not set
CONFIG_MMC35240=m
# CONFIG_IIO_ST_MAGN_3AXIS is not set
CONFIG_SENSORS_HMC5843=m
CONFIG_SENSORS_HMC5843_I2C=m
CONFIG_SENSORS_HMC5843_SPI=m

#
# Multiplexers
#
CONFIG_IIO_MUX=m

#
# Inclinometer sensors
#
# CONFIG_HID_SENSOR_INCLINOMETER_3D is not set
CONFIG_HID_SENSOR_DEVICE_ROTATION=m

#
# Triggers - standalone
#
# CONFIG_IIO_HRTIMER_TRIGGER is not set
CONFIG_IIO_INTERRUPT_TRIGGER=m
CONFIG_IIO_TIGHTLOOP_TRIGGER=m
CONFIG_IIO_SYSFS_TRIGGER=m

#
# Digital potentiometers
#
CONFIG_DS1803=m
# CONFIG_MAX5481 is not set
CONFIG_MAX5487=m
CONFIG_MCP4131=m
CONFIG_MCP4531=m
# CONFIG_TPL0102 is not set

#
# Digital potentiostats
#
# CONFIG_LMP91000 is not set

#
# Pressure sensors
#
# CONFIG_ABP060MG is not set
CONFIG_BMP280=m
CONFIG_BMP280_I2C=m
CONFIG_BMP280_SPI=m
CONFIG_IIO_CROS_EC_BARO=m
# CONFIG_HID_SENSOR_PRESS is not set
# CONFIG_HP03 is not set
# CONFIG_MPL115_I2C is not set
# CONFIG_MPL115_SPI is not set
# CONFIG_MPL3115 is not set
CONFIG_MS5611=m
CONFIG_MS5611_I2C=m
# CONFIG_MS5611_SPI is not set
# CONFIG_MS5637 is not set
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
# CONFIG_LIDAR_LITE_V2 is not set
CONFIG_RFD77402=m
CONFIG_SRF04=m
CONFIG_SX9500=m
CONFIG_SRF08=m

#
# Temperature sensors
#
# CONFIG_MAXIM_THERMOCOUPLE is not set
CONFIG_HID_SENSOR_TEMP=m
# CONFIG_MLX90614 is not set
# CONFIG_TMP006 is not set
CONFIG_TMP007=m
CONFIG_TSYS01=m
# CONFIG_TSYS02D is not set
CONFIG_NTB=m
CONFIG_NTB_IDT=m
CONFIG_NTB_SWITCHTEC=m
CONFIG_NTB_PINGPONG=m
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
CONFIG_NTB_TRANSPORT=m
# CONFIG_VME_BUS is not set
# CONFIG_PWM is not set

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
CONFIG_ARM_GIC_MAX_NR=1
# CONFIG_ARM_GIC_V3_ITS is not set
CONFIG_IPACK_BUS=m
# CONFIG_BOARD_TPCI200 is not set
CONFIG_SERIAL_IPOCTAL=m
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
# CONFIG_FMC is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_BCM_KONA_USB2_PHY=m
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_CPCAP_USB is not set
# CONFIG_PHY_QCOM_USB_HS is not set
CONFIG_PHY_QCOM_USB_HSIC=m
CONFIG_PHY_SAMSUNG_USB2=y
# CONFIG_PHY_EXYNOS4210_USB2 is not set
# CONFIG_PHY_EXYNOS4X12_USB2 is not set
# CONFIG_PHY_EXYNOS5250_USB2 is not set
# CONFIG_PHY_TUSB1210 is not set
CONFIG_POWERCAP=y
# CONFIG_INTEL_RAPL is not set
CONFIG_MCB=m
CONFIG_MCB_PCI=m
CONFIG_MCB_LPC=m

#
# Performance monitor support
#
# CONFIG_RAS is not set
CONFIG_THUNDERBOLT=y

#
# Android
#
# CONFIG_ANDROID is not set
CONFIG_DAX=y
CONFIG_DEV_DAX=y
CONFIG_NVMEM=y
# CONFIG_STM is not set
CONFIG_INTEL_TH=y
# CONFIG_INTEL_TH_PCI is not set
CONFIG_INTEL_TH_GTH=m
# CONFIG_INTEL_TH_MSU is not set
CONFIG_INTEL_TH_PTI=m
CONFIG_INTEL_TH_DEBUG=y
CONFIG_FPGA=y
CONFIG_ALTERA_PR_IP_CORE=y
CONFIG_ALTERA_PR_IP_CORE_PLAT=m
CONFIG_FPGA_MGR_ALTERA_PS_SPI=m
CONFIG_FPGA_MGR_ALTERA_CVP=m
# CONFIG_FPGA_MGR_XILINX_SPI is not set
CONFIG_FPGA_MGR_ICE40_SPI=m
CONFIG_FPGA_BRIDGE=m
CONFIG_XILINX_PR_DECOUPLER=m
CONFIG_FPGA_REGION=m
CONFIG_OF_FPGA_REGION=m
# CONFIG_FSI is not set
CONFIG_MULTIPLEXER=m

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=m
CONFIG_MUX_GPIO=m
# CONFIG_MUX_MMIO is not set
CONFIG_PM_OPP=y
CONFIG_SIOX=y
CONFIG_SIOX_BUS_GPIO=y
CONFIG_SLIMBUS=y
CONFIG_SLIM_QCOM_CTRL=m

#
# Firmware Drivers
#
CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DELL_RBU=m
CONFIG_DCDBAS=y
CONFIG_DMIID=y
# CONFIG_DMI_SYSFS is not set
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_ISCSI_IBFT_FIND=y
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
CONFIG_GOOGLE_FIRMWARE=y
# CONFIG_GOOGLE_SMI is not set
CONFIG_GOOGLE_COREBOOT_TABLE=y
CONFIG_GOOGLE_COREBOOT_TABLE_ACPI=y
CONFIG_GOOGLE_COREBOOT_TABLE_OF=y
CONFIG_GOOGLE_MEMCONSOLE=y
CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY=m
CONFIG_GOOGLE_MEMCONSOLE_COREBOOT=y
CONFIG_GOOGLE_VPD=m

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
# CONFIG_EFI_VARS_PSTORE is not set
# CONFIG_EFI_RUNTIME_MAP is not set
CONFIG_EFI_FAKE_MEMMAP=y
CONFIG_EFI_MAX_FAKE_MEM=8
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_BOOTLOADER_CONTROL=y
CONFIG_EFI_CAPSULE_LOADER=y
CONFIG_EFI_CAPSULE_QUIRK_QUARK_CSH=y
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
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
# CONFIG_MANDATORY_FILE_LOCKING is not set
# CONFIG_FS_ENCRYPTION is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
# CONFIG_PRINT_QUOTA_WARNING is not set
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=m
CONFIG_QFMT_V1=m
CONFIG_QFMT_V2=m
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS4_FS is not set
CONFIG_FUSE_FS=y
# CONFIG_CUSE is not set
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
# CONFIG_FSCACHE is not set

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
# CONFIG_HUGETLB_PAGE is not set
CONFIG_CONFIGFS_FS=y
# CONFIG_EFIVAR_FS is not set
CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
CONFIG_ECRYPT_FS=m
# CONFIG_ECRYPT_FS_MESSAGING is not set
CONFIG_JFFS2_FS=y
CONFIG_JFFS2_FS_DEBUG=0
CONFIG_JFFS2_FS_WRITEBUFFER=y
# CONFIG_JFFS2_FS_WBUF_VERIFY is not set
# CONFIG_JFFS2_SUMMARY is not set
CONFIG_JFFS2_FS_XATTR=y
# CONFIG_JFFS2_FS_POSIX_ACL is not set
# CONFIG_JFFS2_FS_SECURITY is not set
# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
CONFIG_JFFS2_ZLIB=y
# CONFIG_JFFS2_LZO is not set
CONFIG_JFFS2_RTIME=y
# CONFIG_JFFS2_RUBIN is not set
CONFIG_UBIFS_FS=m
CONFIG_UBIFS_FS_ADVANCED_COMPR=y
# CONFIG_UBIFS_FS_LZO is not set
CONFIG_UBIFS_FS_ZLIB=y
# CONFIG_UBIFS_ATIME_SUPPORT is not set
CONFIG_UBIFS_FS_SECURITY=y
CONFIG_CRAMFS=m
# CONFIG_CRAMFS_MTD is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
# CONFIG_PSTORE_ZLIB_COMPRESS is not set
CONFIG_PSTORE_LZO_COMPRESS=y
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
# CONFIG_PSTORE_RAM is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=m
CONFIG_NFS_SWAP=y
# CONFIG_NFS_V4_1 is not set
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V3_ACL is not set
# CONFIG_NFSD_V4 is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_SWAP=y
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=y
# CONFIG_CIFS_STATS is not set
# CONFIG_CIFS_WEAK_PW_HASH is not set
# CONFIG_CIFS_UPCALL is not set
CONFIG_CIFS_XATTR=y
# CONFIG_CIFS_POSIX is not set
CONFIG_CIFS_ACL=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
CONFIG_CIFS_SMB311=y
CONFIG_CODA_FS=y
# CONFIG_AFS_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_737=y
CONFIG_NLS_CODEPAGE_775=y
CONFIG_NLS_CODEPAGE_850=y
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
CONFIG_NLS_CODEPAGE_863=m
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
CONFIG_NLS_CODEPAGE_869=y
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
CONFIG_NLS_CODEPAGE_932=m
# CONFIG_NLS_CODEPAGE_949 is not set
CONFIG_NLS_CODEPAGE_874=y
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=y
CONFIG_NLS_ISO8859_5=y
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=y
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=m
# CONFIG_NLS_KOI8_R is not set
CONFIG_NLS_KOI8_U=y
# CONFIG_NLS_MAC_ROMAN is not set
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=y
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=y
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
# CONFIG_NLS_MAC_ROMANIAN is not set
CONFIG_NLS_MAC_TURKISH=y
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
CONFIG_DLM_DEBUG=y

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
# CONFIG_ENABLE_WARN_DEPRECATED is not set
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_FRAME_WARN=1024
CONFIG_STRIP_ASM_SYMS=y
CONFIG_READABLE_ASM=y
CONFIG_UNUSED_SYMBOLS=y
# CONFIG_PAGE_OWNER is not set
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
CONFIG_DEBUG_SECTION_MISMATCH=y
# CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
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
CONFIG_DEBUG_PAGEALLOC=y
# CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT is not set
CONFIG_PAGE_POISONING=y
# CONFIG_PAGE_POISONING_NO_SANITY is not set
CONFIG_PAGE_POISONING_ZERO=y
CONFIG_DEBUG_RODATA_TEST=y
CONFIG_DEBUG_OBJECTS=y
# CONFIG_DEBUG_OBJECTS_SELFTEST is not set
CONFIG_DEBUG_OBJECTS_FREE=y
# CONFIG_DEBUG_OBJECTS_TIMERS is not set
# CONFIG_DEBUG_OBJECTS_WORK is not set
# CONFIG_DEBUG_OBJECTS_RCU_HEAD is not set
# CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER is not set
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
# CONFIG_DEBUG_SLAB is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
CONFIG_DEBUG_VM=y
CONFIG_DEBUG_VM_VMACACHE=y
CONFIG_DEBUG_VM_RB=y
CONFIG_DEBUG_VM_PGFLAGS=y
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_MEMORY_INIT is not set
# CONFIG_DEBUG_PER_CPU_MAPS is not set
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
# CONFIG_SCHEDSTATS is not set
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
CONFIG_PROVE_LOCKING=y
CONFIG_LOCKDEP=y
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=y
# CONFIG_WW_MUTEX_SELFTEST is not set
CONFIG_TRACE_IRQFLAGS=y
CONFIG_STACKTRACE=y
CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PI_LIST is not set
CONFIG_DEBUG_SG=y
CONFIG_DEBUG_NOTIFIERS=y
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
CONFIG_TORTURE_TEST=y
# CONFIG_RCU_PERF_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
CONFIG_CPU_HOTPLUG_STATE_CONTROL=y
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
# CONFIG_FAIL_FUTEX is not set
# CONFIG_FAULT_INJECTION_DEBUG_FS is not set
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
CONFIG_RUNTIME_TESTING_MENU=y
CONFIG_TEST_LIST_SORT=y
CONFIG_TEST_SORT=y
# CONFIG_BACKTRACE_SELF_TEST is not set
CONFIG_RBTREE_TEST=y
CONFIG_INTERVAL_TREE_TEST=m
CONFIG_PERCPU_TEST=m
CONFIG_ATOMIC64_SELFTEST=m
# CONFIG_TEST_HEXDUMP is not set
CONFIG_TEST_STRING_HELPERS=y
CONFIG_TEST_KSTRTOX=m
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_BITMAP is not set
CONFIG_TEST_UUID=y
CONFIG_TEST_RHASHTABLE=m
CONFIG_TEST_HASH=y
CONFIG_TEST_LKM=m
CONFIG_TEST_USER_COPY=m
CONFIG_TEST_BPF=m
CONFIG_FIND_BIT_BENCHMARK=m
CONFIG_TEST_FIRMWARE=m
# CONFIG_TEST_SYSCTL is not set
# CONFIG_TEST_UDELAY is not set
CONFIG_TEST_STATIC_KEYS=m
# CONFIG_TEST_DEBUG_VIRTUAL is not set
# CONFIG_MEMTEST is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_ARCH_WANTS_UBSAN_NO_NULL is not set
CONFIG_UBSAN=y
# CONFIG_UBSAN_SANITIZE_ALL is not set
# CONFIG_UBSAN_ALIGNMENT is not set
# CONFIG_UBSAN_NULL is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
# CONFIG_EARLY_PRINTK_DBGP is not set
CONFIG_EARLY_PRINTK_EFI=y
# CONFIG_EARLY_PRINTK_USB_XDBC is not set
CONFIG_X86_PTDUMP_CORE=y
CONFIG_X86_PTDUMP=m
CONFIG_EFI_PGT_DUMP=y
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
# CONFIG_IO_DELAY_UDELAY is not set
CONFIG_IO_DELAY_NONE=y
CONFIG_DEFAULT_IO_DELAY_TYPE=3
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
CONFIG_OPTIMIZE_INLINING=y
CONFIG_DEBUG_ENTRY=y
CONFIG_DEBUG_NMI_SELFTEST=y
CONFIG_X86_DEBUG_FPU=y
CONFIG_PUNIT_ATOM_DEBUG=y
CONFIG_UNWINDER_FRAME_POINTER=y
# CONFIG_UNWINDER_GUESS is not set

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_BIG_KEYS is not set
CONFIG_TRUSTED_KEYS=m
CONFIG_ENCRYPTED_KEYS=m
CONFIG_KEY_DH_OPERATIONS=y
CONFIG_SECURITY_DMESG_RESTRICT=y
CONFIG_SECURITY=y
# CONFIG_SECURITY_WRITABLE_HOOKS is not set
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
# CONFIG_SECURITY_NETWORK_XFRM is not set
# CONFIG_SECURITY_PATH is not set
# CONFIG_INTEL_TXT is not set
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
# CONFIG_HARDENED_USERCOPY_FALLBACK is not set
# CONFIG_HARDENED_USERCOPY_PAGESPAN is not set
# CONFIG_FORTIFY_SOURCE is not set
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
CONFIG_SECURITY_SMACK=y
CONFIG_SECURITY_SMACK_BRINGUP=y
# CONFIG_SECURITY_SMACK_APPEND_SIGNALS is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_YAMA is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
# CONFIG_INTEGRITY_ASYMMETRIC_KEYS is not set
# CONFIG_IMA is not set
# CONFIG_EVM is not set
CONFIG_DEFAULT_SECURITY_SMACK=y
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_DEFAULT_SECURITY="smack"
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
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=y
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=m
CONFIG_CRYPTO_MCRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_ABLK_HELPER=m
CONFIG_CRYPTO_GLUE_HELPER_X86=m
CONFIG_CRYPTO_ENGINE=y

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=m
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=m
CONFIG_CRYPTO_CTR=y
# CONFIG_CRYPTO_CTS is not set
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XTS=m
CONFIG_CRYPTO_KEYWRAP=y

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
# CONFIG_CRYPTO_CRC32 is not set
# CONFIG_CRYPTO_CRC32_PCLMUL is not set
CONFIG_CRYPTO_CRCT10DIF=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD128=y
CONFIG_CRYPTO_RMD160=y
CONFIG_CRYPTO_RMD256=y
CONFIG_CRYPTO_RMD320=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
# CONFIG_CRYPTO_SHA3 is not set
CONFIG_CRYPTO_SM3=m
CONFIG_CRYPTO_TGR192=m
CONFIG_CRYPTO_WP512=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=y
CONFIG_CRYPTO_AES_586=y
# CONFIG_CRYPTO_AES_NI_INTEL is not set
CONFIG_CRYPTO_ANUBIS=y
CONFIG_CRYPTO_ARC4=y
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_CAMELLIA is not set
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
# CONFIG_CRYPTO_CAST6 is not set
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SALSA20=y
CONFIG_CRYPTO_SALSA20_586=y
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_586=m
CONFIG_CRYPTO_TEA=y
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_586=y

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=y
CONFIG_CRYPTO_LZ4=m
CONFIG_CRYPTO_LZ4HC=y

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
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=m
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
# CONFIG_CRYPTO_DEV_PADLOCK is not set
CONFIG_CRYPTO_DEV_GEODE=m
CONFIG_CRYPTO_DEV_HIFN_795X=m
CONFIG_CRYPTO_DEV_HIFN_795X_RNG=y
# CONFIG_CRYPTO_DEV_FSL_CAAM_CRYPTO_API_DESC is not set
CONFIG_CRYPTO_DEV_CCP=y
# CONFIG_CRYPTO_DEV_CCP_DD is not set
CONFIG_CRYPTO_DEV_QAT=y
CONFIG_CRYPTO_DEV_QAT_DH895xCC=y
CONFIG_CRYPTO_DEV_QAT_C3XXX=y
CONFIG_CRYPTO_DEV_QAT_C62X=m
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=y
CONFIG_CRYPTO_DEV_QAT_C62XVF=y
CONFIG_CRYPTO_DEV_VIRTIO=y
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
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
CONFIG_VHOST_NET=y
CONFIG_VHOST_VSOCK=m
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
CONFIG_CRC_T10DIF=m
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=m
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC4 is not set
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=y
CONFIG_CRC8=m
# CONFIG_AUDIT_ARCH_COMPAT_GENERIC is not set
CONFIG_RANDOM32_SELFTEST=y
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=m
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
# CONFIG_XZ_DEC_POWERPC is not set
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
# CONFIG_XZ_DEC_SPARC is not set
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=y
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_DEC16=y
CONFIG_BCH=y
CONFIG_BCH_CONST_PARAMS=y
CONFIG_INTERVAL_TREE=y
CONFIG_RADIX_TREE_MULTIORDER=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_SGL_ALLOC=y
# CONFIG_DMA_DIRECT_OPS is not set
# CONFIG_DMA_VIRT_OPS is not set
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_CORDIC=m
# CONFIG_DDR is not set
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_FONT_SUPPORT=y
CONFIG_FONT_8x16=y
CONFIG_FONT_AUTOSELECT=y
# CONFIG_SG_SPLIT is not set
# CONFIG_SG_POOL is not set
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_PRIME_NUMBERS=m
# CONFIG_STRING_SELFTEST is not set

--7ej6mdx5ofjufdrf--
