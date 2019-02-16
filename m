Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E355AC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 12:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B02572192C
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 12:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VH8l8I+x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbfBPMMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 07:12:20 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45774 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbfBPMMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 07:12:19 -0500
Received: by mail-pl1-f193.google.com with SMTP id r14so6304885pls.12
        for <linux-kernel@vger.kernel.org>; Sat, 16 Feb 2019 04:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8yxPfQbdgFsgQmUsjJRgpLpFTR6AgQm0I9PqST8tOsw=;
        b=VH8l8I+xU8tCcJ+mKhk1YHP3fPPE2wqNszp+taY77gWARCZRlT5ulpl70Ow/mH1sGj
         M5TDkpzH4P92gEZtefkyAONTm0Z4UN2Iatdy+dV+7e/ErlhWk/+XTQOPK0xrjbrXLNer
         lxIEBOR70UDxjtaEwsRtnGGP9NT81K1AL454w9ZNkHE0IVwsHaG7Zvrbm7jbjQVwHj2A
         gn2PQIKWVQMdn/ourqWRETpSnqXRBfSQ/2aJNY+89Sg8cHo1jq6JxBG3HXHhp+UoMAU4
         Lkm8NYOmevGiCixGEnt2d2Q+T88m/5SQJnsDb9NOFlXwuqy5h04bEdi9WrdwUo1ng8lT
         dOFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8yxPfQbdgFsgQmUsjJRgpLpFTR6AgQm0I9PqST8tOsw=;
        b=OpPvSqRflhHrbb4I8KKVJXyPmOENb8hpK8y9Y0lpXsSSWDXz20qTHTWQ5BULegSk5V
         RJ7fu9/mB947VRGO2mL60Zriyuoz2GIn7BS+Wa5z3Zf+4uL39Y1xC+D2dt7pSrtq94QX
         VRNNXPSLVyaduwEfNTxJaeVDgp8j+C9PpZKK4fukcgrD+fG1ZyHKYS7suiVZQqxxgcT4
         wvAHI/YwhNAkWmhYnryGyF9G7zX+mlbZGBCpAtf7T5jzCRy+lyfXDCyTpWRGKvl2J3tE
         NKsUTjeJHoP2Z/MfS7pTIBsRi+2tn8zwIcIIfWHXIxaj3nPfbZXEj8CLhzwFqlVroCb4
         t68A==
X-Gm-Message-State: AHQUAuboKjFRaRAGBDjfUNfFko2NxnXhVMWEz3SVT+6ToUf8uQHh524T
        7UfuFy6PzWdXOn2MI6+M/hOhfdU6bltvBaX+3u1vgyl+
X-Google-Smtp-Source: AHgI3IbtmVyx0OPo8QuOT9CIWEzHB+nvSRY+dcHBjtMvSG7dtQ+QbO+braFgLlKpL3HtUmWXZNJpQFy+JxTlrj9EBGU=
X-Received: by 2002:a17:902:7682:: with SMTP id m2mr2206890pll.311.1550319139289;
 Sat, 16 Feb 2019 04:12:19 -0800 (PST)
MIME-Version: 1.0
References: <1550335843-108902-1-git-send-email-peng.hao2@zte.com.cn> <1550335843-108902-2-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1550335843-108902-2-git-send-email-peng.hao2@zte.com.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 16 Feb 2019 14:12:08 +0200
Message-ID: <CAHp75VexcXF4n9dN=ecivr=ygGwVuRYveQ-ZF1eYDGG2VU0Fmw@mail.gmail.com>
Subject: Re: [PATCH V5 1/4] misc/pvpanic : preparing for pvpanic driver framework
To:     Peng Hao <peng.hao2@zte.com.cn>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 16, 2019 at 10:29 AM Peng Hao <peng.hao2@zte.com.cn> wrote:
>
> Preparing for pvpanic driver framework. Create a pvpanic driver
> directory and move current driver file to new directory.
>

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  drivers/misc/Kconfig                 | 9 +--------
>  drivers/misc/Makefile                | 2 +-
>  drivers/misc/pvpanic/Kconfig         | 7 +++++++
>  drivers/misc/pvpanic/Makefile        | 5 +++++
>  drivers/misc/{ => pvpanic}/pvpanic.c | 0
>  5 files changed, 14 insertions(+), 9 deletions(-)
>  create mode 100644 drivers/misc/pvpanic/Kconfig
>  create mode 100644 drivers/misc/pvpanic/Makefile
>  rename drivers/misc/{ => pvpanic}/pvpanic.c (100%)
>
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index f417b06..aa3a805 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -513,14 +513,7 @@ config MISC_RTSX
>         tristate
>         default MISC_RTSX_PCI || MISC_RTSX_USB
>
> -config PVPANIC
> -       tristate "pvpanic device support"
> -       depends on HAS_IOMEM && (ACPI || OF)
> -       help
> -         This driver provides support for the pvpanic device.  pvpanic is
> -         a paravirtualized device provided by QEMU; it lets a virtual machine
> -         (guest) communicate panic events to the host.
> -
> +source "drivers/misc/pvpanic/Kconfig"
>  source "drivers/misc/c2port/Kconfig"
>  source "drivers/misc/eeprom/Kconfig"
>  source "drivers/misc/cb710/Kconfig"
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index e39ccbb..cfe20b3 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -58,4 +58,4 @@ obj-$(CONFIG_ASPEED_LPC_SNOOP)        += aspeed-lpc-snoop.o
>  obj-$(CONFIG_PCI_ENDPOINT_TEST)        += pci_endpoint_test.o
>  obj-$(CONFIG_OCXL)             += ocxl/
>  obj-y                          += cardreader/
> -obj-$(CONFIG_PVPANIC)          += pvpanic.o
> +obj-$(CONFIG_PVPANIC)          += pvpanic/
> diff --git a/drivers/misc/pvpanic/Kconfig b/drivers/misc/pvpanic/Kconfig
> new file mode 100644
> index 0000000..3e612c6
> --- /dev/null
> +++ b/drivers/misc/pvpanic/Kconfig
> @@ -0,0 +1,7 @@
> +config PVPANIC
> +       tristate "pvpanic device support"
> +       depends on HAS_IOMEM && (ACPI || OF)
> +       help
> +         This driver provides support for the pvpanic device.  pvpanic is
> +         a paravirtualized device provided by QEMU; it lets a virtual machine
> +         (guest) communicate panic events to the host.
> diff --git a/drivers/misc/pvpanic/Makefile b/drivers/misc/pvpanic/Makefile
> new file mode 100644
> index 0000000..6394224
> --- /dev/null
> +++ b/drivers/misc/pvpanic/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright (c) 2018 ZTE Ltd.
> +
> +obj-$(CONFIG_PVPANIC)            += pvpanic.o
> diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic/pvpanic.c
> similarity index 100%
> rename from drivers/misc/pvpanic.c
> rename to drivers/misc/pvpanic/pvpanic.c
> --
> 1.8.3.1
>


-- 
With Best Regards,
Andy Shevchenko
