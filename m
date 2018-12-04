Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5F0C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 290B920672
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:51:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 290B920672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbeLDRvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 12:51:42 -0500
Received: from foss.arm.com ([217.140.101.70]:38126 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbeLDRvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 12:51:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 294E8A78;
        Tue,  4 Dec 2018 09:51:41 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA4823F59C;
        Tue,  4 Dec 2018 09:51:40 -0800 (PST)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 347996801C3; Tue,  4 Dec 2018 17:51:39 +0000 (GMT)
Date:   Tue, 4 Dec 2018 17:51:39 +0000
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
Subject: Re: [RFC AFBC 10/12] drm/arm/malidp:- Use the newly introduced
 malidp_format_get_bpp() instead of relying on cpp for calculating
 framebuffer size
Message-ID: <20181204175139.GR988@e110455-lin.cambridge.arm.com>
References: <1543836703-8491-1-git-send-email-ayan.halder@arm.com>
 <1543836703-8491-11-git-send-email-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1543836703-8491-11-git-send-email-ayan.halder@arm.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 11:32:04AM +0000, Ayan Halder wrote:
> Formats like DRM_FORMAT_VUY101010, DRM_FORMAT_YUV420_8BIT and
> DRM_FORMAT_YUV420_10BIT are expressed in bits per pixel as they have a non
> integer value of cpp (thus denoted as '0' in drm_format_info[]). Therefore,
> the calculation of AFBC framebuffer size needs to use malidp_format_get_bpp().
> 
> Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/arm/malidp_drv.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
> index 2f0b553..b2b97db 100644
> --- a/drivers/gpu/drm/arm/malidp_drv.c
> +++ b/drivers/gpu/drm/arm/malidp_drv.c
> @@ -297,6 +297,7 @@ malidp_verify_afbc_framebuffer_size(struct drm_device *dev,
>  	struct drm_gem_object *objs = NULL;
>  	u32 afbc_superblock_size = 0, afbc_superblock_height = 0;
>  	u32 afbc_superblock_width = 0, afbc_size = 0;
> +	int bpp = 0;
>  
>  	switch (mode_cmd->modifier[0] & AFBC_SIZE_MASK) {
>  	case AFBC_SIZE_16X16:
> @@ -313,15 +314,17 @@ malidp_verify_afbc_framebuffer_size(struct drm_device *dev,
>  	n_superblocks = (mode_cmd->width / afbc_superblock_width) *
>  		(mode_cmd->height / afbc_superblock_height);
>  
> -	afbc_superblock_size = info->cpp[0] * afbc_superblock_width *
> -		afbc_superblock_height;
> +	bpp = malidp_format_get_bpp(info->format);
> +
> +	afbc_superblock_size = (bpp * afbc_superblock_width * afbc_superblock_height) / BITS_PER_BYTE;
>  
>  	afbc_size = ALIGN(n_superblocks * AFBC_HEADER_SIZE, AFBC_SUPERBLK_ALIGNMENT);
>  	afbc_size += n_superblocks * ALIGN(afbc_superblock_size, AFBC_SUPERBLK_ALIGNMENT);
>  
> -	if (mode_cmd->width * info->cpp[0] != mode_cmd->pitches[0]) {
> -		DRM_DEBUG_KMS("Invalid value of pitch (=%u) should be same as width (=%u) * cpp (=%u)\n",
> -			      mode_cmd->pitches[0], mode_cmd->width, info->cpp[0]);
> +	if ((mode_cmd->width * bpp) != (mode_cmd->pitches[0] * BITS_PER_BYTE)) {
> +		DRM_DEBUG_KMS("Invalid value of (pitch * BITS_PER_BYTE) (=%u) "
> +			      "should be same as width (=%u) * bpp (=%u)\n",
> +			      (mode_cmd->pitches[0] * BITS_PER_BYTE), mode_cmd->width, bpp);
>  		return false;
>  	}
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
