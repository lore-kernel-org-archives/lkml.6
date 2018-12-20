Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26E8C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 00:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A709420873
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 00:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730351AbeLTAHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 19:07:18 -0500
Received: from gateway36.websitewelcome.com ([192.185.187.5]:42457 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727589AbeLTAHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 19:07:17 -0500
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id E83FB400C5EA0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 17:18:07 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id ZlrwgQuK14FKpZlrwgwFy4; Wed, 19 Dec 2018 18:07:16 -0600
X-Authority-Reason: nr=8
Received: from [189.250.106.44] (port=50512 helo=[192.168.1.76])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gZlrw-0015Bg-8u; Wed, 19 Dec 2018 18:07:16 -0600
Subject: Re: [PATCH 32/41] scsi: myrb: Mark expected switch fall-throughs
To:     Hannes Reinecke <hare@kernel.org>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1543374820.git.gustavo@embeddedor.com>
 <15cf75b544d6b2eae77ba98cd201620b44abec36.1543374820.git.gustavo@embeddedor.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <025dd9a3-e2a0-cb21-8458-f671a673f634@embeddedor.com>
Date:   Wed, 19 Dec 2018 18:07:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <15cf75b544d6b2eae77ba98cd201620b44abec36.1543374820.git.gustavo@embeddedor.com>
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
X-Exim-ID: 1gZlrw-0015Bg-8u
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.76]) [189.250.106.44]:50512
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 20
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
> Addresses-Coverity-ID: 1465234 ("Missing break in switch")
> Addresses-Coverity-ID: 1465238 ("Missing break in switch")
> Addresses-Coverity-ID: 1465242 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>   drivers/scsi/myrb.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/scsi/myrb.c b/drivers/scsi/myrb.c
> index 0642f2d0a3bb..539ac8ce4fcd 100644
> --- a/drivers/scsi/myrb.c
> +++ b/drivers/scsi/myrb.c
> @@ -1528,6 +1528,7 @@ static int myrb_ldev_queuecommand(struct Scsi_Host *shost,
>   			scmd->scsi_done(scmd);
>   			return 0;
>   		}
> +		/* fall through */
>   	case WRITE_6:
>   		lba = (((scmd->cmnd[1] & 0x1F) << 16) |
>   		       (scmd->cmnd[2] << 8) |
> @@ -1544,6 +1545,7 @@ static int myrb_ldev_queuecommand(struct Scsi_Host *shost,
>   			scmd->scsi_done(scmd);
>   			return 0;
>   		}
> +		/* fall through */
>   	case WRITE_10:
>   	case VERIFY:		/* 0x2F */
>   	case WRITE_VERIFY:	/* 0x2E */
> @@ -1560,6 +1562,7 @@ static int myrb_ldev_queuecommand(struct Scsi_Host *shost,
>   			scmd->scsi_done(scmd);
>   			return 0;
>   		}
> +		/* fall through */
>   	case WRITE_12:
>   	case VERIFY_12: /* 0xAF */
>   	case WRITE_VERIFY_12:	/* 0xAE */
> 
