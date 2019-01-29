Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F16C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2DD72082E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbfA2JjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:39:05 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:32864 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728320AbfA2Jii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 04:38:38 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id D08D8276325
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     groeck@chromium.org, gwendal@chromium.org, kernel@collabora.com,
        bleung@chromium.org
Subject: [PATCH v3 07/12] platform/chrome: cros_ec_lpc: switch to SPDX identifier
Date:   Tue, 29 Jan 2019 10:38:18 +0100
Message-Id: <20190129093823.27137-8-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129093823.27137-1-enric.balletbo@collabora.com>
References: <20190129093823.27137-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adopt the SPDX license identifier headers to ease license compliance
management. Also remove the license boiler-plate and redundant driver
description.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Guenter Roeck <groeck@chromium.org>
---

Changes in v3: None
Changes in v2: None

 drivers/platform/chrome/cros_ec_lpc.c     | 34 ++++++++---------------
 drivers/platform/chrome/cros_ec_lpc_mec.c | 26 +++--------------
 drivers/platform/chrome/cros_ec_lpc_mec.h | 20 ++-----------
 drivers/platform/chrome/cros_ec_lpc_reg.c | 26 +++--------------
 drivers/platform/chrome/cros_ec_lpc_reg.h | 20 ++-----------
 5 files changed, 24 insertions(+), 102 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index 14684a56e40f..c9c240fbe7c6 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -1,25 +1,15 @@
-/*
- * cros_ec_lpc - LPC access to the Chrome OS Embedded Controller
- *
- * Copyright (C) 2012-2015 Google, Inc
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * This driver uses the Chrome OS EC byte-level message-based protocol for
- * communicating the keyboard state (which keys are pressed) from a keyboard EC
- * to the AP over some bus (such as i2c, lpc, spi).  The EC does debouncing,
- * but everything else (including deghosting) is done here.  The main
- * motivation for this is to keep the EC firmware as simple as possible, since
- * it cannot be easily upgraded and EC flash/IRAM space is relatively
- * expensive.
- */
+// SPDX-License-Identifier: GPL-2.0
+// LPC interface for ChromeOS Embedded Controller
+//
+// Copyright (C) 2012-2015 Google, Inc
+//
+// This driver uses the ChromeOS EC byte-level message-based protocol for
+// communicating the keyboard state (which keys are pressed) from a keyboard EC
+// to the AP over some bus (such as i2c, lpc, spi).  The EC does debouncing,
+// but everything else (including deghosting) is done here.  The main
+// motivation for this is to keep the EC firmware as simple as possible, since
+// it cannot be easily upgraded and EC flash/IRAM space is relatively
+// expensive.
 
 #include <linux/acpi.h>
 #include <linux/dmi.h>
diff --git a/drivers/platform/chrome/cros_ec_lpc_mec.c b/drivers/platform/chrome/cros_ec_lpc_mec.c
index c4edfa83e493..296554a82b83 100644
--- a/drivers/platform/chrome/cros_ec_lpc_mec.c
+++ b/drivers/platform/chrome/cros_ec_lpc_mec.c
@@ -1,25 +1,7 @@
-/*
- * cros_ec_lpc_mec - LPC variant I/O for Microchip EC
- *
- * Copyright (C) 2016 Google, Inc
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * This driver uses the Chrome OS EC byte-level message-based protocol for
- * communicating the keyboard state (which keys are pressed) from a keyboard EC
- * to the AP over some bus (such as i2c, lpc, spi).  The EC does debouncing,
- * but everything else (including deghosting) is done here.  The main
- * motivation for this is to keep the EC firmware as simple as possible, since
- * it cannot be easily upgraded and EC flash/IRAM space is relatively
- * expensive.
- */
+// SPDX-License-Identifier: GPL-2.0
+// LPC variant I/O for Microchip EC
+//
+// Copyright (C) 2016 Google, Inc
 
 #include <linux/delay.h>
 #include <linux/io.h>
diff --git a/drivers/platform/chrome/cros_ec_lpc_mec.h b/drivers/platform/chrome/cros_ec_lpc_mec.h
index 105068c0e919..68b381f2eb50 100644
--- a/drivers/platform/chrome/cros_ec_lpc_mec.h
+++ b/drivers/platform/chrome/cros_ec_lpc_mec.h
@@ -1,24 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
- * cros_ec_lpc_mec - LPC variant I/O for Microchip EC
+ * LPC variant I/O for Microchip EC
  *
  * Copyright (C) 2016 Google, Inc
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * This driver uses the Chrome OS EC byte-level message-based protocol for
- * communicating the keyboard state (which keys are pressed) from a keyboard EC
- * to the AP over some bus (such as i2c, lpc, spi).  The EC does debouncing,
- * but everything else (including deghosting) is done here.  The main
- * motivation for this is to keep the EC firmware as simple as possible, since
- * it cannot be easily upgraded and EC flash/IRAM space is relatively
- * expensive.
  */
 
 #ifndef __CROS_EC_LPC_MEC_H
diff --git a/drivers/platform/chrome/cros_ec_lpc_reg.c b/drivers/platform/chrome/cros_ec_lpc_reg.c
index fc23d535c404..72fc3f6bff90 100644
--- a/drivers/platform/chrome/cros_ec_lpc_reg.c
+++ b/drivers/platform/chrome/cros_ec_lpc_reg.c
@@ -1,25 +1,7 @@
-/*
- * cros_ec_lpc_reg - LPC access to the Chrome OS Embedded Controller
- *
- * Copyright (C) 2016 Google, Inc
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * This driver uses the Chrome OS EC byte-level message-based protocol for
- * communicating the keyboard state (which keys are pressed) from a keyboard EC
- * to the AP over some bus (such as i2c, lpc, spi).  The EC does debouncing,
- * but everything else (including deghosting) is done here.  The main
- * motivation for this is to keep the EC firmware as simple as possible, since
- * it cannot be easily upgraded and EC flash/IRAM space is relatively
- * expensive.
- */
+// SPDX-License-Identifier: GPL-2.0
+// LPC interface for ChromeOS Embedded Controller
+//
+// Copyright (C) 2016 Google, Inc
 
 #include <linux/io.h>
 #include <linux/mfd/cros_ec.h>
diff --git a/drivers/platform/chrome/cros_ec_lpc_reg.h b/drivers/platform/chrome/cros_ec_lpc_reg.h
index 1c12c38b306a..416fd2572182 100644
--- a/drivers/platform/chrome/cros_ec_lpc_reg.h
+++ b/drivers/platform/chrome/cros_ec_lpc_reg.h
@@ -1,24 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
- * cros_ec_lpc_reg - LPC access to the Chrome OS Embedded Controller
+ * LPC interface for ChromeOS Embedded Controller
  *
  * Copyright (C) 2016 Google, Inc
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * This driver uses the Chrome OS EC byte-level message-based protocol for
- * communicating the keyboard state (which keys are pressed) from a keyboard EC
- * to the AP over some bus (such as i2c, lpc, spi).  The EC does debouncing,
- * but everything else (including deghosting) is done here.  The main
- * motivation for this is to keep the EC firmware as simple as possible, since
- * it cannot be easily upgraded and EC flash/IRAM space is relatively
- * expensive.
  */
 
 #ifndef __CROS_EC_LPC_REG_H
-- 
2.20.1

