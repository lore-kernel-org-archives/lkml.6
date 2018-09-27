Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00754C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F9721566
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:04:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66F9721566
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbeI0XXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:23:19 -0400
Received: from mail-it1-f198.google.com ([209.85.166.198]:36926 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727338AbeI0XXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 19:23:19 -0400
Received: by mail-it1-f198.google.com with SMTP id y73-v6so1741968ita.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 10:04:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=3N865br8NwUus2jU3tbd+DBAH3bAdbuFKK6sBKfsiCA=;
        b=tQsixBht6QLBy3a5nhIifnC+WukwJjXs5firPFWDW3lxVxhxmvy3TTrFzRliioLEXT
         dKqSu6fcFJQ9YNzQ7f0lVfLDnv/svVLy/H459stEmotoL/WpIb2TyztyhqDwZ6vZJUVi
         3Pw/XcUXHvBVTUFhH+IikTnYv7UZTL6vs9cQPv9yC5NJ0sDUATF12/CJgWlvVtaCoMZ3
         ISSGbaV9IF+62mqUWru/Qjb+81THQVshjvZbswKjcvpaVKdflFxR0LQdB2ARd05zNs7L
         aCvfRYEgMQgSQL0zz55ZMmnXIdH8qNjse1W1aBfLCbvHRttwBMLEERoKA8haI7PKtRB+
         oy7Q==
X-Gm-Message-State: ABuFfogfdDMK4E2sspb3qd/68f6x/bsNg48DSMf91vj6eMyb26DbJkQg
        76qRicjO5fX2UIGVnfinItv/s4yHjMXk6ihPQewAgiUs783Y
X-Google-Smtp-Source: ACcGV6387gNn59EFa9UB2W7epeYLWWyNU+EiZVfbNDKHUhBnJdwYwnGBppJG4ks8Gnh+6qY2SRRHAwpZOWDyHlaA7pAY29LKQd86
MIME-Version: 1.0
X-Received: by 2002:a24:4567:: with SMTP id y100-v6mr1074993ita.37.1538067844158;
 Thu, 27 Sep 2018 10:04:04 -0700 (PDT)
Date:   Thu, 27 Sep 2018 10:04:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007dedf00576dd53eb@google.com>
Subject: possible deadlock in acct_pin_kill
From:   syzbot <syzbot+2a73a6ea9507b7112141@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        kstewart@linuxfoundation.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, oleg@redhat.com, paulmck@linux.vnet.ibm.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    46c163a036b4 Add linux-next specific files for 20180921
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17688a4e400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=20ea07a946ad19d7
dashboard link: https://syzkaller.appspot.com/bug?extid=2a73a6ea9507b7112141
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2a73a6ea9507b7112141@syzkaller.appspotmail.com


======================================================
WARNING: possible circular locking dependency detected
4.19.0-rc4-next-20180921+ #77 Not tainted
------------------------------------------------------
syz-executor0/27385 is trying to acquire lock:
00000000d0ec020c (&acct->lock#2){+.+.}, at: acct_pin_kill+0x26/0x100  
kernel/acct.c:173

but task is already holding lock:
00000000dea1d1e8 (sb_writers#5){.+.+}, at: sb_start_write  
include/linux/fs.h:1583 [inline]
00000000dea1d1e8 (sb_writers#5){.+.+}, at: mnt_want_write+0x3f/0xc0  
fs/namespace.c:359

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (sb_writers#5){.+.+}:
        percpu_down_read_preempt_disable include/linux/percpu-rwsem.h:36  
[inline]
        percpu_down_read include/linux/percpu-rwsem.h:59 [inline]
        __sb_start_write+0x214/0x370 fs/super.c:1564
        sb_start_write include/linux/fs.h:1583 [inline]
        mnt_want_write+0x3f/0xc0 fs/namespace.c:359
        ovl_want_write+0x76/0xa0 fs/overlayfs/util.c:24
        ovl_setattr+0x10b/0xaf0 fs/overlayfs/inode.c:30
        notify_change+0xbde/0x1110 fs/attr.c:334
        do_truncate+0x1bd/0x2d0 fs/open.c:63
        handle_truncate fs/namei.c:3008 [inline]
        do_last fs/namei.c:3424 [inline]
        path_openat+0x375c/0x5160 fs/namei.c:3534
        do_filp_open+0x255/0x380 fs/namei.c:3564
        do_sys_open+0x568/0x700 fs/open.c:1063
        ksys_open include/linux/syscalls.h:1292 [inline]
        __do_sys_creat fs/open.c:1121 [inline]
        __se_sys_creat fs/open.c:1119 [inline]
        __x64_sys_creat+0x61/0x80 fs/open.c:1119
        do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #1 (&ovl_i_mutex_key[depth]){+.+.}:
        down_write+0x8a/0x130 kernel/locking/rwsem.c:70
        inode_lock include/linux/fs.h:745 [inline]
        ovl_write_iter+0x151/0xb00 fs/overlayfs/file.c:231
        call_write_iter include/linux/fs.h:1825 [inline]
        new_sync_write fs/read_write.c:474 [inline]
        __vfs_write+0x6b8/0x9f0 fs/read_write.c:487
        __kernel_write+0x10c/0x370 fs/read_write.c:506
        do_acct_process+0x1144/0x1660 kernel/acct.c:520
        acct_pin_kill+0x2e/0x100 kernel/acct.c:174
        pin_kill+0x29d/0xab0 fs/fs_pin.c:50
        acct_on+0x665/0x940 kernel/acct.c:254
        __do_sys_acct kernel/acct.c:286 [inline]
        __se_sys_acct kernel/acct.c:273 [inline]
        __x64_sys_acct+0xc2/0x1f0 kernel/acct.c:273
        do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #0 (&acct->lock#2){+.+.}:
        lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3900
        __mutex_lock_common kernel/locking/mutex.c:925 [inline]
        __mutex_lock+0x166/0x1700 kernel/locking/mutex.c:1072
        mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1087
        acct_pin_kill+0x26/0x100 kernel/acct.c:173
        pin_kill+0x29d/0xab0 fs/fs_pin.c:50
        acct_on+0x665/0x940 kernel/acct.c:254
        __do_sys_acct kernel/acct.c:286 [inline]
        __se_sys_acct kernel/acct.c:273 [inline]
        __x64_sys_acct+0xc2/0x1f0 kernel/acct.c:273
        do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

Chain exists of:
   &acct->lock#2 --> &ovl_i_mutex_key[depth] --> sb_writers#5

  Possible unsafe locking scenario:

        CPU0                    CPU1
kobject: 'loop2' (00000000f0d2441b): kobject_uevent_env
        ----                    ----
   lock(sb_writers#5);
                                lock(&ovl_i_mutex_key[depth]);
                                lock(sb_writers#5);
   lock(&acct->lock#2);
kobject: 'loop2' (00000000f0d2441b): fill_kobj_path: path  
= '/devices/virtual/block/loop2'

  *** DEADLOCK ***

2 locks held by syz-executor0/27385:
  #0: 000000000ae5b2aa (acct_on_mutex){+.+.}, at: __do_sys_acct  
kernel/acct.c:285 [inline]
  #0: 000000000ae5b2aa (acct_on_mutex){+.+.}, at: __se_sys_acct  
kernel/acct.c:273 [inline]
  #0: 000000000ae5b2aa (acct_on_mutex){+.+.}, at: __x64_sys_acct+0xba/0x1f0  
kernel/acct.c:273
  #1: 00000000dea1d1e8 (sb_writers#5){.+.+}, at: sb_start_write  
include/linux/fs.h:1583 [inline]
  #1: 00000000dea1d1e8 (sb_writers#5){.+.+}, at: mnt_want_write+0x3f/0xc0  
fs/namespace.c:359

stack backtrace:
CPU: 0 PID: 27385 Comm: syz-executor0 Not tainted 4.19.0-rc4-next-20180921+  
#77
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d3/0x2c4 lib/dump_stack.c:113
  print_circular_bug.isra.33.cold.54+0x1bd/0x27d  
kernel/locking/lockdep.c:1221
  check_prev_add kernel/locking/lockdep.c:1861 [inline]
  check_prevs_add kernel/locking/lockdep.c:1974 [inline]
  validate_chain kernel/locking/lockdep.c:2415 [inline]
  __lock_acquire+0x33e4/0x4ec0 kernel/locking/lockdep.c:3411
  lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3900
  __mutex_lock_common kernel/locking/mutex.c:925 [inline]
  __mutex_lock+0x166/0x1700 kernel/locking/mutex.c:1072
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1087
  acct_pin_kill+0x26/0x100 kernel/acct.c:173
  pin_kill+0x29d/0xab0 fs/fs_pin.c:50
  acct_on+0x665/0x940 kernel/acct.c:254
  __do_sys_acct kernel/acct.c:286 [inline]
  __se_sys_acct kernel/acct.c:273 [inline]
  __x64_sys_acct+0xc2/0x1f0 kernel/acct.c:273
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457679
Code: 1d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fe6ea920c78 EFLAGS: 00000246 ORIG_RAX: 00000000000000a3
RAX: ffffffffffffffda RBX: 00007fe6ea9216d4 RCX: 0000000000457679
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000100
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004cbe48 R14: 00000000004bd803 R15: 0000000000000000
Process accounting resumed
kobject: 'loop1' (00000000c5233d58): kobject_uevent_env
kobject: 'loop1' (00000000c5233d58): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop4' (00000000978418a7): kobject_uevent_env
Process accounting resumed
kobject: 'loop4' (00000000978418a7): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop4' (00000000978418a7): kobject_uevent_env
kobject: 'loop4' (00000000978418a7): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop5' (000000001c2a90ad): kobject_uevent_env
kobject: 'loop5' (000000001c2a90ad): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
9pnet: p9_fd_create_unix (27435): problem connecting socket: ./file0: -111
kobject: 'rx-0' (00000000cdb97823): kobject_cleanup, parent 00000000a46d3e36
kobject: 'rx-0' (00000000cdb97823): auto cleanup 'remove' event
kobject: 'rx-0' (00000000cdb97823): kobject_uevent_env
kobject: 'loop5' (000000001c2a90ad): kobject_uevent_env
kobject: 'rx-0' (00000000cdb97823): fill_kobj_path: path  
= '/devices/virtual/net/syz_tun/queues/rx-0'
kobject: 'loop5' (000000001c2a90ad): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'rx-0' (00000000cdb97823): auto cleanup kobject_del
kobject: 'rx-0' (00000000cdb97823): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (000000002559bf24): kobject_cleanup, parent 00000000a46d3e36
kobject: 'tx-0' (000000002559bf24): auto cleanup 'remove' event
kobject: 'tx-0' (000000002559bf24): kobject_uevent_env
kobject: 'tx-0' (000000002559bf24): fill_kobj_path: path  
= '/devices/virtual/net/syz_tun/queues/tx-0'
kobject: 'tx-0' (000000002559bf24): auto cleanup kobject_del
kobject: 'tx-0' (000000002559bf24): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (00000000a46d3e36): kobject_cleanup, parent            
(null)
kobject: 'queues' (00000000a46d3e36): calling ktype release
kobject: 'queues' (00000000a46d3e36): kset_release
kobject: 'queues': free name
kobject: 'syz_tun' (00000000aa011056): kobject_uevent_env
kobject: 'syz_tun' (00000000aa011056): fill_kobj_path: path  
= '/devices/virtual/net/syz_tun'
9pnet: p9_fd_create_unix (27439): problem connecting socket: ./file0: -111
kobject: 'syz_tun' (00000000aa011056): kobject_cleanup, parent            
(null)
kobject: 'syz_tun' (00000000aa011056): calling ktype release
kobject: 'syz_tun': free name
netlink: 8 bytes leftover after parsing attributes in process  
`syz-executor5'.
kobject: 'loop4' (00000000978418a7): kobject_uevent_env
kobject: 'loop4' (00000000978418a7): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
IPVS: ftp: loaded support on port[0] = 21
kobject: 'rx-0' (00000000fbde6e76): kobject_cleanup, parent 0000000046f24b87
kobject: 'rx-0' (00000000fbde6e76): auto cleanup 'remove' event
kobject: 'rx-0' (00000000fbde6e76): kobject_uevent_env
kobject: 'rx-0' (00000000fbde6e76): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000fbde6e76): auto cleanup kobject_del
kobject: 'rx-0' (00000000fbde6e76): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (0000000057c73a27): kobject_cleanup, parent 0000000046f24b87
kobject: 'tx-0' (0000000057c73a27): auto cleanup 'remove' event
kobject: 'tx-0' (0000000057c73a27): kobject_uevent_env
kobject: 'tx-0' (0000000057c73a27): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (0000000057c73a27): auto cleanup kobject_del
kobject: 'tx-0' (0000000057c73a27): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (0000000046f24b87): kobject_cleanup, parent            
(null)
kobject: 'queues' (0000000046f24b87): calling ktype release
kobject: 'queues' (0000000046f24b87): kset_release
kobject: 'queues': free name
kobject: 'ip6gre0' (00000000ecc862ab): kobject_uevent_env
kobject: 'ip6gre0' (00000000ecc862ab): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'loop1' (00000000c5233d58): kobject_uevent_env
kobject: 'loop1' (00000000c5233d58): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'rx-0' (00000000c8c9e025): kobject_cleanup, parent 000000007df94d85
kobject: 'rx-0' (00000000c8c9e025): auto cleanup 'remove' event
kobject: 'rx-0' (00000000c8c9e025): kobject_uevent_env
kobject: 'rx-0' (00000000c8c9e025): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000c8c9e025): auto cleanup kobject_del
kobject: 'loop1' (00000000c5233d58): kobject_uevent_env
kobject: 'loop1' (00000000c5233d58): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'rx-0' (00000000c8c9e025): calling ktype release
kobject: 'rx-0': free name
kobject: 'loop4' (00000000978418a7): kobject_uevent_env
kobject: 'tx-0' (000000001e627392): kobject_cleanup, parent 000000007df94d85
kobject: 'loop4' (00000000978418a7): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'tx-0' (000000001e627392): auto cleanup 'remove' event
kobject: 'loop1' (00000000c5233d58): kobject_uevent_env
kobject: 'tx-0' (000000001e627392): kobject_uevent_env
kobject: 'loop1' (00000000c5233d58): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'tx-0' (000000001e627392): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (000000001e627392): auto cleanup kobject_del
kobject: 'tx-0' (000000001e627392): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (000000007df94d85): kobject_cleanup, parent            
(null)
kobject: 'queues' (000000007df94d85): calling ktype release
kobject: 'queues' (000000007df94d85): kset_release
kobject: 'queues': free name
kobject: 'ip6gretap0' (00000000c2cf4bbd): kobject_uevent_env
kobject: 'ip6gretap0' (00000000c2cf4bbd): kobject_uevent_env:  
uevent_suppress caused the event to drop!
kobject: 'lo' (00000000da1af5f3): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'lo' (00000000da1af5f3): kobject_uevent_env
kobject: 'lo' (00000000da1af5f3): fill_kobj_path: path  
= '/devices/virtual/net/lo'
kobject: 'queues' (000000002f5953eb): kobject_add_internal: parent: 'lo',  
set: '<NULL>'
kobject: 'queues' (000000002f5953eb): kobject_uevent_env
kobject: 'queues' (000000002f5953eb): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (000000004f2992d8): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (000000004f2992d8): kobject_uevent_env
kobject: 'rx-0' (000000004f2992d8): fill_kobj_path: path  
= '/devices/virtual/net/lo/queues/rx-0'
kobject: 'tx-0' (0000000015f15aa2): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (0000000015f15aa2): kobject_uevent_env
kobject: 'tx-0' (0000000015f15aa2): fill_kobj_path: path  
= '/devices/virtual/net/lo/queues/tx-0'
netlink: 8 bytes leftover after parsing attributes in process  
`syz-executor5'.
kobject: 'ip6gre0' (00000000ecc862ab): kobject_cleanup, parent            
(null)
kobject: 'ip6gre0' (00000000ecc862ab): auto cleanup 'remove' event
kobject: 'tunl0' (00000000dea42a7b): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'loop5' (000000001c2a90ad): kobject_uevent_env
kobject: 'tunl0' (00000000dea42a7b): kobject_uevent_env
kobject: 'loop5' (000000001c2a90ad): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'tunl0' (00000000dea42a7b): fill_kobj_path: path  
= '/devices/virtual/net/tunl0'
kobject: 'ip6gre0' (00000000ecc862ab): kobject_uevent_env
kobject: 'queues' (000000008948c470): kobject_add_internal:  
parent: 'tunl0', set: '<NULL>'
kobject: 'ip6gre0' (00000000ecc862ab): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'queues' (000000008948c470): kobject_uevent_env
kobject: 'ip6gre0' (00000000ecc862ab): calling ktype release
kobject: 'queues' (000000008948c470): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'ip6gre0': free name
kobject: 'rx-0' (0000000021e57782): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (0000000021e57782): kobject_uevent_env
kobject: 'rx-0' (0000000021e57782): fill_kobj_path: path  
= '/devices/virtual/net/tunl0/queues/rx-0'
kobject: 'tx-0' (00000000f4e4fa08): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (00000000f4e4fa08): kobject_uevent_env
kobject: 'tx-0' (00000000f4e4fa08): fill_kobj_path: path  
= '/devices/virtual/net/tunl0/queues/tx-0'
kobject: 'gre0' (000000006bf5f4b4): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'gre0' (000000006bf5f4b4): kobject_uevent_env
kobject: 'gre0' (000000006bf5f4b4): fill_kobj_path: path  
= '/devices/virtual/net/gre0'
kobject: 'queues' (00000000f68a53fe): kobject_add_internal: parent: 'gre0',  
set: '<NULL>'
kobject: 'queues' (00000000f68a53fe): kobject_uevent_env
kobject: 'queues' (00000000f68a53fe): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (0000000051cac673): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (0000000051cac673): kobject_uevent_env
kobject: 'rx-0' (0000000051cac673): fill_kobj_path: path  
= '/devices/virtual/net/gre0/queues/rx-0'
kobject: 'tx-0' (000000005511ab22): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (000000005511ab22): kobject_uevent_env
kobject: 'tx-0' (000000005511ab22): fill_kobj_path: path  
= '/devices/virtual/net/gre0/queues/tx-0'
kobject: 'ip6gretap0' (00000000c2cf4bbd): kobject_cleanup, parent            
(null)
kobject: 'gretap0' (000000008e864b82): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'ip6gretap0' (00000000c2cf4bbd): auto cleanup 'remove' event
kobject: 'gretap0' (000000008e864b82): kobject_uevent_env
kobject: 'ip6gretap0' (00000000c2cf4bbd): kobject_uevent_env
kobject: 'gretap0' (000000008e864b82): fill_kobj_path: path  
= '/devices/virtual/net/gretap0'
kobject: 'ip6gretap0' (00000000c2cf4bbd): kobject_uevent_env:  
uevent_suppress caused the event to drop!
kobject: 'queues' (000000006844c115): kobject_add_internal:  
parent: 'gretap0', set: '<NULL>'
kobject: 'ip6gretap0' (00000000c2cf4bbd): calling ktype release
kobject: 'queues' (000000006844c115): kobject_uevent_env
kobject: 'ip6gretap0': free name
kobject: 'queues' (000000006844c115): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (00000000cca19ac6): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (00000000cca19ac6): kobject_uevent_env
kobject: 'rx-0' (00000000cca19ac6): fill_kobj_path: path  
= '/devices/virtual/net/gretap0/queues/rx-0'
kobject: 'tx-0' (000000009699c592): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (000000009699c592): kobject_uevent_env
kobject: 'tx-0' (000000009699c592): fill_kobj_path: path  
= '/devices/virtual/net/gretap0/queues/tx-0'
kobject: 'erspan0' (0000000018b81bfa): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'erspan0' (0000000018b81bfa): kobject_uevent_env
kobject: 'erspan0' (0000000018b81bfa): fill_kobj_path: path  
= '/devices/virtual/net/erspan0'
kobject: 'queues' (00000000cebb490f): kobject_add_internal:  
parent: 'erspan0', set: '<NULL>'
kobject: 'queues' (00000000cebb490f): kobject_uevent_env
kobject: 'queues' (00000000cebb490f): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (000000000ab0916f): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (000000000ab0916f): kobject_uevent_env
kobject: 'rx-0' (000000000ab0916f): fill_kobj_path: path  
= '/devices/virtual/net/erspan0/queues/rx-0'
kobject: 'tx-0' (0000000017e67eaa): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (0000000017e67eaa): kobject_uevent_env
kobject: 'tx-0' (0000000017e67eaa): fill_kobj_path: path  
= '/devices/virtual/net/erspan0/queues/tx-0'
kobject: 'rx-0' (00000000fd9e124b): kobject_cleanup, parent 0000000067bc55e9
kobject: 'rx-0' (00000000fd9e124b): auto cleanup 'remove' event
kobject: 'rx-0' (00000000fd9e124b): kobject_uevent_env
kobject: 'rx-0' (00000000fd9e124b): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000fd9e124b): auto cleanup kobject_del
kobject: 'rx-0' (00000000fd9e124b): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (00000000396c0551): kobject_cleanup, parent 0000000067bc55e9
kobject: 'tx-0' (00000000396c0551): auto cleanup 'remove' event
kobject: 'tx-0' (00000000396c0551): kobject_uevent_env
kobject: 'tx-0' (00000000396c0551): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (00000000396c0551): auto cleanup kobject_del
kobject: 'tx-0' (00000000396c0551): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (0000000067bc55e9): kobject_cleanup, parent            
(null)
kobject: 'queues' (0000000067bc55e9): calling ktype release
kobject: 'queues' (0000000067bc55e9): kset_release
kobject: 'queues': free name
kobject: 'ip6tnl0' (00000000a1b842bc): kobject_uevent_env
kobject: 'ip6tnl0' (00000000a1b842bc): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'ip_vti0' (00000000a6d99f49): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'ip_vti0' (00000000a6d99f49): kobject_uevent_env
kobject: 'ip_vti0' (00000000a6d99f49): fill_kobj_path: path  
= '/devices/virtual/net/ip_vti0'
kobject: 'queues' (0000000051170131): kobject_add_internal:  
parent: 'ip_vti0', set: '<NULL>'
kobject: 'queues' (0000000051170131): kobject_uevent_env
kobject: 'queues' (0000000051170131): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (00000000f52b4388): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (00000000f52b4388): kobject_uevent_env
kobject: 'rx-0' (00000000f52b4388): fill_kobj_path: path  
= '/devices/virtual/net/ip_vti0/queues/rx-0'
kobject: 'tx-0' (0000000042b6d7ad): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (0000000042b6d7ad): kobject_uevent_env
kobject: 'tx-0' (0000000042b6d7ad): fill_kobj_path: path  
= '/devices/virtual/net/ip_vti0/queues/tx-0'
kobject: 'ip6tnl0' (00000000a1b842bc): kobject_cleanup, parent            
(null)
kobject: 'ip6_vti0' (00000000883fe298): kobject_add_internal:  
parent: 'net', set: 'devices'
kobject: 'ip6tnl0' (00000000a1b842bc): auto cleanup 'remove' event
kobject: 'ip6_vti0' (00000000883fe298): kobject_uevent_env
kobject: 'ip6tnl0' (00000000a1b842bc): kobject_uevent_env
kobject: 'ip6_vti0' (00000000883fe298): fill_kobj_path: path  
= '/devices/virtual/net/ip6_vti0'
kobject: 'ip6tnl0' (00000000a1b842bc): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'queues' (00000000a7e00bd9): kobject_add_internal:  
parent: 'ip6_vti0', set: '<NULL>'
kobject: 'ip6tnl0' (00000000a1b842bc): calling ktype release
kobject: 'queues' (00000000a7e00bd9): kobject_uevent_env
kobject: 'ip6tnl0': free name
kobject: 'queues' (00000000a7e00bd9): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (00000000dca9d6a4): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (00000000dca9d6a4): kobject_uevent_env
kobject: 'rx-0' (00000000dca9d6a4): fill_kobj_path: path  
= '/devices/virtual/net/ip6_vti0/queues/rx-0'
kobject: 'tx-0' (00000000cc22537f): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (00000000cc22537f): kobject_uevent_env
kobject: 'tx-0' (00000000cc22537f): fill_kobj_path: path  
= '/devices/virtual/net/ip6_vti0/queues/tx-0'
kobject: 'rx-0' (00000000e47a45fc): kobject_cleanup, parent 0000000020aff8af
kobject: 'rx-0' (00000000e47a45fc): auto cleanup 'remove' event
kobject: 'rx-0' (00000000e47a45fc): kobject_uevent_env
kobject: 'rx-0' (00000000e47a45fc): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000e47a45fc): auto cleanup kobject_del
kobject: 'rx-0' (00000000e47a45fc): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (00000000aa5107e6): kobject_cleanup, parent 0000000020aff8af
kobject: 'tx-0' (00000000aa5107e6): auto cleanup 'remove' event
kobject: 'tx-0' (00000000aa5107e6): kobject_uevent_env
kobject: 'tx-0' (00000000aa5107e6): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (00000000aa5107e6): auto cleanup kobject_del
kobject: 'tx-0' (00000000aa5107e6): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (0000000020aff8af): kobject_cleanup, parent            
(null)
kobject: 'queues' (0000000020aff8af): calling ktype release
kobject: 'queues' (0000000020aff8af): kset_release
kobject: 'queues': free name
kobject: 'sit0' (00000000eaf889f6): kobject_uevent_env
kobject: 'sit0' (00000000eaf889f6): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'sit0' (00000000aadc58c7): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'sit0' (00000000aadc58c7): kobject_uevent_env
kobject: 'sit0' (00000000aadc58c7): fill_kobj_path: path  
= '/devices/virtual/net/sit0'
kobject: 'queues' (00000000d3ddb602): kobject_add_internal: parent: 'sit0',  
set: '<NULL>'
kobject: 'queues' (00000000d3ddb602): kobject_uevent_env
kobject: 'queues' (00000000d3ddb602): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (00000000baa21c79): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (00000000baa21c79): kobject_uevent_env
kobject: 'rx-0' (00000000baa21c79): fill_kobj_path: path  
= '/devices/virtual/net/sit0/queues/rx-0'
kobject: 'tx-0' (00000000582dd21d): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (00000000582dd21d): kobject_uevent_env
kobject: 'tx-0' (00000000582dd21d): fill_kobj_path: path  
= '/devices/virtual/net/sit0/queues/tx-0'
kobject: 'sit0' (00000000eaf889f6): kobject_cleanup, parent           (null)
kobject: 'ip6tnl0' (0000000092aea933): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'sit0' (00000000eaf889f6): auto cleanup 'remove' event
kobject: 'ip6tnl0' (0000000092aea933): kobject_uevent_env
kobject: 'sit0' (00000000eaf889f6): kobject_uevent_env
kobject: 'ip6tnl0' (0000000092aea933): fill_kobj_path: path  
= '/devices/virtual/net/ip6tnl0'
kobject: 'sit0' (00000000eaf889f6): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'queues' (00000000f158d159): kobject_add_internal:  
parent: 'ip6tnl0', set: '<NULL>'
kobject: 'sit0' (00000000eaf889f6): calling ktype release
kobject: 'queues' (00000000f158d159): kobject_uevent_env
kobject: 'sit0': free name
kobject: 'queues' (00000000f158d159): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (0000000029223bbe): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (0000000029223bbe): kobject_uevent_env
kobject: 'rx-0' (0000000029223bbe): fill_kobj_path: path  
= '/devices/virtual/net/ip6tnl0/queues/rx-0'
kobject: 'tx-0' (00000000220d750b): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (00000000220d750b): kobject_uevent_env
kobject: 'tx-0' (00000000220d750b): fill_kobj_path: path  
= '/devices/virtual/net/ip6tnl0/queues/tx-0'
kobject: 'rx-0' (00000000264b854e): kobject_cleanup, parent 000000009c69edbb
kobject: 'rx-0' (00000000264b854e): auto cleanup 'remove' event
kobject: 'rx-0' (00000000264b854e): kobject_uevent_env
kobject: 'rx-0' (00000000264b854e): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000264b854e): auto cleanup kobject_del
kobject: 'rx-0' (00000000264b854e): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (0000000077ca0bcf): kobject_cleanup, parent 000000009c69edbb
kobject: 'tx-0' (0000000077ca0bcf): auto cleanup 'remove' event
kobject: 'tx-0' (0000000077ca0bcf): kobject_uevent_env
kobject: 'tx-0' (0000000077ca0bcf): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (0000000077ca0bcf): auto cleanup kobject_del
kobject: 'tx-0' (0000000077ca0bcf): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (000000009c69edbb): kobject_cleanup, parent            
(null)
kobject: 'queues' (000000009c69edbb): calling ktype release
kobject: 'queues' (000000009c69edbb): kset_release
kobject: 'queues': free name
kobject: 'ip6_vti0' (000000009b9def95): kobject_uevent_env
kobject: 'ip6_vti0' (000000009b9def95): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'ip6gre0' (00000000d8a0aee4): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'ip6gre0' (00000000d8a0aee4): kobject_uevent_env
kobject: 'ip6gre0' (00000000d8a0aee4): fill_kobj_path: path  
= '/devices/virtual/net/ip6gre0'
kobject: 'queues' (00000000e2b6be7c): kobject_add_internal:  
parent: 'ip6gre0', set: '<NULL>'
kobject: 'queues' (00000000e2b6be7c): kobject_uevent_env
kobject: 'queues' (00000000e2b6be7c): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (00000000a2e45d6b): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (00000000a2e45d6b): kobject_uevent_env
kobject: 'rx-0' (00000000a2e45d6b): fill_kobj_path: path  
= '/devices/virtual/net/ip6gre0/queues/rx-0'
kobject: 'tx-0' (00000000c3d48108): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (00000000c3d48108): kobject_uevent_env
kobject: 'tx-0' (00000000c3d48108): fill_kobj_path: path  
= '/devices/virtual/net/ip6gre0/queues/tx-0'
kobject: 'syz_tun' (0000000088d89de9): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'syz_tun' (0000000088d89de9): kobject_uevent_env
kobject: 'syz_tun' (0000000088d89de9): fill_kobj_path: path  
= '/devices/virtual/net/syz_tun'
kobject: 'queues' (000000004fd706d9): kobject_add_internal:  
parent: 'syz_tun', set: '<NULL>'
kobject: 'queues' (000000004fd706d9): kobject_uevent_env
kobject: 'queues' (000000004fd706d9): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (000000004daeb7e0): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (000000004daeb7e0): kobject_uevent_env
kobject: 'rx-0' (000000004daeb7e0): fill_kobj_path: path  
= '/devices/virtual/net/syz_tun/queues/rx-0'
kobject: 'tx-0' (00000000d1d5b0fe): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (00000000d1d5b0fe): kobject_uevent_env
kobject: 'tx-0' (00000000d1d5b0fe): fill_kobj_path: path  
= '/devices/virtual/net/syz_tun/queues/tx-0'
kobject: 'ip6_vti0' (000000009b9def95): kobject_cleanup, parent            
(null)
kobject: 'ip6_vti0' (000000009b9def95): auto cleanup 'remove' event
kobject: 'ip6_vti0' (000000009b9def95): kobject_uevent_env
kobject: 'ip6_vti0' (000000009b9def95): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'ip6_vti0' (000000009b9def95): calling ktype release
kobject: 'ip6_vti0': free name
kobject: 'rx-0' (000000008e911b12): kobject_cleanup, parent 000000004da6d921
kobject: 'rx-0' (000000008e911b12): auto cleanup 'remove' event
kobject: 'rx-0' (000000008e911b12): kobject_uevent_env
kobject: 'rx-0' (000000008e911b12): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (000000008e911b12): auto cleanup kobject_del
kobject: 'rx-0' (000000008e911b12): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (00000000bb18d37b): kobject_cleanup, parent 000000004da6d921
kobject: 'tx-0' (00000000bb18d37b): auto cleanup 'remove' event
kobject: 'tx-0' (00000000bb18d37b): kobject_uevent_env
kobject: 'tx-0' (00000000bb18d37b): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (00000000bb18d37b): auto cleanup kobject_del
kobject: 'tx-0' (00000000bb18d37b): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (000000004da6d921): kobject_cleanup, parent            
(null)
kobject: 'queues' (000000004da6d921): calling ktype release
kobject: 'queues' (000000004da6d921): kset_release
kobject: 'queues': free name
kobject: 'ip_vti0' (000000007248a64a): kobject_uevent_env
kobject: 'ip_vti0' (000000007248a64a): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'ip_vti0' (000000007248a64a): kobject_cleanup, parent            
(null)
kobject: 'ip_vti0' (000000007248a64a): auto cleanup 'remove' event
kobject: 'ip_vti0' (000000007248a64a): kobject_uevent_env
kobject: 'ip_vti0' (000000007248a64a): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'ip_vti0' (000000007248a64a): calling ktype release
kobject: 'ip_vti0': free name
kobject: 'rx-0' (00000000956de1f2): kobject_cleanup, parent 000000001465cb14
kobject: 'rx-0' (00000000956de1f2): auto cleanup 'remove' event
kobject: 'rx-0' (00000000956de1f2): kobject_uevent_env
kobject: 'rx-0' (00000000956de1f2): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000956de1f2): auto cleanup kobject_del
kobject: 'rx-0' (00000000956de1f2): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (00000000bd2d83f7): kobject_cleanup, parent 000000001465cb14
kobject: 'tx-0' (00000000bd2d83f7): auto cleanup 'remove' event
kobject: 'tx-0' (00000000bd2d83f7): kobject_uevent_env
kobject: 'tx-0' (00000000bd2d83f7): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (00000000bd2d83f7): auto cleanup kobject_del
kobject: 'tx-0' (00000000bd2d83f7): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (000000001465cb14): kobject_cleanup, parent            
(null)
kobject: 'queues' (000000001465cb14): calling ktype release
kobject: 'queues' (000000001465cb14): kset_release
kobject: 'queues': free name
kobject: 'erspan0' (0000000052540aab): kobject_uevent_env
kobject: 'erspan0' (0000000052540aab): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'ip6gretap0' (00000000dfa28031): kobject_add_internal:  
parent: 'net', set: 'devices'
kobject: 'ip6gretap0' (00000000dfa28031): kobject_uevent_env
kobject: 'ip6gretap0' (00000000dfa28031): fill_kobj_path: path  
= '/devices/virtual/net/ip6gretap0'
kobject: 'queues' (00000000c713b3f3): kobject_add_internal:  
parent: 'ip6gretap0', set: '<NULL>'
kobject: 'queues' (00000000c713b3f3): kobject_uevent_env
kobject: 'queues' (00000000c713b3f3): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (00000000f6dff904): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (00000000f6dff904): kobject_uevent_env
kobject: 'rx-0' (00000000f6dff904): fill_kobj_path: path  
= '/devices/virtual/net/ip6gretap0/queues/rx-0'
kobject: 'tx-0' (00000000feeaf085): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (00000000feeaf085): kobject_uevent_env
kobject: 'tx-0' (00000000feeaf085): fill_kobj_path: path  
= '/devices/virtual/net/ip6gretap0/queues/tx-0'
kobject: 'erspan0' (0000000052540aab): kobject_cleanup, parent            
(null)
kobject: 'erspan0' (0000000052540aab): auto cleanup 'remove' event
kobject: 'erspan0' (0000000052540aab): kobject_uevent_env
kobject: 'erspan0' (0000000052540aab): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'bridge0' (00000000e2bce9cc): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'erspan0' (0000000052540aab): calling ktype release
kobject: 'bridge0' (00000000e2bce9cc): kobject_uevent_env
kobject: 'erspan0': free name
kobject: 'bridge0' (00000000e2bce9cc): fill_kobj_path: path  
= '/devices/virtual/net/bridge0'
kobject: 'queues' (0000000049b86b17): kobject_add_internal:  
parent: 'bridge0', set: '<NULL>'
kobject: 'queues' (0000000049b86b17): kobject_uevent_env
kobject: 'queues' (0000000049b86b17): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (00000000fcbc6fd7): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (00000000fcbc6fd7): kobject_uevent_env
kobject: 'rx-0' (00000000fcbc6fd7): fill_kobj_path: path  
= '/devices/virtual/net/bridge0/queues/rx-0'
kobject: 'tx-0' (00000000d0344d28): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (00000000d0344d28): kobject_uevent_env
kobject: 'tx-0' (00000000d0344d28): fill_kobj_path: path  
= '/devices/virtual/net/bridge0/queues/tx-0'
kobject: 'brif' (000000007a37434f): kobject_add_internal:  
parent: 'bridge0', set: '<NULL>'
kobject: 'rx-0' (000000005ee3a711): kobject_cleanup, parent 0000000016405e31
kobject: 'rx-0' (000000005ee3a711): auto cleanup 'remove' event
kobject: 'rx-0' (000000005ee3a711): kobject_uevent_env
kobject: 'rx-0' (000000005ee3a711): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (000000005ee3a711): auto cleanup kobject_del
kobject: 'rx-0' (000000005ee3a711): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (00000000a97f88e2): kobject_cleanup, parent 0000000016405e31
kobject: 'tx-0' (00000000a97f88e2): auto cleanup 'remove' event
kobject: 'tx-0' (00000000a97f88e2): kobject_uevent_env
kobject: 'tx-0' (00000000a97f88e2): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (00000000a97f88e2): auto cleanup kobject_del
kobject: 'tx-0' (00000000a97f88e2): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (0000000016405e31): kobject_cleanup, parent            
(null)
kobject: 'queues' (0000000016405e31): calling ktype release
kobject: 'queues' (0000000016405e31): kset_release
kobject: 'queues': free name
kobject: 'gretap0' (00000000824284dd): kobject_uevent_env
kobject: 'gretap0' (00000000824284dd): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'vcan0' (00000000141d4fc4): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'vcan0' (00000000141d4fc4): kobject_uevent_env
kobject: 'vcan0' (00000000141d4fc4): fill_kobj_path: path  
= '/devices/virtual/net/vcan0'
kobject: 'queues' (00000000a1678197): kobject_add_internal:  
parent: 'vcan0', set: '<NULL>'
kobject: 'queues' (00000000a1678197): kobject_uevent_env
kobject: 'queues' (00000000a1678197): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (000000006b759fce): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (000000006b759fce): kobject_uevent_env
kobject: 'rx-0' (000000006b759fce): fill_kobj_path: path  
= '/devices/virtual/net/vcan0/queues/rx-0'
kobject: 'tx-0' (0000000035aaf586): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (0000000035aaf586): kobject_uevent_env
kobject: 'tx-0' (0000000035aaf586): fill_kobj_path: path  
= '/devices/virtual/net/vcan0/queues/tx-0'
kobject: 'gretap0' (00000000824284dd): kobject_cleanup, parent            
(null)
kobject: 'gretap0' (00000000824284dd): auto cleanup 'remove' event
kobject: 'gretap0' (00000000824284dd): kobject_uevent_env
kobject: 'gretap0' (00000000824284dd): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'gretap0' (00000000824284dd): calling ktype release
kobject: 'bond0' (000000001cdb7291): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'gretap0': free name
kobject: 'bond0' (000000001cdb7291): kobject_uevent_env
kobject: 'bond0' (000000001cdb7291): fill_kobj_path: path  
= '/devices/virtual/net/bond0'
kobject: 'queues' (00000000825b2be9): kobject_add_internal:  
parent: 'bond0', set: '<NULL>'
kobject: 'queues' (00000000825b2be9): kobject_uevent_env
kobject: 'queues' (00000000825b2be9): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (00000000b2f7f6f0): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (00000000b2f7f6f0): kobject_uevent_env
kobject: 'rx-0' (00000000b2f7f6f0): fill_kobj_path: path  
= '/devices/virtual/net/bond0/queues/rx-0'
kobject: 'rx-1' (000000008fc2a0de): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-1' (000000008fc2a0de): kobject_uevent_env
kobject: 'rx-1' (000000008fc2a0de): fill_kobj_path: path  
= '/devices/virtual/net/bond0/queues/rx-1'
kobject: 'rx-2' (00000000199c39a6): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-2' (00000000199c39a6): kobject_uevent_env
kobject: 'rx-2' (00000000199c39a6): fill_kobj_path: path  
= '/devices/virtual/net/bond0/queues/rx-2'
kobject: 'rx-3' (00000000a2d849c4): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-3' (00000000a2d849c4): kobject_uevent_env
kobject: 'rx-3' (00000000a2d849c4): fill_kobj_path: path  
= '/devices/virtual/net/bond0/queues/rx-3'
kobject: 'rx-4' (00000000148540fa): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-4' (00000000148540fa): kobject_uevent_env
kobject: 'rx-4' (00000000148540fa): fill_kobj_path: path  
= '/devices/virtual/net/bond0/queues/rx-4'
kobject: 'rx-5' (00000000c8b1d924): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-5' (00000000c8b1d924): kobject_uevent_env
kobject: 'rx-5' (00000000c8b1d924): fill_kobj_path: path  
= '/devices/virtual/net/bond0/queues/rx-5'
kobject: 'rx-6' (0000000043b82ecc): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-6' (0000000043b82ecc): kobject_uevent_env
kobject: 'rx-6' (0000000043b82ecc): fill_kobj_path: path  
= '/devices/virtual/net/bond0/queues/rx-6'
kobject: 'rx-7' (000000006f9e9547): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-7' (000000006f9e9547): kobject_uevent_env
kobject: 'rx-7' (000000006f9e9547): fill_kobj_path: path  
= '/devices/virtual/net/bond0/queues/rx-7'
kobject: 'rx-8' (000000002890c8a4): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-8' (000000002890c8a4): kobject_uevent_env
kobject: 'rx-8' (000000002890c8a4): fill_kobj_path: path  
= '/devices/virtual/net/bond0/queues/rx-8'
kobject: 'rx-9' (00000000fc9d56f9): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-9' (00000000fc9d56f9): kobject_uevent_env
kobject: 'rx-9' (00000000fc9d56f9): fill_kobj_path: path  
= '/devices/virtual/net/bond0/queues/rx-9'
kobject: 'rx-10' (0000000018b8739d): kobject_add_internal:  
parent: 'queues', set: 'queues'
kobject: 'rx-10' (0000000018b8739d): kobject_uevent_env
kobject: 'rx-10' (0000000018b8739d): fill_kobj_path: path  
= '/devices/virtual/net/bond0/queues/rx-10'
kobject: 'rx-11' (00000000f1f36f79): kobject_add_internal:  
parent: 'queues', set: 'queues'
kobject: 'rx-11' (00000000f1f36f79): kobject_uevent_env
kobject: 'rx-11' (00000000f1f36f79): fill_kobj_path: path  
= '/devices/virtual/net/bond0/queues/rx-11'
kobject: 'rx-12' (00000000bfcf4446): kobject_add_internal:  
parent: 'queues', set: 'queues'
kobject: 'rx-12' (00000000bfcf4446): kobject_uevent_env
kobject: 'rx-12' (00000000bfcf4446): fill_kobj_path: path  
= '/devices/virtual/net/bond0/queues/rx-12'
kobject: 'rx-13' (000000003de204f6): kobject_add_internal:  
parent: 'queues', set: 'queues'
kobject: 'rx-13' (000000003de204f6): kobject_uevent_env
kobject: 'rx-13' (000000003de204f6): fill_kobj_path: path  
= '/devices/virtual/net/bond0/queues/rx-13'
kobject: 'rx-14' (000000008bd08862): kobject_add_internal:  
parent: 'queues', set: 'queues'
kobject: 'rx-14' (000000008bd08862): kobject_uevent_env
kobject: 'rx-14' (000000008bd08862): fill_kobj_path: path  
= '/devices/virtual/net/bond0/queues/rx-14'
kobject: 'rx-15' (00000000ce03bab1): kobject_add_internal:  
parent: 'queues', set: 'queues'
kobject: 'rx-15' (00000000ce03bab1): kobject_uevent_env
kobject: 'rx-15' (00000000ce03bab1): fill_kobj_path: path  
= '/devices/virtual/net/bond0/queues/rx-15'
kobject: 'tx-0' (000000002a9dcc4c): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (000000002a9dcc4c): kobject_uevent_env
kobject: 'tx-0' (000000002a9dcc4c): fill_kobj_path: path  
= '/devices/virtual/net/bond0/queues/tx-0'
kobject: 'tx-1' (00000000f1f2655c): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-1' (00000000f1f2655c): kobject_uevent_env
kobject: 'tx-1' (00000000f1f2655c): fill_kobj_path: path  
= '/devices/virtual/net/bond0/queues/tx-1'
kobject: 'tx-2' (00000000d5f44323): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-2' (00000000d5f44323): kobject_uevent_env
kobject: 'tx-2' (00000000d5f44323): fill_kobj_path: path  
= '/devices/virtual/net/bond0/queues/tx-2'
kobject: 'tx-3' (0000000000a825ae): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-3' (0000000000a825ae): kobject_uevent_env
kobject: 'tx-3' (0000000000a825ae): fill_kobj_path: path  
= '/devices/virtual/net/bond0/queues/tx-3'
kobject: 'tx-4' (00000000fa6c1780): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-4' (00000000fa6c1780): kobject_uevent_env
kobject: 'tx-4' (00000000fa6c1780): fill_kobj_path: path  
= '/devices/virtual/net/bond0/queues/tx-4'
kobject: 'tx-5' (00000000b377ea6f): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-5' (00000000b377ea6f): kobject_uevent_env
kobject: 'tx-5' (00000000b377ea6f): fill_kobj_path: path  
= '/devices/virtual/net/bond0/queues/tx-5'
kobject: 'tx-6' (000000004ab2464a): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-6' (000000004ab2464a): kobject_uevent_env
kobject: 'tx-6' (000000004ab2464a): fill_kobj_path: path  
= '/devices/virtual/net/bond0/queues/tx-6'
kobject: 'tx-7' (0000000003b7fb01): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-7' (0000000003b7fb01): kobject_uevent_env
kobject: 'tx-7' (0000000003b7fb01): fill_kobj_path: path  
= '/devices/virtual/net/bond0/queues/tx-7'
kobject: 'tx-8' (00000000b02586fd): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-8' (00000000b02586fd): kobject_uevent_env
kobject: 'tx-8' (00000000b02586fd): fill_kobj_path: path  
= '/devices/virtual/net/bond0/queues/tx-8'
kobject: 'tx-9' (00000000d0ed9729): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-9' (00000000d0ed9729): kobject_uevent_env
kobject: 'tx-9' (00000000d0ed9729): fill_kobj_path: path  
= '/devices/virtual/net/bond0/queues/tx-9'
kobject: 'tx-10' (00000000df868fae): kobject_add_internal:  
parent: 'queues', set: 'queues'
kobject: 'tx-10' (00000000df868fae): kobject_uevent_env
kobject: 'tx-10' (00000000df868fae): fill_kobj_path: path  
= '/devices/virtual/net/bond0/queues/tx-10'
kobject: 'tx-11' (00000000824c3293): kobject_add_internal:  
parent: 'queues', set: 'queues'
kobject: 'tx-11' (00000000824c3293): kobject_uevent_env
kobject: 'tx-11' (00000000824c3293): fill_kobj_path: path  
= '/devices/virtual/net/bond0/queues/tx-11'
kobject: 'tx-12' (00000000a68767ed): kobject_add_internal:  
parent: 'queues', set: 'queues'
kobject: 'tx-12' (00000000a68767ed): kobject_uevent_env
kobject: 'tx-12' (00000000a68767ed): fill_kobj_path: path  
= '/devices/virtual/net/bond0/queues/tx-12'
kobject: 'tx-13' (00000000e9ea6f5c): kobject_add_internal:  
parent: 'queues', set: 'queues'
kobject: 'tx-13' (00000000e9ea6f5c): kobject_uevent_env
kobject: 'tx-13' (00000000e9ea6f5c): fill_kobj_path: path  
= '/devices/virtual/net/bond0/queues/tx-13'
kobject: 'tx-14' (0000000090393de6): kobject_add_internal:  
parent: 'queues', set: 'queues'
kobject: 'tx-14' (0000000090393de6): kobject_uevent_env
kobject: 'tx-14' (0000000090393de6): fill_kobj_path: path  
= '/devices/virtual/net/bond0/queues/tx-14'
kobject: 'tx-15' (000000004f77d1c6): kobject_add_internal:  
parent: 'queues', set: 'queues'
kobject: 'tx-15' (000000004f77d1c6): kobject_uevent_env
kobject: 'tx-15' (000000004f77d1c6): fill_kobj_path: path  
= '/devices/virtual/net/bond0/queues/tx-15'
kobject: 'rx-0' (000000005379f01a): kobject_cleanup, parent 000000005d14967f
kobject: 'rx-0' (000000005379f01a): auto cleanup 'remove' event
kobject: 'rx-0' (000000005379f01a): kobject_uevent_env
kobject: 'rx-0' (000000005379f01a): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (000000005379f01a): auto cleanup kobject_del
kobject: 'rx-0' (000000005379f01a): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (000000008ead1750): kobject_cleanup, parent 000000005d14967f
kobject: 'tx-0' (000000008ead1750): auto cleanup 'remove' event
kobject: 'tx-0' (000000008ead1750): kobject_uevent_env
kobject: 'tx-0' (000000008ead1750): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (000000008ead1750): auto cleanup kobject_del
kobject: 'tx-0' (000000008ead1750): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (000000005d14967f): kobject_cleanup, parent            
(null)
kobject: 'queues' (000000005d14967f): calling ktype release
kobject: 'queues' (000000005d14967f): kset_release
kobject: 'queues': free name
kobject: 'gre0' (000000006fec7d49): kobject_uevent_env
kobject: 'gre0' (000000006fec7d49): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'team0' (0000000089558457): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'team0' (0000000089558457): kobject_uevent_env
kobject: 'team0' (0000000089558457): fill_kobj_path: path  
= '/devices/virtual/net/team0'
kobject: 'queues' (00000000d9dde1ec): kobject_add_internal:  
parent: 'team0', set: '<NULL>'
kobject: 'queues' (00000000d9dde1ec): kobject_uevent_env
kobject: 'queues' (00000000d9dde1ec): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (000000005a151b0c): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (000000005a151b0c): kobject_uevent_env
kobject: 'rx-0' (000000005a151b0c): fill_kobj_path: path  
= '/devices/virtual/net/team0/queues/rx-0'
kobject: 'rx-1' (000000001c7f51c5): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-1' (000000001c7f51c5): kobject_uevent_env
kobject: 'rx-1' (000000001c7f51c5): fill_kobj_path: path  
= '/devices/virtual/net/team0/queues/rx-1'
kobject: 'rx-2' (000000000ba1aa7f): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-2' (000000000ba1aa7f): kobject_uevent_env
kobject: 'rx-2' (000000000ba1aa7f): fill_kobj_path: path  
= '/devices/virtual/net/team0/queues/rx-2'
kobject: 'rx-3' (000000009dfa4ae9): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-3' (000000009dfa4ae9): kobject_uevent_env
kobject: 'rx-3' (000000009dfa4ae9): fill_kobj_path: path  
= '/devices/virtual/net/team0/queues/rx-3'
kobject: 'rx-4' (00000000089511aa): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-4' (00000000089511aa): kobject_uevent_env
kobject: 'rx-4' (00000000089511aa): fill_kobj_path: path  
= '/devices/virtual/net/team0/queues/rx-4'
kobject: 'rx-5' (000000004b2f454c): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-5' (000000004b2f454c): kobject_uevent_env
kobject: 'rx-5' (000000004b2f454c): fill_kobj_path: path  
= '/devices/virtual/net/team0/queues/rx-5'
kobject: 'rx-6' (00000000edbf7376): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-6' (00000000edbf7376): kobject_uevent_env
kobject: 'rx-6' (00000000edbf7376): fill_kobj_path: path  
= '/devices/virtual/net/team0/queues/rx-6'
kobject: 'rx-7' (00000000f601bdf2): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-7' (00000000f601bdf2): kobject_uevent_env
kobject: 'rx-7' (00000000f601bdf2): fill_kobj_path: path  
= '/devices/virtual/net/team0/queues/rx-7'
kobject: 'rx-8' (0000000070b0fc62): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-8' (0000000070b0fc62): kobject_uevent_env
kobject: 'rx-8' (0000000070b0fc62): fill_kobj_path: path  
= '/devices/virtual/net/team0/queues/rx-8'
kobject: 'rx-9' (00000000eb53dc4c): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-9' (00000000eb53dc4c): kobject_uevent_env
kobject: 'rx-9' (00000000eb53dc4c): fill_kobj_path: path  
= '/devices/virtual/net/team0/queues/rx-9'
kobject: 'rx-10' (00000000505e5066): kobject_add_internal:  
parent: 'queues', set: 'queues'
kobject: 'rx-10' (00000000505e5066): kobject_uevent_env
kobject: 'rx-10' (00000000505e5066): fill_kobj_path: path  
= '/devices/virtual/net/team0/queues/rx-10'
kobject: 'rx-11' (00000000a6c89e50): kobject_add_internal:  
parent: 'queues', set: 'queues'
kobject: 'rx-11' (00000000a6c89e50): kobject_uevent_env
kobject: 'rx-11' (00000000a6c89e50): fill_kobj_path: path  
= '/devices/virtual/net/team0/queues/rx-11'
kobject: 'rx-12' (000000007ec9f38a): kobject_add_internal:  
parent: 'queues', set: 'queues'
kobject: 'rx-12' (000000007ec9f38a): kobject_uevent_env
kobject: 'rx-12' (000000007ec9f38a): fill_kobj_path: path  
= '/devices/virtual/net/team0/queues/rx-12'
kobject: 'rx-13' (00000000150da95e): kobject_add_internal:  
parent: 'queues', set: 'queues'
kobject: 'rx-13' (00000000150da95e): kobject_uevent_env
kobject: 'rx-13' (00000000150da95e): fill_kobj_path: path  
= '/devices/virtual/net/team0/queues/rx-13'
kobject: 'rx-14' (00000000dc488f8c): kobject_add_internal:  
parent: 'queues', set: 'queues'
kobject: 'rx-14' (00000000dc488f8c): kobject_uevent_env
kobject: 'rx-14' (00000000dc488f8c): fill_kobj_path: path  
= '/devices/virtual/net/team0/queues/rx-14'
kobject: 'rx-15' (0000000040c3716a): kobject_add_internal:  
parent: 'queues', set: 'queues'
kobject: 'rx-15' (0000000040c3716a): kobject_uevent_env
kobject: 'rx-15' (0000000040c3716a): fill_kobj_path: path  
= '/devices/virtual/net/team0/queues/rx-15'
kobject: 'tx-0' (00000000a4895cbd): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (00000000a4895cbd): kobject_uevent_env
kobject: 'tx-0' (00000000a4895cbd): fill_kobj_path: path  
= '/devices/virtual/net/team0/queues/tx-0'
kobject: 'tx-1' (00000000c5078b7c): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-1' (00000000c5078b7c): kobject_uevent_env
kobject: 'tx-1' (00000000c5078b7c): fill_kobj_path: path  
= '/devices/virtual/net/team0/queues/tx-1'
kobject: 'tx-2' (00000000ed68efc7): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-2' (00000000ed68efc7): kobject_uevent_env
kobject: 'tx-2' (00000000ed68efc7): fill_kobj_path: path  
= '/devices/virtual/net/team0/queues/tx-2'
kobject: 'tx-3' (00000000f3ece12d): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-3' (00000000f3ece12d): kobject_uevent_env
kobject: 'tx-3' (00000000f3ece12d): fill_kobj_path: path  
= '/devices/virtual/net/team0/queues/tx-3'
kobject: 'tx-4' (00000000980d7b3f): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-4' (00000000980d7b3f): kobject_uevent_env
kobject: 'tx-4' (00000000980d7b3f): fill_kobj_path: path  
= '/devices/virtual/net/team0/queues/tx-4'
kobject: 'tx-5' (000000009beb42cd): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-5' (000000009beb42cd): kobject_uevent_env
kobject: 'tx-5' (000000009beb42cd): fill_kobj_path: path  
= '/devices/virtual/net/team0/queues/tx-5'
kobject: 'tx-6' (000000006dce3045): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-6' (000000006dce3045): kobject_uevent_env
kobject: 'tx-6' (000000006dce3045): fill_kobj_path: path  
= '/devices/virtual/net/team0/queues/tx-6'
kobject: 'tx-7' (00000000f8ddf9a2): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-7' (00000000f8ddf9a2): kobject_uevent_env
kobject: 'tx-7' (00000000f8ddf9a2): fill_kobj_path: path  
= '/devices/virtual/net/team0/queues/tx-7'
kobject: 'tx-8' (0000000098922d6f): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-8' (0000000098922d6f): kobject_uevent_env
kobject: 'tx-8' (0000000098922d6f): fill_kobj_path: path  
= '/devices/virtual/net/team0/queues/tx-8'
kobject: 'tx-9' (000000002ae7fd25): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-9' (000000002ae7fd25): kobject_uevent_env
kobject: 'tx-9' (000000002ae7fd25): fill_kobj_path: path  
= '/devices/virtual/net/team0/queues/tx-9'
kobject: 'tx-10' (00000000ccfdd320): kobject_add_internal:  
parent: 'queues', set: 'queues'
kobject: 'tx-10' (00000000ccfdd320): kobject_uevent_env
kobject: 'tx-10' (00000000ccfdd320): fill_kobj_path: path  
= '/devices/virtual/net/team0/queues/tx-10'
kobject: 'tx-11' (000000002b641f46): kobject_add_internal:  
parent: 'queues', set: 'queues'
kobject: 'tx-11' (000000002b641f46): kobject_uevent_env
kobject: 'tx-11' (000000002b641f46): fill_kobj_path: path  
= '/devices/virtual/net/team0/queues/tx-11'
kobject: 'tx-12' (00000000d18fec74): kobject_add_internal:  
parent: 'queues', set: 'queues'
kobject: 'tx-12' (00000000d18fec74): kobject_uevent_env
kobject: 'tx-12' (00000000d18fec74): fill_kobj_path: path  
= '/devices/virtual/net/team0/queues/tx-12'
kobject: 'tx-13' (00000000e9c65428): kobject_add_internal:  
parent: 'queues', set: 'queues'
kobject: 'tx-13' (00000000e9c65428): kobject_uevent_env
kobject: 'tx-13' (00000000e9c65428): fill_kobj_path: path  
= '/devices/virtual/net/team0/queues/tx-13'
kobject: 'tx-14' (000000005bddf288): kobject_add_internal:  
parent: 'queues', set: 'queues'
kobject: 'tx-14' (000000005bddf288): kobject_uevent_env
kobject: 'tx-14' (000000005bddf288): fill_kobj_path: path  
= '/devices/virtual/net/team0/queues/tx-14'
kobject: 'tx-15' (00000000d01ed49d): kobject_add_internal:  
parent: 'queues', set: 'queues'
kobject: 'tx-15' (00000000d01ed49d): kobject_uevent_env
kobject: 'tx-15' (00000000d01ed49d): fill_kobj_path: path  
= '/devices/virtual/net/team0/queues/tx-15'
kobject: 'gre0' (000000006fec7d49): kobject_cleanup, parent           (null)
kobject: 'gre0' (000000006fec7d49): auto cleanup 'remove' event
kobject: 'gre0' (000000006fec7d49): kobject_uevent_env
kobject: 'gre0' (000000006fec7d49): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'veth0' (00000000512828dd): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'gre0' (000000006fec7d49): calling ktype release
kobject: 'veth0' (00000000512828dd): kobject_uevent_env
kobject: 'gre0': free name
kobject: 'veth0' (00000000512828dd): fill_kobj_path: path  
= '/devices/virtual/net/veth0'
kobject: 'queues' (00000000bbc1779d): kobject_add_internal:  
parent: 'veth0', set: '<NULL>'
kobject: 'queues' (00000000bbc1779d): kobject_uevent_env
kobject: 'queues' (00000000bbc1779d): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (00000000424dddef): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (00000000424dddef): kobject_uevent_env
kobject: 'rx-0' (00000000424dddef): fill_kobj_path: path  
= '/devices/virtual/net/veth0/queues/rx-0'
kobject: 'tx-0' (000000008a5bdde9): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (000000008a5bdde9): kobject_uevent_env
kobject: 'tx-0' (000000008a5bdde9): fill_kobj_path: path  
= '/devices/virtual/net/veth0/queues/tx-0'
kobject: 'veth1' (00000000cf08bd50): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'veth1' (00000000cf08bd50): kobject_uevent_env
kobject: 'veth1' (00000000cf08bd50): fill_kobj_path: path  
= '/devices/virtual/net/veth1'
kobject: 'queues' (0000000045734fcd): kobject_add_internal:  
parent: 'veth1', set: '<NULL>'
kobject: 'queues' (0000000045734fcd): kobject_uevent_env
kobject: 'queues' (0000000045734fcd): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (0000000037085f1a): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (0000000037085f1a): kobject_uevent_env
kobject: 'rx-0' (0000000037085f1a): fill_kobj_path: path  
= '/devices/virtual/net/veth1/queues/rx-0'
kobject: 'tx-0' (00000000555f3e86): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (00000000555f3e86): kobject_uevent_env
kobject: 'tx-0' (00000000555f3e86): fill_kobj_path: path  
= '/devices/virtual/net/veth1/queues/tx-0'
kobject: 'rx-0' (000000001b56b401): kobject_cleanup, parent 000000004abb143b
kobject: 'rx-0' (000000001b56b401): auto cleanup 'remove' event
kobject: 'rx-0' (000000001b56b401): kobject_uevent_env
kobject: 'rx-0' (000000001b56b401): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (000000001b56b401): auto cleanup kobject_del
kobject: 'rx-0' (000000001b56b401): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (00000000932c7a15): kobject_cleanup, parent 000000004abb143b
kobject: 'tx-0' (00000000932c7a15): auto cleanup 'remove' event
kobject: 'tx-0' (00000000932c7a15): kobject_uevent_env
kobject: 'tx-0' (00000000932c7a15): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (00000000932c7a15): auto cleanup kobject_del
kobject: 'tx-0' (00000000932c7a15): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (000000004abb143b): kobject_cleanup, parent            
(null)
kobject: 'queues' (000000004abb143b): calling ktype release
kobject: 'queues' (000000004abb143b): kset_release
kobject: 'queues': free name
kobject: 'tunl0' (00000000a447bd2c): kobject_uevent_env
kobject: 'tunl0' (00000000a447bd2c): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'veth0_to_bridge' (00000000f588c241): kobject_add_internal:  
parent: 'net', set: 'devices'
kobject: 'veth0_to_bridge' (00000000f588c241): kobject_uevent_env
kobject: 'veth0_to_bridge' (00000000f588c241): fill_kobj_path: path  
= '/devices/virtual/net/veth0_to_bridge'
kobject: 'queues' (00000000737a8dd3): kobject_add_internal:  
parent: 'veth0_to_bridge', set: '<NULL>'
kobject: 'queues' (00000000737a8dd3): kobject_uevent_env
kobject: 'queues' (00000000737a8dd3): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (00000000a350fd8a): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (00000000a350fd8a): kobject_uevent_env
kobject: 'rx-0' (00000000a350fd8a): fill_kobj_path: path  
= '/devices/virtual/net/veth0_to_bridge/queues/rx-0'
kobject: 'tx-0' (00000000eeb75589): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (00000000eeb75589): kobject_uevent_env
kobject: 'tx-0' (00000000eeb75589): fill_kobj_path: path  
= '/devices/virtual/net/veth0_to_bridge/queues/tx-0'
kobject: 'bridge_slave_0' (00000000d16dd752): kobject_add_internal:  
parent: 'net', set: 'devices'
kobject: 'bridge_slave_0' (00000000d16dd752): kobject_uevent_env
kobject: 'bridge_slave_0' (00000000d16dd752): fill_kobj_path: path  
= '/devices/virtual/net/bridge_slave_0'
kobject: 'queues' (00000000bbc96315): kobject_add_internal:  
parent: 'bridge_slave_0', set: '<NULL>'
kobject: 'queues' (00000000bbc96315): kobject_uevent_env
kobject: 'queues' (00000000bbc96315): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (00000000b7825031): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (00000000b7825031): kobject_uevent_env
kobject: 'rx-0' (00000000b7825031): fill_kobj_path: path  
= '/devices/virtual/net/bridge_slave_0/queues/rx-0'
kobject: 'tx-0' (0000000097036847): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (0000000097036847): kobject_uevent_env
kobject: 'tx-0' (0000000097036847): fill_kobj_path: path  
= '/devices/virtual/net/bridge_slave_0/queues/tx-0'
kobject: 'tunl0' (00000000a447bd2c): kobject_cleanup, parent            
(null)
kobject: 'tunl0' (00000000a447bd2c): auto cleanup 'remove' event
kobject: 'tunl0' (00000000a447bd2c): kobject_uevent_env
kobject: 'tunl0' (00000000a447bd2c): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'veth1_to_bridge' (00000000060f8af3): kobject_add_internal:  
parent: 'net', set: 'devices'
kobject: 'tunl0' (00000000a447bd2c): calling ktype release
kobject: 'veth1_to_bridge' (00000000060f8af3): kobject_uevent_env
kobject: 'tunl0': free name
kobject: 'veth1_to_bridge' (00000000060f8af3): fill_kobj_path: path  
= '/devices/virtual/net/veth1_to_bridge'
kobject: 'queues' (0000000059270930): kobject_add_internal:  
parent: 'veth1_to_bridge', set: '<NULL>'
kobject: 'queues' (0000000059270930): kobject_uevent_env
kobject: 'queues' (0000000059270930): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (00000000afd1f8f9): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (00000000afd1f8f9): kobject_uevent_env
kobject: 'rx-0' (00000000afd1f8f9): fill_kobj_path: path  
= '/devices/virtual/net/veth1_to_bridge/queues/rx-0'
kobject: 'tx-0' (0000000052aa64f9): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (0000000052aa64f9): kobject_uevent_env
kobject: 'tx-0' (0000000052aa64f9): fill_kobj_path: path  
= '/devices/virtual/net/veth1_to_bridge/queues/tx-0'
kobject: 'bridge_slave_1' (000000007a1a682f): kobject_add_internal:  
parent: 'net', set: 'devices'
kobject: 'bridge_slave_1' (000000007a1a682f): kobject_uevent_env
kobject: 'bridge_slave_1' (000000007a1a682f): fill_kobj_path: path  
= '/devices/virtual/net/bridge_slave_1'
kobject: 'queues' (0000000088d41fda): kobject_add_internal:  
parent: 'bridge_slave_1', set: '<NULL>'
kobject: 'queues' (0000000088d41fda): kobject_uevent_env
kobject: 'queues' (0000000088d41fda): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (000000000da42a1b): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (000000000da42a1b): kobject_uevent_env
kobject: 'rx-0' (000000000da42a1b): fill_kobj_path: path  
= '/devices/virtual/net/bridge_slave_1/queues/rx-0'
kobject: 'tx-0' (00000000bce3f6c2): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (00000000bce3f6c2): kobject_uevent_env
kobject: 'tx-0' (00000000bce3f6c2): fill_kobj_path: path  
= '/devices/virtual/net/bridge_slave_1/queues/tx-0'
device bridge_slave_1 left promiscuous mode
bridge0: port 2(bridge_slave_1) entered disabled state
kobject: 'brport' (00000000b349e2be): kobject_uevent_env
kobject: 'brport' (00000000b349e2be): kobject_uevent_env: filter function  
caused the event to drop!
device bridge_slave_0 left promiscuous mode
bridge0: port 1(bridge_slave_0) entered disabled state
kobject: 'brport' (00000000b349e2be): kobject_cleanup, parent            
(null)
kobject: 'brport' (00000000b349e2be): calling ktype release
kobject: 'brport': free name
kobject: 'brport' (0000000074bec5d7): kobject_uevent_env
kobject: 'brport' (0000000074bec5d7): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'brif' (000000008ff3bd3b): kobject_cleanup, parent 0000000030fc7379
kobject: 'brif' (000000008ff3bd3b): auto cleanup kobject_del
kobject: 'brif' (000000008ff3bd3b): calling ktype release
kobject: (000000008ff3bd3b): dynamic_kobj_release
kobject: 'brif': free name
kobject: 'brport' (0000000074bec5d7): kobject_cleanup, parent            
(null)
kobject: 'brport' (0000000074bec5d7): calling ktype release
kobject: 'brport': free name
team0 (unregistering): Port device team_slave_1 removed
kobject: 'rx-0' (0000000058e2b7b4): kobject_cleanup, parent 0000000071914e83
kobject: 'rx-0' (0000000058e2b7b4): auto cleanup 'remove' event
kobject: 'rx-0' (0000000058e2b7b4): kobject_uevent_env
kobject: 'rx-0' (0000000058e2b7b4): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (0000000058e2b7b4): auto cleanup kobject_del
kobject: 'rx-0' (0000000058e2b7b4): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (00000000c2a2cea5): kobject_cleanup, parent 0000000071914e83
kobject: 'tx-0' (00000000c2a2cea5): auto cleanup 'remove' event
kobject: 'tx-0' (00000000c2a2cea5): kobject_uevent_env
kobject: 'tx-0' (00000000c2a2cea5): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (00000000c2a2cea5): auto cleanup kobject_del
kobject: 'tx-0' (00000000c2a2cea5): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (0000000071914e83): kobject_cleanup, parent            
(null)
kobject: 'queues' (0000000071914e83): calling ktype release
kobject: 'queues' (0000000071914e83): kset_release
kobject: 'queues': free name
kobject: 'team_slave_1' (00000000e291c51c): kobject_uevent_env
kobject: 'team_slave_1' (00000000e291c51c): kobject_uevent_env:  
uevent_suppress caused the event to drop!
kobject: 'rx-0' (0000000070e061d3): kobject_cleanup, parent 00000000c6e92a5c
kobject: 'rx-0' (0000000070e061d3): auto cleanup 'remove' event
kobject: 'rx-0' (0000000070e061d3): kobject_uevent_env
kobject: 'rx-0' (0000000070e061d3): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (0000000070e061d3): auto cleanup kobject_del
kobject: 'rx

---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
