Return-Path: <3ThDBWgkbAE89FG1r22v8r66zu.x55x2vB9v8t54Av4A.t53@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522602062; cv=none;
        d=google.com; s=arc-20160816;
        b=auAqW7PnydJiorBACCGn2dkzETHRSKIeoRoPEjlI9JijYV0F5iKNNzUHjCo5vRC/O9
         wDJJxte1LzEYTpsl7paUZwE0SVS8nk9KxURMhSZCDzFdX3pjwba8ZO+VZJ5Qt/AV7jzp
         D1cCnVuULSYcs2GffU75qgofWcyS5/QmAlWMhu1vQxtAALLZrctasCciBNZwnrRfa6N9
         pYAhEuQivdk6Yenv2npzLRP0FV+chfwybQdohIwdtOerguxYWH/huRUh4X4g2UUFEmRv
         BsF5iWL09m4F3N4ixECAVU0zrkU29GOeSYMODoFNaexzXMbDfatjdxRHj8yqbrzNT3ML
         Bv4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:from:subject:message-id:date:mime-version
         :arc-authentication-results;
        bh=jLfApwOHGgdRRpPHN7zg+OTw0noLBz2mV/Cgf0Q0RtU=;
        b=YPIG7HV6kXxIgN/Hy1JL9bdRbkKFbXPMI8hIuurxWgnFazl2YIIXKkwOXzamoTjPMK
         uCPMy8fxljaUbmPyw1bHhmIe7OyLgBozbMxFdNAXUJWi6dWcxOwrrZ+Ug48a3VueXf5Q
         f5wMobM+EqDJmEpMe4P4CgHsNajIZkkOZtyl3FZBQlllxhMtubiir7Ke4yEwCMOvTrFw
         FFKUGQ1OOayARj1QOfFKy4l4Xk1RsMZT3qrGcjvKkVlLL2DvHx6/GHqAdkfaQrZqp2Dg
         hqjZNqT4a2ChWLLUeE2sBKbrbT3cLmbiZUBO1ufyCEarJpn5evrUu27N8MTTE2CYLi3r
         mUgg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of 3thdbwgkbae89fg1r22v8r66zu.x55x2vb9v8t54av4a.t53@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com designates 209.85.220.69 as permitted sender) smtp.mailfrom=3ThDBWgkbAE89FG1r22v8r66zu.x55x2vB9v8t54Av4A.t53@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=appspotmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of 3thdbwgkbae89fg1r22v8r66zu.x55x2vb9v8t54av4a.t53@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com designates 209.85.220.69 as permitted sender) smtp.mailfrom=3ThDBWgkbAE89FG1r22v8r66zu.x55x2vB9v8t54Av4A.t53@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=appspotmail.com
X-Google-Smtp-Source: AIpwx49QWQn6AFjNMERB+bQu3phR76L+CJ4uKYlPe6TLHy1ZqdgxUaqbQ3F8Ur3GlGVPVhwS93zkVF/MguGvX39pJjD0bNZOgXkz
MIME-Version: 1.0
Date: Sun, 01 Apr 2018 10:01:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <001a113ed31a122ced0568cc6be1@google.com>
Subject: KASAN: user-memory-access Write in n_tty_set_termios
From: syzbot <syzbot+3aa9784721dfb90e984d@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jslaby@suse.com, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596563981043488445?=
X-GMAIL-MSGID: =?utf-8?q?1596563981043488445?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello,

syzbot hit the following crash on upstream commit
10b84daddbec72c6b440216a69de9a9605127f7a (Sat Mar 31 17:59:00 2018 +0000)
Merge branch 'perf-urgent-for-linus' of  
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=3aa9784721dfb90e984d

So far this crash happened 2 times on upstream.
C reproducer: https://syzkaller.appspot.com/x/repro.c?id=5259401455730688
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=5604984590696448
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=6343571460325376
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=-2760467897697295172
compiler: gcc (GCC) 7.1.1 20170620

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+3aa9784721dfb90e984d@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

==================================================================
BUG: KASAN: user-memory-access in memset include/linux/string.h:330 [inline]
BUG: KASAN: user-memory-access in bitmap_zero include/linux/bitmap.h:208  
[inline]
BUG: KASAN: user-memory-access in n_tty_set_termios+0xfc/0xcf0  
drivers/tty/n_tty.c:1766
Write of size 512 at addr 0000000000001060 by task syzkaller311122/4421

CPU: 0 PID: 4421 Comm: syzkaller311122 Not tainted 4.16.0-rc7+ #9
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:17 [inline]
  dump_stack+0x194/0x24d lib/dump_stack.c:53
  kasan_report_error mm/kasan/report.c:352 [inline]
  kasan_report+0x140/0x360 mm/kasan/report.c:412
  check_memory_region_inline mm/kasan/kasan.c:260 [inline]
  check_memory_region+0x137/0x190 mm/kasan/kasan.c:267
  memset+0x23/0x40 mm/kasan/kasan.c:285
  memset include/linux/string.h:330 [inline]
  bitmap_zero include/linux/bitmap.h:208 [inline]
  n_tty_set_termios+0xfc/0xcf0 drivers/tty/n_tty.c:1766
  tty_set_termios+0x750/0xa60 drivers/tty/tty_ioctl.c:341
  set_termios+0x392/0x6d0 drivers/tty/tty_ioctl.c:414
  tty_mode_ioctl+0x9fc/0xb30 drivers/tty/tty_ioctl.c:749
  n_tty_ioctl_helper+0x40/0x360 drivers/tty/tty_ioctl.c:940
  n_tty_ioctl+0x14d/0x2d0 drivers/tty/n_tty.c:2441
  tty_ioctl+0x336/0x1610 drivers/tty/tty_io.c:2655
  vfs_ioctl fs/ioctl.c:46 [inline]
  do_vfs_ioctl+0x1b1/0x1520 fs/ioctl.c:686
  SYSC_ioctl fs/ioctl.c:701 [inline]
  SyS_ioctl+0x8f/0xc0 fs/ioctl.c:692
  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x445bf9
RSP: 002b:00007fdf68f52d18 EFLAGS: 00000297 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000006dac24 RCX: 0000000000445bf9
RDX: 0000000020000040 RSI: 0000000000005402 RDI: 0000000000000021
RBP: 00000000006dac20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000297 R12: 6d74702f7665642f
R13: 00007ffdda32610f R14: 00007fdf68f539c0 R15: 0000000000000007
==================================================================
Kernel panic - not syncing: panic_on_warn set ...

CPU: 0 PID: 4421 Comm: syzkaller311122 Tainted: G    B             
4.16.0-rc7+ #9
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:17 [inline]
  dump_stack+0x194/0x24d lib/dump_stack.c:53
  panic+0x1e4/0x41c kernel/panic.c:183
  kasan_end_report+0x50/0x50 mm/kasan/report.c:180
  kasan_report_error mm/kasan/report.c:359 [inline]
  kasan_report+0x149/0x360 mm/kasan/report.c:412
  check_memory_region_inline mm/kasan/kasan.c:260 [inline]
  check_memory_region+0x137/0x190 mm/kasan/kasan.c:267
  memset+0x23/0x40 mm/kasan/kasan.c:285
  memset include/linux/string.h:330 [inline]
  bitmap_zero include/linux/bitmap.h:208 [inline]
  n_tty_set_termios+0xfc/0xcf0 drivers/tty/n_tty.c:1766
  tty_set_termios+0x750/0xa60 drivers/tty/tty_ioctl.c:341
  set_termios+0x392/0x6d0 drivers/tty/tty_ioctl.c:414
  tty_mode_ioctl+0x9fc/0xb30 drivers/tty/tty_ioctl.c:749
  n_tty_ioctl_helper+0x40/0x360 drivers/tty/tty_ioctl.c:940
  n_tty_ioctl+0x14d/0x2d0 drivers/tty/n_tty.c:2441
  tty_ioctl+0x336/0x1610 drivers/tty/tty_io.c:2655
  vfs_ioctl fs/ioctl.c:46 [inline]
  do_vfs_ioctl+0x1b1/0x1520 fs/ioctl.c:686
  SYSC_ioctl fs/ioctl.c:701 [inline]
  SyS_ioctl+0x8f/0xc0 fs/ioctl.c:692
  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x445bf9
RSP: 002b:00007fdf68f52d18 EFLAGS: 00000297 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000006dac24 RCX: 0000000000445bf9
RDX: 0000000020000040 RSI: 0000000000005402 RDI: 0000000000000021
RBP: 00000000006dac20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000297 R12: 6d74702f7665642f
R13: 00007ffdda32610f R14: 00007fdf68f539c0 R15: 0000000000000007
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
