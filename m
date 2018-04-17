Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751256AbeDQHYG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 03:24:06 -0400
Received: from mail-io0-f198.google.com ([209.85.223.198]:49646 "EHLO
        mail-io0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751118AbeDQHYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 03:24:03 -0400
X-Google-Smtp-Source: AIpwx4/8YmtyIcPjJFxb6nYqN4hxn4bTENJtAAhtfXYvsDE3vNvT9HOWChF7/7Br/a3ZFZggziPQ3n5uw/6nhHX8aE5UsbsUh1Ug
MIME-Version: 1.0
Date: Tue, 17 Apr 2018 00:24:02 -0700
In-Reply-To: <000000000000b696800568f4a6c6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <001a1139d0ba06bddf056a063986@google.com>
Subject: Re: KASAN: global-out-of-bounds Write in string
From: syzbot <syzbot+b890b3335a4d8c608963@syzkaller.appspotmail.com>
To: dhowells@redhat.com, linux-kernel@vger.kernel.org,
        penguin-kernel@I-love.SAKURA.ne.jp, reiserfs-devel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found reproducer for the following crash on upstream commit
a27fc14219f2e3c4a46ba9177b04d9b52c875532 (Mon Apr 16 21:07:39 2018 +0000)
Merge branch 'parisc-4.17-3' of  
git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=b890b3335a4d8c608963

So far this crash happened 3 times on upstream.
C reproducer: https://syzkaller.appspot.com/x/repro.c?id=4639432657338368
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=5739177354199040
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=5837965024559104
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=-5914490758943236750
compiler: gcc (GCC) 8.0.1 20180413 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b890b3335a4d8c608963@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed.

VFS: Can't find a Minix filesystem V1 | V2 | V3 on device loop5.
==================================================================
BUG: KASAN: global-out-of-bounds in string+0x291/0x2c0 lib/vsprintf.c:608
Write of size 1 at addr ffffffff8a5405c0 by task syzkaller915239/4487

CPU: 1 PID: 4487 Comm: syzkaller915239 Not tainted 4.17.0-rc1+ #6
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
  __asan_report_store1_noabort+0x17/0x20 mm/kasan/report.c:435
  string+0x291/0x2c0 lib/vsprintf.c:608
  vsnprintf+0x4b7/0x1b40 lib/vsprintf.c:2292
  vsprintf+0x2a/0x40 lib/vsprintf.c:2472
  prepare_error_buf+0x23b/0x1aa0 fs/reiserfs/prints.c:240
  __reiserfs_warning+0xb0/0xd0 fs/reiserfs/prints.c:267
  reiserfs_getopt fs/reiserfs/super.c:1044 [inline]
  reiserfs_parse_options+0x11f4/0x27f0 fs/reiserfs/super.c:1194
  reiserfs_fill_super+0x520/0x3900 fs/reiserfs/super.c:1946
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
RIP: 0033:0x448bca
RSP: 002b:00007f33571ccc68 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000040 RCX: 0000000000448bca
RDX: 0000000020000000 RSI: 0000000020000040 RDI: 00007f33571ccc80
RBP: 0000000000000004 R08: 0000000020000380 R09: 000000000000000a
R10: 0000000001000000 R11: 0000000000000202 R12: 0000000000000043
R13: 0000000000000044 R14: 0000000001000000 R15: 0000000000000004

The buggy address belongs to the variable:
  error_buf+0x400/0x420

Memory state around the buggy address:
  ffffffff8a540480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffffffff8a540500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffffffff8a540580: 00 00 00 00 00 00 00 00 fa fa fa fa 04 fa fa fa
                                            ^
  ffffffff8a540600: fa fa fa fa 00 fa fa fa fa fa fa fa 00 fa fa fa
  ffffffff8a540680: fa fa fa fa 00 fa fa fa fa fa fa fa 00 fa fa fa
==================================================================
