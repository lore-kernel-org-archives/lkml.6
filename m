Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2C2C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A45E920660
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbfANId3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 03:33:29 -0500
Received: from mga05.intel.com ([192.55.52.43]:31624 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbfANId2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 03:33:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2019 00:33:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,477,1539673200"; 
   d="scan'208";a="125839396"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.56]) ([10.237.72.56])
  by orsmga002.jf.intel.com with ESMTP; 14 Jan 2019 00:33:24 -0800
Subject: Re: [PATCH] mmc: Fix Kconfig warnings on keystone_defconfig
To:     Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, j-keerthy@ti.com, edubezval@gmail.com,
        olof@lixom.net
References: <20190109124312.10154-1-faiz_abbas@ti.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <d6e57ce6-680c-4264-435c-8699fa704526@intel.com>
Date:   Mon, 14 Jan 2019 10:31:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190109124312.10154-1-faiz_abbas@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/01/19 2:43 PM, Faiz Abbas wrote:
> Commit 961de0a856e3 ("mmc: sdhci-omap: Workaround errata regarding
> SDR104/HS200 tuning failures (i929)") added a select on TI_SOC_THERMAL
> for the driver to get temperature for tuning.
> 
> However, this causes the following warning on keystone_defconfig because
> keystone does not support TI_SOC_THERMAL:
> 
> "WARNING: unmet direct dependencies detected for TI_SOC_THERMAL"
> 
> Fix this by changing the select to imply.
> 
> Fixes: 961de0a856e3 ("mmc: sdhci-omap: Workaround errata regarding
> SDR104/HS200 tuning failures (i929)")
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index e26b8145efb3..bc61eefcb695 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -978,7 +978,7 @@ config MMC_SDHCI_OMAP
>  	tristate "TI SDHCI Controller Support"
>  	depends on MMC_SDHCI_PLTFM && OF
>  	select THERMAL
> -	select TI_SOC_THERMAL
> +	imply TI_SOC_THERMAL
>  	help
>  	  This selects the Secure Digital Host Controller Interface (SDHCI)
>  	  support present in TI's DRA7 SOCs. The controller supports
> 

