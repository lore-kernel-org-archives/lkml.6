Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2089BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 05:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5444206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 05:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NDF3CB/q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5444206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731339AbeKTP1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 10:27:42 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:53582 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbeKTP1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 10:27:41 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAK50SwU121550;
        Mon, 19 Nov 2018 23:00:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542690028;
        bh=D54QJBSckR4RrGMiVjH7GnEKKcfSUn/wpn8NGIuUSkU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=NDF3CB/qxPa/YKgBDWbgm0fZMtZcDrdUcMQk4+rqOGG93beqZxZX/ogoxl9cz8b0W
         xqHxJKQe3mNM4pLR6i2i5s3n/xvyNnrsu9MIIvXwBrDKFzB0sKVEnHO8dvo6z6jMym
         68TvJjM66/fJEsUDdFiFZM3Nn8IQ2noen/ENlZd0=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAK50S4D050832
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Nov 2018 23:00:28 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 19
 Nov 2018 23:00:28 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 19 Nov 2018 23:00:28 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAK50QQL023514;
        Mon, 19 Nov 2018 23:00:26 -0600
Subject: Re: [PATCH 3/4] mmc: sdhci-omap: Add platform specific reset callback
To:     Faiz Abbas <faiz_abbas@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>
References: <20181119111618.2745-1-faiz_abbas@ti.com>
 <20181119111618.2745-4-faiz_abbas@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <04c28877-7705-ce7e-cb73-67d202174741@ti.com>
Date:   Tue, 20 Nov 2018 10:30:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181119111618.2745-4-faiz_abbas@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/11/18 4:46 PM, Faiz Abbas wrote:
> The TRM (SPRUIC2C - January 2017 - Revised May 2018 [1]) forbids
> assertion of data reset while tuning is happening. Implement a
> platform specific callback that takes care of this condition.
> 
> [1] http://www.ti.com/lit/pdf/spruic2 Section 25.5.1.2.4
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>

Once patch 2 is merged with this patch, you can add
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>   drivers/mmc/host/sdhci-omap.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> index cfffcf58be3f..bf268b38ddc8 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -688,6 +688,18 @@ static void sdhci_omap_set_uhs_signaling(struct sdhci_host *host,
>   	sdhci_omap_start_clock(omap_host);
>   }
>   
> +void sdhci_omap_reset(struct sdhci_host *host, u8 mask)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
> +
> +	/* Don't reset data lines during tuning operation */
> +	if (omap_host->is_tuning)
> +		mask &= ~SDHCI_RESET_DATA;
> +
> +	sdhci_reset(host, mask);
> +}
> +
>   static struct sdhci_ops sdhci_omap_ops = {
>   	.set_clock = sdhci_omap_set_clock,
>   	.set_power = sdhci_omap_set_power,
> @@ -696,7 +708,7 @@ static struct sdhci_ops sdhci_omap_ops = {
>   	.get_min_clock = sdhci_omap_get_min_clock,
>   	.set_bus_width = sdhci_omap_set_bus_width,
>   	.platform_send_init_74_clocks = sdhci_omap_init_74_clocks,
> -	.reset = sdhci_reset,
> +	.reset = sdhci_omap_reset,
>   	.set_uhs_signaling = sdhci_omap_set_uhs_signaling,
>   };
>   
> 
