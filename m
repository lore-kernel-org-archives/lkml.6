Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758664AbeD0QAR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 12:00:17 -0400
Received: from mail-io0-f198.google.com ([209.85.223.198]:45649 "EHLO
        mail-io0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758472AbeD0QAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 12:00:02 -0400
X-Google-Smtp-Source: AB8JxZrvzSQltDehbBhWOHnrwVEDU5OiJivoHwEVcSs4eGeLA68N+BPSN6a7nF5KZbCrAUjpDQ5zDnvlv9BFSYi74DUebx3g2TJA
MIME-Version: 1.0
Date: Fri, 27 Apr 2018 09:00:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c0a706056ad69897@google.com>
Subject: general protection fault in fuse_ctl_remove_conn
From: syzbot <syzbot+32c236387d66c4516827@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot hit the following crash on upstream commit
0644f186fc9d77bb5bd198369e59fb28927a3692 (Thu Apr 26 23:36:11 2018 +0000)
Merge tag 'for_linus' of  
git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=32c236387d66c4516827

So far this crash happened 2 times on upstream.
C reproducer: https://syzkaller.appspot.com/x/repro.c?id=6056306666373120
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=6559188280934400
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=4532195645456384
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=7043958930931867332
compiler: gcc (GCC) 8.0.1 20180413 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+32c236387d66c4516827@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

RBP: 0030656c69662f2e R08: 0000000020000300 R09: 0000000000003833
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe5dea3810
R13: ffffffffffffffff R14: 006c746365737566 R15: 0000000000000044
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
Dumping ftrace buffer:
    (ftrace buffer empty)
Modules linked in:
CPU: 0 PID: 4504 Comm: syz-executor777 Not tainted 4.17.0-rc2+ #19
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:fuse_ctl_remove_conn+0xc8/0x1b0 fs/fuse/control.c:286
RSP: 0018:ffff8801b0ee7968 EFLAGS: 00010202
RAX: 0000000000000075 RBX: ffff8801ac6dc2c0 RCX: ffffffff82645bb7
RDX: 0000000000000000 RSI: ffffffff82645bda RDI: 00000000000003a8
RBP: ffff8801b0ee7990 R08: ffff8801b1cd2740 R09: ffffed003b5c46c2
R10: ffffed003b5c46c2 R11: ffff8801dae23613 R12: 0000000000000001
R13: ffff8801d0bb5410 R14: dffffc0000000000 R15: 0000000000000000
FS:  00000000026bc880(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000001471000 CR3: 00000001b1137000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  fuse_ctl_add_conn+0x261/0x280 fs/fuse/control.c:269
  fuse_ctl_fill_super+0xf7/0x160 fs/fuse/control.c:307
  mount_single+0xfb/0x170 fs/super.c:1236
  fuse_ctl_mount+0x2c/0x40 fs/fuse/control.c:322
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
RIP: 0033:0x440579
RSP: 002b:00007ffe5dea3808 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000440579
RDX: 00000000200002c0 RSI: 0000000020000280 RDI: 0000000020000240
RBP: 0030656c69662f2e R08: 0000000020000300 R09: 0000000000003833
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe5dea3810
R13: ffffffffffffffff R14: 006c746365737566 R15: 0000000000000044
Code: 8b 5d 00 48 8d 7b 58 48 89 f8 48 c1 e8 03 42 80 3c 30 00 0f 85 cc 00  
00 00 4c 8b 7b 58 49 8d bf a8 03 00 00 48 89 f8 48 c1 e8 03 <42> 80 3c 30  
00 0f 85 a5 00 00 00 48 89 df 41 83 ec 01 49 83 ed
RIP: fuse_ctl_remove_conn+0xc8/0x1b0 fs/fuse/control.c:286 RSP:  
ffff8801b0ee7968
---[ end trace d64f1dab46c839a5 ]---


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
