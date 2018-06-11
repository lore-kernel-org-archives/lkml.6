Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id RSvqFGQMHlt2MQAAmS7hNA
	; Mon, 11 Jun 2018 05:45:08 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 3ADB560791; Mon, 11 Jun 2018 05:45:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=2.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEXHASH_WORD,MAILING_LIST_MULTI autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 67C01606FA;
	Mon, 11 Jun 2018 05:45:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 67C01606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754003AbeFKFpE (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 01:45:04 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:55863 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753875AbeFKFpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 01:45:02 -0400
Received: by mail-it0-f69.google.com with SMTP id i127-v6so7339591ita.5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jun 2018 22:45:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=RrL224yKwN86TIY8koIMhgPRPgrQJyndnBJSGcg4qlQ=;
        b=Dzwz7PbHN0xU8vBpdESlUSqIBc01ZSzffVJ6urPoTKqUMHukl/W3Qd6NpdAuDxEaY5
         cbTQMphAZRaLy1YOh+DFg3KhxxZeHPmj9hlaglLkEHSf3XgCoYo8lW/vRGoRDtZdp41x
         34fcEob3W+f57RlkAHkZg23sb7+3HlWbz5+Oi9SgzDaKnNMGYVK69AmbxMKzxEa34rp7
         fBAEk3VqB5puLDWSChXPdRlegjF1XUZ90nqogowKzr7JKqyl1x7bBBOP5FCanlGB5Prn
         dN9xZiLyidqWzQRBGXfnwha1xcwTaN6K7O0I727XJdeRrA03SATfperPS6N7SoGysgWF
         UOeA==
X-Gm-Message-State: APt69E3WMpg4lnSMbSejJpXARSy1SSfFPSosJ0l+pNVuT91fbRwkNsy7
        Rh8jxtMvdsF5ToFGbT5FfZyXDQ/5ZnIcRBS86KHZlKFtaD/h
X-Google-Smtp-Source: ADUXVKK+XXAn2/ReeLvbnLRkXS0N4HO9CBvvoPRp80RH9rSKGKOVE1lzC+qS0P+nW1azUt35PokH+A+LE/2tK6QjyDbnjLn/vQ+Q
MIME-Version: 1.0
X-Received: by 2002:a6b:8b51:: with SMTP id n78-v6mr7959813iod.67.1528695902156;
 Sun, 10 Jun 2018 22:45:02 -0700 (PDT)
Date: Sun, 10 Jun 2018 22:45:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000037c4d2056e5740c3@google.com>
Subject: KASAN: use-after-free Read in getname_kernel
From: syzbot <syzbot+abf707d7ccbb3244f34e@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    3ca24ce9ff76 Merge branch 'proc-cmdline'
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15ed37d7800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=314f2150f36c16ca
dashboard link: https://syzkaller.appspot.com/bug?extid=abf707d7ccbb3244f34e
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+abf707d7ccbb3244f34e@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in memcpy include/linux/string.h:345 [inline]
BUG: KASAN: use-after-free in getname_kernel+0x123/0x370 fs/namei.c:241
Read of size 11 at addr ffff8801d8053310 by task syz-executor5/15925

CPU: 0 PID: 15925 Comm: syz-executor5 Not tainted 4.17.0+ #94
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
  check_memory_region_inline mm/kasan/kasan.c:260 [inline]
  check_memory_region+0x13e/0x1b0 mm/kasan/kasan.c:267
  memcpy+0x23/0x50 mm/kasan/kasan.c:302
  memcpy include/linux/string.h:345 [inline]
  getname_kernel+0x123/0x370 fs/namei.c:241
  kern_path+0x1e/0x40 fs/namei.c:2410
  lookup_bdev+0xfa/0x240 fs/block_dev.c:2084
  blkdev_get_by_path+0x1f/0xe0 fs/block_dev.c:1687
  btrfs_get_bdev_and_sb+0x38/0x300 fs/btrfs/volumes.c:392
  btrfs_open_one_device fs/btrfs/volumes.c:695 [inline]
  open_fs_devices+0x6a5/0xc60 fs/btrfs/volumes.c:1112
  btrfs_open_devices+0xc0/0xd0 fs/btrfs/volumes.c:1155
  btrfs_mount_root+0x91f/0x1e70 fs/btrfs/super.c:1568
  mount_fs+0xae/0x328 fs/super.c:1277
  vfs_kern_mount.part.34+0xd4/0x4d0 fs/namespace.c:1037
  vfs_kern_mount+0x40/0x60 fs/namespace.c:1027
  btrfs_mount+0x4a1/0x213e fs/btrfs/super.c:1661
  mount_fs+0xae/0x328 fs/super.c:1277
  vfs_kern_mount.part.34+0xd4/0x4d0 fs/namespace.c:1037
  vfs_kern_mount fs/namespace.c:1027 [inline]
  do_new_mount fs/namespace.c:2518 [inline]
  do_mount+0x564/0x30b0 fs/namespace.c:2848
  ksys_mount+0x12d/0x140 fs/namespace.c:3064
  __do_sys_mount fs/namespace.c:3078 [inline]
  __se_sys_mount fs/namespace.c:3075 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3075
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45842a
Code: b8 a6 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 dd 8f fb ff c3 66 2e 0f  
1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 ba 8f fb ff c3 66 0f 1f 84 00 00 00 00 00
RSP: 002b:00007fe10e408ba8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000080 RCX: 000000000045842a
RDX: 0000000020000080 RSI: 0000000020000100 RDI: 00007fe10e408bf0
RBP: 0000000000000001 R08: 0000000020000240 R09: 0000000020000080
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000014
R13: 0000000000000001 R14: 00000000004d2bc0 R15: 0000000000000000

Allocated by task 15908:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  __do_kmalloc mm/slab.c:3718 [inline]
  __kmalloc+0x14e/0x760 mm/slab.c:3727
  kmalloc include/linux/slab.h:518 [inline]
  kzalloc include/linux/slab.h:706 [inline]
  rcu_string_strdup fs/btrfs/rcu-string.h:17 [inline]
  btrfs_prepare_close_one_device fs/btrfs/volumes.c:1031 [inline]
  close_fs_devices+0x497/0xfa0 fs/btrfs/volumes.c:1052
  btrfs_close_devices+0x29/0x150 fs/btrfs/volumes.c:1085
  open_ctree+0x589/0x7898 fs/btrfs/disk-io.c:3358
  btrfs_fill_super fs/btrfs/super.c:1202 [inline]
  btrfs_mount_root+0x16df/0x1e70 fs/btrfs/super.c:1593
  mount_fs+0xae/0x328 fs/super.c:1277
  vfs_kern_mount.part.34+0xd4/0x4d0 fs/namespace.c:1037
  vfs_kern_mount+0x40/0x60 fs/namespace.c:1027
  btrfs_mount+0x4a1/0x213e fs/btrfs/super.c:1661
  mount_fs+0xae/0x328 fs/super.c:1277
  vfs_kern_mount.part.34+0xd4/0x4d0 fs/namespace.c:1037
  vfs_kern_mount fs/namespace.c:1027 [inline]
  do_new_mount fs/namespace.c:2518 [inline]
  do_mount+0x564/0x30b0 fs/namespace.c:2848
  ksys_mount+0x12d/0x140 fs/namespace.c:3064
  __do_sys_mount fs/namespace.c:3078 [inline]
  __se_sys_mount fs/namespace.c:3075 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3075
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 15922:
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
  rcu_process_callbacks+0xfc5/0x1760 kernel/rcu/tree.c:2802
  __do_softirq+0x2e0/0xaf5 kernel/softirq.c:284

The buggy address belongs to the object at ffff8801d8053300
  which belongs to the cache kmalloc-32 of size 32
The buggy address is located 16 bytes inside of
  32-byte region [ffff8801d8053300, ffff8801d8053320)
The buggy address belongs to the page:
page:ffffea00076014c0 count:1 mapcount:0 mapping:ffff8801da8001c0  
index:0xffff8801d8053fc1
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffffea00075f2f08 ffffea00075a9a08 ffff8801da8001c0
raw: ffff8801d8053fc1 ffff8801d8053000 0000000100000011 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801d8053200: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
  ffff8801d8053280: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
> ffff8801d8053300: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
                          ^
  ffff8801d8053380: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
  ffff8801d8053400: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
