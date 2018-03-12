Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751776AbeCLOJv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 10:09:51 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33341 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751320AbeCLOJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 10:09:50 -0400
X-Google-Smtp-Source: AG47ELvpQvRvh8BL8chQSnJJ2mfoVwtqClXakpX20EXlEkMHTGnSP/ems8Jze1wA2bW3qNxWXmNM/A==
Date: Mon, 12 Mar 2018 14:09:46 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Daniel Schultz <d.schultz@phytec.de>
Cc: zyw@rock-chips.com, zhangqing@rock-chips.com, chenjh@rock-chips.com,
        linux-kernel@vger.kernel.org, w.egorov@phytec.de
Subject: Re: [PATCH v2 1/2] mfd: rk808: Change DEV_OFF to DEV_OFF_RST for
 rk818 shutdown
Message-ID: <20180312140946.quqbfvjourjwjaju@dell>
References: <1520442110-28420-1-git-send-email-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1520442110-28420-1-git-send-email-d.schultz@phytec.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rockchip guys,

I'd really appreciate your input on these two patches please.

Please provide Reviewed-by/Tested-by tags.

On Wed, 07 Mar 2018, Daniel Schultz wrote:
> After running "poweroff", the PMIC restarts the SoC instead of shutting
> it down.
> 
> It seems like the description for those two register bits is swapped.
> After changing from DEV_OFF to DEV_OFF_RST, the system can poweroff
> correctly.
> 
> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
> ---
> Changes:
> 	v2: Re-submit with recipients from Rockchip.
> 
>  drivers/mfd/rk808.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
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
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
