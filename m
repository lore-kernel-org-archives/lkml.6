Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22493C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE30D2086C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730289AbeLSPjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:39:11 -0500
Received: from gateway32.websitewelcome.com ([192.185.145.102]:47073 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728040AbeLSPjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 10:39:10 -0500
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id DFECE18C3C3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 09:39:09 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id ZdwDgZhws2qH7ZdwDgIWea; Wed, 19 Dec 2018 09:39:09 -0600
X-Authority-Reason: nr=8
Received: from [189.250.106.44] (port=35318 helo=[192.168.1.76])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gZdwD-000h8S-Gh; Wed, 19 Dec 2018 09:39:09 -0600
Subject: Re: [PATCH 10/41] scsi: bfa: bfa_fcs_lport: Mark expected switch
 fall-throughs
To:     Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1543374820.git.gustavo@embeddedor.com>
 <5cc329185c0b92f3aad001fc1afa54996a2c1112.1543374820.git.gustavo@embeddedor.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <a2a4fd41-d231-4d72-a95e-e1109c209f94@embeddedor.com>
Date:   Wed, 19 Dec 2018 09:39:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5cc329185c0b92f3aad001fc1afa54996a2c1112.1543374820.git.gustavo@embeddedor.com>
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
X-Exim-ID: 1gZdwD-000h8S-Gh
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.76]) [189.250.106.44]:35318
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 43
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

On 11/27/18 10:27 PM, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Notice that, in this particular case, I replaced "!!! fall through !!!"
> with a "fall through" annotation, which is what GCC is expecting to
> find.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>   drivers/scsi/bfa/bfa_fcs_lport.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/scsi/bfa/bfa_fcs_lport.c b/drivers/scsi/bfa/bfa_fcs_lport.c
> index b4f2c1d8742e..646f09f66443 100644
> --- a/drivers/scsi/bfa/bfa_fcs_lport.c
> +++ b/drivers/scsi/bfa/bfa_fcs_lport.c
> @@ -6430,9 +6430,7 @@ bfa_fcs_vport_sm_logo_for_stop(struct bfa_fcs_vport_s *vport,
>   	switch (event) {
>   	case BFA_FCS_VPORT_SM_OFFLINE:
>   		bfa_sm_send_event(vport->lps, BFA_LPS_SM_OFFLINE);
> -		/*
> -		 * !!! fall through !!!
> -		 */
> +		/* fall through */
>   
>   	case BFA_FCS_VPORT_SM_RSP_OK:
>   	case BFA_FCS_VPORT_SM_RSP_ERROR:
> @@ -6458,9 +6456,7 @@ bfa_fcs_vport_sm_logo(struct bfa_fcs_vport_s *vport,
>   	switch (event) {
>   	case BFA_FCS_VPORT_SM_OFFLINE:
>   		bfa_sm_send_event(vport->lps, BFA_LPS_SM_OFFLINE);
> -		/*
> -		 * !!! fall through !!!
> -		 */
> +		/* fall through */
>   
>   	case BFA_FCS_VPORT_SM_RSP_OK:
>   	case BFA_FCS_VPORT_SM_RSP_ERROR:
> 
