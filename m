Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25248C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 06:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD319204EC
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 06:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFlx4YzX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD319204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbeIGLEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 07:04:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36017 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbeIGLEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 07:04:43 -0400
Received: by mail-wr1-f68.google.com with SMTP id e1-v6so4659383wrt.3;
        Thu, 06 Sep 2018 23:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Fo4uTu35nfqETk1eWWm0rsB3UI2a2lLeir3RiOJ544s=;
        b=LFlx4YzX5Ya7qjOtnIVcTKcznS6oeSSl96/9Eol2DoVDZV4tfaciINHpN5I28FWHp5
         FG+kdQfb8vZtSonZm3U4no34XsHQOlhf4Y9GmoBSPYK8ekVWtjiHQzdvJSlxEPt/8U+g
         zxEH+zMHN6dGDO3DcgmSh83wEbx+CUSvQgO8+277LyiMTom+cSSwCZXPvI73+fMFG+7N
         dXQ+EGHqUX5PQrpDh7Eh2X+v7NhTKJ/FgDZw7ssdxbxRVuDDsevkauPGWdHAN5ZE2YfC
         lgL1CiEcDuf2esZnwYcvGdzEtx/U/5gBnlbNVOW1zuwKXbdKJUNsosBpSIAJeJ+LCY0D
         kDyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Fo4uTu35nfqETk1eWWm0rsB3UI2a2lLeir3RiOJ544s=;
        b=lG+kZoVIAFw3ZatCQOchiOrT7t92BpYEHQOvdefnZuPzpL0yclmRaDrlbeL2lbagxb
         ROu3HO4RWHNxZbEakUoxtvxQHRzFef5+iA1zHteWzA3flDHSgJh4QW018xd6U9MxVN6v
         7NBbYPWYFCtYcrk2ogII6DZY5x0fDA9eE4pkN0vW5olANbPZtXKQmLIGbV7pV5dVWt1V
         8JTYFlhZb9vZw6nRlka9ad0Z815Fmw3rdB0/dxWPa45XOMcbx56+oXu0nbbKpcMH7xzc
         37zB7/K7l1BaDRlVDJrtjwNSbu8E5WvDeJhr9yXmOhzLwQGlJxdjfq7NYKUdmLfbQm8K
         cCsw==
X-Gm-Message-State: APzg51ATqQUZBxQHlEsR8yzNSEw7STZH+Pse8fOb4yAb/UJrsjHRwhK0
        OSlHM8gSmg2Irpf15Cl8vdk=
X-Google-Smtp-Source: ANB0VdYTWL2yOchrIoG9vcULbX7veGh8LNTcSKTcf8Y3FzjiOgnNtos3Ep7jw0Hit8PVEqHbLRL7HA==
X-Received: by 2002:adf:a3d9:: with SMTP id m25-v6mr4974145wrb.1.1536301519078;
        Thu, 06 Sep 2018 23:25:19 -0700 (PDT)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id w10-v6sm8387233wrp.31.2018.09.06.23.25.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 23:25:18 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, appana.durga.rao@xilinx.com,
        dmaengine@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, radhey.shyam.pandey@xilinx.com,
        Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH v5 1/7] dmaengine: xilinx_dma: commonize DMA copy size calculation
Date:   Fri,  7 Sep 2018 08:24:56 +0200
Message-Id: <20180907062502.8241-1-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes a bit of duplicated code by introducing a new
function that implements calculations for DMA copy size.

Suggested-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
---
Changes in v4:
	- introduce this patch in the patch series
Changes in v5:
	None
---
 drivers/dma/xilinx/xilinx_dma.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 27b523530c4a..a3aaa0e34cc7 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -952,6 +952,19 @@ static int xilinx_dma_alloc_chan_resources(struct dma_chan *dchan)
 	return 0;
 }
 
+/**
+ * xilinx_dma_calc_copysize - Calculate the amount of data to copy
+ * @size: Total data that needs to be copied
+ * @done: Amount of data that has been already copied
+ *
+ * Return: Amount of data that has to be copied
+ */
+static int xilinx_dma_calc_copysize(int size, int done)
+{
+	return min_t(size_t, size - done,
+		     XILINX_DMA_MAX_TRANS_LEN);
+}
+
 /**
  * xilinx_dma_tx_status - Get DMA transaction status
  * @dchan: DMA channel
@@ -1791,8 +1804,8 @@ static struct dma_async_tx_descriptor *xilinx_dma_prep_slave_sg(
 			 * Calculate the maximum number of bytes to transfer,
 			 * making sure it is less than the hw limit
 			 */
-			copy = min_t(size_t, sg_dma_len(sg) - sg_used,
-				     XILINX_DMA_MAX_TRANS_LEN);
+			copy = xilinx_dma_calc_copysize(sg_dma_len(sg),
+							sg_used);
 			hw = &segment->hw;
 
 			/* Fill in the descriptor */
@@ -1896,8 +1909,7 @@ static struct dma_async_tx_descriptor *xilinx_dma_prep_dma_cyclic(
 			 * Calculate the maximum number of bytes to transfer,
 			 * making sure it is less than the hw limit
 			 */
-			copy = min_t(size_t, period_len - sg_used,
-				     XILINX_DMA_MAX_TRANS_LEN);
+			copy = xilinx_dma_calc_copysize(period_len, sg_used);
 			hw = &segment->hw;
 			xilinx_axidma_buf(chan, hw, buf_addr, sg_used,
 					  period_len * i);
-- 
2.17.1

