Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91BDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90E982173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbfBZS2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 13:28:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40684 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729035AbfBZS2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 13:28:13 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1QIFBTP164123
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 13:28:12 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qw7y5aqst-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 13:28:06 -0500
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Tue, 26 Feb 2019 18:28:06 -0000
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Feb 2019 18:28:02 -0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1QIRxOU18677944
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Feb 2019 18:27:59 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A43F112063;
        Tue, 26 Feb 2019 18:27:59 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4589E112066;
        Tue, 26 Feb 2019 18:27:58 +0000 (GMT)
Received: from [9.85.194.241] (unknown [9.85.194.241])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Feb 2019 18:27:58 +0000 (GMT)
Subject: Re: [PATCH v4 6/7] s390: ap: Cleanup on removing the AP device
To:     Pierre Morel <pmorel@linux.ibm.com>, borntraeger@de.ibm.com
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com,
        david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
References: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
 <1550849400-27152-7-git-send-email-pmorel@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Tue, 26 Feb 2019 13:27:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1550849400-27152-7-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19022618-2213-0000-0000-000003594714
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010669; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01166741; UDB=6.00609472; IPR=6.00947346;
 MB=3.00025752; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-26 18:28:04
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022618-2214-0000-0000-00005D7D2C5B
Message-Id: <3f15bd09-8a90-ed8a-e15a-0f3bac1a3528@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-26_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902260128
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/19 10:29 AM, Pierre Morel wrote:
> When the device is remove, we must make sure to
> clear the interruption and reset the AP device.
> 
> We also need to clear the CRYCB of the guest.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>   drivers/s390/crypto/vfio_ap_drv.c     | 35 +++++++++++++++++++++++++++++++++++
>   drivers/s390/crypto/vfio_ap_ops.c     |  3 ++-
>   drivers/s390/crypto/vfio_ap_private.h |  3 +++
>   3 files changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
> index eca0ffc..e5d91ff 100644
> --- a/drivers/s390/crypto/vfio_ap_drv.c
> +++ b/drivers/s390/crypto/vfio_ap_drv.c
> @@ -5,6 +5,7 @@
>    * Copyright IBM Corp. 2018
>    *
>    * Author(s): Tony Krowiak <akrowiak@linux.ibm.com>
> + *	      Pierre Morel <pmorel@linux.ibm.com>
>    */
>   
>   #include <linux/module.h>
> @@ -12,6 +13,8 @@
>   #include <linux/slab.h>
>   #include <linux/string.h>
>   #include <asm/facility.h>
> +#include <linux/bitops.h>
> +#include <linux/kvm_host.h>
>   #include "vfio_ap_private.h"
>   
>   #define VFIO_AP_ROOT_NAME "vfio_ap"
> @@ -61,6 +64,33 @@ static int vfio_ap_queue_dev_probe(struct ap_device *apdev)
>   }
>   
>   /**
> + * vfio_ap_update_crycb
> + * @q: A pointer to the queue being removed
> + *
> + * We clear the APID of the queue, making this queue unusable for the guest.
> + * After this function we can reset the queue without to fear a race with
> + * the guest to access the queue again.
> + * We do not fear race with the host as we still get the device.
> + */
> +static void vfio_ap_update_crycb(struct vfio_ap_queue *q)
> +{
> +	struct ap_matrix_mdev *matrix_mdev = q->matrix_mdev;
> +
> +	if (!matrix_mdev)
> +		return;
> +
> +	clear_bit_inv(AP_QID_CARD(q->apqn), matrix_mdev->matrix.apm);
> +
> +	if (!matrix_mdev->kvm)
> +		return;
> +
> +	kvm_arch_crypto_set_masks(matrix_mdev->kvm,
> +				  matrix_mdev->matrix.apm,
> +				  matrix_mdev->matrix.aqm,
> +				  matrix_mdev->matrix.adm);
> +}
> +
> +/**
>    * vfio_ap_queue_dev_remove:
>    *
>    * Free the associated vfio_ap_queue structure
> @@ -70,6 +100,11 @@ static void vfio_ap_queue_dev_remove(struct ap_device *apdev)
>   	struct vfio_ap_queue *q;
>   
>   	q = dev_get_drvdata(&apdev->device);
> +	if (!q)
> +		return;
> +
> +	vfio_ap_update_crycb(q);
> +	vfio_ap_mdev_reset_queue(q);

The reset is unnecessary because once the card is removed from the
CRYCB, the ZAPQ may fail with because the queue may not exist anymore.
Besides, once the card is removed from the guest's CRYCB, the bus
running in the guest will do a reset.

>   	list_del(&q->list);
>   	kfree(q);
>   }
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 0196065..5b9bb33 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -59,6 +59,7 @@ int vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q)
>   			if (retry <= 0)
>   				pr_warn("%s: queue 0x%04x not empty\n",
>   					__func__, q->apqn);
> +			vfio_ap_free_irq(q);
>   			return 0;
>   		case AP_RESPONSE_RESET_IN_PROGRESS:
>   		case AP_RESPONSE_BUSY:
> @@ -83,7 +84,7 @@ int vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q)
>    * Unregister the ISC from the GIB alert
>    * Clear the vfio_ap_queue intern fields
>    */
> -static void vfio_ap_free_irq(struct vfio_ap_queue *q)
> +void vfio_ap_free_irq(struct vfio_ap_queue *q)
>   {
>   	if (!q)
>   		return;
> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
> index e2fd2c0..cc18215 100644
> --- a/drivers/s390/crypto/vfio_ap_private.h
> +++ b/drivers/s390/crypto/vfio_ap_private.h
> @@ -4,6 +4,7 @@
>    *
>    * Author(s): Tony Krowiak <akrowiak@linux.ibm.com>
>    *	      Halil Pasic <pasic@linux.ibm.com>
> + *	      Pierre Morel <pmorel@linux.ibm.com>
>    *
>    * Copyright IBM Corp. 2018
>    */
> @@ -98,4 +99,6 @@ struct vfio_ap_queue {
>   	int	apqn;
>   	unsigned char isc;
>   };
> +void vfio_ap_free_irq(struct vfio_ap_queue *q);
> +int vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q);
>   #endif /* _VFIO_AP_PRIVATE_H_ */
> 

