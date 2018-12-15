Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3067EC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 14:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 063D92084D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 14:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730286AbeLOO2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 09:28:16 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:54381 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729707AbeLOO2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 09:28:15 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gYAvL-00022w-NL; Sat, 15 Dec 2018 14:28:11 +0000
From:   Colin King <colin.king@canonical.com>
To:     Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: bfa: clean up a couple of indentation issues
Date:   Sat, 15 Dec 2018 14:28:09 +0000
Message-Id: <20181215142809.31115-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a break statement with an extra space that needs removed and
a call to bfa_trc that is indented one level too much. Fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/bfa/bfa_ioc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/bfa/bfa_ioc.c b/drivers/scsi/bfa/bfa_ioc.c
index 16d3aeb0e572..9631877aba4f 100644
--- a/drivers/scsi/bfa/bfa_ioc.c
+++ b/drivers/scsi/bfa/bfa_ioc.c
@@ -3819,7 +3819,7 @@ bfa_sfp_scn(struct bfa_sfp_s *sfp, struct bfi_mbmsg_s *msg)
 		sfp->state = BFA_SFP_STATE_REMOVED;
 		sfp->data_valid = 0;
 		bfa_sfp_scn_aen_post(sfp, rsp);
-		 break;
+		break;
 	case BFA_SFP_SCN_FAILED:
 		sfp->state = BFA_SFP_STATE_FAILED;
 		sfp->data_valid = 0;
@@ -5763,7 +5763,7 @@ bfa_phy_intr(void *phyarg, struct bfi_mbmsg_s *msg)
 				(struct bfa_phy_stats_s *) phy->ubuf;
 			bfa_phy_ntoh32((u32 *)stats, (u32 *)phy->dbuf_kva,
 				sizeof(struct bfa_phy_stats_s));
-				bfa_trc(phy, stats->status);
+			bfa_trc(phy, stats->status);
 		}
 
 		phy->status = status;
-- 
2.19.1

