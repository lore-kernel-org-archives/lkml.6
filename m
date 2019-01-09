Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E2CC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CA5921738
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UvEgHCGU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730676AbfAIL2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 06:28:12 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:36630 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730392AbfAIL2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 06:28:12 -0500
Received: by mail-it1-f195.google.com with SMTP id c9so10502550itj.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 03:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dUWGm/4sPfFN1UJt6UEtJ/PK1+2pHD5Y0JKS7yOTNDA=;
        b=UvEgHCGUwfarWCc7/zBI+UiEkSkzynG6Vpcd0ZY5TEpy090k6LeW/wX2I/sF7fS7VX
         deN1/pJCZWssjtAQIt98U/fQR7jPsorbb9pFYBvya2qFc0ZfIPBlpDkoo5EVOpGYM3g+
         8GxtP+75TzebzPX8BtdIzr/2F0pS0Ce1/MWfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dUWGm/4sPfFN1UJt6UEtJ/PK1+2pHD5Y0JKS7yOTNDA=;
        b=jHV6A3VF9hOLrp+E8/VUn9jzUPDcGeelfSAiEcJKRKB0tV3oWlPthe+vuAurxYTWWC
         yCV8eYRdsGLV4qEdrcOowwc6olW8owlpktl5G1Ud8QfOMKYR1b6V1qGumBuf0AQyGIhK
         fFvzECH8BUlhKQTg33OBCCo9LVOoZS3Hi3YRv9aGpvZ2JOvHDQx10h48RXLTwB/wQVNG
         xu6/Tzet5bwraMH/ELwN+jWWjftaWjwdzfqFONwfX+C0fd7LkUc3IxTf/HrF7EUVyrpr
         NvVBhPO1uS4qTj5pljVOPJudHhqYvqY2KG34OM3i4yKk7LuoDbti+YVhkMw9vlnwT1vk
         vXRg==
X-Gm-Message-State: AJcUukcyqa6j5J+utmCKxdrRYQ3+C/gKlAsMP1OgxTywZs0E53D5fAN+
        spywi1JOjD6yMOhk1vgnu7/WjLIqQ5MBNa7MAS3ZZA==
X-Google-Smtp-Source: ALg8bN4Mo4MydjW0+YfIov1HCQrQMsgj7BYwckBh9C5va6ptuExvBqnA2b2qakUy/Cl8vEUw6eNtfKjiHQgkTt5JJcY=
X-Received: by 2002:a24:a20e:: with SMTP id j14mr3921367itf.14.1547033289883;
 Wed, 09 Jan 2019 03:28:09 -0800 (PST)
MIME-Version: 1.0
References: <20190107233833.GI5544@atomide.com> <CAKfTPtDBEmcsLotp-6K1KU1wM9Ba1EpMp3niXScRxYgzjs0nog@mail.gmail.com>
 <20190108155354.GL5544@atomide.com> <CAKfTPtCoOK-cYLXJ--sOfpVa9RVmzOAEN1+zB2qHMCzkJN0qaQ@mail.gmail.com>
 <20190108213743.GN5544@atomide.com> <20190109014218.GA8363@linaro.org> <20190109111703.GA28605@lenoch>
In-Reply-To: <20190109111703.GA28605@lenoch>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 9 Jan 2019 12:27:57 +0100
Message-ID: <CAKfTPtBvzZvJNxBRMbGbNFBYG0-pAR-P7X2=KrBWH01OMWvJYA@mail.gmail.com>
Subject: Re: Regression in v5.0-rc1 with autosuspend hrtimers
To:     Ladislav Michl <ladis@linux-mips.org>
Cc:     Tony Lindgren <tony@atomide.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jan 2019 at 12:17, Ladislav Michl <ladis@linux-mips.org> wrote:
>
> On Wed, Jan 09, 2019 at 02:42:18AM +0100, Vincent Guittot wrote:
> > Le Tuesday 08 Jan 2019 =C3=A0 13:37:43 (-0800), Tony Lindgren a =C3=A9c=
rit :
> > > * Vincent Guittot <vincent.guittot@linaro.org> [190108 16:42]:
> > > > On Tue, 8 Jan 2019 at 16:53, Tony Lindgren <tony@atomide.com> wrote=
:
> > > > > Hmm so could it be that we now rely on timers that that may
> > > > > not be capable of waking up the system from idle states with
> > > > > hrtimer?
> > > >
> > > > With nohz and hrtimer enabled,  timer relies on hrtimer to generate
> > > > the tick so you should use the same interrupt.
> > >
> > > OK yeah looks like that part is working just fine.
> > >
> > > Adding some printks and debugging over ssh, looks like
> > > omap8250_runtime_resume() gets called just fine based on a wakeirq,
> > > but then omap8250_runtime_suspend() runs immediately instead of
> > > waiting for the three second timeout.
> > >
> > > Lowering the autosuspend_delay_ms to 2100 ms makes things work again.
> > > Anything higher than 2200 ms seems to somehow time out immediately
> > > now :)
> >
> > This is quite close to the max ns of an int on arm 32bits
> >
> > Could you try the patch below ?
> >
> > ---
> >  drivers/base/power/runtime.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.=
c
> > index 7062469..44c5c76 100644
> > --- a/drivers/base/power/runtime.c
> > +++ b/drivers/base/power/runtime.c
> > @@ -141,7 +141,7 @@ u64 pm_runtime_autosuspend_expiration(struct device=
 *dev)
> >
> >       last_busy =3D READ_ONCE(dev->power.last_busy);
> >
> > -     expires =3D last_busy + autosuspend_delay * NSEC_PER_MSEC;
> > +     expires =3D last_busy + (u64)(autosuspend_delay) * NSEC_PER_MSEC;
> >       if (expires <=3D now)
> >               expires =3D 0;    /* Already expired. */
>
> Hmm, comment above function states it returns "the expiration time in jif=
fies
> (adjusted to be nonzero)", so there's probably more to fix...

The comment is wrong and should be updated as commit 8234f6734c5d has
moved on hrtimer and expires is now in raw ns unit

>
> You can also consider change like this (still does not return jiffies):
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 70624695b6d5..c72eaf21a61c 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -129,23 +129,20 @@ static void pm_runtime_cancel_pending(struct device=
 *dev)
>  u64 pm_runtime_autosuspend_expiration(struct device *dev)
>  {
>         int autosuspend_delay;
> -       u64 last_busy, expires =3D 0;
> -       u64 now =3D ktime_to_ns(ktime_get());
> +       ktime_t expires;
>
>         if (!dev->power.use_autosuspend)
> -               goto out;
> +               return 0;
>
>         autosuspend_delay =3D READ_ONCE(dev->power.autosuspend_delay);
>         if (autosuspend_delay < 0)
> -               goto out;
> -
> -       last_busy =3D READ_ONCE(dev->power.last_busy);
> +               return 0;
>
> -       expires =3D last_busy + autosuspend_delay * NSEC_PER_MSEC;
> -       if (expires <=3D now)
> -               expires =3D 0;    /* Already expired. */
> +       expires =3D ktime_add_ns(ms_to_ktime(autosuspend_delay),
> +                              READ_ONCE(dev->power.last_busy));
> +       if (expires <=3D ktime_get())
> +               return 0;       /* Already expired. */
>
> - out:
>         return expires;
>  }
>  EXPORT_SYMBOL_GPL(pm_runtime_autosuspend_expiration);
>
> Regards,
>         ladis
