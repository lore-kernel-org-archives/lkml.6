Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AA3C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E78720862
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sM0SaMUO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E78720862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732190AbeGaO4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 10:56:17 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:38710 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732127AbeGaO4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 10:56:17 -0400
Received: by mail-it0-f68.google.com with SMTP id v71-v6so4262439itb.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 06:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gd6FczKcgRIMaz12jc53L8a0wxLtWSErqNudX5G3JIE=;
        b=sM0SaMUOWsJtoBqvx1bQs7tppqv+SNRFYqNLIud8lVrzk5Mw5IsItUdYhDzhhsFQcS
         m99tKdyR1hH5F/lbHp4Fk8Gxzh3bg+K8FXED0XSkWR1xawDsrU5n4MgH9Sl9or22bIm0
         9ARKC32K2eprmZx/HXmakRIXPUTmdvZrb2nN22IKXF8gBKrfwssZIfWmDJTmz1Tsb4ax
         NAQf0sUSvIn68kWIpXJ5OFhI11wzRXCrE6cwinp5HOSehC+g6JjPkTsXqifxtG456xkg
         kBJSwgk8w0NRqAcfdWog9eWSm3uvikTjT+phP8fFNGBFSzJTjRSjeKiaGYuyNJSM0fWN
         QxDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gd6FczKcgRIMaz12jc53L8a0wxLtWSErqNudX5G3JIE=;
        b=N9gMZVVwjY3veja2ZW2FY0sS6/AF/JDQ4mlEV/8oJ42hhpR1TwW/ABKjC/Qlx0JCYV
         8LEeBGqgkSgRKkNJyVBcuEDZGiODkmiqINSSM7W/25AeMGa2EQce4ZHJYIYDr3f9+uvq
         L9UmuFwuIcZzPg48kKN8M8GfcafrHvJNj7SFa7wal81gEl8LC/oFzzXQ3YqCqhRHeqAT
         WL7YkuApYr+W3jE1/9Eh9QDC6oFyeRJlVCxeR1h8Yzeoj9U9VrRGrUr2IVorvLbG9KvE
         eHhjowNQteJQtH2nw1x+mz5R7nz3OkqsNWnLjnJFSQiEHCTyezEiYGMZJp2vTVrD/EpF
         b46A==
X-Gm-Message-State: AOUpUlEy6D9TarbDAupMmhHS0FcspMhLX6iv2NP5sr/mEwzP3BtbVrV6
        4WqV6CTNcq6AVFulnvgfKBk=
X-Google-Smtp-Source: AAOMgpfj9x52nwh0rAIR6yRdpctmUWc+yi9QQIVnKqZq6cGbNaeSPFgnFWp0Iyjy71/XG/eR1IzocQ==
X-Received: by 2002:a24:d442:: with SMTP id x63-v6mr3094415itg.152.1533042960164;
        Tue, 31 Jul 2018 06:16:00 -0700 (PDT)
Received: from [10.0.2.15] ([72.138.96.106])
        by smtp.gmail.com with ESMTPSA id v3-v6sm4501860iop.78.2018.07.31.06.15.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 06:15:59 -0700 (PDT)
Subject: Re: [PATCH 5/6] arm: enable RapidIO menu in Kconfig
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Alexei Colin <acolin@isi.edu>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Paul Walters <jwalters@isi.edu>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180730225035.28365-1-acolin@isi.edu>
 <20180730225035.28365-6-acolin@isi.edu> <20180731120428.GA5696@infradead.org>
 <3784698f-bd9d-6d02-6fa4-2f6057e4c93f@gmail.com>
 <20180731124815.GK17271@n2100.armlinux.org.uk>
From:   Alex Bounine <alex.bou9@gmail.com>
Message-ID: <bfc9daa3-6dd6-55ed-6a2b-f12f07fc6021@gmail.com>
Date:   Tue, 31 Jul 2018 09:15:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180731124815.GK17271@n2100.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-31 08:48 AM, Russell King - ARM Linux wrote:
> On Tue, Jul 31, 2018 at 08:43:02AM -0400, Alex Bounine wrote:
>> On 2018-07-31 08:04 AM, Christoph Hellwig wrote:
>>> On Mon, Jul 30, 2018 at 06:50:33PM -0400, Alexei Colin wrote:
>>>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>>>> index afe350e5e3d9..602a61324890 100644
>>>> --- a/arch/arm/Kconfig
>>>> +++ b/arch/arm/Kconfig
>>>> @@ -1278,6 +1278,8 @@ config PCI_HOST_ITE8152
>>>>   source "drivers/pci/Kconfig"
>>>> +source "drivers/rapidio/Kconfig"
>>>
>>> Please include this from drivers/Kconfig instead of enabling it
>>> for a completely random set of architectures.
>>>
>> This is not a random set of architectures but only ones that implement
>> support for RapidIO as system bus.
>>
>> On some platforms RapidIO can be the only system bus available replacing
>> PCI/PCIe.
>>
>> As it is done now, RapidIO is configured in "Bus Options" (x86/PPC) or "Bus
>> Support" (ARMs) sub-menu and from system configuration option it should be
>> kept this way.
>>
>> Current location of RAPIDIO configuration option is familiar to users of
>> PowerPC and x86 platforms, and is similarly available in some ARM
>> manufacturers kernel code trees.
> 
> ... which is why you have a HAS_RAPIDIO thing and select it from
> arch/*/Kconfig as I suggested in my original review of your patch
> set.

Correct, this option will be selected as soon as board that supports it 
is added.

> 
> As I've also said, I'm unable to review what you've sent this time
> around because I don't have all your patches.
> 
I think Alexei will resend full set soon.

