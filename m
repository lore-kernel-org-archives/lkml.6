Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABAFC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 06:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FC4820671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 06:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="xSjMLEUv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FC4820671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kapsi.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbeGYHvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 03:51:31 -0400
Received: from mail.kapsi.fi ([91.232.154.25]:48339 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728222AbeGYHvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 03:51:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YfWhDcfuQRvrHGIxKTPv5b7y4LjucfnImd/oETDzOw0=; b=xSjMLEUvKz+RR+O7Uy5HlE2/At
        G8p7CzAwH41H7qEiI7TI1K7l2HIOQnMBzbwiuEOdfZJApHalcwaRvzh6EmQwQDOA+IgMx+CIN0+Tc
        /0OnVj6dOffzr6InKxKZMmVmKb4cQJMKawgG07Uvu7e/5Pa55CA7MZgwF+oJ/LJs665oGgaKxBXMK
        A+6twwmz1au1G2jetM6UXbN7pvQWobSxX7E1P07HjILLeD14Rxf6g43joFs7XwddjLnfHBAr4gk5o
        IiWQmgFvp9zLZX49ygSVqDiJiG1boYlCoOHND5oDhi/Aykv021c1f+8lRWaDxrqV5tWcmST/IFrVq
        DUXOOELA==;
Received: from [193.209.96.43] (helo=[10.21.26.144])
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <cyndis@kapsi.fi>)
        id 1fiDTt-0000LT-EV; Wed, 25 Jul 2018 09:41:05 +0300
Subject: Re: [PATCH 2/7] mmc: tegra: Reconfigure pad voltages during voltage
 switching
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
 <1532090746-15863-3-git-send-email-avienamo@nvidia.com>
From:   Mikko Perttunen <cyndis@kapsi.fi>
Message-ID: <45dff1ef-c86e-0265-3386-fe95251b9130@kapsi.fi>
Date:   Wed, 25 Jul 2018 09:41:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1532090746-15863-3-git-send-email-avienamo@nvidia.com>
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

On 20.07.2018 15:45, Aapo Vienamo wrote:
> Parse the pinctrl states from the device tree and implement pad voltage
> state reconfiguration in the mmc start_signal_voltage_switch() callback.
> This is done in the mmc callback because the order of pad
> reconfiguration and sdhci voltage switch depend on the voltage to which
> the transition occurs.
> 
> Add NVQUIRK_NEEDS_PAD_CONTROL and add set it for Tegra210 and Tegra186.
> 
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> ---
>   drivers/mmc/host/sdhci-tegra.c | 91 +++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 85 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index ddf00166..f108c48 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -21,6 +21,7 @@
>   #include <linux/io.h>
>   #include <linux/of.h>
>   #include <linux/of_device.h>
> +#include <linux/pinctrl/consumer.h>
>   #include <linux/reset.h>
>   #include <linux/mmc/card.h>
>   #include <linux/mmc/host.h>
> @@ -55,6 +56,7 @@
>   #define NVQUIRK_ENABLE_SDR104		BIT(4)
>   #define NVQUIRK_ENABLE_DDR50		BIT(5)
>   #define NVQUIRK_HAS_PADCALIB		BIT(6)
> +#define NVQUIRK_NEEDS_PAD_CONTROL	BIT(7)
>   
>   struct sdhci_tegra_soc_data {
>   	const struct sdhci_pltfm_data *pdata;
> @@ -66,8 +68,12 @@ struct sdhci_tegra {
>   	struct gpio_desc *power_gpio;
>   	bool ddr_signaling;
>   	bool pad_calib_required;
> +	bool pad_control_required;
>   
>   	struct reset_control *rst;
> +	struct pinctrl *pinctrl_sdmmc;
> +	struct pinctrl_state *pinctrl_state_3v3;
> +	struct pinctrl_state *pinctrl_state_1v8;
>   };
>   
>   static u16 tegra_sdhci_readw(struct sdhci_host *host, int reg)
> @@ -286,14 +292,80 @@ static int tegra_sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
>   	return mmc_send_tuning(host->mmc, opcode, NULL);
>   }
>   
> -static void tegra_sdhci_voltage_switch(struct sdhci_host *host)
> +static int tegra_sdhci_set_padctrl(struct sdhci_host *host, int voltage)
>   {
>   	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>   	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
> -	const struct sdhci_tegra_soc_data *soc_data = tegra_host->soc_data;
> +	int ret;
> +
> +	if (!tegra_host->pad_control_required)
> +		return 0;
> +
> +	if (voltage == MMC_SIGNAL_VOLTAGE_180) {
> +		ret = pinctrl_select_state(tegra_host->pinctrl_sdmmc,
> +					   tegra_host->pinctrl_state_1v8);
> +		if (ret < 0)
> +			dev_err(mmc_dev(host->mmc),
> +				"setting 1.8V failed, ret: %d\n", ret);
> +	} else {
> +		ret = pinctrl_select_state(tegra_host->pinctrl_sdmmc,
> +					   tegra_host->pinctrl_state_3v3);
> +		if (ret < 0)
> +			dev_err(mmc_dev(host->mmc),
> +				"setting 3.3V failed, ret: %d\n", ret);
> +	}
>   
> -	if (soc_data->nvquirks & NVQUIRK_HAS_PADCALIB)
> -		tegra_host->pad_calib_required = true;
> +	return ret;
> +}
> +
> +static int sdhci_tegra_start_signal_voltage_switch(struct mmc_host *mmc,
> +						   struct mmc_ios *ios)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	int ret = 0;
> +
> +	if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330) {
> +		ret = tegra_sdhci_set_padctrl(host, ios->signal_voltage);
> +		if (ret < 0)
> +			return ret;
> +		ret = sdhci_start_signal_voltage_switch(mmc, ios);
> +	} else if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180) {
> +		ret = sdhci_start_signal_voltage_switch(mmc, ios);
> +		if (ret < 0)
> +			return ret;
> +		ret = tegra_sdhci_set_padctrl(host, ios->signal_voltage);
> +	}
> +
> +	return ret;
> +}
> +
> +static void tegra_sdhci_init_pinctrl_info(struct device *dev,
> +					  struct sdhci_tegra *tegra_host)
> +{
> +	tegra_host->pinctrl_sdmmc = devm_pinctrl_get(dev);
> +	if (IS_ERR_OR_NULL(tegra_host->pinctrl_sdmmc)) {

Can this ever return NULL, considering ARCH_TEGRA selects PINCTRL? 
IS_ERR is probably better. Same for the two other checks in this function.

> +		dev_dbg(dev, "No pinctrl info, err: %ld\n",
> +			PTR_ERR(tegra_host->pinctrl_sdmmc));
> +		return;
> +	}
> +
> +	tegra_host->pinctrl_state_3v3 =
> +		pinctrl_lookup_state(tegra_host->pinctrl_sdmmc, "sdmmc-3v3");
> +	if (IS_ERR_OR_NULL(tegra_host->pinctrl_state_3v3)) {
> +		dev_err(dev, "Missing 3.3V pad state, err: %ld\n",
> +			PTR_ERR(tegra_host->pinctrl_state_3v3));
> +		return;
> +	}
> +
> +	tegra_host->pinctrl_state_1v8 =
> +		pinctrl_lookup_state(tegra_host->pinctrl_sdmmc, "sdmmc-1v8");
> +	if (IS_ERR_OR_NULL(tegra_host->pinctrl_state_1v8)) {
> +		dev_err(dev, "Missing 1.8V pad state, err: %ld\n",
> +			  PTR_ERR(tegra_host->pinctrl_state_3v3));
> +		return;
> +	}
> +
> +	tegra_host->pad_control_required = true; >   }
>   
>   static const struct sdhci_ops tegra_sdhci_ops = {
> @@ -305,7 +377,6 @@ static const struct sdhci_ops tegra_sdhci_ops = {
>   	.reset      = tegra_sdhci_reset,
>   	.platform_execute_tuning = tegra_sdhci_execute_tuning,
>   	.set_uhs_signaling = tegra_sdhci_set_uhs_signaling,
> -	.voltage_switch = tegra_sdhci_voltage_switch,
>   	.get_max_clock = tegra_sdhci_get_max_clock,
>   };
>   
> @@ -362,7 +433,6 @@ static const struct sdhci_ops tegra114_sdhci_ops = {
>   	.reset      = tegra_sdhci_reset,
>   	.platform_execute_tuning = tegra_sdhci_execute_tuning,
>   	.set_uhs_signaling = tegra_sdhci_set_uhs_signaling,
> -	.voltage_switch = tegra_sdhci_voltage_switch,
>   	.get_max_clock = tegra_sdhci_get_max_clock,
>   };
>   
> @@ -419,6 +489,7 @@ static const struct sdhci_pltfm_data sdhci_tegra210_pdata = {
>   
>   static const struct sdhci_tegra_soc_data soc_data_tegra210 = {
>   	.pdata = &sdhci_tegra210_pdata,
> +	.nvquirks = NVQUIRK_NEEDS_PAD_CONTROL,
>   };
>   
>   static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
> @@ -442,6 +513,7 @@ static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
>   
>   static const struct sdhci_tegra_soc_data soc_data_tegra186 = {
>   	.pdata = &sdhci_tegra186_pdata,
> +	.nvquirks = NVQUIRK_NEEDS_PAD_CONTROL,
>   };
>   
>   static const struct of_device_id sdhci_tegra_dt_match[] = {
> @@ -478,8 +550,15 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
>   	tegra_host = sdhci_pltfm_priv(pltfm_host);
>   	tegra_host->ddr_signaling = false;
>   	tegra_host->pad_calib_required = false;
> +	tegra_host->pad_control_required = false;
>   	tegra_host->soc_data = soc_data;
>   
> +	if (soc_data->nvquirks & NVQUIRK_NEEDS_PAD_CONTROL) {
> +		host->mmc_host_ops.start_signal_voltage_switch =
> +			sdhci_tegra_start_signal_voltage_switch;
> +		tegra_sdhci_init_pinctrl_info(&pdev->dev, tegra_host);
> +	}
> +

Do we know here if the controller is for eMMC or SD? If it's for SD we 
should probably print a warning if the pinctrl info is not available. 
Later we would also need to disable 1.8V modes if we fail to get the 
pinctrl info.

Cheers,
Mikko

>   	rc = mmc_of_parse(host->mmc);
>   	if (rc)
>   		goto err_parse_dt;
> 
