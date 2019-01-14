Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC0FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 07:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BD0A20659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 07:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfANHRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 02:17:05 -0500
Received: from mail-it1-f199.google.com ([209.85.166.199]:37313 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfANHRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 02:17:05 -0500
Received: by mail-it1-f199.google.com with SMTP id y86so8773716ita.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jan 2019 23:17:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=k+y+3Mw8xKvPSZLcSfWoKpJNBDwQU475JLGPCLPtU7M=;
        b=Ciq4aW34i7Dg6VfIBnOMQUHPteNvCKqeag5j0sN46a+0AgOw2t4XatDlVScSKvqAmn
         xcNqGdWrcN3jVE66tmytn/4sJARclfwc/zPceVIsWs0xcezanNg8d/o9BARSj0Rp5FLw
         2zTUhkUggJjsZtWeZxkMGogpbPVZQuyJlolIT1vrpr9aXQAibrxGjhl+dcxuxZ7Vsom6
         wTsjas4+1na00qFaRVeikG4tc6c0gWJp8R39bE9wUjCXL8biGk/AVBEu8gu6+nrwMEQa
         hWymq9wMMIxXynd4UJCAVL9Q4y+iukK7lQfhx/L1js8BM/3+/tYYSXFGb31WYk6dDSU3
         R4iA==
X-Gm-Message-State: AJcUukc4AOBbcyG4y9OsyCp4XBb5EwDEbuP3kRGjgB6nMdeoNVwq2aww
        Z2NyQeig7dhcBqwa3ZCUAdIfC4WXGCa3CiBM2EltaptSLcvZ
X-Google-Smtp-Source: ALg8bN6avUTfx+LQJ/Qb3JfTnBfzhG6NROSWHDyU/RFT8WwnsuxLSKYALgjPxOq619o+r4JCfvbXBvkdPoCpzsMEHGXv3XQbsBXN
MIME-Version: 1.0
X-Received: by 2002:a24:74e:: with SMTP id f75mr8331174itf.22.1547450223896;
 Sun, 13 Jan 2019 23:17:03 -0800 (PST)
Date:   Sun, 13 Jan 2019 23:17:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e72f94057f65d4c4@google.com>
Subject: KASAN: slab-out-of-bounds Read in xfrm_policy_insert_list
From:   syzbot <syzbot+071bdf2137f3025fb82b@syzkaller.appspotmail.com>
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

HEAD commit:    8d008e64a2eb mISDN: hfcsusb: Use struct_size() in kzalloc()
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=164f0107400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7308e68273924137
dashboard link: https://syzkaller.appspot.com/bug?extid=071bdf2137f3025fb82b
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+071bdf2137f3025fb82b@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in xfrm_policy_insert_list+0xd32/0xfb0  
net/xfrm/xfrm_policy.c:1532
Read of size 1 at addr ffff8880a57d0699 by task syz-executor0/22062

CPU: 0 PID: 22062 Comm: syz-executor0 Not tainted 4.20.0+ #18
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
  print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
  kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
  __asan_report_load1_noabort+0x14/0x20 mm/kasan/generic_report.c:132
  xfrm_policy_insert_list+0xd32/0xfb0 net/xfrm/xfrm_policy.c:1532
  xfrm_policy_inexact_insert+0x155/0xda0 net/xfrm/xfrm_policy.c:1195
  xfrm_policy_insert+0x623/0x910 net/xfrm/xfrm_policy.c:1570
  xfrm_add_policy+0x2a1/0x6c0 net/xfrm/xfrm_user.c:1657
  xfrm_user_rcv_msg+0x458/0x8d0 net/xfrm/xfrm_user.c:2663
  netlink_rcv_skb+0x17d/0x410 net/netlink/af_netlink.c:2477
  xfrm_netlink_rcv+0x70/0x90 net/xfrm/xfrm_user.c:2671
  netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
  netlink_unicast+0x574/0x770 net/netlink/af_netlink.c:1336
  netlink_sendmsg+0xa05/0xf90 net/netlink/af_netlink.c:1917
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xdd/0x130 net/socket.c:631
  ___sys_sendmsg+0x7ec/0x910 net/socket.c:2116
  __sys_sendmsg+0x112/0x270 net/socket.c:2154
  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg net/socket.c:2161 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457ec9
Code: 6d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 3b b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f2e4aef1c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457ec9
RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000004
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f2e4aef26d4
R13: 00000000004c5394 R14: 00000000004d8e30 R15: 00000000ffffffff

Allocated by task 2682:
  save_stack+0x45/0xd0 mm/kasan/common.c:73
  set_track mm/kasan/common.c:85 [inline]
  kasan_kmalloc mm/kasan/common.c:482 [inline]
  kasan_kmalloc+0xcf/0xe0 mm/kasan/common.c:455
  kasan_slab_alloc+0xf/0x20 mm/kasan/common.c:397
  kmem_cache_alloc+0x12d/0x710 mm/slab.c:3541
  getname_flags fs/namei.c:140 [inline]
  getname_flags+0xd6/0x5b0 fs/namei.c:129
  getname+0x1a/0x20 fs/namei.c:211
  do_sys_open+0x3a5/0x7c0 fs/open.c:1057
  __do_sys_open fs/open.c:1081 [inline]
  __se_sys_open fs/open.c:1076 [inline]
  __x64_sys_open+0x7e/0xc0 fs/open.c:1076
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 2682:
  save_stack+0x45/0xd0 mm/kasan/common.c:73
  set_track mm/kasan/common.c:85 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:444
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:452
  __cache_free mm/slab.c:3485 [inline]
  kmem_cache_free+0x86/0x260 mm/slab.c:3747
  putname+0xef/0x130 fs/namei.c:261
  do_sys_open+0x3f4/0x7c0 fs/open.c:1072
  __do_sys_open fs/open.c:1081 [inline]
  __se_sys_open fs/open.c:1076 [inline]
  __x64_sys_open+0x7e/0xc0 fs/open.c:1076
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8880a57d0800
  which belongs to the cache names_cache of size 4096
The buggy address is located 359 bytes to the left of
  4096-byte region [ffff8880a57d0800, ffff8880a57d1800)
The buggy address belongs to the page:
page:ffffea000295f400 count:1 mapcount:0 mapping:ffff88821bc49080 index:0x0  
compound_mapcount: 0
flags: 0x1fffc0000010200(slab|head)
raw: 01fffc0000010200 ffffea0002949788 ffffea00027c8208 ffff88821bc49080
raw: 0000000000000000 ffff8880a57d0800 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8880a57d0580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8880a57d0600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff8880a57d0680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                             ^
  ffff8880a57d0700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8880a57d0780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
