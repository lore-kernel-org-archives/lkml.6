Return-Path: <3nfG8WgkbAFAAGH2s33w9s770v.y66y3wCAw9u65Bw5B.u64@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522332062; cv=none;
        d=google.com; s=arc-20160816;
        b=C+dZqB6+JgcxEjNWRnQjtF85L7HpDwjGxf7mUCdNDFVXezbRWv30ALPegeauWL9c/N
         8U9Tb/UmIBuV0FC6BAtTCSmuigTXbMepv5A3BsXvemtWIB7J7l40qZpeBPeZvJlw9Lsa
         8mjOdruOXdeEKzznscwTL2lT9QdsTP6v/e7zK/NBvW630htvBGl9bpHuIqT7AQWneupF
         nHXK4AboqqqqRRuqFp3vjRhqcMP2jNWWeeXMJaSsuDpVXWP5mhHfvseXCIHPgd9Lg9dP
         WkTS15e69EiJjP7FZwm/U7cnNGEUdA6vH67asD/TMsXhoYUp1vY4+rD0ZN7Gp3vbYNhl
         K0GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:from:subject:message-id:date:mime-version
         :arc-authentication-results;
        bh=8ITM0kha/Z/7JRdsNcKo+YCjt7MCX9+nmiZ4xrEk+Ws=;
        b=ndlkAA0fH+oI0JNjjY+L9DCJYtWuikNqTlW4Mga5WC8zM1NmQ43ryAVihwc97uWW2r
         IsFJWZdV3pcXfJUYWCE4RhJRj6vvkoUiuZ1BO/YhMmW1vtgouS0Br8xEYHnpVNZsTHmt
         87g3y59iYcSC3KkmeMOMpPxyxqIDCd4j8lADJnaSoA1PsaDLtspTge7s2/cnw/Y30px0
         4a6rZL7s3miOk7JZWj9hkgm4/s13UthGHUDhV4i3WVYZwh/GibvV5v7jmqVorw8s8RoR
         BdTWYW9Wcez5fjJGPUIrb2BcOSQQOXgZ+PsdL6khorFrK7l7X/5SrDR7z4r3rQYTwdzI
         lC0A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of 3nfg8wgkbafaagh2s33w9s770v.y66y3wcaw9u65bw5b.u64@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com designates 209.85.220.69 as permitted sender) smtp.mailfrom=3nfG8WgkbAFAAGH2s33w9s770v.y66y3wCAw9u65Bw5B.u64@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=appspotmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of 3nfg8wgkbafaagh2s33w9s770v.y66y3wcaw9u65bw5b.u64@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com designates 209.85.220.69 as permitted sender) smtp.mailfrom=3nfG8WgkbAFAAGH2s33w9s770v.y66y3wCAw9u65Bw5B.u64@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=appspotmail.com
X-Google-Smtp-Source: AG47ELtpz/ihyR7wckTqY+pcqTUbWUvTCwgyp0X9cq7fx6Bj7OomN0hmwlnY5BTYam9wJWyFWA7UIA0tKjbtDqJxtUpYOH29WXGo
MIME-Version: 1.0
Date: Thu, 29 Mar 2018 07:01:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <089e0825cec8bfc60b05688d8de3@google.com>
Subject: WARNING: kobject bug in device_add
From: syzbot <syzbot+2e63711063e2d8f9ea27@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596280865474192982?=
X-GMAIL-MSGID: =?utf-8?q?1596280865474192982?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello,

syzbot hit the following crash on upstream commit
bcfc1f4554662d8f2429ac8bd96064a59c149754 (Sat Mar 24 16:50:12 2018 +0000)
Merge tag 'pinctrl-v4.16-3' of  
git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=2e63711063e2d8f9ea27

So far this crash happened 19 times on upstream.
C reproducer: https://syzkaller.appspot.com/x/repro.c?id=6431266371010560
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=5933290817060864
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=5328478354276352
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=-5034017172441945317
compiler: gcc (GCC) 7.1.1 20170620

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2e63711063e2d8f9ea27@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

WARNING: CPU: 1 PID: 4192 at lib/kobject.c:238  
kobject_add_internal+0x8d4/0xbc0 lib/kobject.c:235
Kernel panic - not syncing: panic_on_warn set ...

CPU: 1 PID: 4192 Comm: syzkaller870399 Not tainted 4.16.0-rc6+ #1
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
RIP: 0010:kobject_add_internal+0x8d4/0xbc0 lib/kobject.c:235
RSP: 0018:ffff8801b8127270 EFLAGS: 00010282
RAX: dffffc0000000008 RBX: ffff8801b8a81150 RCX: ffffffff815ad0de
RDX: 0000000000000000 RSI: 1ffff10037024dfe RDI: 1ffff10037024dd3
RBP: ffff8801b8127368 R08: 1ffff10037024d95 R09: 0000000000000000
R10: ffff8801b8127030 R11: 0000000000000000 R12: 1ffff10037024e54
R13: 00000000ffffffef R14: ffff8801d5886680 R15: 1ffff10037024e58
  kobject_add_varg lib/kobject.c:364 [inline]
  kobject_add+0x132/0x1f0 lib/kobject.c:409
  device_add+0x35d/0x1650 drivers/base/core.c:1787
  device_create_groups_vargs+0x1f3/0x250 drivers/base/core.c:2430
  device_create_vargs+0x46/0x60 drivers/base/core.c:2470
  bdi_register_va.part.10+0xbb/0x8c0 mm/backing-dev.c:881
  bdi_register_va+0x68/0x80 mm/backing-dev.c:897
  super_setup_bdi_name+0x136/0x230 fs/super.c:1274
  fuse_bdi_init fs/fuse/inode.c:987 [inline]
  fuse_fill_super+0xe75/0x1d60 fs/fuse/inode.c:1107
  mount_bdev+0x2b7/0x370 fs/super.c:1119
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
RIP: 0033:0x4407b9
RSP: 002b:00007ffd93439858 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00000000004407b9
RDX: 00000000004a27ce RSI: 0000000020000080 RDI: 00000000200000c0
RBP: 0030656c69662f2e R08: 00007ffd93439870 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0031656c69662f2e
R13: 0000000000401be0 R14: 0000000000000000 R15: 0000000000000000
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
