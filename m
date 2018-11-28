Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C6BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B69EE2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:29:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B69EE2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbeK1PaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 10:30:05 -0500
Received: from gateway23.websitewelcome.com ([192.185.50.141]:13132 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727008AbeK1PaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 10:30:05 -0500
X-Greylist: delayed 505 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Nov 2018 10:30:04 EST
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 5B2836448
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 22:29:51 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id RrTzgJJfA957pRrTzg2dee; Tue, 27 Nov 2018 22:29:51 -0600
X-Authority-Reason: nr=8
Received: from [189.250.78.127] (port=58300 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gRrTy-001mKT-MS; Tue, 27 Nov 2018 22:29:50 -0600
Date:   Tue, 27 Nov 2018 22:29:48 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     linux-kernel@vger.kernel.org
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 16/41] scsi: imm: mark expected switch fall-throughs
Message-ID: <42e3f9f751b662b7f0e4e763aa880bd752511c60.1543374820.git.gustavo@embeddedor.com>
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
X-Exim-ID: 1gRrTy-001mKT-MS
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.78.127]:58300
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 127
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Notice that, in this particular case, I placed all the "Phase N - ..."
comments on the same line as its corresponding switch case. The same
way in which similar comments appear in drivers/scsi/ppa.c. This makes
it possible to place the "fall through" annotations at the bottom of
each switch case, which is what GCC is expecting to find.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/scsi/imm.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/scsi/imm.c b/drivers/scsi/imm.c
index 8c6627bc8a39..629e0bc70d3e 100644
--- a/drivers/scsi/imm.c
+++ b/drivers/scsi/imm.c
@@ -796,21 +796,21 @@ static int imm_engine(imm_struct *dev, struct scsi_cmnd *cmd)
 			return 0;
 		}
 		return 1;	/* wait until imm_wakeup claims parport */
-		/* Phase 1 - Connected */
-	case 1:
+
+	case 1:		/* Phase 1 - Connected */
 		imm_connect(dev, CONNECT_EPP_MAYBE);
 		cmd->SCp.phase++;
+		/* fall through */
 
-		/* Phase 2 - We are now talking to the scsi bus */
-	case 2:
+	case 2:		/* Phase 2 - We are now talking to the scsi bus */
 		if (!imm_select(dev, scmd_id(cmd))) {
 			imm_fail(dev, DID_NO_CONNECT);
 			return 0;
 		}
 		cmd->SCp.phase++;
+		/* fall through */
 
-		/* Phase 3 - Ready to accept a command */
-	case 3:
+	case 3:		/* Phase 3 - Ready to accept a command */
 		w_ctr(ppb, 0x0c);
 		if (!(r_str(ppb) & 0x80))
 			return 1;
@@ -818,9 +818,9 @@ static int imm_engine(imm_struct *dev, struct scsi_cmnd *cmd)
 		if (!imm_send_command(cmd))
 			return 0;
 		cmd->SCp.phase++;
+		/* fall through */
 
-		/* Phase 4 - Setup scatter/gather buffers */
-	case 4:
+	case 4:		/* Phase 4 - Setup scatter/gather buffers */
 		if (scsi_bufflen(cmd)) {
 			cmd->SCp.buffer = scsi_sglist(cmd);
 			cmd->SCp.this_residual = cmd->SCp.buffer->length;
@@ -834,8 +834,9 @@ static int imm_engine(imm_struct *dev, struct scsi_cmnd *cmd)
 		cmd->SCp.phase++;
 		if (cmd->SCp.this_residual & 0x01)
 			cmd->SCp.this_residual++;
-		/* Phase 5 - Pre-Data transfer stage */
-	case 5:
+		/* fall through */
+
+	case 5:		/* Phase 5 - Pre-Data transfer stage */
 		/* Spin lock for BUSY */
 		w_ctr(ppb, 0x0c);
 		if (!(r_str(ppb) & 0x80))
@@ -850,9 +851,9 @@ static int imm_engine(imm_struct *dev, struct scsi_cmnd *cmd)
 			if (imm_negotiate(dev))
 				return 0;
 		cmd->SCp.phase++;
+		/* fall through */
 
-		/* Phase 6 - Data transfer stage */
-	case 6:
+	case 6:		/* Phase 6 - Data transfer stage */
 		/* Spin lock for BUSY */
 		w_ctr(ppb, 0x0c);
 		if (!(r_str(ppb) & 0x80))
@@ -866,9 +867,9 @@ static int imm_engine(imm_struct *dev, struct scsi_cmnd *cmd)
 				return 1;
 		}
 		cmd->SCp.phase++;
+		/* fall through */
 
-		/* Phase 7 - Post data transfer stage */
-	case 7:
+	case 7:		/* Phase 7 - Post data transfer stage */
 		if ((dev->dp) && (dev->rd)) {
 			if ((dev->mode == IMM_NIBBLE) || (dev->mode == IMM_PS2)) {
 				w_ctr(ppb, 0x4);
@@ -878,9 +879,9 @@ static int imm_engine(imm_struct *dev, struct scsi_cmnd *cmd)
 			}
 		}
 		cmd->SCp.phase++;
+		/* fall through */
 
-		/* Phase 8 - Read status/message */
-	case 8:
+	case 8:		/* Phase 8 - Read status/message */
 		/* Check for data overrun */
 		if (imm_wait(dev) != (unsigned char) 0xb8) {
 			imm_fail(dev, DID_ERROR);
-- 
2.17.1

