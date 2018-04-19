Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753620AbeDSQCT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 12:02:19 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:52694 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753549AbeDSQCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 12:02:02 -0400
X-Google-Smtp-Source: AIpwx4+o6u7/lWZBhslufuvmQuhr1Y12Nnt32CF/UgeHHo0c1jWqWqt62KvItL4NxlO/dGiT3wbsU2XrLARtYSUheWuPsx9Dpc/o
MIME-Version: 1.0
Date: Thu, 19 Apr 2018 09:02:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002df264056a35b16b@google.com>
Subject: kernel BUG at fs/buffer.c:LINE!
From: syzbot <syzbot+cfed5b56649bddf80d6e@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot hit the following crash on upstream commit
86bbbebac1933e6e95e8234c4f7d220c5ddd38bc (Mon Apr 2 18:47:07 2018 +0000)
Merge branch 'ras-core-for-linus' of  
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=cfed5b56649bddf80d6e

So far this crash happened 2 times on upstream.
Unfortunately, I don't have any reproducer for this crash yet.
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=4808221449519104
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=6801295859785128502
compiler: gcc (GCC) 7.1.1 20170620

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+cfed5b56649bddf80d6e@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

FAT-fs (loop0): Directory bread(block 14) failed
FAT-fs (loop0): Directory bread(block 15) failed
netlink: 2 bytes leftover after parsing attributes in process  
`syz-executor6'.
------------[ cut here ]------------
kernel BUG at fs/buffer.c:3058!
invalid opcode: 0000 [#1] SMP KASAN
VFS: Can't find a Minix filesystem V1 | V2 | V3 on device loop3.
Dumping ftrace buffer:
    (ftrace buffer empty)
Modules linked in:
CPU: 1 PID: 16389 Comm: syz-executor0 Not tainted 4.16.0+ #11
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:submit_bh_wbc+0x5a0/0x710 fs/buffer.c:3058
RSP: 0018:ffff8801c737f6c0 EFLAGS: 00010212
RAX: 0000000000040000 RBX: ffff88017247f3f0 RCX: ffffffff81bfe2b0
RDX: 000000000001b35c RSI: ffffc90001ea8000 RDI: 0000000000000001
RBP: ffff8801c737f708 R08: 0000000000000000 R09: ffffed002e48fe8b
R10: 0000000000000001 R11: ffffed002e48fe8a R12: 1ffff10038e6fee4
R13: 0000000000000800 R14: 0000000000000000 R15: 0000000000000001
FS:  00007fb154769700(0000) GS:ffff8801db100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000ddce80 CR3: 00000001c4034004 CR4: 00000000001606e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  submit_bh fs/buffer.c:3105 [inline]
  __sync_dirty_buffer+0x175/0x350 fs/buffer.c:3191
  sync_dirty_buffer+0x1a/0x20 fs/buffer.c:3204
  fat_set_state+0x1ec/0x300 fs/fat/inode.c:696
  fat_fill_super+0x2cf9/0x4940 fs/fat/inode.c:1855
  vfat_fill_super+0x31/0x40 fs/fat/namei_vfat.c:1059
  mount_bdev+0x2b7/0x370 fs/super.c:1119
  vfat_mount+0x34/0x40 fs/fat/namei_vfat.c:1066
  mount_fs+0x66/0x2d0 fs/super.c:1222
  vfs_kern_mount.part.26+0xc6/0x4a0 fs/namespace.c:1037
  vfs_kern_mount fs/namespace.c:2509 [inline]
  do_new_mount fs/namespace.c:2512 [inline]
  do_mount+0xea4/0x2bb0 fs/namespace.c:2842
  SYSC_mount fs/namespace.c:3058 [inline]
  SyS_mount+0xab/0x120 fs/namespace.c:3035
  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x457d0a
RSP: 002b:00007fb154768bb8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000000 RCX: 0000000000457d0a
RDX: 0000000020000000 RSI: 0000000020000140 RDI: 00007fb154768c00
RBP: 0000000000000001 R08: 0000000020000240 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000013
R13: 000000000000066e R14: 00000000006fcaf0 R15: 0000000000000000
Code: 89 45 d0 48 8d 43 10 48 89 45 c0 e9 52 fc ff ff e8 46 46 b1 ff f0 80  
63 01 f7 e9 34 fb ff ff e8 37 46 b1 ff 0f 0b e8 30 46 b1 ff <0f> 0b e8 29  
46 b1 ff 0f 0b e8 22 46 b1 ff 0f 0b e8 1b 46 b1 ff
RIP: submit_bh_wbc+0x5a0/0x710 fs/buffer.c:3058 RSP: ffff8801c737f6c0
---[ end trace 56c650f20e19f6bf ]---


---
This bug is generated by a dumb bot. It may contain errors.
See https://goo.gl/tpsmEJ for details.
Direct all questions to syzkaller@googlegroups.com.

syzbot will keep track of this bug report.
If you forgot to add the Reported-by tag, once the fix for this bug is  
merged
into any tree, please reply to this email with:
#syz fix: exact-commit-title
To mark this as a duplicate of another syzbot report, please reply with:
#syz dup: exact-subject-of-another-report
If it's a one-off invalid bug report, please reply with:
#syz invalid
Note: if the crash happens again, it will cause creation of a new bug  
report.
Note: all commands must start from beginning of the line in the email body.
