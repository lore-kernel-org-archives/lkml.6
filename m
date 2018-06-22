Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A14C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 11:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8322B2415A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 11:41:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8322B2415A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933095AbeFVLl4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 07:41:56 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:34281 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751191AbeFVLly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 07:41:54 -0400
Received: by mail-vk0-f67.google.com with SMTP id q135-v6so3745930vkh.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 04:41:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gwk/bJwN5KcFTvb4KILTH7fFo83lidYj2LE2lgoUwjQ=;
        b=p/KymncnqJQtaxrdVg3OFP7V8TLUn8hStxi/zBrdTo/C3J/ZfJ/aUGMKK45nGShlTq
         T5eMjJ/9EKGrIEvacHOqI1MAEtad0Ttg1a8kxbFgc5ipvQUva0/Edcp9OffhROb27cJW
         tU/WV2yuosX+DnxzhitcYj+rkF6Cl4T+7lr8gqGFffVbvUwULZyUY2dGb9AoqfZ40qke
         D22xJ1Ky2jkGU8rY4oloiA76/K3OaDa69dHorwqKDB3seSgyMt8CUqfR24WCBDoYVIBF
         v/XrY+TvcvHh2tLxmLSPqoISYmyawaV4lPo8cx1Uv0MRyQvU1YpdX18UWCC8kqxRJi8h
         0S6w==
X-Gm-Message-State: APt69E1ekPpFhiU8HZCeN2Okk8PxDV0X0kpMjyscmZCbPbFcIKuGU19d
        HL9FmEcm3J59RvREejYtnCLlNLEwp6EYD1KgELE=
X-Google-Smtp-Source: ADUXVKJIGjjbJtADxpuI2MU+T4mEXZ/PnO6pinX0BP+uOQ8E6VwzB6ISyXXfB1vh48jjpPAF4Z4CuMvFkq3jEDVFeA4=
X-Received: by 2002:a1f:e92:: with SMTP id 140-v6mr731745vko.90.1529667713558;
 Fri, 22 Jun 2018 04:41:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180621155906.12821-1-geert+renesas@glider.be> <20180622092305.GS17671@n2100.armlinux.org.uk>
In-Reply-To: <20180622092305.GS17671@n2100.armlinux.org.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 22 Jun 2018 13:41:37 +0200
Message-ID: <CAMuHMdUqBhR4Ra=hF0TZKxgQHaE_KBUYh04ZTTmg1pRWtjveoQ@mail.gmail.com>
Subject: Re: [PATCH] [RFC] arm: Replace "multiple platforms" by "common platform"
To:     Russell King <linux@armlinux.org.uk>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Chris Brandt <Chris.Brandt@renesas.com>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

Thanks for your comments!

On Fri, Jun 22, 2018 at 11:23 AM Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Thu, Jun 21, 2018 at 05:59:06PM +0200, Geert Uytterhoeven wrote:
> > "ARM multiplatform" has actually two meanings:
> >   1. It groups platforms that follow the "ARM multiplatform" software
> >      framework,
> >   2. It allows to build a single kernel that can be booted on multiple
> >      platforms.
> >
> > Currently support for XIP and/or NOMMU cannot be enabled on platforms
> > that follow the "ARM multiplatform" framework, without duplicating their
> > machine selection logic under a new Kconfig symbol.  As (in theory) all
> > platforms can be used with XIP and/or NOMMU, this is not sustainable.
>
> The reason for that has nothing to do with the way this option is named,
> and even after reading your commit message, I can't come up with any
> reason for this change other than "personally don't like the existing
> wording" which IMHO is not a good enough reason to randomly go around
> rewording stuff in the kernel.
>
> The reason that XIP and NOMMU can't be enabled with a multi-platform
> kernel is that there are often issues with different layouts of the
> physical memory space which can not be taken into account.
>
> Multi-platform works around that by (a) using the MMU to abstract
> away the differences on RAM, and (b) modifying the kernel text to
> adjust the virtual to physical translations.  The latter is not
> possible with XIP, and the former should not be used with NOMMU.
> That means the kernel must be built to accomodate the physical
> layout on the target platform, and so building a kernel supporting
> multiple platforms with differing memory layouts makes no sense.
>
> This is exactly why I really don't like the idea of ARCH_MULTIPLATFORM
> being hijacked for NOMMU/XIP support.

That's multiplatform meaning #2.

But as long as MMU=y and XIP_KERNEL=n, nothing would change.

> We've worked around the issues with "multi-platform" XIP/NOMMU by
> using things such as "ARM_SINGLE_V7M" to cover all V7M platforms
> (which must, by definition) have compatible physical layouts.
> Exactly the same approach should be adopted for other XIP/NOMMU
> platforms, and _not_ reusing ARCH_MULTIPLATFORM, which will lead
> to lots of non-bootable kernels.

So we need ARM_SINGLE_ARMV7A, and let all subarchitectures depend on
ARCH_MULTIPLATFORM || ARM_SINGLE_ARMV7M, to avoid duplicating
their SoC entry?

I had a quick look. So we have e.g. MACH_STM32F746 under ARM_SINGLE_ARMV7M,
and MACH_STM32MP157 under ARCH_MULTI_V7.
But according to stm32mp157c-ed1.dts and stm32746g-eval.dts both have
memory at the same address, so it should be possible to run the same nommu
kernel on the STM32MP157?

MACH_STM32F469 is also under ARM_SINGLE_ARMV7M, but according to
stm32f469-disco.dts, memory may be at a completely different address?
Doesn't that lead to unbootable kernels, too?

> Another problems for NOMMU is that the kernel has to be linked for
> a specific _physical_ address.  When you have ARCH_MULTIPLATFORM
> enabled, there is no facility to select that address.

That can be easily solved with Kconfig symbols that depend on !MMU,
can't it?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
