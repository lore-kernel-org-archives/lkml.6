Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6006C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A49205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JRevrlwP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95A49205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967218AbeFSSUE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 14:20:04 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:36052 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966562AbeFSSUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 14:20:03 -0400
Received: by mail-it0-f68.google.com with SMTP id j135-v6so1787473itj.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 11:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WolFalcJFODJWFVKQIvbXOZhDG5urYr76kVKH4rvvWg=;
        b=JRevrlwPtDplrJnIiGHuaUE8lnhUajIwovl/UvWQUymwRNrJyst4eCJxcgZ1KCtRV7
         xtoav4K9ndbDAg4givJrtlg84QLQMPtTtSnrJZh121fJ/CrDuccVD5M1eCDzo5FAdDtA
         x8D+bl1CVFHYgY29CqT6V3qbNPI8kXYmKCXfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WolFalcJFODJWFVKQIvbXOZhDG5urYr76kVKH4rvvWg=;
        b=PI5RIpRxgZBM2dETu4ZoYjzL66YCPcJHapofErBjjYtpFmO164+qmOUuYTGv6CfRON
         iAMIlfW3rM9X8PeSfhWF9RBnuGmoKQIAe7nX2Ki5AefRimE3pExKyilKNfy2o+GdGtGT
         4PEAUzDUSGRLyWKtLBXJcRx31jRXdWgu8A2/7JA79pUhZYGmmsUq3imaXc4IXpLJkE3h
         hwx/A8r7mj1C7ydFKqpOgHyieEboUY+ENj22XFAAhv5M1bYEE08CUtY3UgAz4PMai5QE
         7crCq8bz1GsaWpC9knHsah7ztkr1BQ08d+E5z/52eaaH7TLhuXHi50b8HuJTx6UKtWb2
         3m7A==
X-Gm-Message-State: APt69E0+CiJznbkp6aUCS0iOMJ7SsZDkmeIGdrHdARatvFITieMTb8Bc
        1dkifOqns04wkS5WOhRItf4N+KLw+yx6TdH0oPECsQ==
X-Google-Smtp-Source: ADUXVKK+VNbfjrGy4mVi40ulk4yQjs2I9pZ6ztj1BBuPweiwKEr3oIxoCSYXkWSLNs+n9gysmdlKhZuDNRYa0aSfZ0U=
X-Received: by 2002:a02:6001:: with SMTP id i1-v6mr14815913jac.5.1529432402687;
 Tue, 19 Jun 2018 11:20:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bbc7:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 11:20:02
 -0700 (PDT)
In-Reply-To: <CAKv+Gu9JTsKEwwKN4OjmNHLf_86s753f2yEdo=7esERdUCaWiQ@mail.gmail.com>
References: <1529384828-2452-1-git-send-email-linux@roeck-us.net>
 <CAKv+Gu8Byj7G3Awnq4Y90Wot=GJTx0gO5A7-960au9ZkBBL2=A@mail.gmail.com>
 <b8bff03d-91a7-0e53-a44e-d1924beb382d@roeck-us.net> <CAKv+Gu-T8Fx3Nry7pUdOoOeRU-Ns89w3oo4itmu1q4FzYF5Rag@mail.gmail.com>
 <20180619172422.GB16846@roeck-us.net> <CAKv+Gu9JTsKEwwKN4OjmNHLf_86s753f2yEdo=7esERdUCaWiQ@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 19 Jun 2018 20:20:02 +0200
Message-ID: <CAKv+Gu-SWaq0s46x_RCQ_TVN2vCBFp_NDmW3jUgUyMrbGoLcbA@mail.gmail.com>
Subject: Re: [RFC PATCH] ARM: Use logical or instead of addition for badr
 address calculation
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 June 2018 at 20:17, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 19 June 2018 at 19:24, Guenter Roeck <linux@roeck-us.net> wrote:
>> On Tue, Jun 19, 2018 at 03:35:07PM +0200, Ard Biesheuvel wrote:
>>> >>
>>> >> +       /* this needs to be a separate macro or \@ does not work correctly
>>> >> */
>>> >> +       .macro  __badr, c, rd, sym
>>> >> +       .eqv    .Lsym\@, \sym
>>> >> +       adr\c   \rd, .Lsym\@ + 1
>>> >
>>> >
>>> > Wild shot, but the following works for me.
>>> >
>>> >         .eqv    .Lsym\@, \sym + 1
>>> >         adr\c   \rd, .Lsym\@
>>> >
>>> > Does it make sense ?
>>> >
>>>
>>> Interesting. Do you mean this works with your 2.30 binutils that
>>> triggers the original issue?
>>>
>>
>> Yes, it does. It is also the solution used for some graphics libraries,
>> though of course now I don't find the link anymore.
>>
>> Guess this is going nowhere given Russell's response, so I'll just
>> live with it, like obviously everyone else does already. I built
>> a toolchain using gcc 7.3.0 and binutils 2.28.1 which "solves"
>> the problem for me.
>>
>
> If we can live with using a wide encoding unconditionally, we could
> consider something like below. That forces the symbol references to be
> resolved at link time, which means we completely sidestep the new GAS
> code.
>
> -----------8<----------------
> From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Date: Tue, 16 Jan 2018 12:12:45 +0000
> Subject: [PATCH] ARM: assembler: prevent ADR from setting the Thumb bit twice
>
> To work around recent issues where ADR references to Thumb function
> symbols may or may not have the Thumb bit set already when they are
> resolved by GAS, reference the symbol indirectly via a global symbol
> typed as 'function', and emit a relocation that lets the linker fix
> up the reference.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
> index 6ae42ad29518..1a55ce4b245c 100644
> --- a/arch/arm/include/asm/assembler.h
> +++ b/arch/arm/include/asm/assembler.h
> @@ -195,13 +195,22 @@
>         .irp    c,,eq,ne,cs,cc,mi,pl,vs,vc,hi,ls,ge,lt,gt,le,hs,lo
>         .macro  badr\c, rd, sym
>  #ifdef CONFIG_THUMB2_KERNEL
> -       adr\c   \rd, \sym + 1
> +       __badr  \c, \rd, \sym
>  #else
>         adr\c   \rd, \sym
>  #endif
>         .endm
>         .endr
>
> +       /* this needs to be a separate macro or \@ does not work correctly */
> +       .macro          __badr, c, rd, sym
> +       .globl          .Lsym_\sym\()_\@
> +       .type           .Lsym_\sym\()_\@, %function
> +       .set            .Lsym_\sym\()_\@, \sym
> +       .reloc          ., R_ARM_THM_ALU_PREL_11_0, .Lsym_\sym\()_\@
> +       adr\c\().w      \rd, .
> +       .endm
> +
>  /*
>   * Get current thread_info.
>   */

It seems we can drop the .globl btw
