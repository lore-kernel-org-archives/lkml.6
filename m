Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754552AbeEAKbd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 06:31:33 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:35928 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751920AbeEAKbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 06:31:31 -0400
X-Google-Smtp-Source: AB8JxZp47oIGo3eT0zCPdQzeP3lpCu+25HMtSIebx7RmckwR+mwXvnDEMSNAeK5329O0FMeHwzu0wQ==
Date: Tue, 1 May 2018 12:31:26 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/18] thermal: exynos: move trips setting to
 exynos_tmu_initialize()
Message-ID: <20180501103126.GK27619@mai>
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20180426115234epcas1p47cf54556fd061e8f90a4df4a2c62f7ce@epcas1p4.samsung.com>
 <1524743493-28113-15-git-send-email-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1524743493-28113-15-git-send-email-b.zolnierkie@samsung.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 01:51:29PM +0200, Bartlomiej Zolnierkiewicz wrote:
> * Add dummy exynos4210_tmu_set_trip_hyst() helper.
> 
> * Add ->tmu_set_trip_temp and ->tmu_set_trip_hyst methods to struct
>   exynos_tmu_data and set them in exynos_map_dt_data().
> 
> * Move trips setting to exynos_tmu_initialize().
> 
> There should be no functional changes caused by this patch.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---

[ ... ]

> +/* failing thresholds are not supported on Exynos4210 */
> +static void exynos4210_tmu_set_trip_hyst(struct exynos_tmu_data *data,
> +					 int trip, u8 temp, u8 hyst)
> +{
> +}
> +

May be you can get rid of this empty function and check against a NULL pointer
in exynos_tmu_initialize ?

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
