Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E345C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8FDA20875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7ofdyzy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8FDA20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388431AbeGXKmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 06:42:47 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:44314 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388236AbeGXKmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 06:42:46 -0400
Received: by mail-oi0-f65.google.com with SMTP id s198-v6so6320866oih.11;
        Tue, 24 Jul 2018 02:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=p46t4t0z8iy2rtkFPpGCDPEAa4zWhMnFpRUNmINEtBk=;
        b=c7ofdyzyzDAuFsU3wFq4SXCFUzOTrfvvhjneYixSH2osj2ObgKoCraGCTMBXZpxDGA
         fyG4/AFocdfByTe3lnvUHPlg5hh9JpHY7TyXURSATvE9DAy0jnJCeE+IPrpkcT902Keb
         g81s7HyNwOnc9G+bhu52RtLc+3weJP7DpfAFodvFvRe5F7XxvJAEHOLeT13X95JvtDov
         XqQnp7V1db7vP2m6+TgRxZgPSn4JxWqV3PjUPrhrfg8H+t93yWStMu/x0Q8aI/dILQE6
         v3JDh/PML3jacbOqZZtOFB5zdTNdIkJ5xcHEZC+WFlbwCePXTI4bjAUPEHuwpnYkTcl0
         zzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=p46t4t0z8iy2rtkFPpGCDPEAa4zWhMnFpRUNmINEtBk=;
        b=KLJQI8ixUrfwJyIT4sAq2aHaSOhXS1IUJayLm2hZeKUbMQfw8dbKC38zP4efhJbKXv
         pgkuuggCalq6FAe/yXJR+YgJxPRQDSknmJtcmZq+gSSXqoFHXqUXnQnjxHQjoIZ0iy8j
         5SHH7l+0llorj6BmkaHt928mxAEMDEarA9MVPvg97AGdI/3qSGO162ZK1MLefRb5UXSn
         kJqg7b5kbd1hd1R1Pa+3yBOc0/DaQpG8NAgK2H1enWTxnacUugq2SPbHhm0nkQHsArPw
         Lm1CI+d2lrFVyZ1pMSTou9OUJnZTe5CuS1LLQcp/q4WpesR9hLwiSlVLISP18R/V35XI
         LAPQ==
X-Gm-Message-State: AOUpUlE6GghkMFoz8940BObmLDAE71ZRzXjDSihEtQ1KoW5Urc6C98uV
        Ccu9kAytIodeyoMD8ZmO9qxLMxqH09NaPq7lpRg=
X-Google-Smtp-Source: AAOMgpdZTYnEFaWHzISnRhRd+QnWm1cUoEFlWEarLJQ8x98vZvENO9+jUI0dpB4GKcMuaccok9OiYu1PqanhofcO0Zg=
X-Received: by 2002:aca:42:: with SMTP id 63-v6mr2188548oia.154.1532425030797;
 Tue, 24 Jul 2018 02:37:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 02:37:10
 -0700 (PDT)
In-Reply-To: <20180724093345.1575921-1-arnd@arndb.de>
References: <20180724093345.1575921-1-arnd@arndb.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 24 Jul 2018 11:37:10 +0200
X-Google-Sender-Auth: Mm1VISpOMGDfIbHcYjEj2FSUtlA
Message-ID: <CAJZ5v0jTowUW6myVf0B2Gyq0ZA2ATqPNnaeOgFS01ce8A=FBpA@mail.gmail.com>
Subject: Re: [PATCH] arm64: fix ACPI dependencies
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 11:33 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> Kconfig reports a warning on x86 builds after the ARM64 dependency
> was added.
>
> drivers/acpi/Kconfig:6:error: recursive dependency detected!
> drivers/acpi/Kconfig:6:       symbol ACPI depends on EFI
>
> This rephrases the dependency to keep the ARM64 details out of the
> shared Kconfig file, so Kconfig no longer gets confused by it.
>
> Fixes: 5bcd44083a08 ("drivers: acpi: add dependency of EFI for arm64")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm64/Kconfig   | 1 +
>  drivers/acpi/Kconfig | 5 ++++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
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
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index a8da730fabc6..0cda51c5d433 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -6,7 +6,7 @@
>  menuconfig ACPI
>         bool "ACPI (Advanced Configuration and Power Interface) Support"
>         depends on !IA64_HP_SIM
> -       depends on IA64 || X86 || (ARM64 && EFI)
> +       depends on IA64 || X86 || ARCH_SUPPORTS_ACPI

That doesn't look particularly consistent to me.

It should be either "depends on ARCH_SUPPORTS_ACPI" alone or mention
ARM64 somehow IMO

>         depends on PCI
>         select PNP
>         default y if (IA64 || X86)
> @@ -41,6 +41,9 @@ menuconfig ACPI
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
