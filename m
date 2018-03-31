Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753293AbeCaUsP (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 16:48:15 -0400
Received: from mail-it0-f70.google.com ([209.85.214.70]:59445 "EHLO
        mail-it0-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752256AbeCaUrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 16:47:07 -0400
X-Google-Smtp-Source: AIpwx4+9Nnp41JqtLPZkqpDfbj0tKpdGllGbkLnIItFciAP1H95jLN+Eh1czbGpkOdQhjBFW2kuPxIu7BqBfG2ODXbvgKtJOhFes
MIME-Version: 1.0
Date: Sat, 31 Mar 2018 13:47:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <001a1148578cc1cc160568bb755b@google.com>
Subject: WARNING in format_decode
From: syzbot <syzbot+6bd77b88c1977c03f584@syzkaller.appspotmail.com>
To: dhowells@redhat.com, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot hit the following crash on upstream commit
10b84daddbec72c6b440216a69de9a9605127f7a (Sat Mar 31 17:59:00 2018 +0000)
Merge branch 'perf-urgent-for-linus' of  
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=6bd77b88c1977c03f584

C reproducer: https://syzkaller.appspot.com/x/repro.c?id=4749946259505152
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=5685328530636800
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=5145264444669952
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=-2760467897697295172
compiler: gcc (GCC) 7.1.1 20170620

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+6bd77b88c1977c03f584@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

REISERFS (device loop0): found reiserfs format "3.5" with non-standard  
journal
REISERFS (device loop0): using ordered data mode
reiserfs: using flush barriers
------------[ cut here ]------------
Please remove unsupported %/ in format string
WARNING: CPU: 1 PID: 4480 at lib/vsprintf.c:2138 format_decode+0x77f/0x830  
lib/vsprintf.c:2138
Kernel panic - not syncing: panic_on_warn set ...

CPU: 1 PID: 4480 Comm: syzkaller116131 Not tainted 4.16.0-rc7+ #9
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:17 [inline]
  dump_stack+0x194/0x24d lib/dump_stack.c:53
  panic+0x1e4/0x41c kernel/panic.c:183
  __warn+0x1dc/0x200 kernel/panic.c:547
  report_bug+0x1f4/0x2b0 lib/bug.c:186
  fixup_bug.part.10+0x37/0x80 arch/x86/kernel/traps.c:178
  fixup_bug arch/x86/kernel/traps.c:247 [inline]
  do_error_trap+0x2d7/0x3e0 arch/x86/kernel/traps.c:296
  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:315
  invalid_op+0x1b/0x40 arch/x86/entry/entry_64.S:986
RIP: 0010:format_decode+0x77f/0x830 lib/vsprintf.c:2138
RSP: 0018:ffff8801acc7ef70 EFLAGS: 00010282
RAX: dffffc0000000008 RBX: ffffffff89e18dc1 RCX: ffffffff815b193e
RDX: 0000000000000000 RSI: 1ffff1003598fd9e RDI: 1ffff1003598fd73
RBP: ffff8801acc7efb0 R08: 1ffff1003598fd35 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff8801acc7f028
R13: 000000000000002f R14: ffffffff89e18dc0 R15: 0000000000000000
  vsnprintf+0x15f/0x1900 lib/vsprintf.c:2234
  vsprintf+0x2a/0x40 lib/vsprintf.c:2462
  prepare_error_buf+0x1ce/0x1870 fs/reiserfs/prints.c:240
  __reiserfs_warning+0xc8/0x1a0 fs/reiserfs/prints.c:267
  journal_init_dev fs/reiserfs/journal.c:2646 [inline]
  journal_init+0x2c9e/0x62f0 fs/reiserfs/journal.c:2772
  reiserfs_fill_super+0xf9f/0x33a0 fs/reiserfs/super.c:2034
  mount_bdev+0x2b7/0x370 fs/super.c:1119
  get_super_block+0x34/0x40 fs/reiserfs/super.c:2605
  mount_fs+0x66/0x2d0 fs/super.c:1222
  vfs_kern_mount.part.26+0xc6/0x4a0 fs/namespace.c:1037
  vfs_kern_mount fs/namespace.c:2509 [inline]
  do_new_mount fs/namespace.c:2512 [inline]
  do_mount+0xea4/0x2bb0 fs/namespace.c:2842
  SYSC_mount fs/namespace.c:3058 [inline]
  SyS_mount+0xab/0x120 fs/namespace.c:3035
  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x442dea
RSP: 002b:00007fff69379cf8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000442dea
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007fff69379d00
RBP: 0000000000000004 R08: 0000000020000500 R09: 000000000000000a
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000401c50
R13: 0000000000401ce0 R14: 0000000000000000 R15: 0000000000000000
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
