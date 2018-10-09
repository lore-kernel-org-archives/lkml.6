Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91944C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 493E02086D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=as-electronics.de header.i=@as-electronics.de header.b="PljazNe3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 493E02086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=exceet.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbeJIVUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 17:20:38 -0400
Received: from mo4-p05-ob.smtp.rzone.de ([85.215.255.133]:14765 "EHLO
        mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbeJIVUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 17:20:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1539093807;
        s=strato-dkim-0002; d=as-electronics.de;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=Y9lUzQris0ewwY7TxRc5B5jmxQNazfVae7pdzKt8rhM=;
        b=PljazNe3t0QhsfaOMUhhbvXBbn2ZXh9ZDSLriIYszMefV0lM6xciI4ziK5k/ELHirF
        gyCB8V0B0mmnIfnLZLhFnMVZ5fQqolk4yL7v718R1wUip6SnUzBtKYSov6EEQ4dilvSj
        Bkxj8wKwVhX/T1xVLtaL5s0u6Pu26fhq618Dz09vRvYkYwzKrgHY7pplwlsBdXb+ww44
        P0MO/UDkd9BiiTifyZgqaB/tjxvjuCCiKUoMRGpxCvGO7T5u3tiyKfOTPDmCnpUSZtpM
        JWeb2+pGhEI0fK1kS2pIfjaeokymmWNOIzZJb88bg28YDYod/DIRIMG/Aqj8vCHueaAy
        Oc1g==
X-RZG-AUTH: ":LX8JdEmkW/4tAFwMkcNJIloh1hrA5u3owhPk7bdT5Fx2zAOrX/r2ZbrrxoyMly7vtKoBCSu4zR9/f0shzjGSYbJY5KbsbrlTGd0CtJA="
X-RZG-CLASS-ID: mo05
Received: from [IPv6:2003:a:e7a:6200:246c:2a8b:f45a:a33d]
        by smtp.strato.de (RZmta 44.2 AUTH)
        with ESMTPSA id h039efu99E3CM1a
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 9 Oct 2018 16:03:12 +0200 (CEST)
Subject: Re: [PATCH 2/2] mmc: Add mmc_force_detect_change_begin / _end
 functions
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Hans de Goede <hdegoede@redhat.com>,
        quentin.schulz@free-electrons.com, ulf.hansson@linaro.org,
        gregkh@linuxfoundation.org, linus.walleij@linaro.org,
        shawn.lin@rock-chips.com, adrian.hunter@intel.com,
        baolin.wang@linaro.org, thomas.petazzoni@free-electrons.com,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        devel@driverdev.osuosl.org, icenowy@aosc.xyz, wens@csie.org
References: <CAPDyKFqDrdD+N+foLCwsVABtboz1Vn=OtJs14gp07zJfXHVKSA@mail.gmail.com>
 <f9028dcb-c217-4efc-60a7-d0a2c1804a08@exceet.de>
 <d9795fde-6bdd-b6fa-da41-839d44df6435@redhat.com>
 <20180927081452.a2xw25sdoqtadntu@flea>
 <85c2baea-8dbb-ef1b-93d2-7749c5a100e6@exceet.de>
 <20181009075230.aaxne3z247yc3lu6@qschulz>
From:   Frieder Schrempf <frieder.schrempf@exceet.de>
Message-ID: <d44615b8-32e0-1c71-97bb-13c1994239fb@exceet.de>
Date:   Tue, 9 Oct 2018 16:03:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181009075230.aaxne3z247yc3lu6@qschulz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

On 09.10.2018 09:52, Quentin Schulz wrote:
> Hi Frieder,
> 
> On Mon, Oct 08, 2018 at 11:53:21AM +0200, Frieder Schrempf wrote:
>> Hi,
>>
>> On 27.09.2018 10:14, Maxime Ripard wrote:
>>> On Wed, Sep 26, 2018 at 10:19:22PM +0200, Hans de Goede wrote:
>>>> On 26-09-18 16:44, Frieder Schrempf wrote:
>>>>> Hi,
>>>>>
>>>>> On Fri, Feb 09, 2018 at 03:01:00PM +0100, Ulf Hansson wrote:
>>>>>> [...]
>>>>>>
>>>>>>>>> I'd like to know if any progress has been made on that problem
>>>>> (I may
>>>>>>>>> have missed patches).
>>>>>>>>> Had you had the time to look at the issue?
>>>>>>>>
>>>>>>>> I have looked at the issue, but not manage to cook some patches
>>>>> for it.
>>>>>>>>
>>>>>>>> However, it's on my top of my TODO list for mmc. No promises, but
>>>>>>>> perhaps and hopefully I manage to get something posted during the
>>>>>>>> coming release cycle.
>>>>>
>>>>> I would be interested in a ESP8089 driver in mainline and that's why I want to pick up this discussion.
>>>>>
>>>>> What is the current status of the "mmc_reprobe_device" implementation, that Hans was explaining and Ulf wanted to provide some months ago?
>>>>
>>>> Ulf did eventually write a new way to deal with this and then Quentin
>>>> did manage to get the esp8089 driver to work with it, the new function
>>>> to use for this is added by this commit:
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/mmc/core?id=1433269c4d2461be1f36db5dbb453976b38996ff
>>>>
>>>> I'm not sure what the status of upstreaming the ep8089 driver is now
>>>> that we've this in place.
>>>>
>>>> Quentin, do you have a version of the esp8089 driver somewhere
>>>> which will work correctly with the new mmc_sw_reset() function?
>>>>
>>>> Also what is the status of adding this driver to say staging?
>>>
>>> IIRC, we tried to get it into staging, and we got told that it was too
>>> nice for staging at this point. So we're basically stuck somewhere
>>> between staging and !staging, with the driver being too nice for the
>>> former, and not nice enough for the latter :)
>>
>> Ok, and is there someone willing to continue upstreaming the driver? Maybe
>> someone can rebase and resend the latest approach?
>>
>> After all it looks like a lot of work has already been done.
>>
> 
> There's clean up to do. It's time consuming but shouldn't be too hard to
> do.
> 
> Then, we stressed the driver with an iperf test and it crashes very
> often so we first need to identify if it happened with the "original"
> driver before Icenowy's, Hans's and my clean-up. If it happened, since
> we don't have a datasheet, it might be not that easy to fix. If it
> didn't happen, then we have to find out where I cleaned up too much :D
> 
> I'm not currently working on this topic so anyone willing to take over
> the work is free to do so.

Thanks a lot for providing the details. It is currently not clear on our 
side, if the project with the ESP8089 will happen, but if that's the 
case we might pick up the work.

Thanks
Frieder
