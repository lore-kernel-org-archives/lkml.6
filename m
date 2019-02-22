Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2241FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9DEE204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbfBVS0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 13:26:05 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:47630 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbfBVS0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 13:26:05 -0500
Received: by mail-io1-f70.google.com with SMTP id p12so2344930iod.14
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 10:26:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=T6Zf0RhyjizoSEliEtOUks78vNEOxrmkYDhvEyZ68U4=;
        b=Q04i+LQIwzFURm/sG7ygp55KKqb+5BMo1HmhaM6rlCWdDITxlRXNyEuAqkI59AwctC
         YgzPBlTPHONHXn/7VVZ4wzP2W7w8JgC3R6jPto4Untj5QgLqg7HgqHmx2FwiQcLjrJGS
         pylQ3K7idrdrQBzdfaabA3Wa885k9OwcqaBISNpyu2YHcoe2RPgnhLg3bwPWebSGR4AE
         eFWVVax5D3HF8m47YmBiFWxv2e46qRFjWeoI25vlOf8IY/Ax0bZFCNk1uOm9CckwwZal
         LUBI+0z/9GVgRfks41aybR2qtgnlxBcdZ8WSrd1vop2lm25LYiD4CuxL+wWSLDqNVBNl
         7Img==
X-Gm-Message-State: AHQUAuY+jwlxMM3vprvCO9RNZVRzOprYz9HV6GfukFYqAnVABW116y8A
        XWWEI+WHjQCIg4nzPk/NjLOkB8VkvROPeXhrbtlgkr/gWmZZ
X-Google-Smtp-Source: AHgI3IZNFqCcDxZtqoJKK6Jk4ZcBTB/BTag82k7v0y7trml52nnlKdfoxhgUTioWTFpBMjUXCDIM/QYpCNsspg7UOM6iyd4EW/MJ
MIME-Version: 1.0
X-Received: by 2002:a24:4d8e:: with SMTP id l136mr3237642itb.5.1550859963891;
 Fri, 22 Feb 2019 10:26:03 -0800 (PST)
Date:   Fri, 22 Feb 2019 10:26:03 -0800
In-Reply-To: <00000000000089904d057f1e0ae0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003e896f05827fb926@google.com>
Subject: Re: general protection fault in rose_send_frame
From:   syzbot <syzbot+7078ae989d857fe17988@syzkaller.appspotmail.com>
To:     davem@davemloft.net, linux-hams@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        ralf@linux-mips.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    7a25c6c0aac8 rocker: Add missing break for PRE_BRIDGE_FLAGS
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=104002d8c00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=58cb9d752ba5f3e0
dashboard link: https://syzkaller.appspot.com/bug?extid=7078ae989d857fe17988
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1224c304c00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=151824f8c00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+7078ae989d857fe17988@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_CHANGE): hsr_slave_1: link becomes ready
8021q: adding VLAN 0 to HW filter on device batadv0
IPv6: ADDRCONF(NETDEV_CHANGE): rose0: link becomes ready
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.0.0-rc7+ #76
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:rose_send_frame+0x1a8/0x280 net/rose/rose_link.c:104
Code: c1 ea 03 80 3c 02 00 0f 85 8d 00 00 00 48 b8 00 00 00 00 00 fc ff df  
4c 8b 63 20 49 8d bc 24 58 03 00 00 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75  
7e 49 8b 94 24 58 03 00 00 e9 b8 fe ff ff e8 f0 53
RSP: 0018:ffff8880ae807ae8 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff88809aa1fa00 RCX: ffffffff86378efb
RDX: 000000000000006b RSI: ffffffff8637902c RDI: 0000000000000358
RBP: ffff8880ae807b18 R08: ffffffff8887dec0 R09: ffffed101263146d
R10: ffffed101263146c R11: ffff88809318a363 R12: 0000000000000000
R13: 0000000000000078 R14: 0000000000000005 R15: ffff8880a4f6fbc0
FS:  0000000000000000(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f23b3e4ee78 CR3: 000000009eef3000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  <IRQ>
  rose_transmit_clear_request+0x1de/0x2a0 net/rose/rose_link.c:258
  rose_rx_call_request+0x4ea/0x1990 net/rose/af_rose.c:1001
  rose_loopback_timer+0x26a/0x3f0 net/rose/rose_loopback.c:100
  call_timer_fn+0x190/0x720 kernel/time/timer.c:1325
  expire_timers kernel/time/timer.c:1362 [inline]
  __run_timers kernel/time/timer.c:1681 [inline]
  __run_timers kernel/time/timer.c:1649 [inline]
  run_timer_softirq+0x652/0x1700 kernel/time/timer.c:1694
  __do_softirq+0x266/0x95a kernel/softirq.c:292
  invoke_softirq kernel/softirq.c:373 [inline]
  irq_exit+0x180/0x1d0 kernel/softirq.c:413
  exiting_irq arch/x86/include/asm/apic.h:536 [inline]
  smp_apic_timer_interrupt+0x14a/0x570 arch/x86/kernel/apic/apic.c:1062
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:807
  </IRQ>
RIP: 0010:native_safe_halt+0x2/0x10 arch/x86/include/asm/irqflags.h:58
Code: ff ff ff 48 89 c7 48 89 45 d8 e8 59 6c a1 fa 48 8b 45 d8 e9 ce fe ff  
ff 48 89 df e8 48 6c a1 fa eb 82 90 90 90 90 90 90 fb f4 <c3> 0f 1f 00 66  
2e 0f 1f 84 00 00 00 00 00 f4 c3 90 90 90 90 90 90
RSP: 0018:ffffffff88807d08 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff13
RAX: 1ffffffff1125061 RBX: ffffffff8887dec0 RCX: 0000000000000000
RDX: dffffc0000000000 RSI: 0000000000000001 RDI: ffffffff8887e73c
RBP: ffffffff88807d38 R08: ffffffff8887dec0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffffffff889282f8 R14: 0000000000000000 R15: 0000000000000000
  arch_cpu_idle+0x10/0x20 arch/x86/kernel/process.c:555
  default_idle_call+0x36/0x90 kernel/sched/idle.c:93
  cpuidle_idle_call kernel/sched/idle.c:153 [inline]
  do_idle+0x386/0x570 kernel/sched/idle.c:262
  cpu_startup_entry+0x1b/0x20 kernel/sched/idle.c:353
  rest_init+0x245/0x37b init/main.c:442
  arch_call_rest_init+0xe/0x1b
  start_kernel+0x803/0x83c init/main.c:739
  x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:470
  x86_64_start_kernel+0x77/0x7b arch/x86/kernel/head64.c:451
  secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:243
Modules linked in:
---[ end trace 8f29030702ddb052 ]---
RIP: 0010:rose_send_frame+0x1a8/0x280 net/rose/rose_link.c:104
Code: c1 ea 03 80 3c 02 00 0f 85 8d 00 00 00 48 b8 00 00 00 00 00 fc ff df  
4c 8b 63 20 49 8d bc 24 58 03 00 00 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75  
7e 49 8b 94 24 58 03 00 00 e9 b8 fe ff ff e8 f0 53
RSP: 0018:ffff8880ae807ae8 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff88809aa1fa00 RCX: ffffffff86378efb
RDX: 000000000000006b RSI: ffffffff8637902c RDI: 0000000000000358
RBP: ffff8880ae807b18 R08: ffffffff8887dec0 R09: ffffed101263146d
R10: ffffed101263146c R11: ffff88809318a363 R12: 0000000000000000
R13: 0000000000000078 R14: 0000000000000005 R15: ffff8880a4f6fbc0
FS:  0000000000000000(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f23b3e4ee78 CR3: 000000009eef3000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

