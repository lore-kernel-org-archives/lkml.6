Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934011AbeCGQkw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 11:40:52 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36414 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933487AbeCGQkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 11:40:47 -0500
X-Google-Smtp-Source: AG47ELuRtyzlFkIys0wYtix7pH2SGs/y1fqo1UOV9sP+u/L6cy1CZSgPNj2IXGii1iQnPFNd0DliSw==
Date: Wed, 7 Mar 2018 16:40:44 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Daniel Schultz <d.schultz@phytec.de>
Cc: linux-kernel@vger.kernel.org, w.egorov@phytec.de
Subject: Re: [PATCH 1/2] mfd: rk808: Change DEV_OFF to DEV_OFF_RST for rk818
 shutdown
Message-ID: <20180307164044.lsu3tjcrcf3mf7wt@dell>
References: <1520255801-8557-1-git-send-email-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1520255801-8557-1-git-send-email-d.schultz@phytec.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Mar 2018, Daniel Schultz wrote:

> After running "poweroff", the PMIC restarts the SoC instead of shutting
> it down.
> 
> It seems like the description for those two register bits is swapped.
> After changing from DEV_OFF to DEV_OFF_RST, the system can poweroff
> correctly.
> 
> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
> ---
>  drivers/mfd/rk808.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Please could you re-submit these 2 patches with the Rock Chips guys in
Cc.  It would be easier to review if we had some expert eyes-on and a
Tested-by or 2.

> diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
> index 216fbf6..d138721 100644
> --- a/drivers/mfd/rk808.c
> +++ b/drivers/mfd/rk808.c
> @@ -418,7 +418,7 @@ static void rk818_device_shutdown(void)
>  
>  	ret = regmap_update_bits(rk808->regmap,
>  				 RK818_DEVCTRL_REG,
> -				 DEV_OFF, DEV_OFF);
> +				 DEV_OFF_RST, DEV_OFF_RST);
>  	if (ret)
>  		dev_err(&rk808_i2c_client->dev, "power off error!\n");
>  }

-- 
Lee Jones
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
