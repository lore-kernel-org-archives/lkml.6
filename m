Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752935AbeA3TXv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 14:23:51 -0500
Received: from mail-yw0-f194.google.com ([209.85.161.194]:38665 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752776AbeA3TXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 14:23:48 -0500
X-Google-Smtp-Source: AH8x225p3qLqwovDM9R2oDAJvKAjAanzOhdFIrfIhNSMP/+LW2aYdpap4w6eMc50Iev4iJhMnCHyp9xVIgqM9K1LHjc=
MIME-Version: 1.0
In-Reply-To: <20180117185020.25169-1-luisbg@kernel.org>
References: <20180117185020.25169-1-luisbg@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 30 Jan 2018 14:23:48 -0500
Message-ID: <CADnq5_Ny_0HZAt9b-D+k7zryowW0hkBtHp2i+k=KN7bfvBMhAg@mail.gmail.com>
Subject: Re: [PATCH] drm: amd: Fix trailing semicolons
To: Luis de Bethencourt <luisbg@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Huang Rui <ray.huang@amd.com>,
        David Airlie <airlied@linux.ie>,
        Harry Wentland <harry.wentland@amd.com>,
        Wenjing Liu <Wenjing.Liu@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Ding Wang <Ding.Wang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Eric Huang <JinHuiEric.Huang@amd.com>,
        Sylvia Tsai <sylvia.tsai@amd.com>, Hersen Wu <hersenxs.wu@amd.com>,
        Maling list - DRI developers
        <dri-devel@lists.freedesktop.org>,
        Joe Perches <joe@perches.com>, Rex Zhu <Rex.Zhu@amd.com>,
        Tony Cheng <tony.cheng@amd.com>,
        Christian Konig <christian.koenig@amd.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 17, 2018 at 1:50 PM, Luis de Bethencourt <luisbg@kernel.org> wrote:
> The trailing semicolon is an empty statement that does no operation.
> Removing the two instances of them since they don't do anything.
>
> Signed-off-by: Luis de Bethencourt <luisbg@kernel.org>

Applied.  thanks!

Alex

> ---
>
> Hi,
>
> After fixing the same thing in drivers/staging/rtl8723bs/, Joe Perches
> suggested I fix it treewide [0].
>
> Best regards
> Luis
>
>
> [0] http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2018-January/115410.html
> [1] http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2018-January/115390.html
>
>  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 2 +-
>  drivers/gpu/drm/amd/powerplay/amd_powerplay.c    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> index 61e8c3e02d16..33d91e4474ea 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> @@ -718,7 +718,7 @@ static enum link_training_result perform_channel_equalization_sequence(
>         uint32_t retries_ch_eq;
>         enum dc_lane_count lane_count = lt_settings->link_settings.lane_count;
>         union lane_align_status_updated dpcd_lane_status_updated = {{0}};
> -       union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] = {{{0}}};;
> +       union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] = {{{0}}};
>
>         hw_tr_pattern = get_supported_tp(link);
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> index fa9d1615a2cc..b98a7a8a22b5 100644
> --- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> +++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> @@ -162,7 +162,7 @@ static int pp_hw_init(void *handle)
>                 if(hwmgr->smumgr_funcs->start_smu(pp_handle->hwmgr)) {
>                         pr_err("smc start failed\n");
>                         hwmgr->smumgr_funcs->smu_fini(pp_handle->hwmgr);
> -                       return -EINVAL;;
> +                       return -EINVAL;
>                 }
>                 if (ret == PP_DPM_DISABLED)
>                         goto exit;
> --
> 2.15.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
