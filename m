Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88175C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5592E20811
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kY1vKfKD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387439AbeLTJlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:41:12 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:43330 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730167AbeLTJlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:41:10 -0500
Received: by mail-ua1-f68.google.com with SMTP id z11so327545uaa.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 01:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=esq0pf+AXhqx5xXP8kafDyjV/A91AQ81qOD+Ua/idLk=;
        b=kY1vKfKDXZVZFafjgFhzcxPBzXPs75A4A9QgCLsHuDwziMoX84N095bhzuA771B+sY
         RKtEnnMLRAmQBnb4iVsr8qZvZg536ESbhjy/+OS+K1FfMK8hm2Qn//dooJ/tMjpTwBVj
         +/865m/g+71LM62dAkimY+aXr4boCuLTbaTX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=esq0pf+AXhqx5xXP8kafDyjV/A91AQ81qOD+Ua/idLk=;
        b=liM502wXnhA499zPDXp5Q6yKJmfi+LF494fQzjIPrLd6emRSkLLPwNVocbmHv1Txi8
         hfsOl/XaYEu350lwh0R+Liw8d27NhP9dtyL8k3+ES8+CcsSzjVBHQ7UWNWzvUvpFscmO
         gWS1o2MXpxOfeM7/dsZDDzCHQoK+mZ0foSYjFVYB8Y9J/i4Vsjw8so30cg5bZYHSo0z5
         or+xkizRTAPQsQ21/PLmhLtRdN+X+p3R9crgim3Dw8oyVHM7geZXwDxVKIEJikAdZGkW
         bHma1ifctHnZpdDoXZbCT0oRnmrgGQROZyeA2xPfN81LXHKrD2mFlyLyLr1QO7DVMpM2
         bH3A==
X-Gm-Message-State: AA+aEWZFigckloH1qEavii7oQiZIYjm5HM/XBJOmUg23eeX5iYQh2btn
        W8tXeJ37s76YVvI4t2bgx3HkeUWVsBViDZiZbB7v+g==
X-Google-Smtp-Source: AFSGD/UaexyLQ1nb6r6nqPTHEMiG5xgM4A+kYufiIwP/4O1vJOC4CHD4rpkBaURJ6GePrFiAZl+qjDZtApqcDhtXJNo=
X-Received: by 2002:a9f:2244:: with SMTP id 62mr10789733uad.119.1545298868834;
 Thu, 20 Dec 2018 01:41:08 -0800 (PST)
MIME-Version: 1.0
References: <1545144923-31546-1-git-send-email-vincent.guittot@linaro.org>
 <1545144923-31546-2-git-send-email-vincent.guittot@linaro.org>
 <CAPDyKFq6X8vJU=pK1fgirGkD2-GS=LryRP1No8bSgPNLbyvAEg@mail.gmail.com>
 <CAKfTPtCpv0MqF64JGTyR63bqKdAhXzL1fEsNbS6DHsD-jXYpKw@mail.gmail.com>
 <CAPDyKFrSxX-eBsTiEvbrbjVpqkSuBnhxruCgtihH6hSvWSFD1g@mail.gmail.com>
 <CAKfTPtB=TUAz=KpZzJsRUvK8ymiXnTgQ3BxcY0yu9YbJ1BW7QA@mail.gmail.com>
 <CAPDyKFoR7t=K65n0_+4yRqdpRMZ0BbA16cDhmxEvNhm0qEOXNQ@mail.gmail.com>
 <CAKfTPtA4Fr6Xk7+dUpzZqGvK6dJGtWAiz70Ho4noQk3gBdGFdg@mail.gmail.com>
 <CAPDyKFqpieqgh-0U_N1wwWdciotMAAJ2SRNXpGAb8D2voiaOJA@mail.gmail.com>
 <CAKfTPtBp+eCqyCWh27FWe8pkrFJiLQitPL_+kfL42r_BTq6DcQ@mail.gmail.com>
 <CAPDyKFocLDoJG5P3ywAV7+p6PL3fnno1cZ87=-Mzn49ag-y6tw@mail.gmail.com> <CAKfTPtA7Y5=wQ-CqKxquyiRVA1PjqqjV1A9aDn8tMok=eDYX5A@mail.gmail.com>
In-Reply-To: <CAKfTPtA7Y5=wQ-CqKxquyiRVA1PjqqjV1A9aDn8tMok=eDYX5A@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 20 Dec 2018 10:40:32 +0100
Message-ID: <CAPDyKFqwB4qPAjhgSGkZmwyzd38AiFzkFVpqcea6K7Sm7BWcfQ@mail.gmail.com>
Subject: Re: [RFC v3 1/3] PM/runtime: Add a new interface to get accounted time
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        jani.nikula@linux.intel.com,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        rodrigo.vivi@intel.com, David Airlie <airlied@linux.ie>,
        "Intel graphics driver community testing & development" 
        <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> > > > Re-thinking this a bit from my earlier comments - and by following the
> > > > above reasoning, it sounds like this better belongs in the
> > > > driver/subsystem, without requiring any data from the core.
> > > >
> > > > The driver/subsystem could just store a timestamp in it's
> > > > ->runtime_suspend() callback and whenever needed, it could compute a
> > > > delta towards it. That should work, right?
> > >
> > > I don't know i915/drm enough to know all that details
> >
> > Okay, so let me re-summarize the main issue I see with your approach
> > in $subject patch.
> >
> > dev->power.accounting_timestamp can't be used to know when last
> > transition was made. If I understand correctly, that is how you use
> > it. No?
>
> Yes. At least that how I have interpreted the current code
>
> >
> > Anyway, as stated, that's because the timestamp becomes updated, if
> > update_pm_runtime_accounting() is called via the sysfs nobs, which
> > means there is no state transition happening, but only accounting data
> > is updated.
>
> Yes I have not realized that the update also happens there which makes
> me think that i have
> may be over interpreted the code and the initialization of
> i915->pmu.suspended_jiffies_last
>
> >
> > So, what I think we can do from the core perspective, if it helps
> > (which I am not sure of):
> > 1. Export a function, which returns the value of dev->power.suspended_jiffies.
> > 2. Export a wrapper function (to deal with locking) which calls
> > update_pm_runtime_accounting(). This wrapper function allows the user
> > the update the total suspended time, also taking into account the time
> > spent in the current state.
>
> Having now in mind that suspended_jiffies can be updated outside state
> transition like via sysfs call,
> we can maybe just implements 2 and return dev->power.suspended_jiffies
>
> something like below
> unsigned long pm_runtime_get_suspended_time(struct device *dev)

"pm_runtime_suspended_time()" should be sufficient I think. The "get"
part would become confusing due to the existing get/put functions that
are part of the runtime PM interface.

> {
> unsigned long time;
> unsigned long flags;
>
> spin_lock_irqsave(&dev->power.lock, flags);
>
> update_pm_runtime_accounting(dev);
>
> time = dev->power.suspended_time;

dev->power.suspended_jiffies

...at least until you converts to ktime :-)

>
> spin_unlock_irqrestore(&dev->power.lock, flags);
>
> return time;
> }

Yes, this looks fine to me!

Kind regards
Uffe
