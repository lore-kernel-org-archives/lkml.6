Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753151AbeDROvT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 10:51:19 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:43746 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753236AbeDROuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 10:50:24 -0400
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 0/5] Use of_clk_get_parent_count() instead of open coding
Date: Wed, 18 Apr 2018 16:50:00 +0200
Message-Id: <1524063005-1716-1-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Mike, Stephen, et al,

This patch series replaces open-coded versions of
of_clk_get_parent_count() by calls to the helper function.

Changes compared to v2:
  - Add Acked-by, Reviewed-by,
  - Add SPDX-License-Identifier to <linux/of_clk.h>,
  - Add <linux/of_clk.h> to clock section in MAINTAINERS (note that Rob
    is still listed as a maintainer, too, due to the include/linux/of*.h
    catch-all rule),

Changes compared to v1:
  - Move OF clock helpers (a.o. of_clk_get_parent_count()) to their own
    include file <linux/of_clk.h>, as suggested by Stephen,
  - Update includes for the above change,
  - Fix timer-sp804, now a dummy is available in the !CONFIG_COMMON_CLK
    case,
  - Fix a new occurrence.

Note that patches 2-5 depend on the first patch.

Thanks!

Geert Uytterhoeven (5):
  clk: Extract OF clock helpers in <linux/of_clk.h>
  ARM: timer-sp: Use of_clk_get_parent_count() instead of open coding
  soc: rockchip: power-domain: Use of_clk_get_parent_count() instead of
    open coding
  soc/tegra: pmc: Use of_clk_get_parent_count() instead of open coding
  pinctrl: sunxi: Use of_clk_get_parent_count() instead of open coding

 MAINTAINERS                           |  1 +
 drivers/clocksource/timer-sp804.c     |  3 ++-
 drivers/pinctrl/sunxi/pinctrl-sunxi.c |  4 ++--
 drivers/soc/rockchip/pm_domains.c     |  4 ++--
 drivers/soc/tegra/pmc.c               |  3 ++-
 include/linux/clk-provider.h          | 14 +-------------
 include/linux/of_clk.h                | 30 ++++++++++++++++++++++++++++++
 7 files changed, 40 insertions(+), 19 deletions(-)
 create mode 100644 include/linux/of_clk.h

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
