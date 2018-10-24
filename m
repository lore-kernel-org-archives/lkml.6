Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF92AC004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 12:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F57E2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 12:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="paPvFFqm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F57E2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbeJXVMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 17:12:22 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43541 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbeJXVMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 17:12:22 -0400
Received: by mail-lj1-f193.google.com with SMTP id x22-v6so1434342ljc.10;
        Wed, 24 Oct 2018 05:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ma0ZH6VoHaR/w8ecQJz/U30X0/K4X+emPKDvOX0nm50=;
        b=paPvFFqmeHqNvf61ojdQcA7TJ1MQ+NCOuciUgwhO/mR/pAw+9hJ7PMhZQi5QzeTZPl
         /TtTwN6sjHuAKXP0msjIXajVf8k/POzgC25t/nQbdHyTrXSDqS1ZHxcg7qFgMD5O0ghh
         Wc6Rw7APV3aucHIzlT8F9GljzsYtca9w6dgpxZw4XzlXy8lSh654MxGwpLNWIRiYrasM
         OGX/DqITWon6H+g/J0AHRkMDUCiDFcUB7LofUYV5K9eop3gdiyLOCO+xQns+NYcpAiZd
         hpbd7sNlVzM6Qu4srd2ibtwI2HYYypYfr/8dYzBX1OzY4JDXkAKYeiSrRpTqKq6gLvKj
         7lRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ma0ZH6VoHaR/w8ecQJz/U30X0/K4X+emPKDvOX0nm50=;
        b=f4K4hMAnV2XlYtbXaVd+MJppvAgaSxD1Y9LOBmiNl9G8Z1xgT1s6mBeGaKxUClb5g3
         ExrwcUHGWi+Vitds3iYmQ3fE21K85wsabTBbHjaelKI/jcM0FTO1+/aP8hh75fF+jgF9
         83eojtH5YqLsjdVq7I2lBZqfM528y0qO2/WdRIpxN1aNHyYOEWdjSg4nQz/52XNkw9nO
         vmY8bBVrpIuPEWnvNBjr1mFtAbK65YjetXKL6jtpwXxSZUky7qWooM6aGssQ0+Id5Oez
         nIjyWfVxC/K0Uho8di636atcEGIS8G9XzgiXkBSqZ78R7yL/6STjUDPBmMNPgr76sCuc
         MM6w==
X-Gm-Message-State: AGRZ1gIodpY5Q3vms5orrXtS6Hz/tbsKO38sFRiqoEOp9XI71XbtB/p+
        kbH9NqzczSi/gQ/kVCaVEOoaNZkN
X-Google-Smtp-Source: AJdET5cRO2YHKOWEuxzycRaozeiVNLFfOizq2Zyj2C+tVnyrS52iIIJ9Qjw2zWfqwBV6KWCV4rXviA==
X-Received: by 2002:a2e:9d05:: with SMTP id t5-v6mr1692685lji.57.1540385061157;
        Wed, 24 Oct 2018 05:44:21 -0700 (PDT)
Received: from [192.168.2.145] (109-252-91-118.nat.spd-mgts.ru. [109.252.91.118])
        by smtp.googlemail.com with ESMTPSA id f95-v6sm655037lji.76.2018.10.24.05.44.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 05:44:20 -0700 (PDT)
Subject: Re: [PATCH] mfd: tps6586x: Handle interrupts on suspend
To:     Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, stable@vger.kernel.org
References: <1539955373-13735-1-git-send-email-jonathanh@nvidia.com>
 <20181022095257.GD4014@ulmo> <366ad7c3-85e2-3526-1c0b-6d2fbde4c552@gmail.com>
 <72b80285-d6ff-9cb9-3bcd-bb3d92006323@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <3e79e753-4e63-5bf0-c9ff-40547d053c8a@gmail.com>
Date:   Wed, 24 Oct 2018 15:44:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <72b80285-d6ff-9cb9-3bcd-bb3d92006323@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/18 1:49 PM, Jon Hunter wrote:
> 
> On 22/10/2018 12:19, Dmitry Osipenko wrote:
>> On 10/22/18 12:52 PM, Thierry Reding wrote:
>>> On Fri, Oct 19, 2018 at 02:22:53PM +0100, Jon Hunter wrote:
>>>> From: Jonathan Hunter <jonathanh@nvidia.com>
>>>>
>>>> The tps6586x driver creates an irqchip that is used by its various child
>>>> devices for managing interrupts. The tps6586x-rtc device is one of its
>>>> children that uses the tps6586x irqchip. When using the tps6586x-rtc as
>>>> a wake-up device from suspend, the following is seen:
>>>>
>>>>  PM: Syncing filesystems ... done.
>>>>  Freezing user space processes ... (elapsed 0.001 seconds) done.
>>>>  OOM killer disabled.
>>>>  Freezing remaining freezable tasks ... (elapsed 0.000 seconds) done.
>>>>  Disabling non-boot CPUs ...
>>>>  Entering suspend state LP1
>>>>  Enabling non-boot CPUs ...
>>>>  CPU1 is up
>>>>  tps6586x 3-0034: failed to read interrupt status
>>>>  tps6586x 3-0034: failed to read interrupt status
>>>>
>>>> The reason why the tps6586x interrupt status cannot be read is because
>>>> the tps6586x interrupt is not masked during suspend and when the
>>>> tps6586x-rtc interrupt occurs, to wake-up the device, the interrupt is
>>>> seen before the i2c controller has been resumed in order to read the
>>>> tps6586x interrupt status.
>>>>
>>>> The tps6586x-rtc driver sets it's interrupt as a wake-up source during
>>>> suspend, which gets propagated to the parent tps6586x interrupt.
>>>> However, the tps6586x-rtc driver cannot disable it's interrupt during
>>>> suspend otherwise we would never be woken up and so the tps6586x must
>>>> disable it's interrupt instead.
>>>>
>>>> Prevent the tps6586x interrupt handler from executing on exiting suspend
>>>> before the i2c controller has been resumed by disabling the tps6586x
>>>> interrupt on entering suspend and re-enabling it on resuming from
>>>> suspend.
>>>>
>>>> Cc: stable@vger.kernel.org
>>>>
>>>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>>>> ---
>>>>  drivers/mfd/tps6586x.c | 24 ++++++++++++++++++++++++
>>>>  1 file changed, 24 insertions(+)
>>>
>>> So does this mean that the SPI interrupt for the PMIC can still be a
>>> wakeup source even if it is masked? This is slightly odd because now
>>> you're saying that this does work while it doesn't work for the RTC
>>> interrupt. So is this an implementation quirk of the LIC/GIC on Tegra
>>> which doesn't extend to the TPS6586x? Or am I missing something?
>>
>> What is the expected behaviour of IRQ disabling? Should it disable wakeup ability or only mask IRQ handling?
> 
> I believe only mask the interrupt. However, the caveat here could be if
> the parent interrupt controller actually supports wake-up. For Tegra it
> is the LIC that handles the wake-up.
> 
>> Couple months ago disabling of IRQ was disabling the wakeup, now something has been changed in kernel and wakeup isn't getting disabled. So either there was a bug before that was fixed or there is a bug now.
> 
> Are you sure you were disabling the PMIC host interrupt? If you disable
> the RTC interrupt in the PMIC's RTC driver, then this will prevent the
> wake-up from occurring because you are masking the interrupt within the
> PMIC and so it will never generate an interrupt to the host.

I'm pretty sure (but not 100%) that was trying the same change as in your patch and it didn't work sometime before. If disable_irq() shouldn't disable wakeup, then everything is perfect now.
