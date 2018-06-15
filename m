Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4E359C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 03:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 025DF208BA
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 03:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O+DSY72E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 025DF208BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965533AbeFOD0C (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 23:26:02 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37022 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965123AbeFOD0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 23:26:01 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5F3OwIb043276;
        Fri, 15 Jun 2018 03:25:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=J9wH4f886tWWO+5rMu8jwyDQrJv/nz0kPzmVKbMwUSU=;
 b=O+DSY72EeztUzj9cDrxcNwQ/0am5O1+eJvnczMAHRKMY15phnUW8mAxyvZwMRw6otEaY
 jdbFT5byKr9TASQw3F7oikQwO+xi2BWuKwtttfTCp11hbju35D/UtHcPfh8oltn96njM
 u0DnDC1Kb+0MDCJHIloaGRYzISSMDOrs38kb29lnDNW8BIfWpaa2QQ7VXbTaIH67lr2e
 Tb4hv6dz9aqTw3SN87loO0CqjE0SwVWjxF8hjhWguMVaiHHMwovbunjeRyFyA7Im0+7S
 sCNWTTD6J4qR05xfWDDcHZRkx/IPwkekWpdtj86x4JL0lHN3e1zibCjx2GAbWWN8DzoT 7w== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2jk0xrfca4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jun 2018 03:25:54 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5F3PrrG007531
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jun 2018 03:25:53 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5F3PqPR028769;
        Fri, 15 Jun 2018 03:25:52 GMT
Received: from [10.182.69.179] (/10.182.69.179)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Jun 2018 20:25:52 -0700
Subject: Re: [PATCH 1/2] block: export __blk_complete_request
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-block <linux-block@vger.kernel.org>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1529027847-29085-1-git-send-email-jianchao.w.wang@oracle.com>
 <CACVXFVMe4zSvfXfuSn0NFayeQqbmDwBBy1kcso=5iznT6EfpSA@mail.gmail.com>
 <3dd3f82a-5b68-f039-3a8a-7c5fe4e24c3e@oracle.com>
 <e5344293-b0b7-d2e0-f2e7-c0700efdfbe4@oracle.com>
 <CACVXFVMRCM6AvNJjAESbwOeJ_P5AZ+1C-7RfhE9L4u0T=_5h4Q@mail.gmail.com>
 <3970fdc7-52d9-d05b-4118-059d48bf4f2d@oracle.com>
 <CACVXFVMPAdFbX3x-KUjHCQhb_rT6p9ROYHg63aUtEqdbitEaKQ@mail.gmail.com>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <7a77829a-ba5f-8975-edb0-ffdf25dc71d6@oracle.com>
Date:   Fri, 15 Jun 2018 11:26:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CACVXFVMPAdFbX3x-KUjHCQhb_rT6p9ROYHg63aUtEqdbitEaKQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8924 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806150034
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming

On 06/15/2018 11:20 AM, Ming Lei wrote:
> On Fri, Jun 15, 2018 at 11:04 AM, jianchao.wang
> <jianchao.w.wang@oracle.com> wrote:
>> Hi Ming
>>
>> Thanks for your kindly response.
>>
>> On 06/15/2018 10:56 AM, Ming Lei wrote:
>>>>> IMO, ref-counter is just to fix the blk-mq req life recycle issue.
>>>>> It cannot replace the blk_mark_rq_complete which could avoid the race between
>>>>> timeout and io completion path.
>>>> The .timeout return BLK_EH_DONE doesn't always mean the request has been completed.
>>>> Such as scsi-mid layer, its .timeout callback return BLK_EH_DONE but the timed out
>>>> request is still in abort or eh process. What if a completion irq come during that ?
>>> For blk-mq, it is avoided by the atomic state change in
>>> __blk_mq_complete_request(),
>>> that is why I mentioned the question in my last reply.
>>>
>>
>> but blk_mq_check_expired doesn't do that.
>> do I miss anything ?
> 
> Right, that is the difference between blk-mq and legacy now, 

Sorry, I cannot follow your point.
blk_mq_check_expired doesn't do a atmoc state change from IN-FLIGHT to COMPLETE.
__blk_mq_complete_request could still proceed to complete a timed out request
which is in scsi abort or eh process. Is it really OK ?


Thanks
Jianchao


> then if scsi-mq
> drivers can work well, they should work well with the following change in the
> non-mq mode:
> 
> diff --git a/block/blk-timeout.c b/block/blk-timeout.c
> index 4b8a48d48ba1..9fce09d55652 100644
> --- a/block/blk-timeout.c
> +++ b/block/blk-timeout.c
> @@ -88,7 +88,6 @@ static void blk_rq_timed_out(struct request *req)
>         switch (ret) {
>         case BLK_EH_RESET_TIMER:
>                 blk_add_timer(req);
> -               blk_clear_rq_complete(req);
>                 break;
>         case BLK_EH_DONE:
>                 /*
> @@ -115,8 +114,7 @@ static void blk_rq_check_expired(struct request
> *rq, unsigned long *next_timeout
>                 /*
>                  * Check if we raced with end io completion
>                  */
> -               if (!blk_mark_rq_complete(rq))
> -                       blk_rq_timed_out(rq);
> +               blk_rq_timed_out(rq);
>         } else if (!*next_set || time_after(*next_timeout, deadline)) {
>                 *next_timeout = deadline;
>                 *next_set = 1;
> 
> 
> Thanks,
> Ming Lei
> 
