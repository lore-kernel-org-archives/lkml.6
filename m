Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753672AbeDYNcP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 09:32:15 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:39628 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752949AbeDYNcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 09:32:11 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Vaishali Thakkar <vthakkar1994@gmail.com>
Cc: airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: rcar-du: Use drm_dev_put
Date: Wed, 25 Apr 2018 16:32:25 +0300
Message-ID: <5811471.PjpYk9OX8O@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180425121036.28965-1-vthakkar1994@gmail.com>
References: <20180425121036.28965-1-vthakkar1994@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vaishali,

Thank you for the patch.

On Wednesday, 25 April 2018 15:10:36 EEST Vaishali Thakkar wrote:
> As specified in drm_drv.c, drm_dev_unref is a compatibility alias
> for drm_dev_put and shouldn't be used in new code. So, use
> drm_dev_put instead.

This looks good to me. However, how about taking it one step further and mass-
patching all drivers to use drm_dev_put() ? We could then remove 
drm_dev_unref() completely.

> Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
> ---
>  drivers/gpu/drm/rcar-du/rcar_du_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> b/drivers/gpu/drm/rcar-du/rcar_du_drv.c index 05745e86d73e..418a80e6b2f4
> 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> @@ -378,7 +378,7 @@ static int rcar_du_remove(struct platform_device *pdev)
>  	drm_kms_helper_poll_fini(ddev);
>  	drm_mode_config_cleanup(ddev);
> 
> -	drm_dev_unref(ddev);
> +	drm_dev_put(ddev);
> 
>  	return 0;
>  }

-- 
Regards,

Laurent Pinchart
