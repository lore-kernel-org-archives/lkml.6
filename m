Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EEE1C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E926D20652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ZPZIgsWG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E926D20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbeJDWE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 18:04:56 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:4287 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbeJDWE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 18:04:56 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bb62d8f0000>; Thu, 04 Oct 2018 08:11:11 -0700
Received: from HQMAIL108.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 04 Oct 2018 08:11:13 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 04 Oct 2018 08:11:13 -0700
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 4 Oct
 2018 15:11:13 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Thu, 4 Oct 2018 15:11:13 +0000
Received: from [10.21.24.139] (Not Verified[10.21.24.139]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5bb62d8f0000>; Thu, 04 Oct 2018 08:11:13 -0700
Subject: Re: [PATCH] firmware: tegra-bpmp: mark PM function as __maybe_unused
To:     Jonathan Hunter <jonathanh@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     Mikko Perttunen <mperttunen@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20181002212208.2971433-1-arnd@arndb.de>
 <64a99db8-85e4-52ab-d0fa-0faa5bb7187a@nvidia.com>
From:   Timo Alho <talho@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <31707122-ae73-c608-e9f6-c114d6db2b25@nvidia.com>
Date:   Thu, 4 Oct 2018 18:11:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <64a99db8-85e4-52ab-d0fa-0faa5bb7187a@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1538665871; bh=OiTON1WRo9DiGH9Rq4r8FVo6iSx4dvH2kUw39JYHoFw=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:
         Content-Language:Content-Transfer-Encoding;
        b=ZPZIgsWGVk+WUUpHrZUQq2XIRHnh7e4j/zefRNdYhzyZefOZNlENgY4wKubOAIaGZ
         h4X2r5r1sVX5MluB4G4cNxM+nIDnFbz7tm0LveIkEVFMEapXOt7gJMtUJf2uNBVFOd
         cISMe3l8LZ7axX+qnoBsfYI8iM/BPwKK1MCn1lVhUW4pWKF8pV5PAtL8mpcWj9fimJ
         K7vsQ1VAb70B1qPJszy3ff5tslGU1ZmWzqfuBva6gHtFKZmNrUFMYaP1xyufJsCv3w
         ej7KJAxr7+652cbInmZhHsp3+yQhcBRssZLRQlMNIk1t2ON7M33pnHGNts/tMo18JS
         YnpxW48tkIwoQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03.10.2018 11:26, Jonathan Hunter wrote:
> 
> On 02/10/18 22:21, Arnd Bergmann wrote:
>> The newly added tegra_bpmp_resume function is unused when CONFIG_PM
>> is disabled:
>>
>> drivers/firmware/tegra/bpmp.c:847:12: error: 'tegra_bpmp_resume' defined but not used [-Werror=unused-function]
>>   static int tegra_bpmp_resume(struct device *dev)
>>
>> Mark it as __maybe_unused to avoid the warning and let the compiler
>> drop it silently.
>>
>> Fixes: cd40f6ff124c ("firmware: tegra: bpmp: Implement suspend/resume support")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>   drivers/firmware/tegra/bpmp.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/firmware/tegra/bpmp.c b/drivers/firmware/tegra/bpmp.c
>> index 41448ba78be9..a3d5b518c10e 100644
>> --- a/drivers/firmware/tegra/bpmp.c
>> +++ b/drivers/firmware/tegra/bpmp.c
>> @@ -844,7 +844,7 @@ static int tegra_bpmp_probe(struct platform_device *pdev)
>>   	return err;
>>   }
>>   
>> -static int tegra_bpmp_resume(struct device *dev)
>> +static int __maybe_unused tegra_bpmp_resume(struct device *dev)
>>   {
>>   	struct tegra_bpmp *bpmp = dev_get_drvdata(dev);
>>   	unsigned int i;
> 
> Arnd, is this seen with 32-bit ARM configs?
> 
> Timo, does it make sense to make BPMP dependent on ARCH_TEGRA_186_SOC
> and ARCH_TEGRA_194_SOC instead of just ARCH_TEGRA? For 64-bit Tegra we
> have a dependency on PM so this should not be seen for 64-bit Tegra.

Jon, there will be eventually a BPMP driver for ARCH_TEGRA_210_SOC as 
well. So it is probably more appropriate to make BPMP dependent on ARM64 
& ARCH_TEGRA.

-Timo
