Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753850AbeDSRCE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 13:02:04 -0400
Received: from mail-it0-f71.google.com ([209.85.214.71]:43977 "EHLO
        mail-it0-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753375AbeDSRCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 13:02:02 -0400
X-Google-Smtp-Source: AIpwx48nIz6nTAojFomEPC44ruXmnoNPakCRZPqeqrtv8Lz5Rxu+UXg3KxH3xVqePYxXStJ8ajQvUWWAEmHLh8I3moqSl+Y2I9GX
MIME-Version: 1.0
Date: Thu, 19 Apr 2018 10:02:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c4b45a056a36872f@google.com>
Subject: kernel BUG at fs/ntfs/aops.c:LINE!
From: syzbot <syzbot+6a5a7672f663cce8b156@syzkaller.appspotmail.com>
To: anton@tuxera.com, linux-kernel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot hit the following crash on upstream commit
87ef12027b9b1dd0e0b12cf311fbcb19f9d92539 (Wed Apr 18 19:48:17 2018 +0000)
Merge tag 'ceph-for-4.17-rc2' of git://github.com/ceph/ceph-client
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=6a5a7672f663cce8b156

So far this crash happened 2 times on upstream.
C reproducer: https://syzkaller.appspot.com/x/repro.c?id=5736415891554304
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=6093704288796672
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=4519020095078400
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=1808800213120130118
compiler: gcc (GCC) 8.0.1 20180413 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+6a5a7672f663cce8b156@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

ntfs: (device loop0): is_boot_sector_ntfs(): Invalid end of sector marker.
------------[ cut here ]------------
kernel BUG at fs/ntfs/aops.c:207!
invalid opcode: 0000 [#1] SMP KASAN
Dumping ftrace buffer:
    (ftrace buffer empty)
Modules linked in:
CPU: 0 PID: 4507 Comm: syzkaller117743 Not tainted 4.17.0-rc1+ #8
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:ntfs_read_block fs/ntfs/aops.c:207 [inline]
RIP: 0010:ntfs_readpage+0x1d0e/0x2290 fs/ntfs/aops.c:456
RSP: 0018:ffff8801d9096f48 EFLAGS: 00010293
RAX: ffff8801ac5a6440 RBX: 0000000000000000 RCX: ffffffff82573fa0
RDX: 0000000000000000 RSI: ffffffff82573fae RDI: 0000000000000007
RBP: ffff8801d90971a8 R08: ffff8801ac5a6440 R09: fffff94000e43853
R10: fffff94000e43853 R11: ffffea000721c29f R12: ffffea000721c290
R13: dffffc0000000000 R14: ffffea000721c280 R15: ffff8801a86b4788
FS:  0000000002339880(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000000 CR3: 00000001a8b1c000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  do_read_cache_page+0x778/0x13b0 mm/filemap.c:2806
  read_cache_page+0x61/0x80 mm/filemap.c:2894
  read_mapping_page include/linux/pagemap.h:402 [inline]
  ntfs_map_page fs/ntfs/aops.h:89 [inline]
  map_mft_record_page fs/ntfs/mft.c:85 [inline]
  map_mft_record+0x290/0xb40 fs/ntfs/mft.c:168
  ntfs_read_locked_inode+0x19b/0x55f0 fs/ntfs/inode.c:575
  ntfs_read_inode_mount+0xb53/0x23e0 fs/ntfs/inode.c:2100
  ntfs_fill_super+0x1513/0x3090 fs/ntfs/super.c:2871
  mount_bdev+0x30c/0x3e0 fs/super.c:1165
  ntfs_mount+0x34/0x40 fs/ntfs/super.c:3065
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
RIP: 0033:0x44471a
RSP: 002b:00007ffe6b3e9468 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00000000200012c0 RCX: 000000000044471a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffe6b3e9470
RBP: 0000000000000003 R08: 000000002007e200 R09: 000000000000000a
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000004
R13: 0000000000403610 R14: 0000000000000000 R15: 0000000000000000
Code: 85 18 fe ff ff 31 ff 48 8b 98 80 fd ff ff 48 c1 eb 03 83 e3 01 48 89  
de e8 b0 f1 21 ff 48 85 db 0f 85 38 f0 ff ff e8 72 f0 21 ff <0f> 0b c6 85  
c4 fd ff ff 00 e9 8c f4 ff ff e8 5f f0 21 ff 0f 0b
RIP: ntfs_read_block fs/ntfs/aops.c:207 [inline] RSP: ffff8801d9096f48
RIP: ntfs_readpage+0x1d0e/0x2290 fs/ntfs/aops.c:456 RSP: ffff8801d9096f48
---[ end trace dc7c4ed6d595ee67 ]---


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
