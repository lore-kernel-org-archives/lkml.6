Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0900AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C11A92086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:57:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C11A92086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbeK1P5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 10:57:20 -0500
Received: from gateway22.websitewelcome.com ([192.185.47.168]:14457 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727008AbeK1P5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 10:57:06 -0500
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 7EC346497
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 22:32:20 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id RrWOgzPvUaSeyRrWOgC2sq; Tue, 27 Nov 2018 22:32:20 -0600
X-Authority-Reason: nr=8
Received: from [189.250.78.127] (port=58354 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gRrWN-001oyU-Nx; Tue, 27 Nov 2018 22:32:19 -0600
Date:   Tue, 27 Nov 2018 22:32:18 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 28/41] scsi: lpfc: lpfc_sli: Mark expected switch
 fall-throughs
Message-ID: <cb80d182329a02971ff365446b0e04771fc77da8.1543374820.git.gustavo@embeddedor.com>
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
X-Exim-ID: 1gRrWN-001oyU-Nx
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.78.127]:58354
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 201
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Notice that, in this particular case, I replaced "Drop thru" and
"Fall Thru" with "fall through" annotations, which is what GCC
is expecting to find.

Also, in some cases a dash is added as a token in order to separate
the "fall through" annotation from the rest of the comment on the
same line, which is what GCC is expecting to find.

Addresses-Coverity-ID: 114979 ("Missing break in switch")
Addresses-Coverity-ID: 114980 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/scsi/lpfc/lpfc_sli.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 3912a2d0b95d..cbcda5a91068 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -9334,6 +9334,7 @@ lpfc_sli4_iocb2wqe(struct lpfc_hba *phba, struct lpfc_iocbq *iocbq,
 		cmnd = CMD_XMIT_SEQUENCE64_CR;
 		if (phba->link_flag & LS_LOOPBACK_MODE)
 			bf_set(wqe_xo, &wqe->xmit_sequence.wge_ctl, 1);
+		/* fall through */
 	case CMD_XMIT_SEQUENCE64_CR:
 		/* word3 iocb=io_tag32 wqe=reserved */
 		wqe->xmit_sequence.rsvd3 = 0;
@@ -13460,6 +13461,7 @@ lpfc_sli4_sp_handle_rcqe(struct lpfc_hba *phba, struct lpfc_rcqe *rcqe)
 	case FC_STATUS_RQ_BUF_LEN_EXCEEDED:
 		lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
 				"2537 Receive Frame Truncated!!\n");
+		/* fall through */
 	case FC_STATUS_RQ_SUCCESS:
 		spin_lock_irqsave(&phba->hbalock, iflags);
 		lpfc_sli4_rq_release(hrq, drq);
@@ -13859,7 +13861,7 @@ lpfc_sli4_nvmet_handle_rcqe(struct lpfc_hba *phba, struct lpfc_queue *cq,
 	case FC_STATUS_RQ_BUF_LEN_EXCEEDED:
 		lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
 				"6126 Receive Frame Truncated!!\n");
-		/* Drop thru */
+		/* fall through */
 	case FC_STATUS_RQ_SUCCESS:
 		spin_lock_irqsave(&phba->hbalock, iflags);
 		lpfc_sli4_rq_release(hrq, drq);
@@ -14769,7 +14771,7 @@ lpfc_eq_create(struct lpfc_hba *phba, struct lpfc_queue *eq, uint32_t imax)
 				eq->entry_count);
 		if (eq->entry_count < 256)
 			return -EINVAL;
-		/* otherwise default to smallest count (drop through) */
+		/* fall through - otherwise default to smallest count */
 	case 256:
 		bf_set(lpfc_eq_context_count, &eq_create->u.request.context,
 		       LPFC_EQ_CNT_256);
@@ -14899,7 +14901,7 @@ lpfc_cq_create(struct lpfc_hba *phba, struct lpfc_queue *cq,
 			       LPFC_CQ_CNT_WORD7);
 			break;
 		}
-		/* Fall Thru */
+		/* fall through */
 	default:
 		lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
 				"0361 Unsupported CQ count: "
@@ -14910,7 +14912,7 @@ lpfc_cq_create(struct lpfc_hba *phba, struct lpfc_queue *cq,
 			status = -EINVAL;
 			goto out;
 		}
-		/* otherwise default to smallest count (drop through) */
+		/* fall through - otherwise default to smallest count */
 	case 256:
 		bf_set(lpfc_cq_context_count, &cq_create->u.request.context,
 		       LPFC_CQ_CNT_256);
@@ -15070,7 +15072,7 @@ lpfc_cq_create_set(struct lpfc_hba *phba, struct lpfc_queue **cqp,
 					       LPFC_CQ_CNT_WORD7);
 					break;
 				}
-				/* Fall Thru */
+				/* fall through */
 			default:
 				lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
 						"3118 Bad CQ count. (%d)\n",
@@ -15079,7 +15081,7 @@ lpfc_cq_create_set(struct lpfc_hba *phba, struct lpfc_queue **cqp,
 					status = -EINVAL;
 					goto out;
 				}
-				/* otherwise default to smallest (drop thru) */
+				/* fall through - otherwise default to smallest */
 			case 256:
 				bf_set(lpfc_mbx_cq_create_set_cqe_cnt,
 				       &cq_set->u.request, LPFC_CQ_CNT_256);
@@ -15351,7 +15353,7 @@ lpfc_mq_create(struct lpfc_hba *phba, struct lpfc_queue *mq,
 			status = -EINVAL;
 			goto out;
 		}
-		/* otherwise default to smallest count (drop through) */
+		/* fall through - otherwise default to smallest count */
 	case 16:
 		bf_set(lpfc_mq_context_ring_size,
 		       &mq_create_ext->u.request.context,
@@ -15770,7 +15772,7 @@ lpfc_rq_create(struct lpfc_hba *phba, struct lpfc_queue *hrq,
 				status = -EINVAL;
 				goto out;
 			}
-			/* otherwise default to smallest count (drop through) */
+			/* fall through - otherwise default to smallest count */
 		case 512:
 			bf_set(lpfc_rq_context_rqe_count,
 			       &rq_create->u.request.context,
@@ -15907,7 +15909,7 @@ lpfc_rq_create(struct lpfc_hba *phba, struct lpfc_queue *hrq,
 				status = -EINVAL;
 				goto out;
 			}
-			/* otherwise default to smallest count (drop through) */
+			/* fall through - otherwise default to smallest count */
 		case 512:
 			bf_set(lpfc_rq_context_rqe_count,
 			       &rq_create->u.request.context,
-- 
2.17.1

