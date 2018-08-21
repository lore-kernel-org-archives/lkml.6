Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E195CC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 18:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C09B21837
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 18:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tKvbdv9A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C09B21837
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbeHUVfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 17:35:18 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39690 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbeHUVfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 17:35:17 -0400
Received: by mail-pf1-f195.google.com with SMTP id j8-v6so8877017pff.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 11:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=huxYcu7rr1SM4YgUjlQ2CXSFiyHYGA4MJn92PprdvTU=;
        b=tKvbdv9ANX61rsRs3dleTy8U1EvQy080VfHQr9uH7EAXuEuymWWT1XIBdy7NBsXtyz
         S2QI5G8ndrwuBmX64Xx/AN572sVv2C3G6kFuBD6SER4SPyraO/L1Ica17Uq3y2krm7k2
         iMZHhbW9oX59pNmimQqaxa7gL0A7roPU67YWesal5fscjoWFUh/ipN+gKfApGlGaPxl8
         dS6mIAW7X7Eshfpbk/zNHctMZ+xvK6R0cQYsijRm9Nmsnsc9dAsjqY5GpPbKygs5a5rV
         TuzwG4s5vIGMnHlDZtCOP1yl+/txzSSENqcwjKJQ+JQHA069knbuNtboQTfVRpqaqGz9
         i4TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=huxYcu7rr1SM4YgUjlQ2CXSFiyHYGA4MJn92PprdvTU=;
        b=jhp7Mv+7bXaZSqhywMMtXY237rVugtz6HQjia3Sc7HvK7b+vSxsYM7oVNWK9Ir5l6F
         BcmMaVt1AKntln150PVzEkiPxZcD0TsLdoy4ugopVgKn8fjF81acpusa5WFH66jvZxJw
         6CsxrBc5/fvhuR8Ji2lfTk4gqU1caMUDsL/G4Qap8fto53ZzjuyfVtSITrNqUtLkheii
         4jIuCGluZHdO2o4gH1PCuWh1doYVi96OH7HBmf1w5MupLhkO9F1Z44W7oTIxxck7ZKVF
         H6PGf5+6XmWsLVbAb+VuK+N/FPLR+uabF8WU2+R8TMyNzPbtoEAmxH6p2iWxbXioaSZl
         8r+g==
X-Gm-Message-State: AOUpUlG6Y8JHXmFwCfJcGL0QHcfi9cmmkX4BD0fgChAvNGQisp9vnM4P
        8STQBZ2owwsdesIKMw1WiCWmWnR5/I45JrJ9R+VGjA==
X-Google-Smtp-Source: AA+uWPzxfyW8vDOUbfR0ke8MicOhjdvFDEK3AG50laIDK5zctCv/yKsTVpHJVMNgfQXIPiZwU2XFdVqzM4//cQywBbU=
X-Received: by 2002:a63:c24c:: with SMTP id l12-v6mr20975608pgg.255.1534875244924;
 Tue, 21 Aug 2018 11:14:04 -0700 (PDT)
MIME-Version: 1.0
References: <20180820224032.53194-1-ndesaulniers@google.com>
 <CAKv+Gu-xAmadr96vwStOxdeqi=rCEBrn8V6GofexBhpmA=JiuA@mail.gmail.com>
 <CAKwvOdkZR-MWuMU=j=kKXQwA0LEj1n0uoZQyTpwOzZuz9gjmJQ@mail.gmail.com>
 <CAKv+Gu8ZZYvh9ZthRH7mvG7_j3bvT=3st-aj0kdwpNQaAcs=-w@mail.gmail.com> <0dda3996-a4f3-33f8-ef4f-935943f132b4@arm.com>
In-Reply-To: <0dda3996-a4f3-33f8-ef4f-935943f132b4@arm.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 21 Aug 2018 11:13:53 -0700
Message-ID: <CAKwvOdnpBT=73JOG-OO36NgnGCGr6HNxhEKsCBDOAX=WR5HB=Q@mail.gmail.com>
Subject: Re: [PATCH] arm64/crypto: remove non-standard notation
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-crypto@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 10:25 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 21/08/18 18:00, Ard Biesheuvel wrote:
> > On 21 August 2018 at 18:50, Nick Desaulniers <ndesaulniers@google.com> wrote:
> >> On Tue, Aug 21, 2018 at 5:23 AM Ard Biesheuvel
> >> <ard.biesheuvel@linaro.org> wrote:
> >>>
> >>> Hi Nick,
> >>>
> >>> On 21 August 2018 at 00:40, Nick Desaulniers <ndesaulniers@google.com> wrote:
> >>>> It seems that:
> >>>> ldr q8, =0x30000000200000001
> >>>>
> >>>> is a GNU as convience notation for:
> >>>> ldr q8, .Lconstant
> >>>> .Lconstant
> >>>> .word 0x00000001
> >>>> .word 0x00000002
> >>>> .word 0x00000003
> >>>> .word 0x00000000
> >>>>
> >>>> based on this comment in binutils' source [0]. I've asked for this
> >>>> non-standard convience notation to be added to other assemblers [1], but
> >>>> until then, we can remove it and get equivalent disassembly:
> >>>>
> >>>
> >>> What do you mean by 'non-standard convenience notation'? Which asm
> >>> 'standard' does Clang actually claim to implement?
> >>
> >> Well, for assembly 'standard' is a bit nebulous.  But it's frustrating
> >> when you can't find what the `=0x...` notation means in either the ARM
> >> or GNU as manuals.  The source of truth happened to be a comment in
> >> the source [0] that explained that this was a "programmer friendly
> >> notation."  Sure, if you can find it.
> >>
> >
> > Well, it is documented in the ARM manuals as the 'ldr pseudo
> > instruction' for 32-bit ARM, and originally, it would only emit a
> > literal if the value could not be loaded using a ordinary mov.
>
> FWIW It's certainly well-documented by common A64 assemblers too:
>
> http://infocenter.arm.com/help/topic/com.arm.doc.100069_0610_01_en/dom1395139540926.html
>
> https://sourceware.org/binutils/docs/as/AArch64-Opcodes.html#AArch64-Opcodes

Thanks for those links, I've added them to the LLVM bug to show that
this is documented behavior.
-- 
Thanks,
~Nick Desaulniers
