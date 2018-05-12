Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751129AbeELOLM (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 10:11:12 -0400
Received: from gloria.sntech.de ([95.129.55.99]:51988 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750827AbeELOLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 10:11:11 -0400
From: Heiko Stuebner <heiko@sntech.de>
To: Elaine Zhang <zhangqing@rock-chips.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org,
        rjw@rjwysocki.net, khilman@kernel.org, ulf.hansson@linaro.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        wxt@rock-chips.com, xxx@rock-chips.com, xf@rock-chips.com,
        huangtao@rock-chips.com, Finley Xiao <finley.xiao@rock-chips.com>
Subject: Re: [PATCH v1 04/13] soc: rockchip: power-domain: Fix wrong value when power up pd
Date: Sat, 12 May 2018 16:11:00 +0200
Message-ID: <2785491.5jVj6F0Ubh@phil>
In-Reply-To: <1526009458-28579-5-git-send-email-zhangqing@rock-chips.com>
References: <1526009458-28579-1-git-send-email-zhangqing@rock-chips.com> <1526009458-28579-5-git-send-email-zhangqing@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Elaine,

Am Freitag, 11. Mai 2018, 05:30:49 CEST schrieb Elaine Zhang:

please provide a patch description. This seems to affect rk3328
alone right now, but seems that rk3328 could only ever turn off
power-domains but never turn them on again, right?

Authorship comment from my previous comment applies here
as well.

And please add a

Fixes: 9bb17ce8edb3 ("soc: rockchip: power-domain: Support domain control in hiword-registers")
Cc: stable@vger.kernel.org

to the patch description.


Thanks
Heiko

> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> ---
>  drivers/soc/rockchip/pm_domains.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
> index ebd7c41898c0..01d4ba26a054 100644
> --- a/drivers/soc/rockchip/pm_domains.c
> +++ b/drivers/soc/rockchip/pm_domains.c
> @@ -264,7 +264,7 @@ static void rockchip_do_pmu_set_power_domain(struct rockchip_pm_domain *pd,
>  		return;
>  	else if (pd->info->pwr_w_mask)
>  		regmap_write(pmu->regmap, pmu->info->pwr_offset,
> -			     on ? pd->info->pwr_mask :
> +			     on ? pd->info->pwr_w_mask :
>  			     (pd->info->pwr_mask | pd->info->pwr_w_mask));
>  	else
>  		regmap_update_bits(pmu->regmap, pmu->info->pwr_offset,
> 
