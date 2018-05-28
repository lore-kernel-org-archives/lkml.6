Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754032AbeE1IAx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 04:00:53 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34185 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753886AbeE1IAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 04:00:51 -0400
X-Google-Smtp-Source: ADUXVKLn9dhdr4q+Uc+FSedYYM6ttEbZD2l2NqRMdO3MaBB6o96g+99ov37tB1JYHFB5nKNVFmY6xLz3W1wdaspdnfA=
MIME-Version: 1.0
In-Reply-To: <20180525171941.26766-4-radu.pirea@microchip.com>
References: <20180525171941.26766-1-radu.pirea@microchip.com> <20180525171941.26766-4-radu.pirea@microchip.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 28 May 2018 11:00:49 +0300
Message-ID: <CAHp75VeeiFhShuMOVzuy2FjxrkfsxxzhyfAnwQNOoeaRwZ103Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] mfd: at91-usart: added mfd driver for usart
To: Radu Pirea <radu.pirea@microchip.com>
Cc: Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        alexandre.belloni@bootlin.com, Lee Jones <lee.jones@linaro.org>,
        Richard Genoud <richard.genoud@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 8:19 PM, Radu Pirea <radu.pirea@microchip.com> wrote:
> This mfd driver is just a wrapper over atmel_serial driver and
> spi-at91-usart driver. Selection of one of the drivers is based on a
> property from device tree. If the property is not specified, the default
> driver is atmel_serial.

> +       depends on OF

What makes this driver OF specific?

> +#include <linux/of.h>
> +#include <linux/of_platform.h>

Ditto.

> +#include <linux/pinctrl/pinctrl.h>

How exactly is this used?

> +#include <linux/platform_device.h>

> +#include <linux/slab.h>

Ditto.

> +#include <linux/types.h>

> +static int at91_usart_mode_probe(struct platform_device *pdev)
> +{
> +       struct device_node *np = pdev->dev.of_node;
> +       struct mfd_cell cell;
> +       u32 opmode;
> +       int err;
> +

> +       err = of_property_read_u32(np, "atmel,usart-mode", &opmode);

Check unified device property API.

> +       return mfd_add_devices(&pdev->dev, PLATFORM_DEVID_AUTO, &cell, 1,
> +                             NULL, 0, NULL);

No devm_ and no ->remove(). Why to leak resources?

-- 
With Best Regards,
Andy Shevchenko
