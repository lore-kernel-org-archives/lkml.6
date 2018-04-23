Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754158AbeDWHp3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 03:45:29 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:45546 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754113AbeDWHpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 03:45:22 -0400
X-Google-Smtp-Source: AIpwx49oN9wJwiIvEHGuDRQrDDC/wQg7hVSLpMHc+XgYtjKfl1gUmo9kcAaIdtF5HdbdlP/1r+9eWdYG9IR9FMCPMJc=
MIME-Version: 1.0
X-Originating-IP: [217.140.96.140]
In-Reply-To: <CAMuHMdUh4MxSoVb5x_FjTgCzrK0Pb_EV-G8npZB6m24d+UJ4Wg@mail.gmail.com>
References: <1523988865-26848-1-git-send-email-geert@linux-m68k.org>
 <CAOtvUMeJLXxB3v2wr8EQFKxXpMo3Oi64Ac8aGA5vLDo37dQWjw@mail.gmail.com> <CAMuHMdUh4MxSoVb5x_FjTgCzrK0Pb_EV-G8npZB6m24d+UJ4Wg@mail.gmail.com>
From: Gilad Ben-Yossef <gilad@benyossef.com>
Date: Mon, 23 Apr 2018 10:45:21 +0300
Message-ID: <CAOtvUMd-_w1r6c3_AswuVPDNTjzVOPso1yyYx+ke77HMRhYkRQ@mail.gmail.com>
Subject: Re: [PATCH/RFC] crypto: Add platform dependencies for CRYPTO_DEV_CCREE
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2018 at 10:47 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Gilad,
>
> On Wed, Apr 18, 2018 at 6:32 AM, Gilad Ben-Yossef <gilad@benyossef.com> wrote:
>> On Tue, Apr 17, 2018 at 9:14 PM, Geert Uytterhoeven
>> <geert@linux-m68k.org> wrote:
>>> The ARM TrustZone CryptoCell is found on ARM SoCs only.  Hence make it
>>> depend on ARM or ARM64, unless compile-testing.
>>
>> Actually it is not. Despite what the name suggest, CryptoCell is
>> designed by Arm but is
>> not in fact limited to Arm cores. I think the only requirement is
>> ability to provide an AMBA bus
>> interface. Kudos to our marketing department to make that so clear and
>> so on... :-)
>
> Good to know, I couldn't find any users of the compatible value in DT sources,
> so I had to guess... and missed ;-)

Yes, the original driver that went through staging was for CC 712,
which so new it doesn't yet
have a commercially available silicon yet :-)

I've added the older 710 and 613 support just recently and will be
working with CC hardware implementors
to add the relevant DT bindings for their respective SoCs

>
> Do you have a good suggestion for a platform dependency?
> Based on the above, I'd say "depends on ARM_AMBA || COMPILE_TEST",
> but (currently) ARM_AMBA is selected on ARM or ARM64 only?

So AMBA *as a system bus* is not strictly needed AFAIK in the sense
that you just need
an AMBA to whatever bus interface, so not all system implementing this
actually define ARM_AMBA.

It's actually safer for me to rule out certain architectures rather
than point to which are used.
I'd say ruling out s390, um, alpha, ia64 and m68k is a safe bet.

Do you want to send a patch or shall I?

Thanks,
Gilad


>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds



-- 
Gilad Ben-Yossef
Chief Coffee Drinker

"If you take a class in large-scale robotics, can you end up in a
situation where the homework eats your dog?"
 -- Jean-Baptiste Queru
