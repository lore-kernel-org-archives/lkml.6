Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1A7C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 14:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1034C208B0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 14:03:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1034C208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390489AbeHPRBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 13:01:49 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43734 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389549AbeHPRBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 13:01:49 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fqIrW-00018g-DI; Thu, 16 Aug 2018 14:02:54 +0000
From:   Colin King <colin.king@canonical.com>
To:     Subbu Seetharaman <subbu.seetharaman@broadcom.com>,
        Ketan Mukadam <ketan.mukadam@broadcom.com>,
        Jitendra Bhivare <jitendra.bhivare@broadcom.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: be2iscsi: remove unused variable dmsg
Date:   Thu, 16 Aug 2018 15:02:54 +0100
Message-Id: <20180816140254.20955-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable dmsg is not being used and is redundant and hence can
be removed.

Cleans up clang warning:
warning: variable 'dmsg' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/be2iscsi/be_main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/be2iscsi/be_main.c b/drivers/scsi/be2iscsi/be_main.c
index 3660059784f7..d544453aa466 100644
--- a/drivers/scsi/be2iscsi/be_main.c
+++ b/drivers/scsi/be2iscsi/be_main.c
@@ -1866,7 +1866,6 @@ unsigned int beiscsi_process_cq(struct be_eq_obj *pbe_eq, int budget)
 {
 	struct be_queue_info *cq;
 	struct sol_cqe *sol;
-	struct dmsg_cqe *dmsg;
 	unsigned int total = 0;
 	unsigned int num_processed = 0;
 	unsigned short code = 0, cid = 0;
@@ -1939,7 +1938,6 @@ unsigned int beiscsi_process_cq(struct be_eq_obj *pbe_eq, int budget)
 				    "BM_%d : Received %s[%d] on CID : %d\n",
 				    cqe_desc[code], code, cid);
 
-			dmsg = (struct dmsg_cqe *)sol;
 			hwi_complete_drvr_msgs(beiscsi_conn, phba, sol);
 			break;
 		case UNSOL_HDR_NOTIFY:
-- 
2.17.1

