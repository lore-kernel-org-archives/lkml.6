Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031511AbeEZJOF (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 05:14:05 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:43329 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031455AbeEZJOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 05:14:03 -0400
X-Google-Smtp-Source: ADUXVKLHG3iKl8PpEGQlqQ5LjmIZ9JtBR8g6jGh+Wb8Ib+QUdEFRhdPW3c7r/J3nKo5K6Vi/2Axxxsh16xCmdDElxBQ4xkprZwL9
MIME-Version: 1.0
Date: Sat, 26 May 2018 02:14:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000038fc49056d184ebf@google.com>
Subject: general protection fault in sock_do_ioctl
From: syzbot <syzbot+09b980aff7b322aac68d@syzkaller.appspotmail.com>
To: davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    62c8a069b510 net: mvpp2: Add missing VLAN tag detection
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10ad5827800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b632d8e2c2ab2c1
dashboard link: https://syzkaller.appspot.com/bug?extid=09b980aff7b322aac68d
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+09b980aff7b322aac68d@syzkaller.appspotmail.com

  __sys_sendmsg+0x115/0x270 net/socket.c:2155
kasan: CONFIG_KASAN_INLINE enabled
  __do_sys_sendmsg net/socket.c:2164 [inline]
  __se_sys_sendmsg net/socket.c:2162 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2162
kasan: GPF could be caused by NULL-ptr deref or user memory access
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
general protection fault: 0000 [#1] SMP KASAN
Dumping ftrace buffer:
    (ftrace buffer empty)
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
Modules linked in:
RIP: 0033:0x455a09
RSP: 002b:00007f7f8526bc68 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
CPU: 0 PID: 8176 Comm: syz-executor2 Not tainted 4.17.0-rc4+ #53
RAX: ffffffffffffffda RBX: 00007f7f8526c6d4 RCX: 0000000000455a09
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RDX: 0000000000000000 RSI: 00000000200019c0 RDI: 0000000000000013
RIP: 0010:smc_tx_prepared_sends net/smc/smc_tx.h:27 [inline]
RIP: 0010:smc_ioctl+0x6db/0x9f0 net/smc/af_smc.c:1506
RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
RSP: 0018:ffff8801afe4f770 EFLAGS: 00010202
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000014
R13: 000000000000059b R14: 00000000006fc728 R15: 0000000000000005
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: dffffc0000000000
RDX: 0000000000000004 RSI: 1ffff10035fc9f0d RDI: 0000000000000020
RBP: ffff8801afe4f9d0 R08: ffffed0035fc9f0e R09: ffffed0035fc9f0d
R10: ffffed0035fc9f0d R11: ffff8801afe4f86f R12: 1ffff10035fc9ef1
R13: 00000000200003c0 R14: ffff8801afe4f868 R15: ffff8801afe4f828
FS:  00007f6710832700(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000007270dc CR3: 00000001c83ae000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  sock_do_ioctl+0xe4/0x3e0 net/socket.c:957
  sock_ioctl+0x30d/0x680 net/socket.c:1081
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:500 [inline]
  do_vfs_ioctl+0x1cf/0x16a0 fs/ioctl.c:684
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
  __do_sys_ioctl fs/ioctl.c:708 [inline]
  __se_sys_ioctl fs/ioctl.c:706 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:706
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 0
CPU: 1 PID: 8189 Comm: syz-executor5 Not tainted 4.17.0-rc4+ #53
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
Call Trace:
RIP: 0033:0x455a09
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
RSP: 002b:00007f6710831c68 EFLAGS: 00000246
  ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f67108326d4 RCX: 0000000000455a09
  fail_dump lib/fault-inject.c:51 [inline]
  should_fail.cold.4+0xa/0x1a lib/fault-inject.c:149
RDX: 00000000200003c0 RSI: 000000000000894b RDI: 0000000000000013
RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 000000000000044c R14: 00000000006fa7c0 R15: 0000000000000000
Code:
f8
48
c1
e8
03
80
3c
10
00
0f
85
ed
01
00
00
48
8b
9b
  __should_failslab+0x124/0x180 mm/failslab.c:32
90
  should_failslab+0x9/0x14 mm/slab_common.c:1522
04
  slab_pre_alloc_hook mm/slab.h:423 [inline]
  slab_alloc mm/slab.c:3378 [inline]
  kmem_cache_alloc+0x47/0x760 mm/slab.c:3552
00
00
48
  kmem_cache_zalloc include/linux/slab.h:691 [inline]
  fill_pool lib/debugobjects.c:134 [inline]
  __debug_object_init+0xbc0/0x12c0 lib/debugobjects.c:377
b8
00
00
00
00
00 fc
ff
df
48
8d
7b
20
48
89
fa
48
c1
ea
03
<0f>
b6
04
02
84
c0
74
08
3c
03
  debug_object_init+0x16/0x20 lib/debugobjects.c:429
0f
  debug_timer_init kernel/time/timer.c:704 [inline]
  debug_init kernel/time/timer.c:757 [inline]
  init_timer_key+0xa1/0x470 kernel/time/timer.c:806
8e
b7
01
00
00
  sctp_association_init net/sctp/associola.c:152 [inline]
  sctp_association_new+0xa90/0x2170 net/sctp/associola.c:312
8b
43
20
49
8d
RIP: smc_tx_prepared_sends net/smc/smc_tx.h:27 [inline] RSP:  
ffff8801afe4f770
RIP: smc_ioctl+0x6db/0x9f0 net/smc/af_smc.c:1506 RSP: ffff8801afe4f770
---[ end trace ed404e46621ff58c ]---


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
