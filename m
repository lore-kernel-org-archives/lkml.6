Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753577AbeDIT35 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 15:29:57 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36956 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752781AbeDIT3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 15:29:51 -0400
X-Google-Smtp-Source: AIpwx492tpQBHXT8icuAHveyNMPpO6/h2AO2dszRDschJ1orta+InbDeG9x9ZBr3B6Kht6RhJMI46A==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/15] dt-bindings: memory: tegra: Document #reset-cells property of the Tegra30 MC
Date: Mon,  9 Apr 2018 22:28:24 +0300
Message-Id: <9efb02bebbb192696d2833eb78c920d774faa2f9.1523301400.git.digetx@gmail.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <cover.1523301400.git.digetx@gmail.com>
References: <cover.1523301400.git.digetx@gmail.com>
In-Reply-To: <cover.1523301400.git.digetx@gmail.com>
References: <cover.1523301400.git.digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory Controller has a memory client "hot reset" functionality, which
resets the DMA interface of a memory client. So MC is a reset controller
in addition to IOMMU.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/memory-controllers/nvidia,tegra30-mc.txt     | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.txt b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.txt
index 14968b048cd3..a878b5908a4d 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.txt
@@ -12,6 +12,9 @@ Required properties:
 - clock-names: Must include the following entries:
   - mc: the module's clock input
 - interrupts: The interrupt outputs from the controller.
+- #reset-cells : Should be 1. This cell represents memory client module ID.
+  The assignments may be found in header file <dt-bindings/memory/tegra30-mc.h>
+  or in the TRM documentation.
 
 Required properties for Tegra30, Tegra114, Tegra124, Tegra132 and Tegra210:
 - #iommu-cells: Should be 1. The single cell of the IOMMU specifier defines
@@ -72,12 +75,14 @@ Example SoC include file:
 		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
 
 		#iommu-cells = <1>;
+		#reset-cells = <1>;
 	};
 
 	sdhci@700b0000 {
 		compatible = "nvidia,tegra124-sdhci";
 		...
 		iommus = <&mc TEGRA_SWGROUP_SDMMC1A>;
+		resets = <&mc TEGRA124_MC_RESET_SDMMC1>;
 	};
 };
 
-- 
2.16.3
