Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14234C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA0A6218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FnbPkDPL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388246AbeLTRyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:54:05 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:33964 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388191AbeLTRyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:54:05 -0500
Received: by mail-io1-f66.google.com with SMTP id l22so638666ioh.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 09:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+w81jMbb1o2ygo2dFZKor/RnHjUNYim0qXEYOaVTDLc=;
        b=FnbPkDPLEuqKdeWe1yEFJJZBekH1QO+pKfgDgKGFEwq8gAd4uvTADH9/BuvWR9V1f+
         6kAR2citfpmJctvSKlLZwenOiV9M9Oc7tg7QvUtAWiN48ciAl0JQfXwb/vp/zU+C7IMf
         x4IV6Ym0i0JaTtiu8z4PulYcpLT/n0qulLFLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+w81jMbb1o2ygo2dFZKor/RnHjUNYim0qXEYOaVTDLc=;
        b=HcpWul676e9A74Hz0OrMnsDE49BhYYMzx4x1M4WNsDEcsHoBqRI+kXnmnhN2EIWPFM
         EhhPepcHYXGOs+dOxeSBtOo+tpcPKHPrXP7xUT7lVA3zoOAx5bCtJe0tjE3ZnWGKZEQO
         PyDX2OGdAJhNoNbYoGAgre7X9RJwG/xIpb8O/ZbmFQQoCsV55osksr+TeqVpNu1DAZ43
         s4duwj65yG7uf7C+SGHj8W+AEq3/DRWPPBFSmKJSTqWw1/YXcWBIPhXI5kNDhcs1Ugz7
         l4TsO0/d9c5zWp6DlX9aSHfEkBAGb+Qm8Nra6f7nOwp4JDpzV/8maL/f2kfW6CstfGG9
         gpOw==
X-Gm-Message-State: AA+aEWYZbZLqtqZU/C4AkyKp5tmQTa9QMMLjfw6uGSR4en3nMth2HlLT
        cig6UDGMxpZ1lXNR7dZz1uOUDchiKGWUDCdbfcfehA==
X-Google-Smtp-Source: AFSGD/Vp+zhHyHp1nKMdtFw4tma8WbKDd6zssG67ODBx/MRA4s6TcuYWmfeK3vKs6cMQBA1XTO1HTT1ZnDOBJTq64So=
X-Received: by 2002:a5e:cb0b:: with SMTP id p11mr22959730iom.60.1545328444007;
 Thu, 20 Dec 2018 09:54:04 -0800 (PST)
MIME-Version: 1.0
References: <1544633245-6036-1-git-send-email-julien.thierry@arm.com>
 <1544633245-6036-12-git-send-email-julien.thierry@arm.com>
 <CAKv+Gu8E9g=J78a-2HAdcijaHyVFL1KA3civwfoVHQ=mp7yJJA@mail.gmail.com>
 <19500d6b-62a3-21cb-9ac0-a4e5d4714a63@arm.com> <CAKv+Gu8+1JNzM4AUujiEfkYujpgakLXcUwTDG4eHwvQ7pKAzFA@mail.gmail.com>
 <31e41461-763f-aa7d-91ea-b493ede81eed@arm.com> <CAKv+Gu9PaeGbfB-9r0Gv1oYn+jORJDk9ozajEwKbse3KjkSmbQ@mail.gmail.com>
 <bc27fb6d-1adf-d7e9-ded2-2cbed81b6e03@arm.com> <e0ecdb24-ef52-2c31-565d-66f7a2770f4a@arm.com>
 <7d42f570-541a-59a3-79fc-f00dc0b51689@arm.com> <CAKv+Gu8CNmL8v=ePXSvQ0vEAzD2O2YAKutQW-b+E6JmyYBPTnA@mail.gmail.com>
 <9c64a977-fdee-b2b2-d726-1e9744d229a7@arm.com> <0e6edb8d-dd41-fd3d-0598-7f02ce4ee9ef@arm.com>
In-Reply-To: <0e6edb8d-dd41-fd3d-0598-7f02ce4ee9ef@arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 20 Dec 2018 18:53:51 +0100
Message-ID: <CAKv+Gu-joM6GivoTqF1t8UKUwtfXkVZ5gTKL6JzMh3uCUJeWog@mail.gmail.com>
Subject: Re: [PATCH v7 11/25] arm64: irqflags: Use ICC_PMR_EL1 for interrupt masking
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        joel@joelfernandes.org, Marc Zyngier <marc.zyngier@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, oleg@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Dec 2018 at 18:01, Julien Thierry <julien.thierry@arm.com> wrote:
>
> Hi Ard,
>
> On 14/12/2018 16:40, Julien Thierry wrote:
> >
> >
> > On 14/12/2018 15:49, Ard Biesheuvel wrote:
> >> On Fri, 14 Dec 2018 at 16:23, Julien Thierry <julien.thierry@arm.com> wrote:
> >>>
> >>> Hi,
> >>>
> >>> On 13/12/2018 15:03, Julien Thierry wrote:
> >>>>
> >>>> Argh, not as simple as I had expected.
> >>>>
> >>>> Turns out include/linux/efi.h does not include asm/efi.h (including it
> >>>> at the beginning of the file breaks the build because asm/efi.h misses
> >>>> the efi type definitions.
> >>>>
> >>>> So a thing like:
> >>>>
> >>>> #ifndef efi_get_irqflags
> >>>> #define efi_get_irqflags(flags) local_save_flags(flags)
> >>>> #endif
> >>>>
> >>>> in include/linux/efi.h cannot be overridden.
> >>>>
> >>>> Either I would need to introduce the definitions arm, arm64 and x86 (I
> >>>> don't think there are other arch supporting EFI right now) or I'll need
> >>>> to come up with another solution.
> >>>>
> >>>
> >>
> >> It might be a bit nasty, but can we put the #ifndef above in
> >> runtime-wrappers.c directly? The only reference in linux/efi.h is a
> >> macro, so that shouldn't matter afaict.
> >>
> >
> > Sadly, in arch/x86/platform/uv/bios_uv.c, uv_bios_call() has a reference
> > to the macro efi_call_virt_pointer() which wouldn't be able to see the
> > definition in runtime-wrappers.c
> >
> > Otherwise, we could've moved efi_call_virt_pointer() and
> > __efi_call_virt_pointer in runtime-wrappers.c and things would not have
> > been as nasty.
> >
> > But no, I don't think we can do that without breaking some x86 build :( .
> >
>
> Since the above does not work, would the solution with the
> HAVE_GENERIC_EFI_FLAGS below be acceptable to you? Or would you rather I
> defined helpers in <asm/efi.h> for all arm/arm64/x86?
>
> Or neither and I shall find another way?
>

Would it be possible to introduce a function

efi_call_virt_save_flags()

[as a counterpart to efi_call_virt_check_flags()], and put the
implementation in runtime-wrappers.c (which already includes
asm/efi.h)?

That should allow you to put arch-specific hooks in asm/efi.h, and use
them in the implementation of efi_call_virt_save_flags(). AFAICT, that
removes the need for Kconfig glue.
