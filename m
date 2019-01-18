Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1D8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 04:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 844202086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 04:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KAAlsxC8";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ngxCCfk1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbfAREyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 23:54:53 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:52416 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbfAREyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 23:54:53 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A661260866; Fri, 18 Jan 2019 04:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547787291;
        bh=h0zMAbmVWt1w7lKXYYOPzJ6G7O5PNxyoNVxjN11o7Cg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KAAlsxC8tyjkDSeJRrNtm4UQYt52ZF55UFoyJdfwqtX59sJjiVxrJIo3q9E0h6WmM
         SxIPJuxelcs05oYFUXdEAIuXWZfamR0uKg6Dsgn8DRXpDLnWSDd9SzJrfNAalWaTP5
         tv5sZVk5eRk082kYf4gvwcOwHuyYoO7X5k4s6OUI=
Received: from [10.79.128.224] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 77E2C602FC;
        Fri, 18 Jan 2019 04:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547787290;
        bh=h0zMAbmVWt1w7lKXYYOPzJ6G7O5PNxyoNVxjN11o7Cg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ngxCCfk1BQ7nkQUDSkMhUGJSuwb/tJnI78J8zITMjNTMXXtguWfZ6u69aYyFYSkgO
         sPgOH4ECMidHyqp08zH3cwE2wcOGsvsPphGw7gRP4bjY4xWol0P4P53AQj58xoVmIF
         SA85Xj1jw41DEPBvkoglDdWUQuoYDG/DlLe3aabI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 77E2C602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v11 4/9] soc: qcom: rpmpd: Add a Power domain driver to
 model corners
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     andy.gross@linaro.org, robh@kernel.org, viresh.kumar@linaro.org,
        sboyd@kernel.org, ulf.hansson@linaro.org, collinsd@codeaurora.org,
        mka@chromium.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        henryc.chen@mediatek.com
References: <20190110040209.6028-1-rnayak@codeaurora.org>
 <20190110040209.6028-5-rnayak@codeaurora.org>
 <20190117174254.GA17273@roeck-us.net>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <ac10a4b9-96fe-0e62-a831-9b3ebe67de23@codeaurora.org>
Date:   Fri, 18 Jan 2019 10:24:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190117174254.GA17273@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[]..

>>
>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>> index fcbf8a2e4080..df5cd9fa0d5e 100644
>> --- a/drivers/soc/qcom/Kconfig
>> +++ b/drivers/soc/qcom/Kconfig
>> @@ -98,6 +98,15 @@ config QCOM_RPMH
>>   	  of hardware components aggregate requests for these resources and
>>   	  help apply the aggregated state on the resource.
>>   
>> +config QCOM_RPMPD
>> +	bool "Qualcomm RPM Power domain driver"
>> +	depends on MFD_QCOM_RPM && QCOM_SMD_RPM
> 
> Since this is bool, but the dependent configurations are tristate,
> configurations such as arm64:allmodconfig result in
> 
> CONFIG_QCOM_RPMPD=y
> CONFIG_MFD_QCOM_RPM=m
> CONFIG_QCOM_SMD_RPM=m
> 
> This in turn results in
> 
>     arm-linux-gnueabi-ld: drivers/soc/qcom/rpmpd.o: in function `rpmpd_send_enable':
>>> rpmpd.c:(.text+0x64): undefined reference to `qcom_rpm_smd_write'
>     arm-linux-gnueabi-ld: drivers/soc/qcom/rpmpd.o: in function `rpmpd_power_on':
>     rpmpd.c:(.text+0x408): undefined reference to `qcom_rpm_smd_write'
>>> arm-linux-gnueabi-ld: rpmpd.c:(.text+0x460): undefined reference to `qcom_rpm_smd_write'
> 
> as reported by 0day.

Thanks for reporting this, the QCOM_RPMPD dependency on MFD_QCOM_RPM was removed
by a patch on top from Bjorn [1]. I have posted a fix now [2] to make QCOM_RPMPD
depend on QCOM_SMD_RPM=y

[1] https://lkml.org/lkml/2019/1/17/5
[2] https://lkml.org/lkml/2019/1/17/1043

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
