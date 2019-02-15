Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A02C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAE04222D7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732250AbfBOWNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 17:13:31 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46796 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728617AbfBOWNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 17:13:31 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1FM8Zla073211
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 17:13:30 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qp1rd1sym-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 17:13:30 -0500
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Fri, 15 Feb 2019 22:13:28 -0000
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 15 Feb 2019 22:13:26 -0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1FMDMjr21299222
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Feb 2019 22:13:22 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD800AC0A5;
        Fri, 15 Feb 2019 22:13:22 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 14812AC0A2;
        Fri, 15 Feb 2019 22:13:22 +0000 (GMT)
Received: from [9.80.239.175] (unknown [9.80.239.175])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 15 Feb 2019 22:13:21 +0000 (GMT)
Subject: Re: [PATCH v3 4/9] s390: ap: tools to find a queue with a specific
 APQN
To:     Pierre Morel <pmorel@linux.ibm.com>, borntraeger@de.ibm.com
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com,
        david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
 <1550152269-6317-5-git-send-email-pmorel@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Fri, 15 Feb 2019 17:13:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1550152269-6317-5-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19021522-2213-0000-0000-00000351E385
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010604; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000280; SDB=6.01161592; UDB=6.00606356; IPR=6.00942152;
 MB=3.00025604; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-15 22:13:28
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021522-2214-0000-0000-00005D5E765F
Message-Id: <56f583e7-fb41-ec54-ccf9-585a3e51b1c4@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-15_16:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902150144
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/19 8:51 AM, Pierre Morel wrote:
> We need to find the queue with a specific APQN during the
> handling of the interception of the PQAP/AQIC instruction.
> 
> To handle the AP associated device reference count we keep
> track of it in the vfio_ap_queue until we put the device.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>   drivers/s390/crypto/vfio_ap_ops.c     | 54 +++++++++++++++++++++++++++++++++++
>   drivers/s390/crypto/vfio_ap_private.h |  1 +
>   2 files changed, 55 insertions(+)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 900b9cf..2a52c9b 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -24,6 +24,60 @@
>   #define VFIO_AP_MDEV_TYPE_HWVIRT "passthrough"
>   #define VFIO_AP_MDEV_NAME_HWVIRT "VFIO AP Passthrough Device"
>   
> +/**
> + * vfio_ap_check_apqn: check if a ap_queue is of a given APQN
> + *
> + * Returns 1 if we have a match.
> + * Otherwise returns 0.
> + */
> +static int vfio_ap_check_apqn(struct device *dev, void *data)
> +{
> +	struct vfio_ap_queue *q = dev_get_drvdata(dev);
> +
> +	return (q->apqn == *(int *)data);
> +}
> +
> +/**
> + * vfio_ap_get_queue: Retrieve a queue with a specific APQN
> + * @apqn: The queue APQN
> + *
> + * Retrieve a queue with a specific APQN from the list of the
> + * devices associated to the vfio_ap_driver.
> + *
> + * The vfio_ap_queue has been already associated with the device
> + * during the probe.
> + * Store the associated device for reference counting
> + *
> + * Returns the pointer to the associated vfio_ap_queue
> + */
> +static  __attribute__((unused))
> +	struct vfio_ap_queue *vfio_ap_get_queue(int apqn)

I think you should change this signature for the reasons I stated
below:

struct device *vfio_ap_get_queue_dev(int apqn)

> +{
> +	struct device *dev;
> +	struct vfio_ap_queue *q;
> +
> +	dev = driver_find_device(&matrix_dev->vfio_ap_drv->driver, NULL, &apqn,
> +				 vfio_ap_check_apqn);
> +	if (!dev)
> +		return NULL;
> +	q = dev_get_drvdata(dev);
> +	q->dev = dev;

Why store the device with the vfio_ap_queue object? Why not just return
the device. The caller can get the vfio_ap_queue from the device's
driver data. It seems the only reason for the 'dev' field is to
temporarily hold a ref to the device so it can be put later. Why not
just put the device.

> +	return q;
> +}
> +
> +/**
> + * vfio_ap_put_queue: lower device reference count for a queue
> + * @q: The queue
> + *
> + * put the associated device
> + *
> + */
> +static  __attribute__((unused)) void vfio_ap_put_queue(struct vfio_ap_queue *q)
> +{
> +	put_device(q->dev);
> +	q->dev = NULL;
> +}

I would get rid of this function. If you take my suggestion above, you
can just call the put_device() directly. There will be no need for
this superfluous 'dev' field.

> +
>   static void vfio_ap_matrix_init(struct ap_config_info *info,
>   				struct ap_matrix *matrix)
>   {
> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
> index 8836f01..081f0d7 100644
> --- a/drivers/s390/crypto/vfio_ap_private.h
> +++ b/drivers/s390/crypto/vfio_ap_private.h
> @@ -87,6 +87,7 @@ extern int vfio_ap_mdev_register(void);
>   extern void vfio_ap_mdev_unregister(void);
>   
>   struct vfio_ap_queue {
> +	struct device *dev;

No need for this as per my comments above.

>   	int	apqn;
>   };
>   #endif /* _VFIO_AP_PRIVATE_H_ */
> 

