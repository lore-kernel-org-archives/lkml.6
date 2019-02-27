Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50118C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2239C20661
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbfB0JyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 04:54:14 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35242 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726419AbfB0JyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 04:54:14 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1R9nHWW051900
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 04:54:13 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qwpk3d9sr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 04:54:12 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Wed, 27 Feb 2019 09:54:10 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 27 Feb 2019 09:54:07 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1R9s5ws31785116
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Feb 2019 09:54:06 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE592A405D;
        Wed, 27 Feb 2019 09:54:05 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E4D6A4055;
        Wed, 27 Feb 2019 09:54:05 +0000 (GMT)
Received: from [9.152.224.140] (unknown [9.152.224.140])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 27 Feb 2019 09:54:05 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v4 5/7] s390: ap: implement PAPQ AQIC interception in
 kernel
To:     Tony Krowiak <akrowiak@linux.ibm.com>, borntraeger@de.ibm.com
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com,
        david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
References: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
 <1550849400-27152-6-git-send-email-pmorel@linux.ibm.com>
 <d8eead83-6d93-4213-c702-c7e684142ff2@linux.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Wed, 27 Feb 2019 10:54:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <d8eead83-6d93-4213-c702-c7e684142ff2@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19022709-0012-0000-0000-000002FAC20D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022709-0013-0000-0000-000021326928
Message-Id: <57819262-9e59-6f81-b8c4-22bbb1f952c7@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-27_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902270066
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/02/2019 19:23, Tony Krowiak wrote:
> On 2/22/19 10:29 AM, Pierre Morel wrote:
>> We register the AP PQAP instruction hook during the open
>> of the mediated device. And unregister it on release.
>>
>> In the AP PQAP instruction hook, if we receive a demand to
>> enable IRQs,
>> - we retrieve the vfio_ap_queue based on the APQN we receive
>>    in REG1,
>> - we retrieve the page of the guest address, (NIB), from
>>    register REG2
>> - we the mediated device to use the VFIO pinning infratrsucture
>>    to pin the page of the guest address,
>> - we retrieve the pointer to KVM to register the guest ISC
>>    and retrieve the host ISC
>> - finaly we activate GISA
>>
>> If we receive a demand to disable IRQs,
>> - we deactivate GISA
>> - unregister from the GIB
>> - unping the NIB
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   arch/s390/include/asm/kvm_host.h      |   1 +
>>   drivers/s390/crypto/ap_bus.h          |   1 +
>>   drivers/s390/crypto/vfio_ap_ops.c     | 199 
>> +++++++++++++++++++++++++++++++++-
>>   drivers/s390/crypto/vfio_ap_private.h |   1 +
>>   4 files changed, 199 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/s390/include/asm/kvm_host.h 
>> b/arch/s390/include/asm/kvm_host.h
>> index 49cc8b0..5f3bb8c 100644
>> --- a/arch/s390/include/asm/kvm_host.h
>> +++ b/arch/s390/include/asm/kvm_host.h
>> @@ -720,6 +720,7 @@ struct kvm_s390_cpu_model {
>>   struct kvm_s390_crypto {
>>       struct kvm_s390_crypto_cb *crycb;
>>       int (*pqap_hook)(struct kvm_vcpu *vcpu);
>> +    void *vfio_private;

...snip...


>> + *
>> + * Return 0 if we could handle the request inside KVM.
>> + * otherwise, returns -EOPNOTSUPP to let QEMU handle the fault.
>> + */
>> +static int handle_pqap(struct kvm_vcpu *vcpu)
> 
> Change this function name to handle_pqap_aqic

Since we only intercept AQIC, why not.

> 
>> +{
>> +}
> 
> Add this function:
> 
> static int handle_pqap(struct kvm_vcpu *vcpu)
> {
>      int ret;
>      uint8_t fc;
> 
>      fc = vcpu->run->s.regs.gprs[0] >> 24;
>      switch (fc) {
>      case 0x03:
>          ret = handle_pqap_aqic(vcpu);
>          break;
>      default:
>          ret = -EOPNOTSUPP;
>          break;
>      }
> 
>      return ret;
> }

It is of no use for now, we only intercept AQIC, why introduce this now?

We can introduce a trampoline when we intercept TAPQ. If we do.


> 
>> +
>> + /*
>>    * vfio_ap_mdev_iommu_notifier: IOMMU notifier callback
>>    *
>>    * @nb: The notifier block
>> @@ -767,9 +950,10 @@ static int vfio_ap_mdev_iommu_notifier(struct 
>> notifier_block *nb,
>>       if (action == VFIO_IOMMU_NOTIFY_DMA_UNMAP) {
>>           struct vfio_iommu_type1_dma_unmap *unmap = data;
>> -        unsigned long g_pfn = unmap->iova >> PAGE_SHIFT;
>> +        unsigned long pfn = unmap->iova >> PAGE_SHIFT;
>> -        vfio_unpin_pages(mdev_dev(matrix_mdev->mdev), &g_pfn, 1);
>> +        if (matrix_mdev->mdev)
>> +            vfio_unpin_pages(mdev_dev(matrix_mdev->mdev), &pfn, 1);
>>           return NOTIFY_OK;
>>       }
>> @@ -879,6 +1063,11 @@ static int vfio_ap_mdev_open(struct mdev_device 
>> *mdev)
>>       if (ret)
>>           goto err_group;
>> +    if (!matrix_mdev->kvm) {
>> +        ret = -ENODEV;
>> +        goto err_iommu;
>> +    }
>> +
>>       matrix_mdev->iommu_notifier.notifier_call = 
>> vfio_ap_mdev_iommu_notifier;
>>       events = VFIO_IOMMU_NOTIFY_DMA_UNMAP;
>> @@ -887,6 +1076,8 @@ static int vfio_ap_mdev_open(struct mdev_device 
>> *mdev)
>>       if (ret)
>>           goto err_iommu;
>> +    matrix_mdev->kvm->arch.crypto.pqap_hook = handle_pqap;
>> +    matrix_mdev->kvm->arch.crypto.vfio_private = matrix_mdev;
> 
> I do not see this used anywhere, why do we need it?

In handle_papq to retrieve the associated mediated device

> 
>>       return 0;
>>   err_iommu:
>> @@ -905,6 +1096,8 @@ static void vfio_ap_mdev_release(struct 
>> mdev_device *mdev)
>>           kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
>>       vfio_ap_mdev_reset_queues(mdev);
>> +    matrix_mdev->kvm->arch.crypto.pqap_hook = NULL;
>> +    matrix_mdev->kvm->arch.crypto.vfio_private = NULL;
> 
> Ditto

ditto

> 
>>       vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
>>                    &matrix_mdev->group_notifier);
>>       vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
>> diff --git a/drivers/s390/crypto/vfio_ap_private.h 
>> b/drivers/s390/crypto/vfio_ap_private.h
>> index e535735..e2fd2c0 100644
>> --- a/drivers/s390/crypto/vfio_ap_private.h
>> +++ b/drivers/s390/crypto/vfio_ap_private.h
>> @@ -94,6 +94,7 @@ struct vfio_ap_queue {
>>       struct list_head list;
>>       struct ap_matrix_mdev *matrix_mdev;
>>       unsigned long nib;
>> +    unsigned long g_pfn;
> 
> Can't this be calculated from the nib?

It is.
It is initialized during the IRQ enabling with the current pinned NIB.
While the nib is initialised with the NIB to be use.

This allows to unpin the previous pinned NIB in the case the guest reset 
the queue, which automatically disable interrupt, because in this case 
the guest will not explicitely disable IRQ by using AQIC.


Regards,
Pierre


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

