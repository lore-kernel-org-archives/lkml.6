Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D796C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 055B12084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="XE9Niigp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 055B12084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbeLLLrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 06:47:40 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:18241 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbeLLLrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 06:47:39 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c10f5560000>; Wed, 12 Dec 2018 03:47:34 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 12 Dec 2018 03:47:38 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 12 Dec 2018 03:47:38 -0800
Received: from [10.26.11.199] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 12 Dec
 2018 11:47:34 +0000
Subject: Re: [PATCH] clk: tegra: fix SMP build
To:     Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Aapo Vienamo <avienamo@nvidia.com>,
        <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20181211143528.2024488-1-arnd@arndb.de>
 <154454887151.17204.5632248748272979028@swboyd.mtv.corp.google.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <20c5f3a9-fd82-5634-6a1e-6384c0facece@nvidia.com>
Date:   Wed, 12 Dec 2018 11:47:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <154454887151.17204.5632248748272979028@swboyd.mtv.corp.google.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1544615254; bh=+MIv/BZcVU873C65h89WGXJait3LU79oeDSUfygH4cQ=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=XE9NiigpUCyozfQmTILT5H5Y+kyEK/p4txt1JAi84I2RgudiTV2uAFaIqYw4ZBtOA
         XIuoqVpAkalgQbTy53l5GUG183T9yKWo5BYYokoW5EjfX3oidXg5yT8mb1F/P1AbYl
         Ux38fm0pQU++lc5u4eZc6MizeUFjX0t+m5v68ECsIj6+0h/ZfZRZb2ewZhbPgVApR8
         +yHfZ/Iy45bHCbDdxm2Vn0meWRBzzQW0waVQAK9JolBJMc+HWUtoMpBAIPYPzj1MBq
         8LHGhydVcC6FuZb267Dn8i8m2pS8fzBQ+hjok999veaqrkZYdun4Bbid75y4zV6DTR
         725qZz3Yv944A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/12/2018 17:21, Stephen Boyd wrote:
> Quoting Arnd Bergmann (2018-12-11 06:35:07)
>> When CONFIG_SMP is disabled, the tegra clk driver now fails to build:
>>
>> drivers/clk/tegra/clk-tegra30.c: In function 'tegra30_cpu_rail_off_ready':
>> drivers/clk/tegra/clk-tegra30.c:1151:19: error: implicit declaration of function 'tegra_pmc_cpu_is_powered'; did you mean 'tegra_powergate_is_powered'? [-Werror=implicit-function-declaration]
>>   cpu_pwr_status = tegra_pmc_cpu_is_powered(1) ||
>>
>> I don't know if tegra works without CONFIG_SMP, but we can get it to
>> build by making the calls conditional, and removing the pointless
>> ifdef around the declaration. The assumption now is that in a
>> non-SMP system, the secondary CPUs are always disabled.
>>
>> Fixes: 61866523ed6e ("clk: tegra30: Use Tegra CPU powergate helper function")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>> Not sure if this is the best solution. If you think it's not, please
>> submit a different fix.
> 
> Hmm.. Is there any reason why the implementation of
> tegra_pmc_cpu_is_powered() is under an ifdef CONFIG_SMP? I'd rather not
> have to think about SMP or not in this clk code and have the
> tegra_pmc_cpu_is_powered() function do the UP vs SMP code optimization.

Not that I know of. I just think that the function should/would not be
used for non-SMP.

I was actually thinking that we could just leave the clk code as it is
and simply drop the CONFIG_SMP from pmc.h. That would be fine with me.

Cheers
Jon

-- 
nvpublic
