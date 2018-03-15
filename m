Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752344AbeCOO2O (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 10:28:14 -0400
Received: from mga03.intel.com ([134.134.136.65]:4784 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752348AbeCOO2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 10:28:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,311,1517904000";
   d="scan'208";a="211602943"
Subject: Re: [PATCH v3 04/11] mmc: sdhci-omap: Invoke sdhci_get_of_property to
 read sdhci dt properties
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180307132020.30951-1-kishon@ti.com>
 <20180307132020.30951-5-kishon@ti.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <e7c61727-0ff5-edb5-b3eb-679f07afbce6@intel.com>
Date: Thu, 15 Mar 2018 16:27:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180307132020.30951-5-kishon@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/18 15:20, Kishon Vijay Abraham I wrote:
> Invoke sdhci_get_of_property defined in sdhci-pltfm.c to read
> sdhci specific properties from dt node.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-omap.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> index fbc20a4fbb23..314dbe4d7412 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -893,6 +893,7 @@ static int sdhci_omap_probe(struct platform_device *pdev)
>  	host->ioaddr += offset;
>  
>  	mmc = host->mmc;
> +	sdhci_get_of_property(pdev);
>  	ret = mmc_of_parse(mmc);
>  	if (ret)
>  		goto err_pltfm_free;
> 
