Return-Path: <3wR3HWgkbAPQouvgWhhanWlleZ.ckkchaqoanYkjpajp.Yki@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522998721; cv=none;
        d=google.com; s=arc-20160816;
        b=RN2Jbm2vQikS3XGDxf3BFn4BDudAcdBF7S3HdEClw+9Uy0hY9oAIDS8RTcp25aQwJJ
         00nXwTx54FoOpD80bTtTMesRn7FJr5QZE8ySeH7JEXXNncxSIXJWn2RuyGJtFHen0/FF
         cRzQ2K73in41dwrJoHl5+QQtAsvapmXcnFQe78Ewwp4hP8m3DjyMjsTsx3RYRbD1gKL2
         whp1yMWHqJUrN3Sxci6Te7B+WpQKo6u8Zltqdehf5yfpUNfXg0X9C4hGmWGCGUvX6BpK
         QtDFGDHb2nsx55heSMlJzmh0aXt/HdrZJSp2Wq1FD/rxmsA6sHOjOteipTvNgHZRE0qF
         3ndQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:from:subject:message-id:date:mime-version
         :arc-authentication-results;
        bh=IRGNuqlP8zEO8QrYmHUnYjiraS8k91c8u0mt2k48NIQ=;
        b=rQEl5oLIp/rmGi8vu7D/Lh/jTP7U5x6cL5Afws2vwxIVrk3TqlHgQ9rolUTAnLokNa
         xz4Xuosiu1zCs6ae7p88cs8/IX+5OFxPg4qy/fpS99fNWr9AAG18oqeOEL1U+UbggAIw
         lknSqi/y7B0bLNY3VkgBYel1C/KsuW24rEb4Dn17J2b7V9RxOh3NT+SGlVvDxwxeOso9
         jlvCHmaGLUZqcrc4QRstvCN1xIZ7a1FWVhGBkubzk2xv5PK1cJIGZP+QF5lFSHMfTCEi
         oC/dhqH6OTfmq2BxIh4VQNiTXyaTmi2lIzITY3JLy+wnpQ2xTxnQIH9FqAEclr1kAICq
         ohww==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of 3wr3hwgkbapqouvgwhhanwllez.ckkchaqoanykjpajp.yki@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com designates 209.85.220.69 as permitted sender) smtp.mailfrom=3wR3HWgkbAPQouvgWhhanWlleZ.ckkchaqoanYkjpajp.Yki@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=appspotmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of 3wr3hwgkbapqouvgwhhanwllez.ckkchaqoanykjpajp.yki@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com designates 209.85.220.69 as permitted sender) smtp.mailfrom=3wR3HWgkbAPQouvgWhhanWlleZ.ckkchaqoanYkjpajp.Yki@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=appspotmail.com
X-Google-Smtp-Source: AIpwx49aH2Kjbz5JccQqO/D3FyOk3V5FvBxR8SxMGSTSlYixNQ5n+gmy6dJIZijAUVo4jXFhBorpls1zxBiTt9pEx/+ft2W+9L88
MIME-Version: 1.0
Date: Fri, 06 Apr 2018 00:12:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <883d24f7d4ccc52e19056928c5be@google.com>
Subject: INFO: rcu detected stall in n_tty_receive_char_special
From: syzbot <syzbot+18df353d7540aa6b5467@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jslaby@suse.com, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596979907220664835?=
X-GMAIL-MSGID: =?utf-8?q?1596979907220664835?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello,

syzbot hit the following crash on upstream commit
3c8ba0d61d04ced9f8d9ff93977995a9e4e96e91 (Sat Mar 31 01:52:36 2018 +0000)
kernel.h: Retain constant expression output for max()/min()
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=18df353d7540aa6b5467

Unfortunately, I don't have any reproducer for this crash yet.
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=5836679554269184
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=-1647968177339044852
compiler: gcc (GCC) 8.0.1 20180301 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+18df353d7540aa6b5467@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

INFO: rcu_sched detected stalls on CPUs/tasks:
	(detected by 1, t=125007 jiffies, g=42488, c=42487, q=11)
All QSes seen, last rcu_sched kthread activity 125014  
(4295022441-4294897427), jiffies_till_next_fqs=3, root ->qsmask 0x0
kworker/u4:5    R  running task    15272  8806      2 0x80000008
Workqueue: events_unbound flush_to_ldisc
Call Trace:
  <IRQ>
  sched_show_task.cold.87+0x27a/0x301 kernel/sched/core.c:5325
  print_other_cpu_stall.cold.79+0x92f/0x9d2 kernel/rcu/tree.c:1481
  check_cpu_stall.isra.61+0x706/0xf50 kernel/rcu/tree.c:1599
  __rcu_pending kernel/rcu/tree.c:3356 [inline]
  rcu_pending kernel/rcu/tree.c:3401 [inline]
  rcu_check_callbacks+0x21b/0xad0 kernel/rcu/tree.c:2763
  update_process_times+0x2d/0x70 kernel/time/timer.c:1636
  tick_sched_handle+0xa0/0x180 kernel/time/tick-sched.c:171
  tick_sched_timer+0x42/0x130 kernel/time/tick-sched.c:1179
  __run_hrtimer kernel/time/hrtimer.c:1337 [inline]
  __hrtimer_run_queues+0x3e3/0x10a0 kernel/time/hrtimer.c:1399
  hrtimer_interrupt+0x286/0x650 kernel/time/hrtimer.c:1457
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1025 [inline]
  smp_apic_timer_interrupt+0x15d/0x710 arch/x86/kernel/apic/apic.c:1050
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:862
  </IRQ>
RIP: 0010:echo_char+0xae/0x2e0 drivers/tty/n_tty.c:915
RSP: 0018:ffff8801d33e71e0 EFLAGS: 00000a07 ORIG_RAX: ffffffffffffff13
RAX: dffffc0000000000 RBX: ffffc90013158000 RCX: ffffffff8375b1b7
RDX: 1ffff1003ad87636 RSI: ffffffff8375b1c6 RDI: ffff8801d6c3b1b4
RBP: ffff8801d33e7210 R08: ffff8801cf482540 R09: fffff5200262b460
R10: fffff5200262b460 R11: ffffc9001315a307 R12: 00000000000000cb
R13: ffff8801d6c3ae00 R14: 00000000c240f0bb R15: 00000000000000bb
  n_tty_receive_char_special+0x13b3/0x31c0 drivers/tty/n_tty.c:1306
  n_tty_receive_buf_fast drivers/tty/n_tty.c:1577 [inline]
  __receive_buf drivers/tty/n_tty.c:1611 [inline]
  n_tty_receive_buf_common+0x20ca/0x2c50 drivers/tty/n_tty.c:1709
  n_tty_receive_buf2+0x33/0x40 drivers/tty/n_tty.c:1744
  tty_ldisc_receive_buf+0xb0/0x190 drivers/tty/tty_buffer.c:456
  tty_port_default_receive_buf+0x110/0x170 drivers/tty/tty_port.c:38
  receive_buf drivers/tty/tty_buffer.c:475 [inline]
  flush_to_ldisc+0x3e9/0x560 drivers/tty/tty_buffer.c:524
  process_one_work+0xc1e/0x1b50 kernel/workqueue.c:2145
  worker_thread+0x1cc/0x1440 kernel/workqueue.c:2279
  kthread+0x345/0x410 kernel/kthread.c:238
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:411
rcu_sched kthread starved for 125626 jiffies! g42488 c42487 f0x2  
RCU_GP_WAIT_FQS(3) ->state=0x0 ->cpu=0
RCU grace-period kthread stack dump:
rcu_sched       R  running task    23592     9      2 0x80000000
Call Trace:
  context_switch kernel/sched/core.c:2848 [inline]
  __schedule+0x807/0x1e40 kernel/sched/core.c:3490
  schedule+0xef/0x430 kernel/sched/core.c:3549
  schedule_timeout+0x138/0x240 kernel/time/timer.c:1801
  rcu_gp_kthread+0x6b5/0x1940 kernel/rcu/tree.c:2231
  kthread+0x345/0x410 kernel/kthread.c:238
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:411


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
