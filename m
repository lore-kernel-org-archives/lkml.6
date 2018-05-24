Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935748AbeEXH77 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 03:59:59 -0400
Received: from mga01.intel.com ([192.55.52.88]:55846 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935508AbeEXH75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 03:59:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,436,1520924400";
   d="scan'208";a="58068780"
Subject: Re: [PATCH 16/33] mmc: sdhci-xenon: use match_string() helper
To: Yisheng Xie <xieyisheng1@huawei.com>, linux-kernel@vger.kernel.org
Cc: Hu Ziji <huziji@marvell.com>, Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
 <1526903890-35761-17-git-send-email-xieyisheng1@huawei.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <91fa698a-5e9f-d5ef-c50e-eada27db7c04@intel.com>
Date: Thu, 24 May 2018 10:58:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1526903890-35761-17-git-send-email-xieyisheng1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/05/18 14:57, Yisheng Xie wrote:
> match_string() returns the index of an array for a matching string,
> which can be used intead of open coded variant.
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Hu Ziji <huziji@marvell.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc@vger.kernel.org
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-xenon-phy.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-xenon-phy.c b/drivers/mmc/host/sdhci-xenon-phy.c
> index ec87943..a35804b 100644
> --- a/drivers/mmc/host/sdhci-xenon-phy.c
> +++ b/drivers/mmc/host/sdhci-xenon-phy.c
> @@ -814,15 +814,10 @@ static int xenon_add_phy(struct device_node *np, struct sdhci_host *host,
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
> -	int i, ret;
> +	int ret;
>  
> -	for (i = 0; i < NR_PHY_TYPES; i++) {
> -		if (!strcmp(phy_name, phy_types[i])) {
> -			priv->phy_type = i;
> -			break;
> -		}
> -	}
> -	if (i == NR_PHY_TYPES) {
> +	priv->phy_type = match_string(phy_types, NR_PHY_TYPES, phy_name);
> +	if (priv->phy_type < 0) {
>  		dev_err(mmc_dev(host->mmc),
>  			"Unable to determine PHY name %s. Use default eMMC 5.1 PHY\n",
>  			phy_name);
> 
