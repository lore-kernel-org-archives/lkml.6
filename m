Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82F9C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC792082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ERBZGcIz";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lIVbfXEw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DC792082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbeJ2WT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 18:19:29 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33352 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbeJ2WT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 18:19:28 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3D8B160791; Mon, 29 Oct 2018 13:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540819847;
        bh=Nnifsa0E2ZKgA7lubQLU3tAeUJitRiddrJGWtEjYrU0=;
        h=From:Subject:To:Cc:References:Date:In-Reply-To:From;
        b=ERBZGcIz1rzBEF79aWYo3g8aR1ZUFzrX2k6hP7Qr2nSKzTiLLRwA6pWqKx4Zj2z3d
         ny7ZaRj2SMBSdGo8tLVISAkh3a3DwbbTRYE10NWjd5ROkYE7CpX3ugFajZl9mJHkhC
         mUb5JzFH/c60SqpYEXRCRabPdtRVWsPgSaDoc3jY=
Received: from [10.206.28.53] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: anilc@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 76FAA602BD;
        Mon, 29 Oct 2018 13:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540819846;
        bh=Nnifsa0E2ZKgA7lubQLU3tAeUJitRiddrJGWtEjYrU0=;
        h=From:Subject:To:Cc:References:Date:In-Reply-To:From;
        b=lIVbfXEwHbT2WXmA2FAde1J9EyHtTlLvQH/pM4PV4HbNduz5z7tW9TPU/fbb+zjeU
         WzWZlfX1OmGv/m6z+Ds+O0ATpuCOc8LbszHFv88ViXCuwhsFeT43Hz0BGCQe15tO7r
         cVkR0jOjg7MGoxaGd3yaPTaZqcWzzncSObWfvNQw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 76FAA602BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=anilc@codeaurora.org
From:   AnilKumar Chimata <anilc@codeaurora.org>
Subject: Re: [PATCH 2/3] dt-bindings: Add ICE device specific parameters
To:     Rob Herring <robh@kernel.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        mark.rutland@arm.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1539789476-6098-1-git-send-email-anilc@codeaurora.org>
 <1539789476-6098-3-git-send-email-anilc@codeaurora.org>
 <20181025181558.GC30244@bogus>
Message-ID: <9ddb1052-e481-022e-e9cb-7a09d75f6667@codeaurora.org>
Date:   Mon, 29 Oct 2018 19:00:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181025181558.GC30244@bogus>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks for the comments,

On 2018-10-25 23:45, Rob Herring wrote:
> On Wed, Oct 17, 2018 at 08:47:55PM +0530, AnilKumar Chimata wrote:
>> Add dt parameters information specific to the Inline
>> Crypto Engine (ICE) device.
>> 
>> Signed-off-by: AnilKumar Chimata <anilc@codeaurora.org>
>> ---
>>  .../devicetree/bindings/crypto/msm/ice.txt         | 34 
>> ++++++++++++++++++++++
>>  1 file changed, 34 insertions(+)
>>  create mode 100644 
>> Documentation/devicetree/bindings/crypto/msm/ice.txt
>> 
>> diff --git a/Documentation/devicetree/bindings/crypto/msm/ice.txt 
>> b/Documentation/devicetree/bindings/crypto/msm/ice.txt
>> new file mode 100644
>> index 0000000..86eed5e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/crypto/msm/ice.txt
>> @@ -0,0 +1,34 @@
>> +* Inline Crypto Engine (ICE)
>> +
>> +Required properties:
>> +  - compatible			: should be "qcom,ice"
> 
> Only 1 version ever? Probably not and this needs an SoC specific
> compatible string. Does this follow any standard or ICE is a QCom 
> thing?

Yes, currently one version and in future we might have to add if there 
are any hardware specific changes and this is Qualcomm specific hardware.

> 
>> +  - reg 			: <register mapping>
> 
> No need to define standard properties. You need to say how many 
> register
> ranges.

Changed.

> 
>> +
>> +Optional properties:
>> +  - interrupt-names     	: name describing the interrupts for ICE IRQ
> 
> No point to this if there is only 1 IRQ.

There are two IRQ lines which hardware can support one for non-secure 
operating system and another for secure operating system.

> 
>> +  - interrupts          	: <interrupt mapping for ICE IRQ>
>> +  - qcom,enable-ice-clk 	: should enable clocks for ICE HW
> 
> This shouldn't be needed.

Changed.

> 
>> +  - clocks              	: List of phandle and clock specifier pairs
>> +  - clock-names         	: List of clock input name strings sorted in 
>> the same
>> +				  order as the clocks property.
> 
> How many?  You need to give the

Currently four clocks are needed, details updated accordingly.

>> +  - qcom,op-freq-hz     	: max clock speed sorted in the same order 
>> as the clocks
>> +				  property.
> 
> Use the assigned-clocks properties for this.

Actually that is not a max clock speed, its any array of operating 
frequencies which ICE can support.

> 
>> +  - qcom,instance-type  	: describe the storage type for which ICE 
>> node is defined
>> +				  currently, only "ufs" and "sdcc" are supported storage type
> 
> What if there is more than one instance of ufs or SD? Do you need to
> know which ICE goes with which controller?

That is right, needs to have multiple device node entries which 
differentiate between storage instances.

> 
>> +  - power-domains		: regulator supply to be used by ICE HW
>> +
>> +Example:
>> +	ufs_ice: ufsice@1d90000 {
> 
> crytpo@...
> 
>> +		compatible = "qcom,ice";
>> +		reg = <0x1d90000 0x8000>;
>> +		qcom,enable-ice-clk;
>> +		clock-names = "ufs_core_clk", "bus_clk",
>> +				"iface_clk", "ice_core_clk";
>> +		clocks = <&gcc GCC_UFS_PHY_AXI_CLK>,
>> +			 <&gcc GCC_UFS_MEM_CLKREF_CLK>,
>> +			 <&gcc GCC_UFS_PHY_AHB_CLK>,
>> +			 <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
>> +		qcom,op-freq-hz = <0>, <0>, <0>, <300000000>;
>> +		power-domains = <&gcc UFS_PHY_GDSC>;
>> +		qcom,instance-type = "ufs";
>> +	};
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
>> Forum,
>> a Linux Foundation Collaborative Project
>> 
