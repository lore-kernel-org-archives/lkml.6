Return-Path: <3KkDEWgkbAJcJPQB1CC5I1GG94.7FF7C5LJ5I3FEK5EK.3FD@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522810922; cv=none;
        d=google.com; s=arc-20160816;
        b=KWbBPl1Fe3ahTp/Kn6baukHiza9Sg3cgJRftew8rnB0AaBNECtAj+kb0ubIYGNHDa9
         gLg9s7211oVJg8oCwVs4fuGc4eeqIbwHzrSXpE8vAPNtSRxo5NoPd4zsg3qfyKKYb9hM
         EDCr8gPPUJ+D3X5hytFiHjb/Hfh8WUMH/XXyUIFLNGMtOYJsjfUhHMoYBIDw3aaiyy4C
         0ULhdCWSt+MZmLscWDvvWv6nKu91UYP0602h+o6y8pUa6PU6kkiTOAtZ0UP00FwdcaL2
         ELOvT7eRQToI+qE/3uXb/1U+VwuObUGT+iy0g+8AVkm/aSWQF7VSAbn0sDy89DUF9fha
         eN4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:from:subject:message-id:date:mime-version
         :arc-authentication-results;
        bh=ycE8QtCIfedPwbwvqvXoop9x07rgyaaqLHh2dXx1CCg=;
        b=PzQ+G0DH61PRZaSKH7zHHT4m7i+b2onj3FTC2COY5kch6kvOjA4xwY/F7oZ0Ia7Sxu
         Bbr1LUExGW8CDmDQQx6Nu/9pSqjX248VKs1lHojUqqKy7d3UArHYhlpr3KmtoK7kIZ4k
         VsNFW9DH/yemC2POf+7ltuxVf5JZ3rouEGQRsD1SHjiY/GvDL3cnZq4ogw9RqoX0QtSe
         R8YBD1pmzuKOjGwR951NlLl6IC/CYe6e10Y4AZypfJN1/W69g5UUMFcVwFfSOuyDhDhL
         9oxYvyBxk9UBGZK8VfccjRhUTrE4cIxn8wzBPnGhQZkv9v4TUV+8nIbw11E/m+6agopA
         ykJw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of 3kkdewgkbajcjpqb1cc5i1gg94.7ff7c5lj5i3fek5ek.3fd@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com designates 209.85.220.69 as permitted sender) smtp.mailfrom=3KkDEWgkbAJcJPQB1CC5I1GG94.7FF7C5LJ5I3FEK5EK.3FD@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=appspotmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of 3kkdewgkbajcjpqb1cc5i1gg94.7ff7c5lj5i3fek5ek.3fd@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com designates 209.85.220.69 as permitted sender) smtp.mailfrom=3KkDEWgkbAJcJPQB1CC5I1GG94.7FF7C5LJ5I3FEK5EK.3FD@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=appspotmail.com
X-Google-Smtp-Source: AIpwx4/VOgfurYGv24f+4HgaBuj+J8GU+U5yZpIakSJ19I5V0kOzlUnxOwZ1QzJZBnUCiDVJO+7SQa1LLvkRwM9X/AZ0Foi5TF2R
MIME-Version: 1.0
Date: Tue, 03 Apr 2018 20:02:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <001a11c1461c14bf9e0568fd0cd6@google.com>
Subject: WARNING in hfs_bnode_create
From: syzbot <syzbot+a19ca73b21fe8bc69101@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, chris.gekas@gmail.com,
	gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, pombredanne@nexb.com,
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596782986329523057?=
X-GMAIL-MSGID: =?utf-8?q?1596782986329523057?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello,

syzbot hit the following crash on upstream commit
f2d285669aae656dfeafa0bf25e86bbbc5d22329 (Tue Apr 3 17:45:39 2018 +0000)
Merge tag 'pm-4.17-rc1' of  
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=a19ca73b21fe8bc69101

C reproducer: https://syzkaller.appspot.com/x/repro.c?id=5003601122426880
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=5963421623255040
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=5236399087288320
Kernel config: https://syzkaller.appspot.com/x/.config?id=686016073509112605
compiler: gcc (GCC) 7.1.1 20170620

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a19ca73b21fe8bc69101@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

hfs: unable to locate alternate MDB
hfs: continuing without an alternate MDB
hfs: new node 0 already hashed?
WARNING: CPU: 0 PID: 4477 at fs/hfs/bnode.c:416  
hfs_bnode_create+0x30b/0x380 fs/hfs/bnode.c:415
Kernel panic - not syncing: panic_on_warn set ...

CPU: 0 PID: 4477 Comm: syzkaller579848 Not tainted 4.16.0+ #13
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:17 [inline]
  dump_stack+0x1a7/0x27d lib/dump_stack.c:53
  panic+0x1f8/0x42c kernel/panic.c:183
  __warn+0x1dc/0x200 kernel/panic.c:547
  report_bug+0x1f4/0x2b0 lib/bug.c:186
  fixup_bug.part.10+0x37/0x80 arch/x86/kernel/traps.c:178
  fixup_bug arch/x86/kernel/traps.c:247 [inline]
  do_error_trap+0x2d7/0x3e0 arch/x86/kernel/traps.c:296
  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:315
  invalid_op+0x1b/0x40 arch/x86/entry/entry_64.S:991
RIP: 0010:hfs_bnode_create+0x30b/0x380 fs/hfs/bnode.c:415
RSP: 0018:ffff8801ad477730 EFLAGS: 00010286
RAX: 000000000000001f RBX: 0000000000000000 RCX: 0000000000000000
RDX: 000000000000001f RSI: 1ffff10035a8ee9b RDI: ffffed0035a8eeda
RBP: ffff8801ad477770 R08: ffffed003b604f99 R09: ffffed003b604f99
R10: 0000000000000001 R11: ffffed003b604f98 R12: ffff8801d953ead0
R13: ffff8801d953ea00 R14: ffff8801d0811c00 R15: 0000000000000000
  hfs_bmap_alloc+0x804/0xee0 fs/hfs/btree.c:279
  hfs_bnode_split+0xc0/0xfb0 fs/hfs/brec.c:240
  hfs_brec_insert+0x366/0xb90 fs/hfs/brec.c:101
  hfs_cat_create+0xa06/0xd80 fs/hfs/catalog.c:123
  hfs_mkdir+0x6a/0xd0 fs/hfs/dir.c:237
  vfs_mkdir+0x390/0x600 fs/namei.c:3806
  do_mkdirat+0x224/0x2b0 fs/namei.c:3829
  SYSC_mkdir fs/namei.c:3845 [inline]
  SyS_mkdir+0x22/0x30 fs/namei.c:3843
  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x440739
RSP: 002b:00007ffe4d841778 EFLAGS: 00000207 ORIG_RAX: 0000000000000053
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000440739
RDX: 0000000000401030 RSI: 0000000000000021 RDI: 0000000020000180
RBP: 0000000000000003 R08: 000000000000000a R09: 6f6f6c2f7665642f
R10: 0000000020011700 R11: 0000000000000207 R12: 0000000000000004
R13: 0000000000401fb0 R14: 0000000000000000 R15: 0000000000000000
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
