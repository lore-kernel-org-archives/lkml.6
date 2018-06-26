Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E660C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 01:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D24222640A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 01:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtU4QkWY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D24222640A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965158AbeFZBtb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 21:49:31 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:46092 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965002AbeFZBt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 21:49:29 -0400
Received: by mail-pf0-f196.google.com with SMTP id q1-v6so7301112pff.13;
        Mon, 25 Jun 2018 18:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iGKqPKB6im3xy+3P6nu3RgezFzumPNkBnVYLlHVkQhM=;
        b=AtU4QkWYxz5JMhyFDfThMzhxylc6L5NZOWYnLsJS1bHjOUDb3rRBLSXLAUQkYUU7oN
         b+1urFQqkrjj+yC67fPZ9w0lsqIudlWgeoDm5r+j4NDV+NQ4/QxLih0dErO8CtTa12E7
         wvKMD36R8/1LBXLOalvO6zndxZSjfnzAIlQkeOFQhRxLj30EsmmZE+YVL+zA0WQVDq3T
         hrk+14vzvo+iy3AnfHw8okRMbEL5Vdfg3uEzLQ4Gp3wVSNEfcLAkKzDmdLwp8b4bDb7l
         7MaSH4Ysqt2HgfFDIp8X4/ARooPgpbR7Pvf7jIIcPBtqtANfDDpF3PISpsY6m5uIKKAf
         cc3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iGKqPKB6im3xy+3P6nu3RgezFzumPNkBnVYLlHVkQhM=;
        b=S0VFMSO6hnkh/ldJ/UjrjS8IYIDLYkzEFs9I1wCa5W+URl2K2dCpqnk83X/RfAMlhw
         eRsBSbt/riwozCOpyIXOblXueAztEQrbS2lfcUsu5TqCs1Ht1Acg+Qg7t2IvEfDSTQnp
         E+Zrmx8rjlkZ4bZaB9wUwGtAMR1cNXnghDiUPlJXFWvLGTn/ARa2cJBJHjGpDquhwPE/
         VNO/JRUUDpXwuKpUs6/YaYFnnRnerFpu4ZJ6QZlk4k0S0DP6P9IY5ouDme8T7QUnweuy
         efOsGoMoAervTR14X7veyF82s951AG+AUl2LqxTb8xNBR1D0CWyFLCt082fne2CWsqTy
         0bKg==
X-Gm-Message-State: APt69E28P5PB9Kwg0m6gV53NZp/R3EZGz2YDtIWFEC0jxlT2WmqoHkgC
        sGvUeCVR7tqQq9qcJrt/lqQ=
X-Google-Smtp-Source: ADUXVKJmxVhRqQG4JZYSmc3rOVwKcD9qmud8vXHquBFI6xXDUcRL9mCevjnm7j6FU632DOGH2LzaKw==
X-Received: by 2002:a63:3c4a:: with SMTP id i10-v6mr12461852pgn.415.1529977768468;
        Mon, 25 Jun 2018 18:49:28 -0700 (PDT)
Received: from localhost ([175.223.48.122])
        by smtp.gmail.com with ESMTPSA id v15-v6sm366456pff.120.2018.06.25.18.49.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 18:49:27 -0700 (PDT)
Date:   Tue, 26 Jun 2018 10:49:24 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     syzbot <syzbot+d29d18215e477cfbfbdd@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, pmladek@suse.com,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        syzkaller-bugs@googlegroups.com,
        Samuel Ortiz <sameo@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: INFO: rcu detected stall in vprintk_emit
Message-ID: <20180626014924.GB11229@jagdpanzerIV>
References: <000000000000720530056f7f9b63@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000720530056f7f9b63@google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/25/18 16:19), syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    77072ca59fdd Merge tag 'for-linus-20180623' of git://git.k..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=169c7c04400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=befbcd7305e41bb0
> dashboard link: https://syzkaller.appspot.com/bug?extid=d29d18215e477cfbfbdd
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=1585147f800000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+d29d18215e477cfbfbdd@syzkaller.appspotmail.com
> 
> llcp: nfc_llcp_send_ui_frame: Could not allocate PDU
> llcp: nfc_llcp_send_ui_frame: Could not allocate PDU
> llcp: nfc_llcp_send_ui_frame: Could not allocate PDU
> llcp: nfc_llcp_send_ui_frame: Could not allocate PDU
> llcp: nfc_llcp_send_ui_frame: Could not allocate PDU

Hi,

Thanks for the report.

I'll Cc networking people on this.

I've a strong feeling that we saw it before. The kernel is
CONFIG_PREEMPT_VOLUNTARY=y, llcp_sock_sendmsg() stuck in a error
reporting loop:

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

[ 1004.674843] llcp: nfc_llcp_send_ui_frame: Could not allocate PDU
[ 1004.681035] llcp: nfc_llcp_send_ui_frame: Could not allocate PDU
...
[ 1098.508526] llcp: nfc_llcp_send_ui_frame: Could not allocate PDU
[ 1098.514698] llcp: nfc_llcp_send_ui_frame: Could not allocate PDU
[ 1098.520844] INFO: rcu_sched self-detected stall on CPU

94 seconds worth of heavy printing, no preemption:

> INFO: rcu_sched self-detected stall on CPU
> 	1-....: (20918 ticks this GP) idle=55a/1/4611686018427387906
> softirq=11347/11347 fqs=20240
> 	 (t=125005 jiffies g=5572 c=5571 q=149)
> NMI backtrace for cpu 1
> CPU: 1 PID: 4811 Comm: syz-executor0 Not tainted 4.18.0-rc1+ #115
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
>  nmi_cpu_backtrace.cold.4+0x19/0xce lib/nmi_backtrace.c:103
>  nmi_trigger_cpumask_backtrace+0x151/0x192 lib/nmi_backtrace.c:62
>  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
>  trigger_single_cpu_backtrace include/linux/nmi.h:156 [inline]
>  rcu_dump_cpu_stacks+0x175/0x1c2 kernel/rcu/tree.c:1336
>  print_cpu_stall kernel/rcu/tree.c:1485 [inline]
>  check_cpu_stall.isra.60.cold.78+0x36c/0x5a6 kernel/rcu/tree.c:1553
>  __rcu_pending kernel/rcu/tree.c:3244 [inline]
>  rcu_pending kernel/rcu/tree.c:3291 [inline]
>  rcu_check_callbacks+0x23f/0xcd0 kernel/rcu/tree.c:2646
>  update_process_times+0x2d/0x70 kernel/time/timer.c:1636
>  tick_sched_handle+0x9f/0x180 kernel/time/tick-sched.c:164
>  tick_sched_timer+0x45/0x130 kernel/time/tick-sched.c:1274
>  __run_hrtimer kernel/time/hrtimer.c:1398 [inline]
>  __hrtimer_run_queues+0x3eb/0x10c0 kernel/time/hrtimer.c:1460
>  hrtimer_interrupt+0x2f3/0x750 kernel/time/hrtimer.c:1518
>  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1025 [inline]
>  smp_apic_timer_interrupt+0x165/0x730 arch/x86/kernel/apic/apic.c:1050
>  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:863
>  </IRQ>
> RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:783
> [inline]
> RIP: 0010:console_unlock+0xc84/0x10b0 kernel/printk/printk.c:2397
> Code: c1 e8 03 42 80 3c 38 00 0f 85 bd 03 00 00 48 83 3d 38 f7 8e 07 00 0f
> 84 69 02 00 00 e8 45 56 19 00 48 8b bd b0 fe ff ff 57 9d <0f> 1f 44 00 00 e9
> 96 f5 ff ff e8 2d 56 19 00 48 8b 7d 08 e8 94 cf
> RSP: 0018:ffff8801aab0f358 EFLAGS: 00000293 ORIG_RAX: ffffffffffffff13
> RAX: ffff8801aa2802c0 RBX: 0000000000000200 RCX: 1ffff10035450163
> RDX: 0000000000000000 RSI: ffffffff8162b8fb RDI: 0000000000000293
> RBP: ffff8801aab0f4c0 R08: ffff8801aa280af8 R09: 0000000000000006
> R10: ffff8801aa2802c0 R11: 0000000000000000 R12: 0000000000000000
> R13: ffffffff84ea9880 R14: 0000000000000001 R15: dffffc0000000000
>  vprintk_emit+0x6c6/0xdf0 kernel/printk/printk.c:1907
>  vprintk_default+0x28/0x30 kernel/printk/printk.c:1948
>  vprintk_func+0x7a/0xe7 kernel/printk/printk_safe.c:382
>  printk+0xa7/0xcf kernel/printk/printk.c:1981
>  nfc_llcp_send_ui_frame.cold.9+0x18/0x1f net/nfc/llcp_commands.c:758
>  llcp_sock_sendmsg+0x278/0x350 net/nfc/llcp_sock.c:786
>  sock_sendmsg_nosec net/socket.c:645 [inline]
>  sock_sendmsg+0xd5/0x120 net/socket.c:655
>  ___sys_sendmsg+0x51d/0x930 net/socket.c:2161
>  __sys_sendmmsg+0x240/0x6f0 net/socket.c:2256
>  __do_sys_sendmmsg net/socket.c:2285 [inline]
>  __se_sys_sendmmsg net/socket.c:2282 [inline]
>  __x64_sys_sendmmsg+0x9d/0x100 net/socket.c:2282
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe


So we can try switching to ratelimited error reporting
[that would be option A]:

---

diff --git a/net/nfc/llcp_commands.c b/net/nfc/llcp_commands.c
index 2ceefa183cee..2f3becb709b8 100644
--- a/net/nfc/llcp_commands.c
+++ b/net/nfc/llcp_commands.c
@@ -755,7 +755,7 @@ int nfc_llcp_send_ui_frame(struct nfc_llcp_sock *sock, u8 ssap, u8 dsap,
 		pdu = nfc_alloc_send_skb(sock->dev, &sock->sk, MSG_DONTWAIT,
 					 frag_len + LLCP_HEADER_SIZE, &err);
 		if (pdu == NULL) {
-			pr_err("Could not allocate PDU\n");
+			pr_err_ratelimited("Could not allocate PDU\n");
 			continue;
 		}
 
---


Or ratelimited error reporting and cond_resched()
[that would be option B]:

---

diff --git a/net/nfc/llcp_commands.c b/net/nfc/llcp_commands.c
index 2ceefa183cee..61741db4c4e6 100644
--- a/net/nfc/llcp_commands.c
+++ b/net/nfc/llcp_commands.c
@@ -755,7 +755,8 @@ int nfc_llcp_send_ui_frame(struct nfc_llcp_sock *sock, u8 ssap, u8 dsap,
 		pdu = nfc_alloc_send_skb(sock->dev, &sock->sk, MSG_DONTWAIT,
 					 frag_len + LLCP_HEADER_SIZE, &err);
 		if (pdu == NULL) {
-			pr_err("Could not allocate PDU\n");
+			pr_err_ratelimited("Could not allocate PDU\n");
+			cond_resched();
 			continue;
 		}
 
---

	-ss
