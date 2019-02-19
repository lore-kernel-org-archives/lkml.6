Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579D8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 18:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15D5A21738
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 18:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbfBSSw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 13:52:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53182 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725875AbfBSSw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 13:52:58 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1JImmp6017477
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 13:52:56 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qrpqd27gw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 13:52:55 -0500
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Tue, 19 Feb 2019 18:52:54 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 19 Feb 2019 18:52:52 -0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1JIqnMN23527600
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Feb 2019 18:52:49 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F0D55AE062;
        Tue, 19 Feb 2019 18:52:48 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B21C6AE05C;
        Tue, 19 Feb 2019 18:52:48 +0000 (GMT)
Received: from [9.60.75.235] (unknown [9.60.75.235])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 19 Feb 2019 18:52:48 +0000 (GMT)
Subject: Re: [PATCH v2 1/1] s390: vfio_ap: link the vfio_ap devices to the
 vfio_ap bus subsystem
To:     Pierre Morel <pmorel@linux.ibm.com>, borntraeger@de.ibm.com
Cc:     cohuck@redhat.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com
References: <1550513328-12646-1-git-send-email-pmorel@linux.ibm.com>
 <1550513328-12646-2-git-send-email-pmorel@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Tue, 19 Feb 2019 13:52:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1550513328-12646-2-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19021918-0072-0000-0000-000003FC44B4
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010627; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01163419; UDB=6.00607465; IPR=6.00944001;
 MB=3.00025659; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-19 18:52:54
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021918-0073-0000-0000-00004B3B9B30
Message-Id: <8e6853ba-12ed-a4f3-1263-0e15f715b644@linux.ibm.com>
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

On 2/18/19 1:08 PM, Pierre Morel wrote:
> Libudev relies on having a subsystem link for non-root devices. To
> avoid libudev (and potentially other userspace tools) choking on the
> matrix device let us introduce a vfio_ap bus and with that the vfio_ap
> bus subsytem, and make the matrix device reside within it.
> 
> Doing this we need to suppress the forced link from the matrix device to
> the vfio_ap driver and we suppress the device_type we do not need
> anymore.
> 
> Since the associated matrix driver is not the vfio_ap driver any more,
> we have to change the search for the devices on the vfio_ap driver in
> the function vfio_ap_verify_queue_reserved.
> 
> Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>   drivers/s390/crypto/vfio_ap_drv.c     | 48 +++++++++++++++++++++++++++++------
>   drivers/s390/crypto/vfio_ap_ops.c     |  4 +--
>   drivers/s390/crypto/vfio_ap_private.h |  1 +
>   3 files changed, 43 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
> index 31c6c84..8e45559 100644
> --- a/drivers/s390/crypto/vfio_ap_drv.c
> +++ b/drivers/s390/crypto/vfio_ap_drv.c
> @@ -24,10 +24,6 @@ MODULE_LICENSE("GPL v2");
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
> @@ -62,6 +58,27 @@ static void vfio_ap_matrix_dev_release(struct device *dev)
>   	kfree(matrix_dev);
>   }
>   
> +static int matrix_bus_match(struct device *dev, struct device_driver *drv)
> +{
> +	return 1;

I think we should verify the following:

* dev == matrix_dev->device
* drv == &matrix_driver

The model employed is for the matrix device to be a singleton, so I
think we should verify that the matrix device and driver defined herein
ought to be the only possible choices for a match. Of course, doing so
will require some restructuring of this patch.

> +}
> +
> +static struct bus_type matrix_bus = {
> +	.name = "vfio_ap",
> +	.match = &matrix_bus_match,
> +};
> +
> +static int matrix_probe(struct device *dev)
> +{
> +	return 0;
> +}
> +
> +static struct device_driver matrix_driver = {
> +	.name = "vfio_ap",

This is the same name used for the original device driver. I think
this driver ought to have a different name to avoid confusion.
How about vfio_ap_matrix or some other name to differentiate the
two.

> +	.bus = &matrix_bus,
> +	.probe = matrix_probe,

I would add:
	.suppress_bind_attrs = true;

This will remove the sysfs bind/unbind interfaces. Since there is only
one matrix device and it's lifecycle is controlled herein, there is no
sense in allowing a root user to bind/unbind it.

> +};
> +
>   static int vfio_ap_matrix_dev_create(void)
>   {
>   	int ret;
> @@ -71,6 +88,10 @@ static int vfio_ap_matrix_dev_create(void)
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
> @@ -87,30 +108,41 @@ static int vfio_ap_matrix_dev_create(void)
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

