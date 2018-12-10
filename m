Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9520C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C2AC205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:51:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C2AC205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbeLJHvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 02:51:08 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:43966 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbeLJHvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 02:51:05 -0500
Received: by mail-io1-f72.google.com with SMTP id k4so10493119ioc.10
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 23:51:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=bbeR77WLkURfcQZItwaOi/Dxdmie58Iaj/gaRr3ztpY=;
        b=S6/7MA+FlZb2FhLLGUBM388bng+8/TVkVAldY0nupP0ikqqaKU8qxdG6I4OsTQzJVV
         QcCYQZJxY51YakObJp7miwXeXj8eU8k/Un4IB1/X8N8hE1fN0+rH+qG8kXFT1T1ymfC4
         GMAIqK0SVEpIBHJmVF2IVW8wyQXHK2BTWsfw52UOfWiWMZ2mPH6vBk+vLtOLVd7oMy6e
         y9CrHHHtdqIjxT5ERvyh1XwrTdorfpKFBF3ShYs8RKT+FE8FeGSqNo8KxuCVrzXzHF1R
         7QrzUYmzi92DZ31HsXqp5o/X37EdD8z7nEWfaL2+J2TN2i+4kTj/RICOc5DmTcoUZhOG
         CGKQ==
X-Gm-Message-State: AA+aEWb+ZhUBxDg9J5DEr4Qqc9yPgrnyU80ZINa3W8i+gD1zfhAvat+j
        wGCuyLj9ft/mVqAyNVCqcK6HRQL93FcI+G1N19lymAHU1Ttj
X-Google-Smtp-Source: AFSGD/UCALTGzcuPhbT7fJiPTtl8/D5OdiAXZea1Z2E+kIfIZtCumZ2/j+LN2lRoAelqGJkSEgAFGQjpd3h4Qvg7TjYxVwfDycTm
MIME-Version: 1.0
X-Received: by 2002:a24:454e:: with SMTP id y75mr9315485ita.37.1544428263633;
 Sun, 09 Dec 2018 23:51:03 -0800 (PST)
Date:   Sun, 09 Dec 2018 23:51:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000008ff3b057ca63a31@google.com>
Subject: KASAN: slab-out-of-bounds Read in ___neigh_create
From:   syzbot <syzbot+3ddead5619658537909b@syzkaller.appspotmail.com>
To:     christian@brauner.io, davem@davemloft.net, dsahern@gmail.com,
        edumazet@google.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, roopa@cumulusnetworks.com,
        syzkaller-bugs@googlegroups.com, w.bumiller@proxmox.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    a60956ed72f7 net: dsa: Make dsa_master_set_mtu() static
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17d2f3f5400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28ecefa8a6e10719
dashboard link: https://syzkaller.appspot.com/bug?extid=3ddead5619658537909b
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+3ddead5619658537909b@syzkaller.appspotmail.com

syz-executor0 (7463) used greatest stack depth: 14544 bytes left
audit: type=1804 audit(1544397792.605:33): pid=7506 uid=0 auid=4294967295  
ses=4294967295 subj==unconfined op=invalid_pcr cause=open_writers  
comm="syz-executor0"  
name="/root/syzkaller-testdir029218375/syzkaller.aGerof/1/memory.events"  
dev="sda1" ino=16519 res=1
==================================================================
BUG: KASAN: slab-out-of-bounds in __list_add_valid+0x8f/0xac  
lib/list_debug.c:26
Read of size 8 at addr ffff8881ca015db0 by task syz-executor2/7521

CPU: 1 PID: 7521 Comm: syz-executor2 Not tainted 4.20.0-rc4+ #335
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.8+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  __list_add_valid+0x8f/0xac lib/list_debug.c:26
  __list_add include/linux/list.h:60 [inline]
  list_add_tail include/linux/list.h:93 [inline]
  neigh_alloc net/core/neighbour.c:395 [inline]
  ___neigh_create+0x14b7/0x2600 net/core/neighbour.c:553
  __neigh_create+0x30/0x40 net/core/neighbour.c:640
  ip_finish_output2+0xb8b/0x1860 net/ipv4/ip_output.c:224
  ip_finish_output+0x7fd/0xfa0 net/ipv4/ip_output.c:317
  NF_HOOK_COND include/linux/netfilter.h:278 [inline]
  ip_mc_output+0x2c4/0x15b0 net/ipv4/ip_output.c:390
  dst_output include/net/dst.h:444 [inline]
  ip_local_out+0xc5/0x1b0 net/ipv4/ip_output.c:124
  ip_send_skb+0x40/0xe0 net/ipv4/ip_output.c:1464
  udp_send_skb.isra.46+0x6ad/0x1160 net/ipv4/udp.c:929
  udp_sendmsg+0x2953/0x3c40 net/ipv4/udp.c:1216
  inet_sendmsg+0x1a1/0x690 net/ipv4/af_inet.c:798
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:631
  ___sys_sendmsg+0x51d/0x930 net/socket.c:2116
  __sys_sendmmsg+0x246/0x6d0 net/socket.c:2211
  __do_sys_sendmmsg net/socket.c:2240 [inline]
  __se_sys_sendmmsg net/socket.c:2237 [inline]
  __x64_sys_sendmmsg+0x9d/0x100 net/socket.c:2237
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457659
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f0c5d66fc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 0000000000457659
RDX: 04000000000001a8 RSI: 0000000020007fc0 RDI: 0000000000000004
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f0c5d6706d4
R13: 00000000004c3e14 R14: 00000000004d6c38 R15: 00000000ffffffff

Allocated by task 7079:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
  kmem_cache_alloc+0x12e/0x730 mm/slab.c:3554
  kmem_cache_zalloc include/linux/slab.h:731 [inline]
  copy_signal kernel/fork.c:1521 [inline]
  copy_process+0x2aba/0x87a0 kernel/fork.c:1914
  _do_fork+0x1cb/0x11d0 kernel/fork.c:2216
  __do_sys_clone kernel/fork.c:2323 [inline]
  __se_sys_clone kernel/fork.c:2317 [inline]
  __x64_sys_clone+0xbf/0x150 kernel/fork.c:2317
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 7091:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kmem_cache_free+0x83/0x290 mm/slab.c:3760
  free_signal_struct kernel/fork.c:707 [inline]
  put_signal_struct kernel/fork.c:713 [inline]
  __put_task_struct+0x3cd/0x620 kernel/fork.c:727
  put_task_struct include/linux/sched/task.h:96 [inline]
  delayed_put_task_struct+0x2ff/0x4c0 kernel/exit.c:181
  __rcu_reclaim kernel/rcu/rcu.h:240 [inline]
  rcu_do_batch kernel/rcu/tree.c:2437 [inline]
  invoke_rcu_callbacks kernel/rcu/tree.c:2716 [inline]
  rcu_process_callbacks+0x100a/0x1ac0 kernel/rcu/tree.c:2697
  __do_softirq+0x308/0xb7e kernel/softirq.c:292

The buggy address belongs to the object at ffff8881ca015800
  which belongs to the cache signal_cache of size 1328
The buggy address is located 128 bytes to the right of
  1328-byte region [ffff8881ca015800, ffff8881ca015d30)
The buggy address belongs to the page:
page:ffffea0007280500 count:1 mapcount:0 mapping:ffff8881da97adc0 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000010200(slab|head)
raw: 02fffc0000010200 ffffea000731ae08 ffffea00070cc708 ffff8881da97adc0
raw: 0000000000000000 ffff8881ca014100 0000000100000005 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881ca015c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881ca015d00: fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc
> ffff8881ca015d80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                      ^
  ffff8881ca015e00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8881ca015e80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
