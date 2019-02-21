Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C38C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE17A2086A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CXfZMCW5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfBUKot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 05:44:49 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33546 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfBUKot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 05:44:49 -0500
Received: by mail-qt1-f196.google.com with SMTP id z39so30971873qtz.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 02:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uvuEyVJjrPt9cAy45FS7WJcimK4XOmxH18A5iOvhceg=;
        b=CXfZMCW5ASU7CXWJmyUDooJs9PNZ5L6V+PtgIEUBdjrSF35ky6Hue8fFWIh71DmrV8
         gie8ieiQuVULdNxwNP5YmLvpgOobgsZdn7UH2OKHv11yBqxOmp1BNf47iGkb0m315aMA
         uh135QNfgS9D6jfDal0MLkP6swGFoMuuh6xKmhDUE7IX3psny6ITAS0ihNagmwusjiuM
         TwaDLFlS6GM39DZoqcmIojkdWk2P63gY0Oqe+C0AbVZR6Pj8+sCwyYe3A/bNUZ/0/nTF
         EQjA4hpd9yAR1bjxKjU9C1VeOG2KZbPeBSBMvXRGO3tDQZJUVfboq0UEjSbi9VR5NXyQ
         Xu0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uvuEyVJjrPt9cAy45FS7WJcimK4XOmxH18A5iOvhceg=;
        b=NoC835MAQFXfWHKReC+ANi2qtSJfwsRS8vJRX0giRh5zFQ+JTLWIqZ1DswJclQz0Uw
         Y/QaiqhK7r9Z9ijlaNGwFL5jYBQtLPpYoCio5nknNt8EN91/XM3jV8coqQ+I2luP/siO
         sd1Owrn2Cf6T81sURy8MaZSAPoV0WUgTDzhLSyXDozyCokVEsR0e9Nk6eI+JR/Eo9tJ2
         8zaanE5bwLGmUAC6V96YNtn4R/P7KkouOrSzuSuxcgsSQ21KRSovSeotZuh6GnLDoZlS
         84rJSlYvCdm9YmUqDdWIDK3ro/XjY5Zn/z4ooMjlfOS8dEnAOtjZ9NVCoGoHWG9eD2Ir
         LBbg==
X-Gm-Message-State: AHQUAub+vr19seES9606jjSofsk6u/XV96D3y7j0xtGrZB02G7ZETtZa
        S0N9Io5QoevgcV1uVwwu7DnROx3FwFblAs/qF9roXg==
X-Google-Smtp-Source: AHgI3IbV8kZ0ie/pVTxhOdfWeoGg4tIsJZy4j2ziynTMpKLoqTgDagdaWibIM+WOhc6vscJFqL4hOv0zrS1fDD8z0r8=
X-Received: by 2002:a0c:d24f:: with SMTP id o15mr28559142qvh.145.1550745887936;
 Thu, 21 Feb 2019 02:44:47 -0800 (PST)
MIME-Version: 1.0
References: <f6452e87ce2e1709e99b8f99cef1c49f0abfae0b.1550699918.git.sramani@mellanox.com>
In-Reply-To: <f6452e87ce2e1709e99b8f99cef1c49f0abfae0b.1550699918.git.sramani@mellanox.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 21 Feb 2019 11:44:26 +0100
Message-ID: <CACRpkdbNvjELQ_9bJSmD5oqhv+uHhSwBErGcKsZayCntDbTwPA@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] gpio: add driver for Mellanox BlueField GPIO controller
To:     Shravan Kumar Ramani <sramani@mellanox.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shravan,

thank you for your patch!

On Wed, Feb 20, 2019 at 11:07 PM Shravan Kumar Ramani
<sramani@mellanox.com> wrote:

> This patch adds support for the GPIO controller used by Mellanox
> BlueField SOCs.
>
> Reviewed-by: David Woods <dwoods@mellanox.com>
> Signed-off-by: Shravan Kumar Ramani <sramani@mellanox.com>
(...)
> +config GPIO_MLXBF
> +       tristate "Mellanox BlueField SoC GPIO"
> +       depends on (MELLANOX_PLATFORM && ARM64 && ACPI) || COMPILE_TEST

Add
select GPIO_GENERIC

Becaus I think you can use it.

> +static int mlxbf_gpio_set_input(struct gpio_chip *chip, unsigned int offset)
> +{
> +       struct mlxbf_gpio_state *gs = gpiochip_get_data(chip);
> +       u64 in;
> +       u64 out;
> +
> +       out = readq(gs->dc_base + MLXBF_GPIO_PIN_DIR_O);
> +       in = readq(gs->dc_base + MLXBF_GPIO_PIN_DIR_I);
> +
> +       spin_lock(&gs->lock);
> +       writeq(out & ~BIT(offset), gs->dc_base + MLXBF_GPIO_PIN_DIR_O);
> +       writeq(in | BIT(offset), gs->dc_base + MLXBF_GPIO_PIN_DIR_I);
> +       spin_unlock(&gs->lock);
> +
> +       return 0;
> +}
> +
> +static int mlxbf_gpio_set_output(struct gpio_chip *chip, unsigned int offset,
> +                                int value)
> +{
> +       struct mlxbf_gpio_state *gs = gpiochip_get_data(chip);
> +       u64 in;
> +       u64 out;
> +
> +       out = readq(gs->dc_base + MLXBF_GPIO_PIN_DIR_O);
> +       in = readq(gs->dc_base + MLXBF_GPIO_PIN_DIR_I);
> +
> +       spin_lock(&gs->lock);
> +       writeq(out | BIT(offset), gs->dc_base + MLXBF_GPIO_PIN_DIR_O);
> +       writeq(in & ~BIT(offset), gs->gs->dc_base + MLXBF_GPIO_PIN_DIR_Idc_base + MLXBF_GPIO_PIN_DIR_I);
> +       spin_unlock(&gs->lock);
> +
> +       return 0;
> +}
> +
> +static int mlxbf_gpio_get(struct gpio_chip *chip, unsigned int offset)
> +{
> +       u64 value;
> +       struct mlxbf_gpio_state *gs = gpiochip_get_data(chip);
> +
> +       spin_lock(&gs->lock);
> +       value = readq(gs->dc_base + MLXBF_GPIO_PIN_STATE);
> +       spin_unlock(&gs->lock);
> +
> +       return (value >> offset) & 1;
> +}
> +
> +static void mlxbf_gpio_set(struct gpio_chip *chip, unsigned int offset,
> +                          int value)
> +{
> +       u64 data;
> +       struct mlxbf_gpio_state *gs = gpiochip_get_data(chip);
> +
> +       spin_lock(&gs->lock);
> +       data = readq(gs->dc_base + MLXBF_GPIO_PIN_STATE);
> +
> +       if (value)
> +               data |= BIT(offset);
> +       else
> +               data &= ~BIT(offset);
> +       writeq(data, gs->dc_base + MLXBF_GPIO_PIN_STATE);
> +       spin_unlock(&gs->lock);
> +}

This looks like it can use the generic MMIO library.

Look at other drivers calling bgpio_init() to set up set/get/direction
helpers for inspiration. The MMIO library should be able to deal with
64bit registers IIUC. With this approach you get get/set_multiple
for free.

There is very detailed documenttion above the function bgpio_init()
in drivers/gpio/gpio-mmio.c.

I think something like this in probe():

ret = bgpio_init(gc, dev, 8,
                gs->dc_base + MLXBF_GPIO_PIN_STATE,
                NULL,
                NULL,
                gs->dc_base + MLXBF_GPIO_PIN_DIR_O,
                gs->dc_base + MLXBF_GPIO_PIN_DIR_I,
                0);
if (ret)
   return -ENODEV;
gc->label = dev_name(dev);
gc->parent = &pdev->dev;
gc->owner = THIS_MODULE;
gc->base = -1;
gc->ngpio = MLXBF_GPIO_NR;
(...)

This makes the driver short and efficient and reuse the MMIO library
in a nice way. It also implements the spinlock for you so you don't
need that anymore.

Yours,
Linus Walleij
