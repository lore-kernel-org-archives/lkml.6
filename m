Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A498C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 21:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00F40222DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 21:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388583AbfBOV7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 16:59:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50918 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387500AbfBOV7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 16:59:45 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1FLnpNI091288
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 16:59:44 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qp5me8b33-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 16:59:43 -0500
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Fri, 15 Feb 2019 21:59:42 -0000
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 15 Feb 2019 21:59:38 -0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1FLxYQd24314028
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Feb 2019 21:59:35 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D2E96AE05C;
        Fri, 15 Feb 2019 21:59:34 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2BCBBAE060;
        Fri, 15 Feb 2019 21:59:34 +0000 (GMT)
Received: from [9.80.239.175] (unknown [9.80.239.175])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 15 Feb 2019 21:59:34 +0000 (GMT)
Subject: Re: [PATCH v3 1/9] s390: vfio_ap: link the vfio_ap devices to the
 vfio_ap bus subsystem
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     pmorel@linux.ibm.com, borntraeger@de.ibm.com,
        alex.williamson@redhat.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        frankja@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        freude@linux.ibm.com, mimu@linux.ibm.com
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
 <1550152269-6317-2-git-send-email-pmorel@linux.ibm.com>
 <20190214155441.087d2a68.cohuck@redhat.com>
 <9403117a-04a6-8f69-2a61-f96d35a59555@linux.ibm.com>
 <20190214175730.4ab609ae.cohuck@redhat.com>
 <9200b1f8-874f-ffa7-bef0-19ca570d7ac1@linux.ibm.com>
 <eac03540-a499-fa0f-1a4a-b5cc99030775@linux.ibm.com>
 <20190215101118.5417d725.cohuck@redhat.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Fri, 15 Feb 2019 16:59:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190215101118.5417d725.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19021521-0052-0000-0000-0000038B4492
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010604; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000280; SDB=6.01161587; UDB=6.00606354; IPR=6.00942148;
 MB=3.00025604; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-15 21:59:40
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021521-0053-0000-0000-00005FDC4AEB
Message-Id: <f38c99e6-bb25-9179-e4cd-20ba8482111f@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-15_16:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902150143
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/19 4:11 AM, Cornelia Huck wrote:
> On Thu, 14 Feb 2019 13:30:59 -0500
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> 
>> On 2/14/19 12:36 PM, Pierre Morel wrote:
>>> On 14/02/2019 17:57, Cornelia Huck wrote:
>>>> On Thu, 14 Feb 2019 16:47:30 +0100 Pierre Morel
>>>> <pmorel@linux.ibm.com> wrote:
>>>>   
>>>>> On 14/02/2019 15:54, Cornelia Huck wrote:
>>>>>> On Thu, 14 Feb 2019 14:51:01 +0100 Pierre Morel
>>>>>> <pmorel@linux.ibm.com> wrote:
> 
>>>>>>> -    matrix_dev->device.type = &vfio_ap_dev_type;
>>>>>>> dev_set_name(&matrix_dev->device, "%s", VFIO_AP_DEV_NAME);
>>>>>>> matrix_dev->device.parent = root_device; +
>>>>>>> matrix_dev->device.bus = &matrix_bus; matrix_dev->device.release =
>>>>>>> vfio_ap_matrix_dev_release; -
>>>>>>> matrix_dev->device.driver = &vfio_ap_drv.driver; +
>>>>>>> matrix_dev->vfio_ap_drv = &vfio_ap_drv;
>>>>>>
>>>>>> Can't you get that structure through matrix_dev->device.driver
>>>>>> instead when you need it in the function below?
>>>>>
>>>>> Not anymore. We have two different drivers and devices matrix_drv
>>>>> <-> matrix_dev and vfio_ap_drv <-> ap_devices
>>>>>
>>>>> The driver behind the matrix_dev->dev->driver is matrix_drv what is
>>>>> needed here is vfio_ap_drv.
>>>>
>>>> Wait, we had tacked a driver for ap devices unto a matrix device,
>>>> which is not on the ap bus?
>>
>> It's really a bit more complicated than that. Without going into a
>> lengthy description of the history of AP passthrough support, suffice it
>> to say that we needed a device to serve as the parent of each mediated
>> device used to configure a matrix of AP adapter IDs and domain indexes
>> identifying the devices to which a guest would be granted access. The
>> AP devices themselves are attached to the AP bus, but the matrix device
>> is an artificial (virtual?) device whose sole purpose in life is to
>> serve as an anchor for the mediated devices whose sysfs interfaces are
>> created and managed by the vfio_ap device driver. The matrix device
>> itself is created by the vfio_ap device driver - when it is initialized
>> - for that purpose. In hindsight, maybe there was a better way to
>> implement this, but neither this patch nor this discussion belongs in
>> this series. It distracts from discussion of interrupt support which is
>> the sole purpose of the patch series.
> 
> The we-need-a-parent part is fine; but whatever we're doing with that
> driver just looks wrong, so that even the new bus that basically does
> nothing looks better...

I believe there might be a much better way to handle this which is why
I objected to this patch being delivered with this series, which
provides AP interrupt support. Quite simply, this patch has no
relationship to interrupt support and should be considered as an item
unto itself. To conduct a review within the context of interrupt
support distracts focus from the pertinent subject matter.

> 
>>
>>>
>>> ...yes -(
>>>    
>>>> Maybe that's what trips libudev? >
>>>> (And reading further in the current code, it seems we clear that
>>>> structure _after_ the matrix device had been setup, so how can that
>>>> even work? Where am I confused?)
>>>
>>> On device_register there were no bus, so the core just do not look for a
>>> driver and this field was nor tested nor overwritten.
> 
> Hm... so has the callback in driver_for_each_device() in
> vfio_ap_verify_queue_reserved() ever been invoked at all? It seems this
> patch fixes more than just libudev issues...

It is this patch that rendered the driver_for_each_device() in
vfio_ap_verify_queue_reserved() erroneous. That function gets called
every time an adapter or domain is assigned to the mdev. This patch
introduced the problem with driver_for_each_device().

> 
>>>    
>>>>   
>>>>>   
>>>>>>   
>>>>>>>
>>>>>>> ret = device_register(&matrix_dev->device); if (ret) goto
>>>>>>> matrix_reg_err;
>>>>>>>
>>>>>>> +    ret = driver_register(&matrix_driver.drv); +    if (ret)
>>>>>>> +        goto
>>>>>>> matrix_drv_err; +
>>>>>>
>>>>>> As you already have several structures that can be registered
>>>>>> exactly once (the root device, the bus, the driver, ...), you can
>>>>>> already be sure that there's only one device on the bus, can't
>>>>>> you?
>>>>>
>>>>> hum, no I don't think so, no device can register before this module
>>>>> is loaded, but what does prevent a device to register later from
>>>>> another module?
>>>>
>>>> Not unless you export the interface, I guess.
>>>>   
>>>
>>> :) definitively right
>>> thanks, this will simplify the code in the next version.
>>> I will take the patch away from this series to get the way to stable as
>>> Christian requested.
> 
> Yeah, makes sense.
> 

