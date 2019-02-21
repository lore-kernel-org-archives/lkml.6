Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CE6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02B552086C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbfBUMkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 07:40:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39774 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725845AbfBUMkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 07:40:41 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1LCda1r061663
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 07:40:41 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qsupvhapj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 07:40:40 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 21 Feb 2019 12:40:38 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 21 Feb 2019 12:40:36 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1LCeYnK30408786
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Feb 2019 12:40:34 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A30894C062;
        Thu, 21 Feb 2019 12:40:34 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F27EF4C04E;
        Thu, 21 Feb 2019 12:40:33 +0000 (GMT)
Received: from [9.152.224.140] (unknown [9.152.224.140])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 21 Feb 2019 12:40:33 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v3 2/9] s390: ap: kvm: setting a hook for PQAP
 instructions
To:     Tony Krowiak <akrowiak@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>
Cc:     borntraeger@de.ibm.com, alex.williamson@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com,
        david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
 <1550152269-6317-3-git-send-email-pmorel@linux.ibm.com>
 <4b21f059-1d37-f341-bac7-5b1fe0d06521@linux.ibm.com>
 <ee84fc90-e158-9c36-b56f-67fe7777f683@linux.ibm.com>
 <20190218234235.7d9f547c.cohuck@redhat.com>
 <74d812c6-bf83-0fb0-8fc3-af1341b0ae3c@linux.ibm.com>
 <e04f0c8b-2fd9-1846-334a-faa48e0e051e@linux.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Thu, 21 Feb 2019 13:40:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <e04f0c8b-2fd9-1846-334a-faa48e0e051e@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19022112-4275-0000-0000-000003123B14
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022112-4276-0000-0000-000038206EE6
Message-Id: <50339bc0-50da-1a38-53a4-cf173fc387ea@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-21_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=553 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902210094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/02/2019 23:36, Tony Krowiak wrote:
> On 2/19/19 2:50 PM, Pierre Morel wrote:
>> On 18/02/2019 23:42, Cornelia Huck wrote:
>>> On Mon, 18 Feb 2019 19:29:10 +0100
>>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>>
>>>> On 15/02/2019 23:02, Tony Krowiak wrote:
>>>>> On 2/14/19 8:51 AM, Pierre Morel wrote:
>>>
>>>>>> +/*
>>>>>> + * handle_pqap: Handling pqap interception
>>>>>> + * @vcpu: the vcpu having issue the pqap instruction
>>>>>> + *
>>>>>> + * This callback only handles PQAP/AQIC instruction and
>>>>>> + * calls a dedicated callback for this instruction if
>>>>>> + * a driver did register one in the CRYPTO satellite of the
>>>>>> + * SIE block.
>>>>>> + *
>>>>>> + * Do not change the behavior if, return -EOPNOTSUPP if:
>>>>>> + * - the hook is not used do not change the behavior.
>>>>>> + * - AP instructions are not available or not available to the guest
>>>>>> + * - the instruction is not PQAP with function code indicating
>>>>>> + *   AQIC do not change the previous behavior.
>>>>>> + *
>>>>>> + * For PQAP/AQIC instruction, verify privilege and specifications
>>>>>> + *
>>>>>> + * return the value returned by the callback.
>>>>>> + */
>>>>>> +static int handle_pqap(struct kvm_vcpu *vcpu)
>>>>>> +{
>>>>>> +    uint8_t fc;
>>>>>> +
>>>>>> +    /* Verify that the hook callback is registered */
>>>>>> +    if (!vcpu->kvm->arch.crypto.pqap_hook)
>>>>>> +        return -EOPNOTSUPP;
>>>>>> +    /* Verify that the AP instruction are available */
>>>>>> +    if (!ap_instructions_available())
>>>>>> +        return -EOPNOTSUPP;
>>>>>> +    /* Verify that the guest is allowed to use AP instructions */
>>>>>> +    if (!(vcpu->arch.sie_block->eca & ECA_APIE))
>>>>>> +        return -EOPNOTSUPP;
>>>>>> +    /* Verify that the function code is AQIC */
>>>>>> +    fc = vcpu->run->s.regs.gprs[0] >> 24;
>>>>>> +    if (fc != 0x03)
>>>>>> +        return -EOPNOTSUPP;
>>>>>
>>>>> This does not belong here. Function code 3 is one of 7 function codes
>>>>> that can be sent with the PQAP instruction. This belongs in the PQAP
>>>>> hook code.
>>>>
>>>> On one hand, effectively I would prefer to put the code in the VFIO
>>>> driver code.
>>>> On the other hand, doing this would lead to export the code for
>>>> test_kvm_facility() and kvm_s390_inject_program_int() from the 
>>>> kvm-s390.h
>>>>
>>>> I choose not to export these functions from the KVM code.
>>>>
>>>> Would like opinion from KVM maintainers?
>>>
>>> Looking at this (and without access to the specification...), I think
>>> the check for problem state makes sense in here (if this applies to all
>>> PQAP functions equally, which seems likely). The check for the facility
>>> makes more sense in the handler. You can probably still inject the
>>> specification exception here if you use a clever return code.
>>>
>>
>> If there is no objection on exporting the KVM functions... I can do this.
> 
> I do not understand why you would have to export KVM functions to place
> the check for FC 0x03 in the pqap hook? What am I missing here? Maybe
> you misunderstood my comment?

No I did not but in between I discovered an error in the handling of the 
interception of PQAP/AQIC.

QEMU and KVM can both accept PQAP/AQIC even if the vfio_ap driver is not 
loaded.
However now that the guest officially get the PQAP/AQIC instruction we 
need to handle the specification and operation exceptions inside KVM
_before_ testing and even calling the driver hook.

I will make the changes in the next iteration.

Regards,
Pierre



-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

