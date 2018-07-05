Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FA0C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7AD92405B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QjDMsSw/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7AD92405B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754325AbeGEQVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:21:34 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46271 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753785AbeGEQVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:21:33 -0400
Received: by mail-pl0-f68.google.com with SMTP id 30-v6so1485985pld.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 09:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=M93BZ4zvkpd6mCTq5ZFgN1BPoAY7Vdbjzz9FFCktLQQ=;
        b=QjDMsSw/bAQuWnAXzzHuu5dpAApmorgz9VlIQEK02WLCZhFOYMCw18aJzsnq2CZjVg
         iZfFbpXZvp5DgYNbGDvI0jdcPddOmauJAuQwvpRPPebsRFyTeYwdwukB+GjCb4tZ+p4U
         Y7c3xjQgK2oExjXLdGjTL7J5ZTmhtqSr8V+j6piUueJ8MBce5PpJigft/rlLqywySaBk
         uDGoMV8n178+laOtD6o3GAPp/xQGu21+LNtApDJV5TW/wyIRc+m7icFH1iE9vNvkfHjA
         80IoeIK4GKK05wFVuoc40xSyxlOaWuXwNRRgxdUG4K9IgoLoBB07oKxkYTxZDhpPMLyX
         Widg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=M93BZ4zvkpd6mCTq5ZFgN1BPoAY7Vdbjzz9FFCktLQQ=;
        b=FJoMQOi/CCa/cy73a+cmyL1rGRIaVlN0XakImzpAYG+AvAYL1OoKSNy3UGFbbI8LXO
         yoqwrAPVBGMfpKnT/n7Eqh2qnr73EQoxPvhPnLBx8hBIhEVS4acVtc8wV65AvVh38RZ0
         ojlPpEROpzjKswGdpxw3Jrik3TRHmhWgAOF09yybUvltbIttOra6Jfvh8az86HSTTesR
         LCTjIJI62gzLMT1O8iu5fhrXK/ZGaMOU2tx/awl6trqOveRr4wpHR+eRSWDmfQUhPg6+
         jEnh1kYI1TYrJS5R4rdCbpEKIwIUt9/YPmvijBiDUmS24d5T6VpPooUzIFBaZI+Wa9jF
         5QUw==
X-Gm-Message-State: APt69E1URjUFR6XjArzEKWZt85V8uLOJGtySxxzlhM95LG9yCVw5KLKY
        N2KaX/IlQSu8WrP0cHCM8+8IauQxEjou3J2xAxDfvA==
X-Google-Smtp-Source: AAOMgpchBOoDivqr25MuZLWVKoFStnyYRcilKX73D2ld8UVztkD4PmmUWRnRfVR4XQMdGF/BT/s7sYS5GT8f6ioNzfE=
X-Received: by 2002:a17:902:b115:: with SMTP id q21-v6mr6753955plr.97.1530807692532;
 Thu, 05 Jul 2018 09:21:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Thu, 5 Jul 2018 09:21:11
 -0700 (PDT)
In-Reply-To: <000000000000c443f505702dd6fb@google.com>
References: <000000000000c443f505702dd6fb@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 5 Jul 2018 18:21:11 +0200
Message-ID: <CACT4Y+Z7FS0QbTZ6CevHA+x3ayKuJAw+om+unAdjwqHkRXFYCw@mail.gmail.com>
Subject: Re: KASAN: stack-out-of-bounds Read in switch_mm_irqs_off
To:     syzbot <syzbot+6cea61a6cd1e9ae6b195@syzkaller.appspotmail.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>, namit@vmware.com,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        tim.c.chen@linux.intel.com,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 5:11 PM, syzbot
<syzbot+6cea61a6cd1e9ae6b195@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    2bdea157b999 Merge branch 'sctp-fully-support-for-dscp-and..
> git tree:       bpf-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=136a7e0c400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f62553dc846b0692
> dashboard link: https://syzkaller.appspot.com/bug?extid=6cea61a6cd1e9ae6b195
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+6cea61a6cd1e9ae6b195@syzkaller.appspotmail.com

#syz dup: KASAN: stack-out-of-bounds Read in timerqueue_add

> ==================================================================
> BUG: KASAN: stack-out-of-bounds in switch_mm_irqs_off+0x13db/0x16c0
> arch/x86/mm/tlb.c:275
> PANIC: double fault, error_code: 0x0
> Read of size 8 at addr ffff8801957727f0 by task swapper/0/0
> CPU: 1 PID: 6433 Comm: syz-executor2 Not tainted 4.18.0-rc3+ #45
>
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.18.0-rc3+ #45
> RIP: 0010:__lock_acquire+0x2e/0x5020 kernel/locking/lockdep.c:3294
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Code:
> Call Trace:
> 41 57
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
> 41
> 89 cf
> 41 56
> 41 55
> 49 89
>  print_address_description+0x6c/0x20b mm/kasan/report.c:256
> fd
> 41
>  kasan_report_error mm/kasan/report.c:354 [inline]
>  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
> 54
>  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
> 45
>  switch_mm_irqs_off+0x13db/0x16c0 arch/x86/mm/tlb.c:275
> 89 cc
> 53
> 65
> 4c
> 8b 34 25
> 40
> ee
> 01 00
> 48
> 83
> e4 f0
>  context_switch kernel/sched/core.c:2850 [inline]
>  __schedule+0x79c/0x1ed0 kernel/sched/core.c:3504
> 48 81
> ec
> 60 03
> 00
> 00
> 48
> 8b
> 45 10
> <89>
>  schedule_idle+0x45/0x80 kernel/sched/core.c:3575
> 94 24
>  do_idle+0x17f/0x570 kernel/sched/idle.c:286
> 80
> 00
> 00
>  cpu_startup_entry+0x10c/0x120 kernel/sched/idle.c:368
> 00
> 48 ba
> 00
> 00
>  rest_init+0xe1/0xe4 init/main.c:442
> 00 00
>  start_kernel+0x90e/0x949 init/main.c:738
> 00
> fc
> ff df
> 48
> 89 84
> 24 98
>  x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:452
>  x86_64_start_kernel+0x76/0x79 arch/x86/kernel/head64.c:433
> RSP: 0018:ffff880193f7eea0 EFLAGS: 00010086
>  secondary_startup_64+0xa5/0xb0 arch/x86/kernel/head_64.S:242
> RAX: 0000000000000000 RBX: 1ffff100327efe50 RCX: 0000000000000002
>
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff88f92620
> Allocated by task 4496:
> RBP: ffff880193f7f228 R08: 0000000000000000 R09: 0000000000000000
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
> R10: ffff880195aa71b8 R11: ffff8801daf236b3 R12: 0000000000000000
>  set_track mm/kasan/kasan.c:460 [inline]
>  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
> R13: ffffffff88f92620 R14: ffff8801aa290440 R15: 0000000000000002
>  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
> FS:  00007f39fda9b700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
>  kmem_cache_alloc+0x12e/0x760 mm/slab.c:3554
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  dup_mm kernel/fork.c:1234 [inline]
>  copy_mm kernel/fork.c:1297 [inline]
>  copy_process.part.40+0x235f/0x7220 kernel/fork.c:1803
> CR2: ffff880193f7ee98 CR3: 00000001d6d6a000 CR4: 00000000001406e0
>  copy_process kernel/fork.c:1616 [inline]
>  _do_fork+0x291/0x12a0 kernel/fork.c:2099
> DR0: 00000000200001c0 DR1: 0000000020000000 DR2: 0000000000000000
>  __do_sys_clone kernel/fork.c:2206 [inline]
>  __se_sys_clone kernel/fork.c:2200 [inline]
>  __x64_sys_clone+0xbf/0x150 kernel/fork.c:2200
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
> Call Trace:
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
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
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/000000000000c443f505702dd6fb%40google.com.
> For more options, visit https://groups.google.com/d/optout.
