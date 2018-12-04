Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4226C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C807A2082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:58:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C807A2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbeLDJ61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 04:58:27 -0500
Received: from ms.tdt.de ([195.243.126.94]:45755 "EHLO mail.dev.tdt.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725764AbeLDJ61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 04:58:27 -0500
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
        by mail.dev.tdt.de (Postfix) with ESMTP id 5EFC621920;
        Tue,  4 Dec 2018 09:58:24 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 04 Dec 2018 10:58:24 +0100
From:   Florian Eckert <fe@dev.tdt.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Eckert.Florian@googlemail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH v5 0/2] Add device driver for APU2/APU3 GPIOs
In-Reply-To: <CAHp75VdEgm-=jHgJXz_mM6DZMnFVEeZW_es3VyL4L2V+khYWtg@mail.gmail.com>
References: <20181127132508.5501-1-fe@dev.tdt.de>
 <CAHp75VfFYJQzTv_oe8RKPo03-FLYHy6BkrKaG23svAKtC+jVBg@mail.gmail.com>
 <583ca922b4a877a4b0577994e40ddf5f@dev.tdt.de>
 <CAHp75VcKu4fhP8=NH7fgfSFCh6xdCLWrNLcsHSuWvMcW+irfmA@mail.gmail.com>
 <70e7b8e2346b9837273b5edce0524584@dev.tdt.de>
 <CAHp75VfSKz8sauUKq2pxUhQ6xvmX4UeOBw6eEA+71=NUyWES9g@mail.gmail.com>
 <51e0d3f36dc23de801f2fdfc990f6c23@dev.tdt.de>
 <CAHp75VdEgm-=jHgJXz_mM6DZMnFVEeZW_es3VyL4L2V+khYWtg@mail.gmail.com>
Message-ID: <84a2396b0b5ba34a2339d35159a97a89@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.1.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> >> Yes i will fix your hints tomorrow and send a v6 of my patchset.
>> >> Thank you for your hints and time
>> >> It would be nice if you could fix ACPI problemmatik.
>> >
>> > I would like to see the ACPI dump for that...
>> 
>> See 
>> https://github.com/openwrt/openwrt/pull/1232#issuecomment-443224576
>> In this comment Michał Żygowski appended to this thread the missing
>> files you want to have.

> So, let me clarify what we have:
>  - some platforms are in the wild with old BIOS with broken ACPI tables

correct

>  - you still may fix the things for new BIOS version for all affected 
> platforms

I have seen that this is a lot of work and I didn't think it was so 
complicated!
To get the GPIO support for APU2/APU3 merged into the gpio subsystem.
I am little confused what i should do now. By the way I only have one 
board (APU3).

>  - you need to support both

That is not necessary from my point of view. I am fine if the driver 
supports at least
the current BIOS version. And if the coreboot maintainer fixes the ACPI 
problem
then we could extend the driver and add the ACPI stuff.
But this not in my hand, right?

> For broken firmware you need to do the following:
>  - create an MFD driver, which would instantiate GPIO and GPIO keys
> support (at least)
>  - create one of each above drivers w/o any DMI crap (should be done
> as a part of MFD driver)

I will have a look how to achieve this.
If we want to support all BIOS version.
And is a must have to get the driver into mainline.

> For fixed BIOS you need to add the following (example, not a fully
> correct solution) at the level behind SB:

I do not understand how I could fix this. I have no idea from ACPI.
I have not found any driver where I can inspire myself.

> 
> Scope (SB)
> {
>   Device(GPIO)
>   {

> After updating firmware you would need just an ACPI ID table to be
> added to the GPIO driver. MFD driver should not be enumerated at all.

That's maybe coming next when the coreboot maintainers have their bios 
fixed, right?


