Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F57C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EB7021A13
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EcZSDvpP";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RyPcEJ9f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EB7021A13
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbeHHSkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:40:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56612 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbeHHSkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:40:52 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9F17860B77; Wed,  8 Aug 2018 16:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533745227;
        bh=/ZdNY38gfDqph1HvYuMZ3OK7zIAsUAWPWtXc3xMSfq0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=EcZSDvpPypYqZrpJoJqXUwS4MLBvKxoqlZoTPNYDV6YPSoFwIbBU3q0pSP4Hqny71
         Ks5ndgMLfahqxudwG87iT8KD740QfP3pG98P0oqM1ijcvJdgohx8HRrPOEQuM59/hR
         IXaGysq2jXPpcLReHoR/hMxXR2658iCt56zeUg2A=
Received: from [192.168.0.105] (unknown [49.207.49.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BCF5D606CF;
        Wed,  8 Aug 2018 16:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533745226;
        bh=/ZdNY38gfDqph1HvYuMZ3OK7zIAsUAWPWtXc3xMSfq0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RyPcEJ9fL1AByBI8ZVkIXwr+tgxF2/8akbwQ3+9g6Y+EPOZvH+jBPqaN5WBzeEFQR
         8TMufvhqjHgnW/Wpmz95zsnSHsUYLlDtgLmlrXRuSizlaMDFDJv3q/gcBc2PUQ/M93
         rhfhuTjhjE6143iAlziGkjVJvM0SqoHACDGL5TlE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BCF5D606CF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH] remoteproc: q6v5: Add support to vote for rpmh power
 domains
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     viresh.kumar@linaro.org, sibis@codeaurora.org,
        ulf.hansson@linaro.org, linux-remoteproc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180629102035.2757-1-rnayak@codeaurora.org>
 <20180806164848.GA21235@tuxbook-pro>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <025ed13c-0b6c-4401-276e-ce2a1cccc67a@codeaurora.org>
Date:   Wed, 8 Aug 2018 21:50:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180806164848.GA21235@tuxbook-pro>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 8/6/2018 10:18 PM, Bjorn Andersson wrote:
> On Fri 29 Jun 03:20 PDT 2018, Rajendra Nayak wrote:
> 
>> With rpmh ARC resources being modelled as power domains with
>> performance state, add support to proxy vote on these for SDM845.
>> Add support to vote on multiple of them, now that genpd supports
>> associating multiple power domains to a device.
>>
> 
> Thanks for writing up this patch Rajendra.
> 
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> ---
>> This patch is dependent on the rpmh powerdomain driver
>> still under review,
>> https://lkml.org/lkml/2018/6/27/7
>>
>>   drivers/remoteproc/qcom_q6v5_pil.c | 77 +++++++++++++++++++++++++++++-
>>   1 file changed, 75 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/remoteproc/qcom_q6v5_pil.c b/drivers/remoteproc/qcom_q6v5_pil.c
>> index 2bf8e7c49f2a..2b5be6d15779 100644
>> --- a/drivers/remoteproc/qcom_q6v5_pil.c
>> +++ b/drivers/remoteproc/qcom_q6v5_pil.c
>> @@ -25,6 +25,8 @@
>>   #include <linux/of_address.h>
>>   #include <linux/of_device.h>
>>   #include <linux/platform_device.h>
>> +#include <linux/pm_domain.h>
>> +#include <linux/pm_runtime.h>
>>   #include <linux/regmap.h>
>>   #include <linux/regulator/consumer.h>
>>   #include <linux/remoteproc.h>
>> @@ -132,6 +134,7 @@ struct rproc_hexagon_res {
>>   	char **proxy_clk_names;
>>   	char **reset_clk_names;
>>   	char **active_clk_names;
>> +	char **pd_names;
>>   	int version;
>>   	bool need_mem_protection;
>>   	bool has_alt_reset;
>> @@ -161,9 +164,11 @@ struct q6v5 {
>>   	struct clk *active_clks[8];
>>   	struct clk *reset_clks[4];
>>   	struct clk *proxy_clks[4];
>> +	struct device *pd_devs[3];
>>   	int active_clk_count;
>>   	int reset_clk_count;
>>   	int proxy_clk_count;
>> +	int pd_count;
>>   
>>   	struct reg_info active_regs[1];
>>   	struct reg_info proxy_regs[3];
>> @@ -324,6 +329,23 @@ static void q6v5_clk_disable(struct device *dev,
>>   		clk_disable_unprepare(clks[i]);
>>   }
>>   
>> +static int q6v5_powerdomain_enable(struct device *dev, struct device **devs,
>> +				   int count)
>> +{
>> +	int i;
>> +
>> +	if (!count)
>> +		return 0;
>> +
>> +	if (count > 1)
>> +		for (i = 0; i < count; i++)
>> +			dev_pm_genpd_set_performance_state(devs[i], INT_MAX);
>> +	else
>> +		dev_pm_genpd_set_performance_state(dev, INT_MAX);
> 
> I would prefer if we could just set the performance state during
> initialization, but I see that we only aggregate the state during
> dev_pm_genpd_set_performance_state().
> 
> As such you need to also reduce the votes in the disable path; or we
> will just max out any shared corners from the first time we boot this
> remoteproc.

Right, I need to drop the votes along with doing a runtime suspend of the
device.

> 
> 
> For this to work I believe _genpd_power_o{n,ff}() would need to
> aggregate the performance state of all enabled consumers, something that
> would make the interface more convenient to use.

This isn't done today. There was some discussion in another thread on *if*
we should do this and what could be the implications [1]

> 
>> +
>> +	return pm_runtime_get_sync(dev);
>> +}
>> +
> [..]
>> @@ -1142,6 +1173,35 @@ static int q6v5_init_clocks(struct device *dev, struct clk **clks,
>>   	return i;
>>   }
>>   
>> +static int q6v5_powerdomain_init(struct device *dev, struct device **devs,
>> +				 char **pd_names)
>> +{
>> +	int i = 0, num_pds;
>> +
>> +	if (!pd_names)
>> +		return 0;
>> +
>> +	while (pd_names[i])
>> +		i++;
>> +
>> +	num_pds = i;
>> +
>> +	if (num_pds > 1) {
>> +		for (i = 0; i < num_pds; i++) {
>> +			devs[i] = genpd_dev_pm_attach_by_id(dev, i);
> 
> This should be done by_name

Right, I posted this out before the by_name api was available :)
I will move to it when I respin.

> 
>> +			if (IS_ERR(devs[i]))
>> +				return PTR_ERR(devs[i]);
>> +			if (!device_link_add(dev, devs[i], DL_FLAG_STATELESS |
>> +					     DL_FLAG_PM_RUNTIME))
>> +				return -EINVAL;
>> +		}
>> +	}
>> +
>> +	pm_runtime_enable(dev);
> 
> Don't you need a call to something like pm_suspend_ignore_children()
> here as well, to prevent a pm_runtime_get_sync() in a child device to
> power on our rails at runtime?

Are there any child nodes of remoteproc which do runtime control of
resources via runtime pm?

Thanks for the review.
regards,
Rajendra

[1] https://lkml.org/lkml/2018/6/15/139
