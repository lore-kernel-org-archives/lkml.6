Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752645AbeBEBZI (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 20:25:08 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:44438 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752523AbeBEBYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 20:24:30 -0500
X-Google-Smtp-Source: AH8x225FXJHUrw73CaFRWJx2l+OmoFDPjzCJPSB0q6skLo4qquiPFeUdxlptwDPfoXACNNdG7gQAsg==
From: Ulf Magnusson <ulfalizer@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org, tfiga@chromium.org, paul.burton@mips.com,
        m.szyprowski@samsung.com, egtvedt@samfundet.no,
        linus.walleij@linaro.org, vgupta@synopsys.com,
        mgorman@techsingularity.net, hch@lst.de, mina86@mina86.com,
        robh@kernel.org, sboyd@codeaurora.org, paulus@ozlabs.org,
        will.deacon@arm.com, tony@atomide.com, npiggin@gmail.com,
        yamada.masahiro@socionext.com, Ulf Magnusson <ulfalizer@gmail.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
Subject: [PATCH 09/20] clk: sunxi-ng: Remove SUNXI_CCU_* selects
Date: Mon,  5 Feb 2018 02:21:21 +0100
Message-Id: <20180205012146.23981-10-ulfalizer@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180205012146.23981-1-ulfalizer@gmail.com>
References: <20180205012146.23981-1-ulfalizer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The selected symbols were removed in commit 06e226c7fb23 ("clk:
sunxi-ng: Move all clock types to a library").

Remove the selects from SUN4I_A10_CCU.

Discovered with the
https://github.com/ulfalizer/Kconfiglib/blob/master/examples/list_undefined.py
script.

Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
---
 drivers/clk/sunxi-ng/Kconfig | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
index 6427d0ebe2de..33168f94ee39 100644
--- a/drivers/clk/sunxi-ng/Kconfig
+++ b/drivers/clk/sunxi-ng/Kconfig
@@ -13,13 +13,6 @@ config SUN50I_A64_CCU
 
 config SUN4I_A10_CCU
 	bool "Support for the Allwinner A10/A20 CCU"
-	select SUNXI_CCU_DIV
-	select SUNXI_CCU_MULT
-	select SUNXI_CCU_NK
-	select SUNXI_CCU_NKM
-	select SUNXI_CCU_NM
-	select SUNXI_CCU_MP
-	select SUNXI_CCU_PHASE
 	default MACH_SUN4I
 	default MACH_SUN7I
 	depends on MACH_SUN4I || MACH_SUN7I || COMPILE_TEST
-- 
2.14.1
