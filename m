Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751435AbeDGKH0 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 06:07:26 -0400
Received: from mga18.intel.com ([134.134.136.126]:12060 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751186AbeDGKHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 06:07:23 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,418,1517904000";
   d="gz'50?scan'50,208,50";a="31449887"
Date: Sat, 07 Apr 2018 18:06:49 +0800
From: kernel test robot <lkp@intel.com>
To: David Howells <dhowells@redhat.com>
Cc: LKP <lkp@01.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-afs@lists.infradead.org, wfg@linux.intel.com
Subject: ace45bec6d ("rxrpc: Fix firewall route keepalive"):  watchdog:
 BUG: soft lockup - CPU#0 stuck for 22s! [kworker/0:1:21]
Message-ID: <5ac89839.7Lq3iBT2DgECIDuO%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_5ac89839.QuAuK65/3XH6H+9kiCOlXwpsf6ZS5K1sJIOckn+W24XajxOY"
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--=_5ac89839.QuAuK65/3XH6H+9kiCOlXwpsf6ZS5K1sJIOckn+W24XajxOY
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
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
f605ba97fb  Merge tag 'vfio-v4.17-rc1' of git://github.com/awilliam/linux-vfio
5e1dacccbb  Add linux-next specific files for 20180406
+------------------------------------------------+------------+------------+------------+---------------+
|                                                | c0b6edef0b | ace45bec6d | f605ba97fb | next-20180406 |
+------------------------------------------------+------------+------------+------------+---------------+
| boot_successes                                 | 117        | 12         | 15         | 7             |
| boot_failures                                  | 0          | 23         | 30         | 19            |
| BUG:soft_lockup-CPU##stuck_for#s               | 0          | 23         | 30         | 18            |
| EIP:lock_acquired                              | 0          | 3          | 2          | 3             |
| Kernel_panic-not_syncing:softlockup:hung_tasks | 0          | 23         | 30         | 19            |
| EIP:rxrpc_peer_keepalive_worker                | 0          | 2          | 0          | 1             |
| EIP:_raw_spin_lock_bh                          | 0          | 2          | 1          |               |
| EIP:lock_acquire                               | 0          | 5          | 10         | 3             |
| EIP:do_raw_spin_trylock                        | 0          | 1          | 1          |               |
| EIP:__local_bh_enable_ip                       | 0          | 6          | 2          | 3             |
| EIP:lock_release                               | 0          | 2          | 10         | 6             |
| EIP:_raw_spin_unlock_bh                        | 0          | 1          | 1          | 1             |
| EIP:__local_bh_disable_ip                      | 0          | 1          | 2          | 2             |
| EIP:do_raw_spin_unlock                         | 0          | 0          | 1          |               |
+------------------------------------------------+------------+------------+------------+---------------+

[  106.318058] audit: type=1326 audit(1523091824.650:24): auid=4294967295 uid=65534 gid=65534 ses=4294967295 pid=725 comm="trinity-c2" exe="/trinity" sig=9 arch=40000003 syscall=19 compat=0 ip=0x6ffd9cc9 code=0x0
[  106.660067] audit: type=1326 audit(1523091824.990:25): auid=4294967295 uid=65534 gid=65534 ses=4294967295 pid=740 comm="trinity-c2" exe="/trinity" sig=9 arch=40000003 syscall=19 compat=0 ip=0x6ffd9cc9 code=0x0
[  106.836490] futex_wake_op: trinity-c3 tries to shift op by -1; fix this program
[  115.175554] warning: process `trinity-c3' used the obsolete bdflush system call
[  115.176314] Fix your initscripts?
[  140.036018] watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [kworker/0:1:21]
[  140.039170] irq event stamp: 245658671
[  140.039756] hardirqs last  enabled at (245658669): [<08d396ee>] __local_bh_enable_ip+0x88/0x120
[  140.041033] hardirqs last disabled at (245658671): [<b952e062>] apic_timer_interrupt+0x3a/0x50
[  140.042317] softirqs last  enabled at (245658668): [<38769241>] rxrpc_peer_keepalive_worker+0x2dc/0x350
[  140.043695] softirqs last disabled at (245658670): [<32696987>] rxrpc_peer_keepalive_worker+0x5f/0x350
[  140.045059] CPU: 0 PID: 21 Comm: kworker/0:1 Not tainted 4.16.0-rc6-02064-gace45be #1
[  140.046225] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[  140.047461] Workqueue: krxrpcd rxrpc_peer_keepalive_worker
[  140.048280] EIP: lock_acquire+0xcf/0x1ed
[  140.048864] EFLAGS: 00000202 CPU: 0
[  140.049393] EAX: 00000202 EBX: 84e05200 ECX: 00000000 EDX: 00000000
[  140.050328] ESI: 00000000 EDI: 00000000 EBP: 78343eac ESP: 78343e94
[  140.051255]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
[  140.052050] CR0: 80050033 CR2: 08d84dd4 CR3: 0c307000 CR4: 001406d0
[  140.052978] DR0: 6ef4b000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[  140.053900] DR6: ffff0ff0 DR7: 00000600
[  140.054573] Call Trace:
[  140.054953]  ? _raw_spin_lock_bh+0x2b/0x60
[  140.055574]  ? rxrpc_peer_keepalive_worker+0x5f/0x350
[  140.056326]  ? rxrpc_peer_keepalive_worker+0x5f/0x350
[  140.057074]  ? __lock_is_held+0x48/0x90
[  140.057660]  ? process_one_work+0x1a3/0x590
[  140.058302]  ? worker_thread+0x39/0x3b0
[  140.058876]  ? kthread+0xda/0x110
[  140.059384]  ? process_one_work+0x590/0x590
[  140.060007]  ? __kthread_bind_mask+0x60/0x60
[  140.060652]  ? ret_from_fork+0x19/0x30
[  140.061220] Code: f0 e8 76 d4 ff ff 64 a1 8c 57 54 7a c7 80 fc 05 00 00 00 00 00 00 a1 80 20 32 7a 83 c4 1c 85 c0 0f 84 c6 00 00 00 8b 45 e8 50 9d <8d> 74 26 00 8d 65 f4 5b 5e 5f 5d c3 90 8d 74 26 00 64 a1 04 01
[  140.064183] Kernel panic - not syncing: softlockup: hung tasks
[  140.065061] CPU: 0 PID: 21 Comm: kworker/0:1 Tainted: G             L   4.16.0-rc6-02064-gace45be #1
[  140.066406] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[  140.067655] Workqueue: krxrpcd rxrpc_peer_keepalive_worker
[  140.068475] Call Trace:
[  140.068852]  ? dump_stack+0xa2/0xf1
[  140.069386]  ? panic+0x9f/0x1f8
[  140.069864]  ? watchdog_timer_fn+0x20b/0x210
[  140.070507]  ? __hrtimer_run_queues+0x149/0x530
[  140.071176]  ? watchdog+0x20/0x20
[  140.071699]  ? hrtimer_run_queues+0xd6/0x100
[  140.072345]  ? run_local_timers+0x15/0x40
[  140.072947]  ? update_process_times+0x18/0x40
[  140.073739]  ? tick_nohz_handler+0x78/0x110
[  140.074375]  ? smp_apic_timer_interrupt+0x6c/0x2b0
[  140.075086]  ? apic_timer_interrupt+0x41/0x50
[  140.075743]  ? proc_sched_show_task+0x1c0b/0x2ff0
[  140.076449]  ? lock_acquire+0xcf/0x1ed
[  140.077010]  ? _raw_spin_lock_bh+0x2b/0x60
[  140.077630]  ? rxrpc_peer_keepalive_worker+0x5f/0x350
[  140.078403]  ? rxrpc_peer_keepalive_worker+0x5f/0x350
[  140.079152]  ? __lock_is_held+0x48/0x90
[  140.079734]  ? process_one_work+0x1a3/0x590
[  140.080373]  ? worker_thread+0x39/0x3b0
[  140.080944]  ? kthread+0xda/0x110
[  140.081448]  ? process_one_work+0x590/0x590
[  140.082070]  ? __kthread_bind_mask+0x60/0x60
[  140.082720]  ? ret_from_fork+0x19/0x30
[  140.083381] Kernel Offset: disabled


                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start cd5cce67ff06509cd3821499dec6879315f7169d 0adb32858b0bddf4ada5f364a84ed60b196dbcda --
git bisect  bad f44d122840dcb65105d784d2bde6f3ea29588f54  # 12:55  B      7     4    7   7  Merge 'linux-review/Shunyong-Yang/cpufreq-cppc_cpufreq-Initialize-shared-cpu-s-perf-capabilities/20180406-224043' into devel-spot-201804071023
git bisect  bad 4e1b7be1b0023ad979db8b5501ed7bd86f4cadfd  # 13:06  B     16     8   12  12  Merge 'clk/clk-cs2000' into devel-spot-201804071023
git bisect  bad 48f1ab6df1157717c49bbe25d7adfc6707734aef  # 13:15  B      6     2    3   3  Merge 'dsahern-linux/ipv6/fib6-change-v1' into devel-spot-201804071023
git bisect good 35297724e08325a26a23c58e6f7ee8f738cd2e60  # 13:32  G     29     0    0   0  Merge 'cel/nfs-rdma-for-4.18' into devel-spot-201804071023
git bisect good 68a5771f0873bf072d9c3b53a60a941bcb0f23fa  # 13:43  G     29     0    0   0  Merge 'linux-review/Lee-Duncan/target-prefer-dbroot-of-etc-target-over-var-target/20180407-081606' into devel-spot-201804071023
git bisect good 14cd48e7077a97a7f5d413b235f99d76fe3f7822  # 13:51  G     27     0    1   1  Merge 'linux-review/Takashi-Iwai/ALSA-pcm-Yet-finer-pending-signal-check-in-OSS-read-write-loop/20180407-060704' into devel-spot-201804071023
git bisect  bad 0757f805e61b6154fa6ba1398495b7fdf87a708d  # 14:04  B      7     4    7   7  Merge 'ipmi/master-ipmi-rebase' into devel-spot-201804071023
git bisect good bb2407a7219760926760f0448fddf00d625e5aec  # 14:18  G     29     0    2   2  Merge tag 'docs-4.17' of git://git.lwn.net/linux
git bisect  bad 845adfe40c2a75e67ddae6639fc2b987338b7983  # 14:32  B     12     3    7   7  bnxt_en: Improve valid bit checking in firmware response message.
git bisect good da75e3b6a0292fc926f4773f58c5ff6b8db5a179  # 15:12  G     31     0    0   0  ibmvnic: Account for VLAN tag in L2 Header descriptor
git bisect good 07e1671cfca54edf3f0c0915ef8754013b02dfbb  # 15:23  G     31     0    1   1  nfp: flower: refactor shared ip header in match offload
git bisect good e15f20ea33b8e5074145abe464b4b48acea505d9  # 15:34  G     31     0    0   0  Merge tag 'mac80211-next-for-davem-2018-03-29' of git://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next
git bisect good b9a12601541eb55d07e00261a5112a4bc36fe7be  # 15:49  G     31     0    0   0  Merge branch 'Close-race-between-un-register_netdevice_notifier-and-pernet_operations'
git bisect  bad f82eb88b0fa6943f58760fd7c3d1b12c1f9cf492  # 15:59  B      2     5    2   2  rxrpc: Fix a bit of time confusion
git bisect good 5adc1668ddc42bb44fd6d006cacad74ed0cbf49d  # 16:10  G     31     0    1   1  netfilter: ebtables: add support for matching ICMP type and code
git bisect good d162190bded8b3f635d1ba1e27e63d1b4a720ba8  # 16:19  G     31     0    0   0  Merge git://git.kernel.org/pub/scm/linux/kernel/git/pablo/nf-next
git bisect good 9b85756341c53fd13b4b5e25104c22849274cd0d  # 16:27  G     31     0    2   2  dt-bindings: net: renesas-ravb: Add support for r8a77470 SoC
git bisect good 6f14f49ce5eb00f533133df06c663fbaea13cd50  # 16:38  G     31     0    0   0  Merge branch 'ieee802154-for-davem-2018-03-29' of git://git.kernel.org/pub/scm/linux/kernel/git/sschmidt/wpan-next
git bisect good c0b6edef0bf0e33c12eaf80c676ff09def011518  # 16:49  G     31     0    1   1  tc-testing: Add newline when writing test case files
git bisect  bad ace45bec6d77bc061c3c3d8ad99e298ea9800c2b  # 17:04  B     16     4   12  12  rxrpc: Fix firewall route keepalive
# first bad commit: [ace45bec6d77bc061c3c3d8ad99e298ea9800c2b] rxrpc: Fix firewall route keepalive
git bisect good c0b6edef0bf0e33c12eaf80c676ff09def011518  # 17:17  G    115     0    2   3  tc-testing: Add newline when writing test case files
# extra tests with debug options
git bisect  bad ace45bec6d77bc061c3c3d8ad99e298ea9800c2b  # 17:30  B     19    11   13  13  rxrpc: Fix firewall route keepalive
# extra tests on HEAD of linux-devel/devel-spot-201804071023
git bisect  bad cd5cce67ff06509cd3821499dec6879315f7169d  # 17:30  B      5     3    0   4  0day head guard for 'devel-spot-201804071023'
# extra tests on tree/branch linus/master
git bisect  bad f605ba97fb80522656c7dce9825a908f1e765b57  # 17:40  B      4     4    2   2  Merge tag 'vfio-v4.17-rc1' of git://github.com/awilliam/linux-vfio
# extra tests with first bad commit reverted
git bisect good 44bb2df83a4e33282821b1bb4a83760f3b345ca5  # 17:50  G     38     0    1   1  Revert "rxrpc: Fix firewall route keepalive"
# extra tests on tree/branch linux-next/master
git bisect  bad 5e1dacccbb87780856219e29122f1eccec912ebb  # 18:06  B     11     3    9   9  Add linux-next specific files for 20180406

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/lkp                          Intel Corporation

--=_5ac89839.QuAuK65/3XH6H+9kiCOlXwpsf6ZS5K1sJIOckn+W24XajxOY
Content-Type: application/gzip
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg-yocto-ivb41-130:20180407170420:i386-randconfig-x0-04071139:4.16.0-rc6-02064-gace45be:1.gz"

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

--=_5ac89839.QuAuK65/3XH6H+9kiCOlXwpsf6ZS5K1sJIOckn+W24XajxOY
Content-Type: application/gzip
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg-yocto-ivb41-29:20180407171342:i386-randconfig-x0-04071139:4.16.0-rc6-02063-gc0b6ede:1.gz"

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

--=_5ac89839.QuAuK65/3XH6H+9kiCOlXwpsf6ZS5K1sJIOckn+W24XajxOY
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="reproduce-yocto-ivb41-130:20180407170420:i386-randconfig-x0-04071139:4.16.0-rc6-02064-gace45be:1"

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

--=_5ac89839.QuAuK65/3XH6H+9kiCOlXwpsf6ZS5K1sJIOckn+W24XajxOY
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="config-4.16.0-rc6-02064-gace45be"

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
# CONFIG_POSIX_MQUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
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
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
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
CONFIG_IRQ_TIME_ACCOUNTING=y
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
# CONFIG_CPU_ISOLATION is not set

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
# CONFIG_MEMCG is not set
# CONFIG_BLK_CGROUP is not set
# CONFIG_CGROUP_SCHED is not set
# CONFIG_CGROUP_PIDS is not set
# CONFIG_CGROUP_RDMA is not set
# CONFIG_CGROUP_FREEZER is not set
# CONFIG_CGROUP_HUGETLB is not set
# CONFIG_CPUSETS is not set
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
# CONFIG_CGROUP_BPF is not set
# CONFIG_CGROUP_DEBUG is not set
# CONFIG_SOCK_CGROUP_DATA is not set
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
CONFIG_RD_LZO=y
# CONFIG_RD_LZ4 is not set
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
CONFIG_SYSCTL_SYSCALL=y
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
# CONFIG_VM_EVENT_COUNTERS is not set
CONFIG_COMPAT_BRK=y
CONFIG_SLAB=y
# CONFIG_SLUB is not set
# CONFIG_SLOB is not set
# CONFIG_SLAB_MERGE_DEFAULT is not set
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SYSTEM_DATA_VERIFICATION is not set
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_OPROFILE=y
# CONFIG_OPROFILE_EVENT_MULTIPLEX is not set
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
# CONFIG_JUMP_LABEL is not set
CONFIG_UPROBES=y
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
CONFIG_CC_STACKPROTECTOR_REGULAR=y
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
CONFIG_BASE_SMALL=0
# CONFIG_MODULES is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
# CONFIG_LBDAF is not set
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_CMDLINE_PARSER=y
# CONFIG_BLK_WBT is not set
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_SED_OPAL=y

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
CONFIG_AIX_PARTITION=y
# CONFIG_OSF_PARTITION is not set
CONFIG_AMIGA_PARTITION=y
CONFIG_ATARI_PARTITION=y
# CONFIG_MAC_PARTITION is not set
# CONFIG_MSDOS_PARTITION is not set
CONFIG_LDM_PARTITION=y
CONFIG_LDM_DEBUG=y
CONFIG_SGI_PARTITION=y
CONFIG_ULTRIX_PARTITION=y
CONFIG_SUN_PARTITION=y
# CONFIG_KARMA_PARTITION is not set
# CONFIG_EFI_PARTITION is not set
CONFIG_SYSV68_PARTITION=y
CONFIG_CMDLINE_PARTITION=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_MQ_RDMA=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_DEFAULT_DEADLINE=y
# CONFIG_DEFAULT_CFQ is not set
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="deadline"
# CONFIG_MQ_IOSCHED_DEADLINE is not set
# CONFIG_MQ_IOSCHED_KYBER is not set
CONFIG_IOSCHED_BFQ=y
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
# CONFIG_X86_MPPARSE is not set
CONFIG_GOLDFISH=y
# CONFIG_RETPOLINE is not set
CONFIG_INTEL_RDT=y
CONFIG_X86_BIGSMP=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
# CONFIG_X86_INTEL_QUARK is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
# CONFIG_IOSF_MBI is not set
# CONFIG_X86_RDC321X is not set
CONFIG_X86_32_NON_STANDARD=y
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_STA2X11 is not set
# CONFIG_X86_32_IRIS is not set
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
CONFIG_PARAVIRT_DEBUG=y
# CONFIG_PARAVIRT_SPINLOCKS is not set
CONFIG_KVM_GUEST=y
CONFIG_KVM_DEBUG_FS=y
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
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MELAN is not set
CONFIG_MGEODEGX1=y
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_MVIAC7 is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_X86_GENERIC=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
# CONFIG_X86_PPRO_FENCE is not set
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_MINIMUM_CPU_FAMILY=5
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
CONFIG_NR_CPUS_RANGE_BEGIN=2
CONFIG_NR_CPUS_RANGE_END=64
CONFIG_NR_CPUS_DEFAULT=32
CONFIG_NR_CPUS=32
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
CONFIG_X86_MCE=y
# CONFIG_X86_MCELOG_LEGACY is not set
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
# CONFIG_X86_ANCIENT_MCE is not set
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=y
CONFIG_X86_THERMAL_VECTOR=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
CONFIG_PERF_EVENTS_AMD_POWER=y
# CONFIG_X86_LEGACY_VM86 is not set
# CONFIG_VM86 is not set
# CONFIG_X86_16BIT is not set
CONFIG_TOSHIBA=y
CONFIG_I8K=y
CONFIG_X86_REBOOTFIXUPS=y
CONFIG_MICROCODE=y
# CONFIG_MICROCODE_INTEL is not set
# CONFIG_MICROCODE_AMD is not set
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
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
CONFIG_MEMORY_ISOLATION=y
# CONFIG_HAVE_BOOTMEM_INFO_NODE is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
# CONFIG_PHYS_ADDR_T_64BIT is not set
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_MEMORY_FAILURE is not set
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
# CONFIG_ARCH_WANTS_THP_SWAP is not set
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
CONFIG_CLEANCACHE=y
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
CONFIG_CMA_DEBUG=y
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=7
CONFIG_ZSWAP=y
CONFIG_ZPOOL=y
# CONFIG_ZBUD is not set
CONFIG_Z3FOLD=y
# CONFIG_ZSMALLOC is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_IDLE_PAGE_TRACKING=y
# CONFIG_PERCPU_STATS is not set
CONFIG_GUP_BENCHMARK=y
CONFIG_HIGHPTE=y
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=y
CONFIG_X86_RESERVE_LOW=64
# CONFIG_MATH_EMULATION is not set
# CONFIG_MTRR is not set
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_INTEL_UMIP=y
# CONFIG_EFI is not set
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
# CONFIG_SCHED_HRTICK is not set
CONFIG_KEXEC=y
# CONFIG_CRASH_DUMP is not set
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_HOTPLUG_CPU=y
# CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
CONFIG_DEBUG_HOTPLUG_CPU0=y
# CONFIG_COMPAT_VDSO is not set
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
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
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
CONFIG_ACPI_HOTPLUG_CPU=y
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
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
# CONFIG_ACPI_EXTLOG is not set
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y
# CONFIG_APM is not set

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
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
# CONFIG_CPU_FREQ_GOV_SCHEDUTIL is not set

#
# CPU frequency scaling drivers
#
# CONFIG_CPUFREQ_DT is not set
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_ACPI_CPUFREQ is not set
# CONFIG_X86_POWERNOW_K6 is not set
# CONFIG_X86_POWERNOW_K7 is not set
# CONFIG_X86_GX_SUSPMOD is not set
CONFIG_X86_SPEEDSTEP_CENTRINO=y
CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE=y
CONFIG_X86_SPEEDSTEP_ICH=y
CONFIG_X86_SPEEDSTEP_SMI=y
# CONFIG_X86_P4_CLOCKMOD is not set
CONFIG_X86_CPUFREQ_NFORCE2=y
CONFIG_X86_LONGRUN=y
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
CONFIG_PCIE_CADENCE=y
# CONFIG_PCIE_CADENCE_HOST is not set
CONFIG_PCIE_CADENCE_EP=y

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
# CONFIG_PCI_ENDPOINT_CONFIGFS is not set
CONFIG_PCI_EPF_TEST=y

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
CONFIG_ISA=y
CONFIG_EISA=y
CONFIG_EISA_VLB_PRIMING=y
CONFIG_EISA_PCI_EISA=y
# CONFIG_EISA_VIRTUAL_ROOT is not set
# CONFIG_EISA_NAMES is not set
# CONFIG_SCx200 is not set
# CONFIG_OLPC is not set
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
CONFIG_BINFMT_AOUT=y
# CONFIG_BINFMT_MISC is not set
CONFIG_COREDUMP=y
CONFIG_COMPAT_32=y
CONFIG_HAVE_ATOMIC_IOMAP=y
CONFIG_NET=y
CONFIG_NET_INGRESS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=y
CONFIG_UNIX=y
# CONFIG_UNIX_DIAG is not set
CONFIG_TLS=y
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_SUB_POLICY is not set
CONFIG_XFRM_MIGRATE=y
# CONFIG_XFRM_STATISTICS is not set
CONFIG_NET_KEY=y
CONFIG_NET_KEY_MIGRATE=y
CONFIG_SMC=y
CONFIG_SMC_DIAG=y
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
CONFIG_IP_ADVANCED_ROUTER=y
# CONFIG_IP_FIB_TRIE_STATS is not set
CONFIG_IP_MULTIPLE_TABLES=y
# CONFIG_IP_ROUTE_MULTIPATH is not set
# CONFIG_IP_ROUTE_VERBOSE is not set
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
CONFIG_NET_IPGRE_DEMUX=y
CONFIG_NET_IP_TUNNEL=y
# CONFIG_NET_IPGRE is not set
CONFIG_IP_MROUTE_COMMON=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=y
CONFIG_NET_UDP_TUNNEL=y
CONFIG_NET_FOU=y
CONFIG_INET_AH=y
CONFIG_INET_ESP=y
CONFIG_INET_ESP_OFFLOAD=y
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_XFRM_TUNNEL is not set
CONFIG_INET_TUNNEL=y
CONFIG_INET_XFRM_MODE_TRANSPORT=y
CONFIG_INET_XFRM_MODE_TUNNEL=y
CONFIG_INET_XFRM_MODE_BEET=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_INET_UDP_DIAG is not set
CONFIG_INET_RAW_DIAG=y
# CONFIG_INET_DIAG_DESTROY is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
# CONFIG_IPV6_ROUTER_PREF is not set
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=y
CONFIG_INET6_ESP=y
# CONFIG_INET6_ESP_OFFLOAD is not set
# CONFIG_INET6_IPCOMP is not set
CONFIG_IPV6_MIP6=y
CONFIG_IPV6_ILA=y
# CONFIG_INET6_XFRM_TUNNEL is not set
CONFIG_INET6_TUNNEL=y
# CONFIG_INET6_XFRM_MODE_TRANSPORT is not set
CONFIG_INET6_XFRM_MODE_TUNNEL=y
# CONFIG_INET6_XFRM_MODE_BEET is not set
CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION=y
CONFIG_IPV6_VTI=y
# CONFIG_IPV6_SIT is not set
CONFIG_IPV6_TUNNEL=y
CONFIG_IPV6_GRE=y
CONFIG_IPV6_FOU=y
# CONFIG_IPV6_FOU_TUNNEL is not set
# CONFIG_IPV6_MULTIPLE_TABLES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
# CONFIG_IPV6_PIMSM_V2 is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
CONFIG_IPV6_SEG6_HMAC=y
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_ADVANCED is not set

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_NETLINK=y
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_NETLINK_LOG=y
# CONFIG_NF_CONNTRACK is not set
CONFIG_NF_LOG_COMMON=y
CONFIG_NF_LOG_NETDEV=y
# CONFIG_NF_TABLES is not set
CONFIG_NETFILTER_XTABLES=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=y

#
# Xtables targets
#
# CONFIG_NETFILTER_XT_TARGET_LOG is not set
CONFIG_NETFILTER_XT_TARGET_NFLOG=y
# CONFIG_NETFILTER_XT_TARGET_SECMARK is not set
# CONFIG_NETFILTER_XT_TARGET_TCPMSS is not set

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=y
# CONFIG_NETFILTER_XT_MATCH_POLICY is not set
CONFIG_IP_SET=y
CONFIG_IP_SET_MAX=256
# CONFIG_IP_SET_BITMAP_IP is not set
# CONFIG_IP_SET_BITMAP_IPMAC is not set
CONFIG_IP_SET_BITMAP_PORT=y
# CONFIG_IP_SET_HASH_IP is not set
# CONFIG_IP_SET_HASH_IPMARK is not set
CONFIG_IP_SET_HASH_IPPORT=y
# CONFIG_IP_SET_HASH_IPPORTIP is not set
# CONFIG_IP_SET_HASH_IPPORTNET is not set
CONFIG_IP_SET_HASH_IPMAC=y
CONFIG_IP_SET_HASH_MAC=y
CONFIG_IP_SET_HASH_NETPORTNET=y
CONFIG_IP_SET_HASH_NET=y
CONFIG_IP_SET_HASH_NETNET=y
CONFIG_IP_SET_HASH_NETPORT=y
# CONFIG_IP_SET_HASH_NETIFACE is not set
# CONFIG_IP_SET_LIST_SET is not set
# CONFIG_IP_VS is not set

#
# IP: Netfilter Configuration
#
# CONFIG_NF_DEFRAG_IPV4 is not set
# CONFIG_NF_SOCKET_IPV4 is not set
CONFIG_NF_DUP_IPV4=y
CONFIG_NF_LOG_ARP=y
# CONFIG_NF_LOG_IPV4 is not set
CONFIG_NF_REJECT_IPV4=y
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_FILTER=y
# CONFIG_IP_NF_TARGET_REJECT is not set
CONFIG_IP_NF_MANGLE=y
# CONFIG_IP_NF_RAW is not set

#
# IPv6: Netfilter Configuration
#
# CONFIG_NF_DEFRAG_IPV6 is not set
CONFIG_NF_SOCKET_IPV6=y
# CONFIG_NF_DUP_IPV6 is not set
CONFIG_NF_REJECT_IPV6=y
CONFIG_NF_LOG_IPV6=y
CONFIG_IP6_NF_IPTABLES=y
CONFIG_IP6_NF_MATCH_IPV6HEADER=y
# CONFIG_IP6_NF_FILTER is not set
CONFIG_IP6_NF_MANGLE=y
# CONFIG_IP6_NF_RAW is not set
CONFIG_BRIDGE_NF_EBTABLES=y
CONFIG_BRIDGE_EBT_BROUTE=y
CONFIG_BRIDGE_EBT_T_FILTER=y
CONFIG_BRIDGE_EBT_T_NAT=y
CONFIG_BRIDGE_EBT_802_3=y
# CONFIG_BRIDGE_EBT_AMONG is not set
CONFIG_BRIDGE_EBT_ARP=y
# CONFIG_BRIDGE_EBT_IP is not set
CONFIG_BRIDGE_EBT_IP6=y
# CONFIG_BRIDGE_EBT_LIMIT is not set
CONFIG_BRIDGE_EBT_MARK=y
# CONFIG_BRIDGE_EBT_PKTTYPE is not set
# CONFIG_BRIDGE_EBT_STP is not set
CONFIG_BRIDGE_EBT_VLAN=y
CONFIG_BRIDGE_EBT_ARPREPLY=y
# CONFIG_BRIDGE_EBT_DNAT is not set
# CONFIG_BRIDGE_EBT_MARK_T is not set
CONFIG_BRIDGE_EBT_REDIRECT=y
# CONFIG_BRIDGE_EBT_SNAT is not set
CONFIG_BRIDGE_EBT_LOG=y
CONFIG_BRIDGE_EBT_NFLOG=y
CONFIG_IP_DCCP=y
CONFIG_INET_DCCP_DIAG=y

#
# DCCP CCIDs Configuration
#
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
CONFIG_IP_DCCP_CCID3=y
CONFIG_IP_DCCP_CCID3_DEBUG=y
CONFIG_IP_DCCP_TFRC_LIB=y
CONFIG_IP_DCCP_TFRC_DEBUG=y

#
# DCCP Kernel Hacking
#
CONFIG_IP_DCCP_DEBUG=y
CONFIG_IP_SCTP=y
CONFIG_SCTP_DBG_OBJCNT=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE=y
# CONFIG_SCTP_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=y
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
CONFIG_ATM=y
# CONFIG_ATM_CLIP is not set
# CONFIG_ATM_LANE is not set
# CONFIG_ATM_BR2684 is not set
CONFIG_L2TP=y
CONFIG_L2TP_DEBUGFS=y
# CONFIG_L2TP_V3 is not set
CONFIG_STP=y
CONFIG_BRIDGE=y
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
CONFIG_DECNET=y
CONFIG_DECNET_ROUTER=y
CONFIG_LLC=y
CONFIG_LLC2=y
CONFIG_ATALK=y
CONFIG_DEV_APPLETALK=y
# CONFIG_LTPC is not set
# CONFIG_COPS is not set
CONFIG_IPDDP=y
# CONFIG_IPDDP_ENCAP is not set
CONFIG_X25=y
CONFIG_LAPB=y
# CONFIG_PHONET is not set
CONFIG_6LOWPAN=y
# CONFIG_6LOWPAN_DEBUGFS is not set
CONFIG_6LOWPAN_NHC=y
CONFIG_6LOWPAN_NHC_DEST=y
# CONFIG_6LOWPAN_NHC_FRAGMENT is not set
CONFIG_6LOWPAN_NHC_HOP=y
CONFIG_6LOWPAN_NHC_IPV6=y
# CONFIG_6LOWPAN_NHC_MOBILITY is not set
CONFIG_6LOWPAN_NHC_ROUTING=y
CONFIG_6LOWPAN_NHC_UDP=y
CONFIG_6LOWPAN_GHC_EXT_HDR_HOP=y
# CONFIG_6LOWPAN_GHC_UDP is not set
CONFIG_6LOWPAN_GHC_ICMPV6=y
CONFIG_6LOWPAN_GHC_EXT_HDR_DEST=y
# CONFIG_6LOWPAN_GHC_EXT_HDR_FRAG is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_ROUTE is not set
CONFIG_IEEE802154=y
CONFIG_IEEE802154_NL802154_EXPERIMENTAL=y
CONFIG_IEEE802154_SOCKET=y
# CONFIG_IEEE802154_6LOWPAN is not set
CONFIG_MAC802154=y
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=y
# CONFIG_NET_SCH_HTB is not set
CONFIG_NET_SCH_HFSC=y
CONFIG_NET_SCH_ATM=y
CONFIG_NET_SCH_PRIO=y
CONFIG_NET_SCH_MULTIQ=y
# CONFIG_NET_SCH_RED is not set
CONFIG_NET_SCH_SFB=y
# CONFIG_NET_SCH_SFQ is not set
CONFIG_NET_SCH_TEQL=y
CONFIG_NET_SCH_TBF=y
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_GRED is not set
CONFIG_NET_SCH_DSMARK=y
CONFIG_NET_SCH_NETEM=y
# CONFIG_NET_SCH_DRR is not set
# CONFIG_NET_SCH_MQPRIO is not set
CONFIG_NET_SCH_CHOKE=y
CONFIG_NET_SCH_QFQ=y
# CONFIG_NET_SCH_CODEL is not set
# CONFIG_NET_SCH_FQ_CODEL is not set
# CONFIG_NET_SCH_FQ is not set
CONFIG_NET_SCH_HHF=y
CONFIG_NET_SCH_PIE=y
# CONFIG_NET_SCH_INGRESS is not set
# CONFIG_NET_SCH_PLUG is not set
CONFIG_NET_SCH_DEFAULT=y
CONFIG_DEFAULT_PFIFO_FAST=y
CONFIG_DEFAULT_NET_SCH="pfifo_fast"

#
# Classification
#
CONFIG_NET_CLS=y
# CONFIG_NET_CLS_BASIC is not set
CONFIG_NET_CLS_TCINDEX=y
CONFIG_NET_CLS_ROUTE4=y
# CONFIG_NET_CLS_FW is not set
CONFIG_NET_CLS_U32=y
CONFIG_CLS_U32_PERF=y
# CONFIG_CLS_U32_MARK is not set
# CONFIG_NET_CLS_RSVP is not set
CONFIG_NET_CLS_RSVP6=y
CONFIG_NET_CLS_FLOW=y
# CONFIG_NET_CLS_CGROUP is not set
CONFIG_NET_CLS_BPF=y
CONFIG_NET_CLS_FLOWER=y
CONFIG_NET_CLS_MATCHALL=y
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
# CONFIG_NET_EMATCH_CMP is not set
CONFIG_NET_EMATCH_NBYTE=y
# CONFIG_NET_EMATCH_U32 is not set
# CONFIG_NET_EMATCH_META is not set
# CONFIG_NET_EMATCH_TEXT is not set
CONFIG_NET_EMATCH_CANID=y
CONFIG_NET_EMATCH_IPSET=y
# CONFIG_NET_EMATCH_IPT is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=y
CONFIG_NET_ACT_GACT=y
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=y
CONFIG_NET_ACT_SAMPLE=y
CONFIG_NET_ACT_IPT=y
CONFIG_NET_ACT_NAT=y
# CONFIG_NET_ACT_PEDIT is not set
# CONFIG_NET_ACT_SIMP is not set
CONFIG_NET_ACT_SKBEDIT=y
# CONFIG_NET_ACT_CSUM is not set
CONFIG_NET_ACT_VLAN=y
CONFIG_NET_ACT_BPF=y
CONFIG_NET_ACT_SKBMOD=y
CONFIG_NET_ACT_IFE=y
CONFIG_NET_ACT_TUNNEL_KEY=y
CONFIG_NET_IFE_SKBMARK=y
# CONFIG_NET_IFE_SKBPRIO is not set
CONFIG_NET_IFE_SKBTCINDEX=y
CONFIG_NET_CLS_IND=y
CONFIG_NET_SCH_FIFO=y
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=y
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
CONFIG_VSOCKETS=y
CONFIG_VSOCKETS_DIAG=y
CONFIG_VIRTIO_VSOCKETS=y
CONFIG_VIRTIO_VSOCKETS_COMMON=y
# CONFIG_NETLINK_DIAG is not set
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
# CONFIG_MPLS_ROUTING is not set
CONFIG_NET_NSH=y
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
CONFIG_NET_L3_MASTER_DEV=y
CONFIG_NET_NCSI=y
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=y
CONFIG_NET_DROP_MONITOR=y
# CONFIG_HAMRADIO is not set
CONFIG_CAN=y
CONFIG_CAN_RAW=y
CONFIG_CAN_BCM=y
CONFIG_CAN_GW=y

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=y
CONFIG_CAN_VXCAN=y
# CONFIG_CAN_SLCAN is not set
CONFIG_CAN_DEV=y
# CONFIG_CAN_CALC_BITTIMING is not set
CONFIG_CAN_LEDS=y
CONFIG_CAN_GRCAN=y
# CONFIG_PCH_CAN is not set
CONFIG_CAN_C_CAN=y
CONFIG_CAN_C_CAN_PLATFORM=y
# CONFIG_CAN_C_CAN_PCI is not set
# CONFIG_CAN_CC770 is not set
CONFIG_CAN_IFI_CANFD=y
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
CONFIG_CAN_SJA1000=y
CONFIG_CAN_SJA1000_ISA=y
# CONFIG_CAN_SJA1000_PLATFORM is not set
# CONFIG_CAN_EMS_PCI is not set
# CONFIG_CAN_PEAK_PCI is not set
# CONFIG_CAN_KVASER_PCI is not set
# CONFIG_CAN_PLX_PCI is not set
CONFIG_CAN_TSCAN1=y
CONFIG_CAN_SOFTING=y
# CONFIG_CAN_DEBUG_DEVICES is not set
CONFIG_BT=y
# CONFIG_BT_BREDR is not set
CONFIG_BT_LE=y
CONFIG_BT_6LOWPAN=y
# CONFIG_BT_LEDS is not set
# CONFIG_BT_SELFTEST is not set
# CONFIG_BT_DEBUGFS is not set

#
# Bluetooth device drivers
#
# CONFIG_BT_HCIBTSDIO is not set
# CONFIG_BT_HCIUART is not set
CONFIG_BT_HCIVHCI=y
CONFIG_BT_MRVL=y
CONFIG_BT_MRVL_SDIO=y
CONFIG_AF_RXRPC=y
CONFIG_AF_RXRPC_IPV6=y
CONFIG_AF_RXRPC_INJECT_LOSS=y
# CONFIG_AF_RXRPC_DEBUG is not set
# CONFIG_RXKAD is not set
CONFIG_AF_KCM=y
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set
# CONFIG_LIB80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
CONFIG_RFKILL=y
CONFIG_RFKILL_LEDS=y
# CONFIG_RFKILL_INPUT is not set
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
CONFIG_NET_9P_RDMA=y
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
CONFIG_NFC=y
CONFIG_NFC_DIGITAL=y
# CONFIG_NFC_NCI is not set
CONFIG_NFC_HCI=y
CONFIG_NFC_SHDLC=y

#
# Near Field Communication (NFC) devices
#
# CONFIG_NFC_SIM is not set
CONFIG_NFC_PN544=y
CONFIG_NFC_PN544_I2C=y
CONFIG_NFC_PN533=y
CONFIG_NFC_PN533_I2C=y
CONFIG_NFC_MICROREAD=y
CONFIG_NFC_MICROREAD_I2C=y
# CONFIG_NFC_ST21NFCA_I2C is not set
CONFIG_PSAMPLE=y
CONFIG_NET_IFE=y
CONFIG_LWTUNNEL=y
# CONFIG_LWTUNNEL_BPF is not set
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
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_STANDALONE=y
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
# CONFIG_SYS_HYPERVISOR is not set
# CONFIG_GENERIC_CPU_DEVICES is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPMI=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# CONFIG_DMA_CMA is not set

#
# Bus devices
#
CONFIG_SIMPLE_PM_BUS=y
CONFIG_CONNECTOR=y
# CONFIG_PROC_EVENTS is not set
CONFIG_MTD=y
CONFIG_MTD_REDBOOT_PARTS=y
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
# CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
CONFIG_MTD_REDBOOT_PARTS_READONLY=y
# CONFIG_MTD_CMDLINE_PARTS is not set
CONFIG_MTD_OF_PARTS=y
# CONFIG_MTD_AR7_PARTS is not set

#
# Partition parsers
#

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=y
# CONFIG_MTD_BLOCK is not set
# CONFIG_MTD_BLOCK_RO is not set
CONFIG_FTL=y
# CONFIG_NFTL is not set
CONFIG_INFTL=y
CONFIG_RFD_FTL=y
CONFIG_SSFDC=y
CONFIG_SM_FTL=y
CONFIG_MTD_OOPS=y
# CONFIG_MTD_SWAP is not set
CONFIG_MTD_PARTITIONED_MASTER=y

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
CONFIG_MTD_JEDECPROBE=y
CONFIG_MTD_GEN_PROBE=y
CONFIG_MTD_CFI_ADV_OPTIONS=y
# CONFIG_MTD_CFI_NOSWAP is not set
CONFIG_MTD_CFI_BE_BYTE_SWAP=y
# CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
CONFIG_MTD_CFI_GEOMETRY=y
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
CONFIG_MTD_MAP_BANK_WIDTH_16=y
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
CONFIG_MTD_CFI_I1=y
# CONFIG_MTD_CFI_I2 is not set
# CONFIG_MTD_CFI_I4 is not set
CONFIG_MTD_CFI_I8=y
CONFIG_MTD_OTP=y
CONFIG_MTD_CFI_INTELEXT=y
# CONFIG_MTD_CFI_AMDSTD is not set
CONFIG_MTD_CFI_STAA=y
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=y
CONFIG_MTD_ROM=y
CONFIG_MTD_ABSENT=y

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
CONFIG_MTD_PHYSMAP=y
CONFIG_MTD_PHYSMAP_COMPAT=y
CONFIG_MTD_PHYSMAP_START=0x8000000
CONFIG_MTD_PHYSMAP_LEN=0
CONFIG_MTD_PHYSMAP_BANKWIDTH=2
CONFIG_MTD_PHYSMAP_OF=y
CONFIG_MTD_PHYSMAP_OF_VERSATILE=y
CONFIG_MTD_PHYSMAP_OF_GEMINI=y
# CONFIG_MTD_SBC_GXX is not set
# CONFIG_MTD_AMD76XROM is not set
CONFIG_MTD_ICHXROM=y
# CONFIG_MTD_ESB2ROM is not set
# CONFIG_MTD_CK804XROM is not set
# CONFIG_MTD_SCB2_FLASH is not set
# CONFIG_MTD_NETtel is not set
# CONFIG_MTD_L440GX is not set
# CONFIG_MTD_PCI is not set
CONFIG_MTD_GPIO_ADDR=y
# CONFIG_MTD_INTEL_VR_NOR is not set
CONFIG_MTD_PLATRAM=y
CONFIG_MTD_LATCH_ADDR=y

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
CONFIG_MTD_SLRAM=y
# CONFIG_MTD_PHRAM is not set
CONFIG_MTD_MTDRAM=y
CONFIG_MTDRAM_TOTAL_SIZE=4096
CONFIG_MTDRAM_ERASE_SIZE=128
CONFIG_MTD_BLOCK2MTD=y

#
# Disk-On-Chip Device Drivers
#
CONFIG_MTD_DOCG3=y
CONFIG_BCH_CONST_M=14
CONFIG_BCH_CONST_T=4
CONFIG_MTD_NAND_ECC=y
CONFIG_MTD_NAND_ECC_SMC=y
CONFIG_MTD_NAND=y
# CONFIG_MTD_NAND_ECC_BCH is not set
# CONFIG_MTD_SM_COMMON is not set
# CONFIG_MTD_NAND_DENALI_PCI is not set
# CONFIG_MTD_NAND_DENALI_DT is not set
# CONFIG_MTD_NAND_GPIO is not set
# CONFIG_MTD_NAND_OMAP_BCH_BUILD is not set
# CONFIG_MTD_NAND_RICOH is not set
CONFIG_MTD_NAND_DISKONCHIP=y
CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED=y
CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=0
# CONFIG_MTD_NAND_DISKONCHIP_PROBE_HIGH is not set
# CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE is not set
CONFIG_MTD_NAND_DOCG4=y
# CONFIG_MTD_NAND_CAFE is not set
CONFIG_MTD_NAND_CS553X=y
CONFIG_MTD_NAND_NANDSIM=y
# CONFIG_MTD_NAND_PLATFORM is not set
# CONFIG_MTD_ONENAND is not set

#
# LPDDR & LPDDR2 PCM memory drivers
#
# CONFIG_MTD_LPDDR is not set
CONFIG_MTD_SPI_NOR=y
# CONFIG_MTD_MT81xx_NOR is not set
CONFIG_MTD_SPI_NOR_USE_4K_SECTORS=y
CONFIG_SPI_INTEL_SPI=y
# CONFIG_SPI_INTEL_SPI_PCI is not set
CONFIG_SPI_INTEL_SPI_PLATFORM=y
CONFIG_MTD_UBI=y
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
CONFIG_MTD_UBI_FASTMAP=y
# CONFIG_MTD_UBI_GLUEBI is not set
CONFIG_MTD_UBI_BLOCK=y
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
CONFIG_OF_KOBJ=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_NET=y
CONFIG_OF_RESOLVE=y
CONFIG_OF_OVERLAY=y
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
# CONFIG_PARPORT_PC is not set
# CONFIG_PARPORT_GSC is not set
CONFIG_PARPORT_AX88796=y
# CONFIG_PARPORT_1284 is not set
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
# CONFIG_ISAPNP is not set
# CONFIG_PNPBIOS is not set
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_BLK_DEV_FD is not set
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
# CONFIG_BLK_DEV_NVME is not set
# CONFIG_NVME_MULTIPATH is not set
CONFIG_NVME_FABRICS=y
CONFIG_NVME_RDMA=y
# CONFIG_NVME_FC is not set
CONFIG_NVME_TARGET=y
CONFIG_NVME_TARGET_LOOP=y
CONFIG_NVME_TARGET_RDMA=y
# CONFIG_NVME_TARGET_FC is not set

#
# Misc devices
#
# CONFIG_SENSORS_LIS3LV02D is not set
CONFIG_AD525X_DPOT=y
CONFIG_AD525X_DPOT_I2C=y
CONFIG_DUMMY_IRQ=y
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_SGI_IOC4 is not set
# CONFIG_TIFM_CORE is not set
CONFIG_ICS932S401=y
CONFIG_ENCLOSURE_SERVICES=y
# CONFIG_HP_ILO is not set
CONFIG_APDS9802ALS=y
CONFIG_ISL29003=y
CONFIG_ISL29020=y
CONFIG_SENSORS_TSL2550=y
CONFIG_SENSORS_BH1770=y
# CONFIG_SENSORS_APDS990X is not set
CONFIG_HMC6352=y
# CONFIG_DS1682 is not set
# CONFIG_PCH_PHUB is not set
CONFIG_USB_SWITCH_FSA9480=y
CONFIG_SRAM=y
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_MISC_RTSX is not set
CONFIG_C2PORT=y
CONFIG_C2PORT_DURAMAR_2150=y

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
CONFIG_EEPROM_LEGACY=y
CONFIG_EEPROM_MAX6875=y
CONFIG_EEPROM_93CX6=y
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# CONFIG_SENSORS_LIS3_I2C is not set
# CONFIG_ALTERA_STAPL is not set
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
# CONFIG_BLK_DEV_SD is not set
# CONFIG_CHR_DEV_ST is not set
CONFIG_CHR_DEV_OSST=y
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=y
CONFIG_CHR_DEV_SCH=y
CONFIG_SCSI_ENCLOSURE=y
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set
# CONFIG_SCSI_SCAN_ASYNC is not set

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
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
# CONFIG_SCSI_DH_HP_SW is not set
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
CONFIG_SCSI_OSD_INITIATOR=y
CONFIG_SCSI_OSD_ULD=y
CONFIG_SCSI_OSD_DPRINT_SENSE=1
CONFIG_SCSI_OSD_DEBUG=y
CONFIG_ATA=y
# CONFIG_ATA_NONSTANDARD is not set
# CONFIG_ATA_VERBOSE_ERROR is not set
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
# CONFIG_SATA_AHCI is not set
CONFIG_SATA_AHCI_PLATFORM=y
# CONFIG_AHCI_CEVA is not set
CONFIG_AHCI_QORIQ=y
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
# CONFIG_ATA_SFF is not set
# CONFIG_MD is not set
CONFIG_TARGET_CORE=y
CONFIG_TCM_IBLOCK=y
CONFIG_TCM_FILEIO=y
CONFIG_TCM_PSCSI=y
# CONFIG_TCM_USER2 is not set
# CONFIG_LOOPBACK_TARGET is not set
# CONFIG_ISCSI_TARGET is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
CONFIG_MACINTOSH_DRIVERS=y
# CONFIG_MAC_EMUMOUSEBTN is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_IFB is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_GTP is not set
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
CONFIG_MDIO=y
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

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
# CONFIG_WAN is not set
CONFIG_IEEE802154_DRIVERS=y
# CONFIG_IEEE802154_FAKELB is not set
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_NETDEVSIM is not set
# CONFIG_ISDN is not set
# CONFIG_NVM is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
# CONFIG_INPUT_FF_MEMLESS is not set
# CONFIG_INPUT_POLLDEV is not set
# CONFIG_INPUT_SPARSEKMAP is not set
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

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
# CONFIG_KEYBOARD_TC3589X is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_TWL4030 is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CAP11XX is not set
# CONFIG_KEYBOARD_BCM is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
# CONFIG_MOUSE_PS2_ELANTECH is not set
# CONFIG_MOUSE_PS2_SENTELIC is not set
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
# CONFIG_MOUSE_PS2_VMMOUSE is not set
CONFIG_MOUSE_PS2_SMBUS=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
# CONFIG_MOUSE_CYAPA is not set
# CONFIG_MOUSE_ELAN_I2C is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_MOUSE_GPIO is not set
# CONFIG_MOUSE_SYNAPTICS_I2C is not set
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
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
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_SERIO_ALTERA_PS2 is not set
# CONFIG_SERIO_PS2MULT is not set
# CONFIG_SERIO_ARC_PS2 is not set
# CONFIG_SERIO_APBPS2 is not set
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
CONFIG_GAMEPORT=y
CONFIG_GAMEPORT_NS558=y
CONFIG_GAMEPORT_L4=y
# CONFIG_GAMEPORT_EMU10K1 is not set
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
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=y
CONFIG_LP_CONSOLE=y
CONFIG_PPDEV=y
# CONFIG_VIRTIO_CONSOLE is not set
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_DMI_DECODE=y
# CONFIG_IPMI_PROC_INTERFACE is not set
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=y
CONFIG_IPMI_SI=y
CONFIG_IPMI_SSIF=y
CONFIG_IPMI_WATCHDOG=y
# CONFIG_IPMI_POWEROFF is not set
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=y
CONFIG_HW_RANDOM_INTEL=y
CONFIG_HW_RANDOM_AMD=y
CONFIG_HW_RANDOM_GEODE=y
# CONFIG_HW_RANDOM_VIA is not set
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_NVRAM=y
CONFIG_DTLK=y
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set
# CONFIG_MWAVE is not set
CONFIG_PC8736x_GPIO=y
CONFIG_NSC_GPIO=y
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=256
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
# CONFIG_TCG_TPM is not set
CONFIG_TELCLOCK=y
# CONFIG_DEVPORT is not set
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
CONFIG_I2C_ARB_GPIO_CHALLENGE=y
CONFIG_I2C_MUX_GPIO=y
# CONFIG_I2C_MUX_GPMUX is not set
CONFIG_I2C_MUX_LTC4306=y
# CONFIG_I2C_MUX_PCA9541 is not set
CONFIG_I2C_MUX_PCA954x=y
CONFIG_I2C_MUX_REG=y
# CONFIG_I2C_MUX_MLXCPLD is not set
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
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=y
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EG20T is not set
# CONFIG_I2C_EMEV2 is not set
CONFIG_I2C_GPIO=y
CONFIG_I2C_GPIO_FAULT_INJECTOR=y
CONFIG_I2C_KEMPLD=y
CONFIG_I2C_OCORES=y
CONFIG_I2C_PCA_PLATFORM=y
# CONFIG_I2C_PXA is not set
# CONFIG_I2C_PXA_PCI is not set
# CONFIG_I2C_RK3X is not set
CONFIG_I2C_SIMTEC=y
CONFIG_I2C_XILINX=y

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_PARPORT is not set
CONFIG_I2C_PARPORT_LIGHT=y
# CONFIG_I2C_TAOS_EVM is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_PCA_ISA=y
# CONFIG_SCx200_ACB is not set
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

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
# CONFIG_PPS_CLIENT_LDISC is not set
CONFIG_PPS_CLIENT_PARPORT=y
# CONFIG_PPS_CLIENT_GPIO is not set

#
# PPS generators support
#

#
# PTP clock support
#

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
CONFIG_PTP_1588_CLOCK_PCH=y
# CONFIG_PINCTRL is not set
CONFIG_GPIOLIB=y
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y

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
CONFIG_GPIO_GRGPIO=y
# CONFIG_GPIO_ICH is not set
# CONFIG_GPIO_LYNXPOINT is not set
# CONFIG_GPIO_MB86S7X is not set
CONFIG_GPIO_MENZ127=y
# CONFIG_GPIO_MOCKUP is not set
CONFIG_GPIO_SYSCON=y
# CONFIG_GPIO_VX855 is not set
CONFIG_GPIO_XILINX=y

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_F7188X=y
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
CONFIG_GPIO_SCH311X=y
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
CONFIG_GPIO_ADNP=y
CONFIG_GPIO_MAX7300=y
CONFIG_GPIO_MAX732X=y
CONFIG_GPIO_MAX732X_IRQ=y
CONFIG_GPIO_PCA953X=y
CONFIG_GPIO_PCA953X_IRQ=y
CONFIG_GPIO_PCF857X=y
# CONFIG_GPIO_TPIC2810 is not set

#
# MFD GPIO expanders
#
# CONFIG_GPIO_ARIZONA is not set
CONFIG_GPIO_BD9571MWV=y
CONFIG_GPIO_DA9055=y
# CONFIG_GPIO_KEMPLD is not set
CONFIG_GPIO_LP3943=y
# CONFIG_GPIO_LP87565 is not set
# CONFIG_GPIO_STMPE is not set
# CONFIG_GPIO_TC3589X is not set
# CONFIG_GPIO_TPS65086 is not set
CONFIG_GPIO_TPS65218=y
CONFIG_GPIO_TPS6586X=y
CONFIG_GPIO_TPS65912=y
CONFIG_GPIO_TWL4030=y
CONFIG_GPIO_TWL6040=y
CONFIG_GPIO_WM8350=y
# CONFIG_GPIO_WM8994 is not set

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
CONFIG_W1=y
# CONFIG_W1_CON is not set

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
CONFIG_W1_MASTER_DS2482=y
# CONFIG_W1_MASTER_DS1WM is not set
# CONFIG_W1_MASTER_GPIO is not set

#
# 1-wire Slaves
#
# CONFIG_W1_SLAVE_THERM is not set
CONFIG_W1_SLAVE_SMEM=y
CONFIG_W1_SLAVE_DS2405=y
# CONFIG_W1_SLAVE_DS2408 is not set
CONFIG_W1_SLAVE_DS2413=y
CONFIG_W1_SLAVE_DS2406=y
CONFIG_W1_SLAVE_DS2423=y
CONFIG_W1_SLAVE_DS2805=y
# CONFIG_W1_SLAVE_DS2431 is not set
CONFIG_W1_SLAVE_DS2433=y
# CONFIG_W1_SLAVE_DS2433_CRC is not set
# CONFIG_W1_SLAVE_DS2438 is not set
CONFIG_W1_SLAVE_DS2760=y
CONFIG_W1_SLAVE_DS2780=y
# CONFIG_W1_SLAVE_DS2781 is not set
CONFIG_W1_SLAVE_DS28E04=y
# CONFIG_W1_SLAVE_DS28E17 is not set
# CONFIG_POWER_AVS is not set
CONFIG_POWER_RESET=y
CONFIG_POWER_RESET_GPIO=y
# CONFIG_POWER_RESET_GPIO_RESTART is not set
# CONFIG_POWER_RESET_LTC2952 is not set
CONFIG_POWER_RESET_RESTART=y
CONFIG_POWER_RESET_SYSCON=y
CONFIG_POWER_RESET_SYSCON_POWEROFF=y
CONFIG_REBOOT_MODE=y
CONFIG_SYSCON_REBOOT_MODE=y
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_PDA_POWER is not set
# CONFIG_GENERIC_ADC_BATTERY is not set
# CONFIG_WM8350_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_BATTERY_88PM860X is not set
# CONFIG_BATTERY_DS2760 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_LEGO_EV3 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_DA9030 is not set
# CONFIG_CHARGER_DA9150 is not set
# CONFIG_BATTERY_DA9150 is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_BATTERY_MAX1721X is not set
# CONFIG_BATTERY_TWL4030_MADC is not set
# CONFIG_CHARGER_PCF50633 is not set
# CONFIG_BATTERY_RX51 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_TWL4030 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_LP8788 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_MANAGER is not set
# CONFIG_CHARGER_LTC3651 is not set
# CONFIG_CHARGER_DETECTOR_MAX14656 is not set
# CONFIG_CHARGER_MAX8998 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24190 is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_SMB347 is not set
# CONFIG_CHARGER_TPS65217 is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_BATTERY_GOLDFISH is not set
# CONFIG_BATTERY_RT5033 is not set
# CONFIG_CHARGER_RT9455 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=y
CONFIG_SENSORS_ABITUGURU3=y
CONFIG_SENSORS_AD7414=y
CONFIG_SENSORS_AD7418=y
CONFIG_SENSORS_ADM1021=y
CONFIG_SENSORS_ADM1025=y
CONFIG_SENSORS_ADM1026=y
# CONFIG_SENSORS_ADM1029 is not set
CONFIG_SENSORS_ADM1031=y
CONFIG_SENSORS_ADM9240=y
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7410=y
# CONFIG_SENSORS_ADT7411 is not set
CONFIG_SENSORS_ADT7462=y
CONFIG_SENSORS_ADT7470=y
# CONFIG_SENSORS_ADT7475 is not set
CONFIG_SENSORS_ASC7621=y
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
# CONFIG_SENSORS_FAM15H_POWER is not set
# CONFIG_SENSORS_APPLESMC is not set
CONFIG_SENSORS_ASB100=y
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=y
# CONFIG_SENSORS_DS620 is not set
CONFIG_SENSORS_DS1621=y
CONFIG_SENSORS_DELL_SMM=y
CONFIG_SENSORS_DA9055=y
# CONFIG_SENSORS_I5K_AMB is not set
# CONFIG_SENSORS_F71805F is not set
CONFIG_SENSORS_F71882FG=y
CONFIG_SENSORS_F75375S=y
CONFIG_SENSORS_MC13783_ADC=y
CONFIG_SENSORS_FSCHMD=y
# CONFIG_SENSORS_GL518SM is not set
CONFIG_SENSORS_GL520SM=y
CONFIG_SENSORS_G760A=y
CONFIG_SENSORS_G762=y
CONFIG_SENSORS_GPIO_FAN=y
CONFIG_SENSORS_HIH6130=y
CONFIG_SENSORS_IBMAEM=y
# CONFIG_SENSORS_IBMPEX is not set
CONFIG_SENSORS_IIO_HWMON=y
# CONFIG_SENSORS_I5500 is not set
# CONFIG_SENSORS_CORETEMP is not set
CONFIG_SENSORS_IT87=y
CONFIG_SENSORS_JC42=y
CONFIG_SENSORS_POWR1220=y
CONFIG_SENSORS_LINEAGE=y
CONFIG_SENSORS_LTC2945=y
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC4151 is not set
CONFIG_SENSORS_LTC4215=y
CONFIG_SENSORS_LTC4222=y
CONFIG_SENSORS_LTC4245=y
CONFIG_SENSORS_LTC4260=y
CONFIG_SENSORS_LTC4261=y
CONFIG_SENSORS_MAX16065=y
# CONFIG_SENSORS_MAX1619 is not set
CONFIG_SENSORS_MAX1668=y
CONFIG_SENSORS_MAX197=y
CONFIG_SENSORS_MAX6621=y
CONFIG_SENSORS_MAX6639=y
# CONFIG_SENSORS_MAX6642 is not set
# CONFIG_SENSORS_MAX6650 is not set
# CONFIG_SENSORS_MAX6697 is not set
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=y
CONFIG_SENSORS_TC654=y
# CONFIG_SENSORS_MENF21BMC_HWMON is not set
CONFIG_SENSORS_LM63=y
# CONFIG_SENSORS_LM73 is not set
CONFIG_SENSORS_LM75=y
CONFIG_SENSORS_LM77=y
CONFIG_SENSORS_LM78=y
CONFIG_SENSORS_LM80=y
# CONFIG_SENSORS_LM83 is not set
CONFIG_SENSORS_LM85=y
CONFIG_SENSORS_LM87=y
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_LM92 is not set
CONFIG_SENSORS_LM93=y
CONFIG_SENSORS_LM95234=y
# CONFIG_SENSORS_LM95241 is not set
CONFIG_SENSORS_LM95245=y
CONFIG_SENSORS_PC87360=y
# CONFIG_SENSORS_PC87427 is not set
# CONFIG_SENSORS_NTC_THERMISTOR is not set
CONFIG_SENSORS_NCT6683=y
CONFIG_SENSORS_NCT6775=y
CONFIG_SENSORS_NCT7802=y
CONFIG_SENSORS_NCT7904=y
# CONFIG_SENSORS_PCF8591 is not set
CONFIG_PMBUS=y
CONFIG_SENSORS_PMBUS=y
CONFIG_SENSORS_ADM1275=y
CONFIG_SENSORS_IBM_CFFPS=y
CONFIG_SENSORS_IR35221=y
# CONFIG_SENSORS_LM25066 is not set
CONFIG_SENSORS_LTC2978=y
CONFIG_SENSORS_LTC2978_REGULATOR=y
# CONFIG_SENSORS_LTC3815 is not set
CONFIG_SENSORS_MAX16064=y
CONFIG_SENSORS_MAX20751=y
CONFIG_SENSORS_MAX31785=y
# CONFIG_SENSORS_MAX34440 is not set
CONFIG_SENSORS_MAX8688=y
CONFIG_SENSORS_TPS40422=y
CONFIG_SENSORS_TPS53679=y
# CONFIG_SENSORS_UCD9000 is not set
CONFIG_SENSORS_UCD9200=y
CONFIG_SENSORS_ZL6100=y
CONFIG_SENSORS_PWM_FAN=y
CONFIG_SENSORS_SHT15=y
# CONFIG_SENSORS_SHT21 is not set
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHTC1 is not set
# CONFIG_SENSORS_SIS5595 is not set
CONFIG_SENSORS_DME1737=y
CONFIG_SENSORS_EMC1403=y
CONFIG_SENSORS_EMC2103=y
# CONFIG_SENSORS_EMC6W201 is not set
CONFIG_SENSORS_SMSC47M1=y
CONFIG_SENSORS_SMSC47M192=y
CONFIG_SENSORS_SMSC47B397=y
CONFIG_SENSORS_STTS751=y
CONFIG_SENSORS_SMM665=y
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS1015=y
CONFIG_SENSORS_ADS7828=y
CONFIG_SENSORS_AMC6821=y
CONFIG_SENSORS_INA209=y
# CONFIG_SENSORS_INA2XX is not set
CONFIG_SENSORS_INA3221=y
CONFIG_SENSORS_TC74=y
CONFIG_SENSORS_THMC50=y
CONFIG_SENSORS_TMP102=y
CONFIG_SENSORS_TMP103=y
CONFIG_SENSORS_TMP108=y
# CONFIG_SENSORS_TMP401 is not set
# CONFIG_SENSORS_TMP421 is not set
CONFIG_SENSORS_VIA_CPUTEMP=y
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_VT1211 is not set
# CONFIG_SENSORS_VT8231 is not set
# CONFIG_SENSORS_W83773G is not set
# CONFIG_SENSORS_W83781D is not set
CONFIG_SENSORS_W83791D=y
# CONFIG_SENSORS_W83792D is not set
# CONFIG_SENSORS_W83793 is not set
CONFIG_SENSORS_W83795=y
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=y
CONFIG_SENSORS_W83L786NG=y
CONFIG_SENSORS_W83627HF=y
CONFIG_SENSORS_W83627EHF=y
CONFIG_SENSORS_WM8350=y

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_OF=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_GOV_STEP_WISE is not set
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
# CONFIG_CPU_THERMAL is not set
CONFIG_THERMAL_EMULATION=y
CONFIG_QORIQ_THERMAL=y
CONFIG_INTEL_POWERCLAMP=y
CONFIG_X86_PKG_TEMP_THERMAL=y
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# CONFIG_INTEL_PCH_THERMAL is not set
# CONFIG_QCOM_SPMI_TEMP_ALARM is not set
CONFIG_GENERIC_ADC_THERMAL=y
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
# CONFIG_SSB_B43_PCI_BRIDGE is not set
CONFIG_SSB_SDIOHOST_POSSIBLE=y
# CONFIG_SSB_SDIOHOST is not set
CONFIG_SSB_SILENT=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
# CONFIG_SSB_DRIVER_PCICORE is not set
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_CS5535 is not set
# CONFIG_MFD_ACT8945A is not set
CONFIG_MFD_AS3711=y
# CONFIG_MFD_AS3722 is not set
# CONFIG_PMIC_ADP5520 is not set
CONFIG_MFD_AAT2870_CORE=y
CONFIG_MFD_ATMEL_FLEXCOM=y
# CONFIG_MFD_ATMEL_HLCDC is not set
CONFIG_MFD_BCM590XX=y
CONFIG_MFD_BD9571MWV=y
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_CROS_EC is not set
CONFIG_PMIC_DA903X=y
# CONFIG_MFD_DA9052_I2C is not set
CONFIG_MFD_DA9055=y
# CONFIG_MFD_DA9062 is not set
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=y
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_I2C=y
CONFIG_MFD_HI6421_PMIC=y
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
# CONFIG_MFD_88PM800 is not set
CONFIG_MFD_88PM805=y
CONFIG_MFD_88PM860X=y
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77620 is not set
CONFIG_MFD_MAX77686=y
# CONFIG_MFD_MAX77693 is not set
CONFIG_MFD_MAX77843=y
CONFIG_MFD_MAX8907=y
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
CONFIG_MFD_MAX8998=y
CONFIG_MFD_MT6397=y
CONFIG_MFD_MENF21BMC=y
# CONFIG_MFD_RETU is not set
CONFIG_MFD_PCF50633=y
CONFIG_PCF50633_ADC=y
CONFIG_PCF50633_GPIO=y
# CONFIG_MFD_RDC321X is not set
CONFIG_MFD_RT5033=y
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_RK808 is not set
CONFIG_MFD_RN5T618=y
CONFIG_MFD_SEC_CORE=y
CONFIG_MFD_SI476X_CORE=y
# CONFIG_MFD_SM501 is not set
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SMSC is not set
CONFIG_ABX500_CORE=y
CONFIG_AB3100_CORE=y
CONFIG_AB3100_OTP=y
CONFIG_MFD_STMPE=y

#
# STMicroelectronics STMPE Interface Drivers
#
# CONFIG_STMPE_I2C is not set
CONFIG_MFD_SYSCON=y
# CONFIG_MFD_TI_AM335X_TSCADC is not set
CONFIG_MFD_LP3943=y
CONFIG_MFD_LP8788=y
CONFIG_MFD_TI_LMU=y
# CONFIG_MFD_PALMAS is not set
CONFIG_TPS6105X=y
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=y
CONFIG_MFD_TPS65086=y
# CONFIG_MFD_TPS65090 is not set
CONFIG_MFD_TPS65217=y
# CONFIG_MFD_TPS68470 is not set
# CONFIG_MFD_TI_LP873X is not set
CONFIG_MFD_TI_LP87565=y
CONFIG_MFD_TPS65218=y
CONFIG_MFD_TPS6586X=y
# CONFIG_MFD_TPS65910 is not set
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
CONFIG_MFD_TPS80031=y
CONFIG_TWL4030_CORE=y
# CONFIG_MFD_TWL4030_AUDIO is not set
CONFIG_TWL6040_CORE=y
CONFIG_MFD_WL1273_CORE=y
CONFIG_MFD_LM3533=y
# CONFIG_MFD_TIMBERDALE is not set
CONFIG_MFD_TC3589X=y
# CONFIG_MFD_TMIO is not set
# CONFIG_MFD_VX855 is not set
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
CONFIG_MFD_CS47L24=y
CONFIG_MFD_WM5102=y
# CONFIG_MFD_WM5110 is not set
CONFIG_MFD_WM8997=y
# CONFIG_MFD_WM8998 is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
CONFIG_MFD_WM8994=y
CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
CONFIG_REGULATOR_88PM8607=y
CONFIG_REGULATOR_ACT8865=y
CONFIG_REGULATOR_AD5398=y
CONFIG_REGULATOR_ANATOP=y
CONFIG_REGULATOR_AAT2870=y
CONFIG_REGULATOR_AB3100=y
CONFIG_REGULATOR_AS3711=y
CONFIG_REGULATOR_BCM590XX=y
CONFIG_REGULATOR_BD9571MWV=y
# CONFIG_REGULATOR_DA903X is not set
# CONFIG_REGULATOR_DA9055 is not set
CONFIG_REGULATOR_DA9063=y
CONFIG_REGULATOR_DA9210=y
CONFIG_REGULATOR_DA9211=y
# CONFIG_REGULATOR_FAN53555 is not set
CONFIG_REGULATOR_GPIO=y
# CONFIG_REGULATOR_HI6421 is not set
# CONFIG_REGULATOR_HI6421V530 is not set
# CONFIG_REGULATOR_ISL9305 is not set
CONFIG_REGULATOR_ISL6271A=y
# CONFIG_REGULATOR_LM363X is not set
# CONFIG_REGULATOR_LP3971 is not set
# CONFIG_REGULATOR_LP3972 is not set
CONFIG_REGULATOR_LP872X=y
CONFIG_REGULATOR_LP8755=y
CONFIG_REGULATOR_LP87565=y
CONFIG_REGULATOR_LP8788=y
CONFIG_REGULATOR_LTC3589=y
# CONFIG_REGULATOR_LTC3676 is not set
CONFIG_REGULATOR_MAX1586=y
# CONFIG_REGULATOR_MAX8649 is not set
CONFIG_REGULATOR_MAX8660=y
# CONFIG_REGULATOR_MAX8907 is not set
CONFIG_REGULATOR_MAX8952=y
# CONFIG_REGULATOR_MAX8973 is not set
CONFIG_REGULATOR_MAX8998=y
CONFIG_REGULATOR_MAX77686=y
CONFIG_REGULATOR_MAX77693=y
# CONFIG_REGULATOR_MAX77802 is not set
CONFIG_REGULATOR_MC13XXX_CORE=y
CONFIG_REGULATOR_MC13783=y
CONFIG_REGULATOR_MC13892=y
CONFIG_REGULATOR_MT6311=y
# CONFIG_REGULATOR_MT6323 is not set
# CONFIG_REGULATOR_MT6397 is not set
CONFIG_REGULATOR_PCF50633=y
CONFIG_REGULATOR_PFUZE100=y
CONFIG_REGULATOR_PV88060=y
CONFIG_REGULATOR_PV88080=y
# CONFIG_REGULATOR_PV88090 is not set
CONFIG_REGULATOR_PWM=y
# CONFIG_REGULATOR_QCOM_SPMI is not set
CONFIG_REGULATOR_RN5T618=y
CONFIG_REGULATOR_RT5033=y
CONFIG_REGULATOR_S2MPA01=y
# CONFIG_REGULATOR_S2MPS11 is not set
# CONFIG_REGULATOR_S5M8767 is not set
CONFIG_REGULATOR_TPS51632=y
CONFIG_REGULATOR_TPS6105X=y
# CONFIG_REGULATOR_TPS62360 is not set
CONFIG_REGULATOR_TPS65023=y
# CONFIG_REGULATOR_TPS6507X is not set
CONFIG_REGULATOR_TPS65086=y
CONFIG_REGULATOR_TPS65132=y
CONFIG_REGULATOR_TPS65217=y
CONFIG_REGULATOR_TPS65218=y
CONFIG_REGULATOR_TPS6586X=y
CONFIG_REGULATOR_TPS65912=y
CONFIG_REGULATOR_TPS80031=y
# CONFIG_REGULATOR_TWL4030 is not set
CONFIG_REGULATOR_VCTRL=y
CONFIG_REGULATOR_WM8350=y
CONFIG_REGULATOR_WM8994=y
CONFIG_CEC_CORE=y
CONFIG_CEC_NOTIFIER=y
# CONFIG_RC_CORE is not set
CONFIG_MEDIA_SUPPORT=y

#
# Multimedia core support
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
# CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_CEC_SUPPORT=y
CONFIG_MEDIA_CONTROLLER=y
CONFIG_VIDEO_DEV=y
# CONFIG_VIDEO_V4L2_SUBDEV_API is not set
CONFIG_VIDEO_V4L2=y
CONFIG_VIDEO_ADV_DEBUG=y
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
# CONFIG_TTPCI_EEPROM is not set

#
# Media drivers
#
# CONFIG_MEDIA_PCI_SUPPORT is not set
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
# CONFIG_V4L_TEST_DRIVERS is not set
# CONFIG_CEC_PLATFORM_DRIVERS is not set
CONFIG_SDR_PLATFORM_DRIVERS=y

#
# Supported MMC/SDIO adapters
#
CONFIG_RADIO_ADAPTERS=y
CONFIG_RADIO_TEA575X=y
# CONFIG_RADIO_SI470X is not set
# CONFIG_RADIO_SI4713 is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_TEA5764 is not set
CONFIG_RADIO_SAA7706H=y
CONFIG_RADIO_TEF6862=y
CONFIG_RADIO_WL1273=y

#
# Texas Instruments WL128x FM driver (ST based)
#
CONFIG_V4L_RADIO_ISA_DRIVERS=y
CONFIG_RADIO_ISA=y
CONFIG_RADIO_CADET=y
# CONFIG_RADIO_RTRACK is not set
# CONFIG_RADIO_RTRACK2 is not set
CONFIG_RADIO_AZTECH=y
CONFIG_RADIO_AZTECH_PORT=350
CONFIG_RADIO_GEMTEK=y
CONFIG_RADIO_GEMTEK_PORT=34c
CONFIG_RADIO_GEMTEK_PROBE=y
CONFIG_RADIO_SF16FMI=y
CONFIG_RADIO_SF16FMR2=y
CONFIG_RADIO_TERRATEC=y
CONFIG_RADIO_TRUST=y
CONFIG_RADIO_TRUST_PORT=350
# CONFIG_RADIO_TYPHOON is not set
# CONFIG_RADIO_ZOLTRIX is not set

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

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
CONFIG_DRM_MIPI_DSI=y
# CONFIG_DRM_DP_AUX_CHARDEV is not set
# CONFIG_DRM_DEBUG_MM is not set
CONFIG_DRM_DEBUG_MM_SELFTEST=y
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_GEM_CMA_HELPER=y
CONFIG_DRM_KMS_CMA_HELPER=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=y
CONFIG_DRM_I2C_SIL164=y
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
# CONFIG_DRM_VIRTIO_GPU is not set
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_LVDS is not set
CONFIG_DRM_PANEL_SIMPLE=y
CONFIG_DRM_PANEL_INNOLUX_P079ZCA=y
CONFIG_DRM_PANEL_JDI_LT070ME05000=y
# CONFIG_DRM_PANEL_ORISETECH_OTM8009A is not set
CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00=y
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2 is not set
CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=y
CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=y
CONFIG_DRM_PANEL_SEIKO_43WVF1G=y
CONFIG_DRM_PANEL_SHARP_LQ101R1SX01=y
# CONFIG_DRM_PANEL_SHARP_LS043T1LE01 is not set
CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
CONFIG_DRM_ANALOGIX_ANX78XX=y
CONFIG_DRM_DUMB_VGA_DAC=y
# CONFIG_DRM_LVDS_ENCODER is not set
CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW=y
CONFIG_DRM_NXP_PTN3460=y
CONFIG_DRM_PARADE_PS8622=y
CONFIG_DRM_SII902X=y
CONFIG_DRM_SII9234=y
CONFIG_DRM_TOSHIBA_TC358767=y
CONFIG_DRM_TI_TFP410=y
CONFIG_DRM_I2C_ADV7511=y
# CONFIG_DRM_I2C_ADV7533 is not set
# CONFIG_DRM_I2C_ADV7511_CEC is not set
CONFIG_DRM_DW_HDMI=y
CONFIG_DRM_DW_HDMI_CEC=y
CONFIG_DRM_ARCPGU=y
# CONFIG_DRM_HISI_HIBMC is not set
# CONFIG_DRM_MXSFB is not set
CONFIG_DRM_TINYDRM=y
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_LIB_RANDOM=y

#
# Frame buffer Devices
#
CONFIG_FB=y
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
# CONFIG_FB_DDC is not set
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
# CONFIG_FB_SVGALIB is not set
# CONFIG_FB_MACMODES is not set
# CONFIG_FB_BACKLIGHT is not set
CONFIG_FB_MODE_HELPERS=y
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
CONFIG_FB_UVESA=y
CONFIG_FB_VESA=y
# CONFIG_FB_N411 is not set
CONFIG_FB_HGA=y
CONFIG_FB_OPENCORES=y
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
CONFIG_FB_IBM_GXT4500=y
# CONFIG_FB_GOLDFISH is not set
CONFIG_FB_VIRTUAL=y
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_BROADSHEET=y
CONFIG_FB_AUO_K190X=y
CONFIG_FB_AUO_K1900=y
# CONFIG_FB_AUO_K1901 is not set
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SSD1307 is not set
# CONFIG_FB_SM712 is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=y
# CONFIG_LCD_CLASS_DEVICE is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_GENERIC=y
CONFIG_BACKLIGHT_LM3533=y
CONFIG_BACKLIGHT_PWM=y
# CONFIG_BACKLIGHT_DA903X is not set
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_PM8941_WLED=y
# CONFIG_BACKLIGHT_SAHARA is not set
CONFIG_BACKLIGHT_ADP8860=y
CONFIG_BACKLIGHT_ADP8870=y
# CONFIG_BACKLIGHT_88PM860X is not set
CONFIG_BACKLIGHT_PCF50633=y
CONFIG_BACKLIGHT_AAT2870=y
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=y
# CONFIG_BACKLIGHT_LP8788 is not set
CONFIG_BACKLIGHT_PANDORA=y
CONFIG_BACKLIGHT_TPS65217=y
CONFIG_BACKLIGHT_AS3711=y
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
CONFIG_BACKLIGHT_BD6107=y
CONFIG_BACKLIGHT_ARCXCNN=y
# CONFIG_VGASTATE is not set
CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y
# CONFIG_LOGO is not set
CONFIG_SOUND=y
# CONFIG_SOUND_OSS_CORE is not set
# CONFIG_SND is not set

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
# CONFIG_HIDRAW is not set
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
# CONFIG_HID_ACRUX is not set
# CONFIG_HID_APPLE is not set
# CONFIG_HID_ASUS is not set
# CONFIG_HID_AUREAL is not set
# CONFIG_HID_BELKIN is not set
# CONFIG_HID_CHERRY is not set
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CYPRESS is not set
# CONFIG_HID_DRAGONRISE is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELECOM is not set
# CONFIG_HID_EZKEY is not set
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
# CONFIG_HID_KEYTOUCH is not set
# CONFIG_HID_KYE is not set
# CONFIG_HID_WALTOP is not set
# CONFIG_HID_GYRATION is not set
# CONFIG_HID_ICADE is not set
# CONFIG_HID_ITE is not set
# CONFIG_HID_JABRA is not set
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
# CONFIG_HID_NTI is not set
# CONFIG_HID_ORTEK is not set
# CONFIG_HID_PANTHERLORD is not set
# CONFIG_HID_PETALYNX is not set
# CONFIG_HID_PICOLCD is not set
# CONFIG_HID_PLANTRONICS is not set
# CONFIG_HID_PRIMAX is not set
# CONFIG_HID_SAITEK is not set
# CONFIG_HID_SAMSUNG is not set
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
# CONFIG_HID_WIIMOTE is not set
# CONFIG_HID_XINMO is not set
# CONFIG_HID_ZEROPLUS is not set
# CONFIG_HID_ZYDACRON is not set
# CONFIG_HID_SENSOR_HUB is not set
# CONFIG_HID_ALPS is not set

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
# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_UWB is not set
CONFIG_MMC=y
CONFIG_PWRSEQ_EMMC=y
CONFIG_PWRSEQ_SD8787=y
CONFIG_PWRSEQ_SIMPLE=y
CONFIG_MMC_BLOCK=y
CONFIG_MMC_BLOCK_MINORS=8
# CONFIG_SDIO_UART is not set
CONFIG_MMC_TEST=y

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=y
# CONFIG_MMC_SDHCI_PCI is not set
# CONFIG_MMC_SDHCI_ACPI is not set
CONFIG_MMC_SDHCI_PLTFM=y
# CONFIG_MMC_SDHCI_OF_ARASAN is not set
CONFIG_MMC_SDHCI_OF_AT91=y
# CONFIG_MMC_SDHCI_CADENCE is not set
# CONFIG_MMC_SDHCI_F_SDH30 is not set
CONFIG_MMC_WBSD=y
# CONFIG_MMC_TIFM_SD is not set
CONFIG_MMC_GOLDFISH=y
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
CONFIG_MMC_USDHI6ROL0=y
CONFIG_MMC_CQHCI=y
# CONFIG_MMC_TOSHIBA_PCI is not set
CONFIG_MMC_MTK=y
CONFIG_MMC_SDHCI_XENON=y
CONFIG_MMC_SDHCI_OMAP=y
CONFIG_MEMSTICK=y
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=y
# CONFIG_MS_BLOCK is not set

#
# MemoryStick Host Controller Drivers
#
# CONFIG_MEMSTICK_TIFM_MS is not set
# CONFIG_MEMSTICK_JMICRON_38X is not set
# CONFIG_MEMSTICK_R592 is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
CONFIG_LEDS_88PM860X=y
CONFIG_LEDS_APU=y
CONFIG_LEDS_BCM6328=y
CONFIG_LEDS_BCM6358=y
CONFIG_LEDS_LM3530=y
# CONFIG_LEDS_LM3533 is not set
# CONFIG_LEDS_LM3642 is not set
CONFIG_LEDS_LM3692X=y
CONFIG_LEDS_MT6323=y
# CONFIG_LEDS_PCA9532 is not set
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_LP3944=y
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP55XX_COMMON=y
CONFIG_LEDS_LP5521=y
# CONFIG_LEDS_LP5523 is not set
CONFIG_LEDS_LP5562=y
CONFIG_LEDS_LP8501=y
CONFIG_LEDS_LP8788=y
CONFIG_LEDS_LP8860=y
# CONFIG_LEDS_CLEVO_MAIL is not set
CONFIG_LEDS_PCA955X=y
CONFIG_LEDS_PCA955X_GPIO=y
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_WM8350 is not set
CONFIG_LEDS_DA903X=y
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_REGULATOR is not set
CONFIG_LEDS_BD2802=y
# CONFIG_LEDS_INTEL_SS4200 is not set
CONFIG_LEDS_LT3593=y
CONFIG_LEDS_MC13783=y
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set
CONFIG_LEDS_OT200=y
# CONFIG_LEDS_MENF21BMC is not set
# CONFIG_LEDS_IS31FL319X is not set
# CONFIG_LEDS_IS31FL32XX is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
CONFIG_LEDS_SYSCON=y
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
# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
CONFIG_LEDS_TRIGGER_BACKLIGHT=y
CONFIG_LEDS_TRIGGER_CPU=y
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
# CONFIG_LEDS_TRIGGER_GPIO is not set
# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=y
CONFIG_LEDS_TRIGGER_CAMERA=y
# CONFIG_LEDS_TRIGGER_PANIC is not set
CONFIG_LEDS_TRIGGER_NETDEV=y
# CONFIG_ACCESSIBILITY is not set
CONFIG_INFINIBAND=y
# CONFIG_INFINIBAND_USER_MAD is not set
# CONFIG_INFINIBAND_USER_ACCESS is not set
CONFIG_INFINIBAND_ADDR_TRANS=y
CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS=y
# CONFIG_INFINIBAND_MTHCA is not set
# CONFIG_MLX4_INFINIBAND is not set
# CONFIG_INFINIBAND_NES is not set
# CONFIG_INFINIBAND_OCRDMA is not set
# CONFIG_INFINIBAND_IPOIB is not set
CONFIG_INFINIBAND_SRP=y
CONFIG_INFINIBAND_SRPT=y
# CONFIG_INFINIBAND_ISER is not set
# CONFIG_RDMA_RXE is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
# CONFIG_EDAC_LEGACY_SYSFS is not set
# CONFIG_EDAC_DEBUG is not set
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
CONFIG_RTC_CLASS=y
# CONFIG_RTC_HCTOSYS is not set
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
# CONFIG_RTC_DRV_88PM860X is not set
CONFIG_RTC_DRV_ABB5ZES3=y
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=y
CONFIG_RTC_DRV_DS1307_HWMON=y
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=y
# CONFIG_RTC_DRV_DS1374_WDT is not set
# CONFIG_RTC_DRV_DS1672 is not set
# CONFIG_RTC_DRV_HYM8563 is not set
CONFIG_RTC_DRV_LP8788=y
CONFIG_RTC_DRV_MAX6900=y
CONFIG_RTC_DRV_MAX8907=y
# CONFIG_RTC_DRV_MAX8998 is not set
# CONFIG_RTC_DRV_MAX77686 is not set
# CONFIG_RTC_DRV_RS5C372 is not set
# CONFIG_RTC_DRV_ISL1208 is not set
CONFIG_RTC_DRV_ISL12022=y
CONFIG_RTC_DRV_X1205=y
CONFIG_RTC_DRV_PCF8523=y
CONFIG_RTC_DRV_PCF85063=y
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=y
CONFIG_RTC_DRV_PCF8583=y
# CONFIG_RTC_DRV_M41T80 is not set
# CONFIG_RTC_DRV_BQ32K is not set
CONFIG_RTC_DRV_TWL4030=y
# CONFIG_RTC_DRV_TPS6586X is not set
CONFIG_RTC_DRV_TPS80031=y
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=y
CONFIG_RTC_DRV_RX8010=y
# CONFIG_RTC_DRV_RX8581 is not set
CONFIG_RTC_DRV_RX8025=y
# CONFIG_RTC_DRV_EM3027 is not set
CONFIG_RTC_DRV_RV8803=y
CONFIG_RTC_DRV_S5M=y

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
CONFIG_RTC_DRV_RV3029C2=y
CONFIG_RTC_DRV_RV3029_HWMON=y

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=y
CONFIG_RTC_DRV_DS1511=y
CONFIG_RTC_DRV_DS1553=y
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=y
CONFIG_RTC_DRV_DS2404=y
# CONFIG_RTC_DRV_DA9055 is not set
CONFIG_RTC_DRV_DA9063=y
CONFIG_RTC_DRV_STK17TA8=y
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=y
CONFIG_RTC_DRV_M48T59=y
CONFIG_RTC_DRV_MSM6242=y
CONFIG_RTC_DRV_BQ4802=y
# CONFIG_RTC_DRV_RP5C01 is not set
# CONFIG_RTC_DRV_V3020 is not set
CONFIG_RTC_DRV_WM8350=y
# CONFIG_RTC_DRV_PCF50633 is not set
CONFIG_RTC_DRV_AB3100=y
CONFIG_RTC_DRV_ZYNQMP=y

#
# on-CPU RTC drivers
#
CONFIG_RTC_DRV_FTRTC010=y
# CONFIG_RTC_DRV_MC13XXX is not set
CONFIG_RTC_DRV_SNVS=y
CONFIG_RTC_DRV_MT6397=y
CONFIG_RTC_DRV_R7301=y

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
# CONFIG_PANEL is not set
CONFIG_UIO=y
# CONFIG_UIO_CIF is not set
# CONFIG_UIO_PDRV_GENIRQ is not set
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
# CONFIG_VIRTIO_BALLOON is not set
# CONFIG_VIRTIO_INPUT is not set
CONFIG_VIRTIO_MMIO=y
# CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# CONFIG_HYPERV_TSCPAGE is not set
CONFIG_STAGING=y
CONFIG_IRDA=y

#
# IrDA protocols
#
CONFIG_IRLAN=y
# CONFIG_IRCOMM is not set
CONFIG_IRDA_ULTRA=y

#
# IrDA options
#
# CONFIG_IRDA_CACHE_LAST_LSAP is not set
# CONFIG_IRDA_FAST_RR is not set
# CONFIG_IRDA_DEBUG is not set

#
# Infrared-port device drivers
#

#
# SIR device drivers
#
# CONFIG_IRTTY_SIR is not set

#
# Dongle support
#

#
# FIR device drivers
#
CONFIG_NSC_FIR=y
CONFIG_WINBOND_FIR=y
# CONFIG_TOSHIBA_FIR is not set
# CONFIG_SMC_IRCC_FIR is not set
CONFIG_ALI_FIR=y
# CONFIG_VLSI_FIR is not set
CONFIG_VIA_FIR=y
CONFIG_IPX=y
CONFIG_IPX_INTERN=y
CONFIG_NCP_FS=y
# CONFIG_NCPFS_PACKET_SIGNING is not set
CONFIG_NCPFS_IOCTL_LOCKING=y
# CONFIG_NCPFS_STRONG is not set
CONFIG_NCPFS_NFS_NS=y
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
CONFIG_NCPFS_NLS=y
CONFIG_NCPFS_EXTRAS=y
# CONFIG_COMEDI is not set
# CONFIG_RTS5208 is not set

#
# IIO staging drivers
#

#
# Accelerometers
#

#
# Analog to digital converters
#
# CONFIG_AD7606 is not set

#
# Analog digital bi-direction converters
#
# CONFIG_ADT7316 is not set

#
# Capacitance to digital converters
#
CONFIG_AD7150=y
# CONFIG_AD7152 is not set
# CONFIG_AD7746 is not set

#
# Direct Digital Synthesis
#

#
# Digital gyroscope sensors
#

#
# Network Analyzer, Impedance Converters
#
# CONFIG_AD5933 is not set

#
# Light sensors
#
CONFIG_TSL2x7x=y

#
# Active energy metering IC
#
# CONFIG_ADE7854 is not set

#
# Resolver to digital converters
#

#
# Triggers - standalone
#
# CONFIG_FB_SM750 is not set
# CONFIG_FB_XGI is not set

#
# Speakup console speech
#
CONFIG_STAGING_MEDIA=y
# CONFIG_I2C_BCM2048 is not set

#
# Android
#
# CONFIG_STAGING_BOARD is not set
CONFIG_GOLDFISH_AUDIO=y
CONFIG_MTD_GOLDFISH_NAND=y
# CONFIG_DGNC is not set
# CONFIG_GS_FPGABOOT is not set
CONFIG_UNISYSSPAR=y
# CONFIG_COMMON_CLK_XLNX_CLKWZRD is not set
# CONFIG_MOST is not set
# CONFIG_KS7010 is not set
CONFIG_GREYBUS=y
CONFIG_GREYBUS_AUDIO=y
CONFIG_GREYBUS_BOOTROM=y
# CONFIG_GREYBUS_HID is not set
CONFIG_GREYBUS_LIGHT=y
# CONFIG_GREYBUS_LOG is not set
CONFIG_GREYBUS_LOOPBACK=y
# CONFIG_GREYBUS_POWER is not set
CONFIG_GREYBUS_RAW=y
CONFIG_GREYBUS_VIBRATOR=y
CONFIG_GREYBUS_BRIDGED_PHY=y
CONFIG_GREYBUS_GPIO=y
# CONFIG_GREYBUS_I2C is not set
CONFIG_GREYBUS_PWM=y
CONFIG_GREYBUS_SDIO=y
# CONFIG_GREYBUS_UART is not set

#
# USB Power Delivery and Type-C drivers
#
# CONFIG_DRM_VBOXVIDEO is not set
CONFIG_X86_PLATFORM_DEVICES=y
# CONFIG_ACER_WIRELESS is not set
# CONFIG_ACERHDF is not set
# CONFIG_ASUS_LAPTOP is not set
# CONFIG_DELL_SMBIOS is not set
# CONFIG_DELL_LAPTOP is not set
# CONFIG_DELL_SMO8800 is not set
# CONFIG_DELL_RBTN is not set
# CONFIG_FUJITSU_LAPTOP is not set
# CONFIG_FUJITSU_TABLET is not set
# CONFIG_AMILO_RFKILL is not set
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_HP_ACCEL is not set
# CONFIG_HP_WIRELESS is not set
# CONFIG_MSI_LAPTOP is not set
# CONFIG_PANASONIC_LAPTOP is not set
# CONFIG_COMPAL_LAPTOP is not set
# CONFIG_SONY_LAPTOP is not set
# CONFIG_IDEAPAD_LAPTOP is not set
# CONFIG_THINKPAD_ACPI is not set
# CONFIG_SENSORS_HDAPS is not set
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
# CONFIG_IBM_RTL is not set
CONFIG_SAMSUNG_LAPTOP=y
# CONFIG_INTEL_OAKTRAIL is not set
# CONFIG_SAMSUNG_Q10 is not set
# CONFIG_APPLE_GMUX is not set
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_PVPANIC is not set
# CONFIG_INTEL_PMC_IPC is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_INTEL_PUNIT_IPC=y
CONFIG_MLX_PLATFORM=y
CONFIG_PMC_ATOM=y
CONFIG_GOLDFISH_BUS=y
CONFIG_GOLDFISH_PIPE=y
CONFIG_CHROME_PLATFORMS=y
CONFIG_CHROMEOS_LAPTOP=y
CONFIG_CHROMEOS_PSTORE=y
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
CONFIG_MELLANOX_PLATFORM=y
# CONFIG_MLXREG_HOTPLUG is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_CLK_HSDK is not set
# CONFIG_COMMON_CLK_MAX77686 is not set
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
CONFIG_PLATFORM_MHU=y
# CONFIG_PCC is not set
CONFIG_ALTERA_MBOX=y
CONFIG_MAILBOX_TEST=y
# CONFIG_IOMMU_SUPPORT is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
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
# CONFIG_XILINX_VCU is not set
# CONFIG_PM_DEVFREQ is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=y
CONFIG_EXTCON_GPIO=y
# CONFIG_EXTCON_INTEL_INT3496 is not set
# CONFIG_EXTCON_MAX3355 is not set
CONFIG_EXTCON_MAX77843=y
# CONFIG_EXTCON_RT8973A is not set
CONFIG_EXTCON_SM5502=y
CONFIG_EXTCON_USB_GPIO=y
# CONFIG_MEMORY is not set
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
CONFIG_BMC150_ACCEL=y
CONFIG_BMC150_ACCEL_I2C=y
CONFIG_DA280=y
CONFIG_DA311=y
CONFIG_DMARD06=y
CONFIG_DMARD09=y
CONFIG_DMARD10=y
# CONFIG_IIO_CROS_EC_ACCEL_LEGACY is not set
# CONFIG_IIO_ST_ACCEL_3AXIS is not set
CONFIG_KXSD9=y
CONFIG_KXSD9_I2C=y
CONFIG_KXCJK1013=y
# CONFIG_MC3230 is not set
# CONFIG_MMA7455_I2C is not set
CONFIG_MMA7660=y
CONFIG_MMA8452=y
CONFIG_MMA9551_CORE=y
# CONFIG_MMA9551 is not set
CONFIG_MMA9553=y
# CONFIG_MXC4005 is not set
CONFIG_MXC6255=y
CONFIG_STK8312=y
CONFIG_STK8BA50=y

#
# Analog to digital converters
#
# CONFIG_AD7291 is not set
CONFIG_AD799X=y
# CONFIG_CC10001_ADC is not set
CONFIG_DA9150_GPADC=y
# CONFIG_ENVELOPE_DETECTOR is not set
# CONFIG_HX711 is not set
# CONFIG_INA2XX_ADC is not set
CONFIG_LP8788_ADC=y
CONFIG_LTC2471=y
# CONFIG_LTC2485 is not set
# CONFIG_LTC2497 is not set
CONFIG_MAX1363=y
# CONFIG_MAX9611 is not set
# CONFIG_MCP3422 is not set
CONFIG_MEN_Z188_ADC=y
# CONFIG_NAU7802 is not set
CONFIG_QCOM_VADC_COMMON=y
CONFIG_QCOM_SPMI_IADC=y
CONFIG_QCOM_SPMI_VADC=y
# CONFIG_SD_ADC_MODULATOR is not set
CONFIG_TI_ADC081C=y
CONFIG_TWL4030_MADC=y
CONFIG_TWL6030_GPADC=y
CONFIG_VF610_ADC=y

#
# Amplifiers
#

#
# Chemical Sensors
#
# CONFIG_ATLAS_PH_SENSOR is not set
CONFIG_CCS811=y
CONFIG_IAQCORE=y
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

#
# Digital to analog converters
#
# CONFIG_AD5064 is not set
CONFIG_AD5380=y
# CONFIG_AD5446 is not set
CONFIG_AD5592R_BASE=y
CONFIG_AD5593R=y
# CONFIG_CIO_DAC is not set
CONFIG_DPOT_DAC=y
CONFIG_DS4424=y
# CONFIG_M62332 is not set
CONFIG_MAX517=y
# CONFIG_MAX5821 is not set
# CONFIG_MCP4725 is not set
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
# CONFIG_MPU3050_I2C is not set
CONFIG_IIO_ST_GYRO_3AXIS=y
CONFIG_IIO_ST_GYRO_I2C_3AXIS=y
# CONFIG_ITG3200 is not set

#
# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4404=y
# CONFIG_MAX30100 is not set
CONFIG_MAX30102=y

#
# Humidity sensors
#
# CONFIG_AM2315 is not set
CONFIG_DHT11=y
CONFIG_HDC100X=y
# CONFIG_HTS221 is not set
# CONFIG_HTU21 is not set
# CONFIG_SI7005 is not set
# CONFIG_SI7020 is not set

#
# Inertial measurement units
#
# CONFIG_BMI160_I2C is not set
CONFIG_KMX61=y
# CONFIG_INV_MPU6050_I2C is not set
CONFIG_IIO_ST_LSM6DSX=y
CONFIG_IIO_ST_LSM6DSX_I2C=y

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
CONFIG_ADJD_S311=y
CONFIG_AL3320A=y
# CONFIG_APDS9300 is not set
CONFIG_APDS9960=y
CONFIG_BH1750=y
CONFIG_BH1780=y
CONFIG_CM32181=y
CONFIG_CM3232=y
CONFIG_CM3323=y
CONFIG_CM3605=y
CONFIG_CM36651=y
# CONFIG_GP2AP020A00F is not set
# CONFIG_SENSORS_ISL29018 is not set
CONFIG_SENSORS_ISL29028=y
# CONFIG_ISL29125 is not set
# CONFIG_JSA1212 is not set
# CONFIG_RPR0521 is not set
# CONFIG_SENSORS_LM3533 is not set
CONFIG_LTR501=y
CONFIG_MAX44000=y
CONFIG_OPT3001=y
CONFIG_PA12203001=y
CONFIG_SI1145=y
CONFIG_STK3310=y
CONFIG_ST_UVIS25=y
CONFIG_ST_UVIS25_I2C=y
CONFIG_TCS3414=y
CONFIG_TCS3472=y
CONFIG_SENSORS_TSL2563=y
# CONFIG_TSL2583 is not set
CONFIG_TSL4531=y
# CONFIG_US5182D is not set
CONFIG_VCNL4000=y
# CONFIG_VEML6070 is not set
# CONFIG_VL6180 is not set
CONFIG_ZOPT2201=y

#
# Magnetometer sensors
#
CONFIG_AK8974=y
CONFIG_AK8975=y
CONFIG_AK09911=y
CONFIG_BMC150_MAGN=y
CONFIG_BMC150_MAGN_I2C=y
CONFIG_MAG3110=y
# CONFIG_MMC35240 is not set
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
# CONFIG_IIO_HRTIMER_TRIGGER is not set
# CONFIG_IIO_INTERRUPT_TRIGGER is not set
# CONFIG_IIO_TIGHTLOOP_TRIGGER is not set
CONFIG_IIO_SYSFS_TRIGGER=y

#
# Digital potentiometers
#
# CONFIG_DS1803 is not set
CONFIG_MCP4531=y
CONFIG_TPL0102=y

#
# Digital potentiostats
#
CONFIG_LMP91000=y

#
# Pressure sensors
#
CONFIG_ABP060MG=y
CONFIG_BMP280=y
CONFIG_BMP280_I2C=y
CONFIG_HP03=y
CONFIG_MPL115=y
CONFIG_MPL115_I2C=y
CONFIG_MPL3115=y
# CONFIG_MS5611 is not set
# CONFIG_MS5637 is not set
CONFIG_IIO_ST_PRESS=y
CONFIG_IIO_ST_PRESS_I2C=y
CONFIG_T5403=y
CONFIG_HP206C=y
CONFIG_ZPA2326=y
CONFIG_ZPA2326_I2C=y

#
# Lightning sensors
#

#
# Proximity and distance sensors
#
CONFIG_LIDAR_LITE_V2=y
# CONFIG_RFD77402 is not set
# CONFIG_SRF04 is not set
# CONFIG_SX9500 is not set
CONFIG_SRF08=y

#
# Temperature sensors
#
CONFIG_MLX90614=y
CONFIG_TMP006=y
# CONFIG_TMP007 is not set
CONFIG_TSYS01=y
CONFIG_TSYS02D=y
# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_FSL_FTM=y
# CONFIG_PWM_LP3943 is not set
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
CONFIG_PWM_PCA9685=y
# CONFIG_PWM_STMPE is not set
CONFIG_PWM_TWL=y
# CONFIG_PWM_TWL_LED is not set

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
CONFIG_ARM_GIC_MAX_NR=1
# CONFIG_ARM_GIC_V3_ITS is not set
CONFIG_IPACK_BUS=y
# CONFIG_BOARD_TPCI200 is not set
# CONFIG_SERIAL_IPOCTAL is not set
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
CONFIG_FMC_FAKEDEV=y
# CONFIG_FMC_TRIVIAL is not set
CONFIG_FMC_WRITE_EEPROM=y
CONFIG_FMC_CHARDEV=y

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_BCM_KONA_USB2_PHY=y
# CONFIG_PHY_PXA_28NM_HSIC is not set
CONFIG_PHY_PXA_28NM_USB2=y
# CONFIG_PHY_CPCAP_USB is not set
# CONFIG_POWERCAP is not set
CONFIG_MCB=y
# CONFIG_MCB_PCI is not set
CONFIG_MCB_LPC=y

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
CONFIG_DEV_DAX=y
CONFIG_NVMEM=y
CONFIG_STM=y
CONFIG_STM_DUMMY=y
CONFIG_STM_SOURCE_CONSOLE=y
CONFIG_STM_SOURCE_HEARTBEAT=y
CONFIG_INTEL_TH=y
# CONFIG_INTEL_TH_PCI is not set
CONFIG_INTEL_TH_GTH=y
# CONFIG_INTEL_TH_STH is not set
# CONFIG_INTEL_TH_MSU is not set
# CONFIG_INTEL_TH_PTI is not set
CONFIG_INTEL_TH_DEBUG=y
# CONFIG_FPGA is not set
CONFIG_FSI=y
CONFIG_FSI_MASTER_GPIO=y
# CONFIG_FSI_MASTER_HUB is not set
CONFIG_FSI_SCOM=y
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=y
CONFIG_MUX_GPIO=y
CONFIG_MUX_MMIO=y
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set

#
# Firmware Drivers
#
# CONFIG_EDD is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DELL_RBU=y
# CONFIG_DCDBAS is not set
CONFIG_DMIID=y
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
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
# CONFIG_EXT2_FS_POSIX_ACL is not set
CONFIG_EXT2_FS_SECURITY=y
CONFIG_EXT3_FS=y
# CONFIG_EXT3_FS_POSIX_ACL is not set
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_EXT4_FS=y
# CONFIG_EXT4_FS_POSIX_ACL is not set
CONFIG_EXT4_FS_SECURITY=y
CONFIG_EXT4_ENCRYPTION=y
CONFIG_EXT4_FS_ENCRYPTION=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_REISERFS_FS_XATTR is not set
# CONFIG_JFS_FS is not set
CONFIG_OCFS2_FS=y
CONFIG_OCFS2_FS_O2CB=y
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=y
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=y
# CONFIG_BTRFS_FS_POSIX_ACL is not set
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
CONFIG_BTRFS_DEBUG=y
CONFIG_BTRFS_ASSERT=y
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
# CONFIG_F2FS_FS is not set
CONFIG_FS_DAX=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
CONFIG_QFMT_V1=y
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
# CONFIG_FUSE_FS is not set
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
CONFIG_FSCACHE=y
# CONFIG_FSCACHE_STATS is not set
# CONFIG_FSCACHE_HISTOGRAM is not set
CONFIG_FSCACHE_DEBUG=y
# CONFIG_FSCACHE_OBJECT_LIST is not set
# CONFIG_CACHEFILES is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
# CONFIG_JOLIET is not set
CONFIG_ZISOFS=y
CONFIG_UDF_FS=y
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_NTFS_FS is not set

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
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_CONFIGFS_FS=y
# CONFIG_MISC_FILESYSTEMS is not set
# CONFIG_NETWORK_FILESYSTEMS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
CONFIG_NLS_CODEPAGE_737=y
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=y
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
CONFIG_NLS_CODEPAGE_862=y
CONFIG_NLS_CODEPAGE_863=y
CONFIG_NLS_CODEPAGE_864=y
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
CONFIG_NLS_CODEPAGE_869=y
# CONFIG_NLS_CODEPAGE_936 is not set
CONFIG_NLS_CODEPAGE_950=y
# CONFIG_NLS_CODEPAGE_932 is not set
CONFIG_NLS_CODEPAGE_949=y
CONFIG_NLS_CODEPAGE_874=y
CONFIG_NLS_ISO8859_8=y
# CONFIG_NLS_CODEPAGE_1250 is not set
CONFIG_NLS_CODEPAGE_1251=y
# CONFIG_NLS_ASCII is not set
# CONFIG_NLS_ISO8859_1 is not set
CONFIG_NLS_ISO8859_2=y
CONFIG_NLS_ISO8859_3=y
CONFIG_NLS_ISO8859_4=y
CONFIG_NLS_ISO8859_5=y
# CONFIG_NLS_ISO8859_6 is not set
CONFIG_NLS_ISO8859_7=y
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
CONFIG_NLS_KOI8_R=y
CONFIG_NLS_KOI8_U=y
CONFIG_NLS_MAC_ROMAN=y
CONFIG_NLS_MAC_CELTIC=y
CONFIG_NLS_MAC_CENTEURO=y
CONFIG_NLS_MAC_CROATIAN=y
# CONFIG_NLS_MAC_CYRILLIC is not set
CONFIG_NLS_MAC_GAELIC=y
CONFIG_NLS_MAC_GREEK=y
CONFIG_NLS_MAC_ICELAND=y
# CONFIG_NLS_MAC_INUIT is not set
CONFIG_NLS_MAC_ROMANIAN=y
CONFIG_NLS_MAC_TURKISH=y
CONFIG_NLS_UTF8=y
CONFIG_DLM=y
# CONFIG_DLM_DEBUG is not set

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
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=1024
CONFIG_STRIP_ASM_SYMS=y
CONFIG_READABLE_ASM=y
CONFIG_UNUSED_SYMBOLS=y
# CONFIG_PAGE_OWNER is not set
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
# CONFIG_DEBUG_SECTION_MISMATCH is not set
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
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
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
# CONFIG_DEBUG_OBJECTS is not set
CONFIG_DEBUG_SLAB=y
# CONFIG_DEBUG_SLAB_LEAK is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_STACK_USAGE=y
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_VIRTUAL=y
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
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
# CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=0
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=1
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
CONFIG_BOOTPARAM_HUNG_TASK_PANIC=y
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=1
# CONFIG_WQ_WATCHDOG is not set
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
CONFIG_SCHED_STACK_END_CHECK=y
# CONFIG_DEBUG_TIMEKEEPING is not set

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
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_WW_MUTEX_SELFTEST is not set
CONFIG_TRACE_IRQFLAGS=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PI_LIST is not set
CONFIG_DEBUG_SG=y
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
CONFIG_TORTURE_TEST=y
# CONFIG_RCU_PERF_TEST is not set
CONFIG_RCU_TORTURE_TEST=y
CONFIG_RCU_CPU_STALL_TIMEOUT=21
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
CONFIG_CPU_HOTPLUG_STATE_CONTROL=y
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
# CONFIG_FAULT_INJECTION is not set
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
# CONFIG_FUNCTION_TRACER is not set
CONFIG_IRQSOFF_TRACER=y
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_FTRACE_SYSCALLS is not set
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_PROFILE_ALL_BRANCHES is not set
# CONFIG_STACK_TRACER is not set
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_PROBE_EVENTS=y
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_MMIOTRACE is not set
# CONFIG_HIST_TRIGGERS is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=y
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
CONFIG_TRACING_EVENTS_GPIO=y
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_RUNTIME_TESTING_MENU is not set
CONFIG_MEMTEST=y
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
# CONFIG_EARLY_PRINTK is not set
CONFIG_X86_PTDUMP_CORE=y
CONFIG_X86_PTDUMP=y
CONFIG_DEBUG_WX=y
CONFIG_DOUBLEFAULT=y
CONFIG_DEBUG_TLBFLUSH=y
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
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_OPTIMIZE_INLINING is not set
# CONFIG_DEBUG_ENTRY is not set
CONFIG_DEBUG_NMI_SELFTEST=y
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_FRAME_POINTER=y
# CONFIG_UNWINDER_GUESS is not set

#
# Security options
#
CONFIG_KEYS=y
CONFIG_PERSISTENT_KEYRINGS=y
# CONFIG_BIG_KEYS is not set
# CONFIG_ENCRYPTED_KEYS is not set
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
# CONFIG_SECURITY is not set
# CONFIG_SECURITYFS is not set
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
# CONFIG_HARDENED_USERCOPY_FALLBACK is not set
CONFIG_HARDENED_USERCOPY_PAGESPAN=y
# CONFIG_FORTIFY_SOURCE is not set
# CONFIG_STATIC_USERMODEHELPER is not set
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
# CONFIG_CRYPTO_DH is not set
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
# CONFIG_CRYPTO_PCRYPT is not set
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=y
# CONFIG_CRYPTO_MCRYPTD is not set
CONFIG_CRYPTO_AUTHENC=y
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
CONFIG_CRYPTO_XCBC=y
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=y
# CONFIG_CRYPTO_CRC32 is not set
CONFIG_CRYPTO_CRC32_PCLMUL=y
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
# CONFIG_CRYPTO_RMD128 is not set
# CONFIG_CRYPTO_RMD160 is not set
CONFIG_CRYPTO_RMD256=y
# CONFIG_CRYPTO_RMD320 is not set
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
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_586=y
CONFIG_CRYPTO_AES_NI_INTEL=y
# CONFIG_CRYPTO_ANUBIS is not set
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
CONFIG_CRYPTO_SALSA20=y
CONFIG_CRYPTO_SALSA20_586=y
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_SEED=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_586=y
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
# CONFIG_CRYPTO_LZ4 is not set
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
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
# CONFIG_CRYPTO_USER_API_RNG is not set
CONFIG_CRYPTO_USER_API_AEAD=y
# CONFIG_CRYPTO_HW is not set
# CONFIG_ASYMMETRIC_KEY_TYPE is not set

#
# Certificates for signature checking
#
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
# CONFIG_VHOST_NET is not set
# CONFIG_VHOST_VSOCK is not set
CONFIG_VHOST_CROSS_ENDIAN_LEGACY=y
CONFIG_BINARY_PRINTF=y

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
CONFIG_CRC32_SLICEBY4=y
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC4=y
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
CONFIG_AUDIT_GENERIC=y
# CONFIG_AUDIT_ARCH_COMPAT_GENERIC is not set
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
# CONFIG_XZ_DEC_X86 is not set
# CONFIG_XZ_DEC_POWERPC is not set
CONFIG_XZ_DEC_IA64=y
# CONFIG_XZ_DEC_ARM is not set
# CONFIG_XZ_DEC_ARMTHUMB is not set
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=y
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=y
CONFIG_REED_SOLOMON_DEC16=y
CONFIG_BCH=y
CONFIG_BCH_CONST_PARAMS=y
CONFIG_RADIX_TREE_MULTIORDER=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_SGL_ALLOC=y
# CONFIG_DMA_DIRECT_OPS is not set
# CONFIG_DMA_VIRT_OPS is not set
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_CORDIC=y
CONFIG_DDR=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
# CONFIG_SG_SPLIT is not set
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_SBITMAP=y
CONFIG_PRIME_NUMBERS=y
# CONFIG_STRING_SELFTEST is not set

--=_5ac89839.QuAuK65/3XH6H+9kiCOlXwpsf6ZS5K1sJIOckn+W24XajxOY--
