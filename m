Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E18C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 08:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8E19213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 08:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbeLaIFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 03:05:05 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:40916 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbeLaIFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 03:05:04 -0500
Received: by mail-io1-f69.google.com with SMTP id u2so30903871iob.7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 00:05:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=YsiI9pGUEcXjsSpmuoCry1FQbVbScVIXcfTujLlsvnw=;
        b=Zi7cOgFZz3DE7cwxC5XoF+H0uIH+iskIRAHv9IsdJjUMiU2oFUM9khcsnCMfaMO69B
         1b3ER5v8yFq6SQwOVUQi4lRyov2l3i3+6q2w5gjZTFdxfrFVg7obljD7DnpmXilboQX+
         WeKWmACbXBKQ+Pwn9nOq7rPc/LtOU5ExjllDYx7zwiK/RTIiQ3wp6vIalyAUABwD8fdx
         qC54nEStdbTY3qCLU8tl+qvr9Cb+dUsSAauajmxvgTIEYfp1k4RHKpcDgff2U3+EaYXN
         v7b6N3RU4DTKg4b5TuIToWK3qgJz5Wx5EFM3tbJGaz6lutk1KKtwv0pw+0XmE4lJ/No8
         Ga5g==
X-Gm-Message-State: AA+aEWYNkNzxsfiHO5fXUUN2wex3Yek9UdT/kF7M6nno3VLfCCBdLRXE
        iA5ciOuooscL7+rBp5IEsdp3Z/6KFo0/oLyA3YUr7eJi8pxH
X-Google-Smtp-Source: AFSGD/Vd1MNKmt2dkLwj0b/Z4f/bsftH2BdFOCBTHn3Sd1pDPBFf1PAq2m+A5pazKQgsuJH/0qvE4c69seg/VibxoN8r6X0UBvk0
MIME-Version: 1.0
X-Received: by 2002:a24:6fd1:: with SMTP id x200mr27986027itb.26.1546243503440;
 Mon, 31 Dec 2018 00:05:03 -0800 (PST)
Date:   Mon, 31 Dec 2018 00:05:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c24fa7057e4cdee6@google.com>
Subject: KASAN: use-after-free Read in xfrm_policy_inexact_insert
From:   syzbot <syzbot+9aba39977d8f64b9b1b1@syzkaller.appspotmail.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        steffen.klassert@secunet.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    24894bc6eabc Merge branch 'neigh-get-support'
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13ee4ddb400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1f6442435a55ea09
dashboard link: https://syzkaller.appspot.com/bug?extid=9aba39977d8f64b9b1b1
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+9aba39977d8f64b9b1b1@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in xfrm_policy_insert_inexact_list  
net/xfrm/xfrm_policy.c:1497 [inline]
BUG: KASAN: use-after-free in xfrm_policy_inexact_insert+0xcd1/0xee0  
net/xfrm/xfrm_policy.c:1202
Read of size 1 at addr ffff888190d1b419 by task syz-executor0/24704

CPU: 1 PID: 24704 Comm: syz-executor0 Not tainted 4.20.0-rc6+ #354
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.8+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load1_noabort+0x14/0x20 mm/kasan/report.c:430
  xfrm_policy_insert_inexact_list net/xfrm/xfrm_policy.c:1497 [inline]
  xfrm_policy_inexact_insert+0xcd1/0xee0 net/xfrm/xfrm_policy.c:1202
  xfrm_policy_insert+0x639/0x850 net/xfrm/xfrm_policy.c:1570
  xfrm_add_policy+0x2a0/0x6f0 net/xfrm/xfrm_user.c:1657
  xfrm_user_rcv_msg+0x44c/0x8e0 net/xfrm/xfrm_user.c:2663
  netlink_rcv_skb+0x16c/0x430 net/netlink/af_netlink.c:2477
  xfrm_netlink_rcv+0x6f/0x90 net/xfrm/xfrm_user.c:2671
  netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
  netlink_unicast+0x59f/0x750 net/netlink/af_netlink.c:1336
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
RIP: 0033:0x457669
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f1f5431ac78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457669
RDX: 0000000000000000 RSI: 000000002014f000 RDI: 0000000000000006
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f1f5431b6d4
R13: 00000000004c44d8 R14: 00000000004d74e8 R15: 00000000ffffffff

Allocated by task 24123:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  __do_kmalloc_node mm/slab.c:3684 [inline]
  __kmalloc_node_track_caller+0x50/0x70 mm/slab.c:3698
  __kmalloc_reserve.isra.41+0x41/0xe0 net/core/skbuff.c:140
  pskb_expand_head+0x22a/0x10d0 net/core/skbuff.c:1465
  __skb_cow include/linux/skbuff.h:2970 [inline]
  skb_cow_head include/linux/skbuff.h:3004 [inline]
  l2tp_xmit_skb+0x1014/0x15f0 net/l2tp/l2tp_core.c:1069
  pppol2tp_sendmsg+0x4b1/0x6c0 net/l2tp/l2tp_ppp.c:333
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:631
  ___sys_sendmsg+0x51d/0x930 net/socket.c:2116
  __sys_sendmmsg+0x246/0x6d0 net/socket.c:2211
  __do_sys_sendmmsg net/socket.c:2240 [inline]
  __se_sys_sendmmsg net/socket.c:2237 [inline]
  __x64_sys_sendmmsg+0x9d/0x100 net/socket.c:2237
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 24123:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3817
  skb_free_head+0x93/0xb0 net/core/skbuff.c:553
  skb_release_data+0x706/0x990 net/core/skbuff.c:573
  skb_release_all+0x4a/0x60 net/core/skbuff.c:627
  __kfree_skb net/core/skbuff.c:641 [inline]
  kfree_skb+0x1bb/0x580 net/core/skbuff.c:659
  l2tp_xmit_skb+0xf03/0x15f0 net/l2tp/l2tp_core.c:1085
  pppol2tp_sendmsg+0x4b1/0x6c0 net/l2tp/l2tp_ppp.c:333
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:631
  ___sys_sendmsg+0x51d/0x930 net/socket.c:2116
  __sys_sendmmsg+0x246/0x6d0 net/socket.c:2211
  __do_sys_sendmmsg net/socket.c:2240 [inline]
  __se_sys_sendmmsg net/socket.c:2237 [inline]
  __x64_sys_sendmmsg+0x9d/0x100 net/socket.c:2237
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff888190d1b200
  which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 537 bytes inside of
  1024-byte region [ffff888190d1b200, ffff888190d1b600)
The buggy address belongs to the page:
page:ffffea0006434680 count:1 mapcount:0 mapping:ffff8881da800ac0  
index:0xffff888190d1a480 compound_mapcount: 0
flags: 0x2fffc0000010200(slab|head)
raw: 02fffc0000010200 ffffea00070c7f08 ffffea0006f60608 ffff8881da800ac0
raw: ffff888190d1a480 ffff888190d1a000 0000000100000003 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff888190d1b300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff888190d1b380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff888190d1b400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                             ^
  ffff888190d1b480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff888190d1b500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
