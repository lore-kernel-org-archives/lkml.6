Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9E1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54C1E205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729818AbfB0J6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 04:58:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47778 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728036AbfB0J6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 04:58:30 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1R9nM92004621
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 04:58:29 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qwqe6txmh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 04:58:28 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Wed, 27 Feb 2019 09:58:26 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 27 Feb 2019 09:58:24 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1R9wN1959965456
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Feb 2019 09:58:23 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA48DA4053;
        Wed, 27 Feb 2019 09:58:22 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36566A4040;
        Wed, 27 Feb 2019 09:58:22 +0000 (GMT)
Received: from [9.152.224.140] (unknown [9.152.224.140])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 27 Feb 2019 09:58:22 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v4 6/7] s390: ap: Cleanup on removing the AP device
To:     Tony Krowiak <akrowiak@linux.ibm.com>, borntraeger@de.ibm.com
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com,
        david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
References: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
 <1550849400-27152-7-git-send-email-pmorel@linux.ibm.com>
 <3f15bd09-8a90-ed8a-e15a-0f3bac1a3528@linux.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Wed, 27 Feb 2019 10:58:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <3f15bd09-8a90-ed8a-e15a-0f3bac1a3528@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19022709-0008-0000-0000-000002C57F08
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022709-0009-0000-0000-00002231CB9A
Message-Id: <97bd632b-87a6-fa23-d4db-7ccdec877831@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-27_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902270066
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/02/2019 19:27, Tony Krowiak wrote:
> On 2/22/19 10:29 AM, Pierre Morel wrote:
>> When the device is remove, we must make sure to
>> clear the interruption and reset the AP device.
>>
>> We also need to clear the CRYCB of the guest.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_drv.c     | 35 
>> +++++++++++++++++++++++++++++++++++
>>   drivers/s390/crypto/vfio_ap_ops.c     |  3 ++-
>>   drivers/s390/crypto/vfio_ap_private.h |  3 +++
>>   3 files changed, 40 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_drv.c 
>> b/drivers/s390/crypto/vfio_ap_drv.c
>> index eca0ffc..e5d91ff 100644
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
>> @@ -61,6 +64,33 @@ static int vfio_ap_queue_dev_probe(struct ap_device 
>> *apdev)
>>   }
>>   /**
>> + * vfio_ap_update_crycb
>> + * @q: A pointer to the queue being removed
>> + *
>> + * We clear the APID of the queue, making this queue unusable for the 
>> guest.
>> + * After this function we can reset the queue without to fear a race 
>> with
>> + * the guest to access the queue again.
>> + * We do not fear race with the host as we still get the device.
>> + */
>> +static void vfio_ap_update_crycb(struct vfio_ap_queue *q)
>> +{
>> +    struct ap_matrix_mdev *matrix_mdev = q->matrix_mdev;
>> +
>> +    if (!matrix_mdev)
>> +        return;
>> +
>> +    clear_bit_inv(AP_QID_CARD(q->apqn), matrix_mdev->matrix.apm);
>> +
>> +    if (!matrix_mdev->kvm)
>> +        return;
>> +
>> +    kvm_arch_crypto_set_masks(matrix_mdev->kvm,
>> +                  matrix_mdev->matrix.apm,
>> +                  matrix_mdev->matrix.aqm,
>> +                  matrix_mdev->matrix.adm);
>> +}
>> +
>> +/**
>>    * vfio_ap_queue_dev_remove:
>>    *
>>    * Free the associated vfio_ap_queue structure
>> @@ -70,6 +100,11 @@ static void vfio_ap_queue_dev_remove(struct 
>> ap_device *apdev)
>>       struct vfio_ap_queue *q;
>>       q = dev_get_drvdata(&apdev->device);
>> +    if (!q)
>> +        return;
>> +
>> +    vfio_ap_update_crycb(q);
>> +    vfio_ap_mdev_reset_queue(q);
> 
> The reset is unnecessary because once the card is removed from the
> CRYCB, the ZAPQ may fail with because the queue may not exist anymore.

The code here is run inside the host. So the queue is still available 
for ZAPQ.


> Besides, once the card is removed from the guest's CRYCB, the bus
> running in the guest will do a reset.

I already answered this:
- The AP bus reset the queue before calling the driver probe
- which means that the guest can still access the queue after the reset 
done by the bus.
- we need to first clear the CRYCB to remove the queue from the guest 
before we reset the queue.


Regards,
Pierre


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

