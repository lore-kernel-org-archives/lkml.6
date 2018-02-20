Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751914AbeBTNfk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 08:35:40 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:52601 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751704AbeBTNfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 08:35:38 -0500
Date: Tue, 20 Feb 2018 14:35:32 +0100
From: jacopo mondi <jacopo@jmondi.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 11/15] gpio: rcar: Add R-Car M3-N compatible string
Message-ID: <20180220133532.GE7203@w540>
References: <1518515162-23663-1-git-send-email-jacopo+renesas@jmondi.org>
 <1518515162-23663-12-git-send-email-jacopo+renesas@jmondi.org>
 <CAMuHMdXW-7+6_iSPk3oUo-fWsMxqvSawuy2QZ3VTYhoeN8kB4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMuHMdXW-7+6_iSPk3oUo-fWsMxqvSawuy2QZ3VTYhoeN8kB4w@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Wed, Feb 14, 2018 at 03:05:05PM +0100, Geert Uytterhoeven wrote:
> On Tue, Feb 13, 2018 at 10:45 AM, Jacopo Mondi
> <jacopo+renesas@jmondi.org> wrote:
> > Add compatible string for R-Car M3-N (r8a77965) in gpio-rcar.
> >
> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
>
> > --- a/drivers/gpio/gpio-rcar.c
> > +++ b/drivers/gpio/gpio-rcar.c
> > @@ -360,6 +360,10 @@ static const struct of_device_id gpio_rcar_of_table[] = {
> >                 /* Gen3 GPIO is identical to Gen2. */
> >                 .data = &gpio_rcar_info_gen2,
> >         }, {
> > +               .compatible = "renesas,gpio-r8a77965",
> > +               /* Gen3 GPIO is identical to Gen2. */
> > +               .data = &gpio_rcar_info_gen2,
> > +       }, {
>
> This part is not needed, as the driver already matches agains the generic
> "renesas,rcar-gen3-gpio".

Just to point out that the compatible string is there for M3-W and H3.
Anyway, if that's not good practice to add per-SoC strings here, I'll
drop this bit.

Thanks
   j

>
> >                 .compatible = "renesas,rcar-gen1-gpio",
> >                 .data = &gpio_rcar_info_gen1,
> >         }, {
>
> With the above fixed:
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
