Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E945C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 11:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB141206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 11:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aEVGB73n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbfADLMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 06:12:45 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:41403 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727550AbfADLMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 06:12:44 -0500
Received: by mail-io1-f65.google.com with SMTP id s22so29272377ioc.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 03:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DZ4r3WakkgR9pFQwNJHjfIy5jjvOz/zFRbRdvrrol8s=;
        b=aEVGB73ne9izNExcc1TApHW6lWVttFOlWBBucItt7b4sUTfX81NHNMq3NtT7VyneT/
         ZFoORXAXpq7VrcJSGtFXn5v+wIqMG9h8UL3oHhpp3l9V/8yoHPbarlF2Tw/0Bls2AuVQ
         MBODhiqFtHOv9ULP/GFTO1S56ZDSLmjglh966VrU9z42M3lmnCbEHQgGEE1uVfmIq3zu
         1wTWUWYcasn8eLXOaqSVTEXsVBj85xc7HR9lbB7eoEJk2xDVZBR3p6yMNr6prgpG1HdB
         zTYp8j78R+C4GEiL2wtG0ArpLf5Y1TfLttpt6DMX9y84VvepVHTSuvmmV3ljrkFbHEvT
         otDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DZ4r3WakkgR9pFQwNJHjfIy5jjvOz/zFRbRdvrrol8s=;
        b=PfkzNLApE2S6Qs1Z+Z5fmq6yv27tGH2rCmRF2ffZmHxzB3tPX6z4iowl3oZsNm8/ni
         IFv5Y+trROvg2o7osox/GNQ1A9ByQvhpvJ34HxYBbQgdXVo8/UELkp/YWO7LXhB5XgNc
         B7olKVt1ELwd5gwXkeKwvial5jE32T1DrrtIM0O75W7oVRd6VQcsYUmV/Uu7iHozw0u+
         H324bTnUH1Yp4ctLvSFtmXQ9ZmCElh3E6K7j6Bb0wOg5YHxAbQWbw1Ed8sr/IFIvdxVf
         N8LUapvO+QWeNqJ8fHWMLbyuMuVhVFRp3AGSIrVJIYswn3HXHcY9kVtIZOXnpVuJhgw0
         6kkA==
X-Gm-Message-State: AJcUukf52wGS09G0UWvCuU4svAQ27PHe/Vdm2H97oyRZqikCHJ54VJQI
        ppuN5On2qGR1GesPiU3N3bjnGTSb6SJMsvBFDXhXUA==
X-Google-Smtp-Source: ALg8bN54AJqw4vSCKRhhei+L8jCG/Dgr2TUkns+hahZeX6uard44B4WiM1YIWf50YvT+6dQ9jKuWE8JzF1jdxMhcAFU=
X-Received: by 2002:a5d:9456:: with SMTP id x22mr9238429ior.282.1546600363161;
 Fri, 04 Jan 2019 03:12:43 -0800 (PST)
MIME-Version: 1.0
References: <0000000000001aea21057e4c1ab5@google.com> <000000000000f9aaa5057e7c9ad5@google.com>
In-Reply-To: <000000000000f9aaa5057e7c9ad5@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 4 Jan 2019 12:12:32 +0100
Message-ID: <CACT4Y+ZzU10rHb8-iLeyD3Js3A7iqR8FwNNzPxHGQeK=W5WgYg@mail.gmail.com>
Subject: Re: BUG: corrupted list in account_entity_enqueue
To:     syzbot <syzbot+14005fa30c9a07192934@syzkaller.appspotmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 2, 2019 at 6:02 PM syzbot
<syzbot+14005fa30c9a07192934@syzkaller.appspotmail.com> wrote:
>
> syzbot has found a reproducer for the following crash on:
>
> HEAD commit:    4cd1b60def51 Add linux-next specific files for 20190102
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=12b12dbf400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3bf665f887bd3d7e
> dashboard link: https://syzkaller.appspot.com/bug?extid=14005fa30c9a07192934
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10621f53400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=154d0427400000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+14005fa30c9a07192934@syzkaller.appspotmail.com

Random manifestation of the stack overflow/corruption:

#syz dup: kernel panic: stack is corrupted in udp4_lib_lookup2

See https://groups.google.com/forum/#!msg/syzkaller-bugs/vr87kmG5qRI/31nOcuVsFgAJ

> list_add corruption. next->prev should be prev (ffff8880ae72d8d8), but was
> 0000000000000610. (next=ffff8880a94b64f0).
> ------------[ cut here ]------------
> kernel BUG at lib/list_debug.c:23!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: -1958513720 Comm:    Not tainted 4.20.0-next-20190102 #2
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:__list_add_valid.cold+0xf/0x3c lib/list_debug.c:23
> Code: 34 fe eb d5 4c 89 e7 e8 3a 82 34 fe eb a3 4c 89 f7 e8 30 82 34 fe e9
> 56 ff ff ff 4c 89 e1 48 c7 c7 40 98 81 88 e8 00 cb d6 fd <0f> 0b 48 89 f2
> 4c 89 e1 4c 89 ee 48 c7 c7 80 99 81 88 e8 e9 ca d6
> RSP: 0018:ffff8880ae707648 EFLAGS: 00010086
> RAX: 0000000000000075 RBX: ffff8880a4783cc0 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffffffff8167d786 RDI: ffffed1015ce0ebb
> RBP: ffff8880ae707660 R08: 0000000000000075 R09: ffffed1015ce5021
> R10: ffffed1015ce5020 R11: ffff8880ae728107 R12: ffff8880a94b64f0
> R13: ffff8880a843a530 R14: ffff8880ae7076e8 R15: ffff8880a843a530
> FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000068 CR3: 00000000a43c7000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <IRQ>
>   __list_add include/linux/list.h:60 [inline]
>   list_add include/linux/list.h:79 [inline]
>   account_entity_enqueue+0x3a0/0x660 kernel/sched/fair.c:2678
>   enqueue_entity+0x276/0x20b0 kernel/sched/fair.c:3902
>   enqueue_task_fair+0x237/0x10c0 kernel/sched/fair.c:5133
>   enqueue_task kernel/sched/core.c:730 [inline]
>   activate_task+0x11d/0x470 kernel/sched/core.c:751
>   ttwu_activate kernel/sched/core.c:1643 [inline]
>   ttwu_do_activate+0xd4/0x1f0 kernel/sched/core.c:1702
>   ttwu_queue kernel/sched/core.c:1847 [inline]
>   try_to_wake_up+0x997/0x1480 kernel/sched/core.c:2057
>   wake_up_process+0x10/0x20 kernel/sched/core.c:2129
>   hrtimer_wakeup+0x48/0x60 kernel/time/hrtimer.c:1637
>   __run_hrtimer kernel/time/hrtimer.c:1389 [inline]
>   __hrtimer_run_queues+0x3a7/0x1050 kernel/time/hrtimer.c:1451
>   hrtimer_interrupt+0x314/0x770 kernel/time/hrtimer.c:1509
>   local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1035 [inline]
>   smp_apic_timer_interrupt+0x18d/0x760 arch/x86/kernel/apic/apic.c:1060
>   apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:807
>   </IRQ>
> Modules linked in:
> ---[ end trace 21a00246ce9209ce ]---
> RIP: 0010:__list_add_valid.cold+0xf/0x3c lib/list_debug.c:23
> Code: 34 fe eb d5 4c 89 e7 e8 3a 82 34 fe eb a3 4c 89 f7 e8 30 82 34 fe e9
> 56 ff ff ff 4c 89 e1 48 c7 c7 40 98 81 88 e8 00 cb d6 fd <0f> 0b 48 89 f2
> 4c 89 e1 4c 89 ee 48 c7 c7 80 99 81 88 e8 e9 ca d6
> RSP: 0018:ffff8880ae707648 EFLAGS: 00010086
> RAX: 0000000000000075 RBX: ffff8880a4783cc0 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffffffff8167d786 RDI: ffffed1015ce0ebb
> RBP: ffff8880ae707660 R08: 0000000000000075 R09: ffffed1015ce5021
> R10: ffffed1015ce5020 R11: ffff8880ae728107 R12: ffff8880a94b64f0
> R13: ffff8880a843a530 R14: ffff8880ae7076e8 R15: ffff8880a843a530
> FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000068 CR3: 00000000a43c7000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000f9aaa5057e7c9ad5%40google.com.
> For more options, visit https://groups.google.com/d/optout.
