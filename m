Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF624C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E5FA2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:46:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E5FA2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbeK1PqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 10:46:20 -0500
Received: from gateway31.websitewelcome.com ([192.185.144.97]:14103 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726847AbeK1PqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 10:46:20 -0500
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 94C133ED2D
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 22:25:43 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id RrPzgJH7n957pRrPzg2b9B; Tue, 27 Nov 2018 22:25:43 -0600
X-Authority-Reason: nr=8
Received: from [189.250.78.127] (port=58232 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gRrPy-001jAq-Rg; Tue, 27 Nov 2018 22:25:43 -0600
Date:   Tue, 27 Nov 2018 22:25:41 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Adaptec OEM Raid Solutions <aacraid@microsemi.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 03/41] scsi: aacraid: aachba: Mark expected switch
 fall-throughs
Message-ID: <fba277107d0b94bdd6e7cabf1d17e0fb0b6e13d8.1543374820.git.gustavo@embeddedor.com>
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
X-Exim-ID: 1gRrPy-001jAq-Rg
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.78.127]:58232
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 58
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Also, a break statement is properly aligned.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/scsi/aacraid/aachba.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/aacraid/aachba.c b/drivers/scsi/aacraid/aachba.c
index bd7f352c28f3..75ab5ff6b78c 100644
--- a/drivers/scsi/aacraid/aachba.c
+++ b/drivers/scsi/aacraid/aachba.c
@@ -2892,6 +2892,7 @@ int aac_scsi_cmd(struct scsi_cmnd * scsicmd)
 					    !(dev->raw_io_64) ||
 					    ((scsicmd->cmnd[1] & 0x1f) != SAI_READ_CAPACITY_16))
 						break;
+					/* fall through */
 				case INQUIRY:
 				case READ_CAPACITY:
 				case TEST_UNIT_READY:
@@ -2966,6 +2967,7 @@ int aac_scsi_cmd(struct scsi_cmnd * scsicmd)
 		/* Issue FIB to tell Firmware to flush it's cache */
 		if ((aac_cache & 6) != 2)
 			return aac_synchronize(scsicmd);
+		/* fall through */
 	case INQUIRY:
 	{
 		struct inquiry_data inq_data;
@@ -3319,8 +3321,9 @@ int aac_scsi_cmd(struct scsi_cmnd * scsicmd)
 			       min_t(size_t,
 				     sizeof(dev->fsa_dev[cid].sense_data),
 				     SCSI_SENSE_BUFFERSIZE));
-		break;
+			break;
 		}
+		/* fall through */
 	case RESERVE:
 	case RELEASE:
 	case REZERO_UNIT:
-- 
2.17.1

