Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9568C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9009620880
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O1TrXm13"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfBUKCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 05:02:36 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:37144 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbfBUKCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 05:02:35 -0500
Received: by mail-io1-f67.google.com with SMTP id v10so984760iop.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 02:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pi3EO1K8ctjymsNQk0xstIxWByfEpqhdrzH20oAUFdA=;
        b=O1TrXm13SmK0hzio7mz4hqyrljoDaFnzHb920PhPNHGS1xLIN8p03ZA+O/fYD/Wizs
         JvhU0kw76t30sqHlO7L/4V97z7/ra4+e/tGhSY7Up4aPJ94OdBDSI0mna1/o6QGbrqIi
         Nyrn/NR/IhHDoALRttDEj/vgvqzSzji8rqG6+anyLk0931mdXQgbyOWHeuH7bjRS86wy
         t/vGs0fb+WWmBrKhQT53FjxmcJcNXogCOLNi5FE0yMnl/9gRqhAOSMENR5HUPnqbSgPr
         gOMsyAt8ePA6xWpGTSdv4/p+PN4TzJApwmKuHQDxLl9tjKO0KFDj1bxq9r2XV2jz1xTA
         ffUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pi3EO1K8ctjymsNQk0xstIxWByfEpqhdrzH20oAUFdA=;
        b=ePOKcmDr9xJseS15LZOf6qUJ+wgs0qLhlC0sBr6w842ww34nwBIkQtO/lFR+JZiQiG
         yWeXn88XXLdVMlcfhDAnI8EXRBBdRjwxnDnU/GqzCE6SC42j6CikDHqo7LBicGfDDmi+
         6fjsTegfwciz5XWUeT+qGc3aL3qniJ5t7JErKKCskjf7GyalBeh8xJoOdImiAlaEWgrG
         +t7Mlqt66Olb3ZNy+SDcgudwKwO9QdLMwBhMmKiDXIz5P9NLlbHh7xPbXqePB2yEynGn
         1sAWBaDQM1R63cm+UJpKxmoNf1JsTFaB16f0IOk4gCchMhb2GM6eqRsqaM2zl6joRhUs
         BEiw==
X-Gm-Message-State: AHQUAuYt809HzN5hWhi8Ozq0+UrqsFNomNMNYptOr76obyAHWuFSSZdW
        67X6/hKxTVaqsHUMrp42qtCb6XNg3XWVi/ObV6HNZg==
X-Google-Smtp-Source: AHgI3IaYVR5/ZfISb+esO812RUYet2rqAcBV+gzNu/3PCcBF/Qj1RiG/WXgIcsfu/O5n0j2Q6RyUmybCeH4FpIQP7F4=
X-Received: by 2002:a6b:8d13:: with SMTP id p19mr6671106iod.18.1550743354455;
 Thu, 21 Feb 2019 02:02:34 -0800 (PST)
MIME-Version: 1.0
References: <1550735942-3569-1-git-send-email-vincent.guittot@linaro.org> <CAJZ5v0jEF2=etp=gLY4dchhB5pRjf8NAUnUt4oyC63pCsd1jqQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0jEF2=etp=gLY4dchhB5pRjf8NAUnUt4oyC63pCsd1jqQ@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 21 Feb 2019 11:02:23 +0100
Message-ID: <CAKfTPtCzgSV1+BJeu8DrNpmHuv9dk6SyHmhNCZETXMnksPXP3w@mail.gmail.com>
Subject: Re: [PATCH] PM-runtime: fix deadlock when canceling hrtimer
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Zhaosheng Sun <sunzhaosheng@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2019 at 10:35, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Feb 21, 2019 at 8:59 AM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > When rpm_resume() desactivates the autosuspend timer, it should only try
> > to cancel hrtimer but not wait for the handler to finish because both
> > rpm_resume() and pm_suspend_timer_fn() are taking the power.lock.
> > We can have the deadlock sequence:
> > CPU0                              CPU1
> > rpm_resume()
> >   spin_lock_irqsave
> >                                   pm_suspend_timer_fn()
> >                                     spin_lock_irqsave
> >   pm_runtime_deactivate_timer()
> >     hrtimer_cancel()
>
> Everybody has missed this, not good.

yes. default behavior if different between timer and hrtimer
del_timer() is equivalent to hrtimer_try_to_cancel()
and hrtimer_cancel() to del_timer_sync()

>
> > hrtimer_try_to_cancel() is enough because dev->power.timer_expires is also
> > set to 0.
> >
> > Fixes: 8234f6734c5d ("PM-runtime: Switch autosuspend over to using hrtimers")
> > Reported-by: Sunzhaosheng Sun(Zhaosheng) <sunzhaosheng@hisilicon.com>
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  drivers/base/power/runtime.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > index 04407d9..78937c4 100644
> > --- a/drivers/base/power/runtime.c
> > +++ b/drivers/base/power/runtime.c
> > @@ -121,7 +121,7 @@ EXPORT_SYMBOL_GPL(pm_runtime_suspended_time);
> >  static void pm_runtime_deactivate_timer(struct device *dev)
> >  {
> >         if (dev->power.timer_expires > 0) {
> > -               hrtimer_cancel(&dev->power.suspend_timer);
> > +               hrtimer_try_to_cancel(&dev->power.suspend_timer);
> >                 dev->power.timer_expires = 0;
> >         }
> >  }
> > --
>
> Applied with some changelog modifications, thanks!

Thanks
