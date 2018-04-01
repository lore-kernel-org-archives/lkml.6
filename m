Return-Path: <3TxDBWgkbAFAAGH2s33w9s770v.y66y3wCAw9u65Bw5B.u64@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522602063; cv=none;
        d=google.com; s=arc-20160816;
        b=pkHG5byH0Cu32XLUv3a8NMg//74tUngxmKF2I+4ugY/Zr4cCZyIT1T2bJFTCrFyRU7
         iprB605mdv+U6CZSHVPo6fKrmDoSa6dEc+sm+w/wu0DJ4uNMYhdhvBP3AwALKdjd4cv0
         EOINJBtZuzvCNwyMfQCBmhqyNOnesWEjN58l5InIZsXwxiNe/mtYSa8LtOiyBkrRf9bN
         7GI1pGx60oqhCs61//IQ3W93PVPvnIiWjas1DFW/uwsAMJ3dddcUER2/nv51NxiS2zkr
         wK/fFSA+BbGOH3Uucikm01/4CxwSWDrmsP2r9oCGm2VD2l0urceEgEclmMsOM/QmxnYb
         P3GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:from:subject:message-id:date:mime-version
         :arc-authentication-results;
        bh=Fc5RQueFSyo8KxoNLhRbwdm/omzbSdAqKIrWJCP/Vus=;
        b=JiBzK+RB8Jw3H22HtOU6bJb0RG8N7uki1TMbP9mC2BRqHnnmclsuEv4ChyM1Nm47dB
         cPSMCmDB4sOD7XYzFQ6Z94XdOVpy3xpCZsGrYJmbCf5vyJT2uQRLUfxSGnZn6phu0azS
         1eFGfy+UU3O6OI9em7gYe+brI9O/EjrHOzdryRoyVt93an25fyURdQXSQNUqk5Qry2h1
         eq9kKaKY4+s5J/pyu7rmnprVpAkFWMMboaxgdIz1yPaEaLOnt6F/DIkUM9jW73gHgcnl
         0PP5Xx+nzJ9+5lum5odYegQ4Q3Mi69gSzcJAoRUoxnMVbOZkzsigxvNCEQrPaqBJ08RN
         yWLQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of 3txdbwgkbafaagh2s33w9s770v.y66y3wcaw9u65bw5b.u64@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com designates 209.85.220.69 as permitted sender) smtp.mailfrom=3TxDBWgkbAFAAGH2s33w9s770v.y66y3wCAw9u65Bw5B.u64@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=appspotmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of 3txdbwgkbafaagh2s33w9s770v.y66y3wcaw9u65bw5b.u64@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com designates 209.85.220.69 as permitted sender) smtp.mailfrom=3TxDBWgkbAFAAGH2s33w9s770v.y66y3wCAw9u65Bw5B.u64@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=appspotmail.com
X-Google-Smtp-Source: AIpwx48rg8C4mVk0U3VUMu4O4D2+C4YEahDVWM+/WpYQ8m6etqoa4h9KGvL8VRamj2sS+7pVY3db6c1W0Y+ihpVzqho3/QckM+Rh
MIME-Version: 1.0
Date: Sun, 01 Apr 2018 10:01:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <001a1140e9201dd16b0568cc6beb@google.com>
Subject: BUG: unable to handle kernel paging request in cleanup_bitmap_list
From: syzbot <syzbot+008ac33be9dec51e0ca3@syzkaller.appspotmail.com>
To: colin.king@canonical.com, dhowells@redhat.com, gregkh@linuxfoundation.org,
	jack@suse.cz, linux-kernel@vger.kernel.org, mingo@kernel.org,
	pombredanne@nexb.com, reiserfs-devel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596563981441211634?=
X-GMAIL-MSGID: =?utf-8?q?1596563981441211634?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello,

syzbot hit the following crash on upstream commit
10b84daddbec72c6b440216a69de9a9605127f7a (Sat Mar 31 17:59:00 2018 +0000)
Merge branch 'perf-urgent-for-linus' of  
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=008ac33be9dec51e0ca3

syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=4931687263764480
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=5716877078691840
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=-2760467897697295172
compiler: gcc (GCC) 7.1.1 20170620

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+008ac33be9dec51e0ca3@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

REISERFS warning (device loop0): sh-2022 reiserfs_fill_super: unable to  
initialize journal space
REISERFS warning (device loop6): sh-462 journal_init: unable to initialize  
journal device
REISERFS warning (device loop6): sh-2022 reiserfs_fill_super: unable to  
initialize journal space
REISERFS warning (device loop3): sh-458 journal_init_dev: cannot init  
journal device 'unknown-block(11,0)': -6
REISERFS warning (device loop3): sh-462 journal_init: unable to initialize  
journal device
BUG: unable to handle kernel paging request at ffffc90004d59000
IP: cleanup_bitmap_list.isra.7.part.8+0x3dd/0x6b0 fs/reiserfs/journal.c:233
PGD 1dad42067 P4D 1dad42067 PUD 1dad43067 PMD 1bb5df067 PTE 0
Oops: 0000 [#1] SMP KASAN
Dumping ftrace buffer:
    (ftrace buffer empty)
Modules linked in:
CPU: 0 PID: 6581 Comm: syz-executor3 Not tainted 4.16.0-rc7+ #9
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:cleanup_bitmap_list.isra.7.part.8+0x3dd/0x6b0  
fs/reiserfs/journal.c:233
RSP: 0018:ffff8801b28770e8 EFLAGS: 00010246
RAX: 0000000000001000 RBX: dffffc0000000000 RCX: ffffc90004d542c0
RDX: 1ffff920009ab200 RSI: 0000000000008000 RDI: 0000000000000001
RBP: ffff8801b28771c0 R08: 1ffff1003650edf3 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffc90004d59000
R13: 0000000000000200 R14: ffff8801b102d6c0 R15: ffff8801b0420080
FS:  00007fa5317af700(0000) GS:ffff8801db000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90004d59000 CR3: 00000001b8324005 CR4: 00000000001606f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  cleanup_bitmap_list fs/reiserfs/journal.c:229 [inline]
  free_list_bitmaps+0x6f/0xf0 fs/reiserfs/journal.c:251
  free_journal_ram+0x148/0x5a0 fs/reiserfs/journal.c:1894
  journal_init+0x22f6/0x62f0 fs/reiserfs/journal.c:2901
  reiserfs_fill_super+0xf9f/0x33a0 fs/reiserfs/super.c:2034
  mount_bdev+0x2b7/0x370 fs/super.c:1119
  get_super_block+0x34/0x40 fs/reiserfs/super.c:2605
  mount_fs+0x66/0x2d0 fs/super.c:1222
  vfs_kern_mount.part.26+0xc6/0x4a0 fs/namespace.c:1037
  vfs_kern_mount fs/namespace.c:2509 [inline]
  do_new_mount fs/namespace.c:2512 [inline]
  do_mount+0xea4/0x2bb0 fs/namespace.c:2842
  SYSC_mount fs/namespace.c:3058 [inline]
  SyS_mount+0xab/0x120 fs/namespace.c:3035
  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x4578aa
RSP: 002b:00007fa5317aebb8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000000 RCX: 00000000004578aa
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007fa5317aec00
RBP: 0000000000000001 R08: 0000000020011400 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000007
R13: 000000000000066d R14: 00000000006fbad8 R15: 0000000000000001
Code: ff ff 4d 63 e5 4a 8d 04 e5 00 00 00 00 4c 8b 21 48 89 85 68 ff ff ff  
49 01 c4 4c 89 e2 48 c1 ea 03 80 3c 1a 00 0f 85 76 02 00 00 <4d> 8b 24 24  
4d 85 e4 0f 84 e5 fe ff ff e8 91 6d 8c ff 49 8d 7e
RIP: cleanup_bitmap_list.isra.7.part.8+0x3dd/0x6b0  
fs/reiserfs/journal.c:233 RSP: ffff8801b28770e8
CR2: ffffc90004d59000
---[ end trace 4f9c7ebf6e463a71 ]---


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
