Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2FFC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0C7D21871
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="G9HsCnGd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbeLSJ6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 04:58:55 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:45813 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727963AbeLSJ6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 04:58:55 -0500
Received: by mail-vs1-f68.google.com with SMTP id x28so4239826vsh.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 01:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sOLDET7sNb5TDwXKMFWdwpc1eihjuQRzqbJa4kFarrQ=;
        b=G9HsCnGdJiNv6cLv8ZXL7ROVhqOw3JeXgKS41NwEHIK8V5HGTAqkNNVywyaXiN7elO
         xN+4s9svqPKx9z9+XDDO6RBDWMvTkunmE/QC4WZIN6PQH5WH4J4tHWfTUD50pOfK7Ot8
         YD1Z00aMSQ521KCxGtBBN+M5mc7RnmyqZjaac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sOLDET7sNb5TDwXKMFWdwpc1eihjuQRzqbJa4kFarrQ=;
        b=HC4uQUw9vq0DWP5a9eWWS6vo2RGPwbXSgzztEUx7GFLGHbQWAuz/Si/mXYJzkq5d8Y
         IfIaIc0blulXCr0Fp2zmfhK5YFThwwvi6a0oEBNUZoJf1foiHBvQutPjd0pvBd1KHySL
         g9EAZZRtBHhFYv7c4OIglj3h2gKCXIRs81u6okRqf1LOeoqiFHH0fjzWzk1sGAK6JxJ5
         aocDoXV5XX/owmgIxWPNRb0yFC/xGElwGvx2h4EwanJCoC+xE+LRgGLJcwqo7EmweAkS
         d4P2qRArsmHOJkImvHRevBOSJIuOhpnyzjLrcDrWdvZ+2duMr4zN5YsOSEafKRBxtyCr
         RHJQ==
X-Gm-Message-State: AA+aEWZsSphufnPhrRUcF2dFW8w9V4qKmOBRDnekkLI4UPyH3G93FQ3k
        rfHIYO10idvE43vcj2ZoqxPn8FNOXekzfSYL1Fh/cA==
X-Google-Smtp-Source: AFSGD/UB03s+I9XQjrxyRchcDiD9wrppKSzA9ok4MzOymNMVeGaIzJ7SdwEygVn0RybORcn6ul2cXv+ynT+kk2uQ/2E=
X-Received: by 2002:a67:e002:: with SMTP id c2mr10043409vsl.34.1545213533720;
 Wed, 19 Dec 2018 01:58:53 -0800 (PST)
MIME-Version: 1.0
References: <1545144923-31546-1-git-send-email-vincent.guittot@linaro.org> <1545144923-31546-2-git-send-email-vincent.guittot@linaro.org>
In-Reply-To: <1545144923-31546-2-git-send-email-vincent.guittot@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 19 Dec 2018 10:58:17 +0100
Message-ID: <CAPDyKFq6X8vJU=pK1fgirGkD2-GS=LryRP1No8bSgPNLbyvAEg@mail.gmail.com>
Subject: Re: [RFC v3 1/3] PM/runtime: Add a new interface to get accounted time
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

On Tue, 18 Dec 2018 at 15:55, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> Some drivers (like i915/drm) need to get the accounted suspended time.
> pm_runtime_accounted_time_get() will return the suspended or active
> accounted time until now.

I suggest to leave the active accounted time out for now. At least
until we have some users.

That said, perhaps rename the function to something along the lines
of, pm_runtime_last_suspended_time(), to make it more clear.

>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  drivers/base/power/runtime.c | 26 ++++++++++++++++++++++++++
>  include/linux/pm_runtime.h   |  2 ++
>  2 files changed, 28 insertions(+)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 7062469..6461469 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -88,6 +88,32 @@ static void __update_runtime_status(struct device *dev, enum rpm_status status)
>         dev->power.runtime_status = status;
>  }
>
> +u64 pm_runtime_accounted_time_get(struct device *dev, enum rpm_status status, bool update)
> +{
> +       u64 now = ktime_to_ns(ktime_get());

I think you should stay on jiffies here - and then switch to ktime in patch 3.

> +       u64 delta = 0, time = 0;
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&dev->power.lock, flags);
> +
> +       if (dev->power.disable_depth > 0)
> +               goto unlock;
> +
> +       /* Add ongoing state  if requested */
> +       if (update && dev->power.runtime_status == status)
> +               delta = now - dev->power.accounting_timestamp;
> +

Hmm. Do we really need to update the accounting timestamp? I would
rather avoid it if possible.

It seems like it should be sufficient to return the delta between
"now" and the "dev->power.accounting_timestamp", when
"dev->power.runtime_status == RPM_SUSPENDED".

In other case, just return 0, because we are not in RPM_SUSPENDED state.

> +       if (status == RPM_SUSPENDED)
> +               time = dev->power.suspended_time + delta;
> +       else
> +               time = dev->power.active_time + delta;
> +
> +unlock:
> +       spin_unlock_irqrestore(&dev->power.lock, flags);
> +
> +       return time;
> +}
> +
>  /**
>   * pm_runtime_deactivate_timer - Deactivate given device's suspend timer.
>   * @dev: Device to handle.
> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> index 54af4ee..86f21f9 100644
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -113,6 +113,8 @@ static inline bool pm_runtime_is_irq_safe(struct device *dev)
>         return dev->power.irq_safe;
>  }
>
> +extern u64 pm_runtime_accounted_time_get(struct device *dev, enum rpm_status status, bool update);
> +
>  #else /* !CONFIG_PM */
>
>  static inline bool queue_pm_work(struct work_struct *work) { return false; }
> --
> 2.7.4
>

Kind regards
Uffe
