Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,T_MIXED_ES,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53F1C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6013D2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:11:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6013D2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbeLLLLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 06:11:15 -0500
Received: from mail-it1-f197.google.com ([209.85.166.197]:58359 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeLLLLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 06:11:06 -0500
Received: by mail-it1-f197.google.com with SMTP id n124so5179986itb.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 03:11:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=kCC5TL11+QuC5Ngxlw79IK6fppo6nV3e1s/WkyA9tNM=;
        b=fVycuT0jg6/AI8702Cb+lAZF4IrkZljOJHIv9IrE3zfzbz4RoaTDAGThTOvP8k6xlJ
         O/XylBANya6fv8kx4EJSFYFyhKdC/IKGFchfsJFkadpLHxH5e8qOKOePOykz4rY6XhnU
         Q/cEWqEkDzVXY+fOKEWkvpfZU72VAJ6QS196U+bbvydVMX24Ej5xxJmYneo5rUrkzHPT
         YzOKEgmt5q223D7Cto2IVlpdjxApYzB5znfuQ0FazvDquN98AUMRMX60YvanXPz4GuwA
         +qfmSz0N63cr57sGyNyXcE/7rxqgPBoLSb7hmGwxLcCcGIyLYFk/L1UsphsH5+iAxPII
         e6pQ==
X-Gm-Message-State: AA+aEWZ3WRJmqTFf2NBPsnsWkkc1VsV/nrLMxoyIDpBS/yXPkXHpTmL0
        D3qqJ3JMdQ3ho7zCe+hVqgAnT/HcuceA02Vp4BR8ooaiqn+c
X-Google-Smtp-Source: AFSGD/XpjnqkYKVPX6w9palrZ3BPL12SAfGrbFRC2mDsgRdHJ1pULAmmhIKQDnUt2Fp1GjiEqofDmQ3T845rywzrLabRsVkXwYu/
MIME-Version: 1.0
X-Received: by 2002:a02:97da:: with SMTP id v26mr15980520jaj.1.1544613064772;
 Wed, 12 Dec 2018 03:11:04 -0800 (PST)
Date:   Wed, 12 Dec 2018 03:11:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000a9cca057cd141bd@google.com>
Subject: inconsistent lock state in icmp_send
From:   syzbot <syzbot+251ec6887ada6eac4921@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    f5d582777bcb Merge branch 'for-linus' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16d7b01b400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8970c89a0efbb23
dashboard link: https://syzkaller.appspot.com/bug?extid=251ec6887ada6eac4921
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10ab6ba3400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+251ec6887ada6eac4921@syzkaller.appspotmail.com

Enabling of bearer <udp:syz1> rejected, already enabled
Enabling of bearer <udp:syz1> rejected, already enabled

================================
Enabling of bearer <udp:syz1> rejected, already enabled
WARNING: inconsistent lock state
4.20.0-rc6+ #150 Not tainted
--------------------------------
inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
ksoftirqd/0/9 [HC0[0]:SC1[3]:HE1:SE0] takes:
00000000b8fc8cda (&(&i->lock)->rlock){?.-.}, at: spin_trylock  
include/linux/spinlock.h:339 [inline]
00000000b8fc8cda (&(&i->lock)->rlock){?.-.}, at: icmp_xmit_lock  
net/ipv4/icmp.c:219 [inline]
00000000b8fc8cda (&(&i->lock)->rlock){?.-.}, at: icmp_send+0x59e/0x1bd0  
net/ipv4/icmp.c:665
Enabling of bearer <udp:syz1> rejected, already enabled
{IN-HARDIRQ-W} state was registered at:
   lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
   __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
   _raw_spin_lock+0x2d/0x40 kernel/locking/spinlock.c:144
   spin_lock include/linux/spinlock.h:329 [inline]
   serial8250_interrupt+0x29/0x190 drivers/tty/serial/8250/8250_core.c:115
Enabling of bearer <udp:syz1> rejected, already enabled
   __handle_irq_event_percpu+0x195/0xb30 kernel/irq/handle.c:149
   handle_irq_event_percpu+0xa0/0x1d0 kernel/irq/handle.c:189
   handle_irq_event+0xa7/0x135 kernel/irq/handle.c:206
kobject: 'loop0' (000000006a387ba7): kobject_uevent_env
   handle_edge_irq+0x227/0x880 kernel/irq/chip.c:791
Enabling of bearer <udp:syz1> rejected, already enabled
   generic_handle_irq_desc include/linux/irqdesc.h:154 [inline]
   handle_irq+0x252/0x3d8 arch/x86/kernel/irq_64.c:78
   do_IRQ+0x98/0x1c0 arch/x86/kernel/irq.c:246
   ret_from_intr+0x0/0x1e
   arch_local_irq_restore arch/x86/include/asm/paravirt.h:761 [inline]
   __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160 [inline]
   _raw_spin_unlock_irqrestore+0xaf/0xd0 kernel/locking/spinlock.c:184
   spin_unlock_irqrestore include/linux/spinlock.h:384 [inline]
   serial8250_do_startup+0xc86/0x2080  
drivers/tty/serial/8250/8250_port.c:2370
kobject: 'loop0' (000000006a387ba7): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
   serial8250_startup+0x61/0x80 drivers/tty/serial/8250/8250_port.c:2425
   uart_port_startup+0x51f/0x9c0 drivers/tty/serial/serial_core.c:213
   uart_startup drivers/tty/serial/serial_core.c:252 [inline]
   uart_port_activate+0x194/0x230 drivers/tty/serial/serial_core.c:1769
kobject: 'loop1' (000000009d41c739): kobject_uevent_env
   tty_port_open+0x137/0x1c0 drivers/tty/tty_port.c:688
   uart_open+0xe6/0x130 drivers/tty/serial/serial_core.c:1748
   tty_open+0x2aa/0xb30 drivers/tty/tty_io.c:2037
   chrdev_open+0x25a/0x710 fs/char_dev.c:417
   do_dentry_open+0x499/0x1250 fs/open.c:771
   vfs_open+0xa0/0xd0 fs/open.c:880
kobject: 'loop1' (000000009d41c739): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
   do_last fs/namei.c:3418 [inline]
   path_openat+0x12bc/0x5150 fs/namei.c:3534
   do_filp_open+0x255/0x380 fs/namei.c:3564
Enabling of bearer <udp:syz1> rejected, already enabled
   do_sys_open+0x568/0x700 fs/open.c:1063
   ksys_open include/linux/syscalls.h:1279 [inline]
   kernel_init_freeable+0x612/0x6bf init/main.c:1154
   kernel_init+0x11/0x1ae init/main.c:1071
Enabling of bearer <udp:syz1> rejected, already enabled
   ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
irq event stamp: 357964
hardirqs last  enabled at (357964): [<ffffffff814aca20>]  
__local_bh_enable_ip+0x160/0x260 kernel/softirq.c:194
hardirqs last disabled at (357963): [<ffffffff814ac9e0>]  
__local_bh_enable_ip+0x120/0x260 kernel/softirq.c:171
softirqs last  enabled at (357944): [<ffffffff880007df>]  
__do_softirq+0x7df/0xb7e kernel/softirq.c:319
Enabling of bearer <udp:syz1> rejected, already enabled
softirqs last disabled at (357949): [<ffffffff814aeaee>]  
run_ksoftirqd+0x5e/0x100 kernel/softirq.c:654

other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(&(&i->lock)->rlock);
   <Interrupt>
     lock(&(&i->lock)->rlock);
Enabling of bearer <udp:syz1> rejected, already enabled

  *** DEADLOCK ***

2 locks held by ksoftirqd/0/9:
  #0: 000000008aedccf1 (rcu_read_lock){....}, at: __skb_unlink  
include/linux/skbuff.h:1909 [inline]
  #0: 000000008aedccf1 (rcu_read_lock){....}, at: __skb_dequeue  
include/linux/skbuff.h:1925 [inline]
  #0: 000000008aedccf1 (rcu_read_lock){....}, at:  
process_backlog+0x1dd/0x7a0 net/core/dev.c:5862
  #1: 000000008aedccf1 (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2142 [inline]
  #1: 000000008aedccf1 (rcu_read_lock){....}, at:  
ip_local_deliver_finish+0x19a/0xda0 net/ipv4/ip_input.c:193

stack backtrace:
Enabling of bearer <udp:syz1> rejected, already enabled
CPU: 0 PID: 9 Comm: ksoftirqd/0 Not tainted 4.20.0-rc6+ #150
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
Enabling of bearer <udp:syz1> rejected, already enabled
  print_usage_bug.cold.59+0x320/0x41a kernel/locking/lockdep.c:2472
kobject: 'loop4' (000000002b4feb64): kobject_uevent_env
  valid_state kernel/locking/lockdep.c:2485 [inline]
  mark_lock_irq kernel/locking/lockdep.c:2679 [inline]
  mark_lock+0x1276/0x1cd0 kernel/locking/lockdep.c:3059
  mark_irqflags kernel/locking/lockdep.c:2951 [inline]
  __lock_acquire+0xcad/0x4c20 kernel/locking/lockdep.c:3298
kobject: 'loop4' (000000002b4feb64): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
Enabling of bearer <udp:syz1> rejected, already enabled
kobject: 'loop5' (0000000077f1f8fc): kobject_uevent_env
  lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
Enabling of bearer <udp:syz1> rejected, already enabled
Enabling of bearer <udp:syz1> rejected, already enabled
  __raw_spin_trylock include/linux/spinlock_api_smp.h:90 [inline]
  _raw_spin_trylock+0x61/0x80 kernel/locking/spinlock.c:128
  spin_trylock include/linux/spinlock.h:339 [inline]
  icmp_xmit_lock net/ipv4/icmp.c:219 [inline]
  icmp_send+0x59e/0x1bd0 net/ipv4/icmp.c:665
kobject: 'loop5' (0000000077f1f8fc): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
Enabling of bearer <udp:syz1> rejected, already enabled
Enabling of bearer <udp:syz1> rejected, already enabled
Enabling of bearer <udp:syz1> rejected, already enabled
  __udp4_lib_rcv+0x2484/0x32e0 net/ipv4/udp.c:2233
kobject: 'loop1' (000000009d41c739): kobject_uevent_env
Enabling of bearer <udp:syz1> rejected, already enabled
kobject: 'loop1' (000000009d41c739): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
  udp_rcv+0x21/0x30 net/ipv4/udp.c:2392
  ip_local_deliver_finish+0x2e9/0xda0 net/ipv4/ip_input.c:215
kobject: 'loop4' (000000002b4feb64): kobject_uevent_env
  NF_HOOK include/linux/netfilter.h:289 [inline]
  ip_local_deliver+0x1e9/0x750 net/ipv4/ip_input.c:256
kobject: 'loop4' (000000002b4feb64): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop0' (000000006a387ba7): kobject_uevent_env
kobject: 'loop0' (000000006a387ba7): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
  dst_input include/net/dst.h:450 [inline]
  ip_rcv_finish+0x1f9/0x300 net/ipv4/ip_input.c:415
Enabling of bearer <udp:syz1> rejected, already enabled
  NF_HOOK include/linux/netfilter.h:289 [inline]
  ip_rcv+0xed/0x600 net/ipv4/ip_input.c:524
Enabling of bearer <udp:syz1> rejected, already enabled
  __netif_receive_skb_one_core+0x14d/0x200 net/core/dev.c:4946
kobject: 'loop5' (0000000077f1f8fc): kobject_uevent_env
  __netif_receive_skb+0x2c/0x1e0 net/core/dev.c:5056
  process_backlog+0x24e/0x7a0 net/core/dev.c:5864
kobject: 'loop5' (0000000077f1f8fc): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
  napi_poll net/core/dev.c:6287 [inline]
  net_rx_action+0x7fa/0x19b0 net/core/dev.c:6353
  __do_softirq+0x308/0xb7e kernel/softirq.c:292
  run_ksoftirqd+0x5e/0x100 kernel/softirq.c:654
  smpboot_thread_fn+0x68b/0xa00 kernel/smpboot.c:164
  kthread+0x35a/0x440 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
kobject: 'loop2' (0000000094a80a8b): kobject_uevent_env
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 9 Comm: ksoftirqd/0 Not tainted 4.20.0-rc6+ #150
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__ip_append_data.isra.48+0x138a/0x29b0 net/ipv4/ip_output.c:888
Code: dc 03 00 00 e9 97 ef ff ff e8 12 b1 e0 fa 48 8b 85 48 fe ff ff 48 8d  
78 3c 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48  
89 f8 83 e0 07 83 c0 01 38 d0 7c 08 84 d2 0f 85 df
RSP: 0018:ffff8881d9ae69c0 EFLAGS: 00010203
RAX: dffffc0000000000 RBX: dffffc0000000000 RCX: ffff8881b46b772c
RDX: 0000000000000007 RSI: ffffffff869ed35e RDI: 000000000000003c
RBP: ffff8881d9ae6c28 R08: ffff8881b46b75a4 R09: ffffffff86b113b0
R10: ffff8881d9ae6da0 R11: ffff8881dae2dafb R12: ffff8881b46b74dc
R13: 0000000000000000 R14: 0000000000000070 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8881dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8a69920000 CR3: 00000001b2258000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
kobject: 'loop2' (0000000094a80a8b): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
kobject: 'loop3' (00000000e8f67fba): kobject_uevent_env
Enabling of bearer <udp:syz1> rejected, already enabled
  ip_append_data.part.49+0xef/0x170 net/ipv4/ip_output.c:1197
  ip_append_data+0x6d/0x90 net/ipv4/ip_output.c:1186
  icmp_push_reply+0x18e/0x540 net/ipv4/icmp.c:375
  icmp_send+0x1544/0x1bd0 net/ipv4/icmp.c:736
  __udp4_lib_rcv+0x2484/0x32e0 net/ipv4/udp.c:2233
  udp_rcv+0x21/0x30 net/ipv4/udp.c:2392
  ip_local_deliver_finish+0x2e9/0xda0 net/ipv4/ip_input.c:215
  NF_HOOK include/linux/netfilter.h:289 [inline]
  ip_local_deliver+0x1e9/0x750 net/ipv4/ip_input.c:256
  dst_input include/net/dst.h:450 [inline]
  ip_rcv_finish+0x1f9/0x300 net/ipv4/ip_input.c:415
  NF_HOOK include/linux/netfilter.h:289 [inline]
  ip_rcv+0xed/0x600 net/ipv4/ip_input.c:524
  __netif_receive_skb_one_core+0x14d/0x200 net/core/dev.c:4946
  __netif_receive_skb+0x2c/0x1e0 net/core/dev.c:5056
  process_backlog+0x24e/0x7a0 net/core/dev.c:5864
  napi_poll net/core/dev.c:6287 [inline]
  net_rx_action+0x7fa/0x19b0 net/core/dev.c:6353
  __do_softirq+0x308/0xb7e kernel/softirq.c:292
  run_ksoftirqd+0x5e/0x100 kernel/softirq.c:654
  smpboot_thread_fn+0x68b/0xa00 kernel/smpboot.c:164
  kthread+0x35a/0x440 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Modules linked in:
---[ end trace b9edc56913d2c907 ]---
RIP: 0010:__ip_append_data.isra.48+0x138a/0x29b0 net/ipv4/ip_output.c:888
Enabling of bearer <udp:syz1> rejected, already enabled
Code: dc 03 00 00 e9 97 ef ff ff e8 12 b1 e0 fa 48 8b 85 48 fe ff ff 48 8d  
78 3c 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48  
89 f8 83 e0 07 83 c0 01 38 d0 7c 08 84 d2 0f 85 df
kobject: 'loop3' (00000000e8f67fba): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
RSP: 0018:ffff8881d9ae69c0 EFLAGS: 00010203
RAX: dffffc0000000000 RBX: dffffc0000000000 RCX: ffff8881b46b772c
RDX: 0000000000000007 RSI: ffffffff869ed35e RDI: 000000000000003c
RBP: ffff8881d9ae6c28 R08: ffff8881b46b75a4 R09: ffffffff86b113b0
R10: ffff8881d9ae6da0 R11: ffff8881dae2dafb R12: ffff8881b46b74dc
R13: 0000000000000000 R14: 0000000000000070 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8881dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kobject: 'loop0' (000000006a387ba7): kobject_uevent_env
CR2: 00007f8a69920000 CR3: 000000000946a000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
