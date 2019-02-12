Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1554FC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D948A2083B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbfBLINN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 03:13:13 -0500
Received: from mga04.intel.com ([192.55.52.120]:59506 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727509AbfBLINN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 03:13:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2019 00:13:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,361,1544515200"; 
   d="scan'208";a="137909992"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.56]) ([10.237.72.56])
  by orsmga001.jf.intel.com with ESMTP; 12 Feb 2019 00:13:09 -0800
Subject: Re: [PATCH v2 3/3] mmc: sdhci-tegra: drop ->get_ro() implementation
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, Faiz Abbas <faiz_abbas@ti.com>,
        Thierry Reding <treding@nvidia.com>
References: <20190211132342.31009-1-thomas.petazzoni@bootlin.com>
 <20190211132342.31009-4-thomas.petazzoni@bootlin.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <a4edf67c-27dd-a866-f249-c861dd2a721c@intel.com>
Date:   Tue, 12 Feb 2019 10:11:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190211132342.31009-4-thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02/19 3:23 PM, Thomas Petazzoni wrote:
> The SDHCI core is know properly checking for the state of a WP GPIO,
> so there is no longer any need for the sdhci-tegra code to implement
> ->get_ro() using mmc_gpio_get_ro().
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> Tested-by: Thierry Reding <treding@nvidia.com>
> Acked-by: Thierry Reding <treding@nvidia.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Changes since v1:
>  - Added Tested-by/Acked-by from Thierry Reding
> 
> Note: this patch has only been compiled tested, as I don't have the
> hardware to test it.
> ---
>  drivers/mmc/host/sdhci-tegra.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index e6ace31e2a41..6ed7323bf030 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -237,11 +237,6 @@ static void tegra210_sdhci_writew(struct sdhci_host *host, u16 val, int reg)
>  	}
>  }
>  
> -static unsigned int tegra_sdhci_get_ro(struct sdhci_host *host)
> -{
> -	return mmc_gpio_get_ro(host->mmc);
> -}
> -
>  static bool tegra_sdhci_is_pad_and_regulator_valid(struct sdhci_host *host)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -837,7 +832,6 @@ static void tegra_sdhci_voltage_switch(struct sdhci_host *host)
>  }
>  
>  static const struct sdhci_ops tegra_sdhci_ops = {
> -	.get_ro     = tegra_sdhci_get_ro,
>  	.read_w     = tegra_sdhci_readw,
>  	.write_l    = tegra_sdhci_writel,
>  	.set_clock  = tegra_sdhci_set_clock,
> @@ -893,7 +887,6 @@ static const struct sdhci_tegra_soc_data soc_data_tegra30 = {
>  };
>  
>  static const struct sdhci_ops tegra114_sdhci_ops = {
> -	.get_ro     = tegra_sdhci_get_ro,
>  	.read_w     = tegra_sdhci_readw,
>  	.write_w    = tegra_sdhci_writew,
>  	.write_l    = tegra_sdhci_writel,
> @@ -947,7 +940,6 @@ static const struct sdhci_tegra_soc_data soc_data_tegra124 = {
>  };
>  
>  static const struct sdhci_ops tegra210_sdhci_ops = {
> -	.get_ro     = tegra_sdhci_get_ro,
>  	.read_w     = tegra_sdhci_readw,
>  	.write_w    = tegra210_sdhci_writew,
>  	.write_l    = tegra_sdhci_writel,
> @@ -980,7 +972,6 @@ static const struct sdhci_tegra_soc_data soc_data_tegra210 = {
>  };
>  
>  static const struct sdhci_ops tegra186_sdhci_ops = {
> -	.get_ro     = tegra_sdhci_get_ro,
>  	.read_w     = tegra_sdhci_readw,
>  	.write_l    = tegra_sdhci_writel,
>  	.set_clock  = tegra_sdhci_set_clock,
> 

