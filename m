Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BE3C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C01AE20870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfAVSXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 13:23:07 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:50611 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbfAVSXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 13:23:06 -0500
Received: by mail-io1-f70.google.com with SMTP id p4so19861382iod.17
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 10:23:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=0XWD+33SdNxNHpvf4GEIWOg3IO75dAA1p7KqhnHzhJI=;
        b=RdgaXY7dNxIgzrTV2XpYKdNWcrVsiCizSCt8R9KD4zmYOrQQAShd227pHTxhIPpu63
         N5fYLWtfkM7xq/GDeLGebFKC2KpV12mdIW4xRV5aQc87yga5MmM8tInngwHpMKV9ZhKF
         t7+anXE8vcnJ/bH5EpaP1DykNe1iqB+01ZXPLaXcLjNRsZFF9tzTN5DQ/8S/Bke113VI
         O/Sxl6uXaH3PbDUvLQ2fhG/uo/O4cUHLMP70dBWKG4jKZoMqQULwzNAsKZbw6V1XXsHU
         zdMHc4IN9BqZM5uYPW89hAl5PFB2LsZBnX3rSYDGL7d9dLhtTUTmqx411X5lGwkHpAPn
         89/A==
X-Gm-Message-State: AJcUukd1og7T2JVZPoOROOIAAqyJpZrkBCi/YIIlkecDW0PHINa0C98L
        ufeeL4IFWjU3YilR8Wavoqk0PX3HwX3oCdkauKILdh+BJ2cj
X-Google-Smtp-Source: ALg8bN51SfqOI/E4oiyDhbQCTZnWSQ5BVdbiX/2izMKOpl98LtjHTTGSsJPD1JCMNwVBt4mAQTJLYV1Ql47NE0UgUM830fRvOEBB
MIME-Version: 1.0
X-Received: by 2002:a24:244:: with SMTP id 65mr1411702itu.3.1548181385428;
 Tue, 22 Jan 2019 10:23:05 -0800 (PST)
Date:   Tue, 22 Jan 2019 10:23:05 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000086d87305801011c4@google.com>
Subject: general protection fault in __bfs (2)
From:   syzbot <syzbot+c58fa3b1231d2ea0c4d3@syzkaller.appspotmail.com>
To:     bp@alien8.de, douly.fnst@cn.fujitsu.com, hpa@zytor.com,
        konrad.wilk@oracle.com, len.brown@intel.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        netdev@vger.kernel.org, puwen@hygon.cn, rppt@linux.vnet.ibm.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    133bbb18ab1a virtio-net: per-queue RPS config
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=130be6cf400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8a4dffabfb4e36f9
dashboard link: https://syzkaller.appspot.com/bug?extid=c58fa3b1231d2ea0c4d3
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1244d4b7400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c58fa3b1231d2ea0c4d3@syzkaller.appspotmail.com

Enabling of bearer <udp:syz0> rejected, already enabled
Enabling of bearer <udp:syz0> rejected, already enabled
Enabling of bearer <udp:syz0> rejected, already enabled
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 8646 Comm: syz-executor1 Not tainted 5.0.0-rc2+ #12
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:lock_accessed kernel/locking/lockdep.c:968 [inline]
RIP: 0010:__bfs kernel/locking/lockdep.c:1035 [inline]
RIP: 0010:__bfs+0x2ce/0x7a0 kernel/locking/lockdep.c:989
Code: 49 01 00 00 49 8d 7f 10 4c 89 f8 4c 8b 1d 7a d0 ee 09 48 89 f9 48 2d  
20 47 32 8b 44 8b 15 ca ce 61 09 48 c1 e9 03 48 c1 f8 06 <42> 80 3c 21 00  
0f 85 2c 03 00 00 49 8b 77 10 4c 8d 46 2c 4c 89 c1
RSP: 0018:ffff8880ae707110 EFLAGS: 00010003
RAX: 0000000001d336e3 RBX: ffffed1015ce0e3b RCX: 0000000000000002
RDX: 1ffff11015ce0e37 RSI: 0000000000000001 RDI: 0000000000000010
RBP: ffff8880ae707240 R08: 0000000000000001 R09: 1ffff11015ce0e3b
R10: 000000000000be6c R11: 0000000000001e64 R12: dffffc0000000000
R13: ffffffff8b200110 R14: ffff8880ae707218 R15: 0000000000000000
FS:  00007f29120d4700(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2912091db8 CR3: 000000008a5ae000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  <IRQ>
  __bfs_forwards kernel/locking/lockdep.c:1063 [inline]
  find_usage_forwards kernel/locking/lockdep.c:1363 [inline]
  check_usage_forwards+0x164/0x3e0 kernel/locking/lockdep.c:2575
  mark_lock_irq kernel/locking/lockdep.c:2690 [inline]
  mark_lock+0x519/0x1cd0 kernel/locking/lockdep.c:3062
  mark_irqflags kernel/locking/lockdep.c:2940 [inline]
  __lock_acquire+0x139c/0x4a30 kernel/locking/lockdep.c:3295
  lock_acquire+0x1db/0x570 kernel/locking/lockdep.c:3841
  __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
  _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:144
  spin_lock include/linux/spinlock.h:329 [inline]
  __queue_work+0xbfc/0x1450 kernel/workqueue.c:1414
  delayed_work_timer_fn+0x5d/0x90 kernel/workqueue.c:1500
  call_timer_fn+0x254/0x900 kernel/time/timer.c:1325
  expire_timers kernel/time/timer.c:1358 [inline]
  __run_timers+0x4a2/0xd50 kernel/time/timer.c:1681
  run_timer_softirq+0x52/0xb0 kernel/time/timer.c:1694
  __do_softirq+0x30b/0xb11 kernel/softirq.c:292
  invoke_softirq kernel/softirq.c:373 [inline]
  irq_exit+0x180/0x1d0 kernel/softirq.c:413
  exiting_irq arch/x86/include/asm/apic.h:536 [inline]
  smp_apic_timer_interrupt+0x1b7/0x760 arch/x86/kernel/apic/apic.c:1062
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:807
  </IRQ>
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:766  
[inline]
RIP: 0010:console_unlock+0xd46/0x11e0 kernel/printk/printk.c:2416
Code: 48 c1 e8 03 80 3c 08 00 0f 85 d2 03 00 00 48 83 3d fe 95 2a 08 00 0f  
84 b9 02 00 00 e8 33 14 1a 00 48 8b bd 10 ff ff ff 57 9d <0f> 1f 44 00 00  
e9 5c ff ff ff e8 1b 14 1a 00 48 8b 7d 08 c7 05 7d
RSP: 0018:ffff8880a8c06ed8 EFLAGS: 00000293 ORIG_RAX: ffffffffffffff13
RAX: ffff88809741c3c0 RBX: 0000000000000200 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: ffffffff8167eabd RDI: 0000000000000293
RBP: ffff8880a8c06ff8 R08: 0000000000000006 R09: ffff88809741ccd8
R10: ffff88809741c3c0 R11: 0000000000000000 R12: 0000000000000000
R13: ffffffff849d5d60 R14: ffffffff89f76fd0 R15: 0000000000006801
  vprintk_emit+0x370/0x960 kernel/printk/printk.c:1931
  vprintk_default+0x28/0x30 kernel/printk/printk.c:1958
  vprintk_func+0x7e/0x189 kernel/printk/printk_safe.c:398
  printk+0xba/0xed kernel/printk/printk.c:1991
  tipc_enable_bearer+0x498/0xed0 net/tipc/bearer.c:339
  __tipc_nl_bearer_enable+0x389/0x4b0 net/tipc/bearer.c:899
  tipc_nl_bearer_enable+0x23/0x40 net/tipc/bearer.c:907
  genl_family_rcv_msg+0x80d/0x11a0 net/netlink/genetlink.c:601
  genl_rcv_msg+0xca/0x16c net/netlink/genetlink.c:626
  netlink_rcv_skb+0x17d/0x410 net/netlink/af_netlink.c:2477
  genl_rcv+0x29/0x40 net/netlink/genetlink.c:637
  netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
  netlink_unicast+0x574/0x770 net/netlink/af_netlink.c:1336
  netlink_sendmsg+0xa05/0xf90 net/netlink/af_netlink.c:1917
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xdd/0x130 net/socket.c:631
  ___sys_sendmsg+0x7ec/0x910 net/socket.c:2116
  __sys_sendmsg+0x112/0x270 net/socket.c:2154
  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg net/socket.c:2161 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x458099
Code: 6d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 3b b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f29120d3c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000458099
RDX: 0000000000000004 RSI: 0000000020000000 RDI: 0000000000000008
RBP: 000000000073bfa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f29120d46d4
R13: 00000000004c53b4 R14: 00000000004d8f98 R15: 00000000ffffffff
Modules linked in:
---[ end trace 1d5ecf1214646bac ]---
RIP: 0010:lock_accessed kernel/locking/lockdep.c:968 [inline]
RIP: 0010:__bfs kernel/locking/lockdep.c:1035 [inline]
RIP: 0010:__bfs+0x2ce/0x7a0 kernel/locking/lockdep.c:989
Code: 49 01 00 00 49 8d 7f 10 4c 89 f8 4c 8b 1d 7a d0 ee 09 48 89 f9 48 2d  
20 47 32 8b 44 8b 15 ca ce 61 09 48 c1 e9 03 48 c1 f8 06 <42> 80 3c 21 00  
0f 85 2c 03 00 00 49 8b 77 10 4c 8d 46 2c 4c 89 c1
RSP: 0018:ffff8880ae707110 EFLAGS: 00010003
RAX: 0000000001d336e3 RBX: ffffed1015ce0e3b RCX: 0000000000000002
RDX: 1ffff11015ce0e37 RSI: 0000000000000001 RDI: 0000000000000010
RBP: ffff8880ae707240 R08: 0000000000000001 R09: 1ffff11015ce0e3b
R10: 000000000000be6c R11: 0000000000001e64 R12: dffffc0000000000
R13: ffffffff8b200110 R14: ffff8880ae707218 R15: 0000000000000000
FS:  00007f29120d4700(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2912091db8 CR3: 000000008a5ae000 CR4: 00000000001406e0
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
