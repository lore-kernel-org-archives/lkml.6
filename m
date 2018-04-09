Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754109AbeDITb3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 15:31:29 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40760 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752939AbeDIT3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 15:29:53 -0400
X-Google-Smtp-Source: AIpwx48BQC40sF/u/dq4QuXDmuidk+Ob79PylWA7yo+hSKVWE5pCyJG9cOLt0zHpBqPdjiJSsGNEnw==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 03/15] dt-bindings: arm: tegra: Document #reset-cells property of the Tegra20 MC
Date: Mon,  9 Apr 2018 22:28:25 +0300
Message-Id: <57c08ef0d2e3dbc6ad0e91f426c5db5b181b0ab9.1523301400.git.digetx@gmail.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <cover.1523301400.git.digetx@gmail.com>
References: <cover.1523301400.git.digetx@gmail.com>
In-Reply-To: <cover.1523301400.git.digetx@gmail.com>
References: <cover.1523301400.git.digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory Controller has a memory client "hot reset" functionality, which
resets the DMA interface of a memory client, so MC is a reset controller.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/tegra/nvidia,tegra20-mc.txt      | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-mc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-mc.txt
index f9632bacbd04..7d60a50a4fa1 100644
--- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-mc.txt
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-mc.txt
@@ -6,11 +6,21 @@ Required properties:
   example below. Note that the MC registers are interleaved with the
   GART registers, and hence must be represented as multiple ranges.
 - interrupts : Should contain MC General interrupt.
+- #reset-cells : Should be 1. This cell represents memory client module ID.
+  The assignments may be found in header file <dt-bindings/memory/tegra20-mc.h>
+  or in the TRM documentation.
 
 Example:
-	memory-controller@7000f000 {
+	mc: memory-controller@7000f000 {
 		compatible = "nvidia,tegra20-mc";
 		reg = <0x7000f000 0x024
 		       0x7000f03c 0x3c4>;
 		interrupts = <0 77 0x04>;
+		#reset-cells = <1>;
+	};
+
+	video-codec@6001a000 {
+		compatible = "nvidia,tegra20-vde";
+		...
+		resets = <&mc TEGRA20_MC_RESET_VDE>;
 	};
-- 
2.16.3
