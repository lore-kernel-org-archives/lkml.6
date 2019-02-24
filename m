Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2195C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 07:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F58B2063F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 07:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbfBXHKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 02:10:06 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:35441 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfBXHKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 02:10:05 -0500
Received: by mail-io1-f70.google.com with SMTP id s9so5456370ioj.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Feb 2019 23:10:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=8v6MqpReFnY0D+DXVtWHGq/h+qg5sMiN7EUtf0wcVJE=;
        b=aRaUoE0t4zpIVpQueMbW/gAIMnLeoB0Zz2Y29U5NZyjtw/hj6FGFGUgV3LH7RtJQH7
         7qHbVNaGB4/MQLwgprW9PvdauWqH5Tf/9W+0k0EDW3E9HVh6/Z7yammu7gJfG7qpyzc0
         ReUidtLZAvtzDP2ws+g1pDnqGPZv9mtZL4vTI4TPisaDbEVPeUVGLKX1NqSzWldPVlRk
         ZKdfSM4S3W/TQKvblCwMugis0Svw3vXN+4g6DFIDjisoKqY/8n22eX9MScFE0JUKxhXN
         M5Ki2O4lBNLNwp7VG6ZONivwx7PqgZMlcC/bsVpx9masRmJeem3c64G6HNpZnf60jW8K
         VMqg==
X-Gm-Message-State: AHQUAubT6cjAvbii6zPtzK4BqSldeQz6pRGmHyAWNipiGheMWHxlidA2
        eVFZ70JvEI6hzylnkh8xGHh4N9auphKNhhYiLqdWAuYSHk0m
X-Google-Smtp-Source: AHgI3IbVPklTRGaQnXhBrBDSBf/mdofOoulFjn6Fz5FdLQkHxyO5XtdtSoFkBUPO+OYamWQZ3smmFffnw0sihqEKTDWMiFOdV4U6
MIME-Version: 1.0
X-Received: by 2002:a6b:fb01:: with SMTP id h1mr4847914iog.31.1550992204649;
 Sat, 23 Feb 2019 23:10:04 -0800 (PST)
Date:   Sat, 23 Feb 2019 23:10:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000685dc805829e835c@google.com>
Subject: WARNING: bad unlock balance detected! (3)
From:   syzbot <syzbot+f3e3434787332dfc1c47@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    40e196a906d9 Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12a49614c00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7132344728e7ec3f
dashboard link: https://syzkaller.appspot.com/bug?extid=f3e3434787332dfc1c47
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13a18ed4c00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f3e3434787332dfc1c47@syzkaller.appspotmail.com

Enabling of bearer <udp:
yz1> rejected, already enabled
=====================================
Enabling of bearer <udp:
yz1> rejected, already enabled
WARNING: bad unlock balance detected!
5.0.0-rc7+ #80 Not tainted
-------------------------------------
kworker/1:1/22 is trying to release lock (
==================================================================
BUG: KASAN: slab-out-of-bounds in print_unlock_imbalance_bug  
kernel/locking/lockdep.c:3383 [inline]
BUG: KASAN: slab-out-of-bounds in  
print_unlock_imbalance_bug.cold+0x97/0x123 kernel/locking/lockdep.c:3368
Read of size 8 at addr ffff888216be498c by task kworker/1:1/22
Enabling of bearer <udp:
yz1> rejected, already enabled

CPU: 1 PID: 22 Comm: kworker/1:1 Not tainted 5.0.0-rc7+ #80
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue:  addrconf_dad_work (ipv6_addrconf)
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
  kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:135
  print_unlock_imbalance_bug kernel/locking/lockdep.c:3383 [inline]
  print_unlock_imbalance_bug.cold+0x97/0x123 kernel/locking/lockdep.c:3368
  __lock_release kernel/locking/lockdep.c:3601 [inline]
  lock_release+0x67e/0xa00 kernel/locking/lockdep.c:3860
  process_one_work+0xa47/0x1790 kernel/workqueue.c:2180
  worker_thread+0x98/0xe40 kernel/workqueue.c:2319
  kthread+0x357/0x430 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

Allocated by task 1:
  save_stack+0x45/0xd0 mm/kasan/common.c:73
  set_track mm/kasan/common.c:85 [inline]
  __kasan_kmalloc mm/kasan/common.c:496 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:469
  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:504
  kmem_cache_alloc_trace+0x151/0x760 mm/slab.c:3609
  kmalloc include/linux/slab.h:545 [inline]
  kzalloc include/linux/slab.h:740 [inline]
  __alloc_workqueue_key+0x79c/0xe00 kernel/workqueue.c:4099
  addrconf_init+0x9a/0x3b1 net/ipv6/addrconf.c:6906
  inet6_init+0x36c/0x6e1 net/ipv6/af_inet6.c:1022
  do_one_initcall+0x109/0x796 init/main.c:887
  do_initcall_level init/main.c:955 [inline]
  do_initcalls init/main.c:963 [inline]
  do_basic_setup init/main.c:981 [inline]
  kernel_init_freeable+0x4da/0x5c9 init/main.c:1136
  kernel_init+0x12/0x1c5 init/main.c:1054
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

Freed by task 0:
(stack is not available)

The buggy address belongs to the object at ffff888216be4780
  which belongs to the cache kmalloc-512 of size 512
The buggy address is located 12 bytes to the right of
  512-byte region [ffff888216be4780, ffff888216be4980)
The buggy address belongs to the page:
page:ffffea00085af900 count:1 mapcount:0 mapping:ffff88812c3f0940  
index:0xffff888216be4280
flags: 0x6fffc0000000200(slab)
raw: 06fffc0000000200 ffffea0008581008 ffffea0008597888 ffff88812c3f0940
raw: ffff888216be4280 ffff888216be4000 0000000100000004 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff888216be4880: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff888216be4900: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
> ffff888216be4980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                       ^
  ffff888216be4a00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff888216be4a80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
