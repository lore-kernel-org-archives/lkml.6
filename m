Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C4EC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 864B720B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548928995;
	bh=P6EbU39RpM2t9+o9M6JN7ecQQ0nr01aRZPRYB8KhWAk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=iWA14ht75tTwIfqLhKd+UFtSkdgM/1cdcQe1pxacSCcFKRPBwZ+/IgKFBMvw6ffK2
	 4+jHEDLfHkgY2V4pE1IdNL/D/+ogbB/AwSAnQtg7ToTFDweIoESsmu02KTmaH1P/Pf
	 8SMyY34QcRcKxZQ9r4msS+KzX8ahT0xEGIcMI/+k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731896AbfAaKDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:03:14 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41779 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbfAaKDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 05:03:13 -0500
Received: by mail-oi1-f196.google.com with SMTP id j21so2216264oii.8;
        Thu, 31 Jan 2019 02:03:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=baCuR1frkul19hG+g9DCHA8Q5QHxg6jxHaotKtTrN5Y=;
        b=brNwFlQV32xcQqLIAr8mCcM9HvvZi0c67XVyrJpXOvrT84FfZLhRQPpc4whhYbmNzj
         bSlwvZng+rF42/Rzm9SDqEYP+W2wgTgxwJcefEUUPU6W0wwfULKySuPJc0O3HBFC5RQJ
         h3zxecDGys6liaCBA+M/Pbp1VtbvGvKw8Nf3VcEkyIvY/9oldCt1vP5fpoMu5lY39LHa
         kQ8UzDjQybPdC5t8Ho4Krh7TFMdlWETcgHowT0/PijVA4B0H9bv13vfi/AhEb7Tzw6NT
         wNLqUbCJ9NcUMR7T8rvuTeD0aedIae2v1JkFcXI1flWADgT9fQH+jWj1Svm4kwFvp3y8
         1xEA==
X-Gm-Message-State: AJcUukfxt0oOHlWiVlVIOnavK0m0T10/UPcBwfIDrXGyDUbl2e3z7IN4
        325PP8WZ66zevmaBKTAW1HEVR0XP7CHG/Cjde8U=
X-Google-Smtp-Source: ALg8bN4FNJola1kvLDB9jtQliGnE/bAmRBRMchrrR918UpXhK2kmTRFXiAp3kPMd6iw9H2/3N6m7FFR+rnasyup+HWc=
X-Received: by 2002:aca:195:: with SMTP id 143mr14110246oib.322.1548928992696;
 Thu, 31 Jan 2019 02:03:12 -0800 (PST)
MIME-Version: 1.0
References: <20190131015139.126890-1-mka@chromium.org> <20190131083004.rkxehycu4pbbx52s@vireshk-i7>
In-Reply-To: <20190131083004.rkxehycu4pbbx52s@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 31 Jan 2019 11:03:01 +0100
Message-ID: <CAJZ5v0hgBNY8cZgkn-u1qCCBrLxkS6T=srjMqsX50_H5V=ofHA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Record stats when fast switching is enabled
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 9:30 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 30-01-19, 17:51, Matthias Kaehlcke wrote:
> > When fast switching is enabled currently no cpufreq stats are
> > recorded and the corresponding sysfs attributes appear empty (see
> > also commit 1aefc75b2449 ("cpufreq: stats: Make the stats code
> > non-modular")).
> >
> > Record the stats after a successful fast switch and re-enable access
> > through sysfs when fast switching is enabled. Since
> > cpufreq_stats_update() can now be called in interrupt context (during
> > a fast switch) disable local IRQs while holding the stats spinlock.
> >
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > The change is so simple that I wonder if I'm missing some important
> > reason why the stats can't/shouldn't be updated during/after a fast
> > switch ...
> >
> > I would expect that holding the stats spinlock briefly in
> > cpufreq_stats_update() shouldn't be a problem. In theory it would
> > also be an option to have a per stats lock, though it seems overkill
> > from my (possibly ignorant) point of view.
> > ---
> >  drivers/cpufreq/cpufreq.c       |  8 +++++++-
> >  drivers/cpufreq/cpufreq_stats.c | 11 +++--------
> >  2 files changed, 10 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index e35a886e00bcf..63aadb0bbddfe 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -1857,9 +1857,15 @@ EXPORT_SYMBOL(cpufreq_unregister_notifier);
> >  unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
> >                                       unsigned int target_freq)
> >  {
> > +     unsigned int freq;
> > +
> >       target_freq = clamp_val(target_freq, policy->min, policy->max);
> >
> > -     return cpufreq_driver->fast_switch(policy, target_freq);
> > +     freq = cpufreq_driver->fast_switch(policy, target_freq);
> > +     if (freq)
> > +             cpufreq_stats_record_transition(policy, freq);
> > +
> > +     return freq;
> >  }
> >  EXPORT_SYMBOL_GPL(cpufreq_driver_fast_switch);
> >
> > diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> > index 1572129844a5b..21b919bfaeccf 100644
> > --- a/drivers/cpufreq/cpufreq_stats.c
> > +++ b/drivers/cpufreq/cpufreq_stats.c
> > @@ -30,11 +30,12 @@ struct cpufreq_stats {
> >  static void cpufreq_stats_update(struct cpufreq_stats *stats)
> >  {
> >       unsigned long long cur_time = get_jiffies_64();
> > +     unsigned long flags;
> >
> > -     spin_lock(&cpufreq_stats_lock);
> > +     spin_lock_irqsave(&cpufreq_stats_lock, flags);
> >       stats->time_in_state[stats->last_index] += cur_time - stats->last_time;
> >       stats->last_time = cur_time;
> > -     spin_unlock(&cpufreq_stats_lock);
> > +     spin_unlock_irqrestore(&cpufreq_stats_lock, flags);
> >  }
>
> The only problem that I can think of (or recall) is that this routine
> also gets called when time_in_state sysfs file is read and that can
> end up taking lock which the scheduler's hotpath will wait for.

What about the extra locking overhead in the scheduler context?
