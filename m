Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753386AbeDSREE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 13:04:04 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:44998 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752294AbeDSREC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 13:04:02 -0400
X-Google-Smtp-Source: AB8JxZq75DQ88a0r5GLM52uyhU7Lb8sD38ZT1KIY+8ZMSyY1DCRJ5hFAPkPUB/n+c5EjtD8Am3YQ+ymOGfEK0UR00BLRcD2AhGBl
MIME-Version: 1.0
Date: Thu, 19 Apr 2018 10:04:02 -0700
In-Reply-To: <0000000000002ab8c5056a35b12b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ed98f1056a368e1a@google.com>
Subject: Re: WARNING in unlock_new_inode
From: syzbot <syzbot+187510916eb6a14598f7@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found reproducer for the following crash on upstream commit
87ef12027b9b1dd0e0b12cf311fbcb19f9d92539 (Wed Apr 18 19:48:17 2018 +0000)
Merge tag 'ceph-for-4.17-rc2' of git://github.com/ceph/ceph-client
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=187510916eb6a14598f7

So far this crash happened 5 times on upstream.
C reproducer: https://syzkaller.appspot.com/x/repro.c?id=5714618731200512
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=5309622306996224
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=5896539788541952
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=1808800213120130118
compiler: gcc (GCC) 8.0.1 20180413 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+187510916eb6a14598f7@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed.

reiserfs: using flush barriers
REISERFS (device loop0): journal params: device loop0, size 512, journal  
first block 18, max trans len 256, max batch 225, max commit age 30, max  
trans age 30
REISERFS (device loop0): checking transaction log (loop0)
REISERFS (device loop0): Using r5 hash to sort names
REISERFS (device loop0): using 3.5.x disk format
WARNING: CPU: 1 PID: 4507 at fs/inode.c:962 unlock_new_inode+0x107/0x130  
fs/inode.c:962
Kernel panic - not syncing: panic_on_warn set ...

CPU: 1 PID: 4507 Comm: syzkaller359861 Not tainted 4.17.0-rc1+ #8
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  panic+0x22f/0x4de kernel/panic.c:184
  __warn.cold.8+0x163/0x1b3 kernel/panic.c:536
  report_bug+0x252/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x1de/0x490 arch/x86/kernel/traps.c:296
  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:315
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:992
RIP: 0010:unlock_new_inode+0x107/0x130 fs/inode.c:962
RSP: 0018:ffff8801ac0670b8 EFLAGS: 00010293
RAX: ffff8801d02b0040 RBX: ffff8801c4661780 RCX: ffffffff81c6eb00
RDX: 0000000000000000 RSI: ffffffff81c6eb57 RDI: 0000000000000007
RBP: ffff8801ac0670e0 R08: ffff8801d02b0040 R09: ffffed00388cc301
R10: ffffed00388cc301 R11: ffff8801c466180b R12: 0000000000000000
R13: ffff8801c4661858 R14: ffff8801c4661808 R15: 0000000000000000
  reiserfs_new_inode+0x643/0x32f0 fs/reiserfs/inode.c:2159
  reiserfs_mkdir+0x4af/0x8b0 fs/reiserfs/namei.c:840
  xattr_mkdir.constprop.15+0x135/0x1a0 fs/reiserfs/xattr.c:76
  create_privroot fs/reiserfs/xattr.c:857 [inline]
  reiserfs_xattr_init+0x53d/0xa59 fs/reiserfs/xattr.c:976
  reiserfs_fill_super+0x27a0/0x3900 fs/reiserfs/super.c:2177
  mount_bdev+0x30c/0x3e0 fs/super.c:1165
  get_super_block+0x34/0x40 fs/reiserfs/super.c:2605
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
RIP: 0033:0x44306a
RSP: 002b:00007ffe74640c18 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00000000200002a0 RCX: 000000000044306a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffe74640c20
RBP: 0000000000000003 R08: 0000000020011500 R09: 000000000000000a
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000004
R13: 0000000000401f60 R14: 0000000000000000 R15: 0000000000000000
Dumping ftrace buffer:
    (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 86400 seconds..
