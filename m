Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0D2C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 03:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A6FD20843
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 03:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=steffenvogel.de header.i=@steffenvogel.de header.b="TLflfOqU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A6FD20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=steffenvogel.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbeJ2L63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 07:58:29 -0400
Received: from nag.0l.de ([207.154.252.120]:44740 "EHLO nag.0l.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729185AbeJ2L63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 07:58:29 -0400
From:   Steffen Vogel <post@steffenvogel.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffenvogel.de;
        s=2017; t=1540782276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RWl7YGoYgcFScVWInfImYX3Ry9lu9aD34p6tUTUEaWU=;
        b=TLflfOqU05hJok9GVkUYAqe9irCxj8BADbURcBTLqfFcLBJUFAhHHdIljzv+F0mJ+eGfyq
        t5+hh/8limf1dDMtmwlpxoWFfjuaEpwjFe4VHMTgzLGwufGha2/l6i7FB9PPX9zgo1sNn6
        Z3APybf9lZ0b3wAC/cv9+TUfDDtMzwTLV9KbFYsD8bGB+2f+1Og7uacsjRjHzTkisluig4
        nD64254kJdDaIlX+42A/6gsQfifoBtGg6c1mizjBW0lmuq1gza00QPgyEL6HlASmtfO66W
        TmOfr9CKzdWnKlW52ItSQQzh9N3XaA6PgF3GQFBAqXaLTR6gJMpiHvwH2yCEmg==
To:     linux-kernel@vger.kernel.org
Cc:     Evgeniy Polyakov <zbr@ioremap.net>, Joe Perches <joe@perches.com>,
        Steffen Vogel <post@steffenvogel.de>
Subject: [PATCH v2 03/12] w1: add newlines after declarations
Date:   Mon, 29 Oct 2018 04:03:33 +0100
Message-Id: <1dd8e38bf28bff6100a02679e041f58496ea9fe6.1540782140.git.post@steffenvogel.de>
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
        bh=RWl7YGoYgcFScVWInfImYX3Ry9lu9aD34p6tUTUEaWU=;
        b=VCmOIIPmLVPk3YmyjJUgNinfdSu4tywYANw6L1apBUwxLXbkSTGJiDYAAAWoaHjxC/oUtI
        0MHrju1SeknNBd6rRTBKyT0Gg0D5Ex3o9wWO+NTjDtkkgjzb5Fwxtpr2dt2CdEPIhmInKm
        53Jowlat3M3LC/SO2kF/Mhu5SY5amUs0B1AqkIHVfCyAEzpENxujw2AqRPuQmp9bZwJaTc
        lO8NS9fgTFTX3rlGzxkhjWOVFhK+iVNfQYCpmYgSzIO9iBs/3ef9ryon47H+9iCAZ7ml1z
        26eD2u1A8EOFRp4pdkpjrda6itlqbJ197TANhVRhffc2sUfTsBbPtLTX9U3TDQ==
ARC-Seal: i=1; s=2017; d=steffenvogel.de; t=1540782276; a=rsa-sha256;
        cv=none;
        b=mEdHSTxAwv3lk3daqem+3RS5rdfLKXfvcOcPD4CKmBa1/ptIe7QcOQkcudyHV+pUJHnVnQ0VqApeKRjHTeTp33EyyGzqQk59Dm1H/oMWeO22ba/Vih+J1dhnQZFx4xglpUhRhc97a6fOqiW5N2F6B39IezL45j6wxRKJvlUrDF2NkAo2I4SPIJKNkXKu9bOQwyM0oALeobmTu+XeGdQB2+Bx+IzfLNiFqA4ySwggEyCyFynWDZFnphtsHOpc5UAJWue6gVwWNP9MAdY55b0ERsn5vSr7liQmw5vhlLa9vdWRvDvoNEY6uCUPcJ224fpvlcoQmG1AIfJy/GOqabpAtA==
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
 drivers/w1/w1.c         | 23 +++++++++++++++++++++++
 drivers/w1/w1_netlink.c |  7 +++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index 6b3cdc5a09fb..48c20639f75f 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -128,6 +128,7 @@ static ssize_t rw_write(struct file *filp, struct kobject *kobj,
 
 out_up:
 	mutex_unlock(&sl->master->mutex);
+
 	return count;
 }
 
@@ -140,6 +141,7 @@ static ssize_t rw_read(struct file *filp, struct kobject *kobj,
 	mutex_lock(&sl->master->mutex);
 	w1_read_block(sl->master, buf, count);
 	mutex_unlock(&sl->master->mutex);
+
 	return count;
 }
 
@@ -296,6 +298,7 @@ static ssize_t w1_master_attribute_show_pointer(struct device *dev,
 	mutex_lock(&md->mutex);
 	count = sprintf(buf, "0x%p\n", md->bus_master);
 	mutex_unlock(&md->mutex);
+
 	return count;
 }
 
@@ -304,7 +307,9 @@ static ssize_t w1_master_attribute_show_timeout(struct device *dev,
 						char *buf)
 {
 	ssize_t count;
+
 	count = sprintf(buf, "%d\n", w1_timeout);
+
 	return count;
 }
 
@@ -313,7 +318,9 @@ static ssize_t w1_master_attribute_show_timeout_us(struct device *dev,
 						   char *buf)
 {
 	ssize_t count;
+
 	count = sprintf(buf, "%d\n", w1_timeout_us);
+
 	return count;
 }
 
@@ -375,6 +382,7 @@ static ssize_t w1_master_attribute_show_slave_count(struct device *dev,
 	mutex_lock(&md->mutex);
 	count = sprintf(buf, "%d\n", md->slave_count);
 	mutex_unlock(&md->mutex);
+
 	return count;
 }
 
@@ -407,8 +415,10 @@ static ssize_t w1_master_attribute_show_add(struct device *dev,
 					    char *buf)
 {
 	int c = PAGE_SIZE;
+
 	c -= snprintf(buf+PAGE_SIZE - c, c,
 		"write device id xx-xxxxxxxxxxxx to add slave\n");
+
 	return PAGE_SIZE - c;
 }
 
@@ -457,6 +467,7 @@ struct w1_slave *w1_slave_search_device(struct w1_master *dev,
 					struct w1_reg_num *rn)
 {
 	struct w1_slave *sl;
+
 	mutex_lock(&dev->list_mutex);
 	list_for_each_entry(sl, &dev->slist, w1_slave_entry) {
 		if (sl->reg_num.family == rn->family &&
@@ -467,6 +478,7 @@ struct w1_slave *w1_slave_search_device(struct w1_master *dev,
 		}
 	}
 	mutex_unlock(&dev->list_mutex);
+
 	return NULL;
 }
 
@@ -504,8 +516,10 @@ static ssize_t w1_master_attribute_show_remove(struct device *dev,
 					       char *buf)
 {
 	int c = PAGE_SIZE;
+
 	c -= snprintf(buf+PAGE_SIZE - c, c,
 		"write device id xx-xxxxxxxxxxxx to remove slave\n");
+
 	return PAGE_SIZE - c;
 }
 
@@ -684,6 +698,7 @@ static int w1_family_notify(unsigned long action, struct w1_slave *sl)
 			sysfs_remove_groups(&sl->dev.kobj, fops->groups);
 		break;
 	}
+
 	return 0;
 }
 
@@ -719,6 +734,7 @@ static int __w1_attach_slave_device(struct w1_slave *sl)
 			"Device registration [%s] failed. err=%d\n",
 			dev_name(&sl->dev), err);
 		put_device(&sl->dev);
+
 		return err;
 	}
 	w1_family_notify(BUS_NOTIFY_ADD_DEVICE, sl);
@@ -787,6 +803,7 @@ int w1_attach_slave_device(struct w1_master *dev, struct w1_reg_num *rn)
 		w1_family_put(sl->family);
 		atomic_dec(&sl->master->refcnt);
 		kfree(sl);
+
 		return err;
 	}
 
@@ -803,6 +820,7 @@ int w1_unref_slave(struct w1_slave *sl)
 {
 	struct w1_master *dev = sl->master;
 	int refcnt;
+
 	mutex_lock(&dev->list_mutex);
 	refcnt = atomic_sub_return(1, &sl->refcnt);
 	if (refcnt == 0) {
@@ -827,6 +845,7 @@ int w1_unref_slave(struct w1_slave *sl)
 	}
 	atomic_dec(&dev->refcnt);
 	mutex_unlock(&dev->list_mutex);
+
 	return refcnt;
 }
 
@@ -834,6 +853,7 @@ int w1_slave_detach(struct w1_slave *sl)
 {
 	/* Only detach a slave once as it decreases the refcnt each time. */
 	int destroy_now;
+
 	mutex_lock(&sl->master->list_mutex);
 	destroy_now = !test_bit(W1_SLAVE_DETACH, &sl->flags);
 	set_bit(W1_SLAVE_DETACH, &sl->flags);
@@ -841,6 +861,7 @@ int w1_slave_detach(struct w1_slave *sl)
 
 	if (destroy_now)
 		destroy_now = !w1_unref_slave(sl);
+
 	return destroy_now ? 0 : -EBUSY;
 }
 
@@ -1006,6 +1027,7 @@ void w1_search(struct w1_master *dev, u8 search_type,
 		/* Do fast search on single slave bus */
 		if (dev->max_slave_count == 1) {
 			int rv;
+
 			w1_write_8(dev, W1_READ_ROM);
 			rv = w1_read_block(dev, (u8 *)&rn, 8);
 			mutex_unlock(&dev->bus_mutex);
@@ -1141,6 +1163,7 @@ int w1_process_callbacks(struct w1_master *dev)
 			mutex_lock(&dev->list_mutex);
 		}
 	}
+
 	return ret;
 }
 
diff --git a/drivers/w1/w1_netlink.c b/drivers/w1/w1_netlink.c
index 7ef46d8ab059..5e7adc76f643 100644
--- a/drivers/w1/w1_netlink.c
+++ b/drivers/w1/w1_netlink.c
@@ -63,6 +63,7 @@ static void w1_unref_block(struct w1_cb_block *block)
 {
 	if (atomic_sub_return(1, &block->refcnt) == 0) {
 		u16 len = w1_reply_len(block);
+
 		if (len) {
 			cn_netlink_send_mult(block->first_cn, len,
 					     block->portid, 0, GFP_KERNEL);
@@ -137,6 +138,7 @@ static void w1_netlink_queue_cmd(struct w1_cb_block *block,
 				 struct w1_netlink_cmd *cmd)
 {
 	u32 space;
+
 	w1_reply_make_space(block, sizeof(struct cn_msg) +
 		sizeof(struct w1_netlink_msg) + sizeof(*cmd) + cmd->len);
 
@@ -166,6 +168,7 @@ static void w1_netlink_queue_status(struct w1_cb_block *block,
 				    int error)
 {
 	u16 space = sizeof(struct cn_msg) + sizeof(*req_msg) + sizeof(*req_cmd);
+
 	w1_reply_make_space(block, space);
 	w1_netlink_setup_msg(block, block->request_cn.ack);
 
@@ -278,6 +281,7 @@ static int w1_get_slaves(struct w1_master *dev, struct w1_netlink_cmd *req_cmd)
 
 	if (req_cmd->cmd == W1_CMD_LIST_SLAVES) {
 		u64 rn;
+
 		mutex_lock(&dev->list_mutex);
 		list_for_each_entry(sl, &dev->slist, w1_slave_entry) {
 			memcpy(&rn, &sl->reg_num, sizeof(rn));
@@ -510,6 +514,7 @@ static void w1_list_count_cmds(struct w1_netlink_msg *msg, int *cmd_count,
 	u16 mlen = msg->len;
 	u16 len;
 	int slave_list = 0;
+
 	while (mlen) {
 		if (cmd->len + sizeof(struct w1_netlink_cmd) > mlen)
 			break;
@@ -528,6 +533,7 @@ static void w1_list_count_cmds(struct w1_netlink_msg *msg, int *cmd_count,
 
 	if (slave_list) {
 		struct w1_master *dev = w1_search_master_id(msg->id.mst.id);
+
 		if (dev) {
 			/* Bytes, and likely an overstimate, and if it isn't
 			 * the results can still be split between packets.
@@ -588,6 +594,7 @@ static void w1_cn_callback(struct cn_msg *cn, struct netlink_skb_parms *nsp)
 	if (node_count) {
 		int size;
 		int reply_size = sizeof(*cn) + cn->len + slave_len;
+
 		if (cn->flags & W1_CN_BUNDLE) {
 			/* bundling duplicats some of the messages */
 			reply_size += 2 * cmd_count * (sizeof(struct cn_msg) +
-- 
2.11.0

