Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09E8C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 06:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 624F820861
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 06:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pgh9G8de"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 624F820861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbeIGLEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 07:04:46 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32970 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbeIGLEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 07:04:45 -0400
Received: by mail-wr1-f65.google.com with SMTP id v90-v6so13772107wrc.0;
        Thu, 06 Sep 2018 23:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G0d4E4UUBGUZ+uqudEZiIppK0s4vLLe5noMqkvJPkuU=;
        b=Pgh9G8deVvztHjVCwyJuRM0Ll6p/RwKoE5lKIPkqaSYFJe7qQ2sasOolra9ymO+Z+2
         T9QWgs+2b9wumUqRt/bfnO+lNtf4ITFhaP1yo0RuugFQRpf7WBNO8+YdZ8/gV6XnveGN
         bnMmAHFYUiM2+jLgrvIsjpm2bdh110HQSJJq5Z1SAq+gw/gItdo3WGKxzCio39lLss0y
         rfUDac+tuLoBzYNruVTM9MzpXPETZKg7qC6peESB6mVJ8QnEzXxh7VdS5thpZJQsHOEA
         W3CCBKtZ3Oa8iP26tYaZt3w1rRY+Sb7b4ylMWCpXE1GLlyDIoD7QAzsbE3D29/OhR+f6
         Q7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G0d4E4UUBGUZ+uqudEZiIppK0s4vLLe5noMqkvJPkuU=;
        b=IVlA3dNQH3qWvt9F/5S/bXrWWxai3QcgWr8dxYNTsL/peqMuallZV247MVVLm2bC1x
         5nuGpQ9ibVZKg0KC4+PUoxvnHzAiM5JGL7K08sASwF2O1fJ5wHy8bspt0Jar8SVkCADL
         OPt6D92eR8bXiibppaouQ1wRskJNWLyV45i3jhE+0YmUHqO2JuvciRPWg1EoF4nNrv7R
         Y2kdn+eRC/bUwuZEFEPAX9IuF6TDN4b9xDDo6qIWqEI2u46TFz9ZZ2zdIjnd49+0oQsl
         i+szVl6RxRQ/5lyTNB8dAz2ygWcUQ0R2QBYygJ5gLXmFYi606tpXQTexEW8Ee+qDFcuE
         Uqqg==
X-Gm-Message-State: APzg51BOKnhttDe9C0fGkrnpOP37YuEBWsjE0qpeYDk1ZW12keIy75iI
        UZF78XK4Vq1WPweOpKczIBs=
X-Google-Smtp-Source: ANB0VdbHcQABVeP+3wDtH9ye0milPJ4WQpEcq3N4Md1LnllLiKvm4bV3NzGKaau9GlVQnbp7CC/6Rw==
X-Received: by 2002:adf:93c2:: with SMTP id 60-v6mr4495773wrp.81.1536301520318;
        Thu, 06 Sep 2018 23:25:20 -0700 (PDT)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id w10-v6sm8387233wrp.31.2018.09.06.23.25.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 23:25:19 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, appana.durga.rao@xilinx.com,
        dmaengine@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, radhey.shyam.pandey@xilinx.com,
        Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH v5 2/7] dmaengine: xilinx_dma: in axidma slave_sg and dma_cyclic mode align split descriptors
Date:   Fri,  7 Sep 2018 08:24:57 +0200
Message-Id: <20180907062502.8241-2-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180907062502.8241-1-andrea.merello@gmail.com>
References: <20180907062502.8241-1-andrea.merello@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whenever a single or cyclic transaction is prepared, the driver
could eventually split it over several SG descriptors in order
to deal with the HW maximum transfer length.

This could end up in DMA operations starting from a misaligned
address. This seems fatal for the HW if DRE (Data Realignment Engine)
is not enabled.

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
Changes in v5:
	- fix typo in commit title
	- add hint about "DRE" meaning in commit message
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

