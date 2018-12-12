Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE07EC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 05:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED0E20851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 05:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EUf9HoW5";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RZIa5Jyo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ED0E20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbeLLFFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 00:05:02 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:40962 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbeLLFFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 00:05:02 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CCADD602FA; Wed, 12 Dec 2018 05:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544591100;
        bh=f+D84lMZkr0EskdhJk+dlQjKRi+IApAkdy1y4jkecX4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=EUf9HoW5yI6aHP2yQek9tBe1f8DI7GYtFf2vbpkxkSYn9Fx15ckkfQ9FTuv/93COJ
         d+6mOaHFBLqfp9mke1fwS7drKCanoraoXbMNA8PCCABmfRqr5NX/eg5qdc0AlowSQZ
         JzOHbh7FGKsGhOvV33o3qLwFXs0NDUs/9AlK/fo0=
Received: from [10.79.128.154] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E5A2D601B4;
        Wed, 12 Dec 2018 05:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544591099;
        bh=f+D84lMZkr0EskdhJk+dlQjKRi+IApAkdy1y4jkecX4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RZIa5JyoAdhS1fA+Gt7e/CS+dPloo+XlmGIkpclA1V7APTm5hNzjfh24NOYAQw/1b
         r/fWjWRnC1l+ni+Dt0LwrVdcXxXKxZB5wJm/gMFQzv7g/O9kFBUjwCxSOWPHERExv2
         ZG/+dymKiaafmMaQwB1mZd3BL2hKuk5lPZyKCls4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E5A2D601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v6 06/10] soc: qcom: rpmhpd: Add RPMh power domain driver
To:     Stephen Boyd <swboyd@chromium.org>, andy.gross@linaro.org,
        collinsd@codeaurora.org, mka@chromium.org, robh@kernel.org,
        ulf.hansson@linaro.org, viresh.kumar@linaro.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181211094938.25086-1-rnayak@codeaurora.org>
 <20181211094938.25086-7-rnayak@codeaurora.org>
 <154456566209.17204.2943300246902710989@swboyd.mtv.corp.google.com>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <7e7869c1-dc8d-a225-3ba2-11ae80746c50@codeaurora.org>
Date:   Wed, 12 Dec 2018 10:34:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <154456566209.17204.2943300246902710989@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/12/2018 3:31 AM, Stephen Boyd wrote:
> Quoting Rajendra Nayak (2018-12-11 01:49:34)
>> The RPMh power domain driver aggregates the corner votes from various
>> consumers for the ARC resources and communicates it to RPMh.
>>
>> With RPMh we use 2 different numbering space for corners, one used
>> by the clients to express their performance needs, and another used
>> to communicate to RPMh hardware.
>>
>> The clients express their performance requirements using a sparse
>> numbering space which are mapped to meaningful levels like RET, SVS,
>> NOMINAL, TURBO etc which then get mapped to another number space
>> between 0 and 15 which is communicated to RPMh. The sparse number space,
>> also referred to as vlvl is mapped to the continuous number space of 0
>> to 15, also referred to as hlvl, using command DB.
>>
>> Some power domain clients could request a performance state only while
>> the CPU is active, while some others could request for a certain
>> performance state all the time regardless of the state of the CPU.
>> We handle this by internally aggregating the votes from both type of
>> clients and then send the aggregated votes to RPMh.
>>
>> There are also 3 different types of Votes that are comunicated to RPMh
> 
> Why capitalize vote?

will fix,

> 
>> for every resource.
>> 1. ACTIVE_ONLY: This specifies the requirement for the resource when the
>> CPU is active
>> 2. SLEEP: This specifies the requirement for the resource when the CPU
>> is going to sleep
>> 3. WAKE_ONLY: This specifies the requirement for the resource when the
>> CPU is coming out of sleep to active state
> 
> Can you tab these in?

sure, will do

> 
>>
>> We add data for all power domains on sdm845 SoC as part of the patch.
>> The driver can be extended to support other SoCs which support RPMh
>>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> Just minor nitpicks ahead and a warning.
> 
>> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
>> index f1b25fdcf2ad..dd6ca92985ee 100644
>> --- a/drivers/soc/qcom/Makefile
>> +++ b/drivers/soc/qcom/Makefile
>> @@ -22,3 +22,4 @@ obj-$(CONFIG_QCOM_APR) += apr.o
>>   obj-$(CONFIG_QCOM_LLCC) += llcc-slice.o
>>   obj-$(CONFIG_QCOM_SDM845_LLCC) += llcc-sdm845.o
>>   obj-$(CONFIG_QCOM_RPMPD) += rpmpd.o
>> +obj-$(CONFIG_QCOM_RPMHPD) += rpmhpd.o
> 
> Put this before RPMPD? At least it would be semi-sorted then.

okay, will do

> 
>> diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
>> new file mode 100644
>> index 000000000000..f993a86be48c
>> --- /dev/null
>> +++ b/drivers/soc/qcom/rpmhpd.c
>> @@ -0,0 +1,417 @@
> [..]
>> +
>> +static int rpmhpd_update_level_mapping(struct rpmhpd *rpmhpd)
>> +{
>> +       u8 buf[RPMH_ARC_MAX_LEVELS * RPMH_ARC_LEVEL_SIZE];
>> +       int i, j, len, ret;
>> +
>> +       len = cmd_db_read_aux_data_len(rpmhpd->res_name);
>> +       if (len <= 0)
>> +               return len;
>> +       else if (len > RPMH_ARC_MAX_LEVELS * RPMH_ARC_LEVEL_SIZE)
>> +               return -EINVAL;
>> +
>> +       ret = cmd_db_read_aux_data(rpmhpd->res_name, buf, len);
>> +       if (ret < 0)
>> +               return ret;
> 
> I've changed cmd_db_read_aux_data() and that change is winding through
> the arm-soc tree. This will break in the compilation phase in
> linux-next.

will resend these based on Andy's for-next

> 
>> +
>> +       rpmhpd->level_count = len / RPMH_ARC_LEVEL_SIZE;
>> +
>> +       for (i = 0; i < rpmhpd->level_count; i++) {
>> +               rpmhpd->level[i] = 0;
>> +               for (j = 0; j < RPMH_ARC_LEVEL_SIZE; j++)
>> +                       rpmhpd->level[i] |=
>> +                               buf[i * RPMH_ARC_LEVEL_SIZE + j] << (8 * j);
>> +
>> +               /*
>> +                * The AUX data may be zero padded.  These 0 valued entries at
>> +                * the end of the map must be ignored.
>> +                */
>> +               if (i > 0 && rpmhpd->level[i] == 0) {
>> +                       rpmhpd->level_count = i;
>> +                       break;
>> +               }
>> +               pr_debug("%s: ARC hlvl=%2d --> vlvl=%4u\n", rpmhpd->res_name, i,
>> +                        rpmhpd->level[i]);
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int rpmhpd_probe(struct platform_device *pdev)
>> +{
>> +       int i, ret;
>> +       size_t num_pds;
>> +       struct device *dev = &pdev->dev;
>> +       struct genpd_onecell_data *data;
>> +       struct rpmhpd **rpmhpds;
>> +       const struct rpmhpd_desc *desc;
>> +
>> +       desc = of_device_get_match_data(dev);
>> +       if (!desc)
>> +               return -EINVAL;
>> +
>> +       rpmhpds = desc->rpmhpds;
>> +       num_pds = desc->num_pds;
>> +
>> +       data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>> +       if (!data)
>> +               return -ENOMEM;
>> +
>> +       data->domains = devm_kcalloc(dev, num_pds, sizeof(*data->domains),
>> +                                    GFP_KERNEL);
>> +       if (!data->domains)
>> +               return -ENOMEM;
>> +
>> +       data->num_domains = num_pds;
>> +
>> +       ret = cmd_db_ready();
> 
> Does this matter? I thought we forced cmd_db_ready() in the rpmh driver
> probe, and that was the parent of all rpmh devices so we should be fine
> to not need to check it again here?

sure, will remove.

thanks for the review.

> 
>> +       if (ret) {
>> +               if (ret != -EPROBE_DEFER)
>> +                       dev_err(dev, "Command DB unavailable, ret=%d\n", ret);
>> +               return ret;
>> +       }
>> +
