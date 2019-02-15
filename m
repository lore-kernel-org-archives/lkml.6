Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65947C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 23:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29C6B2192D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 23:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388677AbfBOX3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 18:29:17 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42786 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387534AbfBOX3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 18:29:17 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1FNOHO3122789
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 18:29:15 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qp5jsjvwm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 18:29:15 -0500
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Fri, 15 Feb 2019 23:29:14 -0000
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 15 Feb 2019 23:29:11 -0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1FNT6s922610098
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Feb 2019 23:29:07 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB52ABE05D;
        Fri, 15 Feb 2019 23:29:06 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E4E10BE053;
        Fri, 15 Feb 2019 23:29:04 +0000 (GMT)
Received: from [9.80.239.175] (unknown [9.80.239.175])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 15 Feb 2019 23:29:04 +0000 (GMT)
Subject: Re: [PATCH v3 8/9] s390: ap: Cleanup on removing the AP device
To:     Pierre Morel <pmorel@linux.ibm.com>, borntraeger@de.ibm.com
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com,
        david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
 <1550152269-6317-9-git-send-email-pmorel@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Fri, 15 Feb 2019 18:29:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1550152269-6317-9-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19021523-8235-0000-0000-00000E5E31B8
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010604; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000280; SDB=6.01161617; UDB=6.00606372; IPR=6.00942178;
 MB=3.00025605; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-15 23:29:13
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021523-8236-0000-0000-0000447C0246
Message-Id: <f60b520b-7342-da0d-48cb-5a16190b7f40@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-15_16:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902150150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/19 8:51 AM, Pierre Morel wrote:
> When the device is remove, we must make sure to
> clear the interruption and reset the AP device.
> 
> We also need to clear the CRYCB of the guest.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>   drivers/s390/crypto/vfio_ap_drv.c     | 92 +++++++++++++++++++++++++++++++++++
>   drivers/s390/crypto/vfio_ap_ops.c     |  2 +-
>   drivers/s390/crypto/vfio_ap_private.h |  2 +
>   3 files changed, 95 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
> index 03153e6..50428be 100644
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
> @@ -64,6 +67,88 @@ static int vfio_ap_queue_dev_probe(struct ap_device *apdev)
>   	return 0;
>   }
>   
> +/*
> + * vfio_ap_drain_queue
> + * @q: the queue to drain
> + *
> + * This function waits until the queue is empty.
> + */
> +static void vfio_ap_drain_queue(struct vfio_ap_queue *q)
> +{
> +	struct ap_queue_status status;
> +	int retry = 20;
> +
> +	status = ap_tapq(q->apqn, NULL);
> +	while (!status.queue_empty && retry--)  {
> +		msleep(200);
> +		status = ap_tapq(q->apqn, NULL);
> +	}
> +	if (retry <= 0) {
> +		pr_warn("%s: queue not empty after zapq on apqn 0x%04x\n",
> +			__func__, q->apqn);
> +	}
> +}
> +
> +/*
> + * vfio_ap_zapq
> + * @q: The queue to zerro
> + *
> + * It is best effort, no return value is done, however on success
> + * we will drain the queue before getting the queue back to the
> + * AP bus.
> + */
> +static void vfio_ap_zapq(struct vfio_ap_queue *q)
> +{
> +	struct ap_queue_status status;
> +	int retry = 20;
> +
> +	do {
> +		status = ap_zapq(q->apqn);
> +		switch (status.response_code) {
> +		case AP_RESPONSE_RESET_IN_PROGRESS:
> +		case AP_RESPONSE_BUSY:
> +			msleep(20);
> +			break;
> +		default:
> +			pr_warn("%s: zapq error %02x on apqn 0x%04x\n",
> +				__func__, status.response_code, q->apqn);
> +			return;
> +		case AP_RESPONSE_NORMAL:
> +			vfio_ap_drain_queue(q);

I don't think this is necessary. The zeroize is performed on
each AP-queue entry in an AP queue. My understanding is that when a
reset or zeroize is pending, any AP instructions subsequently issued
are rejected with condition-code 3 indicating an AP queue reset is in
progress. It is also my understanding that once the AP commands 
currently executing in a given AP queue entry complete, the queue
entry will be zeroized. So it seems to me that there is no need to
"drain" the queue, it will have already been done by the zeroize.

If you agree we don't need to "drain" the queue, then I'd rather just
make the zapq function in the vfio_ap_ops.c non-static and make it
available to the driver. There is no sense in duplicating this code. In
fact, even if you keep the draining function, you still don't need to
duplicate a zaapq instruction here, you can just call the vfio_ap_ops.c
version and then drain the queue on AP_RESPONSE_NORMAL.


> +			return;
> +		}
> +	} while (retry--);
> +	pr_warn("%s: zapq retry count exceeded code %02x on apqn 0x%04x\n",
> +		__func__, status.response_code, q->apqn);
> +}
> +
> +/**
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
> +	struct ap_matrix_mdev *matrix_mdev = q->matrix;
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
>   /**
>    * vfio_ap_queue_dev_remove:
>    *
> @@ -74,6 +159,13 @@ static void vfio_ap_queue_dev_remove(struct ap_device *apdev)
>   	struct vfio_ap_queue *q;
>   
>   	q = dev_get_drvdata(&apdev->device);
> +	if (!q)
> +		return;
> +
> +	vfio_ap_update_crycb(q);
> +	vfio_ap_zapq(q);
> +
> +	vfio_ap_free_irq(q);

If you make the zapq function in vfio_ap_ops.c available to the driver
rather than duplicating it in this file, you won't need this call
to vfio_ap_free_irq because it is done as part of the zapq in
vfio_ap_ops.c.

>   	kfree(q);
>   }
>   
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 5664cf3..7ec957c 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -85,7 +85,7 @@ static void vfio_ap_put_queue(struct vfio_ap_queue *q)
>    * Unregister the ISC from the GIB alert
>    * Clear the vfio_ap_queue intern fields
>    */
> -static void vfio_ap_free_irq(struct vfio_ap_queue *q)
> +void vfio_ap_free_irq(struct vfio_ap_queue *q)
>   {
>   	unsigned long pfn = q->nib >> PAGE_SHIFT;
>   
> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
> index 16c99e9..d108c6d 100644
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
> @@ -95,4 +96,5 @@ struct vfio_ap_queue {
>   	unsigned long nib;
>   	unsigned char isc;
>   };
> +void vfio_ap_free_irq(struct vfio_ap_queue *q);
>   #endif /* _VFIO_AP_PRIVATE_H_ */
> 

