Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935737AbeCHKqS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 05:46:18 -0500
Received: from mail-ot0-f195.google.com ([74.125.82.195]:47044 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934574AbeCHKqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 05:46:17 -0500
X-Google-Smtp-Source: AG47ELtlrXzy8+urtVgrCqssLTGTjFdFEH46fk73aR8VQgr61D3mVDMT1xiLq45V1e55GTFXed53oHV8QDZH3LtdaAQ=
MIME-Version: 1.0
In-Reply-To: <CACPK8XeVMSeQNkPNp1_vms97H_9rMuk1-DzUAc=s-7o=FmVncw@mail.gmail.com>
References: <20180307162430.2664523-1-arnd@arndb.de> <20180307162430.2664523-2-arnd@arndb.de>
 <CACPK8XeVMSeQNkPNp1_vms97H_9rMuk1-DzUAc=s-7o=FmVncw@mail.gmail.com>
From: Avi Fishman <avifishman70@gmail.com>
Date: Thu, 8 Mar 2018 12:46:16 +0200
Message-ID: <CAKKbWA5F29HJFOTNfVmt14Qg5rMgrLSsHjY4NQESZL6OKmA95w@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: npcm: drop extraneous 'select' statements
To: Joel Stanley <joel@jms.id.au>
Cc: Arnd Bergmann <arnd@arndb.de>, Tomer Maimon <tmaimon77@gmail.com>,
        Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So at least replace CACHE_L2X0 with MIGHT_HAVE_CACHE_L2X0 then
CACHE_L2X0 will be selected by default and user can still remove it.

On Thu, Mar 8, 2018 at 4:12 AM, Joel Stanley <joel@jms.id.au> wrote:
> On Thu, Mar 8, 2018 at 2:54 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> While looking at the build regression, I noticed that the
>> platform selects a lot of other Kconfig symbols that it really
>> should not:
>>
>> CPU_V7, ARM_GIC, HAVE_SMP, COMMON_CLK, GENERIC_CLOCKEVENTS,
>> and CLKDEV_LOOKUP are all implied by ARCH_MULTI_V7, so they
>> can be dropped.
>>
>> CACHE_L2X0, SMP and USB are meant to be user-selectable, we
>> want to be able to turn those off for testing purposes.
>>
>> CPU_USE_DOMAINS looks completely misplaced here, we should not
>> select that for an ARMv7 platform.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> I had a similar patch queued for sending out. Thanks Arnd.
>
> Acked-by: Joel Stanley <joel@jms.id.au>
>
> Cheers,
>
> Joel
>
>> ---
>>  arch/arm/mach-npcm/Kconfig | 18 ------------------
>>  1 file changed, 18 deletions(-)
>>
>> diff --git a/arch/arm/mach-npcm/Kconfig b/arch/arm/mach-npcm/Kconfig
>> index 2bc6697c8d97..c6a16230e8ef 100644
>> --- a/arch/arm/mach-npcm/Kconfig
>> +++ b/arch/arm/mach-npcm/Kconfig
>> @@ -12,12 +12,6 @@ comment "NPCM7XX CPU type"
>>  config ARCH_NPCM750
>>         depends on ARCH_NPCM
>>         bool "Support for NPCM750 BMC CPU (Poleg)"
>> -       select CACHE_L2X0
>> -       select CPU_V7
>> -       select ARM_GIC
>> -       select HAVE_SMP
>> -       select SMP
>> -       select SMP_ON_UP
>>         select HAVE_ARM_SCU
>>         select HAVE_ARM_TWD if SMP
>>         select ARM_ERRATA_720789
>> @@ -26,18 +20,6 @@ config ARCH_NPCM750
>>         select ARM_ERRATA_794072
>>         select PL310_ERRATA_588369
>>         select PL310_ERRATA_727915
>> -       select USB_EHCI_ROOT_HUB_TT
>> -       select USB_ARCH_HAS_HCD
>> -       select USB_ARCH_HAS_EHCI
>> -       select USB_EHCI_HCD
>> -       select USB_ARCH_HAS_OHCI
>> -       select USB_OHCI_HCD
>> -       select USB
>> -       select FIQ
>> -       select CPU_USE_DOMAINS
>> -       select GENERIC_CLOCKEVENTS
>> -       select CLKDEV_LOOKUP
>> -       select COMMON_CLK if OF
>>         select NPCM750_TIMER
>>         select MFD_SYSCON
>>         help
>> --
>> 2.9.0
>>
