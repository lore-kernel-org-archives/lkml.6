Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F429C282D7
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 05:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 168DD21773
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 05:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfBDFnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 00:43:04 -0500
Received: from mail-it1-f197.google.com ([209.85.166.197]:42847 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfBDFnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 00:43:04 -0500
Received: by mail-it1-f197.google.com with SMTP id g7so12779254itg.7
        for <linux-kernel@vger.kernel.org>; Sun, 03 Feb 2019 21:43:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=cFS2FgXfVX6ztIQl2sXWDhUac3bPqmCnVhgawluBHKw=;
        b=NJcCAA5M/dY08XuoiSF2cWpIdi2yI24Qvy6ilRCuFVZZxgeRKrlxqTnutXzA2Vu0Pp
         jfX/fY7uinat/vcl1yPm3MNjH9AR9GIiwzQYr7pJq2ldD54Girl3Dt/rXDrLpE5LoS26
         dgNUOLaBoso5aF0iX1oy6QTFsQeLZGROAdKR3wi7p/Fflvp+NQUnBzUuH0jSzBsi1QQL
         GwsUGGf0stQsvf+Q6Ih+zY14HFDjOrocQYpFeBdinvanUWv6FbKD44urSHPcA7sFq8xS
         0YAsL94M6anN3t5mGxWOvrLe7enOQUT2JMfJ0DxedFRio01HZVVxZZSQXlQbtySTc/0H
         i5lg==
X-Gm-Message-State: AHQUAuYVD+myMhGIstaQys1i71xpCHbv0VddJORS0JLFOwqMAHjucBCo
        ANl0gVAnRZyvbwj/uT/7pUF2pGOwZxmL70+PZoA1YoBMNqJV
X-Google-Smtp-Source: AHgI3IbWEDiZcmaXwozVQBYzn8Yl7xsnfrL2trKd79iPMuv/K0LbvWMGYrraLVIcetrFW4YxB/UWVOm8LNAoZQbwqDhKX+yZkxdC
MIME-Version: 1.0
X-Received: by 2002:a6b:6511:: with SMTP id z17mr651318iob.0.1549258982878;
 Sun, 03 Feb 2019 21:43:02 -0800 (PST)
Date:   Sun, 03 Feb 2019 21:43:02 -0800
In-Reply-To: <00000000000089904d057f1e0ae0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000056f57205810af7d0@google.com>
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

HEAD commit:    9fb20801dab4 net: Fix ip_mc_{dec,inc}_group allocation con..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17530a0f400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=33ad02b9305759c3
dashboard link: https://syzkaller.appspot.com/bug?extid=7078ae989d857fe17988
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148b35f8c00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+7078ae989d857fe17988@syzkaller.appspotmail.com

8021q: adding VLAN 0 to HW filter on device batadv0
device rose0 entered promiscuous mode
IPv6: ADDRCONF(NETDEV_CHANGE): rose0: link becomes ready
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 7801 Comm: udevd Not tainted 5.0.0-rc4+ #44
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:rose_send_frame+0x1a8/0x280 net/rose/rose_link.c:104
Code: c1 ea 03 80 3c 02 00 0f 85 8d 00 00 00 48 b8 00 00 00 00 00 fc ff df  
4c 8b 63 20 49 8d bc 24 58 03 00 00 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75  
7e 49 8b 94 24 58 03 00 00 e9 b8 fe ff ff e8 60 cd
RSP: 0000:ffff8880ae907ae8 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff88809a954500 RCX: ffffffff86360ccb
RDX: 000000000000006b RSI: ffffffff86360dfc RDI: 0000000000000358
RBP: ffff8880ae907b18 R08: ffff888094b50080 R09: ffffed10146ad41d
R10: ffffed10146ad41c R11: ffff8880a356a0e3 R12: 0000000000000000
R13: 0000000000000078 R14: 0000000000000005 R15: ffff8880a886acc0
FS:  00007f75710e57a0(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7570790590 CR3: 000000009fb95000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  <IRQ>
  rose_transmit_clear_request+0x1de/0x2a0 net/rose/rose_link.c:258
  rose_rx_call_request+0x4ea/0x1990 net/rose/af_rose.c:999
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
RIP: 0010:__sanitizer_cov_trace_const_cmp1+0x1/0x20 kernel/kcov.c:174
Code: c3 0f 1f 84 00 00 00 00 00 55 48 89 f2 48 89 fe bf 06 00 00 00 48 89  
e5 48 8b 4d 08 e8 18 ff ff ff 5d c3 66 0f 1f 44 00 00 55 <40> 0f b6 d6 40  
0f b6 f7 bf 01 00 00 00 48 89 e5 48 8b 4d 08 e8 f6
RSP: 0000:ffff8880a806fb90 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
RAX: ffff888094b50080 RBX: ffff8880a806fca8 RCX: ffffffff818a7cde
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff8880a806fcd0 R08: ffff888094b50080 R09: 0000000000000004
R10: ffffed1015d25bc7 R11: ffff8880ae92de3b R12: ffffea000025f980
R13: ffff88809b8a87b8 R14: 0000000000000001 R15: 0000000000000084
  do_fault_around mm/memory.c:3391 [inline]
  do_read_fault mm/memory.c:3425 [inline]
  do_fault mm/memory.c:3556 [inline]
  handle_pte_fault mm/memory.c:3787 [inline]
  __handle_mm_fault+0x3226/0x3f20 mm/memory.c:3911
  handle_mm_fault+0x43f/0xb30 mm/memory.c:3948
  do_user_addr_fault arch/x86/mm/fault.c:1475 [inline]
  __do_page_fault+0x5da/0xd60 arch/x86/mm/fault.c:1541
  do_page_fault+0x71/0x581 arch/x86/mm/fault.c:1572
  page_fault+0x1e/0x30 arch/x86/entry/entry_64.S:1143
RIP: 0033:0x7f7570790590
Code: 00 74 0f f0 ff 0d ac 41 31 00 0f 85 d3 6b 00 00 eb 0c ff 0d 9e 41 31  
00 0f 85 c5 6b 00 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 <8b> 0d 4e 1b 31  
00 85 c9 7e 6c 48 8b 15 97 41 31 00 48 8b 05 78 17
RSP: 002b:00007ffec2e21978 EFLAGS: 00010206
RAX: 00007f7570aa4740 RBX: 00007ffec2e219a0 RCX: 00007f75705162a0
RDX: 00007f7570790590 RSI: 00007f7570512240 RDI: 00007f7570aa26c0
RBP: 00007ffec2e219e0 R08: 0000000000001ce4 R09: 0000000000001ce4
R10: 00007f7570512240 R11: 00007f75710e57a0 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f75710f0040 R15: 0000000000000005
Modules linked in:
---[ end trace 19f243a97b44aa5b ]---
RIP: 0010:rose_send_frame+0x1a8/0x280 net/rose/rose_link.c:104
Code: c1 ea 03 80 3c 02 00 0f 85 8d 00 00 00 48 b8 00 00 00 00 00 fc ff df  
4c 8b 63 20 49 8d bc 24 58 03 00 00 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75  
7e 49 8b 94 24 58 03 00 00 e9 b8 fe ff ff e8 60 cd
RSP: 0000:ffff8880ae907ae8 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff88809a954500 RCX: ffffffff86360ccb
RDX: 000000000000006b RSI: ffffffff86360dfc RDI: 0000000000000358
RBP: ffff8880ae907b18 R08: ffff888094b50080 R09: ffffed10146ad41d
R10: ffffed10146ad41c R11: ffff8880a356a0e3 R12: 0000000000000000
R13: 0000000000000078 R14: 0000000000000005 R15: ffff8880a886acc0
FS:  00007f75710e57a0(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7570790590 CR3: 000000009fb95000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

