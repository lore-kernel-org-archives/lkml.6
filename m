Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F4EC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 03:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20D592081C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 03:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mmt3tGcV";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QNI0yT/L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20D592081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbeLEDhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 22:37:12 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:60070 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbeLEDhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 22:37:11 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0117660159; Wed,  5 Dec 2018 03:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543981030;
        bh=y/Vqn6N2YfoZY/j8McxAGSD8g8dbRBIyqgSPRbAHItc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mmt3tGcVPi1D9dj3qvI7AYamsgGrmyM508yu4rsUaFiMRGWes+bjqXhbqW18NsNR+
         HWfAjY0yNkC7rKpiRMfFWeYKG9ZYFzSTZfx59StGmeORWvSoec52k2ut94K05PEUr9
         zc60vFPsVShHgILcnRn6vHQ7BQjPS640S50mjqK4=
Received: from [192.168.225.247] (unknown [49.33.238.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A4A0860159;
        Wed,  5 Dec 2018 03:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543981028;
        bh=y/Vqn6N2YfoZY/j8McxAGSD8g8dbRBIyqgSPRbAHItc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QNI0yT/LOhAs2HzfpubQh3ZGl4fZGracpL51RW9K6601tMYUDHwavj2LTDppjDNtF
         syoimra/PNyqnY7OfwBST7mdXc+HG78/rgf/vzASIubELt4fIac3E308JrP68V6y3C
         1RLHyjL2M7jsaNcu2o2f7plab7GGgiwIQP+UHb6s=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A4A0860159
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v11 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW
 driver
To:     Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        skannan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        evgreen@google.com
References: <1543722903-10989-1-git-send-email-tdas@codeaurora.org>
 <1543722903-10989-3-git-send-email-tdas@codeaurora.org>
 <20181204051231.mm5ixli7ckpfzvd4@vireshk-i7>
 <154396249199.88331.1800559141437859959@swboyd.mtv.corp.google.com>
 <154396472692.88331.13742924031474269133@swboyd.mtv.corp.google.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <49139ae4-4373-9e70-02ad-80f7bbc4494c@codeaurora.org>
Date:   Wed, 5 Dec 2018 09:07:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <154396472692.88331.13742924031474269133@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen, Viresh

Thanks for the code and suggestions.

Having a NR_DOMAINS '2' makes the driver not scalable for re-use.
This assumption is only true for the current version of the HW and do 
not intend to update/clean-up this logic again. So want to stick keeping 
current logic of having the *qcom_freq_domain_map[NR_CPUS].

On 12/5/2018 4:35 AM, Stephen Boyd wrote:
> Quoting Stephen Boyd (2018-12-04 14:28:11)
>> Quoting Viresh Kumar (2018-12-03 21:12:31)
>>> Hi Taniya,
>>>
>>> Sorry that I haven't been reviewing it much from last few iterations as I was
>>> letting others get this into a better shape. Thanks for your efforts..
>>>
>>> On 02-12-18, 09:25, Taniya Das wrote:
>>>> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
>>>
>>>> +struct cpufreq_qcom {
>>>> +     struct cpufreq_frequency_table *table;
>>>> +     void __iomem *perf_state_reg;
>>>> +     cpumask_t related_cpus;
>>>> +};
>>>> +
>>>> +static struct cpufreq_qcom *qcom_freq_domain_map[NR_CPUS];
>>>
>>> Now that the code is much more simplified, I am not sure if you need this
>>> per-cpu structure at all. The only place where you are using it is in
>>> qcom_cpufreq_hw_cpu_init() and probe(). Why not merge qcom_cpu_resources_init()
>>> completely into qcom_cpufreq_hw_cpu_init() and get rid of this structure
>>> entirely ?
>>>
>>
>> Good point. Here's an untested patch to handle that. It removes the
>> related functionality and makes an array of pointers to the domains that
>> are created each time qcom_cpu_resources_init() is called.
>>
>> ---8<----
>>
>> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
>> index 8dc6b73c2f22..04e7cfd70316 100644
>> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
>> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
>> @@ -23,14 +23,14 @@
>>   #define REG_LUT_TABLE                  0x110
>>   #define REG_PERF_STATE                 0x920
>>   
>> +#define MAX_FREQ_DOMAINS               2
>> +
>>   struct cpufreq_qcom {
>>          struct cpufreq_frequency_table *table;
>>          void __iomem *perf_state_reg;
>>          cpumask_t related_cpus;
>>   };
>>   
>> -static struct cpufreq_qcom *qcom_freq_domain_map[NR_CPUS];
>> -
>>   static int qcom_cpufreq_hw_target_index(struct cpufreq_policy *policy,
>>                                          unsigned int index)
>>   {
>> @@ -76,9 +76,14 @@ static unsigned int qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
>>   
>>   static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>>   {
>> +       struct cpufreq_qcom **freq_domain_map;
>>          struct cpufreq_qcom *c;
>>   
>> -       c = qcom_freq_domain_map[policy->cpu];
>> +       freq_domain_map = cpufreq_get_driver_data();
>> +       if (!freq_domain_map)
>> +               return -ENODEV;
>> +
>> +       c = freq_domain_map[policy->cpu];
> 
> And this fails now because it indexes based on cpu number. We have to
> parse the frequency domain out of the cpunode again to fix that.
> 
> Here's the updated (still untested) patch and I also just allocated the
> freq domain array up front instead of in each domain init routine to
> simplify some more.
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index 8dc6b73c2f22..bc0d734f7e3c 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -23,14 +23,14 @@
>   #define REG_LUT_TABLE			0x110
>   #define REG_PERF_STATE			0x920
>   
> +#define MAX_FREQ_DOMAINS		2
> +
>   struct cpufreq_qcom {
>   	struct cpufreq_frequency_table *table;
>   	void __iomem *perf_state_reg;
>   	cpumask_t related_cpus;
>   };
>   
> -static struct cpufreq_qcom *qcom_freq_domain_map[NR_CPUS];
> -
>   static int qcom_cpufreq_hw_target_index(struct cpufreq_policy *policy,
>   					unsigned int index)
>   {
> @@ -76,9 +76,26 @@ static unsigned int qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
>   
>   static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>   {
> -	struct cpufreq_qcom *c;
> +	struct cpufreq_qcom *freq_domain_map, *c;
> +	struct device_node *cpu_np;
> +	struct of_phandle_args args;
> +	int ret;
> +
> +	freq_domain_map = cpufreq_get_driver_data();
> +	if (!freq_domain_map)
> +		return -ENODEV;
> +
> +	cpu_np = of_cpu_device_node_get(policy->cpu);
> +	if (!cpu_np)
> +		return -ENODEV;
> +
> +	ret = of_parse_phandle_with_args(cpu_np, "qcom,freq-domain",
> +					 "#freq-domain-cells", 0, &args);
> +	of_node_put(cpu_np);
> +	if (ret)
> +		return ret;
>   
> -	c = qcom_freq_domain_map[policy->cpu];
> +	c = &freq_domain_map[args.args[0]];
>   	if (!c) {
>   		pr_err("No scaling support for CPU%d\n", policy->cpu);
>   		return -ENODEV;
> @@ -171,43 +188,15 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev, struct cpufreq_qcom *c,
>   	return 0;
>   }
>   
> -static void qcom_get_related_cpus(int index, struct cpumask *m)
> -{
> -	struct device_node *cpu_np;
> -	struct of_phandle_args args;
> -	int cpu, ret;
> -
> -	for_each_possible_cpu(cpu) {
> -		cpu_np = of_cpu_device_node_get(cpu);
> -		if (!cpu_np)
> -			continue;
> -
> -		ret = of_parse_phandle_with_args(cpu_np, "qcom,freq-domain",
> -						 "#freq-domain-cells", 0,
> -						  &args);
> -		of_node_put(cpu_np);
> -		if (ret < 0)
> -			continue;
> -
> -		if (index == args.args[0])
> -			cpumask_set_cpu(cpu, m);
> -	}
> -}
> -
>   static int qcom_cpu_resources_init(struct platform_device *pdev,
> -				   unsigned int cpu, int index,
> -				   unsigned long xo_rate,
> -				   unsigned long cpu_hw_rate)
> +				   int index, unsigned long xo_rate,
> +				   unsigned long cpu_hw_rate,
> +				   struct cpufreq_qcom *c)
>   {
> -	struct cpufreq_qcom *c;
>   	struct resource *res;
>   	struct device *dev = &pdev->dev;
>   	void __iomem *base;
> -	int ret, cpu_r;
> -
> -	c = devm_kzalloc(dev, sizeof(*c), GFP_KERNEL);
> -	if (!c)
> -		return -ENOMEM;
> +	int ret;
>   
>   	res = platform_get_resource(pdev, IORESOURCE_MEM, index);
>   	base = devm_ioremap_resource(dev, res);
> @@ -220,12 +209,6 @@ static int qcom_cpu_resources_init(struct platform_device *pdev,
>   		return -ENODEV;
>   	}
>   
> -	qcom_get_related_cpus(index, &c->related_cpus);
> -	if (!cpumask_weight(&c->related_cpus)) {
> -		dev_err(dev, "Domain-%d failed to get related CPUs\n", index);
> -		return -ENOENT;
> -	}
> -
>   	c->perf_state_reg = base + REG_PERF_STATE;
>   
>   	ret = qcom_cpufreq_hw_read_lut(dev, c, base, xo_rate, cpu_hw_rate);
> @@ -234,9 +217,6 @@ static int qcom_cpu_resources_init(struct platform_device *pdev,
>   		return ret;
>   	}
>   
> -	for_each_cpu(cpu_r, &c->related_cpus)
> -		qcom_freq_domain_map[cpu_r] = c;
> -
>   	return 0;
>   }
>   
> @@ -245,9 +225,16 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
>   	struct device_node *cpu_np;
>   	struct of_phandle_args args;
>   	struct clk *clk;
> -	unsigned int cpu;
> +	unsigned int cpu, domain;
>   	unsigned long xo_rate, cpu_hw_rate;
>   	int ret;
> +	struct cpufreq_qcom *freq_domain_map, *freq_domain;
> +
> +	freq_domain_map = devm_kcalloc(&pdev->dev, MAX_FREQ_DOMAINS,
> +				       sizeof(*freq_domain_map), GFP_KERNEL);
> +	cpufreq_qcom_hw_driver.driver_data = freq_domain_map;
> +	if (!freq_domain_map)
> +		return -ENOMEM;
>   
>   	clk = clk_get(&pdev->dev, "xo");
>   	if (IS_ERR(clk))
> @@ -273,16 +260,26 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
>   
>   		ret = of_parse_phandle_with_args(cpu_np, "qcom,freq-domain",
>   						 "#freq-domain-cells", 0,
> -						  &args);
> +						 &args);
>   		of_node_put(cpu_np);
>   		if (ret)
>   			return ret;
>   
> -		if (qcom_freq_domain_map[cpu])
> +		domain = args.args[0];
> +		if (WARN_ON(domain >= MAX_FREQ_DOMAINS))
> +			continue;
> +
> +		freq_domain = &freq_domain_map[domain];
> +		cpumask_set_cpu(cpu, &freq_domain->related_cpus);
> +		/*
> +		 * If we've already populated the frequency table for this domain
> +		 * just mark it related and get out of here
> +		 */
> +		if (cpumask_weight(&freq_domain->related_cpus) > 1)
>   			continue;
>   
> -		ret = qcom_cpu_resources_init(pdev, cpu, args.args[0],
> -					      xo_rate, cpu_hw_rate);
> +		ret = qcom_cpu_resources_init(pdev, domain, xo_rate,
> +					      cpu_hw_rate, freq_domain);
>   		if (ret)
>   			return ret;
>   	}
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
