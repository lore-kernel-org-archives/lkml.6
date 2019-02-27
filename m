Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57282C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20E322147C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:29:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbfB0J3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 04:29:21 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35084 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726346AbfB0J3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 04:29:21 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1R9IiB2059640
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 04:29:20 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qwqe6snw2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 04:29:20 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Wed, 27 Feb 2019 09:29:17 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 27 Feb 2019 09:29:15 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1R9TD7045350956
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Feb 2019 09:29:13 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 998A4A405D;
        Wed, 27 Feb 2019 09:29:13 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D44BA4051;
        Wed, 27 Feb 2019 09:29:13 +0000 (GMT)
Received: from [9.152.224.140] (unknown [9.152.224.140])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 27 Feb 2019 09:29:12 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v4 3/7] s390: ap: associate a ap_vfio_queue and a matrix
 mdev
To:     Tony Krowiak <akrowiak@linux.ibm.com>, borntraeger@de.ibm.com
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com,
        david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
References: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
 <1550849400-27152-4-git-send-email-pmorel@linux.ibm.com>
 <0c109cf1-c5f0-9a8b-7729-2ce8bbe1dedd@linux.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Wed, 27 Feb 2019 10:29:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <0c109cf1-c5f0-9a8b-7729-2ce8bbe1dedd@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19022709-0028-0000-0000-0000034D968E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022709-0029-0000-0000-0000240BECF2
Message-Id: <d46abd0d-d365-299e-0ca7-8bae13e440d6@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-27_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902270063
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/02/2019 19:14, Tony Krowiak wrote:
> On 2/22/19 10:29 AM, Pierre Morel wrote:
>> We need to associate the ap_vfio_queue, which will hold the
>> per queue information for interrupt with a matrix mediated device
>> which hold the configuration and the way to the CRYCB.
>>
>> Let's do this when assigning a APID or a APQI to the mediated device
>> and clear the relation when unassigning.
>>
>> Queuing the devices on a list of free devices and testing the
>> matrix_mdev pointer to the associated matrix allow us to know
>> if the queue is associated to the matrix device and associated
>> or not to a mediated device.
>>
>> When resetting an AP queue we must wait until there are no more
>> messages in the message queue before considering the queue is really
>> in a clean state.
>>
>> Let's do it and wait until the status response code indicate the
>> queue is empty after issuing a PAPQ/ZAPQ instruction.
>>
>> Being at work on the reset function, let's simplify
>> vfio_ap_mdev_reset_queue and vfio_ap_mdev_reset_queues by using the
>> vfio_ap_queue structure as parameter.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_ops.c | 385 
>> +++++++++++++++++++-------------------
>>   1 file changed, 189 insertions(+), 196 deletions(-)

...snip...

>> +static int vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q)
>> +{
>> +    struct ap_queue_status status;
>> +    int retry = 20;
>> +
>> +    do {
>> +        status = ap_zapq(q->apqn);
>> +        switch (status.response_code) {
>> +        case AP_RESPONSE_NORMAL:
>> +            while (!status.queue_empty && retry--) {
>> +                msleep(20);
>> +                status = ap_tapq(q->apqn, NULL);
>> +            }
> 
> I am not sure the above is necessary. I have an email out to the author
> of the architecture doc to verify.

I do not know the question you asked but the documentation is very clear 
on the reset behavior: a queue is completely reseted only after the RC 
of reset/zapq is 0 and the queue_empty bit is set.

> 
>> +            if (retry <= 0)
>> +                pr_warn("%s: queue 0x%04x not empty\n",

...snip...

>> + * @matrix_mdev: the matrix mediated device for which we want to 
>> associate
>> + *         all available queues with a given apqi.
>> + * @apid:     The apid which associated with all defined APQI of the
>> + *         mediated device will define a AP queue.
>>    *
>> - * - If @data contains only an apid value, @data will be flagged as
>> - *   reserved if the APID field in the AP queue device matches
>> - *
>> - * - If @data contains only an apqi value, @data will be flagged as
>> - *   reserved if the APQI field in the AP queue device matches
>> - *
>> - * Returns 0 to indicate the input to function succeeded. Returns 
>> -EINVAL if
>> - * @data does not contain either an apid or apqi.
>> + * We remove the queue from the list of queues associated with the
>> + * mediated device and put them back to the free list of the matrix
>> + * device and clear the matrix_mdev pointer.
>>    */
>> -static int vfio_ap_has_queue(struct device *dev, void *data)
>> +static void vfio_ap_put_all_domains(struct ap_matrix_mdev *matrix_mdev,
>> +                    int apid)
> 
> I would prefer this be named:
> 
>      vfio_ap_mdev_free_queues_with_apid()
> 
> get/put is typically used to increment/decrement reference counters.
> What you are doing in this function freeing all queues connected to 
> specified card.

OK, I can change this function name and the further one you mentioned.

> 
>>   {
>> -    struct vfio_ap_queue_reserved *qres = data;
>> -    struct ap_queue *ap_queue = to_ap_queue(dev);
>> -    ap_qid_t qid;
>> -    unsigned long id;
>> +    int apqi, apqn;
>> -    if (qres->apid && qres->apqi) {
>> -        qid = AP_MKQID(*qres->apid, *qres->apqi);
>> -        if (qid == ap_queue->qid)
>> -            qres->reserved = true;
>> -    } else if (qres->apid && !qres->apqi) {
>> -        id = AP_QID_CARD(ap_queue->qid);
>> -        if (id == *qres->apid)
>> -            qres->reserved = true;
>> -    } else if (!qres->apid && qres->apqi) {
>> -        id = AP_QID_QUEUE(ap_queue->qid);
>> -        if (id == *qres->apqi)
>> -            qres->reserved = true;
>> -    } else {
>> -        return -EINVAL;
>> +    for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm, AP_DOMAINS) {
>> +        apqn = AP_MKQID(apid, apqi);
>> +        vfio_ap_free_queue(apqn, matrix_mdev);
>>       }
> 
> Maybe you should clear the bit corresponding to apid from the APM here?

I do not think so, this is pure list handling, the APM bit is already 
cleared in the unassign_adapter_store function.

I only answered once for all comments on naming and bit mask but will 
treat them the same way.
Thanks for comments.

Regards,
Pierre



-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

