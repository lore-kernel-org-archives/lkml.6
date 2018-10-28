Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE84CC6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 22:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A80E20843
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 22:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=steffenvogel.de header.i=@steffenvogel.de header.b="aW0bFvaN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A80E20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=steffenvogel.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbeJ2HGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 03:06:02 -0400
Received: from nag.0l.de ([207.154.252.120]:33464 "EHLO nag.0l.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727251AbeJ2HGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 03:06:01 -0400
From:   Steffen Vogel <post@steffenvogel.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffenvogel.de;
        s=2017; t=1540764601; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PAgujbtqO4TqrpyUG1Gx0jiGTE50eJZ4PAdukjYCckQ=;
        b=aW0bFvaNFhZFIhyQtdS1RfBzPozyuYC1bz5OAfTtVBvhklQTe2Cj7P7RKK+IP4o0AYrELP
        1s1VwA49yMsTiNKBYF2hoTzthZtcHt2GQ3k01peJQdg3Gjha0GVIMUitBeNHmAuXEf8427
        lhOp3TfIXicMMrVDA48rGXOaWOarhqzcKyyW8VhvCWZMwsh1cPk2d3P53XquQlxYSAT7FU
        BfKQUNcKjN8QsAwGSYLvlRemOJ84DcBw5hY78SvRI85uYr+K4dYMr5rYEHXCpZITTBohqu
        3q5k9JSqh6B1j+1/QNJXMDM0fKVpJgUqLe3DNXsm0/yarUNL9LTeHLc41UvFJg==
To:     linux-kernel@vger.kernel.org
Cc:     Evgeniy Polyakov <zbr@ioremap.net>,
        Steffen Vogel <post@steffenvogel.de>
Subject: [PATCH 4/9] w1: cleanup whitespaces according to coding style document
Date:   Sun, 28 Oct 2018 23:09:23 +0100
Message-Id: <20181028220927.56227-5-post@steffenvogel.de>
In-Reply-To: <20181028220927.56227-1-post@steffenvogel.de>
References: <20181028220927.56227-1-post@steffenvogel.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=steffenvogel.de;
        s=2017; t=1540764601; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PAgujbtqO4TqrpyUG1Gx0jiGTE50eJZ4PAdukjYCckQ=;
        b=Nin/dZPOSbtZNYxw3uVXlvkrrrb5jaAaQVhAVVaJ7D0wn44NaOFFGoS2UICBYjY0oquREv
        5weNlhkplWKDbrogrqAIhFhYn2Y5nloW8Tw3GM0+OQ69NeFNAW24phvk98nZ6hJeR+DnP2
        K6+mHIkrngD/A3WxiizEqoNxrKX+UKxK9eMvBnJSjl4gGyG9Vjs2sSZ82C/VQvejh9Mv6v
        d7wOBFjZSVbg1K+Zw5lihi7xjq5KMot1ay5mbxC5aljnftLpT5Ki5nOzw6FZ7aSfUYor5y
        BUInbOE02w4F8Uy3/PvmgKRnfM2uh75cVmV5IEmOmcRYPtsueXszg+MS8o8U/A==
ARC-Seal: i=1; s=2017; d=steffenvogel.de; t=1540764601; a=rsa-sha256;
        cv=none;
        b=v6tSyRCyRBxCmpufmurh+EbDy1NKSHdorASWOghKfNhseAuX5lHpgS6RfDw0SWkxiOd1HQ5Q8L6tSRfqrJDISGXqqQQCppxss8/PIkTmKaVnlD2s1iwIEF/RgMftCQ5ULu6s/3yyyb+jRau4NbaCqirCHjTGd0ezXdV/ZcnVgsZ688nLTXlcNlqo9+2xEHsXAMaZEv19Fr12/gM3nzuvxMRWsLpogTIvQ2bmof0rSPMf1b2nDSmtPEB4J6CDi5/kH6k9yWHbjj29HDR5e2x4sFuPXFLLBFPlVStiVy1PTunXLixzYfm0lSmAjioyxpiyRDmqEknWMxUh3MlMuv2M+g==
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
 drivers/w1/w1.c         | 20 +++++++++-----------
 drivers/w1/w1_family.c  |  2 +-
 drivers/w1/w1_io.c      | 17 +++++++++--------
 drivers/w1/w1_netlink.c |  2 +-
 4 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index 812186ce35d6..f64da16dbec9 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -775,7 +775,7 @@ int w1_attach_slave_device(struct w1_master *dev, struct w1_reg_num *rn)
 	spin_lock(&w1_flock);
 	f = w1_family_registered(rn->family);
 	if (!f) {
-		f= &w1_default_family;
+		f = &w1_default_family;
 		dev_info(&dev->dev, "Family %x for %02x.%012llx.%02x is not registered.\n",
 			  rn->family, rn->family,
 			  (unsigned long long)rn->id, rn->crc);
@@ -997,7 +997,7 @@ void w1_search(struct w1_master *dev, u8 search_type,
 
 	desc_bit = 64;
 
-	while ( !last_device && (slave_count++ < dev->max_slave_count) ) {
+	while (!last_device && (slave_count++ < dev->max_slave_count)) {
 		last_rn = rn;
 		rn = 0;
 
@@ -1045,7 +1045,7 @@ void w1_search(struct w1_master *dev, u8 search_type,
 			triplet_ret = w1_triplet(dev, search_bit);
 
 			/* quit if no device responded */
-			if ( (triplet_ret & 0x03) == 0x03 )
+			if ((triplet_ret & 0x03) == 0x03)
 				break;
 
 			/* If both directions were valid, and we took the 0 path */
@@ -1064,13 +1064,12 @@ void w1_search(struct w1_master *dev, u8 search_type,
 		}
 		mutex_unlock(&dev->bus_mutex);
 
-		if ( (triplet_ret & 0x03) != 0x03 ) {
+		if ((triplet_ret & 0x03) != 0x03) {
 			if ((desc_bit == last_zero) || (last_zero < 0)) {
 				last_device = 1;
 				dev->search_id = 0;
-			} else {
+			} else
 				dev->search_id = rn;
-			}
 			desc_bit = last_zero;
 			cb(dev, rn);
 		}
@@ -1109,8 +1108,7 @@ void w1_search_process_cb(struct w1_master *dev, u8 search_type,
 			mutex_unlock(&dev->list_mutex);
 			w1_slave_detach(sl);
 			mutex_lock(&dev->list_mutex);
-		}
-		else if (test_bit(W1_SLAVE_ACTIVE, &sl->flags))
+		} else if (test_bit(W1_SLAVE_ACTIVE, &sl->flags))
 			sl->ttl = dev->slave_ttl;
 	}
 	mutex_unlock(&dev->list_mutex);
@@ -1142,7 +1140,8 @@ int w1_process_callbacks(struct w1_master *dev)
 		list_for_each_entry_safe(async_cmd, async_n, &dev->async_list,
 			async_entry) {
 			/* drop the lock, if it is a search it can take a long
-			 * time */
+			 * time
+			 */
 			mutex_unlock(&dev->list_mutex);
 			async_cmd->cb(dev, async_cmd);
 			ret = 1;
@@ -1199,8 +1198,7 @@ int w1_process(void *data)
 			if (!jremain)
 				jremain = jtime;
 			jremain = schedule_timeout(jremain);
-		}
-		else
+		} else
 			schedule();
 	}
 
diff --git a/drivers/w1/w1_family.c b/drivers/w1/w1_family.c
index ee90a6733472..5abbeb86de6e 100644
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
index 2626a61852e9..283c89708c7c 100644
--- a/drivers/w1/w1_io.c
+++ b/drivers/w1/w1_io.c
@@ -140,13 +140,13 @@ void w1_write_8(struct w1_master *dev, u8 byte)
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
@@ -236,9 +236,10 @@ u8 w1_read_8(struct w1_master *dev)
 
 	if (dev->bus_master->read_byte)
 		res = dev->bus_master->read_byte(dev->bus_master->data);
-	else
+	else {
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
@@ -358,7 +359,7 @@ int w1_reset_bus(struct w1_master *dev)
 }
 EXPORT_SYMBOL_GPL(w1_reset_bus);
 
-u8 w1_calc_crc8(u8 * data, int len)
+u8 w1_calc_crc8(u8 *data, int len)
 {
 	u8 crc = 0;
 
@@ -400,7 +401,7 @@ int w1_reset_select_slave(struct w1_slave *sl)
 		w1_write_8(sl->master, W1_SKIP_ROM);
 	else {
 		u8 match[9] = {W1_MATCH_ROM, };
-		u64 rn = le64_to_cpu(*((u64*)&sl->reg_num));
+		u64 rn = le64_to_cpu(*((u64 *)&sl->reg_num));
 
 		memcpy(&match[1], &rn, 8);
 		w1_write_block(sl->master, match, 9);
diff --git a/drivers/w1/w1_netlink.c b/drivers/w1/w1_netlink.c
index ff858bf4a94d..b0c7abddd091 100644
--- a/drivers/w1/w1_netlink.c
+++ b/drivers/w1/w1_netlink.c
@@ -606,7 +606,7 @@ static void w1_cn_callback(struct cn_msg *cn, struct netlink_skb_parms *nsp)
 		 * space for replies which is the original message size plus
 		 * space for any list slave data and status messages
 		 * cn->len doesn't include itself which is part of the block
-		 * */
+		 */
 		size =  /* block + original message */
 			sizeof(struct w1_cb_block) + sizeof(*cn) + cn->len +
 			/* space for nodes */
-- 
2.11.0

