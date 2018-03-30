Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751104AbeC3IBS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 04:01:18 -0400
Received: from mail-qt0-f180.google.com ([209.85.216.180]:41450 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750741AbeC3IBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 04:01:15 -0400
X-Google-Smtp-Source: AIpwx48ji5sFmRuXfZBYR9wx27yycuxjsjoQTWLIOv1IDKEj6AA1JH49QLWt1CaVO1C4IEwKWa5f3TPnCHCy7f5ywH4=
MIME-Version: 1.0
In-Reply-To: <1522309629-10152-3-git-send-email-michel.pollet@bp.renesas.com>
References: <1522309629-10152-1-git-send-email-michel.pollet@bp.renesas.com> <1522309629-10152-3-git-send-email-michel.pollet@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 30 Mar 2018 10:01:14 +0200
X-Google-Sender-Auth: 40z9pY7P5ZtEKjUpPe2HmvnbLyA
Message-ID: <CAMuHMdXo4wVD-b+_2WT+JUq6mpDpZoDvqMaLrs0yyjfe=Af4Dg@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] DT: reset: renesas,rzn1-reboot: document RZ/N1
 reboot driver
To: Michel Pollet <michel.pollet@bp.renesas.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Michel Pollet <buserror+upstream@gmail.com>,
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

On Thu, Mar 29, 2018 at 9:46 AM, Michel Pollet
<michel.pollet@bp.renesas.com> wrote:
> The Renesas RZ/N1 Family (Part #R9A06G0xx) requires a driver
> as part of the sysctrl MFD to handle rebooting the CA7 cores.
> This documents the driver bindings.
>
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/renesas,rzn1-reboot.txt
> @@ -0,0 +1,20 @@
> +DT bindings for the Renesas RZ/N1 Reboot Driver
> +
> +== Reboot Driver Node ==
> +
> +The reboot driver is always a subnode of the system controller node, see
> +renesas,rzn1-sysctrl.txt for details.
> +
> +Bindings:
> ++ Required:
> +       compatible = "renesas,rzn1-reboot";

You should list the supported SoC-specific compatible values here.

Quoting what I said on IRC:
1) DT bindings. These should list all compatible values possible/used.
2) DTS: These should list all applicable compatible values,
                from most-specific to least-specific (SoC-specific,
                family-specific (if exists), generic (if exists))
3 Driver: These should list only the least specific that is
                sufficient to get the job done. So usually we have the
                family-specific only, except if an SoC needs to be handled
                specially, or for historical reasons (DTB backeards
                compatibility)

> +
> +Example:
> +       sysctrl: sysctrl@4000c000 {
> +               compatible = "renesas,rzn1-sysctrl", "syscon", "simple-mfd";

Missing SoC-specific compatible value.

> +               reg = <0x4000c000 0x1000>;
> +
> +               reboot {
> +                       compatible = "renesas,rzn1-reboot";

Missing SoC-specific compatible value.

> +               };
> +       };

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
