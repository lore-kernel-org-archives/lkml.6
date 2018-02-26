Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751575AbeBZS2u (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 13:28:50 -0500
Received: from mail-qt0-f174.google.com ([209.85.216.174]:43604 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750826AbeBZS2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 13:28:48 -0500
X-Google-Smtp-Source: AG47ELtD7z9D4aEedRQcOnijTDY5yFGqh2mqUuYSnLN/Heiz8CSZ2o3cDaQvHYSTLqnXFRZFl8gkSeHIK0v8do0RJ64=
MIME-Version: 1.0
In-Reply-To: <1519667836-31330-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1519667836-31330-1-git-send-email-jacopo+renesas@jmondi.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 Feb 2018 19:28:47 +0100
X-Google-Sender-Auth: o5JcChObq7piTXMLZ41MMoIZIsg
Message-ID: <CAMuHMdXwxhT7MP5xs3HLP3oFX+V9rhCM5jQycXUiCyBOKOUg1Q@mail.gmail.com>
Subject: Re: [PATCH 0/8] R-Car M3-N: Enable EtherAVB device node
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: Simon Horman <horms@verge.net.au>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        iommu@lists.linux-foundation.org, netdev <netdev@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

On Mon, Feb 26, 2018 at 6:57 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
>   as discussed with you Sergei and Geert, in order to enable EtherAVB for
> R8A77965 we first wanted to make the phy-mode "rgmii-txid" a board specific
> property for all other SoCs.

Thanks for your series!

> This series adds  the phy-mode property to salvator-common.dtsi and reset the
> one for R8A77965/R8A7796/R8A77995 to "rgmii".

I forgot that r8a7795.dtsi and r8a7796.dtsi are used for the ULCB boards, too.
So to avoid regressions, you need to make a similar change to ulcb.dtsi like you
made for salvator-common.dtsi.

In addition, r8a77995.dtsi is only used for the Draak board.
So you have to update r8a7795-draak.dtsi first, too.

> Then, in order to enable EtherAVB for R-Car M3-N, iommu nodes had to be added
> as they are referenced by the "avb" device node (CC the iommu list for the
> series for that reason).

I don't think we need the iommu properties and nodes at this early stage.
Ethernet works fine without them. Simon, do you agree?

P.S. scripts/dtc/dtx_diff is a great tool to compare DTBs before and after your
      changes. It would have revealed the changes for ULCB and Draak.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
