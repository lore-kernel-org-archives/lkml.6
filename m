Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87EB8C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B56208E5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="VnKlPySV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35B56208E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753287AbeGDPKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 11:10:16 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50191 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752528AbeGDPI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 11:08:26 -0400
Received: by mail-wm0-f66.google.com with SMTP id v25-v6so6365002wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 08:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/vu3zBlSww3fbIYXMeJOEU7sc8OaKhykES6IpLaYsf4=;
        b=VnKlPySVRYM03JgLEQ7ucbbeR/KbB3s7l3ULL1/l+iXsFUGqlCUiEMFrK+ShDWodg+
         TzZrZaYRUftmoHs3iTTC1XB10cbykwojSlq/ubRr7Yz5SqAgam1/U/H2PNmuhUtnpDh6
         u4M+16VlU58A4EPq7CFwQ7Q4F87hOV3xSx5V2C2YED2Q6UbtgoyW5ylH+8qSQpiaDV3F
         7B3rzHBRGnLWD+C3pcG3qr5z/1Tdkt6aZpkgKF/cEgop8VksF8y2k7O35WiRx7/Gd/sz
         /i5juk8bI10qoI52WP7/0/SwJiM42tFTZAD4MhvXLaDsu57mpw/ZpPHCURXluCTMYVQG
         8XQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/vu3zBlSww3fbIYXMeJOEU7sc8OaKhykES6IpLaYsf4=;
        b=RCiBvnKrS+v5fz6W0YgraT630NKBvpwJ7lR/Z/dj9fwvlVotc2sKy129GepfIrS+sP
         gpD0OWQDbI9tTYxaYAsL/e9gUVjTfnTSDX9037JJMF/7+QAUfy0GMUdXweZ2ulhPlheM
         KVecvqmLltoNhB8hkyVJPgIQeYOlqqa8hKCuRQNAuz7/5J7XSGsaGLJuXf8W20Yd35V3
         5JcH9fp86X0L3Dltxi3IPxccLChaM2On0vtH7uKcSHl8TMaf45j9vq5i0sSzmpdhbpz6
         ySOcVk3hIFsj2jBTJ1LDAzMtXsQwiiZ55aBT1l0a1FexDWC9eDKQh1M15J6gi7WyHJTb
         ghBw==
X-Gm-Message-State: APt69E3ADXANweZQI247rtaAgMzKp9iAv9h34lYRlXy0PvAP7y1RDOT9
        Ufe4DTW4KVNJj7wQK3PSO/gJUg==
X-Google-Smtp-Source: AAOMgpeEXVTRrTbDe+l0H+AefF/j9HaYSxO/EqPxJ7qO29QcMwqwWtzn+uMSL3hzHsxYBHAu/+QnLA==
X-Received: by 2002:a5d:41c1:: with SMTP id e1-v6mr1888172wrq.25.1530716905522;
        Wed, 04 Jul 2018 08:08:25 -0700 (PDT)
Received: from bender.baylibre.local ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id l7-v6sm9607737wmh.1.2018.07.04.08.08.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Jul 2018 08:08:24 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     airlied@linux.ie, hans.verkuil@cisco.com, lee.jones@linaro.org,
        olof@lixom.net, seanpaul@google.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>, sadolfsson@google.com,
        felixe@google.com, bleung@google.com, darekm@google.com,
        marcheu@chromium.org, fparent@baylibre.com,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        eballetbo@gmail.com
Subject: [PATCH v8 1/6] media: cec-notifier: Get notifier by device and connector name
Date:   Wed,  4 Jul 2018 17:08:16 +0200
Message-Id: <1530716901-30164-2-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530716901-30164-1-git-send-email-narmstrong@baylibre.com>
References: <1530716901-30164-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In non device-tree world, we can need to get the notifier by the driver
name directly and eventually defer probe if not yet created.

This patch adds a variant of the get function by using the device name
instead and will not create a notifier if not yet created.

But the i915 driver exposes at least 2 HDMI connectors, this patch also
adds the possibility to add a connector name tied to the notifier device
to form a tuple and associate different CEC controllers for each HDMI
connectors.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Hans Verkuil <hans.verkuil@cisco.com>
---
 drivers/media/cec/cec-notifier.c | 11 ++++++++---
 include/media/cec-notifier.h     | 27 ++++++++++++++++++++++++---
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/media/cec/cec-notifier.c b/drivers/media/cec/cec-notifier.c
index 16dffa0..dd2078b 100644
--- a/drivers/media/cec/cec-notifier.c
+++ b/drivers/media/cec/cec-notifier.c
@@ -21,6 +21,7 @@ struct cec_notifier {
 	struct list_head head;
 	struct kref kref;
 	struct device *dev;
+	const char *conn;
 	struct cec_adapter *cec_adap;
 	void (*callback)(struct cec_adapter *adap, u16 pa);
 
@@ -30,13 +31,14 @@ struct cec_notifier {
 static LIST_HEAD(cec_notifiers);
 static DEFINE_MUTEX(cec_notifiers_lock);
 
-struct cec_notifier *cec_notifier_get(struct device *dev)
+struct cec_notifier *cec_notifier_get_conn(struct device *dev, const char *conn)
 {
 	struct cec_notifier *n;
 
 	mutex_lock(&cec_notifiers_lock);
 	list_for_each_entry(n, &cec_notifiers, head) {
-		if (n->dev == dev) {
+		if (n->dev == dev &&
+		    (!conn || !strcmp(n->conn, conn))) {
 			kref_get(&n->kref);
 			mutex_unlock(&cec_notifiers_lock);
 			return n;
@@ -46,6 +48,8 @@ struct cec_notifier *cec_notifier_get(struct device *dev)
 	if (!n)
 		goto unlock;
 	n->dev = dev;
+	if (conn)
+		n->conn = kstrdup(conn, GFP_KERNEL);
 	n->phys_addr = CEC_PHYS_ADDR_INVALID;
 	mutex_init(&n->lock);
 	kref_init(&n->kref);
@@ -54,7 +58,7 @@ struct cec_notifier *cec_notifier_get(struct device *dev)
 	mutex_unlock(&cec_notifiers_lock);
 	return n;
 }
-EXPORT_SYMBOL_GPL(cec_notifier_get);
+EXPORT_SYMBOL_GPL(cec_notifier_get_conn);
 
 static void cec_notifier_release(struct kref *kref)
 {
@@ -62,6 +66,7 @@ static void cec_notifier_release(struct kref *kref)
 		container_of(kref, struct cec_notifier, kref);
 
 	list_del(&n->head);
+	kfree(n->conn);
 	kfree(n);
 }
 
diff --git a/include/media/cec-notifier.h b/include/media/cec-notifier.h
index cf0add7..814eeef 100644
--- a/include/media/cec-notifier.h
+++ b/include/media/cec-notifier.h
@@ -20,8 +20,10 @@ struct cec_notifier;
 #if IS_REACHABLE(CONFIG_CEC_CORE) && IS_ENABLED(CONFIG_CEC_NOTIFIER)
 
 /**
- * cec_notifier_get - find or create a new cec_notifier for the given device.
+ * cec_notifier_get_conn - find or create a new cec_notifier for the given
+ * device and connector tuple.
  * @dev: device that sends the events.
+ * @conn: the connector name from which the event occurs
  *
  * If a notifier for device @dev already exists, then increase the refcount
  * and return that notifier.
@@ -31,7 +33,8 @@ struct cec_notifier;
  *
  * Return NULL if the memory could not be allocated.
  */
-struct cec_notifier *cec_notifier_get(struct device *dev);
+struct cec_notifier *cec_notifier_get_conn(struct device *dev,
+					   const char *conn);
 
 /**
  * cec_notifier_put - decrease refcount and delete when the refcount reaches 0.
@@ -85,7 +88,8 @@ void cec_register_cec_notifier(struct cec_adapter *adap,
 			       struct cec_notifier *notifier);
 
 #else
-static inline struct cec_notifier *cec_notifier_get(struct device *dev)
+static inline struct cec_notifier *cec_notifier_get_conn(struct device *dev,
+							 const char *conn)
 {
 	/* A non-NULL pointer is expected on success */
 	return (struct cec_notifier *)0xdeadfeed;
@@ -121,6 +125,23 @@ static inline void cec_register_cec_notifier(struct cec_adapter *adap,
 #endif
 
 /**
+ * cec_notifier_get - find or create a new cec_notifier for the given device.
+ * @dev: device that sends the events.
+ *
+ * If a notifier for device @dev already exists, then increase the refcount
+ * and return that notifier.
+ *
+ * If it doesn't exist, then allocate a new notifier struct and return a
+ * pointer to that new struct.
+ *
+ * Return NULL if the memory could not be allocated.
+ */
+static inline struct cec_notifier *cec_notifier_get(struct device *dev)
+{
+	return cec_notifier_get_conn(dev, NULL);
+}
+
+/**
  * cec_notifier_phys_addr_invalidate() - set the physical address to INVALID
  *
  * @n: the CEC notifier
-- 
2.7.4

