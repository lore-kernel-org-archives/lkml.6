Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEEAC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D35D82086E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UJbZp2bs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D35D82086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbeIYSpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 14:45:18 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34414 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728588AbeIYSpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 14:45:18 -0400
Received: by mail-wm1-f65.google.com with SMTP id j25-v6so12528718wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 05:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ooC413dYCfVW/b6u1msiKl6qqALOlTLOqW/iSWutPXo=;
        b=UJbZp2bs/BQQnX1VnVvMyVk5DVAV0G7rEEOkoIloACQGzPdgSclq5fREWdxiczExTB
         byla+8wJGDczrkjlmEuvlezj0MRpKLgPbQYCMfvGbCk+n6fBnfe5PP0FVfNb6JYsK97j
         DMmltV+R0MLuq34uGF30tIH6hr8Yo+2OGbZ44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ooC413dYCfVW/b6u1msiKl6qqALOlTLOqW/iSWutPXo=;
        b=nWVHpohBZdx7ZVaD99zpm1lhiHJQy1ahxgmSbizeBxujaA460Wz9ZBanba41cfOKxq
         OUscgVfmCQDhRFwZqjyCAKzkKOsVzYqfznGwkXitITmKTy/mrj5lmUPpfFrfC60AhFLX
         o2rjGPDK07ouMZ5/CJYo5C4ijWFDzVd2yqxNmErGpeFnLXeHNJpS0cT/09lxuB4cRaUM
         VobQ8LOEfTbWb/CK4c3bRoWL+vaJ1QI27T3hBAGQ2OUMilRVY9/Z5FMXlV6I8e00qvbe
         kyvd9IclX1ymv/uHoi+pPFAwo+8kYr6zZ6Unw6zswagmy/0Aik24kCPNO5/V0k3FC6lo
         Wu1Q==
X-Gm-Message-State: ABuFfoihDIUTiaLNESjCb/tclwf7fc5ua1SqZ8+SMfFpP3etBsO5WofP
        qyoteQZAFCPE4g/gT09v6047B6fKZ68EpkNEg7WfCA==
X-Google-Smtp-Source: ACcGV60zjkM+B7xmeheniHLirvj+UsqashDyKZZA5jXgkkLVlxJSc3lqCCRRCmS3g/sRIppOKJdSIsFst1VmYcrEOBw=
X-Received: by 2002:a1c:d986:: with SMTP id q128-v6mr585466wmg.110.1537879073681;
 Tue, 25 Sep 2018 05:37:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180806144900.GA13925@jordon-HP-15-Notebook-PC>
 <CAFqt6zYWehpkSNf7LHFXFaY1s-aAdXg=OV0C9Hr8j9fS-P3OCw@mail.gmail.com> <CAFqt6zYyBQhbvQiy4EWOpHHL-a77Fjm9LCLNA+drT62MhHuKeQ@mail.gmail.com>
In-Reply-To: <CAFqt6zYyBQhbvQiy4EWOpHHL-a77Fjm9LCLNA+drT62MhHuKeQ@mail.gmail.com>
From:   Xinliang Liu <xinliang.liu@linaro.org>
Date:   Tue, 25 Sep 2018 20:37:42 +0800
Message-ID: <CAGd==041pgoA+5Xx6+tWm6zY=_B6FZ0+=TX3iG3zzuWQmQW0Dg@mail.gmail.com>
Subject: Re: [PATCH] gpu/drm/hisilicon: Convert drm_atomic_helper_suspend/resume()
To:     jrdr.linux@gmail.com
Cc:     "Liuxinliang (Matthew Liu)" <z.liuxinliang@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        XinWei Kong <kong.kongxinwei@hisilicon.com>,
        Feng Chen <puck.chen@hisilicon.com>,
        David Airlie <airlied@linux.ie>, ajitn.linux@gmail.com,
        sabyasachi.linux@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        brajeswar.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Souptick,

On Mon, 17 Sep 2018 at 15:40, Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> On Tue, Sep 11, 2018 at 2:04 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
> >
> > On Mon, Aug 6, 2018 at 8:16 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
> > >
> > > convert drm_atomic_helper_suspend/resume() to use
> > > drm_mode_config_helper_suspend/resume().
> > >
> > > Fixed one sparse warning by making hibmc_drm_interrupt
> > > static.
> > >
> > > Signed-off-by: Ajit Negi <ajitn.linux@gmail.com>
> > > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > > Reviewed-by: Xinliang Liu <z.liuxinliang@hisilicon.com>
> >
> > Can we get this patch in queue for 4.20 ??
>
> Daniel, can we get this patch in queue for 4.20, if no further comment  ?

Will send 4.20 drm-next pull for this patch. I am verifying it on our D05 board.

Thanks,
Xinliang

>
> >
> > > ---
> > > v2: remove ret variable from both suspend and resume.
> > >     remove suspend_state from hibmc_drm_private struct.
> > >
> > >  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 20 +++-----------------
> > >  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h |  1 -
> > >  2 files changed, 3 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> > > index d4f6f1f..ee24480 100644
> > > --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> > > +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> > > @@ -37,7 +37,7 @@
> > >         .llseek         = no_llseek,
> > >  };
> > >
> > > -irqreturn_t hibmc_drm_interrupt(int irq, void *arg)
> > > +static irqreturn_t hibmc_drm_interrupt(int irq, void *arg)
> > >  {
> > >         struct drm_device *dev = (struct drm_device *)arg;
> > >         struct hibmc_drm_private *priv =
> > > @@ -74,30 +74,16 @@ static int __maybe_unused hibmc_pm_suspend(struct device *dev)
> > >  {
> > >         struct pci_dev *pdev = to_pci_dev(dev);
> > >         struct drm_device *drm_dev = pci_get_drvdata(pdev);
> > > -       struct hibmc_drm_private *priv = drm_dev->dev_private;
> > > -
> > > -       drm_kms_helper_poll_disable(drm_dev);
> > > -       priv->suspend_state = drm_atomic_helper_suspend(drm_dev);
> > > -       if (IS_ERR(priv->suspend_state)) {
> > > -               DRM_ERROR("drm_atomic_helper_suspend failed: %ld\n",
> > > -                         PTR_ERR(priv->suspend_state));
> > > -               drm_kms_helper_poll_enable(drm_dev);
> > > -               return PTR_ERR(priv->suspend_state);
> > > -       }
> > >
> > > -       return 0;
> > > +       return drm_mode_config_helper_suspend(drm_dev);
> > >  }
> > >
> > >  static int  __maybe_unused hibmc_pm_resume(struct device *dev)
> > >  {
> > >         struct pci_dev *pdev = to_pci_dev(dev);
> > >         struct drm_device *drm_dev = pci_get_drvdata(pdev);
> > > -       struct hibmc_drm_private *priv = drm_dev->dev_private;
> > >
> > > -       drm_atomic_helper_resume(drm_dev, priv->suspend_state);
> > > -       drm_kms_helper_poll_enable(drm_dev);
> > > -
> > > -       return 0;
> > > +       return drm_mode_config_helper_resume(drm_dev);
> > >  }
> > >
> > >  static const struct dev_pm_ops hibmc_pm_ops = {
> > > diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
> > > index e195521..45c25a4 100644
> > > --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
> > > +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
> > > @@ -47,7 +47,6 @@ struct hibmc_drm_private {
> > >         /* drm */
> > >         struct drm_device  *dev;
> > >         bool mode_config_initialized;
> > > -       struct drm_atomic_state *suspend_state;
> > >
> > >         /* ttm */
> > >         struct drm_global_reference mem_global_ref;
> > > --
> > > 1.9.1
> > >
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
