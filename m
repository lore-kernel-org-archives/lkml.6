Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E94C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 19:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6FC820832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 19:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/LsZbC2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6FC820832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbeK2GMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 01:12:45 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:43826 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbeK2GMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 01:12:45 -0500
Received: by mail-io1-f67.google.com with SMTP id g8so20882242iop.10;
        Wed, 28 Nov 2018 11:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MpzeY3M5c36pB7uV+l/sCZzsiKUOR04rRXMdUH8swrk=;
        b=F/LsZbC2NNLTK0eqZ5/mrGcb0CsxnliATJa/MU621C8HwZs24uAk+u5vNKfRnV0clP
         QxwnYgfj56PcA3xkpR6pYTMGb3pJrH9OblsA42lbyFdjTiSMKNCRHADcUgy12C4wbco5
         uTJgUzllUmuNROegPx/mDcXcKSyPMa4Rie/DRIpnXJl3CU5az9xbGX2mR/uRUU8pLvCx
         NsjORgi1TEMAVib5vJSZ7dJsRbn5nozCjtMksrIKNvP6Wf0H/51q0+tP3jraDk4LQ2+p
         sLbnE2as8hXHlPPpHXOWoyFL/xYn1wipZe/VPi8HbWRBQu0Hf2yCVEBXPdXBARJS4anp
         V8bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MpzeY3M5c36pB7uV+l/sCZzsiKUOR04rRXMdUH8swrk=;
        b=fLailYRRzGiw0xNmgUo5+hOcJvDgKBxqY8NwAZ7zLRsF704W+dvu6GYc/U1XuTgfNf
         o3PdYqLP8DBZedqAI4GTWzbYjhTIOPxFS6K31XDmWYaG/Po2n4LNyXoI5nMzcen7cCvM
         UU6A5BZx0hJlbI7ao741FvFDfBqrVWRzzWYqAy7alWKz7MI65QCHmHjXJMw1qqb0SRzb
         ro+d3geqFxPY15uYL/nEMK+hNCk3r2foYZMhycyPc0OVrtySWjLtc6zznS4HsERIJl7W
         9vsnWto67FB/kAKKtEMWkXIxhz5NeDR7kaeGIVwffOCnNcGA8yD56IJUjRBTOVGfWxUS
         /DLQ==
X-Gm-Message-State: AA+aEWa1hLCs/UISQZSenUbGP7zKul/E16Upssw4X8hdwRZX3U/cKhKA
        V+gc/dt4Jdqk9RCjeBWM97zLU+8PV/J8Gdv2oTw=
X-Google-Smtp-Source: AFSGD/XTesXltMnLIZgHsJJjH/RQL0reOE67sQ7IGsaIJDvV9n3SAsjj4PpNuKre8lVAeXzTsVV2HyWf724RI91URLY=
X-Received: by 2002:a6b:fc05:: with SMTP id r5mr25976315ioh.129.1543432204339;
 Wed, 28 Nov 2018 11:10:04 -0800 (PST)
MIME-Version: 1.0
References: <20181128182929.19925-1-jcrouse@codeaurora.org> <20181128182929.19925-2-jcrouse@codeaurora.org>
In-Reply-To: <20181128182929.19925-2-jcrouse@codeaurora.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Wed, 28 Nov 2018 14:09:52 -0500
Message-ID: <CAF6AEGuZPOvA6EjPOGPdWt9quvJoD2oBfNFXXRKE69U94SmXgg@mail.gmail.com>
Subject: Re: [Freedreno] [PATCH 1/1] drm/msm/a6xx: Add support for an
 interconnect path
To:     Jordan Crouse <jcrouse@codeaurora.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 1:29 PM Jordan Crouse <jcrouse@codeaurora.org> wrote:
>
> Try to get the interconnect path for the GPU and vote for the maximum
> bandwidth to support all frequencies. This is needed for performance.
> Later we will want to scale the bandwidth based on the frequency to
> also optimize for power but that will require some device tree
> infrastructure that does not yet exist.
>
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c   | 20 ++++++++++++++++++++
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c |  9 +++++++++
>  drivers/gpu/drm/msm/msm_gpu.h           |  3 +++
>  3 files changed, 32 insertions(+)
>
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index 546599a7ab05..b96ae2ab04bb 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -3,6 +3,7 @@
>
>  #include <linux/clk.h>
>  #include <linux/pm_opp.h>
> +#include <linux/interconnect.h>
>  #include <soc/qcom/cmd-db.h>
>
>  #include "a6xx_gpu.h"
> @@ -63,6 +64,9 @@ static bool a6xx_gmu_gx_is_on(struct a6xx_gmu *gmu)
>
>  static void __a6xx_gmu_set_freq(struct a6xx_gmu *gmu, int index)
>  {
> +       struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
> +       struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
> +       struct msm_gpu *gpu = &adreno_gpu->base;
>         int ret;
>
>         gmu_write(gmu, REG_A6XX_GMU_DCVS_ACK_OPTION, 0);
> @@ -85,6 +89,12 @@ static void __a6xx_gmu_set_freq(struct a6xx_gmu *gmu, int index)
>                 dev_err(gmu->dev, "GMU set GPU frequency error: %d\n", ret);
>
>         gmu->freq = gmu->gpu_freqs[index];
> +
> +       /*
> +        * Eventually we will want to scale the path vote with the frequency but
> +        * for now leave it t at max so that the performance is nominal.
> +        */
> +       icc_set(gpu->icc_path, 0, 7216000000);

Should we get these hard-coded rates from 'struct adreno_info'?  I
guess they are not constant across all the variants of a given
generation?

I assume at least the port label would be the same for all?

BR,
-R

>  }
>
>  void a6xx_gmu_set_freq(struct msm_gpu *gpu, unsigned long freq)
> @@ -680,6 +690,8 @@ int a6xx_gmu_reset(struct a6xx_gpu *a6xx_gpu)
>
>  int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
>  {
> +       struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
> +       struct msm_gpu *gpu = &adreno_gpu->base;
>         struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
>         int status, ret;
>
> @@ -695,6 +707,9 @@ int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
>         if (ret)
>                 goto out;
>
> +       /* Set the bus quota to a reasonable value for boot */
> +       icc_set(gpu->icc_path, 0, 3072000000);
> +
>         a6xx_gmu_irq_enable(gmu);
>
>         /* Check to see if we are doing a cold or warm boot */
> @@ -735,6 +750,8 @@ bool a6xx_gmu_isidle(struct a6xx_gmu *gmu)
>
>  int a6xx_gmu_stop(struct a6xx_gpu *a6xx_gpu)
>  {
> +       struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
> +       struct msm_gpu *gpu = &adreno_gpu->base;
>         struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
>         u32 val;
>
> @@ -781,6 +798,9 @@ int a6xx_gmu_stop(struct a6xx_gpu *a6xx_gpu)
>         /* Tell RPMh to power off the GPU */
>         a6xx_rpmh_stop(gmu);
>
> +       /* Remove the bus vote */
> +       icc_set(gpu->icc_path, 0, 0);
> +
>         clk_bulk_disable_unprepare(gmu->nr_clocks, gmu->clocks);
>
>         pm_runtime_put_sync(gmu->dev);
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> index 93d70f4a2154..9bab491912cf 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -21,6 +21,7 @@
>  #include <linux/kernel.h>
>  #include <linux/pm_opp.h>
>  #include <linux/slab.h>
> +#include <linux/interconnect.h>
>  #include "adreno_gpu.h"
>  #include "msm_gem.h"
>  #include "msm_mmu.h"
> @@ -695,6 +696,11 @@ static int adreno_get_pwrlevels(struct device *dev,
>
>         DBG("fast_rate=%u, slow_rate=27000000", gpu->fast_rate);
>
> +       /* Check for an interconnect path for the bus */
> +       gpu->icc_path = of_icc_get(dev, "port0");
> +       if (IS_ERR(gpu->icc_path))
> +               gpu->icc_path = NULL;
> +
>         return 0;
>  }
>
> @@ -733,10 +739,13 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
>
>  void adreno_gpu_cleanup(struct adreno_gpu *adreno_gpu)
>  {
> +       struct msm_gpu *gpu = &adreno_gpu->base;
>         unsigned int i;
>
>         for (i = 0; i < ARRAY_SIZE(adreno_gpu->info->fw); i++)
>                 release_firmware(adreno_gpu->fw[i]);
>
> +       icc_put(gpu->icc_path);
> +
>         msm_gpu_cleanup(&adreno_gpu->base);
>  }
> diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
> index f82bac086666..7b04d1665555 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.h
> +++ b/drivers/gpu/drm/msm/msm_gpu.h
> @@ -20,6 +20,7 @@
>
>  #include <linux/clk.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/interconnect.h>
>
>  #include "msm_drv.h"
>  #include "msm_fence.h"
> @@ -119,6 +120,8 @@ struct msm_gpu {
>         struct clk *ebi1_clk, *core_clk, *rbbmtimer_clk;
>         uint32_t fast_rate;
>
> +       struct icc_path *icc_path;
> +
>         /* Hang and Inactivity Detection:
>          */
>  #define DRM_MSM_INACTIVE_PERIOD   66 /* in ms (roughly four frames) */
> --
> 2.18.0
>
> _______________________________________________
> Freedreno mailing list
> Freedreno@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/freedreno
