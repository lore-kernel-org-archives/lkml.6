Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932782AbeBVOom (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 09:44:42 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:40514 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932564AbeBVOoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 09:44:39 -0500
X-Google-Smtp-Source: AH8x2241rSkudPuXZE86l7gyh6BjKT6VpNthN2VZSEavMIsBrQ8OAYdRSzfAdO2Rky3ZFG8YLDfoRC2ChVtqxExF3lY=
MIME-Version: 1.0
In-Reply-To: <CACRpkdZ4oPmc5ithggUVMd6_MStMLs59mi3yV4e+ym4UgF5H5A@mail.gmail.com>
References: <1518443713-1835-1-git-send-email-geert+renesas@glider.be>
 <1518443713-1835-4-git-send-email-geert+renesas@glider.be> <CACRpkdZ4oPmc5ithggUVMd6_MStMLs59mi3yV4e+ym4UgF5H5A@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 22 Feb 2018 15:44:37 +0100
X-Google-Sender-Auth: 0pr8Epn_jC6mKZQUoSqkaD-tCF8
Message-ID: <CAMuHMdXXvwREAZwaeb6heN296OJKOugzR9oD9_M4x6dBc7A69g@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] gpio: rcar: Use wakeup_path i.s.o. explicit clock handling
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-gpio@vger.kernel.org,
        Linux PM list <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Thu, Feb 22, 2018 at 3:23 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Feb 12, 2018 at 2:55 PM, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
>
>> Since commit ab82fa7da4dce5c7 ("gpio: rcar: Prevent module clock disable
>> when wake-up is enabled"), when a GPIO is used for wakeup, the GPIO
>> block's module clock (if exists) is manually kept running during system
>> suspend, to make sure the device stays active.
>>
>> However, this explicit clock handling is merely a workaround for a
>> failure to properly communicate wakeup information to the device core.
>>
>> Instead, set the device's power.wakeup_path field, to indicate this
>> device is part of the wakeup path.  Depending on the PM Domain's
>> active_wakeup configuration, the genpd core code will keep the device
>> enabled (and the clock running) during system suspend when needed.
>> This allows for the removal of all explicit clock handling code from the
>> driver.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> Can I apply this and only this patch to GPIO?

Yes please.

> Should it be applied for fixes, next?

No, as it depends on infrastructure (device_set_wakeup_path()) and fixes
(various "Keep wakeup sources active during system suspend") in v4.16-rc1.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
