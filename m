Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64E5C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9705B20851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="aHUFLTyh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9705B20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbeKSW7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 17:59:38 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:35776 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728724AbeKSW7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 17:59:37 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id E682724E0C74;
        Mon, 19 Nov 2018 04:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1542630966; bh=FLB4Eq3tYdIau5jOx45En6/r+rsKTWF76zHlbhJVonI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=aHUFLTyhsuzimrTl2uj0NBQjnLGKQadewiEHoY0NO+5eLycEq9IzsxU7vuwZ30O2k
         KhppQG9c8t4GtFAajTSLpfqxxOBiDT9+Eh4X/d21WoqxOBUz8/vV9QOo3/+qmbw9vL
         b5OqhcKRuREDDmMH7VOrt0JC7LrVdawPppi544nGGmZ+QwiTC1cAlAet/+JM821swe
         GNIBaehdAHzJxdyyCqDDXby0ZHG8KMQg/kQuuopt2ipKqivBodeH3bxhLiiiXWep56
         JYQVS9/DsJs8Aa+IV/UQmBbL6eJjGnVON3nsQqmEFwED+sq+SAk5q+Ae3ygg0yd4Td
         2IItXQynH2Ddg==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        by mailhost.synopsys.com (Postfix) with ESMTP id 765AA3A15;
        Mon, 19 Nov 2018 04:36:03 -0800 (PST)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 19 Nov 2018 04:36:03 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 19 Nov 2018 13:36:01 +0100
Received: from [10.0.2.15] (10.107.19.165) by DE02WEHTCA.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 19 Nov
 2018 13:36:00 +0100
Subject: Re: [PATCH v10 0/9] Add the I3C subsystem
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        vitor <vitor.soares@synopsys.com>
CC:     Wolfram Sang <wsa@the-dreams.de>, <linux-i2c@vger.kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        "Cyprian Wronka" <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "Rafal Ciepiela" <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        "Kumar Gala" <galak@codeaurora.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        <linux-gpio@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>,
        Peter Rosin <peda@axentia.se>,
        Mike Shettel <mshettel@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Mark Brown <broonie@kernel.org>
References: <20181026144333.12276-1-boris.brezillon@bootlin.com>
 <76b1d15d-232c-d8ba-5eba-8394e71be725@synopsys.com>
 <20181115135731.25f60990@bbrezillon> <20181115150137.GB4169@kunai>
 <20181115162826.42b54776@bbrezillon>
 <1d64f21a-ad24-94e0-2c17-25729ef59a31@synopsys.com>
 <20181115200058.1869afdb@bbrezillon>
 <5f946406-a205-3802-aefd-ebd8b5a72b0b@synopsys.com>
 <20181116141639.31074113@bbrezillon>
From:   vitor <vitor.soares@synopsys.com>
Message-ID: <ffcc3c3d-0bfd-23e2-5fbb-00cfbcd6b7af@synopsys.com>
Date:   Mon, 19 Nov 2018 12:35:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181116141639.31074113@bbrezillon>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.107.19.165]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 16/11/18 13:16, Boris Brezillon wrote:
> On Fri, 16 Nov 2018 12:31:42 +0000
> vitor <vitor.soares@synopsys.com> wrote:
>
>> Hi Boris,
>>
>>
>> On 15/11/18 19:00, Boris Brezillon wrote:
>>> On Thu, 15 Nov 2018 18:03:47 +0000
>>> vitor <vitor.soares@synopsys.com> wrote:
>>>   
>>>> Hi Boris,
>>>>
>>>>
>>>> On 15/11/18 15:28, Boris Brezillon wrote:
>>>>> On Thu, 15 Nov 2018 16:01:37 +0100
>>>>> Wolfram Sang <wsa@the-dreams.de> wrote:
>>>>>      
>>>>>> Hi Boris,
>>>>>>      
>>>>>>> What we could do though, is expose I3C devices that do not have a
>>>>>>> driver in kernel space, like spidev does.
>>>>>> ...
>>>>>>      
>>>>>>> Mark, Wolfram, Arnd, Greg, any opinion?
>>>>>> Is there a benefit for having drivers in userspace? My gut feeling is to
>>>>>> encourage people to write kernel drivers. If this is, for some reason,
>>>>>> not possible for some driver, then we have a use case at hand to test
>>>>>> the then-to-be-developed userspace interface against. Until then, I
>>>>>> personally wouldn't waste effort on designing it without a user in
>>>>>> sight.
>>>>> I kind of agree with that. Vitor, do you have a use case in mind for
>>>>> such userspace drivers? I don't think it's worth designing an API for
>>>>> something we don't need (yet).
>>>> My use case is a tool for tests, lets say like the i2c tools.
>>> What would you like to test exactly?
>>>   
>>>> There is
>>>> other subsystems, some of them mentioned on this thread, that have and
>>>> ioctl system call or other method to change parameters or send data.
>>> I don't think they added the /dev interface before having a real use
>>> case for it.
>>>   
>>>> I rise this topic because I really think it worth to define now how this
>>>> should be design (and for me how to do the things right) to avoid future
>>>> issues.
>>> Actually it should be done the other way around: you should have a real
>>> need and the /dev interface should be designed to fulfill this need.
>>> Based on this real use case we can discuss other potential usage that
>>> might appear in the future and try to design something more
>>> future-proof, but clearly, this userspace interface should be driven by
>>> a real/well-defined use case.
>>>
>>> Also, exposing things to userspace is way more risky than adding a new
>>> in-kernel subsystem/framework, because it then becomes part of the
>>> stable ABI.
>>>
>>> To make things clearer, I'm not against the idea of exposing I3C
>>> devices (or I3C buses) to userspace, but I'd like to understand what you
>>> plan to do with that. If this is about testing, what kind of tests
>>> you'd like to run. If this is about developing drivers in userspace,
>>> why can't these be done in kernel space (license issues?), and what
>>> would those drivers be allowed to do?
>>
>> Basically I need a tool that help me during the development and to avoid
>> me to write a dummy driver for each device that I test.
> But we want I3C device drivers to be upstreamed, so why not developing a
> real driver everytime you test a new device and submitting it upstream?


Usually the devices that I test aren't the final product so it isn't 
easy to do the upstream.

But when possible I plan to do that.


>
>> For instances do some read/write,
> Doing SDR/DDR transfers is probably acceptable, but I still think we
> should push hard to have kernel drivers when that's possible.
>
>> get/set ccc commands,
> Exposing CCC commands is definitely not a good idea, since they're not
> even exposed to kernel drivers.
>
>> if something
>> goes wrong during the bus initialization have a to debug etc...
> Can't we add such a debug infrastructure in the kernel. Maybe we can
> expose debugfs files too if that helps, though if those debugfs files
> are actually used by userspace libs/tools, it's not any better than
> ioctls or sysfs files, since they will anyway become a stable ABI.
>
>>
>> For me this is a valid use case and I imagine when people start to
>> develop in i3c this interface will help everyone.
> How about you propose an i3cdev driver that allow users to do SDR
> transfers throuh an ioctl?

I think that was for v6 I started to something to expose the bus like in 
i2c-dev, but I liked the idea of expose only the device doesn't have a 
driver. Do you know if  there is already something in the kernel doing 
the same?


Best regards,

Vitor Soares

