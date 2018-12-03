Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977D5C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EC5120851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:21:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EC5120851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbeLCKVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:21:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52042 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726139AbeLCKVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:21:24 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wB3AJ0Wh135232
        for <linux-kernel@vger.kernel.org>; Mon, 3 Dec 2018 05:20:58 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p51654rmc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 05:20:58 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Mon, 3 Dec 2018 10:20:56 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 3 Dec 2018 10:20:53 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wB3AKqsp17105138
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 3 Dec 2018 10:20:52 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E135B52052;
        Mon,  3 Dec 2018 10:20:51 +0000 (GMT)
Received: from [9.145.178.193] (unknown [9.145.178.193])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id E2CB452051;
        Mon,  3 Dec 2018 10:20:37 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v2 3/3] vfio: ap: AP Queue Interrupt Control VFIO ioctl
 calls
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     borntraeger@de.ibm.com, alex.williamson@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
References: <1542906675-7949-1-git-send-email-pmorel@linux.ibm.com>
 <1542906675-7949-4-git-send-email-pmorel@linux.ibm.com>
 <20181203110422.4d069a8c.cohuck@redhat.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Mon, 3 Dec 2018 11:20:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181203110422.4d069a8c.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18120310-0012-0000-0000-000002D3C425
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120310-0013-0000-0000-0000210919BF
Message-Id: <0119edfa-2feb-03f6-e082-e3773f4e42e2@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-03_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812030100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/2018 11:04, Cornelia Huck wrote:
> On Thu, 22 Nov 2018 18:11:15 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> This is the implementation of the VFIO ioctl calls to handle
>> the AQIC interception and use GISA to handle interrupts.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_ops.c | 110 +++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 109 insertions(+), 1 deletion(-)
>>
> 
>> +static int vfio_ap_ioctl_setirq(struct mdev_device *mdev, unsigned long arg)
>> +{
>> +	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>> +	struct vfio_ap_aqic parm;
>> +	struct ap_qirq_ctrl aqic_gisa = {};
>> +	struct kvm *kvm = matrix_mdev->kvm;
>> +	struct kvm_s390_gisa *gisa = kvm->arch.gisa;
>> +	struct ap_queue_status ap_status;
>> +	unsigned long nib;
>> +
>> +	if (copy_from_user(&parm, (void __user *)arg, sizeof(parm)))
>> +		return -EFAULT;
>> +
>> +	if (parm.isc > MAX_ISC)
>> +		return -EINVAL;
>> +
>> +	if (kvm->vcpus[0]->arch.sie_block->gd & 0x01)
>> +		aqic_gisa.gf = 1;
>> +
>> +	nib = vfio_ap_get_nib(kvm, &parm);
>> +	if (!nib)
>> +		return -ENODEV;
>> +
>> +	aqic_gisa.gisc = parm.isc;
>> +	aqic_gisa.isc = kvm_s390_gisc_register(kvm, parm.isc);
> 
> Oh, and as I just looked at the callers of these functions: You'll want
> to check the return code here, even though the function should not fail
> with the checking you did beforehand.
> 

I should check.

> [I assume you'll have similar code even when using a different
> interface.]

Yes.


> 
>> +	aqic_gisa.ir = 1;
>> +	aqic_gisa.gisa = gisa->next_alert >> 4;
>> +
>> +	ap_status = ap_aqic(parm.apqn, aqic_gisa, (void *)nib);
>> +	parm.status = *(uint32_t *)(&ap_status);
>> +
>> +	if (copy_to_user((void __user *)arg, &parm, sizeof(parm))) {
>> +		kvm_s390_gisc_unregister(kvm, parm.isc);
>> +		return -EFAULT;
>> +	}
>> +
>> +	if (ap_status.response_code) {
>> +		kvm_s390_gisc_unregister(kvm, parm.isc);
>> +		return -EIO;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int vfio_ap_ioctl_clrirq(struct mdev_device *mdev, unsigned long arg)
>> +{
>> +	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>> +	struct vfio_ap_aqic parm;
>> +	struct ap_qirq_ctrl aqic_gisa = {};
>> +	struct ap_queue_status ap_status;
>> +	struct kvm *kvm = matrix_mdev->kvm;
>> +
>> +	if (copy_from_user(&parm, (void __user *)arg, sizeof(parm)))
>> +		return -EFAULT;
>> +
>> +	if (kvm->vcpus[0]->arch.sie_block->gd & 0x01)
>> +		aqic_gisa.gf = 1;
>> +	aqic_gisa.ir = 0;
>> +
>> +	ap_status = ap_aqic(parm.apqn, aqic_gisa, NULL);
>> +	parm.status = *(uint32_t *)(&ap_status);
>> +
>> +	kvm_s390_gisc_unregister(kvm, parm.isc);
> 
> Here, you don't seem to verify the sanity of parm.isc beforehand...
> luckily the function can deal with that :)

You are right.
Anyway I will change this, because this relies on user's code which is 
not right.


> 
>> +
>> +	if (copy_to_user((void __user *)arg, &parm, sizeof(parm)))
>> +		return -EFAULT;
>> +
>> +	return (ap_status.response_code) ? -EIO : 0;
>> +}
>> +
> 


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

