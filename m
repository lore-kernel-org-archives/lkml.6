Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEA9C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB8FE214F1
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgy6RqJL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB8FE214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732451AbeKNTDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 14:03:12 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36602 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732360AbeKNTDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 14:03:10 -0500
Received: by mail-qk1-f194.google.com with SMTP id o125so24409578qkf.3;
        Wed, 14 Nov 2018 01:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RPD9sah2A1Mv+qiAYHld6BzppwGsqEtwrRC06K8HXYU=;
        b=bgy6RqJLcWsagJzXGZu5B9tevMPVb5OomTQDT02i2wJulRyLSFSJBLvQRyyf4hFexu
         nGIm9r4jm+ZFNS3nmzd4kVXn9kupxqJ0uYqJ9pzFtoPB/dsDk3ARuE0G4ilC9bqCDUEJ
         ZNgaCefjklGKnn5muuioN+hGsZSVNhUsious6FX367LGYV5gaX5wPVZ/p3iGjSz+AeUp
         zcxe47bvS/Omt3P9kETHjGKlRnZTFdpNvYA0/75nhoZONZVQSEVzdn2lMGqxRlvtsZ+S
         oUKUdaoilG9ZI2NBrHOdr5CNQtMTqkHDdvE4mm0cT3nGuSquuFvB5noz7I5JZGSvA+t8
         bPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RPD9sah2A1Mv+qiAYHld6BzppwGsqEtwrRC06K8HXYU=;
        b=UcjHP3HIiWsjuGCaezIvzcTzUk5iIo3XFdyg4DOsP+A5koWjh/qCZ+KVnZ4QnyxRLX
         1ErFtsM6ldg2j+mck8wr0X7z+iF/F+b2fAXBouRHeuax964an1reDzDp9zOtcb84Bc38
         zZDBP6542s5SYOZ/Ww8JvK96g4/02IvEmRcX22eN4DDx+9qS3MsKduVStsLqmAGNTusK
         ZW7a8hT3JFOW5kSqk1wKhEvOkCqD1RGJfudrBDHhxFbwwDvAtCosW0/xxZ9NOECtq4hD
         u2scwhI4x1dDWIjDOB0drCRKX528eFO7fbLexL+kFWT9yRwTKNvhVWesBA2SXyN67Oky
         PeVw==
X-Gm-Message-State: AGRZ1gJJGd6+9RoZdguGhbf2we8c/PRc4MmypnBnr2MuWXp8FoB4psxc
        /xbYCwFNpos65uX/22+xUK4XSBnEhGzZLApENto=
X-Google-Smtp-Source: AJdET5ffphKL5o9g65GlI20XGSfmvPnVrV6J24LnKZyhfc6jK2tj4dKdOyZMtGuaL292kiU45guV8oxAmxVcjEQq/2A=
X-Received: by 2002:a37:1f44:: with SMTP id f65mr838174qkf.33.1542186050088;
 Wed, 14 Nov 2018 01:00:50 -0800 (PST)
MIME-Version: 1.0
References: <20181114072658.11457-1-fe@dev.tdt.de> <20181114072658.11457-3-fe@dev.tdt.de>
In-Reply-To: <20181114072658.11457-3-fe@dev.tdt.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 14 Nov 2018 11:00:38 +0200
Message-ID: <CAHp75Vcmu927EWKHcydVT6+yiN_UG2JcR+xi=hrt1F+UrZXi=Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] kernel: Add reset button platform device for APU2/APU3
To:     Florian Eckert <fe@dev.tdt.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Joe Perches <joe@perches.com>,
        Christian Lamparter <chunkeey@gmail.com>, piotr.krol@3mdeb.com,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 9:27 AM Florian Eckert <fe@dev.tdt.de> wrote:
>
> This will add a x86 platform device "gpio-keys-polled" which uses the
> new gpio-apu drive for APU2 and APU3 boards from PC Engines.

Subject more likely should start from x86/platform.

On the other hand, why it's under arch/x86 and not part of PDx86
(drivers/platform/x86)?

>
> Signed-off-by: Florian Eckert <fe@dev.tdt.de>
> ---
>  arch/x86/Kconfig               | 14 ++++++++
>  arch/x86/platform/Makefile     |  1 +
>  arch/x86/platform/amd/Makefile |  1 +
>  arch/x86/platform/amd/apu.c    | 72 ++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 88 insertions(+)
>  create mode 100644 arch/x86/platform/amd/Makefile
>  create mode 100644 arch/x86/platform/amd/apu.c
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 9d734f3c8234..97c53286fdb6 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2820,6 +2820,20 @@ config TS5500
>
>  endif # X86_32
>
> +if X86_64
> +config APU
> +       bool "PCEngines APU System Support"
> +       help
> +         This option enables system support for the PCEngines APU platform.
> +         At present this just sets up the reset button control on
> +         APU2/APU3 boards. However, other system specific setup should
> +         get added here.
> +
> +         Note: You must still enable the drivers for GPIO and LED support
> +         (GPIO_APU & LEDS_APU) to actually use the LEDs and the GPIOs
> +
> +endif # X86_64
> +
>  config AMD_NB
>         def_bool y
>         depends on CPU_SUP_AMD && PCI
> diff --git a/arch/x86/platform/Makefile b/arch/x86/platform/Makefile
> index d0e835470d01..a95d18810c29 100644
> --- a/arch/x86/platform/Makefile
> +++ b/arch/x86/platform/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # Platform specific code goes here
>  obj-y  += atom/
> +obj-y  += amd/
>  obj-y  += ce4100/
>  obj-y  += efi/
>  obj-y  += geode/
> diff --git a/arch/x86/platform/amd/Makefile b/arch/x86/platform/amd/Makefile
> new file mode 100644
> index 000000000000..bf04c5799d7f
> --- /dev/null
> +++ b/arch/x86/platform/amd/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_APU)              +=apu.o
> diff --git a/arch/x86/platform/amd/apu.c b/arch/x86/platform/amd/apu.c
> new file mode 100644
> index 000000000000..a4b695881177
> --- /dev/null
> +++ b/arch/x86/platform/amd/apu.c
> @@ -0,0 +1,72 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * System Specific setup for PC-Engines APU2/APU3 devices
> + *
> + * Copyright (C) 2018 Florian Eckert <fe@dev.tdt.de>
> + */
> +
> +#include <linux/platform_device.h>

> +#include <linux/gpio.h>

Mustn't be present in new code. Either consumer or driver (in very
rare cases both, not here)

> +#include <linux/input.h>
> +#include <linux/gpio_keys.h>
> +#include <linux/dmi.h>
> +
> +static struct gpio_keys_button apu_gpio_buttons[] = {
> +       {
> +               .code                   = KEY_RESTART,
> +               .gpio                   = 20,
> +               .active_low             = 1,
> +               .desc                   = "Reset button",
> +               .type                   = EV_KEY,
> +               .debounce_interval      = 60,
> +       }
> +};
> +
> +static struct gpio_keys_platform_data apu_buttons_data = {
> +       .buttons                = apu_gpio_buttons,
> +       .nbuttons               = ARRAY_SIZE(apu_gpio_buttons),
> +       .poll_interval          = 20,
> +};
> +
> +static struct platform_device apu_buttons_dev = {
> +       .name                   = "gpio-keys-polled",
> +       .id                     = 1,
> +       .dev = {
> +               .platform_data          = &apu_buttons_data,
> +       }
> +};
> +
> +static struct platform_device *apu_devs[] __initdata = {
> +               &apu_buttons_dev,
> +};
> +
> +static void __init register_apu(void)
> +{
> +       /* Setup push button control through gpio-apu driver */
> +       platform_add_devices(apu_devs, ARRAY_SIZE(apu_devs));
> +}
> +
> +static int __init apu_init(void)
> +{

> +       if (!dmi_match(DMI_SYS_VENDOR, "PC Engines")) {
> +               pr_err("No PC Engines board detected\n");
> +               return -ENODEV;
> +       }
> +
> +       if (!(dmi_match(DMI_PRODUCT_NAME, "APU2") ||
> +             dmi_match(DMI_PRODUCT_NAME, "apu2") ||
> +             dmi_match(DMI_PRODUCT_NAME, "PC Engines apu2") ||
> +             dmi_match(DMI_PRODUCT_NAME, "APU3") ||
> +             dmi_match(DMI_PRODUCT_NAME, "apu3") ||
> +             dmi_match(DMI_PRODUCT_NAME, "PC Engines apu3"))) {
> +               pr_err("Unknown PC Engines board: %s\n",
> +                       dmi_get_system_info(DMI_PRODUCT_NAME));
> +               return -ENODEV;
> +       }

Do we really need this here?
If so, perhaps a common code should be created in a way like
x86_apple_machine global variable?

> +
> +       register_apu();
> +
> +       return 0;
> +}
> +
> +device_initcall(apu_init);
> --
> 2.11.0
>


-- 
With Best Regards,
Andy Shevchenko
