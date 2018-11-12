Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F83C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D740216FD
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oRFR/sFl";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Y8EQ2Frt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D740216FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731987AbeKLQuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 11:50:46 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:54996 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728224AbeKLQuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 11:50:46 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D3DDE60881; Mon, 12 Nov 2018 06:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542005930;
        bh=pA/LxHBCbNLWXnXuPwP/2gzMlZSuttod8QInMr1L3sU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=oRFR/sFll5C45MCkGqhsMDwfOmrp8t4HLxpa0CXC4JIAmcq4G+1z74TArMehJO00O
         vOjp0KkVKykLtQ+GcVaXsEELS1QrZ7SXCVQGUakcune4Lhd1SZzrYqZeC7EVeOGhw0
         JrVAoF5dFmpyin/h2tnw2vaKS9rbKbaW5/dcYNLc=
Received: from [10.252.220.119] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vbadigan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1461B60795;
        Mon, 12 Nov 2018 06:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542005929;
        bh=pA/LxHBCbNLWXnXuPwP/2gzMlZSuttod8QInMr1L3sU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Y8EQ2FrtGCQzwinkQLQLDlcmp0sdLScD5Iut2+UU8MRL/lG11xssLRR4AJ/2bB1Qn
         J5QF6NUHDD9fcguV1J4wBnBkaNDRm7LhXoGc+1K7Ch5eKs8LJHi+85qtf7G3ROcLXv
         KY9CUw1R0qtq5veemfhovGQ3V4tTDQ5ZFN5uUQQA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1461B60795
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vbadigan@codeaurora.org
Subject: Re: [PATCH V4 1/2] dt-bindings: mmc: sdhci-msm: Add SoC-specific
 compatible strings
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, evgreen@chromium.org, dianders@google.com
Cc:     asutoshd@codeaurora.org, riteshh@codeaurora.org,
        stummala@codeaurora.org, sayalil@codeaurora.org,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." 
        <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1542002209-1510-1-git-send-email-vbadigan@codeaurora.org>
 <1542002209-1510-2-git-send-email-vbadigan@codeaurora.org>
From:   Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Message-ID: <e03554eb-ff64-82f8-6cf8-a2a04f2c3d49@codeaurora.org>
Date:   Mon, 12 Nov 2018 12:28:44 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1542002209-1510-2-git-send-email-vbadigan@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Please ignore this patch set. Right patch-set is V5. 
https://patchwork.kernel.org/project/linux-mmc/list/?series=41661

Sorry for the inconvenience.


Thanks

Veera


On 11/12/2018 11:26 AM, Veerabhadrarao Badiganti wrote:
> Add SoC-specific compatible strings for qcom-sdhci controller.
>
> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> ---
>   Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 21 +++++++++++++++++----
>   1 file changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> index 502b3b8..b72871a 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> @@ -4,12 +4,25 @@ This file documents differences between the core properties in mmc.txt
>   and the properties used by the sdhci-msm driver.
>   
>   Required properties:
> -- compatible: Should contain:
> +- compatible: Should contain a SoC-specific string and a IP version string:
> +	version strings:
>   		"qcom,sdhci-msm-v4" for sdcc versions less than 5.0
> -		"qcom,sdhci-msm-v5" for sdcc versions >= 5.0
> +		"qcom,sdhci-msm-v5" for sdcc version 5.0
>   		For SDCC version 5.0.0, MCI registers are removed from SDCC
>   		interface and some registers are moved to HC. New compatible
>   		string is added to support this change - "qcom,sdhci-msm-v5".
> +	full compatible strings with SoC and version:
> +		"qcom,apq8084-sdhci", "qcom,sdhci-msm-v4"
> +		"qcom,msm8974-sdhci", "qcom,sdhci-msm-v4"
> +		"qcom,msm8916-sdhci", "qcom,sdhci-msm-v4"
> +		"qcom,msm8992-sdhci", "qcom,sdhci-msm-v4"
> +		"qcom,msm8996-sdhci", "qcom,sdhci-msm-v4"
> +		"qcom,sdm845-sdhci", "qcom,sdhci-msm-v5"
> +		"qcom,qcs404-sdhci", "qcom,sdhci-msm-v5"
> +	NOTE that some old device tree files may be floating around that only
> +	have the string "qcom,sdhci-msm-v4" without the SoC compatible string
> +	but doing that should be considered a deprecated practice.
> +
>   - reg: Base address and length of the register in the following order:
>   	- Host controller register map (required)
>   	- SD Core register map (required)
> @@ -29,7 +42,7 @@ Required properties:
>   Example:
>   
>   	sdhc_1: sdhci@f9824900 {
> -		compatible = "qcom,sdhci-msm-v4";
> +		compatible = "qcom,msm8974-sdhci", "qcom,sdhci-msm-v4";
>   		reg = <0xf9824900 0x11c>, <0xf9824000 0x800>;
>   		interrupts = <0 123 0>;
>   		bus-width = <8>;
> @@ -46,7 +59,7 @@ Example:
>   	};
>   
>   	sdhc_2: sdhci@f98a4900 {
> -		compatible = "qcom,sdhci-msm-v4";
> +		compatible = "qcom,msm8974-sdhci", "qcom,sdhci-msm-v4";
>   		reg = <0xf98a4900 0x11c>, <0xf98a4000 0x800>;
>   		interrupts = <0 125 0>;
>   		bus-width = <4>;

