Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DABEECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EFE920779
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:21:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EFE920779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729985AbeGPIrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:47:16 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:37603 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbeGPIrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:47:15 -0400
Received: by mail-it0-f72.google.com with SMTP id r10-v6so13264696itc.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 01:21:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Na5lO58XDRRmYXNguPvfmfr1/TVB1Trpq/ciqDxQuq8=;
        b=oYKbNEhymY4aHz78oCD1/V2AgivXx+1aZUJYEbV2MyQESy/ROcHrybPgjLv3FLTZdK
         u+K+la//rFmsZhiChBczoqX02//S1rAjO+y+p4j4YZeaYSGyZCZ/xBO72p3Z4yKW/YD1
         gQAw62spURwrWJ5Ar5LjJivuU8eysY3vUz9GrHsFZ1lLFz7seRfCsbELVG4Rkdg6JcwK
         UEYHVfbWVnp5JrkWb0EVE+8rHoTO/Up4qd1X5O99baLLrQEv/5IrpiogoXbN+CLnvmhb
         GLBGCtS/bhEWZ3QscbIT7bSXNmToakfnp0Lcoq84rERIrH5Eyge7n+d1cVncF3MyAmO4
         mbjg==
X-Gm-Message-State: AOUpUlEkyeDHMk25dLIbFm3nrMx0XZP9v4VLiFsfVSv+jQRkrVY+jNAS
        4yAXnk5tEHoNLAMZhSsU/tN+dCXj9ZOS1+be2Ury3hiDXdg4
X-Google-Smtp-Source: AAOMgpeBfS9+ET2pN2tEQZxvBfSiXeIENvyhnZN6U/wDT4Cg96NgnAUqIeakJJnAPJLPnlIhw3n+UMHBL7dmCUyfFqiCWdLDJwnD
MIME-Version: 1.0
X-Received: by 2002:a24:4643:: with SMTP id j64-v6mr6625957itb.18.1531729262138;
 Mon, 16 Jul 2018 01:21:02 -0700 (PDT)
Date:   Mon, 16 Jul 2018 01:21:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008fe18f05711982f1@google.com>
Subject: KASAN: slab-out-of-bounds Read in tun_net_xmit (2)
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

Hello,

syzbot found the following crash on:

HEAD commit:    8f19f12bdcc6 selftests: in udpgso_bench do not test udp ze..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=153c0c44400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b88de6eac8694da6
dashboard link: https://syzkaller.appspot.com/bug?extid=8993c0fa96d57c399735
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+8993c0fa96d57c399735@syzkaller.appspotmail.com

RDX: 0000000020000000 RSI: 00000000000089e1 RDI: 0000000000000013
RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000014
R13: 00000000004bfe58 R14: 00000000004cf778 R15: 0000000000000001
==================================================================
BUG: KASAN: slab-out-of-bounds in __ptr_ring_produce  
include/linux/ptr_ring.h:110 [inline]
BUG: KASAN: slab-out-of-bounds in ptr_ring_produce  
include/linux/ptr_ring.h:133 [inline]
BUG: KASAN: slab-out-of-bounds in tun_net_xmit+0x1b28/0x1cd0  
drivers/net/tun.c:1119
Read of size 8 at addr ffff8801d7356888 by task syz-executor3/4560

CPU: 0 PID: 4560 Comm: syz-executor3 Not tainted 4.18.0-rc3+ #8
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  __ptr_ring_produce include/linux/ptr_ring.h:110 [inline]
  ptr_ring_produce include/linux/ptr_ring.h:133 [inline]
  tun_net_xmit+0x1b28/0x1cd0 drivers/net/tun.c:1119
  __netdev_start_xmit include/linux/netdevice.h:4148 [inline]
  netdev_start_xmit include/linux/netdevice.h:4157 [inline]
  xmit_one net/core/dev.c:3034 [inline]
  dev_hard_start_xmit+0x26c/0xc30 net/core/dev.c:3050
  sch_direct_xmit+0x486/0x1140 net/sched/sch_generic.c:327
  qdisc_restart net/sched/sch_generic.c:390 [inline]
  __qdisc_run+0x619/0x19f0 net/sched/sch_generic.c:398
  qdisc_run include/net/pkt_sched.h:118 [inline]
  __dev_xmit_skb net/core/dev.c:3229 [inline]
  __dev_queue_xmit+0x13ec/0x38e0 net/core/dev.c:3537
  dev_queue_xmit+0x17/0x20 net/core/dev.c:3602
  neigh_hh_output include/net/neighbour.h:473 [inline]
  neigh_output include/net/neighbour.h:481 [inline]
  ip6_finish_output2+0x135a/0x2820 net/ipv6/ip6_output.c:120
  ip6_finish_output+0x5fe/0xbc0 net/ipv6/ip6_output.c:154
  NF_HOOK_COND include/linux/netfilter.h:276 [inline]
  ip6_output+0x234/0x9d0 net/ipv6/ip6_output.c:171
  dst_output include/net/dst.h:444 [inline]
  NF_HOOK include/linux/netfilter.h:287 [inline]
  mld_sendpack+0xaeb/0xfc0 net/ipv6/mcast.c:1658
  mld_send_cr net/ipv6/mcast.c:1954 [inline]
  mld_ifc_timer_expire+0x447/0x8a0 net/ipv6/mcast.c:2453
  call_timer_fn+0x242/0x970 kernel/time/timer.c:1326
  expire_timers kernel/time/timer.c:1363 [inline]
  __run_timers+0x7a6/0xc70 kernel/time/timer.c:1666
  run_timer_softirq+0x4c/0x70 kernel/time/timer.c:1692
  __do_softirq+0x2e8/0xb17 kernel/softirq.c:288
  invoke_softirq kernel/softirq.c:368 [inline]
  irq_exit+0x1d1/0x200 kernel/softirq.c:408
  exiting_irq arch/x86/include/asm/apic.h:527 [inline]
  smp_apic_timer_interrupt+0x186/0x730 arch/x86/kernel/apic/apic.c:1052
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:863
  </IRQ>
RIP: 0010:__mark_inode_dirty+0x719/0x1550 fs/fs-writeback.c:2147
Code: 00 fc ff df 48 89 fa 48 c1 ea 03 0f b6 14 02 48 89 f8 83 e0 07 83 c0  
03 38 d0 7c 08 84 d2 0f 85 d5 09 00 00 8b 05 f7 17 d4 08 <48> 8d 8b 88 00  
00 00 31 ff 49 89 ce 89 c6 89 85 a0 fd ff ff e8 de
RSP: 0018:ffff8801a2887930 EFLAGS: 00000297 ORIG_RAX: ffffffffffffff13
RAX: 0000000000000000 RBX: ffff88019f664b60 RCX: ffffffff81d170cb
RDX: 0000000000000004 RSI: ffffffff81d175b2 RDI: ffffffff8aa58de0
RBP: ffff8801a2887b98 R08: ffff8801a287e000 R09: ffffed003b5c46d6
R10: ffffed003b5c46d6 R11: ffff8801dae236b3 R12: 0000000000000001
R13: 0000000000000001 R14: 0000000000000000 R15: ffff88019f664c38
  generic_update_time+0x26a/0x450 fs/inode.c:1643
  update_time fs/inode.c:1659 [inline]
  touch_atime+0x29e/0x320 fs/inode.c:1731
  file_accessed include/linux/fs.h:2082 [inline]
  iterate_dir+0x394/0x5d0 fs/readdir.c:56
  __do_sys_getdents fs/readdir.c:231 [inline]
  __se_sys_getdents fs/readdir.c:212 [inline]
  __x64_sys_getdents+0x29f/0x510 fs/readdir.c:212
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x453fbb
Code: 02 74 b6 31 f6 eb b9 0f 1f 84 00 00 00 00 00 41 57 41 56 48 63 ff 41  
55 41 54 b8 4e 00 00 00 55 53 48 89 f3 48 83 ec 08 0f 05 <48> 3d 00 f0 ff  
ff 77 55 4c 8d 24 06 49 89 c5 4c 39 e6 73 33 90 0f
RSP: 002b:0000000000a3d980 EFLAGS: 00000202 ORIG_RAX: 000000000000004e
RAX: ffffffffffffffda RBX: 0000000001bfc970 RCX: 0000000000453fbb
RDX: 0000000000008000 RSI: 0000000001bfc970 RDI: 0000000000000013
RBP: 0000000001bfc970 R08: 0000000000000001 R09: 0000000001bfb940
R10: 0000000000000000 R11: 0000000000000202 R12: ffffffffffffffd4
R13: 0000000000000016 R14: 0000000000a3f160 R15: 0000000000702140

Allocated by task 12926:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  __do_kmalloc_node mm/slab.c:3682 [inline]
  __kmalloc_node+0x47/0x70 mm/slab.c:3689
  kmalloc_node include/linux/slab.h:555 [inline]
  kvmalloc_node+0x65/0xf0 mm/util.c:423
  kvmalloc include/linux/mm.h:557 [inline]
  kvmalloc_array include/linux/mm.h:575 [inline]
  __ptr_ring_init_queue_alloc include/linux/ptr_ring.h:475 [inline]
  ptr_ring_resize_multiple include/linux/ptr_ring.h:635 [inline]
  tun_queue_resize drivers/net/tun.c:3444 [inline]
  tun_device_event+0x567/0x1030 drivers/net/tun.c:3463
  notifier_call_chain+0x180/0x390 kernel/notifier.c:93
  __raw_notifier_call_chain kernel/notifier.c:394 [inline]
  raw_notifier_call_chain+0x2d/0x40 kernel/notifier.c:401
  call_netdevice_notifiers_info+0x3f/0x90 net/core/dev.c:1735
  call_netdevice_notifiers net/core/dev.c:1753 [inline]
  dev_change_tx_queue_len+0x192/0x270 net/core/dev.c:7150
  do_setlink+0xccb/0x3e10 net/core/rtnetlink.c:2398
  rtnl_group_changelink net/core/rtnetlink.c:2834 [inline]
  rtnl_newlink+0x159a/0x1d60 net/core/rtnetlink.c:2992
  rtnetlink_rcv_msg+0x46e/0xc30 net/core/rtnetlink.c:4662
  netlink_rcv_skb+0x172/0x440 net/netlink/af_netlink.c:2448
  rtnetlink_rcv+0x1c/0x20 net/core/rtnetlink.c:4680
  netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
  netlink_unicast+0x5a0/0x760 net/netlink/af_netlink.c:1336
  netlink_sendmsg+0xa18/0xfd0 net/netlink/af_netlink.c:1901
  sock_sendmsg_nosec net/socket.c:641 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:651
  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2125
  __sys_sendmsg+0x11d/0x290 net/socket.c:2163
  __do_sys_sendmsg net/socket.c:2172 [inline]
  __se_sys_sendmsg net/socket.c:2170 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2170
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 2418:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xd9/0x260 mm/slab.c:3813
  kernfs_fop_write+0x18c/0x480 fs/kernfs/file.c:330
  __vfs_write+0x117/0x9f0 fs/read_write.c:485
  vfs_write+0x1f8/0x560 fs/read_write.c:549
  ksys_write+0x101/0x260 fs/read_write.c:598
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8801d7356880
  which belongs to the cache kmalloc-32 of size 32
The buggy address is located 8 bytes inside of
  32-byte region [ffff8801d7356880, ffff8801d73568a0)
The buggy address belongs to the page:
page:ffffea00075cd580 count:1 mapcount:0 mapping:ffff8801da8001c0  
index:0xffff8801d7356fc1
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffffea00075b4b08 ffffea0007510888 ffff8801da8001c0
raw: ffff8801d7356fc1 ffff8801d7356000 0000000100000037 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801d7356780: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
  ffff8801d7356800: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
> ffff8801d7356880: 00 fc fc fc fc fc fc fc 00 00 00 fc fc fc fc fc
                       ^
  ffff8801d7356900: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
  ffff8801d7356980: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
