Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 1IlcAo82HlvKIAAAmS7hNA
	; Mon, 11 Jun 2018 08:45:41 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8637760792; Mon, 11 Jun 2018 08:45:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 16D06602FC;
	Mon, 11 Jun 2018 08:45:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 16D06602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932572AbeFKIof (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 04:44:35 -0400
Received: from baptiste.telenet-ops.be ([195.130.132.51]:58034 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754083AbeFKIoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 04:44:32 -0400
Received: from ayla.of.borg ([84.194.111.163])
        by baptiste.telenet-ops.be with bizsmtp
        id xLkS1x00Z3XaVaC01LkSy2; Mon, 11 Jun 2018 10:44:31 +0200
Received: from ramsan.of.borg ([192.168.97.29] helo=ramsan)
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fSIR8-0006xV-Gt; Mon, 11 Jun 2018 10:44:26 +0200
Received: from geert by ramsan with local (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fSIR8-0005OO-FV; Mon, 11 Jun 2018 10:44:26 +0200
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Greg Ungerer <gerg@linux-m68k.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        "David S . Miller" <davem@davemloft.net>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-m68k@lists.linux-m68k.org,
        linux-mips@linux-mips.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 3/3 RFC] Revert "net: stmmac: fix build failure due to missing COMMON_CLK dependency"
Date: Mon, 11 Jun 2018 10:44:23 +0200
Message-Id: <1528706663-20670-4-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528706663-20670-1-git-send-email-geert@linux-m68k.org>
References: <1528706663-20670-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit bde4975310eb1982bd0bbff673989052d92fd481.

All legacy clock implementations now implement clk_set_rate() (Some
implementations may be dummies, though).

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Marked "RFC", as this depends on "m68k: coldfire: Normalize clk API" and
"MIPS: AR7: Normalize clk API".
---
 drivers/net/ethernet/stmicro/stmmac/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index cb5b0f58c395c2bd..e28c0d2c58e911ed 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -33,7 +33,7 @@ config DWMAC_DWC_QOS_ETH
 	select PHYLIB
 	select CRC32
 	select MII
-	depends on OF && COMMON_CLK && HAS_DMA
+	depends on OF && HAS_DMA
 	help
 	  Support for chips using the snps,dwc-qos-ethernet.txt DT binding.
 
@@ -57,7 +57,7 @@ config DWMAC_ANARION
 config DWMAC_IPQ806X
 	tristate "QCA IPQ806x DWMAC support"
 	default ARCH_QCOM
-	depends on OF && COMMON_CLK && (ARCH_QCOM || COMPILE_TEST)
+	depends on OF && (ARCH_QCOM || COMPILE_TEST)
 	select MFD_SYSCON
 	help
 	  Support for QCA IPQ806X DWMAC Ethernet.
@@ -100,7 +100,7 @@ config DWMAC_OXNAS
 config DWMAC_ROCKCHIP
 	tristate "Rockchip dwmac support"
 	default ARCH_ROCKCHIP
-	depends on OF && COMMON_CLK && (ARCH_ROCKCHIP || COMPILE_TEST)
+	depends on OF && (ARCH_ROCKCHIP || COMPILE_TEST)
 	select MFD_SYSCON
 	help
 	  Support for Ethernet controller on Rockchip RK3288 SoC.
@@ -123,7 +123,7 @@ config DWMAC_SOCFPGA
 config DWMAC_STI
 	tristate "STi GMAC support"
 	default ARCH_STI
-	depends on OF && COMMON_CLK && (ARCH_STI || COMPILE_TEST)
+	depends on OF && (ARCH_STI || COMPILE_TEST)
 	select MFD_SYSCON
 	---help---
 	  Support for ethernet controller on STi SOCs.
@@ -147,7 +147,7 @@ config DWMAC_STM32
 config DWMAC_SUNXI
 	tristate "Allwinner GMAC support"
 	default ARCH_SUNXI
-	depends on OF && COMMON_CLK && (ARCH_SUNXI || COMPILE_TEST)
+	depends on OF && (ARCH_SUNXI || COMPILE_TEST)
 	---help---
 	  Support for Allwinner A20/A31 GMAC ethernet controllers.
 
-- 
2.7.4
