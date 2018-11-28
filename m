Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5267C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A39B82081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:31:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A39B82081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbeK1PbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 10:31:25 -0500
Received: from gateway23.websitewelcome.com ([192.185.50.141]:17923 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726847AbeK1PbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 10:31:25 -0500
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 6B1024554
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 22:31:11 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id RrVHggVjzkBj6RrVHgcsXc; Tue, 27 Nov 2018 22:31:11 -0600
X-Authority-Reason: nr=8
Received: from [189.250.78.127] (port=58332 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gRrVG-001niW-N9; Tue, 27 Nov 2018 22:31:10 -0600
Date:   Tue, 27 Nov 2018 22:31:08 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 22/41] scsi: lpfc: lpfc_ct: Mark expected switch fall-throughs
Message-ID: <4e80e3ae7cd0f0c54b45530a3772af4f606b0c8e.1543374820.git.gustavo@embeddedor.com>
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
X-Exim-ID: 1gRrVG-001niW-N9
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.78.127]:58332
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 165
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
 drivers/scsi/lpfc/lpfc_ct.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_ct.c b/drivers/scsi/lpfc/lpfc_ct.c
index 6305ffeba7ea..b2b7fcc23654 100644
--- a/drivers/scsi/lpfc/lpfc_ct.c
+++ b/drivers/scsi/lpfc/lpfc_ct.c
@@ -3050,6 +3050,7 @@ lpfc_fdmi_cmd(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	case SLI_MGMT_GHAT:
 	case SLI_MGMT_GRPL:
 		rsp_size = FC_MAX_NS_RSP;
+		/* fall through */
 	case SLI_MGMT_DHBA:
 	case SLI_MGMT_DHAT:
 		pe = (struct lpfc_fdmi_port_entry *)&CtReq->un.PortID;
@@ -3062,6 +3063,7 @@ lpfc_fdmi_cmd(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	case SLI_MGMT_GPAT:
 	case SLI_MGMT_GPAS:
 		rsp_size = FC_MAX_NS_RSP;
+		/* fall through */
 	case SLI_MGMT_DPRT:
 	case SLI_MGMT_DPA:
 		pe = (struct lpfc_fdmi_port_entry *)&CtReq->un.PortID;
-- 
2.17.1

