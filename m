Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9BEC433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 22:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E03E20883
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 22:25:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E03E20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbeIXEZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 00:25:02 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49993 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbeIXEZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 00:25:02 -0400
Received: from cpc129250-craw9-2-0-cust139.know.cable.virginm.net ([82.43.126.140] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1g4Cp2-0003gt-PI; Sun, 23 Sep 2018 22:25:48 +0000
From:   Colin King <colin.king@canonical.com>
To:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: megaraid: fix spelling mistake "maibox" -> "mailbox"
Date:   Sun, 23 Sep 2018 23:25:48 +0100
Message-Id: <20180923222548.7908-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in warning message and comments

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/megaraid/megaraid_mbox.c | 4 ++--
 drivers/scsi/megaraid/megaraid_mbox.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_mbox.c b/drivers/scsi/megaraid/megaraid_mbox.c
index 530358cdcb39..2013523605c5 100644
--- a/drivers/scsi/megaraid/megaraid_mbox.c
+++ b/drivers/scsi/megaraid/megaraid_mbox.c
@@ -484,7 +484,7 @@ megaraid_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	// Start the mailbox based controller
 	if (megaraid_init_mbox(adapter) != 0) {
 		con_log(CL_ANN, (KERN_WARNING
-			"megaraid: maibox adapter did not initialize\n"));
+			"megaraid: mailbox adapter did not initialize\n"));
 
 		goto out_free_adapter;
 	}
@@ -950,7 +950,7 @@ megaraid_fini_mbox(adapter_t *adapter)
  * megaraid_alloc_cmd_packets - allocate shared mailbox
  * @adapter		: soft state of the raid controller
  *
- * Allocate and align the shared mailbox. This maibox is used to issue
+ * Allocate and align the shared mailbox. This mailbox is used to issue
  * all the commands. For IO based controllers, the mailbox is also registered
  * with the FW. Allocate memory for all commands as well.
  * This is our big allocator.
diff --git a/drivers/scsi/megaraid/megaraid_mbox.h b/drivers/scsi/megaraid/megaraid_mbox.h
index c1d86d961a92..e075aeb4012f 100644
--- a/drivers/scsi/megaraid/megaraid_mbox.h
+++ b/drivers/scsi/megaraid/megaraid_mbox.h
@@ -117,7 +117,7 @@
  * @raw_mbox		: raw mailbox pointer
  * @mbox		: mailbox
  * @mbox64		: extended mailbox
- * @mbox_dma_h		: maibox dma address
+ * @mbox_dma_h		: mailbox dma address
  * @sgl64		: 64-bit scatter-gather list
  * @sgl32		: 32-bit scatter-gather list
  * @sgl_dma_h		: dma handle for the scatter-gather list
-- 
2.17.1

