Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2974FC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDEE420821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YhubCNfb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDEE420821
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbeLJMB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 07:01:59 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39018 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbeLJMB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 07:01:59 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBAC1arI059664;
        Mon, 10 Dec 2018 06:01:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1544443296;
        bh=BXSauysFtSHnUqgxpsB1VhuLgfyEVffNcruP+e9gkxI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=YhubCNfbyD1LX6Gt+wYdzYEEqgeP8eq59x8ogkEHljSdyEtlQZFJ+VnttMRbANDlG
         ln1AmbX3MQnsAhY6KZJ/bijVuq11cmYHXzPxRVF7AB9Uhu92sZWyDJHyVaYjW/cjXo
         08zK4BTRIGFz+fAO0Mlm7tJPndssmZd5Kvbwv5dg=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBAC1atT050620
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Dec 2018 06:01:36 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 10
 Dec 2018 06:01:36 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 10 Dec 2018 06:01:36 -0600
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBAC1WIF025102;
        Mon, 10 Dec 2018 06:01:33 -0600
Subject: Re: [PATCH 3/3] mmc: sdhci_am654: Add Initial Support for AM654 SDHCI
 driver
To:     Adrian Hunter <adrian.hunter@intel.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>, <kishon@ti.com>
References: <20181129161513.31734-1-faiz_abbas@ti.com>
 <20181129161513.31734-4-faiz_abbas@ti.com>
 <2618ec91-09d1-26f3-361e-34a073b1e5ea@intel.com>
 <dfe6c97a-6383-c697-88e5-279f6ca8136e@ti.com>
 <970c3531-5d7d-fe94-55c1-13603735b43a@intel.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <94794998-2c22-1b7f-946c-7887116ee55b@ti.com>
Date:   Mon, 10 Dec 2018 17:34:20 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <970c3531-5d7d-fe94-55c1-13603735b43a@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On 07/12/18 7:02 PM, Adrian Hunter wrote:
> On 5/12/18 5:07 PM, Faiz Abbas wrote:
>> Hi Adrian,
>>
>> On 05/12/18 7:12 PM, Adrian Hunter wrote:
>>> On 29/11/18 6:15 PM, Faiz Abbas wrote:
>>>> The host controllers on TI's AM654 SOCs are not compatible with
>>>> the phy and consumer model of the sdhci-of-arasan driver. It turns out
>>>> that for optimal operation at higher speeds, a special tuning procedure
>>>> needs to be implemented which involves configuration of platform
>>>> specific phy registers.
>>>>
>>>> Therefore, branch out to a new sdhci_am654 driver and add the phy
>>>> register space with all phy configurations to it. Populate AM654
>>>> specific callbacks to sdhci_ops and add SDHCI_QUIRKS wherever
>>>> applicable.
>>>>
>>>> Only add support for upto High Speed for SD card and upto DDR52 speed
>>>> mode for eMMC. Higher speeds will be added in subsequent patches.
>>>>
...
>>>> +
>>>> +	sdhci_am654->clk_ahb = devm_clk_get(dev, "clk_ahb");
>>>> +	if (IS_ERR(sdhci_am654->clk_ahb)) {
>>>> +		dev_err(dev, "clk_ahb clock not found.\n");
>>>> +		ret = PTR_ERR(sdhci_am654->clk_ahb);
>>>> +		goto err_pltfm_free;
>>>> +	}
>>>
>>> Did you intend not to enable clks?
>>
>> Yes. Clocks get enabled as a part of pm_runtime calls.
> 
> Ok, but that could use an explanatory comment.  Also why get a reference to
> clk_ahb if that reference is never used?
> 

You're right. It was being used in sdhci-of-arasan because other users
needed to call enable() and disable(). I missed out on removing it when
porting over. Will remove it and add the comment.

Thanks,
Faiz
