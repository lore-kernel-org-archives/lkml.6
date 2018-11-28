Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD4DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 404582081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:49:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 404582081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbeK1Pt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 10:49:56 -0500
Received: from gateway20.websitewelcome.com ([192.185.62.46]:12683 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726847AbeK1Pty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 10:49:54 -0500
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 123D1400CD68E
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 22:27:28 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id RrRggD85MPvAdRrRggswMy; Tue, 27 Nov 2018 22:27:28 -0600
X-Authority-Reason: nr=8
Received: from [189.250.78.127] (port=58266 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gRrRe-001kYd-BZ; Tue, 27 Nov 2018 22:27:27 -0600
Date:   Tue, 27 Nov 2018 22:27:23 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 11/41] scsi: bfa: bfa_fcs_rport: Mark expected switch
 fall-throughs
Message-ID: <c2a6667094f80fd7f72c887b2e7844b6341ce961.1543374820.git.gustavo@embeddedor.com>
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
X-Exim-ID: 1gRrRe-001kYd-BZ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.78.127]:58266
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 105
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Notice that I replaced "!! fall through !!" and "!!! fall through !!!"
comments with "fall through" annotations, which is what GCC is
expecting to find.

Addresses-Coverity-ID: 744899 ("Missing break in switch")
Addresses-Coverity-ID: 744900 ("Missing break in switch")
Addresses-Coverity-ID: 744901 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/scsi/bfa/bfa_fcs_rport.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/bfa/bfa_fcs_rport.c b/drivers/scsi/bfa/bfa_fcs_rport.c
index de50349a39ce..1e400f2aaece 100644
--- a/drivers/scsi/bfa/bfa_fcs_rport.c
+++ b/drivers/scsi/bfa/bfa_fcs_rport.c
@@ -427,17 +427,13 @@ bfa_fcs_rport_sm_plogi(struct bfa_fcs_rport_s *rport, enum rport_event event)
 
 	case RPSM_EVENT_LOGO_RCVD:
 		bfa_fcs_rport_send_logo_acc(rport);
-		/*
-		 * !! fall through !!
-		 */
+		/* fall through */
 	case RPSM_EVENT_PRLO_RCVD:
 		if (rport->prlo == BFA_TRUE)
 			bfa_fcs_rport_send_prlo_acc(rport);
 
 		bfa_fcxp_discard(rport->fcxp);
-		/*
-		 * !! fall through !!
-		 */
+		/* fall through */
 	case RPSM_EVENT_FAILED:
 		if (rport->plogi_retries < BFA_FCS_RPORT_MAX_RETRIES) {
 			rport->plogi_retries++;
@@ -868,9 +864,7 @@ bfa_fcs_rport_sm_adisc_online(struct bfa_fcs_rport_s *rport,
 		 * At least go offline when a PLOGI is received.
 		 */
 		bfa_fcxp_discard(rport->fcxp);
-		/*
-		 * !!! fall through !!!
-		 */
+		/* fall through */
 
 	case RPSM_EVENT_FAILED:
 	case RPSM_EVENT_ADDRESS_CHANGE:
@@ -1056,6 +1050,7 @@ bfa_fcs_rport_sm_fc4_logosend(struct bfa_fcs_rport_s *rport,
 
 	case RPSM_EVENT_LOGO_RCVD:
 		bfa_fcs_rport_send_logo_acc(rport);
+		/* fall through */
 	case RPSM_EVENT_PRLO_RCVD:
 		if (rport->prlo == BFA_TRUE)
 			bfa_fcs_rport_send_prlo_acc(rport);
@@ -1144,9 +1139,7 @@ bfa_fcs_rport_sm_hcb_offline(struct bfa_fcs_rport_s *rport,
 			bfa_fcs_rport_send_plogiacc(rport, NULL);
 			break;
 		}
-		/*
-		 * !! fall through !!
-		 */
+		/* fall through */
 
 	case RPSM_EVENT_ADDRESS_CHANGE:
 		if (!bfa_fcs_lport_is_online(rport->port)) {
@@ -1303,6 +1296,7 @@ bfa_fcs_rport_sm_hcb_logosend(struct bfa_fcs_rport_s *rport,
 
 	case RPSM_EVENT_LOGO_RCVD:
 		bfa_fcs_rport_send_logo_acc(rport);
+		/* fall through */
 	case RPSM_EVENT_PRLO_RCVD:
 		if (rport->prlo == BFA_TRUE)
 			bfa_fcs_rport_send_prlo_acc(rport);
@@ -1346,6 +1340,7 @@ bfa_fcs_rport_sm_logo_sending(struct bfa_fcs_rport_s *rport,
 
 	case RPSM_EVENT_LOGO_RCVD:
 		bfa_fcs_rport_send_logo_acc(rport);
+		/* fall through */
 	case RPSM_EVENT_PRLO_RCVD:
 		if (rport->prlo == BFA_TRUE)
 			bfa_fcs_rport_send_prlo_acc(rport);
-- 
2.17.1

