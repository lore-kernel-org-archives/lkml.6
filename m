Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755201AbeEYJXw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 05:23:52 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:45028 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755107AbeEYJXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 05:23:50 -0400
X-Google-Smtp-Source: AB8JxZpsrUMlQ5AQfeRa21i6aO/AS17b8SxsNyRH9iNCyssVc5jXPw7Z35e/ppAysWLJ4t7sBaQpyiSiA0AJNxVeFio=
MIME-Version: 1.0
In-Reply-To: <1527154169-32380-3-git-send-email-michel.pollet@bp.renesas.com>
References: <1527154169-32380-1-git-send-email-michel.pollet@bp.renesas.com> <1527154169-32380-3-git-send-email-michel.pollet@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 25 May 2018 11:23:48 +0200
X-Google-Sender-Auth: LlNbfI6zFG5Xmz_VhaOes8Scd9E
Message-ID: <CAMuHMdUb4fWFB9oP41ejO0_FDxmgBPL0GxQnkFv18Zfb5=1-fw@mail.gmail.com>
Subject: Re: [PATCH v7 2/5] dt-bindings: clock: renesas,r9a06g032-sysctrl: documentation
To: Michel Pollet <michel.pollet@bp.renesas.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Michel Pollet <buserror+upstream@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michel,

On Thu, May 24, 2018 at 11:28 AM, Michel Pollet
<michel.pollet@bp.renesas.com> wrote:
> The Renesas R9A06G032 SYSCTRL node description.
>
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.txt
> @@ -0,0 +1,32 @@
> +* Renesas R9A06G032 SYSCTRL
> +
> +Required Properties:
> +
> +  - compatible: Must be:
> +    - "renesas,r9a06g032-sysctrl"
> +  - reg: Base address and length of the SYSCTRL IO block.
> +  - #clock-cells: Must be 1

No clocks/clock-names for the external clock inputs?

"RZ/N1 has 3 clock sources, 1 reference clock inputs for RGMII, and 2
 reference clock outputs for RMII/MII."

Given the documentation explicitly mentions the module clocks are to be
used for power-management, you may want to add #power-domain-cells as well,
and let the driver register clock domain. But that can be added later
(although it will break backwards compatibility with old DTBs).

As PWRCTRL_* registers allow to reset individual modules, #reset-cells is
another thing to add later.  It's good to start thinking early about how to
reference resets, though.
E.g. on other Renesas-SoCs, module resets uses the same numerical
references as module clocks.


> +
> +Examples
> +--------
> +
> +  - SYSCTRL node:
> +
> +       sysctrl: sysctrl@4000c000 {

system-controller@

> +               compatible = "renesas,r9a06g032-sysctrl";
> +               reg = <0x4000c000 0x1000>;
> +               #clock-cells = <1>;
> +       };

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
