Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C6CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3455218C3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730329AbeLSPjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:39:44 -0500
Received: from gateway33.websitewelcome.com ([192.185.145.24]:39076 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728249AbeLSPjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 10:39:44 -0500
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 8A86011D202
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 09:39:43 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id ZdwlgYGR490onZdwlg6MrW; Wed, 19 Dec 2018 09:39:43 -0600
X-Authority-Reason: nr=8
Received: from [189.250.106.44] (port=35330 helo=[192.168.1.76])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gZdwl-000ha3-6O; Wed, 19 Dec 2018 09:39:43 -0600
Subject: Re: [PATCH 13/41] scsi: csiostor: csio_wr: mark expected switch
 fall-through
To:     linux-kernel@vger.kernel.org
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
References: <cover.1543374820.git.gustavo@embeddedor.com>
 <5e846a635bfaf121af56e1f60a99816091e55170.1543374820.git.gustavo@embeddedor.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <a05a7975-b09b-fd0a-8af1-82ab3b90596e@embeddedor.com>
Date:   Wed, 19 Dec 2018 09:39:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5e846a635bfaf121af56e1f60a99816091e55170.1543374820.git.gustavo@embeddedor.com>
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
X-Exim-ID: 1gZdwl-000ha3-6O
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.76]) [189.250.106.44]:35330
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 56
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

On 11/27/18 10:28 PM, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Addresses-Coverity-ID: 1056538 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>   drivers/scsi/csiostor/csio_wr.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/scsi/csiostor/csio_wr.c b/drivers/scsi/csiostor/csio_wr.c
> index dc12933533d5..b6861ea66c9f 100644
> --- a/drivers/scsi/csiostor/csio_wr.c
> +++ b/drivers/scsi/csiostor/csio_wr.c
> @@ -808,6 +808,7 @@ csio_wr_destroy_queues(struct csio_hw *hw, bool cmd)
>   
>   				csio_q_eqid(hw, i) = CSIO_MAX_QID;
>   			}
> +			/* fall through */
>   		case CSIO_INGRESS:
>   			if (csio_q_iqid(hw, i) != CSIO_MAX_QID) {
>   				csio_wr_cleanup_iq_ftr(hw, i);
> 
