Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946631AbeCBOEv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 09:04:51 -0500
Received: from albert.telenet-ops.be ([195.130.137.90]:51050 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1425223AbeCBOEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 09:04:50 -0500
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Dinh Nguyen <dinguyen@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] ARM: socfpga: PM: Drop useless check for PM_SUSPEND_STANDBY
Date: Fri,  2 Mar 2018 15:04:47 +0100
Message-Id: <1519999487-15474-1-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As SoCFPGA uses the standard suspend_valid_only_mem() for its
platform_suspend_ops.valid() callback, its platform_suspend_ops.enter()
callback will never be called with state equal to PM_SUSPEND_STANDBY.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Tony Lindgren <tony@atomide.com>
Acked-by: Dinh Nguyen <dinguyen@kernel.org>
---
v2:
  - Add Acked-by.
---
 arch/arm/mach-socfpga/pm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-socfpga/pm.c b/arch/arm/mach-socfpga/pm.c
index c378ab0c24317ccf..d4866788702cb87a 100644
--- a/arch/arm/mach-socfpga/pm.c
+++ b/arch/arm/mach-socfpga/pm.c
@@ -116,7 +116,6 @@ static int socfpga_pm_suspend(unsigned long arg)
 static int socfpga_pm_enter(suspend_state_t state)
 {
 	switch (state) {
-	case PM_SUSPEND_STANDBY:
 	case PM_SUSPEND_MEM:
 		outer_disable();
 		cpu_suspend(0, socfpga_pm_suspend);
-- 
2.7.4
