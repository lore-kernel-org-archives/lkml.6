Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238DCC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3DE72172B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="OOSjPw5q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3DE72172B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=iluvatar.ai
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732853AbeHCJQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:16:54 -0400
Received: from mail.iluvatar.ai ([58.213.90.100]:59738 "EHLO mail.iluvatar.ai"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729813AbeHCJQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:16:53 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 23DFB14556874;
        Fri,  3 Aug 2018 15:25:34 +0800 (CST)
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Saz99B2AhKQW; Fri,  3 Aug 2018 15:25:32 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 1E4D41455687E;
        Fri,  3 Aug 2018 15:25:32 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 mail.iluvatar.ai 1E4D41455687E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iluvatar.ai;
        s=809B2F8E-810B-11E8-86FD-A0A654EEFFEB; t=1533281132;
        bh=SUwpzQbE1dBuHteEo8GV++J2K752LQCpcXdmCCznyIg=;
        h=From:To:Subject:Date:Message-Id;
        b=OOSjPw5qAGCZrW26FNpLSjsLsQmKnh8ME7S2yC4wMhwMv3i17YNXDqfld/Snqq0Al
         yNHhoFblWL3YzRSUSh6i3dW1XGpUujj5TNZfYlcpBI8xj2flA1QqWN2rniuQrl8xD1
         l5kIYDiAKfEug+tydZMfbYuuurAtQEuuChrPL8t8=
X-Virus-Scanned: amavisd-new at iluvatar.ai
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id MphS_Hx7VJYP; Fri,  3 Aug 2018 15:25:32 +0800 (CST)
Received: from localhost.localdomain (unknown [180.166.124.10])
        by mail.iluvatar.ai (Postfix) with ESMTPSA id 6326F1455687B;
        Fri,  3 Aug 2018 15:25:31 +0800 (CST)
From:   Huang Shijie <sjhuang@iluvatar.ai>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave.jiang@intel.com, radhey.shyam.pandey@xilinx.com,
        appana.durga.rao@xilinx.com, jmkrzyszt@gmail.com,
        gomonovych@gmail.com, peter.ujfalusi@ti.com, keescook@chromium.org,
        horms+renesas@verge.net.au, geert+renesas@glider.be,
        shawnguo@kernel.org, baoyou.xie@linaro.org,
        michal.simek@xilinx.com, baohua@kernel.org,
        ludovic.desroches@microchip.com, linus.walleij@linaro.org,
        david.brown@linaro.org, Huang Shijie <sjhuang@iluvatar.ai>
Subject: [PATCH 46/46] dmaengine: add COMPILE_TEST for the drivers
Date:   Fri,  3 Aug 2018 15:20:16 +0800
Message-Id: <20180803072016.21544-47-sjhuang@iluvatar.ai>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180803072016.21544-1-sjhuang@iluvatar.ai>
References: <20180803072016.21544-1-sjhuang@iluvatar.ai>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can do the compiling test with COMPILE_TEST.
Thisi patch adds the COMPILE_TEST for the drivers.

Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
---
 drivers/dma/Kconfig    | 24 ++++++++++++------------
 drivers/dma/ti/Kconfig |  2 +-
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index d4a4230a7942..7670b2f967c4 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -85,14 +85,14 @@ config AMCC_PPC440SPE_ADMA
 
 config AT_HDMAC
 	tristate "Atmel AHB DMA support"
-	depends on ARCH_AT91
+	depends on ARCH_AT91 || COMPILE_TEST
 	select DMA_ENGINE
 	help
 	  Support the Atmel AHB DMA controller.
 
 config AT_XDMAC
 	tristate "Atmel XDMA support"
-	depends on ARCH_AT91
+	depends on ARCH_AT91 || COMPILE_TEST
 	select DMA_ENGINE
 	help
 	  Support the Atmel XDMA controller.
@@ -163,7 +163,7 @@ config DMA_SA11X0
 
 config DMA_SUN4I
 	tristate "Allwinner A10 DMA SoCs support"
-	depends on MACH_SUN4I || MACH_SUN5I || MACH_SUN7I
+	depends on MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || COMPILE_TEST
 	default (MACH_SUN4I || MACH_SUN5I || MACH_SUN7I)
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
@@ -240,7 +240,7 @@ config IMG_MDC_DMA
 
 config IMX_DMA
 	tristate "i.MX DMA support"
-	depends on ARCH_MXC
+	depends on ARCH_MXC || COMPILE_TEST
 	select DMA_ENGINE
 	help
 	  Support the i.MX DMA engine. This engine is integrated into
@@ -248,7 +248,7 @@ config IMX_DMA
 
 config IMX_SDMA
 	tristate "i.MX SDMA support"
-	depends on ARCH_MXC
+	depends on ARCH_MXC || COMPILE_TEST
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
@@ -341,7 +341,7 @@ config MMP_TDMA
 
 config MOXART_DMA
 	tristate "MOXART DMA support"
-	depends on ARCH_MOXART
+	depends on ARCH_MOXART || COMPILE_TEST
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
@@ -439,7 +439,7 @@ config PL330_DMA
 
 config PXA_DMA
 	bool "PXA DMA support"
-	depends on (ARCH_MMP || ARCH_PXA)
+	depends on (ARCH_MMP || ARCH_PXA || COMPILE_TEST)
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
@@ -450,14 +450,14 @@ config PXA_DMA
 
 config SIRF_DMA
 	tristate "CSR SiRFprimaII/SiRFmarco DMA support"
-	depends on ARCH_SIRF
+	depends on ARCH_SIRF || COMPILE_TEST
 	select DMA_ENGINE
 	help
 	  Enable support for the CSR SiRFprimaII DMA engine.
 
 config STE_DMA40
 	bool "ST-Ericsson DMA40 support"
-	depends on ARCH_U8500
+	depends on ARCH_U8500 || COMPILE_TEST
 	select DMA_ENGINE
 	help
 	  Support for ST-Ericsson DMA40 controller
@@ -538,7 +538,7 @@ config TXX9_DMAC
 
 config TEGRA20_APB_DMA
 	bool "NVIDIA Tegra20 APB DMA support"
-	depends on ARCH_TEGRA
+	depends on ARCH_TEGRA || COMPILE_TEST
 	select DMA_ENGINE
 	help
 	  Support for the NVIDIA Tegra20 APB DMA controller driver. The
@@ -579,7 +579,7 @@ config XGENE_DMA
 
 config XILINX_DMA
 	tristate "Xilinx AXI DMAS Engine"
-	depends on (ARCH_ZYNQ || MICROBLAZE || ARM64)
+	depends on (ARCH_ZYNQ || MICROBLAZE || ARM64 || COMPILE_TEST)
 	select DMA_ENGINE
 	help
 	  Enable support for Xilinx AXI VDMA Soft IP.
@@ -598,7 +598,7 @@ config XILINX_DMA
 
 config XILINX_ZYNQMP_DMA
 	tristate "Xilinx ZynqMP DMA Engine"
-	depends on (ARCH_ZYNQ || MICROBLAZE || ARM64)
+	depends on (ARCH_ZYNQ || MICROBLAZE || ARM64 || COMPILE_TEST)
 	select DMA_ENGINE
 	help
 	  Enable support for Xilinx ZynqMP DMA controller.
diff --git a/drivers/dma/ti/Kconfig b/drivers/dma/ti/Kconfig
index e5e74e1361dc..a494789c5b87 100644
--- a/drivers/dma/ti/Kconfig
+++ b/drivers/dma/ti/Kconfig
@@ -4,7 +4,7 @@
 
 config TI_CPPI41
 	tristate "Texas Instruments CPPI 4.1 DMA support"
-	depends on (ARCH_OMAP || ARCH_DAVINCI_DA8XX)
+	depends on (ARCH_OMAP || ARCH_DAVINCI_DA8XX || COMPILE_TEST)
 	select DMA_ENGINE
 	help
 	  The Communications Port Programming Interface (CPPI) 4.1 DMA engine
-- 
2.17.1

