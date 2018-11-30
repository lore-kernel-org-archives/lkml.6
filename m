Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056D7C04EB9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 02:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B68982086B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 02:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="FH6K+/Zk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B68982086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbeK3OAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 09:00:31 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:11381 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbeK3OAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 09:00:30 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c00a6040000>; Thu, 29 Nov 2018 18:52:52 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 29 Nov 2018 18:52:47 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 29 Nov 2018 18:52:47 -0800
Received: from [10.19.225.182] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 30 Nov
 2018 02:52:44 +0000
Subject: Re: [PATCH v4 1/3] thermal: tegra: remove unnecessary warnings
To:     Eduardo Valentin <edubezval@gmail.com>
CC:     <thierry.reding@gmail.com>, <daniel.lezcano@linaro.org>,
        <linux-tegra@vger.kernel.org>, <rui.zhang@intel.com>,
        <srikars@nvidia.com>, <linux-kernel@vger.kernel.org>
References: <1543486183-2868-1-git-send-email-wni@nvidia.com>
 <1543486183-2868-2-git-send-email-wni@nvidia.com>
 <20181129163938.GA2045@localhost.localdomain>
From:   Wei Ni <wni@nvidia.com>
Message-ID: <380eb5fc-ed94-db87-9118-2fa8133d9c78@nvidia.com>
Date:   Fri, 30 Nov 2018 10:52:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181129163938.GA2045@localhost.localdomain>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1543546372; bh=xCs+zfARQlZ33YKrbYyDAY6a/EEBJFZxnDMf+Qb3cMg=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=FH6K+/Zksuv+V+1rc6PPQMGwl2Rlbz5mn68QgOvUNcLRpSJBv2vjwl/9iOzJr3a6p
         Kuz/0J6fbYgtasqNFObIPiUvnlrsqOZgeG5JqJbXQzsX5pMw6GrCo9bTQEuTnmj0M7
         Zw5JWtG3wgdgRoAK3+dQ9K5w/PAKLYJUNy6fEb04/DbHcVA6B4DQlkZ9L5kEx1JORq
         dNsJ5eK3Wl/uxaBCeBlbdksYLiqRLY591+0YI9vrEDeXawKWki7/ass0gYGqUcCKTr
         IMYqZho3OZDYqauix2e74xk7YSHSNISFI+8yoMFAGFaK+YpqfF3Pfg4M5Dor50Lw+q
         LgPYfVqufnOlA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/11/2018 12:39 AM, Eduardo Valentin wrote:
> Hey,
> 
> On Thu, Nov 29, 2018 at 06:09:41PM +0800, Wei Ni wrote:
>> Convert warnings to info as not all platforms may
>> have all the thresholds and sensors enabled.
>>
>> Signed-off-by: Wei Ni <wni@nvidia.com>
>> ---
>>  drivers/thermal/tegra/soctherm.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
>> index ed28110a3535..55cc1f2f6a45 100644
>> --- a/drivers/thermal/tegra/soctherm.c
>> +++ b/drivers/thermal/tegra/soctherm.c
>> @@ -550,7 +550,7 @@ static int tegra_soctherm_set_hwtrips(struct device *dev,
>>  
>>  	ret = tz->ops->get_crit_temp(tz, &temperature);
>>  	if (ret) {
>> -		dev_warn(dev, "thermtrip: %s: missing critical temperature\n",
>> +		dev_info(dev, "thermtrip: %s: missing critical temperature\n",
> 
> I am mostly ok with your change in direction. But are you sure this is a
> good thing? What about in the case that you have a platform that have
> the crit temp and you really failed to .get_crit_temp()?

If we set the crit temp in DT, but failed to .get_crit_temp(), it mean
the thermal framework have some problems. Since the critical trip is
very important, may be we should still keep "dev_warn" in here?

> 
>>  			 sg->name);
>>  		goto set_throttle;
>>  	}
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
>> -- 
>> 2.7.4
>>
