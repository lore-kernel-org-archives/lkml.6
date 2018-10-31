Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB647C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6862A20664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="P/bHYtKY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6862A20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732298AbeKAIP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:15:57 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40204 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731068AbeKAIPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:15:55 -0400
Received: by mail-lj1-f193.google.com with SMTP id t22-v6so16415141lji.7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 16:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zqh9IOUVZdUuiMLhRIXCgBB9k/G7N/Sy+ajuwjMKvI0=;
        b=P/bHYtKYsb4N9MWhALOJOz06j3Qt1okbrrCqj9e/5JXEsNasHbDGrX8rQ5Kts3et6Q
         abH4IB2sTpucwDUZEuUEswbROii0HzWcJ4zz3jEFJguoubgiRJxMsIIWtzaNuUlkk/Yz
         clzwBj8xVhF06DotwLcvhK6t3aNBOXnhJyOvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zqh9IOUVZdUuiMLhRIXCgBB9k/G7N/Sy+ajuwjMKvI0=;
        b=Fj/P0IJL0nhF99YdATRoCURZLAF9ReEbF9VJd796gxMOglPLlBV18jm91rTGfyZxD9
         uuOKQ1qeLbneuGcl1WZ6LlI7uBtH0IEcHruiWyLPCLxnxgCGrs2z12aotb6ZYVHgZasx
         sZ9NuRd0dwb3w73BZj0ReMc7cOdNQZScRpT4U/KiZQPBcWg7HucclDgz+cNBRTtQeAWn
         ruNiGI1v8M3ta2fBYriQz/jIoi5+OYFMf/cb9OzjuDzTESAty0PC4pEtBiULlkDCUyfD
         twFMz7P9+i/sp1Cx726LeZ/VnBABDNrXcBDh6CgYHHhmEWjFiTPQbEJOctViOMsCsZuM
         I+XA==
X-Gm-Message-State: AGRZ1gLNk6isqoALetwk3RlifnnRaluZUMPNcCX3wCxXtFYcCFsli5Hi
        /D/y77/IUHdEFxI4qB/9//9fn5WGbJqjzS7YqSoQsg==
X-Google-Smtp-Source: AJdET5d8YvF2yP82R3RIppcLVL0r3aqKCjpWm6/Ovh2q7T1R3t3qkAIYSt649Ju2UyyYbOqIzR2e19P2NRKpHMfsPVo=
X-Received: by 2002:a2e:9849:: with SMTP id e9-v6mr3321439ljj.9.1541027739941;
 Wed, 31 Oct 2018 16:15:39 -0700 (PDT)
MIME-Version: 1.0
References: <20181031194425.32132-1-TheSven73@googlemail.com> <20181031194425.32132-2-TheSven73@googlemail.com>
In-Reply-To: <20181031194425.32132-2-TheSven73@googlemail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 1 Nov 2018 00:15:25 +0100
Message-ID: <CACRpkdai-6iNbz4EGuHNHkQYyR+yhTEJdRXP4G6fUKpA+XApjQ@mail.gmail.com>
Subject: Re: [PATCH anybus v2 1/5] misc: support the Arcx anybus bridge.
To:     Sven Van Asbroeck <thesven73@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     svendev@arcx.com, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Thierry Reding <treding@nvidia.com>,
        David Lechner <david@lechnology.com>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Johan Hovold <johan@kernel.org>,
        Michal Simek <monstr@monstr.eu>, michal.vokac@ysoft.com,
        Greg KH <gregkh@linuxfoundation.org>, john.garry@huawei.com,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Stuart Yoder <stuyoder@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sven,

On Wed, Oct 31, 2018 at 8:44 PM <thesven73@gmail.com> wrote:

> From: Sven Van Asbroeck <svendev@arcx.com>
>
> Add a driver for the Arcx anybus bridge.
>
> This chip embeds up to two Anybus-S application connectors
> (slots), and connects to the SoC via a parallel memory bus.
> There is also a CAN power readout, unrelated to the Anybus.
>
> Signed-off-by: Sven Van Asbroeck <svendev@arcx.com>

This is fun :)

>  drivers/misc/Kconfig         |   9 ++
>  drivers/misc/Makefile        |   1 +
>  drivers/misc/anybus-bridge.c | 301 +++++++++++++++++++++++++++++++++++

I would put this also in drivers/bus, why not. Just two files
there. It's a bus bridge for sure, we keep them there.
drivers/reset if it is mostly about resetting stuff.

> +config ARCX_ANYBUS_BRIDGE
> +       tristate "Arcx Anybus-S Bridge"
> +       depends on OF

depends on GPIOLIB

> +       help
> +         Select this to get support for the Arcx Anybus bridge.
> +         It connects to the SoC via a parallel memory bus, and
> +         embeds up to two Anybus-S application connectors (slots).
> +         There is also a CAN power readout, unrelated to the Anybus.

(...)
> +#include <linux/gpio.h>
> +#include <linux/of_gpio.h>

Don't use these please. Juse use
#include <linux/gpio/consumer.h>

> +struct bridge_priv {
> +       struct device *class_dev;
> +       struct reset_controller_dev rcdev;
> +       bool common_reset;
> +       int reset_gpio;

struct gpio_desc *reset_gpiod;

> +       void __iomem *cpld_base;
> +       spinlock_t regs_lock;
> +       u8 control_reg;
> +       char version[3];
> +       u16 design_no;
(...)

> +static ssize_t version_show(struct device *dev,
> +               struct device_attribute *attr, char *buf)
> +{
> +       struct bridge_priv *cd = dev_get_drvdata(dev);
> +
> +       return sprintf(buf, "%s\n", cd->version);
> +}
> +static DEVICE_ATTR_RO(version);

Do you need this in userspace really?

> +static ssize_t design_number_show(struct device *dev,
> +               struct device_attribute *attr, char *buf)
> +{
> +       struct bridge_priv *cd = dev_get_drvdata(dev);
> +
> +       return sprintf(buf, "%d\n", cd->design_no);
> +}
> +static DEVICE_ATTR_RO(design_number);

And this?

> +static ssize_t can_power_show(struct device *dev,
> +               struct device_attribute *attr, char *buf)
> +{
> +       struct bridge_priv *cd = dev_get_drvdata(dev);
> +
> +       return sprintf(buf, "%d\n",
> +               !(readb(cd->cpld_base + CPLD_STATUS1) &
> +                                       CPLD_STATUS1_CAN_POWER));
> +}
> +static DEVICE_ATTR_RO(can_power);

This should certainly be reflected as a fixed-voltage regulator
and not a random integer in sysfs.

> +static int bridge_probe(struct platform_device *pdev)
> +{
> +       struct bridge_priv *cd;
> +       struct device *dev = &pdev->dev;
> +       struct device_node *np = dev->of_node;
> +       int err, id;
> +       struct resource *res;
> +       u8 status1, cap;
> +
> +       cd = devm_kzalloc(dev, sizeof(*cd), GFP_KERNEL);
> +       if (!cd)
> +               return -ENOMEM;
> +       dev_set_drvdata(dev, cd);
> +       spin_lock_init(&cd->regs_lock);

This:

> +       cd->reset_gpio = of_get_named_gpio(np, "reset-gpios", 0);
> +       if (!gpio_is_valid(cd->reset_gpio)) {
> +               dev_err(dev, "reset-gpios not found\n");
> +               return -EINVAL;
> +       }
> +       devm_gpio_request(dev, cd->reset_gpio, NULL);
> +       gpio_direction_output(cd->reset_gpio, 0);

Should be:

cd->reset_gpiod = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
if (IS_ERR(cd->reset_gpiod))
    return PTR_ERR(cd->reset_gpiod);

You can turn it to input as you do in the .remove() function to let
a pull-up resistor pull it high, but isn't it better to actively just drive
it high?

Yours,
Linus Walleij
