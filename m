Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967312AbeBNLDo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 06:03:44 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34723 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967224AbeBNLDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 06:03:42 -0500
X-Google-Smtp-Source: AH8x224Z/ey+gwA1RPd0KxfDgMrNVzzMYgd/FDn4+BsX+GZNzSMYhkiOomNDl6MrUYHZ3x8lVK+Ypp6RE+zVavHIrDQ=
MIME-Version: 1.0
In-Reply-To: <1518515162-23663-3-git-send-email-jacopo+renesas@jmondi.org>
References: <1518515162-23663-1-git-send-email-jacopo+renesas@jmondi.org> <1518515162-23663-3-git-send-email-jacopo+renesas@jmondi.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 14 Feb 2018 12:03:40 +0100
X-Google-Sender-Auth: fhEDGeGyk8WWFbHbShjJNZii2Qs
Message-ID: <CAMuHMdWzNky5zEPGBvgQi58NaxxptGfeybe5OF2w1V+S7SACmw@mail.gmail.com>
Subject: Re: [PATCH 02/15] clk: renesas: cpg-msr: Add support for R-Car M3-N
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

On Tue, Feb 13, 2018 at 10:45 AM, Jacopo Mondi
<jacopo+renesas@jmondi.org> wrote:
> Initial support for R-Car M3-N (r8a77965), including core and module
> clocks.
>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Thanks for your patch!

Please refer to Table 8.2d of R-Car Series, 3rd Generation User's Manual:
Hardware (Rev. 0.80, Oct 31, 2017), so we know which exact version of
the datasheet
was used for the core clock definitions.

> --- /dev/null
> +++ b/drivers/clk/renesas/r8a77965-cpg-mssr.c
> @@ -0,0 +1,333 @@

> +static const struct mssr_mod_clk r8a77965_mod_clks[] __initconst = {
> +       DEF_MOD("scif5",                202,    R8A77965_CLK_S3D4),
> +       DEF_MOD("scif4",                203,    R8A77965_CLK_S3D4),
> +       DEF_MOD("scif3",                204,    R8A77965_CLK_S3D4),
> +       DEF_MOD("scif1",                206,    R8A77965_CLK_S3D4),
> +       DEF_MOD("scif0",                207,    R8A77965_CLK_S3D4),
> +       DEF_MOD("sys-dmac2",            217,    R8A77965_CLK_S0D3),
> +       DEF_MOD("sys-dmac1",            218,    R8A77965_CLK_S0D3),
> +       DEF_MOD("sys-dmac0",            219,    R8A77965_CLK_S0D3),
> +
> +       DEF_MOD("cmt3",                 300,    R8A77965_CLK_R),
> +       DEF_MOD("cmt2",                 301,    R8A77965_CLK_R),
> +       DEF_MOD("cmt1",                 302,    R8A77965_CLK_R),
> +       DEF_MOD("cmt0",                 303,    R8A77965_CLK_R),
> +       DEF_MOD("scif2",                310,    R8A77965_CLK_S3D4),
> +       DEF_MOD("sdif3",                311,    R8A77965_CLK_SD3),
> +       DEF_MOD("sdif2",                312,    R8A77965_CLK_SD2),
> +       DEF_MOD("sdif1",                313,    R8A77965_CLK_SD1),
> +       DEF_MOD("sdif0",                314,    R8A77965_CLK_SD0),
> +       DEF_MOD("pcie1",                318,    R8A77965_CLK_S3D1),
> +       DEF_MOD("pcie0",                319,    R8A77965_CLK_S3D1),
> +       DEF_MOD("usb3-if0",             328,    R8A77965_CLK_S3D1),
> +       DEF_MOD("usb-dmac0",            330,    R8A77965_CLK_S3D1),
> +       DEF_MOD("usb-dmac1",            331,    R8A77965_CLK_S3D1),
> +
> +       DEF_MOD("rwdt",                 402,    R8A77965_CLK_R),
> +       DEF_MOD("intc-ex",              407,    R8A77965_CLK_CP),
> +       DEF_MOD("intc-ap",              408,    R8A77965_CLK_S3D1),

According to Figure 12A.1 the parent clock is S0D3. See also commit
6e7ddf89d67c2b0c ("clk: renesas: r8a7796: Correct parent clock of INTC-AP").

> +static int __init r8a77965_cpg_mssr_init(struct device *dev)
> +{

[...]

> +
> +       return rcar_gen3_cpg_init(cpg_pll_config, CLK_EXTALR, cpg_mode);
> +};

Stray semicolon.

With the above fixed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
