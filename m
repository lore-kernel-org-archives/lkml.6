Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10508C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2F0420834
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:56:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2F0420834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbeLDQ4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:56:33 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37040 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726459AbeLDQ4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 11:56:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA4C6A78;
        Tue,  4 Dec 2018 08:56:31 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 564B73F614;
        Tue,  4 Dec 2018 08:56:31 -0800 (PST)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id A5D15680159; Tue,  4 Dec 2018 16:56:29 +0000 (GMT)
Date:   Tue, 4 Dec 2018 16:56:29 +0000
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
Subject: Re: [RFC AFBC 05/12] drm/arm/malidp:- Define a common list of AFBC
 format modifiers supported for DP500, DP550 and DP650
Message-ID: <20181204165629.GM988@e110455-lin.cambridge.arm.com>
References: <1543836703-8491-1-git-send-email-ayan.halder@arm.com>
 <1543836703-8491-6-git-send-email-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1543836703-8491-6-git-send-email-ayan.halder@arm.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 11:31:59AM +0000, Ayan Halder wrote:
> We need to define a common list of format modifiers supported by each of the Mali
> display processors. The difference between DP500 from DP550/650 is that DP500
> does not support block split mode (ie AFBC_FORMAT_MOD_SPLIT) and DP550 supports
> YUV420 with split mode. We noted these special cases by defining MALIDP_DEVICE_AFBC_SUPPORT_SPLIT
> and AFBC_SUPPORT_SPLIT_WITH_YUV_420_10 for malidp_hw_regmap.features
> 
> Also we have defined a set of meaningful macros to shorten the modifier names
> 
> Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
> 
> Change-Id: I09fba2032a7474e6ce45af230e0ed18fc1f4c1df
> ---
>  drivers/gpu/drm/arm/malidp_drv.c |  8 ++++----
>  drivers/gpu/drm/arm/malidp_hw.c  | 30 ++++++++++++++++++++++++++++--
>  drivers/gpu/drm/arm/malidp_hw.h  | 20 +++++++++++++++-----
>  3 files changed, 47 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
> index 505f316..b8db92f 100644
> --- a/drivers/gpu/drm/arm/malidp_drv.c
> +++ b/drivers/gpu/drm/arm/malidp_drv.c
> @@ -293,8 +293,8 @@ malidp_verify_afbc_framebuffer_caps(struct drm_device *dev,
>  		return false;
>  	}
>  
> -	switch (mode_cmd->modifier[0] & AFBC_FORMAT_MOD_BLOCK_SIZE_MASK) {
> -	case AFBC_FORMAT_MOD_BLOCK_SIZE_16x16:
> +	switch (mode_cmd->modifier[0] & AFBC_SIZE_MASK) {
> +	case AFBC_SIZE_16X16:
>  		if ((mode_cmd->width % 16) || (mode_cmd->height % 16)) {
>  			DRM_DEBUG_KMS("AFBC buffers must be aligned to 16 pixels\n");
>  			return false;
> @@ -319,8 +319,8 @@ malidp_verify_afbc_framebuffer_size(struct drm_device *dev,
>  	u32 afbc_superblock_size = 0, afbc_superblock_height = 0;
>  	u32 afbc_superblock_width = 0, afbc_size = 0;
>  
> -	switch (mode_cmd->modifier[0] & AFBC_FORMAT_MOD_BLOCK_SIZE_MASK) {
> -	case AFBC_FORMAT_MOD_BLOCK_SIZE_16x16:
> +	switch (mode_cmd->modifier[0] & AFBC_SIZE_MASK) {
> +	case AFBC_SIZE_16X16:
>  		afbc_superblock_height = 16;
>  		afbc_superblock_width = 16;
>  		break;
> diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_hw.c
> index 87b7b12..55d379b 100644
> --- a/drivers/gpu/drm/arm/malidp_hw.c
> +++ b/drivers/gpu/drm/arm/malidp_hw.c
> @@ -137,6 +137,32 @@ static const struct malidp_layer malidp650_layers[] = {
>  		ROTATE_NONE, 0 },
>  };
>  
> +const u64 malidp_format_modifiers[] = {
> +	/* All RGB formats (except XRGB, RGBX, XBGR, BGRX) */
> +	DRM_FORMAT_MOD_ARM_AFBC(AFBC_SIZE_16X16 | AFBC_YTR | AFBC_SPARSE),
> +	DRM_FORMAT_MOD_ARM_AFBC(AFBC_SIZE_16X16 | AFBC_YTR),
> +
> +	/* All RGB formats > 16bpp (except XRGB, RGBX, XBGR, BGRX) */
> +	DRM_FORMAT_MOD_ARM_AFBC(AFBC_SIZE_16X16 | AFBC_YTR | AFBC_SPARSE | AFBC_SPLIT),
> +
> +	/* All 8 or 10 bit YUV 444 formats. */
> +	/* In DP550, 10 bit YUV 420 format also supported */
> +	DRM_FORMAT_MOD_ARM_AFBC(AFBC_SIZE_16X16 | AFBC_SPARSE | AFBC_SPLIT),
> +
> +	/* YUV 420, 422 P1 8 bit and YUV 444 8 bit/10 bit formats */
> +	DRM_FORMAT_MOD_ARM_AFBC(AFBC_SIZE_16X16 | AFBC_SPARSE),
> +	DRM_FORMAT_MOD_ARM_AFBC(AFBC_SIZE_16X16),
> +
> +	/* YUV 420, 422 P1 8, 10 bit formats */
> +	DRM_FORMAT_MOD_ARM_AFBC(AFBC_SIZE_16X16 | AFBC_CBR | AFBC_SPARSE),
> +	DRM_FORMAT_MOD_ARM_AFBC(AFBC_SIZE_16X16 | AFBC_CBR),
> +
> +	/* All formats */
> +	DRM_FORMAT_MOD_LINEAR,
> +
> +	DRM_FORMAT_MOD_INVALID
> +};
> +
>  #define SE_N_SCALING_COEFFS	96
>  static const u16 dp500_se_scaling_coeffs[][SE_N_SCALING_COEFFS] = {
>  	[MALIDP_UPSCALING_COEFFS - 1] = {
> @@ -841,7 +867,7 @@ const struct malidp_hw malidp_device[MALIDP_MAX_DEVICES] = {
>  			.se_base = MALIDP550_SE_BASE,
>  			.dc_base = MALIDP550_DC_BASE,
>  			.out_depth_base = MALIDP550_DE_OUTPUT_DEPTH,
> -			.features = MALIDP_REGMAP_HAS_CLEARIRQ,
> +			.features = MALIDP_REGMAP_HAS_CLEARIRQ | MALIDP_DEVICE_AFBC_SUPPORT_SPLIT | AFBC_SUPPORT_SPLIT_WITH_YUV_420_10,
>  			.n_layers = ARRAY_SIZE(malidp550_layers),
>  			.layers = malidp550_layers,
>  			.de_irq_map = {
> @@ -887,7 +913,7 @@ const struct malidp_hw malidp_device[MALIDP_MAX_DEVICES] = {
>  			.se_base = MALIDP550_SE_BASE,
>  			.dc_base = MALIDP550_DC_BASE,
>  			.out_depth_base = MALIDP550_DE_OUTPUT_DEPTH,
> -			.features = MALIDP_REGMAP_HAS_CLEARIRQ,
> +			.features = MALIDP_REGMAP_HAS_CLEARIRQ | MALIDP_DEVICE_AFBC_SUPPORT_SPLIT,
>  			.n_layers = ARRAY_SIZE(malidp650_layers),
>  			.layers = malidp650_layers,
>  			.de_irq_map = {
> diff --git a/drivers/gpu/drm/arm/malidp_hw.h b/drivers/gpu/drm/arm/malidp_hw.h
> index 651558f..27b907f 100644
> --- a/drivers/gpu/drm/arm/malidp_hw.h
> +++ b/drivers/gpu/drm/arm/malidp_hw.h
> @@ -95,7 +95,9 @@ struct malidp_se_config {
>  };
>  
>  /* regmap features */
> -#define MALIDP_REGMAP_HAS_CLEARIRQ	(1 << 0)
> +#define MALIDP_REGMAP_HAS_CLEARIRQ				BIT(0)
> +#define MALIDP_DEVICE_AFBC_SUPPORT_SPLIT			BIT(1)
> +#define AFBC_SUPPORT_SPLIT_WITH_YUV_420_10			BIT(2)
>  
>  struct malidp_hw_regmap {
>  	/* address offset of the DE register bank */
> @@ -390,9 +392,17 @@ static inline void malidp_se_set_enh_coeffs(struct malidp_hw_device *hwdev)
>  
>  #define MALIDP_GAMMA_LUT_SIZE		4096
>  
> -#define AFBC_MOD_VALID_BITS (AFBC_FORMAT_MOD_BLOCK_SIZE_MASK | \
> -			AFBC_FORMAT_MOD_YTR | AFBC_FORMAT_MOD_SPLIT | \
> -			AFBC_FORMAT_MOD_SPARSE | AFBC_FORMAT_MOD_CBR | \
> -			AFBC_FORMAT_MOD_TILED | AFBC_FORMAT_MOD_SC)
> +#define AFBC_SIZE_MASK		AFBC_FORMAT_MOD_BLOCK_SIZE_MASK
> +#define AFBC_SIZE_16X16		AFBC_FORMAT_MOD_BLOCK_SIZE_16x16
> +#define AFBC_YTR		AFBC_FORMAT_MOD_YTR
> +#define AFBC_SPARSE		AFBC_FORMAT_MOD_SPARSE
> +#define AFBC_CBR		AFBC_FORMAT_MOD_CBR
> +#define AFBC_SPLIT		AFBC_FORMAT_MOD_SPLIT
> +#define AFBC_TILED		AFBC_FORMAT_MOD_TILED
> +#define AFBC_SC			AFBC_FORMAT_MOD_SC

Why do you need the aliasing of the names? Just to help the typing?


> +
> +#define AFBC_MOD_VALID_BITS (AFBC_SIZE_MASK | AFBC_YTR | AFBC_SPLIT | AFBC_SPARSE | AFBC_CBR | AFBC_TILED | AFBC_SC)

The length of the lines are getting a bit too big, maybe follow the
style of the code you are removing and split the macro into multiple
lines?

Best regards,
Liviu


> +
> +extern const u64 malidp_format_modifiers[];
>  
>  #endif  /* __MALIDP_HW_H__ */
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
