Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B87C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94F8A218AD
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hhg0i37S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbfBLIOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 03:14:19 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45924 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbfBLIOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 03:14:18 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1C8EBBu015861;
        Tue, 12 Feb 2019 02:14:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549959252;
        bh=MVTG7QM5FBT0KG9DVDOD1pKJpK2Xfk1G7FZv/SMemrQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=hhg0i37S3qeqb3i3xFYTlxop81QOLy7dN6NDX/1qP/vWKqAPcl9y/v6pwNXgf67hJ
         4EsRjeSDU+EvLIkIqDN8Ddj/LpFRditHm4g1Kn0rUdwo9EveRnzfe7uO76EfLVTzeR
         O1j3L6J07/mU/7gxgEHb4QfWCzn6wlMwjTAFKOcA=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1C8EBTP116653
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Feb 2019 02:14:11 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 12
 Feb 2019 02:14:11 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 12 Feb 2019 02:14:11 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1C8E7jN007149;
        Tue, 12 Feb 2019 02:14:08 -0600
Subject: Re: [PATCH v2 2/3] mmc: sdhci-omap: drop ->get_ro() implementation
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, Faiz Abbas <faiz_abbas@ti.com>,
        Thierry Reding <treding@nvidia.com>
References: <20190211132342.31009-1-thomas.petazzoni@bootlin.com>
 <20190211132342.31009-3-thomas.petazzoni@bootlin.com>
 <0af919d0-3a35-7aa1-bdd1-4d42128809c9@intel.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <2f0ccc6c-9d35-ccf1-7587-7ad0ebfe6e97@ti.com>
Date:   Tue, 12 Feb 2019 13:43:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <0af919d0-3a35-7aa1-bdd1-4d42128809c9@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/02/19 1:41 PM, Adrian Hunter wrote:
> On 11/02/19 3:23 PM, Thomas Petazzoni wrote:
>> The SDHCI core is now properly checking for the state of a WP GPIO,
>> so there is no longer any need for the sdhci-omap code to implement
>> ->get_ro() using mmc_gpio_get_ro().
>>
>> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
>> Reviewed-by: Thierry Reding <treding@nvidia.com>
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> 
>> ---
>> Changes since v1:
>> - Added Reviewed-by from Thierry Reding
>> - Fix typo in commit log s/know/now/ noticed by Thierry Reding
>>
>> Note: this patch has only been compiled tested, as I don't have the
>> hardware to test it.
>> ---
>>  drivers/mmc/host/sdhci-omap.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
>> index d264391616f9..c2a28930086f 100644
>> --- a/drivers/mmc/host/sdhci-omap.c
>> +++ b/drivers/mmc/host/sdhci-omap.c
>> @@ -987,7 +987,6 @@ static int sdhci_omap_probe(struct platform_device *pdev)
>>  		goto err_put_sync;
>>  	}
>>  
>> -	host->mmc_host_ops.get_ro = mmc_gpio_get_ro;
>>  	host->mmc_host_ops.start_signal_voltage_switch =
>>  					sdhci_omap_start_signal_voltage_switch;
>>  	host->mmc_host_ops.set_ios = sdhci_omap_set_ios;
>>
> 
