Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D38C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D709F20844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="W4gMIQYt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D709F20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kapsi.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbeGYIZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 04:25:18 -0400
Received: from mail.kapsi.fi ([91.232.154.25]:44385 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728441AbeGYIZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 04:25:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XaLWDGcvOjqwICLLZ6HH3Lwe9t+YVyI+QKj3ZW5Noy4=; b=W4gMIQYtZP8tqZ93bFZKmCaAUC
        Y+6dGkKfqPeR2G3XGhOKzAqdtjyZcEKExA3ONNVur7PAI5Di7sez/9+BY+UAmVYn+fkSXhvgGZvYV
        h08p9A/CGx+r1ZSlcO/UGCzHYo+z19naZxSfb+d1+j1hkXdAH6xYNuWFainOfub+wxrAqu5WOYX0s
        HMoQZsVdQDPh5uh7BBpWNBHOKl9qcCO89bYv+O6sHHVFEPTg+eizPLkgHSmiLWgEwkAdyDWZjK3Cl
        BRcNMoyMyWPEDHMQfFZfq4lXcegIf7DXFT9E+x9gC2W8qsnF/pRXhuYwzoNA3rt/9ODKVh9Zlcf8N
        itJ73I2w==;
Received: from [193.209.96.43] (helo=[10.21.26.144])
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <cyndis@kapsi.fi>)
        id 1fiE0c-0004In-Md; Wed, 25 Jul 2018 10:14:54 +0300
Subject: Re: [PATCH 04/10] mmc: tegra: Disable card clock during pad
 calibration
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
 <1532442865-6391-3-git-send-email-avienamo@nvidia.com>
From:   Mikko Perttunen <cyndis@kapsi.fi>
Message-ID: <1f70fd07-f952-63c9-8727-e6dacf52da73@kapsi.fi>
Date:   Wed, 25 Jul 2018 10:14:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1532442865-6391-3-git-send-email-avienamo@nvidia.com>
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
> Disable the card clock during automatic pad drive strength calibration
> and re-enable it aftewards.

s/aftewards/afterwards/.

> 
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> ---
>   drivers/mmc/host/sdhci-tegra.c | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 61067b7..0de74f4 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -52,6 +52,7 @@
>   #define SDHCI_TEGRA_SDMEM_COMP_PADCTRL			0x1e0
>   #define SDHCI_TEGRA_SDMEM_COMP_PADCTRL_VREF_SEL_MASK	0x0000000f
>   #define SDHCI_TEGRA_SDMEM_COMP_PADCTRL_VREF_SEL_VAL	0x7
> +#define SDHCI_TEGRA_PAD_E_INPUT_OR_E_PWRD		BIT(31)

Looks like this should be in the previous patch.

>   
>   #define SDHCI_TEGRA_AUTO_CAL_STATUS     0x1ec
>   #define SDHCI_TEGRA_AUTO_CAL_ACTIVE     BIT(31)
> @@ -226,11 +227,35 @@ static void tegra_sdhci_configure_cal_pad(struct sdhci_host *host, bool enable)
>   	udelay(1);
>   }
>   
> +static bool tegra_sdhci_configure_card_clk(struct sdhci_host *host, bool enable)
> +{
> +	bool orig_enabled;
> +	u32 reg;
> +
> +	reg = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +	orig_enabled = reg & SDHCI_CLOCK_CARD_EN;

I would do !!(reg & SDHCI_CLOCK_CARD_EN) here.

> +
> +	if (orig_enabled == enable)
> +		return orig_enabled;
> +
> +	if (enable)
> +		reg |= SDHCI_CLOCK_CARD_EN;
> +	else
> +		reg &= ~SDHCI_CLOCK_CARD_EN;
> +
> +	sdhci_writew(host, reg, SDHCI_CLOCK_CONTROL);
> +
> +	return orig_enabled;
> +}
> +
>   static void tegra_sdhci_pad_autocalib(struct sdhci_host *host)
>   {
>   	unsigned timeout = 10;
> +	bool card_clk_enabled;
>   	u32 reg;
>   
> +	card_clk_enabled = tegra_sdhci_configure_card_clk(host, false);
> +
>   	tegra_sdhci_configure_cal_pad(host, true);
>   
>   	reg = sdhci_readl(host, SDHCI_TEGRA_AUTO_CAL_CONFIG);
> @@ -248,6 +273,8 @@ static void tegra_sdhci_pad_autocalib(struct sdhci_host *host)
>   
>   	tegra_sdhci_configure_cal_pad(host, false);
>   
> +	tegra_sdhci_configure_card_clk(host, card_clk_enabled);
> +
>   	if (timeout == 0)
>   		dev_err(mmc_dev(host->mmc), "Pad autocal timed out\n");
>   }
> 
