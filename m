Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751176AbeEAEXu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 00:23:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50490 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750817AbeEAEXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 00:23:48 -0400
Subject: Re: [PATCH][next] pinctrl: actions: Fix Kconfig dependency and help
 text
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linus.walleij@linaro.org, afaerber@suse.de, sfr@canb.auug.org.au
Cc: linux-next@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180501030047.305-1-manivannan.sadhasivam@linaro.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <92d58976-7fe4-517e-95e9-b4255ecb390c@infradead.org>
Date: Mon, 30 Apr 2018 21:23:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180501030047.305-1-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/30/2018 08:00 PM, Manivannan Sadhasivam wrote:
> 1. Fix Kconfig dependency for Actions Semi S900 pinctrl driver which
> generates below warning in x86:
> 
> WARNING: unmet direct dependencies detected for PINCTRL_OWL
>   Depends on [n]: PINCTRL [=y] && (ARCH_ACTIONS || COMPILE_TEST [=n]) && OF [=n]
>   Selected by [y]:
>   - PINCTRL_S900 [=y] && PINCTRL [=y]
> 
> 2. Add help text for OWL pinctrl driver
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/pinctrl/actions/Kconfig | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/actions/Kconfig b/drivers/pinctrl/actions/Kconfig
> index 1c7309c90f0d..ede97cdbbc12 100644
> --- a/drivers/pinctrl/actions/Kconfig
> +++ b/drivers/pinctrl/actions/Kconfig
> @@ -1,12 +1,14 @@
>  config PINCTRL_OWL
> -	bool
> +	bool "Actions Semi OWL pinctrl driver"
>  	depends on (ARCH_ACTIONS || COMPILE_TEST) && OF
>  	select PINMUX
>  	select PINCONF
>  	select GENERIC_PINCONF
> +	help
> +	  Say Y here to enable Actions Semi OWL pinctrl driver
>  
>  config PINCTRL_S900
>  	bool "Actions Semi S900 pinctrl driver"
> -	select PINCTRL_OWL
> +	depends on PINCTRL_OWL
>  	help
>  	  Say Y here to enable Actions Semi S900 pinctrl driver
> 


-- 
~Randy
