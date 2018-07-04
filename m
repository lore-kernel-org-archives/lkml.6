Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2D9C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 421BA23CFD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VYnXJAh1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 421BA23CFD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752709AbeGDQfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 12:35:16 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:40363 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752484AbeGDQfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 12:35:14 -0400
Received: by mail-pf0-f196.google.com with SMTP id z24-v6so3060688pfe.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 09:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=myO/QZwCrnC1kg5KnsI+y2OFMsoDaVMHDRRxUEtkV3A=;
        b=VYnXJAh1QApNVVanNKTiWygR1k8nRTM132DowC7YoMYqFPG6b2+acyoUguNdScOQuo
         mIzP34kanuCVbMcBN6OdU/Yd3Iv9z5nVz2XNg0CYQ1+tNsfCgMdLRtas2kG7t8/s8fg5
         AFA7kwvKwL2F3zzxkBOjgAhf1DOUn6h+oeiKQRXiKCHs+WNqKmixAnY/lmAD750xO4Ud
         CAjxY+7Wp1YCWMbDzoJmT4W11rEqdeVmuwVkrc68/TIE+dOH292xVm3AGBSxC1P01iTg
         uD+33OwlYOMQDKviwxLX6BjAc9iTvPINkSswIZqIUu6kJ/eTuY4Gh0ol5L1RFDEYF/FT
         RhFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=myO/QZwCrnC1kg5KnsI+y2OFMsoDaVMHDRRxUEtkV3A=;
        b=hHvBfRb3UtaddxfekiengT8vpBmg4ka6eAUVaP8Op12xnjGeobKCCg33b49CbtdhQw
         dATP2ASHnmpdH31ew1p+tUyxGzhebGJ3wH+3lItNNVFGv4Nz+eWvv+qW4U+u0FPPQB5o
         fDDaRFQNd87vgXahmnkc8VoY/Yd7mxdt/hz44cCFOuODjFzHuAYXnNoco5mHu7+nEc5u
         4bTsA2ih1Muboeqd9xDWPLG1GSiwkFFj8a3tpUmr+pHYLo1IxPXrUmTc4mvPu19Do+hZ
         qFyFDo0NQxOzJr4if6hfX6WIK6HShxrzjgXIXt/uT7kkIrxqPLvsLNLAOBCooonPXFnz
         whJg==
X-Gm-Message-State: APt69E2Fly9rfKNvOV6K2XeK2fFueeEMEke4t31hXKJcV8jv4wqQGGF6
        xtI2y5DLaoo5dNxIApwQ6L085NQh8Z2lFJ4ZzO6afCa02NM=
X-Google-Smtp-Source: AAOMgpfovOczh5vlG+V/gvsWhbb6fu7ruxgr4q1PMuYtZmN18nV7LENTfNYOtQzwv2trfAymUE5nH0dkN31EBwZeyxI=
X-Received: by 2002:a62:4a41:: with SMTP id x62-v6mr1057288pfa.45.1530722113071;
 Wed, 04 Jul 2018 09:35:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Wed, 4 Jul 2018 09:34:52
 -0700 (PDT)
In-Reply-To: <000000000000b2989805702eedd3@google.com>
References: <000000000000b2989805702eedd3@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 4 Jul 2018 18:34:52 +0200
Message-ID: <CACT4Y+b0fysS3D4QCcfw5X-rFt3c1a7XAHntN4Q7p9tdHNCuow@mail.gmail.com>
Subject: Re: KASAN: stack-out-of-bounds Read in timerqueue_add
To:     syzbot <syzbot+b680e42077a0d7c9a0c4@syzkaller.appspotmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 6:29 PM, syzbot
<syzbot+b680e42077a0d7c9a0c4@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    fc36def997cf mm: teach dump_page() to correctly output poi..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=167e3b92400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f62553dc846b0692
> dashboard link: https://syzkaller.appspot.com/bug?extid=b680e42077a0d7c9a0c4
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=1030a858400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1167aaa4400000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+b680e42077a0d7c9a0c4@syzkaller.appspotmail.com

+bpf maintainers since the repro seems to deal to bpf maps

We've got a splash of crashes today, all seem to suggest some kind of
stack corruption/overflow, see the last 6 bugs here:
https://syzkaller.appspot.com/



> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> IPVS: ftp: loaded support on port[0] = 21
> ==================================================================
> BUG: KASAN: stack-out-of-bounds in timerqueue_add+0x249/0x2b0
> lib/timerqueue.c:52
> Read of size 8 at addr ffff8801af537cf8 by task syz-executor591/7178
>
> CPU: 0 PID: 7178 Comm: syz-executor591 Not tainted 4.18.0-rc3+ #130
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
>  print_address_description+0x6c/0x20b mm/kasan/report.c:256
>  kasan_report_error mm/kasan/report.c:354 [inline]
>  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
>  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
>  timerqueue_add+0x249/0x2b0 lib/timerqueue.c:52
>  enqueue_hrtimer+0x18e/0x540 kernel/time/hrtimer.c:960
>  __run_hrtimer kernel/time/hrtimer.c:1413 [inline]
>  __hrtimer_run_queues+0xc07/0x10c0 kernel/time/hrtimer.c:1460
>  hrtimer_interrupt+0x2f3/0x750 kernel/time/hrtimer.c:1518
>  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1025 [inline]
>  smp_apic_timer_interrupt+0x165/0x730 arch/x86/kernel/apic/apic.c:1050
>  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:863
>  </IRQ>
>
> The buggy address belongs to the page:
> page:ffffea0006bd4dc0 count:0 mapcount:0 mapping:0000000000000000 index:0x0
> flags: 0x2fffc0000000000()
> raw: 02fffc0000000000 0000000000000000 ffffffff06bd0101 0000000000000000
> raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>  ffff8801af537b80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffff8801af537c00: 00 00 00 00 f1 f1 f1 f1 00 f2 f2 f2 f2 f2 f2 f2
>>
>> ffff8801af537c80: 00 f2 f2 f2 f2 f2 f2 f2 00 f2 f2 f2 f2 f2 f2 f2
>
>                                                                 ^
>  ffff8801af537d00: f8 f2 f2 f2 f2 f2 f2 f2 00 f2 f2 f2 00 00 00 00
>  ffff8801af537d80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ==================================================================
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
> https://groups.google.com/d/msgid/syzkaller-bugs/000000000000b2989805702eedd3%40google.com.
> For more options, visit https://groups.google.com/d/optout.
