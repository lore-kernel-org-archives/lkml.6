Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757132AbeDZWQs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 18:16:48 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:60952 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754760AbeDZWQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 18:16:46 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: architt@codeaurora.org, a.hajda@samsung.com, airlied@linux.ie,
        daniel.vetter@ffwll.ch, bhumirks@gmail.com, narmstrong@baylibre.com,
        inki.dae@samsung.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpu: drm: bridge: adv7511: Replace mdelay with usleep_range in adv7511_probe
Date: Fri, 27 Apr 2018 01:16:59 +0300
Message-ID: <5009396.5p49gfLLAe@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <1523435622-4329-1-git-send-email-baijiaju1990@gmail.com>
References: <1523435622-4329-1-git-send-email-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jia-Ju,

Thank you for the patch.

On Wednesday, 11 April 2018 11:33:42 EEST Jia-Ju Bai wrote:
> adv7511_probe() is never called in atomic context.
> This function is only set as ".probe" in struct i2c_driver.
> 
> Despite never getting called from atomic context, adv7511_probe()
> calls mdelay() to busily wait.
> This is not necessary and can be replaced with usleep_range() to
> avoid busy waiting.
> 
> This is found by a static analysis tool named DCNS written by myself.
> And I also manually check it.

Nice work ! Is the tool open-source ?

> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c index b2431ae..2cf7fa1
> 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> @@ -1054,7 +1054,7 @@ static int adv7511_probe(struct i2c_client *i2c, const
> struct i2c_device_id *id) }
> 
>  	if (adv7511->gpio_pd) {
> -		mdelay(5);
> +		usleep_range(5000, 6000);
>  		gpiod_set_value_cansleep(adv7511->gpio_pd, 0);
>  	}

The patch looks good to me.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

-- 
Regards,

Laurent Pinchart
