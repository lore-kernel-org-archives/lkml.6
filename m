Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751585AbeBUXl7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 18:41:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:33244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751426AbeBUXlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 18:41:14 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57CE221785
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
From: James Hogan <jhogan@kernel.org>
To: linux-metag@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, James Hogan <jhogan@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org
Subject: [PATCH 11/13] watchdog: imgpdc: Drop METAG dependency
Date: Wed, 21 Feb 2018 23:38:23 +0000
Message-Id: <20180221233825.10024-12-jhogan@kernel.org>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180221233825.10024-1-jhogan@kernel.org>
References: <20180221233825.10024-1-jhogan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that arch/metag/ has been removed, remove the METAG dependency from
the IMG IR device driver. The hardware is also present on MIPS SoCs so
the driver still has value.

Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org
Cc: linux-metag@vger.kernel.org
---
 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index aff773bcebdb..152268010c45 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1602,7 +1602,7 @@ config BCM7038_WDT
 config IMGPDC_WDT
 	tristate "Imagination Technologies PDC Watchdog Timer"
 	depends on HAS_IOMEM
-	depends on METAG || MIPS || COMPILE_TEST
+	depends on MIPS || COMPILE_TEST
 	select WATCHDOG_CORE
 	help
 	  Driver for Imagination Technologies PowerDown Controller
-- 
2.13.6
