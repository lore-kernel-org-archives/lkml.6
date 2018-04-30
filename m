Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752786AbeD3KSj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 06:18:39 -0400
Received: from mga12.intel.com ([192.55.52.136]:38019 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752363AbeD3KSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 06:18:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,346,1520924400";
   d="scan'208";a="51101761"
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Daniel Vetter <daniel.vetter@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>
Subject: Re: [PATCH 2/6] backlight/generic-bl: remove DRIVER1 state
In-Reply-To: <20180425174253.4616-2-daniel.vetter@ffwll.ch>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20180425174253.4616-1-daniel.vetter@ffwll.ch> <20180425174253.4616-2-daniel.vetter@ffwll.ch>
Date: Mon, 30 Apr 2018 13:21:16 +0300
Message-ID: <87lgd59eqr.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Apr 2018, Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> Nothing in the entire tree ever sets this, which means this is dead
> code. Remove it.
>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

> ---
>  drivers/video/backlight/generic_bl.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/video/backlight/generic_bl.c b/drivers/video/backlight/generic_bl.c
> index 67dfb939a514..4dea91acea13 100644
> --- a/drivers/video/backlight/generic_bl.c
> +++ b/drivers/video/backlight/generic_bl.c
> @@ -21,9 +21,6 @@ static int genericbl_intensity;
>  static struct backlight_device *generic_backlight_device;
>  static struct generic_bl_info *bl_machinfo;
>  
> -/* Flag to signal when the battery is low */
> -#define GENERICBL_BATTLOW       BL_CORE_DRIVER1
> -
>  static int genericbl_send_intensity(struct backlight_device *bd)
>  {
>  	int intensity = bd->props.brightness;
> @@ -34,8 +31,6 @@ static int genericbl_send_intensity(struct backlight_device *bd)
>  		intensity = 0;
>  	if (bd->props.state & BL_CORE_SUSPENDED)
>  		intensity = 0;
> -	if (bd->props.state & GENERICBL_BATTLOW)
> -		intensity &= bl_machinfo->limit_mask;
>  
>  	bl_machinfo->set_bl_intensity(intensity);

-- 
Jani Nikula, Intel Open Source Technology Center
