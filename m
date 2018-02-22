Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932792AbeBVOXH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 09:23:07 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:40196 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932726AbeBVOXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 09:23:04 -0500
X-Google-Smtp-Source: AH8x224EVsAfXw5GMg/b0GhOJ9eZ6rqy441u2Li1U2BQsyPW77/N3+9Zl0slW1EKHhBEtK0tm9WWkMha1Tm4RO7mxV0=
MIME-Version: 1.0
In-Reply-To: <1518443713-1835-4-git-send-email-geert+renesas@glider.be>
References: <1518443713-1835-1-git-send-email-geert+renesas@glider.be> <1518443713-1835-4-git-send-email-geert+renesas@glider.be>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 22 Feb 2018 15:23:03 +0100
Message-ID: <CACRpkdZ4oPmc5ithggUVMd6_MStMLs59mi3yV4e+ym4UgF5H5A@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] gpio: rcar: Use wakeup_path i.s.o. explicit clock handling
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 2:55 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> Since commit ab82fa7da4dce5c7 ("gpio: rcar: Prevent module clock disable
> when wake-up is enabled"), when a GPIO is used for wakeup, the GPIO
> block's module clock (if exists) is manually kept running during system
> suspend, to make sure the device stays active.
>
> However, this explicit clock handling is merely a workaround for a
> failure to properly communicate wakeup information to the device core.
>
> Instead, set the device's power.wakeup_path field, to indicate this
> device is part of the wakeup path.  Depending on the PM Domain's
> active_wakeup configuration, the genpd core code will keep the device
> enabled (and the clock running) during system suspend when needed.
> This allows for the removal of all explicit clock handling code from the
> driver.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Can I apply this and only this patch to GPIO?

Should it be applied for fixes, next?

Else please funnel this through the irqchip tree with my
ACK.

Yours,
Linus Walleij
