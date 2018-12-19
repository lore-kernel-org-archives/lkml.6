Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CEC0C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 429BD20989
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nf5PbU8m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbeLSN0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 08:26:12 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:36347 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728806AbeLSN0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 08:26:11 -0500
Received: by mail-io1-f65.google.com with SMTP id m19so15618094ioh.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 05:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2TklxcyNCHet/VUKMmV9m2tymIl2mT8ZoduxL3mQF/U=;
        b=Nf5PbU8mawDrea5mCT8UgUwbMeaWCLCWXVNtDtlbU8gDTs/J5Kbuyo4Ua46uWBhxOm
         MqGGsx3aiA7aIJTNmtNyOxtxa+PhkXpT8fG4zZ4Kh/MNwO0nuCU+JrYWskzAXtVrimyg
         nZ6bekSHcI9hjrRRZgHj4rhhP6ru+OH1nt7jk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2TklxcyNCHet/VUKMmV9m2tymIl2mT8ZoduxL3mQF/U=;
        b=RCUXLrGliyRejfEWQ0M3U0b92cIRwDcUh1Dm69QAGfuksGC9IfBSMdck0K1etqAdWU
         WZeop75D7e3JE2FR9FkekQ/a+ZRRWgzFKsQIsGat2rvWZpalTlPQ9DV++tctt/F1DRnL
         KhUM304yZhB2t2ZPajn3rICghdkTMWO0PAAjVpf1NkrTFS3oAq1bcedQ3P+Ooxf5AyRC
         /j9vuLwclNrThlnqK+/woohcs2RGxLdO/6vIqLqD+maDdnAOCT2VSnAtE9fS9nOrUBxw
         Bw0XHcn4ENe3tKaC4RcJoUTHO+khc6FUgClND9lu9ghh4J5VwbYepIMsD/gtfPQGUFpm
         lcFw==
X-Gm-Message-State: AJcUukezuKnhOK0e5/tIvyLELleogE7rSQVlmAgdtkSwzhaVQW7OhV5U
        mvQGouHKQAUANB4QFgtSys2Hvd6hvykpxG22TIW7Cg==
X-Google-Smtp-Source: ALg8bN6EHtB6EC/bW8ao8zyr42LTrDqqAX5Pdo3QcrCnun+uGwiAsBuhz5PkN0NHcik2uXPN28MXTZC72eBEv40Grdg=
X-Received: by 2002:a6b:6b01:: with SMTP id g1mr768792ioc.18.1545225970373;
 Wed, 19 Dec 2018 05:26:10 -0800 (PST)
MIME-Version: 1.0
References: <1545144923-31546-1-git-send-email-vincent.guittot@linaro.org>
 <1545144923-31546-2-git-send-email-vincent.guittot@linaro.org>
 <CAPDyKFq6X8vJU=pK1fgirGkD2-GS=LryRP1No8bSgPNLbyvAEg@mail.gmail.com>
 <CAKfTPtCpv0MqF64JGTyR63bqKdAhXzL1fEsNbS6DHsD-jXYpKw@mail.gmail.com>
 <CAPDyKFrSxX-eBsTiEvbrbjVpqkSuBnhxruCgtihH6hSvWSFD1g@mail.gmail.com>
 <CAKfTPtB=TUAz=KpZzJsRUvK8ymiXnTgQ3BxcY0yu9YbJ1BW7QA@mail.gmail.com> <CAPDyKFoR7t=K65n0_+4yRqdpRMZ0BbA16cDhmxEvNhm0qEOXNQ@mail.gmail.com>
In-Reply-To: <CAPDyKFoR7t=K65n0_+4yRqdpRMZ0BbA16cDhmxEvNhm0qEOXNQ@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 19 Dec 2018 14:25:58 +0100
Message-ID: <CAKfTPtA4Fr6Xk7+dUpzZqGvK6dJGtWAiz70Ho4noQk3gBdGFdg@mail.gmail.com>
Subject: Re: [RFC v3 1/3] PM/runtime: Add a new interface to get accounted time
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Dec 2018 at 11:43, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Wed, 19 Dec 2018 at 11:34, Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > On Wed, 19 Dec 2018 at 11:21, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >

> > > > > >
> > > > > > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > > > > > index 7062469..6461469 100644
> > > > > > --- a/drivers/base/power/runtime.c
> > > > > > +++ b/drivers/base/power/runtime.c
> > > > > > @@ -88,6 +88,32 @@ static void __update_runtime_status(struct device *dev, enum rpm_status status)
> > > > > >         dev->power.runtime_status = status;
> > > > > >  }
> > > > > >
> > > > > > +u64 pm_runtime_accounted_time_get(struct device *dev, enum rpm_status status, bool update)
> > > > > > +{
> > > > > > +       u64 now = ktime_to_ns(ktime_get());
> > > > >
> > > > > I think you should stay on jiffies here - and then switch to ktime in patch 3.
> > > > >
> > > > > > +       u64 delta = 0, time = 0;
> > > > > > +       unsigned long flags;
> > > > > > +
> > > > > > +       spin_lock_irqsave(&dev->power.lock, flags);
> > > > > > +
> > > > > > +       if (dev->power.disable_depth > 0)
> > > > > > +               goto unlock;
> > > > > > +
> > > > > > +       /* Add ongoing state  if requested */
> > > > > > +       if (update && dev->power.runtime_status == status)
> > > > > > +               delta = now - dev->power.accounting_timestamp;
> > > > > > +
> > > > >
> > > > > Hmm. Do we really need to update the accounting timestamp? I would
> > > > > rather avoid it if possible.
> > > >
> > > > i915/drm uses this to track ongoing suspended state. In fact they are
> > > > mainly interested by this part
> > >
> > > Again, sorry I don't follow.
> >
> > In fact we don't update dev->power.accounting_timestamp but only use
> > it to get how much time has elapsed in the current state.
> >
> > >
> > > My suggested changes below, would do exactly that; track the ongoing
> > > suspended state.
> > >
> > > The user can call the function several times while the device remains
> > > RPM_SUSPENDED, and if needed the user could then compute the delta
> > > in-between the calls, for whatever reason that may be needed.
> >
> > So I'm not sure to catch your question:
> > Is your problem linked to status != RPM_SUSPENDED or the update
> > parameter that compute delta ?
>
> My intent was to keep things simple.
>
> 1. Only expose last suspended time, which means tracking the ongoing
> suspended state. In other words, you can also remove "enum rpm_status
> status" as the in-parameter to pm_runtime_accounted_time_get().

Ok for this point if Rafael doesn't see any benefit of keeping the
generic interface

> 2. Don't allow the user of pm_runtime_accounted_time_get() to update
> the current timestamp, in "dev->power.accounting_timestamp".

But pm_runtime_accounted_time_get doesn't update
dev->power.accounting_timestamp, it only reads it to know when when
the last state transition happened

>
> Is that okay for the drm driver, to do what it does today?

drm driver needs 2 things: the  accounted suspended time since the
last transition
and the time elapse in the current state when suspened

>
> >
> > >
> > > >
> > > > >
> > > > > It seems like it should be sufficient to return the delta between
> > > > > "now" and the "dev->power.accounting_timestamp", when
> > > > > "dev->power.runtime_status == RPM_SUSPENDED".
> > > > >
> > > > > In other case, just return 0, because we are not in RPM_SUSPENDED state.
> > > >
> > > > only the RPM_SUSPENDED is used by i915/drm but wanted to provide a
> > > > generic interface to get
> > > > suspended or not suspend state
> > >
> > > I see.
> > >
> > > Although, unless Rafael thinks different, I would rather try to keep
> > > this as simple as possible and expose only what is needed and nothing
> > > more.
> >
> > I'm fine with both. Rafael ?
> >
> > >
> > > >
> > > > >
> > > > > > +       if (status == RPM_SUSPENDED)
> > > > > > +               time = dev->power.suspended_time + delta;
> > > > > > +       else
> > > > > > +               time = dev->power.active_time + delta;
> > > > > > +
> > > > > > +unlock:
> > > > > > +       spin_unlock_irqrestore(&dev->power.lock, flags);
> > > > > > +
> > > > > > +       return time;
> > > > > > +}
> > > > > > +
> > > > > >  /**
> > > > > >   * pm_runtime_deactivate_timer - Deactivate given device's suspend timer.
> > > > > >   * @dev: Device to handle.
> > > > > > diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> > > > > > index 54af4ee..86f21f9 100644
> > > > > > --- a/include/linux/pm_runtime.h
> > > > > > +++ b/include/linux/pm_runtime.h
> > > > > > @@ -113,6 +113,8 @@ static inline bool pm_runtime_is_irq_safe(struct device *dev)
> > > > > >         return dev->power.irq_safe;
> > > > > >  }
> > > > > >
> > > > > > +extern u64 pm_runtime_accounted_time_get(struct device *dev, enum rpm_status status, bool update);
> > > > > > +
> > > > > >  #else /* !CONFIG_PM */
> > > > > >
> > > > > >  static inline bool queue_pm_work(struct work_struct *work) { return false; }
> > > > > > --
> > > > > > 2.7.4
> > > > > >
> > > > >
> > > > > Kind regards
> > > > > Uffe
> > >
> > > Kind regards
> > > Uffe
