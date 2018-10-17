Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222E8ECDE3B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 20:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFA8B2145D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 20:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UG10uTBU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFA8B2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbeJRErT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 00:47:19 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39547 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbeJRErT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 00:47:19 -0400
Received: by mail-lf1-f67.google.com with SMTP id n14-v6so9045438lfe.6;
        Wed, 17 Oct 2018 13:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gO2xsugPFExqWrI5vcKZaLQPN8jH9y8vY8w//y93DB0=;
        b=UG10uTBUOlvWmlhuz/dFrYYt8P8JljgN3KEyfYtnqOncP00FBy5NTGk6vCkkrzuDGx
         tNOJPuhSwZGEc2ZXrRvaYxhEtayQ1uJIN2IW1xjHBdoji+KZLTOtsLmz5lGGe5dc/kqx
         bzalfdKB1+4AIw4GNU+bIiV2rsPvUHvZ7E9I7Q1Ph0D4bgUbWOpk35CCRrtyL5Lu7H4P
         zH+N3rPki9pI5wHJC6ny0JcdbaSEkoj5eP2s+EidS7+Tn2GoZE2wPQH0bpMUVhXNqLyu
         mxi4pMCcXfOSjqMO08h2Zp2OyATKBtgl2DINiAc2s79urjl/swLZGXrDeosAtH1/BVcF
         gqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gO2xsugPFExqWrI5vcKZaLQPN8jH9y8vY8w//y93DB0=;
        b=IVoXb6mC3XxtoC3dTBS0t3Hv6tnHPFr9QrJH7NOxgSe+2DLPcxJENXQbTTAtB+rsUw
         sFL9il/HMxtyn5/avqxhXsOjy9Q3ZcEIwirrGiX5hqVG1AygXG6fV4VfyglaLSSMd6mc
         1ieMCieLFx5TlqaMQsNWwtLaU0l5dWizc/W7asbfRLsaYonm1tsRCMon4EVU3f3GGGdv
         IKBHEl4o8QHGHFKA3FMR6pEaGfKDcoOdPWMXZK0HPgfhlpPdKafkgVmgVQhlnFCNhP6S
         q8nf9IoyEFgrAKkTQk/KR8d7abuC2coIYA4ADeR8FiOzU5pi2H29naIk6DJv8ZSHCud7
         lDVg==
X-Gm-Message-State: ABuFfohUkQzDyTmiCmQmk+0z36EjLUyBiBtDQQ5rthErCrjKfXFBETBS
        /RKeQgVdQ5zODbuS9r7ctT9iF0rR
X-Google-Smtp-Source: ACcGV63P+UmyhJ+Ld2Sd+nnlZND/sv8ecPmHcZ2ftQz0gpucy5+koGcrqjrBJC/RF+xChRCO4bdmqw==
X-Received: by 2002:a19:9f8c:: with SMTP id i134-v6mr16315140lfe.52.1539809389107;
        Wed, 17 Oct 2018 13:49:49 -0700 (PDT)
Received: from [192.168.2.145] ([109.252.91.118])
        by smtp.googlemail.com with ESMTPSA id g64-v6sm2852197lfe.87.2018.10.17.13.49.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 13:49:48 -0700 (PDT)
Subject: Re: [PATCH v1] i2c: tegra: Remove suspend-resume
To:     Jon Hunter <jonathanh@nvidia.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180513211347.7187-1-digetx@gmail.com>
 <c1b73435-48f0-b445-568f-3c8942878123@nvidia.com>
 <47eaced9-761d-b8d0-2f43-41bf3dd050cc@gmail.com>
 <87168ccb-65f5-0ac3-8451-ccc2159d99df@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <27a1f887-8bb0-7016-c6ff-310ff897e516@gmail.com>
Date:   Wed, 17 Oct 2018 23:49:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <87168ccb-65f5-0ac3-8451-ccc2159d99df@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/18 10:41 PM, Jon Hunter wrote:
> 
> On 17/10/2018 15:30, Dmitry Osipenko wrote:
>> On 10/17/18 4:59 PM, Jon Hunter wrote:
>>>
>>> On 13/05/2018 22:13, Dmitry Osipenko wrote:
>>>> Nothing prevents I2C clients to access I2C while Tegra's driver is being
>>>> suspended, this results in -EBUSY error returned to the clients and that
>>>> may have unfortunate consequences. In particular this causes problems
>>>> for the TPS6586x MFD driver which emits hundreds of "failed to read
>>>> interrupt status" error messages on resume from suspend. This happens if
>>>> TPS6586X is used to wake system from suspend by the expired RTC alarm
>>>> timer because TPS6586X is an I2C device driver and its IRQ handler reads
>>>> the status register while Tegra's I2C driver is suspended, i.e. just after
>>>> kernel enabled IRQ's during of resume-from-suspend process.
>>>
>>> I have been looking at the above issue with the tps6586x because I am
>>> seeing delays on resume caused by this driver on the stable branches. I
>>> understand that this patch was dropped for stable, but looking at the
>>> specific issue with the tps6586x I am curious why the tps6586x driver
>>> was not fixed because it appears to me that the issue largely resides
>>> with that driver and any other device that uses the tps6586x is
>>> susceptible to it. I was able to fix the tps6586x driver by doing the
>>> following and I am interested in your thoughts ...
>>>
>>> Subject: [PATCH] mfd: tps6586x: Handle interrupts on suspend
>>>
>>> The tps6586x device is registered as an irqchip and the tps6586x-rtc
>>> interrupt is one of it's interrupt sources. When using the tps6586x-rtc
>>> as a wake-up device from suspend, the following is seen:
>>>
>>>  PM: Syncing filesystems ... done.
>>>  Freezing user space processes ... (elapsed 0.001 seconds) done.
>>>  OOM killer disabled.
>>>  Freezing remaining freezable tasks ... (elapsed 0.000 seconds) done.
>>>  Disabling non-boot CPUs ...
>>>  Entering suspend state LP1
>>>  Enabling non-boot CPUs ...
>>>  CPU1 is up
>>>  tps6586x 3-0034: failed to read interrupt status
>>>  tps6586x 3-0034: failed to read interrupt status
>>>
>>> The reason why the tps6586x interrupt status cannot be read is because
>>> the tps6586x interrupt is not masked during suspend and when the
>>> tps6586x-rtc interrupt occurs, to wake-up the device, the interrupt is
>>> seen before the i2c controller has been resumed in order to read the
>>> tps6586x interrupt status.
>>>
>>> The tps6586x-rtc driver sets it's interrupt as a wake-up source during
>>> suspend, which gets propagated to the parent tps6586x interrupt.
>>> However, the tps6586x-rtc driver cannot disable it's interrupt during
>>> suspend otherwise we would never be woken up and so the tps6586x must
>>> disable it's interrupt instead.
>>>
>>> Fix this by disabling the tps6586x interrupt on entering suspend and
>>> re-enabling it on resuming from suspend.
>>
>> Looks like it should work, but I vaguely recalling that something didn't work after disabling of IRQ on suspend. Maybe wakeup was getting disabled, but seems it is working fine now. Patch is good to me if you're going to propose it for backporting, but you should test that it works properly with all of stable kernels.
> 
> Indeed, I have been setting up some automated testing of various stable
> branches (mainly 4.x LTS releases) and I am seeing this problem there.
> Furthermore, I am using this to validate the change as well.
> 
>> I just found this [0], seems your patch need to address the same review comment.
>>
>> [0] https://lkml.org/lkml/2011/3/29/18
> 
> Thanks will do.
> 
> I know we don't support low power modes (ie. LP0), however, I do wonder
> if we should have some sort of i2c suspend/resume handler for Tegra?
> Eventually we will need this.

I'd suggest to support LP0 in the core first and only then to start making necessary suspend/resume changes in the drivers, otherwise it may end up being wasted time and effort for you and other maintainers.
