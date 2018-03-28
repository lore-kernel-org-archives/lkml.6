Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753102AbeC1RBc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 13:01:32 -0400
Received: from esa7.dell-outbound.iphmx.com ([68.232.153.96]:27321 "EHLO
        esa7.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752399AbeC1RBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 13:01:30 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2H0AAC1ybtamMmZ6ERdGgEBAQEBAgEBA?=
 =?us-ascii?q?QEIAQEBAYURKJhdgwOSSoF6C4F6gwoChA0hNRcBAgEBAQEBAQIBAhABAQEBAQg?=
 =?us-ascii?q?LCwYoL4I4IoJNBnkQPxJXBhOFDq4OiEaCKYdegVQ/iEgbhXAChwSFTIpjCIFfj?=
 =?us-ascii?q?EkCjC+CJo1RgSUeAYIIcIMSgi6OPVGNKoJGAQE?=
X-IPAS-Result: =?us-ascii?q?A2H0AAC1ybtamMmZ6ERdGgEBAQEBAgEBAQEIAQEBAYURKJh?=
 =?us-ascii?q?dgwOSSoF6C4F6gwoChA0hNRcBAgEBAQEBAQIBAhABAQEBAQgLCwYoL4I4IoJNB?=
 =?us-ascii?q?nkQPxJXBhOFDq4OiEaCKYdegVQ/iEgbhXAChwSFTIpjCIFfjEkCjC+CJo1RgSU?=
 =?us-ascii?q?eAYIIcIMSgi6OPVGNKoJGAQE?=
X-LoopCount0: from 10.208.86.39
X-IronPort-AV: E=Sophos;i="5.48,372,1517896800";
   d="scan'208";a="637271540"
X-DLP: DLP_GlobalPCIDSS
From: Mario Limonciello <mario.limonciello@dell.com>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@dell.com>
Subject: [PATCH v3 2/2] power/hibernate: Change message when writing to /sys/power/resume
Date: Wed, 28 Mar 2018 12:01:10 -0500
Message-Id: <1522256470-2825-2-git-send-email-mario.limonciello@dell.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522256470-2825-1-git-send-email-mario.limonciello@dell.com>
References: <1522256470-2825-1-git-send-email-mario.limonciello@dell.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file is used both for setting the wakeup device without kernel
command line as well as for actually waking the system (when appropriate
swap header is in place).

To avoid confusion on incorrect logs in system log downgrade the
message to debug and make it clearer.

Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
---
 kernel/power/hibernate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index d58fad3d..1028ecb 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -1053,7 +1053,7 @@ static ssize_t resume_store(struct kobject *kobj, struct kobj_attribute *attr,
 	lock_system_sleep();
 	swsusp_resume_device = res;
 	unlock_system_sleep();
-	pr_info("Starting manual resume from disk\n");
+	pm_pr_dbg("Configured resume from disk to %u\n", swsusp_resume_device);
 	noresume = 0;
 	software_resume();
 	return n;
-- 
2.7.4
