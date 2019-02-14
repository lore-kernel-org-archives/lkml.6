Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F457C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3648222DB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394681AbfBNRMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 12:12:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32768 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732491AbfBNRMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 12:12:41 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1EH0Hcu099693
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 12:12:40 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qncbph3vn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 12:12:39 -0500
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Thu, 14 Feb 2019 17:12:38 -0000
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 14 Feb 2019 17:12:36 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1EHCWZP24445106
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Feb 2019 17:12:32 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 970F9B205F;
        Thu, 14 Feb 2019 17:12:32 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D363EB2065;
        Thu, 14 Feb 2019 17:12:31 +0000 (GMT)
Received: from [9.80.213.209] (unknown [9.80.213.209])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 14 Feb 2019 17:12:31 +0000 (GMT)
Subject: Re: [PATCH v3 1/9] s390: vfio_ap: link the vfio_ap devices to the
 vfio_ap bus subsystem
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Cc:     alex.williamson@redhat.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        frankja@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        freude@linux.ibm.com, mimu@linux.ibm.com
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
 <1550152269-6317-2-git-send-email-pmorel@linux.ibm.com>
 <20190214155441.087d2a68.cohuck@redhat.com>
 <6147f1ce-fd8b-1ec2-30ce-7ac68f3d8e27@de.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Thu, 14 Feb 2019 12:12:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <6147f1ce-fd8b-1ec2-30ce-7ac68f3d8e27@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19021417-0040-0000-0000-000004C189E5
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010595; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000280; SDB=6.01161015; UDB=6.00604226; IPR=6.00941572;
 MB=3.00025584; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-14 17:12:37
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021417-0041-0000-0000-000008CCAAC5
Message-Id: <25a8cfb4-f432-8bde-bec9-1187c7705084@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-14_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902140115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/19 10:05 AM, Christian Borntraeger wrote:
> On 14.02.2019 15:54, Cornelia Huck wrote:
>> On Thu, 14 Feb 2019 14:51:01 +0100
>> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
> Pierre,
> this is independent from this series and should have been sent separately.
> In the end (when we have the final solution) this will require cc stable.

I agree wholeheartedly with this statement. It has nothing to do with
interrupt processing.

>>
>>> Libudev relies on having a subsystem link for non-root devices. To
>>> avoid libudev (and potentially other userspace tools) choking on the
>>> matrix device let us introduce a vfio_ap bus and with that the vfio_ap
>>> bus subsytem, and make the matrix device reside within it.
>>
>> How does libudev choke on this? It feels wrong to introduce a bus that
>> basically does nothing...
> 
> I have seen libvirt looping when a matrix device was available before the
> libvirt start.
> Marc Hartmayer debugged this and circumvented this in libvirt:
> https://www.redhat.com/archives/libvir-list/2019-February/msg00837.html
> 
> Still libudev expects a subsystem link in the matrix folder when doing the
> udev_enumerate_scan_devices call.
> 
> Having a bus is one way of adding a subsystem link.
> 
>>
>>>
>>> We restrict the number of allowed devices to a single one.
>>>
>>> Doing this we need to suppress the forced link from the matrix device to
>>> the vfio_ap driver and we suppress the device_type we do not need
>>> anymore.
>>>
>>> Since the associated matrix driver is not the vfio_ap driver any more,
>>> we have to change the search for the devices on the vfio_ap driver in
>>> the function vfio_ap_verify_queue_reserved.
>>>
>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>> ---
>>>   drivers/s390/crypto/vfio_ap_drv.c     | 63 +++++++++++++++++++++++++++++++----
>>>   drivers/s390/crypto/vfio_ap_ops.c     |  4 +--
>>>   drivers/s390/crypto/vfio_ap_private.h |  1 +
>>>   3 files changed, 60 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
>>> index 31c6c84..1fd5fe6 100644
>>> --- a/drivers/s390/crypto/vfio_ap_drv.c
>>> +++ b/drivers/s390/crypto/vfio_ap_drv.c
>>> @@ -24,8 +24,9 @@ MODULE_LICENSE("GPL v2");
>>>   
>>>   static struct ap_driver vfio_ap_drv;
>>>   
>>> -static struct device_type vfio_ap_dev_type = {
>>> -	.name = VFIO_AP_DEV_TYPE_NAME,
>>> +struct matrix_driver {
>>> +	struct device_driver drv;
>>> +	int device_count;
>>
>> This counter basically ensures that at most one device may bind with
>> this driver... you'd still have that device on the bus, though.
>>
>>>   };
>>>   
>>>   struct ap_matrix_dev *matrix_dev;
>>> @@ -62,6 +63,41 @@ static void vfio_ap_matrix_dev_release(struct device *dev)
>>>   	kfree(matrix_dev);
>>>   }
>>>   
>>> +static int matrix_bus_match(struct device *dev, struct device_driver *drv)
>>> +{
>>> +	return 1;
>>> +}
>>> +
>>> +static struct bus_type matrix_bus = {
>>> +	.name = "vfio_ap",
>>> +	.match = &matrix_bus_match,
>>> +};
>>> +
>>> +static int matrix_probe(struct device *dev);
>>> +static int matrix_remove(struct device *dev);
>>> +static struct matrix_driver matrix_driver = {
>>> +	.drv = {
>>> +		.name = "vfio_ap",
>>> +		.bus = &matrix_bus,
>>> +		.probe = matrix_probe,
>>> +		.remove = matrix_remove,
>>> +	},
>>> +};
>>> +
>>> +static int matrix_probe(struct device *dev)
>>> +{
>>> +	if (matrix_driver.device_count)
>>> +		return -EEXIST;
>>> +	matrix_driver.device_count++;
>>> +	return 0;
>>> +}
>>> +
>>> +static int matrix_remove(struct device *dev)
>>> +{
>>> +	matrix_driver.device_count--;
>>> +	return 0;
>>> +}
>>> +
>>>   static int vfio_ap_matrix_dev_create(void)
>>>   {
>>>   	int ret;
>>> @@ -71,6 +107,10 @@ static int vfio_ap_matrix_dev_create(void)
>>>   	if (IS_ERR(root_device))
>>>   		return PTR_ERR(root_device);
>>>   
>>> +	ret = bus_register(&matrix_bus);
>>> +	if (ret)
>>> +		goto bus_register_err;
>>> +
>>>   	matrix_dev = kzalloc(sizeof(*matrix_dev), GFP_KERNEL);
>>>   	if (!matrix_dev) {
>>>   		ret = -ENOMEM;
>>> @@ -87,30 +127,41 @@ static int vfio_ap_matrix_dev_create(void)
>>>   	mutex_init(&matrix_dev->lock);
>>>   	INIT_LIST_HEAD(&matrix_dev->mdev_list);
>>>   
>>> -	matrix_dev->device.type = &vfio_ap_dev_type;
>>>   	dev_set_name(&matrix_dev->device, "%s", VFIO_AP_DEV_NAME);
>>>   	matrix_dev->device.parent = root_device;
>>> +	matrix_dev->device.bus = &matrix_bus;
>>>   	matrix_dev->device.release = vfio_ap_matrix_dev_release;
>>> -	matrix_dev->device.driver = &vfio_ap_drv.driver;
>>> +	matrix_dev->vfio_ap_drv = &vfio_ap_drv;
>>
>> Can't you get that structure through matrix_dev->device.driver instead
>> when you need it in the function below?
>>
>>>   
>>>   	ret = device_register(&matrix_dev->device);
>>>   	if (ret)
>>>   		goto matrix_reg_err;
>>>   
>>> +	ret = driver_register(&matrix_driver.drv);
>>> +	if (ret)
>>> +		goto matrix_drv_err;
>>> +
>>
>> As you already have several structures that can be registered exactly
>> once (the root device, the bus, the driver, ...), you can already be
>> sure that there's only one device on the bus, can't you?
>>
>>>   	return 0;
>>>   
>>> +matrix_drv_err:
>>> +	device_unregister(&matrix_dev->device);
>>>   matrix_reg_err:
>>>   	put_device(&matrix_dev->device);
>>>   matrix_alloc_err:
>>> +	bus_unregister(&matrix_bus);
>>> +bus_register_err:
>>>   	root_device_unregister(root_device);
>>> -
>>>   	return ret;
>>>   }
>>>   
>>>   static void vfio_ap_matrix_dev_destroy(void)
>>>   {
>>> +	struct device *root_device = matrix_dev->device.parent;
>>> +
>>> +	driver_unregister(&matrix_driver.drv);
>>>   	device_unregister(&matrix_dev->device);
>>> -	root_device_unregister(matrix_dev->device.parent);
>>> +	bus_unregister(&matrix_bus);
>>> +	root_device_unregister(root_device);
>>>   }
>>>   
>>>   static int __init vfio_ap_init(void)
>>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>>> index 272ef42..900b9cf 100644
>>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>>> @@ -198,8 +198,8 @@ static int vfio_ap_verify_queue_reserved(unsigned long *apid,
>>>   	qres.apqi = apqi;
>>>   	qres.reserved = false;
>>>   
>>> -	ret = driver_for_each_device(matrix_dev->device.driver, NULL, &qres,
>>> -				     vfio_ap_has_queue);
>>> +	ret = driver_for_each_device(&matrix_dev->vfio_ap_drv->driver, NULL,
>>> +				     &qres, vfio_ap_has_queue);
>>>   	if (ret)
>>>   		return ret;
>>>   
>>> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
>>> index 5675492..76b7f98 100644
>>> --- a/drivers/s390/crypto/vfio_ap_private.h
>>> +++ b/drivers/s390/crypto/vfio_ap_private.h
>>> @@ -40,6 +40,7 @@ struct ap_matrix_dev {
>>>   	struct ap_config_info info;
>>>   	struct list_head mdev_list;
>>>   	struct mutex lock;
>>> +	struct ap_driver  *vfio_ap_drv;
>>>   };
>>>   
>>>   extern struct ap_matrix_dev *matrix_dev;
>>
>> This feels like a lot of boilerplate code, just to create a bus that
>> basically doesn't do anything. I'm surprised that libudev can't deal
>> with bus-less devices properly...
>>
> 

