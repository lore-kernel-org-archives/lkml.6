Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754194AbeEAJzq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 05:55:46 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34632 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750994AbeEAJzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 05:55:44 -0400
X-Google-Smtp-Source: AB8JxZr+DcYJbBTQKoE2Uq28AfYCxRC3YR3aj2D++IJZ5tNavDK0oW3TGUR56Vxi6pp+FyN1pnX5jg==
Date: Tue, 1 May 2018 11:55:40 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/18] thermal: exynos: add exynos*_tmu_set_[trip,hyst]()
 helpers
Message-ID: <20180501095540.GH27619@mai>
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20180426115226epcas1p2e902011524b5ef6e0b53c314b72f35e0@epcas1p2.samsung.com>
 <1524743493-28113-12-git-send-email-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1524743493-28113-12-git-send-email-b.zolnierkie@samsung.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 01:51:26PM +0200, Bartlomiej Zolnierkiewicz wrote:
> Add exynos*_tmu_set_[trip,hyst]() helpers and convert
> all ->tmu_initialize implementations accordingly.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/thermal/samsung/exynos_tmu.c | 282 +++++++++++++++++------------------
>  1 file changed, 140 insertions(+), 142 deletions(-)
> 
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index 82484c5..80265d2 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -305,30 +305,6 @@ static void sanitize_temp_error(struct exynos_tmu_data *data, u32 trim_info)
>  			EXYNOS_TMU_TEMP_MASK;
>  }

[ ... ]

> +static void exynos4210_tmu_set_trip_temp(struct exynos_tmu_data *data,
> +					 int trip, u8 temp)
> +{
> +	const struct thermal_trip * const trips =
> +		of_thermal_get_trip_points(data->tzd);
> +	u8 ref, th_code;

I would not do this kind of change (unsigned long => u8) with this patch.
Just code reorg and another patch to tweak the variable types if needed.



-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
