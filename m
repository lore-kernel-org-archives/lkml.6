Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751544AbeBZXVW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 18:21:22 -0500
Received: from mail-ot0-f196.google.com ([74.125.82.196]:44687 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751079AbeBZXVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 18:21:21 -0500
X-Google-Smtp-Source: AH8x227Slax9EG627D4nRUdGifospJlbfWFPDqDZdU1tPW+b4R2hYFyYYzcLR+JFXtYiGuQi/79dqA==
From: Guenter Roeck <linux@roeck-us.net>
To: "David S . Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>, Kees Cook <keescook@chromium.org>
Subject: [PATCH] sparc64: Oracle DAX driver depends on SPARC64
Date: Mon, 26 Feb 2018 15:21:18 -0800
Message-Id: <1519687278-9785-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sparc:allmodconfig fails to build as follows.

ERROR: "mdesc_release" [drivers/sbus/char/oradax.ko] undefined!
ERROR: "sun4v_hvapi_register" [drivers/sbus/char/oradax.ko] undefined!
ERROR: "mdesc_get_property" [drivers/sbus/char/oradax.ko] undefined!
ERROR: "mdesc_node_by_name" [drivers/sbus/char/oradax.ko] undefined!
ERROR: "mdesc_grab" [drivers/sbus/char/oradax.ko] undefined!
ERROR: "sun4v_ccb_info" [drivers/sbus/char/oradax.ko] undefined!
ERROR: "sun4v_ccb_submit" [drivers/sbus/char/oradax.ko] undefined!
ERROR: "sun4v_ccb_kill" [drivers/sbus/char/oradax.ko] undefined!

The symbols are only available with SPARC64 builds, thus the driver
depends on it.

Fixes: dd0273284c74 ("sparc64: Oracle DAX driver")
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/sbus/char/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/sbus/char/Kconfig b/drivers/sbus/char/Kconfig
index a785aa7660c3..bf3c5f735614 100644
--- a/drivers/sbus/char/Kconfig
+++ b/drivers/sbus/char/Kconfig
@@ -72,7 +72,8 @@ config DISPLAY7SEG
 
 config ORACLE_DAX
 	tristate "Oracle Data Analytics Accelerator"
-	default m if SPARC64
+	depends on SPARC64
+	default m
 	help
 	 Driver for Oracle Data Analytics Accelerator, which is
 	 a coprocessor that performs database operations in hardware.
-- 
2.7.4
