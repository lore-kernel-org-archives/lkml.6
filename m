Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1310EC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 14:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF6DA2150E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 14:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qVQHkycN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF6DA2150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732477AbeHBQBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 12:01:42 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36732 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732141AbeHBQBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 12:01:42 -0400
Received: by mail-wr1-f66.google.com with SMTP id h9-v6so2299429wro.3;
        Thu, 02 Aug 2018 07:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NPisTIUxEJWllPtVLNR+w7rnRDOVuscZpqNlMO4PTg8=;
        b=qVQHkycNLclULwTXiDeJPxKYdPwDoM0UCfDyc2FdD0++BxTwl3kSb0MOnH3uMV4qdb
         qKSg4R4VcVDls2VmQa17AB0GIPU4kR0WnMIHsrILlUejoJtzWE7DpbJtmvJKWPpuhNgD
         NZvBx4xIM5oPTXPzV7A0+RGCTBOrEcbh6+w8XleP2HpUi+iA7T8VOv8DmZWLlSmR5fm+
         p2sI7LkpQBEuKX5SzcbcLIBwwEYY+wEOPczGVpF5fePlrEB2ryXoTIQnivUT/KeevhMy
         U+MBnFD6S8HA8AuEPfDy/JeRmB+HG4jvn2Dhj7VyczHejMAjIMnMeynJK18PRFtVau23
         zWzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NPisTIUxEJWllPtVLNR+w7rnRDOVuscZpqNlMO4PTg8=;
        b=CEE6lv0Bfoa3QsIHRiZwyH66WG8jk26tnBdYmtfWgdVIN47LgL0YPQpTk3wRsh2SUs
         U2NPocMlmsQAebH1lpi0zYvBNKeuP6Crqrqy71z4EwYL5HfQDRzvEbo9lMo08nObFA14
         RTq5ZPBQnQuOB4Yi1EHYCWP8XJGeB4/3O0zlJciUiStdXZcABjt41bUGLKMuCMXb3PAa
         eSyAFfgPsHgb5jSl89i8C8tgH05IeM7g7oxTc1VRHK2wSdTW+nW0pPL58xwIv4zRFzTP
         POZgue0apKmPof/8VVNsIY3P2kZyVj6XuzVSijPYDRbScIBHGgTsZ8TVF/I20EzbcQoz
         VA+w==
X-Gm-Message-State: AOUpUlE8DTwYYBvZYk6T/ZKh6DcerPGs+vrvY+Y0LurvAbInbSOyTp2w
        TEzdDHqB6qJykJZyRbgTYiQ=
X-Google-Smtp-Source: AAOMgpcPYdK2+JgAvUBhf8b+RM5WPAVCDoisie/8hbPiagqA9l6iXr0W0pVcjCKD7MFAGWxM0/GluQ==
X-Received: by 2002:adf:bc03:: with SMTP id s3-v6mr2262503wrg.211.1533219018243;
        Thu, 02 Aug 2018 07:10:18 -0700 (PDT)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id d78-v6sm3392310wma.37.2018.08.02.07.10.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 07:10:17 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, appana.durga.rao@xilinx.com,
        dmaengine@vger.kernel.org
Cc:     v4-000linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        radhey.shyam.pandey@xilinx.com,
        Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH v4 1/7] dmaengine: xilinx_dma: commonize DMA copy size calculation
Date:   Thu,  2 Aug 2018 16:10:06 +0200
Message-Id: <20180802141012.19970-1-andrea.merello@gmail.com>
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

