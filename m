Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB7FC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 07:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA542054F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 07:37:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACA542054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbeLNHhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 02:37:46 -0500
Received: from mga01.intel.com ([192.55.52.88]:57729 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbeLNHhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 02:37:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Dec 2018 23:37:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,352,1539673200"; 
   d="scan'208";a="110321904"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.130]) ([10.237.72.130])
  by orsmga003.jf.intel.com with ESMTP; 13 Dec 2018 23:37:43 -0800
Subject: Re: [PATCH V1] mmc: tegra: Fix for SDMMC pads autocal parsing from dt
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1544732743-11106-1-git-send-email-skomatineni@nvidia.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <79cc4735-b2c6-b0f7-b661-df5ff15e74e7@intel.com>
Date:   Fri, 14 Dec 2018 09:36:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1544732743-11106-1-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/12/18 10:25 PM, Sowjanya Komatineni wrote:
> Some of the SDMMC pads auto calibration values parsed from
> devicetree are assigned incorrectly. This patch fixes it.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-tegra.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 7b95d088fdef..e6ace31e2a41 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -510,25 +510,25 @@ static void tegra_sdhci_parse_pad_autocal_dt(struct sdhci_host *host)
>  
>  	err = device_property_read_u32(host->mmc->parent,
>  			"nvidia,pad-autocal-pull-up-offset-3v3-timeout",
> -			&autocal->pull_up_3v3);
> +			&autocal->pull_up_3v3_timeout);
>  	if (err)
>  		autocal->pull_up_3v3_timeout = 0;
>  
>  	err = device_property_read_u32(host->mmc->parent,
>  			"nvidia,pad-autocal-pull-down-offset-3v3-timeout",
> -			&autocal->pull_down_3v3);
> +			&autocal->pull_down_3v3_timeout);
>  	if (err)
>  		autocal->pull_down_3v3_timeout = 0;
>  
>  	err = device_property_read_u32(host->mmc->parent,
>  			"nvidia,pad-autocal-pull-up-offset-1v8-timeout",
> -			&autocal->pull_up_1v8);
> +			&autocal->pull_up_1v8_timeout);
>  	if (err)
>  		autocal->pull_up_1v8_timeout = 0;
>  
>  	err = device_property_read_u32(host->mmc->parent,
>  			"nvidia,pad-autocal-pull-down-offset-1v8-timeout",
> -			&autocal->pull_down_1v8);
> +			&autocal->pull_down_1v8_timeout);
>  	if (err)
>  		autocal->pull_down_1v8_timeout = 0;
>  
> 

