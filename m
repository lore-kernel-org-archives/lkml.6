Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E745C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14EB720882
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="qZKiHVFT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14EB720882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kapsi.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbeGYITI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 04:19:08 -0400
Received: from mail.kapsi.fi ([91.232.154.25]:36543 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728444AbeGYITH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 04:19:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=26NYzL26N6S+GxoNBM5smObYJtOwiXJ3Ne1UYa5W2Iw=; b=qZKiHVFTbsNGPbaWZNXr5KKjpJ
        gFscbW3jX/FCYUmeh+Ag3SHTBpVDxzQ36a9uq7PbBvxuliTBLNdwag9U25hjTPfQvlg5jUU4kAu39
        V4vl8QhhtYffiQoKVHjtTuTyPyDS1BzbL2kUleXLVl8xwB7/c8CgMKu36Cbl0Uu20XE1yRf/zq2MG
        llsUVYOoLIWhxuFtJ5ufRzGakZeeUQ5y1KKNVg8eb0wpeQz1uCJ8a1VZRhlhsXMKOyY+kpNIydVlw
        yEmDQZdViCIgivNBpvCelB1F9nFCvDyYh6LgCTxhm8O7Mr0Z6ozMPSqEqH1IvNJHStWMImucSRbIv
        OvLwCnrQ==;
Received: from [193.209.96.43] (helo=[10.21.26.144])
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <cyndis@kapsi.fi>)
        id 1fiDug-00024j-Ub; Wed, 25 Jul 2018 10:08:46 +0300
Subject: Re: [PATCH 02/10] mmc: tegra: Set calibration pad voltage reference
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
From:   Mikko Perttunen <cyndis@kapsi.fi>
Message-ID: <d5018027-f333-8432-f8ed-81a2cdfedea8@kapsi.fi>
Date:   Wed, 25 Jul 2018 10:08:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1532442865-6391-1-git-send-email-avienamo@nvidia.com>
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
> Configure the voltage reference used by the automatic pad drive strength
> calibration procedure. The value is a magic number from the TRM.
> 
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> ---
>   drivers/mmc/host/sdhci-tegra.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index e40ca43..6008e2f 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -49,6 +49,10 @@
>   #define SDHCI_AUTO_CAL_START			BIT(31)
>   #define SDHCI_AUTO_CAL_ENABLE			BIT(29)
>   
> +#define SDHCI_TEGRA_SDMEM_COMP_PADCTRL			0x1e0
> +#define SDHCI_TEGRA_SDMEM_COMP_PADCTRL_VREF_SEL_MASK	0x0000000f
> +#define SDHCI_TEGRA_SDMEM_COMP_PADCTRL_VREF_SEL_VAL	0x7
> +
>   #define SDHCI_TEGRA_AUTO_CAL_STATUS     0x1ec
>   #define SDHCI_TEGRA_AUTO_CAL_ACTIVE     BIT(31)
>   
> @@ -152,7 +156,7 @@ static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
>   	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>   	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
>   	const struct sdhci_tegra_soc_data *soc_data = tegra_host->soc_data;
> -	u32 misc_ctrl, clk_ctrl;
> +	u32 misc_ctrl, clk_ctrl, pad_ctrl;
>   
>   	sdhci_reset(host, mask);
>   
> @@ -193,8 +197,14 @@ static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
>   	sdhci_writel(host, misc_ctrl, SDHCI_TEGRA_VENDOR_MISC_CTRL);
>   	sdhci_writel(host, clk_ctrl, SDHCI_TEGRA_VENDOR_CLOCK_CTRL);
>   
> -	if (soc_data->nvquirks & NVQUIRK_HAS_PADCALIB)
> +	if (soc_data->nvquirks & NVQUIRK_HAS_PADCALIB) {
> +		pad_ctrl = sdhci_readl(host, SDHCI_TEGRA_SDMEM_COMP_PADCTRL);
> +		pad_ctrl &= ~SDHCI_TEGRA_SDMEM_COMP_PADCTRL_VREF_SEL_MASK;
> +		pad_ctrl |= SDHCI_TEGRA_SDMEM_COMP_PADCTRL_VREF_SEL_VAL;
> +		sdhci_writel(host, pad_ctrl, SDHCI_TEGRA_SDMEM_COMP_PADCTRL);
> +

Will this happen to only eMMC controllers or for all controllers? My 
docs are saying this should be set to 0x7 for SDMMC2/4 and 0x1 or 0x2 
for SDMMC1/3 depending on voltage. Not sure how downstream is 
programming it, though.

>   		tegra_host->pad_calib_required = true;
> +	}
>   
>   	tegra_host->ddr_signaling = false;
>   }
> 
