Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4F9C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 11:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4724620658
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 11:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgktSkZQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4724620658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbeJVThS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 15:37:18 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36505 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbeJVThR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 15:37:17 -0400
Received: by mail-lj1-f193.google.com with SMTP id p89-v6so36600453ljb.3;
        Mon, 22 Oct 2018 04:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x8oCIvt6nOoHUTvDF2NggLqQeL6wo+FZ64JvsC5L7Hc=;
        b=CgktSkZQusFg4nk94NkMWLuDEp/69UNVg5Jw+fOFZwaoSRx6Ef4NY04sB++6aQrlua
         8hJD3wJhcy4E2Fc+NkuP7W+6nh2c2UFslyQJg5SIoFX9r8Zbn/oS5Vwghk9owxizMlaP
         v6O0RY9mIdBpHB0X4siCKnsYodThh3H2dWg8IqI6e+7WAD7yruwSmfUe88qQAPbYgezO
         74WJ/hOA8fbytKjtSm61tVKefi7nVdO+W+RmAAHksz4aEJ8gtnNbxdcelR26zrkowlCg
         Wpr+HkgAACUw+OkU4LZvD5nXNelO0dZwCVWDW/kt10D2vOs+AEWXmrIxZbP2fYrxiJt9
         Tufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x8oCIvt6nOoHUTvDF2NggLqQeL6wo+FZ64JvsC5L7Hc=;
        b=o2gEnDIA/VGiNqQb8YSHJEs7aGFKV28OYAKQlwlMGULPMHM85BfjQcdQEjXrQv5K30
         +MSudPDTY5de0RkEEpEH2jZqA2cVWH41TMqt4f67RCejYc+v0bVjQUXnuC1FyjLc03BB
         TYxANYVCmpPxDyBBql8yCkvDKCOW/AL5rVe7FTTfm3HMrYH6g7C4rYSRNDprw4umzBmC
         GL4GEChGupquRga/gMoc1sbSaP7cPZqKKAX69GuCXJDxdWtmwC2axK1VykxKr36TqQqR
         4i+vqkphSoc5WhVT/0iv6D7Opdrw1fRoYrYI8YvNWIcFzknfhSl3cKY/DzhGhvw/MMD/
         qTKA==
X-Gm-Message-State: ABuFfojokwP4XCGUc/v/attXzOb6tKQepc9xz0PDjxj3UHBUdA88HVRb
        VfVOUnKO+B689WoeDtQqIpsMexRr
X-Google-Smtp-Source: AJdET5fxm+JzFxnEmnN0GjNETazgSS24y+nWq1HxcxhNcBNMXNKxfq0rCI+HHgCUm9R4RzoNcbEWAg==
X-Received: by 2002:a2e:87da:: with SMTP id v26-v6mr12075888ljj.13.1540207147212;
        Mon, 22 Oct 2018 04:19:07 -0700 (PDT)
Received: from [192.168.2.145] (109-252-91-118.nat.spd-mgts.ru. [109.252.91.118])
        by smtp.googlemail.com with ESMTPSA id t4-v6sm1361633lft.77.2018.10.22.04.19.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 04:19:06 -0700 (PDT)
Subject: Re: [PATCH] mfd: tps6586x: Handle interrupts on suspend
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, stable@vger.kernel.org
References: <1539955373-13735-1-git-send-email-jonathanh@nvidia.com>
 <20181022095257.GD4014@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <366ad7c3-85e2-3526-1c0b-6d2fbde4c552@gmail.com>
Date:   Mon, 22 Oct 2018 14:19:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181022095257.GD4014@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/18 12:52 PM, Thierry Reding wrote:
> On Fri, Oct 19, 2018 at 02:22:53PM +0100, Jon Hunter wrote:
>> From: Jonathan Hunter <jonathanh@nvidia.com>
>>
>> The tps6586x driver creates an irqchip that is used by its various child
>> devices for managing interrupts. The tps6586x-rtc device is one of its
>> children that uses the tps6586x irqchip. When using the tps6586x-rtc as
>> a wake-up device from suspend, the following is seen:
>>
>>  PM: Syncing filesystems ... done.
>>  Freezing user space processes ... (elapsed 0.001 seconds) done.
>>  OOM killer disabled.
>>  Freezing remaining freezable tasks ... (elapsed 0.000 seconds) done.
>>  Disabling non-boot CPUs ...
>>  Entering suspend state LP1
>>  Enabling non-boot CPUs ...
>>  CPU1 is up
>>  tps6586x 3-0034: failed to read interrupt status
>>  tps6586x 3-0034: failed to read interrupt status
>>
>> The reason why the tps6586x interrupt status cannot be read is because
>> the tps6586x interrupt is not masked during suspend and when the
>> tps6586x-rtc interrupt occurs, to wake-up the device, the interrupt is
>> seen before the i2c controller has been resumed in order to read the
>> tps6586x interrupt status.
>>
>> The tps6586x-rtc driver sets it's interrupt as a wake-up source during
>> suspend, which gets propagated to the parent tps6586x interrupt.
>> However, the tps6586x-rtc driver cannot disable it's interrupt during
>> suspend otherwise we would never be woken up and so the tps6586x must
>> disable it's interrupt instead.
>>
>> Prevent the tps6586x interrupt handler from executing on exiting suspend
>> before the i2c controller has been resumed by disabling the tps6586x
>> interrupt on entering suspend and re-enabling it on resuming from
>> suspend.
>>
>> Cc: stable@vger.kernel.org
>>
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>> ---
>>  drivers/mfd/tps6586x.c | 24 ++++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
> 
> So does this mean that the SPI interrupt for the PMIC can still be a
> wakeup source even if it is masked? This is slightly odd because now
> you're saying that this does work while it doesn't work for the RTC
> interrupt. So is this an implementation quirk of the LIC/GIC on Tegra
> which doesn't extend to the TPS6586x? Or am I missing something?

What is the expected behaviour of IRQ disabling? Should it disable wakeup ability or only mask IRQ handling?

Couple months ago disabling of IRQ was disabling the wakeup, now something has been changed in kernel and wakeup isn't getting disabled. So either there was a bug before that was fixed or there is a bug now.
