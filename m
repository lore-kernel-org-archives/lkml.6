Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58388C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E53220855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:52:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E53220855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbeLJHwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 02:52:05 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:46872 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbeLJHwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 02:52:05 -0500
Received: by mail-io1-f71.google.com with SMTP id n25so10699163iog.13
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 23:52:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=j777Nh1HgzxGI85n+XlRvGpuqaBC63+tS1N1P+zs9RI=;
        b=he9HM5c27rxsikNBQKGkCJIF5VDonNmbOcFGbDIAkuQUPA8yUR54zdQbIC8NB3+Lo0
         oz5eaSFgR7kufo+CTeJFqrffNNi44cRsyLCb1kcMQGl/F2y9tRnsVYo4K4BWctLu7d2K
         X5SXAEu1GNBt0s7hzpyZG3ZNF2EldmxCsmHXyAMdU+W3gCXV0Jq2/mOQ9CUMIh0owoRb
         8v7wA7rjxS1ZMRL729emz5NvcpkcWTQge2KVI0GHYHaFbu9bcMgaLc7I1o54JHLWJglv
         8K8hhL9z1p2lLPdOPoskalx9e9s5STdGZpoRq8zqNItzEkRbeNJBvL3gJ2yci2TNeUjD
         XxZQ==
X-Gm-Message-State: AA+aEWaMaGM/bNn6kY4Y9ks975ezSO3UwG9gU6tgaBYffRFYOgf0Sw5V
        A5753KZXCPG2rOcxy15G+WCKhnkG9tvTStiI5umH1j1RJVf5
X-Google-Smtp-Source: AFSGD/Wfxyr4o/OyLqagyvciOz9gr7qcWvbLbApdf4vJcSNPJ5LQmNlNV6+ESL6e6kI7E9UzWHRP4UU3l1Ki9NA6QJatRekPWldh
MIME-Version: 1.0
X-Received: by 2002:a24:4597:: with SMTP id c23mr9209104itd.20.1544428323971;
 Sun, 09 Dec 2018 23:52:03 -0800 (PST)
Date:   Sun, 09 Dec 2018 23:52:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a1adb3057ca63d3b@google.com>
Subject: KASAN: use-after-free Read in ___neigh_create
From:   syzbot <syzbot+e4d42eb35f6a27b0a628@syzkaller.appspotmail.com>
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

HEAD commit:    83af01ba1c2d Merge branch 'tc-testing-next'
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15562a43400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28ecefa8a6e10719
dashboard link: https://syzkaller.appspot.com/bug?extid=e4d42eb35f6a27b0a628
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e4d42eb35f6a27b0a628@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __list_add_valid+0x8f/0xac lib/list_debug.c:26
Read of size 8 at addr ffff8881b83e4bb0 by task syz-executor4/14957

CPU: 0 PID: 14957 Comm: syz-executor4 Not tainted 4.20.0-rc4+ #333
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
  ip_send_skb+0x40/0xe0 net/ipv4/ip_output.c:1463
  udp_send_skb.isra.46+0x6ad/0x1160 net/ipv4/udp.c:929
  udp_sendmsg+0x2953/0x3c40 net/ipv4/udp.c:1216
  udpv6_sendmsg+0x182c/0x36a0 net/ipv6/udp.c:1316
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
RIP: 0033:0x457569
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fe6733c8c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 0000000000457569
RDX: 04000000000001da RSI: 0000000020000080 RDI: 0000000000000004
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fe6733c96d4
R13: 00000000004c3c33 R14: 00000000004d6248 R15: 00000000ffffffff

Allocated by task 14937:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  __do_kmalloc mm/slab.c:3722 [inline]
  __kmalloc+0x15b/0x760 mm/slab.c:3731
  kmalloc include/linux/slab.h:551 [inline]
  kzalloc include/linux/slab.h:741 [inline]
  neigh_alloc net/core/neighbour.c:375 [inline]
  ___neigh_create+0x13fc/0x2600 net/core/neighbour.c:553
  neigh_add+0xbaa/0xd90 net/core/neighbour.c:1865
  rtnetlink_rcv_msg+0x46a/0xc20 net/core/rtnetlink.c:4966
  netlink_rcv_skb+0x172/0x440 net/netlink/af_netlink.c:2477
  rtnetlink_rcv+0x1c/0x20 net/core/rtnetlink.c:4984
  netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
  netlink_unicast+0x5a5/0x760 net/netlink/af_netlink.c:1336
  netlink_sendmsg+0xa18/0xfc0 net/netlink/af_netlink.c:1917
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:631
  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2116
  __sys_sendmsg+0x11d/0x280 net/socket.c:2154
  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg net/socket.c:2161 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 14947:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3817
  __rcu_reclaim kernel/rcu/rcu.h:233 [inline]
  rcu_do_batch kernel/rcu/tree.c:2437 [inline]
  invoke_rcu_callbacks kernel/rcu/tree.c:2716 [inline]
  rcu_process_callbacks+0x1140/0x1ac0 kernel/rcu/tree.c:2697
  __do_softirq+0x308/0xb7e kernel/softirq.c:292

The buggy address belongs to the object at ffff8881b83e4940
  which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 624 bytes inside of
  1024-byte region [ffff8881b83e4940, ffff8881b83e4d40)
The buggy address belongs to the page:
page:ffffea0006e0f900 count:1 mapcount:0 mapping:ffff8881da800ac0 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000010200(slab|head)
raw: 02fffc0000010200 ffffea000666bf08 ffffea0006d00788 ffff8881da800ac0
raw: 0000000000000000 ffff8881b83e4040 0000000100000007 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881b83e4a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881b83e4b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8881b83e4b80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                      ^
  ffff8881b83e4c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881b83e4c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
