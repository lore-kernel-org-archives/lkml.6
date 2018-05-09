Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756469AbeEIOID (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 10:08:03 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33907 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756338AbeEIOIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 10:08:01 -0400
X-Google-Smtp-Source: AB8JxZqh+ap+4nIdKAhNcNXNEGpCG8E8mIrhGFu1lzeKUxChV29IhOSEQT3iB2FscUimepFHJh5EYw==
From: Nick Simonov <nicksimonovv@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: rydberg@bitmath.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nick Simonov <nicksimonovv@gmail.com>
Subject: [PATCH] input: fix coding style issues in input.c
Date: Wed,  9 May 2018 17:07:14 +0300
Message-Id: <1525874834-20432-1-git-send-email-nicksimonovv@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch to the input.c file that fixes
up warning found by checkpatch.pl tool

Signed-off-by: Nick Simonov <nicksimonovv@gmail.com>
---
 drivers/input/input.c | 52 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 19 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 9785546..e18fdae 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * The input core
  *
@@ -252,7 +253,8 @@ static int input_handle_abs_event(struct input_dev *dev,
 	}
 
 	/* Flush pending "slot" event */
-	if (is_mt_event && mt && mt->slot != input_abs_get_val(dev, ABS_MT_SLOT)) {
+	if (is_mt_event && mt && mt->slot !=
+		input_abs_get_val(dev, ABS_MT_SLOT)) {
 		input_abs_set_val(dev, ABS_MT_SLOT, mt->slot);
 		return INPUT_PASS_TO_HANDLERS | INPUT_SLOT;
 	}
@@ -969,7 +971,8 @@ bool input_match_device_id(const struct input_dev *dev,
 }
 EXPORT_SYMBOL(input_match_device_id);
 
-static const struct input_device_id *input_match_device(struct input_handler *handler,
+static
+const struct input_device_id *input_match_device(struct input_handler *handler,
 							struct input_dev *dev)
 {
 	const struct input_device_id *id;
@@ -984,7 +987,8 @@ static const struct input_device_id *input_match_device(struct input_handler *ha
 	return NULL;
 }
 
-static int input_attach_handler(struct input_dev *dev, struct input_handler *handler)
+static
+int input_attach_handler(struct input_dev *dev, struct input_handler *handler)
 {
 	const struct input_device_id *id;
 	int error;
@@ -1010,6 +1014,7 @@ static int input_bits_to_string(char *buf, int buf_size,
 
 	if (in_compat_syscall()) {
 		u32 dword = bits >> 32;
+
 		if (dword || !skip_empty)
 			len += snprintf(buf, buf_size, "%x ", dword);
 
@@ -1132,7 +1137,10 @@ static int input_devices_seq_show(struct seq_file *seq, void *v)
 	struct input_handle *handle;
 
 	seq_printf(seq, "I: Bus=%04x Vendor=%04x Product=%04x Version=%04x\n",
-		   dev->id.bustype, dev->id.vendor, dev->id.product, dev->id.version);
+		   dev->id.bustype,
+		   dev->id.vendor,
+		   dev->id.product,
+		   dev->id.version);
 
 	seq_printf(seq, "N: Name=\"%s\"\n", dev->name ? dev->name : "");
 	seq_printf(seq, "P: Phys=%s\n", dev->phys ? dev->phys : "");
@@ -1221,9 +1229,10 @@ static void *input_handlers_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 
 static int input_handlers_seq_show(struct seq_file *seq, void *v)
 {
-	struct input_handler *handler = container_of(v, struct input_handler, node);
+	struct input_handler *handler;
 	union input_seq_state *state = (union input_seq_state *)&seq->private;
 
+	handler = container_of(v, struct input_handler, node);
 	seq_printf(seq, "N: Number=%u Name=%s", state->pos, handler->name);
 	if (handler->filter)
 		seq_puts(seq, " (filter)");
@@ -1302,7 +1311,7 @@ static ssize_t input_dev_show_##name(struct device *dev,		\
 	return scnprintf(buf, PAGE_SIZE, "%s\n",			\
 			 input_dev->name ? input_dev->name : "");	\
 }									\
-static DEVICE_ATTR(name, S_IRUGO, input_dev_show_##name, NULL)
+static DEVICE_ATTR(name, 0444, input_dev_show_##name, NULL)
 
 INPUT_DEV_STRING_ATTR_SHOW(name);
 INPUT_DEV_STRING_ATTR_SHOW(phys);
@@ -1317,7 +1326,8 @@ static int input_print_modalias_bits(char *buf, int size,
 	len += snprintf(buf, max(size, 0), "%c", name);
 	for (i = min_bit; i < max_bit; i++)
 		if (bm[BIT_WORD(i)] & BIT_MASK(i))
-			len += snprintf(buf + len, max(size - len, 0), "%X,", i);
+			len += snprintf(buf + len, max(size - len, 0),
+							"%X,", i);
 	return len;
 }
 
@@ -1327,9 +1337,9 @@ static int input_print_modalias(char *buf, int size, struct input_dev *id,
 	int len;
 
 	len = snprintf(buf, max(size, 0),
-		       "input:b%04Xv%04Xp%04Xe%04X-",
-		       id->id.bustype, id->id.vendor,
-		       id->id.product, id->id.version);
+				"input:b%04Xv%04Xp%04Xe%04X-",
+				id->id.bustype, id->id.vendor,
+				id->id.product, id->id.version);
 
 	len += input_print_modalias_bits(buf + len, size - len,
 				'e', id->evbit, 0, EV_MAX);
@@ -1367,7 +1377,7 @@ static ssize_t input_dev_show_modalias(struct device *dev,
 
 	return min_t(int, len, PAGE_SIZE);
 }
-static DEVICE_ATTR(modalias, S_IRUGO, input_dev_show_modalias, NULL);
+static DEVICE_ATTR(modalias, 0444, input_dev_show_modalias, NULL);
 
 static int input_print_bitmap(char *buf, int buf_size, unsigned long *bitmap,
 			      int max, int add_cr);
@@ -1381,7 +1391,7 @@ static ssize_t input_dev_show_properties(struct device *dev,
 				     INPUT_PROP_MAX, true);
 	return min_t(int, len, PAGE_SIZE);
 }
-static DEVICE_ATTR(properties, S_IRUGO, input_dev_show_properties, NULL);
+static DEVICE_ATTR(properties, 0444, input_dev_show_properties, NULL);
 
 static struct attribute *input_dev_attrs[] = {
 	&dev_attr_name.attr,
@@ -1404,7 +1414,7 @@ static ssize_t input_dev_show_id_##name(struct device *dev,		\
 	struct input_dev *input_dev = to_input_dev(dev);		\
 	return scnprintf(buf, PAGE_SIZE, "%04x\n", input_dev->id.name);	\
 }									\
-static DEVICE_ATTR(name, S_IRUGO, input_dev_show_id_##name, NULL)
+static DEVICE_ATTR(name, 0444, input_dev_show_id_##name, NULL)
 
 INPUT_DEV_ID_ATTR(bustype);
 INPUT_DEV_ID_ATTR(vendor);
@@ -1437,7 +1447,8 @@ static int input_print_bitmap(char *buf, int buf_size, unsigned long *bitmap,
 		if (len) {
 			skip_empty = false;
 			if (i > 0)
-				len += snprintf(buf + len, max(buf_size - len, 0), " ");
+				len += snprintf(buf + len,
+						max(buf_size - len, 0), " ");
 		}
 	}
 
@@ -1464,7 +1475,7 @@ static ssize_t input_dev_show_cap_##bm(struct device *dev,		\
 				     true);				\
 	return min_t(int, len, PAGE_SIZE);				\
 }									\
-static DEVICE_ATTR(bm, S_IRUGO, input_dev_show_cap_##bm, NULL)
+static DEVICE_ATTR(bm, 0444, input_dev_show_cap_##bm, NULL)
 
 INPUT_DEV_CAP_ATTR(EV, ev);
 INPUT_DEV_CAP_ATTR(KEY, key);
@@ -1519,7 +1530,9 @@ static void input_dev_release(struct device *device)
  * device bitfields.
  */
 static int input_add_uevent_bm_var(struct kobj_uevent_env *env,
-				   const char *name, unsigned long *bitmap, int max)
+				   const char *name,
+				   unsigned long *bitmap,
+				   int max)
 {
 	int len;
 
@@ -1899,7 +1912,8 @@ EXPORT_SYMBOL(input_free_device);
  * In addition to setting up corresponding bit in appropriate capability
  * bitmap the function also adjusts dev->evbit.
  */
-void input_set_capability(struct input_dev *dev, unsigned int type, unsigned int code)
+void input_set_capability(struct input_dev *dev,
+					 unsigned int type, unsigned int code)
 {
 	switch (type) {
 	case EV_KEY:
@@ -1943,8 +1957,8 @@ void input_set_capability(struct input_dev *dev, unsigned int type, unsigned int
 		break;
 
 	default:
-		pr_err("input_set_capability: unknown type %u (code %u)\n",
-		       type, code);
+		pr_err("%s: unknown type %u (code %u)\n",
+			   __func__, type, code);
 		dump_stack();
 		return;
 	}
-- 
2.7.4
