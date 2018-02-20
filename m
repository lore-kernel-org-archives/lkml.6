Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752589AbeBTPki (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 10:40:38 -0500
Received: from mail-qt0-f181.google.com ([209.85.216.181]:36774 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752313AbeBTPkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 10:40:36 -0500
X-Google-Smtp-Source: AH8x227Qp2U9y7ffyn+Oui7nkh37X0dVBx+pA57zX2v1zrpL4OgfLsPges+6fXWRV9t2h4bdJOS7dVYMTXdfQRsAEj8=
MIME-Version: 1.0
In-Reply-To: <1519139541-18783-4-git-send-email-jacopo+renesas@jmondi.org>
References: <1519139541-18783-1-git-send-email-jacopo+renesas@jmondi.org> <1519139541-18783-4-git-send-email-jacopo+renesas@jmondi.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 20 Feb 2018 16:40:34 +0100
X-Google-Sender-Auth: EhhZiA_DRm7yn3NZYQ8zpIJEU1Y
Message-ID: <CAMuHMdVw4OSPP7XYLGuE7SfVjOk_6VK847NdsVwszBX9XshQ3A@mail.gmail.com>
Subject: Re: [PATCH v2 03/19] soc: renesas: Identify R-Car M3-N
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

Hi Jacopo,

On Tue, Feb 20, 2018 at 4:12 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> Add support for indentifying R-Car M3-N (R8A77965) SoC.
>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/soc/renesas/renesas-soc.c
> +++ b/drivers/soc/renesas/renesas-soc.c
> @@ -149,6 +149,11 @@ static const struct renesas_soc soc_rcar_v3m __initconst __maybe_unused = {
>         .id     = 0x54,
>  };
>
> +static const struct renesas_soc soc_rcar_m3_n __initconst __maybe_unused = {
> +       .family = &fam_rcar_gen3,
> +       .id     = 0x55,
> +};

Note that the list was sorted by SoC part number.

> +
>  static const struct renesas_soc soc_rcar_v3h __initconst __maybe_unused = {
>         .family = &fam_rcar_gen3,
>         .id     = 0x56,
> @@ -214,6 +219,9 @@ static const struct of_device_id renesas_socs[] __initconst = {
>  #ifdef CONFIG_ARCH_R8A7796
>         { .compatible = "renesas,r8a7796",      .data = &soc_rcar_m3_w },
>  #endif
> +#ifdef CONFIG_ARCH_R8A77965
> +       { .compatible = "renesas,r8a77965",     .data = &soc_rcar_m3_n },
> +#endif
>  #ifdef CONFIG_ARCH_R8A77970
>         { .compatible = "renesas,r8a77970",     .data = &soc_rcar_v3m },
>  #endif

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
