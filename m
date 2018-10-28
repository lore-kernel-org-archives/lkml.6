Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A769CC6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 22:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D2D42064C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 22:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=steffenvogel.de header.i=@steffenvogel.de header.b="RDpEOfRZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D2D42064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=steffenvogel.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbeJ2HGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 03:06:01 -0400
Received: from nag.0l.de ([207.154.252.120]:33482 "EHLO nag.0l.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbeJ2HGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 03:06:01 -0400
From:   Steffen Vogel <post@steffenvogel.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffenvogel.de;
        s=2017; t=1540764601; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UZ+uT7kVjqwLZYOg1c2d5AcoIHDejx6MDyhY4qb+E7U=;
        b=RDpEOfRZUqtkizES1+HbH5lNE+DPa4bj7B2c8r4YnREcU6aULNzONyInIIw+5Uv+QgfDiq
        8d70tAoo4tGTR0EHDhQgWZl2HX8ld88L2q424GEO9S20r3iPHXk+EYgttngGQgeyVaDPXb
        eDTh5hEIlMNSccSBZlvb6DmVpTAjTEe6SXr4rrL1vdRVUsHUJ0A/QusRC+k01A9neNkO+Q
        gBdnIUe4HS+FRVuz12FAUISXgCwGZiylcVdQPvPX9xFcA8XIsJVnxdHyXgjnsG6u1YxDm3
        l5RgnLQ8euNWfH5Ee3nowgDPb64p0LMExsAAg7XwfO701lnonLsBZULoZ17dIw==
To:     linux-kernel@vger.kernel.org
Cc:     Evgeniy Polyakov <zbr@ioremap.net>,
        Steffen Vogel <post@steffenvogel.de>
Subject: [PATCH 2/9] w1: improve coding style by following strict 80 column line limit
Date:   Sun, 28 Oct 2018 23:09:21 +0100
Message-Id: <20181028220927.56227-3-post@steffenvogel.de>
In-Reply-To: <20181028220927.56227-1-post@steffenvogel.de>
References: <20181028220927.56227-1-post@steffenvogel.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=steffenvogel.de;
        s=2017; t=1540764601; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UZ+uT7kVjqwLZYOg1c2d5AcoIHDejx6MDyhY4qb+E7U=;
        b=JxkCUxWJ2xy8vjXfnWmEOaJ1IiVKcM8Rj4ORrM5+WibRZO/oLZ/u15g5dfjovOg+rZ8igx
        IROigmljAxl6t7/vNAlBb1VCLWDmM/p5ELnPcm+CXiTgFgUdjITnj1XN/RJEqd08QQTMds
        PXwtBaZwHenuLZHe0CBEZU/xjoqEMI6Y9LpsS9+HQWU43NUjIaNkFG64AOxTXSfPTqiHTq
        QF7pT4ruWsNfGaLBFwRK0IhoUc9KmHM8n3v0yo5ckZwBBYFZFU2aATXm4giPL/mp1WjCcY
        5sx4xFrcyKw7Oa0ksb3HVgDGxrjc54+4TdKvxV9W7ZtHO4TeeXaAnlr0FC05mA==
ARC-Seal: i=1; s=2017; d=steffenvogel.de; t=1540764601; a=rsa-sha256;
        cv=none;
        b=NWbVlSsfCZdCi/L3nfU5pjmxly5Wks0kgwMpavV1W2OYbc5ByH1oW89H4FYM+pWM0V2IPReuW6IMhMN+TWvO/RYhaS+PwsawrsuYRzvrX7UpS1EoSm8uez7x3bHoFaMts2AKb9+o4h6vxF6J45Ww+EeUaZOZAXCvyYSrFCw63l+q59Xt0+/BkOQwx9kHObMZcTOJKhBtC+PlavnQb4LiVMmHLG/EKVtBizYw5iim2A1aCZ000jvOwbG6IuEiBRhuA7H0MD5keKgfa409gi5WhxHYM1GxTrCW10O09d0JtEOtv7MdswFqcaPDZbaL16bNGe3+q9vZiaUISIWGkQPAMw==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=stv0g@0l.de smtp.mailfrom=post@steffenvogel.de
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=stv0g@0l.de smtp.mailfrom=post@steffenvogel.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This satisfies a checkpatch warning

Signed-off-by: Steffen Vogel <post@steffenvogel.de>
---
 drivers/w1/w1.c         | 56 +++++++++++++++++++++++++++++--------------------
 drivers/w1/w1_int.c     |  3 ++-
 drivers/w1/w1_io.c      | 29 +++++++++++++++----------
 drivers/w1/w1_netlink.c | 16 +++++++++-----
 4 files changed, 64 insertions(+), 40 deletions(-)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index 2c64655b603c..bd95dfe4041d 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -85,7 +85,8 @@ static void w1_slave_release(struct device *dev)
 	sl->master->slave_count--;
 }
 
-static ssize_t name_show(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t name_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
 {
 	struct w1_slave *sl = dev_to_w1_slave(dev);
 
@@ -203,9 +204,10 @@ struct device w1_slave_device = {
 	.driver = &w1_slave_driver,
 	.release = &w1_slave_release
 };
-#endif  /*  0  */
+#endif
 
-static ssize_t w1_master_attribute_show_name(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t w1_master_attribute_show_name(struct device *dev,
+	struct device_attribute *attr, char *buf)
 {
 	struct w1_master *md = dev_to_w1_master(dev);
 	ssize_t count;
@@ -217,9 +219,9 @@ static ssize_t w1_master_attribute_show_name(struct device *dev, struct device_a
 	return count;
 }
 
-static ssize_t w1_master_attribute_store_search(struct device * dev,
+static ssize_t w1_master_attribute_store_search(struct device *dev,
 						struct device_attribute *attr,
-						const char * buf, size_t count)
+						const char *buf, size_t count)
 {
 	long tmp;
 	struct w1_master *md = dev_to_w1_master(dev);
@@ -286,7 +288,8 @@ static ssize_t w1_master_attribute_show_pullup(struct device *dev,
 	return count;
 }
 
-static ssize_t w1_master_attribute_show_pointer(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t w1_master_attribute_show_pointer(struct device *dev,
+	struct device_attribute *attr, char *buf)
 {
 	struct w1_master *md = dev_to_w1_master(dev);
 	ssize_t count;
@@ -297,7 +300,8 @@ static ssize_t w1_master_attribute_show_pointer(struct device *dev, struct devic
 	return count;
 }
 
-static ssize_t w1_master_attribute_show_timeout(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t w1_master_attribute_show_timeout(struct device *dev,
+	struct device_attribute *attr, char *buf)
 {
 	ssize_t count;
 	count = sprintf(buf, "%d\n", w1_timeout);
@@ -330,7 +334,8 @@ static ssize_t w1_master_attribute_store_max_slave_count(struct device *dev,
 	return count;
 }
 
-static ssize_t w1_master_attribute_show_max_slave_count(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t w1_master_attribute_show_max_slave_count(struct device *dev,
+	struct device_attribute *attr, char *buf)
 {
 	struct w1_master *md = dev_to_w1_master(dev);
 	ssize_t count;
@@ -338,10 +343,12 @@ static ssize_t w1_master_attribute_show_max_slave_count(struct device *dev, stru
 	mutex_lock(&md->mutex);
 	count = sprintf(buf, "%d\n", md->max_slave_count);
 	mutex_unlock(&md->mutex);
+
 	return count;
 }
 
-static ssize_t w1_master_attribute_show_attempts(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t w1_master_attribute_show_attempts(struct device *dev,
+	struct device_attribute *attr, char *buf)
 {
 	struct w1_master *md = dev_to_w1_master(dev);
 	ssize_t count;
@@ -349,10 +356,12 @@ static ssize_t w1_master_attribute_show_attempts(struct device *dev, struct devi
 	mutex_lock(&md->mutex);
 	count = sprintf(buf, "%lu\n", md->attempts);
 	mutex_unlock(&md->mutex);
+
 	return count;
 }
 
-static ssize_t w1_master_attribute_show_slave_count(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t w1_master_attribute_show_slave_count(struct device *dev,
+	struct device_attribute *attr, char *buf)
 {
 	struct w1_master *md = dev_to_w1_master(dev);
 	ssize_t count;
@@ -408,8 +417,7 @@ static int w1_atoreg_num(struct device *dev, const char *buf, size_t count,
 	 * print it either.  It would be unreasonable for the user to then
 	 * provide it.
 	 */
-	const char *error_msg = "bad slave string format, expecting "
-		"ff-dddddddddddd\n";
+	const char *error_msg = "bad slave string format, expecting ff-dddddddddddd\n";
 
 	if (buf[2] != '-') {
 		dev_err(dev, "%s", error_msg);
@@ -880,8 +888,8 @@ void w1_reconnect_slaves(struct w1_family *f, int attach)
 
 	mutex_lock(&w1_mlock);
 	list_for_each_entry(dev, &w1_masters, w1_master_entry) {
-		dev_dbg(&dev->dev, "Reconnecting slaves in device %s "
-			"for family %02x.\n", dev->name, f->fid);
+		dev_dbg(&dev->dev, "Reconnecting slaves in device %s for family %02x.\n",
+			dev->name, f->fid);
 		mutex_lock(&dev->mutex);
 		mutex_lock(&dev->list_mutex);
 		list_for_each_entry_safe(sl, sln, &dev->slist, w1_slave_entry) {
@@ -905,8 +913,8 @@ void w1_reconnect_slaves(struct w1_family *f, int attach)
 				mutex_lock(&dev->list_mutex);
 			}
 		}
-		dev_dbg(&dev->dev, "Reconnecting slaves in device %s "
-			"has been finished.\n", dev->name);
+		dev_dbg(&dev->dev, "Reconnecting slaves in device %s has been finished.\n",
+			dev->name);
 		mutex_unlock(&dev->list_mutex);
 		mutex_unlock(&dev->mutex);
 	}
@@ -951,7 +959,8 @@ void w1_slave_found(struct w1_master *dev, u64 rn)
  * See "Application note 187 1-wire search algorithm" at www.maxim-ic.com
  *
  */
-void w1_search(struct w1_master *dev, u8 search_type, w1_slave_found_callback cb)
+void w1_search(struct w1_master *dev, u8 search_type,
+	w1_slave_found_callback cb)
 {
 	u64 last_rn, rn, tmp64;
 	int i, slave_count = 0;
@@ -1002,9 +1011,11 @@ void w1_search(struct w1_master *dev, u8 search_type, w1_slave_found_callback cb
 		for (i = 0; i < 64; ++i) {
 			/* Determine the direction/search bit */
 			if (i == desc_bit)
-				search_bit = 1;	  /* took the 0 path last time, so take the 1 path */
+				/* took the 0 path last time, so take the 1 path */
+				search_bit = 1;
 			else if (i > desc_bit)
-				search_bit = 0;	  /* take the 0 path on the next branch */
+				/* take the 0 path on the next branch */
+				search_bit = 0;
 			else
 				search_bit = ((last_rn >> i) & 0x1);
 
@@ -1015,7 +1026,7 @@ void w1_search(struct w1_master *dev, u8 search_type, w1_slave_found_callback cb
 			if ( (triplet_ret & 0x03) == 0x03 )
 				break;
 
-			/* If both directions were valid, and we took the 0 path... */
+			/* If both directions were valid, and we took the 0 path */
 			if (triplet_ret == 0)
 				last_zero = i;
 
@@ -1051,9 +1062,8 @@ void w1_search(struct w1_master *dev, u8 search_type, w1_slave_found_callback cb
 			 * last id as the first id (provided it is still on the
 			 * bus).
 			 */
-			dev_info(&dev->dev, "%s: max_slave_count %d reached, "
-				"will continue next search.\n", __func__,
-				dev->max_slave_count);
+			dev_info(&dev->dev, "%s: max_slave_count %d reached, will continue next search.\n",
+				__func__, dev->max_slave_count);
 			set_bit(W1_WARN_MAX_COUNT, &dev->flags);
 		}
 	}
diff --git a/drivers/w1/w1_int.c b/drivers/w1/w1_int.c
index 507eea535d43..72b9392d9551 100644
--- a/drivers/w1/w1_int.c
+++ b/drivers/w1/w1_int.c
@@ -31,7 +31,8 @@ static struct w1_master *w1_alloc_dev(u32 id, int slave_count, int slave_ttl,
 	/*
 	 * We are in process context(kernel thread), so can sleep.
 	 */
-	dev = kzalloc(sizeof(struct w1_master) + sizeof(struct w1_bus_master), GFP_KERNEL);
+	dev = kzalloc(sizeof(struct w1_master) +
+		sizeof(struct w1_bus_master), GFP_KERNEL);
 	if (!dev) {
 		pr_err("Failed to allocate %zd bytes for new w1 device.\n",
 			sizeof(struct w1_master));
diff --git a/drivers/w1/w1_io.c b/drivers/w1/w1_io.c
index bc7d1f7a1222..2626a61852e9 100644
--- a/drivers/w1/w1_io.c
+++ b/drivers/w1/w1_io.c
@@ -73,7 +73,8 @@ static void w1_write_bit(struct w1_master *dev, int bit)
 {
 	unsigned long flags = 0;
 
-	if(w1_disable_irqs) local_irq_save(flags);
+	if (w1_disable_irqs)
+		local_irq_save(flags);
 
 	if (bit) {
 		dev->bus_master->write_bit(dev->bus_master->data, 0);
@@ -87,7 +88,8 @@ static void w1_write_bit(struct w1_master *dev, int bit)
 		w1_delay(10);
 	}
 
-	if(w1_disable_irqs) local_irq_restore(flags);
+	if (w1_disable_irqs)
+		local_irq_restore(flags);
 }
 
 /**
@@ -192,9 +194,10 @@ static u8 w1_read_bit(struct w1_master *dev)
  */
 u8 w1_triplet(struct w1_master *dev, int bdir)
 {
-	if (dev->bus_master->triplet)
-		return dev->bus_master->triplet(dev->bus_master->data, bdir);
-	else {
+	if (dev->bus_master->triplet) {
+		return dev->bus_master->triplet(dev->bus_master->data,
+			bdir);
+	} else {
 		u8 id_bit   = w1_touch_bit(dev, 1);
 		u8 comp_bit = w1_touch_bit(dev, 1);
 		u8 retval;
@@ -298,9 +301,10 @@ u8 w1_read_block(struct w1_master *dev, u8 *buf, int len)
 	int i;
 	u8 ret;
 
-	if (dev->bus_master->read_block)
-		ret = dev->bus_master->read_block(dev->bus_master->data, buf, len);
-	else {
+	if (dev->bus_master->read_block) {
+		ret = dev->bus_master->read_block(dev->bus_master->data,
+			buf, len);
+	} else {
 		for (i = 0; i < len; ++i)
 			buf[i] = w1_read_8(dev);
 		ret = len;
@@ -320,7 +324,8 @@ int w1_reset_bus(struct w1_master *dev)
 	int result;
 	unsigned long flags = 0;
 
-	if(w1_disable_irqs) local_irq_save(flags);
+	if (w1_disable_irqs)
+		local_irq_save(flags);
 
 	if (dev->bus_master->reset_bus)
 		result = dev->bus_master->reset_bus(dev->bus_master->data) & 0x1;
@@ -346,7 +351,8 @@ int w1_reset_bus(struct w1_master *dev)
 		msleep(1);
 	}
 
-	if(w1_disable_irqs) local_irq_restore(flags);
+	if (w1_disable_irqs)
+		local_irq_restore(flags);
 
 	return result;
 }
@@ -363,7 +369,8 @@ u8 w1_calc_crc8(u8 * data, int len)
 }
 EXPORT_SYMBOL_GPL(w1_calc_crc8);
 
-void w1_search_devices(struct w1_master *dev, u8 search_type, w1_slave_found_callback cb)
+void w1_search_devices(struct w1_master *dev, u8 search_type,
+	w1_slave_found_callback cb)
 {
 	dev->attempts++;
 	if (dev->bus_master->search)
diff --git a/drivers/w1/w1_netlink.c b/drivers/w1/w1_netlink.c
index 0f2c6ed94b0f..54a82bf69566 100644
--- a/drivers/w1/w1_netlink.c
+++ b/drivers/w1/w1_netlink.c
@@ -82,8 +82,10 @@ static void w1_unref_block(struct w1_cb_block *block)
 static void w1_reply_make_space(struct w1_cb_block *block, u16 space)
 {
 	u16 len = w1_reply_len(block);
+
 	if (len + space >= block->maxlen) {
-		cn_netlink_send_mult(block->first_cn, len, block->portid, 0, GFP_KERNEL);
+		cn_netlink_send_mult(block->first_cn, len,
+			block->portid, 0, GFP_KERNEL);
 		block->first_cn->len = 0;
 		block->cn = NULL;
 		block->msg = NULL;
@@ -110,7 +112,8 @@ static void w1_netlink_check_send(struct w1_cb_block *block)
 static void w1_netlink_setup_msg(struct w1_cb_block *block, u32 ack)
 {
 	if (block->cn && block->cn->ack == ack) {
-		block->msg = (struct w1_netlink_msg *)(block->cn->data + block->cn->len);
+		block->msg = (struct w1_netlink_msg *)
+			(block->cn->data + block->cn->len);
 	} else {
 		/* advance or set to data */
 		if (block->cn)
@@ -170,7 +173,9 @@ static void w1_netlink_queue_status(struct w1_cb_block *block,
 	block->msg->len = 0;
 	block->msg->status = (u8)-error;
 	if (req_cmd) {
-		struct w1_netlink_cmd *cmd = (struct w1_netlink_cmd *)block->msg->data;
+		struct w1_netlink_cmd *cmd =
+			(struct w1_netlink_cmd *) block->msg->data;
+
 		memcpy(cmd, req_cmd, sizeof(*cmd));
 		block->cn->len += sizeof(*cmd);
 		block->msg->len += sizeof(*cmd);
@@ -388,8 +393,9 @@ static int w1_process_command_slave(struct w1_slave *sl,
 		struct w1_netlink_cmd *cmd)
 {
 	dev_dbg(&sl->master->dev, "%s: %02x.%012llx.%02x: cmd=%02x, len=%u.\n",
-		__func__, sl->reg_num.family, (unsigned long long)sl->reg_num.id,
-		sl->reg_num.crc, cmd->cmd, cmd->len);
+		__func__, sl->reg_num.family,
+		(unsigned long long) sl->reg_num.id, sl->reg_num.crc, cmd->cmd,
+		cmd->len);
 
 	return w1_process_command_io(sl->master, cmd);
 }
-- 
2.11.0

