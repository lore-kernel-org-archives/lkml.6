Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE2EC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 09:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3375D218FD
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 09:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbeLWJeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 04:34:37 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:44319
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727364AbeLWJeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 04:34:06 -0500
X-IronPort-AV: E=Sophos;i="5.56,386,1539640800"; 
   d="scan'208";a="289991782"
Received: from palace.lip6.fr ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES128-SHA256; 23 Dec 2018 10:33:55 +0100
From:   Julia Lawall <Julia.Lawall@lip6.fr>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     kernel-janitors@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 17/20] dmaengine: pl330: drop useless LIST_HEAD
Date:   Sun, 23 Dec 2018 09:57:12 +0100
Message-Id: <1545555435-24576-18-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1545555435-24576-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1545555435-24576-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop LIST_HEAD where the variable it declares is never used.

The variable has not been used since the function was introduced
in 740aa95703c5 ("dmaengine: pl330: Split device_control").

The semantic patch that fixes this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
identifier x;
@@
- LIST_HEAD(x);
  ... when != x
// </smpl>

Fixes: 740aa95703c5 ("dmaengine: pl330: Split device_control")
Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
Successfully 0-day tested on 151 configurations.

 drivers/dma/pl330.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index cff1b143fff5..eec79fdf27a5 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2267,7 +2267,6 @@ static int pl330_terminate_all(struct dma_chan *chan)
 	struct dma_pl330_desc *desc;
 	unsigned long flags;
 	struct pl330_dmac *pl330 = pch->dmac;
-	LIST_HEAD(list);
 	bool power_down = false;
 
 	pm_runtime_get_sync(pl330->ddma.dev);

