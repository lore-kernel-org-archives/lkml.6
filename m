Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC43C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECFA820874
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbeLSW2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 17:28:12 -0500
Received: from gateway32.websitewelcome.com ([192.185.145.113]:19273 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730002AbeLSW2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 17:28:11 -0500
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id 83A95144D66
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 16:28:10 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id ZkK2gs9iIiQerZkK2gxcSt; Wed, 19 Dec 2018 16:28:10 -0600
X-Authority-Reason: nr=8
Received: from [189.250.106.44] (port=47232 helo=[192.168.1.76])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gZkK2-000E7O-1o; Wed, 19 Dec 2018 16:28:10 -0600
Subject: Re: [PATCH 28/41] scsi: lpfc: lpfc_sli: Mark expected switch
 fall-throughs
To:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1543374820.git.gustavo@embeddedor.com>
 <cb80d182329a02971ff365446b0e04771fc77da8.1543374820.git.gustavo@embeddedor.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <1a29b249-e248-d4ea-525e-e5f3efece00f@embeddedor.com>
Date:   Wed, 19 Dec 2018 16:28:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <cb80d182329a02971ff365446b0e04771fc77da8.1543374820.git.gustavo@embeddedor.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.106.44
X-Source-L: No
X-Exim-ID: 1gZkK2-000E7O-1o
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.76]) [189.250.106.44]:47232
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 70
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Friendly ping:

Who can ack or review this patch, please?

Thanks
-- 
Gustavo

On 11/27/18 10:32 PM, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Notice that, in this particular case, I replaced "Drop thru" and
> "Fall Thru" with "fall through" annotations, which is what GCC
> is expecting to find.
> 
> Also, in some cases a dash is added as a token in order to separate
> the "fall through" annotation from the rest of the comment on the
> same line, which is what GCC is expecting to find.
> 
> Addresses-Coverity-ID: 114979 ("Missing break in switch")
> Addresses-Coverity-ID: 114980 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>   drivers/scsi/lpfc/lpfc_sli.c | 20 +++++++++++---------
>   1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
> index 3912a2d0b95d..cbcda5a91068 100644
> --- a/drivers/scsi/lpfc/lpfc_sli.c
> +++ b/drivers/scsi/lpfc/lpfc_sli.c
> @@ -9334,6 +9334,7 @@ lpfc_sli4_iocb2wqe(struct lpfc_hba *phba, struct lpfc_iocbq *iocbq,
>   		cmnd = CMD_XMIT_SEQUENCE64_CR;
>   		if (phba->link_flag & LS_LOOPBACK_MODE)
>   			bf_set(wqe_xo, &wqe->xmit_sequence.wge_ctl, 1);
> +		/* fall through */
>   	case CMD_XMIT_SEQUENCE64_CR:
>   		/* word3 iocb=io_tag32 wqe=reserved */
>   		wqe->xmit_sequence.rsvd3 = 0;
> @@ -13460,6 +13461,7 @@ lpfc_sli4_sp_handle_rcqe(struct lpfc_hba *phba, struct lpfc_rcqe *rcqe)
>   	case FC_STATUS_RQ_BUF_LEN_EXCEEDED:
>   		lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
>   				"2537 Receive Frame Truncated!!\n");
> +		/* fall through */
>   	case FC_STATUS_RQ_SUCCESS:
>   		spin_lock_irqsave(&phba->hbalock, iflags);
>   		lpfc_sli4_rq_release(hrq, drq);
> @@ -13859,7 +13861,7 @@ lpfc_sli4_nvmet_handle_rcqe(struct lpfc_hba *phba, struct lpfc_queue *cq,
>   	case FC_STATUS_RQ_BUF_LEN_EXCEEDED:
>   		lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
>   				"6126 Receive Frame Truncated!!\n");
> -		/* Drop thru */
> +		/* fall through */
>   	case FC_STATUS_RQ_SUCCESS:
>   		spin_lock_irqsave(&phba->hbalock, iflags);
>   		lpfc_sli4_rq_release(hrq, drq);
> @@ -14769,7 +14771,7 @@ lpfc_eq_create(struct lpfc_hba *phba, struct lpfc_queue *eq, uint32_t imax)
>   				eq->entry_count);
>   		if (eq->entry_count < 256)
>   			return -EINVAL;
> -		/* otherwise default to smallest count (drop through) */
> +		/* fall through - otherwise default to smallest count */
>   	case 256:
>   		bf_set(lpfc_eq_context_count, &eq_create->u.request.context,
>   		       LPFC_EQ_CNT_256);
> @@ -14899,7 +14901,7 @@ lpfc_cq_create(struct lpfc_hba *phba, struct lpfc_queue *cq,
>   			       LPFC_CQ_CNT_WORD7);
>   			break;
>   		}
> -		/* Fall Thru */
> +		/* fall through */
>   	default:
>   		lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
>   				"0361 Unsupported CQ count: "
> @@ -14910,7 +14912,7 @@ lpfc_cq_create(struct lpfc_hba *phba, struct lpfc_queue *cq,
>   			status = -EINVAL;
>   			goto out;
>   		}
> -		/* otherwise default to smallest count (drop through) */
> +		/* fall through - otherwise default to smallest count */
>   	case 256:
>   		bf_set(lpfc_cq_context_count, &cq_create->u.request.context,
>   		       LPFC_CQ_CNT_256);
> @@ -15070,7 +15072,7 @@ lpfc_cq_create_set(struct lpfc_hba *phba, struct lpfc_queue **cqp,
>   					       LPFC_CQ_CNT_WORD7);
>   					break;
>   				}
> -				/* Fall Thru */
> +				/* fall through */
>   			default:
>   				lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
>   						"3118 Bad CQ count. (%d)\n",
> @@ -15079,7 +15081,7 @@ lpfc_cq_create_set(struct lpfc_hba *phba, struct lpfc_queue **cqp,
>   					status = -EINVAL;
>   					goto out;
>   				}
> -				/* otherwise default to smallest (drop thru) */
> +				/* fall through - otherwise default to smallest */
>   			case 256:
>   				bf_set(lpfc_mbx_cq_create_set_cqe_cnt,
>   				       &cq_set->u.request, LPFC_CQ_CNT_256);
> @@ -15351,7 +15353,7 @@ lpfc_mq_create(struct lpfc_hba *phba, struct lpfc_queue *mq,
>   			status = -EINVAL;
>   			goto out;
>   		}
> -		/* otherwise default to smallest count (drop through) */
> +		/* fall through - otherwise default to smallest count */
>   	case 16:
>   		bf_set(lpfc_mq_context_ring_size,
>   		       &mq_create_ext->u.request.context,
> @@ -15770,7 +15772,7 @@ lpfc_rq_create(struct lpfc_hba *phba, struct lpfc_queue *hrq,
>   				status = -EINVAL;
>   				goto out;
>   			}
> -			/* otherwise default to smallest count (drop through) */
> +			/* fall through - otherwise default to smallest count */
>   		case 512:
>   			bf_set(lpfc_rq_context_rqe_count,
>   			       &rq_create->u.request.context,
> @@ -15907,7 +15909,7 @@ lpfc_rq_create(struct lpfc_hba *phba, struct lpfc_queue *hrq,
>   				status = -EINVAL;
>   				goto out;
>   			}
> -			/* otherwise default to smallest count (drop through) */
> +			/* fall through - otherwise default to smallest count */
>   		case 512:
>   			bf_set(lpfc_rq_context_rqe_count,
>   			       &rq_create->u.request.context,
> 
