Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136F4C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DABF52081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:50:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DABF52081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbeK1PvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 10:51:09 -0500
Received: from gateway21.websitewelcome.com ([192.185.45.250]:21891 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727312AbeK1PvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 10:51:08 -0500
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id B0DA7400D0B08
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 22:26:33 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id RrQngD7VlPvAdRrQngsvnr; Tue, 27 Nov 2018 22:26:33 -0600
X-Authority-Reason: nr=8
Received: from [189.250.78.127] (port=58250 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gRrQm-001jpB-8F; Tue, 27 Nov 2018 22:26:33 -0600
Date:   Tue, 27 Nov 2018 22:26:29 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Hannes Reinecke <hare@suse.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 06/41] scsi: aic7xxx: mark expected switch fall-throughs
Message-ID: <b55c3f902d88871053983314cfa837e641db5db6.1543374820.git.gustavo@embeddedor.com>
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
X-Exim-ID: 1gRrQm-001jpB-8F
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.78.127]:58250
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 73
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Notice that, in some cases, I replaced "FALLTHROUGH" with a "fall through"
annotation and then placed it at the bottom of the corresponding switch
case, which is what GCC is expecting to find.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/scsi/aic7xxx/aic7xxx_core.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/aic7xxx/aic7xxx_core.c b/drivers/scsi/aic7xxx/aic7xxx_core.c
index f3362f4ab16e..d4a7263e4b8f 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_core.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_core.c
@@ -4920,24 +4920,30 @@ ahc_fini_scbdata(struct ahc_softc *ahc)
 		}
 		ahc_dma_tag_destroy(ahc, scb_data->sg_dmat);
 	}
+		/* fall through */
 	case 6:
 		ahc_dmamap_unload(ahc, scb_data->sense_dmat,
 				  scb_data->sense_dmamap);
+		/* fall through */
 	case 5:
 		ahc_dmamem_free(ahc, scb_data->sense_dmat, scb_data->sense,
 				scb_data->sense_dmamap);
 		ahc_dmamap_destroy(ahc, scb_data->sense_dmat,
 				   scb_data->sense_dmamap);
+		/* fall through */
 	case 4:
 		ahc_dma_tag_destroy(ahc, scb_data->sense_dmat);
+		/* fall through */
 	case 3:
 		ahc_dmamap_unload(ahc, scb_data->hscb_dmat,
 				  scb_data->hscb_dmamap);
+		/* fall through */
 	case 2:
 		ahc_dmamem_free(ahc, scb_data->hscb_dmat, scb_data->hscbs,
 				scb_data->hscb_dmamap);
 		ahc_dmamap_destroy(ahc, scb_data->hscb_dmat,
 				   scb_data->hscb_dmamap);
+		/* fall through */
 	case 1:
 		ahc_dma_tag_destroy(ahc, scb_data->hscb_dmat);
 		break;
@@ -6002,8 +6008,8 @@ ahc_search_qinfifo(struct ahc_softc *ahc, int target, char channel,
 				if ((scb->flags & SCB_ACTIVE) == 0)
 					printk("Inactive SCB in Waiting List\n");
 				ahc_done(ahc, scb);
-				/* FALLTHROUGH */
 			}
+				/* fall through */
 			case SEARCH_REMOVE:
 				next = ahc_rem_wscb(ahc, next, prev);
 				break;
@@ -7008,8 +7014,8 @@ ahc_download_instr(struct ahc_softc *ahc, u_int instrptr, uint8_t *dconsts)
 		}
 		address -= address_offset;
 		fmt3_ins->address = address;
-		/* FALLTHROUGH */
 	}
+		/* fall through */
 	case AIC_OP_OR:
 	case AIC_OP_AND:
 	case AIC_OP_XOR:
@@ -7035,7 +7041,7 @@ ahc_download_instr(struct ahc_softc *ahc, u_int instrptr, uint8_t *dconsts)
 			fmt1_ins->opcode = AIC_OP_AND;
 			fmt1_ins->immediate = 0xff;
 		}
-		/* FALLTHROUGH */
+		/* fall through */
 	case AIC_OP_ROL:
 		if ((ahc->features & AHC_ULTRA2) != 0) {
 			int i, count;
-- 
2.17.1

