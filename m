Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id w2ZdKFRVGVuZNAAAmS7hNA
	; Thu, 07 Jun 2018 15:55:19 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8DD5E607E7; Thu,  7 Jun 2018 15:55:19 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ba8iDx5v"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E2943601D2;
	Thu,  7 Jun 2018 15:55:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E2943601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934444AbeFGPzR (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:55:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:49792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933699AbeFGPzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:55:14 -0400
Received: from mail-it0-f54.google.com (mail-it0-f54.google.com [209.85.214.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB0C52086E;
        Thu,  7 Jun 2018 15:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528386913;
        bh=Ahv9R/0mGB6aQf9bAECV3z+yofIjl9XWQv8aQD0sgiE=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=Ba8iDx5v6rSm1WYhrFUOMPeIzl0GDU/11lZR4mvCwk5qN9BlP8GMoYulOa9tXu1Kg
         UIo7Nf3dz8ntnBrvfTPFkuzFQLDm2GQVyQk+UwyykyL17LZKHgR9gv3I2zZwrEn7qR
         yiiA83g8972lnvznoWMg9Sx6rIy5Iixs8ltRgnqw=
Received: by mail-it0-f54.google.com with SMTP id n7-v6so13516104itn.1;
        Thu, 07 Jun 2018 08:55:13 -0700 (PDT)
X-Gm-Message-State: APt69E08R+Kgas4/v/DUvM8oo5VlCmDFEr12R2/dP4H4a5FmhYQVAfkW
        jDSRYiv1rA5m4vxAdeJzoiQwU5rcD6e+yz9K+Q==
X-Google-Smtp-Source: ADUXVKLGe28tPsZm48d9mVzkW8zmXv5aRamr2d2ZkMOP0eZzY9O0bg8hu2Inp9JZE9wLvX1XsThcqUOsGfOt23Qo9n4=
X-Received: by 2002:a24:ec44:: with SMTP id g65-v6mr2654124ith.18.1528386913189;
 Thu, 07 Jun 2018 08:55:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:5505:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 08:54:52 -0700 (PDT)
In-Reply-To: <OSBPR01MB205442B483C792125E6A6AF7D2640@OSBPR01MB2054.jpnprd01.prod.outlook.com>
References: <1528198148-23308-1-git-send-email-michel.pollet@bp.renesas.com>
 <1528198148-23308-3-git-send-email-michel.pollet@bp.renesas.com>
 <0481173f-6384-98d6-707c-89dc5ef103f0@gmail.com> <OSBPR01MB2054E3A1E383495F3534B551D2650@OSBPR01MB2054.jpnprd01.prod.outlook.com>
 <9cef7124-3020-5741-f3a2-6925a6c8f0f3@gmail.com> <79c0899e-7df1-1fe7-9681-ad3bd51feda7@gmail.com>
 <OSBPR01MB205442B483C792125E6A6AF7D2640@OSBPR01MB2054.jpnprd01.prod.outlook.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 7 Jun 2018 10:54:52 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLn+x0JCkjwABU7XkPsgvyVdiCRq=gZTfUBbbR4-c+1bQ@mail.gmail.com>
Message-ID: <CAL_JsqLn+x0JCkjwABU7XkPsgvyVdiCRq=gZTfUBbbR4-c+1bQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] arm: shmobile: Add the R9A06G032 SMP enabler driver
To: Michel Pollet <michel.pollet@bp.renesas.com>
Cc: Frank Rowand <frowand.list@gmail.com>,
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

On Thu, Jun 7, 2018 at 1:59 AM, Michel Pollet
<michel.pollet@bp.renesas.com> wrote:
> On 06 June 2018 22:53, Frank wrote:
>> On 06/06/18 14:48, Frank Rowand wrote:
>> > On 06/05/18 23:36, Michel Pollet wrote:
>> >> Hi Frank,
>> >>
>> >> On 05 June 2018 18:34, Frank wrote:
>> >>> On 06/05/18 04:28, Michel Pollet wrote:
>> >>>> The Renesas R9A06G032 second CA7 is parked in a ROM pen at boot
>> >>>> time, it requires a special enable method to get it started.

[...]

>> >>>> + * The second CPU is parked in ROM at boot time. It requires
>> >>>> +waking it after
>> >>>> + * writing an address into the BOOTADDR register of sysctrl.
>> >>>> + *
>> >>>> + * So the default value of the "cpu-release-addr" corresponds to
>> >>> BOOTADDR...
>> >>>> + *
>> >>>> + * *However* the BOOTADDR register is not available when the
>> >>>> +kernel
>> >>>> + * starts in NONSEC mode.
>> >>>> + *
>> >>>> + * So for NONSEC mode, the bootloader re-parks the second CPU into
>> >>>> +a pen
>> >>>> + * in SRAM, and changes the "cpu-release-addr" of linux's DT to a
>> >>>> +SRAM address,
>> >>>> + * which is not restricted.
>> >>>
>> >>> The binding document for cpu-release-addr does not have a definition
>> >>> for 32 bit arm.  The existing definition is only 64 bit arm.  Please
>> >>> add the definition for 32 bit arm to patch 1.
>> >>
>> >> Hmmm I do find a definition in
>> >> Documentation/devicetree/bindings/arm/cpus.txt -- just under where I
>> >> added my 'enable-method' -- And it is already used as 32 bits in at
>> >> least arch/arm/boot/dts/stih407-family.dtsi.
>> >
>> > If the correct answer is for cpu-release-addr to be 64 bits in certain
>> > cases (that discussion is ongoing further downthread) then one
>> > approach to maintain compatibility _and_ to fix the devicetree source
>> > files is to change the source code that currently gets
>> > cpu-release-addr as a
>> > 32 bit object to check the size of the property and get it as either a
>> > 32 bit or 64 bit object, based on the actual size of the property in
>> > the device tree and then change the value in the devicetree source
>> > files to be two cells.  BUT this does not consider the bootloader
>> > complication.  arch/arm/boot/dts/axm5516-cpus.dtsi has a note "//
>> > Fixed by the boot loader", so the boot loader also has to be modified
>> > to be able to handle the possibility that the property could be either
>> > 32 bits or 64 bits.  I don't know how to maintain compatibility with
>> > the boot loader since we can't force it to change synchronously with
>> > changes in the kernel.
>> >
>> > You can consider this comment to be a drive-by observation.  I think
>> > Rob and Geert and people like that are likely to be more helpful with
>> > what to actually do, and you can treat my comment more as pointing out
>> > the issue than as providing the perfect solution.
>>
>> Darn it, hit <send> too quickly.
>>
>> I meant to mention that there are several devicetree source files that have a
>> single cell value for cpu-release-addr, and thus potentially face the same
>> situation, depending on what the final decision is on the proper size for cpu-
>> release-addr. As of v4.17, a git grep shows one cell values in:
>>
>>   arch/arm/boot/dts/axm5516-cpus.dtsi
>>   arch/arm/boot/dts/stih407-family.dtsi
>>   arch/arm/boot/dts/stih418.dtsi
>
> Yes, I had grepped before I used 32 bits on mine...
>
> Now, what is the decision here? Our bootloader is already modified to set it to 32 bits, so I propose that

And too late to fix the bootloader?

>
> + I change the driver to handle 32 and 64 bits properties

That's fine if you can't fix the bootloader.

> + I add this to the cpu.txt, as a separate patch:
> # On other systems, the property can be either
>   32 bits or 64 bits, it is the driver's responsibility
>   to deal with either sizes.

That is definitely not what we want to say. Use of 32-bit should be
considered out of spec. Yes, we have a few platforms in that category,
but they already handle that themselves. Would be nice to fix them,
but at least the STi platforms don't seem too active.

IMO, we should delete whatever text we can here and at most just refer
to the spec.

Rob
