Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5812FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 02:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25AB12086A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 02:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="jbyAkV/s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbfBSCOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 21:14:22 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:15361 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbfBSCOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 21:14:21 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c6b66830000>; Mon, 18 Feb 2019 18:14:28 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 18 Feb 2019 18:14:21 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 18 Feb 2019 18:14:21 -0800
Received: from [10.19.225.182] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 19 Feb
 2019 02:14:18 +0000
Subject: Re: [PATCH v7 1/3] thermal: tegra: remove unnecessary warnings
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, <edubezval@gmail.com>
CC:     <thierry.reding@gmail.com>, <linux-tegra@vger.kernel.org>,
        <rui.zhang@intel.com>, <srikars@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <1546510369-28491-1-git-send-email-wni@nvidia.com>
 <1546510369-28491-2-git-send-email-wni@nvidia.com>
 <ec484530-0a07-b725-a376-43c65ca4a723@linaro.org>
From:   Wei Ni <wni@nvidia.com>
Message-ID: <b47037a2-86de-eacd-e9f7-760744783835@nvidia.com>
Date:   Tue, 19 Feb 2019 10:14:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <ec484530-0a07-b725-a376-43c65ca4a723@linaro.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550542468; bh=3oIrpeDb00pQ9aljIM1/KdmPdClyXviTBRjCivau92k=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=jbyAkV/sUte4UvGvKOUHCHTwmOIojVEl4CkQJ9a9/gKyJF0PnY70ZjpvbA1UCN/eH
         Y2jlXQ/3OqltblvdMsRL5dwgy9BqzmFuGHszxLMguhTgGb1E/MFOHBX3SC4chOrfPJ
         hNZdfc5q6DS1ISRTcEnnAyqpUIESRv1I8wl6r8BDHqtfdLWARIZ1BjIETLxc0Ewoar
         H0C2qBBhlsP1E7qg2iFI7ov4Azyxn4HtsZf7IbNITggI7d797jMV/EsPKxYcz7TxWP
         dz2SD7v7cdsIuddhU/3oM4X0rAAmIsD865CUs9mqQQ3M8tMIUAcYhjNxeDkq9O2/5w
         QrOOdaR9uOv2g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/2/2019 5:47 PM, Daniel Lezcano wrote:
> On 03/01/2019 11:12, Wei Ni wrote:
>> Convert warnings to info as not all platforms may
>> have all the thresholds and sensors enabled.
>>
>> Signed-off-by: Wei Ni <wni@nvidia.com>
>> ---
> 
> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Daniel, thank you for your review.
> 
>>  drivers/thermal/tegra/soctherm.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
>> index ed28110a3535..f07de8258e93 100644
>> --- a/drivers/thermal/tegra/soctherm.c
>> +++ b/drivers/thermal/tegra/soctherm.c
>> @@ -569,7 +569,7 @@ static int tegra_soctherm_set_hwtrips(struct device *dev,
>>  set_throttle:
>>  	ret = get_hot_temp(tz, &trip, &temperature);
>>  	if (ret) {
>> -		dev_warn(dev, "throttrip: %s: missing hot temperature\n",
>> +		dev_info(dev, "throttrip: %s: missing hot temperature\n",
>>  			 sg->name);
>>  		return 0;
>>  	}
>> @@ -600,7 +600,7 @@ static int tegra_soctherm_set_hwtrips(struct device *dev,
>>  	}
>>  
>>  	if (i == THROTTLE_SIZE)
>> -		dev_warn(dev, "throttrip: %s: missing throttle cdev\n",
>> +		dev_info(dev, "throttrip: %s: missing throttle cdev\n",
>>  			 sg->name);
>>  
>>  	return 0;
>>
> 
> 
