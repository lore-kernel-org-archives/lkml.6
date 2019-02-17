Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF33C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 08:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32CE821B69
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 08:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbfBQILG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 03:11:06 -0500
Received: from mail-it1-f200.google.com ([209.85.166.200]:44398 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbfBQILF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 03:11:05 -0500
Received: by mail-it1-f200.google.com with SMTP id v12so15536839itv.9
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 00:11:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=4gO1aGt3ofJVb/VUWnJUqmPXBz8gI51s6VrbXgYPWi0=;
        b=h900zcpKyXnhpNnMFd5jOFdaEin6r4+CIb+qRZ8kFYABz3cXKvYZMVkMZK92BuAjcd
         6otgddCAuk22rQ4Io1s1e4wQzzd5IrqkuPf1UBxf+6+wtH8CsY9kx7KUOdZLVrOAJUFf
         pa+6sKJUi/Zs3dzoHAzYuQAK51McJK/FucZ3ojLuaZ3OyhSkB8hs9ReIyAv305cmyYcB
         oW2+rd3ul2i618+EI6eadKxwOR46qRTAFkc6uyaQDVtygRYOSU8dJ4FRoJQvtia+L9kC
         y/Knb0QGW4d1thSsQKuYJ/CqZpusNFWkkma3C6exy/9m0XL3ZoKXBjbJPbmTY4ibQb6l
         oezQ==
X-Gm-Message-State: AHQUAuZ5iLw7vU5/GvtFAtKZRzhPA4gAIyiKdgJm0P7psXTLlQ9Mramn
        scMCaCxr/fEvNXfGHC09F0AZCixI7q9irMst2uzm55HArpUB
X-Google-Smtp-Source: AHgI3Ibc6rN7aXj5TqDdxyVXl5QZrnOlPr3f7JfbADM/QbY9gXsMrvkM5tsXGA/aq5JPR+uTCaStfv9/lC8zQWEQBPMlbuwQnAhT
MIME-Version: 1.0
X-Received: by 2002:a24:7d8a:: with SMTP id b132mr460768itc.20.1550391063702;
 Sun, 17 Feb 2019 00:11:03 -0800 (PST)
Date:   Sun, 17 Feb 2019 00:11:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009d787a0582128cbe@google.com>
Subject: INFO: task hung in unregister_netdevice_notifier (3)
From:   syzbot <syzbot+0f1827363a305f74996f@syzkaller.appspotmail.com>
To:     davem@davemloft.net, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org, mkl@pengutronix.de,
        netdev@vger.kernel.org, socketcan@hartkopp.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    aa0c38cf39de Merge branch 'fixes' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=105302a7400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ee434566c893c7b1
dashboard link: https://syzkaller.appspot.com/bug?extid=0f1827363a305f74996f
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0f1827363a305f74996f@syzkaller.appspotmail.com

INFO: task syz-executor.1:32467 blocked for more than 140 seconds.
       Not tainted 5.0.0-rc6+ #69
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.1  D28224 32467  30279 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:2844 [inline]
  __schedule+0x817/0x1cc0 kernel/sched/core.c:3485
  schedule+0x92/0x180 kernel/sched/core.c:3529
  __rwsem_down_write_failed_common kernel/locking/rwsem-xadd.c:584 [inline]
  rwsem_down_write_failed+0x774/0xc30 kernel/locking/rwsem-xadd.c:613
  call_rwsem_down_write_failed+0x17/0x30 arch/x86/lib/rwsem.S:117
  __down_write arch/x86/include/asm/rwsem.h:142 [inline]
  down_write+0x53/0x90 kernel/locking/rwsem.c:72
  unregister_netdevice_notifier+0x7e/0x3a0 net/core/dev.c:1703
  raw_release+0x57/0x6f0 net/can/raw.c:358
  __sock_release+0xd3/0x250 net/socket.c:579
  sock_close+0x1b/0x30 net/socket.c:1139
  __fput+0x2df/0x8d0 fs/file_table.c:278
  ____fput+0x16/0x20 fs/file_table.c:309
  task_work_run+0x14a/0x1c0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x273/0x2c0 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x52d/0x610 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x411d41
Code: 00 00 8b b3 30 01 00 00 31 c0 bf d0 36 44 00 e8 05 f3 00 00 8b b3 08  
01 00 00 31 c0 bf e4 36 44 00 e8 f3 f2 00 00 8b 83 e0 00 <00> 00 48 89 ee  
bf f9 36 44 00 85 c0 49 0f 44 f4 31 c0 e8 d8 f2 00
RSP: 002b:00007ffc0aec9520 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000005 RCX: 0000000000411d41
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 0000000000000000 R08: ffffffff8100a073 R09: 0000000021576e54
R10: 00007ffc0aec9450 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000001 R14: 0000000000000072 R15: 0000000000000001
INFO: task syz-executor.5:32470 blocked for more than 140 seconds.
       Not tainted 5.0.0-rc6+ #69
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.5  D28224 32470   7467 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:2844 [inline]
  __schedule+0x817/0x1cc0 kernel/sched/core.c:3485
  schedule+0x92/0x180 kernel/sched/core.c:3529
  __rwsem_down_write_failed_common kernel/locking/rwsem-xadd.c:584 [inline]
  rwsem_down_write_failed+0x774/0xc30 kernel/locking/rwsem-xadd.c:613
  call_rwsem_down_write_failed+0x17/0x30 arch/x86/lib/rwsem.S:117
  __down_write arch/x86/include/asm/rwsem.h:142 [inline]
  down_write+0x53/0x90 kernel/locking/rwsem.c:72
  unregister_netdevice_notifier+0x7e/0x3a0 net/core/dev.c:1703
  raw_release+0x57/0x6f0 net/can/raw.c:358
  __sock_release+0xd3/0x250 net/socket.c:579
  sock_close+0x1b/0x30 net/socket.c:1139
  __fput+0x2df/0x8d0 fs/file_table.c:278
  ____fput+0x16/0x20 fs/file_table.c:309
  task_work_run+0x14a/0x1c0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x273/0x2c0 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x52d/0x610 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x411d41
Code: 00 00 8b b3 30 01 00 00 31 c0 bf d0 36 44 00 e8 05 f3 00 00 8b b3 08  
01 00 00 31 c0 bf e4 36 44 00 e8 f3 f2 00 00 8b 83 e0 00 <00> 00 48 89 ee  
bf f9 36 44 00 85 c0 49 0f 44 f4 31 c0 e8 d8 f2 00
RSP: 002b:00007ffe4f2857d0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000008 RCX: 0000000000411d41
RDX: 0000000000000000 RSI: 0000000000741140 RDI: 0000000000000007
RBP: 0000000000000000 R08: ffffffff8175450f R09: 0000000021576e54
R10: 00007ffe4f285700 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000001 R14: 0000000000001504 R15: 0000000000000005
INFO: task syz-executor.0:32475 blocked for more than 140 seconds.
       Not tainted 5.0.0-rc6+ #69
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.0  D28224 32475  25857 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:2844 [inline]
  __schedule+0x817/0x1cc0 kernel/sched/core.c:3485
  schedule+0x92/0x180 kernel/sched/core.c:3529
  __rwsem_down_write_failed_common kernel/locking/rwsem-xadd.c:584 [inline]
  rwsem_down_write_failed+0x774/0xc30 kernel/locking/rwsem-xadd.c:613
  call_rwsem_down_write_failed+0x17/0x30 arch/x86/lib/rwsem.S:117
  __down_write arch/x86/include/asm/rwsem.h:142 [inline]
  down_write+0x53/0x90 kernel/locking/rwsem.c:72
  unregister_netdevice_notifier+0x7e/0x3a0 net/core/dev.c:1703
  raw_release+0x57/0x6f0 net/can/raw.c:358
  __sock_release+0xd3/0x250 net/socket.c:579
  sock_close+0x1b/0x30 net/socket.c:1139
  __fput+0x2df/0x8d0 fs/file_table.c:278
  ____fput+0x16/0x20 fs/file_table.c:309
  task_work_run+0x14a/0x1c0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x273/0x2c0 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x52d/0x610 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x411d41
Code: 00 00 8b b3 30 01 00 00 31 c0 bf d0 36 44 00 e8 05 f3 00 00 8b b3 08  
01 00 00 31 c0 bf e4 36 44 00 e8 f3 f2 00 00 8b 83 e0 00 <00> 00 48 89 ee  
bf f9 36 44 00 85 c0 49 0f 44 f4 31 c0 e8 d8 f2 00
RSP: 002b:00007ffd315a7180 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000005 RCX: 0000000000411d41
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 0000000000000000 R08: 00000000c77ce9e8 R09: 00000000c77ce9ec
R10: 00007ffd315a70b0 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000001 R14: 0000000000000142 R15: 0000000000000000
INFO: task syz-executor.3:32481 blocked for more than 140 seconds.
kobject: 'batman_adv' (00000000eb158d40): kobject_uevent_env
kobject: 'batman_adv' (00000000eb158d40): kobject_uevent_env: filter  
function caused the event to drop!
       Not tainted 5.0.0-rc6+ #69
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.3  D29872 32481  25311 0x00000004
kobject: 'batman_adv' (00000000eb158d40): kobject_cleanup, parent            
(null)
Call Trace:
  context_switch kernel/sched/core.c:2844 [inline]
  __schedule+0x817/0x1cc0 kernel/sched/core.c:3485
kobject: 'batman_adv' (00000000eb158d40): calling ktype release
kobject: (00000000eb158d40): dynamic_kobj_release
kobject: 'batman_adv': free name
  schedule+0x92/0x180 kernel/sched/core.c:3529
kobject: 'rx-0' (000000009425fba9): kobject_cleanup, parent 00000000b76440a4
  __rwsem_down_write_failed_common kernel/locking/rwsem-xadd.c:584 [inline]
  rwsem_down_write_failed+0x774/0xc30 kernel/locking/rwsem-xadd.c:613
kobject: 'rx-0' (000000009425fba9): auto cleanup 'remove' event
kobject: 'rx-0' (000000009425fba9): kobject_uevent_env
  call_rwsem_down_write_failed+0x17/0x30 arch/x86/lib/rwsem.S:117
kobject: 'rx-0' (000000009425fba9): kobject_uevent_env: uevent_suppress  
caused the event to drop!
  __down_write arch/x86/include/asm/rwsem.h:142 [inline]
  down_write+0x53/0x90 kernel/locking/rwsem.c:72
kobject: 'rx-0' (000000009425fba9): auto cleanup kobject_del
  register_netdevice_notifier+0x7e/0x630 net/core/dev.c:1634
kobject: 'rx-0' (000000009425fba9): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-3' (000000005fdfc520): kobject_cleanup, parent 00000000b76440a4
kobject: 'tx-3' (000000005fdfc520): auto cleanup 'remove' event
  raw_init+0x299/0x340 net/can/raw.c:343
kobject: 'tx-3' (000000005fdfc520): kobject_uevent_env
kobject: 'tx-3' (000000005fdfc520): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-3' (000000005fdfc520): auto cleanup kobject_del
kobject: 'tx-3' (000000005fdfc520): calling ktype release
kobject: 'tx-3': free name
kobject: 'tx-2' (00000000b08d97be): kobject_cleanup, parent 00000000b76440a4
kobject: 'tx-2' (00000000b08d97be): auto cleanup 'remove' event
  can_create+0x28a/0x4b0 net/can/af_can.c:183
  __sock_create+0x3e6/0x750 net/socket.c:1275
kobject: 'tx-2' (00000000b08d97be): kobject_uevent_env
kobject: 'tx-2' (00000000b08d97be): kobject_uevent_env: uevent_suppress  
caused the event to drop!
  sock_create net/socket.c:1315 [inline]
  __sys_socket+0x103/0x220 net/socket.c:1345
kobject: 'tx-2' (00000000b08d97be): auto cleanup kobject_del
kobject: 'tx-2' (00000000b08d97be): calling ktype release
kobject: 'tx-2': free name
kobject: 'tx-1' (00000000709a5639): kobject_cleanup, parent 00000000b76440a4
  __do_sys_socket net/socket.c:1354 [inline]
  __se_sys_socket net/socket.c:1352 [inline]
  __x64_sys_socket+0x73/0xb0 net/socket.c:1352
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
kobject: 'tx-1' (00000000709a5639): auto cleanup 'remove' event
RIP: 0033:0x457e39
Code: Bad RIP value.
RSP: 002b:00007ff564faac78 EFLAGS: 00000246 ORIG_RAX: 0000000000000029
kobject: 'tx-1' (00000000709a5639): kobject_uevent_env
kobject: 'tx-1' (00000000709a5639): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-1' (00000000709a5639): auto cleanup kobject_del
kobject: 'tx-1' (00000000709a5639): calling ktype release
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457e39
kobject: 'tx-1': free name
kobject: 'tx-0' (00000000835508d8): kobject_cleanup, parent 00000000b76440a4
RDX: 0000000000000001 RSI: 0000000000000003 RDI: 000000000000001d
kobject: 'tx-0' (00000000835508d8): auto cleanup 'remove' event
kobject: 'tx-0' (00000000835508d8): kobject_uevent_env
kobject: 'tx-0' (00000000835508d8): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (00000000835508d8): auto cleanup kobject_del
RBP: 000000000073bfa0 R08: 0000000000000000 R09: 0000000000000000
kobject: 'tx-0' (00000000835508d8): calling ktype release
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ff564fab6d4
kobject: 'tx-0': free name
R13: 00000000004c616d R14: 00000000004db2f0 R15: 00000000ffffffff
kobject: 'queues' (00000000b76440a4): kobject_cleanup, parent            
(null)

Showing all locks held in the system:
1 lock held by khungtaskd/1039:
kobject: 'queues' (00000000b76440a4): calling ktype release
  #0: 00000000b60d248e (rcu_read_lock){....}, at:  
debug_show_all_locks+0x5f/0x27e kernel/locking/lockdep.c:4389
kobject: 'queues' (00000000b76440a4): kset_release
1 lock held by udevd/3867:
kobject: 'queues': free name
2 locks held by getty/7415:
  #0: 00000000e88d5f59 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
kobject: 'wlan2130' (000000006fe942ce): kobject_uevent_env
  #1: 0000000019eb2138 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2154
kobject: 'wlan2130' (000000006fe942ce): kobject_uevent_env: uevent_suppress  
caused the event to drop!
2 locks held by getty/7416:
kobject: 'net' (00000000df13c95f): kobject_cleanup, parent           (null)
kobject: 'net' (00000000df13c95f): calling ktype release
kobject: 'net': free name
  #0: 000000005ade2a44 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 000000003c9b35b9 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2154
2 locks held by getty/7417:
  #0: 00000000014d4db9 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 0000000040737cf5 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2154
2 locks held by getty/7418:
  #0: 00000000495d2925 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 000000008468a6ce (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2154
2 locks held by getty/7419:
  #0: 000000000a1e8d17 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 000000000f0237e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2154
2 locks held by getty/7420:
  #0: 00000000fe409789 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 000000005a06b62c (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2154
2 locks held by getty/7421:
  #0: 00000000ef5d25aa (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 00000000effcff7b (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2154
2 locks held by kworker/1:0/28948:
  #0: 0000000036c9d838 ((wq_completion)"rcu_gp"){+.+.}, at:  
__write_once_size include/linux/compiler.h:220 [inline]
  #0: 0000000036c9d838 ((wq_completion)"rcu_gp"){+.+.}, at:  
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0: 0000000036c9d838 ((wq_completion)"rcu_gp"){+.+.}, at: atomic64_set  
include/asm-generic/atomic-instrumented.h:40 [inline]
  #0: 0000000036c9d838 ((wq_completion)"rcu_gp"){+.+.}, at: atomic_long_set  
include/asm-generic/atomic-long.h:59 [inline]
  #0: 0000000036c9d838 ((wq_completion)"rcu_gp"){+.+.}, at: set_work_data  
kernel/workqueue.c:617 [inline]
  #0: 0000000036c9d838 ((wq_completion)"rcu_gp"){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:644 [inline]
  #0: 0000000036c9d838 ((wq_completion)"rcu_gp"){+.+.}, at:  
process_one_work+0x87e/0x1790 kernel/workqueue.c:2144
  #1: 00000000fba37eaa ((work_completion)(&rew.rew_work)){+.+.}, at:  
process_one_work+0x8b4/0x1790 kernel/workqueue.c:2148
1 lock held by syz-executor.4/16551:
  #0: 000000008e9f7a44 (&sig->cred_guard_mutex){+.+.}, at:  
prepare_bprm_creds fs/exec.c:1407 [inline]
  #0: 000000008e9f7a44 (&sig->cred_guard_mutex){+.+.}, at:  
__do_execve_file.isra.0+0x376/0x23f0 fs/exec.c:1750
5 locks held by kworker/u4:3/25989:
  #0: 00000000e512596f ((wq_completion)"%s""netns"){+.+.}, at:  
__write_once_size include/linux/compiler.h:220 [inline]
  #0: 00000000e512596f ((wq_completion)"%s""netns"){+.+.}, at:  
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0: 00000000e512596f ((wq_completion)"%s""netns"){+.+.}, at: atomic64_set  
include/asm-generic/atomic-instrumented.h:40 [inline]
  #0: 00000000e512596f ((wq_completion)"%s""netns"){+.+.}, at:  
atomic_long_set include/asm-generic/atomic-long.h:59 [inline]
  #0: 00000000e512596f ((wq_completion)"%s""netns"){+.+.}, at: set_work_data  
kernel/workqueue.c:617 [inline]
  #0: 00000000e512596f ((wq_completion)"%s""netns"){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:644 [inline]
  #0: 00000000e512596f ((wq_completion)"%s""netns"){+.+.}, at:  
process_one_work+0x87e/0x1790 kernel/workqueue.c:2144
  #1: 00000000d6c01503 (net_cleanup_work){+.+.}, at:  
process_one_work+0x8b4/0x1790 kernel/workqueue.c:2148
  #2: 000000005ef07189 (pernet_ops_rwsem){++++}, at: cleanup_net+0xae/0x960  
net/core/net_namespace.c:518
  #3: 00000000a64a1703 (rtnl_mutex){+.+.}, at: rtnl_lock+0x17/0x20  
net/core/rtnetlink.c:77
  #4: 000000007f9e135c (rcu_state.exp_mutex){+.+.}, at: exp_funnel_lock  
kernel/rcu/tree_exp.h:296 [inline]
  #4: 000000007f9e135c (rcu_state.exp_mutex){+.+.}, at:  
_synchronize_rcu_expedited.constprop.0+0x42a/0x530 kernel/rcu/tree_exp.h:622
2 locks held by syz-executor.1/32467:
  #0: 0000000091604586 (&sb->s_type->i_mutex_key#11){+.+.}, at: inode_lock  
include/linux/fs.h:757 [inline]
  #0: 0000000091604586 (&sb->s_type->i_mutex_key#11){+.+.}, at:  
__sock_release+0x89/0x250 net/socket.c:578
  #1: 000000005ef07189 (pernet_ops_rwsem){++++}, at:  
unregister_netdevice_notifier+0x7e/0x3a0 net/core/dev.c:1703
2 locks held by syz-executor.5/32470:
  #0: 00000000a53c9e1d (&sb->s_type->i_mutex_key#11){+.+.}, at: inode_lock  
include/linux/fs.h:757 [inline]
  #0: 00000000a53c9e1d (&sb->s_type->i_mutex_key#11){+.+.}, at:  
__sock_release+0x89/0x250 net/socket.c:578
  #1: 000000005ef07189 (pernet_ops_rwsem){++++}, at:  
unregister_netdevice_notifier+0x7e/0x3a0 net/core/dev.c:1703
2 locks held by syz-executor.0/32475:
  #0: 000000005169c482 (&sb->s_type->i_mutex_key#11){+.+.}, at: inode_lock  
include/linux/fs.h:757 [inline]
  #0: 000000005169c482 (&sb->s_type->i_mutex_key#11){+.+.}, at:  
__sock_release+0x89/0x250 net/socket.c:578
  #1: 000000005ef07189 (pernet_ops_rwsem){++++}, at:  
unregister_netdevice_notifier+0x7e/0x3a0 net/core/dev.c:1703
1 lock held by syz-executor.3/32481:
  #0: 000000005ef07189 (pernet_ops_rwsem){++++}, at:  
register_netdevice_notifier+0x7e/0x630 net/core/dev.c:1634
1 lock held by syz-executor.2/32495:
  #0: 000000005ef07189 (pernet_ops_rwsem){++++}, at: copy_net_ns+0x1ba/0x340  
net/core/net_namespace.c:433

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 1039 Comm: khungtaskd Not tainted 5.0.0-rc6+ #69
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  nmi_cpu_backtrace.cold+0x63/0xa4 lib/nmi_backtrace.c:101
  nmi_trigger_cpumask_backtrace+0x1be/0x236 lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
  check_hung_uninterruptible_tasks kernel/hung_task.c:203 [inline]
  watchdog+0x9df/0xee0 kernel/hung_task.c:287
  kthread+0x357/0x430 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 3867 Comm: udevd Not tainted 5.0.0-rc6+ #69
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:pvclock_scale_delta arch/x86/include/asm/pvclock.h:68 [inline]
RIP: 0010:__pvclock_read_cycles arch/x86/include/asm/pvclock.h:85 [inline]
RIP: 0010:pvclock_clocksource_read+0x1b2/0x4d0 arch/x86/kernel/pvclock.c:87
Code: 89 d9 48 89 c2 48 8b 7d a8 4c 89 d6 f7 d9 48 d3 ea 44 89 d9 48 d3 e0  
45 85 db 48 0f 48 c2 8b 53 18 83 e6 07 48 89 f9 48 f7 e2 <48> 0f ac d0 20  
4c 89 d2 48 c1 e9 03 48 c1 ea 03 42 0f b6 0c 21 42
RSP: 0018:ffff888098037bb8 EFLAGS: 00000a07
RAX: 51a81ae58ed2e6ca RBX: ffffffff89997000 RCX: ffffffff89997017
RDX: 0000000000000287 RSI: 0000000000000000 RDI: ffffffff89997017
RBP: ffff888098037c40 R08: ffffffff8999701c R09: ffffffff89997008
R10: ffffffff89997010 R11: 00000000ffffffff R12: dffffc0000000000
R13: ffffffff89997003 R14: fffffbfff1332e01 R15: ffffffff8999701d
FS:  00007ff1ce5b57a0(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c428a8f000 CR3: 0000000098cb6000 CR4: 00000000001406f0
DR0: 00000000200001c0 DR1: 00000000200001c0 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Call Trace:
  kvm_clock_read+0x18/0x30 arch/x86/kernel/kvmclock.c:90
  kvm_clock_get_cycles+0x9/0x10 arch/x86/kernel/kvmclock.c:97
  tk_clock_read kernel/time/timekeeping.c:167 [inline]
  timekeeping_get_delta kernel/time/timekeeping.c:261 [inline]
  timekeeping_get_ns kernel/time/timekeeping.c:368 [inline]
  ktime_get_ts64+0x1b0/0x3f0 kernel/time/timekeeping.c:885
  ep_set_mstimeout fs/eventpoll.c:1726 [inline]
  ep_poll+0x36a/0xe50 fs/eventpoll.c:1759
  do_epoll_wait+0x1b3/0x200 fs/eventpoll.c:2216
  __do_sys_epoll_wait fs/eventpoll.c:2226 [inline]
  __se_sys_epoll_wait fs/eventpoll.c:2223 [inline]
  __x64_sys_epoll_wait+0x97/0xf0 fs/eventpoll.c:2223
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7ff1cdcc9943
Code: 00 31 d2 48 29 c2 64 89 11 48 83 c8 ff eb ea 90 90 90 90 90 90 90 90  
83 3d b5 dc 2a 00 00 75 13 49 89 ca b8 e8 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 73 34 c3 48 83 ec 08 e8 3b c4 00 00 48 89 04 24
RSP: 002b:00007ffe9afc6838 EFLAGS: 00000246 ORIG_RAX: 00000000000000e8
RAX: ffffffffffffffda RBX: 0000000000000bb8 RCX: 00007ff1cdcc9943
RDX: 0000000000000008 RSI: 00007ffe9afc6930 RDI: 000000000000000a
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000001
R10: 0000000000000bb8 R11: 0000000000000246 R12: 0000000000000003
R13: 0000000000000000 R14: 0000000001c4c770 R15: 0000000001c49250


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
