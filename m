Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754442AbeDTJlG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 05:41:06 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:39190 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754394AbeDTJlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 05:41:05 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: dri-devel@lists.freedesktop.org
Cc: Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>, devicetree@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Russell King <linux@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 5/7] drm/i2c: tda998x: find the drm_device via the drm_connector
Date: Fri, 20 Apr 2018 12:41:14 +0300
Message-ID: <1995876.dqZyKbpDZd@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180419162751.25223-6-peda@axentia.se>
References: <20180419162751.25223-1-peda@axentia.se> <20180419162751.25223-6-peda@axentia.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Thank you for the patch.

On Thursday, 19 April 2018 19:27:49 EEST Peter Rosin wrote:
> This prepares for being a drm_bridge which will not register the
> encoder. That makes the connector the better choice.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/i2c/tda998x_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c
> b/drivers/gpu/drm/i2c/tda998x_drv.c index cd3f0873bbdd..8f6e013f2b87 100644
> --- a/drivers/gpu/drm/i2c/tda998x_drv.c
> +++ b/drivers/gpu/drm/i2c/tda998x_drv.c
> @@ -630,7 +630,7 @@ static void tda998x_detect_work(struct work_struct
> *work) {
>  	struct tda998x_priv *priv =
>  		container_of(work, struct tda998x_priv, detect_work);
> -	struct drm_device *dev = priv->encoder.dev;
> +	struct drm_device *dev = priv->connector.dev;
> 
>  	if (dev)
>  		drm_kms_helper_hotplug_event(dev);


-- 
Regards,

Laurent Pinchart
