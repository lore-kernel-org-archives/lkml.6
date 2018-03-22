Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754533AbeCVP3o (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 11:29:44 -0400
Received: from mail.bootlin.com ([62.4.15.54]:47836 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752199AbeCVP33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 11:29:29 -0400
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: ocelot: fix gpio direction
References: <20180322123500.2379-1-alexandre.belloni@bootlin.com>
Date: Thu, 22 Mar 2018 16:29:17 +0100
In-Reply-To: <20180322123500.2379-1-alexandre.belloni@bootlin.com> (Alexandre
        Belloni's message of "Thu, 22 Mar 2018 13:35:00 +0100")
Message-ID: <87muz0w2lu.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,
 
 On jeu., mars 22 2018, Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> Bits have to be cleared in DEVCPU_GCB:GPIO:GPIO_OE for input and set for
> output. ocelot_gpio_set_direction() got it wrong and this went unnoticed
> when the driver was reworked.
>
> Reported-by: Gregory Clement <gregory.clement@bootlin.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Thanks,

Gregory

> ---
>  drivers/pinctrl/pinctrl-ocelot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
> index a9423238471e..b5b3547fdcb2 100644
> --- a/drivers/pinctrl/pinctrl-ocelot.c
> +++ b/drivers/pinctrl/pinctrl-ocelot.c
> @@ -252,7 +252,7 @@ static int ocelot_gpio_set_direction(struct pinctrl_dev *pctldev,
>  	struct ocelot_pinctrl *info = pinctrl_dev_get_drvdata(pctldev);
>  
>  	regmap_update_bits(info->map, OCELOT_GPIO_OE, BIT(pin),
> -			   input ? BIT(pin) : 0);
> +			   input ? 0 : BIT(pin));
>  
>  	return 0;
>  }
> -- 
> 2.16.2
>

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
