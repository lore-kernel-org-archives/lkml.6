Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752773AbeDKIv5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 04:51:57 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:38109 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752509AbeDKIvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 04:51:54 -0400
X-Google-Smtp-Source: AIpwx49djjiHf2HuN4BO2hAEt4lU79akgR0EBJt+P5qy3NCZJqiTw29QgmUWtzKG7Z/j8q1hPZMTPQ==
Date: Wed, 11 Apr 2018 14:21:51 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: edubezval@gmail.com, kevin.wangtao@linaro.org, leo.yan@linaro.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        javi.merino@kernel.org, rui.zhang@intel.com,
        daniel.thompson@linaro.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 7/7] cpuidle/drivers/cpuidle-arm: Register the cooling
 device
Message-ID: <20180411085151.GO7671@vireshk-i7>
References: <1522945005-7165-1-git-send-email-daniel.lezcano@linaro.org>
 <1522945005-7165-8-git-send-email-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522945005-7165-8-git-send-email-daniel.lezcano@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-04-18, 18:16, Daniel Lezcano wrote:
> Register the ARM generic cpuidle driver as a cooling device.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/cpuidle/cpuidle-arm.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
> index ddee1b6..44b4fe3 100644
> --- a/drivers/cpuidle/cpuidle-arm.c
> +++ b/drivers/cpuidle/cpuidle-arm.c
> @@ -11,6 +11,7 @@
>  
>  #define pr_fmt(fmt) "CPUidle arm: " fmt
>  
> +#include <linux/cpu_cooling.h>
>  #include <linux/cpuidle.h>
>  #include <linux/cpumask.h>
>  #include <linux/cpu_pm.h>
> @@ -172,6 +173,8 @@ static int __init arm_idle_init(void)
>  			goto out_fail;
>  	}
>  
> +	cpuidle_cooling_register();
> +
>  	return 0;
>  
>  out_fail:

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
