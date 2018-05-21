Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752654AbeEUNE7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 09:04:59 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49334 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752398AbeEUNE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 09:04:57 -0400
Cc: Sudeep Holla <sudeep.holla@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, rnayak@codeaurora.org,
        amit.kucheria@linaro.org, nicolas.dechesne@linaro.org,
        celster@codeaurora.org, tfinkel@codeaurora.org
Subject: Re: [PATCH] cpufreq: Add Kryo CPU scaling driver
To: ilialin@codeaurora.org, mturquette@baylibre.com, sboyd@kernel.org,
        robh@kernel.org, mark.rutland@arm.com, viresh.kumar@linaro.org,
        nm@ti.com, lgirdwood@gmail.com, broonie@kernel.org,
        andy.gross@linaro.org, david.brown@linaro.org, catalin.marinas@arm.com,
        will.deacon@arm.com, rjw@rjwysocki.net, linux-clk@vger.kernel.org
References: <1526555955-29960-11-git-send-email-ilialin@codeaurora.org>
 <1526729701-8589-1-git-send-email-ilialin@codeaurora.org>
 <153cc316-dcb5-972f-5a2f-c91fe0f6348b@arm.com>
 <000f01d3f103$3ff78ba0$bfe6a2e0$@codeaurora.org>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <2ace10bc-e1c4-2060-94d3-eb71e966ffbe@arm.com>
Date: Mon, 21 May 2018 14:04:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <000f01d3f103$3ff78ba0$bfe6a2e0$@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/05/18 13:57, ilialin@codeaurora.org wrote:
> 
[...]

>>> +#include <linux/cpu.h>
>>> +#include <linux/err.h>
>>> +#include <linux/init.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/module.h>
>>> +#include <linux/nvmem-consumer.h>
>>> +#include <linux/of.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/pm_opp.h>
>>> +#include <linux/slab.h>
>>> +#include <linux/soc/qcom/smem.h>
>>> +
>>> +#define MSM_ID_SMEM	137
>>> +#define SILVER_LEAD	0
>>> +#define GOLD_LEAD	2
>>> +
>>
>> So I gather form other emails, that these are physical cpu number(not even
>> unique identifier like MPIDR). Will this work on parts or platforms that need
>> to boot in GOLD LEAD cpus.
> 
> The driver is for Kryo CPU, which (and AFAIK all multicore MSMs)
> always boots on the CPU0.


That may be true and I am not that bothered about it. But assuming
physical ordering from the logical cpu number is *incorrect* and will
break if kernel decides to change the allocation algorithm. Kernel
provides no guarantee on that, so you need to depend on some physical ID
or may be DT to achieve what your want. But the current code as it
stands is wrong.

-- 
Regards,
Sudeep
