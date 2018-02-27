Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932253AbeB0P5F (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 10:57:05 -0500
Received: from esa2.dell-outbound.iphmx.com ([68.232.149.220]:16540 "EHLO
        esa2.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932176AbeB0P5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 10:57:03 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GKAAAGf5Vahz+a6EReGQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQcBAQEBAYUmKJt1gxiWPwqFMoJOWBQBAgEBAQEBAQIBAhABAQEKCwkIKC+?=
 =?us-ascii?q?COCQBgnVST28BEoUVrSA6iHCCFDKHSoFXkCMFjXJ0i2gJgguOZgKOcpFQgS41g?=
 =?us-ascii?q?XNwT4JDgXMBTAMQDIIaWIxSAQEB?=
X-IPAS-Result: =?us-ascii?q?A2GKAAAGf5Vahz+a6EReGQEBAQEBAQEBAQEBAQcBAQEBAYU?=
 =?us-ascii?q?mKJt1gxiWPwqFMoJOWBQBAgEBAQEBAQIBAhABAQEKCwkIKC+COCQBgnVST28BE?=
 =?us-ascii?q?oUVrSA6iHCCFDKHSoFXkCMFjXJ0i2gJgguOZgKOcpFQgS41gXNwT4JDgXMBTAM?=
 =?us-ascii?q?QDIIaWIxSAQEB?=
X-LoopCount0: from 10.208.86.39
X-IronPort-AV: E=Sophos;i="5.47,401,1515477600";
   d="scan'208";a="623642134"
X-DLP: DLP_GlobalPCIDSS
From: Mario Limonciello <mario.limonciello@dell.com>
To: dvhart@infradead.org, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: pali.rohar@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Mario Limonciello <mario.limonciello@dell.com>
Subject: [PATCH 1/3] platform/x86: dell-smbios: Correct some style warnings
Date: Tue, 27 Feb 2018 09:56:52 -0600
Message-Id: <1519747014-17561-1-git-send-email-mario.limonciello@dell.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING: function definition argument 'struct calling_interface_buffer *'
should also have an identifier name
+       int (*call_fn)(struct calling_interface_buffer *);

WARNING: Block comments use * on subsequent lines
+       /* 4 bytes of table header, plus 7 bytes of Dell header,
	plus at least
+          6 bytes of entry */

WARNING: Block comments use a trailing */ on a separate line
+          6 bytes of entry */

Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
---
 drivers/platform/x86/dell-smbios.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/dell-smbios.c b/drivers/platform/x86/dell-smbios.c
index 8541cde..4850658 100644
--- a/drivers/platform/x86/dell-smbios.c
+++ b/drivers/platform/x86/dell-smbios.c
@@ -36,7 +36,7 @@ static DEFINE_MUTEX(smbios_mutex);
 struct smbios_device {
 	struct list_head list;
 	struct device *device;
-	int (*call_fn)(struct calling_interface_buffer *);
+	int (*call_fn)(struct calling_interface_buffer *arg);
 };
 
 struct smbios_call {
@@ -353,7 +353,8 @@ static void __init parse_da_table(const struct dmi_header *dm)
 		container_of(dm, struct calling_interface_structure, header);
 
 	/* 4 bytes of table header, plus 7 bytes of Dell header, plus at least
-	   6 bytes of entry */
+	 * 6 bytes of entry
+	 */
 
 	if (dm->length < 17)
 		return;
-- 
2.7.4
