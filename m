Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752405AbeCMJer (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 05:34:47 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39879 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752063AbeCMJeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 05:34:46 -0400
X-Google-Smtp-Source: AG47ELtdwqj3z9iUtAyjKfE779fNsUDI6J+QlPgsfe+ZLvCHQRVw5NgKVArB2iNwwCldrX48v8sH4A==
Subject: Re: [PATCH 2/3] drm/meson: Use drm_dev_put() instead of
 drm_dev_unref()
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, airlied@linux.ie,
        carlo@caione.org, khilman@baylibre.com
Cc: dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <cover.1520885192.git.christophe.jaillet@wanadoo.fr>
 <d4ce46077d3ada7149c4555acfdda8ade4a6cf50.1520885192.git.christophe.jaillet@wanadoo.fr>
From: Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <0f801ea3-79e0-9942-2c18-6294e2c769cb@baylibre.com>
Date: Tue, 13 Mar 2018 10:34:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <d4ce46077d3ada7149c4555acfdda8ade4a6cf50.1520885192.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2018 21:15, Christophe JAILLET wrote:
> According to 'drivers/gpu/drm/drm_drv.c', 'drm_dev_unref()' is just a
> compatibility alias for 'drm_dev_put()'. So use the latter instead.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/gpu/drm/meson/meson_drv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
> index 02b0886debc0..6ee3dd7fa450 100644
> --- a/drivers/gpu/drm/meson/meson_drv.c
> +++ b/drivers/gpu/drm/meson/meson_drv.c
> @@ -284,7 +284,7 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
>  	return 0;
>  
>  free_drm:
> -	drm_dev_unref(drm);
> +	drm_dev_put(drm);
>  
>  	return ret;
>  }
> @@ -303,7 +303,7 @@ static void meson_drv_unbind(struct device *dev)
>  	drm_kms_helper_poll_fini(drm);
>  	drm_fbdev_cma_fini(priv->fbdev);
>  	drm_mode_config_cleanup(drm);
> -	drm_dev_unref(drm);
> +	drm_dev_put(drm);
>  
>  }
>  
> 

It's not useless, there is a clear statement :
 * This is a compatibility alias for drm_dev_put() and should not be used by new
 * code.

Acked-by: Neil Armstrong <narmstrong@baylibre.com>

Thanks,
Neil
