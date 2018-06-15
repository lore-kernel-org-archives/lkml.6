Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7455CC5CFC0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 02:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 205D9208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 02:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lDGmpwqt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 205D9208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965430AbeFOCoh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 22:44:37 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38278 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964995AbeFOCof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 22:44:35 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5F2YHEa054419;
        Fri, 15 Jun 2018 02:44:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=95tBIym0zMKvFhPQEH+U5i2luPx3TgWnd1XgHnXHvt0=;
 b=lDGmpwqtNAyifNIBPb5wqihS5ohEsn6iCDZ7CBXInZ/op6id19iBInX6lMExYKjzXVwG
 Ciym8FXJfkRbd9IA06hch10Ihmq/eWT3wgz66L/YJ3iywHDmTyhvjgNsXBe1KR3SzZqp
 QJmUS2cfgXFX8+2tjbQXglEW6dgFeLpiN/XQdExxSS53qFWIrx1BlEvODa1eJ8Xui8h/
 +tMz9deORKcYzsLvkZW4W/rzlYy3UY1Wkn32TPkm7PuK6Ue8It++ppw0DXu8Mm1T3Yb+
 gFQIu7JqbOTTRWf75XnIOxlwf0W2a8nRmnHt/GcJHe2BWpgu4jq2qzvx/yQx+JdlpSdO Dg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2jk0xrq9d1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jun 2018 02:44:28 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5F2iRMj017756
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jun 2018 02:44:27 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5F2iROl014898;
        Fri, 15 Jun 2018 02:44:27 GMT
Received: from [10.182.69.179] (/10.182.69.179)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Jun 2018 19:44:26 -0700
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
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <e5344293-b0b7-d2e0-f2e7-c0700efdfbe4@oracle.com>
Date:   Fri, 15 Jun 2018 10:44:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <3dd3f82a-5b68-f039-3a8a-7c5fe4e24c3e@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8924 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=956
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806150026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/15/2018 10:22 AM, jianchao.wang wrote:
> Hi Ming
> 
> On 06/15/2018 10:17 AM, Ming Lei wrote:
>> On Fri, Jun 15, 2018 at 9:57 AM, Jianchao Wang
>> <jianchao.w.wang@oracle.com> wrote:
>>> After f6e7d48 (block: remove BLK_EH_HANDLED), LLDD is responsible
>>> to complete the timed out request, however, for blk-legacy, the
>>> 'complete' is still marked, blk_complete_request will do nothing,
>>> we export __blk_complete_request for LLDD to complete the request
>>> in timeout path.
>>>
>>> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
>>> ---
>>>  block/blk-softirq.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/block/blk-softirq.c b/block/blk-softirq.c
>>> index 01e2b35..15c1f5e 100644
>>> --- a/block/blk-softirq.c
>>> +++ b/block/blk-softirq.c
>>> @@ -144,6 +144,7 @@ void __blk_complete_request(struct request *req)
>>>
>>>         local_irq_restore(flags);
>>>  }
>>> +EXPORT_SYMBOL(__blk_complete_request);
>>>
>>>  /**
>>>   * blk_complete_request - end I/O on a request
>>> --
>>> 2.7.4
>>>
>>
>> Looks non-blk-mq timeout code need to convert to ref-counter
>> based approach too?
> 
> IMO, ref-counter is just to fix the blk-mq req life recycle issue.
> It cannot replace the blk_mark_rq_complete which could avoid the race between
> timeout and io completion path.

The .timeout return BLK_EH_DONE doesn't always mean the request has been completed.
Such as scsi-mid layer, its .timeout callback return BLK_EH_DONE but the timed out
request is still in abort or eh process. What if a completion irq come during that ? 

> Or maybe my understanding is wrong ...
> 
> Thanks
> Jianchao
>>
> 
