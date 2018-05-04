Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751847AbeEDJwC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 05:52:02 -0400
Received: from mga03.intel.com ([134.134.136.65]:45569 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751269AbeEDJwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 05:52:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,362,1520924400";
   d="scan'208";a="36801071"
Subject: Re: [PATCH] mmc: tegra: remove redundant return statement
To: Aapo Vienamo <aapo.vienamo@iki.fi>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180504092053.GA20277@orion>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <c4dff381-4d46-c79c-5d36-d7f62438e0f1@intel.com>
Date: Fri, 4 May 2018 12:50:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180504092053.GA20277@orion>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/18 12:20, Aapo Vienamo wrote:
> A redundant return statement is removed from
> tegra_sdhci_set_uhs_signaling(). The function returns void and the
> return does not affect the control flow of the function.
> 
> Signed-off-by: Aapo Vienamo <aapo.vienamo@iki.fi>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-tegra.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index b877c13184c2..970d38f68939 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -231,7 +231,7 @@ static void tegra_sdhci_set_uhs_signaling(struct sdhci_host *host,
>  	if (timing == MMC_TIMING_UHS_DDR50)
>  		tegra_host->ddr_signaling = true;
>  
> -	return sdhci_set_uhs_signaling(host, timing);
> +	sdhci_set_uhs_signaling(host, timing);
>  }
>  
>  static unsigned int tegra_sdhci_get_max_clock(struct sdhci_host *host)
> 
