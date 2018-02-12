Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933305AbeBLWvY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:51:24 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:37598 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933077AbeBLWss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:48:48 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 41/45] rtc: tx4939: remove arch/mips dependency
Date: Mon, 12 Feb 2018 23:47:55 +0100
Message-Id: <20180212224759.15999-42-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
References: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Copy RTC definitions from arch/mips/include/asm/txx9/tx4939.h to the RTC
driver so it doesn't depend on arch/mips anymore.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-tx4939.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-tx4939.c b/drivers/rtc/rtc-tx4939.c
index 560d9a5e0225..1f4013d8ae7b 100644
--- a/drivers/rtc/rtc-tx4939.c
+++ b/drivers/rtc/rtc-tx4939.c
@@ -14,7 +14,30 @@
 #include <linux/module.h>
 #include <linux/io.h>
 #include <linux/gfp.h>
-#include <asm/txx9/tx4939.h>
+
+#define TX4939_RTCCTL_ALME	0x00000080
+#define TX4939_RTCCTL_ALMD	0x00000040
+#define TX4939_RTCCTL_BUSY	0x00000020
+
+#define TX4939_RTCCTL_COMMAND	0x00000007
+#define TX4939_RTCCTL_COMMAND_NOP	0x00000000
+#define TX4939_RTCCTL_COMMAND_GETTIME	0x00000001
+#define TX4939_RTCCTL_COMMAND_SETTIME	0x00000002
+#define TX4939_RTCCTL_COMMAND_GETALARM	0x00000003
+#define TX4939_RTCCTL_COMMAND_SETALARM	0x00000004
+
+#define TX4939_RTCTBC_PM	0x00000080
+#define TX4939_RTCTBC_COMP	0x0000007f
+
+#define TX4939_RTC_REG_RAMSIZE	0x00000100
+#define TX4939_RTC_REG_RWBSIZE	0x00000006
+
+struct tx4939_rtc_reg {
+	__u32 ctl;
+	__u32 adr;
+	__u32 dat;
+	__u32 tbc;
+};
 
 struct tx4939rtc_plat_data {
 	struct rtc_device *rtc;
-- 
2.16.1
