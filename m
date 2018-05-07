Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752094AbeEGJIT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 05:08:19 -0400
Received: from sci-ig2.spreadtrum.com ([222.66.158.135]:25669 "EHLO
        SHSQR01.spreadtrum.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1751940AbeEGJIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 05:08:18 -0400
From: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
CC: <linux-kernel@vger.kernel.org>,
        Baolin Wang <baolin.wang@spreadtrum.com>,
        Orson Zhai <orson.zhai@spreadtrum.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@spreadtrum.com>
Subject: [PATCH V2] clocksource/drivers/sprd: Fix Kconfig dependency
Date: Mon, 7 May 2018 17:04:47 +0800
Message-ID: <1525683887-17584-1-git-send-email-chunyan.zhang@spreadtrum.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.93.106]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com w4794eXg093150
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPRD arch doesn't select SPRD_TIMER, so this config would not
appear even if ARCH_SPRD is set but COMPILE_TEST not.

Fix the dependency of this config with SPRD arch, and set a
default value for it, also leave other choices for EXPERT.

Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
---
 drivers/clocksource/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 8e8a097..dec0dd8 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -450,8 +450,10 @@ config MTK_TIMER
 	  Support for Mediatek timer driver.
 
 config SPRD_TIMER
-	bool "Spreadtrum timer driver" if COMPILE_TEST
+	bool "Spreadtrum timer driver" if EXPERT
 	depends on HAS_IOMEM
+	depends on (ARCH_SPRD || COMPILE_TEST)
+	default ARCH_SPRD
 	select TIMER_OF
 	help
 	  Enables support for the Spreadtrum timer driver.
-- 
2.7.4
