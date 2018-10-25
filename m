Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C504C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 06:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3DF220831
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 06:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cYgzEVH7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3DF220831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbeJYOhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 10:37:21 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38548 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbeJYOhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 10:37:20 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9P64TSc148765;
        Thu, 25 Oct 2018 06:06:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=G9oPES3TRBkHU4NzyyqHyLy2yrWIye6Z0K85R3T3dso=;
 b=cYgzEVH7eD7LQAbCoT8iSGxyu2G5gMX+1Xdcm19ZCz8OV/X171eA72Hi2sUkGyrQv2yd
 hSlgtfOVX5/z5nvL9i4n9dcETDT3I64E3BniutPyIAHhMjzKeaUn67s1jAf/cKqymBPb
 JuUa04RurehKB9urWIiV+WwqORKuIRmLkCwIGKAIPx20cRIN1HVScMWRPW15ps1L9y8l
 GIzcxEwNRR1wAl0CL9+Se3kMeOxVMnVlMs8yHLWAIO5+8JrHFNBgpC/B2YEbUuwSNoRJ
 kBKgsDq03yBim5Var4txU079d4kHcmDP9c3cWcYedgtqjcmrYxy2ocKEqX6e1PRFCNMm aA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2n7vaq7dny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Oct 2018 06:06:03 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9P663o6030363
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Oct 2018 06:06:03 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9P663I5015203;
        Thu, 25 Oct 2018 06:06:03 GMT
Received: from mwanda (/129.205.6.86)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 24 Oct 2018 23:06:02 -0700
Date:   Thu, 25 Oct 2018 09:05:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Aleksa Zdravkovic <alex.zdravkovic98@gmail.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: axis-fifo: Fix line over 80 characters error
Message-ID: <20181025060533.mfmdozimla7wq2sg@mwanda>
References: <20181024150550.GA5150@zdravcePC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181024150550.GA5150@zdravcePC>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9056 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810250056
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 05:05:53PM +0200, Aleksa Zdravkovic wrote:
> This patch fixes the checkpatch.pl warning:
> 
> WARNING: line over 80 characters
> +			 (write_timeout >= 0) ? msecs_to_jiffies(write_timeout) :
> 
> Signed-off-by: Aleksa Zdravkovic <alex.zdravkovic98@gmail.com>
> ---
>  drivers/staging/axis-fifo/axis-fifo.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
> index c18bf31f55b6..2f609712f507 100644
> --- a/drivers/staging/axis-fifo/axis-fifo.c
> +++ b/drivers/staging/axis-fifo/axis-fifo.c
> @@ -482,10 +482,10 @@ static ssize_t axis_fifo_write(struct file *f, const char __user *buf,
>  		spin_lock_irq(&fifo->write_queue_lock);
>  		ret = wait_event_interruptible_lock_irq_timeout
>  			(fifo->write_queue,
> -			 ioread32(fifo->base_addr + XLLF_TDFV_OFFSET)
> +			ioread32(fifo->base_addr + XLLF_TDFV_OFFSET)
>  				>= words_to_write,
> -			 fifo->write_queue_lock,
> -			 (write_timeout >= 0) ? msecs_to_jiffies(write_timeout) :
> +			fifo->write_queue_lock,
> +			(write_timeout >= 0) ? msecs_to_jiffies(write_timeout) :
>  				MAX_SCHEDULE_TIMEOUT);

The original was fine.  Just leave it.

Checkpatch.pl is only useful if it improves the readability for humans.

regards,
dan carpenter

