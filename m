Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id V5jAGv7WGltYRQAAmS7hNA
	; Fri, 08 Jun 2018 19:20:48 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2A684607E4; Fri,  8 Jun 2018 19:20:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 95FCE605A2;
	Fri,  8 Jun 2018 19:20:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 95FCE605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753151AbeFHTUo (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 15:20:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52176 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753096AbeFHTUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 15:20:37 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w58JJvVk091497
        for <linux-kernel@vger.kernel.org>; Fri, 8 Jun 2018 15:20:37 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jfw7mx285-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 15:20:36 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <brking@linux.vnet.ibm.com>;
        Fri, 8 Jun 2018 13:20:35 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 8 Jun 2018 13:20:31 -0600
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w58JKU1U8782186
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Jun 2018 12:20:30 -0700
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 13F9A6E050;
        Fri,  8 Jun 2018 13:20:30 -0600 (MDT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A4616E04C;
        Fri,  8 Jun 2018 13:20:29 -0600 (MDT)
Received: from oc6034535106.ibm.com (unknown [9.10.86.185])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  8 Jun 2018 13:20:29 -0600 (MDT)
Subject: Re: [PATCH] scsi: ipr: fix build on 32-bit architectures
To: Sinan Kaya <okaya@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Brian King <brking@us.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Hannes Reinecke <hare@suse.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Wen Xiong <wenxiong@linux.vnet.ibm.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>
References: <20180608144617.2900894-1-arnd@arndb.de>
 <04758f3a-0f03-4fe9-6eb8-10ebb2430a98@codeaurora.org>
 <CAK8P3a2=uMFOcw=gZGuwsH+V=1DMXGgxf_hZHw3tMJD1nDdG2Q@mail.gmail.com>
 <830c2468-293c-385c-0b91-c96bedae4d4a@codeaurora.org>
From: Brian King <brking@linux.vnet.ibm.com>
Date: Fri, 8 Jun 2018 14:20:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <830c2468-293c-385c-0b91-c96bedae4d4a@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18060819-0016-0000-0000-000008ED81CB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009153; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01044101; UDB=6.00534603; IPR=6.00823139;
 MB=3.00021536; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-08 19:20:34
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060819-0017-0000-0000-00003F2F6E02
Message-Id: <07a50fe0-0378-769a-f4eb-d39ac543dc95@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-08_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806080212
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/2018 11:10 AM, Sinan Kaya wrote:
> On 6/8/2018 11:47 AM, Arnd Bergmann wrote:
>> On Fri, Jun 8, 2018 at 5:27 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
>>> +Will,
>>>
> 
> [snip]
> 
>>> So, it is difficult to judge how this barrier has been used without an
>>> expert opinion.
>>>
>>> Changing
>>>
>>> wmb() + writel()
>>>
>>> to
>>>
>>> wmb() + writel_relaxed()
>>>
>>> is safer than dropping the wmb() altogether.
>>
>> If the wmb() was not just about the writeq() then I would argue your patch
>> description was misleading. We certainly shouldn't replace random writeq()
>> calls with writeq_relaxed() just because we can show that the driver has
>> a barrier in front of it.
>>
>> In particular, the ipr_mask_and_clear_interrupts() function has multiple
>> writeq() or writel() calls, and even a readl() and your patch only changes
>> one of them, which seems like a rather pointless exercise as the function
>> still fully synchronizes the I/O multiple times.
> 
> You are right, I only searched wmb() + writel() combinations. Changed only
> the places where I found issues. 
> 
> We were given a direction to go to eliminating barriers direction as you already
> noted. 
> 
> I just wanted to highlight the difficulty of wholesale dropping of wmb() without
> careful inspection. [1] [2]
> 
> We certainly need a better patch that covers all use cases. Your patch is
> a step in the good direction. We just need some attention from the maintainer
> that we are not actually breaking something.

To be clear here, we are talking about two code paths that are not in the performance
path, so attempting to performance optimize them to use lighter weight mmio
accessors isn't exactly critical. 

I'm fine with the replacement patch from Arnd. Thanks Arnd!

Acked-by: Brian King <brking@linux.vnet.ibm.com>

> 
>>
>>> Will Deacon should probably look at why writeq_relaxed is missing on some ARM
>>> arches too.
>>>
>>> Drivers shouldn't worry about write derivatives.
>>
>> This driver defines writeq() itself for architectures that don't have it, but
>> it doesn't define writeq_relaxed() and doesn't include
>> linux/io-64-nonatomic-lo-hi.h
>> or linux/io-64-nonatomic-hi-lo.h. It seems that it needs a different behavior
>> from all other drivers here, storing the upper 32 bits into the lower
>> address and
>> the lower 32 bits into the upper address.
> 
> I don't think there is a consensus about using these includes in the community.
> I bumped into this issue before and came up with an include you pointed.
> I didn't get too much enthusiasm from the maintainer.
> 
> Why are we pushing the responsibility into the drivers? I'd think that architecture
> should take care of this. Is there a portability issue that I'm missing from some
> architecture I never heart of? (I work on Little-Endian machines most of the time)

The attributes of the adapter hardware can have an impact here. The ipr hardware, for
example, depends on the upper 4 bytes to be written first, then the lower 4 bytes
to be written second, and its the act of writing the lower 4 bytes that triggers
the adapter hardware to read the value and take action on it.

Thanks,

Brian

-- 
Brian King
Power Linux I/O
IBM Linux Technology Center
