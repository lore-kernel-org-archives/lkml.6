Return-Path: <3Vq-_WgkbAI8BHI3t44xAt881w.z77z4xDBxAv76Cx6C.v75@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522511702; cv=none;
        d=google.com; s=arc-20160816;
        b=fxyStXu074VizNeSfktKhj3ZJOC3tUYf+Pe93r9yj9AOHHMRqEH6V8FcwtSxe1yah8
         4+XQAkzXUtBkGSot+zq1jsFPEjEDT/Pl3jCRAfu++PdCy7nBoEyGx2SCeYZ87k/3zBNp
         mZeBa15lXcpm42WcWuTvszxgVzbpCiAiAApdJmMzSgoDAMKoxezYXGlDAcJFAFi9XesA
         12tL1vBYlFvA8EMZVd/CCxYnuFhizC/m+gW8GI+4M/6S1V+DdXLC7Je9ZnxHgvG0qqvk
         ymMz5ODpibPxf/KSLG1TTEEzn71eUfZ3Z6T0lrASeDPZ/nGzTSveFk87GSIPSp0EIxxp
         mRqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:from:subject:message-id:date:mime-version
         :arc-authentication-results;
        bh=BrJCUBGPs9fpBy4ZYyweL4OuAw9O/aEt2BBM/KzH3z8=;
        b=V0oGtTJcdNQKx/2zQmVogUs3euufsPi7IHAvM8Sec4HEnWP3shJ9VB6bnZTaSGNJl+
         CIEvRMEE/s7u1mRjuIKlPgyUeZQOJu2/Re2L193mhim7OZdFluwNESMWNdOBXbomQXGx
         fNx1hmLKKf+2tJovxg80Z+b/kaFZdQ7NT5eKf0+XELYD3a2oX0d0uznmx58+1oOKMuhW
         cjVGxh7kdrsGTnLJH9VjrajLd5T1i+MWUMDw/hbqFIdEsUoiLZfeB1vSsxuaArtsuCJq
         NkFSixSxndoKY43NKc7hrRNqwntLnusrsXpyuUPU+oObF/Y3UP0NUcP2BhpZnm2rAcue
         cNwQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of 3vq-_wgkbai8bhi3t44xat881w.z77z4xdbxav76cx6c.v75@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com designates 209.85.220.69 as permitted sender) smtp.mailfrom=3Vq-_WgkbAI8BHI3t44xAt881w.z77z4xDBxAv76Cx6C.v75@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=appspotmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of 3vq-_wgkbai8bhi3t44xat881w.z77z4xdbxav76cx6c.v75@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com designates 209.85.220.69 as permitted sender) smtp.mailfrom=3Vq-_WgkbAI8BHI3t44xAt881w.z77z4xDBxAv76Cx6C.v75@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=appspotmail.com
X-Google-Smtp-Source: AIpwx48E8CBJKtBAnpCGVk7sJYbTStqxXL2FXP4XRjzuENboYJlta5CnsvlNZCQhdisYCY6+MtgL4nO+i9xckjpJcKOB6m4OfotO
MIME-Version: 1.0
Date: Sat, 31 Mar 2018 08:55:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <001a113eba282f2ffc0568b76123@google.com>
Subject: kernel BUG at fs/reiserfs/journal.c:LINE!
From: syzbot <syzbot+6820505ae5978f4f8f2f@syzkaller.appspotmail.com>
To: colin.king@canonical.com, dhowells@redhat.com, gregkh@linuxfoundation.org,
	jack@suse.cz, linux-kernel@vger.kernel.org, mingo@kernel.org,
	reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596469231504729146?=
X-GMAIL-MSGID: =?utf-8?q?1596469231504729146?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello,

syzbot hit the following crash on upstream commit
9dd2326890d89a5179967c947dab2bab34d7ddee (Fri Mar 30 17:29:47 2018 +0000)
Merge tag 'ceph-for-4.16-rc8' of git://github.com/ceph/ceph-client
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=6820505ae5978f4f8f2f

syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=5883680186695680
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=6706763961204736
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=-2760467897697295172
compiler: gcc (GCC) 7.1.1 20170620

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+6820505ae5978f4f8f2f@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

REISERFS (device loop7): using 3.5.x disk format
REISERFS (device loop0): found reiserfs format "3.5" with non-standard  
journal
REISERFS (device loop5): using 3.5.x disk format
REISERFS (device loop3): checking transaction log (loop3)
------------[ cut here ]------------
kernel BUG at fs/reiserfs/journal.c:3640!
REISERFS (device loop0): using ordered data mode
invalid opcode: 0000 [#1] SMP KASAN
reiserfs: using flush barriers
Dumping ftrace buffer:
    (ftrace buffer empty)
Modules linked in:
CPU: 0 PID: 4674 Comm: syz-executor5 Not tainted 4.16.0-rc7+ #7
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:check_journal_end fs/reiserfs/journal.c:3640 [inline]
RIP: 0010:do_journal_end+0x39ae/0x4ce0 fs/reiserfs/journal.c:4037
RSP: 0018:ffff8801aafbf1a0 EFLAGS: 00010293
RAX: ffff8801aaf0c100 RBX: ffffc9000273d000 RCX: ffffffff81e6637e
REISERFS (device loop1): found reiserfs format "3.5" with non-standard  
journal
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff8801aafbfa04
RBP: ffff8801aafbf758 R08: ffffffff81e76040 R09: 0000000000000004
R10: ffff8801aafbf168 R11: 0000000000000004 R12: 0000000000000000
R13: ffffc9000273d058 R14: ffffc9000273d048 R15: ffff8801aafbfa10
FS:  00007f3bb0f9f700(0000) GS:ffff8801db000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000625208 CR3: 00000001a9148006 CR4: 00000000001606f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
init_special_inode: bogus i_mode (0) for inode loop4:2
REISERFS warning (device loop4): vs-13075 reiserfs_read_locked_inode: dead  
inode read from disk [1 2 0x0 SD]. This is likely to be race with knfsd.  
Ignore
  journal_end+0x239/0x2d0 fs/reiserfs/journal.c:3409
REISERFS (device loop0): journal params: device loop0, size 512, journal  
first block 18, max trans len 256, max batch 225, max commit age 30, max  
trans age 30
  reiserfs_fill_super+0x2a66/0x33a0 fs/reiserfs/super.c:2168
init_special_inode: bogus i_mode (0) for inode loop3:2
  mount_bdev+0x2b7/0x370 fs/super.c:1119
REISERFS warning (device loop3): vs-13075 reiserfs_read_locked_inode: dead  
inode read from disk [1 2 0x0 SD]. This is likely to be race with knfsd.  
Ignore
  get_super_block+0x34/0x40 fs/reiserfs/super.c:2605
  mount_fs+0x66/0x2d0 fs/super.c:1222
  vfs_kern_mount.part.26+0xc6/0x4a0 fs/namespace.c:1037
REISERFS (device loop1): using ordered data mode
  vfs_kern_mount fs/namespace.c:2509 [inline]
  do_new_mount fs/namespace.c:2512 [inline]
  do_mount+0xea4/0x2bb0 fs/namespace.c:2842
reiserfs: using flush barriers
  SYSC_mount fs/namespace.c:3058 [inline]
  SyS_mount+0xab/0x120 fs/namespace.c:3035
  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x4578aa
RSP: 002b:00007f3bb0f9ebb8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000000 RCX: 00000000004578aa
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f3bb0f9ec00
RBP: 0000000000000007 R08: 0000000020011500 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000005
R13: 000000000000066d R14: 00000000006fbad8 R15: 0000000000000001
Code: e8 c8 fe fe ff e9 b9 f9 ff ff e8 de 01 8b ff 0f 0b e8 d7 01 8b ff 0f  
0b e8 d0 01 8b ff 0f 0b e8 c9 01 8b ff 0f 0b e8 c2 01 8b ff <0f> 0b 4c 8d  
a5 98 fc ff ff e8 b4 01 8b ff 48 8d bb d0 01 00 00
RIP: check_journal_end fs/reiserfs/journal.c:3640 [inline] RSP:  
ffff8801aafbf1a0
RIP: do_journal_end+0x39ae/0x4ce0 fs/reiserfs/journal.c:4037 RSP:  
ffff8801aafbf1a0
---[ end trace 85601a98bc340fd3 ]---


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
