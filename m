Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752866AbeDULCE (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 07:02:04 -0400
Received: from mail-io0-f200.google.com ([209.85.223.200]:56242 "EHLO
        mail-io0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751462AbeDULCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 07:02:02 -0400
X-Google-Smtp-Source: AB8JxZoJrexPfL2zqE5bcIF2bQ1EI1+zyNs8X1bOwGjaXIAPdVg9NEjVaYMD3atsqD8qOGcU7SYNfoKGwlMKZABEoDC5cmWuDADB
MIME-Version: 1.0
Date: Sat, 21 Apr 2018 04:02:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f57ef4056a59bb4d@google.com>
Subject: kernel BUG at fs/f2fs/segment.c:LINE!
From: syzbot <syzbot+bf9253040425feb155ad@syzkaller.appspotmail.com>
To: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        yuchao0@huawei.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot hit the following crash on upstream commit
83beed7b2b26f232d782127792dd0cd4362fdc41 (Fri Apr 20 17:56:32 2018 +0000)
Merge branch 'fixes' of  
git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=bf9253040425feb155ad

syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=5692130282438656
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=5095924598571008
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=1808800213120130118
compiler: gcc (GCC) 8.0.1 20180413 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+bf9253040425feb155ad@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

F2FS-fs (loop0): invalid crc value
F2FS-fs (loop0): Try to recover 1th superblock, ret: 0
F2FS-fs (loop0): Mounted with checkpoint version = d
F2FS-fs (loop0): Bitmap was wrongly cleared, blk:9740
------------[ cut here ]------------
kernel BUG at fs/f2fs/segment.c:1884!
invalid opcode: 0000 [#1] SMP KASAN
Dumping ftrace buffer:
    (ftrace buffer empty)
Modules linked in:
CPU: 1 PID: 4508 Comm: syz-executor0 Not tainted 4.17.0-rc1+ #10
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:update_sit_entry+0x1215/0x1590 fs/f2fs/segment.c:1882
RSP: 0018:ffff8801af526708 EFLAGS: 00010282
RAX: ffffed0035ea4cc0 RBX: ffff8801ad454f90 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff82eeb87e RDI: ffffed0035ea4cb6
RBP: ffff8801af526760 R08: ffff8801ad4a2480 R09: ffffed003b5e4f90
R10: ffffed003b5e4f90 R11: ffff8801daf27c87 R12: ffff8801adb8d380
R13: 0000000000000001 R14: 0000000000000008 R15: 00000000ffffffff
FS:  00000000014af940(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f06bc223000 CR3: 00000001adb02000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  allocate_data_block+0x66f/0x2050 fs/f2fs/segment.c:2663
  do_write_page+0x105/0x1b0 fs/f2fs/segment.c:2727
  write_node_page+0x129/0x350 fs/f2fs/segment.c:2770
  __write_node_page+0x7da/0x1370 fs/f2fs/node.c:1398
  sync_node_pages+0x18cf/0x1eb0 fs/f2fs/node.c:1652
  block_operations+0x429/0xa60 fs/f2fs/checkpoint.c:1088
  write_checkpoint+0x3ba/0x5380 fs/f2fs/checkpoint.c:1405
  f2fs_sync_fs+0x2fb/0x6a0 fs/f2fs/super.c:1077
  __sync_filesystem fs/sync.c:39 [inline]
  sync_filesystem+0x265/0x310 fs/sync.c:67
  generic_shutdown_super+0xd7/0x520 fs/super.c:429
  kill_block_super+0xa4/0x100 fs/super.c:1191
  kill_f2fs_super+0x9f/0xd0 fs/f2fs/super.c:3030
  deactivate_locked_super+0x97/0x100 fs/super.c:316
  deactivate_super+0x188/0x1b0 fs/super.c:347
  cleanup_mnt+0xbf/0x160 fs/namespace.c:1174
  __cleanup_mnt+0x16/0x20 fs/namespace.c:1181
  task_work_run+0x1e4/0x290 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:191 [inline]
  exit_to_usermode_loop+0x2bd/0x310 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:265 [inline]
  do_syscall_64+0x6ac/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457d97
RSP: 002b:00007ffd46f9c8e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000457d97
RDX: 00000000014b09a3 RSI: 0000000000000002 RDI: 00007ffd46f9da50
RBP: 00007ffd46f9da50 R08: 0000000000000000 R09: 0000000000000009
R10: 0000000000000005 R11: 0000000000000246 R12: 00000000014b0940
R13: 0000000000000000 R14: 0000000000000002 R15: 000000000000658e
Code: c6 40 d6 f2 87 e8 5c 1d f6 ff 0f 0b e8 15 96 80 fe 8b 4d d0 48 8b 7d  
b8 48 c7 c2 20 d7 f2 87 48 c7 c6 40 d6 f2 87 e8 3b 1d f6 ff <0f> 0b e8 e4  
f0 bc fe e9 73 ef ff ff 4c 89 ef e8 d7 f0 bc fe e9
RIP: update_sit_entry+0x1215/0x1590 fs/f2fs/segment.c:1882 RSP:  
ffff8801af526708
---[ end trace f498328bb02610a2 ]---


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
