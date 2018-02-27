Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751729AbeB0SXN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 13:23:13 -0500
Received: from esa3.dell-outbound.iphmx.com ([68.232.153.94]:39198 "EHLO
        esa3.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751654AbeB0SXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 13:23:11 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GKAAAFoZVamMuZ6EReGQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQcBAQEBAYUmKJt1gxiWPwqFMoJOWBQBAgEBAQEBAQIBAhABAQEBAQYNCwY?=
 =?us-ascii?q?oL4I4JAGCdVJPbwEShRWuETqIcIJIh0qBV5AjBY1ydItoCYILjmYCjnKRUIEuN?=
 =?us-ascii?q?YFzcE+CQ4FzAUwDEAyCGliMUgEBAQ?=
X-IPAS-Result: =?us-ascii?q?A2GKAAAFoZVamMuZ6EReGQEBAQEBAQEBAQEBAQcBAQEBAYU?=
 =?us-ascii?q?mKJt1gxiWPwqFMoJOWBQBAgEBAQEBAQIBAhABAQEBAQYNCwYoL4I4JAGCdVJPb?=
 =?us-ascii?q?wEShRWuETqIcIJIh0qBV5AjBY1ydItoCYILjmYCjnKRUIEuNYFzcE+CQ4FzAUw?=
 =?us-ascii?q?DEAyCGliMUgEBAQ?=
X-LoopCount0: from 10.208.86.39
X-IronPort-AV: E=Sophos;i="5.47,402,1515477600";
   d="scan'208";a="140764454"
X-DLP: DLP_GlobalPCIDSS
From: Mario Limonciello <mario.limonciello@dell.com>
To: dvhart@infradead.org, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: pali.rohar@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Mario Limonciello <mario.limonciello@dell.com>
Subject: [PATCH v3 1/3] platform/x86: dell-smbios: Correct some style warnings
Date: Tue, 27 Feb 2018 12:23:02 -0600
Message-Id: <1519755784-2155-1-git-send-email-mario.limonciello@dell.com>
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
 drivers/platform/x86/dell-smbios.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/dell-smbios.c b/drivers/platform/x86/dell-smbios.c
index 8541cde..76b9d75 100644
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
@@ -352,8 +352,10 @@ static void __init parse_da_table(const struct dmi_header *dm)
 	struct calling_interface_structure *table =
 		container_of(dm, struct calling_interface_structure, header);
 
-	/* 4 bytes of table header, plus 7 bytes of Dell header, plus at least
-	   6 bytes of entry */
+	/*
+	 * 4 bytes of table header, plus 7 bytes of Dell header
+	 * plus at least 6 bytes of entry
+	 */
 
 	if (dm->length < 17)
 		return;
-- 
2.7.4
