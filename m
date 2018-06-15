Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5B70DC5CFC0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 03:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05C9620891
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 03:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="njQQORiA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05C9620891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936155AbeFODEI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 23:04:08 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:53270 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936083AbeFODEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 23:04:06 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5F33mOs139440;
        Fri, 15 Jun 2018 03:03:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=MOV+1T8hoI0m7JvgQKj/ZsFm1/PmeNDMJRHjvQ1Fiqk=;
 b=njQQORiAY8Jm8pmCtrdBga86boQfOYdIYxZmpNiTyXUBd3QFiifOjI4PydueRj1zld4L
 4APqYDkNeg3UgKjf2YWkPL1Jr8d41+WmiDkj1wArn39VVtP4QZvOWfhu34M7wzXx+zfB
 +ZLIFgdKW839/0Dk5SvQcbY+S8ALZQPzwF7GasDQ2G96g6g9m0toUmU7RKSRx6ymyldZ
 WZkK+kzadddpkNrwqEuHmxL1B18XrRYZAkqilRk36ODPUpbaG3lvdG8Mqkyz8xc9bMdO
 6aztsoV0jAkjJNuNwNucAyAcz+PDkNfwffuVMbpvmUR3ZkesGARej444g3YpoNwrfxGh wQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2jk0xqyatb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jun 2018 03:03:54 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5F33rPu007590
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jun 2018 03:03:53 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5F33qHb019221;
        Fri, 15 Jun 2018 03:03:52 GMT
Received: from [10.182.69.179] (/10.182.69.179)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Jun 2018 20:03:52 -0700
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
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <3970fdc7-52d9-d05b-4118-059d48bf4f2d@oracle.com>
Date:   Fri, 15 Jun 2018 11:04:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CACVXFVMRCM6AvNJjAESbwOeJ_P5AZ+1C-7RfhE9L4u0T=_5h4Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8924 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=772
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806150030
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming

Thanks for your kindly response.

On 06/15/2018 10:56 AM, Ming Lei wrote:
>>> IMO, ref-counter is just to fix the blk-mq req life recycle issue.
>>> It cannot replace the blk_mark_rq_complete which could avoid the race between
>>> timeout and io completion path.
>> The .timeout return BLK_EH_DONE doesn't always mean the request has been completed.
>> Such as scsi-mid layer, its .timeout callback return BLK_EH_DONE but the timed out
>> request is still in abort or eh process. What if a completion irq come during that ?
> For blk-mq, it is avoided by the atomic state change in
> __blk_mq_complete_request(),
> that is why I mentioned the question in my last reply.
> 

but blk_mq_check_expired doesn't do that.
do I miss anything ?

> But what if the timed-out request has been freed by EH? Then seems
> req's ref_counter

Thanks
Jianchao
