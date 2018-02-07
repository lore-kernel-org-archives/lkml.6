Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753772AbeBGKP5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 05:15:57 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39810 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753376AbeBGKPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 05:15:55 -0500
X-Google-Smtp-Source: AH8x225iGs150SCevND/kmc+R5rNDyQAvepYrXf8M7tMC5PMVT8wvN4wKNSmwW0S1LEqYRdjRBRoVw==
Subject: Re: [PATCH 4/8] thermal/drivers/Kconfig: Convert the CPU cooling
 device to a choice
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: edubezval@gmail.com, kevin.wangtao@linaro.org, leo.yan@linaro.org,
        vincent.guittot@linaro.org, amit.kachhap@gmail.com,
        linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
References: <1516721671-16360-1-git-send-email-daniel.lezcano@linaro.org>
 <1516721671-16360-5-git-send-email-daniel.lezcano@linaro.org>
 <20180207090448.GP28462@vireshk-i7>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <4d66ce4f-c8eb-092a-04b5-a705793a1796@linaro.org>
Date: Wed, 7 Feb 2018 11:15:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180207090448.GP28462@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2018 10:04, Viresh Kumar wrote:
> On 23-01-18, 16:34, Daniel Lezcano wrote:
>> The next changes will add new way to cool down a CPU. In order to
>> sanitize and make the overall cpu cooling code consistent and robust
>> we must prevent the cpu cooling devices to co-exists with the same
>> purpose at the same time in the kernel.
>>
>> Make the CPU cooling device a choice in the Kconfig, so only one CPU
>> cooling strategy can be chosen.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  drivers/thermal/Kconfig | 20 +++++++++++++++++---
>>  1 file changed, 17 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>> index 315ae29..925e73b 100644
>> --- a/drivers/thermal/Kconfig
>> +++ b/drivers/thermal/Kconfig
>> @@ -142,17 +142,31 @@ config THERMAL_GOV_POWER_ALLOCATOR
>>  	  allocating and limiting power to devices.
>>  
>>  config CPU_THERMAL
>> -	bool "generic cpu cooling support"
>> -	depends on CPU_FREQ
>> +	bool "Generic cpu cooling support"
>>  	depends on THERMAL_OF
>>  	help
>> +	  Enable the CPU cooling features. If the system has no active
>> +	  cooling device available, this option allows to use the CPU
>> +	  as a cooling device.
>> +
>> +choice
>> +	prompt "CPU cooling strategies"
>> +	depends on CPU_THERMAL
>> +	default CPU_FREQ_THERMAL
>> +	help
>> +	  Select the CPU cooling strategy.
>> +
>> +config CPU_FREQ_THERMAL
> 
> Perhaps you should start using this macro in code in this patch
> itself.

Do you mean s/CPU_THERMAL/CPU_FREQ_THERMAL/ in include/linux/cpu_cooling.h ?


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
