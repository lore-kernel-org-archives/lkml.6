Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933080AbeEHQ3f (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 12:29:35 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:41270 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932735AbeEHQ3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 12:29:32 -0400
X-Google-Smtp-Source: AB8JxZrQCFh/2owAmVUg+XlyRr9zexlrQnK+ftuH1RVMhsSCIHicmgjBE+0uSb6uA/SoKlnWcLrCWQ==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marcel Ziswiler <marcel@ziswiler.com>, Marc Dietrich <marvin24@gmx.de>
Cc: linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] ARM: dts: tegra20: Revert "Fix ULPI regression on Tegra20"
Date: Tue,  8 May 2018 19:26:07 +0300
Message-Id: <20180508162607.3500-6-digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508162607.3500-1-digetx@gmail.com>
References: <20180508162607.3500-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 4c9a27a6c66d ("ARM: tegra: Fix ULPI regression on Tegra20") changed
"ulpi-link" clock from CDEV2 to PLL_P_OUT4. Turned out that PLL_P_OUT4 is
the parent of CDEV2 clock and original clock setup of "ulpi-link" was
correct. The reverted patch was fixing USB for one board and broke the
other, now Tegra's clk driver correctly sets parent for the CDEV2 clock
and hence patch could be reverted safely, restoring USB for all of the
boards.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Reviewed-by: Marcel Ziswiler <marcel@ziswiler.com>
Tested-by: Marcel Ziswiler <marcel@ziswiler.com>
Tested-by: Marc Dietrich <marvin24@gmx.de>
---
 arch/arm/boot/dts/tegra20.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 0a7136462a1a..983dd5c14794 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -741,7 +741,7 @@
 		phy_type = "ulpi";
 		clocks = <&tegra_car TEGRA20_CLK_USB2>,
 			 <&tegra_car TEGRA20_CLK_PLL_U>,
-			 <&tegra_car TEGRA20_CLK_PLL_P_OUT4>;
+			 <&tegra_car TEGRA20_CLK_CDEV2>;
 		clock-names = "reg", "pll_u", "ulpi-link";
 		resets = <&tegra_car 58>, <&tegra_car 22>;
 		reset-names = "usb", "utmi-pads";
-- 
2.17.0
