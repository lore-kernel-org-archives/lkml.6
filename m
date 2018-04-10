Return-Path: <3SkXMWgkbAOEVbcNDOOHUDSSLG.JRRJOHXVHUFRQWHQW.FRP@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523336522; cv=none;
        d=google.com; s=arc-20160816;
        b=0HUzvNoCmPcOzkRi9kyUMCvcE4aIAjRo6PfLR7KmAOb8uFsIwzNRZNlIFbCnaqr3E9
         skY0mnL7UkFUSzYOJ2dT75WApMfCeinYOAOfnfaALYxg5ScFVJQg8bT4AvkVhKbPD/1d
         I9mncat3givmhP8eEIrFYbudNEbDaRGtJmqO/N4aZKyVYJ+1daPDM6IFx//GyAaXW8P+
         iky6DGDfvoLYkBDivLimqDhnbSei1W1V+WBcD4ithopdDcRIhWK1PXlp30I0MYk8f7re
         YvIYwFBeQOXI4rd1GRXI8WLGMYgovCBIUGNLd9ATYlSpfN29B+FPIo89z//rx+s2UjNg
         63iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:from:subject:message-id:date:mime-version
         :arc-authentication-results;
        bh=nxLevhbjRXZOwm28PnNZrzoTRAkOTbh8FmrLDvfSexE=;
        b=0UP3Txgf3zhhHJ78neoH4lGhb4UHGpOps3WRG/rFb0+7agvCrE57h+jYmWUIuwvb4a
         PXFMbHX1tQTC3VDded+/Z1L7Bs0Ot5q4nNewB/6wQaw8up4eShT51g7kmVEx6/BxxeBr
         9LTbjKJywm/Xrb9BL4iojpwiaGXsCuaN41qRZf9R8dvwZsAwcXS8rRIqeBLciJQqYW4+
         anHJzvjwQMhCpjk3fKpIeXBcsf0Ea4dEEGuL097LIkpkeT+RoNtjA1dpSuN1+K02O0PM
         q8XU2uYkmWB+eigK7t0OSXEiFI2Oh4W3kcys/3sZvFl/KV5uYmyk5z45wgkjEhSPm+nq
         BJZQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of 3skxmwgkbaoevbcndoohudsslg.jrrjohxvhufrqwhqw.frp@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com designates 209.85.220.69 as permitted sender) smtp.mailfrom=3SkXMWgkbAOEVbcNDOOHUDSSLG.JRRJOHXVHUFRQWHQW.FRP@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=appspotmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of 3skxmwgkbaoevbcndoohudsslg.jrrjohxvhufrqwhqw.frp@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com designates 209.85.220.69 as permitted sender) smtp.mailfrom=3SkXMWgkbAOEVbcNDOOHUDSSLG.JRRJOHXVHUFRQWHQW.FRP@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=appspotmail.com
X-Google-Smtp-Source: AIpwx49L+PVGH8DG1amxdgDMXa5uW5vmiGmOcTQ2vTMldMlB40OqNKQgb+T8vFslJucmSyiPSO8fWtn+d6EaQjkookvmGnoMv8Tm
MIME-Version: 1.0
Date: Mon, 09 Apr 2018 22:02:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000047b6430569776cbc@google.com>
Subject: WARNING: kobject bug in corrupted
From: syzbot <syzbot+dd8fe49d0d1423aa5295@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597334117924271383?=
X-GMAIL-MSGID: =?utf-8?q?1597334117924271383?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello,

syzbot hit the following crash on upstream commit
fd40ffc72e2f74c7db61e400903e7d50a88bc0b0 (Mon Apr 9 18:36:05 2018 +0000)
selinux: fix missing dput() before selinuxfs unmount
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=dd8fe49d0d1423aa5295

C reproducer: https://syzkaller.appspot.com/x/repro.c?id=5710100694040576
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=5951393567342592
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=6276231339180032
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=-771321277174894814
compiler: gcc (GCC) 8.0.1 20180301 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+dd8fe49d0d1423aa5295@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
kobject_add_internal failed for gfs2meta with -EEXIST, don't try to  
register things with the same name in the same directory.
  sysfs_warn_dup.cold.3+0x1c/0x2b fs/sysfs/dir.c:30
  sysfs_create_dir_ns+0x184/0x1d0 fs/sysfs/dir.c:58
WARNING: CPU: 1 PID: 4473 at lib/kobject.c:238  
kobject_add_internal+0x8e0/0xba0 lib/kobject.c:236
  create_dir lib/kobject.c:69 [inline]
  kobject_add_internal+0x353/0xba0 lib/kobject.c:228
Kernel panic - not syncing: panic_on_warn set ...

  kobject_add_varg lib/kobject.c:364 [inline]
  kobject_init_and_add+0xed/0x130 lib/kobject.c:435
  gfs2_sys_fs_add+0x1ff/0x500 fs/gfs2/sys.c:652
  fill_super+0x8c9/0x1a40 fs/gfs2/ops_fstype.c:1118
  gfs2_mount+0x5e6/0x712 fs/gfs2/ops_fstype.c:1321
  mount_fs+0xae/0x328 fs/super.c:1222
  vfs_kern_mount.part.34+0xd4/0x4d0 fs/namespace.c:1037
  vfs_kern_mount fs/namespace.c:1027 [inline]
  do_new_mount fs/namespace.c:2517 [inline]
  do_mount+0x564/0x3070 fs/namespace.c:2847
  ksys_mount+0x12d/0x140 fs/namespace.c:3063
  SYSC_mount fs/namespace.c:3077 [inline]
  SyS_mount+0x35/0x50 fs/namespace.c:3074
  do_syscall_64+0x29e/0x9d0 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x4430ca
RSP: 002b:00007fff5f80e158 EFLAGS: 00000297 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000004430ca
RDX: 0000000020000040 RSI: 0000000020000080 RDI: 00007fff5f80e170
RBP: 00000000006cb018 R08: 00000000200004c0 R09: 000000000000000a
R10: 0000000000000000 R11: 0000000000000297 R12: 6e5f6b636f6c3d6f
R13: 746f72706b636f6c R14: 0030656c69662f2e R15: 0000000000000004
CPU: 1 PID: 4473 Comm: syzkaller208561 Not tainted 4.16.0+ #14
------------[ cut here ]------------
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
kobject_add_internal failed for gfs2meta with -EEXIST, don't try to  
register things with the same name in the same directory.
  panic+0x22f/0x4de kernel/panic.c:183
WARNING: CPU: 0 PID: 4470 at lib/kobject.c:238  
kobject_add_internal+0x8e0/0xba0 lib/kobject.c:236
Modules linked in:
CPU: 0 PID: 4470 Comm: syzkaller208561 Not tainted 4.16.0+ #14
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:kobject_add_internal+0x8e0/0xba0 lib/kobject.c:236
  __warn.cold.8+0x163/0x1a3 kernel/panic.c:547
RSP: 0018:ffff8801af7af480 EFLAGS: 00010286
  report_bug+0x252/0x2d0 lib/bug.c:186
RAX: 000000000000007d RBX: ffff8801af24d1d0 RCX: ffffffff815f42ed
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x1de/0x490 arch/x86/kernel/traps.c:296
RDX: 0000000000000000 RSI: ffffffff815f8fa1 RDI: ffff8801af7aefe0
RBP: ffff8801af7af578 R08: ffff8801af794640 R09: 0000000000000006
R10: ffff8801af794640 R11: 0000000000000000 R12: 00000000ffffffef
R13: ffff8801d3abea48 R14: 1ffff10035ef5e9a R15: ffff8801d3abea00
FS:  00000000011be880(0000) GS:ffff8801db000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff0fb79330 CR3: 00000001af480000 CR4: 00000000001406f0
  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:315
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  invalid_op+0x1b/0x40 arch/x86/entry/entry_64.S:991
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
RIP: 0010:kobject_add_internal+0x8e0/0xba0 lib/kobject.c:236
RSP: 0018:ffff8801af4ef480 EFLAGS: 00010286
RAX: 000000000000007d RBX: ffff8801af2a1210 RCX: ffffffff815f42ed
RDX: 0000000000000000 RSI: ffffffff815f8fa1 RDI: ffff8801af4eefe0
RBP: ffff8801af4ef578 R08: ffff8801af00c700 R09: 0000000000000006
R10: ffff8801af00c700 R11: 0000000000000000 R12: 00000000ffffffef
R13: ffff8801d3abea48 R14: 1ffff10035e9de9a R15: ffff8801d3abea00
  kobject_add_varg lib/kobject.c:364 [inline]
  kobject_init_and_add+0xed/0x130 lib/kobject.c:435
  gfs2_sys_fs_add+0x1ff/0x500 fs/gfs2/sys.c:652
  kobject_add_varg lib/kobject.c:364 [inline]
  kobject_init_and_add+0xed/0x130 lib/kobject.c:435
  gfs2_sys_fs_add+0x1ff/0x500 fs/gfs2/sys.c:652
  fill_super+0x8c9/0x1a40 fs/gfs2/ops_fstype.c:1118
  fill_super+0x8c9/0x1a40 fs/gfs2/ops_fstype.c:1118
  gfs2_mount+0x5e6/0x712 fs/gfs2/ops_fstype.c:1321
  mount_fs+0xae/0x328 fs/super.c:1222
  vfs_kern_mount.part.34+0xd4/0x4d0 fs/namespace.c:1037
  gfs2_mount+0x5e6/0x712 fs/gfs2/ops_fstype.c:1321
  vfs_kern_mount fs/namespace.c:1027 [inline]
  do_new_mount fs/namespace.c:2517 [inline]
  do_mount+0x564/0x3070 fs/namespace.c:2847
  mount_fs+0xae/0x328 fs/super.c:1222
  vfs_kern_mount.part.34+0xd4/0x4d0 fs/namespace.c:1037
  vfs_kern_mount fs/namespace.c:1027 [inline]
  do_new_mount fs/namespace.c:2517 [inline]
  do_mount+0x564/0x3070 fs/namespace.c:2847
  ksys_mount+0x12d/0x140 fs/namespace.c:3063
  SYSC_mount fs/namespace.c:3077 [inline]
  SyS_mount+0x35/0x50 fs/namespace.c:3074
  do_syscall_64+0x29e/0x9d0 arch/x86/entry/common.c:287
  ksys_mount+0x12d/0x140 fs/namespace.c:3063
  SYSC_mount fs/namespace.c:3077 [inline]
  SyS_mount+0x35/0x50 fs/namespace.c:3074
  do_syscall_64+0x29e/0x9d0 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x4430ca
RSP: 002b:00007fff5f80e158 EFLAGS: 00000297 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000004430ca
RDX: 0000000020000040 RSI: 0000000020000080 RDI: 00007fff5f80e170
RBP: 00000000006cb018 R08: 00000000200004c0 R09: 000000000000000a
R10: 0000000000000000 R11: 0000000000000297 R12: 6e5f6b636f6c3d6f
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
R13: 746f72706b636f6c R14: 0030656c69662f2e R15: 0000000000000004
RIP: 0033:0x4430ca
Code:
RSP: 002b:00007fff5f80e158 EFLAGS: 00000297
00
  ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000004430ca
00
RDX: 0000000020000040 RSI: 0000000020000080 RDI: 00007fff5f80e170
RBP: 00000000006cb018 R08: 00000000200004c0 R09: 000000000000000a
00
R10: 0000000000000000 R11: 0000000000000297 R12: 6e5f6b636f6c3d6f
00
R13: 746f72706b636f6c R14: 0030656c69662f2e R15: 0000000000000004
fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 88 02 00 00 48 8b 13 48 c7 c6 60 1a  
42 88 48 c7 c7 c0 17 42 88 e8 e0 62 fd f9 <0f> 0b e9 47 fb ff ff 4c 89 e7  
e8 f1 1b 6b fa e9 e2 f7 ff ff 4c
---[ end trace 34ddd5ed728de6e7 ]---
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
