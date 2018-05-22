Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751329AbeEVJ0T (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 05:26:19 -0400
Received: from mga06.intel.com ([134.134.136.31]:18099 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750707AbeEVJ0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 05:26:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,429,1520924400";
   d="scan'208";a="226267419"
Subject: Re: [PATCH 1/2] drm/fourcc: add a 10bits fully packed variant of NV12
To: Randy Li <ayaka@soulik.info>, dri-devel@lists.freedesktop.org
Cc: hjc@rock-chips.com, heiko@sntech.de,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        nicolas.dufresne@collabora.com, gustavo@padovan.org,
        seanpaul@chromium.org, airlied@linux.ie
References: <20180520171705.29690-1-ayaka@soulik.info>
 <20180520171705.29690-2-ayaka@soulik.info>
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Message-ID: <303c89b8-e24f-cacb-c305-65d17c58c597@linux.intel.com>
Date: Tue, 22 May 2018 11:26:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180520171705.29690-2-ayaka@soulik.info>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Op 20-05-18 om 19:17 schreef Randy Li:
> This pixel format is a fully packed and 10bits variant of NV12.
> A luma pixel would take 10bits in memory, without any
> filled bits between pixels in a stride. The color gamut
> follows the BT.2020 standard.
>
> Signed-off-by: Randy Li <ayaka@soulik.info>
> ---
>  drivers/gpu/drm/drm_fourcc.c  | 1 +
>  include/uapi/drm/drm_fourcc.h | 3 +++
>  2 files changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
> index 5ca6395cd4d3..1f43967c4013 100644
> --- a/drivers/gpu/drm/drm_fourcc.c
> +++ b/drivers/gpu/drm/drm_fourcc.c
> @@ -173,6 +173,7 @@ const struct drm_format_info *__drm_format_info(u32 format)
>  		{ .format = DRM_FORMAT_UYVY,		.depth = 0,  .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 2, .vsub = 1 },
>  		{ .format = DRM_FORMAT_VYUY,		.depth = 0,  .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 2, .vsub = 1 },
>  		{ .format = DRM_FORMAT_AYUV,		.depth = 0,  .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> +		{ .format = DRM_FORMAT_NV12_10LE40,	.depth = 0,  .num_planes = 2, .cpp = { 1, 2, 0 }, .hsub = 2, .vsub = 2 },
Hm, the cpp value might give problems because it rounds down, not sure how we should handle that? Set to zero?
>  	};
>  
>  	unsigned int i;
> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> index e04613d30a13..8eabf01e966f 100644
> --- a/include/uapi/drm/drm_fourcc.h
> +++ b/include/uapi/drm/drm_fourcc.h
> @@ -140,6 +140,9 @@ extern "C" {
>  #define DRM_FORMAT_NV61		fourcc_code('N', 'V', '6', '1') /* 2x1 subsampled Cb:Cr plane */
>  #define DRM_FORMAT_NV24		fourcc_code('N', 'V', '2', '4') /* non-subsampled Cr:Cb plane */
>  #define DRM_FORMAT_NV42		fourcc_code('N', 'V', '4', '2') /* non-subsampled Cb:Cr plane */
> +/* A fully packed variant of NV12_10LE32 */
> +#define DRM_FORMAT_NV12_10LE40	fourcc_code('R', 'K', '2', '0') /* 2x2 subsampled Cr:Cb plane */
> +
>  
>  /*
>   * 3 plane YCbCr
