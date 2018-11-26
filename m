Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387A4C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E089620855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="M0CcvtjO";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="D0QIr8Nz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E089620855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbeK0Dxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:53:40 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:33308 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbeK0Dxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 22:53:40 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2115760B13; Mon, 26 Nov 2018 16:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543251538;
        bh=ZH8wN3/Y4aVblhi1bxQS0XI+pHl4m+rKtKEsQAw2H+g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=M0CcvtjOlUFE441i20KkkXBmOP1hOrhV8GPt6ndcMx5+FpTe98kVpSR35vyJ627XU
         YMFDb5HRPwVM/8eWaHFR3icKSLc9lIUlYFpH3Lj7S+/jrfeE8ce/25UZRA2MZP5hvq
         zqzRf1+gNaZcJ8wQpcfjWjxHuslhYKDPTaBDKEN8=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 1302A6079C;
        Mon, 26 Nov 2018 16:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543251537;
        bh=ZH8wN3/Y4aVblhi1bxQS0XI+pHl4m+rKtKEsQAw2H+g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=D0QIr8Nz07MILpxVCflV7byejELUzLmvcwcbXmKgO0ouFIx5Hj/cWZt4mTTAOb6Jg
         OuQCG6ddKMg0K+lNIkquHTjTyaGc/9xYwhrkYD8Nu8ShR5EJ8TkZ/SI38EGllGfhvN
         JR0UG9P5Aq0nznpVRuOYyyzXGfGTqfVctj1M5oFc=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 26 Nov 2018 22:28:57 +0530
From:   Govind Singh <govinds@codeaurora.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     andy.gross@linaro.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: qcs404: Add WCN3990 WLAN module device
 node
In-Reply-To: <20181126144422.GU3175@vkoul-mobl.Dlink>
References: <20181126142133.16966-1-govinds@codeaurora.org>
 <20181126144422.GU3175@vkoul-mobl.Dlink>
Message-ID: <bcda9f6ffc58c8457e8822226b751132@codeaurora.org>
X-Sender: govinds@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

Thanks for the review.

On 2018-11-26 20:14, Vinod Koul wrote:
> Hi Govind,
> 
> On 26-11-18, 19:51, Govind Singh wrote:
>> Add device node for the ath10k SNOC platform driver probe
>> and add resources required for WCN3990 on qcs404 soc.
>> Optional clock and regulator controls are not yet available in
>> upstream, hence add them once available.
>> 
>> Signed-off-by: Govind Singh <govinds@codeaurora.org>
>> ---
>>  arch/arm64/boot/dts/qcom/qcs404.dtsi | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi 
>> b/arch/arm64/boot/dts/qcom/qcs404.dtsi
>> index 9ca4f061ecc5..1a401a32d4a1 100644
>> --- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
>> @@ -958,6 +958,25 @@
>>  				status = "disabled";
>>  			};
>>  		};
>> +
>> +		wifi: wifi@0A000000 {
> 
> Please remove leading 0 from node
> 

Sure, i will change in v2.

>> +			compatible = "qcom,wcn3990-wifi";
>> +			reg = <0x0A000000 0x800000>;
>> +			reg-names = "membase";
>> +			memory-region = <&wlan_msa_mem>;
>> +			interrupts = <GIC_SPI 277 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
>> +		};
>>  	};
>> 
>>  	timer {
> 
> This file is sorted alphabetically and reg values. So this should be
> between blsp1_uart2 and intc node, can you please change that
> 
> Also please compile this with W=12
> 

Sure, i will change in v2.

> Lastly, I am not sure, but should the wifi node be always enabled?
> Should it not be enabled in the board dts file? Bjorn..?
> 

yes, i some how missed this.
I will mark the status disabled by default and enable from qcs404 evb 
dts.

> Thanks
