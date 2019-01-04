Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41E9C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAFFF218CD
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbfADRnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 12:43:52 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:48443 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbfADRnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 12:43:52 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gfTVd-00044L-OH; Fri, 04 Jan 2019 17:43:49 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jia-Ju Bai <baijiaju1990@gmail.com>, linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: host: u132-hcd: fix a couple of indentation issues
Date:   Fri,  4 Jan 2019 17:43:49 +0000
Message-Id: <20190104174349.9318-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are two statements that are indented incorrectly and need
to be moved to a new line.  Fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/usb/host/u132-hcd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/u132-hcd.c b/drivers/usb/host/u132-hcd.c
index 5b8a3d9530c4..934584f0a20a 100644
--- a/drivers/usb/host/u132-hcd.c
+++ b/drivers/usb/host/u132-hcd.c
@@ -2477,7 +2477,8 @@ static int u132_endp_urb_dequeue(struct u132 *u132, struct u132_endp *endp,
 				spin_unlock_irqrestore(&endp->queue_lock.slock,
 					irqs);
 				kfree(urbq);
-			} urb->error_count = 0;
+			}
+			urb->error_count = 0;
 			usb_hcd_giveback_urb(hcd, urb, status);
 			return 0;
 		} else if (list_empty(&endp->urb_more)) {
@@ -2982,7 +2983,8 @@ static int u132_remove(struct platform_device *pdev)
 			while (rings-- > 0) {
 				struct u132_ring *ring = &u132->ring[rings];
 				u132_ring_cancel_work(u132, ring);
-			} while (endps-- > 0) {
+			}
+			while (endps-- > 0) {
 				struct u132_endp *endp = u132->endp[endps];
 				if (endp)
 					u132_endp_cancel_work(u132, endp);
-- 
2.19.1

