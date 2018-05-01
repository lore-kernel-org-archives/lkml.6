Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754051AbeEAKCs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 06:02:48 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:42673 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750994AbeEAKCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 06:02:46 -0400
X-Google-Smtp-Source: AB8JxZqRHBj4853rqKG9UhAn9VHWjrh3VWdYwoq8IJBWeGU70Ohi1q5sGMcjPYa5a0eQjf4kzvyHPw==
Date: Tue, 1 May 2018 12:02:42 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/18] thermal: exynos: set trips in ascending order in
 exynos7_tmu_initialize()
Message-ID: <20180501100242.GJ27619@mai>
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20180426115231epcas2p3727de5409903e05811c2b5ed10ee0a51@epcas2p3.samsung.com>
 <1524743493-28113-14-git-send-email-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1524743493-28113-14-git-send-email-b.zolnierkie@samsung.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 01:51:28PM +0200, Bartlomiej Zolnierkiewicz wrote:
> Set trips in ascending order in exynos7_tmu_initialize() (it should
> make no difference in driver operation). This prepares the driver
> code to moving trips setting from ->tmu_initialize method to
> exynos_tmu_initialize().
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/thermal/samsung/exynos_tmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index 12b60e2..571511f 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -618,7 +618,7 @@ static void exynos7_tmu_initialize(struct platform_device *pdev)
>  	sanitize_temp_error(data, trim_info);
>  
>  	/* Write temperature code for rising and falling threshold */
> -	for (i = (of_thermal_get_ntrips(tz) - 1); i >= 0; i--) {
> +	for (i = 0; i < of_thermal_get_ntrips(tz); i++) {

Capped with data->ntrip ?

>  		tz->ops->get_trip_temp(tz, i, &temp);
>  		temp /= MCELSIUS;
>  		exynos7_tmu_set_trip_temp(data, i, temp);
> -- 
> 1.9.1
> 

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
