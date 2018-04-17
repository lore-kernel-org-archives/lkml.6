Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752514AbeDQLOV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 07:14:21 -0400
Received: from gloria.sntech.de ([95.129.55.99]:58440 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751810AbeDQLOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 07:14:20 -0400
From: Heiko Stuebner <heiko@sntech.de>
To: Sandy Huang <hjc@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/rockchip: vop: fixup linebuffer mode calc error
Date: Tue, 17 Apr 2018 13:14:08 +0200
Message-ID: <2475172.s4GHAT5PDW@phil>
In-Reply-To: <1523960108-190541-1-git-send-email-hjc@rock-chips.com>
References: <1523960108-190541-1-git-send-email-hjc@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sandy,

Am Dienstag, 17. April 2018, 12:15:07 CEST schrieb Sandy Huang:
> When video width is bigger than 3840 the linebuffer mode
> should be LB_YUV_3840X5.

Can you explain that a bit better?

I.e. when looking at the code, the very first check is width > 2560.

So it seems your change targets some YUV mode with width > 3840
which should be mentioned in the commit message, so people like
me don't scratch their head in confusion ;-)

Similarly that check is actually width > 1280 to set LB_YUV_3840X5,
so I guess you're actually wanting any YUV mode bigger than
1280px should use LB_YUV_3840X5?


Heiko

> Signed-off-by: Sandy Huang <hjc@rock-chips.com>
> ---
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
> index 56bbd2e..3e7501b 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
> @@ -332,7 +332,7 @@ static inline int scl_vop_cal_lb_mode(int width, bool is_yuv)
>  
>  	if (width > 2560)
>  		lb_mode = LB_RGB_3840X2;
> -	else if (width > 1920)
> +	else if (!is_yuv && width > 1920)
>  		lb_mode = LB_RGB_2560X4;
>  	else if (!is_yuv)
>  		lb_mode = LB_RGB_1920X5;
> 
