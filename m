Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753093AbeFDM0c (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 08:26:32 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38815 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753036AbeFDM02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 08:26:28 -0400
X-Google-Smtp-Source: ADUXVKIoiQNWcpLqXHr45aw3jmWJw1z7ioQ2+XzJWLRu4PIvlx3DzrMQk6YO4qOL9EMjci3k2G4pvw==
Date: Mon, 4 Jun 2018 13:26:24 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3 02/10] mfd: da9063: Use REGMAP_IRQ_REG
Message-ID: <20180604122624.GB21163@dell>
References: <20180602101155.26375-1-marek.vasut+renesas@gmail.com>
 <20180602101155.26375-2-marek.vasut+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180602101155.26375-2-marek.vasut+renesas@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 02 Jun 2018, Marek Vasut wrote:

> Convert the regmap_irq table to use REGMAP_IRQ_REG().
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Steve Twiss <stwiss.opensource@diasemi.com>
> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Cc: linux-renesas-soc@vger.kernel.org
> ---
> V3: New patch
> Note: A sed oneliner was used:
>       sed -i "/\[DA9063_IRQ_/ {N;N;N;s/\n//g;s/.*\[\(DA9063_IRQ_[^]]\+\)].*reg_offset = \([^,]\+\),.* = \([^,]\+\),.*/\tREGMAP_IRQ_REG(\1, \2, \3),/}" drivers/mfd/da9063-irq.c
> ---
>  drivers/mfd/da9063-irq.c | 145 ++++++++++-------------------------------------
>  1 file changed, 29 insertions(+), 116 deletions(-)
> 
> diff --git a/drivers/mfd/da9063-irq.c b/drivers/mfd/da9063-irq.c
> index 207bbfe55449..5b406ecfc14a 100644
> --- a/drivers/mfd/da9063-irq.c
> +++ b/drivers/mfd/da9063-irq.c
> @@ -28,125 +28,38 @@
>  
>  static const struct regmap_irq da9063_irqs[] = {
>  	/* DA9063 event A register */
> -	[DA9063_IRQ_ONKEY] = {
> -		.reg_offset = DA9063_REG_EVENT_A_OFFSET,
> -		.mask = DA9063_M_ONKEY,
> -	},
> -	[DA9063_IRQ_ALARM] = {
> -		.reg_offset = DA9063_REG_EVENT_A_OFFSET,
> -		.mask = DA9063_M_ALARM,
> -	},
> -	[DA9063_IRQ_TICK] = {
> -		.reg_offset = DA9063_REG_EVENT_A_OFFSET,
> -		.mask = DA9063_M_TICK,
> -	},
> -	[DA9063_IRQ_ADC_RDY] = {
> -		.reg_offset = DA9063_REG_EVENT_A_OFFSET,
> -		.mask = DA9063_M_ADC_RDY,
> -	},
> -	[DA9063_IRQ_SEQ_RDY] = {
> -		.reg_offset = DA9063_REG_EVENT_A_OFFSET,
> -		.mask = DA9063_M_SEQ_RDY,
> -	},
> +	REGMAP_IRQ_REG(DA9063_IRQ_ONKEY, DA9063_REG_EVENT_A_OFFSET, DA9063_M_ONKEY),
> +	REGMAP_IRQ_REG(DA9063_IRQ_ALARM, DA9063_REG_EVENT_A_OFFSET, DA9063_M_ALARM),
> +	REGMAP_IRQ_REG(DA9063_IRQ_TICK, DA9063_REG_EVENT_A_OFFSET, DA9063_M_TICK),
> +	REGMAP_IRQ_REG(DA9063_IRQ_ADC_RDY, DA9063_REG_EVENT_A_OFFSET, DA9063_M_ADC_RDY),
> +	REGMAP_IRQ_REG(DA9063_IRQ_SEQ_RDY, DA9063_REG_EVENT_A_OFFSET, DA9063_M_SEQ_RDY),

Nice, but I think checkpatch.pl would complain.

Better to break after the first argument I think.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
