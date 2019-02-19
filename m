Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343AFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 017032147C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbfBSVeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 16:34:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36706 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727206AbfBSVeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 16:34:14 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1JLYAIA152828
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 16:34:12 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qrs761fhe-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 16:34:08 -0500
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Tue, 19 Feb 2019 21:34:06 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 19 Feb 2019 21:34:04 -0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1JLY0R123330996
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Feb 2019 21:34:00 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 372D2AE05F;
        Tue, 19 Feb 2019 21:34:00 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA980AE05C;
        Tue, 19 Feb 2019 21:33:59 +0000 (GMT)
Received: from [9.60.75.235] (unknown [9.60.75.235])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 19 Feb 2019 21:33:59 +0000 (GMT)
Subject: Re: [PATCH v3 6/9] vfio: ap: register IOMMU VFIO notifier
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Pierre Morel <pmorel@linux.ibm.com>, borntraeger@de.ibm.com,
        alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        freude@linux.ibm.com, mimu@linux.ibm.com
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
 <1550152269-6317-7-git-send-email-pmorel@linux.ibm.com>
 <3ce0a3a0-22fb-c418-321d-7e6e3af5b66c@linux.ibm.com>
 <20190219105946.29e510a6@oc2783563651>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Tue, 19 Feb 2019 16:33:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190219105946.29e510a6@oc2783563651>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19021921-2213-0000-0000-000003547517
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010628; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01163473; UDB=6.00607498; IPR=6.00944055;
 MB=3.00025661; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-19 21:34:05
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021921-2214-0000-0000-00005D68F5C6
Message-Id: <ef8ac760-8da9-6f79-ac26-933d998f4c3a@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-19_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902190150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/19/19 4:59 AM, Halil Pasic wrote:
> On Fri, 15 Feb 2019 17:55:35 -0500
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> 
>> On 2/14/19 8:51 AM, Pierre Morel wrote:
>>> To be able to use the VFIO interface to facilitate the
>>> mediated device memory pining/unpining we need to register
>>> a notifier for IOMMU.
>>>
>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>> ---
>>>    drivers/s390/crypto/vfio_ap_ops.c     | 64 +++++++++++++++++++++++++++++++----
>>>    drivers/s390/crypto/vfio_ap_private.h |  2 ++
>>>    2 files changed, 60 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>>> index 1851b24..6eddc2c 100644
>>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> 
> [..]
>    	struct vfio_ap_queue *q;
>>> @@ -967,12 +996,32 @@ static int vfio_ap_mdev_open(struct mdev_device *mdev)
>>>    
>>>    	ret = vfio_register_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
>>>    				     &events, &matrix_mdev->group_notifier);
>>> -	if (ret) {
>>> -		module_put(THIS_MODULE);
>>> -		return ret;
>>> -	}
>>> +	if (ret)
>>> +		goto err_group;
>>> +
>>> +	matrix_mdev->iommu_notifier.notifier_call = vfio_ap_mdev_iommu_notifier;
>>> +	events = VFIO_IOMMU_NOTIFY_DMA_UNMAP;
>>> +
>>> +	ret = vfio_register_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
>>> +				     &events, &matrix_mdev->iommu_notifier);
>>> +	if (ret)
>>> +		goto err_iommu;
>>> +
>>> +	ret = vfio_ap_associate_queues(matrix_mdev);
>>> +	if (ret)
>>> +		goto err_associate;
>>
>> I think the matrix_mdev should be associated with queues when an
>> assignment of an adapter or domain is made to the mdev device via its
>> sysfs interfaces. I say this because assigning an adapter or domain to
>> an mdev device effectively grants ownership of any additional AP queues
>> added to the mdev device's AP matrix as a result of the assignment. It
>> only makes sense to assign ownership to the vfio_ap_queue objects
>> representing the queues at that time. If an adapter or domain is
>> dynamically assigned while a guest is using the affected queues, then
>> the associations will have to be made at that time and this code will
>> likely go bye bye.
>>
> 
> 
> Actually, we need the stuff in vfio_ap_queues only if the guest is
> offered to  decides to use AP adaper interrupts. I would prefer to have
> it around only when needed: as long as we have the nib pinned for any
> given queue. Is there a reason why not to do so?

Even if we keep the vfio_ap_queue around for the life of a guest,
association/dissociation will have to be done when an adapter or domain
is dynamically assigned.

> 
> Regards,
> Halil
>   
> [..]
> 

