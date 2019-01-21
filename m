Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB20CC2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7860820861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FjxGsCqC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730117AbfAUOUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:20:31 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39880 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729693AbfAUOU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:20:28 -0500
Received: by mail-lj1-f196.google.com with SMTP id t9-v6so17673249ljh.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 06:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=blI7pVrta7bFFRIe7g2xgLRIywYAbEGyThO1GFaydko=;
        b=FjxGsCqCHHvBaJz6FvVpHzw6NHQPVW+GaCV+nyQy9IG3DEYqqw7NYd2pw0YWhTs2qa
         U2EPsTBj4LYjUWUEHQfmAdfCUP8nPYcsrYZ8L9hNHYNgTR4B/yvDXJVmWFfP+ZqGcnFi
         J6O7/tkgc2eQBcgdsuZwAH+F9O6Vvx6rkTNwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=blI7pVrta7bFFRIe7g2xgLRIywYAbEGyThO1GFaydko=;
        b=ajtFMehqmKsdBBGN15NLX7MJivwS7aekJx3U6pkMmxBtZT2h8tk3WGw9FLuAgfSS71
         vNc/IV2LbAUnU+i7lqBo7mgce0tmHsLj5/GKq5ReuOOXEobCIndPegKOHR3Eq2cVq0Ty
         dZHmkvqF902MCHJSSC3JMlq2Y9Y4SosaHFu719yutyggZQ2ZXHC6g6o10cwy65csF3Ul
         f9GOwrZa0/xwHtqLrnIZpHDFKpF2Ge8HBvq1k7CXW8DP7yncSY7yhXLIHo3zfIjcDBh7
         JynaHwsJPojs6CJZTUg9LnuBS0AQugsaRQpoNEAlVdU0ktDsQjSuGiWj53IAdsMtQCcC
         rD4g==
X-Gm-Message-State: AJcUukf3UyMagIFyfAOYaeJUdKeJCIa9yJ6q/KCLrGvVgZnPEruN7wHr
        KGgEGdXZafgg+a8RJHhUVLKin2/TfOE6GzybQ6vXJg==
X-Google-Smtp-Source: ALg8bN7hXaV7mMi9RBuAs8Jp9wJfA0lQDxh5r+cpQV2bK5p2Fdm06EcfrLu8hHJ5/GRZXTUQwIQ4WH1ar9S4FIpv+BM=
X-Received: by 2002:a2e:9107:: with SMTP id m7-v6mr17901121ljg.23.1548080426506;
 Mon, 21 Jan 2019 06:20:26 -0800 (PST)
MIME-Version: 1.0
References: <20190118134244.22253-1-brgl@bgdev.pl> <20190118134244.22253-11-brgl@bgdev.pl>
In-Reply-To: <20190118134244.22253-11-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 21 Jan 2019 15:20:13 +0100
Message-ID: <CACRpkdZhy7yBZrGLxhRGaac7v5jZhgUSz9gZAhFXbevJbKjpZw@mail.gmail.com>
Subject: Re: [PATCH 10/13] gpio: max77650: add GPIO support
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Brian Masney <masneyb@onstation.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartosz,

thanks for the patch!

On Fri, Jan 18, 2019 at 2:43 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Add GPIO support for max77650 mfd device. This PMIC exposes a single
> GPIO line.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Overall you know for sure what you're doing so not much to
say about the GPIO chip etc. The .set_config() is nice and
helpful (maybe you will be able to also add pull up/down
using Thomas Petazzoni's new config interfaces!)

However enlighten me on this:

> +static int max77650_gpio_to_irq(struct gpio_chip *gc, unsigned int offset)
> +{
> +       struct max77650_gpio_chip *chip = gpiochip_get_data(gc);
> +
> +       return regmap_irq_get_virq(chip->irq_chip_data, MAX77650_INT_GPI);
> +}

I know this may be opening the gates to a lot of coding, but
isn't this IRQ hierarchical? I.e. that irqchip is not in the
node of the GPIO chip but in the node of the MFD top
device, with a 1:1 mapping between some of the IRQs
and a certain GPIO line.

Using regmap IRQ makes it confusing for me so I do not
know for sure if that is the case.

I am worried that you are recreating a problem (present in many
drivers, including some written by me, mea culpa) that Brian Masney
has been trying to solve for the gpiochip inside the SPMI
GPIO (drivers/pinctrl/qcom/pinctrl-spmi-gpio.c).

I have queued Brians refactoring and solution here:
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git/log/?h=ib-qcom-spmi

And the overall description on what he's trying to achieve is
here:
https://marc.info/?l=linux-gpio&m=154793071511130&w=2

My problem description (which I fear will apply also to this
driver):
https://www.spinics.net/lists/linux-gpio/msg34655.html

I plan to merge Brians patches soon-ish to devel and then from
there try to construct more helpers in the gpiolib core,
and if possible fix some of the old drivers who rely on
.to_irq().

We will certainly fix ssbi-gpio as well, and that is a good start
since the Qualdcomm platforms are so pervasive in the
market.

But maybe this doesn't apply here? I am not the smartest...
Just want to make sure that it is possible to refer an
interrupt directly to this DT node, as it is indeed marked
as interrupt-controller.

Yours,
Linus Walleij
