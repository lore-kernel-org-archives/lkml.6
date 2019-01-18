Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FA6C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F173C2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SKVm8Z9y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbfARKyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 05:54:20 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33622 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfARKyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 05:54:19 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0IAs963128711;
        Fri, 18 Jan 2019 04:54:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547808849;
        bh=uxwF+mlc5LfCizp/QX1dZ87dksbq7KcoOrWHWxlyCI4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=SKVm8Z9yNjFrxslo0wjlD4771Tn26V62f06E6HqO5C2Z36jVpv13clP018jBd3DU4
         IMx++dyfbB9pvO5zhGKTyxhkFLYFpQhnlJl98twlYaUocx971u76C0NAX/DEUjE+bx
         iFEZMkNMMwU0SFQ8YDdCJfT8jFdXjucNC72nIZAo=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0IAs9Ep085863
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Jan 2019 04:54:09 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 18
 Jan 2019 04:54:08 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 18 Jan 2019 04:54:08 -0600
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0IAs471010119;
        Fri, 18 Jan 2019 04:54:05 -0600
Subject: Re: [PATCH 2/3] mmc: sdhci-omap: drop ->get_ro() implementation
To:     Tony Lindgren <tony@atomide.com>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        <linux-omap@vger.kernel.org>
References: <20190115162837.5399-1-thomas.petazzoni@bootlin.com>
 <20190115162837.5399-3-thomas.petazzoni@bootlin.com>
 <20190116132747.GB11050@ulmo> <20190116154717.GQ5544@atomide.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <fab3147f-10e3-51b0-6f58-a1aff751f4be@ti.com>
Date:   Fri, 18 Jan 2019 16:27:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190116154717.GQ5544@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tony,

On 16/01/19 9:17 PM, Tony Lindgren wrote:
> * Thierry Reding <thierry.reding@gmail.com> [190116 13:28]:
>> On Tue, Jan 15, 2019 at 05:28:36PM +0100, Thomas Petazzoni wrote:
>>> The SDHCI core is know properly checking for the state of a WP GPIO,
>>
>> "know" -> "now"
>>
>>> so there is no longer any need for the sdhci-omap code to implement
>>> ->get_ro() using mmc_gpio_get_ro().
>>>
>>> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
>>> ---
>>> Note: this patch has only been compiled tested, as I don't have the
>>> hardware to test it.
>>> ---
>>>  drivers/mmc/host/sdhci-omap.c | 1 -
>>>  1 file changed, 1 deletion(-)
>>
>> I can't runtime test this myself, but it certainly looks like this would
>> do the right thing because it calls the core now call the very same
>> function as this used to, so:
>>
>> Reviewed-by: Thierry Reding <treding@nvidia.com>
>>
>> Adding Tony and linux-omap for a slightly wider audience and hopefully
>> find someone to test this on. For reference, the whole series is here:
>>
>> 	https://patchwork.kernel.org/project/linux-mmc/list/?series=66905
> 
> Thanks Kishon can you please review and test?
> 

I can help with testing once Thomas posts a v2.

Thanks,
Faiz
