Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754166AbeBGNAq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 08:00:46 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:33605 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754162AbeBGNAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 08:00:44 -0500
X-Google-Smtp-Source: AH8x2259B0DffzqU/udzFpND47nbEnzijQfa9qrpkmpwXSWfO1naPQHtGheEssp4jXU9fAKSNGK7npRCZTK34PriSAw=
MIME-Version: 1.0
In-Reply-To: <1516576180-1467-1-git-send-email-david@lechnology.com>
References: <1516576180-1467-1-git-send-email-david@lechnology.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 7 Feb 2018 14:00:43 +0100
Message-ID: <CACRpkdaTcCo93xqDNy7ixvF=aeF1VbML+OaJY8rtcEJZswXFbA@mail.gmail.com>
Subject: Re: [PATCH] gpio: davinci: add support for pinmux gpio ranges
To: David Lechner <david@lechnology.com>
Cc: linux-gpio@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Keerthy <j-keerthy@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 22, 2018 at 12:09 AM, David Lechner <david@lechnology.com> wrote:

> This adds support for the pinmux gpio ranges feature to the DaVinci gpio
> driver. Only device tree is supported since the non-DT boards don't
> use a generic pinmux controller.
>
> Cc: Keerthy <j-keerthy@ti.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: David Lechner <david@lechnology.com>

Nice, patch applied!

> +       if (of_property_read_bool(dev->of_node, "gpio-ranges")) {
> +               chips->chip.request = gpiochip_generic_request;
> +               chips->chip.free = gpiochip_generic_free;
> +       }

If the backing pin controller can do things like debounce
or open drain pin control, consider using also the
gpiochip_generic_config() callback in the future.

Yours,
Linus Walleij
