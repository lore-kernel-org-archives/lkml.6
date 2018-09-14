Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E47FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 03:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8BDB20853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 03:40:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8BDB20853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbeINIwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 04:52:32 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:51882 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbeINIwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 04:52:32 -0400
Received: by mail-it0-f69.google.com with SMTP id q5-v6so957756ith.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 20:40:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=+0xR7sYyzxxmd2kDAcrklEX8ffJtskj5QpJLiLbOrBo=;
        b=D4x0mMEYgggtaKisFYEFAdvooR/CWh67cHTfDNnt7HuQxq6QUnDiiW7P0BX+53uRt2
         5jXhTqEarN34tBYgZ2Xt2vvL/Y7roA0HqtVOLrWZpdnbrPenCnuYF02IVAMfbpDbA/W/
         HhAncOA1NiY34n1/7QKkMWqzn8EqVjxeCopxFk2aqSHf0+NQCu/otwhUUKLwsyXy1RWn
         vYmhL7GMNdnajT1Gw5oYPsGtbUp4XTVmW1DWp+NpZw3dHBgflSFepBXGgDHONM7UZmbn
         /1+lPO+WW0ScfrcZrUk3gpS5JkDu3aVyVRj0piu0ky4JpQch29c1TP4xipQ9cwkg2Chh
         k/XA==
X-Gm-Message-State: APzg51BcLwXLZ8uCAGbTB/xHlnG0J8Iubmt43H4/MyYY/8cUX21mO5yj
        Guce7WrzdqSmHS11xqX0OG+lIHTOVpPasZo8F8N83lhv922n
X-Google-Smtp-Source: ANB0VdZ8GkjCH1jqUPTsdRa9LRdCYqs6s9aHosM942ut+jpC4DQxXa/HrEpAAhtwojcUXFSoBIArRyf3HisHfgohXVT5qjPVoh3U
MIME-Version: 1.0
X-Received: by 2002:a24:ac14:: with SMTP id s20-v6mr712102ite.14.1536896401755;
 Thu, 13 Sep 2018 20:40:01 -0700 (PDT)
Date:   Thu, 13 Sep 2018 20:40:01 -0700
In-Reply-To: <000000000000e0d794057592192b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001561080575cc9447@google.com>
Subject: Re: INFO: rcu detected stall in kvm_vcpu_ioctl
From:   syzbot <syzbot+e9b1e8f574404b6e4ed3@syzkaller.appspotmail.com>
To:     hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, pbonzini@redhat.com, rkrcmar@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    f8dcd0279214 Add linux-next specific files for 20180913
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14828b21400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=eb7f4703ab2604e5
dashboard link: https://syzkaller.appspot.com/bug?extid=e9b1e8f574404b6e4ed3
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13091af1400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e9b1e8f574404b6e4ed3@syzkaller.appspotmail.com

8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
L1TF CPU bug present and SMT on, data leak possible. See CVE-2018-3646 and  
https://www.kernel.org/doc/html/latest/admin-guide/l1tf.html for details.
hrtimer: interrupt took 32352 ns
sched: DL replenish lagged too much
rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 	0-...!: (10500 ticks this GP) idle=fd2/1/0x4000000000000002  
softirq=7735/7735 fqs=0
rcu: 	 (t=10500 jiffies g=6877 q=964)
rcu: rcu_preempt kthread starved for 10500 jiffies! g6877 f0x0  
RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=0
rcu: RCU grace-period kthread stack dump:
rcu_preempt     I23016    10      2 0x80000000
Call Trace:
  context_switch kernel/sched/core.c:2830 [inline]
  __schedule+0x86c/0x1ed0 kernel/sched/core.c:3479
  schedule+0xfe/0x460 kernel/sched/core.c:3523
  schedule_timeout+0x140/0x260 kernel/time/timer.c:1804
  rcu_gp_fqs_loop+0x762/0xa80 kernel/rcu/tree.c:1934
  rcu_gp_kthread+0x341/0xc70 kernel/rcu/tree.c:2090
  kthread+0x35a/0x440 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
NMI backtrace for cpu 0
CPU: 0 PID: 7296 Comm: syz-executor4 Not tainted 4.19.0-rc3-next-20180913+  
#73
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d3/0x2c4 lib/dump_stack.c:113
  nmi_cpu_backtrace.cold.4+0x63/0xa2 lib/nmi_backtrace.c:101
  nmi_trigger_cpumask_backtrace+0x1c2/0x22c lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_single_cpu_backtrace include/linux/nmi.h:162 [inline]
  rcu_dump_cpu_stacks+0x16f/0x1bc kernel/rcu/tree.c:1195
  print_cpu_stall.cold.65+0x1f3/0x3c6 kernel/rcu/tree.c:1334
  check_cpu_stall kernel/rcu/tree.c:1408 [inline]
  rcu_pending kernel/rcu/tree.c:2961 [inline]
  rcu_check_callbacks+0xac1/0x1400 kernel/rcu/tree.c:2506
  update_process_times+0x2d/0x70 kernel/time/timer.c:1636
  tick_sched_handle+0x9f/0x180 kernel/time/tick-sched.c:164
  tick_sched_timer+0x45/0x130 kernel/time/tick-sched.c:1274
  __run_hrtimer kernel/time/hrtimer.c:1398 [inline]
  __hrtimer_run_queues+0x412/0x10c0 kernel/time/hrtimer.c:1460
  hrtimer_interrupt+0x313/0x780 kernel/time/hrtimer.c:1518
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1029 [inline]
  smp_apic_timer_interrupt+0x1a1/0x750 arch/x86/kernel/apic/apic.c:1054
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:804
  </IRQ>
RIP: 0010:vmx_handle_external_intr+0x1b4/0x220 arch/x86/kvm/vmx.c:10413
Code: 9e c2 84 c9 0f 95 c0 84 c2 75 73 8b 43 08 48 c1 e0 20 4c 09 e0 4c 09  
e8 48 89 e2 48 83 e4 f0 6a 18 52 9c 6a 10 e8 1c 37 e4 06 <e8> 87 26 61 00  
5b 41 5c 41 5d 5d c3 e8 7b 26 61 00 31 f6 bf 00 00
RSP: 0018:ffff8801c5d574c8 EFLAGS: 00000086 ORIG_RAX: ffffffffffffff13
RAX: ffffffff87e01510 RBX: fffffe0000000ec0 RCX: 0000000000000000
RDX: ffff8801c5d574c8 RSI: 0000000000000001 RDI: fffffe0000000ec8
RBP: ffff8801c5d574e0 R08: ffff8801c18fa500 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000087e00000
R13: 0000000000001510 R14: 0000000000000000 R15: 0000000000000000
  vcpu_enter_guest+0x11ee/0x6260 arch/x86/kvm/x86.c:7621
  vcpu_run arch/x86/kvm/x86.c:7711 [inline]
  kvm_arch_vcpu_ioctl_run+0x370/0x16e0 arch/x86/kvm/x86.c:7888
  kvm_vcpu_ioctl+0x5c8/0x1150 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2589
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:501 [inline]
  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
  __do_sys_ioctl fs/ioctl.c:709 [inline]
  __se_sys_ioctl fs/ioctl.c:707 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4572d9
Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f9437972c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f94379736d4 RCX: 00000000004572d9
RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000006
RBP: 0000000000930140 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004cfa78 R14: 00000000004c5cb4 R15: 0000000000000001
Sending NMI from CPU 0 to CPUs 1:
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.100  
msecs
NMI backtrace for cpu 1
CPU: 1 PID: 7297 Comm: syz-executor0 Not tainted 4.19.0-rc3-next-20180913+  
#73
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:vmx_complete_atomic_exit arch/x86/kvm/vmx.c:10391 [inline]
RIP: 0010:vmx_vcpu_run+0x1da4/0x26e3 arch/x86/kvm/vmx.c:10890
Code: ff 00 02 00 80 0f 85 ab 01 00 00 e8 e6 1b 5c 00 48 c7 c7 c0 d5 23 88  
e8 4a 1a 6f 02 48 8b 04 24 65 48 89 05 fe 9c e0 7e cd 02 <48> c7 c7 c0 d5  
23 88 e8 30 1a 6f 02 48 89 da 48 b8 00 00 00 00 00
RSP: 0018:ffff8801c6357370 EFLAGS: 00000092
RAX: ffff8801c17a8200 RBX: ffff8801c17ad910 RCX: ffffffff83904c2a
RDX: 0000000000000000 RSI: ffffffff83904c38 RDI: 0000000000000005
RBP: ffff8801c6357840 R08: ffff8801c2c1a4c0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000080000202
R13: 0000000000000000 R14: 0000000080000202 R15: 0000000080000200
FS:  00007f1efdac8700(0000) GS:ffff8801dad00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000001c6c90000 CR4: 00000000001426e0
Call Trace:
  vcpu_run arch/x86/kvm/x86.c:7711 [inline]
  kvm_arch_vcpu_ioctl_run+0x370/0x16e0 arch/x86/kvm/x86.c:7888
  kvm_vcpu_ioctl+0x5c8/0x1150 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2589
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:501 [inline]
  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
  __do_sys_ioctl fs/ioctl.c:709 [inline]
  __se_sys_ioctl fs/ioctl.c:707 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4572d9
Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f1efdac7c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f1efdac86d4 RCX: 00000000004572d9
RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000006
RBP: 0000000000930140 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004cfa78 R14: 00000000004c5cb4 R15: 0000000000000001
IPVS: ftp: loaded support on port[0] = 21
IPVS: ftp: loaded support on port[0] = 21
IPVS: ftp: loaded support on port[0] = 21
IPVS: ftp: loaded support on port[0] = 21
IPVS: ftp: loaded support on port[0] = 21
IPVS: ftp: loaded support on port[0] = 21
device bridge_slave_1 left promiscuous mode
bridge0: port 2(bridge_slave_1) entered disabled state
device bridge_slave_0 left promiscuous mode
bridge0: port 1(bridge_slave_0) entered disabled state
team0 (unregistering): Port device team_slave_1 removed
team0 (unregistering): Port device team_slave_0 removed
bond0 (unregistering): Releasing backup interface bond_slave_1
bond0 (unregistering): Releasing backup interface bond_slave_0
bond0 (unregistering): Released all slaves
bridge0: port 1(bridge_slave_0) entered blocking state
bridge0: port 1(bridge_slave_0) entered disabled state
device bridge_slave_0 entered promiscuous mode
bridge0: port 2(bridge_slave_1) entered blocking state
bridge0: port 2(bridge_slave_1) entered disabled state
device bridge_slave_1 entered promiscuous mode
IPv6: ADDRCONF(NETDEV_UP): veth0_to_bridge: link is not ready
IPv6: ADDRCONF(NETDEV_UP): veth1_to_bridge: link is not ready
bridge0: port 1(bridge_slave_0) entered blocking state
bridge0: port 1(bridge_slave_0) entered disabled state
device bridge_slave_0 entered promiscuous mode
bridge0: port 1(bridge_slave_0) entered blocking state
bridge0: port 1(bridge_slave_0) entered disabled state
device bridge_slave_0 entered promiscuous mode
bridge0: port 1(bridge_slave_0) entered blocking state
bridge0: port 1(bridge_slave_0) entered disabled state
device bridge_slave_0 entered promiscuous mode
bridge0: port 1(bridge_slave_0) entered blocking state
bridge0: port 1(bridge_slave_0) entered disabled state
device bridge_slave_0 entered promiscuous mode
bridge0: port 2(bridge_slave_1) entered blocking state
bridge0: port 2(bridge_slave_1) entered disabled state
device bridge_slave_1 entered promiscuous mode
bridge0: port 1(bridge_slave_0) entered blocking state
bridge0: port 1(bridge_slave_0) entered disabled state
device bridge_slave_0 entered promiscuous mode
bridge0: port 2(bridge_slave_1) entered blocking state
bridge0: port 2(bridge_slave_1) entered disabled state
device bridge_slave_1 entered promiscuous mode
bridge0: port 2(bridge_slave_1) entered blocking state
bridge0: port 2(bridge_slave_1) entered disabled state
device bridge_slave_1 entered promiscuous mode
bridge0: port 2(bridge_slave_1) entered blocking state
bridge0: port 2(bridge_slave_1) entered disabled state
device bridge_slave_1 entered promiscuous mode
bond0: Enslaving bond_slave_0 as an active interface with an up link
IPv6: ADDRCONF(NETDEV_UP): veth0_to_bridge: link is not ready
bridge0: port 2(bridge_slave_1) entered blocking state
bridge0: port 2(bridge_slave_1) entered disabled state
device bridge_slave_1 entered promiscuous mode
IPv6: ADDRCONF(NETDEV_UP): veth0_to_bridge: link is not ready
IPv6: ADDRCONF(NETDEV_UP): veth0_to_bridge: link is not ready
IPv6: ADDRCONF(NETDEV_UP): veth0_to_bridge: link is not ready
IPv6: ADDRCONF(NETDEV_UP): veth1_to_bridge: link is not ready
bond0: Enslaving bond_slave_1 as an active interface with an up link
IPv6: ADDRCONF(NETDEV_UP): veth0_to_bridge: link is not ready
IPv6: ADDRCONF(NETDEV_UP): veth1_to_bridge: link is not ready
IPv6: ADDRCONF(NETDEV_UP): veth1_to_bridge: link is not ready
IPv6: ADDRCONF(NETDEV_UP): veth1_to_bridge: link is not ready
IPv6: ADDRCONF(NETDEV_UP): veth1_to_bridge: link is not ready
bond0: Enslaving bond_slave_0 as an active interface with an up link
bond0: Enslaving bond_slave_0 as an active interface with an up link
bond0: Enslaving bond_slave_1 as an active interface with an up link
bond0: Enslaving bond_slave_0 as an active interface with an up link
bond0: Enslaving bond_slave_0 as an active interface with an up link
bond0: Enslaving bond_slave_1 as an active interface with an up link
bond0: Enslaving bond_slave_0 as an active interface with an up link
IPv6: ADDRCONF(NETDEV_UP): veth0_to_bond: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_bond: link becomes ready
bond0: Enslaving bond_slave_1 as an active interface with an up link
IPv6: ADDRCONF(NETDEV_UP): team_slave_0: link is not ready
team0: Port device team_slave_0 added
bond0: Enslaving bond_slave_1 as an active interface with an up link
IPv6: ADDRCONF(NETDEV_UP): veth0_to_bond: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_bond: link becomes ready
bond0: Enslaving bond_slave_1 as an active interface with an up link
IPv6: ADDRCONF(NETDEV_UP): veth1_to_bond: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_bond: link becomes ready
IPv6: ADDRCONF(NETDEV_UP): veth0_to_bond: link is not ready
IPv6: ADDRCONF(NETDEV_UP): team_slave_1: link is not ready
team0: Port device team_slave_1 added
IPv6: ADDRCONF(NETDEV_UP): veth1_to_bond: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_bond: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_bond: link becomes ready
IPv6: ADDRCONF(NETDEV_UP): veth0_to_bond: link is not ready
IPv6: ADDRCONF(NETDEV_UP): veth0_to_bond: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_bond: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_bond: link becomes ready
IPv6: ADDRCONF(NETDEV_UP): veth1_to_bond: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_0: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_bond: link becomes ready
IPv6: ADDRCONF(NETDEV_UP): veth1_to_bond: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_bond: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_1: link becomes ready
IPv6: ADDRCONF(NETDEV_UP): bridge_slave_0: link is not ready
IPv6: ADDRCONF(NETDEV_UP): team_slave_0: link is not ready
team0: Port device team_slave_0 added
IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_0: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_bridge: link becomes ready
IPv6: ADDRCONF(NETDEV_UP): team_slave_0: link is not ready
team0: Port device team_slave_0 added
IPv6: ADDRCONF(NETDEV_UP): team_slave_0: link is not ready
team0: Port device team_slave_0 added
IPv6: ADDRCONF(NETDEV_UP): bridge_slave_1: link is not ready
IPv6: ADDRCONF(NETDEV_UP): team_slave_1: link is not ready
team0: Port device team_slave_1 added
IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_bridge: link becomes ready
IPv6: ADDRCONF(NETDEV_UP): team_slave_0: link is not ready
team0: Port device team_slave_0 added
IPv6: ADDRCONF(NETDEV_UP): team_slave_1: link is not ready
team0: Port device team_slave_1 added
IPv6: ADDRCONF(NETDEV_UP): team_slave_1: link is not ready
team0: Port device team_slave_1 added
IPv6: ADDRCONF(NETDEV_UP): team_slave_0: link is not ready
team0: Port device team_slave_0 added
IPv6: ADDRCONF(NETDEV_UP): veth0_to_team: link is not ready
IPv6: ADDRCONF(NETDEV_UP): veth0_to_team: link is not ready
IPv6: ADDRCONF(NETDEV_UP): team_slave_1: link is not ready
team0: Port device team_slave_1 added
IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_team: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_0: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_team: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_0: link becomes ready
IPv6: ADDRCONF(NETDEV_UP): veth0_to_team: link is not ready
IPv6: ADDRCONF(NETDEV_UP): veth1_to_team: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_team: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_0: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_team: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_1: link becomes ready
IPv6: ADDRCONF(NETDEV_UP): veth1_to_team: link is not ready
IPv6: ADDRCONF(NETDEV_UP): team_slave_1: link is not ready
team0: Port device team_slave_1 added
IPv6: ADDRCONF(NETDEV_UP): bridge_slave_0: link is not ready
IPv6: ADDRCONF(NETDEV_UP): veth0_to_team: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_team: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_0: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_bridge: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_team: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_0: link becomes ready
IPv6: ADDRCONF(NETDEV_UP): veth1_to_team: link is not ready
IPv6: ADDRCONF(NETDEV_UP): veth1_to_team: link is not ready
IPv6: ADDRCONF(NETDEV_UP): veth0_to_team: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_team: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_team: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_team: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_0: link becomes ready
IPv6: ADDRCONF(NETDEV_UP): bridge_slave_0: link is not ready
IPv6: ADDRCONF(NETDEV_UP): bridge_slave_1: link is not ready
IPv6: ADDRCONF(NETDEV_UP): bridge_slave_0: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_0: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_bridge: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_bridge: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_0: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_bridge: link becomes ready
IPv6: ADDRCONF(NETDEV_UP): bridge_slave_0: link is not ready
IPv6: ADDRCONF(NETDEV_UP): veth1_to_team: link is not ready
IPv6: ADDRCONF(NETDEV_UP): bridge_slave_1: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_0: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_bridge: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_team: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_bridge: link becomes ready
IPv6: ADDRCONF(NETDEV_UP): bridge_slave_1: link is not ready
IPv6: ADDRCONF(NETDEV_UP): bridge_slave_1: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_bridge: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_bridge: link becomes ready
IPv6: ADDRCONF(NETDEV_UP): bridge_slave_0: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_0: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_bridge: link becomes ready
IPv6: ADDRCONF(NETDEV_UP): bridge_slave_1: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_bridge: link becomes ready
bridge0: port 2(bridge_slave_1) entered blocking state
bridge0: port 2(bridge_slave_1) entered forwarding state
bridge0: port 1(bridge_slave_0) entered blocking state
bridge0: port 1(bridge_slave_0) entered forwarding state
IPv6: ADDRCONF(NETDEV_UP): bridge0: link is not ready
device bridge_slave_1 left promiscuous mode
bridge0: port 2(bridge_slave_1) entered disabled state
device bridge_slave_0 left promiscuous mode
bridge0: port 1(bridge_slave_0) entered disabled state
device bridge_slave_1 left promiscuous mode
bridge0: port 2(bridge_slave_1) entered disabled state
device bridge_slave_0 left promiscuous mode
bridge0: port 1(bridge_slave_0) entered disabled state
device bridge_slave_1 left promiscuous mode
bridge0: port 2(bridge_slave_1) entered disabled state
device bridge_slave_0 left promiscuous mode
bridge0: port 1(bridge_slave_0) entered disabled state
device bridge_slave_1 left promiscuous mode
bridge0: port 2(bridge_slave_1) entered disabled state
device bridge_slave_0 left promiscuous mode
bridge0: port 1(bridge_slave_0) entered disabled state
device bridge_slave_1 left promiscuous mode
bridge0: port 2(bridge_slave_1) entered disabled state
device bridge_slave_0 left promiscuous mode
bridge0: port 1(bridge_slave_0) entered disabled state
team0 (unregistering): Port device team_slave_1 removed
team0 (unregistering): Port device team_slave_0 removed
bond0 (unregistering): Releasing backup interface bond_slave_1
bond0 (unregistering): Releasing backup interface bond_slave_0
bond0 (unregistering): Released all slaves
team0 (unregistering): Port device team_slave_1 removed
team0 (unregistering): Port device team_slave_0 removed
bond0 (unregistering): Releasing backup interface bond_slave_1
bond0 (unregistering): Releasing backup interface bond_slave_0
bond0 (unregistering): Released all slaves
team0 (unregistering): Port device team_slave_1 removed
team0 (unregistering): Port device team_slave_0 removed
bond0 (unregistering): Releasing backup interface bond_slave_1
bond0 (unregistering): Releasing backup interface bond_slave_0
bond0 (unregistering): Released all slaves
team0 (unregistering): Port device team_slave_1 removed
team0 (unregistering): Port device team_slave_0 removed
bond0 (unregistering): Releasing backup interface bond_slave_1
bond0 (unregistering): Releasing backup interface bond_slave_0
bond0 (unregistering): Released all slaves
team0 (unregistering): Port device team_slave_1 removed
team0 (unregistering): Port device team_slave_0 removed
bond0 (unregistering): Releasing backup interface bond_slave_1
bond0 (unregistering): Releasing backup interface bond_slave_0
bond0 (unregistering): Released all slaves
IPv6: ADDRCONF(NETDEV_CHANGE): bridge0: link becomes ready
bridge0: port 2(bridge_slave_1) entered blocking state
bridge0: port 2(bridge_slave_1) entered forwarding state
bridge0: port 1(bridge_slave_0) entered blocking state
bridge0: port 1(bridge_slave_0) entered forwarding state
IPv6: ADDRCONF(NETDEV_UP): bridge0: link is not ready
bridge0: port 2(bridge_slave_1) entered blocking state
bridge0: port 2(bridge_slave_1) entered forwarding state
bridge0: port 1(bridge_slave_0) entered blocking state
bridge0: port 1(bridge_slave_0) entered forwarding state
IPv6: ADDRCONF(NETDEV_UP): bridge0: link is not ready
bridge0: port 2(bridge_slave_1) entered blocking state
bridge0: port 2(bridge_slave_1) entered forwarding state
bridge0: port 1(bridge_slave_0) entered blocking state
bridge0: port 1(bridge_slave_0) entered forwarding state
IPv6: ADDRCONF(NETDEV_UP): bridge0: link is not ready
bridge0: port 2(bridge_slave_1) entered blocking state
bridge0: port 2(bridge_slave_1) entered forwarding state
bridge0: port 1(bridge_slave_0) entered blocking state
bridge0: port 1(bridge_slave_0) entered forwarding state
IPv6: ADDRCONF(NETDEV_UP): bridge0: link is not ready
bridge0: port 2(bridge_slave_1) entered blocking state
bridge0: port 2(bridge_slave_1) entered forwarding state
bridge0: port 1(bridge_slave_0) entered blocking state
bridge0: port 1(bridge_slave_0) entered forwarding state
IPv6: ADDRCONF(NETDEV_UP): bridge0: link is not ready

