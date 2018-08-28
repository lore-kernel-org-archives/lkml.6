Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49321C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0356520846
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:01:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0356520846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbeH1LwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 07:52:05 -0400
Received: from mga14.intel.com ([192.55.52.115]:37605 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbeH1LwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 07:52:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2018 01:01:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,298,1531810800"; 
   d="scan'208";a="66535671"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.137]) ([10.237.72.137])
  by fmsmga008.fm.intel.com with ESMTP; 28 Aug 2018 01:01:37 -0700
Subject: Re: [PATCH] mmc: Convert to using %pOFn instead of device_node.name
To:     Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Hu Ziji <huziji@marvell.com>, Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-32-robh@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <b64da243-c049-31aa-625c-e9e4d751b213@intel.com>
Date:   Tue, 28 Aug 2018 10:59:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180828015252.28511-32-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/18 04:52, Rob Herring wrote:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Hu Ziji <huziji@marvell.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-xenon-phy.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-xenon-phy.c b/drivers/mmc/host/sdhci-xenon-phy.c
> index c335052d0c02..5956e90380e8 100644
> --- a/drivers/mmc/host/sdhci-xenon-phy.c
> +++ b/drivers/mmc/host/sdhci-xenon-phy.c
> @@ -660,8 +660,8 @@ static int get_dt_pad_ctrl_data(struct sdhci_host *host,
>  		return 0;
>  
>  	if (of_address_to_resource(np, 1, &iomem)) {
> -		dev_err(mmc_dev(host->mmc), "Unable to find SoC PAD ctrl register address for %s\n",
> -			np->name);
> +		dev_err(mmc_dev(host->mmc), "Unable to find SoC PAD ctrl register address for %pOFn\n",
> +			np);
>  		return -EINVAL;
>  	}
>  
> 

