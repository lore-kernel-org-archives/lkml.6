Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45B6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D5F0222DD
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394232AbfBOWzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 17:55:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51228 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728235AbfBOWzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 17:55:46 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1FMccE3176619
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 17:55:45 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qp59samme-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 17:55:44 -0500
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Fri, 15 Feb 2019 22:55:44 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 15 Feb 2019 22:55:40 -0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1FMtbo724445034
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Feb 2019 22:55:37 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 006C3AE062;
        Fri, 15 Feb 2019 22:55:37 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45CE6AE060;
        Fri, 15 Feb 2019 22:55:36 +0000 (GMT)
Received: from [9.80.239.175] (unknown [9.80.239.175])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 15 Feb 2019 22:55:36 +0000 (GMT)
Subject: Re: [PATCH v3 6/9] vfio: ap: register IOMMU VFIO notifier
To:     Pierre Morel <pmorel@linux.ibm.com>, borntraeger@de.ibm.com
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com,
        david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
 <1550152269-6317-7-git-send-email-pmorel@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Fri, 15 Feb 2019 17:55:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1550152269-6317-7-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19021522-0072-0000-0000-000003FAB960
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010604; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000280; SDB=6.01161606; UDB=6.00606365; IPR=6.00942166;
 MB=3.00025605; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-15 22:55:43
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021522-0073-0000-0000-00004B31B5B3
Message-Id: <3ce0a3a0-22fb-c418-321d-7e6e3af5b66c@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-15_16:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902150147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/19 8:51 AM, Pierre Morel wrote:
> To be able to use the VFIO interface to facilitate the
> mediated device memory pining/unpining we need to register
> a notifier for IOMMU.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>   drivers/s390/crypto/vfio_ap_ops.c     | 64 +++++++++++++++++++++++++++++++----
>   drivers/s390/crypto/vfio_ap_private.h |  2 ++
>   2 files changed, 60 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 1851b24..6eddc2c 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -781,6 +781,36 @@ static const struct attribute_group *vfio_ap_mdev_attr_groups[] = {
>   };
>   
>   /**
> + * vfio_ap_mdev_iommu_notifier: IOMMU notifier callback
> + *
> + * @nb: The notifier block
> + * @action: Action to be taken (VFIO_IOMMU_NOTIFY_DMA_UNMAP)
> + * @data: the specific unmap structure for vfio_iommu_type1
> + *
> + * Unpins the guest IOVA. (The NIB guest address we pinned before).
> + * Return NOTIFY_OK after unpining on a UNMAP request.
> + * otherwise, returns NOTIFY_DONE .
> + */
> +static int vfio_ap_mdev_iommu_notifier(struct notifier_block *nb,
> +				       unsigned long action, void *data)
> +{
> +	struct ap_matrix_mdev *matrix_mdev;
> +
> +	matrix_mdev = container_of(nb, struct ap_matrix_mdev, iommu_notifier);
> +
> +	if (action == VFIO_IOMMU_NOTIFY_DMA_UNMAP) {
> +		struct vfio_iommu_type1_dma_unmap *unmap = data;
> +		unsigned long g_pfn = unmap->iova >> PAGE_SHIFT;
> +
> +		vfio_unpin_pages(mdev_dev(matrix_mdev->mdev), &g_pfn, 1);
> +		return NOTIFY_OK;
> +	}
> +
> +	return NOTIFY_DONE;
> +}
> +
> +
> +/**
>    * vfio_ap_mdev_set_kvm
>    *
>    * @matrix_mdev: a mediated matrix device
> @@ -904,8 +934,7 @@ static void vfio_ap_dissociate_queues(struct ap_matrix_mdev *matrix_mdev)
>    * In the case a queue could not be found return -ENODEV.
>    * Otherwise return 0.
>    */
> -static __attribute__((unused))
> -	int vfio_ap_associate_queues(struct ap_matrix_mdev *matrix_mdev)
> +static int vfio_ap_associate_queues(struct ap_matrix_mdev *matrix_mdev)

Maybe this function should be introduced in this patch instead?

>   {
>   	unsigned long apid, apqi;
>   	struct vfio_ap_queue *q;
> @@ -967,12 +996,32 @@ static int vfio_ap_mdev_open(struct mdev_device *mdev)
>   
>   	ret = vfio_register_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
>   				     &events, &matrix_mdev->group_notifier);
> -	if (ret) {
> -		module_put(THIS_MODULE);
> -		return ret;
> -	}
> +	if (ret)
> +		goto err_group;
> +
> +	matrix_mdev->iommu_notifier.notifier_call = vfio_ap_mdev_iommu_notifier;
> +	events = VFIO_IOMMU_NOTIFY_DMA_UNMAP;
> +
> +	ret = vfio_register_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
> +				     &events, &matrix_mdev->iommu_notifier);
> +	if (ret)
> +		goto err_iommu;
> +
> +	ret = vfio_ap_associate_queues(matrix_mdev);
> +	if (ret)
> +		goto err_associate;

I think the matrix_mdev should be associated with queues when an 
assignment of an adapter or domain is made to the mdev device via its
sysfs interfaces. I say this because assigning an adapter or domain to
an mdev device effectively grants ownership of any additional AP queues 
added to the mdev device's AP matrix as a result of the assignment. It
only makes sense to assign ownership to the vfio_ap_queue objects
representing the queues at that time. If an adapter or domain is
dynamically assigned while a guest is using the affected queues, then
the associations will have to be made at that time and this code will
likely go bye bye.

>   
>   	return 0;
> +
> +err_associate:
> +	vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
> +				 &matrix_mdev->iommu_notifier);
> +err_iommu:
> +	vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
> +				 &matrix_mdev->group_notifier);
> +err_group:
> +	module_put(THIS_MODULE);
> +	return ret;
>   }
>   
>   static void vfio_ap_mdev_release(struct mdev_device *mdev)
> @@ -985,6 +1034,9 @@ static void vfio_ap_mdev_release(struct mdev_device *mdev)
>   	vfio_ap_mdev_reset_queues(mdev);
>   	vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
>   				 &matrix_mdev->group_notifier);
> +	vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
> +				 &matrix_mdev->iommu_notifier);
> +	vfio_ap_dissociate_queues(matrix_mdev);

I think the matrix_mdev should be dissociated from queues when an
adapter or domain is unassigned from the mdev device via its
sysfs interfaces. I say this because unassigning an adapter or domain 
from an mdev device effectively takes away ownership of any AP queues
removed from the mdev device's AP matrix as a result of the
unassignment. It only makes sense to remove ownership from the
vfio_ap_queue objects representing the queues at that time. This will
become necessary for the forthcoming dynamic configuration patches.
If an adapter or domain is dynamically unassigned while a guest is
using the affected queues, then the dissociation will have to be made
at that time and this code will likely go bye bye.

>   	matrix_mdev->kvm = NULL;
>   	module_put(THIS_MODULE);
>   }
> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
> index 10bc8b5..2781720 100644
> --- a/drivers/s390/crypto/vfio_ap_private.h
> +++ b/drivers/s390/crypto/vfio_ap_private.h
> @@ -80,7 +80,9 @@ struct ap_matrix_mdev {
>   	struct list_head node;
>   	struct ap_matrix matrix;
>   	struct notifier_block group_notifier;
> +	struct notifier_block iommu_notifier;
>   	struct kvm *kvm;
> +	struct mdev_device *mdev;
>   };
>   
>   extern int vfio_ap_mdev_register(void);
> 

