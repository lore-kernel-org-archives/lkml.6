Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752059AbeDXOmE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 10:42:04 -0400
Received: from mail-it0-f71.google.com ([209.85.214.71]:59885 "EHLO
        mail-it0-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750916AbeDXOmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 10:42:02 -0400
X-Google-Smtp-Source: AIpwx49NHjyc7fIXldqcyPVRuMK86p2TiWXT3mVILpz8vbEPPGATmKwAzTLNirqqoA1rwaRJ5+hz3X8DNfcJmEYzY8W1bagEkC2e
MIME-Version: 1.0
Date: Tue, 24 Apr 2018 07:42:01 -0700
In-Reply-To: <CACT4Y+b2UgpGHDdfPgu3vp1MR8feL16C=HXsQwx7TC2-3U=0Sg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000438db9056a9928d7@google.com>
Subject: Re: kernel BUG at fs/f2fs/node.c:LINE!
From: syzbot <syzbot+d154ec99402c6f628887@syzkaller.appspotmail.com>
To: dvyukov@google.com, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yuchao0@huawei.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer still triggered  
crash:
kernel BUG at fs/f2fs/inode.c:LINE!

F2FS-fs (loop5): invalid crc value
F2FS-fs (loop0): Magic Mismatch, valid(0xf2f52010) - read(0x0)
F2FS-fs (loop0): Can't find valid F2FS filesystem in 1th superblock
F2FS-fs (loop5): check_nid_range: out-of-range nid=1, run fsck to fix.
------------[ cut here ]------------
kernel BUG at fs/f2fs/inode.c:588!
invalid opcode: 0000 [#1] SMP KASAN
Dumping ftrace buffer:
    (ftrace buffer empty)
Modules linked in:
CPU: 1 PID: 4848 Comm: syz-executor5 Not tainted 4.17.0-rc1+ #1
F2FS-fs (loop0): invalid crc value
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:f2fs_evict_inode+0x1344/0x1710 fs/f2fs/inode.c:587
RSP: 0018:ffff8801bf96ef10 EFLAGS: 00010293
RAX: ffff8801abfa8040 RBX: ffff8801a8957080 RCX: ffffffff82eb2fc6
RDX: 0000000000000000 RSI: ffffffff82eb2fd4 RDI: 0000000000000001
RBP: ffff8801bf96f0f8 R08: ffff8801abfa8040 R09: ffffed003a0331b5
F2FS-fs (loop6): Magic Mismatch, valid(0xf2f52010) - read(0x0)
R10: ffffed003a0331b5 R11: ffff8801d0198dab R12: 0000000000000000
R13: 00000000ffffffea R14: 0000000000000000 R15: 0000000000000001
FS:  00007febdf624700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
F2FS-fs (loop6): Can't find valid F2FS filesystem in 1th superblock
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000002431228 CR3: 00000001d7686000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
F2FS-fs (loop0): check_nid_range: out-of-range nid=1, run fsck to fix.
Call Trace:
------------[ cut here ]------------
kernel BUG at fs/f2fs/inode.c:588!
  evict+0x4a6/0x960 fs/inode.c:557
  iput_final fs/inode.c:1519 [inline]
  iput+0x62d/0xa80 fs/inode.c:1545
  f2fs_fill_super+0x5f4e/0x7bf0 fs/f2fs/super.c:2849
  mount_bdev+0x30c/0x3e0 fs/super.c:1165
  f2fs_mount+0x34/0x40 fs/f2fs/super.c:3020
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
RIP: 0033:0x457dba
RSP: 002b:00007febdf623ba8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000000 RCX: 0000000000457dba
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007febdf623bf0
RBP: 000000000000006a R08: 0000000020016a00 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
R13: 000000000000006a R14: 00000000006fcb80 R15: 0000000000000000
Code: 5e 03 00 00 8b 73 40 4c 89 e7 31 d2 e8 c6 e1 05 00 31 ff 41 89 c4 89  
c6 e8 2a 01 8e fe 45 84 e4 0f 85 b1 f3 ff ff e8 4c 00 8e fe <0f> 0b e8 85  
5a ca fe e9 c7 ee ff ff e8 7b 5a ca fe e9 10 ef ff
RIP: f2fs_evict_inode+0x1344/0x1710 fs/f2fs/inode.c:587 RSP:  
ffff8801bf96ef10
invalid opcode: 0000 [#2] SMP KASAN
---[ end trace a8c4607d38f9047d ]---
Dumping ftrace buffer:
    (ftrace buffer empty)
Modules linked in:


Tested on  
git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/dev-test  
commit
65b966f58e8264477da6c8b70703ce362cb1f8f0 (Tue Apr 24 05:02:31 2018 +0000)
f2fs: give message and set need_fsck given broken node id

compiler: gcc (GCC) 8.0.1 20180413 (experimental)
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=1808800213120130118
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=5916974974500864
