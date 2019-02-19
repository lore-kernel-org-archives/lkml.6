Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D2DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 22:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAA422147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 22:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729810AbfBSWvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 17:51:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44156 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728001AbfBSWvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 17:51:07 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1JMhgv3141877
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 17:51:06 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qrqrj00kg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 17:51:06 -0500
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Tue, 19 Feb 2019 22:51:04 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 19 Feb 2019 22:51:00 -0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1JMou8i22151336
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Feb 2019 22:50:56 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB525AE05F;
        Tue, 19 Feb 2019 22:50:56 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75798AE05C;
        Tue, 19 Feb 2019 22:50:56 +0000 (GMT)
Received: from [9.60.75.235] (unknown [9.60.75.235])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 19 Feb 2019 22:50:56 +0000 (GMT)
Subject: Re: [PATCH v3 2/9] s390: ap: kvm: setting a hook for PQAP
 instructions
To:     pmorel@linux.ibm.com, Cornelia Huck <cohuck@redhat.com>
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
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Tue, 19 Feb 2019 17:50:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <74d812c6-bf83-0fb0-8fc3-af1341b0ae3c@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19021922-0052-0000-0000-0000038CFEF9
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010628; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01163498; UDB=6.00607513; IPR=6.00944081;
 MB=3.00025661; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-19 22:51:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021922-0053-0000-0000-00005FE75A8E
Message-Id: <342ffd56-b73a-b1f4-004d-de2c4aeef729@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-19_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=684 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902190155
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/19/19 2:50 PM, Pierre Morel wrote:
> On 18/02/2019 23:42, Cornelia Huck wrote:
>> On Mon, 18 Feb 2019 19:29:10 +0100
>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>
>>> On 15/02/2019 23:02, Tony Krowiak wrote:
>>>> On 2/14/19 8:51 AM, Pierre Morel wrote:
>>
>>>>> +/*
>>>>> + * handle_pqap: Handling pqap interception
>>>>> + * @vcpu: the vcpu having issue the pqap instruction
>>>>> + *
>>>>> + * This callback only handles PQAP/AQIC instruction and
>>>>> + * calls a dedicated callback for this instruction if
>>>>> + * a driver did register one in the CRYPTO satellite of the
>>>>> + * SIE block.
>>>>> + *
>>>>> + * Do not change the behavior if, return -EOPNOTSUPP if:
>>>>> + * - the hook is not used do not change the behavior.
>>>>> + * - AP instructions are not available or not available to the guest
>>>>> + * - the instruction is not PQAP with function code indicating
>>>>> + *   AQIC do not change the previous behavior.
>>>>> + *
>>>>> + * For PQAP/AQIC instruction, verify privilege and specifications
>>>>> + *
>>>>> + * return the value returned by the callback.
>>>>> + */
>>>>> +static int handle_pqap(struct kvm_vcpu *vcpu)
>>>>> +{
>>>>> +    uint8_t fc;
>>>>> +
>>>>> +    /* Verify that the hook callback is registered */
>>>>> +    if (!vcpu->kvm->arch.crypto.pqap_hook)
>>>>> +        return -EOPNOTSUPP;
>>>>> +    /* Verify that the AP instruction are available */
>>>>> +    if (!ap_instructions_available())
>>>>> +        return -EOPNOTSUPP;
>>>>> +    /* Verify that the guest is allowed to use AP instructions */
>>>>> +    if (!(vcpu->arch.sie_block->eca & ECA_APIE))
>>>>> +        return -EOPNOTSUPP;
>>>>> +    /* Verify that the function code is AQIC */
>>>>> +    fc = vcpu->run->s.regs.gprs[0] >> 24;
>>>>> +    if (fc != 0x03)
>>>>> +        return -EOPNOTSUPP;
>>>>
>>>> This does not belong here. Function code 3 is one of 7 function codes
>>>> that can be sent with the PQAP instruction. This belongs in the PQAP
>>>> hook code.
>>>
>>> On one hand, effectively I would prefer to put the code in the VFIO
>>> driver code.
>>> On the other hand, doing this would lead to export the code for
>>> test_kvm_facility() and kvm_s390_inject_program_int() from the 
>>> kvm-s390.h
>>>
>>> I choose not to export these functions from the KVM code.
>>>
>>> Would like opinion from KVM maintainers?
>>
>> Looking at this (and without access to the specification...), I think
>> the check for problem state makes sense in here (if this applies to all
>> PQAP functions equally, which seems likely). The check for the facility
>> makes more sense in the handler. You can probably still inject the
>> specification exception here if you use a clever return code.
>>
> 
> If there is no objection on exporting the KVM functions... I can do this.

I think I understand where you are coming from. In looking back at the
original patch, I see there are checks using the test_kvm_facility and
kvm_s390_inject_program_int functions placed after your check for
fc != 0x03. You clearly misunderstood what I was asking you to do.
I was suggesting that ONLY the check for 'fc != 0x03' be done in the
hook. I was NOT suggesting the instructions following the check for
fc != 0x03 be done in the hook, so there is no need to export any KVM
functions.


> 
>> Another option: Provide a way to register a callback per function code;
>> this allows you to still do the check here and extend it later for
>> other function codes (which will probably be indicated by another
>> facility).
> 
> I like this option even better.
> 
> Regards,
> Pierre
> 
> 

