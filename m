Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030939AbeBNOmG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 09:42:06 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:38835 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030772AbeBNOmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 09:42:04 -0500
X-Google-Smtp-Source: AH8x226D/c9SZCuUjoF+VG5ctiqJzhRJPpTbGt6AcKB44succh5HiIYW2h35iusMqIRseULznIbgL7SXrJZjfXY892U=
MIME-Version: 1.0
In-Reply-To: <1518515162-23663-10-git-send-email-jacopo+renesas@jmondi.org>
References: <1518515162-23663-1-git-send-email-jacopo+renesas@jmondi.org> <1518515162-23663-10-git-send-email-jacopo+renesas@jmondi.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 14 Feb 2018 15:42:02 +0100
X-Google-Sender-Auth: kOG02VGI3qjgmd9OV9CPWmtC55w
Message-ID: <CAMuHMdV0ej+77MLt-5tz=0MzYz5rC499hbR5jMS6w9kLX46gWQ@mail.gmail.com>
Subject: Re: [PATCH 09/15] pinctrl: sh-pfc: r8a77965: Add SCIFs groups/functions
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
> Add SCIF[0-5] groups and pin function definitions for R-Car M3-N.
>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Minor nit below...

> --- a/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
> @@ -1577,10 +1577,306 @@ static const struct sh_pfc_pin pinmux_pins[] = {
>         SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('T'), 30, ASEBRK, CFG_FLAGS),
>  };
>
> +/* - SCIF0 ------------------------------------------------------------------ */
> +static const unsigned int scif0_data_pins[] = {
> +       /* RX, TX */
> +       RCAR_GP_PIN(5, 1), RCAR_GP_PIN(5, 2),
> +};
> +static const unsigned int scif0_data_mux[] = {
> +       RX0_MARK, TX0_MARK,
> +};
> +static const unsigned int scif0_clk_pins[] = {
> +       /* SCK */
> +       RCAR_GP_PIN(5, 0),
> +};
> +static const unsigned int scif0_clk_mux[] = {
> +       SCK0_MARK,
> +};
> +static const unsigned int scif0_ctrl_pins[] = {
> +       /* RTS, CTS */
> +       RCAR_GP_PIN(5, 4), RCAR_GP_PIN(5, 3),
> +};
> +static const unsigned int scif0_ctrl_mux[] = {
> +       RTS0_N_TANS_MARK, CTS0_N_MARK,

Without TANS please (cfr. recent fixes to pfc-r8a7796.c).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
