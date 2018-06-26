Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34CDC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 05:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B2B82650A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 05:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S7txW7xt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B2B82650A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751576AbeFZFIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 01:08:23 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:43089 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751121AbeFZFIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 01:08:20 -0400
Received: by mail-pl0-f65.google.com with SMTP id c41-v6so7926444plj.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 22:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=I2fo/bEBb94t4oxxdXXxR4Kr3DNBAV0hMBWdYiTCaPs=;
        b=S7txW7xtKhBtrp9/aqMzs/nOBP3OwkKeJvMYA2bpZP6fJwf4Ly9SCgxrPZCpM9acP8
         kexCC0+E1x1XKbg8LuDwEZ2XNx4F+zaaZ7+fwoTaI1iresmaLWNrtBhdWhIyRdRkKee7
         H27V40rSeMQCFZqo9zb6Gc7liGkqVSLKlX3gytXPu3v45/xG/Jw9Hc4mnkmjpDUjth1r
         9+COR9lemQhyYf6fqw9/rCBSgrTny2INq+RtfN/RXqN/eu4KqghOU4aFfanZRNyxeagw
         aFFWwq3eiylDdxAitJ8ms2hBFtMZIRPGra/B20v+AhIUMbf5Wxq9P/W2GIAHmEPOT2MZ
         cjrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=I2fo/bEBb94t4oxxdXXxR4Kr3DNBAV0hMBWdYiTCaPs=;
        b=aNPm2McjxEXYdrGqt2ZTzPxYVPVYORFZufzIJrUb28w5CGLQJVfQbzuAWvZ1oeBDcv
         Cpf4EFQKDBa0VggFcJDZmAVARsngGiUtImJqTcfON9vbAyhV4MGgszhbH/X8Ur04sqzb
         4Kle0ttOo/5LIDREFo4aeRSqZlpQcMF2y9AUB/IoMqauScPdsU0memkitNbIc6EKtmbm
         OzwrV8T84jSYoiRmH3bbQyEvlUo1MDF5vZAqAQe4EFLx1an4txOuf+ELBNNr2IC1ilx7
         wi2njC5cgwj2x4DhlWEfpWW9hLKnv+Hd+jPMp940SHdBosdOBTKuNJv/FvVLyFXUWKeZ
         rq+g==
X-Gm-Message-State: APt69E37Ok2lc49brxVZ1M+dpMXhljgzWWJ12CM3K1SAr9lO2EhOg452
        xZy1VPj+B12b1r6xT/jIdtnF50bn/y3EA62nJllm6A==
X-Google-Smtp-Source: ADUXVKJH59wQQNWN8NoUqBlScnrnnmVJlLVWQQkfQ16KMDhKAxNRcAS+rlZt/Ex8eNMRQwUYS2yNrzYQYSiUbPiBuoo=
X-Received: by 2002:a17:902:5a4d:: with SMTP id f13-v6mr9997855plm.85.1529989699942;
 Mon, 25 Jun 2018 22:08:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Mon, 25 Jun 2018 22:07:59
 -0700 (PDT)
In-Reply-To: <20180626044119.30118-1-sergey.senozhatsky@gmail.com>
References: <20180626044119.30118-1-sergey.senozhatsky@gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 26 Jun 2018 07:07:59 +0200
Message-ID: <CACT4Y+ZvLqzEwXgdB25MrmAS_j2_HsS8NFaJaMojzMV3prXypg@mail.gmail.com>
Subject: Re: [PATCH] NFC: llcp: fix nfc_llcp_send_ui_frame() lockup
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Samuel Ortiz <sameo@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-wireless@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+d29d18215e477cfbfbdd@syzkaller.appspotmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 6:41 AM, Sergey Senozhatsky
<sergey.senozhatsky.work@gmail.com> wrote:
> syzbot reported the following nfc_llcp_send_ui_frame() lockup:
>
> The kernel is CONFIG_PREEMPT_VOLUNTARY=y, llcp_sock_sendmsg() stuck
> in an infinite error reporting loop, because the system is low memory
> and MSG_DONTWAIT nfc_alloc_send_skb() allocations fail:
>
>         do {
>         ...
>                 pdu = nfc_alloc_send_skb(sock->dev, &sock->sk, MSG_DONTWAIT,
>                                          frag_len + LLCP_HEADER_SIZE, &err);
>                 if (pdu == NULL) {
>                         pr_err("Could not allocate PDU\n");
>                         continue;
>                 }
>         ...
>         } while (remaining_len > 0);
>
> nfc_llcp_send_ui_frame() spent enough time (94+ sec) trying to
> allocate PDU, which resulted in RCU stall due to PREEMPT_VOLUNTARY:
>
>  llcp: nfc_llcp_send_ui_frame: Could not allocate PDU
>  llcp: nfc_llcp_send_ui_frame: Could not allocate PDU
> ...
>  llcp: nfc_llcp_send_ui_frame: Could not allocate PDU
>  llcp: nfc_llcp_send_ui_frame: Could not allocate PDU
>  INFO: rcu_sched self-detected stall on CPU
>          1-....: (20918 ticks this GP) idle=55a/1/4611686018427387906
>  softirq=11347/11347 fqs=20240
>           (t=125005 jiffies g=5572 c=5571 q=149)
>  NMI backtrace for cpu 1
>  CPU: 1 PID: 4811 Comm: syz-executor0 Not tainted 4.18.0-rc1+ #115
>  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google
>  01/01/2011
>  Call Trace:
>   <IRQ>
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
>   nmi_cpu_backtrace.cold.4+0x19/0xce lib/nmi_backtrace.c:103
>   nmi_trigger_cpumask_backtrace+0x151/0x192 lib/nmi_backtrace.c:62
>   arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
>   trigger_single_cpu_backtrace include/linux/nmi.h:156 [inline]
>   rcu_dump_cpu_stacks+0x175/0x1c2 kernel/rcu/tree.c:1336
>   print_cpu_stall kernel/rcu/tree.c:1485 [inline]
>   check_cpu_stall.isra.60.cold.78+0x36c/0x5a6 kernel/rcu/tree.c:1553
>   __rcu_pending kernel/rcu/tree.c:3244 [inline]
>   rcu_pending kernel/rcu/tree.c:3291 [inline]
>   rcu_check_callbacks+0x23f/0xcd0 kernel/rcu/tree.c:2646
>   update_process_times+0x2d/0x70 kernel/time/timer.c:1636
>   tick_sched_handle+0x9f/0x180 kernel/time/tick-sched.c:164
>   tick_sched_timer+0x45/0x130 kernel/time/tick-sched.c:1274
>   __run_hrtimer kernel/time/hrtimer.c:1398 [inline]
>   __hrtimer_run_queues+0x3eb/0x10c0 kernel/time/hrtimer.c:1460
>   hrtimer_interrupt+0x2f3/0x750 kernel/time/hrtimer.c:1518
>   local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1025 [inline]
>   smp_apic_timer_interrupt+0x165/0x730 arch/x86/kernel/apic/apic.c:1050
>   apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:863
>   </IRQ>
>  RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:783 [inline]
>  RIP: 0010:console_unlock+0xc84/0x10b0 kernel/printk/printk.c:2397
>  Code: c1 e8 03 42 80 3c 38 00 0f 85 bd 03 00 00 48 83 3d 38 f7 8e 07 00 0f 84
>  69 02 00 00 e8 45 56 19 00 48 8b bd b0 fe ff ff 57 9d <0f> 1f 44 00 00 e9 96
>  f5 ff ff e8 2d 56 19 00 48 8b 7d 08 e8 94 cf
>  RSP: 0018:ffff8801aab0f358 EFLAGS: 00000293 ORIG_RAX: ffffffffffffff13
>  RAX: ffff8801aa2802c0 RBX: 0000000000000200 RCX: 1ffff10035450163
>  RDX: 0000000000000000 RSI: ffffffff8162b8fb RDI: 0000000000000293
>  RBP: ffff8801aab0f4c0 R08: ffff8801aa280af8 R09: 0000000000000006
>  R10: ffff8801aa2802c0 R11: 0000000000000000 R12: 0000000000000000
>  R13: ffffffff84ea9880 R14: 0000000000000001 R15: dffffc0000000000
>   vprintk_emit+0x6c6/0xdf0 kernel/printk/printk.c:1907
>   vprintk_default+0x28/0x30 kernel/printk/printk.c:1948
>   vprintk_func+0x7a/0xe7 kernel/printk/printk_safe.c:382
>   printk+0xa7/0xcf kernel/printk/printk.c:1981
>   nfc_llcp_send_ui_frame.cold.9+0x18/0x1f net/nfc/llcp_commands.c:758
>   llcp_sock_sendmsg+0x278/0x350 net/nfc/llcp_sock.c:786
>   sock_sendmsg_nosec net/socket.c:645 [inline]
>   sock_sendmsg+0xd5/0x120 net/socket.c:655
>   ___sys_sendmsg+0x51d/0x930 net/socket.c:2161
>   __sys_sendmmsg+0x240/0x6f0 net/socket.c:2256
>   __do_sys_sendmmsg net/socket.c:2285 [inline]
>   __se_sys_sendmmsg net/socket.c:2282 [inline]
>   __x64_sys_sendmmsg+0x9d/0x100 net/socket.c:2282
>   do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> Address the issues by rate limiting nfc_alloc_send_skb() allocation
> error, to avoid logbuf pollution, and do cond_resched() before llcp
> attempts to allocate PDU again.
>
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Reported-by: syzbot+d29d18215e477cfbfbdd@syzkaller.appspotmail.com
> ---
>  net/nfc/llcp_commands.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/net/nfc/llcp_commands.c b/net/nfc/llcp_commands.c
> index 2ceefa183cee..e19fadaa9022 100644
> --- a/net/nfc/llcp_commands.c
> +++ b/net/nfc/llcp_commands.c
> @@ -20,6 +20,7 @@
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/sched.h>
>  #include <linux/nfc.h>
>
>  #include <net/nfc/nfc.h>
> @@ -755,7 +756,8 @@ int nfc_llcp_send_ui_frame(struct nfc_llcp_sock *sock, u8 ssap, u8 dsap,
>                 pdu = nfc_alloc_send_skb(sock->dev, &sock->sk, MSG_DONTWAIT,
>                                          frag_len + LLCP_HEADER_SIZE, &err);
>                 if (pdu == NULL) {
> -                       pr_err("Could not allocate PDU\n");
> +                       pr_err_ratelimited("Could not allocate PDU\n");
> +                       cond_resched();
>                         continue;
>                 }


But this thread is still in an infinite (unkillable?) loop? If yes, we
are waiting for the next syzbot report ;)

I suspect this is not OOM. This is probably some persistent
logical condition that makes the allocation function fail, either we
ask for too much, or socket in some bad state. Potentially this is
even triggerable remotely because there are some remove variables
involved in size calculation.
