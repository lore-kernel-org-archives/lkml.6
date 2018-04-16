Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754157AbeDPIuF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 04:50:05 -0400
Received: from mail-io0-f197.google.com ([209.85.223.197]:50244 "EHLO
        mail-io0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754037AbeDPIuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 04:50:03 -0400
X-Google-Smtp-Source: AIpwx49YAu6RxyD4312tEpPTjigSRVvbRtylMoB7kRW8gsi5oKsmno4oEq+yWra387ZPmyEBx96NdfsAz9XdHZPM3o96qOUa/yH1
MIME-Version: 1.0
Date: Mon, 16 Apr 2018 01:50:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <001a113ef9b8bb27870569f34e94@google.com>
Subject: KASAN: use-after-free Read in llc_conn_ac_send_sabme_cmd_p_set_x
From: syzbot <syzbot+6e181fc95081c2cf9051@syzkaller.appspotmail.com>
To: davem@davemloft.net, keescook@chromium.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot hit the following crash on upstream commit
18b7fd1c93e5204355ddbf2608a097d64df81b88 (Sat Apr 14 15:50:50 2018 +0000)
Merge branch 'akpm' (patches from Andrew)
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=6e181fc95081c2cf9051

Unfortunately, I don't have any reproducer for this crash yet.
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=5257422885093376
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=-8852471259444315113
compiler: gcc (GCC) 8.0.1 20180413 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+6e181fc95081c2cf9051@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

XFS (loop1): Invalid superblock magic number
==================================================================
BUG: KASAN: use-after-free in  
llc_conn_ac_send_sabme_cmd_p_set_x+0x3a8/0x460 net/llc/llc_c_ac.c:785
Read of size 1 at addr ffff88018be1a290 by task syz-executor7/13726

CPU: 0 PID: 13726 Comm: syz-executor7 Not tainted 4.16.0+ #3
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
  __asan_report_load1_noabort+0x14/0x20 mm/kasan/report.c:430
  llc_conn_ac_send_sabme_cmd_p_set_x+0x3a8/0x460 net/llc/llc_c_ac.c:785
  llc_exec_conn_trans_actions net/llc/llc_conn.c:475 [inline]
  llc_conn_service net/llc/llc_conn.c:400 [inline]
  llc_conn_state_process+0x4e1/0x13a0 net/llc/llc_conn.c:75
  llc_backlog_rcv+0x195/0x1e0 net/llc/llc_conn.c:891
  sk_backlog_rcv include/net/sock.h:909 [inline]
  __release_sock+0x12f/0x3a0 net/core/sock.c:2335
  release_sock+0xa4/0x2b0 net/core/sock.c:2850
  llc_ui_release+0xc8/0x220 net/llc/af_llc.c:204
  sock_release+0x96/0x1b0 net/socket.c:594
  sock_close+0x16/0x20 net/socket.c:1149
  __fput+0x34d/0x890 fs/file_table.c:209
  ____fput+0x15/0x20 fs/file_table.c:243
  task_work_run+0x1e4/0x290 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x1aee/0x2730 kernel/exit.c:865
  do_group_exit+0x16f/0x430 kernel/exit.c:968
  SYSC_exit_group kernel/exit.c:979 [inline]
  SyS_exit_group+0x1d/0x20 kernel/exit.c:977
  do_syscall_64+0x29e/0x9d0 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x455319
RSP: 002b:00007ffc740e5db8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00000000000000c4 RCX: 0000000000455319
RDX: 00000000000274e8 RSI: 0000000000730500 RDI: 0000000000000000
RBP: 0000000000000013 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000013
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000001380

Allocated by task 13728:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_trace+0x152/0x780 mm/slab.c:3620
  kmalloc include/linux/slab.h:512 [inline]
  kzalloc include/linux/slab.h:701 [inline]
  llc_sap_alloc net/llc/llc_core.c:35 [inline]
  llc_sap_open+0x193/0x4d0 net/llc/llc_core.c:102
  llc_ui_bind+0xb8c/0xef0 net/llc/af_llc.c:354
  __sys_bind+0x331/0x440 net/socket.c:1484
  SYSC_bind net/socket.c:1495 [inline]
  SyS_bind+0x24/0x30 net/socket.c:1493
  do_syscall_64+0x29e/0x9d0 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7

Freed by task 13726:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xd9/0x260 mm/slab.c:3813
  llc_sap_close+0x1d8/0x2d0 net/llc/llc_core.c:132
  llc_sap_put include/net/llc.h:124 [inline]
  llc_sap_remove_socket+0x460/0x5b0 net/llc/llc_conn.c:760
  llc_ui_release+0x1de/0x220 net/llc/af_llc.c:203
  sock_release+0x96/0x1b0 net/socket.c:594
  sock_close+0x16/0x20 net/socket.c:1149
  __fput+0x34d/0x890 fs/file_table.c:209
  ____fput+0x15/0x20 fs/file_table.c:243
  task_work_run+0x1e4/0x290 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x1aee/0x2730 kernel/exit.c:865
  do_group_exit+0x16f/0x430 kernel/exit.c:968
  SYSC_exit_group kernel/exit.c:979 [inline]
  SyS_exit_group+0x1d/0x20 kernel/exit.c:977
  do_syscall_64+0x29e/0x9d0 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7

The buggy address belongs to the object at ffff88018be1a280
  which belongs to the cache kmalloc-2048 of size 2048
The buggy address is located 16 bytes inside of
  2048-byte region [ffff88018be1a280, ffff88018be1aa80)
The buggy address belongs to the page:
page:ffffea00062f8680 count:1 mapcount:0 mapping:ffff88018be1a280 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000008100(slab|head)
raw: 02fffc0000008100 ffff88018be1a280 0000000000000000 0000000100000003
raw: ffffea00062f7ea0 ffffea00062f88a0 ffff8801dac00c40 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff88018be1a180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff88018be1a200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff88018be1a280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                          ^
  ffff88018be1a300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88018be1a380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
To mark this as a duplicate of another syzbot report, please reply with:
#syz dup: exact-subject-of-another-report
If it's a one-off invalid bug report, please reply with:
#syz invalid
Note: if the crash happens again, it will cause creation of a new bug  
report.
Note: all commands must start from beginning of the line in the email body.
