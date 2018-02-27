Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753311AbeB0O2C (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 09:28:02 -0500
Received: from lucky1.263xmail.com ([211.157.147.132]:56969 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752193AbeB0O2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 09:28:01 -0500
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: shawn.lin@rock-chips.com
X-FST-TO: linux-renesas-soc@vger.kernel.org
X-SENDER-IP: 220.200.5.149
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-UNIQUE-TAG: <f6600dcbf72f4da6e322509c082a69f5>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Cc: Adrian Hunter <adrian.hunter@intel.com>, shawn.lin@rock-chips.com,
        Michal Simek <michal.simek@xilinx.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Add quirk to avoid erroneous msg
To: Phil Edworthy <phil.edworthy@renesas.com>
References: <1519739731-27920-1-git-send-email-phil.edworthy@renesas.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <b35a8ac6-af47-5851-95ae-371288bb5f25@rock-chips.com>
Date: Tue, 27 Feb 2018 22:27:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519739731-27920-1-git-send-email-phil.edworthy@renesas.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2018/2/27 21:55, Phil Edworthy Ð´µÀ:
> Since the controller does not support the end-of-busy IRQ, don't use it.
> Otherwise, on older SD cards you will get lots of these messages:
> "mmc0: Got data interrupt 0x00000002 even though no data operation was in progress"
> 

I'm afraid you have to explain which version of arasan's IP suffer from
this and what does the "older SD cards" mean?

> This has been reported on Xilinx devices that also use the Arasan IP.
> See https://patchwork.kernel.org/patch/8062871/
> 
> This has been tested on the Renesas RZ/ND-DB board with the RZ/N1 SoC.
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---
>   drivers/mmc/host/sdhci-of-arasan.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index c33a5f7..ab66e32 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -290,7 +290,8 @@ static const struct sdhci_pltfm_data sdhci_arasan_pdata = {
>   	.ops = &sdhci_arasan_ops,
>   	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
>   	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> -			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
> +			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN |
> +			SDHCI_QUIRK2_STOP_WITH_TC,
>   };
>   
>   static u32 sdhci_arasan_cqhci_irq(struct sdhci_host *host, u32 intmask)
> 


-- 
Best Regards
Shawn Lin
