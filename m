Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F9FC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDA692184B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jhSiHfzY";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jhSiHfzY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729949AbfBEWKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 17:10:46 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:58106 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbfBEWKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 17:10:46 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 97A42608BA; Tue,  5 Feb 2019 22:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549404644;
        bh=ZUjT/cJ29Ox4E+6X1L4YPc9b6XSssHhMr33Sf49q10I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jhSiHfzY31nChQHHu+KA0ECuPRGQAiLGugHR85I6lNW9cInpH9J4pKuxNlTlI2nbL
         SXbKc8gYv/WdW62pfTMO8ASvY9prEXIxibNTSxhKrUoIga609pJzN5N9Cjv8swGc2o
         9jO88tQP/DLtNfSZWTJ739aP3LSWimAlZQlmr4qY=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 43F79602CB;
        Tue,  5 Feb 2019 22:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549404644;
        bh=ZUjT/cJ29Ox4E+6X1L4YPc9b6XSssHhMr33Sf49q10I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jhSiHfzY31nChQHHu+KA0ECuPRGQAiLGugHR85I6lNW9cInpH9J4pKuxNlTlI2nbL
         SXbKc8gYv/WdW62pfTMO8ASvY9prEXIxibNTSxhKrUoIga609pJzN5N9Cjv8swGc2o
         9jO88tQP/DLtNfSZWTJ739aP3LSWimAlZQlmr4qY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 43F79602CB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v1 4/4] arm64: dts: qcom: msm8998: Add mmcc node
To:     Stephen Boyd <sboyd@kernel.org>, andy.gross@linaro.org,
        bjorn.andersson@linaro.org, david.brown@linaro.org
Cc:     marc.w.gonzalez@free.fr, mturquette@baylibre.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <1548866102-30224-1-git-send-email-jhugo@codeaurora.org>
 <1548866184-30378-1-git-send-email-jhugo@codeaurora.org>
 <154940421042.169292.8494408240796466238@swboyd.mtv.corp.google.com>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <966e58d7-8ebd-3871-029e-5f6eab2cc318@codeaurora.org>
Date:   Tue, 5 Feb 2019 15:10:40 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <154940421042.169292.8494408240796466238@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/2019 3:03 PM, Stephen Boyd wrote:
> Quoting Jeffrey Hugo (2019-01-30 08:36:24)
>> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
>> index 7136ab1..5673a65 100644
>> --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
>> @@ -814,6 +814,21 @@
>>                          status = "disabled";
>>                  };
>>   
>> +               mmcc: clock-controller@c8c0000 {
>> +                       compatible = "qcom,mmcc-msm8998";
>> +                       #clock-cells = <1>;
>> +                       #reset-cells = <1>;
>> +                       #power-domain-cells = <1>;
>> +                       reg = <0x0c8c0000 0x40000>;
>> +
>> +                       clock-names =
>> +                               "xo",
> 
> Weird newline here. Please put "xo" on the same line as clock-names.
> 
>> +                               "gpll0";
>> +                       clocks =
>> +                               <&rpmcc RPM_SMD_XO_CLK_SRC>,
>> +                               <&gcc GPLL0_OUT_MAIN>;
> 
> Ah ok, so only the multimedia clks get the xo clk from rpm for now?
> 

Yes.  With this entire series, its possible to retrofit GCC, but I 
didn't tackle that since we'd need to consider backwards compatibility. 
I hope to do this moving forward though.

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
