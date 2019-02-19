Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21C8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F0462147C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbfBSVb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 16:31:26 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48090 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729140AbfBSVb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 16:31:26 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1JLIu6Z134455
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 16:31:24 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qrs7m1am9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 16:31:23 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Tue, 19 Feb 2019 21:31:22 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 19 Feb 2019 21:31:19 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1JLVIgY24051938
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Feb 2019 21:31:18 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 079F3A405B;
        Tue, 19 Feb 2019 21:31:18 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88284A405F;
        Tue, 19 Feb 2019 21:31:17 +0000 (GMT)
Received: from [9.145.76.69] (unknown [9.145.76.69])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 19 Feb 2019 21:31:17 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v2 1/1] s390: vfio_ap: link the vfio_ap devices to the
 vfio_ap bus subsystem
To:     Tony Krowiak <akrowiak@linux.ibm.com>, borntraeger@de.ibm.com
Cc:     cohuck@redhat.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com
References: <1550513328-12646-1-git-send-email-pmorel@linux.ibm.com>
 <1550513328-12646-2-git-send-email-pmorel@linux.ibm.com>
 <8e6853ba-12ed-a4f3-1263-0e15f715b644@linux.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Tue, 19 Feb 2019 22:31:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <8e6853ba-12ed-a4f3-1263-0e15f715b644@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19021921-0028-0000-0000-0000034A897E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021921-0029-0000-0000-00002408C6C2
Message-Id: <6cc5b478-4678-9a82-b902-cc9aed22becf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-19_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902190149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/02/2019 19:52, Tony Krowiak wrote:
> On 2/18/19 1:08 PM, Pierre Morel wrote:
>> Libudev relies on having a subsystem link for non-root devices. To
>> avoid libudev (and potentially other userspace tools) choking on the
>> matrix device let us introduce a vfio_ap bus and with that the vfio_ap
>> bus subsytem, and make the matrix device reside within it.
>>
>> Doing this we need to suppress the forced link from the matrix device to
>> the vfio_ap driver and we suppress the device_type we do not need
>> anymore.
>>
>> Since the associated matrix driver is not the vfio_ap driver any more,
>> we have to change the search for the devices on the vfio_ap driver in
>> the function vfio_ap_verify_queue_reserved.
>>
>> Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
>> Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_drv.c     | 48 
>> +++++++++++++++++++++++++++++------
>>   drivers/s390/crypto/vfio_ap_ops.c     |  4 +--
>>   drivers/s390/crypto/vfio_ap_private.h |  1 +
>>   3 files changed, 43 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_drv.c 
>> b/drivers/s390/crypto/vfio_ap_drv.c
>> index 31c6c84..8e45559 100644
>> --- a/drivers/s390/crypto/vfio_ap_drv.c
>> +++ b/drivers/s390/crypto/vfio_ap_drv.c
>> @@ -24,10 +24,6 @@ MODULE_LICENSE("GPL v2");
>>   static struct ap_driver vfio_ap_drv;
>> -static struct device_type vfio_ap_dev_type = {
>> -    .name = VFIO_AP_DEV_TYPE_NAME,
>> -};
>> -
>>   struct ap_matrix_dev *matrix_dev;
>>   /* Only type 10 adapters (CEX4 and later) are supported
>> @@ -62,6 +58,27 @@ static void vfio_ap_matrix_dev_release(struct 
>> device *dev)
>>       kfree(matrix_dev);
>>   }
>> +static int matrix_bus_match(struct device *dev, struct device_driver 
>> *drv)
>> +{
>> +    return 1;
> 
> I think we should verify the following:
> 
> * dev == matrix_dev->device
> * drv == &matrix_driver
> 
> The model employed is for the matrix device to be a singleton, so I
> think we should verify that the matrix device and driver defined herein
> ought to be the only possible choices for a match. Of course, doing so
> will require some restructuring of this patch.

I think Conny already answered this question.

> 
>> +}
>> +
>> +static struct bus_type matrix_bus = {
>> +    .name = "vfio_ap",
>> +    .match = &matrix_bus_match,
>> +};
>> +
>> +static int matrix_probe(struct device *dev)
>> +{
>> +    return 0;
>> +}
>> +
>> +static struct device_driver matrix_driver = {
>> +    .name = "vfio_ap",
> 
> This is the same name used for the original device driver. I think
> this driver ought to have a different name to avoid confusion.
> How about vfio_ap_matrix or some other name to differentiate the
> two.

I would like too, but changing this will change the path to the mediated 
device supported type.


> 
>> +    .bus = &matrix_bus,
>> +    .probe = matrix_probe,
> 
> I would add:
>      .suppress_bind_attrs = true;
> 
> This will remove the sysfs bind/unbind interfaces. Since there is only
> one matrix device and it's lifecycle is controlled herein, there is no
> sense in allowing a root user to bind/unbind it.
> 

OTOH bind/unbind has no impact.
If no one else ask for this I will not change what has already been 
reviewed by Conny and Christian.

Regards,
Pierre


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

