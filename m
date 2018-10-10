Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4965AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F07B320835
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ghYlhOgb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F07B320835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbeJJQ0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 12:26:08 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:51359 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbeJJQ0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 12:26:06 -0400
Received: by mail-it1-f196.google.com with SMTP id 74-v6so6937521itw.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 02:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s9xNZ6ajtGDeVG5ebuIZNGgHb4V6hGnPu7n24WYk+AM=;
        b=ghYlhOgbiNih2LxITJ/C4IloDpurKzd9kIxEnHyM/PIYLrkCg0RKRGtetSINh+RkkL
         r/trLYq8mCSbkq3C4S6XBDIshS+hqGaQEyZ6mvaoT1jBhCZgb4j+UGOZz4yw+yrarXrv
         aToPp+1DU9KzvvBn2nPOZmlLxdKWv6UBQ0Aio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s9xNZ6ajtGDeVG5ebuIZNGgHb4V6hGnPu7n24WYk+AM=;
        b=IMe7uAIvWu5g5OJ2AOcjy6386iJKbYjK/QxyMQWW3mOQEANHSrPvmDhKJcbm8MpOd2
         TETH8thYAKO7JNFbctd1Vo9xDZjW122aAWIDbv8D/Z8BBgQYSBdMtnu7lEdfLes2nGah
         moXYVdSPqfyy3NZoF/4UTxuqlnqXvyiJ8Edq0lpYeKfLTBLyXEp7KU2z62+UxVblDOsO
         a0dPr5y4YMGWhrOGz3uaTtytdVa++CiWjoHUnBw1AD1z9npODNeNFOno5+7nI5q3AE83
         DoGC5Q+953m+6aYg8JF8Jzm6NCm47JZBzhNZCiFVKtqLMtYHUfdyH8T1DeDqVLBEwQSa
         1uFQ==
X-Gm-Message-State: ABuFfogCV+DluNoCZ1DwY1iu5Yqr6Rk/Oh/JsmoCB37c17Rq89kfS0b0
        VPUlRky9e+te61yWExE+pgK8j3Mh0yvqZMCB7RSJrQ==
X-Google-Smtp-Source: ACcGV60xVHH2GrTyL1WOS5d6M9fVXT9BZ5WF/69o6ITz2pTba05TrdxfgQQjRgwvfP7/0iSHOyJeLRG71RSOlYznGE4=
X-Received: by 2002:a24:e0c8:: with SMTP id c191-v6mr61048ith.156.1539162292807;
 Wed, 10 Oct 2018 02:04:52 -0700 (PDT)
MIME-Version: 1.0
References: <20181008211205.2900-1-vz@mleia.com> <20181008211205.2900-7-vz@mleia.com>
In-Reply-To: <20181008211205.2900-7-vz@mleia.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 10 Oct 2018 11:04:41 +0200
Message-ID: <CACRpkdbMMnXzA_j_p=nGgT1SyECrhCNRC6wWQ-+COMEkSQdPAA@mail.gmail.com>
Subject: Re: [PATCH 6/7] pinctrl: ds90ux9xx: add TI DS90Ux9xx pinmux and GPIO
 controller driver
To:     Vladimir Zapolskiy <vz@mleia.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Vasut <marek.vasut@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-media@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir,

thanks for your patch! Some review comments:

On Mon, Oct 8, 2018 at 11:12 PM Vladimir Zapolskiy <vz@mleia.com> wrote:

> From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
>
> The change adds an MFD cell driver for managing pin functions on
> TI DS90Ux9xx de-/serializers.
>
> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>

Please mention in the commit that you are also adding a GPIO
chip driver.

> +// SPDX-License-Identifier: GPL-2.0-or-later

I prefer the simple "GPL-2.0+" here.

> +#include <linux/of_gpio.h>

You should not need this include. If you do, something is wrong.

> +#define SER_REG_PIN_CTRL               0x12
> +#define PIN_CTRL_RGB18                 BIT(2)
> +#define PIN_CTRL_I2S_DATA_ISLAND       BIT(1)
> +#define PIN_CTRL_I2S_CHANNEL_B         (BIT(0) | BIT(3))
> +
> +#define SER_REG_I2S_SURROUND           0x1A
> +#define PIN_CTRL_I2S_SURR_BIT          BIT(0)
> +
> +#define DES_REG_INDIRECT_PASS          0x16
> +
> +#define OUTPUT_HIGH                    BIT(3)
> +#define REMOTE_CONTROL                 BIT(2)
> +#define DIR_INPUT                      BIT(1)
> +#define ENABLE_GPIO                    BIT(0)
> +
> +#define GPIO_AS_INPUT                  (ENABLE_GPIO | DIR_INPUT)
> +#define GPIO_AS_OUTPUT                 ENABLE_GPIO
> +#define GPIO_OUTPUT_HIGH               (GPIO_AS_OUTPUT | OUTPUT_HIGH)
> +#define GPIO_OUTPUT_LOW                        GPIO_AS_OUTPUT
> +#define GPIO_OUTPUT_REMOTE             (GPIO_AS_OUTPUT | REMOTE_CONTROL)

These have a creepily generic look, like they hit the global GPIO
namespace without really clashing. It gets confusing when reading
the code.

Do you think you could prefix them with DS90_* or something
so it is clear that these defines belong in this driver?

> +static const struct gpio_chip ds90ux9xx_gpio_chip = {
> +       .owner                  = THIS_MODULE,
> +       .get                    = ds90ux9xx_gpio_get,
> +       .set                    = ds90ux9xx_gpio_set,
> +       .get_direction          = ds90ux9xx_gpio_get_direction,
> +       .direction_input        = ds90ux9xx_gpio_direction_input,
> +       .direction_output       = ds90ux9xx_gpio_direction_output,
> +       .base                   = -1,
> +       .can_sleep              = 1,

This is bool so set it = true;

Overall it's a very nice driver. It is pretty complex but pin control
is complex so that's a fact of life.

Yours,
Linus Walleij
