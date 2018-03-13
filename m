Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752376AbeCMJgb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 05:36:31 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41492 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752148AbeCMJg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 05:36:29 -0400
X-Google-Smtp-Source: AG47ELuj32bqhqjf2PgcFfOkEKUpAL53bpBrsorvrv4JF9KE/1m0FfTxTZxcl7bkJKnc4Xn9b2h1QA==
Subject: Re: [PATCH 1/3] drm/meson: Fix an un-handled error path in
 'meson_drv_bind_master()'
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, airlied@linux.ie,
        carlo@caione.org, khilman@baylibre.com
Cc: dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <cover.1520885192.git.christophe.jaillet@wanadoo.fr>
 <6cbf3d70ac3904489c7194c895225c4103aebb96.1520885192.git.christophe.jaillet@wanadoo.fr>
From: Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <48544583-2bf9-0904-b848-ec4194200af6@baylibre.com>
Date: Tue, 13 Mar 2018 10:36:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <6cbf3d70ac3904489c7194c895225c4103aebb96.1520885192.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2018 21:15, Christophe JAILLET wrote:
> 'drm_vblank_init()' can fail. So handle this (unlikely) error.
> 
> Fixes: bbbe775ec5b5 ("drm: Add support for Amlogic Meson Graphic Controller")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/gpu/drm/meson/meson_drv.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
> index f9ad0e960263..02b0886debc0 100644
> --- a/drivers/gpu/drm/meson/meson_drv.c
> +++ b/drivers/gpu/drm/meson/meson_drv.c
> @@ -222,7 +222,10 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
>  
>  	priv->vsync_irq = platform_get_irq(pdev, 0);
>  
> -	drm_vblank_init(drm, 1);
> +	ret = drm_vblank_init(drm, 1);
> +	if (ret)
> +		goto free_drm;
> +
>  	drm_mode_config_init(drm);
>  	drm->mode_config.max_width = 3840;
>  	drm->mode_config.max_height = 2160;
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>

Thanks,
Neil
