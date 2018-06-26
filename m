Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D378DC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 04:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78019264F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 04:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvAiu9F/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78019264F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751186AbeFZEl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 00:41:57 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:39891 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750972AbeFZElz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 00:41:55 -0400
Received: by mail-pg0-f66.google.com with SMTP id n2-v6so3633869pgq.6;
        Mon, 25 Jun 2018 21:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rrLz9SXX8D3Im2LUrAySQBIyfgTZMNl9glrxgYUJhtA=;
        b=cvAiu9F/24JUfIa7LOWjwB28VILxOybixqlrte/sBuWtsZ3yA0IZdQqRDVOeNEkiuY
         AEe0wTx8PR9MDuWIDwCAQD0UI08qUs2mPhj1QGm4hjc53aPIzfnMixa6nyuj66tq8IDf
         npWhmcu4jUkgU65H3Lt6YO2WFvHC++lQTqzgePjrOkxeNr/PUgx1IxBLCH0pblaLKJcO
         F6y2iCgnoEip7YrFjloPwyRsZaH+AXFRRNE8en0sUp5iG4PeS1N55GoeveMgyPeJd6OT
         wySkSa1KnPzFSJt/xrTWPFdQQ3adrbuetYHsmy3PndCxweEe8viW96gqsMRLa1gFPJhS
         86kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rrLz9SXX8D3Im2LUrAySQBIyfgTZMNl9glrxgYUJhtA=;
        b=AzfXbGehzJ+XVyTNz8AHzdvr98OCTB2ijaTBza3Zqev0D/Q1th0A/m37xQ05JvLbql
         bj+iJJJJVUEXmRO6SymKfZI+HW6MlBnfZyfBqfgtE+3BzBWNMel3kXtUz2lWixv6iH4p
         wZxcmo4cu3rjsmuqTHA6zy9FGQg01noyBxmot6LQSaMY3Bo7hfLXl8tEkXETJXDRdaLx
         +amUePJzg7fJlOuJPZwQaasiLPwPcMWVvYLxHU4qLd4fSOFbGuiOrzfTOvFbNHg8lr6B
         Y8w1goJk7w2L/+cKrfdMDoBrJhzmtO5zpkUHMNOD3tZZ+6j2CmK/trPtYHHHTqN4mrnZ
         I+HQ==
X-Gm-Message-State: APt69E0GYnctAaPRAu9k5zP911ARxdqi3ontzY4Cy2Q5nBCZSM1fnvhX
        z5YewktUTDD2EQC3cSFJ7+w=
X-Google-Smtp-Source: ADUXVKJZfxik/oJ/feyrQ7Vk/jmhy1rzVuuacCsirHNX7kusWCiMon3PwWqonC5iMsDno/uWbi9AzA==
X-Received: by 2002:a65:504c:: with SMTP id k12-v6mr4750560pgo.435.1529988114707;
        Mon, 25 Jun 2018 21:41:54 -0700 (PDT)
Received: from localhost.localdomain ([175.223.48.122])
        by smtp.gmail.com with ESMTPSA id s22-v6sm692551pgs.34.2018.06.25.21.41.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 21:41:53 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Samuel Ortiz <sameo@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        syzkaller-bugs@googlegroups.com, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot <syzbot+d29d18215e477cfbfbdd@syzkaller.appspotmail.com>,
        sergey.senozhatsky@gmail.com
Subject: [PATCH] NFC: llcp: fix nfc_llcp_send_ui_frame() lockup
Date:   Tue, 26 Jun 2018 13:41:19 +0900
Message-Id: <20180626044119.30118-1-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot reported the following nfc_llcp_send_ui_frame() lockup:

The kernel is CONFIG_PREEMPT_VOLUNTARY=y, llcp_sock_sendmsg() stuck
in an infinite error reporting loop, because the system is low memory
and MSG_DONTWAIT nfc_alloc_send_skb() allocations fail:

        do {
        ...
                pdu = nfc_alloc_send_skb(sock->dev, &sock->sk, MSG_DONTWAIT,
                                         frag_len + LLCP_HEADER_SIZE, &err);
                if (pdu == NULL) {
                        pr_err("Could not allocate PDU\n");
                        continue;
                }
        ...
        } while (remaining_len > 0);

nfc_llcp_send_ui_frame() spent enough time (94+ sec) trying to
allocate PDU, which resulted in RCU stall due to PREEMPT_VOLUNTARY:

 llcp: nfc_llcp_send_ui_frame: Could not allocate PDU
 llcp: nfc_llcp_send_ui_frame: Could not allocate PDU
...
 llcp: nfc_llcp_send_ui_frame: Could not allocate PDU
 llcp: nfc_llcp_send_ui_frame: Could not allocate PDU
 INFO: rcu_sched self-detected stall on CPU
         1-....: (20918 ticks this GP) idle=55a/1/4611686018427387906
 softirq=11347/11347 fqs=20240
          (t=125005 jiffies g=5572 c=5571 q=149)
 NMI backtrace for cpu 1
 CPU: 1 PID: 4811 Comm: syz-executor0 Not tainted 4.18.0-rc1+ #115
 Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google
 01/01/2011
 Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  nmi_cpu_backtrace.cold.4+0x19/0xce lib/nmi_backtrace.c:103
  nmi_trigger_cpumask_backtrace+0x151/0x192 lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_single_cpu_backtrace include/linux/nmi.h:156 [inline]
  rcu_dump_cpu_stacks+0x175/0x1c2 kernel/rcu/tree.c:1336
  print_cpu_stall kernel/rcu/tree.c:1485 [inline]
  check_cpu_stall.isra.60.cold.78+0x36c/0x5a6 kernel/rcu/tree.c:1553
  __rcu_pending kernel/rcu/tree.c:3244 [inline]
  rcu_pending kernel/rcu/tree.c:3291 [inline]
  rcu_check_callbacks+0x23f/0xcd0 kernel/rcu/tree.c:2646
  update_process_times+0x2d/0x70 kernel/time/timer.c:1636
  tick_sched_handle+0x9f/0x180 kernel/time/tick-sched.c:164
  tick_sched_timer+0x45/0x130 kernel/time/tick-sched.c:1274
  __run_hrtimer kernel/time/hrtimer.c:1398 [inline]
  __hrtimer_run_queues+0x3eb/0x10c0 kernel/time/hrtimer.c:1460
  hrtimer_interrupt+0x2f3/0x750 kernel/time/hrtimer.c:1518
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1025 [inline]
  smp_apic_timer_interrupt+0x165/0x730 arch/x86/kernel/apic/apic.c:1050
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:863
  </IRQ>
 RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:783 [inline]
 RIP: 0010:console_unlock+0xc84/0x10b0 kernel/printk/printk.c:2397
 Code: c1 e8 03 42 80 3c 38 00 0f 85 bd 03 00 00 48 83 3d 38 f7 8e 07 00 0f 84
 69 02 00 00 e8 45 56 19 00 48 8b bd b0 fe ff ff 57 9d <0f> 1f 44 00 00 e9 96
 f5 ff ff e8 2d 56 19 00 48 8b 7d 08 e8 94 cf
 RSP: 0018:ffff8801aab0f358 EFLAGS: 00000293 ORIG_RAX: ffffffffffffff13
 RAX: ffff8801aa2802c0 RBX: 0000000000000200 RCX: 1ffff10035450163
 RDX: 0000000000000000 RSI: ffffffff8162b8fb RDI: 0000000000000293
 RBP: ffff8801aab0f4c0 R08: ffff8801aa280af8 R09: 0000000000000006
 R10: ffff8801aa2802c0 R11: 0000000000000000 R12: 0000000000000000
 R13: ffffffff84ea9880 R14: 0000000000000001 R15: dffffc0000000000
  vprintk_emit+0x6c6/0xdf0 kernel/printk/printk.c:1907
  vprintk_default+0x28/0x30 kernel/printk/printk.c:1948
  vprintk_func+0x7a/0xe7 kernel/printk/printk_safe.c:382
  printk+0xa7/0xcf kernel/printk/printk.c:1981
  nfc_llcp_send_ui_frame.cold.9+0x18/0x1f net/nfc/llcp_commands.c:758
  llcp_sock_sendmsg+0x278/0x350 net/nfc/llcp_sock.c:786
  sock_sendmsg_nosec net/socket.c:645 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:655
  ___sys_sendmsg+0x51d/0x930 net/socket.c:2161
  __sys_sendmmsg+0x240/0x6f0 net/socket.c:2256
  __do_sys_sendmmsg net/socket.c:2285 [inline]
  __se_sys_sendmmsg net/socket.c:2282 [inline]
  __x64_sys_sendmmsg+0x9d/0x100 net/socket.c:2282
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Address the issues by rate limiting nfc_alloc_send_skb() allocation
error, to avoid logbuf pollution, and do cond_resched() before llcp
attempts to allocate PDU again.

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Reported-by: syzbot+d29d18215e477cfbfbdd@syzkaller.appspotmail.com
---
 net/nfc/llcp_commands.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/nfc/llcp_commands.c b/net/nfc/llcp_commands.c
index 2ceefa183cee..e19fadaa9022 100644
--- a/net/nfc/llcp_commands.c
+++ b/net/nfc/llcp_commands.c
@@ -20,6 +20,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/sched.h>
 #include <linux/nfc.h>
 
 #include <net/nfc/nfc.h>
@@ -755,7 +756,8 @@ int nfc_llcp_send_ui_frame(struct nfc_llcp_sock *sock, u8 ssap, u8 dsap,
 		pdu = nfc_alloc_send_skb(sock->dev, &sock->sk, MSG_DONTWAIT,
 					 frag_len + LLCP_HEADER_SIZE, &err);
 		if (pdu == NULL) {
-			pr_err("Could not allocate PDU\n");
+			pr_err_ratelimited("Could not allocate PDU\n");
+			cond_resched();
 			continue;
 		}
 
-- 
2.18.0

