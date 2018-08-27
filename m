Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2925C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 12:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A42B620869
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 12:40:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A42B620869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbeH0Q1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 12:27:20 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:34734 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbeH0Q1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 12:27:20 -0400
Received: by mail-ua1-f67.google.com with SMTP id r15-v6so9407758uao.1;
        Mon, 27 Aug 2018 05:40:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h6QHfcU//RQzOKPMP1j5WuBU+Oz2TSeuoksthh7W0yM=;
        b=og5qGdnDieI7bwMZCKUMR+SUunix0JzoM6dRcGQOp/Uz3ticjSPjKMe161JLTwtA2u
         0fZDgpcMxrm/dD/7k4UH7QTwBHb2aw6rvYJAMrdAZQ3qYCj7LHk4RoqNEineLJhZAbg7
         Vg+8Sfzu4UhRDsnLI+3R3JkgZ/OnyQrAR2tP5hxmeLR/Hu++ysuOwt6MFw/fiSMO5Gro
         ElC6e4t7UArAboU+M3pqv9lL1rRwip6RnT7mSkhig5tFOBB4/B5MnyQcDYwGRmywuFC/
         B3tHMMeNXgGIj2iKqGEE4O8H1NoE/YirRMcse03+SwPIphUBYaw84/me8ZImZfpFru+k
         5lXg==
X-Gm-Message-State: APzg51B8hjliLvAw9ZdAjEyRsqe4fw++imxq+5YQQo6Kw1K+AoPU+Kdr
        O78flqg2L/nEfkJVVbcZktgb/fIti+koy+BYWb0=
X-Google-Smtp-Source: ANB0VdZxaEhlFX4v0+4nMwRQkIJtuclj32/jIE8OfF6p58wxH3s1WgfnpNAe8kiZzDFrdz0Rvlh2UenRWEZloeUwtok=
X-Received: by 2002:ab0:51e4:: with SMTP id h33-v6mr8231639uaa.137.1535373648998;
 Mon, 27 Aug 2018 05:40:48 -0700 (PDT)
MIME-Version: 1.0
References: <1535029653-7418-1-git-send-email-fabrizio.castro@bp.renesas.com> <1535029653-7418-4-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1535029653-7418-4-git-send-email-fabrizio.castro@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 27 Aug 2018 14:40:37 +0200
Message-ID: <CAMuHMdWPuqfXOgh_-qp8q6wATU3Lj_WpX0bAOxPBX76SKvyXCQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] dt-bindings: can: rcar_can: Add r8a774a1 support
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org,
        netdev <netdev@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrizio,

On Thu, Aug 23, 2018 at 3:08 PM Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:>
> Document RZ/G2M (r8a774a1) SoC specific bindings and RZ/G2
> generic bindings.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Chris Paterson <Chris.Paterson2@renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/net/can/rcar_can.txt
> +++ b/Documentation/devicetree/bindings/net/can/rcar_can.txt
> @@ -4,6 +4,7 @@ Renesas R-Car CAN controller Device Tree Bindings
>  Required properties:
>  - compatible: "renesas,can-r8a7743" if CAN controller is a part of R8A7743 SoC.
>               "renesas,can-r8a7745" if CAN controller is a part of R8A7745 SoC.
> +             "renesas,can-r8a774a1" if CAN controller is a part of R8A774A1 SoC.

Looks good to me.

>               "renesas,can-r8a7778" if CAN controller is a part of R8A7778 SoC.
>               "renesas,can-r8a7779" if CAN controller is a part of R8A7779 SoC.
>               "renesas,can-r8a7790" if CAN controller is a part of R8A7790 SoC.
> @@ -17,6 +18,7 @@ Required properties:
>               "renesas,rcar-gen2-can" for a generic R-Car Gen2 or RZ/G1
>               compatible device.
>               "renesas,rcar-gen3-can" for a generic R-Car Gen3 compatible device.
> +             "renesas,rzg-gen2-can" for a generic RZ/G2 compatible device.

AFAIK, the actual CAN module in RZ/G2M is fully compatible with the CAN
module in R-Car Gen3 SoCs. The lack of clkp2 is merely an integration
difference: as RZ/G2 SoCs do not have the CANFD module, and their CPG block
doesn't provide the CANFD clock (so the CAN device node in DT cannot refer
to that clock anyway).

Hence I don't think there's a need to introduce a "renesas,rzg-gen2-can"
compatible value.

>               When compatible with the generic version, nodes must list the
>               SoC-specific version corresponding to the platform first
>               followed by the generic version.
> @@ -24,7 +26,9 @@ Required properties:
>  - reg: physical base address and size of the R-Car CAN register map.
>  - interrupts: interrupt specifier for the sole interrupt.
>  - clocks: phandles and clock specifiers for 3 CAN clock inputs.

You still have "3" here. Perhaps
"Must contain a phandle and clock-specifier pair for each entry in
clock-names."?

> -- clock-names: 3 clock input name strings: "clkp1", "clkp2", "can_clk".
> +- clock-names: 2 clock input name strings for RZ/G2: "clkp1", "can_clk".
> +              3 clock input name strings for every other SoC: "clkp1", "clkp2",
> +              "can_clk".

OK.

> @@ -41,8 +45,9 @@ using the below properties:
>  Optional properties:
>  - renesas,can-clock-select: R-Car CAN Clock Source Select. Valid values are:
>                             <0x0> (default) : Peripheral clock (clkp1)
> -                           <0x1> : Peripheral clock (clkp2)
> -                           <0x3> : Externally input clock
> +                           <0x1> : Peripheral clock (clkp2) (not supported by
> +                                   RZ/G2 devices)
> +                           <0x3> : External input clock

I already expressed my feelings about this property in my reply to the first
patch ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
