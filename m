Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE81C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 13:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67D7D207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 13:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vCr/1Mhy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbfAXNqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 08:46:39 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41976 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727622AbfAXNqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 08:46:38 -0500
Received: by mail-pg1-f194.google.com with SMTP id m1so2678046pgq.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 05:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jJLIGPWLVJeu/VD4dvVV7/7/k0FEpgfkeI319bl97I8=;
        b=vCr/1MhyhLjSRQvw+laBq3+8G9MbDvZn55Wti4oQb+fgebSgctq//5tAnl7JFhAyyr
         K15CmCAmK1+TJXjOPNXMaxqpaHm/u9LoVvdjOEpRKayGouLMk9BRTRNovGMeoWlczuPf
         CMwLCKHb+IVLv7Biv1H0yfdsACoFbglCxITko4ZhCcEL2BDm8VTkqboU7vxL/GZztJcr
         tYvHsFWiaTjFwz6MtiLGBH/pMQUHPpqWfi0P7n4XWabVjgnnS0pe0gBjxfw62Laf++V0
         0xomLbLWmht83B3WTX8DN8Qps/wiw9uJ+bU9yVJL6GK3Gdsdq2V8yoSp3iBZIzuuEkFC
         bYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jJLIGPWLVJeu/VD4dvVV7/7/k0FEpgfkeI319bl97I8=;
        b=EItKuZYj1fkClNu2DDYf0bY+PoBjcPfYmy1jGsKOEnnmy1+eEY88w5Fu/4Qvm6QfgK
         tsC/WvoZrS/p0ZCdnEFXOXuwgRPNZic2DmD67+QKA6kRLV+Frz4kM4+WG/BJTpRIi3aZ
         H5epDp5M2nmtnaDqAQlqczD4hZSn8eumECxlRQ4sKlSTYjHjMcAZSmKRF5TgU/tEzhVr
         hfkhilCTLa+a3J+Fg6efZpmq1AviJgNMjSC5WGd6/oz77gOxXd6Ll0OifULHBUkpM2oD
         MVZW0u/aDmcgtSaPT7ebEJxZr/n3Sn5yRPzsoC7uBeAgoDcLOSt7jdlaFxx4VsU4V/VM
         tQaA==
X-Gm-Message-State: AJcUukd1pGEkH9g0lWU9Pf/qntYPr6aG3hbAm5d8cbRcQYoAZ++XY/DR
        EtrF1p4bSJYEbvhDniTqlKFK6huSvn0umsgIyMLQKDDA
X-Google-Smtp-Source: ALg8bN7DZQ9aek1mbSoTZCZXXV6Xf/CquyMveP7EHnSKsBGtm6EMAuuAw9S8ZrInuCci7W3GgvRrYXOkSUdxswVJwAQ=
X-Received: by 2002:a63:d450:: with SMTP id i16mr5906831pgj.246.1548337597249;
 Thu, 24 Jan 2019 05:46:37 -0800 (PST)
MIME-Version: 1.0
References: <1548348038-69560-1-git-send-email-peng.hao2@zte.com.cn> <1548348038-69560-2-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1548348038-69560-2-git-send-email-peng.hao2@zte.com.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 24 Jan 2019 15:46:26 +0200
Message-ID: <CAHp75VfgKH+uCUHyo=bRXU-tmDCLukXgZRN6rXDV_z+oCLG9Aw@mail.gmail.com>
Subject: Re: [PATCH V4 1/6] misc/pvpanic: preparing for pvpanic driver framework
To:     Peng Hao <peng.hao2@zte.com.cn>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 10:17 AM Peng Hao <peng.hao2@zte.com.cn> wrote:
>
> Preparing for pvpanic driver framework. Create a pvpanic driver
> directory and move current driver file to new directory.
>

This one is okay.

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
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# Copyright (c) 2018 ZTE Ltd.
> +
> +obj-$(CONFIG_PVPANIC)      += pvpanic.o
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
