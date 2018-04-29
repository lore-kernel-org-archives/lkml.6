Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753866AbeD2QQw (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 12:16:52 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:47099 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753752AbeD2QQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 12:16:50 -0400
From: Guenter Roeck <linux@roeck-us.net>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Woods <brian.woods@amd.com>, Gabriel C <nix.or.die@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] hwmon: (k10temp) Add support for Stoney Ridge and Bristol Ridge CPUs
Date: Sun, 29 Apr 2018 09:16:45 -0700
Message-Id: <1525018605-22302-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Stoney Ridge and Bristol Ridge (Family 15h Model 0x70)
CPUs. Registers match those of Family 15h Model 0x60.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/k10temp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 34b5448b00be..f014e03eee5a 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -36,6 +36,10 @@ MODULE_PARM_DESC(force, "force loading on processors with erratum 319");
 /* Provide lock for writing to NB_SMU_IND_ADDR */
 static DEFINE_MUTEX(nb_smu_ind_mutex);
 
+#ifndef PCI_DEVICE_ID_AMD_15H_M70H_NB_F3
+#define PCI_DEVICE_ID_AMD_15H_M70H_NB_F3	0x15b3
+#endif
+
 #ifndef PCI_DEVICE_ID_AMD_17H_DF_F3
 #define PCI_DEVICE_ID_AMD_17H_DF_F3	0x1463
 #endif
@@ -319,6 +323,7 @@ static const struct pci_device_id k10temp_id_table[] = {
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_15H_M10H_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_15H_M30H_NB_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_15H_M60H_NB_F3) },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_15H_M70H_NB_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_16H_NB_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_16H_M30H_NB_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_DF_F3) },
-- 
2.7.4
