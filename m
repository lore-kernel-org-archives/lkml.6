Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55D4C31680
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5B322089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="y7u2sbbh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbfAURHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 12:07:36 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:36155 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbfAURHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 12:07:36 -0500
Received: by mail-io1-f68.google.com with SMTP id m19so16934594ioh.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 09:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+qKNF4SDqZ8Cmkl7t5eoGqwDzAnyKArVQHpPC0Jdyo0=;
        b=y7u2sbbh627XtRHa4a95FZUweoxWDtAwUfzzvgTr8I4CsFawe1fpSh1XfLAMoCbYSN
         XAtxLE4XiZ0A+E8DHyUhtPHKNgt3lnTIb1huUeoe6id2oujRNrEM4KvCjvAV2BGRg7Sp
         tr6Tn3Q/jVo0/iFNRJAZ9a4DWfPPUBxrSgfOX6Cy7vfZILX+f4axuTXQ1yirIPBQkcfc
         7UZRjTY/VsXATTEle3wLcNQlp9Bzq6znT8aBoiYgOf6KYOd98ARrfKwYDsPNMQUm/pEm
         PVqUmtSJUXL4sCYLyfIXP0AjhM57+6c7Cj/VfrgUD1Ji6qJRBlwwDQ+++o+D+5k41pSb
         2M0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+qKNF4SDqZ8Cmkl7t5eoGqwDzAnyKArVQHpPC0Jdyo0=;
        b=X1cfB+i9jcprZtJP60giD9J0HqHoX3Yl9KGg4oIR9a6ny6MUQOdtzgIcNYy38idiaM
         VlyCFVZKMGGeMrxPt7C76bH0Ecms3nJaTecavM5p30ixDrbpRQycanc7i6oC87rY1DYd
         BkcfM9WwyXTy4HXDAQg/9aHyGWUqWMAQ4zQ4+xFrlcEq4CDPZpD5zCzeyk3Zltc1luf/
         6O/L+qeMTHYPzVpPkGRbNXStmTetFCaxq843EW2geYiKMwg36z/pUsRlpMPiV2GlwoFC
         t6iW0xdLNIdfY3XJqDu0cUqiR2he+jax9TycZNCHL/8mYC4rabqwEcaBfe8AdIUX4T/4
         /iuw==
X-Gm-Message-State: AJcUukdhUp1cfsb1VgIZDfYU5y3BEFROYt7UxWHlacMVr+OXcVTe8gzi
        B839Gqs7gwMsUeWuvx+NYCmciFgFrhGL9+jxFvssKQ==
X-Google-Smtp-Source: ALg8bN7n1FiRfZ5PWSLID8T547uVNIjmOYyGJzgjnnPwVr/Zi2UuuPkCRGVyt4NZL3ZN9nGtjw/2FYwD8LoIG/CBk98=
X-Received: by 2002:a5d:834e:: with SMTP id q14mr16186660ior.258.1548090455062;
 Mon, 21 Jan 2019 09:07:35 -0800 (PST)
MIME-Version: 1.0
References: <20190118134244.22253-1-brgl@bgdev.pl> <20190118134244.22253-11-brgl@bgdev.pl>
 <CACRpkdZhy7yBZrGLxhRGaac7v5jZhgUSz9gZAhFXbevJbKjpZw@mail.gmail.com>
In-Reply-To: <CACRpkdZhy7yBZrGLxhRGaac7v5jZhgUSz9gZAhFXbevJbKjpZw@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 21 Jan 2019 18:07:24 +0100
Message-ID: <CAMRc=Me6OSKDk7bN4++M68DjoeArd+gZx16o0oQBXfRoCWBt2A@mail.gmail.com>
Subject: Re: [PATCH 10/13] gpio: max77650: add GPIO support
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Brian Masney <masneyb@onstation.org>,
        Rob Herring <robh+dt@kernel.org>,
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 21 sty 2019 o 15:20 Linus Walleij <linus.walleij@linaro.org> napisa=
=C5=82(a):
>
> Hi Bartosz,
>
> thanks for the patch!
>
> On Fri, Jan 18, 2019 at 2:43 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote=
:
>
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Add GPIO support for max77650 mfd device. This PMIC exposes a single
> > GPIO line.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Overall you know for sure what you're doing so not much to
> say about the GPIO chip etc. The .set_config() is nice and
> helpful (maybe you will be able to also add pull up/down
> using Thomas Petazzoni's new config interfaces!)
>
> However enlighten me on this:
>
> > +static int max77650_gpio_to_irq(struct gpio_chip *gc, unsigned int off=
set)
> > +{
> > +       struct max77650_gpio_chip *chip =3D gpiochip_get_data(gc);
> > +
> > +       return regmap_irq_get_virq(chip->irq_chip_data, MAX77650_INT_GP=
I);
> > +}
>
> I know this may be opening the gates to a lot of coding, but
> isn't this IRQ hierarchical? I.e. that irqchip is not in the
> node of the GPIO chip but in the node of the MFD top
> device, with a 1:1 mapping between some of the IRQs
> and a certain GPIO line.
>
> Using regmap IRQ makes it confusing for me so I do not
> know for sure if that is the case.
>
> I am worried that you are recreating a problem (present in many
> drivers, including some written by me, mea culpa) that Brian Masney
> has been trying to solve for the gpiochip inside the SPMI
> GPIO (drivers/pinctrl/qcom/pinctrl-spmi-gpio.c).
>
> I have queued Brians refactoring and solution here:
> https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git/log=
/?h=3Dib-qcom-spmi
>
> And the overall description on what he's trying to achieve is
> here:
> https://marc.info/?l=3Dlinux-gpio&m=3D154793071511130&w=3D2
>
> My problem description (which I fear will apply also to this
> driver):
> https://www.spinics.net/lists/linux-gpio/msg34655.html
>
> I plan to merge Brians patches soon-ish to devel and then from
> there try to construct more helpers in the gpiolib core,
> and if possible fix some of the old drivers who rely on
> .to_irq().
>
> We will certainly fix ssbi-gpio as well, and that is a good start
> since the Qualdcomm platforms are so pervasive in the
> market.
>
> But maybe this doesn't apply here? I am not the smartest...
> Just want to make sure that it is possible to refer an
> interrupt directly to this DT node, as it is indeed marked
> as interrupt-controller.
>

Hi Linus,

Thank you for your review. While I think you're right about the issue
being present in this driver, I'm not sure it's really a problem. Do
we actually require every gpio-controller to also be a stand-alone
interrupt-controller? The binding document for the GPIO module doesn't
mention this - it only requires the gpio-controller property. Without
the "interrupt-controller" property dtc will bail-out if anyone uses
this node as the interrupt parent.

If I'm wrong and we do require it, then I think we need to update
Documentation/devicetree/bindings/gpio/gpio.txt.

Best regards,
Bartosz Golaszewski

PS: FYI since this submission I dropped the virtual irq number lookup
in sub-drivers in favor of resources setup by the parent driver[1] as
suggested by Dmitry in his review of the input module driver.

[1] https://github.com/brgl/linux/blob/topic/max77650_mfd_driver/drivers/gp=
io/gpio-max77650.c#L158
