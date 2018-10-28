Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239F4ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 22:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB66E2064C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 22:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=steffenvogel.de header.i=@steffenvogel.de header.b="crTxnUns"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB66E2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=steffenvogel.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbeJ2HGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 03:06:03 -0400
Received: from nag.0l.de ([207.154.252.120]:33480 "EHLO nag.0l.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725841AbeJ2HGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 03:06:02 -0400
From:   Steffen Vogel <post@steffenvogel.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffenvogel.de;
        s=2017; t=1540764601; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aUlh6ptyzuVQTpQPSQ0uAv0fx0Pk/HrpjD7cdK3uirA=;
        b=crTxnUnsSsrm8P4IJ7MLlQNv5VcxTiBeJaX6f8IsZjpKYC1745rfJ+ElEFIIptDhQKw5fC
        feZajjWcbVI8I/S2oLE4kz9aZdaFrDXAtmxF/lQXDn95if1hgnE/QLjYny3kQv3UM0j3kt
        Hew5aLETJTB3Aq7/qkuP8LXCE46/n22Py2NgSH4Q4TOD96mDqZOjw65oGtDdeEXLfo0XKR
        xm5bCWEF7DXFXOMAYfU9LcLoZoACaHOtmlAOB4v7Fyfy1EUn/dsxNHSqK4M5ng5NIJQZDz
        4+bLf224lgGgPxl4iy0+1WZC9tig81iI8jNxCy0B6bNGdNvEExeEWIiewoJx4w==
To:     linux-kernel@vger.kernel.org
Cc:     Evgeniy Polyakov <zbr@ioremap.net>,
        Steffen Vogel <post@steffenvogel.de>
Subject: [PATCH 3/9] w1: add newlines after declarations
Date:   Sun, 28 Oct 2018 23:09:22 +0100
Message-Id: <20181028220927.56227-4-post@steffenvogel.de>
In-Reply-To: <20181028220927.56227-1-post@steffenvogel.de>
References: <20181028220927.56227-1-post@steffenvogel.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=steffenvogel.de;
        s=2017; t=1540764601; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aUlh6ptyzuVQTpQPSQ0uAv0fx0Pk/HrpjD7cdK3uirA=;
        b=qZ1DzV2eK4DLpIbQgqQW09Qlx4xyghELo0gIH00VSNQ1+I6dDh0zufCEjko8l6YCd/8Io/
        /skLhy05zKejJoG4VoRzMsEKeuc/zlBr3qPqIrVBzE851CYguddfW2WjpvueoEXPv35vg7
        4QrQSaFR3X//16F4YtiQaskqamvjwV0nzFBgeb34FOUJFy3bg18voeG3M9hIdFvGTlVevx
        3/eh2QCe7ufPW4OsNUmWok1UwzzmmVyVoIVmaAiVD6z4zNNTbEAU96X1ctT9Ruijia+LD7
        WIsZcheEtIpcrXvlrpf27hLKfJXXarMAzqXPIq+jKAG/JICZg+kC3zSpLIeRSQ==
ARC-Seal: i=1; s=2017; d=steffenvogel.de; t=1540764601; a=rsa-sha256;
        cv=none;
        b=IpbXSAlHf5WtTfQEg6xjpdco2GkpgLW7wSlaItX/2PR5wlQPoY5d8/kl6h+fgtESxJGz0IK9puOugQ2C9YfG0pSR2ececcaDssZ++iQpf2eRPDDGPTCDa0XU6l8aVBlddGLZFO2n3X0yEFsfalShVMh/oRp5vxZYxOM65p1PyyTe7K5lH6ljZRZeAxk8jiefz5KtNXmHn8CQC+0HVlptwJOgOzlFtd8OKvlaJd5lpcOJJEnERvdq94oBTwWchvC6CCRVh+1FQ6tTQRWf+PrOSJHVpduvcXr9SUi1393d1txM3vaKAmUyiMqcTm4YkI2VT3hFGmPO4GmFz7dsYD5Upg==
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
index bd95dfe4041d..812186ce35d6 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -130,6 +130,7 @@ static ssize_t rw_write(struct file *filp, struct kobject *kobj,
 
 out_up:
 	mutex_unlock(&sl->master->mutex);
+
 	return count;
 }
 
@@ -142,6 +143,7 @@ static ssize_t rw_read(struct file *filp, struct kobject *kobj,
 	mutex_lock(&sl->master->mutex);
 	w1_read_block(sl->master, buf, count);
 	mutex_unlock(&sl->master->mutex);
+
 	return count;
 }
 
@@ -297,6 +299,7 @@ static ssize_t w1_master_attribute_show_pointer(struct device *dev,
 	mutex_lock(&md->mutex);
 	count = sprintf(buf, "0x%p\n", md->bus_master);
 	mutex_unlock(&md->mutex);
+
 	return count;
 }
 
@@ -304,7 +307,9 @@ static ssize_t w1_master_attribute_show_timeout(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
 	ssize_t count;
+
 	count = sprintf(buf, "%d\n", w1_timeout);
+
 	return count;
 }
 
@@ -312,7 +317,9 @@ static ssize_t w1_master_attribute_show_timeout_us(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
 	ssize_t count;
+
 	count = sprintf(buf, "%d\n", w1_timeout_us);
+
 	return count;
 }
 
@@ -369,6 +376,7 @@ static ssize_t w1_master_attribute_show_slave_count(struct device *dev,
 	mutex_lock(&md->mutex);
 	count = sprintf(buf, "%d\n", md->slave_count);
 	mutex_unlock(&md->mutex);
+
 	return count;
 }
 
@@ -399,8 +407,10 @@ static ssize_t w1_master_attribute_show_add(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
 	int c = PAGE_SIZE;
+
 	c -= snprintf(buf+PAGE_SIZE - c, c,
 		"write device id xx-xxxxxxxxxxxx to add slave\n");
+
 	return PAGE_SIZE - c;
 }
 
@@ -449,6 +459,7 @@ struct w1_slave *w1_slave_search_device(struct w1_master *dev,
 	struct w1_reg_num *rn)
 {
 	struct w1_slave *sl;
+
 	mutex_lock(&dev->list_mutex);
 	list_for_each_entry(sl, &dev->slist, w1_slave_entry) {
 		if (sl->reg_num.family == rn->family &&
@@ -459,6 +470,7 @@ struct w1_slave *w1_slave_search_device(struct w1_master *dev,
 		}
 	}
 	mutex_unlock(&dev->list_mutex);
+
 	return NULL;
 }
 
@@ -495,8 +507,10 @@ static ssize_t w1_master_attribute_show_remove(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
 	int c = PAGE_SIZE;
+
 	c -= snprintf(buf+PAGE_SIZE - c, c,
 		"write device id xx-xxxxxxxxxxxx to remove slave\n");
+
 	return PAGE_SIZE - c;
 }
 
@@ -674,6 +688,7 @@ static int w1_family_notify(unsigned long action, struct w1_slave *sl)
 			sysfs_remove_groups(&sl->dev.kobj, fops->groups);
 		break;
 	}
+
 	return 0;
 }
 
@@ -709,6 +724,7 @@ static int __w1_attach_slave_device(struct w1_slave *sl)
 			"Device registration [%s] failed. err=%d\n",
 			dev_name(&sl->dev), err);
 		put_device(&sl->dev);
+
 		return err;
 	}
 	w1_family_notify(BUS_NOTIFY_ADD_DEVICE, sl);
@@ -777,6 +793,7 @@ int w1_attach_slave_device(struct w1_master *dev, struct w1_reg_num *rn)
 		w1_family_put(sl->family);
 		atomic_dec(&sl->master->refcnt);
 		kfree(sl);
+
 		return err;
 	}
 
@@ -793,6 +810,7 @@ int w1_unref_slave(struct w1_slave *sl)
 {
 	struct w1_master *dev = sl->master;
 	int refcnt;
+
 	mutex_lock(&dev->list_mutex);
 	refcnt = atomic_sub_return(1, &sl->refcnt);
 	if (refcnt == 0) {
@@ -817,6 +835,7 @@ int w1_unref_slave(struct w1_slave *sl)
 	}
 	atomic_dec(&dev->refcnt);
 	mutex_unlock(&dev->list_mutex);
+
 	return refcnt;
 }
 
@@ -824,6 +843,7 @@ int w1_slave_detach(struct w1_slave *sl)
 {
 	/* Only detach a slave once as it decreases the refcnt each time. */
 	int destroy_now;
+
 	mutex_lock(&sl->master->list_mutex);
 	destroy_now = !test_bit(W1_SLAVE_DETACH, &sl->flags);
 	set_bit(W1_SLAVE_DETACH, &sl->flags);
@@ -831,6 +851,7 @@ int w1_slave_detach(struct w1_slave *sl)
 
 	if (destroy_now)
 		destroy_now = !w1_unref_slave(sl);
+
 	return destroy_now ? 0 : -EBUSY;
 }
 
@@ -996,6 +1017,7 @@ void w1_search(struct w1_master *dev, u8 search_type,
 		/* Do fast search on single slave bus */
 		if (dev->max_slave_count == 1) {
 			int rv;
+
 			w1_write_8(dev, W1_READ_ROM);
 			rv = w1_read_block(dev, (u8 *)&rn, 8);
 			mutex_unlock(&dev->bus_mutex);
@@ -1127,6 +1149,7 @@ int w1_process_callbacks(struct w1_master *dev)
 			mutex_lock(&dev->list_mutex);
 		}
 	}
+
 	return ret;
 }
 
diff --git a/drivers/w1/w1_netlink.c b/drivers/w1/w1_netlink.c
index 54a82bf69566..ff858bf4a94d 100644
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
 
@@ -165,6 +167,7 @@ static void w1_netlink_queue_status(struct w1_cb_block *block,
 	int error)
 {
 	u16 space = sizeof(struct cn_msg) + sizeof(*req_msg) + sizeof(*req_cmd);
+
 	w1_reply_make_space(block, space);
 	w1_netlink_setup_msg(block, block->request_cn.ack);
 
@@ -276,6 +279,7 @@ static int w1_get_slaves(struct w1_master *dev, struct w1_netlink_cmd *req_cmd)
 
 	if (req_cmd->cmd == W1_CMD_LIST_SLAVES) {
 		u64 rn;
+
 		mutex_lock(&dev->list_mutex);
 		list_for_each_entry(sl, &dev->slist, w1_slave_entry) {
 			memcpy(&rn, &sl->reg_num, sizeof(rn));
@@ -508,6 +512,7 @@ static void w1_list_count_cmds(struct w1_netlink_msg *msg, int *cmd_count,
 	u16 mlen = msg->len;
 	u16 len;
 	int slave_list = 0;
+
 	while (mlen) {
 		if (cmd->len + sizeof(struct w1_netlink_cmd) > mlen)
 			break;
@@ -526,6 +531,7 @@ static void w1_list_count_cmds(struct w1_netlink_msg *msg, int *cmd_count,
 
 	if (slave_list) {
 		struct w1_master *dev = w1_search_master_id(msg->id.mst.id);
+
 		if (dev) {
 			/* Bytes, and likely an overstimate, and if it isn't
 			 * the results can still be split between packets.
@@ -586,6 +592,7 @@ static void w1_cn_callback(struct cn_msg *cn, struct netlink_skb_parms *nsp)
 	if (node_count) {
 		int size;
 		int reply_size = sizeof(*cn) + cn->len + slave_len;
+
 		if (cn->flags & W1_CN_BUNDLE) {
 			/* bundling duplicats some of the messages */
 			reply_size += 2 * cmd_count * (sizeof(struct cn_msg) +
-- 
2.11.0

