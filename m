Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id zfuTAf03GFtoXwAAmS7hNA
	; Wed, 06 Jun 2018 19:38:15 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2A31F608B8; Wed,  6 Jun 2018 19:38:15 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHoGxvl7"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8DCAA607F7;
	Wed,  6 Jun 2018 19:38:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8DCAA607F7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752609AbeFFTiN (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 15:38:13 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:43681 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752517AbeFFTiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 15:38:10 -0400
Received: by mail-qt0-f196.google.com with SMTP id y89-v6so7646446qtd.10;
        Wed, 06 Jun 2018 12:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lmXqksawfcVlUptD0kz6x4A07KLDvEUWZSXqhUK3zaA=;
        b=fHoGxvl7yTLMAD/eVuAkkwvRg2RyF3Zl62JW+tteLRJNj2pFp3IZmXGfjRoZzGDDzw
         XT2scvdzf1QGvq4bmRAWS1wbceEYPZDJ2RKxDlW8F//zt95fEBNduP3QzRT7CSMptDHV
         d/1XqhuaqU9DNTFbH8FUG/2dq3SGoMLbINl4UX8BgCAHbcvqtolq6QnokImJ9OcbK1jK
         ZNVcLhWmBjRZKpuJVHIQECL0j7/DGd9EDcBsFLPRgn4CNoxnWUDOShcwp/bKb/mcuGoj
         I2hKTAtmV/d6JBs6AFsFXpy/86Fs1dp4eVHX9wqic8KiEn5zUBOnrrWPk2ZGeBBf3Kgj
         lA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=lmXqksawfcVlUptD0kz6x4A07KLDvEUWZSXqhUK3zaA=;
        b=bPyixWMxbCljPL57VF8Lc0EAxSLKItOcviPP/6wXmWN4fCMvfgFQRnjsmBFEo7K2Cg
         3TTayY6hcvApKB4d1TYEkXLfA8LX/uR7uI+r8WbAd8YF3rEk/x7hCkRwuqV7YJQPgVzF
         et53b2IA00Tin/dHtHyxDMqtcd1M953PWPtU02zSVF4OTPauploHb5iCStiLUsXbg/NH
         705Dj4QW8MwCJAMsqETUG1QjIhi9kMmnaTVtvLXWQz7fiXtO+Vx3qkuHs3k9nOOXZEDq
         TYGabHxbMpsRgoehJt4vwR+1i8ofnn4tmnXDCkedJaU9AH0lYko16CpDfeRIjwDXkkUi
         38hA==
X-Gm-Message-State: APt69E1stD+MyCeYKq5kkNaI+7fTy4/C1oDCvB+xikDt9/0xUeu/9bPb
        niAtYG0Dn2EMfy/TGsJ9FSM=
X-Google-Smtp-Source: ADUXVKK8o2Sy5yk+4oepjvwOeideACXNwP9EaZ/nAmmurxMxCMzx2Ltzq9e9WY2G97zX9VJ1aGgMXQ==
X-Received: by 2002:a0c:e28a:: with SMTP id r10-v6mr3978350qvl.172.1528313889227;
        Wed, 06 Jun 2018 12:38:09 -0700 (PDT)
Received: from [10.69.41.93] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id 34-v6sm16022989qtt.76.2018.06.06.12.38.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 12:38:08 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] arm: shmobile: Add the R9A06G032 SMP enabler
 driver
To: Frank Rowand <frowand.list@gmail.com>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>
Cc: Michel Pollet <buserror+upstream@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Douglas Anderson <dianders@chromium.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
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
From: Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <7e49c265-e332-29c5-5d91-4b5d5da6cb37@gmail.com>
Date: Wed, 6 Jun 2018 12:37:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <bbbd287c-437e-d7bd-d40f-6bb914d96860@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/2018 12:30 PM, Frank Rowand wrote:
> Hi Michel,
> 
> On 06/05/18 23:36, Michel Pollet wrote:
>> Hi Frank,
>>
>> On 05 June 2018 18:34, Frank wrote:
>>> On 06/05/18 04:28, Michel Pollet wrote:
>>>> The Renesas R9A06G032 second CA7 is parked in a ROM pen at boot time,
>>>> it requires a special enable method to get it started.
>>>>
>>>> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
>>>> ---
>>>>  arch/arm/mach-shmobile/Makefile        |  1 +
>>>>  arch/arm/mach-shmobile/smp-r9a06g032.c | 79
>>>> ++++++++++++++++++++++++++++++++++
>>>>  2 files changed, 80 insertions(+)
>>>>  create mode 100644 arch/arm/mach-shmobile/smp-r9a06g032.c
>>>>
>>>> diff --git a/arch/arm/mach-shmobile/Makefile
>>>> b/arch/arm/mach-shmobile/Makefile index 1939f52..d7fc98f 100644
>>>> --- a/arch/arm/mach-shmobile/Makefile
>>>> +++ b/arch/arm/mach-shmobile/Makefile
>>>> @@ -34,6 +34,7 @@ smp-$(CONFIG_ARCH_SH73A0)+= smp-sh73a0.o
>>> headsmp-scu.o platsmp-scu.o
>>>>  smp-$(CONFIG_ARCH_R8A7779)+= smp-r8a7779.o headsmp-scu.o
>>> platsmp-scu.o
>>>>  smp-$(CONFIG_ARCH_R8A7790)+= smp-r8a7790.o
>>>>  smp-$(CONFIG_ARCH_R8A7791)+= smp-r8a7791.o
>>>> +smp-$(CONFIG_ARCH_R9A06G032)+= smp-r9a06g032.o
>>>>  smp-$(CONFIG_ARCH_EMEV2)+= smp-emev2.o headsmp-scu.o
>>> platsmp-scu.o
>>>>
>>>>  # PM objects
>>>> diff --git a/arch/arm/mach-shmobile/smp-r9a06g032.c
>>>> b/arch/arm/mach-shmobile/smp-r9a06g032.c
>>>> new file mode 100644
>>>> index 0000000..cd40e6e
>>>> --- /dev/null
>>>> +++ b/arch/arm/mach-shmobile/smp-r9a06g032.c
>>>> @@ -0,0 +1,79 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * R9A06G032 Second CA7 enabler.
>>>> + *
>>>> + * Copyright (C) 2018 Renesas Electronics Europe Limited
>>>> + *
>>>> + * Michel Pollet <michel.pollet@bp.renesas.com>,
>>> <buserror@gmail.com>
>>>> + * Derived from action,s500-smp
>>>> + */
>>>> +
>>>> +#include <linux/io.h>
>>>> +#include <linux/of.h>
>>>> +#include <linux/of_address.h>
>>>> +#include <linux/smp.h>
>>>> +
>>>> +/*
>>>> + * The second CPU is parked in ROM at boot time. It requires waking
>>>> +it after
>>>> + * writing an address into the BOOTADDR register of sysctrl.
>>>> + *
>>>> + * So the default value of the "cpu-release-addr" corresponds to
>>> BOOTADDR...
>>>> + *
>>>> + * *However* the BOOTADDR register is not available when the kernel
>>>> + * starts in NONSEC mode.
>>>> + *
>>>> + * So for NONSEC mode, the bootloader re-parks the second CPU into a
>>>> +pen
>>>> + * in SRAM, and changes the "cpu-release-addr" of linux's DT to a
>>>> +SRAM address,
>>>> + * which is not restricted.
>>>
>>> The binding document for cpu-release-addr does not have a definition for 32
>>> bit arm.  The existing definition is only 64 bit arm.  Please add the definition
>>> for 32 bit arm to patch 1.
>>
>> Hmmm I do find a definition in
>> Documentation/devicetree/bindings/arm/cpus.txt -- just under where I
>> added my 'enable-method' -- And it is already used as 32 bits in at least
>> arch/arm/boot/dts/stih407-family.dtsi.
> 
> From cpus.txt:
> 
>         - cpu-release-addr
>                 Usage: required for systems that have an "enable-method"
>                        property value of "spin-table".
>                 Value type: <prop-encoded-array>
>                 Definition:
>                         # On ARM v8 64-bit systems must be a two cell
>                           property identifying a 64-bit zero-initialised
>                           memory location.
> 
> The definition specifies a two cell property for 64-bit systems.
> 
> Please add to the definition that cpu-release-addr is a one cell property
> for 32-bit systems.

Or maybe phrase it such that the number of cells encoded in
cpu-release-addr must exactly match the CPU node's #address-cells size?
-- 
Florian
