Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932369AbeBTBoB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 20:44:01 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:39512 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932294AbeBTBn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 20:43:59 -0500
X-Google-Smtp-Source: AH8x227d5YFRaGyJRRJIRGK9u8xqz+vHcc9QWNO+EkxYvu095YUnjjqLsZX0kENk488ir4tpJKqoRA==
From: Joel Stanley <joel@jms.id.au>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andrew Jeffery <andrew@aj.id.au>
Cc: Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org
Subject: [PATCH v2 2/3] reset: simple: Enable for ASPEED systems
Date: Tue, 20 Feb 2018 12:13:29 +1030
Message-Id: <20180220014330.23425-3-joel@jms.id.au>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180220014330.23425-1-joel@jms.id.au>
References: <20180220014330.23425-1-joel@jms.id.au>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ASPEED BMC SoCs have a reset controller in the LPC IP that can be
controlled using this driver to release the UARTs from reset.

No special configuration is required, so only the compatible string is
added.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/reset/Kconfig        | 10 +++++++---
 drivers/reset/reset-simple.c |  2 ++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 7fc77696bb1e..18f152d251d7 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -83,14 +83,18 @@ config RESET_PISTACHIO
 
 config RESET_SIMPLE
 	bool "Simple Reset Controller Driver" if COMPILE_TEST
-	default ARCH_SOCFPGA || ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX
+	default ARCH_SOCFPGA || ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX || ARCH_ASPEED
 	help
 	  This enables a simple reset controller driver for reset lines that
 	  that can be asserted and deasserted by toggling bits in a contiguous,
 	  exclusive register space.
 
-	  Currently this driver supports Altera SoCFPGAs, the RCC reset
-	  controller in STM32 MCUs, Allwinner SoCs, and ZTE's zx2967 family.
+	  Currently this driver supports:
+	   - Altera SoCFPGAs
+	   - ASPEED BMC SoCs
+	   - RCC reset controller in STM32 MCUs
+	   - Allwinner SoCs
+	   - ZTE's zx2967 family
 
 config RESET_SUNXI
 	bool "Allwinner SoCs Reset Driver" if COMPILE_TEST && !ARCH_SUNXI
diff --git a/drivers/reset/reset-simple.c b/drivers/reset/reset-simple.c
index 2d4f362ef025..f7ce8910a392 100644
--- a/drivers/reset/reset-simple.c
+++ b/drivers/reset/reset-simple.c
@@ -125,6 +125,8 @@ static const struct of_device_id reset_simple_dt_ids[] = {
 		.data = &reset_simple_active_low },
 	{ .compatible = "zte,zx296718-reset",
 		.data = &reset_simple_active_low },
+	{ .compatible = "aspeed,ast2400-lpc-reset" },
+	{ .compatible = "aspeed,ast2500-lpc-reset" },
 	{ /* sentinel */ },
 };
 
-- 
2.15.1
