Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751980AbeDSKXm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 06:23:42 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:40104 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751042AbeDSKXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 06:23:38 -0400
X-Google-Smtp-Source: AIpwx48drKpU+EMG6QkeR24pdfJO9xlVvXzvxlwGY+2UxxUTRaym4FIG1mQeZjY16wRzckxYxrv5jg==
Subject: Re: [PATCH v1 4/7] soc: mediatek: reuse regmap_read_poll_timeout
 helpers
To: sean.wang@mediatek.com, robh+dt@kernel.org, mark.rutland@arm.com,
        marcel@holtmann.org, johan.hedberg@gmail.com
Cc: devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>, Weiyi Lu <weiyi.lu@mediatek.com>
References: <cover.1522736996.git.sean.wang@mediatek.com>
 <2f84f7695ea3223b8626a8369aa4ae5e0d03fdce.1522736996.git.sean.wang@mediatek.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <6fd85b96-f076-36c7-8ff4-8e8ed252edb2@gmail.com>
Date: Thu, 19 Apr 2018 12:23:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <2f84f7695ea3223b8626a8369aa4ae5e0d03fdce.1522736996.git.sean.wang@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/03/2018 09:15 AM, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Reuse the common helpers regmap_read_poll_timeout provided by Linux core
> instead of an open-coded handling.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Weiyi Lu <weiyi.lu@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-infracfg.c | 45 +++++++++----------------------------
>  1 file changed, 10 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-infracfg.c b/drivers/soc/mediatek/mtk-infracfg.c
> index 8c310de..b849aa5 100644
> --- a/drivers/soc/mediatek/mtk-infracfg.c
> +++ b/drivers/soc/mediatek/mtk-infracfg.c
> @@ -12,6 +12,7 @@
>   */
>  
>  #include <linux/export.h>
> +#include <linux/iopoll.h>
>  #include <linux/jiffies.h>
>  #include <linux/regmap.h>
>  #include <linux/soc/mediatek/infracfg.h>
> @@ -37,7 +38,6 @@
>  int mtk_infracfg_set_bus_protection(struct regmap *infracfg, u32 mask,
>  		bool reg_update)
>  {
> -	unsigned long expired;
>  	u32 val;
>  	int ret;
>  
> @@ -47,22 +47,11 @@ int mtk_infracfg_set_bus_protection(struct regmap *infracfg, u32 mask,
>  	else
>  		regmap_write(infracfg, INFRA_TOPAXI_PROTECTEN_SET, mask);
>  
> -	expired = jiffies + HZ;
> +	ret = regmap_read_poll_timeout(infracfg, INFRA_TOPAXI_PROTECTSTA1,
> +				       val, (val & mask) == mask, 10,
> +				       jiffies_to_usecs(HZ));

To align with the changes in scpsys, please define MTK_POLL_DELAY_US and
MTK_POLL_TIMEOUT. I'm not really fan of passing macros as function arguments.

Other then that, the patch looks good.

Thanks a lot,
Matthias

>  
> -	while (1) {
> -		ret = regmap_read(infracfg, INFRA_TOPAXI_PROTECTSTA1, &val);
> -		if (ret)
> -			return ret;
> -
> -		if ((val & mask) == mask)
> -			break;
> -
> -		cpu_relax();
> -		if (time_after(jiffies, expired))
> -			return -EIO;
> -	}
> -
> -	return 0;
> +	return ret;
>  }
>  
>  /**
> @@ -80,30 +69,16 @@ int mtk_infracfg_set_bus_protection(struct regmap *infracfg, u32 mask,
>  int mtk_infracfg_clear_bus_protection(struct regmap *infracfg, u32 mask,
>  		bool reg_update)
>  {
> -	unsigned long expired;
>  	int ret;
> +	u32 val;
>  
>  	if (reg_update)
>  		regmap_update_bits(infracfg, INFRA_TOPAXI_PROTECTEN, mask, 0);
>  	else
>  		regmap_write(infracfg, INFRA_TOPAXI_PROTECTEN_CLR, mask);
>  
> -	expired = jiffies + HZ;
> -
> -	while (1) {
> -		u32 val;
> -
> -		ret = regmap_read(infracfg, INFRA_TOPAXI_PROTECTSTA1, &val);
> -		if (ret)
> -			return ret;
> -
> -		if (!(val & mask))
> -			break;
> -
> -		cpu_relax();
> -		if (time_after(jiffies, expired))
> -			return -EIO;
> -	}
> -
> -	return 0;
> +	ret = regmap_read_poll_timeout(infracfg, INFRA_TOPAXI_PROTECTSTA1,
> +				       val, !(val & mask), 10,
> +				       jiffies_to_usecs(HZ));
> +	return ret;
>  }
> 
