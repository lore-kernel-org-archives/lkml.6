Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A59DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA5D2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:34:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AA5D2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbeK1Peo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 10:34:44 -0500
Received: from gateway24.websitewelcome.com ([192.185.51.122]:23187 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726894AbeK1Peo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 10:34:44 -0500
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 2500A4B98F
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 22:34:30 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id RrYUgzR74aSeyRrYUgC43R; Tue, 27 Nov 2018 22:34:30 -0600
X-Authority-Reason: nr=8
Received: from [189.250.78.127] (port=58400 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gRrYT-001qnw-28; Tue, 27 Nov 2018 22:34:29 -0600
Date:   Tue, 27 Nov 2018 22:34:25 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Vinayak Holikatti <vinholikatti@gmail.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 40/41] scsi: ufs: ufshcd: mark expected switch fall-throughs
Message-ID: <f4ee30ab52b0fadd2242dd189fe03b60ecba1f47.1543374820.git.gustavo@embeddedor.com>
References: <cover.1543374820.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1543374820.git.gustavo@embeddedor.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.78.127
X-Source-L: No
X-Exim-ID: 1gRrYT-001qnw-28
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.78.127]:58400
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 270
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 1087954 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/scsi/ufs/ufshcd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 003d489f1b4b..be207197b63f 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -1551,6 +1551,7 @@ int ufshcd_hold(struct ufs_hba *hba, bool async)
 		 * currently running. Hence, fall through to cancel gating
 		 * work and to enable clocks.
 		 */
+		/* fall through */
 	case CLKS_OFF:
 		ufshcd_scsi_block_requests(hba);
 		hba->clk_gating.state = REQ_CLKS_ON;
@@ -1562,6 +1563,7 @@ int ufshcd_hold(struct ufs_hba *hba, bool async)
 		 * fall through to check if we should wait for this
 		 * work to be done or not.
 		 */
+		/* fall through */
 	case REQ_CLKS_ON:
 		if (async) {
 			rc = -EAGAIN;
@@ -4620,6 +4622,7 @@ ufshcd_scsi_cmd_status(struct ufshcd_lrb *lrbp, int scsi_status)
 	switch (scsi_status) {
 	case SAM_STAT_CHECK_CONDITION:
 		ufshcd_copy_sense_data(lrbp);
+		/* fall through */
 	case SAM_STAT_GOOD:
 		result |= DID_OK << 16 |
 			  COMMAND_COMPLETE << 8 |
-- 
2.17.1

