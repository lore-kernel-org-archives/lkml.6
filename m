Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C20C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 337B42081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:51:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 337B42081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbeK1Pve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 10:51:34 -0500
Received: from gateway30.websitewelcome.com ([192.185.168.15]:47077 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727394AbeK1Pvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 10:51:32 -0500
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id A99E046F3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 22:27:09 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id RrRNgJI3Q957pRrRNg2c4A; Tue, 27 Nov 2018 22:27:09 -0600
X-Authority-Reason: nr=8
Received: from [189.250.78.127] (port=58262 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gRrRM-001kKf-To; Tue, 27 Nov 2018 22:27:09 -0600
Date:   Tue, 27 Nov 2018 22:27:08 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 09/41] scsi: bfa: bfa_fcpim: Mark expected switch
 fall-throughs
Message-ID: <8f042a78366807fe4cf3c1f7157dc80f1dd49219.1543374820.git.gustavo@embeddedor.com>
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
X-Exim-ID: 1gRrRM-001kKf-To
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.78.127]:58262
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 93
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Notice that I replaced "Fall through !!!" with a "fall through"
annotation, which is what GCC is expecting to find.

Addresses-Coverity-ID: 114971 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/scsi/bfa/bfa_fcpim.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/bfa/bfa_fcpim.c b/drivers/scsi/bfa/bfa_fcpim.c
index 2c85f5b1f9c1..7e996bcf026c 100644
--- a/drivers/scsi/bfa/bfa_fcpim.c
+++ b/drivers/scsi/bfa/bfa_fcpim.c
@@ -2586,6 +2586,7 @@ bfa_ioim_send_ioreq(struct bfa_ioim_s *ioim)
 	case FCP_IODIR_RW:
 		bfa_stats(itnim, input_reqs);
 		bfa_stats(itnim, output_reqs);
+		/* fall through */
 	default:
 		bfi_h2i_set(m->mh, BFI_MC_IOIM_IO, 0, bfa_fn_lpu(ioim->bfa));
 	}
@@ -2820,6 +2821,7 @@ bfa_ioim_isr(struct bfa_s *bfa, struct bfi_msg_s *m)
 
 	case BFI_IOIM_STS_TIMEDOUT:
 		bfa_stats(ioim->itnim, iocomp_timedout);
+		/* fall through */
 	case BFI_IOIM_STS_ABORTED:
 		rsp->io_status = BFI_IOIM_STS_ABORTED;
 		bfa_stats(ioim->itnim, iocomp_aborted);
@@ -3215,9 +3217,7 @@ bfa_tskim_sm_cleanup_qfull(struct bfa_tskim_s *tskim,
 	switch (event) {
 	case BFA_TSKIM_SM_DONE:
 		bfa_reqq_wcancel(&tskim->reqq_wait);
-		/*
-		 * Fall through !!!
-		 */
+		/* fall through */
 	case BFA_TSKIM_SM_QRESUME:
 		bfa_sm_set_state(tskim, bfa_tskim_sm_cleanup);
 		bfa_tskim_send_abort(tskim);
-- 
2.17.1

