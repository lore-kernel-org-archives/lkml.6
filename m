Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751518AbeDXPoh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 11:44:37 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:39901 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750943AbeDXPod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 11:44:33 -0400
X-Google-Smtp-Source: AIpwx4+JGnST1Ia1GlgWNiG7oUiFhgM0UPO5uCdxm6CE9XIHjNJuOz5baiaoH8H/Gvod/rqgpwqA1A==
Date: Tue, 24 Apr 2018 10:44:31 -0500
From: Rob Herring <robh@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-tegra@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/5] clk: Extract OF clock helpers in <linux/of_clk.h>
Message-ID: <20180424154431.5bf35ck4z5xtusnm@rob-hp-laptop>
References: <1524063005-1716-1-git-send-email-geert+renesas@glider.be>
 <1524063005-1716-2-git-send-email-geert+renesas@glider.be>
 <152417672470.46528.14790019208345640453@swboyd.mtv.corp.google.com>
 <CAMuHMdUX9dJcGLgftAAeCOXYxKUOQ_dW7=oLwNt5VRbd6nQpuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUX9dJcGLgftAAeCOXYxKUOQ_dW7=oLwNt5VRbd6nQpuA@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 08:28:28AM +0200, Geert Uytterhoeven wrote:
> Hi Stephen, Rob,
> 
> On Fri, Apr 20, 2018 at 12:25 AM, Stephen Boyd <sboyd@kernel.org> wrote:
> > Quoting Geert Uytterhoeven (2018-04-18 07:50:01)
> >> The use of of_clk_get_parent_{count,name}() and of_clk_init() is not
> >> limited to clock providers.
> >>
> >> Hence move these helpers into their own header file, so callers that are
> >> not clock providers no longer have to include <linux/clk-provider.h>.
> >>
> >> Suggested-by: Stephen Boyd <sboyd@kernel.org>
> >> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> >> ---
> >> v3:
> >>   - Add Reviewed-by,
> >>   - Add SPDX-License-Identifier,
> >>   - Add to clock section in MAINTAINERS (note that Rob is still listed
> >>     as a maintainer, too, due to the include/linux/of*.h catch-all
> >>     rule),
> >
> > Can you X: out this file so Rob is happy? Or that doesn't work?
> 
> I guess that should work.
> 
> My point here is that due to the catch-all rule, he's listed as maintainer
> for of_{dma,gpio,irq,iommu,mdio,net,pci} too, which are all helpers for
> other subsystems. Perhaps these should be X'd-out too?
> Or is it OK without X-ing them out, as the clock maintainers are now shown, too?
> 
> Rob: What's your preference?

It's fine as-is.

Rob
