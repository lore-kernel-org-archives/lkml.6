Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A22CC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B8BF20647
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="zWCWLGM6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B8BF20647
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kapsi.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbeGYIe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 04:34:29 -0400
Received: from mail.kapsi.fi ([91.232.154.25]:50795 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728378AbeGYIe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 04:34:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2blypJ1oS+TImnO1ImoMNYDqC8jyn688KL4VA6gHYvg=; b=zWCWLGM6+F0wQPelESwylcHr+k
        pb16W2JX6a6hphWTod2KZ8wIehxPF3FTQmDUap3HjSGaTuxjeohOiq6LxAJZfdEdBsPifMZqUxZ50
        4Jb3RF4DYtOqtk/RnEowQ4PdovWFuMzyPVZ0wd+OoinxxpGBLEN91XQbOqxTrE+Nl6GCYqdVFS1MU
        SurZm/rSZ59hniYM8mxKipUWccDNXua+ymf6tH4ufGfzIv4XVypJtPvJXvsIbAb49mrHFnlUU8E2m
        iUXridreZhwtrKFDu5LIHXQqwKkFch2HEHA2apEntjsLjZJt7JvREO2BXMhXVQ8DaddtPIozVACm0
        GS3Ti3GQ==;
Received: from [193.209.96.43] (helo=[10.21.26.144])
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <cyndis@kapsi.fi>)
        id 1fiE9S-0007hE-0F; Wed, 25 Jul 2018 10:24:02 +0300
Subject: Re: [PATCH 06/10] mmc: tegra: Program pad autocal offsets from dt
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
 <1532442865-6391-5-git-send-email-avienamo@nvidia.com>
From:   Mikko Perttunen <cyndis@kapsi.fi>
Message-ID: <1c31907f-e6af-ae6f-9a7f-a983cc055f32@kapsi.fi>
Date:   Wed, 25 Jul 2018 10:24:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1532442865-6391-5-git-send-email-avienamo@nvidia.com>
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
> Parse the pad drive strength calibration offsets from the device tree.
> Program the calibration offsets in accordance with the current signaling
> mode.
> 
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> ---
>   drivers/mmc/host/sdhci-tegra.c | 147 ++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 146 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 0de74f4..78781bd 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -48,6 +48,7 @@
>   #define SDHCI_TEGRA_AUTO_CAL_CONFIG		0x1e4
>   #define SDHCI_AUTO_CAL_START			BIT(31)
>   #define SDHCI_AUTO_CAL_ENABLE			BIT(29)
> +#define SDHCI_AUTO_CAL_PDPU_OFFSET_MASK		0x0000ffff
>   
>   #define SDHCI_TEGRA_SDMEM_COMP_PADCTRL			0x1e0
>   #define SDHCI_TEGRA_SDMEM_COMP_PADCTRL_VREF_SEL_MASK	0x0000000f
> @@ -71,6 +72,22 @@ struct sdhci_tegra_soc_data {
>   	u32 nvquirks;
>   };
>   
> +/* Magic pull up and pull down pad calibration offsets */
> +struct sdhci_tegra_autocal_offsets {
> +	u8 pull_up_3v3;
> +	u8 pull_down_3v3;
> +	u8 pull_up_3v3_timeout;
> +	u8 pull_down_3v3_timeout;
> +	u8 pull_up_1v8;
> +	u8 pull_down_1v8;
> +	u8 pull_up_1v8_timeout;
> +	u8 pull_down_1v8_timeout;
> +	u8 pull_up_sdr104;
> +	u8 pull_down_sdr104;
> +	u8 pull_up_hs400;
> +	u8 pull_down_hs400;
> +}; > +
>   struct sdhci_tegra {
>   	const struct sdhci_tegra_soc_data *soc_data;
>   	struct gpio_desc *power_gpio;
> @@ -82,6 +99,8 @@ struct sdhci_tegra {
>   	struct pinctrl *pinctrl_sdmmc;
>   	struct pinctrl_state *pinctrl_state_3v3;
>   	struct pinctrl_state *pinctrl_state_1v8;
> +
> +	struct sdhci_tegra_autocal_offsets autocal_offsets;
>   };
>   
>   static u16 tegra_sdhci_readw(struct sdhci_host *host, int reg)
> @@ -248,12 +267,45 @@ static bool tegra_sdhci_configure_card_clk(struct sdhci_host *host, bool enable)
>   	return orig_enabled;
>   }
>   
> +static void tegra_sdhci_set_pad_autocal_offset(struct sdhci_host *host,
> +					       u16 pdpu)
> +{
> +	u32 reg;
> +
> +	reg = sdhci_readl(host, SDHCI_TEGRA_AUTO_CAL_CONFIG);
> +	reg &= ~SDHCI_AUTO_CAL_PDPU_OFFSET_MASK;
> +	reg |= pdpu;
> +	sdhci_writel(host, reg, SDHCI_TEGRA_AUTO_CAL_CONFIG);
> +}
> +
>   static void tegra_sdhci_pad_autocalib(struct sdhci_host *host)
>   {
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
> +	struct sdhci_tegra_autocal_offsets offsets =
> +			tegra_host->autocal_offsets;
> +	struct mmc_ios *ios = &host->mmc->ios;
>   	unsigned timeout = 10;
>   	bool card_clk_enabled;
> +	u16 pdpu;
>   	u32 reg;
>   
> +	switch (ios->timing) {
> +	case MMC_TIMING_UHS_SDR104:
> +		pdpu = offsets.pull_down_sdr104 << 8 | offsets.pull_up_sdr104;
> +		break;
> +	case MMC_TIMING_MMC_HS400:
> +		pdpu = offsets.pull_down_hs400 << 8 | offsets.pull_up_hs400;
> +		break;
> +	default:
> +		if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180)
> +			pdpu = offsets.pull_down_1v8 << 8 | offsets.pull_up_1v8;
> +		else
> +			pdpu = offsets.pull_down_3v3 << 8 | offsets.pull_up_3v3;
> +	}
> +
> +	tegra_sdhci_set_pad_autocal_offset(host, pdpu);
> +
>   	card_clk_enabled = tegra_sdhci_configure_card_clk(host, false);
>   
>   	tegra_sdhci_configure_cal_pad(host, true);
> @@ -275,8 +327,99 @@ static void tegra_sdhci_pad_autocalib(struct sdhci_host *host)
>   
>   	tegra_sdhci_configure_card_clk(host, card_clk_enabled);
>   
> -	if (timeout == 0)
> +	if (timeout == 0) {
>   		dev_err(mmc_dev(host->mmc), "Pad autocal timed out\n");
> +
> +		if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180)
> +			pdpu = offsets.pull_down_1v8_timeout << 8 |
> +			       offsets.pull_up_1v8_timeout;
> +		else
> +			pdpu = offsets.pull_down_3v3_timeout << 8 |
> +			       offsets.pull_up_3v3_timeout;
> +
> +		tegra_sdhci_set_pad_autocal_offset(host, pdpu);
> +	}
> +}
> +
> +static void tegra_sdhci_parse_pad_autocal_dt(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
> +	struct sdhci_tegra_autocal_offsets *autocal =
> +			&tegra_host->autocal_offsets;
> +	int err;
> +
> +	err = device_property_read_u8(host->mmc->parent,
> +				      "pad-autocal-pull-up-offset-3v3",
> +				      &autocal->pull_up_3v3);
> +	if (err)
> +		autocal->pull_up_3v3 = 0;
> +

If you read these properties using read_u8, they'll need to be specified 
in the device tree as "property = /bits/ 8 <...>;", which might not be 
desirable.

> +	err = device_property_read_u8(host->mmc->parent,
> +				      "pad-autocal-pull-down-offset-3v3",
> +				      &autocal->pull_down_3v3);
> +	if (err)
> +		autocal->pull_down_3v3 = 0;
> +
> +	err = device_property_read_u8(host->mmc->parent,
> +				      "pad-autocal-pull-up-offset-1v8",
> +				      &autocal->pull_up_1v8);
> +	if (err)
> +		autocal->pull_up_1v8 = 0;
> +
> +	err = device_property_read_u8(host->mmc->parent,
> +				      "pad-autocal-pull-down-offset-1v8",
> +				      &autocal->pull_down_1v8);
> +	if (err)
> +		autocal->pull_down_1v8 = 0;
> +
> +	err = device_property_read_u8(host->mmc->parent,
> +				      "pad-autocal-pull-up-offset-3v3-timeout",
> +				      &autocal->pull_up_3v3);
> +	if (err)
> +		autocal->pull_up_3v3_timeout = 0;
> +
> +	err = device_property_read_u8(host->mmc->parent,
> +			"pad-autocal-pull-down-offset-3v3-timeout",
> +			&autocal->pull_down_3v3);
> +	if (err)
> +		autocal->pull_down_3v3_timeout = 0;
> +
> +	err = device_property_read_u8(host->mmc->parent,
> +				      "pad-autocal-pull-up-offset-1v8-timeout",
> +				      &autocal->pull_up_1v8);
> +	if (err)
> +		autocal->pull_up_1v8_timeout = 0;
> +
> +	err = device_property_read_u8(host->mmc->parent,
> +			"pad-autocal-pull-down-offset-1v8-timeout",
> +			&autocal->pull_down_1v8);
> +	if (err)
> +		autocal->pull_down_1v8_timeout = 0;
> +
> +	err = device_property_read_u8(host->mmc->parent,
> +				      "pad-autocal-pull-up-offset-sdr104",
> +				      &autocal->pull_up_sdr104);
> +	if (err)
> +		autocal->pull_up_sdr104 = autocal->pull_up_1v8;
> +
> +	err = device_property_read_u8(host->mmc->parent,
> +				      "pad-autocal-pull-down-offset-sdr104",
> +				      &autocal->pull_down_sdr104);
> +	if (err)
> +		autocal->pull_down_sdr104 = autocal->pull_down_1v8;
> +
> +	err = device_property_read_u8(host->mmc->parent,
> +				      "pad-autocal-pull-up-offset-hs400",
> +				      &autocal->pull_up_hs400);
> +	if (err)
> +		autocal->pull_up_hs400 = autocal->pull_up_1v8;
> +
> +	err = device_property_read_u8(host->mmc->parent,
> +				      "pad-autocal-pull-down-offset-hs400",
> +				      &autocal->pull_down_hs400);
> +	if (err)
> +		autocal->pull_down_hs400 = autocal->pull_down_1v8;
>   }
>   
>   static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
> @@ -638,6 +781,8 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
>   	if (tegra_host->soc_data->nvquirks & NVQUIRK_ENABLE_DDR50)
>   		host->mmc->caps |= MMC_CAP_1_8V_DDR;
>   
> +	tegra_sdhci_parse_pad_autocal_dt(host);
> +
>   	tegra_host->power_gpio = devm_gpiod_get_optional(&pdev->dev, "power",
>   							 GPIOD_OUT_HIGH);
>   	if (IS_ERR(tegra_host->power_gpio)) {
> 
