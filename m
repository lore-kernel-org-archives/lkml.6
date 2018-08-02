Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C44C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 14:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE6532150E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 14:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPMEKV+e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE6532150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732535AbeHBQBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 12:01:45 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36673 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732231AbeHBQBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 12:01:44 -0400
Received: by mail-wm0-f68.google.com with SMTP id w24-v6so2726349wmc.1;
        Thu, 02 Aug 2018 07:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=13UB+8MFeFfRAoIF7WXwnAp2DUzob6xSPX4RlR1oE4g=;
        b=iPMEKV+e50KrFb96gOmYfO4cE2Y3nPDiPCQzQiDZ4QKZezHfltiWJj8BHT4WrdfNVP
         8pTXNghF2FAFqOlwBZ7SLp35Mjc2U+79vUds6iv8qgIW9813/bNQe4ShOXIfMqLeN1y7
         v2I11JdOSKw8t789Bq2TqDO+vo3PfVcXnEQya117fJUrDCX/JT9QDZ1gLnqtPQ8zUkXO
         7UplD+Vb8n5ZOw3TvfoxxOTCnkYwK31fZKgRr7fAHvCGhoqDPzfUniDA8U3XBi/Ag68N
         e1qMT1Xo+U1d8/Wmo+75p3NCKcLH5R7Daf8Ex3EWHKPNl3m457DtDdUO5mLa8oWjR4cg
         FyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=13UB+8MFeFfRAoIF7WXwnAp2DUzob6xSPX4RlR1oE4g=;
        b=BAQIxEWO39kWMc1tfmkq9h/xPMrB/VrAejNuY3fnMvVubaOlHkMSHvtDpbUK0ePd0e
         f69lTqu9BAhMkGvOzzsTKFrfC4ZTEIEtfXheQQW+YjGaIosqq+7ZgMYTB6UPzBWyx6+9
         hZxVvnqrWOeD67prDIkXEbo1dWeH1y2BGWhBYCOkdObaNk+TnOfEj/GyZ3opVFoEJW1D
         yRyTEUlVgMZNPibYGmFmSuxRrO9KsmL8Nds5VYWYTLLqujml/dVw0eJSyRzE7czmLIVJ
         /dPZVR/AjZn7K5hx/d1IMv/h8s2fiidkNK+Q0AdPxR7DbYR/hdbbqFklzC4FmX4m2CQo
         gicA==
X-Gm-Message-State: AOUpUlGHJKOI24BO0hVjGx//isJKJDjxswy2Wa3wA/ugNBnKCYqQBctr
        ReixjXH5LStJBzZ70fNceDU=
X-Google-Smtp-Source: AAOMgpcMbA/f4AT1mTO5Z2ZphcOPN3BfAYAI5xnPqIplQ6sesLUCktN7XrP1jKT/ZmL2ZlJKhVpjRQ==
X-Received: by 2002:a1c:8414:: with SMTP id g20-v6mr2366880wmd.90.1533219019457;
        Thu, 02 Aug 2018 07:10:19 -0700 (PDT)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id d78-v6sm3392310wma.37.2018.08.02.07.10.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 07:10:18 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, appana.durga.rao@xilinx.com,
        dmaengine@vger.kernel.org
Cc:     v4-000linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        radhey.shyam.pandey@xilinx.com,
        Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH v4 2/7] dmaengine: xilinx_dma: in axidma slave_sg and dma_cylic mode align split descriptors
Date:   Thu,  2 Aug 2018 16:10:07 +0200
Message-Id: <20180802141012.19970-2-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180802141012.19970-1-andrea.merello@gmail.com>
References: <20180802141012.19970-1-andrea.merello@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whenever a single or cyclic transaction is prepared, the driver
could eventually split it over several SG descriptors in order
to deal with the HW maximum transfer length.

This could end up in DMA operations starting from a misaligned
address. This seems fatal for the HW if DRE is not enabled.

This patch eventually adjusts the transfer size in order to make sure
all operations start from an aligned address.

Cc: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
Changes in v2:
        - don't introduce copy_mask field, rather rely on already-esistent
          copy_align field. Suggested by Radhey Shyam Pandey
        - reword title
Changes in v3:
	- fix bug introduced in v2: wrong copy size when DRE is enabled
	- use implementation suggested by Radhey Shyam Pandey
Changes in v4:
	- rework on the top of 1/6
---
 drivers/dma/xilinx/xilinx_dma.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index a3aaa0e34cc7..aaa6de8a70e4 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -954,15 +954,28 @@ static int xilinx_dma_alloc_chan_resources(struct dma_chan *dchan)
 
 /**
  * xilinx_dma_calc_copysize - Calculate the amount of data to copy
+ * @chan: Driver specific DMA channel
  * @size: Total data that needs to be copied
  * @done: Amount of data that has been already copied
  *
  * Return: Amount of data that has to be copied
  */
-static int xilinx_dma_calc_copysize(int size, int done)
+static int xilinx_dma_calc_copysize(struct xilinx_dma_chan *chan,
+				    int size, int done)
 {
-	return min_t(size_t, size - done,
+	size_t copy = min_t(size_t, size - done,
 		     XILINX_DMA_MAX_TRANS_LEN);
+
+	if ((copy + done < size) &&
+	    chan->xdev->common.copy_align) {
+		/*
+		 * If this is not the last descriptor, make sure
+		 * the next one will be properly aligned
+		 */
+		copy = rounddown(copy,
+				 (1 << chan->xdev->common.copy_align));
+	}
+	return copy;
 }
 
 /**
@@ -1804,7 +1817,7 @@ static struct dma_async_tx_descriptor *xilinx_dma_prep_slave_sg(
 			 * Calculate the maximum number of bytes to transfer,
 			 * making sure it is less than the hw limit
 			 */
-			copy = xilinx_dma_calc_copysize(sg_dma_len(sg),
+			copy = xilinx_dma_calc_copysize(chan, sg_dma_len(sg),
 							sg_used);
 			hw = &segment->hw;
 
@@ -1909,7 +1922,8 @@ static struct dma_async_tx_descriptor *xilinx_dma_prep_dma_cyclic(
 			 * Calculate the maximum number of bytes to transfer,
 			 * making sure it is less than the hw limit
 			 */
-			copy = xilinx_dma_calc_copysize(period_len, sg_used);
+			copy = xilinx_dma_calc_copysize(chan,
+							period_len, sg_used);
 			hw = &segment->hw;
 			xilinx_axidma_buf(chan, hw, buf_addr, sg_used,
 					  period_len * i);
-- 
2.17.1

