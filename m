Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F7FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C28720870
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sx7wc+pQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C28720870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731410AbeKTI6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 03:58:22 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40627 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730290AbeKTI6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 03:58:21 -0500
Received: by mail-lj1-f193.google.com with SMTP id n18-v6so6605863lji.7;
        Mon, 19 Nov 2018 14:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7VeGZlpAy71icVzhG1bAgBSRPAHMCnD37NLZGKL7BKE=;
        b=Sx7wc+pQHC4PXXL31y41CKI1hfYwzBqfl5fL5JlBkOoDq4wA6r5P5pWA9+2nHrvVxb
         RRydPIkr5RBkyxw/jVcgJ+/bRluM2mcxFx+31RycOqQytKvtKfVZJ31DQAW6fnWoSegK
         wmBaEJE602bwmxTAX71N34YRv/pjQSFa6AaRnrXyhzCWAdnm740MyQ9VHFLRelZhZBCW
         bwwhHoEsb28sF9pjfXYsFrD9cxIp0UwfcYtpXqV1Mzp6qi63NSEkPMlbw3py5JNjiD+X
         uyJYoBCuUMwcDfbMB8jqLavNf0RJ6CNdPLFW6mkQGCvr370g1CAgPOEqGn8YKKgMiV54
         ny5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7VeGZlpAy71icVzhG1bAgBSRPAHMCnD37NLZGKL7BKE=;
        b=WtBXKYMbI5HAOGpPfHvFJ/iQaSUPkQARZSU994IUO+wF1wzSCzzAyIgM7mgKkHjsva
         QzWNFdejNaRqzB3doalD0OyC3mfx7xP2oZ8Q64VeKLYNg2oNEetsfIZp4Dy5aqDbxT5p
         B17a29+v/zDRwmaaXnaddmd1/8961gHjjqp5FF0R5bIk0OZDW9kqG+jqyjLkqIPvBaJ5
         I3LAmfA4ggFjbV2ZwoAY2cJkZ8QrFXMXRWCHtfkhnBMwCs8hsfdsmAx2JK1lW0cjVPUN
         opb+o+48sF5VHZi9rWjFBmuAAd8owNeb3GEwVq5pH2/AdBaPtAHesX+ZghlpNvuNpZl+
         epsw==
X-Gm-Message-State: AGRZ1gLHkhkasjS2dMLQ1W/7Jd/y9NbxgIA0jPKjjRB70u8IjxLFGAc1
        vjkVDdNzmBSL2I5+uy/1KmYp4BWI
X-Google-Smtp-Source: AJdET5dAukYlrj7Fo0SzYkhyojfX1EVsRzxwMlyooyBsdC2NxoisGXH6+SXwogkIklldMUQrezfvWA==
X-Received: by 2002:a2e:1551:: with SMTP id 17-v6mr12394502ljv.68.1542666750061;
        Mon, 19 Nov 2018 14:32:30 -0800 (PST)
Received: from [192.168.2.145] (ppp91-76-171-181.pppoe.mtu-net.ru. [91.76.171.181])
        by smtp.googlemail.com with ESMTPSA id m21sm5580792lfl.97.2018.11.19.14.32.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 14:32:29 -0800 (PST)
Subject: Re: [PATCH v1 2/4] ARM: tegra: Fix DRAM refresh-interval clobbering
 on resume from LP1 on Tegra30
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180830185404.7224-1-digetx@gmail.com>
 <20180830185404.7224-3-digetx@gmail.com>
 <4f61bf5f-0aa8-df6e-109b-194b08f3374e@nvidia.com>
 <cee4398b-edb8-4c9d-7830-6f52fffd6e1c@gmail.com>
Message-ID: <2096a744-d80b-42ad-a285-7bc1c1d3a5ed@gmail.com>
Date:   Tue, 20 Nov 2018 01:32:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <cee4398b-edb8-4c9d-7830-6f52fffd6e1c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.11.2018 1:09, Dmitry Osipenko wrote:
> On 20.11.2018 0:34, Jon Hunter wrote:
>>
>> On 30/08/2018 19:54, Dmitry Osipenko wrote:
>>> The DRAM refresh-interval is getting erroneously set to "1" on exiting
>>> from memory self-refreshing mode. The clobbered interval causes the
>>> "refresh request overflow timeout" error raised by the External Memory
>>> Controller on exiting from LP1 on Tegra30.
>>>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  arch/arm/mach-tegra/sleep-tegra30.S | 2 --
>>>  1 file changed, 2 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/arch/arm/mach-tegra/sleep-tegra30.S
>>> index 801fe58978ae..99ac9c6dcf7c 100644
>>> --- a/arch/arm/mach-tegra/sleep-tegra30.S
>>> +++ b/arch/arm/mach-tegra/sleep-tegra30.S
>>> @@ -29,7 +29,6 @@
>>>  #define EMC_CFG				0xc
>>>  #define EMC_ADR_CFG			0x10
>>>  #define EMC_TIMING_CONTROL		0x28
>>> -#define EMC_REFRESH			0x70
>>>  #define EMC_NOP				0xdc
>>>  #define EMC_SELF_REF			0xe0
>>>  #define EMC_MRW				0xe8
>>> @@ -459,7 +458,6 @@ emc_wait_auto_cal_onetime:
>>>  	cmp	r10, #TEGRA30
>>>  	streq	r1, [r0, #EMC_NOP]
>>>  	streq	r1, [r0, #EMC_NOP]
>>> -	streq	r1, [r0, #EMC_REFRESH]
>>>  
>>>  	emc_device_mask r1, r0
>>
>> This does look incorrect and it appears Tegra20 has the same bug.
> 
> Indeed.. somehow this doesn't cause any problems on T20. Maybe this affects only specific timing configurations and it's just a luck that "refresh overflow" isn't getting raised.

Ah, T20 exit_selfrefresh_loop doesn't latch registers.. that's probably why it stayed unnoticed.
