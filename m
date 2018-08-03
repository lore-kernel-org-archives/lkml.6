Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6745AC43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1590C21708
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aLXVahqn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1590C21708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732068AbeHCCCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 22:02:50 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:54594 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730951AbeHCCCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 22:02:49 -0400
Received: by mail-it0-f65.google.com with SMTP id s7-v6so6118079itb.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 17:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=whepv9ceqpKeQSobXWBzs/Amu/cZ+5W6duyabfxJS5I=;
        b=aLXVahqnkz9QDpDLJ8AQLKE2W7L1TLpvjIga7fwNbe7sUXz9FIkH0gKb5hYCpk8WM+
         3c11zespD0cGxbg8/BfoWhGUtL7CjiHHVqu0DTMofkUG2k1v0bFYB0bQypfoZn2LvBw4
         wjtf1tZViA86DQAUim6matsVQ85/IpJ0j8LFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=whepv9ceqpKeQSobXWBzs/Amu/cZ+5W6duyabfxJS5I=;
        b=GStEv5LT4hxLMXS8aEZf+lHDBdQhTLLL0rrIj3th2++O/rxaogSrSwQjw0k9wnZ7WZ
         1y3GYhe+agK+82jC/Pt48tjUqQVdfm9yUssTpHQrzR1qyEXikVYQtbkJSCgUryI5qTms
         sTr1SYrnHlbxXXOX+mSq1+B8J0IFz9EhQ7Pb6bcwrtXzb9mfKj4+fCGEDZjrMT90a9Ce
         WRI1kJlBwIVS2i172UyEyvQc/GyMckiu3vYk4X8fPw09tkyrE/b+LBNwnMTQSDN7o0zK
         JUdqVMwmxaBPs12ik1PJTEeeTGhwwB3MwVjsuFUuwgMV3fsT4xVhAPRZX241JmVxR756
         FzBw==
X-Gm-Message-State: AOUpUlGKuei5OmXKW0uUPZSMYyY6ANQ/Qf89uiWrsG429lnd99pHv0v/
        utrVafquCh0mR8BiRwFNPQBEJpV7qK9E7IWqZNCYqg==
X-Google-Smtp-Source: AAOMgpfA7kGxe4+RmMHk6xkgilWzSkt5oVQTttrgZ/UHP7wRzP/cvXXCllKfuYqkC4nqJzVbs6vTuPyy0cQ7ub7pHNg=
X-Received: by 2002:a24:5004:: with SMTP id m4-v6mr4457189itb.38.1533254956321;
 Thu, 02 Aug 2018 17:09:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180730110406.132729-1-tmaimon77@gmail.com> <20180730110406.132729-3-tmaimon77@gmail.com>
In-Reply-To: <20180730110406.132729-3-tmaimon77@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 3 Aug 2018 02:09:04 +0200
Message-ID: <CACRpkdaXxWWQZQhap51nGcFvZeGnJ0ZK5LuwVJvkWevxvj7JUw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] pinctrl: nuvoton: add NPCM7xx pinctrl and GPIO driver
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nancy Yuen <yuenn@google.com>,
        Patrick Venture <venture@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        avifishman70@gmail.com, Joel Stanley <joel@jms.id.au>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomer,

this is starting to look really good!

Please try this with my patch and drop the new DIR_INV flag that I think
we do not need anymore after that.

Other small bits:

On Mon, Jul 30, 2018 at 1:04 PM Tomer Maimon <tmaimon77@gmail.com> wrote:

> +/* Structure for register banks */
> +struct npcm7xx_gpio {
> +       void __iomem            *base;
> +       struct gpio_chip        gc;
> +       int                     irqbase;
> +       int                     irq;
> +       void                    *priv;
> +       struct irq_chip         irq_chip;
> +       u32                     pinctrl_id;
> +       int (*direction_input)(struct gpio_chip *chip, unsigned offset);
> +       int (*direction_output)(struct gpio_chip *chip, unsigned offset,
> +                               int value);
> +       int (*request)(struct gpio_chip *chip, unsigned offset);
> +       void (*free)(struct gpio_chip *chip, unsigned offset);

Very nice! You sorted it out perfectly.

> +/* GPIO handling in the pinctrl driver */
> +static void npcm_gpio_set(struct gpio_chip *gc, void __iomem *reg,
> +                         unsigned int pinmask)
> +{
> +       unsigned long flags;
> +       unsigned long val;
> +
> +       spin_lock_irqsave(&gc->bgpio_lock, flags);
> +
> +       val = gc->read_reg(reg) | pinmask;
> +       gc->write_reg(reg, val);

I see some GPIO drivers do this but I don't think you need to use these indirect
->read_reg() and ->write_reg() accessors, it just obscures things. If
you need to
access these registers I think it's fine to just use the base and
read/write them.
But it's your pick, I will not insist. Maybe it's a matter of taste.

> +static int npcmgpio_direction_input(struct gpio_chip *chip, unsigned int offset)
> +{
> +       struct npcm7xx_gpio *bank = gpiochip_get_data(chip);
> +       int ret;
> +
> +       ret = pinctrl_gpio_direction_input(offset + chip->base);
> +       if (ret)
> +               return ret;
> +
> +       return bank->direction_input(chip, offset);
> +}

Exactly as I think it should work, sweet!

This:

> +                       pctrl->gpio_bank[id].pinctrl_id = pinspec.args[0];
> +                       pctrl->gpio_bank[id].gc.base = pinspec.args[1];
> +                       pctrl->gpio_bank[id].gc.ngpio = pinspec.args[2];
> +                       pctrl->gpio_bank[id].gc.owner = THIS_MODULE;
> +                       pctrl->gpio_bank[id].gc.label =
> +                               devm_kasprintf(pctrl->dev, GFP_KERNEL, "%pOF",

And this:

> +       for (i = 0 ; i < pctrl->bank_num ; i++) {
> +               ret = gpiochip_add_pin_range(&pctrl->gpio_bank[i].gc,
> +                                            dev_name(pctrl->dev),
> +                                            pctrl->gpio_bank[i].pinctrl_id,
> +                                            pctrl->gpio_bank[i].gc.base,
> +                                            pctrl->gpio_bank[i].gc.ngpio);
> +               if (ret < 0) {
> +                       dev_err(pctrl->dev, "Failed to add GPIO bank %u\n", i);
> +                       gpiochip_remove(&pctrl->gpio_bank[i].gc);
> +                       goto err_range;
> +               }
> +       }

Worries me a bit. This seems to be like this because you register the
GPIO before the pin controller.

Normally we would register in the other order, and the code inside
of_gpiochio_add() as part of [devm_]gpiochip_add() will parse the phandle
and add the ranges when you add the GPIO chip.

Is this impossible to solve this cleanly?

Yours,
Linus Walleij
