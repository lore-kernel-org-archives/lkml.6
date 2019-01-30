Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0867CC169C4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 02:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C829420880
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 02:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="KG3A3Ye0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729914AbfA3CkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 21:40:11 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:6526 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729814AbfA3CkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 21:40:11 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c510e6e0000>; Tue, 29 Jan 2019 18:39:42 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 29 Jan 2019 18:40:10 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 29 Jan 2019 18:40:10 -0800
Received: from [10.19.108.132] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 30 Jan
 2019 02:40:08 +0000
Subject: Re: [PATCH V2 2/6] clocksource: tegra: add Tegra210 timer driver
To:     Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
CC:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-arm-kernel@lists.infradead.org>
References: <20190128091815.7040-1-josephl@nvidia.com>
 <20190128091815.7040-3-josephl@nvidia.com> <20190128150908.GB31317@ulmo>
 <20190129084155.GX7714@pdeschrijver-desktop.Nvidia.com>
 <20190129102912.GC28850@ulmo>
From:   Joseph Lo <josephl@nvidia.com>
Message-ID: <8d5b6a61-8fb8-2f83-5378-9b1a1e5bd03d@nvidia.com>
Date:   Wed, 30 Jan 2019 10:40:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190129102912.GC28850@ulmo>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548815982; bh=FrciTN+redRE/lCiDp/HTROkP++nJMtJ9d9VV4lPFqM=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=KG3A3Ye0Sb7XAUGr538f8B6znelawNhxh7Sr36OfdmyBYXqHsPxVloNC41l79e1Dp
         QD1Hi8WvPF1anHlwPa6an9XA0NfCArJuFja6XMeKmQO54qsKI/jR/y4tBHHA5n1hw/
         xf+QWgdlDb/RZAVXNsy0Ru3HAH1pfeaLVfmJRHzfbQqvdnxsTZZTAaCEkPLQQmnTzk
         6ClMBbfF30v7MjlQ/azBhzyRseDtTJ6mezMqeQLXfNwPlkYz+Fv3eI23AD/Y8pYtm9
         9Z3jyHG2BJ5XF954uRjLrxq5sHjoV9/cP6eaCI3qzHgv9h6c0UI2Sp0asQ+xJjlf+w
         VvOEdZ1CdYhjQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/29/19 6:29 PM, Thierry Reding wrote:
> On Tue, Jan 29, 2019 at 10:41:55AM +0200, Peter De Schrijver wrote:
>> On Mon, Jan 28, 2019 at 04:09:08PM +0100, Thierry Reding wrote:
>>
>> ...
>>
>>>
>>> Up to here this is a duplicate of timer-tegra20.c. And a lot of
>>> tegra210_timer_init() is the same as tegra20_timer_init() as well. Can't
>>> we unify the two drivers instead?
>>>
>>> The power cycle restrictions of the architected timer, do they not apply
>>> to chips earlier than Tegra210 either? So don't we need all of these
>>> additional features on the timer-tegra20.c driver as well? If so that
>>
>> No. Chips prior to Tegra114 do not have an arch timer and the arch timer
>> does work correctly on Cortex-A15 so Tegra114 and Tegra124 can use it.
>> It's broken on Cortex-A57 though, so we can't use it as a wakeup source
>> on Tegra210.
> 
> If chips prior to Tegra114 don't have an architected timer, then we
> can't remove the timer-tegra20 driver, because we still need it on
> Tegra20 and Tegra30, right?
> 

For Tegra20/30, it's Cortext-A9 with TWD timer. (arch/arm/kernel/smp_twd.c)

Originally, I thought the functionality of timer-tegra20 would be fully 
replaced by TWD timer driver. But from the log in the kernelci test 
farm[1][2], it looks to me the timer-tegra20 driver still works as 
clocksource driver for Tegra20/30. I cannot confirm if the clock event 
device has been replaced by TWD timer in the log. It could be replaced 
in the background. And by looking into the driver, it should be.

Compare to the log of Tegra124[3], it has been fully replaced by arch 
timer driver.

Note, "timer_us" is the name of Tegra20 timer.
[1]: 
https://storage.kernelci.org/mainline/master/v5.0-rc4-1-g4aa9fc2a435a/arm/tegra_defconfig/lab-baylibre-seattle/boot-tegra30-beaver.html
[2]: 
https://storage.kernelci.org/stable-rc/linux-4.9.y/v4.9.153-43-g6674590d15d2/arm/tegra_defconfig/lab-baylibre-seattle/boot-tegra20-iris-512.html
[3]: 
https://storage.kernelci.org/lsk/linux-linaro-lsk-v4.9/lsk-v4.9-18.09-1494-gde3059d32f93/arm/tegra_defconfig/lab-collabora/boot-tegra124-nyan-big.html

Thanks,
Joseph
