Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FD9C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 18:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D49D20836
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 18:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbeL3SBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 13:01:04 -0500
Received: from mail-it1-f199.google.com ([209.85.166.199]:44066 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbeL3SBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 13:01:04 -0500
Received: by mail-it1-f199.google.com with SMTP id x82so30222899ita.9
        for <linux-kernel@vger.kernel.org>; Sun, 30 Dec 2018 10:01:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=moJov1ggopCANY9n3kR0xN/GZN/0nAiLwn+tJGDXHEk=;
        b=iog8ZoikcHf6n4KfJMDD6hPgc5usfpk3K4Gd8x+hfZzFKwmupal2wyKE1qyGOY89nT
         WOJB+QTesiNLWE1MnnKIjjFRe6YDMFIFVwjoa+EbXyF21MxJaYYP8hlHTSQCrPBwYsyr
         NjgPvdXPXY6B30SFrmZsKRGq9l8MxkbJw8duWK+kcnOtviYQfTbCwANFTlnneNOa+rwV
         aWB4fwWUH/iEF/7ZJ3gXz3iG7MRZTFzEZ5q6AlaINPd8N2t82rvYuR1/7g16QbEDIeWe
         v2G+BGnwYYYakdfeCWICpgSoEsej1+TBYAETO5DmKNrIaFpGNhhaJHQ+Lyp0bs/bJjiK
         DPtw==
X-Gm-Message-State: AA+aEWYh93ZTWXoiPeOALWMsGr4EACzUljHMv40VMRZjmGspxm+sUWlt
        4vvJb+jej8QqQygG5seue41eNA4Fafn4HFPsMbl+8hXgxmde
X-Google-Smtp-Source: AFSGD/VcrD3pQ2z3lYMglnKykHwpQI6CB83wR88EKHqY5TUBwpk6Vvnl7Nzw+OKMejyDmy8nzd0MmHCBaPFIX6hHYWmlRJla6kcq
MIME-Version: 1.0
X-Received: by 2002:a24:a945:: with SMTP id x5mr26986911iti.26.1546192863133;
 Sun, 30 Dec 2018 10:01:03 -0800 (PST)
Date:   Sun, 30 Dec 2018 10:01:03 -0800
In-Reply-To: <0000000000008fe18f05711982f1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005c921a057e4114a2@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in tun_net_xmit (2)
From:   syzbot <syzbot+8993c0fa96d57c399735@syzkaller.appspotmail.com>
To:     brouer@redhat.com, davem@davemloft.net, edumazet@google.com,
        jasowang@redhat.com, linux-kernel@vger.kernel.org, mst@redhat.com,
        netdev@vger.kernel.org, peterpenkov96@gmail.com,
        sd@queasysnail.net, syzkaller-bugs@googlegroups.com,
        willemb@google.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    b71acb0e3721 Merge branch 'linus' of git://git.kernel.org/..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14494353400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4b137b8ba637eb77
dashboard link: https://syzkaller.appspot.com/bug?extid=8993c0fa96d57c399735
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11a01577400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=174baeab400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+8993c0fa96d57c399735@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_CHANGE): hsr0: link becomes ready
IPv6: ADDRCONF(NETDEV_UP): vxcan1: link is not ready
8021q: adding VLAN 0 to HW filter on device batadv0
nf_conntrack: default automatic helper assignment has been turned off for  
security reasons and CT-based  firewall rule not found. Use the iptables CT  
target to attach helpers instead.
==================================================================
BUG: KASAN: slab-out-of-bounds in __ptr_ring_produce  
include/linux/ptr_ring.h:110 [inline]
BUG: KASAN: slab-out-of-bounds in ptr_ring_produce  
include/linux/ptr_ring.h:133 [inline]
BUG: KASAN: slab-out-of-bounds in tun_net_xmit+0x197e/0x1be0  
drivers/net/tun.c:1119
Read of size 8 at addr ffff88809fa64f48 by task swapper/0/0

CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.20.0+ #363
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d3/0x2c6 lib/dump_stack.c:113
  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  __ptr_ring_produce include/linux/ptr_ring.h:110 [inline]
  ptr_ring_produce include/linux/ptr_ring.h:133 [inline]
  tun_net_xmit+0x197e/0x1be0 drivers/net/tun.c:1119
  __netdev_start_xmit include/linux/netdevice.h:4382 [inline]
  netdev_start_xmit include/linux/netdevice.h:4391 [inline]
  xmit_one net/core/dev.c:3278 [inline]
  dev_hard_start_xmit+0x286/0xc80 net/core/dev.c:3294
  sch_direct_xmit+0x48b/0x1130 net/sched/sch_generic.c:327
  qdisc_restart net/sched/sch_generic.c:390 [inline]
  __qdisc_run+0x624/0x19f0 net/sched/sch_generic.c:398
  qdisc_run include/net/pkt_sched.h:121 [inline]
  __dev_xmit_skb net/core/dev.c:3473 [inline]
  __dev_queue_xmit+0x190c/0x3ac0 net/core/dev.c:3832
  dev_queue_xmit+0x17/0x20 net/core/dev.c:3897
  neigh_hh_output include/net/neighbour.h:498 [inline]
  neigh_output include/net/neighbour.h:506 [inline]
  ip6_finish_output2+0x144e/0x2930 net/ipv6/ip6_output.c:120
  ip6_finish_output+0x583/0xc50 net/ipv6/ip6_output.c:154
  NF_HOOK_COND include/linux/netfilter.h:278 [inline]
  ip6_output+0x232/0x9d0 net/ipv6/ip6_output.c:171
  dst_output include/net/dst.h:444 [inline]
  NF_HOOK include/linux/netfilter.h:289 [inline]
  mld_sendpack+0xac9/0xfa0 net/ipv6/mcast.c:1683
  mld_send_initial_cr.part.32+0x114/0x160 net/ipv6/mcast.c:2100
  mld_send_initial_cr net/ipv6/mcast.c:2084 [inline]
  mld_dad_timer_expire+0x42/0x1b0 net/ipv6/mcast.c:2119
  call_timer_fn+0x272/0x920 kernel/time/timer.c:1325
  expire_timers kernel/time/timer.c:1362 [inline]
  __run_timers+0x7e5/0xc70 kernel/time/timer.c:1681
  run_timer_softirq+0x52/0xb0 kernel/time/timer.c:1694
  __do_softirq+0x30c/0xb2e kernel/softirq.c:292
  invoke_softirq kernel/softirq.c:373 [inline]
  irq_exit+0x17f/0x1c0 kernel/softirq.c:413
  exiting_irq arch/x86/include/asm/apic.h:536 [inline]
  smp_apic_timer_interrupt+0x1cb/0x760 arch/x86/kernel/apic/apic.c:1062
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:807
  </IRQ>
RIP: 0010:native_safe_halt+0x6/0x10 arch/x86/include/asm/irqflags.h:58
Code: e9 2c ff ff ff 48 89 c7 48 89 45 d8 e8 a3 84 c9 f9 48 8b 45 d8 e9 ca  
fe ff ff 48 89 df e8 92 84 c9 f9 eb 82 55 48 89 e5 fb f4 <5d> c3 0f 1f 84  
00 00 00 00 00 55 48 89 e5 f4 5d c3 90 90 90 90 90
RSP: 0018:ffffffff89607c20 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff13
RAX: dffffc0000000000 RBX: 1ffffffff12c0f88 RCX: 0000000000000000
RDX: 1ffffffff12e4969 RSI: 0000000000000001 RDI: ffffffff89724b48
RBP: ffffffff89607c20 R08: ffffffff8967aec0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff89607ce0
R13: ffffffff8a3a3260 R14: 0000000000000000 R15: 0000000000000000
  arch_safe_halt arch/x86/include/asm/paravirt.h:156 [inline]
  default_idle+0xbf/0x490 arch/x86/kernel/process.c:564
  arch_cpu_idle+0x10/0x20 arch/x86/kernel/process.c:555
  default_idle_call+0x6d/0x90 kernel/sched/idle.c:93
  cpuidle_idle_call kernel/sched/idle.c:153 [inline]
  do_idle+0x3db/0x5b0 kernel/sched/idle.c:262
  cpu_startup_entry+0x18/0x20 kernel/sched/idle.c:353
  rest_init+0x243/0x372 init/main.c:443
  arch_call_rest_init+0xe/0x1b
  start_kernel+0x873/0x8ae init/main.c:741
  x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:470
  x86_64_start_kernel+0x76/0x79 arch/x86/kernel/head64.c:451
  secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:243

Allocated by task 7497:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  __do_kmalloc_node mm/slab.c:3684 [inline]
  __kmalloc_node+0x50/0x70 mm/slab.c:3691
  kmalloc_node include/linux/slab.h:589 [inline]
  kvmalloc_node+0x65/0xf0 mm/util.c:416
  kvmalloc include/linux/mm.h:577 [inline]
  kvmalloc_array include/linux/mm.h:595 [inline]
  __ptr_ring_init_queue_alloc include/linux/ptr_ring.h:475 [inline]
  ptr_ring_resize_multiple include/linux/ptr_ring.h:635 [inline]
  tun_queue_resize drivers/net/tun.c:3606 [inline]
  tun_device_event+0x56a/0x106c drivers/net/tun.c:3625
  notifier_call_chain+0x17e/0x380 kernel/notifier.c:93
  __raw_notifier_call_chain kernel/notifier.c:394 [inline]
  raw_notifier_call_chain+0x2d/0x40 kernel/notifier.c:401
  call_netdevice_notifiers_info+0x3f/0x90 net/core/dev.c:1739
  call_netdevice_notifiers_extack net/core/dev.c:1751 [inline]
  call_netdevice_notifiers net/core/dev.c:1765 [inline]
  dev_change_tx_queue_len+0x188/0x270 net/core/dev.c:7742
  dev_ifsioc+0x79b/0xa80 net/core/dev_ioctl.c:287
  dev_ioctl+0x1b5/0xcc0 net/core/dev_ioctl.c:488
  sock_do_ioctl+0x1f6/0x420 net/socket.c:973
  sock_ioctl+0x313/0x690 net/socket.c:1074
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0x1de/0x1790 fs/ioctl.c:696
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 4400:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3817
  single_release+0x8f/0xb0 fs/seq_file.c:597
  __fput+0x385/0xa30 fs/file_table.c:278
  ____fput+0x15/0x20 fs/file_table.c:309
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff88809fa64f40
  which belongs to the cache kmalloc-32 of size 32
The buggy address is located 8 bytes inside of
  32-byte region [ffff88809fa64f40, ffff88809fa64f60)
The buggy address belongs to the page:
page:ffffea00027e9900 count:1 mapcount:0 mapping:ffff88812c3f01c0  
index:0xffff88809fa64fc1
flags: 0x1fffc0000000200(slab)
raw: 01fffc0000000200 ffffea0002837048 ffffea00028f0888 ffff88812c3f01c0
raw: ffff88809fa64fc1 ffff88809fa64000 000000010000003f 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff88809fa64e00: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
  ffff88809fa64e80: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
> ffff88809fa64f00: fb fb fb fb fc fc fc fc 00 fc fc fc fc fc fc fc
                                               ^
  ffff88809fa64f80: 06 fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff88809fa65000: fc fc fc fc fc fc fc fc 00 00 00 00 00 00 00 00
==================================================================

