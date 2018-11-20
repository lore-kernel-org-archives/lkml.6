Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9625C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 05:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABCDB206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 05:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QllP5UGd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABCDB206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731486AbeKTP2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 10:28:52 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:53728 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbeKTP2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 10:28:52 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAK51eWB122113;
        Mon, 19 Nov 2018 23:01:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542690100;
        bh=2lYP/uwTyofxAigNwqbEnbUqFVpELfXDw0JzvlX0RW4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=QllP5UGdd3Lbe1QXSiI9Bks6yJzVJC593PmYXddNK9+osy4cGWRNzikhlAFa6y6ON
         XYezQxoUWnIAKV283PsPMwiJhZENqduwTo3GQXHVbqOlfU2FTiTIY1jAMxYSvDL095
         2zZNwmfN/GB9JHib0U+nNoCr6j1fgcb9T2ZhdV30=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAK51e2u052036
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Nov 2018 23:01:40 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 19
 Nov 2018 23:01:40 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 19 Nov 2018 23:01:40 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAK51blZ016971;
        Mon, 19 Nov 2018 23:01:38 -0600
Subject: Re: [PATCH 4/4] mmc: sdhci-omap: Remove redundant structure
 assignments
To:     Faiz Abbas <faiz_abbas@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>
References: <20181119111618.2745-1-faiz_abbas@ti.com>
 <20181119111618.2745-5-faiz_abbas@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <e337e772-5581-c225-e1c1-58fa6d285988@ti.com>
Date:   Tue, 20 Nov 2018 10:31:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181119111618.2745-5-faiz_abbas@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/11/18 4:46 PM, Faiz Abbas wrote:
> The sdhci_execute_tuning() function has assignment of
> private pointers multiple times. Remove the redundant assignment.
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>   drivers/mmc/host/sdhci-omap.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> index bf268b38ddc8..b3cb39d0db6f 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -295,10 +295,6 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
>   	int ret = 0;
>   	u32 reg;
>   
> -	pltfm_host = sdhci_priv(host);
> -	omap_host = sdhci_pltfm_priv(pltfm_host);
> -	dev = omap_host->dev;
> -
>   	/* clock tuning is not needed for upto 52MHz */
>   	if (ios->clock <= 52000000)
>   		return 0;
> 
