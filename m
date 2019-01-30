Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB004C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 895A720989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZdFh7+Lh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730462AbfA3Jl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:41:29 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:55808 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728298AbfA3Jl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:41:28 -0500
Received: by mail-it1-f194.google.com with SMTP id m62so9229148ith.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 01:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8p9guxdW2dSYDedRw8V3sEOTdwxjxH/BsBrvfgqOjy8=;
        b=ZdFh7+Lhxhub53RHgUUM9RREUxH4vj+Bk6LWu3q71VlW0oV46Fr0Tf22AWvvePQ0fc
         jTZr3dpWZcPFH+74QeiIL9IHAwIsVqyU8O76Oxe3KTsDayGHhUbj4ZIhZWeHD3djGZMZ
         CD6SgSyevqgMvsMsyRDw+Iu8D+IKMHS42eb3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8p9guxdW2dSYDedRw8V3sEOTdwxjxH/BsBrvfgqOjy8=;
        b=hSG+j1KtGdWclDWdqlVPfPcJpFMgTxnraPrihlQIY7ljxdJ8OZ2CtWkwFwxXcQpG3n
         c0p+QakN7uY2LW+cj+YfI4O+h3AqTivaWdxcYx0SyKk1zLcjAlbcQ46i6ZG0Gq+DfgtK
         iEzol5Bsiml+XrEIJapUleG4ri+0pBbv7xjCPYY56XZCWWySETLXTQIcutuOl9yZdAQ4
         Tjxsdp4bYNAQDhXKk0Pwh5/np49mgsMbsc9I8ZJL7NfGFwNozz306yc9Cuzola1wpQ+X
         w14J/y+NwwmE4g4Hz2ztLw8oo1iAY6S6k8l8LXXeRSGly6gGUQ6+lFKSHV636FIBEA8I
         +WkA==
X-Gm-Message-State: AJcUukfoim6radLpQ9X21boQdGqjcdyx9PXQu83wzDKThS/T9jPiIpFp
        TI8Y4ZshoyKQXpSEHsXAkL/LTmodoVDdD00DQDl1aQ==
X-Google-Smtp-Source: ALg8bN5wn920FaduALkeh2LPYs0Nvrhp5D8Zd6duGp1ooTD7vwwPGF+V+15A3oTd8AWgW0wQ80vD2es1aExkzfw/aiI=
X-Received: by 2002:a02:7f08:: with SMTP id r8mr15823080jac.20.1548841287480;
 Wed, 30 Jan 2019 01:41:27 -0800 (PST)
MIME-Version: 1.0
References: <1548836194-15264-1-git-send-email-vincent.guittot@linaro.org>
 <CAMuHMdWYV-tDD2osdvs4yhD-mu2n8-JSC7rV8Zt5vW4kr8hdWQ@mail.gmail.com>
 <CAKfTPtBiWunvVHv=tpq7CPqAX+54d_dyPt6BME_m1_Wz+qPaTA@mail.gmail.com> <CAJZ5v0jLJ8Tu7Gpt-4bhW59Q3=PX4wyb2rFBWuPKMFHcFXBxAA@mail.gmail.com>
In-Reply-To: <CAJZ5v0jLJ8Tu7Gpt-4bhW59Q3=PX4wyb2rFBWuPKMFHcFXBxAA@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 30 Jan 2019 10:41:16 +0100
Message-ID: <CAKfTPtD+Yd7fBw=PhnedYmkGGW-JhNiZ739B-8YD7pFJEe9wig@mail.gmail.com>
Subject: Re: [PATCH] PM-runtime: fix deadlock with ktime
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:TI ETHERNET SWITCH DRIVER (CPSW)" 
        <linux-omap@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Biju Das <biju.das@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2019 at 10:39, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Jan 30, 2019 at 10:14 AM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > Hi Geert,
> >
> > On Wed, 30 Jan 2019 at 09:21, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > >
> > > Hi Vincent,
> > >
> > > On Wed, Jan 30, 2019 at 9:16 AM Vincent Guittot
> > > <vincent.guittot@linaro.org> wrote:
> > > > A deadlock has been seen when swicthing clocksources which use PM runtime.
> > > > The call path is:
> > > > change_clocksource
> > > >     ...
> > > >     write_seqcount_begin
> > > >     ...
> > > >     timekeeping_update
> > > >         ...
> > > >         sh_cmt_clocksource_enable
> > > >             ...
> > > >             rpm_resume
> > > >                 pm_runtime_mark_last_busy
> > > >                     ktime_get
> > > >                         do
> > > >                             read_seqcount_begin
> > > >                         while read_seqcount_retry
> > > >     ....
> > > >     write_seqcount_end
> > > >
> > > > Although we should be safe because we haven't yet changed the clocksource
> > > > at that time, we can't because of seqcount protection.
> > > >
> > > > Use ktime_get_mono_fast_ns instead which is lock safe for such case
> > > >
> > > > Fixes: 8234f6734c5d ("PM-runtime: Switch autosuspend over to using hrtimers")
> > > > Reported-by: Biju Das <biju.das@bp.renesas.com>
> > > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > >
> > > Thanks for your patch!
> > >
> > > /**
> > >  * ktime_get_mono_fast_ns - Fast NMI safe access to clock monotonic
> > >  *
> > >  * This timestamp is not guaranteed to be monotonic across an update.
> > >  * The timestamp is calculated by:
> > >  *
> > >  *      now = base_mono + clock_delta * slope
> > >  *
> > >  * So if the update lowers the slope, readers who are forced to the
> > >  * not yet updated second array are still using the old steeper slope.
> > >  *
> > >  * tmono
> > >  * ^
> > >  * |    o  n
> > >  * |   o n
> > >  * |  u
> > >  * | o
> > >  * |o
> > >  * |12345678---> reader order
> > >  *
> > >  * o = old slope
> > >  * u = update
> > >  * n = new slope
> > >  *
> > >  * So reader 6 will observe time going backwards versus reader 5.
> > >  *
> > >  * While other CPUs are likely to be able observe that, the only way
> > >  * for a CPU local observation is when an NMI hits in the middle of
> > >  * the update. Timestamps taken from that NMI context might be ahead
> > >  * of the following timestamps. Callers need to be aware of that and
> > >  * deal with it.
> > >  */
> > >
> > > As this function is not guaranteed to be monotonic, have you checked how
> > > the Runtime PM code behaves if time goes backwards? Does it just make
> > > a suboptimal decision or does it crash?
> >
> > As a worst case this will generate a suboptimal decision around the update
>
> So that should be explained in the changelog of the patch.  In detail,
> if poss, please.

Ok, I'm going to update the commit message
