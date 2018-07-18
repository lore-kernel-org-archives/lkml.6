Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD684ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 08:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BBAB2075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 08:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="exOwiuln"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BBAB2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730348AbeGRJZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 05:25:24 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36648 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728010AbeGRJZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 05:25:24 -0400
Received: by mail-pl0-f65.google.com with SMTP id e11-v6so1749663plb.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 01:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=h1cblc/YkYzNbJ6A6AdjlEg1ROJqd/KvTuXu+1oIqH0=;
        b=exOwiulnSqE2bOi0NTAmPEWWNFAOIfnU6TJL9FsW8mZcFTNm38WaN5njxqkH094HNH
         UC/ECsRopIXGya3+I4XefRZgTWrQfasENRSRYcvgurhzvbXtfQUq67bLnexfoQ18+Sni
         SW4Lmqcruw9vpgRXrGpZeXcOmAjdH8YhizMYvGxI+RhEBFF/51qfNUR9IGMkoOpHg+uv
         EbwO2pgG89573kaGqMAgIbL5Q9hMn1DBq7a964kqF399kh1PV/Y0tPqrahk1Isrmfy8M
         f87IJejym3LDXaxElZRHkdRe8SrsdHrPVQ3j3gIAED2HuPZhMpVmd6ISsX+M3Sbco6yJ
         j0gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=h1cblc/YkYzNbJ6A6AdjlEg1ROJqd/KvTuXu+1oIqH0=;
        b=RcWA/bT3NYUaZx10F6vIN/j5qUoWcgnzSh4MmVb4YqYEV0+AjjbHbgZF6ZnCNamT3/
         wFAlRcBPLpMQ/pa+X9+w6itnGecgtYIihgZwX6FyqqONr0QNqwHscSKw7LTSMyq7RU0F
         /O9aar4gQYclXUxMfP1AiaYjhzCYzCyDeBVfNmkhcSnaU3HUNsW369jLbuohD5r5bfyD
         hnHIsrdIdUGGqXH2qbh2PaAgNc6WVB0zOPkkRcdZCbRw0AxOCeHzR2w+sx23menrH/dU
         BEtFYVHbd/4PwkZ6o4Vda0p3YVnFV8XjWxyVni5JmABjYPSw6K+cQq2lSbOViVaRAkMb
         f+Fg==
X-Gm-Message-State: AOUpUlEptgghkIFjUWH2GhbBYWWfsjtbzxO39CftjWPayAy6B7jkiy0a
        uAeZt4bfrOKlhkq0LkkXX6COgcIx1Isijwv0PE65NA==
X-Google-Smtp-Source: AAOMgpfD1j05L5YO7GXYR1P/ki9Z/Zdmrn/EMDzPd6xInVkBa2HewrqLAqinzwnzR9w53+O8Fjn+v1UHkZX+gIKf4Ic=
X-Received: by 2002:a17:902:740b:: with SMTP id g11-v6mr5102544pll.85.1531903713091;
 Wed, 18 Jul 2018 01:48:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Wed, 18 Jul 2018 01:48:12
 -0700 (PDT)
In-Reply-To: <0000000000008e056605713e8035@google.com>
References: <0000000000008e056605713e8035@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 18 Jul 2018 10:48:12 +0200
Message-ID: <CACT4Y+YxgGaBnPK1tQR5Sa7D4+eMMQnwKG8w1EHZLTgVA6+w8A@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in
 corrupted (2)
To:     syzbot <syzbot+c9ebf7fd9683e40ccebc@syzkaller.appspotmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 6:29 AM, syzbot
<syzbot+c9ebf7fd9683e40ccebc@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    dc989d2ce2c2 tools: bpftool: don't pass FEATURES_DUMP to l..
> git tree:       bpf-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=10a9a978400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=89129667b46496c3
> dashboard link: https://syzkaller.appspot.com/bug?extid=c9ebf7fd9683e40ccebc
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=11974b2c400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14de7a58400000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+c9ebf7fd9683e40ccebc@syzkaller.appspotmail.com

#syz fix: bpf: sockhash, disallow bpf_tcp_close and update in parallel

> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> IPVS: ftp: loaded support on port[0] = 21
> BUG: unable to handle kernel NULL pointer dereference at 0000000000000072
> ==================================================================
> PGD 1acfe1067
> BUG: KASAN: stack-out-of-bounds in rcu_cblist_dequeue+0xaa/0xe0
> kernel/rcu/rcu_segcblist.c:54
> P4D 1acfe1067
> Read of size 8 at addr ffff8801cfe1e340 by task syz-executor568/12240
> PUD 1c551a067
>
> PMD 0
> CPU: 0 PID: 12240 Comm: syz-executor568 Not tainted 4.18.0-rc3+ #57
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Oops: 0002 [#1] SMP KASAN
> Call Trace:
> CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.18.0-rc3+ #57
>  <IRQ>
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
> RIP: 0010:K512_4+0x6792/0x120eac
> Code:
> 20
> 36
> 34
>  print_address_description+0x6c/0x20b mm/kasan/report.c:256
> 20
> 34
>  kasan_report_error mm/kasan/report.c:354 [inline]
>  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
> 20
>  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
> 74
>  rcu_cblist_dequeue+0xaa/0xe0 kernel/rcu/rcu_segcblist.c:54
> 68
> 69
>  rcu_do_batch kernel/rcu/tree.c:2556 [inline]
>  invoke_rcu_callbacks kernel/rcu/tree.c:2818 [inline]
>  __rcu_process_callbacks kernel/rcu/tree.c:2785 [inline]
>  rcu_process_callbacks+0xf7e/0x1850 kernel/rcu/tree.c:2802
> 73
> 20
> 32
> 35
> 36
> 20
> 36
> 34
> 20
> 34
> 20
>  __do_softirq+0x2e8/0xb17 kernel/softirq.c:288
> 74
> 68
> 61
> 74
> 20
> 00
> 00
> 00
> 00
> 00
>  invoke_softirq kernel/softirq.c:368 [inline]
>  irq_exit+0x1d1/0x200 kernel/softirq.c:408
> 00
>  exiting_irq arch/x86/include/asm/apic.h:527 [inline]
>  smp_apic_timer_interrupt+0x186/0x730 arch/x86/kernel/apic/apic.c:1052
> 00
> 20
> 30
> 20
> 33
> 32
> 20
> 38
>  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:863
> 20
>  </IRQ>
> 31
>
> 32
> Allocated by task 0:
> <20>
> (stack is not available)
> 74
>
> 61
> Freed by task 3487688240:
> 72 67 65 74 5f 65 6e 74 72 79 20 39 36 20 32 34 20 35 20
> RSP: 0018:ffff8801daf07980 EFLAGS: 00010202
> RAX: ffffffff81674dc6 RBX: ffffffff88bf2c08 RCX: 0000000000000000
> RDX: ffffffff88bf2c08 RSI: 0000000000000000 RDI: ffff8801cfea94a0
> RBP: ffff8801daf07c88 R08: 0000000000000000 R09: 0000000000000000
> R10: fffffbfff157bc71 R11: ffffffff8abde38b R12: ffff8801cfea94a0
> R13: ffff8801cfea94a8 R14: dffffc0000000000 R15: ffff8801daf07c60
> FS:  0000000000000000(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000072 CR3: 00000001cae8d000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <IRQ>
>  __do_softirq+0x2e8/0xb17 kernel/softirq.c:288
>  invoke_softirq kernel/softirq.c:368 [inline]
>  irq_exit+0x1d1/0x200 kernel/softirq.c:408
>  exiting_irq arch/x86/include/asm/apic.h:527 [inline]
>  smp_apic_timer_interrupt+0x186/0x730 arch/x86/kernel/apic/apic.c:1052
>  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:863
>  </IRQ>
> RIP: 0010:native_safe_halt+0x6/0x10 arch/x86/include/asm/irqflags.h:54
> Code: c7 48 89 45 d8 e8 8a 2d 23 fa 48 8b 45 d8 e9 d2 fe ff ff 48 89 df e8
> 79 2d 23 fa eb 8a 90 90 90 90 90 90 90 55 48 89 e5 fb f4 <5d> c3 0f 1f 84 00
> 00 00 00 00 55 48 89 e5 f4 5d c3 90 90 90 90 90
> RSP: 0018:ffff8801d9af7c38 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff13
> RAX: dffffc0000000000 RBX: 1ffff1003b35ef8a RCX: ffffffff81667982
> RDX: 1ffffffff11e3610 RSI: 0000000000000004 RDI: ffffffff88f1b080
> RBP: ffff8801d9af7c38 R08: ffffed003b5e46d7 R09: ffffed003b5e46d6
> R10: ffffed003b5e46d6 R11: ffff8801daf236b3 R12: 0000000000000001
> R13: ffff8801d9af7cf0 R14: ffffffff899ee920 R15: 0000000000000000
>  arch_safe_halt arch/x86/include/asm/paravirt.h:94 [inline]
>  default_idle+0xc7/0x450 arch/x86/kernel/process.c:500
>  arch_cpu_idle+0x10/0x20 arch/x86/kernel/process.c:491
>  default_idle_call+0x6d/0x90 kernel/sched/idle.c:93
>  cpuidle_idle_call kernel/sched/idle.c:153 [inline]
>  do_idle+0x3aa/0x570 kernel/sched/idle.c:262
>  cpu_startup_entry+0x10c/0x120 kernel/sched/idle.c:368
>  start_secondary+0x433/0x5d0 arch/x86/kernel/smpboot.c:265
>  secondary_startup_64+0xa5/0xb0 arch/x86/kernel/head_64.S:242
> Modules linked in:
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> CR2: 0000000000000072
> ---[ end trace 9d01a82a0b66f200 ]---
> BUG: unable to handle kernel paging request at ffffffff8c3f7968
> PGD 8e6d067
> RIP: 0010:K512_4+0x6792/0x120eac
> P4D 8e6d067
> Code:
> PUD 8e6e063
> 20
> PMD 0
> 36
> 34
> Thread overran stack, or stack corrupted
> 20 34
> Oops: 0000 [#2] SMP KASAN
> 20
> CPU: 0 PID: 12240 Comm: syz-executor568 Tainted: G      D
> 4.18.0-rc3+ #57
> 74
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> 68
> RIP: 0010:depot_fetch_stack+0x10/0x30 lib/stackdepot.c:201
> 69
> Code:
> 73
> e8
> 20
> c5
> 32
> 2e
> 35
> 47
> 36
> fe
> 20
> e9
> 36
> b3
> 34
> fd
> 20
> ff
> 34
> ff
> 20
> e8
> 74
> bb
> 68
> 2e
> 61
> 47
> 74
> fe
> 20
> e9
> 00
> 55
> 00
> fd
> 00
> ff
> 00
> ff
> 00
> 90
> 00
> 90
> 00
> 90
> 20
> 90
> 30
> 90
> 20
> 90
> 33
> 89
> 32
> f8
> 20
> c1
> 38
> ef
> 20
> 11
> 31
> 25
> 32
> ff
> <20>
> ff
> 74
> 1f
> 61
> 00
> 72
> 81
> 67
> e7
> 65
> f0
> 74
> 3f
> 5f
> 00
> 65
> 00
> 6e
> <48>
> 74
> 03
> 72
> 3c
> 79
> c5
> 20
> 60
> 39
> 39
> 36
> 43
> 20
> 8b
> 32
> 8b
> 34
> 47
> 20
> 0c
> 35
> 48
> 20
> 83
> c7
> RSP: 0018:ffff8801daf07980 EFLAGS: 00010202
> 18
> c7
> RAX: ffffffff81674dc6 RBX: ffffffff88bf2c08 RCX: 0000000000000000
> 46 10
> RDX: ffffffff88bf2c08 RSI: 0000000000000000 RDI: ffff8801cfea94a0
> 00
> RBP: ffff8801daf07c88 R08: 0000000000000000 R09: 0000000000000000
> 00
> R10: fffffbfff157bc71 R11: ffffffff8abde38b R12: ffff8801cfea94a0
> 00
> R13: ffff8801cfea94a8 R14: dffffc0000000000 R15: ffff8801daf07c60
> 00
> FS:  0000000000000000(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> RSP: 0018:ffff8801dae07898 EFLAGS: 00010006
> CR2: 0000000000000072 CR3: 00000001cae8d000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> RAX: 00000000001f8801 RBX: ffff8801cfe1e514 RCX: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> RDX: 0000000000000000 RSI: ffff8801dae078a0 RDI: 0000000000003ff0
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
> https://groups.google.com/d/msgid/syzkaller-bugs/0000000000008e056605713e8035%40google.com.
> For more options, visit https://groups.google.com/d/optout.
