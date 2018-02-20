Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932388AbeBTBoL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 20:44:11 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:37154 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932294AbeBTBoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 20:44:07 -0500
X-Google-Smtp-Source: AH8x225cLBJpKfcBClaY4Sythn6sXx63YCHBxQby86P1ADxZEVvHp9xeetNO+lQOb8IWywIinECKQQ==
From: Joel Stanley <joel@jms.id.au>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andrew Jeffery <andrew@aj.id.au>
Cc: Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org
Subject: [PATCH v2 3/3] reset: simple: Allow user selection of driver
Date: Tue, 20 Feb 2018 12:13:30 +1030
Message-Id: <20180220014330.23425-4-joel@jms.id.au>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180220014330.23425-1-joel@jms.id.au>
References: <20180220014330.23425-1-joel@jms.id.au>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently this driver is only user selectable if COMPILE_TEST is turned
on. Users may wish to select (and deselect) it, so remove this
restriction.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/reset/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 18f152d251d7..7490a4370900 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -82,7 +82,7 @@ config RESET_PISTACHIO
 	  This enables the reset driver for ImgTec Pistachio SoCs.
 
 config RESET_SIMPLE
-	bool "Simple Reset Controller Driver" if COMPILE_TEST
+	bool "Simple Reset Controller Driver"
 	default ARCH_SOCFPGA || ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX || ARCH_ASPEED
 	help
 	  This enables a simple reset controller driver for reset lines that
-- 
2.15.1
