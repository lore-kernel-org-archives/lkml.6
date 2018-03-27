Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752118AbeC0U7O (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 16:59:14 -0400
Received: from esa3.dell-outbound.iphmx.com ([68.232.153.94]:65135 "EHLO
        esa3.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751179AbeC0U7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 16:59:01 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EpAQDbr7pah8uZ6ERdGwEBAgMBAQoBA?=
 =?us-ascii?q?YUTKJhygwOUVAuBeoMKAoQDITcVAQIBAQEBAQECAQIQAQEBCgsJCCgvgjgigk0?=
 =?us-ascii?q?GeRA/ElcGE4UOrhCIS4IXhT6CGoFUQIhPG4VxA4cKhVCKaAiBX4xUAow6giaNV?=
 =?us-ascii?q?4ElMoF1cIMSgi+OP1GNNYJGAQE?=
X-IPAS-Result: =?us-ascii?q?A2EpAQDbr7pah8uZ6ERdGwEBAgMBAQoBAYUTKJhygwOUVAu?=
 =?us-ascii?q?BeoMKAoQDITcVAQIBAQEBAQECAQIQAQEBCgsJCCgvgjgigk0GeRA/ElcGE4UOr?=
 =?us-ascii?q?hCIS4IXhT6CGoFUQIhPG4VxA4cKhVCKaAiBX4xUAow6giaNV4ElMoF1cIMSgi+?=
 =?us-ascii?q?OP1GNNYJGAQE?=
X-LoopCount0: from 10.208.86.39
X-IronPort-AV: E=Sophos;i="5.48,368,1517896800";
   d="scan'208";a="1124121474"
X-DLP: DLP_GlobalPCIDSS
From: Mario Limonciello <mario.limonciello@dell.com>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@dell.com>
Subject: [PATCH v2 2/2] power/hibernate: Change message when writing to /sys/power/resume
Date: Tue, 27 Mar 2018 15:58:53 -0500
Message-Id: <1522184333-27582-2-git-send-email-mario.limonciello@dell.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522184333-27582-1-git-send-email-mario.limonciello@dell.com>
References: <1522184333-27582-1-git-send-email-mario.limonciello@dell.com>
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
index 16e8645..15bc3cd 100644
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
