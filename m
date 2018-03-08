Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751333AbeCHUtq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 15:49:46 -0500
Received: from mail.bootlin.com ([62.4.15.54]:35616 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750761AbeCHUtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 15:49:43 -0500
Date: Thu, 8 Mar 2018 21:49:41 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, broonie@kernel.org,
        linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/4] rtc: at91sam9: Pass pdev->dev to
 regmap_init_mmio()
Message-ID: <20180308204941.GK20370@piout.net>
References: <20180308102154.25686-1-jeffy.chen@rock-chips.com>
 <20180308102154.25686-3-jeffy.chen@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180308102154.25686-3-jeffy.chen@rock-chips.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2018 at 18:21:52 +0800, Jeffy Chen wrote:
> Otherwise it would use "dummy*" to create regmap debugfs dir.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
> Changes in v3: None
> 
>  drivers/rtc/rtc-at91sam9.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-at91sam9.c b/drivers/rtc/rtc-at91sam9.c
> index 7418a763ce52..0d6a17a77841 100644
> --- a/drivers/rtc/rtc-at91sam9.c
> +++ b/drivers/rtc/rtc-at91sam9.c
> @@ -402,7 +402,7 @@ static int at91_rtc_probe(struct platform_device *pdev)
>  		if (IS_ERR(gpbr))
>  			return PTR_ERR(gpbr);
>  
> -		rtc->gpbr = regmap_init_mmio(NULL, gpbr,
> +		rtc->gpbr = regmap_init_mmio(&pdev->dev, gpbr,
>  					     &gpbr_regmap_config);

This would be misleading as the gpbr is not directly related to the rtc.


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
