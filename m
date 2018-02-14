Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030223AbeBNN1t (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 08:27:49 -0500
Received: from lelnx194.ext.ti.com ([198.47.27.80]:20013 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967713AbeBNN1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 08:27:48 -0500
Subject: Re: [PATCH 1/2] drm/tilcdc: Delete an error message for a failed
 memory allocation in seven functions
To: SF Markus Elfring <elfring@users.sourceforge.net>,
        <dri-devel@lists.freedesktop.org>, David Airlie <airlied@linux.ie>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>
CC: LKML <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <a7c7cebb-f4c9-04b7-5507-e41f8ebfb5f9@users.sourceforge.net>
 <8391221b-45f4-7ad2-ad21-3681a945f034@users.sourceforge.net>
From: Jyri Sarha <jsarha@ti.com>
Message-ID: <8c7dbd4e-6c11-9a28-aaf0-1aaf7bf7d947@ti.com>
Date: Wed, 14 Feb 2018 15:27:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <8391221b-45f4-7ad2-ad21-3681a945f034@users.sourceforge.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02/18 23:23, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 6 Feb 2018 21:51:15 +0100
> 
> Omit an extra message for a memory allocation failure in these functions.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Thanks,
picked for the tilcdc next pull request.

Best regards,
Jyri

> ---
>  drivers/gpu/drm/tilcdc/tilcdc_crtc.c   | 4 +---
>  drivers/gpu/drm/tilcdc/tilcdc_drv.c    | 4 +---
>  drivers/gpu/drm/tilcdc/tilcdc_panel.c  | 9 ++-------
>  drivers/gpu/drm/tilcdc/tilcdc_tfp410.c | 8 ++------
>  4 files changed, 6 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
> index 8bf6bb93dc79..1b278a22c8b7 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
> @@ -994,10 +994,8 @@ int tilcdc_crtc_create(struct drm_device *dev)
>  	int ret;
>  
>  	tilcdc_crtc = devm_kzalloc(dev->dev, sizeof(*tilcdc_crtc), GFP_KERNEL);
> -	if (!tilcdc_crtc) {
> -		dev_err(dev->dev, "allocation failed\n");
> +	if (!tilcdc_crtc)
>  		return -ENOMEM;
> -	}
>  
>  	init_completion(&tilcdc_crtc->palette_loaded);
>  	tilcdc_crtc->palette_base = dmam_alloc_coherent(dev->dev,
> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> index 1afde61f1247..b8a5e4ed22e6 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> @@ -233,10 +233,8 @@ static int tilcdc_init(struct drm_driver *ddrv, struct device *dev)
>  	int ret;
>  
>  	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> -	if (!priv) {
> -		dev_err(dev, "failed to allocate private data\n");
> +	if (!priv)
>  		return -ENOMEM;
> -	}
>  
>  	ddev = drm_dev_alloc(ddrv, dev);
>  	if (IS_ERR(ddev))
> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_panel.c b/drivers/gpu/drm/tilcdc/tilcdc_panel.c
> index 8eebb5f826a6..0b6aa95aec89 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_panel.c
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_panel.c
> @@ -101,10 +101,8 @@ static struct drm_encoder *panel_encoder_create(struct drm_device *dev,
>  
>  	panel_encoder = devm_kzalloc(dev->dev, sizeof(*panel_encoder),
>  				     GFP_KERNEL);
> -	if (!panel_encoder) {
> -		dev_err(dev->dev, "allocation failed\n");
> +	if (!panel_encoder)
>  		return NULL;
> -	}
>  
>  	panel_encoder->mod = mod;
>  
> @@ -210,10 +208,8 @@ static struct drm_connector *panel_connector_create(struct drm_device *dev,
>  
>  	panel_connector = devm_kzalloc(dev->dev, sizeof(*panel_connector),
>  				       GFP_KERNEL);
> -	if (!panel_connector) {
> -		dev_err(dev->dev, "allocation failed\n");
> +	if (!panel_connector)
>  		return NULL;
> -	}
>  
>  	panel_connector->encoder = encoder;
>  	panel_connector->mod = mod;
> @@ -294,7 +290,6 @@ static struct tilcdc_panel_info *of_get_panel_info(struct device_node *np)
>  
>  	info = kzalloc(sizeof(*info), GFP_KERNEL);
>  	if (!info) {
> -		pr_err("%s: allocation failed\n", __func__);
>  		of_node_put(info_np);
>  		return NULL;
>  	}
> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_tfp410.c b/drivers/gpu/drm/tilcdc/tilcdc_tfp410.c
> index 7e3643462a08..c45cabb38db0 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_tfp410.c
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_tfp410.c
> @@ -111,10 +111,8 @@ static struct drm_encoder *tfp410_encoder_create(struct drm_device *dev,
>  
>  	tfp410_encoder = devm_kzalloc(dev->dev, sizeof(*tfp410_encoder),
>  				      GFP_KERNEL);
> -	if (!tfp410_encoder) {
> -		dev_err(dev->dev, "allocation failed\n");
> +	if (!tfp410_encoder)
>  		return NULL;
> -	}
>  
>  	tfp410_encoder->dpms = DRM_MODE_DPMS_OFF;
>  	tfp410_encoder->mod = mod;
> @@ -224,10 +222,8 @@ static struct drm_connector *tfp410_connector_create(struct drm_device *dev,
>  
>  	tfp410_connector = devm_kzalloc(dev->dev, sizeof(*tfp410_connector),
>  					GFP_KERNEL);
> -	if (!tfp410_connector) {
> -		dev_err(dev->dev, "allocation failed\n");
> +	if (!tfp410_connector)
>  		return NULL;
> -	}
>  
>  	tfp410_connector->encoder = encoder;
>  	tfp410_connector->mod = mod;
> 


-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
