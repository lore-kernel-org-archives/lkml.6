Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932252AbeCOOUP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 10:20:15 -0400
Received: from mga11.intel.com ([192.55.52.93]:32201 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752262AbeCOOUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 10:20:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,311,1517904000";
   d="scan'208";a="211601362"
Subject: Re: [PATCH v3 02/11] mmc: sdhci-omap: Remove setting ADMA capability
 in driver
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180307132020.30951-1-kishon@ti.com>
 <20180307132020.30951-3-kishon@ti.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <a867eebf-2c32-4a0f-713a-766d81d52c4c@intel.com>
Date: Thu, 15 Mar 2018 16:18:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180307132020.30951-3-kishon@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/18 15:20, Kishon Vijay Abraham I wrote:
> sdhci can directly get ADMA capability from MMCHS_CAPA register.
> Remove explicitly setting ADMA here as some instances might not have
> ADMA enabled. (sdhci_read_caps() is also removed from here since
> sdhci_setup_host() invokes it).
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-omap.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> index 3cce30584d2f..0c40b13fb67d 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -923,9 +923,6 @@ static int sdhci_omap_probe(struct platform_device *pdev)
>  	host->mmc_host_ops.card_busy = sdhci_omap_card_busy;
>  	host->mmc_host_ops.execute_tuning = sdhci_omap_execute_tuning;
>  
> -	sdhci_read_caps(host);
> -	host->caps |= SDHCI_CAN_DO_ADMA2;
> -
>  	ret = sdhci_setup_host(host);
>  	if (ret)
>  		goto err_put_sync;
> 
