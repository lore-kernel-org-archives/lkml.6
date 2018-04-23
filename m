Return-Path: <3izDdWgkbAD4x34pfqqjwfuuni.lttlqjzxjwhtsyjsy.htr@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524445324; cv=none;
        d=google.com; s=arc-20160816;
        b=xQLSvSSkrWfAW3SyVeHRv2cUCRVDTc4TOPzK0rbXTLVbRhrjvNtQqDqpcLSisj3zf4
         QGxnkrn+kBVtekxR47Cq1S7QUdg7kjsMKESCJENsAEteU5PRFoxN6BHAFfJAEpoajYI/
         1CLkZE4r2wBuZ755iLanlhALzyC21wmfmUFSoQiI7Dche6K9uk5xreuTfa1plNh1HGZ+
         og4/RKtSEbvTgPBHI8X+RJACyv8nD/rrqohpND1eH4UzRZDcHbjPb+6A1sD1wRw7e8KY
         1BzwqmRcttyopq3OMet72Zi4xVdD/WTYX/ULFp+kunZTAa4j1RHE6pOp8WSiq/ODmuCw
         +jsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:from:subject:message-id:date:mime-version
         :arc-authentication-results;
        bh=YbQ0BfWjHmT6IOv/Y1YWSZD81+2B4D4IgewIaxVw+fQ=;
        b=CzPhcVqyTWJ4uA9v7BIwkHydzbJhtYNa7W1iaVpJ8POo9CBefUFAiJIuOKIflBl4Hp
         1PRRhFbysc5CJmCZwQVJ1r6+7mJT6RYSe7PZNNK/dmTuutbrMfbpi0VihB2YZAxgYWux
         f8Jo5kXbh3U57cze4Gl9d3xdScDilycduv/xmp/SOnVGKPr5ZRAHTcbT6xDmuLq57fX+
         2i/CVSRlgpEFscS33GasAhQTkHXtMz25CvauTP5Yb/zDOgmY9grG7UV6sSlx4TlPql4Y
         CU06MjHN/LDmBhRWlvh5d1Nkb+PrmhdF26PiWY5GoLH3Je3a/kCgtrJxbpI6tcYJjc+z
         Fo8Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of 3izddwgkbad4x34pfqqjwfuuni.lttlqjzxjwhtsyjsy.htr@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com designates 209.85.220.69 as permitted sender) smtp.mailfrom=3izDdWgkbAD4x34pfqqjwfuuni.lttlqjzxjwhtsyjsy.htr@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=appspotmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of 3izddwgkbad4x34pfqqjwfuuni.lttlqjzxjwhtsyjsy.htr@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com designates 209.85.220.69 as permitted sender) smtp.mailfrom=3izDdWgkbAD4x34pfqqjwfuuni.lttlqjzxjwhtsyjsy.htr@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=appspotmail.com
X-Google-Smtp-Source: AIpwx482wQh7/SJHCbaDd4pP/hSA922qO+7/JYACCHn55XJ/ZdQAK0NHLzErM4ngn7bG0CpwZIjpRiavDQMJUe8ksUXXWz20z6SA
MIME-Version: 1.0
Date: Sun, 22 Apr 2018 18:02:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f64410056a7995db@google.com>
Subject: possible deadlock in hfs_find_init
From: syzbot <syzbot+b718ec84a87b7e73ade4@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, kstewart@linuxfoundation.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	pombredanne@nexb.com, syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598496780609265938?=
X-GMAIL-MSGID: =?utf-8?q?1598496780609265938?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello,

syzbot hit the following crash on upstream commit
43f70c960180c11d64ee3e9e53075fe1acd43ff1 (Fri Apr 20 16:08:37 2018 +0000)
Merge tag 'ecryptfs-4.17-rc2-fixes' of  
git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=b718ec84a87b7e73ade4

C reproducer: https://syzkaller.appspot.com/x/repro.c?id=5968078374436864
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=4766076478947328
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=6072762028261376
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=1808800213120130118
compiler: gcc (GCC) 8.0.1 20180413 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b718ec84a87b7e73ade4@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

hfs: unable to locate alternate MDB
hfs: continuing without an alternate MDB

============================================
WARNING: possible recursive locking detected
4.17.0-rc1+ #9 Not tainted
--------------------------------------------
syzkaller905163/4505 is trying to acquire lock:
00000000cf71528f (&tree->tree_lock){+.+.}, at: hfs_find_init+0x11c/0x180  
fs/hfs/bfind.c:28

but task is already holding lock:
000000007d108cde (&tree->tree_lock){+.+.}, at: hfs_find_init+0x11c/0x180  
fs/hfs/bfind.c:28

other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(&tree->tree_lock);
   lock(&tree->tree_lock);

  *** DEADLOCK ***

  May be due to missing lock nesting notation

3 locks held by syzkaller905163/4505:
  #0: 000000005253f77a (&type->s_umount_key#36/1){+.+.}, at: alloc_super  
fs/super.c:212 [inline]
  #0: 000000005253f77a (&type->s_umount_key#36/1){+.+.}, at:  
sget_userns+0x2dd/0xf20 fs/super.c:503
  #1: 000000007d108cde (&tree->tree_lock){+.+.}, at:  
hfs_find_init+0x11c/0x180 fs/hfs/bfind.c:28
  #2: 00000000d9af4d52 (&HFS_I(tree->inode)->extents_lock){+.+.}, at:  
hfs_get_block+0x56c/0x850 fs/hfs/extent.c:359

stack backtrace:
CPU: 1 PID: 4505 Comm: syzkaller905163 Not tainted 4.17.0-rc1+ #9
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  print_deadlock_bug kernel/locking/lockdep.c:1761 [inline]
  check_deadlock kernel/locking/lockdep.c:1805 [inline]
  validate_chain kernel/locking/lockdep.c:2401 [inline]
  __lock_acquire.cold.62+0x18c/0x55b kernel/locking/lockdep.c:3431
  lock_acquire+0x1dc/0x520 kernel/locking/lockdep.c:3920
  __mutex_lock_common kernel/locking/mutex.c:756 [inline]
  __mutex_lock+0x16d/0x17f0 kernel/locking/mutex.c:893
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:908
  hfs_find_init+0x11c/0x180 fs/hfs/bfind.c:28
  hfs_ext_read_extent+0x1b9/0xc20 fs/hfs/extent.c:196
  hfs_get_block+0x578/0x850 fs/hfs/extent.c:360
  block_read_full_page+0x2c7/0xab0 fs/buffer.c:2236
  hfs_readpage+0x1c/0x20 fs/hfs/inode.c:38
  do_read_cache_page+0x778/0x13b0 mm/filemap.c:2806
  read_cache_page+0x61/0x80 mm/filemap.c:2894
  read_mapping_page include/linux/pagemap.h:402 [inline]
  __hfs_bnode_create+0x601/0x9f0 fs/hfs/bnode.c:281
  hfs_bnode_find+0x2b8/0xb80 fs/hfs/bnode.c:330
  hfs_brec_find+0x2f3/0x5b0 fs/hfs/bfind.c:114
  hfs_brec_read+0x27/0x120 fs/hfs/bfind.c:153
  hfs_cat_find_brec+0x14a/0x400 fs/hfs/catalog.c:186
  hfs_fill_super+0x11f4/0x18c0 fs/hfs/super.c:426
  mount_bdev+0x30c/0x3e0 fs/super.c:1165
  hfs_mount+0x34/0x40 fs/hfs/super.c:463
  mount_fs+0xae/0x328 fs/super.c:1268
  vfs_kern_mount.part.34+0xd4/0x4d0 fs/namespace.c:1037
  vfs_kern_mount fs/namespace.c:1027 [inline]
  do_new_mount fs/namespace.c:2517 [inline]
  do_mount+0x564/0x3070 fs/namespace.c:2847
  ksys_mount+0x12d/0x140 fs/namespace.c:3063
  __do_sys_mount fs/namespace.c:3077 [inline]
  __se_sys_mount fs/namespace.c:3074 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3074
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x442e4a
RSP: 002b:00007ffe9b4269d8 EFLAGS: 00000297 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000258 RCX: 0000000000442e4a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffe9b4269e0


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
