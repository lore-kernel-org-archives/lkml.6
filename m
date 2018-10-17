Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F025ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5B012151D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="jI2OU/q2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5B012151D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbeJQRtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 13:49:32 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17262 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbeJQRtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 13:49:32 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bc706d90000>; Wed, 17 Oct 2018 02:54:33 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 17 Oct 2018 02:54:37 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 17 Oct 2018 02:54:37 -0700
Received: from [10.26.11.110] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 17 Oct
 2018 09:54:33 +0000
Subject: Re: [PATCH v1 3/5] ARM: tegra: Create tegra20-cpufreq device on
 Tegra30
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20180830194356.14059-1-digetx@gmail.com>
 <20180830194356.14059-4-digetx@gmail.com>
 <9ec51c2d-02f6-0988-0940-0ec31d22f697@nvidia.com>
Message-ID: <65532de7-2768-0d99-33a9-5b43cfbf510c@nvidia.com>
Date:   Wed, 17 Oct 2018 10:54:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <9ec51c2d-02f6-0988-0940-0ec31d22f697@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1539770073; bh=Ek5uwfjJJydXTstdQNhl42aY1ck+tR/v4kY9CGRCioU=;
        h=X-PGP-Universal:Subject:From:To:CC:References:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=jI2OU/q2j2hrCVU1u/OQIGYcFAhgHojQu4t7pKGNZeG8+ILMusIsySd/B2im1SS1b
         Qp8wZkZIeIzTh8m9rVWnUojtBjqdRvGLF3Bccuay2fMXPRU9KxL2cgtyfer9M1YczI
         Saq/AehsOuZ4goJP7Mi19X88CXNvDJQxaYNv9zdr0KM0vRzbvwPGvON/eAFyuVKvJO
         /7QbKs+8Iqnrc6DY11VK5eIqqAXdItAMfGMB3Zur/YHwvAr3XKTnQvgvDQKg0+ZmLC
         xXsSvchuqAOVO7zJJduvciuUZAtIPm5lnHn4xO+OE0Y7UAKyD92jpzEupZxX7XYmtQ
         YrzVKdF+7rRVg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 17/10/2018 09:49, Jon Hunter wrote:
> 
> On 30/08/2018 20:43, Dmitry Osipenko wrote:
>> Tegra20-cpufreq driver require a platform device in order to be loaded,
>> instantiate a simple platform device for the driver during of the machines
>> late initialization. Driver now supports Tegra30 SoC's, hence create the
>> device on Tegra30 machines.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  arch/arm/mach-tegra/tegra.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
>> index 67d8ae60ac67..b559e22eab76 100644
>> --- a/arch/arm/mach-tegra/tegra.c
>> +++ b/arch/arm/mach-tegra/tegra.c
>> @@ -111,6 +111,10 @@ static void __init tegra_dt_init_late(void)
>>  	if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC) &&
>>  	    of_machine_is_compatible("nvidia,tegra20"))
>>  		platform_device_register_simple("tegra20-cpufreq", -1, NULL, 0);
>> +
>> +	if (IS_ENABLED(CONFIG_ARCH_TEGRA_3x_SOC) &&
>> +	    of_machine_is_compatible("nvidia,tegra30"))
>> +		platform_device_register_simple("tegra20-cpufreq", -1, NULL, 0);
>>  }
>>  
>>  static const char * const tegra_dt_board_compat[] = {
> 
> Not sure why you would do this if now the driver only works with DT. Am
> I missing something?

Actually, not sure why we just don't move this into the actual driver
itself like we have for tegra124.

Cheers
Jon

-- 
nvpublic
