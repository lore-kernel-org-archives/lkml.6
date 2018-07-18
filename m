Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5083ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A96A62084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:15:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A96A62084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbeGRKxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 06:53:00 -0400
Received: from mga01.intel.com ([192.55.52.88]:11979 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbeGRKw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 06:52:59 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jul 2018 03:15:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,369,1526367600"; 
   d="scan'208";a="58604211"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga006.jf.intel.com with SMTP; 18 Jul 2018 03:15:40 -0700
Received: by stinkbox (sSMTP sendmail emulation); Wed, 18 Jul 2018 13:15:40 +0300
Date:   Wed, 18 Jul 2018 13:15:40 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Ayan Kumar Halder <ayan.halder@arm.com>
Cc:     liviu.dudau@arm.com, brian.starkey@arm.com, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        airlied@linux.ie, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        intel-gfx@lists.freedesktop.org, hjc@rock-chips.com,
        heiko@sntech.de, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        tomi.valkeinen@ti.com, laurent.pinchart@ideasonboard.com,
        sre@kernel.org, bparrot@ti.com, peter.ujfalusi@ti.com, afd@ti.com,
        dri-devel@lists.freedesktop.org, maxime.ripard@bootlin.com,
        wens@csie.org, malidp@foss.arm.com, nd@arm.com
Subject: Re: [Intel-gfx] [PATCH 5/5] drm/sun4i: Substitute
 sun4i_backend_format_is_yuv() with format->is_yuv
Message-ID: <20180718101540.GT5565@intel.com>
References: <1531847626-22248-1-git-send-email-ayan.halder@arm.com>
 <1531847626-22248-5-git-send-email-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1531847626-22248-5-git-send-email-ayan.halder@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 06:13:46PM +0100, Ayan Kumar Halder wrote:
> drm_format_info table has a field 'is_yuv' to denote if the format
> is yuv or not. The driver is expected to use this instead of
> having a function for the same purpose.
> 
> Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_backend.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
> index de0a76d..d7950b5 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_backend.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
> @@ -86,12 +86,6 @@ static inline bool sun4i_backend_format_is_packed_yuv422(uint32_t format)
>  	}
>  }
>  
> -static inline bool sun4i_backend_format_is_yuv(uint32_t format)
> -{
> -	return sun4i_backend_format_is_planar_yuv(format) ||
> -		sun4i_backend_format_is_packed_yuv422(format);
> -}

sun4i_backend_format_is_planar_yuv() is now unused so could be nuked.
Also the one remaining use of sun4i_backend_format_is_packed_yuv422()
could be replaced with 'is_yuv && num_planes == 1', so that one could
be easily killed off ass well.

> -
>  static void sun4i_backend_apply_color_correction(struct sunxi_engine *engine)
>  {
>  	int i;
> @@ -304,7 +298,7 @@ int sun4i_backend_update_layer_formats(struct sun4i_backend *backend,
>  			   SUN4I_BACKEND_ATTCTL_REG0_LAY_GLBALPHA_EN,
>  			   val);
>  
> -	if (sun4i_backend_format_is_yuv(fb->format->format))
> +	if (fb->format->is_yuv)
>  		return sun4i_backend_update_yuv_format(backend, layer, plane);
>  
>  	ret = sun4i_backend_drm_format_to_layer(fb->format->format, &val);
> @@ -384,7 +378,7 @@ int sun4i_backend_update_layer_buffer(struct sun4i_backend *backend,
>  	 */
>  	paddr -= PHYS_OFFSET;
>  
> -	if (sun4i_backend_format_is_yuv(fb->format->format))
> +	if (fb->format->is_yuv)
>  		return sun4i_backend_update_yuv_buffer(backend, fb, paddr);
>  
>  	/* Write the 32 lower bits of the address (in bits) */
> @@ -502,7 +496,7 @@ static int sun4i_backend_atomic_check(struct sunxi_engine *engine,
>  		if (fb->format->has_alpha || (plane_state->alpha != DRM_BLEND_ALPHA_OPAQUE))
>  			num_alpha_planes++;
>  
> -		if (sun4i_backend_format_is_yuv(fb->format->format)) {
> +		if (fb->format->is_yuv) {
>  			DRM_DEBUG_DRIVER("Plane FB format is YUV\n");
>  			num_yuv_planes++;
>  		}
> -- 
> 2.7.4
> 
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gfx

-- 
Ville Syrjälä
Intel
