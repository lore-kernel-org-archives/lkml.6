Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA0EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8656720874
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FuvoMQT/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbeLSPZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:25:21 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:38630 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727418AbeLSPZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 10:25:21 -0500
Received: by mail-io1-f68.google.com with SMTP id l14so15895570ioj.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 07:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fwXyV3uXHFnEFzarKwBmGEamrwhwKWEPPcrhlHwu7VM=;
        b=FuvoMQT/brpDTWyRZN7dv1B0ZVyUJwtTBlGMGWcTcCrhMFMqDL6lU+wJGkP/v6iPZW
         5UBo/wl3/kf+X9Exh5eRxeqwpiiQYTliAVS4H58dA10UDTxr2l9vI/qWZit7kkt1szRP
         4mXGaYrr8UI/dUDHCHp1pQpJ1rwZh2+9Z/4FM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fwXyV3uXHFnEFzarKwBmGEamrwhwKWEPPcrhlHwu7VM=;
        b=Nboq1mRypC99tVlQCew6kcr67c3rmKqD3AOH8fm4qwYjAe5xEuvTVY/jJRwlRkZQAF
         mFFp0M2F9KYvBLUa3zzq24/xADABt38Dt1C9x23UiPKobOBLKcnac5AdoroNO8K8iP/t
         HcgWBB25OsqGoj+ydMMCS1z/m273XugYPQCuJn7FGU7xDc/HmnsHcJJv72p5d2RsCHa7
         ElxucdlgCmlGeYh2wChFWrnRK4c7v+cCOSIz9Tdt55YqZ1ykhZ17A3ICYwhpnBZiJzho
         00r/QHoDMcE83JWT+Jo3wwTj9/4zhP83VfQi/6waaQoy57ZpEHf1FieZPUhKenCdwg5+
         bHpg==
X-Gm-Message-State: AJcUukc51LtqK8jjQ6mGm4KH8Qcizvovj01TU2OZCYDX7I47eUu06x+I
        /KIlBhB1m1dWCV/hmfy6rRTsWdfw8r3Q1xDFSepyEQ==
X-Google-Smtp-Source: ALg8bN5MnoeNKYenNWZ7OPURZKQIzibsiKxA1thSj8Mb03eeTbeWFnDQpNoy80Kr3Wz6f4wKxwexi+IRR/POCM+orHQ=
X-Received: by 2002:a6b:6b01:: with SMTP id g1mr56755ioc.18.1545233119800;
 Wed, 19 Dec 2018 07:25:19 -0800 (PST)
MIME-Version: 1.0
References: <1545144923-31546-1-git-send-email-vincent.guittot@linaro.org>
 <1545144923-31546-2-git-send-email-vincent.guittot@linaro.org> <CAPDyKFq6X8vJU=pK1fgirGkD2-GS=LryRP1No8bSgPNLbyvAEg@mail.gmail.com>
In-Reply-To: <CAPDyKFq6X8vJU=pK1fgirGkD2-GS=LryRP1No8bSgPNLbyvAEg@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 19 Dec 2018 16:25:08 +0100
Message-ID: <CAKfTPtBokDKeaPOPNqxP_2CfzRRNdfZUmxDqsQ6puc+_FQRGbg@mail.gmail.com>
Subject: Re: [RFC v3 1/3] PM/runtime: Add a new interface to get accounted time
To:     Ulf Hansson <ulf.hansson@linaro.org>
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

On Wed, 19 Dec 2018 at 10:58, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 18 Dec 2018 at 15:55, Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > Some drivers (like i915/drm) need to get the accounted suspended time.
> > pm_runtime_accounted_time_get() will return the suspended or active
> > accounted time until now.
>
> I suggest to leave the active accounted time out for now. At least
> until we have some users.
>
> That said, perhaps rename the function to something along the lines
> of, pm_runtime_last_suspended_time(), to make it more clear.
>
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  drivers/base/power/runtime.c | 26 ++++++++++++++++++++++++++
> >  include/linux/pm_runtime.h   |  2 ++
> >  2 files changed, 28 insertions(+)
> >
> > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > index 7062469..6461469 100644
> > --- a/drivers/base/power/runtime.c
> > +++ b/drivers/base/power/runtime.c
> > @@ -88,6 +88,32 @@ static void __update_runtime_status(struct device *dev, enum rpm_status status)
> >         dev->power.runtime_status = status;
> >  }
> >
> > +u64 pm_runtime_accounted_time_get(struct device *dev, enum rpm_status status, bool update)
> > +{
> > +       u64 now = ktime_to_ns(ktime_get());
>
> I think you should stay on jiffies here - and then switch to ktime in patch 3.

I forgot to reply to this comment
Yes I agree that I should stay in jiffies there


>
> > +       u64 delta = 0, time = 0;
> > +       unsigned long flags;
> > +
> > +       spin_lock_irqsave(&dev->power.lock, flags);
