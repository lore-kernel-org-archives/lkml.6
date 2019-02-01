Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3AD2C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8859421901
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gClI8gB5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730202AbfBAP3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:29:07 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:45029 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728316AbfBAP3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 10:29:07 -0500
Received: by mail-io1-f68.google.com with SMTP id r200so5948912iod.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 07:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uYKc9GV/4uCJsaJYgvdgE+UUlXO7kvvSTACKVVKdeEU=;
        b=gClI8gB5sXKGUTrc4Umfpr9L3RkHZb7r/U34ZyDlWsq9cBUeK3gw/O+Zod6ppjd8/O
         QgPqMHJ/wXVYQQpJctIrTdIdMdak5H1CjwXJvTg6wMGTvGkzPkbMCrVkd5489Qb9D52B
         f2ANrunklqX7yRGg/smX1a/P3MclaQBp1y+z0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uYKc9GV/4uCJsaJYgvdgE+UUlXO7kvvSTACKVVKdeEU=;
        b=Lps9bSAZ3LvE62ZwlAyuOLzm9hshUdHQtkMJAhfJ8zgmkMzw0OMeNOwxppL+5kkGwq
         Gk4aWliNww/hfj5HjU/9M9M6fOisQqYRgbW6z8sQrpCoczX00LMnMkjSnUfy0UgWEZkY
         n+WC8YDK1+4D+8TL8fpM3S4/S2YjbHaavavvIwG67JCUHPYtOfjSCz4/Q7fRbBFCHuqO
         mqne64JfwUy38qEgJCMqJWZPIsMfF+fc5/JCbXapeAc4+7UnHjqBP5I9tSnsNXBKCoBD
         F6ufU8bdOUSHame0Z8elUx0ZQS98Qvm1ZA+VxPEEmtaT3qZbxMGZ+fg2RaWXanof1hqT
         LHtg==
X-Gm-Message-State: AHQUAuZ/b+s/HSRaeFHZBznOvSwT6F2TnjkiIXVDshmnJ8rw5F+EhnHr
        c9TFNSXMHzpOfJsti6HvdNBJgqi27FReOFCCFULZsg==
X-Google-Smtp-Source: AHgI3IZYLv9yZWEvhp1o6Pj4fxsF+K3xGXgAWckOMz6MVhkiR0dg7Tm6iQPvfGv6HDWKUxS90rDkP1n4smkpzzBuiBg=
X-Received: by 2002:a6b:c8c9:: with SMTP id y192mr22069631iof.183.1549034945923;
 Fri, 01 Feb 2019 07:29:05 -0800 (PST)
MIME-Version: 1.0
References: <CAJZ5v0gunbCHp_9mDTmtwW1i-_GcXPcjTP48NdV2zv-B6UrD4g@mail.gmail.com>
 <1548869162-6223-1-git-send-email-vincent.guittot@linaro.org>
 <CAJZ5v0gnJ5DKvOO9OcJoMrGYpHfeQBt2Ec0pMW6=2q5aMoFpww@mail.gmail.com> <OSBPR01MB210387DEC42870D8E5688CE9B8920@OSBPR01MB2103.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB210387DEC42870D8E5688CE9B8920@OSBPR01MB2103.jpnprd01.prod.outlook.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 1 Feb 2019 16:28:54 +0100
Message-ID: <CAKfTPtDNMV+HFsqc9A0VcMHOO=MvxWYZt8XkmWepso7SpfeAqA@mail.gmail.com>
Subject: Re: [PATCH v3] PM-runtime: fix deadlock with ktime
To:     Biju Das <biju.das@bp.renesas.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Feb 2019 at 16:02, Biju Das <biju.das@bp.renesas.com> wrote:
>
> Hi Vincent,
>
> I have rebased my kernel to "next-20190201".  Still I am seeing dead lock.
>
> Am I missing any patch?

No you don't miss anything.
I think that it's the opposite.

Modification in time accounting in PM runtime has been queued but it
has not moved (yet) to ktime_get_mono_fast_ns()

Can you try to revert c669560be6c8 ("PM-runtime: Replace jiffies-based
accounting with ktime-based accounting") ?

>
> root@ek874:/# echo e61e0000.timer > /sys/devices/system/clocksource/clocksource0/current_clocksource
> [  193.869423]
> [  193.870963] ============================================
> [  193.876292] WARNING: possible recursive locking detected
> [  193.881625] 5.0.0-rc4-next-20190201-00007-g731346f #3 Not tainted
> [  193.887737] --------------------------------------------
> [  193.893066] migration/0/11 is trying to acquire lock:
> [  193.898136] (____ptrval____) (tk_core.seq){----}, at: update_pm_runtime_accounting+0x14/0x68
> [  193.906632]
> [  193.906632] but task is already holding lock:
> [  193.912483] (____ptrval____) (tk_core.seq){----}, at: multi_cpu_stop+0x8c/0x140
> [  193.919828]
> [  193.919828] other info that might help us debug this:
> [  193.926377]  Possible unsafe locking scenario:
> [  193.926377]
> [  193.932314]        CPU0
> [  193.934765]        ----
> [  193.937216]   lock(tk_core.seq);
> [  193.940453]   lock(tk_core.seq);
> [  193.943691]
> [  193.943691]  *** DEADLOCK ***
> [  193.943691]
> [  193.949634]  May be due to missing lock nesting notation
> [  193.949634]
> [  193.956446] 3 locks held by migration/0/11:
> [  193.960642]  #0: (____ptrval____) (timekeeper_lock){-.-.}, at: change_clocksource+0x2c/0x118
> [  193.969125]  #1: (____ptrval____) (tk_core.seq){----}, at: multi_cpu_stop+0x8c/0x140
> [  193.976903]  #2: (____ptrval____) (&(&dev->power.lock)->rlock){....}, at: __pm_runtime_resume+0x40/0x98
> [  193.986339]
> [  193.986339] stack backtrace:
> [  193.990715] CPU: 0 PID: 11 Comm: migration/0 Not tainted 5.0.0-rc4-next-20190201-00007-g731346f #3
> [  193.999707] Hardware name: Silicon Linux RZ/G2E evaluation kit EK874 (CAT874 + CAT875) (DT)
> [  194.008089] Call trace:
> [  194.010553]  dump_backtrace+0x0/0x178
> [  194.014227]  show_stack+0x14/0x20
> [  194.017562]  dump_stack+0xb0/0xec
> [  194.020895]  __lock_acquire+0xfb4/0x1c08
> [  194.024832]  lock_acquire+0xd0/0x268
> [  194.028420]  ktime_get+0x5c/0x108
> [  194.031747]  update_pm_runtime_accounting+0x14/0x68
> [  194.036643]  rpm_resume+0x4ec/0x698
> [  194.040144]  __pm_runtime_resume+0x50/0x98
> [  194.044264]  sh_tmu_enable.part.1+0x24/0x50
> [  194.048462]  sh_tmu_clocksource_enable+0x48/0x70
> [  194.053097]  change_clocksource+0x84/0x118
> [  194.057208]  multi_cpu_stop+0x8c/0x140
> [  194.060970]  cpu_stopper_thread+0xac/0x120
> [  194.065087]  smpboot_thread_fn+0x1ac/0x2c8
> [  194.069198]  kthread+0x128/0x130
> [  194.072439]  ret_from_fork+0x10/0x18
>
>
> Regards,
> Biju
>
> > -----Original Message-----
> > From: Rafael J. Wysocki <rafael@kernel.org>
> > Sent: 30 January 2019 21:53
> > To: Vincent Guittot <vincent.guittot@linaro.org>
> > Cc: Linux PM <linux-pm@vger.kernel.org>; Linux Kernel Mailing List <linux-
> > kernel@vger.kernel.org>; Linux ARM <linux-arm-
> > kernel@lists.infradead.org>; Linux OMAP Mailing List <linux-
> > omap@vger.kernel.org>; Rafael J. Wysocki <rjw@rjwysocki.net>; Ulf
> > Hansson <ulf.hansson@linaro.org>; Biju Das <biju.das@bp.renesas.com>;
> > Geert Uytterhoeven <geert@linux-m68k.org>; Linux-Renesas <linux-
> > renesas-soc@vger.kernel.org>
> > Subject: Re: [PATCH v3] PM-runtime: fix deadlock with ktime
> >
> > On Wed, Jan 30, 2019 at 6:26 PM Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> > >
> > > A deadlock has been seen when swicthing clocksources which use PM
> > runtime.
> > > The call path is:
> > > change_clocksource
> > >     ...
> > >     write_seqcount_begin
> > >     ...
> > >     timekeeping_update
> > >         ...
> > >         sh_cmt_clocksource_enable
> > >             ...
> > >             rpm_resume
> > >                 pm_runtime_mark_last_busy
> > >                     ktime_get
> > >                         do
> > >                             read_seqcount_begin
> > >                         while read_seqcount_retry
> > >     ....
> > >     write_seqcount_end
> > >
> > > Although we should be safe because we haven't yet changed the
> > > clocksource at that time, we can't because of seqcount protection.
> > >
> > > Use ktime_get_mono_fast_ns() instead which is lock safe for such case
> > >
> > > With ktime_get_mono_fast_ns, the timestamp is not guaranteed to be
> > > monotonic across an update and as a result can goes backward.
> > > According to
> > > update_fast_timekeeper() description: "In the worst case, this can
> > > result is a slightly wrong timestamp (a few nanoseconds)". For PM
> > > runtime autosuspend, this means only that the suspend decision can be
> > > slightly sub optimal.
> > >
> > > Fixes: 8234f6734c5d ("PM-runtime: Switch autosuspend over to using
> > > hrtimers")
> > > Reported-by: Biju Das <biju.das@bp.renesas.com>
> > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > ---
> > >
> > > Hi Rafael,
> > >
> > > Sorry, I sent the version with the typo mistake that generated the
> > > compilation error reported by kbuild-test-robot
> > >
> > > This version doesn't have the typo.
> >
> > OK, I've applied this one, thanks!
>
>
>
> Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
