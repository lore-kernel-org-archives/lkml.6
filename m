Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14E5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF9DA20836
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbfBUQSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 11:18:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55964 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727645AbfBUQSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 11:18:42 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1LG9eQC028477
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 11:18:41 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qsy2f95rs-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 11:18:40 -0500
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Thu, 21 Feb 2019 16:18:39 -0000
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 21 Feb 2019 16:18:36 -0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1LGIV9e19857542
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Feb 2019 16:18:31 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA271BE051;
        Thu, 21 Feb 2019 16:18:31 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B4E2BE053;
        Thu, 21 Feb 2019 16:18:30 +0000 (GMT)
Received: from [9.85.140.198] (unknown [9.85.140.198])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 21 Feb 2019 16:18:29 +0000 (GMT)
Subject: Re: [PATCH v3 1/1] s390: vfio_ap: link the vfio_ap devices to the
 vfio_ap bus subsystem
To:     Pierre Morel <pmorel@linux.ibm.com>, borntraeger@de.ibm.com
Cc:     cohuck@redhat.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com
References: <1550758494-28227-1-git-send-email-pmorel@linux.ibm.com>
 <1550758494-28227-2-git-send-email-pmorel@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Thu, 21 Feb 2019 11:18:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1550758494-28227-2-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19022116-8235-0000-0000-00000E631F0E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010638; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01164322; UDB=6.00608011; IPR=6.00944908;
 MB=3.00025682; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-21 16:18:38
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022116-8236-0000-0000-0000448E9214
Message-Id: <139f6846-3c1b-bef1-a204-901e12b9c035@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-21_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902210117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/19 9:14 AM, Pierre Morel wrote:
> Libudev relies on having a subsystem link for non-root devices. To
> avoid libudev (and potentially other userspace tools) choking on the
> matrix device let us introduce a matrix bus and with it the matrix
> bus subsytem. Also make the matrix device reside within the matrix
> bus.
> 
> Doing this we remove the forced link from the matrix device to the
> vfio_ap driver and the device_type we do not need anymore.
> 
> Since the associated matrix driver is not the vfio_ap driver any more,
> we have to change the search for the devices on the vfio_ap driver in
> the function vfio_ap_verify_queue_reserved.
> 
> Fixes: 1fde573413b5 ("s390: vfio-ap: base implementation of VFIO AP device driver")
> 
> Cc: stable@vger.kernel.org
> 
> Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>

Reviewed-by: Tony Krowiak <akrowiak@linux.ibm.com>

> Acked-by: Halil Pasic <pasic@linux.ibm.com>
> ---
>   drivers/s390/crypto/vfio_ap_drv.c     | 44 ++++++++++++++++++++++++++++-------
>   drivers/s390/crypto/vfio_ap_ops.c     |  4 ++--
>   drivers/s390/crypto/vfio_ap_private.h |  1 +
>   3 files changed, 38 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
> index 31c6c84..e9824c3 100644
> --- a/drivers/s390/crypto/vfio_ap_drv.c
> +++ b/drivers/s390/crypto/vfio_ap_drv.c
> @@ -15,7 +15,6 @@
>   #include "vfio_ap_private.h"
>   
>   #define VFIO_AP_ROOT_NAME "vfio_ap"
> -#define VFIO_AP_DEV_TYPE_NAME "ap_matrix"
>   #define VFIO_AP_DEV_NAME "matrix"
>   
>   MODULE_AUTHOR("IBM Corporation");
> @@ -24,10 +23,6 @@ MODULE_LICENSE("GPL v2");
>   
>   static struct ap_driver vfio_ap_drv;
>   
> -static struct device_type vfio_ap_dev_type = {
> -	.name = VFIO_AP_DEV_TYPE_NAME,
> -};
> -
>   struct ap_matrix_dev *matrix_dev;
>   
>   /* Only type 10 adapters (CEX4 and later) are supported
> @@ -62,6 +57,22 @@ static void vfio_ap_matrix_dev_release(struct device *dev)
>   	kfree(matrix_dev);
>   }
>   
> +static int matrix_bus_match(struct device *dev, struct device_driver *drv)
> +{
> +	return 1;
> +}
> +
> +static struct bus_type matrix_bus = {
> +	.name = "matrix",

I'm sorry, I'm late to the game due to being in a time zone six hours
behind you all, but my preference would be 'ap_matrix' for the name
of the bus. It seems odd to have the bus and the device both named
'matrix'. It's just my opinion and not a show stopper.

> +	.match = &matrix_bus_match,
> +};
> +
> +static struct device_driver matrix_driver = {
> +	.name = "vfio_ap",
> +	.bus = &matrix_bus,
> +	.suppress_bind_attrs = true,
> +};
> +
>   static int vfio_ap_matrix_dev_create(void)
>   {
>   	int ret;
> @@ -71,6 +82,10 @@ static int vfio_ap_matrix_dev_create(void)
>   	if (IS_ERR(root_device))
>   		return PTR_ERR(root_device);
>   
> +	ret = bus_register(&matrix_bus);
> +	if (ret)
> +		goto bus_register_err;
> +
>   	matrix_dev = kzalloc(sizeof(*matrix_dev), GFP_KERNEL);
>   	if (!matrix_dev) {
>   		ret = -ENOMEM;
> @@ -87,30 +102,41 @@ static int vfio_ap_matrix_dev_create(void)
>   	mutex_init(&matrix_dev->lock);
>   	INIT_LIST_HEAD(&matrix_dev->mdev_list);
>   
> -	matrix_dev->device.type = &vfio_ap_dev_type;
>   	dev_set_name(&matrix_dev->device, "%s", VFIO_AP_DEV_NAME);
>   	matrix_dev->device.parent = root_device;
> +	matrix_dev->device.bus = &matrix_bus;
>   	matrix_dev->device.release = vfio_ap_matrix_dev_release;
> -	matrix_dev->device.driver = &vfio_ap_drv.driver;
> +	matrix_dev->vfio_ap_drv = &vfio_ap_drv;
>   
>   	ret = device_register(&matrix_dev->device);
>   	if (ret)
>   		goto matrix_reg_err;
>   
> +	ret = driver_register(&matrix_driver);
> +	if (ret)
> +		goto matrix_drv_err;
> +
>   	return 0;
>   
> +matrix_drv_err:
> +	device_unregister(&matrix_dev->device);
>   matrix_reg_err:
>   	put_device(&matrix_dev->device);
>   matrix_alloc_err:
> +	bus_unregister(&matrix_bus);
> +bus_register_err:
>   	root_device_unregister(root_device);
> -
>   	return ret;
>   }
>   
>   static void vfio_ap_matrix_dev_destroy(void)
>   {
> +	struct device *root_device = matrix_dev->device.parent;
> +
> +	driver_unregister(&matrix_driver);
>   	device_unregister(&matrix_dev->device);
> -	root_device_unregister(matrix_dev->device.parent);
> +	bus_unregister(&matrix_bus);
> +	root_device_unregister(root_device);
>   }
>   
>   static int __init vfio_ap_init(void)
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 272ef42..900b9cf 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -198,8 +198,8 @@ static int vfio_ap_verify_queue_reserved(unsigned long *apid,
>   	qres.apqi = apqi;
>   	qres.reserved = false;
>   
> -	ret = driver_for_each_device(matrix_dev->device.driver, NULL, &qres,
> -				     vfio_ap_has_queue);
> +	ret = driver_for_each_device(&matrix_dev->vfio_ap_drv->driver, NULL,
> +				     &qres, vfio_ap_has_queue);
>   	if (ret)
>   		return ret;
>   
> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
> index 5675492..76b7f98 100644
> --- a/drivers/s390/crypto/vfio_ap_private.h
> +++ b/drivers/s390/crypto/vfio_ap_private.h
> @@ -40,6 +40,7 @@ struct ap_matrix_dev {
>   	struct ap_config_info info;
>   	struct list_head mdev_list;
>   	struct mutex lock;
> +	struct ap_driver  *vfio_ap_drv;
>   };
>   
>   extern struct ap_matrix_dev *matrix_dev;
> 

