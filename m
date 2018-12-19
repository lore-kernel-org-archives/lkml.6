Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65083C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E3D20873
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730050AbeLSW2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 17:28:07 -0500
Received: from gateway32.websitewelcome.com ([192.185.145.113]:37761 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730002AbeLSW2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 17:28:06 -0500
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id 6DE5D144D54
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 16:28:05 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id ZkJxgs9d9iQerZkJxgxcNL; Wed, 19 Dec 2018 16:28:05 -0600
X-Authority-Reason: nr=8
Received: from [189.250.106.44] (port=47228 helo=[192.168.1.76])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gZkJx-000E1N-0f; Wed, 19 Dec 2018 16:28:05 -0600
Subject: Re: [PATCH 27/41] scsi: lpfc: lpfc_scsi: Mark expected switch
 fall-throughs
To:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1543374820.git.gustavo@embeddedor.com>
 <4c7efa89883829e21a09e558139e5d8a0d94dee0.1543374820.git.gustavo@embeddedor.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <a0d88f0a-bd1b-41aa-d325-dbfa1e217b23@embeddedor.com>
Date:   Wed, 19 Dec 2018 16:28:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <4c7efa89883829e21a09e558139e5d8a0d94dee0.1543374820.git.gustavo@embeddedor.com>
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
X-Exim-ID: 1gZkJx-000E1N-0f
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.76]) [189.250.106.44]:47228
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 64
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
> Notice that, in this particular case, I replaced "Drop thru" with
> "fall through" annotations, which is what GCC is expecting to find.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>   drivers/scsi/lpfc/lpfc_scsi.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
> index baed2b891efb..0eeed6c4c2ee 100644
> --- a/drivers/scsi/lpfc/lpfc_scsi.c
> +++ b/drivers/scsi/lpfc/lpfc_scsi.c
> @@ -1427,7 +1427,7 @@ lpfc_bg_err_inject(struct lpfc_hba *phba, struct scsi_cmnd *sc,
>   
>   					break;
>   				}
> -				/* Drop thru */
> +				/* fall through */
>   			case SCSI_PROT_WRITE_INSERT:
>   				/*
>   				 * For WRITE_INSERT, force the error
> @@ -1546,7 +1546,7 @@ lpfc_bg_err_inject(struct lpfc_hba *phba, struct scsi_cmnd *sc,
>   					rc = BG_ERR_TGT | BG_ERR_CHECK;
>   					break;
>   				}
> -				/* Drop thru */
> +				/* fall through */
>   			case SCSI_PROT_WRITE_INSERT:
>   				/*
>   				 * For WRITE_INSERT, force the
> @@ -1628,7 +1628,7 @@ lpfc_bg_err_inject(struct lpfc_hba *phba, struct scsi_cmnd *sc,
>   			switch (op) {
>   			case SCSI_PROT_WRITE_PASS:
>   				rc = BG_ERR_CHECK;
> -				/* Drop thru */
> +				/* fall through */
>   
>   			case SCSI_PROT_WRITE_INSERT:
>   				/*
> @@ -4115,7 +4115,7 @@ lpfc_scsi_cmd_iocb_cmpl(struct lpfc_hba *phba, struct lpfc_iocbq *pIocbIn,
>   					lpfc_cmd->cur_iocbq.sli4_lxritag,
>   					0, 0);
>   			}
> -		/* else: fall through */
> +			/* fall through */
>   		default:
>   			cmd->result = DID_ERROR << 16;
>   			break;
> 
