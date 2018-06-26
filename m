Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DACFC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 04:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1577264DC
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 04:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EsbNoMjj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1577264DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751253AbeFZE5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 00:57:13 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34334 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751145AbeFZE5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 00:57:10 -0400
Received: by mail-pf0-f194.google.com with SMTP id g3-v6so2769343pfi.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 21:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HMHtvh++RONSAfE3RXnJIzL4QQEwiXL2ShNod+OIjCA=;
        b=EsbNoMjjBRV5DcoHHu/u6hAw/HHlcHkz1tvh2MY609LSOZI4n2krIXJLFgaO+Bepys
         /e8Bb5DoJSKoi3cWDyxqpZkxZquIGuFyRFRGltv5RjS4u/XwlytXXFiCnJIWXjAjcvJq
         5MhSurUMVYQQZEMxtn2tBuoJlGp46ie3CAJJoKZaK/Pfa7OAVgIZb/+vWeZNr30JIW4K
         Df89SsplOXWfmkryWZ34BvMJkUwX1tg/hBJahg+7MAJyqwGgg0IRCm8nhjnE6yAVfUE5
         NJrZYZRn/8hdOQ4+puXAS7Ha+JFBNIw9fA32rbXjgwZAmOQlkpb+JNiHMj+OMIDA8O4/
         HmbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HMHtvh++RONSAfE3RXnJIzL4QQEwiXL2ShNod+OIjCA=;
        b=LUUurpOXTS12KxOTXH7xTh5QUdPMOMngZmkTYfQpyPAmwA1uXilrX8FRPmdzdOBGfV
         IAvW5b0d3m++Lefauu9lV7Tps5U9xXb20mQ1EgEh+9/5Q8ctG5xaOVpLVMEmdXo0NqQw
         8RJTW+qTEyWQlTeQiow2zPr/7cHY6Q67IwMYfgOil8fMcGOpCNLhumPEgI1o9bOOMv3w
         J1DwL5hg0NFTks4aaAll9N/aF+3Ks98VlqUmctpWt4M0RkOGENlktC0p413RyVSyE654
         4X7iVh/I3PfLohifixr20AvSOy49+hWq0qipS79oPNcLfQqM1gn+CBJ3m0IoW5jVgmrw
         FR0A==
X-Gm-Message-State: APt69E3VQwo97Vsf4xpTwgK3YVteIculWz7CiUgUq8foSIGuZOjB1Boy
        MRdrlw5rZUWqMamjXogJtDUZqux1SkyIaYxcIBM3Zw==
X-Google-Smtp-Source: ADUXVKJvHJ/OFSCHlkFoQCOHBIL2/nL1K/tkUitMu9PoQX7xFOaFNFOSpgu2M++BDKEc/QkXOwy19UxJQV5i52+2f4Y=
X-Received: by 2002:a62:9652:: with SMTP id c79-v6mr15872997pfe.114.1529989029594;
 Mon, 25 Jun 2018 21:57:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Mon, 25 Jun 2018 21:56:49
 -0700 (PDT)
In-Reply-To: <20180626014924.GB11229@jagdpanzerIV>
References: <000000000000720530056f7f9b63@google.com> <20180626014924.GB11229@jagdpanzerIV>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 26 Jun 2018 06:56:49 +0200
Message-ID: <CACT4Y+aGZWmBg9nWaWkBukUiP6ZTRH50OT89o+aGGdY8-JO0PQ@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in vprintk_emit
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     syzbot <syzbot+d29d18215e477cfbfbdd@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Samuel Ortiz <sameo@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 3:49 AM, Sergey Senozhatsky
<sergey.senozhatsky.work@gmail.com> wrote:
> On (06/25/18 16:19), syzbot wrote:
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    77072ca59fdd Merge tag 'for-linus-20180623' of git://git.k..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=169c7c04400000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=befbcd7305e41bb0
>> dashboard link: https://syzkaller.appspot.com/bug?extid=d29d18215e477cfbfbdd
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=1585147f800000
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+d29d18215e477cfbfbdd@syzkaller.appspotmail.com
>>
>> llcp: nfc_llcp_send_ui_frame: Could not allocate PDU
>> llcp: nfc_llcp_send_ui_frame: Could not allocate PDU
>> llcp: nfc_llcp_send_ui_frame: Could not allocate PDU
>> llcp: nfc_llcp_send_ui_frame: Could not allocate PDU
>> llcp: nfc_llcp_send_ui_frame: Could not allocate PDU
>
> Hi,
>
> Thanks for the report.
>
> I'll Cc networking people on this.
>
> I've a strong feeling that we saw it before.

A very similar bug was reported before:

https://groups.google.com/d/msg/syzkaller-bugs/Axw2t6DvU60/TfLUoXsjBAAJ



> The kernel is
> CONFIG_PREEMPT_VOLUNTARY=y, llcp_sock_sendmsg() stuck in a error
> reporting loop:
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
> [ 1004.674843] llcp: nfc_llcp_send_ui_frame: Could not allocate PDU
> [ 1004.681035] llcp: nfc_llcp_send_ui_frame: Could not allocate PDU
> ...
> [ 1098.508526] llcp: nfc_llcp_send_ui_frame: Could not allocate PDU
> [ 1098.514698] llcp: nfc_llcp_send_ui_frame: Could not allocate PDU
> [ 1098.520844] INFO: rcu_sched self-detected stall on CPU
>
> 94 seconds worth of heavy printing, no preemption:
>
>> INFO: rcu_sched self-detected stall on CPU
>>       1-....: (20918 ticks this GP) idle=55a/1/4611686018427387906
>> softirq=11347/11347 fqs=20240
>>        (t=125005 jiffies g=5572 c=5571 q=149)
>> NMI backtrace for cpu 1
>> CPU: 1 PID: 4811 Comm: syz-executor0 Not tainted 4.18.0-rc1+ #115
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>> Google 01/01/2011
>> Call Trace:
>>  <IRQ>
>>  __dump_stack lib/dump_stack.c:77 [inline]
>>  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
>>  nmi_cpu_backtrace.cold.4+0x19/0xce lib/nmi_backtrace.c:103
>>  nmi_trigger_cpumask_backtrace+0x151/0x192 lib/nmi_backtrace.c:62
>>  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
>>  trigger_single_cpu_backtrace include/linux/nmi.h:156 [inline]
>>  rcu_dump_cpu_stacks+0x175/0x1c2 kernel/rcu/tree.c:1336
>>  print_cpu_stall kernel/rcu/tree.c:1485 [inline]
>>  check_cpu_stall.isra.60.cold.78+0x36c/0x5a6 kernel/rcu/tree.c:1553
>>  __rcu_pending kernel/rcu/tree.c:3244 [inline]
>>  rcu_pending kernel/rcu/tree.c:3291 [inline]
>>  rcu_check_callbacks+0x23f/0xcd0 kernel/rcu/tree.c:2646
>>  update_process_times+0x2d/0x70 kernel/time/timer.c:1636
>>  tick_sched_handle+0x9f/0x180 kernel/time/tick-sched.c:164
>>  tick_sched_timer+0x45/0x130 kernel/time/tick-sched.c:1274
>>  __run_hrtimer kernel/time/hrtimer.c:1398 [inline]
>>  __hrtimer_run_queues+0x3eb/0x10c0 kernel/time/hrtimer.c:1460
>>  hrtimer_interrupt+0x2f3/0x750 kernel/time/hrtimer.c:1518
>>  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1025 [inline]
>>  smp_apic_timer_interrupt+0x165/0x730 arch/x86/kernel/apic/apic.c:1050
>>  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:863
>>  </IRQ>
>> RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:783
>> [inline]
>> RIP: 0010:console_unlock+0xc84/0x10b0 kernel/printk/printk.c:2397
>> Code: c1 e8 03 42 80 3c 38 00 0f 85 bd 03 00 00 48 83 3d 38 f7 8e 07 00 0f
>> 84 69 02 00 00 e8 45 56 19 00 48 8b bd b0 fe ff ff 57 9d <0f> 1f 44 00 00 e9
>> 96 f5 ff ff e8 2d 56 19 00 48 8b 7d 08 e8 94 cf
>> RSP: 0018:ffff8801aab0f358 EFLAGS: 00000293 ORIG_RAX: ffffffffffffff13
>> RAX: ffff8801aa2802c0 RBX: 0000000000000200 RCX: 1ffff10035450163
>> RDX: 0000000000000000 RSI: ffffffff8162b8fb RDI: 0000000000000293
>> RBP: ffff8801aab0f4c0 R08: ffff8801aa280af8 R09: 0000000000000006
>> R10: ffff8801aa2802c0 R11: 0000000000000000 R12: 0000000000000000
>> R13: ffffffff84ea9880 R14: 0000000000000001 R15: dffffc0000000000
>>  vprintk_emit+0x6c6/0xdf0 kernel/printk/printk.c:1907
>>  vprintk_default+0x28/0x30 kernel/printk/printk.c:1948
>>  vprintk_func+0x7a/0xe7 kernel/printk/printk_safe.c:382
>>  printk+0xa7/0xcf kernel/printk/printk.c:1981
>>  nfc_llcp_send_ui_frame.cold.9+0x18/0x1f net/nfc/llcp_commands.c:758
>>  llcp_sock_sendmsg+0x278/0x350 net/nfc/llcp_sock.c:786
>>  sock_sendmsg_nosec net/socket.c:645 [inline]
>>  sock_sendmsg+0xd5/0x120 net/socket.c:655
>>  ___sys_sendmsg+0x51d/0x930 net/socket.c:2161
>>  __sys_sendmmsg+0x240/0x6f0 net/socket.c:2256
>>  __do_sys_sendmmsg net/socket.c:2285 [inline]
>>  __se_sys_sendmmsg net/socket.c:2282 [inline]
>>  __x64_sys_sendmmsg+0x9d/0x100 net/socket.c:2282
>>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
>
> So we can try switching to ratelimited error reporting
> [that would be option A]:
>
> ---
>
> diff --git a/net/nfc/llcp_commands.c b/net/nfc/llcp_commands.c
> index 2ceefa183cee..2f3becb709b8 100644
> --- a/net/nfc/llcp_commands.c
> +++ b/net/nfc/llcp_commands.c
> @@ -755,7 +755,7 @@ int nfc_llcp_send_ui_frame(struct nfc_llcp_sock *sock, u8 ssap, u8 dsap,
>                 pdu = nfc_alloc_send_skb(sock->dev, &sock->sk, MSG_DONTWAIT,
>                                          frag_len + LLCP_HEADER_SIZE, &err);
>                 if (pdu == NULL) {
> -                       pr_err("Could not allocate PDU\n");
> +                       pr_err_ratelimited("Could not allocate PDU\n");
>                         continue;
>                 }
>
> ---
>
>
> Or ratelimited error reporting and cond_resched()
> [that would be option B]:
>
> ---
>
> diff --git a/net/nfc/llcp_commands.c b/net/nfc/llcp_commands.c
> index 2ceefa183cee..61741db4c4e6 100644
> --- a/net/nfc/llcp_commands.c
> +++ b/net/nfc/llcp_commands.c
> @@ -755,7 +755,8 @@ int nfc_llcp_send_ui_frame(struct nfc_llcp_sock *sock, u8 ssap, u8 dsap,
>                 pdu = nfc_alloc_send_skb(sock->dev, &sock->sk, MSG_DONTWAIT,
>                                          frag_len + LLCP_HEADER_SIZE, &err);
>                 if (pdu == NULL) {
> -                       pr_err("Could not allocate PDU\n");
> +                       pr_err_ratelimited("Could not allocate PDU\n");
> +                       cond_resched();
>                         continue;
>                 }
>
> ---
>
>         -ss
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/20180626014924.GB11229%40jagdpanzerIV.
> For more options, visit https://groups.google.com/d/optout.
