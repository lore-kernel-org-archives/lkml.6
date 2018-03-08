Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751169AbeCHWj5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 17:39:57 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:39735 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750848AbeCHWjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 17:39:54 -0500
X-Google-Smtp-Source: AG47ELu6sjbD/iWKGe7QDjqGyElm01Qi0XOeFP4QiH3Wj6nLfedXfVQsmhGteOBm81umMhTF6yhbpA==
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 2/2] of: unittest: local return value variable related cleanups
Date: Thu,  8 Mar 2018 14:39:05 -0800
Message-Id: <1520548745-25021-2-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520548745-25021-1-git-send-email-frowand.list@gmail.com>
References: <1520548745-25021-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

Several more style issues became apparent while creating
"of: unittest: remove unneeded local return value variables".
Correct those issues.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/unittest.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 546483c0be62..7aef8688c365 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1267,7 +1267,6 @@ static void of_unittest_destroy_tracked_overlays(void)
 static int __init of_unittest_apply_overlay(int overlay_nr, int unittest_nr,
 		int *overlay_id)
 {
-	struct device_node *np = NULL;
 	const char *overlay_name;
 	int ret;
 
@@ -1277,16 +1276,11 @@ static int __init of_unittest_apply_overlay(int overlay_nr, int unittest_nr,
 	if (!ret) {
 		unittest(0, "could not apply overlay \"%s\"\n",
 				overlay_name);
-		goto out;
+		return ret;
 	}
 	of_unittest_track_overlay(*overlay_id);
 
-	ret = 0;
-
-out:
-	of_node_put(np);
-
-	return ret;
+	return 0;
 }
 
 /* apply an overlay while checking before and after states */
@@ -1582,8 +1576,8 @@ static void __init of_unittest_overlay_10(void)
 
 	ret = of_path_device_type_exists(child_path, PDEV_OVERLAY);
 	kfree(child_path);
-	if (unittest(ret, "overlay test %d failed; no child device\n", 10))
-		return;
+
+	unittest(ret, "overlay test %d failed; no child device\n", 10);
 }
 
 /* test insertion of a bus with parent devices (and revert) */
@@ -1594,9 +1588,7 @@ static void __init of_unittest_overlay_11(void)
 	/* device should disable */
 	ret = of_unittest_apply_revert_overlay_check(11, 11, 0, 1,
 			PDEV_OVERLAY);
-	if (unittest(ret == 0,
-			"overlay test %d failed; overlay application\n", 11))
-		return;
+	unittest(ret == 0, "overlay test %d failed; overlay apply\n", 11);
 }
 
 #if IS_BUILTIN(CONFIG_I2C) && IS_ENABLED(CONFIG_OF_OVERLAY)
@@ -2120,10 +2112,8 @@ static int __init overlay_data_apply(const char *overlay_name, int *overlay_id)
 	}
 
 	size = info->dtb_end - info->dtb_begin;
-	if (!size) {
+	if (!size)
 		pr_err("no overlay data for %s\n", overlay_name);
-		ret = 0;
-	}
 
 	ret = of_overlay_fdt_apply(info->dtb_begin, size, &info->overlay_id);
 	if (overlay_id)
-- 
Frank Rowand <frank.rowand@sony.com>
