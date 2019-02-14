Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4066C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73B80222DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404828AbfBNPLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:11:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51004 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389062AbfBNPLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:11:40 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1EFAPQu098596
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 10:11:39 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qn9tpw3ev-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 10:11:37 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 14 Feb 2019 15:09:43 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 14 Feb 2019 15:09:40 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1EF9cDk3015072
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 Feb 2019 15:09:39 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E0E5811C050;
        Thu, 14 Feb 2019 15:09:38 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5292711C04C;
        Thu, 14 Feb 2019 15:09:38 +0000 (GMT)
Received: from [9.152.224.140] (unknown [9.152.224.140])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 14 Feb 2019 15:09:38 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v3 1/9] s390: vfio_ap: link the vfio_ap devices to the
 vfio_ap bus subsystem
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
 <1550152269-6317-2-git-send-email-pmorel@linux.ibm.com>
 <8d4a76f9-9cc8-691f-b1ae-ec6e95324e74@de.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Thu, 14 Feb 2019 16:09:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <8d4a76f9-9cc8-691f-b1ae-ec6e95324e74@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19021415-0012-0000-0000-000002F5BC12
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021415-0013-0000-0000-0000212D398D
Message-Id: <38519183-5668-d05a-6d27-19d85858323c@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-14_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902140106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2019 16:01, Christian Borntraeger wrote:
> 
> 
> On 14.02.2019 14:51, Pierre Morel wrote:
>> Libudev relies on having a subsystem link for non-root devices. To
>> avoid libudev (and potentially other userspace tools) choking on the
>> matrix device let us introduce a vfio_ap bus and with that the vfio_ap
>> bus subsytem, and make the matrix device reside within it.
>>
>> We restrict the number of allowed devices to a single one.
>>
>> Doing this we need to suppress the forced link from the matrix device to
>> the vfio_ap driver and we suppress the device_type we do not need
>> anymore.
>>
>> Since the associated matrix driver is not the vfio_ap driver any more,
>> we have to change the search for the devices on the vfio_ap driver in
>> the function vfio_ap_verify_queue_reserved.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> 
> Didnt you want to a add a reported-by?

Yes, forgot it.

Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>



>> ---
> 
> 
>>   drivers/s390/crypto/vfio_ap_drv.c     | 63 +++++++++++++++++++++++++++++++----
>>   drivers/s390/crypto/vfio_ap_ops.c     |  4 +--
>>   drivers/s390/crypto/vfio_ap_private.h |  1 +
>>   3 files changed, 60 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
>> index 31c6c84..1fd5fe6 100644
>> --- a/drivers/s390/crypto/vfio_ap_drv.c
>> +++ b/drivers/s390/crypto/vfio_ap_drv.c
>> @@ -24,8 +24,9 @@ MODULE_LICENSE("GPL v2");
>>   
>>   static struct ap_driver vfio_ap_drv;
>>   
>> -static struct device_type vfio_ap_dev_type = {
>> -	.name = VFIO_AP_DEV_TYPE_NAME,
>> +struct matrix_driver {
>> +	struct device_driver drv;
>> +	int device_count;
>>   };
>>   
>>   struct ap_matrix_dev *matrix_dev;
>> @@ -62,6 +63,41 @@ static void vfio_ap_matrix_dev_release(struct device *dev)
>>   	kfree(matrix_dev);
>>   }
>>   
>> +static int matrix_bus_match(struct device *dev, struct device_driver *drv)
>> +{
>> +	return 1;
>> +}
>> +
>> +static struct bus_type matrix_bus = {
>> +	.name = "vfio_ap",
>> +	.match = &matrix_bus_match,
>> +};
>> +
>> +static int matrix_probe(struct device *dev);
>> +static int matrix_remove(struct device *dev);
>> +static struct matrix_driver matrix_driver = {
>> +	.drv = {
>> +		.name = "vfio_ap",
>> +		.bus = &matrix_bus,
>> +		.probe = matrix_probe,
>> +		.remove = matrix_remove,
>> +	},
>> +};
>> +
>> +static int matrix_probe(struct device *dev)
>> +{
>> +	if (matrix_driver.device_count)
>> +		return -EEXIST;
>> +	matrix_driver.device_count++;
>> +	return 0;
>> +}
>> +
>> +static int matrix_remove(struct device *dev)
>> +{
>> +	matrix_driver.device_count--;
>> +	return 0;
>> +}
>> +
>>   static int vfio_ap_matrix_dev_create(void)
>>   {
>>   	int ret;
>> @@ -71,6 +107,10 @@ static int vfio_ap_matrix_dev_create(void)
>>   	if (IS_ERR(root_device))
>>   		return PTR_ERR(root_device);
>>   
>> +	ret = bus_register(&matrix_bus);
>> +	if (ret)
>> +		goto bus_register_err;
>> +
>>   	matrix_dev = kzalloc(sizeof(*matrix_dev), GFP_KERNEL);
>>   	if (!matrix_dev) {
>>   		ret = -ENOMEM;
>> @@ -87,30 +127,41 @@ static int vfio_ap_matrix_dev_create(void)
>>   	mutex_init(&matrix_dev->lock);
>>   	INIT_LIST_HEAD(&matrix_dev->mdev_list);
>>   
>> -	matrix_dev->device.type = &vfio_ap_dev_type;
>>   	dev_set_name(&matrix_dev->device, "%s", VFIO_AP_DEV_NAME);
>>   	matrix_dev->device.parent = root_device;
>> +	matrix_dev->device.bus = &matrix_bus;
>>   	matrix_dev->device.release = vfio_ap_matrix_dev_release;
>> -	matrix_dev->device.driver = &vfio_ap_drv.driver;
>> +	matrix_dev->vfio_ap_drv = &vfio_ap_drv;
>>   
>>   	ret = device_register(&matrix_dev->device);
>>   	if (ret)
>>   		goto matrix_reg_err;
>>   
>> +	ret = driver_register(&matrix_driver.drv);
>> +	if (ret)
>> +		goto matrix_drv_err;
>> +
>>   	return 0;
>>   
>> +matrix_drv_err:
>> +	device_unregister(&matrix_dev->device);
>>   matrix_reg_err:
>>   	put_device(&matrix_dev->device);
>>   matrix_alloc_err:
>> +	bus_unregister(&matrix_bus);
>> +bus_register_err:
>>   	root_device_unregister(root_device);
>> -
>>   	return ret;
>>   }
>>   
>>   static void vfio_ap_matrix_dev_destroy(void)
>>   {
>> +	struct device *root_device = matrix_dev->device.parent;
>> +
>> +	driver_unregister(&matrix_driver.drv);
>>   	device_unregister(&matrix_dev->device);
>> -	root_device_unregister(matrix_dev->device.parent);
>> +	bus_unregister(&matrix_bus);
>> +	root_device_unregister(root_device);
>>   }
>>   
>>   static int __init vfio_ap_init(void)
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index 272ef42..900b9cf 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -198,8 +198,8 @@ static int vfio_ap_verify_queue_reserved(unsigned long *apid,
>>   	qres.apqi = apqi;
>>   	qres.reserved = false;
>>   
>> -	ret = driver_for_each_device(matrix_dev->device.driver, NULL, &qres,
>> -				     vfio_ap_has_queue);
>> +	ret = driver_for_each_device(&matrix_dev->vfio_ap_drv->driver, NULL,
>> +				     &qres, vfio_ap_has_queue);
>>   	if (ret)
>>   		return ret;
>>   
>> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
>> index 5675492..76b7f98 100644
>> --- a/drivers/s390/crypto/vfio_ap_private.h
>> +++ b/drivers/s390/crypto/vfio_ap_private.h
>> @@ -40,6 +40,7 @@ struct ap_matrix_dev {
>>   	struct ap_config_info info;
>>   	struct list_head mdev_list;
>>   	struct mutex lock;
>> +	struct ap_driver  *vfio_ap_drv;
>>   };
>>   
>>   extern struct ap_matrix_dev *matrix_dev;
>>


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

