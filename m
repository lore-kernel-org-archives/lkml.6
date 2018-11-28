Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD1DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C2F82081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:51:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C2F82081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbeK1PvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 10:51:17 -0500
Received: from gateway32.websitewelcome.com ([192.185.145.111]:26300 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727019AbeK1PvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 10:51:16 -0500
X-Greylist: delayed 1314 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Nov 2018 10:51:16 EST
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id 8EE371D6221
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 22:29:09 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id RrTJgMwn5BcCXRrTJgSCYp; Tue, 27 Nov 2018 22:29:09 -0600
X-Authority-Reason: nr=8
Received: from [189.250.78.127] (port=58290 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gRrTI-001lsB-NP; Tue, 27 Nov 2018 22:29:09 -0600
Date:   Tue, 27 Nov 2018 22:29:07 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Don Brace <don.brace@microsemi.com>, esc.storagedev@microsemi.com
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 15/41] scsi: hpsa: mark expected switch fall-throughs
Message-ID: <991ec154d1a1da019442e4fd025a39fa2ad2bebb.1543374820.git.gustavo@embeddedor.com>
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
X-Exim-ID: 1gRrTI-001lsB-NP
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.78.127]:58290
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 126
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 1195463 ("Missing break in switch")
Addresses-Coverity-ID: 1195464 ("Missing break in switch")
Addresses-Coverity-ID: 1195465 ("Missing break in switch")
Addresses-Coverity-ID: 1195466 ("Missing break in switch")
Addresses-Coverity-ID: 1357338 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/scsi/hpsa.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index c9cccf35e9d7..bc64e8a0449d 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -4663,6 +4663,7 @@ static int fixup_ioaccel_cdb(u8 *cdb, int *cdb_len)
 	case WRITE_6:
 	case WRITE_12:
 		is_write = 1;
+		/* fall through */
 	case READ_6:
 	case READ_12:
 		if (*cdb_len == 6) {
@@ -5093,6 +5094,7 @@ static int hpsa_scsi_ioaccel_raid_map(struct ctlr_info *h,
 	switch (cmd->cmnd[0]) {
 	case WRITE_6:
 		is_write = 1;
+		/* fall through */
 	case READ_6:
 		first_block = (((cmd->cmnd[1] & 0x1F) << 16) |
 				(cmd->cmnd[2] << 8) |
@@ -5103,6 +5105,7 @@ static int hpsa_scsi_ioaccel_raid_map(struct ctlr_info *h,
 		break;
 	case WRITE_10:
 		is_write = 1;
+		/* fall through */
 	case READ_10:
 		first_block =
 			(((u64) cmd->cmnd[2]) << 24) |
@@ -5115,6 +5118,7 @@ static int hpsa_scsi_ioaccel_raid_map(struct ctlr_info *h,
 		break;
 	case WRITE_12:
 		is_write = 1;
+		/* fall through */
 	case READ_12:
 		first_block =
 			(((u64) cmd->cmnd[2]) << 24) |
@@ -5129,6 +5133,7 @@ static int hpsa_scsi_ioaccel_raid_map(struct ctlr_info *h,
 		break;
 	case WRITE_16:
 		is_write = 1;
+		/* fall through */
 	case READ_16:
 		first_block =
 			(((u64) cmd->cmnd[2]) << 56) |
-- 
2.17.1

