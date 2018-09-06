Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1274C4321E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 22:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CD0D20659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 22:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dAe59m12";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oRXbN0Oj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CD0D20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbeIGDUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 23:20:53 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60710 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727836AbeIGDUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 23:20:52 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 71B45607DC; Thu,  6 Sep 2018 22:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536273790;
        bh=us8//nu9WSUvI8+RL7Bx93Q3wVQzWHfNpegbsqY8XgY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dAe59m12ZC3MgB2RCLKLMIk0vwilG2KskrpXluQW8lNyFzU04tvYF0OoI6DIEfgws
         mYAr+ksFLaK4BmnhhskCxz3NaKNX6YLRCNHB6BWm/rAdBoo8PsCDZVH5amI7o+b3d4
         RQKy//D0reY62R34ZiF48gWP2/1okn8XEq9alhOQ=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id AB4E7601D9;
        Thu,  6 Sep 2018 22:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536273789;
        bh=us8//nu9WSUvI8+RL7Bx93Q3wVQzWHfNpegbsqY8XgY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oRXbN0Oj+fscMUQqty+tnoQfN/pirgUs1fcDG0bghvZz7KR45bIaNamPgnZXXJU2p
         miTLiQh/1NXfJ/G7w/A3l9QN6MDU1WYaaqfOaKyKoYl4PlfbtagsDmLbYZ//mH6PiB
         0ydGNTESpYyEyZMwHfZ2Ye3GwGcm+2BeVGdIs2/U=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 06 Sep 2018 15:43:09 -0700
From:   vnkgutta@codeaurora.org
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Borislav Petkov <bp@alien8.de>, evgreen@chromium.org,
        robh@kernel.org, mchehab@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, tsoni@codeaurora.org,
        ckadabi@codeaurora.org, rishabhb@codeaurora.org,
        swboyd@chromium.org, bjorn.andersson@linaro.org
Subject: Re: [PATCH v4 4/4] dt-bindings: msm: Update documentation of
 qcom,llcc
In-Reply-To: <9ecd23b7-b04d-ac82-4cbc-3a858f264824@codeaurora.org>
References: <1536103345-1919-1-git-send-email-vnkgutta@codeaurora.org>
 <1536103345-1919-5-git-send-email-vnkgutta@codeaurora.org>
 <9ecd23b7-b04d-ac82-4cbc-3a858f264824@codeaurora.org>
Message-ID: <819c72c265051ce791d37d4b80d2c117@codeaurora.org>
X-Sender: vnkgutta@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-06 06:16, Sai Prakash Ranjan wrote:
> On 9/5/2018 4:52 AM, Venkata Narendra Kumar Gutta wrote:
>> Add reg-names and interrupts for LLCC documentation and the usage
>> examples. llcc broadcast base is added in addition to llcc base,
>> which is used for llcc broadcast writes.
>> 
>> Signed-off-by: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> ---
>>   .../devicetree/bindings/arm/msm/qcom,llcc.txt         | 19 
>> +++++++++++++++++--
>>   1 file changed, 17 insertions(+), 2 deletions(-)
>> 
>> diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt 
>> b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
>> index 5e85749..2e007dc 100644
>> --- a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
>> +++ b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
>> @@ -16,11 +16,26 @@ Properties:
>>   - reg:
>>   	Usage: required
>>   	Value Type: <prop-encoded-array>
>> -	Definition: Start address and the the size of the register region.
>> +	Definition: The first element specifies the llcc base start address 
>> and
>> +		    the size of the register region. The second element specifies
>> +		    the llcc broadcast base address and size of the register 
>> region.
>> +
>> +- reg-names:
>> +        Usage: required
>> +        Value Type: <stringlist>
>> +        Definition: Register region names. Must be "llcc_base", 
>> "llcc_bcast_base".
>> +
>> +- interrupts:
>> +	Usage: required
>> +	Definition: The interrupt is associated with the llcc edac device.
>> +			It's used for llcc cache single and double bit error detection
>> +			and reporting.
>>     Example:
>>     	cache-controller@1100000 {
>>   		compatible = "qcom,sdm845-llcc";
>> -		reg = <0x1100000 0x250000>;
>> +		reg = <0x1100000 0x200000>, <0x1300000 0x50000> ;
>> +		reg-names = "llcc_base", "llcc_bcast_base";
>> +		interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
>>   	};
>> 
> 
> Also, llcc_bcast_base should be llcc_broadcast_base as given in Patch
> 1 or you can change to llcc_bcast_base in Patch 1 of series.

My bad, I'll correct that in the next series.
