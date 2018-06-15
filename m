Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 242AFC5CFC0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 02:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C591B208B5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 02:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gQlzmPWI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C591B208B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965426AbeFOCWq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 22:22:46 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59310 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964995AbeFOCWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 22:22:42 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5F2Jmsd179867;
        Fri, 15 Jun 2018 02:22:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=E1qrakeRUYConereeztnkrjyfCaQn9rGGMvTjKS16kg=;
 b=gQlzmPWI7Rzv0GXA5evDGBbHk1lrUBxBni8dXrFchAKAQq8xVNAegzfv/QW2O5SpT39X
 6nAFKyMKmyU4uQbYsBWjecJThz6x8bzOoybpleHXlddPDZ/AB5762wrJ5oBolf1hZPjU
 ukKFKggoDM05gSGlrCdr2u1GiTYtP4iqy0YINCcgXqv2hQlZq9e/ETDctzPGwDgGiSL2
 kBeP2kGniDum9rwIi6VJZmR5LtjhY21l6/Ksd9+ILdWUSwn8us4CcaIZIURWOzrcyI2/
 BtHYeeGAS9JVoqnMyEtDbMw+5+2iqJYk/IYJAZW+BRxM1uuNaBwRQbtit7/18Su2Ry8v mQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2jk0xrf9b2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jun 2018 02:22:37 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5F2MaUW015257
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jun 2018 02:22:36 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5F2MZqj021761;
        Fri, 15 Jun 2018 02:22:35 GMT
Received: from [10.182.69.179] (/10.182.69.179)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Jun 2018 19:22:35 -0700
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
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <3dd3f82a-5b68-f039-3a8a-7c5fe4e24c3e@oracle.com>
Date:   Fri, 15 Jun 2018 10:22:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CACVXFVMe4zSvfXfuSn0NFayeQqbmDwBBy1kcso=5iznT6EfpSA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8924 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806150023
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming

On 06/15/2018 10:17 AM, Ming Lei wrote:
> On Fri, Jun 15, 2018 at 9:57 AM, Jianchao Wang
> <jianchao.w.wang@oracle.com> wrote:
>> After f6e7d48 (block: remove BLK_EH_HANDLED), LLDD is responsible
>> to complete the timed out request, however, for blk-legacy, the
>> 'complete' is still marked, blk_complete_request will do nothing,
>> we export __blk_complete_request for LLDD to complete the request
>> in timeout path.
>>
>> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
>> ---
>>  block/blk-softirq.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/block/blk-softirq.c b/block/blk-softirq.c
>> index 01e2b35..15c1f5e 100644
>> --- a/block/blk-softirq.c
>> +++ b/block/blk-softirq.c
>> @@ -144,6 +144,7 @@ void __blk_complete_request(struct request *req)
>>
>>         local_irq_restore(flags);
>>  }
>> +EXPORT_SYMBOL(__blk_complete_request);
>>
>>  /**
>>   * blk_complete_request - end I/O on a request
>> --
>> 2.7.4
>>
> 
> Looks non-blk-mq timeout code need to convert to ref-counter
> based approach too?

IMO, ref-counter is just to fix the blk-mq req life recycle issue.
It cannot replace the blk_mark_rq_complete which could avoid the race between
timeout and io completion path.
Or maybe my understanding is wrong ...

Thanks
Jianchao
> 
