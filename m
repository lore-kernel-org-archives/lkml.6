Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754641AbeCVM36 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 08:29:58 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:39981 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751835AbeCVM3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 08:29:53 -0400
X-Google-Smtp-Source: AG47ELvy2cKZSNsRdrrHIVrtJl++5doU7J+6QuCv0GCtcKVF6gVYGKlg2iijo03tFCjXZ8bGNOuy7e+pbx2+MHcuy90=
MIME-Version: 1.0
In-Reply-To: <1521719091-25157-2-git-send-email-michel.pollet@bp.renesas.com>
References: <1521719091-25157-1-git-send-email-michel.pollet@bp.renesas.com> <1521719091-25157-2-git-send-email-michel.pollet@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 22 Mar 2018 13:29:52 +0100
X-Google-Sender-Auth: EOipBSr_oknWoiB6bsQkR88LvQo
Message-ID: <CAMuHMdUx7E3dk0S678HOotv3E33ZEjfoEQ=xaRpNLMCKMVnXLA@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] DT: mfd: renesas,rzn1-sysctrl: document RZ/N1
 sysctrl node
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

Thanks for your patch!

On Thu, Mar 22, 2018 at 12:44 PM, Michel Pollet
<michel.pollet@bp.renesas.com> wrote:
> The Renesas RZ/N1 Family (Part #R9A06G0xx) has a multi-function
> system controller. This documents the node used to encapsulate
> it's sub drivers.

its

>
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/renesas,rzn1-sysctrl.txt
> @@ -0,0 +1,22 @@
> +DT bindings for the Renesas RZ-N1 System Controller

RZ/N1

> +
> +== System Controller Node ==
> +
> +The system controller node currently only hosts a single sub-driver to handle

s/sub-driver/sub-node/

> +the rebooting of the CPU. Eventually it will host the clock driver, SMP
> +start handler, watchdog etc.
> +
> +See renesas,rzn1-reboot.txt for further details.
> +
> +Bindings:
> ++ Optional:
> +       compatible = "renesas,r9a06g032-sysctrl";
> ++ Required:
> +       compatible = "renesas,rzn1-sysctrl";

Please mark both the SoC-specific and the family-specific values required.
Missing "syscon", "simple-mfd".

> +
> +Example:
> +       sysctrl: sysctrl@4000c000 {
> +               compatible = "renesas,r9a06g032-sysctrl",
> +                       "renesas,rzn1-sysctrl", "syscon", "simple-mfd";
> +               reg = <0x4000c000 0x1000>;
> +       };

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
