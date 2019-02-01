Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D77C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3708B2086C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="btqkFKuP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730227AbfBAPwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:52:46 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:35272 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727743AbfBAPwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 10:52:46 -0500
Received: by mail-it1-f195.google.com with SMTP id p197so10444600itp.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 07:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wdqHgkaD2n2HoY8SHW31dYYHfwAxon77dALfLwqq4/w=;
        b=btqkFKuPqnwlx/n8VfyPYvpBGs27bzST1oBfyb5q5+werSQBSMwDWYwC5UUy5Tk5OP
         RIta0liBO3eHINDpL4mD94lnJJ0UmtkGeP4zL+BhF19AeC86n6OF4O4MsuChIBNbwJ0c
         BEfoc4aoMkTVHGga/pMeiuh+B+x/TF1RfMJk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wdqHgkaD2n2HoY8SHW31dYYHfwAxon77dALfLwqq4/w=;
        b=MCuCMYb3fyNu2zx0kTHkhAHlAowcYJg7CYzphUkj3q+UYLqC7DCrBPN2Sb9hul9TFg
         9SnfYBPf8fg6UHuFrCBXt3YZxFUiwhiB7TzXsXahxX8MU1P8imD7490T0H0nOAzSzJD6
         ZMsyBW30Zcj5Eifgm//JV1ecdm0/IPHpYrNPDVhYbJmqgfYiIFD636kR1QUHHxZZ/Two
         zrtVjYl9Xent2knNEwmmZCnJGBFbv/NJGlXlLrKW5aBtKzeF5DqPws6xXP+W/64cPG7w
         mixc0ptIxCZ6wv2wjE/7+sUhmpSLRK4mJjEizkFZhpv/TgbseKq3E5SOnTxsbtPGeiow
         Jq2g==
X-Gm-Message-State: AHQUAuY25FgBkvw+pSMzAO54BPNoc6SzGQHbQEJStod1DG3DNT67/2AH
        L1V+JtNB645GnUOScIThaiEKcQwr6rDhpB6VnGGktQ==
X-Google-Smtp-Source: AHgI3IZdxBWUNlXEf9y3YVJyNKekE9/DBSL7Q3JSDSRFsGCp1LB0d9vrHLcB42PmY2MmMkYrRO0iS3IetmOoVNZQAPE=
X-Received: by 2002:a24:a20e:: with SMTP id j14mr1900748itf.14.1549036364976;
 Fri, 01 Feb 2019 07:52:44 -0800 (PST)
MIME-Version: 1.0
References: <CAJZ5v0gunbCHp_9mDTmtwW1i-_GcXPcjTP48NdV2zv-B6UrD4g@mail.gmail.com>
 <1548869162-6223-1-git-send-email-vincent.guittot@linaro.org>
 <CAJZ5v0gnJ5DKvOO9OcJoMrGYpHfeQBt2Ec0pMW6=2q5aMoFpww@mail.gmail.com>
 <OSBPR01MB210387DEC42870D8E5688CE9B8920@OSBPR01MB2103.jpnprd01.prod.outlook.com>
 <CAKfTPtDNMV+HFsqc9A0VcMHOO=MvxWYZt8XkmWepso7SpfeAqA@mail.gmail.com>
 <OSBPR01MB21031D92553AD16A1F206273B8920@OSBPR01MB2103.jpnprd01.prod.outlook.com>
 <CAKfTPtB9Ke167hQCKB7wgRpDarn_uFmL3B4QnzHhHUGmuhnejA@mail.gmail.com>
In-Reply-To: <CAKfTPtB9Ke167hQCKB7wgRpDarn_uFmL3B4QnzHhHUGmuhnejA@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 1 Feb 2019 16:52:33 +0100
Message-ID: <CAKfTPtBXt3-jn9h4Pur2Xvg3+k0UvPaNAecXdLB7VWMzccjEgA@mail.gmail.com>
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

On Fri, 1 Feb 2019 at 16:48, Vincent Guittot <vincent.guittot@linaro.org> wrote:
>
> On Fri, 1 Feb 2019 at 16:44, Biju Das <biju.das@bp.renesas.com> wrote:
> >
> > Hi Vincent,
> >
> > Thanks for the feedback. Instead of reverting.  I just modified the patch like this and it fixed the issue.
> >
> > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > index 4eaf166..145a182 100644
> > --- a/drivers/base/power/runtime.c
> > +++ b/drivers/base/power/runtime.c
> > @@ -66,7 +66,7 @@ static int rpm_suspend(struct device *dev, int rpmflags);
> >   */
> >  void update_pm_runtime_accounting(struct device *dev)
> >  {
> > -       u64 now = ktime_to_ns(ktime_get());
> > +       u64 now = ktime_get_mono_fast_ns();
> >         u64 delta;
>
> yes.
> This probably also need to be changed in another place
> (pm_runtime_enable) to be safe
> Our email have crossed. I just sent something similar

In fact after more thinking, it's probably better to revert because we
are not sure to be monotonic with ktime_get_mono_fast_ns() which means
that the time account can be negative but this not yet taken into
account. It's part of a clean up patch that was on hold while working
on previous problem

>
>
>
> >
> > regards,
> > Biju
> >
> > > -----Original Message-----
> > > From: linux-renesas-soc-owner@vger.kernel.org <linux-renesas-soc-
> > > owner@vger.kernel.org> On Behalf Of Vincent Guittot
> > > Sent: 01 February 2019 15:29
> > > To: Biju Das <biju.das@bp.renesas.com>
> > > Cc: Rafael J. Wysocki <rafael@kernel.org>; Linux PM <linux-
> > > pm@vger.kernel.org>; Linux Kernel Mailing List <linux-
> > > kernel@vger.kernel.org>; Linux ARM <linux-arm-
> > > kernel@lists.infradead.org>; Linux OMAP Mailing List <linux-
> > > omap@vger.kernel.org>; Rafael J. Wysocki <rjw@rjwysocki.net>; Ulf
> > > Hansson <ulf.hansson@linaro.org>; Geert Uytterhoeven <geert@linux-
> > > m68k.org>; Linux-Renesas <linux-renesas-soc@vger.kernel.org>
> > > Subject: Re: [PATCH v3] PM-runtime: fix deadlock with ktime
> > >
> > > On Fri, 1 Feb 2019 at 16:02, Biju Das <biju.das@bp.renesas.com> wrote:
> > > >
> > > > Hi Vincent,
> > > >
> > > > I have rebased my kernel to "next-20190201".  Still I am seeing dead lock.
> > > >
> > > > Am I missing any patch?
> > >
> > > No you don't miss anything.
> > > I think that it's the opposite.
> > >
> > > Modification in time accounting in PM runtime has been queued but it has
> > > not moved (yet) to ktime_get_mono_fast_ns()
> > >
> > > Can you try to revert c669560be6c8 ("PM-runtime: Replace jiffies-based
> > > accounting with ktime-based accounting") ?
> > >
> > > >
> > > > root@ek874:/# echo e61e0000.timer >
> > > > /sys/devices/system/clocksource/clocksource0/current_clocksource
> > > > [  193.869423]
> > > > [  193.870963] ============================================
> > > > [  193.876292] WARNING: possible recursive locking detected [
> > > > 193.881625] 5.0.0-rc4-next-20190201-00007-g731346f #3 Not tainted [
> > > > 193.887737] --------------------------------------------
> > > > [  193.893066] migration/0/11 is trying to acquire lock:
> > > > [  193.898136] (____ptrval____) (tk_core.seq){----}, at:
> > > > update_pm_runtime_accounting+0x14/0x68
> > > > [  193.906632]
> > > > [  193.906632] but task is already holding lock:
> > > > [  193.912483] (____ptrval____) (tk_core.seq){----}, at:
> > > > multi_cpu_stop+0x8c/0x140 [  193.919828] [  193.919828] other info
> > > > that might help us debug this:
> > > > [  193.926377]  Possible unsafe locking scenario:
> > > > [  193.926377]
> > > > [  193.932314]        CPU0
> > > > [  193.934765]        ----
> > > > [  193.937216]   lock(tk_core.seq);
> > > > [  193.940453]   lock(tk_core.seq);
> > > > [  193.943691]
> > > > [  193.943691]  *** DEADLOCK ***
> > > > [  193.943691]
> > > > [  193.949634]  May be due to missing lock nesting notation [
> > > > 193.949634] [  193.956446] 3 locks held by migration/0/11:
> > > > [  193.960642]  #0: (____ptrval____) (timekeeper_lock){-.-.}, at:
> > > > change_clocksource+0x2c/0x118 [  193.969125]  #1: (____ptrval____)
> > > > (tk_core.seq){----}, at: multi_cpu_stop+0x8c/0x140 [  193.976903]  #2:
> > > > (____ptrval____) (&(&dev->power.lock)->rlock){....}, at:
> > > > __pm_runtime_resume+0x40/0x98 [  193.986339] [  193.986339] stack
> > > backtrace:
> > > > [  193.990715] CPU: 0 PID: 11 Comm: migration/0 Not tainted
> > > > 5.0.0-rc4-next-20190201-00007-g731346f #3 [  193.999707] Hardware
> > > > name: Silicon Linux RZ/G2E evaluation kit EK874 (CAT874 + CAT875) (DT) [
> > > 194.008089] Call trace:
> > > > [  194.010553]  dump_backtrace+0x0/0x178 [  194.014227]
> > > > show_stack+0x14/0x20 [  194.017562]  dump_stack+0xb0/0xec [
> > > > 194.020895]  __lock_acquire+0xfb4/0x1c08 [  194.024832]
> > > > lock_acquire+0xd0/0x268 [  194.028420]  ktime_get+0x5c/0x108 [
> > > > 194.031747]  update_pm_runtime_accounting+0x14/0x68
> > > > [  194.036643]  rpm_resume+0x4ec/0x698 [  194.040144]
> > > > __pm_runtime_resume+0x50/0x98 [  194.044264]
> > > > sh_tmu_enable.part.1+0x24/0x50 [  194.048462]
> > > > sh_tmu_clocksource_enable+0x48/0x70
> > > > [  194.053097]  change_clocksource+0x84/0x118 [  194.057208]
> > > > multi_cpu_stop+0x8c/0x140 [  194.060970]
> > > > cpu_stopper_thread+0xac/0x120 [  194.065087]
> > > > smpboot_thread_fn+0x1ac/0x2c8 [  194.069198]  kthread+0x128/0x130 [
> > > > 194.072439]  ret_from_fork+0x10/0x18
> > > >
> > > >
> > > > Regards,
> > > > Biju
> > > >
> > > > > -----Original Message-----
> > > > > From: Rafael J. Wysocki <rafael@kernel.org>
> > > > > Sent: 30 January 2019 21:53
> > > > > To: Vincent Guittot <vincent.guittot@linaro.org>
> > > > > Cc: Linux PM <linux-pm@vger.kernel.org>; Linux Kernel Mailing List
> > > > > <linux- kernel@vger.kernel.org>; Linux ARM <linux-arm-
> > > > > kernel@lists.infradead.org>; Linux OMAP Mailing List <linux-
> > > > > omap@vger.kernel.org>; Rafael J. Wysocki <rjw@rjwysocki.net>; Ulf
> > > > > Hansson <ulf.hansson@linaro.org>; Biju Das
> > > > > <biju.das@bp.renesas.com>; Geert Uytterhoeven
> > > > > <geert@linux-m68k.org>; Linux-Renesas <linux-
> > > > > renesas-soc@vger.kernel.org>
> > > > > Subject: Re: [PATCH v3] PM-runtime: fix deadlock with ktime
> > > > >
> > > > > On Wed, Jan 30, 2019 at 6:26 PM Vincent Guittot
> > > > > <vincent.guittot@linaro.org> wrote:
> > > > > >
> > > > > > A deadlock has been seen when swicthing clocksources which use PM
> > > > > runtime.
> > > > > > The call path is:
> > > > > > change_clocksource
> > > > > >     ...
> > > > > >     write_seqcount_begin
> > > > > >     ...
> > > > > >     timekeeping_update
> > > > > >         ...
> > > > > >         sh_cmt_clocksource_enable
> > > > > >             ...
> > > > > >             rpm_resume
> > > > > >                 pm_runtime_mark_last_busy
> > > > > >                     ktime_get
> > > > > >                         do
> > > > > >                             read_seqcount_begin
> > > > > >                         while read_seqcount_retry
> > > > > >     ....
> > > > > >     write_seqcount_end
> > > > > >
> > > > > > Although we should be safe because we haven't yet changed the
> > > > > > clocksource at that time, we can't because of seqcount protection.
> > > > > >
> > > > > > Use ktime_get_mono_fast_ns() instead which is lock safe for such
> > > > > > case
> > > > > >
> > > > > > With ktime_get_mono_fast_ns, the timestamp is not guaranteed to be
> > > > > > monotonic across an update and as a result can goes backward.
> > > > > > According to
> > > > > > update_fast_timekeeper() description: "In the worst case, this can
> > > > > > result is a slightly wrong timestamp (a few nanoseconds)". For PM
> > > > > > runtime autosuspend, this means only that the suspend decision can
> > > > > > be slightly sub optimal.
> > > > > >
> > > > > > Fixes: 8234f6734c5d ("PM-runtime: Switch autosuspend over to using
> > > > > > hrtimers")
> > > > > > Reported-by: Biju Das <biju.das@bp.renesas.com>
> > > > > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > > > > ---
> > > > > >
> > > > > > Hi Rafael,
> > > > > >
> > > > > > Sorry, I sent the version with the typo mistake that generated the
> > > > > > compilation error reported by kbuild-test-robot
> > > > > >
> > > > > > This version doesn't have the typo.
> > > > >
> > > > > OK, I've applied this one, thanks!
> > > >
> > > >
> > > >
> > > > Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne
> > > End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under
> > > Registered No. 04586709.
> >
> >
> >
> > Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
