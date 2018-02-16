Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752314AbeBPEka (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 23:40:30 -0500
Received: from lelnx194.ext.ti.com ([198.47.27.80]:58625 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751466AbeBPEk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 23:40:29 -0500
Subject: Re: [PATCH] mfd: tps65218: Reorder tps65218_regulator_id enum
To: Dave Gerlach <d-gerlach@ti.com>, <linux-kernel@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-omap@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@kernel.org>
References: <20180216041705.6340-1-d-gerlach@ti.com>
From: Keerthy <j-keerthy@ti.com>
Message-ID: <31b8b1af-c1b3-0a1d-fc94-f4c334bf2208@ti.com>
Date: Fri, 16 Feb 2018 10:10:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180216041705.6340-1-d-gerlach@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday 16 February 2018 09:47 AM, Dave Gerlach wrote:
> Commit 2dc4940360d4 ("regulator: tps65218: Remove all the compatibles")
> changes the probe function of drivers/regulator/tps65218-regulator.c so
> that it iterates through all available regulators and assumes that the
> regulator IDs are sequential and match the order present in the enum
> tps65218_regulator_id. However, for some reason the much older commit
> c0ea88b890d6 ("regulator: tps65218: add support for LS3 current
> regulator") updated all arrays with LS3 at the end but added it second
> to last for the enum.
> 
> Because of this long standing mismatch in order between the
> tps65218_regulator_id enum and the regulator_desc array in the tps65218
> regulator driver, the new probe function causes the strobe values to be
> associated with the wrong regulator ID. This causes LDO1 to fail to
> suspend in tps65218_pmic_set_suspend_disable due to not having anything
> probes for its strobe value. Fix the order in the enum so the probe
> function works as the update intended.

Reviewed-by: Keerthy <j-keerthy@ti.com>

> 
> Fixes: 2dc4940360d4 ("regulator: tps65218: Remove all the compatibles")
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---
>  include/linux/mfd/tps65218.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mfd/tps65218.h b/include/linux/mfd/tps65218.h
> index f069c518c0ed..c204d9a79436 100644
> --- a/include/linux/mfd/tps65218.h
> +++ b/include/linux/mfd/tps65218.h
> @@ -205,10 +205,10 @@ enum tps65218_regulator_id {
>  	TPS65218_DCDC_4,
>  	TPS65218_DCDC_5,
>  	TPS65218_DCDC_6,
> -	/* LS's */
> -	TPS65218_LS_3,
>  	/* LDOs */
>  	TPS65218_LDO_1,
> +	/* LS's */
> +	TPS65218_LS_3,
>  };
>  
>  #define TPS65218_MAX_REG_ID		TPS65218_LDO_1
> 
