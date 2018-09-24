Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7CDC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F242098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:42:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90F242098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732054AbeIXWpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 18:45:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36811 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728115AbeIXWpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 18:45:50 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1g4Twe-0005ni-Hw; Mon, 24 Sep 2018 16:42:48 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mailbox: bcm-flexrm-mailbox: fix spelling mistake "toogle" -> "toggle"
Date:   Mon, 24 Sep 2018 17:42:48 +0100
Message-Id: <20180924164248.2180-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in function name flexrm_flip_header_toogle,
rename it to flexrm_flip_header_toggle.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/mailbox/bcm-flexrm-mailbox.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mailbox/bcm-flexrm-mailbox.c b/drivers/mailbox/bcm-flexrm-mailbox.c
index 8ab077ff58f4..d7a8ed7d8097 100644
--- a/drivers/mailbox/bcm-flexrm-mailbox.c
+++ b/drivers/mailbox/bcm-flexrm-mailbox.c
@@ -375,7 +375,7 @@ static u32 flexrm_estimate_header_desc_count(u32 nhcnt)
 	return hcnt;
 }
 
-static void flexrm_flip_header_toogle(void *desc_ptr)
+static void flexrm_flip_header_toggle(void *desc_ptr)
 {
 	u64 desc = flexrm_read_desc(desc_ptr);
 
@@ -709,7 +709,7 @@ static void *flexrm_spu_write_descs(struct brcm_message *msg, u32 nhcnt,
 	wmb();
 
 	/* Flip toggle bit in header */
-	flexrm_flip_header_toogle(orig_desc_ptr);
+	flexrm_flip_header_toggle(orig_desc_ptr);
 
 	return desc_ptr;
 }
@@ -838,7 +838,7 @@ static void *flexrm_sba_write_descs(struct brcm_message *msg, u32 nhcnt,
 	wmb();
 
 	/* Flip toggle bit in header */
-	flexrm_flip_header_toogle(orig_desc_ptr);
+	flexrm_flip_header_toggle(orig_desc_ptr);
 
 	return desc_ptr;
 }
-- 
2.17.1

