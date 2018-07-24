Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265E5C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD04020874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ce3ed9WH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD04020874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388378AbeGXLAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 07:00:06 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33610 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388251AbeGXLAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 07:00:06 -0400
Received: by mail-oi0-f67.google.com with SMTP id l10-v6so6441904oii.0;
        Tue, 24 Jul 2018 02:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=/OVhb/EUU26bc0TtFH5zFFpLu3sFRzLLH9IiLBUDCFY=;
        b=ce3ed9WH2QPQ8jH5tlphLkBeMn+95MlvRV1+rG6gYMOLDvPTrhITi6s+lbsHMay8am
         NRWcmf3JkN8hxFgqRDnNgggSgK+JnpnUfwxL9opfHkUmBc3ghZ0ojOY74867g9RTFZ65
         aFPJLwDJMJ31J549nGzVTOF7ZbSd+16w2ekTZfXhfSWg+t+cWG0JYgU7U7V4VAKH16Lc
         qPrZTEoamG4pMkHmRjQCTgmJ0KsZKsUJlAczEuz3dkht0dNFWbSqgVbcPJ39a3pJsi81
         5ASLf7EZSx0o+5LgVjsYT9iBoeC0FeXDbabiCWEJPXfp2KEFto+AR7wmH0wnviQZCqAE
         Zxsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=/OVhb/EUU26bc0TtFH5zFFpLu3sFRzLLH9IiLBUDCFY=;
        b=ch+7uQVeh4v2b+6SvIfvMLqyqjkgBel9PUwwRYw0FojjexWBOeIJdZGZv6y0wJhQjf
         2BMZ3Vw+rNihDV5bcFHte72zmwqMOWxiMLREeGRg7FZPh1rGQMAPsuA6GU1Iqghasmap
         DxyFbORCCdoFaMszFWOOhw5L4KyNMWJUtg1jjxhFtGeSwHCr8PhUH9Tx8T5uf2F1o42j
         4mLirJVuoitzVJKwRsZPloT72LmF9qkHoaBJtZoX7woakyj0UE2KjiERxyQM11ibR0LU
         V/cpUdcEzvJ7Ci0CNYNZY2FCGuvn3lVEWph8EK56EpS9nGDjSjfC6kEkua0UR/rR9Jhn
         eaYQ==
X-Gm-Message-State: AOUpUlEDr/dFL/Ah6MA/6dxmNYpZeBZj8U7JhI++cpIZu3g6OFK0445H
        K5+TavGYk5CQ5MbP2ATDu9aR+Arh6pvDTYPBz3c=
X-Google-Smtp-Source: AAOMgpeoXkpXPw3OzKQYrfXRe8EXQO/Jw0KKqqVyrMGICri2CnIP/AGfYkcN4KEw0CxABV8pYvAjntG8CkRH6y9uykc=
X-Received: by 2002:aca:b841:: with SMTP id i62-v6mr2331708oif.358.1532426065590;
 Tue, 24 Jul 2018 02:54:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 02:54:25
 -0700 (PDT)
In-Reply-To: <20180724094957.1967541-1-arnd@arndb.de>
References: <20180724094957.1967541-1-arnd@arndb.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 24 Jul 2018 11:54:25 +0200
X-Google-Sender-Auth: _ESE_Vmdxw87WhO-OfpFTIcmxfM
Message-ID: <CAJZ5v0jMtWDZePW=mu_cO2PjHVGp1hQThSveq9+=2aNozESENQ@mail.gmail.com>
Subject: Re: [PATCH] [SUBMITTED 20180724] arm64: fix ACPI dependencies
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Will Deacon <will.deacon@arm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 11:48 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> Kconfig reports a warning on x86 builds after the ARM64 dependency
> was added.
>
> drivers/acpi/Kconfig:6:error: recursive dependency detected!
> drivers/acpi/Kconfig:6:       symbol ACPI depends on EFI
>
> This rephrases the dependency to keep the ARM64 details out of the
> shared Kconfig file, so Kconfig no longer gets confused by it.
>
> For consistency, all three architectures that support ACPI now
> select ARCH_SUPPORTS_ACPI in exactly the configuration in which
> they allow it. We still need the 'default x86', as each one
> wants a different default: default-y on x86, default-n on arm64,
> and always-y on ia64.
>
> Fixes: 5bcd44083a08 ("drivers: acpi: add dependency of EFI for arm64")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: use 'select ARCH_SUPPORTS_ACPI' for all three.

LGTM

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  arch/arm64/Kconfig   | 1 +
>  arch/ia64/Kconfig    | 1 +
>  arch/x86/Kconfig     | 1 +
>  drivers/acpi/Kconfig | 8 +++++---
>  4 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index cdcaa6a798b2..2f987a938405 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1267,6 +1267,7 @@ config EFI
>         bool "UEFI runtime support"
>         depends on OF && !CPU_BIG_ENDIAN
>         depends on KERNEL_MODE_NEON
> +       select ARCH_SUPPORTS_ACPI
>         select LIBFDT
>         select UCS2_STRING
>         select EFI_PARAMS_FROM_FDT
> diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
> index ff861420b8f5..02eb68d5d1c0 100644
> --- a/arch/ia64/Kconfig
> +++ b/arch/ia64/Kconfig
> @@ -16,6 +16,7 @@ config IA64
>         select ARCH_MIGHT_HAVE_PC_SERIO
>         select PCI if (!IA64_HP_SIM)
>         select ACPI if (!IA64_HP_SIM)
> +       select ARCH_SUPPORTS_ACPI if (!IA64_HP_SIM)
>         select ACPI_SYSTEM_POWER_STATES_SUPPORT if ACPI
>         select ARCH_MIGHT_HAVE_ACPI_PDC if ACPI
>         select HAVE_UNSTABLE_SCHED_CLOCK
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 088b719bc5d1..442575220708 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -76,6 +76,7 @@ config X86
>         select ARCH_MIGHT_HAVE_ACPI_PDC         if ACPI
>         select ARCH_MIGHT_HAVE_PC_PARPORT
>         select ARCH_MIGHT_HAVE_PC_SERIO
> +       select ARCH_SUPPORTS_ACPI
>         select ARCH_SUPPORTS_ATOMIC_RMW
>         select ARCH_SUPPORTS_NUMA_BALANCING     if X86_64
>         select ARCH_USE_BUILTIN_BSWAP
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index a8da730fabc6..1edca05ee0ae 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -5,11 +5,10 @@
>
>  menuconfig ACPI
>         bool "ACPI (Advanced Configuration and Power Interface) Support"
> -       depends on !IA64_HP_SIM
> -       depends on IA64 || X86 || (ARM64 && EFI)
> +       depends on ARCH_SUPPORTS_ACPI
>         depends on PCI
>         select PNP
> -       default y if (IA64 || X86)
> +       default y if X86
>         help
>           Advanced Configuration and Power Interface (ACPI) support for
>           Linux requires an ACPI-compliant platform (hardware/firmware),
> @@ -41,6 +40,9 @@ menuconfig ACPI
>           <http://www.acpi.info>
>           <http://www.uefi.org/acpi/specs>
>
> +config ARCH_SUPPORTS_ACPI
> +       bool
> +
>  if ACPI
>
>  config ACPI_LEGACY_TABLES_LOOKUP
> --
> 2.18.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
