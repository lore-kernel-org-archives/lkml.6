Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935701AbeE3DRz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 23:17:55 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38990 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935703AbeE3DRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 23:17:44 -0400
X-Google-Smtp-Source: ADUXVKI0Xg2EwvX+XjbDvKmFic1cEK3lMzF0iYSAW/ALE4XQAPQfGmmoUZrveku5Q5qkGO5xYuN6Pw==
From: Fabien Parent <fparent@baylibre.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        eballetbo@gmail.com, gpain@baylibre.com,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 1/3] mfd: cros: add charger port count command definition
Date: Tue, 29 May 2018 20:17:02 -0700
Message-Id: <20180530031704.18597-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180530031704.18597-1-fparent@baylibre.com>
References: <20180530031704.18597-1-fparent@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A new more command has been added to the ChromeOS embedded controller
that allows to get the number of charger port count. Unlike
EC_CMD_USB_PD_PORTS, this new command also includes the dedicated
port if present.

This command will be used to expose the dedicated charger port
in the ChromeOS charger driver.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 include/linux/mfd/cros_ec_commands.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 0d926492ac3a..e3187f8bdb7e 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -3005,6 +3005,16 @@ struct ec_params_usb_pd_info_request {
 	uint8_t port;
 } __packed;
 
+/*
+ * This command will return the number of USB PD charge port + the number
+ * of dedicated port present.
+ * EC_CMD_USB_PD_PORTS does NOT include the dedicated ports
+ */
+#define EC_CMD_CHARGE_PORT_COUNT 0x0105
+struct ec_response_charge_port_count {
+	uint8_t port_count;
+} __packed;
+
 /* Read USB-PD Device discovery info */
 #define EC_CMD_USB_PD_DISCOVERY 0x0113
 struct ec_params_usb_pd_discovery_entry {
-- 
2.17.0
