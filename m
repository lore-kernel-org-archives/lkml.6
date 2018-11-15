Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D781C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D212E21780
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QslEfbp7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D212E21780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388015AbeKOUDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 15:03:44 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38807 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728719AbeKOUDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 15:03:44 -0500
Received: by mail-lj1-f196.google.com with SMTP id c19-v6so3952234lja.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 01:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x331bA8a2GWD5VrL19MROXhlhKzu5Fl6vQm27yOzBDQ=;
        b=QslEfbp7sxaEnE+AEkyEPT3EvJ0QpG9+AlRrDK16jWweCtZOckMpYkEQptnuk/drgI
         EhYK0e0PeFBP7qP3bxC7UW81l+lGdNZ0YJ8RC08zui886U556NWoPnsdu6IUQcnU224C
         YGwko6ZkRag7W2v5dy2eJtzq5RB6gQuzUIyPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x331bA8a2GWD5VrL19MROXhlhKzu5Fl6vQm27yOzBDQ=;
        b=FMfLRryp5RlIQUrTdwZbMq9hajpzEPNOstZjFimBjKV3hKcaWhO/paEyr7lqzsS19Z
         zwQjJa/+tYmR+8vuwbPuZoPKskI+C3xGwryWK1otYJGY4cMPS0lWae5uRRBISqDwylpt
         59qYZ/M2pUcSoIeGsq+YY9dB2111I+xbnPhggLe3eSDOH7QV862X1xrgYTGtRtOtWE4H
         ERKsFnTrn+K2JcBzAhVK8v73YDpQO0hRAzxfaaVMg5Uv1WiSHJyxAYvksfzAfE6v6b80
         PiM1Li6UxbcPsJD6MTP5sQPTLng8/9z4Nln9Yt/TzHoZRyOihRDjP7xgrGSzZmEic8Ui
         H8zQ==
X-Gm-Message-State: AGRZ1gJehWlcNUzhA8Ivd0yiK5dstEL1khxhz1sx1xrTN40xW3kxluCM
        LBzsT6aOjpbGEPJZLGZVLyxm8eMvAKNo5xaqQcAHhg==
X-Google-Smtp-Source: AJdET5d63DrKUU6wYvpz/u/vdYcIN8f2sugqG2Yh2sD/3BYKkdXTjCnQPOuRW5CLQWEe1263aFZy7ne1DoPnncPde0E=
X-Received: by 2002:a2e:9849:: with SMTP id e9-v6mr2455145ljj.9.1542275794527;
 Thu, 15 Nov 2018 01:56:34 -0800 (PST)
MIME-Version: 1.0
References: <1541603580-17448-1-git-send-email-andrei.stefanescu@microchip.com>
 <1541603580-17448-4-git-send-email-andrei.stefanescu@microchip.com>
In-Reply-To: <1541603580-17448-4-git-send-email-andrei.stefanescu@microchip.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 15 Nov 2018 10:56:22 +0100
Message-ID: <CACRpkda6NLv_HrzygJ5J082jrWwVH3Ljt-5bqJv1kvoax5wWWA@mail.gmail.com>
Subject: Re: [PATCH 3/3] gpio: add driver for sama5d2 PIOBU pins
To:     Andrei.Stefanescu@microchip.com
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Nicolas Ferre <Nicolas.Ferre@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ludovic Desroches <Ludovic.Desroches@microchip.com>,
        Cristian.Birsan@microchip.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrei,

thanks for your patch!

On Wed, Nov 7, 2018 at 4:12 PM <Andrei.Stefanescu@microchip.com> wrote:

> PIOBU pins do not lose their voltage during Backup/Self-refresh.
> This patch adds a simple GPIO controller for them.
>
> This driver adds support for using the pins as GPIO
> offering the possibility to read/set the voltage.
>
> Signed-off-by: Andrei Stefanescu <andrei.stefanescu@microchip.com>

(...)
> +config GPIO_SAMA5D2_PIOBU
> +       tristate "SAMA5D2 PIOBU GPIO support"
> +       depends on GPIO_SYSCON

Should it not be:
depends on MFD_SYSCON
select GPIO_SYSCON

> +#include <linux/gpio.h>

Drivers should only
#include <linux/gpio/driver.h>

Also add:
#include <linux/bits.h>
because you use BIT() macros.

> +#define PIOBU_NUM 8
> +#define PIOBU_REG_SIZE 4

Isnt register size 4 implied by syscon, I think it is hardwired
to 32 bits.

> +/*
> + * sama5d2_piobu_setup_pin - prepares a pin for sama5d2_piobu_set_direction call
> + *
> + * Do not consider pin for intrusion detection (normal and backup modes)
> + * Do not consider pin as intrusion wakeup interrupt source

Intrusion ... sounds like some burglar alarm :D

> +/*
> + * sama5d2_piobu_get_direction - gpiochip get_direction
> + */

Check all your kerneldoc comments please,

/**
 * this_is_a_function() - This is a function
 */

See
Documentation/doc-guide/kernel-doc.rst

> +static int sama5d2_piobu_get_direction(struct gpio_chip *chip,
> +                                      unsigned int pin)
> +{
> +       int ret = sama5d2_piobu_read_value(chip, pin, PIOBU_DIRECTION);
> +
> +       if (ret < 0)
> +               return ret;
> +
> +       return (ret == PIOBU_IN) ? GPIOF_DIR_IN : GPIOF_DIR_OUT;

Please do not use these flags in drivers: they are for consumers.
Just return 0/1.

> +static int sama5d2_piobu_get(struct gpio_chip *chip, unsigned int pin)
> +{
> +       /* if pin is input, read value from PDS else read from SOD */
> +       int ret = sama5d2_piobu_get_direction(chip, pin);
> +
> +       if (ret == GPIOF_DIR_IN)
> +               ret = sama5d2_piobu_read_value(chip, pin, PIOBU_PDS);
> +       else if (ret == GPIOF_DIR_OUT)
> +               ret = sama5d2_piobu_read_value(chip, pin, PIOBU_SOD);

Dito.

> +static void sama5d2_piobu_set(struct gpio_chip *chip, unsigned int pin,
> +                             int value)
> +{
> +       value = (value == 0) ? PIOBU_LOW : PIOBU_HIGH;

That looks unorthodox. Just use an if() statement.

> +const struct gpio_chip sama5d2_piobu_template_chip = {
> +       .owner = THIS_MODULE,
> +       .get_direction = sama5d2_piobu_get_direction,
> +       .direction_input = sama5d2_piobu_direction_input,
> +       .direction_output = sama5d2_piobu_direction_output,
> +       .get = sama5d2_piobu_get,
> +       .set = sama5d2_piobu_set,
> +       .base = -1,
> +       .ngpio = PIOBU_NUM,
> +       .can_sleep = 0,
(...)
> +       piobu->chip = sama5d2_piobu_template_chip;
> +       piobu->chip.label = pdev->name;
> +       piobu->chip.parent = &pdev->dev;
> +       piobu->chip.of_node = pdev->dev.of_node;

This is just overcomplicating things. Instead of assigning the template
just assign all function here in the probe() code, get rid of the
templaye. It's easier to follow.

> +       piobu->regmap =
> +               syscon_regmap_lookup_by_compatible("microchip,sama5d2-piobu");

So maybe just put this inside your syscon node and use:
syscon_node_to_regmap(pdev->dev.parent->of_node);

I might have more comments on the next version, but keep at it!

Yours,
Linus Walleij
