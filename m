Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751417AbeDFACE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 20:02:04 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:41000 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751179AbeDFACC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 20:02:02 -0400
X-Google-Smtp-Source: AIpwx48QjswaffNIP08nWRQYaNNf988FCagu+erJHBX9tdQc4etYwBVzj6XDAF+48qw5zwyQSretxYdxth6p7RMyOK2cY+K4XfGE
MIME-Version: 1.0
Date: Thu, 05 Apr 2018 17:02:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <001a113fe6c005d8ac056922c4c3@google.com>
Subject: WARNING in snd_pcm_hw_params
From: syzbot <syzbot+803e0047ac3a3096bb4f@syzkaller.appspotmail.com>
To: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        o-takashi@sakamocchi.jp, perex@perex.cz,
        syzkaller-bugs@googlegroups.com, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot hit the following crash on upstream commit
3c8ba0d61d04ced9f8d9ff93977995a9e4e96e91 (Sat Mar 31 01:52:36 2018 +0000)
kernel.h: Retain constant expression output for max()/min()
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=803e0047ac3a3096bb4f

So far this crash happened 6 times on upstream.
C reproducer: https://syzkaller.appspot.com/x/repro.c?id=5886672973594624
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=4913841943085056
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=6314122077536256
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=-1647968177339044852
compiler: gcc (GCC) 8.0.1 20180301 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+803e0047ac3a3096bb4f@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000441939
RDX: 0000000000000001 RSI: 0000000020000180 RDI: 0000000000000003
RBP: 00007ffe8c3569b0 R08: 0000000000000002 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000005
R13: ffffffffffffffff R14: 0000000000000000 R15: 0000000000000000
WARNING: CPU: 0 PID: 4468 at sound/core/pcm_native.c:620  
snd_pcm_hw_params_choose sound/core/pcm_native.c:620 [inline]
WARNING: CPU: 0 PID: 4468 at sound/core/pcm_native.c:620  
snd_pcm_hw_params+0x65a/0x1e20 sound/core/pcm_native.c:672
Kernel panic - not syncing: panic_on_warn set ...

CPU: 0 PID: 4468 Comm: syzkaller371267 Not tainted 4.16.0+ #2
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:17 [inline]
  dump_stack+0x1b9/0x29f lib/dump_stack.c:53
  panic+0x22f/0x4de kernel/panic.c:183
  __warn.cold.8+0x163/0x1a3 kernel/panic.c:547
  report_bug+0x252/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x1bc/0x470 arch/x86/kernel/traps.c:296
  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:315
  invalid_op+0x1b/0x40 arch/x86/entry/entry_64.S:991
RIP: 0010:snd_pcm_hw_params_choose sound/core/pcm_native.c:620 [inline]
RIP: 0010:snd_pcm_hw_params+0x65a/0x1e20 sound/core/pcm_native.c:672
RSP: 0018:ffff8801ac66f498 EFLAGS: 00010293
RAX: ffff8801acb86580 RBX: 00000000fffffff4 RCX: ffffffff859d7220
RDX: 0000000000000000 RSI: ffffffff859d752a RDI: 0000000000000005
RBP: ffff8801ac66f6e8 R08: ffff8801acb86580 R09: ffffed003b6046c2
R10: ffffed003b6046c2 R11: ffff8801db023613 R12: ffffffff8826309c
R13: ffff8801ceab6940 R14: ffff8801d9509200 R15: dffffc0000000000
  snd_pcm_kernel_ioctl+0x6c/0x240 sound/core/pcm_native.c:2999
  snd_pcm_oss_change_params_locked+0x1be8/0x3ce0 sound/core/oss/pcm_oss.c:993
  snd_pcm_oss_make_ready_locked+0xbc/0x130 sound/core/oss/pcm_oss.c:1182
  snd_pcm_oss_write1 sound/core/oss/pcm_oss.c:1396 [inline]
  snd_pcm_oss_write+0x516/0xa20 sound/core/oss/pcm_oss.c:2774
  __vfs_write+0x10b/0x880 fs/read_write.c:485
  vfs_write+0x1f8/0x560 fs/read_write.c:549
  ksys_write+0xf9/0x250 fs/read_write.c:598
  SYSC_write fs/read_write.c:610 [inline]
  SyS_write+0x24/0x30 fs/read_write.c:607
  do_syscall_64+0x29e/0x9d0 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x441939
RSP: 002b:00007ffe8c3568e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000441939
RDX: 0000000000000001 RSI: 0000000020000180 RDI: 0000000000000003
RBP: 00007ffe8c3569b0 R08: 0000000000000002 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000005
R13: ffffffffffffffff R14: 0000000000000000 R15: 0000000000000000
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
