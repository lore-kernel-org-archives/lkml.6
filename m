Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF7DC5AE5E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 23:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3D0120652
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 23:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Eypht+C9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730135AbfARXp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 18:45:58 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41174 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730063AbfARXp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 18:45:58 -0500
Received: by mail-lj1-f194.google.com with SMTP id k15-v6so13014942ljc.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 15:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=vyPa6RWp8yc0OiI1CZ1DDkVzWOCj5KcsnrJwE3e1pnY=;
        b=Eypht+C9rILThlmdKX62zVmVpWZ6K9ZnGyitFjNlHSFDCTESm3JSqW5sBO/rIM5K8x
         wLkd9DYL9tlcCY0MNzeIG+yD4C1VYDNhmze874voWkjf88FoMaJkSKAaacg2AKoLKHM+
         FXsKs2i5zZM/GZM7cD8leSL+9VAc2zUriwOls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=vyPa6RWp8yc0OiI1CZ1DDkVzWOCj5KcsnrJwE3e1pnY=;
        b=EuB9upmfm39o3E4HUdGsVPO+BZrmsofFBtb59TP+PB40uTV4jnDrN5C/fV1zt4E30i
         xKUW+l6sdPgKhmcuBtuUMlmWveEKxBEK7c01cECg3gIoOmnXJC6pIUSwcLeAWx5OFcZe
         yVilj49NC+UN23M3SSA1Md+NBBdFfqMx7GqyPcaJEq/mycVaAyIyMJaT6gvM3n8EdqJi
         xvZt734PhtKC6d4xXE5QYDMJetWheA+3tmXEs5OTOTSB0fNR6ldYKUuTeZuLNcvL+BFB
         PRIMZ3Hd0ME4dV+Rn1lTubrVVcq2toASLVlc7fnPTdimv7pCiCb8cTw4/t23arQoH3Mo
         xQmA==
X-Gm-Message-State: AJcUukfpdt/qGg47N2kfeE0zRf6qQuszMvcShTjhSaKHuN/iiVuSo7tW
        EKASJ6kMCI7xPkdLVmQFRVDtQnq7G64=
X-Google-Smtp-Source: ALg8bN5ttA498TeDLQZBPAb7OBNncUDH+7ev4vdp90/CV57Rp3CDY7daDG00QoK/d5YwyHReWpaaiw==
X-Received: by 2002:a2e:8786:: with SMTP id n6-v6mr14173569lji.100.1547855155324;
        Fri, 18 Jan 2019 15:45:55 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id g15sm1012920lfb.1.2019.01.18.15.45.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 15:45:53 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id s5-v6so12985377ljd.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 15:45:53 -0800 (PST)
X-Received: by 2002:a2e:880a:: with SMTP id x10-v6mr14332410ljh.174.1547855152543;
 Fri, 18 Jan 2019 15:45:52 -0800 (PST)
MIME-Version: 1.0
References: <1547843058-27933-1-git-send-email-jcrouse@codeaurora.org>
 <CAE=gft6RWRkSZCOrKu=qqTerfmXRW5_kNt2NG4xdfxtTn6KxYA@mail.gmail.com> <20190118232746.GF4140@jcrouse1-lnx.qualcomm.com>
In-Reply-To: <20190118232746.GF4140@jcrouse1-lnx.qualcomm.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 18 Jan 2019 15:45:16 -0800
X-Gmail-Original-Message-ID: <CAE=gft4OAMztQ0CE4wz3_fNr0K0UqNP8DOm5=TRaVvcpTefPTw@mail.gmail.com>
Message-ID: <CAE=gft4OAMztQ0CE4wz3_fNr0K0UqNP8DOm5=TRaVvcpTefPTw@mail.gmail.com>
Subject: Re: [PATCH v6] drm/msm/a6xx: Add support for an interconnect path
To:     Evan Green <evgreen@chromium.org>, freedreno@lists.freedesktop.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <swboyd@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Colin Ian King <colin.king@canonical.com>,
        Sharat Masetty <smasetty@codeaurora.org>,
        dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Jonathan Marek <jonathan@marek.ca>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 3:27 PM Jordan Crouse <jcrouse@codeaurora.org> wrote:
>
> On Fri, Jan 18, 2019 at 03:04:34PM -0800, Evan Green wrote:
> > On Fri, Jan 18, 2019 at 12:24 PM Jordan Crouse <jcrouse@codeaurora.org> wrote:
> > >
> > > Try to get the interconnect path for the GPU and vote for the maximum
> > > bandwidth to support all frequencies. This is needed for performance.
> > > Later we will want to scale the bandwidth based on the frequency to
> > > also optimize for power but that will require some device tree
> > > infrastructure that does not yet exist.
> > >
> > > v6: use icc_set_bw() instead of icc_set()
> > > v5: Remove hardcoded interconnect name and just use the default
> > > v4: Don't use a port string at all to skip the need for names in the DT
> > > v3: Use macros and change port string per Georgi Djakov
> > >
> > > Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> > > ---
> > >
> > >  drivers/gpu/drm/msm/Kconfig             |  1 +
> > >  drivers/gpu/drm/msm/adreno/a6xx_gmu.c   | 20 ++++++++++++++++++++
> > >  drivers/gpu/drm/msm/adreno/adreno_gpu.c |  9 +++++++++
> > >  drivers/gpu/drm/msm/msm_gpu.h           |  3 +++
> > >  4 files changed, 33 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
> > > index cf549f1..78c9e5a5 100644
> > > --- a/drivers/gpu/drm/msm/Kconfig
> > > +++ b/drivers/gpu/drm/msm/Kconfig
> > > @@ -5,6 +5,7 @@ config DRM_MSM
> > >         depends on ARCH_QCOM || SOC_IMX5 || (ARM && COMPILE_TEST)
> > >         depends on OF && COMMON_CLK
> > >         depends on MMU
> > > +       depends on INTERCONNECT || !INTERCONNECT
> > >         select QCOM_MDT_LOADER if ARCH_QCOM
> > >         select REGULATOR
> > >         select DRM_KMS_HELPER
> > > diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> > > index 5beb83d..c48fe46 100644
> > > --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> > > +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> > > @@ -2,6 +2,7 @@
> > >  /* Copyright (c) 2017-2018 The Linux Foundation. All rights reserved. */
> > >
> > >  #include <linux/clk.h>
> > > +#include <linux/interconnect.h>
> > >  #include <linux/pm_opp.h>
> > >  #include <soc/qcom/cmd-db.h>
> > >
> > > @@ -84,6 +85,9 @@ bool a6xx_gmu_gx_is_on(struct a6xx_gmu *gmu)
> > >
> > >  static void __a6xx_gmu_set_freq(struct a6xx_gmu *gmu, int index)
> > >  {
> > > +       struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
> > > +       struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
> > > +       struct msm_gpu *gpu = &adreno_gpu->base;
> > >         int ret;
> > >
> > >         gmu_write(gmu, REG_A6XX_GMU_DCVS_ACK_OPTION, 0);
> > > @@ -106,6 +110,12 @@ static void __a6xx_gmu_set_freq(struct a6xx_gmu *gmu, int index)
> > >                 dev_err(gmu->dev, "GMU set GPU frequency error: %d\n", ret);
> > >
> > >         gmu->freq = gmu->gpu_freqs[index];
> > > +
> > > +       /*
> > > +        * Eventually we will want to scale the path vote with the frequency but
> > > +        * for now leave it at max so that the performance is nominal.
> > > +        */
> > > +       icc_set_bw(gpu->icc_path, 0, MBps_to_icc(7216));
> > >  }
> > >
> > >  void a6xx_gmu_set_freq(struct msm_gpu *gpu, unsigned long freq)
> > > @@ -705,6 +715,8 @@ int a6xx_gmu_reset(struct a6xx_gpu *a6xx_gpu)
> > >
> > >  int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
> > >  {
> > > +       struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
> > > +       struct msm_gpu *gpu = &adreno_gpu->base;
> > >         struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
> > >         int status, ret;
> > >
> > > @@ -720,6 +732,9 @@ int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
> > >         if (ret)
> > >                 goto out;
> > >
> > > +       /* Set the bus quota to a reasonable value for boot */
> > > +       icc_set_bw(gpu->icc_path, 0, MBps_to_icc(3072));
> >
> > Does the comment mention boot because this resume call happens during
> > init?
>
> Correct. Boot refers to the GMU in this context.
>
> > How come this number is different from the one in __a6xx_gmu_set_freq?
>
> If you never request a bus quota from the kernel the sucker is horribly
> painfully slow. I'm not sure if that is just the default reset value of
> the registers or if the bootloader is doing something. In any event
> the GMU doesn't always initialize if you try to bring it up with the
> default bus settings so we set it to a "reasonable" quota for the
> init sequence. I admit I didn't come up with these numbers on my own;
> some poor anonymous soul debugged this on the downstream kernel and
> I just stole the same parameters.
>
> As for _a6xx_gmu_set_freq() eventually we'll agree on a way to communicate
> the bus bandwidth in the opp settings and we'll be able to adjust the quota
> based on the frequency to save power so that's why the code is organized the way
> it is so that a6xx_gmu_set_freq() won't have to be massively changed later.

Oh I see, so it's just a placeholder to max for now until the OPP part
gets figured out. That makes sense.

Reviewed-by: Evan Green <evgreen@chromium.org>
