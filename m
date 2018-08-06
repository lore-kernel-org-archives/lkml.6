Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D628AC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 00:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CFF72192C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 00:55:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CFF72192C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbeHFDCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 23:02:11 -0400
Received: from mga18.intel.com ([134.134.136.126]:53621 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726947AbeHFDCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 23:02:11 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2018 17:55:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,450,1526367600"; 
   d="gz'50?scan'50,208,50";a="222139782"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.4])
  by orsmga004.jf.intel.com with ESMTP; 05 Aug 2018 17:55:32 -0700
Date:   Mon, 6 Aug 2018 08:56:07 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, LKP <lkp@01.org>
Subject: [LKP] ace45bec6d [ 40.028987] watchdog: BUG: soft lockup - CPU#0
 stuck for 23s! [kworker/0:1:23]
Message-ID: <20180806005607.GB18936@shao2-debian>
Reply-To: kernel test robot <lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="kXdP64Ggrk/fb43R"
Content-Disposition: inline
User-Agent: Heirloom mailx 12.5 6/20/10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kXdP64Ggrk/fb43R
Content-Type: text/plain; charset=utf-8
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
0b5b1f9a78  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm
116b181bb6  Add linux-next specific files for 20180803
+------------------------------------------------+------------+------------+------------+---------------+
|                                                | c0b6edef0b | ace45bec6d | 0b5b1f9a78 | next-20180803 |
+------------------------------------------------+------------+------------+------------+---------------+
| boot_successes                                 | 214        | 47         | 63         | 37            |
| boot_failures                                  | 4          | 35         | 25         | 16            |
| Mem-Info                                       | 4          | 3          | 1          |               |
| BUG:soft_lockup-CPU##stuck_for#s               | 0          | 32         | 23         | 16            |
| EIP:lock_acquire                               | 0          | 13         | 12         | 5             |
| Kernel_panic-not_syncing:softlockup:hung_tasks | 0          | 32         | 24         | 16            |
| EIP:lock_acquired                              | 0          | 2          | 2          | 1             |
| EIP:lock_release                               | 0          | 12         | 9          | 6             |
| EIP:do_raw_spin_trylock                        | 0          | 3          |            |               |
| EIP:do_raw_spin_unlock                         | 0          | 1          |            |               |
| EIP:__local_bh_enable_ip                       | 0          | 1          |            |               |
| EIP:rxrpc_peer_keepalive_worker                | 0          | 0          | 1          | 1             |
| EIP:do_softirq                                 | 0          | 0          | 0          | 2             |
| EIP:_raw_spin_lock_bh                          | 0          | 0          | 0          | 1             |
+------------------------------------------------+------------+------------+------------+---------------+

01 00 00 00 68 00 00 00 06 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 05 00 00 00 00 00 00 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
[   13.490790] warning: process `trinity-c3' used the obsolete bdflush system call
[   13.492039] Fix your initscripts?
[   14.538595] warning: process `trinity-c2' used the obsolete bdflush system call
[   14.539733] Fix your initscripts?
[   40.028987] watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [kworker/0:1:23]
[   40.031637] Modules linked in:
[   40.032105] CPU: 0 PID: 23 Comm: kworker/0:1 Not tainted 4.16.0-rc6-02064-gace45be #1
[   40.033238] Workqueue: krxrpcd rxrpc_peer_keepalive_worker
[   40.034043] EIP: lock_acquire+0x69/0x80
[   40.034603] EFLAGS: 00000246 CPU: 0
[   40.035121] EAX: 00000246 EBX: 781db580 ECX: 4e69a837 EDX: 00000000
[   40.036030] ESI: 860b3200 EDI: 00000000 EBP: 781f7e8c ESP: 781f7e64
[   40.036940]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
[   40.037725] CR0: 80050033 CR2: 6f8429c0 CR3: 09435000 CR4: 00140690
[   40.038629] DR0: 6ec96000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[   40.039696] DR6: ffff0ff0 DR7: 00000600
[   40.040261] Call Trace:
[   40.040633]  ? rxrpc_peer_keepalive_worker+0x5e/0x350
[   40.041374]  ? _raw_spin_lock_bh+0x29/0x60
[   40.041983]  ? rxrpc_peer_keepalive_worker+0x5e/0x350
[   40.042727]  ? rxrpc_peer_keepalive_worker+0x5e/0x350
[   40.043461]  ? __lock_acquire+0x3d3/0x870
[   40.044158]  ? process_one_work+0x110/0x340
[   40.044779]  ? process_one_work+0x166/0x340
[   40.045390]  ? process_one_work+0x110/0x340
[   40.046013]  ? worker_thread+0x39/0x3c0
[   40.046578]  ? kthread+0xdb/0x110
[   40.047073]  ? cancel_delayed_work+0x90/0x90
[   40.047700]  ? kthread_stop+0x70/0x70
[   40.048240]  ? ret_from_fork+0x19/0x24
[   40.048806] Code: 75 14 ff 75 10 8b 45 f0 c1 e8 09 83 f0 01 83 e0 01 50 ff 75 08 89 f0 e8 d6 ef ff ff c7 83 48 15 00 00 00 00 00 00 8b 45 f0 50 9d <8d> 74 26 00 83 c4 18 8d 65 f4 5b 5e 5f 5d c3 90 8d b4 26 00 00
[   40.051620] Kernel panic - not syncing: softlockup: hung tasks
[   40.052473] CPU: 0 PID: 23 Comm: kworker/0:1 Tainted: G             L   4.16.0-rc6-02064-gace45be #1
[   40.053822] Workqueue: krxrpcd rxrpc_peer_keepalive_worker
[   40.054722] Call Trace:
[   40.055116]  ? dump_stack+0x57/0x7e
[   40.055634]  ? panic+0x8d/0x1b7
[   40.056112]  ? watchdog_timer_fn+0x205/0x210
[   40.056743]  ? watchdog+0x20/0x20
[   40.057235]  ? __hrtimer_run_queues+0xf6/0x190
[   40.057898]  ? hrtimer_run_queues+0xd6/0x100
[   40.058525]  ? run_local_timers+0x15/0x40
[   40.059121]  ? update_process_times+0x1c/0x50
[   40.059765]  ? tick_nohz_handler+0x7c/0x110
[   40.060375]  ? smp_apic_timer_interrupt+0x43/0x80
[   40.061067]  ? apic_timer_interrupt+0x3c/0x44
[   40.061714]  ? lock_acquire+0x69/0x80
[   40.062251]  ? rxrpc_peer_keepalive_worker+0x5e/0x350
[   40.062996]  ? _raw_spin_lock_bh+0x29/0x60
[   40.063596]  ? rxrpc_peer_keepalive_worker+0x5e/0x350
[   40.064335]  ? rxrpc_peer_keepalive_worker+0x5e/0x350
[   40.065070]  ? __lock_acquire+0x3d3/0x870
[   40.065762]  ? process_one_work+0x110/0x340
[   40.066371]  ? process_one_work+0x166/0x340
[   40.066985]  ? process_one_work+0x110/0x340
[   40.067598]  ? worker_thread+0x39/0x3c0
[   40.069081]  ? kthread+0xdb/0x110
[   40.069568]  ? cancel_delayed_work+0x90/0x90
[   40.070205]  ? kthread_stop+0x70/0x70
[   40.070753]  ? ret_from_fork+0x19/0x24
[   40.071340] Kernel Offset: disabled


                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start v4.17 v4.16 --
git bisect  bad 83beed7b2b26f232d782127792dd0cd4362fdc41  # 01:43  B     25     1   14  14  Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal
git bisect  bad 8844a509863d7da41024194e40190ec00c2cd890  # 02:02  B     37     3   13  13  Merge branch 'misc.sparc' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs
git bisect  bad a8f8e8ac766ddb8702ef9baf01b7ae4f8d3a940c  # 02:13  B     11     1    3   3  Merge tag '4.17-SMB3-Fixes' of git://git.samba.org/sfrench/cifs-2.6
git bisect good 642e7fd23353e22290e3d51719fcb658dc252342  # 02:26  G     89     0   29  29  Merge branch 'syscalls-next' of git://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux
git bisect  bad 5bb053bef82523a8fd78d650bca81c9f114fa276  # 02:36  B     31     3   16  16  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next
git bisect good 3ac684b88148bf132fbf02a133cba9dcfb2e7aa2  # 02:51  G     89     0   28  28  Merge tag 'for-v4.17' of git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply
git bisect good 77624cd2a7783fccf2c518768a6fd7a7aeccd002  # 03:03  G     93     0   29  29  Merge tag 'pinctrl-v4.17-1' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl
git bisect good e40dc66220b7ff1b816311b135b9298f8ba14ce6  # 03:18  G     94     0   32  32  Merge tag 'leds_for_4.17-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/j.anaszewski/linux-leds
git bisect good bb2407a7219760926760f0448fddf00d625e5aec  # 03:34  G     94     0   26  26  Merge tag 'docs-4.17' of git://git.lwn.net/linux
git bisect good 489b30b53f0540b9f8e391cbb2839cea48b5d1c1  # 03:49  G     94     0   27  27  net: Convert l2tp_net_ops
git bisect good 038d49baab571800e3077b9d322a004f95c8aa8f  # 03:58  G     89     0   24  24  Merge branch 'Introduce-net_rwsem-to-protect-net_namespace_list'
git bisect good d162190bded8b3f635d1ba1e27e63d1b4a720ba8  # 04:09  G     92     0   27  27  Merge git://git.kernel.org/pub/scm/linux/kernel/git/pablo/nf-next
git bisect  bad 70ae7222c61d4f19c844c8fe75f053f8976b9552  # 04:22  B      4     1    2   2  Merge branch 'inet-frags-bring-rhashtables-to-IP-defrag'
git bisect  bad e2e80c027f5adab3cc44c3d07c4484291384d278  # 04:31  B      9     1    6   6  Merge tag 'rxrpc-next-20180330' of git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs
git bisect  bad 17226f1240381812c3a4927dc9da2814fb71c8ac  # 04:42  B     12     1    6   6  rxrpc: Fix leak of rxrpc_peer objects
git bisect good 6f14f49ce5eb00f533133df06c663fbaea13cd50  # 05:04  G     93     0   28  28  Merge branch 'ieee802154-for-davem-2018-03-29' of git://git.kernel.org/pub/scm/linux/kernel/git/sschmidt/wpan-next
git bisect  bad 59299aa1028fce051adbd25aaff7c387b865cd6d  # 05:20  B     21     2    7   7  rxrpc: Fix resend event time calculation
git bisect  bad ace45bec6d77bc061c3c3d8ad99e298ea9800c2b  # 05:28  B     10     1    8   8  rxrpc: Fix firewall route keepalive
git bisect good c0b6edef0bf0e33c12eaf80c676ff09def011518  # 05:40  G     90     0   29  29  tc-testing: Add newline when writing test case files
# first bad commit: [ace45bec6d77bc061c3c3d8ad99e298ea9800c2b] rxrpc: Fix firewall route keepalive
git bisect good c0b6edef0bf0e33c12eaf80c676ff09def011518  # 05:46  G    262     0   54  83  tc-testing: Add newline when writing test case files
# extra tests with debug options
git bisect  bad ace45bec6d77bc061c3c3d8ad99e298ea9800c2b  # 05:55  B     22     4   13  13  rxrpc: Fix firewall route keepalive
# extra tests on HEAD of linux-devel/devel-catchup-201808050031
git bisect  bad 1d4386204235d9ff3cbb610dbc8d92a3d8675aa6  # 05:56  B      4     4    0   4  0day head guard for 'devel-catchup-201808050031'
# extra tests on tree/branch linus/master
git bisect  bad 0b5b1f9a78b5e1bb3c3972fcd27dc013367550f8  # 06:05  B      2     1    2   2  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm
# extra tests on tree/branch linux-next/master
git bisect  bad 116b181bb646afedd770985de20a68721bdb2648  # 06:20  B     27     3   12  12  Add linux-next specific files for 20180803

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/lkp                          Intel Corporation

--kXdP64Ggrk/fb43R
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-yocto-ivb41-101:20180805052833:i386-randconfig-b0-08050024:4.16.0-rc6-02064-gace45be:1.gz"
Content-Transfer-Encoding: base64

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
5cd//uc7oSmOE/RMXX35Mz0e/BfA+GFVg6gAAA==

--kXdP64Ggrk/fb43R
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-yocto-ivb41-100:20180805053717:i386-randconfig-b0-08050024:4.16.0-rc6-02063-gc0b6ede:1.gz"
Content-Transfer-Encoding: base64

H4sICJMmZlsAA2RtZXNnLXlvY3RvLWl2YjQxLTEwMDoyMDE4MDgwNTA1MzcxNzppMzg2LXJh
bmRjb25maWctYjAtMDgwNTAwMjQ6NC4xNi4wLXJjNi0wMjA2My1nYzBiNmVkZToxAKxbaXPb
ONL+/O6v6N39EOUtSyZ4idSWttaHEqts2RrLmZndVEpFkaDMMUVyePhI7Y/fboCUKJHykdhV
iXh0P2gAjb4AcicNn8CNoywOOQQRZDwvEnzg8b9M03gRREsYnZ5Ch3veMPZ9yGPwgsxZhPxj
r9eD+O4vXwH/lJ4i/r7BRRAVj3DP0yyII9B7zOwp3dQ1u4qqmFp36SoLk3scOneLIgi9f4V3
Sfc2e1TUj9BZum6N0+7p0Dnli8Ap77rqx4/wdwazyRRmRQRHxRIMUIyBpg1UFU5mN6AqzNqV
6Hx0fTm6gKxIkjjNuQduUmSDXSqAo8kpQua3PMoDF2+aFDepE2UrnjvwmUdFEPGbyaNlPke3
vjqZftmlw0cD7G7kxek88OBDiTmOch5+gCK6i+KH6ACKjCZhySOeBi5OUZD3WpH+HRcpZE9Z
zlewcp5gwREjy2mqGgwo9aGfFAMcRjEo1MLvs6NfR+BzJy9SDsqjorABfHi0+uCHsSNIkjiI
ckj5MsBW0uzDj8GqCDubjX4aR0eco19/fw3OI45DzueowKjfX9VvAwCjbx5Uz7PgO8/kY9Vo
zOcaZRTRYHolVyVLhsL0D2gN5fwxB8KCIANLU2HxlPOsmsEPyBV5Tup9AD9OV05zGrmlKgM4
Hl/Nukka3wcetpXcPmWB64RwfTTBaU0aeivIJefXFU49jcz2X3frke0vfP8bykR9eROY7btN
MJ/AcBB4es+9N8H5Tdn8H4djja76vsf8H+oqcqoNsB+Wzec+DVwdjh79MJxE24J7UTqPL4rl
AIJlFKeki2G8DPk9D8nc0+pqqOJljDaQD+Dyd+iMHrlboL6flnYfUDlz7uZkpV0niuKcbA2X
i2MAURx1p0cjuONpxMO/7iKfPSUoYpDFKUpFMMRz/uukfTEUiUdLbWcMqr7XpheGw3/u7b7E
Svkqvq9jORuscvzaVUWyh06WzxM/giFyk4rgcnycO6l7u34qlbDNfkyPbgZwEkd+sCxSRwzd
V6XbR4vz2zHAbzcAX066+A8a97toMxxyMiDCC6LD3jM0Gnbn9ay1pS2X9OtZa8vYb2X14yLy
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

--kXdP64Ggrk/fb43R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reproduce-yocto-ivb41-101:20180805052833:i386-randconfig-b0-08050024:4.16.0-rc6-02064-gace45be:1"

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

--kXdP64Ggrk/fb43R
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
CONFIG_CONSTRUCTORS=y
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
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_CROSS_MEMORY_ATTACH is not set
# CONFIG_USELIB is not set
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
CONFIG_IRQ_TIME_ACCOUNTING=y
# CONFIG_BSD_PROCESS_ACCT is not set
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
# CONFIG_RCU_FAST_NO_HZ is not set
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
# CONFIG_MEMCG is not set
# CONFIG_BLK_CGROUP is not set
# CONFIG_CGROUP_SCHED is not set
# CONFIG_CGROUP_PIDS is not set
# CONFIG_CGROUP_RDMA is not set
# CONFIG_CGROUP_FREEZER is not set
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
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_SYSCTL_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
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
# CONFIG_EVENTFD is not set
CONFIG_SHMEM=y
# CONFIG_AIO is not set
# CONFIG_ADVISE_SYSCALLS is not set
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
# CONFIG_PC104 is not set

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
# CONFIG_SLAB_MERGE_DEFAULT is not set
# CONFIG_SLAB_FREELIST_RANDOM is not set
CONFIG_SLAB_FREELIST_HARDENED=y
CONFIG_SLUB_CPU_PARTIAL=y
# CONFIG_SYSTEM_DATA_VERIFICATION is not set
CONFIG_PROFILING=y
# CONFIG_OPROFILE is not set
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_KPROBES=y
# CONFIG_JUMP_LABEL is not set
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
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_CYC_COMPLEXITY is not set
CONFIG_GCC_PLUGIN_LATENT_ENTROPY=y
CONFIG_GCC_PLUGIN_STRUCTLEAK=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_VERBOSE is not set
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
CONFIG_GCOV_KERNEL=y
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# CONFIG_GCOV_PROFILE_ALL is not set
CONFIG_GCOV_FORMAT_AUTODETECT=y
# CONFIG_GCOV_FORMAT_3_4 is not set
# CONFIG_GCOV_FORMAT_4_7 is not set
CONFIG_HAVE_GENERIC_DMA_COHERENT=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_MODVERSIONS=y
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_LBDAF=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_ZONED=y
# CONFIG_BLK_CMDLINE_PARSER is not set
# CONFIG_BLK_WBT is not set
CONFIG_BLK_DEBUG_FS=y
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
# CONFIG_IOSCHED_CFQ is not set
CONFIG_DEFAULT_NOOP=y
CONFIG_DEFAULT_IOSCHED="noop"
CONFIG_MQ_IOSCHED_DEADLINE=y
# CONFIG_MQ_IOSCHED_KYBER is not set
# CONFIG_IOSCHED_BFQ is not set
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
# CONFIG_X86_BIGSMP is not set
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
# CONFIG_IOSF_MBI is not set
CONFIG_X86_RDC321X=y
# CONFIG_X86_32_NON_STANDARD is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
CONFIG_X86_32_IRIS=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
# CONFIG_QUEUED_LOCK_STAT is not set
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
CONFIG_X86_GENERIC=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
# CONFIG_X86_PPRO_FENCE is not set
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=6
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_PROCESSOR_SELECT=y
# CONFIG_CPU_SUP_INTEL is not set
# CONFIG_CPU_SUP_CYRIX_32 is not set
CONFIG_CPU_SUP_AMD=y
# CONFIG_CPU_SUP_CENTAUR is not set
CONFIG_CPU_SUP_TRANSMETA_32=y
# CONFIG_CPU_SUP_UMC_32 is not set
CONFIG_HPET_TIMER=y
# CONFIG_DMI is not set
CONFIG_NR_CPUS_RANGE_BEGIN=2
CONFIG_NR_CPUS_RANGE_END=8
CONFIG_NR_CPUS_DEFAULT=8
CONFIG_NR_CPUS=8
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
# CONFIG_X86_MCE_INTEL is not set
CONFIG_X86_MCE_AMD=y
CONFIG_X86_ANCIENT_MCE=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_AMD_POWER=y
CONFIG_X86_LEGACY_VM86=y
CONFIG_VM86=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
CONFIG_X86_REBOOTFIXUPS=y
CONFIG_MICROCODE=y
# CONFIG_MICROCODE_INTEL is not set
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
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
CONFIG_MEMORY_ISOLATION=y
# CONFIG_HAVE_BOOTMEM_INFO_NODE is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
# CONFIG_COMPACTION is not set
# CONFIG_PHYS_ADDR_T_64BIT is not set
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=y
# CONFIG_TRANSPARENT_HUGEPAGE is not set
# CONFIG_ARCH_WANTS_THP_SWAP is not set
# CONFIG_CLEANCACHE is not set
CONFIG_FRONTSWAP=y
# CONFIG_CMA is not set
# CONFIG_ZSWAP is not set
CONFIG_ZPOOL=m
# CONFIG_ZBUD is not set
# CONFIG_Z3FOLD is not set
# CONFIG_ZSMALLOC is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_PERCPU_STATS=y
# CONFIG_GUP_BENCHMARK is not set
CONFIG_HIGHPTE=y
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_X86_RESERVE_LOW=64
# CONFIG_MTRR is not set
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
# CONFIG_EFI is not set
# CONFIG_SECCOMP is not set
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
# CONFIG_SCHED_HRTICK is not set
# CONFIG_KEXEC is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
CONFIG_DEBUG_HOTPLUG_CPU0=y
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
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
CONFIG_PM_AUTOSLEEP=y
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
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
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
CONFIG_ISA_BUS=y
CONFIG_ISA_DMA_API=y
CONFIG_ISA=y
CONFIG_EISA=y
# CONFIG_EISA_VLB_PRIMING is not set
CONFIG_EISA_PCI_EISA=y
# CONFIG_EISA_VIRTUAL_ROOT is not set
CONFIG_EISA_NAMES=y
CONFIG_SCx200=m
CONFIG_SCx200HR_TIMER=m
# CONFIG_OLPC is not set
CONFIG_ALIX=y
CONFIG_NET5501=y
CONFIG_AMD_NB=y
CONFIG_PCCARD=y
CONFIG_PCMCIA=y
# CONFIG_PCMCIA_LOAD_CIS is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
# CONFIG_YENTA is not set
# CONFIG_PD6729 is not set
# CONFIG_I82092 is not set
CONFIG_I82365=m
CONFIG_TCIC=y
CONFIG_PCMCIA_PROBE=y
CONFIG_PCCARD_NONSTATIC=y
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
CONFIG_NET=y

#
# Networking options
#
# CONFIG_PACKET is not set
CONFIG_UNIX=y
# CONFIG_UNIX_DIAG is not set
CONFIG_TLS=m
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
# CONFIG_XFRM_STATISTICS is not set
CONFIG_XFRM_IPCOMP=y
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
# CONFIG_IP_MULTIPLE_TABLES is not set
# CONFIG_IP_ROUTE_MULTIPATH is not set
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=y
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
CONFIG_IP_MROUTE_COMMON=y
# CONFIG_IP_MROUTE is not set
# CONFIG_SYN_COOKIES is not set
CONFIG_NET_UDP_TUNNEL=y
CONFIG_NET_FOU=y
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=y
CONFIG_INET_ESP_OFFLOAD=m
CONFIG_INET_IPCOMP=y
CONFIG_INET_XFRM_TUNNEL=y
CONFIG_INET_TUNNEL=y
# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
# CONFIG_INET_XFRM_MODE_TUNNEL is not set
CONFIG_INET_XFRM_MODE_BEET=m
# CONFIG_INET_DIAG is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=m
CONFIG_IPV6_ROUTER_PREF=y
# CONFIG_IPV6_ROUTE_INFO is not set
CONFIG_IPV6_OPTIMISTIC_DAD=y
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
CONFIG_IPV6_MIP6=m
# CONFIG_INET6_XFRM_TUNNEL is not set
CONFIG_INET6_TUNNEL=m
CONFIG_INET6_XFRM_MODE_TRANSPORT=m
CONFIG_INET6_XFRM_MODE_TUNNEL=m
# CONFIG_INET6_XFRM_MODE_BEET is not set
CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_FOU=m
CONFIG_IPV6_FOU_TUNNEL=m
# CONFIG_IPV6_MULTIPLE_TABLES is not set
CONFIG_IPV6_MROUTE=y
# CONFIG_IPV6_MROUTE_MULTIPLE_TABLES is not set
CONFIG_IPV6_PIMSM_V2=y
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
# CONFIG_NETFILTER is not set
CONFIG_IP_DCCP=y

#
# DCCP CCIDs Configuration
#
CONFIG_IP_DCCP_CCID2_DEBUG=y
# CONFIG_IP_DCCP_CCID3 is not set

#
# DCCP Kernel Hacking
#
CONFIG_IP_DCCP_DEBUG=y
CONFIG_IP_SCTP=m
CONFIG_SCTP_DBG_OBJCNT=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE=y
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
# CONFIG_RDS is not set
CONFIG_TIPC=y
# CONFIG_TIPC_MEDIA_UDP is not set
CONFIG_TIPC_DIAG=m
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
CONFIG_ATM_BR2684_IPFILTER=y
CONFIG_L2TP=m
# CONFIG_L2TP_DEBUGFS is not set
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=y
CONFIG_L2TP_ETH=y
CONFIG_STP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
CONFIG_DECNET=m
# CONFIG_DECNET_ROUTER is not set
CONFIG_LLC=y
CONFIG_LLC2=y
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
CONFIG_LAPB=y
CONFIG_PHONET=y
# CONFIG_6LOWPAN is not set
CONFIG_IEEE802154=y
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
# CONFIG_IEEE802154_SOCKET is not set
# CONFIG_MAC802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=y
CONFIG_BATMAN_ADV=m
CONFIG_BATMAN_ADV_BATMAN_V=y
CONFIG_BATMAN_ADV_BLA=y
CONFIG_BATMAN_ADV_DAT=y
# CONFIG_BATMAN_ADV_NC is not set
# CONFIG_BATMAN_ADV_MCAST is not set
# CONFIG_BATMAN_ADV_DEBUGFS is not set
CONFIG_OPENVSWITCH=y
# CONFIG_VSOCKETS is not set
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_MPLS_ROUTING=y
CONFIG_NET_NSH=y
CONFIG_HSR=m
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
CONFIG_NET_NCSI=y
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
# CONFIG_BPF_STREAM_PARSER is not set
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=y
# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
CONFIG_BT=m
CONFIG_BT_BREDR=y
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
# CONFIG_BT_BNEP_MC_FILTER is not set
# CONFIG_BT_BNEP_PROTO_FILTER is not set
# CONFIG_BT_HIDP is not set
CONFIG_BT_HS=y
CONFIG_BT_LE=y
CONFIG_BT_LEDS=y
CONFIG_BT_SELFTEST=y
CONFIG_BT_SELFTEST_ECDH=y
CONFIG_BT_SELFTEST_SMP=y
# CONFIG_BT_DEBUGFS is not set

#
# Bluetooth device drivers
#
# CONFIG_BT_HCIBTSDIO is not set
# CONFIG_BT_HCIUART is not set
CONFIG_BT_HCIDTL1=m
# CONFIG_BT_HCIBT3C is not set
CONFIG_BT_HCIBLUECARD=m
# CONFIG_BT_HCIBTUART is not set
CONFIG_BT_HCIVHCI=m
CONFIG_BT_MRVL=m
CONFIG_BT_MRVL_SDIO=m
# CONFIG_BT_WILINK is not set
CONFIG_AF_RXRPC=y
CONFIG_AF_RXRPC_INJECT_LOSS=y
# CONFIG_AF_RXRPC_DEBUG is not set
# CONFIG_RXKAD is not set
CONFIG_AF_KCM=y
CONFIG_STREAM_PARSER=y
CONFIG_WIRELESS=y
CONFIG_WIRELESS_EXT=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_WEXT_PRIV=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
CONFIG_CFG80211_DEVELOPER_WARNINGS=y
CONFIG_CFG80211_CERTIFICATION_ONUS=y
# CONFIG_CFG80211_REQUIRE_SIGNED_REGDB is not set
# CONFIG_CFG80211_REG_CELLULAR_HINTS is not set
CONFIG_CFG80211_REG_RELAX_NO_IR=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
# CONFIG_CFG80211_CRDA_SUPPORT is not set
CONFIG_CFG80211_WEXT=y
# CONFIG_LIB80211 is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_MINSTREL_HT=y
CONFIG_MAC80211_RC_MINSTREL_VHT=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
CONFIG_MAC80211_MESH=y
# CONFIG_MAC80211_LEDS is not set
# CONFIG_MAC80211_DEBUGFS is not set
# CONFIG_MAC80211_MESSAGE_TRACING is not set
CONFIG_MAC80211_DEBUG_MENU=y
# CONFIG_MAC80211_NOINLINE is not set
# CONFIG_MAC80211_VERBOSE_DEBUG is not set
CONFIG_MAC80211_MLME_DEBUG=y
CONFIG_MAC80211_STA_DEBUG=y
# CONFIG_MAC80211_HT_DEBUG is not set
# CONFIG_MAC80211_OCB_DEBUG is not set
CONFIG_MAC80211_IBSS_DEBUG=y
# CONFIG_MAC80211_PS_DEBUG is not set
# CONFIG_MAC80211_MPL_DEBUG is not set
CONFIG_MAC80211_MPATH_DEBUG=y
CONFIG_MAC80211_MHWMP_DEBUG=y
# CONFIG_MAC80211_MESH_SYNC_DEBUG is not set
CONFIG_MAC80211_MESH_CSA_DEBUG=y
# CONFIG_MAC80211_MESH_PS_DEBUG is not set
CONFIG_MAC80211_TDLS_DEBUG=y
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_WIMAX=m
CONFIG_WIMAX_DEBUG_LEVEL=8
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
# CONFIG_RFKILL_INPUT is not set
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=m
CONFIG_NET_9P_VIRTIO=m
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
CONFIG_CEPH_LIB_PRETTYDEBUG=y
# CONFIG_CEPH_LIB_USE_DNS_RESOLVER is not set
CONFIG_NFC=m
CONFIG_NFC_DIGITAL=m
# CONFIG_NFC_NCI is not set
# CONFIG_NFC_HCI is not set

#
# Near Field Communication (NFC) devices
#
CONFIG_NFC_SIM=m
CONFIG_NFC_PN533=m
CONFIG_NFC_PN533_I2C=m
CONFIG_PSAMPLE=m
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
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
CONFIG_WANT_DEV_COREDUMP=y
# CONFIG_ALLOW_DEV_COREDUMP is not set
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_DEVRES=y
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
# CONFIG_SYS_HYPERVISOR is not set
# CONFIG_GENERIC_CPU_DEVICES is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
# CONFIG_DMA_SHARED_BUFFER is not set

#
# Bus devices
#
# CONFIG_CONNECTOR is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
CONFIG_PARPORT_PC_PCMCIA=m
# CONFIG_PARPORT_GSC is not set
CONFIG_PARPORT_AX88796=m
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
# CONFIG_ISAPNP is not set
CONFIG_PNPBIOS=y
CONFIG_PNPBIOS_PROC_FS=y
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
# CONFIG_BLK_DEV_NVME is not set
# CONFIG_NVME_MULTIPATH is not set
CONFIG_NVME_FABRICS=y
CONFIG_NVME_FC=m
CONFIG_NVME_TARGET=y
CONFIG_NVME_TARGET_LOOP=y
# CONFIG_NVME_TARGET_FC is not set

#
# Misc devices
#
# CONFIG_SENSORS_LIS3LV02D is not set
CONFIG_AD525X_DPOT=y
CONFIG_AD525X_DPOT_I2C=m
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_SGI_IOC4 is not set
# CONFIG_TIFM_CORE is not set
CONFIG_ICS932S401=m
CONFIG_ENCLOSURE_SERVICES=y
# CONFIG_HP_ILO is not set
CONFIG_APDS9802ALS=y
CONFIG_ISL29003=y
CONFIG_ISL29020=y
# CONFIG_SENSORS_TSL2550 is not set
# CONFIG_SENSORS_BH1770 is not set
CONFIG_SENSORS_APDS990X=y
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
# CONFIG_PCH_PHUB is not set
# CONFIG_USB_SWITCH_FSA9480 is not set
CONFIG_SRAM=y
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_MISC_RTSX is not set
CONFIG_C2PORT=y
# CONFIG_C2PORT_DURAMAR_2150 is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
CONFIG_EEPROM_LEGACY=m
# CONFIG_EEPROM_MAX6875 is not set
# CONFIG_EEPROM_93CX6 is not set
CONFIG_EEPROM_IDT_89HPESX=m
# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
CONFIG_TI_ST=m
# CONFIG_SENSORS_LIS3_I2C is not set
CONFIG_ALTERA_STAPL=m
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
CONFIG_IDE=y

#
# Please see Documentation/ide/ide.txt for help/info on IDE drives
#
CONFIG_IDE_XFER_MODE=y
CONFIG_IDE_TIMINGS=y
CONFIG_IDE_ATAPI=y
CONFIG_IDE_LEGACY=y
CONFIG_BLK_DEV_IDE_SATA=y
# CONFIG_IDE_GD is not set
# CONFIG_BLK_DEV_IDECS is not set
# CONFIG_BLK_DEV_DELKIN is not set
# CONFIG_BLK_DEV_IDECD is not set
CONFIG_BLK_DEV_IDETAPE=m
# CONFIG_BLK_DEV_IDEACPI is not set
CONFIG_IDE_TASK_IOCTL=y
CONFIG_IDE_PROC_FS=y

#
# IDE chipset support/bugfixes
#
# CONFIG_IDE_GENERIC is not set
# CONFIG_BLK_DEV_PLATFORM is not set
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPNP=y

#
# PCI IDE chipsets support
#
# CONFIG_BLK_DEV_GENERIC is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_CS5535 is not set
# CONFIG_BLK_DEV_CS5536 is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_JMICRON is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_IT8172 is not set
# CONFIG_BLK_DEV_IT8213 is not set
# CONFIG_BLK_DEV_IT821X is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_BLK_DEV_TC86C001 is not set

#
# Other IDE chipsets support
#

#
# Note: most of these also require special kernel boot parameters
#
# CONFIG_BLK_DEV_4DRIVES is not set
# CONFIG_BLK_DEV_ALI14XX is not set
# CONFIG_BLK_DEV_DTC2278 is not set
# CONFIG_BLK_DEV_HT6560B is not set
CONFIG_BLK_DEV_QD65XX=m
# CONFIG_BLK_DEV_UMC8672 is not set
# CONFIG_BLK_DEV_IDEDMA is not set

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
CONFIG_CHR_DEV_ST=y
CONFIG_CHR_DEV_OSST=m
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m
# CONFIG_SCSI_ENCLOSURE is not set
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
# CONFIG_SCSI_FC_ATTRS is not set
CONFIG_SCSI_ISCSI_ATTRS=y
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
# CONFIG_SCSI_SAS_ATA is not set
# CONFIG_SCSI_SAS_HOST_SMP is not set
# CONFIG_SCSI_SRP_ATTRS is not set
# CONFIG_SCSI_LOWLEVEL is not set
# CONFIG_SCSI_LOWLEVEL_PCMCIA is not set
# CONFIG_SCSI_DH is not set
CONFIG_SCSI_OSD_INITIATOR=m
# CONFIG_SCSI_OSD_ULD is not set
CONFIG_SCSI_OSD_DPRINT_SENSE=1
CONFIG_SCSI_OSD_DEBUG=y
CONFIG_ATA=y
# CONFIG_ATA_NONSTANDARD is not set
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
# CONFIG_SATA_AHCI is not set
# CONFIG_SATA_AHCI_PLATFORM is not set
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
# CONFIG_ATA_BMDMA is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
CONFIG_PATA_PCMCIA=m
CONFIG_PATA_PLATFORM=y
CONFIG_PATA_QDI=y
# CONFIG_PATA_RZ1000 is not set
CONFIG_PATA_WINBOND_VLB=y

#
# Generic fallback / legacy drivers
#
CONFIG_PATA_LEGACY=y
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
# CONFIG_MD_RAID0 is not set
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
# CONFIG_MD_RAID456 is not set
CONFIG_MD_MULTIPATH=m
# CONFIG_MD_FAULTY is not set
CONFIG_MD_CLUSTER=m
CONFIG_BCACHE=m
# CONFIG_BCACHE_DEBUG is not set
# CONFIG_BCACHE_CLOSURES_DEBUG is not set
# CONFIG_BLK_DEV_DM is not set
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
# CONFIG_TCM_PSCSI is not set
CONFIG_LOOPBACK_TARGET=m
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
# CONFIG_NET_CORE is not set
CONFIG_ARCNET=m
# CONFIG_ARCNET_1201 is not set
CONFIG_ARCNET_1051=m
CONFIG_ARCNET_RAW=m
# CONFIG_ARCNET_CAP is not set
CONFIG_ARCNET_COM90xx=m
CONFIG_ARCNET_COM90xxIO=m
# CONFIG_ARCNET_RIM_I is not set
CONFIG_ARCNET_COM20020=m
# CONFIG_ARCNET_COM20020_ISA is not set
# CONFIG_ARCNET_COM20020_PCI is not set
CONFIG_ARCNET_COM20020_CS=m
# CONFIG_ATM_DRIVERS is not set

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
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_LANCE is not set
# CONFIG_PCNET32 is not set
# CONFIG_PCMCIA_NMCLAN is not set
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
CONFIG_NET_VENDOR_CIRRUS=y
# CONFIG_CS89x0 is not set
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
CONFIG_NET_VENDOR_FUJITSU=y
# CONFIG_PCMCIA_FMVJ18X is not set
CONFIG_NET_VENDOR_HP=y
# CONFIG_HP100 is not set
CONFIG_NET_VENDOR_HUAWEI=y
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
# CONFIG_PCMCIA_AXNET is not set
# CONFIG_NE2000 is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_PCMCIA_PCNET is not set
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
CONFIG_FDDI=y
CONFIG_DEFXX=m
# CONFIG_DEFXX_MMIO is not set
# CONFIG_SKFP is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_MDIO_BITBANG=y
CONFIG_MDIO_GPIO=m
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set

#
# MII PHY device drivers
#
CONFIG_AMD_PHY=y
CONFIG_AQUANTIA_PHY=y
CONFIG_AT803X_PHY=m
CONFIG_BCM7XXX_PHY=y
# CONFIG_BCM87XX_PHY is not set
CONFIG_BCM_NET_PHYLIB=y
CONFIG_BROADCOM_PHY=y
# CONFIG_CICADA_PHY is not set
CONFIG_CORTINA_PHY=y
# CONFIG_DAVICOM_PHY is not set
CONFIG_DP83822_PHY=y
CONFIG_DP83848_PHY=y
CONFIG_DP83867_PHY=y
CONFIG_FIXED_PHY=m
CONFIG_ICPLUS_PHY=y
CONFIG_INTEL_XWAY_PHY=m
CONFIG_LSI_ET1011C_PHY=y
# CONFIG_LXT_PHY is not set
# CONFIG_MARVELL_PHY is not set
CONFIG_MARVELL_10G_PHY=m
CONFIG_MICREL_PHY=m
CONFIG_MICROCHIP_PHY=m
CONFIG_MICROSEMI_PHY=m
CONFIG_NATIONAL_PHY=m
CONFIG_QSEMI_PHY=y
# CONFIG_REALTEK_PHY is not set
CONFIG_RENESAS_PHY=m
CONFIG_ROCKCHIP_PHY=y
CONFIG_SMSC_PHY=y
CONFIG_STE10XP=y
CONFIG_TERANETICS_PHY=m
CONFIG_VITESSE_PHY=m
CONFIG_XILINX_GMII2RGMII=y
# CONFIG_PLIP is not set
CONFIG_PPP=y
CONFIG_PPP_BSDCOMP=m
CONFIG_PPP_DEFLATE=y
# CONFIG_PPP_FILTER is not set
CONFIG_PPP_MPPE=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPPOATM=m
CONFIG_PPPOE=m
# CONFIG_PPPOL2TP is not set
# CONFIG_PPP_ASYNC is not set
CONFIG_PPP_SYNC_TTY=y
CONFIG_SLIP=y
CONFIG_SLHC=y
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
CONFIG_SLIP_MODE_SLIP6=y

#
# Host-side USB support is needed for USB Network Adapter support
#
# CONFIG_WLAN is not set

#
# WiMAX Wireless Broadband devices
#

#
# Enable USB support to see WiMAX USB drivers
#
CONFIG_WAN=y
CONFIG_HOSTESS_SV11=m
# CONFIG_COSA is not set
# CONFIG_LANMEDIA is not set
CONFIG_SEALEVEL_4021=m
CONFIG_HDLC=m
CONFIG_HDLC_RAW=m
# CONFIG_HDLC_RAW_ETH is not set
CONFIG_HDLC_CISCO=m
# CONFIG_HDLC_FR is not set
CONFIG_HDLC_PPP=m
CONFIG_HDLC_X25=m
# CONFIG_PCI200SYN is not set
# CONFIG_WANXL is not set
# CONFIG_PC300TOO is not set
CONFIG_N2=m
# CONFIG_C101 is not set
# CONFIG_FARSYNC is not set
# CONFIG_DSCC4 is not set
CONFIG_DLCI=m
CONFIG_DLCI_MAX=8
# CONFIG_SDLA is not set
CONFIG_SBNI=m
CONFIG_SBNI_MULTILINE=y
# CONFIG_IEEE802154_DRIVERS is not set
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
# CONFIG_KEYBOARD_GOLDFISH_EVENTS is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_TWL4030 is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CROS_EC is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
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
CONFIG_SERIO_CT82C710=y
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
CONFIG_SERIO_PS2MULT=y
CONFIG_SERIO_ARC_PS2=m
# CONFIG_SERIO_GPIO_PS2 is not set
CONFIG_USERIO=m
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
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
CONFIG_CYCLADES=y
# CONFIG_CYZ_INTR is not set
CONFIG_MOXA_INTELLIO=y
CONFIG_MOXA_SMARTIO=m
# CONFIG_SYNCLINK is not set
# CONFIG_SYNCLINKMP is not set
# CONFIG_SYNCLINK_GT is not set
# CONFIG_NOZOMI is not set
# CONFIG_ISI is not set
# CONFIG_N_HDLC is not set
CONFIG_N_GSM=m
CONFIG_TRACE_ROUTER=y
CONFIG_TRACE_SINK=y
CONFIG_GOLDFISH_TTY=m
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set

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
# CONFIG_SERIAL_8250_CS is not set
CONFIG_SERIAL_8250_MEN_MCB=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_FSL is not set
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_8250_MOXA is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_UARTLITE=y
# CONFIG_SERIAL_UARTLITE_CONSOLE is not set
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_SERIAL_SCCNXP=y
# CONFIG_SERIAL_SCCNXP_CONSOLE is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_TIMBERDALE is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_PCH_UART is not set
CONFIG_SERIAL_ARC=y
CONFIG_SERIAL_ARC_CONSOLE=y
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
CONFIG_SERIAL_FSL_LPUART=m
# CONFIG_SERIAL_MEN_Z135 is not set
CONFIG_SERIAL_DEV_BUS=m
# CONFIG_TTY_PRINTK is not set
# CONFIG_PRINTER is not set
CONFIG_PPDEV=m
CONFIG_HVC_DRIVER=y
CONFIG_VIRTIO_CONSOLE=m
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_PROC_INTERFACE=y
CONFIG_IPMI_PANIC_EVENT=y
# CONFIG_IPMI_PANIC_STRING is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=y
# CONFIG_IPMI_WATCHDOG is not set
CONFIG_IPMI_POWEROFF=y
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=y
CONFIG_HW_RANDOM_AMD=y
CONFIG_HW_RANDOM_GEODE=y
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=m
# CONFIG_NVRAM is not set
# CONFIG_DTLK is not set
CONFIG_R3964=m
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
CONFIG_CARDMAN_4000=m
CONFIG_CARDMAN_4040=y
# CONFIG_SCR24X is not set
# CONFIG_IPWIRELESS is not set
CONFIG_MWAVE=y
CONFIG_SCx200_GPIO=m
# CONFIG_PC8736x_GPIO is not set
CONFIG_NSC_GPIO=m
# CONFIG_RAW_DRIVER is not set
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=m
CONFIG_TCG_TIS=m
CONFIG_TCG_TIS_I2C_ATMEL=y
CONFIG_TCG_TIS_I2C_INFINEON=y
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=y
# CONFIG_TCG_ATMEL is not set
# CONFIG_TCG_INFINEON is not set
# CONFIG_TCG_CRB is not set
CONFIG_TCG_VTPM_PROXY=y
CONFIG_TCG_TIS_ST33ZP24=y
CONFIG_TCG_TIS_ST33ZP24_I2C=y
CONFIG_TELCLOCK=m
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
CONFIG_I2C_MUX_GPIO=y
CONFIG_I2C_MUX_LTC4306=y
CONFIG_I2C_MUX_PCA9541=m
CONFIG_I2C_MUX_PCA954x=m
CONFIG_I2C_MUX_REG=y
# CONFIG_I2C_MUX_MLXCPLD is not set
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
CONFIG_I2C_KEMPLD=m
CONFIG_I2C_OCORES=m
CONFIG_I2C_PCA_PLATFORM=y
# CONFIG_I2C_PXA_PCI is not set
CONFIG_I2C_SIMTEC=y
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_PARPORT is not set
CONFIG_I2C_PARPORT_LIGHT=y
CONFIG_I2C_TAOS_EVM=y

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_PCA_ISA=y
# CONFIG_I2C_CROS_EC_TUNNEL is not set
# CONFIG_SCx200_ACB is not set
CONFIG_I2C_STUB=m
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=m
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_SPI is not set
# CONFIG_SPMI is not set
CONFIG_HSI=m
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
CONFIG_HSI_CHAR=m
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=y
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=m
CONFIG_DP83640_PHY=m
# CONFIG_PTP_1588_CLOCK_PCH is not set
CONFIG_PTP_1588_CLOCK_KVM=m
CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
CONFIG_DEBUG_PINCTRL=y
CONFIG_PINCTRL_AMD=y
CONFIG_PINCTRL_MCP23S08=m
CONFIG_PINCTRL_SX150X=y
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
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=m
CONFIG_GPIO_MAX730X=m

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_DWAPB=m
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
# CONFIG_GPIO_ICH is not set
# CONFIG_GPIO_LYNXPOINT is not set
CONFIG_GPIO_MB86S7X=y
CONFIG_GPIO_MENZ127=m
CONFIG_GPIO_MOCKUP=y
# CONFIG_GPIO_VX855 is not set

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_F7188X=y
CONFIG_GPIO_IT87=y
# CONFIG_GPIO_SCH is not set
CONFIG_GPIO_SCH311X=m
CONFIG_GPIO_WINBOND=y
CONFIG_GPIO_WS16C48=y

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=y
CONFIG_GPIO_ADP5588_IRQ=y
CONFIG_GPIO_MAX7300=m
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCF857X is not set
CONFIG_GPIO_TPIC2810=m

#
# MFD GPIO expanders
#
CONFIG_GPIO_ADP5520=y
# CONFIG_GPIO_DA9055 is not set
# CONFIG_GPIO_KEMPLD is not set
# CONFIG_GPIO_LP873X is not set
CONFIG_GPIO_PALMAS=y
# CONFIG_GPIO_RC5T583 is not set
CONFIG_GPIO_TPS65912=y
CONFIG_GPIO_TWL4030=m
CONFIG_GPIO_TWL6040=y
# CONFIG_GPIO_WM831X is not set
CONFIG_GPIO_WM8994=m

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
CONFIG_W1=m

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
CONFIG_W1_MASTER_DS2482=m
# CONFIG_W1_MASTER_DS1WM is not set
CONFIG_W1_MASTER_GPIO=m

#
# 1-wire Slaves
#
# CONFIG_W1_SLAVE_THERM is not set
CONFIG_W1_SLAVE_SMEM=m
# CONFIG_W1_SLAVE_DS2405 is not set
CONFIG_W1_SLAVE_DS2408=m
CONFIG_W1_SLAVE_DS2408_READBACK=y
CONFIG_W1_SLAVE_DS2413=m
CONFIG_W1_SLAVE_DS2406=m
# CONFIG_W1_SLAVE_DS2423 is not set
CONFIG_W1_SLAVE_DS2805=m
CONFIG_W1_SLAVE_DS2431=m
CONFIG_W1_SLAVE_DS2433=m
# CONFIG_W1_SLAVE_DS2433_CRC is not set
CONFIG_W1_SLAVE_DS2438=m
CONFIG_W1_SLAVE_DS2760=m
CONFIG_W1_SLAVE_DS2780=m
CONFIG_W1_SLAVE_DS2781=m
CONFIG_W1_SLAVE_DS28E04=m
# CONFIG_W1_SLAVE_DS28E17 is not set
CONFIG_POWER_AVS=y
# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_PDA_POWER is not set
# CONFIG_GENERIC_ADC_BATTERY is not set
# CONFIG_WM831X_BACKUP is not set
# CONFIG_WM831X_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_BATTERY_88PM860X is not set
# CONFIG_BATTERY_DS2760 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_CHARGER_AXP20X is not set
# CONFIG_BATTERY_AXP20X is not set
# CONFIG_AXP20X_POWER is not set
# CONFIG_AXP288_FUEL_GAUGE is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_BATTERY_MAX1721X is not set
# CONFIG_BATTERY_TWL4030_MADC is not set
# CONFIG_BATTERY_RX51 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_TWL4030 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_LP8788 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LTC3651 is not set
# CONFIG_CHARGER_MAX14577 is not set
# CONFIG_CHARGER_MAX77693 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24190 is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_SMB347 is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_BATTERY_GOLDFISH is not set
# CONFIG_CHARGER_RT9455 is not set
CONFIG_HWMON=m
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
# CONFIG_SENSORS_AD7414 is not set
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
# CONFIG_SENSORS_ADM1029 is not set
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM9240 is not set
# CONFIG_SENSORS_ADT7410 is not set
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
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_DS620 is not set
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=m
CONFIG_SENSORS_DA9055=m
# CONFIG_SENSORS_I5K_AMB is not set
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
# CONFIG_SENSORS_F75375S is not set
CONFIG_SENSORS_MC13783_ADC=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_GL518SM is not set
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
CONFIG_SENSORS_G762=m
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
# CONFIG_SENSORS_IBMPEX is not set
CONFIG_SENSORS_IIO_HWMON=m
# CONFIG_SENSORS_I5500 is not set
# CONFIG_SENSORS_CORETEMP is not set
CONFIG_SENSORS_IT87=m
# CONFIG_SENSORS_JC42 is not set
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
CONFIG_SENSORS_LTC2945=m
# CONFIG_SENSORS_LTC2990 is not set
CONFIG_SENSORS_LTC4151=m
# CONFIG_SENSORS_LTC4215 is not set
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
CONFIG_SENSORS_LTC4260=m
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX16065 is not set
# CONFIG_SENSORS_MAX1619 is not set
CONFIG_SENSORS_MAX1668=m
# CONFIG_SENSORS_MAX197 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
# CONFIG_SENSORS_MAX6650 is not set
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_TC654 is not set
CONFIG_SENSORS_MENF21BMC_HWMON=m
# CONFIG_SENSORS_LM63 is not set
CONFIG_SENSORS_LM73=m
# CONFIG_SENSORS_LM75 is not set
CONFIG_SENSORS_LM77=m
# CONFIG_SENSORS_LM78 is not set
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
# CONFIG_SENSORS_LM92 is not set
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NTC_THERMISTOR=m
CONFIG_SENSORS_NCT6683=m
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
# CONFIG_SENSORS_ADM1275 is not set
CONFIG_SENSORS_IBM_CFFPS=m
CONFIG_SENSORS_IR35221=m
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
CONFIG_SENSORS_LTC3815=m
CONFIG_SENSORS_MAX16064=m
CONFIG_SENSORS_MAX20751=m
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
# CONFIG_SENSORS_MAX8688 is not set
CONFIG_SENSORS_TPS40422=m
CONFIG_SENSORS_TPS53679=m
CONFIG_SENSORS_UCD9000=m
# CONFIG_SENSORS_UCD9200 is not set
# CONFIG_SENSORS_ZL6100 is not set
# CONFIG_SENSORS_SHT15 is not set
CONFIG_SENSORS_SHT21=m
CONFIG_SENSORS_SHT3x=m
CONFIG_SENSORS_SHTC1=m
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_DME1737 is not set
CONFIG_SENSORS_EMC1403=m
CONFIG_SENSORS_EMC2103=m
# CONFIG_SENSORS_EMC6W201 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_STTS751=m
CONFIG_SENSORS_SMM665=m
CONFIG_SENSORS_ADC128D818=m
# CONFIG_SENSORS_ADS1015 is not set
# CONFIG_SENSORS_ADS7828 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
# CONFIG_SENSORS_INA2XX is not set
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
CONFIG_SENSORS_TMP108=m
# CONFIG_SENSORS_TMP401 is not set
# CONFIG_SENSORS_TMP421 is not set
CONFIG_SENSORS_VIA_CPUTEMP=m
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_VT1211 is not set
# CONFIG_SENSORS_VT8231 is not set
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
CONFIG_SENSORS_W83795_FANCTRL=y
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
CONFIG_SENSORS_WM831X=m

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
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
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# CONFIG_INTEL_PCH_THERMAL is not set
# CONFIG_GENERIC_ADC_THERMAL is not set
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
# CONFIG_SSB_B43_PCI_BRIDGE is not set
CONFIG_SSB_PCMCIAHOST_POSSIBLE=y
# CONFIG_SSB_PCMCIAHOST is not set
CONFIG_SSB_SDIOHOST_POSSIBLE=y
# CONFIG_SSB_SDIOHOST is not set
# CONFIG_SSB_SILENT is not set
CONFIG_SSB_DEBUG=y
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
# CONFIG_MFD_AS3711 is not set
CONFIG_PMIC_ADP5520=y
# CONFIG_MFD_AAT2870_CORE is not set
CONFIG_MFD_BCM590XX=m
# CONFIG_MFD_BD9571MWV is not set
CONFIG_MFD_AXP20X=m
CONFIG_MFD_AXP20X_I2C=m
CONFIG_MFD_CROS_EC=y
# CONFIG_MFD_CROS_EC_I2C is not set
CONFIG_MFD_CROS_EC_CHARDEV=y
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_I2C is not set
CONFIG_MFD_DA9055=y
# CONFIG_MFD_DA9062 is not set
CONFIG_MFD_DA9063=y
# CONFIG_MFD_DA9150 is not set
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_I2C=y
# CONFIG_HTC_PASIC3 is not set
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
CONFIG_MFD_KEMPLD=m
# CONFIG_MFD_88PM800 is not set
CONFIG_MFD_88PM805=y
CONFIG_MFD_88PM860X=y
CONFIG_MFD_MAX14577=y
CONFIG_MFD_MAX77693=y
CONFIG_MFD_MAX77843=y
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
CONFIG_MFD_MAX8997=y
CONFIG_MFD_MAX8998=y
# CONFIG_MFD_MT6397 is not set
CONFIG_MFD_MENF21BMC=m
CONFIG_MFD_RETU=m
# CONFIG_MFD_PCF50633 is not set
# CONFIG_UCB1400_CORE is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
CONFIG_MFD_RC5T583=y
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=y
CONFIG_MFD_SM501_GPIO=y
CONFIG_MFD_SKY81452=m
CONFIG_MFD_SMSC=y
CONFIG_ABX500_CORE=y
CONFIG_AB3100_CORE=y
CONFIG_AB3100_OTP=m
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=m
# CONFIG_MFD_LP3943 is not set
CONFIG_MFD_LP8788=y
# CONFIG_MFD_TI_LMU is not set
CONFIG_MFD_PALMAS=y
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=y
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TPS68470 is not set
CONFIG_MFD_TI_LP873X=y
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
# CONFIG_MFD_TPS80031 is not set
CONFIG_TWL4030_CORE=y
CONFIG_MFD_TWL4030_AUDIO=y
CONFIG_TWL6040_CORE=y
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TIMBERDALE is not set
# CONFIG_MFD_TMIO is not set
# CONFIG_MFD_VX855 is not set
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_WM8400 is not set
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
# CONFIG_MFD_WM8350_I2C is not set
CONFIG_MFD_WM8994=y
CONFIG_RAVE_SP_CORE=m
# CONFIG_REGULATOR is not set
# CONFIG_RC_CORE is not set
CONFIG_MEDIA_SUPPORT=m

#
# Multimedia core support
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
# CONFIG_MEDIA_RADIO_SUPPORT is not set
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_CEC_SUPPORT=y
CONFIG_MEDIA_CONTROLLER=y
CONFIG_MEDIA_CONTROLLER_DVB=y
CONFIG_VIDEO_DEV=m
# CONFIG_VIDEO_V4L2_SUBDEV_API is not set
CONFIG_VIDEO_V4L2=m
# CONFIG_VIDEO_ADV_DEBUG is not set
CONFIG_VIDEO_FIXED_MINOR_RANGES=y
CONFIG_DVB_CORE=m
# CONFIG_DVB_MMAP is not set
# CONFIG_DVB_NET is not set
# CONFIG_TTPCI_EEPROM is not set
CONFIG_DVB_MAX_ADAPTERS=16
CONFIG_DVB_DYNAMIC_MINORS=y
CONFIG_DVB_DEMUX_SECTION_LOSS_LOG=y
# CONFIG_DVB_ULE_DEBUG is not set

#
# Media drivers
#
# CONFIG_MEDIA_PCI_SUPPORT is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set
CONFIG_CEC_PLATFORM_DRIVERS=y
# CONFIG_SDR_PLATFORM_DRIVERS is not set

#
# Supported MMC/SDIO adapters
#
CONFIG_SMS_SDIO_DRV=m
CONFIG_MEDIA_COMMON_OPTIONS=y

#
# common driver options
#
CONFIG_SMS_SIANO_MDTV=m

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
# SDR tuner chips
#

#
# Miscellaneous helper chips
#

#
# Sensors used on soc_camera driver
#
CONFIG_MEDIA_TUNER=m
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC5000=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_MC44S803=m

#
# Multistandard (satellite) frontends
#

#
# Multistandard (cable + terrestrial) frontends
#

#
# DVB-S (satellite) frontends
#

#
# DVB-T (terrestrial) frontends
#
# CONFIG_DVB_AS102_FE is not set
# CONFIG_DVB_GP8PSK_FE is not set

#
# DVB-C (cable) frontends
#

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#

#
# ISDB-T (terrestrial) frontends
#

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#

#
# Digital terrestrial only tuners/PLL
#

#
# SEC control devices for DVB-S
#

#
# Tools to develop new frontends
#
# CONFIG_DVB_DUMMY_FE is not set

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
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_HECUBA=y
# CONFIG_FB_SVGALIB is not set
# CONFIG_FB_MACMODES is not set
# CONFIG_FB_BACKLIGHT is not set
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_ARC=y
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
CONFIG_FB_N411=y
CONFIG_FB_HGA=m
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
CONFIG_FB_SM501=y
# CONFIG_FB_IBM_GXT4500 is not set
CONFIG_FB_GOLDFISH=m
# CONFIG_FB_VIRTUAL is not set
CONFIG_FB_METRONOME=m
# CONFIG_FB_MB862XX is not set
CONFIG_FB_BROADSHEET=m
# CONFIG_FB_AUO_K190X is not set
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SM712 is not set
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
# CONFIG_VGASTATE is not set
# CONFIG_LOGO is not set
CONFIG_SOUND=y
# CONFIG_SOUND_OSS_CORE is not set
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=m
CONFIG_SND_DMAENGINE_PCM=m
CONFIG_SND_SEQ_DEVICE=y
CONFIG_SND_RAWMIDI=y
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
# CONFIG_SND_OSSEMUL is not set
# CONFIG_SND_PCM_TIMER is not set
# CONFIG_SND_DYNAMIC_MINORS is not set
CONFIG_SND_SUPPORT_OLD_API=y
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_SEQUENCER=y
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_SEQ_MIDI_EVENT=y
CONFIG_SND_SEQ_MIDI=y
# CONFIG_SND_OPL3_LIB_SEQ is not set
# CONFIG_SND_OPL4_LIB_SEQ is not set
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_DRIVERS=y
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_ALOOP is not set
# CONFIG_SND_VIRMIDI is not set
CONFIG_SND_MTPAV=y
# CONFIG_SND_MTS64 is not set
CONFIG_SND_SERIAL_U16550=m
# CONFIG_SND_MPU401 is not set
CONFIG_SND_PORTMAN2X4=m
CONFIG_SND_AC97_POWER_SAVE=y
CONFIG_SND_AC97_POWER_SAVE_DEFAULT=0
# CONFIG_SND_ISA is not set
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
# CONFIG_SND_PCMCIA is not set
CONFIG_SND_SOC=m
CONFIG_SND_SOC_AC97_BUS=y
CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
# CONFIG_SND_SOC_AMD_ACP is not set
CONFIG_SND_ATMEL_SOC=m
# CONFIG_SND_DESIGNWARE_I2S is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
# CONFIG_SND_SOC_FSL_ASRC is not set
CONFIG_SND_SOC_FSL_SAI=m
CONFIG_SND_SOC_FSL_SSI=m
CONFIG_SND_SOC_FSL_SPDIF=m
CONFIG_SND_SOC_FSL_ESAI=m
# CONFIG_SND_SOC_IMX_AUDMUX is not set
CONFIG_SND_I2S_HI6210_I2S=m
CONFIG_SND_SOC_IMG=y
# CONFIG_SND_SOC_IMG_I2S_IN is not set
CONFIG_SND_SOC_IMG_I2S_OUT=m
CONFIG_SND_SOC_IMG_PARALLEL_OUT=m
CONFIG_SND_SOC_IMG_SPDIF_IN=m
CONFIG_SND_SOC_IMG_SPDIF_OUT=m
# CONFIG_SND_SOC_IMG_PISTACHIO_INTERNAL_DAC is not set
# CONFIG_SND_SOC_INTEL_SST_TOPLEVEL is not set

#
# STMicroelectronics STM32 SOC audio support
#
# CONFIG_SND_SOC_XTFPGA_I2S is not set
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
CONFIG_SND_SOC_ADAU7002=m
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
# CONFIG_SND_SOC_CS42L52 is not set
# CONFIG_SND_SOC_CS42L56 is not set
CONFIG_SND_SOC_CS42L73=m
CONFIG_SND_SOC_CS4265=m
CONFIG_SND_SOC_CS4270=m
CONFIG_SND_SOC_CS4271=m
CONFIG_SND_SOC_CS4271_I2C=m
CONFIG_SND_SOC_CS42XX8=m
CONFIG_SND_SOC_CS42XX8_I2C=m
CONFIG_SND_SOC_CS43130=m
CONFIG_SND_SOC_CS4349=m
CONFIG_SND_SOC_CS53L30=m
CONFIG_SND_SOC_DIO2125=m
CONFIG_SND_SOC_ES7134=m
CONFIG_SND_SOC_ES8316=m
CONFIG_SND_SOC_ES8328=m
CONFIG_SND_SOC_ES8328_I2C=m
CONFIG_SND_SOC_GTM601=m
CONFIG_SND_SOC_INNO_RK3036=m
CONFIG_SND_SOC_MAX98504=m
CONFIG_SND_SOC_MAX98927=m
CONFIG_SND_SOC_MAX98373=m
CONFIG_SND_SOC_MAX9860=m
CONFIG_SND_SOC_MSM8916_WCD_DIGITAL=m
CONFIG_SND_SOC_PCM1681=m
CONFIG_SND_SOC_PCM179X=m
CONFIG_SND_SOC_PCM179X_I2C=m
CONFIG_SND_SOC_PCM186X=m
CONFIG_SND_SOC_PCM186X_I2C=m
CONFIG_SND_SOC_PCM3168A=m
CONFIG_SND_SOC_PCM3168A_I2C=m
CONFIG_SND_SOC_PCM512x=m
CONFIG_SND_SOC_PCM512x_I2C=m
CONFIG_SND_SOC_RL6231=m
# CONFIG_SND_SOC_RT5514_SPI_BUILTIN is not set
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
CONFIG_SND_SOC_SSM2602_I2C=m
CONFIG_SND_SOC_SSM4567=m
CONFIG_SND_SOC_STA32X=m
CONFIG_SND_SOC_STA350=m
CONFIG_SND_SOC_STI_SAS=m
CONFIG_SND_SOC_TAS2552=m
CONFIG_SND_SOC_TAS5086=m
CONFIG_SND_SOC_TAS571X=m
CONFIG_SND_SOC_TAS5720=m
CONFIG_SND_SOC_TAS6424=m
CONFIG_SND_SOC_TFA9879=m
CONFIG_SND_SOC_TLV320AIC23=m
CONFIG_SND_SOC_TLV320AIC23_I2C=m
CONFIG_SND_SOC_TLV320AIC31XX=m
CONFIG_SND_SOC_TLV320AIC32X4=m
CONFIG_SND_SOC_TLV320AIC32X4_I2C=m
CONFIG_SND_SOC_TLV320AIC3X=m
CONFIG_SND_SOC_TS3A227E=m
CONFIG_SND_SOC_TSCS42XX=m
CONFIG_SND_SOC_WM8510=m
CONFIG_SND_SOC_WM8523=m
CONFIG_SND_SOC_WM8524=m
CONFIG_SND_SOC_WM8580=m
CONFIG_SND_SOC_WM8711=m
CONFIG_SND_SOC_WM8728=m
CONFIG_SND_SOC_WM8731=m
CONFIG_SND_SOC_WM8737=m
CONFIG_SND_SOC_WM8741=m
CONFIG_SND_SOC_WM8750=m
CONFIG_SND_SOC_WM8753=m
CONFIG_SND_SOC_WM8776=m
CONFIG_SND_SOC_WM8804=m
CONFIG_SND_SOC_WM8804_I2C=m
CONFIG_SND_SOC_WM8903=m
CONFIG_SND_SOC_WM8960=m
# CONFIG_SND_SOC_WM8962 is not set
CONFIG_SND_SOC_WM8974=m
CONFIG_SND_SOC_WM8978=m
CONFIG_SND_SOC_WM8985=m
# CONFIG_SND_SOC_ZX_AUD96P22 is not set
CONFIG_SND_SOC_NAU8540=m
CONFIG_SND_SOC_NAU8810=m
CONFIG_SND_SOC_NAU8824=m
CONFIG_SND_SOC_TPA6130A2=m
CONFIG_SND_SIMPLE_CARD_UTILS=m
CONFIG_SND_SIMPLE_CARD=m
# CONFIG_SND_X86 is not set
CONFIG_AC97_BUS=m

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
# CONFIG_HID_PRODIKEYS is not set
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
# CONFIG_TAHVO_USB is not set
# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
CONFIG_UWB=y
# CONFIG_UWB_WHCI is not set
CONFIG_MMC=y
CONFIG_MMC_BLOCK=y
CONFIG_MMC_BLOCK_MINORS=8
# CONFIG_SDIO_UART is not set
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
CONFIG_MMC_DEBUG=y
CONFIG_MMC_SDHCI=m
# CONFIG_MMC_SDHCI_PCI is not set
# CONFIG_MMC_SDHCI_ACPI is not set
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
CONFIG_MMC_WBSD=y
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_GOLDFISH is not set
# CONFIG_MMC_SDRICOH_CS is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
CONFIG_MMC_USDHI6ROL0=y
CONFIG_MMC_CQHCI=y
# CONFIG_MMC_TOSHIBA_PCI is not set
CONFIG_MMC_MTK=m
# CONFIG_MMC_SDHCI_XENON is not set
CONFIG_MEMSTICK=m
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=m
CONFIG_MS_BLOCK=m

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
CONFIG_LEDS_LM3530=y
CONFIG_LEDS_LM3642=m
CONFIG_LEDS_NET48XX=m
CONFIG_LEDS_WRAP=m
# CONFIG_LEDS_PCA9532 is not set
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_LP3944=m
CONFIG_LEDS_LP3952=y
CONFIG_LEDS_LP55XX_COMMON=y
CONFIG_LEDS_LP5521=y
CONFIG_LEDS_LP5523=m
CONFIG_LEDS_LP5562=y
# CONFIG_LEDS_LP8501 is not set
# CONFIG_LEDS_LP8788 is not set
CONFIG_LEDS_PCA955X=m
CONFIG_LEDS_PCA955X_GPIO=y
CONFIG_LEDS_PCA963X=m
CONFIG_LEDS_WM831X_STATUS=m
# CONFIG_LEDS_PWM is not set
CONFIG_LEDS_BD2802=y
# CONFIG_LEDS_LT3593 is not set
# CONFIG_LEDS_ADP5520 is not set
# CONFIG_LEDS_MC13783 is not set
CONFIG_LEDS_TCA6507=y
CONFIG_LEDS_TLC591XX=m
CONFIG_LEDS_MAX8997=y
CONFIG_LEDS_LM355x=m
# CONFIG_LEDS_OT200 is not set
CONFIG_LEDS_MENF21BMC=m

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
# CONFIG_LEDS_TRIGGER_ONESHOT is not set
# CONFIG_LEDS_TRIGGER_DISK is not set
# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
CONFIG_LEDS_TRIGGER_CPU=y
CONFIG_LEDS_TRIGGER_ACTIVITY=m
# CONFIG_LEDS_TRIGGER_GPIO is not set
# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
# CONFIG_LEDS_TRIGGER_CAMERA is not set
# CONFIG_LEDS_TRIGGER_PANIC is not set
CONFIG_LEDS_TRIGGER_NETDEV=y
# CONFIG_ACCESSIBILITY is not set
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
# CONFIG_EDAC_I82860 is not set
# CONFIG_EDAC_R82600 is not set
# CONFIG_EDAC_I5000 is not set
# CONFIG_EDAC_I5100 is not set
# CONFIG_EDAC_I7300 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
CONFIG_RTC_DEBUG=y
# CONFIG_RTC_NVMEM is not set

#
# RTC interfaces
#
# CONFIG_RTC_INTF_SYSFS is not set
# CONFIG_RTC_INTF_PROC is not set
CONFIG_RTC_INTF_DEV=y
CONFIG_RTC_INTF_DEV_UIE_EMUL=y
CONFIG_RTC_DRV_TEST=m

#
# I2C RTC drivers
#
CONFIG_RTC_DRV_88PM860X=m
# CONFIG_RTC_DRV_ABB5ZES3 is not set
CONFIG_RTC_DRV_ABX80X=m
# CONFIG_RTC_DRV_DS1307 is not set
CONFIG_RTC_DRV_DS1374=y
CONFIG_RTC_DRV_DS1374_WDT=y
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_LP8788=y
# CONFIG_RTC_DRV_MAX6900 is not set
# CONFIG_RTC_DRV_MAX8998 is not set
CONFIG_RTC_DRV_MAX8997=m
CONFIG_RTC_DRV_RS5C372=y
CONFIG_RTC_DRV_ISL1208=m
# CONFIG_RTC_DRV_ISL12022 is not set
CONFIG_RTC_DRV_X1205=y
CONFIG_RTC_DRV_PCF8523=y
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=y
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
# CONFIG_RTC_DRV_BQ32K is not set
CONFIG_RTC_DRV_PALMAS=m
# CONFIG_RTC_DRV_RC5T583 is not set
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
# CONFIG_RTC_DRV_RX8025 is not set
CONFIG_RTC_DRV_EM3027=y
CONFIG_RTC_DRV_RV8803=m

#
# SPI RTC drivers
#
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
CONFIG_RTC_DRV_PCF2127=y
CONFIG_RTC_DRV_RV3029C2=y

#
# Platform RTC drivers
#
# CONFIG_RTC_DRV_CMOS is not set
CONFIG_RTC_DRV_DS1286=m
# CONFIG_RTC_DRV_DS1511 is not set
# CONFIG_RTC_DRV_DS1553 is not set
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_DA9055=y
# CONFIG_RTC_DRV_DA9063 is not set
CONFIG_RTC_DRV_STK17TA8=m
CONFIG_RTC_DRV_M48T86=y
CONFIG_RTC_DRV_M48T35=y
# CONFIG_RTC_DRV_M48T59 is not set
# CONFIG_RTC_DRV_MSM6242 is not set
CONFIG_RTC_DRV_BQ4802=m
# CONFIG_RTC_DRV_RP5C01 is not set
CONFIG_RTC_DRV_V3020=m
# CONFIG_RTC_DRV_WM831X is not set
CONFIG_RTC_DRV_AB3100=y
CONFIG_RTC_DRV_CROS_EC=m

#
# on-CPU RTC drivers
#
CONFIG_RTC_DRV_FTRTC010=m
CONFIG_RTC_DRV_MC13XXX=y

#
# HID Sensor RTC drivers
#
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
# CONFIG_SYNC_FILE is not set
CONFIG_AUXDISPLAY=y
CONFIG_CHARLCD=m
CONFIG_HD44780=m
CONFIG_KS0108=m
CONFIG_KS0108_PORT=0x378
CONFIG_KS0108_DELAY=2
# CONFIG_CFAG12864B is not set
CONFIG_IMG_ASCII_LCD=y
CONFIG_PANEL=m
CONFIG_PANEL_PARPORT=0
CONFIG_PANEL_PROFILE=5
# CONFIG_PANEL_CHANGE_MESSAGE is not set
# CONFIG_UIO is not set
CONFIG_VIRT_DRIVERS=y
# CONFIG_VBOXGUEST is not set
CONFIG_VIRTIO=m
CONFIG_VIRTIO_MENU=y
# CONFIG_VIRTIO_PCI is not set
CONFIG_VIRTIO_BALLOON=m
# CONFIG_VIRTIO_INPUT is not set
# CONFIG_VIRTIO_MMIO is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# CONFIG_HYPERV_TSCPAGE is not set
CONFIG_STAGING=y
# CONFIG_IRDA is not set
# CONFIG_IPX is not set
# CONFIG_NCP_FS is not set
CONFIG_COMEDI=y
# CONFIG_COMEDI_DEBUG is not set
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
# CONFIG_COMEDI_MISC_DRIVERS is not set
# CONFIG_COMEDI_ISA_DRIVERS is not set
# CONFIG_COMEDI_PCI_DRIVERS is not set
CONFIG_COMEDI_PCMCIA_DRIVERS=y
CONFIG_COMEDI_CB_DAS16_CS=m
# CONFIG_COMEDI_DAS08_CS is not set
CONFIG_COMEDI_NI_DAQ_700_CS=y
CONFIG_COMEDI_NI_DAQ_DIO24_CS=m
CONFIG_COMEDI_NI_LABPC_CS=y
CONFIG_COMEDI_NI_MIO_CS=y
CONFIG_COMEDI_QUATECH_DAQP_CS=y
CONFIG_COMEDI_8254=y
CONFIG_COMEDI_8255=y
CONFIG_COMEDI_8255_SA=m
CONFIG_COMEDI_KCOMEDILIB=y
CONFIG_COMEDI_NI_LABPC=y
CONFIG_COMEDI_NI_TIO=y
# CONFIG_R8822BE is not set
# CONFIG_RTS5208 is not set
# CONFIG_VT6655 is not set

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
CONFIG_AD7152=m
CONFIG_AD7746=m

#
# Direct Digital Synthesis
#

#
# Digital gyroscope sensors
#

#
# Network Analyzer, Impedance Converters
#
CONFIG_AD5933=m

#
# Light sensors
#
# CONFIG_TSL2x7x is not set

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
# CONFIG_DVB_CXD2099 is not set

#
# Android
#
CONFIG_GOLDFISH_AUDIO=m
# CONFIG_LNET is not set
# CONFIG_DGNC is not set
# CONFIG_GS_FPGABOOT is not set
CONFIG_UNISYSSPAR=y
CONFIG_WILC1000=m
CONFIG_WILC1000_SDIO=m
# CONFIG_WILC1000_HW_OOB_INTR is not set
CONFIG_MOST=m
CONFIG_MOST_CDEV=m
# CONFIG_MOST_NET is not set
CONFIG_MOST_SOUND=m
CONFIG_MOST_VIDEO=m
# CONFIG_MOST_DIM2 is not set
# CONFIG_MOST_I2C is not set
CONFIG_KS7010=m
CONFIG_GREYBUS=m
CONFIG_GREYBUS_AUDIO=m
CONFIG_GREYBUS_BOOTROM=m
# CONFIG_GREYBUS_HID is not set
CONFIG_GREYBUS_LIGHT=m
# CONFIG_GREYBUS_LOG is not set
CONFIG_GREYBUS_LOOPBACK=m
# CONFIG_GREYBUS_POWER is not set
# CONFIG_GREYBUS_RAW is not set
CONFIG_GREYBUS_VIBRATOR=m
CONFIG_GREYBUS_BRIDGED_PHY=m
CONFIG_GREYBUS_GPIO=m
CONFIG_GREYBUS_I2C=m
CONFIG_GREYBUS_PWM=m
CONFIG_GREYBUS_SDIO=m
# CONFIG_GREYBUS_UART is not set

#
# USB Power Delivery and Type-C drivers
#
# CONFIG_X86_PLATFORM_DEVICES is not set
CONFIG_PMC_ATOM=y
CONFIG_GOLDFISH_BUS=y
# CONFIG_GOLDFISH_PIPE is not set
CONFIG_CHROME_PLATFORMS=y
CONFIG_CHROMEOS_PSTORE=m
CONFIG_CROS_EC_CTL=y
# CONFIG_CROS_EC_LPC is not set
CONFIG_CROS_EC_PROTO=y
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
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
# CONFIG_CLK_TWL6040 is not set
# CONFIG_COMMON_CLK_NXP is not set
# CONFIG_COMMON_CLK_PALMAS is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_COMMON_CLK_PXA is not set
# CONFIG_COMMON_CLK_PIC32 is not set
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
# CONFIG_PCC is not set
CONFIG_ALTERA_MBOX=y
# CONFIG_IOMMU_SUPPORT is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=m

#
# Rpmsg drivers
#
CONFIG_RPMSG=m
CONFIG_RPMSG_CHAR=m
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
CONFIG_RPMSG_VIRTIO=m
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
CONFIG_XILINX_VCU=m
# CONFIG_PM_DEVFREQ is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=y
CONFIG_EXTCON_GPIO=y
# CONFIG_EXTCON_INTEL_INT3496 is not set
# CONFIG_EXTCON_MAX14577 is not set
# CONFIG_EXTCON_MAX3355 is not set
# CONFIG_EXTCON_MAX77693 is not set
# CONFIG_EXTCON_MAX77843 is not set
CONFIG_EXTCON_MAX8997=y
CONFIG_EXTCON_PALMAS=y
CONFIG_EXTCON_RT8973A=y
# CONFIG_EXTCON_SM5502 is not set
CONFIG_EXTCON_USB_GPIO=y
CONFIG_EXTCON_USBC_CROS_EC=m
CONFIG_MEMORY=y
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
CONFIG_IIO_BUFFER_HW_CONSUMER=m
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=m
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=m
CONFIG_IIO_SW_TRIGGER=m

#
# Accelerometers
#
# CONFIG_ADXL345_I2C is not set
CONFIG_BMA180=y
CONFIG_BMC150_ACCEL=y
CONFIG_BMC150_ACCEL_I2C=y
CONFIG_DA280=y
CONFIG_DA311=y
CONFIG_DMARD09=m
# CONFIG_DMARD10 is not set
CONFIG_IIO_CROS_EC_ACCEL_LEGACY=m
CONFIG_IIO_ST_ACCEL_3AXIS=y
CONFIG_IIO_ST_ACCEL_I2C_3AXIS=y
# CONFIG_KXSD9 is not set
CONFIG_KXCJK1013=y
CONFIG_MC3230=m
CONFIG_MMA7455=m
CONFIG_MMA7455_I2C=m
# CONFIG_MMA7660 is not set
CONFIG_MMA8452=m
CONFIG_MMA9551_CORE=m
CONFIG_MMA9551=m
# CONFIG_MMA9553 is not set
# CONFIG_MXC4005 is not set
# CONFIG_MXC6255 is not set
CONFIG_STK8312=y
CONFIG_STK8BA50=y

#
# Analog to digital converters
#
CONFIG_AD7291=y
CONFIG_AD799X=y
CONFIG_AXP20X_ADC=m
CONFIG_AXP288_ADC=m
CONFIG_HX711=m
CONFIG_INA2XX_ADC=y
CONFIG_LP8788_ADC=y
CONFIG_LTC2471=m
CONFIG_LTC2485=y
CONFIG_LTC2497=m
# CONFIG_MAX1363 is not set
CONFIG_MAX9611=m
CONFIG_MCP3422=m
# CONFIG_MEN_Z188_ADC is not set
CONFIG_NAU7802=y
CONFIG_PALMAS_GPADC=y
CONFIG_TI_ADC081C=m
CONFIG_TI_ADS1015=m
CONFIG_TI_AM335X_ADC=m
CONFIG_TWL4030_MADC=m
CONFIG_TWL6030_GPADC=m

#
# Amplifiers
#

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=m
# CONFIG_CCS811 is not set
CONFIG_IAQCORE=m
# CONFIG_VZ89X is not set
# CONFIG_IIO_CROS_EC_SENSORS_CORE is not set

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
CONFIG_AD5064=m
# CONFIG_AD5380 is not set
CONFIG_AD5446=m
CONFIG_AD5592R_BASE=y
CONFIG_AD5593R=y
# CONFIG_CIO_DAC is not set
# CONFIG_DS4424 is not set
CONFIG_M62332=m
# CONFIG_MAX517 is not set
CONFIG_MCP4725=y

#
# IIO dummy driver
#
CONFIG_IIO_SIMPLE_DUMMY=m
# CONFIG_IIO_SIMPLE_DUMMY_EVENTS is not set
# CONFIG_IIO_SIMPLE_DUMMY_BUFFER is not set

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
CONFIG_IIO_ST_GYRO_3AXIS=m
CONFIG_IIO_ST_GYRO_I2C_3AXIS=m
CONFIG_ITG3200=m

#
# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4404=m
# CONFIG_MAX30100 is not set
CONFIG_MAX30102=y

#
# Humidity sensors
#
CONFIG_AM2315=m
# CONFIG_DHT11 is not set
CONFIG_HDC100X=y
# CONFIG_HTS221 is not set
CONFIG_HTU21=y
# CONFIG_SI7005 is not set
CONFIG_SI7020=y

#
# Inertial measurement units
#
CONFIG_BMI160=y
CONFIG_BMI160_I2C=y
CONFIG_KMX61=m
CONFIG_INV_MPU6050_IIO=m
CONFIG_INV_MPU6050_I2C=m
CONFIG_IIO_ST_LSM6DSX=y
CONFIG_IIO_ST_LSM6DSX_I2C=y

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
CONFIG_ADJD_S311=y
# CONFIG_AL3320A is not set
CONFIG_APDS9300=y
CONFIG_APDS9960=m
# CONFIG_BH1750 is not set
CONFIG_BH1780=y
CONFIG_CM32181=y
# CONFIG_CM3232 is not set
# CONFIG_CM3323 is not set
# CONFIG_CM36651 is not set
CONFIG_GP2AP020A00F=m
CONFIG_SENSORS_ISL29018=m
CONFIG_SENSORS_ISL29028=y
# CONFIG_ISL29125 is not set
CONFIG_JSA1212=m
# CONFIG_RPR0521 is not set
CONFIG_LTR501=m
# CONFIG_MAX44000 is not set
# CONFIG_OPT3001 is not set
CONFIG_PA12203001=y
# CONFIG_SI1145 is not set
CONFIG_STK3310=m
CONFIG_ST_UVIS25=y
CONFIG_ST_UVIS25_I2C=y
CONFIG_TCS3414=m
CONFIG_TCS3472=y
# CONFIG_SENSORS_TSL2563 is not set
CONFIG_TSL2583=m
CONFIG_TSL4531=m
CONFIG_US5182D=m
CONFIG_VCNL4000=y
# CONFIG_VEML6070 is not set
# CONFIG_VL6180 is not set
CONFIG_ZOPT2201=y

#
# Magnetometer sensors
#
# CONFIG_AK8975 is not set
# CONFIG_AK09911 is not set
CONFIG_BMC150_MAGN=m
CONFIG_BMC150_MAGN_I2C=m
CONFIG_MAG3110=m
CONFIG_MMC35240=m
# CONFIG_IIO_ST_MAGN_3AXIS is not set
CONFIG_SENSORS_HMC5843=y
CONFIG_SENSORS_HMC5843_I2C=y

#
# Multiplexers
#

#
# Inclinometer sensors
#

#
# Triggers - standalone
#
CONFIG_IIO_HRTIMER_TRIGGER=m
CONFIG_IIO_INTERRUPT_TRIGGER=y
# CONFIG_IIO_TIGHTLOOP_TRIGGER is not set
CONFIG_IIO_SYSFS_TRIGGER=m

#
# Digital potentiometers
#
CONFIG_DS1803=m
# CONFIG_MCP4531 is not set
# CONFIG_TPL0102 is not set

#
# Digital potentiostats
#
CONFIG_LMP91000=m

#
# Pressure sensors
#
CONFIG_ABP060MG=m
# CONFIG_BMP280 is not set
CONFIG_HP03=m
# CONFIG_MPL115_I2C is not set
CONFIG_MPL3115=m
CONFIG_MS5611=m
# CONFIG_MS5611_I2C is not set
CONFIG_MS5637=y
CONFIG_IIO_ST_PRESS=m
CONFIG_IIO_ST_PRESS_I2C=m
# CONFIG_T5403 is not set
CONFIG_HP206C=m
# CONFIG_ZPA2326 is not set

#
# Lightning sensors
#

#
# Proximity and distance sensors
#
CONFIG_LIDAR_LITE_V2=y
# CONFIG_RFD77402 is not set
CONFIG_SRF04=m
CONFIG_SX9500=y
# CONFIG_SRF08 is not set

#
# Temperature sensors
#
# CONFIG_MLX90614 is not set
CONFIG_TMP006=y
# CONFIG_TMP007 is not set
CONFIG_TSYS01=m
CONFIG_TSYS02D=y
# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_CROS_EC=y
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
CONFIG_PWM_PCA9685=m
# CONFIG_PWM_TWL is not set
CONFIG_PWM_TWL_LED=m

#
# IRQ chip support
#
CONFIG_ARM_GIC_MAX_NR=1
# CONFIG_ARM_GIC_V3_ITS is not set
CONFIG_IPACK_BUS=m
# CONFIG_BOARD_TPCI200 is not set
CONFIG_SERIAL_IPOCTAL=m
# CONFIG_RESET_CONTROLLER is not set
# CONFIG_FMC is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_BCM_KONA_USB2_PHY=y
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_CPCAP_USB is not set
CONFIG_POWERCAP=y
CONFIG_MCB=y
# CONFIG_MCB_PCI is not set
CONFIG_MCB_LPC=y

#
# Performance monitor support
#
CONFIG_RAS=y
CONFIG_RAS_CEC=y
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
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_INTEL_TH=m
# CONFIG_INTEL_TH_PCI is not set
# CONFIG_INTEL_TH_GTH is not set
CONFIG_INTEL_TH_STH=m
# CONFIG_INTEL_TH_MSU is not set
# CONFIG_INTEL_TH_PTI is not set
CONFIG_INTEL_TH_DEBUG=y
CONFIG_FPGA=y
CONFIG_ALTERA_PR_IP_CORE=m
# CONFIG_FPGA_MGR_ALTERA_CVP is not set
CONFIG_FPGA_BRIDGE=y
CONFIG_XILINX_PR_DECOUPLER=m
CONFIG_FPGA_REGION=m
# CONFIG_FSI is not set
# CONFIG_SIOX is not set
CONFIG_SLIMBUS=m
CONFIG_SLIM_QCOM_CTRL=m

#
# Firmware Drivers
#
CONFIG_EDD=y
# CONFIG_EDD_OFF is not set
# CONFIG_FIRMWARE_MEMMAP is not set
CONFIG_DELL_RBU=y
CONFIG_DCDBAS=y
# CONFIG_ISCSI_IBFT_FIND is not set
CONFIG_FW_CFG_SYSFS=m
CONFIG_FW_CFG_SYSFS_CMDLINE=y
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
# CONFIG_EXT2_FS is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_EXT4_FS=y
# CONFIG_EXT4_USE_FOR_EXT2 is not set
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
CONFIG_EXT4_ENCRYPTION=y
CONFIG_EXT4_FS_ENCRYPTION=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
CONFIG_JFS_FS=m
CONFIG_JFS_POSIX_ACL=y
CONFIG_JFS_SECURITY=y
# CONFIG_JFS_DEBUG is not set
CONFIG_JFS_STATISTICS=y
CONFIG_XFS_FS=m
CONFIG_XFS_QUOTA=y
# CONFIG_XFS_POSIX_ACL is not set
# CONFIG_XFS_RT is not set
# CONFIG_XFS_ONLINE_SCRUB is not set
CONFIG_XFS_WARN=y
# CONFIG_XFS_DEBUG is not set
CONFIG_GFS2_FS=y
CONFIG_OCFS2_FS=y
CONFIG_OCFS2_FS_O2CB=y
# CONFIG_OCFS2_FS_USERSPACE_CLUSTER is not set
# CONFIG_OCFS2_FS_STATS is not set
# CONFIG_OCFS2_DEBUG_MASKLOG is not set
CONFIG_OCFS2_DEBUG_FS=y
# CONFIG_BTRFS_FS is not set
# CONFIG_NILFS2_FS is not set
# CONFIG_F2FS_FS is not set
# CONFIG_FS_DAX is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
# CONFIG_PRINT_QUOTA_WARNING is not set
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
CONFIG_QFMT_V1=y
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS4_FS is not set
CONFIG_FUSE_FS=y
# CONFIG_CUSE is not set
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
CONFIG_OVERLAY_FS_INDEX=y
CONFIG_OVERLAY_FS_NFS_EXPORT=y

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
CONFIG_FAT_FS=m
# CONFIG_MSDOS_FS is not set
CONFIG_VFAT_FS=m
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
CONFIG_SUNRPC_GSS=y
CONFIG_RPCSEC_GSS_KRB5=y
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
CONFIG_CIFS_STATS=y
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_WEAK_PW_HASH=y
# CONFIG_CIFS_UPCALL is not set
CONFIG_CIFS_XATTR=y
# CONFIG_CIFS_POSIX is not set
# CONFIG_CIFS_ACL is not set
# CONFIG_CIFS_DEBUG is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_SMB311 is not set
# CONFIG_CODA_FS is not set
CONFIG_AFS_FS=y
# CONFIG_AFS_DEBUG is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=y
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=y
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=y
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=y
# CONFIG_NLS_CODEPAGE_865 is not set
CONFIG_NLS_CODEPAGE_866=y
CONFIG_NLS_CODEPAGE_869=m
# CONFIG_NLS_CODEPAGE_936 is not set
CONFIG_NLS_CODEPAGE_950=y
CONFIG_NLS_CODEPAGE_932=y
# CONFIG_NLS_CODEPAGE_949 is not set
CONFIG_NLS_CODEPAGE_874=m
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=y
# CONFIG_NLS_ASCII is not set
# CONFIG_NLS_ISO8859_1 is not set
CONFIG_NLS_ISO8859_2=y
CONFIG_NLS_ISO8859_3=y
CONFIG_NLS_ISO8859_4=y
CONFIG_NLS_ISO8859_5=m
# CONFIG_NLS_ISO8859_6 is not set
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=y
# CONFIG_NLS_ISO8859_13 is not set
CONFIG_NLS_ISO8859_14=y
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_MAC_ROMAN is not set
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=y
CONFIG_NLS_MAC_CROATIAN=m
# CONFIG_NLS_MAC_CYRILLIC is not set
CONFIG_NLS_MAC_GAELIC=y
CONFIG_NLS_MAC_GREEK=y
CONFIG_NLS_MAC_ICELAND=y
CONFIG_NLS_MAC_INUIT=y
# CONFIG_NLS_MAC_ROMANIAN is not set
CONFIG_NLS_MAC_TURKISH=m
# CONFIG_NLS_UTF8 is not set
CONFIG_DLM=m
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
CONFIG_FRAME_WARN=2048
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
# CONFIG_MAGIC_SYSRQ_SERIAL is not set
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
CONFIG_DEBUG_PAGEALLOC=y
# CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT is not set
# CONFIG_PAGE_POISONING is not set
CONFIG_DEBUG_RODATA_TEST=y
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_STACK_USAGE=y
CONFIG_DEBUG_VM=y
CONFIG_DEBUG_VM_VMACACHE=y
# CONFIG_DEBUG_VM_RB is not set
# CONFIG_DEBUG_VM_PGFLAGS is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
# CONFIG_DEBUG_MEMORY_INIT is not set
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_DEBUG_HIGHMEM=y
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACKOVERFLOW=y
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
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
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
# CONFIG_PROVE_LOCKING is not set
CONFIG_LOCKDEP=y
CONFIG_LOCK_STAT=y
CONFIG_DEBUG_LOCKDEP=y
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=y
CONFIG_WW_MUTEX_SELFTEST=m
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PI_LIST=y
CONFIG_DEBUG_SG=y
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
# CONFIG_PROVE_RCU is not set
CONFIG_TORTURE_TEST=y
# CONFIG_RCU_PERF_TEST is not set
CONFIG_RCU_TORTURE_TEST=m
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_TRACE=y
# CONFIG_RCU_EQS_DEBUG is not set
CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FAULT_INJECTION=y
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAILSLAB=y
CONFIG_FAIL_PAGE_ALLOC=y
CONFIG_FAIL_MAKE_REQUEST=y
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_MMC_REQUEST is not set
# CONFIG_FAIL_FUTEX is not set
# CONFIG_FAIL_FUNCTION is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAULT_INJECTION_STACKTRACE_FILTER is not set
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
# CONFIG_RUNTIME_TESTING_MENU is not set
CONFIG_MEMTEST=y
CONFIG_BUG_ON_DATA_CORRUPTION=y
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
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set
CONFIG_X86_VERBOSE_BOOTUP=y
# CONFIG_EARLY_PRINTK is not set
CONFIG_X86_PTDUMP_CORE=y
CONFIG_X86_PTDUMP=m
CONFIG_DEBUG_WX=y
CONFIG_DOUBLEFAULT=y
CONFIG_DEBUG_TLBFLUSH=y
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
CONFIG_OPTIMIZE_INLINING=y
CONFIG_DEBUG_ENTRY=y
CONFIG_DEBUG_NMI_SELFTEST=y
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
CONFIG_SECURITY_DMESG_RESTRICT=y
# CONFIG_SECURITY is not set
CONFIG_SECURITYFS=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
# CONFIG_HARDENED_USERCOPY_FALLBACK is not set
CONFIG_HARDENED_USERCOPY_PAGESPAN=y
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
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
# CONFIG_CRYPTO_RSA is not set
# CONFIG_CRYPTO_DH is not set
CONFIG_CRYPTO_ECDH=m
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=y
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
# CONFIG_CRYPTO_PCRYPT is not set
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=m
CONFIG_CRYPTO_MCRYPTD=m
CONFIG_CRYPTO_AUTHENC=y
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_ABLK_HELPER=m
CONFIG_CRYPTO_SIMD=m
CONFIG_CRYPTO_GLUE_HELPER_X86=m
CONFIG_CRYPTO_ENGINE=m

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=m
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
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=y
CONFIG_CRYPTO_KEYWRAP=m

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_XCBC is not set
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
# CONFIG_CRYPTO_CRC32 is not set
CONFIG_CRYPTO_CRC32_PCLMUL=y
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_GHASH=m
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
# CONFIG_CRYPTO_RMD128 is not set
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_RMD256=y
# CONFIG_CRYPTO_RMD320 is not set
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3 is not set
# CONFIG_CRYPTO_TGR192 is not set
# CONFIG_CRYPTO_WP512 is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_586=y
CONFIG_CRYPTO_AES_NI_INTEL=m
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
# CONFIG_CRYPTO_CAMELLIA is not set
CONFIG_CRYPTO_CAST_COMMON=y
# CONFIG_CRYPTO_CAST5 is not set
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_DES=y
# CONFIG_CRYPTO_FCRYPT is not set
CONFIG_CRYPTO_KHAZAD=m
# CONFIG_CRYPTO_SALSA20 is not set
# CONFIG_CRYPTO_SALSA20_586 is not set
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_586=m
CONFIG_CRYPTO_TEA=y
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_586=y

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=m
CONFIG_CRYPTO_842=y
CONFIG_CRYPTO_LZ4=y
# CONFIG_CRYPTO_LZ4HC is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=y
# CONFIG_CRYPTO_DEV_PADLOCK_AES is not set
# CONFIG_CRYPTO_DEV_PADLOCK_SHA is not set
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
CONFIG_CRYPTO_DEV_VIRTIO=m
# CONFIG_ASYMMETRIC_KEY_TYPE is not set

#
# Certificates for signature checking
#
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
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
CONFIG_CRC_CCITT=m
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=y
# CONFIG_CRC32_SLICEBY8 is not set
CONFIG_CRC32_SLICEBY4=y
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC4=y
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=m
CONFIG_AUDIT_GENERIC=y
# CONFIG_AUDIT_ARCH_COMPAT_GENERIC is not set
CONFIG_RANDOM32_SELFTEST=y
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
# CONFIG_XZ_DEC_SPARC is not set
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
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
CONFIG_GLOB_SELFTEST=y
CONFIG_NLATTR=y
CONFIG_CORDIC=m
CONFIG_DDR=y
CONFIG_IRQ_POLL=y
CONFIG_OID_REGISTRY=y
# CONFIG_SG_SPLIT is not set
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_STACKDEPOT=y
CONFIG_SBITMAP=y
# CONFIG_STRING_SELFTEST is not set

--kXdP64Ggrk/fb43R--
