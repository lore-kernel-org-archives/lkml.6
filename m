Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752275AbeBUIRS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 03:17:18 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:45489 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752224AbeBUIRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 03:17:16 -0500
X-Google-Smtp-Source: AG47ELvGp9uuRcbPWlv1ba+9uWkmPhyPD+mLPWK9MINXSVxZQhk2pWA2I8/B1uMN+dH2Wo7OrbGKDY8MTzk0pEkI7HA=
MIME-Version: 1.0
In-Reply-To: <20180221081100.17662-1-maxime.ripard@bootlin.com>
References: <20180221081100.17662-1-maxime.ripard@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 21 Feb 2018 09:17:15 +0100
Message-ID: <CACRpkdYkT7TJrhyQoJr=ZK7w8+KY=_fgjrJeaZCsLHA_6WbZbg@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: Keep returning EPROBE_DEFER when we should
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Chen-Yu Tsai <wens@csie.org>, linux-gpio@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 9:11 AM, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:

> Commits c85823390215 ("gpio: of: Support SPI nonstandard GPIO properties")
> and 6a537d48461d ("gpio: of: Support regulator nonstandard GPIO
> properties") have introduced a regression in the way error codes from
> of_get_named_gpiod_flags are handled.
>
> Previously, those errors codes were returned immediately, but the two
> commits mentioned above are now overwriting the error pointer, meaning that
> whatever value has been returned will be dropped in favor of whatever the
> two new functions will return.
>
> This might not be a big deal except for EPROBE_DEFER, on which GPIOlib
> customers will depend on, and that will now be returned as an hard error
> which means that they will not probe anymore, instead of gently deferring
> their probe.
>
> Since EPROBE_DEFER basically means that we have found a valid property but
> there was no GPIO controller registered to handle it, fix this issues by
> returning it as soon as we encounter it.
>
> Fixes: c85823390215 ("gpio: of: Support SPI nonstandard GPIO properties")
> Fixes: 6a537d48461d ("gpio: of: Support regulator nonstandard GPIO properties")
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Whoops sorry for that, patch applied for fixes.

Thanks you for your help!

Yours,
Linus Walleij
