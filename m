Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57ED3C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2798420657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRfOIStb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732998AbfAORQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 12:16:40 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44988 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732625AbfAORQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 12:16:39 -0500
Received: by mail-lf1-f65.google.com with SMTP id z13so2613486lfe.11;
        Tue, 15 Jan 2019 09:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2gv+25Lx+MVqStXVMiZm18qbvZyUO+MHfeqnZflo9OE=;
        b=VRfOIStbEwKk/spk3SEjr8t/QD8qofGk8k3xNH6PzYPvDXh5LalW7t0JGV7pNvnrgw
         xIX+gDQgqrHfVpGooD9qZdawHw27OXa+bsfkVOD5Uz2eFe5V9nRUDnfhFDMsrbCt12B1
         77LDBgeM78Ogkj+ri2JKfOfsaprpG3vVPVMKuglNsCXvdaXAi6J+pq1YVfPONAGd+8tM
         /6YYTnpUt7gVcjmHx5fEn0hdRZAZmDMZUaqPaiVSN4egBQeEjDSRLOQNbMZx4mxdWPxf
         JFRc8kcB+R0BS/ihgN4YBkbjWoVQdTEsklyNiBwKc5X8XUcQUwOevxCMWLGz0o0YR6do
         8/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2gv+25Lx+MVqStXVMiZm18qbvZyUO+MHfeqnZflo9OE=;
        b=HGaWRI4ROrRIjMTy+O+ylvCh4LlkUSmmLdOOUMlMsfUoAv2jL90hUN3V/PsiRLGg4s
         KdMV+pHWy3Tlzi66mUkPGDC/XHU2GG5uoQpSmwv3WFd0F0PcrsJuVLLzHkfK9sY4Ao5f
         TUhBlsZ9wDzs7KCZ4oepObQh6b1z0qduKcNh2KhJV9eXsA5RCGcc2mUuTCQAKaSikdx3
         LdLxNQdDdGmv4rJKYwEeh/0PSdYSzMmnI+Cc8MKsx60+8rMCCxo193CQWDjonoL2RZ+W
         j7TYM8Wmmx3WYTLEqU5qAeNHzphXjJlZBgPgqEcvWtcR0ugdmkUXj6MZYCg8PmSFreuf
         LIgg==
X-Gm-Message-State: AJcUukfFU2qaxI7CoIGsZt1Q+jpYkPG8YiLvsaJC54v72PfeGNP7Y1Iv
        fXGD021VVJkTz+YK8hO1mOo=
X-Google-Smtp-Source: ALg8bN7IENMy/O8wrvj5OCUvbEoX3ToP5k1TwU5czuTyBkuT9pxXWUM4/Iv6XeMNZEKxiAMiTEJxWw==
X-Received: by 2002:a19:41c4:: with SMTP id o187mr3760420lfa.32.1547572597255;
        Tue, 15 Jan 2019 09:16:37 -0800 (PST)
Received: from c5c146071e14 (c-11c0e555.09-37-73746f39.bbcust.telenor.se. [85.229.192.17])
        by smtp.gmail.com with ESMTPSA id p10-v6sm646311ljh.59.2019.01.15.09.16.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 09:16:36 -0800 (PST)
Received: from root by c5c146071e14 with local (Exim 4.89)
        (envelope-from <root@c290a08716d1>)
        id 1gjSKJ-0000C0-3W; Tue, 15 Jan 2019 17:16:35 +0000
From:   Leonid Iziumtsev <leonid.iziumtsev@gmail.com>
To:     dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        m.grzeschik@pengutronix.de
Cc:     Leonid Iziumtsev <leonid.iziumtsev@gmail.com>
Subject: [PATCH] dmaengine: imx-dma: fix wrong callback invoke
Date:   Tue, 15 Jan 2019 17:15:23 +0000
Message-Id: <20190115171523.702-1-leonid.iziumtsev@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once the "ld_queue" list is not empty, next descriptor will migrate
into "ld_active" list. The "desc" variable will be overwritten
during that transition. And later the dmaengine_desc_get_callback_invoke()
will use it as an argument. As result we invoke wrong callback.

That behaviour was in place since:
commit fcaaba6c7136 ("dmaengine: imx-dma: fix callback path in tasklet").
But after commit 4cd13c21b207 ("softirq: Let ksoftirqd do its job")
things got worse, since possible delay between tasklet_schedule()
from DMA irq handler and actual tasklet function execution got bigger.
And that gave more time for new DMA request to be submitted and
to be put into "ld_queue" list.

It has been noticed that DMA issue is causing problems for "mxc-mmc"
driver. While stressing the system with heavy network traffic and
writing/reading to/from sd card simultaneously the timeout may happen:

10013000.sdhci: mxcmci_watchdog: read time out (status = 0x30004900)

That often lead to file system corruption.

Signed-off-by: Leonid Iziumtsev <leonid.iziumtsev@gmail.com>
---
 drivers/dma/imx-dma.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
index c2fff3f6c9ca..4a09af3cd546 100644
--- a/drivers/dma/imx-dma.c
+++ b/drivers/dma/imx-dma.c
@@ -618,7 +618,7 @@ static void imxdma_tasklet(unsigned long data)
 {
 	struct imxdma_channel *imxdmac = (void *)data;
 	struct imxdma_engine *imxdma = imxdmac->imxdma;
-	struct imxdma_desc *desc;
+	struct imxdma_desc *desc, *next_desc;
 	unsigned long flags;
 
 	spin_lock_irqsave(&imxdma->lock, flags);
@@ -648,10 +648,10 @@ static void imxdma_tasklet(unsigned long data)
 	list_move_tail(imxdmac->ld_active.next, &imxdmac->ld_free);
 
 	if (!list_empty(&imxdmac->ld_queue)) {
-		desc = list_first_entry(&imxdmac->ld_queue, struct imxdma_desc,
-					node);
+		next_desc = list_first_entry(&imxdmac->ld_queue,
+					     struct imxdma_desc, node);
 		list_move_tail(imxdmac->ld_queue.next, &imxdmac->ld_active);
-		if (imxdma_xfer_desc(desc) < 0)
+		if (imxdma_xfer_desc(next_desc) < 0)
 			dev_warn(imxdma->dev, "%s: channel: %d couldn't xfer desc\n",
 				 __func__, imxdmac->channel);
 	}
-- 
2.11.0

