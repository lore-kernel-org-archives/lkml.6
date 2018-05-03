Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751174AbeECNN4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 09:13:56 -0400
Received: from mx1.unisoc.com ([222.66.158.135]:13463 "EHLO SHSQR01.unisoc.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751120AbeECNNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 09:13:55 -0400
From: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
CC: <linux-kernel@vger.kernel.org>,
        Baolin Wang <baolin.wang@spreadtrum.com>,
        Orson Zhai <orson.zhai@spreadtrum.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@spreadtrum.com>
Subject: [PATCH] clocksource/drivers/sprd: Fix Kconfig dependency
Date: Thu, 3 May 2018 20:27:32 +0800
Message-ID: <1525350452-14433-1-git-send-email-chunyan.zhang@spreadtrum.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.93.106]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL: SHSQR01.spreadtrum.com w43CRSDc017287
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPRD arch doesn't select SPRD_TIMER, so this config would not
appear even if ARCH_SPRD is set and COMPILE_TEST is not.

Fix the Kconfig selection rule by letting the SPRD arch to select.

This patch also sets the default value of SPRD_TIMER with ARCH_SPRD,
but it still is selectable to users.

Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
---
 drivers/clocksource/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 619b120..c89e4d6 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -468,8 +468,9 @@ config MTK_TIMER
 	  Support for Mediatek timer driver.
 
 config SPRD_TIMER
-	bool "Spreadtrum timer driver" if COMPILE_TEST
-	depends on HAS_IOMEM
+	bool "Spreadtrum timer driver"
+	depends on HAS_IOMEM && (ARCH_SPRD || COMPILE_TEST)
+	default ARCH_SPRD
 	select TIMER_OF
 	help
 	  Enables support for the Spreadtrum timer driver.
-- 
2.7.4
