Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16783C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 05:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE5002086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 05:19:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE5002086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbeK1QT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 11:19:56 -0500
Received: from gateway36.websitewelcome.com ([192.185.197.22]:12343 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726972AbeK1QTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 11:19:55 -0500
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id 13EAC400CB2B1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 21:42:27 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id RrWwggWlskBj6RrWwgctYq; Tue, 27 Nov 2018 22:32:54 -0600
X-Authority-Reason: nr=8
Received: from [189.250.78.127] (port=58366 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gRrWv-001pRn-6u; Tue, 27 Nov 2018 22:32:53 -0600
Date:   Tue, 27 Nov 2018 22:32:52 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Hannes Reinecke <hare@kernel.org>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 32/41] scsi: myrb: Mark expected switch fall-throughs
Message-ID: <15cf75b544d6b2eae77ba98cd201620b44abec36.1543374820.git.gustavo@embeddedor.com>
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
X-Exim-ID: 1gRrWv-001pRn-6u
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.78.127]:58366
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 230
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 1465234 ("Missing break in switch")
Addresses-Coverity-ID: 1465238 ("Missing break in switch")
Addresses-Coverity-ID: 1465242 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/scsi/myrb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/myrb.c b/drivers/scsi/myrb.c
index 0642f2d0a3bb..539ac8ce4fcd 100644
--- a/drivers/scsi/myrb.c
+++ b/drivers/scsi/myrb.c
@@ -1528,6 +1528,7 @@ static int myrb_ldev_queuecommand(struct Scsi_Host *shost,
 			scmd->scsi_done(scmd);
 			return 0;
 		}
+		/* fall through */
 	case WRITE_6:
 		lba = (((scmd->cmnd[1] & 0x1F) << 16) |
 		       (scmd->cmnd[2] << 8) |
@@ -1544,6 +1545,7 @@ static int myrb_ldev_queuecommand(struct Scsi_Host *shost,
 			scmd->scsi_done(scmd);
 			return 0;
 		}
+		/* fall through */
 	case WRITE_10:
 	case VERIFY:		/* 0x2F */
 	case WRITE_VERIFY:	/* 0x2E */
@@ -1560,6 +1562,7 @@ static int myrb_ldev_queuecommand(struct Scsi_Host *shost,
 			scmd->scsi_done(scmd);
 			return 0;
 		}
+		/* fall through */
 	case WRITE_12:
 	case VERIFY_12: /* 0xAF */
 	case WRITE_VERIFY_12:	/* 0xAE */
-- 
2.17.1

