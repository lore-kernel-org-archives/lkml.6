Return-Path: <39ZXAWgkbAP4y45qgrrkxgvvoj.muumrk0ykxiutzktz.ius@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522570742; cv=none;
        d=google.com; s=arc-20160816;
        b=yhalhlKCybSMMFYvLX8CtJbi1hTFpikSBRvQCw2zPSnDUCuqHkW6LO/WRONKtc9fDC
         GXnTRFfL9R7fJ6msjwH2Ghe84AXW2B/Mq47Z/JrHHuaymqKNLoUSUH4HK7fY3HaKaPao
         T6BmgnCCHR9VwQ+dfw8puWBVQzKEjbVtJpbbht8PGd//oBqglvbIOPPDZi867zrMMtHU
         kEjLWcTVj5KhCCbYA+Iq1EUMMxIM68AQeRO8rqvu2ai4oR1FkWpxyuj5AU5wXbC4Dq/v
         lIxsl6KWZs+BFqemX2E5DLaYb08HlWykpYUGH45w6zWNBneAWF11eCxeuVcwqfYw7TCs
         Bxtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:from:subject:message-id:date:mime-version
         :arc-authentication-results;
        bh=GOvJvtN02gTd0i7FIAyLxEEeHPka4+mZrnjHpC07MnY=;
        b=IDroFKVui12OVdyvdlWyvFR/dduHNn7yVu9U7lerj7/hOWvJPPBQatmer+lb1nulEF
         erNgG91YocVS5a0gbLIJ1X1A/ln1X+dMQtuKi0m3xy9L5PxkFyViDouSCqcwP4BOsjV2
         oixXteQLee5h8+eTPONPF6EUTwm12XN1Q1Qx4/sOTQDTYMC5eFmZ+VSKyS9u7Viz2EWo
         mER3xWYddPAFw+4eSgoal3pKbXhN8JKnW2HpHM8hVm2mibbhD/N1aUfvW3zOZRDGoEQb
         pUSPbVj9291BIsxYfwLMnxBZCzqM3ezN8BEepCxLr9GiUqw3OBoq8L3Gc4zejNjbKAD8
         CRLA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of 39zxawgkbap4y45qgrrkxgvvoj.muumrk0ykxiutzktz.ius@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com designates 209.85.220.69 as permitted sender) smtp.mailfrom=39ZXAWgkbAP4y45qgrrkxgvvoj.muumrk0ykxiutzktz.ius@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=appspotmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of 39zxawgkbap4y45qgrrkxgvvoj.muumrk0ykxiutzktz.ius@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com designates 209.85.220.69 as permitted sender) smtp.mailfrom=39ZXAWgkbAP4y45qgrrkxgvvoj.muumrk0ykxiutzktz.ius@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=appspotmail.com
X-Google-Smtp-Source: AIpwx4+7v7S/Ncjg5tPoHQgsCuWe2A0Ez9DdXpn09eUmoY2F+gkpKa1DueGs463w2ATASB3wZd25GT59xiV3ELBqlzCbncW9TotV
MIME-Version: 1.0
Date: Sun, 01 Apr 2018 01:19:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003471d40568c520bc@google.com>
Subject: kernel BUG at drivers/tty/tty_ldisc.c:LINE!
From: syzbot <syzbot+40b7287c2dc987c48c81@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jslaby@suse.com, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596531138218511116?=
X-GMAIL-MSGID: =?utf-8?q?1596531138218511116?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello,

syzbot hit the following crash on upstream commit
c2a9838452a4d71f76103c18c926468a9ea05713 (Fri Mar 30 05:27:12 2018 +0000)
Merge tag 'for-4.16/dm-fixes-4' of  
git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=40b7287c2dc987c48c81

So far this crash happened 2 times on upstream.
Unfortunately, I don't have any reproducer for this crash yet.
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=4558686131322880
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=-8440362230543204781
compiler: gcc (GCC) 7.1.1 20170620

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+40b7287c2dc987c48c81@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

RDX: 0000000000000000 RSI: 0000000000005441 RDI: 0000000000000014
RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000016
R13: 0000000000000307 R14: 00000000006f6948 R15: 0000000000000002
------------[ cut here ]------------
kernel BUG at drivers/tty/tty_ldisc.c:684!
invalid opcode: 0000 [#1] SMP KASAN
Dumping ftrace buffer:
    (ftrace buffer empty)
Modules linked in:
CPU: 0 PID: 15418 Comm: syz-executor4 Not tainted 4.16.0-rc7+ #6
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:tty_ldisc_reinit+0x236/0x2b0 drivers/tty/tty_ldisc.c:684
RSP: 0018:ffff8801d8cdf660 EFLAGS: 00010246
RAX: 0000000000010000 RBX: ffff8801acc871c0 RCX: ffffffff82f49786
RDX: 0000000000010000 RSI: ffffc90001bc1000 RDI: 0000000000000282
RBP: ffff8801d8cdf688 R08: 1ffff1003b19be8c R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: fffffffffffffff4
R13: ffff8801acc87620 R14: 0000000000000000 R15: ffff8801b4a63390
FS:  00007f0cd4482700(0000) GS:ffff8801db200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b9bc22000 CR3: 00000001cb19e004 CR4: 00000000001606f0
DR0: 0000000020000000 DR1: 0000000020000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Call Trace:
  tty_reopen+0x1a3/0x220 drivers/tty/tty_io.c:1272
  tty_open_by_driver drivers/tty/tty_io.c:1953 [inline]
  tty_open+0x877/0xaa0 drivers/tty/tty_io.c:2007
  chrdev_open+0x257/0x730 fs/char_dev.c:417
  do_dentry_open+0x667/0xd40 fs/open.c:752
  vfs_open+0x107/0x220 fs/open.c:866
  dentry_open+0x9a/0x1f0 fs/open.c:883
  ptm_open_peer+0x20b/0x2f0 drivers/tty/pty.c:639
  tty_ioctl+0x517/0x1610 drivers/tty/tty_io.c:2639
  vfs_ioctl fs/ioctl.c:46 [inline]
  do_vfs_ioctl+0x1b1/0x1520 fs/ioctl.c:686
  SYSC_ioctl fs/ioctl.c:701 [inline]
  SyS_ioctl+0x8f/0xc0 fs/ioctl.c:692
  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x4548b9
RSP: 002b:00007f0cd4481c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f0cd44826d4 RCX: 00000000004548b9
RDX: 0000000000000000 RSI: 0000000000005441 RDI: 0000000000000014
RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000016
R13: 0000000000000307 R14: 00000000006f6948 R15: 0000000000000002
Code: 02 00 0f 85 84 00 00 00 48 c7 83 b0 00 00 00 00 00 00 00 e9 0c fe ff  
ff e8 a8 31 7d fe 45 85 f6 0f 85 f9 fd ff ff e8 9a 31 7d fe <0f> 0b 4c 89  
ef e8 40 78 b5 fe e9 43 fe ff ff 4c 89 ef e8 33 78
RIP: tty_ldisc_reinit+0x236/0x2b0 drivers/tty/tty_ldisc.c:684 RSP:  
ffff8801d8cdf660
---[ end trace 1dab10d0b8df769a ]---


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
