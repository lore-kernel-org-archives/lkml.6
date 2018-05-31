Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753996AbeEaF5L (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 01:57:11 -0400
Received: from mga14.intel.com ([192.55.52.115]:25246 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753836AbeEaF5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 01:57:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,462,1520924400";
   d="scan'208";a="60035326"
Subject: Re: [PATCH] mmc: sdhci-msm: Remove NO_CARD_NO_RESET quirk
To: Georgi Djakov <georgi.djakov@linaro.org>, ulf.hansson@linaro.org
Cc: vviswana@codeaurora.org, riteshh@codeaurora.org,
        subhashj@codeaurora.org, stummala@codeaurora.org,
        asutoshd@codeaurora.org, bjorn.andersson@linaro.org,
        linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180530144335.7888-1-georgi.djakov@linaro.org>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <c61b82f1-8095-91dd-b4ea-5e38b1f257fe@intel.com>
Date: Thu, 31 May 2018 08:55:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180530144335.7888-1-georgi.djakov@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/18 17:43, Georgi Djakov wrote:
> Now we have a proper implementation for the power irq handling and this
> quirk is not needed anymore. In fact, it is causing card detection delays
> on apq8096 platforms and the following error is displayed:
> sdhci_msm 74a4900.sdhci: mmc0: pwr_irq for req: (4) timed out
> 
> The quirk is forcing the controller to retain 1.8V signalling on the slot
> even when a new card is inserted, which is not correct. The proper behavior
> would be to reset the controller in order to start with 3.3V signaling.
> 
> Fixes: c0309b3803fe ("mmc: sdhci-msm: Add sdhci msm register write APIs which wait for pwr irq")
> Suggested-by: Vijay Viswanath <vviswana@codeaurora.org>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> This can go for v4.18, as it's not a critical fix.
> Tested on db410c and db820c.
> ---
>  drivers/mmc/host/sdhci-msm.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index c283291db705..791779173332 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -1333,7 +1333,6 @@ static const struct sdhci_ops sdhci_msm_ops = {
>  
>  static const struct sdhci_pltfm_data sdhci_msm_pdata = {
>  	.quirks = SDHCI_QUIRK_BROKEN_CARD_DETECTION |
> -		  SDHCI_QUIRK_NO_CARD_NO_RESET |
>  		  SDHCI_QUIRK_SINGLE_POWER_WRITE |
>  		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
>  	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> 
