Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66976C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1861B20819
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="BKasgaZn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1861B20819
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729892AbeKEWMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 17:12:44 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40605 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728971AbeKEWMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 17:12:43 -0500
Received: by mail-wr1-f65.google.com with SMTP id i17-v6so9387755wre.7
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 04:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=FScKFZTAxHg4bvwUt58mNUAFnNr0vviGjYNYxYvx2GA=;
        b=BKasgaZnNp/zNEl6BXO0BM3KjlbpoiQN5eTOJq2Jq15znv9v3p3aUdeVm9FDvff7G3
         pMBbNU836l3GJ4UPPKYTP44ihJhUY8McHtQVJaWOdRzlEQ33IERARUcr2AzZnvvn+lPi
         pUbWpt/F5iZWdue6JZSiaORH8Hvw1Ma2JPyeYdYi7FPdsTIC3bUZbQwDvR0g3fhbBSYk
         2/pqTy/QULSwgWh+nZM2fV5/WxFd+jG9qk384FyAp5DfRMA/SmdhjHfI65o65qOuYMKY
         YK6KzrfdYhqssZLwIzqRNC1kRHosw2LLt2pJaKIPYbl/U1Z4G6QLnkTj2Uccumyav45o
         VK5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=FScKFZTAxHg4bvwUt58mNUAFnNr0vviGjYNYxYvx2GA=;
        b=aKHbbQxdH5qNyQqZ6brLfBLXE4YT+0D3VFyo7vCd2cHpIJQohxTuGrSUVSXdSPgIJK
         VlMpq2G0IdkOpCqX6BD3ymLx7I2gVIc8F9hvymOxAcOsaWMDYYRBSobWenfSzsc4AgfO
         U2tjCEprSWxUz0ex2tj+NX45ABWlfEjOwbU3OnPnB4jKwyqaF4iy0qqyqM7jFtdYSJFI
         lsApehfPLO9AZhg6RxnWsbC+gRpd5z4zRr+QzoNo7ayCq1G5QZYR59Jhvdys4lWEACss
         Qfqxl4dODgV3evNiyv0ELZLHZ/VIXg3BSnSimD95mBbcoo8FiZx+YnLJNP4/scgLRxUS
         Q+Dg==
X-Gm-Message-State: AGRZ1gKmyJ4RNaMufrliboZ/cLIrai8VM4wMDVj8Zw8lh773KkAA8dU3
        Y1eu2ZHx2YdVFsmM2a5RNznGLQ==
X-Google-Smtp-Source: AJdET5cVFikEyJo1xGA2uhKwP8lzl3gku5Q1zaUJ9bCxqZTKkVHplhoPyZHK5k4WYbDQHhAZ97FZmA==
X-Received: by 2002:adf:e781:: with SMTP id n1-v6mr15300404wrm.115.1541422385183;
        Mon, 05 Nov 2018 04:53:05 -0800 (PST)
Received: from [10.1.2.12] ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id v129-v6sm23195129wme.45.2018.11.05.04.53.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 04:53:04 -0800 (PST)
Subject: Re: [PATCH 2/2] drm/meson: Use optional canvas provider
To:     Maxime Jourdan <mjourdan@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org
References: <20181105104508.23090-1-mjourdan@baylibre.com>
 <20181105104508.23090-3-mjourdan@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKE5laWwgQXJtc3Ryb25nIDxuYXJtc3Ryb25nQGJheWxpYnJlLmNvbT7CwHsEEwEKACUC
 GyMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheABQJXDO2CAhkBAAoJEBaat7Gkz/iubGIH/iyk
 RqvgB62oKOFlgOTYCMkYpm2aAOZZLf6VKHKc7DoVwuUkjHfIRXdslbrxi4pk5VKU6ZP9AKsN
 NtMZntB8WrBTtkAZfZbTF7850uwd3eU5cN/7N1Q6g0JQihE7w4GlIkEpQ8vwSg5W7hkx3yQ6
 2YzrUZh/b7QThXbNZ7xOeSEms014QXazx8+txR7jrGF3dYxBsCkotO/8DNtZ1R+aUvRfpKg5
 ZgABTC0LmAQnuUUf2PHcKFAHZo5KrdO+tyfL+LgTUXIXkK+tenkLsAJ0cagz1EZ5gntuheLD
 YJuzS4zN+1Asmb9kVKxhjSQOcIh6g2tw7vaYJgL/OzJtZi6JlIXOwE0ETVkGzwEIALyKDN/O
 GURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYpQTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXM
 coJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hi
 SvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY4yG6xI99NIPEVE9lNBXBKIlewIyVlkOa
 YvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoMMtsyw18YoX9BqMFInxqYQQ3j/HpVgTSv
 mo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUXoUk33HEAEQEAAcLAXwQYAQIACQUCTVkG
 zwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfnM7IbRuiSZS1unlySUVYu3SD6YBYnNi3G
 5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa33eDIHu/zr1HMKErm+2SD6PO9umRef8V8
 2o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCSKmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+
 RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJ
 C3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTTQbM0WUIBIcGmq38+OgUsMYu4NzLu7uZF
 Acmp6h8g
Organization: Baylibre
Message-ID: <d4bbd846-bc77-4a04-a2a2-e5fac9de13ea@baylibre.com>
Date:   Mon, 5 Nov 2018 13:53:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181105104508.23090-3-mjourdan@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/2018 11:45, Maxime Jourdan wrote:
> This is the first step into converting the meson/drm driver to use
> the canvas module.
> 
> If a canvas provider node is detected in DT, use it. Otherwise,
> fall back to what is currently being done.
> 
> Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
> ---
>  drivers/gpu/drm/meson/Kconfig       |  1 +
>  drivers/gpu/drm/meson/meson_crtc.c  | 14 ++++++---
>  drivers/gpu/drm/meson/meson_drv.c   | 46 ++++++++++++++++++-----------
>  drivers/gpu/drm/meson/meson_drv.h   |  4 +++
>  drivers/gpu/drm/meson/meson_plane.c |  8 ++++-
>  5 files changed, 51 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/gpu/drm/meson/Kconfig b/drivers/gpu/drm/meson/Kconfig
> index 3ce51d8dfe1c..c28b69f48555 100644
> --- a/drivers/gpu/drm/meson/Kconfig
> +++ b/drivers/gpu/drm/meson/Kconfig
> @@ -7,6 +7,7 @@ config DRM_MESON
>  	select DRM_GEM_CMA_HELPER
>  	select VIDEOMODE_HELPERS
>  	select REGMAP_MMIO
> +	select MESON_CANVAS
>  
>  config DRM_MESON_DW_HDMI
>  	tristate "HDMI Synopsys Controller support for Amlogic Meson Display"
> diff --git a/drivers/gpu/drm/meson/meson_crtc.c b/drivers/gpu/drm/meson/meson_crtc.c
> index 05520202c967..b3bc0b0ee07f 100644
> --- a/drivers/gpu/drm/meson/meson_crtc.c
> +++ b/drivers/gpu/drm/meson/meson_crtc.c
> @@ -193,10 +193,16 @@ void meson_crtc_irq(struct meson_drm *priv)
>  		} else
>  			meson_vpp_disable_interlace_vscaler_osd1(priv);
>  
> -		meson_canvas_setup(priv, MESON_CANVAS_ID_OSD1,
> -			   priv->viu.osd1_addr, priv->viu.osd1_stride,
> -			   priv->viu.osd1_height, MESON_CANVAS_WRAP_NONE,
> -			   MESON_CANVAS_BLKMODE_LINEAR);
> +		if (priv->canvas)
> +			meson_canvas_config(priv->canvas, priv->canvas_id_osd1,
> +				priv->viu.osd1_addr, priv->viu.osd1_stride,
> +				priv->viu.osd1_height, MESON_CANVAS_WRAP_NONE,
> +				MESON_CANVAS_BLKMODE_LINEAR, 0);
> +		else
> +			meson_canvas_setup(priv, MESON_CANVAS_ID_OSD1,
> +				priv->viu.osd1_addr, priv->viu.osd1_stride,
> +				priv->viu.osd1_height, MESON_CANVAS_WRAP_NONE,
> +				MESON_CANVAS_BLKMODE_LINEAR);
>  
>  		/* Enable OSD1 */
>  		writel_bits_relaxed(VPP_OSD1_POSTBLEND, VPP_OSD1_POSTBLEND,
> diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
> index d3443125e661..b39c38c2350d 100644
> --- a/drivers/gpu/drm/meson/meson_drv.c
> +++ b/drivers/gpu/drm/meson/meson_drv.c
> @@ -216,24 +216,33 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
>  		goto free_drm;
>  	}
>  
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dmc");
> -	if (!res) {
> -		ret = -EINVAL;
> -		goto free_drm;
> -	}
> -	/* Simply ioremap since it may be a shared register zone */
> -	regs = devm_ioremap(dev, res->start, resource_size(res));
> -	if (!regs) {
> -		ret = -EADDRNOTAVAIL;
> -		goto free_drm;
> -	}
> +	priv->canvas = meson_canvas_get(dev);
> +	if (!IS_ERR(priv->canvas)) {
> +		ret = meson_canvas_alloc(priv->canvas, &priv->canvas_id_osd1);
> +		if (ret)
> +			goto free_drm;
> +	} else {
> +		priv->canvas = NULL;
>  
> -	priv->dmc = devm_regmap_init_mmio(dev, regs,
> -					  &meson_regmap_config);
> -	if (IS_ERR(priv->dmc)) {
> -		dev_err(&pdev->dev, "Couldn't create the DMC regmap\n");
> -		ret = PTR_ERR(priv->dmc);
> -		goto free_drm;
> +		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dmc");
> +		if (!res) {
> +			ret = -EINVAL;
> +			goto free_drm;
> +		}
> +		/* Simply ioremap since it may be a shared register zone */
> +		regs = devm_ioremap(dev, res->start, resource_size(res));
> +		if (!regs) {
> +			ret = -EADDRNOTAVAIL;
> +			goto free_drm;
> +		}
> +
> +		priv->dmc = devm_regmap_init_mmio(dev, regs,
> +						  &meson_regmap_config);
> +		if (IS_ERR(priv->dmc)) {
> +			dev_err(&pdev->dev, "Couldn't create the DMC regmap\n");
> +			ret = PTR_ERR(priv->dmc);
> +			goto free_drm;
> +		}
>  	}
>  
>  	priv->vsync_irq = platform_get_irq(pdev, 0);
> @@ -315,6 +324,9 @@ static void meson_drv_unbind(struct device *dev)
>  	struct drm_device *drm = dev_get_drvdata(dev);
>  	struct meson_drm *priv = drm->dev_private;
>  
> +	if (priv->canvas)
> +		meson_canvas_free(priv->canvas, priv->canvas_id_osd1);
> +
>  	drm_dev_unregister(drm);
>  	drm_kms_helper_poll_fini(drm);
>  	drm_fbdev_cma_fini(priv->fbdev);
> diff --git a/drivers/gpu/drm/meson/meson_drv.h b/drivers/gpu/drm/meson/meson_drv.h
> index 8450d6ac8c9b..728d0ca33732 100644
> --- a/drivers/gpu/drm/meson/meson_drv.h
> +++ b/drivers/gpu/drm/meson/meson_drv.h
> @@ -22,6 +22,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/of.h>
> +#include <linux/soc/amlogic/meson-canvas.h>
>  #include <drm/drmP.h>
>  
>  struct meson_drm {
> @@ -31,6 +32,9 @@ struct meson_drm {
>  	struct regmap *dmc;
>  	int vsync_irq;
>  
> +	struct meson_canvas *canvas;
> +	u8 canvas_id_osd1;
> +
>  	struct drm_device *drm;
>  	struct drm_crtc *crtc;
>  	struct drm_fbdev_cma *fbdev;
> diff --git a/drivers/gpu/drm/meson/meson_plane.c b/drivers/gpu/drm/meson/meson_plane.c
> index 12c80dfcff59..51bec8e98a39 100644
> --- a/drivers/gpu/drm/meson/meson_plane.c
> +++ b/drivers/gpu/drm/meson/meson_plane.c
> @@ -90,6 +90,7 @@ static void meson_plane_atomic_update(struct drm_plane *plane,
>  		.y2 = state->crtc_y + state->crtc_h,
>  	};
>  	unsigned long flags;
> +	u8 canvas_id_osd1;
>  
>  	/*
>  	 * Update Coordinates
> @@ -104,8 +105,13 @@ static void meson_plane_atomic_update(struct drm_plane *plane,
>  				   (0xFF << OSD_GLOBAL_ALPHA_SHIFT) |
>  				   OSD_BLK0_ENABLE;
>  
> +	if (priv->canvas)
> +		canvas_id_osd1 = priv->canvas_id_osd1;
> +	else
> +		canvas_id_osd1 = MESON_CANVAS_ID_OSD1;
> +
>  	/* Set up BLK0 to point to the right canvas */
> -	priv->viu.osd1_blk0_cfg[0] = ((MESON_CANVAS_ID_OSD1 << OSD_CANVAS_SEL) |
> +	priv->viu.osd1_blk0_cfg[0] = ((canvas_id_osd1 << OSD_CANVAS_SEL) |
>  				      OSD_ENDIANNESS_LE);
>  
>  	/* On GXBB, Use the old non-HDR RGB2YUV converter */
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
