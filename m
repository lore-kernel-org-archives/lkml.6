Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49ADC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 20:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73A0520858
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 20:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hFNRf9bW";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hFNRf9bW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73A0520858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388900AbeKPGVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 01:21:03 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:51314 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbeKPGVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 01:21:03 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E6C6760722; Thu, 15 Nov 2018 20:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542312706;
        bh=4RyjE2MocDJw3xposY3DqPAVdUxEFmQcjDSOtYCpY3U=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hFNRf9bWUq2KHEnRXD+hJoZv+x8LN6Eg1cf6kN2XgOJrFXlw1Ndn8qK7fjB81sZYJ
         HiNRAOzn8oGmp1rhzMLlRyDGu+s0NzU8gjOA1kIROD1fmqEhFNoljULZsaSchL5WRu
         B+CVMLeg5KtdcOUoAHy9UMtu0y5CksxWmo46gbJ4=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C670D601D4;
        Thu, 15 Nov 2018 20:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542312706;
        bh=4RyjE2MocDJw3xposY3DqPAVdUxEFmQcjDSOtYCpY3U=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hFNRf9bWUq2KHEnRXD+hJoZv+x8LN6Eg1cf6kN2XgOJrFXlw1Ndn8qK7fjB81sZYJ
         HiNRAOzn8oGmp1rhzMLlRyDGu+s0NzU8gjOA1kIROD1fmqEhFNoljULZsaSchL5WRu
         B+CVMLeg5KtdcOUoAHy9UMtu0y5CksxWmo46gbJ4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C670D601D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH 4/4] arm64: dts: qcom: msm8998-mtp: Add external SD
To:     Andy Gross <andy.gross@linaro.org>
Cc:     david.brown@linaro.org, bjorn.andersson@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1542302291-6864-1-git-send-email-jhugo@codeaurora.org>
 <1542302291-6864-5-git-send-email-jhugo@codeaurora.org>
 <20181115190559.GA17484@hector>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <837878fb-6285-f71f-ad10-5c1a1a781c6e@codeaurora.org>
Date:   Thu, 15 Nov 2018 13:11:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181115190559.GA17484@hector>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/2018 12:05 PM, Andy Gross wrote:
> On Thu, Nov 15, 2018 at 10:18:11AM -0700, Jeffrey Hugo wrote:
>> The externally accessible SD card slot on the MTP is driven by SDCC2.
>> Wire it up for use.
>>
>> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
>> ---
>>   arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi | 13 +++++++++++++
>>   arch/arm64/boot/dts/qcom/msm8998.dtsi     |  1 +
>>   2 files changed, 14 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
>> index b4276da..a90b427 100644
>> --- a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
>> @@ -241,3 +241,16 @@
>>   		};
>>   	};
>>   };
>> +
>> +&sdhc2 {
>> +	status = "okay";
>> +        cd-gpios = <&tlmm 95 GPIO_ACTIVE_LOW>;
>> +
>> +        vmmc-supply = <&vreg_l21a_2p95>;
>> +        vqmmc-supply = <&vreg_l13a_2p95>;
>> +
>> +        pinctrl-names = "default", "sleep";
>> +        pinctrl-0 = <&sdc2_clk_on  &sdc2_cmd_on  &sdc2_data_on  &sdc2_cd_on>;
>> +        pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
> 
> Fix to use tabs instead of spaces.

Doh.  Nice catch.  I see I didn't commit that change in my tree.
I'll send out a V2 with this and any other fixes folks comment on.


-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
