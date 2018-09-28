Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3269EC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 05:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F863216FA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 05:51:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F863216FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbeI1MNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 08:13:08 -0400
Received: from mail-it1-f198.google.com ([209.85.166.198]:53269 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbeI1MNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 08:13:08 -0400
Received: by mail-it1-f198.google.com with SMTP id e21-v6so246396itc.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 22:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=h0zv27CGvBJcFRvbN4vDC7wL6hZQyfW/fIHzLFBt0SU=;
        b=dDN6wc87VVNZzGDGSwiFMHOyJLsQlxGpUySK0enI0jG/sPtACK1UB+M8V4CHVMQ6ef
         NeHey/iD0Gv6flu/iGKcOUbRX2rj+4Uqqz8K8LnnleXD07XCnOBNigOBfw2PySLAL4K+
         +BiPwXp/VQ2tdrLj5EmHtwLIy621d9ZiCO1c/ddVvQtjG3V8A5DZvAP5j/LKjpgWC0Ih
         nTR87W4hDThagV0YkiU2ufsxMxv7X9me1gpCh2cUFg7iG+BHHn0rgUz3naAqaXW/O8ef
         kmB2AFVkdN3gYxw0/VMZ0TcQ5z7PaUQDJ81JBOZWZuF1MIYDqHmdcnhzBVgazsT0+QfM
         WqzQ==
X-Gm-Message-State: ABuFfoij1FGim8bQRHRAh6FwuEfEImMevguMBxNL2RP81J16PM7axRvJ
        m5YdNST4JnwpXT4hS4MtOOy2zTK2YiWYf/yHRWYKXLaYhrTw
X-Google-Smtp-Source: ACcGV6297JnDNmpXNSMzY99LKV8o6w1MQEkVWmxDuW5sSRs89XUveHw+WiHxX9N8EClErqy625zouU1XJajRFVJO0IL4qtb5s6sd
MIME-Version: 1.0
X-Received: by 2002:a24:2b87:: with SMTP id h129-v6mr679497ita.13.1538113863484;
 Thu, 27 Sep 2018 22:51:03 -0700 (PDT)
Date:   Thu, 27 Sep 2018 22:51:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007523a60576e80a47@google.com>
Subject: BUG: MAX_LOCKDEP_CHAINS too low!
From:   syzbot <syzbot+aaa6fa4949cc5d9b7b25@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    c307aaf3eb47 Merge tag 'iommu-fixes-v4.19-rc5' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13810df1400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dfb440e26f0a6f6f
dashboard link: https://syzkaller.appspot.com/bug?extid=aaa6fa4949cc5d9b7b25
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+aaa6fa4949cc5d9b7b25@syzkaller.appspotmail.com

BUG: MAX_LOCKDEP_CHAINS too low!
turning off the locking correctness validator.
CPU: 0 PID: 9480 Comm: syz-executor4 Not tainted 4.19.0-rc5+ #256
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
  add_chain_cache kernel/locking/lockdep.c:2254 [inline]
  lookup_chain_cache_add kernel/locking/lockdep.c:2366 [inline]
  validate_chain kernel/locking/lockdep.c:2386 [inline]
  __lock_acquire.cold.61+0x337/0x482 kernel/locking/lockdep.c:3411
  lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3900
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0x99/0xd0 kernel/locking/spinlock.c:152
  debug_object_activate+0x1d4/0x600 lib/debugobjects.c:473
  debug_hrtimer_activate kernel/time/hrtimer.c:416 [inline]
  debug_activate kernel/time/hrtimer.c:465 [inline]
  enqueue_hrtimer+0x97/0x560 kernel/time/hrtimer.c:954
  __hrtimer_start_range_ns kernel/time/hrtimer.c:1089 [inline]
  hrtimer_start_range_ns+0x640/0xe00 kernel/time/hrtimer.c:1115
  hrtimer_start include/linux/hrtimer.h:398 [inline]
  perf_swevent_start_hrtimer.part.74+0x19a/0x260 kernel/events/core.c:9145
  perf_swevent_start_hrtimer kernel/events/core.c:9133 [inline]
  cpu_clock_event_start+0x127/0x180 kernel/events/core.c:9203
  cpu_clock_event_add+0x4d/0x50 kernel/events/core.c:9215
  event_sched_in.isra.107+0x43c/0xe40 kernel/events/core.c:2279
  group_sched_in+0xe4/0x400 kernel/events/core.c:2315
  flexible_sched_in+0x792/0xc70 kernel/events/core.c:3309
  visit_groups_merge+0x380/0x6c0 kernel/events/core.c:3257
  ctx_flexible_sched_in kernel/events/core.c:3343 [inline]
  ctx_sched_in+0x392/0x790 kernel/events/core.c:3388
  perf_event_sched_in+0x6d/0xa0 kernel/events/core.c:2424
  perf_event_context_sched_in kernel/events/core.c:3428 [inline]
  __perf_event_task_sched_in+0x859/0xb60 kernel/events/core.c:3467
  perf_event_task_sched_in include/linux/perf_event.h:1095 [inline]
  finish_task_switch+0x366/0x900 kernel/sched/core.c:2673
  context_switch kernel/sched/core.c:2828 [inline]
  __schedule+0x874/0x1ed0 kernel/sched/core.c:3473
  preempt_schedule_irq+0x87/0x110 kernel/sched/core.c:3700
  retint_kernel+0x1b/0x2d
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:788  
[inline]
RIP: 0010:qlink_free mm/kasan/quarantine.c:150 [inline]
RIP: 0010:qlist_free_all+0xf8/0x140 mm/kasan/quarantine.c:166
Code: 40 10 00 00 00 00 48 83 c4 10 5b 41 5c 41 5d 41 5e 41 5f 5d c3 e8 b8  
8f c2 ff 48 83 3d 78 da af 07 00 74 46 48 8b 7d d0 57 9d <0f> 1f 44 00 00  
eb ae 48 89 df e8 09 1c 76 ff 48 b9 00 00 00 00 00
RSP: 0018:ffff88019362ebb8 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff13
RAX: 0000000000000000 RBX: ffff8801ac0a6a10 RCX: 1ffff10036f289f9
RDX: 0000000000000000 RSI: ffff8801b7944fd0 RDI: 0000000000000286
RBP: ffff88019362ebf0 R08: ffff8801b7944fc8 R09: 0000000000000006
R10: 0000000000000000 R11: ffff8801b7944700 R12: 0000000000000000
R13: ffff8801da94c500 R14: ffff88018e1a5f50 R15: ffffffff89723ac0
  quarantine_reduce+0x163/0x1a0 mm/kasan/quarantine.c:259
  kasan_kmalloc+0x9b/0xe0 mm/kasan/kasan.c:538
  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
  slab_post_alloc_hook mm/slab.h:444 [inline]
  slab_alloc mm/slab.c:3392 [inline]
  __do_kmalloc mm/slab.c:3716 [inline]
  __kmalloc_track_caller+0x133/0x750 mm/slab.c:3733
  kstrdup+0x39/0x70 mm/util.c:56
  kstrdup_const+0x66/0x80 mm/util.c:77
  __kernfs_new_node+0xe8/0x8d0 fs/kernfs/dir.c:630
  kernfs_new_node+0x95/0x120 fs/kernfs/dir.c:695
  kernfs_create_link+0xdb/0x250 fs/kernfs/symlink.c:40
  sysfs_do_create_link_sd.isra.2+0x90/0x130 fs/sysfs/symlink.c:43
  sysfs_do_create_link fs/sysfs/symlink.c:79 [inline]
  sysfs_create_link+0x65/0xc0 fs/sysfs/symlink.c:91
  driver_sysfs_add+0x109/0x350 drivers/base/dd.c:370
  device_bind_driver+0x19/0xd0 drivers/base/dd.c:424
  mac80211_hwsim_new_radio+0x48b/0x3570  
drivers/net/wireless/mac80211_hwsim.c:2688
  hwsim_new_radio_nl+0x7dc/0xb20 drivers/net/wireless/mac80211_hwsim.c:3376
  genl_family_rcv_msg+0x8a9/0x1140 net/netlink/genetlink.c:601
  genl_rcv_msg+0xc6/0x168 net/netlink/genetlink.c:626
  netlink_rcv_skb+0x172/0x440 net/netlink/af_netlink.c:2454
  genl_rcv+0x28/0x40 net/netlink/genetlink.c:637
  netlink_unicast_kernel net/netlink/af_netlink.c:1317 [inline]
  netlink_unicast+0x5a5/0x760 net/netlink/af_netlink.c:1343
  netlink_sendmsg+0xa18/0xfc0 net/netlink/af_netlink.c:1908
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:631
  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2116
  __sys_sendmsg+0x11d/0x280 net/socket.c:2154
  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg net/socket.c:2161 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457579
Code: 1d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f6a204f7c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457579
RDX: 0000000000000000 RSI: 0000000020000080 RDI: 0000000000000004
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f6a204f86d4
R13: 00000000004c3891 R14: 00000000004d56d0 R15: 00000000ffffffff
kobject: 'loop3' (0000000049972f9d): kobject_uevent_env
kobject: 'loop3' (0000000049972f9d): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop2' (000000007177bce6): kobject_uevent_env
kobject: 'loop2' (000000007177bce6): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop5' (0000000033af2aa2): kobject_uevent_env
kobject: 'loop5' (0000000033af2aa2): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop0' (000000001b064100): kobject_uevent_env
kobject: 'loop0' (000000001b064100): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'rx-0' (00000000b5f3f776): kobject_cleanup, parent 0000000027ec32cd
kobject: 'hwsim77' (000000006f94a6e0): kobject_uevent_env
kobject: 'rx-0' (00000000b5f3f776): auto cleanup 'remove' event
kobject: 'hwsim77' (000000006f94a6e0): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim77'
kobject: 'loop5' (0000000033af2aa2): kobject_uevent_env
kobject: 'rx-0' (00000000b5f3f776): kobject_uevent_env
kobject: 'loop5' (0000000033af2aa2): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'rx-0' (00000000b5f3f776): fill_kobj_path: path  
= '/devices/virtual/net/syz_tun/queues/rx-0'
kobject: 'rx-0' (00000000b5f3f776): auto cleanup kobject_del
kobject: 'rx-0' (00000000b5f3f776): calling ktype release
kobject: 'loop3' (0000000049972f9d): kobject_uevent_env
kobject: 'loop3' (0000000049972f9d): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'rx-0': free name
kobject: 'tx-0' (00000000ac11dd12): kobject_cleanup, parent 0000000027ec32cd
kobject: 'tx-0' (00000000ac11dd12): auto cleanup 'remove' event
kobject: 'tx-0' (00000000ac11dd12): kobject_uevent_env
kobject: 'tx-0' (00000000ac11dd12): fill_kobj_path: path  
= '/devices/virtual/net/syz_tun/queues/tx-0'
kobject: 'loop0' (000000001b064100): kobject_uevent_env
kobject: 'tx-0' (00000000ac11dd12): auto cleanup kobject_del
kobject: 'tx-0' (00000000ac11dd12): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (0000000027ec32cd): kobject_cleanup, parent            
(null)
kobject: 'queues' (0000000027ec32cd): calling ktype release
kobject: 'queues' (0000000027ec32cd): kset_release
kobject: 'queues': free name
kobject: 'syz_tun' (000000007668427e): kobject_uevent_env
kobject: 'syz_tun' (000000007668427e): fill_kobj_path: path  
= '/devices/virtual/net/syz_tun'
kobject: 'loop0' (000000001b064100): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'ieee80211' (00000000abea8d1d): kobject_add_internal:  
parent: 'hwsim77', set: '(null)'
kobject: 'phy77' (00000000f56381dc): kobject_add_internal:  
parent: 'ieee80211', set: 'devices'
kobject: 'phy77' (00000000f56381dc): kobject_uevent_env
kobject: 'phy77' (00000000f56381dc): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim77/ieee80211/phy77'
kobject: 'rfkill96' (000000002d5dfeef): kobject_add_internal:  
parent: 'phy77', set: 'devices'
kobject: 'rfkill96' (000000002d5dfeef): kobject_uevent_env
kobject: 'rfkill96' (000000002d5dfeef): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim77/ieee80211/phy77/rfkill96'
kobject: 'rx-0' (00000000c2635233): kobject_cleanup, parent 0000000095e05fe0
kobject: 'rx-0' (00000000c2635233): auto cleanup 'remove' event
kobject: 'rx-0' (00000000c2635233): kobject_uevent_env
kobject: 'loop3' (0000000049972f9d): kobject_uevent_env
kobject: 'rx-0' (00000000c2635233): fill_kobj_path: path  
= '/devices/virtual/net/syz_tun/queues/rx-0'
kobject: 'loop3' (0000000049972f9d): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'rx-0' (00000000c2635233): auto cleanup kobject_del
kobject: 'rx-0' (00000000c2635233): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (00000000f7614753): kobject_cleanup, parent 0000000095e05fe0
kobject: 'tx-0' (00000000f7614753): auto cleanup 'remove' event
kobject: 'tx-0' (00000000f7614753): kobject_uevent_env
kobject: 'tx-0' (00000000f7614753): fill_kobj_path: path  
= '/devices/virtual/net/syz_tun/queues/tx-0'
kobject: 'tx-0' (00000000f7614753): auto cleanup kobject_del
kobject: 'tx-0' (00000000f7614753): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (0000000095e05fe0): kobject_cleanup, parent            
(null)
kobject: 'queues' (0000000095e05fe0): calling ktype release
kobject: 'queues' (0000000095e05fe0): kset_release
kobject: 'queues': free name
kobject: 'syz_tun' (00000000eb4cc7f0): kobject_uevent_env
kobject: 'syz_tun' (00000000eb4cc7f0): fill_kobj_path: path  
= '/devices/virtual/net/syz_tun'
kobject: 'syz_tun' (000000007668427e): kobject_cleanup, parent            
(null)
kobject: 'syz_tun' (000000007668427e): calling ktype release
kobject: 'syz_tun': free name
kobject: 'rx-0' (0000000061d1b261): kobject_cleanup, parent 00000000f88fdb0a
kobject: 'rx-0' (0000000061d1b261): auto cleanup 'remove' event
kobject: 'rx-0' (0000000061d1b261): kobject_uevent_env
kobject: 'loop0' (000000001b064100): kobject_uevent_env
kobject: 'rx-0' (0000000061d1b261): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'loop0' (000000001b064100): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'rx-0' (0000000061d1b261): auto cleanup kobject_del
kobject: 'rx-0' (0000000061d1b261): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (00000000544c7408): kobject_cleanup, parent 00000000f88fdb0a
kobject: 'tx-0' (00000000544c7408): auto cleanup 'remove' event
kobject: 'tx-0' (00000000544c7408): kobject_uevent_env
kobject: 'tx-0' (00000000544c7408): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (00000000544c7408): auto cleanup kobject_del
kobject: 'tx-0' (00000000544c7408): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (00000000f88fdb0a): kobject_cleanup, parent            
(null)
kobject: 'queues' (00000000f88fdb0a): calling ktype release
kobject: 'queues' (00000000f88fdb0a): kset_release
kobject: 'queues': free name
kobject: 'ip6gre0' (00000000f6cb3a1b): kobject_uevent_env
kobject: 'ip6gre0' (00000000f6cb3a1b): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000c5992233): kobject_cleanup, parent 00000000a931fc66
kobject: 'rx-0' (00000000c5992233): auto cleanup 'remove' event
kobject: 'rx-0' (00000000c5992233): kobject_uevent_env
kobject: 'rx-0' (00000000c5992233): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000c5992233): auto cleanup kobject_del
kobject: 'rx-0' (00000000c5992233): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (000000001492ee3e): kobject_cleanup, parent 00000000a931fc66
kobject: 'tx-0' (000000001492ee3e): auto cleanup 'remove' event
kobject: 'tx-0' (000000001492ee3e): kobject_uevent_env
kobject: 'tx-0' (000000001492ee3e): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (000000001492ee3e): auto cleanup kobject_del
kobject: 'tx-0' (000000001492ee3e): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (00000000a931fc66): kobject_cleanup, parent            
(null)
kobject: 'queues' (00000000a931fc66): calling ktype release
kobject: 'queues' (00000000a931fc66): kset_release
kobject: 'queues': free name
kobject: 'ip6gretap0' (0000000072f65534): kobject_uevent_env
kobject: 'ip6gretap0' (0000000072f65534): kobject_uevent_env:  
uevent_suppress caused the event to drop!
kobject: 'rfkill96' (000000002d5dfeef): kobject_uevent_env
ieee80211 phy77: Selected rate control algorithm 'minstrel_ht'
kobject: 'rfkill96' (000000002d5dfeef): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim77/ieee80211/phy77/rfkill96'
kobject: 'net' (0000000039f969e1): kobject_add_internal: parent: 'hwsim77',  
set: '(null)'
kobject: 'wlan8' (0000000068e8141f): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'wlan8' (0000000068e8141f): kobject_uevent_env
kobject: 'wlan8' (0000000068e8141f): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim77/net/wlan8'
kobject: 'queues' (000000006901efd4): kobject_add_internal:  
parent: 'wlan8', set: '<NULL>'
kobject: 'queues' (000000006901efd4): kobject_uevent_env
kobject: 'queues' (000000006901efd4): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (000000009e31e178): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (000000009e31e178): kobject_uevent_env
kobject: 'rx-0' (000000009e31e178): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim77/net/wlan8/queues/rx-0'
kobject: 'tx-0' (0000000098527b68): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (0000000098527b68): kobject_uevent_env
kobject: 'tx-0' (0000000098527b68): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim77/net/wlan8/queues/tx-0'
kobject: 'tx-1' (00000000b5a91c3f): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-1' (00000000b5a91c3f): kobject_uevent_env
kobject: 'tx-1' (00000000b5a91c3f): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim77/net/wlan8/queues/tx-1'
kobject: 'tx-2' (00000000f19487ce): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-2' (00000000f19487ce): kobject_uevent_env
kobject: 'tx-2' (00000000f19487ce): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim77/net/wlan8/queues/tx-2'
kobject: 'tx-3' (0000000064ef4ef0): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-3' (0000000064ef4ef0): kobject_uevent_env
kobject: 'tx-3' (0000000064ef4ef0): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim77/net/wlan8/queues/tx-3'
kobject: 'syz_tun' (00000000eb4cc7f0): kobject_cleanup, parent            
(null)
kobject: 'syz_tun' (00000000eb4cc7f0): calling ktype release
kobject: 'syz_tun': free name
kobject: 'loop1' (00000000261da70b): kobject_uevent_env
kobject: 'loop1' (00000000261da70b): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'ip6gre0' (00000000f6cb3a1b): kobject_cleanup, parent            
(null)
kobject: 'loop4' (000000001e9bb253): kobject_uevent_env
kobject: 'ip6gre0' (00000000f6cb3a1b): auto cleanup 'remove' event
kobject: 'hwsim78' (00000000ed32663c): kobject_add_internal:  
parent: 'mac80211_hwsim', set: 'devices'
kobject: 'loop4' (000000001e9bb253): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'ip6gre0' (00000000f6cb3a1b): kobject_uevent_env
kobject: 'loop0' (000000001b064100): kobject_uevent_env
kobject: 'loop0' (000000001b064100): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'ip6gre0' (00000000f6cb3a1b): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'hwsim78' (00000000ed32663c): kobject_uevent_env
kobject: 'loop3' (0000000049972f9d): kobject_uevent_env
kobject: 'loop3' (0000000049972f9d): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'ip6gre0' (00000000f6cb3a1b): calling ktype release
kobject: 'hwsim78' (00000000ed32663c): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim78'
kobject: 'ip6gre0': free name
kobject: 'loop0' (000000001b064100): kobject_uevent_env
kobject: 'loop0' (000000001b064100): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
IPVS: ftp: loaded support on port[0] = 21
kobject: 'hwsim78' (00000000ed32663c): kobject_uevent_env
kobject: 'ip6gretap0' (0000000072f65534): kobject_cleanup, parent            
(null)
kobject: 'ip6gretap0' (0000000072f65534): auto cleanup 'remove' event
kobject: 'loop3' (0000000049972f9d): kobject_uevent_env
kobject: 'lo' (0000000026ed1e89): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'ip6gretap0' (0000000072f65534): kobject_uevent_env
kobject: 'hwsim78' (00000000ed32663c): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim78'
kobject: 'lo' (0000000026ed1e89): kobject_uevent_env
kobject: 'ip6gretap0' (0000000072f65534): kobject_uevent_env:  
uevent_suppress caused the event to drop!
kobject: 'loop3' (0000000049972f9d): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'lo' (0000000026ed1e89): fill_kobj_path: path  
= '/devices/virtual/net/lo'
kobject: 'ip6gretap0' (0000000072f65534): calling ktype release
kobject: 'loop0' (000000001b064100): kobject_uevent_env
kobject: 'ip6gretap0': free name
kobject: 'queues' (000000009fc73604): kobject_add_internal: parent: 'lo',  
set: '<NULL>'
kobject: 'loop0' (000000001b064100): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'queues' (000000009fc73604): kobject_uevent_env
IPVS: ftp: loaded support on port[0] = 21
kobject: 'queues' (000000009fc73604): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (00000000435d09f3): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (00000000435d09f3): kobject_uevent_env
kobject: 'rx-0' (00000000435d09f3): fill_kobj_path: path  
= '/devices/virtual/net/lo/queues/rx-0'
kobject: 'tx-0' (0000000098392069): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (0000000098392069): kobject_uevent_env
kobject: 'tx-0' (0000000098392069): fill_kobj_path: path  
= '/devices/virtual/net/lo/queues/tx-0'
kobject: 'tunl0' (000000001e342edc): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'tunl0' (000000001e342edc): kobject_uevent_env
kobject: 'tunl0' (000000001e342edc): fill_kobj_path: path  
= '/devices/virtual/net/tunl0'
kobject: 'queues' (000000005361d6aa): kobject_add_internal:  
parent: 'tunl0', set: '<NULL>'
kobject: 'queues' (000000005361d6aa): kobject_uevent_env
kobject: 'queues' (000000005361d6aa): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (00000000f46bc135): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (00000000f46bc135): kobject_uevent_env
kobject: 'rx-0' (00000000f46bc135): fill_kobj_path: path  
= '/devices/virtual/net/tunl0/queues/rx-0'
kobject: 'tx-0' (00000000f09f92cb): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (00000000f09f92cb): kobject_uevent_env
kobject: 'tx-0' (00000000f09f92cb): fill_kobj_path: path  
= '/devices/virtual/net/tunl0/queues/tx-0'
kobject: 'gre0' (00000000e089a5b3): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'gre0' (00000000e089a5b3): kobject_uevent_env
kobject: 'gre0' (00000000e089a5b3): fill_kobj_path: path  
= '/devices/virtual/net/gre0'
kobject: 'queues' (0000000090d6237c): kobject_add_internal: parent: 'gre0',  
set: '<NULL>'
kobject: 'queues' (0000000090d6237c): kobject_uevent_env
kobject: 'queues' (0000000090d6237c): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (000000008dc59821): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (000000008dc59821): kobject_uevent_env
kobject: 'rx-0' (000000008dc59821): fill_kobj_path: path  
= '/devices/virtual/net/gre0/queues/rx-0'
kobject: 'tx-0' (00000000b063970c): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (00000000b063970c): kobject_uevent_env
kobject: 'tx-0' (00000000b063970c): fill_kobj_path: path  
= '/devices/virtual/net/gre0/queues/tx-0'
kobject: 'gretap0' (00000000d45f51ef): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'gretap0' (00000000d45f51ef): kobject_uevent_env
kobject: 'gretap0' (00000000d45f51ef): fill_kobj_path: path  
= '/devices/virtual/net/gretap0'
kobject: 'queues' (000000004e0689ff): kobject_add_internal:  
parent: 'gretap0', set: '<NULL>'
kobject: 'queues' (000000004e0689ff): kobject_uevent_env
kobject: 'queues' (000000004e0689ff): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (0000000057f00024): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (0000000057f00024): kobject_uevent_env
kobject: 'rx-0' (0000000057f00024): fill_kobj_path: path  
= '/devices/virtual/net/gretap0/queues/rx-0'
kobject: 'tx-0' (0000000084733bae): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (0000000084733bae): kobject_uevent_env
kobject: 'tx-0' (0000000084733bae): fill_kobj_path: path  
= '/devices/virtual/net/gretap0/queues/tx-0'
kobject: 'erspan0' (00000000629238cb): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'erspan0' (00000000629238cb): kobject_uevent_env
kobject: 'erspan0' (00000000629238cb): fill_kobj_path: path  
= '/devices/virtual/net/erspan0'
kobject: 'queues' (00000000a7870bef): kobject_add_internal:  
parent: 'erspan0', set: '<NULL>'
kobject: 'queues' (00000000a7870bef): kobject_uevent_env
kobject: 'queues' (00000000a7870bef): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (000000008ccdd182): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (000000008ccdd182): kobject_uevent_env
kobject: 'rx-0' (000000008ccdd182): fill_kobj_path: path  
= '/devices/virtual/net/erspan0/queues/rx-0'
kobject: 'tx-0' (00000000ca475f8c): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (00000000ca475f8c): kobject_uevent_env
kobject: 'tx-0' (00000000ca475f8c): fill_kobj_path: path  
= '/devices/virtual/net/erspan0/queues/tx-0'
kobject: 'ieee80211' (0000000034003b2d): kobject_add_internal:  
parent: 'hwsim78', set: '(null)'
kobject: 'phy78' (00000000b6656112): kobject_add_internal:  
parent: 'ieee80211', set: 'devices'
kobject: 'phy78' (00000000b6656112): kobject_uevent_env
kobject: 'phy78' (00000000b6656112): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim78/ieee80211/phy78'
kobject: 'rfkill97' (00000000f97c6bd6): kobject_add_internal:  
parent: 'phy78', set: 'devices'
kobject: 'rfkill97' (00000000f97c6bd6): kobject_uevent_env
kobject: 'rfkill97' (00000000f97c6bd6): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim78/ieee80211/phy78/rfkill97'
kobject: 'rx-0' (000000007daa8947): kobject_cleanup, parent 0000000091940c5f
kobject: 'rx-0' (000000007daa8947): auto cleanup 'remove' event
kobject: 'rx-0' (000000007daa8947): kobject_uevent_env
kobject: 'rx-0' (000000007daa8947): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (000000007daa8947): auto cleanup kobject_del
kobject: 'rx-0' (000000007daa8947): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (00000000861a74db): kobject_cleanup, parent 0000000091940c5f
kobject: 'tx-0' (00000000861a74db): auto cleanup 'remove' event
kobject: 'tx-0' (00000000861a74db): kobject_uevent_env
kobject: 'tx-0' (00000000861a74db): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (00000000861a74db): auto cleanup kobject_del
kobject: 'tx-0' (00000000861a74db): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (0000000091940c5f): kobject_cleanup, parent            
(null)
kobject: 'queues' (0000000091940c5f): calling ktype release
kobject: 'queues' (0000000091940c5f): kset_release
kobject: 'queues': free name
kobject: 'ip6tnl0' (000000005239a013): kobject_uevent_env
kobject: 'ip6tnl0' (000000005239a013): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'lo' (0000000011a2116b): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'lo' (0000000011a2116b): kobject_uevent_env
kobject: 'lo' (0000000011a2116b): fill_kobj_path: path  
= '/devices/virtual/net/lo'
kobject: 'queues' (00000000fdf6ce56): kobject_add_internal: parent: 'lo',  
set: '<NULL>'
kobject: 'queues' (00000000fdf6ce56): kobject_uevent_env
kobject: 'queues' (00000000fdf6ce56): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (00000000f8b6c016): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (00000000f8b6c016): kobject_uevent_env
kobject: 'rx-0' (00000000f8b6c016): fill_kobj_path: path  
= '/devices/virtual/net/lo/queues/rx-0'
kobject: 'tx-0' (000000007324da58): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (000000007324da58): kobject_uevent_env
kobject: 'tx-0' (000000007324da58): fill_kobj_path: path  
= '/devices/virtual/net/lo/queues/tx-0'
kobject: 'ip_vti0' (0000000044d40d2e): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'ip_vti0' (0000000044d40d2e): kobject_uevent_env
kobject: 'ip_vti0' (0000000044d40d2e): fill_kobj_path: path  
= '/devices/virtual/net/ip_vti0'
kobject: 'queues' (00000000d3e39d5a): kobject_add_internal:  
parent: 'ip_vti0', set: '<NULL>'
kobject: 'queues' (00000000d3e39d5a): kobject_uevent_env
kobject: 'queues' (00000000d3e39d5a): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (0000000023c378b6): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (0000000023c378b6): kobject_uevent_env
kobject: 'rx-0' (0000000023c378b6): fill_kobj_path: path  
= '/devices/virtual/net/ip_vti0/queues/rx-0'
kobject: 'tx-0' (00000000f4b30b04): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (00000000f4b30b04): kobject_uevent_env
kobject: 'tx-0' (00000000f4b30b04): fill_kobj_path: path  
= '/devices/virtual/net/ip_vti0/queues/tx-0'
kobject: 'rfkill97' (00000000f97c6bd6): kobject_uevent_env
ieee80211 phy78: Selected rate control algorithm 'minstrel_ht'
kobject: 'rfkill97' (00000000f97c6bd6): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim78/ieee80211/phy78/rfkill97'
kobject: 'net' (00000000fd3fcd8d): kobject_add_internal: parent: 'hwsim78',  
set: '(null)'
kobject: 'wlan9' (00000000929337df): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'wlan9' (00000000929337df): kobject_uevent_env
kobject: 'wlan9' (00000000929337df): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim78/net/wlan9'
kobject: 'queues' (0000000063cd3400): kobject_add_internal:  
parent: 'wlan9', set: '<NULL>'
kobject: 'queues' (0000000063cd3400): kobject_uevent_env
kobject: 'queues' (0000000063cd3400): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (00000000ef1fcb8f): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (00000000ef1fcb8f): kobject_uevent_env
kobject: 'rx-0' (00000000ef1fcb8f): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim78/net/wlan9/queues/rx-0'
kobject: 'tx-0' (000000007abf9854): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (000000007abf9854): kobject_uevent_env
kobject: 'tx-0' (000000007abf9854): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim78/net/wlan9/queues/tx-0'
kobject: 'tx-1' (000000006726ac4e): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-1' (000000006726ac4e): kobject_uevent_env
kobject: 'tx-1' (000000006726ac4e): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim78/net/wlan9/queues/tx-1'
kobject: 'tx-2' (000000002b70d9f7): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-2' (000000002b70d9f7): kobject_uevent_env
kobject: 'tx-2' (000000002b70d9f7): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim78/net/wlan9/queues/tx-2'
kobject: 'tx-3' (000000005fa9262f): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-3' (000000005fa9262f): kobject_uevent_env
kobject: 'tx-3' (000000005fa9262f): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim78/net/wlan9/queues/tx-3'
kobject: 'ip6tnl0' (000000005239a013): kobject_cleanup, parent            
(null)
kobject: 'tunl0' (00000000008014d3): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'ip6tnl0' (000000005239a013): auto cleanup 'remove' event
kobject: 'ip6tnl0' (000000005239a013): kobject_uevent_env
kobject: 'ip6tnl0' (000000005239a013): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'ip6tnl0' (000000005239a013): calling ktype release
kobject: 'ip6tnl0': free name
kobject: 'loop1' (00000000261da70b): kobject_uevent_env
kobject: 'loop1' (00000000261da70b): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop0' (000000001b064100): kobject_uevent_env
kobject: 'tunl0' (00000000008014d3): kobject_uevent_env
kobject: 'loop4' (000000001e9bb253): kobject_uevent_env
kobject: 'loop0' (000000001b064100): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'tunl0' (00000000008014d3): fill_kobj_path: path  
= '/devices/virtual/net/tunl0'
kobject: 'loop4' (000000001e9bb253): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
f2fs_msg: 6 callbacks suppressed
F2FS-fs (loop0): Magic Mismatch, valid(0xf2f52010) - read(0x0)
kobject: 'queues' (0000000085ad9b5f): kobject_add_internal:  
parent: 'tunl0', set: '<NULL>'
F2FS-fs (loop0): Can't find valid F2FS filesystem in 1th superblock
kobject: 'loop3' (0000000049972f9d): kobject_uevent_env
attempt to access beyond end of device
loop0: rw=12288, want=8200, limit=20
attempt to access beyond end of device
loop0: rw=12288, want=12296, limit=20
kobject: 'loop3' (0000000049972f9d): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
F2FS-fs (loop0): Failed to get valid F2FS checkpoint
F2FS-fs (loop0): Magic Mismatch, valid(0xf2f52010) - read(0x0)
F2FS-fs (loop0): Can't find valid F2FS filesystem in 1th superblock
kobject: 'queues' (0000000085ad9b5f): kobject_uevent_env
attempt to access beyond end of device
loop0: rw=12288, want=8200, limit=20
attempt to access beyond end of device
loop0: rw=12288, want=12296, limit=20
kobject: 'queues' (0000000085ad9b5f): kobject_uevent_env: filter function  
caused the event to drop!
F2FS-fs (loop0): Failed to get valid F2FS checkpoint
kobject: 'rx-0' (000000001fb7db9b): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (000000001fb7db9b): kobject_uevent_env
kobject: 'rx-0' (000000001fb7db9b): fill_kobj_path: path  
= '/devices/virtual/net/tunl0/queues/rx-0'
kobject: 'tx-0' (000000004dbf1fa8): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (000000004dbf1fa8): kobject_uevent_env
kobject: 'tx-0' (000000004dbf1fa8): fill_kobj_path: path  
= '/devices/virtual/net/tunl0/queues/tx-0'
kobject: 'gre0' (000000001ff413c5): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'gre0' (000000001ff413c5): kobject_uevent_env
kobject: 'gre0' (000000001ff413c5): fill_kobj_path: path  
= '/devices/virtual/net/gre0'
kobject: 'queues' (000000008553a1e7): kobject_add_internal: parent: 'gre0',  
set: '<NULL>'
kobject: 'loop0' (000000001b064100): kobject_uevent_env
kobject: 'queues' (000000008553a1e7): kobject_uevent_env
kobject: 'queues' (000000008553a1e7): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (000000002ec2b04e): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (000000002ec2b04e): kobject_uevent_env
kobject: 'loop0' (000000001b064100): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'rx-0' (000000002ec2b04e): fill_kobj_path: path  
= '/devices/virtual/net/gre0/queues/rx-0'
kobject: 'tx-0' (0000000078e14477): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (0000000078e14477): kobject_uevent_env
kobject: 'tx-0' (0000000078e14477): fill_kobj_path: path  
= '/devices/virtual/net/gre0/queues/tx-0'
kobject: 'loop0' (000000001b064100): kobject_uevent_env
kobject: 'ip6_vti0' (000000008e2c8c23): kobject_add_internal:  
parent: 'net', set: 'devices'
kobject: 'loop0' (000000001b064100): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
F2FS-fs (loop0): Magic Mismatch, valid(0xf2f52010) - read(0x0)
kobject: 'ip6_vti0' (000000008e2c8c23): kobject_uevent_env
F2FS-fs (loop0): Can't find valid F2FS filesystem in 1th superblock
kobject: 'ip6_vti0' (000000008e2c8c23): fill_kobj_path: path  
= '/devices/virtual/net/ip6_vti0'
attempt to access beyond end of device
kobject: 'queues' (00000000eaea788f): kobject_add_internal:  
parent: 'ip6_vti0', set: '<NULL>'
loop0: rw=12288, want=8200, limit=20
attempt to access beyond end of device
kobject: 'queues' (00000000eaea788f): kobject_uevent_env
loop0: rw=12288, want=12296, limit=20
kobject: 'queues' (00000000eaea788f): kobject_uevent_env: filter function  
caused the event to drop!
F2FS-fs (loop0): Failed to get valid F2FS checkpoint
F2FS-fs (loop0): Magic Mismatch, valid(0xf2f52010) - read(0x0)
kobject: 'rx-0' (0000000041c09ad6): kobject_add_internal: parent: 'queues',  
set: 'queues'
attempt to access beyond end of device
kobject: 'rx-0' (0000000041c09ad6): kobject_uevent_env
loop0: rw=12288, want=8200, limit=20
kobject: 'rx-0' (0000000041c09ad6): fill_kobj_path: path  
= '/devices/virtual/net/ip6_vti0/queues/rx-0'
attempt to access beyond end of device
loop0: rw=12288, want=12296, limit=20
kobject: 'tx-0' (00000000188d926f): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (00000000188d926f): kobject_uevent_env
kobject: 'tx-0' (00000000188d926f): fill_kobj_path: path  
= '/devices/virtual/net/ip6_vti0/queues/tx-0'
kobject: 'rx-0' (00000000198dbba6): kobject_cleanup, parent 00000000f5491f13
kobject: 'rx-0' (00000000198dbba6): auto cleanup 'remove' event
kobject: 'rx-0' (00000000198dbba6): kobject_uevent_env
kobject: 'rx-0' (00000000198dbba6): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000198dbba6): auto cleanup kobject_del
kobject: 'loop0' (000000001b064100): kobject_uevent_env
kobject: 'rx-0' (00000000198dbba6): calling ktype release
kobject: 'loop0' (000000001b064100): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'rx-0': free name
kobject: 'tx-0' (00000000b008619e): kobject_cleanup, parent 00000000f5491f13
kobject: 'tx-0' (00000000b008619e): auto cleanup 'remove' event
kobject: 'tx-0' (00000000b008619e): kobject_uevent_env
kobject: 'tx-0' (00000000b008619e): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (00000000b008619e): auto cleanup kobject_del
kobject: 'tx-0' (00000000b008619e): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (00000000f5491f13): kobject_cleanup, parent            
(null)
kobject: 'queues' (00000000f5491f13): calling ktype release
kobject: 'queues' (00000000f5491f13): kset_release
kobject: 'queues': free name
kobject: 'sit0' (00000000c7a47a9c): kobject_uevent_env
kobject: 'sit0' (00000000c7a47a9c): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'gretap0' (00000000e84b27d6): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'loop3' (0000000049972f9d): kobject_uevent_env
kobject: 'loop3' (0000000049972f9d): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'gretap0' (00000000e84b27d6): kobject_uevent_env
kobject: 'gretap0' (00000000e84b27d6): fill_kobj_path: path  
= '/devices/virtual/net/gretap0'
kobject: 'queues' (0000000044843888): kobject_add_internal:  
parent: 'gretap0', set: '<NULL>'
kobject: 'loop1' (00000000261da70b): kobject_uevent_env
kobject: 'queues' (0000000044843888): kobject_uevent_env
kobject: 'loop1' (00000000261da70b): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'queues' (0000000044843888): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (00000000a6a8e870): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (00000000a6a8e870): kobject_uevent_env
kobject: 'rx-0' (00000000a6a8e870): fill_kobj_path: path  
= '/devices/virtual/net/gretap0/queues/rx-0'
kobject: 'tx-0' (000000000f82eab0): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (000000000f82eab0): kobject_uevent_env
kobject: 'tx-0' (000000000f82eab0): fill_kobj_path: path  
= '/devices/virtual/net/gretap0/queues/tx-0'
kobject: 'erspan0' (0000000090b660a5): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'erspan0' (0000000090b660a5): kobject_uevent_env
kobject: 'erspan0' (0000000090b660a5): fill_kobj_path: path  
= '/devices/virtual/net/erspan0'
kobject: 'queues' (0000000020ef6b7a): kobject_add_internal:  
parent: 'erspan0', set: '<NULL>'
kobject: 'queues' (0000000020ef6b7a): kobject_uevent_env
kobject: 'queues' (0000000020ef6b7a): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (0000000076034137): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (0000000076034137): kobject_uevent_env
kobject: 'rx-0' (0000000076034137): fill_kobj_path: path  
= '/devices/virtual/net/erspan0/queues/rx-0'
kobject: 'tx-0' (00000000a2877c40): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (00000000a2877c40): kobject_uevent_env
kobject: 'tx-0' (00000000a2877c40): fill_kobj_path: path  
= '/devices/virtual/net/erspan0/queues/tx-0'
kobject: 'sit0' (00000000e3e2a16f): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'sit0' (00000000e3e2a16f): kobject_uevent_env
kobject: 'sit0' (00000000e3e2a16f): fill_kobj_path: path  
= '/devices/virtual/net/sit0'
kobject: 'queues' (00000000c87a748d): kobject_add_internal: parent: 'sit0',  
set: '<NULL>'
kobject: 'queues' (00000000c87a748d): kobject_uevent_env
kobject: 'queues' (00000000c87a748d): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (0000000013220ea2): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (0000000013220ea2): kobject_uevent_env
kobject: 'rx-0' (0000000013220ea2): fill_kobj_path: path  
= '/devices/virtual/net/sit0/queues/rx-0'
kobject: 'tx-0' (000000000f597677): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (000000000f597677): kobject_uevent_env
kobject: 'tx-0' (000000000f597677): fill_kobj_path: path  
= '/devices/virtual/net/sit0/queues/tx-0'
kobject: 'sit0' (00000000c7a47a9c): kobject_cleanup, parent           (null)
kobject: 'ip6tnl0' (00000000ef426155): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'ip6tnl0' (00000000ef426155): kobject_uevent_env
kobject: 'sit0' (00000000c7a47a9c): auto cleanup 'remove' event
kobject: 'ip6tnl0' (00000000ef426155): fill_kobj_path: path  
= '/devices/virtual/net/ip6tnl0'
kobject: 'sit0' (00000000c7a47a9c): kobject_uevent_env
kobject: 'queues' (0000000014824614): kobject_add_internal:  
parent: 'ip6tnl0', set: '<NULL>'
kobject: 'queues' (0000000014824614): kobject_uevent_env
kobject: 'sit0' (00000000c7a47a9c): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'queues' (0000000014824614): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'sit0' (00000000c7a47a9c): calling ktype release
kobject: 'rx-0' (0000000087b89223): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'sit0': free name
kobject: 'rx-0' (0000000087b89223): kobject_uevent_env
kobject: 'rx-0' (0000000087b89223): fill_kobj_path: path  
= '/devices/virtual/net/ip6tnl0/queues/rx-0'
kobject: 'tx-0' (000000000bb0a388): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (000000000bb0a388): kobject_uevent_env
kobject: 'tx-0' (000000000bb0a388): fill_kobj_path: path  
= '/devices/virtual/net/ip6tnl0/queues/tx-0'
kobject: 'ip6gre0' (000000006fc72841): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'ip6gre0' (000000006fc72841): kobject_uevent_env
kobject: 'ip6gre0' (000000006fc72841): fill_kobj_path: path  
= '/devices/virtual/net/ip6gre0'
kobject: 'queues' (0000000019e0690c): kobject_add_internal:  
parent: 'ip6gre0', set: '<NULL>'
kobject: 'loop4' (000000001e9bb253): kobject_uevent_env
kobject: 'loop4' (000000001e9bb253): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'queues' (0000000019e0690c): kobject_uevent_env
kobject: 'queues' (0000000019e0690c): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (00000000afeda5c2): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (00000000afeda5c2): kobject_uevent_env
kobject: 'rx-0' (00000000afeda5c2): fill_kobj_path: path  
= '/devices/virtual/net/ip6gre0/queues/rx-0'
kobject: 'tx-0' (000000004ea2b5e7): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (000000004ea2b5e7): kobject_uevent_env
kobject: 'tx-0' (000000004ea2b5e7): fill_kobj_path: path  
= '/devices/virtual/net/ip6gre0/queues/tx-0'
kobject: 'ip_vti0' (000000005bc278ba): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'ip_vti0' (000000005bc278ba): kobject_uevent_env
kobject: 'ip_vti0' (000000005bc278ba): fill_kobj_path: path  
= '/devices/virtual/net/ip_vti0'
kobject: 'queues' (000000002e225b4e): kobject_add_internal:  
parent: 'ip_vti0', set: '<NULL>'
kobject: 'queues' (000000002e225b4e): kobject_uevent_env
kobject: 'queues' (000000002e225b4e): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (000000006e75f4ca): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (000000006e75f4ca): kobject_uevent_env
kobject: 'rx-0' (000000006e75f4ca): fill_kobj_path: path  
= '/devices/virtual/net/ip_vti0/queues/rx-0'
kobject: 'tx-0' (0000000039077593): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (0000000039077593): kobject_uevent_env
kobject: 'tx-0' (0000000039077593): fill_kobj_path: path  
= '/devices/virtual/net/ip_vti0/queues/tx-0'
kobject: 'rx-0' (000000001a24142c): kobject_cleanup, parent 0000000028636b03
kobject: 'rx-0' (000000001a24142c): auto cleanup 'remove' event
kobject: 'rx-0' (000000001a24142c): kobject_uevent_env
kobject: 'rx-0' (000000001a24142c): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (000000001a24142c): auto cleanup kobject_del
kobject: 'rx-0' (000000001a24142c): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (0000000092b23e36): kobject_cleanup, parent 0000000028636b03
kobject: 'tx-0' (0000000092b23e36): auto cleanup 'remove' event
kobject: 'tx-0' (0000000092b23e36): kobject_uevent_env
kobject: 'tx-0' (0000000092b23e36): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (0000000092b23e36): auto cleanup kobject_del
kobject: 'tx-0' (0000000092b23e36): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (0000000028636b03): kobject_cleanup, parent            
(null)
kobject: 'queues' (0000000028636b03): calling ktype release
kobject: 'queues' (0000000028636b03): kset_release
kobject: 'queues': free name
kobject: 'ip6_vti0' (0000000020ef4527): kobject_uevent_env
kobject: 'ip6_vti0' (0000000020ef4527): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'syz_tun' (00000000f9c30323): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'syz_tun' (00000000f9c30323): kobject_uevent_env
kobject: 'syz_tun' (00000000f9c30323): fill_kobj_path: path  
= '/devices/virtual/net/syz_tun'
kobject: 'queues' (0000000041c26192): kobject_add_internal:  
parent: 'syz_tun', set: '<NULL>'
kobject: 'queues' (0000000041c26192): kobject_uevent_env
kobject: 'queues' (0000000041c26192): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (00000000954dd602): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (00000000954dd602): kobject_uevent_env
kobject: 'rx-0' (00000000954dd602): fill_kobj_path: path  
= '/devices/virtual/net/syz_tun/queues/rx-0'
kobject: 'tx-0' (000000005f836e67): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (000000005f836e67): kobject_uevent_env
kobject: 'tx-0' (000000005f836e67): fill_kobj_path: path  
= '/devices/virtual/net/syz_tun/queues/tx-0'
kobject: 'ip6_vti0' (0000000087375d88): kobject_add_internal:  
parent: 'net', set: 'devices'
kobject: 'ip6_vti0' (0000000087375d88): kobject_uevent_env
kobject: 'ip6_vti0' (0000000087375d88): fill_kobj_path: path  
= '/devices/virtual/net/ip6_vti0'
kobject: 'queues' (000000009eac168b): kobject_add_internal:  
parent: 'ip6_vti0', set: '<NULL>'
kobject: 'queues' (000000009eac168b): kobject_uevent_env
kobject: 'queues' (000000009eac168b): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (0000000028433a9e): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (0000000028433a9e): kobject_uevent_env
kobject: 'rx-0' (0000000028433a9e): fill_kobj_path: path  
= '/devices/virtual/net/ip6_vti0/queues/rx-0'
kobject: 'tx-0' (00000000098cde74): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (00000000098cde74): kobject_uevent_env
kobject: 'tx-0' (00000000098cde74): fill_kobj_path: path  
= '/devices/virtual/net/ip6_vti0/queues/tx-0'
kobject: 'ip6_vti0' (0000000020ef4527): kobject_cleanup, parent            
(null)
kobject: 'sit0' (0000000039b70061): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'sit0' (0000000039b70061): kobject_uevent_env
kobject: 'ip6_vti0' (0000000020ef4527): auto cleanup 'remove' event
kobject: 'sit0' (0000000039b70061): fill_kobj_path: path  
= '/devices/virtual/net/sit0'
kobject: 'ip6_vti0' (0000000020ef4527): kobject_uevent_env
kobject: 'queues' (00000000018e5271): kobject_add_internal: parent: 'sit0',  
set: '<NULL>'
kobject: 'queues' (00000000018e5271): kobject_uevent_env
kobject: 'ip6_vti0' (0000000020ef4527): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'queues' (00000000018e5271): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'ip6_vti0' (0000000020ef4527): calling ktype release
kobject: 'rx-0' (0000000021412345): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'ip6_vti0': free name
kobject: 'rx-0' (0000000021412345): kobject_uevent_env
kobject: 'rx-0' (0000000021412345): fill_kobj_path: path  
= '/devices/virtual/net/sit0/queues/rx-0'
kobject: 'tx-0' (00000000e9b27282): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (00000000e9b27282): kobject_uevent_env
kobject: 'tx-0' (00000000e9b27282): fill_kobj_path: path  
= '/devices/virtual/net/sit0/queues/tx-0'
kobject: 'rx-0' (000000005aa24b22): kobject_cleanup, parent 000000004cd2ac60
kobject: 'rx-0' (000000005aa24b22): auto cleanup 'remove' event
kobject: 'rx-0' (000000005aa24b22): kobject_uevent_env
kobject: 'rx-0' (000000005aa24b22): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (000000005aa24b22): auto cleanup kobject_del
kobject: 'rx-0' (000000005aa24b22): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (00000000fc29b4de): kobject_cleanup, parent 000000004cd2ac60
kobject: 'tx-0' (00000000fc29b4de): auto cleanup 'remove' event
kobject: 'tx-0' (00000000fc29b4de): kobject_uevent_env
kobject: 'tx-0' (00000000fc29b4de): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (00000000fc29b4de): auto cleanup kobject_del
kobject: 'tx-0' (00000000fc29b4de): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (000000004cd2ac60): kobject_cleanup, parent            
(null)
kobject: 'queues' (000000004cd2ac60): calling ktype release
kobject: 'queues' (000000004cd2ac60): kset_release
kobject: 'queues': free name
kobject: 'ip_vti0' (00000000617c37c5): kobject_uevent_env
kobject: 'ip_vti0' (00000000617c37c5): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'ip6tnl0' (00000000b70e37b0): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'ip6tnl0' (00000000b70e37b0): kobject_uevent_env
kobject: 'ip6tnl0' (00000000b70e37b0): fill_kobj_path: path  
= '/devices/virtual/net/ip6tnl0'
kobject: 'queues' (0000000006a6c48d): kobject_add_internal:  
parent: 'ip6tnl0', set: '<NULL>'
kobject: 'queues' (0000000006a6c48d): kobject_uevent_env
kobject: 'queues' (0000000006a6c48d): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (000000000af89fbd): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (000000000af89fbd): kobject_uevent_env
kobject: 'rx-0' (000000000af89fbd): fill_kobj_path: path  
= '/devices/virtual/net/ip6tnl0/queues/rx-0'
kobject: 'tx-0' (000000001030a511): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (000000001030a511): kobject_uevent_env
kobject: 'tx-0' (000000001030a511): fill_kobj_path: path  
= '/devices/virtual/net/ip6tnl0/queues/tx-0'
kobject: 'ip6gre0' (00000000279f7ced): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'ip6gre0' (00000000279f7ced): kobject_uevent_env
kobject: 'ip6gre0' (00000000279f7ced): fill_kobj_path: path  
= '/devices/virtual/net/ip6gre0'
kobject: 'queues' (00000000445fd090): kobject_add_internal:  
parent: 'ip6gre0', set: '<NULL>'
kobject: 'queues' (00000000445fd090): kobject_uevent_env
kobject: 'queues' (00000000445fd090): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (000000001846accf): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (000000001846accf): kobject_uevent_env
kobject: 'rx-0' (000000001846accf): fill_kobj_path: path  
= '/devices/virtual/net/ip6gre0/queues/rx-0'
kobject: 'tx-0' (0000000089bc5a27): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (0000000089bc5a27): kobject_uevent_env
kobject: 'tx-0' (0000000089bc5a27): fill_kobj_path: path  
= '/devices/virtual/net/ip6gre0/queues/tx-0'
kobject: 'syz_tun' (00000000e07d3df0): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'ip_vti0' (00000000617c37c5): kobject_cleanup, parent            
(null)
kobject: 'syz_tun' (00000000e07d3df0): kobject_uevent_env
kobject: 'ip_vti0' (00000000617c37c5): auto cleanup 'remove' event
kobject: 'syz_tun' (00000000e07d3df0): fill_kobj_path: path  
= '/devices/virtual/net/syz_tun'
kobject: 'ip_vti0' (00000000617c37c5): kobject_uevent_env
kobject: 'ip_vti0' (00000000617c37c5): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'queues' (00000000e8902e54): kobject_add_internal:  
parent: 'syz_tun', set: '<NULL>'
kobject: 'ip_vti0' (00000000617c37c5): calling ktype release
kobject: 'queues' (00000000e8902e54): kobject_uevent_env
kobject: 'queues' (00000000e8902e54): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'ip_vti0': free name
kobject: 'rx-0' (00000000af14a71a): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (00000000af14a71a): kobject_uevent_env
kobject: 'rx-0' (00000000af14a71a): fill_kobj_path: path  
= '/devices/virtual/net/syz_tun/queues/rx-0'
kobject: 'tx-0' (000000006a8e698e): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (000000006a8e698e): kobject_uevent_env
kobject: 'tx-0' (000000006a8e698e): fill_kobj_path: path  
= '/devices/virtual/net/syz_tun/queues/tx-0'
kobject: 'rx-0' (000000005f5c75e6): kobject_cleanup, parent 000000004e456e48
kobject: 'rx-0' (000000005f5c75e6): auto cleanup 'remove' event
kobject: 'rx-0' (000000005f5c75e6): kobject_uevent_env
kobject: 'rx-0' (000000005f5c75e6): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (000000005f5c75e6): auto cleanup kobject_del
kobject: 'rx-0' (000000005f5c75e6): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (00000000a98a4e66): kobject_cleanup, parent 000000004e456e48
kobject: 'tx-0' (00000000a98a4e66): auto cleanup 'remove' event
kobject: 'tx-0' (00000000a98a4e66): kobject_uevent_env
kobject: 'tx-0' (00000000a98a4e66): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (00000000a98a4e66): auto cleanup kobject_del
kobject: 'tx-0' (00000000a98a4e66): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (000000004e456e48): kobject_cleanup, parent            
(null)
kobject: 'queues' (000000004e456e48): calling ktype release
kobject: 'queues' (000000004e456e48): kset_release
kobject: 'queues': free name
kobject: 'erspan0' (00000000cf5ce776): kobject_uevent_env
kobject: 'erspan0' (00000000cf5ce776): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'erspan0' (00000000cf5ce776): kobject_cleanup, parent            
(null)
kobject: 'erspan0' (00000000cf5ce776): auto cleanup 'remove' event
kobject: 'erspan0' (00000000cf5ce776): kobject_uevent_env
kobject: 'erspan0' (00000000cf5ce776): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'erspan0' (00000000cf5ce776): calling ktype release
kobject: 'erspan0': free name
kobject: 'rx-0' (000000000ad8ad2c): kobject_cleanup, parent 000000005cdf48e5
kobject: 'rx-0' (000000000ad8ad2c): auto cleanup 'remove' event
kobject: 'rx-0' (000000000ad8ad2c): kobject_uevent_env
kobject: 'rx-0' (000000000ad8ad2c): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (000000000ad8ad2c): auto cleanup kobject_del
kobject: 'rx-0' (000000000ad8ad2c): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (00000000c903a801): kobject_cleanup, parent 000000005cdf48e5
kobject: 'tx-0' (00000000c903a801): auto cleanup 'remove' event
kobject: 'tx-0' (00000000c903a801): kobject_uevent_env
kobject: 'tx-0' (00000000c903a801): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (00000000c903a801): auto cleanup kobject_del
kobject: 'tx-0' (00000000c903a801): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (000000005cdf48e5): kobject_cleanup, parent            
(null)
kobject: 'queues' (000000005cdf48e5): calling ktype release
kobject: 'queues' (000000005cdf48e5): kset_release
kobject: 'queues': free name
kobject: 'gretap0' (000000004d423aac): kobject_uevent_env
kobject: 'gretap0' (000000004d423aac): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'gretap0' (000000004d423aac): kobject_cleanup, parent            
(null)
kobject: 'gretap0' (000000004d423aac): auto cleanup 'remove' event
kobject: 'gretap0' (000000004d423aac): kobject_uevent_env
kobject: 'gretap0' (000000004d423aac): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'gretap0' (000000004d423aac): calling ktype release
kobject: 'gretap0': free name
kobject: 'rx-0' (00000000a4b747d7): kobject_cleanup, parent 000000003ccae0b4
kobject: 'rx-0' (00000000a4b747d7): auto cleanup 'remove' event
kobject: 'rx-0' (00000000a4b747d7): kobject_uevent_env
kobject: 'rx-0' (00000000a4b747d7): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000a4b747d7): auto cleanup kobject_del
kobject: 'rx-0' (00000000a4b747d7): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (00000000e6a79f88): kobject_cleanup, parent 000000003ccae0b4
kobject: 'tx-0' (00000000e6a79f88): auto cleanup 'remove' event
kobject: 'tx-0' (00000000e6a79f88): kobject_uevent_env
kobject: 'tx-0' (00000000e6a79f88): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (00000000e6a79f88): auto cleanup kobject_del
kobject: 'tx-0' (00000000e6a79f88): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (000000003ccae0b4): kobject_cleanup, parent            
(null)
kobject: 'queues' (000000003ccae0b4): calling ktype release
kobject: 'queues' (000000003ccae0b4): kset_release
kobject: 'queues': free name
kobject: 'gre0' (0000000077fb13a5): kobject_uevent_env
kobject: 'gre0' (0000000077fb13a5): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'ip6gretap0' (000000007281cf91): kobject_add_internal:  
parent: 'net', set: 'devices'
kobject: 'ip6gretap0' (000000007281cf91): kobject_uevent_env
kobject: 'ip6gretap0' (000000007281cf91): fill_kobj_path: path  
= '/devices/virtual/net/ip6gretap0'
kobject: 'queues' (00000000c5800ac6): kobject_add_internal:  
parent: 'ip6gretap0', set: '<NULL>'
kobject: 'queues' (00000000c5800ac6): kobject_uevent_env
kobject: 'queues' (00000000c5800ac6): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (000000002b4502a3): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (000000002b4502a3): kobject_uevent_env
kobject: 'rx-0' (000000002b4502a3): fill_kobj_path: path  
= '/devices/virtual/net/ip6gretap0/queues/rx-0'
kobject: 'tx-0' (000000007dec8283): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (000000007dec8283): kobject_uevent_env
kobject: 'tx-0' (000000007dec8283): fill_kobj_path: path  
= '/devices/virtual/net/ip6gretap0/queues/tx-0'
kobject: 'gre0' (0000000077fb13a5): kobject_cleanup, parent           (null)
kobject: 'gre0' (0000000077fb13a5): auto cleanup 'remove' event
kobject: 'gre0' (0000000077fb13a5): kobject_uevent_env
kobject: 'gre0' (0000000077fb13a5): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'gre0' (0000000077fb13a5): calling ktype release
kobject: 'gre0': free name
kobject: 'rx-0' (00000000c13182aa): kobject_cleanup, parent 000000000b2c1ed3
kobject: 'rx-0' (00000000c13182aa): auto cleanup 'remove' event
kobject: 'rx-0' (00000000c13182aa): kobject_uevent_env
kobject: 'rx-0' (00000000c13182aa): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000c13182aa): auto cleanup kobject_del
kobject: 'rx-0' (00000000c13182aa): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (00000000c70edf3f): kobject_cleanup, parent 000000000b2c1ed3
kobject: 'tx-0' (00000000c70edf3f): auto cleanup 'remove' event
kobject: 'tx-0' (00000000c70edf3f): kobject_uevent_env
kobject: 'tx-0' (00000000c70edf3f): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (00000000c70edf3f): auto cleanup kobject_del
kobject: 'tx-0' (00000000c70edf3f): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (000000000b2c1ed3): kobject_cleanup, parent            
(null)
kobject: 'queues' (000000000b2c1ed3): calling ktype release
kobject: 'queues' (000000000b2c1ed3): kset_release
kobject: 'queues': free name
kobject: 'tunl0' (00000000a752cb36): kobject_uevent_env
kobject: 'tunl0' (00000000a752cb36): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'bridge0' (00000000ec037900): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'bridge0' (00000000ec037900): kobject_uevent_env
kobject: 'bridge0' (00000000ec037900): fill_kobj_path: path  
= '/devices/virtual/net/bridge0'
kobject: 'queues' (00000000552da2fa): kobject_add_internal:  
parent: 'bridge0', set: '<NULL>'
kobject: 'queues' (00000000552da2fa): kobject_uevent_env
kobject: 'queues' (00000000552da2fa): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (0000000078141758): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (0000000078141758): kobject_uevent_env
kobject: 'rx-0' (0000000078141758): fill_kobj_path: path  
= '/devices/virtual/net/bridge0/queues/rx-0'
kobject: 'tx-0' (000000005e80af55): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (000000005e80af55): kobject_uevent_env
kobject: 'tx-0' (000000005e80af55): fill_kobj_path: path  
= '/devices/virtual/net/bridge0/queues/tx-0'
kobject: 'brif' (00000000c8bf76bf): kobject_add_internal:  
parent: 'bridge0', set: '<NULL>'
kobject: 'tunl0' (00000000a752cb36): kobject_cleanup, parent            
(null)
kobject: 'tunl0' (00000000a752cb36): auto cleanup 'remove' event
kobject: 'tunl0' (00000000a752cb36): kobject_uevent_env
kobject: 'tunl0' (00000000a752cb36): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tunl0' (00000000a752cb36): calling ktype release
kobject: 'tunl0': free name
device bridge_slave_1 left promiscuous mode
bridge0: port 2(bridge_slave_1) entered disabled state
kobject: 'brport' (000000005031346d): kobject_uevent_env
kobject: 'brport' (000000005031346d): kobject_uevent_env: filter function  
caused the event to drop!
device bridge_slave_0 left promiscuous mode
bridge0: port 1(bridge_slave_0) entered disabled state
kobject: 'brport' (000000005031346d): kobject_cleanup, parent            
(null)
kobject: 'brport' (000000005031346d): calling ktype release
kobject: 'brport': free name
kobject: 'brport' (00000000b1ad1e68): kobject_uevent_env
kobject: 'brport' (00000000b1ad1e68): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'brif' (000000006af76442): kobject_cleanup, parent 0000000028e7ba42
kobject: 'brif' (000000006af76442): auto cleanup kobject_del
kobject: 'brif' (000000006af76442): calling ktype release
kobject: (000000006af76442): dynamic_kobj_release
kobject: 'brif': free name
kobject: 'brport' (00000000b1ad1e68): kobject_cleanup, parent            
(null)
kobject: 'brport' (00000000b1ad1e68): calling ktype release
kobject: 'brport': free name
team0 (unregistering): Port device team_slave_1 removed
kobject: 'rx-0' (000000007779f1a6): kobject_cleanup, parent 000000004b650d31
kobject: 'rx-0' (000000007779f1a6): auto cleanup 'remove' event
kobject: 'rx-0' (000000007779f1a6): kobject_uevent_env
kobject: 'rx-0' (000000007779f1a6): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (000000007779f1a6): auto cleanup kobject_del
kobject: 'rx-0' (000000007779f1a6): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (0000000088012822): kobject_cleanup, parent 000000004b650d31
kobject: 'tx-0' (0000000088012822): auto cleanup 'remove' event
kobject: 'tx-0' (0000000088012822): kobject_uevent_env
kobject: 'tx-0' (0000000088012822): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (0000000088012822): auto cleanup kobject_del
kobject: 'tx-0' (0000000088012822): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (000000004b650d31): kobject_cleanup, parent            
(null)
kobject: 'queues' (000000004b650d31): calling ktype release
kobject: 'queues' (000000004b650d31): kset_release
kobject: 'queues': free name
kobject: 'team_slave_1' (0000000034c19cd0): kobject_uevent_env
kobject: 'team_slave_1' (0000000034c19cd0): kobject_uevent_env:  
uevent_suppress caused the event to drop!
kobject: 'rx-0' (00000000d720100c): kobject_cleanup, parent 000000004ada38be
kobject: 'rx-0' (00000000d720100c): auto cleanup 'remove' event
kobject: 'rx-0' (00000000d720100c): kobject_uevent_env
kobject: 'rx-0' (00000000d720100c): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000d720100c): auto cleanup kobject_del
kobject: 'rx-0' (00000000d720100c): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (000000005a4e65c3): kobject_cleanup, parent 000000004ada38be
kobject: 'tx-0' (000000005a4e65c3): auto cleanup 'remove' event
kobject: 'tx-0' (000000005a4e65c3): kobject_uevent_env
kobject: 'tx-0' (000000005a4e65c3): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (000000005a4e65c3): auto cleanup kobject_del
kobject: 'tx-0' (000000005a4e65c3): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (000000004ada38be): kobject_cleanup, parent            
(null)
kobject: 'queues' (000000004ada38be): calling ktype release
kobject: 'queues' (000000004ada38be): kset_release
kobject: 'queues': free name
kobject: 'veth1_to_team' (00000000635494af): kobject_uevent_env
kobject: 'veth1_to_team' (00000000635494af): kobject_uevent_env:  
uevent_suppress caused the event to drop!
team0 (unregistering): Port device team_slave_0 removed
kobject: 'rx-0' (0000000026c2e8e9): kobject_cleanup, parent 00000000328f51f1
kobject: 'rx-0' (0000000026c2e8e9): auto cleanup 'remove' event
kobject: 'rx-0' (0000000026c2e8e9): kobject_uevent_env
kobject: 'rx-0' (0000000026c2e8e9): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (0000000026c2e8e9): auto cleanup kobject_del
kobject: 'rx-0' (0000000026c2e8e9): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (00000000d45b45c1): kobject_cleanup, parent 00000000328f51f1
kobject: 'tx-0' (00000000d45b45c1): auto cleanup 'remove' event
kobject: 'tx-0' (00000000d45b45c1): kobject_uevent_env
kobject: 'tx-0' (00000000d45b45c1): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (00000000d45b45c1): auto cleanup kobject_del
kobject: 'tx-0' (00000000d45b45c1): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (00000000328f51f1): kobject_cleanup, parent            
(null)
kobject: 'queues' (00000000328f51f1): calling ktype release
kobject: 'queues' (00000000328f51f1): kset_release
kobject: 'queues': free name
kobject: 'team_slave_0' (000000007ce7cb14): kobject_uevent_env
kobject: 'team_slave_0' (000000007ce7cb14): kobject_uevent_env:  
uevent_suppress caused the event to drop!
kobject: 'rx-0' (00000000cb91554e): kobject_cleanup, parent 000000009bb1eee4
kobject: 'rx-0' (00000000cb91554e): auto cleanup 'remove' event
kobject: 'rx-0' (00000000cb91554e): kobject_uevent_env
kobject: 'rx-0' (00000000cb91554e): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000cb91554e): auto cleanup kobject_del
kobject: 'rx-0' (00000000cb91554e): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (00000000f68b70cb): kobject_cleanup, parent 000000009bb1eee4
kobject: 'tx-0' (00000000f68b70cb): auto cleanup 'remove' event
kobject: 'tx-0' (00000000f68b70cb): kobject_u

---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
