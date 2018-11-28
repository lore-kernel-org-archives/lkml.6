Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0CDC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D1DE2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:56:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D1DE2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbeK1P4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 10:56:18 -0500
Received: from gateway32.websitewelcome.com ([192.185.145.111]:26457 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727312AbeK1P4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 10:56:18 -0500
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id 79B6D2AC469
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 22:31:27 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id RrVXgzPOlaSeyRrVXgC2MW; Tue, 27 Nov 2018 22:31:27 -0600
X-Authority-Reason: nr=8
Received: from [189.250.78.127] (port=58342 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gRrVV-001nzb-VR; Tue, 27 Nov 2018 22:31:26 -0600
Date:   Tue, 27 Nov 2018 22:31:23 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 24/41] scsi: lpfc: lpfc_hbadisc: Mark expected switch
 fall-throughs
Message-ID: <8db99b2700dd1589b8cf5ddb6b3de84dfe1e9f82.1543374820.git.gustavo@embeddedor.com>
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
X-Exim-ID: 1gRrVV-001nzb-VR
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.78.127]:58342
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 177
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Notice that, in this particular case, I replaced "Drop thru" with a
"fall through" annotation, which is what GCC is expecting to find.

Addresses-Coverity-ID: 114976 ("Missing break in switch")
Addresses-Coverity-ID: 114977 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/scsi/lpfc/lpfc_hbadisc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
index 6c2fb55d739b..1a61806739ff 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -4645,9 +4645,11 @@ lpfc_check_sli_ndlp(struct lpfc_hba *phba,
 		case CMD_GEN_REQUEST64_CR:
 			if (iocb->context_un.ndlp == ndlp)
 				return 1;
+			/* fall through */
 		case CMD_ELS_REQUEST64_CR:
 			if (icmd->un.elsreq64.remoteID == ndlp->nlp_DID)
 				return 1;
+			/* fall through */
 		case CMD_XMIT_ELS_RSP64_CX:
 			if (iocb->context1 == (uint8_t *) ndlp)
 				return 1;
@@ -5791,7 +5793,7 @@ lpfc_disc_timeout_handler(struct lpfc_vport *vport)
 
 	case LPFC_LINK_UP:
 		lpfc_issue_clear_la(phba, vport);
-		/* Drop thru */
+		/* fall through */
 	case LPFC_LINK_UNKNOWN:
 	case LPFC_WARM_START:
 	case LPFC_INIT_START:
-- 
2.17.1

