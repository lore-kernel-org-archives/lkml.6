Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C326C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 05:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 173D9208A3
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 05:52:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 173D9208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932385AbeGIFwF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 01:52:05 -0400
Received: from mail-io0-f199.google.com ([209.85.223.199]:50592 "EHLO
        mail-io0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751373AbeGIFwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 01:52:02 -0400
Received: by mail-io0-f199.google.com with SMTP id v2-v6so9134265ioh.17
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 22:52:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ciCfP/gsW6mU//rgWe8rcmCX0Eh0uNq1dfEtZZzxcbk=;
        b=nmqd0gkld8RMuV3u/nhwveFj5GiR4ANPQycofvP94/zOqR5OZoGBu0XizHVSCIHH3S
         JICtuVN36Qv3rBYjelEbwm4iQ4cKortzMHZLlzu5jWpthVe1uJo7LUMWJfXUpeH+ywl1
         UbX+btdiY4CG1r3u68nMTAbFXrnerHqPnvPm1YyXxFF1vFuo92Po1YGFH/ahSOD9qXwu
         r0O+uvCsX1/v02mCf//Ce7e4kMzp7uCmGHlThWJY4uIuuIwsDoZ28kVyWLuKT3Mv4wiz
         R0enfLeSb0if1lWDonrTlI0nMon1ukLp3ik5Z1k30t3tPG5QtOewIPlyMaeCC8h/UqyZ
         0l9g==
X-Gm-Message-State: APt69E0xpMczFJGUdxtVhFO+gyS2MpWV1d5Ep7y35FxDZI4Y4vNf+P/b
        Hr7nMSjMcpOjEofQEwC7obWnQq/BfgggvQvto8u/b2F0vA7E
X-Google-Smtp-Source: AAOMgpceW3yhJCjGo8E63zdAo0oJiVMY/58gqLku83X6HuOAkPfP3gw0JqI1xVC2OsB0D/6fq2o/W3H4oYUJjBGWzlGNhzAj0g1Y
MIME-Version: 1.0
X-Received: by 2002:a02:c483:: with SMTP id t3-v6mr5624088jam.2.1531115522303;
 Sun, 08 Jul 2018 22:52:02 -0700 (PDT)
Date:   Sun, 08 Jul 2018 22:52:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d13b2e05708a9ca0@google.com>
Subject: KASAN: use-after-free Read in p9_conn_cancel
From:   syzbot <syzbot+f0fdc967350bd580a80b@syzkaller.appspotmail.com>
To:     davem@davemloft.net, ericvh@gmail.com,
        linux-kernel@vger.kernel.org, lucho@ionkov.net,
        netdev@vger.kernel.org, rminnich@sandia.gov,
        syzkaller-bugs@googlegroups.com,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ca04b3cca11a Merge tag 'armsoc-fixes' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13150594400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2ca6c7a31d407f86
dashboard link: https://syzkaller.appspot.com/bug?extid=f0fdc967350bd580a80b
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f0fdc967350bd580a80b@syzkaller.appspotmail.com

binder: 24216:24235 got reply transaction with no transaction stack
binder: 24216:24235 transaction failed 29201/-71, size 0-0 line 2759
binder: undelivered TRANSACTION_ERROR: 29201
binder: undelivered TRANSACTION_ERROR: 29201
==================================================================
BUG: KASAN: use-after-free in p9_conn_cancel+0x9de/0xd30  
net/9p/trans_fd.c:207
Read of size 4 at addr ffff8801b70f22e8 by task kworker/1:2/1038

CPU: 1 PID: 1038 Comm: kworker/1:2 Not tainted 4.18.0-rc3+ #137
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events p9_poll_workfn
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
  __asan_report_load4_noabort+0x14/0x20 mm/kasan/report.c:432
  p9_conn_cancel+0x9de/0xd30 net/9p/trans_fd.c:207
  p9_poll_mux net/9p/trans_fd.c:620 [inline]
  p9_poll_workfn+0x4b2/0x6d0 net/9p/trans_fd.c:1107
  process_one_work+0xc73/0x1ba0 kernel/workqueue.c:2153
  worker_thread+0x189/0x13c0 kernel/workqueue.c:2296
  kthread+0x345/0x410 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412

Allocated by task 24174:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_trace+0x152/0x780 mm/slab.c:3620
  kmalloc include/linux/slab.h:513 [inline]
  kzalloc include/linux/slab.h:707 [inline]
  p9_fd_open net/9p/trans_fd.c:796 [inline]
  p9_fd_create+0x1a7/0x3f0 net/9p/trans_fd.c:1036
  p9_client_create+0x915/0x16c9 net/9p/client.c:1062
  v9fs_session_init+0x21a/0x1a80 fs/9p/v9fs.c:400
  v9fs_mount+0x7c/0x900 fs/9p/vfs_super.c:135
  mount_fs+0xae/0x328 fs/super.c:1277
  vfs_kern_mount.part.34+0xdc/0x4e0 fs/namespace.c:1037
  vfs_kern_mount fs/namespace.c:1027 [inline]
  do_new_mount fs/namespace.c:2518 [inline]
  do_mount+0x581/0x30e0 fs/namespace.c:2848
  ksys_mount+0x12d/0x140 fs/namespace.c:3064
  __do_sys_mount fs/namespace.c:3078 [inline]
  __se_sys_mount fs/namespace.c:3075 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3075
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 24174:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xd9/0x260 mm/slab.c:3813
  p9_fd_close+0x416/0x5b0 net/9p/trans_fd.c:893
  p9_client_create+0xac2/0x16c9 net/9p/client.c:1076
  v9fs_session_init+0x21a/0x1a80 fs/9p/v9fs.c:400
  v9fs_mount+0x7c/0x900 fs/9p/vfs_super.c:135
  mount_fs+0xae/0x328 fs/super.c:1277
  vfs_kern_mount.part.34+0xdc/0x4e0 fs/namespace.c:1037
  vfs_kern_mount fs/namespace.c:1027 [inline]
  do_new_mount fs/namespace.c:2518 [inline]
  do_mount+0x581/0x30e0 fs/namespace.c:2848
  ksys_mount+0x12d/0x140 fs/namespace.c:3064
  __do_sys_mount fs/namespace.c:3078 [inline]
  __se_sys_mount fs/namespace.c:3075 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3075
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8801b70f22c0
  which belongs to the cache kmalloc-512 of size 512
The buggy address is located 40 bytes inside of
  512-byte region [ffff8801b70f22c0, ffff8801b70f24c0)
The buggy address belongs to the page:
page:ffffea0006dc3c80 count:1 mapcount:0 mapping:ffff8801da800940  
index:0xffff8801b70f2a40
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffffea00071fb6c8 ffffea0006b2c488 ffff8801da800940
raw: ffff8801b70f2a40 ffff8801b70f2040 0000000100000005 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801b70f2180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801b70f2200: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> ffff8801b70f2280: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
                                                           ^
  ffff8801b70f2300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801b70f2380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
