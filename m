Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2AAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C411B2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfBVPFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 10:05:22 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52862 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726380AbfBVPFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 10:05:22 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1MF4weL017086
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 10:05:21 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qtkbj8baw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 10:05:17 -0500
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Fri, 22 Feb 2019 15:05:05 -0000
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 22 Feb 2019 15:05:02 -0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1MF4vbc21692504
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Feb 2019 15:04:57 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 27224BE053;
        Fri, 22 Feb 2019 15:04:57 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E992CBE051;
        Fri, 22 Feb 2019 15:04:55 +0000 (GMT)
Received: from [9.60.75.235] (unknown [9.60.75.235])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 22 Feb 2019 15:04:55 +0000 (GMT)
Subject: Re: [PATCH v3 4/9] s390: ap: tools to find a queue with a specific
 APQN
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Pierre Morel <pmorel@linux.ibm.com>, borntraeger@de.ibm.com,
        alex.williamson@redhat.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        frankja@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        freude@linux.ibm.com, mimu@linux.ibm.com
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
 <1550152269-6317-5-git-send-email-pmorel@linux.ibm.com>
 <56f583e7-fb41-ec54-ccf9-585a3e51b1c4@linux.ibm.com>
 <20190218132111.3684b1f1.cohuck@redhat.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Fri, 22 Feb 2019 10:04:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190218132111.3684b1f1.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19022215-8235-0000-0000-00000E639797
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010644; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01164775; UDB=6.00608284; IPR=6.00945363;
 MB=3.00025698; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-22 15:05:04
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022215-8236-0000-0000-000044913A28
Message-Id: <522c48c8-411d-3363-17e1-8b0da0b07cc4@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-22_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=877 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902220106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/19 7:21 AM, Cornelia Huck wrote:
> On Fri, 15 Feb 2019 17:13:21 -0500
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> 
>> On 2/14/19 8:51 AM, Pierre Morel wrote:
>>> We need to find the queue with a specific APQN during the
>>> handling of the interception of the PQAP/AQIC instruction.
>>>
>>> To handle the AP associated device reference count we keep
>>> track of it in the vfio_ap_queue until we put the device.
>>>
>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>> ---
>>>    drivers/s390/crypto/vfio_ap_ops.c     | 54 +++++++++++++++++++++++++++++++++++
>>>    drivers/s390/crypto/vfio_ap_private.h |  1 +
>>>    2 files changed, 55 insertions(+)
> 
>>> +/**
>>> + * vfio_ap_get_queue: Retrieve a queue with a specific APQN
>>> + * @apqn: The queue APQN
>>> + *
>>> + * Retrieve a queue with a specific APQN from the list of the
>>> + * devices associated to the vfio_ap_driver.
>>> + *
>>> + * The vfio_ap_queue has been already associated with the device
>>> + * during the probe.
>>> + * Store the associated device for reference counting
>>> + *
>>> + * Returns the pointer to the associated vfio_ap_queue
>>> + */
>>> +static  __attribute__((unused))
>>> +	struct vfio_ap_queue *vfio_ap_get_queue(int apqn)
>>
>> I think you should change this signature for the reasons I stated
>> below:
>>
>> struct device *vfio_ap_get_queue_dev(int apqn)
>>
>>> +{
>>> +	struct device *dev;
>>> +	struct vfio_ap_queue *q;
>>> +
>>> +	dev = driver_find_device(&matrix_dev->vfio_ap_drv->driver, NULL, &apqn,
>>> +				 vfio_ap_check_apqn);
>>> +	if (!dev)
>>> +		return NULL;
>>> +	q = dev_get_drvdata(dev);
>>> +	q->dev = dev;
>>
>> Why store the device with the vfio_ap_queue object? Why not just return
>> the device. The caller can get the vfio_ap_queue from the device's
>> driver data. It seems the only reason for the 'dev' field is to
>> temporarily hold a ref to the device so it can be put later. Why not
>> just put the device.

After thinking about this further, I question whether we even need
this function if it is going to return 'struct device *'. In that case,
why not just call driver_find_device() when the device is needed?
If you want to keep the function, then the function needs only one 
statement:

	return driver_find_device(...).

> 
> Having looked at the remainder of the patches, I tend to agree that we
> don't really need the backlink; we walk the driver's list of devices in
> any case IIUC.
> 
> We *might* want a mechanism to grab the queue quickly (i.e. without
> walking the list) if there's anything performance sensitive in there;
> but from the patch descriptions, I don't think anything is done in a
> hot path, so it should be fine.
> 

