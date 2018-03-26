Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751964AbeCZJMa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 05:12:30 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:51830 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751083AbeCZJMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 05:12:06 -0400
X-Google-Smtp-Source: AG47ELviSHY8m4AZyMPRo8uCrRsyYocubEwzFLC/LY2yaKYz4L4IljgtQVkmw7tbMTBIXRzzCA4SRNnGq4LjNnq6bfk=
MIME-Version: 1.0
In-Reply-To: <20180312164530.215524-1-djkurtz@chromium.org>
References: <20180312164530.215524-1-djkurtz@chromium.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 26 Mar 2018 11:12:04 +0200
Message-ID: <CACRpkdaXzf=2nap2oqU0z_sTQ7XaFJGBnuk0UBE7FfNpT8mAFA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl/amd: poll InterruptEnable bits in enable_irq
To: Daniel Kurtz <djkurtz@chromium.org>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Nehal Shah <Nehal-bakulchandra.Shah@amd.com>,
        Ken Xue <Ken.Xue@amd.com>
Cc: adurbin@chromium.org,
        "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 5:45 PM, Daniel Kurtz <djkurtz@chromium.org> wrote:

> In certain cases interrupt enablement will be delayed relative to when
> the InterruptEnable bits are written.  One example of this is when
> a GPIO's "debounce" logice is first enabled.  After enabling debounce,
> there is a 900 us "warm up" period during which InterruptEnable[0]
> (bit 11) will read as 0 despite being written 1.  During this time
> InterruptSts will not be updated, nor will interrupts be delivered, even
> if the GPIO's interrupt configuration has been written to the register.
>
> To work around this delay, poll the InterruptEnable bits after setting
> them to ensure interrupts have truly been enabled in hardware before
> returning from the irq_enable handler.
>
> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>

Patch applied.

I see the AMD people were not on CC so adding them here so they can
say if there is any problem with the approach.

Daniel: maybe you should consider listing yourself as comaintainer of this
driver?

Yours,
Linus Walleij
