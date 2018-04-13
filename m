Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752223AbeDMIUY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 04:20:24 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:40164 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750940AbeDMIUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 04:20:21 -0400
X-Google-Smtp-Source: AIpwx49nkDLY1SOICoteQ7tEYAiVEF7ftCAP592EYIgAs59PRXfgsFXGt/PTF2EDBv9ITfEeklGFxef/ncpNRz99d2g=
MIME-Version: 1.0
In-Reply-To: <1523606900-2332-3-git-send-email-phil.edworthy@renesas.com>
References: <1523606900-2332-1-git-send-email-phil.edworthy@renesas.com> <1523606900-2332-3-git-send-email-phil.edworthy@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 13 Apr 2018 10:20:19 +0200
X-Google-Sender-Auth: iQKuQ_-L0hCTz3VCimfPrOZse5s
Message-ID: <CAMuHMdVKi=dDvn29U-S26PtAc_Um_+1Oy=PzKAgYUSU9qvcF-Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mfd: intel_quark_i2c_gpio: Update Synopsys GPIO interrupts
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Hoan Tran <hotran@apm.com>, Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phil,

On Fri, Apr 13, 2018 at 10:08 AM, Phil Edworthy
<phil.edworthy@renesas.com> wrote:
> Since the way the Synopsys GPIO interrupts are stored has changed, this
> driver needs to be updated in line with the changes.
>
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---
> v2:
>  - New patch in v2 to fix the only other user of struct dwapb_port_property.

Thanks for your patch!

To avoid bisection compile failures due to the changed type of
dwapb_port_property.irq,
I think this should be folded into the first patch,

> ---
>  drivers/mfd/intel_quark_i2c_gpio.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mfd/intel_quark_i2c_gpio.c b/drivers/mfd/intel_quark_i2c_gpio.c
> index 90e35de..5bddb84 100644
> --- a/drivers/mfd/intel_quark_i2c_gpio.c
> +++ b/drivers/mfd/intel_quark_i2c_gpio.c
> @@ -233,7 +233,8 @@ static int intel_quark_gpio_setup(struct pci_dev *pdev, struct mfd_cell *cell)
>         pdata->properties->idx          = 0;
>         pdata->properties->ngpio        = INTEL_QUARK_MFD_NGPIO;
>         pdata->properties->gpio_base    = INTEL_QUARK_MFD_GPIO_BASE;
> -       pdata->properties->irq          = pdev->irq;
> +       pdata->properties->irq[0]       = pdev->irq;
> +       pdata->properties->has_irq      = true;
>         pdata->properties->irq_shared   = true;
>
>         cell->platform_data = pdata;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
