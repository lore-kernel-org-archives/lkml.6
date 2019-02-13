Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E3AC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55B0721905
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R/pqI1nb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731301AbfBMDk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 22:40:29 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:38475 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbfBMDk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 22:40:29 -0500
Received: by mail-vs1-f66.google.com with SMTP id t7so571008vsq.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 19:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tPnpFiBczWJvHzGyfFeMJhYr2Iapj4G+lIhpm0mD5jk=;
        b=R/pqI1nb4u1R9bcySiJ5WyXywnofO2nCSOvZUTNu9WNLX/pZrrREYo9cgXtBDbD5M5
         4zoiobJv1fd2ZYDjcrTNTEdYEGFHdXhihg6tk6JCvHiSuTZc9TwNS6KyId8HzlqTNPx1
         4WCuIhDxV8CCQaEPJS8P4fFzBUcUkV05Wo4oc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tPnpFiBczWJvHzGyfFeMJhYr2Iapj4G+lIhpm0mD5jk=;
        b=ZjJNSqhdhGcgDgIor6KLSBsqyPSjMPaMW0oEfHbSoqDtDgpqo5/8b+/PZTbVqj+/Ea
         kX30jDugXZBzyPnD9069M0LsN6/xcV+nMhDobA2Nrjpy6+i9AZvsORyH77yYys2qNyOn
         ti/1jFt63fn7GQVslt3Btk3v3X+vXjAQZcB/hUIrpu9m5h699VSP35ODhZakAMSnPcih
         rvWBJlXVOW/EwUMdGskgd3OzncgRcdZDT7N2hdq+wENpB/5GOk9hZM4T41CPTQ7z4zP6
         AmQf9Qn6WiUUKhHghU7lwkRYcsM0uMQd5K/sTck5/tW1gjvJuNxHtTdHQEif1sg6Q8Pe
         ZR8Q==
X-Gm-Message-State: AHQUAuYk4dUTXo766X5NhHOqqpMSHfelXUR4P0iwbzAB1KssIjjRLdcB
        gUBOmuoamsDjiQwQVUXCcLcVlgt3uS0=
X-Google-Smtp-Source: AHgI3IaDjXttxLKc5IUKqIjKltZltAy11X99vxiMMBCxIoRS6usO+UwVZE4Ajw892mt2qW0NIcCSUw==
X-Received: by 2002:a67:c907:: with SMTP id w7mr2949343vsk.98.1550029226677;
        Tue, 12 Feb 2019 19:40:26 -0800 (PST)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id j95sm11565340uad.6.2019.02.12.19.40.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 19:40:25 -0800 (PST)
Received: by mail-vs1-f46.google.com with SMTP id k11so597489vsm.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 19:40:25 -0800 (PST)
X-Received: by 2002:a67:c00a:: with SMTP id v10mr3109904vsi.66.1550029224570;
 Tue, 12 Feb 2019 19:40:24 -0800 (PST)
MIME-Version: 1.0
References: <001a1140589435c9b60563c76e3f@google.com> <CACT4Y+bVG7eoLWndM3McQpf3FN+JxEm9Xyrg0H0gg6UiUFC62A@mail.gmail.com>
 <CAGXu5jJ-+P+p_SsO1X-LJ43RbEG2cYbiV_EYubWoh3mUVRBK9A@mail.gmail.com> <20190212211449.5f48bee1@gandalf.local.home>
In-Reply-To: <20190212211449.5f48bee1@gandalf.local.home>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 12 Feb 2019 19:40:12 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+Z=ns37DdNU-mYtfio1cW4c25jyAGwFx74YFXKM5SD1A@mail.gmail.com>
Message-ID: <CAGXu5j+Z=ns37DdNU-mYtfio1cW4c25jyAGwFx74YFXKM5SD1A@mail.gmail.com>
Subject: Re: WARNING in event_function_local
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+352bd10e338d9a90e5e0@syzkaller.appspotmail.com>,
        Abderrahmane Benbachir <abderrahmane.benbachir@polymtl.ca>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 6:14 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> On Tue, 12 Feb 2019 17:27:56 -0800
> Kees Cook <keescook@chromium.org> wrote:
>
> > On Wed, May 9, 2018 at 10:18 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > >
> > > On Sat, Jan 27, 2018 at 8:58 PM, syzbot
> > > <syzbot+352bd10e338d9a90e5e0@syzkaller.appspotmail.com> wrote:
> > > > Hello,
> > > >
> > > > syzbot hit the following crash on bpf-next commit
> > > > 8223967fe0b8eb2448cca5cfe3c64a0838e6f60d (Sat Jan 27 01:06:23 2018 +0000)
> > > > Merge branch 'fix-lpm-map'
> > > >
> > > > So far this crash happened 2 times on bpf-next.
> > > > C reproducer is attached.
> > > > syzkaller reproducer is attached.
> > > > Raw console output is attached.
> > > > compiler: gcc (GCC) 7.1.1 20170620
> > > > .config is attached.
> > > >
> > > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > > Reported-by: syzbot+352bd10e338d9a90e5e0@syzkaller.appspotmail.com
> > > > It will help syzbot understand when the bug is fixed. See footer for
> > > > details.
> > > > If you forward the report, please keep this part and the footer.
> > >
> > >
> > > This was bisected to:
> > >
> > > commit 4ee7c60de83ac01fa4c33c55937357601631e8ad
> > > Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > > Date:   Fri Mar 23 10:18:03 2018 -0400
> > >
> > >     init, tracing: Add initcall trace events
> > >
> > >
> > >
> > > > WARNING: CPU: 1 PID: 5105 at kernel/events/core.c:331
> > > > event_function_local.constprop.102+0x494/0x560 kernel/events/core.c:331
> > > > Kernel panic - not syncing: panic_on_warn set ...
> > > >
> > > > CPU: 1 PID: 5105 Comm: syzkaller318382 Not tainted 4.15.0-rc8+ #8
> > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > > > Google 01/01/2011
> > > > Call Trace:
> > > >  <IRQ>
> > > >  __dump_stack lib/dump_stack.c:17 [inline]
> > > >  dump_stack+0x194/0x257 lib/dump_stack.c:53
> > > >  panic+0x1e4/0x41c kernel/panic.c:183
> > > >  __warn+0x1dc/0x200 kernel/panic.c:547
> > > >  report_bug+0x211/0x2d0 lib/bug.c:184
> > > >  fixup_bug.part.11+0x37/0x80 arch/x86/kernel/traps.c:178
> > > >  fixup_bug arch/x86/kernel/traps.c:247 [inline]
> > > >  do_error_trap+0x2d7/0x3e0 arch/x86/kernel/traps.c:296
> > > >  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:315
> > > >  invalid_op+0x22/0x40 arch/x86/entry/entry_64.S:1096
> > > > RIP: 0010:event_function_local.constprop.102+0x494/0x560
> > > > kernel/events/core.c:331
> > > > RSP: 0018:ffff8801db307d00 EFLAGS: 00010006
> > > > RAX: ffff8801d902a180 RBX: ffff8801d60beac0 RCX: ffffffff81862a54
> > > > RDX: 0000000000010000 RSI: ffff8801db3079f0 RDI: ffff8801d60bebc8
> > > > RBP: ffff8801db307da0 R08: 1ffff1003b660edf R09: 000000000000000c
> > > > R10: ffff8801db307bb8 R11: 0000000000000044 R12: ffff8801db330e00
> > > > R13: 1ffff1003b660fa3 R14: ffff8801d90841c0 R15: ffff8801d979ce40
> > > >  perf_event_disable_local kernel/events/core.c:1979 [inline]
> > > >  perf_pending_event+0x1e5/0x240 kernel/events/core.c:5446
> > > >  irq_work_run_list+0x184/0x240 kernel/irq_work.c:155
> > > >  irq_work_run+0x1d/0x50 kernel/irq_work.c:170
> > > >  smp_irq_work_interrupt+0x103/0x640 arch/x86/kernel/irq_work.c:21
> > > >  irq_work_interrupt+0xa9/0xb0 arch/x86/entry/entry_64.S:968
> > > >  </IRQ>
> >
> > I got curious why this report went silent, and bisected the "fix" to:
>
> It's still tagged as "TODO" in my INBOX, along with 1000 other emails
> tagged with TODO :-p

Totally understood. I went to go try to tackle this because it's one
of the weird "super easy to reproduce for half a year then suddenly
went silent" bugs that didn't have an obvious fix that went in.

>
> > Steve, what could possibly be happening here? Just adding more
> > tracepoints causes some kind of race where the task vs current test
> > trips in event_function_local():
> >
> >                         if (WARN_ON_ONCE(task != current))
> >                                 goto unlock;
>
> That's perf code. How are you getting there? What's special about this
> run? You have perf running?

Yes, the reproducer is in an 8-way parallel tight loop, doing:

  fd = syscall(__NR_perf_event_open, 0x20000140, 0, 0, -1, 0);
  syscall(__NR_ioctl, fd, 0x2402, 0x100000001);

I haven't decoded the structures that are passed in, but I'm at a loss
for how changing how many trace entries there are could impact the
race timing... O_o

> > Is this maybe just an unlucky condition with the event loop running in
> > an IRQ? Should the WARN be expected, or is running under an IRQ
> > unexpected?

Is perf expected to fire during an IRQ? The task == current test seems
suspicious if so...

-- 
Kees Cook
