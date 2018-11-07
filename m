Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B59C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D8B42086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:40:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D8B42086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbeKHINT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 03:13:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42946 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727694AbeKHINS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 03:13:18 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA7MYOs7058004
        for <linux-kernel@vger.kernel.org>; Wed, 7 Nov 2018 17:40:49 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nm7q7k3qu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 17:40:48 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Wed, 7 Nov 2018 22:40:46 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 7 Nov 2018 22:40:44 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA7Meh2861604070
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 7 Nov 2018 22:40:43 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 125F642041;
        Wed,  7 Nov 2018 22:40:43 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 71B4B42047;
        Wed,  7 Nov 2018 22:40:42 +0000 (GMT)
Received: from [9.145.168.249] (unknown [9.145.168.249])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  7 Nov 2018 22:40:42 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v1 6/7] vfio: ap: register guest ISC with GISA and GIB
To:     Tony Krowiak <akrowiak@linux.ibm.com>, borntraeger@de.ibm.com
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com,
        david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
References: <1541009577-29656-1-git-send-email-pmorel@linux.ibm.com>
 <1541009577-29656-7-git-send-email-pmorel@linux.ibm.com>
 <382fe325-e12d-8be8-7f30-c3c64bd37505@linux.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Wed, 7 Nov 2018 23:40:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <382fe325-e12d-8be8-7f30-c3c64bd37505@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18110722-0016-0000-0000-00000222C9BA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110722-0017-0000-0000-0000327B1ADA
Message-Id: <5a1f9900-e90a-541d-7801-e7fcfd9f48a3@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-07_18:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811070200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/11/2018 21:21, Tony Krowiak wrote:
> On 10/31/18 2:12 PM, Pierre Morel wrote:
>> Register to the GIB Alert list and retrieve the GAL_ISC
>> to pass to the GISA registration.
>>
>> Unregister on error and when clearing the interrupt.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_ops.c | 16 +++++++++++++---
>>   1 file changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c 
>> b/drivers/s390/crypto/vfio_ap_ops.c
>> index f68102163bf4..232168797fb8 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -903,16 +903,20 @@ static int ap_ioctl_setirq(struct ap_matrix_mdev 
>> *matrix_mdev,
>>       struct ap_status ap_status = reg2status(0);
>>       unsigned long p;
>>       int ret = -1;
>> -    int apqn;
>> +    int apqn, gal_isc;
>>       uint32_t gd;
>> +    gal_isc = kvm_s390_gisc_register(matrix_mdev->kvm, 
>> matrix_mdev->gisc);
>> +    if (gal_isc < 0)
>> +        return -EIO;
>> +
>>       apqn = (int)(parm->cmd & 0xffff);
>>       gd = matrix_mdev->kvm->vcpus[0]->arch.sie_block->gd;
>>       if (gd & 0x01)
>>           aqic_gisa.f = 1;
>>       aqic_gisa.gisc = matrix_mdev->gisc;
>> -    aqic_gisa.isc = GAL_ISC;
>> +    aqic_gisa.isc = gal_isc;
>>       aqic_gisa.ir = 1;
>>       aqic_gisa.gisao = gisa->next_alert >> 4;
>> @@ -923,7 +927,11 @@ static int ap_ioctl_setirq(struct ap_matrix_mdev 
>> *matrix_mdev,
>>       parm->status = ret;
>>       ap_status = reg2status(ret);
>> -    return (ap_status.rc) ? -EIO : 0;
>> +    if (ap_status.rc) {
>> +        kvm_s390_gisc_unregister(matrix_mdev->kvm, matrix_mdev->gisc);
>> +        return -EIO;
>> +    }
>> +    return 0;
>>   }
>>   static int ap_ioctl_clrirq(struct ap_matrix_mdev *matrix_mdev,
>> @@ -946,6 +954,8 @@ static int ap_ioctl_clrirq(struct ap_matrix_mdev 
>> *matrix_mdev,
>>       parm->status = retval;
>>       ap_status = reg2status(retval);
>> +    /* unregister the IAM from the GIB anyway! */
>> +    kvm_s390_gisc_unregister(matrix_mdev->kvm, matrix_mdev->gisc);
> 
> The case statement in patch 4 does not set mdev->gisc, so the
> presumption here is that VFIO_AP_SET_IRQ has been previously called and
> has set the value for matrix_mdev->gisc. Is it possible for
> VFIO_AP_CLEAR_IRQ to get invoked without a prior call to

right, I will check this.

However if the IRQ is not registered there is no problem as we will get 
an error when unregistering the IRQ
and unregistering the gisc 0 which was not registered will fail too.

But I think we better check before in case these functions change.

> VFIO_AP_SET_IRQ? In any case, shouldn't the GISC value be taken from
> bits 61-63 of 'parm'?

No this is not possible, the ISC field is not relevant when clearing 
interrupts.

> 
>>       return (ap_status.rc) ? -EIO : 0;
>>   }
>>
> 


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

