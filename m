Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA33C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 00:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 506F920873
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 00:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730418AbeLTAHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 19:07:50 -0500
Received: from gateway36.websitewelcome.com ([192.185.187.5]:44608 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730399AbeLTAHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 19:07:49 -0500
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id 8B1F9400CA63A
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 17:18:40 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id ZlsTgitoI90onZlsTgGwIB; Wed, 19 Dec 2018 18:07:49 -0600
X-Authority-Reason: nr=8
Received: from [189.250.106.44] (port=50520 helo=[192.168.1.76])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gZlsS-0015Vm-U3; Wed, 19 Dec 2018 18:07:49 -0600
Subject: Re: [PATCH 35/41] scsi: ppa: mark expected switch fall-through
To:     linux-kernel@vger.kernel.org
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
References: <cover.1543374820.git.gustavo@embeddedor.com>
 <ac6de237bf4ee2d748eed7bbc3b2582f54650c0a.1543374820.git.gustavo@embeddedor.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <a83c27d7-28e6-faef-9730-8276aa57b499@embeddedor.com>
Date:   Wed, 19 Dec 2018 18:07:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <ac6de237bf4ee2d748eed7bbc3b2582f54650c0a.1543374820.git.gustavo@embeddedor.com>
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
X-Exim-ID: 1gZlsS-0015Vm-U3
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.76]) [189.250.106.44]:50520
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 32
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

On 11/27/18 10:33 PM, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Addresses-Coverity-ID: 114988 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>   drivers/scsi/ppa.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/scsi/ppa.c b/drivers/scsi/ppa.c
> index ee86a0c62dbf..d29999ba5458 100644
> --- a/drivers/scsi/ppa.c
> +++ b/drivers/scsi/ppa.c
> @@ -717,6 +717,7 @@ static int ppa_engine(ppa_struct *dev, struct scsi_cmnd *cmd)
>   			}
>   			cmd->SCp.phase++;
>   		}
> +		/* fall through */
>   
>   	case 2:		/* Phase 2 - We are now talking to the scsi bus */
>   		if (!ppa_select(dev, scmd_id(cmd))) {
> 
