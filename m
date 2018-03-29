Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752177AbeC2WBF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 18:01:05 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:36397 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750881AbeC2WBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 18:01:03 -0400
X-Google-Smtp-Source: AG47ELvJHysPQlQIlkiODYiuRKum4ASAMroL6ytowFciNKFB6g27Y3LcOQg60gDpIzzhnebdjiPJfNz8jkuE1BvuqtEKQj3MzVCo
MIME-Version: 1.0
Date: Thu, 29 Mar 2018 15:01:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <001a113ed5546fb3c00568944220@google.com>
Subject: WARNING in refcount_sub_and_test (2)
From: syzbot <syzbot+c7b0dde061c523bc4b0f@syzkaller.appspotmail.com>
To: davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot hit the following crash on bpf-next commit
22527437e0a0c96ee3153e9d0382942b0fd4f9dd (Thu Mar 29 02:36:15 2018 +0000)
Merge branch 'nfp-bpf-updates'
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=c7b0dde061c523bc4b0f

C reproducer: https://syzkaller.appspot.com/x/repro.c?id=5996614741131264
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=5947747274326016
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=6215237837520896
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=-1280663959502969741
compiler: gcc (GCC) 7.1.1 20170620

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c7b0dde061c523bc4b0f@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

R13: 0030656c69662f2e R14: 0000000000000005 R15: 2f30656c69662f2e
------------[ cut here ]------------
------------[ cut here ]------------
refcount_t: increment on 0; use-after-free.
refcount_t: underflow; use-after-free.
WARNING: CPU: 0 PID: 4450 at lib/refcount.c:187  
refcount_sub_and_test+0x167/0x1b0 lib/refcount.c:187
WARNING: CPU: 1 PID: 4460 at lib/refcount.c:153 refcount_inc+0x47/0x50  
lib/refcount.c:153
Kernel panic - not syncing: panic_on_warn set ...

Modules linked in:
CPU: 0 PID: 4450 Comm: syzkaller428798 Not tainted 4.16.0-rc6+ #40
CPU: 1 PID: 4460 Comm: syzkaller428798 Not tainted 4.16.0-rc6+ #40
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
RIP: 0010:refcount_inc+0x47/0x50 lib/refcount.c:153
  __dump_stack lib/dump_stack.c:17 [inline]
  dump_stack+0x194/0x24d lib/dump_stack.c:53
RSP: 0018:ffff8801b534f860 EFLAGS: 00010286
RAX: dffffc0000000008 RBX: ffff8801b1b8c184 RCX: ffffffff815ba4be
  panic+0x1e4/0x41c kernel/panic.c:183
RDX: 0000000000000000 RSI: 1ffff10036a69ebc RDI: 1ffff10036a69e91
RBP: ffff8801b534f868 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8801b534faf8
R13: ffff8801b04db513 R14: ffff8801b1b8c180 R15: ffff8801b04db501
FS:  00000000008e6880(0000) GS:ffff8801db300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  __warn+0x1dc/0x200 kernel/panic.c:547
CR2: 00000000006ea510 CR3: 00000001b106f005 CR4: 00000000001606e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  report_bug+0x1f4/0x2b0 lib/bug.c:186
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  fixup_bug.part.11+0x37/0x80 arch/x86/kernel/traps.c:178
Call Trace:
  fixup_bug arch/x86/kernel/traps.c:247 [inline]
  do_error_trap+0x2d7/0x3e0 arch/x86/kernel/traps.c:296
  get_net include/net/net_namespace.h:204 [inline]
  sk_alloc+0x3f9/0x1440 net/core/sock.c:1540
  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:315
  invalid_op+0x1b/0x40 arch/x86/entry/entry_64.S:986
RIP: 0010:refcount_sub_and_test+0x167/0x1b0 lib/refcount.c:187
RSP: 0018:ffff8801b0e87728 EFLAGS: 00010286
RAX: dffffc0000000008 RBX: 0000000000000000 RCX: ffffffff815ba4be
RDX: 0000000000000000 RSI: 1ffff100361d0e95 RDI: 0000000000000293
RBP: ffff8801b0e877b8 R08: 0000000000000000 R09: 0000000000000000
R10: ffff8801b0e87850 R11: 0000000000000000 R12: 1ffff100361d0ee6
  inet_create+0x47c/0xf50 net/ipv4/af_inet.c:320
R13: 00000000ffffffff R14: 0000000000000001 R15: ffff8801b0816204
  __sock_create+0x4d4/0x850 net/socket.c:1285
  sock_create net/socket.c:1325 [inline]
  SYSC_socket net/socket.c:1355 [inline]
  SyS_socket+0xeb/0x1d0 net/socket.c:1335
  refcount_dec_and_test+0x1a/0x20 lib/refcount.c:212
  put_net include/net/net_namespace.h:222 [inline]
  __sk_destruct+0x560/0x920 net/core/sock.c:1592
  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
  sk_destruct+0x47/0x80 net/core/sock.c:1601
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
  __sk_free+0xf1/0x2b0 net/core/sock.c:1612
RIP: 0033:0x44ac67
  sk_free+0x2a/0x40 net/core/sock.c:1623
RSP: 002b:00007ffcd4f45588 EFLAGS: 00000202
  sock_put include/net/sock.h:1660 [inline]
  tcp_close+0x967/0x1190 net/ipv4/tcp.c:2321
  ORIG_RAX: 0000000000000029
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000044ac67
RDX: 0000000000000006 RSI: 0000000000000001 RDI: 0000000000000002
RBP: 00007ffcd4f456b0 R08: 0000000000000000 R09: 0000000000000001
R10: 0000000000000006 R11: 0000000000000202 R12: 0000000000000002
  inet_release+0xed/0x1c0 net/ipv4/af_inet.c:427
R13: 0000000000000002 R14: 000000000000b38f R15: 00007ffcd4f456d8
  sock_release+0x8d/0x1e0 net/socket.c:594
Code:
be
  sock_close+0x16/0x20 net/socket.c:1149
fe
  __fput+0x327/0x7e0 fs/file_table.c:209
5b
5d
c3
  ____fput+0x15/0x20 fs/file_table.c:243
e8
  task_work_run+0x199/0x270 kernel/task_work.c:113
5a
3c
be
fe
  tracehook_notify_resume include/linux/tracehook.h:191 [inline]
  exit_to_usermode_loop+0x275/0x2f0 arch/x86/entry/common.c:166
80
3d
91
  prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:265 [inline]
  do_syscall_64+0x6ec/0x940 arch/x86/entry/common.c:292
f5
84
05
00 75 ea e8 4c 3c be
fe
48
c7
c7
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
80
RIP: 0033:0x406fe0
78
RSP: 002b:00007ffcd4f45588 EFLAGS: 00000246
e5
  ORIG_RAX: 0000000000000003
86
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000406fe0
c6
RDX: 00000000000000e0 RSI: 00007ffcd4f45e70 RDI: 0000000000000003
05
RBP: 00007ffcd4f456b0 R08: 00007ffcd4f455b0 R09: 0000000000000001
7c
R10: 00007ffcd4f456b0 R11: 0000000000000246 R12: 00000000006de4c0
R13: 00000000006dde40 R14: 0000000000001380 R15: 00007ffcd4f456d8
f5 84 05 01 e8 f9 47 8e fe <0f> 0b eb ce 0f 1f 44 00 00 55 48 89 e5 41 57  
41 56 41 55 41 54
---[ end trace 04af8119701e2164 ]---
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
