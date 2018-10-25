Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB015C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 13:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 580CF2082D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 13:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLZlrxIB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 580CF2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbeJYVeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 17:34:06 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40376 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbeJYVeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 17:34:06 -0400
Received: by mail-lj1-f196.google.com with SMTP id t22-v6so8117318lji.7;
        Thu, 25 Oct 2018 06:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IdfG7e238Qr/muLb9Nm4PSde5cxCGzo7iOnWuFkYFC4=;
        b=ZLZlrxIBN8Gu8AffEDx3mHTrsqBYA3egopnvnZJHBjfy9z8DQnCA5p468KIYlsmxmH
         eCT3ZVq2i2LCPaL/iROeob6y9lu0jdVNB2WVBpUgYv43pqnGyxNWErG9WTnB2SIJW1c+
         ZKGnwgnh2a6XB2kzldB6ftlm6SxUEOdtXXsQIPYnvkCVogyPEmJORKPIGdnNhK2BEbrz
         SBrzUfrqUT4WhN5Xf9SXsd12b0IpaeUOr4d5yytfR/rfjffZaGkcQoNtrlT0O5bZiGty
         3V3abPvk0Rit9PavwjmdwRRT1PCxusL71YcZOCYfmcCI3lmWhNxsykU320VocMoD9ctp
         jHWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IdfG7e238Qr/muLb9Nm4PSde5cxCGzo7iOnWuFkYFC4=;
        b=iBbfdXb1CmZ1k8yUcSqIuFugwllMeLOACH1L8adKKAmbV0gcvdVLgool8TVjbgfIYE
         npT8robZ9V7jcWWcOATqBYKP7G9bmgIwyzWFoeFKVQUYeFUJibk6efBZE+yNrlR0Vk5W
         wL4Nt+oFrtz0O9TFdWSZLDZUYkTxzgFoGc9XGMipS6cn1Q8SqqLpRiQ6JOG8RAm7VXZE
         aMjCeKKeA9fEPc+KArjy9m0vQkxPIoBvEV9XarNRbeg9UL2aLzdXu+lPnk3ouOd754O9
         XWyGYtbsxIT3QR6bmI8YRH5ND3s3PxyST2r/xWSFVwg3qnJ3XHVfneDj9RDN/ddcNHPt
         SAQA==
X-Gm-Message-State: AGRZ1gLCg0QXQv6Jy68GumY/Asc9riarDa11fXi2nsqHBhla6fZRpxxh
        neSL8UH0F39AhCtikliOVtc1Mzu0
X-Google-Smtp-Source: AJdET5fKGIHcY9J5ts1FnJNb0EgXLQ1GuJgVQZmv4plTO6WcRsG7166+XJYYyjGAcEo0NMusAntQSg==
X-Received: by 2002:a2e:5586:: with SMTP id g6-v6mr1175557lje.75.1540472482654;
        Thu, 25 Oct 2018 06:01:22 -0700 (PDT)
Received: from [192.168.2.145] (109-252-91-118.nat.spd-mgts.ru. [109.252.91.118])
        by smtp.googlemail.com with ESMTPSA id x84-v6sm933656ljb.56.2018.10.25.06.01.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 06:01:21 -0700 (PDT)
Subject: Re: [PATCH] mfd: tps6586x: Handle interrupts on suspend
To:     Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, stable@vger.kernel.org
References: <1539955373-13735-1-git-send-email-jonathanh@nvidia.com>
 <20181022095257.GD4014@ulmo> <366ad7c3-85e2-3526-1c0b-6d2fbde4c552@gmail.com>
 <72b80285-d6ff-9cb9-3bcd-bb3d92006323@nvidia.com>
 <3e79e753-4e63-5bf0-c9ff-40547d053c8a@gmail.com>
 <551feb87-efb0-4bc3-2f0e-84ab55f7cbfe@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <5a6c9c02-78b1-a30f-e938-573e89e3b92c@gmail.com>
Date:   Thu, 25 Oct 2018 16:01:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <551feb87-efb0-4bc3-2f0e-84ab55f7cbfe@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/18 5:19 PM, Jon Hunter wrote:
> 
> On 24/10/2018 13:44, Dmitry Osipenko wrote:
>> On 10/24/18 1:49 PM, Jon Hunter wrote:
>>>
>>> On 22/10/2018 12:19, Dmitry Osipenko wrote:
>>>> On 10/22/18 12:52 PM, Thierry Reding wrote:
>>>>> On Fri, Oct 19, 2018 at 02:22:53PM +0100, Jon Hunter wrote:
>>>>>> From: Jonathan Hunter <jonathanh@nvidia.com>
>>>>>>
>>>>>> The tps6586x driver creates an irqchip that is used by its various child
>>>>>> devices for managing interrupts. The tps6586x-rtc device is one of its
>>>>>> children that uses the tps6586x irqchip. When using the tps6586x-rtc as
>>>>>> a wake-up device from suspend, the following is seen:
>>>>>>
>>>>>>  PM: Syncing filesystems ... done.
>>>>>>  Freezing user space processes ... (elapsed 0.001 seconds) done.
>>>>>>  OOM killer disabled.
>>>>>>  Freezing remaining freezable tasks ... (elapsed 0.000 seconds) done.
>>>>>>  Disabling non-boot CPUs ...
>>>>>>  Entering suspend state LP1
>>>>>>  Enabling non-boot CPUs ...
>>>>>>  CPU1 is up
>>>>>>  tps6586x 3-0034: failed to read interrupt status
>>>>>>  tps6586x 3-0034: failed to read interrupt status
>>>>>>
>>>>>> The reason why the tps6586x interrupt status cannot be read is because
>>>>>> the tps6586x interrupt is not masked during suspend and when the
>>>>>> tps6586x-rtc interrupt occurs, to wake-up the device, the interrupt is
>>>>>> seen before the i2c controller has been resumed in order to read the
>>>>>> tps6586x interrupt status.
>>>>>>
>>>>>> The tps6586x-rtc driver sets it's interrupt as a wake-up source during
>>>>>> suspend, which gets propagated to the parent tps6586x interrupt.
>>>>>> However, the tps6586x-rtc driver cannot disable it's interrupt during
>>>>>> suspend otherwise we would never be woken up and so the tps6586x must
>>>>>> disable it's interrupt instead.
>>>>>>
>>>>>> Prevent the tps6586x interrupt handler from executing on exiting suspend
>>>>>> before the i2c controller has been resumed by disabling the tps6586x
>>>>>> interrupt on entering suspend and re-enabling it on resuming from
>>>>>> suspend.
>>>>>>
>>>>>> Cc: stable@vger.kernel.org
>>>>>>
>>>>>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>>>>>> ---
>>>>>>  drivers/mfd/tps6586x.c | 24 ++++++++++++++++++++++++
>>>>>>  1 file changed, 24 insertions(+)
>>>>>
>>>>> So does this mean that the SPI interrupt for the PMIC can still be a
>>>>> wakeup source even if it is masked? This is slightly odd because now
>>>>> you're saying that this does work while it doesn't work for the RTC
>>>>> interrupt. So is this an implementation quirk of the LIC/GIC on Tegra
>>>>> which doesn't extend to the TPS6586x? Or am I missing something?
>>>>
>>>> What is the expected behaviour of IRQ disabling? Should it disable wakeup ability or only mask IRQ handling?
>>>
>>> I believe only mask the interrupt. However, the caveat here could be if
>>> the parent interrupt controller actually supports wake-up. For Tegra it
>>> is the LIC that handles the wake-up.
>>>
>>>> Couple months ago disabling of IRQ was disabling the wakeup, now something has been changed in kernel and wakeup isn't getting disabled. So either there was a bug before that was fixed or there is a bug now.
>>>
>>> Are you sure you were disabling the PMIC host interrupt? If you disable
>>> the RTC interrupt in the PMIC's RTC driver, then this will prevent the
>>> wake-up from occurring because you are masking the interrupt within the
>>> PMIC and so it will never generate an interrupt to the host.
>>
>> I'm pretty sure (but not 100%) that was trying the same change as in your patch and it didn't work sometime before. If disable_irq() shouldn't disable wakeup, then everything is perfect now.
> 
> Please note that this is very similar to the following fix where I
> experienced the same problem with another PMIC a couple years back ...
> 
> 35deff7eb212 ("mfd: as3722: Handle interrupts on suspend")
> 
> I did not bother setting the enable/disable_irq_wake() for the tps6586x
> host irq during resume/suspend because the irqchip for the tps6586x has
> an irq_set_wake function that propagates the wake enable/disable.

Okay, thanks.
