Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9091AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6066221928
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437446AbfBNRgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 12:36:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36970 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2437416AbfBNRgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 12:36:54 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1EHYTDr115395
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 12:36:53 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qncg0hsev-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 12:36:53 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 14 Feb 2019 17:36:50 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 14 Feb 2019 17:36:49 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1EHalAH2621728
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 Feb 2019 17:36:47 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E80311C05B;
        Thu, 14 Feb 2019 17:36:47 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C3E5E11C050;
        Thu, 14 Feb 2019 17:36:46 +0000 (GMT)
Received: from [9.152.224.140] (unknown [9.152.224.140])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 14 Feb 2019 17:36:46 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v3 1/9] s390: vfio_ap: link the vfio_ap devices to the
 vfio_ap bus subsystem
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     borntraeger@de.ibm.com, alex.williamson@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
 <1550152269-6317-2-git-send-email-pmorel@linux.ibm.com>
 <20190214155441.087d2a68.cohuck@redhat.com>
 <9403117a-04a6-8f69-2a61-f96d35a59555@linux.ibm.com>
 <20190214175730.4ab609ae.cohuck@redhat.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Thu, 14 Feb 2019 18:36:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190214175730.4ab609ae.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19021417-0008-0000-0000-000002C08816
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021417-0009-0000-0000-0000222CAB8E
Message-Id: <9200b1f8-874f-ffa7-bef0-19ca570d7ac1@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-14_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902140119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2019 17:57, Cornelia Huck wrote:
> On Thu, 14 Feb 2019 16:47:30 +0100 Pierre Morel
> <pmorel@linux.ibm.com> wrote:
> 
>> On 14/02/2019 15:54, Cornelia Huck wrote:
>>> On Thu, 14 Feb 2019 14:51:01 +0100 Pierre Morel
>>> <pmorel@linux.ibm.com> wrote:
> 
>>>> +++ b/drivers/s390/crypto/vfio_ap_drv.c @@ -24,8 +24,9 @@
>>>> MODULE_LICENSE("GPL v2");
>>>> 
>>>> static struct ap_driver vfio_ap_drv;
>>>> 
>>>> -static struct device_type vfio_ap_dev_type = { -	.name =
>>>> VFIO_AP_DEV_TYPE_NAME, +struct matrix_driver { +	struct
>>>> device_driver drv; +	int device_count;
>>> 
>>> This counter basically ensures that at most one device may bind
>>> with this driver... you'd still have that device on the bus,
>>> though.
>> 
>> yes, this is what is wanted: this driver can only support one
>> device. May be another matrix driver can support one or more other
>> devices.
>> 
>> I should update comment message my be.
>> 
>>> 
>>>> };
>>>> 
>>>> struct ap_matrix_dev *matrix_dev;
>> 
>>>> 
>>>> -	matrix_dev->device.type = &vfio_ap_dev_type; 
>>>> dev_set_name(&matrix_dev->device, "%s", VFIO_AP_DEV_NAME); 
>>>> matrix_dev->device.parent = root_device; +
>>>> matrix_dev->device.bus = &matrix_bus; 
>>>> matrix_dev->device.release = vfio_ap_matrix_dev_release; -
>>>> matrix_dev->device.driver = &vfio_ap_drv.driver; +
>>>> matrix_dev->vfio_ap_drv = &vfio_ap_drv;
>>> 
>>> Can't you get that structure through matrix_dev->device.driver
>>> instead when you need it in the function below?
>> 
>> Not anymore. We have two different drivers and devices matrix_drv
>> <-> matrix_dev and vfio_ap_drv <-> ap_devices
>> 
>> The driver behind the matrix_dev->dev->driver is matrix_drv what is
>> needed here is vfio_ap_drv.
> 
> Wait, we had tacked a driver for ap devices unto a matrix device,
> which is not on the ap bus?

...yes -(

> Maybe that's what trips libudev? >
> (And reading further in the current code, it seems we clear that 
> structure _after_ the matrix device had been setup, so how can that 
> even work? Where am I confused?)

On device_register there were no bus, so the core just do not look for a 
driver and this field was nor tested nor overwritten.

> 
>> 
>>> 
>>>> 
>>>> ret = device_register(&matrix_dev->device); if (ret) goto
>>>> matrix_reg_err;
>>>> 
>>>> +	ret = driver_register(&matrix_driver.drv); +	if (ret) +		goto
>>>> matrix_drv_err; +
>>> 
>>> As you already have several structures that can be registered
>>> exactly once (the root device, the bus, the driver, ...), you can
>>> already be sure that there's only one device on the bus, can't
>>> you?
>> 
>> hum, no I don't think so, no device can register before this module
>> is loaded, but what does prevent a device to register later from
>> another module?
> 
> Not unless you export the interface, I guess.
> 

:) definitively right
thanks, this will simplify the code in the next version.
I will take the patch away from this series to get the way to stable as 
Christian requested.

Regards,
Pierre

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

