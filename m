Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752717AbeC2MuJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 08:50:09 -0400
Received: from mga04.intel.com ([192.55.52.120]:19369 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751903AbeC2MuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 08:50:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,376,1517904000";
   d="scan'208";a="37864000"
Subject: Re: [PATCH v2] mmc: sdhci-of-arasan: Add quirk to avoid unexpected
 interrupt msgs
To: Phil Edworthy <phil.edworthy@renesas.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: Michal Simek <michal.simek@xilinx.com>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michel Pollet <michel.pollet@bp.renesas.com>
References: <1520951200-24703-1-git-send-email-phil.edworthy@renesas.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <4b50ca51-117e-cab2-7459-d6c9727ca07c@intel.com>
Date: Thu, 29 Mar 2018 15:49:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520951200-24703-1-git-send-email-phil.edworthy@renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/03/18 16:26, Phil Edworthy wrote:
> On SD 2.00 cards we get lots of these messages:
> "mmc0: Got data interrupt 0x00000002 even though no data operation was in progress"
> By applying the SDHCI_QUIRK2_STOP_WITH_TC quirk, the messages no longer happen.
> 
> A single card claiming to be SD 3.00 compliant also generates the interrupts,
> but since the card's manfacturing date is 2002 mar, it's unlikely to really be
> SD 3.00. This card is a 8GB SanDisk 'SU08G' 8.0 (SDHC class 4).
> 
> This has been reported on Xilinx devices that also use the Arasan IP.
> See https://patchwork.kernel.org/patch/8062871/
> 
> This has been tested on the Renesas RZ/ND-DB board with the RZ/N1 SoC. The
> Arasan IP in this device is version 1.39a and uses a max SD clock of 50MHz and
> does not support DDR modes.
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> v2:
>  - Changed commit msg to detail the cards that fail.
>  - Provided the IP version and further background info.
> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index c33a5f7..ab66e32 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -290,7 +290,8 @@ static const struct sdhci_pltfm_data sdhci_arasan_pdata = {
>  	.ops = &sdhci_arasan_ops,
>  	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
>  	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> -			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
> +			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN |
> +			SDHCI_QUIRK2_STOP_WITH_TC,
>  };
>  
>  static u32 sdhci_arasan_cqhci_irq(struct sdhci_host *host, u32 intmask)
> 
