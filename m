Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B551EC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 12:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7010420866
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 12:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="m28mhrX9";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dR1hRky/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7010420866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbeKKWbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 17:31:09 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:33378 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbeKKWbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 17:31:09 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B5C4560A33; Sun, 11 Nov 2018 12:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541940159;
        bh=hF/omAr0+4O+t6KrEhSBC45nS/s2dupbv5nPlOR0+0A=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=m28mhrX9XOpS6LIDqkOYa1Crw0+FGDXOzSlr9UyhO5n+vZRuIrUqQjarDAONR7eT3
         E8Le5704bR0Oyvy6hcO4zG2bXUVSP1K5rSma6v5WEtpYpbN49iFPDdmwh3+yTeUubD
         6VafLwUlUi32WeItV7qX98vLVUeVMcVdpCTgnM30=
Received: from [10.79.169.103] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 777F060249;
        Sun, 11 Nov 2018 12:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541940158;
        bh=hF/omAr0+4O+t6KrEhSBC45nS/s2dupbv5nPlOR0+0A=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dR1hRky/UCSbmQJhX7BWdl3/3n71uVs3rtshOG8ggZxLFcrTLxIY4Z9JZwkUYfIRd
         W8XAycjiCTqRnryFMA33tvMkwU59xBvPJt1PHNhB1dW1uyo0dHaw5VnptxgUq3RyTa
         S5nKEBnDed7VMQQoCfd5aonczDQpHPZVjEapPICY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 777F060249
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW
 driver
To:     Stephen Boyd <swboyd@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org,
        robh@kernel.org, skannan@codeaurora.org,
        linux-arm-msm@vger.kernel.org, amit.kucheria@linaro.org,
        evgreen@google.com
References: <1539257761-23023-1-git-send-email-tdas@codeaurora.org>
 <1539257761-23023-3-git-send-email-tdas@codeaurora.org>
 <153981915373.5275.15971019914218464179@swboyd.mtv.corp.google.com>
 <0c51a12e-38d3-2df5-4f5f-6a687727e9bf@codeaurora.org>
 <154130523254.88331.12609105382114756048@swboyd.mtv.corp.google.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <3aa7b871-9cf9-9626-11fe-b9aa6009b477@codeaurora.org>
Date:   Sun, 11 Nov 2018 18:12:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <154130523254.88331.12609105382114756048@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen,

Thanks for your comments.

On 11/4/2018 9:50 AM, Stephen Boyd wrote:
> Quoting Taniya Das (2018-11-02 20:06:00)
>> Hello Stephen,
>>
>> On 10/18/2018 5:02 AM, Stephen Boyd wrote:
>>> Quoting Taniya Das (2018-10-11 04:36:01)
>>>> --- a/drivers/cpufreq/Kconfig.arm
>>>> +++ b/drivers/cpufreq/Kconfig.arm
>>>> @@ -121,6 +121,17 @@ config ARM_QCOM_CPUFREQ_KRYO
>>>>
>>>>             If in doubt, say N.
>>>>
>>>> +config ARM_QCOM_CPUFREQ_HW
>>>> +       bool "QCOM CPUFreq HW driver"
>>>
>>> Is there any reason this can't be a module?
>>>
>>
>> We do not have any use cases where we need to support it as module.
> 
> Ok, so it could easily be tristate then? Why not allow it?
> 

I have checked other vendors CPUfreq drivers and those too support only 
"bool".

>>
>>>> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
>>>> new file mode 100644
>>>> index 0000000..fe1c264
>>>> --- /dev/null
>>>> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
>>>> @@ -0,0 +1,354 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
>>>> + */
> [...]
>>>> +
>>>> +static const u16 cpufreq_qcom_std_offsets[REG_ARRAY_SIZE] = {
>>>
>>> Is this going to change in the future?
>>>
>>
>> Yes, they could change and that was the reason to introduce the offsets.
>> This was discussed earlier too with Sudeep and was to add them.
>>
>>>> +       [REG_ENABLE]            = 0x0,
> 
> This is only used once? Maybe it could be removed.
> 
>>>> +       [REG_LUT_TABLE]         = 0x110,
> 
> And this is only used during probe to figure out the supported
> frequencies. So we definitely don't need to store around the registers
> after probe in an array of iomem pointers. The only one that we need
> after probe is the one below.
> 
>>>> +       [REG_PERF_STATE]        = 0x920,
>>>> +};
>>>> +

As these address offsets could change, so I am of the opinion to leave 
them as it is.

>>>> +static struct cpufreq_qcom *qcom_freq_domain_map[NR_CPUS];
>>>> +
>>>> +static int
>>>> +qcom_cpufreq_hw_target_index(struct cpufreq_policy *policy,
>>>> +                            unsigned int index)
>>>> +{
>>>> +       struct cpufreq_qcom *c = policy->driver_data;
>>>> +
>>>> +       writel_relaxed(index, c->reg_bases[REG_PERF_STATE]);
>>>
>>> Why can't we avoid the indirection here and store the perf_state pointer
>>> in probe? Then we don't have to indirect through a table to perform the
>>> register write.
>>>
>>
>> As the offsets could change and that was the reason to add this.
> 
> With fast switching we can avoid incurring any extra instructions, so
> please make another iomem pointer in the cpufreq_qcom struct just for
> writing the index or if possible, just pass the iomem pointer that
> points to the REG_PERF_STATE as the policy->driver_data variable here.
> Then we have the address in hand without any extra load. If my
> understanding is correct, we don't need to keep around anything besides
> this register address anyway so we should be able to just load it and
> write it immediately.
>

The c->reg_bases[] is just an index to the updated bases addresses. I am 
not clear as to why it would incur an extra instruction.

The below code would already take care of it.

+	for (i = REG_ENABLE; i < REG_ARRAY_SIZE; i++)
+		c->reg_bases[i] = base + offsets[i];
+

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
