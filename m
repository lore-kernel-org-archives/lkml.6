Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752774AbeBKJTI (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 04:19:08 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:60577 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752273AbeBKJTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 04:19:06 -0500
From: Aaron Ma <aaron.ma@canonical.com>
To: ike.pan@canonical.com, aaron.ma@canonical.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: ideapad-laptop: Increase timeout to wait for EC answer
Date: Sun, 11 Feb 2018 17:18:49 +0800
Message-Id: <1518340729-12463-1-git-send-email-aaron.ma@canonical.com>
X-Mailer: git-send-email 1.8.5.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lenovo E41-20 needs more time than 100ms to read VPC,
the funtion keys always failed responding.
Increase timeout to get the value from VPC, then
the funtion keys like mic mute key work well.

Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/platform/x86/ideapad-laptop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index 5b6f18b18801..535199c9e6bc 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -113,7 +113,7 @@ MODULE_PARM_DESC(no_bt_rfkill, "No rfkill for bluetooth.");
 /*
  * ACPI Helpers
  */
-#define IDEAPAD_EC_TIMEOUT (100) /* in ms */
+#define IDEAPAD_EC_TIMEOUT (200) /* in ms */
 
 static int read_method_int(acpi_handle handle, const char *method, int *val)
 {
-- 
2.14.3
