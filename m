Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932218AbeDZX7G (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 19:59:06 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33246 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751626AbeDZX7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 19:59:01 -0400
X-Google-Smtp-Source: AB8JxZquluhoDx7BID7EUKDjo012G/R+X8IA4Nwazl48XA21MfgV5NSKVfUNaHvVuqgonK2Lem2JLw==
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
Subject: [PATCH v1 4/4] ARM: dts: tegra20: Revert "Fix ULPI regression on Tegra20"
Date: Fri, 27 Apr 2018 02:58:18 +0300
Message-Id: <20180426235818.10018-5-digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180426235818.10018-1-digetx@gmail.com>
References: <20180426235818.10018-1-digetx@gmail.com>
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
