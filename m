Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753063AbeBXCuf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 21:50:35 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5263 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752525AbeBXCud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 21:50:33 -0500
Subject: Re: [PATCH V2 7/7] cpuidle/drivers/cpuidle-arm: Register the cooling
 device
To: Daniel Lezcano <daniel.lezcano@linaro.org>, <edubezval@gmail.com>
CC: <kevin.wangtao@linaro.org>, <leo.yan@linaro.org>,
        <vincent.guittot@linaro.org>, <amit.kachhap@gmail.com>,
        <linux-kernel@vger.kernel.org>, <javi.merino@kernel.org>,
        <rui.zhang@intel.com>, <daniel.thompson@linaro.org>,
        <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <1519226968-19821-1-git-send-email-daniel.lezcano@linaro.org>
 <1519226968-19821-8-git-send-email-daniel.lezcano@linaro.org>
From: "Wangtao (Kevin, Kirin)" <kevin.wangtao@hisilicon.com>
Message-ID: <3b852c23-8bfd-0699-f219-fa694e8ceb71@hisilicon.com>
Date: Sat, 24 Feb 2018 10:50:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <1519226968-19821-8-git-send-email-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.121.90.40]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/2/21 23:29, Daniel Lezcano wrote:
> Register the ARM generic cpuidle driver as a cooling device.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   drivers/cpuidle/cpuidle-arm.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
> index ddee1b6..c100915 100644
> --- a/drivers/cpuidle/cpuidle-arm.c
> +++ b/drivers/cpuidle/cpuidle-arm.c
> @@ -11,6 +11,7 @@
>   
>   #define pr_fmt(fmt) "CPUidle arm: " fmt
>   
> +#include <linux/cpu_cooling.h>
>   #include <linux/cpuidle.h>
>   #include <linux/cpumask.h>
>   #include <linux/cpu_pm.h>
> @@ -172,6 +173,10 @@ static int __init arm_idle_init(void)
>   			goto out_fail;
>   	}
>   
> +	ret = cpuidle_cooling_register();
> +	if (ret)
> +		pr_warn("Failed to register the cpuidle cooling device\n");
> +
SoC which uses Big-Little architecture doesn't use cpuidle-arm driver, is it
better to put cpuidle_cooling_register to cpuidle_register_driver, and use the
cpumask of cpuidle driver to register cpuidle cooling device intead of get it
from topology?
>   	return 0;
>   
>   out_fail:
> 
