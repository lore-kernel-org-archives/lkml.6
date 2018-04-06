Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751984AbeDFTCI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 15:02:08 -0400
Received: from mail-it0-f71.google.com ([209.85.214.71]:39247 "EHLO
        mail-it0-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751435AbeDFTCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 15:02:02 -0400
X-Google-Smtp-Source: AIpwx48XKw+XMzw+3L9DqaBz0dwOMiluB4liSnKI91m5Ved4ZfBu+rbR3/88n1xJJIacvxbvrL4jrQOA8yJuVfr1f6LKXVBNMSe3
MIME-Version: 1.0
Date: Fri, 06 Apr 2018 12:02:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <001a11449424f11322056932b09c@google.com>
Subject: kernel BUG at drivers/vhost/vhost.c:LINE! (2)
From: syzbot <syzbot+65a84dde0214b0387ccd@syzkaller.appspotmail.com>
To: jasowang@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mst@redhat.com, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot hit the following crash on upstream commit
38c23685b273cfb4ccf31a199feccce3bdcb5d83 (Fri Apr 6 04:29:35 2018 +0000)
Merge tag 'armsoc-drivers' of  
git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=65a84dde0214b0387ccd

So far this crash happened 4 times on upstream.
C reproducer: https://syzkaller.appspot.com/x/repro.c?id=6586748079439872
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=5974272052822016
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=6224632407392256
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=-5813481738265533882
compiler: gcc (GCC) 8.0.1 20180301 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+65a84dde0214b0387ccd@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

------------[ cut here ]------------
kernel BUG at drivers/vhost/vhost.c:1652!
invalid opcode: 0000 [#1] SMP KASAN
------------[ cut here ]------------
Dumping ftrace buffer:
kernel BUG at drivers/vhost/vhost.c:1652!
    (ftrace buffer empty)
Modules linked in:
CPU: 1 PID: 4461 Comm: syzkaller684218 Not tainted 4.16.0+ #3
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:set_bit_to_user drivers/vhost/vhost.c:1652 [inline]
RIP: 0010:log_write+0x42a/0x4d0 drivers/vhost/vhost.c:1676
RSP: 0018:ffff8801b256f920 EFLAGS: 00010293
RAX: ffff8801adc9e2c0 RBX: dffffc0000000000 RCX: ffffffff85924a0f
RDX: 0000000000000000 RSI: ffffffff85924cea RDI: 0000000000000005
RBP: ffff8801b256fa58 R08: ffff8801adc9e2c0 R09: ffffed003962412d
R10: ffff8801b256fad8 R11: ffff8801cb12096f R12: 0001ffffffffffff
R13: ffffed00364adf36 R14: 0000000000000000 R15: ffff8801b256fa30
FS:  00007fdf24b19700(0000) GS:ffff8801db100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020bf6000 CR3: 00000001ae6a7000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  vhost_update_used_flags+0x3af/0x4a0 drivers/vhost/vhost.c:1723
  vhost_vq_init_access+0x117/0x590 drivers/vhost/vhost.c:1763
  vhost_vsock_start drivers/vhost/vsock.c:446 [inline]
  vhost_vsock_dev_ioctl+0x751/0x920 drivers/vhost/vsock.c:678
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:500 [inline]
  do_vfs_ioctl+0x1cf/0x1650 fs/ioctl.c:684
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
  SYSC_ioctl fs/ioctl.c:708 [inline]
  SyS_ioctl+0x24/0x30 fs/ioctl.c:706
  do_syscall_64+0x29e/0x9d0 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x4456c9
RSP: 002b:00007fdf24b18da8 EFLAGS: 00000297 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000006dac24 RCX: 00000000004456c9
RDX: 0000000020f82ffc RSI: 000000004004af61 RDI: 000000000000001b
RBP: 00000000006dac20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000297 R12: 6b636f73762d7473
R13: 6f68762f7665642f R14: fffffffffffffffc R15: 0000000000000007
Code: e8 7c 5e e4 fb 4c 89 ef e8 e4 16 06 fc 48 8d 85 58 ff ff ff 48 c1 e8  
03 c6 04 18 f8 e9 46 ff ff ff 45 31 f6 eb 91 e8 56 5e e4 fb <0f> 0b e8 4f  
5e e4 fb 48 c7 c6 a0 a3 24 88 4c 89 ef e8 60 b6 10
RIP: set_bit_to_user drivers/vhost/vhost.c:1652 [inline] RSP:  
ffff8801b256f920
RIP: log_write+0x42a/0x4d0 drivers/vhost/vhost.c:1676 RSP: ffff8801b256f920
invalid opcode: 0000 [#2] SMP KASAN
---[ end trace 0d0ff45aa44d8a23 ]---
Dumping ftrace buffer:
    (ftrace buffer empty)
Modules linked in:


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
