Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753541AbeDTSCD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 14:02:03 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:38861 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753091AbeDTSCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 14:02:01 -0400
X-Google-Smtp-Source: AIpwx4+FbCkH1btB1zRbDjyeLbX3oIAEpIFgQqGc/zjal08sKUKXw0mu0HiloFl/l79AA+zQAimdlWW5i1QoXMTYSDuPfkV0rmik
MIME-Version: 1.0
Date: Fri, 20 Apr 2018 11:02:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000021d960056a4b7c6f@google.com>
Subject: BUG: unable to handle kernel paging request in build_segment_manager
From: syzbot <syzbot+83699adeb2d13579c31e@syzkaller.appspotmail.com>
To: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        yuchao0@huawei.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot hit the following crash on upstream commit
87ef12027b9b1dd0e0b12cf311fbcb19f9d92539 (Wed Apr 18 19:48:17 2018 +0000)
Merge tag 'ceph-for-4.17-rc2' of git://github.com/ceph/ceph-client
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=83699adeb2d13579c31e

C reproducer: https://syzkaller.appspot.com/x/repro.c?id=5805208181407744
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=6005073343676416
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=6555047731134464
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=1808800213120130118
compiler: gcc (GCC) 8.0.1 20180413 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+83699adeb2d13579c31e@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

F2FS-fs (loop0): Magic Mismatch, valid(0xf2f52010) - read(0x0)
F2FS-fs (loop0): Can't find valid F2FS filesystem in 1th superblock
F2FS-fs (loop0): invalid crc value
BUG: unable to handle kernel paging request at ffffed006b2a50c0
PGD 21ffee067 P4D 21ffee067 PUD 21fbeb067 PMD 0
Oops: 0000 [#1] SMP KASAN
Dumping ftrace buffer:
    (ftrace buffer empty)
Modules linked in:
CPU: 0 PID: 4514 Comm: syzkaller989480 Not tainted 4.17.0-rc1+ #8
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:build_sit_entries fs/f2fs/segment.c:3653 [inline]
RIP: 0010:build_segment_manager+0x7ef7/0xbf70 fs/f2fs/segment.c:3852
RSP: 0018:ffff8801b102e5b0 EFLAGS: 00010a06
RAX: 1ffff1006b2a50c0 RBX: 0000000000000004 RCX: 0000000000000001
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8801ac74243e
RBP: ffff8801b102f410 R08: ffff8801acbd46c0 R09: fffffbfff14d9af8
R10: fffffbfff14d9af8 R11: ffff8801acbd46c0 R12: ffff8801ac742a80
R13: ffff8801d9519100 R14: dffffc0000000000 R15: ffff880359528600
FS:  0000000001e04880(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffed006b2a50c0 CR3: 00000001ac6ac000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  f2fs_fill_super+0x4095/0x7bf0 fs/f2fs/super.c:2803
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
RIP: 0033:0x443d6a
RSP: 002b:00007ffd312813c8 EFLAGS: 00000297 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000c00 RCX: 0000000000443d6a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffd312813d0
RBP: 0000000000000003 R08: 0000000020016a00 R09: 000000000000000a
R10: 0000000000000000 R11: 0000000000000297 R12: 0000000000000004
R13: 0000000000402c60 R14: 0000000000000000 R15: 0000000000000000
Code: 48 89 55 80 48 8b 50 36 48 89 55 88 48 8b 50 3e 48 89 55 90 48 8b 50  
46 48 89 55 98 0f b7 40 4e 66 89 45 a0 4c 89 f8 48 c1 e8 03 <42> 0f b6 04  
30 84 c0 74 08 3c 03 0f 8e 1d 3a 00 00 41 0f b7 07
RIP: build_sit_entries fs/f2fs/segment.c:3653 [inline] RSP: ffff8801b102e5b0
RIP: build_segment_manager+0x7ef7/0xbf70 fs/f2fs/segment.c:3852 RSP:  
ffff8801b102e5b0
CR2: ffffed006b2a50c0
---[ end trace a2034989e196ff17 ]---


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
