Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481FBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 19:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A6092147C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 19:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbfBSTaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 14:30:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53814 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726289AbfBSTaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 14:30:07 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1JJPHoU106881
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 14:30:07 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qrmsx2dnr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 14:30:06 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Tue, 19 Feb 2019 19:30:03 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 19 Feb 2019 19:29:59 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1JJTvvK26214422
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Feb 2019 19:29:57 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 92219AE045;
        Tue, 19 Feb 2019 19:29:57 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E12D2AE051;
        Tue, 19 Feb 2019 19:29:56 +0000 (GMT)
Received: from [9.145.25.7] (unknown [9.145.25.7])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 19 Feb 2019 19:29:56 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v3 8/9] s390: ap: Cleanup on removing the AP device
To:     Tony Krowiak <akrowiak@linux.ibm.com>, borntraeger@de.ibm.com
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com,
        david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
 <1550152269-6317-9-git-send-email-pmorel@linux.ibm.com>
 <f60b520b-7342-da0d-48cb-5a16190b7f40@linux.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Tue, 19 Feb 2019 20:29:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <f60b520b-7342-da0d-48cb-5a16190b7f40@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19021919-0016-0000-0000-000002586567
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021919-0017-0000-0000-000032B2AB26
Message-Id: <2b6a07ac-b999-b7d0-81de-273abfcb7c00@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-19_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902190137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/02/2019 00:29, Tony Krowiak wrote:
> On 2/14/19 8:51 AM, Pierre Morel wrote:
>> When the device is remove, we must make sure to
>> clear the interruption and reset the AP device.
>>
>> We also need to clear the CRYCB of the guest.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_drv.c     | 92 
>> +++++++++++++++++++++++++++++++++++
>>   drivers/s390/crypto/vfio_ap_ops.c     |  2 +-
>>   drivers/s390/crypto/vfio_ap_private.h |  2 +
>>   3 files changed, 95 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_drv.c 
>> b/drivers/s390/crypto/vfio_ap_drv.c
>> index 03153e6..50428be 100644
>> --- a/drivers/s390/crypto/vfio_ap_drv.c
>> +++ b/drivers/s390/crypto/vfio_ap_drv.c
>> @@ -5,6 +5,7 @@
>>    * Copyright IBM Corp. 2018
>>    *
>>    * Author(s): Tony Krowiak <akrowiak@linux.ibm.com>
>> + *          Pierre Morel <pmorel@linux.ibm.com>
>>    */
>>   #include <linux/module.h>
>> @@ -12,6 +13,8 @@
>>   #include <linux/slab.h>
>>   #include <linux/string.h>
>>   #include <asm/facility.h>
>> +#include <linux/bitops.h>
>> +#include <linux/kvm_host.h>
>>   #include "vfio_ap_private.h"
>>   #define VFIO_AP_ROOT_NAME "vfio_ap"
>> @@ -64,6 +67,88 @@ static int vfio_ap_queue_dev_probe(struct ap_device 
>> *apdev)
>>       return 0;
>>   }
>> +/*
>> + * vfio_ap_drain_queue
>> + * @q: the queue to drain
>> + *
>> + * This function waits until the queue is empty.
>> + */
>> +static void vfio_ap_drain_queue(struct vfio_ap_queue *q)
>> +{
>> +    struct ap_queue_status status;
>> +    int retry = 20;
>> +
>> +    status = ap_tapq(q->apqn, NULL);
>> +    while (!status.queue_empty && retry--)  {
>> +        msleep(200);
>> +        status = ap_tapq(q->apqn, NULL);
>> +    }
>> +    if (retry <= 0) {
>> +        pr_warn("%s: queue not empty after zapq on apqn 0x%04x\n",
>> +            __func__, q->apqn);
>> +    }
>> +}
>> +
>> +/*
>> + * vfio_ap_zapq
>> + * @q: The queue to zerro
>> + *
>> + * It is best effort, no return value is done, however on success
>> + * we will drain the queue before getting the queue back to the
>> + * AP bus.
>> + */
>> +static void vfio_ap_zapq(struct vfio_ap_queue *q)
>> +{
>> +    struct ap_queue_status status;
>> +    int retry = 20;
>> +
>> +    do {
>> +        status = ap_zapq(q->apqn);
>> +        switch (status.response_code) {
>> +        case AP_RESPONSE_RESET_IN_PROGRESS:
>> +        case AP_RESPONSE_BUSY:
>> +            msleep(20);
>> +            break;
>> +        default:
>> +            pr_warn("%s: zapq error %02x on apqn 0x%04x\n",
>> +                __func__, status.response_code, q->apqn);
>> +            return;
>> +        case AP_RESPONSE_NORMAL:
>> +            vfio_ap_drain_queue(q);
> 
> I don't think this is necessary. The zeroize is performed on
> each AP-queue entry in an AP queue. My understanding is that when a
> reset or zeroize is pending, any AP instructions subsequently issued
> are rejected with condition-code 3 indicating an AP queue reset is in
> progress. It is also my understanding that once the AP commands 
> currently executing in a given AP queue entry complete, the queue
> entry will be zeroized. So it seems to me that there is no need to
> "drain" the queue, it will have already been done by the zeroize.

My understanding from the specifications is that after a RAPQ or a ZAPQ
we should wait for the queue to be really empty.

> 
> If you agree we don't need to "drain" the queue, then I'd rather just
> make the zapq function in the vfio_ap_ops.c non-static and make it
> available to the driver. There is no sense in duplicating this code. In
> fact, even if you keep the draining function, you still don't need to
> duplicate a zaapq instruction here, you can just call the vfio_ap_ops.c
> version and then drain the queue on AP_RESPONSE_NORMAL.

OK I will see how to optimize this.



>> +        return;
>> +
>> +    vfio_ap_update_crycb(q);
>> +    vfio_ap_zapq(q);
>> +
>> +    vfio_ap_free_irq(q);
> 
> If you make the zapq function in vfio_ap_ops.c available to the driver
> rather than duplicating it in this file, you won't need this call
> to vfio_ap_free_irq because it is done as part of the zapq in
> vfio_ap_ops.c.

Another solution.
OK I will look at this.

Thanks,
Pierre


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

