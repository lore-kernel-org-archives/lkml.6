Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4106C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B808420672
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mLWw7zfp";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mLWw7zfp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B808420672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbeLEHDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 02:03:20 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:50530 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbeLEHDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 02:03:20 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 742DD60807; Wed,  5 Dec 2018 07:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543993399;
        bh=EUx0oNDaDQThY35jjZcjZ3Wdh0Mpi2SsP/MQfLe1gGQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mLWw7zfpgyrKu+LFZpyxXik+sKurxvxCOfSBPDomBbT+Y8uSdq2ks3RpeC6C+A7Q5
         HEqqLvXZSLsRjgdCtOXVh4HPw8M7P9vvu/dXC+HPxfmkMjvT6Ojb4bJe0Rlcp6lpmv
         5gBKCYPrk4DlMH/Jgbii4QqUcEafv5UkukJeV2tQ=
Received: from [10.79.128.218] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3FF156014B;
        Wed,  5 Dec 2018 07:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543993399;
        bh=EUx0oNDaDQThY35jjZcjZ3Wdh0Mpi2SsP/MQfLe1gGQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mLWw7zfpgyrKu+LFZpyxXik+sKurxvxCOfSBPDomBbT+Y8uSdq2ks3RpeC6C+A7Q5
         HEqqLvXZSLsRjgdCtOXVh4HPw8M7P9vvu/dXC+HPxfmkMjvT6Ojb4bJe0Rlcp6lpmv
         5gBKCYPrk4DlMH/Jgbii4QqUcEafv5UkukJeV2tQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3FF156014B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v5 4/8] soc: qcom: rpmpd: Add support for get/set
 performance state
To:     Stephen Boyd <sboyd@kernel.org>, andy.gross@linaro.org,
        collinsd@codeaurora.org, mka@chromium.org, robh@kernel.org,
        ulf.hansson@linaro.org, viresh.kumar@linaro.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181204052119.806-1-rnayak@codeaurora.org>
 <20181204052119.806-5-rnayak@codeaurora.org>
 <154396526967.88331.13652897075952274639@swboyd.mtv.corp.google.com>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <d9317471-fb81-482a-22c1-4a7b466a1df4@codeaurora.org>
Date:   Wed, 5 Dec 2018 12:33:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <154396526967.88331.13652897075952274639@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/5/2018 4:44 AM, Stephen Boyd wrote:
> Quoting Rajendra Nayak (2018-12-03 21:21:15)
>> @@ -221,6 +224,47 @@ static int rpmpd_power_off(struct generic_pm_domain *domain)
>>          return ret;
>>   }
>>   
>> +static int rpmpd_set_performance(struct generic_pm_domain *domain,
>> +                                unsigned int state)
>> +{
>> +       int ret = 0;
>> +       struct rpmpd *pd = domain_to_rpmpd(domain);
>> +
>> +       mutex_lock(&rpmpd_lock);
>> +
>> +       if (state > MAX_RPMPD_STATE)
>> +               goto out;
> 
> Does this need to be under the mutex lock? Doesn't look like it.

Nope, will move it out.

> 
>> +
>> +       pd->corner = state;
>> +
>> +       if (!pd->enabled && (pd->key != KEY_FLOOR_CORNER))
> 
> Please drop useless parenthesis.

sure

> 
>> +               goto out;
>> +
>> +       ret = rpmpd_aggregate_corner(pd);
>> +
>> +out:
>> +       mutex_unlock(&rpmpd_lock);
>> +
>> +       return ret;
>> +}
>> +
>> +static unsigned int rpmpd_get_performance(struct generic_pm_domain *genpd,
>> +                                         struct dev_pm_opp *opp)
>> +{
>> +       struct device_node *np;
>> +       unsigned int corner = 0;
>> +
>> +       np = dev_pm_opp_get_of_node(opp);
>> +       if (of_property_read_u32(np, "qcom,level", &corner)) {
>> +               pr_err("%s: missing 'qcom,level' property\n", __func__);
> 
> We leak np reference here, assuming dev_pm_opp_get_of_node() returns an
> of_node_get() pointer to the caller.

good catch, will fix.

> 
>> +               return 0;
>> +       }
>> +
>> +       of_node_put(np);
> 
> This same code exists twice. Perhaps a helper needs to exist for
> qcom_rpm_get_performance() to pull the number out of the DT.

Sure I can make both drivers use a common helper instead of duplicating it.

> 
>> +
>> +       return corner;
>> +}
