Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752898AbeDCRBH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 13:01:07 -0400
Received: from mail-io0-f197.google.com ([209.85.223.197]:46618 "EHLO
        mail-io0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752501AbeDCRBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 13:01:02 -0400
X-Google-Smtp-Source: AIpwx4/n5clm9K8uK7TIiPWuqr9T6bPxt15VjnOqMPawc8ehbtmDj3U/ypru8KfdG9kDTTHQGSPVTCy15UMXoeijQThwcNc9iPkU
MIME-Version: 1.0
Date: Tue, 03 Apr 2018 10:01:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b696800568f4a6c6@google.com>
Subject: KASAN: global-out-of-bounds Write in string
From: syzbot <syzbot+b890b3335a4d8c608963@syzkaller.appspotmail.com>
To: dhowells@redhat.com, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot hit the following crash on upstream commit
642e7fd23353e22290e3d51719fcb658dc252342 (Tue Apr 3 04:22:12 2018 +0000)
Merge branch 'syscalls-next' of  
git://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=b890b3335a4d8c608963

syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=4698588919627776
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=5456053378482176
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=-6874493495260513980
compiler: gcc (GCC) 7.1.1 20170620

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b890b3335a4d8c608963@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

IPVS: ftp: loaded support on port[0] = 21
REISERFS warning (device loop0): sh-2021 reiserfs_fill_super: can not find  
reiserfs on loop0
syz-executor0 (4503) used greatest stack depth: 15560 bytes left
REISERFS warning (device loop0): sh-2021 reiserfs_fill_super: can not find  
reiserfs on loop0
==================================================================
BUG: KASAN: global-out-of-bounds in string+0x1cb/0x200 lib/vsprintf.c:598
Write of size 1 at addr ffffffff89e166a0 by task syz-executor0/4522

CPU: 1 PID: 4522 Comm: syz-executor0 Not tainted 4.16.0+ #12
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:17 [inline]
  dump_stack+0x1a7/0x27d lib/dump_stack.c:53
  print_address_description+0x178/0x250 mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report+0x23c/0x360 mm/kasan/report.c:412
  __asan_report_store1_noabort+0x17/0x20 mm/kasan/report.c:435
  string+0x1cb/0x200 lib/vsprintf.c:598
  vsnprintf+0x863/0x1900 lib/vsprintf.c:2282
  vsprintf+0x2a/0x40 lib/vsprintf.c:2462
  prepare_error_buf+0x1d2/0x1820 fs/reiserfs/prints.c:240
  __reiserfs_warning+0xc8/0x1a0 fs/reiserfs/prints.c:267
  reiserfs_getopt fs/reiserfs/super.c:1044 [inline]
  reiserfs_parse_options+0x11e5/0x24e0 fs/reiserfs/super.c:1194
  reiserfs_fill_super+0x520/0x33a0 fs/reiserfs/super.c:1946
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
RIP: 0033:0x457d0a
RSP: 002b:00007f0655cddbb8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000000 RCX: 0000000000457d0a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f0655cddc00
RBP: 0000000000000004 R08: 0000000020013f00 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000005
R13: 000000000000066d R14: 00000000006fcad8 R15: 0000000000000001

The buggy address belongs to the variable:
  error_buf+0x400/0x420

Memory state around the buggy address:
  ffffffff89e16580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffffffff89e16600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffffffff89e16680: 00 00 00 00 fa fa fa fa 04 fa fa fa fa fa fa fa
                                ^
  ffffffff89e16700: 00 fa fa fa fa fa fa fa 00 fa fa fa fa fa fa fa
  ffffffff89e16780: 00 fa fa fa fa fa fa fa 00 fa fa fa fa fa fa fa
==================================================================


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
