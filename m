Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F6BECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 05:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92ABB2086B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 05:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZyFeQZM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92ABB2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbeIQKnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 06:43:14 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41605 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbeIQKnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 06:43:14 -0400
Received: by mail-lj1-f193.google.com with SMTP id y17-v6so12000072ljy.8
        for <linux-kernel@vger.kernel.org>; Sun, 16 Sep 2018 22:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z+S/xVSlFt4RjonH7tI/KM5sUlNiH6lX11CBOmk2DTo=;
        b=bZyFeQZMKEoQf34Ddex2xHaGvPtj8HHkc7qzoUTF3FelnxDvOy30qsoZL/+EyXD3XB
         T6NlSINCiBQgWg0TEEP8eiU4HNY9gPOiONR9Ro6nYl57KJTLbmF98EThXfYpclcv64X1
         T9GfYVKsghWHeSZl2SsOuNYPJmY1nxWpbNDV/SFFvbPZNfciqeQzZ616ovnAbxu8Lh7p
         e3wjzne/WlANOFsgI7LeL1IFT7uiV8g9RA1mzXVRbQb3v3F82kFhnmNq9DavVu/qyA3W
         DKxQoWClch4SFGdK+xxI8QhE6jh364fK7/iy52ugHt/DC4iNoBymoeVrWRfVu6Tzm2z+
         uRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z+S/xVSlFt4RjonH7tI/KM5sUlNiH6lX11CBOmk2DTo=;
        b=YwHdL4A2t5c+l1a3TrLzPgf5hSxIKQG89SWynBKMc/tynWFAPJGbP3ZRYyk5+Mx/Ej
         ccJsASbJ5imXNygY0+nGItwYZ8W+mV7BiXdpBWTijFFtpiBg7hLKY2RhhX49bZUQOexD
         11II/1FkVArHcy84ahN4THVGZKd8xihvSFrJ5CniHLDpGiRZsqF9t2UswsP1YFBg0Zgx
         esLrk5gtbGWPTEZO1wD2jnlaN55bRES6/m5j3mGwHEKjRJbS8XLlCp2N27nOR2GvF8GM
         N4A68Tl7FMQzkbewt7zTS80Xv9R0WBoaikJrW9/9FIYgZQWcjoi4FeIoTO5STZX/y09Z
         Q8og==
X-Gm-Message-State: APzg51BpRjVFPFImsj6J6B+YHMvyRDxp8KbtbYSM4E/y7JlNodCtlGCf
        fLsuPIXjPyr8Pl3I3IyNXFv5NwxpDNsiimdihgozkw==
X-Google-Smtp-Source: ANB0Vdb4SC0JsJLtMXy/pZ523zplqzxLPibusu+2WHZRoOF+wIH/TexqMtCspEBW+87dpU73J9Ui5mWhC81qydnhQRk=
X-Received: by 2002:a2e:8ed1:: with SMTP id e17-v6mr13572662ljl.86.1537161449113;
 Sun, 16 Sep 2018 22:17:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180806144900.GA13925@jordon-HP-15-Notebook-PC> <CAFqt6zYWehpkSNf7LHFXFaY1s-aAdXg=OV0C9Hr8j9fS-P3OCw@mail.gmail.com>
In-Reply-To: <CAFqt6zYWehpkSNf7LHFXFaY1s-aAdXg=OV0C9Hr8j9fS-P3OCw@mail.gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 17 Sep 2018 10:47:16 +0530
Message-ID: <CAFqt6zYyBQhbvQiy4EWOpHHL-a77Fjm9LCLNA+drT62MhHuKeQ@mail.gmail.com>
Subject: Re: [PATCH] gpu/drm/hisilicon: Convert drm_atomic_helper_suspend/resume()
To:     xinliang <z.liuxinliang@hisilicon.com>,
        Zou Rongrong <zourongrong@gmail.com>,
        kong.kongxinwei@hisilicon.com, puck.chen@hisilicon.com,
        airlied@linux.ie, Ajit Linux <ajitn.linux@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 2:04 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> On Mon, Aug 6, 2018 at 8:16 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
> >
> > convert drm_atomic_helper_suspend/resume() to use
> > drm_mode_config_helper_suspend/resume().
> >
> > Fixed one sparse warning by making hibmc_drm_interrupt
> > static.
> >
> > Signed-off-by: Ajit Negi <ajitn.linux@gmail.com>
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > Reviewed-by: Xinliang Liu <z.liuxinliang@hisilicon.com>
>
> Can we get this patch in queue for 4.20 ??

Daniel, can we get this patch in queue for 4.20, if no further comment  ?

>
> > ---
> > v2: remove ret variable from both suspend and resume.
> >     remove suspend_state from hibmc_drm_private struct.
> >
> >  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 20 +++-----------------
> >  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h |  1 -
> >  2 files changed, 3 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> > index d4f6f1f..ee24480 100644
> > --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> > +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> > @@ -37,7 +37,7 @@
> >         .llseek         = no_llseek,
> >  };
> >
> > -irqreturn_t hibmc_drm_interrupt(int irq, void *arg)
> > +static irqreturn_t hibmc_drm_interrupt(int irq, void *arg)
> >  {
> >         struct drm_device *dev = (struct drm_device *)arg;
> >         struct hibmc_drm_private *priv =
> > @@ -74,30 +74,16 @@ static int __maybe_unused hibmc_pm_suspend(struct device *dev)
> >  {
> >         struct pci_dev *pdev = to_pci_dev(dev);
> >         struct drm_device *drm_dev = pci_get_drvdata(pdev);
> > -       struct hibmc_drm_private *priv = drm_dev->dev_private;
> > -
> > -       drm_kms_helper_poll_disable(drm_dev);
> > -       priv->suspend_state = drm_atomic_helper_suspend(drm_dev);
> > -       if (IS_ERR(priv->suspend_state)) {
> > -               DRM_ERROR("drm_atomic_helper_suspend failed: %ld\n",
> > -                         PTR_ERR(priv->suspend_state));
> > -               drm_kms_helper_poll_enable(drm_dev);
> > -               return PTR_ERR(priv->suspend_state);
> > -       }
> >
> > -       return 0;
> > +       return drm_mode_config_helper_suspend(drm_dev);
> >  }
> >
> >  static int  __maybe_unused hibmc_pm_resume(struct device *dev)
> >  {
> >         struct pci_dev *pdev = to_pci_dev(dev);
> >         struct drm_device *drm_dev = pci_get_drvdata(pdev);
> > -       struct hibmc_drm_private *priv = drm_dev->dev_private;
> >
> > -       drm_atomic_helper_resume(drm_dev, priv->suspend_state);
> > -       drm_kms_helper_poll_enable(drm_dev);
> > -
> > -       return 0;
> > +       return drm_mode_config_helper_resume(drm_dev);
> >  }
> >
> >  static const struct dev_pm_ops hibmc_pm_ops = {
> > diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
> > index e195521..45c25a4 100644
> > --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
> > +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
> > @@ -47,7 +47,6 @@ struct hibmc_drm_private {
> >         /* drm */
> >         struct drm_device  *dev;
> >         bool mode_config_initialized;
> > -       struct drm_atomic_state *suspend_state;
> >
> >         /* ttm */
> >         struct drm_global_reference mem_global_ref;
> > --
> > 1.9.1
> >
