Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA23C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 21:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84607208DC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 21:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PJtphNvL";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MCyf2Q8O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84607208DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbeHWBNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 21:13:11 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45534 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbeHWBNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 21:13:11 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AC4B36019F; Wed, 22 Aug 2018 21:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534974393;
        bh=Lphu5D+vuRyLl18x1g5M5WqAu/WJpuQVE1jHbGhtb30=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PJtphNvLTmwTIhsRqNAv5vtbOeVCSN3NbhTiuYE2LEjLuYczKj6IVKW1e6KsR+QWt
         SZmPnX50D9YgVEIHtJlKq21mGwIBbhQIBfkdskN7gb3x0snR9+nuCRloyBZcdmws1f
         bh0hZZWyY7gpZxmWVWiXonCwBIM4fEhGsNQNRm3Y=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id AAAA66019F;
        Wed, 22 Aug 2018 21:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534974392;
        bh=Lphu5D+vuRyLl18x1g5M5WqAu/WJpuQVE1jHbGhtb30=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MCyf2Q8OH5b8v/d14fNKIzVjGbFZmQ+AtkP/4apEJpuUIuJb2TBrS5cT7yRPS8/3o
         vuLXML6cvYcY2WN8no2rO4+jQSonlQ8vQwjAdFVgEvGr6TMrKwjbFjsSO1Ns5N266Q
         lkyU0dkNYD7Bu9DdoF/VN18oxKilLs5bbG4yWhGo=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 22 Aug 2018 14:46:32 -0700
From:   vnkgutta@codeaurora.org
To:     Rob Herring <robh@kernel.org>
Cc:     mchehab@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        tsoni@codeaurora.org, ckadabi@codeaurora.org,
        rishabhb@codeaurora.org, bp@alien8.de, evgreen@chromium.org
Subject: Re: [PATCH v2 4/4] dt-bindigs: msm: Update documentation of qcom,llcc
In-Reply-To: <20180820195341.GA3358@bogus>
References: <1534550915-18230-1-git-send-email-vnkgutta@codeaurora.org>
 <1534550915-18230-5-git-send-email-vnkgutta@codeaurora.org>
 <20180820195341.GA3358@bogus>
Message-ID: <713d4db0899096456befe8dbe94a4997@codeaurora.org>
X-Sender: vnkgutta@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-20 12:53, Rob Herring wrote:
> On Fri, Aug 17, 2018 at 05:08:35PM -0700, Venkata Narendra Kumar Gutta 
> wrote:
>> Add reg-names and interrupts for LLCC documentation and the usage
>> examples. llcc broadcast base is added in addition to llcc base,
>> which is used for llcc broadcast writes.
> 
> Typo in the subject.
> 
> This binding just landed recently and it's already being updated? Sigh.
> Bindings should be complete from the start. Technically, you can't add
> new required properties.

Sure, I'll correct the typo.

llcc broadcast base was being computed from the number of banks which 
was incorrect,
so we have to add this property.

And the interrupt is needed for EDAC functionality.

> 
>> 
>> Signed-off-by: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
>> ---
>>  Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt | 15 
>> ++++++++++++++-
>>  1 file changed, 14 insertions(+), 1 deletion(-)
>> 
>> diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt 
>> b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
>> index 5e85749..b4b1c86 100644
>> --- a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
>> +++ b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
>> @@ -18,9 +18,22 @@ Properties:
>>  	Value Type: <prop-encoded-array>
>>  	Definition: Start address and the the size of the register region.
>> 
>> +- reg-names:
>> +        Usage: required
>> +        Value Type: <stringlist>
>> +        Definition: Register region names. Must be "llcc_base", 
>> "llcc_bcast_base".
> 
> reg needs to be updated that there are 2 entries.

Ok, I'll update this in the next version.

> 
>> +
>> +- interrupts:
>> +	Usage: required
>> +	Definition: The interrupt is associated with the llcc edac device.
>> +			It's used for llcc cache single and double bit error detection
>> +			and reporting.
>> +
>>  Example:
>> 
>>  	cache-controller@1100000 {
>>  		compatible = "qcom,sdm845-llcc";
>> -		reg = <0x1100000 0x250000>;
>> +		reg = <0x1100000 0x200000>, <0x1300000 0x50000> ;
>> +		reg-names = "llcc_base", "llcc_bcast_base";
>> +		interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
>>  	};
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
>> Forum,
>> a Linux Foundation Collaborative Project
>> 
