Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752338AbeC2XBc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 19:01:32 -0400
Received: from mail-io0-f200.google.com ([209.85.223.200]:54707 "EHLO
        mail-io0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752259AbeC2XBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 19:01:02 -0400
X-Google-Smtp-Source: AIpwx4/CxzCVXVbIY8KhOpKname1erAoB/kqkD0XiirPfNx4y1aisVnTBfxdsQGkeq2wGTLkWrrkAjs/KSfyz9sxSnUi06vbR/3l
MIME-Version: 1.0
Date: Thu, 29 Mar 2018 16:01:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <001a114043bcfab6ab05689518f9@google.com>
Subject: WARNING in kill_block_super
From: syzbot <syzbot+5a170e19c963a2e0df79@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot hit the following crash on upstream commit
0b412605ef5f5c64b31f19e2910b1d5eba9929c3 (Thu Mar 29 01:07:23 2018 +0000)
Merge tag 'drm-fixes-for-v4.16-rc8' of  
git://people.freedesktop.org/~airlied/linux
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=5a170e19c963a2e0df79

So far this crash happened 2 times on upstream.
C reproducer: https://syzkaller.appspot.com/x/repro.c?id=6168466046320640
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=4851040260194304
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=5936700618440704
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=-8440362230543204781
compiler: gcc (GCC) 7.1.1 20170620

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+5a170e19c963a2e0df79@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

RAX: ffffffffffffffda RBX: 00007ffed0bc62a0 RCX: 0000000000442e79
RDX: 00000000004a4d6d RSI: 0000000020001740 RDI: 0000000020001780
RBP: 0000000000000000 R08: 00007ffed0bc62a0 R09: ffffffffffffffff
R10: 0000000000000000 R11: 0000000000000206 R12: ffffffffffffffff
R13: 0000000000000008 R14: 0000000000001380 R15: 00007ffed0bc5b38
WARNING: CPU: 1 PID: 4445 at fs/super.c:1148 kill_block_super+0xc9/0xf0  
fs/super.c:1148
Kernel panic - not syncing: panic_on_warn set ...

CPU: 1 PID: 4445 Comm: syzkaller195321 Not tainted 4.16.0-rc7+ #5
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:17 [inline]
  dump_stack+0x194/0x24d lib/dump_stack.c:53
  panic+0x1e4/0x41c kernel/panic.c:183
  __warn+0x1dc/0x200 kernel/panic.c:547
  report_bug+0x1f4/0x2b0 lib/bug.c:186
  fixup_bug.part.11+0x37/0x80 arch/x86/kernel/traps.c:178
  fixup_bug arch/x86/kernel/traps.c:247 [inline]
  do_error_trap+0x2d7/0x3e0 arch/x86/kernel/traps.c:296
  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:315
  invalid_op+0x1b/0x40 arch/x86/entry/entry_64.S:986
RIP: 0010:kill_block_super+0xc9/0xf0 fs/super.c:1148
RSP: 0018:ffff8801aecc77a0 EFLAGS: 00010293
RAX: ffff8801af180040 RBX: ffff8801aede22c0 RCX: ffffffff81b31649
RDX: 0000000000000000 RSI: ffff8801b9a76478 RDI: ffff8801d5527ba0
RBP: ffff8801aecc77b8 R08: 0000000000000000 R09: 1ffff10035d98ea5
R10: ffff8801aecc7568 R11: 0000000000000001 R12: ffff8801d5527800
R13: 0000000000000000 R14: ffff8801aecc7a10 R15: ffff8801aede22c0
  fuse_kill_sb_blk+0x90/0xb0 fs/fuse/inode.c:1232
  deactivate_locked_super+0x88/0xd0 fs/super.c:312
  sget_userns+0xbda/0xe40 fs/super.c:522
  sget+0xd2/0x120 fs/super.c:557
  mount_bdev+0x109/0x370 fs/super.c:1092
  fuse_mount_blk+0x34/0x40 fs/fuse/inode.c:1219
  mount_fs+0x66/0x2d0 fs/super.c:1222
  vfs_kern_mount.part.26+0xc6/0x4a0 fs/namespace.c:1037
  vfs_kern_mount fs/namespace.c:2509 [inline]
  do_new_mount fs/namespace.c:2512 [inline]
  do_mount+0xea4/0x2bb0 fs/namespace.c:2842
  SYSC_mount fs/namespace.c:3058 [inline]
  SyS_mount+0xab/0x120 fs/namespace.c:3035
  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x442e79
RSP: 002b:00007ffed0bc59e8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffed0bc62a0 RCX: 0000000000442e79
RDX: 00000000004a4d6d RSI: 0000000020001740 RDI: 0000000020001780
RBP: 0000000000000000 R08: 00007ffed0bc62a0 R09: ffffffffffffffff
R10: 0000000000000000 R11: 0000000000000206 R12: ffffffffffffffff
R13: 0000000000000008 R14: 0000000000001380 R15: 00007ffed0bc5b38
Dumping ftrace buffer:
    (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 86400 seconds..


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
