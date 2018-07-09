Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDD2C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 05:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0421D208A3
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 05:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uig6MXwM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0421D208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754526AbeGIFtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 01:49:11 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:43494 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754371AbeGIFtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 01:49:10 -0400
Received: by mail-pf0-f196.google.com with SMTP id y8-v6so12831292pfm.10
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 22:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Pitt8N3e/Xjs7HXGaALBoeUX3MEAt6s4BiLThZDIZW0=;
        b=Uig6MXwMhuIfLIYmQGXd9OAICNVxH8lL1pkvVuIURYdJg0Smsl+KZqEe5e3G6T/OKt
         W289oQx4/V8vX7dRk8Z9B/XeTzlO83P2eXS8Op9DWO9XVMCT60fDq5yv0zLtJvRjt51V
         86RzaZzKlR+11I3S9XuynfXYcgquF+EpiHLN8eW4uB8FWbq0g4lXf/NYXg1fDPEvXi0t
         yPtPR+QjVunPNGLGNDdo9TPAoAHJPKQkez1F/dJUBbHrfKvkGxKMxUajg5H/oWVdAR61
         Kuj5tpzft/fSBaRnlR8mTsi6UBkpr8a4qhe0sm6LOq4q2VKNo8X0/Cvd5eAH5QHXA/n9
         SMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Pitt8N3e/Xjs7HXGaALBoeUX3MEAt6s4BiLThZDIZW0=;
        b=KD56O1fha+neAAxuCI8rZpmrOxNJQGsLoZUd926Fqw8BxqySwg15Fu3kWatR4b+hk2
         8SbrUtTOJ6Vy7zhXj90vh1GloC7/QnwByVvRg0aBOxQYW199icv3br+VFOt4N8cbmYIS
         vzh1bhYpL2enopLc3LpdO1eyLlQrnR9eScazzbmhAPcRHf/eqEp0Ms/QMqv77b0Jxvp1
         hm4jubnF3LXvLhH4vfPnpmILEfbe/LKIU7SOmVLOq534JXsmEOcIyoAlMhPxoXbSF5K9
         nz/TAk9vawEOFpCjsd0eJ5f89nuwKXfHnIURE+p1IiQ/11wbsff2QMqdY96k7mAfuQPA
         aVyw==
X-Gm-Message-State: APt69E1EO+5THXuwc1XQWhWlRCsZnXRuTRHKsOZ1wdFFrAz6wLRsVawn
        O6hfyr2PRuegaH6QZR9C+JWHHX54A5UBo5hLkLuFLB5J60A=
X-Google-Smtp-Source: AAOMgped6iLzr5LvwH6GcWXBBqWK7ioT16xifdFcWj44cZ/hmpWa2H9whEkyHsFdGZcfg8xPaEWsIcal5U8mUTtfVng=
X-Received: by 2002:a65:40cd:: with SMTP id u13-v6mr18019872pgp.334.1531115349197;
 Sun, 08 Jul 2018 22:49:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:950a:0:0:0:0 with HTTP; Sun, 8 Jul 2018 22:48:48
 -0700 (PDT)
In-Reply-To: <000000000000fcc4db05708855b0@google.com>
References: <000000000000fcc4db05708855b0@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 9 Jul 2018 07:48:48 +0200
Message-ID: <CACT4Y+bdewgY9mhWwgi+yMXhqvQCf5xcVhrtBh8oSOVe3sFrKA@mail.gmail.com>
Subject: Re: general protection fault in scheduler_tick
To:     syzbot <syzbot+c840410f5e0567496967@syzkaller.appspotmail.com>
Cc:     =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 5:09 AM, syzbot
<syzbot+c840410f5e0567496967@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    526674536360 Add linux-next specific files for 20180706
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D17f6396840000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dc8d1cfc0cb798=
e48
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dc840410f5e05674=
96967
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=3D16e50594400=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D129180c840000=
0
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit=
:
> Reported-by: syzbot+c840410f5e0567496967@syzkaller.appspotmail.com


#syz fix: bpf: sockhash, disallow bpf_tcp_close and update in parallel

> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] SMP KASAN
> CPU: 0 PID: -1996936928 Comm: =EF=BF=BD=EF=BF=BD=D7=A9 =EF=BF=BD=EF=BF=BD=
=EF=BF=BDutor Not tainted
> 4.18.0-rc3-next-20180706+ #1
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:scheduler_tick+0x170/0x430 kernel/sched/core.c:3078
> Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 9a 02 00 00 48 ba 00 00 00 0=
0
> 00 fc ff df 49 8b 47 78 48 8d 78 78 48 89 f9 48 c1 e9 03 <80> 3c 11 00 0f=
 85
> 5f 02 00 00 48 8b 40 78 31 d2 4c 89 fe 48 89 df
> RSP: 0018:ffff8801dae07a00 EFLAGS: 00010006
> RAX: 0000000000000000 RBX: ffff8801dae2c980 RCX: 000000000000000f
> RDX: dffffc0000000000 RSI: 0000000000000008 RDI: 0000000000000078
> RBP: ffff8801dae07ae0 R08: ffff88021fff8018 R09: ffff88021fff801b
> R10: ffffed0043fff001 R11: 0000000000000000 R12: 0000000000000000
> R13: ffff8801dae07a38 R14: ffff8801dae07ab8 R15: ffff8801a9d7e080
> FS:  00007ff7f2704700(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000130 CR3: 0000000008e6a000 CR4: 00000000001406f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <IRQ>
>  update_process_times+0x51/0x70 kernel/time/timer.c:1641
>  tick_sched_handle+0x9f/0x180 kernel/time/tick-sched.c:164
>  tick_sched_timer+0x45/0x130 kernel/time/tick-sched.c:1274
>  __run_hrtimer kernel/time/hrtimer.c:1398 [inline]
>  __hrtimer_run_queues+0x3eb/0x10c0 kernel/time/hrtimer.c:1460
>  hrtimer_interrupt+0x2f3/0x750 kernel/time/hrtimer.c:1518
>  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1025 [inline]
>  smp_apic_timer_interrupt+0x165/0x730 arch/x86/kernel/apic/apic.c:1050
>  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:867
>  </IRQ>
> Modules linked in:
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> ---[ end trace 40913575008fbda0 ]---
> RIP: 0010:scheduler_tick+0x170/0x430 kernel/sched/core.c:3078
> Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 9a 02 00 00 48 ba 00 00 00 0=
0
> 00 fc ff df 49 8b 47 78 48 8d 78 78 48 89 f9 48 c1 e9 03 <80> 3c 11 00 0f=
 85
> 5f 02 00 00 48 8b 40 78 31 d2 4c 89 fe 48 89 df
> RSP: 0018:ffff8801dae07a00 EFLAGS: 00010006
> RAX: 0000000000000000 RBX: ffff8801dae2c980 RCX: 000000000000000f
> RDX: dffffc0000000000 RSI: 0000000000000008 RDI: 0000000000000078
> RBP: ffff8801dae07ae0 R08: ffff88021fff8018 R09: ffff88021fff801b
> R10: ffffed0043fff001 R11: 0000000000000000 R12: 0000000000000000
> R13: ffff8801dae07a38 R14: ffff8801dae07ab8 R15: ffff8801a9d7e080
> FS:  00007ff7f2704700(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000130 CR3: 0000000008e6a000 CR4: 00000000001406f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
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
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/000000000000fcc4db057088=
55b0%40google.com.
> For more options, visit https://groups.google.com/d/optout.
