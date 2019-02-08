Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7ACC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30FED20863
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sk/TVzQn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbfBHRzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:55:22 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50856 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727291AbfBHRzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:55:22 -0500
Received: by mail-wm1-f65.google.com with SMTP id z5so4497905wmf.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 09:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=beAq55IerBLB4oPI+Hv3Vh7cxwg89eky+TIgBx+dpU4=;
        b=Sk/TVzQnzcOlskkXJ9RKFRzk/+JZ2CIxueOOAOmDDOGEMfEL9S99Kce2uqWQIlcCVY
         tVMMTw5gmTtXfdjaGEufLZDId8k1lGp5W3ub3p8dvFaRUO3i7XJJ/YKiZKMwTpyuhGCb
         nHP/WCzPpR9h7VR/yHvfLR9SYquDChEFE3Q2XXRBw6EgqrBtZmWmD9OJ1d7/gQ5sJ67I
         rXxV7GMEIsVzRazt7R8yRAtjwbNfBp9K1MzBrGpPb1In/ZFBBc6GjdXwECN/yKvypp4B
         +6c9r+xSl+42KEe8Gh1/QlKxQE73H6dc5n80seBkkeH3kriKRyeVH+rerux5m8Nt2VMY
         oLWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=beAq55IerBLB4oPI+Hv3Vh7cxwg89eky+TIgBx+dpU4=;
        b=ZlRHT6MurWsNGqQDM+GB/ovQfvYSyXYxJQRYe+l6q5DEULSlvUkXiPpUCsaR4wCK3f
         3nYkBDshchTxbz1Pkc7cLsWjKDz/iECllz8J+KZXDkz+swWn8GxvFDTuqgFpwljRDnag
         XCdSZx+uymJLUlU72CelIgAqelQjkPQzRwi8Fr9CJJq5yTcOsrQFU9zg1a22pbWkzMaB
         QZp/Oaz50QvuvtcVALzpSuJlZvlIeG1aK8f0mC3ubYRUe0eFbajZfDZZT5XVdfPqOCQg
         /JiXChpFQwc0l2oy2khbT5q9ghrv8Iq2lF7A2A1vwM3NFadUZ/OJ0WFbupgd2Jwpy5DP
         ifmA==
X-Gm-Message-State: AHQUAubNV5fEWQz43KHBd/2Nriu38I9xXa8B53aeicjgPDY9C58E4BnI
        zL5mTtgzFaf/xzLUCR4ripNz5Q==
X-Google-Smtp-Source: AHgI3IaYE2gbqCdMFXzZST+PSoQGc01l5ZmiJZ475LI/3TLGZg0z9yQZYqWEzy5LI2C4ddYU388IkQ==
X-Received: by 2002:a1c:ab87:: with SMTP id u129mr12607012wme.104.1549648519604;
        Fri, 08 Feb 2019 09:55:19 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id f134sm3455765wme.31.2019.02.08.09.55.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Feb 2019 09:55:18 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     andy.gross@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, rohitkr@codeaurora.org,
        bgoswami@codeaurora.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH v2] qcom: apr: Make apr callbacks in non-atomic context
Date:   Fri,  8 Feb 2019 17:55:10 +0000
Message-Id: <20190208175510.26837-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

APR communication with DSP is not atomic in nature.
Its request-response type. Trying to pretend that these are atomic
and invoking apr client callbacks directly under atomic/irq context has
endless issues with soundcard. It makes more sense to convert these
to nonatomic calls. This also coverts all the dais to be nonatomic.

All the callbacks are now invoked as part of rx work queue.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
Changes since v1:
 - flush and destroy work queue after removing the device
	 to avoid active communication from device. suggested by Bjorn.

 drivers/soc/qcom/apr.c | 74 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 69 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/qcom/apr.c b/drivers/soc/qcom/apr.c
index 74f8b9607daa..039e3aa6f5e0 100644
--- a/drivers/soc/qcom/apr.c
+++ b/drivers/soc/qcom/apr.c
@@ -8,6 +8,7 @@
 #include <linux/spinlock.h>
 #include <linux/idr.h>
 #include <linux/slab.h>
+#include <linux/workqueue.h>
 #include <linux/of_device.h>
 #include <linux/soc/qcom/apr.h>
 #include <linux/rpmsg.h>
@@ -17,8 +18,18 @@ struct apr {
 	struct rpmsg_endpoint *ch;
 	struct device *dev;
 	spinlock_t svcs_lock;
+	spinlock_t rx_lock;
 	struct idr svcs_idr;
 	int dest_domain_id;
+	struct workqueue_struct *rxwq;
+	struct work_struct rx_work;
+	struct list_head rx_list;
+};
+
+struct apr_rx_buf {
+	struct list_head node;
+	int len;
+	uint8_t buf[];
 };
 
 /**
@@ -62,11 +73,7 @@ static int apr_callback(struct rpmsg_device *rpdev, void *buf,
 				  int len, void *priv, u32 addr)
 {
 	struct apr *apr = dev_get_drvdata(&rpdev->dev);
-	uint16_t hdr_size, msg_type, ver, svc_id;
-	struct apr_device *svc = NULL;
-	struct apr_driver *adrv = NULL;
-	struct apr_resp_pkt resp;
-	struct apr_hdr *hdr;
+	struct apr_rx_buf *abuf;
 	unsigned long flags;
 
 	if (len <= APR_HDR_SIZE) {
@@ -75,6 +82,34 @@ static int apr_callback(struct rpmsg_device *rpdev, void *buf,
 		return -EINVAL;
 	}
 
+	abuf = kzalloc(sizeof(*abuf) + len, GFP_ATOMIC);
+	if (!abuf)
+		return -ENOMEM;
+
+	abuf->len = len;
+	memcpy(abuf->buf, buf, len);
+
+	spin_lock_irqsave(&apr->rx_lock, flags);
+	list_add_tail(&abuf->node, &apr->rx_list);
+	spin_unlock_irqrestore(&apr->rx_lock, flags);
+
+	queue_work(apr->rxwq, &apr->rx_work);
+
+	return 0;
+}
+
+
+static int apr_do_rx_callback(struct apr *apr, struct apr_rx_buf *abuf)
+{
+	uint16_t hdr_size, msg_type, ver, svc_id;
+	struct apr_device *svc = NULL;
+	struct apr_driver *adrv = NULL;
+	struct apr_resp_pkt resp;
+	struct apr_hdr *hdr;
+	unsigned long flags;
+	void *buf = abuf->buf;
+	int len = abuf->len;
+
 	hdr = buf;
 	ver = APR_HDR_FIELD_VER(hdr->hdr_field);
 	if (ver > APR_PKT_VER + 1)
@@ -132,6 +167,23 @@ static int apr_callback(struct rpmsg_device *rpdev, void *buf,
 	return 0;
 }
 
+static void apr_rxwq(struct work_struct *work)
+{
+	struct apr *apr = container_of(work, struct apr, rx_work);
+	struct apr_rx_buf *abuf, *b;
+	unsigned long flags;
+
+	if (!list_empty(&apr->rx_list)) {
+		list_for_each_entry_safe(abuf, b, &apr->rx_list, node) {
+			apr_do_rx_callback(apr, abuf);
+			spin_lock_irqsave(&apr->rx_lock, flags);
+			list_del(&abuf->node);
+			spin_unlock_irqrestore(&apr->rx_lock, flags);
+			kfree(abuf);
+		}
+	}
+}
+
 static int apr_device_match(struct device *dev, struct device_driver *drv)
 {
 	struct apr_device *adev = to_apr_device(dev);
@@ -285,6 +337,14 @@ static int apr_probe(struct rpmsg_device *rpdev)
 	dev_set_drvdata(dev, apr);
 	apr->ch = rpdev->ept;
 	apr->dev = dev;
+	apr->rxwq = create_singlethread_workqueue("qcom_apr_rx");
+	if (!apr->rxwq) {
+		dev_err(apr->dev, "Failed to start Rx WQ\n");
+		return -ENOMEM;
+	}
+	INIT_WORK(&apr->rx_work, apr_rxwq);
+	INIT_LIST_HEAD(&apr->rx_list);
+	spin_lock_init(&apr->rx_lock);
 	spin_lock_init(&apr->svcs_lock);
 	idr_init(&apr->svcs_idr);
 	of_register_apr_devices(dev);
@@ -303,7 +363,11 @@ static int apr_remove_device(struct device *dev, void *null)
 
 static void apr_remove(struct rpmsg_device *rpdev)
 {
+	struct apr *apr = dev_get_drvdata(&rpdev->dev);
+
 	device_for_each_child(&rpdev->dev, NULL, apr_remove_device);
+	flush_workqueue(apr->rxwq);
+	destroy_workqueue(apr->rxwq);
 }
 
 /*
-- 
2.20.1

