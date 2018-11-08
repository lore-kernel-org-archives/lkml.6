Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC49ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D386020684
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:00:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D386020684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbeKIDh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 22:37:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55149 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727155AbeKIDhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 22:37:25 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA8Hx7hj124074
        for <linux-kernel@vger.kernel.org>; Thu, 8 Nov 2018 13:00:47 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nmqb1r7he-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 13:00:46 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 8 Nov 2018 18:00:43 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 8 Nov 2018 18:00:40 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA8I0cUI34865354
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 8 Nov 2018 18:00:38 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF63011C05C;
        Thu,  8 Nov 2018 18:00:38 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1116811C04A;
        Thu,  8 Nov 2018 18:00:38 +0000 (GMT)
Received: from [9.145.183.4] (unknown [9.145.183.4])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  8 Nov 2018 18:00:37 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v1 4/7] vfio: ap: AP Queue Interrupt Control VFIO ioctl
 calls
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     borntraeger@de.ibm.com, alex.williamson@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
References: <1541009577-29656-1-git-send-email-pmorel@linux.ibm.com>
 <1541009577-29656-5-git-send-email-pmorel@linux.ibm.com>
 <20181107104624.36707cca.cohuck@redhat.com>
 <97094e1c-f74c-7b90-8439-5177301d3189@linux.ibm.com>
 <20181108101435.023e835d.cohuck@redhat.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Thu, 8 Nov 2018 19:00:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181108101435.023e835d.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18110818-0016-0000-0000-000002234D8F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110818-0017-0000-0000-0000327BA3B6
Message-Id: <29392872-d8a0-3ddd-77fe-342202ed1d2a@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-08_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811080152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/2018 10:14, Cornelia Huck wrote:
> On Wed, 7 Nov 2018 23:23:40 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> On 07/11/2018 10:46, Cornelia Huck wrote:
>>> On Wed, 31 Oct 2018 19:12:54 +0100
>>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>>    
>>>> This is the implementation of the VFIO ioctl calls to handle
>>>> the AQIC interception and use GISA to handle interrupts.
>>>>
>>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>>> ---
>>>>    drivers/s390/crypto/vfio_ap_ops.c | 95 +++++++++++++++++++++++++++++++
>>>>    1 file changed, 95 insertions(+)
>>>>
>>>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>>>> index 272ef427dcc0..f68102163bf4 100644
>>>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>>>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>>>> @@ -895,12 +895,107 @@ static int vfio_ap_mdev_get_device_info(unsigned long arg)
>>>>    	return copy_to_user((void __user *)arg, &info, minsz);
>>>>    }
>>>>    
>>>> +static int ap_ioctl_setirq(struct ap_matrix_mdev *matrix_mdev,
>>>> +			   struct vfio_ap_aqic *parm)
>>>> +{
>>>> +	struct aqic_gisa aqic_gisa = reg2aqic(0);
>>>> +	struct kvm_s390_gisa *gisa = matrix_mdev->kvm->arch.gisa;
>>>> +	struct ap_status ap_status = reg2status(0);
>>>> +	unsigned long p;
>>>> +	int ret = -1;
>>>> +	int apqn;
>>>> +	uint32_t gd;
>>>> +
>>>> +	apqn = (int)(parm->cmd & 0xffff);
>>>
>>> It seems you always use cmd & 0xffff only. What if there is other stuff
>>> in the remaining bits of cmd? Do you plan to ignore it in any case, or
>>> should you actively check that there is nothing in it?
>>>    
>>
>> I do not think that the ioctl interface should reflect the hardware
>> interface.
>> The ioctl interface ignores the remaining bits.
>> We ignore the FC because we obviously want to make a AQIC FC=3
>> We ignore the T bit.
>>
>> But we receive the information from the intercepting software, i.e. QEMU
>> which should I think do the checks before using the ioctl interface.
> 
> Yes, it should; but you still can't know whether it actually did...

I do not care, I just ignore these bits.

> 
>>
>> It seemed easier to me to pass the complete registers and to ignore some
>> bits in them. In case we get any change in the future
>> But we could also only pass the APQN
> 
> I'd prefer to use a well-defined structure that explicitly handles the
> userspace<->kernel communication. Not that we start relying on implicit
> assumptions and then things break when userspace does something
> different...
> 

OK, I can pass a u16 in the ioctl parameters and explicitly reserve the 
ignored bits.

Thanks for the review.

Regards,
Pierre

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

