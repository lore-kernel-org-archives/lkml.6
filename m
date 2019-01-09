Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C5BC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83F0D20821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VRMRsMC9";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Y5fcw19a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730013AbfAIJX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:23:59 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:43906 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729284AbfAIJX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:23:58 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C4457608D4; Wed,  9 Jan 2019 09:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547025837;
        bh=tSWxF7CS3Lbi7l5jTrpQkeq33vt83K2SE9B3vWSUXGQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VRMRsMC9WOUdmuPPafhmk9rWjJKgyzWLQ6LogFMQGRTqDEWjpfIWiNuSrSWdB/rT8
         UJifjRCz2Wv2Abq0N8CWYUKhvlLKeRQRNH7azhkx52TacSWff8ekWUWnZq65cd0pmp
         cKmmDD1/lyp50zCd4/f4nwBEU8rbbQUOWymoy/K4=
Received: from [10.79.128.18] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B105960312;
        Wed,  9 Jan 2019 09:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547025834;
        bh=tSWxF7CS3Lbi7l5jTrpQkeq33vt83K2SE9B3vWSUXGQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Y5fcw19afb+FbSwZLT1rtJWA3B4PWxkFj2ZYFkZTP+rq6VRoyDs8UwseC8HQBrrdH
         MK5MXek0RheaIqKk3Ff2A0PwlB5YUYP5j5tYREKcgchpUF3yI7y/ZUYsaBKZQSG0VL
         apig3yRudcnDbXQkW04CaVWAFT6FxLW0Z1CNk2PM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B105960312
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v10 2/9] OPP: Add support for parsing the 'opp-level'
 property
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     andy.gross@linaro.org, robh@kernel.org, sboyd@kernel.org,
        ulf.hansson@linaro.org, collinsd@codeaurora.org, mka@chromium.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, henryc.chen@mediatek.com
References: <20190109090420.8100-1-rnayak@codeaurora.org>
 <20190109090420.8100-3-rnayak@codeaurora.org>
 <20190109091210.jw6gw5qif55p7wes@vireshk-i7>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <47fc34b9-02f0-1216-0a01-cddb45af6df4@codeaurora.org>
Date:   Wed, 9 Jan 2019 14:53:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190109091210.jw6gw5qif55p7wes@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/9/2019 2:42 PM, Viresh Kumar wrote:
> On 09-01-19, 14:34, Rajendra Nayak wrote:
>> Now that the OPP bindings are updated to include an optional
>> 'opp-level' property, add support to parse it from device tree
>> and store it as part of dev_pm_opp structure.
>> Also add and export an helper 'dev_pm_opp_get_level()' that can be
>> used to get the level value read from device tree when present.
>>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> ---
>>   drivers/opp/core.c     | 18 ++++++++++++++++++
>>   drivers/opp/of.c       |  5 ++++-
>>   drivers/opp/opp.h      |  2 ++
>>   include/linux/pm_opp.h |  7 +++++++
>>   4 files changed, 31 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
>> index e5507add8f04..738b1783aa65 100644
>> --- a/drivers/opp/core.c
>> +++ b/drivers/opp/core.c
>> @@ -130,6 +130,24 @@ unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
>>   }
>>   EXPORT_SYMBOL_GPL(dev_pm_opp_get_freq);
>>   
>> +/**
>> + * dev_pm_opp_get_level() - Gets the level corresponding to an available opp
>> + * @opp:	opp for which level value has to be returned for
>> + *
>> + * Return: level read from device tree corresponding to the opp, else
>> + * return 0
> 
> All a full-stop here.

will do

> 
>> + */
>> +unsigned int dev_pm_opp_get_level(struct dev_pm_opp *opp)
>> +{
>> +	if (IS_ERR_OR_NULL(opp) || !opp->available) {
>> +		pr_err("%s: Invalid parameters\n", __func__);
>> +		return 0;
>> +	}
>> +
>> +	return opp->level;
>> +}
>> +EXPORT_SYMBOL_GPL(dev_pm_opp_get_level);
>> +
>>   /**
>>    * dev_pm_opp_is_turbo() - Returns if opp is turbo OPP or not
>>    * @opp: opp for which turbo mode is being verified
>> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
>> index 06f0f632ec47..8274d3ba2c5b 100644
>> --- a/drivers/opp/of.c
>> +++ b/drivers/opp/of.c
>> @@ -568,7 +568,7 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
>>   {
>>   	struct dev_pm_opp *new_opp;
>>   	u64 rate = 0;
>> -	u32 val;
>> +	u32 val, level = 0;
>>   	int ret;
>>   	bool rate_not_available = false;
>>   
>> @@ -594,6 +594,9 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
>>   		new_opp->rate = (unsigned long)rate;
>>   	}
>>   
>> +	if (!of_property_read_u32(np, "opp-level", &level))
>> +		new_opp->level = level;
>> +
> 
> What about
> 
>          of_property_read_u32(np, "opp-level", &new_opp->level);
> 
> ??

sure, will update

> 
>>   	/* Check if the OPP supports hardware's hierarchy of versions or not */
>>   	if (!_opp_is_supported(dev, opp_table, np)) {
>>   		dev_dbg(dev, "OPP not supported by hardware: %llu\n", rate);
>> diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
>> index e24d81497375..5accdd96867d 100644
>> --- a/drivers/opp/opp.h
>> +++ b/drivers/opp/opp.h
>> @@ -60,6 +60,7 @@ extern struct list_head opp_tables;
>>    * @suspend:	true if suspend OPP
>>    * @pstate: Device's power domain's performance state.
>>    * @rate:	Frequency in hertz
>> + * @level:	level value to be comminucated to remote power manager
> 
> Just say "performance level" here. Btw, communicated was also
> misspelled here.

will fix and respin

thanks for the review.
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
