Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752398AbeBTPN2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 10:13:28 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:49125 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752364AbeBTPN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 10:13:27 -0500
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: geert@linux-m68k.org, horms@verge.net.au, magnus.damm@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/19] soc: renesas: rcar-rst: Add support for R-Car M3-N
Date: Tue, 20 Feb 2018 16:12:04 +0100
Message-Id: <1519139541-18783-3-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519139541-18783-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1519139541-18783-1-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 Documentation/devicetree/bindings/reset/renesas,rst.txt | 1 +
 drivers/soc/renesas/Kconfig                             | 4 ++--
 drivers/soc/renesas/rcar-rst.c                          | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/reset/renesas,rst.txt b/Documentation/devicetree/bindings/reset/renesas,rst.txt
index a55b886..294a0da 100644
--- a/Documentation/devicetree/bindings/reset/renesas,rst.txt
+++ b/Documentation/devicetree/bindings/reset/renesas,rst.txt
@@ -26,6 +26,7 @@ Required properties:
 		  - "renesas,r8a7794-rst" (R-Car E2)
 		  - "renesas,r8a7795-rst" (R-Car H3)
 		  - "renesas,r8a7796-rst" (R-Car M3-W)
+		  - "renesas,r8a77965-rst" (R-Car M3-N)
 		  - "renesas,r8a77970-rst" (R-Car V3M)
 		  - "renesas,r8a77980-rst" (R-Car V3H)
 		  - "renesas,r8a77995-rst" (R-Car D3)
diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index 6efd7be..741b7cd 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -3,8 +3,8 @@ config SOC_RENESAS
 	default y if ARCH_RENESAS
 	select SOC_BUS
 	select RST_RCAR if ARCH_RCAR_GEN1 || ARCH_RCAR_GEN2 || \
-			   ARCH_R8A7795 || ARCH_R8A7796 || ARCH_R8A77970 || \
-			   ARCH_R8A77980 || ARCH_R8A77995
+			   ARCH_R8A7795 || ARCH_R8A7796 || ARCH_R8A77965 || \
+			   ARCH_R8A77970 || ARCH_R8A77980 || ARCH_R8A77995
 	select SYSC_R8A7743 if ARCH_R8A7743
 	select SYSC_R8A7745 if ARCH_R8A7745
 	select SYSC_R8A7779 if ARCH_R8A7779
diff --git a/drivers/soc/renesas/rcar-rst.c b/drivers/soc/renesas/rcar-rst.c
index e2340eb..33060f2 100644
--- a/drivers/soc/renesas/rcar-rst.c
+++ b/drivers/soc/renesas/rcar-rst.c
@@ -41,6 +41,7 @@ static const struct of_device_id rcar_rst_matches[] __initconst = {
 	/* R-Car Gen3 is handled like R-Car Gen2 */
 	{ .compatible = "renesas,r8a7795-rst", .data = &rcar_rst_gen2 },
 	{ .compatible = "renesas,r8a7796-rst", .data = &rcar_rst_gen2 },
+	{ .compatible = "renesas,r8a77965-rst", .data = &rcar_rst_gen2 },
 	{ .compatible = "renesas,r8a77970-rst", .data = &rcar_rst_gen2 },
 	{ .compatible = "renesas,r8a77980-rst", .data = &rcar_rst_gen2 },
 	{ .compatible = "renesas,r8a77995-rst", .data = &rcar_rst_gen2 },
-- 
2.7.4
