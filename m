Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751628AbeBXWyB (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 17:54:01 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37256 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751582AbeBXWx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 17:53:59 -0500
X-Google-Smtp-Source: AH8x2267+p0wnL9v9ZEeg2fbHoDVaPAdviR4jFOSBVOdcAkoUX3tfcKxYPLEm5H0Byq3LeOY4wgkrw==
Subject: Re: [PATCH V2 7/7] cpuidle/drivers/cpuidle-arm: Register the cooling
 device
To: "Wangtao (Kevin, Kirin)" <kevin.wangtao@hisilicon.com>,
        edubezval@gmail.com
Cc: kevin.wangtao@linaro.org, leo.yan@linaro.org,
        vincent.guittot@linaro.org, amit.kachhap@gmail.com,
        linux-kernel@vger.kernel.org, javi.merino@kernel.org,
        rui.zhang@intel.com, daniel.thompson@linaro.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <1519226968-19821-1-git-send-email-daniel.lezcano@linaro.org>
 <1519226968-19821-8-git-send-email-daniel.lezcano@linaro.org>
 <3b852c23-8bfd-0699-f219-fa694e8ceb71@hisilicon.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <eab97c33-0c5a-9207-f040-5367fb352491@linaro.org>
Date: Sat, 24 Feb 2018 23:53:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <3b852c23-8bfd-0699-f219-fa694e8ceb71@hisilicon.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/02/2018 03:50, Wangtao (Kevin, Kirin) wrote:
> 
> 
> On 2018/2/21 23:29, Daniel Lezcano wrote:
>> Register the ARM generic cpuidle driver as a cooling device.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>   drivers/cpuidle/cpuidle-arm.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/cpuidle/cpuidle-arm.c
>> b/drivers/cpuidle/cpuidle-arm.c
>> index ddee1b6..c100915 100644
>> --- a/drivers/cpuidle/cpuidle-arm.c
>> +++ b/drivers/cpuidle/cpuidle-arm.c
>> @@ -11,6 +11,7 @@
>>     #define pr_fmt(fmt) "CPUidle arm: " fmt
>>   +#include <linux/cpu_cooling.h>
>>   #include <linux/cpuidle.h>
>>   #include <linux/cpumask.h>
>>   #include <linux/cpu_pm.h>
>> @@ -172,6 +173,10 @@ static int __init arm_idle_init(void)
>>               goto out_fail;
>>       }
>>   +    ret = cpuidle_cooling_register();
>> +    if (ret)
>> +        pr_warn("Failed to register the cpuidle cooling device\n");
>> +
> SoC which uses Big-Little architecture doesn't use cpuidle-arm driver,
> is it
> better to put cpuidle_cooling_register to cpuidle_register_driver, and
> use the
> cpumask of cpuidle driver to register cpuidle cooling device intead of
> get it
> from topology?

The bL is supported by the cpuidle-arm driver, however due to how the
cpumask is built, we can't use this in cpuidle_register_driver for that,
it is a soapy board for now.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
