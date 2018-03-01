Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032843AbeCAQGw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 11:06:52 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:34695 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031777AbeCAQGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 11:06:49 -0500
X-Google-Smtp-Source: AG47ELsHNRcN2NgjpyyBe4cFntlQxDCJNLe0ZnP0M92zqMEqctNhrFtUCeb+oAef69EGQIYud+kKXCEZZDzMEsNPs2k=
MIME-Version: 1.0
In-Reply-To: <1518443713-1835-4-git-send-email-geert+renesas@glider.be>
References: <1518443713-1835-1-git-send-email-geert+renesas@glider.be> <1518443713-1835-4-git-send-email-geert+renesas@glider.be>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 1 Mar 2018 17:06:47 +0100
Message-ID: <CACRpkdbnJ7W4EPqXtMAM_z1aO5UpuKh=-CCCSQFEToca1LU2=A@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] gpio: rcar: Use wakeup_path i.s.o. explicit clock handling
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
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
> ---
> v3:

Patch applied for v4.16 fixes.

Yours,
Linus Walleij
