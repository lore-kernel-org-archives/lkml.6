Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B03C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CD93256B3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhl6y9+v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CD93256B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754782AbeFYJ1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 05:27:51 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:44912 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750919AbeFYJ1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 05:27:49 -0400
Received: by mail-wr0-f193.google.com with SMTP id p12-v6so11265010wrn.11;
        Mon, 25 Jun 2018 02:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=67rhiyFVzoKVQXTuifEiGRJEsSDBWmuXfM2BvfFlAMY=;
        b=dhl6y9+v+ycSfiUBxdNf416LexO1FtagKLWSYz/FgwWxbTaD3JRk0mDpOP0heFjpm9
         +b3bnFN4pscTJYmixfYnM2e+Jm7m5C1mwGxrV620QGuUiJVlhVkEECRWwfSfh0km33A7
         yYorPABnKZZ3RG8C2P2sfOVQyylVwsky0nz2x5UPDmz/+dhU9lQCW+uTxF6gZIi9iLvN
         wsWI6S0KuUy9q3I7mq9oAteeeaskSNnI6OmqnV84cofVzs95Dy5i1nFah6B5x6xGylkp
         yxzC3HfzEdcR3SkuBlzXykESDM9uTfQmt55hO4qtvUrFoctqMt6qGG6dqnU++8L0MIE5
         Oq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=67rhiyFVzoKVQXTuifEiGRJEsSDBWmuXfM2BvfFlAMY=;
        b=g2ZJyTsH7a1u6ux04buofvyA1t2FRh/OwRno/N8OQNx1xKcGD+udH09VMRmKZNFyGK
         bqYr2leI7Dd/5Ji7KDXOAbUS4y0HclDBvfNo30i/T9Y7Xyne6+bMPsnWvjXNEYUuPklY
         UJPGRIfshg4DFY1qDaHB8AIYjqO/eCRl2tEr5Zihb7zpaqhKwl2E6YpGxYpOHvQIojtz
         fX4laN7ahMwRagqohX9URxOt+LKEX+mYTbrmTclTfYL2D27+8NmpdIl5ut3zGQMUrRjB
         9YBw1jiq1sSXZTg8DqjZQwWlOE7VjQSTsyazlTlwsw/JfkfybAyfieWJ2O4ccMlnWCTJ
         lw6Q==
X-Gm-Message-State: APt69E0f7VfSsjZej4yNOd9hflNvUPZb32wQ0QZTD01PaCLjFBdb72Nv
        Uwy6o3dxLRaGIObzHR5yMqM=
X-Google-Smtp-Source: AAOMgpdS2STkIDUxrW88Z8MYmB+jI6DvmWOcw6WEScoskZ8ThR3W3RDBrvf3IyLpD7fCswnQzMn3+w==
X-Received: by 2002:a5d:41c5:: with SMTP id e5-v6mr3256028wrq.25.1529918868222;
        Mon, 25 Jun 2018 02:27:48 -0700 (PDT)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id v2-v6sm15638779wrm.84.2018.06.25.02.27.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 02:27:47 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, appana.durga.rao@xilinx.com,
        dmaengine@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrea Merello <andrea.merello@gmail.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH v3 1/5] dmaengine: xilinx_dma: in axidma slave_sg and dma_cylic mode align split descriptors
Date:   Mon, 25 Jun 2018 11:27:20 +0200
Message-Id: <20180625092724.22164-1-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
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
	  use implementation suggested by Radhey Shyam Pandey
---
 drivers/dma/xilinx/xilinx_dma.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 27b523530c4a..113d9bf1b6a1 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -1793,6 +1793,16 @@ static struct dma_async_tx_descriptor *xilinx_dma_prep_slave_sg(
 			 */
 			copy = min_t(size_t, sg_dma_len(sg) - sg_used,
 				     XILINX_DMA_MAX_TRANS_LEN);
+
+			if ((copy + sg_used < sg_dma_len(sg)) &&
+			    chan->xdev->common.copy_align) {
+				/*
+				 * If this is not the last descriptor, make sure
+				 * the next one will be properly aligned
+				 */
+				copy = rounddown(copy,
+					(1 << chan->xdev->common.copy_align));
+			}
 			hw = &segment->hw;
 
 			/* Fill in the descriptor */
@@ -1898,6 +1908,16 @@ static struct dma_async_tx_descriptor *xilinx_dma_prep_dma_cyclic(
 			 */
 			copy = min_t(size_t, period_len - sg_used,
 				     XILINX_DMA_MAX_TRANS_LEN);
+
+			if ((copy + sg_used < period_len) &&
+			    chan->xdev->common.copy_align) {
+				/*
+				 * If this is not the last descriptor, make sure
+				 * the next one will be properly aligned
+				 */
+				copy = rounddown(copy,
+					(1 << chan->xdev->common.copy_align));
+			}
 			hw = &segment->hw;
 			xilinx_axidma_buf(chan, hw, buf_addr, sg_used,
 					  period_len * i);
-- 
2.17.1

