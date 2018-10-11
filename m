Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770D5C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 05:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20B802086E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 05:50:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20B802086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbeJKNPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 09:15:44 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:53558 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728048AbeJKNPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 09:15:43 -0400
Received: by mail-io1-f72.google.com with SMTP id t22-v6so6854685ioc.20
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 22:50:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ahW+pmTMes9hrkJsDRmSi8zkOT0DmR15xnx3YHoMhzo=;
        b=NAI2t10XOXBqLH0C89AL9f2HVhoLO9XW7L5JtSLEdQwYJqe2u/fuRxKBpFFHCXUlQo
         Ggy8K72pm+35LTpzl9fn7K5kwG9eSLrG5z+kepslnC7myFzDWhjyjjLSdWlhENJ4dE6m
         K0v7aVFbVcqSxvDKAsZP4Ed7fa9qAyQvRAWwTI4iAk4Ro0bx9yUNyWPInJRR0T2K2iY2
         HQzLr9ZyAesFdG1Ifb7brEWePg7eXOeuWP4xquMHrDInVgfKYJXY4Vgmm37KZWbttU0O
         hRXMbmgzxdLCtv9gu0gScBsgamomw1kYSiLqeOXzrpwR3C/VaL5bqaJOX6DOcmAB3X8O
         Ya0Q==
X-Gm-Message-State: ABuFfoiRSWSdHZwNqqdCi0diwoRaP/LyK5zaMXo8Givh6nbDM+noeIhW
        AQyU8ZCDNszeyyvdecCGqsGmr2XuWnR01mr05DRiQ4WGTw2D
X-Google-Smtp-Source: ACcGV60NRc7Eh4lJ55oswSmru3P2ZyePJLucF+I734MA5d/BPU+CynYbPJNK8/4gWZ9dFtOvBbx3nbGYOfv3egG4xOCQxzobc88p
MIME-Version: 1.0
X-Received: by 2002:a6b:4418:: with SMTP id r24-v6mr107974ioa.29.1539237003080;
 Wed, 10 Oct 2018 22:50:03 -0700 (PDT)
Date:   Wed, 10 Oct 2018 22:50:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cb3d0b0577ed8a96@google.com>
Subject: KASAN: use-after-free Read in __llc_lookup_established
From:   syzbot <syzbot+11e05f04c15e03be5254@syzkaller.appspotmail.com>
To:     davem@davemloft.net, keescook@chromium.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    3d647e62686f Merge tag 's390-4.19-4' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1707d809400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=88e9a8a39dc0be2d
dashboard link: https://syzkaller.appspot.com/bug?extid=11e05f04c15e03be5254
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+11e05f04c15e03be5254@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in llc_estab_match net/llc/llc_conn.c:494  
[inline]
BUG: KASAN: use-after-free in __llc_lookup_established+0xc80/0xe10  
net/llc/llc_conn.c:522
Read of size 1 at addr ffff8801c5794a7f by task syz-executor3/10277

CPU: 0 PID: 10277 Comm: syz-executor3 Not tainted 4.19.0-rc7+ #55
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
net_ratelimit: 9 callbacks suppressed
openvswitch: netlink: Key type 12288 is out of range max 29
  __asan_report_load1_noabort+0x14/0x20 mm/kasan/report.c:430
  llc_estab_match net/llc/llc_conn.c:494 [inline]
  __llc_lookup_established+0xc80/0xe10 net/llc/llc_conn.c:522
openvswitch: netlink: Key type 12288 is out of range max 29
  llc_lookup_established+0x36/0x60 net/llc/llc_conn.c:554
  llc_ui_bind+0x810/0xdd0 net/llc/af_llc.c:381
  __sys_bind+0x331/0x440 net/socket.c:1483
  __do_sys_bind net/socket.c:1494 [inline]
  __se_sys_bind net/socket.c:1492 [inline]
  __x64_sys_bind+0x73/0xb0 net/socket.c:1492
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457579
Code: 1d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f2a18100c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000031
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457579
RDX: 0000000000000010 RSI: 0000000020000040 RDI: 0000000000000006
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f2a181016d4
R13: 00000000004bd718 R14: 00000000004cbfe0 R15: 00000000ffffffff

Allocated by task 10278:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  __do_kmalloc mm/slab.c:3718 [inline]
  __kmalloc+0x14e/0x760 mm/slab.c:3727
  kmalloc include/linux/slab.h:518 [inline]
  sk_prot_alloc+0x1b0/0x2e0 net/core/sock.c:1468
  sk_alloc+0x10d/0x1690 net/core/sock.c:1522
  llc_sk_alloc+0x35/0x4b0 net/llc/llc_conn.c:949
  llc_ui_create+0x142/0x520 net/llc/af_llc.c:173
  __sock_create+0x536/0x930 net/socket.c:1277
  sock_create net/socket.c:1317 [inline]
  __sys_socket+0x106/0x260 net/socket.c:1347
  __do_sys_socket net/socket.c:1356 [inline]
  __se_sys_socket net/socket.c:1354 [inline]
  __x64_sys_socket+0x73/0xb0 net/socket.c:1354
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 10276:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3813
  sk_prot_free net/core/sock.c:1505 [inline]
  __sk_destruct+0x797/0xa80 net/core/sock.c:1587
  sk_destruct+0x78/0x90 net/core/sock.c:1595
  __sk_free+0xcf/0x300 net/core/sock.c:1606
  sk_free+0x42/0x50 net/core/sock.c:1617
  sock_put include/net/sock.h:1691 [inline]
  llc_sk_free+0x9d/0xb0 net/llc/llc_conn.c:1017
  llc_ui_release+0x161/0x2a0 net/llc/af_llc.c:218
  __sock_release+0xd7/0x250 net/socket.c:579
  sock_close+0x19/0x20 net/socket.c:1141
  __fput+0x385/0xa30 fs/file_table.c:278
  ____fput+0x15/0x20 fs/file_table.c:309
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:193 [inline]
  exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8801c5794600
  which belongs to the cache kmalloc-2048 of size 2048
The buggy address is located 1151 bytes inside of
  2048-byte region [ffff8801c5794600, ffff8801c5794e00)
The buggy address belongs to the page:
page:ffffea000715e500 count:1 mapcount:0 mapping:ffff8801da800c40 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000008100(slab|head)
raw: 02fffc0000008100 ffffea00075c0d88 ffffea0006f48908 ffff8801da800c40
raw: 0000000000000000 ffff8801c5794600 0000000100000003 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801c5794900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801c5794980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8801c5794a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                                 ^
  ffff8801c5794a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801c5794b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
