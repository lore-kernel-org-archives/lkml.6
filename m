Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4949CECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 06:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECD9620685
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 06:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PicGUSEZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD9620685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbeIRLdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 07:33:38 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38510 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbeIRLdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 07:33:38 -0400
Received: by mail-lf1-f68.google.com with SMTP id z186-v6so646008lfa.5;
        Mon, 17 Sep 2018 23:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cw9MBjFl6kMTvJfej6PY+IpmfNK4j9G5QWxzLp37qcE=;
        b=PicGUSEZ6zc3xwTJ0fnzLqBD2RnfVVYcUt7agoOYztG7Mr4VvVWJN8bguyoEPwuiGJ
         Kp39sR6e6+PnXDIWLcwWpu+UK/32NxL20kSVhTnrJGgqocWd5NgUEbfjBpBpzmsPoTwV
         CPkjWLfVeIs14gMg1gy9F1cc0WNeJNyEjc5TQcrw4/ePwKSbjRuTVafxPaslfKOWPylb
         NKhCP9xefakhe8bu6E0S0n0u4vPyBTSyGJ95mchQVSDmtjnfqiuBLywIWtJ+pGq5vL4u
         8vjjWP00C1bPJftiOT0Lc084CtuOawArTq+4Jb+9lyXDU4rJgwiZ4RPxT1tK6zZWwsss
         MrRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cw9MBjFl6kMTvJfej6PY+IpmfNK4j9G5QWxzLp37qcE=;
        b=Nyj6pXiDVrABS8MPwr4F9NZRafdkFvFuTJApJEr+7y3bKYPeidwLTT6G2vKQSG87zk
         G7YyM4l1btWEW201VTZEiukQRlupaKiPcW4JKV84bFfutmof5FkSRvYXWaf1B89XtfR9
         KZFh3P1H2N9MjULmDYduMC6sS+qXdj6KAoSwUPAsEWIt1DRkDO0wbCpe5sNNUoTzvpty
         3gTFxgzRFXom0xsSnTXmvIWsl4tjVtdvmGL787fvho+tBQlsWgnnIsEZLmwlcDzdcXzT
         l4ltify+mqrzDPgZ0AWn/NnhWPeup6NIgt8UQtiVd9SgAaZhmenrH+N58AIrSTxDbPcR
         PXlw==
X-Gm-Message-State: APzg51AF755JpsoPpo3I4EVFLms7KavCGwda4CHv6iEKLV6YIo8rxGNE
        RjBuyGX6CxbEazOw+oRyc0eZdciXGeVY1yHVVu6Qsg==
X-Google-Smtp-Source: ANB0VdZovNu6DrSfxl78zpIrJbDUuieA5zYFgdRkrIkL/hBCXJLnoABc9063iET71bsxWfGNH8iz402k2y1/nSb1C2k=
X-Received: by 2002:a19:cc97:: with SMTP id c145-v6mr8762791lfg.145.1537250554139;
 Mon, 17 Sep 2018 23:02:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180802154517.GA10593@jordon-HP-15-Notebook-PC> <CAFqt6zZDRaVp53RnEri+P4b8+GByE-UQwerJmuLBe6E=GK0kDQ@mail.gmail.com>
In-Reply-To: <CAFqt6zZDRaVp53RnEri+P4b8+GByE-UQwerJmuLBe6E=GK0kDQ@mail.gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 18 Sep 2018 11:32:22 +0530
Message-ID: <CAFqt6zbp+yFq-59o-J5dtB8Gfc3Ggd6Ff6tCy5vt0OTTSr41vQ@mail.gmail.com>
Subject: Re: [PATCH v4] gpu/drm/exynos: Convert drm_atomic_helper_suspend/resume()
To:     Inki Dae <inki.dae@samsung.com>, jy0922.shim@samsung.com,
        sw0312.kim@samsung.com, Kyungmin Park <kyungmin.park@samsung.com>,
        airlied@linux.ie, kgene@kernel.org, krzk@kernel.org,
        Ajit Linux <ajitn.linux@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Inki,
On Tue, Sep 11, 2018 at 2:06 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> On Thu, Aug 2, 2018 at 9:12 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
> >
> > convert drm_atomic_helper_suspend/resume() to use
> > drm_mode_config_helper_suspend/resume().
> >
> > exynos_drm_fbdev_suspend/resume can be removed
> > as drm_mode_config_helper_suspend/resume has
> > implement the same in generic way.
> >
> > Remove suspend_state from exynos_drm_private
> > struct as it is no more useful.
> >
> > Signed-off-by: Ajit Negi <ajitn.linux@gmail.com>
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>
> Can we get this patch in queue for 4.20 ? Not yet available in linux-next.

Is this patch queued for 4.20 ?

> > ---
> > v2: Address Inki Dae's comment. Remove ret variable
> >     from both suspend/resume function.
> >
> > v3: Tested by Marek. Updated the change log.
> >
> > v4: removing the return as exynos_drm_resume()
> >     now returns void.
> >
> >  drivers/gpu/drm/exynos/exynos_drm_drv.c   | 26 ++------------------------
> >  drivers/gpu/drm/exynos/exynos_drm_drv.h   |  1 -
> >  drivers/gpu/drm/exynos/exynos_drm_fbdev.c | 17 -----------------
> >  drivers/gpu/drm/exynos/exynos_drm_fbdev.h | 10 ----------
> >  4 files changed, 2 insertions(+), 52 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.c b/drivers/gpu/drm/exynos/exynos_drm_drv.c
> > index b599f74..6f76baf 100644
> > --- a/drivers/gpu/drm/exynos/exynos_drm_drv.c
> > +++ b/drivers/gpu/drm/exynos/exynos_drm_drv.c
> > @@ -149,37 +149,15 @@ static void exynos_drm_postclose(struct drm_device *dev, struct drm_file *file)
> >  static int exynos_drm_suspend(struct device *dev)
> >  {
> >         struct drm_device *drm_dev = dev_get_drvdata(dev);
> > -       struct exynos_drm_private *private;
> > -
> > -       if (!drm_dev)
> > -               return 0;
> > -
> > -       private = drm_dev->dev_private;
> > -
> > -       drm_kms_helper_poll_disable(drm_dev);
> > -       exynos_drm_fbdev_suspend(drm_dev);
> > -       private->suspend_state = drm_atomic_helper_suspend(drm_dev);
> > -       if (IS_ERR(private->suspend_state)) {
> > -               exynos_drm_fbdev_resume(drm_dev);
> > -               drm_kms_helper_poll_enable(drm_dev);
> > -               return PTR_ERR(private->suspend_state);
> > -       }
> >
> > -       return 0;
> > +       return  drm_mode_config_helper_suspend(drm_dev);
> >  }
> >
> >  static void exynos_drm_resume(struct device *dev)
> >  {
> >         struct drm_device *drm_dev = dev_get_drvdata(dev);
> > -       struct exynos_drm_private *private;
> > -
> > -       if (!drm_dev)
> > -               return;
> >
> > -       private = drm_dev->dev_private;
> > -       drm_atomic_helper_resume(drm_dev, private->suspend_state);
> > -       exynos_drm_fbdev_resume(drm_dev);
> > -       drm_kms_helper_poll_enable(drm_dev);
> > +       drm_mode_config_helper_resume(drm_dev);
> >  }
> >
> >  static const struct dev_pm_ops exynos_drm_pm_ops = {
> > diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.h b/drivers/gpu/drm/exynos/exynos_drm_drv.h
> > index c737c4b..7349e7c 100644
> > --- a/drivers/gpu/drm/exynos/exynos_drm_drv.h
> > +++ b/drivers/gpu/drm/exynos/exynos_drm_drv.h
> > @@ -195,7 +195,6 @@ struct drm_exynos_file_private {
> >   */
> >  struct exynos_drm_private {
> >         struct drm_fb_helper *fb_helper;
> > -       struct drm_atomic_state *suspend_state;
> >
> >         struct device *g2d_dev;
> >         struct device *dma_dev;
> > diff --git a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
> > index 132dd52..918dd2c 100644
> > --- a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
> > +++ b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
> > @@ -270,20 +270,3 @@ void exynos_drm_fbdev_fini(struct drm_device *dev)
> >         private->fb_helper = NULL;
> >  }
> >
> > -void exynos_drm_fbdev_suspend(struct drm_device *dev)
> > -{
> > -       struct exynos_drm_private *private = dev->dev_private;
> > -
> > -       console_lock();
> > -       drm_fb_helper_set_suspend(private->fb_helper, 1);
> > -       console_unlock();
> > -}
> > -
> > -void exynos_drm_fbdev_resume(struct drm_device *dev)
> > -{
> > -       struct exynos_drm_private *private = dev->dev_private;
> > -
> > -       console_lock();
> > -       drm_fb_helper_set_suspend(private->fb_helper, 0);
> > -       console_unlock();
> > -}
> > diff --git a/drivers/gpu/drm/exynos/exynos_drm_fbdev.h b/drivers/gpu/drm/exynos/exynos_drm_fbdev.h
> > index b338472..6840b6a 100644
> > --- a/drivers/gpu/drm/exynos/exynos_drm_fbdev.h
> > +++ b/drivers/gpu/drm/exynos/exynos_drm_fbdev.h
> > @@ -19,8 +19,6 @@
> >
> >  int exynos_drm_fbdev_init(struct drm_device *dev);
> >  void exynos_drm_fbdev_fini(struct drm_device *dev);
> > -void exynos_drm_fbdev_suspend(struct drm_device *drm);
> > -void exynos_drm_fbdev_resume(struct drm_device *drm);
> >
> >  #else
> >
> > @@ -39,14 +37,6 @@ static inline void exynos_drm_fbdev_restore_mode(struct drm_device *dev)
> >
> >  #define exynos_drm_output_poll_changed (NULL)
> >
> > -static inline void exynos_drm_fbdev_suspend(struct drm_device *drm)
> > -{
> > -}
> > -
> > -static inline void exynos_drm_fbdev_resume(struct drm_device *drm)
> > -{
> > -}
> > -
> >  #endif
> >
> >  #endif
> > --
> > 1.9.1
> >
