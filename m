Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD783C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABAF72081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:31:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABAF72081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbeK1Pbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 10:31:51 -0500
Received: from gateway21.websitewelcome.com ([192.185.45.250]:26490 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726847AbeK1Pbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 10:31:50 -0500
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Nov 2018 10:31:50 EST
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 1BC42400CEB87
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 22:31:37 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id RrVhgzPVRaSeyRrVhgC2T7; Tue, 27 Nov 2018 22:31:37 -0600
X-Authority-Reason: nr=8
Received: from [189.250.78.127] (port=58344 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gRrVg-001oAE-Dq; Tue, 27 Nov 2018 22:31:36 -0600
Date:   Tue, 27 Nov 2018 22:31:33 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 25/41] scsi: lpfc: lpfc_nportdisc: Mark expected switch
 fall-through
Message-ID: <8d1c41fb93d54415cfd0a8c1fa6d31a6a76db461.1543374820.git.gustavo@embeddedor.com>
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
X-Exim-ID: 1gRrVg-001oAE-Dq
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.78.127]:58344
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 183
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/scsi/lpfc/lpfc_nportdisc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/lpfc/lpfc_nportdisc.c b/drivers/scsi/lpfc/lpfc_nportdisc.c
index 7d5693cfaa87..e8583496feaf 100644
--- a/drivers/scsi/lpfc/lpfc_nportdisc.c
+++ b/drivers/scsi/lpfc/lpfc_nportdisc.c
@@ -360,6 +360,7 @@ lpfc_rcv_plogi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	case  NLP_STE_NPR_NODE:
 		if (!(ndlp->nlp_flag & NLP_NPR_ADISC))
 			break;
+		/* fall through */
 	case  NLP_STE_REG_LOGIN_ISSUE:
 	case  NLP_STE_PRLI_ISSUE:
 	case  NLP_STE_UNMAPPED_NODE:
-- 
2.17.1

