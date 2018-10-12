Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05AEC67877
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 18:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F1C120645
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 18:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ThcCXgke";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="o1wgeDgA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F1C120645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbeJMBn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 21:43:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40274 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbeJMBn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 21:43:57 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2401F6060A; Fri, 12 Oct 2018 18:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539367814;
        bh=Ey+ZGPDZyApzqlv5ZuaPFV9POqnj6Fs3XioaOsm8rRQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ThcCXgkerfxZ3WFN0A3Fx3QjY40WWlTBdF3EbhaWVHnAs/dElQO/roGKpuDwHUsle
         hWv6bzin0wwp5fIVrm+xKzXyJFKQz2y2F8UCwhz48s72YwcmgZtujNsnDtuKghUV3x
         +AO0O1l0VIjqL5VolCcG1TjvVNmCH3xB+/Wafl9g=
Received: from [192.168.1.3] (unknown [183.83.77.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 041136060A;
        Fri, 12 Oct 2018 18:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539367813;
        bh=Ey+ZGPDZyApzqlv5ZuaPFV9POqnj6Fs3XioaOsm8rRQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=o1wgeDgAZ7oz7xklfnOBMQkAv2XHS0J7WTA1AtSG82uW4W3Usi8aASKKvlc7MuZMG
         0EhC5qtkMJX8olD0lm9xj1fqrzPsJGIQB82XdM3iMCqoUaNcxENVW2weXJ4+fKcuo2
         pbpL8/8R9DMoL4lmSVyY44988zd2Ybtxp+Fv6IQ8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 041136060A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
Subject: Re: [PATCH RFC v1 7/8] drivers: qcom: cpu_pd: Handle cpu hotplug in
 the domain
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net,
        ulf.hansson@linaro.org, khilman@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org,
        dianders@chromium.org, mka@chromium.org, ilina@codeaurora.org
References: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
 <1539206455-29342-8-git-send-email-rplsssn@codeaurora.org>
 <20181012142503.GF3401@e107155-lin>
From:   Raju P L S S S N <rplsssn@codeaurora.org>
Message-ID: <f3452af3-a180-8700-43c7-b20dbaa2549e@codeaurora.org>
Date:   Fri, 12 Oct 2018 23:40:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181012142503.GF3401@e107155-lin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/2018 7:55 PM, Sudeep Holla wrote:
> On Thu, Oct 11, 2018 at 02:50:54AM +0530, Raju P.L.S.S.S.N wrote:
>> Use cpu hotplug callback mechanism to attach/dettach the cpu in
>> the cpu power domain. During cpu hotplug callback registration,
>> the starting callback is invoked on all online cpus. So there is
>> no need to attach from device probe.
>>
>> Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
>> ---
>>   drivers/soc/qcom/cpu_pd.c  | 33 +++++++++++++++++++++++++--------
>>   include/linux/cpuhotplug.h |  1 +
>>   2 files changed, 26 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/soc/qcom/cpu_pd.c b/drivers/soc/qcom/cpu_pd.c
>> index 242eced..bf2d95d 100644
>> --- a/drivers/soc/qcom/cpu_pd.c
>> +++ b/drivers/soc/qcom/cpu_pd.c
>> @@ -3,6 +3,7 @@
>>    * Copyright (c) 2018, The Linux Foundation. All rights reserved.
>>    */
>>   
>> +#include <linux/cpuhotplug.h>
>>   #include <linux/ktime.h>
>>   #include <linux/of_platform.h>
>>   #include <linux/pm_domain.h>
>> @@ -85,12 +86,26 @@ static int cpu_pd_power_off(struct generic_pm_domain *domain)
>>   	return 0;
>>   }
>>   
>> +static int cpu_pd_starting(unsigned int cpu)
>> +{
>> +	if (!suspend && of_genpd_attach_cpu(cpu))
>> +		pr_err("%s: genpd_attach_cpu fail\n", __func__);
> 
> If it's that serious, return proper error code and drop the message which
> could be annoying if you are running some hotplug test loop.

Sure will do that.

Thanks Sudeep.

- Raju

> 
> --
> Regards,
> Sudeep
> 
