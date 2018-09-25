Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0A7C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1E792086E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pMltn7Dx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1E792086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbeIYSvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 14:51:24 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33182 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728773AbeIYSvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 14:51:23 -0400
Received: by mail-lj1-f193.google.com with SMTP id l19-v6so7089372ljb.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 05:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Clp+MLrTWiDC2LMN7Mi6tOoYK+QihCb8ndogVELRDHc=;
        b=pMltn7DxVRwEeQOPSuWWdE/CBHMMjrEniigEl+XExhlSFBoyJ4Q1iR4+c1HuGmxDsK
         w+UXS3WeEZ0qAF1bJ5Wkcxs+txGcQiJRjB3Bj0NwmOLUsJlK5IdH6HaFEqM7l4yHMMen
         RY2P1pnKzIOErSqtgP2MKddziYHHDkwQVFCvuWiK/rwl8/Mc+rcDgNhQfmnKSe3momXq
         U6zGTqU7rpUbfYZkk0qsVZ9mvHew4ZHDDtdxFoi5YKBamUUvIwozicDokguhDUGRkYb5
         kCe12H5b0med1xMXAMEP97qV4CkVkJ8BvcIMgRSWBT3T/yqKK7rvSEK3CtM5/8m6+Qdu
         EXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Clp+MLrTWiDC2LMN7Mi6tOoYK+QihCb8ndogVELRDHc=;
        b=I2wMEuXB0n8rnp1b9FI7b7AhXq5caS6e+AQNxB+gctMetwzPxp0jUtlbUZ5vsYHlaX
         eetXh/YXm/Zx0bJmCymCpJ9pfqjsj3CNs1eMXpSDZsHEc1i8/U0tI71wyErqRAzjTcim
         DQRHYCTPFIWOKzFh1+iJpYg/Sbl2NbNTX4Q/GpvIZrjtAEBD2zzxDrrbOJraThXPziso
         8JgaRR5owEtEgsbEaYiuoBBAfkDrITIvMsbeyHTiUwzx+xPrZbIduzvIXlH//jGfHb75
         FbVXxQvR2F2P2cWxsGncL/067bSEZoZGCLYxl7u+tB5N8EBKEtBNdObC2p9QQEpoAljb
         JEWg==
X-Gm-Message-State: ABuFfojrOmY/y7d0pjKj9Roa39dXnSkSTu2RlOKrJVh8wdT+ZzK4KlBp
        7RlbLY7G7vC1t+JuQ1YgLBcwsxSMzp5nlBHQhzU=
X-Google-Smtp-Source: ACcGV60K8pzm94c43hp54EeUNZMlxZ9lj5f0zjmioaN2lKN3eOoStSW4cUyqXew819r29CddJAjKxvgNi2OrTsvS2k0=
X-Received: by 2002:a2e:1652:: with SMTP id 18-v6mr766842ljw.56.1537879437387;
 Tue, 25 Sep 2018 05:43:57 -0700 (PDT)
MIME-Version: 1.0
References: <20180806144900.GA13925@jordon-HP-15-Notebook-PC>
 <CAFqt6zYWehpkSNf7LHFXFaY1s-aAdXg=OV0C9Hr8j9fS-P3OCw@mail.gmail.com>
 <CAFqt6zYyBQhbvQiy4EWOpHHL-a77Fjm9LCLNA+drT62MhHuKeQ@mail.gmail.com> <CAGd==041pgoA+5Xx6+tWm6zY=_B6FZ0+=TX3iG3zzuWQmQW0Dg@mail.gmail.com>
In-Reply-To: <CAGd==041pgoA+5Xx6+tWm6zY=_B6FZ0+=TX3iG3zzuWQmQW0Dg@mail.gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 25 Sep 2018 18:13:44 +0530
Message-ID: <CAFqt6zZH9tDU_3vEAEhM4dFZk7RxmKOxGT0QXtDhF2ez+fP6bA@mail.gmail.com>
Subject: Re: [PATCH] gpu/drm/hisilicon: Convert drm_atomic_helper_suspend/resume()
To:     xinliang.liu@linaro.org
Cc:     xinliang <z.liuxinliang@hisilicon.com>,
        Zou Rongrong <zourongrong@gmail.com>,
        kong.kongxinwei@hisilicon.com, puck.chen@hisilicon.com,
        airlied@linux.ie, Ajit Linux <ajitn.linux@gmail.com>,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 6:07 PM Xinliang Liu <xinliang.liu@linaro.org> wrote:
>
> Hi Souptick,
>
> On Mon, 17 Sep 2018 at 15:40, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> >
> > On Tue, Sep 11, 2018 at 2:04 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
> > >
> > > On Mon, Aug 6, 2018 at 8:16 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
> > > >
> > > > convert drm_atomic_helper_suspend/resume() to use
> > > > drm_mode_config_helper_suspend/resume().
> > > >
> > > > Fixed one sparse warning by making hibmc_drm_interrupt
> > > > static.
> > > >
> > > > Signed-off-by: Ajit Negi <ajitn.linux@gmail.com>
> > > > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > > > Reviewed-by: Xinliang Liu <z.liuxinliang@hisilicon.com>
> > >
> > > Can we get this patch in queue for 4.20 ??
> >
> > Daniel, can we get this patch in queue for 4.20, if no further comment  ?
>
> Will send 4.20 drm-next pull for this patch. I am verifying it on our D05 board.

Thanks.
> > >
> > > > ---
> > > > v2: remove ret variable from both suspend and resume.
> > > >     remove suspend_state from hibmc_drm_private struct.
> > > >
> > > >  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 20 +++-----------------
> > > >  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h |  1 -
> > > >  2 files changed, 3 insertions(+), 18 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> > > > index d4f6f1f..ee24480 100644
> > > > --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> > > > +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> > > > @@ -37,7 +37,7 @@
> > > >         .llseek         = no_llseek,
> > > >  };
> > > >
> > > > -irqreturn_t hibmc_drm_interrupt(int irq, void *arg)
> > > > +static irqreturn_t hibmc_drm_interrupt(int irq, void *arg)
> > > >  {
> > > >         struct drm_device *dev = (struct drm_device *)arg;
> > > >         struct hibmc_drm_private *priv =
> > > > @@ -74,30 +74,16 @@ static int __maybe_unused hibmc_pm_suspend(struct device *dev)
> > > >  {
> > > >         struct pci_dev *pdev = to_pci_dev(dev);
> > > >         struct drm_device *drm_dev = pci_get_drvdata(pdev);
> > > > -       struct hibmc_drm_private *priv = drm_dev->dev_private;
> > > > -
> > > > -       drm_kms_helper_poll_disable(drm_dev);
> > > > -       priv->suspend_state = drm_atomic_helper_suspend(drm_dev);
> > > > -       if (IS_ERR(priv->suspend_state)) {
> > > > -               DRM_ERROR("drm_atomic_helper_suspend failed: %ld\n",
> > > > -                         PTR_ERR(priv->suspend_state));
> > > > -               drm_kms_helper_poll_enable(drm_dev);
> > > > -               return PTR_ERR(priv->suspend_state);
> > > > -       }
> > > >
> > > > -       return 0;
> > > > +       return drm_mode_config_helper_suspend(drm_dev);
> > > >  }
> > > >
> > > >  static int  __maybe_unused hibmc_pm_resume(struct device *dev)
> > > >  {
> > > >         struct pci_dev *pdev = to_pci_dev(dev);
> > > >         struct drm_device *drm_dev = pci_get_drvdata(pdev);
> > > > -       struct hibmc_drm_private *priv = drm_dev->dev_private;
> > > >
> > > > -       drm_atomic_helper_resume(drm_dev, priv->suspend_state);
> > > > -       drm_kms_helper_poll_enable(drm_dev);
> > > > -
> > > > -       return 0;
> > > > +       return drm_mode_config_helper_resume(drm_dev);
> > > >  }
> > > >
> > > >  static const struct dev_pm_ops hibmc_pm_ops = {
> > > > diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
> > > > index e195521..45c25a4 100644
> > > > --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
> > > > +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
> > > > @@ -47,7 +47,6 @@ struct hibmc_drm_private {
> > > >         /* drm */
> > > >         struct drm_device  *dev;
> > > >         bool mode_config_initialized;
> > > > -       struct drm_atomic_state *suspend_state;
> > > >
> > > >         /* ttm */
> > > >         struct drm_global_reference mem_global_ref;
> > > > --
> > > > 1.9.1
> > > >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
