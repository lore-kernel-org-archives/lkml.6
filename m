Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753239AbeBTQ3b (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 11:29:31 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:38698 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752815AbeBTQZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 11:25:49 -0500
X-Google-Smtp-Source: AH8x227Bq5//zL5I72DZaIv/Dn4XivMXGJvSMeCWz0hi7p2NtNFH5IUYB9RXX17ATzPs0c/dGD+d9Q==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/15] dt-bindings: memory: tegra: Document #reset-cells property of the Tegra30 MC
Date: Tue, 20 Feb 2018 19:25:15 +0300
Message-Id: <cc137269e617947fe6b80629cb439ff17eec38a6.1519141896.git.digetx@gmail.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <cover.1519141896.git.digetx@gmail.com>
References: <cover.1519141896.git.digetx@gmail.com>
In-Reply-To: <cover.1519141896.git.digetx@gmail.com>
References: <cover.1519141896.git.digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory Controller has a memory client "hot reset" functionality, which
resets the DMA interface of a memory client. So MC is a reset controller
in addition to IOMMU. Documentation the new property.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
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
2.16.1
