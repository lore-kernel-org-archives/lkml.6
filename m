Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4CDC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB2720859
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730732AbfAIMO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 07:14:28 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44978 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730702AbfAIMO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 07:14:27 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x09CBfDR055530
        for <linux-kernel@vger.kernel.org>; Wed, 9 Jan 2019 07:14:26 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pwdgh1d7u-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 07:14:25 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Wed, 9 Jan 2019 12:14:23 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Jan 2019 12:14:19 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x09CEIl94587818
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jan 2019 12:14:18 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 40DA242041;
        Wed,  9 Jan 2019 12:14:18 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C784B42042;
        Wed,  9 Jan 2019 12:14:17 +0000 (GMT)
Received: from [9.152.224.140] (unknown [9.152.224.140])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Jan 2019 12:14:17 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v5 13/15] KVM: s390: add function process_gib_alert_list()
To:     mimu@linux.ibm.com, Halil Pasic <pasic@linux.ibm.com>
Cc:     KVM Mailing List <kvm@vger.kernel.org>,
        Linux-S390 Mailing List <linux-s390@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>
References: <20181219191756.57973-1-mimu@linux.ibm.com>
 <20181219191756.57973-14-mimu@linux.ibm.com>
 <20190108135919.18048dd4@oc2783563651>
 <7e4a5077-00f0-3a0f-e21a-5bbc2fa14b70@linux.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Wed, 9 Jan 2019 13:14:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <7e4a5077-00f0-3a0f-e21a-5bbc2fa14b70@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19010912-0020-0000-0000-0000030380F0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010912-0021-0000-0000-000021549675
Message-Id: <01566362-d452-c04b-0509-cdcc758bc1e1@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-09_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901090102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/2019 16:21, Michael Mueller wrote:
> 
> 
> On 08.01.19 13:59, Halil Pasic wrote:
>> On Wed, 19 Dec 2018 20:17:54 +0100
>> Michael Mueller <mimu@linux.ibm.com> wrote:
>>
>>> This function processes the Gib Alert List (GAL). It is required
>>> to run when either a gib alert interruption has been received or
>>> a gisa that is in the alert list is cleared or dropped.
>>>
>>> The GAL is build up by millicode, when the respective ISC bit is
>>> set in the Interruption Alert Mask (IAM) and an interruption of
>>> that class is observed.
>>>
>>> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
>>> ---
>>>   arch/s390/kvm/interrupt.c | 140 
>>> ++++++++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 140 insertions(+)
>>>
>>> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
>>> index 48a93f5e5333..03e7ba4f215a 100644
>>> --- a/arch/s390/kvm/interrupt.c
>>> +++ b/arch/s390/kvm/interrupt.c
>>> @@ -2941,6 +2941,146 @@ int kvm_s390_get_irq_state(struct kvm_vcpu 
>>> *vcpu, __u8 __user *buf, int len)
>>>       return n;
>>>   }
>>> +static int __try_airqs_kick(struct kvm *kvm, u8 ipm)
>>> +{
>>> +    struct kvm_s390_float_interrupt *fi = &kvm->arch.float_int;
>>> +    struct kvm_vcpu *vcpu = NULL, *kick_vcpu[MAX_ISC + 1];
>>> +    int online_vcpus = atomic_read(&kvm->online_vcpus);
>>> +    u8 ioint_mask, isc_mask, kick_mask = 0x00;
>>> +    int vcpu_id, kicked = 0;
>>> +
>>> +    /* Loop over vcpus in WAIT state. */
>>> +    for (vcpu_id = find_first_bit(fi->idle_mask, online_vcpus);
>>> +         /* Until all pending ISCs have a vcpu open for airqs. */
>>> +         (~kick_mask & ipm) && vcpu_id < online_vcpus;
>>> +         vcpu_id = find_next_bit(fi->idle_mask, online_vcpus, 
>>> vcpu_id)) {
>>> +        vcpu = kvm_get_vcpu(kvm, vcpu_id);
>>> +        if (psw_ioint_disabled(vcpu))
>>> +            continue;
>>> +        ioint_mask = (u8)(vcpu->arch.sie_block->gcr[6] >> 24);
>>> +        for (isc_mask = 0x80; isc_mask; isc_mask >>= 1) {
>>> +            /* ISC pending in IPM ? */
>>> +            if (!(ipm & isc_mask))
>>> +                continue;
>>> +            /* vcpu for this ISC already found ? */
>>> +            if (kick_mask & isc_mask)
>>> +                continue;
>>> +            /* vcpu open for airq of this ISC ? */
>>> +            if (!(ioint_mask & isc_mask))
>>> +                continue;
>>> +            /* use this vcpu (for all ISCs in ioint_mask) */
>>> +            kick_mask |= ioint_mask;
>>> +            kick_vcpu[kicked++] = vcpu;
>>
>> Assuming that the vcpu can/will take all ISCs it's currently open for
>> does not seem right. We kind of rely on this assumption here, or?

why does it not seem right?

> 
> My latest version of this routine already follows a different strategy.
> It looks for a horizontal distribution of pending ISCs among idle vcpus.
> 

May be you should separate the GAL IRQ handling and the algorithm of the 
vCPU to kick in different patches to ease the review.


Regards,
Pierre

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

