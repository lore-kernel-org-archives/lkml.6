Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B377C37124
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 02:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF1221019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 02:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dhgQktT1";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dhgQktT1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbfAVCat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 21:30:49 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:59636 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbfAVCat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 21:30:49 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D67D060860; Tue, 22 Jan 2019 02:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548124248;
        bh=8vbIr5XY0YAd7DNq1WNeC1soeWhLsB0V644Kxzlptlw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dhgQktT1KfFjb1pRLXCf/mcfl923JKpnv2fs3BtiZToLKLTklMxQ9qfF/5c5yuKTJ
         gihx8UiKc+bR2hhxMddM3QuLQ8naiRtTqclRrEDtzfkAyXw5m1Yq7zcgfHgWYww6G+
         BNVoTGMr+Tg0oVFA1ua+xfZDjw4upo+O4MgqHKPI=
Received: from [10.79.128.187] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A46FB60712;
        Tue, 22 Jan 2019 02:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548124248;
        bh=8vbIr5XY0YAd7DNq1WNeC1soeWhLsB0V644Kxzlptlw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dhgQktT1KfFjb1pRLXCf/mcfl923JKpnv2fs3BtiZToLKLTklMxQ9qfF/5c5yuKTJ
         gihx8UiKc+bR2hhxMddM3QuLQ8naiRtTqclRrEDtzfkAyXw5m1Yq7zcgfHgWYww6G+
         BNVoTGMr+Tg0oVFA1ua+xfZDjw4upo+O4MgqHKPI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A46FB60712
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH] soc: qcom: update config dependencies for QCOM_RPMPD
To:     Stephen Boyd <swboyd@chromium.org>, andy.gross@linaro.org,
        david.brown@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@roeck-us.net
References: <20190118044801.7312-1-rnayak@codeaurora.org>
 <154783318835.169631.6614930101893188915@swboyd.mtv.corp.google.com>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <df735d42-d208-62c7-ddbc-87ea314c36d1@codeaurora.org>
Date:   Tue, 22 Jan 2019 08:00:44 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <154783318835.169631.6614930101893188915@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/18/2019 11:09 PM, Stephen Boyd wrote:
> Quoting Rajendra Nayak (2019-01-17 20:48:01)
>>   drivers/soc/qcom/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>> index a5d5167c3f16..1ee298f6bf17 100644
>> --- a/drivers/soc/qcom/Kconfig
>> +++ b/drivers/soc/qcom/Kconfig
>> @@ -109,7 +109,7 @@ config QCOM_RPMHPD
>>   
>>   config QCOM_RPMPD
>>          bool "Qualcomm RPM Power domain driver"
> 
> Just curious, does it need to be bool for some reason?

Here's the link to the discussion around it on the v3 patchset of this series
https://lkml.org/lkml/2018/6/12/111

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
