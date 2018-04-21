Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752241AbeDUHCE (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 03:02:04 -0400
Received: from mail-io0-f199.google.com ([209.85.223.199]:54463 "EHLO
        mail-io0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750931AbeDUHCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 03:02:02 -0400
X-Google-Smtp-Source: AIpwx48IOJecyZaDP/Koq6GTOdYg+kweeUE9VGtdIEKj2czIi20kjwCSxWSmaJ+KfOcxL1msM5TIkCq/EKvNCeTI8oczzD05AArS
MIME-Version: 1.0
Date: Sat, 21 Apr 2018 00:02:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aa1e22056a5661df@google.com>
Subject: kernel BUG at fs/f2fs/inode.c:LINE!
From: syzbot <syzbot+41a1b341571f0952badb@syzkaller.appspotmail.com>
To: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        yuchao0@huawei.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot hit the following crash on upstream commit
43f70c960180c11d64ee3e9e53075fe1acd43ff1 (Fri Apr 20 16:08:37 2018 +0000)
Merge tag 'ecryptfs-4.17-rc2-fixes' of  
git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=41a1b341571f0952badb

C reproducer: https://syzkaller.appspot.com/x/repro.c?id=4580931511779328
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=5022282351116288
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=6030092669026304
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=1808800213120130118
compiler: gcc (GCC) 8.0.1 20180413 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+41a1b341571f0952badb@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

F2FS-fs (loop0): Magic Mismatch, valid(0xf2f52010) - read(0x0)
F2FS-fs (loop0): Can't find valid F2FS filesystem in 1th superblock
F2FS-fs (loop0): invalid crc value
------------[ cut here ]------------
kernel BUG at fs/f2fs/inode.c:242!
invalid opcode: 0000 [#1] SMP KASAN
Dumping ftrace buffer:
    (ftrace buffer empty)
Modules linked in:
CPU: 0 PID: 4543 Comm: syzkaller153755 Not tainted 4.17.0-rc1+ #9
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:do_read_inode fs/f2fs/inode.c:242 [inline]
RIP: 0010:f2fs_iget+0x3440/0x3d10 fs/f2fs/inode.c:317
RSP: 0018:ffff8801d90370e8 EFLAGS: 00010293
RAX: ffff8801d906c400 RBX: ffff8801b6ec10c0 RCX: ffffffff82eaccd4
RDX: 0000000000000000 RSI: ffffffff82eaee50 RDI: 0000000000000007
RBP: ffff8801d9037410 R08: ffff8801d906c400 R09: ffffed003b2fbab6
R10: ffffed003b2fbab6 R11: ffff8801d97dd5b7 R12: ffff8801ad3c8000
R13: 0000000000000003 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000001393880(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fafd7c0c000 CR3: 00000001d9b5a000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  f2fs_fill_super+0x4377/0x7bf0 fs/f2fs/super.c:2842
  mount_bdev+0x30c/0x3e0 fs/super.c:1165
  f2fs_mount+0x34/0x40 fs/f2fs/super.c:3020
  mount_fs+0xae/0x328 fs/super.c:1268
  vfs_kern_mount.part.34+0xd4/0x4d0 fs/namespace.c:1037
  vfs_kern_mount fs/namespace.c:1027 [inline]
  do_new_mount fs/namespace.c:2517 [inline]
  do_mount+0x564/0x3070 fs/namespace.c:2847
  ksys_mount+0x12d/0x140 fs/namespace.c:3063
  __do_sys_mount fs/namespace.c:3077 [inline]
  __se_sys_mount fs/namespace.c:3074 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3074
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x443cfa
RSP: 002b:00007ffca5ac3f88 EFLAGS: 00000297 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000b70 RCX: 0000000000443cfa
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffca5ac3f90
RBP: 0000000000000003 R08: 0000000020016a00 R09: 000000000000000a
R10: 0000000000000000 R11: 0000000000000297 R12: 0000000000000004
R13: 0000000000402bf0 R14: 0000000000000000 R15: 0000000000000000
Code: 8e fe 48 c7 c2 e0 08 f2 87 be 1c 01 00 00 48 c7 c7 40 09 f2 87 c6 05  
88 e7 8b 06 01 e8 3b 4a 72 fe e9 51 ef ff ff e8 d0 41 8e fe <0f> 0b e8 c9  
41 8e fe e8 64 b7 78 fe 31 ff 89 c3 89 c6 e8 c9 42
RIP: do_read_inode fs/f2fs/inode.c:242 [inline] RSP: ffff8801d90370e8
RIP: f2fs_iget+0x3440/0x3d10 fs/f2fs/inode.c:317 RSP: ffff8801d90370e8
---[ end trace 8004fd56969de769 ]---


---
This bug is generated by a dumb bot. It may contain errors.
See https://goo.gl/tpsmEJ for details.
Direct all questions to syzkaller@googlegroups.com.

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
