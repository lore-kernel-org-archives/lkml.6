Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C7BC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83E522084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sEPUt3RF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83E522084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbeJDUw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 16:52:57 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:35345 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727314AbeJDUw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 16:52:57 -0400
Received: by mail-ua1-f65.google.com with SMTP id m18so3250548uaq.2;
        Thu, 04 Oct 2018 06:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=36W88g/sbdWHaxPvakg0WThcJLhSAlIZ8PRVCyj1+TQ=;
        b=sEPUt3RFfBOe9VWsyQi2jXsaZTlPUMIysr46mHLeEwh0wq5X9lHuSbtsIIvdmE00WE
         7LeY0SAHFyCnCkhWEPC18+IVsQm42AtpAKEgBkHycfA8cFOcf7vjhbpU+K8ltfPwOePx
         P9MVNzQy/KSDgzZl7haeIwd9B4vBD7Sp+jgi4OvW93fvpkxmzT8LRLlzLW2NtOtuhjOl
         c6pwLvfAoKGo+l+or4ZcbFMHkHwYQFdGmmRf6LycHG6idQKPsPBi9AUIQMcIZf+UDDm6
         pMsSNH05xgRZLqQARxlRwg9dwTyIZU8SCzYznWXeblOmg0taj3sJC5Vbh7TZOD6wRhPf
         K1TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=36W88g/sbdWHaxPvakg0WThcJLhSAlIZ8PRVCyj1+TQ=;
        b=cD6jB2mcfj5ifkQd66Jf3ks+Izm0qx6VpHv2WLFicvIx5qQ2z/MviK8mhKNcWD0MID
         KYj7AnQ0vO+F9JbHjWMfztqrIltiqPrRF+4eIGnUuouKrtHfuOtRT+FZKKJawoASC4Wl
         q9aeWyJz+rRwzZe4dX7I5kce5eBJPNQkGSw1GLR8dqc2jOuMSWQjIHXrE99QMaoPLM1P
         jFP2D2vEt4bJF04IUHug6Ys18MTB85UfBVXxH+FHzfyg4zUTTo3PY6Od05AtF9ZsUFy9
         c5+x3dheKILzWDHrtR8Lm8gVUSqGRxMG3n8LR/x34GukIyi1FZBbsBCBvtUp873XkixG
         7wFQ==
X-Gm-Message-State: ABuFfojm/FSYhawQFcSOcM8MegI38Ejzin59YEGLZ7W5GcOMrp+1P7CC
        YzxfE/OdNoek3XyXGaH247Wo/7QJv1dsPORaaUQ=
X-Google-Smtp-Source: ACcGV62cnoIHwoKDK2SoLn5+/jAWbm/emPhR8qBjAO9hHaUYpEfIsGu8ilG+0+0kH92zta7jkFp0+nGI/iURziGpBF4=
X-Received: by 2002:a9f:2237:: with SMTP id 52mr2724064uad.33.1538661570212;
 Thu, 04 Oct 2018 06:59:30 -0700 (PDT)
MIME-Version: 1.0
References: <61559514.Vym8FNvob2@aspire.rjw.lan> <CAPDyKFoUdQRUYQ0qb5WM=Bi-F_4Fe8VEPNYZGu2ezMPj_wxoPg@mail.gmail.com>
In-Reply-To: <CAPDyKFoUdQRUYQ0qb5WM=Bi-F_4Fe8VEPNYZGu2ezMPj_wxoPg@mail.gmail.com>
From:   Alan Cooper <alcooperx@gmail.com>
Date:   Thu, 4 Oct 2018 09:59:00 -0400
Message-ID: <CAOGqxeXCsXbxOcDrdjsgLXXxOtFfyzE0-zVEU6Y9kLxUaVfDiQ@mail.gmail.com>
Subject: Re: [PATCH] PM / core: Clear the direct_complete flag on errors
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>, pavel@ucw.cz
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 4 October 2018 at 11:08, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > If __device_suspend() returns early on an error or pending wakeup
> > and the power.direct_complete flag has been set for the device
> > already, the subsequent device_resume() will be confused by it
> > and it will call pm_runtime_enable() incorrectly, as runtime PM
> > has not been disabled for the device by __device_suspend().
>
> I think it would be fair to mention that is related to the async
> suspend path, in dpm_suspend().

This also fixed the issue and looks cleaner.

>
> >
> > To avoid that, clear power.direct_complete if __device_suspend()
> > is not going to disable runtime PM for the device before returning.
>
> Overall, by looking at the behavior in dpm_suspend() of async
> suspended devices, it does look a bit fragile to me.
>
> My worries is that we put asynced suspended devices in the
> dpm_suspended_list, no matter if the device was successfully suspended
> or not. This differs from the no-async path.
>
> In the long run, maybe we should change that instead?

I originally looked into this. Currently dmp_suspend moves async
devices from the prepared list to the suspended list as they are
queued and I looked at moving this to __device_suspend (after the
checks for async_error and wake_pending) but realized that this would
change normal resume ordering and was afraid that would be too
disruptive.

Al


On Thu, Oct 4, 2018 at 9:23 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On 4 October 2018 at 11:08, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > If __device_suspend() returns early on an error or pending wakeup
> > and the power.direct_complete flag has been set for the device
> > already, the subsequent device_resume() will be confused by it
> > and it will call pm_runtime_enable() incorrectly, as runtime PM
> > has not been disabled for the device by __device_suspend().
>
> I think it would be fair to mention that is related to the async
> suspend path, in dpm_suspend().
>
> >
> > To avoid that, clear power.direct_complete if __device_suspend()
> > is not going to disable runtime PM for the device before returning.
>
> Overall, by looking at the behavior in dpm_suspend() of async
> suspended devices, it does look a bit fragile to me.
>
> My worries is that we put asynced suspended devices in the
> dpm_suspended_list, no matter if the device was successfully suspended
> or not. This differs from the no-async path.
>
> In the long run, maybe we should change that instead?
>
> >
> > Fixes: aae4518b3124 (PM / sleep: Mechanism to avoid resuming runtime-suspended devices unnecessarily)
> > Reported-by: Al Cooper <alcooperx@gmail.com>
> > Cc: 3.16+ <stable@vger.kernel.org> # 3.16+
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Kind regards
> Uffe
>
> > ---
> >  drivers/base/power/main.c |    5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > Index: linux-pm/drivers/base/power/main.c
> > ===================================================================
> > --- linux-pm.orig/drivers/base/power/main.c
> > +++ linux-pm/drivers/base/power/main.c
> > @@ -1713,8 +1713,10 @@ static int __device_suspend(struct devic
> >
> >         dpm_wait_for_subordinate(dev, async);
> >
> > -       if (async_error)
> > +       if (async_error) {
> > +               dev->power.direct_complete = false;
> >                 goto Complete;
> > +       }
> >
> >         /*
> >          * If a device configured to wake up the system from sleep states
> > @@ -1726,6 +1728,7 @@ static int __device_suspend(struct devic
> >                 pm_wakeup_event(dev, 0);
> >
> >         if (pm_wakeup_pending()) {
> > +               dev->power.direct_complete = false;
> >                 async_error = -EBUSY;
> >                 goto Complete;
> >         }
> >
