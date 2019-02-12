Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E81CC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 238392083B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbfBLIM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 03:12:58 -0500
Received: from mga09.intel.com ([134.134.136.24]:23624 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbfBLIM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 03:12:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2019 00:12:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,361,1544515200"; 
   d="scan'208";a="137909928"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.56]) ([10.237.72.56])
  by orsmga001.jf.intel.com with ESMTP; 12 Feb 2019 00:12:54 -0800
Subject: Re: [PATCH v2 2/3] mmc: sdhci-omap: drop ->get_ro() implementation
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, Faiz Abbas <faiz_abbas@ti.com>,
        Thierry Reding <treding@nvidia.com>
References: <20190211132342.31009-1-thomas.petazzoni@bootlin.com>
 <20190211132342.31009-3-thomas.petazzoni@bootlin.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <0af919d0-3a35-7aa1-bdd1-4d42128809c9@intel.com>
Date:   Tue, 12 Feb 2019 10:11:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190211132342.31009-3-thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02/19 3:23 PM, Thomas Petazzoni wrote:
> The SDHCI core is now properly checking for the state of a WP GPIO,
> so there is no longer any need for the sdhci-omap code to implement
> ->get_ro() using mmc_gpio_get_ro().
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> Reviewed-by: Thierry Reding <treding@nvidia.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Changes since v1:
> - Added Reviewed-by from Thierry Reding
> - Fix typo in commit log s/know/now/ noticed by Thierry Reding
> 
> Note: this patch has only been compiled tested, as I don't have the
> hardware to test it.
> ---
>  drivers/mmc/host/sdhci-omap.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> index d264391616f9..c2a28930086f 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -987,7 +987,6 @@ static int sdhci_omap_probe(struct platform_device *pdev)
>  		goto err_put_sync;
>  	}
>  
> -	host->mmc_host_ops.get_ro = mmc_gpio_get_ro;
>  	host->mmc_host_ops.start_signal_voltage_switch =
>  					sdhci_omap_start_signal_voltage_switch;
>  	host->mmc_host_ops.set_ios = sdhci_omap_set_ios;
> 

