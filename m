Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755169AbeBOJHU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 04:07:20 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:34840 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755069AbeBOJHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 04:07:15 -0500
X-Google-Smtp-Source: AH8x226/wMwafSw73e8gpGun4UjrZfulh9WPIMJMnT788TTlEJR98A1xHSJ1B9taCz2Vo76MPUF2WbxSPkXLXToV7Jk=
MIME-Version: 1.0
In-Reply-To: <1518683903-10681-6-git-send-email-kbingham@kernel.org>
References: <1518683903-10681-1-git-send-email-kbingham@kernel.org> <1518683903-10681-6-git-send-email-kbingham@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 15 Feb 2018 10:07:14 +0100
X-Google-Sender-Auth: IeOSZLeeI8VRbxGLRSACtOFzXj4
Message-ID: <CAMuHMdVKczZpoXgSDOSEJZb59LAZtbWsopRaa8PtHDoZcFEMTQ@mail.gmail.com>
Subject: Re: [PATCH 5/8] arm64: dts: renesas: r8a77995: Add LVDS support
To: Kieran Bingham <kbingham@kernel.org>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Simon Horman <horms@verge.net.au>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

On Thu, Feb 15, 2018 at 9:38 AM, Kieran Bingham <kbingham@kernel.org> wrote:
> From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
>
> The r8a77995 D3 platform has 2 LVDS channels connected to the DU.
>
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

I love your patch!
Yet something to improve...

> --- a/arch/arm64/boot/dts/renesas/r8a77995.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
> @@ -773,18 +773,70 @@
>                                 port@1 {
>                                         reg = <1>;
>                                         du_out_lvds0: endpoint {
> +                                               remote-endpoint = <&du_out_lvds0>;
>                                         };
>                                 };
>
>                                 port@2 {
>                                         reg = <2>;
>                                         du_out_lvds1: endpoint {
> +                                               remote-endpoint = <&du_out_lvds1>;
>                                         };
>                                 };
>                         };
>                 };
>         };
>
> +       lvds0: lvds@feb90000 {
> +               compatible = "renesas,lvds-r8a77995";
> +               reg = <0 0xfeb90000 0 0x20>;
> +               clocks = <&cpg CPG_MOD 727>;
> +               status = "disabled";

Missing resets, power-domains

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
