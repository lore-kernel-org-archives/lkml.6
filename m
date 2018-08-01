Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A97EC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 14:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B36AA20862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 14:58:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B36AA20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389680AbeHAQo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 12:44:56 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43751 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389256AbeHAQo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 12:44:56 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fksaH-0006wy-UU; Wed, 01 Aug 2018 14:58:42 +0000
From:   Colin King <colin.king@canonical.com>
To:     Matthew Wilcox <willy@infradead.org>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [SCSI] sym53c8xx: remove some redundant variables
Date:   Wed,  1 Aug 2018 15:58:41 +0100
Message-Id: <20180801145841.5877-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variables scriptb0 and dp_sgmin are being assigned but are never
used hence they are redundant and can be removed.

Cleans up clang warnings:
warning: variable 'scriptb0' set but not used [-Wunused-but-set-variable]
warning: variable 'dp_sgmin' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/sym53c8xx_2/sym_fw.c   | 4 ----
 drivers/scsi/sym53c8xx_2/sym_hipd.c | 3 +--
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/scsi/sym53c8xx_2/sym_fw.c b/drivers/scsi/sym53c8xx_2/sym_fw.c
index 190770bdc194..91db17727963 100644
--- a/drivers/scsi/sym53c8xx_2/sym_fw.c
+++ b/drivers/scsi/sym53c8xx_2/sym_fw.c
@@ -295,10 +295,8 @@ static void
 sym_fw1_setup(struct sym_hcb *np, struct sym_fw *fw)
 {
 	struct sym_fw1a_scr *scripta0;
-	struct sym_fw1b_scr *scriptb0;
 
 	scripta0 = (struct sym_fw1a_scr *) np->scripta0;
-	scriptb0 = (struct sym_fw1b_scr *) np->scriptb0;
 
 	/*
 	 *  Fill variable parts in scripts.
@@ -319,10 +317,8 @@ static void
 sym_fw2_setup(struct sym_hcb *np, struct sym_fw *fw)
 {
 	struct sym_fw2a_scr *scripta0;
-	struct sym_fw2b_scr *scriptb0;
 
 	scripta0 = (struct sym_fw2a_scr *) np->scripta0;
-	scriptb0 = (struct sym_fw2b_scr *) np->scriptb0;
 
 	/*
 	 *  Fill variable parts in scripts.
diff --git a/drivers/scsi/sym53c8xx_2/sym_hipd.c b/drivers/scsi/sym53c8xx_2/sym_hipd.c
index 378af306fda1..bd3f6e2d6834 100644
--- a/drivers/scsi/sym53c8xx_2/sym_hipd.c
+++ b/drivers/scsi/sym53c8xx_2/sym_hipd.c
@@ -3855,7 +3855,7 @@ static void sym_modify_dp(struct sym_hcb *np, struct sym_tcb *tp, struct sym_ccb
 
 int sym_compute_residual(struct sym_hcb *np, struct sym_ccb *cp)
 {
-	int dp_sg, dp_sgmin, resid = 0;
+	int dp_sg, resid = 0;
 	int dp_ofs = 0;
 
 	/*
@@ -3902,7 +3902,6 @@ int sym_compute_residual(struct sym_hcb *np, struct sym_ccb *cp)
 	 *  We are now full comfortable in the computation 
 	 *  of the data residual (2's complement).
 	 */
-	dp_sgmin = SYM_CONF_MAX_SG - cp->segments;
 	resid = -cp->ext_ofs;
 	for (dp_sg = cp->ext_sg; dp_sg < SYM_CONF_MAX_SG; ++dp_sg) {
 		u_int tmp = scr_to_cpu(cp->phys.data[dp_sg].size);
-- 
2.17.1

