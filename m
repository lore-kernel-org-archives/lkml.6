Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751676AbeBWJTZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 04:19:25 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:42188 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750861AbeBWJTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 04:19:22 -0500
X-Google-Smtp-Source: AG47ELvGcWWnhPbCVDzZ8Ww1WX721RjfLMXBUbHWmZnGhYPqz7PKOcpwe6PYuEOFsHkO65cSK+Yej0gTrYxCQ9IlG0U=
MIME-Version: 1.0
In-Reply-To: <1519326370-15805-2-git-send-email-jacopo+renesas@jmondi.org>
References: <1519326370-15805-1-git-send-email-jacopo+renesas@jmondi.org> <1519326370-15805-2-git-send-email-jacopo+renesas@jmondi.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 23 Feb 2018 10:19:21 +0100
X-Google-Sender-Auth: Geb9yx4Wzfp2kPDA4Y8YziysO9E
Message-ID: <CAMuHMdWGYpeOMJQKcT8=wm1YzQoB+vpK5H99Kg_pJ_HeBUw8Sw@mail.gmail.com>
Subject: Re: [PATCH 1/6] arm64: dts: renesas: r8a77965: Add "reg" properties
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

On Thu, Feb 22, 2018 at 8:06 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> Add "reg" properties to place-holder nodes with unit address defined for
> R-Car M3-N SoC.
>
> This silences the following DTC compiler warning:
> Warning (unit_address_vs_reg): Node /soc/... has a unit name,
> but no reg property
>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

A few minor nits below...

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi

> @@ -520,130 +521,163 @@
>                 };
>
>                 avb: ethernet@e6800000 {
> +                       reg = <0 0xe6800000 0 0x800>, <0 0xe6a00000 0 0x10000>;

The first reg part would be sufficient for a placeholder.
I think even setting the size to zero would work...

>                 du: display@feb00000 {
> +                       reg = <0 0xfeb00000 0 0x70000>,

Unlike M3-W, the M3-N DU has a third channel, so the size is too small.

> +                             <0 0xfeb90000 0 0x14>;
>                         /* placeholder */

> @@ -703,38 +745,47 @@
>                 };
>
>                 usb2_phy1: usb-phy@ee0a0200 {
> +                       reg = <0 0xee0a0200 0 0x700>;
>                         /* placeholder */
>                 };

To be moved up, next to the other usb2 devices?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
