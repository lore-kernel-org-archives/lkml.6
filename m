Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0188EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 08:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C89218FE
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 08:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbfB0IkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 03:40:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44878 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726791AbfB0IkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 03:40:22 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1R8dZRV100119
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 03:40:21 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qwpaxau6u-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 03:40:18 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Wed, 27 Feb 2019 08:40:17 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 27 Feb 2019 08:40:15 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1R8eDN956623218
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Feb 2019 08:40:13 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 93A5CA4057;
        Wed, 27 Feb 2019 08:40:13 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 08A1FA4040;
        Wed, 27 Feb 2019 08:40:13 +0000 (GMT)
Received: from [9.152.224.140] (unknown [9.152.224.140])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 27 Feb 2019 08:40:12 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v4 2/7] s390: ap: new vfio_ap_queue structure
To:     Tony Krowiak <akrowiak@linux.ibm.com>, borntraeger@de.ibm.com
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com,
        david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
References: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
 <1550849400-27152-3-git-send-email-pmorel@linux.ibm.com>
 <944bb7fe-2b2c-28d0-f63b-6fa84c324735@linux.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Wed, 27 Feb 2019 09:40:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <944bb7fe-2b2c-28d0-f63b-6fa84c324735@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19022708-0020-0000-0000-0000031BCA87
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022708-0021-0000-0000-0000216D3502
Message-Id: <581b859f-3959-aed2-90af-a31cb6b75d49@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-27_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902270059
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/02/2019 17:10, Tony Krowiak wrote:
> On 2/22/19 10:29 AM, Pierre Morel wrote:
>> The AP interruptions are assigned on a queue basis and
>> the GISA structure is handled on a VM basis, so that
>> we need to add a structure we can retrieve from both side
>> holding the information we need to handle PQAP/AQIC interception
>> and setup the GISA.
>>
>> Since we can not add more information to the ap_device
>> we add a new structure vfio_ap_queue, to hold per queue
>> information useful to handle interruptions and set it as
>> driver's data of the standard ap_queue device.
>>
>> Usually, the device and the mediated device are linked together
>> but in the vfio_ap driver design we have a bunch of "sub" devices
>> (the ap_queue devices) belonging to the mediated device.
>>
>> Linking these structure to the mediated device it is assigned to,
>> with the help of the vfio_ap_queue structure will help us to
>> retrieve the AP devices associated with the mediated devices
>> during the mediated device operations.
>>
>> ------------    -------------
>> | AP queue |--> | AP_vfio_q |<----
>> ------------    ------^------    |    ---------------
>>                        |          <--->| matrix_mdev |
>> ------------    ------v------    |    ---------------
>> | AP queue |--> | AP_vfio_q |-----
>> ------------    -------------
>>
>> The vfio_ap_queue device will hold the following entries:
>> - apqn: AP queue number (defined here)
>> - isc : Interrupt subclass (defined later)
>> - nib : notification information byte (defined later)
>> - list: a list_head entry allowing to link this structure to a
>>     matrix mediated device it is assigned to.
>>
>> The vfio_ap_queue structure is allocated when the vfio_ap_driver
>> is probed and added as driver data to the ap_queue device.
>> It is free on remove.
>>
>> The structure is linked to the matrix_dev host device at the
>> probe of the device building some kind of free list for the
>> matrix mediated devices.
>>
>> When the vfio_queue is associated to a matrix mediated device,
>> the vfio_ap_queue device is linked to this matrix mediated device
>> and unlinked when dissociated.
>>
>> This patch and the 3 next can be squashed together on the
>> final release of this series.
>> until then I separate them to ease the review.
>>
>> So please do not complain about unused functions or about
>> squashing the patches together, this will be resolved during
>> the last iteration.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_drv.c     | 27 ++++++++++++++++++++++++++-
>>   drivers/s390/crypto/vfio_ap_private.h |  9 +++++++++
>>   2 files changed, 35 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_drv.c 
>> b/drivers/s390/crypto/vfio_ap_drv.c
>> index e9824c3..eca0ffc 100644
>> --- a/drivers/s390/crypto/vfio_ap_drv.c
>> +++ b/drivers/s390/crypto/vfio_ap_drv.c
>> @@ -40,14 +40,38 @@ static struct ap_device_id ap_queue_ids[] = {
>>   MODULE_DEVICE_TABLE(vfio_ap, ap_queue_ids);
>> +/**
>> + * vfio_ap_queue_dev_probe:
>> + *
>> + * Allocate a vfio_ap_queue structure and associate it
>> + * with the device as driver_data.
>> + */
>>   static int vfio_ap_queue_dev_probe(struct ap_device *apdev)
>>   {
>> +    struct vfio_ap_queue *q;
>> +
>> +    q = kzalloc(sizeof(*q), GFP_KERNEL);
>> +    if (!q)
>> +        return -ENOMEM;
>> +    dev_set_drvdata(&apdev->device, q);
>> +    q->apqn = to_ap_queue(&apdev->device)->qid;
>> +    INIT_LIST_HEAD(&q->list);
>> +    list_add(&q->list, &matrix_dev->free_list);
>>       return 0;
>>   }
>> +/**
>> + * vfio_ap_queue_dev_remove:
>> + *
>> + * Free the associated vfio_ap_queue structure
>> + */
>>   static void vfio_ap_queue_dev_remove(struct ap_device *apdev)
>>   {
>> -    /* Nothing to do yet */
>> +    struct vfio_ap_queue *q;
>> +
>> +    q = dev_get_drvdata(&apdev->device);
>> +    list_del(&q->list);
>> +    kfree(q);
>>   }
>>   static void vfio_ap_matrix_dev_release(struct device *dev)
>> @@ -107,6 +131,7 @@ static int vfio_ap_matrix_dev_create(void)
>>       matrix_dev->device.bus = &matrix_bus;
>>       matrix_dev->device.release = vfio_ap_matrix_dev_release;
>>       matrix_dev->vfio_ap_drv = &vfio_ap_drv;
>> +    INIT_LIST_HEAD(&matrix_dev->free_list);
>>       ret = device_register(&matrix_dev->device);
>>       if (ret)
>> diff --git a/drivers/s390/crypto/vfio_ap_private.h 
>> b/drivers/s390/crypto/vfio_ap_private.h
>> index 76b7f98..2760178 100644
>> --- a/drivers/s390/crypto/vfio_ap_private.h
>> +++ b/drivers/s390/crypto/vfio_ap_private.h
>> @@ -39,6 +39,7 @@ struct ap_matrix_dev {
>>       atomic_t available_instances;
>>       struct ap_config_info info;
>>       struct list_head mdev_list;
>> +    struct list_head free_list;
>>       struct mutex lock;
>>       struct ap_driver  *vfio_ap_drv;
>>   };
>> @@ -81,9 +82,17 @@ struct ap_matrix_mdev {
>>       struct ap_matrix matrix;
>>       struct notifier_block group_notifier;
>>       struct kvm *kvm;
>> +    struct list_head qlist;
> 
> I do not see much value in maintaining two lists of at the
> expense of complicating the code and introducing additional
> processing (i.e., list rewinds etc.). IMHO, the only think it buys
> us is being able to pass a smaller list to the vfio_ap_get_queue()
> function to traverse. That function can traverse the list in
> struct ap_matrix_dev to find a queue. I understand what you are
> doing here in pulling vfio_ap_queue structs from the free_list
> to add them to qlist for the mdev when adapter/domain assignment
> takes place, but you are now maintaining links to the vfio_ap_queue
> in multiple places; as drvdata as well as two lists. I think this
> is over designing.

This is not completely exact, the drvdata allows to retrieve the 
vfio_ap_queue structure from the AP device, which is global to all AP 
devices, and not related to a mediated device.

The vfio_ap_queue structure is only linked to one of the different lists 
it can be linked to: the free_list or the mediated device list.

The complication of the code you mention make us win almost 200 LOCs, 
some may see it as a simplification ;) .

Regards,
Pierre

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

