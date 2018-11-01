Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6E1C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 11:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A47CC2081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 11:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="f4t1F2wa";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hGE5gyGt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A47CC2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbeKAU51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 16:57:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51380 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbeKAU50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 16:57:26 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1706C6081A; Thu,  1 Nov 2018 11:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541073288;
        bh=IqrnJffXMiVdYXzY5Q75lP/B0DPw8K9lqvyJS3LZ2dE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=f4t1F2waP+fFuiMQfgI+WVB0VUo0GgTZtUa89fcOigixGJszOkVQVrHK5Br9wXPS6
         qd7r1+sL+9DB+G/4IpHqk7fgY1pOfOqK20b6WE6JxxEbh+OMtKgnONUN3wbRx+eWYQ
         pys066P2vRG73jyS5H1aLiIDiCR4Gi9iVFCz3Rsk=
Received: from [10.206.25.187] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vbadigan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6CA5C60591;
        Thu,  1 Nov 2018 11:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541073287;
        bh=IqrnJffXMiVdYXzY5Q75lP/B0DPw8K9lqvyJS3LZ2dE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hGE5gyGtsFS/wY2l8IrzaFcT9lpErlRKNywWjd6FfO45byQC6TedRoPrg7nNkMKo4
         8Q5W+q5ESUO36nlhrlaczeKGt5KyCOqKqqztClr5Mi54Szig3twm//sXM3IcdALgGJ
         K/wq+KCNVKYx5HdZyATW9GxU9/FBDEKjoszJRKF0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6CA5C60591
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vbadigan@codeaurora.org
Subject: Re: [PATCH V2 1/2] dt-bindings: mmc: sdhci-msm: Add new compatible
 string for sdcdc10 DLL
To:     Rob Herring <robh@kernel.org>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        evgreen@chromium.org, dianders@google.com, asutoshd@codeaurora.org,
        riteshh@codeaurora.org, stummala@codeaurora.org,
        sayalil@codeaurora.org, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1539005138-32560-1-git-send-email-vbadigan@codeaurora.org>
 <1539005138-32560-2-git-send-email-vbadigan@codeaurora.org>
 <20181012204848.GA30953@bogus>
From:   Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Message-ID: <d4dfd853-d926-3e83-ff9d-8f44b66eb521@codeaurora.org>
Date:   Thu, 1 Nov 2018 17:24:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181012204848.GA30953@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/13/2018 2:18 AM, Rob Herring wrote:
> On Mon, Oct 08, 2018 at 06:55:37PM +0530, Veerabhadrarao Badiganti wrote:
>> On the SDHC-MSM controllers which makes use of sdcdc10 variant DLLs,
>> the DLL configuration needs to be restored whenever controller clocks
>> are gated. This new compatible string denotes the sdhc-msm controller
>> variant which uses sdcdc10 DLL.
> What is sdcdc10 DLL?
>
> Seems like a work-around to not having SoC specific compatible strings.

Will update this to SOC specific compatible string.

>> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
>> ---
>>   Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>> index 3720385..49b0a43 100644
>> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>> @@ -6,7 +6,11 @@ and the properties used by the sdhci-msm driver.
>>   Required properties:
>>   - compatible: Should contain:
>>   		"qcom,sdhci-msm-v4" for sdcc versions less than 5.0
>> +		"qcom,sdhci-msm-v4-sdcdc10" for sdcc versions < 5.0 and
>> +		which makes use of sdcdc10 variant DLLs.
>>   		"qcom,sdhci-msm-v5" for sdcc versions >= 5.0
>> +		"qcom,sdhci-msm-v5-sdcdc10" for sdcc versions >= 5.0 and
>> +		which makes use of sdcdc10 variant DLLs.
>>   		For SDCC version 5.0.0, MCI registers are removed from SDCC
>>   		interface and some registers are moved to HC. New compatible
>>   		string is added to support this change - "qcom,sdhci-msm-v5".
>> -- 
>> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
>> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
>>

Thanks
Veera
