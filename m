Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935473AbeBLNWE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 08:22:04 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40612 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934007AbeBLNWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 08:22:02 -0500
Subject: Re: [PATCH] irqchip/irq-imx-gpcv2: Remove unused function
To: Fabio Estevam <festevam@gmail.com>, tglx@linutronix.de
Cc: andrew.smirnov@gmail.com, linux-kernel@vger.kernel.org,
        Fabio Estevam <fabio.estevam@nxp.com>
References: <1518441176-6107-1-git-send-email-festevam@gmail.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <287cdb39-92ed-79d7-82a0-69063e9d49e0@arm.com>
Date: Mon, 12 Feb 2018 13:22:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1518441176-6107-1-git-send-email-festevam@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/02/18 13:12, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> imx_gpcv2_get_wakeup_source() is not used anywhere, so remove it.
> 
> This fixes the following sparse warning:
> 
> drivers/irqchip/irq-imx-gpcv2.c:34:5: warning: symbol 'imx_gpcv2_get_wakeup_source' was not declared. Should it be static?
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  drivers/irqchip/irq-imx-gpcv2.c | 14 --------------
>  1 file changed, 14 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-imx-gpcv2.c b/drivers/irqchip/irq-imx-gpcv2.c
> index 675eda5..4760307 100644
> --- a/drivers/irqchip/irq-imx-gpcv2.c
> +++ b/drivers/irqchip/irq-imx-gpcv2.c
> @@ -28,20 +28,6 @@ struct gpcv2_irqchip_data {
>  
>  static struct gpcv2_irqchip_data *imx_gpcv2_instance;
>  
> -/*
> - * Interface for the low level wakeup code.
> - */
> -u32 imx_gpcv2_get_wakeup_source(u32 **sources)
> -{
> -	if (!imx_gpcv2_instance)
> -		return 0;
> -
> -	if (sources)
> -		*sources = imx_gpcv2_instance->wakeup_sources;
> -
> -	return IMR_NUM;
> -}
> -
>  static int gpcv2_wakeup_source_save(void)
>  {
>  	struct gpcv2_irqchip_data *cd;
> 

I'll queue this up for -rc2, with this addition:

Fixes: e324c4dc4a59 ("irqchip/imx-gpcv2: IMX GPCv2 driver for wakeup
sources")

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
