Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664E0C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C0C20871
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:35:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12C0C20871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754517AbeGILfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:35:05 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:35216 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754432AbeGILfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:35:03 -0400
Received: by mail-it0-f69.google.com with SMTP id r184-v6so10292083ith.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 04:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=r+k+14oNMYJyiV9Bcju4Xe2q4CpykZ90yLa3w94ztVA=;
        b=XaALpN6wTfIBKW+JmSSpr+h9qJc9mIWA/RwIBe153zw7A9nwY0NcxKseQG9Izqdh33
         PpzgiiF3nHZ8X7DnAfMjsouDUGTdPyz0rOcvr0uOAY2NuOl3mKT1y+JDJU3yyUStKaAv
         MgZjJxd3bJazffxzKEjEYZsq4OuLuB/q7osSMXCh50R3kKN+fr8jg8l+cjuXQuZIln3w
         Edaw9wWej8P0z+C9F1KST8snS+SZ5Wfx6Lzv9iMoGr+d1FNHq2QAUNzUNY1+Qq/YJeq4
         YTcEnMh8wAuOiiOVATxzS23wVPjeSXrXiR1+lzZ8D+LPEFrQpPQZ9O77WUa4Jk/VJ7lD
         DDrA==
X-Gm-Message-State: APt69E1CJxytfQlxI9a+fCCwm+KDkKQZT4AFVwW/rVUc7q8c4+P78/qF
        O+YcUUlBH97+u7kqaqI2C9MLRySaQigX8sP7Zzq0qrYv2326
X-Google-Smtp-Source: AAOMgpdzXHgtu3OhkVlAeqbQ3nG4X9VzB/ZAuuiXdaV4xYZNudqr80Sa8D5UzdzhVfwpt5WNkzHHVTAf722f89s5wCm+XaYo6JZA
MIME-Version: 1.0
X-Received: by 2002:a24:4a07:: with SMTP id k7-v6mr4564656itb.10.1531136103002;
 Mon, 09 Jul 2018 04:35:03 -0700 (PDT)
Date:   Mon, 09 Jul 2018 04:35:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000085c1ce05708f6724@google.com>
Subject: BUG: sleeping function called from invalid context at mm/slab.h:LINE (4)
From:   syzbot <syzbot+9bf843c33f782d73ae7d@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    d00d6d9a339d Add linux-next specific files for 20180709
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10ad4968400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=94fe2b586beccacd
dashboard link: https://syzkaller.appspot.com/bug?extid=9bf843c33f782d73ae7d
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+9bf843c33f782d73ae7d@syzkaller.appspotmail.com

RAX: ffffffffffffffda RBX: cccccccccccccccd RCX: 0000000000410081
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007fc453c22850
RBP: 000000000072bea0 R08: 000000000000000f R09: 0000000000000000
R10: 0000000020000100 R11: 0000000000000293 R12: 0000000000000015
R13: 00000000004c289a R14: 00000000004d41c8 R15: 0000000000000004
BUG: sleeping function called from invalid context at mm/slab.h:421
in_atomic(): 1, irqs_disabled(): 0, pid: 24283, name: syz-executor7
INFO: lockdep is turned off.
CPU: 1 PID: 24283 Comm: syz-executor7 Not tainted 4.18.0-rc3-next-20180709+  
#2
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  ___might_sleep.cold.86+0x11f/0x13a kernel/sched/core.c:6187
  __might_sleep+0x95/0x190 kernel/sched/core.c:6140
  slab_pre_alloc_hook mm/slab.h:421 [inline]
  slab_alloc mm/slab.c:3378 [inline]
  kmem_cache_alloc_trace+0x2bc/0x780 mm/slab.c:3618
  kmalloc include/linux/slab.h:513 [inline]
  kzalloc include/linux/slab.h:707 [inline]
  kobject_uevent_env+0x20f/0x1110 lib/kobject_uevent.c:514
  kobject_uevent+0x1f/0x30 lib/kobject_uevent.c:636
  kobject_cleanup lib/kobject.c:630 [inline]
  kobject_release lib/kobject.c:672 [inline]
  kref_put include/linux/kref.h:70 [inline]
  kobject_put+0x1fb/0x280 lib/kobject.c:689
  put_device+0x20/0x30 drivers/base/core.c:2002
  delete_partition_rcu_cb+0x147/0x1b0 block/partition-generic.c:254
  __rcu_reclaim kernel/rcu/rcu.h:258 [inline]
  rcu_do_batch kernel/rcu/tree.c:2576 [inline]
  invoke_rcu_callbacks kernel/rcu/tree.c:2878 [inline]
  __rcu_process_callbacks kernel/rcu/tree.c:2845 [inline]
  rcu_process_callbacks+0xe01/0x2810 kernel/rcu/tree.c:2862
  __do_softirq+0x2e8/0xb17 kernel/softirq.c:288
  invoke_softirq kernel/softirq.c:368 [inline]
  irq_exit+0x1d1/0x200 kernel/softirq.c:408
  exiting_irq arch/x86/include/asm/apic.h:527 [inline]
  smp_apic_timer_interrupt+0x186/0x730 arch/x86/kernel/apic/apic.c:1052
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:867
  </IRQ>
RIP: 0010:__read_once_size include/linux/compiler.h:188 [inline]
RIP: 0010:check_kcov_mode kernel/kcov.c:69 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x26/0x50 kernel/kcov.c:101
Code: 5d c3 66 90 55 65 48 8b 04 25 40 ee 01 00 65 8b 15 5f 73 85 7e 48 89  
e5 81 e2 00 01 1f 00 48 8b 75 08 75 2b 8b 90 98 12 00 00 <83> fa 02 75 20  
48 8b 88 a0 12 00 00 8b 80 9c 12 00 00 48 8b 11 48
RSP: 0018:ffff8801ca396bb0 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
RAX: ffff8801c5c62240 RBX: ffff8801c9db6f10 RCX: ffffffff81ac0f6f
RDX: 0000000000000000 RSI: ffffffff81ac0f7d RDI: 0000000000000007
RBP: ffff8801ca396bb0 R08: ffff8801c5c62240 R09: fffff94000d02f5e
R10: fffff94000d02f5e R11: ffffea0006817af3 R12: ffffea0006817ac0
R13: 00007fc4545e3000 R14: dffffc0000000000 R15: 0000000000000000
  constant_test_bit arch/x86/include/asm/bitops.h:328 [inline]
  PageCompound include/linux/page-flags.h:156 [inline]
  page_mapcount include/linux/mm.h:613 [inline]
  zap_pte_range mm/memory.c:1340 [inline]
  zap_pmd_range mm/memory.c:1443 [inline]
  zap_pud_range mm/memory.c:1472 [inline]
  zap_p4d_range mm/memory.c:1493 [inline]
  unmap_page_range+0xf7d/0x2220 mm/memory.c:1514
  unmap_single_vma+0x1a0/0x310 mm/memory.c:1559
  unmap_vmas+0x120/0x1f0 mm/memory.c:1589
  exit_mmap+0x2c2/0x5b0 mm/mmap.c:3106
  __mmput kernel/fork.c:974 [inline]
  mmput+0x265/0x620 kernel/fork.c:995
  exit_mm kernel/exit.c:544 [inline]
  do_exit+0xea9/0x2750 kernel/exit.c:856
  do_group_exit+0x177/0x440 kernel/exit.c:972
  get_signal+0x88e/0x1970 kernel/signal.c:2467
  do_signal+0x9c/0x21c0 arch/x86/kernel/signal.c:816
  exit_to_usermode_loop+0x2e0/0x370 arch/x86/entry/common.c:162
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455e29
Code: 38 4c 8b 95 30 fb ff ff 4c 8b 85 20 fb ff ff 49 39 c2 0f 85 b2 f4 ff  
ff 44 8b 8d 28 fb ff ff b8 ff ff ff 7f 44 29 c8 48 98 49 <39> c2 0f 86 00  
f9 ff ff 48 c7 c0 d0 ff ff ff 64 c7 00 4b 00 00 00
RSP: 002b:00007fc453c22ce8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 000000000072bec0 RCX: 0000000000455e29
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000072bec0
RBP: 000000000072bec0 R08: 0000000000000035 R09: 000000000072bea0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff0111086f R14: 00007fc453c239c0 R15: 0000000000000000
netlink: 'syz-executor3': attribute type 10 has an invalid length.
netlink: 'syz-executor3': attribute type 10 has an invalid length.


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
