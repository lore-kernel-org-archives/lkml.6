Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C762C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 19:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34F0D20673
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 19:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knjiomJ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34F0D20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbeLGTfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 14:35:46 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:34379 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbeLGTfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 14:35:45 -0500
Received: by mail-it1-f195.google.com with SMTP id x124so2307363itd.1;
        Fri, 07 Dec 2018 11:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=beCD05nZWbeYcBnFZ9Uyu0lGvx1BqGCDThwyEpjQx8U=;
        b=knjiomJ4UMkK/3PkMMhE0rThQ0KFk7Get+MJaa9SNAav1DySr8p/NfohU5xq+0a86o
         V/eMbIpwM/c+Kn0U5HBv559ZKcO+dSv9LpVz8NyyGWWn6wMaY2ICOuIkKqCpepFrS+ya
         QFWJST1mR3IPQVswcZi2H7oS7iKIB/9UYj7ryXUGbghIcmxijO9VcZ7yCxVrEbcSVgB0
         7n79/bAxUjgGuJDv3eQEox3yKShBahJk4xhGyjI/sI6+rl2yv/k4xtU2px/NpDW919YU
         elELuSQWL0ppS5/9GAovO2YaOGdrTQrbGA7TfWHhWwSi+DAsAAsyHWR/mfRnrbdeg1KI
         OClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=beCD05nZWbeYcBnFZ9Uyu0lGvx1BqGCDThwyEpjQx8U=;
        b=bMcG4+yLCsLSlwpEuz/QdjlVgfk/3LI3kve59LzrUPB3ehKAe1W6wRVN0UiG0ebtw6
         PVTld/W7lKJ1WD4aTIQdLVdjd/COYlZ679ts46kh3HGEWNB6K9Ylspo2g4tfh5GGP5tq
         HMRf6q/7NAet3F80zqEkXHhEU+rwscNs6taJBf2I2ukir6pGxxv+D8qe1D0SLvwvEDJi
         Y0tWOic3YUHHaHBTmEYU9wJvpmPRBjOvW7qDt6JQvPgz5byjP1AkReH3z7veMR96raRD
         UGtO3Q5+WHB4xRYgA2BsyPBS/3R5URVcksH27lJ8h6KkkAUIFuS/el98L6BdVPIFerrp
         VSfw==
X-Gm-Message-State: AA+aEWbKWNUYjLDmDmaNrH9QsOL+BlXdUkBvaKKlRjEGQJWOtLzAhIAY
        YqKnRxFtdBPIqTKrVebFA8/2jocUViLAIYZ/rBI=
X-Google-Smtp-Source: AFSGD/URPAkPenSJKLIphnjqmSWE3o2fwnXC6XSgdJGvbOf/8HQ1LdEUsdcK+h9H3jPWX+KxgZKmpwNHLhllSau0N4I=
X-Received: by 2002:a02:3da:: with SMTP id e87mr2737637jae.78.1544211344235;
 Fri, 07 Dec 2018 11:35:44 -0800 (PST)
MIME-Version: 1.0
References: <20181207170656.13208-1-jcrouse@codeaurora.org> <20181207180712.GC20602@jcrouse-lnx.qualcomm.com>
In-Reply-To: <20181207180712.GC20602@jcrouse-lnx.qualcomm.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Fri, 7 Dec 2018 14:35:32 -0500
Message-ID: <CAF6AEGvRQ9h4b8329oddaJZQeK4+P3xZb-LXwAvKAHfSWBBoDQ@mail.gmail.com>
Subject: Re: [Freedreno] [PATCH] drm/msm/a6xx: Add support for an interconnect path
To:     freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 7, 2018 at 1:07 PM Jordan Crouse <jcrouse@codeaurora.org> wrote:
>
> On Fri, Dec 07, 2018 at 10:06:56AM -0700, Jordan Crouse wrote:
> > Try to get the interconnect path for the GPU and vote for the maximum
> > bandwidth to support all frequencies. This is needed for performance.
> > Later we will want to scale the bandwidth based on the frequency to
> > also optimize for power but that will require some device tree
> > infrastructure that does not yet exist.
> >
> > v3: Use macros and change port string per Georgi Djakov
>
> Rob had asked earlier if it would be appropriate and/or possible to merge this
> with the generic interconnect patches and with his blessing I would like to
> renew that request. This should merge cleanly against tip of tree and it would
> be nice to get this support in at the same time that the base patches go in.
>

Acked-by: Rob Clark <robdclark@gmail.com>

for landing this via Georgi's tree.. that seems easier than having to
do a 2nd late pull-req for drm to get the driver parts merged..

BR,
-R


> Jordan
>
> > Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> > ---
> >  drivers/gpu/drm/msm/Kconfig             |  1 +
> >  drivers/gpu/drm/msm/adreno/a6xx_gmu.c   | 20 ++++++++++++++++++++
> >  drivers/gpu/drm/msm/adreno/adreno_gpu.c |  9 +++++++++
> >  drivers/gpu/drm/msm/msm_gpu.h           |  3 +++
> >  4 files changed, 33 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
> > index 843a9d40c05e..990c4350f0c4 100644
> > --- a/drivers/gpu/drm/msm/Kconfig
> > +++ b/drivers/gpu/drm/msm/Kconfig
> > @@ -5,6 +5,7 @@ config DRM_MSM
> >       depends on ARCH_QCOM || (ARM && COMPILE_TEST)
> >       depends on OF && COMMON_CLK
> >       depends on MMU
> > +     depends on INTERCONNECT || !INTERCONNECT
> >       select QCOM_MDT_LOADER if ARCH_QCOM
> >       select REGULATOR
> >       select DRM_KMS_HELPER
> > diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> > index 546599a7ab05..f37a9bfe5c30 100644
> > --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> > +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> > @@ -2,6 +2,7 @@
> >  /* Copyright (c) 2017-2018 The Linux Foundation. All rights reserved. */
> >
> >  #include <linux/clk.h>
> > +#include <linux/interconnect.h>
> >  #include <linux/pm_opp.h>
> >  #include <soc/qcom/cmd-db.h>
> >
> > @@ -63,6 +64,9 @@ static bool a6xx_gmu_gx_is_on(struct a6xx_gmu *gmu)
> >
> >  static void __a6xx_gmu_set_freq(struct a6xx_gmu *gmu, int index)
> >  {
> > +     struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
> > +     struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
> > +     struct msm_gpu *gpu = &adreno_gpu->base;
> >       int ret;
> >
> >       gmu_write(gmu, REG_A6XX_GMU_DCVS_ACK_OPTION, 0);
> > @@ -85,6 +89,12 @@ static void __a6xx_gmu_set_freq(struct a6xx_gmu *gmu, int index)
> >               dev_err(gmu->dev, "GMU set GPU frequency error: %d\n", ret);
> >
> >       gmu->freq = gmu->gpu_freqs[index];
> > +
> > +     /*
> > +      * Eventually we will want to scale the path vote with the frequency but
> > +      * for now leave it at max so that the performance is nominal.
> > +      */
> > +     icc_set(gpu->icc_path, 0, MBps_to_icc(7216));
> >  }
> >
> >  void a6xx_gmu_set_freq(struct msm_gpu *gpu, unsigned long freq)
> > @@ -680,6 +690,8 @@ int a6xx_gmu_reset(struct a6xx_gpu *a6xx_gpu)
> >
> >  int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
> >  {
> > +     struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
> > +     struct msm_gpu *gpu = &adreno_gpu->base;
> >       struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
> >       int status, ret;
> >
> > @@ -695,6 +707,9 @@ int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
> >       if (ret)
> >               goto out;
> >
> > +     /* Set the bus quota to a reasonable value for boot */
> > +     icc_set(gpu->icc_path, 0, MBps_to_icc(3072));
> > +
> >       a6xx_gmu_irq_enable(gmu);
> >
> >       /* Check to see if we are doing a cold or warm boot */
> > @@ -735,6 +750,8 @@ bool a6xx_gmu_isidle(struct a6xx_gmu *gmu)
> >
> >  int a6xx_gmu_stop(struct a6xx_gpu *a6xx_gpu)
> >  {
> > +     struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
> > +     struct msm_gpu *gpu = &adreno_gpu->base;
> >       struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
> >       u32 val;
> >
> > @@ -781,6 +798,9 @@ int a6xx_gmu_stop(struct a6xx_gpu *a6xx_gpu)
> >       /* Tell RPMh to power off the GPU */
> >       a6xx_rpmh_stop(gmu);
> >
> > +     /* Remove the bus vote */
> > +     icc_set(gpu->icc_path, 0, 0);
> > +
> >       clk_bulk_disable_unprepare(gmu->nr_clocks, gmu->clocks);
> >
> >       pm_runtime_put_sync(gmu->dev);
> > diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > index 93d70f4a2154..7403ade9aabc 100644
> > --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > @@ -18,6 +18,7 @@
> >   */
> >
> >  #include <linux/ascii85.h>
> > +#include <linux/interconnect.h>
> >  #include <linux/kernel.h>
> >  #include <linux/pm_opp.h>
> >  #include <linux/slab.h>
> > @@ -695,6 +696,11 @@ static int adreno_get_pwrlevels(struct device *dev,
> >
> >       DBG("fast_rate=%u, slow_rate=27000000", gpu->fast_rate);
> >
> > +     /* Check for an interconnect path for the bus */
> > +     gpu->icc_path = of_icc_get(dev, "gfx-mem");
> > +     if (IS_ERR(gpu->icc_path))
> > +             gpu->icc_path = NULL;
> > +
> >       return 0;
> >  }
> >
> > @@ -733,10 +739,13 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
> >
> >  void adreno_gpu_cleanup(struct adreno_gpu *adreno_gpu)
> >  {
> > +     struct msm_gpu *gpu = &adreno_gpu->base;
> >       unsigned int i;
> >
> >       for (i = 0; i < ARRAY_SIZE(adreno_gpu->info->fw); i++)
> >               release_firmware(adreno_gpu->fw[i]);
> >
> > +     icc_put(gpu->icc_path);
> > +
> >       msm_gpu_cleanup(&adreno_gpu->base);
> >  }
> > diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
> > index f82bac086666..12fc5b1cb39d 100644
> > --- a/drivers/gpu/drm/msm/msm_gpu.h
> > +++ b/drivers/gpu/drm/msm/msm_gpu.h
> > @@ -19,6 +19,7 @@
> >  #define __MSM_GPU_H__
> >
> >  #include <linux/clk.h>
> > +#include <linux/interconnect.h>
> >  #include <linux/regulator/consumer.h>
> >
> >  #include "msm_drv.h"
> > @@ -119,6 +120,8 @@ struct msm_gpu {
> >       struct clk *ebi1_clk, *core_clk, *rbbmtimer_clk;
> >       uint32_t fast_rate;
> >
> > +     struct icc_path *icc_path;
> > +
> >       /* Hang and Inactivity Detection:
> >        */
> >  #define DRM_MSM_INACTIVE_PERIOD   66 /* in ms (roughly four frames) */
> > --
> > 2.18.0
> >
> > _______________________________________________
> > Freedreno mailing list
> > Freedreno@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/freedreno
>
> --
> The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
