Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id qosbBYxSGFsxYgAAmS7hNA
	; Wed, 06 Jun 2018 21:31:15 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 209F96089E; Wed,  6 Jun 2018 21:31:15 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSK0rglz"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7BAA860290;
	Wed,  6 Jun 2018 21:31:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7BAA860290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752448AbeFFVbM (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 17:31:12 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:46101 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752346AbeFFVbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 17:31:09 -0400
Received: by mail-pg0-f67.google.com with SMTP id d2-v6so3616231pga.13;
        Wed, 06 Jun 2018 14:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gnCpniQokRdRuauSITStzuHe3PcnYM3KxXVXElo2iLc=;
        b=TSK0rglz9wr65f6T75NpJsalrDw4EUlhiVkc2axp5OaK6V+VusLFXSlxaaft6bg+Wf
         f0ITLlW0P5+gxG0mevOEUAobEcO+/uypfIKLZ1DSwgPtiMZFj/a1aaSAZ3ZQyWgq7pWk
         wmvoJ/NgET2YN6o6oanldCgsx7/9fV3WLkCDoNE+3FPbA9x33Uzwa4GKVFUcmP/4lp9B
         touQwfKj5GFX3LS1o+53FIvXwDQ1gnyNR2xBtwiks9tOW9gPtzrEIB0G1UJLNOHGK73W
         l1zpawO8sUjR+exzv5jaiqJouzqfEiSkx9QdHSUSHPUFjY3f2w0GMJI4Ljcva/UQJ7FD
         W0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gnCpniQokRdRuauSITStzuHe3PcnYM3KxXVXElo2iLc=;
        b=b+vtlHs/XCccnmIL8P5Y8K6I40Bss5+hj9/fHB94fGxUeuS58ngYsNKqCfzR7wWZO2
         6Z36COhJzm/nLHNpbwv3k2QRFLoaIWXLaYJK2EKxAmriVmSUHuXpg2jPZ79ycSGxpCu9
         hDUsrpRxefeLumM3cJ9ofOqfwHwySRdis1v0hguWh3ro1PKTCwzQ27r3HbYiY87HdU07
         lFAv3wYsXBRDhXj8bmtEI4HoeVIMrHOLZj6wbbLo3xiUcXGFaasa7z7IwAQtTpSnTFrX
         3Qjezrs70fqsgXdBT+0X+KGQJnsnwyKo60ucur44wYhNSpQUXVKcy5XO9PDdsQOO28Kg
         AGgg==
X-Gm-Message-State: APt69E0UME4JyWTbuurt0puX5S9cBbXXF6ghtbCej73a3y70Cc8RMU8L
        aTOL9NOsj48+DRIvwV9/FZM=
X-Google-Smtp-Source: ADUXVKLWRDdKHED/s0qkJByUcaG+jPIcvsnbDkrh5g7u9oKV9PJ+T61c8ONfTugkHm6rm2ubYzUqfA==
X-Received: by 2002:a62:40dc:: with SMTP id f89-v6mr3934053pfd.194.1528320669389;
        Wed, 06 Jun 2018 14:31:09 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id f11-v6sm10082471pgo.62.2018.06.06.14.31.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 14:31:08 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] arm: shmobile: Add the R9A06G032 SMP enabler
 driver
To: Rob Herring <robh+dt@kernel.org>
Cc: Michel Pollet <michel.pollet@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Michel Pollet <buserror+upstream@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Douglas Anderson <dianders@chromium.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Carlo Caione <carlo@endlessm.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Frank Rowand <frank.rowand@sony.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
References: <1528198148-23308-1-git-send-email-michel.pollet@bp.renesas.com>
 <1528198148-23308-3-git-send-email-michel.pollet@bp.renesas.com>
 <0481173f-6384-98d6-707c-89dc5ef103f0@gmail.com>
 <OSBPR01MB2054E3A1E383495F3534B551D2650@OSBPR01MB2054.jpnprd01.prod.outlook.com>
 <bbbd287c-437e-d7bd-d40f-6bb914d96860@gmail.com>
 <CAL_JsqJCkP_c_wKGRc7Qzkiw8sZLRf6MGz-WgVsLjnQfqK8r6Q@mail.gmail.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <0197b272-d2d4-fc7b-b4c5-494d73ef1531@gmail.com>
Date: Wed, 6 Jun 2018 14:31:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJCkP_c_wKGRc7Qzkiw8sZLRf6MGz-WgVsLjnQfqK8r6Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/18 12:35, Rob Herring wrote:
> On Wed, Jun 6, 2018 at 2:30 PM, Frank Rowand <frowand.list@gmail.com> wrote:
>> Hi Michel,
>>
>> On 06/05/18 23:36, Michel Pollet wrote:
>>> Hi Frank,
>>>
>>> On 05 June 2018 18:34, Frank wrote:
>>>> On 06/05/18 04:28, Michel Pollet wrote:
>>>>> The Renesas R9A06G032 second CA7 is parked in a ROM pen at boot time,
>>>>> it requires a special enable method to get it started.
>>>>>
>>>>> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
>>>>> ---
>>>>>  arch/arm/mach-shmobile/Makefile        |  1 +
>>>>>  arch/arm/mach-shmobile/smp-r9a06g032.c | 79
>>>>> ++++++++++++++++++++++++++++++++++
>>>>>  2 files changed, 80 insertions(+)
>>>>>  create mode 100644 arch/arm/mach-shmobile/smp-r9a06g032.c
>>>>>
>>>>> diff --git a/arch/arm/mach-shmobile/Makefile
>>>>> b/arch/arm/mach-shmobile/Makefile index 1939f52..d7fc98f 100644
>>>>> --- a/arch/arm/mach-shmobile/Makefile
>>>>> +++ b/arch/arm/mach-shmobile/Makefile
>>>>> @@ -34,6 +34,7 @@ smp-$(CONFIG_ARCH_SH73A0)+= smp-sh73a0.o
>>>> headsmp-scu.o platsmp-scu.o
>>>>>  smp-$(CONFIG_ARCH_R8A7779)+= smp-r8a7779.o headsmp-scu.o
>>>> platsmp-scu.o
>>>>>  smp-$(CONFIG_ARCH_R8A7790)+= smp-r8a7790.o
>>>>>  smp-$(CONFIG_ARCH_R8A7791)+= smp-r8a7791.o
>>>>> +smp-$(CONFIG_ARCH_R9A06G032)+= smp-r9a06g032.o
>>>>>  smp-$(CONFIG_ARCH_EMEV2)+= smp-emev2.o headsmp-scu.o
>>>> platsmp-scu.o
>>>>>
>>>>>  # PM objects
>>>>> diff --git a/arch/arm/mach-shmobile/smp-r9a06g032.c
>>>>> b/arch/arm/mach-shmobile/smp-r9a06g032.c
>>>>> new file mode 100644
>>>>> index 0000000..cd40e6e
>>>>> --- /dev/null
>>>>> +++ b/arch/arm/mach-shmobile/smp-r9a06g032.c
>>>>> @@ -0,0 +1,79 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>> +/*
>>>>> + * R9A06G032 Second CA7 enabler.
>>>>> + *
>>>>> + * Copyright (C) 2018 Renesas Electronics Europe Limited
>>>>> + *
>>>>> + * Michel Pollet <michel.pollet@bp.renesas.com>,
>>>> <buserror@gmail.com>
>>>>> + * Derived from action,s500-smp
>>>>> + */
>>>>> +
>>>>> +#include <linux/io.h>
>>>>> +#include <linux/of.h>
>>>>> +#include <linux/of_address.h>
>>>>> +#include <linux/smp.h>
>>>>> +
>>>>> +/*
>>>>> + * The second CPU is parked in ROM at boot time. It requires waking
>>>>> +it after
>>>>> + * writing an address into the BOOTADDR register of sysctrl.
>>>>> + *
>>>>> + * So the default value of the "cpu-release-addr" corresponds to
>>>> BOOTADDR...
>>>>> + *
>>>>> + * *However* the BOOTADDR register is not available when the kernel
>>>>> + * starts in NONSEC mode.
>>>>> + *
>>>>> + * So for NONSEC mode, the bootloader re-parks the second CPU into a
>>>>> +pen
>>>>> + * in SRAM, and changes the "cpu-release-addr" of linux's DT to a
>>>>> +SRAM address,
>>>>> + * which is not restricted.
>>>>
>>>> The binding document for cpu-release-addr does not have a definition for 32
>>>> bit arm.  The existing definition is only 64 bit arm.  Please add the definition
>>>> for 32 bit arm to patch 1.
>>>
>>> Hmmm I do find a definition in
>>> Documentation/devicetree/bindings/arm/cpus.txt -- just under where I
>>> added my 'enable-method' -- And it is already used as 32 bits in at least
>>> arch/arm/boot/dts/stih407-family.dtsi.
>>
>> From cpus.txt:
>>
>>         - cpu-release-addr
>>                 Usage: required for systems that have an "enable-method"
>>                        property value of "spin-table".
>>                 Value type: <prop-encoded-array>
>>                 Definition:
>>                         # On ARM v8 64-bit systems must be a two cell
>>                           property identifying a 64-bit zero-initialised
>>                           memory location.
>>
>> The definition specifies a two cell property for 64-bit systems.
>>
>> Please add to the definition that cpu-release-addr is a one cell property
>> for 32-bit systems.
> 
> Actually, this is all already documented in the DT spec and it is
> always 2 cells[1]. We should perhaps just remove whatever is
> duplicated from the spec.

Thanks for noting that.  I jumped to the (incorrect) conclusion that the
property should be one cell based on the code and the .dtsi.

There are about 4 more emails following this in the thread that discuss
what size cpu-release-addr should be.  Whatever the end result is (one
cell or two or based on some #XXX-calls value), it needs to be documented
consistently in the binding and in the DT spec (or preferably only in the
DT spec), and if it is a two cell property for this system then
smp-r9a06g032.c and r9a06g032.dtsi need to be adjusted to reflect that.

-Frank

> 
> Rob
> 
> [1]
>    ``cpu-release-addr``   | SD  | ``<u64>``        The
> cpu-release-addr property is required for
>                                                    cpu nodes that have
> an enable-method property
>                                                    value of
> ``"spin-table"``. The value specifies the
>                                                    physical address of
> a spin table entry that
>                                                    releases a
> secondary CPU from its spin loop.
> 
