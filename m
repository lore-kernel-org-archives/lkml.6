Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70913ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 12:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B612150D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 12:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDx8nk8u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35B612150D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbeJQT6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 15:58:00 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38654 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeJQT6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 15:58:00 -0400
Received: by mail-lf1-f67.google.com with SMTP id x24-v6so3824313lfe.5;
        Wed, 17 Oct 2018 05:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yQzDSHv7NYm/YgVp0WZHnel5L0ZI8R6eW8jHFCFcx9M=;
        b=YDx8nk8uO8yBffkeLnezDAlMiTe9egafjepmd06GF/bmhvhUT1q4GEZc6kih8vDj0y
         rmGPee8rPH2BpqcXECF0xjOQMN2E2zIVuVvJK6c5WEeIe8CeYs7oM2WYRgI1oRVPp1Pu
         0/h5/TMvJoC7bnoVBfmF5EC8ZeupKUVL0qoPCYcJwRm3i/ThN4M8u72XCmaKBPQ8OMgA
         WpMLMRq44/h7Fvzn7wSJncSVCnWNx9nUMx+hD5cqsT+9FKf0wQ5KHJHi7aJqcyFuT4nV
         zH+uYotpSjdjdba0RSITZ9mdEdGh2KoauYIp++BTf9tVvEWjddIOqqCwOvM51lSP2N8p
         YtgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yQzDSHv7NYm/YgVp0WZHnel5L0ZI8R6eW8jHFCFcx9M=;
        b=MHB22mkQji+TO+/hb7OFLVki2m6TGv/o/OGcdaGOYEGxKuaDqtf4NPpcKOr/t3u+Fj
         HDRZiP50I2fIcPNegn1y29RiIdMuq/SH0MGdywiO0qQo3at7A4dZ6kzHy3LSfNsTHMo3
         4v7N5WWa4J15+rdsdQ9ne5M6X3u1cMdbeQJ1ugDJwrhBHk9sZ/XAonDA0uQF05nUqkrL
         +oif2vhAv+uw6Nv6S3d3Lb00rc+5DSAvEL1UR5IOhyBSdoeZEMbPQiGJVmJkyYMdYUM5
         6jhNgVQ37aJYlyWZhT9CmmA4xkBp8hpcF98loSyKc7a4JyI5nM13r09Mf9oMRtZ5DcG4
         5yqA==
X-Gm-Message-State: ABuFfojMgp93vTIwQnpSthAOJ/qwN6QUzmrp0yl2OfqHQ45lbDabSe3T
        voMo+UcmsLWcz11pCDryRzKjmj6E
X-Google-Smtp-Source: ACcGV63PXtwp+5bLT8N6kk+9Djw1ZfBUax8SJTUuZwq9fUKOf4/sPgRu5PekZ40MM1EledX5He+BlA==
X-Received: by 2002:a19:9c94:: with SMTP id f142-v6mr5585983lfe.76.1539777754177;
        Wed, 17 Oct 2018 05:02:34 -0700 (PDT)
Received: from [192.168.2.145] ([109.252.91.118])
        by smtp.googlemail.com with ESMTPSA id b132-v6sm3807508lfe.56.2018.10.17.05.02.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 05:02:33 -0700 (PDT)
Subject: Re: [PATCH v1 3/5] ARM: tegra: Create tegra20-cpufreq device on
 Tegra30
To:     Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180830194356.14059-1-digetx@gmail.com>
 <20180830194356.14059-4-digetx@gmail.com>
 <9ec51c2d-02f6-0988-0940-0ec31d22f697@nvidia.com>
 <65532de7-2768-0d99-33a9-5b43cfbf510c@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <45b53cd5-c1e2-d733-38ed-b04531bce65e@gmail.com>
Date:   Wed, 17 Oct 2018 15:02:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <65532de7-2768-0d99-33a9-5b43cfbf510c@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/18 12:54 PM, Jon Hunter wrote:
> 
> On 17/10/2018 09:49, Jon Hunter wrote:
>>
>> On 30/08/2018 20:43, Dmitry Osipenko wrote:
>>> Tegra20-cpufreq driver require a platform device in order to be loaded,
>>> instantiate a simple platform device for the driver during of the machines
>>> late initialization. Driver now supports Tegra30 SoC's, hence create the
>>> device on Tegra30 machines.
>>>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  arch/arm/mach-tegra/tegra.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
>>> index 67d8ae60ac67..b559e22eab76 100644
>>> --- a/arch/arm/mach-tegra/tegra.c
>>> +++ b/arch/arm/mach-tegra/tegra.c
>>> @@ -111,6 +111,10 @@ static void __init tegra_dt_init_late(void)
>>>  	if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC) &&
>>>  	    of_machine_is_compatible("nvidia,tegra20"))
>>>  		platform_device_register_simple("tegra20-cpufreq", -1, NULL, 0);
>>> +
>>> +	if (IS_ENABLED(CONFIG_ARCH_TEGRA_3x_SOC) &&
>>> +	    of_machine_is_compatible("nvidia,tegra30"))
>>> +		platform_device_register_simple("tegra20-cpufreq", -1, NULL, 0);
>>>  }
>>>  
>>>  static const char * const tegra_dt_board_compat[] = {
>>
>> Not sure why you would do this if now the driver only works with DT. Am
>> I missing something?
> 
> Actually, not sure why we just don't move this into the actual driver
> itself like we have for tegra124.

Tegra124 has specific HW for the CPUFreq, T20/30 do not. Hence on T20/30 CPUFreq control is implemented purely in software and there is no real HW device for the driver.
