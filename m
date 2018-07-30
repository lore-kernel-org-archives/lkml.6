Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A36F4C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56CDB208A2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:15:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56CDB208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729561AbeG3TvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 15:51:15 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:53622 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbeG3TvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 15:51:15 -0400
Received: by mail-it0-f69.google.com with SMTP id e5-v6so282045itf.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 11:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=OtlVcHiREl7EUG+w6c0JNFKn8IL6wnBApDUuoFJxj5Q=;
        b=fCDwsCHpBL17xYqSZ01kRa99Ik6zTvcXKFuNksmlZfKmVePZjDTcDfpqlUJzij5Orr
         wyW6CAyz6JVCByWzqll1ecMmvhBqMszpZysvxQWnf+O5eyVFQHdyCKKgCQMMT1Sp8NCz
         EbjpAnXQupaudzrDnODOQzXdEqMXao4qAKQl0ZlfMi84QFOPN4ecVm4Ga5GuN2I+MMi7
         bhCzqfVFemExIReCNkdm+trwUrwxuBB2bwO0jwd5ECbyVvwO9xqWmV659ZLfB5rAsXLJ
         scROHwTBfhubNJQ3WeloJvboUSowhwO8l4MAm1ok+MoitxSBldiEC5cy2cyGRWf8mD88
         E7FA==
X-Gm-Message-State: AOUpUlHviGagnyJOapduxNsoeRSH2UrGTVi6eE0nvfjPSpDPodR+eB5P
        AvWNsYx3NxyW7UdqiVZMRZzRMLytdRfs7QyNgOYN9nv0LKiF
X-Google-Smtp-Source: AAOMgpfxCsR9iWb5SfY+Cq7QTeagOYpY+cqLy8JNDSgUVK+TEqLzGvEs4uFmF7gb6OxgWCoiZmi3iuQOmwL5Nt1nOlH2ED2KZLKf
MIME-Version: 1.0
X-Received: by 2002:a02:a319:: with SMTP id q25-v6mr9075392jai.44.1532974502925;
 Mon, 30 Jul 2018 11:15:02 -0700 (PDT)
Date:   Mon, 30 Jul 2018 11:15:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b25ef505723b70a0@google.com>
Subject: KASAN: slab-out-of-bounds Read in request_end
From:   syzbot <syzbot+26f447d98c463ead8245@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    acb1872577b3 Linux 4.18-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16ab932c400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2dc0cd7c2eefb46f
dashboard link: https://syzkaller.appspot.com/bug?extid=26f447d98c463ead8245
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+26f447d98c463ead8245@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in constant_test_bit  
arch/x86/include/asm/bitops.h:328 [inline]
BUG: KASAN: slab-out-of-bounds in request_end+0x98e/0xb20 fs/fuse/dev.c:379
Read of size 8 at addr ffff8801aa271438 by task syz-executor6/13610

CPU: 1 PID: 13610 Comm: syz-executor6 Not tainted 4.18.0-rc7+ #169
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  constant_test_bit arch/x86/include/asm/bitops.h:328 [inline]
  request_end+0x98e/0xb20 fs/fuse/dev.c:379
  end_requests+0x296/0x460 fs/fuse/dev.c:2045
  fuse_dev_release+0x18c/0x2e0 fs/fuse/dev.c:2154
  __fput+0x355/0x8b0 fs/file_table.c:209
  ____fput+0x15/0x20 fs/file_table.c:243
  task_work_run+0x1ec/0x2a0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:192 [inline]
  exit_to_usermode_loop+0x313/0x370 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x456a09
Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f2981760c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: 0000000000000030 RBX: 00007f29817616d4 RCX: 0000000000456a09
RDX: 0000000000001000 RSI: 0000000020001000 RDI: 0000000000000015
RBP: 00000000009300a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004d2680 R14: 00000000004c76ca R15: 0000000000000000

Allocated by task 13610:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_trace+0x152/0x780 mm/slab.c:3620
  kmalloc include/linux/slab.h:513 [inline]
  kzalloc include/linux/slab.h:707 [inline]
  fuse_dev_alloc+0xbd/0x500 fs/fuse/inode.c:1023
  fuse_fill_super+0xd39/0x1ee0 fs/fuse/inode.c:1121
  mount_nodev+0x6b/0x110 fs/super.c:1220
  fuse_mount+0x2c/0x40 fs/fuse/inode.c:1210
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

Freed by task 2095:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xd9/0x260 mm/slab.c:3813
  __rcu_reclaim kernel/rcu/rcu.h:173 [inline]
  rcu_do_batch kernel/rcu/tree.c:2558 [inline]
  invoke_rcu_callbacks kernel/rcu/tree.c:2818 [inline]
  __rcu_process_callbacks kernel/rcu/tree.c:2785 [inline]
  rcu_process_callbacks+0x1004/0x1850 kernel/rcu/tree.c:2802
  __do_softirq+0x2e8/0xb17 kernel/softirq.c:292

The buggy address belongs to the object at ffff8801aa2713c0
  which belongs to the cache kmalloc-128 of size 128
The buggy address is located 120 bytes inside of
  128-byte region [ffff8801aa2713c0, ffff8801aa271440)
The buggy address belongs to the page:
page:ffffea0006a89c40 count:1 mapcount:0 mapping:ffff8801dac00640 index:0x0
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffffea0007267248 ffffea0007289cc8 ffff8801dac00640
raw: 0000000000000000 ffff8801aa271000 0000000100000015 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801aa271300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801aa271380: fc fc fc fc fc fc fc fc 00 00 00 00 00 00 00 00
> ffff8801aa271400: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
                                         ^
  ffff8801aa271480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fc
  ffff8801aa271500: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
