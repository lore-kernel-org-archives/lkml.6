Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D472C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 267F2205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GhWIg8nA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 267F2205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937650AbeFSOwf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 10:52:35 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47294 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756467AbeFSOwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 10:52:32 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5JEnI3N193647;
        Tue, 19 Jun 2018 14:52:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=1MGFnErG+HkPq7BLP/pRBxrJHI6Vwpz/uoIN72JEK/k=;
 b=GhWIg8nAy0e/p+Q7oV1IuRkdYfJXj+6Ffb0HFWYdltiNqap8ht2lnIW/HGvO8KbBk9K1
 kz20L07yMPiAUYEcniM7MyZQ/Ji66yZDBbtKqz+N9rgVi0E2cC8BezkBbdwOlSJUlL+3
 /NgIA4KnfIzj2Vk9NmXywefLKtIb3jOZv/cT3s0c4m+ksjXNmqYw+4SPOM2Aa7BsKk/Z
 3mgVenHrqONmJDdqUVGdfjtdo/x3/Q++1Ru8ZEiX1wxmJtjCnvJGZq0AK4QgzFvnkZwH
 e+E6QasnVws+Df57vR5kR0w2jkZZI5sm07XfRPX/Z48cOf7OSxXMpj22WHuGVqlgl1j+ 3g== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2jmtgwrh4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jun 2018 14:52:24 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5JEqNR4003603
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jun 2018 14:52:23 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5JEqMC5006985;
        Tue, 19 Jun 2018 14:52:23 GMT
Received: from [10.191.18.5] (/10.191.18.5)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Jun 2018 07:52:22 -0700
Subject: Re: [PATCH 1/2] block: export __blk_complete_request
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1529027847-29085-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180619140942.GA13089@lst.de>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <5a952345-c245-57ee-29c7-4022e1664a46@oracle.com>
Date:   Tue, 19 Jun 2018 22:52:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180619140942.GA13089@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8928 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806190166
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph

Thanks for your kindly response.
The patch I posted ('scsi_transport_fc: use __blk_complete_request in fc_bsg_job_timeout')
is just based on code review. I don't have actual issue on it. :)

Thanks
Jianchao

On 06/19/2018 10:09 PM, Christoph Hellwig wrote:
> Does the patch below fix your FC issue?
> 
> ---
>>From 5e5b4fc51c84a0f5c27f2f770be7a4eaed0f6e8c Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Tue, 19 Jun 2018 13:59:52 +0200
> Subject: block: fix timeout changes for legacy request drivers
> 
> blk_mq_complete_request can only be called for blk-mq drivers, but when
> removing the BLK_EH_HANDLED return value, two legacy request timeout
> methods incorrectly got switched to call blk_mq_complete_request.
> Call __blk_complete_request instead to reinstance the previous behavior.
> For that __blk_complete_request needs to be exported.
> 
> Fixes: 1fc2b62e ("scsi_transport_fc: complete requests from ->timeout")
> Fixes: 0df0bb08 ("null_blk: complete requests from ->timeout")
> Reported-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-softirq.c              | 1 +
>  drivers/block/null_blk.c         | 2 +-
>  drivers/scsi/scsi_transport_fc.c | 2 +-
>  3 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-softirq.c b/block/blk-softirq.c
> index 01e2b353a2b9..15c1f5e12eb8 100644
> --- a/block/blk-softirq.c
> +++ b/block/blk-softirq.c
> @@ -144,6 +144,7 @@ void __blk_complete_request(struct request *req)
>  
>  	local_irq_restore(flags);
>  }
> +EXPORT_SYMBOL(__blk_complete_request);
>  
>  /**
>   * blk_complete_request - end I/O on a request
> diff --git a/drivers/block/null_blk.c b/drivers/block/null_blk.c
> index 7948049f6c43..042c778e5a4e 100644
> --- a/drivers/block/null_blk.c
> +++ b/drivers/block/null_blk.c
> @@ -1365,7 +1365,7 @@ static blk_qc_t null_queue_bio(struct request_queue *q, struct bio *bio)
>  static enum blk_eh_timer_return null_rq_timed_out_fn(struct request *rq)
>  {
>  	pr_info("null: rq %p timed out\n", rq);
> -	blk_mq_complete_request(rq);
> +	__blk_complete_request(rq);
>  	return BLK_EH_DONE;
>  }
>  
> diff --git a/drivers/scsi/scsi_transport_fc.c b/drivers/scsi/scsi_transport_fc.c
> index 1da3d71e9f61..13948102ca29 100644
> --- a/drivers/scsi/scsi_transport_fc.c
> +++ b/drivers/scsi/scsi_transport_fc.c
> @@ -3592,7 +3592,7 @@ fc_bsg_job_timeout(struct request *req)
>  
>  	/* the blk_end_sync_io() doesn't check the error */
>  	if (inflight)
> -		blk_mq_complete_request(req);
> +		__blk_complete_request(req);
>  	return BLK_EH_DONE;
>  }
>  
> 
