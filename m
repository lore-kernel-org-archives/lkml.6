Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AA7ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 059FE21479
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="XHAWiv14"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 059FE21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbeJRDij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 23:38:39 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:19830 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbeJRDij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 23:38:39 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bc7905f0000>; Wed, 17 Oct 2018 12:41:19 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 17 Oct 2018 12:41:26 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 17 Oct 2018 12:41:26 -0700
Received: from [10.26.11.110] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 17 Oct
 2018 19:41:24 +0000
Subject: Re: [PATCH v1] i2c: tegra: Remove suspend-resume
To:     Dmitry Osipenko <digetx@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-i2c@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20180513211347.7187-1-digetx@gmail.com>
 <c1b73435-48f0-b445-568f-3c8942878123@nvidia.com>
 <47eaced9-761d-b8d0-2f43-41bf3dd050cc@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <87168ccb-65f5-0ac3-8451-ccc2159d99df@nvidia.com>
Date:   Wed, 17 Oct 2018 20:41:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <47eaced9-761d-b8d0-2f43-41bf3dd050cc@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1539805279; bh=L0FBkrF/3uWbGQBeXtuR0cgflVjbbgP165SrkGWfaiI=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=XHAWiv14eC9lh65+636F7euiWKEHG0a9aWzKK0mcpCu83j9O29llrFAVPW7Tmwxpn
         lYZKtYjJqsZZDfhQZSfx21ZqjYAg6Ej1UjnddvgfHgItysjhqhSFB9AROz9tE6ZAFT
         mhLPy6pkpSsnalqYfK8pyAz2lM55edj5u2xwxG5VgjqRkPPLRqARSs36TMJnibqbnx
         a8V31QZ6Pt2Y1phYnqP6mKhK3hjZi6hkujooNdMp2EpV/n4/8uh2vRvwpuxKoPOJtO
         I2NLUYQIgzOZlMhLlE1/TYK9xftvqgH6oICQQIvSUVZLlUP/7K9j/SO2DkIokIe/VZ
         HnTcpq2NNMr/w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 17/10/2018 15:30, Dmitry Osipenko wrote:
> On 10/17/18 4:59 PM, Jon Hunter wrote:
>>
>> On 13/05/2018 22:13, Dmitry Osipenko wrote:
>>> Nothing prevents I2C clients to access I2C while Tegra's driver is being
>>> suspended, this results in -EBUSY error returned to the clients and that
>>> may have unfortunate consequences. In particular this causes problems
>>> for the TPS6586x MFD driver which emits hundreds of "failed to read
>>> interrupt status" error messages on resume from suspend. This happens if
>>> TPS6586X is used to wake system from suspend by the expired RTC alarm
>>> timer because TPS6586X is an I2C device driver and its IRQ handler reads
>>> the status register while Tegra's I2C driver is suspended, i.e. just after
>>> kernel enabled IRQ's during of resume-from-suspend process.
>>
>> I have been looking at the above issue with the tps6586x because I am
>> seeing delays on resume caused by this driver on the stable branches. I
>> understand that this patch was dropped for stable, but looking at the
>> specific issue with the tps6586x I am curious why the tps6586x driver
>> was not fixed because it appears to me that the issue largely resides
>> with that driver and any other device that uses the tps6586x is
>> susceptible to it. I was able to fix the tps6586x driver by doing the
>> following and I am interested in your thoughts ...
>>
>> Subject: [PATCH] mfd: tps6586x: Handle interrupts on suspend
>>
>> The tps6586x device is registered as an irqchip and the tps6586x-rtc
>> interrupt is one of it's interrupt sources. When using the tps6586x-rtc
>> as a wake-up device from suspend, the following is seen:
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
>> Fix this by disabling the tps6586x interrupt on entering suspend and
>> re-enabling it on resuming from suspend.
> 
> Looks like it should work, but I vaguely recalling that something didn't work after disabling of IRQ on suspend. Maybe wakeup was getting disabled, but seems it is working fine now. Patch is good to me if you're going to propose it for backporting, but you should test that it works properly with all of stable kernels.

Indeed, I have been setting up some automated testing of various stable
branches (mainly 4.x LTS releases) and I am seeing this problem there.
Furthermore, I am using this to validate the change as well.

> I just found this [0], seems your patch need to address the same review comment.
> 
> [0] https://lkml.org/lkml/2011/3/29/18

Thanks will do.

I know we don't support low power modes (ie. LP0), however, I do wonder
if we should have some sort of i2c suspend/resume handler for Tegra?
Eventually we will need this.

Cheers
Jon

-- 
nvpublic
