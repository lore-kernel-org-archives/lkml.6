Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851AFC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 08:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A354214F1
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 08:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="il9JaSep"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A354214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731593AbeKNSzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 13:55:45 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37512 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbeKNSzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 13:55:45 -0500
Received: by mail-qk1-f195.google.com with SMTP id 131so24377528qkd.4;
        Wed, 14 Nov 2018 00:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=73jh9UXun8r8VPe9d3GfRjJwdMPdAjuraqozfNc8yL4=;
        b=il9JaSepGxnZY4GGDS2zPjw59v0SvRS41m8GGvm2czAvNdnW+GprjidtJAtAOsaWrp
         iu8wjrn0JEQXZa4+1XikI/QTB9buY9ZmAPpgtSvbfzL5k1lKd187ClWS9Fs3Mcdh+v2g
         LEccg960seKX+J17x4QKVAeILhB5JdTVaPgig0CqnFCCX/6tPDjo6nQbRwIcBqslLshi
         n75Kr/hcAtJoG8HvILF8r0yKUferHWP2J2jDP9grNX09GvQM+3mPZaGnDeBTyB2ViQj6
         o0rAASG8ugfoq4CFB7GhcAho0A+gzNMXKPUS9XethSS5z6IoE56w5B/rITqbhbJ4YlMi
         BIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=73jh9UXun8r8VPe9d3GfRjJwdMPdAjuraqozfNc8yL4=;
        b=X+6tZ/JUOx/OA27RTCsvFZppbxMeizHHmpDkIpbIwdx+RAqei2VrXxD1UtFMkV0OMv
         1ZZtkAdMedy7MmG508P6cAzyKs22XHGT+tsRpyrO63QWHbMjo6CIUOXA8HLI8jIGoznG
         GtC7OxKGB4hDJ0o3PCpf7Q8NW8FihtrP+ZHyu/0qG6X1uJj9K1fdjQR5iRtpEKqX7aVl
         FhOKxtkZCA8w2YBu1Ok6l7mOuB7OuLFKTMdXW7Oa4SkaaWbLmnDzKsEHSbI9FGfAtrDr
         snz2X8AmS6ig8b6UZ2ySISqgN0YQZtAsfDzMVi/Y48sAWkPffD5qh98AZOrdQhvLW3rI
         7CtA==
X-Gm-Message-State: AGRZ1gJtNSj0vhoUCcq442cUVNg40iEL/MBAbRBYEWyWFlwcaVY4XSAS
        xmeflVeDG3+qy0SYbD0jVBLbk+c5G0Szh2MKrAc=
X-Google-Smtp-Source: AJdET5c/eoSELjgXPEbm+lOpbNlWNXP4hXJaM4SQfk6yPqLvUzNjrDEL0XAwY4pKRX0w9e3wQJ73z/GtWNq5V6pPY60=
X-Received: by 2002:a37:1f44:: with SMTP id f65mr823186qkf.33.1542185605619;
 Wed, 14 Nov 2018 00:53:25 -0800 (PST)
MIME-Version: 1.0
References: <20181114072658.11457-1-fe@dev.tdt.de> <20181114072658.11457-2-fe@dev.tdt.de>
In-Reply-To: <20181114072658.11457-2-fe@dev.tdt.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 14 Nov 2018 10:53:14 +0200
Message-ID: <CAHp75VfeDzXeb7g2rz2CUcfnLCeGxn-nVC8hiwzqV9E=mCEx4w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] gpio: Add driver for PC Engines APU2/APU3 GPIOs
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
> Add a new device driver "gpio-apu" which will handle the GPIOs onAPU2
> and APU3 devices from PC Engines.
>
> APU2 (https://pcengines.ch/schema/apu2c.pdf page 7):
> - G32 is "button_reset" connected to the smd-button on the frontpanel
> - G50 is "mpcie2_reset" connected to mPCIe2 reset line
> - G51 is "mpcie3_reset" connected to mPCIe3 reset line
>
> APU3 (https://pcengines.ch/schema/apu3c.pdf page 7):
> - G32 is "button_reset" connected to the smd-button on the frontpanel
> - G50 is "mpcie2_reset" connected to mPCIe2 reset line
> - G51 is "mpcie3_reset" connected to mPCIe3 reset line
> - G33 is "simswap" connected to SIM switch IC to swap the SIM between
>   mPCIe2 and mPCIe3 slot
>
> Signed-off-by: Florian Eckert <fe@dev.tdt.de>
> ---
>  drivers/gpio/Kconfig    |   8 ++
>  drivers/gpio/Makefile   |   1 +
>  drivers/gpio/gpio-apu.c | 312 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 321 insertions(+)
>  create mode 100644 drivers/gpio/gpio-apu.c
>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 833a1b51c948..f9e603d5670c 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -117,6 +117,14 @@ config GPIO_AMDPT
>           driver for GPIO functionality on Promontory IOHub
>           Require ACPI ASL code to enumerate as a platform device.
>
> +config GPIO_APU
> +       tristate "PC Engines APU2/APU3 GPIO support"
> +       depends on X86
> +       select GPIO_GENERIC
> +       help
> +         Say Y here to support GPIO functionality on APU2/APU3 boards
> +         from PC Engines.
> +
>  config GPIO_ASPEED
>         tristate "Aspeed GPIO support"
>         depends on (ARCH_ASPEED || COMPILE_TEST) && OF_GPIO
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index 671c4477c951..9c27523fb189 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -29,6 +29,7 @@ obj-$(CONFIG_GPIO_ALTERA)     += gpio-altera.o
>  obj-$(CONFIG_GPIO_ALTERA_A10SR)        += gpio-altera-a10sr.o
>  obj-$(CONFIG_GPIO_AMD8111)     += gpio-amd8111.o
>  obj-$(CONFIG_GPIO_AMDPT)       += gpio-amdpt.o
> +obj-$(CONFIG_GPIO_APU)         += gpio-apu.o
>  obj-$(CONFIG_GPIO_ARIZONA)     += gpio-arizona.o
>  obj-$(CONFIG_GPIO_ATH79)       += gpio-ath79.o
>  obj-$(CONFIG_GPIO_ASPEED)      += gpio-aspeed.o
> diff --git a/drivers/gpio/gpio-apu.c b/drivers/gpio/gpio-apu.c
> new file mode 100644
> index 000000000000..df166c0d8258
> --- /dev/null
> +++ b/drivers/gpio/gpio-apu.c
> @@ -0,0 +1,312 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* PC Engines APU2/APU3 GPIO device driver
> + *
> + * Copyright (C) 2018 Florian Eckert <fe@dev.tdt.de>
> + */
> +
> +#include <linux/dmi.h>
> +#include <linux/err.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/input.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#define DEVNAME                "gpio-apu"
> +
> +#define APU_FCH_ACPI_MMIO_BASE 0xFED80000
> +#define APU_FCH_GPIO_BASE      (APU_FCH_ACPI_MMIO_BASE + 0x1500)
> +#define APU_GPIO_BIT_RD        16
> +#define APU_GPIO_BIT_WR        22
> +#define APU_GPIO_BIT_DIR       23
> +
> +struct apu_gpio_pdata {
> +       struct platform_device *pdev;
> +       struct gpio_chip *chip;
> +       unsigned long *offset;          /* base register offset */
> +       void __iomem **addr;            /* remapped iomem addresses */
> +       spinlock_t lock;                /* lock register access */
> +};
> +
> +static struct apu_gpio_pdata *apu_gpio;
> +
> +/* APU2 */
> +static unsigned long apu2_gpio_offset[] = {
> +       APU_FCH_GPIO_BASE + 89 * sizeof(u32),
> +       APU_FCH_GPIO_BASE + 67 * sizeof(u32),
> +       APU_FCH_GPIO_BASE + 66 * sizeof(u32),
> +};
> +static const char * const apu2_gpio_names[] = {
> +       "button_reset",
> +       "mpcie2_reset",
> +       "mpcie3_reset",
> +};
> +
> +/* APU3 */
> +static unsigned long apu3_gpio_offset[] = {
> +       APU_FCH_GPIO_BASE + 89 * sizeof(u32),
> +       APU_FCH_GPIO_BASE + 67 * sizeof(u32),
> +       APU_FCH_GPIO_BASE + 66 * sizeof(u32),
> +       APU_FCH_GPIO_BASE + 90 * sizeof(u32),
> +};
> +static const char * const apu3_gpio_names[] = {
> +       "button_reset",
> +       "mpcie2_reset",
> +       "mpcie3_reset",
> +       "simswap",
> +};
> +
> +static int gpio_apu_get_dir(struct gpio_chip *chip, unsigned int offset)
> +{
> +       u32 val;
> +
> +       spin_lock(&apu_gpio->lock);
> +
> +       val = ~ioread32(apu_gpio->addr[offset]);
> +       val = (val >> APU_GPIO_BIT_DIR) & 1;
> +
> +       spin_unlock(&apu_gpio->lock);
> +
> +       return val;
> +}
> +
> +static int gpio_apu_dir_in(struct gpio_chip *chip, unsigned int offset)
> +{
> +       u32 val;
> +
> +       spin_lock(&apu_gpio->lock);
> +
> +       val = ioread32(apu_gpio->addr[offset]);
> +       val &= ~BIT(APU_GPIO_BIT_DIR);
> +       iowrite32(val, apu_gpio->addr[offset]);
> +
> +       spin_unlock(&apu_gpio->lock);
> +
> +       return 0;
> +}
> +
> +static int gpio_apu_dir_out(struct gpio_chip *chip, unsigned int offset,
> +               int value)
> +{
> +       u32 val;
> +
> +       spin_lock(&apu_gpio->lock);
> +
> +       val = ioread32(apu_gpio->addr[offset]);
> +       val |= BIT(APU_GPIO_BIT_DIR);
> +       iowrite32(val, apu_gpio->addr[offset]);
> +
> +       spin_unlock(&apu_gpio->lock);
> +
> +       return 0;
> +}
> +
> +static int gpio_apu_get_data(struct gpio_chip *chip, unsigned int offset)
> +{
> +       u32 val;
> +
> +       spin_lock(&apu_gpio->lock);
> +
> +       val = ioread32(apu_gpio->addr[offset]);

> +       val = (val >> APU_GPIO_BIT_RD) & 1;

This can be done outside of spin lock as a part of return statement.

> +
> +       spin_unlock(&apu_gpio->lock);
> +
> +       return val;
> +}
> +
> +static void gpio_apu_set_data(struct gpio_chip *chip, unsigned int offset,
> +               int value)
> +{
> +       u32 val;
> +
> +       spin_lock(&apu_gpio->lock);
> +
> +       val = ioread32(apu_gpio->addr[offset]);
> +       if (value)
> +               val |= BIT(APU_GPIO_BIT_WR);
> +       else
> +               val &= ~BIT(APU_GPIO_BIT_WR);
> +       iowrite32(val, apu_gpio->addr[offset]);
> +
> +       spin_unlock(&apu_gpio->lock);
> +}
> +
> +static const struct dmi_system_id apu_gpio_dmi_table[] __initconst = {
> +       /* PC Engines APU2 with "Legacy" bios < 4.0.8 */
> +       {
> +               .ident = "apu2",
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
> +                       DMI_MATCH(DMI_BOARD_NAME, "APU2")
> +               }
> +       },
> +       /* PC Engines APU2 with "Legacy" bios >= 4.0.8 */
> +       {
> +               .ident = "apu2",
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
> +                       DMI_MATCH(DMI_BOARD_NAME, "apu2")
> +               }
> +       },
> +       /* PC Engines APU2 with "Mainline" bios */
> +       {
> +               .ident = "apu2",
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
> +                       DMI_MATCH(DMI_BOARD_NAME, "PC Engines apu2")
> +               }
> +       },
> +       /* PC Engines APU3 with "Legacy" bios < 4.0.8 */
> +       {
> +               .ident = "apu3",
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
> +                       DMI_MATCH(DMI_BOARD_NAME, "APU3")
> +               }
> +       },
> +       /* PC Engines APU3 with "Legacy" bios >= 4.0.8 */
> +       {
> +               .ident = "apu3",
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
> +                       DMI_MATCH(DMI_BOARD_NAME, "apu3")
> +               }
> +       },
> +       /* PC Engines APU3 with "Mainline" bios */
> +       {
> +               .ident = "apu3",
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
> +                       DMI_MATCH(DMI_BOARD_NAME, "PC Engines apu3")
> +               }
> +       },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(dmi, apu_gpio_dmi_table);
> +
> +static struct gpio_chip gpio_apu_chip = {
> +       .label = "gpio-apu",
> +       .owner = THIS_MODULE,
> +       .base = 20,
> +       .get_direction = gpio_apu_get_dir,
> +       .direction_input = gpio_apu_dir_in,
> +       .direction_output = gpio_apu_dir_out,
> +       .get = gpio_apu_get_data,
> +       .set = gpio_apu_set_data,
> +};
> +
> +static int __init apu_gpio_probe(struct platform_device *pdev)
> +{

> +       int i;

unsigned int i; ?

> +
> +       apu_gpio = devm_kzalloc(&pdev->dev, sizeof(*apu_gpio), GFP_KERNEL);

> +

Redundant blank line.

> +       if (!apu_gpio)
> +               return -ENOMEM;
> +
> +       apu_gpio->pdev = pdev;
> +       apu_gpio->chip = &gpio_apu_chip;
> +       spin_lock_init(&apu_gpio->lock);
> +

> +       if (dmi_match(DMI_BOARD_NAME, "APU3") ||
> +           dmi_match(DMI_BOARD_NAME, "apu3") ||
> +           dmi_match(DMI_BOARD_NAME, "PC Engines apu3")) {

This branch...

> +               apu_gpio->addr = devm_kzalloc(&pdev->dev,
> +                               sizeof(apu3_gpio_offset),
> +                               GFP_KERNEL);
> +
> +               if (!apu_gpio->addr)
> +                       return -ENOMEM;
> +
> +               apu_gpio->offset = apu3_gpio_offset;
> +               apu_gpio->chip->names = apu3_gpio_names;
> +               apu_gpio->chip->ngpio = ARRAY_SIZE(apu3_gpio_offset);
> +               for (i = 0; i < ARRAY_SIZE(apu3_gpio_offset); i++) {
> +                       apu_gpio->addr[i] = devm_ioremap(&pdev->dev,
> +                                       apu_gpio->offset[i], sizeof(u32));
> +                       if (!apu_gpio->addr[i])
> +                               return -ENOMEM;
> +               }
> +       } else if (dmi_match(DMI_BOARD_NAME, "APU2") ||
> +                  dmi_match(DMI_BOARD_NAME, "apu2") ||
> +                  dmi_match(DMI_BOARD_NAME, "PC Engines apu2")) {

...and this one can be done as a callback functions in a regular DMI
table. See, for example, drivers in drivers/platform/x86.

> +               apu_gpio->addr = devm_kzalloc(&pdev->dev,
> +                               sizeof(apu2_gpio_offset),
> +                               GFP_KERNEL);
> +
> +               if (!apu_gpio->addr)
> +                       return -ENOMEM;
> +
> +               apu_gpio->offset = apu2_gpio_offset;
> +               apu_gpio->chip->names = apu2_gpio_names;
> +               apu_gpio->chip->ngpio = ARRAY_SIZE(apu2_gpio_offset);
> +               for (i = 0; i < ARRAY_SIZE(apu2_gpio_offset); i++) {
> +                       apu_gpio->addr[i] = devm_ioremap(&pdev->dev,
> +                                       apu_gpio->offset[i], sizeof(u32));
> +                       if (!apu_gpio->addr[i])
> +                               return -ENOMEM;
> +               }
> +       }
> +
> +       return devm_gpiochip_add_data(&pdev->dev, apu_gpio->chip, NULL);
> +}
> +
> +static struct platform_driver apu_gpio_driver = {
> +       .driver = {
> +               .name = KBUILD_MODNAME,
> +       },
> +};
> +
> +static int __init apu_gpio_init(void)
> +{
> +       struct platform_device *pdev;
> +       int err;
> +

> +       if (!dmi_match(DMI_SYS_VENDOR, "PC Engines")) {
> +               pr_err("No PC Engines board detected\n");
> +               return -ENODEV;
> +       }
> +       if (!(dmi_match(DMI_PRODUCT_NAME, "APU2") ||
> +             dmi_match(DMI_PRODUCT_NAME, "apu2") ||
> +             dmi_match(DMI_PRODUCT_NAME, "PC Engines apu2") ||
> +             dmi_match(DMI_PRODUCT_NAME, "APU3") ||
> +             dmi_match(DMI_PRODUCT_NAME, "apu3") ||
> +             dmi_match(DMI_PRODUCT_NAME, "PC Engines apu3"))) {
> +               pr_err("Unknown PC Engines board: %s\n",
> +                               dmi_get_system_info(DMI_PRODUCT_NAME));
> +               return -ENODEV;
> +       }

Similar here, you can get a first match in the table and if none, bail out.

> +
> +       pdev = platform_device_register_simple(KBUILD_MODNAME, -1, NULL, 0);
> +       if (IS_ERR(pdev)) {
> +               pr_err("Device allocation failed\n");
> +               return PTR_ERR(pdev);
> +       }
> +
> +       err = platform_driver_probe(&apu_gpio_driver, apu_gpio_probe);
> +       if (err) {
> +               pr_err("Probe platform driver failed\n");
> +               platform_device_unregister(pdev);
> +       }
> +

> +       pr_info("%s: APU2/3 GPIO driver module loaded\n", DEVNAME);

Noise

> +
> +       return err;
> +}
> +
> +static void __exit apu_gpio_exit(void)
> +{
> +       gpiochip_remove(apu_gpio->chip);
> +       platform_device_unregister(apu_gpio->pdev);
> +       platform_driver_unregister(&apu_gpio_driver);

> +       pr_info("%s: APU2/3 GPIO driver module unloaded\n", DEVNAME);

Noise

> +}
> +
> +module_init(apu_gpio_init);
> +module_exit(apu_gpio_exit);
> +
> +MODULE_AUTHOR("Florian Eckert");
> +MODULE_DESCRIPTION("PC Engines APU2/3 family GPIO driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:gpio_apu");
> --
> 2.11.0
>


-- 
With Best Regards,
Andy Shevchenko
