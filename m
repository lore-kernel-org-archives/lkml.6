Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDD9ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 22:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7737020883
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 22:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7737020883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbeIXENv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 00:13:51 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49918 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725741AbeIXENv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 00:13:51 -0400
Received: from cpc129250-craw9-2-0-cust139.know.cable.virginm.net ([82.43.126.140] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1g4CeD-0003B9-7R; Sun, 23 Sep 2018 22:14:37 +0000
From:   Colin King <colin.king@canonical.com>
To:     Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: ti: fix spelling mistake "instace" -> "instance"
Date:   Sun, 23 Sep 2018 23:14:36 +0100
Message-Id: <20180923221436.7701-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in dev_err messages and comments

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/soc/ti/knav_dma.c  | 4 ++--
 drivers/soc/ti/knav_qmss.h | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/ti/knav_dma.c b/drivers/soc/ti/knav_dma.c
index 224d7ddeeb76..23f09dce23e0 100644
--- a/drivers/soc/ti/knav_dma.c
+++ b/drivers/soc/ti/knav_dma.c
@@ -438,7 +438,7 @@ void *knav_dma_open_channel(struct device *dev, const char *name,
 
 	chan_num = of_channel_match_helper(dev->of_node, name, &instance);
 	if (chan_num < 0) {
-		dev_err(kdev->dev, "No DMA instace with name %s\n", name);
+		dev_err(kdev->dev, "No DMA instance with name %s\n", name);
 		return (void *)-EINVAL;
 	}
 
@@ -461,7 +461,7 @@ void *knav_dma_open_channel(struct device *dev, const char *name,
 		}
 	}
 	if (!found) {
-		dev_err(kdev->dev, "No DMA instace with name %s\n", instance);
+		dev_err(kdev->dev, "No DMA instance with name %s\n", instance);
 		return (void *)-EINVAL;
 	}
 
diff --git a/drivers/soc/ti/knav_qmss.h b/drivers/soc/ti/knav_qmss.h
index 3efc47e82973..7c128132799e 100644
--- a/drivers/soc/ti/knav_qmss.h
+++ b/drivers/soc/ti/knav_qmss.h
@@ -240,14 +240,14 @@ struct knav_pool {
 };
 
 /**
- * struct knav_queue_inst:		qmss queue instace properties
+ * struct knav_queue_inst:		qmss queue instance properties
  * @descs:				descriptor pointer
  * @desc_head, desc_tail, desc_count:	descriptor counters
  * @acc:				accumulator channel pointer
  * @kdev:				qmss device pointer
  * @range:				range info
  * @qmgr:				queue manager info
- * @id:					queue instace id
+ * @id:					queue instance id
  * @irq_num:				irq line number
  * @notify_needed:			notifier needed based on queue type
  * @num_notifiers:			total notifiers
@@ -274,7 +274,7 @@ struct knav_queue_inst {
 /**
  * struct knav_queue:			qmss queue properties
  * @reg_push, reg_pop, reg_peek:	push, pop queue registers
- * @inst:				qmss queue instace properties
+ * @inst:				qmss queue instance properties
  * @notifier_fn:			notifier function
  * @notifier_fn_arg:			notifier function argument
  * @notifier_enabled:			notier enabled for a give queue
-- 
2.17.1

