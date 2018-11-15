Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837BFC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 20:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EE87208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 20:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QaLlcSL9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EE87208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389048AbeKPGuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 01:50:02 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56071 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbeKPGuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 01:50:02 -0500
Received: by mail-wm1-f66.google.com with SMTP id y139so2721269wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 12:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lWG2cd6w8rnC0DBqkoTJ0TLzHfQTjGauMRizFzZSirk=;
        b=QaLlcSL9GhdGWRJ4zaFrXDO+NO2eTZw+QL9/u4DE+opPZ9bEGyA9U+GEAHMgWLxsyb
         8+ddSxI/rEq0/doS/+nOBCLJKXog89iobx3so8YqzlPViG246mVutGbEUq8w5sxk4eNB
         AqBtJkQZxiJ3UoxHTn2c8XA4Dr0J723ECy/GagP2HRqRCnXSnpjIQFlmaF80t1k6DpNa
         S9tA+xyP6eTSYJSDpUceNdfXtTQ/78WbT8jokJbPjVt81SnCbwYaC/WHw0a2Z9udSbus
         WvupDV0rlS5fY5NEinoAUftxHUFvLA+0MpVhLurZkQLhWwIswHhWWbyDynWj/CORc39Y
         EsSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lWG2cd6w8rnC0DBqkoTJ0TLzHfQTjGauMRizFzZSirk=;
        b=SXu1d9u5mxJryEmzpNTQjiovWNNEjTgDN4lxsXERCVlchmAmwAT22/O/DhSD3cd40D
         QC2k5FcumaIf5X5AifEijXyerl6T13cWZ5sN+VJ7PNomyiXL9MOBHqIewMh6uZwvd8uo
         eWaJYDTZkNp+K+2uvQi6PR7kXqL1RNu+D/eRFMpAxtY1Rd9Nyqp410KLIIJtYTIYk794
         /2MZRyqdCqWdsKFhrzb8FNmGHYwl6opl4WDFuyZ4MJWLBamSYh0VacQSLRU3R0f1M0yR
         3diNBlC8AlTjdjy1YUvGn7nlgE3nbHQBzT0oXojgy3SFC5+1MTUMafKt5jFrJbxGH8iz
         FLLA==
X-Gm-Message-State: AGRZ1gKxkO/2PMH4DzWE+dRV/7Z3SFLJDvhcr0W4I0NYYfIZWlSI1EOv
        1zYt2eJ3HBvCqOVjBSO2V0AI22V78JbVBoMCMBQ=
X-Google-Smtp-Source: AJdET5dSimr+9Jju87cMG745KN/N5cbWNNl1tmEeXcQN4XKSt+onn93/Kwccuw/lEUH9bvYM/VbHzT9stMNo4Awmdjo=
X-Received: by 2002:a1c:ba54:: with SMTP id k81mr402080wmf.153.1542314437352;
 Thu, 15 Nov 2018 12:40:37 -0800 (PST)
MIME-Version: 1.0
References: <20181115134029.25675-1-joro@8bytes.org>
In-Reply-To: <20181115134029.25675-1-joro@8bytes.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 15 Nov 2018 15:40:23 -0500
Message-ID: <CADnq5_P3C-4pnDMJ4149+rzLGbLfi4eanZum54reyF1JABw0CA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: Ratelimit all "was not implemented" messages
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Rex Zhu <rex.zhu@amd.com>, "Quan, Evan" <evan.quan@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>, jroedel@suse.de,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 8:47 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> From: Joerg Roedel <jroedel@suse.de>
>
> Running kfdtest on an AMD Carizzo flooded the kernel log
> with thousands of these "was not implemented" messages,
> making it impossible to see other messages there.
>
> Ratelimit the messages to prevent user-space from flooding
> the kernel log.
>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Should we just make these debug only?  Applied.

Thanks,

Alex

> ---
>  drivers/gpu/drm/amd/powerplay/amd_powerplay.c | 52 +++++++++++++--------------
>  1 file changed, 26 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> index d6aa1d414320..b68c2e0fef01 100644
> --- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> +++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> @@ -300,7 +300,7 @@ static int pp_set_clockgating_by_smu(void *handle, uint32_t msg_id)
>                 return -EINVAL;
>
>         if (hwmgr->hwmgr_func->update_clock_gatings == NULL) {
> -               pr_info("%s was not implemented.\n", __func__);
> +               pr_info_ratelimited("%s was not implemented.\n", __func__);
>                 return 0;
>         }
>
> @@ -387,7 +387,7 @@ static uint32_t pp_dpm_get_sclk(void *handle, bool low)
>                 return 0;
>
>         if (hwmgr->hwmgr_func->get_sclk == NULL) {
> -               pr_info("%s was not implemented.\n", __func__);
> +               pr_info_ratelimited("%s was not implemented.\n", __func__);
>                 return 0;
>         }
>         mutex_lock(&hwmgr->smu_lock);
> @@ -405,7 +405,7 @@ static uint32_t pp_dpm_get_mclk(void *handle, bool low)
>                 return 0;
>
>         if (hwmgr->hwmgr_func->get_mclk == NULL) {
> -               pr_info("%s was not implemented.\n", __func__);
> +               pr_info_ratelimited("%s was not implemented.\n", __func__);
>                 return 0;
>         }
>         mutex_lock(&hwmgr->smu_lock);
> @@ -422,7 +422,7 @@ static void pp_dpm_powergate_vce(void *handle, bool gate)
>                 return;
>
>         if (hwmgr->hwmgr_func->powergate_vce == NULL) {
> -               pr_info("%s was not implemented.\n", __func__);
> +               pr_info_ratelimited("%s was not implemented.\n", __func__);
>                 return;
>         }
>         mutex_lock(&hwmgr->smu_lock);
> @@ -438,7 +438,7 @@ static void pp_dpm_powergate_uvd(void *handle, bool gate)
>                 return;
>
>         if (hwmgr->hwmgr_func->powergate_uvd == NULL) {
> -               pr_info("%s was not implemented.\n", __func__);
> +               pr_info_ratelimited("%s was not implemented.\n", __func__);
>                 return;
>         }
>         mutex_lock(&hwmgr->smu_lock);
> @@ -505,7 +505,7 @@ static void pp_dpm_set_fan_control_mode(void *handle, uint32_t mode)
>                 return;
>
>         if (hwmgr->hwmgr_func->set_fan_control_mode == NULL) {
> -               pr_info("%s was not implemented.\n", __func__);
> +               pr_info_ratelimited("%s was not implemented.\n", __func__);
>                 return;
>         }
>         mutex_lock(&hwmgr->smu_lock);
> @@ -522,7 +522,7 @@ static uint32_t pp_dpm_get_fan_control_mode(void *handle)
>                 return 0;
>
>         if (hwmgr->hwmgr_func->get_fan_control_mode == NULL) {
> -               pr_info("%s was not implemented.\n", __func__);
> +               pr_info_ratelimited("%s was not implemented.\n", __func__);
>                 return 0;
>         }
>         mutex_lock(&hwmgr->smu_lock);
> @@ -540,7 +540,7 @@ static int pp_dpm_set_fan_speed_percent(void *handle, uint32_t percent)
>                 return -EINVAL;
>
>         if (hwmgr->hwmgr_func->set_fan_speed_percent == NULL) {
> -               pr_info("%s was not implemented.\n", __func__);
> +               pr_info_ratelimited("%s was not implemented.\n", __func__);
>                 return 0;
>         }
>         mutex_lock(&hwmgr->smu_lock);
> @@ -558,7 +558,7 @@ static int pp_dpm_get_fan_speed_percent(void *handle, uint32_t *speed)
>                 return -EINVAL;
>
>         if (hwmgr->hwmgr_func->get_fan_speed_percent == NULL) {
> -               pr_info("%s was not implemented.\n", __func__);
> +               pr_info_ratelimited("%s was not implemented.\n", __func__);
>                 return 0;
>         }
>
> @@ -594,7 +594,7 @@ static int pp_dpm_set_fan_speed_rpm(void *handle, uint32_t rpm)
>                 return -EINVAL;
>
>         if (hwmgr->hwmgr_func->set_fan_speed_rpm == NULL) {
> -               pr_info("%s was not implemented.\n", __func__);
> +               pr_info_ratelimited("%s was not implemented.\n", __func__);
>                 return 0;
>         }
>         mutex_lock(&hwmgr->smu_lock);
> @@ -720,7 +720,7 @@ static int pp_dpm_force_clock_level(void *handle,
>                 return -EINVAL;
>
>         if (hwmgr->hwmgr_func->force_clock_level == NULL) {
> -               pr_info("%s was not implemented.\n", __func__);
> +               pr_info_ratelimited("%s was not implemented.\n", __func__);
>                 return 0;
>         }
>
> @@ -745,7 +745,7 @@ static int pp_dpm_print_clock_levels(void *handle,
>                 return -EINVAL;
>
>         if (hwmgr->hwmgr_func->print_clock_levels == NULL) {
> -               pr_info("%s was not implemented.\n", __func__);
> +               pr_info_ratelimited("%s was not implemented.\n", __func__);
>                 return 0;
>         }
>         mutex_lock(&hwmgr->smu_lock);
> @@ -763,7 +763,7 @@ static int pp_dpm_get_sclk_od(void *handle)
>                 return -EINVAL;
>
>         if (hwmgr->hwmgr_func->get_sclk_od == NULL) {
> -               pr_info("%s was not implemented.\n", __func__);
> +               pr_info_ratelimited("%s was not implemented.\n", __func__);
>                 return 0;
>         }
>         mutex_lock(&hwmgr->smu_lock);
> @@ -781,7 +781,7 @@ static int pp_dpm_set_sclk_od(void *handle, uint32_t value)
>                 return -EINVAL;
>
>         if (hwmgr->hwmgr_func->set_sclk_od == NULL) {
> -               pr_info("%s was not implemented.\n", __func__);
> +               pr_info_ratelimited("%s was not implemented.\n", __func__);
>                 return 0;
>         }
>
> @@ -800,7 +800,7 @@ static int pp_dpm_get_mclk_od(void *handle)
>                 return -EINVAL;
>
>         if (hwmgr->hwmgr_func->get_mclk_od == NULL) {
> -               pr_info("%s was not implemented.\n", __func__);
> +               pr_info_ratelimited("%s was not implemented.\n", __func__);
>                 return 0;
>         }
>         mutex_lock(&hwmgr->smu_lock);
> @@ -818,7 +818,7 @@ static int pp_dpm_set_mclk_od(void *handle, uint32_t value)
>                 return -EINVAL;
>
>         if (hwmgr->hwmgr_func->set_mclk_od == NULL) {
> -               pr_info("%s was not implemented.\n", __func__);
> +               pr_info_ratelimited("%s was not implemented.\n", __func__);
>                 return 0;
>         }
>         mutex_lock(&hwmgr->smu_lock);
> @@ -878,7 +878,7 @@ static int pp_get_power_profile_mode(void *handle, char *buf)
>                 return -EINVAL;
>
>         if (hwmgr->hwmgr_func->get_power_profile_mode == NULL) {
> -               pr_info("%s was not implemented.\n", __func__);
> +               pr_info_ratelimited("%s was not implemented.\n", __func__);
>                 return snprintf(buf, PAGE_SIZE, "\n");
>         }
>
> @@ -894,7 +894,7 @@ static int pp_set_power_profile_mode(void *handle, long *input, uint32_t size)
>                 return ret;
>
>         if (hwmgr->hwmgr_func->set_power_profile_mode == NULL) {
> -               pr_info("%s was not implemented.\n", __func__);
> +               pr_info_ratelimited("%s was not implemented.\n", __func__);
>                 return ret;
>         }
>
> @@ -917,7 +917,7 @@ static int pp_odn_edit_dpm_table(void *handle, uint32_t type, long *input, uint3
>                 return -EINVAL;
>
>         if (hwmgr->hwmgr_func->odn_edit_dpm_table == NULL) {
> -               pr_info("%s was not implemented.\n", __func__);
> +               pr_info_ratelimited("%s was not implemented.\n", __func__);
>                 return -EINVAL;
>         }
>
> @@ -935,7 +935,7 @@ static int pp_dpm_switch_power_profile(void *handle,
>                 return -EINVAL;
>
>         if (hwmgr->hwmgr_func->set_power_profile_mode == NULL) {
> -               pr_info("%s was not implemented.\n", __func__);
> +               pr_info_ratelimited("%s was not implemented.\n", __func__);
>                 return -EINVAL;
>         }
>
> @@ -972,7 +972,7 @@ static int pp_set_power_limit(void *handle, uint32_t limit)
>                 return -EINVAL;
>
>         if (hwmgr->hwmgr_func->set_power_limit == NULL) {
> -               pr_info("%s was not implemented.\n", __func__);
> +               pr_info_ratelimited("%s was not implemented.\n", __func__);
>                 return -EINVAL;
>         }
>
> @@ -1212,7 +1212,7 @@ static int pp_dpm_powergate_mmhub(void *handle)
>                 return -EINVAL;
>
>         if (hwmgr->hwmgr_func->powergate_mmhub == NULL) {
> -               pr_info("%s was not implemented.\n", __func__);
> +               pr_info_ratelimited("%s was not implemented.\n", __func__);
>                 return 0;
>         }
>
> @@ -1227,7 +1227,7 @@ static int pp_dpm_powergate_gfx(void *handle, bool gate)
>                 return 0;
>
>         if (hwmgr->hwmgr_func->powergate_gfx == NULL) {
> -               pr_info("%s was not implemented.\n", __func__);
> +               pr_info_ratelimited("%s was not implemented.\n", __func__);
>                 return 0;
>         }
>
> @@ -1242,7 +1242,7 @@ static void pp_dpm_powergate_acp(void *handle, bool gate)
>                 return;
>
>         if (hwmgr->hwmgr_func->powergate_acp == NULL) {
> -               pr_info("%s was not implemented.\n", __func__);
> +               pr_info_ratelimited("%s was not implemented.\n", __func__);
>                 return;
>         }
>
> @@ -1257,7 +1257,7 @@ static void pp_dpm_powergate_sdma(void *handle, bool gate)
>                 return;
>
>         if (hwmgr->hwmgr_func->powergate_sdma == NULL) {
> -               pr_info("%s was not implemented.\n", __func__);
> +               pr_info_ratelimited("%s was not implemented.\n", __func__);
>                 return;
>         }
>
> @@ -1303,7 +1303,7 @@ static int pp_notify_smu_enable_pwe(void *handle)
>                 return -EINVAL;
>
>         if (hwmgr->hwmgr_func->smus_notify_pwe == NULL) {
> -               pr_info("%s was not implemented.\n", __func__);
> +               pr_info_ratelimited("%s was not implemented.\n", __func__);
>                 return -EINVAL;;
>         }
>
> --
> 2.13.7
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
