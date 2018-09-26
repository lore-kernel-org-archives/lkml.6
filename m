Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA439C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6138C21528
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:16:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6138C21528
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbeIZW3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 18:29:45 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:43240 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbeIZW3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 18:29:45 -0400
Received: by mail-io1-f69.google.com with SMTP id w19-v6so52595572ioa.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 09:16:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=W7/7wSjwCgKu1u1XRlpZDX6zhMm3ovgYpIREkcxbw3U=;
        b=jij7AOjkvwYicma0/zPCrYTYrz/B5+aJpyf86ky/s3chYsBsF3M5MZUImj7Zw4sCBa
         +wUnkkYzHHgte9WuxV2TN9vtj3+l8fCpNPt5RlxvsSeRHzwIJCUj1IvJJL0SOb/pDC5z
         HOn8q6EOo+WDtdPxq5F/gprUx9VH1XgNe0Q0oF3xqq9+bsfo1RRfG8rjJta6YqlzuRYO
         WqfCme7Ld+39jHcTwU6F6cmmxG6ngAxaQWOzsRbiP51yMHWcfKI/1gjhIC/f5DC2JxC0
         5FwS+0j506irvUMgr26w5FAdVvOltm7AQcsO+EPDp52PIcOuTP44fpvm3E7n2v0SOxpl
         kfXg==
X-Gm-Message-State: ABuFfohoE+tM3SRDoZNDrmnB/2O1RyHCz0wbbgduVf61IAfKN29LdhIT
        F0RjxWcSH3iKX0XU7Kz+a/VfUV7u6TgmQSplrzqNwcLx8sVt
X-Google-Smtp-Source: ACcGV62F1qfpEOEHReEHefeBj2wZ1lrtWuAcmm4op/kC+jnnVm6DjPtYmPauVu2/ZNYO2z0kMpJ3eXHCNxTu4uwb1/UB8ePEjH1Q
MIME-Version: 1.0
X-Received: by 2002:a6b:4e19:: with SMTP id c25-v6mr4541868iob.69.1537978563736;
 Wed, 26 Sep 2018 09:16:03 -0700 (PDT)
Date:   Wed, 26 Sep 2018 09:16:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f6c5100576c88918@google.com>
Subject: KASAN: use-after-free Read in rtnl_fill_ifinfo
From:   syzbot <syzbot+1e0c7db78acf0d004daf@syzkaller.appspotmail.com>
To:     christian@brauner.io, davem@davemloft.net, dsahern@gmail.com,
        fw@strlen.de, jakub.kicinski@netronome.com, jbenc@redhat.com,
        ktkhai@virtuozzo.com, linux-kernel@vger.kernel.org,
        lucien.xin@gmail.com, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    4b1bd6976945 net: phy: marvell: Fix build.
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1477df9e400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=443816db871edd66
dashboard link: https://syzkaller.appspot.com/bug?extid=1e0c7db78acf0d004daf
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+1e0c7db78acf0d004daf@syzkaller.appspotmail.com

llcp: llcp_sock_recvmsg: Recv datagram failed state 5 -107 0
==================================================================
BUG: KASAN: use-after-free in rtnl_fill_ifinfo+0x420e/0x4670  
net/core/rtnetlink.c:1630
Read of size 8 at addr ffff8801c2e7a4d8 by task syz-executor2/9379

CPU: 1 PID: 9379 Comm: syz-executor2 Not tainted 4.19.0-rc5+ #232
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  rtnl_fill_ifinfo+0x420e/0x4670 net/core/rtnetlink.c:1630
  rtnl_dump_ifinfo+0x90a/0x1130 net/core/rtnetlink.c:1943
  netlink_dump+0x519/0xd50 net/netlink/af_netlink.c:2226
  netlink_recvmsg+0xf6f/0x1480 net/netlink/af_netlink.c:1984
  sock_recvmsg_nosec+0x8c/0xb0 net/socket.c:794
  ___sys_recvmsg+0x2b6/0x680 net/socket.c:2278
  __sys_recvmmsg+0x303/0xb90 net/socket.c:2390
  do_sys_recvmmsg+0xec/0x1a0 net/socket.c:2471
  __do_sys_recvmmsg net/socket.c:2484 [inline]
  __se_sys_recvmmsg net/socket.c:2480 [inline]
  __x64_sys_recvmmsg+0xbe/0x150 net/socket.c:2480
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457579
Code: 1d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f3e5c58cc78 EFLAGS: 00000246
  ORIG_RAX: 000000000000012b
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 0000000000457579
RDX: 04000000000000f6 RSI: 00000000200037c0 RDI: 0000000000000003
RBP: 000000000072bfa0 R08: 0000000020003700 R09: 0000000000000000
R10: 0000000000000006 R11: 0000000000000246 R12: 00007f3e5c58d6d4
R13: 00000000004c3258 R14: 00000000004d4de8 R15: 00000000ffffffff

Allocated by task 5629:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  __do_kmalloc_node mm/slab.c:3682 [inline]
  __kmalloc_node+0x47/0x70 mm/slab.c:3689
  kmalloc_node include/linux/slab.h:555 [inline]
  kzalloc_node include/linux/slab.h:718 [inline]
  qdisc_alloc+0x10f/0xb50 net/sched/sch_generic.c:820
  qdisc_create_dflt+0x7a/0x1e0 net/sched/sch_generic.c:894
  attach_one_default_qdisc net/sched/sch_generic.c:1041 [inline]
  netdev_for_each_tx_queue include/linux/netdevice.h:2114 [inline]
  attach_default_qdiscs net/sched/sch_generic.c:1060 [inline]
  dev_activate+0x82f/0xcb0 net/sched/sch_generic.c:1103
  __dev_open+0x2cb/0x410 net/core/dev.c:1400
  dev_open+0xf2/0x1b0 net/core/dev.c:1426
  bond_enslave+0xfca/0x5f90 drivers/net/bonding/bond_main.c:1531
  do_set_master+0x1c9/0x220 net/core/rtnetlink.c:2313
  do_setlink+0xbe6/0x3f20 net/core/rtnetlink.c:2447
  rtnl_newlink+0x136f/0x1d40 net/core/rtnetlink.c:3054
  rtnetlink_rcv_msg+0x46a/0xc20 net/core/rtnetlink.c:4730
  netlink_rcv_skb+0x172/0x440 net/netlink/af_netlink.c:2447
  rtnetlink_rcv+0x1c/0x20 net/core/rtnetlink.c:4748
  netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
  netlink_unicast+0x5a5/0x760 net/netlink/af_netlink.c:1336
  netlink_sendmsg+0xa18/0xfc0 net/netlink/af_netlink.c:1901
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:631
  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2116
  __sys_sendmsg+0x11d/0x280 net/socket.c:2154
  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg net/socket.c:2161 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 5520:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3813
  qdisc_free+0x89/0x100 net/sched/sch_generic.c:941
  qdisc_free_cb+0x19/0x20 net/sched/sch_generic.c:948
  __rcu_reclaim kernel/rcu/rcu.h:236 [inline]
  rcu_do_batch kernel/rcu/tree.c:2576 [inline]
  invoke_rcu_callbacks kernel/rcu/tree.c:2880 [inline]
  __rcu_process_callbacks kernel/rcu/tree.c:2847 [inline]
  rcu_process_callbacks+0xf23/0x2670 kernel/rcu/tree.c:2864
  __do_softirq+0x30b/0xad8 kernel/softirq.c:292

The buggy address belongs to the object at ffff8801c2e7a4c0
  which belongs to the cache kmalloc-1024 of size 1024
The buggy address is located 24 bytes inside of
  1024-byte region [ffff8801c2e7a4c0, ffff8801c2e7a8c0)
The buggy address belongs to the page:
page:ffffea00070b9e80 count:1 mapcount:0 mapping:ffff8801da800ac0 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000008100(slab|head)
raw: 02fffc0000008100 ffffea0007081708 ffffea00071f2688 ffff8801da800ac0
raw: 0000000000000000 ffff8801c2e7a040 0000000100000007 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801c2e7a380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801c2e7a400: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> ffff8801c2e7a480: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
                                                     ^
  ffff8801c2e7a500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801c2e7a580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
