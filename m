Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3BAC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23DDA20657
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbfAJUDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 15:03:17 -0500
Received: from gateway31.websitewelcome.com ([192.185.143.39]:37493 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726242AbfAJUDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 15:03:17 -0500
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 1DC11DEE11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 14:03:17 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id hgXtgDZwq2qH7hgXtgs8JL; Thu, 10 Jan 2019 14:03:17 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=41168 helo=[192.168.43.131])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1ghgXs-002Ws1-I2; Thu, 10 Jan 2019 14:03:16 -0600
Subject: Re: [PATCH 24/41] scsi: lpfc: lpfc_hbadisc: Mark expected switch
 fall-throughs
To:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1543374820.git.gustavo@embeddedor.com>
 <8db99b2700dd1589b8cf5ddb6b3de84dfe1e9f82.1543374820.git.gustavo@embeddedor.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <45372bd0-7785-8353-45fc-6638ac726fb8@embeddedor.com>
Date:   Thu, 10 Jan 2019 14:03:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <8db99b2700dd1589b8cf5ddb6b3de84dfe1e9f82.1543374820.git.gustavo@embeddedor.com>
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
X-Exim-ID: 1ghgXs-002Ws1-I2
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.43.131]) [189.250.130.205]:41168
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 18
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
> Notice that, in this particular case, I replaced "Drop thru" with a
> "fall through" annotation, which is what GCC is expecting to find.
> 
> Addresses-Coverity-ID: 114976 ("Missing break in switch")
> Addresses-Coverity-ID: 114977 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>   drivers/scsi/lpfc/lpfc_hbadisc.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
> index 6c2fb55d739b..1a61806739ff 100644
> --- a/drivers/scsi/lpfc/lpfc_hbadisc.c
> +++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
> @@ -4645,9 +4645,11 @@ lpfc_check_sli_ndlp(struct lpfc_hba *phba,
>   		case CMD_GEN_REQUEST64_CR:
>   			if (iocb->context_un.ndlp == ndlp)
>   				return 1;
> +			/* fall through */
>   		case CMD_ELS_REQUEST64_CR:
>   			if (icmd->un.elsreq64.remoteID == ndlp->nlp_DID)
>   				return 1;
> +			/* fall through */
>   		case CMD_XMIT_ELS_RSP64_CX:
>   			if (iocb->context1 == (uint8_t *) ndlp)
>   				return 1;
> @@ -5791,7 +5793,7 @@ lpfc_disc_timeout_handler(struct lpfc_vport *vport)
>   
>   	case LPFC_LINK_UP:
>   		lpfc_issue_clear_la(phba, vport);
> -		/* Drop thru */
> +		/* fall through */
>   	case LPFC_LINK_UNKNOWN:
>   	case LPFC_WARM_START:
>   	case LPFC_INIT_START:
> 
