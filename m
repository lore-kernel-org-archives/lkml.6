Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753945AbeDKPPI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 11:15:08 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:57352 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753725AbeDKPPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 11:15:04 -0400
X-Google-Smtp-Source: AIpwx4+TaMa/TQAvMWz5samh9erI27NcivHBjgrjntZOQ4FG2f/qX1YkCdspSch+Js3vNEQKwOZs8Vc0Ue0hK+8Tw2LZ4LGeVbXj
MIME-Version: 1.0
Date: Wed, 11 Apr 2018 08:15:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <001a113de2d878ade40569941a21@google.com>
Subject: WARNING: kobject bug in br_add_if
From: syzbot <syzbot+de73361ee4971b6e6f75@syzkaller.appspotmail.com>
To: bridge@lists.linux-foundation.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        stephen@networkplumber.org, syzkaller-bugs@googlegroups.com
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
https://syzkaller.appspot.com/bug?extid=de73361ee4971b6e6f75

So far this crash happened 4 times on net-next, upstream.
Unfortunately, I don't have any reproducer for this crash yet.
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=5007286875455488
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=-2760467897697295172
compiler: gcc (GCC) 7.1.1 20170620

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+de73361ee4971b6e6f75@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

R13: 0000000000000369 R14: 00000000006f7278 R15: 0000000000000006
------------[ cut here ]------------
binder: 23650:23651 unknown command 1078223622
kobject_add_internal failed for brport (error: -12 parent: bond0)
binder: 23650:23651 ioctl c0306201 2000dfd0 returned -22
WARNING: CPU: 1 PID: 23647 at lib/kobject.c:242  
kobject_add_internal+0x3f6/0xbc0 lib/kobject.c:240
Kernel panic - not syncing: panic_on_warn set ...

CPU: 1 PID: 23647 Comm: syz-executor7 Not tainted 4.16.0-rc7+ #374
binder: BINDER_SET_CONTEXT_MGR already set
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
RIP: 0010:kobject_add_internal+0x3f6/0xbc0 lib/kobject.c:240
RSP: 0018:ffff8801d089f560 EFLAGS: 00010286
RAX: dffffc0000000008 RBX: ffff8801adbee178 RCX: ffffffff815b193e
RDX: 0000000000040000 RSI: ffffc900022aa000 RDI: 1ffff1003a113e31
RBP: ffff8801d089f658 R08: 1ffff1003a113df3 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 1ffff1003a113eb2
R13: 00000000fffffff4 R14: ffff8801abd88828 R15: ffff8801d75a1e00
  kobject_add_varg lib/kobject.c:364 [inline]
  kobject_init_and_add+0xf9/0x150 lib/kobject.c:436
  br_add_if+0x79a/0x1a70 net/bridge/br_if.c:533
  add_del_if+0xf4/0x140 net/bridge/br_ioctl.c:101
  br_dev_ioctl+0xa2/0xc0 net/bridge/br_ioctl.c:396
  dev_ifsioc+0x333/0x9b0 net/core/dev_ioctl.c:334
  dev_ioctl+0x176/0xbe0 net/core/dev_ioctl.c:500
  sock_do_ioctl+0x1ba/0x390 net/socket.c:981
  sock_ioctl+0x367/0x670 net/socket.c:1081
  vfs_ioctl fs/ioctl.c:46 [inline]
  do_vfs_ioctl+0x1b1/0x1520 fs/ioctl.c:686
  SYSC_ioctl fs/ioctl.c:701 [inline]
  SyS_ioctl+0x8f/0xc0 fs/ioctl.c:692
  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x454e79
RSP: 002b:00007eff7dab7c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007eff7dab86d4 RCX: 0000000000454e79
RDX: 0000000020000000 RSI: 00000000000089a2 RDI: 0000000000000014
RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000015
R13: 0000000000000369 R14: 00000000006f7278 R15: 0000000000000006
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
To mark this as a duplicate of another syzbot report, please reply with:
#syz dup: exact-subject-of-another-report
If it's a one-off invalid bug report, please reply with:
#syz invalid
Note: if the crash happens again, it will cause creation of a new bug  
report.
Note: all commands must start from beginning of the line in the email body.
