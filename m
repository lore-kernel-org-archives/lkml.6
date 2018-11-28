Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5006EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DD772081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:51:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DD772081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbeK1Pve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 10:51:34 -0500
Received: from gateway30.websitewelcome.com ([192.185.168.15]:18743 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727396AbeK1Pvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 10:51:32 -0500
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id A4C075A5D
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 22:27:18 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id RrRWgMvgFBcCXRrRWgSBTD; Tue, 27 Nov 2018 22:27:18 -0600
X-Authority-Reason: nr=8
Received: from [189.250.78.127] (port=58264 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gRrRV-001kRt-Sj; Tue, 27 Nov 2018 22:27:18 -0600
Date:   Tue, 27 Nov 2018 22:27:15 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 10/41] scsi: bfa: bfa_fcs_lport: Mark expected switch
 fall-throughs
Message-ID: <5cc329185c0b92f3aad001fc1afa54996a2c1112.1543374820.git.gustavo@embeddedor.com>
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
X-Exim-ID: 1gRrRV-001kRt-Sj
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.78.127]:58264
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 99
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Notice that, in this particular case, I replaced "!!! fall through !!!"
with a "fall through" annotation, which is what GCC is expecting to
find.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/scsi/bfa/bfa_fcs_lport.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/bfa/bfa_fcs_lport.c b/drivers/scsi/bfa/bfa_fcs_lport.c
index b4f2c1d8742e..646f09f66443 100644
--- a/drivers/scsi/bfa/bfa_fcs_lport.c
+++ b/drivers/scsi/bfa/bfa_fcs_lport.c
@@ -6430,9 +6430,7 @@ bfa_fcs_vport_sm_logo_for_stop(struct bfa_fcs_vport_s *vport,
 	switch (event) {
 	case BFA_FCS_VPORT_SM_OFFLINE:
 		bfa_sm_send_event(vport->lps, BFA_LPS_SM_OFFLINE);
-		/*
-		 * !!! fall through !!!
-		 */
+		/* fall through */
 
 	case BFA_FCS_VPORT_SM_RSP_OK:
 	case BFA_FCS_VPORT_SM_RSP_ERROR:
@@ -6458,9 +6456,7 @@ bfa_fcs_vport_sm_logo(struct bfa_fcs_vport_s *vport,
 	switch (event) {
 	case BFA_FCS_VPORT_SM_OFFLINE:
 		bfa_sm_send_event(vport->lps, BFA_LPS_SM_OFFLINE);
-		/*
-		 * !!! fall through !!!
-		 */
+		/* fall through */
 
 	case BFA_FCS_VPORT_SM_RSP_OK:
 	case BFA_FCS_VPORT_SM_RSP_ERROR:
-- 
2.17.1

