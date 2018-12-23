Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9227C43612
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 09:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3FF8218FD
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 09:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbeLWJex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 04:34:53 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:44319
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727329AbeLWJeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 04:34:04 -0500
X-IronPort-AV: E=Sophos;i="5.56,386,1539640800"; 
   d="scan'208";a="289991779"
Received: from palace.lip6.fr ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES128-SHA256; 23 Dec 2018 10:33:54 +0100
From:   Julia Lawall <Julia.Lawall@lip6.fr>
To:     Patrice Chotard <patrice.chotard@st.com>
Cc:     kernel-janitors@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 14/20] dmaengine: st_fdma: drop useless LIST_HEAD
Date:   Sun, 23 Dec 2018 09:57:09 +0100
Message-Id: <1545555435-24576-15-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1545555435-24576-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1545555435-24576-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop LIST_HEAD where the variable it declares is never used.

The declarations were introduced with the file, but the declared
variables were not used.

The semantic patch that fixes this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
identifier x;
@@
- LIST_HEAD(x);
  ... when != x
// </smpl>

Fixes: 6b4cd727eaf1 ("dmaengine: st_fdma: Add STMicroelectronics FDMA engine driver support")
Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
Successfully 0-day tested on 151 configurations.

 drivers/dma/st_fdma.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/dma/st_fdma.c b/drivers/dma/st_fdma.c
index 07c20aa2e955..954f7cf62bb1 100644
--- a/drivers/dma/st_fdma.c
+++ b/drivers/dma/st_fdma.c
@@ -294,8 +294,6 @@ static void st_fdma_free_chan_res(struct dma_chan *chan)
 	struct rproc *rproc = fchan->fdev->slim_rproc->rproc;
 	unsigned long flags;
 
-	LIST_HEAD(head);
-
 	dev_dbg(fchan->fdev->dev, "%s: freeing chan:%d\n",
 		__func__, fchan->vchan.chan.chan_id);
 
@@ -626,7 +624,6 @@ static void st_fdma_issue_pending(struct dma_chan *chan)
 static int st_fdma_pause(struct dma_chan *chan)
 {
 	unsigned long flags;
-	LIST_HEAD(head);
 	struct st_fdma_chan *fchan = to_st_fdma_chan(chan);
 	int ch_id = fchan->vchan.chan.chan_id;
 	unsigned long cmd = FDMA_CMD_PAUSE(ch_id);

