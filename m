Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714A7ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2360521531
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="d/7UMQ4b";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="d/7UMQ4b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2360521531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389811AbeIUQUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 12:20:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60046 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388909AbeIUQU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 12:20:29 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C013360E5A; Fri, 21 Sep 2018 10:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537525933;
        bh=JpovLsUxK9UKq2Wkw6h4oRZ1TJCDLQGpLyf6nxA7AJA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=d/7UMQ4bYUrU3F9mTEvErqySeV38XGi3AJEu+po86E0SGG+w+gX4HC0PHPevnP/o8
         1J3pOvwkGD/pUS9ce7aaiIDH3C5Lcv+S3CJZDgLluICnf+7wHoHeayrczNAY85KKtP
         D/QAC9a+sE7BTFgcTURMF/7omEOLKRrFlkkoqJyE=
Received: from [10.206.25.139] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vbadigan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4D84D612DA;
        Fri, 21 Sep 2018 10:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537525933;
        bh=JpovLsUxK9UKq2Wkw6h4oRZ1TJCDLQGpLyf6nxA7AJA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=d/7UMQ4bYUrU3F9mTEvErqySeV38XGi3AJEu+po86E0SGG+w+gX4HC0PHPevnP/o8
         1J3pOvwkGD/pUS9ce7aaiIDH3C5Lcv+S3CJZDgLluICnf+7wHoHeayrczNAY85KKtP
         D/QAC9a+sE7BTFgcTURMF/7omEOLKRrFlkkoqJyE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4D84D612DA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vbadigan@codeaurora.org
Subject: Re: [PATCH V2 2/3] dt-bindings: mmc: sdhci-msm: Add entries for
 passing load values
To:     Evan Green <evgreen@chromium.org>
Cc:     adrian.hunter@intel.com, Ulf Hansson <ulf.hansson@linaro.org>,
        robh+dt@kernel.org, linux-mmc@vger.kernel.org,
        asutoshd@codeaurora.org, riteshh@codeaurora.org,
        stummala@codeaurora.org, sayali <sayalil@codeaurora.org>,
        Doug Anderson <dianders@google.com>, vviswana@codeaurora.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1537424558-17989-1-git-send-email-vbadigan@codeaurora.org>
 <1537424558-17989-3-git-send-email-vbadigan@codeaurora.org>
 <CAE=gft6w_iV+vm=u=ZKNvDLVTHcAO+AR0A9Yg9etTHW8bJy05w@mail.gmail.com>
From:   Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Message-ID: <8f26b82c-b966-11d3-4fb6-0137a0a8cd4a@codeaurora.org>
Date:   Fri, 21 Sep 2018 16:02:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAE=gft6w_iV+vm=u=ZKNvDLVTHcAO+AR0A9Yg9etTHW8bJy05w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Evan,


On 9/21/2018 5:45 AM, Evan Green wrote:
> On Wed, Sep 19, 2018 at 11:24 PM Veerabhadrarao Badiganti
> <vbadigan@codeaurora.org> wrote:
>> From: Vijay Viswanath <vviswana@codeaurora.org>
>>
>> The load a particular sdhc controller should request from a regulator
>> is device specific and hence each device should individually vote for
>> the required load.
>>
>> Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
>> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
>> ---
>>   Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>> index 502b3b8..3720385 100644
>> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>> @@ -26,6 +26,11 @@ Required properties:
>>          "cal"   - reference clock for RCLK delay calibration (optional)
>>          "sleep" - sleep clock for RCLK delay calibration (optional)
>>
>> +Optional properties:
>> +- qcom,<supply>-current-level-microamp - specifies load levels for supply during BUS_ON and
>> +                                       BUS_OFF states in power irq. Should be specified in
>> +                                       pairs (lpm, hpm), for BUS_OFF and BUS_ON respectively.
>> +                                       Units uA.
>>   Example:
>>
>>          sdhc_1: sdhci@f9824900 {
>> @@ -37,6 +42,7 @@ Example:
>>
>>                  vmmc-supply = <&pm8941_l20>;
>>                  vqmmc-supply = <&pm8941_s3>;
>> +               qcom,vqmmc-current-level-microamp = <200 22000>;
>>
>>                  pinctrl-names = "default";
>>                  pinctrl-0 = <&sdc1_clk &sdc1_cmd &sdc1_data>;
>> --
>> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
>>
> Aren't the regulator load levels pretty coarse? Would it be safe to
> say that pretty much all sd/mmc devices need the high powered mode, or
> are there really some devices that can get by with LPM all the time?
> -Evan
The load levels here are min and max supported by the regulator. To 
cover all devices
we do set it to max load. We can't make any assumptions on this,  as 
peak current may vary
from device to device.

Thanks,
Veera

