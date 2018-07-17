Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C599DECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E7DB208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nBPLt8xo";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZvGTT4Ly"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E7DB208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbeGQDUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 23:20:40 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37232 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729859AbeGQDUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 23:20:40 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C40226014B; Tue, 17 Jul 2018 02:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531795821;
        bh=T+1bzQu8I48/z0LdkY/ID+CeZCQjEPYUQhIuVGUSLFs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=nBPLt8xobixqrH7ESE2oIYqeZklnHUyYdweRth2m8z2hOwdQrcHVBKI1/H+8pgefY
         gTVuvph4PXTufij9aqFALvVFvFBTgwn0nP54MKBJ5WRo6QUVLkSZADzPXNQU01EZ3F
         zcRt1/udYtQlsePQFVqcuPdtunnV1GZ9xptjUoeg=
Received: from [10.4.34.47] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F1CD76014B;
        Tue, 17 Jul 2018 02:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531795820;
        bh=T+1bzQu8I48/z0LdkY/ID+CeZCQjEPYUQhIuVGUSLFs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ZvGTT4Ly8stBcETuCsA6GYyFpBhcKQnSNHwFKEsrXwNjEj5sfYPEQaxGTI3wmPvTe
         Cpop9ptrs/Goxd7aPqfBsHlDAtHNkmFCoDnUh0VvIFkAFWvZFuHAcbicLlVZlGB3TO
         bA3xDaXsM+A0RFSh20rlcaeFfH6J4LSiXnytDotY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F1CD76014B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v5 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW
 driver
To:     Evan Green <evgreen@google.com>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        sboyd@kernel.org, Rajendra Nayak <rnayak@codeaurora.org>,
        anischal@codeaurora.org, devicetree@vger.kernel.org,
        robh@kernel.org, Saravana Kannan <skannan@codeaurora.org>,
        amit.kucheria@linaro.org
References: <1531418745-19742-1-git-send-email-tdas@codeaurora.org>
 <1531418745-19742-3-git-send-email-tdas@codeaurora.org>
 <CAE=gft7pVnhbEtOyR7Q8n_WuL_RsttrxN+sp=_EPyR=D3NPv9g@mail.gmail.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <6a75b366-8290-e820-571c-675c060e573e@codeaurora.org>
Date:   Tue, 17 Jul 2018 08:20:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAE=gft7pVnhbEtOyR7Q8n_WuL_RsttrxN+sp=_EPyR=D3NPv9g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Evan,

Thank you for testing the patch.

On 7/17/2018 4:32 AM, Evan Green wrote:
> Hi Taniya,
> On Thu, Jul 12, 2018 at 11:06 AM Taniya Das <tdas@codeaurora.org> wrote:
>>
>> The CPUfreq HW present in some QCOM chipsets offloads the steps necessary
>> for changing the frequency of CPUs. The driver implements the cpufreq
>> driver interface for this hardware engine.
>>
>> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
>> Signed-off-by: Taniya Das <tdas@codeaurora.org>
>> ---
>>   drivers/cpufreq/Kconfig.arm       |  10 ++
>>   drivers/cpufreq/Makefile          |   1 +
>>   drivers/cpufreq/qcom-cpufreq-hw.c | 344 ++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 355 insertions(+)
>>   create mode 100644 drivers/cpufreq/qcom-cpufreq-hw.c
>>
> ...
>> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
>> new file mode 100644
>> index 0000000..fa25a95
>> --- /dev/null
>> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> ...
>> +static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>> +{
>> +       struct cpufreq_qcom *c;
>> +
>> +       c = qcom_freq_domain_map[policy->cpu];
>> +       if (!c) {
>> +               pr_err("No scaling support for CPU%d\n", policy->cpu);
>> +               return -ENODEV;
>> +       }
>> +
>> +       cpumask_copy(policy->cpus, &c->related_cpus);
>> +
>> +       policy->fast_switch_possible = true;
>> +       policy->freq_table = c->table;
>> +       policy->driver_data = c;
>> +
>> +       return 0;
> I haven't looked at this driver in detail, but I have tested it.
> Instead of the line above, I needed:
> 
> return cpufreq_table_validate_and_show(policy, c->table);
> 
> Without this the framework thinks that the min and max frequencies are
> zero, and then you get a warning about an invalid table. I also
> removed "policy->freq_table = c->table", since validate_and_show does
> this.
> -Evan
> 

The API is no longer supported,

https://patchwork.kernel.org/patch/10320897/

If you are using the 4.14 kernel, you do need to replace

-policy->freq_table = c->table;
+cpufreq_table_validate_and_show(policy, c->table);

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
