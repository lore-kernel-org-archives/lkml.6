Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933680AbeCEKZo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 05:25:44 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39221 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933576AbeCEKZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 05:25:35 -0500
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Shawn Guo <shawnguo@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH v6 3/6] kernel/reboot.c: export pm_power_off_prepare
Date: Mon,  5 Mar 2018 11:25:20 +0100
Message-Id: <20180305102524.5905-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180305102524.5905-1-o.rempel@pengutronix.de>
References: <20180305102524.5905-1-o.rempel@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export pm_power_off_prepare. It is needed to implement power off on
Freescale/NXP iMX6 based boards with external power management
integrated circuit (PMIC).

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 kernel/reboot.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index e4ced883d8de..350be6baa60d 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -49,6 +49,7 @@ int reboot_force;
  */
 
 void (*pm_power_off_prepare)(void);
+EXPORT_SYMBOL(pm_power_off_prepare);
 
 /**
  *	emergency_restart - reboot the system
-- 
2.16.1
