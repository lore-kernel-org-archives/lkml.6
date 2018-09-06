Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504A5C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0742B2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BfsyRMkp";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="g2NdLux2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0742B2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729237AbeIFRwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:52:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41546 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbeIFRwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:52:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6A1B9606FA; Thu,  6 Sep 2018 13:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536239805;
        bh=uCIiKvUITpqWalbgfP7GavAPN8rA14ge6jfz7OAH+wI=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=BfsyRMkptSN1tjXscz7Rr7JqCZ0SRfWNUtZbVsTmlLIORclOFQijSObY5shV4r7gG
         HqMfWdRN2J4gX2w+nt4VmY4J10lAUHUETx9Z4BokJuLLq0HXIeuZh+sd9HJPTdcCch
         EqW0rN4K9Bosk9qxZzAeyEs7mdCN5zYvx3DNfAAY=
Received: from [10.79.128.227] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9165960710;
        Thu,  6 Sep 2018 13:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536239804;
        bh=uCIiKvUITpqWalbgfP7GavAPN8rA14ge6jfz7OAH+wI=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=g2NdLux2meUB3FxJOWlm3yao/UCOm11oN9TugK/tZbDiYaCWLbs3N3JL14zNNLLK7
         IFUusrP0rgtY8WciTe5CP+QgT43iAD1RWUT4tDlFefQ8pXMBmP+Pid89GAHIGXjBza
         7wcbjceCysBLC7yxatsmGUaFmPrYvEeHT889BDxU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9165960710
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH v4 4/4] dt-bindings: msm: Update documentation of
 qcom,llcc
To:     Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>,
        Borislav Petkov <bp@alien8.de>, evgreen@chromium.org,
        robh@kernel.org, mchehab@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, tsoni@codeaurora.org,
        ckadabi@codeaurora.org, rishabhb@codeaurora.org,
        swboyd@chromium.org, bjorn.andersson@linaro.org
References: <1536103345-1919-1-git-send-email-vnkgutta@codeaurora.org>
 <1536103345-1919-5-git-send-email-vnkgutta@codeaurora.org>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <9ecd23b7-b04d-ac82-4cbc-3a858f264824@codeaurora.org>
Date:   Thu, 6 Sep 2018 18:46:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1536103345-1919-5-git-send-email-vnkgutta@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/2018 4:52 AM, Venkata Narendra Kumar Gutta wrote:
> Add reg-names and interrupts for LLCC documentation and the usage
> examples. llcc broadcast base is added in addition to llcc base,
> which is used for llcc broadcast writes.
> 
> Signed-off-by: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>   .../devicetree/bindings/arm/msm/qcom,llcc.txt         | 19 +++++++++++++++++--
>   1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
> index 5e85749..2e007dc 100644
> --- a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
> +++ b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
> @@ -16,11 +16,26 @@ Properties:
>   - reg:
>   	Usage: required
>   	Value Type: <prop-encoded-array>
> -	Definition: Start address and the the size of the register region.
> +	Definition: The first element specifies the llcc base start address and
> +		    the size of the register region. The second element specifies
> +		    the llcc broadcast base address and size of the register region.
> +
> +- reg-names:
> +        Usage: required
> +        Value Type: <stringlist>
> +        Definition: Register region names. Must be "llcc_base", "llcc_bcast_base".
> +
> +- interrupts:
> +	Usage: required
> +	Definition: The interrupt is associated with the llcc edac device.
> +			It's used for llcc cache single and double bit error detection
> +			and reporting.
>   
>   Example:
>   
>   	cache-controller@1100000 {
>   		compatible = "qcom,sdm845-llcc";
> -		reg = <0x1100000 0x250000>;
> +		reg = <0x1100000 0x200000>, <0x1300000 0x50000> ;
> +		reg-names = "llcc_base", "llcc_bcast_base";
> +		interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
>   	};
> 

Also, llcc_bcast_base should be llcc_broadcast_base as given in Patch 1 
or you can change to llcc_bcast_base in Patch 1 of series.
