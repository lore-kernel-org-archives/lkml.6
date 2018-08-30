Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19048C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9CDF20834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UU9ObnT8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9CDF20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbeH3Tmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:42:44 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40941 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbeH3Tmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:42:43 -0400
Received: by mail-pf1-f195.google.com with SMTP id s13-v6so4053330pfi.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 08:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1UnD9TybNYX87ySsJYQrH8NIUHrrgNSEGob1qymno8A=;
        b=UU9ObnT8L4/L/fk8rV0DtnhOJEyfFK27LzVGjW2qDcyltNsE16kZxprXeijreMbsps
         QjbOuaXwTsaFLpY7p16P3Ed/0qWEIGvvuFOKeNGa83cWzXosjo3lix+MnXR73pSsZ/N8
         6D67LMCfblqYqNyhckTYN+v4M2DHnqOoWG1GP1G1QSb/JV6yBpF6RGjqJfJ7NkP0lub8
         dZhm5TxVZ4BFJ7gNl1qVU8XUtXqSG4X5IDbyp1Ym0xEiGb0OoWxRL7d4Ihx+m6HFg7lT
         RuuCJrRyg3M1GXk5ASwPpuLY1PqIA2e1jzWGB1dyDHuY89EvAp+UjYb6vQ71zUpJ31VA
         XhMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1UnD9TybNYX87ySsJYQrH8NIUHrrgNSEGob1qymno8A=;
        b=rN3i8xVgBp+eIA1kUGAZnbbMqEs+zwL3NzZKQo66XTIuH+c3X1xYeSbI73wN9b8wiq
         qIeVGE8e0MitdeFe9DEs5ypPYHk8j5BZRMr2lPrOZXvXTDIKYF2QK8V5W5VkXGXXzCz/
         dipXvMFdbPDuZa9WrUHJ09ecPpnem79nPpySkRgq/hF8LvvxTwEPEY0Hl5WSI4uAQqgX
         a/CK+cm+dJJOAa3rTdKzvIQuCvHwSL7xBv1fHdTqiAav+EtUA/xnepbAq5bZxEHPcGN5
         +E12NINn842fD5THoMlAYDN2t7n57+DynWQX7+VZI6QJdyJ83H0QEf2HUDQoKejwtJpz
         Zqug==
X-Gm-Message-State: APzg51C80KKkCEopI69sF5Qjlm3rlbCm5N73Sgk81bucUfZN4RAjQT+A
        QNgIAvqaEBTJYSwraj+KG6LZ6IVUhH/EMRHxV/7Kkw==
X-Google-Smtp-Source: ANB0VdalHRXG4kf7Fwr0DDXtcr7mctGrroUXk3GAR5v6EFgwliOBF+TTaq84JUcjX8/xNL0P27W19LjUo68J3FzdyFM=
X-Received: by 2002:a63:4702:: with SMTP id u2-v6mr9895480pga.95.1535643598667;
 Thu, 30 Aug 2018 08:39:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Thu, 30 Aug 2018 08:39:38
 -0700 (PDT)
In-Reply-To: <0000000000003b1c360574a8c31e@google.com>
References: <0000000000003b1c360574a8c31e@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 30 Aug 2018 08:39:38 -0700
Message-ID: <CACT4Y+Yuwcm9N-_QwyPzj==xFUuziW24eQzw318Y=VKXQ=8_nw@mail.gmail.com>
Subject: Re: WARNING in handle_irq (3)
To:     syzbot <syzbot+a58b558e3e62d0604e5c@syzkaller.appspotmail.com>,
        netdev <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, nstange@suse.de,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 8:31 AM, syzbot
<syzbot+a58b558e3e62d0604e5c@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    58c3f14f86c9 Merge tag 'riscv-for-linus-4.19-rc2' of git:/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10be176a400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=531a917630d2a492
> dashboard link: https://syzkaller.appspot.com/bug?extid=a58b558e3e62d0604e5c
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.

+bpf maintainers

Looks suspiciously similar to:
https://groups.google.com/d/msg/syzkaller-bugs/4v7MtbIT1hY/A87hInzyAwAJ

Note this commit seems to already have "bpf, sockmap: fix
sock_hash_alloc and reject zero-sized keys ".

Tentative reproducer from the log is:

14:08:59 executing program 5:
socketpair(0x20000, 0x0, 0x0, &(0x7f0000000140))
r0 = socket$inet6_tcp(0xa, 0x1, 0x0)
r1 = socket$inet6_tcp(0xa, 0x1, 0x0)
bind$inet6(r1, &(0x7f00000000c0)={0xa, 0x4e22}, 0x1c)
listen(r1, 0x0)
sendto$inet6(r0, &(0x7f0000000140), 0x2d6, 0x20000004,
&(0x7f0000000080)={0xa, 0x100000004e22, 0x0, @loopback}, 0x1c)
setsockopt$inet6_tcp_TCP_ULP(r0, 0x6, 0x1f, &(0x7f0000000080)='tls\x00', 0x152)
r2 = bpf$MAP_CREATE(0x0, &(0x7f0000000280)={0xf, 0x4, 0x4, 0x70}, 0x2c)
bpf$MAP_UPDATE_ELEM(0x2, &(0x7f0000000180)={r2, &(0x7f0000000000),
&(0x7f0000000140)}, 0x20)

Which does not create a 0-key map.



> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+a58b558e3e62d0604e5c@syzkaller.appspotmail.com
>
> TCP: request_sock_TCPv6: Possible SYN flooding on port 20002. Sending
> cookies.  Check SNMP counters.
> ------------[ cut here ]------------
> do_IRQ(): syz-executor5 has overflown the kernel stack
> (cur:ffff88018aec0000,sp:ffff88018aeb0e18,irq stk
> top-bottom:ffff8801db000080-ffff8801db008000,exception stk
> top-bottom:fffffe0000007080-fffffe0000011000,ip:lock_is_held_type+0x18b/0x210)
> WARNING: CPU: 0 PID: 13805 at arch/x86/kernel/irq_64.c:64
> stack_overflow_check arch/x86/kernel/irq_64.c:61 [inline]
> WARNING: CPU: 0 PID: 13805 at arch/x86/kernel/irq_64.c:64
> handle_irq+0x1fb/0x2e7 arch/x86/kernel/irq_64.c:73
> Kernel panic - not syncing: panic_on_warn set ...
>
> CPU: 0 PID: 13805 Comm: syz-executor5 Not tainted 4.19.0-rc1+ #215
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
>  panic+0x238/0x4e7 kernel/panic.c:184
>  __warn.cold.8+0x163/0x1ba kernel/panic.c:536
>  report_bug+0x252/0x2d0 lib/bug.c:186
>  fixup_bug arch/x86/kernel/traps.c:178 [inline]
>  do_error_trap+0x1fc/0x4d0 arch/x86/kernel/traps.c:296
>  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
>  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:993
> RIP: 0010:stack_overflow_check arch/x86/kernel/irq_64.c:61 [inline]
> RIP: 0010:handle_irq+0x1fb/0x2e7 arch/x86/kernel/irq_64.c:73
> Code: 00 00 ff b6 80 00 00 00 48 c7 c7 80 ca 24 87 41 54 41 55 65 48 8b 04
> 25 40 ee 01 00 48 05 68 06 00 00 48 89 c6 e8 95 c4 1c 00 <0f> 0b 48 83 c4 18
> e9 3f ff ff ff 48 89 75 e0 e8 c1 fe 90 00 48 8b
> RSP: 0018:ffff8801db007f58 EFLAGS: 00010082
> RAX: 0000000000000000 RBX: ffff8801cee0ad80 RCX: 0000000000000000
> RDX: 0000000000010000 RSI: ffffffff8163ac01 RDI: 0000000000000001
> RBP: ffff8801db007fb0 R08: ffff8801c9b4a700 R09: ffffed003b603eca
> R10: ffffed003b603eca R11: ffff8801db01f657 R12: fffffe0000011000
> R13: fffffe0000007080 R14: 000000000000002a R15: 0000000000000000
>  do_IRQ+0x80/0x1a0 arch/x86/kernel/irq.c:246
>  common_interrupt+0xf/0xf arch/x86/entry/entry_64.S:643
>  </IRQ>
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
> syzbot.
