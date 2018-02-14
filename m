Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030660AbeBNOFI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 09:05:08 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:41801 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030450AbeBNOFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 09:05:06 -0500
X-Google-Smtp-Source: AH8x226ztn8QuglBApiXl/W7bnNITJp7uUjLSn9EHjR/tLKbAoJ3h312Oc/AL77m4fG8BVy79EfbG84pFs0nRiO0rBQ=
MIME-Version: 1.0
In-Reply-To: <1518515162-23663-12-git-send-email-jacopo+renesas@jmondi.org>
References: <1518515162-23663-1-git-send-email-jacopo+renesas@jmondi.org> <1518515162-23663-12-git-send-email-jacopo+renesas@jmondi.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 14 Feb 2018 15:05:05 +0100
X-Google-Sender-Auth: pjlkAy8zVZATDSNG9K2IUuB-cqI
Message-ID: <CAMuHMdXW-7+6_iSPk3oUo-fWsMxqvSawuy2QZ3VTYhoeN8kB4w@mail.gmail.com>
Subject: Re: [PATCH 11/15] gpio: rcar: Add R-Car M3-N compatible string
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 10:45 AM, Jacopo Mondi
<jacopo+renesas@jmondi.org> wrote:
> Add compatible string for R-Car M3-N (r8a77965) in gpio-rcar.
>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

> --- a/drivers/gpio/gpio-rcar.c
> +++ b/drivers/gpio/gpio-rcar.c
> @@ -360,6 +360,10 @@ static const struct of_device_id gpio_rcar_of_table[] = {
>                 /* Gen3 GPIO is identical to Gen2. */
>                 .data = &gpio_rcar_info_gen2,
>         }, {
> +               .compatible = "renesas,gpio-r8a77965",
> +               /* Gen3 GPIO is identical to Gen2. */
> +               .data = &gpio_rcar_info_gen2,
> +       }, {

This part is not needed, as the driver already matches agains the generic
"renesas,rcar-gen3-gpio".

>                 .compatible = "renesas,rcar-gen1-gpio",
>                 .data = &gpio_rcar_info_gen1,
>         }, {

With the above fixed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
