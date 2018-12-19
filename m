Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444CEC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B6D720873
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729547AbeLSW0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 17:26:44 -0500
Received: from gateway24.websitewelcome.com ([192.185.51.209]:39558 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728221AbeLSW0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 17:26:44 -0500
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 9BB208B596
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 16:26:43 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id ZkIdgs8NqiQerZkIdgxb8x; Wed, 19 Dec 2018 16:26:43 -0600
X-Authority-Reason: nr=8
Received: from [189.250.106.44] (port=47194 helo=[192.168.1.76])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gZkIc-000DBN-Qs; Wed, 19 Dec 2018 16:26:42 -0600
Subject: Re: [PATCH 18/41] scsi: isci: remote_device: Mark expected switch
 fall-throughs
To:     Intel SCU Linux support <intel-linux-scu@intel.com>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1543374820.git.gustavo@embeddedor.com>
 <de14fd0d7246aa4ac19dcc48491641890c2c289d.1543374820.git.gustavo@embeddedor.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <b0878c46-fc1d-07a7-b9b5-641a69cf9163@embeddedor.com>
Date:   Wed, 19 Dec 2018 16:26:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <de14fd0d7246aa4ac19dcc48491641890c2c289d.1543374820.git.gustavo@embeddedor.com>
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
X-Exim-ID: 1gZkIc-000DBN-Qs
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.76]) [189.250.106.44]:47194
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 16
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

On 11/27/18 10:30 PM, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Notice that, in this particular case, a dash is added as a token in
> order to separate the "fall through" annotations from the rest of
> the comment on the same line, which is what GCC is expecting to find.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>   drivers/scsi/isci/remote_device.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/isci/remote_device.c b/drivers/scsi/isci/remote_device.c
> index cc51f38b116d..9d29edb9f590 100644
> --- a/drivers/scsi/isci/remote_device.c
> +++ b/drivers/scsi/isci/remote_device.c
> @@ -310,7 +310,7 @@ static void isci_remote_device_not_ready(struct isci_host *ihost,
>   		/* Kill all outstanding requests for the device. */
>   		sci_remote_device_terminate_requests(idev);
>   
> -		/* Fall through into the default case... */
> +		/* Fall through - into the default case... */
>   	default:
>   		clear_bit(IDEV_IO_READY, &idev->flags);
>   		break;
> @@ -593,7 +593,7 @@ enum sci_status sci_remote_device_event_handler(struct isci_remote_device *idev,
>   
>   			break;
>   		}
> -	/* Else, fall through and treat as unhandled... */
> +		/* fall through - and treat as unhandled... */
>   	default:
>   		dev_dbg(scirdev_to_dev(idev),
>   			"%s: device: %p event code: %x: %s\n",
> 
