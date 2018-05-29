Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966139AbeE2S1D (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 14:27:03 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36493 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965993AbeE2S1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 14:27:01 -0400
X-Google-Smtp-Source: ADUXVKKZNP5Q0APWfraAAB8FgB4JWUCGcW6hVVPqEu4Apoj28SviwscOiWg4q2mRHz0vjQ9GpZBqnw==
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
        Chunyan Zhang <chunyan.zhang@spreadtrum.com>
Subject: [PATCH 1/7] clocksource/drivers/sprd: Fix Kconfig dependency
Date: Tue, 29 May 2018 20:26:36 +0200
Message-Id: <1527618402-31974-1-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1274a543-02dd-bbf0-c690-b08c788d9e91@linaro.org>
References: <1274a543-02dd-bbf0-c690-b08c788d9e91@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@spreadtrum.com>

SPRD arch doesn't select SPRD_TIMER, so this config would not
appear even if ARCH_SPRD is set but COMPILE_TEST not.

Fix the dependency of this config with SPRD arch, and set a
default value for it, also leave other choices for EXPERT.

Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
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
