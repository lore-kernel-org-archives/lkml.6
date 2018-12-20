Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D497C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C6A1217D8
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbeLTMLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 07:11:05 -0500
Received: from mail-oi1-f200.google.com ([209.85.167.200]:41373 "EHLO
        mail-oi1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729216AbeLTMLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 07:11:04 -0500
Received: by mail-oi1-f200.google.com with SMTP id j13so1096013oii.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 04:11:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=iXkBGpTljByJJo/qOAJMpBbiLNxpvaPcmTWFFhj5+q8=;
        b=AdoI4S56VuCYooomDvzP9GftEjNRyeahhpzz2medk66vINlDy7kwi26be54vx0uC9a
         bXydR4xYjrumNkZvmAkCc2PZtEYm9a+P7YrHe4LdGUZjjwF68Ez55shi/luTo0H1QWef
         OXo5bXg7t5Hl+b6dNKy/0Rmp9nWU0wu1Lf0nYO1TJgRaoe6Ue5d7ohg0qgYcIZUvGye1
         AErAgLi9z9ibzg5RTaLUWs+utbpKWT+H06Ya283cB+MAq4gtqlHxQOCf7YEqGf/SCdkM
         SmazcOABsMY+IImN/0aCFKvsfOpLC+K4nI/Ju5GqOGGv+N1yLQmuQunul4irdelgyJqt
         gLQw==
X-Gm-Message-State: AA+aEWbYIN13bOpaDAG+XDjaVqJ9iFSCrhOrFiUkXlZ5cHwgZshCjzfT
        H4FgVaXP3aO/iUMcl+DYEl+E7Xjf6P4CnCpsoNXz7N1nN5Bn
X-Google-Smtp-Source: AFSGD/UzU4VhmQCj/YOcTwAvEhglPjm16017BfVwBrnvDz7fJ1VNmz+Sgo6cs6HI2iklFRORnv0nHh5XWPdOciAEdU2YlyxKgqgh
MIME-Version: 1.0
X-Received: by 2002:a9d:69d7:: with SMTP id v23mr20499511oto.56.1545307863682;
 Thu, 20 Dec 2018 04:11:03 -0800 (PST)
Date:   Thu, 20 Dec 2018 04:11:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004896aa057d7306e3@google.com>
Subject: KASAN: slab-out-of-bounds Read in xfrm_policy_inexact_insert
From:   syzbot <syzbot+ededf2bd5d663a945d57@syzkaller.appspotmail.com>
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

HEAD commit:    33f18c96afdf net: ethernet: don't set phylib state CHANGEL..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12361d5d400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d9655b05acfc97ff
dashboard link: https://syzkaller.appspot.com/bug?extid=ededf2bd5d663a945d57
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+ededf2bd5d663a945d57@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in xfrm_policy_insert_inexact_list  
net/xfrm/xfrm_policy.c:1497 [inline]
BUG: KASAN: slab-out-of-bounds in xfrm_policy_inexact_insert+0xcd1/0xee0  
net/xfrm/xfrm_policy.c:1202
Read of size 1 at addr ffff8881c099cb19 by task syz-executor5/25179

CPU: 0 PID: 25179 Comm: syz-executor5 Not tainted 4.20.0-rc6+ #353
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
  pfkey_spdadd+0x10f8/0x19d0 net/key/af_key.c:2339
  pfkey_process+0x857/0x9a0 net/key/af_key.c:2844
  pfkey_sendmsg+0x5e5/0xfb0 net/key/af_key.c:3683
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
RSP: 002b:00007f8d19159c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457669
RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000004
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f8d1915a6d4
R13: 00000000004c443a R14: 00000000004d7410 R15: 00000000ffffffff

Allocated by task 24782:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
  kmem_cache_alloc+0x12e/0x730 mm/slab.c:3554
  getname_flags+0xd0/0x590 fs/namei.c:140
  user_path_at_empty+0x2d/0x50 fs/namei.c:2608
  user_path_at include/linux/namei.h:57 [inline]
  vfs_statx+0x129/0x210 fs/stat.c:185
  vfs_fstatat include/linux/fs.h:3176 [inline]
  __do_sys_newfstatat+0x98/0x110 fs/stat.c:366
  __se_sys_newfstatat fs/stat.c:360 [inline]
  __x64_sys_newfstatat+0x97/0xf0 fs/stat.c:360
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 24782:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kmem_cache_free+0x83/0x290 mm/slab.c:3760
  putname+0xf2/0x130 fs/namei.c:261
  filename_lookup+0x39a/0x520 fs/namei.c:2357
  user_path_at_empty+0x40/0x50 fs/namei.c:2608
  user_path_at include/linux/namei.h:57 [inline]
  vfs_statx+0x129/0x210 fs/stat.c:185
  vfs_fstatat include/linux/fs.h:3176 [inline]
  __do_sys_newfstatat+0x98/0x110 fs/stat.c:366
  __se_sys_newfstatat fs/stat.c:360 [inline]
  __x64_sys_newfstatat+0x97/0xf0 fs/stat.c:360
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8881c099cc00
  which belongs to the cache names_cache of size 4096
The buggy address is located 231 bytes to the left of
  4096-byte region [ffff8881c099cc00, ffff8881c099dc00)
The buggy address belongs to the page:
page:ffffea0007026700 count:1 mapcount:0 mapping:ffff8881da980e00 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000010200(slab|head)
raw: 02fffc0000010200 ffffea00075e5e88 ffffea000642a588 ffff8881da980e00
raw: 0000000000000000 ffff8881c099cc00 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881c099ca00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8881c099ca80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff8881c099cb00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                             ^
  ffff8881c099cb80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8881c099cc00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
