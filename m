Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754677AbeCVMal (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 08:30:41 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:33675 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754659AbeCVMaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 08:30:39 -0400
X-Google-Smtp-Source: AG47ELtaXUscbQGsNjha1crR0IXf6ZrCCxufKTvdV7pK275YXFT6AYXp+BMlT41bNpv+Q7Y1TOrVSR0kLHszXW26alw=
MIME-Version: 1.0
In-Reply-To: <1521719091-25157-3-git-send-email-michel.pollet@bp.renesas.com>
References: <1521719091-25157-1-git-send-email-michel.pollet@bp.renesas.com> <1521719091-25157-3-git-send-email-michel.pollet@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 22 Mar 2018 13:30:37 +0100
X-Google-Sender-Auth: 73h0CIJq5QSYo_bNEy_3b97lBlc
Message-ID: <CAMuHMdUzW221ppgR=BW0iiLNRr8KQbgTPoRbTKRKU8wnXavVtA@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] DT: reset: renesas,rzn1-reboot: document RZ/N1
 reboot driver
To: Michel Pollet <michel.pollet@bp.renesas.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Sebastian Reichel <sre@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michel,

On Thu, Mar 22, 2018 at 12:44 PM, Michel Pollet
<michel.pollet@bp.renesas.com> wrote:
> The Renesas RZ/N1 Family (Part #R9A06G0xx) requires a driver
> as part of the sysctrl MFD to handle rebooting the CA7 cores.
> This documents the driver bindings.
>
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/renesas,rzn1-reboot.txt
> @@ -0,0 +1,22 @@
> +DT bindings for the Renesas RZ-N1 Reboot Driver
> +
> +== Reboot Driver Node ==
> +
> +The reboot driver is always a subnode of the system controller node, see
> +renesas,rzn1-sysctrl.txt for details.
> +
> +Bindings:
> ++ Optional:
> +       compatible = "renesas,r9a06g032-reboot";
> ++ Required:
> +       compatible = "renesas,rzn1-reboot";

Please mark both the SoC-specific and the family-specific values required.

> +
> +Example:
> +       sysctrl: sysctrl@4000c000 {
> +               compatible = "renesas,r9a06g032-sysctrl", "syscon", "simple-mfd";
> +               reg = <0x4000c000 0x1000>;
> +
> +               reboot {
> +                       compatible = "renesas,r9a06g032-reboot";

"renesas,r9a06g032-reboot", "renesas,rzn1-reboot".

> +               };
> +       };

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
