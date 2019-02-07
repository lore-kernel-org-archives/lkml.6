Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B6AC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE27E2086C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oWgi7Ysc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfBGSYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 13:24:44 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33219 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfBGSYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 13:24:43 -0500
Received: by mail-pf1-f194.google.com with SMTP id c123so324178pfb.0;
        Thu, 07 Feb 2019 10:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mvnXM74kKHmI/PDwdpRvKVQMY9Rjr43CLMCE5Ua4/Kw=;
        b=oWgi7YscRVVO7CUWbwWVjjos2UAZrTG2kVKcvTPXZF36VtWaQhjLe79DotYOejLZOD
         sMwZ0T8+3bEMeaVoJRJkwwdiAi13NFga/ji7ouX+IIPF+iGtZzJkBh543AAaLPg3luba
         enOOlwa3OsPHVqXSqYQSpzZHRrl22Dbfc/qKQSt4Mlq072B/AgT11qiwCaOom+opyh9G
         9KseYCH0uzTxvkR9Acpndnuf0UVWa3HbPwe3B3+RQjzehAp260W7Vm1v+/8r94mG1gr4
         UNIVAg0u4tgZiif5nWO3oiUUPhvPjkdROOQiUZCOM3tcJ81PPSMUcu9cd5jTPuTYKHWh
         bKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mvnXM74kKHmI/PDwdpRvKVQMY9Rjr43CLMCE5Ua4/Kw=;
        b=nldM4e6qiqtQhK4W5TxSdwkUKJKxGx3WfNyuOq22Dgb3kZRXZIdg0ZJ/c1Qn+/uHfA
         alTOxupjzJ3B5w2crR5CTvJ4fBu5uw6GjB/wAvkyCp2Nwsq9H1fKiN/FGOKZL+g6N3MV
         gFUWRY6Q4YgxgZa1SUgaxrcjnw93f5Ds4LkJrMG6sCVdw/joVK38XEHhT3E84md6FX92
         vlg8pOwoT1KO82WkOlKbA71i9GBSuS2UTeV4h+0uidmSLWzAWM0aGdHHwTIASI58pULa
         gsMkWrDNy9wSAAVBPb7+QCCehP/TKO3QwbAsx2Xstx6TZAPMhwdFPp7uY9fXO4AzZUh8
         GQKw==
X-Gm-Message-State: AHQUAuaJSxTezr66VB3MAzpS2ygD1N2VBeunsSqb6Q/G+eeZwsllpKHm
        oR7ouGzT9TAm+TH3TcYzIR1LO/Y2LwdiQn4CP6o=
X-Google-Smtp-Source: AHgI3Ia8676jk0Aykwo7Btev+Mzo7yeBj8xmLZO9w8zekDh35ZT0cvzZnjzonR2+H8AUPjkMI973qVgJL+I9tJkWLW0=
X-Received: by 2002:a63:4a21:: with SMTP id x33mr16498887pga.428.1549563882721;
 Thu, 07 Feb 2019 10:24:42 -0800 (PST)
MIME-Version: 1.0
References: <1549559639-9447-1-git-send-email-info@metux.net> <1549559639-9447-2-git-send-email-info@metux.net>
In-Reply-To: <1549559639-9447-2-git-send-email-info@metux.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 7 Feb 2019 20:24:31 +0200
Message-ID: <CAHp75Vc35zXh2fM94TfEjgunPKFqQqvBACjd4gHHQTe0r3AVtQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86: pcengines apuv2 gpio/leds/keys platform driver
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 7, 2019 at 7:14 PM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:

Thanks for the patch, my comments below.

> Driver for PCengines APUv2 board that supports GPIOs via AMD PCH
> and attached LEDs and keys.

You should put here why ACPI can't be used for providing a necessary
information.
For example, 'The driver is targeting old platforms that do not have a
proper entry in ACPI tables for these devices. In new version of BIOS
this going to be fixed."

Besides same comments as per other patch in the series, can you tell
why it's not an MFD driver?

> +       depends on KEYBOARD_GPIO
> +       depends on KEYBOARD_GPIO_POLLED
> +       depends on LEDS_GPIO

Why?
Is any of this fatal to have driver not registered?


> +/* TODO
> +   * support apu1 board (different fch, different register layouts
> +   * add spinlocks
> +*/

Either remove this, or fix it properly. TODO is not going to be upstream.

> +#define FCH_ACPI_MMIO_BASE     0xFED80000
> +#define FCH_GPIO_OFFSET                0x1500
> +#define FCH_GPIO_SIZE          0x300

0x0300

> +#define GPIO_BASE              100
> +
> +#define GPIO_LED1              (GPIO_BASE+0)
> +#define GPIO_LED2              (GPIO_BASE+1)
> +#define GPIO_LED3              (GPIO_BASE+2)
> +#define GPIO_MODESW            (GPIO_BASE+3)
> +#define GPIO_SIMSWAP           (GPIO_BASE+4)

Have namespace issues.

> +static struct amd_fch_gpio_reg apu2_gpio_regs[] = {
> +       { 0x44 }, // GPIO_57 -- LED1
> +       { 0x45 }, // GPIO_58 -- LED2
> +       { 0x46 }, // GPIO_59 -- LED3
> +       { 0x59 }, // GPIO_32 -- LED4 -- GE32 -- #modesw
> +       { 0x5A }, // GPIO_33 -- LED5 -- GE33 -- simswap
> +       { 0x42 }, // GPIO_51 -- LED6
> +       { 0x43 }, // GPIO_55 -- LED7
> +       { 0x47 }, // GPIO_64 -- LED8
> +       { 0x48 }, // GPIO_68 -- LED9
> +       { 0x4C }, // GPIO_70 -- LED10

Keep it sorted and consider to use 'gpio-names' property.

> +};

> +static struct platform_device *apu_gpio_pdev = NULL;
> +static struct platform_device *apu_leds_pdev = NULL;
> +static struct platform_device *apu_keys_pdev = NULL;

Redundant assignments.

> +static int __init apu_gpio_init(void)
> +{
> +       int rc;

> +       const struct dmi_system_id *dmi = dmi_first_match(apu_gpio_dmi_table);

Split it to three lines.

const struct ... *id;

id = dmi_first_match(...);
if (!id)

> +       if (!dmi) {
> +               pr_err(KBUILD_MODNAME ": failed to detect apu board via dmi\n");
> +               return -ENODEV;
> +       }

> +                       -1,                                     /* id */

PLATFORM_DEVID_NONE ?

> +fail:
> +       if (!IS_ERR(apu_keys_pdev))
> +               platform_device_unregister(apu_keys_pdev);
> +       if (!IS_ERR(apu_leds_pdev))
> +               platform_device_unregister(apu_leds_pdev);
> +       if (!IS_ERR(apu_gpio_pdev))
> +               platform_device_unregister(apu_gpio_pdev);

So, why the failure of the registration of any of these devices is fatal?

> +}

> +static void __exit apu_gpio_exit(void)
> +{

> +       if (!IS_ERR(apu_keys_pdev))

Redundant.
See commit 99fef587ff98 ("driver core: platform: Respect return code
of platform_device_register_full()") for the details.

> +               platform_device_unregister(apu_keys_pdev);
> +       if (!IS_ERR(apu_leds_pdev))
> +               platform_device_unregister(apu_leds_pdev);
> +       if (!IS_ERR(apu_gpio_pdev))
> +               platform_device_unregister(apu_gpio_pdev);
> +}

> +MODULE_LICENSE("GPL");

License mismatch.

-- 
With Best Regards,
Andy Shevchenko
