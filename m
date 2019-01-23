Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D83CC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C696420861
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rgi/Tq6c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfAWIuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 03:50:50 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:40408 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbfAWIut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 03:50:49 -0500
Received: by mail-it1-f193.google.com with SMTP id h193so1890063ita.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 00:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qqqr6i1pzvuqiJVIw+m8cqVTw0rosF2QUA3fc4XZEmM=;
        b=Rgi/Tq6cE7vhMZbsTkqzG/9yUzGm2P31U0XGUpA1wxdWslwUESOhEj3iuTyoc+OiaR
         DszmcwND1PbaW+37f4bi1QrHL1Q43AunsiXbYielZA7NM7EmBAp36g4gwiPUvUxlVJ0y
         mBkNNPcRUvfzGqcHcFcefH9LlJJ68JwIUdGA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qqqr6i1pzvuqiJVIw+m8cqVTw0rosF2QUA3fc4XZEmM=;
        b=CuSbVdzJLctyxFyWLGr7OoWniikqPrV9/eUiklOLpx4/7+kGMbPx2khuWPFHiAgZp+
         vETnXSfOfw/yAWBsUXYqWMqYzzCZz9mQRQFVIhrFz6cVVxTYzLxKNgpn2X7IR7WRfVyf
         +hunZFV6fz0myOgbXlq5sc5SK+o8jbYXlxV0T8lTNiObLTZQVM/FgpTGtmVqfX4eVbtX
         jyMROlNzfVEYS3AdsMW1O53MRn2mPgplOKHRqzZ6c97oaI/YERgmy+nXBfdRd2id7HLe
         JG7IDnuVVJmkaFzaSIzpg7SKyBdJrep5+rNcDh6RTY0J3Jku2awpYiwUX6bqlehxFwAq
         bF2Q==
X-Gm-Message-State: AJcUukfwT+mQVPkHNxp1LJkUeKI1welCCg7jrkcOEoIrD7EUzwVm/UAc
        cTGRU3cpeKiMfBwT6N10dQ0tqc4V7z5RalK7JITa1w==
X-Google-Smtp-Source: ALg8bN4scxqOcPYy/p1LsStP0vVZbqh7sdsTYYw6g2jOI+760/STofHImtKeHyUHHPSG/cBJd0ZVm8MmXPy7O4POYAY=
X-Received: by 2002:a02:6019:: with SMTP id i25mr812238jac.137.1548233448576;
 Wed, 23 Jan 2019 00:50:48 -0800 (PST)
MIME-Version: 1.0
References: <1548167070-421-1-git-send-email-vincent.guittot@linaro.org>
 <1548167070-421-2-git-send-email-vincent.guittot@linaro.org> <CAPDyKFqeo1Yxso-iYF4Co-eRYXKDRmiFHi9i5wiZSCXGtgSdkQ@mail.gmail.com>
In-Reply-To: <CAPDyKFqeo1Yxso-iYF4Co-eRYXKDRmiFHi9i5wiZSCXGtgSdkQ@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 23 Jan 2019 09:50:37 +0100
Message-ID: <CAKfTPtDxWK-W-jP7Ak3Nk_zksCbVrY0CHT+OnWZgt1t17AYjFw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] PM-runtime: update accounting_timestamp only when enable
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2019 at 09:14, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 22 Jan 2019 at 15:24, Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > Initializing accounting_timestamp to something different from 0 during
> > pm_runtime_init() doesn't make sense and put useless ordering constraint between
> > timekeeping_init() and pm_runtime_init().
> > PM runtime should start accounting time only when it is enable and discard
> > the period when disabled.
> > Set accounting_timestamp to now when enabling PM runtime.
>
> Hmm, my first impression is that this sounds like a reasonable thing
> to do. However, there are couple of more things to consider.
>
> 1) update_pm_runtime_accounting() is setting a new value of
> dev->power.accounting_timestamp, no matter of whether runtime PM has
> been enabled. That's seems wrong to me, at least from the perspective
> of what we are trying to change here. So you probably needs to fix
> that too.

note that whatever is done before enabling pm runtime, this will be
overwritten during the enablement.
I can add a clean up patch but this behavior is already there with jiffies.

Or do you think that update_pm_runtime_accounting can be called before
timekeeping_init() ?

>
> 2) I don't think you explicitly need to set
> dev->power.accounting_timestamp to zero at pm_runtime_init(). Just
> leave it uninitialized, as we are anyways going to initialize it
> before we make use of it.

yes probably

>
> 3) How will this change affect accounting while being system
> suspended? As you know, the PM core disables and re-enables runtime PM

So the time in system suspended will not be accounted

> during a system suspend/resume sequence. It looks to me, that you
> actually need to call update_pm_runtime_accounting() from
> pm_runtime_enable|disable(), or something along those lines, as to get
> the accounting correct, no?

I thought that everything was already done for jiffies too. As soon as
pm runtime is disable, we can't really account this time to
suspended_time or active_time because we don't have control anymore

I think that we don't need any additional changes for
pm_runtime_enable because we just init the accounting_timestamp and
there is no active or suspend runtime to account yet
For pm_runtime_disable(), I thought that everything was already there
otherwise it means that we already didn't account the time correctly.
I will have a deeper look at that

>
> >
> > Suggested-by: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  drivers/base/power/runtime.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > index fb5e2b6..7df1d05 100644
> > --- a/drivers/base/power/runtime.c
> > +++ b/drivers/base/power/runtime.c
> > @@ -1306,6 +1306,10 @@ void pm_runtime_enable(struct device *dev)
> >
> >         spin_lock_irqsave(&dev->power.lock, flags);
> >
> > +       /* About to enable runtime pm, set accounting_timestamp to now */
> > +       if (dev->power.disable_depth == 1)
> > +               dev->power.accounting_timestamp = jiffies;
> > +
> >         if (dev->power.disable_depth > 0)
> >                 dev->power.disable_depth--;
> >         else
> > @@ -1506,7 +1510,7 @@ void pm_runtime_init(struct device *dev)
> >         dev->power.request_pending = false;
> >         dev->power.request = RPM_REQ_NONE;
> >         dev->power.deferred_resume = false;
> > -       dev->power.accounting_timestamp = jiffies;
> > +       dev->power.accounting_timestamp = 0;
> >         INIT_WORK(&dev->power.work, pm_runtime_work);
> >
> >         dev->power.timer_expires = 0;
> > --
> > 2.7.4
> >
