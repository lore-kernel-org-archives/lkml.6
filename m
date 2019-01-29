Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFCFC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89E6021473
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbfA2RdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:33:05 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:39056 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727993AbfA2RdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 12:33:04 -0500
Received: by mail-io1-f70.google.com with SMTP id q23so17234636ior.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 09:33:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=gQkIedbpzPLyZ0g0DlBcMR6eqwozWkapQ9632gLfoVQ=;
        b=db1pfs4igbPnshtUf2CUFwO8xYKaWN0a3gq/BPV8Jp1Slb0Cf73cWaXOj/UTUuIhX8
         teqasc+4aKsAPrAd3hZR1WN3NvObie6FH1IiM2n/Ljoihu5WOrBwe4v28NWRHmx3YCtq
         uKyeHwXU+jK5HfbyrJFgKkK9FJXNPLVANfk6Jdh71hAm0DbSSS3n+dma/Hy60k+VXIUe
         /7gMAZeMjxLsdeATL6m+uFc1a4MZVPqmMq0/DGHEnpALFGpj3Vgvhyg9MUiNMQ8lYREE
         ST9+UFf8qPW3VMiSOm/wUf5a6UuQxoBxT/7TG+KZt7z2idkPNKdqScyomO6h0T6wJu4X
         Bd/w==
X-Gm-Message-State: AHQUAua+cF246/LpFWDrb4PzwqordjvzwfqjzT8Zy3xXHeKXTlDvymKw
        vfvBg25J4y0uQaWQyvUb1CGjGVqIEr7sQ63UP5lgdWMD4qaB
X-Google-Smtp-Source: AHgI3IYT7t+AYmaiCo7tsXUCP9Y6ORr97pbjAZjIz7LWzWCZyW2dfW977J9ezI7z4bpRhep0Trf2Fxi568Mwby0dwSoqbG8jy7i1
MIME-Version: 1.0
X-Received: by 2002:a5d:9a0b:: with SMTP id s11mr3598781iol.5.1548783183511;
 Tue, 29 Jan 2019 09:33:03 -0800 (PST)
Date:   Tue, 29 Jan 2019 09:33:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007cd20e05809c2f96@google.com>
Subject: INFO: trying to register non-static key in icmp_send
From:   syzbot <syzbot+e1628a5e87492e6f1b76@syzkaller.appspotmail.com>
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

HEAD commit:    4aa9fc2a435a Revert "mm, memory_hotplug: initialize struct..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=168581ef400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4fceea9e2d99ac20
dashboard link: https://syzkaller.appspot.com/bug?extid=e1628a5e87492e6f1b76
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=175c96ef400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e1628a5e87492e6f1b76@syzkaller.appspotmail.com

Enabling of bearer <udp:syz1> rejected, already enabled
Enabling of bearer <udp:syz1> rejected, already enabled
Enabling of bearer <udp:syz1> rejected, already enabled
Enabling of bearer <udp:syz1> rejected, already enabled
Enabling of bearer <udp:syz1> rejected, already enabled
INFO: trying to register non-static key.
the code is fine but needs lockdep annotation.
Enabling of bearer <udp:syz1> rejected, already enabled
turning off the locking correctness validator.
CPU: 1 PID: 3867 Comm: udevd Not tainted 5.0.0-rc4+ #50
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
  assign_lock_key kernel/locking/lockdep.c:731 [inline]
  register_lock_class+0x19dc/0x1e60 kernel/locking/lockdep.c:757
  __lock_acquire+0x149/0x4a30 kernel/locking/lockdep.c:3224
Enabling of bearer <udp:syz1> rejected, already enabled
Enabling of bearer <udp:syz1> rejected, already enabled
  lock_acquire+0x1db/0x570 kernel/locking/lockdep.c:3841
Enabling of bearer <udp:syz1> rejected, already enabled
Enabling of bearer <udp:syz1> rejected, already enabled
  __raw_spin_trylock include/linux/spinlock_api_smp.h:90 [inline]
  _raw_spin_trylock+0x62/0x80 kernel/locking/spinlock.c:128
  spin_trylock include/linux/spinlock.h:339 [inline]
  icmp_xmit_lock net/ipv4/icmp.c:219 [inline]
  icmp_send+0x582/0x1bc0 net/ipv4/icmp.c:665
  __udp4_lib_rcv+0x23a8/0x3180 net/ipv4/udp.c:2321
Enabling of bearer <udp:syz1> rejected, already enabled
  udp_rcv+0x22/0x30 net/ipv4/udp.c:2480
  ip_protocol_deliver_rcu+0xb6/0xa20 net/ipv4/ip_input.c:208
Enabling of bearer <udp:syz1> rejected, already enabled
  ip_local_deliver_finish+0x23b/0x390 net/ipv4/ip_input.c:234
  NF_HOOK include/linux/netfilter.h:289 [inline]
  NF_HOOK include/linux/netfilter.h:283 [inline]
  ip_local_deliver+0x1f0/0x740 net/ipv4/ip_input.c:255
Enabling of bearer <udp:syz1> rejected, already enabled
  dst_input include/net/dst.h:450 [inline]
  ip_rcv_finish+0x1f4/0x2f0 net/ipv4/ip_input.c:414
  NF_HOOK include/linux/netfilter.h:289 [inline]
  NF_HOOK include/linux/netfilter.h:283 [inline]
  ip_rcv+0xed/0x620 net/ipv4/ip_input.c:524
  __netif_receive_skb_one_core+0x160/0x210 net/core/dev.c:4973
  __netif_receive_skb+0x2c/0x1c0 net/core/dev.c:5083
  process_backlog+0x206/0x750 net/core/dev.c:5923
  napi_poll net/core/dev.c:6346 [inline]
  net_rx_action+0x76d/0x1930 net/core/dev.c:6412
  __do_softirq+0x30b/0xb11 kernel/softirq.c:292
  invoke_softirq kernel/softirq.c:373 [inline]
  irq_exit+0x180/0x1d0 kernel/softirq.c:413
  exiting_irq arch/x86/include/asm/apic.h:536 [inline]
  smp_apic_timer_interrupt+0x1b7/0x760 arch/x86/kernel/apic/apic.c:1062
Enabling of bearer <udp:syz1> rejected, already enabled
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:807
  </IRQ>
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:766  
[inline]
RIP: 0010:lock_acquire+0x259/0x570 kernel/locking/lockdep.c:3844
Code: 00 00 00 00 00 48 c1 e8 03 80 3c 10 00 0f 85 64 02 00 00 48 83 3d 66  
30 2e 08 00 0f 84 d0 01 00 00 48 8b bd 48 ff ff ff 57 9d <0f> 1f 44 00 00  
48 b8 00 00 00 00 00 fc ff df 48 03 85 40 ff ff ff
RSP: 0018:ffff888097c57640 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff13
RAX: 1ffffffff1325046 RBX: ffff888097c4c2c0 RCX: 0000000000000000
RDX: dffffc0000000000 RSI: 0000000000000eb8 RDI: 0000000000000282
RBP: ffff888097c57710 R08: 0000000000000001 R09: ffff888097c4cb88
R10: ffff888097c4cb68 R11: 0000000000000001 R12: ffff88808954e7b8
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
  __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
  _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:144
  spin_lock include/linux/spinlock.h:329 [inline]
  __d_lookup+0x2b6/0x960 fs/dcache.c:2272
  lookup_fast+0x480/0x1260 fs/namei.c:1617
  do_last fs/namei.c:3284 [inline]
  path_openat+0x4db/0x5650 fs/namei.c:3534
  do_filp_open+0x26f/0x370 fs/namei.c:3564
  do_sys_open+0x59a/0x7c0 fs/open.c:1063
  __do_sys_open fs/open.c:1081 [inline]
  __se_sys_open fs/open.c:1076 [inline]
  __x64_sys_open+0x7e/0xc0 fs/open.c:1076
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f902edde120
Code: 48 8b 15 1b 4d 2b 00 f7 d8 64 89 02 83 c8 ff c3 90 90 90 90 90 90 90  
90 90 90 83 3d d5 a4 2b 00 00 75 10 b8 02 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 73 31 c3 48 83 ec 08 e8 5e 8c 01 00 48 89 04 24
RSP: 002b:00007ffc8e9d9588 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0000000000b35bb0 RCX: 00007f902edde120
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 00007ffc8e9da200
RBP: 0000000000b35360 R08: 000000000041f4f1 R09: 00007f902ee347d0
R10: 7269762f73656369 R11: 0000000000000246 R12: 0000000000000003
R13: 0000000000000000 R14: 0000000000b35bb0 R15: 0000000000b25250
kasan: CONFIG_KASAN_INLINE enabled
Enabling of bearer <udp:syz1> rejected, already enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 3867 Comm: udevd Not tainted 5.0.0-rc4+ #50
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__ip_append_data.isra.0+0x301/0x3350 net/ipv4/ip_output.c:898
Code: c7 85 64 fe ff ff 00 00 00 00 0f 85 78 15 00 00 e8 d4 c5 f0 fa 48 8b  
95 d8 fe ff ff 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f  
85 60 2f 00 00 48 8b 85 d8 fe ff ff 48 8b 18 48 b8
RSP: 0018:ffff8880ae706e38 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff86913e0c
RDX: 0000000000000000 RSI: ffffffff86913e8c RDI: 0000000000000001
RBP: ffff8880ae707010 R08: ffff888097c4c2c0 R09: ffffffff86a3da70
R10: ffff8880ae707180 R11: ffff888096919343 R12: ffff88808dba2a70
R13: ffff88808dba2f10 R14: 0000000000000001 R15: dead4ead00000000
FS:  00007f902f6d67a0(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fffb4062fe4 CR3: 00000000981e9000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  <IRQ>
Enabling of bearer <udp:syz1> rejected, already enabled
Enabling of bearer <udp:syz1> rejected, already enabled
  ip_append_data.part.0+0xf2/0x170 net/ipv4/ip_output.c:1220
Enabling of bearer <udp:syz1> rejected, already enabled
  ip_append_data+0x6e/0x90 net/ipv4/ip_output.c:1209
  icmp_push_reply+0x189/0x510 net/ipv4/icmp.c:375
Enabling of bearer <udp:syz1> rejected, already enabled
  icmp_send+0x1535/0x1bc0 net/ipv4/icmp.c:736
Enabling of bearer <udp:syz1> rejected, already enabled
  __udp4_lib_rcv+0x23a8/0x3180 net/ipv4/udp.c:2321
  udp_rcv+0x22/0x30 net/ipv4/udp.c:2480
  ip_protocol_deliver_rcu+0xb6/0xa20 net/ipv4/ip_input.c:208
Enabling of bearer <udp:syz1> rejected, already enabled
  ip_local_deliver_finish+0x23b/0x390 net/ipv4/ip_input.c:234
  NF_HOOK include/linux/netfilter.h:289 [inline]
  NF_HOOK include/linux/netfilter.h:283 [inline]
  ip_local_deliver+0x1f0/0x740 net/ipv4/ip_input.c:255
Enabling of bearer <udp:syz1> rejected, already enabled
  dst_input include/net/dst.h:450 [inline]
  ip_rcv_finish+0x1f4/0x2f0 net/ipv4/ip_input.c:414
  NF_HOOK include/linux/netfilter.h:289 [inline]
  NF_HOOK include/linux/netfilter.h:283 [inline]
  ip_rcv+0xed/0x620 net/ipv4/ip_input.c:524
  __netif_receive_skb_one_core+0x160/0x210 net/core/dev.c:4973
Enabling of bearer <udp:syz1> rejected, already enabled
Enabling of bearer <udp:syz1> rejected, already enabled
  __netif_receive_skb+0x2c/0x1c0 net/core/dev.c:5083
  process_backlog+0x206/0x750 net/core/dev.c:5923
Enabling of bearer <udp:syz1> rejected, already enabled
  napi_poll net/core/dev.c:6346 [inline]
  net_rx_action+0x76d/0x1930 net/core/dev.c:6412
Enabling of bearer <udp:syz1> rejected, already enabled
  __do_softirq+0x30b/0xb11 kernel/softirq.c:292
  invoke_softirq kernel/softirq.c:373 [inline]
  irq_exit+0x180/0x1d0 kernel/softirq.c:413
  exiting_irq arch/x86/include/asm/apic.h:536 [inline]
  smp_apic_timer_interrupt+0x1b7/0x760 arch/x86/kernel/apic/apic.c:1062
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:807
  </IRQ>
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:766  
[inline]
RIP: 0010:lock_acquire+0x259/0x570 kernel/locking/lockdep.c:3844
Code: 00 00 00 00 00 48 c1 e8 03 80 3c 10 00 0f 85 64 02 00 00 48 83 3d 66  
30 2e 08 00 0f 84 d0 01 00 00 48 8b bd 48 ff ff ff 57 9d <0f> 1f 44 00 00  
48 b8 00 00 00 00 00 fc ff df 48 03 85 40 ff ff ff
RSP: 0018:ffff888097c57640 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff13
RAX: 1ffffffff1325046 RBX: ffff888097c4c2c0 RCX: 0000000000000000
RDX: dffffc0000000000 RSI: 0000000000000eb8 RDI: 0000000000000282
RBP: ffff888097c57710 R08: 0000000000000001 R09: ffff888097c4cb88
R10: ffff888097c4cb68 R11: 0000000000000001 R12: ffff88808954e7b8
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
  __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
  _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:144
  spin_lock include/linux/spinlock.h:329 [inline]
  __d_lookup+0x2b6/0x960 fs/dcache.c:2272
  lookup_fast+0x480/0x1260 fs/namei.c:1617
  do_last fs/namei.c:3284 [inline]
  path_openat+0x4db/0x5650 fs/namei.c:3534
  do_filp_open+0x26f/0x370 fs/namei.c:3564
  do_sys_open+0x59a/0x7c0 fs/open.c:1063
  __do_sys_open fs/open.c:1081 [inline]
  __se_sys_open fs/open.c:1076 [inline]
  __x64_sys_open+0x7e/0xc0 fs/open.c:1076
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f902edde120
Code: 48 8b 15 1b 4d 2b 00 f7 d8 64 89 02 83 c8 ff c3 90 90 90 90 90 90 90  
90 90 90 83 3d d5 a4 2b 00 00 75 10 b8 02 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 73 31 c3 48 83 ec 08 e8 5e 8c 01 00 48 89 04 24
RSP: 002b:00007ffc8e9d9588 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0000000000b35bb0 RCX: 00007f902edde120
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 00007ffc8e9da200
RBP: 0000000000b35360 R08: 000000000041f4f1 R09: 00007f902ee347d0
R10: 7269762f73656369 R11: 0000000000000246 R12: 0000000000000003
R13: 0000000000000000 R14: 0000000000b35bb0 R15: 0000000000b25250
Modules linked in:
---[ end trace 6d5f724bc69e6c3e ]---
Enabling of bearer <udp:syz1> rejected, already enabled
RIP: 0010:__ip_append_data.isra.0+0x301/0x3350 net/ipv4/ip_output.c:898
Code: c7 85 64 fe ff ff 00 00 00 00 0f 85 78 15 00 00 e8 d4 c5 f0 fa 48 8b  
95 d8 fe ff ff 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f  
85 60 2f 00 00 48 8b 85 d8 fe ff ff 48 8b 18 48 b8
RSP: 0018:ffff8880ae706e38 EFLAGS: 00010246
Enabling of bearer <udp:syz1> rejected, already enabled
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff86913e0c
RDX: 0000000000000000 RSI: ffffffff86913e8c RDI: 0000000000000001
RBP: ffff8880ae707010 R08: ffff888097c4c2c0 R09: ffffffff86a3da70
Enabling of bearer <udp:syz1> rejected, already enabled
R10: ffff8880ae707180 R11: ffff888096919343 R12: ffff88808dba2a70
R13: ffff88808dba2f10 R14: 0000000000000001 R15: dead4ead00000000
FS:  00007f902f6d67a0(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fffb4062fe4 CR3: 00000000981e9000 CR4: 00000000001406e0
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
