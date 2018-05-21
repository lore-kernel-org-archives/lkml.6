Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752820AbeEUOt6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 10:49:58 -0400
Received: from mga06.intel.com ([134.134.136.31]:43914 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751133AbeEUOtw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 10:49:52 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,426,1520924400";
   d="scan'208";a="48503615"
Date: Mon, 21 May 2018 17:49:48 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Randy Li <ayaka@soulik.info>
Cc: dri-devel@lists.freedesktop.org, airlied@linux.ie,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        nicolas.dufresne@collabora.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] drm/fourcc: add a 10bits fully packed variant of NV12
Message-ID: <20180521144948.GF23723@intel.com>
References: <20180520171705.29690-1-ayaka@soulik.info>
 <20180520171705.29690-2-ayaka@soulik.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180520171705.29690-2-ayaka@soulik.info>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 01:17:04AM +0800, Randy Li wrote:
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

What does "fully packed" mean? NV12_10LE32 doesn't even exist so
referring to it makes no sense.

Please try to provide an unambiguous description of new formats like we
have for everything else.

> +#define DRM_FORMAT_NV12_10LE40	fourcc_code('R', 'K', '2', '0') /* 2x2 subsampled Cr:Cb plane */
> +
>  
>  /*
>   * 3 plane YCbCr
> -- 
> 2.14.3
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Ville Syrjälä
Intel
