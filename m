Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26EBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2F9A2080C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lystxf8p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2F9A2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731360AbeKTIfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 03:35:09 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44244 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731273AbeKTIfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 03:35:09 -0500
Received: by mail-lj1-f195.google.com with SMTP id k19-v6so27509170lji.11;
        Mon, 19 Nov 2018 14:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ipXa7Vc/e0hcn/af2fyahPfbdCtUVMRlaoQAaL9VU14=;
        b=lystxf8p/YyLHNAqQB7SodBZLZhdFCnuswyX7oT9LCWTQ35Yn58w/UV8PVWsmNi2x9
         x0JRLZebDzlwzc8mPKXbzjzs4ZwAU0qADOf8J2gS3MOaXieuZF2Dhvn6+jFkKIkw+kXO
         8nej71zb4Etxc/A+524tj31wpSKct4Z6RnECxQWCWBNh5accPqFcMPs4SUryP68yAooO
         +D/vyP11EMpTZELMRDOH8I0ApnO2FJHb6LVqe2JyctIkMr2cORawIE0twSlFZH/xJQOV
         1bG0g6Lfr8g8RnR6f6NbRP3z1rSNOlU5mIQPD7wvbm9tie5e+qtKI1rIGMycd6jIedFc
         EyAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ipXa7Vc/e0hcn/af2fyahPfbdCtUVMRlaoQAaL9VU14=;
        b=sb+/vx5DsPev00p6gRANbicxXIr1oHfyqCLmJNkpwDJWPdJ84Xge8aBWoVLS3ii4FA
         j3N0QrjOwNd+CYE9SlpwcXvDKgwRVnKlUB93XOHYSgYSgkK5MEQTyXmiZq5ZLce60xnF
         N7SCen5RHgyv2vekpobDACbm9YE0GSNhhW+RdCPBpqWmqndwd/rDLpnNXXOvMp6muoL9
         cIGQzr6cBkU0tOQU7McKRrP6R7w2b9zhqn4HAvXcLa8Jv95oi911+feVDC1/MnSmWKIm
         vEC2cWW38r1NuzI98dpBT9Gj/dF4kNqTIpkNV87CLkSqjzF5sKrHnDQFFI0lWb+kzv9G
         jrBg==
X-Gm-Message-State: AGRZ1gJjBGNpkmu2EQiAWJ6J7XSag/VdUsIk8Xgbxh3Qo7qP7lt1KQV9
        v/9RuvQnSrUpM7TkmXcZLL31yfhh
X-Google-Smtp-Source: AFSGD/Ud36VkG/8sjBnFhuHIhfRsmn7DzaiooH793H0zh0PboxWjW00vUk2Z6dsOyxVRu/d09CNSeQ==
X-Received: by 2002:a2e:8643:: with SMTP id i3-v6mr5878417ljj.43.1542665362564;
        Mon, 19 Nov 2018 14:09:22 -0800 (PST)
Received: from [192.168.2.145] (ppp91-76-171-181.pppoe.mtu-net.ru. [91.76.171.181])
        by smtp.googlemail.com with ESMTPSA id h85-v6sm5136826ljf.68.2018.11.19.14.09.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 14:09:21 -0800 (PST)
Subject: Re: [PATCH v1 2/4] ARM: tegra: Fix DRAM refresh-interval clobbering
 on resume from LP1 on Tegra30
To:     Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180830185404.7224-1-digetx@gmail.com>
 <20180830185404.7224-3-digetx@gmail.com>
 <4f61bf5f-0aa8-df6e-109b-194b08f3374e@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <cee4398b-edb8-4c9d-7830-6f52fffd6e1c@gmail.com>
Date:   Tue, 20 Nov 2018 01:09:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <4f61bf5f-0aa8-df6e-109b-194b08f3374e@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.11.2018 0:34, Jon Hunter wrote:
> 
> On 30/08/2018 19:54, Dmitry Osipenko wrote:
>> The DRAM refresh-interval is getting erroneously set to "1" on exiting
>> from memory self-refreshing mode. The clobbered interval causes the
>> "refresh request overflow timeout" error raised by the External Memory
>> Controller on exiting from LP1 on Tegra30.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  arch/arm/mach-tegra/sleep-tegra30.S | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/arch/arm/mach-tegra/sleep-tegra30.S
>> index 801fe58978ae..99ac9c6dcf7c 100644
>> --- a/arch/arm/mach-tegra/sleep-tegra30.S
>> +++ b/arch/arm/mach-tegra/sleep-tegra30.S
>> @@ -29,7 +29,6 @@
>>  #define EMC_CFG				0xc
>>  #define EMC_ADR_CFG			0x10
>>  #define EMC_TIMING_CONTROL		0x28
>> -#define EMC_REFRESH			0x70
>>  #define EMC_NOP				0xdc
>>  #define EMC_SELF_REF			0xe0
>>  #define EMC_MRW				0xe8
>> @@ -459,7 +458,6 @@ emc_wait_auto_cal_onetime:
>>  	cmp	r10, #TEGRA30
>>  	streq	r1, [r0, #EMC_NOP]
>>  	streq	r1, [r0, #EMC_NOP]
>> -	streq	r1, [r0, #EMC_REFRESH]
>>  
>>  	emc_device_mask r1, r0
> 
> This does look incorrect and it appears Tegra20 has the same bug.

Indeed.. somehow this doesn't cause any problems on T20. Maybe this affects only specific timing configurations and it's just a luck that "refresh overflow" isn't getting raised.

> However, looking at the EMC_REFRESH register it appears that bits 5:0
> are the REFRESH_LO and bits 15:6 are the refresh interval. So this seems
> to imply the interval is set to 0 and not 1. So maybe the commit message
> needs to be fixed up.

Do you mean that EMC_REFRESH is a fractional value?

> The other question I have, should we be restoring the refresh value here
> somewhere?

The EMC_REFRESH value isn't altered on enter/exit self-refresh, at least on Tegra30.. very likely it should be the same for other gens.
