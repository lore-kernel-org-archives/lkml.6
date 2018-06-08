Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id CJN4CZ9CGlvpZwAAmS7hNA
	; Fri, 08 Jun 2018 08:47:27 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0D1A1608BA; Fri,  8 Jun 2018 08:47:27 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSBiKUXr"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5331E6074D;
	Fri,  8 Jun 2018 08:47:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5331E6074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932133AbeFHIrY (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 04:47:24 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:42207 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751108AbeFHIrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 04:47:20 -0400
Received: by mail-ua0-f196.google.com with SMTP id x18-v6so8389646uaj.9;
        Fri, 08 Jun 2018 01:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=k7NHztRHCDtxLiyifmQlv6URzyZnHgREFh6hTBdnG6U=;
        b=dSBiKUXrEA2lu+UDoFkZKLqUzS01mp4LY/Lv8gbzbIJHu7T/rgHuI8jGeDXxcK6YWZ
         uJ1rlSVTgPonIq79ys83Ifr7IEfjIWjAWML/LrEZJH5LwbctTIBp7+XeAihqZTK7fIm9
         R/tQjNebqS0wWA6XuscF9XW31gRXMh1dKVjI2cF9/AOgy2Pk+cY8k3XbBk5BmriE20Hd
         jl5bHPfYLMsi70somppSbGtE3mPNYSTynyq2CQ4yCS6a3lYZ4/RoJrtVOO7xWB4ufEBV
         I2LRzikOSNuM2O08D3F2edg2COuJoDtEH+008R/AAv0qcT3OwCL8E/xK2enL03x/0Gsp
         pCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=k7NHztRHCDtxLiyifmQlv6URzyZnHgREFh6hTBdnG6U=;
        b=rTeZ00QsudlEqMsLnPO6GlKmoQK3JrZUSIr1kEtTnHtHka7HdSMby1AYiaBHxF8tDo
         MSJRmnZWp3ULi6oO1/EwpoVXeZmkiwyLG3aZxWyqs8lASXY+YKS9+TI5KTZBZ+6BZ3XP
         JoIHVwvU6asDiyF/QhTwLa+ZuFyTO77PS7ScGtos2Oh1JpQTInYkDC/JQAvm+MjN0IE1
         9i4s568ryvzyxOKaN8hlK6P3/tIJMauAQr+pQ8eZspsjAL0UlxVgZSlLhrvHeHo17RmC
         jBflJLPHAQEmB021bJGmdAU/BDUZxaBSqWh0vkGXGmhuyKkaQE+2taPJ+T2Pz+HxAKCw
         iY8Q==
X-Gm-Message-State: APt69E3X7UuX9xRdVLZnBOwCcQnvapftgXH2EgTvFWArguzR1Sg08Wes
        C9OSGps6W+KG8TEcVJrukZ6lO0mU9/PKgSIbLHw=
X-Google-Smtp-Source: ADUXVKJYtgpMbhF3TGxiQLagbFWXUSRKqZ+iq1MTn5xb9XYMjiBdKxnKjizadmOvFGW9Yja0uYWGJc4vaooGiYh3ydg=
X-Received: by 2002:ab0:5922:: with SMTP id n31-v6mr3817055uad.114.1528447639376;
 Fri, 08 Jun 2018 01:47:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8596:0:0:0:0:0 with HTTP; Fri, 8 Jun 2018 01:47:18 -0700 (PDT)
In-Reply-To: <OSBPR01MB2054A701CF65784FAB947692D27B0@OSBPR01MB2054.jpnprd01.prod.outlook.com>
References: <1528198148-23308-1-git-send-email-michel.pollet@bp.renesas.com>
 <1528198148-23308-3-git-send-email-michel.pollet@bp.renesas.com>
 <0481173f-6384-98d6-707c-89dc5ef103f0@gmail.com> <OSBPR01MB2054E3A1E383495F3534B551D2650@OSBPR01MB2054.jpnprd01.prod.outlook.com>
 <9cef7124-3020-5741-f3a2-6925a6c8f0f3@gmail.com> <79c0899e-7df1-1fe7-9681-ad3bd51feda7@gmail.com>
 <OSBPR01MB205442B483C792125E6A6AF7D2640@OSBPR01MB2054.jpnprd01.prod.outlook.com>
 <CAL_JsqLn+x0JCkjwABU7XkPsgvyVdiCRq=gZTfUBbbR4-c+1bQ@mail.gmail.com> <OSBPR01MB2054A701CF65784FAB947692D27B0@OSBPR01MB2054.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 8 Jun 2018 10:47:18 +0200
X-Google-Sender-Auth: mPkPAO8vbYV29-V-FRZy6U9CYLk
Message-ID: <CAMuHMdUOqLhmb8kXOxriQ5mt_4rDQJbUqGsQiJBSkq5J5FWG7w@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] arm: shmobile: Add the R9A06G032 SMP enabler driver
To: Michel Pollet <michel.pollet@bp.renesas.com>
Cc: Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
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

On Fri, Jun 8, 2018 at 8:50 AM, Michel Pollet
<michel.pollet@bp.renesas.com> wrote:
> On 07 June 2018 16:55, Rob wrote:
>> On Thu, Jun 7, 2018 at 1:59 AM, Michel Pollet
>> <michel.pollet@bp.renesas.com> wrote:
>> > On 06 June 2018 22:53, Frank wrote:
>> >> On 06/06/18 14:48, Frank Rowand wrote:
>> >> > On 06/05/18 23:36, Michel Pollet wrote:
>> >> >> On 05 June 2018 18:34, Frank wrote:
>> >> >>> On 06/05/18 04:28, Michel Pollet wrote:
>> >> >>>> The Renesas R9A06G032 second CA7 is parked in a ROM pen at boot
>> >> >>>> time, it requires a special enable method to get it started.
>>
>> [...]
>>
>> >> >>>> + * The second CPU is parked in ROM at boot time. It requires
>> >> >>>> +waking it after
>> >> >>>> + * writing an address into the BOOTADDR register of sysctrl.
>> >> >>>> + *
>> >> >>>> + * So the default value of the "cpu-release-addr" corresponds
>> >> >>>> +to
>> >> >>> BOOTADDR...
>> >> >>>> + *
>> >> >>>> + * *However* the BOOTADDR register is not available when the
>> >> >>>> +kernel
>> >> >>>> + * starts in NONSEC mode.
>> >> >>>> + *
>> >> >>>> + * So for NONSEC mode, the bootloader re-parks the second CPU
>> >> >>>> +into a pen
>> >> >>>> + * in SRAM, and changes the "cpu-release-addr" of linux's DT to
>> >> >>>> +a SRAM address,
>> >> >>>> + * which is not restricted.
>> >> >>>
>> >> >>> The binding document for cpu-release-addr does not have a
>> >> >>> definition for 32 bit arm.  The existing definition is only 64
>> >> >>> bit arm.  Please add the definition for 32 bit arm to patch 1.
>> >> >>
>> >> >> Hmmm I do find a definition in
>> >> >> Documentation/devicetree/bindings/arm/cpus.txt -- just under where
>> >> >> I added my 'enable-method' -- And it is already used as 32 bits in
>> >> >> at least arch/arm/boot/dts/stih407-family.dtsi.
>> >> >
>> >> > If the correct answer is for cpu-release-addr to be 64 bits in
>> >> > certain cases (that discussion is ongoing further downthread) then
>> >> > one approach to maintain compatibility _and_ to fix the devicetree
>> >> > source files is to change the source code that currently gets
>> >> > cpu-release-addr as a
>> >> > 32 bit object to check the size of the property and get it as
>> >> > either a
>> >> > 32 bit or 64 bit object, based on the actual size of the property
>> >> > in the device tree and then change the value in the devicetree
>> >> > source files to be two cells.  BUT this does not consider the
>> >> > bootloader complication.  arch/arm/boot/dts/axm5516-cpus.dtsi has a
>> >> > note "// Fixed by the boot loader", so the boot loader also has to
>> >> > be modified to be able to handle the possibility that the property
>> >> > could be either
>> >> > 32 bits or 64 bits.  I don't know how to maintain compatibility
>> >> > with the boot loader since we can't force it to change
>> >> > synchronously with changes in the kernel.
>> >> >
>> >> > You can consider this comment to be a drive-by observation.  I
>> >> > think Rob and Geert and people like that are likely to be more
>> >> > helpful with what to actually do, and you can treat my comment more
>> >> > as pointing out the issue than as providing the perfect solution.
>> >>
>> >> Darn it, hit <send> too quickly.
>> >>
>> >> I meant to mention that there are several devicetree source files
>> >> that have a single cell value for cpu-release-addr, and thus
>> >> potentially face the same situation, depending on what the final
>> >> decision is on the proper size for cpu- release-addr. As of v4.17, a git grep
>> shows one cell values in:
>> >>
>> >>   arch/arm/boot/dts/axm5516-cpus.dtsi
>> >>   arch/arm/boot/dts/stih407-family.dtsi
>> >>   arch/arm/boot/dts/stih418.dtsi
>> >
>> > Yes, I had grepped before I used 32 bits on mine...
>> >
>> > Now, what is the decision here? Our bootloader is already modified to
>> > set it to 32 bits, so I propose that
>>
>> And too late to fix the bootloader?
>
>
> Well not too late, but read further on...
>
>>
>> >
>> > + I change the driver to handle 32 and 64 bits properties
>>
>> That's fine if you can't fix the bootloader.
>>
>> > + I add this to the cpu.txt, as a separate patch:
>> > # On other systems, the property can be either
>> >   32 bits or 64 bits, it is the driver's responsibility
>> >   to deal with either sizes.
>>
>> That is definitely not what we want to say. Use of 32-bit should be
>> considered out of spec. Yes, we have a few platforms in that category, but
>> they already handle that themselves. Would be nice to fix them, but at least
>> the STi platforms don't seem too active.
>>
>> IMO, we should delete whatever text we can here and at most just refer to
>> the spec.
>
> So actually I didn't use 32 bits by plain chance, I read the cpu.txt file which says
> that 64 bits systems use 64 bits property, concluded that in my case I ought to
> use 32 bits, then grepped around and found other systems using 32 bits, therefore
> I went forward and used it..
>
> Nothing said here that it should be 64 bits everywhere -- So the documentation
> needs fixing somehow. Right now it certainly led me wrong.

Perhaps we should add to Documentation/devicetree/bindings/ the standard
bindings from ePAPR and successors, too?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
