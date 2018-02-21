Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751343AbeBUWUh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 17:20:37 -0500
Received: from botnar.kaiser.cx ([176.28.20.183]:59484 "EHLO botnar.kaiser.cx"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751158AbeBUWUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 17:20:36 -0500
From: Martin Kaiser <martin@kaiser.cx>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH] ARM: mx35_3ds: remove unnecessary USB OTG init flag
Date: Wed, 21 Feb 2018 23:17:43 +0100
Message-Id: <1519251463-12318-1-git-send-email-martin@kaiser.cx>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The platform-specific init function for the USB OTG port,
mx35_3ds_otg_init(), sets the MXC_EHCI_INTERNAL_PHY flag.

This flag is applicable only to the host port, not to the OTG port. It's
ignored by mx35_initialize_usb_hw() when the OTG port is initialized.

Remove the flag to make it clear what is actually configured.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 arch/arm/mach-imx/mach-mx35_3ds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/mach-mx35_3ds.c b/arch/arm/mach-imx/mach-mx35_3ds.c
index 1c33a6c..f1963f2 100644
--- a/arch/arm/mach-imx/mach-mx35_3ds.c
+++ b/arch/arm/mach-imx/mach-mx35_3ds.c
@@ -407,7 +407,7 @@ static void __init imx35_3ds_init_mc13892(void)
 
 static int mx35_3ds_otg_init(struct platform_device *pdev)
 {
-	return mx35_initialize_usb_hw(pdev->id, MXC_EHCI_INTERNAL_PHY);
+	return mx35_initialize_usb_hw(pdev->id, 0);
 }
 
 /* OTG config */
-- 
2.1.4
