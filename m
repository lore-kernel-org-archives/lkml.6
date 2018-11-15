Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DE3C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 20:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B286620858
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 20:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NwMCfo5+";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="THeY+/Ui"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B286620858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbeKPGYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 01:24:35 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:53108 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbeKPGYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 01:24:34 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5A8F8601D4; Thu, 15 Nov 2018 20:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542312917;
        bh=ESzJEnULYHkiWJQzA1XBhg+sCSA7LC6xnyEzXnkfqWk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NwMCfo5+ASXfU9/bdkZyFVACU1FUhooF8Vbx5kAKzhRGzGJXiCeDz0NZ0uiFb42uK
         57yFI3yNnMLqqjthgGn1GMSmnbvt9lPzjgbLBPvqLgZP5m99+UteOpEpe7hTgfrQv2
         yjQ2qRN7EeWqxhV84jrf//YZslOW2rV5AQ+sa8ls=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 396C360452;
        Thu, 15 Nov 2018 20:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542312916;
        bh=ESzJEnULYHkiWJQzA1XBhg+sCSA7LC6xnyEzXnkfqWk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=THeY+/Ui3s8QMrW/LFFwUFJWtHfv9opy/vtkqKzT1r5Hb2ZBFQpLBPtzr8UAFMcCj
         Ya6ny1eLIIcMi+AJjKaa4RkIVhGSq8qssmcRZJdoVJGhaXL5PNK3p1H5BXSZbvFGJt
         HzeNlJaTdTzQW53gwOIQdDyecvylUD8MELi3qwVU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 396C360452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH 3/4] arm64: dts: qcom: msm8998: Add SDC2 control pins
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1542302291-6864-1-git-send-email-jhugo@codeaurora.org>
 <1542302291-6864-4-git-send-email-jhugo@codeaurora.org>
 <20181115191623.GK10915@tuxbook-pro>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <ad7859ae-bccb-b2a4-a4f3-8d507121aaa6@codeaurora.org>
Date:   Thu, 15 Nov 2018 13:15:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181115191623.GK10915@tuxbook-pro>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/2018 12:16 PM, Bjorn Andersson wrote:
> On Thu 15 Nov 09:18 PST 2018, Jeffrey Hugo wrote:
> 
>> The SDC2 control pins are typically used to manage sleep.
>>
>> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
>> ---
>>   arch/arm64/boot/dts/qcom/msm8998-pins.dtsi | 78 ++++++++++++++++++++++++++++++
> 
> Rather than adding a -pins file, add the pinctrl states the individual
> dts(i) directly.
> 
>>   arch/arm64/boot/dts/qcom/msm8998.dtsi      |  2 +
>>   2 files changed, 80 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/qcom/msm8998-pins.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/qcom/msm8998-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8998-pins.dtsi
>> new file mode 100644
>> index 0000000..a22abf9
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/msm8998-pins.dtsi
>> @@ -0,0 +1,78 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2018, The Linux Foundation. All rights reserved. */
>> +
>> +&tlmm {
>> +	sdc2_clk_on: sdc2_clk_on {
> 
> Use _ in labels, - in node names.
> 
>> +		config {
> 
> You don't have to put the pinctrl state properties in an additional
> subnode anymore, so feel free to remove the extra subnode level.
> 
>> +			pins = "sdc2_clk";
>> +			bias-disable;           /* NO pull */
>> +			drive-strength = <16>;  /* 16 MA */
> 
> Please push electrical properties to the board dts instead of the
> platform one, as they might be board specific.
> 
>> +		};
>> +	};
> 
> Apart from this the patch loogs good.
> 

Thanks for the guidance.  This all makes sense to me.  I'll roll this 
all into v2.

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
