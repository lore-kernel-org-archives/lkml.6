Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15BFC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE3922073D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731024AbfACKnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 05:43:04 -0500
Received: from mail-it1-f198.google.com ([209.85.166.198]:55426 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730901AbfACKnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 05:43:04 -0500
Received: by mail-it1-f198.google.com with SMTP id j3so35346531itf.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 02:43:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=7yrqO4D1wPf9BJpeM98hwAgpJKYqFIO765mE7gH3i+M=;
        b=qqUbmHN/VD+G1OQrZM96d7jMl1aRR3qrDerczTteeaMEWLWSvMpdr9MA8REJ32vPmI
         banxIA8iLhRZ9bkgkGYe4RUupXcBl8+bu52DXl31BOgk5irORmHZB8KIfAdezjst34I2
         +vcBmA0ZY4ucP4WPCtm3vSz6w4oXW0QMyqWNX0c3d6ZhgkzwUNAc6jp9OEg58akaggcN
         YwdtHshUxkaVWpDjfgshejisA+4KpBnQxadoGos+yBMDkwfa42NB4Udn+VGnAQZ88w2I
         ZvKUPsIcyBpffrJaOWoAr79JGqXxnI3MHEbVUnnqILIgKxGLVi+qZO7nqjhzC2EwALyP
         gHqw==
X-Gm-Message-State: AJcUukchRS8bF0p02kUmhSt3+Dc1DngRdMrfw061xhSMztZDhfeLsDWN
        /c11JKNCepaRSXlXgwTDSdtGx2M5nb1nnXphQx1Igd/jFu93
X-Google-Smtp-Source: ALg8bN5fAiiDcVvACvB5hbBCJt6ighwGS+VLpvSdzK9mCS1qm1VihN/t4i0QnvTS0zh3B0xjlta+HPonGTVM3velAiWo4hJJJtnx
MIME-Version: 1.0
X-Received: by 2002:a24:5f93:: with SMTP id r141mr34803205itb.4.1546512183116;
 Thu, 03 Jan 2019 02:43:03 -0800 (PST)
Date:   Thu, 03 Jan 2019 02:43:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000050ccc2057e8b6df4@google.com>
Subject: KASAN: slab-out-of-bounds Read in __xfrm_policy_bysel_ctx
From:   syzbot <syzbot+f8bca486925bdceb2632@syzkaller.appspotmail.com>
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

HEAD commit:    b71acb0e3721 Merge branch 'linus' of git://git.kernel.org/..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15e83920c00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4a8e05cab2dc66d3
dashboard link: https://syzkaller.appspot.com/bug?extid=f8bca486925bdceb2632
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f8bca486925bdceb2632@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in  
__xfrm_policy_bysel_ctx.constprop.0+0x3e5/0x470 net/xfrm/xfrm_policy.c:1618
Read of size 1 at addr ffff8880a7a49459 by task syz-executor2/9675

CPU: 0 PID: 9675 Comm: syz-executor2 Not tainted 4.20.0+ #2
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
  print_address_description.cold+0x7c/0x20d mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report mm/kasan/report.c:412 [inline]
  kasan_report.cold+0x8c/0x2ba mm/kasan/report.c:396
  __asan_report_load1_noabort+0x14/0x20 mm/kasan/report.c:430
  __xfrm_policy_bysel_ctx.constprop.0+0x3e5/0x470 net/xfrm/xfrm_policy.c:1618
  xfrm_policy_bysel_ctx+0x944/0x1020 net/xfrm/xfrm_policy.c:1664
  xfrm_get_policy+0x67b/0x1160 net/xfrm/xfrm_user.c:1887
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
RSP: 002b:00007f80d9bebc78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457ec9
RDX: 0000000000000000 RSI: 000000002014f000 RDI: 0000000000000003
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f80d9bec6d4
R13: 00000000004c5223 R14: 00000000004d8ae8 R15: 00000000ffffffff

Allocated by task 3861:
  save_stack+0x45/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc mm/kasan/kasan.c:553 [inline]
  kasan_kmalloc+0xce/0xf0 mm/kasan/kasan.c:531
  kasan_slab_alloc+0xf/0x20 mm/kasan/kasan.c:490
  kmem_cache_alloc+0x12e/0x700 mm/slab.c:3554
  getname_flags fs/namei.c:140 [inline]
  getname_flags+0xd6/0x5b0 fs/namei.c:129
  getname+0x1a/0x20 fs/namei.c:211
  do_sys_open+0x3a5/0x740 fs/open.c:1057
  __do_sys_open fs/open.c:1081 [inline]
  __se_sys_open fs/open.c:1076 [inline]
  __x64_sys_open+0x7e/0xc0 fs/open.c:1076
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 3861:
  save_stack+0x45/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kmem_cache_free+0x86/0x260 mm/slab.c:3760
  putname+0xef/0x130 fs/namei.c:261
  do_sys_open+0x3f4/0x740 fs/open.c:1072
  __do_sys_open fs/open.c:1081 [inline]
  __se_sys_open fs/open.c:1076 [inline]
  __x64_sys_open+0x7e/0xc0 fs/open.c:1076
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8880a7a48200
  which belongs to the cache names_cache of size 4096
The buggy address is located 601 bytes to the right of
  4096-byte region [ffff8880a7a48200, ffff8880a7a49200)
The buggy address belongs to the page:
page:ffffea00029e9200 count:1 mapcount:0 mapping:ffff88812c2bec40 index:0x0  
compound_mapcount: 0
flags: 0x1fffc0000010200(slab|head)
raw: 01fffc0000010200 ffffea0002a05208 ffffea00021b2f08 ffff88812c2bec40
raw: 0000000000000000 ffff8880a7a48200 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8880a7a49300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8880a7a49380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff8880a7a49400: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                                     ^
  ffff8880a7a49480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8880a7a49500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
