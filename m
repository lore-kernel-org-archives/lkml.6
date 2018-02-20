Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752895AbeBTQZx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 11:25:53 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:45491 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752856AbeBTQZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 11:25:50 -0500
X-Google-Smtp-Source: AH8x226r9EB2IpxTk4uj15x77QyP36MwKp54MlFXjBJbsW6EAkVVwMU2xucv7CBqVB+Lz8H+Jxb4NQ==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/15] dt-bindings: arm: tegra: Document #reset-cells property of the Tegra20 MC
Date: Tue, 20 Feb 2018 19:25:16 +0300
Message-Id: <c16e37ca23b7a3c53d121ba85889bb6f35576557.1519141896.git.digetx@gmail.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <cover.1519141896.git.digetx@gmail.com>
References: <cover.1519141896.git.digetx@gmail.com>
In-Reply-To: <cover.1519141896.git.digetx@gmail.com>
References: <cover.1519141896.git.digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory Controller has a memory client "hot reset" functionality, which
resets the DMA interface of a memory client, so MC is a reset controller.
Documentation the new property.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
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
2.16.1
