Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C200C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA9CB2098A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ez6rui+J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA9CB2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbeIYQlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 12:41:02 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42393 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbeIYQlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 12:41:01 -0400
Received: by mail-io1-f68.google.com with SMTP id n18-v6so20035767ioa.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 03:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0MYY5OeVo0LhoXWN1gz4zbiSHN6/1aAwmokhScTIgz8=;
        b=Ez6rui+J/kLRG9/z04ZP/2yu1Pnfu4nG/tGAJ4BNk7aMSLgUo0tPu2Uc9VJyLSvfZb
         Pwb9Yfpy9wCY5mvoy+VjSNiwfgCMGb963XclCr07oF/DLYph0+o09OnuhhcxqlCCH3zu
         8ENn2Bx15XjOqhG9ztlU+wvjSxF971S4YPAXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0MYY5OeVo0LhoXWN1gz4zbiSHN6/1aAwmokhScTIgz8=;
        b=Xd0L7bGf8mbLR35eMBSIxshj72zah2jiyVHxsOVJ1+VJ4FeiGUr1lCEeLM2W6ahnpT
         Nf7AXBcJuSw9K34SgM7Zp6UAsceOGA0cnzX18FppbytS7TIte0mMomsHyuhGgBlnpK3F
         XV6VhQj0zQuo6EVxtpplirf5XlVOxkTTRWnbnvLlRMatvKylZi9UsPcl6udj3fqD2eD7
         0cu9cvfqRg/GECXqVXgmdHhRN1dwxI2KnRb+b0szVEzRxST0zHe2/upR8Lii9POFX5PX
         yGBCE5LNUfRpicBx8q0WwsMkD4zJcvp1N8erdwvT4fnEptI1TKqBmghwO6S72+QSAMaE
         V5WQ==
X-Gm-Message-State: ABuFfoil7dQi8CRtwvDw7oyF0QHumm7PXF/B6eOoCXMD8pMoIYB5y8hg
        RS0GDWvXshZdegaxVlCdCVUgwPy2WRLUdA3dJI2Cvw==
X-Google-Smtp-Source: ACcGV63MV8onEekX18ZS5+I/UFkGD390syn5K4IzG48IkL8aWJy+/tQfL0sW1gRYqlWJuqOws/5j9TyMZVrJn1kz8QY=
X-Received: by 2002:a6b:4006:: with SMTP id k6-v6mr212799ioa.277.1537871646937;
 Tue, 25 Sep 2018 03:34:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180921102546.12745-1-thierry.reding@gmail.com>
 <20180921102546.12745-7-thierry.reding@gmail.com> <CACRpkdYnrf7FknvnZyFSgfT5aCrcWT4hxSnQo0UqxYfR6Fkqwg@mail.gmail.com>
 <20180925093315.GB7097@ulmo>
In-Reply-To: <20180925093315.GB7097@ulmo>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 25 Sep 2018 12:33:54 +0200
Message-ID: <CACRpkdbOpVPB5MqgCyF5x_ENzLscz5oYEstYqwVceqeKZq2w5g@mail.gmail.com>
Subject: Re: [PATCH 6/9] gpio: Add support for hierarchical IRQ domains
To:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-tegra@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 11:33 AM Thierry Reding
<thierry.reding@gmail.com> wrote:
> On Tue, Sep 25, 2018 at 10:11:06AM +0200, Linus Walleij wrote:

> > While I think it is really important that we start supporting hierarchical
> > irqdomains in the gpiolib core, I want a more complete approach,
> > so that drivers that need hierarchical handling of irqdomains
> > can get the same support from gpiolib as they get for simple
> > domains.
(...)
> > I can't see if you need to pull more stuff into the core to accomplish
> > that, but I think in essence the core gpiolib needs to be more helpful
> > with hierarchies.
>
> This is not as trivial as it sounds. I think we could probably provide a
> simple helper in the core that may work for the majority of GPIO
> controllers, and would be similar to irq_domain_xlate_twocell(). The
> problem is that ->gpio_to_irq() effectively needs to convert the offset
> of the pin in the GPIO controller to an IRQ specifier. If the IRQ domain
> can use irq_domain_xlate_twocell(), that should be easy, but if it does
> not, then we likely need a custom implementation as well.

This sounds a lot like the "gpio-ranges" we have in the
gpiochip DT bindings, mapping gpio offsets to pin offsets.

I assume that we could just introduce a cross-mapping
array from IRQ to IRQ in struct gpio_irq_chip for the
hierarchical irqchip? Is it any
more complicated than an array of [(int, int)] tuples?

I guess this is what you have in mind for twocell?

> For example, as you may remember, the Tegra186 GPIO controller is
> somewhat quirky in that it has a number of banks, each of which can have
> any number of pins up to 8. However, in order to prevent users from
> attempting to use one of the non-existent GPIOs, we resorted to
> compacting the GPIO number space so that the GPIO specifier uses
> basically a (bank, pin) pair that is converted into a GPIO offset. The
> same is done for interrupt specifiers.

I guess this stuff is what you refer to?

#define TEGRA_MAIN_GPIO_PORT(port, base, count, controller)     \
        [TEGRA_MAIN_GPIO_PORT_##port] = {                       \
                .name = #port,                                  \
                .offset = base,                                 \
                .pins = count,                                  \
                .irq = controller,                              \
        }

static const struct tegra_gpio_port tegra186_main_ports[] = {
        TEGRA_MAIN_GPIO_PORT( A, 0x2000, 7, 2),
        TEGRA_MAIN_GPIO_PORT( B, 0x3000, 7, 3),
        TEGRA_MAIN_GPIO_PORT( C, 0x3200, 7, 3),
        TEGRA_MAIN_GPIO_PORT( D, 0x3400, 6, 3),
(...)

Maybe things have changed slightly.

As I see it there are some ways to go about this:

1. Create one gpiochip per bank and just register the number of
GPIOs actually accessible per bank offset from 0. This works
if one does not insist on having one gpiochip covering all pins,
and as long as all usable pins are stacked from offset 0..n.
(Tegra186 doesn't do this, it is registering one chip for all.)

2. If the above cannot be met, register enough pins to cover all
(e.g. 32 pins for a 32bit GPIO register) then mask off the
unused pins in .valid_mask in the gpio_chip. This was fairly
recently introduced to add ACPI support for Qualcomm, as
there were valid, but unusable GPIO offsets, but it can be
used to cut arbitrary holes in any range of offsets.

3. Some driver-specific way. Which seems to be what Tegra186
is doing.

Would you consider to move over to using method (2) to
get a more linear numberspace? I.e. register 8 GPIOs/IRQs
per port/bank and then just mask off the invalid ones?
.valid_mask in gpio_chip can be used for the GPIOs and
.valid_mask in the gpio_irq_chip can be used for IRQs.

Or do you think it is nonelegant?

> Since there is no 1:1 relationship between the value in the specifier
> and the GPIO offset, we can't use irq_domain_xlate_twocell().

Am I right that if you switch to method (2) above this is solved
and we get rid of the custom tegra186 xlate function == big win?

> I think we can probably just implement the simple two-cell version in
> gpiochip_to_irq() directly and leave it up to drivers that require
> something more to override ->to_irq().

And if what I assume (in my naive thinking) you can do with
.valid_mask is correct, then you can convert tegra186 to use
common twocell translation.

Sorry for being a pest, I just have a feeling we are reinventing
wheels here, I really want to pull as many fringe cases as
possible into gpiolib if I can so the maintenance gets
simpler.

Yours,
Linus Walleij
