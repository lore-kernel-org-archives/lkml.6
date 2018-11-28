Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E1BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D623D2081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:49:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D623D2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbeK1PuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 10:50:06 -0500
Received: from gateway24.websitewelcome.com ([192.185.51.122]:12804 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727394AbeK1PuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 10:50:06 -0500
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 7E0605F29
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 22:27:36 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id RrRogD8ALPvAdRrRogswRz; Tue, 27 Nov 2018 22:27:36 -0600
X-Authority-Reason: nr=8
Received: from [189.250.78.127] (port=58268 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gRrRm-001kgE-Re; Tue, 27 Nov 2018 22:27:35 -0600
Date:   Tue, 27 Nov 2018 22:27:32 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 12/41] scsi: bfa: bfa_ioc: Mark expected switch fall-throughs
Message-ID: <520fb16cd3630d612c5768989e2ffa90f1a73f97.1543374820.git.gustavo@embeddedor.com>
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
X-Exim-ID: 1gRrRm-001kgE-Re
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.78.127]:58268
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 111
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Notice that, in this particular case, I replaced "!!! fall through !!!"
comment with "fall through" annotations, which is what GCC is expecting
to find.

Addresses-Coverity-ID: 146155 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/scsi/bfa/bfa_ioc.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/bfa/bfa_ioc.c b/drivers/scsi/bfa/bfa_ioc.c
index 16d3aeb0e572..32b24e51cce6 100644
--- a/drivers/scsi/bfa/bfa_ioc.c
+++ b/drivers/scsi/bfa/bfa_ioc.c
@@ -978,9 +978,7 @@ bfa_iocpf_sm_enabling(struct bfa_iocpf_s *iocpf, enum iocpf_event event)
 
 	case IOCPF_E_INITFAIL:
 		bfa_iocpf_timer_stop(ioc);
-		/*
-		 * !!! fall through !!!
-		 */
+		/* fall through */
 
 	case IOCPF_E_TIMEOUT:
 		writel(1, ioc->ioc_regs.ioc_sem_reg);
@@ -1056,9 +1054,7 @@ bfa_iocpf_sm_disabling(struct bfa_iocpf_s *iocpf, enum iocpf_event event)
 
 	case IOCPF_E_FAIL:
 		bfa_iocpf_timer_stop(ioc);
-		/*
-		 * !!! fall through !!!
-		 */
+		/* fall through */
 
 	case IOCPF_E_TIMEOUT:
 		bfa_ioc_set_cur_ioc_fwstate(ioc, BFI_IOC_FAIL);
@@ -6007,6 +6003,7 @@ bfa_dconf_sm_final_sync(struct bfa_dconf_mod_s *dconf,
 	case BFA_DCONF_SM_IOCDISABLE:
 	case BFA_DCONF_SM_FLASH_COMP:
 		bfa_timer_stop(&dconf->timer);
+		/* fall through */
 	case BFA_DCONF_SM_TIMEOUT:
 		bfa_sm_set_state(dconf, bfa_dconf_sm_uninit);
 		bfa_fsm_send_event(&dconf->bfa->iocfc, IOCFC_E_DCONF_DONE);
-- 
2.17.1

