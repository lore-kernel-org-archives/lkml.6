Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDF1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8441B21B1A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405554AbfBOKKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 05:10:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32902 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728633AbfBOKKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 05:10:54 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1FA9m1Y078304
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 05:10:52 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qnt8skned-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 05:10:52 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Fri, 15 Feb 2019 10:10:50 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 15 Feb 2019 10:10:46 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1FAAi7s8192422
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Feb 2019 10:10:44 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8DE1DA405B;
        Fri, 15 Feb 2019 10:10:44 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DFB65A405C;
        Fri, 15 Feb 2019 10:10:43 +0000 (GMT)
Received: from [9.145.44.11] (unknown [9.145.44.11])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 15 Feb 2019 10:10:43 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v3 4/9] s390: ap: tools to find a queue with a specific
 APQN
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     borntraeger@de.ibm.com, alex.williamson@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
 <1550152269-6317-5-git-send-email-pmorel@linux.ibm.com>
 <20190215104904.5cbe31bb.cohuck@redhat.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Fri, 15 Feb 2019 11:10:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190215104904.5cbe31bb.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19021510-0028-0000-0000-00000348E969
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021510-0029-0000-0000-000024071880
Message-Id: <423e3f5b-dbbe-92b1-cfd3-d5a6f4e38f37@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-15_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902150074
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/02/2019 10:49, Cornelia Huck wrote:
> On Thu, 14 Feb 2019 14:51:04 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> We need to find the queue with a specific APQN during the
>> handling of the interception of the PQAP/AQIC instruction.
>>
>> To handle the AP associated device reference count we keep
>> track of it in the vfio_ap_queue until we put the device.
> 
> So, the relationship is
> (struct ap_device)--(driver_data)-->(struct vfio_ap_queue)--(pointer)-->(struct ap_device)
> ? IOW, a backlink?
> 
> If so, can't you already set that up during probe?

Will do.

> 
> Or am I confused by the various similar devices again? Maybe a diagram
> would help...

No you are right.


> 
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_ops.c     | 54 +++++++++++++++++++++++++++++++++++
>>   drivers/s390/crypto/vfio_ap_private.h |  1 +
>>   2 files changed, 55 insertions(+)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index 900b9cf..2a52c9b 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -24,6 +24,60 @@
>>   #define VFIO_AP_MDEV_TYPE_HWVIRT "passthrough"
>>   #define VFIO_AP_MDEV_NAME_HWVIRT "VFIO AP Passthrough Device"
>>   
>> +/**
>> + * vfio_ap_check_apqn: check if a ap_queue is of a given APQN
>> + *
>> + * Returns 1 if we have a match.
>> + * Otherwise returns 0.
>> + */
>> +static int vfio_ap_check_apqn(struct device *dev, void *data)
>> +{
>> +	struct vfio_ap_queue *q = dev_get_drvdata(dev);
>> +
>> +	return (q->apqn == *(int *)data);
>> +}
>> +
>> +/**
>> + * vfio_ap_get_queue: Retrieve a queue with a specific APQN
>> + * @apqn: The queue APQN
>> + *
>> + * Retrieve a queue with a specific APQN from the list of the
>> + * devices associated to the vfio_ap_driver.
>> + *
>> + * The vfio_ap_queue has been already associated with the device
>> + * during the probe.
>> + * Store the associated device for reference counting
>> + *
>> + * Returns the pointer to the associated vfio_ap_queue
>> + */
>> +static  __attribute__((unused))
> 
> Eww. Can you get rid of that by reordering or squashing patches?

I did this to avoid posting a very big patch.
I will of course squash 4 and 5 with patch 6, when the two patches 4 and 
5 are reviewed.

If you think it brings more clarity to squash all for the next iteration 
I will do.

Regards,
Pierre


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

