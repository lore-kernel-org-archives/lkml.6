Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712F8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 18:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 340B02147C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 18:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbfBSSv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 13:51:26 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56618 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725939AbfBSSv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 13:51:26 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1JIml3T123621
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 13:51:24 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qrmgn9tn3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 13:51:22 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Tue, 19 Feb 2019 18:51:19 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 19 Feb 2019 18:51:17 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1JIpFib63045754
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Feb 2019 18:51:16 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF256AE056;
        Tue, 19 Feb 2019 18:51:15 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D7F1AAE055;
        Tue, 19 Feb 2019 18:51:14 +0000 (GMT)
Received: from [9.145.49.77] (unknown [9.145.49.77])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 19 Feb 2019 18:51:14 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v3 6/9] vfio: ap: register IOMMU VFIO notifier
To:     Tony Krowiak <akrowiak@linux.ibm.com>, borntraeger@de.ibm.com
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com,
        david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
 <1550152269-6317-7-git-send-email-pmorel@linux.ibm.com>
 <3ce0a3a0-22fb-c418-321d-7e6e3af5b66c@linux.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Tue, 19 Feb 2019 19:51:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <3ce0a3a0-22fb-c418-321d-7e6e3af5b66c@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19021918-0016-0000-0000-00000258627C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021918-0017-0000-0000-000032B2A822
Message-Id: <81c8422d-4952-747e-6c91-a613ce6d626e@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-19_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902190134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/02/2019 23:55, Tony Krowiak wrote:
> On 2/14/19 8:51 AM, Pierre Morel wrote:
>> To be able to use the VFIO interface to facilitate the
>> mediated device memory pining/unpining we need to register
>> a notifier for IOMMU.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_ops.c     | 64 
>> +++++++++++++++++++++++++++++++----
>>   drivers/s390/crypto/vfio_ap_private.h |  2 ++
>>   2 files changed, 60 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c 
>> b/drivers/s390/crypto/vfio_ap_ops.c
>> index 1851b24..6eddc2c 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -781,6 +781,36 @@ static const struct attribute_group 
>> *vfio_ap_mdev_attr_groups[] = {
>>   };
>>   /**
>> + * vfio_ap_mdev_iommu_notifier: IOMMU notifier callback
>> + *
>> + * @nb: The notifier block
>> + * @action: Action to be taken (VFIO_IOMMU_NOTIFY_DMA_UNMAP)
>> + * @data: the specific unmap structure for vfio_iommu_type1
>> + *
>> + * Unpins the guest IOVA. (The NIB guest address we pinned before).
>> + * Return NOTIFY_OK after unpining on a UNMAP request.
>> + * otherwise, returns NOTIFY_DONE .
>> + */
>> +static int vfio_ap_mdev_iommu_notifier(struct notifier_block *nb,
>> +                       unsigned long action, void *data)
>> +{
>> +    struct ap_matrix_mdev *matrix_mdev;
>> +
>> +    matrix_mdev = container_of(nb, struct ap_matrix_mdev, 
>> iommu_notifier);
>> +
>> +    if (action == VFIO_IOMMU_NOTIFY_DMA_UNMAP) {
>> +        struct vfio_iommu_type1_dma_unmap *unmap = data;
>> +        unsigned long g_pfn = unmap->iova >> PAGE_SHIFT;
>> +
>> +        vfio_unpin_pages(mdev_dev(matrix_mdev->mdev), &g_pfn, 1);
>> +        return NOTIFY_OK;
>> +    }
>> +
>> +    return NOTIFY_DONE;
>> +}
>> +
>> +
>> +/**
>>    * vfio_ap_mdev_set_kvm
>>    *
>>    * @matrix_mdev: a mediated matrix device
>> @@ -904,8 +934,7 @@ static void vfio_ap_dissociate_queues(struct 
>> ap_matrix_mdev *matrix_mdev)
>>    * In the case a queue could not be found return -ENODEV.
>>    * Otherwise return 0.
>>    */
>> -static __attribute__((unused))
>> -    int vfio_ap_associate_queues(struct ap_matrix_mdev *matrix_mdev)
>> +static int vfio_ap_associate_queues(struct ap_matrix_mdev *matrix_mdev)
> 
> Maybe this function should be introduced in this patch instead?
> 
>>   {
>>       unsigned long apid, apqi;
>>       struct vfio_ap_queue *q;
>> @@ -967,12 +996,32 @@ static int vfio_ap_mdev_open(struct mdev_device 
>> *mdev)
>>       ret = vfio_register_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
>>                        &events, &matrix_mdev->group_notifier);
>> -    if (ret) {
>> -        module_put(THIS_MODULE);
>> -        return ret;
>> -    }
>> +    if (ret)
>> +        goto err_group;
>> +
>> +    matrix_mdev->iommu_notifier.notifier_call = 
>> vfio_ap_mdev_iommu_notifier;
>> +    events = VFIO_IOMMU_NOTIFY_DMA_UNMAP;
>> +
>> +    ret = vfio_register_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
>> +                     &events, &matrix_mdev->iommu_notifier);
>> +    if (ret)
>> +        goto err_iommu;
>> +
>> +    ret = vfio_ap_associate_queues(matrix_mdev);
>> +    if (ret)
>> +        goto err_associate;
> 
> I think the matrix_mdev should be associated with queues when an 
> assignment of an adapter or domain is made to the mdev device via its
> sysfs interfaces. I say this because assigning an adapter or domain to
> an mdev device effectively grants ownership of any additional AP queues 
> added to the mdev device's AP matrix as a result of the assignment. It
> only makes sense to assign ownership to the vfio_ap_queue objects
> representing the queues at that time. If an adapter or domain is
> dynamically assigned while a guest is using the affected queues, then
> the associations will have to be made at that time and this code will
> likely go bye bye.
> 
>>       return 0;
>> +
>> +err_associate:
>> +    vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
>> +                 &matrix_mdev->iommu_notifier);
>> +err_iommu:
>> +    vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
>> +                 &matrix_mdev->group_notifier);
>> +err_group:
>> +    module_put(THIS_MODULE);
>> +    return ret;
>>   }
>>   static void vfio_ap_mdev_release(struct mdev_device *mdev)
>> @@ -985,6 +1034,9 @@ static void vfio_ap_mdev_release(struct 
>> mdev_device *mdev)
>>       vfio_ap_mdev_reset_queues(mdev);
>>       vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
>>                    &matrix_mdev->group_notifier);
>> +    vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
>> +                 &matrix_mdev->iommu_notifier);
>> +    vfio_ap_dissociate_queues(matrix_mdev);
> 
> I think the matrix_mdev should be dissociated from queues when an
> adapter or domain is unassigned from the mdev device via its
> sysfs interfaces. I say this because unassigning an adapter or domain 
> from an mdev device effectively takes away ownership of any AP queues
> removed from the mdev device's AP matrix as a result of the
> unassignment. It only makes sense to remove ownership from the
> vfio_ap_queue objects representing the queues at that time. This will
> become necessary for the forthcoming dynamic configuration patches.
> If an adapter or domain is dynamically unassigned while a guest is
> using the affected queues, then the dissociation will have to be made
> at that time and this code will likely go bye bye.

Effectively,having a link from the vfio_ap_queue to the mediated device 
will simplify the sanity checking during assignment.

I will go this way.

Regards,
Pierre

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

