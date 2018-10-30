Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACBBC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 295852080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:00:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 295852080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbeJ3Xxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 19:53:53 -0400
Received: from mail-it1-f197.google.com ([209.85.166.197]:37785 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbeJ3Xxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 19:53:53 -0400
Received: by mail-it1-f197.google.com with SMTP id m8-v6so13766853iti.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 08:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=7IBYvPtjO0kKludNHCHI4ygFiT5t81YgFAQGgDy/anw=;
        b=WGlUfbVWU7Ihv2sdmArS4epXmMmAVnRelOWUX7PloincGEofbyrZrWC7Dpmyge8T8o
         gTaxU3SOOKnaCx41ZAo8Am+RtCM+NqFS1k0zuOO8YoRUbMnQvgMDbcssooGINZcT9aL8
         sYZPkYJHreelmAuO92uSjwU+QbBWquFDvQvnskZ97+0AIgA5Bd2Lo/kS+5QZTUzdDKRT
         U/4j7EDwuWTH5G4xKi6hsuh+ykdchIE25TLCkdj6ELQ7zuApyESwABPVWJK9zO1hIjox
         BpMei7MOM+cTXPzcxQdeKqWYnOO029LhB9F48svSZBxR/sYqLxvhkQ8ibsecYo/0NbS4
         PrVQ==
X-Gm-Message-State: AGRZ1gKKgrwgJdPoKmMJzrlTERVE885IcYvyYfALei3fU7O5gTjBafcU
        9vsCPGgv82UEsVviLqL2ybfNwJMr4DkVWmPK05RRQw2vOS7C
X-Google-Smtp-Source: AJdET5f2G5980bWyqLHLZ6gn5O8U6MDb+AscKuAkOvprCYi4Hk8MtjWDsZFf82bUMzZ5MK2/qVxNjxncGuX/r00RbL9OcFUs381e
MIME-Version: 1.0
X-Received: by 2002:a6b:cf17:: with SMTP id o23-v6mr1918356ioa.30.1540911604214;
 Tue, 30 Oct 2018 08:00:04 -0700 (PDT)
Date:   Tue, 30 Oct 2018 08:00:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ccd7e80579737060@google.com>
Subject: upstream boot error (2)
From:   syzbot <syzbot+3701447012fe951dabb2@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    11743c56785c Merge tag 'rpmsg-v4.20' of git://github.com/a..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15121199400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=93932074d01b4a5
dashboard link: https://syzkaller.appspot.com/bug?extid=3701447012fe951dabb2
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+3701447012fe951dabb2@syzkaller.appspotmail.com

KASAN: use-after-free Read in del_timer_syncNon-volatile memory driver v1.3
Linux agpgart interface v0.103
[drm] Initialized vgem 1.0.0 20120112 for virtual device on minor 0
usbcore: registered new interface driver udl
==================================================================
BUG: KASAN: use-after-free in __lock_acquire+0x36d9/0x4c20  
kernel/locking/lockdep.c:3218
Read of size 8 at addr ffff8801d1b6b540 by task swapper/0/1

CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.19.0+ #88
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.8+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  __lock_acquire+0x36d9/0x4c20 kernel/locking/lockdep.c:3218
  lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
  del_timer_sync+0xb7/0x270 kernel/time/timer.c:1283
  blk_cleanup_queue+0x413/0x710 block/blk-core.c:809
  brd_free+0x5d/0x71 drivers/block/brd.c:422
  brd_init+0x2eb/0x393 drivers/block/brd.c:518
  do_one_initcall+0x145/0x957 init/main.c:890
  do_initcall_level init/main.c:958 [inline]
  do_initcalls init/main.c:966 [inline]
  do_basic_setup init/main.c:984 [inline]
  kernel_init_freeable+0x5c6/0x6b9 init/main.c:1148
  kernel_init+0x11/0x1ae init/main.c:1068
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:350

Allocated by task 1:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_node_trace+0x14c/0x740 mm/slab.c:3663
  kmalloc_node include/linux/slab.h:584 [inline]
  bdi_alloc_node+0x89/0xe0 mm/backing-dev.c:861
  blk_alloc_queue_node+0x2b7/0xe80 block/blk-core.c:1024
  blk_alloc_queue+0x1a/0x20 block/blk-core.c:911
  brd_alloc+0xb9/0x540 drivers/block/brd.c:378
  brd_init+0x11d/0x393 drivers/block/brd.c:498
  do_one_initcall+0x145/0x957 init/main.c:890
  do_initcall_level init/main.c:958 [inline]
  do_initcalls init/main.c:966 [inline]
  do_basic_setup init/main.c:984 [inline]
  kernel_init_freeable+0x5c6/0x6b9 init/main.c:1148
  kernel_init+0x11/0x1ae init/main.c:1068
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:350

Freed by task 12:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3817
  release_bdi mm/backing-dev.c:968 [inline]
  kref_put include/linux/kref.h:70 [inline]
  bdi_put+0x138/0x180 mm/backing-dev.c:973
  blk_exit_queue+0xbf/0xf0 block/blk-core.c:746
  __blk_release_queue+0x12f/0x510 block/blk-sysfs.c:841
  process_one_work+0xc90/0x1c40 kernel/workqueue.c:2153
  worker_thread+0x17f/0x1390 kernel/workqueue.c:2296
  kthread+0x35a/0x440 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:350

The buggy address belongs to the object at ffff8801d1b6ae80
  which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 1728 bytes inside of
  2048-byte region [ffff8801d1b6ae80, ffff8801d1b6b680)
The buggy address belongs to the page:
page:ffffea000746da80 count:1 mapcount:0 mapping:ffff8801da800c40 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000010200(slab|head)
raw: 02fffc0000010200 ffffea000746da08 ffffea000746dc08 ffff8801da800c40
raw: 0000000000000000 ffff8801d1b6a600 0000000100000003 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801d1b6b400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801d1b6b480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8801d1b6b500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                            ^
  ffff8801d1b6b580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801d1b6b600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
