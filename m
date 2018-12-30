Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08422C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 16:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D594A20866
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 16:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbeL3Qac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 11:30:32 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:52556
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726489AbeL3QaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 11:30:03 -0500
X-IronPort-AV: E=Sophos;i="5.56,417,1539640800"; 
   d="scan'208";a="290435981"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES128-SHA256; 30 Dec 2018 17:29:58 +0100
From:   Julia Lawall <Julia.Lawall@lip6.fr>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org
Subject: [PATCH 4/8] firmware: stratix10-svc: reduce indentation
Date:   Sun, 30 Dec 2018 16:53:11 +0100
Message-Id: <1546185195-25676-5-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1546185195-25676-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1546185195-25676-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete tab aligning a statement with the right hand side of a
preceding assignment rather than the left hand side.

Found with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/firmware/stratix10-svc.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 6e6514825ad0..ec99eed3edea 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -766,12 +766,12 @@ int stratix10_svc_send(struct stratix10_svc_chan *chan, void *msg)
 					      (void *)chan->ctrl,
 					      cpu_to_node(cpu),
 					      "svc_smc_hvc_thread");
-			if (IS_ERR(chan->ctrl->task)) {
-				dev_err(chan->ctrl->dev,
-					"fails to create svc_smc_hvc_thread\n");
-				kfree(p_data);
-				return -EINVAL;
-			}
+		if (IS_ERR(chan->ctrl->task)) {
+			dev_err(chan->ctrl->dev,
+				"fails to create svc_smc_hvc_thread\n");
+			kfree(p_data);
+			return -EINVAL;
+		}
 		kthread_bind(chan->ctrl->task, cpu);
 		wake_up_process(chan->ctrl->task);
 	}

