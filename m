Return-Path: <31izvWgkbAMk7DEzp00t6p44xs.v33v0t97t6r328t28.r31@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525624022; cv=none;
        d=google.com; s=arc-20160816;
        b=YupSsQ/Jw83FEn8X636As0piOAv3iY1yI74d7FWbcL4FjJzP5CfTWBT0HQw1CZqqgy
         5Q8mV5i4Dz3UsMgLxXDgHvgF1kMZ1ixB4Ardi7YQaybbihYzsx8y+6RdMeTuPwwdwaLk
         j/C5H1oJpurjfZ7gzWcRNJrKKOPDn0f0wh5yS/qeGuICEO94ZacGwYC9u5RuBFbkOvJZ
         i8dotxswq5GCdfq+RH/4k4CmMHUS944xuW7d8rRpe1y+6QxiH2T/3IISiUJen0mRtebO
         3n7dYPu94dZpUwZWUoGX4VDXLAJSRE80VAa3ALhASvBAeXoUBzXqtL22PNHmjuOmjTLO
         rnBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:from:subject:message-id:date:mime-version
         :arc-authentication-results;
        bh=XVzTA3EPtLff8Dp2e9oRqS1gOOCaHVVGC/8fUYNgcG0=;
        b=Uq5y4e/5GUWlppJQFF+vlILUG12eN1pIrNJ1eS685B8ITJK1Ch1jyISAb4y1qj3sWU
         O7Eiyn+QfEmrwz7DcXkeLgtpazgioCFu8hCkASY1Fuf/SQfgqxkGM/vaYtpKvHvjsGV1
         h9hhlDFEStDCI0ts1cqdb1IM5YU4SE5CFhu6Tw7Ksd5KCQHU37SRqGHSmoc1xwi+1b20
         aWV5hyIomsnlNnjxyZAYdkNU9q5d1b0lGS4K8LpQA9iAVN91Q5un5l2nYM+dkxqo2yax
         jYm8fNE/v6RoAtKw7zxwPZRZz1OQByOz6VgLJ0xl8bA/R80vzKW3sqYtv+pxPk1C4BhJ
         tIhQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of 31izvwgkbamk7dezp00t6p44xs.v33v0t97t6r328t28.r31@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com designates 209.85.220.69 as permitted sender) smtp.mailfrom=31izvWgkbAMk7DEzp00t6p44xs.v33v0t97t6r328t28.r31@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=appspotmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of 31izvwgkbamk7dezp00t6p44xs.v33v0t97t6r328t28.r31@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com designates 209.85.220.69 as permitted sender) smtp.mailfrom=31izvWgkbAMk7DEzp00t6p44xs.v33v0t97t6r328t28.r31@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=appspotmail.com
X-Google-Smtp-Source: AB8JxZokU48YllxX0DNE+9pNWYQbIt0urX32IER3gcCyYS31Vztk2qKd5fXrrgmti30fZegCMbnc86VSAA/L7gukMWvP/ubz62LU
MIME-Version: 1.0
Date: Sun, 06 May 2018 09:27:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ea358d056b8c0547@google.com>
Subject: BUG: soft lockup in commit_echoes
From: syzbot <syzbot+995c889cef82be5ccddf@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jslaby@suse.com, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599732735084730836?=
X-GMAIL-MSGID: =?utf-8?q?1599732735084730836?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello,

syzbot found the following crash on:

HEAD commit:    c1c07416cdd4 Merge tag 'kbuild-fixes-v4.17' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=138afde7800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a1dc06635c10d27
dashboard link: https://syzkaller.appspot.com/bug?extid=995c889cef82be5ccddf
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=1355fc37800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1033f657800000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+995c889cef82be5ccddf@syzkaller.appspotmail.com

watchdog: BUG: soft lockup - CPU#0 stuck for 135s! [kworker/u4:3:4495]
Modules linked in:
irq event stamp: 916736
hardirqs last  enabled at (916735): [<ffffffff878009d5>]  
restore_regs_and_return_to_kernel+0x0/0x2b
hardirqs last disabled at (916736): [<ffffffff87800905>]  
interrupt_entry+0xb5/0xf0 arch/x86/entry/entry_64.S:625
softirqs last  enabled at (746274): [<ffffffff87a00778>]  
__do_softirq+0x778/0xaf5 kernel/softirq.c:311
softirqs last disabled at (746209): [<ffffffff81475281>] invoke_softirq  
kernel/softirq.c:365 [inline]
softirqs last disabled at (746209): [<ffffffff81475281>]  
irq_exit+0x1d1/0x200 kernel/softirq.c:405
CPU: 0 PID: 4495 Comm: kworker/u4:3 Not tainted 4.17.0-rc3+ #34
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events_unbound flush_to_ldisc
RIP: 0010:echo_buf drivers/tty/n_tty.c:144 [inline]
RIP: 0010:__process_echoes+0x1fd/0x8d0 drivers/tty/n_tty.c:733
RSP: 0018:ffff8801adbc7268 EFLAGS: 00000293 ORIG_RAX: ffffffffffffff13
RAX: ffff8801ad126280 RBX: 00000001fda8cfee RCX: ffffffff8397b54c
RDX: 0000000000000000 RSI: ffffffff8397b46d RDI: 0000000000000001
RBP: ffff8801adbc72d0 R08: ffff8801ad126280 R09: 0000000000000006
R10: ffff8801ad126280 R11: 0000000000000000 R12: ffffc90001eec000
R13: 0000000000001a02 R14: 00000001fda8cfef R15: 00000000000000ff
FS:  0000000000000000(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000021000000 CR3: 00000001ada40000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  commit_echoes+0x163/0x1d0 drivers/tty/n_tty.c:764
  n_tty_receive_char_fast drivers/tty/n_tty.c:1416 [inline]
  n_tty_receive_buf_fast drivers/tty/n_tty.c:1576 [inline]
  __receive_buf drivers/tty/n_tty.c:1611 [inline]
  n_tty_receive_buf_common+0x2048/0x2c50 drivers/tty/n_tty.c:1709
  n_tty_receive_buf2+0x33/0x40 drivers/tty/n_tty.c:1744
  tty_ldisc_receive_buf+0xb0/0x190 drivers/tty/tty_buffer.c:456
  tty_port_default_receive_buf+0x110/0x170 drivers/tty/tty_port.c:38
  receive_buf drivers/tty/tty_buffer.c:475 [inline]
  flush_to_ldisc+0x3e9/0x560 drivers/tty/tty_buffer.c:524
  process_one_work+0xc1e/0x1b50 kernel/workqueue.c:2145
  worker_thread+0x1cc/0x1440 kernel/workqueue.c:2279
  kthread+0x345/0x410 kernel/kthread.c:238
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
Code: 48 83 c3 01 48 b9 00 00 00 00 00 fc ff df 48 c1 e8 03 80 3c 08 00 0f  
85 17 06 00 00 4d 8b 6c 24 20 e9 db fe ff ff e8 73 7b e1 fd <41> 81 e6 ff  
0f 00 00 48 b9 00 00 00 00 00 fc ff df 4b 8d bc 34


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

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
