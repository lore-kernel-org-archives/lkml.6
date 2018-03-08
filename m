Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751045AbeCHWjz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 17:39:55 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45726 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750800AbeCHWjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 17:39:53 -0500
X-Google-Smtp-Source: AG47ELtLX3wz0njSxRt3Rbwprx1RHBlgEYMDWWB4LmSr3zKDASejRfqS2u3ejWlavN52Qbzo3icz9g==
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 1/2] of: unittest: remove unneeded local return value variables
Date: Thu,  8 Mar 2018 14:39:04 -0800
Message-Id: <1520548745-25021-1-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

A common pattern in many unittest functions is to save the return
value of a function in a local variable, then test the value of
the local variable, without using that return value for any further
purpose.  Remove the local return value variable for these cases.

A second common pattern is:

   ret = some_test_function(many, parameters, ...);
   if (unittest(ret == 0, "error message format", ...))
      return;

This pattern is more clear when the local variable 'ret' is used, due
to the long lines caused by the parameters to the test function and
the long format and data parameters of unittest().  The local
variable is retained in these cases.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/unittest.c | 89 ++++++++++++++-------------------------------------
 1 file changed, 24 insertions(+), 65 deletions(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index a23b54780c7d..546483c0be62 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1380,11 +1380,8 @@ static int __init of_unittest_apply_revert_overlay_check(int overlay_nr,
 /* test activation of device */
 static void __init of_unittest_overlay_0(void)
 {
-	int ret;
-
 	/* device should enable */
-	ret = of_unittest_apply_overlay_check(0, 0, 0, 1, PDEV_OVERLAY);
-	if (ret != 0)
+	if (of_unittest_apply_overlay_check(0, 0, 0, 1, PDEV_OVERLAY))
 		return;
 
 	unittest(1, "overlay test %d passed\n", 0);
@@ -1393,11 +1390,8 @@ static void __init of_unittest_overlay_0(void)
 /* test deactivation of device */
 static void __init of_unittest_overlay_1(void)
 {
-	int ret;
-
 	/* device should disable */
-	ret = of_unittest_apply_overlay_check(1, 1, 1, 0, PDEV_OVERLAY);
-	if (ret != 0)
+	if (of_unittest_apply_overlay_check(1, 1, 1, 0, PDEV_OVERLAY))
 		return;
 
 	unittest(1, "overlay test %d passed\n", 1);
@@ -1406,11 +1400,8 @@ static void __init of_unittest_overlay_1(void)
 /* test activation of device */
 static void __init of_unittest_overlay_2(void)
 {
-	int ret;
-
 	/* device should enable */
-	ret = of_unittest_apply_overlay_check(2, 2, 0, 1, PDEV_OVERLAY);
-	if (ret != 0)
+	if (of_unittest_apply_overlay_check(2, 2, 0, 1, PDEV_OVERLAY))
 		return;
 
 	unittest(1, "overlay test %d passed\n", 2);
@@ -1419,11 +1410,8 @@ static void __init of_unittest_overlay_2(void)
 /* test deactivation of device */
 static void __init of_unittest_overlay_3(void)
 {
-	int ret;
-
 	/* device should disable */
-	ret = of_unittest_apply_overlay_check(3, 3, 1, 0, PDEV_OVERLAY);
-	if (ret != 0)
+	if (of_unittest_apply_overlay_check(3, 3, 1, 0, PDEV_OVERLAY))
 		return;
 
 	unittest(1, "overlay test %d passed\n", 3);
@@ -1432,11 +1420,8 @@ static void __init of_unittest_overlay_3(void)
 /* test activation of a full device node */
 static void __init of_unittest_overlay_4(void)
 {
-	int ret;
-
 	/* device should disable */
-	ret = of_unittest_apply_overlay_check(4, 4, 0, 1, PDEV_OVERLAY);
-	if (ret != 0)
+	if (of_unittest_apply_overlay_check(4, 4, 0, 1, PDEV_OVERLAY))
 		return;
 
 	unittest(1, "overlay test %d passed\n", 4);
@@ -1445,11 +1430,8 @@ static void __init of_unittest_overlay_4(void)
 /* test overlay apply/revert sequence */
 static void __init of_unittest_overlay_5(void)
 {
-	int ret;
-
 	/* device should disable */
-	ret = of_unittest_apply_revert_overlay_check(5, 5, 0, 1, PDEV_OVERLAY);
-	if (ret != 0)
+	if (of_unittest_apply_revert_overlay_check(5, 5, 0, 1, PDEV_OVERLAY))
 		return;
 
 	unittest(1, "overlay test %d passed\n", 5);
@@ -1458,7 +1440,7 @@ static void __init of_unittest_overlay_5(void)
 /* test overlay application in sequence */
 static void __init of_unittest_overlay_6(void)
 {
-	int ret, i, ov_id[2], ovcs_id;
+	int i, ov_id[2], ovcs_id;
 	int overlay_nr = 6, unittest_nr = 6;
 	int before = 0, after = 1;
 	const char *overlay_name;
@@ -1481,8 +1463,7 @@ static void __init of_unittest_overlay_6(void)
 
 		overlay_name = overlay_name_from_nr(overlay_nr + i);
 
-		ret = overlay_data_apply(overlay_name, &ovcs_id);
-		if (!ret)  {
+		if (!overlay_data_apply(overlay_name, &ovcs_id)) {
 			unittest(0, "could not apply overlay \"%s\"\n",
 					overlay_name);
 			return;
@@ -1506,8 +1487,7 @@ static void __init of_unittest_overlay_6(void)
 
 	for (i = 1; i >= 0; i--) {
 		ovcs_id = ov_id[i];
-		ret = of_overlay_remove(&ovcs_id);
-		if (ret != 0) {
+		if (of_overlay_remove(&ovcs_id)) {
 			unittest(0, "%s failed destroy @\"%s\"\n",
 					overlay_name_from_nr(overlay_nr + i),
 					unittest_path(unittest_nr + i,
@@ -1536,7 +1516,7 @@ static void __init of_unittest_overlay_6(void)
 /* test overlay application in sequence */
 static void __init of_unittest_overlay_8(void)
 {
-	int ret, i, ov_id[2], ovcs_id;
+	int i, ov_id[2], ovcs_id;
 	int overlay_nr = 8, unittest_nr = 8;
 	const char *overlay_name;
 
@@ -1559,8 +1539,7 @@ static void __init of_unittest_overlay_8(void)
 
 	/* now try to remove first overlay (it should fail) */
 	ovcs_id = ov_id[0];
-	ret = of_overlay_remove(&ovcs_id);
-	if (ret == 0) {
+	if (!of_overlay_remove(&ovcs_id)) {
 		unittest(0, "%s was destroyed @\"%s\"\n",
 				overlay_name_from_nr(overlay_nr + 0),
 				unittest_path(unittest_nr,
@@ -1571,8 +1550,7 @@ static void __init of_unittest_overlay_8(void)
 	/* removing them in order should work */
 	for (i = 1; i >= 0; i--) {
 		ovcs_id = ov_id[i];
-		ret = of_overlay_remove(&ovcs_id);
-		if (ret != 0) {
+		if (of_overlay_remove(&ovcs_id)) {
 			unittest(0, "%s not destroyed @\"%s\"\n",
 					overlay_name_from_nr(overlay_nr + i),
 					unittest_path(unittest_nr,
@@ -1769,7 +1747,7 @@ static int unittest_i2c_mux_select_chan(struct i2c_mux_core *muxc, u32 chan)
 static int unittest_i2c_mux_probe(struct i2c_client *client,
 		const struct i2c_device_id *id)
 {
-	int ret, i, nchans;
+	int i, nchans;
 	struct device *dev = &client->dev;
 	struct i2c_adapter *adap = to_i2c_adapter(dev->parent);
 	struct device_node *np = client->dev.of_node, *child;
@@ -1785,8 +1763,7 @@ static int unittest_i2c_mux_probe(struct i2c_client *client,
 
 	max_reg = (u32)-1;
 	for_each_child_of_node(np, child) {
-		ret = of_property_read_u32(child, "reg", &reg);
-		if (ret)
+		if (of_property_read_u32(child, "reg", &reg))
 			continue;
 		if (max_reg == (u32)-1 || reg > max_reg)
 			max_reg = reg;
@@ -1802,8 +1779,7 @@ static int unittest_i2c_mux_probe(struct i2c_client *client,
 	if (!muxc)
 		return -ENOMEM;
 	for (i = 0; i < nchans; i++) {
-		ret = i2c_mux_add_adapter(muxc, 0, i, 0);
-		if (ret) {
+		if (i2c_mux_add_adapter(muxc, 0, i, 0)) {
 			dev_err(dev, "Failed to register mux #%d\n", i);
 			i2c_mux_del_adapters(muxc);
 			return -ENODEV;
@@ -1877,11 +1853,8 @@ static void of_unittest_overlay_i2c_cleanup(void)
 
 static void __init of_unittest_overlay_i2c_12(void)
 {
-	int ret;
-
 	/* device should enable */
-	ret = of_unittest_apply_overlay_check(12, 12, 0, 1, I2C_OVERLAY);
-	if (ret != 0)
+	if (of_unittest_apply_overlay_check(12, 12, 0, 1, I2C_OVERLAY))
 		return;
 
 	unittest(1, "overlay test %d passed\n", 12);
@@ -1890,11 +1863,8 @@ static void __init of_unittest_overlay_i2c_12(void)
 /* test deactivation of device */
 static void __init of_unittest_overlay_i2c_13(void)
 {
-	int ret;
-
 	/* device should disable */
-	ret = of_unittest_apply_overlay_check(13, 13, 1, 0, I2C_OVERLAY);
-	if (ret != 0)
+	if (of_unittest_apply_overlay_check(13, 13, 1, 0, I2C_OVERLAY))
 		return;
 
 	unittest(1, "overlay test %d passed\n", 13);
@@ -1907,11 +1877,8 @@ static void of_unittest_overlay_i2c_14(void)
 
 static void __init of_unittest_overlay_i2c_15(void)
 {
-	int ret;
-
 	/* device should enable */
-	ret = of_unittest_apply_overlay_check(15, 15, 0, 1, I2C_OVERLAY);
-	if (ret != 0)
+	if (of_unittest_apply_overlay_check(15, 15, 0, 1, I2C_OVERLAY))
 		return;
 
 	unittest(1, "overlay test %d passed\n", 15);
@@ -1927,10 +1894,8 @@ static inline void of_unittest_overlay_i2c_15(void) { }
 static void __init of_unittest_overlay(void)
 {
 	struct device_node *bus_np = NULL;
-	int ret;
 
-	ret = platform_driver_register(&unittest_driver);
-	if (ret != 0) {
+	if (platform_driver_register(&unittest_driver)) {
 		unittest(0, "could not register unittest driver\n");
 		goto out;
 	}
@@ -1941,8 +1906,7 @@ static void __init of_unittest_overlay(void)
 		goto out;
 	}
 
-	ret = of_platform_default_populate(bus_np, NULL, NULL);
-	if (ret != 0) {
+	if (of_platform_default_populate(bus_np, NULL, NULL)) {
 		unittest(0, "could not populate bus @ \"%s\"\n", bus_path);
 		goto out;
 	}
@@ -2193,7 +2157,6 @@ static __init void of_unittest_overlay_high_level(void)
 	struct device_node *overlay_base_symbols;
 	struct device_node **pprev;
 	struct property *prop;
-	int ret;
 
 	if (!overlay_base_root) {
 		unittest(0, "overlay_base_root not initialized\n");
@@ -2284,19 +2247,15 @@ static __init void of_unittest_overlay_high_level(void)
 					 prop->name);
 				goto err_unlock;
 			}
-			ret = __of_add_property(of_symbols, new_prop);
-			if (ret) {
-				if (!strcmp(new_prop->name, "name")) {
-					/* auto-generated by unflatten */
-					ret = 0;
+			if (__of_add_property(of_symbols, new_prop)) {
+				/* "name" auto-generated by unflatten */
+				if (!strcmp(new_prop->name, "name"))
 					continue;
-				}
 				unittest(0, "duplicate property '%s' in overlay_base node __symbols__",
 					 prop->name);
 				goto err_unlock;
 			}
-			ret = __of_add_property_sysfs(of_symbols, new_prop);
-			if (ret) {
+			if (__of_add_property_sysfs(of_symbols, new_prop)) {
 				unittest(0, "unable to add property '%s' in overlay_base node __symbols__ to sysfs",
 					 prop->name);
 				goto err_unlock;
-- 
Frank Rowand <frank.rowand@sony.com>
