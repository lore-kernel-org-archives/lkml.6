Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966203AbeEYKsl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 06:48:41 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59426 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965255AbeEYKsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 06:48:39 -0400
Cc: Sudeep Holla <sudeep.holla@arm.com>, vireshk@kernel.org, nm@ti.com,
        sboyd@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 1/2] cpufreq: Add Kryo CPU scaling driver
To: Viresh Kumar <viresh.kumar@linaro.org>,
        Ilia Lin <ilialin@codeaurora.org>
References: <1527174220-13244-1-git-send-email-ilialin@codeaurora.org>
 <1527174220-13244-2-git-send-email-ilialin@codeaurora.org>
 <20180525035412.3jjocp7ccmv5u2il@vireshk-i7>
 <DF878CBB-304A-4116-83D5-DF6BCEB7C131@codeaurora.org>
 <20180525040536.njrdqjn376oehw2b@vireshk-i7>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <3aa2ced3-ad14-e02b-6702-c0fd1c48513b@arm.com>
Date: Fri, 25 May 2018 11:48:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180525040536.njrdqjn376oehw2b@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/05/18 05:05, Viresh Kumar wrote:
> On 25-05-18, 07:00, Ilia Lin wrote:
>>
>>
>> On May 25, 2018 6:54:12 AM GMT+03:00, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>> On 24-05-18, 18:03, Ilia Lin wrote:
>>>> +static int __init qcom_cpufreq_kryo_init(void)
>>>> +{
>>>> +	struct device_node *np;
>>>> +	struct device *cpu_dev;
>>>> +	int ret;
>>>> +
>>>> +	cpu_dev = get_cpu_device(0);
>>>> +	if (NULL == cpu_dev)
>>>> +		ret = -ENODEV;
>>>> +
>>>> +	np = dev_pm_opp_of_get_opp_desc_node(cpu_dev);
>>>> +	if (IS_ERR(np))
>>>> +		return PTR_ERR(np);
>>>> +
>>>> +	ret = of_device_is_compatible(np, "operating-points-v2-kryo-cpu");
>>>> +	of_node_put(np);
>>>> +	if (!ret)
>>>> +		return -ENOENT;
>>>> +
>>>
>>> I hate the fact that it is taking so long to get done with this. But
>>> can't you
>>> just check machine compatibility instead of this complicated setup to
>>> check OPP
>>> node ? Like:
>>>
>>>        if (!of_device_is_compatible("qcom,apq8096") &&
>>>            !of_device_is_compatible("qcom,msm8996"))
>>>                return;
>>
>> I have to check the "operating-points-v2-kryo-cpu" anyway, so I moved it from probe to the init.
> 
> Okay, leave it as is then. Don't send anything yet and wait for Sudeep to
> respond.
> 

I have already mentioned that I can't suggest since I don't have much
knowledge on QCOM PM. I see lots of patches flying around these days
with multiple people doing same things in different ways. That's why I
suggested Ilia to check with Taniya or Saravana or SBoyd to see what's
the best thing to do in this context. I don't prefer using OPP
compatible and would go with machine compatibility as you suggested.
But I am fine with OPP, just wanted to make sure it won't clash with
anything else.
-- 
Regards,
Sudeep
