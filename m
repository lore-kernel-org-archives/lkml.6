Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C069C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 03:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD8820843
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 03:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=steffenvogel.de header.i=@steffenvogel.de header.b="VLNTHtZR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACD8820843
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=steffenvogel.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbeJ2L63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 07:58:29 -0400
Received: from nag.0l.de ([207.154.252.120]:44736 "EHLO nag.0l.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729184AbeJ2L63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 07:58:29 -0400
From:   Steffen Vogel <post@steffenvogel.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffenvogel.de;
        s=2017; t=1540782276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zJkQaGgXcUCBUNZ8mxupRlWLGIHIXad/r8zoy905LqE=;
        b=VLNTHtZRQHQzokf9+V7eJJdfbBBRe/aArjLNOW7OLaS3Q4l6cAnyak7N1ZpDDuAWcKxWr6
        wfahL0wpas78+s4EBKvXdU0MyikciyT84nrXooRD7PXEsozidiJDku2wwxpIggY+Jcsrkf
        vta+3IDaT+JWpOcitC+c9TbfvC/kDWrrcenSttayszKn7PGolL7wVUXORRBcIRKrGWhmng
        w+rs/N+F27FeT3xkqPdOVGLfOVWqRdL2rBosKfWeFL5RIy4RdGtLA2QrytfS8E/PtCLpxZ
        Dfa7LwQZUH3CWfjBump9B4WT39YzKt4QlgLbOiqRFr4eEQoboxnt//alsbOW8A==
To:     linux-kernel@vger.kernel.org
Cc:     Evgeniy Polyakov <zbr@ioremap.net>, Joe Perches <joe@perches.com>,
        Steffen Vogel <post@steffenvogel.de>
Subject: [PATCH v2 04/12] w1: cleanup whitespaces according to coding style document
Date:   Mon, 29 Oct 2018 04:03:34 +0100
Message-Id: <9a47b8bddc209dfe747929e02b5f2c2b07288cbb.1540782140.git.post@steffenvogel.de>
In-Reply-To: <cover.1540782140.git.post@steffenvogel.de>
References: <cover.1540782140.git.post@steffenvogel.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=steffenvogel.de;
        s=2017; t=1540782276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zJkQaGgXcUCBUNZ8mxupRlWLGIHIXad/r8zoy905LqE=;
        b=rF2d0zq/uNeX0CXUUUIz74e77A43mcypp2Qzj/3Vg30SZ/P3OcCgm04eURMR6SiWhuWv7c
        3KrY3nucgwGgnej3ghl14n1Ank9gONWOSVtfGRmJADs/RSiUMUYw/DPbncNdpCDd4vJpkq
        dasCAzZ3y/ldclnbwHshVlTWxZ63nIH+2q4XWAaniQtPicKkO4crW2UvP3P2RMzisxezhK
        ygxR7Ke+xomDyBBioTVOzWo9/nbilXiKaMdBefD4arEQAZg7/DPL76T388bSQzfyynn1HZ
        Fkq7ShNoz4vR6eJyazA0C2hg68kvbhWQk2j21Ysxdrc5AWqhhcNpLdwq6QBEbQ==
ARC-Seal: i=1; s=2017; d=steffenvogel.de; t=1540782276; a=rsa-sha256;
        cv=none;
        b=gqarnLfi86U4c+mOK1eRuwDvha0QltnjhsGZ5kcbiPRYhzMHmVEASWMQLwvnoV5psn/vzO5ibHC2Qp+eJaS21dANNxmlN/iTVOc6l1AMdXe/S3lOE7b7CxgCLkc89OOhC01VyMq7oXCbeVcLL3UtrF03jhPULQ9PPY8DorRUa1zO8wprcjiF63qMdCNFLSoEpdonhBlQw35NVK+PXWhdhu3HiW8uCKZS2jqA6ZcxZZbMJDbIBSOYhjOENljFd50Re5fDlUe7J/hgn8Dhv0uVKovabPFWJLTvFrPQTp44LOMq+9iex4B/+o2UVpwPMfeM1DSbRlCPlp7uxzdK7RhuNQ==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=stv0g@0l.de smtp.mailfrom=post@steffenvogel.de
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=stv0g@0l.de smtp.mailfrom=post@steffenvogel.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These changes fix several warnings emitted by the checkpatch tool.

Signed-off-by: Steffen Vogel <post@steffenvogel.de>
---
 drivers/w1/w1.c         | 38 +++++++++++++++++++-------------------
 drivers/w1/w1_family.c  |  2 +-
 drivers/w1/w1_io.c      | 40 +++++++++++++++++++++-------------------
 drivers/w1/w1_netlink.c |  8 ++++----
 4 files changed, 45 insertions(+), 43 deletions(-)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index 48c20639f75f..184df1fe216b 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -416,7 +416,7 @@ static ssize_t w1_master_attribute_show_add(struct device *dev,
 {
 	int c = PAGE_SIZE;
 
-	c -= snprintf(buf+PAGE_SIZE - c, c,
+	c -= snprintf(buf + PAGE_SIZE - c, c,
 		"write device id xx-xxxxxxxxxxxx to add slave\n");
 
 	return PAGE_SIZE - c;
@@ -517,7 +517,7 @@ static ssize_t w1_master_attribute_show_remove(struct device *dev,
 {
 	int c = PAGE_SIZE;
 
-	c -= snprintf(buf+PAGE_SIZE - c, c,
+	c -= snprintf(buf + PAGE_SIZE - c, c,
 		"write device id xx-xxxxxxxxxxxx to remove slave\n");
 
 	return PAGE_SIZE - c;
@@ -785,7 +785,7 @@ int w1_attach_slave_device(struct w1_master *dev, struct w1_reg_num *rn)
 	spin_lock(&w1_flock);
 	f = w1_family_registered(rn->family);
 	if (!f) {
-		f= &w1_default_family;
+		f = &w1_default_family;
 		dev_info(&dev->dev, "Family %x for %02x.%012llx.%02x is not registered.\n",
 			 rn->family, rn->family,
 			 (unsigned long long)rn->id, rn->crc);
@@ -880,7 +880,7 @@ struct w1_master *w1_search_master_id(u32 id)
 	}
 	mutex_unlock(&w1_mlock);
 
-	return (found)?dev:NULL;
+	return found ? dev : NULL;
 }
 
 struct w1_slave *w1_search_slave(struct w1_reg_num *id)
@@ -909,7 +909,7 @@ struct w1_slave *w1_search_slave(struct w1_reg_num *id)
 	}
 	mutex_unlock(&w1_mlock);
 
-	return (found)?sl:NULL;
+	return found ? sl : NULL;
 }
 
 void w1_reconnect_slaves(struct w1_family *f, int attach)
@@ -960,7 +960,7 @@ void w1_slave_found(struct w1_master *dev, u64 rn)
 
 	atomic_inc(&dev->refcnt);
 
-	tmp = (struct w1_reg_num *) &rn;
+	tmp = (struct w1_reg_num *)&rn;
 
 	sl = w1_slave_search_device(dev, tmp);
 	if (sl) {
@@ -1007,12 +1007,11 @@ void w1_search(struct w1_master *dev, u8 search_type,
 
 	desc_bit = 64;
 
-	while ( !last_device && (slave_count++ < dev->max_slave_count) ) {
+	while (!last_device && (slave_count++ < dev->max_slave_count)) {
 		last_rn = rn;
 		rn = 0;
 
-		/*
-		 * Reset bus and all 1-wire device state machines
+		/* Reset bus and all 1-wire device state machines
 		 * so they can respond to our requests.
 		 *
 		 * Return 0 - device(s) present, 1 - no devices present.
@@ -1059,7 +1058,7 @@ void w1_search(struct w1_master *dev, u8 search_type,
 			triplet_ret = w1_triplet(dev, search_bit);
 
 			/* quit if no device responded */
-			if ( (triplet_ret & 0x03) == 0x03 )
+			if ((triplet_ret & 0x03) == 0x03)
 				break;
 
 			/* If both directions were valid, and we took the 0 path */
@@ -1078,13 +1077,14 @@ void w1_search(struct w1_master *dev, u8 search_type,
 		}
 		mutex_unlock(&dev->bus_mutex);
 
-		if ( (triplet_ret & 0x03) != 0x03 ) {
-			if ((desc_bit == last_zero) || (last_zero < 0)) {
+		if ((triplet_ret & 0x03) != 0x03) {
+			if (desc_bit == last_zero || last_zero < 0) {
 				last_device = 1;
 				dev->search_id = 0;
 			} else {
 				dev->search_id = rn;
 			}
+
 			desc_bit = last_zero;
 			cb(dev, rn);
 		}
@@ -1123,9 +1123,9 @@ void w1_search_process_cb(struct w1_master *dev, u8 search_type,
 			mutex_unlock(&dev->list_mutex);
 			w1_slave_detach(sl);
 			mutex_lock(&dev->list_mutex);
-		}
-		else if (test_bit(W1_SLAVE_ACTIVE, &sl->flags))
+		} else if (test_bit(W1_SLAVE_ACTIVE, &sl->flags)) {
 			sl->ttl = dev->slave_ttl;
+		}
 	}
 	mutex_unlock(&dev->list_mutex);
 
@@ -1156,7 +1156,8 @@ int w1_process_callbacks(struct w1_master *dev)
 		list_for_each_entry_safe(async_cmd, async_n, &dev->async_list,
 					 async_entry) {
 			/* drop the lock, if it is a search it can take a long
-			 * time */
+			 * time
+			 */
 			mutex_unlock(&dev->list_mutex);
 			async_cmd->cb(dev, async_cmd);
 			ret = 1;
@@ -1169,7 +1170,7 @@ int w1_process_callbacks(struct w1_master *dev)
 
 int w1_process(void *data)
 {
-	struct w1_master *dev = (struct w1_master *) data;
+	struct w1_master *dev = (struct w1_master *)data;
 	/* As long as w1_timeout is only set by a module parameter the sleep
 	 * time can be calculated in jiffies once.
 	 */
@@ -1179,7 +1180,6 @@ int w1_process(void *data)
 	unsigned long jremain = 0;
 
 	for (;;) {
-
 		if (!jremain && dev->search_count) {
 			mutex_lock(&dev->mutex);
 			w1_search_process(dev, W1_SEARCH);
@@ -1213,9 +1213,9 @@ int w1_process(void *data)
 			if (!jremain)
 				jremain = jtime;
 			jremain = schedule_timeout(jremain);
-		}
-		else
+		} else {
 			schedule();
+		}
 	}
 
 	atomic_dec(&dev->refcnt);
diff --git a/drivers/w1/w1_family.c b/drivers/w1/w1_family.c
index f351defbef23..e41e7c375fd2 100644
--- a/drivers/w1/w1_family.c
+++ b/drivers/w1/w1_family.c
@@ -83,7 +83,7 @@ EXPORT_SYMBOL(w1_unregister_family);
 /*
  * Should be called under w1_flock held.
  */
-struct w1_family * w1_family_registered(u8 fid)
+struct w1_family *w1_family_registered(u8 fid)
 {
 	struct list_head *ent, *n;
 	struct w1_family *f = NULL;
diff --git a/drivers/w1/w1_io.c b/drivers/w1/w1_io.c
index caf07bda18d1..688778cccf65 100644
--- a/drivers/w1/w1_io.c
+++ b/drivers/w1/w1_io.c
@@ -53,12 +53,13 @@ u8 w1_touch_bit(struct w1_master *dev, int bit)
 {
 	if (dev->bus_master->touch_bit)
 		return dev->bus_master->touch_bit(dev->bus_master->data, bit);
-	else if (bit)
+
+	if (bit)
 		return w1_read_bit(dev);
-	else {
-		w1_write_bit(dev, 0);
-		return 0;
-	}
+
+	w1_write_bit(dev, 0);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(w1_touch_bit);
 
@@ -140,18 +141,17 @@ void w1_write_8(struct w1_master *dev, u8 byte)
 	if (dev->bus_master->write_byte) {
 		w1_pre_write(dev);
 		dev->bus_master->write_byte(dev->bus_master->data, byte);
-	}
-	else
+	} else {
 		for (i = 0; i < 8; ++i) {
 			if (i == 7)
 				w1_pre_write(dev);
 			w1_touch_bit(dev, (byte >> i) & 0x1);
 		}
+	}
 	w1_post_write(dev);
 }
 EXPORT_SYMBOL_GPL(w1_write_8);
 
-
 /**
  * w1_read_bit() - Generates a write-1 cycle and samples the level.
  * @dev:	the master device
@@ -234,11 +234,12 @@ u8 w1_read_8(struct w1_master *dev)
 	int i;
 	u8 res = 0;
 
-	if (dev->bus_master->read_byte)
+	if (dev->bus_master->read_byte) {
 		res = dev->bus_master->read_byte(dev->bus_master->data);
-	else
+	} else {
 		for (i = 0; i < 8; ++i)
-			res |= (w1_touch_bit(dev,1) << i);
+			res |= (w1_touch_bit(dev, 1) << i);
+	}
 
 	return res;
 }
@@ -257,10 +258,10 @@ void w1_write_block(struct w1_master *dev, const u8 *buf, int len)
 	if (dev->bus_master->write_block) {
 		w1_pre_write(dev);
 		dev->bus_master->write_block(dev->bus_master->data, buf, len);
-	}
-	else
+	} else {
 		for (i = 0; i < len; ++i)
 			w1_write_8(dev, buf[i]); /* calls w1_pre_write */
+	}
 	w1_post_write(dev);
 }
 EXPORT_SYMBOL_GPL(w1_write_block);
@@ -327,9 +328,9 @@ int w1_reset_bus(struct w1_master *dev)
 	if (w1_disable_irqs)
 		local_irq_save(flags);
 
-	if (dev->bus_master->reset_bus)
+	if (dev->bus_master->reset_bus) {
 		result = dev->bus_master->reset_bus(dev->bus_master->data) & 0x1;
-	else {
+	} else {
 		dev->bus_master->write_bit(dev->bus_master->data, 0);
 		/* minimum 480, max ? us
 		 * be nice and sleep, except 18b20 spec lists 960us maximum,
@@ -358,7 +359,7 @@ int w1_reset_bus(struct w1_master *dev)
 }
 EXPORT_SYMBOL_GPL(w1_reset_bus);
 
-u8 w1_calc_crc8(u8 * data, int len)
+u8 w1_calc_crc8(u8 *data, int len)
 {
 	u8 crc = 0;
 
@@ -396,15 +397,16 @@ int w1_reset_select_slave(struct w1_slave *sl)
 	if (w1_reset_bus(sl->master))
 		return -1;
 
-	if (sl->master->slave_count == 1)
+	if (sl->master->slave_count == 1) {
 		w1_write_8(sl->master, W1_SKIP_ROM);
-	else {
+	} else {
 		u8 match[9] = {W1_MATCH_ROM, };
-		u64 rn = le64_to_cpu(*((u64*)&sl->reg_num));
+		u64 rn = le64_to_cpu(*((u64 *)&sl->reg_num));
 
 		memcpy(&match[1], &rn, 8);
 		w1_write_block(sl->master, match, 9);
 	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(w1_reset_select_slave);
diff --git a/drivers/w1/w1_netlink.c b/drivers/w1/w1_netlink.c
index 5e7adc76f643..9952c99aa3fc 100644
--- a/drivers/w1/w1_netlink.c
+++ b/drivers/w1/w1_netlink.c
@@ -35,6 +35,7 @@ struct w1_cb_block {
 	 * reply first_cn, data (w1_netlink_msg and w1_netlink_cmd)
 	 */
 };
+
 struct w1_cb_node {
 	struct w1_async_cmd async;
 	/* pointers within w1_cb_block and cn data */
@@ -178,7 +179,7 @@ static void w1_netlink_queue_status(struct w1_cb_block *block,
 	block->msg->status = (u8)-error;
 	if (req_cmd) {
 		struct w1_netlink_cmd *cmd =
-			(struct w1_netlink_cmd *) block->msg->data;
+			(struct w1_netlink_cmd *)block->msg->data;
 
 		memcpy(cmd, req_cmd, sizeof(*cmd));
 		block->cn->len += sizeof(*cmd);
@@ -400,7 +401,7 @@ static int w1_process_command_slave(struct w1_slave *sl,
 {
 	dev_dbg(&sl->master->dev, "%s: %02x.%012llx.%02x: cmd=%02x, len=%u.\n",
 		__func__, sl->reg_num.family,
-		(unsigned long long) sl->reg_num.id, sl->reg_num.crc, cmd->cmd,
+		(unsigned long long)sl->reg_num.id, sl->reg_num.crc, cmd->cmd,
 		cmd->len);
 
 	return w1_process_command_io(sl->master, cmd);
@@ -608,7 +609,7 @@ static void w1_cn_callback(struct cn_msg *cn, struct netlink_skb_parms *nsp)
 		 * space for replies which is the original message size plus
 		 * space for any list slave data and status messages
 		 * cn->len doesn't include itself which is part of the block
-		 * */
+		 */
 		size =  /* block + original message */
 			sizeof(struct w1_cb_block) + sizeof(*cn) + cn->len +
 			/* space for nodes */
@@ -645,7 +646,6 @@ static void w1_cn_callback(struct cn_msg *cn, struct netlink_skb_parms *nsp)
 
 	msg_len = cn->len;
 	while (msg_len && !err) {
-
 		dev = NULL;
 		sl = NULL;
 
-- 
2.11.0

