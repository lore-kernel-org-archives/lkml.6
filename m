Return-Path: <3y_O_WgkbAI4AGH2s33w9s770v.y66y3wCAw9u65Bw5B.u64@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522529228; cv=none;
        d=google.com; s=arc-20160816;
        b=a7DHESEmUz7in1DsGc/8EMlUN+nGhyMtawEwKRfj6I0XW2+r+8jPeUSyp2BqQY7sPE
         WXTBhiikcxPc6mqq7dG8tKPFYv/TMffmeIn1vFMGs1BbnfmqMRo9UgnlXuCOsvUYPzmo
         dk+Q0sWkZqgeN9N3/crmtmGOA10f57DcxsCzEKeBz0sI+6BvEIccL0fGITq94/tKV7X3
         avV1MN5NIEIuPPFDiQglMC4hcI5K38yfujCCxd0+GbvANtS/BoSjYImcNuYZubyN6yEH
         1Noa4T/lkOZ/HgSJjg0pXMFGaKH5HxSF8zXeolRDixpo1C+e/QN1Vk1xNM6GKZbL3+cl
         BiTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:from:subject:message-id:date:mime-version
         :arc-authentication-results;
        bh=Tmfn7RgNkHCpYphrDYKPrIgrSnPhNLreE0ca9HZ23/g=;
        b=BzlE28GhWnTCy8n0x/0YxAjMjUHRie9njTbmisGRnasF+EulJYXAt/kTq+EmyqFwCC
         Q+uRSi1FfpMNsVSmdir5dRxqz2/SMJiO+mmkKe2JPLYlm7tCiXhdTIvYW1fm+3d7ylrY
         FW1Cqg4HZ2c5cqFl2ViRZvSV33KGydZrkVfpCTQXpbSCwWi2fP9mCscAM1zayzuazAPZ
         4WAfJDW0Y4JoAbrlZXds9tHKeCH9EvkjObzK0TBr4Ld/2o7XQH8wr+8ZdRWesuBU0qET
         GQu3HFj2tVVwua+Y/tBhF8Xe1RKRJj+p2s4fFy+BF3YBnZgH9mQsMjXEZGB5PMAuAdWG
         mEWQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of 3y_o_wgkbai4agh2s33w9s770v.y66y3wcaw9u65bw5b.u64@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com designates 209.85.220.69 as permitted sender) smtp.mailfrom=3y_O_WgkbAI4AGH2s33w9s770v.y66y3wCAw9u65Bw5B.u64@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=appspotmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of 3y_o_wgkbai4agh2s33w9s770v.y66y3wcaw9u65bw5b.u64@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com designates 209.85.220.69 as permitted sender) smtp.mailfrom=3y_O_WgkbAI4AGH2s33w9s770v.y66y3wCAw9u65Bw5B.u64@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=appspotmail.com
X-Google-Smtp-Source: AIpwx4/gi2kY3Kpx59Wx3egXUmWZ1Hi7hbKfhClOLsMF4Nk2W+qy3IU1vhMkwM8MJM3ZsN+JjqL1YtdFLPz8O38D9Co1MxRG58nS
MIME-Version: 1.0
Date: Sat, 31 Mar 2018 13:47:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <f403043cbe84c408e40568bb7581@google.com>
Subject: general protection fault in hfs_find_init
From: syzbot <syzbot+7ca256d0da4af073b2e2@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, kstewart@linuxfoundation.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	pombredanne@nexb.com, syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596487607750660102?=
X-GMAIL-MSGID: =?utf-8?q?1596487607750660102?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello,

syzbot hit the following crash on upstream commit
10b84daddbec72c6b440216a69de9a9605127f7a (Sat Mar 31 17:59:00 2018 +0000)
Merge branch 'perf-urgent-for-linus' of  
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=7ca256d0da4af073b2e2

C reproducer: https://syzkaller.appspot.com/x/repro.c?id=5475665407115264
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=5340549896732672
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=5639884018548736
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=-2760467897697295172
compiler: gcc (GCC) 7.1.1 20170620

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+7ca256d0da4af073b2e2@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

hfs: unable to locate alternate MDB
hfs: continuing without an alternate MDB
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
Dumping ftrace buffer:
    (ftrace buffer empty)
Modules linked in:
CPU: 0 PID: 4467 Comm: syzkaller143800 Not tainted 4.16.0-rc7+ #9
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:hfs_find_init+0x76/0x180 fs/hfs/bfind.c:21
RSP: 0018:ffff8801acbe6bd0 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff8801acbe6c58 RCX: ffffffff820dd056
RDX: 0000000000000008 RSI: ffff8801acbe6c58 RDI: ffff8801acbe6c70
RBP: ffff8801acbe6bf0 R08: ffffffff820f0430 R09: 0000000000000000
R10: ffff8801acbe6ce0 R11: ffffed003597cc6f R12: 0000000000000000
R13: 0000000000000040 R14: ffff8801ad972080 R15: ffff8801acbe6cb8
FS:  0000000001e2d880(0000) GS:ffff8801db000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe9b457a9b8 CR3: 00000001ac89e004 CR4: 00000000001606f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  hfs_ext_read_extent+0x197/0xb50 fs/hfs/extent.c:196
  hfs_get_block+0x4cc/0x7a0 fs/hfs/extent.c:360
  block_read_full_page+0x293/0x990 fs/buffer.c:2259
  hfs_readpage+0x1c/0x20 fs/hfs/inode.c:38
  do_read_cache_page+0x637/0x11b0 mm/filemap.c:2804
  read_cache_page+0x61/0x80 mm/filemap.c:2892
  read_mapping_page include/linux/pagemap.h:402 [inline]
  hfs_btree_open+0x536/0x1630 fs/hfs/btree.c:78
  hfs_mdb_get+0x16ab/0x22c0 fs/hfs/mdb.c:193
  hfs_fill_super+0x1023/0x1930 fs/hfs/super.c:413
  mount_bdev+0x2b7/0x370 fs/super.c:1119
  hfs_mount+0x34/0x40 fs/hfs/super.c:463
  mount_fs+0x66/0x2d0 fs/super.c:1222
  vfs_kern_mount.part.26+0xc6/0x4a0 fs/namespace.c:1037
  vfs_kern_mount fs/namespace.c:2509 [inline]
  do_new_mount fs/namespace.c:2512 [inline]
  do_mount+0xea4/0x2bb0 fs/namespace.c:2842
  SYSC_mount fs/namespace.c:3058 [inline]
  SyS_mount+0xab/0x120 fs/namespace.c:3035
  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x442daa
RSP: 002b:00007ffd0232faf8 EFLAGS: 00000297 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000258 RCX: 0000000000442daa
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffd0232fb00
RBP: 0000000000000003 R08: 00000000200001c0 R09: 000000000000000a
R10: 0000000000000000 R11: 0000000000000297 R12: 0000000000000004
R13: 0000000000401ca0 R14: 0000000000000000 R15: 0000000000000000
Code: c1 ea 03 80 3c 02 00 0f 85 f2 00 00 00 4d 8d 6c 24 40 48 b8 00 00 00  
00 00 fc ff df 48 c7 43 18 00 00 00 00 4c 89 ea 48 c1 ea 03 <0f> b6 04 02  
84 c0 74 08 3c 03 0f 8e b0 00 00 00 41 8b 44 24 40
RIP: hfs_find_init+0x76/0x180 fs/hfs/bfind.c:21 RSP: ffff8801acbe6bd0
---[ end trace 5617fd7a7b5bfbcd ]---


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
