Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D02C4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 05:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67B82215E5
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 05:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20150623.gappssmtp.com header.i=@landley-net.20150623.gappssmtp.com header.b="uEXMmGZt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67B82215E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbeHSIse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 04:48:34 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:50445 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbeHSIse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 04:48:34 -0400
Received: by mail-it0-f66.google.com with SMTP id j81-v6so16524302ite.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Aug 2018 22:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WB0Pz5E7ntIgu1zMZuAYpVIOS5Vg0u3ZNRaPxkPt8jI=;
        b=uEXMmGZthVF7fuMMw4rdRrWPusITfjo4p0OjWcFwTbes9kJ7SRgM5/6M8JRZ8yS4Pr
         xJZB1FPMWztumG4I0Rqrz9oXNFAq6b9WJ3TMYmPRC9gVnLns4KR24TrIy2kzSgWMMG3S
         rINn60RmSOITf0a7mY2FybmhSUzL3oNBgm4cyVd2WKckr11Yii9B9Z3puB7w3cVqNh9h
         T7iIGU3i6fNH76aK5ipfGpejBr494pYLeRuzhRsf6YUIKkAaXbwE4i/CPk6A0+0dt0ak
         2xtiFMNZcEyaufSImNqBp+lkg944NV6oHGCsyFAgO/ROL3gd8BBEsOo4xhLsYt+CuPmE
         lREA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WB0Pz5E7ntIgu1zMZuAYpVIOS5Vg0u3ZNRaPxkPt8jI=;
        b=dqzLvjA+KhDoghFQIgEFqV5Yod2LVLXLhZ6oaZMNdGXLmIpBTnFfQJja0SOS41j7sH
         ZMZIpSYT4i6dRIsi8v1XDFZ4Ccwl+g9fHrRZ82xB7QfYQAm18eHvWNEHG8iELhXprWHO
         z6c6O5OQZvqrIwcmcSCEnz5cBYJ8fIN3zbL12YfU0SMLUpJqvJoBJaH4zhT43zeXWyVk
         F0SRFXLbwZWMCfscC0WlDj/zLqaMq4AM354qZ/oB4bcA+XOC0Ak9km4354Q2b2l9XX8f
         1UoUDU6IzggZukd1plTJyPX1c4/tvF7lj2Mf+AUlUhrrL01dpRZJzxAwdcwjne882qB5
         A0zw==
X-Gm-Message-State: AOUpUlEjO3KUX5VSi9ebLXF3+VXCzxqE17uaTwjPw0o7b+bBfmyZzI0W
        W811DaS2YYmo6uOMlo4/ahmt3WPredk=
X-Google-Smtp-Source: AA+uWPznraIBQGKqf3rus7azdw0xqhIunIcWbPBeTuuwMrSXYv2+ORipc7NDb+EiiMT9KyxJhNsRWA==
X-Received: by 2002:a24:ac44:: with SMTP id m4-v6mr8882674iti.90.1534657095949;
        Sat, 18 Aug 2018 22:38:15 -0700 (PDT)
Received: from [192.168.43.158] ([172.58.139.120])
        by smtp.googlemail.com with ESMTPSA id x3-v6sm889176iob.6.2018.08.18.22.38.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Aug 2018 22:38:15 -0700 (PDT)
Subject: Re: dmaengine for sh7760 (was Re: use the generic dma-noncoherent
 code for sh V2)
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
References: <20180724120147.15096-1-hch@lst.de> <20180724202115.GA4685@lst.de>
 <18df6608-61c1-963d-bb1a-d46320232f40@landley.net>
 <CAK8P3a3bwFupzM14eigXfoQsLtj3cq_xv_p3=O924cgSceLE0g@mail.gmail.com>
 <418f3fa1-036f-d775-f1bc-e96778b4a4d8@landley.net>
 <CAK8P3a3x0f_op8PxOaWGNHQ3udg05T6NZggFAd7awns-FoL4yA@mail.gmail.com>
From:   Rob Landley <rob@landley.net>
Message-ID: <3f9fed2a-9800-8a86-2b1f-f7baaea74e54@landley.net>
Date:   Sun, 19 Aug 2018 00:38:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3x0f_op8PxOaWGNHQ3udg05T6NZggFAd7awns-FoL4yA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/17/2018 03:23 PM, Arnd Bergmann wrote:
> On Fri, Aug 17, 2018 at 7:04 PM Rob Landley <rob@landley.net> wrote:
>> On 07/31/2018 07:56 AM, Arnd Bergmann wrote:
>>> On Fri, Jul 27, 2018 at 6:20 PM, Rob Landley <rob@landley.net> wrote:
>>>> On 07/24/2018 03:21 PM, Christoph Hellwig wrote:
>>>>> On Tue, Jul 24, 2018 at 02:01:42PM +0200, Christoph Hellwig wrote:
>>>>>> Hi all,
>>> If you hack on it, please convert the dmaengine platform data to use
>>> a dma_slave_map array to pass the data into the dmaengine driver,
>>
>> The dmatest module didn't need it? I don't see why the ethernet driver would?
>> (Isn't the point of an allocator to allocate from a request?)
> 
> I guess you have hit two of the special cases here:
> 
> - dmatest uses the memory-to-memory DMA engine interface, not the slave
>   API, so you don't have to configure a slave at all

I've read through
https://www.kernel.org/doc/Documentation/driver-api/dmaengine/client.rst twice
and am still very unclear on the slave API.

> - smc91x (and its smc911x.c relative) are apparently special in that they
>   use they use the DMA slave API

Only sort of. In 4.14 at least it's under #ifdef ARCH_PXA and full of PXA
constants (PXAD_PRIO_LOWEST and such).

> but (AFAICT) require programming
>   the dmaengine hardware into a memory-to-memory transfer with no
>   DMA slave request signal and completely synchronous operation
>   (the IRQ handler polls for the DMA descriptor to be complete),
>   see also https://lkml.org/lkml/2018/4/3/464 for the discussion about
>   the recent rework of that driver's implementation.

Bookmarked, thanks.

(Being able to just upgrade to a 4.19 kernel or something and have DMA work in
this driver if I've got dmaengine set up for the platform would be lovely.)

>>> mapping the settings from a (pdev-name, channel-id) tuple to a pointer
>>> that describes the channel configuration rather than having the
>>> mapping from an numerical slave_id to a struct sh_dmae_slave_config
>>> in the setup files. It should be a fairly mechanical conversion.
>>
>> I think all 8 channels are generic. Drivers should be able to grab them and
>> release them at will, why does it need a table?
>>
>> (I say this not having made the smc91x.c driver use this yet, its "conversion"
>> to device tree left it full of PXA #ifdefs and constants, and I've tried the
> 
> Another point about smc91x is that it only uses DMA on the PXA platform,
> which is not part of the "multiplatform" ARM setup. It's likely that no
> other platform actually has a DMA engine that can talk to this device in
> the absence of a request signal, or that on more modern CPU cores,
> a readsl() is actually just as fast, but it avoids the setup cost of talking
> to the dma engine. Possibly both of the above.

The sh7760 has the CPU pegged at 100% trying to keep up with ethernet traffic.
Being able to use DMA on this would be very nice.

>> last half-dozen kernel releases and qemu releases and have yet to find an arm
>> mainstone board under qemu that _doesn't_ time out trying to use DMA with this
>> card. But that's another post...)
> 
> Is smc91x the only driver that you want to make use of the DMA engine?

This driver's the low-hanging fruit, yeah. Copying NOR flash jffs2 data into
page cache would be nice but there's a decompression step so I'm not sure that's
a win.

> I suspect that every other one currently relies on passing a slave ID
> shdma_chan_filter into dma_request_slave_channel_compat() or
> dma_request_channel() , which are some of the interfaces we want to
> remove in the future, to make everything work the same across
> all platforms.

What are "all platforms" in this context? I tried to find an x86 variant that
uses DMAEngine but came up empty. Can I use DMAEngine on a raspberry pi perhaps?
Is there a QEMU taret I can play with DMAEngine under?

I built a mainstone kernel with dmaengine amd smc91x both enabled, and booted it
on qemu-system-arm -M mainstone, and it works fine until I try to ping the host
(via the 10.0.2.2 redirect), at which point no packets are received and a timer
expires all over the console a few seconds later. I.E. the DMA claims to be
there, but the transfer never occurs.

I built and tested every Linux version back to 4.2 (before the smc91x was
converted from PXA dma to use DMAEngine, albeit in a very PXA specific manner).
I also tested each qemu release back to 2.3.0, with no obvious behavioral
difference.

I can dig further back in qemu history maybe? Ask on the qemu list? (Did this
ever work for anyone? I can post my kernel config and qemu command line if you
think it would help?)

> shdma_chan_filter() is one of those that expect its pointer argument to
> be a number that is in turn associated with an sh_dmae_slave_config
> structure in the platform data of the dma engine. What the newer
> dma_request_chan() interface does is to pass a pointer to the
> slave device and a string as identifier for the same data, which then
> gets associated through the dma_slave_map. On smc91x, both
> the device and name argument are NULL, which triggers the special
> case in the pxa dmaengine driver.

I do not understand what the slave map is for, is it documented anywhere? (The
Documentation/randomdir/dmaengine/client.nolongertxt file says: "The association
is done via DT, ACPI or board file based dma_slave_map matching table." which is
its only mention of the existence of dma_slave_map.

If the driver just needs "a channel" and doesn't care which one, why isn't the
config info for that channel in the driver as a generic request for resource?

>>> The other part I noticed is arch/sh/drivers/dma/*, which appears to
>>> be entirely unused, and should probably removed.
>>
>> I had to switch that off to get this to work, yes. I believe it predates
>> dmaengine and was obsoleted by it.
> 
> Ok. Have you found any reason to keep it around though?

I have not.

>        Arnd

Rob
