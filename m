Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E10EC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB962086B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abUEPkUT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAB962086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbeIJNAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:00:18 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37396 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbeIJNAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:00:18 -0400
Received: by mail-lf1-f66.google.com with SMTP id j8-v6so16647634lfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 01:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DEanT5STU0/oQw8z/5QuYfY/ru455E/DyywX6JOmCHc=;
        b=abUEPkUT5Yg+otS7s5oqYPqxRyLHwBYPTGNsQYx6mb9OBQIYmAZKtMcYwFO3c1yN9J
         Hs0AKxur+QyrT/iYj/ybgCXJ9h5qazF/dkHF58vFtuBU9oWBnB9g3+WnJG2cffk6cWZM
         ss//g43NaiqFica204/RfKfyAnNPBKL94qO79WRCXbQbFRk5nft3+8Y6dhOSQvIc+eqt
         ymHPMAMWXKiafMwGbLpKrBiTPqyiY6pRaXo1d2rY5GjlqqSIDisdpH+fvnwBf+/19WCS
         R7qy9cqE8uNFhyJGc80REHWWYkKv2RF8Zr7Li4R5Fi+H9wi8pee81fsQW+fVwmOqcP2F
         hdrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DEanT5STU0/oQw8z/5QuYfY/ru455E/DyywX6JOmCHc=;
        b=UcBqypRkJhbKnf9lfq3VsY6Y6CtaZZ7635QKmVq55DcUmKUQd3wOBEwOB2rfYQiNWd
         vyOWL2o04jdOR/PwBZqqbkJqcY+KXo4+qAPTXw6DeWKxQgb5UMzgHfwbV/UuC1S+FGva
         vDmdWn0uScDjEjpLfNzjNLgIdi14/6ytug9TusqufufmUbEyEiaSnhWT/QELu5U4rEsq
         y+gKrNVq6wYF7DHu8ETvgPdwkRuGLrSCmbiXaSVfWs4sKfUUixP3CC4xJGm7TFmHSPYP
         p6AvGIcXCO6Eydt9YUeHmVlS259myhSqZlUk9W4MYZklxUHL8i29I6O+jjLKKLjhCY3G
         1Ilw==
X-Gm-Message-State: APzg51D6cTfq2/LBtGjRFpnSGcc8JU/civQhGcbt+iQt/WJ5Rr1s+q7T
        4ZzTpOgUsYXPgZMo+W27muwmioz/3wpMMBt4ZIA=
X-Google-Smtp-Source: ANB0Vdac+52eTInBuDUicTVPu5GmwsaUrzTZvBuv0ujFmDQ7fUmDmeUc2/HgRZnfhm21cYe5QDLk1BppEcyfi0qMxnk=
X-Received: by 2002:a19:6756:: with SMTP id e22-v6mr11198296lfj.54.1536566849489;
 Mon, 10 Sep 2018 01:07:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180808161641.GA20483@jordon-HP-15-Notebook-PC>
 <CAFqt6zYn_kf+sQ0Dih83CH7hVR2f6ZW-ANVRm9+MX54KcMk=jQ@mail.gmail.com> <1f0a17d5-59cc-0d6a-a1dc-a865975bffe2@ti.com>
In-Reply-To: <1f0a17d5-59cc-0d6a-a1dc-a865975bffe2@ti.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 10 Sep 2018 13:37:17 +0530
Message-ID: <CAFqt6zb=fUvFqF0BBBNJXnZjDQVGxaO-1oSZkokZRsR9eDR8YQ@mail.gmail.com>
Subject: Re: [PATCH] drm/tilcdc: Convert drm_atomic_helper_suspend/resume()
To:     jsarha@ti.com
Cc:     Tomi Valkeinen <tomi.valkeinen@ti.com>, airlied@linux.ie,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Ajit Linux <ajitn.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 1:11 PM Jyri Sarha <jsarha@ti.com> wrote:
>
> On 10/09/18 09:45, Souptick Joarder wrote:
> > On Wed, Aug 8, 2018 at 9:43 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
> >>
> >> convert drm_atomic_helper_suspend/resume() to use
> >> drm_mode_config_helper_suspend/resume().
> >>
> >> saved_state in tilcdc_drm_private will not be used
> >> anymore, so it can be removed.
> >
> > Any comment on this patch ?
>
> I planned to test this out, but I did not find time to do that. But here
> is my:
>
> Reviewed-by: Jyri Sarha <jsarha@ti.com>
>
> I'll pick this up for my next pull request.
>

Thanks, Hopefully It will make into 4.20 :)

> BR,
> Jyri
>
> >>
> >> Signed-off-by: Ajit Negi <ajitn.linux@gmail.com>
> >> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> >> ---
> >>  drivers/gpu/drm/tilcdc/tilcdc_drv.c | 14 ++++----------
> >>  drivers/gpu/drm/tilcdc/tilcdc_drv.h |  3 ---
> >>  2 files changed, 4 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> >> index 0fb300d..33e5332 100644
> >> --- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> >> +++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> >> @@ -554,29 +554,23 @@ static int tilcdc_debugfs_init(struct drm_minor *minor)
> >>  static int tilcdc_pm_suspend(struct device *dev)
> >>  {
> >>         struct drm_device *ddev = dev_get_drvdata(dev);
> >> -       struct tilcdc_drm_private *priv = ddev->dev_private;
> >> +       int ret = 0;
> >>
> >> -       priv->saved_state = drm_atomic_helper_suspend(ddev);
> >> +       ret = drm_mode_config_helper_suspend(ddev);
> >>
> >>         /* Select sleep pin state */
> >>         pinctrl_pm_select_sleep_state(dev);
> >>
> >> -       return 0;
> >> +       return ret;
> >>  }
> >>
> >>  static int tilcdc_pm_resume(struct device *dev)
> >>  {
> >>         struct drm_device *ddev = dev_get_drvdata(dev);
> >> -       struct tilcdc_drm_private *priv = ddev->dev_private;
> >> -       int ret = 0;
> >>
> >>         /* Select default pin state */
> >>         pinctrl_pm_select_default_state(dev);
> >> -
> >> -       if (priv->saved_state)
> >> -               ret = drm_atomic_helper_resume(ddev, priv->saved_state);
> >> -
> >> -       return ret;
> >> +       return  drm_mode_config_helper_resume(ddev);
> >>  }
> >>  #endif
> >>
> >> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.h b/drivers/gpu/drm/tilcdc/tilcdc_drv.h
> >> index ead5122..62cea5f 100644
> >> --- a/drivers/gpu/drm/tilcdc/tilcdc_drv.h
> >> +++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.h
> >> @@ -70,9 +70,6 @@ struct tilcdc_drm_private {
> >>         const uint32_t *pixelformats;
> >>         uint32_t num_pixelformats;
> >>
> >> -       /* The context for pm susped/resume cycle is stored here */
> >> -       struct drm_atomic_state *saved_state;
> >> -
> >>  #ifdef CONFIG_CPU_FREQ
> >>         struct notifier_block freq_transition;
> >>  #endif
> >> --
> >> 1.9.1
> >>
>
>
> --
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
