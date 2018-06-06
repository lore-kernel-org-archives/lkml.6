Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id FMZ8Kgk5GFuIaQAAmS7hNA
	; Wed, 06 Jun 2018 19:43:07 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 76D0D608C1; Wed,  6 Jun 2018 19:43:07 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khNPHDKG"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id DA917607E4;
	Wed,  6 Jun 2018 19:43:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DA917607E4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752729AbeFFTnE (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 15:43:04 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:41385 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752351AbeFFTnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 15:43:02 -0400
Received: by mail-ua0-f195.google.com with SMTP id a5-v6so4841284uao.8;
        Wed, 06 Jun 2018 12:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=MZ/kQT2cl0qguV//e4JqeArWb+wCGNyoCzkjL7NkzYg=;
        b=khNPHDKGi/tHmPs7p+TlOfHrZZdAEBekQZRTzitlXg1el7/TPlXXi10kyd4o7qISel
         9Ky6MiLkUwB2xjye29vhodn8KmDbiyZ/XXLO6qi/36P1j/bjc5fOQvkIEe+PZresPK5h
         nlDeyqoEB7+cW1e8CjORxBkdXFI5MW/H2wtIhiDPvvrXX0j5eam/jfoFW1dC8atiYWj8
         UQk4cP6kQxzProKvmRWD6NuNsG5cmOlafG7OghUmAWgXJu3lgXy3IayAPT+Cvrbd/1e/
         pKjKLlc3iqbw/Ppn3wGL2zR1GvSYeMyGf4LTWe0Wik2qGhWNJbc9lmXXM4KzpVt6NnLX
         Gm+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=MZ/kQT2cl0qguV//e4JqeArWb+wCGNyoCzkjL7NkzYg=;
        b=iSZsXzDAxGlaZ0tH0lsgCMbjwJnRlw8mF+9IB6p2XO6dbSThX/6nVWcIBUdQfPeWgo
         isdbMwt/JvgaweL41J7V2zZJbINn1Sd0fNBHtOqpyw+Acr2ukQsITkhRcMucKN7jvlbL
         LekVzsZzDiEqADwPwW+2uzr9MuYp5Zp36riDj+wMlS+qiFBB1Qjxjqe++QCc2ygC4OkW
         //M66CKe1UsF6p75kzVizQxuWcLpi81uyqZApmCQf5W3nKDs0BcIjFApXO6z/KMA3Lo5
         GwqurW22InEMvKaz4tmPOKVbnNASbE7XQMUXajF/16INEXq9lUosq6hoHqPVcw3SYxLX
         g+FA==
X-Gm-Message-State: APt69E2vccdpX64a3v2dmYM7C9qy8evXZWmhd9TaUDdzDSbdqhLBxN5K
        yiUSeg4/zP0eryu/5dVKxgcbVbshEZBMuoBgEbOTzRHh
X-Google-Smtp-Source: ADUXVKI8p56Poo+dSZE6K4ZO2v2ERyYBcWds47jaafx/fRlaL9ZJksxzWmjrIbfyxMoK2qHzNdCyc3A1I+IfVFZjBkE=
X-Received: by 2002:ab0:96:: with SMTP id 22-v6mr2967205uaj.4.1528314180251;
 Wed, 06 Jun 2018 12:43:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8596:0:0:0:0:0 with HTTP; Wed, 6 Jun 2018 12:42:59 -0700 (PDT)
In-Reply-To: <CAL_JsqJCkP_c_wKGRc7Qzkiw8sZLRf6MGz-WgVsLjnQfqK8r6Q@mail.gmail.com>
References: <1528198148-23308-1-git-send-email-michel.pollet@bp.renesas.com>
 <1528198148-23308-3-git-send-email-michel.pollet@bp.renesas.com>
 <0481173f-6384-98d6-707c-89dc5ef103f0@gmail.com> <OSBPR01MB2054E3A1E383495F3534B551D2650@OSBPR01MB2054.jpnprd01.prod.outlook.com>
 <bbbd287c-437e-d7bd-d40f-6bb914d96860@gmail.com> <CAL_JsqJCkP_c_wKGRc7Qzkiw8sZLRf6MGz-WgVsLjnQfqK8r6Q@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 6 Jun 2018 21:42:59 +0200
X-Google-Sender-Auth: AT3qgQRdMpkPQPBhaT_9sn4PIhk
Message-ID: <CAMuHMdXv2UXTx_ttCqytH2TePoJ-Pw4gJ-PaSOmUL969ac1BMw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] arm: shmobile: Add the R9A06G032 SMP enabler driver
To: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
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
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Frank Rowand <frank.rowand@sony.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Wed, Jun 6, 2018 at 9:35 PM, Rob Herring <robh+dt@kernel.org> wrote:
> On Wed, Jun 6, 2018 at 2:30 PM, Frank Rowand <frowand.list@gmail.com> wrote:
>> On 06/05/18 23:36, Michel Pollet wrote:
>>> On 05 June 2018 18:34, Frank wrote:
>>>> On 06/05/18 04:28, Michel Pollet wrote:
>>>>> The Renesas R9A06G032 second CA7 is parked in a ROM pen at boot time,
>>>>> it requires a special enable method to get it started.
>>>>>
>>>>> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>

>>>>> --- /dev/null
>>>>> +++ b/arch/arm/mach-shmobile/smp-r9a06g032.c

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

Interesting. But why is this <u64>, and not just following #address-cells?
Due to the ePAPR-spec being 64-bit Power System-centric?

There's also "initial-mapped-area", which must use 64-bit values for effective
and physical addresses, according to ePAPR.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
