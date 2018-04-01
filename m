Return-Path: <3ThDBWgkbAE89FG1r22v8r66zu.x55x2vB9v8t54Av4A.t53@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522602062; cv=none;
        d=google.com; s=arc-20160816;
        b=AH6wSWNZALN9t74yMHTwlpNDcbvJ78xAyhM5dUMT1B9JaR7rgMtcTdYgP5P3UBzhId
         0lN/eD05I4VmSiwydQ0JtVYak35Y4s8r19bBcJE4Ok/5F+r7dEX+YMXLgHw8f3OqitVo
         ZQ74T/Om0jKXg/BQK2RP08BCQwrjXxOFZrGrXAEVlDhFQ5pOpktbKNe8sDZGKJMD9S4N
         R7wU4OlLCeHWkpBo3LFn00aRXNl0mwZ0uiqTMoxla9XbSsRYO5IJWsNXB3yuIxvMtoC+
         YPwnuKIY6KksrPtumiUAtflxTKF+k4zGwY7GpeOuswV/pznJbbhQf4N8lUq5moCYCqCA
         1EAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:from:subject:message-id:date:mime-version
         :arc-authentication-results;
        bh=nEgsuC/HLCWKPHfnxqaCmTKiceFlsZac+9CPZHCWI1k=;
        b=QtC9KmgtpeDWgRrolret8yixFxVopu77rZK0cZy9Erk9hqLgjVlhoP1R5F60h9btpT
         MhwWvDrYqfXzUJ/n6uTXGY24YN4ictfwOwjjimt35xPh9KV+XY2jYd3WDzsRs4+AJ2Yf
         mw8oHrwUqu1FmpczWnW+YNq6DwYYTCuf0jIgFjQVjW1h+4V+1Eo9UY/shP+0Kh23Iqjy
         YWdownBW9p6DeOxc2njsCigl+Udszjn0YoNTA+hi1WcYXrOMklaXuQJXSx9hNZl7DCZ1
         4x3AIxEWaMSFueFHbx2JIEZ37/UetDY7xHnFv5yCAy0l8P8lsk0hiKACLH/KZfgMl3hK
         +u9w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of 3thdbwgkbae89fg1r22v8r66zu.x55x2vb9v8t54av4a.t53@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com designates 209.85.220.69 as permitted sender) smtp.mailfrom=3ThDBWgkbAE89FG1r22v8r66zu.x55x2vB9v8t54Av4A.t53@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=appspotmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of 3thdbwgkbae89fg1r22v8r66zu.x55x2vb9v8t54av4a.t53@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com designates 209.85.220.69 as permitted sender) smtp.mailfrom=3ThDBWgkbAE89FG1r22v8r66zu.x55x2vB9v8t54Av4A.t53@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=appspotmail.com
X-Google-Smtp-Source: AIpwx4+LE9nQQg7YOxm9OXy0Tbn4t6x0VQZaXrJJNtuduW6T4HK1EM2dymcpjjb5OKNKaKnVvhJBd0RpIAeFwonaKSxnzgZSVX/6
MIME-Version: 1.0
Date: Sun, 01 Apr 2018 10:01:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <94eb2c0546040ebb4d0568cc6bdb@google.com>
Subject: general protection fault in kernfs_kill_sb
From: syzbot <syzbot+151de3f2be6b40ac8026@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, kstewart@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, pombredanne@nexb.com,
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596563980561316248?=
X-GMAIL-MSGID: =?utf-8?q?1596563980561316248?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello,

syzbot hit the following crash on bpf-next commit
7828f20e3779e4e85e55371e0e43f5006a15fb41 (Sat Mar 31 00:17:57 2018 +0000)
Merge branch 'bpf-cgroup-bind-connect'
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=151de3f2be6b40ac8026

So far this crash happened 3 times on bpf-next.
C reproducer: https://syzkaller.appspot.com/x/repro.c?id=4857382450495488
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=4644052230209536
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=5798498637185024
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=5909223872832634926
compiler: gcc (GCC) 7.1.1 20170620

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+151de3f2be6b40ac8026@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

kasan: GPF could be caused by NULL-ptr deref or user memory access
  should_failslab+0xec/0x120 mm/failslab.c:32
  slab_pre_alloc_hook mm/slab.h:422 [inline]
  slab_alloc mm/slab.c:3365 [inline]
  __do_kmalloc mm/slab.c:3703 [inline]
  __kmalloc+0x63/0x760 mm/slab.c:3714
general protection fault: 0000 [#1] SMP KASAN
Dumping ftrace buffer:
    (ftrace buffer empty)
  kmalloc include/linux/slab.h:517 [inline]
  kzalloc include/linux/slab.h:701 [inline]
  register_shrinker+0x10e/0x2d0 mm/vmscan.c:268
Modules linked in:
CPU: 1 PID: 4471 Comm: syzkaller129261 Not tainted 4.16.0-rc6+ #43
  sget_userns+0xbbf/0xe40 fs/super.c:520
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__list_del_entry_valid+0x7e/0x150 lib/list_debug.c:51
RSP: 0018:ffff8801ae017658 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffff8801d97a6e98 RDI: ffff8801d97a6ea0
RBP: ffff8801ae017670 R08: ffffffff81d39d22 R09: 0000000000000004
R10: ffff8801ae017670 R11: 0000000000000000 R12: 0000000000000000
R13: ffff8801d91dec00 R14: ffff8801ae017700 R15: ffff8801d97a6e98
FS:  0000000001569880(0000) GS:ffff8801db100000(0000) knlGS:0000000000000000
  kernfs_mount_ns+0x13d/0x8b0 fs/kernfs/mount.c:320
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000006d0188 CR3: 00000001da40c005 CR4: 00000000001606e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  sysfs_mount+0xc2/0x1c0 fs/sysfs/mount.c:36
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  __list_del_entry include/linux/list.h:117 [inline]
  list_del include/linux/list.h:125 [inline]
  kernfs_kill_sb+0x9e/0x330 fs/kernfs/mount.c:361
  mount_fs+0x66/0x2d0 fs/super.c:1222
  vfs_kern_mount.part.26+0xc6/0x4a0 fs/namespace.c:1037
  sysfs_kill_sb+0x22/0x40 fs/sysfs/mount.c:50
  vfs_kern_mount fs/namespace.c:2509 [inline]
  do_new_mount fs/namespace.c:2512 [inline]
  do_mount+0xea4/0x2bb0 fs/namespace.c:2842
  deactivate_locked_super+0x88/0xd0 fs/super.c:312
  sget_userns+0xbda/0xe40 fs/super.c:522
  SYSC_mount fs/namespace.c:3058 [inline]
  SyS_mount+0xab/0x120 fs/namespace.c:3035
  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
  kernfs_mount_ns+0x13d/0x8b0 fs/kernfs/mount.c:320
  sysfs_mount+0xc2/0x1c0 fs/sysfs/mount.c:36
  mount_fs+0x66/0x2d0 fs/super.c:1222
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
  vfs_kern_mount.part.26+0xc6/0x4a0 fs/namespace.c:1037
RIP: 0033:0x442609
RSP: 002b:00007fff40a278e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000442609
RDX: 0000000020000140 RSI: 0000000020000040 RDI: 0000000020000000
RBP: 00007fff40a28190 R08: 00000000200002c0 R09: 0000000300000000
  vfs_kern_mount fs/namespace.c:2509 [inline]
  do_new_mount fs/namespace.c:2512 [inline]
  do_mount+0xea4/0x2bb0 fs/namespace.c:2842
R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffff
R13: 0000000000000003 R14: 0000000000001380 R15: 00007fff40a27a28
  SYSC_mount fs/namespace.c:3058 [inline]
  SyS_mount+0xab/0x120 fs/namespace.c:3035
  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x442609
RSP: 002b:00007fff40a278e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000442609
RDX: 0000000020000140 RSI: 0000000020000040 RDI: 0000000020000000
RBP: 00007fff40a28190 R08: 00000000200002c0 R09: 0000000300000000
R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffff
R13: 0000000000000003 R14: 0000000000001380 R15: 00007fff40a27a28
Code: 00 00 00 00 ad de 49 39 c4 74 66 48 b8 00 02 00 00 00 00 ad de 48 89  
da 48 39 c3 74 65 48 c1 ea 03 48 b8 00 00 00 00 00 fc ff df <80> 3c 02 00  
75 7b 48 8b 13 48 39 f2 75 57 49 8d 7c 24 08 48 b8
RIP: __list_del_entry_valid+0x7e/0x150 lib/list_debug.c:51 RSP:  
ffff8801ae017658
---[ end trace b14d521943ecadbd ]---


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
