Return-Path: <3-RXEWgkbABIAGH2s33w9s770v.y66y3wCAw9u65Bw5B.u64@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522800121; cv=none;
        d=google.com; s=arc-20160816;
        b=IXJs5WgvTzZUMu1Jt6LZQ+oJGDWOpmZUHENOpTRpJcVUtRI3//glruu3ost1ZDKkNK
         2fOpTn1wey7IdKmjPvK2iIRgXB568zyenCk6t/18WYnz5Adl3OpOZ0tt/hGfaTwC743g
         rY7tM47jx4yhEE2VFztZIDpqctvbfnh4U6OX+6z69trrNXunYPBUDgJKIKvwM2Dntrmw
         vaqjWu+Q9Z9a5tUxayn02b3ffjIXm2KoIq8vDvLTUnpPyL9/XmALPNgsNeEkSoQ9qAcX
         jA+y25s8b4XEfF49vRyi6pKPRFQq3lgDc+hguefTCyOwjr8sO5K+oA8yg9SMhRm3FnX6
         GyXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :arc-authentication-results;
        bh=arxixZZr4dA0d9ABG4kaRb1mVfaJUacCWVOrCmDvB0k=;
        b=CgbqwOwDhZlmHik+yplkGpHg16n/mfwFQJKyI5du/Jl4OwND5KXEj2mK/1LHBz+LeX
         7ohJ0X0NXvTW4cUn6osuG0nrsNTRbiTz3tN/bXlPGYVY6Dh8qnezeR6FwA5070xt6cq3
         Og/aKa7g9JuHegKHHisBFObd9/EvoW36N1euLfNPWtgMEf9TQXSkb1+nJPGr+hWH0q81
         siUaW7B3MuE+rqp5KPbnO133FcKoXuaYbSeLkuIao/Uoqpf+KrtrpJqZHo2VVPXbpsKn
         OMH2JFQOztmjExxoWHg5vTD61BIniB7Nr6tnOD+LD66u96k4xo9IpUlmxiToNrK9K87T
         4RTg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of 3-rxewgkbabiagh2s33w9s770v.y66y3wcaw9u65bw5b.u64@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com designates 209.85.220.69 as permitted sender) smtp.mailfrom=3-RXEWgkbABIAGH2s33w9s770v.y66y3wCAw9u65Bw5B.u64@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=appspotmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of 3-rxewgkbabiagh2s33w9s770v.y66y3wcaw9u65bw5b.u64@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com designates 209.85.220.69 as permitted sender) smtp.mailfrom=3-RXEWgkbABIAGH2s33w9s770v.y66y3wCAw9u65Bw5B.u64@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=appspotmail.com
X-Google-Smtp-Source: AIpwx49anTuF/AAQduxYjcCrYPTzNKIxjbW+GLNhK0EUwoNR2j5Aii5TM2BQlBFk6RKweda03KP02lENkNi0xiWzOveJjXFouj5V
MIME-Version: 1.0
Date: Tue, 03 Apr 2018 17:02:01 -0700
In-Reply-To: <001a1140e9201dd16b0568cc6beb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <001a114ab89c4f23a90568fa88f7@google.com>
Subject: Re: BUG: unable to handle kernel paging request in cleanup_bitmap_list
From: syzbot <syzbot+008ac33be9dec51e0ca3@syzkaller.appspotmail.com>
To: colin.king@canonical.com, dhowells@redhat.com, gregkh@linuxfoundation.org,
	jack@suse.cz, kstewart@linuxfoundation.org, linux-kernel@vger.kernel.org,
	mingo@kernel.org, pombredanne@nexb.com, reiserfs-devel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596563981441211634?=
X-GMAIL-MSGID: =?utf-8?q?1596771660612776275?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

syzbot has found reproducer for the following crash on upstream commit
f2d285669aae656dfeafa0bf25e86bbbc5d22329 (Tue Apr 3 17:45:39 2018 +0000)
Merge tag 'pm-4.17-rc1' of  
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=008ac33be9dec51e0ca3

So far this crash happened 3 times on upstream.
C reproducer: https://syzkaller.appspot.com/x/repro.c?id=5967772961996800
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=4833954477637632
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=5985556743847936
Kernel config: https://syzkaller.appspot.com/x/.config?id=686016073509112605
compiler: gcc (GCC) 7.1.1 20170620

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+008ac33be9dec51e0ca3@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed.

syzkaller001137 (4456) used greatest stack depth: 15592 bytes left
REISERFS (device loop0): found reiserfs format "3.6" with non-standard  
journal
REISERFS (device loop0): using ordered data mode
reiserfs: using flush barriers
REISERFS warning (device loop0): sh-460 journal_init: journal header magic  
0 (device loop0) does not match to magic found in super block 4c3955ba
BUG: unable to handle kernel paging request at ffffc90001f23000
PGD 1dad42067 P4D 1dad42067 PUD 1dad43067 PMD 1b0857067 PTE 0
Oops: 0000 [#1] SMP KASAN
Dumping ftrace buffer:
    (ftrace buffer empty)
Modules linked in:
CPU: 0 PID: 4461 Comm: syzkaller001137 Not tainted 4.16.0+ #13
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:cleanup_bitmap_list.isra.7.part.8+0x3dd/0x6b0  
fs/reiserfs/journal.c:233
RSP: 0018:ffff8801adc7f0b0 EFLAGS: 00010246
RAX: 0000000000001000 RBX: dffffc0000000000 RCX: ffffc90001f202b0
RDX: 1ffff920003e4600 RSI: 0000000000008000 RDI: 0000000000000001
RBP: ffff8801adc7f188 R08: ffffed003b6046c3 R09: ffffed003b6046c3
R10: 0000000000000001 R11: ffffed003b6046c2 R12: ffffc90001f23000
R13: 0000000000000200 R14: ffff8801d962fb40 R15: ffff8801d9a08a80
FS:  00007f2354935700(0000) GS:ffff8801db000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001f23000 CR3: 00000001b0f93000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  cleanup_bitmap_list fs/reiserfs/journal.c:229 [inline]
  free_list_bitmaps+0x6f/0xf0 fs/reiserfs/journal.c:251
  free_journal_ram+0x148/0x5a0 fs/reiserfs/journal.c:1894
  journal_init+0x2320/0x6320 fs/reiserfs/journal.c:2901
  reiserfs_fill_super+0xf9f/0x33a0 fs/reiserfs/super.c:2034
  mount_bdev+0x2b7/0x370 fs/super.c:1119
  get_super_block+0x34/0x40 fs/reiserfs/super.c:2605
  mount_fs+0x66/0x2d0 fs/super.c:1222
  vfs_kern_mount.part.26+0xc6/0x4a0 fs/namespace.c:1037
  vfs_kern_mount fs/namespace.c:2514 [inline]
  do_new_mount fs/namespace.c:2517 [inline]
  do_mount+0xea4/0x2b90 fs/namespace.c:2847
  ksys_mount+0xab/0x120 fs/namespace.c:3063
  SYSC_mount fs/namespace.c:3077 [inline]
  SyS_mount+0x39/0x50 fs/namespace.c:3074
  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x44990a
RSP: 002b:00007f2354934cf8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000100 RCX: 000000000044990a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f2354934d10
RBP: 0000000000000004 R08: 0000000020011500 R09: 000000000000000a
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000004
R13: 0000000000000005 R14: 0000000000000000 R15: 0000000000000004
Code: ff ff 4d 63 e5 4a 8d 04 e5 00 00 00 00 4c 8b 21 48 89 85 68 ff ff ff  
49 01 c4 4c 89 e2 48 c1 ea 03 80 3c 1a 00 0f 85 76 02 00 00 <4d> 8b 24 24  
4d 85 e4 0f 84 e5 fe ff ff e8 b1 81 8c ff 49 8d 7e
RIP: cleanup_bitmap_list.isra.7.part.8+0x3dd/0x6b0  
fs/reiserfs/journal.c:233 RSP: ffff8801adc7f0b0
CR2: ffffc90001f23000
---[ end trace 834bcfee184feda9 ]---
