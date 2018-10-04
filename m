Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30E3C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 06:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF2422098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 06:59:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF2422098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbeJDNvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 09:51:01 -0400
Received: from gateway23.websitewelcome.com ([192.185.50.129]:26876 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727172AbeJDNvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 09:51:01 -0400
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 02C14E7C3
        for <linux-kernel@vger.kernel.org>; Thu,  4 Oct 2018 01:59:14 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 7xbNg8p4nSjJA7xbNggvvo; Thu, 04 Oct 2018 01:59:14 -0500
X-Authority-Reason: nr=8
Received: from 174.206.93.92.rev.sfr.net ([92.93.206.174]:48038 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1g7xbN-002uTW-8u; Thu, 04 Oct 2018 01:59:13 -0500
Date:   Thu, 4 Oct 2018 08:59:11 +0200
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Hannes Reinecke <hare@suse.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embededdor.com>
Subject: [PATCH] scsi: aic7xxx: mark expected switch fall-throughs
Message-ID: <20181004065641.GA11681@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 92.93.206.174
X-Source-L: No
X-Exim-ID: 1g7xbN-002uTW-8u
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 174.206.93.92.rev.sfr.net (embeddedor) [92.93.206.174]:48038
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 114961 ("Missing break in switch")
Addresses-Coverity-ID: 114962 ("Missing break in switch")
Addresses-Coverity-ID: 114963 ("Missing break in switch")
Addresses-Coverity-ID: 114964 ("Missing break in switch")
Addresses-Coverity-ID: 114965 ("Missing break in switch")
Addresses-Coverity-ID: 114966 ("Missing break in switch")
Addresses-Coverity-ID: 114967 ("Missing break in switch")
Addresses-Coverity-ID: 114968 ("Missing break in switch")
Addresses-Coverity-ID: 114969 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/scsi/aic7xxx/aic7xxx_core.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/aic7xxx/aic7xxx_core.c b/drivers/scsi/aic7xxx/aic7xxx_core.c
index f3362f4..5fe5384 100644
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
+				/* fall through  */
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
2.7.4

