Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752180AbeBZIOl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 03:14:41 -0500
Received: from mail-qt0-f175.google.com ([209.85.216.175]:42247 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751788AbeBZIOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 03:14:38 -0500
X-Google-Smtp-Source: AG47ELtAv4JVSN+eYrOnTbRYZ/dtKpezWOl2g69zNm8LBiT3NWS7wL4wLcmnUB67fUiRQheJliPOSFfopKfwjs0yYHo=
MIME-Version: 1.0
In-Reply-To: <1519139541-18783-2-git-send-email-jacopo+renesas@jmondi.org>
References: <1519139541-18783-1-git-send-email-jacopo+renesas@jmondi.org> <1519139541-18783-2-git-send-email-jacopo+renesas@jmondi.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 Feb 2018 09:14:36 +0100
X-Google-Sender-Auth: 8K0v7xo-Gpz-d7lH9VL5tDFD_JE
Message-ID: <CAMuHMdWcLd6BnwW2fwOPhpsRZ=qfuYE6YoehFj8WXkUmGZMW_A@mail.gmail.com>
Subject: Re: [PATCH v2 01/19] clk: renesas: cpg-mssr: Add support for R-Car M3-N
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
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

On Tue, Feb 20, 2018 at 4:12 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> Initial support for R-Car M3-N (r8a77965), including core and module
> clocks.
>
> Based on Table 8.2d of "R-Car Series, 3rd Generation User's Manual:
> Hardware (Rev. 0.80, Oct 31, 2017)".
>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

> --- a/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.txt
> +++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.txt
> @@ -22,6 +22,7 @@ Required Properties:
>        - "renesas,r8a7794-cpg-mssr" for the r8a7794 SoC (R-Car E2)
>        - "renesas,r8a7795-cpg-mssr" for the r8a7795 SoC (R-Car H3)
>        - "renesas,r8a7796-cpg-mssr" for the r8a7796 SoC (R-Car M3-W)
> +      - "renesas,r8a77965-cpg-mssr" for the r8a77965 SoC (R-Car M3-N)
>        - "renesas,r8a77970-cpg-mssr" for the r8a77970 SoC (R-Car V3M)
>        - "renesas,r8a77995-cpg-mssr" for the r8a77995 SoC (R-Car D3)

You forgot to update the list of external parent clock names.
No need to fix and resend, I've squashed in the following:

--- a/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.txt
+++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.txt
@@ -34,8 +34,8 @@ Required Properties:
     clock-names
   - clock-names: List of external parent clock names. Valid names are:
       - "extal" (r8a7743, r8a7745, r8a7790, r8a7791, r8a7792, r8a7793, r8a7794,
-                r8a7795, r8a7796, r8a77970, r8a77980, r8a77995)
-      - "extalr" (r8a7795, r8a7796, r8a77970, r8a77980)
+                r8a7795, r8a7796, r8a77965, r8a77970, r8a77980, r8a77995)
+      - "extalr" (r8a7795, r8a7796, r8a77965, r8a77970, r8a77980)
       - "usb_extal" (r8a7743, r8a7745, r8a7790, r8a7791, r8a7793, r8a7794)

   - #clock-cells: Must be 2

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
