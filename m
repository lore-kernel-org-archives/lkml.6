Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E34C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C407D20874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="B7ap0PF6";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cBErfWSb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C407D20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757184AbeFSKZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 06:25:10 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43658 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757119AbeFSKZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 06:25:07 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1D10E60AD9; Tue, 19 Jun 2018 10:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529403907;
        bh=mtnzpUP+68lwo5pLsBt4KBaAqxIhxsqaMEGeRBPYEQ4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=B7ap0PF6vdg+fUTzl/Tm/PEdjM4lMRrjZFGJUee7M2PWVi4nPEZdHI6CcsSFJIQHc
         mrD5X5PQDhwNAXsozy/P7iCMfeoanJTz3dk6nb6e+tbXZt+P0gZCKEvZiht1L4JJRf
         46Ra3RF5P6QtjtX2C7DQvWegpdqZiskAWkfDZpKM=
Received: from [10.4.34.47] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A9FAF607EB;
        Tue, 19 Jun 2018 10:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529403906;
        bh=mtnzpUP+68lwo5pLsBt4KBaAqxIhxsqaMEGeRBPYEQ4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cBErfWSb12UJcdj+XAsiyIDTrU8OI+L1lpo+r6DhUCc7JKwYwZhdqSYz3j8Arwmdw
         rQRULda2rzww3FgGqQMftRzHhbuhjuH6H4kjX7Gf+S2ewv34/v4Mvbzu2Ttody4s7/
         A4g/d6mapKDiMXcM9CbBZza93R9Y3f7VBGWwypnI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A9FAF607EB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH 2/2] cpufreq: qcom-fw: Add support for QCOM cpufreq FW
 driver
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, robh@kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, skannan@codeaurora.org
References: <1528109194-16864-1-git-send-email-tdas@codeaurora.org>
 <1528109194-16864-3-git-send-email-tdas@codeaurora.org>
 <20180606060119.yzl24vhqff6btvrk@vireshk-i7>
 <3cd5944b-d2ca-e7d7-f315-c3e5f230701b@codeaurora.org>
 <20180619085407.nmos7tix77vnaqre@vireshk-i7>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <82d0646e-8dd7-43ba-6b5d-b772e57e865d@codeaurora.org>
Date:   Tue, 19 Jun 2018 15:55:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180619085407.nmos7tix77vnaqre@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/19/2018 2:24 PM, Viresh Kumar wrote:
> Sorry for being late..
> 
> On 07-06-18, 12:48, Taniya Das wrote:
>> On 6/6/2018 11:31 AM, Viresh Kumar wrote:
>>> On 04-06-18, 16:16, Taniya Das wrote:
> 
>>>> +static struct cpufreq_driver cpufreq_qcom_fw_driver = {
>>>> +	.flags		= CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK |
>>>> +			  CPUFREQ_HAVE_GOVERNOR_PER_POLICY,
>>>> +	.verify		= cpufreq_generic_frequency_table_verify,
>>>> +	.target_index	= qcom_cpufreq_fw_target_index,
>>>> +	.get		= qcom_cpufreq_fw_get,
>>>> +	.init		= qcom_cpufreq_fw_cpu_init,
>>>
>>> What about CPU hotplug ? We can still do that, right ? So what will happen if
>>> all CPUs of a freq-domain are removed (hence cpufreq policy is removed) and then
>>> someone calls qcom_cpufreq_fw_get() ? You should really work on cpufreq_policy
>>> there to get 'c'.
>>>
>>
>> You want the _get to do something as below.
>> Please correct me if my understanding is wrong.
>> ....
>>
>>   policy = cpufreq_cpu_get_raw(cpu);
>>   if (!policy)
>>      return 0;
>>
>>   c = policy->driver_data;
>>
>>   index = readl_relaxed(c->perf_base);
>>   index = min(index, LUT_MAX_ENTRIES - 1);
>>
>>   return c->table[index].frequency;
>>
>> ....
> 
> Right.
> 
>>>> +static int qcom_read_lut(struct platform_device *pdev,
>>>> +			 struct cpufreq_qcom *c)
>>>> +{
>>>> +	struct device *dev = &pdev->dev;
>>>> +	u32 data, src, lval, i, core_count, prev_cc, prev_freq, cur_freq;
>>>> +
>>>> +	c->table = devm_kcalloc(dev, LUT_MAX_ENTRIES + 1,
>>>> +				sizeof(*c->table), GFP_KERNEL);
>>>> +	if (!c->table)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
>>>> +		data = readl_relaxed(c->lut_base + i * LUT_ROW_SIZE);
>>>> +		src = ((data & GENMASK(31, 30)) >> 30);
>>>> +		lval = (data & GENMASK(7, 0));
>>>> +		core_count = CORE_COUNT_VAL(data);
>>>> +
>>>> +		if (!src)
>>>> +			c->table[i].frequency = INIT_RATE / 1000;
>>>> +		else
>>>> +			c->table[i].frequency = XO_RATE * lval / 1000;
>>>> +
>>>> +		cur_freq = c->table[i].frequency;
>>>> +
>>>> +		dev_dbg(dev, "index=%d freq=%d, core_count %d\n",
>>>> +			i, c->table[i].frequency, core_count);
>>>> +
>>>> +		if (core_count != c->max_cores)
>>>> +			cur_freq = CPUFREQ_ENTRY_INVALID;
>>>> +
>>>> +		/*
>>>> +		 * Two of the same frequencies with the same core counts means
>>>> +		 * end of table.
>>>> +		 */
>>>> +		if (i > 0 && c->table[i - 1].frequency ==
>>>> +		   c->table[i].frequency && prev_cc == core_count) {
>>>> +			struct cpufreq_frequency_table *prev = &c->table[i - 1];
>>>> +
>>>> +			if (prev_freq == CPUFREQ_ENTRY_INVALID)
>>>> +				prev->flags = CPUFREQ_BOOST_FREQ;
>>>> +			break;
>>>> +		}
>>>> +		prev_cc = core_count;
>>>> +		prev_freq = cur_freq;
>>>> +	}
>>>> +
>>>> +	c->table[i].frequency = CPUFREQ_TABLE_END;
>>>> +
>>>> +	return 0;
>>>> +}
>>>
>>> Looks like there are many problems here.
>>> - You are assigning prev_freq with cur_freq (which may be uninitialized local
>>>     variable here).
>>> - In this version, you never write CPUFREQ_ENTRY_INVALID to table[i].frequency,
>>>     which looks wrong as well.
>>>
>>
>> - The code to detect boost, would only enter for i > 0 and the prev_freq
>> would be initialized with the cur_freq.
>> - In the case where the core_count != max_cores, the cur_freq is marked
>> INVALID, and when both prev_freq == cur_freq && prev_cc && cur_cc match,
>> that is the time the prev table flags need to be updated. Marking the
>> table[i].frequency as INVALID is not required as cur_freq is already marked
>> with the same. Please correct me if you think otherwise.
> 
> Yeah but the value of cur_freq isn't written to the table entries now. This
> wasn't the case in the earlier version. Have a look at that one.
> 

Yes, Viresh, earlier code was updating the table frequency as I was 
marking the table frequency INVALID.
	if (core_count != c->max_cores)	
		c->table[i].frequency = CPUFREQ_ENTRY_INVALID;	

And thus I had to update the table frequency.

But now I have used the cur_freq instead and the table frequency is not 
touched.
	if (core_count != c->max_cores)
		cur_freq = CPUFREQ_ENTRY_INVALID;

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
