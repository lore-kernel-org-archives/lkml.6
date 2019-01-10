Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99355C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CF0D208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbfAJUCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 15:02:15 -0500
Received: from gateway23.websitewelcome.com ([192.185.49.219]:35811 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726242AbfAJUCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 15:02:14 -0500
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 9FA485236
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 14:02:13 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id hgWrgBxJL90onhgWrgflMh; Thu, 10 Jan 2019 14:02:13 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=41146 helo=[192.168.43.131])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1ghgWq-002Vva-TR; Thu, 10 Jan 2019 14:02:13 -0600
Subject: Re: [PATCH 26/41] scsi: lpfc: lpfc_nvme: Mark expected switch
 fall-through
To:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1543374820.git.gustavo@embeddedor.com>
 <79e1e3ed62a02dc3caf264f6960e7be68bbbc70c.1543374820.git.gustavo@embeddedor.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <fffe7a61-abb9-6715-9104-6381002196cd@embeddedor.com>
Date:   Thu, 10 Jan 2019 14:02:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <79e1e3ed62a02dc3caf264f6960e7be68bbbc70c.1543374820.git.gustavo@embeddedor.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1ghgWq-002Vva-TR
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.43.131]) [189.250.130.205]:41146
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 12
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Friendly ping (second one):

Who can ack/review/take this patch, please?

Thanks
--
Gustavo

On 11/27/18 10:31 PM, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>   drivers/scsi/lpfc/lpfc_nvme.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/scsi/lpfc/lpfc_nvme.c b/drivers/scsi/lpfc/lpfc_nvme.c
> index ba831def9301..942fe58c433d 100644
> --- a/drivers/scsi/lpfc/lpfc_nvme.c
> +++ b/drivers/scsi/lpfc/lpfc_nvme.c
> @@ -1115,6 +1115,7 @@ lpfc_nvme_io_cmd_wqe_cmpl(struct lpfc_hba *phba, struct lpfc_iocbq *pwqeIn,
>   					 lpfc_ncmd, nCmd,
>   					 lpfc_ncmd->cur_iocbq.sli4_xritag,
>   					 bf_get(lpfc_wcqe_c_xb, wcqe));
> +			/* fall through */
>   		default:
>   out_err:
>   			lpfc_printf_vlog(vport, KERN_INFO, LOG_NVME_IOERR,
> 
