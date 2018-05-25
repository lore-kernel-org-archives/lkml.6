Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967237AbeEYPzE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 11:55:04 -0400
Received: from mga05.intel.com ([192.55.52.43]:51224 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966293AbeEYPzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 11:55:01 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,440,1520924400";
   d="scan'208";a="50200604"
Date: Fri, 25 May 2018 18:54:56 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Ayan Kumar Halder <ayan.halder@arm.com>
Cc: liviu.dudau@arm.com, brian.starkey@arm.com,
        alexandru-cosmin.gheorghe@arm.com, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, nd@arm.com
Subject: Re: [PATCH] drm: check_pixel_format() should return true if no
 modifiers are passed for a supported pixel format
Message-ID: <20180525155456.GF23723@intel.com>
References: <1527262541-13964-1-git-send-email-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1527262541-13964-1-git-send-email-ayan.halder@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 04:35:41PM +0100, Ayan Kumar Halder wrote:
> If a plane supports a pixel format and the framebuffer does not pass any
> modifiers, then drm_plane_check_pixel_format() should always return true
> for the given format regardless of whether the plane supports any
> modifiers or not.

If your plane supports DRM_FORMAT_MOD_LINEAR then you should add that
to the plane's modifier list.

> 
> Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>
> ---
>  drivers/gpu/drm/drm_plane.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
> index 6d2a6e4..873c084 100644
> --- a/drivers/gpu/drm/drm_plane.c
> +++ b/drivers/gpu/drm/drm_plane.c
> @@ -564,6 +564,9 @@ int drm_plane_check_pixel_format(struct drm_plane *plane,
>  	if (!plane->modifier_count)
>  		return 0;
>  
> +	if (modifier == DRM_FORMAT_MOD_NONE)
> +		return 0;
> +
>  	for (i = 0; i < plane->modifier_count; i++) {
>  		if (modifier == plane->modifiers[i])
>  			break;
> -- 
> 2.7.4
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Ville Syrjälä
Intel
