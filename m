Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBF4C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 12:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE31320865
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 12:45:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE31320865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbeIIRei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 13:34:38 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:42825 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbeIIReh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 13:34:37 -0400
Received: by mail-io1-f71.google.com with SMTP id m13-v6so1828545ioq.9
        for <linux-kernel@vger.kernel.org>; Sun, 09 Sep 2018 05:45:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=h6eGEjFWvraLKU+dipsirQatm3ZKZwn2HSLBG9m8W8M=;
        b=jWxOAy5N6LBzPK417IscEFw43EJBuC/5nXjcqlLerGXVyiuRK++oU/EpIqlSECxAQK
         TlfxfKVoyNcRSepiAJ5ce7QM6i/VjyFeNPvdtn72Qc1BJJLLexN0zxXoln/eamPWpuVL
         t97pocjWQA6t7PwvDsucB3FY6jhjX0+FGZLbAQ4RMZA6c79ZQkD+Q0V0Oe3hQcL/N/Xx
         RylHOI1gE/p809WMfxjipL+DRm6pECv+t7ojLJsqFEYeQtuibfK8CBe99ebz9cVrTcgo
         fY6lQhwjxwwvncIS5s49IVFpA6AB5pOBDFYg1YFxOWsqRb6RUZWUNV9PDU0ejIhAxVU5
         KveA==
X-Gm-Message-State: APzg51DzMlkxmgx5hponwZAW7bfbp+39QUqy7s2f2cJ9T748qhSfmmBu
        x/Gg/FngiEfD54TTq2kCAYRK4WljG/AM/inpCUKrQG3ZyXjJ
X-Google-Smtp-Source: ANB0VdZFiUDKoF22d3C64MVGrHet10pn44Qf7YqywPz8UdMzBPLuc1Pzz+chuT9eAv95VJc1p2Pn++Ut12bWI/IZsIW3Xi821VVJ
MIME-Version: 1.0
X-Received: by 2002:a6b:df09:: with SMTP id w9-v6mr13951314iog.117.1536497102370;
 Sun, 09 Sep 2018 05:45:02 -0700 (PDT)
Date:   Sun, 09 Sep 2018 05:45:02 -0700
In-Reply-To: <0000000000002b8fac056b863655@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fc499305756f9b4a@google.com>
Subject: Re: INFO: rcu detected stall in vcpu_enter_guest
From:   syzbot <syzbot+f58b8603b48434ef07d3@syzkaller.appspotmail.com>
To:     dvyukov@google.com, hpa@zytor.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    f8f65382c98a Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13af4cda400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f59875069d721b6
dashboard link: https://syzkaller.appspot.com/bug?extid=f58b8603b48434ef07d3
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11ead70a400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f58b8603b48434ef07d3@syzkaller.appspotmail.com

8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
L1TF CPU bug present and SMT on, data leak possible. See CVE-2018-3646 and  
https://www.kernel.org/doc/html/latest/admin-guide/l1tf.html for details.
hrtimer: interrupt took 31085 ns
rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	(detected by 0, t=10502 jiffies, g=6833, q=154)
rcu: All QSes seen, last rcu_preempt kthread activity 10503  
(4295000262-4294989759), jiffies_till_next_fqs=1, root ->qsmask 0x0
syz-executor4   R  running task    22104  7395   5354 0x00000000
Call Trace:
  <IRQ>
  sched_show_task.cold.83+0x2b6/0x30a kernel/sched/core.c:5296
  print_other_cpu_stall.cold.79+0xa83/0xba5 kernel/rcu/tree.c:1430
  check_cpu_stall kernel/rcu/tree.c:1557 [inline]
  __rcu_pending kernel/rcu/tree.c:3276 [inline]
  rcu_pending kernel/rcu/tree.c:3319 [inline]
  rcu_check_callbacks+0xafc/0x1990 kernel/rcu/tree.c:2665
  update_process_times+0x2d/0x70 kernel/time/timer.c:1636
  tick_sched_handle+0x9f/0x180 kernel/time/tick-sched.c:164
  tick_sched_timer+0x45/0x130 kernel/time/tick-sched.c:1274
  __run_hrtimer kernel/time/hrtimer.c:1398 [inline]
  __hrtimer_run_queues+0x41c/0x10d0 kernel/time/hrtimer.c:1460
  hrtimer_interrupt+0x313/0x780 kernel/time/hrtimer.c:1518
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1029 [inline]
  smp_apic_timer_interrupt+0x1a1/0x760 arch/x86/kernel/apic/apic.c:1054
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:864
  </IRQ>
RIP: 0010:__srcu_read_lock+0xec/0x160 kernel/rcu/srcutree.c:414
Code: 48 ba 00 00 00 00 00 fc ff df 48 89 f9 48 c1 e9 03 c6 04 13 f8 80 3c  
11 00 75 66 48 63 c8 49 8b 95 48 04 00 00 65 48 ff 04 ca <f0> 83 44 24 fc  
00 48 ba 00 00 00 00 00 fc ff df 49 c7 04 14 00 00
RSP: 0018:ffff8801bf2bf458 EFLAGS: 00000206 ORIG_RAX: ffffffffffffff13
RAX: 0000000000000001 RBX: 1ffff10037e57e90 RCX: 0000000000000001
RDX: 000060fe24eb2dc0 RSI: 0000000000000000 RDI: ffffc90001fd2c28
RBP: ffff8801bf2bf4e0 R08: ffff8801c0b82080 R09: 0000000000000006
R10: 0000000000000000 R11: ffff8801c0b82080 R12: 1ffff10037e57e8c
R13: ffffc90001fd27e0 R14: ffff8801bf2bf4c0 R15: 0000000000000000
  srcu_read_lock include/linux/srcu.h:198 [inline]
  vcpu_enter_guest+0x1309/0x62e0 arch/x86/kvm/x86.c:7631
  vcpu_run arch/x86/kvm/x86.c:7711 [inline]
  kvm_arch_vcpu_ioctl_run+0x375/0x16e0 arch/x86/kvm/x86.c:7888
  kvm_vcpu_ioctl+0x72b/0x1150 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2590
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:501 [inline]
  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
  __do_sys_ioctl fs/ioctl.c:709 [inline]
  __se_sys_ioctl fs/ioctl.c:707 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457099
Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffeca5f9b58 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000002395914 RCX: 0000000000457099
RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000006
RBP: 00000000009300a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004cf730 R14: 00000000004c59b9 R15: 0000000000000000
rcu: rcu_preempt kthread starved for 10590 jiffies! g6833 f0x2  
RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: RCU grace-period kthread stack dump:
rcu_preempt     R  running task    23064    10      2 0x80000000
Call Trace:
  context_switch kernel/sched/core.c:2825 [inline]
  __schedule+0x86c/0x1ed0 kernel/sched/core.c:3473
  schedule+0xfe/0x460 kernel/sched/core.c:3517
  schedule_timeout+0x140/0x260 kernel/time/timer.c:1804
  rcu_gp_kthread+0x9d9/0x2310 kernel/rcu/tree.c:2194
  kthread+0x35a/0x420 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:413
sched: RT throttling activated
IPVS: ftp: loaded support on port[0] = 21
IPVS: ftp: loaded support on port[0] = 21
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
bridge0: port 1(bridge_slave_0) entered blocking state
bridge0: port 1(bridge_slave_0) entered disabled state
device bridge_slave_0 entered promiscuous mode
bridge0: port 1(bridge_slave_0) entered blocking state
bridge0: port 1(bridge_slave_0) entered disabled state
device bridge_slave_0 entered promiscuous mode
bridge0: port 2(bridge_slave_1) entered blocking state
bridge0: port 2(bridge_slave_1) entered disabled state
device bridge_slave_1 entered promiscuous mode
bridge0: port 2(bridge_slave_1) entered blocking state
bridge0: port 2(bridge_slave_1) entered disabled state
device bridge_slave_1 entered promiscuous mode
bridge0: port 1(bridge_slave_0) entered blocking state
bridge0: port 1(bridge_slave_0) entered disabled state
device bridge_slave_0 entered promiscuous mode
IPv6: ADDRCONF(NETDEV_UP): veth0_to_bridge: link is not ready
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
bridge0: port 2(bridge_slave_1) entered blocking state
bridge0: port 2(bridge_slave_1) entered disabled state
device bridge_slave_1 entered promiscuous mode
IPv6: ADDRCONF(NETDEV_UP): veth1_to_bridge: link is not ready
bridge0: port 2(bridge_slave_1) entered blocking state
bridge0: port 2(bridge_slave_1) entered disabled state
device bridge_slave_1 entered promiscuous mode
IPv6: ADDRCONF(NETDEV_UP): veth0_to_bridge: link is not ready
bridge0: port 1(bridge_slave_0) entered blocking state
bridge0: port 1(bridge_slave_0) entered disabled state
device bridge_slave_0 entered promiscuous mode
bridge0: port 2(bridge_slave_1) entered blocking state
bridge0: port 2(bridge_slave_1) entered disabled state
device bridge_slave_1 entered promiscuous mode
IPv6: ADDRCONF(NETDEV_UP): veth1_to_bridge: link is not ready
IPv6: ADDRCONF(NETDEV_UP): veth0_to_bridge: link is not ready
bridge0: port 2(bridge_slave_1) entered blocking state
bridge0: port 2(bridge_slave_1) entered disabled state
device bridge_slave_1 entered promiscuous mode
IPv6: ADDRCONF(NETDEV_UP): veth0_to_bridge: link is not ready
bridge0: port 1(bridge_slave_0) entered blocking state
bridge0: port 1(bridge_slave_0) entered disabled state
device bridge_slave_0 entered promiscuous mode
IPv6: ADDRCONF(NETDEV_UP): veth0_to_bridge: link is not ready
IPv6: ADDRCONF(NETDEV_UP): veth1_to_bridge: link is not ready
IPv6: ADDRCONF(NETDEV_UP): veth1_to_bridge: link is not ready
bond0: Enslaving bond_slave_0 as an active interface with an up link
IPv6: ADDRCONF(NETDEV_UP): veth0_to_bridge: link is not ready
IPv6: ADDRCONF(NETDEV_UP): veth1_to_bridge: link is not ready
bridge0: port 2(bridge_slave_1) entered blocking state
bridge0: port 2(bridge_slave_1) entered disabled state
device bridge_slave_1 entered promiscuous mode
bond0: Enslaving bond_slave_0 as an active interface with an up link
IPv6: ADDRCONF(NETDEV_UP): veth1_to_bridge: link is not ready
bond0: Enslaving bond_slave_1 as an active interface with an up link
IPv6: ADDRCONF(NETDEV_UP): veth0_to_bridge: link is not ready
bond0: Enslaving bond_slave_0 as an active interface with an up link
bond0: Enslaving bond_slave_0 as an active interface with an up link
IPv6: ADDRCONF(NETDEV_UP): veth0_to_bond: link is not ready
IPv6: ADDRCONF(NETDEV_UP): veth1_to_bridge: link is not ready
bond0: Enslaving bond_slave_1 as an active interface with an up link
IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_bond: link becomes ready
bond0: Enslaving bond_slave_0 as an active interface with an up link
bond0: Enslaving bond_slave_0 as an active interface with an up link
bond0: Enslaving bond_slave_1 as an active interface with an up link
IPv6: ADDRCONF(NETDEV_UP): veth1_to_bond: link is not ready
bond0: Enslaving bond_slave_1 as an active interface with an up link
IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_bond: link becomes ready
bond0: Enslaving bond_slave_0 as an active interface with an up link
bond0: Enslaving bond_slave_1 as an active interface with an up link
bond0: Enslaving bond_slave_1 as an active interface with an up link
IPv6: ADDRCONF(NETDEV_UP): veth0_to_bond: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_bond: link becomes ready
bond0: Enslaving bond_slave_1 as an active interface with an up link
bond0: Enslaving bond_slave_0 as an active interface with an up link
bond0: Enslaving bond_slave_1 as an active interface with an up link
IPv6: ADDRCONF(NETDEV_UP): team_slave_0: link is not ready
team0: Port device team_slave_0 added
IPv6: ADDRCONF(NETDEV_UP): veth1_to_bond: link is not ready
IPv6: ADDRCONF(NETDEV_UP): veth0_to_bond: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_bond: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_bond: link becomes ready
IPv6: ADDRCONF(NETDEV_UP): team_slave_0: link is not ready
team0: Port device team_slave_0 added
IPv6: ADDRCONF(NETDEV_UP): team_slave_1: link is not ready
team0: Port device team_slave_1 added
IPv6: ADDRCONF(NETDEV_UP): veth1_to_bond: link is not ready
IPv6: ADDRCONF(NETDEV_UP): team_slave_0: link is not ready
team0: Port device team_slave_0 added
IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_bond: link becomes ready
IPv6: ADDRCONF(NETDEV_UP): team_slave_0: link is not ready
team0: Port device team_slave_0 added
IPv6: ADDRCONF(NETDEV_UP): team_slave_1: link is not ready
team0: Port device team_slave_1 added
IPv6: ADDRCONF(NETDEV_UP): team_slave_0: link is not ready
team0: Port device team_slave_0 added
IPv6: ADDRCONF(NETDEV_UP): veth0_to_team: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_team: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_0: link becomes ready
IPv6: ADDRCONF(NETDEV_UP): team_slave_1: link is not ready
team0: Port device team_slave_1 added
IPv6: ADDRCONF(NETDEV_UP): team_slave_0: link is not ready
team0: Port device team_slave_0 added
IPv6: ADDRCONF(NETDEV_UP): veth0_to_team: link is not ready
IPv6: ADDRCONF(NETDEV_UP): veth1_to_team: link is not ready
IPv6: ADDRCONF(NETDEV_UP): team_slave_0: link is not ready
team0: Port device team_slave_0 added
IPv6: ADDRCONF(NETDEV_UP): team_slave_1: link is not ready
team0: Port device team_slave_1 added
IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_team: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_0: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_team: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_1: link becomes ready
IPv6: ADDRCONF(NETDEV_UP): veth0_to_team: link is not ready
IPv6: ADDRCONF(NETDEV_UP): team_slave_1: link is not ready
team0: Port device team_slave_1 added
IPv6: ADDRCONF(NETDEV_UP): bridge_slave_0: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_team: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_0: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_0: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_bridge: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_0: link becomes ready
IPv6: ADDRCONF(NETDEV_UP): bridge_slave_0: link is not ready
IPv6: ADDRCONF(NETDEV_UP): team_slave_1: link is not ready
team0: Port device team_slave_1 added
IPv6: ADDRCONF(NETDEV_UP): team_slave_1: link is not ready
team0: Port device team_slave_1 added
IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_0: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_bridge: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_0: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_1: link becomes ready
IPv6: ADDRCONF(NETDEV_UP): bridge_slave_1: link is not ready
IPv6: ADDRCONF(NETDEV_UP): bridge_slave_0: link is not ready
IPv6: ADDRCONF(NETDEV_UP): bridge_slave_0: link is not ready
IPv6: ADDRCONF(NETDEV_UP): team_slave_0: link is not ready
team0: Port device team_slave_0 added
IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_bridge: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_0: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_bridge: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_0: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_0: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_bridge: link becomes ready
IPv6: ADDRCONF(NETDEV_UP): bridge_slave_1: link is not ready
IPv6: ADDRCONF(NETDEV_UP): veth0_to_team: link is not ready
IPv6: ADDRCONF(NETDEV_UP): veth1_to_team: link is not ready
IPv6: ADDRCONF(NETDEV_UP): bridge_slave_1: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_bridge: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_team: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_0: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_team: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_bridge: link becomes ready
IPv6: ADDRCONF(NETDEV_UP): bridge_slave_0: link is not ready
IPv6: ADDRCONF(NETDEV_UP): bridge_slave_1: link is not ready
IPv6: ADDRCONF(NETDEV_UP): team_slave_1: link is not ready
team0: Port device team_slave_1 added
IPv6: ADDRCONF(NETDEV_UP): bridge_slave_1: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_0: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_bridge: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_bridge: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_bridge: link becomes ready
IPv6: ADDRCONF(NETDEV_UP): bridge_slave_0: link is not ready
IPv6: ADDRCONF(NETDEV_UP): veth1_to_team: link is not ready
IPv6: ADDRCONF(NETDEV_UP): veth0_to_team: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_0: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_bridge: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_team: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_team: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_0: link becomes ready
IPv6: ADDRCONF(NETDEV_UP): bridge_slave_1: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_bridge: link becomes ready
IPv6: ADDRCONF(NETDEV_UP): bridge_slave_0: link is not ready
IPv6: ADDRCONF(NETDEV_UP): veth1_to_team: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_0: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_bridge: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_team: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_1: link becomes ready
IPv6: ADDRCONF(NETDEV_UP): bridge_slave_1: link is not ready
IPv6: ADDRCONF(NETDEV_UP): bridge_slave_0: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_bridge: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_0: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_bridge: link becomes ready
IPv6: ADDRCONF(NETDEV_UP): bridge_slave_1: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_bridge: link becomes ready
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

