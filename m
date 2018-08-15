Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C363EC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 16:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98391208DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 16:36:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98391208DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730264AbeHOT2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 15:28:55 -0400
Received: from mail-it0-f71.google.com ([209.85.214.71]:38501 "EHLO
        mail-it0-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729934AbeHOT2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 15:28:55 -0400
Received: by mail-it0-f71.google.com with SMTP id h5-v6so1634316itb.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 09:36:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=zJc2BnYlDCyVdN1ObZ9P2vlBfZQh5HCUIePbf4xxGbw=;
        b=BVMabJEq+b42HWuRZiL6/ez3l3IT6SQnrnMO+L5H2SqNrqqMXuqordGvFZ5XOgaE3N
         wC6xGtGc/IcZpbxTTqp0LoBSPvhQ8ZDpRrseJrHXGCJRHXGzWUSrTQE5yDc1uBDpvPqi
         VvR1GYDBlFIeQO/m8NojaXhCwfkoTHGXT9j/ISp/UdFUIPpmhgocmP3lp8bWBho2CGbD
         ktvfuK7mdVVUY30JwIrHM6LVx9A27ZxVHiZPiNlFWIwrkKcAMpOdyrQoN7WKaAU30Ht+
         EgvhniPNq5C48PUmTiEWAfKdYe6dpB5ZbWjFgHyj7nE8tChyEZ/t6YA6qUN8TcRT9aoH
         KRQg==
X-Gm-Message-State: AOUpUlE8Rgnx1FJ5p3H9t+enZx1F2bjz1b3mCaAKWQBJ3Br9MC9YLIE9
        8KClJM7w8v/FF8ccG6vKzbUYOCvQMDu11DBq4mmvWOKI/S8J
X-Google-Smtp-Source: AA+uWPxVyKcRGXTVXpGHju4kRupXzGMxKhGuYgqsdFHI/BJMrjbELxBHR0qQQVEwubv3p8wHRd3NG1n/zeYzxfTWBtOpPrGM2nr0
MIME-Version: 1.0
X-Received: by 2002:a6b:ab81:: with SMTP id u123-v6mr12098158ioe.102.1534350963319;
 Wed, 15 Aug 2018 09:36:03 -0700 (PDT)
Date:   Wed, 15 Aug 2018 09:36:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000212a2005737bec96@google.com>
Subject: KASAN: use-after-free Read in end_requests
From:   syzbot <syzbot+444b9c373e79de86c456@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    94710cac0ef4 Linux 4.18
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10d962c4400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=265bef9882cce8d7
dashboard link: https://syzkaller.appspot.com/bug?extid=444b9c373e79de86c456
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+444b9c373e79de86c456@syzkaller.appspotmail.com

bridge0: port 3(veth0) entered disabled state
device veth0 entered promiscuous mode
bridge0: port 3(veth0) entered blocking state
bridge0: port 3(veth0) entered forwarding state
==================================================================
BUG: KASAN: use-after-free in __list_del_entry_valid+0xd0/0xf3  
lib/list_debug.c:42
Read of size 8 at addr ffff8801d89e4a08 by task syz-executor6/7918

CPU: 1 PID: 7918 Comm: syz-executor6 Not tainted 4.18.0+ #186
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  __list_del_entry_valid+0xd0/0xf3 lib/list_debug.c:42
  __list_del_entry include/linux/list.h:117 [inline]
  list_del_init include/linux/list.h:159 [inline]
  end_requests+0x180/0x460 fs/fuse/dev.c:2044
  fuse_dev_release+0x18c/0x2e0 fs/fuse/dev.c:2154
  __fput+0x355/0x8b0 fs/file_table.c:209
  ____fput+0x15/0x20 fs/file_table.c:243
  task_work_run+0x1ec/0x2a0 kernel/task_work.c:113
  get_signal+0x1559/0x1970 kernel/signal.c:2298
Unknown ioctl 1074021777
  do_signal+0x9c/0x21c0 arch/x86/kernel/signal.c:816
  exit_to_usermode_loop+0x2e0/0x370 arch/x86/entry/common.c:162
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457089
Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f7cdc2b5c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: 0000000000000030 RBX: 00007f7cdc2b66d4 RCX: 0000000000457089
RDX: 0000000000001000 RSI: 0000000020001000 RDI: 0000000000000003
RBP: 0000000000930140 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004d3240 R14: 00000000004c8281 R15: 0000000000000001

Allocated by task 7914:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
  kmem_cache_alloc+0x12e/0x760 mm/slab.c:3554
  __fuse_request_alloc+0x27/0xf0 fs/fuse/dev.c:58
  fuse_request_alloc+0x18/0x20 fs/fuse/dev.c:89
  fuse_fill_super+0x12cb/0x1ee0 fs/fuse/inode.c:1154
  mount_nodev+0x6b/0x110 fs/super.c:1220
  fuse_mount+0x2c/0x40 fs/fuse/inode.c:1210
  mount_fs+0xae/0x328 fs/super.c:1277
  vfs_kern_mount.part.34+0xdc/0x4e0 fs/namespace.c:1046
  vfs_kern_mount fs/namespace.c:1036 [inline]
  do_new_mount fs/namespace.c:2542 [inline]
  do_mount+0x581/0x30e0 fs/namespace.c:2872
  ksys_mount+0x12d/0x140 fs/namespace.c:3088
  __do_sys_mount fs/namespace.c:3102 [inline]
  __se_sys_mount fs/namespace.c:3099 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3099
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 7914:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kmem_cache_free+0x86/0x2d0 mm/slab.c:3756
  fuse_request_free+0x8b/0xa0 fs/fuse/dev.c:104
  fuse_put_request+0x2b7/0x360 fs/fuse/dev.c:294
  request_end+0x3ee/0xb20 fs/fuse/dev.c:403
  end_requests+0x296/0x460 fs/fuse/dev.c:2045
  fuse_abort_conn+0xf9c/0x1580 fs/fuse/dev.c:2138
  fuse_put_super+0x123/0x440 fs/fuse/inode.c:396
  generic_shutdown_super+0x1bf/0x530 fs/super.c:453
  kill_anon_super+0x3c/0x50 fs/super.c:1046
  fuse_kill_sb_anon+0x90/0xb0 fs/fuse/inode.c:1223
  deactivate_locked_super+0x97/0x100 fs/super.c:326
  deactivate_super+0x193/0x1c0 fs/super.c:357
  cleanup_mnt+0xbf/0x160 fs/namespace.c:1183
  __cleanup_mnt+0x16/0x20 fs/namespace.c:1190
  task_work_run+0x1ec/0x2a0 kernel/task_work.c:113
  get_signal+0x1559/0x1970 kernel/signal.c:2298
  do_signal+0x9c/0x21c0 arch/x86/kernel/signal.c:816
  exit_to_usermode_loop+0x2e0/0x370 arch/x86/entry/common.c:162
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8801d89e4a00
  which belongs to the cache fuse_request of size 448
The buggy address is located 8 bytes inside of
  448-byte region [ffff8801d89e4a00, ffff8801d89e4bc0)
The buggy address belongs to the page:
page:ffffea0007627900 count:1 mapcount:0 mapping:ffff8801d478cb40 index:0x0
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffffea0006c23bc8 ffff8801d4749348 ffff8801d478cb40
raw: 0000000000000000 ffff8801d89e4000 0000000100000008 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801d89e4900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8801d89e4980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff8801d89e4a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                       ^
  ffff8801d89e4a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801d89e4b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
