Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAA1C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 04:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A5B020879
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 04:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GvABM1Dg";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BZtevPbB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A5B020879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbeLNEK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 23:10:29 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49708 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbeLNEK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 23:10:29 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D2D2060740; Fri, 14 Dec 2018 04:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544760627;
        bh=DSCe6cuC+czpMytLwJ/5cNW5IBqi96I8cf4mpWiqFeI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GvABM1Dgucb88iIoSFl1JdfVrHqjpzx5G+ZAn/7/N8TPYVQJ8EO+UiEls4D9WY6Mm
         VhAzOtmRUAc9K4IEAXfpkj1/g0pbAY/lNxDhznixBCeq3uxkQy46hjkC5mCpQW3C1h
         6MucYyFyEc+hL2DVwb/8ZTfgYBCMkUYCDUbm5c5M=
Received: from [10.79.165.223] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 87551601D7;
        Fri, 14 Dec 2018 04:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544760626;
        bh=DSCe6cuC+czpMytLwJ/5cNW5IBqi96I8cf4mpWiqFeI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=BZtevPbBGE12sASSKYbduoosBXxcbiD4OEq9MVTxIfvGpD3KegEM1Zf2gxOh+oIJ3
         F40bBZMjUFDHybDtlXuRBWDc0m15mwP2eQ6rWY4EdFYO3SB6mwRZECyqJ/YSMc95FI
         G6V8t7YbXmRWGoEfsnVKBVubYGvZWpvAAW8LP5HU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 87551601D7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v12 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW
 driver
To:     Stephen Boyd <swboyd@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org,
        robh@kernel.org, skannan@codeaurora.org,
        linux-arm-msm@vger.kernel.org, evgreen@google.com,
        Matthias Kaehlcke <mka@chromium.org>
References: <1544687394-331-1-git-send-email-tdas@codeaurora.org>
 <1544687394-331-3-git-send-email-tdas@codeaurora.org>
 <154469510700.19322.7762676027024031719@swboyd.mtv.corp.google.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <a220e6d4-04e7-c911-06fa-202f46ecf4b0@codeaurora.org>
Date:   Fri, 14 Dec 2018 09:40:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <154469510700.19322.7762676027024031719@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen, Viresh,

On 12/13/2018 3:28 PM, Stephen Boyd wrote:
> Quoting Taniya Das (2018-12-12 23:49:54)
>> The CPUfreq HW present in some QCOM chipsets offloads the steps necessary
>> for changing the frequency of CPUs. The driver implements the cpufreq
>> driver interface for this hardware engine.
>>
>> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
>> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
>> Signed-off-by: Taniya Das <tdas@codeaurora.org>
>> ---
> 
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> 
> But I noticed that we don't release the I/O region anymore so hotplug
> and replug of a whole clk domain fails. I guess devm_ioremap_resource()
> was just too much magic so how about we downgrade to devm_ioremap()
> instead?
> 
> BTW, Viresh, I see a lockdep splat when cpufreq_init returns an error
> upon bringing the policy online the second time. I guess cpufreq_stats
> aren't able to be freed from there because they take locks in different
> order vs. the normal path?
> 
> -----8<-------
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index fce7a1162e87..0e1105151478 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -182,9 +182,12 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>   	index = args.args[0];
>   
>   	res = platform_get_resource(global_pdev, IORESOURCE_MEM, index);
> -	base = devm_ioremap_resource(dev, res);
> -	if (IS_ERR(base))
> -		return PTR_ERR(base);
> +	if (!res)
> +		return -ENODEV;
> +
> +	base = devm_ioremap(dev, res->start, resource_size(res));
> +	if (!base)
> +		return -ENOMEM;
>   

Updated the above in the next series.

>   	/* HW should be in enabled state to proceed */
>   	if (!(readl_relaxed(base + REG_ENABLE) & 0x1)) {
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
