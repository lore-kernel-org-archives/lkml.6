Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Zn2XC7pDGFsaXgAAmS7hNA
	; Wed, 06 Jun 2018 20:29:03 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4B68B60290; Wed,  6 Jun 2018 20:29:03 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gk1iYUls"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8D8B8607E4;
	Wed,  6 Jun 2018 20:29:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8D8B8607E4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752787AbeFFU3A (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 16:29:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:34782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752369AbeFFU26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 16:28:58 -0400
Received: from mail-io0-f171.google.com (mail-io0-f171.google.com [209.85.223.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C38DB208A0;
        Wed,  6 Jun 2018 20:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528316937;
        bh=RsI/8j70vSe5YuUghAqVUDQOXn+pTDzp0gQY9n0cxRU=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=Gk1iYUls4Ud6gMvZHQ0Vw6+raWYLHZxY7tbR6Gk+P3d8M+RUoHSh91GYNEE9DtXHC
         Eh5qQb9qI9+pm3iZu7+sOAM/ME3LsZlARz3p96PBoYxtIbq+AghvkxF+CZMKNbLn9H
         pKGelGSSoqIJPhcThW+BolBB3Nvmz2HKgFUOAeiM=
Received: by mail-io0-f171.google.com with SMTP id t5-v6so9167950ioa.8;
        Wed, 06 Jun 2018 13:28:57 -0700 (PDT)
X-Gm-Message-State: APt69E0AzGIK5+J2aJyaBGJg34t6AsFgWbjg1wiQfImkgD9MvHXkPM09
        JUWGAEQ4qgQYuxqlQ9WnmvKhpGV9HC0LAXZL2A==
X-Google-Smtp-Source: ADUXVKI7BtKXDu3axxJK6/6cX6FkwRrvCS3nVYKvMLLarMnW893AF4cs3UD1naKbTISJviBK3RPlI93ho2VOnmtK5OM=
X-Received: by 2002:a6b:c689:: with SMTP id w131-v6mr4350051iof.79.1528316936995;
 Wed, 06 Jun 2018 13:28:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:5505:0:0:0:0:0 with HTTP; Wed, 6 Jun 2018 13:28:36 -0700 (PDT)
In-Reply-To: <CAMuHMdXv2UXTx_ttCqytH2TePoJ-Pw4gJ-PaSOmUL969ac1BMw@mail.gmail.com>
References: <1528198148-23308-1-git-send-email-michel.pollet@bp.renesas.com>
 <1528198148-23308-3-git-send-email-michel.pollet@bp.renesas.com>
 <0481173f-6384-98d6-707c-89dc5ef103f0@gmail.com> <OSBPR01MB2054E3A1E383495F3534B551D2650@OSBPR01MB2054.jpnprd01.prod.outlook.com>
 <bbbd287c-437e-d7bd-d40f-6bb914d96860@gmail.com> <CAL_JsqJCkP_c_wKGRc7Qzkiw8sZLRf6MGz-WgVsLjnQfqK8r6Q@mail.gmail.com>
 <CAMuHMdXv2UXTx_ttCqytH2TePoJ-Pw4gJ-PaSOmUL969ac1BMw@mail.gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 6 Jun 2018 15:28:36 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLvhsYRfp0_fkEQ4Gzub3W2vSN6KD0fZGoMmrVh__CayQ@mail.gmail.com>
Message-ID: <CAL_JsqLvhsYRfp0_fkEQ4Gzub3W2vSN6KD0fZGoMmrVh__CayQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] arm: shmobile: Add the R9A06G032 SMP enabler driver
To: Geert Uytterhoeven <geert@linux-m68k.org>
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

On Wed, Jun 6, 2018 at 2:42 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Rob,
>
> On Wed, Jun 6, 2018 at 9:35 PM, Rob Herring <robh+dt@kernel.org> wrote:
>> On Wed, Jun 6, 2018 at 2:30 PM, Frank Rowand <frowand.list@gmail.com> wrote:
>>> On 06/05/18 23:36, Michel Pollet wrote:
>>>> On 05 June 2018 18:34, Frank wrote:
>>>>> On 06/05/18 04:28, Michel Pollet wrote:
>>>>>> The Renesas R9A06G032 second CA7 is parked in a ROM pen at boot time,
>>>>>> it requires a special enable method to get it started.
>>>>>>
>>>>>> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
>
>>>>>> --- /dev/null
>>>>>> +++ b/arch/arm/mach-shmobile/smp-r9a06g032.c
>
>>>>>> +/*
>>>>>> + * The second CPU is parked in ROM at boot time. It requires waking
>>>>>> +it after
>>>>>> + * writing an address into the BOOTADDR register of sysctrl.
>>>>>> + *
>>>>>> + * So the default value of the "cpu-release-addr" corresponds to
>>>>> BOOTADDR...
>>>>>> + *
>>>>>> + * *However* the BOOTADDR register is not available when the kernel
>>>>>> + * starts in NONSEC mode.
>>>>>> + *
>>>>>> + * So for NONSEC mode, the bootloader re-parks the second CPU into a
>>>>>> +pen
>>>>>> + * in SRAM, and changes the "cpu-release-addr" of linux's DT to a
>>>>>> +SRAM address,
>>>>>> + * which is not restricted.
>>>>>
>>>>> The binding document for cpu-release-addr does not have a definition for 32
>>>>> bit arm.  The existing definition is only 64 bit arm.  Please add the definition
>>>>> for 32 bit arm to patch 1.
>>>>
>>>> Hmmm I do find a definition in
>>>> Documentation/devicetree/bindings/arm/cpus.txt -- just under where I
>>>> added my 'enable-method' -- And it is already used as 32 bits in at least
>>>> arch/arm/boot/dts/stih407-family.dtsi.
>>>
>>> From cpus.txt:
>>>
>>>         - cpu-release-addr
>>>                 Usage: required for systems that have an "enable-method"
>>>                        property value of "spin-table".
>>>                 Value type: <prop-encoded-array>
>>>                 Definition:
>>>                         # On ARM v8 64-bit systems must be a two cell
>>>                           property identifying a 64-bit zero-initialised
>>>                           memory location.
>>>
>>> The definition specifies a two cell property for 64-bit systems.
>>>
>>> Please add to the definition that cpu-release-addr is a one cell property
>>> for 32-bit systems.
>>
>> Actually, this is all already documented in the DT spec and it is
>> always 2 cells[1]. We should perhaps just remove whatever is
>> duplicated from the spec.
>>
>> Rob
>>
>> [1]
>>    ``cpu-release-addr``   | SD  | ``<u64>``        The
>> cpu-release-addr property is required for
>>                                                    cpu nodes that have
>> an enable-method property
>>                                                    value of
>> ``"spin-table"``. The value specifies the
>>                                                    physical address of
>> a spin table entry that
>>                                                    releases a
>> secondary CPU from its spin loop.
>
> Interesting. But why is this <u64>, and not just following #address-cells?

As you said in your other email, it's not the same.

> Due to the ePAPR-spec being 64-bit Power System-centric?

Other than #address-cells already having another defined purpose in
/cpus, my guess is 64-bit works for either and 32-bit SMP systems
didn't predate 64-bit (for the ePAPR author's perspective).

> There's also "initial-mapped-area", which must use 64-bit values for effective
> and physical addresses, according to ePAPR.

I would have thought that followed #{size,address}-cells being
/memory. Though, I guess the bootloader fills this in and it is much
easier to work with fixed sizes.

Rob
