Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8B9C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 06:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE69E20671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 06:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="jqK3O1oc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE69E20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kapsi.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbeGYH52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 03:57:28 -0400
Received: from mail.kapsi.fi ([91.232.154.25]:39759 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728222AbeGYH52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 03:57:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pFHupmcL1IEgxrPaggHscF+6G0vRyuBXD8cxoQ+KLW0=; b=jqK3O1oc7wewsnXKclOeWboThe
        UcXWnNSyuCK3m+c4iEoqycyZS6hqXMt7vvIYWTfxXvC5Hxq0omq/VhZ0IHPb/IvV37LSa2q7e4/74
        xLO43lpFKiMnCMnTusPReGpCwAD4uAWY32KI1Y4z/Q3CnWoJPE4ygteKhNEkfY3EkTIZmA99ACehW
        vlPAkwOd4vP77wsiuMr9Uo/B8s0j4oEc2SnYM2cOHFUr8DxJCHck3yxcUc+YfvYzRbOEdcISrxTvj
        kWGrUjIK2/0PJ6WXFDvagwzRRMU49EpxVOXbcpVqU9L1ygYWR+9TENBzpuvXgEZonQ+6zeA1YKkAv
        fLPxySdQ==;
Received: from [193.209.96.43] (helo=[10.21.26.144])
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <cyndis@kapsi.fi>)
        id 1fiDZo-0002V6-Jg; Wed, 25 Jul 2018 09:47:12 +0300
Subject: Re: [PATCH 1/7] dt-bindings: Document Tegra SDHCI pinctrl bindings
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
References: <1532090746-15863-1-git-send-email-avienamo@nvidia.com>
 <1532090746-15863-2-git-send-email-avienamo@nvidia.com>
From:   Mikko Perttunen <cyndis@kapsi.fi>
Message-ID: <13b93496-0f35-2fe4-c713-352a139433d6@kapsi.fi>
Date:   Wed, 25 Jul 2018 09:47:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1532090746-15863-2-git-send-email-avienamo@nvidia.com>
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

I would maybe say "dt-bindings: mmc: tegra: Add pad voltage control 
properties" or similar for the subject - the current kind of looks like 
the SDHCI controller is a pinctrl device :)

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>

On 20.07.2018 15:45, Aapo Vienamo wrote:
> Document the pinctrl bindings used by the SDHCI driver to reconfigure
> pad voltages on controllers supporting multiple voltage levels.
> 
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> ---
>   .../bindings/mmc/nvidia,tegra20-sdhci.txt          | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> index 9bce578..90c214d 100644
> --- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> @@ -38,3 +38,25 @@ sdhci@c8000200 {
>   	power-gpios = <&gpio 155 0>; /* gpio PT3 */
>   	bus-width = <8>;
>   };
> +
> +Optional properties for Tegra210 and Tegra186:
> +- pinctrl-names, pinctrl-0, pinctrl-1 : Specify pad voltage
> +  configurations. Valid pinctrl-names are "sdmmc-3v3" and "sdmmc-1v8"
> +  for controllers supporting multiple voltage levels. The order of names
> +  should correspond to the pin configuration states in pinctrl-0 and
> +  pinctrl-1.
> +
> +Example:
> +sdhci@700b0000 {
> +	compatible = "nvidia,tegra210-sdhci", "nvidia,tegra124-sdhci";
> +	reg = <0x0 0x700b0000 0x0 0x200>;
> +	interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
> +	clocks = <&tegra_car TEGRA210_CLK_SDMMC1>;
> +	clock-names = "sdhci";
> +	resets = <&tegra_car 14>;
> +	reset-names = "sdhci";
> +	pinctrl-names = "sdmmc-3v3", "sdmmc-1v8";
> +	pinctrl-0 = <&sdmmc1_3v3>;
> +	pinctrl-1 = <&sdmmc1_1v8>;
> +	status = "disabled";
> +};
> 
