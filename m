Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934714AbeCHCMg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 21:12:36 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:46052 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933351AbeCHCMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 21:12:34 -0500
X-Google-Smtp-Source: AG47ELu0u9UUiMaOxrsj+hCI5q3aHc7RibOW1/of2af30hob2CmWxvRD4++LvvBTdAIa4MQ8ffPEiVAu35lRYi4bAEs=
MIME-Version: 1.0
In-Reply-To: <20180307162430.2664523-2-arnd@arndb.de>
References: <20180307162430.2664523-1-arnd@arndb.de> <20180307162430.2664523-2-arnd@arndb.de>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 8 Mar 2018 12:42:12 +1030
X-Google-Sender-Auth: GPAycjjUe33p8pSM9ccGvV6TL-A
Message-ID: <CACPK8XeVMSeQNkPNp1_vms97H_9rMuk1-DzUAc=s-7o=FmVncw@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: npcm: drop extraneous 'select' statements
To: Arnd Bergmann <arnd@arndb.de>
Cc: Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 8, 2018 at 2:54 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> While looking at the build regression, I noticed that the
> platform selects a lot of other Kconfig symbols that it really
> should not:
>
> CPU_V7, ARM_GIC, HAVE_SMP, COMMON_CLK, GENERIC_CLOCKEVENTS,
> and CLKDEV_LOOKUP are all implied by ARCH_MULTI_V7, so they
> can be dropped.
>
> CACHE_L2X0, SMP and USB are meant to be user-selectable, we
> want to be able to turn those off for testing purposes.
>
> CPU_USE_DOMAINS looks completely misplaced here, we should not
> select that for an ARMv7 platform.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I had a similar patch queued for sending out. Thanks Arnd.

Acked-by: Joel Stanley <joel@jms.id.au>

Cheers,

Joel

> ---
>  arch/arm/mach-npcm/Kconfig | 18 ------------------
>  1 file changed, 18 deletions(-)
>
> diff --git a/arch/arm/mach-npcm/Kconfig b/arch/arm/mach-npcm/Kconfig
> index 2bc6697c8d97..c6a16230e8ef 100644
> --- a/arch/arm/mach-npcm/Kconfig
> +++ b/arch/arm/mach-npcm/Kconfig
> @@ -12,12 +12,6 @@ comment "NPCM7XX CPU type"
>  config ARCH_NPCM750
>         depends on ARCH_NPCM
>         bool "Support for NPCM750 BMC CPU (Poleg)"
> -       select CACHE_L2X0
> -       select CPU_V7
> -       select ARM_GIC
> -       select HAVE_SMP
> -       select SMP
> -       select SMP_ON_UP
>         select HAVE_ARM_SCU
>         select HAVE_ARM_TWD if SMP
>         select ARM_ERRATA_720789
> @@ -26,18 +20,6 @@ config ARCH_NPCM750
>         select ARM_ERRATA_794072
>         select PL310_ERRATA_588369
>         select PL310_ERRATA_727915
> -       select USB_EHCI_ROOT_HUB_TT
> -       select USB_ARCH_HAS_HCD
> -       select USB_ARCH_HAS_EHCI
> -       select USB_EHCI_HCD
> -       select USB_ARCH_HAS_OHCI
> -       select USB_OHCI_HCD
> -       select USB
> -       select FIQ
> -       select CPU_USE_DOMAINS
> -       select GENERIC_CLOCKEVENTS
> -       select CLKDEV_LOOKUP
> -       select COMMON_CLK if OF
>         select NPCM750_TIMER
>         select MFD_SYSCON
>         help
> --
> 2.9.0
>
