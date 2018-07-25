Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672E5C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E4CE20844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="0vypqJPW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E4CE20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kapsi.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbeGYIV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 04:21:58 -0400
Received: from mail.kapsi.fi ([91.232.154.25]:39621 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728496AbeGYIV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 04:21:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=L7nAIy1ib05GTXhgTIWU79BablvQZMfRO6Y3INS3ddg=; b=0vypqJPW4mbY21Ea7l7QjcX/xZ
        Y3kTZCNaUn2BW+SV7delyOaPSlzPj59qWxargtByLzAW1+EvQb+u0SWXFQEtYcbp2cTi1ORkogLqc
        9J56LB3THe6T3ZoJMP2ZeVyDiGuBRLNAXNviIfcGZNRk/UmpOvpOHrQhfCCGiL8zf7blKL+BV0Kbo
        NhJsb2//5hpuQuYLdNsAPCeenFBrNfbbPT3OUBzZXt2WClo7EwW3KPfgiaJTLoGIT8mvBfFMrwrEw
        YIO9I5p84tSDvQP096kWzdUS3KwrDLLnXEv8EWJ1uL6+ilmfan95yNbC2acyxthvh2x4OTckecyh8
        SSUpGpzw==;
Received: from [193.209.96.43] (helo=[10.21.26.144])
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <cyndis@kapsi.fi>)
        id 1fiDxO-0003Fc-DL; Wed, 25 Jul 2018 10:11:34 +0300
Subject: Re: [PATCH 03/10] mmc: tegra: Power on the calibration pad
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
 <1532442865-6391-2-git-send-email-avienamo@nvidia.com>
From:   Mikko Perttunen <cyndis@kapsi.fi>
Message-ID: <3a364a72-1052-b0c8-35f5-2987c2c2784c@kapsi.fi>
Date:   Wed, 25 Jul 2018 10:11:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1532442865-6391-2-git-send-email-avienamo@nvidia.com>
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

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>

On 24.07.2018 17:34, Aapo Vienamo wrote:
> Automatic pad drive strength calibration is performed on a separate pad
> identical to the ones used for driving the actual bus. Power on the
> calibration pad during the calibration procedure and power it off
> afterwards to save power.
> 
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> ---
>   drivers/mmc/host/sdhci-tegra.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 6008e2f..61067b7 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -209,11 +209,30 @@ static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
>   	tegra_host->ddr_signaling = false;
>   }
>   
> +static void tegra_sdhci_configure_cal_pad(struct sdhci_host *host, bool enable)
> +{
> +	u32 reg;
> +
> +	/*
> +	 * Enable or disable the additional I/O pad used by the drive strength
> +	 * calibration process.
> +	 */
> +	reg = sdhci_readl(host, SDHCI_TEGRA_SDMEM_COMP_PADCTRL);
> +	if (enable)
> +		reg |= SDHCI_TEGRA_PAD_E_INPUT_OR_E_PWRD;
> +	else
> +		reg &= ~SDHCI_TEGRA_PAD_E_INPUT_OR_E_PWRD;
> +	sdhci_writel(host, reg, SDHCI_TEGRA_SDMEM_COMP_PADCTRL);
> +	udelay(1);
> +}
> +
>   static void tegra_sdhci_pad_autocalib(struct sdhci_host *host)
>   {
>   	unsigned timeout = 10;
>   	u32 reg;
>   
> +	tegra_sdhci_configure_cal_pad(host, true);
> +
>   	reg = sdhci_readl(host, SDHCI_TEGRA_AUTO_CAL_CONFIG);
>   	reg |= SDHCI_AUTO_CAL_ENABLE | SDHCI_AUTO_CAL_START;
>   	sdhci_writel(host, reg, SDHCI_TEGRA_AUTO_CAL_CONFIG);
> @@ -227,6 +246,8 @@ static void tegra_sdhci_pad_autocalib(struct sdhci_host *host)
>   		timeout--;
>   	} while (timeout);
>   
> +	tegra_sdhci_configure_cal_pad(host, false);
> +
>   	if (timeout == 0)
>   		dev_err(mmc_dev(host->mmc), "Pad autocal timed out\n");
>   }
> 
