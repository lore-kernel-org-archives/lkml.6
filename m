Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FEDC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2993F20672
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:54:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2993F20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbeLDRyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 12:54:25 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38242 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbeLDRyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 12:54:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD952A78;
        Tue,  4 Dec 2018 09:54:23 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F4A13F59C;
        Tue,  4 Dec 2018 09:54:23 -0800 (PST)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id CC65A6801C3; Tue,  4 Dec 2018 17:54:21 +0000 (GMT)
Date:   Tue, 4 Dec 2018 17:54:21 +0000
From:   Liviu Dudau <Liviu.Dudau@arm.com>
To:     Ayan Halder <Ayan.Halder@arm.com>
Cc:     Brian Starkey <Brian.Starkey@arm.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [RFC v3 AFBC 12/12] drm/arm/malidp: Added support for AFBC
 modifiers for all layers except DE_SMART
Message-ID: <20181204175421.GT988@e110455-lin.cambridge.arm.com>
References: <1543836703-8491-1-git-send-email-ayan.halder@arm.com>
 <1543836703-8491-13-git-send-email-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1543836703-8491-13-git-send-email-ayan.halder@arm.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 11:32:06AM +0000, Ayan Halder wrote:
> The list of modifiers to be supported for each plane has been dynamically generated
> from 'malidp_format_modifiers[]' and 'malidp_hw_regmap->features'.
> 
> Changes from v1:-
> 1. Replaced DRM_ERROR() with DRM_DEBUG_KMS() in malidp_format_mod_supported()
> to report unsupported modifiers.
> 
> Changes from v2:-
> 1. Removed malidp_format_mod_supported() from the current patch. This has been added
> in "PATCH 7/12"
> 2. Dynamically generate the list of modifiers (to be supported for each plane) from
> 'malidp_format_modifiers' and features.
> 
> Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/arm/malidp_drv.c    |  1 +
>  drivers/gpu/drm/arm/malidp_planes.c | 28 ++++++++++++++++++++++++++--
>  2 files changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
> index b2b97db..be45703 100644
> --- a/drivers/gpu/drm/arm/malidp_drv.c
> +++ b/drivers/gpu/drm/arm/malidp_drv.c
> @@ -388,6 +388,7 @@ static int malidp_init(struct drm_device *drm)
>  	drm->mode_config.max_height = hwdev->max_line_size;
>  	drm->mode_config.funcs = &malidp_mode_config_funcs;
>  	drm->mode_config.helper_private = &malidp_mode_config_helpers;
> +	drm->mode_config.allow_fb_modifiers = true;
>  
>  	ret = malidp_crtc_init(drm);
>  	if (ret)
> diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/malidp_planes.c
> index eec0442..01037d0 100644
> --- a/drivers/gpu/drm/arm/malidp_planes.c
> +++ b/drivers/gpu/drm/arm/malidp_planes.c
> @@ -934,6 +934,25 @@ int malidp_de_planes_init(struct drm_device *drm)
>  				  BIT(DRM_MODE_BLEND_COVERAGE);
>  	u32 *formats;
>  	int ret, i, j, n;
> +	u64 supported_modifiers[MODIFIERS_COUNT_MAX];
> +	const u64 *modifiers;
> +
> +	modifiers = malidp_format_modifiers;
> +
> +	if (!(map->features & MALIDP_DEVICE_AFBC_SUPPORT_SPLIT)) {
> +		/*
> +		 * Since our hardware does not support SPLIT, so build the list of
> +		 * supported modifiers excluding SPLIT ones.
> +		 */
> +		while (*modifiers != DRM_FORMAT_MOD_INVALID) {
> +			if (!(*modifiers & AFBC_SPLIT))
> +				supported_modifiers[j++] = *modifiers;
> +
> +			modifiers++;
> +		}
> +		supported_modifiers[j++] = DRM_FORMAT_MOD_INVALID;
> +		modifiers = supported_modifiers;
> +	}
>  
>  	formats = kcalloc(map->n_pixel_formats, sizeof(*formats), GFP_KERNEL);
>  	if (!formats) {
> @@ -958,9 +977,14 @@ int malidp_de_planes_init(struct drm_device *drm)
>  
>  		plane_type = (i == 0) ? DRM_PLANE_TYPE_PRIMARY :
>  					DRM_PLANE_TYPE_OVERLAY;
> +
> +		/*
> +		 * All the layers except smart layer supports AFBC modifiers.
> +		 */
>  		ret = drm_universal_plane_init(drm, &plane->base, crtcs,
> -					       &malidp_de_plane_funcs, formats,
> -					       n, NULL, plane_type, NULL);
> +				&malidp_de_plane_funcs, formats, n,
> +				(id == DE_SMART) ? NULL : modifiers, plane_type, NULL);
> +
>  		if (ret < 0)
>  			goto cleanup;
>  
> -- 
> 2.7.4
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
