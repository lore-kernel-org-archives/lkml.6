Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BFCC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4085F2184A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vPD66ggb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbeLRKAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 05:00:31 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:40721 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbeLRKAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 05:00:30 -0500
Received: by mail-io1-f68.google.com with SMTP id v12so8690517iop.7;
        Tue, 18 Dec 2018 02:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Bygy8q+B+26MqgPUBkfyodN9+lfiaRKsw0ThW9v2JQM=;
        b=vPD66ggb0O+2Ymqvhuv9Z096lrbab0CMHY9LJDyQ5f/KO1g2ppMa2CUOcp+TF6RWrT
         DtwwzeJAplyabkbHTWkZou6FE45zqKMbYq3PBVZCMV1+sAHTfHDOo+/0dxnDK0Bajlnc
         SOhV9aYreBJik+89y5HQaTudgHdH4HIsm5cGYGac1tIBet2YfWe7FvxAQNYlqapC/NmT
         DNLL/Oq7VOY2LgtjGEG11Z4etfJ/ppfkPOQoyDApQcy04Xkkq6S4ESJwNl0kyU7NOto/
         rAvEd787tVZYVbehdOYgQRptTOWzrpPotUsqcN8lU9pUzAE1EdB/LtfvVSB5OAxB/BGx
         V8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Bygy8q+B+26MqgPUBkfyodN9+lfiaRKsw0ThW9v2JQM=;
        b=KukHuv0/D7V36d4HjlCLJudKX+0zda2FNkW2NbALRV4cYy34LrVHfeLkFjws+TaxsR
         rsUBOVqWo7dnVTNhVdqYU0Z2gW9bS6D4HTTT2gdNq/VTR53gy/NKkjm/7EdMafe2A51W
         0u5GCVtKbXdAeWkIUtWsSN0b2/CS2dlkQidmSvMx7KlFfWDv7MoNNMURyUYoEh5x/pvQ
         djOe56INEJR/Igt0JAKsdDiejn7l6eae0TK2ZVFSP3tEZLLcfqO3j0xipilXBJhLICDx
         1QPYLaZslbhMqNLRmdB6BJgMaD0qkUZB8rhHZ5I8s0oCzcqLeGBqhydK0O6UvoWVvLLs
         DKmA==
X-Gm-Message-State: AA+aEWYugoPXlzYGCmrh3cMhg249zMaeYrGptMhlssqmLxsH4ViJNh1f
        1SEmHQJYrvF+RDna/Tl3fgQ=
X-Google-Smtp-Source: AFSGD/Uez3tDYekgZCva0c4AeczDVhtVOChhRykKY91LKfSMNgXzE9FkQO98uoWq4FJxxo2O8X4EgQ==
X-Received: by 2002:a6b:1807:: with SMTP id 7mr13251090ioy.167.1545127229343;
        Tue, 18 Dec 2018 02:00:29 -0800 (PST)
Received: from localhost.localdomain ([2402:f000:1:4414:3dd3:3693:8487:3f39])
        by smtp.gmail.com with ESMTPSA id p21sm6557538ioh.25.2018.12.18.02.00.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 02:00:28 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] r8a66597: Fix a possible concurrency use-after-free bug in r8a66597_endpoint_disable()
Date:   Tue, 18 Dec 2018 18:00:20 +0800
Message-Id: <20181218100020.26250-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function r8a66597_endpoint_disable() and r8a66597_urb_enqueue() may
be concurrently executed.
The two functions both access a possible shared variable "hep->hcpriv".

This shared variable is freed by r8a66597_endpoint_disable() via the
call path:
r8a66597_endpoint_disable
  kfree(hep->hcpriv) (line 1995 in Linux-4.19)

This variable is read by r8a66597_urb_enqueue() via the call path:
r8a66597_urb_enqueue
  spin_lock_irqsave(&r8a66597->lock);
  init_pipe_info
    enable_r8a66597_pipe
      pipe = hep->hcpriv (line 802 in Linux-4.19)

The read operation is protected by a spinlock, but the free operation
is not protected by this spinlock, thus a concurrency use-after-free bug
may occur.

To fix this bug, the spin-lock and spin-unlock function calls in
r8a66597_endpoint_disable() are moved to protect the free operation.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/usb/host/r8a66597-hcd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/r8a66597-hcd.c b/drivers/usb/host/r8a66597-hcd.c
index 984892dd72f5..1495ce14ad22 100644
--- a/drivers/usb/host/r8a66597-hcd.c
+++ b/drivers/usb/host/r8a66597-hcd.c
@@ -1991,13 +1991,14 @@ static void r8a66597_endpoint_disable(struct usb_hcd *hcd,
 		return;
 	pipenum = pipe->info.pipenum;
 
+	spin_lock_irqsave(&r8a66597->lock, flags);
 	if (pipenum == 0) {
 		kfree(hep->hcpriv);
 		hep->hcpriv = NULL;
+		spin_unlock_irqrestore(&r8a66597->lock, flags);
 		return;
 	}
 
-	spin_lock_irqsave(&r8a66597->lock, flags);
 	pipe_stop(r8a66597, pipe);
 	pipe_irq_disable(r8a66597, pipenum);
 	disable_irq_empty(r8a66597, pipenum);
-- 
2.17.0

