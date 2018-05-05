Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751793AbeEEPrK (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 11:47:10 -0400
Received: from mail-it0-f71.google.com ([209.85.214.71]:36710 "EHLO
        mail-it0-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751118AbeEEPrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 11:47:03 -0400
X-Google-Smtp-Source: AB8JxZpfaMZ8LzdNvtqCxhTtaWg5FURH8xMTJUhMNT8zA1mzzxJNy1IbRpMZgIbrxeixhSq8o+zDfGLOzh45AEUB2dL7WI0Jm83N
MIME-Version: 1.0
Date: Sat, 05 May 2018 08:47:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000390eb056b77596d@google.com>
Subject: WARNING in kernfs_add_one
From: syzbot <syzbot+df47f81c226b31d89fb1@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    8fb11a9a8d51 net/ipv6: rename rt6_next to fib6_next
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14b27237800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c416c61f3cd96be
dashboard link: https://syzkaller.appspot.com/bug?extid=df47f81c226b31d89fb1
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=172fb3e7800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16552e57800000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+df47f81c226b31d89fb1@syzkaller.appspotmail.com

RBP: 00007fff808f3e10 R08: 0000000000000002 R09: 00007fff80003534
R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffff
R13: 0000000000000006 R14: 0000000000000000 R15: 0000000000000000
------------[ cut here ]------------
kernfs: ns required in 'ieee80211' for 'phy3'
WARNING: CPU: 0 PID: 4538 at fs/kernfs/dir.c:759 kernfs_add_one+0x406/0x4d0  
fs/kernfs/dir.c:758
Kernel panic - not syncing: panic_on_warn set ...

CPU: 0 PID: 4538 Comm: syz-executor486 Not tainted 4.17.0-rc3+ #33
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
RIP: 0010:kernfs_add_one+0x406/0x4d0 fs/kernfs/dir.c:758
RSP: 0018:ffff8801ca9eece0 EFLAGS: 00010286
RAX: 000000000000002d RBX: ffffffff87d5cee0 RCX: ffffffff8160ba7d
RDX: 0000000000000000 RSI: ffffffff81610731 RDI: ffff8801ca9ee840
RBP: ffff8801ca9eed20 R08: ffff8801d9538500 R09: 0000000000000006
R10: ffff8801d9538500 R11: 0000000000000000 R12: ffff8801ad1cb6c0
R13: ffffffff885da640 R14: 0000000000000020 R15: 0000000000000000
  kernfs_create_link+0x112/0x180 fs/kernfs/symlink.c:41
  sysfs_do_create_link_sd.isra.2+0x90/0x130 fs/sysfs/symlink.c:43
  sysfs_do_create_link fs/sysfs/symlink.c:79 [inline]
  sysfs_create_link+0x65/0xc0 fs/sysfs/symlink.c:91
  device_add_class_symlinks drivers/base/core.c:1612 [inline]
  device_add+0x7a0/0x16d0 drivers/base/core.c:1810
  wiphy_register+0x178a/0x2430 net/wireless/core.c:806
  ieee80211_register_hw+0x13cd/0x35d0 net/mac80211/main.c:1047
  mac80211_hwsim_new_radio+0x1d9b/0x3410  
drivers/net/wireless/mac80211_hwsim.c:2772
  hwsim_new_radio_nl+0x7a7/0xa60 drivers/net/wireless/mac80211_hwsim.c:3246
  genl_family_rcv_msg+0x889/0x1120 net/netlink/genetlink.c:599
  genl_rcv_msg+0xc6/0x170 net/netlink/genetlink.c:624
  netlink_rcv_skb+0x172/0x440 net/netlink/af_netlink.c:2448
  genl_rcv+0x28/0x40 net/netlink/genetlink.c:635
  netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
  netlink_unicast+0x58b/0x740 net/netlink/af_netlink.c:1336
  netlink_sendmsg+0x9f0/0xfa0 net/netlink/af_netlink.c:1901
  sock_sendmsg_nosec net/socket.c:629 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:639
  ___sys_sendmsg+0x805/0x940 net/socket.c:2117
  __sys_sendmsg+0x115/0x270 net/socket.c:2155
  __do_sys_sendmsg net/socket.c:2164 [inline]
  __se_sys_sendmsg net/socket.c:2162 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2162
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4404c9
RSP: 002b:00007fff808f3e08 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004404c9
RDX: 0000000000000000 RSI: 0000000020b3dfc8 RDI: 0000000000000005
RBP: 00007fff808f3e10 R08: 0000000000000002 R09: 00007fff80003534
R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffff
R13: 0000000000000006 R14: 0000000000000000 R15: 0000000000000000
Dumping ftrace buffer:
    (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

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
