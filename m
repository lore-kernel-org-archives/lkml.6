Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF263C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BDA120844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="onE7E5rL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BDA120844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kapsi.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbeGYI07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 04:26:59 -0400
Received: from mail.kapsi.fi ([91.232.154.25]:39127 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728461AbeGYI07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 04:26:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dcejK3iovJQ6FjP+DHOVZx9uiQvEOqc7ttxbpO6h7xc=; b=onE7E5rLI4fzT2veU71E9gpGo5
        5ubn4xRFYBo5N+NbnYN4MMLBRaSoB11k1pmytOWYxoyzSz2YXHzdOHrBFf8KMorLc9G8CQp8nKkEY
        +yby+hyee8dUpBPlHyu9zkW4yzlTys9hMSpehdG4F4NnTQ3WZqWq51jYlD286tbxTCVsyRMZCJi7C
        SMXIq7jOZ9QKR0Luz1YO1rPs4smAIkyy/gwH9z37U8qTMC09bfx1roWRbxGrs5/LhMKyLquZ4WRtE
        U9kXFz6mpGb5Eid078jSKYT00UwM8DVKNhqND6ew/zuOXYwKOIXvzIFf3NKkevjQir4aDKldrqbXf
        BhhzepVg==;
Received: from [193.209.96.43] (helo=[10.21.26.144])
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <cyndis@kapsi.fi>)
        id 1fiE2F-0004yA-Q6; Wed, 25 Jul 2018 10:16:35 +0300
Subject: Re: [PATCH 05/10] dt-bindings: Add Tegra SDHCI pad pdpu offset
 bindings
To:     Aapo Vienamo <avienamo@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mikko Perttunen <mperttunen@nvidia.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1532442591-5640-1-git-send-email-avienamo@nvidia.com>
 <1532442865-6391-1-git-send-email-avienamo@nvidia.com>
 <1532442865-6391-4-git-send-email-avienamo@nvidia.com>
From:   Mikko Perttunen <cyndis@kapsi.fi>
Message-ID: <13cc61ad-dbf5-7b11-2e69-a091090ce0eb@kapsi.fi>
Date:   Wed, 25 Jul 2018 10:16:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1532442865-6391-4-git-send-email-avienamo@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 193.209.96.43
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.07.2018 17:34, Aapo Vienamo wrote:
> Add bindings documentation for pad pull up and pull down offset values to be
> programmed before executing automatic pad drive strength calibration.
> 
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> ---
>   .../bindings/mmc/nvidia,tegra20-sdhci.txt          | 32 ++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> index 90c214d..949f616 100644
> --- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> @@ -24,6 +24,7 @@ Required properties:
>   Optional properties:
>   - power-gpios : Specify GPIOs for power control
>   
> +Optional properties for Tegra210 and Tegra186:
>   Example:
>   
>   sdhci@c8000200 {
> @@ -45,6 +46,33 @@ Optional properties for Tegra210 and Tegra186:
>     for controllers supporting multiple voltage levels. The order of names
>     should correspond to the pin configuration states in pinctrl-0 and
>     pinctrl-1.
> +- pad-autocal-pull-up-offset-3v3, pad-autocal-pull-down-offset-3v3 :
> +  Specify drive strength calibration offsets for 3.3 V signaling modes.
> +- pad-autocal-pull-up-offset-1v8, pad-autocal-pull-down-offset-1v8 :
> +  Specify drive strength calibration offsets for 1.8 V signaling modes.
> +- pad-autocal-pull-up-offset-3v3-timeout,
> +  pad-autocal-pull-down-offset-3v3-timeout : Specify drive strength
> +  used as a fallback in case the automatic calibration times out on a
> +  3.3 V signaling mode.
> +- pad-autocal-pull-up-offset-1v8-timeout,
> +  pad-autocal-pull-down-offset-1v8-timeout : Specify drive strength
> +  used as a fallback in case the automatic calibration times out on a
> +  1.8 V signaling mode.
> +- pad-autocal-pull-up-offset-sdr104,
> +  pad-autocal-pull-down-offset-sdr104 : Specify drive strength
> +  calibration offsets for SDR104 mode.
> +- pad-autocal-pull-up-offset-hs400,
> +  pad-autocal-pull-down-offset-hs400 : Specify drive strength
> +  calibration offsets for HS400 mode.

All of these need an "nvidia," prefix.

> +
> +  Notes on the pad calibration pull up and pulldown offset values:
> +    - The property values are drive codes which are programmed into the
> +      PD_OFFSET and PU_OFFSET sections of the
> +      SDHCI_TEGRA_AUTO_CAL_CONFIG register.
> +    - A higher value corresponds to higher drive strength. Please refer
> +      to the reference manual of the SoC for correct values.
> +    - The SDR104 and HS400 timing specific values are used in
> +      corresponding modes if specified.
>   
>   Example:
>   sdhci@700b0000 {
> @@ -58,5 +86,9 @@ sdhci@700b0000 {
>   	pinctrl-names = "sdmmc-3v3", "sdmmc-1v8";
>   	pinctrl-0 = <&sdmmc1_3v3>;
>   	pinctrl-1 = <&sdmmc1_1v8>;
> +	pad-autocal-pull-up-offset-3v3 = <0x00>;
> +	pad-autocal-pull-down-offset-3v3 = <0x7d>;
> +	pad-autocal-pull-up-offset-1v8 = <0x7b>;
> +	pad-autocal-pull-down-offset-1v8 = <0x7b>;
>   	status = "disabled";
>   };
> 
