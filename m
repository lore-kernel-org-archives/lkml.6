Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751849AbeCIKQJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 05:16:09 -0500
Received: from terminus.zytor.com ([198.137.202.136]:43705 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751741AbeCIKQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 05:16:07 -0500
Date: Fri, 9 Mar 2018 02:15:55 -0800
From: tip-bot for Masahiro Yamada <tipbot@zytor.com>
Message-ID: <tip-bd2746f09e1d8e37164f53b846f5225f3d36ee2d@git.kernel.org>
Cc: tglx@linutronix.de, mingo@kernel.org, daniel.lezcano@linaro.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, arnd@arndb.de,
        yamada.masahiro@socionext.com
Reply-To: tglx@linutronix.de, mingo@kernel.org, daniel.lezcano@linaro.org,
        hpa@zytor.com, yamada.masahiro@socionext.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org
In-Reply-To: <1520335233-11277-1-git-send-email-yamada.masahiro@socionext.com>
References: <1520335233-11277-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:timers/urgent] clocksource/atmel-st: Add 'depends on
 HAS_IOMEM' to fix unmet dependency
Git-Commit-ID: bd2746f09e1d8e37164f53b846f5225f3d36ee2d
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  bd2746f09e1d8e37164f53b846f5225f3d36ee2d
Gitweb:     https://git.kernel.org/tip/bd2746f09e1d8e37164f53b846f5225f3d36ee2d
Author:     Masahiro Yamada <yamada.masahiro@socionext.com>
AuthorDate: Tue, 6 Mar 2018 20:20:33 +0900
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 9 Mar 2018 11:11:58 +0100

clocksource/atmel-st: Add 'depends on HAS_IOMEM' to fix unmet dependency

The ATMEL_ST config selects MFD_SYSCON, but does not depend on HAS_IOMEM.

Compile testing on architecture without HAS_IOMEM causes "unmet direct
dependencies" in Kconfig phase. Detected by "make ARCH=score allyesconfig".

Add the proper dependency to the ATMEL_ST config.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Link: https://lkml.kernel.org/r/1520335233-11277-1-git-send-email-yamada.masahiro@socionext.com

---
 drivers/clocksource/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index b3b4ed9b6874..d2e5382821a4 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -386,6 +386,7 @@ config ATMEL_PIT
 
 config ATMEL_ST
 	bool "Atmel ST timer support" if COMPILE_TEST
+	depends on HAS_IOMEM
 	select TIMER_OF
 	select MFD_SYSCON
 	help
