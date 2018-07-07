Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C07C6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 07:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34DF9224F4
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 07:10:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34DF9224F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754126AbeGGHKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 03:10:05 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:34909 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751663AbeGGHKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 03:10:03 -0400
Received: by mail-it0-f69.google.com with SMTP id r184-v6so6530697ith.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jul 2018 00:10:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=b9VCUkHV3xEbhrILKV0dw+HySyKijX8NdkG0qmHsfyU=;
        b=B3JcWYpozKh8I/zziddn93KJKmPbFwi+CGcPboVDdT93WRAFVs0XXsgtM8/LHc3JbA
         xhegtzERA1cE0zGjVgzWqEyZHneKVziGTTI8oiXfLkyuskT0rE1XNyZfJe4J6xpYX3NP
         mG3hSfgZQVNxMQdLJbSc1L9+MD7HvjV6rMravOrX/RBjzSWYsyQApEIxORQweqOJq1fc
         vSC4o6X6pboEW72wKtOKJ0Mia7M9JU14oUfj0jQZ+4Y8Ea/c6WXK+WD/RUCY2rJ79Swd
         Eu1rJByYTgiEipW3QNtLsqLyn2ocThKhrxo5YhibPck7sPOuIBSo9BIzFfD8a6kurBNm
         fIjg==
X-Gm-Message-State: AOUpUlEc+wUtcm0I/WQXcx1vnec1CMCmLUTttSSTLHlJoBwmB4QieqSY
        FnpsJtjuJY0syu3F+2swPbRx/uy0ZQDXxhWq3TzZkpX0KpqZ
X-Google-Smtp-Source: AAOMgpdlHlZ3PU4Aud6pfm99ZD8ztWHyNSGY9Yw+rd8A9qscM1lDmn6WCGjOu3fxe7kMuEMHrcRu3U5h1W/f0F4yiAuZrS71dxZ+
MIME-Version: 1.0
X-Received: by 2002:a6b:2712:: with SMTP id n18-v6mr5558543ion.90.1530947402552;
 Sat, 07 Jul 2018 00:10:02 -0700 (PDT)
Date:   Sat, 07 Jul 2018 00:10:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000195e0e057063783e@google.com>
Subject: KASAN: use-after-free Read in cma_acquire_dev
From:   syzbot <syzbot+908eac39ffdc39221032@syzkaller.appspotmail.com>
To:     danielj@mellanox.com, dledford@redhat.com, jgg@ziepe.ca,
        leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, monis@mellanox.com, parav@mellanox.com,
        swise@opengridcomputing.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    fc36def997cf mm: teach dump_page() to correctly output poi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1378110c400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2ca6c7a31d407f86
dashboard link: https://syzkaller.appspot.com/bug?extid=908eac39ffdc39221032
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+908eac39ffdc39221032@syzkaller.appspotmail.com

netlink: 4 bytes leftover after parsing attributes in process  
`syz-executor0'.
QAT: Invalid ioctl
capability: warning: `syz-executor0' uses deprecated v2 capabilities in a  
way that may be insecure
==================================================================
BUG: KASAN: use-after-free in rdma_ip2gid include/rdma/ib_addr.h:143  
[inline]
BUG: KASAN: use-after-free in cma_acquire_dev+0xe56/0xea0  
drivers/infiniband/core/cma.c:654
Read of size 2 at addr ffff88019c561360 by task syz-executor2/8894

CPU: 1 PID: 8894 Comm: syz-executor2 Not tainted 4.18.0-rc3+ #131
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
  __asan_report_load2_noabort+0x14/0x20 mm/kasan/report.c:431
  rdma_ip2gid include/rdma/ib_addr.h:143 [inline]
  cma_acquire_dev+0xe56/0xea0 drivers/infiniband/core/cma.c:654
  rdma_bind_addr+0x248/0x23b0 drivers/infiniband/core/cma.c:3388
  cma_bind_addr drivers/infiniband/core/cma.c:2930 [inline]
  rdma_resolve_addr+0x500/0x28a0 drivers/infiniband/core/cma.c:2942
  ucma_resolve_ip+0x242/0x2a0 drivers/infiniband/core/ucma.c:711
  ucma_write+0x336/0x420 drivers/infiniband/core/ucma.c:1680
  __vfs_write+0x117/0x9f0 fs/read_write.c:485
  vfs_write+0x1f8/0x560 fs/read_write.c:549
  ksys_write+0x101/0x260 fs/read_write.c:598
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455ba9
Code: 1d ba fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb b9 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fb04c987c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fb04c9886d4 RCX: 0000000000455ba9
RDX: 0000000000000048 RSI: 00000000200002c0 RDI: 0000000000000015
RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004c7f98 R14: 00000000004d4160 R15: 0000000000000000

Allocated by task 8894:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_trace+0x152/0x780 mm/slab.c:3620
  kmalloc include/linux/slab.h:513 [inline]
  kzalloc include/linux/slab.h:707 [inline]
  __rdma_create_id+0xdf/0x720 drivers/infiniband/core/cma.c:780
  ucma_create_id+0x399/0x9d0 drivers/infiniband/core/ucma.c:502
  ucma_write+0x336/0x420 drivers/infiniband/core/ucma.c:1680
  __vfs_write+0x117/0x9f0 fs/read_write.c:485
  vfs_write+0x1f8/0x560 fs/read_write.c:549
  ksys_write+0x101/0x260 fs/read_write.c:598
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 8905:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xd9/0x260 mm/slab.c:3813
  rdma_destroy_id+0x8cd/0xe60 drivers/infiniband/core/cma.c:1703
  ucma_close+0x100/0x300 drivers/infiniband/core/ucma.c:1759
  __fput+0x355/0x8b0 fs/file_table.c:209
  ____fput+0x15/0x20 fs/file_table.c:243
  task_work_run+0x1ec/0x2a0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:192 [inline]
  exit_to_usermode_loop+0x313/0x370 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff88019c561340
  which belongs to the cache kmalloc-2048 of size 2048
The buggy address is located 32 bytes inside of
  2048-byte region [ffff88019c561340, ffff88019c561b40)
The buggy address belongs to the page:
page:ffffea0006715800 count:1 mapcount:0 mapping:ffff8801da800c40  
index:0xffff88019c560240 compound_mapcount: 0
flags: 0x2fffc0000008100(slab|head)
raw: 02fffc0000008100 ffffea00066fb108 ffffea000670dc08 ffff8801da800c40
raw: ffff88019c560240 ffff88019c560240 0000000100000002 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff88019c561200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88019c561280: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> ffff88019c561300: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
                                                        ^
  ffff88019c561380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88019c561400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
