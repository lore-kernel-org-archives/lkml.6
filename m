Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 788DFC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 05:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B6E2208B5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 05:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kL5b+Vtd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B6E2208B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755868AbeFOFKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 01:10:01 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48530 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754165AbeFOFJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 01:09:57 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5F59Gr2101777;
        Fri, 15 Jun 2018 05:09:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=TZKokBkol+B0awicJ3SWKYxWBNZORSwca+/0I4ASPmE=;
 b=kL5b+VtdLlVsW5LZYpwXOprpi9ukFK2Y+95GC85KYGfZLE4Fu4smTFTFuf1t8+Rfy9oo
 ir/uW74QGg8rwLYsI0uYj9PaVFQ88rTO1w0pVL67JjMYw3Kwa8/+2ZbCzjsqFP305sqL
 jQRGrTBWx0wnVElVP9LfQgFhW9focQTzfaHJMVYBvFl1je4HdBf6a7VmligH7vEOnskM
 jRceZhuJRegPqv0VUOnH/jTSTLz4Udf9sXcZ3S2rLuxlv80DvBwuCV+dqT3iwGCSA1tO
 tTwU9LCFneN6DQ1huSdesQfE8lNC0BS/UMcRFJhrI8UhVuxWEexevtWu9hdxxhJIrPFw zw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2jk0xrfgqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jun 2018 05:09:51 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5F59odk007017
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jun 2018 05:09:50 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5F59naa031918;
        Fri, 15 Jun 2018 05:09:49 GMT
Received: from [10.182.69.179] (/10.182.69.179)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Jun 2018 22:09:49 -0700
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
 <7a77829a-ba5f-8975-edb0-ffdf25dc71d6@oracle.com>
 <CACVXFVO+GsQHCgoc6GuP1osnWprfeGrsikBgxj49+KiJoOsvBA@mail.gmail.com>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <adf25c83-550a-3095-5d8a-c241329a2e3b@oracle.com>
Date:   Fri, 15 Jun 2018 13:10:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CACVXFVO+GsQHCgoc6GuP1osnWprfeGrsikBgxj49+KiJoOsvBA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8924 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=677
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806150054
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming

Thanks for your kindly response

On 06/15/2018 12:03 PM, Ming Lei wrote:
> On Fri, Jun 15, 2018 at 11:26 AM, jianchao.wang
> <jianchao.w.wang@oracle.com> wrote:
>> Hi Ming
>>
>> On 06/15/2018 11:20 AM, Ming Lei wrote:
>>> On Fri, Jun 15, 2018 at 11:04 AM, jianchao.wang
>>> <jianchao.w.wang@oracle.com> wrote:
>>>> Hi Ming
>>>>
>>>> Thanks for your kindly response.
>>>>
>>>> On 06/15/2018 10:56 AM, Ming Lei wrote:
>>>>>>> IMO, ref-counter is just to fix the blk-mq req life recycle issue.
>>>>>>> It cannot replace the blk_mark_rq_complete which could avoid the race between
>>>>>>> timeout and io completion path.
>>>>>> The .timeout return BLK_EH_DONE doesn't always mean the request has been completed.
>>>>>> Such as scsi-mid layer, its .timeout callback return BLK_EH_DONE but the timed out
>>>>>> request is still in abort or eh process. What if a completion irq come during that ?
>>>>> For blk-mq, it is avoided by the atomic state change in
>>>>> __blk_mq_complete_request(),
>>>>> that is why I mentioned the question in my last reply.
>>>>>
>>>>
>>>> but blk_mq_check_expired doesn't do that.
>>>> do I miss anything ?
>>>
>>> Right, that is the difference between blk-mq and legacy now,
>>
>> Sorry, I cannot follow your point.
>> blk_mq_check_expired doesn't do a atmoc state change from IN-FLIGHT to COMPLETE.
>> __blk_mq_complete_request could still proceed to complete a timed out request
>> which is in scsi abort or eh process. Is it really OK ?
> > That is the idea of Christoph's patchset of 'complete requests from ->timeout',

Yes, I used to read that mail thread.

> then drivers need to cover race between timeout and normal completeion.
> 
> But at least the request won't be completed twice because of the atomic
> state change in __blk_mq_complete_request().

Yes

> 
> So what is your real concern about blk-mq's timeout?
I concern whether the current drivers have bee ready for taking this task currently.
At least, for scsi, if I try to trigger timeout and completion path concurrently, system would crash.
4.17.rc7 or 4.18 with a patch that change state in blk_mq_check_expired will survive.

Thanks
jianchao 

> 
> Thanks,
> Ming
> 
