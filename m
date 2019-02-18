Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B49CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3736E217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbfBRScl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 13:32:41 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45752 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726235AbfBRSck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 13:32:40 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1IITJ7q018544
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 13:32:39 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qqxynj0ub-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 13:32:39 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Mon, 18 Feb 2019 18:32:36 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 18 Feb 2019 18:32:32 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1IIWVNT59834440
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 Feb 2019 18:32:31 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47FB511C04C;
        Mon, 18 Feb 2019 18:32:31 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9FF6E11C058;
        Mon, 18 Feb 2019 18:32:30 +0000 (GMT)
Received: from [9.145.70.2] (unknown [9.145.70.2])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 18 Feb 2019 18:32:30 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v3 4/9] s390: ap: tools to find a queue with a specific
 APQN
To:     Cornelia Huck <cohuck@redhat.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     borntraeger@de.ibm.com, alex.williamson@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com,
        david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
 <1550152269-6317-5-git-send-email-pmorel@linux.ibm.com>
 <56f583e7-fb41-ec54-ccf9-585a3e51b1c4@linux.ibm.com>
 <20190218132111.3684b1f1.cohuck@redhat.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Mon, 18 Feb 2019 19:32:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190218132111.3684b1f1.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19021818-0012-0000-0000-000002F72D87
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021818-0013-0000-0000-0000212EB7C1
Message-Id: <e01e890e-3eea-de72-a1ae-bd8d761db7e3@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-18_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=852 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902180137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/02/2019 13:21, Cornelia Huck wrote:
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

OK you are right, I ll drop it


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

