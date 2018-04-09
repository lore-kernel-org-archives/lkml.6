Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752246AbeDIF6D (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 01:58:03 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:44008 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751464AbeDIF6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 01:58:02 -0400
X-Google-Smtp-Source: AIpwx48DEaqAGP1pVezV3Ev6Ldr1s496ToF1zNpOkjLmFObotN0GZzdfJpjXYRiOjA40ShkTx8vdxk5RSp180Bc4Kc8+pgvHVE+m
MIME-Version: 1.0
Date: Sun, 08 Apr 2018 22:58:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000abcd98056964164c@google.com>
Subject: BUG: soft lockup in snd_virmidi_output_trigger
From: syzbot <syzbot+619d9f40141d826b097e@syzkaller.appspotmail.com>
To: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        perex@perex.cz, syzkaller-bugs@googlegroups.com, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot hit the following crash on upstream commit
3fd14cdcc05a682b03743683ce3a726898b20555 (Fri Apr 6 19:15:41 2018 +0000)
Merge tag 'mtd/for-4.17' of git://git.infradead.org/linux-mtd
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=619d9f40141d826b097e

Unfortunately, I don't have any reproducer for this crash yet.
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=4594231414882304
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=-5813481738265533882
compiler: gcc (GCC) 8.0.1 20180301 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+619d9f40141d826b097e@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

8021q: adding VLAN 0 to HW filter on device team0
IPv6: ADDRCONF(NETDEV_UP): team0: link is not ready
8021q: adding VLAN 0 to HW filter on device team0
IPv6: ADDRCONF(NETDEV_UP): team0: link is not ready
8021q: adding VLAN 0 to HW filter on device team0
watchdog: BUG: soft lockup - CPU#1 stuck for 134s! [syz-executor2:10431]
Modules linked in:
irq event stamp: 35856
hardirqs last  enabled at (35855): [<ffffffff874a1734>]  
__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160 [inline]
hardirqs last  enabled at (35855): [<ffffffff874a1734>]  
_raw_spin_unlock_irqrestore+0x74/0xc0 kernel/locking/spinlock.c:184
hardirqs last disabled at (35856): [<ffffffff87600901>]  
interrupt_entry+0xb1/0xf0 arch/x86/entry/entry_64.S:624
softirqs last  enabled at (162): [<ffffffff87800778>]  
__do_softirq+0x778/0xaf5 kernel/softirq.c:311
softirqs last disabled at (95): [<ffffffff81467a61>] invoke_softirq  
kernel/softirq.c:365 [inline]
softirqs last disabled at (95): [<ffffffff81467a61>] irq_exit+0x1d1/0x200  
kernel/softirq.c:405
CPU: 1 PID: 10431 Comm: syz-executor2 Not tainted 4.16.0+ #4
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:783  
[inline]
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160  
[inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0xa1/0xc0  
kernel/locking/spinlock.c:184
RSP: 0018:ffff880184db7780 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff13
RAX: dffffc0000000000 RBX: 0000000000000282 RCX: 0000000000000000
RDX: 1ffffffff1162e55 RSI: 0000000000000001 RDI: 0000000000000282
RBP: ffff880184db7790 R08: ffffed0035d21962 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8801ae90cb08
R13: ffff880184db7810 R14: 0000000000000001 R15: ffff8801cb9a5880
FS:  00007fc943ad8700(0000) GS:ffff8801db100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc943ad7db8 CR3: 00000001b070d000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  spin_unlock_irqrestore include/linux/spinlock.h:365 [inline]
  snd_virmidi_output_trigger+0x522/0x6c0 sound/core/seq/seq_virmidi.c:205
  snd_rawmidi_output_trigger sound/core/rawmidi.c:150 [inline]
  snd_rawmidi_kernel_write1+0x519/0x700 sound/core/rawmidi.c:1288
  snd_rawmidi_write+0x2e2/0xdc0 sound/core/rawmidi.c:1338
  __vfs_write+0x10b/0x880 fs/read_write.c:485
  vfs_write+0x1f8/0x560 fs/read_write.c:549
  ksys_write+0xf9/0x250 fs/read_write.c:598
  SYSC_write fs/read_write.c:610 [inline]
  SyS_write+0x24/0x30 fs/read_write.c:607
  do_syscall_64+0x29e/0x9d0 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x455259
RSP: 002b:00007fc943ad7c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fc943ad86d4 RCX: 0000000000455259
RDX: 00000000e78e624c RSI: 0000000020000040 RDI: 0000000000000014
RBP: 000000000072c010 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000000006ca R14: 00000000006fd390 R15: 0000000000000002
Code: c7 a8 72 b1 88 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80  
3c 02 00 75 21 48 83 3d 4e 5b 67 01 00 74 0e 48 89 df 57 9d <0f> 1f 44 00  
00 eb bb 0f 0b 0f 0b e8 6f 29 68 fa eb 97 e8 68 29


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
