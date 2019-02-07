Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79D1C169C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 03:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5735218D3
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 03:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfBGDmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 22:42:04 -0500
Received: from mail-it1-f197.google.com ([209.85.166.197]:42313 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbfBGDmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 22:42:04 -0500
Received: by mail-it1-f197.google.com with SMTP id g7so8511938itg.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 19:42:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Vv4pEI+nEv4cmwkhMSg9AV8+ZbB28Q1RMEpsUiZPHx8=;
        b=fW8EXIMovmL9KMB6af2aDSisqZVLSV4/WvDVCC7opP/E1luU1XS1e6WVQ2DTRrY210
         BiDIgO4wKgHRmOUZZfp/r+bYkem256D68bFx/zMFrUH/Q6pbC0Gx7+7oDcfWWcEWDi2b
         xql6AvfqaxT2sAmyZhqipWZ3qcGEjkOhAGlrUQ8d6Lobq86f1xQPwDwWw2vN/xkRqWVc
         5JTf//DETeX+usLImboMMRAYTQ9vHNJ4JTPAOqbDYq7uIe0tK5lb6t16WUGwKYkvD7Dt
         fDOqOiSlTOpASg3S1TEyxzhF0bPssQlzWbMJnMZzmlLi9j86qvm/qbc/YbaueNwUJO90
         4mrA==
X-Gm-Message-State: AHQUAuaDxfSrsWvUUXte+zXK6howu/KIdNCzvn95dxxoGh4o8KSZVP0E
        62O6bABQk+HWAHJZXn12TVtPh0AfaPTrg9TIRpj854V/UBsN
X-Google-Smtp-Source: AHgI3IYotUWSLQ6qa5tnkvDmqEH5LPuYcEqarx9yIrx9Fxl+Kp/6dBHRpc5lSFhO8pdSrwBxY48e/UQzR8TAujqfzr/9pJIjVfp2
MIME-Version: 1.0
X-Received: by 2002:a6b:7a4c:: with SMTP id k12mr348250iop.17.1549510923073;
 Wed, 06 Feb 2019 19:42:03 -0800 (PST)
Date:   Wed, 06 Feb 2019 19:42:03 -0800
In-Reply-To: <00000000000086d87305801011c4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000254002058145a0b5@google.com>
Subject: Re: general protection fault in __bfs (2)
From:   syzbot <syzbot+c58fa3b1231d2ea0c4d3@syzkaller.appspotmail.com>
To:     andy.shevchenko@gmail.com, bp@alien8.de, douly.fnst@cn.fujitsu.com,
        hpa@zytor.com, konrad.wilk@oracle.com, len.brown@intel.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        netdev@vger.kernel.org, puwen@hygon.cn, rppt@linux.vnet.ibm.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    8834f5600cf3 Linux 5.0-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=143fd61f400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f00801d7b7c4fe6
dashboard link: https://syzkaller.appspot.com/bug?extid=c58fa3b1231d2ea0c4d3
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15bab650c00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17a331df400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c58fa3b1231d2ea0c4d3@syzkaller.appspotmail.com

Started in network mode
Own node identity 7f000001, cluster identity 4711
Enabled bearer <udp:syz0>, priority 10
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 7800 Comm: syz-executor309 Not tainted 5.0.0-rc5 #59
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:lock_accessed kernel/locking/lockdep.c:968 [inline]
RIP: 0010:__bfs kernel/locking/lockdep.c:1035 [inline]
RIP: 0010:__bfs+0x18a/0x5a0 kernel/locking/lockdep.c:989
Code: 8b 3f 4d 39 fd 0f 84 77 01 00 00 49 8d 7f 10 4c 89 f8 4c 8b 0d f7 94  
fa 08 48 89 f9 48 2d a0 27 31 8a 48 c1 e9 03 48 c1 f8 06 <42> 80 3c 31 00  
0f 85 db 02 00 00 49 8b 77 10 4c 8d 46 2c 4c 89 c1
RSP: 0018:ffff8880ae807828 EFLAGS: 00010003
RAX: 0000000001d73b61 RBX: ffff8880ae8078f0 RCX: 0000000000000002
RDX: 0000000000000000 RSI: 1ffffffff14aad54 RDI: 0000000000000010
RBP: ffff8880ae807890 R08: 0000000000000001 R09: 0000000000001c9c
R10: ffffed1015d05bcf R11: 0000000000000000 R12: 0000000000000006
R13: ffffffff8a220a50 R14: dffffc0000000000 R15: 0000000000000000
FS:  00007f2ebceb4700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000340 CR3: 000000009ad36000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  <IRQ>
  __bfs_forwards kernel/locking/lockdep.c:1063 [inline]
  find_usage_forwards kernel/locking/lockdep.c:1363 [inline]
  check_usage_forwards+0x119/0x340 kernel/locking/lockdep.c:2575
  mark_lock_irq kernel/locking/lockdep.c:2690 [inline]
  mark_lock+0x427/0x1380 kernel/locking/lockdep.c:3062
  mark_irqflags kernel/locking/lockdep.c:2940 [inline]
  __lock_acquire+0x128f/0x4700 kernel/locking/lockdep.c:3295
  lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:3841
  __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
  _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:144
  spin_lock include/linux/spinlock.h:329 [inline]
  __queue_work+0x9ce/0x1180 kernel/workqueue.c:1434
  delayed_work_timer_fn+0x5d/0x90 kernel/workqueue.c:1520
  call_timer_fn+0x190/0x720 kernel/time/timer.c:1325
  expire_timers kernel/time/timer.c:1358 [inline]
  __run_timers kernel/time/timer.c:1681 [inline]
  __run_timers kernel/time/timer.c:1649 [inline]
  run_timer_softirq+0x44c/0x1700 kernel/time/timer.c:1694
  __do_softirq+0x266/0x95a kernel/softirq.c:292
  invoke_softirq kernel/softirq.c:373 [inline]
  irq_exit+0x180/0x1d0 kernel/softirq.c:413
  exiting_irq arch/x86/include/asm/apic.h:536 [inline]
  smp_apic_timer_interrupt+0x14a/0x570 arch/x86/kernel/apic/apic.c:1062
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:807
  </IRQ>
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:766  
[inline]
RIP: 0010:console_unlock+0xc0d/0x10a0 kernel/printk/printk.c:2416
Code: fc ff df 48 c1 e8 03 80 3c 08 00 0f 85 49 04 00 00 48 83 3d 94 56 38  
07 00 0f 84 af 02 00 00 e8 b9 af 15 00 48 8b 7d 98 57 9d <0f> 1f 44 00 00  
e9 5f ff ff ff e8 a4 af 15 00 48 8b 7d 08 c7 05 56
RSP: 0018:ffff88809accf1b8 EFLAGS: 00000293 ORIG_RAX: ffffffffffffff13
RAX: ffff88808cc40300 RBX: 0000000000000200 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: ffffffff815a2b67 RDI: 0000000000000293
RBP: ffff88809accf248 R08: ffff88808cc40300 R09: ffff88808cc40c18
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffffffff841a1770 R14: ffffffff88f81d70 R15: 0000000000006601
  vprintk_emit+0x280/0x6d0 kernel/printk/printk.c:1931
  vprintk_default+0x28/0x30 kernel/printk/printk.c:1958
  vprintk_func+0x7e/0x189 kernel/printk/printk_safe.c:398
  printk+0xba/0xed kernel/printk/printk.c:1991
  tipc_enable_bearer.cold+0x2d/0xda net/tipc/bearer.c:335
  __tipc_nl_bearer_enable+0x2d1/0x3b0 net/tipc/bearer.c:899
  tipc_nl_bearer_enable+0x23/0x40 net/tipc/bearer.c:907
  genl_family_rcv_msg+0x6e1/0xd90 net/netlink/genetlink.c:601
  genl_rcv_msg+0xca/0x16c net/netlink/genetlink.c:626
  netlink_rcv_skb+0x17a/0x460 net/netlink/af_netlink.c:2477
  genl_rcv+0x29/0x40 net/netlink/genetlink.c:637
  netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
  netlink_unicast+0x536/0x720 net/netlink/af_netlink.c:1336
  netlink_sendmsg+0x8ae/0xd70 net/netlink/af_netlink.c:1917
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xdd/0x130 net/socket.c:631
  ___sys_sendmsg+0x806/0x930 net/socket.c:2116
  __sys_sendmsg+0x105/0x1d0 net/socket.c:2154
  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg net/socket.c:2161 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x44ddd9
Code: e8 5c e6 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 1b c9 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f2ebceb3ce8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000700028 RCX: 000000000044ddd9
RDX: 0000000000000004 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 0000000000700020 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000002 R11: 0000000000000246 R12: 000000000070002c
R13: 000000000080fc2f R14: 00007f2ebceb49c0 R15: 0000000000000000
Modules linked in:
---[ end trace 23d22854ea5c89a7 ]---
RIP: 0010:lock_accessed kernel/locking/lockdep.c:968 [inline]
RIP: 0010:__bfs kernel/locking/lockdep.c:1035 [inline]
RIP: 0010:__bfs+0x18a/0x5a0 kernel/locking/lockdep.c:989
Code: 8b 3f 4d 39 fd 0f 84 77 01 00 00 49 8d 7f 10 4c 89 f8 4c 8b 0d f7 94  
fa 08 48 89 f9 48 2d a0 27 31 8a 48 c1 e9 03 48 c1 f8 06 <42> 80 3c 31 00  
0f 85 db 02 00 00 49 8b 77 10 4c 8d 46 2c 4c 89 c1
RSP: 0018:ffff8880ae807828 EFLAGS: 00010003
RAX: 0000000001d73b61 RBX: ffff8880ae8078f0 RCX: 0000000000000002
RDX: 0000000000000000 RSI: 1ffffffff14aad54 RDI: 0000000000000010
RBP: ffff8880ae807890 R08: 0000000000000001 R09: 0000000000001c9c
R10: ffffed1015d05bcf R11: 0000000000000000 R12: 0000000000000006
R13: ffffffff8a220a50 R14: dffffc0000000000 R15: 0000000000000000
FS:  00007f2ebceb4700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000340 CR3: 000000009ad36000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

