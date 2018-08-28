Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F32C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8531020878
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:10:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8531020878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbeH1TCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 15:02:23 -0400
Received: from michel.telenet-ops.be ([195.130.137.88]:58156 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbeH1TCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 15:02:23 -0400
Received: from ramsan.of.borg ([84.194.111.163])
        by michel.telenet-ops.be with bizsmtp
        id UfAD1y00K3XaVaC06fADtC; Tue, 28 Aug 2018 17:10:15 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fufdF-00004v-DA; Tue, 28 Aug 2018 17:10:13 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fufdF-0003fh-B9; Tue, 28 Aug 2018 17:10:13 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 2/2] arm64: renesas: Remove the ARCH_SHMOBILE Kconfig symbol
Date:   Tue, 28 Aug 2018 17:10:11 +0200
Message-Id: <20180828151011.14065-3-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180828151011.14065-1-geert+renesas@glider.be>
References: <20180828151011.14065-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kconfig symbol for Renesas 64-bit ARM SoCs has always been
ARCH_RENESAS, with ARCH_SHMOBILE being selected to reuse drivers shared
with Renesas 32-bit ARM and/or Renesas SuperH SH-Mobile SoCs.

Commit 9b5ba0df4ea4f940 ("ARM: shmobile: Introduce ARCH_RENESAS")
started the conversion from ARCH_SHMOBILE to ARCH_RENESAS for Renesas
32-bit SoCs.  Now all drivers for Renesas ARM SoCs have gained proper
ARCH_RENESAS platform dependencies, there is no longer a need to select
ARCH_SHMOBILE.

With ARCH_SHMOBILE gone, move the ARCH_RENESAS section up, to restore
alphabetical sort order.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
v2:
  - Add Acked-by,
  - Drop RFC, now all dependencies have been merged,
  - Move ARCH_SYNQUACER after ARCH_STRATIX10,
  - Rebase.

JFTR, after this, the following symbols for drivers supporting only
Renesas SuperH "SH-Mobile" SoCs can no longer be selected:
  - CONFIG_KEYBOARD_SH_KEYSC,
  - CONFIG_VIDEO_SH_VOU,
  - CONFIG_VIDEO_RENESAS_CEU.
(changes for a renesas_defconfig .config)
---
 arch/arm64/Kconfig.platforms | 44 ++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 531ea508aa6ba3f4..52610071fdc189bf 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -152,32 +152,8 @@ config ARCH_REALTEK
 	  This enables support for the ARMv8 based Realtek chipsets,
 	  like the RTD1295.
 
-config ARCH_ROCKCHIP
-	bool "Rockchip Platforms"
-	select ARCH_HAS_RESET_CONTROLLER
-	select GPIOLIB
-	select PINCTRL
-	select PINCTRL_ROCKCHIP
-	select PM
-	select ROCKCHIP_TIMER
-	help
-	  This enables support for the ARMv8 based Rockchip chipsets,
-	  like the RK3368.
-
-config ARCH_SEATTLE
-	bool "AMD Seattle SoC Family"
-	help
-	  This enables support for AMD Seattle SOC Family
-
-config ARCH_SHMOBILE
-	bool
-
-config ARCH_SYNQUACER
-	bool "Socionext SynQuacer SoC Family"
-
 config ARCH_RENESAS
 	bool "Renesas SoC Platforms"
-	select ARCH_SHMOBILE
 	select PINCTRL
 	select PM
 	select PM_GENERIC_DOMAINS
@@ -234,11 +210,31 @@ config ARCH_R8A77995
 	help
 	  This enables support for the Renesas R-Car D3 SoC.
 
+config ARCH_ROCKCHIP
+	bool "Rockchip Platforms"
+	select ARCH_HAS_RESET_CONTROLLER
+	select GPIOLIB
+	select PINCTRL
+	select PINCTRL_ROCKCHIP
+	select PM
+	select ROCKCHIP_TIMER
+	help
+	  This enables support for the ARMv8 based Rockchip chipsets,
+	  like the RK3368.
+
+config ARCH_SEATTLE
+	bool "AMD Seattle SoC Family"
+	help
+	  This enables support for AMD Seattle SOC Family
+
 config ARCH_STRATIX10
 	bool "Altera's Stratix 10 SoCFPGA Family"
 	help
 	  This enables support for Altera's Stratix 10 SoCFPGA Family.
 
+config ARCH_SYNQUACER
+	bool "Socionext SynQuacer SoC Family"
+
 config ARCH_TEGRA
 	bool "NVIDIA Tegra SoC Family"
 	select ARCH_HAS_RESET_CONTROLLER
-- 
2.17.1

