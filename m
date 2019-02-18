Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF7BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3780221773
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbfBRSgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 13:36:32 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38358 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725730AbfBRSgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 13:36:32 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1IITGQK033259
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 13:36:30 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qr1ty8vmt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 13:36:30 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Mon, 18 Feb 2019 18:36:28 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 18 Feb 2019 18:36:25 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1IIaOsh25690364
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 Feb 2019 18:36:24 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA62E11C054;
        Mon, 18 Feb 2019 18:36:23 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 60BE311C04A;
        Mon, 18 Feb 2019 18:36:23 +0000 (GMT)
Received: from [9.145.70.2] (unknown [9.145.70.2])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 18 Feb 2019 18:36:23 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v3 5/9] s390: ap: tools to associate a queue to a matrix
To:     Tony Krowiak <akrowiak@linux.ibm.com>, borntraeger@de.ibm.com
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com,
        david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
 <1550152269-6317-6-git-send-email-pmorel@linux.ibm.com>
 <061c4900-03fa-8320-c3a0-c832ccd152aa@linux.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Mon, 18 Feb 2019 19:36:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <061c4900-03fa-8320-c3a0-c832ccd152aa@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19021818-0016-0000-0000-00000257E672
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021818-0017-0000-0000-000032B22789
Message-Id: <fde260b9-6a99-5d13-2dcc-a0ef2782f559@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-18_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902180137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/02/2019 23:30, Tony Krowiak wrote:
> On 2/14/19 8:51 AM, Pierre Morel wrote:
>> We need tools to associate a queue and a matrix to be able
>> later to find the matrix associated with the queue for which
>> we got the APQN in the register 1 during a PQAP/AQIC instruction
>> interception.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_ops.c     | 66 
>> +++++++++++++++++++++++++++++++++--
>>   drivers/s390/crypto/vfio_ap_private.h |  1 +
>>   2 files changed, 64 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c 
>> b/drivers/s390/crypto/vfio_ap_ops.c
>> index 2a52c9b..1851b24 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -50,8 +50,7 @@ static int vfio_ap_check_apqn(struct device *dev, 
>> void *data)
>>    *
>>    * Returns the pointer to the associated vfio_ap_queue
>>    */
>> -static  __attribute__((unused))
>> -    struct vfio_ap_queue *vfio_ap_get_queue(int apqn)
> 
> I don't like this, it indicates to me that this and the previous
> patch should have been squashed together. I realize your intent
> was to make the patches smaller, but I don't think this makes it
> any easier to review them. In fact, it makes it harder IMHO, because
> you have to flip back and forth between patches to fully comprehend
> the usage.
> 
>> +static struct vfio_ap_queue *vfio_ap_get_queue(int apqn)
>>   {
>>       struct device *dev;
>>       struct vfio_ap_queue *q;
>> @@ -72,7 +71,7 @@ static  __attribute__((unused))
>>    * put the associated device
>>    *
>>    */
>> -static  __attribute__((unused)) void vfio_ap_put_queue(struct 
>> vfio_ap_queue *q)
> 
> Ditto for this.
> 
>> +static void vfio_ap_put_queue(struct vfio_ap_queue *q)
>>   {
>>       put_device(q->dev);
>>       q->dev = NULL;
>> @@ -867,6 +866,67 @@ static int vfio_ap_mdev_reset_queue(unsigned int 
>> apid, unsigned int apqi,
>>       return -EBUSY;
>>   }
>> +/**
>> + * vfio_ap_dissociate_queues: Dissociate a matrix mediated device to 
>> a queue
>> + *
>> + * Go through all bits in the AQM and APM and dissociate the queue
>> + * from the matrix device.
>> + *
>> + * No return value we are throwing the mediated device anyway.
>> + */
>> +static void vfio_ap_dissociate_queues(struct ap_matrix_mdev 
>> *matrix_mdev)
>> +{
>> +    unsigned long apid, apqi;
> 
> The changes I recommend here are based on the comments in my
> response to patch 4.
> 
>> +    struct vfio_ap_queue *q;
> 
> Add this:
> 
>      struct device *qdev;
> 
>> +
>> +    for_each_set_bit_inv(apid, matrix_mdev->matrix.apm,
>> +                 matrix_mdev->matrix.apm_max + 1) {
>> +        for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm,
>> +                     matrix_mdev->matrix.aqm_max + 1) {
>> +            q = vfio_ap_get_queue(AP_MKQID(apid, apqi));
> 
> Replace with:
>      qdev = vfio_ap_get_queue_dev(AP_MKQID(apid, apqi);
> 
>> +            if (q) {
> 
> Replace with:
>      if (qdev) {
> 
> Add this:
>      q = dev_get_drvdata(qdev);
> 
>> +                vfio_ap_mdev_reset_queue(apid, apqi, 1);
>> +                q->matrix = NULL;
>> +                vfio_ap_put_queue(q);
> 
> Replace with:
>      put_device(qdev)
> 
>> +            } else
>> +                pr_err("%s: no queue for %02lx.%04lx\n",
>> +                       __func__, apid, apqi);
>> +        }
>> +    }
>> +}
>> +
>> +/**
>> + * vfio_ap_associate_queues: Associate a matrix mediated device to a 
>> queue
>> + *
>> + * Go through all bits in the AQM and APM and calculate the APQN, and 
>> find
>> + * the matching queue to associate with the matrix device.
>> + *
>> + * In the case a queue could not be found return -ENODEV.
>> + * Otherwise return 0.
>> + */
>> +static __attribute__((unused))
> 
> This indicates this patch should be squashed with the patch that
> introduces this function. Why have a patch that introduces a function
> that is not used and put and artificially specify an attribute just to
> keep the compiler from issuing a warning?

Seems to be a majority for this so... will do.

> 
>> +    int vfio_ap_associate_queues(struct ap_matrix_mdev *matrix_mdev)
>> +{
> 
> The same as above, the changes I recommend here are based on the
> comments in my response to patch 4.
> 
... will do

>> +    pr_err("%s: no queue for %02lx.%04lx\n", __func__, apid, apqi);
>> +    vfio_ap_dissociate_queues(matrix_mdev);
>> +    return -ENODEV;
>> +}
>>   static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev)
>>   {
>>       int ret;
>> diff --git a/drivers/s390/crypto/vfio_ap_private.h 
>> b/drivers/s390/crypto/vfio_ap_private.h
>> index 081f0d7..10bc8b5 100644
>> --- a/drivers/s390/crypto/vfio_ap_private.h
>> +++ b/drivers/s390/crypto/vfio_ap_private.h
>> @@ -89,5 +89,6 @@ extern void vfio_ap_mdev_unregister(void);
>>   struct vfio_ap_queue {
>>       struct device *dev;
>>       int    apqn;
>> +    struct ap_matrix_mdev *matrix;
> 
> Can you rename this variable matrix_mdev?
> * That is how struct ap_matrix_mdev vars are named everywhere else
> * It prevents confusing it with naming of vars for struct ap_matrix.

Sorry, I did this but it seems to have been forgotten in a rebase.
Will do.

> 
>>   };
>>   #endif /* _VFIO_AP_PRIVATE_H_ */
>>
> 


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

