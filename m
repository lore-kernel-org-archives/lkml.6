Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AA6C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 19:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38E2C21EFC
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 19:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSGKHuqX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38E2C21EFC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbeHIWIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 18:08:46 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33673 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbeHIWIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 18:08:46 -0400
Received: by mail-oi0-f68.google.com with SMTP id 8-v6so11949697oip.0;
        Thu, 09 Aug 2018 12:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8JBQKlq/kNHalGoYH0563aL/tADMqSytw+aX2LFeF/M=;
        b=lSGKHuqXwkygx+07/OAwBq4C51M9eMWBhniVpUNMUBBo5NTfk3hNiHFkOQq7P5kqcG
         MIlGHYiABbowLRYizkC9NCRQYAPRGnKq3YK8xUyBUUizI0ayg+87knMAa973EB6GBXdh
         GQruA4uNLgkwXeXi/2kvPZNwNBVhv2xuVtpuAewUDA1lB9qDiGdSwmxYZAwpY1F/M3HG
         Hg00PZwkrz5+aqDkZPgWgc2cM+5bu6ao9jYeSnGOuP1FU8eGaH7DkbAj7CB5c/lZ6+Sc
         2WDz/aAcNl/D5wedSRdo73d8djCxaWHutIC8rM/TtHBMaWqozl/B3sD5Dp6uaMYJHLGP
         x88A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8JBQKlq/kNHalGoYH0563aL/tADMqSytw+aX2LFeF/M=;
        b=IgI+SITIithlB/7rtc9Cw+++gIidy+i1U2rOh80ubCaSTSpZHfBOe3+S3tuh4P5UAB
         DxyQsgMNlTiHejUqQkJnGNn5cgarY8JGCEdavNHc87QiUugDLJEZHYYsDy+4+Nr5YAua
         qlluTaSI0Ao2yKcq/iDs6YsJwPWoo2DWV9kMhvHojVLjTZapVVBiO7zN5Kxd6gmnYU3T
         ZcCNTMq1ysenTfqWf5Jl0ICHjB0IIogDg8jCT5PB/imOvP1Dqnx/rVyXAM8wv+7ZttxA
         2kvDa0N8CABt9dlb5sxZekNYN7NouIbDsvUy/0GenBcOvcWG43kx5iPjj6ITKY0C4oBf
         niSA==
X-Gm-Message-State: AOUpUlHTchtGUfQq4IHKyUEcTV4JwC8l9PopzwDikzMaYfjA7YOtwQGR
        pb6fshq6uoOstvo8/P0oPQ59xchdpNU=
X-Google-Smtp-Source: AA+uWPxgaEac6vSyqbPWzbnDVWAAOfm28JObA2HIq1OzX/Rc31DM1ENMtrpA4Ua4kktppv6v7wXiXw==
X-Received: by 2002:aca:3110:: with SMTP id x16-v6mr3381911oix.126.1533843747409;
        Thu, 09 Aug 2018 12:42:27 -0700 (PDT)
Received: from nuclearis2-1.gtech (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id o206-v6sm8697172oif.7.2018.08.09.12.42.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 12:42:26 -0700 (PDT)
Subject: Re: [PATCH] PCI/AER: Do not clear AER bits if we don't own AER
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Alex_Gagniuc@Dellteam.com, bhelgaas@google.com,
        keith.busch@intel.com, Austin.Bolen@dell.com, Shyam.Iyer@dell.com,
        fred@fredlawl.com, poza@codeaurora.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180717153135.25925-1-mr.nuke.me@gmail.com>
 <20180809141551.GH49411@bhelgaas-glaptop.roam.corp.google.com>
 <2cae6a5ac8324be18b8dcf3d7dfcc288@ausx13mps321.AMER.DELL.COM>
 <20180809182905.GA113140@bhelgaas-glaptop.roam.corp.google.com>
 <d235e71d-647f-00d1-8a21-2784b7939c25@gmail.com>
 <20180809191832.GC113140@bhelgaas-glaptop.roam.corp.google.com>
From:   "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <cb5bc2ce-d55f-bd39-55fb-177c6cd6c05f@gmail.com>
Date:   Thu, 9 Aug 2018 14:42:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180809191832.GC113140@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/09/2018 02:18 PM, Bjorn Helgaas wrote:
> On Thu, Aug 09, 2018 at 02:00:23PM -0500, Alex G. wrote:
>> On 08/09/2018 01:29 PM, Bjorn Helgaas wrote:
>>> On Thu, Aug 09, 2018 at 04:46:32PM +0000, Alex_Gagniuc@Dellteam.com wrote:
>>>> On 08/09/2018 09:16 AM, Bjorn Helgaas wrote:
>> (snip_
>>>>>      enable_ecrc_checking()
>>>>>      disable_ecrc_checking()
>>>>
>>>> I don't immediately see how this would affect FFS, but the bits are part
>>>> of the AER capability structure. According to the FFS model, those would
>>>> be owned by FW, and we'd have to avoid touching them.
>>>
>>> Per ACPI v6.2, sec 18.3.2.4, the HEST may contain entries for Root
>>> Ports that contain the FIRMWARE_FIRST flag as well as values the OS is
>>> supposed to write to several AER capability registers.  It looks like
>>> we currently ignore everything except the FIRMWARE_FIRST and GLOBAL
>>> flags (ACPI_HEST_FIRMWARE_FIRST and ACPI_HEST_GLOBAL in Linux).
>>>
>>> That seems like a pretty major screwup and more than I want to fix
>>> right now.
>>
>> The logic is not very clear, but I think it goes like this:
>> For GLOBAL and FFS, disable native AER everywhere.
>> When !GLOBAL and FFS, then only disable native AER for the root port
>> described by the HEST entry.
> 
> I agree the code is convoluted, but that sounds right to me.
> 
> What I meant is that we ignore the values the HEST entry tells us
> we're supposed to write to Device Control and the AER Uncorrectable
> Error Mask, Uncorrectable Error Severity, Correctable Error Mask, and
> AER Capabilities and Control.

Wait, what? _HPX has the same information. This is madness!
Since root ports are not hot-swappable, the BIOS normally programs those 
registers. Even if linux doesn't apply said masks, the programming BIOS 
did should be sufficient to have *cough* correct *cough* behavior.

>>>> For practical considerations this is not an issue today. The ACPI error
>>>> handling code currently crashes when it encounters any fatal error, so
>>>> we wouldn't hit this in the FFS case.
>>>
>>> I wasn't aware the firmware-first path was *that* broken.  Are there
>>> problem reports for this?  Is this a regression?
>>
>> It's been like this since, I believe, 3.10, and probably much earlier. All
>> reports that I have seen of linux crashing on surprise hot-plug have been
>> caused by the panic() call in the apei code. Dell BIOSes do an extreme
>> amount of work to determine when it's safe to _not_ report errors to the OS,
>> since all known OSes crash on this path.
> 
> Oh, is this the __ghes_panic() path?  If so, I'm going to turn away
> and plead ignorance unless the PCI core is doing something wrong that
> eventually results in that panic.

I agree, and I'll quote you on that!

Alex
