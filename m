Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752570AbeEJVqD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 17:46:03 -0400
Received: from mail-io0-f200.google.com ([209.85.223.200]:37081 "EHLO
        mail-io0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752298AbeEJVqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 17:46:02 -0400
X-Google-Smtp-Source: AB8JxZpk1CjLqAY8iGdYzd4LhIleCxurLyq0qzpvAh4/GK4eYdXTaLaJwXSr4Kc/SxL9D3vs0oqJWPZEQOy5VMqQ3/Q6tPQ0Zdxv
MIME-Version: 1.0
Date: Thu, 10 May 2018 14:46:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000011b400056be0f28d@google.com>
Subject: WARNING: kmalloc bug in get_valid_checkpoint
From: syzbot <syzbot+ef4e8fc3a06e9019bb40@syzkaller.appspotmail.com>
To: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        yuchao0@huawei.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    008464a9360e Merge branch 'for-linus' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15f3a077800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=31f4b3733894ef79
dashboard link: https://syzkaller.appspot.com/bug?extid=ef4e8fc3a06e9019bb40
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=15499a97800000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+ef4e8fc3a06e9019bb40@syzkaller.appspotmail.com

IPVS: ftp: loaded support on port[0] = 21
IPVS: ftp: loaded support on port[0] = 21
IPVS: ftp: loaded support on port[0] = 21
F2FS-fs (loop1): Magic Mismatch, valid(0xf2f52010) - read(0x0)
F2FS-fs (loop1): Can't find valid F2FS filesystem in 1th superblock
WARNING: CPU: 1 PID: 4572 at mm/slab_common.c:996 kmalloc_slab+0x56/0x70  
mm/slab_common.c:996
Kernel panic - not syncing: panic_on_warn set ...

CPU: 1 PID: 4572 Comm: syz-executor1 Not tainted 4.17.0-rc4+ #40
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
IPVS: ftp: loaded support on port[0] = 21
  panic+0x22f/0x4de kernel/panic.c:184
  __warn.cold.8+0x163/0x1b3 kernel/panic.c:536
  report_bug+0x252/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x1de/0x490 arch/x86/kernel/traps.c:296
F2FS-fs (loop0): Magic Mismatch, valid(0xf2f52010) - read(0x0)
  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:315
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:992
F2FS-fs (loop0): Can't find valid F2FS filesystem in 1th superblock
RIP: 0010:kmalloc_slab+0x56/0x70 mm/slab_common.c:996
RSP: 0018:ffff8801ae926e08 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff8801b21c9540 RCX: ffffffff82f163e4
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000001e3a030000
RBP: ffff8801ae926e08 R08: ffff8801b26a0040 R09: ffffed003b5e46c2
R10: ffffed003b5e46c2 R11: ffff8801daf23613 R12: 0000001e3a030000
R13: ffff8801b21ca298 R14: 0000000000000000 R15: 00000000014080c0
  __do_kmalloc mm/slab.c:3713 [inline]
  __kmalloc+0x25/0x760 mm/slab.c:3727
  kmalloc include/linux/slab.h:517 [inline]
  f2fs_kmalloc fs/f2fs/f2fs.h:2534 [inline]
  f2fs_kzalloc fs/f2fs/f2fs.h:2540 [inline]
  get_valid_checkpoint+0x37f/0x1e90 fs/f2fs/checkpoint.c:805
F2FS-fs (loop0): Failed to get valid F2FS checkpoint
F2FS-fs (loop0): Magic Mismatch, valid(0xf2f52010) - read(0x0)
  f2fs_fill_super+0x318f/0x7bf0 fs/f2fs/super.c:2768
F2FS-fs (loop0): Can't find valid F2FS filesystem in 1th superblock
F2FS-fs (loop0): Failed to get valid F2FS checkpoint
F2FS-fs (loop7): Magic Mismatch, valid(0xf2f52010) - read(0x0)
F2FS-fs (loop7): Can't find valid F2FS filesystem in 1th superblock
  mount_bdev+0x30c/0x3e0 fs/super.c:1164
  f2fs_mount+0x34/0x40 fs/f2fs/super.c:3020
  mount_fs+0xae/0x328 fs/super.c:1267
  vfs_kern_mount.part.34+0xd4/0x4d0 fs/namespace.c:1037
  vfs_kern_mount fs/namespace.c:1027 [inline]
  do_new_mount fs/namespace.c:2518 [inline]
  do_mount+0x564/0x3070 fs/namespace.c:2848
  ksys_mount+0x12d/0x140 fs/namespace.c:3064
  __do_sys_mount fs/namespace.c:3078 [inline]
  __se_sys_mount fs/namespace.c:3075 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3075
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4583aa
RSP: 002b:00007f33f012aba8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000040 RCX: 00000000004583aa
RDX: 0000000020000040 RSI: 0000000020000080 RDI: 00007f33f012abf0
RBP: 0000000000000001 R08: 00000000200000c0 R09: 0000000020000040
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
R13: 0000000000000001 R14: 00000000006fe2d0 R15: 0000000000000000
Dumping ftrace buffer:
    (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report.
If you forgot to add the Reported-by tag, once the fix for this bug is  
merged
into any tree, please reply to this email with:
#syz fix: exact-commit-title
If you want to test a patch for this bug, please reply with:
#syz test: git://repo/address.git branch
and provide the patch inline or as an attachment.
To mark this as a duplicate of another syzbot report, please reply with:
#syz dup: exact-subject-of-another-report
If it's a one-off invalid bug report, please reply with:
#syz invalid
Note: if the crash happens again, it will cause creation of a new bug  
report.
Note: all commands must start from beginning of the line in the email body.
