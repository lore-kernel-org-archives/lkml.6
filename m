Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C520C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C56052089D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:41:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C56052089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbeIZNwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 09:52:40 -0400
Received: from mail-it1-f197.google.com ([209.85.166.197]:51143 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727187AbeIZNwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 09:52:40 -0400
Received: by mail-it1-f197.google.com with SMTP id n194-v6so2103951itn.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 00:41:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=vshtUzyQRqB796fzv28aDHnGnlKIA3zsatJllM5eD5I=;
        b=sZj8ZMC1isdqUdMWiS1bEndEq+LB11zvPa9Y85B5pgWKh8AJkX7TWE6sXb6Ni9Hs5W
         qZcdVJrGzMh3rq/fIq2AIoiiprGoUtsZ7nDCTpcwrhviyhkAakQy6n7Kvrih0NHSVcDk
         4rcBvwxt+A3vltjytBsZS4+QBRLRTZM7sVQMe7S7xsybkMULX1HNm3Vupkd3pxYOcl3E
         /qIa0iwurkEgHPT8bsZdF/w/uV7/fg4mqwLMfSSC4ZqdX0jeeHcytZ8RV1ymy2Tak6tf
         b7a0SP1dvHGld0f5iCcEANp2qGSACf/wc039kDJEfOkeb0XnqnJ/57vtBn2jaxjWcMSR
         FFtQ==
X-Gm-Message-State: ABuFfoiwT/oyFaKd06u0jNd2quIJO9A+B3OhRGLRmKCvtrH3nkYfkNjK
        HsmKW7ZmgR5VetnUEiW1UHebte7yFWxEUHrWbgYvNXA8w3Tt
X-Google-Smtp-Source: ACcGV63qUhz71laVp66JWOtBO/Rwq/TUAS8Oe6e6zSB777fE3bwYv5WpEnQQcYrUsEf7wgyHbJpSwG1wHTD0uOuYaqbeyKyxx1oh
MIME-Version: 1.0
X-Received: by 2002:a02:4ddc:: with SMTP id t89-v6mr3831445jad.19.1537947663744;
 Wed, 26 Sep 2018 00:41:03 -0700 (PDT)
Date:   Wed, 26 Sep 2018 00:41:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002e4a260576c1589d@google.com>
Subject: KASAN: use-after-free Read in relay_switch_subbuf
From:   syzbot <syzbot+29093015c21333d1c46d@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, ebiggers@google.com,
        jrdr.linux@gmail.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, mawilcox@microsoft.com,
        rientjes@google.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    2dd68cc7fd8c Merge gitolite.kernel.org:/pub/scm/linux/kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=105fe676400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=22a62640793a83c9
dashboard link: https://syzkaller.appspot.com/bug?extid=29093015c21333d1c46d
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+29093015c21333d1c46d@syzkaller.appspotmail.com

8021q: adding VLAN 0 to HW filter on device team0
device team0 left promiscuous mode
device team_slave_0 left promiscuous mode
device team_slave_1 left promiscuous mode
==================================================================
BUG: KASAN: use-after-free in relay_switch_subbuf+0xa0e/0xa70  
kernel/relay.c:753
Read of size 8 at addr ffff8801b3c10778 by task kworker/0:3/5668

CPU: 0 PID: 5668 Comm: kworker/0:3 Not tainted 4.19.0-rc5+ #30
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events __blk_release_queue
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  relay_switch_subbuf+0xa0e/0xa70 kernel/relay.c:753
  relay_flush+0x1c6/0x280 kernel/relay.c:881
  __blk_trace_startstop.isra.20+0x2ae/0x8c0 kernel/trace/blktrace.c:668
  blk_trace_shutdown+0x5b/0x80 kernel/trace/blktrace.c:751
  __blk_release_queue+0x22d/0x500 block/blk-sysfs.c:852
  process_one_work+0xc90/0x1b90 kernel/workqueue.c:2153
device team0 entered promiscuous mode
  worker_thread+0x17f/0x1390 kernel/workqueue.c:2296
device team_slave_0 entered promiscuous mode
device team_slave_1 entered promiscuous mode
  kthread+0x35a/0x420 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:413

Allocated by task 26646:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
  kmem_cache_alloc+0x12e/0x730 mm/slab.c:3554
8021q: adding VLAN 0 to HW filter on device team0
  __d_alloc+0xc8/0xcc0 fs/dcache.c:1614
  d_alloc+0x96/0x380 fs/dcache.c:1698
  d_alloc_parallel+0x15a/0x1f40 fs/dcache.c:2441
  __lookup_slow+0x1e6/0x540 fs/namei.c:1654
  lookup_one_len+0x1d8/0x220 fs/namei.c:2543
  start_creating+0xf2/0x220 fs/debugfs/inode.c:308
  __debugfs_create_file+0x63/0x400 fs/debugfs/inode.c:347
  debugfs_create_file+0x57/0x70 fs/debugfs/inode.c:399
  blk_create_buf_file_callback+0x33/0x40 kernel/trace/blktrace.c:444
  relay_create_buf_file+0xf6/0x150 kernel/relay.c:428
  relay_open_buf.part.10+0x753/0xb20 kernel/relay.c:455
  relay_open_buf kernel/relay.c:447 [inline]
  relay_open+0x5e9/0xac0 kernel/relay.c:597
  do_blk_trace_setup+0x4fb/0xda0 kernel/trace/blktrace.c:532
  __blk_trace_setup+0xd5/0x180 kernel/trace/blktrace.c:577
  blk_trace_ioctl+0x17a/0x2f0 kernel/trace/blktrace.c:716
  blkdev_ioctl+0x8bc/0x2010 block/ioctl.c:587
  block_ioctl+0xee/0x130 fs/block_dev.c:1883
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:501 [inline]
  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
  __do_sys_ioctl fs/ioctl.c:709 [inline]
  __se_sys_ioctl fs/ioctl.c:707 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 26604:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kmem_cache_free+0x83/0x290 mm/slab.c:3756
  __d_free+0x20/0x30 fs/dcache.c:257
  __rcu_reclaim kernel/rcu/rcu.h:236 [inline]
  rcu_do_batch kernel/rcu/tree.c:2576 [inline]
  invoke_rcu_callbacks kernel/rcu/tree.c:2880 [inline]
  __rcu_process_callbacks kernel/rcu/tree.c:2847 [inline]
  rcu_process_callbacks+0xf23/0x2670 kernel/rcu/tree.c:2864
  __do_softirq+0x30b/0xad8 kernel/softirq.c:292

The buggy address belongs to the object at ffff8801b3c10720
  which belongs to the cache dentry(81:syz1) of size 288
The buggy address is located 88 bytes inside of
  288-byte region [ffff8801b3c10720, ffff8801b3c10840)
The buggy address belongs to the page:
page:ffffea0006cf0400 count:1 mapcount:0 mapping:ffff8801bb6ce300 index:0x0
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffffea00072adb88 ffffea0006800c48 ffff8801bb6ce300
raw: 0000000000000000 ffff8801b3c10040 000000010000000b ffff8801c7eb6100
page dumped because: kasan: bad access detected
page->mem_cgroup:ffff8801c7eb6100

Memory state around the buggy address:
  ffff8801b3c10600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801b3c10680: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
> ffff8801b3c10700: fc fc fc fc fb fb fb fb fb fb fb fb fb fb fb fb
                                                                 ^
  ffff8801b3c10780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801b3c10800: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
==================================================================
kobject: 'loop1' (00000000f4503744): kobject_uevent_env
device team0 left promiscuous mode
kobject: 'loop1' (00000000f4503744): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
device team_slave_0 left promiscuous mode
kobject: 'cpu0' (000000004fdcedbb): kobject_add_internal: parent: '0',  
set: '<NULL>'
device team_slave_1 left promiscuous mode
kobject: 'cpu1' (00000000e70df734): kobject_add_internal: parent: '0',  
set: '<NULL>'
kobject: 'kvm' (000000009a7db5f0): kobject_uevent_env
kobject: 'queue' (0000000084fcdfca): kobject_uevent_env
kobject: 'kvm' (000000009a7db5f0): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'queue' (0000000084fcdfca): kobject_uevent_env: filter function  
caused the event to drop!
device team0 entered promiscuous mode


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
